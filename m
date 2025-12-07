Return-Path: <linux-rdma+bounces-14912-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96370CAB4C2
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Dec 2025 13:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7851D3007D88
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Dec 2025 12:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE552F0C63;
	Sun,  7 Dec 2025 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALhBBNJz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B47083C
	for <linux-rdma@vger.kernel.org>; Sun,  7 Dec 2025 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765111226; cv=none; b=mfTJzpvbIubsr3/GgfRmS8KPU93+8WfsMlC9W+nDsnQV0SetIaqOdIweLlK1x9fV6LNQFr8YGueVoTN6wsYhDkR+zCKiOJkTdFwxL64q7KPnvgKtgmO78tNWpgVV2x2Lk9Fqslw8cKgoEGAIoU9iktMmcJLf+h4dUVdtgOCnNlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765111226; c=relaxed/simple;
	bh=vfs6N9sDwumAAjFelXXmUF2gA0S98gkOcwdpB5QXLUc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iRRpIM7oqUM3H/ZwZf4lqc+pZ8riY9MXByp8Bs1OYPrloDjXgyUBIFSPL1Ts9uNaAvW238+fq5bfKBqIemLR9V/KatYdlqL5CPd3LoT+OPMwYSUCC3VF8vTsbNq2+LiBYGs5kh0TBHTuXT9LcMLl1ausNVRK8sdqOLgdjx3heCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALhBBNJz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765111222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=/HKvmdPqRZHJ9/v9r83b5lWZWkfSL/6IdXrUhiE9JhQ=;
	b=ALhBBNJz+HUdIJUmaWhVGG+FuWjR9Q9506/yLTH4qWkeR38nNXo/vGF7cFMOf6TwOoH3LR
	sgDWMpgralPpsA0TBawx+5FdbEHcWhAbSz0862y532PlR+Z3DlDOw5utxinSc7+LBRutXr
	rD0Zd6RtvbXcu/8CHCxqioYGlSeB9bM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-lKGezg7JN4ahQWbzy3fjVQ-1; Sun,
 07 Dec 2025 07:40:18 -0500
X-MC-Unique: lKGezg7JN4ahQWbzy3fjVQ-1
X-Mimecast-MFC-AGG-ID: lKGezg7JN4ahQWbzy3fjVQ_1765111214
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98FA018002EC;
	Sun,  7 Dec 2025 12:40:14 +0000 (UTC)
Received: from fedora (unknown [10.44.32.50])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 852F6180044F;
	Sun,  7 Dec 2025 12:40:04 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  7 Dec 2025 13:40:16 +0100 (CET)
Date: Sun, 7 Dec 2025 13:40:05 +0100
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
Subject: [PATCH 6/7] RDMA/umem: don't abuse current->group_leader
Message-ID: <aTV1pbftBkH8n4kh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTV1KYdcDGvjXHos@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Cleanup and preparation to simplify the next changes.

Use current->tgid instead of current->group_leader->pid.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 drivers/infiniband/core/umem_odp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 572a91a62a7b..32267258a19c 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -149,7 +149,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_device *device,
 	umem->owning_mm = current->mm;
 	umem_odp->page_shift = PAGE_SHIFT;
 
-	umem_odp->tgid = get_task_pid(current->group_leader, PIDTYPE_PID);
+	umem_odp->tgid = get_task_pid(current, PIDTYPE_TGID);
 	ib_init_umem_implicit_odp(umem_odp);
 	return umem_odp;
 }
@@ -258,7 +258,7 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_device *device,
 		umem_odp->page_shift = HPAGE_SHIFT;
 #endif
 
-	umem_odp->tgid = get_task_pid(current->group_leader, PIDTYPE_PID);
+	umem_odp->tgid = get_task_pid(current, PIDTYPE_TGID);
 	ret = ib_init_umem_odp(umem_odp, ops);
 	if (ret)
 		goto err_put_pid;
-- 
2.52.0


