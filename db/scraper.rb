require 'nokogiri'
require 'open-uri'

    def scrapeUrl(url, extra = nil)
        i = 0
        stats = []
        html = open(url)
        doc = Nokogiri::HTML(html)
        table = doc.at('table')
        table.search('tr').each do |tr|
            cells = tr.search('th, td').text
            cells = cells.gsub(/[^0-9a-z.,-]/i, ' ')
            if i == 0 && extra == nil
                cells.insert(2, ' ')
                cells.insert(9, ' ')
                cells.insert(14, ' ')
                cells = cells.split(' ')
                i += 1
            elsif i == 0 && extra != nil
                cells.split(' ')
                extra = nil
                removeFirst = true
            else
                cells = cells.split('  ')
            end
            if removeFirst != true
                cells.reject! {|c| c.empty?}
                cells.map! {|v| v.strip}
                stats << cells
            end
            removeFirst = false
        end
        stats
    end
