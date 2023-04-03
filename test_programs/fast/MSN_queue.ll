; ModuleID = 'MSN_queue.c'
source_filename = "MSN_queue.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._node_t = type { i32, %struct._pointer_t }
%struct._pointer_t = type { %struct._node_t*, i32 }
%struct._queue_t = type { %struct._pointer_t, %struct._pointer_t }
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
  %7 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %6, i32 0, i32 0
  store %struct._node_t* null, %struct._node_t** %7, align 8
  %8 = load %struct._node_t*, %struct._node_t** %3, align 8
  %9 = load %struct._queue_t*, %struct._queue_t** %2, align 8
  %10 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %9, i32 0, i32 1
  %11 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %10, i32 0, i32 0
  store %struct._node_t* %8, %struct._node_t** %11, align 8
  %12 = load %struct._queue_t*, %struct._queue_t** %2, align 8
  %13 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %12, i32 0, i32 0
  %14 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %13, i32 0, i32 0
  store %struct._node_t* %8, %struct._node_t** %14, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @enqueue(%struct._queue_t* %0, i32 %1) #0 {
  %3 = alloca %struct._queue_t*, align 8
  %4 = alloca i32, align 4
  %5 = alloca %struct._pointer_t, align 8
  %6 = alloca %struct._node_t*, align 8
  %7 = alloca %struct._pointer_t, align 8
  %8 = alloca %struct._pointer_t, align 8
  %9 = alloca %struct._pointer_t, align 8
  %10 = alloca %struct._pointer_t, align 8
  store %struct._queue_t* %0, %struct._queue_t** %3, align 8
  store i32 %1, i32* %4, align 4
  %11 = call %struct._node_t* @new_node()
  store %struct._node_t* %11, %struct._node_t** %6, align 8
  %12 = load i32, i32* %4, align 4
  %13 = load %struct._node_t*, %struct._node_t** %6, align 8
  %14 = getelementptr inbounds %struct._node_t, %struct._node_t* %13, i32 0, i32 0
  store i32 %12, i32* %14, align 8
  %15 = load %struct._node_t*, %struct._node_t** %6, align 8
  %16 = getelementptr inbounds %struct._node_t, %struct._node_t* %15, i32 0, i32 1
  %17 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %16, i32 0, i32 0
  store %struct._node_t* null, %struct._node_t** %17, align 8
  br label %18

18:                                               ; preds = %2, %92
  %19 = load %struct._queue_t*, %struct._queue_t** %3, align 8
  %20 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %19, i32 0, i32 1
  %21 = bitcast %struct._pointer_t* %5 to i8*
  %22 = bitcast %struct._pointer_t* %20 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %21, i8* align 8 %22, i64 16, i1 false)
  %23 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %5, i32 0, i32 0
  %24 = load %struct._node_t*, %struct._node_t** %23, align 8
  %25 = getelementptr inbounds %struct._node_t, %struct._node_t* %24, i32 0, i32 1
  %26 = bitcast %struct._pointer_t* %7 to i8*
  %27 = bitcast %struct._pointer_t* %25 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %26, i8* align 8 %27, i64 16, i1 false)
  %28 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %5, i32 0, i32 0
  %29 = load %struct._node_t*, %struct._node_t** %28, align 8
  %30 = load %struct._queue_t*, %struct._queue_t** %3, align 8
  %31 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %30, i32 0, i32 1
  %32 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %31, i32 0, i32 0
  %33 = load %struct._node_t*, %struct._node_t** %32, align 8
  %34 = icmp eq %struct._node_t* %29, %33
  br i1 %34, label %35, label %92

35:                                               ; preds = %18
  %36 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %5, i32 0, i32 1
  %37 = load i32, i32* %36, align 8
  %38 = load %struct._queue_t*, %struct._queue_t** %3, align 8
  %39 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %38, i32 0, i32 1
  %40 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %39, i32 0, i32 1
  %41 = load i32, i32* %40, align 8
  %42 = icmp eq i32 %37, %41
  br i1 %42, label %43, label %92

