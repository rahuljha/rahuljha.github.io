
# Background

This article aims to provide an overview of the summarization research in 2019. The NLP community has done a great job of organizing publications across venues in a common repository, [the ACL Anthology](https://www.aclweb.org/anthology/). For my analysis, I pulled out the consolidated <span class="SpellE">bibtex</span> files for ACL, NAACL and EMNLP conferences from 2019\. These are the top-tier NLP conferences, as confirmed by a [quick <span class="SpellE">lookup</span> on Google scholar.](https://scholar.google.com/citations?view_op=top_venues&hl=en&vq=eng_computationallinguistics)

I then used the python [<span class="SpellE">bibtexparser</span>](https://bibtexparser.readthedocs.io/en/master/bibtexparser.html) library to parse the bib files and used some simple keyword matching to get to the summarization papers. This returned 58 papers, which I then skimmed over and did a hybrid top-down and bottom-up clustering to organize them into a loose topical hierarchy. Let’s dive into the results.

# Focus of Summarization Community

How big is the summarization community compared to the rest of NLP? The table below show that 2-4% of the papers at the top 3 NLP venues were on summarization. These numbers are similar to 2018 numbers and are also similar to other areas such as question answering and sentiment analysis.

|       | # All papers | # Summarization papers | % Summarization |
|-------|--------------|------------------------|-----------------|
| EMNLP | 681          | 23                     | 3%              |
| NAACL | 423          | 8                      | 2%              |
| ACL   | 660          | 27                     | 4%              |
| Total | 1764         | 58                     | 3%              |

The figure below shows the distribution of summarization papers across some high-level themes. 40 papers, 69% of the total, were focused on introducing new techniques for summarization. The next biggest focus area was papers introducing new datasets and new tasks (8 papers). There were a number of analysis papers as well (6 papers), many offering critical evaluation of current summarization datasets and evaluation metrics. Finally, there were 3 papers introducing new evaluation techniques (5%) and one theory paper.

![high-level distribution of papers](https://rahuljha.github.io/assets/PapersPieChart.png)

Let’s now look into the details of each of those clusters, starting from the biggest one: Techniques.

# New Techniques

There was a lot of diversity in summarization techniques explored by the research community in 2019, but I see some clear themes. In the text below, I’ve skipped the year from the citations of the 2019 papers and have included a link to the paper PDFs in ACL Anthology.

**<u>Reinforcement Learning Rewards</u>**

There were four papers focusing on reinforcement learning (RL) based summarization methods, all of them focusing on designing better rewards. Previous RL systems have used ROUGE as the reward for their RL systems, but new works criticize ROUGE as a reward and propose new reward metrics. For example, [Bohm et al.](https://www.aclweb.org/anthology/D19-1307.pdf) learned a reward function from human rating on 2500 summaries and use it for training the RL systems. [<span class="SpellE">Scialom</span> et al.](https://www.aclweb.org/anthology/D19-1320.pdf) and [<span class="SpellE">Arumae</span> & Liu](https://www.aclweb.org/anthology/N19-1264.pdf) proposed question answering based reward metrics that work better than ROUGE. [Li et al.](https://www.aclweb.org/anthology/D19-1623.pdf) propose a BERT based similarity score for rewards instead of ROUGE that works on n-gram overlap (this move towards distributional similarity from n-gram overlap appears in the evaluation papers as well).

**<u>Transformer Based Approaches</u>**

Not surprisingly, a number of BERT and other transformer based approaches have appeared. [Zhang et al.](https://www.aclweb.org/anthology/P19-1499.pdf) introduce HIBERT, a technique that extends the original BERT objective by predicting masked sentences instead of masked words. [Liu & <span class="SpellE">Lapata</span>](https://www.aclweb.org/anthology/D19-1387.pdf) introduce <span class="SpellE">BERTSum</span>, a simple but effective technique that runs inference on all sentences of a document together using a joint transformer architecture. 
Another interesting paper was [Liu & <span class="SpellE">Lapata</span>](https://www.aclweb.org/anthology/P19-1500.pdf), which used hierarchical transformers for multi-document summarization on the <span class="SpellE">WikiSum</span> dataset.

**<u>Using Latent Discourse Structure</u>**

In this section, I am grouping several papers that try to use latent discourse structure of input text.

_Templates_: In old-school summarization, template based generation was a popular technique. There seems to be a new interest in learning templates automatically from data and using them to guide summaries. [Gao et al.](https://www.aclweb.org/anthology/D19-1388.pdf) use labeled document-summary pairs to obtain summary patterns and prototype facts, which are then used to guide the generated summary. [Wang et al.](https://www.aclweb.org/anthology/P19-1207.pdf) also propose a method to extract template summaries from training data that are then used as an additional input for the summarizer.

_Topical structure_: A different direction is to uncover the latent topical structure of the input documents and use it to guide summaries. [Zheng et al.](https://www.aclweb.org/anthology/D19-1311.pdf) present an RNN based model that learns subtopics and uses them to build an extractive summary for news articles. [Perez-<span class="SpellE">Beltrachini</span> et al.](https://www.aclweb.org/anthology/P19-1504.pdf) extract LDA topics and train their document-level decoder to predict sentence topics as an auxiliary task. This is a direction I find really promising. Back in the day, a number of good summarization models were based on uncovering topical structure, e.g. [<span class="SpellE">Barzilay</span> & Lee 2004](https://www.aclweb.org/anthology/N04-1015.pdf) and [<span class="SpellE">Haghighi</span> & Vanderwende 2009](https://www.aclweb.org/anthology/N09-1041.pdf). I explored this area during my PhD as well ([Jha et al. 2015](http://www-personal.umich.edu/~rahuljha/pdf/surveyor_aaai_15.pdf)).

_Entity distribution_: Modeling distribution of entities is a great way to capture the discourse structure of text. [Sharma et al.](https://www.aclweb.org/anthology/D19-1323.pdf) use an entity-driven hybrid summarization model that first uses an entity-aware content selection module to select sentences, followed by an abstractive component. Again, this work renews an older thread of research around modeling entities in discourse, e.g. [<span class="SpellE">Barzilay</span> & Lapata 2008](https://people.csail.mit.edu/regina/my_papers/coherence.pdf).

_Discourse parsing_: This direction is not as popular now as it used to be, but [Liu & <span class="SpellE">Lapata</span>](https://www.aclweb.org/anthology/N19-1173.pdf) are trying to bring it back in fashion by inducing multi-root dependency trees relating sentences to each other and using them for summarization. These dependency trees are a loose version of the rigid RST based discourse trees people have tried before (e.g. [Marcu99](http://courses.ischool.berkeley.edu/i256/f06/papers/marcu99.pdf)).

**<u>Unsupervised Summarization</u>**

Last year also saw a number of new unsupervised techniques, I’ll mention two. [Zheng & <span class="SpellE">Lapata</span>](https://www.aclweb.org/anthology/P19-1628.pdf) revisit network centrality for summarization by using BERT based representations for capturing similarities and using directed graphs based on document position. Network based methods are one of the all-time most successful methods for summarization (e.g. [Erkan & <span style="mso-bookmark:
_GoBack"></span><span class="SpellE">Radev’s</span> <span class="SpellE">Lexrank</span>](https://arxiv.org/abs/1109.2128)<a name="_GoBack"></a> has more than 2000 citations). [West & Choi](https://www.aclweb.org/anthology/D19-1389.pdf) present an interesting technique called <span class="SpellE">BottleSum</span> that tries to summarize a sentence by learning to keep only the information that is needed to predict the next sentence.

**<u>Tweaking previous methods</u>**

A number of papers tried to improve previous architectures by tweaking attention in various ways: [You et al.](https://www.aclweb.org/anthology/P19-1205.pdf) tried a new focus-attention mechanism, [<span class="SpellE">Gui</span> et al.](https://www.aclweb.org/anthology/D19-1117.pdf) tried an attention refinement unit paired with local variance loss and [<span class="SpellE">Duan</span> et al.](https://www.aclweb.org/anthology/D19-1301.pdf) tried contrastive attention. Two papers tried to improve Pointer-Generator networks: [Shen et al.](https://www.aclweb.org/anthology/D19-1390.pdf) allow their pointers to edit pointed tokens and [<span class="SpellE">Wenbo</span> et al.](https://www.aclweb.org/anthology/D19-1304.pdf) add a concept pointer to incorporate external knowledge.

# Analysis Papers

[<span class="SpellE">Kryscinski</span> et al.](https://www.aclweb.org/anthology/D19-1051.pdf) did a critical evaluation of neural text summarization and highlighted three shortcomings: 1) automatically collected datasets leave the task under constrained and may contain noise, 2) current evaluation protocol is weakly correlated with human judgment 3) models overfit to layout biases of current datasets. The concern around the unconstrained nature of the summarization task resonates with me, it makes evaluation very tricky. In another critical evaluation, [<span class="SpellE">Peyrad</span>](https://www.aclweb.org/anthology/P19-1502.pdf) claims that evaluation metrics like ROUGE strongly disagree in the higher scoring range in which the current systems operate.

[Jung et al.](https://www.aclweb.org/anthology/D19-1327.pdf) evaluate the bias in several summarization datasets on the aspects of position, importance and diversity. Not surprisingly, news datasets show high bias for position, but this is not true for academic papers and meeting minutes. There is a lot of useful information in this paper that should guide researchers in their data annotation efforts. In a related work, [Zhong et al.](https://www.aclweb.org/anthology/P19-1100.pdf) analyze the impact of different components in extractive neural summarization models.

# New Evaluation Techniques and Datasets

[Sun & <span class="SpellE">Nenkova</span>](https://www.aclweb.org/anthology/D19-1116.pdf) present a great set of experiments on using distributed representations for summarization evaluation compared to n-gram overlap in ROUGE. [Eyal et al.](https://www.aclweb.org/anthology/N19-1395.pdf) use the progress in Question Answering (QA) to design an evaluation based on automated QA systems called APES (Answering Performance for Evaluation of Summaries). The idea is that a good summary should allow a QA system to answer salient questions related to the original text. [Hardy et al.](https://www.aclweb.org/anthology/P19-1330.pdf) present a new methodology for human evaluation in which summaries are assessed by multiple annotators via manually highlighted salient content in the source document.

I found three of the new datasets interesting. [Sharma et al.](https://www.aclweb.org/anthology/P19-1212.pdf) introduce <span class="SpellE">BigPatent</span>, a dataset of 1.3 million abstractive patent summaries. [Lev et al.](https://www.aclweb.org/anthology/P19-1204.pdf) introduce <span class="SpellE">TalkSumm</span>, a dataset for scientific paper summarization created by aligning papers and their conference talk transcripts. [<span class="SpellE">Fabri</span> et al.](https://www.aclweb.org/anthology/P19-1102.pdf) created one of the few large scale multi-document news summarization datasets called Multi-News with about 56,000 examples.

Finally, [Deutsch & Roth](https://www.aclweb.org/anthology/D19-1386.pdf) introduce an interesting new task called summary cloze: to generate the next sentence of a summary conditioned on the beginning of the summary, a topic, and a reference document. They release a dataset of 500,000 summary cloze instances based on Wikipedia.

# Final Thoughts

Clearly, the summarization community is active as ever! I hope you found this review useful. If you’re interested in exploring this more, I’ve uploaded the raw text file with all the papers organized into my topic hierarchy [here](https://rahuljha.github.io/assets/2019_summarization_themes.txt).

</div>
