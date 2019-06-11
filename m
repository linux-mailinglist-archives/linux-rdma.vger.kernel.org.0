Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E283D172
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 17:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391833AbfFKPxO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 11:53:14 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33187 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391827AbfFKPxO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 11:53:14 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 Jun 2019 18:53:01 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x5BFqxLI023036;
        Tue, 11 Jun 2019 18:53:01 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 16/21] RDMA/rw: Introduce rdma_rw_inv_key helper
Date:   Tue, 11 Jun 2019 18:52:52 +0300
Message-Id: <1560268377-26560-17-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
References: <1560268377-26560-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

This is a preparation for adding new signature API to the rw-API.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/core/rw.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 289aef824269..096fafec1047 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -57,6 +57,22 @@ static inline u32 rdma_rw_fr_page_list_len(struct ib_device *dev)
 	return min_t(u32, dev->attrs.max_fast_reg_page_list_len, 256);
 }
 
+static inline int rdma_rw_inv_key(struct rdma_rw_reg_ctx *reg)
+{
+	int count = 0;
+
+	if (reg->mr->need_inval) {
+		reg->inv_wr.opcode = IB_WR_LOCAL_INV;
+		reg->inv_wr.ex.invalidate_rkey = reg->mr->lkey;
+		reg->inv_wr.next = &reg->reg_wr.wr;
+		count++;
+	} else {
+		reg->inv_wr.next = NULL;
+	}
+
+	return count;
+}
+
 /* Caller must have zero-initialized *reg. */
 static int rdma_rw_init_one_mr(struct ib_qp *qp, u8 port_num,
 		struct rdma_rw_reg_ctx *reg, struct scatterlist *sg,
@@ -70,14 +86,7 @@ static int rdma_rw_init_one_mr(struct ib_qp *qp, u8 port_num,
 	if (!reg->mr)
 		return -EAGAIN;
 
-	if (reg->mr->need_inval) {
-		reg->inv_wr.opcode = IB_WR_LOCAL_INV;
-		reg->inv_wr.ex.invalidate_rkey = reg->mr->lkey;
-		reg->inv_wr.next = &reg->reg_wr.wr;
-		count++;
-	} else {
-		reg->inv_wr.next = NULL;
-	}
+	count += rdma_rw_inv_key(reg);
 
 	ret = ib_map_mr_sg(reg->mr, sg, nents, &offset, PAGE_SIZE);
 	if (ret < 0 || ret < nents) {
-- 
2.16.3

