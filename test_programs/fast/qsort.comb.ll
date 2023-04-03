; ModuleID = 'qsort.comb.c'
source_filename = "qsort.comb.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque
%struct.pthread_qsort_data_t = type { i8*, i64, i64, i64, i32 (i8*, i8*)*, i64, %union.pthread_mutex_t*, %union.pthread_cond_t*, i32* }
%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { %struct.__pthread_internal_list*, %struct.__pthread_internal_list* }
%union.pthread_cond_t = type { %struct.__pthread_cond_s }
%struct.__pthread_cond_s = type { %union.anon, %union.anon.0, [2 x i32], [2 x i32], i32, i32, [2 x i32] }
%union.anon = type { i64 }
%union.anon.0 = type { i64 }
%union.pthread_attr_t = type { i64, [48 x i8] }
%union.pthread_mutexattr_t = type { i32 }
%union.pthread_condattr_t = type { i32 }
%struct.timeval = type { i64, i64 }

@.str = private unnamed_addr constant [9 x i8] c"%d.%d.%d\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@orig_array = internal global [100 x i64] zeroinitializer, align 16
@sort_array = internal global [100 x i64] zeroinitializer, align 16
@stderr = external dso_local global %struct._IO_FILE*, align 8
@.str.2 = private unnamed_addr constant [34 x i8] c"%s: %d: gettimeofday() ERROR: %s\0A\00", align 1
@.str.3 = private unnamed_addr constant [13 x i8] c"qsort.comb.c\00", align 1
@stdout = external dso_local global %struct._IO_FILE*, align 8
@.str.4 = private unnamed_addr constant [35 x i8] c"qsort test time: %02d:%02d:%07.4f\0A\00", align 1
@.str.5 = private unnamed_addr constant [33 x i8] c"%s: %d: ERROR: array not sorted\0A\00", align 1
@.str.6 = private unnamed_addr constant [39 x i8] c"%s: %d: pthread_get_nproc() ERROR: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [45 x i8] c"pthread_qsort_t test time: %02d:%02d:%07.4f\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @pthread_qsort(i8* %0, i64 %1, i64 %2, i32 (i8*, i8*)* %3, i64 %4) #0 {
  %6 = alloca i8*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca i32 (i8*, i8*)*, align 8
  %10 = alloca i64, align 8
  %11 = alloca i32, align 4
  store i8* %0, i8** %6, align 8
  store i64 %1, i64* %7, align 8
  store i64 %2, i64* %8, align 8
  store i32 (i8*, i8*)* %3, i32 (i8*, i8*)** %9, align 8
  store i64 %4, i64* %10, align 8
  %12 = load i64, i64* %7, align 8
  %13 = load i64, i64* %10, align 8
  %14 = udiv i64 %12, %13
  %15 = trunc i64 %14 to i32
  store i32 %15, i32* %11, align 4
  %16 = load i8*, i8** %6, align 8
  %17 = load i64, i64* %8, align 8
  %18 = load i64, i64* %7, align 8
  %19 = sub i64 %18, 1
  %20 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %9, align 8
  %21 = load i32, i32* %11, align 4
  %22 = sext i32 %21 to i64
  call void @pthread_qsort_local(i8* %16, i64 %17, i64 0, i64 %19, i32 (i8*, i8*)* %20, i64 %22)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @pthread_qsort_local(i8* %0, i64 %1, i64 %2, i64 %3, i32 (i8*, i8*)* %4, i64 %5) #0 {
  %7 = alloca i8*, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  %11 = alloca i32 (i8*, i8*)*, align 8
  %12 = alloca i64, align 8
  %13 = alloca i32, align 4
  %14 = alloca i64, align 8
  %15 = alloca %struct.pthread_qsort_data_t, align 8
  %16 = alloca %union.pthread_mutex_t, align 8
  %17 = alloca %union.pthread_cond_t, align 8
  %18 = alloca i64, align 8
  %19 = alloca %union.pthread_attr_t, align 8
  store i8* %0, i8** %7, align 8
  store i64 %1, i64* %8, align 8
  store i64 %2, i64* %9, align 8
  store i64 %3, i64* %10, align 8
  store i32 (i8*, i8*)* %4, i32 (i8*, i8*)** %11, align 8
  store i64 %5, i64* %12, align 8
  %20 = call i32 @pthread_mutex_init(%union.pthread_mutex_t* %16, %union.pthread_mutexattr_t* null) #6
  %21 = call i32 @pthread_cond_init(%union.pthread_cond_t* %17, %union.pthread_condattr_t* null) #6
  %22 = load i64, i64* %10, align 8
  %23 = load i64, i64* %9, align 8
  %24 = sub i64 %22, %23
  %25 = load i64, i64* %12, align 8
  %26 = icmp ugt i64 %24, %25
  br i1 %26, label %27, label %90

