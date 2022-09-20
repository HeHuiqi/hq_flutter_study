# hq_study

在 StatefulWidget 上调用 createState() 之后，框架将新的状态对象插入到树中，然后在状态对象上调用 initState()。 State 的子类可以重写 initState 来完成只需要发生一次的工作。例如，重写 initState 来配置动画或订阅平台服务。实现 initState 需要调用父类的 super.initState 方法来开始。

当不再需要状态对象时，框架会调用状态对象上的 dispose() 方法。可以重写dispose 方法来清理状态。例如，重写 dispose 以取消计时器或取消订阅平台服务。实现 dispose 时通常通过调用 super.dispose 来结束。


* 首先，上层 widget 向下层 widget 传递约束条件；
* 然后，下层 widget 向上层 widget 传递大小信息。
* 最后，上层 widget 决定下层 widget 的位置


* Widget 会通过它的 父级 获得自身的约束。约束实际上就是 4 个浮点类型的集合：最大/最小宽度，以及最大/最小高度。

* 然后，这个 widget 将会逐个遍历它的 children 列表。向子级传递 约束（子级之间的约束可能会有所不同），然后询问它的每一个子级需要用于布局的大小。

* 然后，这个 widget 就会对它子级的 children 逐个进行布局。（水平方向是 x 轴，竖直是 y 轴）

* 最后，widget 将会把它的大小信息向上传递至父 widget（包括其原始约束条件）

全局context解决方案
https://pub.dev/packages/one_context
https://pub.flutter-io.cn/packages/bot_toast