Soft Story Buildings
====================

Helping Oakland residents understand their buildings' earthquake risks

### One-liner
A simple way for people to view information on the status of "soft-story" buildings in Oakland.

### Status
- 3/1/14: We have data (see below) representing the 1,000 buildings whose owners submitted screenings. We're still waiting on the full original list of potential soft-story buildings that were asked to submit a screening (1,379 properties.)

The next big step is to do some design and minimal prototyping for a "proof of concept" what a basic search and educational tool would look like, and start to map out possible points of continued engagement (e-mail list? info to contact someone?)

### Local Setup

To get the alpha version of the web site running locally, do the following:

- Clone the repo and `cd` into the directory
- Install Bower if you don't already have it: `npm install -g bower`
- Run `bower install`
- Install compass if you don't have it: `gem install compass`
- Run `compass watch`
- Run `python -m SimpleHTTPServer` to serve up the site
- Visit [http://localhost:8000/](http://localhost:8000/) where the site will be!

### Getting Involved

If you're interested in this project, a few ways to get involved are:

1. Contact Dave ([@allafarce on Twitter](https://twitter.com/allafarce))
1. Comment on a project task on [the Issues page](https://github.com/openoakland/soft-story-buildings/issues) that interests you
1. Come to an [OpenOakland meeting](http://www.meetup.com/OpenOakland/) (every Tuesday evening @ Oakland City Hall)

### Description
The [Association of Bay Area Governments](http://quake.abag.ca.gov/projects/oakland-soft-story/) identified 1,379 "soft-story" buildings in Oakland that are the highest-risk for causing injuries or worse in a large earthquake. The City of Oakland then passed an ordinance requiring properties' owners submit a "screening" of these buildings with basic facts that can inform a risk assessment for each building. Among the biggest factors are slope and having parking/empty space underneath the building.

[ABAG's report](http://quake.abag.ca.gov/wp-content/documents/OaklandSoftStoryReport_061113.pdf) details the findings of the first stage of screenings, but there currently seems to be no raw data, and therefore no way for a resident to find out the status of their own building.

What I'm thinking is making an easy way for residents (particularly renters) to see the seismic risk of buildings in Oakland (per the screening data.) It would be great to increase awareness, as renters suffer the consequences of not-retrofitting a building, but may not know that they're at-risk. With the rental market in Oakland booming, many landlords are making higher profits than they have in the past, and so making it easier for renters to advocate for retrofitting of their own buildings is my ultimate aim. (Berkeley, SF, and Fremont have all passed measures *requiring* retrofits of soft-story buildings: with the prices and speculation in Oakland currently, the cost arguments should be less concerning over time.)

### Data

Check out [data.csv](data.csv) for the raw data received from the City on 2/11/14.

### Other resources
Stumbled upon the idea by way of this little app made by @kleinlieu for Berkeley:
http://senator.kleinlieu.com/saferenting/

- City of Oakland soft-story FAQ: http://www2.oaklandnet.com/Government/o/PBN/OurOrganization/BuildingServices/o/Permits/DOWD008964
- ABAG Oakland soft-story project page: http://quake.abag.ca.gov/projects/oakland-soft-story/ 
- ABAG report: http://quake.abag.ca.gov/wp-content/documents/OaklandSoftStoryReport_061113.pdf 
- Map (soft-story buildings for survey): http://quake.abag.ca.gov/wp-content/documents/OaklandSoftStoryMap2013.pdf 
- Map (suspected, from initial cut): http://quake.abag.ca.gov/wp-content/documents/OaklandSoftStoryMap.pdf 
- Public records request for the data from Oakland on RecordTrac: http://records.oaklandnet.com/request/2281 
- Oakland North article: http://oaklandnorth.net/2011/05/03/is-oakland-ready-for-its-next-big-earthquake/
- LAT coverage of CA earthquake safety: http://www.latimes.com/local/la-me-sg-earthquake,0,7535474.storygallery#axzz2rIa5pxVg 
- City of Oakland Resilient City page: http://www2.oaklandnet.com/Government/o/CityAdministration/OAK044398 

*[Migrated from @daguar's [personal repo](https://github.com/daguar/ideas/issues/8) now that it's more explicitly an OpenOakland project idea]*
