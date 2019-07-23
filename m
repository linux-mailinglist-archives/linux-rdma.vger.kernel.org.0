Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D85B71FCA
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391642AbfGWTBr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:01:47 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42491 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391637AbfGWTBr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:01:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so31890138qkm.9
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kEIIl/wHnLOY0XOMg6Gta0jA6ZWKKqlFmHhwlrFbhHY=;
        b=ERG0x6BlYQ3wrthNm01JBjnWPbln2kwpFZtHiThKcLeAIy8WOBq5GZAFr2mH91iAxZ
         2AZ1v4FylxRg0CidjGq5O++kCMLRcjfdvTLV5jgwWqbWZ5f4enX0PI7qsv+PcgjLSkH4
         WCeKbXFsbfJjSQOcmYap7IEeyFppa1TLCKV/xpvFakN4wlWKxE46AKD/sUtgfYAX8x7v
         V3VF2WZw/PcMOSEVdFt0ytTqe0Z/k12FcmPdF0tuCvFvE7xH9QWJw/OkoyEjVoRjQw+q
         RZtCdZgjrawo/K90YYg5vrF06bkPPUpEvGrXcTo5ydjf977opnRLjGmOh4JrUm7dRc0Y
         3O6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEIIl/wHnLOY0XOMg6Gta0jA6ZWKKqlFmHhwlrFbhHY=;
        b=EnEnqHFpR+1fX2aiKFx1/ip/eEBU5NVKb/DOTNgTNFU0M5juXfTu6k6kAHnfRwYsyA
         PStp+bCHqMzc458UAh5/iviPiJ+N2ERoG8P7WOxnccyIpcChgFX6zo6nbwcMqkUbOTjD
         I2dCRveKemyVewQ/V+N5QcUseco/tEWgsd4UGxRjUelBXE2SzNg97C7o8jojQVHGG8e8
         n9rQ78VYb+FKR1RaXm1WCHz+Qrz7F5r4oSFDi3aMjFk/SYGMyE7jbvSYSIA2U8TJlyXN
         VN0Se07mgchZJmlE3x+bqwrcbShl+j34aWkwHrrLsK04ACWVt7V3GSP/svvYIwBDvw29
         1KUg==
X-Gm-Message-State: APjAAAWBLaahM0Om+Js+6olACDaQSJpwgdYcpN1xIt8YWoWrA0wD19+n
        v//6DHqS/Ad3yt93iJ07ONcvhGCyllipfg==
X-Google-Smtp-Source: APXvYqzb56Gv8RtFmQewShAEaN/JW6QDMQCtkVs8KQACD9GF7LGZkln4rJWXVu5LGo5iPgeuiiE/sQ==
X-Received: by 2002:a37:9c94:: with SMTP id f142mr46198995qke.427.1563908505322;
        Tue, 23 Jul 2019 12:01:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n27sm13855159qkk.35.2019.07.23.12.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:01:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-00044d-LK; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 09/19] build/azp: Use gcc 9.3 for building
Date:   Tue, 23 Jul 2019 16:01:27 -0300
Message-Id: <20190723190137.15370-10-jgg@ziepe.ca>
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

Latest release

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/azure-pipelines.yml | 18 +++++-----
 buildlib/cbuild              | 69 ++++++++++++++++++++++++++----------
 2 files changed, 60 insertions(+), 27 deletions(-)

diff --git a/buildlib/azure-pipelines.yml b/buildlib/azure-pipelines.yml
index e1ed19c6e7ad93..f488bfe607c482 100644
--- a/buildlib/azure-pipelines.yml
+++ b/buildlib/azure-pipelines.yml
@@ -35,16 +35,16 @@ stages:
 
           - bash: |
               set -e
-              mkdir build-gcc8
-              cd build-gcc8
-              CC=gcc-8 CFLAGS="-Werror" cmake -GNinja .. -DIOCTL_MODE=both -DENABLE_STATIC=1
+              mkdir build-gcc9
+              cd build-gcc9
+              CC=gcc-9 CFLAGS="-Werror" cmake -GNinja .. -DIOCTL_MODE=both -DENABLE_STATIC=1
               ninja
-            displayName: gcc 8.3 Compile
+            displayName: gcc 9.1 Compile
 
           - bash: |
               set -e
