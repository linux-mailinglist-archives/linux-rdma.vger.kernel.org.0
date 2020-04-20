Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1021B0185
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2020 08:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgDTGWh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Apr 2020 02:22:37 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:28541 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTGWh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Apr 2020 02:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587363757; x=1618899757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0B9NG+CNUjnaeheSwmfoehBAs2azAA5dhSSxwQIxC/s=;
  b=iVM6A3ixF5a42xUF8iCLAwq8+qt8tdiaTQklByxzVTg/4tSLX8lv2iGc
   I3xZb7n6I5szQRa2/OtRyoIZz3v0MGqmEhWKc2knUnyXd5MiNODf6XNUq
   tNafsRN9rnZSRhXF4WLIvZZ7M6wwqvJDvr5WG7m1ccmiWwpgeK0VMREBP
   4=;
IronPort-SDR: 8Fx0j16GQBfC7mf4/5BFy/SpnZdbI1nlJCXbb8lopDhL2OMg51Du18eKB6cPL2vUhKo/ifjhMk
 aWhCo8NU4Nqw==
X-IronPort-AV: E=Sophos;i="5.72,405,1580774400"; 
   d="scan'208";a="29678455"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 20 Apr 2020 06:22:36 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 4C3F2A180B;
        Mon, 20 Apr 2020 06:22:34 +0000 (UTC)
Received: from EX13D19EUB002.ant.amazon.com (10.43.166.78) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Apr 2020 06:22:34 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D19EUB002.ant.amazon.com (10.43.166.78) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Apr 2020 06:22:33 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.212.20) by
 mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 20 Apr 2020 06:22:31 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next 3/3] RDMA/efa: Count admin commands errors
Date:   Mon, 20 Apr 2020 09:22:13 +0300
Message-ID: <20200420062213.44577-4-galpress@amazon.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420062213.44577-1-galpress@amazon.com>
References: <20200420062213.44577-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a new stat that counts admin commands failures, which might help
when debugging different issues.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com.c   | 5 ++++-
 drivers/infiniband/hw/efa/efa_com.h   | 3 ++-
 drivers/infiniband/hw/efa/efa_verbs.c | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 7fce69f5568f..336bc2c57bb1 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -631,17 +631,20 @@ int efa_com_cmd_exec(struct efa_com_admin_queue *aq,
 			cmd->aq_common_descriptor.opcode, PTR_ERR(comp_ctx));
 
 		up(&aq->avail_cmds);
+		atomic64_inc(&aq->stats.cmd_err);
 		return PTR_ERR(comp_ctx);
 	}
 
 	err = efa_com_wait_and_process_admin_cq(comp_ctx, aq);
-	if (err)
+	if (err) {
 		ibdev_err_ratelimited(
 			aq->efa_dev,
 			"Failed to process command %s (opcode %u) comp_status %d err %d\n",
 			efa_com_cmd_str(cmd->aq_common_descriptor.opcode),
 			cmd->aq_common_descriptor.opcode, comp_ctx->comp_status,
 			err);
+		atomic64_inc(&aq->stats.cmd_err);
+	}
 
 	up(&aq->avail_cmds);
 
diff --git a/drivers/infiniband/hw/efa/efa_com.h b/drivers/infiniband/hw/efa/efa_com.h
index c67dd8109d1c..5e4c88877ddb 100644
--- a/drivers/infiniband/hw/efa/efa_com.h
+++ b/drivers/infiniband/hw/efa/efa_com.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_COM_H_
@@ -47,6 +47,7 @@ struct efa_com_admin_sq {
 struct efa_com_stats_admin {
 	atomic64_t submitted_cmd;
 	atomic64_t completed_cmd;
+	atomic64_t cmd_err;
 	atomic64_t no_completion;
 };
 
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 75eef1ec2474..ce7a3ead1ba7 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -37,6 +37,7 @@ struct efa_user_mmap_entry {
 	op(EFA_RX_DROPS, "rx_drops") \
 	op(EFA_SUBMITTED_CMDS, "submitted_cmds") \
 	op(EFA_COMPLETED_CMDS, "completed_cmds") \
+	op(EFA_CMDS_ERR, "cmds_err") \
 	op(EFA_NO_COMPLETION_CMDS, "no_completion_cmds") \
 	op(EFA_KEEP_ALIVE_RCVD, "keep_alive_rcvd") \
 	op(EFA_ALLOC_PD_ERR, "alloc_pd_err") \
@@ -1752,6 +1753,7 @@ int efa_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
 	as = &dev->edev.aq.stats;
 	stats->value[EFA_SUBMITTED_CMDS] = atomic64_read(&as->submitted_cmd);
 	stats->value[EFA_COMPLETED_CMDS] = atomic64_read(&as->completed_cmd);
+	stats->value[EFA_CMDS_ERR] = atomic64_read(&as->cmd_err);
 	stats->value[EFA_NO_COMPLETION_CMDS] = atomic64_read(&as->no_completion);
 
 	s = &dev->stats;
-- 
2.26.1

