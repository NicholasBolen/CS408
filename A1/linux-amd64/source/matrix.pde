// Matrix multiplication functions from Danial Shiffman AKA The Coding Train on YouTube
// I do not claim these as my own work, and they are only used as 
// helper functions in place of importing a math library
// https://thecodingtrain.com/
// https://youtu.be/tzsgS19RRc8

float[][] vecToMatrix(PVector v) {
    float[][] m = new float[3][1];
    m[0][0] = v.x;
    m[1][0] = v.y;
    m[2][0] = v.z;
    return m;
}

PVector matrixToVec(float[][] m) {
    PVector v = new PVector();
    v.x = m[0][0];
    v.y = m[1][0];
    if (m.length > 2) {
        v.z = m[2][0];
    }
    return v;
}

float[][] matmul(float[][] a, PVector b) {
    float[][] m = vecToMatrix(b);
    return matmul(a,m);
}

float[][] matmul(float[][] a, float[][] b) {
    int colsA = a[0].length;
    int rowsA = a.length;
    int colsB = b[0].length;
    int rowsB = b.length;

    if (colsA != rowsB) {
        println("Columns of A must match rows of B");
        return null;
    }
    float result[][] = new float[rowsA][colsB];
    
    for (int i = 0; i < rowsA; i++) {
        for (int j = 0; j < colsB; j++) {
            float sum = 0;
            for (int k = 0; k < colsA; k++) {
                sum += a[i][k] * b[k][j];
            }
            result[i][j] = sum;
        }
    }
    return result;
}
