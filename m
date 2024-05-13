Return-Path: <linux-rdma+bounces-2444-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE2B8C3B92
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 08:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB77281583
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 06:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1721465AA;
	Mon, 13 May 2024 06:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="My2ueOZr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FD214658B
	for <linux-rdma@vger.kernel.org>; Mon, 13 May 2024 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582810; cv=none; b=Ym55IdpZNzA0uddUImhD9MDMh2zFpVnP0Vl5RKXeH3zl/RzqzpSYmyl2+D2NmPDzfAkFfoA9iD7cTG6EcxKyijS0AbArMtW8089j1VaWznWjutWM4XK+PcUMh1E1V44hwSGBa3V66PE0VrP48DbgySkhmAN7eqwg1Kcc9k95eBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582810; c=relaxed/simple;
	bh=fMEQlO5xyMBQcp0XRkfeT5Mm3s+yUQWrkZ2lfQPRqbE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G9hLgPx0Is0NLoksp7SWTBGGXD7PACno+T00WkxFx4igmgTZBQpp3P2XqIZtNfmF7UOBD7wFgeCkJZ6ga5R6g8rbu9MlGXx3AtmIvDkobzMPDd7X7c4lOwLmx2sogTH1ZCA2DgLhcrtVxYt31RfWYaUCJbcJq/0t4dv9Xfj6Sf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=My2ueOZr; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715582806; x=1747118806;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p5cIZWRdbBjjo1P727wmze5+y3nZ3wSHVOwb8chBlsY=;
  b=My2ueOZrV4pv7D7kiVFcIeTBlGAdHng6M4gzKB/zAi1AnZ8Z1Q92HpYS
   ez9ZYBIqzmFDqvzDddaDjUP+ZT0WTjEV+u/lzo1SvQaC+dKhejW/04jqy
   moUzgh2WuMSeS81ihIAdlZN764/5OXZ2PpEfBlsGWMMh+9TtAJgpRPbSX
   Q=;
X-IronPort-AV: E=Sophos;i="6.08,157,1712620800"; 
   d="scan'208";a="400734037"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 06:46:42 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:52455]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.50:2525] with esmtp (Farcaster)
 id 187280fe-be94-4043-9373-eebf8a38dc5f; Mon, 13 May 2024 06:46:33 +0000 (UTC)
X-Farcaster-Flow-ID: 187280fe-be94-4043-9373-eebf8a38dc5f
Received: from EX19D002EUA004.ant.amazon.com (10.252.50.181) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 06:46:33 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D002EUA004.ant.amazon.com (10.252.50.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 13 May 2024 06:46:32 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Mon, 13 May 2024 06:46:31
 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Firas
 Jahjah" <firasj@amazon.com>, Yehuda Yitschak <yehuday@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Properly handle unexpected AQ completions
Date: Mon, 13 May 2024 06:46:30 +0000
Message-ID: <20240513064630.6247-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Do not try to handle admin command completion if it has an unexpected
command id and print a relevant error message.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Yehuda Yitschak <yehuday@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com.c | 30 ++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 16a24a05fc2a..bafd210dd43e 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include "efa_com.h"
@@ -406,8 +406,8 @@ static struct efa_comp_ctx *efa_com_submit_admin_cmd(struct efa_com_admin_queue
 	return comp_ctx;
 }
 
-static void efa_com_handle_single_admin_completion(struct efa_com_admin_queue *aq,
-						   struct efa_admin_acq_entry *cqe)
+static int efa_com_handle_single_admin_completion(struct efa_com_admin_queue *aq,
+						  struct efa_admin_acq_entry *cqe)
 {
 	struct efa_comp_ctx *comp_ctx;
 	u16 cmd_id;
@@ -416,11 +416,11 @@ static void efa_com_handle_single_admin_completion(struct efa_com_admin_queue *a
 			 EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID);
 
 	comp_ctx = efa_com_get_comp_ctx(aq, cmd_id, false);
-	if (!comp_ctx) {
+	if (comp_ctx->status != EFA_CMD_SUBMITTED) {
 		ibdev_err(aq->efa_dev,
-			  "comp_ctx is NULL. Changing the admin queue running state\n");
-		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
-		return;
+			  "Received completion with unexpected command id[%d], sq producer: %d, sq consumer: %d, cq consumer: %d\n",
+			  cmd_id, aq->sq.pc, aq->sq.cc, aq->cq.cc);
+		return -EINVAL;
 	}
 
 	comp_ctx->status = EFA_CMD_COMPLETED;
@@ -428,14 +428,17 @@ static void efa_com_handle_single_admin_completion(struct efa_com_admin_queue *a
 
 	if (!test_bit(EFA_AQ_STATE_POLLING_BIT, &aq->state))
 		complete(&comp_ctx->wait_event);
+
+	return 0;
 }
 
 static void efa_com_handle_admin_completion(struct efa_com_admin_queue *aq)
 {
 	struct efa_admin_acq_entry *cqe;
 	u16 queue_size_mask;
-	u16 comp_num = 0;
+	u16 comp_cmds = 0;
 	u8 phase;
+	int err;
 	u16 ci;
 
 	queue_size_mask = aq->depth - 1;
@@ -453,10 +456,12 @@ static void efa_com_handle_admin_completion(struct efa_com_admin_queue *aq)
 		 * phase bit was validated
 		 */
 		dma_rmb();
-		efa_com_handle_single_admin_completion(aq, cqe);
+		err = efa_com_handle_single_admin_completion(aq, cqe);
+		if (!err)
+			comp_cmds++;
 
+		aq->cq.cc++;
 		ci++;
-		comp_num++;
 		if (ci == aq->depth) {
 			ci = 0;
 			phase = !phase;
@@ -465,10 +470,9 @@ static void efa_com_handle_admin_completion(struct efa_com_admin_queue *aq)
 		cqe = &aq->cq.entries[ci];
 	}
 
-	aq->cq.cc += comp_num;
 	aq->cq.phase = phase;
-	aq->sq.cc += comp_num;
-	atomic64_add(comp_num, &aq->stats.completed_cmd);
+	aq->sq.cc += comp_cmds;
+	atomic64_add(comp_cmds, &aq->stats.completed_cmd);
 }
 
 static int efa_com_comp_status_to_errno(u8 comp_status)
-- 
2.40.1


