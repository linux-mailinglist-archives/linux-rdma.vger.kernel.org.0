Return-Path: <linux-rdma+bounces-11879-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 139AEAF7FF6
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 20:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22A91CA3295
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 18:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEE22F237E;
	Thu,  3 Jul 2025 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qP2XxRJv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB7921A449
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567016; cv=none; b=P5VeNhcNEuNQygxu74XETugbEHLC2QgZYF4j3h3pbNXiFHHzEJ0qXbbKHVcoQJ+MkcCF8B/SWbfekW5oATyxUapk9kp98h2dHcEXNvWPrDBl+8Yos5nVlF6UNamETKevP1KNRj2W6qhID7nUuV6DCJpORYRm18WKMnkZcxdlW1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567016; c=relaxed/simple;
	bh=v2NLgfploFN2GCPtt9GGQN4WgGh1JjmA8cpLAniae1w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=msTQAJkUUJiFgkIv087H6c0SUKS3104M/yIBUehpGiI7Q60CchLXq3s4Wb1nwxQ3ARhEaOgRed7lIhbiPb70BgNSZok8W8QWIFcrqxb4Y/Y7+pnSqLWsAknguLG4g3FJyqvnMxSVvNfo82J8CJedXqJoKmOHNj3WvGHUOTi9L0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qP2XxRJv; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1751567015; x=1783103015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pguPPGo7XEcmAwVpM+O56w2lbVDeww1kFZig9m9J+6o=;
  b=qP2XxRJvXjZAc+ptQIOZI7+GgZ66Rz+PMIFjug271zBPfcHGaXmJ9598
   hCR0v6wLaihisLeCSec537egflLoqUlXW5UQIVwqudq0VaZEhK6G83MnD
   Rvu+CC/x9BuQZBbOrPIDaR/+/KPfwMS20vgIe50feTH4fhhEnwHj0NMYZ
   RdVKlMMqhpAfH3Vc3gqBkJABFn3utNK5dI85M6McZXcpmTZwFVULKFKmo
   nhW+7WNRatAWIFklLovO/S0/lPzWjVBd8R/UlcnZF+mgLmb461l1cIMVg
   Kh3gVVhA3Sxv6QcyNh+QigoYyEuON6GQ0W83C2y968YD9lrTWPzGGZtvo
   w==;
X-IronPort-AV: E=Sophos;i="6.16,285,1744070400"; 
   d="scan'208";a="35530124"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 18:23:28 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:38528]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.0.124:2525] with esmtp (Farcaster)
 id 1316a866-6e22-4c6c-95b3-644c04fdfc3b; Thu, 3 Jul 2025 18:23:26 +0000 (UTC)
X-Farcaster-Flow-ID: 1316a866-6e22-4c6c-95b3-644c04fdfc3b
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 3 Jul 2025 18:23:25 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D031EUB003.ant.amazon.com (10.252.61.88) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Thu, 3 Jul 2025
 18:23:23 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next v2] RDMA/efa: Extend admin timeout error print
Date: Thu, 3 Jul 2025 18:23:14 +0000
Message-ID: <20250703182314.16442-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

Add command id to the printed message for additional debug information.

Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index bafd210dd43e..e6377602a9c4 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include "efa_com.h"
@@ -30,6 +30,7 @@ struct efa_comp_ctx {
 	struct efa_admin_acq_entry *user_cqe;
 	u32 comp_size;
 	enum efa_cmd_status status;
+	u16 cmd_id;
 	u8 cmd_opcode;
 	u8 occupied;
 };
@@ -333,6 +334,7 @@ static struct efa_comp_ctx *__efa_com_submit_admin_cmd(struct efa_com_admin_queu
 	comp_ctx->comp_size = comp_size_in_bytes;
 	comp_ctx->user_cqe = comp;
 	comp_ctx->cmd_opcode = cmd->aq_common_descriptor.opcode;
+	comp_ctx->cmd_id = cmd_id;
 
 	reinit_completion(&comp_ctx->wait_event);
 
@@ -557,17 +559,19 @@ static int efa_com_wait_and_process_admin_cq_interrupts(struct efa_comp_ctx *com
 		if (comp_ctx->status == EFA_CMD_COMPLETED)
 			ibdev_err_ratelimited(
 				aq->efa_dev,
-				"The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (ctx: 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
+				"The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (id: %d, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
 				efa_com_cmd_str(comp_ctx->cmd_opcode),
 				comp_ctx->cmd_opcode, comp_ctx->status,
-				comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
+				comp_ctx->cmd_id, aq->sq.pc, aq->sq.cc,
+				aq->cq.cc);
 		else
 			ibdev_err_ratelimited(
 				aq->efa_dev,
-				"The device didn't send any completion for admin cmd %s(%d) status %d (ctx 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
+				"The device didn't send any completion for admin cmd %s(%d) status %d (id: %d, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
 				efa_com_cmd_str(comp_ctx->cmd_opcode),
 				comp_ctx->cmd_opcode, comp_ctx->status,
-				comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
+				comp_ctx->cmd_id, aq->sq.pc, aq->sq.cc,
+				aq->cq.cc);
 
 		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
 		err = -ETIME;
-- 
2.47.1


