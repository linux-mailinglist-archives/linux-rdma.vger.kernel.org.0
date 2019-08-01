Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989557E0D5
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 19:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbfHARPa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 13:15:30 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:34905 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfHARPa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Aug 2019 13:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564679728; x=1596215728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pTaB8kXXRDNBVA1sJtKoajgZaWp5zmHX1OmL2qTj6NU=;
  b=jMaYuDTDEX+vDIlUPOXZc8RlIwuMtdx+3wIwflmsRR81aiY5IPiTRA/I
   DVnMtysQOX/oihpDy4iWYnW+uPthznGJKfewutt2tDlMT8VtPpru/x4VE
   d/8StXJYvgACMzX38xGQcxcl0kZWb7TWLMjYSJvNm5BaBUsxphdiy0yb+
   E=;
X-IronPort-AV: E=Sophos;i="5.64,334,1559520000"; 
   d="scan'208";a="413458400"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-397e131e.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 01 Aug 2019 17:15:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-397e131e.us-west-2.amazon.com (Postfix) with ESMTPS id 67FFDA2DE3;
        Thu,  1 Aug 2019 17:15:25 +0000 (UTC)
Received: from EX13D19EUA001.ant.amazon.com (10.43.165.74) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 17:15:24 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D19EUA001.ant.amazon.com (10.43.165.74) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 17:15:23 +0000
Received: from 8c85908914bf.ant.amazon.com (10.95.68.21) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 1 Aug 2019 17:15:19 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        "Leon Romanovsky" <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Firas JahJah" <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next v2 2/2] RDMA/efa: Rate limit admin queue error prints
Date:   Thu, 1 Aug 2019 20:14:47 +0300
Message-ID: <20190801171447.54440-3-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801171447.54440-1-galpress@amazon.com>
References: <20190801171447.54440-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Admin queue error prints should never happen unless something wrong
happened to the device. However, in the unfortunate case that it does,
we should take extra care not to flood the log with error messages.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com.c     |  70 ++++++------
 drivers/infiniband/hw/efa/efa_com_cmd.c | 136 ++++++++++++++----------
 2 files changed, 120 insertions(+), 86 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 2cb42484b0f8..3c412bc5b94f 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -109,17 +109,19 @@ static u32 efa_com_reg_read32(struct efa_com_dev *edev, u16 offset)
 	} while (time_is_after_jiffies(exp_time));
 
 	if (read_resp->req_id != mmio_read->seq_num) {
-		ibdev_err(edev->efa_dev,
-			  "Reading register timed out. expected: req id[%u] offset[%#x] actual: req id[%u] offset[%#x]\n",
-			  mmio_read->seq_num, offset, read_resp->req_id,
-			  read_resp->reg_off);
+		ibdev_err_ratelimited(
+			edev->efa_dev,
+			"Reading register timed out. expected: req id[%u] offset[%#x] actual: req id[%u] offset[%#x]\n",
+			mmio_read->seq_num, offset, read_resp->req_id,
+			read_resp->reg_off);
 		err = EFA_MMIO_READ_INVALID;
 		goto out;
 	}
 
 	if (read_resp->reg_off != offset) {
-		ibdev_err(edev->efa_dev,
-			  "Reading register failed: wrong offset provided\n");
+		ibdev_err_ratelimited(
+			edev->efa_dev,
+			"Reading register failed: wrong offset provided\n");
 		err = EFA_MMIO_READ_INVALID;
 		goto out;
 	}
