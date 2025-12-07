Return-Path: <linux-rdma+bounces-14913-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF060CAB4CE
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Dec 2025 13:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 694DF305C826
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Dec 2025 12:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9592F1FE6;
	Sun,  7 Dec 2025 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lss+ZpdV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF429C325
	for <linux-rdma@vger.kernel.org>; Sun,  7 Dec 2025 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765111238; cv=none; b=B6ZSBWRTYIJgMNIL2BwxAF3kzEAngcarIfgb67FrWrHdWyA6dNodqzxvWKuPQE+2fjJ2lobNqcytr2KW6qpUdMaACT0ou5CFHTRIumkz1a4tqOawHejNcpfslA13j7FphVO7Cd76aQPDge3IhTnZjhHXP2MwJ6xm4SrcEqJ3NPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765111238; c=relaxed/simple;
	bh=K2R9b0barWC68k/7xbhNUGCfm1zFHkjY7UaNg/NdOEg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GNL3t85U05bXzr3tWre0nrdeugZmOjhMMkCQiat76gHaFbXVlA9IBz3mkJTJX1CpDW1vevNDJZ6OanKt3AGGSYWlTQffpdJdAD2S1qkauGCilDQtub0Bc0t1tUdg7eNbF2tPs4oSmzjNRiwdwVKw4fcozg3T6q6JuHEDsxf+Wz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lss+ZpdV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765111235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=vBKRDP8bqkordujGp7qy48QcPV4IJTrct7fsioyRbjk=;
	b=Lss+ZpdVRYPolqJtDb+W3p1bc3yvMSiJoOZmPN2tVYrmH3IbF6bj1NsdsfkrrTaafX1awG
	V+GwFkbQ+K81gSp2YisoXlo8jm6ZWdj5Hl11whGO4PXj3Nr3VsnM1GlWOkUH9E6dYHcHXx
	1BW9RxLeJXDv3MpO5c9/UcyeUSRWBDk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-JQrVjfGoPfWfFYZ-A2FkAA-1; Sun,
 07 Dec 2025 07:40:30 -0500
X-MC-Unique: JQrVjfGoPfWfFYZ-A2FkAA-1
X-Mimecast-MFC-AGG-ID: JQrVjfGoPfWfFYZ-A2FkAA_1765111226
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C312A195609F;
	Sun,  7 Dec 2025 12:40:26 +0000 (UTC)
Received: from fedora (unknown [10.44.32.50])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B38033011A86;
	Sun,  7 Dec 2025 12:40:16 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  7 Dec 2025 13:40:28 +0100 (CET)
Date: Sun, 7 Dec 2025 13:40:17 +0100
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
Subject: [PATCH 7/7] netclassid: use thread_group_leader(p) in
 update_classid_task()
Message-ID: <aTV1sWfObXC4-lgY@redhat.com>
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

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 net/core/netclassid_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netclassid_cgroup.c b/net/core/netclassid_cgroup.c
index dff66d8fb325..db9a5354f9de 100644
--- a/net/core/netclassid_cgroup.c
+++ b/net/core/netclassid_cgroup.c
@@ -93,7 +93,7 @@ static void update_classid_task(struct task_struct *p, u32 classid)
 	/* Only update the leader task, when many threads in this task,
 	 * so it can avoid the useless traversal.
 	 */
-	if (p != p->group_leader)
+	if (!thread_group_leader(p))
 		return;
 
 	do {
-- 
2.52.0