27:                                               ; preds = %6
  %28 = load i8*, i8** %7, align 8
  %29 = load i64, i64* %8, align 8
  %30 = load i64, i64* %9, align 8
  %31 = load i64, i64* %10, align 8
  %32 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %11, align 8
  call void @pthread_qsort_split(i8* %28, i64 %29, i64 %30, i64 %31, i64* %14, i32 (i8*, i8*)* %32)
  store i32 0, i32* %13, align 4
  %33 = load i8*, i8** %7, align 8
  %34 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %15, i32 0, i32 0
  store i8* %33, i8** %34, align 8
  %35 = load i64, i64* %8, align 8
  %36 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %15, i32 0, i32 1
  store i64 %35, i64* %36, align 8
  %37 = load i64, i64* %9, align 8
  %38 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %15, i32 0, i32 2
  store i64 %37, i64* %38, align 8
  %39 = load i64, i64* %14, align 8
  %40 = sub i64 %39, 1
  %41 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %15, i32 0, i32 3
  store i64 %40, i64* %41, align 8
  %42 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %11, align 8
  %43 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %15, i32 0, i32 4
  store i32 (i8*, i8*)* %42, i32 (i8*, i8*)** %43, align 8
  %44 = load i64, i64* %12, align 8
  %45 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %15, i32 0, i32 5
  store i64 %44, i64* %45, align 8
  %46 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %15, i32 0, i32 6
  store %union.pthread_mutex_t* %16, %union.pthread_mutex_t** %46, align 8
  %47 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %15, i32 0, i32 7
  store %union.pthread_cond_t* %17, %union.pthread_cond_t** %47, align 8
  %48 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %15, i32 0, i32 8
  store i32* %13, i32** %48, align 8
  %49 = call i32 @pthread_attr_init(%union.pthread_attr_t* %19) #6
  %50 = icmp ne i32 %49, 0
  br i1 %50, label %51, label %52

51:                                               ; preds = %27
  call void @abort() #7
  unreachable

52:                                               ; preds = %27
  %53 = call i32 @pthread_attr_setdetachstate(%union.pthread_attr_t* %19, i32 1) #6
  %54 = icmp ne i32 %53, 0
  br i1 %54, label %55, label %56

55:                                               ; preds = %52
  call void @abort() #7
  unreachable

56:                                               ; preds = %52
  %57 = bitcast %struct.pthread_qsort_data_t* %15 to i8*
  %58 = call i32 @pthread_create(i64* %18, %union.pthread_attr_t* %19, i8* (i8*)* @pthread_qsort_local_call, i8* %57) #6
  %59 = icmp ne i32 %58, 0
  br i1 %59, label %60, label %61

60:                                               ; preds = %56
  call void @abort() #7
  unreachable

61:                                               ; preds = %56
  %62 = load i8*, i8** %7, align 8
  %63 = load i64, i64* %8, align 8
  %64 = load i64, i64* %14, align 8
  %65 = add i64 %64, 1
  %66 = load i64, i64* %10, align 8
  %67 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %11, align 8
  %68 = load i64, i64* %12, align 8
  call void @pthread_qsort_local(i8* %62, i64 %63, i64 %65, i64 %66, i32 (i8*, i8*)* %67, i64 %68)
  %69 = call i32 @pthread_mutex_lock(%union.pthread_mutex_t* %16) #6
  %70 = icmp ne i32 %69, 0
  br i1 %70, label %71, label %72

71:                                               ; preds = %61
  call void @abort() #7
  unreachable

72:                                               ; preds = %61
  br label %73

73:                                               ; preds = %80, %72
  %74 = load i32, i32* %13, align 4
  %75 = icmp eq i32 %74, 0
  br i1 %75, label %76, label %81

76:                                               ; preds = %73
  %77 = call i32 @pthread_cond_wait(%union.pthread_cond_t* %17, %union.pthread_mutex_t* %16)
  %78 = icmp ne i32 %77, 0
  br i1 %78, label %79, label %80

79:                                               ; preds = %76
  call void @abort() #7
  unreachable

80:                                               ; preds = %76
  br label %73, !llvm.loop !2

81:                                               ; preds = %73
  %82 = call i32 @pthread_mutex_unlock(%union.pthread_mutex_t* %16) #6
  %83 = icmp ne i32 %82, 0
  br i1 %83, label %84, label %85

84:                                               ; preds = %81
  call void @abort() #7
  unreachable

85:                                               ; preds = %81
  %86 = call i32 @pthread_attr_destroy(%union.pthread_attr_t* %19) #6
  %87 = icmp ne i32 %86, 0
  br i1 %87, label %88, label %89

88:                                               ; preds = %85
  call void @abort() #7
  unreachable

89:                                               ; preds = %85
  br label %104

90:                                               ; preds = %6
  %91 = load i8*, i8** %7, align 8
  %92 = ptrtoint i8* %91 to i64
  %93 = load i64, i64* %9, align 8
  %94 = load i64, i64* %8, align 8
  %95 = mul i64 %93, %94
  %96 = add i64 %92, %95
  %97 = inttoptr i64 %96 to i8*
  %98 = load i64, i64* %10, align 8
  %99 = load i64, i64* %9, align 8
  %100 = sub i64 %98, %99
  %101 = add i64 %100, 1
  %102 = load i64, i64* %8, align 8
  %103 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %11, align 8
  call void @qsort(i8* %97, i64 %101, i64 %102, i32 (i8*, i8*)* %103)
  br label %104

104:                                              ; preds = %90, %89
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @pthread_ctf_version(i8* %0, i64 %1) #0 {
  %3 = alloca i8*, align 8
  %4 = alloca i64, align 8
  store i8* %0, i8** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i8*, i8** %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = call i32 (i8*, i64, i8*, ...) @snprintf(i8* %5, i64 %6, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i64 0, i64 0), i32 0, i32 1, i32 0) #6
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local i32 @snprintf(i8*, i64, i8*, ...) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @pthread_get_nproc(i32* %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32*, align 8
  store i32* %0, i32** %3, align 8
  %4 = load i32*, i32** %3, align 8
  %5 = icmp eq i32* %4, null
  br i1 %5, label %6, label %7

6:                                                ; preds = %1
  store i32 14, i32* %2, align 4
  br label %14

7:                                                ; preds = %1
  %8 = call i64 @sysconf(i32 84) #6
  %9 = trunc i64 %8 to i32
  %10 = load i32*, i32** %3, align 8
  store i32 %9, i32* %10, align 4
  %11 = icmp eq i32 %9, -1
  br i1 %11, label %12, label %13

12:                                               ; preds = %7
  store i32 95, i32* %2, align 4
  br label %14

13:                                               ; preds = %7
  store i32 0, i32* %2, align 4
  br label %14

14:                                               ; preds = %13, %12, %6
  %15 = load i32, i32* %2, align 4
  ret i32 %15
}

