Return-Path: <linux-rdma+bounces-22926-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3J6nNm1NT2rGdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22926-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 09:27:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A6572DAED
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 09:27:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=auditcode.ai header.s=zmail header.b=GSvt0m0p;
	dmarc=pass (policy=none) header.from=auditcode.ai;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22926-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22926-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35DC43025492
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B727A3CB2DC;
	Thu,  9 Jul 2026 07:27:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E33CB911;
	Thu,  9 Jul 2026 07:27:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582031; cv=pass; b=K7GUQHVQ7ZeycBdj7Shv0b7cPFGRPfTTykkvCXxGC1kJtzFDxtDB2lzuf7yWUuHaIbkHn+KagIt7fVlo3I6/scnnjmUBgicPbF83uqM8XCUkawg9As2jMvqq+ilGTru7kG6KZAgZbiQLQSlx0hBnTRD8jbNwCgp2IB1P+YP7e0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582031; c=relaxed/simple;
	bh=2VOZ1Q8y/ld42IHfECDvgAv3CXosyg8FYfrklNHRoFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzCuST5S4u2x5m0sHT5afTqGm73mjh+6KdxvR91E5i5RbpqWgqqMLBVpXrd/0sEFC2Q1QpaPf4M2d746JX9UKGx2fTxP7P7zzemKLH+2Q+KZ1ws+ZV2+kM9TRS6QDRSBYXXaoqcIZFJjmoad1o+mAcXriS74erNTBuNDFjh6xwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=GSvt0m0p; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1783582020; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=e7FoGYGNK+9V3G703i9kktpYiQj5LzOBQHhcG5sZbTls3dgVJQ/hHf7JEG3XLFnPXM1IPPAHAaCD7ins4InBy5wPOAAnJfx+j7vcdJIbX73eHq0hyWzd6fWWHF4Qy3l0XJcSWB8XsF+u6Yl1Wb+I0KiAjEXMXJtYfZtPcdwUhe8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783582020; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1RdpyygBue2iLcmMr8lORAPhAaCxeQESuFVtpwaibxI=; 
	b=QwXVJ08y7SSJ7ty+G8Tq511ss78TsHcx4vPuAd67PZgNhKOEqWl++9rGfmg6mXgML10Hi6Y32i+bNDum3K5qpXrOvDTJ4fZolvC1ddrEQTOPg1Yp5oU7P9NMIumi6YdTZQ46loECzUfz2Bz3zTgY02cnjpNxKuxuzWnGZE1hccM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783582020;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1RdpyygBue2iLcmMr8lORAPhAaCxeQESuFVtpwaibxI=;
	b=GSvt0m0pfZoI3DD43Ev6WEx5/+RRtn4HtyuYLSYfzBy6WRmxtvwdRpUKLrYRkw0P
	w83RQV2auPY9uorsAvuFIa7fFYWTzjvsvFE/EyJW+1NC+MNtqS3BQGM1YrnLuBWL9SI
	gcCj32Lv6y4niVPZ/m+kVuRw/91PuUbPd7I0hJxY=
Received: by mx.zoho.eu with SMTPS id 1783582018762841.0455827055187;
	Thu, 9 Jul 2026 09:26:58 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: yanjun.zhu@linux.dev,
	zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] RDMA/rxe: validate num_sge/cur_sge before indexing wqe->dma.sge[]
Date: Thu,  9 Jul 2026 09:26:56 +0200
Message-ID: <20260709072656.9074-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708224534.1206-1-security@auditcode.ai>
References: <20260708224534.1206-1-security@auditcode.ai>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[auditcode.ai,none];
	R_DKIM_ALLOW(-0.20)[auditcode.ai:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22926-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,ziepe.ca,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[security@auditcode.ai,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[auditcode.ai:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@auditcode.ai,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68A6572DAED

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

copy_data() indexes the per-WQE sge array with the attacker-controlled
cur_sge field and dereferences it (once there is payload to copy):

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
bound the fields pulled from the (possibly user-mapped) send queue
entry before they are used to index wqe->dma.sge[], right where the
requester fetches the next WQE off the ring in rxe_requester(). num_sge
is capped at qp->sq.max_sge (matching the sibling SRQ check and the
kernel-QP validate_send_wr() check). cur_sge is bounded only when the
WQE actually carries payload (wqe->dma.resid): copy_data() dereferences
dma->sge[cur_sge] only after its own length == 0 early return, so a
zero-payload WQE never touches the sge array and must not be rejected
-- notably that is the only kind of WQE a max_sge == 0 QP can post
(qp->sq.max_sge is itself derived from user-supplied max_send_sge /
max_inline_data and may be 0). Gating on resid rather than num_sge is
deliberate: payload is wqe->dma.resid, which is independent of num_sge,
so a WQE with num_sge == 0 but a large resid and an out-of-range
cur_sge would still reach the sge dereference.

This is a long-standing bug in the rxe (soft-RoCE) driver: the
qp->is_user bypass in rxe_post_send() and the unbounded
&dma->sge[dma->cur_sge] indexing in copy_data() have been present
since the driver was introduced.

Runtime-verified on a v6.19 KASAN (CONFIG_KASAN_VMALLOC=y) stand: a
reproducer that posts a user QP send WQE with an out-of-range cur_sge
reliably tripped "KASAN: vmalloc-out-of-bounds in copy_data" (an
out-of-bounds read) before this patch, and no longer triggers that
report with the patch applied.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
v2: address Zhu Yanjun's review of v1
    (https://lore.kernel.org/linux-rdma/20260708224534.1206-1-security@auditcode.ai/):
    qp->sq.max_sge can legitimately be 0, and v1's unconditional
    "cur_sge >= max_sge" check then wrongly rejected a valid zero-payload
    WQE. Gate the cur_sge bound on wqe->dma.resid instead (copy_data()
    dereferences dma->sge[] only when there is payload), so zero-payload
    WQEs -- the only kind a max_sge == 0 QP can post -- are accepted while
    the out-of-range cur_sge OOB is still rejected. Commit message fixed.

 drivers/infiniband/sw/rxe/rxe_req.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 12d03f390b09..363c56a1edbb 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -701,6 +701,28 @@ int rxe_requester(struct rxe_qp *qp)
 	if (unlikely(!wqe))
 		goto exit;
 
+	/*
+	 * Don't trust user space data: for a user QP, qp->sq.queue is a
+	 * raw ring the application writes directly, so this WQE's num_sge
+	 * and cur_sge are attacker-controlled. copy_data() dereferences
+	 * dma->sge[cur_sge] without bounding the initial cur_sge against
+	 * the per-WQE sge array, whose capacity is qp->sq.max_sge (the
+	 * loop there only bounds subsequent increments, against num_sge).
+	 * Bound num_sge to that capacity, the way get_srq_wqe() and
+	 * validate_send_wr() already do, and bound cur_sge only when the
+	 * WQE actually carries payload (dma.resid): copy_data() returns
+	 * early on a zero-length copy before it ever touches dma->sge[],
+	 * so a zero-payload WQE -- the only valid WQE on a max_sge == 0
+	 * QP -- must not be rejected here.
+	 */
+	if (unlikely(wqe->dma.num_sge > qp->sq.max_sge ||
+		     (wqe->dma.resid &&
+		      wqe->dma.cur_sge >= qp->sq.max_sge))) {
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


