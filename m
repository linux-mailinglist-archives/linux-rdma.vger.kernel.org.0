Return-Path: <linux-rdma+bounces-15990-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLo0FJ8/dmm6OAEAu9opvQ
	(envelope-from <linux-rdma+bounces-15990-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 17:06:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A78A28156B
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 17:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3828B3006501
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E690E326927;
	Sun, 25 Jan 2026 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtUVD3te"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CB4325726
	for <linux-rdma@vger.kernel.org>; Sun, 25 Jan 2026 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769357209; cv=none; b=VX9sWMBAomDmlS1Ui8IgDqFnE0WjJBgjD2cxigX5ErQm1kiam060teH5nM0wiJGXUyAJBDBu9MUgvg7YNpi1EoqwqBCMg0uMzcKTY7wS1J+mjzgqgmgykgrpqH/maU+mKSZ89M+6bZCwrC1HGaZ8isWDuWqBJpijNGy9UnanWlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769357209; c=relaxed/simple;
	bh=GSlQIT/+IJfCKmiinYtstHpEZeTo2NJEAuuwOFkTEzo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=chQ6M7lbn73I/CvhxPabDhwh+S/MifvfTMeHJ/t+qOZ5xqdDN108BUZDxN+RIAWVqNFPF8vwDlBHtjOTqSWj/UZstSjEy+dppWOsKnK9yZqOVcHlamlKRcDB2FfSJ+WNN7U4NCT43PWrcre42CUmBPYUiqfb47kp/hax2Ow6KP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BtUVD3te; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769357207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=6XHVeVhJgsFiFSaz4pxwz0WF8NA7U9e0c68zypE8Q6g=;
	b=BtUVD3tezpTWYrxvEE8kW/U/j/EoyEf1gEWdD1c2yLKwctLXAgqWdrIXx8HTqp3KwVV9Hf
	u3ryWJP6DIxK7RgCku7D9hqfnB6RyXADLF61sQy+60y393JmVVTs1WEeDSgXgKxXTKteUi
	HRQgzxMKBKYNSfRxkpXKZdadkP0T2yA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-IolnCAo-OX6IbJfKHl6ZvQ-1; Sun,
 25 Jan 2026 11:06:41 -0500
X-MC-Unique: IolnCAo-OX6IbJfKHl6ZvQ-1
X-Mimecast-MFC-AGG-ID: IolnCAo-OX6IbJfKHl6ZvQ_1769357199
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05828195608D;
	Sun, 25 Jan 2026 16:06:39 +0000 (UTC)
Received: from fedora (unknown [10.45.224.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1F3C330001A7;
	Sun, 25 Jan 2026 16:06:32 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 25 Jan 2026 17:06:38 +0100 (CET)
Date: Sun, 25 Jan 2026 17:06:31 +0100
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
Subject: [PATCH v2 0/7] don't abuse task_struct.group_leader
Message-ID: <aXY_h8i78n6yD9JY@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-15990-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: A78A28156B
X-Rspamd-Action: no action

Andrew, can you take these simple cleanups?

The patches do not depend on each other, this series just removes
the usage of ->group_leader when it is "obviously unnecessary".

I am going to move ->group_leader from task_struct to signal_struct
or at least add the new task_group_leader() helper. So I will send
more tree-wide changes on top of this series.

Link to V1: https://lore.kernel.org/all/aTV1KYdcDGvjXHos@redhat.com/

V2 doesn't differ, I only added the acks I got (thanks!).

7/7 was not reviewed, but looks really trivial.

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


