# ghpup

Project documentation update automation.

# What can ghpup do for me?

Give `ghpup` a folder where your `gh-pages` content is located,
and it will automatically update (or create) your upstream `gh-pages` branch.

# Example

Assuming that a `doc` rule will generate your documentation in
`$(DOCDIR)`, you may add this `gh-pages` rule to your `Makefile`.

    gh-pages: doc
	        commitmsg="Documentation for $(VERSION) version." \
			docdir="$(DOCDIR)" \
			upstream="origin" \
			ghpup

# Installation

Give `ghpup` execution rights, and copy it somewhere in your path
(e.g. `/usr/local/bin/`)

    chmod u+x ./ghpup
	mv ./ghpup /usr/local/bin/
