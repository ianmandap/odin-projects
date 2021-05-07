// Operator functions
function add(x,y) {
    return parseInt(x)+parseInt(y);
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
    if (length > 14) {
        return answer.toFixed(14);
    } else return answer.toFixed(length);
}

function power(x,y) {
	return x ** y;
}

function factorial(x) {
	if (x === 0) {return 1}
	return x * factorial(x-1);
}

// Helper functions
function operator(operatorSign, x, y) {
    let tempFunction = window[operatorSign]; // access function using its string name from the current window
    return tempFunction(x,y); // properly returns result of operation
}

function clearAll() {
    ans = 0;
    valueDisplayed1 = 0;
    valueDisplayed2 = 0;
    operatorValue = undefined;

}

// Global variables
let ans = 0;
let valueDisplayed1 = 0;
let valueDisplayed2 = 0;
let operatorValue;

// DOM Selectors
const screen = document.querySelector('.screen');
const numbers = [...document.querySelectorAll('.number')]; // Array of the number buttons

numbers.forEach(function(item) {
    item.addEventListener('click', function() {
        displayNumber(this.textContent)});
})

function displayNumber(num) {
    console.log(valueDisplayed1, valueDisplayed2, ans);
    if (screen.textContent == 0 || operatorValue || ans) { //qd
        screen.textContent = num;
    } else {
        screen.textContent += num;
    };
    valueDisplayed1 = screen.textContent;
}

// Delete Button
const deleteBtn = document.querySelector('#delete');
deleteBtn.addEventListener('click', deleteANumber);

function deleteANumber() {
    screen.textContent = screen.textContent.slice(0,-1);
}

// AllClear Button
const allClearBtn = document.querySelector('#allClear');
allClearBtn.addEventListener('click', allClear);

function allClear() {
    screen.textContent = 0;
    ans = 0;
    valueDisplayed1 = 0;
    valueDisplayed2 = 0;
    operatorValue = undefined;
}

// Operator Buttons
const operatorButtons = [...document.querySelectorAll('.operator')]; // array list of 4 operator buttons
const addBtn = document.querySelector('#add');
const subtractBtn = document.querySelector('#subtract');
const multiplyBtn = document.querySelector('#multiply');
const divideBtn = document.querySelector('#divide');
const equalsBtn = document.querySelector('#equals');

operatorButtons.forEach(function(item) {
    item.addEventListener('click', function() {
        if (operatorValue) {equals()};
        operatorValue = item.getAttribute('id'); // Add operator value
        valueDisplayed2 = valueDisplayed1; // store first number in another variable
    })
})

equalsBtn.addEventListener('click', equals);

function equals() {
    if (!operatorValue) return;
    ans = operator(operatorValue, valueDisplayed2, valueDisplayed1); // valueDisplayed2 is 'x'
    screen.textContent = ""; // reset screen
    valueDisplayed1 = 0; // reset temp var
    valueDisplayed2 = 0; // reset temp var
    operatorValue = undefined; // reset operator value
    displayNumber(ans); // qd
}
