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
let overflowValue = 14; // max number of characters in display
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
    // overwrite display only if flag is 0; 
    // else check if infinity and return infinity
    // else concat on to it
    if (overwriteFlag == 0) { 
        screen.textContent = num;
        overwriteFlag++;
    } else if (screen.textContent.includes("Infinity")) {
        screen.textContent = "Infinity";
    } else screen.textContent += num;

    // convert big numbers to exponential to fit the display
    if (screen.textContent.length >= overflowValue) {
        screen.textContent = Number(screen.textContent).toExponential(overflowValue - 6);
    }
    
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
    valueDisplayed1 = ans; // store answer in first variable to allow continued equation after
    isFirstNumberStored = false; // reset variable to allow fresh equation to be input
    valueDisplayed2 = undefined; // reset second var
    operatorValue = undefined; // reset operator value
    overwriteFlag = 0; // reset flag
}

// C. Others: DEL AC . %
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
        if (overwriteFlag == 0) {
            displayNumber("0.");
        } else displayNumber(".");
    }
    return;
}

// iv. Percent %
const percentBtn = document.querySelector('#percent');
percentBtn.addEventListener('click', percentage);
document.addEventListener('keydown', function(e) {
    if (e.key == percentBtn.textContent) {
        percentBtn.focus(); // applies focus-visible pseudoclass
        percentage();
    }
})

function percentage() {
    // display percent in display
    if (!screen.textContent.includes('%')) {
        displayNumber('%');
        overwriteFlag = 0; // prevent additional characters
    }

    // simulate divison by 100
    if (isFirstNumberStored == false) { // transform 1st value to equivalent
        valueDisplayed1 = parseFloat(valueDisplayed1) / 100;
        overwriteflag = 0;
        operatorValue = 'divide';
        isFirstNumberStored = true;
        valueDisplayed2 = 1;
    } else {
        valueDisplayed2 = parseFloat(valueDisplayed2) / 100; // transform 2nd value to equivalent
    }
}