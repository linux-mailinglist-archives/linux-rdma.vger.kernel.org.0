Return-Path: <linux-rdma+bounces-14911-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E92BCAB4AD
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Dec 2025 13:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31C0C301784B
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Dec 2025 12:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875D32EFDB4;
	Sun,  7 Dec 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKkoz22W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C2F2D12EC
	for <linux-rdma@vger.kernel.org>; Sun,  7 Dec 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765111212; cv=none; b=X/DFuHtGQKHbKI7yxpTEJ0fNo9ytmLprtUw634IWHdncGxbwqtyKHgwGY7i0WN9GqxD2C3eBmIehvOYyNzToU70CufdF0s6Ta+Zt5oKVwrLbQPnYQRzAEAraj8IcKbkWQ8Q+1x5o6XDqaU7mAqR5lzqsx+wQqTmZCCVGLaVrVpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765111212; c=relaxed/simple;
	bh=YTH3r3peosgWPKyoUacL9XewNPCT/1k4nAgk7xQQ9XY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Yao2sjD5dm4vLbNA3fbcyvDGUtep3T5R+9VvfXIPcINzp3BxgZ6yGuW9VyxNd4+sXmXyH3Fr53xzo8awhoXNA1md4jJDpnKQktwtSID1Eb+XmdvvUaAEHVq6d0HN4uYHajQwCLlIPVqP2ctikc73AzIHFYWGbi0+VR27DSjVDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKkoz22W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765111208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=qm2SST2ROvbrb0g6IbjuLKtf6ZL8lExfalWyhBUzXok=;
	b=dKkoz22WC5aEvuYek6pHMN7vnMIHILLnD5Q52kat1gJso3UiH9kauu7egyYDUTbP6jHD1V
	il8o9C8UrChDQYvkPeFvAELALnP+ReSTlsxLL/SNJfy7BWpUU61mX3D6ukqqMFkCB3ohy1
	zy7RALSV1cS0321ZXTpmx7zs9ZeF0CY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-PbT8magNPuOajFBJKgpfeA-1; Sun,
 07 Dec 2025 07:40:06 -0500
X-MC-Unique: PbT8magNPuOajFBJKgpfeA-1
X-Mimecast-MFC-AGG-ID: PbT8magNPuOajFBJKgpfeA_1765111202
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D9241956095;
	Sun,  7 Dec 2025 12:40:02 +0000 (UTC)
Received: from fedora (unknown [10.44.32.50])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8A21F3011A86;
	Sun,  7 Dec 2025 12:39:52 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  7 Dec 2025 13:40:04 +0100 (CET)
Date: Sun, 7 Dec 2025 13:39:53 +0100
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
Subject: [PATCH 5/7] drm/pan*: don't abuse current->group_leader
Message-ID: <aTV1maDfDvqgu1oT@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTV1KYdcDGvjXHos@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Cleanup and preparation to simplify the next changes.

Use current->tgid instead of current->group_leader->pid.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 2 +-
 drivers/gpu/drm/panthor/panthor_gem.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 8041b65c6609..1ff1f2c8b726 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -17,7 +17,7 @@
 static void panfrost_gem_debugfs_bo_add(struct panfrost_device *pfdev,
 					struct panfrost_gem_object *bo)
 {
-	bo->debugfs.creator.tgid = current->group_leader->pid;
+	bo->debugfs.creator.tgid = current->tgid;
 	get_task_comm(bo->debugfs.creator.process_name, current->group_leader);
 
 	mutex_lock(&pfdev->debugfs.gems_lock);
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index fbde78db270a..29cc57efc4b9 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -27,7 +27,7 @@ static void panthor_gem_debugfs_bo_add(struct panthor_gem_object *bo)
 	struct panthor_device *ptdev = container_of(bo->base.base.dev,
 						    struct panthor_device, base);
 
-	bo->debugfs.creator.tgid = current->group_leader->pid;
+	bo->debugfs.creator.tgid = current->tgid;
 	get_task_comm(bo->debugfs.creator.process_name, current->group_leader);
 
 	mutex_lock(&ptdev->gems.lock);
-- 
2.52.0


