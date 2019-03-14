local number={
4,
9 ,
10 , 
12
}
local expression={}

local PRECISION = 0.000001
local function toExpression(numbers)
	if not numbers or type(numbers) ~= 'table' then return end
	for i,v in ipairs(numbers) do 
		expression[i]= tostring(v);
	end
end

local function Search(n) 
    if (n == 1) then 
    	return math.abs(number[1] - 24)<PRECISION
    end

    for i=1,n do 
        for j=i+1,n do
            local a, b = number[i],number[j]
            local expa, expb = expression[i],expression[j]

            number[j] = number[n]
            expression[j] = expression[n]

            expression[i] = '(' .. expa .. '+' .. expb .. ')'; 
            number[i] = a + b; 
            if Search(n - 1)  then return true end

            expression[i] = '(' .. expa .. '-' .. expb .. ')'
            number[i] = a - b; 
            if Search(n - 1)  then return true end

            expression[i] = '(' .. expb .. '-' .. expa .. ')'
            number[i] = b - a; 
            if Search(n - 1)  then return true end


            expression[i] = '(' .. expa .. '*' .. expb .. ')' 
            number[i] = a * b; 
            if Search(n - 1)  then return true end

            if (b ~= 0) then 
                expression[i] = '(' .. expa .. '/' .. expb .. ')' 
                number[i] = a / b; 
                if Search(n - 1)  then return true end
            end
            if (a ~= 0) then
                expression[i] = '(' .. expb .. '/' .. expa .. ')' 
                number[i] = b / a; 
                if Search(n - 1)  then return true end
            end

            number[i] = a
            number[j] = b
            expression[i] = expa
            expression[j] = expb
        end
    end
    return false; 
end

local function main()
	toExpression(number)
	print(Search(#number) and "SUCCESS\n" .. expression[1] or "FAIL")
end
main()