Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429DE6AA440
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Mar 2023 23:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjCCWZb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Mar 2023 17:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjCCWZL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Mar 2023 17:25:11 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BE481F96
        for <linux-rdma@vger.kernel.org>; Fri,  3 Mar 2023 14:17:40 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id e12-20020a4ae0cc000000b00525034ca5e9so686766oot.0
        for <linux-rdma@vger.kernel.org>; Fri, 03 Mar 2023 14:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677881808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfn4as6N1cuuZrRkFOkpt/A3kT/mFo9kmURYG14S21M=;
        b=XhKREZu4zWWnKXe7K9YAhCUxhY7dfKLM++ctWu8CUfSDiqeNVCCR+iFMNza9KCVheu
         0e3hJbqAl5mVhaSmF9pRd1gmD4mLAyCYizw6vofGagHiOVPXvIH+p726nQ2DkTVrET3t
         w6uI/H1AL/VXf0DPkeufU19SMKJa6k6soBNXKBZdISpGtVqT8afMA5XJkFoF5wU69F64
         j/vXSSQsz5Ton6Ir7uKEa+dV7MT90XdV5fd/j9BHTpEWByqWZEJgBjasjFTyWAEZipab
         OMLoFNWfe6zzt9uvoNsTvz3vWaMI7DmEAxz5NiINL///xDcNzqF3MFJIf4pQNz8f1uTs
         51/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677881808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfn4as6N1cuuZrRkFOkpt/A3kT/mFo9kmURYG14S21M=;
        b=dWt2sieAQbmWwdSmN7ibelrUmWrImdsmjjYLHYo4pD3NLcUAHqDFoZOnX9OesqdslT
         1fK/wp3/pKl4ZfvI++T2+uliB3YVYZLOMWGQQ7xvhBZpDi+Js6Wey+ZEkZPrpq2XHv90
         UpfZm+iIFbA3T/O0IhKbUNGSHXRx/ImzG1WmGF+V3qV3jwEdw4TliXFWS6Z7aoydB3mG
         nTuWUx/nXLJfr4qrE0pAy0+SSgbpeQ14P8Ki78swEw0vZkLJ1seqbtwl3ePR0IgrzpnO
         nhWEVbMT0EuWTPTrmGDt/DF8qcAD8VtH8DpFVSKFOqOy6ElKHJN9ogZj7D9L5UuxDgGa
         +Mgg==
X-Gm-Message-State: AO0yUKWZIzcHB9bq5qrUgdF1rbrzLjZXJSFRUeBXgu5FTshELq8oZPsE
        8eJ5IRkM0CBjX/eYV9GAYJoCe9bxQ2Y=
X-Google-Smtp-Source: AK7set9SI1w17gOcsQnRpGKhkTV+ex23wixy9yo4L/+2LTqG3ZEHIfVjr4ytUqR8J+0RCRdQVd4qBg==
X-Received: by 2002:a4a:b78c:0:b0:525:2d37:5335 with SMTP id a12-20020a4ab78c000000b005252d375335mr1716037oop.8.1677881808077;
        Fri, 03 Mar 2023 14:16:48 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-de65-7c8e-0940-8c68.res6.spectrum.com. [2603:8081:140c:1a00:de65:7c8e:940:8c68])
        by smtp.gmail.com with ESMTPSA id zd34-20020a05687127a200b001730afaeb63sm1480740oab.19.2023.03.03.14.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 14:16:47 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 4/4] RDMA/rxe: Add error messages
Date:   Fri,  3 Mar 2023 16:16:24 -0600
Message-Id: <20230303221623.8053-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303221623.8053-1-rpearsonhpe@gmail.com>
References: <20230303221623.8053-1-rpearsonhpe@gmail.com>
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

This patch adds error and debug messages so that every interaction
with rdma-core through a verbs API call or a completion error return
will generate at least one error message backed up by debug messages
with more detail.

With dynamic debugging one can follow up after seeing an error message
by turning on the appropriate debug messages.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |   4 +
 drivers/infiniband/sw/rxe/rxe_loc.h   |   1 -
 drivers/infiniband/sw/rxe/rxe_mr.c    |  13 -
 drivers/infiniband/sw/rxe/rxe_resp.c  |   4 +
 drivers/infiniband/sw/rxe/rxe_verbs.c | 828 +++++++++++++++++++-------
 5 files changed, 609 insertions(+), 241 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 20737fec392b..876057e3ee3c 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -428,6 +428,10 @@ static void make_send_cqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 				uwc->wc_flags = IB_WC_WITH_IMM;
 			uwc->byte_len = wqe->dma.length;
 		}
+	} else {
+		if (wqe->status != IB_WC_WR_FLUSH_ERR)
+			rxe_err_qp(qp, "non-flush error status = %d",
+				wqe->status);
 	}
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 1bb0cb479eb1..839de34cf4c9 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -80,7 +80,6 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 int rxe_invalidate_mr(struct rxe_qp *qp, u32 key);
 int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
-int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
 void rxe_mr_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_mw.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index b10aa1580a64..1e17f8086d59 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -722,19 +722,6 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	return 0;
 }
 
-int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
-{
-	struct rxe_mr *mr = to_rmr(ibmr);
-
-	/* See IBA 10.6.7.2.6 */
-	if (atomic_read(&mr->num_mw) > 0)
-		return -EINVAL;
-
-	rxe_cleanup(mr);
-	kfree_rcu(mr);
-	return 0;
-}
-
 void rxe_mr_cleanup(struct rxe_pool_elem *elem)
 {
 	struct rxe_mr *mr = container_of(elem, typeof(*mr), elem);
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 0cc1ba91d48c..4217eec03a94 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1151,6 +1151,10 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 
 			wc->port_num		= qp->attr.port_num;
 		}
