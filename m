Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9639B192BF3
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2020 16:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgCYPMv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Mar 2020 11:12:51 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:45398 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727768AbgCYPMu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Mar 2020 11:12:50 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from sergeygo@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 25 Mar 2020 17:12:48 +0200
Received: from rsws38.mtr.labs.mlnx (rsws38.mtr.labs.mlnx [10.209.40.117])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02PFCmlG021025;
        Wed, 25 Mar 2020 17:12:48 +0200
From:   Sergey Gorenko <sergeygo@mellanox.com>
To:     sagi@grimberg.me
Cc:     linux-rdma@vger.kernel.org, Sergey Gorenko <sergeygo@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH] IB/iser: Always check sig MR before putting it to the free pool
Date:   Wed, 25 Mar 2020 15:12:10 +0000
Message-Id: <20200325151210.1548-1-sergeygo@mellanox.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

libiscsi calls the check_protection transport handler only if
SCSI-Respose is received. So, the handler is never called if iSCSI
task is completed for some other reason like a timeout or error
handling. And this behavior looks correct. But the iSER does not
handle this case properly because it puts a non-checked signature
MR to the free pool. Then the error occurs at reusing the MR
because it is not allowed to invalidate a signature MR without
checking.

This commit adds an extra check to iser_unreg_mem_fastreg(), which
is a part of the task cleanup flow. Now the signature MR is
checked there if it is needed.

Signed-off-by: Sergey Gorenko <sergeygo@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/iser/iser_memory.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 7a8f24de3631..999ef7cdd05e 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -292,12 +292,27 @@ void iser_unreg_mem_fastreg(struct iscsi_iser_task *iser_task,
 {
 	struct iser_device *device = iser_task->iser_conn->ib_conn.device;
 	struct iser_mem_reg *reg = &iser_task->rdma_reg[cmd_dir];
+	struct iser_fr_desc *desc;
+	struct ib_mr_status mr_status;
 
-	if (!reg->mem_h)
+	desc = reg->mem_h;
+	if (!desc)
 		return;
 
-	device->reg_ops->reg_desc_put(&iser_task->iser_conn->ib_conn,
-				     reg->mem_h);
+	/*
+	 * The signature MR cannot be invalidated and reused without checking.
+	 * libiscsi calls the check_protection transport handler only if
+	 * SCSI-Response is received. And the signature MR is not checked if
+	 * the task is completed for some other reason like a timeout or error
+	 * handling. That's why we must check the signature MR here before
+	 * putting it to the free pool.
+	 */
+	if (unlikely(desc->sig_protected)) {
+		desc->sig_protected = false;
+		ib_check_mr_status(desc->rsc.sig_mr, IB_MR_CHECK_SIG_STATUS,
+				   &mr_status);
+	}
+	device->reg_ops->reg_desc_put(&iser_task->iser_conn->ib_conn, desc);
 	reg->mem_h = NULL;
 }
 
-- 
2.21.1

