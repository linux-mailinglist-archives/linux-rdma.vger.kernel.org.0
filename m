Return-Path: <linux-rdma+bounces-250-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FCC804351
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 01:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5422813CF
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 00:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8045657;
	Tue,  5 Dec 2023 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UErw5z0T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F24DB0
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 16:24:16 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b844357f7cso2809836b6e.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 Dec 2023 16:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701735855; x=1702340655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QktSggJLQcetld8uakFuhfIq2ygrmNPQ2pKu14TqlYs=;
        b=UErw5z0T0aZ4tOdWoU/ua9QBycOSmeUCijT2L0NkRJWIFu/6rZvyN+zokKKzVlF60h
         P4SGc6JJNW8JloVLOCQxGD+cQqOcHppUvOA2IXf8kDYvJ9FXpB6VDsg69S41pNkSuBUs
         L5yJ8hsZPo8fiOt1MU7uj9G6mmqnafKJo0BUBcYpB6vx70ROOHFc2cz/4T7dN9OGJj1i
         +53DE/YGzc9zuqrTq9SZJ7macYOWlYRtCASMftBJ5P1uAPfWNUBhNWihZ+ImlRiu84tT
         A9CzHnAg0F1c6AcFNqZY25tetaM+qkabYnBb7Ci7RbHZmwpykD5JPHt+soCIO1OizJRN
         eN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735855; x=1702340655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QktSggJLQcetld8uakFuhfIq2ygrmNPQ2pKu14TqlYs=;
        b=coykprlQ/KBhlrZDL7xt0GLXQ+Vgo949yijUyzyvEru6GHBO/13teTHK2nMI5lNRKX
         zbE7tqtr3Iy0XeTSoS/gnk0fAJ5UbcgUAAqWMEcFUCSftwNhBAb0bV25/pI1unANfngs
         rGRLMiWUOTaDD0mJIOnhtBb/JTKgrvSYMCnmiVNosDdMLEjIRfAFA9Le4mPqxi6j1j8x
         y/Tbg/JrP2Yf4WkufS3AJfXiT1Y+r2g0l3fXp/C4l9bmB1sUXXk18EmDU7Dt66u/U4dv
         YQdrXtaRfJN81NwRw902hwXbCy2zg3k45jl/aRCAjvohHgablEyzJ8slfnT5CqK9kWIK
         Fe9A==
X-Gm-Message-State: AOJu0YzBLoBXCMdaWFr50t67bxnDoj6RYHxVvHyGnuctPYmjYPsnCNqv
	9fltzYhxQ/VrH3GTktslda8=
X-Google-Smtp-Source: AGHT+IFbGoBnxVwJlflAQCGHCAnRdF58ujxT3MuF/tzBK8hUjHAEspceJayEYpyddRsZF1UmtPXGlg==
X-Received: by 2002:aca:1b08:0:b0:3b6:b073:20d7 with SMTP id b8-20020aca1b08000000b003b6b07320d7mr4757160oib.17.1701735855382;
        Mon, 04 Dec 2023 16:24:15 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-e463-fe8f-1aa8-6edb.res6.spectrum.com. [2603:8081:1405:679b:e463:fe8f:1aa8:6edb])
        by smtp.gmail.com with ESMTPSA id bi25-20020a056808189900b003b2e4754cc2sm2007066oib.26.2023.12.04.16.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:24:14 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 1/7] RDMA/rxe: Cleanup rxe_ah/av_chk_attr
Date: Mon,  4 Dec 2023 18:23:18 -0600
Message-Id: <20231205002322.10143-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205002322.10143-1-rpearsonhpe@gmail.com>
References: <20231205002322.10143-1-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace rxe_ah_chk_attr() and rxe_av_chk_attr() by a single
routine rxe_chk_ah_attr().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c    | 43 ++++-----------------------
 drivers/infiniband/sw/rxe/rxe_loc.h   |  3 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  4 +--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  5 ++--
 4 files changed, 12 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 889d7adbd455..4ac17b8def28 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -14,45 +14,24 @@ void rxe_init_av(struct rdma_ah_attr *attr, struct rxe_av *av)
 	memcpy(av->dmac, attr->roce.dmac, ETH_ALEN);
 }
 
