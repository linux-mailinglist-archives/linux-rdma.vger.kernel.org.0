Return-Path: <linux-rdma+bounces-14907-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 802B1CAB48F
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Dec 2025 13:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E60D300A239
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Dec 2025 12:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D356B19049B;
	Sun,  7 Dec 2025 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgZ2zvu3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E78D2C031B
	for <linux-rdma@vger.kernel.org>; Sun,  7 Dec 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765111167; cv=none; b=bmyzZJJghskFihSwfO4uKoyp9HN8H+qqZtP/lC1pUGA9fxPMeUteF49jufiudGpKQu8lwBtRhgyNVqqxT71r4oi0GWdWqoVH3WUbDqk3nJ8nNj8BSwo3J1NrIPuAjBfRY9XGoxOlZ2vZCrcbUgzt+00qVKnmvm8rG4Bvri0LJxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765111167; c=relaxed/simple;
	bh=6bJAp3FtnBT0Hpdk8297wzdwh4zG3qxVQVHhDbz1oig=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mHdB14b2ALL08RbxRavwobySU75de2lWrM3fO9klbI1iI2RVw3uSaqoEHs2pOu/ZiN3JYucxxUeXuNKldPqzvQwgpRMYF7U0LW2n113+3+l5A98jVvg2CfomNUwYQmhaA2XqYYM+/BVEZTVGn0jF+lLfh8l6w39GyGg6oCutXbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EgZ2zvu3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765111165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=EsBQW8HxAVAKrwqsykmMqSqPHf2ZEI/TGurllEoeIZc=;
	b=EgZ2zvu3sx1AOSZapu+Bu/ZIIUITcj8wJQMI52Ut0JeVUmAxY6Bfkn6suE7dm88BIGQ/jL
	7X9ZXQOvzYbD64G33QFHWYEwnJlJU7IgxcVPnlwCTZe6ufpY6xcLaEd3oPhi2OteKFF0my
	AYWV5DXdpWraLmsMUsaNuUtMBh3BtO4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-mgcHMoYVOeuGRxXPF14XEQ-1; Sun,
 07 Dec 2025 07:39:18 -0500
X-MC-Unique: mgcHMoYVOeuGRxXPF14XEQ-1
X-Mimecast-MFC-AGG-ID: mgcHMoYVOeuGRxXPF14XEQ_1765111155
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61B691956053;
	Sun,  7 Dec 2025 12:39:14 +0000 (UTC)
Received: from fedora (unknown [10.44.32.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E641B1953986;
	Sun,  7 Dec 2025 12:39:03 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  7 Dec 2025 13:39:16 +0100 (CET)
Date: Sun, 7 Dec 2025 13:39:04 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
	=?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/7] android/binder: don't abuse current->group_leader
Message-ID: <aTV1aJVZ8B8_n2LE@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTV1KYdcDGvjXHos@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Cleanup and preparation to simplify the next changes.

- Use current->tgid instead of current->group_leader->pid

- Use the value returned by get_task_struct() to initialize proc->tsk

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 drivers/android/binder.c       | 7 +++----
 drivers/android/binder_alloc.c | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index a3a1b5c33ba3..a00f6678f04d 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6044,7 +6044,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	bool existing_pid = false;
 
 	binder_debug(BINDER_DEBUG_OPEN_CLOSE, "%s: %d:%d\n", __func__,
-		     current->group_leader->pid, current->pid);
+		     current->tgid, current->pid);
 
 	proc = kzalloc(sizeof(*proc), GFP_KERNEL);
 	if (proc == NULL)
@@ -6053,8 +6053,8 @@ static int binder_open(struct inode *nodp, struct file *filp)
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
@@ -6073,7 +6073,6 @@ static int binder_open(struct inode *nodp, struct file *filp)
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


