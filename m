Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C10A71FF4
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfGWTLj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:11:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45849 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfGWTLj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:11:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id x22so38053731qtp.12
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7z7AyjDUrHUPyguGqWPdnXY6cT/lWyMNV1dB37o5Ea8=;
        b=lSAbCI6gV8OJNe4zojBPVvl3+qNZv+sQg19zGPkbeYp26M1ARSyuCMrbgCUZ61c2ck
         RyUZ3RNI7+kWm6mpXumFIrQkzpikeZnGrTTytkGoO33lOsSN1C/Zkk866Oap/q14k7+n
         y9o4nksH8zo2HQy/afvoIoYhoXL1dVR71E5y90eZ+pI7MvTkiBHYQcNzAn66Nn6mWw1N
         RdLMKe4AX/jSHObbOzVcY+/Sn7+mL4xnsztBa8ZpIeJoU5JpUGFELSK/qZlKWHsXUA9b
         DktNdyh/lm1U2pVDuyRDsDc+yFt58t6COpYb2gkinLgg8zEzrGpIG+0WwvitCfF9J2W9
         1rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7z7AyjDUrHUPyguGqWPdnXY6cT/lWyMNV1dB37o5Ea8=;
        b=VbtrFROM6NxoB/QT10Q/MyjBtEiqM6jVU1KVk+AGNK/+yCuP8bmL8cjRA0WsqDq+9I
         Z/8xjfgvf4IMtFugU83RVbM2W6mPdq/vGBA5WkawAsq/axNQjDbUz201uP5oG49RKwit
         o2W+PPo+A6FevAktYJoUS1Ow6zyRNrEfVq5Vbo9JM4MkcdT49OuC2AbZ6DCphcHWEIvu
         BY6Yg02WXcBWZMj+vrzKmJSG9wcjpxUcLH5IINnb867k5cwsup8D1TvXdWomg150pNzp
         i0+3tGbbErovbp4Xs5Ui4XCQhWPz5Ynl/hEOLM+IVLaMVSpgMVfDoZRTGjs/N6EmCASX
         cVfw==
X-Gm-Message-State: APjAAAVrjNTU3UZyb3yQgPPrizDo8zi2GPZrOjMCdZksKezG8w8imarv
        zQvg7PDeHns3gWQycMhTTjP50U3VAA9qeg==
X-Google-Smtp-Source: APXvYqzoI9ragMjdViMfW4R93TiFofAVawSHIfT7cbMiWVdCouJlwrIVAePKTg0DdvYyWcZlka4x0g==
X-Received: by 2002:ac8:c0e:: with SMTP id k14mr54165396qti.72.1563909096835;
        Tue, 23 Jul 2019 12:11:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 131sm20115725qkn.7.2019.07.23.12.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:11:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-000457-R7; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 14/19] build/cbuild: Update cbuild to work with python3
Date:   Tue, 23 Jul 2019 16:01:32 -0300
Message-Id: <20190723190137.15370-15-jgg@ziepe.ca>
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

This is the last script run from azp that was using python2.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/azure-pipelines.yml |  2 +-
 buildlib/cbuild              | 53 +++++++++++++++++++-----------------
 2 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/buildlib/azure-pipelines.yml b/buildlib/azure-pipelines.yml
index 39188a4c0b727b..e062908e23756b 100644
--- a/buildlib/azure-pipelines.yml
+++ b/buildlib/azure-pipelines.yml
@@ -134,7 +134,7 @@ stages:
               ninja docs
               cd ../artifacts
               # FIXME: Check Build.SourceBranch for tag consistency
-              python2.7 ../buildlib/cbuild make-dist-tar ../build-pandoc
+              python3 ../buildlib/cbuild make-dist-tar ../build-pandoc
             displayName: Prebuild Documentation
 
           - task: PublishPipelineArtifact@0
diff --git a/buildlib/cbuild b/buildlib/cbuild
index 1de550e7bf8934..d6727f46669197 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # Copyright 2015-2016 Obsidian Research Corp.
 # Licensed under BSD (MIT variant) or GPLv2. See COPYING.
 # PYTHON_ARGCOMPLETE_OK
