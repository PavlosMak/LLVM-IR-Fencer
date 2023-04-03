; ModuleID = 'FIFO_iWSQ.c'
source_filename = "FIFO_iWSQ.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.array_with_size_t = type { i32, i32* }
%union.pthread_attr_t = type { i64, [48 x i8] }

@counter = dso_local global i64 0, align 8
@counter_arrays = dso_local global i64 0, align 8
@shared_tasks = dso_local global [10 x i32] zeroinitializer, align 16
@shared_arrays = dso_local global [10 x %struct.array_with_size_t] zeroinitializer, align 16
@head = dso_local global i32 0, align 4
@tail = dso_local global i32 0, align 4
@tasks = dso_local global %struct.array_with_size_t* null, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32* @new_task_array(i32 %0) #0 {
  %2 = alloca i32*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  store i32 %0, i32* %3, align 4
  %5 = load i64, i64* @counter, align 8
  %6 = load i32, i32* %3, align 4
  %7 = sext i32 %6 to i64
  %8 = add i64 %5, %7
  %9 = icmp ult i64 %8, 10
  br i1 %9, label %10, label %18

10:                                               ; preds = %1
  %11 = load i64, i64* @counter, align 8
  store i64 %11, i64* %4, align 8
  %12 = load i32, i32* %3, align 4
  %13 = sext i32 %12 to i64
  %14 = load i64, i64* @counter, align 8
  %15 = add i64 %14, %13
  store i64 %15, i64* @counter, align 8
  %16 = load i64, i64* %4, align 8
  %17 = getelementptr inbounds i32, i32* getelementptr inbounds ([10 x i32], [10 x i32]* @shared_tasks, i64 0, i64 0), i64 %16
  store i32* %17, i32** %2, align 8
  br label %19

18:                                               ; preds = %1
  store i32* null, i32** %2, align 8
  br label %19

19:                                               ; preds = %18, %10
  %20 = load i32*, i32** %2, align 8
  ret i32* %20
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.array_with_size_t* @new_array_with_size() #0 {
  %1 = alloca %struct.array_with_size_t*, align 8
  %2 = load i64, i64* @counter, align 8
  %3 = icmp ult i64 %2, 10
  br i1 %3, label %4, label %8

4:                                                ; preds = %0
  %5 = load i64, i64* @counter_arrays, align 8
  %6 = add i64 %5, 1
  store i64 %6, i64* @counter_arrays, align 8
  %7 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* getelementptr inbounds ([10 x %struct.array_with_size_t], [10 x %struct.array_with_size_t]* @shared_arrays, i64 0, i64 0), i64 %5
  store %struct.array_with_size_t* %7, %struct.array_with_size_t** %1, align 8
  br label %9

8:                                                ; preds = %0
  store %struct.array_with_size_t* null, %struct.array_with_size_t** %1, align 8
  br label %9

