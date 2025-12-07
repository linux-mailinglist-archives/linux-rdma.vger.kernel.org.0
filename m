Return-Path: <linux-rdma+bounces-14908-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2A1CAB49E
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Dec 2025 13:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 199B63058A4B
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Dec 2025 12:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16E2ED164;
	Sun,  7 Dec 2025 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkmY0U0F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11FB1F239B
	for <linux-rdma@vger.kernel.org>; Sun,  7 Dec 2025 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765111176; cv=none; b=rMiTxv9Ok+CI8q1IK0YSnS1fShGwHWZlSAhqTwkNhSfiH6mntkok1oIceov5T9Q7UR/rOD+WIY+BZb9EheFr0Tjml0QW66AoQsip80IqWdHW68jCCawRc+uvPwT+H269RBBMNbf8hRZlE3IBk+edMyUb+NX3e8ksOFKjt3hqYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765111176; c=relaxed/simple;
	bh=3aC+u0nuPMsrqkVloCDN63ABR3XLIyUV3vUQuLukUCw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rYmaXW2PFgXzsvhtnSuXbbUpMUgX3Qq6Q4rkykTBpHYEdO/s9bbCp0+EjnIcHZY1thHBiaOl+H49CYKRtJty+QlyqOiWG9MG5exZR6RQnG897lNUnLYJcDzcMpTEfUCfXyk8XXKrkXc3mz+sAPUst2ttUsrKFYHGSrYYRsWvb5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gkmY0U0F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765111173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=FXlhOdfvxpvaaDvBl5X+h/hsx7G14jGyMV7HWDsiG0A=;
	b=gkmY0U0FJ+nZxO4Q5bmC9wuGc6N9Enr6oCjCou6UiR+u1cRhzfyj/XZgW1rIFnUTGWSLKD
	7lzP2Sy5K0oDAiXLpjzuKfUk0OD5OByy6JFEkIcbji9VQv06Q57UG+4e3YvbV7pc4CSIAA
	52IIp2g3biIFmXwn45/1AkDSKF2tKZY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-MnXhMlg-NOGbLn5AUANwSg-1; Sun,
 07 Dec 2025 07:39:29 -0500
X-MC-Unique: MnXhMlg-NOGbLn5AUANwSg-1
X-Mimecast-MFC-AGG-ID: MnXhMlg-NOGbLn5AUANwSg_1765111166
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 543F91956052;
	Sun,  7 Dec 2025 12:39:26 +0000 (UTC)
Received: from fedora (unknown [10.44.32.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7F53119560BD;
	Sun,  7 Dec 2025 12:39:16 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  7 Dec 2025 13:39:28 +0100 (CET)
Date: Sun, 7 Dec 2025 13:39:17 +0100
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
Subject: [PATCH 2/7] android/binder: use same_thread_group(proc->tsk,
 current) in binder_mmap()
Message-ID: <aTV1dc-I5vAw6i0n@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTV1KYdcDGvjXHos@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

With or without this change the checked condition can be falsely true
if proc->tsk execs, but this is fine: binder_alloc_mmap_handler() checks
vma->vm_mm == alloc->mm.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index a00f6678f04d..980bb13228fc 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6013,7 +6013,7 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct binder_proc *proc = filp->private_data;
 
-	if (proc->tsk != current->group_leader)
+	if (!same_thread_group(proc->tsk, current))
 		return -EINVAL;
 
 	binder_debug(BINDER_DEBUG_OPEN_CLOSE,
-- 
2.52.0


