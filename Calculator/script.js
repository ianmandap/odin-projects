// Operator functions
function add(x,y) {
    return x+y;
}

function subtract(x,y) {
    return x-y;
}

function multiply (x,y) {
	return x * y;
}

function divide(x,y) {
    if (y === 0) {
        alert("Cannot divide by 0.");
        return;
    }
	return x / y;
}

function power(x,y) {
	return x ** y;
}

function factorial(x) {
	if (x === 0) {return 1}
	return x * factorial(x-1);
}

// Helper functions
function operator(operator, x, y) {
    return operator(x,y);
}

function clearAll() {
    ans = 0;
}

// Global variables
let ans = 0;

