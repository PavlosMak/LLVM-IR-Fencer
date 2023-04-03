; ModuleID = 'Anchor_iWSQ.c'
source_filename = "Anchor_iWSQ.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.array_with_size_t = type { i32, i32* }
%struct.anchor_t = type { i32, i32, i32 }
%union.pthread_attr_t = type { i64, [48 x i8] }

@counter = dso_local global i64 0, align 8
@counter_arrays = dso_local global i64 0, align 8
@shared_tasks = dso_local global [10 x i32] zeroinitializer, align 16
@shared_arrays = dso_local global [10 x %struct.array_with_size_t] zeroinitializer, align 16
@anchor = dso_local global %struct.anchor_t zeroinitializer, align 4
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
define dso_local void @DeIwsq(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  store i32 0, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 0), align 4
  store i32 0, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 1), align 4
  store i32 0, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 2), align 4
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
define dso_local zeroext i1 @CAS(%struct.anchor_t* %0, i32 %1, i32 %2, i32 %3, i32 %4, i32 %5, i32 %6) #0 {
  %8 = alloca %struct.anchor_t*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i8, align 1
  store %struct.anchor_t* %0, %struct.anchor_t** %8, align 8
  store i32 %1, i32* %9, align 4
  store i32 %2, i32* %10, align 4
  store i32 %3, i32* %11, align 4
  store i32 %4, i32* %12, align 4
  store i32 %5, i32* %13, align 4
  store i32 %6, i32* %14, align 4
  %16 = load %struct.anchor_t*, %struct.anchor_t** %8, align 8
  %17 = getelementptr inbounds %struct.anchor_t, %struct.anchor_t* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 4
  %19 = load i32, i32* %9, align 4
  %20 = icmp eq i32 %18, %19
  br i1 %20, label %21, label %33

21:                                               ; preds = %7
  %22 = load %struct.anchor_t*, %struct.anchor_t** %8, align 8
  %23 = getelementptr inbounds %struct.anchor_t, %struct.anchor_t* %22, i32 0, i32 1
  %24 = load i32, i32* %23, align 4
  %25 = load i32, i32* %10, align 4
  %26 = icmp eq i32 %24, %25
  br i1 %26, label %27, label %33

27:                                               ; preds = %21
  %28 = load %struct.anchor_t*, %struct.anchor_t** %8, align 8
  %29 = getelementptr inbounds %struct.anchor_t, %struct.anchor_t* %28, i32 0, i32 2
  %30 = load i32, i32* %29, align 4
  %31 = load i32, i32* %11, align 4
  %32 = icmp eq i32 %30, %31
  br label %33

33:                                               ; preds = %27, %21, %7
  %34 = phi i1 [ false, %21 ], [ false, %7 ], [ %32, %27 ]
  %35 = zext i1 %34 to i8
  store i8 %35, i8* %15, align 1
  %36 = load i8, i8* %15, align 1
  %37 = trunc i8 %36 to i1
  br i1 %37, label %38, label %48

38:                                               ; preds = %33
  %39 = load i32, i32* %12, align 4
  %40 = load %struct.anchor_t*, %struct.anchor_t** %8, align 8
  %41 = getelementptr inbounds %struct.anchor_t, %struct.anchor_t* %40, i32 0, i32 0
  store i32 %39, i32* %41, align 4
  %42 = load i32, i32* %13, align 4
  %43 = load %struct.anchor_t*, %struct.anchor_t** %8, align 8
  %44 = getelementptr inbounds %struct.anchor_t, %struct.anchor_t* %43, i32 0, i32 1
  store i32 %42, i32* %44, align 4
  %45 = load i32, i32* %14, align 4
  %46 = load %struct.anchor_t*, %struct.anchor_t** %8, align 8
  %47 = getelementptr inbounds %struct.anchor_t, %struct.anchor_t* %46, i32 0, i32 2
  store i32 %45, i32* %47, align 4
  br label %48

