const tools = @import("tools.zig");

pub const cubeType = struct { orbitOne: u13 = 0, orbitTwo: u13 = 0, centers: [4]u1 = [4]u1{ 0, 0, 0, 0 } };

pub fn fMove(cube: cubeType) cubeType {
    var cubeCopy = cube;
    cubeCopy.centers[0] +%= 1;

    var pieces = tools.indexToPermutation(cube.orbitOne);
    const piecesCopy = pieces;
    pieces[0] = pieces[3];
    pieces[3] = piecesCopy[0];
    pieces[1] = pieces[2];
    pieces[2] = piecesCopy[1];
    cubeCopy.orbitOne = tools.permutationToIndex(pieces);

    pieces = tools.indexToPermutation(cube.orbitTwo);
    const pieceCopy = pieces[0];
    pieces[0] = pieces[1];
    pieces[1] = pieceCopy;
    cubeCopy.orbitTwo = tools.permutationToIndex(pieces);

    return cubeCopy;
}

pub fn lMove(cube: cubeType) cubeType {
    var cubeCopy = cube;
    cubeCopy.centers[1] +%= 1;

    var pieces = tools.indexToPermutation(cube.orbitOne);
    const pieceCopy = pieces[0];
    pieces[0] = pieces[6];
    pieces[6] = pieceCopy;
    cubeCopy.orbitOne = tools.permutationToIndex(pieces);

    pieces = tools.indexToPermutation(cube.orbitTwo);
    const piecesCopy = pieces;
    pieces[0] = pieces[4];
    pieces[4] = piecesCopy[0];
    pieces[5] = pieces[6];
    pieces[6] = piecesCopy[5];
    cubeCopy.orbitTwo = tools.permutationToIndex(pieces);

    return cubeCopy;
}

pub fn bMove(cube: cubeType) cubeType {
    var cubeCopy = cube;
    cubeCopy.centers[2] +%= 1;

    var pieces = tools.indexToPermutation(cube.orbitOne);
    const pieceCopy = pieces[5];
    pieces[5] = pieces[6];
    pieces[6] = pieceCopy;
    cubeCopy.orbitOne = tools.permutationToIndex(pieces);

    pieces = tools.indexToPermutation(cube.orbitTwo);
    const piecesCopy = pieces;
    pieces[2] = pieces[5];
    pieces[5] = piecesCopy[2];
    pieces[3] = pieces[4];
    pieces[4] = piecesCopy[3];
    cubeCopy.orbitTwo = tools.permutationToIndex(pieces);

    return cubeCopy;
}

pub fn rMove(cube: cubeType) cubeType {
    var cubeCopy = cube;
    cubeCopy.centers[3] +%= 1;

    var pieces = tools.indexToPermutation(cube.orbitOne);
    const piecesCopy = pieces;
    pieces[2] = pieces[5];
    pieces[5] = piecesCopy[2];
    pieces[3] = pieces[4];
    pieces[4] = piecesCopy[3];
    cubeCopy.orbitOne = tools.permutationToIndex(pieces);

    pieces = tools.indexToPermutation(cube.orbitTwo);
    const pieceCopy = pieces[1];
    pieces[1] = pieces[2];
    pieces[2] = pieceCopy;
    cubeCopy.orbitTwo = tools.permutationToIndex(pieces);

    return cubeCopy;
}
