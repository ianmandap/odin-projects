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
let valueDisplayed2;
let operatorValue; // var to store what operator will be used
let overflowValue = 13; // max number of characters in display
let isFirstNumberStored = false;

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
        if (e.key == item.textContent) {
            item.focus(); // applies focus-visible pseudoclass
            displayNumber(item.textContent);
        }
    })   
})

function displayNumber(num) {
    if (valueDisplayed1.length > overflowValue) return;

    // overwrite display only if flag is 0; else add on to it
    if (overwriteFlag == 0) { 
        screen.textContent = num;
        overwriteFlag++;
    } else {
        screen.textContent += num;
    };
    
    // store value in variable
    if (!isFirstNumberStored) {
        valueDisplayed1 = screen.textContent;
    } else valueDisplayed2 = screen.textContent;
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
        isFirstNumberStored = true;
    })
    // add keypress event to operators
    document.addEventListener('keypress', function(e) {
        if (e.key == item.value || e.key == item.textContent) {
            item.focus();
            if (operatorValue) {equals()};
            overwriteFlag = 0; // reset flag
            operatorValue = item.getAttribute('id'); // Add operator value
            isFirstNumberStored = true;
        }
    })
});

equalsBtn.addEventListener('click', equals);
document.addEventListener('keypress', function(e) {
    if (e.key == equalsBtn.textContent) {
        equalsBtn.focus();
        equals();
    }
})

function equals() {
    if (!valueDisplayed2) return; // prevents calc with no input of 2nd number
    if (!operatorValue) return; // prevents calc with no input of operator
    ans = operator(operatorValue, valueDisplayed1, valueDisplayed2);
    screen.textContent = ""; // Reset screen to none so display can add on to it
    if (ans !== undefined) displayNumber(ans);
    valueDisplayed1 = ans; // store answer in first variable
    isFirstNumberStored = true;
    valueDisplayed2 = undefined; // reset second var
    operatorValue = undefined; // reset operator value
    overwriteFlag = 0; // reset flag
}

// C. Others: DEL AC . Ans
// i. DEL
const deleteBtn = document.querySelector('#delete');
deleteBtn.addEventListener('click', deleteANumber);
document.addEventListener('keydown', function(e) {
    if (e.key == "Backspace") {
        deleteBtn.focus(); // applies focus-visible pseudoclass
        deleteANumber();
    }
})

function deleteANumber() {
    screen.textContent = screen.textContent.slice(0,-1);
    valueDisplayed1 = screen.textContent;
}

// ii. AC
const allClearBtn = document.querySelector('#allClear');
allClearBtn.addEventListener('click', allClear);
document.addEventListener('keydown', function(e) {
    if (e.key == "Escape") {
        allClearBtn.focus(); // applies focus-visible pseudoclass
        allClear();
    }
})

function allClear() {
    screen.textContent = 0;
    overwriteFlag = 0;
    ans = 0;
    valueDisplayed1 = 0;
    valueDisplayed2 = undefined;
    operatorValue = undefined;
    isFirstNumberStored = false;
}

// iii. . (Decimal)
const decimalBtn = document.querySelector('.decimal');
decimalBtn.addEventListener('click', decimalPoint);
document.addEventListener('keydown', function(e) {
    if (e.key == decimalBtn.textContent) {
        decimalBtn.focus(); // applies focus-visible pseudoclass
        decimalPoint();
    }
})

function decimalPoint() {
    if (!screen.textContent.includes(".")) {
        displayNumber(".");
    }
    return;
}

/// iv. Ans