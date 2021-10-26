class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :create, :index, :edit, :update, :destroy]

  # GET /budgets or /budgets.json
  def index
    if current_user.try(:admin?)
        redirect_to rails_admin_path
    end
    
    
    @budgets_recap = []
    @budgets = Budget.all
    @budgets.each do |budget|
      @budget_recap = {}
      puts "Ici budget#{budget} puis les expenses #{budget.expenses}"
      amount = 0
      budget.expenses.each_with_index do |bud, i|
        puts "Montant du expense #{bud.amount}"
        puts "result du test #{bud.amount == bud.amount.to_i.to_s}"
        if bud.amount.to_i == bud.amount
          amount += bud.amount
          puts "Montant de amount à l'itération #{i} est#{amount}"
        end
        @budget_recap['used'] = amount
      end
      @budget_recap['start_date'] = budget.start_date
      @budget_recap['end_date'] = budget.end_date
      @budget_recap['amount'] = budget.amount
      @budget_recap['id'] = budget.id
      @budget_recap['remain'] = budget.amount - amount
      @budgets_recap += [@budget_recap]
      puts "amount dans recap #{@budget_recap['used']}"
    end

   
  end

  # GET /budgets/1 or /budgets/1.json
  def show
  end

  # GET /budgets/new
  def new
    @budget = Budget.new
    #@budget.needs.build
    5.times{@budget.needs.build}
      
  end

  # GET /budgets/1/edit
  def edit
    @budget.needs.build
  end

  # POST /budgets or /budgets.json
  def create
    @budget = current_user.budgets.build(budget_params)

    respond_to do |format|
      if @budget.save
        format.html { redirect_to @budget, notice: "Budget was successfully created." }
        format.json { render :show, status: :created, location: @budget }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /budgets/1 or /budgets/1.json
  def update
    respond_to do |format|
      if @budget.update(budget_params)
        format.html { redirect_to @budget, notice: "Budget was successfully updated." }
        format.json { render :show, status: :ok, location: @budget }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1 or /budgets/1.json
  def destroy
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to budgets_url, notice: "Budget was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget
      @budget = Budget.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def budget_params
      params.require(:budget)
            .permit(:start_date, :end_date, :amount, :name,
                    needs_attributes: [:id, :amount, :name, :priority, :status]
      )
    end
end
