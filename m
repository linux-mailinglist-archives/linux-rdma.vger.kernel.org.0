Return-Path: <linux-rdma+bounces-14952-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9078CB2F8F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 14:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B4003023FBF
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Dec 2025 13:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51F6322C60;
	Wed, 10 Dec 2025 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="K2PAEtWH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.156.205.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB990322C7F
	for <linux-rdma@vger.kernel.org>; Wed, 10 Dec 2025 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.156.205.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765372027; cv=none; b=TTpg+oxpqhppwXxR+vwNdS4uXSkhOvH37qy79LP/yveM/IXQswGkOmhAC5HKlM+L+9kLUPMkOKII2fvr/ei3vIWeceWKh/NMlh6Z8fEaq407BlK2C9fd5My4bwxiUf1WLt6doIuyDpuL1XjuvNeYEUW0BcBwhj+aQvjTXbAf6M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765372027; c=relaxed/simple;
	bh=R4qWu9AVpRJjtzASbIoylUQmtkP4lie3Jdd3k23vEkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4r86pjyWkRZnUGMSqC0hkKbYgcvWvYv5WPzYCroH2q8alVEVWyMo8IKdNlLV4/OF1afakqf0v3zytLIIbnX9e6zgjEahI6Sq+CBTXW3DJe9ZH7QJAQECqVqRPezVVqa30/lfxawTOmS/sutRtJnLve+GAKAOdBtTEg+i8FDd0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=K2PAEtWH; arc=none smtp.client-ip=18.156.205.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765372026; x=1796908026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aQN9WqM8nDkAb4p3udr5ikCV0/mVpnMowK6VgCsKyyE=;
  b=K2PAEtWHC8DR0zcThGxNUkTwZlTw7ovbbIjS0wixf9PCC+HTPFP1aDeT
   3LyX50g4UcXrJ6VvYxVoajOMskWKlHYlwbLFCIoUFjIDp69BW8KtWUTdf
   USuxfo98bGIyFUz/il7qqYUUPt0VHeIygR7PCx0Cvsp+8OoWMxsyZD/vw
   5BMu0fSgMoYF4q2ZUuDa0HgdmPP8zB+iywNIvVEPQin3xSzTlFSiqsX7J
   s88b5cTeWReK4nvU1mfH+1NjKUkvww5PG4u5s1mFJCqlvfnAEdskBZxKg
   qkCJhJedCoQmDyeDL7mhz7Hxtlc09SSv2PB3H1Bs9S0oHR6zFtZruQo8K
   Q==;
X-CSE-ConnectionGUID: fEKX9rbVQ1affVEkPA8BhA==
X-CSE-MsgGUID: qJX9DI5YQmqfKjHk/Ab1Rg==
X-IronPort-AV: E=Sophos;i="6.20,264,1758585600"; 
   d="scan'208";a="6195816"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 13:06:46 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:12003]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.23.73:2525] with esmtp (Farcaster)
 id 8f5a9749-7bdd-4054-8697-a00957e7c8a2; Wed, 10 Dec 2025 13:06:46 +0000 (UTC)
X-Farcaster-Flow-ID: 8f5a9749-7bdd-4054-8697-a00957e7c8a2
Received: from EX19D011EUB004.ant.amazon.com (10.252.51.93) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 10 Dec 2025 13:06:39 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D011EUB004.ant.amazon.com (10.252.51.93) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Wed, 10 Dec 2025
 13:06:35 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>, "Daniel
 Kranzdorf" <dkkranzd@amazon.com>
Subject: [PATCH 1/2] RDMA/efa: Check stored completion CTX command ID with received one
Date: Wed, 10 Dec 2025 13:06:13 +0000
Message-ID: <20251210130614.36460-2-ynachum@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251210130614.36460-1-ynachum@amazon.com>
References: <20251210130614.36460-1-ynachum@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D011EUB004.ant.amazon.com (10.252.51.93)

In admin command completion, we receive a CQE with the command ID which
is constructed from context index and entropy bits from the admin queue
producer counter. To try to detect memory corruptions in the received
CQE, validate the full command ID of the fetched context with the CQE
command ID. If there is a mismatch, complete the CQE with error.
Also use LSBs of the admin queue producer counter to better detect
entropy mismatch between smaller number of commands.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 drivers/infiniband/hw/efa/efa_com.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 0e979ca10d24..b31478f3a121 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -3,6 +3,8 @@
  * Copyright 2018-2025 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
+#include <linux/log2.h>
+
 #include "efa_com.h"
 #include "efa_regs_defs.h"
 
@@ -317,7 +319,7 @@ static struct efa_comp_ctx *__efa_com_submit_admin_cmd(struct efa_com_admin_queu
 
 	/* cmd_id LSBs are the ctx_id and MSBs are entropy bits from pc */
 	cmd_id = ctx_id & queue_size_mask;
-	cmd_id |= aq->sq.pc & ~queue_size_mask;
+	cmd_id |= aq->sq.pc << ilog2(aq->depth);
 	cmd_id &= EFA_ADMIN_AQ_COMMON_DESC_COMMAND_ID_MASK;
 
 	cmd->aq_common_descriptor.command_id = cmd_id;
@@ -418,7 +420,7 @@ static int efa_com_handle_single_admin_completion(struct efa_com_admin_queue *aq
 			 EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID);
 
 	comp_ctx = efa_com_get_comp_ctx(aq, cmd_id, false);
-	if (comp_ctx->status != EFA_CMD_SUBMITTED) {
+	if (comp_ctx->status != EFA_CMD_SUBMITTED || comp_ctx->cmd_id != cmd_id) {
 		ibdev_err(aq->efa_dev,
 			  "Received completion with unexpected command id[%d], sq producer: %d, sq consumer: %d, cq consumer: %d\n",
 			  cmd_id, aq->sq.pc, aq->sq.cc, aq->cq.cc);
-- 
2.47.3