; Function Attrs: nounwind
declare dso_local i64 @sysconf(i32) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @pthread_get_name(i64 %0, i8* %1, i64 %2) #0 {
  %4 = alloca i64, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i64, align 8
  store i64 %0, i64* %4, align 8
  store i8* %1, i8** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load i8*, i8** %5, align 8
  %8 = load i64, i64* %6, align 8
  %9 = load i64, i64* %4, align 8
  %10 = trunc i64 %9 to i32
  %11 = call i32 (i8*, i64, i8*, ...) @snprintf(i8* %7, i64 %8, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i64 0, i64 0), i32 %10) #6
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @pthread_version(i8* %0, i64 %1) #0 {
  %3 = alloca i8*, align 8
  %4 = alloca i64, align 8
  store i8* %0, i8** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i8*, i8** %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = call i64 @confstr(i32 3, i8* %5, i64 %6) #6
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local i64 @confstr(i32, i8*, i64) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca float, align 4
  %8 = alloca %struct.timeval, align 8
  %9 = alloca %struct.timeval, align 8
  store i32 0, i32* %1, align 4
  store i32 0, i32* %2, align 4
  br label %10

10:                                               ; preds = %25, %0
  %11 = load i32, i32* %2, align 4
  %12 = icmp slt i32 %11, 100
  br i1 %12, label %13, label %28

13:                                               ; preds = %10
  %14 = call i64 @mrand48() #6
  %15 = load i32, i32* %2, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds [100 x i64], [100 x i64]* @orig_array, i64 0, i64 %16
  store i64 %14, i64* %17, align 8
  %18 = load i32, i32* %2, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [100 x i64], [100 x i64]* @orig_array, i64 0, i64 %19
  %21 = load i64, i64* %20, align 8
  %22 = load i32, i32* %2, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [100 x i64], [100 x i64]* @sort_array, i64 0, i64 %23
  store i64 %21, i64* %24, align 8
  br label %25

25:                                               ; preds = %13
  %26 = load i32, i32* %2, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, i32* %2, align 4
  br label %10, !llvm.loop !4

28:                                               ; preds = %10
  %29 = call i32 @gettimeofday(%struct.timeval* %8, i8* null) #6
  %30 = icmp ne i32 %29, 0
  br i1 %30, label %31, label %37

31:                                               ; preds = %28
  %32 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %33 = call i32* @__errno_location() #8
  %34 = load i32, i32* %33, align 4
  %35 = call i8* @strerror(i32 %34) #6
  %36 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %32, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.3, i64 0, i64 0), i32 630, i8* %35)
  call void @exit(i32 1) #7
  unreachable

37:                                               ; preds = %28
  call void @qsort(i8* bitcast ([100 x i64]* @sort_array to i8*), i64 100, i64 8, i32 (i8*, i8*)* @work_long)
  %38 = call i32 @gettimeofday(%struct.timeval* %9, i8* null) #6
  %39 = icmp ne i32 %38, 0
  br i1 %39, label %40, label %46

40:                                               ; preds = %37
  %41 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %42 = call i32* @__errno_location() #8
  %43 = load i32, i32* %42, align 4
  %44 = call i8* @strerror(i32 %43) #6
  %45 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %41, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.3, i64 0, i64 0), i32 639, i8* %44)
  call void @exit(i32 1) #7
  unreachable

46:                                               ; preds = %37
  %47 = getelementptr inbounds %struct.timeval, %struct.timeval* %9, i32 0, i32 0
  %48 = load i64, i64* %47, align 8
  %49 = getelementptr inbounds %struct.timeval, %struct.timeval* %8, i32 0, i32 0
  %50 = load i64, i64* %49, align 8
  %51 = sub nsw i64 %48, %50
  %52 = sitofp i64 %51 to double
  %53 = getelementptr inbounds %struct.timeval, %struct.timeval* %9, i32 0, i32 1
  %54 = load i64, i64* %53, align 8
  %55 = getelementptr inbounds %struct.timeval, %struct.timeval* %8, i32 0, i32 1
  %56 = load i64, i64* %55, align 8
  %57 = sub nsw i64 %54, %56
  %58 = sitofp i64 %57 to double
  %59 = fdiv double %58, 1.000000e+06
  %60 = fadd double %52, %59
  %61 = fptrunc double %60 to float
  store float %61, float* %7, align 4
  %62 = load float, float* %7, align 4
  %63 = fdiv float %62, 6.000000e+01
  %64 = fptosi float %63 to i32
  store i32 %64, i32* %6, align 4
  %65 = load float, float* %7, align 4
  %66 = load i32, i32* %6, align 4
  %67 = mul nsw i32 %66, 60
  %68 = sitofp i32 %67 to float
  %69 = fsub float %65, %68
  store float %69, float* %7, align 4
  %70 = load i32, i32* %6, align 4
  %71 = sdiv i32 %70, 60
  store i32 %71, i32* %5, align 4
  %72 = load i32, i32* %6, align 4
  %73 = load i32, i32* %5, align 4
  %74 = mul nsw i32 %73, 60
  %75 = sub nsw i32 %72, %74
  store i32 %75, i32* %6, align 4
  %76 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %77 = load i32, i32* %5, align 4
  %78 = load i32, i32* %6, align 4
  %79 = load float, float* %7, align 4
  %80 = fpext float %79 to double
  %81 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %76, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.4, i64 0, i64 0), i32 %77, i32 %78, double %80)
  store i32 1, i32* %2, align 4
  br label %82

