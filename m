Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 699B6257F3
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 21:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfEUTBd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 15:01:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40546 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbfEUTBd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 15:01:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id k24so21824543qtq.7
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZnLAvF2TQmvzir8YcJdEbcp+YHhChloz4RuzwqEwBLk=;
        b=mCuLB0ItSaWYGP2Ev6cxareXxbiE4ht4Bmha7aZ0bheoQeWiLRjSTJJJGVh2Es9KcS
         /06bd8zr/ICo+iVD3VMnDP66qTyZH+LnOn+o8NOJe47nZh+N+g9TuIK2aMn9XSuU6fMM
         9jLsZY19mwyO3IJzlXEeZzLONRLPbBZwIbSEAFlGWRTV6eSCKzJ2ssoRacxEwwchTsNd
         8i7J4o3mWfByet4pjrpPN/qEzeTxJDLohyhxekKqxnZGzQQM496ZTyPlwX2tpxB4U4nF
         eTrWyqgaEa+rh0qHeE4nX0yEfUxn+btNx1ZOaggDbBHRCVXbebkUqy01/zR6r6I3cyh8
         FqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZnLAvF2TQmvzir8YcJdEbcp+YHhChloz4RuzwqEwBLk=;
        b=KA0KAGpvf5NPmsl+MPezaBatHcoc6V9T2TpI2oWcCbzKsRbiqerJH9gcrOoNoSml8k
         N0ts5pbaBikml7bjSi2B4UzEcejYlKfaWnlGdzNjOIakgOM5M3mdNYBivfAFwf1T7S5U
         9esx6IY6NpyqN9dVABEou/hjVrsfbtGpew9MKsnWRWrv18h5atHSA1GtUSFf51rN0wnw
         9xs0qVBZOTeoAnZ+fizyLgkN9iUCxjKfIQZaf8VeQMAypj2EoMykQ71eVskf3GX3QZLO
         jMrTI/Ug/FDFJODcZrS6ryjw75bQxAPTVSAArxDRStiALVct2/UN2XAGgAfLFsclYcf2
         sMjw==
X-Gm-Message-State: APjAAAWMdegVt4GRGpCCLOHgbFytm2GOlGa+WRZ6L+Tqgt/aizjQhVQS
        Rw4+iQ5g2OsPM4ns7An/ozcT1oSDP6E=
X-Google-Smtp-Source: APXvYqzNqhzwNcGaGX2PLAVm4y6eM+y0WfyvIgTuf3F/j0X//pb2HBmQqFObfo+vBABSsJpVQw5gsg==
X-Received: by 2002:a0c:ad02:: with SMTP id u2mr30430214qvc.90.1558465291923;
        Tue, 21 May 2019 12:01:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id j64sm3892116qke.92.2019.05.21.12.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 12:01:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTA0u-0007DK-91; Tue, 21 May 2019 16:01:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 7/7] build: Expose the cbuild machinery to build the release .tar.gz
Date:   Tue, 21 May 2019 16:01:24 -0300
Message-Id: <20190521190124.27486-8-jgg@ziepe.ca>
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

cbuild makes this tar file as does the github-release script, just have
it in one place.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/cbuild         | 55 ++++++++++++++++++++++++++++++++---------
 buildlib/github-release |  7 +-----
 2 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/buildlib/cbuild b/buildlib/cbuild
index 2bd869cc28cbe1..7b0b9a9de0ed44 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -510,21 +510,12 @@ def get_tar_file(args,tarfn,pandoc_prebuilt=False):
 
     # When the OS does not support pandoc we got through the extra step to
     # build pandoc output in the travis container and include it in the
-    # tar. This is similar to what buildlib/github-release does.
+    # tar.
     if not args.use_prebuilt_pandoc:
         subprocess.check_call(["buildlib/cbuild","make","travis","docs"]);
 
