; ModuleID = 'LIFO_iWSQ.c'
source_filename = "LIFO_iWSQ.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.anchor_t = type { i32, i32 }
%union.pthread_attr_t = type { i64, [48 x i8] }

@counter = dso_local global i64 0, align 8
@shared_tasks = dso_local global [10 x i32] zeroinitializer, align 16
@anchor = dso_local global %struct.anchor_t zeroinitializer, align 4
@capacity = dso_local global i32 0, align 4
@tasks = dso_local global i32* null, align 8

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
define dso_local void @LifoIwsq(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  store i32 0, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 0), align 4
  store i32 0, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 1), align 4
  %3 = load i32, i32* %2, align 4
  store i32 %3, i32* @capacity, align 4
  %4 = load i32, i32* %2, align 4
  %5 = call i32* @new_task_array(i32 %4)
  store i32* %5, i32** @tasks, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i1 @CAS(%struct.anchor_t* %0, i32 %1, i32 %2, i32 %3, i32 %4) #0 {
  %6 = alloca %struct.anchor_t*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i8, align 1
  store %struct.anchor_t* %0, %struct.anchor_t** %6, align 8
  store i32 %1, i32* %7, align 4
  store i32 %2, i32* %8, align 4
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  %12 = load %struct.anchor_t*, %struct.anchor_t** %6, align 8
  %13 = getelementptr inbounds %struct.anchor_t, %struct.anchor_t* %12, i32 0, i32 0
  %14 = load i32, i32* %13, align 4
  %15 = load i32, i32* %7, align 4
  %16 = icmp eq i32 %14, %15
  br i1 %16, label %17, label %23

17:                                               ; preds = %5
  %18 = load %struct.anchor_t*, %struct.anchor_t** %6, align 8
  %19 = getelementptr inbounds %struct.anchor_t, %struct.anchor_t* %18, i32 0, i32 1
  %20 = load i32, i32* %19, align 4
  %21 = load i32, i32* %8, align 4
  %22 = icmp eq i32 %20, %21
  br label %23

23:                                               ; preds = %17, %5
  %24 = phi i1 [ false, %5 ], [ %22, %17 ]
  %25 = zext i1 %24 to i8
  store i8 %25, i8* %11, align 1
  %26 = load i8, i8* %11, align 1
  %27 = trunc i8 %26 to i1
  br i1 %27, label %28, label %35

28:                                               ; preds = %23
  %29 = load i32, i32* %9, align 4
  %30 = load %struct.anchor_t*, %struct.anchor_t** %6, align 8
  %31 = getelementptr inbounds %struct.anchor_t, %struct.anchor_t* %30, i32 0, i32 0
  store i32 %29, i32* %31, align 4
  %32 = load i32, i32* %10, align 4
  %33 = load %struct.anchor_t*, %struct.anchor_t** %6, align 8
  %34 = getelementptr inbounds %struct.anchor_t, %struct.anchor_t* %33, i32 0, i32 1
  store i32 %32, i32* %34, align 4
  br label %35

35:                                               ; preds = %28, %23
  %36 = load i8, i8* %11, align 1
  %37 = trunc i8 %36 to i1
  ret i1 %37
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @expand() #0 {
  %1 = alloca i32*, align 8
  %2 = alloca i32, align 4
  %3 = load i32, i32* @capacity, align 4
  %4 = call i32* @new_task_array(i32 %3)
  store i32* %4, i32** %1, align 8
  store i32 0, i32* %2, align 4
  br label %5

5:                                                ; preds = %19, %0
  %6 = load i32, i32* %2, align 4
  %7 = load i32, i32* @capacity, align 4
  %8 = icmp slt i32 %6, %7
  br i1 %8, label %9, label %22

9:                                                ; preds = %5
  %10 = load i32*, i32** @tasks, align 8
  %11 = load i32, i32* %2, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds i32, i32* %10, i64 %12
  %14 = load i32, i32* %13, align 4
  %15 = load i32*, i32** %1, align 8
  %16 = load i32, i32* %2, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds i32, i32* %15, i64 %17
  store i32 %14, i32* %18, align 4
  br label %19

