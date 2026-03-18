Return-Path: <linux-rdma+bounces-18356-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDXgD7bYumkycgIAu9opvQ
	(envelope-from <linux-rdma+bounces-18356-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 17:54:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0CE2BFAFC
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 17:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C4D734EA73C
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63AF3FE641;
	Wed, 18 Mar 2026 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gcT5Y+15"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD3F3FE666
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850713; cv=none; b=qoWCqQXMNmCIOaBUxpaLQBU1bEDDp/dHg2iVje7op+S8BTA3HmFpporfgihMvOKou0sUy31kCV0mfzoZJWYqskcAkRzBscK1qZVEpwX2dOgBRUhv41AGYDYYzaUBgLoCYIWkdJ4mlaSnRZBVjXJo5QDqKmeHKyurwvSv6ZH9/XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850713; c=relaxed/simple;
	bh=q/3DhFqpiLUZNYsct3Isv/JOIVBR7VvKNFFG+XC5sww=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bSnUQT3ShbdzCuFcDIcbP6M8hviUWEUzzn9OVz2DjxjVJOKbTdiD0Wo6SoPY1yUh/6hYoGenLEWheRU2tkLyR39E31cy22nbPOLwnnmJXtO4G8wIe+TbY5yL5K2bcbQKbaDBIzdHqlZudI9YETm9f9u88Ml9ihbkf4N0unbTcPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gcT5Y+15; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773850704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YGMkiCcfp3RRHzdYIatDmi18YdY0uccX6gUZLbY8tls=;
	b=gcT5Y+15ftbzqyfgcjejI2a61JQrYqAMs/HgHJb7wQ5qeJqBCUGB4bSL2+GlE3xVV03LAZ
	ioDgufoCvU+57iYGMqN/z/WyM6DFD4/YjB4O/s1k2Hys99lzvupME9tXTOCfbX4xDe2GCy
	Nc/wOTnWNmNS038UMhW6OSLJWD3sSug=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	yanjun.zhu@linux.dev
Subject: [PATCH v2 1/1] RDMA/rxe: Use a dedicated and robust workqueue for RXE tasks
Date: Wed, 18 Mar 2026 09:18:08 -0700
Message-ID: <20260318161808.249835-1-yanjun.zhu@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-18356-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.981];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A0CE2BFAFC
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
V1 -> V2: Remove WQ_MEM_RECLAIM
---
 drivers/infiniband/sw/rxe/rxe_odp.c  | 2 +-
 drivers/infiniband/sw/rxe/rxe_task.c | 7 +++++++
 drivers/infiniband/sw/rxe/rxe_task.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

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
index f522820b950c..59e88d759255 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -254,6 +254,13 @@ void rxe_sched_task(struct rxe_task *task)
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
2.53.0


