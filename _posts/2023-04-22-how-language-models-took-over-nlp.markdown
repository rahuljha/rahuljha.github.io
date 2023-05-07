---
title: "[WIP] How Language Models Took Over NLP"
date: 2023-04-22
layout: post
---

# [Work-in-progress article]

![A joke showing a language model trying to predict what it can take over](/assets/lm_history/LM_blog_opening.png)

Language modelling used to be a sub-area within NLP [^1], but over the past decade, like the Roman Empire expanding its borders, language models haven taken over NLP and judging by the flurry of recent articles, seem poised to take over a big part of AI. In this article, I want to trace the evolution of language models from their humble beginnings and how they became the dominant paradigm in NLP.

# What is a language model?

[comment]: <> (My friends call me smooth)

At its most fundamental, a language model is used to determine the probability of a word sequence $[w_1, w_2, ... w_n]$. The probablity depends on the usage for the language in question. For example, the probability of a common word sequence in English like $[my, name, is]$ should be much higher than the probability of a less common word sequence like $[is,cheese, name]$ in a reasonable language model. [^2].

If we use $P(w_1...w_n)$ to denote this probability, it can be broken down like this:

$$ P(w_1...w_i) = P(w_1) \times P(w_2 \mid w_1) \times ... \times P(w_i \mid w_1 ... w_{i-1})$$

Here $P(w_i \mid w_1...w_{i-1})$ is the conditional probability of observing $w_i$ given that you observed word sequence $[w_1...w_{i-1}]$ before. Since this probability can get difficult to compute for long sequences, old-style language modeling often made the simplifying assumption that the probability of a word dpeends only on the the previous few words. So, for example, a trigram model would assume that the probability of a word depends on only the previous two words, so you just need to estimate $P(w_i \mid w_{i-2}w_{i-1})$. 

These probabilities can be estimated simply by counting the occurences of word sequences in your data. For example, if you wanted to estimate the probability of $P(my, name, is \mid my, name)$, you count the number of times you saw the words [$my, name, is$] (say 30,000 times) and the number of times you saw the words [$my, name$] (say 40,000). Then your probability would be:

$$ P(my, name, is \mid my, name) = \frac{count([my, name, is])}{count([my, name])} = \frac{30000}{40000} = 0.75$$

This can be noisy because of the limitations of the dataset, for example, some sequences may never occur. Many techniques were developed to learn better language models, such as smoothing and clustering. [(Goodman, 2008)](https://arxiv.org/pdf/cs/0108005.pdf) provides a great overview of the work done in these era of language modeling. These early language models were a component for several NLP tasks such as speech recognition and machine translation. 

All these approaches depended on using words as discrete tokens. One problem with this approach is that you can't generalize to a new sequence of words even if you have seen a sequence of similar words. For example, if you have seen the sequence $[Tomorrow, is, Monday]$ in your data, you should be able to assign a higher probability to $[Tomorrow, is, Tuesday]$, since $Monday$ and $Tuesday$ are similar words. But a purely token based approach like we discussed above can't do that. Trying to solve this problem in a systematic manner led to the first big step in making language modeling a cornerstone for Many NLP tasks. 


# Language modeling for learning shared representations

 * NLP from scratch [(Collobert et al., 2011)](https://www.jmlr.org/papers/volume12/collobert11a/collobert11a.pdf)
 * Predict don't count paper [(Baroni et al., 2014)](https://aclanthology.org/P14-1023.pdf)

# Learning contextual representations 

 * Elmo
 * GPT
 * BERT

# Early evidence of zero-shot and few-shot learning

 * GPT 2[(Radford et al., 2019)](https://d4mucfpksywv.cloudfront.net/better-language-models/language-models.pdf)
 * T5 [(Raffel et al. 2020)](https://arxiv.org/pdf/1910.10683.pdf)

  |![GPT2](/assets/lm_history/GPT2.png)|
 |:--:|
 |GPT2|

 
 |![T5](/assets/lm_history/T5.png)|
 |:--:|
 |T5|

 # Large language models take over NLP

 * GPT3 [(Brown et al. 2020)](https://arxiv.org/pdf/2005.14165.pdf)
 * InstructGPT
 * GPT4


  |![GPT3](/assets/lm_history/GPT3.png)|
 |:--:|
 |GPT3|

# What's next?

*


# Footnotes
[^1]: NLP or Natural Language Processing is the sub-field of AI devoted to  building and understanding systems involving human language.

[^2]: When I used this example in an internal talk,one of my colleagues felt compelled to make up me this passage: Is cheese name an important factor? Typically, the flavor profile is given more weight when deciding among several cheeses, but it can also be important to select cheese whose names are easily pronounceable – especially if you're planning to use your cheese board as "smalltalk fodder"