Return-Path: <linux-rdma+bounces-22925-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q0bUELhNT2rddwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22925-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 09:28:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DABE172DB24
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 09:28:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=auditcode.ai header.s=zmail header.b=R0CwPgLL;
	dmarc=pass (policy=none) header.from=auditcode.ai;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22925-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22925-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE7B43065BFC
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 07:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CB73C9ED6;
	Thu,  9 Jul 2026 07:27:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4B1B7910;
	Thu,  9 Jul 2026 07:27:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582027; cv=pass; b=b3ab4sYvlpLgt9+EXdr26QicOXw+C0sCYHgVmyoWmAcJaIt1oHygjlowF8JdCHzl4ZEZ2IpjuX0+h1QCmBKcZY6J3jpCY7Zzy15RBnKBvIwlNeDCMoNGyWhVechHkKANfAhFwJlqBLMAHjGzoH+LROM7Zhq8nxz17ReKbezDnqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582027; c=relaxed/simple;
	bh=At2fRYQ89R/VEPqOutyv6KBQ7UlhYGN71Gj3tBf2glk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoNgxjCM+CtkUQ9XnjZV7aDHMKQiX0BR2znq7mYK9qNErAattSvXq/z3mTQplGye251i8ojx9JbizLqn3ZDG4HoWNT7UYguypU/AiZDUIU9IrP7Gth/F4UgPaqFbHuQDx+AxjxmKVbo9/MenIUG3bG752CSf0VIybbaJu/uVQbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=R0CwPgLL; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal: i=1; a=rsa-sha256; t=1783582015; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=JNIo0v0Bgm1K37gnuH/8H2eeUwHPyLzgYaNS+Fmh7ywE9lJO1F0Q9+7qSrowslA4J1Tgmf52feY5Ccq7AHXGrRBv4Ed//D1kbvwxyZtcG6B3t4fa5QXrQzQ0a/EdAKGPgqu3K8rLs6X7UpDzAqnu4X9KwTuHbwJj+Wb8UazPLLI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783582015; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cGdYyHdF4eooldaXFoLH1BUNBeRF8jbgPm0566Cjifs=; 
	b=JpdBl6swA6KQwD1GztQnNyTqUN2aEcMfS2ObbLTqjYMDTIiS/zh4zfzgfy1kAJ5favuJltb/60Lf79EAnyjvlN3pdGpdeTVjZteUElLzE2g9LyteJaFlL8xmqFtF1yeQh5ZsP4LXpHZuZVWBR7UWN6W+1kB/GYZc4/dgzBms4nE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783582015;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cGdYyHdF4eooldaXFoLH1BUNBeRF8jbgPm0566Cjifs=;
	b=R0CwPgLLsq86BNm0GQjH3KkZLY5M6TxNAotPWRqkuJZuVr2k//CI582sNfJ3qsSh
	BE6zO/oLIc5e6QVQjpzhE1/BEA+gZe+3b2IT2HQSP3//MRhyy5THlxS2riwmwdE8IVl
	jZUHnINJszqQ37SEc9GmtqNqtkFA7iPGHIc25My0=
Received: by mx.zoho.eu with SMTPS id 1783582013693679.3330432379032;
	Thu, 9 Jul 2026 09:26:53 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: yanjun.zhu@linux.dev,
	zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] RDMA/rxe: fix responder UAF on IB_QP_MAX_DEST_RD_ATOMIC modify_qp
Date: Thu,  9 Jul 2026 09:26:51 +0200
Message-ID: <20260709072651.9040-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708224550.1281-1-security@auditcode.ai>
References: <20260708224550.1281-1-security@auditcode.ai>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22925-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,ziepe.ca,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[security@auditcode.ai,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[auditcode.ai:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[auditcode.ai:from_mime,auditcode.ai:email,auditcode.ai:mid,auditcode.ai:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DABE172DB24

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
and rxe_enable_task(&qp->recv_task) only after alloc_rd_atomic_resources()
has succeeded, so rxe_receiver() cannot observe the array mid-free/
mid-realloc. On the alloc-failure path the responder is deliberately
left quiesced: qp->resp.resources is NULL at that point and
rxe_prepare_res()/find_resource() would dereference it, so recv_task
must not be re-enabled until a fresh array has been installed. And
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
v2: address Zhu Yanjun's review of v1
    (https://lore.kernel.org/linux-rdma/20260708224550.1281-1-security@auditcode.ai/):
    only re-enable recv_task after alloc_rd_atomic_resources() succeeds, so
    the responder is not resumed against a NULL qp->resp.resources on the
    ENOMEM path (rxe_prepare_res()/find_resource() would dereference it).
    No change to the successful path; fix description updated accordingly.

 drivers/infiniband/sw/rxe/rxe_qp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index f3dff1aea96a..e39fb144cbbb 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -172,6 +172,7 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
 		}
 		kfree(qp->resp.resources);
 		qp->resp.resources = NULL;
+		qp->resp.res = NULL;
 	}
 }
 
@@ -709,11 +710,24 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 
 		qp->attr.max_dest_rd_atomic = max_dest_rd_atomic;
 
+		/*
+		 * This branch is not gated by IB_QP_STATE, so the responder
+		 * task is live here. Quiesce it the way rxe_qp_reset() does
+		 * before swapping the rd_atomic resource array, so
+		 * rxe_receiver() cannot race the free/realloc.
+		 */
+		rxe_disable_task(&qp->recv_task);
 		free_rd_atomic_resources(qp);
-
 		err = alloc_rd_atomic_resources(qp, max_dest_rd_atomic);
+		/*
+		 * On failure the responder stays quiesced: qp->resp.resources
+		 * is NULL now, and rxe_prepare_res()/find_resource() would
+		 * dereference it, so do not re-enable recv_task until a fresh
+		 * array has been installed.
+		 */
 		if (err)
 			return err;
+		rxe_enable_task(&qp->recv_task);
 	}
 
 	if (mask & IB_QP_EN_SQD_ASYNC_NOTIFY)
-- 
2.50.1 (Apple Git-155)


