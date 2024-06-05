Return-Path: <linux-rdma+bounces-2899-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778598FD127
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 16:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902DB1C21F1E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CD527701;
	Wed,  5 Jun 2024 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="m9Y+6pqb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1124A19D8A3
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599116; cv=none; b=YKaTDhThKGGvpuZq83m+TFRjIj8ejDzTeU9IboEWiOt8pPY2Ee634kfKejip8sJfIO6axxpQ0diRzUc9q+lrltq008ik4MSgKKSPiVkqqm0Q4v9HFy+jhqp0d91VLXfDo+ZTXPyZePFbEyZoo+lS2Jf08xcw0IVG/dCyZ4nPQH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599116; c=relaxed/simple;
	bh=r/IFBp+yYlo9FQTgwQy2+xbNt3lwzK5MtMfJ+1R3RMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsOCzbJwLO1XP8o9nv0nTX3KOMvTyNnFMAXxwJxbYTQc+6KYyZ5PytUzPe+4E6CM4cOSKq9aHEBaHrn6VjwN4Ikj7kagpisBV2JTqn8QwX7Z8bcBdkaUjzwGIJ6Pqg17WWob2Uy/wSLyO2OaLU+7P/bL5c4gmUe7HS5QOsuqW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=m9Y+6pqb; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VvVmB3VgrzlgMVW;
	Wed,  5 Jun 2024 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1717599111; x=1720191112; bh=pRFWw
	nxDpbaPZ3mobvlFH89gOCKjm18/Izua5RjI8bw=; b=m9Y+6pqbn7giIVrCe4637
	Oos8Ld45OZ3pNg99Qvl7GKbE5/MKbyIm5yM0A6PH/Vz65ef4l1XmceoLGmApsPj8
	0TOrQo7Z8q5wKdFhfmA4uXwbPafSzQFBFU+fZQMR9BqXQnaDsnkTcab6Hd0GHAJ9
	OVL9nR0Gvn3aQuvG23IqlARbGagaIphUEteeNIw4eWqeUCLSqq/pE/NPVgHazxq0
	OHXohV7RdcvIbv7tQ2+GYAIkmvmhBQwViUEjYUu5YQIjWE3NqSYYrkTpsvkANvgO
	BnX/IaogpBAkXxlbzxVRyk+U1tDBVkoCjePl8TSTsVePX+mZtwcZcKx7ClNGDh3Q
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0ABlTBwXomLb; Wed,  5 Jun 2024 14:51:51 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VvVm52Q67zlgMVS;
	Wed,  5 Jun 2024 14:51:49 +0000 (UTC)
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
Subject: [PATCH 2/5] RDMA/iwcm: Change the return type of iwcm_deref_id()
Date: Wed,  5 Jun 2024 08:50:58 -0600
Message-ID: <20240605145117.397751-3-bvanassche@acm.org>
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

Since iwcm_deref_id() returns either 0 or 1, change its return type from
'int' into 'bool'.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/core/iwcm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwc=
m.c
index 90d8f3d66990..ae9c12409f8a 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -206,17 +206,17 @@ static void free_cm_id(struct iwcm_id_private *cm_i=
d_priv)
=20
 /*
  * Release a reference on cm_id. If the last reference is being
- * released, free the cm_id and return 1.
+ * released, free the cm_id and return 'true'.
  */
-static int iwcm_deref_id(struct iwcm_id_private *cm_id_priv)
+static bool iwcm_deref_id(struct iwcm_id_private *cm_id_priv)
 {
 	if (refcount_dec_and_test(&cm_id_priv->refcount)) {
 		BUG_ON(!list_empty(&cm_id_priv->work_list));
 		free_cm_id(cm_id_priv);
-		return 1;
+		return true;
 	}
=20
-	return 0;
+	return false;
 }
=20
 static void add_ref(struct iw_cm_id *cm_id)