@@ -293,9 +295,10 @@ static struct efa_comp_ctx *efa_com_get_comp_ctx(struct efa_com_admin_queue *aq,
 	u16 ctx_id = cmd_id & (aq->depth - 1);
 
 	if (aq->comp_ctx[ctx_id].occupied && capture) {
-		ibdev_err(aq->efa_dev,
-			  "Completion context for command_id %#x is occupied\n",
-			  cmd_id);
+		ibdev_err_ratelimited(
+			aq->efa_dev,
+			"Completion context for command_id %#x is occupied\n",
+			cmd_id);
 		return NULL;
 	}
 
@@ -401,7 +404,7 @@ static struct efa_comp_ctx *efa_com_submit_admin_cmd(struct efa_com_admin_queue
 
 	spin_lock(&aq->sq.lock);
 	if (!test_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state)) {
-		ibdev_err(aq->efa_dev, "Admin queue is closed\n");
+		ibdev_err_ratelimited(aq->efa_dev, "Admin queue is closed\n");
 		spin_unlock(&aq->sq.lock);
 		return ERR_PTR(-ENODEV);
 	}
@@ -519,8 +522,9 @@ static int efa_com_wait_and_process_admin_cq_polling(struct efa_comp_ctx *comp_c
 			break;
 
 		if (time_is_before_jiffies(timeout)) {
-			ibdev_err(aq->efa_dev,
-				  "Wait for completion (polling) timeout\n");
+			ibdev_err_ratelimited(
+				aq->efa_dev,
+				"Wait for completion (polling) timeout\n");
 			/* EFA didn't have any completion */
 			atomic64_inc(&aq->stats.no_completion);
 
@@ -561,17 +565,19 @@ static int efa_com_wait_and_process_admin_cq_interrupts(struct efa_comp_ctx *com
 		atomic64_inc(&aq->stats.no_completion);
 
 		if (comp_ctx->status == EFA_CMD_COMPLETED)
-			ibdev_err(aq->efa_dev,
-				  "The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (ctx: 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
-				  efa_com_cmd_str(comp_ctx->cmd_opcode),
-				  comp_ctx->cmd_opcode, comp_ctx->status,
-				  comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
+			ibdev_err_ratelimited(
+				aq->efa_dev,
+				"The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (ctx: 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
+				efa_com_cmd_str(comp_ctx->cmd_opcode),
+				comp_ctx->cmd_opcode, comp_ctx->status,
+				comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
 		else
-			ibdev_err(aq->efa_dev,
-				  "The device didn't send any completion for admin cmd %s(%d) status %d (ctx 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
-				  efa_com_cmd_str(comp_ctx->cmd_opcode),
-				  comp_ctx->cmd_opcode, comp_ctx->status,
-				  comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
+			ibdev_err_ratelimited(
+				aq->efa_dev,
+				"The device didn't send any completion for admin cmd %s(%d) status %d (ctx 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
+				efa_com_cmd_str(comp_ctx->cmd_opcode),
+				comp_ctx->cmd_opcode, comp_ctx->status,
+				comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
 
 		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
 		err = -ETIME;
@@ -633,10 +639,11 @@ int efa_com_cmd_exec(struct efa_com_admin_queue *aq,
 		  cmd->aq_common_descriptor.opcode);
 	comp_ctx = efa_com_submit_admin_cmd(aq, cmd, cmd_size, comp, comp_size);
 	if (IS_ERR(comp_ctx)) {
-		ibdev_err(aq->efa_dev,
-			  "Failed to submit command %s (opcode %u) err %ld\n",
-			  efa_com_cmd_str(cmd->aq_common_descriptor.opcode),
-			  cmd->aq_common_descriptor.opcode, PTR_ERR(comp_ctx));
+		ibdev_err_ratelimited(
+			aq->efa_dev,
+			"Failed to submit command %s (opcode %u) err %ld\n",
+			efa_com_cmd_str(cmd->aq_common_descriptor.opcode),
+			cmd->aq_common_descriptor.opcode, PTR_ERR(comp_ctx));
 
 		up(&aq->avail_cmds);
 		return PTR_ERR(comp_ctx);
@@ -644,11 +651,12 @@ int efa_com_cmd_exec(struct efa_com_admin_queue *aq,
 
 	err = efa_com_wait_and_process_admin_cq(comp_ctx, aq);
 	if (err)
-		ibdev_err(aq->efa_dev,
-			  "Failed to process command %s (opcode %u) comp_status %d err %d\n",
-			  efa_com_cmd_str(cmd->aq_common_descriptor.opcode),
-			  cmd->aq_common_descriptor.opcode,
-			  comp_ctx->comp_status, err);
+		ibdev_err_ratelimited(
+			aq->efa_dev,
+			"Failed to process command %s (opcode %u) comp_status %d err %d\n",
+			efa_com_cmd_str(cmd->aq_common_descriptor.opcode),
+			cmd->aq_common_descriptor.opcode, comp_ctx->comp_status,
+			err);
 
 	up(&aq->avail_cmds);
 
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 16b115df63e8..501dce89f275 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -44,7 +44,8 @@ int efa_com_create_qp(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to create qp [%d]\n", err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to create qp [%d]\n", err);
 		return err;
 	}
 
@@ -82,9 +83,10 @@ int efa_com_modify_qp(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&resp,
 			       sizeof(resp));
 	if (err) {
-		ibdev_err(edev->efa_dev,
-			  "Failed to modify qp-%u modify_mask[%#x] [%d]\n",
-			  cmd.qp_handle, cmd.modify_mask, err);
+		ibdev_err_ratelimited(
+			edev->efa_dev,
+			"Failed to modify qp-%u modify_mask[%#x] [%d]\n",
+			cmd.qp_handle, cmd.modify_mask, err);
 		return err;
 	}
 
@@ -109,8 +111,9 @@ int efa_com_query_qp(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&resp,
 			       sizeof(resp));
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to query qp-%u [%d]\n",
-			  cmd.qp_handle, err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to query qp-%u [%d]\n",
+				      cmd.qp_handle, err);
 		return err;
 	}
 
@@ -139,8 +142,9 @@ int efa_com_destroy_qp(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to destroy qp-%u [%d]\n",
-			  qp_cmd.qp_handle, err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to destroy qp-%u [%d]\n",
+				      qp_cmd.qp_handle, err);
 		return err;
 	}
 
@@ -173,7 +177,8 @@ int efa_com_create_cq(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to create cq[%d]\n", err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to create cq[%d]\n", err);
 		return err;
 	}
 
@@ -201,8 +206,9 @@ int efa_com_destroy_cq(struct efa_com_dev *edev,
 			       sizeof(destroy_resp));
 
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to destroy CQ-%u [%d]\n",
-			  params->cq_idx, err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to destroy CQ-%u [%d]\n",
+				      params->cq_idx, err);
 		return err;
 	}
 
@@ -250,7 +256,8 @@ int efa_com_register_mr(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to register mr [%d]\n", err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to register mr [%d]\n", err);
 		return err;
 	}
 
@@ -277,9 +284,9 @@ int efa_com_dereg_mr(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
 	if (err) {
-		ibdev_err(edev->efa_dev,
-			  "Failed to de-register mr(lkey-%u) [%d]\n",
-			  mr_cmd.l_key, err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to de-register mr(lkey-%u) [%d]\n",
+				      mr_cmd.l_key, err);
 		return err;
 	}
 
@@ -306,8 +313,9 @@ int efa_com_create_ah(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to create ah for %pI6 [%d]\n",
-			  ah_cmd.dest_addr, err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to create ah for %pI6 [%d]\n",
+				      ah_cmd.dest_addr, err);
 		return err;
 	}
 
@@ -334,8 +342,9 @@ int efa_com_destroy_ah(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&cmd_completion,
 			       sizeof(cmd_completion));
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to destroy ah-%d pd-%d [%d]\n",
-			  ah_cmd.ah, ah_cmd.pd, err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to destroy ah-%d pd-%d [%d]\n",
+				      ah_cmd.ah, ah_cmd.pd, err);
 		return err;
 	}
 
