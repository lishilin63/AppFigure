Appfigures Jr. Data Scientist Take Home

This take home will simulate two of the most common/immediate tasks you'll be doing in the position, it'll not only serve to measure your fit for the role but also meant to give you a sense of the type of work. We'll be focusing on estimating app downloads for a category in the app store, think games, utilities, etc.

You have been provided two files ranks.csv and sales.csv, containing simulated rank and sales data for an app category over 3 months. A category can have 1000 ranks at a given time, which changes hourly, while downloads and reviews are recorded daily. We'll ask you to create a sales model and use estimates by the model to come up with an interesting insight about an app, the category over time or anything you think is insightful. 

Part 1 (~3-4hrs):

Your goal is to create a model to estimate the daily downloads of a ranked app. You're allowed to use any statistical/ML model you'd like as long as results are fully reproducible. Don't focus too much on model accuracy, we're mainly concerned on how you perform exploratory analysis, handle missing data, outliers, variable selection, choose loss function and validation. 

Please submit your analysis/model code (ideally Python or R) along with a file ([last name]_estimates.csv) which contain your estimates for all ranked apps. Submissions will have the following format:
Date, app_id, sales_est
"2016-01-01",1,10000
"2016-01-01",2,106780

Part 2 (~1hr):

We have estimates now! Great! What do we DO with it now? Part 2 will be more open ended. We want you to come up with something interesting given the new data. It can be about an app or it can be about the category in aggregate. It should be formatted more like a report, but the exacts are up to you.

Field details:
app_id		identifier for app
s1-s5		daily 1-5 star reviews
cs1-cs5		cumulative 1-5 star reviews 
r0-r23		ranks at the respective hour of the day (e.g. r1 is the rank at 1 am)
sales		"cleaned" app downloads