Return-Path: <linux-rdma+bounces-22913-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bgoOBDzTTmpiUwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22913-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 00:46:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAF872AEEF
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 00:46:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=auditcode.ai header.s=zmail header.b=CvhVL2bG;
	dmarc=pass (policy=none) header.from=auditcode.ai;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22913-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22913-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32342303B7FB
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 22:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4092A2E7631;
	Wed,  8 Jul 2026 22:46:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169FC27A907;
	Wed,  8 Jul 2026 22:46:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783550767; cv=pass; b=iFq9HvUG/B7/lRapzTL4eoB5TXZ5ZGX2I+5EKuU3fYEPUiCJaEOb+IqEHa4DNUKH2hOGu8ko5E7q0K16CdpFkSAzxIRyBOOmDx6xoIatUtfwPCO56D2qJHaZGBgeuhR4Ssg6jgBF+nNsoVI7tnNi0/ReWPGW1ZY5cLamIo602jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783550767; c=relaxed/simple;
	bh=f7hTj5Z6gRvSa0KtpoX7/eRvO2RceLcXei9E5wV8n3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ahr9xFVU5uhKoZ1gB0lcX5uJgxSqiXvcT7rnuKUJcyuEfo3nNa6042wj616HAXEH12aWTwmFmys3MbVJwY9EouydyEDksmoV+2gsT+d3FW2W9hC8RAfEEHowsfnZgySxMltgfEDImT1WphT2iCZqnUpG9FNKrMjavOt0D63/4sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=CvhVL2bG; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1783550756; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=EntOqNFnDL0j9g0Q8/LcCZsE3AMe4Cy55gFdZAX1IVbouzqN13rYpOpMiXXIdMBeJ+105gOIb09pXHxKY76YHZ99vRXYd3giKKI4eNTRLwcrOOVmS8iLCcr3RLaZsjJXswZC5KkJKGvEbHzyXRZkyazussOqS8bXIrYsXkRXMHc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783550756; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BLuv8CvIQiEDopySExwjFH41Ldb+fBdbqFUmbwvT514=; 
	b=CLiE+9E34LBmq1RwvJrzKuP9Tz1bS0W3miCi2K1ZRUmX7ik06SvMgM1FPlkt8kp+OVGSBAoek/2dZXNBIgqjNMtPc0hujpYY77fJzXKmp+YQRJn9flVOVFMItaf3hn6Lp2VeVp5hGddeHkOcjq3MH10jJ8EZ5rrEkabJEDH1Mc8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783550756;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=BLuv8CvIQiEDopySExwjFH41Ldb+fBdbqFUmbwvT514=;
	b=CvhVL2bGy4TIMKeHHBqcGdUfbOHUaWZhhBBomigDD4Db8bo5o6kov7vLUrFK+5wu
	Q0yJigXsQ3cutfSy7gv9+8iy+NPyC+22OGaNicBvh54rLdy7FpMHVd1xQFyX0rqlTRc
	ye3ZlPC2oZA30lfRH7NjW4aUrzS97/cY1P4JrwTY=
Received: by mx.zoho.eu with SMTPS id 1783550753234656.5754088413917;
	Thu, 9 Jul 2026 00:45:53 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/rxe: fix responder UAF on IB_QP_MAX_DEST_RD_ATOMIC modify_qp
