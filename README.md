# babylon_demo

Screen1
Posts screen shows posts per user in sections (section header is user name)

Screen2
Post Details screen shows author (user name), title (selected post) and comments for selected post 

Following points have been considered to design and develop this demo app….

Using Swift 5.0

MVVM design pattern

Protocol oriented programming

Reactive programing using RxSwift / RxCocoa / RxDataSources

Used Generics, Results etc. latest APIs

Used dependency injection (injection through constructor)

Multithread programing  

Error handling (Custom Error)

By analysing data (users, posts, comments) setup CoreData model with relations (“one-to-many” and “many-to-one”) among tables (entities) to facilitate fetching data and cascade delete

Syncing of background threads using dispatch group (download data from all three endpoints (user, post, comment) then saving data in CoreData model in background thread

Few test cases have been added, mainly 
Data Downloader tests (tested data download, cascade delete)
URL Components Provider tests
Data Parser Test