82:                                               ; preds = %100, %46
  %83 = load i32, i32* %2, align 4
  %84 = icmp slt i32 %83, 100
  br i1 %84, label %85, label %103

85:                                               ; preds = %82
  %86 = load i32, i32* %2, align 4
  %87 = sub nsw i32 %86, 1
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds [100 x i64], [100 x i64]* @sort_array, i64 0, i64 %88
  %90 = load i64, i64* %89, align 8
  %91 = load i32, i32* %2, align 4
  %92 = sext i32 %91 to i64
  %93 = getelementptr inbounds [100 x i64], [100 x i64]* @sort_array, i64 0, i64 %92
  %94 = load i64, i64* %93, align 8
  %95 = icmp sgt i64 %90, %94
  br i1 %95, label %96, label %99

96:                                               ; preds = %85
  %97 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %98 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %97, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.3, i64 0, i64 0), i32 660)
  call void @exit(i32 1) #7
  unreachable

99:                                               ; preds = %85
  br label %100

100:                                              ; preds = %99
  %101 = load i32, i32* %2, align 4
  %102 = add nsw i32 %101, 1
  store i32 %102, i32* %2, align 4
  br label %82, !llvm.loop !5

103:                                              ; preds = %82
  store i32 0, i32* %2, align 4
  br label %104

104:                                              ; preds = %115, %103
  %105 = load i32, i32* %2, align 4
  %106 = icmp slt i32 %105, 100
  br i1 %106, label %107, label %118

107:                                              ; preds = %104
  %108 = load i32, i32* %2, align 4
  %109 = sext i32 %108 to i64
  %110 = getelementptr inbounds [100 x i64], [100 x i64]* @orig_array, i64 0, i64 %109
  %111 = load i64, i64* %110, align 8
  %112 = load i32, i32* %2, align 4
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds [100 x i64], [100 x i64]* @sort_array, i64 0, i64 %113
  store i64 %111, i64* %114, align 8
  br label %115

115:                                              ; preds = %107
  %116 = load i32, i32* %2, align 4
  %117 = add nsw i32 %116, 1
  store i32 %117, i32* %2, align 4
  br label %104, !llvm.loop !6

118:                                              ; preds = %104
  %119 = call i32 @pthread_get_nproc(i32* %4)
  store i32 %119, i32* %3, align 4
  %120 = icmp ne i32 %119, 0
  br i1 %120, label %121, label %126

121:                                              ; preds = %118
  %122 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %123 = load i32, i32* %3, align 4
  %124 = call i8* @strerror(i32 %123) #6
  %125 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %122, i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.3, i64 0, i64 0), i32 673, i8* %124)
  call void @exit(i32 1) #7
  unreachable

126:                                              ; preds = %118
  %127 = load i32, i32* %4, align 4
  %128 = icmp eq i32 %127, 1
  br i1 %128, label %129, label %130

129:                                              ; preds = %126
  store i32 4, i32* %4, align 4
  br label %130

130:                                              ; preds = %129, %126
  %131 = call i32 @gettimeofday(%struct.timeval* %8, i8* null) #6
  %132 = icmp ne i32 %131, 0
  br i1 %132, label %133, label %139

133:                                              ; preds = %130
  %134 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %135 = call i32* @__errno_location() #8
  %136 = load i32, i32* %135, align 4
  %137 = call i8* @strerror(i32 %136) #6
  %138 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %134, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.3, i64 0, i64 0), i32 689, i8* %137)
  call void @exit(i32 1) #7
  unreachable

139:                                              ; preds = %130
  %140 = load i32, i32* %4, align 4
  %141 = sext i32 %140 to i64
  call void @pthread_qsort(i8* bitcast ([100 x i64]* @sort_array to i8*), i64 100, i64 8, i32 (i8*, i8*)* @work_long, i64 %141)
  %142 = call i32 @gettimeofday(%struct.timeval* %9, i8* null) #6
  %143 = icmp ne i32 %142, 0
  br i1 %143, label %144, label %150

144:                                              ; preds = %139
  %145 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %146 = call i32* @__errno_location() #8
  %147 = load i32, i32* %146, align 4
  %148 = call i8* @strerror(i32 %147) #6
  %149 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %145, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.3, i64 0, i64 0), i32 698, i8* %148)
  call void @exit(i32 1) #7
  unreachable

