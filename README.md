# Battlefield 4 Webcon
BF4 Webcon intends to support the [Something Awful Forums](http://forums.somethingawful.com/) Battlefield community with a companion web browser tab to [Battlelog](http://battlelog.battlefield.com). Although development will be tailored to SA's needs and humor, the majority of code will work with any community. This is meant to provide more capabilities than my [Battlefield 3 RCON PHP Scripts project](https://github.com/RobFreiburger/Battlefield-3-RCON-PHP-Scripts).

## Planned Features
* Community player authentication via [Steam OpenID](http://steamcommunity.com/dev) and SA Forums profile scraping.
* Constant connection to servers for event listening and logging.
* Community player whitelisting.
* Friends of community player whitelisting and tracking (if friend is banned, community player may be banned too).
* Bad behavior reporting via server and website.
* Player kicking/banning via server and website by server renter, server admins, and/or community player voting.
* PunkBuster ban tracking to prevent PB-banned players from rejoining (if possible).

## Development
BF4 Webcon is a [Ruby on Rails 4.0](http://rubyonrails.org/) app designed to be deployed via [Heroku](http://heroku.com/). This repository follows the [Git Flow development model](http://nvie.com/posts/a-successful-git-branching-model/). Development is based on the assumption that BF4's RCON protocol will be nearly identical to BF3's RCON protocol.

## License
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">BF4 Webcon</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/RobFreiburger/BF4_Webcon" property="cc:attributionName" rel="cc:attributionURL">Rob Freiburger</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/deed.en_US">Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License</a>.

If you would like to use BF4 Webcon for commercial purposes, [please contact me](mailto:rob@robfreiburger.com).