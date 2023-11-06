Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5E37E28AE
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 16:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjKFP35 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Nov 2023 10:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjKFP35 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Nov 2023 10:29:57 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2821100
        for <linux-rdma@vger.kernel.org>; Mon,  6 Nov 2023 07:29:50 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1f03db0a410so2888390fac.1
        for <linux-rdma@vger.kernel.org>; Mon, 06 Nov 2023 07:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699284590; x=1699889390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QktSggJLQcetld8uakFuhfIq2ygrmNPQ2pKu14TqlYs=;
        b=ZSMcvQRYcV2GdFNL5omR09wuUOykB80UxPrF5plOezmpaSXlu5762XqcOoOrK2HUyr
         YfPlc/GDCRuvRfzMgEn19OFi+Ar/ZpWgp4BXlvs4YS6NnqB5Re/emjnVjvZGcqBctKwe
         L43+19ghMnIF1naVC5cnXDTnzV+GVHoox8ab75aVj82ipxgkd7eedAlBIHM2vWkz6S1A
         tpD+CaFKg1gWQrnaFFLvm5SzhF4FPjSJ0XeF1TmcjqRGZCrFXDlMIQuaoT/tOijUfIVn
         jsjIkBekY/013NU0b4gf5iglpt8Qgss30w6gtokBlm4YYyvuse4jTy++StSVj3iJTo+C
         zcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699284590; x=1699889390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QktSggJLQcetld8uakFuhfIq2ygrmNPQ2pKu14TqlYs=;
        b=DyD3gKPgDrF4KakPBjSIyuHr79duE5OheX/RnyrCsZ9WyPi9W2iRMYFTaSSK1CzP6U
         mG84DHzhuAjQtT4xFPcDuDcVR0oWZsHY1Gstcq7eLeyNpv+5byTJNuZ+cvkpJj2zZQee
         oMEAon4pgKkHjEE/M4r5GKjUcoJpGGLtaEgyukmiHxqSA/TyoggwkKzWw5U5IfiWWe/X
         B/dwZg4MmdhbER7LmsyFmmeauQiJFohcaPYyJJWvCP/+DO7lNdGCpr/EmzIasFe6hmvW
         mzZLtncLGjaoKeBGh87TS5Ax3GWeswgx4E6nSI0Lc/EG2qCZBMrxS0Tyla/lzfAHwM0n
         auGw==
X-Gm-Message-State: AOJu0Yydst2N8meuENdBcI9y2o+aki1MpDg19YQxzapwHg80fcWswL2i
        OUQzw15STmpJ7/2Yx7R465c=
X-Google-Smtp-Source: AGHT+IFfE4lLQaQHmKtK5udYYLta6RInR8A8l05lMtE8sEXd2qPYk8Ry40VujwoetHv9QILlfWN2Vw==
X-Received: by 2002:a05:6870:a3cd:b0:1ea:2506:3e90 with SMTP id h13-20020a056870a3cd00b001ea25063e90mr4836oak.35.1699284590092;
        Mon, 06 Nov 2023 07:29:50 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-7d5a-f32b-d7fe-f16c.res6.spectrum.com. [2603:8081:1405:679b:7d5a:f32b:d7fe:f16c])
        by smtp.gmail.com with ESMTPSA id ds50-20020a0568705b3200b001e578de89cesm1438897oab.37.2023.11.06.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 07:29:49 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 1/6] RDMA/rxe: Cleanup rxe_ah/av_chk_attr
Date:   Mon,  6 Nov 2023 09:29:24 -0600
Message-Id: <20231106152928.47869-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231106152928.47869-1-rpearsonhpe@gmail.com>
References: <20231106152928.47869-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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

