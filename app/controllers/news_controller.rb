class NewsController < ApplicationController

	def index
	end

	def new
		require_dev
	end

	def news_gen
		@page=params[:page]
		puts @page
		@newsad=params[:newsad]
		puts @newsad
		@newsT=params[:newsT]
		puts @newsT
		@newsH=params[:newsH]
		puts @newsH
		@newsD=params[:newsD]
		puts @newsD
		@newsC=params[:content]
		puts @newsC
	end
end