+	} else {
+		if (wc->status != IB_WC_WR_FLUSH_ERR)
+			rxe_err_qp(qp, "non-flush error status = %d",
+				wc->status);
 	}
 
 	/* have copy for srq and reference for !srq */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index f178d0773ff2..84b53c070fc5 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -12,31 +12,48 @@
 #include "rxe_queue.h"
 #include "rxe_hw_counters.h"
 
-static int rxe_query_device(struct ib_device *dev,
+static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr);
+
+/* dev */
+static int rxe_query_device(struct ib_device *ibdev,
 			    struct ib_device_attr *attr,
-			    struct ib_udata *uhw)
+			    struct ib_udata *udata)
 {
-	struct rxe_dev *rxe = to_rdev(dev);
+	struct rxe_dev *rxe = to_rdev(ibdev);
+	int err;
+
+	if (udata->inlen || udata->outlen) {
+		rxe_dbg_dev(rxe, "malformed udata");
+		err = -EINVAL;
+		goto err_out;
+	}
 
-	if (uhw->inlen || uhw->outlen)
-		return -EINVAL;
+	memcpy(attr, &rxe->attr, sizeof(*attr));
 
-	*attr = rxe->attr;
 	return 0;
+
+err_out:
+	rxe_err_dev(rxe, "returned err = %d", err);
+	return err;
 }
 
