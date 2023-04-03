; ModuleID = 'MS2_queue.c'
source_filename = "MS2_queue.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._node_t = type { i32, %struct._node_t* }
%struct._queue_t = type { %struct._node_t*, %struct._node_t*, i32, i32 }
%union.pthread_attr_t = type { i64, [48 x i8] }

@counter = dso_local global i64 0, align 8
@shared_nodes = dso_local global [10 x %struct._node_t] zeroinitializer, align 16
@queue = dso_local global %struct._queue_t zeroinitializer, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct._node_t* @new_node() #0 {
  %1 = alloca %struct._node_t*, align 8
  %2 = load i64, i64* @counter, align 8
  %3 = icmp ult i64 %2, 10
  br i1 %3, label %4, label %8

4:                                                ; preds = %0
  %5 = load i64, i64* @counter, align 8
  %6 = add i64 %5, 1
  store i64 %6, i64* @counter, align 8
  %7 = getelementptr inbounds %struct._node_t, %struct._node_t* getelementptr inbounds ([10 x %struct._node_t], [10 x %struct._node_t]* @shared_nodes, i64 0, i64 0), i64 %5
  store %struct._node_t* %7, %struct._node_t** %1, align 8
  br label %9

8:                                                ; preds = %0
  store %struct._node_t* null, %struct._node_t** %1, align 8
  br label %9

9:                                                ; preds = %8, %4
  %10 = load %struct._node_t*, %struct._node_t** %1, align 8
  ret %struct._node_t* %10
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @initialize(%struct._queue_t* %0) #0 {
  %2 = alloca %struct._queue_t*, align 8
  %3 = alloca %struct._node_t*, align 8
  store %struct._queue_t* %0, %struct._queue_t** %2, align 8
  %4 = call %struct._node_t* @new_node()
  store %struct._node_t* %4, %struct._node_t** %3, align 8
  %5 = load %struct._node_t*, %struct._node_t** %3, align 8
  %6 = getelementptr inbounds %struct._node_t, %struct._node_t* %5, i32 0, i32 1
  store %struct._node_t* null, %struct._node_t** %6, align 8
  %7 = load %struct._node_t*, %struct._node_t** %3, align 8
  %8 = load %struct._queue_t*, %struct._queue_t** %2, align 8
  %9 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %8, i32 0, i32 1
  store %struct._node_t* %7, %struct._node_t** %9, align 8
  %10 = load %struct._queue_t*, %struct._queue_t** %2, align 8
  %11 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %10, i32 0, i32 0
  store %struct._node_t* %7, %struct._node_t** %11, align 8
  %12 = load %struct._queue_t*, %struct._queue_t** %2, align 8
  %13 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %12, i32 0, i32 2
  %14 = call i32 @pthread_spin_init(i32* %13, i32 0) #2
  %15 = load %struct._queue_t*, %struct._queue_t** %2, align 8
  %16 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %15, i32 0, i32 3
  %17 = call i32 @pthread_spin_init(i32* %16, i32 0) #2
  ret void
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_spin_init(i32*, i32) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @enqueue(%struct._queue_t* %0, i32 %1) #0 {
  %3 = alloca %struct._queue_t*, align 8
  %4 = alloca i32, align 4
  %5 = alloca %struct._node_t*, align 8
  store %struct._queue_t* %0, %struct._queue_t** %3, align 8
  store i32 %1, i32* %4, align 4
  %6 = call %struct._node_t* @new_node()
  store %struct._node_t* %6, %struct._node_t** %5, align 8
  %7 = load i32, i32* %4, align 4
  %8 = load %struct._node_t*, %struct._node_t** %5, align 8
  %9 = getelementptr inbounds %struct._node_t, %struct._node_t* %8, i32 0, i32 0
  store i32 %7, i32* %9, align 8
  %10 = load %struct._node_t*, %struct._node_t** %5, align 8
  %11 = getelementptr inbounds %struct._node_t, %struct._node_t* %10, i32 0, i32 1
  store %struct._node_t* null, %struct._node_t** %11, align 8
  %12 = load %struct._queue_t*, %struct._queue_t** %3, align 8
  %13 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %12, i32 0, i32 3
  %14 = call i32 @pthread_spin_lock(i32* %13) #2
  %15 = load %struct._node_t*, %struct._node_t** %5, align 8
  %16 = load %struct._queue_t*, %struct._queue_t** %3, align 8
  %17 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %16, i32 0, i32 1
  %18 = load %struct._node_t*, %struct._node_t** %17, align 8
  %19 = getelementptr inbounds %struct._node_t, %struct._node_t* %18, i32 0, i32 1
  store %struct._node_t* %15, %struct._node_t** %19, align 8
  %20 = load %struct._node_t*, %struct._node_t** %5, align 8
  %21 = load %struct._queue_t*, %struct._queue_t** %3, align 8
  %22 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %21, i32 0, i32 1
  store %struct._node_t* %20, %struct._node_t** %22, align 8
  %23 = load %struct._queue_t*, %struct._queue_t** %3, align 8
  %24 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %23, i32 0, i32 3
  %25 = call i32 @pthread_spin_unlock(i32* %24) #2
  ret void
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_spin_lock(i32*) #1

