Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1BA71FF5
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfGWTLk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:11:40 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39388 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfGWTLk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:11:40 -0400
Received: by mail-qk1-f194.google.com with SMTP id w190so31920319qkc.6
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lz5MTuqfXxvjBuzR2PQib/9Vw5DvcY8g/qxbQf+4H0w=;
        b=ix3BFGlI2C69ooNZ/av43hDls0gSGoiqHEykLzmHkAVl2fZj4TBDd/hekwoExc99tI
         sTuK8oqKoa6F+3aprpImFSxruHonDHCM05yow1wnRyBJon2nHJN+osTNm1luagjcvGy1
         hv7NahnJW9D8eCEhqIV9P7SJsleWP42ZbgYaDJ+j3/s0kfw04vUDwlg9WHvPTQzZz08Q
         obIxEUTQgPZMRdn8cqpw6X1I+E/+1ANnvtT56q0kMJEy9fPC8jrNjjqRHeYPB809U2tc
         LWpbG9K/fCRNyj474hsYdGgiZRSNkn/YTON6oQioiOpEMUdMPcPEVtKG/aC4zo3L6uWx
         qqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lz5MTuqfXxvjBuzR2PQib/9Vw5DvcY8g/qxbQf+4H0w=;
        b=ND0+NxdRlLHskurgEGzgx3VRLLM8+1+SvVd8J3g5LY6xawmwGyiXka5vq+0ransTlR
         uGn5vJnGOwCqF5wyf5HxE4Urn5poQ4bAsggqN5g52wGBgDM4TWJuCab2rBqBZEEKKEUu
         ee0yhFSSl6LGI4nHq0v5SWMThcl5/22drr/iS2qt1ULPRSFh9Y/vdDx6YWfN5E8ivf0K
         sBlcEHpgseCl4hEWRIg1MxrjnQj00JnPuIPE8ohUXwc7KhbnyR01/8wOuq/Z1RaIYCnr
         5jiV9PlcEuS8QnW9WEEbK7PDiG+areijgacpsjJF6jqSWApkSsG0GBih47aeE6ieW1w8
         Xoiw==
X-Gm-Message-State: APjAAAUeHfbdktTjbCE7AQGLZQltd/2MKkhHIphysGAQWGYJX1ATZzQS
        IkHf/yepz0aUL/5OaoivJAMdRW/Vr+jx8w==
X-Google-Smtp-Source: APXvYqxmkTKGUrnclMbj2q2i+tZZvdlVQox0lDw1CNIjmmoJpa01MXlCVgxW6mO3c8p8CLZ/esCZRg==
X-Received: by 2002:a05:620a:12f8:: with SMTP id f24mr54193322qkl.202.1563909098849;
        Tue, 23 Jul 2019 12:11:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z1sm20214939qke.122.2019.07.23.12.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:11:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-000451-Py; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 13/19] build/azp: Update check-build to work with python3
Date:   Tue, 23 Jul 2019 16:01:31 -0300
Message-Id: <20190723190137.15370-14-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723190137.15370-1-jgg@ziepe.ca>
References: <20190723190137.15370-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Remove dependencies on python2.7 so it can be removed from the container.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/azure-pipelines.yml | 10 +++++---
 buildlib/cbuild              |  7 +++--
 buildlib/check-build         | 50 +++++++++++++++++++-----------------
 3 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/buildlib/azure-pipelines.yml b/buildlib/azure-pipelines.yml
index 7df483e3329534..39188a4c0b727b 100644
--- a/buildlib/azure-pipelines.yml
+++ b/buildlib/azure-pipelines.yml
@@ -44,11 +44,13 @@ stages:
               ninja
             displayName: gcc 9.1 Compile
 
-          - bash: |
-              set -e
-              cd build-gcc9
-              python2.7 ../buildlib/check-build --src .. --cc gcc-9
+          - task: PythonScript@0
             displayName: Check Build Script
+            inputs:
+              scriptPath: buildlib/check-build
+              arguments: --src .. --cc gcc-9
+              workingDirectory: build-gcc9
+              pythonInterpreter: /usr/bin/python3
 
           # Run sparse on the subdirectories which are sparse clean
           - bash: |
