require 'spec_helper'
require 'rsolr'
require 'rspec-solr'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.order = 'random'

  solr_url = ENV["SOLR_URL"]
  if solr_url
    solr_config = {:url => solr_url}
  else
    raise "Please specify a solr url"
  end
  @@solr_path = ENV["SOLR_PATH"]
  @@solr = RSolr.connect(solr_config)
end

def solr_resp_doc_ids_only(solr_params)
  solr_response(solr_params.merge(@@doc_ids_only))
end

def solr_resp_title_only(solr_params)
  solr_response(solr_params.merge(@@title_only))
end

def solr_resp_author_only(solr_params)
  solr_response(solr_params.merge(@@author_only))
end

def author_search_args(query_str)
  {'q'=>"{!qf=$author_qf}#{query_str}"}
end
def subject_search_args(query_str)
  {'q'=>"{!qf=$subject_qf}#{query_str}"}
end
def title_search_args(query_str)
  {'q'=>"{!qf=$title_qf}#{query_str}"}
end

def solr_response(solr_params)
  solr_params["fq"] ||= Array.new
  solr_params["fq"] << "access_ss:dtu"
  solr_params["sort"] ||= "score desc, pub_date_tsort desc, title_sort asc"
  RSpecSolr::SolrResponseHash.new(@@solr.send_and_receive(@@solr_path, {:method => :get, :params => solr_params}))
end

private

@@doc_ids_only = {'fl'=>'id', 'facet'=>'false'}
@@title_only = {'fl' => 'title_ts', 'facet' => 'false'}
@@author_only = {'fl' => 'author_ts', 'facet' => 'false'}

def solr_schema
  @@schema_xml ||= @@solr.send_and_receive('admin/file/', {:method => :get, :params => {'file'=>'schema.xml', :wt=>'xml'}})
end

def solr_config_xml
  @@solrconfig_xml = @@solr.send_and_receive('admin/file/', {:method => :get, :params => {'file'=>'solrconfig.xml', :wt=>'xml'}})
end