19:                                               ; preds = %9
  %20 = load i32, i32* %2, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, i32* %2, align 4
  br label %5, !llvm.loop !2

22:                                               ; preds = %5
  %23 = load i32*, i32** %1, align 8
  store i32* %23, i32** @tasks, align 8
  %24 = load i32, i32* @capacity, align 4
  %25 = mul nsw i32 %24, 2
  store i32 %25, i32* @capacity, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @put(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  br label %5

5:                                                ; preds = %11, %1
  %6 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 0), align 4
  store i32 %6, i32* %3, align 4
  %7 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 1), align 4
  store i32 %7, i32* %4, align 4
  %8 = load i32, i32* %3, align 4
  %9 = load i32, i32* @capacity, align 4
  %10 = icmp eq i32 %8, %9
  br i1 %10, label %11, label %12

11:                                               ; preds = %5
  call void @expand()
  br label %5

12:                                               ; preds = %5
  %13 = load i32, i32* %2, align 4
  %14 = load i32*, i32** @tasks, align 8
  %15 = load i32, i32* %3, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds i32, i32* %14, i64 %16
  store i32 %13, i32* %17, align 4
  %18 = load i32, i32* %3, align 4
  %19 = add nsw i32 %18, 1
  store i32 %19, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 0), align 4
  %20 = load i32, i32* %4, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 1), align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @take() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 0), align 4
  store i32 %5, i32* %2, align 4
  %6 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 1), align 4
  store i32 %6, i32* %3, align 4
  %7 = load i32, i32* %2, align 4
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %10

9:                                                ; preds = %0
  store i32 -1, i32* %1, align 4
  br label %21

10:                                               ; preds = %0
  %11 = load i32*, i32** @tasks, align 8
  %12 = load i32, i32* %2, align 4
  %13 = sub nsw i32 %12, 1
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds i32, i32* %11, i64 %14
  %16 = load i32, i32* %15, align 4
  store i32 %16, i32* %4, align 4
  %17 = load i32, i32* %2, align 4
  %18 = sub nsw i32 %17, 1
  store i32 %18, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 0), align 4
  %19 = load i32, i32* %3, align 4
  store i32 %19, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 1), align 4
  %20 = load i32, i32* %4, align 4
  store i32 %20, i32* %1, align 4
  br label %21

21:                                               ; preds = %10, %9
  %22 = load i32, i32* %1, align 4
  ret i32 %22
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @steal() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32*, align 8
  %5 = alloca i32, align 4
  br label %6

6:                                                ; preds = %26, %0
  %7 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 0), align 4
  store i32 %7, i32* %2, align 4
  %8 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 1), align 4
  store i32 %8, i32* %3, align 4
  %9 = load i32, i32* %2, align 4
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %11, label %12

11:                                               ; preds = %6
  store i32 -1, i32* %1, align 4
  br label %29

12:                                               ; preds = %6
  %13 = load i32*, i32** @tasks, align 8
  store i32* %13, i32** %4, align 8
  %14 = load i32*, i32** %4, align 8
  %15 = load i32, i32* %2, align 4
  %16 = sub nsw i32 %15, 1
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds i32, i32* %14, i64 %17
  %19 = load i32, i32* %18, align 4
  store i32 %19, i32* %5, align 4
  %20 = load i32, i32* %2, align 4
  %21 = load i32, i32* %3, align 4
  %22 = load i32, i32* %2, align 4
  %23 = sub nsw i32 %22, 1
  %24 = load i32, i32* %3, align 4
  %25 = call zeroext i1 @CAS(%struct.anchor_t* @anchor, i32 %20, i32 %21, i32 %23, i32 %24)
  br i1 %25, label %27, label %26

26:                                               ; preds = %12
  br label %6

27:                                               ; preds = %12
  %28 = load i32, i32* %5, align 4
  store i32 %28, i32* %1, align 4
  br label %29

29:                                               ; preds = %27, %11
  %30 = load i32, i32* %1, align 4
  ret i32 %30
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
  call void @LifoIwsq(i32 10)
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
