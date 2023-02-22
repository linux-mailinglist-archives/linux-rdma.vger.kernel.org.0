Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9E569FF9A
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Feb 2023 00:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBVXfh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Feb 2023 18:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjBVXfg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Feb 2023 18:35:36 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3D0474E1
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:25 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so1216552otv.0
        for <linux-rdma@vger.kernel.org>; Wed, 22 Feb 2023 15:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGpGGGVhHs0Vj9gMT+dcS/avlfeAoohLIXbv88L+KZ0=;
        b=q0Cl8YOIAzt30LGQQ7h7hZGXd0K2Z7LC4PLkFt7XB46z5F6WEfadrKB6OpQL16OBB+
         2u5LF9pC+zIy17fN1Pv7Qny0+NcoP5J8UHETTSM/o2VV4jfSwjg6GctF9t2mQxQNBVSt
         VRGL9eNlpMWQw5fu3XZjY2K13mmvs1k9Pz2fUF3eSZUr7cP+CMmeXZPGUllvvYNV8PAz
         AEqcBHhFcBbXCiASsjBf5jWXmEC3HYYOEqmicuLlJtAYwPZdAUvCYkUZzsx/abmB+sDX
         WJR2l9T+Xrgz3jBsUpDtvIDI0Qi3igHOb8l57PCstU/+EAX6wbMhiCHLBr/LGKQKLOJ1
         K2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGpGGGVhHs0Vj9gMT+dcS/avlfeAoohLIXbv88L+KZ0=;
        b=6hFBKugZGNefmd0oG9ipmVzwkm6/0KvOGZ9TxjkdawrO/RbRkEpXwj0IuJUBMZDI33
         6GjLposvirkkcihyr+z+u4ecz+4dLZdDS6uTKEdxcJD3WlMofE5VzA8YSDxWdKlJ5A80
         wxjrLKifCktSDaOCh7LoWptCvCMNZF7/NMB55oBeUsKI08VPEk25Or07aiIUx5Myzcc7
         MeIi0754TVeTNA0jBUPAeKeBAr6kjWc7xZd5VP0i6rRSjvE1iH459d9mtTR0n047bUpj
         4vZzT4ukhIzXQKfqUGTZ8n0g+rGftc5qj1nBRE/I4ncLcrSIuVUD//FmFtLlmH3tCIgh
         XrJQ==
X-Gm-Message-State: AO0yUKUADkcMSUM5e3zRCLC1JOe6htg9/191uzvrD7yTYZLIUopr+W8D
        MHK/YduTCF/aTSyuH35Q6fI=
X-Google-Smtp-Source: AK7set9jwaWQrvw3Pe5apSIKtTkAViYrF08bDZ90q5mR0+rQniWX/+WLsSo3CtVEq/tj25y/qcm+Jg==
X-Received: by 2002:a9d:4e3:0:b0:68b:e4d7:b8d with SMTP id 90-20020a9d04e3000000b0068be4d70b8dmr1528542otm.35.1677108924434;
        Wed, 22 Feb 2023 15:35:24 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-e92c-8850-3fad-351f.res6.spectrum.com. [2603:8081:140c:1a00:e92c:8850:3fad:351f])
        by smtp.gmail.com with ESMTPSA id l19-20020a9d7093000000b0068663820588sm2723281otj.44.2023.02.22.15.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:35:23 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 1/9] RDMA/rxe: Extend debug log messages
Date:   Wed, 22 Feb 2023 17:32:30 -0600
Message-Id: <20230222233237.48940-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222233237.48940-1-rpearsonhpe@gmail.com>
References: <20230222233237.48940-1-rpearsonhpe@gmail.com>
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

