
EMNLP 2020 was my first virtual conference. I started the week with doubts about how effective the conference format would be, but am finishing the week thoroughly satisfied. Below, I share some notes from the conference. I start with some general notes about the virtual conference experience, followed by a brief summary of some papers that caught my attention, followed by recaps of the invited talks/panels that I had the time to attend.

#	Virtual Conference Experience
Here were the main ways in which you could choose to spend time at the conference:
*	10 min recorded talks for all conference papers, workshop papers and tutorials, which you can watch anytime
*	1 hour zoom sessions for different tracks (e.g. summarization, question answering etc.), which mimic oral sessions
*	a gather town space for meeting up with people and poster sessions
*	live streams for keynotes

Given all these options, I found it easy to organize my time in a flexible way to get the most out of the conference. I reviewed the zoom sessions for the tracks I was interested in, looked at the pre-recorded talks (at 2x speed, w00t!) and attended the zoom sessions that had a good density of papers I found relevant to me.
Apart from the zoom sessions and the scheduled keynotes, I split the rest of the time between watching pre-recorded talks and meeting people in the gather space. The gather space worked really well, even better than a physical conference lobby in some cases, since you could quickly look at who was around.

#	Some Papers
##	Multi-View Conversation Summarization
(Chen and Yang, 2020) propose an interesting method for conversation summarization. The main thesis is that we can build better summaries by looking at the structure of the conversation from different views. They first extract two views from the conversation: a topic view and a stage view. For topic view, the conversation is segmented into topic segments using C99 with Sentence-BERT for sentence representations. The stage view is modeled by an HMM with a fixed set of hidden states. A good way to think about these is that different conversations will have different topics, but the same stages. Apart from these two, there is also the global view that creates one block for the entire conversation, and a discrete view that puts each utterance in a separate block.
The model itself is pretty intuitive: given a view, they obtain a representation for each block in the view by passing the tokens through BART and using the representation of the first pseudo-token as the block’s representation. To get the representation for the view itself they pass each block through LSTM layers and use the last hidden state to represent the current view. The transformer based decoder attends to all the views when decoding the next token. Their evaluations show that the multi-view setup helps. For me, the paper opened up a different way of thinking about conversational data: we don’t have to restrict ourselves to a single view like topics, we can look at it from multiple views.
In addition to the topic view and stage view (which reminds me of Simone Teufel’s Argumentative Zoning) we can also think in terms of views based on sentiment, speaker intent, entities etc. These different views also relate to attentional and intentional structure of discourse proposed in (Grosz and Sidner, 1986).

##	Few-shot summarization
(Brazinskas et al., 2020) present an interesting approach for review summarization that depends on aˇ large amount of unlabeled data and a very small amount of labeled data (about a 100). The motivation is that unsupervised multi-document summarization models such as COPYCAT and MEANSUM are unable to learn key characteristics of output summaries since they are never exposed to actual summaries. For example, systems trained on subjectively written reviews tend to generate summaries in the same writing style.

The authors observe that reviews in a large collection vary a lot: e.g. in style, level of detail, divergence from other reviews and sentiment. These individual review characteristics and their relations to other reviews are called properties. Only reviews with a small set of property values are suitable for summarization, e.g. the summary should be close to the content of reviews, avoid using first-person pronouns and agree with the reviews in sentiment.

During the unsupervised learning phase, the authors use an oracle to extract the properties of the target review and condition the decoder on these properties. This helps the decoder learn to produce summary based on properties. They look at three kinds of properties: content coverage, writing style, and length deviations. Once this model is trained, technically we could control the kind of summaries produced by setting the appropriate property values. Except we don’t know what they are! This is where the fewshot learning part comes in. They learn a plug-in network that is initialized to predict properties on the unsupervised dataset, but then fine-tuned to predict properties for the small set of labeled summaries. Their results show that the resulting model, called FEWSUM performs much better compared to other unsupervised methods.

This is a great methodology when you can obtain lots of surrogate summaries easily. Moving on, EMNLP added a few papers questioning the evaluation metrics and data for summarization. Here I describe two of the them.

##	What have we achieved in text summarization?
To answer the rather dramatic question, (Huang et al., 2020) designed a new multi-dimensional human evaluation called PolyTope (similar in spirit to CHECKLIST (Ribeiro et al., 2020)). They evaluated 4 extractive and 6 abstractive summarization models on CNN/DailyMail using PolyTope.

