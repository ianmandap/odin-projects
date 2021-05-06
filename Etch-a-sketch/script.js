window.onload = function() {
    changeGrid(16);
    hoverBlack();
};

// DOM SELECTORS
const gridContainer = document.querySelector('#grid-container');
const grid = document.querySelector('#grid');
const sizeButton = document.querySelector('#size');
const sizeInput = document.querySelector('#size-input');
const blackBtn = document.querySelector('#black');
const whiteBtn = document.querySelector('#white');
const rgbBtn = document.querySelector('#rgb');
const darkenBtn = document.querySelector('#darken');
const lightenBtn = document.querySelector('#lighten');
const clearBtn = document.querySelector('#clear');

// Grid Size Button
sizeButton.addEventListener('click', () => {
    sizeInput.focus();
})

// Change Grid Size
sizeInput.addEventListener('keydown', function(e) {
    if (e.keyCode === 13) {
        if (this.value > 64) {
            e.preventDefault();
        } else changeGrid(this.value);
    }
});

function changeGrid(num) {
    grid.innerHTML = createDivs(num);
    grid.setAttribute("style", "grid-template-columns: repeat(" + num + ", 1fr);"); 
}

function createDivs(num) {
    var sq = num*num;
    var divHTML = "";
    for (let i = 0; i < sq; i++) {divHTML += `<div class="grid-item" 
                                                   style="background-color: rgb(255,255,255);"></div>`};
    return divHTML;
};

// Hover Buttons
blackBtn.addEventListener('click', hoverBlack);
whiteBtn.addEventListener('click', hoverWhite);
rgbBtn.addEventListener('click', hoverRGB);
darkenBtn.addEventListener('click', hoverDarken);
lightenBtn.addEventListener('click', hoverLighten);
clearBtn.addEventListener('click', clear);

// Grid Item Hover Functions
function hoverBlack() {
    // add onhover per item
    var gridNodeList = document.querySelectorAll('.grid-item');
    for (let i =0; i < gridNodeList.length; i++) {
        gridNodeList[i].onmouseover = function() {
            this.setAttribute("style", "background-color: rgb( 0, 0, 0)");
        }
    }
}

function hoverRGB() {
    // add onhover per item
    var gridNodeList = document.querySelectorAll('.grid-item');
    for (let i =0; i < gridNodeList.length; i++) {
        gridNodeList[i].onmouseover = function() {
            var R = randNum();
            var G = randNum();
            var B = randNum();
            this.setAttribute("style", "background-color: rgb( " + R + ", " + G + ", " + B + ");");
        }
    }
}

function hoverWhite() {
    // add onhover per item
    var gridNodeList = document.querySelectorAll('.grid-item');
    for (let i =0; i < gridNodeList.length; i++) {
        gridNodeList[i].onmouseover = function() {
            this.setAttribute("style", "background-color: rgb( 255, 255, 255");
        }
    }
}

function hoverDarken() {
    // add onhover per item
    var gridNodeList = document.querySelectorAll('.grid-item');
    for (let i =0; i < gridNodeList.length; i++) {
        gridNodeList[i].onmouseover = function() {
            var style = getComputedStyle(gridNodeList[i]);
            var bg = style['background-color'];
            bg = bg.replace('rgb(',"");
            var rgb = bg.split(',');
            var r = parseInt(rgb[0])-26;
            var g = parseInt(rgb[1])-26;
            var b = parseInt(rgb[2])-26;
            this.setAttribute("style", "background-color: rgb( " + r + ", " + g + ", " + b + ");");
        }
    }
}

function hoverLighten() {
    // add onhover per item
    var gridNodeList = document.querySelectorAll('.grid-item');
    for (let i =0; i < gridNodeList.length; i++) {
        gridNodeList[i].onmouseover = function() {
            var style = getComputedStyle(gridNodeList[i]);
            var bg = style['background-color'];
            bg = bg.replace('rgb(',"");
            var rgb = bg.split(',');
            var r = parseInt(rgb[0])+26;
            var g = parseInt(rgb[1])+26;
            var b = parseInt(rgb[2])+26;
            this.setAttribute("style", "background-color: rgb( " + r + ", " + g + ", " + b + ");");
        }
    }
}

function clear() {
    var gridNodeList = document.querySelectorAll('.grid-item');
    for (let i =0; i < gridNodeList.length; i++) {
        gridNodeList[i].setAttribute("style", "background-color: rgb( 255, 255, 255");
    }
}


function randNum() {
    // generate random number from 0 to 255
    return Math.floor((Math.random()*256));
}