Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA6A2B5244
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgKPUQW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:16:22 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11997 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbgKPUQV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 15:16:21 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2de1e0001>; Mon, 16 Nov 2020 12:16:30 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:16:20 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:16:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqxdJwLIMj/T/gEu8I0n+LHtd0JHdd7pmWocgqZyeutEy15BKDAQq+983DzPaHn7e7YHBLGJYcBynQbmeQgwVgeEyLys7l5gpIkeMldvaizBZW14tueYyyWyfvaiqWyGkD/Eg5sxcoJjMEhX1f39cdYNZ/8PxyVtfBFnlro1LZZBAyahViMFt+V48lJcMuqN9e7EufMim9/VOdHH8MGonxJFCFuocPrqYjla7Tlt8f9/f4kFT2oGfARuGohcvUBaAk8YwRjvEQP24VceSUJ6MEK+4MWTgXa+IbIRPybUo6wkUbwRP49WcwjTbP2ZQ3AD/7ipEawwifClWsvjnyxXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPNCuKOxdVgADTdxhvq0pU9C2ZUChbdl5OcB2L5rMMk=;
 b=ePM+DZyR0pkQdUtPbHlze2i7/CaVG6M5B8YdSOWgoBRWr2zclc0SgpBr/AH9UbN5tS8WJRcOH8T9bg4pkhx60cIsehGq0pUZQSk2Nup3jJ1XmJvq+SDF799X4YUAau9JalB60MSlyUK4huqc+JAnS4VYpap4q4oUL8Y4bO01DAcpqHXUwQAs1aj+mBf9JyUgzoR7F6mzpuexcfBQ33FY4havVnl5FHSMPqhwFrZHlckQBqlbnRm9/iGwYJHvzMcCSK39BNxCrFBBLb57cuRrWPfC4tv8v13XnDEl8z7LpmMi65wMeJ2ISFuqOXaZZgCOv6SJbQfqDo8dIZ5qs+OKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4810.namprd12.prod.outlook.com (2603:10b6:5:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 16 Nov
 2020 20:16:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:16:19 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
Subject: [PATCH 4/4] util: Use GCC 10's attribute symver to define compat symbol versions
Date:   Mon, 16 Nov 2020 16:16:16 -0400
Message-ID: <4-v1-f03f70229014+144-fix_lto_jgg@nvidia.com>
In-Reply-To: <0-v1-f03f70229014+144-fix_lto_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 20:16:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kekvA-006kmJ-Nr     for linux-rdma@vger.kernel.org; Mon, 16 Nov 2020 16:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605557790; bh=+igmOoWzzOVgWRl7NVGOd4YgqTlBSGeDQKeBMfmqGNs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=KDZHMUiHsi87rWtS93k4q8BWFIkRJZ4iBWP2kL01UQuQUDZrB4lwMySSa6FFIVxG6
         9q1N8/Bry8/jahwlIpayd6qR14HSmeQfkTGsnHwlCVwh6tv8xOBhw3eM7hY4QyVyYO
         GqCB+eV9Y7MSJUaUnL4rQu1FFoA6U08wxEmsS/A47AEqmD5z+ognPM8Q54HI5dRasu
         8BP7f4IGH2QD9HEvZkfbvkYYAs8MV3sl/uSZm/bzpgkvpAiXueo8xe/n2ASR5zaRIK
         fmKlnkv6FGxm/6GXm47sT7dUClJu6Sjes/Ns/BW7LvRHoI0OT3UnjgMETSQVf1/tTE
         GfEFdPTEbKzlA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This has no behavior change but allows LTO to be used to build rdma-core.
Also remove the LTO disablement in the spec files since it works now.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 CMakeLists.txt              | 13 +++++++++++++
 buildlib/FindLDSymVer.cmake | 28 +++++++++++++++++++---------
 buildlib/config.h.in        |  2 ++
 redhat/rdma-core.spec       |  7 -------
 suse/rdma-core.spec         |  2 --
 util/symver.h               |  9 +++++++--
 6 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index ab9caff1f68d02..33fd120f23581a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -282,6 +282,16 @@ CHECK_C_SOURCE_COMPILES("
   HAVE_FUNC_ATTRIBUTE_IFUNC
   FAIL_REGEX "warning")
=20
+CHECK_C_SOURCE_COMPILES("
+ #include <unistd.h>
+
+ void _sym(void);
+ __attribute__((__symver__(\"sym@TEST_1.1\"))) void _sym(void) {}
+
+ int main(int argc,const char *argv[]) { _sym(); }"
+  HAVE_FUNC_ATTRIBUTE_SYMVER
+  FAIL_REGEX "warning")
+
 # The code does not do the racy fcntl if the various CLOEXEC's are not
 # supported so it really doesn't work right if this isn't available. Thus =
hard
 # require it.
@@ -700,6 +710,9 @@ endif()
 if (NOT HAVE_FUNC_ATTRIBUTE_IFUNC)
   message(STATUS " Compiler attribute ifunc NOT supported")
 endif()
+if (NOT HAVE_FUNC_ATTRIBUTE_SYMVER)
+  message(STATUS " Compiler attribute symver NOT supported, can not use LT=
O")
+endif()
 if (NOT HAVE_COHERENT_DMA)
   message(STATUS " Architecture NOT able to do coherent DMA (check util/ud=
ma_barrier.h) some providers disabled!")
 endif()
diff --git a/buildlib/FindLDSymVer.cmake b/buildlib/FindLDSymVer.cmake
index 48238f2407f4fd..d4065d92220a6e 100644
--- a/buildlib/FindLDSymVer.cmake
+++ b/buildlib/FindLDSymVer.cmake
@@ -27,15 +27,25 @@ else()
 endif()
=20
 # And matching source, this also checks that .symver asm works
-check_c_source_compiles("
-void ibv_get_device_list_1(void);
-void ibv_get_device_list_1(void){}
-asm(\".symver ibv_get_device_list_1, ibv_get_device_list@IBVERBS_1.1\");
-void ibv_get_device_list_0(void);
-void ibv_get_device_list_0(void){}
-asm(\".symver ibv_get_device_list_0, ibv_get_device_list@@IBVERBS_1.0\");
-
-int main(int argc,const char *argv[]){return 0;}" _LDSYMVER_SUCCESS)
+if (HAVE_FUNC_ATTRIBUTE_SYMVER)
+  check_c_source_compiles("
+  void ibv_get_device_list_1(void);
+  __attribute((__symver__(\"ibv_get_device_list@IBVERBS_1.1\")))
+  void ibv_get_device_list_1(void){}
+  void ibv_get_device_list_0(void);
+  __attribute((__symver__(\"ibv_get_device_list@IBVERBS_1.0\")))
+  void ibv_get_device_list_0(void){}
+  int main(int argc,const char *argv[]){return 0;}" _LDSYMVER_SUCCESS)
+else()
+  check_c_source_compiles("
+  void ibv_get_device_list_1(void);
+  void ibv_get_device_list_1(void){}
+  asm(\".symver ibv_get_device_list_1, ibv_get_device_list@IBVERBS_1.1\");
+  void ibv_get_device_list_0(void);
+  void ibv_get_device_list_0(void){}
+  asm(\".symver ibv_get_device_list_0, ibv_get_device_list@@IBVERBS_1.0\")=
;
+  int main(int argc,const char *argv[]){return 0;}" _LDSYMVER_SUCCESS)
+endif()
=20
 file(REMOVE "${CMAKE_CURRENT_BINARY_DIR}/test.map")
 set(CMAKE_EXE_LINKER_FLAGS "${SAFE_CMAKE_EXE_LINKER_FLAGS}")
diff --git a/buildlib/config.h.in b/buildlib/config.h.in
index e22e136a5878aa..c5b0bf55709d03 100644
--- a/buildlib/config.h.in
+++ b/buildlib/config.h.in
@@ -46,6 +46,8 @@
=20
 #cmakedefine HAVE_FUNC_ATTRIBUTE_IFUNC 1
=20
+#cmakedefine HAVE_FUNC_ATTRIBUTE_SYMVER 1
+
 #cmakedefine HAVE_WORKING_IF_H 1
=20
 // Operating mode for symbol versions
diff --git a/redhat/rdma-core.spec b/redhat/rdma-core.spec
index e1ee0801344a45..179f4a61aca9a9 100644
--- a/redhat/rdma-core.spec
+++ b/redhat/rdma-core.spec
@@ -279,13 +279,6 @@ easy, object-oriented access to IB verbs.
 %setup
=20
 %build
-# This package uses top level ASM constructs which are incompatible with L=
TO.
-# Top level ASMs are often used to implement symbol versioning.  gcc-10
-# introduces a new mechanism for symbol versioning which works with LTO.
-# Converting packages to use that mechanism instead of toplevel ASMs is
-# recommended.
-# Disable LTO
-%define _lto_cflags %{nil}
=20
 # New RPM defines _rundir, usually as /run
 %if 0%{?_rundir:1}
diff --git a/suse/rdma-core.spec b/suse/rdma-core.spec
index c89ecba6242f1f..229c75bb0118f7 100644
--- a/suse/rdma-core.spec
+++ b/suse/rdma-core.spec
@@ -389,8 +389,6 @@ Pyverbs is a Cython-based Python API over libibverbs, p=
roviding an
 easy, object-oriented access to IB verbs.
=20
 %prep
-# Make sure LTO is disable as rdma-core fails to compile with LTO enabled
-%define _lto_cflags %{nil}
 %setup -q -n  %{name}-%{version}%{git_ver}
=20
 %build
diff --git a/util/symver.h b/util/symver.h
index ae413050650e0f..eb14c57ebdc132 100644
--- a/util/symver.h
+++ b/util/symver.h
@@ -58,11 +58,16 @@
   warnings.  See also Documentation/versioning.md
 */
=20
+#if HAVE_FUNC_ATTRIBUTE_SYMVER
 #define _MAKE_SYMVER(_local_sym, _public_sym, _ver_str)                   =
     \
-	asm(".symver " #_local_sym "," #_public_sym "@" _ver_str)
+	__attribute__((__symver__(#_public_sym "@" _ver_str)))
+#else
+#define _MAKE_SYMVER(_local_sym, _public_sym, _ver_str)                   =
     \
+	asm(".symver " #_local_sym "," #_public_sym "@" _ver_str);
+#endif
 #define _MAKE_SYMVER_FUNC(_public_sym, _uniq, _ver_str, _ret, ...)        =
     \
 	_ret __##_public_sym##_##_uniq(__VA_ARGS__);                           \
-	_MAKE_SYMVER(__##_public_sym##_##_uniq, _public_sym, _ver_str);        \
+	_MAKE_SYMVER(__##_public_sym##_##_uniq, _public_sym, _ver_str)         \
 	_ret __##_public_sym##_##_uniq(__VA_ARGS__)
=20
 #if defined(HAVE_FULL_SYMBOL_VERSIONS) && !defined(_STATIC_LIBRARY_BUILD_)
--=20
2.29.2

