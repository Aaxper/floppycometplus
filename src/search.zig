const cubes = @import("cubes.zig");
const tools = @import("tools.zig");
const state_map = @import("state_map.zig");
const std = @import("std");

pub fn search() void {
    const map = state_map.new();
    _ = state_map.update(map, 0);

    std.debug.print("depth | new positions | total positions\n", .{});

    var depth: usize = 0;
    var total: usize = 1;
    var new: usize = 1;
    while (new != 0) {
        state_map.next();
        depth += 1;
        new = 0;
        for (0..map.*.len) |i| {
            const state: state_map.States = @enumFromInt(map.*[i]);
            if (state.isCurrent()) {
                if (state_map.update(map, tools.cubeToIndex(cubes.fMove(tools.indexToCube(i))))) new += 1;
                if (state_map.update(map, tools.cubeToIndex(cubes.lMove(tools.indexToCube(i))))) new += 1;
                if (state_map.update(map, tools.cubeToIndex(cubes.bMove(tools.indexToCube(i))))) new += 1;
                if (state_map.update(map, tools.cubeToIndex(cubes.rMove(tools.indexToCube(i))))) new += 1;
                map.*[i] = @intFromEnum(state_map.States.old);
            }
        }

        total += new;
        if (new > 0) std.debug.print("{} | {} | {}\n", .{ depth, new, total });
    }
}
