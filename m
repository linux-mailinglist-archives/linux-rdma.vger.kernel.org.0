Return-Path: <linux-rdma+bounces-15994-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNgqM1FAdmm6OAEAu9opvQ
	(envelope-from <linux-rdma+bounces-15994-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 17:09:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 127E581616
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 17:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E9A53032CE2
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 16:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB86DEEAB;
	Sun, 25 Jan 2026 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FV0NObKJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A16B325734
	for <linux-rdma@vger.kernel.org>; Sun, 25 Jan 2026 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769357273; cv=none; b=p1nSNLaglNX2q1rNjUYHR2p506cP5ZjT3VXW23TTQt6iKZq84uq+hCM2Z8/vDEFCnvS7UuCFj1JPX8yuCM/lEV9Fb/dMXLEUJURKdCbEogzbe52Qw08PTpPUfBKz3ljMxcNtUEKu1vAF1QYATnozHBdGqQWF0UAvoDn0hDjMNdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769357273; c=relaxed/simple;
	bh=VJ5cSYp2xK2SbdPZbmh3iaP2IOZw+qeby9FVKdtFbpY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tbZA25YzPtGcLlGVt1BBfU0UwBY49/b1zjUvKdtNrSlTksdKVUkco7gGcy0upUCYSZLOuSgDGvVHKZQqassOFqraj8kjxuC/kJ7UN5AXtVCucxTEIBykDu6oWHsq+exfw3KouGS6nCF5QCdIGdn7WHgmGBwCxYSkHgDXS3pWiwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FV0NObKJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769357271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=HX7g4ZyLO3QeN4rHwQXwu4GirpPKoFXznz/m5O/wqpg=;
	b=FV0NObKJnN+AoPnAJ2lOx2WgFZSfPpEbnFPbJnWAptrKOgY0FNOOdJDdorHN90+VN3ZqRm
	2h0WmY0ePGBsu3pi2gHF9Xj7RzS9aeNN0Z14M/g2/pQiI698lmOzGvhTeh6xvhTM9GF7rq
	FigC8ymkDbg5O1blWvD6F2C28HAVtIk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-8vLhMG4tMRe8EuN-kyIaCA-1; Sun,
 25 Jan 2026 11:07:46 -0500
X-MC-Unique: 8vLhMG4tMRe8EuN-kyIaCA-1
X-Mimecast-MFC-AGG-ID: 8vLhMG4tMRe8EuN-kyIaCA_1769357264
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B313A195608D;
	Sun, 25 Jan 2026 16:07:43 +0000 (UTC)
Received: from fedora (unknown [10.45.224.8])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EDD351800665;
	Sun, 25 Jan 2026 16:07:37 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 25 Jan 2026 17:07:43 +0100 (CET)
Date: Sun, 25 Jan 2026 17:07:36 +0100
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
Subject: [PATCH v2 4/7] drm/amd: kill the outdated "Only the pthreads
 threading model is supported" checks
Message-ID: <aXY_yLVHd63UlWtm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXY_h8i78n6yD9JY@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15994-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: 127E581616
X-Rspamd-Action: no action

Nowaday task->group_leader->mm != task->mm is only possible if
a) task is not a group leader and b) task->group_leader->mm == NULL
because task->group_leader has already exited using sys_exit().

I don't think that drm/amd tries to detect/nack this case.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
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


