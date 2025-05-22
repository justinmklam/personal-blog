build:
	hugo

serve:
	hugo -D serve

clean:
	rm -rf docs resources/_gen

# Page bundle format, allows images in the same directory
new:
	@if [ -z "$(title)" ]; then echo "Please provide 'title'"; exit 1; fi
	hugo new posts/$$(date +%Y/%m)/$(title)/index.md

new-single:
	@if [ -z "$(title)" ]; then echo "Please provide 'title'"; exit 1; fi
	hugo new posts/$$(date +%Y/%m)/$(title).md