150:                                              ; preds = %139
  %151 = getelementptr inbounds %struct.timeval, %struct.timeval* %9, i32 0, i32 0
  %152 = load i64, i64* %151, align 8
  %153 = getelementptr inbounds %struct.timeval, %struct.timeval* %8, i32 0, i32 0
  %154 = load i64, i64* %153, align 8
  %155 = sub nsw i64 %152, %154
  %156 = sitofp i64 %155 to double
  %157 = getelementptr inbounds %struct.timeval, %struct.timeval* %9, i32 0, i32 1
  %158 = load i64, i64* %157, align 8
  %159 = getelementptr inbounds %struct.timeval, %struct.timeval* %8, i32 0, i32 1
  %160 = load i64, i64* %159, align 8
  %161 = sub nsw i64 %158, %160
  %162 = sitofp i64 %161 to double
  %163 = fdiv double %162, 1.000000e+06
  %164 = fadd double %156, %163
  %165 = fptrunc double %164 to float
  store float %165, float* %7, align 4
  %166 = load float, float* %7, align 4
  %167 = fdiv float %166, 6.000000e+01
  %168 = fptosi float %167 to i32
  store i32 %168, i32* %6, align 4
  %169 = load float, float* %7, align 4
  %170 = load i32, i32* %6, align 4
  %171 = mul nsw i32 %170, 60
  %172 = sitofp i32 %171 to float
  %173 = fsub float %169, %172
  store float %173, float* %7, align 4
  %174 = load i32, i32* %6, align 4
  %175 = sdiv i32 %174, 60
  store i32 %175, i32* %5, align 4
  %176 = load i32, i32* %6, align 4
  %177 = load i32, i32* %5, align 4
  %178 = mul nsw i32 %177, 60
  %179 = sub nsw i32 %176, %178
  store i32 %179, i32* %6, align 4
  %180 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %181 = load i32, i32* %5, align 4
  %182 = load i32, i32* %6, align 4
  %183 = load float, float* %7, align 4
  %184 = fpext float %183 to double
  %185 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %180, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @.str.7, i64 0, i64 0), i32 %181, i32 %182, double %184)
  store i32 1, i32* %2, align 4
  br label %186

186:                                              ; preds = %204, %150
  %187 = load i32, i32* %2, align 4
  %188 = icmp slt i32 %187, 100
  br i1 %188, label %189, label %207

189:                                              ; preds = %186
  %190 = load i32, i32* %2, align 4
  %191 = sub nsw i32 %190, 1
  %192 = sext i32 %191 to i64
  %193 = getelementptr inbounds [100 x i64], [100 x i64]* @sort_array, i64 0, i64 %192
  %194 = load i64, i64* %193, align 8
  %195 = load i32, i32* %2, align 4
  %196 = sext i32 %195 to i64
  %197 = getelementptr inbounds [100 x i64], [100 x i64]* @sort_array, i64 0, i64 %196
  %198 = load i64, i64* %197, align 8
  %199 = icmp sgt i64 %194, %198
  br i1 %199, label %200, label %203

200:                                              ; preds = %189
  %201 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %202 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %201, i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.3, i64 0, i64 0), i32 719)
  call void @exit(i32 1) #7
  unreachable

203:                                              ; preds = %189
  br label %204

204:                                              ; preds = %203
  %205 = load i32, i32* %2, align 4
  %206 = add nsw i32 %205, 1
  store i32 %206, i32* %2, align 4
  br label %186, !llvm.loop !7

207:                                              ; preds = %186
  ret i32 1
}

; Function Attrs: nounwind
declare dso_local i64 @mrand48() #1

; Function Attrs: nounwind
declare dso_local i32 @gettimeofday(%struct.timeval*, i8*) #1

declare dso_local i32 @fprintf(%struct._IO_FILE*, i8*, ...) #2

; Function Attrs: nounwind
declare dso_local i8* @strerror(i32) #1

; Function Attrs: nounwind readnone willreturn
declare dso_local i32* @__errno_location() #3

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) #4