-    tmp_tarfn = os.path.join(os.path.dirname(tarfn),"tmp.tar");
-    get_tar_file(args,tmp_tarfn,False);
-
-    subprocess.check_call([
-        "tar",
-        "-rf",tmp_tarfn,
-        "build-travis/pandoc-prebuilt/",
-        "--xform","s|build-travis/pandoc-prebuilt|%sbuildlib/pandoc-prebuilt|g"%(prefix)]);
-    with open(tarfn,"w") as F:
-        subprocess.check_call(["gzip","-9c",tmp_tarfn],stdout=F);
-    os.unlink(tmp_tarfn);
+    cmd_make_dist_tar(argparse.Namespace(BUILD="build-travis",tarfn=tarfn,
+                                         script_pwd="",tag=None));
 
 def run_rpm_build(args,spec_file,env):
     with open(spec_file,"r") as F:
@@ -904,6 +895,45 @@ def cmd_build_images(args):
                      tmpdir]);
             docker_cmd(args,*opts);
 
+# -------------------------------------------------------------------------
+def args_make_dist_tar(parser):
+    parser.add_argument("BUILD",help="Path to the build directory")
+    parser.add_argument("--tarfn",help="Output TAR filename")
+    parser.add_argument("--tag",help="git tag to sanity check against")
+def cmd_make_dist_tar(args):
+    """Make the standard distribution tar. The BUILD argument must point to a build
+    output directory that has pandoc-prebuilt"""
+    ver = get_version();
+
+    if not args.tarfn:
+        args.tarfn = "%s-%s.tar.gz"%(project,ver)
+
+    # The tag name and the cmake file must match.
+    if args.tag:
+        assert args.tag == "v" + ver;
+
+    with private_tmp(args) as tmpdir:
+        tmp_tarfn = os.path.join(tmpdir,"tmp.tar");
+
+        prefix = "%s-%s/"%(project,get_version());
+        subprocess.check_call(["git","archive",
+                               "--prefix",prefix,
+                               "--output",tmp_tarfn,
+                               "HEAD"]);
+
+        # Mangle the paths and append the prebuilt stuff to the tar file
+        if args.BUILD:
+            subprocess.check_call([
+                "tar",
+                "-C",os.path.join(args.script_pwd,args.BUILD,"pandoc-prebuilt"),
+                "-rf",tmp_tarfn,
+                "./",
+                "--xform",r"s|^\.|%sbuildlib/pandoc-prebuilt|g"%(prefix)]);
+
+        assert args.tarfn.endswith(".gz") or args.tarfn.endswith(".tgz");
+        with open(os.path.join(args.script_pwd,args.tarfn),"w") as F:
+            subprocess.check_call(["gzip","-9c",tmp_tarfn],stdout=F);
+
 # -------------------------------------------------------------------------
 def args_docker_gc(parser):
     pass;
@@ -944,6 +974,7 @@ if __name__ == '__main__':
     # This script must always run from the top of the git tree, and a git
     # checkout is mandatory.
     git_top = subprocess.check_output(["git","rev-parse","--show-toplevel"]).strip();
+    args.script_pwd = os.getcwd();
     os.chdir(git_top);
 
     args.func(args);
diff --git a/buildlib/github-release b/buildlib/github-release
index f95d40f5ee51ee..8fc536fb8b1074 100755
--- a/buildlib/github-release
+++ b/buildlib/github-release
@@ -3,10 +3,5 @@
 set -e
 
 if [[ $TRAVIS_TAG == v* ]] && [ "$TRAVIS_OS_NAME" = "linux" ]; then
-	# Let's create release for vX tags only.
-	# Strip the v from the TRAVIS_TAG for our prefix and output items
-	REL_TAG=`echo $TRAVIS_TAG | sed -e 's/^v//'`
-	git archive --prefix rdma-core-$REL_TAG/ --output rdma-core-$REL_TAG.tar $TRAVIS_TAG
-	tar -rf rdma-core-$REL_TAG.tar build-travis/pandoc-prebuilt/ --xform "s|build-travis/pandoc-prebuilt|rdma-core-$REL_TAG/buildlib/pandoc-prebuilt|g"
-	gzip -9 rdma-core-$REL_TAG.tar
+    buildlib/cbuild make-dist-tar --tag "$TRAVIS_TAG" build-travis
 fi
-- 
2.21.0