43:                                               ; preds = %35
  %44 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %7, i32 0, i32 0
  %45 = load %struct._node_t*, %struct._node_t** %44, align 8
  %46 = icmp eq %struct._node_t* %45, null
  br i1 %46, label %47, label %70

47:                                               ; preds = %43
  %48 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %8, i32 0, i32 0
  %49 = load %struct._node_t*, %struct._node_t** %6, align 8
  store %struct._node_t* %49, %struct._node_t** %48, align 8
  %50 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %8, i32 0, i32 1
  %51 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %7, i32 0, i32 1
  %52 = load i32, i32* %51, align 8
  %53 = add i32 %52, 1
  store i32 %53, i32* %50, align 8
  %54 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %5, i32 0, i32 0
  %55 = load %struct._node_t*, %struct._node_t** %54, align 8
  %56 = getelementptr inbounds %struct._node_t, %struct._node_t* %55, i32 0, i32 1
  %57 = bitcast %struct._pointer_t* %7 to { %struct._node_t*, i32 }*
  %58 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %57, i32 0, i32 0
  %59 = load %struct._node_t*, %struct._node_t** %58, align 8
  %60 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %57, i32 0, i32 1
  %61 = load i32, i32* %60, align 8
  %62 = bitcast %struct._pointer_t* %8 to { %struct._node_t*, i32 }*
  %63 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %62, i32 0, i32 0
  %64 = load %struct._node_t*, %struct._node_t** %63, align 8
  %65 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %62, i32 0, i32 1
  %66 = load i32, i32* %65, align 8
  %67 = call zeroext i1 @CAS(%struct._pointer_t* %56, %struct._node_t* %59, i32 %61, %struct._node_t* %64, i32 %66)
  br i1 %67, label %68, label %69

68:                                               ; preds = %47
  br label %93

69:                                               ; preds = %47
  br label %91

70:                                               ; preds = %43
  %71 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %9, i32 0, i32 0
  %72 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %7, i32 0, i32 0
  %73 = load %struct._node_t*, %struct._node_t** %72, align 8
  store %struct._node_t* %73, %struct._node_t** %71, align 8
  %74 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %9, i32 0, i32 1
  %75 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %5, i32 0, i32 1
  %76 = load i32, i32* %75, align 8
  %77 = add i32 %76, 1
  store i32 %77, i32* %74, align 8
  %78 = load %struct._queue_t*, %struct._queue_t** %3, align 8
  %79 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %78, i32 0, i32 1
  %80 = bitcast %struct._pointer_t* %5 to { %struct._node_t*, i32 }*
  %81 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %80, i32 0, i32 0
  %82 = load %struct._node_t*, %struct._node_t** %81, align 8
  %83 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %80, i32 0, i32 1
  %84 = load i32, i32* %83, align 8
  %85 = bitcast %struct._pointer_t* %9 to { %struct._node_t*, i32 }*
  %86 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %85, i32 0, i32 0
  %87 = load %struct._node_t*, %struct._node_t** %86, align 8
  %88 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %85, i32 0, i32 1
  %89 = load i32, i32* %88, align 8
  %90 = call zeroext i1 @CAS(%struct._pointer_t* %79, %struct._node_t* %82, i32 %84, %struct._node_t* %87, i32 %89)
  br label %91

91:                                               ; preds = %70, %69
  br label %92

92:                                               ; preds = %91, %35, %18
  br label %18

