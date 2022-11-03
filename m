Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEF46185E1
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiKCRLt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiKCRKs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:48 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABB7129
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:47 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r76so2605582oie.13
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRLbWGyzppaEcg12JplsRCjTGKb3cs8GwAQSVdceh6o=;
        b=A6B6SyDV4T3A4yKYlNcydyo5JmdBoXs7KOecEfs+3e3Rlv74EVc85OG4a4Qvs4XSCS
         GZ+g/UR4e/9FeGcGL/jSUzP9Gpq2Dl6SwvvIMBfJCKlmiO1U2qnaiRn6DRM8bKhG9Ozh
         qSY6W7xqktcAmfev9ChNL1pHjoiRKCHR2QS3gPmwZe9WDNR2fwdWhH2m37Cp9MGyf8fW
         7Ux6F0PJjKqyV2tWQ08SJ/GZ3s5uKaRfwyl/Moi56PH9TzfBx9AiF7pHYpf0jWaYSR6z
         /meo4okQ/z0cv2znU26lute4+Ss5B/ruuFsU04eidBfyQzakGB0nPk8iv9y/i8HUHeIy
         EFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRLbWGyzppaEcg12JplsRCjTGKb3cs8GwAQSVdceh6o=;
        b=0lRZXCVsJTjgMcBcrWuSHJvcRgV4YuUKjs3tuW4VZoxiYu851v5dDLEA3UtAF5VeHP
         dkwTXRr03irgc5H/8+afTSrKXEfkOvgMgBYOOCZgSgk0NFsMLC8qqiJ6X4slyX1FREXz
         ugzunm5XBVT6opmRQi4LTjzDXl3tXIlFYNA1oZgQ2SREE0s7POxUgXWRezJ/fqoJQXrd
         KYHSqogJXhvIJELdl3grGk7MwSyMoKZLWc5H6U9caSJEN/4mHkUOiGFJxLESsy940bBG
         hBtXz9eBo73y7uePonR8/4CCCD++ZvUOO96bL98dryJQyXmfH70NKdTIcywV6veBLLVJ
         0pUw==
X-Gm-Message-State: ACrzQf08feg8JnOn13M8PYGbMh2nrkTKOp3g4ckGWV9nMHyCBMrxYlFC
        v9TeJKED5FPzJZWbFR+tL/0=
X-Google-Smtp-Source: AMsMyM5mO63eqm1gEcXG/aTgx6T7RbRLfHTIC4owyRSPwO/7cuavBapyVAq0SUZ94+diealelk9bBw==
X-Received: by 2002:a05:6808:f01:b0:354:2d95:3f96 with SMTP id m1-20020a0568080f0100b003542d953f96mr16037548oiw.41.1667495446780;
        Thu, 03 Nov 2022 10:10:46 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:46 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 12/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_av.c
Date:   Thu,  3 Nov 2022 12:10:10 -0500
Message-Id: <20221103171013.20659-13-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103171013.20659-1-rpearsonhpe@gmail.com>
References: <20221103171013.20659-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace calls to pr_xxx() in rxe_av.c with rxe_dbg_xxx().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c    | 43 ++++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_loc.h   |  8 ++---
 drivers/infiniband/sw/rxe/rxe_qp.c    |  4 +--
 drivers/infiniband/sw/rxe/rxe_verbs.c | 13 ++++----
 4 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 3b05314ca739..889d7adbd455 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -14,26 +14,45 @@ void rxe_init_av(struct rdma_ah_attr *attr, struct rxe_av *av)
 	memcpy(av->dmac, attr->roce.dmac, ETH_ALEN);
 }
 
-int rxe_av_chk_attr(struct rxe_dev *rxe, struct rdma_ah_attr *attr)
+static int chk_attr(void *obj, struct rdma_ah_attr *attr, bool obj_is_ah)
 {
 	const struct ib_global_route *grh = rdma_ah_read_grh(attr);
 	struct rxe_port *port;
+	struct rxe_dev *rxe;
+	struct rxe_qp *qp;
+	struct rxe_ah *ah;
 	int type;
 
+	if (obj_is_ah) {
+		ah = obj;
+		rxe = to_rdev(ah->ibah.device);
+	} else {
+		qp = obj;
+		rxe = to_rdev(qp->ibqp.device);
+	}
+
 	port = &rxe->port;
 
 	if (rdma_ah_get_ah_flags(attr) & IB_AH_GRH) {
 		if (grh->sgid_index > port->attr.gid_tbl_len) {
-			pr_warn("invalid sgid index = %d\n",
-					grh->sgid_index);
+			if (obj_is_ah)
+				rxe_dbg_ah(ah, "invalid sgid index = %d\n",
+						grh->sgid_index);
+			else
+				rxe_dbg_qp(qp, "invalid sgid index = %d\n",
+						grh->sgid_index);
 			return -EINVAL;
 		}
 
 		type = rdma_gid_attr_network_type(grh->sgid_attr);
 		if (type < RDMA_NETWORK_IPV4 ||
 		    type > RDMA_NETWORK_IPV6) {
-			pr_warn("invalid network type for rdma_rxe = %d\n",
-					type);
+			if (obj_is_ah)
+				rxe_dbg_ah(ah, "invalid network type for rdma_rxe = %d\n",
+						type);
+			else
+				rxe_dbg_qp(qp, "invalid network type for rdma_rxe = %d\n",
+						type);
 			return -EINVAL;
 		}
 	}
@@ -41,6 +60,16 @@ int rxe_av_chk_attr(struct rxe_dev *rxe, struct rdma_ah_attr *attr)
 	return 0;
 }
 
