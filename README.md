# WSJ RSS Reader
A simple RSS reader for various WSJ RSS Feeds written using primarily SwiftUI and Combine and architected in a simple MVVM architecture.

[Feeds Source](https://www.wsj.com/news/rss-news-and-feeds)

#### Where I'd go next...
1. I don't care for the error display solution that I ended up on. The fact that displaying an error and the error getting set are so decoupled and not bound feels off, but it works for this simple scenario. 
2. I would love to implement pull-to-refresh functionality on the feed pages. I have the call split out to allow for reloading. I would just need to implement the user interaction.
3. On iPad and landscape on larger phones, the default is a split view leaving the main view blank on launch. This is a bit disorienting as far as UX is concerned. I would like to implement some sort of placeholder view there that can greet the user.