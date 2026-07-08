Return-Path: <linux-rdma+bounces-22912-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uxcpICTTTmpVUwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22912-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 00:45:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 359EA72AEE1
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 00:45:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=auditcode.ai header.s=zmail header.b=YhthOYiN;
	dmarc=pass (policy=none) header.from=auditcode.ai;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22912-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22912-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 826A0303A71C
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 22:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2B22DF719;
	Wed,  8 Jul 2026 22:45:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F9233955;
	Wed,  8 Jul 2026 22:45:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783550750; cv=pass; b=hpv7HKy4rtRn+XWOZx85kEWctQqUd6kqtbtqVkC2Px8Hk/qgSQPLWeBZVQLrdbRwz3dIh+jytntYO2wn1L7BYwSzui9mF9Os6KZ2caEuOfLfUyIwvo9n0m6r6mKHY+KE2eogShCip9c++g3VBnmm8k0xSKb+xafd4Dk/GTlwTzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783550750; c=relaxed/simple;
	bh=1BXqvaegiwBMFTNvtId773TO+wCSJGm9zuNVe+aMTN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1Nq4DqySd6/f15apMIG7wVKVOnvLvu3gk2u08wgZSe4w/ZZp+hgYWUKJFN3dZ19YsVXGKOjJ7yA59oXD1OhZuekpU3eZ+0egdnk4ErzNHV4Q2AX5ImqXXVjXQ+l1wb7z81VOJDRP2HNQwR7In1N56nGHV9AV0IhIOru1mzbs7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=YhthOYiN; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1783550739; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=IXzlc5PCLYVWiPk4sCq6Mr2JBMa1FtOgZK3MooaV7prWauQBhqhdhsMN1uJqDOZIB6aPy4lMs5tvXU9GN5RmYiGZDcPwFm5VcBh5ayfgnBPvhSvSqsedS8G01cr0Fk8f4bjPMLZdFrmDPuYsLqDE+bgSxefrJxlJpHLQUvA9cyQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783550739; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A9ZSaY1dOlXF8qW8X5vfZ8p79gCdbkf6XGNk5YfsOvo=; 
	b=FdndDBuDouBWIdPtdPSEKyYf0A8vAy9fTnHBVFbRjlcYKZFlDPqcaihMHkWCSEWp+zU/NLfAO6qK3L3YDlpqfQZzyb2hebT/I9sAhmQZCXEzeqyH0peMm6KCjCIGOSB/mIcAE8Xn3dk/FWt4XQTcUFCl7Ws4jEVCWEv0xn7yBrw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783550739;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=A9ZSaY1dOlXF8qW8X5vfZ8p79gCdbkf6XGNk5YfsOvo=;
	b=YhthOYiNXwgKVEUZH9UgLKDaCf9kXKHblca3nYSk+UQyjAtBaT921cvcGWLCtHFw
	cYTiabOytDOsUM6bFWso0R5vSErMcefAR46MmB9lD4Or6DMzAObmxboVj7+idyic8ZN
	qM1G3V+NvkOsdIw1ymQAlxaVBbPLG2uc+7NzR/ks=
Received: by mx.zoho.eu with SMTPS id 178355073702292.05988634109019;
	Thu, 9 Jul 2026 00:45:37 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/rxe: validate num_sge/cur_sge before indexing wqe->dma.sge[]