@@ -36,6 +36,7 @@ finished, only the base container created during 'build-images' is kept. The
 running the build command and instead run an interactive bash shell. This is
 useful for debugging certain kinds of build problems."""
 
+from __future__ import print_function
 import argparse
 import collections
 import filecmp
@@ -572,8 +573,8 @@ def docker_cmd_str(env,*cmd):
     """Invoke docker"""
     cmd = list(cmd);
     if env.sudo:
-        return subprocess.check_output(["sudo","docker"] + cmd);
-    return subprocess.check_output(["docker"] + cmd);
+        return subprocess.check_output(["sudo","docker"] + cmd).decode();
+    return subprocess.check_output(["docker"] + cmd).decode();
 
 @contextmanager
 def private_tmp(args):
@@ -684,7 +685,7 @@ def run_rpm_build(args,spec_file,env):
         # rpmbuild complains if we do not have an entry in passwd and group
         # for the user we are going to use to do the build.
         with open(os.path.join(tmpdir,"go.py"),"w") as F:
-            print >> F,"""
+            print("""
 import os,subprocess;
 with open("/etc/passwd","a") as F:
    F.write({passwd!r} + "\\n");
@@ -703,7 +704,7 @@ os.symlink({tarfn!r},os.path.join(b"SOURCES",tarfn));
            uid=os.getuid(),
            gid=os.getgid(),
            tarfn=tarfn,
-           tspec_file=tspec_file);
+           tspec_file=tspec_file), file=F);
 
             extra_opts = getattr(env,"rpmbuild_options", [])
             bopts = ["-bb",tspec_file] + extra_opts;
@@ -715,8 +716,8 @@ os.symlink({tarfn!r},os.path.join(b"SOURCES",tarfn));
                 if env.build_pyverbs:
                     bopts.extend(["--with", "pyverbs"]);
 
-            print >> F,'os.execlp("rpmbuild","rpmbuild",%s)'%(
-                ",".join(repr(I) for I in bopts));
+            print('os.execlp("rpmbuild","rpmbuild",%s)'%(
+                ",".join(repr(I) for I in bopts)), file=F);
 
         if args.run_shell:
             opts.append("-ti");
@@ -729,10 +730,10 @@ os.symlink({tarfn!r},os.path.join(b"SOURCES",tarfn));
 
         docker_cmd(args,*opts)
 
-        print
+        print()
         for path,jnk,files in os.walk(os.path.join(tmpdir,"RPMS")):
             for I in files:
-                print "Final RPM: ",os.path.join("..",I);
+                print("Final RPM: ",os.path.join("..",I));
                 shutil.move(os.path.join(path,I),
                             os.path.join("..",I));
 
@@ -765,7 +766,7 @@ def run_deb_build(args,env):
         # Create a go.py that will let us run the compilation as the user and
         # then switch to root only for the packaging step.
         with open(os.path.join(tmpdir,"go.py"),"w") as F:
-            print >> F,"""
+            print("""
 import subprocess,os;
 def to_user():
    os.setgid({gid:d});
@@ -774,7 +775,7 @@ subprocess.check_call(["debian/rules","debian/rules","build"],
             preexec_fn=to_user);
 subprocess.check_call(["debian/rules","debian/rules","binary"]);
 """.format(uid=os.getuid(),
-           gid=os.getgid());
+           gid=os.getgid()), file=F);
 
         if args.run_shell:
             opts.append("-ti");
@@ -787,10 +788,10 @@ subprocess.check_call(["debian/rules","debian/rules","binary"]);
 
         docker_cmd(args,*opts);
 
-        print
+        print()
         for I in os.listdir(tmpdir):
             if I.endswith(".deb"):
-                print "Final DEB: ",os.path.join("..",I);
+                print("Final DEB: ",os.path.join("..",I));
                 shutil.move(os.path.join(tmpdir,I),
                             os.path.join("..",I));
 