-static int rxe_query_port(struct ib_device *dev,
+static int rxe_query_port(struct ib_device *ibdev,
 			  u32 port_num, struct ib_port_attr *attr)
 {
-	struct rxe_dev *rxe = to_rdev(dev);
-	int rc;
+	struct rxe_dev *rxe = to_rdev(ibdev);
+	int err, ret;
 
-	/* *attr being zeroed by the caller, avoid zeroing it here */
-	*attr = rxe->port.attr;
+	if (port_num != 1) {
+		err = -EINVAL;
+		rxe_dbg_dev(rxe, "bad port_num = %d", port_num);
+		goto err_out;
+	}
+
+	memcpy(attr, &rxe->port.attr, sizeof(*attr));
 
 	mutex_lock(&rxe->usdev_lock);
-	rc = ib_get_eth_speed(dev, port_num, &attr->active_speed,
-			      &attr->active_width);
+	ret = ib_get_eth_speed(ibdev, port_num, &attr->active_speed,
+			       &attr->active_width);
 
 	if (attr->state == IB_PORT_ACTIVE)
 		attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
@@ -47,27 +64,45 @@ static int rxe_query_port(struct ib_device *dev,
 
 	mutex_unlock(&rxe->usdev_lock);
 
-	return rc;
+	return ret;
+
+err_out:
+	rxe_err_dev(rxe, "returned err = %d", err);
+	return err;
 }
 
-static int rxe_query_pkey(struct ib_device *device,
+static int rxe_query_pkey(struct ib_device *ibdev,
 			  u32 port_num, u16 index, u16 *pkey)
 {
-	if (index > 0)
-		return -EINVAL;
+	struct rxe_dev *rxe = to_rdev(ibdev);
+	int err;
+
+	if (index != 0) {
+		err = -EINVAL;
+		rxe_dbg_dev(rxe, "bad pkey index = %d", index);
+		goto err_out;
+	}
 
 	*pkey = IB_DEFAULT_PKEY_FULL;
 	return 0;
+
+err_out:
+	rxe_err_dev(rxe, "returned err = %d", err);
+	return err;
 }
 
-static int rxe_modify_device(struct ib_device *dev,
+static int rxe_modify_device(struct ib_device *ibdev,
 			     int mask, struct ib_device_modify *attr)
 {
-	struct rxe_dev *rxe = to_rdev(dev);
+	struct rxe_dev *rxe = to_rdev(ibdev);
+	int err;
 
 	if (mask & ~(IB_DEVICE_MODIFY_SYS_IMAGE_GUID |
-		     IB_DEVICE_MODIFY_NODE_DESC))
-		return -EOPNOTSUPP;
+		     IB_DEVICE_MODIFY_NODE_DESC)) {
+		err = -EOPNOTSUPP;
+		rxe_dbg_dev(rxe, "unsupported mask = 0x%x", mask);
+		goto err_out;
+	}
 
 	if (mask & IB_DEVICE_MODIFY_SYS_IMAGE_GUID)
 		rxe->attr.sys_image_guid = cpu_to_be64(attr->sys_image_guid);
@@ -78,16 +113,33 @@ static int rxe_modify_device(struct ib_device *dev,
 	}
 
 	return 0;
+
+err_out:
+	rxe_err_dev(rxe, "returned err = %d", err);
+	return err;
 }
 
-static int rxe_modify_port(struct ib_device *dev,
-			   u32 port_num, int mask, struct ib_port_modify *attr)
+static int rxe_modify_port(struct ib_device *ibdev, u32 port_num,
+			   int mask, struct ib_port_modify *attr)
 {
-	struct rxe_dev *rxe = to_rdev(dev);
+	struct rxe_dev *rxe = to_rdev(ibdev);
 	struct rxe_port *port;
+	int err;
 
-	port = &rxe->port;
+	if (port_num != 1) {
+		err = -EINVAL;
+		rxe_dbg_dev(rxe, "bad port_num = %d", port_num);
+		goto err_out;
+	}
 
+	//TODO is shutdown useful
+	if (mask & ~(IB_PORT_RESET_QKEY_CNTR)) {
+		err = -EOPNOTSUPP;
+		rxe_dbg_dev(rxe, "unsupported mask = 0x%x", mask);
+		goto err_out;
+	}
+
+	port = &rxe->port;
 	port->attr.port_cap_flags |= attr->set_port_cap_mask;
 	port->attr.port_cap_flags &= ~attr->clr_port_cap_mask;
 
@@ -95,73 +147,125 @@ static int rxe_modify_port(struct ib_device *dev,
 		port->attr.qkey_viol_cntr = 0;
 
 	return 0;
-}
 
-static enum rdma_link_layer rxe_get_link_layer(struct ib_device *dev,
-					       u32 port_num)
-{
-	return IB_LINK_LAYER_ETHERNET;
+err_out:
+	rxe_err_dev(rxe, "returned err = %d", err);
+	return err;
 }
 
-static int rxe_alloc_ucontext(struct ib_ucontext *ibuc, struct ib_udata *udata)
+static enum rdma_link_layer rxe_get_link_layer(struct ib_device *ibdev,
+					       u32 port_num)
 {
-	struct rxe_dev *rxe = to_rdev(ibuc->device);
-	struct rxe_ucontext *uc = to_ruc(ibuc);
+	struct rxe_dev *rxe = to_rdev(ibdev);
+	int err;
 
-	return rxe_add_to_pool(&rxe->uc_pool, uc);
-}
+	if (port_num != 1) {
+		err = -EINVAL;
+		rxe_dbg_dev(rxe, "bad port_num = %d", port_num);
+		goto err_out;
+	}
 
-static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
-{
-	struct rxe_ucontext *uc = to_ruc(ibuc);
+	return IB_LINK_LAYER_ETHERNET;
 
-	rxe_cleanup(uc);
+err_out:
+	rxe_err_dev(rxe, "returned err = %d", err);
+	return err;
 }
 
-static int rxe_port_immutable(struct ib_device *dev, u32 port_num,
+static int rxe_port_immutable(struct ib_device *ibdev, u32 port_num,
 			      struct ib_port_immutable *immutable)
 {
+	struct rxe_dev *rxe = to_rdev(ibdev);
+	struct ib_port_attr attr = {};
 	int err;
-	struct ib_port_attr attr;
 
-	immutable->core_cap_flags = RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
+	if (port_num != 1) {
+		err = -EINVAL;
+		rxe_dbg_dev(rxe, "bad port_num = %d", port_num);
+		goto err_out;
+	}
 
-	err = ib_query_port(dev, port_num, &attr);
+	err = ib_query_port(ibdev, port_num, &attr);
 	if (err)
-		return err;
+		goto err_out;
 
+	immutable->core_cap_flags = RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
 	immutable->pkey_tbl_len = attr.pkey_tbl_len;
 	immutable->gid_tbl_len = attr.gid_tbl_len;
 	immutable->max_mad_size = IB_MGMT_MAD_SIZE;
 
 	return 0;
+
+err_out:
+	rxe_err_dev(rxe, "returned err = %d", err);
+	return err;
 }
 
+/* uc */
+static int rxe_alloc_ucontext(struct ib_ucontext *ibuc, struct ib_udata *udata)
+{
+	struct rxe_dev *rxe = to_rdev(ibuc->device);
+	struct rxe_ucontext *uc = to_ruc(ibuc);
+	int err;
+
+	err = rxe_add_to_pool(&rxe->uc_pool, uc);
+	if (err)
+		rxe_err_dev(rxe, "unable to create uc");
+
+	return err;
+}
+
+static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
+{
+	struct rxe_ucontext *uc = to_ruc(ibuc);
+	int err;
+
+	err = rxe_cleanup(uc);
+	if (err)
+		rxe_err_uc(uc, "cleanup failed, err = %d", err);
+}
+
+/* pd */
 static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
+	int err;
+
+	err = rxe_add_to_pool(&rxe->pd_pool, pd);
+	if (err) {
+		rxe_dbg_dev(rxe, "unable to alloc pd");
+		goto err_out;
+	}
 
-	return rxe_add_to_pool(&rxe->pd_pool, pd);
+	return 0;
+
+err_out:
+	rxe_err_dev(rxe, "returned err = %d", err);
+	return err;
 }
 
 static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct rxe_pd *pd = to_rpd(ibpd);
+	int err;
+
+	err = rxe_cleanup(pd);
+	if (err)
+		rxe_err_pd(pd, "cleanup failed, err = %d", err);
 
-	rxe_cleanup(pd);
 	return 0;
 }
 
+/* ah */
 static int rxe_create_ah(struct ib_ah *ibah,
 			 struct rdma_ah_init_attr *init_attr,
 			 struct ib_udata *udata)
-
 {
 	struct rxe_dev *rxe = to_rdev(ibah->device);
 	struct rxe_ah *ah = to_rah(ibah);
 	struct rxe_create_ah_resp __user *uresp = NULL;
-	int err;
+	int err, cleanup_err;
 
 	if (udata) {
 		/* test if new user provider */
@@ -174,16 +278,18 @@ static int rxe_create_ah(struct ib_ah *ibah,
 
 	err = rxe_add_to_pool_ah(&rxe->ah_pool, ah,
 			init_attr->flags & RDMA_CREATE_AH_SLEEPABLE);
-	if (err)
-		return err;
+	if (err) {
+		rxe_dbg_dev(rxe, "unable to create ah");
+		goto err_out;
+	}
 
 	/* create index > 0 */
 	ah->ah_num = ah->elem.index;
 
 	err = rxe_ah_chk_attr(ah, init_attr->ah_attr);
 	if (err) {
-		rxe_cleanup(ah);
-		return err;
+		rxe_dbg_ah(ah, "bad attr");
+		goto err_cleanup;
 	}
 
 	if (uresp) {
@@ -191,8 +297,9 @@ static int rxe_create_ah(struct ib_ah *ibah,
 		err = copy_to_user(&uresp->ah_num, &ah->ah_num,
 					 sizeof(uresp->ah_num));
 		if (err) {
-			rxe_cleanup(ah);
-			return -EFAULT;
+			err = -EFAULT;
+			rxe_dbg_ah(ah, "unable to copy to user");
+			goto err_cleanup;
 		}
 	} else if (ah->is_user) {
 		/* only if old user provider */
@@ -203,19 +310,34 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	rxe_finalize(ah);
 
 	return 0;
+
+err_cleanup:
+	cleanup_err = rxe_cleanup(ah);
+	if (cleanup_err)
+		rxe_err_ah(ah, "cleanup failed, err = %d", cleanup_err);
+err_out:
+	rxe_err_ah(ah, "returned err = %d", err);
+	return err;
 }
 
 static int rxe_modify_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr)
 {
-	int err;
 	struct rxe_ah *ah = to_rah(ibah);
+	int err;
 
 	err = rxe_ah_chk_attr(ah, attr);
-	if (err)
-		return err;
+	if (err) {
+		rxe_dbg_ah(ah, "bad attr");
+		goto err_out;
+	}
 
 	rxe_init_av(attr, &ah->av);
+
 	return 0;
+
+err_out:
+	rxe_err_ah(ah, "returned err = %d", err);
+	return err;
 }
 
 static int rxe_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr)
@@ -225,92 +347,77 @@ static int rxe_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr)
 	memset(attr, 0, sizeof(*attr));
 	attr->type = ibah->type;
 	rxe_av_to_attr(&ah->av, attr);
+
 	return 0;
 }
 
 static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
+	int err;
 
-	rxe_cleanup_ah(ah, flags & RDMA_DESTROY_AH_SLEEPABLE);
-
-	return 0;
-}
-
-static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
-{
-	int i;
-	u32 length;
-	struct rxe_recv_wqe *recv_wqe;
-	int num_sge = ibwr->num_sge;
-	int full;
-
-	full = queue_full(rq->queue, QUEUE_TYPE_FROM_ULP);
-	if (unlikely(full))
-		return -ENOMEM;
-
-	if (unlikely(num_sge > rq->max_sge))
-		return -EINVAL;
-
-	length = 0;
-	for (i = 0; i < num_sge; i++)
-		length += ibwr->sg_list[i].length;
-
-	recv_wqe = queue_producer_addr(rq->queue, QUEUE_TYPE_FROM_ULP);
-	recv_wqe->wr_id = ibwr->wr_id;
-
-	memcpy(recv_wqe->dma.sge, ibwr->sg_list,
-	       num_sge * sizeof(struct ib_sge));
-
-	recv_wqe->dma.length		= length;
-	recv_wqe->dma.resid		= length;
-	recv_wqe->dma.num_sge		= num_sge;
-	recv_wqe->dma.cur_sge		= 0;
-	recv_wqe->dma.sge_offset	= 0;
-
-	queue_advance_producer(rq->queue, QUEUE_TYPE_FROM_ULP);
+	err = rxe_cleanup_ah(ah, flags & RDMA_DESTROY_AH_SLEEPABLE);
+	if (err)
+		rxe_err_ah(ah, "cleanup failed, err = %d", err);
 
 	return 0;
 }
 
+/* srq */
 static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 			  struct ib_udata *udata)
 {
-	int err;
 	struct rxe_dev *rxe = to_rdev(ibsrq->device);
 	struct rxe_pd *pd = to_rpd(ibsrq->pd);
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 	struct rxe_create_srq_resp __user *uresp = NULL;
+	int err, cleanup_err;
 
 	if (udata) {
-		if (udata->outlen < sizeof(*uresp))
-			return -EINVAL;
+		if (udata->outlen < sizeof(*uresp)) {
+			err = -EINVAL;
+			rxe_err_dev(rxe, "malformed udata");
+			goto err_out;
+		}
 		uresp = udata->outbuf;
 	}
 
-	if (init->srq_type != IB_SRQT_BASIC)
-		return -EOPNOTSUPP;
+	if (init->srq_type != IB_SRQT_BASIC) {
+		err = -EOPNOTSUPP;
+		rxe_dbg_dev(rxe, "srq type = %d, not supported",
+				init->srq_type);
+		goto err_out;
+	}
 
 	err = rxe_srq_chk_init(rxe, init);
-	if (err)
-		return err;
+	if (err) {
+		rxe_dbg_dev(rxe, "invalid init attributes");
+		goto err_out;
+	}
 
 	err = rxe_add_to_pool(&rxe->srq_pool, srq);
-	if (err)
-		return err;
+	if (err) {
+		rxe_dbg_dev(rxe, "unable to create srq, err = %d", err);
+		goto err_out;
+	}
 
 	rxe_get(pd);
 	srq->pd = pd;
 
 	err = rxe_srq_from_init(rxe, srq, init, udata, uresp);
-	if (err)
+	if (err) {
+		rxe_dbg_srq(srq, "create srq failed, err = %d", err);
 		goto err_cleanup;
+	}
 
 	return 0;
 
 err_cleanup:
-	rxe_cleanup(srq);
-
+	cleanup_err = rxe_cleanup(srq);
+	if (cleanup_err)
+		rxe_err_srq(srq, "cleanup failed, err = %d", cleanup_err);
+err_out:
+	rxe_err_dev(rxe, "returned err = %d", err);
 	return err;
 }
 
