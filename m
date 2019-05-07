Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AE016B33
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEGTUX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 15:20:23 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:40421 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfEGTUW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 15:20:22 -0400
Received: by mail-qk1-f172.google.com with SMTP id w20so255895qka.7
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dbndi23zngJJt6JxrXNaJQqclMQZ9d0Ljmf//5SCbFw=;
        b=gtcjXXScoyurK4vq8jht+WYIgRzrDL1dHnGrOdKzkZZ6KlisRTXHWQTj/731Huqxba
         4/RmeWA6iszrSZOifFgufADEkbdNqVhT9fQxf/SyUHqE4z9LLac3CD2n7zcyGfbGbBVj
         PtW795lD3qJgEkEhxrsZOhjqIrcHsxSH8VA2Hh6PDUPo8hsYe/1mej1GjPLA1uIoqWkx
         +HEsteBM2swSzTIppAzKR2WdN2WpwpS57ie4iMDacRnIgOVSkg5dXz7g9eQ5MQsWpUoI
         IGwe5OjxnYLS7/VY1nQlac+L1cWTNbN+xi6KTkp754k+fn5bCC7TyB6CNA9jf+R6YyrT
         KmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dbndi23zngJJt6JxrXNaJQqclMQZ9d0Ljmf//5SCbFw=;
        b=s70yVEptOawOt2tH5+6MMbueOzmYNqbLHJjZMpCBfbVBJS+rQ06a/HFwLXte6FaUtp
         ru+f/Rcx4AmGOM+ytBsU0hjG+n+BFjCrN48J5z5CAFqgp5KeFfUIyEShKySN6wDytCbS
         UVE+k6FEZ0Pn5It+aVOE+SPz+lnw+3haDPiG06a7HnKsjtmqNosshhxKS6KcxYVCJ9EU
         cJP6JBfgLnjEMLb+4bPuYcmfZq6v2tG/Kz27ZPG+RexTjzOVhPCrxI+mbDnG/0oqkH8D
         ccbth6atsLEtmCLvxU35XZ2GqaIJdPI9SYCNu6R5L1/NVXLmXUmbFRSZYYeX4OSF+vnU
         N5+g==
X-Gm-Message-State: APjAAAVBPo47pEzz/IxE+78hk+H0fDjwd2mQo85CXGo2ro++66RAmeUv
        fimu1jMtlfkK/u5VOnJJecrmQu0QoQo=
X-Google-Smtp-Source: APXvYqxp1vg2fJnoCbB41u9KMySHnOieZTrsFaIsD3tzZIyoSudwwTRaERmjfkxS6T+sHWqqJmDL7g==
X-Received: by 2002:a37:6445:: with SMTP id y66mr12869960qkb.102.1557256820946;
        Tue, 07 May 2019 12:20:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id q50sm10072047qtq.34.2019.05.07.12.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 12:20:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hO5dS-0001fF-VX; Tue, 07 May 2019 16:20:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 2/2] cbuild: Update to Fedora Core 30
Date:   Tue,  7 May 2019 16:20:17 -0300
Message-Id: <20190507192017.6284-3-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190507192017.6284-1-jgg@ziepe.ca>
References: <20190507192017.6284-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Now that FC30 is released, update cbuild to support it.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/cbuild | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/buildlib/cbuild b/buildlib/cbuild
index 095b17782fd331..0010f16acfc0e7 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -139,10 +139,10 @@ class centos7_epel(centos7):
         res.lines.append("RUN ln -s /usr/bin/cmake3 /usr/local/bin/cmake");
         return res;
 
-class fc29(Environment):
-    docker_parent = "fedora:29";
+class fc30(Environment):
+    docker_parent = "fedora:30";
     pkgs = (centos7.pkgs - {"make", "python-argparse" }) | {"ninja-build","pandoc","perl-generators","python3-Cython","python3-devel"};
-    name = "fc29";
+    name = "fc30";
     specfile = "redhat/rdma-core.spec";
     ninja_cmd = "ninja-build";
     is_rpm = True;
@@ -377,7 +377,7 @@ environments = [centos6(),
                 bionic(),
                 jessie(),
                 stretch(),
-                fc29(),
+                fc30(),
                 leap(),
                 tumbleweed(),
                 debian_experimental(),
-- 
2.21.0

