Return-Path: <linux-rdma+bounces-2902-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4498FD12B
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 16:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FFDFB238C9
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E65224EA;
	Wed,  5 Jun 2024 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KnfnMSlV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0027450
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599142; cv=none; b=p0cScM5CYJX2lRo2doBMX7r/H7sHAcNeAJ1slQlA6icsfs5RkHewVO4knP8AeQeKBSp1NEXSeTdURkC1KD1SrxI90BNsgQ26NbFhPNWPxgbfOwf+DkkpQq5T7zofL8HTRWM8lTuCWX4MbcjnK0cI5JV+HQh9/2KKdqGmKXHD4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599142; c=relaxed/simple;
	bh=TlKUs0z4HGQbT87QlP7EL88FFtI01S4xY4tN+HVAwns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qdqe0mCSph7rVIfXj9fEkwyz7RXGpam62TcfL9if8Z/KdMoAa1angyfK3vk3bchrXe2z0jAhIcS8G7VRv+h1sUHRDatdoel5zB331WCZ+wv3d9NDqnaMAzECLjskbw6CUGndmuyp4q9pQGFDTh0Of1MJ1WEzENSPjaI5zETuG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KnfnMSlV; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VvVmh1rlPzlgMVV;
	Wed,  5 Jun 2024 14:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1717599136; x=1720191137; bh=DHsoZ
	4Tf+szqcoTBNHI8hXrUOmjHAAHzpWk3j4+V9Gk=; b=KnfnMSlVdXrJx7vNCQO7p
	b9twWsYmkU+yZt4SSYzwY67zwC1/QxKikg3fMEhc8JeENrOcWWxjE+7wYWeTVH2S
	HoaH8WQqOcTG6htU6csFxzqa1emsWZtLr58YT3nVdvXyuk5TdqDj2BZUt+6wrHt0
	/eMw2Do/+XLDEaNdOxWk72mByvdIL4nnweOdhdtf49uYRO5sk5eYPXNFGByyeL4C
	eDh1+O+5lJJL6wU0aOe33JcgnaGRe2wsZ8Q3bEA+MYLBLcjPxxnUbWI7fZ4P19ua
	WK1qO1NqOXp3hykMLhX734PysD/GhaQXEDIv7GBoGKVILi3LjUeYWH8KyU/05kgV
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kce4BlD2Lm03; Wed,  5 Jun 2024 14:52:16 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VvVmZ1TjBzlgMVS;
	Wed,  5 Jun 2024 14:52:14 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	linux-rdma@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>
Subject: [PATCH 5/5] RDMA/iwcm: Fix a use-after-free related to destroying CM IDs
Date: Wed,  5 Jun 2024 08:51:01 -0600
Message-ID: <20240605145117.397751-6-bvanassche@acm.org>
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

iw_conn_req_handler() associates a new struct rdma_id_private (conn_id) w=
ith
an existing struct iw_cm_id (cm_id) as follows:

        conn_id->cm_id.iw =3D cm_id;
        cm_id->context =3D conn_id;
        cm_id->cm_handler =3D cma_iw_handler;

rdma_destroy_id() frees both the cm_id and the struct rdma_id_private. Ma=
ke
sure that cm_work_handler() does not trigger a use-after-free by only
freeing of the struct rdma_id_private after all pending work has finished=
.

Cc: stable
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/core/iwcm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwc=
m.c
index 4424f430fc08..1a6339f3a63f 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -368,8 +368,10 @@ EXPORT_SYMBOL(iw_cm_disconnect);
  *
  * Clean up all resources associated with the connection and release
  * the initial reference taken by iw_create_cm_id.
+ *
+ * Returns true if and only if the last cm_id_priv reference has been dr=
opped.
  */
-static void destroy_cm_id(struct iw_cm_id *cm_id)
+static bool destroy_cm_id(struct iw_cm_id *cm_id)
 {
 	struct iwcm_id_private *cm_id_priv;
 	struct ib_qp *qp;
@@ -439,7 +441,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 		iwpm_remove_mapping(&cm_id->local_addr, RDMA_NL_IWCM);
 	}
=20
-	(void)iwcm_deref_id(cm_id_priv);
+	return iwcm_deref_id(cm_id_priv);
 }
=20
 /*
@@ -450,7 +452,8 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
  */
 void iw_destroy_cm_id(struct iw_cm_id *cm_id)
 {
-	destroy_cm_id(cm_id);
+	if (!destroy_cm_id(cm_id))
+		flush_workqueue(iwcm_wq);
 }
 EXPORT_SYMBOL(iw_destroy_cm_id);
=20
@@ -1031,7 +1034,7 @@ static void cm_work_handler(struct work_struct *_wo=
rk)
 		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
 			ret =3D process_event(cm_id_priv, &levent);
 			if (ret)
-				destroy_cm_id(&cm_id_priv->id);
+				WARN_ON_ONCE(destroy_cm_id(&cm_id_priv->id));
 		} else
 			pr_debug("dropping event %d\n", levent.event);
 		if (iwcm_deref_id(cm_id_priv))

