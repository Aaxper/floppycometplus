const cubes = @import("cubes.zig");

pub fn permutationToIndex(permutation: [7]u3) u13 {
    var index: u13 = 0;

    var available = [7]bool{ true, true, true, true, true, true, true };
    var factor: u13 = 5040;

    for (0..7) |i| {
        factor /= @intCast(7 - i);

        var count: u3 = 0;
        for (0..permutation[i]) |j| {
            if (available[j]) count += 1;
        }

        index += count * factor;
        available[permutation[i]] = false;
    }

    return index;
}

pub fn indexToPermutation(_index: u13) [7]u3 {
    var index = _index;
    var permutation = [7]u3{ 0, 0, 0, 0, 0, 0, 0 };

    var available = [7]bool{ true, true, true, true, true, true, true };
    var factor: u13 = 5040;

    for (0..7) |i| {
        factor /= @intCast(7 - i);
        const count = index / factor;
        index %= factor;

        var j: u3 = 0;
        var k: isize = -1;
        while (true) {
            if (available[j]) k += 1;
            if (k == count) break;
            j += 1;
        }

        permutation[i] = j;
        available[j] = false;
    }

    return permutation;
}

pub fn cubeToIndex(cube: cubes.cubeType) usize {
    const centers = @as(usize, cube.centers[3]) * 8 + @as(usize, cube.centers[2]) * 4 + @as(usize, cube.centers[1]) * 2 + @as(usize, cube.centers[0]);
    return centers * 5040 * 5040 + @as(usize, cube.orbitOne) * 5040 + @as(usize, cube.orbitTwo);
}

pub fn indexToCube(index: usize) cubes.cubeType {
    const centers: u4 = @intCast(index / (5040 * 5040));

    return cubes.cubeType{
        .orbitOne = @intCast((index / 5040) % 5040),
        .orbitTwo = @intCast(index % 5040),
        .centers = [4]u1{
            @intCast(centers % 2),
            @intCast((centers / 2) % 2),
            @intCast((centers / 4) % 2),
            @intCast((centers / 8) % 2),
        },
    };
}
