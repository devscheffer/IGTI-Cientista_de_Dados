# -*- coding: utf-8 -*-
"""
Created on Mon Jun  1 19:17:22 2020

@author: IGTI
"""
import scrapy
 
class SpiderMinimo(scrapy.Spider):
    """Scrapy spider mínimo"""
    
    name = 'minimo'
 
   
    def start_requests(self):
        #URL que será raspada ou rastreada
        url = 'https://www.igti.com.br/blog/'
        return [scrapy.Request(url)]
     
    def parse(self, response):
        self.log('Acessando a URL: %s' % response.url)    
        