@@ -318,46 +425,64 @@ static int rxe_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
 			  enum ib_srq_attr_mask mask,
 			  struct ib_udata *udata)
 {
-	int err;
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 	struct rxe_dev *rxe = to_rdev(ibsrq->device);
-	struct rxe_modify_srq_cmd ucmd = {};
+	struct rxe_modify_srq_cmd cmd = {};
+	int err;
 
 	if (udata) {
-		if (udata->inlen < sizeof(ucmd))
-			return -EINVAL;
+		if (udata->inlen < sizeof(cmd)) {
+			err = -EINVAL;
+			rxe_dbg_srq(srq, "malformed udata");
+			goto err_out;
+		}
 
-		err = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
-		if (err)
-			return err;
+		err = ib_copy_from_udata(&cmd, udata, sizeof(cmd));
+		if (err) {
+			err = -EFAULT;
+			rxe_dbg_srq(srq, "unable to read udata");
+			goto err_out;
+		}
 	}
 
 	err = rxe_srq_chk_attr(rxe, srq, attr, mask);
-	if (err)
-		return err;
+	if (err) {
+		rxe_dbg_srq(srq, "bad init attributes");
+		goto err_out;
+	}
+
+	err = rxe_srq_from_attr(rxe, srq, attr, mask, &cmd, udata);
+	if (err) {
+		rxe_dbg_srq(srq, "bad attr");
+		goto err_out;
+	}
+
+	return 0;
 
-	return rxe_srq_from_attr(rxe, srq, attr, mask, &ucmd, udata);
+err_out:
+	rxe_err_srq(srq, "returned err = %d", err);
+	return err;
 }
 
 static int rxe_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 {
 	struct rxe_srq *srq = to_rsrq(ibsrq);
+	int err;
 
-	if (srq->error)
-		return -EINVAL;
+	if (srq->error) {
+		err = -EINVAL;
+		rxe_dbg_srq(srq, "srq in error state");
+		goto err_out;
+	}
 
 	attr->max_wr = srq->rq.queue->buf->index_mask;
 	attr->max_sge = srq->rq.max_sge;
 	attr->srq_limit = srq->limit;
 	return 0;
-}
-
-static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
-{
-	struct rxe_srq *srq = to_rsrq(ibsrq);
 
-	rxe_cleanup(srq);
-	return 0;
+err_out:
+	rxe_err_srq(srq, "returned err = %d", err);
+	return err;
 }
 
 static int rxe_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
