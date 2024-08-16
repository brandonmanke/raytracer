const std = @import("std");

const util = @import("util.zig");

const vector = @import("vector.zig");
const Point = vector.Point;
const Vector = vector.Vector;
const env = @import("environment.zig");
const Projectile = env.Projectile;
const Environment = env.Environment;

const VectorType = struct { f64, f64, f64, vector.TupleType };

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    std.debug.print("VectorType {s}\n", .{@typeName(VectorType)});

    const v = VectorType{ 1.0, 1.0, 1.0, vector.TupleType.vector };
    std.debug.print("VectorType {d}\n", .{@intFromEnum(v[3])});

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    //const is_equal = float_cmp(1.1231231, 1.123);
    const is_equal = util.floatCmp(f64, 1.0, 1.0);

    std.debug.print("1.0 == 1.0 ? {d}\n", .{@intFromBool(is_equal)});

    // tick test
    const p = Projectile{
        .position = Point(f64).init(0.0, 1.0, 0.0),
        .velocity = Vector(f64).init(1.0, 1.0, 0.0).normalize(),
    };

    const e = Environment{
        .gravity = vector.Vector(f64).init(0.0, 1.0, 0.0),
        .wind = vector.Vector(f64).init(1.0, 1.0, 0.0).normalize(),
    };

    try stdout.print("Env Test\n\n", .{});
    const proj2 = env.tick(e, p);
    try stdout.print("proj2.position.x = {d}\n", .{proj2.position.x});
    try stdout.print("proj2.position.y = {d}\n", .{proj2.position.y});
    try stdout.print("proj2.position.z = {d}\n", .{proj2.position.z});
    try stdout.print("proj2.velocity._type = {d}\n", .{@intFromEnum(proj2.velocity._type)});

    try bw.flush(); // don't forget to flush!
}
