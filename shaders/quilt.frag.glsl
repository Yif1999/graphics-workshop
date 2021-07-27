precision mediump float;

uniform vec2 resolution;
uniform float time;
uniform float seed;

void main() {
    // 屏幕坐标归一化
    vec2 coord = gl_FragCoord.xy / resolution;

    // Output RGB color in range from 0.0 to 1.0
    // color对应RGB三分量
    vec3 color = vec3(coord.x,coord.y,0.0);
    // +=实际上就是=，因为color.z的初始值为0.0，每一帧都重新计算，而非不断叠加
    color.z += abs(sin(time));

    // 1. Uncomment these lines to draw triangles
    // 定义每个小方块的坐标与动态模式
    vec2 squareCoord = 20.0 * gl_FragCoord.xy / resolution.x - vec2(time,time/2.0);
    // 截取小数部分
    vec2 loc = fract(squareCoord);
    // 生成阶梯过渡
    color = vec3(smoothstep(-0.05, 0.05, loc.y - loc.x));

    // 2. Uncomment these lines to invert some of the triangles
    // 获取每一块方块的块坐标
    vec2 cell = squareCoord - loc;
    // 满足条件的块进行反相操作
    if (mod(float(int(10.0*seed)) * cell.x + cell.y, 5.0) == 1.0) {
        color = 1.0 - color;
    }

    // 3. Uncomment these lines to produce interesting colors
    // 生成色值
    float c = mod(3.0 * cell.x + 1.0 * cell.y, 7.0) / 7.0;
    vec3 cd = vec3 (sin(loc.x),sin(loc.y),0.0);
    // 颜色重新赋值
    // color = 1.0 - (1.0 - color) * vec3(c, c, c);
    color = 1.0 - (1.0 - color) * cd;

    // 4. Uncomment to lighten the colors
    color = sqrt (color);

    gl_FragColor = vec4(color, 1.0);
}
