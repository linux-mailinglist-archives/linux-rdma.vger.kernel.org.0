Return-Path: <linux-rdma+bounces-15169-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D9ECD810E
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 05:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E688D3075C15
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 04:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6492E62AC;
	Tue, 23 Dec 2025 04:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OhTKFi8t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B8E2E7621
	for <linux-rdma@vger.kernel.org>; Tue, 23 Dec 2025 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766464942; cv=none; b=i6yYJ46BZOHtfd5/maU79ZjUKLZqgdXIb6UfytbT5Hvc56KjdWVvW34g32HXus+l/ls7XIQX+rWCxrCb6ax4lhlJ2HVkkubcmlyP3V/qQlFVfwW/oltZ0f3kl+UM5gpOXpEvOmXbzJHkwics2gYQ/5v/I2wN60DC5k6HabfQzlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766464942; c=relaxed/simple;
	bh=5OrutWyQ4GJ47KYUidPFQG7Tk44Gkgw9O+NSI2QmWuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZHJqeU6fL00HxbD/3A7rN0R6kJTzRbFpiJlJFGd5vqOWRirtS8iFlQToO3IAb+SruqE4yyXLVujrB7Jhfd2mfaMdRInTLazSlEJvuNHD20cQsYKR8UMOL54C3YUMpPig4dK3Bk3v+aX0YvQVQagxjilrN1CiIuDXO8HaoMNCYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OhTKFi8t; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766464938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nFthc9CHrZ5Y0LBu95uJirfebLtW2A/ghS+MKel5wj8=;
	b=OhTKFi8tKHW5AC0s7ePwfmTzQ7GBU7Kpipxr3b71lRofQ9Pe6uKUFMyaEBcwxU6amreNbq
	htvs1sOv7zj+233G2DHEbyytrMhUg/dwjkOowbJlfJEZn3hZuisH0iptiOzLqiybi3TyYC
	LRZDx1fzPSTpNyZe4HYBM5Kwq+Qreh8=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH v3 1/1] RDMA/rxe: Avoid -Wflex-array-member-not-at-end warnings
Date: Mon, 22 Dec 2025 23:41:29 -0500
Message-Id: <20251223044129.6232-1-yanjun.zhu@linux.dev>
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
V2->V3: Replace struct ib_sge with struct rxe_sge
---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index fd48075810dd..3ffd7be8e7b1 100644
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
+		struct rxe_sge		sge[RXE_MAX_SGE];
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


