Return-Path: <linux-rdma+bounces-15137-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D76CD46FF
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 00:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93E6E3002D40
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 23:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D68A27BF7C;
	Sun, 21 Dec 2025 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DvWEwAeI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4048278753
	for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766360090; cv=none; b=Q5kCxpP0hCIzr/DU2U8jBuycMd8bq3D9qUOwNkaowyGmZyVoO4KNW6S5mTyWspuuygQQMdVhRPGgEif0nmwI6FMYbU8xCZ77138GiEEvqlD9nYWJ7U0PnbAjO0cg6La3eh42VNiV5uN9P1M+rSeCPyLrhBBL6uIgfnAvwK506TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766360090; c=relaxed/simple;
	bh=k4DX/UR36CHqzyLx5iYbQ00zVYAd2CAgc1Ko4NDFPXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FhiIV6umBO2y1a2oM1nOKumQqJOzKDmR+U3718MBc6V97uw5HCoSxHAl03km4MyF70ENb0My02vkCBfQat6yA2+oxcsJfFQeTHfxbbybNZJlAlK1O7JJE7eeQxhuV/vHxbrlDt578V1Bs5LjYVZh2UCxSq9qxxryoV8gl/71FTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DvWEwAeI; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766360081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3C/4DM15YdEGrDcaavllTDcDgIcOzX/ljN5Px5rHF9I=;
	b=DvWEwAeIv5ESYFSOWOVn46uibHtD135kupo4HYSC1dum/aWuKtMsADOMu32GGk3wFw+8ZF
	ppsykU7EaE3SEH/pv2iHbf7kHea6JBGemINrKDXMUJvpV/nylbSoUicR7cUWIUnxITyZfN
	Hjmq1t0rsD/mCvXn/6AEZABbdlw1mMM=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH v2 1/2] RDMA/rxe: Avoid -Wflex-array-member-not-at-end warnings
Date: Sun, 21 Dec 2025 18:34:03 -0500
Message-Id: <20251221233404.332108-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the new TRAILING_OVERLAP() helper to fix the following warning:

21 drivers/infiniband/sw/rxe/rxe_verbs.h:271:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM) and a
set of MEMBERS that would otherwise follow it.

This overlays the trailing MEMBER struct ib_sge sge[RXE_MAX_SGE]; onto
the FAM struct rxe_recv_wqe::dma.sge, while keeping the FAM and the
start of MEMBER aligned.

The static_assert() ensures this alignment remains, and it's
intentionally placed inmediately after the related structure --no
blank line in between.

Lastly, move the conflicting declaration struct rxe_resp_info resp;
to the end of the corresponding structure.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
V1->V2: Replace struct rxe_sge with struct ib_sge
---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index fd48075810dd..6498d61e8956 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -219,12 +219,6 @@ struct rxe_resp_info {
 	u32			rkey;
 	u32			length;
 
-	/* SRQ only */
-	struct {
-		struct rxe_recv_wqe	wqe;
-		struct ib_sge		sge[RXE_MAX_SGE];
-	} srq_wqe;
-
 	/* Responder resources. It's a circular list where the oldest
 	 * resource is dropped first.
 	 */
@@ -232,7 +226,15 @@ struct rxe_resp_info {
 	unsigned int		res_head;
 	unsigned int		res_tail;
 	struct resp_res		*res;
+
+	/* SRQ only */
+	/* Must be last as it ends in a flexible-array member. */
+	TRAILING_OVERLAP(struct rxe_recv_wqe, wqe, dma.sge,
+		struct ib_sge		sge[RXE_MAX_SGE];
+	) srq_wqe;
 };
+static_assert(offsetof(struct rxe_resp_info, srq_wqe.wqe.dma.sge) ==
+	      offsetof(struct rxe_resp_info, srq_wqe.sge));
 
 struct rxe_qp {
 	struct ib_qp		ibqp;
@@ -269,7 +271,6 @@ struct rxe_qp {
 
 	struct rxe_req_info	req;
 	struct rxe_comp_info	comp;
-	struct rxe_resp_info	resp;
 
 	atomic_t		ssn;
 	atomic_t		skb_out;
@@ -289,6 +290,9 @@ struct rxe_qp {
 	spinlock_t		state_lock; /* guard requester and completer */
 
 	struct execute_work	cleanup_work;
+
+	/* Must be last as it ends in a flexible-array member. */
+	struct rxe_resp_info	resp;
 };
 
 enum {
-- 
2.39.5