@@ -367,8 +376,9 @@ static int efa_com_get_feature_ex(struct efa_com_dev *edev,
 	int err;
 
 	if (!efa_com_check_supported_feature_id(edev, feature_id)) {
-		ibdev_err(edev->efa_dev, "Feature %d isn't supported\n",
-			  feature_id);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Feature %d isn't supported\n",
+				      feature_id);
 		return -EOPNOTSUPP;
 	}
 
@@ -396,9 +406,10 @@ static int efa_com_get_feature_ex(struct efa_com_dev *edev,
 			       sizeof(*get_resp));
 
 	if (err) {
-		ibdev_err(edev->efa_dev,
-			  "Failed to submit get_feature command %d [%d]\n",
-			  feature_id, err);
+		ibdev_err_ratelimited(
+			edev->efa_dev,
+			"Failed to submit get_feature command %d [%d]\n",
+			feature_id, err);
 		return err;
 	}
 
@@ -421,8 +432,9 @@ int efa_com_get_network_attr(struct efa_com_dev *edev,
 	err = efa_com_get_feature(edev, &resp,
 				  EFA_ADMIN_NETWORK_ATTR);
 	if (err) {
-		ibdev_err(edev->efa_dev,
-			  "Failed to get network attributes %d\n", err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to get network attributes %d\n",
+				      err);
 		return err;
 	}
 
@@ -441,8 +453,9 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 
 	err = efa_com_get_feature(edev, &resp, EFA_ADMIN_DEVICE_ATTR);
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to get device attributes %d\n",
-			  err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to get device attributes %d\n",
+				      err);
 		return err;
 	}
 
@@ -456,9 +469,10 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 	result->db_bar = resp.u.device_attr.db_bar;
 
 	if (result->admin_api_version < 1) {
-		ibdev_err(edev->efa_dev,
-			  "Failed to get device attr api version [%u < 1]\n",
-			  result->admin_api_version);
+		ibdev_err_ratelimited(
+			edev->efa_dev,
+			"Failed to get device attr api version [%u < 1]\n",
+			result->admin_api_version);
 		return -EINVAL;
 	}
 
@@ -466,8 +480,9 @@ int efa_com_get_device_attr(struct efa_com_dev *edev,
 	err = efa_com_get_feature(edev, &resp,
 				  EFA_ADMIN_QUEUE_ATTR);
 	if (err) {
-		ibdev_err(edev->efa_dev,
-			  "Failed to get network attributes %d\n", err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to get network attributes %d\n",
+				      err);
 		return err;
 	}
 
@@ -497,7 +512,8 @@ int efa_com_get_hw_hints(struct efa_com_dev *edev,
 
 	err = efa_com_get_feature(edev, &resp, EFA_ADMIN_HW_HINTS);
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to get hw hints %d\n", err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to get hw hints %d\n", err);
 		return err;
 	}
 
