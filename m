Return-Path: <linux-rdma+bounces-230-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A0B803EF2
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 21:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069FF1F212B1
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 20:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4839933CC9;
	Mon,  4 Dec 2023 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2DUmMYH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFCC107
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 12:04:11 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-58e31b5b0d0so1229074eaf.3
        for <linux-rdma@vger.kernel.org>; Mon, 04 Dec 2023 12:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701720251; x=1702325051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QktSggJLQcetld8uakFuhfIq2ygrmNPQ2pKu14TqlYs=;
        b=X2DUmMYHwwgg5ignVqTLVxMY4ZR3yqjDXArCGOHVUVRIzHMoNzxdoAREBu6r4mzfm5
         u0gix31LLqAAEk8KO4uHuzVfbbmf9yx3/gDLIbf+K/e0M216ckG6F7UbwtoV738gg8vT
         ZLb8mpMqd1g9cuvZrr/Sno8vFMgmXgS/6x28JXkBDtu+g1Fvlt2V8zk0z86eiSCIVINE
         TGtl/cSyaQkDUYWtOaJ7i/X3TSqn/EJGpHYgJ6i1oycjLJQKmKc37iBdiHNi6+SFGH2f
         KhY/1+7vAKeQpKgCQC9a7/GlO6XEXzFNo65PrSEhc81p4Sc7SkKbTJYmY0hs2IWpKr0n
         id4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720251; x=1702325051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QktSggJLQcetld8uakFuhfIq2ygrmNPQ2pKu14TqlYs=;
        b=Fki0Xucje3fJDuBbQYWsqAuolbHSIoV1RSAqkf1w2/kZLMuf4BfeJFd2ev8Gy3ELmS
         5gb6vzY2P/yv3kdhMm6bpVwdXwDdNcPQ0Db4Rv00Qo7cBAIS4EizaGaDw4YoBj5lrYpM
         5nyejyTCYRKOCeGcMFRQtes44T0CaED2FQaZxliFU45Msb4KIpUVmr8cIwMKv6AQCk0z
         SyHpuSWB/BseOkP9Rd3lP1jIzqkU+5nBXXUCmNtAA40wP5W/pgxnjAAGY3faaCzUvLMP
         mKUu4Dm8ujPXc43/aAdAdXt4d96/WGMdnonmJAGBtyhs8Ii50sbt7FIgroPsLiLLwOfv
         /pyQ==
X-Gm-Message-State: AOJu0Yw/Q2oiYlQKR5fsYamcQM+TwEOdto8PQ+2FQIcTDnv8hYUtCliQ
	bFZdUaLzkVmc4Fmw+1LEpdG/SPNFs/E=
X-Google-Smtp-Source: AGHT+IFb+WeziVhehheme5gmoLPhPm7n44TQoOIpdlMpoP47YqTHRHGuCihEV7cdisfhk7bR967gjw==
X-Received: by 2002:a05:6820:515:b0:58d:6217:795e with SMTP id m21-20020a056820051500b0058d6217795emr3215475ooj.8.1701720249662;
        Mon, 04 Dec 2023 12:04:09 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-e463-fe8f-1aa8-6edb.res6.spectrum.com. [2603:8081:1405:679b:e463:fe8f:1aa8:6edb])
        by smtp.gmail.com with ESMTPSA id e72-20020a4a554b000000b0054f85f67f31sm537281oob.46.2023.12.04.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:04:08 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 1/7] RDMA/rxe: Cleanup rxe_ah/av_chk_attr
Date: Mon,  4 Dec 2023 14:03:37 -0600
Message-Id: <20231204200342.7125-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204200342.7125-1-rpearsonhpe@gmail.com>
References: <20231204200342.7125-1-rpearsonhpe@gmail.com>
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


