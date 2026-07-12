Return-Path: <linux-rdma+bounces-23077-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ol6lMvWGU2p7bgMAu9opvQ
	(envelope-from <linux-rdma+bounces-23077-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 14:22:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3747449F5
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 14:22:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=auditcode.ai header.s=zmail header.b=imAvRM8o;
	dmarc=pass (policy=none) header.from=auditcode.ai;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23077-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23077-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9671300D175
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 12:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BC43A7F7E;
	Sun, 12 Jul 2026 12:22:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A43AA9CA;
	Sun, 12 Jul 2026 12:22:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783858927; cv=pass; b=D2pkT+BQq3OoqhuWJIwhVK+Fwc8s+iJBFr+8FMxgFyTYTXeJE1GlPKTwF765XLN9OpEzuKtEphP4ZbVBBPYF+wAn4dSD1xDeIW4P++DO4gkTmXQMp/aop4bejtTY2BAwEKWLOfHzV8J4BRvpD5w390gOtkBRFLRmez/vf89uUvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783858927; c=relaxed/simple;
	bh=t6tQHsqws6xa4fMtVf6HCdaDC+vv7nmcKjRxRtC4p38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0L4ZdYd5Vskn9/bujCl32o18QnLUL/bevRu66TbtQmeTgIYfJLZxJPBkke6mJS4QYTRILv3DvA39dFpZ2g7GO8hrq0tlPfMq0EtSMBtXPJE4RkFQ9Y692mmfA+zrYpR6yfEIKjTkca/42p4gIAwLeztoGF6Yn5rmBjuItxzMNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=imAvRM8o; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1783858914; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=eTp7owvI6JOhRL219Iuclm/YWVQDg+Iei+Nd7M84+n0h1AG2HdEHghvbW57zARQHkr1Mo215l/7o0MtM+9x0Fiark/JZcFD81NHuPOjWHM58IgOrP3gNVw9b5JJueF7gQ4YCrTnnm+YrfoaHW7m0c+XZjoihyFx+Dp01er7smdg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783858914; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OKvwEhWsKuNbp5fDca1ITiaM7pUXWpNEFSHsDwKFfR0=; 
	b=NUNn2UwIIa9CwhOJm8d0BvsX9gEWv4xyMeTv6jmRbetJT2cjQkMkXIFeh0O4dDEl45DsQ52ygcHatADINobL+U4qpuqtuxdkYQ21uwdmAINnRNCvtgkACwn49c3ub/MT0iDHZizwlkwLj++8RpViR3vIdPjBZTpf3RDnTUfyRdk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783858914;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OKvwEhWsKuNbp5fDca1ITiaM7pUXWpNEFSHsDwKFfR0=;
	b=imAvRM8obVKT48COGaqeKr0IEK6BpqctNWfurHankPU2jEqOdBxPAJVC9xoG/Mmt
	SAIb/IQl5RTkaXMsZFKLT4xXghsNUaSP5UzD4+I2155NG6lPpxIk0+UKwehSibGFQWU
	er3eUzOn3hDIhyAzqMki0a4jTUbt1u8T2+dNptXo=
Received: by mx.zoho.eu with SMTPS id 1783858911707645.6397057912544;
	Sun, 12 Jul 2026 14:21:51 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: yanjun.zhu@linux.dev,
	zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] RDMA/rxe: validate num_sge/cur_sge before indexing wqe->dma.sge[]
Date: Sun, 12 Jul 2026 14:21:49 +0200
Message-ID: <20260712122149.78142-1-security@auditcode.ai>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[auditcode.ai,none];
	R_DKIM_ALLOW(-0.20)[auditcode.ai:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23077-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,ziepe.ca,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[security@auditcode.ai,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[auditcode.ai:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,auditcode.ai:from_mime,auditcode.ai:email,auditcode.ai:mid,auditcode.ai:dkim,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E3747449F5

For a user QP, qp->sq.queue is a ring the application writes directly,
so rxe_post_send() takes the is_user branch and only schedules send_task
without validating the WQE. rxe_requester() consumes it in place via
req_next_wqe() and calls copy_data(), which indexes
&wqe->dma.sge[cur_sge] with the attacker-controlled num_sge/cur_sge.
Only the kernel path bounds num_sge (validate_send_wr()); the user WQE
is never checked, so a local unprivileged user can post a WQE with an
out-of-range cur_sge or oversized num_sge and force an out-of-bounds
read of the per-WQE sge array in copy_data() (vmalloc OOB read, local
DoS).

Bound num_sge to qp->sq.max_sge in rxe_requester() before use, the way
get_srq_wqe() already guards SRQ entries, and bound cur_sge only when
the WQE carries payload (dma.resid): copy_data() returns early on a
zero-length copy before touching dma->sge[], so a zero-payload WQE --
the only kind a max_sge == 0 QP can post -- stays valid.

Reproduced under KASAN; the vmalloc-out-of-bounds in copy_data() is gone.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
v3: rewrite the commit message to describe the rxe_post_send() -> rxe_requester() -> copy_data() call flow directly and terse per Leon's review; resend as a standalone patch (not in-reply-to the previous series). No code change from v2; carries Zhu Yanjun's Reviewed-by.
 drivers/infiniband/sw/rxe/rxe_req.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 12d03f390b09..24f5c044363f 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -701,6 +701,21 @@ int rxe_requester(struct rxe_qp *qp)
 	if (unlikely(!wqe))
 		goto exit;
 
+	/*
+	 * Don't trust user space data: a user QP's WQE comes from an mmap'd
+	 * ring, so num_sge/cur_sge are attacker-controlled. Bound num_sge like
+	 * get_srq_wqe(); bound cur_sge only when payload exists (dma.resid),
+	 * since copy_data() skips dma->sge[] on a zero-length copy (all a
+	 * max_sge == 0 QP can post).
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


