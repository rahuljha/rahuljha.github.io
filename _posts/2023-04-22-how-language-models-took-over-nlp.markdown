---
title: "How Language Models Took Over NLP"
date: 2023-04-22
layout: post
---

# [Work-in-progress article]

![A joke showing a language model trying to predict what it can take over](/assets/lm_history/LM_blog_opening.png)

Language modelling used to be a sub-area within NLP, but over the past decade, bit-by-bit language models seem to be taking over all of NLP. The GPT* craze is the latest iteration in this take-over, but it may not stop there. In this article, I want to trace some of the changes I've witnessed as LM's importance grew in NLP. Let's start with the basics.

# My friends call me smooth: What is a language model?

At its most fundamental, a language model is used to determine the probability of a word sequence $[w_1, w_2, ... w_n]$. The probablity depends on the usage for the language in question. For example, the probability of a common word sequence in English like $[my, name, is]$ should be much higher than the probability of a less common word sequence like $[is,cheese, name]$ in a reasonable language model. [^1].

If we use $P(w_1...w_n)$ to denote this probability, it can be broken down like this:

$$ P(w_1...w_i) = P(w_1) \times P(w_2 \mid w_1) \times ... \times P(w_i \mid w_1 ... w_{i-1})$$

Since $P(w_i \mid w_1...w_{i-1})$ can get difficult to compute for long sequences, old-style language modeling often made the simplifying assumption that the probability of a word dpeends only on the the previous few words. So, for example, a trigram model would assume that the prbability of a word depends on only the previous few words.

Language modeling was used as a subtask for several NLP tasks such as speech recognition and machine translation. Many techniques were developed to learn better language models, such as smoothing and clustering. [(Goodman, 2008)](https://arxiv.org/pdf/cs/0108005.pdf) provides a great overview of the work done in these early language models.

All these approaches depended on using words as discrete tokens. One problem with this approach is that you can't generalize to a new sequence of words even if you have seen a sequence of similar words. For example, if you have seen the sequence $[Tomorrow, is, Monday]$ in your data, you should be able to assign a higher probability to $[Tomorrow, is, Tuesday]$, since $Monday$ and $Tuesday$ are similar words. But a purely token based approach like we discussed above can't do that.

Trying to solve this approach in a systematic manner led to the first big step in making language modeling crucial for all NLP tasks. 


# Let's start from scratch : language modeling for learning shared representations

 * NLP from scratch [(Collobert et al., 2011)](https://www.jmlr.org/papers/volume12/collobert11a/collobert11a.pdf)

# Let me look around : learning contextual representations 

 * Elmo
 * GPT
 * BERT

# Can I do more? : Early examples of zero-shot and few-shot learning

 * GPT 2[(Radford et al., 2019)](https://d4mucfpksywv.cloudfront.net/better-language-models/language-models.pdf)
 * T5 [(Raffel et al. 2020)](https://arxiv.org/pdf/1910.10683.pdf)

  |![GPT2](/assets/lm_history/GPT2.png)|
 |:--:|
 |GPT2|

 
 |![T5](/assets/lm_history/T5.png)|
 |:--:|
 |T5|

 # Actually, I can do everything : large language models take over NLP

 * GPT3 [(Brown et al. 2020)](https://arxiv.org/pdf/2005.14165.pdf)
 * InstructGPT


  |![GPT3](/assets/lm_history/GPT3.png)|
 |:--:|
 |GPT3|





# Should I stop here? : Thoughts about the future


# Footnotes
[^1]: When I used this example in an internal talk,one of my colleagues felt compelled to make up me this passage: Is cheese name an important factor? Typically, the flavor profile is given more weight when deciding among several cheeses, but it can also be important to select cheese whose names are easily pronounceable – especially if you're planning to use your cheese board as "smalltalk fodder"