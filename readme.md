# Huskie Hack 2017
Code for the NIU Huskie Hack 2017 Disaster and Wellness Challenge

The idea was to create a website that could not only predict natural disaster events but also map directions to the nearest shelter. Many of these shelters are actually converted from churhces, schools, etc.

## How it works

In order to determine the likelihood of a certain natural disaster of occuring in a certain area we trained a series of logistic binary regressors on a FEMA database of 50,000 date points. This would tell us the likelihood of each event within a certain state or county. We then included information about geography and climate to increase the accuracy of the algorithm.

To map the route to the nearest shelter we first created an algorithm that would find all the schools, churches, and shelter zones in every county in a specific area. From there we used the Google Maps API to create a path for the user to follow. This leverages a gps chip in most cellular devices in the case where internet is offline. 

Our website runs on both mobile and desktop sites. There is a feature which allows for users to save a copy of the map when they are preparing for different natural disasters.
