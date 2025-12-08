Return-Path: <linux-rdma+bounces-14914-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33403CAC705
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Dec 2025 08:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B586030024E3
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Dec 2025 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614082D5410;
	Mon,  8 Dec 2025 07:58:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-m49217.qiye.163.com (mail-m49217.qiye.163.com [45.254.49.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0852D63E2;
	Mon,  8 Dec 2025 07:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765180682; cv=none; b=rGNEaI9QETJVOPNQE8PlPGWAx8VJYSBSBS66A5Vim02syYEQ8j+bFww2tPr1LumZlLM03kcdvgf/ka71GWTwe7H31lIIFDLF82izWgoatpMpxJ9Rdg4XSbULSPqFWu7yIBHC3Q56aEXX2lRrPleS11N3HRa/6prERtn/AtKMyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765180682; c=relaxed/simple;
	bh=UYah9kl/EDUZ719/gAuP83OOG1bcjLgmeFiLD55bCWk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ODcnAkglmGKZdpfWMSDlOjSnmGGwWT92Jkli2o7cCtjZhsHCReWtcrDdlMyisHxWloYan8V95YsyxRzPCVBNnQub75CaqZe0t3v/9ycFk7GTNe4scY0RjXpXxoNpty0yW9G4mACBNkGQZ3eFtVu9HbM9vqeJtwFZMzX9Y2/vibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=45.254.49.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from localhost.localdomain (unknown [113.92.158.29])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2c5f55760;
	Mon, 8 Dec 2025 15:22:23 +0800 (GMT+08:00)
From: Ding Hui <dinghui@sangfor.com.cn>
To: selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	saravanan.vajravel@broadcom.com,
	vasuthevan.maheswaran@broadcom.com
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhengyingying@sangfor.com.cn,
	Ding Hui <dinghui@sangfor.com.cn>
Subject: [RFC PATCH] RDMA/bnxt_re: Fix OOB write in bnxt_re_copy_err_stats()
Date: Mon,  8 Dec 2025 15:21:10 +0800
Message-Id: <20251208072110.28874-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Tid: 0a9afcd70d9609d9kunm07dbb04d2b0cc8a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSk4ZVhgeHRhLGkhCSB9NH1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkhVQklVSk5DVUlCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Recently we encountered an OOB write issue on BCM957414A4142CC with outbox
NetXtreme-E-235.1.160.0 driver from broadcom. After a litte research,
we found the inbox driver from upstream maybe have the same issue.

The commit ef56081d1864 ("RDMA/bnxt_re: RoCE related hardware counters
update") introduced 3 counters, and appended after BNXT_RE_OUT_OF_SEQ_ERR.

However, BNXT_RE_OUT_OF_SEQ_ERR serves as a boundary marker for allocating
hw stats with different num_counters for chip_gen_p5_p7 hardware.

For BNXT_RE_NUM_STD_COUNTERS allocated hw_stats, leading to an
out-of-bounds write in bnxt_re_copy_err_stats().

It seems like that the BNXT_RE_REQ_CQE_ERROR, BNXT_RE_RESP_CQE_ERROR,
and BNXT_RE_RESP_REMOTE_ACCESS_ERRS can be updated for generic hardware,
not only for p5/p7 hardware.

Fix this by moving them before BNXT_RE_OUT_OF_SEQ_ERR so they become
part of the generic counter.

Compile tested only.

Fixes: ef56081d1864 ("RDMA/bnxt_re: RoCE related hardware counters update")
Reported-by: Yingying Zheng <zhengyingying@sangfor.com.cn>
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 drivers/infiniband/hw/bnxt_re/hw_counters.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.h b/drivers/infiniband/hw/bnxt_re/hw_counters.h
index 09d371d442aa..cebec033f4a0 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.h
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.h
@@ -89,6 +89,9 @@ enum bnxt_re_hw_stats {
 	BNXT_RE_RES_SRQ_LOAD_ERR,
 	BNXT_RE_RES_TX_PCI_ERR,
 	BNXT_RE_RES_RX_PCI_ERR,
+	BNXT_RE_REQ_CQE_ERROR,
+	BNXT_RE_RESP_CQE_ERROR,
+	BNXT_RE_RESP_REMOTE_ACCESS_ERRS,
 	BNXT_RE_OUT_OF_SEQ_ERR,
 	BNXT_RE_TX_ATOMIC_REQ,
 	BNXT_RE_TX_READ_REQ,
@@ -110,9 +113,6 @@ enum bnxt_re_hw_stats {
 	BNXT_RE_TX_CNP,
 	BNXT_RE_RX_CNP,
 	BNXT_RE_RX_ECN,
-	BNXT_RE_REQ_CQE_ERROR,
-	BNXT_RE_RESP_CQE_ERROR,
-	BNXT_RE_RESP_REMOTE_ACCESS_ERRS,
 	BNXT_RE_NUM_EXT_COUNTERS
 };
 
-- 
2.17.1


