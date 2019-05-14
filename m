Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 872461E59B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfENXaf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:30:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38097 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfENXae (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:30:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id d13so1188345qth.5
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QBNq4uL31hyWRrhU17bJdyuEo/KV6BjGKXsLdozu+J8=;
        b=IO2AJ6Cly93f/EryIZ2s5hWv4r7orZuQgR9ek6Lqqr4VkYDbCijuYd+c36i1/Qxna1
         gF2dtP4u14NDEEg6p8sjx0jEuIKySK00vUHsguziHjEfgrxk1D9hmWkfWT+iY4sTOiKc
         TRHyfWlkEwwXb9tKgrr41T8A9vHrsxyWtNwcBOH6ENuo3L5ZtAddj70I8AZE/nxC7q5F
         eliuZNtLpG5BSLK5j7FaRa5+yax1Uq5HjvSsw8nvo+5uiKo0w3SVX0JXSe/KDVGvCW+l
         G2kKSBhF57DYbLCvlJuEqPnP6qBqR/fJOpDXTMLOw4gG8/ONUPJwQfMWRZdmTDynKV+B
         p94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QBNq4uL31hyWRrhU17bJdyuEo/KV6BjGKXsLdozu+J8=;
        b=gTzb5xUPbX4umW79DXUox5dqObBFug2UQ/43DDEr4NohiHFXSLucdZvcNDlbfdiY3m
         XRhJuN/2FrebkEPqGcC4nB+Rhp0NWpyWjpXzz2fMcn4Ef/BpRqnMhtYAzQX3giyBQjIy
         dP6+MQElIGs/P51Ah9X58Ss6hTJZqkZIAzMD99AB2ii6rLg/BF1xIiLwCz7bSD5zUQBZ
         oYgaywH3FWh7JFqYShAZNFp1fTBQ/wvss9gSlwxu5YchWZu7supOVE67+F6uZXCKpSre
         dt7cJFg4GffKVVDEE6/b/vQ7J8BllxMBwPkj6CqGk5pbQxA3IcR9UqOzmRh7q2s30Sk4
         /U0Q==
X-Gm-Message-State: APjAAAX6UyXV/yFxOb9jhYg9fKssJlxIzQPsbbGslP2cXXbHu2ire6mz
        XkPN4/BGjO4ZFBHoOzMiEaBWpcAZ2Ic=
X-Google-Smtp-Source: APXvYqy/JSBmfABlEX3Ceev2I0GZTdLOZ3FNGOgtZdAoVrRmRDwI2/TXNa3/+woFl17cI17C+44F6Q==
X-Received: by 2002:a0c:8d83:: with SMTP id t3mr30817555qvb.160.1557876633606;
        Tue, 14 May 2019 16:30:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id e20sm108422qkm.42.2019.05.14.16.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:30:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQgsQ-000148-GH; Tue, 14 May 2019 20:30:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 1/5] cbuild: Make pyverbs build with epel
Date:   Tue, 14 May 2019 20:30:24 -0300
Message-Id: <20190514233028.3905-2-jgg@ziepe.ca>
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

For some reason cmake3 installs python3.6, but EPEL only has cython
built for python3.4. Convice the python3 link to be python3.4 so cmake
finds it without hassles.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/cbuild | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/buildlib/cbuild b/buildlib/cbuild
index 0010f16acfc0e7..30a06f06345743 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -125,8 +125,16 @@ class centos7(YumEnvironment):
     python_cmd = "python";
 
 class centos7_epel(centos7):
-    pkgs = (centos7.pkgs - {"cmake","make"}) | {"ninja-build","cmake3","pandoc", 'python3-Cython', 'python3-devel'};
+    pkgs = (centos7.pkgs - {"cmake","make"}) | {
+        "cmake3",
+        "ninja-build",
+        "pandoc",
+        "python34-setuptools",
+        'python34-Cython',
+        'python34-devel',
+    };
     name = "centos7_epel";
+    build_pyverbs = True;
     use_make = False;
     pandoc = True;
     ninja_cmd = "ninja-build";
@@ -136,7 +144,7 @@ class centos7_epel(centos7):
     def get_docker_file(self):
         res = YumEnvironment.get_docker_file(self);
         res.lines.insert(1,"RUN yum install -y epel-release");
-        res.lines.append("RUN ln -s /usr/bin/cmake3 /usr/local/bin/cmake");
+        res.lines.append("RUN ln -s /usr/bin/cmake3 /usr/local/bin/cmake && ln -sf /usr/bin/python3.4 /usr/bin/python3");
         return res;
 
 class fc30(Environment):
-- 
2.21.0

