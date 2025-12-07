Return-Path: <linux-rdma+bounces-14906-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 48981CAB46E
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Dec 2025 13:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABE933006FC7
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Dec 2025 12:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C8E2EC558;
	Sun,  7 Dec 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDJQns4R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233DC27145F
	for <linux-rdma@vger.kernel.org>; Sun,  7 Dec 2025 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765111102; cv=none; b=CFFvjfdjjEttZ4gwcTk04jhO6wi1jce5LL9G8oEVfN2tDBkgx6+oq9WNp6ySJLvjehVRiHHWx3UHZE9mX7Ts4AUFykrMq2/SRuBYJ3RQbVqmWQFgGPXRej8iBV6uGB5pj6d8FWC3XV3F0YPckgYf8wxImGRC/HNF6AJ84hpp2CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765111102; c=relaxed/simple;
	bh=F7zr8Cs75tSdtgrViCUFLoXfov1UXJTsuww8Bn3boPI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=elEjLVoCjyyxHle5cnLDezGJg8FlZ/KzzcZ1MOhYIVyrTwPLM7rR05kJA91lo6Vg7VzOdykTUU9bxaqaySY8h85rpgB9oEY7MLHEzTk2O+RT2EPlvIbk4hqnJf+UT+Z+P1tm/U/rl2cdLw6MHM24ly2wEp8oYV2CWbBjI6wGApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDJQns4R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765111100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=+SUXnBMjMPDW9AevCrJiO1mJpoSaewy40KTaeWq5vxk=;
	b=eDJQns4R0TbYyOZXidP9wPMBTgkiD0E+MISQ70MCfLY0OYykmPksgpvV8erq0oXEoxjREq
	gHE5aKPISrIHOFhJae86RcAGmZHE9v1y0XNvXBQ1eXyBGxxk03dXpfaEgz1NK+xnm2zDy6
	9lcUI8EjWX3UslvVOtsP4MNNng4eql0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-vrxS2WXmOGKs8vXhE9as-g-1; Sun,
 07 Dec 2025 07:38:15 -0500
X-MC-Unique: vrxS2WXmOGKs8vXhE9as-g-1
X-Mimecast-MFC-AGG-ID: vrxS2WXmOGKs8vXhE9as-g_1765111092
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9956D1956088;
	Sun,  7 Dec 2025 12:38:11 +0000 (UTC)
Received: from fedora (unknown [10.44.32.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2C14F1800357;
	Sun,  7 Dec 2025 12:38:00 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  7 Dec 2025 13:38:13 +0100 (CET)
Date: Sun, 7 Dec 2025 13:38:01 +0100
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
Subject: [PATCH 0/7] don't abuse task_struct.group_leader
Message-ID: <aTV1KYdcDGvjXHos@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello.

Untested but hopefully trivial, please review.

The patches do not depend on each other, this series just removes
the usage of ->group_leader when it is "obviously unnecessary".

I am going to move ->group_leader from task_struct to signal_struct
or at least add the new task_group_leader() helper. So I will send
more tree-wide changes on top of this series.

If this series passes the review, can it be routed via mm tree?

Oleg.
---
 drivers/android/binder.c                         |  9 ++++-----
 drivers/android/binder_alloc.c                   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  5 +----
 drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 10 ----------
 drivers/gpu/drm/panfrost/panfrost_gem.c          |  2 +-
 drivers/gpu/drm/panthor/panthor_gem.c            |  2 +-
 drivers/infiniband/core/umem_odp.c               |  4 ++--
 net/core/netclassid_cgroup.c                     |  2 +-
 9 files changed, 12 insertions(+), 26 deletions(-)


