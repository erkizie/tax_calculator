# frozen_string_literal: true

RSpec.describe 'Sales Tax Calculator Integration' do
  describe 'processing receipts' do
    it 'processes input 1 correctly' do
      input = <<~INPUT
        2 book at 12.49
        1 music CD at 14.99
        1 chocolate bar at 0.85
        done
      INPUT

      expected_output = <<~OUTPUT
        Enter your shopping items (type 'done' to finish):
        2 book: 24.98
        1 music CD: 16.49
        1 chocolate bar: 0.85
        Sales Taxes: 1.50
        Total: 42.32
      OUTPUT

      expect do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(*input.lines)
        SalesTaxCalculator.run
      end.to output(expected_output).to_stdout
    end

    it 'processes input 2 correctly' do
      input = <<~INPUT
        1 imported box of chocolates at 10.00
        1 imported bottle of perfume at 47.50
        done
      INPUT

      expected_output = <<~OUTPUT
        Enter your shopping items (type 'done' to finish):
        1 imported box of chocolates: 10.50
        1 imported bottle of perfume: 54.65
        Sales Taxes: 7.65
        Total: 65.15
      OUTPUT

      expect do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(*input.lines)
        SalesTaxCalculator.run
      end.to output(expected_output).to_stdout
    end

    it 'processes input 3 correctly' do
      input = <<~INPUT
        1 imported bottle of perfume at 27.99
        1 bottle of perfume at 18.99
        1 packet of headache pills at 9.75
        3 imported boxes of chocolates at 11.25
        done
      INPUT

      expected_output = <<~OUTPUT
        Enter your shopping items (type 'done' to finish):
        1 imported bottle of perfume: 32.19
        1 bottle of perfume: 20.89
        1 packet of headache pills: 9.75
        3 imported boxes of chocolates: 35.55
        Sales Taxes: 7.90
        Total: 98.38
      OUTPUT

      expect do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(*input.lines)
        SalesTaxCalculator.run
      end.to output(expected_output).to_stdout
    end
  end

  describe 'error handling' do
    it 'handles empty input' do
      input = "done\n"
      expected_output = <<~OUTPUT
        Enter your shopping items (type 'done' to finish):
        Error: Input cannot be empty
      OUTPUT

      expect do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(input)
        SalesTaxCalculator.run
      end.to output(expected_output).to_stdout.and raise_error(SystemExit)
    end

    it 'handles invalid input format' do
      input = <<~INPUT
        invalid format
        done
      INPUT

      expected_output = <<~OUTPUT
        Enter your shopping items (type 'done' to finish):
        Warning: Skipping invalid line: Invalid format: 'invalid format'
        Error: No valid items found
      OUTPUT

      expect do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(*input.lines)
        SalesTaxCalculator.run
      end.to output(expected_output).to_stdout.and raise_error(SystemExit)
    end

    it 'handles negative prices' do
      input = <<~INPUT
        1 book at -10.00
        done
      INPUT

      expected_output = <<~OUTPUT
        Enter your shopping items (type 'done' to finish):
        Warning: Skipping invalid line: Price must be positive
        Error: No valid items found
      OUTPUT

      expect do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(*input.lines)
        SalesTaxCalculator.run
      end.to output(expected_output).to_stdout.and raise_error(SystemExit)
    end

    it 'handles negative quantities' do
      input = <<~INPUT
        -1 book at 10.00
        done
      INPUT

      expected_output = <<~OUTPUT
        Enter your shopping items (type 'done' to finish):
        Warning: Skipping invalid line: Invalid format: '-1 book at 10.00'
        Error: No valid items found
      OUTPUT

      expect do
        allow_any_instance_of(Kernel).to receive(:gets).and_return(*input.lines)
        SalesTaxCalculator.run
      end.to output(expected_output).to_stdout.and raise_error(SystemExit)
    end
  end
end
