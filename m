Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACED14F18
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfEFPHr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:07:47 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:50132 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727531AbfEFPHr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 11:07:47 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2019 18:07:41 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x46F7edf019922;
        Mon, 6 May 2019 18:07:41 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     leon@kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 09/11] Documentation: Document QP creation and basic usage with pyverbs
Date:   Mon,  6 May 2019 18:07:36 +0300
Message-Id: <20190506150738.19477-10-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190506150738.19477-1-noaos@mellanox.com>
References: <20190506150738.19477-1-noaos@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add code to show the needed steps for QP creation as well as a simple
post_send.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 Documentation/pyverbs.md | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/pyverbs.md b/Documentation/pyverbs.md
index 371fcd07b2cd..22c51868e025 100644
--- a/Documentation/pyverbs.md
+++ b/Documentation/pyverbs.md
@@ -307,3 +307,35 @@ sgid index            : 0
 hop limit             : 1
 traffic class         : 0
 ```
+
+##### QP
+The following snippets will demonstrate creation of a QP and a simple post_send
+operation. For more complex examples, please see pyverbs/examples section.
+```python
+from pyverbs.qp import QPCap, QPInitAttr, QPAttr, QP
+from pyverbs.addr import GlobalRoute
+from pyverbs.addr import AH, AHAttr
+import pyverbs.device as d
+import pyverbs.enums as e
+from pyverbs.pd import PD
+from pyverbs.cq import CQ
+import pyverbs.wr as pwr
+
+
+ctx = d.Context(name='mlx5_0')
+pd = PD(ctx)
+cq = CQ(ctx, 100, None, None, 0)
+cap = QPCap(100, 10, 1, 1, 0)
+qia = QPInitAttr(cap=cap, qp_type = e.IBV_QPT_UD, scq=cq, rcq=cq)
+# A UD QP will be in RTS if a QPAttr object is provided
+udqp = QP(pd, qia, QPAttr())
+port_num = 1
+gid_index = 3 # Hard-coded for RoCE v2 interface
+gid = ctx.query_gid(port_num, gid_index)
+gr = GlobalRoute(dgid=gid, sgid_index=gid_index)
+ah_attr = AHAttr(gr=gr, is_global=1, port_num=port_num)
+ah=AH(pd, ah_attr)
+wr = pwr.SendWR()
+wr.set_wr_ud(ah, 0x1101, 0) # in real life, use real values
+udqp.post_send(wr)
+```
-- 
2.17.2

