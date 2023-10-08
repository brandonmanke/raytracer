const std = @import("std");

const util = @import("util.zig");

const vector = @import("vector.zig");

const VectorType = struct { f64, f64, f64, vector.TupleType };

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    std.debug.print("VectorType {s}\n", .{@typeName(VectorType)});

    var v = VectorType{ 1.0, 1.0, 1.0, vector.TupleType.vector };
    std.debug.print("VectorType {d}\n", .{@intFromEnum(v[3])});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!

    //const is_equal = float_cmp(1.1231231, 1.123);
    const is_equal = util.floatCmp(f64, 1.0, 1.0);

    std.debug.print("1.0 == 1.0 ? {d}\n", .{@intFromBool(is_equal)});
}