diff --git a/buildlib/cbuild b/buildlib/cbuild
index 1441a91a8427fd..1de550e7bf8934 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -903,8 +903,11 @@ def run_azp_build(args,env):
             script.append(I["bash"]);
         elif I.get("task") == "PythonScript@0":
             script.append("set -e");
-            script.append("%s %s"%(I["inputs"]["pythonInterpreter"],
-                                   I["inputs"]["scriptPath"]));
+            if "workingDirectory" in I["inputs"]:
+                script.append("cd %s"%(os.path.join(srcdir,I["inputs"]["workingDirectory"])));
+            script.append("%s %s %s"%(I["inputs"]["pythonInterpreter"],
+                                      os.path.join(srcdir,I["inputs"]["scriptPath"]),
+                                      I["inputs"].get("arguments","")));
         else:
             raise ValueError("Unknown stanza %r"%(I));
 
diff --git a/buildlib/check-build b/buildlib/check-build
index 82812272b40b1d..acb72f0e1f2588 100755
--- a/buildlib/check-build
+++ b/buildlib/check-build
@@ -1,7 +1,8 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # Copyright 2017 Obsidian Research Corp.
 # Licensed under BSD (MIT variant) or GPLv2. See COPYING.
 """check-build - Run static checks on a build"""
+from __future__ import print_function
 import argparse
 import inspect
 import os
@@ -18,7 +19,7 @@ from distutils.version import LooseVersion;
 
 def get_src_dir():
     """Get the source directory using git"""
-    git_top = subprocess.check_output(["git","rev-parse","--git-dir"]).strip();
+    git_top = subprocess.check_output(["git","rev-parse","--git-dir"]).decode().strip();
     if git_top == ".git":
         return ".";
     return os.path.dirname(git_top);
@@ -55,7 +56,8 @@ def private_tmp():
 
 def get_symbol_vers(fn,exported=True):
     """Return the symbol version suffixes from the ELF file, eg IB_VERBS_1.0, etc"""
-    syms = subprocess.check_output(["readelf","--wide","-s",fn]);
+    syms = subprocess.check_output(["readelf","--wide","-s",fn]).decode();
+
     go = False;
     res = set();
     for I in syms.splitlines():
@@ -166,7 +168,7 @@ def check_abi(args,fn):
                            "-o",cur_fn]);
 
     if not os.path.exists(ref_fn):
