// let board = [
//   ["x", "0", "x"],
//   ["", "", ""],
//   ["", "", ""]
// ]

// function playRandom(board, mark) {
//   for(let i=0; i<board.length; i++) {
//     for(let j=0; j<board.length; j++) {
//       if(board[i][j] === "") {
//         board[i][j] = mark
//         return board
//       }
//     }
//   }
// }

//optimizations make check winning vert and horizontal in one function just switch i and j
// make both diagonals in one function just do arr[i][i] for left to right and arr[i][pos-i] for right to left where pos = 2
// if i return the empty pos from the winn function I can then take out block boolean and just place x or o in pos

// return tie before this function even runs if board is full
function playRandom(board, mark) {
  let notValid = true
  while(notValid) {
    let row = Math.floor(Math.random() * 3)
    let pos = Math.floor(Math.random() * 3)
    if(board[row][pos] === "") {
      notValid = false
      board[row][pos] = mark
      return board
    }
  }
}

function winningVert(board, mark, block) {
  for(let i=0; i<board.length; i++) {
    let counter = 0
    let row = board[i]
    for(let j=0; j<row.length; j++) {
      if(row[j] === mark) counter ++
      if(counter >= 2) {
        for(let k=0; k<row.length; k++) {
          if(row[k] === "") {
            if(block) {
              if(mark === "X") {
                mark = "O"
              } else {
                mark = "X"
              }
            }
            row[k] = mark
            return true
          }
        }
      }
    }
  }
}

function winningHorzi(board, mark, block) {
  for(let i=0; i<board.length; i++) {
    let counter = 0
    for(let j=0; j<board[i].length; j++) {
      if(board[j][i] === mark) counter ++
      if(counter >= 2) {
        for(let k=0; k<board[i].length; k++) {
          if(board[j][i] === "") {
            if(block) {
              if(mark === "X") {
                mark = "O"
              } else {
                mark = "X"
              }
            }
            board[j][i] = mark
            return true
          }
        }
      }
    }
  }
}

function diagonalRigthWinning(board, mark, block) {
  let counter = 0
  if(board[0][0] === mark) counter ++
  if(board[1][1] === mark) counter ++
  if(board[2][2] === mark) counter ++
  if (counter >= 2) {
    for(let i=0; i<board.length; i++) {
      if(board[i][i] === "") {
        if(block) {
          if(mark === "X") {
            mark = "O"
          } else {
            mark = "X"
          }
        }
        board[i][i] = mark
        return true
      }
    }
  }
}

function diagonalLefthWinning(board, mark, block) {
  let counter = 0
  if(board[0][2] === mark) counter ++
  if(board[1][1] === mark) counter ++
  if(board[2][0] === mark) counter ++
  if (counter >= 2) {
    if(board[0][2] === "") {
      if(block) {
        if(mark === "X") {
          mark = "O"
        } else {
          mark = "X"
        }
      }
      board[0][2] = mark
      return true
    }
    if(board[1][1] === "") {
      if(block) {
        if(mark === "X") {
          mark = "O"
        } else {
          mark = "X"
        }
      }
      board[1][1] = mark
      return true
        }
    if(board[2][0] === "") {
        if(block) {
        if(mark === "X") {
          mark = "O"
        } else {
          mark = "X"
        }
      }
      board[2][0] = mark
      return true
    }
  }
}

function playWinningMove(board, mark) {
  if(winningVert(board, mark, false)) return board
  if(winningHorzi(board, mark, false)) return board
  if(diagonalLefthWinning(board, mark, false)) return board
  if(diagonalRigthWinning(board, mark, false)) return board
}

function blockWinningMove(board, mark) {
  if(mark === "X") {
    mark = "O"
  } else {
    mark = "X"
  }
  if(winningVert(board, mark, true)) return board
  if(winningHorzi(board, mark, true)) return board
  if(diagonalLefthWinning(board, mark, true)) return board
  if(diagonalRigthWinning(board, mark, true)) return board
}

let board = [
  ["X", "O", "X"],
  ["", "X", "X"],
  ["", "", ""]
]
// console.log(playRandom(board, "X"))
// console.log(winningVert(board, "X"))
// console.log(winningHorzi(board, "X"))
// console.log(diagonalLefthWinning(board, "X"))
console.log(playWinningMove(board, "X", false))
// console.log(blockWinningMove(board, "O", true))