-static int chk_attr(void *obj, struct rdma_ah_attr *attr, bool obj_is_ah)
+int rxe_chk_ah_attr(struct rxe_dev *rxe, struct rdma_ah_attr *attr)
 {
 	const struct ib_global_route *grh = rdma_ah_read_grh(attr);
-	struct rxe_port *port;
-	struct rxe_dev *rxe;
-	struct rxe_qp *qp;
-	struct rxe_ah *ah;
+	struct rxe_port *port = &rxe->port;
 	int type;
 
-	if (obj_is_ah) {
-		ah = obj;
-		rxe = to_rdev(ah->ibah.device);
-	} else {
-		qp = obj;
-		rxe = to_rdev(qp->ibqp.device);
-	}
-
-	port = &rxe->port;
-
 	if (rdma_ah_get_ah_flags(attr) & IB_AH_GRH) {
 		if (grh->sgid_index > port->attr.gid_tbl_len) {
-			if (obj_is_ah)
-				rxe_dbg_ah(ah, "invalid sgid index = %d\n",
-						grh->sgid_index);
-			else
-				rxe_dbg_qp(qp, "invalid sgid index = %d\n",
-						grh->sgid_index);
+			rxe_dbg_dev(rxe, "invalid sgid index = %d\n",
+					grh->sgid_index);
 			return -EINVAL;
 		}
 
 		type = rdma_gid_attr_network_type(grh->sgid_attr);
 		if (type < RDMA_NETWORK_IPV4 ||
 		    type > RDMA_NETWORK_IPV6) {
-			if (obj_is_ah)
-				rxe_dbg_ah(ah, "invalid network type for rdma_rxe = %d\n",
-						type);
-			else
-				rxe_dbg_qp(qp, "invalid network type for rdma_rxe = %d\n",
-						type);
+			rxe_dbg_dev(rxe, "invalid network type for rdma_rxe = %d\n",
+					type);
 			return -EINVAL;
 		}
 	}
@@ -60,16 +39,6 @@ static int chk_attr(void *obj, struct rdma_ah_attr *attr, bool obj_is_ah)
 	return 0;
 }
 
-int rxe_av_chk_attr(struct rxe_qp *qp, struct rdma_ah_attr *attr)
-{
-	return chk_attr(qp, attr, false);
-}
-
-int rxe_ah_chk_attr(struct rxe_ah *ah, struct rdma_ah_attr *attr)
-{
-	return chk_attr(ah, attr, true);
-}
-
 void rxe_av_from_attr(u8 port_num, struct rxe_av *av,
 		     struct rdma_ah_attr *attr)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 4d2a8ef52c85..3d2504a0ae56 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -9,8 +9,7 @@
 
 /* rxe_av.c */
 void rxe_init_av(struct rdma_ah_attr *attr, struct rxe_av *av);
-int rxe_av_chk_attr(struct rxe_qp *qp, struct rdma_ah_attr *attr);
-int rxe_ah_chk_attr(struct rxe_ah *ah, struct rdma_ah_attr *attr);
+int rxe_chk_ah_attr(struct rxe_dev *rxe, struct rdma_ah_attr *attr);
 void rxe_av_from_attr(u8 port_num, struct rxe_av *av,
 		     struct rdma_ah_attr *attr);
 void rxe_av_to_attr(struct rxe_av *av, struct rdma_ah_attr *attr);
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 28e379c108bc..c28005db032d 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -456,11 +456,11 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 			goto err1;
 	}
 
-	if (mask & IB_QP_AV && rxe_av_chk_attr(qp, &attr->ah_attr))
+	if (mask & IB_QP_AV && rxe_chk_ah_attr(rxe, &attr->ah_attr))
 		goto err1;
 
 	if (mask & IB_QP_ALT_PATH) {
-		if (rxe_av_chk_attr(qp, &attr->alt_ah_attr))
+		if (rxe_chk_ah_attr(rxe, &attr->alt_ah_attr))
 			goto err1;
 		if (!rdma_is_port_valid(&rxe->ib_dev, attr->alt_port_num))  {
 			rxe_dbg_qp(qp, "invalid alt port %d\n", attr->alt_port_num);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 48f86839d36a..6706d540f1f6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -286,7 +286,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	/* create index > 0 */
 	ah->ah_num = ah->elem.index;
 
-	err = rxe_ah_chk_attr(ah, init_attr->ah_attr);
+	err = rxe_chk_ah_attr(rxe, init_attr->ah_attr);
 	if (err) {
 		rxe_dbg_ah(ah, "bad attr");
 		goto err_cleanup;
@@ -322,10 +322,11 @@ static int rxe_create_ah(struct ib_ah *ibah,
 
 static int rxe_modify_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr)
 {
+	struct rxe_dev *rxe = to_rdev(ibah->device);
 	struct rxe_ah *ah = to_rah(ibah);
 	int err;
 
-	err = rxe_ah_chk_attr(ah, attr);
+	err = rxe_chk_ah_attr(rxe, attr);
 	if (err) {
 		rxe_dbg_ah(ah, "bad attr");
 		goto err_out;
-- 
2.40.1


