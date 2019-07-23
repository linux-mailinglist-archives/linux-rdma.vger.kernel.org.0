Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D1F71FCC
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391652AbfGWTBs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:01:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42491 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391640AbfGWTBs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:01:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id 201so31890180qkm.9
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cE2YmJOoUvJi6N4PcPWSBx7RPu50opRPgii3QI4KFAw=;
        b=Ypck7+D0U1yItOkAPT0ChuzBPHCHQIsynQqVtwAaFPoNTwVd25zqygJ+L4CjBxTFtB
         pR1PNjIhG3RhOL6WMucGglRWvbpctGZIQA71781evLJfbH7gShdlq9wnde9w1G0k71bQ
         omEckzrJolglh54SS5h1HECqen6jBkMjoeQaIDjogjTiU/4s+bNgUwhtSYRjylfQx8Sj
         ptg/s8KtjJSmRhhCEBd+52rlBJzCYiVCsNIXDpOwel2oVLulym6sfkoDi/8Bpsw9QWpi
         a/+8edLWDub/PQ8QWOU71OY39xEG89lUu/RLi6ufRKekcRBsVT2ZM9AuIYqi5GgcsQdG
         RIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cE2YmJOoUvJi6N4PcPWSBx7RPu50opRPgii3QI4KFAw=;
        b=OLkO8k8EMQu1qnIGKDW7c2EvtJ+c7RkiGjm1f62H+uuW5LxLzT2D/sbctkLJyyIi0P
         7THbGSXuDwLbZWxU+5syAOybVkopFZM5NpdqpV4ixSFDLKjZTIH8aXp0FzkwulwJHrfQ
         fhpY6ZdsuNQgfnk6mTVhvTDadTfsGpzKrA8VoO/nHJGJkIO9D9MsH4QmxHFeFK7UA2k3
         NigTkHxdZJZQ61YwdBIo/gy1pCjNrm/7COR5whdYvZMo7x/MmQFMxzg1hfJT6X6g8r8J
         w+OzjQ5RK1EkTHpmyAJRr7pCLDG1gfqUwuy/JIqvbjeixdcNvbY5hd2wjf4BDH6yYQBd
         7PNg==
X-Gm-Message-State: APjAAAX4oCWhMYBpoqT0Gb3HBK0PTvbiMGHYJVsTctpZqp3iu9LBDoq6
        XxuKzMcbSW9MHgU54X4kOis42eEiXEoRQQ==
X-Google-Smtp-Source: APXvYqxLqTbthcMrrkkFC7+zoxkntGtNqarkvs+JMTVvr3pBka5EiPgQyBLNR10HgL7a8u6VaWocpg==
X-Received: by 2002:a37:8604:: with SMTP id i4mr50512960qkd.255.1563908506600;
        Tue, 23 Jul 2019 12:01:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o5sm19396466qkf.10.2019.07.23.12.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:01:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-00044R-I5; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 07/19] build/azp: Use a version number for the docker images
Date:   Tue, 23 Jul 2019 16:01:25 -0300
Message-Id: <20190723190137.15370-8-jgg@ziepe.ca>
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

This way when we make a stable branch the CI container images will remain
unchanged for that branch instead of tracking the master branch.

If incompatible changes are made during a release then a suffix should be
appended.

The version number for the image is taken from the
buildlib/azure-pipelines.yml.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/azure-pipelines.yml |  6 +++---
 buildlib/cbuild              | 22 ++++++++++++++++++----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/buildlib/azure-pipelines.yml b/buildlib/azure-pipelines.yml
index 998b598bfc482f..e1ed19c6e7ad93 100644
--- a/buildlib/azure-pipelines.yml
+++ b/buildlib/azure-pipelines.yml
@@ -8,13 +8,13 @@ pr:
 resources:
   containers:
     - container: azp
-      image: ucfconsort.azurecr.io/rdma-core/azure_pipelines:latest
+      image: ucfconsort.azurecr.io/rdma-core/azure_pipelines:25.0
       endpoint: ucfconsort_registry
     - container: centos7
-      image: ucfconsort.azurecr.io/rdma-core/centos7:latest
+      image: ucfconsort.azurecr.io/rdma-core/centos7:25.0
       endpoint: ucfconsort_registry
     - container: leap
-      image: ucfconsort.azurecr.io/rdma-core/opensuse-15.0:latest
+      image: ucfconsort.azurecr.io/rdma-core/opensuse-15.0:25.0
       endpoint: ucfconsort_registry
 
 stages:
diff --git a/buildlib/cbuild b/buildlib/cbuild
index 7f93baa82b1959..1c325c9fe7cbdf 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -52,6 +52,7 @@ import shutil
 import subprocess
 import sys
 import tempfile
+import yaml
 from contextlib import contextmanager;
 
 project = "rdma-core";
@@ -72,6 +73,7 @@ class DockerFile(object):
         self.lines = ["FROM %s"%(src)];
 
 class Environment(object):
+    azp_images = None;
     pandoc = True;
     python_cmd = "python3";
     aliases = set();
@@ -81,9 +83,23 @@ class Environment(object):
 
     to_azp = False;
 
+    def _get_azp_names(self):
+        if Environment.azp_images:
+            return Environment.azp_images;
+
+        with open("buildlib/azure-pipelines.yml") as F:
+            azp = yaml.safe_load(F)
+        Environment.azp_images = set(I["image"] for I in azp["resources"]["containers"])
+        return Environment.azp_images;
+
     def image_name(self):
         if self.to_azp:
-            return "ucfconsort.azurecr.io/%s/%s"%(project, self.name);
+            # Get the version number of the container out of the azp file.
+            prefix = "ucfconsort.azurecr.io/%s/%s:"%(project, self.name);
+            for I in self._get_azp_names():
+                if I.startswith(prefix):
+                    return I;
+            raise ValueError("Image is not used in buildlib/azure-pipelines.yml")
         return "build-%s/%s"%(project,self.name);
 
 # -------------------------------------------------------------------------
@@ -252,7 +268,6 @@ class travis(APTEnvironment):
     _yaml = None;
 
     def get_yaml(self):
-        import yaml
         if self._yaml:
             return self._yaml;
 
@@ -394,6 +409,7 @@ class azure_pipelines(bionic):
         "gcc-8",
         "git",
         "python2.7",
+        "python3-yaml",
         "sparse",
         'python-docutils',
     } | {
@@ -750,7 +766,6 @@ def copy_abi_files(src):
             shutil.copy(cur_fn, ref_fn);
 
 def run_travis_build(args,env):
-    import yaml
     with private_tmp(args) as tmpdir:
         os.mkdir(os.path.join(tmpdir,"src"));
         os.mkdir(os.path.join(tmpdir,"tmp"));
@@ -815,7 +830,6 @@ def run_travis_build(args,env):
         copy_abi_files(os.path.join(tmpdir, "src/ABI"));
 
 def run_azp_build(args,env):
-    import yaml
     # Load the commands from the pipelines file
     with open("buildlib/azure-pipelines.yml") as F:
         azp = yaml.safe_load(F);
-- 
2.22.0

