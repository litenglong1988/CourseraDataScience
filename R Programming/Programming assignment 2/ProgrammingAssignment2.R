## Caching the Inverse of a Matrix


## Write a short comment describing this function:
## The first function, makeCacheMatrix creates a special "matrix",
## which is really a list containing a function to 
# 1.set the value of the matrix
# 2.get the value of the matrix
# 3.set the value of the the Inverse of matrix
# 4.get the value of the the Inverse of matrix

makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setinverse <- function(solve) m <<- solve
    getinverse <- function() m
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
    
}


## Return a matrix that is the inverse of 'x':
## it first checks to see if the inverse has already been calculated
## If so, it gets the value from the cache and skips the computation
## Otherwise, it calculates the inverse of the data 
## and sets the value in the cache via the setinverse function


cacheSolve <- function(x, ...) {
    m <- x$getinverse()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setinverse(m)
    m
}

# a<-matrix(sample(25),5,5)
# solve(a)
# d<-makeCacheMatrix(a)
# cacheSolve(d)