Some interesting takeaways: 1) Lead-3 baseline is still strong, it was the 4th among all compared models 2) Extractive and abstractive systems are similar in terms of fluency, which is a testament to recent progress in language generation 3) BART overwhelmingly outperforms other models and gets the 1st rank, but the next three places are taken up by extractive models. Extractive methods win by having better factuality and faithfulness, while their main problem is having extraneous information. 4) Hybrid systems such as Bottom-Up rank low, also due to factuality and faithfulness issues.

Factual consistency and faithfulness is a big problem for productizing abstractive summarization systems, we’ve been investigating it in our group as well.

## Re-evaluating summarization evaluation

(Bhandari et al., 2020) presented their work on a meta-evaluation of summarization evaluation metrics. The motivation is familiar: the most recent meta-evaluation results for metrics like ROUGE are now close to a decade old, and it’s not clear if they hold for modern systems. They use LitePyramid (Shapira et al., 2019) to get ground-truth annotations.

Some takeaways: 1) MoverScore and JS-2 are significantly better than other metrics, though ROUGE2 does well on CNN/DM 2) Metrics cannot reliably quantify improvement of one system over other, specially for the top few systems, but JS-2 and ROUGE-2 are reliable over TAC2009 and CNN/DM datasets. 3) In general, different metrics are well-suited to different datasets, and should be emperically tested for efficacy on specific datasets before applying. For example, BERTScore, WMS, R-1 and RL have negative correlations on TAC-2009 but perform moderately well on other datasets including CNN/DM.

I’ll just mention (Bommasani and Cardie, 2020) as well, who also recommend caution in picking summarization datasets since they may contain surprising properties not aligned with the problem area they are used for. Let’s now look at a generation paper.

##	Sparse text generation
(Martins et al., 2020) introduce an interesting technique for training text generation systems. This paper is a bit more mathematical compared to the other papers I’ve described. Here’s the problem it targts: when decoding at inference time, deterministic search for the most probable sentence (greedy, beam search) leads to dull and repetitive text, while sampling from the full distribution generates many implausible sentences from the tail of the distribution. Top-k and top-p sampling introduce sparsity at inference time, but the model doesn’t see this sparsity at train time.

The authors propose replacing the softmax with entmax, which generates sparse probability distributions. Like softmax, entmax has an associated loss, which means the sparsity can be learnt during training. In addition to the loss, the authors also present three new evaluation metrics for text generation better suited when using sparse distributions (such as the proposed method but also top-k and top-p). Their experiments show that the new sampling procedure generates more diverse text and fewer repetitions compared to top-k and top-p sampling procedures previously proposed.

# Other Talks
##	Tutorials
There were a number of tutorials at EMNLP, I looked at two of them.