Date: Thu,  9 Jul 2026 00:45:50 +0200
Message-ID: <20260708224550.1281-1-security@auditcode.ai>
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
	TAGGED_FROM(0.00)[bounces-22913-lists,linux-rdma=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFAF872AEEF

rxe_qp_from_attr()'s IB_QP_MAX_DEST_RD_ATOMIC branch frees and
reallocates qp->resp.resources[] (the rd_atomic resource array used by
the responder to track in-flight RDMA READ/ATOMIC/FLUSH requests)
completely outside of the IB_QP_STATE handling above it. Unlike every
other place that tears this array down -- rxe_qp_reset(), reached only
under IB_QP_STATE, always calls rxe_disable_task(&qp->recv_task) /
rxe_disable_task(&qp->send_task) to drain the responder and requester
tasks before touching per-QP state, then re-enables them -- this branch
runs with the responder task (rxe_receiver(), scheduled as recv_task on
the rxe_wq workqueue) fully live and unlocked. A userspace modify_qp()
that sets only IB_QP_MAX_DEST_RD_ATOMIC (no state change, so
__qp_chk_state()/ib_modify_qp_is_ok() never runs and qp->state_lock is
never taken here) can therefore race the responder in two ways:

 1. free_rd_atomic_resources() calls kfree(qp->resp.resources) and
    alloc_rd_atomic_resources() kzalloc_objs()'s a new array while
    rxe_prepare_res()/find_resource() in rxe_resp.c are concurrently
    walking &qp->resp.resources[i] with no lock held -- a straight
    free-vs-read race on the array itself.

 2. free_rd_atomic_resources() only NULLs qp->resp.resources; it never
    clears qp->resp.res, the raw pointer *into* that array that
    rxe_resp.c caches across a multi-packet RDMA READ/ATOMIC/FLUSH
    reply (set at rxe_resp.c read/atomic/flush-reply sites, cleared
    only on the normal completion paths). If a modify_qp() races a
    resource still referenced by qp->resp.res, the array is freed out
    from under the cached pointer and the next reply packet dereferences
    it -- independent of the kfree/kzalloc_objs() window in (1).

Reproduced with KASAN: a single process driving one RC QP pair in rxe
loopback, one thread pumping large multi-packet IBV_WR_RDMA_READs
against qpB while a second thread hammers
ibv_modify_qp(qpB, IB_QP_MAX_DEST_RD_ATOMIC), reliably (~11s) produces

  BUG: KASAN: slab-use-after-free in rxe_receiver+0x4f78/0x89e0 [rdma_rxe]
  Workqueue: rxe_wq do_work [rdma_rxe]

with the freed kmalloc-1k object being the rd_atomic resource array
freed by the modify_qp() thread while the recv_task kworker reads it.
An identical run modifying only IB_QP_MIN_RNR_TIMER (no resource free)
is clean.

Fix both races the same way rxe_qp_reset() already handles tearing down
this exact array: quiesce the responder task around the free/realloc by
calling rxe_disable_task(&qp->recv_task) before free_rd_atomic_resources()
and rxe_enable_task(&qp->recv_task) after alloc_rd_atomic_resources(),
so rxe_receiver() cannot observe the array mid-free/mid-realloc. And
close the still-open window for (2) at the source: have
free_rd_atomic_resources() clear qp->resp.res along with
qp->resp.resources, exactly like the existing completion paths in
rxe_resp.c (check_rkey()/duplicate_request()/RESPST_CLEANUP) already do
when a resource's lifetime ends, so a drained-and-resumed responder
restarts at RESPST_CHK_PSN against the fresh array instead of replaying
a stale reference into the old one.

Only qp->recv_task is drained: qp->resp.resources / qp->resp.res are
touched exclusively by the responder (rxe_resp.c); the requester
(send_task / rxe_sender()) never reads them, so there is no need to
widen this beyond what rxe_qp_reset() would drain for the equivalent
state.

Verified on the same v6.19 KASAN stand: with this fix applied, the
identical differential reproducer drives sustained MAX_DEST_RD_ATOMIC
storms against qpB well past the ~11s pre-fix time-to-first-splat with
zero KASAN reports, versus reliably tripping the slab-use-after-free in
rxe_receiver() described above before the fix.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index f3dff1aea96a..646957707765 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -172,6 +172,7 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
 		}
 		kfree(qp->resp.resources);
 		qp->resp.resources = NULL;
+		qp->resp.res = NULL;
 	}
 }
 
@@ -709,9 +710,15 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 
 		qp->attr.max_dest_rd_atomic = max_dest_rd_atomic;
 
+		/*
+		 * Not gated by IB_QP_STATE above: quiesce the responder task
+		 * the same way rxe_qp_reset() does before touching this
+		 * array, so rxe_receiver() can't race the free/realloc.
+		 */
+		rxe_disable_task(&qp->recv_task);
 		free_rd_atomic_resources(qp);
-
 		err = alloc_rd_atomic_resources(qp, max_dest_rd_atomic);
+		rxe_enable_task(&qp->recv_task);
 		if (err)
 			return err;
 	}
-- 
2.50.1 (Apple Git-155)


