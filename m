Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78D76A6654
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Mar 2023 04:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCADKx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 22:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCADKw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 22:10:52 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D46A2BECA
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 19:10:51 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id e26-20020a9d6e1a000000b00694274b5d3aso1033069otr.5
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 19:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWZFX8wo+ZIoSXxkx7gBdyK3Bjms0DZFr1d1efJji1g=;
        b=m6JcW0UCSKa1BAITIi9uw6LV5vVXrCezLXt0rwekRuS81SAwmIRU27CExIvdV9cYT9
         B18ECL7vFTxvFiqiV8FU21gx+iGdwdP7NTu2DVZ+TcNBuFSLEGOw6Y9UCQle/KDZeklU
         U3IhzlENSDt3wPm/NkHQglaDVrGIWebq219NsHM5CoWZ4Qg5f30FxCnYYfNxWUdBpQbs
         MLhRyQpnoWsZA13KIykl6WKneN8LyAE8GyHDydqsOzum98UM9W+sjaUDH8qe/du3s/uZ
         LAyRyFkfCtpsXPOfP44B0U+c3R2FwSmLa8Tn32DB/MtkOpFhDQeWkqyVRahqepEhjU6D
         57Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWZFX8wo+ZIoSXxkx7gBdyK3Bjms0DZFr1d1efJji1g=;
        b=LTJR/+W6ShlDtK+TztDnfSWw/7Q1lox7bGg64QSgdYv6KXNQRhRABE4jqV0YCTqfXg
         Taj4r4CM1fPVXSkBp/aM3xSxmhqc4pr19fwQKoKFI8Xc32od72icv8sqNpFyFkPoaKVf
         mVJI7ZRFUWnfYQMUYbl635abhxyFp5hwyT5gHGfo3RRp1Up7w40cbCD3/Ukl6cjoN9eZ
         1Zgz8IhMwTfAbPcqROz+rJwjrXkIbinMwVz8cHlNVlhjlw5XZDDfoV6gIA/ZuJkDvpVb
         fS0EhkmzVDF/0T4I9gIH6yTykQXkMRiAD4UrkrfHQ1nzLXmA00BhnY+85oUMYWihj9Zl
         HI9A==
X-Gm-Message-State: AO0yUKUh1D0FD7UFOnpqu1Mb6whajPONuiE6TDDej0luM8BUNmJ6Y0Dt
        veGsk4bN5h4Ca+PmW+Go82fY32FCIxg=
X-Google-Smtp-Source: AK7set9blA2FbozES63vaC+ZRISAlo6VANr59728lUSR6X7L02mOZqdAfOIQbmAwWiEG0D3mzgbFEA==
X-Received: by 2002:a05:6830:4121:b0:68d:5bc9:7ac8 with SMTP id w33-20020a056830412100b0068d5bc97ac8mr2826560ott.11.1677640250615;
        Tue, 28 Feb 2023 19:10:50 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-759b-a469-60fc-ba97.res6.spectrum.com. [2603:8081:140c:1a00:759b:a469:60fc:ba97])
        by smtp.gmail.com with ESMTPSA id e7-20020a05683013c700b00684152e9ff2sm4484942otq.0.2023.02.28.19.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 19:10:50 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 2/4] RDMA/rxe: Change rxe_dbg to rxe_dbg_dev
Date:   Tue, 28 Feb 2023 21:10:37 -0600
Message-Id: <20230301031038.10851-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230301031038.10851-1-rpearsonhpe@gmail.com>
References: <20230301031038.10851-1-rpearsonhpe@gmail.com>
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

Replace the name rxe_dbg with rxe_dbg_dev which better matches
the remaining rxe_dbg_xxx macros for debug messages with a
rxe device parameter. Reuse the name rxe_dbg for debug messages
which do not have a rxe device parameter.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  2 +-
 drivers/infiniband/sw/rxe/rxe.h       |  3 ++-
 drivers/infiniband/sw/rxe/rxe_cq.c    |  6 +++---
 drivers/infiniband/sw/rxe/rxe_icrc.c  |  4 ++--
 drivers/infiniband/sw/rxe/rxe_mmap.c  |  6 +++---
 drivers/infiniband/sw/rxe/rxe_net.c   |  4 ++--
 drivers/infiniband/sw/rxe/rxe_qp.c    | 16 ++++++++--------
 drivers/infiniband/sw/rxe/rxe_srq.c   |  6 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
 9 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index a3f05fdd9fac..d57ba7a5964b 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -187,7 +187,7 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	rxe = rxe_get_dev_from_net(ndev);
 	if (rxe) {
 		ib_device_put(&rxe->ib_dev);
-		rxe_dbg(rxe, "already configured on %s\n", ndev->name);
+		rxe_dbg_dev(rxe, "already configured on %s\n", ndev->name);
 		err = -EEXIST;
 		goto err;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 2415f3704f57..0757acc38103 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -38,7 +38,8 @@
 
 #define RXE_ROCE_V2_SPORT		(0xc000)
 
-#define rxe_dbg(rxe, fmt, ...) ibdev_dbg(&(rxe)->ib_dev,		\
+#define rxe_dbg(fmt, ...) pr_debug("%s: " fmt "\n", __func__, ##__VA_ARGS__)
+#define rxe_dbg_dev(rxe, fmt, ...) ibdev_dbg(&(rxe)->ib_dev,		\
 		"%s: " fmt, __func__, ##__VA_ARGS__)
 #define rxe_dbg_uc(uc, fmt, ...) ibdev_dbg((uc)->ibuc.device,		\
 		"uc#%d %s: " fmt, (uc)->elem.index, __func__, ##__VA_ARGS__)
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

