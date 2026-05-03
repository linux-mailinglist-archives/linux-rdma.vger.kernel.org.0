Return-Path: <linux-rdma+bounces-19872-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TFRBJBi29ml0XwIAu9opvQ
	(envelope-from <linux-rdma+bounces-19872-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 04:42:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 533CD4B42A8
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 04:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 381DF3007E18
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 02:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85943392820;
	Sun,  3 May 2026 02:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="jt2eAE+z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound.baidu.com (mx14.baidu.com [220.181.3.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D8733317162
	for <linux-rdma@vger.kernel.org>; Sun,  3 May 2026 02:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777776141; cv=none; b=KXl2DyeXmfy5PTAi/QlfJG3zs5/YKwXP/nIxOj4dciwxc2gifmXErjO3L3W0mc7Sp5DwCQA/64G23g5nOoC7wjpBHo5bImpWrc0RI14rhVNvWVb1I5NmaddPx17tj2U29fGWFCN0IzhJ755fYz7iA1CkkYvjkksNT6gSgUC6F8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777776141; c=relaxed/simple;
	bh=FFOE0IaXTaBm40yZuNtro6DCVpiAMFNj06n97gqNsQM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gX9Ht1qLPi0zU2mXP3zroOt6JxFd0Hec0ToSD0O96sNA0+yvR36Y2h1/FJrIgIq5xQxmoxil0kP2Et+mqyInz4Luex6C2gF5e7WOWWLj4xSE/oqnsJdjsaU61ezIZwuiMBLDxxhTXScjfJvKQP3GFZ36ZEA5tMr6hgAZ9bmX67g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=jt2eAE+z; arc=none smtp.client-ip=220.181.3.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	<linux-rdma@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] IB/mlx5: Reduce spinlock contention by moving free operations outside
Date: Sat, 2 May 2026 22:33:49 -0400
Message-ID: <20260503023349.1959-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc3.internal.baidu.com (172.31.50.47) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1777775638;
	bh=z+vUFwFt5TfIOLEted0dwbcbILfjz01XsAJ2IhpGy0w=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=jt2eAE+zUSXsrfrtYrBEif53jIlaVKUGllabSCp5pP76NjPUeaoS/MKLwsmPf5bXS
	 5RhxXFV5oeiNSSGzrSacFVrfEmXU30sDkIS8Ybu/kMRKzdnfeZ/a5NR2FNot4DpRgX
	 soqddTUfOmitvhIAdELLOsQP8yL7wMLqmHcEk9+U/B37AIjnvGl71mGZg2AOiBgRIr
	 NS5ktzVKCvkdi56exaeN3S6dm6t+A5mLfZHO+JHWlYFYNgo9h9RF6/O8ptT2JnOzrT
	 HBwm1Mo5oXeyhA5EIf8e7pdxXjaQq4XGTtaf+hchqIvHN6g0rW2mmIpwYa8rIsBwUu
	 cvTGc2RKPcobA==
X-Rspamd-Queue-Id: 533CD4B42A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-19872-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[baidu.com:?];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_SPAM(0.00)[0.495];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_DNSFAIL(0.00)[baidu.com : SPF/DKIM temp error,quarantine];
	R_DKIM_TEMPFAIL(0.00)[baidu.com:s=selector1];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]

From: Li RongQing <lirongqing@baidu.com>

The functions kfree() and kvfree() can occasionally trigger a long
chain of calls or face contention in the slab allocator. Executing
these inside a spinlock increases the risk of CPU stalls and increases
lock contention under heavy event load.

