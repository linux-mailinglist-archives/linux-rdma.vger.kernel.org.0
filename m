Return-Path: <linux-rdma+bounces-14910-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 047B3CAB4A1
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Dec 2025 13:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F24C4300D331
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Dec 2025 12:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BEF2EDD41;
	Sun,  7 Dec 2025 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYNlsIBY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022E32D12EC
	for <linux-rdma@vger.kernel.org>; Sun,  7 Dec 2025 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765111200; cv=none; b=q/U63d0PqJOoUaZUg+BkzU4J7aLhHa/kn8NEUEE4p4gYsj+iEHOpfo51CiOZrhyLqpfLx6OxrZRC/yc24VaNgpwWlonXWZa2SmmYCTc4Ttp0jnauRTF+zI+HBIDpAVYU+ONV8XVHQqJtr1c3BZAfBEPH1O6GZjiN3KTDNL5a7Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765111200; c=relaxed/simple;
	bh=Ytz+SZqOIW+Xy5xzf61tHStbY6EtoqoLzDhjnRsCsAk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WdY5vJtiuCL9xPXW6ij4CqTOLpG252rZvCjdJ68IYIhQizfR2L3fq1FE0OF4tbGgo7HbxKIyJxhhNrHMGS4aoSLE7VqWxjwI6n8Gf4VoFj8F+J6DVCwT8ebmWkPo9Va1aEkctYZ5NeWYPzTIsYOnDLjaJIJ/gBoPwk2Jyy3VMwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYNlsIBY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765111197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=rgXA81QLeZ8uxrq5YssERSuP8GaYN0hU+8W5qT5Vtak=;
	b=UYNlsIBYjXcXIwgqrXFYL+A6Mv7Uub2pgbZFfngr3SKJ+sSA4RLqktLbFh75/RZY3WRRf1
	Kkz12Qa+OLf4SkguKCY2IwrBCtqv2vxhUY0OVhhf9iKyp878ohm1Cd4fDBG5tdKk4/3UnA
	UoOZKWEw18Qwf3yOMPt1ulCkfGez0j4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-PXj43SbAMtaj8nAdWGYIEA-1; Sun,
 07 Dec 2025 07:39:54 -0500
X-MC-Unique: PXj43SbAMtaj8nAdWGYIEA-1
X-Mimecast-MFC-AGG-ID: PXj43SbAMtaj8nAdWGYIEA_1765111191
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8766018002C0;
	Sun,  7 Dec 2025 12:39:50 +0000 (UTC)
Received: from fedora (unknown [10.44.32.50])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 76BD5180044F;
	Sun,  7 Dec 2025 12:39:40 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  7 Dec 2025 13:39:52 +0100 (CET)
Date: Sun, 7 Dec 2025 13:39:41 +0100
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
Subject: [PATCH 4/7] drm/amd: kill the outdated "Only the pthreads threading
 model is supported" checks
Message-ID: <aTV1jTmYK3Bjh4k6@redhat.com>
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

Nowaday task->group_leader->mm != task->mm is only possible if
a) task is not a group leader and b) task->group_leader->mm == NULL
because task->group_leader has already exited using sys_exit().

I don't think that drm/amd tries to detect/nack this case.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  3 ---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 ----------
 2 files changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a0f8ba382b9e..e44f158a11f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2551,9 +2551,6 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 	vm->task_info->task.pid = current->pid;
 	get_task_comm(vm->task_info->task.comm, current);
 
-	if (current->group_leader->mm != current->mm)
-		return;
-
 	vm->task_info->tgid = current->tgid;
 	get_task_comm(vm->task_info->process_name, current->group_leader);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a085faac9fe1..f8ef18a3aa71 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -833,12 +833,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	if (!(thread->mm && mmget_not_zero(thread->mm)))
 		return ERR_PTR(-EINVAL);
 
-	/* Only the pthreads threading model is supported. */
-	if (thread->group_leader->mm != thread->mm) {
-		mmput(thread->mm);
-		return ERR_PTR(-EINVAL);
-	}
-
 	/* If the process just called exec(3), it is possible that the
 	 * cleanup of the kfd_process (following the release of the mm
 	 * of the old process image) is still in the cleanup work queue.
@@ -918,10 +912,6 @@ struct kfd_process *kfd_get_process(const struct task_struct *thread)
 	if (!thread->mm)
 		return ERR_PTR(-EINVAL);
 
-	/* Only the pthreads threading model is supported. */
-	if (thread->group_leader->mm != thread->mm)
-		return ERR_PTR(-EINVAL);
-
 	process = find_process(thread, false);
 	if (!process)
 		return ERR_PTR(-EINVAL);
-- 
2.52.0


