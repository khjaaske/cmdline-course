BOOKS=alice christmas_carol dracula frankenstein heart_of_darkness life_of_bee moby_dick modest_propsal pride_and_prejudice tale_of_two_cities ulysses

FREQLISTS=$(BOOKS:%=results/%.freq.txt)
SENTEDBOOKS=$(BOOKS:%=results/%.sent.txt)
NO_MD_BOOKS=$(BOOKS:%=data/%.no_md.txt)
ALLFREQ=$(BOOKS:%=results/%.all.freq.txt)
ALLSENT=$(BOOKS:%=results/%.all.sent.txt)

# all command sees that the script needs both FREQLISTS and SENTEDBOOKS.
all: $(FREQLISTS) $(SENTEDBOOKS) $(ALLFREQ) $(ALLSENT)

clean:
	rm -f results/* data/*no_md.txt

# removes metadata from all book in the book list
%.no_md.txt: %.txt
	python3 src/remove_gutenberg_metadata.py $< > $@

# creates frequency lists of all the books in separate files
results/%.freq.txt: data/%.no_md.txt 
	src/freqlist.sh $< > $@

# creates sentence lists of all the books in separate files
results/%.sent.txt: data/%.no_md.txt
	src/sent_per_line.sh $< > $@

results/%.all.freq.txt: data/%.no_md.txt
	src/freqlist.sh $< > $@

results/%.all.sent.txt: data/%.no_md.txt
	src/sent_per_line.sh $< > $@

# adds a dependency that lists all the non-metadata texts concatenated into a file all.no_md.txt
data/all.no_md.txt:  $(NO_MD_BOOKS)
	cat $^ > $@

data/all.freq.txt: $(ALLFREQ)
	cat $^ > $@

data/all.sent.txt: $(SENTEDBOOKS)
	cat $^ > $@

no_md: $(NO_MD_BOOKS)
all.no_md: $(NO_MD_BOOKS)
allfreq: $(ALLFREQ)
allsent: $(ALLSENT)