@@ -378,76 +503,116 @@ static int rxe_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 
 	spin_unlock_irqrestore(&srq->rq.producer_lock, flags);
 
-	if (err)
+	if (err) {
 		*bad_wr = wr;
+		rxe_err_srq(srq, "returned err = %d", err);
+	}
 
 	return err;
 }
 
+static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
+{
+	struct rxe_srq *srq = to_rsrq(ibsrq);
+	int err;
+
+	err = rxe_cleanup(srq);
+	if (err)
+		rxe_err_srq(srq, "cleanup failed, err = %d", err);
+
+	return 0;
+}
+
+/* qp */
 static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 			 struct ib_udata *udata)
 {
-	int err;
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_pd *pd = to_rpd(ibqp->pd);
 	struct rxe_qp *qp = to_rqp(ibqp);
 	struct rxe_create_qp_resp __user *uresp = NULL;
+	int err, cleanup_err;
 
 	if (udata) {
-		if (udata->outlen < sizeof(*uresp))
-			return -EINVAL;
-		uresp = udata->outbuf;
-	}
-
-	if (init->create_flags)
-		return -EOPNOTSUPP;
-
-	err = rxe_qp_chk_init(rxe, init);
-	if (err)
-		return err;
+		if (udata->inlen) {
+			err = -EINVAL;
+			rxe_dbg_dev(rxe, "malformed udata, err = %d", err);
+			goto err_out;
+		}
 
-	if (udata) {
-		if (udata->inlen)
-			return -EINVAL;
+		if (udata->outlen < sizeof(*uresp)) {
+			err = -EINVAL;
+			rxe_dbg_dev(rxe, "malformed udata, err = %d", err);
+			goto err_out;
+		}
 
 		qp->is_user = true;
+		uresp = udata->outbuf;
 	} else {
 		qp->is_user = false;
 	}
 
+	if (init->create_flags) {
+		err = -EOPNOTSUPP;
+		rxe_dbg_dev(rxe, "unsupported create_flags, err = %d", err);
+		goto err_out;
+	}
+
+	err = rxe_qp_chk_init(rxe, init);
+	if (err) {
+		rxe_dbg_dev(rxe, "bad init attr, err = %d", err);
+		goto err_out;
+	}
+
 	err = rxe_add_to_pool(&rxe->qp_pool, qp);
-	if (err)
-		return err;
+	if (err) {
+		rxe_dbg_dev(rxe, "unable to create qp, err = %d", err);
+		goto err_out;
+	}
 
 	err = rxe_qp_from_init(rxe, qp, pd, init, uresp, ibqp->pd, udata);
-	if (err)
-		goto qp_init;
+	if (err) {
+		rxe_dbg_qp(qp, "create qp failed, err = %d", err);
+		goto err_cleanup;
+	}
 
 	rxe_finalize(qp);
 	return 0;
 
-qp_init:
-	rxe_cleanup(qp);
+err_cleanup:
+	cleanup_err = rxe_cleanup(qp);
+	if (cleanup_err)
+		rxe_err_qp(qp, "cleanup failed, err = %d", cleanup_err);
+err_out:
+	rxe_err_dev(rxe, "returned err = %d", err);
 	return err;
 }
 
 static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 			 int mask, struct ib_udata *udata)
 {
-	int err;
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
+	int err;
 
-	if (mask & ~IB_QP_ATTR_STANDARD_BITS)
-		return -EOPNOTSUPP;
+	if (mask & ~IB_QP_ATTR_STANDARD_BITS) {
+		err = -EOPNOTSUPP;
+		rxe_dbg_qp(qp, "unsupported mask = 0x%x, err = %d",
+			   mask, err);
+		goto err_out;
+	}
 
 	err = rxe_qp_chk_attr(rxe, qp, attr, mask);
-	if (err)
-		return err;
+	if (err) {
+		rxe_dbg_qp(qp, "bad mask/attr, err = %d", err);
+		goto err_out;
+	}
 
 	err = rxe_qp_from_attr(qp, attr, mask, udata);
-	if (err)
-		return err;
+	if (err) {
+		rxe_dbg_qp(qp, "modify qp failed, err = %d", err);
+		goto err_out;
+	}
 
 	if ((mask & IB_QP_AV) && (attr->ah_attr.ah_flags & IB_AH_GRH))
 		qp->src_port = rdma_get_udp_sport(attr->ah_attr.grh.flow_label,
@@ -455,6 +620,10 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 						  qp->attr.dest_qp_num);
 
 	return 0;
+
+err_out:
+	rxe_err_qp(qp, "returned err = %d", err);
+	return err;
 }
 
 static int rxe_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
@@ -471,38 +640,59 @@ static int rxe_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
 	struct rxe_qp *qp = to_rqp(ibqp);