Extend the debug log messages (e.g. rxe_dbg_xxx) to include
err and info types. Also replace rxe_xxx(rxe, ...) by
rxe_dev_xxx(rxe, ...) and add a new macro rxe_xxx(...) which
does not have a device parameter. A few examples are added to
show how these are used.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       | 25 ++++++++++-----
 drivers/infiniband/sw/rxe/rxe.h       | 45 ++++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_cq.c    |  6 ++--
 drivers/infiniband/sw/rxe/rxe_icrc.c  |  4 +--
 drivers/infiniband/sw/rxe/rxe_mmap.c  |  6 ++--
 drivers/infiniband/sw/rxe/rxe_net.c   |  4 +--
 drivers/infiniband/sw/rxe/rxe_qp.c    | 16 +++++-----
 drivers/infiniband/sw/rxe/rxe_srq.c   |  6 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
 9 files changed, 83 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 136c2efe3466..59cda01a6018 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -160,6 +160,8 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
 
 	port->attr.active_mtu = mtu;
 	port->mtu_cap = ib_mtu_enum_to_int(mtu);
+
+	rxe_info_dev(rxe, "set mtu to %d", port->mtu_cap);
 }
 
 /* called by ifc layer to create new rxe device.
@@ -167,34 +169,41 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
  */
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
 {
+	int err;
+
 	rxe_init(rxe);
+	err = rxe_register_device(rxe, ibdev_name);
+
 	rxe_set_mtu(rxe, mtu);
 
-	return rxe_register_device(rxe, ibdev_name);
+	return err;
 }
 
 static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 {
-	struct rxe_dev *exists;
+	struct rxe_dev *rxe;
 	int err = 0;
 
 	if (is_vlan_dev(ndev)) {
-		pr_err("rxe creation allowed on top of a real device only\n");
 		err = -EPERM;
+		rxe_err("rxe creation not allowed on vlan device %s\n",
+			ndev->name);
 		goto err;
 	}
 
-	exists = rxe_get_dev_from_net(ndev);
-	if (exists) {
-		ib_device_put(&exists->ib_dev);
-		rxe_dbg(exists, "already configured on %s\n", ndev->name);
+	rxe = rxe_get_dev_from_net(ndev);
+	if (rxe) {
+		ib_device_put(&rxe->ib_dev);
 		err = -EEXIST;
+		rxe_err_dev(rxe, "already configured on %s, err = %d",
+			    ndev->name, err);
 		goto err;
 	}
 
 	err = rxe_net_add(ibdev_name, ndev);
 	if (err) {
-		rxe_dbg(exists, "failed to add %s\n", ndev->name);
+		rxe_err("failed to add %s to %s, err = %d",
+			ibdev_name, ndev->name, err);
 		goto err;
 	}
 err:
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 2415f3704f57..9da26107dbf3 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -38,7 +38,8 @@
 
 #define RXE_ROCE_V2_SPORT		(0xc000)
 
-#define rxe_dbg(rxe, fmt, ...) ibdev_dbg(&(rxe)->ib_dev,		\
+#define rxe_dbg(fmt, ...) pr_dbg("%s: " fmt "\n", __func__, ##__VA_ARGS__)
+#define rxe_dbg_dev(rxe, fmt, ...) ibdev_dbg(&(rxe)->ib_dev,		\
 		"%s: " fmt, __func__, ##__VA_ARGS__)
 #define rxe_dbg_uc(uc, fmt, ...) ibdev_dbg((uc)->ibuc.device,		\
 		"uc#%d %s: " fmt, (uc)->elem.index, __func__, ##__VA_ARGS__)
@@ -57,6 +58,48 @@
 #define rxe_dbg_mw(mw, fmt, ...) ibdev_dbg((mw)->ibmw.device,		\
 		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
 
+#define rxe_err(fmt, ...) pr_err_ratelimited("%s: " fmt "\n", __func__, \
+					##__VA_ARGS__)
+#define rxe_err_dev(rxe, fmt, ...) ibdev_err_ratelimited(&(rxe)->ib_dev, \
+		"%s: " fmt, __func__, ##__VA_ARGS__)
+#define rxe_err_uc(uc, fmt, ...) ibdev_err_ratelimited((uc)->ibuc.device, \
+		"uc#%d %s: " fmt, (uc)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_pd(pd, fmt, ...) ibdev_err_ratelimited((pd)->ibpd.device, \
+		"pd#%d %s: " fmt, (pd)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_ah(ah, fmt, ...) ibdev_err_ratelimited((ah)->ibah.device, \
+		"ah#%d %s: " fmt, (ah)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_srq(srq, fmt, ...) ibdev_err_ratelimited((srq)->ibsrq.device, \
+		"srq#%d %s: " fmt, (srq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_qp(qp, fmt, ...) ibdev_err_ratelimited((qp)->ibqp.device, \
+		"qp#%d %s: " fmt, (qp)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_cq(cq, fmt, ...) ibdev_err_ratelimited((cq)->ibcq.device, \
+		"cq#%d %s: " fmt, (cq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_mr(mr, fmt, ...) ibdev_err_ratelimited((mr)->ibmr.device, \
+		"mr#%d %s:  " fmt, (mr)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_mw(mw, fmt, ...) ibdev_err_ratelimited((mw)->ibmw.device, \
+		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
+
+#define rxe_info(fmt, ...) pr_info_ratelimited("%s: " fmt "\n", __func__, \
+					##__VA_ARGS__)
+#define rxe_info_dev(rxe, fmt, ...) ibdev_info_ratelimited(&(rxe)->ib_dev, \
+		"%s: " fmt, __func__, ##__VA_ARGS__)
+#define rxe_info_uc(uc, fmt, ...) ibdev_info_ratelimited((uc)->ibuc.device, \
+		"uc#%d %s: " fmt, (uc)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_pd(pd, fmt, ...) ibdev_info_ratelimited((pd)->ibpd.device, \
+		"pd#%d %s: " fmt, (pd)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_ah(ah, fmt, ...) ibdev_info_ratelimited((ah)->ibah.device, \
+		"ah#%d %s: " fmt, (ah)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_srq(srq, fmt, ...) ibdev_info_ratelimited((srq)->ibsrq.device, \
+		"srq#%d %s: " fmt, (srq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_qp(qp, fmt, ...) ibdev_info_ratelimited((qp)->ibqp.device, \
+		"qp#%d %s: " fmt, (qp)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_cq(cq, fmt, ...) ibdev_info_ratelimited((cq)->ibcq.device, \
+		"cq#%d %s: " fmt, (cq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_mr(mr, fmt, ...) ibdev_info_ratelimited((mr)->ibmr.device, \
+		"mr#%d %s:  " fmt, (mr)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_mw(mw, fmt, ...) ibdev_info_ratelimited((mw)->ibmw.device, \
+		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
+
 /* responder states */
 enum resp_states {
 	RESPST_NONE,
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 1df186534639..22fbc198e5d1 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -14,12 +14,12 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 	int count;
 
 	if (cqe <= 0) {
-		rxe_dbg(rxe, "cqe(%d) <= 0\n", cqe);
+		rxe_dbg_dev(rxe, "cqe(%d) <= 0\n", cqe);
 		goto err1;
 	}
 
 	if (cqe > rxe->attr.max_cqe) {
-		rxe_dbg(rxe, "cqe(%d) > max_cqe(%d)\n",
+		rxe_dbg_dev(rxe, "cqe(%d) > max_cqe(%d)\n",
 				cqe, rxe->attr.max_cqe);
 		goto err1;
 	}
@@ -65,7 +65,7 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 	cq->queue = rxe_queue_init(rxe, &cqe,
 			sizeof(struct rxe_cqe), type);
 	if (!cq->queue) {
-		rxe_dbg(rxe, "unable to create cq\n");
+		rxe_dbg_dev(rxe, "unable to create cq\n");
 		return -ENOMEM;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index 71bc2c189588..fdf5f08cd8f1 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -21,7 +21,7 @@ int rxe_icrc_init(struct rxe_dev *rxe)
 
 	tfm = crypto_alloc_shash("crc32", 0, 0);
 	if (IS_ERR(tfm)) {
-		rxe_dbg(rxe, "failed to init crc32 algorithm err: %ld\n",
+		rxe_dbg_dev(rxe, "failed to init crc32 algorithm err: %ld\n",
 			       PTR_ERR(tfm));
 		return PTR_ERR(tfm);
 	}
@@ -51,7 +51,7 @@ static __be32 rxe_crc32(struct rxe_dev *rxe, __be32 crc, void *next, size_t len)
 	*(__be32 *)shash_desc_ctx(shash) = crc;
 	err = crypto_shash_update(shash, next, len);
 	if (unlikely(err)) {
-		rxe_dbg(rxe, "failed crc calculation, err: %d\n", err);
+		rxe_dbg_dev(rxe, "failed crc calculation, err: %d\n", err);
 		return (__force __be32)crc32_le((__force u32)crc, next, len);
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/rxe/rxe_mmap.c
index a47d72dbc537..6b7f2bd69879 100644
--- a/drivers/infiniband/sw/rxe/rxe_mmap.c
+++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
@@ -79,7 +79,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 
 		/* Don't allow a mmap larger than the object. */
 		if (size > ip->info.size) {
-			rxe_dbg(rxe, "mmap region is larger than the object!\n");
+			rxe_dbg_dev(rxe, "mmap region is larger than the object!\n");
 			spin_unlock_bh(&rxe->pending_lock);
 			ret = -EINVAL;
 			goto done;
@@ -87,7 +87,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 
 		goto found_it;
 	}
-	rxe_dbg(rxe, "unable to find pending mmap info\n");
+	rxe_dbg_dev(rxe, "unable to find pending mmap info\n");
 	spin_unlock_bh(&rxe->pending_lock);
 	ret = -EINVAL;
 	goto done;
@@ -98,7 +98,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 
 	ret = remap_vmalloc_range(vma, ip->obj, 0);
 	if (ret) {
-		rxe_dbg(rxe, "err %d from remap_vmalloc_range\n", ret);
+		rxe_dbg_dev(rxe, "err %d from remap_vmalloc_range\n", ret);
 		goto done;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index e02e1624bcf4..a2ace42e9536 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -596,7 +596,7 @@ static int rxe_notify(struct notifier_block *not_blk,
 		rxe_port_down(rxe);
 		break;
 	case NETDEV_CHANGEMTU:
-		rxe_dbg(rxe, "%s changed mtu to %d\n", ndev->name, ndev->mtu);
+		rxe_dbg_dev(rxe, "%s changed mtu to %d\n", ndev->name, ndev->mtu);
 		rxe_set_mtu(rxe, ndev->mtu);
 		break;
 	case NETDEV_CHANGE:
@@ -608,7 +608,7 @@ static int rxe_notify(struct notifier_block *not_blk,
 	case NETDEV_CHANGENAME:
 	case NETDEV_FEAT_CHANGE:
 	default:
-		rxe_dbg(rxe, "ignoring netdev event = %ld for %s\n",
+		rxe_dbg_dev(rxe, "ignoring netdev event = %ld for %s\n",
 			event, ndev->name);
 		break;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index ab72db68b58f..c954dd9394ba 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -19,33 +19,33 @@ static int rxe_qp_chk_cap(struct rxe_dev *rxe, struct ib_qp_cap *cap,
 			  int has_srq)
 {
 	if (cap->max_send_wr > rxe->attr.max_qp_wr) {
-		rxe_dbg(rxe, "invalid send wr = %u > %d\n",
+		rxe_dbg_dev(rxe, "invalid send wr = %u > %d\n",
 			 cap->max_send_wr, rxe->attr.max_qp_wr);
 		goto err1;
 	}
 
 	if (cap->max_send_sge > rxe->attr.max_send_sge) {
-		rxe_dbg(rxe, "invalid send sge = %u > %d\n",
+		rxe_dbg_dev(rxe, "invalid send sge = %u > %d\n",
 			 cap->max_send_sge, rxe->attr.max_send_sge);
 		goto err1;
 	}
 
 	if (!has_srq) {
 		if (cap->max_recv_wr > rxe->attr.max_qp_wr) {
-			rxe_dbg(rxe, "invalid recv wr = %u > %d\n",
+			rxe_dbg_dev(rxe, "invalid recv wr = %u > %d\n",
 				 cap->max_recv_wr, rxe->attr.max_qp_wr);
 			goto err1;
 		}
 
 		if (cap->max_recv_sge > rxe->attr.max_recv_sge) {
-			rxe_dbg(rxe, "invalid recv sge = %u > %d\n",
+			rxe_dbg_dev(rxe, "invalid recv sge = %u > %d\n",
 				 cap->max_recv_sge, rxe->attr.max_recv_sge);
 			goto err1;
 		}
 	}
 
 	if (cap->max_inline_data > rxe->max_inline_data) {
-		rxe_dbg(rxe, "invalid max inline data = %u > %d\n",
+		rxe_dbg_dev(rxe, "invalid max inline data = %u > %d\n",
 			 cap->max_inline_data, rxe->max_inline_data);
 		goto err1;
 	}
@@ -73,7 +73,7 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 	}
 
 	if (!init->recv_cq || !init->send_cq) {
-		rxe_dbg(rxe, "missing cq\n");
+		rxe_dbg_dev(rxe, "missing cq\n");
 		goto err1;
 	}
 
@@ -82,14 +82,14 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 
 	if (init->qp_type == IB_QPT_GSI) {
 		if (!rdma_is_port_valid(&rxe->ib_dev, port_num)) {
-			rxe_dbg(rxe, "invalid port = %d\n", port_num);
+			rxe_dbg_dev(rxe, "invalid port = %d\n", port_num);
 			goto err1;
 		}
 
 		port = &rxe->port;
 
 		if (init->qp_type == IB_QPT_GSI && port->qp_gsi_index) {
-			rxe_dbg(rxe, "GSI QP exists for port %d\n", port_num);
+			rxe_dbg_dev(rxe, "GSI QP exists for port %d\n", port_num);
 			goto err1;
 		}
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 82e37a41ced4..27ca82ec0826 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -13,13 +13,13 @@ int rxe_srq_chk_init(struct rxe_dev *rxe, struct ib_srq_init_attr *init)
 	struct ib_srq_attr *attr = &init->attr;
 
 	if (attr->max_wr > rxe->attr.max_srq_wr) {
-		rxe_dbg(rxe, "max_wr(%d) > max_srq_wr(%d)\n",
+		rxe_dbg_dev(rxe, "max_wr(%d) > max_srq_wr(%d)\n",
 			attr->max_wr, rxe->attr.max_srq_wr);
 		goto err1;
 	}
 
 	if (attr->max_wr <= 0) {
-		rxe_dbg(rxe, "max_wr(%d) <= 0\n", attr->max_wr);
+		rxe_dbg_dev(rxe, "max_wr(%d) <= 0\n", attr->max_wr);
 		goto err1;
 	}
 
@@ -27,7 +27,7 @@ int rxe_srq_chk_init(struct rxe_dev *rxe, struct ib_srq_init_attr *init)
 		attr->max_wr = RXE_MIN_SRQ_WR;
 
 	if (attr->max_sge > rxe->attr.max_srq_sge) {
-		rxe_dbg(rxe, "max_sge(%d) > max_srq_sge(%d)\n",
+		rxe_dbg_dev(rxe, "max_sge(%d) > max_srq_sge(%d)\n",
 			attr->max_sge, rxe->attr.max_srq_sge);
 		goto err1;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index e14050a69276..f178d0773ff2 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1095,7 +1095,7 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 
 	err = ib_register_device(dev, ibdev_name, NULL);
 	if (err)
-		rxe_dbg(rxe, "failed with error %d\n", err);
+		rxe_dbg_dev(rxe, "failed with error %d\n", err);
 
 	/*
 	 * Note that rxe may be invalid at this point if another thread
-- 
2.37.2

