# -*- coding: utf-8 -*-
require 'handsoap'

class Smodel < Handsoap::Service
  endpoint SMODEL_SERVICE_ENDPOINT

  def on_create_document(doc)
    # register namespaces for the request
    doc.alias 'web', "http://www.webserviceX.NET"
  end
=begin
  def on_response_document(doc)
    # register namespaces for the response
    doc.add_namespace 'web', 'http://www.webservicex.NET'
  end
=end
  # public methods

  def get_countries
  	response = invoke("web:GetCountries", :soap_action => :none)

  	node = response.document.xpath('//ns:GetCountriesResult', ns)[0]
  	parse_country_description(node)
  end
  
  def get_currencies
  	response = invoke("web:GetCurrencies", :soap_action => :none)  

  	node = response.document.xpath('//ns:GetCurrenciesResult', ns)[0]#.children
  	parse_currency_description(node)
  end
  
  def get_country_by_code(country_code)
    response = invoke("web:GetCountryByCountryCode", :soap_action => :none) do |message|
      message.add 'web:CountryCode', country_code
    end
    node = response.document.xpath('//ns:GetCountryByCountryCodeResult', ns).first
    parse_country_by_code_result(node)
  end

  
  private

  def ns
    { 'ns' => 'http://www.webserviceX.NET' }
  end
  
  # helpers
  def parse_country_description(node)
     # xml_to_str(node, nil).scan(/\<Name\>(.+?)\<\/Name\>/).flatten
	array = []
	doc = Nokogiri::XML(node.children[0].to_s)
	doc.search('Table').each{|d|
		hash = {
			'name'=>d.search('Name').text.strip,
		}
		array.push(hash)
	};2

	return array
      
  end
  def parse_currency_description(node)
=begin
       <soap:Body>
      <GetCurrenciesResponse xmlns="http://www.webserviceX.NET">
         <GetCurrenciesResult><![CDATA[<NewDataSet>
  <Table>
    <Name>Afghanistan, Islamic State of</Name>
    <CountryCode>af</CountryCode>
    <Currency>Afghani</Currency>
    <CurrencyCode>AFA</CurrencyCode>
  </Table>
  <Table>
=end
	array = []

	doc = Nokogiri::XML(node.children[0].to_s)
	doc.search('Table').each{|d|
		hash = {
			'name'=>d.search('Name').text.strip,
			'countrycode'=>d.search('CountryCode').text.strip,
			'currency'=>d.search('Currency').text.strip,
			'currencycode'=>d.search('CurrencyCode').text.strip
		}
		array.push(hash)
	};2

	return array
  end
  
  def parse_country_by_code_result(node)
	array = []
	doc = Nokogiri::XML(node.children[0].to_s)
	doc.search('Name').children.each{|a|
		array.push(a)
	}
	return array
	
  end
  
  
  
end

