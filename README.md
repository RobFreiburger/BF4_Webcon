NOTE: I am no longer maintaining this repository.

# Battlefield 4 Webcon
BF4 Webcon was intended to be a community-oriented tool for managing BF4 servers. However, BF4's launch was very problematic, even for the developer's reputation of buggy launches. It essentially destroyed my preferred community's desire to play it as well as my desire to keep developing this project.

## Implemented Features
* [Steam OpenID](http://steamcommunity.com/dev) authentication. Valve's Steam service was the closest thing to a open standard for gamers. Nearly every PC gamer used Steam or at least knew of it.
* [Something Awful Forums](http://forums.somethingawful.com) member profile scraping. This second authentication factor was only performed once to establish a Steam account belonged to a Something Awful member. Profiles are not publically accessible, so a dummy account and cookie management were necessary for scraping.
* Player whitelisting. After being authenticated, members could enter their [Origin](http://www.origin.com) ID. Origin was [Electronic Arts](http://www.ea.com)' competitor to Steam, but there was no API for their system.

## Previously Planned Features
* Constant connection to BF4 game servers for event listening and logging.
* Friends of community player whitelisting and tracking (if friend is banned, community player may be banned too).
* Bad behavior reporting via server and website.
* Player kicking/banning via server and website by server renter, server admins, and/or community player voting.
* [PunkBuster](http://www.evenbalance.com) ban tracking to prevent PB-banned players from rejoining (if possible).

## Development Process
BF4 Webcon was a [Ruby on Rails 4.0](http://rubyonrails.org/) app designed to be deployed via [Heroku](http://heroku.com/). This repository followed the [Git Flow development model](http://nvie.com/posts/a-successful-git-branching-model/). It was assumed BF4's RCON protocol for game server querying and interaction was nearly identical to [BF3's RCON protocol](https://github.com/RobFreiburger/Battlefield-3-RCON-PHP-Scripts).

## License
Copyright 2013 Rob Freiburger and Paul Robins

Battlefield 4 Webcon is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

Battlefield 4 Webcon is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with Battlefield 4 Webcon. If not, see <http://www.gnu.org/licenses/>.