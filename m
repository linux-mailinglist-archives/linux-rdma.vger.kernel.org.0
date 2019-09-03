Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F56A68D5
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2019 14:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfICMpa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Sep 2019 08:45:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46300 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728983AbfICMpa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Sep 2019 08:45:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id i8so4670401edn.13;
        Tue, 03 Sep 2019 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YuU5Kut51UGWatXnkAlIqGxLpuRa0KTrEmrDc7CWAno=;
        b=VICwTZtkx0EwcMMTSSNqVxyf3gaKYP7SJXhh+ZkgC2V1+F1u3N36Iy///DzVa7chvU
         pbQ6hBFRGHTwYG5DXg2c3AdLw2k7Vf4lGDoxjtOf74DDVNIjpZ8n+cUPuJdzHaKIZ4LI
         MipwS2A5pFZChQAoR+/feK0BSk25KFVVE71VNvTW8m+xdoti28o95xXcH1iGmpr65ShQ
         osQoHMcNkq4JvNRfDLkh84N5Jx6AEGaaqEe+Uqq4bZu5kbXoFoxgHY75OWhdikDK42gw
         5A8skVtrqm4H/yGrbPtXXIn9xIK+Nz5EmVU3ZGtGmE16yjMyUMeEgm/wWJ2CqGOTatA9
         bTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YuU5Kut51UGWatXnkAlIqGxLpuRa0KTrEmrDc7CWAno=;
        b=sjXvi9M5Atm/tyYpeOt5b8L/FH/natyxK5Y1A5Ohp4vOQ778cHFzkTAGBy593TcPwy
         D/K+SC+8XFns6cjTP9wP/XtQSt43Juw8T6VeyPWDsq2j67S16dw+Anx3TrOM4WwmBgui
         xaB3PyqOzi3La69nneVYjYVNwLi0VkRbtNtcYltqWOlteg5CBk6WsZZatQSXsJkz8HJv
         wQF4Z1rrfoSYQlWFYlxO2CsnrQEJD+E4tLC/Tu3ueeKIG6ZY1G85jNUW6vMhx42ALgaB
         k1TektsPOOr8vFJzYqv1pnv5ng83/bRoBpPhYwd9HTP0MqqoKSzp8Uxr5KBaw8j8GCEP
         z40A==
X-Gm-Message-State: APjAAAVcEqonRZt0tBMKPTdEWnNtEZWJWn+nuS4h6lpAHuTROk7U8XfL
        gT50weWfAS0CGK7hbGddBvg=
X-Google-Smtp-Source: APXvYqxLfYP7dNCG8E1yxQOGrRDglt2Kt2HKST4ZJffgNCqtameGmym6UUiDn6xM6ap7QmGZTxxx4w==
X-Received: by 2002:aa7:c353:: with SMTP id j19mr36340105edr.292.1567514728173;
        Tue, 03 Sep 2019 05:45:28 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:d18b:bb02:c1af:62c1])
        by smtp.gmail.com with ESMTPSA id r13sm3418061edb.16.2019.09.03.05.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 05:45:27 -0700 (PDT)
From:   Guoqing Jiang <jgq516@gmail.com>
X-Google-Original-From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     dledford@redhat.com, jgg@ziepe.ca, corbet@lwn.net
Cc:     linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Subject: [PATCH] Documentation/infiniband: update name of some functions
Date:   Tue,  3 Sep 2019 14:45:19 +0200
Message-Id: <20190903124519.28318-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Update the document since those functions had been renamed in below.

commit 0a18cfe4f6d7d ("IB/core: Rename ib_create_ah to rdma_create_ah")
commit 67b985b6c7553 ("IB/core: Rename ib_modify_ah to rdma_modify_ah")
commit bfbfd661c9ea2 ("IB/core: Rename ib_query_ah to rdma_query_ah")
commit 365231593409f ("IB/core: Rename ib_destroy_ah to rdma_destroy_ah")

Cc: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 Documentation/infiniband/core_locking.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/infiniband/core_locking.rst b/Documentation/infiniband/core_locking.rst
index f34669beb4fe..8f76a8a5a38f 100644
--- a/Documentation/infiniband/core_locking.rst
+++ b/Documentation/infiniband/core_locking.rst
@@ -29,10 +29,10 @@ Sleeping and interrupt context
   The corresponding functions exported to upper level protocol
   consumers:
 
-    - ib_create_ah
-    - ib_modify_ah
-    - ib_query_ah
-    - ib_destroy_ah
+    - rdma_create_ah
+    - rdma_modify_ah
+    - rdma_query_ah
+    - rdma_destroy_ah
     - ib_post_send
     - ib_post_recv
     - ib_req_notify_cq
-- 
2.17.1