-	int ret;
+	int err;
+
+	err = rxe_qp_chk_destroy(qp);
+	if (err) {
+		rxe_dbg_qp(qp, "unable to destroy qp, err = %d", err);
+		goto err_out;
+	}
 
-	ret = rxe_qp_chk_destroy(qp);
-	if (ret)
-		return ret;
+	err = rxe_cleanup(qp);
+	if (err)
+		rxe_err_qp(qp, "cleanup failed, err = %d", err);
 
-	rxe_cleanup(qp);
 	return 0;
+
+err_out:
+	rxe_err_qp(qp, "returned err = %d", err);
+	return err;
 }
 
+/* send wr */
 static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 			    unsigned int mask, unsigned int length)
 {
 	int num_sge = ibwr->num_sge;
 	struct rxe_sq *sq = &qp->sq;
 
-	if (unlikely(num_sge > sq->max_sge))
-		return -EINVAL;
+	if (unlikely(num_sge > sq->max_sge)) {
+		rxe_dbg_qp(qp, "num_sge > max_sge");
+		goto err_out;
+	}
 
 	if (unlikely(mask & WR_ATOMIC_MASK)) {
-		if (length < 8)
-			return -EINVAL;
+		if (length != 8) {
+			rxe_dbg_qp(qp, "atomic length != 8");
+			goto err_out;
+		}
 
-		if (atomic_wr(ibwr)->remote_addr & 0x7)
-			return -EINVAL;
+		if (atomic_wr(ibwr)->remote_addr & 0x7) {
+			rxe_dbg_qp(qp, "misaligned atomic address");
+			goto err_out;
+		}
 	}
 
 	if (unlikely((ibwr->send_flags & IB_SEND_INLINE) &&
-		     (length > sq->max_inline)))
-		return -EINVAL;
+		     (length > sq->max_inline))) {
+		rxe_dbg_qp(qp, "inline length too big");
+		goto err_out;
+	}
 
 	return 0;
+
+err_out:
+	return -EINVAL;
 }
 
 static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
@@ -550,12 +740,12 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 			break;
 		case IB_WR_LOCAL_INV:
 			wr->ex.invalidate_rkey = ibwr->ex.invalidate_rkey;
-		break;
+			break;
 		case IB_WR_REG_MR:
 			wr->wr.reg.mr = reg_wr(ibwr)->mr;
 			wr->wr.reg.key = reg_wr(ibwr)->key;
 			wr->wr.reg.access = reg_wr(ibwr)->access;
-		break;
+			break;
 		default:
 			break;
 		}
@@ -624,9 +814,9 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	spin_lock_irqsave(&qp->sq.sq_lock, flags);
 
 	full = queue_full(sq->queue, QUEUE_TYPE_FROM_ULP);
-
 	if (unlikely(full)) {
 		spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
+		rxe_dbg_qp(qp, "queue full");
 		return -ENOMEM;
 	}
 
@@ -652,6 +842,7 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 	while (wr) {
 		mask = wr_opcode_mask(wr->opcode, qp);
 		if (unlikely(!mask)) {
+			rxe_dbg_qp(qp, "bad wr opcode for qp");
 			err = -EINVAL;
 			*bad_wr = wr;
 			break;
@@ -659,6 +850,7 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 
 		if (unlikely((wr->send_flags & IB_SEND_INLINE) &&
 			     !(mask & WR_INLINE_MASK))) {
+			rxe_dbg_qp(qp, "opcode doesn't support inline data");
 			err = -EINVAL;
 			*bad_wr = wr;
 			break;
@@ -669,17 +861,26 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 		length = 0;
 		for (i = 0; i < wr->num_sge; i++)
 			length += wr->sg_list[i].length;
+		if (length > 1<<31) {
+			err = -EINVAL;
+			rxe_dbg_qp(qp, "message length too long");
+			*bad_wr = wr;
+			break;
+		}
 
 		err = post_one_send(qp, wr, mask, length);
-
 		if (err) {
 			*bad_wr = wr;
 			break;
 		}
+
 		wr = next;
 	}
 
-	rxe_sched_task(&qp->req.task);
+	/* if we didn't post anything there's nothing to do */
+	if (!err)
+		rxe_sched_task(&qp->req.task);
+
 	if (unlikely(qp->req.state == QP_STATE_ERROR))
 		rxe_sched_task(&qp->comp.task);
 
@@ -690,23 +891,90 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			 const struct ib_send_wr **bad_wr)
 {
 	struct rxe_qp *qp = to_rqp(ibqp);
+	int err;
 
 	if (unlikely(!qp->valid)) {
 		*bad_wr = wr;
-		return -EINVAL;
+		err = -EINVAL;
+		rxe_dbg_qp(qp, "qp destroyed");
+		goto err_out;
 	}
 
 	if (unlikely(qp->req.state < QP_STATE_READY)) {
 		*bad_wr = wr;
-		return -EINVAL;
+		err = -EINVAL;
+		rxe_dbg_qp(qp, "qp not ready to send");
+		goto err_out;
 	}
 
 	if (qp->is_user) {
 		/* Utilize process context to do protocol processing */
 		rxe_run_task(&qp->req.task);
-		return 0;
-	} else
-		return rxe_post_send_kernel(qp, wr, bad_wr);
+	} else {
+		err = rxe_post_send_kernel(qp, wr, bad_wr);
+		if (err)
+			goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	rxe_err_qp(qp, "returned err = %d", err);
+	return err;
+}
+
+/* recv wr */
+static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
+{
+	int i;
+	unsigned long length;
+	struct rxe_recv_wqe *recv_wqe;
+	int num_sge = ibwr->num_sge;
+	int full;
+	int err;
+
+	full = queue_full(rq->queue, QUEUE_TYPE_FROM_ULP);
+	if (unlikely(full)) {
+		err = -ENOMEM;
+		rxe_dbg("queue full");
+		goto err_out;
+	}
+
+	if (unlikely(num_sge > rq->max_sge)) {
+		err = -EINVAL;
+		rxe_dbg("bad num_sge > max_sge");
+		goto err_out;
+	}
+
+	length = 0;
+	for (i = 0; i < num_sge; i++)
+		length += ibwr->sg_list[i].length;
+
+	/* IBA max message size is 2^31 */
+	if (length >= (1UL<<31)) {
+		err = -EINVAL;
+		rxe_dbg("message length too long");
+		goto err_out;
+	}
+
+	recv_wqe = queue_producer_addr(rq->queue, QUEUE_TYPE_FROM_ULP);
+
+	recv_wqe->wr_id = ibwr->wr_id;
+	recv_wqe->dma.length = length;
+	recv_wqe->dma.resid = length;
+	recv_wqe->dma.num_sge = num_sge;
+	recv_wqe->dma.cur_sge = 0;
+	recv_wqe->dma.sge_offset = 0;
+	memcpy(recv_wqe->dma.sge, ibwr->sg_list,
+	       num_sge * sizeof(struct ib_sge));
+
+	queue_advance_producer(rq->queue, QUEUE_TYPE_FROM_ULP);
+
+	return 0;
+
+err_out:
+	rxe_dbg("returned err = %d", err);
+	return err;
 }
 
 static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
@@ -719,12 +987,16 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 
 	if (unlikely((qp_state(qp) < IB_QPS_INIT) || !qp->valid)) {
 		*bad_wr = wr;
-		return -EINVAL;
+		err = -EINVAL;
+		rxe_dbg_qp(qp, "qp destroyed or not ready to post recv");
+		goto err_out;
 	}
 
 	if (unlikely(qp->srq)) {
 		*bad_wr = wr;
-		return -EINVAL;
+		err = -EINVAL;
+		rxe_dbg_qp(qp, "use post_srq_recv instead");
+		goto err_out;
 	}
 
 	spin_lock_irqsave(&rq->producer_lock, flags);
@@ -743,73 +1015,101 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	if (qp->resp.state == QP_STATE_ERROR)
 		rxe_sched_task(&qp->resp.task);
 
+err_out:
+	if (err)
+		rxe_err_qp(qp, "returned err = %d", err);
+
 	return err;
 }
 