-        print >> sys.stderr, "ABI file does not exist for %r"%(ref_fn);
+        print("ABI file does not exist for %r"%(ref_fn), file=sys.stderr);
         return False;
 
     subprocess.check_call(["abi-compliance-checker",
@@ -183,7 +185,7 @@ def test_verbs_uapi(args):
 
     # User must provide the ABI dir in the source tree
     if not os.path.isdir(os.path.join(args.SRC,"ABI")):
-        print "ABI check skipped, no ABI/ directory.";
+        print("ABI check skipped, no ABI/ directory.");
         return;
 
     libd = os.path.join(args.BUILD,"lib");
@@ -221,24 +223,24 @@ def get_headers(incdir):
     return includes;
 
 def compile_test_headers(tmpd,incdir,includes,with_cxx=False):
-    cppflags = subprocess.check_output(["pkg-config","libnl-3.0","--cflags-only-I"]).strip();
+    cppflags = subprocess.check_output(["pkg-config","libnl-3.0","--cflags-only-I"]).decode().strip();
     cppflags = "-I %s %s"%(incdir,cppflags)
     with open(os.path.join(tmpd,"build.ninja"),"wt") as F:
-        print >> F,"rule comp";
-        print >> F," command = %s -Werror -c %s $in -o $out"%(args.CC,cppflags);
-        print >> F," description=Header check for $in";
-        print >> F,"rule comp_cxx";
-        print >> F," command = %s -Werror -c %s $in -o $out"%(args.CXX,cppflags);
-        print >> F," description=Header C++ check for $in";
+        print("rule comp", file=F);
+        print(" command = %s -Werror -c %s $in -o $out"%(args.CC,cppflags), file=F);
+        print(" description=Header check for $in", file=F);
+        print("rule comp_cxx", file=F);
+        print(" command = %s -Werror -c %s $in -o $out"%(args.CXX,cppflags), file=F);
+        print(" description=Header C++ check for $in", file=F);
         count = 0;
         for I in sorted(includes):
             if is_obsolete(I) or is_fixup(I):
                 continue;
-            print >> F,"build %s : comp %s"%("out%d.o"%(count),I);
-            print >> F,"default %s"%("out%d.o"%(count));
-            print >> F,"build %s : comp_cxx %s"%("outxx%d.o"%(count),I);
+            print("build %s : comp %s"%("out%d.o"%(count),I), file=F);
+            print("default %s"%("out%d.o"%(count)), file=F);
+            print("build %s : comp_cxx %s"%("outxx%d.o"%(count),I), file=F);
             if with_cxx:
-                print >> F,"default %s"%("outxx%d.o"%(count));
+                print("default %s"%("outxx%d.o"%(count)), file=F);
             count = count + 1;
     subprocess.check_call(["ninja"],cwd=tmpd);
 
@@ -286,7 +288,7 @@ def test_installed_headers(args):
         subprocess.check_output(["ninja","install"],env=env,cwd=args.BUILD);
 
         includes = get_headers(tmpd);
-        incdir = os.path.commonprefix(includes);
+        incdir = os.path.commonprefix(list(includes));
         rincludes = {I[len(incdir):] for I in includes};
 
         bincdir = os.path.abspath(os.path.join(args.BUILD,"include"));
@@ -308,7 +310,7 @@ def test_installed_headers(args):
                 os.makedirs(dfn);
             assert not os.path.exists(I);
             with open(I,"w") as F:
-                print >> F,'#error "Private internal header"';
+                print('#error "Private internal header"', file=F);
 
         # Roughly check that the headers have the extern "C" for C++
         # compilation.
@@ -324,7 +326,7 @@ def test_installed_headers(args):
 
 def get_symbol_names(fn):
     """Return the defined, public, symbols from a ELF shlib"""
-    syms = subprocess.check_output(["readelf", "--wide", "-s", fn])
+    syms = subprocess.check_output(["readelf", "--wide", "-s", fn]).decode()
     go = False
     res = set()
     for I in syms.splitlines():
@@ -352,7 +354,7 @@ def get_cc_args_from_pkgconfig(args, name, static):
     flags = ["pkg-config", "--errors-to-stdout", "--cflags", "--libs"]
     if static:
         flags.append("--static")
-    opts = subprocess.check_output(flags + ["lib" + name])
+    opts = subprocess.check_output(flags + ["lib" + name]).decode()
     opts = shlex.split(opts)
 
     opts.insert(0, "-Wall")
@@ -365,7 +367,7 @@ def get_cc_args_from_pkgconfig(args, name, static):
     # The old pkg-config that travis uses incorrectly removes duplicated
     # flags, which breaks linking.
     if (name == "ibverbs" and
-        subprocess.check_output(["pkg-config", "--version"]).strip() == "0.26"):
+        subprocess.check_output(["pkg-config", "--version"]).decode().strip() == "0.26"):
         opts.insert(0, "-libverbs")
 
     # Only static link the pkg-config stuff, otherwise we get warnings about
@@ -392,7 +394,7 @@ def get_cc_args_from_pkgconfig(args, name, static):
 
 
 def compile_ninja(args, Fninja, name, cfn, opts):
-    print >> Fninja, """
+    print("""
 rule comp_{name}
     command = {CC} -Wall -o $out $in {opts}
     description = Compile and link $out
@@ -401,7 +403,7 @@ default {name}""".format(
         name=name,
         CC=args.CC,
         cfn=cfn,
-        opts=" ".join(pipes.quote(I) for I in opts))
+        opts=" ".join(pipes.quote(I) for I in opts)), file=Fninja)
 
 
 def get_providers(args):
@@ -510,6 +512,6 @@ args.SRC = os.path.abspath(args.SRC);
 args.PACKAGE_VERSION = get_package_version(args);
 
 funcs = globals();
-for k,v in funcs.items():
+for k,v in list(funcs.items()):
     if k.startswith("test_") and inspect.isfunction(v):
         v(args);
-- 
2.22.0

