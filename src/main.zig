const search = @import("search.zig");
const tools = @import("tools.zig");
const std = @import("std");

pub fn main() !void {
    std.debug.print("Search started\n", .{});
    search.search();
    std.debug.print("Search completed\n", .{});
}