48:                                               ; preds = %38, %33
  %49 = load i8, i8* %15, align 1
  %50 = trunc i8 %49 to i1
  ret i1 %50
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @expand() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca %struct.array_with_size_t*, align 8
  %5 = alloca i32, align 4
  %6 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 0), align 4
  store i32 %6, i32* %1, align 4
  %7 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 1), align 4
  store i32 %7, i32* %2, align 4
  %8 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 2), align 4
  store i32 %8, i32* %3, align 4
  %9 = call %struct.array_with_size_t* @new_array_with_size()
  store %struct.array_with_size_t* %9, %struct.array_with_size_t** %4, align 8
  %10 = load i32, i32* %2, align 4
  %11 = mul nsw i32 %10, 2
  %12 = call i32* @new_task_array(i32 %11)
  %13 = load %struct.array_with_size_t*, %struct.array_with_size_t** %4, align 8
  %14 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %13, i32 0, i32 1
  store i32* %12, i32** %14, align 8
  %15 = load i32, i32* %2, align 4
  %16 = mul nsw i32 2, %15
  %17 = load %struct.array_with_size_t*, %struct.array_with_size_t** %4, align 8
  %18 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %17, i32 0, i32 0
  store i32 %16, i32* %18, align 8
  store i32 0, i32* %5, align 4
  br label %19

19:                                               ; preds = %49, %0
  %20 = load i32, i32* %5, align 4
  %21 = load i32, i32* %2, align 4
  %22 = icmp slt i32 %20, %21
  br i1 %22, label %23, label %52

23:                                               ; preds = %19
  %24 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %25 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %24, i32 0, i32 1
  %26 = load i32*, i32** %25, align 8
  %27 = load i32, i32* %1, align 4
  %28 = load i32, i32* %5, align 4
  %29 = add nsw i32 %27, %28
  %30 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %31 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 8
  %33 = srem i32 %29, %32
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds i32, i32* %26, i64 %34
  %36 = load i32, i32* %35, align 4
  %37 = load %struct.array_with_size_t*, %struct.array_with_size_t** %4, align 8
  %38 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %37, i32 0, i32 1
  %39 = load i32*, i32** %38, align 8
  %40 = load i32, i32* %1, align 4
  %41 = load i32, i32* %5, align 4
  %42 = add nsw i32 %40, %41
  %43 = load %struct.array_with_size_t*, %struct.array_with_size_t** %4, align 8
  %44 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %43, i32 0, i32 0
  %45 = load i32, i32* %44, align 8
  %46 = srem i32 %42, %45
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds i32, i32* %39, i64 %47
  store i32 %36, i32* %48, align 4
  br label %49

49:                                               ; preds = %23
  %50 = load i32, i32* %5, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, i32* %5, align 4
  br label %19, !llvm.loop !2

52:                                               ; preds = %19
  %53 = load %struct.array_with_size_t*, %struct.array_with_size_t** %4, align 8
  store %struct.array_with_size_t* %53, %struct.array_with_size_t** @tasks, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @put(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  br label %6

6:                                                ; preds = %15, %1
  %7 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 0), align 4
  store i32 %7, i32* %3, align 4
  %8 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 1), align 4
  store i32 %8, i32* %4, align 4
  %9 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 2), align 4
  store i32 %9, i32* %5, align 4
  %10 = load i32, i32* %4, align 4
  %11 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %12 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %11, i32 0, i32 0
  %13 = load i32, i32* %12, align 8
  %14 = icmp eq i32 %10, %13
  br i1 %14, label %15, label %16

15:                                               ; preds = %6
  call void @expand()
  br label %6

16:                                               ; preds = %6
  %17 = load i32, i32* %2, align 4
  %18 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %19 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %18, i32 0, i32 1
  %20 = load i32*, i32** %19, align 8
  %21 = load i32, i32* %3, align 4
  %22 = load i32, i32* %4, align 4
  %23 = add nsw i32 %21, %22
  %24 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %25 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %24, i32 0, i32 0
  %26 = load i32, i32* %25, align 8
  %27 = srem i32 %23, %26
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds i32, i32* %20, i64 %28
  store i32 %17, i32* %29, align 4
  %30 = load i32, i32* %3, align 4
  store i32 %30, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 0), align 4
  %31 = load i32, i32* %4, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 1), align 4
  %33 = load i32, i32* %5, align 4
  %34 = add nsw i32 %33, 1
  store i32 %34, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 2), align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @take() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 0), align 4
  store i32 %6, i32* %2, align 4
  %7 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 1), align 4
  store i32 %7, i32* %3, align 4
  %8 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 2), align 4
  store i32 %8, i32* %4, align 4
  %9 = load i32, i32* %3, align 4
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %11, label %12

