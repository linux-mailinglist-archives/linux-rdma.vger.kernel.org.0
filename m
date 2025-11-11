Return-Path: <linux-rdma+bounces-14378-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 467E1C4B572
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 04:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCBB3B20FC
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 03:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAE5346E60;
	Tue, 11 Nov 2025 03:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O91AfSNV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98F60B8A;
	Tue, 11 Nov 2025 03:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762832107; cv=none; b=Gi4T+PwMju7CYyIEhebe7ICShVO6p/w8vtvImBQ58uY/T6POsA3bngkHXc2ele0VnJri+pJptqR0YIXibsoQ2Kml0VSJqJ3zDx/nWBsIPGY67Pfhn3uyberCs9byz5yZsi1Bl2vIc7eo3ItaX3T8//bYo+WHFuf52o+zF1HlUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762832107; c=relaxed/simple;
	bh=9zeEptkI8w6bdJjrk6CgIgbcm9k2lrjPlUN+bSaVvPA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z2G9b2BrsPoCTfkkICqgowMlcWgTdh5a02amoog1KQLCKbhMOFGA4tU37IjCIbtSsSHttFWN+ihB7SqYdEYI2KuyXt2/wu1S6fWjCgcbSWY31fhScWHMyAgjmqeuDBZJnZeoyQKYF5R7gAUJ4IxllITx4F7l/vcRW3aRgkh0kTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O91AfSNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CA0C4CEF5;
	Tue, 11 Nov 2025 03:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762832107;
	bh=9zeEptkI8w6bdJjrk6CgIgbcm9k2lrjPlUN+bSaVvPA=;
	h=Date:From:To:Cc:Subject:From;
	b=O91AfSNVaR8bAIXL5Co8ZGbIkrDraCxUHQedhWXV0D/ggthut+IhW3JvUOU9aDmNM
	 A6BuP1tkcXHtDi2NLeLoHoH0G8vBODwWWWt5OFzNgeCyWgiUL8wQ8XjNwk0irTRYgp
	 v6UwtlCvPkGcJ0H56xMirmuGJFnwZ43QHH9V6gW3MFA+4DPsbW/UrbO1h2cw7bGiuL
	 OlJZcks7kxkic9oTYL8whZt2aAsWcPwOCfewV9Ei6ZqTttExI4otvzNHJFUCPuKkQL
	 DP4CsWBJyeITAdB4zV2MNNLSR88OivRo2MzbR/x586Q0OdQZs8KroFenYKq1SD/wTs
	 NOiiVeOonOfHA==
Date: Tue, 11 Nov 2025 12:35:02 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end warnings
Message-ID: <aRKu5lNV04Sq82IG@kspp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
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
2.43.0