+/* cq */
 static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			 struct ib_udata *udata)
 {
-	int err;
 	struct ib_device *dev = ibcq->device;
 	struct rxe_dev *rxe = to_rdev(dev);
 	struct rxe_cq *cq = to_rcq(ibcq);
 	struct rxe_create_cq_resp __user *uresp = NULL;
+	int err, cleanup_err;
 
 	if (udata) {
-		if (udata->outlen < sizeof(*uresp))
-			return -EINVAL;
+		if (udata->outlen < sizeof(*uresp)) {
+			err = -EINVAL;
+			rxe_dbg_dev(rxe, "malformed udata, err = %d", err);
+			goto err_out;
+		}
 		uresp = udata->outbuf;
 	}
 
-	if (attr->flags)
-		return -EOPNOTSUPP;
+	if (attr->flags) {
+		err = -EOPNOTSUPP;
+		rxe_dbg_dev(rxe, "bad attr->flags, err = %d", err);
+		goto err_out;
+	}
 
 	err = rxe_cq_chk_attr(rxe, NULL, attr->cqe, attr->comp_vector);
-	if (err)
-		return err;
+	if (err) {
+		rxe_dbg_dev(rxe, "bad init attributes, err = %d", err);
+		goto err_out;
+	}
+
+	err = rxe_add_to_pool(&rxe->cq_pool, cq);
+	if (err) {
+		rxe_dbg_dev(rxe, "unable to create cq, err = %d", err);
+		goto err_out;
+	}
 
 	err = rxe_cq_from_init(rxe, cq, attr->cqe, attr->comp_vector, udata,
 			       uresp);
-	if (err)
-		return err;
-
-	return rxe_add_to_pool(&rxe->cq_pool, cq);
-}
-
-static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
-{
-	struct rxe_cq *cq = to_rcq(ibcq);
-
-	/* See IBA C11-17: The CI shall return an error if this Verb is
-	 * invoked while a Work Queue is still associated with the CQ.
-	 */
-	if (atomic_read(&cq->num_wq))
-		return -EINVAL;
-
-	rxe_cq_disable(cq);
+	if (err) {
+		rxe_dbg_cq(cq, "create cq failed, err = %d", err);
+		goto err_cleanup;
+	}
 
-	rxe_cleanup(cq);
 	return 0;
+
+err_cleanup:
+	cleanup_err = rxe_cleanup(cq);
+	if (cleanup_err)
+		rxe_err_cq(cq, "cleanup failed, err = %d", cleanup_err);
+err_out:
+	rxe_err_dev(rxe, "returned err = %d", err);
+	return err;
 }
 
 static int rxe_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
 {
-	int err;
 	struct rxe_cq *cq = to_rcq(ibcq);
 	struct rxe_dev *rxe = to_rdev(ibcq->device);
 	struct rxe_resize_cq_resp __user *uresp = NULL;
+	int err;
 
 	if (udata) {
-		if (udata->outlen < sizeof(*uresp))
-			return -EINVAL;
+		if (udata->outlen < sizeof(*uresp)) {
+			err = -EINVAL;
+			rxe_dbg_cq(cq, "malformed udata");
+			goto err_out;
+		}
 		uresp = udata->outbuf;
 	}
 
 	err = rxe_cq_chk_attr(rxe, cq, cqe, 0);
-	if (err)
-		return err;
+	if (err) {
+		rxe_dbg_cq(cq, "bad attr, err = %d", err);
+		goto err_out;
+	}
 
-	return rxe_cq_resize_queue(cq, cqe, uresp, udata);
+	err = rxe_cq_resize_queue(cq, cqe, uresp, udata);
+	if (err) {
+		rxe_dbg_cq(cq, "resize cq failed, err = %d", err);
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	rxe_err_cq(cq, "returned err = %d", err);
+	return err;
 }
 
 static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
@@ -823,7 +1123,7 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 	for (i = 0; i < num_entries; i++) {
 		cqe = queue_head(cq->queue, QUEUE_TYPE_TO_ULP);
 		if (!cqe)
-			break;
+			break;	/* queue empty */
 
 		memcpy(wc++, &cqe->ibwc, sizeof(*wc));
 		queue_advance_consumer(cq->queue, QUEUE_TYPE_TO_ULP);
@@ -864,6 +1164,34 @@ static int rxe_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 	return ret;
 }
 
+static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
+{
+	struct rxe_cq *cq = to_rcq(ibcq);
+	int err;
+
+	/* See IBA C11-17: The CI shall return an error if this Verb is
+	 * invoked while a Work Queue is still associated with the CQ.
+	 */
+	if (atomic_read(&cq->num_wq)) {
+		err = -EINVAL;
+		rxe_dbg_cq(cq, "still in use");
+		goto err_out;
+	}
+
+	rxe_cq_disable(cq);
+
+	err = rxe_cleanup(cq);
+	if (err)
+		rxe_err_cq(cq, "cleanup failed, err = %d", err);
+
+	return 0;
+
+err_out:
+	rxe_err_cq(cq, "returned err = %d", err);
+	return err;
+}
+
+/* mr */
 static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 {
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
@@ -874,12 +1202,15 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr) {
 		err = -ENOMEM;
+		rxe_dbg_dev(rxe, "no memory for mr");
 		goto err_out;
 	}
 
 	err = rxe_add_to_pool(&rxe->mr_pool, mr);
-	if (err)
+	if (err) {
+		rxe_dbg_dev(rxe, "unable to create mr");
 		goto err_free;
+	}
 
 	rxe_get(pd);
 	mr->ibmr.pd = ibpd;
@@ -892,46 +1223,53 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 err_free:
 	kfree(mr);
 err_out:
+	rxe_err_pd(pd, "returned err = %d", err);
 	return ERR_PTR(err);
 }
 
