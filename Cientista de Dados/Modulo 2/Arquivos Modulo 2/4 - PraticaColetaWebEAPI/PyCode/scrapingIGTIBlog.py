# -*- coding: utf-8 -*-
"""
Created on Mon Jun  2 20:05:24 2020

@author: IGTI
"""

import scrapy

# Para executar, use o prompt do Anaconda, e execute o seguinte comando:
# scrapy runspider scrapingIGTIBlog.py -t json -o artigos.json
#       ou
#scrapy runspider scrapingIGTIBlog.py -t csv -o artigos.csv

class Itens(scrapy.Item): 
    #Para cada artigo da página:
    categoria = scrapy.Field()
    categoriaURL = scrapy.Field()
    titulo = scrapy.Field()
    url = scrapy.Field()
    dtPostagem = scrapy.Field()
    comentarios = scrapy.Field()
    visualizacoes = scrapy.Field()

class IGTIBlogSpider(scrapy.Spider):

    name = 'Scraping IGTI Blog'
       
    # A página alvo da nossa raspagem é 'https://www.igti.com.br/blog/'

    def __init__(self):
        self.start_urls = ['https://www.igti.com.br/blog/']        
              
    def parse(self, response):
        self.log('Acessando a URL: %s' % response.url)

        artigos = response.xpath("//article")
        count = 0
        self.log('Total de artigos em destaque: %s' % str(len(response.css('article'))))
        
        for artigo in artigos:
            item = Itens()
            count += 1
            #print('Artigo:',str(count))                    
            
            categorias = artigo.xpath(".//div/div[@class='entry-category']//a")
            
            if len(categorias) == 1 :
                item['categoria'] = ''.join(categorias.xpath('text()').get())
                item['categoriaURL'] = ''.join(categorias.xpath('@href').get())
            else:
                cat = []
                catUrl = []
                for categoria in categorias:
                    cat.append(''.join(categoria.xpath('text()').extract()))
                    cat.append(', ')
                    catUrl.append(''.join(categoria.xpath('@href').extract()))
                    catUrl.append(', ')                                                           
                item['categoria'] = ''.join(cat)
                item['categoriaURL'] = ''.join(catUrl)

            print('Categoria: ', item['categoria'])
            #print('Categoria URL: ', item['categoriaURL'])            
            
            titulo = artigo.xpath(".//h2[@class='entry-title h3']//a")
            
            item['titulo'] = ''.join(titulo.xpath('text()').extract())
            item['url'] = ''.join(titulo.xpath('@href').extract())	
            #print('Titulo: ', item['titulo'])
            #print('URL: ', item['url'])            
            
            metadata = artigo.xpath(".//div/div[@class='entry-meta']")
            data = metadata.xpath(".//div[@class='meta-item meta-date']/span[@class='updated']")		
            item['dtPostagem'] = ''.join(data.xpath('text()').get())            
            #print('Data da postagem: ', item['dtPostagem'])
            
            comentario = metadata.xpath(".//div[@class='meta-item meta-comments']//a//span[@class='dsq-postid']")            
            item['comentarios'] = ''.join(comentario.xpath('text()').get())
            #print('Quantidade de comentários: ', item['comentarios'])
             
            visao = metadata.xpath(".//div[@class='meta-item meta-views']")
            item['visualizacoes'] = ''.join(visao.xpath('text()').get())
            #print('Quantidade de visualizações: ', item['visualizacoes'])
            
            yield item
        
        self.log('Artigos raspados: %s' % str(count))
        
        self.log('FIM DA RASPAGEM!')
  