Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59319602357
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJREge (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJREg1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:27 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB15DA0248
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:23 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id l5so14398942oif.7
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yW+DMhH4EeyZPJ/sfP09rQT+gnK+v+z7PE/z/pWlIgo=;
        b=RbnjK9O36NQy/mXBNXpXUx8qJ3GaX5X/vEzsaAETqdCYL9zhP/P4baTfAAIU+xK7za
         dUivgmoNJf7COEKwQ9WUX8NRlcDGqd37R3G08U8aiUmcZYO5XMC1MMptN4L31odCNj1V
         T7XUhxjEnfN2oOUZv3jSsaqW3pootEb08En9D7hDL3z/OtoRHgIFt4nACiwTubHY/vKX
         18zSTn0QUJdtJBis5kQ4KRzBy+9Sb4G2NDiyS/CVatzupzBsE+H2QhLYoVhoo64j4q+z
         i1BmXaJ28qYufmPQJxPBZ0N4b4SpUhrDpaznQybU9HvXoMRWHotkKFPlRmswKnQqsBTU
         loLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yW+DMhH4EeyZPJ/sfP09rQT+gnK+v+z7PE/z/pWlIgo=;
        b=XA8yLNNZktaZWP0tLvDw5lwuSxL396f8tKyVxy1kiucBsEMdEe80Bw9WHuXfX7VUpU
         yEaGT8w+h1ghxgXbeaOd6bl2l/SkVabbE3uDt+ybt+qrtyvij1f9uOlLPIS5+VMoxbZY
         mzZQ9+VNEqTNTWLfmsdndU8gtR185Gd8x55nF1RWu9mLO/KzhTJ9ActezFAy2WMaHRrM
         jOGFM5cc6MVL8xyqiEDBoOBwiepubdoDslZBYpEfsFAMedjjRyddGM0a3DeZP0LqwfmL
         FXrfqDHHnT4haaol/R7wuZ1JiTOT3nY9npWhKiaR72/95sJ4ZRpTNnBO3JFgYg3LOZ0d
         l8VA==
X-Gm-Message-State: ACrzQf0Znp7HJ/4ANX2HhaSoas31F2fIgakYdeisCBCVfTEuACpnY9zT
        d5QFFqw/bRdxwXtHpgT7/ny2DzktNFUh4w==
X-Google-Smtp-Source: AMsMyM7rpBYpdZwYbXZ636zha/4eLEoHZMMux5MyGf50WInCWrQawKisMnDSxt0Qv2Ct6DB4Ax1DJA==
X-Received: by 2002:a05:6808:1894:b0:355:2235:31f7 with SMTP id bi20-20020a056808189400b00355223531f7mr8282173oib.248.1666067783221;
        Mon, 17 Oct 2022 21:36:23 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:36:22 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 08/16] RDMA/rxe: Split rxe_drain_resp_pkts()
Date:   Mon, 17 Oct 2022 23:33:39 -0500
Message-Id: <20221018043345.4033-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018043345.4033-1-rpearsonhpe@gmail.com>
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
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

Split rxe_drain_resp_pkts() into two subroutines which perform separate
functions.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index d2a250123617..5d434cce2b69 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -524,17 +524,21 @@ static inline enum comp_state complete_wqe(struct rxe_qp *qp,
 	return COMPST_GET_WQE;
 }
 
-static void rxe_drain_resp_pkts(struct rxe_qp *qp, bool notify)
+static void rxe_drain_resp_pkts(struct rxe_qp *qp)
 {
 	struct sk_buff *skb;
-	struct rxe_send_wqe *wqe;
-	struct rxe_queue *q = qp->sq.queue;
 
 	while ((skb = skb_dequeue(&qp->resp_pkts))) {
 		rxe_put(qp);
 		kfree_skb(skb);
 		ib_device_put(qp->ibqp.device);
 	}
+}
+
+static void rxe_drain_send_queue(struct rxe_qp *qp, bool notify)
+{
+	struct rxe_send_wqe *wqe;
+	struct rxe_queue *q = qp->sq.queue;
 
 	while ((wqe = queue_head(q, q->type))) {
 		if (notify) {
@@ -565,6 +569,7 @@ int rxe_completer(void *arg)
 	struct sk_buff *skb = NULL;
 	struct rxe_pkt_info *pkt = NULL;
 	enum comp_state state;
+	bool notify;
 	int ret;
 
 	if (!rxe_get(qp))
@@ -572,8 +577,9 @@ int rxe_completer(void *arg)
 
 	if (!qp->valid || qp->comp.state == QP_STATE_ERROR ||
 	    qp->comp.state == QP_STATE_RESET) {
-		rxe_drain_resp_pkts(qp, qp->valid &&
-				    qp->comp.state == QP_STATE_ERROR);
+		notify = qp->valid && (qp->comp.state == QP_STATE_ERROR);
+		rxe_drain_resp_pkts(qp);
+		rxe_drain_send_queue(qp, notify);
 		goto exit;
 	}
 
-- 
2.34.1

