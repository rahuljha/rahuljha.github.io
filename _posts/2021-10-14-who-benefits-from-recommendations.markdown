![community recommendation](assets/community.jpg)

For those of us working on recommendation systems, there is nothing like hearing from a consumer: "I discovered something through your system that I would never have seen otherwise!" This motivates us to make our systems more personalized and valuable for our consumers.

However, there are other things a recommendation system should care about. We'd like to also hear: "Due to your system, my content was seen by a lot of relevant people." Or: "Through your system, I discovered this community I didn't know existed." There is a difference between optimizing only for engagement vs overall health of the ecosystem.

What happens if we only focus on optimizing user engagement and ignore other factors? At the beginning of 2018, LinkedIn found that even though the engagements on their feed were increasing more than 50% YoY, almost all the gains in these engagements were accrued to the top 1% of power users, while majority of creators who don't receive feedback were receiving less than ever [1]. Secondly, irrelevant hyper-viral posts were crowding out posts from closer connections. This was happening because the recommendation model was ranking posts based only on the probability that the viewer will engage with the post.

As a result of this analysis, LinkedIn updated their model to also consider the value of feedback for the creator. For the top 1% of the creators, one more like or comment may not mean much, but for the average creator, getting one more piece of feedback from a close colleague can be very meaningful. Adding this additional creator utility term in the objective for the relevance model had the impact of taking about 8% of the feedback away from top 0.1% of creators and redistributing it to the bottom 98%. They also saw a reduction in out-of-network highly-viral posts in top slots of the feed. These changes didn't hurt the top creators, since given the 50% YoY growth still left them with a lot more engagement. But these changes ensured that the rising tide lifted all boats.

Recent work has explored more techniques for creator side optimization. In [2], the authors train a model that predicts the probability of a creator creating a new content based on number of feedbacks received in the past. Feedback sensitivity is defined as a delta probability of creation given an increase in feedback. This sensitivity is used to estimate creator utility and added as an additional term in the score of an item in addition to consumer utility. By using the updated model, they achieved offline gains as well as online gains in both consumer and creator side metrics.

In another recent paper [3], the authors propose a social reinforcement learning approach for optimizing the diffusion of true news in social networks. The hypothesis is that increased exposure to true news will increase mistrust of fake news. They learn a simulation model for the news diffusion process using real-world Twitter datasets and use the simulation model to create train and evaluation data. Incentives are provided to users to promote true news, with incentives distributed among the users based on a budget constraint. The policy for distributing these interventions is learnt using reinforcement learning. Their results show that by applying the learnt policy, they can increase the spread of true news even among the people exposed to fake news.

Models that optimize higher order network effects such as creator utility and information diffusion are less well-studied than those that optimize consumer engagement. There are also several challenges in conducting online A/B experiments for measuring these network effects [4]. However, we cannot ignore them if we want our recommendation systems to promote healthy communities.

**References:**

[1] Bonnie Barrilleaux and Dylan Wang, [Spreading the Love in the LinkedIn Feed with Creator-Side Optimization.](https://engineering.linkedin.com/blog/2018/10/linkedin-feed-with-creator-side-optimization) LinkedIn Blog 2018.

[2] Ye Tu, et al. [Feedback shaping: A modeling approach to nurture content creation.](https://arxiv.org/abs/2106.11312) KDD 2019.

[3] Mahak Goindani and Jennifer Neville. [Social Reinforcement Learning to Combat Fake News Spread.](http://proceedings.mlr.press/v115/goindani20a.html) UAI 2020.

[4] Martin Saveski et al. [Detecting Network Effects: Randomizing Over Randomized Experiments.](https://dl.acm.org/doi/10.1145/3097983.3098192) KDD 2017.
