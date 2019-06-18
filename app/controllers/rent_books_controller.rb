class RentBooksController < ApplicationController
  before_action :find_rent_books, only: %i[index]
  before_action :find_rent_book, only: %i[show edit update]

  def index
    if params[:start_date].present? || params[:end_date].present?
      @rent_books = RentBook.where(book_id: params[:book_ids]).before_date(params[:start_date]).after_date(params[:end_date])
    else
      flash[:alert] = "Start date or End date cannot be empty"
    end
  end

  def show
  end

  def new
    @rent_book = current_user.rent_books.new
  end

  def edit
  end

  def create
    @rent_book = current_user.rent_books.new(rent_book_params)

    if @rent_book.save
      redirect_to @rent_book, notice: "Your rent_book successfully created."
    else
      render :new
    end
  end

  def update
    if @rent_book.update(rent_book_params)
      redirect_to @rent_book, notice: "Your rent_book successfully updated."
    else
      render :edit
    end
  end

  private

  def rent_book_params
    params.require(:rent_book).permit(:book_id, :start_rent_time, :end_rent_time)
  end

  def find_rent_books
    @rent_books = RentBook.all
  end

  def find_rent_book
    @rent_book = RentBook.find(params[:id])
  end
end