Date: Thu,  9 Jul 2026 00:45:34 +0200
Message-ID: <20260708224534.1206-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[auditcode.ai,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[auditcode.ai:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[security@auditcode.ai,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[auditcode.ai:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@auditcode.ai,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22912-lists,linux-rdma=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 359EA72AEE1

A user QP's send queue (qp->sq.queue) is a shared ring the userspace
application writes to directly via mmap (vmalloc_user(), see
rxe_queue.c). For such a QP, rxe_post_send() takes the qp->is_user
branch and only schedules the requester task -- it never validates or
copies the posted WQE:

	drivers/infiniband/sw/rxe/rxe_verbs.c:
		if (qp->is_user) {
			rxe_sched_task(&qp->send_task);
			...
		}

The requester then consumes the WQE in place straight out of that
mmap'd ring:

	rxe_req.c:	wqe = req_next_wqe(qp);
	rxe_req.c:	err = copy_data(qp->pd, 0, &wqe->dma,
					payload_addr(pkt), payload,
					RXE_FROM_MR_OBJ);

copy_data() immediately indexes the per-WQE sge array with the
attacker-controlled cur_sge field, before any bound is checked:

	rxe_mr.c:	struct rxe_sge *sge = &dma->sge[dma->cur_sge];
	rxe_mr.c:	...
	rxe_mr.c:	if (sge->length && (offset < sge->length)) {

dma->sge[] is a flex array whose real backing storage is exactly
qp->sq.max_sge entries per WQE slot (see rxe_qp.c, wqe_size computed
from max_sge at QP create time). Since a user QP's WQE bytes are
entirely attacker-supplied, both wqe->dma.num_sge and wqe->dma.cur_sge
can be set to arbitrary values independent of each other and of
max_sge. Only the *kernel*-QP post path bounds num_sge:

	rxe_verbs.c: validate_send_wr()
		if (num_sge > sq->max_sge) {
			rxe_err_qp(qp, "num_sge > max_sge\n");

but that function is only reachable from rxe_post_one_send() for
kernel-owned QPs; it is never consulted for a user QP's raw WQE.

The sibling receive path already has the equivalent guard, with the
literal comment documenting exactly why it is required:

	rxe_resp.c: get_srq_wqe()
		/* don't trust user space data */
		if (unlikely(wqe->dma.num_sge > srq->rq.max_sge)) {
			...
			rxe_dbg_qp(qp, "invalid num_sge in SRQ entry\n");
			return RESPST_ERR_MALFORMED_WQE;
		}

The send/requester path has no analogous check, so a local,
unprivileged user who can open /dev/infiniband/uverbs* and create a
user QP on a soft-RoCE (rxe) link can hand-craft a WQE in the shared
send queue with an out-of-range wqe->dma.cur_sge (or an oversized
wqe->dma.num_sge) and ring the send doorbell. rxe_requester() then
calls copy_data(), which dereferences &dma->sge[cur_sge] out of the
bounds of the per-WQE sge array -- a vmalloc out-of-bounds *read*
(confirmed via KASAN: "KASAN: vmalloc-out-of-bounds in copy_data"),
reliably panicking the kernel (local DoS). sge->addr itself is still
bounds-checked later by lookup_mr()/rxe_mr_copy(), so the primitive is
an OOB read of sge metadata, not an arbitrary read/write primitive.

Fix this the same way get_srq_wqe() already does for SRQ entries:
bound both fields pulled from the (possibly user-mapped) send queue
entry before they are ever used to index wqe->dma.sge[], right where
the requester fetches the next WQE off the ring in rxe_requester().
num_sge is capped at qp->sq.max_sge (matching the sibling SRQ check
and the kernel-QP validate_send_wr() check), and cur_sge is capped at
qp->sq.max_sge directly, since that is the true per-WQE array capacity
that copy_data() indexes into -- this also covers num_sge == 0 /
cur_sge == 0 local-op and zero-payload WQEs, which remain valid.

This is a long-standing bug in the rxe (soft-RoCE) driver: the
qp->is_user bypass in rxe_post_send() and the unbounded
&dma->sge[dma->cur_sge] indexing in copy_data() have been present
since the driver was introduced.

Runtime-verified on a v6.19 KASAN (CONFIG_KASAN_VMALLOC=y) stand: a
reproducer that posts a user QP send WQE with an out-of-range
cur_sge reliably tripped "KASAN: vmalloc-out-of-bounds in
copy_data" (an out-of-bounds read) before this patch, and no longer
triggers that report with the patch applied.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 drivers/infiniband/sw/rxe/rxe_req.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 12d03f390b09..9fb2c49fb503 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -701,6 +701,22 @@ int rxe_requester(struct rxe_qp *qp)
 	if (unlikely(!wqe))
 		goto exit;
 
+	/*
+	 * Don't trust user space data: qp->sq.queue is a raw ring the
+	 * application writes directly for a user QP, so wqe->dma.num_sge
+	 * and wqe->dma.cur_sge must be bounds-checked the same way
+	 * get_srq_wqe() checks an SRQ entry's num_sge before it is used.
+	 * Otherwise copy_data() indexes wqe->dma.sge[wqe->dma.cur_sge]
+	 * with an unvalidated, attacker-controlled index/count and reads
+	 * out of bounds of the per-wqe sge array.
+	 */
+	if (unlikely(wqe->dma.num_sge > qp->sq.max_sge ||
+		     wqe->dma.cur_sge >= qp->sq.max_sge)) {
+		rxe_dbg_qp(qp, "invalid num_sge/cur_sge in send wqe\n");
+		wqe->status = IB_WC_LOC_QP_OP_ERR;
+		goto err;
+	}
+
 	if (rxe_wqe_is_fenced(qp, wqe)) {
 		qp->req.wait_fence = 1;
 		goto exit;
-- 
2.50.1 (Apple Git-155)