93:                                               ; preds = %68
  %94 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %10, i32 0, i32 0
  %95 = load %struct._node_t*, %struct._node_t** %6, align 8
  store %struct._node_t* %95, %struct._node_t** %94, align 8
  %96 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %10, i32 0, i32 1
  %97 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %5, i32 0, i32 1
  %98 = load i32, i32* %97, align 8
  %99 = add i32 %98, 1
  store i32 %99, i32* %96, align 8
  %100 = load %struct._queue_t*, %struct._queue_t** %3, align 8
  %101 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %100, i32 0, i32 1
  %102 = bitcast %struct._pointer_t* %5 to { %struct._node_t*, i32 }*
  %103 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %102, i32 0, i32 0
  %104 = load %struct._node_t*, %struct._node_t** %103, align 8
  %105 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %102, i32 0, i32 1
  %106 = load i32, i32* %105, align 8
  %107 = bitcast %struct._pointer_t* %10 to { %struct._node_t*, i32 }*
  %108 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %107, i32 0, i32 0
  %109 = load %struct._node_t*, %struct._node_t** %108, align 8
  %110 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %107, i32 0, i32 1
  %111 = load i32, i32* %110, align 8
  %112 = call zeroext i1 @CAS(%struct._pointer_t* %101, %struct._node_t* %104, i32 %106, %struct._node_t* %109, i32 %111)
  ret void
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

declare dso_local zeroext i1 @CAS(%struct._pointer_t*, %struct._node_t*, i32, %struct._node_t*, i32) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i1 @dequeue(%struct._queue_t* %0, i32* %1) #0 {
  %3 = alloca i1, align 1
  %4 = alloca %struct._queue_t*, align 8
  %5 = alloca i32*, align 8
  %6 = alloca %struct._pointer_t, align 8
  %7 = alloca %struct._pointer_t, align 8
  %8 = alloca %struct._pointer_t, align 8
  %9 = alloca %struct._pointer_t, align 8
  %10 = alloca %struct._pointer_t, align 8
  store %struct._queue_t* %0, %struct._queue_t** %4, align 8
  store i32* %1, i32** %5, align 8
  br label %11

11:                                               ; preds = %2, %84
  %12 = load %struct._queue_t*, %struct._queue_t** %4, align 8
  %13 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %12, i32 0, i32 0
  %14 = bitcast %struct._pointer_t* %6 to i8*
  %15 = bitcast %struct._pointer_t* %13 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %14, i8* align 8 %15, i64 16, i1 false)
  %16 = load %struct._queue_t*, %struct._queue_t** %4, align 8
  %17 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %16, i32 0, i32 1
  %18 = bitcast %struct._pointer_t* %7 to i8*
  %19 = bitcast %struct._pointer_t* %17 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %18, i8* align 8 %19, i64 16, i1 false)
  %20 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %6, i32 0, i32 0
  %21 = load %struct._node_t*, %struct._node_t** %20, align 8
  %22 = getelementptr inbounds %struct._node_t, %struct._node_t* %21, i32 0, i32 1
  %23 = bitcast %struct._pointer_t* %8 to i8*
  %24 = bitcast %struct._pointer_t* %22 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %23, i8* align 8 %24, i64 16, i1 false)
  %25 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %6, i32 0, i32 0
  %26 = load %struct._node_t*, %struct._node_t** %25, align 8
  %27 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %7, i32 0, i32 0
  %28 = load %struct._node_t*, %struct._node_t** %27, align 8
  %29 = icmp eq %struct._node_t* %26, %28
  br i1 %29, label %30, label %56

30:                                               ; preds = %11
  %31 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %8, i32 0, i32 0
  %32 = load %struct._node_t*, %struct._node_t** %31, align 8
  %33 = icmp eq %struct._node_t* %32, null
  br i1 %33, label %34, label %35

34:                                               ; preds = %30
  store i1 false, i1* %3, align 1
  br label %89

