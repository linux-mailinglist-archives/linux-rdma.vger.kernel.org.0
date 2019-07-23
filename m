Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30E471FC7
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391639AbfGWTBp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:01:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46452 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391637AbfGWTBp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:01:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id r4so31840460qkm.13
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3xizULMY+3etu/2FnZTSV4yQ4WFrL4KEPZtIVZVyx4k=;
        b=Q6Tx1JrfcxSmfqEo6OVJAE+cEql7sG7s8J1caVCvSpyArRgPmKPys1WoXLI7vjsANX
         WxX/XndIN7jQ8Ql9DoDuSXY9wDymmi7JituT/4lKxA5D1EsMCtaqIgmQmzWUhlqFXu71
         EXgcWXPkeKT24ukwMM8BXlQw3hoxgQXrPoisV6MIB4SQJHCnKvFSP4eaGvjFNMb4KIrF
         qNN4O8bgCFmF+gruZPCBAtG6pswir0SBL2xnmPDVlsK0RMXN9Ooyf3Iyi+Pp+RxIqE1Z
         dtNELqcTRPW4fJoN2c/PKGJz40zqUYqn9zx55uJfZaZcXxNFRQVbO3MIP1PlhyXDWP74
         ycMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3xizULMY+3etu/2FnZTSV4yQ4WFrL4KEPZtIVZVyx4k=;
        b=gKZ9vUjfip0JOxEwyQxtMVRhsbhUwTZ9GIoRZ125E20b2KZxMRIAsnoOQWwXBH0QHv
         +0o9coWDnhBLoPMI3fXv2R9gDFrdzXciPmBHc3UixhJA4pKRLpiHxU9bVzMSsL+mMwBa
         34yGsLSgFK01w8KqCdggt7PBhpnjkxioJtr2o8Zq9q0KsuicGtRUuTptTCqyW3QgiXjP
         9ZlS6UegvI7QCE/faE6T5lKmJmgR9/DNg4xxT0mP8OeFXllWMq9Xe689NpazqW3yBAws
         hgJ1trSyxvZ/9QmXVly1Y2rdKHX/lqNtixOghz3xLIKkPyzv9dLjNVNVhvmPvQkbhbO/
         1pIw==
X-Gm-Message-State: APjAAAWr5oeeIEn2xaP+5MZxwYvyETuHseBZDtNa5d2ZIzLHu5BVe5bV
        RVuEgHLNsAqJ0uIHUnGMazlDT947H995ww==
X-Google-Smtp-Source: APXvYqxXPJr7RtjAifUTNTCqGC2PmiCBk3vb2mOANh3infYXJtM63Ma9Tqckxz6+F/q9wkIwatGZWw==
X-Received: by 2002:a37:6146:: with SMTP id v67mr35456091qkb.493.1563908504351;
        Tue, 23 Jul 2019 12:01:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h40sm25618528qth.4.2019.07.23.12.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:01:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-00045D-SF; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 15/19] build/azp: Reduce the package list
Date:   Tue, 23 Jul 2019 16:01:33 -0300
Message-Id: <20190723190137.15370-16-jgg@ziepe.ca>
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

Remove some unneeded packages and files from the container. The unpacked
image size is reduced by about 120MB.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/cbuild | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/buildlib/cbuild b/buildlib/cbuild
index d6727f46669197..cc9c7e2999a9d2 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -200,7 +200,7 @@ class APTEnvironment(Environment):
     build_python = True;
     def get_docker_file(self,tmpdir):
         res = DockerFile(self.docker_parent);
-        res.lines.append("RUN apt-get update && apt-get install -y --no-install-recommends %s && apt-get clean && rm -rf /usr/share/doc/ /usr/lib/debug"%(
+        res.lines.append("RUN apt-get update && apt-get install -y --no-install-recommends %s && apt-get clean && rm -rf /usr/share/doc/ /usr/lib/debug /var/lib/apt/lists/"%(
             " ".join(sorted(self.pkgs))));
         return res;
 
@@ -429,19 +429,38 @@ class tumbleweed(ZypperEnvironment):
 
 # -------------------------------------------------------------------------
 
-class azure_pipelines(bionic):
-    pkgs = bionic.pkgs | {
+class azure_pipelines(APTEnvironment):
+    docker_parent = "ubuntu:18.04"
+    pkgs = {
         "abi-compliance-checker",
         "abi-dumper",
         "ca-certificates",
         "clang-8",
+        "cmake",
+        "cython3",
+        "debhelper",
+        "dh-systemd",
+        "dpkg-dev",
         "fakeroot",
         "gcc-9",
         "git",
         "python2.7",
+        "libc6-dev",
+        "libnl-3-dev",
+        "libnl-route-3-dev",
+        "libsystemd-dev",
+        "libudev-dev",
+        "make",
+        "ninja-build",
+        "pandoc",
+        "pkg-config",
+        "python3-docutils",
+        "python3",
+        "python3-dev",
+        "python3-docutils",
         "python3-yaml",
         "sparse",
-        'python-docutils',
+        "valgrind",
     } | {
         # 32 bit build support
         "libgcc-9-dev:i386",
-- 
2.22.0

