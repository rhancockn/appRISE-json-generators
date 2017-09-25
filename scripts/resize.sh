for f in *.jpg; do
convert $f -thumbnail '200x200>' \
          -background white -gravity center -extent 200x200 resized/${f}
done
