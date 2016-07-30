import re
digits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
characters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
		'n','o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 
		'E','F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 
		'V','W', 'X', 'Y', 'Z']
special = ['.', ',', ';', '(', ')', '[', ']', '+', '-', '=', '*', '"', '!', '#']
keyword = ['if', 'else', 'else', 'void', 'int' 'main', 'include', 'iostream', 'using',
			'namespace', 'std', 'cout', 'cin', 'endl', 'return']
identifier = ['a', 'b', 'sum']
tokenCount = dict()
tokenClass = dict()
classCount = dict()

inputFile = open('add.cpp')
for line in inputFile:
	single = list(line)
	word = re.split(r';|\s+',line)
	for letter in single:
		if letter in digits:
			tokenClass[letter] = "digits"
		elif letter in characters:
			tokenClass[letter] = "characters"
		elif letter in special:
			tokenClass[letter] = "special"
		else:
			continue

		if letter in tokenCount:
			tokenCount[letter] += 1
		else:
			tokenCount[letter] = 1

		if tokenClass[letter] in classCount:
			classCount[tokenClass[letter]] += 1
		else:
			classCount[tokenClass[letter]] = 1
	for wrd in word:
		if wrd in keyword:
			tokenClass[wrd] = "keyword"
		elif wrd in identifier:
			tokenClass[wrd] = "identifier"
		elif (re.search(r'\d+', wrd)):
			tokenClass[wrd] = "integer"
		else:
			continue

		if wrd in tokenCount:
			tokenCount[wrd] +=1
		else:
			tokenCount[wrd] = 1

		if tokenClass[wrd] in classCount:
			classCount[tokenClass[wrd]] += 1
		else:
			classCount[tokenClass[wrd]] = 1

print "\nTOKENCOUNT"
for key, val in tokenCount.items():
	print("{} \t {}".format(key,val))

print "\nTOKENCLASS"
for key, val in tokenClass.items():
	print("{} \t {}".format(key,val))

print "\nCLASSCOUNT"
for key, val in classCount.items():
	print("{} \t {}".format(key,val))