9:                                                ; preds = %8, %4
  %10 = load %struct.array_with_size_t*, %struct.array_with_size_t** %1, align 8
  ret %struct.array_with_size_t* %10
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @FifoIwsq(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  store i32 0, i32* @head, align 4
  store i32 0, i32* @tail, align 4
  %3 = call %struct.array_with_size_t* @new_array_with_size()
  store %struct.array_with_size_t* %3, %struct.array_with_size_t** @tasks, align 8
  %4 = load i32, i32* %2, align 4
  %5 = call i32* @new_task_array(i32 %4)
  %6 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %7 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %6, i32 0, i32 1
  store i32* %5, i32** %7, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i1 @CAS(i32* %0, i32 %1, i32 %2) #0 {
  %4 = alloca i32*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i8, align 1
  store i32* %0, i32** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %8 = load i32*, i32** %4, align 8
  %9 = load i32, i32* %8, align 4
  %10 = load i32, i32* %5, align 4
  %11 = icmp eq i32 %9, %10
  %12 = zext i1 %11 to i8
  store i8 %12, i8* %7, align 1
  %13 = load i8, i8* %7, align 1
  %14 = trunc i8 %13 to i1
  br i1 %14, label %15, label %18

15:                                               ; preds = %3
  %16 = load i32, i32* %6, align 4
  %17 = load i32*, i32** %4, align 8
  store i32 %16, i32* %17, align 4
  br label %18

18:                                               ; preds = %15, %3
  %19 = load i8, i8* %7, align 1
  %20 = trunc i8 %19 to i1
  ret i1 %20
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @expand() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.array_with_size_t*, align 8
  %3 = alloca i32, align 4
  %4 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %5 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %4, i32 0, i32 0
  %6 = load i32, i32* %5, align 8
  store i32 %6, i32* %1, align 4
  %7 = call %struct.array_with_size_t* @new_array_with_size()
  store %struct.array_with_size_t* %7, %struct.array_with_size_t** %2, align 8
  %8 = load i32, i32* %1, align 4
  %9 = mul nsw i32 %8, 2
  %10 = call i32* @new_task_array(i32 %9)
  %11 = load %struct.array_with_size_t*, %struct.array_with_size_t** %2, align 8
  %12 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %11, i32 0, i32 1
  store i32* %10, i32** %12, align 8
  %13 = load i32, i32* %1, align 4
  %14 = mul nsw i32 2, %13
  %15 = load %struct.array_with_size_t*, %struct.array_with_size_t** %2, align 8
  %16 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %15, i32 0, i32 0
  store i32 %14, i32* %16, align 8
  %17 = load i32, i32* @head, align 4
  store i32 %17, i32* %3, align 4
  br label %18

18:                                               ; preds = %44, %0
  %19 = load i32, i32* %3, align 4
  %20 = load i32, i32* @tail, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %47

22:                                               ; preds = %18
  %23 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %24 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %23, i32 0, i32 1
  %25 = load i32*, i32** %24, align 8
  %26 = load i32, i32* %3, align 4
  %27 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %28 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %27, i32 0, i32 0
  %29 = load i32, i32* %28, align 8
  %30 = srem i32 %26, %29
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds i32, i32* %25, i64 %31
  %33 = load i32, i32* %32, align 4
  %34 = load %struct.array_with_size_t*, %struct.array_with_size_t** %2, align 8
  %35 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %34, i32 0, i32 1
  %36 = load i32*, i32** %35, align 8
  %37 = load i32, i32* %3, align 4
  %38 = load %struct.array_with_size_t*, %struct.array_with_size_t** %2, align 8
  %39 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %38, i32 0, i32 0
  %40 = load i32, i32* %39, align 8
  %41 = srem i32 %37, %40
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds i32, i32* %36, i64 %42
  store i32 %33, i32* %43, align 4
  br label %44

44:                                               ; preds = %22
  %45 = load i32, i32* %3, align 4
  %46 = add nsw i32 %45, 1
  store i32 %46, i32* %3, align 4
  br label %18, !llvm.loop !2

47:                                               ; preds = %18
  %48 = load %struct.array_with_size_t*, %struct.array_with_size_t** %2, align 8
  store %struct.array_with_size_t* %48, %struct.array_with_size_t** @tasks, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @put(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  br label %5

5:                                                ; preds = %15, %1
  %6 = load i32, i32* @head, align 4
  store i32 %6, i32* %3, align 4
  %7 = load i32, i32* @tail, align 4
  store i32 %7, i32* %4, align 4
  %8 = load i32, i32* %4, align 4
  %9 = load i32, i32* %3, align 4
  %10 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %11 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %10, i32 0, i32 0
  %12 = load i32, i32* %11, align 8
  %13 = add nsw i32 %9, %12
  %14 = icmp eq i32 %8, %13
  br i1 %14, label %15, label %16

15:                                               ; preds = %5
  call void @expand()
  br label %5

16:                                               ; preds = %5
  %17 = load i32, i32* %2, align 4
  %18 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %19 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %18, i32 0, i32 1
  %20 = load i32*, i32** %19, align 8
  %21 = load i32, i32* %4, align 4
  %22 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %23 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %22, i32 0, i32 0
  %24 = load i32, i32* %23, align 8
  %25 = srem i32 %21, %24
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds i32, i32* %20, i64 %26
  store i32 %17, i32* %27, align 4
  %28 = load i32, i32* %4, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, i32* @tail, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @take() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = load i32, i32* @head, align 4
  store i32 %5, i32* %2, align 4
  %6 = load i32, i32* @tail, align 4
  store i32 %6, i32* %3, align 4
  %7 = load i32, i32* %2, align 4
  %8 = load i32, i32* %3, align 4
  %9 = icmp eq i32 %7, %8
  br i1 %9, label %10, label %11

10:                                               ; preds = %0
  store i32 -1, i32* %1, align 4
  br label %26

11:                                               ; preds = %0
  %12 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %13 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %12, i32 0, i32 1
  %14 = load i32*, i32** %13, align 8
  %15 = load i32, i32* %2, align 4
  %16 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %17 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 8
  %19 = srem i32 %15, %18
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds i32, i32* %14, i64 %20
  %22 = load i32, i32* %21, align 4
  store i32 %22, i32* %4, align 4
  %23 = load i32, i32* %2, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, i32* @head, align 4
  %25 = load i32, i32* %4, align 4
  store i32 %25, i32* %1, align 4
  br label %26

26:                                               ; preds = %11, %10
  %27 = load i32, i32* %1, align 4
  ret i32 %27
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @steal() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca %struct.array_with_size_t*, align 8
  %5 = alloca i32, align 4
  br label %6

6:                                                ; preds = %30, %0
  %7 = load i32, i32* @head, align 4
  store i32 %7, i32* %2, align 4
  %8 = load i32, i32* @tail, align 4
  store i32 %8, i32* %3, align 4
  %9 = load i32, i32* %2, align 4
  %10 = load i32, i32* %3, align 4
  %11 = icmp eq i32 %9, %10
  br i1 %11, label %12, label %13

12:                                               ; preds = %6
  store i32 -1, i32* %1, align 4
  br label %33

13:                                               ; preds = %6
  %14 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  store %struct.array_with_size_t* %14, %struct.array_with_size_t** %4, align 8
  %15 = load %struct.array_with_size_t*, %struct.array_with_size_t** %4, align 8
  %16 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %15, i32 0, i32 1
  %17 = load i32*, i32** %16, align 8
  %18 = load i32, i32* %2, align 4
  %19 = load %struct.array_with_size_t*, %struct.array_with_size_t** %4, align 8
  %20 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 8
  %22 = srem i32 %18, %21
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds i32, i32* %17, i64 %23
  %25 = load i32, i32* %24, align 4
  store i32 %25, i32* %5, align 4
  %26 = load i32, i32* %2, align 4
  %27 = load i32, i32* %2, align 4
  %28 = add nsw i32 %27, 1
  %29 = call zeroext i1 @CAS(i32* @head, i32 %26, i32 %28)
  br i1 %29, label %31, label %30

30:                                               ; preds = %13
  br label %6

31:                                               ; preds = %13
  %32 = load i32, i32* %5, align 4
  store i32 %32, i32* %1, align 4
  br label %33

33:                                               ; preds = %31, %12
  %34 = load i32, i32* %1, align 4
  ret i32 %34
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @owner(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 0, i32* %4, align 4
  br label %5

5:                                                ; preds = %18, %1
  %6 = load i32, i32* %4, align 4
  %7 = icmp slt i32 %6, 10
  br i1 %7, label %8, label %21

8:                                                ; preds = %5
  %9 = call i32 @rand() #2
  %10 = srem i32 %9, 2
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %14

12:                                               ; preds = %8
  %13 = call i32 @take()
  br label %17

14:                                               ; preds = %8
  %15 = call i32 @rand() #2
  %16 = srem i32 %15, 2
  call void @put(i32 %16)
  br label %17

17:                                               ; preds = %14, %12
  br label %18

18:                                               ; preds = %17
  %19 = load i32, i32* %4, align 4
  %20 = add nsw i32 %19, 1
  store i32 %20, i32* %4, align 4
  br label %5, !llvm.loop !4

21:                                               ; preds = %5
  %22 = load i8*, i8** %2, align 8
  ret i8* %22
}

; Function Attrs: nounwind
declare dso_local i32 @rand() #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @thief(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 0, i32* %4, align 4
  br label %5

5:                                                ; preds = %10, %1
  %6 = load i32, i32* %4, align 4
  %7 = icmp slt i32 %6, 10
  br i1 %7, label %8, label %13

8:                                                ; preds = %5
  %9 = call i32 @steal()
  br label %10

10:                                               ; preds = %8
  %11 = load i32, i32* %4, align 4
  %12 = add nsw i32 %11, 1
  store i32 %12, i32* %4, align 4
  br label %5, !llvm.loop !5

13:                                               ; preds = %5
  %14 = load i8*, i8** %2, align 8
  ret i8* %14
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  store i32 0, i32* %1, align 4
  call void @FifoIwsq(i32 10)
  %3 = call i32 @pthread_create(i64* %2, %union.pthread_attr_t* null, i8* (i8*)* @owner, i8* null) #2
  %4 = call i8* @thief(i8* null)
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
!5 = distinct !{!5, !3}