; Function Attrs: nounwind
declare dso_local i32 @pthread_spin_unlock(i32*) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i1 @dequeue(%struct._queue_t* %0, i32* %1) #0 {
  %3 = alloca i1, align 1
  %4 = alloca %struct._queue_t*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca %struct._node_t*, align 8
  %7 = alloca %struct._node_t*, align 8
  store %struct._queue_t* %0, %struct._queue_t** %4, align 8
  store i32* %1, i32** %5, align 8
  %8 = load %struct._queue_t*, %struct._queue_t** %4, align 8
  %9 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %8, i32 0, i32 2
  %10 = call i32 @pthread_spin_lock(i32* %9) #2
  %11 = load %struct._queue_t*, %struct._queue_t** %4, align 8
  %12 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %11, i32 0, i32 0
  %13 = load %struct._node_t*, %struct._node_t** %12, align 8
  store %struct._node_t* %13, %struct._node_t** %6, align 8
  %14 = load %struct._node_t*, %struct._node_t** %6, align 8
  %15 = getelementptr inbounds %struct._node_t, %struct._node_t* %14, i32 0, i32 1
  %16 = load %struct._node_t*, %struct._node_t** %15, align 8
  store %struct._node_t* %16, %struct._node_t** %7, align 8
  %17 = load %struct._node_t*, %struct._node_t** %7, align 8
  %18 = icmp eq %struct._node_t* %17, null
  br i1 %18, label %19, label %23

19:                                               ; preds = %2
  %20 = load %struct._queue_t*, %struct._queue_t** %4, align 8
  %21 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %20, i32 0, i32 2
  %22 = call i32 @pthread_spin_unlock(i32* %21) #2
  store i1 false, i1* %3, align 1
  br label %36

23:                                               ; preds = %2
  %24 = load %struct._node_t*, %struct._node_t** %7, align 8
  %25 = getelementptr inbounds %struct._node_t, %struct._node_t* %24, i32 0, i32 0
  %26 = load i32, i32* %25, align 8
  %27 = load i32*, i32** %5, align 8
  store i32 %26, i32* %27, align 4
  %28 = load %struct._node_t*, %struct._node_t** %7, align 8
  %29 = load %struct._queue_t*, %struct._queue_t** %4, align 8
  %30 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %29, i32 0, i32 0
  store %struct._node_t* %28, %struct._node_t** %30, align 8
  %31 = load %struct._queue_t*, %struct._queue_t** %4, align 8
  %32 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %31, i32 0, i32 2
  %33 = call i32 @pthread_spin_unlock(i32* %32) #2
  %34 = load %struct._node_t*, %struct._node_t** %6, align 8
  %35 = bitcast %struct._node_t* %34 to i8*
  call void @free(i8* %35) #2
  store i1 true, i1* %3, align 1
  br label %36

36:                                               ; preds = %23, %19
  %37 = load i1, i1* %3, align 1
  ret i1 %37
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @leftThread(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 0, i32* %4, align 4
  br label %5

5:                                                ; preds = %11, %1
  %6 = load i32, i32* %4, align 4
  %7 = icmp slt i32 %6, 10
  br i1 %7, label %8, label %14

8:                                                ; preds = %5
  %9 = call i32 @rand() #2
  %10 = srem i32 %9, 2
  call void @enqueue(%struct._queue_t* @queue, i32 %10)
  br label %11

11:                                               ; preds = %8
  %12 = load i32, i32* %4, align 4
  %13 = add nsw i32 %12, 1
  store i32 %13, i32* %4, align 4
  br label %5, !llvm.loop !2

14:                                               ; preds = %5
  %15 = load i8*, i8** %2, align 8
  ret i8* %15
}

; Function Attrs: nounwind
declare dso_local i32 @rand() #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @rightThread(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i8, align 1
  store i8* %0, i8** %3, align 8
  store i32 0, i32* %4, align 4
  br label %7

7:                                                ; preds = %13, %1
  %8 = load i32, i32* %4, align 4
  %9 = icmp slt i32 %8, 10
  br i1 %9, label %10, label %16

10:                                               ; preds = %7
  store i32 0, i32* %5, align 4
  %11 = call zeroext i1 @dequeue(%struct._queue_t* @queue, i32* %5)
  %12 = zext i1 %11 to i8
  store i8 %12, i8* %6, align 1
  br label %13

13:                                               ; preds = %10
  %14 = load i32, i32* %4, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, i32* %4, align 4
  br label %7, !llvm.loop !4

16:                                               ; preds = %7
  %17 = load i8*, i8** %2, align 8
  ret i8* %17
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  store i32 0, i32* %1, align 4
  call void @initialize(%struct._queue_t* @queue)
  %3 = call i32 @pthread_create(i64* %2, %union.pthread_attr_t* null, i8* (i8*)* @leftThread, i8* null) #2
  %4 = call i8* @rightThread(i8* null)
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.5"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
!4 = distinct !{!4, !3}