declare dso_local void @qsort(i8*, i64, i64, i32 (i8*, i8*)*) #2

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @work_long(i8* %0, i8* %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i64*, align 8
  %7 = alloca i64*, align 8
  store i8* %0, i8** %4, align 8
  store i8* %1, i8** %5, align 8
  %8 = load i8*, i8** %4, align 8
  %9 = bitcast i8* %8 to i64*
  store i64* %9, i64** %6, align 8
  %10 = load i8*, i8** %5, align 8
  %11 = bitcast i8* %10 to i64*
  store i64* %11, i64** %7, align 8
  %12 = load i64*, i64** %6, align 8
  %13 = load i64, i64* %12, align 8
  %14 = load i64*, i64** %7, align 8
  %15 = load i64, i64* %14, align 8
  %16 = icmp slt i64 %13, %15
  br i1 %16, label %17, label %18

17:                                               ; preds = %2
  store i32 -1, i32* %3, align 4
  br label %27

18:                                               ; preds = %2
  %19 = load i64*, i64** %6, align 8
  %20 = load i64, i64* %19, align 8
  %21 = load i64*, i64** %7, align 8
  %22 = load i64, i64* %21, align 8
  %23 = icmp sgt i64 %20, %22
  br i1 %23, label %24, label %25

24:                                               ; preds = %18
  store i32 1, i32* %3, align 4
  br label %27

25:                                               ; preds = %18
  br label %26

26:                                               ; preds = %25
  store i32 0, i32* %3, align 4
  br label %27

27:                                               ; preds = %26, %24, %17
  %28 = load i32, i32* %3, align 4
  ret i32 %28
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_mutex_init(%union.pthread_mutex_t*, %union.pthread_mutexattr_t*) #1

; Function Attrs: nounwind
declare dso_local i32 @pthread_cond_init(%union.pthread_cond_t*, %union.pthread_condattr_t*) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @pthread_qsort_split(i8* %0, i64 %1, i64 %2, i64 %3, i64* %4, i32 (i8*, i8*)* %5) #0 {
  %7 = alloca i8*, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  %11 = alloca i64*, align 8
  %12 = alloca i32 (i8*, i8*)*, align 8
  %13 = alloca i16, align 2
  %14 = alloca i64, align 8
  %15 = alloca i64, align 8
  %16 = alloca i64, align 8
  %17 = alloca i8*, align 8
  store i8* %0, i8** %7, align 8
  store i64 %1, i64* %8, align 8
  store i64 %2, i64* %9, align 8
  store i64 %3, i64* %10, align 8
  store i64* %4, i64** %11, align 8
  store i32 (i8*, i8*)* %5, i32 (i8*, i8*)** %12, align 8
  %18 = load i64, i64* %8, align 8
  %19 = alloca i8, i64 %18, align 16
  store i8* %19, i8** %17, align 8
  %20 = load i64, i64* %9, align 8
  %21 = load i64, i64* %10, align 8
  %22 = add i64 %20, %21
  %23 = udiv i64 %22, 2
  store i64 %23, i64* %16, align 8
  %24 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %12, align 8
  %25 = load i8*, i8** %7, align 8
  %26 = ptrtoint i8* %25 to i64
  %27 = load i64, i64* %16, align 8
  %28 = load i64, i64* %8, align 8
  %29 = mul i64 %27, %28
  %30 = add i64 %26, %29
  %31 = inttoptr i64 %30 to i8*
  %32 = load i8*, i8** %7, align 8
  %33 = ptrtoint i8* %32 to i64
  %34 = load i64, i64* %9, align 8
  %35 = load i64, i64* %8, align 8
  %36 = mul i64 %34, %35
  %37 = add i64 %33, %36
  %38 = inttoptr i64 %37 to i8*
  %39 = call i32 %24(i8* %31, i8* %38)
  %40 = icmp slt i32 %39, 0
  br i1 %40, label %41, label %46

41:                                               ; preds = %6
  %42 = load i8*, i8** %7, align 8
  %43 = load i64, i64* %8, align 8
  %44 = load i64, i64* %16, align 8
  %45 = load i64, i64* %9, align 8
  call void @pthread_qsort_swap(i8* %42, i64 %43, i64 %44, i64 %45)
  br label %46

46:                                               ; preds = %41, %6
  %47 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %12, align 8
  %48 = load i8*, i8** %7, align 8
  %49 = ptrtoint i8* %48 to i64
  %50 = load i64, i64* %10, align 8
  %51 = load i64, i64* %8, align 8
  %52 = mul i64 %50, %51
  %53 = add i64 %49, %52
  %54 = inttoptr i64 %53 to i8*
  %55 = load i8*, i8** %7, align 8
  %56 = ptrtoint i8* %55 to i64
  %57 = load i64, i64* %9, align 8
  %58 = load i64, i64* %8, align 8
  %59 = mul i64 %57, %58
  %60 = add i64 %56, %59
  %61 = inttoptr i64 %60 to i8*
  %62 = call i32 %47(i8* %54, i8* %61)
  %63 = icmp slt i32 %62, 0
  br i1 %63, label %64, label %69

64:                                               ; preds = %46
  %65 = load i8*, i8** %7, align 8
  %66 = load i64, i64* %8, align 8
  %67 = load i64, i64* %10, align 8
  %68 = load i64, i64* %9, align 8
  call void @pthread_qsort_swap(i8* %65, i64 %66, i64 %67, i64 %68)
  br label %69

69:                                               ; preds = %64, %46
  %70 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %12, align 8
  %71 = load i8*, i8** %7, align 8
  %72 = ptrtoint i8* %71 to i64
  %73 = load i64, i64* %10, align 8
  %74 = load i64, i64* %8, align 8
  %75 = mul i64 %73, %74
  %76 = add i64 %72, %75
  %77 = inttoptr i64 %76 to i8*
  %78 = load i8*, i8** %7, align 8
  %79 = ptrtoint i8* %78 to i64
  %80 = load i64, i64* %16, align 8
  %81 = load i64, i64* %8, align 8
  %82 = mul i64 %80, %81
  %83 = add i64 %79, %82
  %84 = inttoptr i64 %83 to i8*
  %85 = call i32 %70(i8* %77, i8* %84)
  %86 = icmp slt i32 %85, 0
  br i1 %86, label %87, label %92

87:                                               ; preds = %69
  %88 = load i8*, i8** %7, align 8
  %89 = load i64, i64* %8, align 8
  %90 = load i64, i64* %10, align 8
  %91 = load i64, i64* %16, align 8
  call void @pthread_qsort_swap(i8* %88, i64 %89, i64 %90, i64 %91)
  br label %92

92:                                               ; preds = %87, %69
  %93 = load i8*, i8** %17, align 8
  %94 = load i8*, i8** %7, align 8
  %95 = ptrtoint i8* %94 to i64
  %96 = load i64, i64* %16, align 8
  %97 = load i64, i64* %8, align 8
  %98 = mul i64 %96, %97
  %99 = add i64 %95, %98
  %100 = inttoptr i64 %99 to i8*
  %101 = load i64, i64* %8, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %93, i8* align 1 %100, i64 %101, i1 false)
  %102 = load i8*, i8** %7, align 8
  %103 = load i64, i64* %8, align 8
  %104 = load i64, i64* %16, align 8
  %105 = load i64, i64* %10, align 8
  %106 = sub i64 %105, 1
  call void @pthread_qsort_swap(i8* %102, i64 %103, i64 %104, i64 %106)
  %107 = load i64, i64* %9, align 8
  store i64 %107, i64* %14, align 8
  %108 = load i64, i64* %10, align 8
  %109 = sub i64 %108, 1
  store i64 %109, i64* %15, align 8
  store i16 0, i16* %13, align 2
  br label %110

