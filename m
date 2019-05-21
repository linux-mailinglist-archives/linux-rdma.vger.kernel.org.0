Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F15F5257F0
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 21:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfEUTBc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 15:01:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46167 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbfEUTBc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 15:01:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id a132so11696711qkb.13
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P2t3+c9ysN1rC5QhyAqJD0PA6V0JpRZ6T2st9xocQGk=;
        b=Te0MvSKYtVEhDN30fuRbCMzMeTnPtWXuO+EAQX5to0cf9Ewpn4i7xADYPUknqLBchv
         YO8owuWWK1P+UP/EfraODOwSuoLNBajLpzD76uGpG1G82q/4m9nOmQR/dYTZYImV0ML7
         Pue7SDUOHASqh7NzRNhHGex0kTCs32/C6iyd6ZO3QIc8OyQEOeWQspOJjBOYRLyvnXLq
         N83x1fXCqOxKEkyhyyn83b7P69c/bohCj7pRfpJCSMvS3pRr5vDnFzo7vmWjgHxbHlDJ
         5ETeINp68vx4JccPrLFMu+0FefJeeEVP32LIG35mvZ1refepflqHmTwZD9e5rZdgaEMp
         onJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P2t3+c9ysN1rC5QhyAqJD0PA6V0JpRZ6T2st9xocQGk=;
        b=QXxrEfb1UjiKEiHxiinbF53RFNXMYeKiYITQcUWQs4IEG0SZMkn7vI4unj2yg7tem0
         GnEt5pRxL2aeye4JQHHQwNqlVvQLSHYQ08kSXrWnMmO9PjTCfXeKkwv8kvSI2VGoOZg9
         ZEKvOL4e5HALEnJCZKPo04cZJO8LQ9Fazu2Fe+/Rat+5jYpzYfM+q1KFhaQMSvwuxvXd
         oUHmeDTtUPWE6jl/M+lKyOnVEGae7YgHSBoijnZlQ36mZa47KO4b0c9rDarkl2hZrZ+m
         SjBRZa7yA4D/Ov6N/ub0MJTLpwODLAkUDt6znjWOZY1zaijP42DJK1xsZA1igIYMB4QT
         hjbg==
X-Gm-Message-State: APjAAAVahe0HT/EGx3JV8Z6C++kVELi+ISkYqZgqlnI+rKZUiNEl8STd
        eWwDz8p2F/00eV3tQsSmHW8pjrbxUe4=
X-Google-Smtp-Source: APXvYqz2pPBnUqPI6+tkYzqzOYJad9TD9FJ5zd+7MeERtM1hzqUSM6xkM1WWt36fcEC2d0n7umbvcA==
X-Received: by 2002:a05:620a:1278:: with SMTP id b24mr63929018qkl.265.1558465291080;
        Tue, 21 May 2019 12:01:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id o37sm13734319qta.86.2019.05.21.12.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 12:01:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTA0u-0007D8-70; Tue, 21 May 2019 16:01:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 5/7] build: Revise how gen-sparse finds the system headers
Date:   Tue, 21 May 2019 16:01:22 -0300
Message-Id: <20190521190124.27486-6-jgg@ziepe.ca>
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

When the compiler is configured for true multi-arch the system headers are
not in /usr/include anymore, but in one of the arch specific directories.

Get gcc to give the include search path and look along that path for the
system header location for patching.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/RDMA_Sparse.cmake |  1 +
 buildlib/gen-sparse.py     | 30 ++++++++++++++++++++++++++----
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/buildlib/RDMA_Sparse.cmake b/buildlib/RDMA_Sparse.cmake
index 3d03ce6283eec4..72581fe5ceb9cf 100644
--- a/buildlib/RDMA_Sparse.cmake
+++ b/buildlib/RDMA_Sparse.cmake
@@ -22,6 +22,7 @@ int main(int argc,const char *argv[]) {return 0;}
     execute_process(COMMAND "${PYTHON_EXECUTABLE}" "${BUILDLIB}/gen-sparse.py"
       "--out" "${BUILD_INCLUDE}/"
       "--src" "${CMAKE_SOURCE_DIR}/"
+      "--cc" "${CMAKE_C_COMPILER}"
       RESULT_VARIABLE retcode)
     if(NOT "${retcode}" STREQUAL "0")
       message(FATAL_ERROR "glibc header file patching for sparse failed. Review include/*.rej and fix the rejects, then do "
diff --git a/buildlib/gen-sparse.py b/buildlib/gen-sparse.py
index 67e64de3202331..fe428b42a97462 100755
--- a/buildlib/gen-sparse.py
+++ b/buildlib/gen-sparse.py
@@ -5,6 +5,7 @@ import argparse
 import subprocess
 import os
 import collections
+import re
 
 headers = {
     "bits/sysmacros.h",
@@ -25,6 +26,27 @@ def norm_header(fn):
             return I;
     return None;
 
+def find_system_header(args,hdr):
+    """/usr/include is not always where the include files are, particularly if we
+    are running full multi-arch as the azure_pipeline container does. Get gcc
+    to tell us where /usr/include is"""
+    if "incpath" not in args:
+        cpp = subprocess.check_output([args.cc, "-print-prog-name=cpp"],universal_newlines=True).strip()
+        data = subprocess.check_output([cpp, "-v"],universal_newlines=True,stdin=subprocess.DEVNULL,
+                                       stderr=subprocess.STDOUT)
+        args.incpath = [];
+        for incdir in re.finditer(r"^ (/\S+)$", data, re.MULTILINE):
+            incdir = incdir.group(1)
+            if "fixed" in incdir:
+                continue;
+            args.incpath.append(incdir)
+
+    for incdir in args.incpath:
+        fn = os.path.join(incdir,hdr)
+        if os.path.exists(fn):
+            return fn
+    raise ValueError("Could not find system include directory.");
+
 def get_buildlib_patches(dfn):
     """Within the buildlib directory we store patches for the glibc headers. Each
     patch is in a numbered sub directory that indicates the order to try, the
@@ -78,7 +100,7 @@ def apply_patch(src,patch,dest):
 def replace_header(fn):
     tries = 0;
     for pfn in patches[fn]:
-        if apply_patch(os.path.join(args.REF,fn),
+        if apply_patch(find_system_header(args,fn),
                        pfn,os.path.join(args.INCLUDE,fn)):
             return;
         tries = tries + 1;
@@ -100,7 +122,7 @@ def save(fn,outdir):
     with open(flatfn,"wt") as F:
         try:
             subprocess.check_call(["diff","-u",
-                                   os.path.join(args.REF,fn),
+                                   find_system_header(args,fn),
                                    os.path.join(args.INCLUDE,fn)],
                                   stdout=F);
         except subprocess.CalledProcessError as ex:
@@ -113,8 +135,8 @@ parser.add_argument("--out",dest="INCLUDE",required=True,
                     help="Directory to write header files to");
 parser.add_argument("--src",dest="SRC",required=True,
                     help="Top of the source tree");
-parser.add_argument("--ref",dest="REF",default="/usr/include/",
-                    help="System headers to manipulate");
+parser.add_argument("--cc",default="gcc",
+                    help="System compiler to use to locate the default system headers");
 parser.add_argument("--save",action="store_true",default=False,
                     help="Save mode will write the current content of the headers to buildlib as a diff.");
 args = parser.parse_args();
-- 
2.21.0

