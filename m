Return-Path: <linux-rdma+bounces-15993-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OWuBBlAdmm6OAEAu9opvQ
	(envelope-from <linux-rdma+bounces-15993-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 17:08:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 685A2815F9
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 17:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 849E530210EF
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD16C32573F;
	Sun, 25 Jan 2026 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+wOi+sl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5054D1A704B
	for <linux-rdma@vger.kernel.org>; Sun, 25 Jan 2026 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769357263; cv=none; b=tpOYcUGucwCTqfye5qMI9V1jm5jTdbf/bSdxzzZy94fvFildD40e5gWZwqT1PyXggcriNEVczwysP5Rvf8P5WayWfOKnhyLp/aPH1JC6HXwNtuk65H7Fg0SGrTOgAjIfEbih3xaFMPZVnalAUyeLUNk/D6pIjzYoJwBFzj2sQDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769357263; c=relaxed/simple;
	bh=1lGyYdRNHkzunJkfjyz57W92tLBgj8dcgac0gWPppr4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IGZKmeCpOoHfc+IqHw/Ehky4/MZXkLDA3aOUgmoP+PyyMA4v9L5E3Vqt3iPVBCRuHrF0nssfdCbAMKnEE0ZI1S+riwAlu8DAtF5ad3CampDcIuJD7w6Pkach+az7es5lHJyv1BkW2lcSJSixhrzO5k3dp8s0vSSPZM/RLc5/1G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+wOi+sl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769357261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=aojbJJ5FzMzE2HJE4QEerULCpiKv5AGEyOIjsVq7b3Q=;
	b=A+wOi+slVatp38lrcnDoUrXmLlVqKCZ0mnfw7awmcdnzlCIil8oZiNseMdtlwypjYmZfwI
	fMKbMF/0lfmHe3ASaKt8IIozyeLGeS/WI8hbhrEjplUZ14OvWnJ0wmFKiC4aCMV0Imewbo
	HboLSoIsvPAp18GWxixQxRL/YJul8LQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-m897L2klPTqHE3h_lcyBAg-1; Sun,
 25 Jan 2026 11:07:38 -0500
X-MC-Unique: m897L2klPTqHE3h_lcyBAg-1
X-Mimecast-MFC-AGG-ID: m897L2klPTqHE3h_lcyBAg_1769357256
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E58761800451;
	Sun, 25 Jan 2026 16:07:35 +0000 (UTC)
Received: from fedora (unknown [10.45.224.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D7B8A1958DC4;
	Sun, 25 Jan 2026 16:07:29 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 25 Jan 2026 17:07:35 +0100 (CET)
Date: Sun, 25 Jan 2026 17:07:28 +0100
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
Subject: [PATCH v2 3/7] drm/amdgpu: don't abuse current->group_leader
Message-ID: <aXY_wKewzV5lCa5I@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXY_h8i78n6yD9JY@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15993-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 685A2815F9
X-Rspamd-Action: no action

Cleanup and preparation to simplify the next changes.

- Use current->tgid instead of current->group_leader->pid

- Use get_task_pid(current, PIDTYPE_TGID) instead of
  get_task_pid(current->group_leader, PIDTYPE_PID)

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b1c24c8fa686..df22b54ba346 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1421,7 +1421,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 			goto create_evict_fence_fail;
 		}
 
-		info->pid = get_task_pid(current->group_leader, PIDTYPE_PID);
+		info->pid = get_task_pid(current, PIDTYPE_TGID);
 		INIT_DELAYED_WORK(&info->restore_userptr_work,
 				  amdgpu_amdkfd_restore_userptr_worker);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a67285118c37..a0f8ba382b9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2554,7 +2554,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 	if (current->group_leader->mm != current->mm)
 		return;
 
-	vm->task_info->tgid = current->group_leader->pid;
+	vm->task_info->tgid = current->tgid;
 	get_task_comm(vm->task_info->process_name, current->group_leader);
 }
 
-- 
2.52.0