-static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
-				     u64 start,
-				     u64 length,
-				     u64 iova,
-				     int access, struct ib_udata *udata)
+static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
+				     u64 length, u64 iova, int access,
+				     struct ib_udata *udata)
 {
-	int err;
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
+	int err, cleanup_err;
 
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr) {
 		err = -ENOMEM;
+		rxe_dbg_pd(pd, "no memory for mr");
 		goto err_out;
 	}
 
 	err = rxe_add_to_pool(&rxe->mr_pool, mr);
-	if (err)
+	if (err) {
+		rxe_dbg_pd(pd, "unable to create mr");
 		goto err_free;
+	}
 
 	rxe_get(pd);
 	mr->ibmr.pd = ibpd;
 	mr->ibmr.device = ibpd->device;
 
 	err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
-	if (err)
+	if (err) {
+		rxe_dbg_mr(mr, "reg_user_mr failed, err = %d", err);
 		goto err_cleanup;
+	}
 
 	rxe_finalize(mr);
 	return &mr->ibmr;
 
 err_cleanup:
-	rxe_cleanup(mr);
+	cleanup_err = rxe_cleanup(mr);
+	if (cleanup_err)
+		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
 err_free:
 	kfree(mr);
 err_out:
+	rxe_err_pd(pd, "returned err = %d", err);
 	return ERR_PTR(err);
 }
 
@@ -941,40 +1279,76 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
-	int err;
+	int err, cleanup_err;
 
-	if (mr_type != IB_MR_TYPE_MEM_REG)
-		return ERR_PTR(-EINVAL);
+	if (mr_type != IB_MR_TYPE_MEM_REG) {
+		err = -EINVAL;
+		rxe_dbg_pd(pd, "mr type %d not supported, err = %d",
+			   mr_type, err);
+		goto err_out;
+	}
 
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr) {
 		err = -ENOMEM;
+		rxe_dbg_mr(mr, "no memory for mr");
 		goto err_out;
 	}
 
 	err = rxe_add_to_pool(&rxe->mr_pool, mr);
-	if (err)
+	if (err) {
+		rxe_dbg_mr(mr, "unable to create mr, err = %d", err);
 		goto err_free;
+	}
 
 	rxe_get(pd);
 	mr->ibmr.pd = ibpd;
 	mr->ibmr.device = ibpd->device;
 
 	err = rxe_mr_init_fast(max_num_sg, mr);
-	if (err)
+	if (err) {
+		rxe_dbg_mr(mr, "alloc_mr failed, err = %d", err);
 		goto err_cleanup;
+	}
 
 	rxe_finalize(mr);
 	return &mr->ibmr;
 
 err_cleanup:
-	rxe_cleanup(mr);
+	cleanup_err = rxe_cleanup(mr);
+	if (cleanup_err)
+		rxe_err_mr(mr, "cleanup failed, err = %d", err);
 err_free:
 	kfree(mr);
 err_out:
+	rxe_err_pd(pd, "returned err = %d", err);
 	return ERR_PTR(err);
 }
 
+static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
+{
+	struct rxe_mr *mr = to_rmr(ibmr);
+	int err, cleanup_err;
+
+	/* See IBA 10.6.7.2.6 */
+	if (atomic_read(&mr->num_mw) > 0) {
+		err = -EINVAL;
+		rxe_dbg_mr(mr, "mr has mw's bound");
+		goto err_out;
+	}
+
+	cleanup_err = rxe_cleanup(mr);
+	if (cleanup_err)
+		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
+
+	kfree_rcu(mr);
+	return 0;
+
+err_out:
+	rxe_err_mr(mr, "returned err = %d", err);
+	return err;
+}
+
 static ssize_t parent_show(struct device *device,
 			   struct device_attribute *attr, char *buf)
 {
-- 
2.37.2