110:                                              ; preds = %160, %92
  %111 = load i16, i16* %13, align 2
  %112 = sext i16 %111 to i32
  %113 = icmp eq i32 %112, 0
  br i1 %113, label %114, label %161

114:                                              ; preds = %110
  %115 = load i64, i64* %14, align 8
  %116 = add i64 %115, 1
  store i64 %116, i64* %14, align 8
  br label %117

117:                                              ; preds = %129, %114
  %118 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %12, align 8
  %119 = load i8*, i8** %7, align 8
  %120 = ptrtoint i8* %119 to i64
  %121 = load i64, i64* %14, align 8
  %122 = load i64, i64* %8, align 8
  %123 = mul i64 %121, %122
  %124 = add i64 %120, %123
  %125 = inttoptr i64 %124 to i8*
  %126 = load i8*, i8** %17, align 8
  %127 = call i32 %118(i8* %125, i8* %126)
  %128 = icmp slt i32 %127, 0
  br i1 %128, label %129, label %132

129:                                              ; preds = %117
  %130 = load i64, i64* %14, align 8
  %131 = add i64 %130, 1
  store i64 %131, i64* %14, align 8
  br label %117, !llvm.loop !8

132:                                              ; preds = %117
  %133 = load i64, i64* %15, align 8
  %134 = add i64 %133, -1
  store i64 %134, i64* %15, align 8
  br label %135

135:                                              ; preds = %147, %132
  %136 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %12, align 8
  %137 = load i8*, i8** %7, align 8
  %138 = ptrtoint i8* %137 to i64
  %139 = load i64, i64* %15, align 8
  %140 = load i64, i64* %8, align 8
  %141 = mul i64 %139, %140
  %142 = add i64 %138, %141
  %143 = inttoptr i64 %142 to i8*
  %144 = load i8*, i8** %17, align 8
  %145 = call i32 %136(i8* %143, i8* %144)
  %146 = icmp sgt i32 %145, 0
  br i1 %146, label %147, label %150

147:                                              ; preds = %135
  %148 = load i64, i64* %15, align 8
  %149 = add i64 %148, -1
  store i64 %149, i64* %15, align 8
  br label %135, !llvm.loop !9

150:                                              ; preds = %135
  %151 = load i64, i64* %14, align 8
  %152 = load i64, i64* %15, align 8
  %153 = icmp ult i64 %151, %152
  br i1 %153, label %154, label %159

154:                                              ; preds = %150
  %155 = load i8*, i8** %7, align 8
  %156 = load i64, i64* %8, align 8
  %157 = load i64, i64* %14, align 8
  %158 = load i64, i64* %15, align 8
  call void @pthread_qsort_swap(i8* %155, i64 %156, i64 %157, i64 %158)
  br label %160

159:                                              ; preds = %150
  store i16 1, i16* %13, align 2
  br label %160

160:                                              ; preds = %159, %154
  br label %110, !llvm.loop !10

161:                                              ; preds = %110
  %162 = load i8*, i8** %7, align 8
  %163 = load i64, i64* %8, align 8
  %164 = load i64, i64* %14, align 8
  %165 = load i64, i64* %10, align 8
  %166 = sub i64 %165, 1
  call void @pthread_qsort_swap(i8* %162, i64 %163, i64 %164, i64 %166)
  %167 = load i64, i64* %14, align 8
  %168 = load i64*, i64** %11, align 8
  store i64 %167, i64* %168, align 8
  ret void
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_attr_init(%union.pthread_attr_t*) #1

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #4

; Function Attrs: nounwind
declare dso_local i32 @pthread_attr_setdetachstate(%union.pthread_attr_t*, i32) #1

