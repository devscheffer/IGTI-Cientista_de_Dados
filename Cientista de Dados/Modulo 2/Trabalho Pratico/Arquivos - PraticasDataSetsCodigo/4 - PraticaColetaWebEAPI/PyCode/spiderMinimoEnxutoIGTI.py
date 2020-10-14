# -*- coding: utf-8 -*-
"""
Created on Mon Jun  1 19:29:44 2020

@author: IGTI
"""

import scrapy
 
class SpiderMinimo(scrapy.Spider):
    """Scrapy spider mínimo"""
    
    name = 'minimo'
 
    start_urls = ['https://www.igti.com.br','https://www.igti.com.br/blog/']
 
    def parse(self, response):
        self.log('Acessando a URL: %s' % response.url)   

