module tb();
	reg clk, rst;
	reg [7:0] data_in_tb;
	reg [15:0] sum_tb;
	wire [15:0] sum_in_tb;
	wire carry;


	my_interface my_if(clk);
	accumulator dut (my_if);



	always #5 clk = ~clk;
	int i,Error_count;

	data_in_array = new[500]; //Dynamic array of size of 500
	sum_values queue[$]; //Creating Queue summing up values 


	initial begin
		clk = 0;
		$vcdpluson;
		$dumpfile("dump.vcd");
		$dumpvars;

		ret = 1;
		#5;
		rst = 0;
		#5;

//Checking Reset 
		if (sum_tb == 16'h0000) begin
			$display("Success");
		end else begin
			$display ("Failed");
		end

		#5;
//Creating 500 random values

		for (i=0; i<500; i++) begin
			data_in_array[i] = $urandom;
			data_in_tb = data_in_array[i]; 
		end

		#5;

//Checking Correctness
		expect_sum =0;
		for (i=0; i<500; i++) begin
			expect_sum = expect_sum +data_in_array[i];
			sum_tb = sum_values;
			$display("Sum: %h\t Expected: %h\n", sum_tb, expect_sum);
		end
	$finish
			
	end


	task checkoutput (input logic [15:0] sum_tb, expect_sum);
		begin
			if(sum_tb == expect_sum) begin
				$display("Success");end
			else begin
				$display("Error");
				Error_count = Error_count +1;
			end
		end
	endtask