; Function Attrs: nounwind
declare dso_local i32 @pthread_create(i64*, %union.pthread_attr_t*, i8* (i8*)*, i8*) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal i8* @pthread_qsort_local_call(i8* %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca %struct.pthread_qsort_data_t*, align 8
  store i8* %0, i8** %2, align 8
  %4 = load i8*, i8** %2, align 8
  %5 = bitcast i8* %4 to %struct.pthread_qsort_data_t*
  store %struct.pthread_qsort_data_t* %5, %struct.pthread_qsort_data_t** %3, align 8
  %6 = load %struct.pthread_qsort_data_t*, %struct.pthread_qsort_data_t** %3, align 8
  %7 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %6, i32 0, i32 0
  %8 = load i8*, i8** %7, align 8
  %9 = load %struct.pthread_qsort_data_t*, %struct.pthread_qsort_data_t** %3, align 8
  %10 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %9, i32 0, i32 1
  %11 = load i64, i64* %10, align 8
  %12 = load %struct.pthread_qsort_data_t*, %struct.pthread_qsort_data_t** %3, align 8
  %13 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %12, i32 0, i32 2
  %14 = load i64, i64* %13, align 8
  %15 = load %struct.pthread_qsort_data_t*, %struct.pthread_qsort_data_t** %3, align 8
  %16 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %15, i32 0, i32 3
  %17 = load i64, i64* %16, align 8
  %18 = load %struct.pthread_qsort_data_t*, %struct.pthread_qsort_data_t** %3, align 8
  %19 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %18, i32 0, i32 4
  %20 = load i32 (i8*, i8*)*, i32 (i8*, i8*)** %19, align 8
  %21 = load %struct.pthread_qsort_data_t*, %struct.pthread_qsort_data_t** %3, align 8
  %22 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %21, i32 0, i32 5
  %23 = load i64, i64* %22, align 8
  call void @pthread_qsort_local(i8* %8, i64 %11, i64 %14, i64 %17, i32 (i8*, i8*)* %20, i64 %23)
  %24 = load %struct.pthread_qsort_data_t*, %struct.pthread_qsort_data_t** %3, align 8
  %25 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %24, i32 0, i32 6
  %26 = load %union.pthread_mutex_t*, %union.pthread_mutex_t** %25, align 8
  %27 = call i32 @pthread_mutex_lock(%union.pthread_mutex_t* %26) #6
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %29, label %30

29:                                               ; preds = %1
  call void @abort() #7
  unreachable

30:                                               ; preds = %1
  %31 = load %struct.pthread_qsort_data_t*, %struct.pthread_qsort_data_t** %3, align 8
  %32 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %31, i32 0, i32 8
  %33 = load i32*, i32** %32, align 8
  store i32 1, i32* %33, align 4
  %34 = load %struct.pthread_qsort_data_t*, %struct.pthread_qsort_data_t** %3, align 8
  %35 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %34, i32 0, i32 7
  %36 = load %union.pthread_cond_t*, %union.pthread_cond_t** %35, align 8
  %37 = call i32 @pthread_cond_signal(%union.pthread_cond_t* %36) #6
  %38 = icmp ne i32 %37, 0
  br i1 %38, label %39, label %40

39:                                               ; preds = %30
  call void @abort() #7
  unreachable

40:                                               ; preds = %30
  %41 = load %struct.pthread_qsort_data_t*, %struct.pthread_qsort_data_t** %3, align 8
  %42 = getelementptr inbounds %struct.pthread_qsort_data_t, %struct.pthread_qsort_data_t* %41, i32 0, i32 6
  %43 = load %union.pthread_mutex_t*, %union.pthread_mutex_t** %42, align 8
  %44 = call i32 @pthread_mutex_unlock(%union.pthread_mutex_t* %43) #6
  %45 = icmp ne i32 %44, 0
  br i1 %45, label %46, label %47

46:                                               ; preds = %40
  call void @abort() #7
  unreachable

47:                                               ; preds = %40
  ret i8* null
}

; Function Attrs: nounwind
declare dso_local i32 @pthread_mutex_lock(%union.pthread_mutex_t*) #1

declare dso_local i32 @pthread_cond_wait(%union.pthread_cond_t*, %union.pthread_mutex_t*) #2

; Function Attrs: nounwind
declare dso_local i32 @pthread_mutex_unlock(%union.pthread_mutex_t*) #1

; Function Attrs: nounwind
declare dso_local i32 @pthread_attr_destroy(%union.pthread_attr_t*) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @pthread_qsort_swap(i8* %0, i64 %1, i64 %2, i64 %3) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  %9 = alloca i8*, align 8
  store i8* %0, i8** %5, align 8
  store i64 %1, i64* %6, align 8
  store i64 %2, i64* %7, align 8
  store i64 %3, i64* %8, align 8
  %10 = load i64, i64* %6, align 8
  %11 = alloca i8, i64 %10, align 16
  store i8* %11, i8** %9, align 8
  %12 = load i8*, i8** %9, align 8
  %13 = load i8*, i8** %5, align 8
  %14 = ptrtoint i8* %13 to i64
  %15 = load i64, i64* %7, align 8
  %16 = load i64, i64* %6, align 8
  %17 = mul i64 %15, %16
  %18 = add i64 %14, %17
  %19 = inttoptr i64 %18 to i8*
  %20 = load i64, i64* %6, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %12, i8* align 1 %19, i64 %20, i1 false)
  %21 = load i8*, i8** %5, align 8
  %22 = ptrtoint i8* %21 to i64
  %23 = load i64, i64* %7, align 8
  %24 = load i64, i64* %6, align 8
  %25 = mul i64 %23, %24
  %26 = add i64 %22, %25
  %27 = inttoptr i64 %26 to i8*
  %28 = load i8*, i8** %5, align 8
  %29 = ptrtoint i8* %28 to i64
  %30 = load i64, i64* %8, align 8
  %31 = load i64, i64* %6, align 8
  %32 = mul i64 %30, %31
  %33 = add i64 %29, %32
  %34 = inttoptr i64 %33 to i8*
  %35 = load i64, i64* %6, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %27, i8* align 1 %34, i64 %35, i1 false)
  %36 = load i8*, i8** %5, align 8
  %37 = ptrtoint i8* %36 to i64
  %38 = load i64, i64* %8, align 8
  %39 = load i64, i64* %6, align 8
  %40 = mul i64 %38, %39
  %41 = add i64 %37, %40
  %42 = inttoptr i64 %41 to i8*
  %43 = load i8*, i8** %9, align 8
  %44 = load i64, i64* %6, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %42, i8* align 1 %43, i64 %44, i1 false)
  ret void
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #5

; Function Attrs: nounwind
declare dso_local i32 @pthread_cond_signal(%union.pthread_cond_t*) #1

attributes #0 = { noinline nounwind optnone uwtable "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone willreturn "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { argmemonly nofree nosync nounwind willreturn }
attributes #6 = { nounwind }
attributes #7 = { noreturn nounwind }
attributes #8 = { nounwind readnone willreturn }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.0-3ubuntu1~20.04.5"}
!2 = distinct !{!2, !3}
!3 = !{!"llvm.loop.mustprogress"}
!4 = distinct !{!4, !3}
!5 = distinct !{!5, !3}
!6 = distinct !{!6, !3}
!7 = distinct !{!7, !3}
!8 = distinct !{!8, !3}
!9 = distinct !{!9, !3}
!10 = distinct !{!10, !3}
