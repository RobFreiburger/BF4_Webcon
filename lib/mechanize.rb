# http://www.dzone.com/snippets/ruby-extending-mechanizes
require 'mechanize'

class WWW::Mechanize::CookieJar

	public

	def save_str
		return URI.escape(YAML::dump(@jar))
	end

	def load_str(str)
		@jar = YAML::load(URI.unescape(str))
	end

end