---
title: "New A/B Test? Call My Agent"
date: 2026-07-22
layout: post
---

![an image showing agents testing a system](https://rahuljha.github.io/assets/agentic_ab/agentic_ab_banner.png)



A/B testing is the standard way to establish whether a product change actually works: split users into two groups, show one the current experience and the other the proposed change, and compare some outcome metric between the two. This works well, but it is slow. You need a finished implementation, a live rollout, real users exposed to something unproven, and then a multi-week wait before the metric accrues. 

With the recent advances in LLM, a new research stream has started around whether this loop can be shortened by simulating the test first, using AI agents that stand in for real users and interact with the proposed change before it ever goes live. To be able to do this, the agent needs to be able to interact with whatever canvas is being tested, and should represent the user population faithfully. 

Here I cover the main concerns in the design of these agents and how recent papers have tackled it.

## Who's behind the agent?

Before an agent can act like a user, you have to decide where its persona actually comes from. There are a few ways to do this, and they trade off real-world grounding against how much real data you need to get there.

### Hand-written

The simplest option is to hand-build the persona: write out a plausible user (some demographics, a shopping style, a few stated preferences) and let the model play the role, without tying it to any specific real person's behavior. [UXAgent](https://arxiv.org/abs/2502.12561) does this by prompting an LLM to invent a plausible person, with no attempt to match anyone real, and [AgentA/B](https://arxiv.org/abs/2504.09723) runs its thousand-agent Amazon experiment on the same kind of generated, non-user-grounded personas. 

### Mapped to individual users

A more grounded option is to tie each agent to one specific real user. [SimGym](https://arxiv.org/abs/2605.19219) scores each agent's persona directly from a single real user's full purchase history, and their ablation results show that this matters: pull out that individual grounding and correlation with real A/B test outcomes drops from 0.55 to 0.02. [Customer-R1](https://arxiv.org/abs/2510.07230) reaches a similar place from a different direction, conditioning an RL-trained agent on one real person's demographics, personality, and stated preferences from an actual interview. Shuffling personas across people, breaking the individual pairing, collapses its accuracy.

### Mapped to user clusters

A third option sits in between: build the persona from a type or cluster shared across many real users, rather than any single identity. [SimPersona](https://arxiv.org/abs/2605.14205) does this by learning a discrete user-type code from real clickstreams across millions of users, then giving each agent a persona token for its user type rather than its specific identity. It's a composite, not an individual, but a composite built entirely from real behavior.

## How to train your agent

At its core, training the agent means training a model to predict what a real user would do next, given some context: a session so far, maybe a persona, the current page. You could try to skip training entirely and just prompt an off-the-shelf model to guess. Unsurprisingly, this doesn't hold up well: [Customer-R1](https://arxiv.org/abs/2510.07230) reports 7.3% next-action accuracy zero-shot, and training the same base model lifts that to 35–40%.

### Raw trajectories

The simplest regime trains directly on logged action trajectories, with no conditioning at all: real sessions in, next action out. [Beyond Believability](https://arxiv.org/abs/2503.20749) fine-tunes an open model this way, on real e-commerce action traces, and shows it beats prompting a much larger, untrained model by a wide margin. There's nothing else going into the model besides the trajectory itself: the current page and the session's own action history, with no persona layered on top. 

### Conditioned trajectories

A step up conditions that same next-action objective on some additional signal about who's acting. [Customer-R1](https://arxiv.org/abs/2510.07230) trains via SFT followed by RL, with the model's input augmented by a real person's demographics, personality, and stated preferences. The conditioning helps: at test time, shuffling that context across users (same trajectories, wrong person's information attached) collapses session-outcome accuracy from 79.45 to 48.41. Conditioning the training signal on the right extra context measurably changes what the model learns to predict, not just how the output is dressed up.

### Generated and filtered trajectories

[SimPersona](https://arxiv.org/abs/2605.14205) takes a more involved approach to building the training set itself, rather than to the model or its inputs. It first has an LLM rewrite each real user's raw clickstream into a short, ordered natural-language goal: search this, view that, add to cart, abandon at checkout, preserving the order and identity of what actually happened. A separate agent then tries to carry out that goal on the live storefront from scratch, conditioned on the user's persona signal and a running memory of its own progress, navigating freely rather than being pinned to the original clicks, and emitting a structured action plus a reasoning trace at every step. Not every attempt actually finishes the goal, so a judge model checks each resulting trajectory against the original intent and throws out the ones that fail. Only the trajectories that survive this replicate-then-filter process become training data. 

Why does SimPersona take such a complex approach? It gives you something that real users don't: the explanation for why an action was taken. 

## Everything has a reason

Predicting the action alone tells you what a simulated user did. It doesn't tell you why, but that why is useful. A next-action model that says a user would add an item to cart is a data point; a model that also says it did so because the price dropped below a threshold it cares about is something a product team can actually act on. With action prediction you just get metrics, with action prediction with explanations, you get both metrics and insights.

Adding explanations also turns out to help action prediction itself. [Beyond Believability](https://arxiv.org/abs/2503.20749) trains models to produce a reasoning trace alongside the predicted action, and finds this beats training on the action label alone across every model tested: a 7B model trained with reasoning reaches an outcome F1 of 33.9, against 26.9 for the same model trained on actions only. [Customer-R1](https://arxiv.org/abs/2510.07230) finds the same thing from the other direction: strip the rationale out of its training regime, and accuracy drops no matter which other training choices are held fixed. Asking the model to explain itself doesn't just make the output more useful. It makes the model better at the underlying task too.

## Closing thoughts

Agentic A/B testing is still a young research direction, but recent papers already show it can replicate some aspects of real experiments. [SimGym](https://arxiv.org/abs/2605.19219) validated its simulated results against 50 completed real-world A/B tests and got the direction of the outcome right about 77% of the time, with a real correlation to the size of the effect. [AgentA/B](https://arxiv.org/abs/2504.09723) ran a thousand agents through a live Amazon filter-panel test and matched the direction of a parallel human experiment, even though its agents behaved somewhat differently from real users along the way. 

Despite the progress, I don't see agentic A/B testing completely replacing real A/B tests anytime soon. But I do see them working in conjunction. You could run proposed changes past a population of agents first, and use the result to prune which ideas are actually worth building and testing on real users, instead of putting every candidate through a multi-week rollout. It can also run alongside a live test, adding a layer of insight standard A/B testing doesn't give you on its own: a reason for the effect, not just the size of it. 
