Return-Path: <linux-rdma+bounces-11839-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16313AF5CBD
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 17:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82531C459DF
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B11E2F198A;
	Wed,  2 Jul 2025 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="n6DsOzZ1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484AE2D949F
	for <linux-rdma@vger.kernel.org>; Wed,  2 Jul 2025 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469644; cv=none; b=VONTblDXoY0EbKtpQ3fR2zo8yWllioESmnHCrW0CjOxuUDuAt0zpr2teF1JtCWdd5l4QS7Je0xz9FPWeTZ6Zg+P9E45stuVoUTYnsQ0xoMS7c8bwDmCuuFZtZfggm3EMMLbfMDhuNRhHjCmmcn0tvkJXIPVrXhgGpizXPMNsuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469644; c=relaxed/simple;
	bh=iDI7vlPNxDzCvkBaqmMglBDyQgmN73kgbJEDfVYkjzk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OoFDI0w5GTALkM6UALY1leI/5ZNuQeu3TkNvgl0mo1pZPA8MWhMWr9oivHwZ7Cy91fg4p/Uy7lZToJwe8msbEMDa8EPg3V4RUpoVzJWtbVD4msGMsBWO+z7u4SpGTP240WSM5QHotvPLHjZ4hPQLUMflt1ks8jI6ziPP2F/aml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=n6DsOzZ1; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1751469644; x=1783005644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5sPGyVzfDMa+iVqjCVbwm+BMwKeYb7zlNEH7nGf/2jM=;
  b=n6DsOzZ1vPKCsUYyiUzpJvt6jTSNLUT5Dcg9y9hstzTkxxWziBeD9O6x
   y7cJHlNfzLiKYNd97u0PetqBYrDW2RXpcPhwme4PQfiGzK8v3OFg7aenp
   e4rg6dFS6hRDlFuJg6/smtVNfoK8OIv2Ou6o6SLc+CT6L1YvLJPwp6T/E
   9D5TYavpaOZoLkwL07/yrcABeEPpG9cCfSC6tTPKaj60UqkAuosR3RBO6
   p+gBQejpglkfHbPOHqTfRRLTK50i+RBHdvGH/nin37FE7LQIraZRl6gVT
   L84kkF46arf7r/soetLgnd9+M/zm+0R6PTQm3MZyXR/q5iN54A/mizcpu
   w==;
X-IronPort-AV: E=Sophos;i="6.16,281,1744070400"; 
   d="scan'208";a="760554662"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 15:20:41 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:4820]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.23.90:2525] with esmtp (Farcaster)
 id c7917501-1346-4ff0-8cc5-f7a822fae2d6; Wed, 2 Jul 2025 15:20:39 +0000 (UTC)
X-Farcaster-Flow-ID: c7917501-1346-4ff0-8cc5-f7a822fae2d6
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Jul 2025 15:20:38 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D031EUB003.ant.amazon.com (10.252.61.88) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Wed, 2 Jul 2025
 15:20:36 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Extend admin timeout error print
Date: Wed, 2 Jul 2025 15:20:28 +0000
Message-ID: <20250702152028.2812-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

Add command context index to the printed message for additional debug
information.

Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index bafd210dd43e..f1e88ee89bb8 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2024 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include "efa_com.h"
@@ -557,17 +557,19 @@ static int efa_com_wait_and_process_admin_cq_interrupts(struct efa_comp_ctx *com
 		if (comp_ctx->status == EFA_CMD_COMPLETED)
 			ibdev_err_ratelimited(
 				aq->efa_dev,
-				"The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (ctx: 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
+				"The device sent a completion but the driver didn't receive any MSI-X interrupt for admin cmd %s(%d) status %d (ctx[%d]: 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
 				efa_com_cmd_str(comp_ctx->cmd_opcode),
 				comp_ctx->cmd_opcode, comp_ctx->status,
-				comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
+				comp_ctx - aq->comp_ctx, comp_ctx, aq->sq.pc,
+				aq->sq.cc, aq->cq.cc);
 		else
 			ibdev_err_ratelimited(
 				aq->efa_dev,
-				"The device didn't send any completion for admin cmd %s(%d) status %d (ctx 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
+				"The device didn't send any completion for admin cmd %s(%d) status %d (ctx[%d]: 0x%p, sq producer: %d, sq consumer: %d, cq consumer: %d)\n",
 				efa_com_cmd_str(comp_ctx->cmd_opcode),
 				comp_ctx->cmd_opcode, comp_ctx->status,
-				comp_ctx, aq->sq.pc, aq->sq.cc, aq->cq.cc);
+				comp_ctx - aq->comp_ctx, comp_ctx, aq->sq.pc,
+				aq->sq.cc, aq->cq.cc);
 
 		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
 		err = -ETIME;
-- 
2.47.1


