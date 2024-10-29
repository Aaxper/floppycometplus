var gpa = @import("std").heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

pub const States = enum(u2) {
    var isSwitched = false;
    not_found = 0,
    new = 1,
    current = 2,
    old = 3,
    pub fn isCurrent(self: States) bool {
        return (!isSwitched and self == States.current) or (isSwitched and self == States.new);
    }
};

const StateMap = [5040 * 5040 * 16]u2;

pub fn new() *StateMap {
    const map = allocator.create([5040 * 5040 * 16]u2) catch @panic("Allocation failed");
    @memset(map, 0);
    return map;
}

pub fn get(map: *StateMap, index: usize) States {
    return States[map.*[index]];
}

pub fn update(map: *StateMap, index: usize) bool {
    const not_found = map.*[index] == @intFromEnum(States.not_found);
    if (not_found) {
        if (States.isSwitched) {
            map.*[index] = @intFromEnum(States.current);
        } else {
            map.*[index] = @intFromEnum(States.new);
        }
    }
    return not_found;
}

pub fn visit(map: *StateMap, index: usize) void {
    map.*[index] = States.old;
}

pub fn next() void {
    States.isSwitched = !States.isSwitched;
}

pub fn free(map: *StateMap) void {
    allocator.free(map.*);
}
