build:
	hugo

serve:
	hugo -D serve

serve-local:
	hugo -D serve --bind 0.0.0.0 --baseURL http://$$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p'):1313

clean:
	rm -rf docs resources/_gen

# Page bundle format, allows images in the same directory
new:
	@if [ -z "$(title)" ]; then echo "Please provide 'title'"; exit 1; fi
	hugo new posts/$$(date +%Y/%m)/$(title)/index.md

new-single:
	@if [ -z "$(title)" ]; then echo "Please provide 'title'"; exit 1; fi
	hugo new posts/$$(date +%Y/%m)/$(title).md
