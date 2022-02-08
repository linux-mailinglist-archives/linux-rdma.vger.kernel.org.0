Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5DB4AE3F3
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 23:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345032AbiBHWYz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 17:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386864AbiBHVRT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 16:17:19 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1700C0612BA
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 13:17:18 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id x193so516670oix.0
        for <linux-rdma@vger.kernel.org>; Tue, 08 Feb 2022 13:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uUCkWwoN4ANeBFvyn/bUTxsS52qGVJg89kXWa2UrRYQ=;
        b=l0hsJA5ERe4McX1FG6aRRLlUyqCrIHKKR7ozlQY2DaM6ib7MlvXHpGNm0p0yiRgcEX
         f7oDEh2yVe1YbHupCfpIGP7/KHJG57tHS0DYZwB4fLSpuSN1OSZkRZUAfy9vS52WMBCq
         o3VHmo8Lh3ZVhX88CCmrV1UEP3XFPXxfn7/nF5ffRPlubMxMakRinRnkIhmahQH+WXGD
         RNfahDqTohcJGxq0m3R+aRz4js/tK8IPiCTGS60FjerFiz5R6AscfbM8D0OJF2GS+e3C
         B6HNSkEv2Fw31VoGa3+VeCz98PVRacSw5CovNxSTV3sHzT6R+Cj//44wBq8LDojB/ePq
         iotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uUCkWwoN4ANeBFvyn/bUTxsS52qGVJg89kXWa2UrRYQ=;
        b=w17M+QWFAU3csZcZg17OVsb1ZWNxWOemPBj83p6rLBG9VYIaQmUkjHbeYNNTuoHNe7
         P0Cuf7Pz6Z4jlxZ53Fn5NcoXTTK2fM/bBptU41q214EaENvfFm7FdwG9MnTuiFx9lVF6
         Ox5vGCUIMSwFGJ1E/nNh8k6ARO5OZ2YXYYt+UVFrDfHlV5gjmNI4euJ5ZX6QRtIZb6UI
         Yy6Z854rUElHljRhMaBmyDZ//jdlTsEWIjDe7+TNE1srGSlamHsbkHtnciAlc7BFC5/4
         cGibywiPYVT9KISim67vU6z8aSbgxKfu9TxTKEMA4BLsAKuqyaMUSJjQppJP/lleAaTd
         oeNw==
X-Gm-Message-State: AOAM532i8PDp6hr5kiBraPxbomm+anOrc0OV6b1ixV10LG1HRuuYgsAb
        ue3uZ2dvOfJLoq2TtE/7yUK+daURkDI=
X-Google-Smtp-Source: ABdhPJyL6wSTBLyCY+HkIIxZ3AlzX8ZP1EVqsSZx86Fn2G3+NnYXrY/xPQMR3JJ5b6lxJ+Mp7nPLbA==
X-Received: by 2002:a05:6808:1181:: with SMTP id j1mr1377100oil.182.1644355037795;
        Tue, 08 Feb 2022 13:17:17 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-2501-ba3f-d39d-75da.res6.spectrum.com. [2603:8081:140c:1a00:2501:ba3f:d39d:75da])
        by smtp.googlemail.com with ESMTPSA id bh7sm2145462oib.6.2022.02.08.13.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:17:17 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 04/11] RDMA/rxe: Replace int num_qp by atomic_t qp_num
Date:   Tue,  8 Feb 2022 15:16:38 -0600
Message-Id: <20220208211644.123457-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208211644.123457-1-rpearsonhpe@gmail.com>
References: <20220208211644.123457-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace int num_qp in struct rxe_mcg by atomic_t qp_num.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 9 ++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 96dc11a892a4..2c6cb2eb5ac1 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -109,7 +109,8 @@ static int rxe_attach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 	}
 
 	/* check limits after checking if already attached */
-	if (mcg->num_qp >= rxe->attr.max_mcast_qp_attach) {
+	if (atomic_inc_return(&mcg->qp_num) > rxe->attr.max_mcast_qp_attach) {
+		atomic_dec(&mcg->qp_num);
 		kfree(mca);
 		err = -ENOMEM;
 		goto out;
@@ -120,7 +121,6 @@ static int rxe_attach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 	mca->qp = qp;
 
 	atomic_inc(&qp->mcg_num);
-	mcg->num_qp++;
 	list_add(&mca->qp_list, &mcg->qp_list);
 
 	err = 0;
@@ -178,8 +178,7 @@ static int rxe_detach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 			 * object since we are still holding a ref
 			 * from the get key above.
 			 */
-			mcg->num_qp--;
-			if (mcg->num_qp <= 0)
+			if (atomic_dec_return(&mcg->qp_num) <= 0)
 				__rxe_destroy_mcg(mcg);
 
 			atomic_dec(&qp->mcg_num);
@@ -218,7 +217,7 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	err = rxe_attach_mcg(rxe, qp, mcg);
 
 	/* if we failed to attach the first qp to mcg tear it down */
-	if (mcg->num_qp == 0)
+	if (atomic_read(&mcg->qp_num) == 0)
 		rxe_destroy_mcg(mcg);
 
 	rxe_drop_ref(mcg);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 1b0f40881895..3790163bb265 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -356,7 +356,7 @@ struct rxe_mcg {
 	struct rxe_dev		*rxe;
 	struct list_head	qp_list;
 	union ib_gid		mgid;
-	int			num_qp;
+	atomic_t		qp_num;
 	u32			qkey;
 	u16			pkey;
 };
-- 
2.32.0

