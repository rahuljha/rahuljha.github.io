# [Work-in-progress article]

![opening](/assets/LM_blog_opening.png)

Language modelling used to be a sub-area within NLP, but over the past decade, bit-by-bit language models have taken over NLP. In this post, I want to start from the basics of what langauge modeling is and how it took over NLP.

# What is a language model?

At its most fundamental, a language model is used to determine the probability of a word sequence $[w_1, w_2, ... w_n]$. The probablity depends on the usage for the language in question. For example, the probability of a common word sequence in English like $[my, name, is]$ should be much higher than the probability of a less common word sequence like $[is,cheese, name]$ in a reasonable language model. [^1].

If we use $P(w_1...w_n)$ to denote this probability, it can be broken down like this:

$$ P(w_1...w_i) = P(w_1) \times P(w_2|w_1) \times ... \times P(w_i | w_1 ... w_{i-1})$$

Since $P(w_i|w_1...w_{i-1})$ can get difficult to compute for long sequences, old-style language modeling often made the simplifying assumption that the probability of a word dpeends only on the the previous few words. So, for example, a trigram model would assume that the prbability of a word depends on only the previous few words.

Language modeling was used as a subtask for several NLP tasks such as speech recognition and machine translation. Many techniques were developed to learn better language models, such as smoothing and clustering. [(Goodman, 2008)](https://arxiv.org/pdf/cs/0108005.pdf) provides a great overview of the work done in these early language models.

However, circa 2010, language models started to gain a lot more importance in NLP. We'll cover this next.

[^1]: When I used this example in an internal talk,one of my colleagues felt compelled to make up me this passage: Is cheese name an important factor? Typically, the flavor profile is given more weight when deciding among several cheeses, but it can also be important to select cheese whose names are easily pronounceable – especially if you're planning to use your cheese board as "smalltalk fodder"