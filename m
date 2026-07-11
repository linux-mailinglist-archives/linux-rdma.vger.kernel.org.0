Return-Path: <linux-rdma+bounces-23059-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EzD9NUB1UmpSQAMAu9opvQ
	(envelope-from <linux-rdma+bounces-23059-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 18:54:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCA97424C5
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 18:54:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Mn1iK46k;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23059-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23059-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0E2930151FF
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 16:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7CC3CAE74;
	Sat, 11 Jul 2026 16:54:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8236287247;
	Sat, 11 Jul 2026 16:54:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783788861; cv=none; b=RuURI20h4ahKVi0rQ72tKyK91PwD2+eAwz5MueCkDFwO1NSOXni3SxILZa6o43y5TQwSauUSOiJta8EOhUmfQRZpCfZwxcHfRrK6exJFo63VJkBnJIw2T2EzPy5GnAZQSa///RcNl1m7R4DsfBhllF/OIwst8qgaO5Zj5ildufM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783788861; c=relaxed/simple;
	bh=RPG4mK1iavRNNS/of6gO5cwEu5csBBoQKZmKdSLLxY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=os4yPLu5B07wfEyM4FeA970XVDvP6AfvOrgRBxpIhnJEI/yPeC6AahWrobdXqzOcO40dUHNvQokWu4BIAerCL0rbjehFj5sRrGlRYMRwIlRCT5YEIOm501WdaRyHKeIDNV+pih8oGlejDtbr/vp05j5tXy+cyha/ugnccxbwyAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mn1iK46k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9721F000E9;
	Sat, 11 Jul 2026 16:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783788860;
	bh=6uAeZnUIlVawIsyK/ey6kUbvgIVzicvXV8yWYRQ/FWU=;
	h=From:To:Cc:Subject:Date;
	b=Mn1iK46k19EV89VDyHaEV0oZTKMSvmjxIxuKOaLXJO2dVnZcLXkOq35YLlwtfVmOg
	 NupyE0DdkHONwq4eNStSaj35jKzhJJ+bDikc4CGQLoYpcZGCGHVL2/Y71DShbOffEF
	 6XU4s3b7ar6QOkyuM0M8T/jBNvxiB5QkCjWdVxGmybLBe7NmaKYfU18KtEm6LhXKSO
	 iNRN8CFoDEL7sRDQimmxZqAG5cpMR5JPGdWcGsBE24G9+T9OyUQe4amGLci5NA4cR9
	 eb/3YmEQJhvbZj5H7WrEsmNc3sxjXCau+p4edNnPtQzWRpe9QoAYjesAW92D2QdUdi
	 hX/9H9BfnZqGQ==
From: Allison Henderson <achender@kernel.org>
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Bob Pearson <rpearsonhpe@gmail.com>,
	Ian Ziemba <ian.ziemba@hpe.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Allison Henderson <achender@kernel.org>
Subject: [PATCH for-rc] RDMA/rxe: don't re-execute the current packet after the QP moved to error state
Date: Sat, 11 Jul 2026 09:54:19 -0700
Message-Id: <20260711165419.13486-1-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23059-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,hpe.com,vger.kernel.org,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:rpearsonhpe@gmail.com,m:ian.ziemba@hpe.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:achender@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CCA97424C5

When do_complete() finds the QP in the error state it returns
RESPST_CHK_RESOURCE.  Before commit 49dc9c1f0c7e ("RDMA/rxe: Cleanup
reset state handling in rxe_resp.c") this was the flush loop:
check_resource() had an error-state branch that fetched each remaining
recv WQE and completed it with IB_WC_WR_FLUSH_ERR, without touching
the current packet.  That commit removed the error-state branch from
check_resource() (draining is now done at rxe_receiver() entry) but
kept the do_complete() error-state return.

As a result, when a QP moves to the error state while a packet is
being completed - e.g. an rdma_cm disconnect racing with receive
processing - the responder state machine loops back into the request
processing chain with the already-completed packet still in hand:
check_resource() fetches a fresh recv WQE, execute()/send_data_in()
copies the same packet payload again, do_complete() posts another
IB_WC_SUCCESS CQE (qp->resp.status is still 0), and control returns
to the error-state check.  The loop re-executes the same packet once
per posted recv WQE (observed: ~1000 duplicate IB_WC_SUCCESS
completions of one SEND, one per ~8us, matching the RQ occupancy)
until the RQ is exhausted, after which qp->resp.wqe is NULL and
send_data_in() dereferences it:

  BUG: kernel NULL pointer dereference, address: 0000000000000014
  Workqueue: rxe_wq do_work
  RIP: copy_data+0x29/0x1f0
  Call Trace:
   send_data_in+0x25/0x50
   rxe_receiver+0xf36/0x1dd0

The duplicate completions are indistinguishable from real receives to
the ULP.  During an rds stress test, the message was accepted as new and
delivered the same datagram to user space hundreds of times, corrupting
the stream; any ULP that relies on RC exactly-once delivery is affected.

A live packet reaching the error-state check in do_complete() has
been executed and completed exactly once and must be consumed, not
re-processed.  Return RESPST_CLEANUP for it (dequeue and free); keep
returning RESPST_CHK_RESOURCE for the pkt == NULL case.

Fixes: 49dc9c1f0c7e ("RDMA/rxe: Cleanup reset state handling in rxe_resp.c")
Assisted-by: Claude-Code:claude-fable-5
Signed-off-by: Allison Henderson <achender@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index d8cbdfa70cdbd..02b16e2b49b8f 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1217,7 +1217,14 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	spin_lock_irqsave(&qp->state_lock, flags);
 	if (unlikely(qp_state(qp) == IB_QPS_ERR)) {
 		spin_unlock_irqrestore(&qp->state_lock, flags);
-		return RESPST_CHK_RESOURCE;
+		/* The packet was executed and completed before the QP
+		 * moved to ERROR; it must be consumed exactly once.
+		 * Re-entering the request chain with the stale packet
+		 * would copy it into every remaining recv WQE as a new
+		 * completion.  Remaining WQEs are flushed by the drain
+		 * path at rxe_receiver() entry.
+		 */
+		return pkt ? RESPST_CLEANUP : RESPST_CHK_RESOURCE;
 	}
 	spin_unlock_irqrestore(&qp->state_lock, flags);
 
-- 
2.25.1