11:                                               ; preds = %0
  store i32 -1, i32* %1, align 4
  br label %32

12:                                               ; preds = %0
  %13 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %14 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %13, i32 0, i32 1
  %15 = load i32*, i32** %14, align 8
  %16 = load i32, i32* %2, align 4
  %17 = load i32, i32* %3, align 4
  %18 = add nsw i32 %16, %17
  %19 = sub nsw i32 %18, 1
  %20 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  %21 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %20, i32 0, i32 0
  %22 = load i32, i32* %21, align 8
  %23 = srem i32 %19, %22
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds i32, i32* %15, i64 %24
  %26 = load i32, i32* %25, align 4
  store i32 %26, i32* %5, align 4
  %27 = load i32, i32* %2, align 4
  store i32 %27, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 0), align 4
  %28 = load i32, i32* %3, align 4
  %29 = sub nsw i32 %28, 1
  store i32 %29, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 1), align 4
  %30 = load i32, i32* %4, align 4
  store i32 %30, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 2), align 4
  %31 = load i32, i32* %5, align 4
  store i32 %31, i32* %1, align 4
  br label %32

32:                                               ; preds = %12, %11
  %33 = load i32, i32* %1, align 4
  ret i32 %33
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @steal() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca %struct.array_with_size_t*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  br label %8

8:                                                ; preds = %38, %0
  %9 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 0), align 4
  store i32 %9, i32* %2, align 4
  %10 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 1), align 4
  store i32 %10, i32* %3, align 4
  %11 = load i32, i32* getelementptr inbounds (%struct.anchor_t, %struct.anchor_t* @anchor, i32 0, i32 2), align 4
  store i32 %11, i32* %4, align 4
  %12 = load i32, i32* %3, align 4
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %14, label %15

14:                                               ; preds = %8
  store i32 -1, i32* %1, align 4
  br label %41

15:                                               ; preds = %8
  %16 = load %struct.array_with_size_t*, %struct.array_with_size_t** @tasks, align 8
  store %struct.array_with_size_t* %16, %struct.array_with_size_t** %5, align 8
  %17 = load %struct.array_with_size_t*, %struct.array_with_size_t** %5, align 8
  %18 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %17, i32 0, i32 1
  %19 = load i32*, i32** %18, align 8
  %20 = load i32, i32* %2, align 4
  %21 = load %struct.array_with_size_t*, %struct.array_with_size_t** %5, align 8
  %22 = getelementptr inbounds %struct.array_with_size_t, %struct.array_with_size_t* %21, i32 0, i32 0
  %23 = load i32, i32* %22, align 8
  %24 = srem i32 %20, %23
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds i32, i32* %19, i64 %25
  %27 = load i32, i32* %26, align 4
  store i32 %27, i32* %6, align 4
  %28 = load i32, i32* %2, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, i32* %7, align 4
  %30 = load i32, i32* %2, align 4
  %31 = load i32, i32* %3, align 4
  %32 = load i32, i32* %4, align 4
  %33 = load i32, i32* %7, align 4
  %34 = load i32, i32* %3, align 4
  %35 = sub nsw i32 %34, 1
  %36 = load i32, i32* %4, align 4
  %37 = call zeroext i1 @CAS(%struct.anchor_t* @anchor, i32 %30, i32 %31, i32 %32, i32 %33, i32 %35, i32 %36)
  br i1 %37, label %39, label %38

38:                                               ; preds = %15
  br label %8

39:                                               ; preds = %15
  %40 = load i32, i32* %6, align 4
  store i32 %40, i32* %1, align 4
  br label %41

41:                                               ; preds = %39, %14
  %42 = load i32, i32* %1, align 4
  ret i32 %42
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
  call void @DeIwsq(i32 10)
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