-              cd build-gcc8
-              python2.7 ../buildlib/check-build --src .. --cc gcc-8
+              cd build-gcc9
+              python2.7 ../buildlib/check-build --src .. --cc gcc-9
             displayName: Check Build Script
 
           # Run sparse on the subdirectories which are sparse clean
@@ -75,9 +75,9 @@ stages:
               set -e
               mv util/udma_barrier.h util/udma_barrier.h.old
               echo "#error Fail" >> util/udma_barrier.h
-              cd build-gcc8
+              cd build-gcc9
               rm CMakeCache.txt
-              CC=gcc-8 CFLAGS="-Werror" cmake -GNinja .. -DIOCTL_MODE=both
+              CC=gcc-9 CFLAGS="-Werror" cmake -GNinja .. -DIOCTL_MODE=both
               ninja
               mv ../util/udma_barrier.h.old ../util/udma_barrier.h
             displayName: Simulate non-coherent DMA Platform Compile
@@ -117,7 +117,7 @@ stages:
               set -e
               mkdir build-pandoc artifacts
               cd build-pandoc
-              CC=gcc-8 cmake -GNinja ..
+              CC=gcc-9 cmake -GNinja ..
               ninja docs
               cd ../artifacts
               # FIXME: Check Build.SourceBranch for tag consistency
diff --git a/buildlib/cbuild b/buildlib/cbuild
index 9fd51cc750dcbb..34051e55c24e81 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -106,7 +106,7 @@ class Environment(object):
 
 class YumEnvironment(Environment):
     is_rpm = True;
-    def get_docker_file(self):
+    def get_docker_file(self,tmpdir):
         res = DockerFile(self.docker_parent);
         res.lines.append("RUN yum install -y %s && yum clean all"%(
             " ".join(sorted(self.pkgs))));
@@ -163,8 +163,8 @@ class centos7_epel(centos7):
     is_rpm = False;
     to_azp = False;
 
-    def get_docker_file(self):
-        res = YumEnvironment.get_docker_file(self);
+    def get_docker_file(self,tmpdir):
+        res = YumEnvironment.get_docker_file(self,tmpdir);
         res.lines.insert(1,"RUN yum install -y epel-release");
         res.lines.append("RUN ln -s /usr/bin/cmake3 /usr/local/bin/cmake && ln -sf /usr/bin/python3.4 /usr/bin/python3");
         return res;
@@ -185,7 +185,7 @@ class fc30(Environment):
     is_rpm = True;
     aliases = {"fedora"};
 
-    def get_docker_file(self):
+    def get_docker_file(self,tmpdir):
         res = DockerFile(self.docker_parent);
         res.lines.append("RUN dnf install -y %s && dnf clean all"%(
             " ".join(sorted(self.pkgs))));
@@ -196,12 +196,39 @@ class fc30(Environment):
 class APTEnvironment(Environment):
     is_deb = True;
     build_python = True;
-    def get_docker_file(self):
+    def get_docker_file(self,tmpdir):
         res = DockerFile(self.docker_parent);
         res.lines.append("RUN apt-get update && apt-get install -y --no-install-recommends %s && apt-get clean && rm -rf /usr/share/doc/ /usr/lib/debug"%(
             " ".join(sorted(self.pkgs))));
         return res;
 
