Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E3661532F
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 21:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKAUYE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 16:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiKAUYB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 16:24:01 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8241EC71
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 13:23:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso9166248otb.6
        for <linux-rdma@vger.kernel.org>; Tue, 01 Nov 2022 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJWftdyeXBm9wF1AzRAnKgMZKBrEO1waOP1rNpHh3EI=;
        b=fi3zbqxZ3FyKXgQyfi+zi6TFRb80WztbO67+09gGmLzlwub0kUj10Tik+aIGHHkn6m
         CxID6tAwI38ndVqXXz2rWmlGV0WoJnXeeckVXj2AFI0GHJqcJx1E5YHHxFAn8DhLJSBS
         hs2ekLH+9y3bhHmsqOAEVS+8V2tjYZaNDVqGXoFc1Nblw5gOTF0CyRbJoq+YGM4g5jpr
         FIIuVXYbOtxNvdx69FEn3MgQWi5OGfIONl2t1P7U9G5M4DmV8RxAXJRECaLF0ljjLFiq
         PthOsMCqVunb9Ljx6tczVK6iNpdENBmGFXKSftqR/xqdyOBVHVaY6rxld0iqeKlJEYqW
         ByXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJWftdyeXBm9wF1AzRAnKgMZKBrEO1waOP1rNpHh3EI=;
        b=S5r+bLU7qwiOMnncD/nma1PqISgKk3EN93T/CcFofjuddQ79m3HpWo3xfzbxYhlavC
         f0kl+92VezUSr6rQ3LvzpZHQ/kI/bfK/I5uW9h1rT24i9SBDM5Sl3dfNcEfuVOA08w0j
         G1aVodAr017r436m8ETE1L+59EuAYmHqfTXxvF1H/IVYBsvgp5uLfh6vfPFB+dOxfQWK
         14W10OvsRgEbIUy05e62+zQOA5HKSqr9wjd0SpZNZhZ6sAWumlbvmtImZoklMRAoZ6nH
         TfhC9xbIZP+qDnVRxJdIatdxKlRhiMpMGPGDOXVGzZP7zj8ibGdhD9PAEuk/vbWhowyN
         bfiA==
X-Gm-Message-State: ACrzQf2JfIPV2g0SdmC3k6X2vozBTcrA+PJML/3hdL1x1MLGNfXv0eUc
        qZXK0DpWV7B00XW6KhWW0Ok=
X-Google-Smtp-Source: AMsMyM4GRQR0jmeW/xXqe9/XJv3wWC+ytDWCUMetHpMKF+2ZqqfwBVJYKUWLrhWlAbctcMEVVR7OhQ==
X-Received: by 2002:a9d:6d16:0:b0:66b:b674:4a4b with SMTP id o22-20020a9d6d16000000b0066bb6744a4bmr10934041otp.363.1667334237787;
        Tue, 01 Nov 2022 13:23:57 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-e052-4710-92ba-8142.res6.spectrum.com. [2603:8081:140c:1a00:e052:4710:92ba:8142])
        by smtp.googlemail.com with ESMTPSA id d22-20020a056830045600b0066210467fb1sm4337493otc.41.2022.11.01.13.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:23:57 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 10/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_srq in rxe_srq.c
Date:   Tue,  1 Nov 2022 15:22:35 -0500
Message-Id: <20221101202238.32836-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101202238.32836-1-rpearsonhpe@gmail.com>
References: <20221101202238.32836-1-rpearsonhpe@gmail.com>
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

Replace calls to rxe_err/warn in rxe_srq.c with rxe_dbg_srq().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_srq.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 02b39498c370..82e37a41ced4 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -13,13 +13,13 @@ int rxe_srq_chk_init(struct rxe_dev *rxe, struct ib_srq_init_attr *init)
 	struct ib_srq_attr *attr = &init->attr;
 
 	if (attr->max_wr > rxe->attr.max_srq_wr) {
-		pr_warn("max_wr(%d) > max_srq_wr(%d)\n",
+		rxe_dbg(rxe, "max_wr(%d) > max_srq_wr(%d)\n",
 			attr->max_wr, rxe->attr.max_srq_wr);
 		goto err1;
 	}
 
 	if (attr->max_wr <= 0) {
-		pr_warn("max_wr(%d) <= 0\n", attr->max_wr);
+		rxe_dbg(rxe, "max_wr(%d) <= 0\n", attr->max_wr);
 		goto err1;
 	}
 
@@ -27,7 +27,7 @@ int rxe_srq_chk_init(struct rxe_dev *rxe, struct ib_srq_init_attr *init)
 		attr->max_wr = RXE_MIN_SRQ_WR;
 
 	if (attr->max_sge > rxe->attr.max_srq_sge) {
-		pr_warn("max_sge(%d) > max_srq_sge(%d)\n",
+		rxe_dbg(rxe, "max_sge(%d) > max_srq_sge(%d)\n",
 			attr->max_sge, rxe->attr.max_srq_sge);
 		goto err1;
 	}
@@ -65,7 +65,7 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 	type = QUEUE_TYPE_FROM_CLIENT;
 	q = rxe_queue_init(rxe, &srq->rq.max_wr, srq_wqe_size, type);
 	if (!q) {
-		pr_warn("unable to allocate queue for srq\n");
+		rxe_dbg_srq(srq, "Unable to allocate queue\n");
 		return -ENOMEM;
 	}
 
@@ -94,24 +94,24 @@ int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		     struct ib_srq_attr *attr, enum ib_srq_attr_mask mask)
 {
 	if (srq->error) {
-		pr_warn("srq in error state\n");
+		rxe_dbg_srq(srq, "in error state\n");
 		goto err1;
 	}
 
 	if (mask & IB_SRQ_MAX_WR) {
 		if (attr->max_wr > rxe->attr.max_srq_wr) {
-			pr_warn("max_wr(%d) > max_srq_wr(%d)\n",
+			rxe_dbg_srq(srq, "max_wr(%d) > max_srq_wr(%d)\n",
 				attr->max_wr, rxe->attr.max_srq_wr);
 			goto err1;
 		}
 
 		if (attr->max_wr <= 0) {
-			pr_warn("max_wr(%d) <= 0\n", attr->max_wr);
+			rxe_dbg_srq(srq, "max_wr(%d) <= 0\n", attr->max_wr);
 			goto err1;
 		}
 
 		if (srq->limit && (attr->max_wr < srq->limit)) {
-			pr_warn("max_wr (%d) < srq->limit (%d)\n",
+			rxe_dbg_srq(srq, "max_wr (%d) < srq->limit (%d)\n",
 				attr->max_wr, srq->limit);
 			goto err1;
 		}
@@ -122,13 +122,13 @@ int rxe_srq_chk_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 
 	if (mask & IB_SRQ_LIMIT) {
 		if (attr->srq_limit > rxe->attr.max_srq_wr) {
-			pr_warn("srq_limit(%d) > max_srq_wr(%d)\n",
+			rxe_dbg_srq(srq, "srq_limit(%d) > max_srq_wr(%d)\n",
 				attr->srq_limit, rxe->attr.max_srq_wr);
 			goto err1;
 		}
 
 		if (attr->srq_limit > srq->rq.queue->buf->index_mask) {
-			pr_warn("srq_limit (%d) > cur limit(%d)\n",
+			rxe_dbg_srq(srq, "srq_limit (%d) > cur limit(%d)\n",
 				attr->srq_limit,
 				srq->rq.queue->buf->index_mask);
 			goto err1;
-- 
2.34.1