35:                                               ; preds = %30
  %36 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %9, i32 0, i32 0
  %37 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %8, i32 0, i32 0
  %38 = load %struct._node_t*, %struct._node_t** %37, align 8
  store %struct._node_t* %38, %struct._node_t** %36, align 8
  %39 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %9, i32 0, i32 1
  %40 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %7, i32 0, i32 1
  %41 = load i32, i32* %40, align 8
  %42 = add i32 %41, 1
  store i32 %42, i32* %39, align 8
  %43 = load %struct._queue_t*, %struct._queue_t** %4, align 8
  %44 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %43, i32 0, i32 1
  %45 = bitcast %struct._pointer_t* %7 to { %struct._node_t*, i32 }*
  %46 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %45, i32 0, i32 0
  %47 = load %struct._node_t*, %struct._node_t** %46, align 8
  %48 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %45, i32 0, i32 1
  %49 = load i32, i32* %48, align 8
  %50 = bitcast %struct._pointer_t* %9 to { %struct._node_t*, i32 }*
  %51 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %50, i32 0, i32 0
  %52 = load %struct._node_t*, %struct._node_t** %51, align 8
  %53 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %50, i32 0, i32 1
  %54 = load i32, i32* %53, align 8
  %55 = call zeroext i1 @CAS(%struct._pointer_t* %44, %struct._node_t* %47, i32 %49, %struct._node_t* %52, i32 %54)
  br label %84

56:                                               ; preds = %11
  %57 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %8, i32 0, i32 0
  %58 = load %struct._node_t*, %struct._node_t** %57, align 8
  %59 = getelementptr inbounds %struct._node_t, %struct._node_t* %58, i32 0, i32 0
  %60 = load i32, i32* %59, align 8
  %61 = load i32*, i32** %5, align 8
  store i32 %60, i32* %61, align 4
  %62 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %10, i32 0, i32 0
  %63 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %8, i32 0, i32 0
  %64 = load %struct._node_t*, %struct._node_t** %63, align 8
  store %struct._node_t* %64, %struct._node_t** %62, align 8
  %65 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %10, i32 0, i32 1
  %66 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %6, i32 0, i32 1
  %67 = load i32, i32* %66, align 8
  %68 = add i32 %67, 1
  store i32 %68, i32* %65, align 8
  %69 = load %struct._queue_t*, %struct._queue_t** %4, align 8
  %70 = getelementptr inbounds %struct._queue_t, %struct._queue_t* %69, i32 0, i32 0
  %71 = bitcast %struct._pointer_t* %6 to { %struct._node_t*, i32 }*
  %72 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %71, i32 0, i32 0
  %73 = load %struct._node_t*, %struct._node_t** %72, align 8
  %74 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %71, i32 0, i32 1
  %75 = load i32, i32* %74, align 8
  %76 = bitcast %struct._pointer_t* %10 to { %struct._node_t*, i32 }*
  %77 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %76, i32 0, i32 0
  %78 = load %struct._node_t*, %struct._node_t** %77, align 8
  %79 = getelementptr inbounds { %struct._node_t*, i32 }, { %struct._node_t*, i32 }* %76, i32 0, i32 1
  %80 = load i32, i32* %79, align 8
  %81 = call zeroext i1 @CAS(%struct._pointer_t* %70, %struct._node_t* %73, i32 %75, %struct._node_t* %78, i32 %80)
  br i1 %81, label %82, label %83

82:                                               ; preds = %56
  br label %85

83:                                               ; preds = %56
  br label %84

84:                                               ; preds = %83, %35
  br label %11

85:                                               ; preds = %82
  %86 = getelementptr inbounds %struct._pointer_t, %struct._pointer_t* %6, i32 0, i32 0
  %87 = load %struct._node_t*, %struct._node_t** %86, align 8
  %88 = bitcast %struct._node_t* %87 to i8*
  call void @free(i8* %88) #4
  store i1 true, i1* %3, align 1
  br label %89

89:                                               ; preds = %85, %34
  %90 = load i1, i1* %3, align 1
  ret i1 %90
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

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
  %9 = call i32 @rand() #4
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
declare dso_local i32 @rand() #3

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
  %3 = call i32 @pthread_create(i64* %2, %union.pthread_attr_t* null, i8* (i8*)* @leftThread, i8* null) #4
  %4 = call i8* @rightThread(i8* null)
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #3

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }
attributes #2 = { "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.5"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
!4 = distinct !{!4, !3}
