Return-Path: <linux-rdma+bounces-13600-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4561B966D8
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 16:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7877C16D77D
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 14:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39852594B7;
	Tue, 23 Sep 2025 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wdFT+bTw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD55242D6C
	for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638753; cv=none; b=aeaeLxUUEdb4ibLvMWXm+RKxaDjL4BBf57cYp4cX9eMoiwBSnEtxvJrhMfPMyipAUKqYWKl7iNVDfz3AiWH4b2cfpROKZgJpeuNG0lKz4nbFPC+Qs1CmYYmaagINJ9+mnQz3ZecaWQqsHitpBReKKqFWegnzPu9Sub73MeIXla0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638753; c=relaxed/simple;
	bh=7fyHx3MneXd+aO3SjMu+UL280nWvNhHmpk9Vz58j5e8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRISQ4p25wrvIfzMonLIpcS4BheXJj40T3kkP3e5AH+/IF1X1FIw9CHm0UF4jdyNXFGn16SagYGVyi8Ss7izWtqQomv4beTbN77D51DaMGUqfc0mhqzKQrGa5uj7cP5tJdFVlLqihV5RW5/2azfxuxkLPjbP7PlpceLSz40xcm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wdFT+bTw; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758638749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xNF2FzcjUi/HiofcuHnZtU2OQaBdSyiIaRzssn0jnn0=;
	b=wdFT+bTwPPpbJAr8PeDTJWmBjU+7v7S9JLw4icMGr6Q/hjNLKAVJFlZOFITcnVeoc5dLck
	4GAKL9ockC9eksiwso4SQc1hUNWDqeRNeJa1bRt/Skcx9stUDL4J4IgbavPcQ42jG67NcO
	ga6lybIbKIkZ2/HKOo7E3VeWmKLqSzQ=
From: bernard.metzler@linux.dev
To: jgg@ziepe.ca,
	leon@kernel.org,
	metze@samba.org
Cc: linux-rdma@vger.kernel.org,
	Bernard Metzler <bernard.metzler@linux.dev>
Subject: [PATCH] RDMA/siw: Always report immediate post SQ errors
Date: Tue, 23 Sep 2025 16:45:36 +0200
Message-ID: <20250923144536.103825-1-bernard.metzler@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Bernard Metzler <bernard.metzler@linux.dev>

In siw_post_send(), any immediate error encountered during
processing of the work request list must be reported to the
caller, even if previous work requests in that list were just
accepted and added to the send queue.
Not reporting those errors confuses the caller, which would
wait indefinitely for the failing and potentially subsequently
aborted work requests completion.
This fixes a case where immediate errors were overwritten
by subsequent code in siw_post_send().

Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
Suggested-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Bernard Metzler <bernard.metzler@linux.dev>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 35c3bde0d00a..efa2f097b582 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -769,7 +769,7 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 	struct siw_wqe *wqe = tx_wqe(qp);
 
 	unsigned long flags;
-	int rv = 0;
+	int rv = 0, imm_err = 0;
 
 	if (wr && !rdma_is_kernel_res(&qp->base_qp.res)) {
 		siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
@@ -955,9 +955,17 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 	 * Send directly if SQ processing is not in progress.
 	 * Eventual immediate errors (rv < 0) do not affect the involved
 	 * RI resources (Verbs, 8.3.1) and thus do not prevent from SQ
-	 * processing, if new work is already pending. But rv must be passed
-	 * to caller.
+	 * processing, if new work is already pending. But rv and pointer
+	 * to failed work request must be passed to caller.
 	 */
+	if (unlikely(rv < 0)) {
+		/*
+		 * Immediate error
+		 */
+		siw_dbg_qp(qp, "Immediate error %d\n", rv);
+		imm_err = rv;
+		*bad_wr = wr;
+	}
 	if (wqe->wr_status != SIW_WR_IDLE) {
 		spin_unlock_irqrestore(&qp->sq_lock, flags);
 		goto skip_direct_sending;
@@ -982,15 +990,10 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 
 	up_read(&qp->state_lock);
 
-	if (rv >= 0)
-		return 0;
-	/*
-	 * Immediate error
-	 */
-	siw_dbg_qp(qp, "error %d\n", rv);
+	if (unlikely(imm_err))
+		return imm_err;
 
-	*bad_wr = wr;
-	return rv;
+	return (rv >= 0) ? 0 : rv;
 }
 
 /*
-- 
2.50.0


