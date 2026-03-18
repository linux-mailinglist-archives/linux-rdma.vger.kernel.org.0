Return-Path: <linux-rdma+bounces-18287-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM3rFbkUumlORQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18287-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 03:58:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FDE2B5642
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 03:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AE4D305DBB4
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 02:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43CD256C6C;
	Wed, 18 Mar 2026 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cWiL6vsc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F701E487
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 02:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773802678; cv=none; b=LSiMN762PZoSS4bSqNKDsMqhRCvvPDSHHkiKhgO6pQ0r8JXIwZBsyKLg/XqcCkoguC6FLN4P3dVRaIa1f+TR/lKjfj91sW+fFa+CWrYCh/hgH8CF6GghTstlczaqBDnKft/Ze1MjZ6CCMJQY/4Bcz6adJS3BPyOhC/1KSWOGoGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773802678; c=relaxed/simple;
	bh=8GHeTGXyV6TPZbBFI3/QSs/Zq9Y5O30tpnnikAMviu4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=euJYrWZTwIf2gJWWOKNDv6+ZxsldM4YNd10qbZKn3Qm9Vq9L3rbsICyb3PibouiAoVTejDjYQtucb7i/3aAn7mColwTEZUswTTtbi0ds9fsvBiTNaYoIs6EX/gc/hAGSLIUstufjfKTcb0GWKe2YLlpY5A1htQyJEiYXFdLneTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cWiL6vsc; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773802674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7NVBgIMm7IedhjWWQTmax1oa3uryaE9i5gsj+U0u3OE=;
	b=cWiL6vsce5R7HN4ZeTZVkA+us6hGb+Qeg4SbTk1wrpAy4jshDAjB26eCCwhfQVydmhaTuE
	OdALYJusfIFm5n+qkbfWKGEyOk9dOjQ4aXQBF9SKpR+FFWiRCZiu6U9vjjXPOLyRc3Ku2u
	hCOrQbH7w67FQtz9EUM0YX9uLqAQwtQ=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	yanjun.zhu@linux.dev
Subject: [PATCH 1/1] RDMA/rxe: Use a dedicated and robust workqueue for RXE tasks
Date: Wed, 18 Mar 2026 03:57:39 +0100
Message-ID: <20260318025739.5058-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18287-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org,linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85FDE2B5642
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, the RXE driver uses the system-wide 'system_unbound_wq' for
auxiliary tasks like ODP prefetching. This can lead to interference
from other system services and lacks guaranteed forward progress
under memory pressure.

Currently make all the tasks queue into the driver-specific 'rxe_wq'.

Suggested-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_odp.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_task.c | 10 +++++++++-
 drivers/infiniband/sw/rxe/rxe_task.h |  1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index bc11b1ec59ac..98092dcc1870 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -545,7 +545,7 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
 		work->frags[i].mr = mr;
 	}
 
-	queue_work(system_unbound_wq, &work->work);
+	rxe_queue_work(&work->work);
 
 	return 0;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index f522820b950c..4385137eb4d7 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -10,7 +10,8 @@ static struct workqueue_struct *rxe_wq;
 
 int rxe_alloc_wq(void)
 {
-	rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
+	rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND | WQ_MEM_RECLAIM,
+				WQ_MAX_ACTIVE);
 	if (!rxe_wq)
 		return -ENOMEM;
 
@@ -254,6 +255,13 @@ void rxe_sched_task(struct rxe_task *task)
 	spin_unlock_irqrestore(&task->lock, flags);
 }
 
+/* Helper to queue auxiliary tasks into rxe_wq.
+ */
+void rxe_queue_work(struct work_struct *work)
+{
+	queue_work(rxe_wq, work);
+}
+
 /* rxe_disable/enable_task are only called from
  * rxe_modify_qp in process context. Task is moved
  * to the drained state by do_task.
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index a8c9a77b6027..60c085cc11a7 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -36,6 +36,7 @@ int rxe_alloc_wq(void);
 
 void rxe_destroy_wq(void);
 
+void rxe_queue_work(struct work_struct *work);
 /*
  * init rxe_task structure
  *	qp  => parameter to pass to func
-- 
2.43.0


