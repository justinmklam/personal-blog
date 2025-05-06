build:
	hugo 

serve:
	hugo -D serve

new:
	@if [ -z "$(title)" ]; then echo "Please provide 'title'"; exit 1; fi
	hugo new posts/$$(date +%Y/%m)/$(title).md
