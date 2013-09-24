# http://www.dzone.com/snippets/ruby-extending-mechanizesbla

class Mechanize::CookieJar

	public

	def save_str
		URI.escape(YAML::dump(@jar))
	end

	def load_str(str)
		@jar = YAML::load(URI.unescape(str))
	end

end