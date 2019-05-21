Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71B52257F1
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 21:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfEUTBc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 15:01:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44088 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfEUTBc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 15:01:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id w25so11715640qkj.11
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5MpwQ6tQ0aEMdn0ZXcDRd5/w2QuFnL63MJdz7xrMAhY=;
        b=bXe1bg8Y+y6/PnxGaoMykMkqwJ6MsysPM5nfEntQV6mNOKgpANWUhO4QAMARc7T0OK
         9ztXj9+xRsNinldIeA60nAdrgoIeEFxjT85VO+b/sK9nfWlNfBtOAaEyS/Wd0tDsBvoD
         dGIaYNGqCxV50ueLuISmSlV0YP0oBSPJwXe8ovFU8GZ6qgxAMt48DsRwrNkFQlGMTiNJ
         Aq1t20nNvIRx9zmzdDV6OHnvAviNrAa7RgBRA2NjEJyDUpp1cFZnln0JU+dXj3BXCtrX
         uyERKExcWE52bFO1fyXgaUcNZebidY+MlOJV7MEC1FeLKu8b4xzuRwkGBOl1cd21EmVE
         tW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5MpwQ6tQ0aEMdn0ZXcDRd5/w2QuFnL63MJdz7xrMAhY=;
        b=UEPDVba1KTD61SSXZGhJcaMGg/cDuOvz7NUyIh9dsdkwIrrAyvNHIylFd+bYcK/p0Z
         OKlfVA9zeoko44PT+T2BzbU/Cwy9H9as5SF0DMaXLg5/v4F7vaObN4mxQjMBvxU4Lf+y
         P/BUbGHC3uo0/a14OV9mjGfaHftGLsThoJivH4IVFLPNwdOSngu99IGwaDBL9XzE9vBm
         QBsTRTOnNFrdSaRGLzZ5gFrGYhBua8xQjUT34s6elfyB+Tr5D5WjbTpjamftNUCfZT64
         gyjlSDn89DtdI7cAvwNlXVrbmq/Gf6OUhPeyZVHPAQzFfItQPKtkSRyGdIffn29lqe/j
         i9JA==
X-Gm-Message-State: APjAAAWWy9j1aX7fYUHDfz1dk9Yf6y8MFFNdScpfzkRPox9Z86fW4j0x
        RgPnDgpkUQ9zfLet5S1aSd41L/+l8x4=
X-Google-Smtp-Source: APXvYqzDLzvxpQ2GturrissyGzs+0KSHJZtHRceZsE3LuYoFLmoveLSmJhJcxpG20J5vWqX8cVBpZA==
X-Received: by 2002:a05:620a:16b4:: with SMTP id s20mr65588371qkj.34.1558465290581;
        Tue, 21 May 2019 12:01:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id p28sm8832284qkj.14.2019.05.21.12.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 12:01:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTA0u-0007Cw-3g; Tue, 21 May 2019 16:01:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 3/7] build: Use the system PYTHON_EXECUTABLE for gen-sparse
Date:   Tue, 21 May 2019 16:01:20 -0300
Message-Id: <20190521190124.27486-4-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521190124.27486-1-jgg@ziepe.ca>
References: <20190521190124.27486-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

All python scripts run from cmake should use PYTHON_EXECUTABLE and must
support python3. Update gen-sparse's call to this standard.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 CMakeLists.txt             | 30 +++++++++++++++---------------
 buildlib/RDMA_Sparse.cmake |  2 +-
 buildlib/gen-sparse.py     | 11 ++++++-----
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 31100e267f2150..cfd4c3cbf9481e 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -170,6 +170,21 @@ endif()
 RDMA_BuildType()
 include_directories(${BUILD_INCLUDE})
 
