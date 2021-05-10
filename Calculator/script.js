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
	let answer = x / y;
    let length = answer.toString(10).length; // add rounding
    if (length > overflowValue) {
        return answer.toFixed(overflowValue);
    } else return answer.toFixed(length);
}

function power(x,y) {
	return x ** y;
}

function factorial(x) {
	if (x === 0) {return 1}
	return x * factorial(x-1);
}

function operator(operatorSign, x, y) {
    x = parseFloat(x);
    y = parseFloat(y);
    let tempFunction = window[operatorSign]; // access function using its string name from the current window
    return tempFunction(x,y); // properly returns result of operation
}

// Global variables
let overwriteFlag = 0; // used to flag whether to overwrite display 
let ans = 0;
let valueDisplayed1 = 0;
let valueDisplayed2 = 0;
let operatorValue; // var to store what operator will be used
let overflowValue = 12; // max number of characters in display

// DOM Selectors
const screen = document.querySelector('.screen');
const numbers = [...document.querySelectorAll('.number')]; // Array of the number buttons

// A. Numbers
numbers.forEach(function(item) {
    // add click event to numbers
    item.addEventListener('click', function() {
        displayNumber(this.textContent)});
    // add keypress event to window based on the numbers
    document.addEventListener('keydown', function(e) {
        if (e.keyCode == parseInt(item.getAttribute('data-key'))) {
            displayNumber(item.textContent);
        }
    })   
})

function displayNumber(num) {
    if (overwriteFlag == 0) { // overwrite display only if flag is 0
        screen.textContent = num;
        overwriteFlag++;
    } else {
        screen.textContent += num;
    };
    valueDisplayed1 = screen.textContent;
}

// B. Operators + - * / =
const operatorButtons = [...document.querySelectorAll('.operator')]; // array list of 4 operator buttons
const addBtn = document.querySelector('#add');
const subtractBtn = document.querySelector('#subtract');
const multiplyBtn = document.querySelector('#multiply');
const divideBtn = document.querySelector('#divide');
const equalsBtn = document.querySelector('#equals');

operatorButtons.forEach(function(item) {
    // add click event to operators
    item.addEventListener('click', function() {
        if (operatorValue) {equals()};
        overwriteFlag = 0; // reset flag
        operatorValue = item.getAttribute('id'); // Add operator value
        valueDisplayed2 = valueDisplayed1; // store first number in another variable
    })
});

equalsBtn.addEventListener('click', equals);
document.addEventListener('keypress', function(e) {
    if (e.keyCode == equalsBtn.getAttribute('data-key')) {
        equals();
    }
})

function equals() {
    if (!operatorValue) return;
    ans = operator(operatorValue, valueDisplayed2, valueDisplayed1); // valueDisplayed2 is 'x'
    overwriteFlag = 0; // reset flag
    screen.textContent = 0; // reset screen
    valueDisplayed1 = 0; // reset temp var
    valueDisplayed2 = 0; // reset temp var
    operatorValue = undefined; // reset operator value
    if (ans !== undefined) displayNumber(ans); // qd
}

// C. Others: DEL AC . EXP Ans
// i. DEL
const deleteBtn = document.querySelector('#delete');
deleteBtn.addEventListener('click', deleteANumber);

function deleteANumber() {
    screen.textContent = screen.textContent.slice(0,-1);
    valueDisplayed1 = screen.textContent;
}

// ii. AC
const allClearBtn = document.querySelector('#allClear');
allClearBtn.addEventListener('click', allClear);

function allClear() {
    screen.textContent = 0;
    overwriteFlag = 0;
    ans = 0;
    valueDisplayed1 = 0;
    valueDisplayed2 = 0;
    operatorValue = undefined;
}

// iii. .


/// iv. EXP


/// v. Ans