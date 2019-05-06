Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1A114F3D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfEFPID (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:08:03 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:50102 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727388AbfEFPHr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 11:07:47 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2019 18:07:40 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x46F7edZ019922;
        Mon, 6 May 2019 18:07:40 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     leon@kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 03/11] Documentation: Document Address Handle creation with pyverbs
Date:   Mon,  6 May 2019 18:07:30 +0300
Message-Id: <20190506150738.19477-4-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190506150738.19477-1-noaos@mellanox.com>
References: <20190506150738.19477-1-noaos@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add code snippet to show AH creation.
Fix a typo in DMMR snippet.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 Documentation/pyverbs.md | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/pyverbs.md b/Documentation/pyverbs.md
index 3a20b7a95769..371fcd07b2cd 100644
--- a/Documentation/pyverbs.md
+++ b/Documentation/pyverbs.md
@@ -209,7 +209,7 @@ device's own memory rather than a user-allocated buffer.
 import random
 
 from pyverbs.device import DM, AllocDmAttr
-from pyverbs.mr import DmMr
+from pyverbs.mr import DMMR
 import pyverbs.device as d
 from pyverbs.pd import PD
 import pyverbs.enums as e
@@ -222,7 +222,7 @@ with d.Context(name='mlx5_0') as ctx:
         dm_mr_len = random.randint(4, dm_len)
         with DM(ctx, dm_attrs) as dm:
             with PD(ctx) as pd:
-                dm_mr = DmMr(pd, dm_mr_len, e.IBV_ACCESS_ZERO_BASED, dm=dm,
+                dm_mr = DMMR(pd, dm_mr_len, e.IBV_ACCESS_ZERO_BASED, dm=dm,
                              offset=0)
 ```
 
@@ -280,4 +280,30 @@ flags                 : 0
 Extended CQ:
 Handle                : 0
 CQEs                  : 15
-```
\ No newline at end of file
+```
+
+##### Addressing related objects
+The following code demonstrates creation of GlobalRoute, AHAttr and AH objects.
+The example creates a global AH so it can also run on RoCE without
+modifications.
+```python
+
+from pyverbs.addr import GlobalRoute, AHAttr, AH
+import pyverbs.device as d
+from pyverbs.pd import PD
+
+with d.Context(name='mlx5_0') as ctx:
+    port_number = 1
+    gid_index = 0  # GID index 0 always exists and valid
+    gid = ctx.query_gid(port_number, gid_index)
+    gr = GlobalRoute(dgid=gid, sgid_index=gid_index)
+    ah_attr = AHAttr(gr=gr, is_global=1, port_num=port_number)
+    print(ah_attr)
+    with PD(ctx) as pd:
+        ah = AH(pd, attr=ah_attr)
+DGID                  : fe80:0000:0000:0000:9a03:9bff:fe00:e4bf
+flow label            : 0
+sgid index            : 0
+hop limit             : 1
+traffic class         : 0
+```
-- 
2.17.2

