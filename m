Return-Path: <linux-rdma+bounces-2900-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25DF8FD128
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 16:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A19285620
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 14:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A382327450;
	Wed,  5 Jun 2024 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mwVPKJ6e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4919D8A3
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599122; cv=none; b=Gm5P6399DKguySotMt7a8h/jF/OSFIV6zFFvU6gerauXdM8KGFa5ATe/DK52M1YMXf/bY/aVzs6qMeHlXMhfqXmw5KwR8yz8IUog21IfhGLgVKV5J/lfvSR9wzeubbtYLtwnQJK3XKgaT+etItvp2U3E8DviC6fcwBWYbD+OZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599122; c=relaxed/simple;
	bh=wDm8oxVJqZI40k1iiq1qOwG8H4gAoNqGOvCJ49ZSntY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYXu/MXi/aKvFgZf3pdvKm7lvWrLe9Q5tpgiPhjfOpb77sgwJvZS+BAIlQMg0B64eoSJ2+FYNdt8bWyV+kyGkLjtKnRfVjDxnKSiGfeRgmZEuQDKskMc6V/mJE/vPTJyIeVYN4j7IsJRqQsRYVfs/pXxacKVHOCkGfV4+TpvlAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mwVPKJ6e; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VvVmJ4kSHzlgMVV;
	Wed,  5 Jun 2024 14:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1717599117; x=1720191118; bh=dxKjZ
	lWEpeeiDoQUnXbj70tGUpxYAtXGTzInP6i7SJI=; b=mwVPKJ6eu6VLUsmDRTKIv
	tTBs5OPtr8i0+ri5eFhxJTKeXtuMEtfk5S0HzQ/qZwHcUpwcEPz7wDlt0lsSAinr
	DwbArqsUk1VqQSts4X3SllfWUuGGx0OYaywvJrzehjUX3XVlm1UFcZS52IcwVZ0G
	/pfR3waXeHC8VOBKL+33beTjc49MbRra0HPgJmy4imAfuz0NixQN3yrB0tDxSe1c
	8RpQSNAiQczrjhjJsInLN/SNgyMm0KXwY1WxDWTT8WpF7uNOTZpm3yxcgGBJp2+x
	N5hiVTrLQl6Bybq+PurehC2WDkAxxVG+wAN9XNc64diuZdACinpJJiRaxqC2HEWU
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id n8AfIv_I3b5c; Wed,  5 Jun 2024 14:51:57 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VvVmC36SWzlgMVS;
	Wed,  5 Jun 2024 14:51:55 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	linux-rdma@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 3/5] RDMA/iwcm: Simplify cm_event_handler()
Date: Wed,  5 Jun 2024 08:50:59 -0600
Message-ID: <20240605145117.397751-4-bvanassche@acm.org>
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

queue_work() can test efficiently whether or not work is pending. Hence,
simplify cm_event_handler() by always calling queue_work() instead of onl=
y
if the list with pending work is empty.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/core/iwcm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwc=
m.c
index ae9c12409f8a..3d66aec36899 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -1093,11 +1093,8 @@ static int cm_event_handler(struct iw_cm_id *cm_id=
,
 	}
=20
 	refcount_inc(&cm_id_priv->refcount);
-	if (list_empty(&cm_id_priv->work_list)) {
-		list_add_tail(&work->list, &cm_id_priv->work_list);
-		queue_work(iwcm_wq, &work->work);
-	} else
-		list_add_tail(&work->list, &cm_id_priv->work_list);
+	list_add_tail(&work->list, &cm_id_priv->work_list);
+	queue_work(iwcm_wq, &work->work);
 out:
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 	return ret;

