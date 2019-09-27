Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59426C0A89
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2019 19:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfI0RoY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Sep 2019 13:44:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfI0RoY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Sep 2019 13:44:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17DA064120;
        Fri, 27 Sep 2019 17:44:24 +0000 (UTC)
Received: from dhcp-128-227.nay.redhat.com (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 406D55D6A7;
        Fri, 27 Sep 2019 17:44:22 +0000 (UTC)
From:   Honggang LI <honli@redhat.com>
To:     bvanassche@acm.org, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, Honggang Li <honli@redhat.com>
Subject: [patch v5 2/2] RDMA/srp: calculate max_it_iu_size if remote max_it_iu length available
Date:   Sat, 28 Sep 2019 01:43:52 +0800
Message-Id: <20190927174352.7800-2-honli@redhat.com>
In-Reply-To: <20190927174352.7800-1-honli@redhat.com>
References: <20190927174352.7800-1-honli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 27 Sep 2019 17:44:24 +0000 (UTC)
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

The maximum initiator to target iu length can be obtained by sending
MAD packets to query subnet manager port and SRP target ports. We should
calculate the max_it_iu_size instead of the default value, when remote
maximum initiator to target iu length available.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Honggang Li <honli@redhat.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index b829dab0df77..b48088af2ea1 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1362,7 +1362,8 @@ static void srp_terminate_io(struct srp_rport *rport)
 }
 
 /* Calculate maximum initiator to target information unit length. */
-static uint32_t srp_max_it_iu_len(int cmd_sg_cnt, bool use_imm_data)
+static uint32_t srp_max_it_iu_len(int cmd_sg_cnt, bool use_imm_data,
+				  uint32_t max_it_iu_size)
 {
 	uint32_t max_iu_len = sizeof(struct srp_cmd) + SRP_MAX_ADD_CDB_LEN +
 		sizeof(struct srp_indirect_buf) +
@@ -1372,6 +1373,11 @@ static uint32_t srp_max_it_iu_len(int cmd_sg_cnt, bool use_imm_data)
 		max_iu_len = max(max_iu_len, SRP_IMM_DATA_OFFSET +
 				 srp_max_imm_data);
 
+	if (max_it_iu_size)
+		max_iu_len = min(max_iu_len, max_it_iu_size);
+
+	pr_debug("max_iu_len = %d\n", max_iu_len);
+
 	return max_iu_len;
 }
 
@@ -1389,7 +1395,8 @@ static int srp_rport_reconnect(struct srp_rport *rport)
 	struct srp_target_port *target = rport->lld_data;
 	struct srp_rdma_ch *ch;
 	uint32_t max_iu_len = srp_max_it_iu_len(target->cmd_sg_cnt,
-						srp_use_imm_data);
+						srp_use_imm_data,
+						target->max_it_iu_size);
 	int i, j, ret = 0;
 	bool multich = false;
 
@@ -2538,7 +2545,8 @@ static void srp_cm_rep_handler(struct ib_cm_id *cm_id,
 		ch->req_lim       = be32_to_cpu(lrsp->req_lim_delta);
 		ch->use_imm_data  = lrsp->rsp_flags & SRP_LOGIN_RSP_IMMED_SUPP;
 		ch->max_it_iu_len = srp_max_it_iu_len(target->cmd_sg_cnt,
-						      ch->use_imm_data);
+						      ch->use_imm_data,
+						      target->max_it_iu_size);
 		WARN_ON_ONCE(ch->max_it_iu_len >
 			     be32_to_cpu(lrsp->max_it_iu_len));
 
@@ -3897,7 +3905,9 @@ static ssize_t srp_create_target(struct device *dev,
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