+int rxe_av_chk_attr(struct rxe_qp *qp, struct rdma_ah_attr *attr)
+{
+	return chk_attr(qp, attr, false);
+}
+
+int rxe_ah_chk_attr(struct rxe_ah *ah, struct rdma_ah_attr *attr)
+{
+	return chk_attr(ah, attr, true);
+}
+
 void rxe_av_from_attr(u8 port_num, struct rxe_av *av,
 		     struct rdma_ah_attr *attr)
 {
@@ -121,12 +150,12 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt, struct rxe_ah **ahp)
 		/* only new user provider or kernel client */
 		ah = rxe_pool_get_index(&pkt->rxe->ah_pool, ah_num);
 		if (!ah) {
-			pr_warn("Unable to find AH matching ah_num\n");
+			rxe_dbg_qp(pkt->qp, "Unable to find AH matching ah_num\n");
 			return NULL;
 		}
 
 		if (rxe_ah_pd(ah) != pkt->qp->pd) {
-			pr_warn("PDs don't match for AH and QP\n");
+			rxe_dbg_qp(pkt->qp, "PDs don't match for AH and QP\n");
 			rxe_put(ah);
 			return NULL;
 		}
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index c2a5c8814a48..a22476d27b38 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -9,16 +9,12 @@
 
 /* rxe_av.c */
 void rxe_init_av(struct rdma_ah_attr *attr, struct rxe_av *av);
-
-int rxe_av_chk_attr(struct rxe_dev *rxe, struct rdma_ah_attr *attr);
-
+int rxe_av_chk_attr(struct rxe_qp *qp, struct rdma_ah_attr *attr);
+int rxe_ah_chk_attr(struct rxe_ah *ah, struct rdma_ah_attr *attr);
 void rxe_av_from_attr(u8 port_num, struct rxe_av *av,
 		     struct rdma_ah_attr *attr);
-
 void rxe_av_to_attr(struct rxe_av *av, struct rdma_ah_attr *attr);
-
 void rxe_av_fill_ip_info(struct rxe_av *av, struct rdma_ah_attr *attr);
-
 struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt, struct rxe_ah **ahp);
 
 /* rxe_cq.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index bcbfe6068b8b..46f6c74ce00e 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -414,11 +414,11 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 	if (mask & IB_QP_CAP && rxe_qp_chk_cap(rxe, &attr->cap, !!qp->srq))
 		goto err1;
 
-	if (mask & IB_QP_AV && rxe_av_chk_attr(rxe, &attr->ah_attr))
+	if (mask & IB_QP_AV && rxe_av_chk_attr(qp, &attr->ah_attr))
 		goto err1;
 
 	if (mask & IB_QP_ALT_PATH) {
-		if (rxe_av_chk_attr(rxe, &attr->alt_ah_attr))
+		if (rxe_av_chk_attr(qp, &attr->alt_ah_attr))
 			goto err1;
 		if (!rdma_is_port_valid(&rxe->ib_dev, attr->alt_port_num))  {
 			rxe_dbg_qp(qp, "invalid alt port %d\n", attr->alt_port_num);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index e6eca21c54e6..025b35bf014e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -172,10 +172,6 @@ static int rxe_create_ah(struct ib_ah *ibah,
 		ah->is_user = false;
 	}
 
-	err = rxe_av_chk_attr(rxe, init_attr->ah_attr);
-	if (err)
-		return err;
-
 	err = rxe_add_to_pool_ah(&rxe->ah_pool, ah,
 			init_attr->flags & RDMA_CREATE_AH_SLEEPABLE);
 	if (err)
@@ -184,6 +180,12 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	/* create index > 0 */
 	ah->ah_num = ah->elem.index;
 
+	err = rxe_ah_chk_attr(ah, init_attr->ah_attr);
+	if (err) {
+		rxe_cleanup(ah);
+		return err;
+	}
+
 	if (uresp) {
 		/* only if new user provider */
 		err = copy_to_user(&uresp->ah_num, &ah->ah_num,
@@ -206,10 +208,9 @@ static int rxe_create_ah(struct ib_ah *ibah,
 static int rxe_modify_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr)
 {
 	int err;
-	struct rxe_dev *rxe = to_rdev(ibah->device);
 	struct rxe_ah *ah = to_rah(ibah);
 
-	err = rxe_av_chk_attr(rxe, attr);
+	err = rxe_ah_chk_attr(ah, attr);
 	if (err)
 		return err;
 
-- 
2.34.1