+# Look for Python. We prefer some variant of python 3 if the system has it.
+FIND_PACKAGE(PythonInterp 3 QUIET)
+if (PythonInterp_FOUND)
+  # pyverbs can only use python3:
+  if (NO_PYVERBS)
+    set(CYTHON_EXECUTABLE "")
+  else()
+    FIND_PACKAGE(cython)
+  endif()
+else()
+  # But we still must have python (be it 2) for the build process:
+  FIND_PACKAGE(PythonInterp REQUIRED)
+  set(CYTHON_EXECUTABLE "")
+endif()
+
 RDMA_CheckSparse()
 
 # Require GNU99 mode
@@ -364,21 +379,6 @@ else()
   set(HAVE_FULL_SYMBOL_VERSIONS 1)
 endif()
 
-# Look for Python. We prefer some variant of python 3 if the system has it.
-FIND_PACKAGE(PythonInterp 3 QUIET)
-if (PythonInterp_FOUND)
-  # pyverbs can only use python3:
-  if (NO_PYVERBS)
-    set(CYTHON_EXECUTABLE "")
-  else()
-    FIND_PACKAGE(cython)
-  endif()
-else()
-  # But we still must have python (be it 2) for the build process:
-  FIND_PACKAGE(PythonInterp REQUIRED)
-  set(CYTHON_EXECUTABLE "")
-endif()
-
 # A cython & python-devel installation that matches our selected interpreter.
 
 if (CYTHON_EXECUTABLE)
diff --git a/buildlib/RDMA_Sparse.cmake b/buildlib/RDMA_Sparse.cmake
index 8fcfb758d5284f..3d03ce6283eec4 100644
--- a/buildlib/RDMA_Sparse.cmake
+++ b/buildlib/RDMA_Sparse.cmake
@@ -19,7 +19,7 @@ int main(int argc,const char *argv[]) {return 0;}
     set(HAVE_SPARSE TRUE PARENT_SCOPE)
 
     # Replace various glibc headers with our own versions that have embedded sparse annotations.
-    execute_process(COMMAND "${BUILDLIB}/gen-sparse.py"
+    execute_process(COMMAND "${PYTHON_EXECUTABLE}" "${BUILDLIB}/gen-sparse.py"
       "--out" "${BUILD_INCLUDE}/"
       "--src" "${CMAKE_SOURCE_DIR}/"
       RESULT_VARIABLE retcode)
diff --git a/buildlib/gen-sparse.py b/buildlib/gen-sparse.py
index c289da31c19d75..84781f4528feef 100755
--- a/buildlib/gen-sparse.py
+++ b/buildlib/gen-sparse.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # Copyright 2015-2017 Obsidian Research Corp.
 # Licensed under BSD (MIT variant) or GPLv2. See COPYING.
 import argparse
@@ -66,10 +66,10 @@ def apply_patch(src,patch,dest):
         subprocess.check_output(["patch","-f","--follow-symlinks","-V","never","-i",patch,"-o",dest,src]);
 
         if os.path.exists(dest + ".rej"):
-            print "Patch from %r failed"%(patch);
+            print("Patch from %r failed"%(patch));
             return False;
     except subprocess.CalledProcessError:
-        print "Patch from %r failed"%(patch);
+        print("Patch from %r failed"%(patch));
         return False;
     return True;
 
@@ -81,7 +81,7 @@ def replace_header(fn):
             return;
         tries = tries + 1;
 
-    print "Unable to apply any patch to %r, tries %u"%(fn,tries);
+    print("Unable to apply any patch to %r, tries %u"%(fn,tries));
     global failed;
     failed = True;
 
@@ -119,7 +119,8 @@ args = parser.parse_args();
 
 if args.save:
     # Get the glibc version string
-    ver = subprocess.check_output(["ldd","--version"]).splitlines()[0].split(' ')[-1];
+    ver = subprocess.check_output(["ldd","--version"]).decode()
+    ver = ver.splitlines()[0].split(' ')[-1];
     ver = ver.partition(".")[-1];
     outdir = os.path.join(args.SRC,"buildlib","sparse-include",ver);
     if not os.path.isdir(outdir):
-- 
2.21.0