@@ -520,8 +536,9 @@ static int efa_com_set_feature_ex(struct efa_com_dev *edev,
 	int err;
 
 	if (!efa_com_check_supported_feature_id(edev, feature_id)) {
-		ibdev_err(edev->efa_dev, "Feature %d isn't supported\n",
-			  feature_id);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Feature %d isn't supported\n",
+				      feature_id);
 		return -EOPNOTSUPP;
 	}
 
@@ -545,9 +562,10 @@ static int efa_com_set_feature_ex(struct efa_com_dev *edev,
 			       sizeof(*set_resp));
 
 	if (err) {
-		ibdev_err(edev->efa_dev,
-			  "Failed to submit set_feature command %d error: %d\n",
-			  feature_id, err);
+		ibdev_err_ratelimited(
+			edev->efa_dev,
+			"Failed to submit set_feature command %d error: %d\n",
+			feature_id, err);
 		return err;
 	}
 
@@ -574,8 +592,9 @@ int efa_com_set_aenq_config(struct efa_com_dev *edev, u32 groups)
 
 	err = efa_com_get_feature(edev, &get_resp, EFA_ADMIN_AENQ_CONFIG);
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to get aenq attributes: %d\n",
-			  err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to get aenq attributes: %d\n",
+				      err);
 		return err;
 	}
 
@@ -585,9 +604,10 @@ int efa_com_set_aenq_config(struct efa_com_dev *edev, u32 groups)
 		  get_resp.u.aenq.enabled_groups);
 
 	if ((get_resp.u.aenq.supported_groups & groups) != groups) {
-		ibdev_err(edev->efa_dev,
-			  "Trying to set unsupported aenq groups[%#x] supported[%#x]\n",
-			  groups, get_resp.u.aenq.supported_groups);
+		ibdev_err_ratelimited(
+			edev->efa_dev,
+			"Trying to set unsupported aenq groups[%#x] supported[%#x]\n",
+			groups, get_resp.u.aenq.supported_groups);
 		return -EOPNOTSUPP;
 	}
 
@@ -595,8 +615,9 @@ int efa_com_set_aenq_config(struct efa_com_dev *edev, u32 groups)
 	err = efa_com_set_feature(edev, &set_resp, &cmd,
 				  EFA_ADMIN_AENQ_CONFIG);
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to set aenq attributes: %d\n",
-			  err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to set aenq attributes: %d\n",
+				      err);
 		return err;
 	}
 
@@ -619,7 +640,8 @@ int efa_com_alloc_pd(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&resp,
 			       sizeof(resp));
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to allocate pd[%d]\n", err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to allocate pd[%d]\n", err);
 		return err;
 	}
 
@@ -645,8 +667,9 @@ int efa_com_dealloc_pd(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&resp,
 			       sizeof(resp));
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to deallocate pd-%u [%d]\n",
-			  cmd.pd, err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to deallocate pd-%u [%d]\n",
+				      cmd.pd, err);
 		return err;
 	}
 
@@ -669,7 +692,8 @@ int efa_com_alloc_uar(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&resp,
 			       sizeof(resp));
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to allocate uar[%d]\n", err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to allocate uar[%d]\n", err);
 		return err;
 	}
 
@@ -695,8 +719,9 @@ int efa_com_dealloc_uar(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&resp,
 			       sizeof(resp));
 	if (err) {
-		ibdev_err(edev->efa_dev, "Failed to deallocate uar-%u [%d]\n",
-			  cmd.uar, err);
+		ibdev_err_ratelimited(edev->efa_dev,
+				      "Failed to deallocate uar-%u [%d]\n",
+				      cmd.uar, err);
 		return err;
 	}
 
@@ -723,9 +748,10 @@ int efa_com_get_stats(struct efa_com_dev *edev,
 			       (struct efa_admin_acq_entry *)&resp,
 			       sizeof(resp));
 	if (err) {
-		ibdev_err(edev->efa_dev,
-			  "Failed to get stats type-%u scope-%u.%u [%d]\n",
-			  cmd.type, cmd.scope, cmd.scope_modifier, err);
+		ibdev_err_ratelimited(
+			edev->efa_dev,
+			"Failed to get stats type-%u scope-%u.%u [%d]\n",
+			cmd.type, cmd.scope, cmd.scope_modifier, err);
 		return err;
 	}
 
-- 
2.22.0

