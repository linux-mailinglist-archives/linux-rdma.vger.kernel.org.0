Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDD95B028
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Jun 2019 16:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfF3Ox3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 30 Jun 2019 10:53:29 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:65340 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3Ox3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 30 Jun 2019 10:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1561906407; x=1593442407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gVIjeCi9sf3UdHyY1xpkpBIiFpGbYnsNIT9kQ8q1e+E=;
  b=VpSi3v7pcPNqg+nHxAUVsoP8o3UBd7YkRo4ShBN6Ua3OcdnBn86qsAHQ
   a6EJJaGE4+PO95KyT3Mv3gRamRQt+cOO98UHWeFApgW7AYHtxgHufHo1y
   yKPfIpMEI/+5K2uozz+QF+NPAK33hBezYiORkOIoaR2ZHrNPGqVVIAMTv
   c=;
X-IronPort-AV: E=Sophos;i="5.62,434,1554768000"; 
   d="scan'208";a="408698686"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 30 Jun 2019 14:53:26 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id E41F4A2182;
        Sun, 30 Jun 2019 14:53:25 +0000 (UTC)
Received: from EX13D22EUA003.ant.amazon.com (10.43.165.210) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 30 Jun 2019 14:53:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D22EUA003.ant.amazon.com (10.43.165.210) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 30 Jun 2019 14:53:24 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.133) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 30 Jun 2019 14:53:21 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        "Gal Pressman" <galpress@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Entropy in admin commands id
Date:   Sun, 30 Jun 2019 17:53:02 +0300
Message-ID: <20190630145302.13603-1-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Daniel Kranzdorf <dkkranzd@amazon.com>

Make admin commands id easier to distinguish by using relevant bits from
the producer counter.
This allows us to differentiate admin commands with the same producer
index (happens after admin queue overlap), which is helpful when
debugging.

Signed-off-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com.c | 44 +++++++++++++++--------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index ec04ced9fd2b..2cb42484b0f8 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -278,36 +278,34 @@ static void efa_com_dealloc_ctx_id(struct efa_com_admin_queue *aq,
 static inline void efa_com_put_comp_ctx(struct efa_com_admin_queue *aq,
 					struct efa_comp_ctx *comp_ctx)
 {
-	u16 comp_id = comp_ctx->user_cqe->acq_common_descriptor.command &
-		      EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID_MASK;
+	u16 cmd_id = comp_ctx->user_cqe->acq_common_descriptor.command &
+		     EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID_MASK;
+	u16 ctx_id = cmd_id & (aq->depth - 1);
 
-	ibdev_dbg(aq->efa_dev, "Putting completion command_id %d\n", comp_id);
+	ibdev_dbg(aq->efa_dev, "Put completion command_id %#x\n", cmd_id);
 	comp_ctx->occupied = 0;
-	efa_com_dealloc_ctx_id(aq, comp_id);
+	efa_com_dealloc_ctx_id(aq, ctx_id);
 }
 
 static struct efa_comp_ctx *efa_com_get_comp_ctx(struct efa_com_admin_queue *aq,
-						 u16 command_id, bool capture)
+						 u16 cmd_id, bool capture)
 {
-	if (command_id >= aq->depth) {
-		ibdev_err(aq->efa_dev,
-			  "command id is larger than the queue size. cmd_id: %u queue size %d\n",
-			  command_id, aq->depth);
-		return NULL;
-	}
+	u16 ctx_id = cmd_id & (aq->depth - 1);
 
-	if (aq->comp_ctx[command_id].occupied && capture) {
-		ibdev_err(aq->efa_dev, "Completion context is occupied\n");
+	if (aq->comp_ctx[ctx_id].occupied && capture) {
+		ibdev_err(aq->efa_dev,
+			  "Completion context for command_id %#x is occupied\n",
+			  cmd_id);
 		return NULL;
 	}
 
 	if (capture) {
-		aq->comp_ctx[command_id].occupied = 1;
-		ibdev_dbg(aq->efa_dev, "Taking completion ctxt command_id %d\n",
-			  command_id);
+		aq->comp_ctx[ctx_id].occupied = 1;
+		ibdev_dbg(aq->efa_dev,
+			  "Take completion ctxt for command_id %#x\n", cmd_id);
 	}
 
-	return &aq->comp_ctx[command_id];
+	return &aq->comp_ctx[ctx_id];
 }
 
 static struct efa_comp_ctx *__efa_com_submit_admin_cmd(struct efa_com_admin_queue *aq,
@@ -318,6 +316,7 @@ static struct efa_comp_ctx *__efa_com_submit_admin_cmd(struct efa_com_admin_queu
 {
 	struct efa_comp_ctx *comp_ctx;
 	u16 queue_size_mask;
+	u16 cmd_id;
 	u16 ctx_id;
 	u16 pi;
 
@@ -326,13 +325,16 @@ static struct efa_comp_ctx *__efa_com_submit_admin_cmd(struct efa_com_admin_queu
 
 	ctx_id = efa_com_alloc_ctx_id(aq);
 
+	/* cmd_id LSBs are the ctx_id and MSBs are entropy bits from pc */
+	cmd_id = ctx_id & queue_size_mask;
+	cmd_id |= aq->sq.pc & ~queue_size_mask;
+	cmd_id &= EFA_ADMIN_AQ_COMMON_DESC_COMMAND_ID_MASK;
+
+	cmd->aq_common_descriptor.command_id = cmd_id;
 	cmd->aq_common_descriptor.flags |= aq->sq.phase &
 		EFA_ADMIN_AQ_COMMON_DESC_PHASE_MASK;
 
-	cmd->aq_common_descriptor.command_id |= ctx_id &
-		EFA_ADMIN_AQ_COMMON_DESC_COMMAND_ID_MASK;
-
-	comp_ctx = efa_com_get_comp_ctx(aq, ctx_id, true);
+	comp_ctx = efa_com_get_comp_ctx(aq, cmd_id, true);
 	if (!comp_ctx) {
 		efa_com_dealloc_ctx_id(aq, ctx_id);
 		return ERR_PTR(-EINVAL);
-- 
2.22.0