The high-performance NLP tutorial was amazing. It covered a number of topics with up-to-the-minute references, including knowledge distillation, quantization, pruning, efficient attention mechanisms, parallelization and a number of benchmarks and case studies. You can find the slides online at [this link](http://gabrielilharco.com/publications/EMNLP_2020_Tutorial__High_Performance_NLP.pdf).

The text generation tutorial was also nice, but given the time, I only got a chance to skim through it. It contained a lot of useful information about modern methods for text generation, including decoding and learning strategies, evaluation, and challenges in productionizing generation models. Again, slides are [available online](https://nlg-world.github.io/).
##	Keynotes
Clair Cardie gave a great keynote talk describing information extraction through the years. She described how the task started in early 1990’s and then was re-defined as a study of smaller more constrained tasks such as named entity recognition, extraction pattern acquisition, coreference resolution, relation extraction, entity linking etc.

She also described the evolution in the modeling approaches. Initially we had ML-based pipelines, where the output of each stage is passed as an input to the next stage. This is easy to setup but has problems where errors in upstream components add up. These methods led to joint inference methods (such as Integer Linear Programming or ILP based methods), where we still use separate models but keep the top-k results and do joint optimization at inference time. This allows modeling of global constraints on output structure as well. This led to joint learning methods where the different models are trained jointly, but still are feature-based. Finally, we now have end-to-end neural methods. The transition from pipeline based ML to joint inferencing is very relevant to production systems, where joint inferencing provides a cheaper way of having a decomposable system that still has some check against propagating errors and allows for global constraints.

Claire then described a number of recent papers and concluded that information extraction has been successful in instilling a culture of rigorous evaluation in the field and has helped to advance NLP as a whole with new sub-areas of research and practice.

Rich Caruana gave a great keynote about glassbox ML methods and predicted that they are going to come to the forefront in coming years, since data scientists now want to use ML methods that are interpretable. He argued that the new explanation based methods are competitive in terms of accuracy while being intelligible, and described the generalized additive models with pair-wise interactions and a number of applications. All of this applies to tabular data (think of features, not dense embeddings), but Rich mentioned their new work on neural additive models, which is a collaboration between his group at Microsoft Research, Hinton’s group and Google. THat sounds great and I see there is a paper on Arxiv but haven’t had a chance to look at it yet.

Janet Pierrehumbert had a keynote about linguistic behaviour and testing of real-world NLP systems. This was the talk that went furthest away from what I know, but I’ll try to capture it at a high level. We evaluate our NLP systems on held-out test data, but a lot of examples our deployed systems will see are examples nobody saw before. This is because predicting linguistic behaviour of humans is like predicting the weather: human language involves ”The infinite use of finite means” (von Humboldt). The talk focused on current NLP methodology vs behavioural mechanisms.

Cloze testing (as operationalized in BERT) is strongly grounded in behavioural studies, but overall error rates don’t separate errors arising from different lingustic mechanisms. Topic models (such as LDA) are also well-grounded, but treatment of word-burstiness is much better than the treatment of domain restrictions. The big point is: context is always important, no linguistic behaviour is out of context, and so we need better testing regimes, like Cloze testing using full paragraphs. Benchmarking datasets based on human judgments collected out of context are a problem. E.g. if someone asked you how similar is cat to tiger, you’ll probably ask: as pets? or w.r.t to physical traits? People will be influenced by all available context: order of items, statistical profile of items, instructions etc. We should also keep our eye-out for human variability: for some linguistic behaviors, few people do the average thing.

##	Panels
The industry panel had a lot of great discussion, I’ll mention some highlights. Everyone agreed that co-organizing challenges are a great way for collaboration between industry and academia, but it might be good to have a consortium for releasing realistic data where both industry and academia take responsibility for privacy issues. For new PhD students going into industry, there was a lot of great advise around aligning your goals with the company goals in the short and long term and importance of focusing on a few key areas. Daniel Marcu also made a great point: when you’re finishing your PhD you get a lot of advise that you can’t really parse, because you lack the perspective, so if nothing makes sense, just focus on doing outstanding work and things will fall in place.

Finally, the ethics panel had a lot of debate about the right way of incorporating ethical considerations into our work. Some concerns were that academics are not trained to understand the long-term impact of their work and they can’t be expected to take responsibility of every possible application that their work is used for. Also, cultures have different ideas about what is ethical, and you don’t want to restrict research independence. The counterpoint was that the ACL community is trying to involve researchers from different communities, and the work is right now focused on guidelines and self-reporting and not any specific restrictions. This is going to be a very important area for the community moving forward, and it was good to see an open discussion with varying opinions.

# Final thoughts

I had a wonderful time at EMNLP 2020 and learnt a lot. Thanks to the organizers for creating such a great event!

# Bibliography

Manik Bhandari, Pranav Narayan Gour, Atabak Ashfaq, Pengfei Liu, and Graham Neubig. 2020. Re-evaluating evaluation in text summarization. In Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing (EMNLP), pages 9347–9359, Online, November. Association for Computational Linguistics.

Rishi Bommasani and Claire Cardie. 2020. Intrinsic evaluation of summarization datasets. In Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing (EMNLP), pages 8075–8096, Online, November. Association for Computational Linguistics.

Arthur Brazinskas, Mirella Lapata, and Ivan Titov.ˇ 2020. Few-shot learning for opinion summarization. In Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing (EMNLP), pages 4119–4135, Online, November. Association for Computational Linguistics.

Jiaao Chen and Diyi Yang. 2020. Multi-view sequence-to-sequence models with conversational structure for abstractive dialogue summarization. In Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing (EMNLP), pages 4106–4118, Online, November. Association for Computational Linguistics.

Barbara J. Grosz and Candace L. Sidner. 1986. Attention, intentions, and the structure of discourse. Computational Linguistics, 12(3):175–204.

Dandan Huang, Leyang Cui, Sen Yang, Guangsheng Bao, Kun Wang, Jun Xie, and Yue Zhang. 2020. What have we achieved on text summarization? In Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing (EMNLP), pages 446–469, Online, November. Association for Computational
Linguistics.

Pedro Henrique Martins, Zita Marinho, and Andre F. T. Martins. 2020. Sparse text generation. In´ Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing (EMNLP), pages 4252–4273, Online, November. Association for Computational Linguistics.

Marco Tulio Ribeiro, Tongshuang Wu, Carlos Guestrin, and Sameer Singh. 2020. Beyond accuracy: Behavioral testing of NLP models with CheckList. In Proceedings of the 58th Annual Meeting of the Association for Computational Linguistics, pages 4902–4912, Online, July. Association for Computational Linguistics.
