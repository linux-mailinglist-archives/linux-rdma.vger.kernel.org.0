Return-Path: <linux-rdma+bounces-2901-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 762658FD12A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 16:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8331F24579
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 14:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5496F2E403;
	Wed,  5 Jun 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="bIqUh0+w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CB225774
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599133; cv=none; b=mHrnVFQrDcbWAwBBFJGBSDxZVed/63OT1lg+lFmZORoH8wlL6YcCBbYdAqBMVzh6p7v+AXCw54LD2K5+t/aUnmwBNpiGiHnhyo/xjGTs45kQLz4tImwjlX5fLq/BS8/c5oIv5fq/+aG2RoqjzdMx6gKf692Ctu3CqCrjqGOffxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599133; c=relaxed/simple;
	bh=hG2+BDNfy3pagO2sWcFkx0lXK/nck2spPLDruMjnR0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fj6/aoZqix3j9/fRW3fVTii27gmhU2arnGIVMJlcRLanm1iqGJWx1zkgIh/JUgdwOG+7CyyK5pc1IJ+CntbIzO18v82UXOIbGrtrFausHToe+0hl4lFcQ/wkXeDKpvJ+GDnbHIfJz/byq0LllV/FW85ZWhZajXJK5NyBnYy1Yjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=bIqUh0+w; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VvVmW2fGHzlgMVV;
	Wed,  5 Jun 2024 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1717599127; x=1720191128; bh=tPUDq
	vHHJnIoYtVbpAepuZthuvUDN03ZrbWJJYHu0wI=; b=bIqUh0+wKssnlfEgT87jf
	umqC+lvixPDa6bKzw2GMA2loyiRVzywSy8AjiYVcFux9UUQlOtwEAE/ji5cc5VaP
	NfYkQvbBxW7rk/MAjP0K8FyVbAOtbnyeIQWMpfi1AkLscBx8GbC3VSSl78lbPWtq
	tBe8uhFv6yK4o9xKxfscmnxt6PCUwlLPsDnix8tes03bP1A8AXM/L1qEqdz3Hatg
	O5Eh6m3s6T6ikTPjLmof6vGyK2c3rDbHyz8yIQQkHfF5ciUzM35WIrgiHUoQx/8D
	0AqRpCthygiExU1TFn4F0SAdY26Vm1mgBg1v6Sdnrd+5cbaXuOMRQMcMBQ+qze/1
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id U_w2qN5jHQlj; Wed,  5 Jun 2024 14:52:07 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VvVmP1SjRzlgMVS;
	Wed,  5 Jun 2024 14:52:04 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	linux-rdma@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Joel Granados <j.granados@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 4/5] RDMA/iwcm: Simplify cm_work_handler()
Date: Wed,  5 Jun 2024 08:51:00 -0600
Message-ID: <20240605145117.397751-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240605145117.397751-1-bvanassche@acm.org>
References: <20240605145117.397751-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of complicating the code to avoid a spin_lock_irqsave() /
spin_lock_irqrestore() pair before returning, simplify the code by removi=
ng
the local variable 'empty'.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/core/iwcm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwc=
m.c
index 3d66aec36899..4424f430fc08 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -1017,16 +1017,13 @@ static void cm_work_handler(struct work_struct *_=
work)
 	struct iw_cm_event levent;
 	struct iwcm_id_private *cm_id_priv =3D work->cm_id;
 	unsigned long flags;
-	int empty;
 	int ret =3D 0;
=20
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
-	empty =3D list_empty(&cm_id_priv->work_list);
-	while (!empty) {
+	while (!list_empty(&cm_id_priv->work_list)) {
 		work =3D list_first_entry(&cm_id_priv->work_list,
 					struct iwcm_work, list);
 		list_del_init(&work->list);
-		empty =3D list_empty(&cm_id_priv->work_list);
 		levent =3D work->event;
 		put_work(work);
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
@@ -1039,8 +1036,6 @@ static void cm_work_handler(struct work_struct *_wo=
rk)
 			pr_debug("dropping event %d\n", levent.event);
 		if (iwcm_deref_id(cm_id_priv))
 			return;
-		if (empty)
-			return;
 		spin_lock_irqsave(&cm_id_priv->lock, flags);
 	}
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);

