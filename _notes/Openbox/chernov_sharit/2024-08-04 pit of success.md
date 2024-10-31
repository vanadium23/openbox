---
{"dg-publish":true,"up":"[[Chernov sharit]]","date":"2024-08-04","posted":"https://t.me/chernov_sharit/604","modified_at":"2024-09-10T22:50:29+03:00","published_at":"2024-08-04T19:05:00+03:00","dg-path":"/chernov_sharit/2024-08-04 pit of success.md","permalink":"/chernov-sharit/2024-08-04-pit-of-success/","dgPassFrontmatter":true}
---


### (062/100) pit of success

Есть такая старенькая статья от Jeff Atwood - https://blog.codinghorror.com/falling-into-the-pit-of-success/. Она про то, что дизайн должен выбираться так, чтобы пользователь сам тяготел к правильным примерам. Больше всего в ней критики C++, как языка где выстрельнуть в себя в двойном тулупе проще простого.

На этой неделе DARPA пошла дальше и выкатила свою политику Translating All C to Rust (TRACTOR) - https://www.darpa.mil/news-events/2024-07-31a. Основной причиной послужил факт, что в программах на C / C++ возникает много ошибок при работе с памятью. В Rust (за скобками unsafe) эта работа сделана на уровне компилятора. То есть вместо ошибок у пользователя, мы получаем ошибки на уровне разработчика. Правда, форумы заполнены вопросы по работе с ним - https://www.reddit.com/r/rust/search/?q=Borrow+Checker.

А теперь давайте ещё взглянем на go. Он появился не как ответ на память, а как ответ на то, что разработчики недостаточно хорошо утилизировали железки в дата центрах. В итоге проще было не обучать разработчиков, а сделать общий движок (https://rakyll.org/scheduler/), куда разработчики скидывают код своих задачек. Только потом на stackoverflow топовый второй тег работа с channels/syncmaps, а не проблемы бедности языка.

Получает так, что если мы подойдём к вопросу хорошим программ на выходе, то DevEx вокруг этого должен не улучшать опыт программиста - а наоборот бить по рукам. Вот такая вот яма.

#марафон #черновик   @chernov_sharit