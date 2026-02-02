# System Metrics Complete project.

1st of all you need to run the backend. you may find the instruction [here](./backend/system_metrics/README.md)

backend instruction also provide details about how you can get the base url, swagger. after collect the base url:
- go to the ```660778ee0cf2/mobile_app/system_metrics_mobile_app/lib/data/client/client_constant.dart``` file
- replace the base url.

then, to run mobile app, you may find the instruction [here](./mobile_app/system_metrics_mobile_app/README.md)

**without backend setup and base url, mobile app will not work**

Currnt backend set up is based on http. so, though you will find ios vitals data, but you cannot use backend. but if you use visual studio's iis express or host the project in any secure server, then hopefully you will get a remote link with https and can use all functionlities even from ios. but right now you can easily use app in android phone.