Move the memory freeing logic out of the critical sections in devx.c
by using temporary lists and local flags. This narrows the lock's
scope to only protect the list integrity and state transitions.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 645ebcc..a41c065 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2512,7 +2512,7 @@ static int deliver_event(struct devx_event_subscription *event_sub,
 			 const void *data)
 {
 	struct devx_async_event_file *ev_file;
-	struct devx_async_event_data *event_data;
+	struct devx_async_event_data *event_data, *to_free;
 	unsigned long flags;
 
 	ev_file = event_sub->ev_file;
@@ -2543,12 +2543,17 @@ static int deliver_event(struct devx_event_subscription *event_sub,
 	event_data->hdr.cookie = event_sub->cookie;
 	memcpy(event_data->hdr.out_data, data, sizeof(struct mlx5_eqe));
 
+	to_free = NULL;
+
 	spin_lock_irqsave(&ev_file->lock, flags);
 	if (!ev_file->is_destroyed)
 		list_add_tail(&event_data->list, &ev_file->event_list);
 	else
-		kfree(event_data);
+		to_free = event_data;
 	spin_unlock_irqrestore(&ev_file->lock, flags);
+
+	kfree(to_free);
+
 	wake_up_interruptible(&ev_file->poll_wait);
 
 	return 0;
@@ -2942,6 +2947,7 @@ static void devx_async_cmd_event_destroy_uobj(struct ib_uobject *uobj,
 			     uobj);
 	struct devx_async_event_queue *ev_queue = &comp_ev_file->ev_queue;
 	struct devx_async_data *entry, *tmp;
+	LIST_HEAD(tmp_list);
 
 	spin_lock_irq(&ev_queue->lock);
 	ev_queue->is_destroyed = 1;
@@ -2951,12 +2957,15 @@ static void devx_async_cmd_event_destroy_uobj(struct ib_uobject *uobj,
 	mlx5_cmd_cleanup_async_ctx(&comp_ev_file->async_ctx);
 
 	spin_lock_irq(&comp_ev_file->ev_queue.lock);
-	list_for_each_entry_safe(entry, tmp,
-				 &comp_ev_file->ev_queue.event_list, list) {
+	/* Move all entries to a temporary list and free them outside lock */
+	list_splice_init(&comp_ev_file->ev_queue.event_list, &tmp_list);
+	spin_unlock_irq(&comp_ev_file->ev_queue.lock);
+
+	/* Free memory outside of critical section */
+	list_for_each_entry_safe(entry, tmp, &tmp_list, list) {
 		list_del(&entry->list);
 		kvfree(entry);
 	}
-	spin_unlock_irq(&comp_ev_file->ev_queue.lock);
 };
 
 static void devx_async_event_destroy_uobj(struct ib_uobject *uobj,
@@ -2966,7 +2975,9 @@ static void devx_async_event_destroy_uobj(struct ib_uobject *uobj,
 		container_of(uobj, struct devx_async_event_file,
 			     uobj);
 	struct devx_event_subscription *event_sub, *event_sub_tmp;
+	struct devx_async_event_data *entry, *tmp;
 	struct mlx5_ib_dev *dev = ev_file->dev;
+	LIST_HEAD(tmp_list);
 
 	spin_lock_irq(&ev_file->lock);
 	ev_file->is_destroyed = 1;
@@ -2980,18 +2991,19 @@ static void devx_async_event_destroy_uobj(struct ib_uobject *uobj,
 			list_del_init(&event_sub->event_list);
 
 	} else {
-		struct devx_async_event_data *entry, *tmp;
-
-		list_for_each_entry_safe(entry, tmp, &ev_file->event_list,
-					 list) {
-			list_del(&entry->list);
-			kfree(entry);
-		}
+		/* Move all entries to a temporary list */
+		list_splice_init(&ev_file->event_list, &tmp_list);
 	}
 
 	spin_unlock_irq(&ev_file->lock);
 	wake_up_interruptible(&ev_file->poll_wait);
 
+	/* Free event data outside of critical section */
+	list_for_each_entry_safe(entry, tmp, &tmp_list, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+
 	mutex_lock(&dev->devx_event_table.event_xa_lock);
 	/* delete the subscriptions which are related to this FD */
 	list_for_each_entry_safe(event_sub, event_sub_tmp,
-- 
2.9.4


