Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3BDBADD3
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 08:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393210AbfIWGaV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 02:30:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387519AbfIWGaV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Sep 2019 02:30:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8F33308FC20;
        Mon, 23 Sep 2019 06:30:20 +0000 (UTC)
Received: from dhcp-128-227.nay.redhat.com (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFF7319C78;
        Mon, 23 Sep 2019 06:30:18 +0000 (UTC)
From:   Honggang LI <honli@redhat.com>
To:     bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, Honggang Li <honli@redhat.com>
Subject: [patch v4 2/2] RDMA/srp: calculate max_it_iu_size if remote max_it_iu length available
Date:   Mon, 23 Sep 2019 14:29:40 +0800
Message-Id: <20190923062940.12330-2-honli@redhat.com>
In-Reply-To: <20190923062940.12330-1-honli@redhat.com>
References: <20190923062940.12330-1-honli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 23 Sep 2019 06:30:20 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Honggang Li <honli@redhat.com>

The default maximum immediate size is too big for old srp clients,
which do not support immediate data.

According to the SRP and SRP-2 specifications, the IOControllerProfile
attributes for SRP target ports contains the maximum initiator to target
iu length.

The maximum initiator to target iu length can be retrieved from the subnet
manager, such as opensm and opafm. We should calculate the
max_it_iu_size instead of the default value, when remote maximum
initiator to target iu length available.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Honggang Li <honli@redhat.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index b829dab0df77..b3bf5d552de9 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -139,7 +139,7 @@ MODULE_PARM_DESC(use_imm_data,
 
 static unsigned int srp_max_imm_data = 8 * 1024;
 module_param_named(max_imm_data, srp_max_imm_data, uint, 0644);
-MODULE_PARM_DESC(max_imm_data, "Maximum immediate data size.");
+MODULE_PARM_DESC(max_imm_data, "Maximum immediate data size if max_it_iu_size has not been specified.");
 
 static unsigned ch_count;
 module_param(ch_count, uint, 0444);
@@ -1362,15 +1362,23 @@ static void srp_terminate_io(struct srp_rport *rport)
 }
 
 /* Calculate maximum initiator to target information unit length. */
-static uint32_t srp_max_it_iu_len(int cmd_sg_cnt, bool use_imm_data)
+static uint32_t srp_max_it_iu_len(int cmd_sg_cnt, bool use_imm_data,
+				  uint32_t max_it_iu_size)
 {
 	uint32_t max_iu_len = sizeof(struct srp_cmd) + SRP_MAX_ADD_CDB_LEN +
 		sizeof(struct srp_indirect_buf) +
 		cmd_sg_cnt * sizeof(struct srp_direct_buf);
 
-	if (use_imm_data)
-		max_iu_len = max(max_iu_len, SRP_IMM_DATA_OFFSET +
-				 srp_max_imm_data);
+	if (use_imm_data) {
+		if (max_it_iu_size == 0) {
+			max_iu_len = max(max_iu_len,
+			   SRP_IMM_DATA_OFFSET + srp_max_imm_data);
+		} else {
+			max_iu_len = max_it_iu_size;
+		}
+	}
+
+	pr_debug("max_iu_len = %d\n", max_iu_len);
 
 	return max_iu_len;
 }
@@ -1389,7 +1397,8 @@ static int srp_rport_reconnect(struct srp_rport *rport)
 	struct srp_target_port *target = rport->lld_data;
 	struct srp_rdma_ch *ch;
 	uint32_t max_iu_len = srp_max_it_iu_len(target->cmd_sg_cnt,
-						srp_use_imm_data);
+						srp_use_imm_data,
+						target->max_it_iu_size);
 	int i, j, ret = 0;
 	bool multich = false;
 
@@ -2538,7 +2547,8 @@ static void srp_cm_rep_handler(struct ib_cm_id *cm_id,
 		ch->req_lim       = be32_to_cpu(lrsp->req_lim_delta);
 		ch->use_imm_data  = lrsp->rsp_flags & SRP_LOGIN_RSP_IMMED_SUPP;
 		ch->max_it_iu_len = srp_max_it_iu_len(target->cmd_sg_cnt,
-						      ch->use_imm_data);
+						      ch->use_imm_data,
+						      target->max_it_iu_size);
 		WARN_ON_ONCE(ch->max_it_iu_len >
 			     be32_to_cpu(lrsp->max_it_iu_len));
 
@@ -3897,7 +3907,9 @@ static ssize_t srp_create_target(struct device *dev,
 	target->mr_per_cmd = mr_per_cmd;
 	target->indirect_size = target->sg_tablesize *
 				sizeof (struct srp_direct_buf);
-	max_iu_len = srp_max_it_iu_len(target->cmd_sg_cnt, srp_use_imm_data);
+	max_iu_len = srp_max_it_iu_len(target->cmd_sg_cnt,
+				       srp_use_imm_data,
+				       target->max_it_iu_size);
 
 	INIT_WORK(&target->tl_err_work, srp_tl_err_work);
 	INIT_WORK(&target->remove_work, srp_remove_work);
-- 
2.21.0

