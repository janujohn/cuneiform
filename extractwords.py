# -*- coding: utf-8 -*-
"""Extracts non trivial words for a raw text
Stops nltk's stopwords and single alphabets from a-z
Returns a list of extracted words

Authored by: JohnsiRaani.M <hi@johnsiraani.com>"""

import re
import nltk
nltk_stopwords = ['i', 'me', 'my', 'myself', 'we', 'our', 'ours', 'ourselves', 'you', 'your', 'yours', 'yourself', 'yourselves', 'he', 'him', 'his', 'himself', 'she', 'her', 'hers', 'herself', 'it', 'its', 'itself', 'they', 'them', 'their', 'theirs', 'themselves', 'what', 'which', 'who', 'whom', 'this', 'that', 'these', 'those', 'am', 'is', 'are', 'was', 'were', 'be', 'been', 'being', 'have', 'has', 'had', 'having', 'do', 'does', 'did', 'doing', 'a', 'an', 'the', 'and', 'but', 'if', 'or',
'because', 'as', 'until', 'while', 'of', 'at', 'by', 'for', 'with', 'about', 'against', 'between', 'into', 'through', 'during', 'before', 'after', 'above', 'below', 'to', 'from', 'up', 'down', 'in', 'out', 'on', 'off', 'over', 'under', 'again', 'further', 'then', 'once', 'here', 'there', 'when', 'where', 'why', 'how', 'all', 'any', 'both', 'each', 'few', 'more', 'most', 'other', 'some', 'such', 'no', 'nor', 'not', 'only', 'own', 'same', 'so', 'than', 'too', 'very', 's', 't', 'can',
'will', 'just', 'don', 'should', 'now',]

alphabets = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']

others = ['st', 'nd', 'rd', 'th']
stopwords = nltk_stopwords + alphabets + others

"""Extracts and returns non trivial words from given raw text
Skips ASCII incompatible encoded characters"""
def extract(raw):
	filtered = []
	word_list = nltk.word_tokenize(raw.lower().decode('utf-8'))

	# compile regex for punctuation
	punctuation = re.compile(r'[-.?!,":;\'`\[\]()*%&@$^|0-9]')
	word_list = [punctuation.sub("", word).strip() for word in word_list] 

	# skip empty string words
	cleaned = [word for word in word_list if word.strip() != '']

	# skip stopwords
	stopped = [word for word in cleaned if word not in stopwords]

	# remove duplicates
	stopped = sorted(list(set(stopped)))

	for a in stopped:
		try:
			str(a)
			filtered.append(a)
		except UnicodeEncodeError:
			pass
	return filtered