@@ -810,7 +811,7 @@ def copy_abi_files(src):
             if os.path.isfile(ref_fn) and filecmp.cmp(ref_fn,cur_fn,False):
                 continue;
 
-            print "Changed ABI File: ", ref_fn;
+            print("Changed ABI File: ", ref_fn);
             shutil.copy(cur_fn, ref_fn);
 
 def run_travis_build(args,env):
@@ -832,7 +833,7 @@ def run_travis_build(args,env):
             base = subprocess.check_output(["git",
                                             "--git-dir",os.path.join(opwd,".git"),
                                             "merge-base",
-                                            "HEAD","FETCH_HEAD"]).strip();
+                                            "HEAD","FETCH_HEAD"]).decode().strip();
 
         home = os.path.join(os.path.sep,"home","travis");
         home_build = os.path.join(os.path.sep,home,"build");
@@ -856,10 +857,10 @@ def run_travis_build(args,env):
             cmds = yaml.safe_load(F)["script"];
 
         with open(os.path.join(tmpdir,"go.sh"),"w") as F:
-            print >> F,"#!/bin/bash";
-            print >> F,"set -e";
+            print("#!/bin/bash", file=F);
+            print("set -e", file=F);
             for I in cmds:
-                print >> F,I;
+                print(I, file=F);
 
         if args.run_shell:
             opts.append("-ti");
@@ -872,7 +873,7 @@ def run_travis_build(args,env):
 
         try:
             docker_cmd(args,*opts);
-        except subprocess.CalledProcessError, e:
+        except subprocess.CalledProcessError as e:
             copy_abi_files(os.path.join(tmpdir, "src/ABI"));
             raise;
         copy_abi_files(os.path.join(tmpdir, "src/ABI"));
@@ -929,7 +930,7 @@ def run_azp_build(args,env):
             base = subprocess.check_output(["git",
                                             "--git-dir",os.path.join(opwd,".git"),
                                             "merge-base",
-                                            "HEAD","FETCH_HEAD"]).strip();
+                                            "HEAD","FETCH_HEAD"]).decode().strip();
 
         opts = [
             "run",
@@ -959,7 +960,7 @@ def run_azp_build(args,env):
 
         try:
             docker_cmd(args,*opts);
-        except subprocess.CalledProcessError, e:
+        except subprocess.CalledProcessError as e:
             copy_abi_files(os.path.join(tmpdir, "s/ABI"));
             raise;
         copy_abi_files(os.path.join(tmpdir, "s/ABI"));
@@ -988,7 +989,7 @@ def cmd_pkg(args):
                           getattr(env,"specfile","%s.spec"%(project)),
                           env);
         else:
-            print "%s does not support packaging"%(env.name);
+            print("%s does not support packaging"%(env.name));
 
 # -------------------------------------------------------------------------
 
@@ -1102,7 +1103,7 @@ def cmd_build_images(args):
             fn = os.path.join(tmpdir,"Dockerfile");
             with open(fn,"wt") as F:
                 for ln in df.lines:
-                    print >> F,ln;
+                    print(ln, file=F);
             opts = (["build"] +
                     get_build_args(args,env) +
                     ["-f",fn,
@@ -1176,13 +1177,15 @@ def cmd_make_dist_tar(args):
 
 if __name__ == '__main__':
     parser = argparse.ArgumentParser(description='Operate docker for building this package')
-    subparsers = parser.add_subparsers(title="Sub Commands");
+    subparsers = parser.add_subparsers(title="Sub Commands",dest="command");
+    subparsers.required = True;
 
     funcs = globals();
-    for k,v in funcs.items():
+    for k,v in list(funcs.items()):
         if k.startswith("cmd_") and inspect.isfunction(v):
             sparser = subparsers.add_parser(k[4:].replace('_','-'),
                                             help=v.__doc__);
+            sparser.required = True;
             funcs["args_" + k[4:]](sparser);
             sparser.set_defaults(func=v);
 
-- 
2.22.0

