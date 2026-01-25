Return-Path: <linux-rdma+bounces-15995-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKRNCGdAdmm6OAEAu9opvQ
	(envelope-from <linux-rdma+bounces-15995-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 17:10:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A7D8161D
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 17:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E035300DF67
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 16:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809B9326937;
	Sun, 25 Jan 2026 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O20MEYEg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EB6325726
	for <linux-rdma@vger.kernel.org>; Sun, 25 Jan 2026 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769357280; cv=none; b=P1n2g1d7dk5Vg9pKfZGGtbbOYS1kk3bW39XqHL6FAjpm23Qe75ZV8xQke95aeq902Ex/aAso1BAA+v7AWfcXi5JW6005y58j34vchqpu6uI69dN1+CcUHaM7N6MYdcsrxV9ZgZjuqX0ywr/rzVyDWDlhU1worRimEJ7+ZjdXhYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769357280; c=relaxed/simple;
	bh=swHaI3c2JoPO1HOTXeiCGWsEgjLI793SCNrpBEK/UgA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qXcO2yeSvLPs1RsH+xWDXWNpCgtG5XTC/sDFhVKUumQvQPWDxpQTrei5iFUm8iUKaWSLMNTea4uEdDBVKkiKS1nKW5q97O0dDiS48mkdG2xxbPtPPuP7BRihPL8PKIobCSwsWRUfdFY2ctrwZPu6G2BOUYXGe8YgVgSrvD8Zx1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O20MEYEg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769357277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=pehOQwRLVUnKwmfNDz7t+7CRyqZIDgEsusANGj0Uc5c=;
	b=O20MEYEgMahTrwaHfmR0gBYcinT1d14yL2fU1RJjqUCvjOCsVWx13l1Cj2UwUzpfj9yUze
	HcMWK2QF58DGB/HE3J6Lq/eWaw8enF3ZiYwoFvC3cs2ro9VFu72AGrdExBadaSmk0oA+U9
	sEAbGmRnBZutf+icAlXcrPJxKYWNELQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-EJ_A6oNuP3CBRjhniGKd5Q-1; Sun,
 25 Jan 2026 11:07:53 -0500
X-MC-Unique: EJ_A6oNuP3CBRjhniGKd5Q-1
X-Mimecast-MFC-AGG-ID: EJ_A6oNuP3CBRjhniGKd5Q_1769357271
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFD5118003FC;
	Sun, 25 Jan 2026 16:07:51 +0000 (UTC)
Received: from fedora (unknown [10.45.224.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D1A1B1955F66;
	Sun, 25 Jan 2026 16:07:45 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 25 Jan 2026 17:07:51 +0100 (CET)
Date: Sun, 25 Jan 2026 17:07:44 +0100
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
Subject: [PATCH v2 5/7] drm/pan*: don't abuse current->group_leader
Message-ID: <aXY_0MrQBZWKbbmA@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-15995-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: 58A7D8161D
X-Rspamd-Action: no action

Cleanup and preparation to simplify the next changes.

Use current->tgid instead of current->group_leader->pid.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
Acked-by: Steven Price <steven.price@arm.com>
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


