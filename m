Return-Path: <linux-rdma+bounces-2898-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295CD8FD125
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 16:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E1C1F23ECA
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D595A1EEE6;
	Wed,  5 Jun 2024 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="S9V5GNeT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B44819D8A3
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599110; cv=none; b=J49hCVmUVJqGuc3/IIQg/0xIpzX4NGfccH1IImvtklBWCQXAGBUGgf66ntaYyE2P6qgLwVOY4FSStPRrjGcuC9f7heseW5P4wfyftsI5wComwCDiYqkIDJIxWJJkNunAZWsEiIjnkmWzmGCUnkwVpxPgMBxdCK4QDVoVv0LvZn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599110; c=relaxed/simple;
	bh=k6TBkKogCGBOGdS/ehVn0sIqejOoljb+798ywySdX9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbNqNSlrjnDg/ALwrRnTF22k0vCpNmgT8UNCwnp84Y903yGGZm+H1Lobe0SkdVAggLQIstcvUVhymt5FnsCP9Gb7uG0DfN2HaVzqbTfve6KSq0ZInLZW2PYyKht0hh9lHeU6TgGyVFlmcpnv63h5JdVcpgxDQBnFvdyKbJW/Lb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=S9V5GNeT; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VvVm45QgszlgMVV;
	Wed,  5 Jun 2024 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1717599105; x=1720191106; bh=LKWcZ
	Kgr9WtBiRSIv/1iiA76vNy5YvxFIbtqTDcNces=; b=S9V5GNeTF3An1i8KeFEeO
	T4l5Qq69vatU6kNBgFMVd8K2h5whrJhzMYgsvFuTiQ8I5sCaPMyHZLDmvBjDGoiE
	/e++ZNtcWCYEmbRAxIZrMcwuCVDhoiyZHXucBCi3eT/afekbcKJGLRUN/j/uV0p+
	dsxYQxDI6Iwa0cIlP35qk8VJ0pnc49rhTSgfI3AjtbYO8c5drSep3EYqT//+cD+K
	Oa7gCsHSOWVN9bdF1fdy3OkaQy/m6FAWKjGtq7E8qyCNnYSaK17vBd5pKfkBI85t
	7nGr0kUTLf5gOditGejFtBFkebXbTwRmj2D8vK4xCI/Jo4vOThZgnswIAPTx11S3
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fAz4kRzV33Wz; Wed,  5 Jun 2024 14:51:45 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VvVlz2rp1zlgMVS;
	Wed,  5 Jun 2024 14:51:43 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	linux-rdma@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/5] RDMA/iwcm: Use list_first_entry() where appropriate
Date: Wed,  5 Jun 2024 08:50:57 -0600
Message-ID: <20240605145117.397751-2-bvanassche@acm.org>
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

Improve source code readability by using list_first_entry() where appropr=
iate.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/core/iwcm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwc=
m.c
index 0301fcad4b48..90d8f3d66990 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -143,8 +143,8 @@ static struct iwcm_work *get_work(struct iwcm_id_priv=
ate *cm_id_priv)
=20
 	if (list_empty(&cm_id_priv->work_free_list))
 		return NULL;
-	work =3D list_entry(cm_id_priv->work_free_list.next, struct iwcm_work,
-			  free_list);
+	work =3D list_first_entry(&cm_id_priv->work_free_list, struct iwcm_work=
,
+				free_list);
 	list_del_init(&work->free_list);
 	return work;
 }
@@ -1023,8 +1023,8 @@ static void cm_work_handler(struct work_struct *_wo=
rk)
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	empty =3D list_empty(&cm_id_priv->work_list);
 	while (!empty) {
-		work =3D list_entry(cm_id_priv->work_list.next,
-				  struct iwcm_work, list);
+		work =3D list_first_entry(&cm_id_priv->work_list,
+					struct iwcm_work, list);
 		list_del_init(&work->list);
 		empty =3D list_empty(&cm_id_priv->work_list);
 		levent =3D work->event;

