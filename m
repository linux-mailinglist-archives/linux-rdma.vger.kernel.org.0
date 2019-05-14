Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 093871E59A
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfENXae (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:30:34 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:45781 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfENXae (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:30:34 -0400
Received: by mail-qt1-f170.google.com with SMTP id t1so1138219qtc.12
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V1NFFMDv1BOGwNBnOdjFcSR9phYUpYYBZ8TqyIk8rkY=;
        b=D7M/tDoI1+k9N2X1SwLqZoEGeDFHy4PvWA1H+qx60IEQWb85CRRjO0PXv7smBixFgj
         gC43840F+fcV1VdatWKOx5W48kol19hogyKCH3KJkXwIdPWn0hGusKfsSL3BW4EB6h2I
         54wQEEWNzvWPL28GKAniKMfrTCW7u1qyMhotCpGN9nXZtxb+VGdIz6eairc/wLNOTelX
         ZmemcwkPjzBYpelUzAHJuYbkO60/F0Hmc1GsmB2mVx7BqAXZ8HiDdaNUnue1iHdteLyR
         t/s5Ckk5RW0EcNNy8ScNcddivL1hEDI4oVwlaO3nHKXh6b6gsmtmqj94SPK/lUSpC04n
         oKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V1NFFMDv1BOGwNBnOdjFcSR9phYUpYYBZ8TqyIk8rkY=;
        b=uK+8pka0jKSLU4hP0GlZnId+s06AqYFf33PiPpAsRStHK0qILGLzgiceAR2ab7bEn6
         fU1MamvACtwBgsnpxpG04Mi+YDx0xkNR1Y5FUvs/rPZgJc0xyYaA0MRhSovs1CR9ZZbK
         H9CAFBG00IXAxHzoTHXslhfBIE0EUB1d2f12rGpr/nI+pu/AWiatZsswBnpfgdLbkTA3
         +GoV1dMvoFqfl1ajgLooVDqwvp6oSNHABrofcbHNNb95WqrZsRNFOz6RlyWECZ3GSMnM
         4ObIvhWbAWDxCr4p1kSBVCA90BTwR0TlZq5SKOXFL6qwT78Hrg6q1hTIVTvO4I8jbjWg
         Zbfg==
X-Gm-Message-State: APjAAAUM1uMGCu+52OzMB8UNmzph5kAqjNab2SAE7ct8xVUdGeVIIkNN
        ErfPZCeff2dbDpvs4ETbvJF611M+8MY=
X-Google-Smtp-Source: APXvYqwWwg/353/BymsoCImV8ORYUDmJ6kbz5l+2jAEVNf9cXkOs3kwZda5m3DHXUFIIZNRQ5HqlNw==
X-Received: by 2002:ac8:43c2:: with SMTP id w2mr32930276qtn.274.1557876633201;
        Tue, 14 May 2019 16:30:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id g15sm118561qkl.2.2019.05.14.16.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:30:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQgsQ-00014E-HE; Tue, 14 May 2019 20:30:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 2/5] cbuild: Remove ubuntu trusty
Date:   Tue, 14 May 2019 20:30:25 -0300
Message-Id: <20190514233028.3905-3-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514233028.3905-1-jgg@ziepe.ca>
References: <20190514233028.3905-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

We only support 2 LTSs at any given time, xenial and bionic are the ones
for Ubuntu. cythond oesn't work on xenial so remove it frmo the package
list as well.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/cbuild | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/buildlib/cbuild b/buildlib/cbuild
index 30a06f06345743..3035db9f375c1d 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -173,9 +173,9 @@ class APTEnvironment(Environment):
             " ".join(sorted(self.pkgs))));
         return res;
 
-class trusty(APTEnvironment):
-    docker_parent = "ubuntu:14.04";
-    common_pkgs = {
+class xenial(APTEnvironment):
+    docker_parent = "ubuntu:16.04"
+    pkgs = {
         'build-essential',
         'cmake',
         'debhelper',
@@ -183,32 +183,24 @@ class trusty(APTEnvironment):
         'gcc',
         'libnl-3-dev',
         'libnl-route-3-dev',
+        'libsystemd-dev',
         'libudev-dev',
         'make',
         'ninja-build',
         'pandoc',
         'pkg-config',
+        'python3',
         'valgrind',
-        };
-    pkgs = common_pkgs | {
-        'libsystemd-daemon-dev',
-        'libsystemd-id128-dev',
-        'libsystemd-journal-dev',
-        };
-    name = "ubuntu-14.04";
-    aliases = {"trusty"};
-    python_cmd = "python";
-    build_pyverbs = False;
-
-class xenial(APTEnvironment):
-    docker_parent = "ubuntu:16.04"
-    pkgs = trusty.common_pkgs | {"libsystemd-dev", "python3-dev", "cython3"};
+    };
     name = "ubuntu-16.04";
     aliases = {"xenial"};
 
 class bionic(APTEnvironment):
     docker_parent = "ubuntu:18.04"
-    pkgs = xenial.pkgs
+    pkgs = xenial.pkgs | {
+        'cython3',
+        'python3-dev',
+    };
     name = "ubuntu-18.04";
     aliases = {"bionic", "ubuntu"};
 
@@ -221,7 +213,7 @@ class jessie(APTEnvironment):
 
 class stretch(APTEnvironment):
     docker_parent = "debian:9"
-    pkgs = jessie.pkgs;
+    pkgs = bionic.pkgs;
     name = "debian-9";
     aliases = {"stretch"};
 
@@ -380,7 +372,6 @@ environments = [centos6(),
                 centos7(),
                 centos7_epel(),
                 travis(),
-                trusty(),
                 xenial(),
                 bionic(),
                 jessie(),
-- 
2.21.0

