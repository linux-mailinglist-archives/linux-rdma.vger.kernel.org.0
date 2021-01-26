Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1D8303C8F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392326AbhAZMIy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:08:54 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:64013 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392286AbhAZMIp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611662925; x=1643198925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mfFjNndfIUcxgSMI0Iju/vZnTHHijKiunSEBtwINhcU=;
  b=nmzgymTx4EdzusHa7ln2Ach4hv2AoZDTXf2bTjBoD1mL2hMqqzGARhut
   keX0fnmvNqkkeSDD1/nsQy1URucmo4OB7KXduRk4SDI9blxFeVmj2BiMq
   5rr0vBhF1tRq6znIAN7sO48wCo/4C5s2dFVqFF9ml2d1vNIorNXQ/g9L2
   M=;
X-IronPort-AV: E=Sophos;i="5.79,375,1602547200"; 
   d="scan'208";a="114818129"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-42f764a0.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 26 Jan 2021 12:07:58 +0000
Received: from EX13D02EUC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-42f764a0.us-east-1.amazon.com (Postfix) with ESMTPS id DE4E1C1BAF;
        Tue, 26 Jan 2021 12:07:55 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D02EUC001.ant.amazon.com (10.43.164.92) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 26 Jan 2021 12:07:54 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.21) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 26 Jan 2021 12:07:52 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next 1/5] RDMA/efa: Remove redundant NULL pointer check of CQE
Date:   Tue, 26 Jan 2021 14:06:57 +0200
Message-ID: <20210126120702.9807-2-galpress@amazon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126120702.9807-1-galpress@amazon.com>
References: <20210126120702.9807-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A pointer to store the command completion must be provided as it is
always used in efa_com_put_comp_ctx() to return the completion context
back to the pool. Remove the NULL pointer check and the redundant
'status' field stored on the context as it could be retrieved from the
completion itself.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index f7242188a843..747efc794cc0 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include "efa_com.h"
@@ -33,8 +33,6 @@ struct efa_comp_ctx {
 	struct efa_admin_acq_entry *user_cqe;
 	u32 comp_size;
 	enum efa_cmd_status status;
-	/* status from the device */
-	u8 comp_status;
 	u8 cmd_opcode;
 	u8 occupied;
 };
@@ -421,9 +419,7 @@ static void efa_com_handle_single_admin_completion(struct efa_com_admin_queue *a
 	}
 
 	comp_ctx->status = EFA_CMD_COMPLETED;
-	comp_ctx->comp_status = cqe->acq_common_descriptor.status;
-	if (comp_ctx->user_cqe)
-		memcpy(comp_ctx->user_cqe, cqe, comp_ctx->comp_size);
+	memcpy(comp_ctx->user_cqe, cqe, comp_ctx->comp_size);
 
 	if (!test_bit(EFA_AQ_STATE_POLLING_BIT, &aq->state))
 		complete(&comp_ctx->wait_event);
@@ -521,7 +517,7 @@ static int efa_com_wait_and_process_admin_cq_polling(struct efa_comp_ctx *comp_c
 		msleep(aq->poll_interval);
 	}
 
-	err = efa_com_comp_status_to_errno(comp_ctx->comp_status);
+	err = efa_com_comp_status_to_errno(comp_ctx->user_cqe->acq_common_descriptor.status);
 out:
 	efa_com_put_comp_ctx(aq, comp_ctx);
 	return err;
@@ -569,7 +565,7 @@ static int efa_com_wait_and_process_admin_cq_interrupts(struct efa_comp_ctx *com
 		goto out;
 	}
 
-	err = efa_com_comp_status_to_errno(comp_ctx->comp_status);
+	err = efa_com_comp_status_to_errno(comp_ctx->user_cqe->acq_common_descriptor.status);
 out:
 	efa_com_put_comp_ctx(aq, comp_ctx);
 	return err;
@@ -641,8 +637,8 @@ int efa_com_cmd_exec(struct efa_com_admin_queue *aq,
 			aq->efa_dev,
 			"Failed to process command %s (opcode %u) comp_status %d err %d\n",
 			efa_com_cmd_str(cmd->aq_common_descriptor.opcode),
-			cmd->aq_common_descriptor.opcode, comp_ctx->comp_status,
-			err);
+			cmd->aq_common_descriptor.opcode,
+			comp_ctx->user_cqe->acq_common_descriptor.status, err);
 		atomic64_inc(&aq->stats.cmd_err);
 	}
 
-- 
2.30.0