+    def add_source_list(self,tmpdir,name,content):
+        sld = os.path.join(tmpdir,"etc","apt","sources.list.d");
+        if not os.path.isdir(sld):
+            os.makedirs(sld);
+        with open(os.path.join(sld,name),"w") as F:
+            F.write(content + "\n");
+
+    def add_ppa(self,tmpdir,srcline,keyid):
+        gpgd = os.path.join(tmpdir,"etc","apt","trusted.gpg.d");
+        if not os.path.isdir(gpgd):
+            os.makedirs(gpgd);
+
+        # The container does not have gpg or other stuff to get the signing
+        # key for the toolchain ppa.  Fetch it in the host and just import the
+        # gpg data directly into the trusted keyring.
+        kb = os.path.join(tmpdir,"%s.kb.gpg"%(keyid));
+        subprocess.check_call(["gpg","--no-default-keyring","--keyring",kb,"--always-trust",
+                               "--recv-key",keyid]);
+        kr = os.path.join(gpgd,"%s.gpg"%(keyid));
+        with open(kr,"wb") as F:
+            F.write(subprocess.check_output(["gpg","--no-default-keyring",
+                                             "--keyring",kb,
+                                             "--export",keyid]));
+        os.unlink(kb);
+
+        self.add_source_list(tmpdir,keyid + ".list",srcline);
+
 class xenial(APTEnvironment):
     docker_parent = "ubuntu:16.04"
     pkgs = {
@@ -252,7 +279,7 @@ class debian_experimental(APTEnvironment):
     pkgs = (stretch.pkgs ^ {"gcc"}) | {"gcc-9"};
     name = "debian-experimental";
 
-    def get_docker_file(self):
+    def get_docker_file(self,tmpdir):
         res = DockerFile(self.docker_parent);
         res.lines.append("RUN apt-get update && apt-get -t experimental install -y --no-install-recommends %s && apt-get clean"%(
             " ".join(sorted(self.pkgs))));
@@ -330,10 +357,10 @@ class travis(APTEnvironment):
     def get_cython(self):
         return ["""RUN pip3 install cython"""]
 
-    def get_docker_file(self):
+    def get_docker_file(self,tmpdir):
         # First this to get apt-add-repository
         self.pkgs = {"software-properties-common"}
-        res = APTEnvironment.get_docker_file(self);
+        res = APTEnvironment.get_docker_file(self,tmpdir);
 
         # Sources list from the travis.yml
         res.lines.extend(self.get_repos());
@@ -357,7 +384,7 @@ class travis(APTEnvironment):
 class ZypperEnvironment(Environment):
     proxy = False;
     is_rpm = True;
-    def get_docker_file(self):
+    def get_docker_file(self,tmpdir):
         res = DockerFile(self.docker_parent);
         res.lines.append("RUN zypper --non-interactive refresh");
         res.lines.append("RUN zypper --non-interactive dist-upgrade");
@@ -407,7 +434,7 @@ class azure_pipelines(bionic):
         "ca-certificates",
         "clang-7",
         "fakeroot",
-        "gcc-8",
+        "gcc-9",
         "git",
         "python2.7",
         "python3-yaml",
@@ -415,7 +442,7 @@ class azure_pipelines(bionic):
         'python-docutils',
     } | {
         # 32 bit build support
-        "libgcc-8-dev:i386",
+        "libgcc-9-dev:i386",
         "libc6-dev:i386",
         "libnl-3-dev:i386",
         "libnl-route-3-dev:i386",
@@ -435,14 +462,20 @@ class azure_pipelines(bionic):
     name = "azure_pipelines";
     aliases = {"azp"}
 
-    def get_docker_file(self):
-        res = bionic.get_docker_file(self);
+    def get_docker_file(self,tmpdir):
+        res = bionic.get_docker_file(self,tmpdir);
+        self.add_ppa(tmpdir,
+                     "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic main",
+                     "60C317803A41BA51845E371A1E9377A2BA9EF27F");
+        self.add_source_list(tmpdir,"arm64.list",
+                             """deb [arch=arm64] http://ports.ubuntu.com/ bionic main universe
+deb [arch=arm64] http://ports.ubuntu.com/ bionic-security main universe
+deb [arch=arm64] http://ports.ubuntu.com/ bionic-updates main universe""");
+
+        res.lines.insert(1,"ADD etc/ /etc/");
         res.lines.insert(1,"RUN dpkg --add-architecture i386 &&"
                          "dpkg --add-architecture arm64 &&"
-                         "sed -i -e 's/^deb /deb [arch=amd64,i386] /g' /etc/apt/sources.list &&"
-                         "echo 'deb [arch=arm64] http://ports.ubuntu.com/ bionic main universe\\n"
-                               "deb [arch=arm64] http://ports.ubuntu.com/ bionic-security main universe\\n"
-                               "deb [arch=arm64] http://ports.ubuntu.com/ bionic-updates main universe' > /etc/apt/sources.list.d/arm64.list");
+                         "sed -i -e 's/^deb /deb [arch=amd64,i386] /g' /etc/apt/sources.list");
         return res;
 
 # -------------------------------------------------------------------------
@@ -1047,8 +1080,8 @@ def cmd_build_images(args):
     """Run from the top level source directory to make the docker images that are
     needed for building. This only needs to be run once."""
     for env in args.ENV:
-        df = env.get_docker_file();
         with private_tmp(args) as tmpdir:
+            df = env.get_docker_file(tmpdir);
             fn = os.path.join(tmpdir,"Dockerfile");
             with open(fn,"wt") as F:
                 for ln in df.lines:
-- 
2.22.0

