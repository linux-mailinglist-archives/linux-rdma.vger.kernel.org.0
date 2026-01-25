Return-Path: <linux-rdma+bounces-15991-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOQqM+I/dmm6OAEAu9opvQ
	(envelope-from <linux-rdma+bounces-15991-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 17:08:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A193815B0
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 17:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27B8C300FEDA
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A00D32572E;
	Sun, 25 Jan 2026 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQDJLIyn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C62D32573F
	for <linux-rdma@vger.kernel.org>; Sun, 25 Jan 2026 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769357249; cv=none; b=hAnTPgXqqCtZubCDmMC5YWAXwY2D5gizVuyc3bjV9Aap0UtTQeRYFKOtVwCCtERaekhEvkiMO0djY8XMcO0TtS6y4VWltVrSCkbu+AkC8JO63hinUZMXOYFP/uPP/fXxMOCY1NNf5PPHc3N+VZyEcvSpFv9ursH+b89G0BKlH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769357249; c=relaxed/simple;
	bh=1JQUHjZYL59DmrAabDgnZXBTuRE0Rrr0TT0qVpO3zE4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kdtQwU6+ymBxi0N4bjohq+WRFBSfelmvUkR/UWFg1K6IlFgPweFxc9VCaH8AikTrwAEeqww+g2l1XjvNdas/J7d+L2P4ec5QdsIBul0RXx+pgXSad0Nt+HR2gYzed9FqN1ec9DpRIj7qCgcswIU6tMc4T4Q0lMBiePsXmSySkjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQDJLIyn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769357247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=xB97zLe11SZtUlvoaULtcDCkHx3T3uK2AQMcqJMNJHc=;
	b=SQDJLIynMpLz+l+BSncbZSUN19Bm4RpsQg54BIMUZ2YrJ8alvmnEIuIJJVqsQHp2jvhoub
	tqC0G5Ll0+1hajbaaFAEtqMVAIBs9652gDo2TXWo61Yq+ordhVHfxTVbJ3niV1B8VZdcpH
	zJyCyvw8iZ9UoKZloPjqFutPxXJbncg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-MV5s2csbO0WMU3OsplZ8Kg-1; Sun,
 25 Jan 2026 11:07:22 -0500
X-MC-Unique: MV5s2csbO0WMU3OsplZ8Kg-1
X-Mimecast-MFC-AGG-ID: MV5s2csbO0WMU3OsplZ8Kg_1769357240
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF0C119560B5;
	Sun, 25 Jan 2026 16:07:19 +0000 (UTC)
Received: from fedora (unknown [10.45.224.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 69D1B30001A7;
	Sun, 25 Jan 2026 16:07:13 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 25 Jan 2026 17:07:19 +0100 (CET)
Date: Sun, 25 Jan 2026 17:07:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Steven Price <steven.price@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 1/7] android/binder: don't abuse current->group_leader
Message-ID: <aXY_ryGDwdygl1Tv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXY_h8i78n6yD9JY@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15991-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2A193815B0
X-Rspamd-Action: no action

Cleanup and preparation to simplify the next changes.

- Use current->tgid instead of current->group_leader->pid

- Use the value returned by get_task_struct() to initialize proc->tsk

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder.c       | 7 +++----
 drivers/android/binder_alloc.c | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 535fc881c8da..dea701daabb0 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6046,7 +6046,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	bool existing_pid = false;
 
 	binder_debug(BINDER_DEBUG_OPEN_CLOSE, "%s: %d:%d\n", __func__,
-		     current->group_leader->pid, current->pid);
+		     current->tgid, current->pid);
 
 	proc = kzalloc(sizeof(*proc), GFP_KERNEL);
 	if (proc == NULL)
@@ -6055,8 +6055,8 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	dbitmap_init(&proc->dmap);
 	spin_lock_init(&proc->inner_lock);
 	spin_lock_init(&proc->outer_lock);
-	get_task_struct(current->group_leader);
-	proc->tsk = current->group_leader;
+	proc->tsk = get_task_struct(current->group_leader);
+	proc->pid = current->tgid;
 	proc->cred = get_cred(filp->f_cred);
 	INIT_LIST_HEAD(&proc->todo);
 	init_waitqueue_head(&proc->freeze_wait);
@@ -6075,7 +6075,6 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	binder_alloc_init(&proc->alloc);
 
 	binder_stats_created(BINDER_STAT_PROC);
-	proc->pid = current->group_leader->pid;
 	INIT_LIST_HEAD(&proc->delivered_death);
 	INIT_LIST_HEAD(&proc->delivered_freeze);
 	INIT_LIST_HEAD(&proc->waiting_threads);
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 979c96b74cad..145ed5f14cdb 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1233,7 +1233,7 @@ static struct shrinker *binder_shrinker;
 VISIBLE_IF_KUNIT void __binder_alloc_init(struct binder_alloc *alloc,
 					  struct list_lru *freelist)
 {
-	alloc->pid = current->group_leader->pid;
+	alloc->pid = current->tgid;
 	alloc->mm = current->mm;
 	mmgrab(alloc->mm);
 	mutex_init(&alloc->mutex);
-- 
2.52.0


