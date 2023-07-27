Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E214A765CCC
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 22:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjG0UCe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 16:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjG0UCc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 16:02:32 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C0F30CD
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:21 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b9edef7993so1088542a34.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690488140; x=1691092940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jv4JZdZiF1836Z7KBUUppYgX/3nVIYsPvkge6EqPA74=;
        b=LTvlSpOyHMHCuRZNu9OPkvt6EPLcsQ3e1DkNP0tyy6vSUnIGPax6q76Jb7Sj2jEROF
         I3twL1+cVlcujFwQHvEwCE9pIMA1Jq2yRWSoHxbpgWgo9/FJCHwTUp+JHANwEHj8YQZc
         Y5IZv4Dmzc67qeY1KKtfpRg+zvavfmH04i95bNAAIBqcElHgX1mmLrD5c+UfxadGKAwp
         sDgzzQf5fJr+EWTXP/VBoMYnf0Y+zF9RmJvK7xJIDXBRo1mxgnAqU2IodFavmCEYMxVP
         hTfpEUqvHdX8KtygLT4FGVHpEb+f7h/M7BuFGZKy7mEI0EZp3blDvT2M4PxiZufOZBYI
         /yFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488140; x=1691092940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jv4JZdZiF1836Z7KBUUppYgX/3nVIYsPvkge6EqPA74=;
        b=jvH8TbDbLBQroIFT6kFr+dW7F8oYvRgWI0dWkHinXbhU/NLm4HSltvmXIhA83ACAoO
         zpHo2NCBFpkMjIOIPSrkTXnIP7/zxtt8+sB2zKgWKyrU7jCuVgXy5JxxSbi8zZl+V0Ov
         1dgy+GcY5vmR4F2sMGQcgN0BB5cQTdwTbSPF0wuIoGf4EJ2Tm5aPGoxa0sFrd6zGWgwp
         1y2fCyw/xceaqJTe2CBEd5UVxA95VmUYaKmFxl2RrxQypfkUWT6QyPGyYmww5/3GKaR5
         xD2116ghhKenIIByZ2Hkv9X5GrH6+/0JKG57AqMEW0lgCAW9QviWSashVMj3Fevkt4iy
         vKEw==
X-Gm-Message-State: ABy/qLa5X+7nsem7BeYd3VKHE6g2CKPVoKqljowsEwhcRN6Mz443s5Zd
        g2Mi8+tim+p86m0lm36c+g8=
X-Google-Smtp-Source: APBJJlGbH5NgePVFcdeie2VMMu6MThpK5V1nGnxEwI9h8NzR2AC9rhM0ugSNydMHcjaembZh9SZNtw==
X-Received: by 2002:a05:6870:4396:b0:1b0:5bf7:3bb6 with SMTP id r22-20020a056870439600b001b05bf73bb6mr540493oah.28.1690488140656;
        Thu, 27 Jul 2023 13:02:20 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id m3-20020a9d73c3000000b006b9acf5ebc0sm938142otk.76.2023.07.27.13.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:02:20 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 09/10] RDMA/rxe: Extend do_read() in rxe_comp.c for frags
Date:   Thu, 27 Jul 2023 15:01:28 -0500
Message-Id: <20230727200128.65947-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727200128.65947-1-rpearsonhpe@gmail.com>
References: <20230727200128.65947-1-rpearsonhpe@gmail.com>
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

Extend do_read() in rxe_comp.c to support fragmented skbs.

Rename rxe_do_read(). Adjust caller's API.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 39 ++++++++++++++++++----------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 670ee08f6f5a..ecaaed15c4eb 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -360,22 +360,35 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 	return COMPST_ERROR;
 }
 
-static inline enum comp_state do_read(struct rxe_qp *qp,
-				      struct rxe_pkt_info *pkt,
-				      struct rxe_send_wqe *wqe)
+/**
+ * rxe_do_read() - Process read reply packet
+ * @qp: The queue pair
+ * @pkt: Packet info
+ * @wqe: The current work request
+ *
+ * Copy payload from incoming read reply packet into current
+ * iova.
+ *
+ * Returns: 0 on success else an error comp_state
+ */
+static inline enum comp_state rxe_do_read(struct rxe_qp *qp,
+					  struct rxe_pkt_info *pkt,
+					  struct rxe_send_wqe *wqe)
 {
 	struct sk_buff *skb = PKT_TO_SKB(pkt);
-	int skb_offset = 0;
-	int ret;
+	u8 *data_addr = payload_addr(pkt);
+	int data_len = payload_size(pkt);
+	enum rxe_mr_copy_op op;
+	int skb_offset;
+	int err;
 
-	ret = rxe_copy_dma_data(skb, qp->pd, IB_ACCESS_LOCAL_WRITE,
-				&wqe->dma, payload_addr(pkt),
-				skb_offset, payload_size(pkt),
-				RXE_COPY_TO_MR);
-	if (ret) {
-		wqe->status = IB_WC_LOC_PROT_ERR;
+	op = skb_is_nonlinear(skb) ? RXE_FRAG_TO_MR : RXE_COPY_TO_MR;
+	skb_offset = rxe_opcode[pkt->opcode].length;
+	err = rxe_copy_dma_data(skb, qp->pd, IB_ACCESS_LOCAL_WRITE,
+				&wqe->dma, data_addr,
+				skb_offset, data_len, op);
+	if (err)
 		return COMPST_ERROR;
-	}
 
 	if (wqe->dma.resid == 0 && (pkt->mask & RXE_END_MASK))
 		return COMPST_COMP_ACK;
@@ -704,7 +717,7 @@ int rxe_completer(struct rxe_qp *qp)
 			break;
 
 		case COMPST_READ:
-			state = do_read(qp, pkt, wqe);
+			state = rxe_do_read(qp, pkt, wqe);
 			break;
 
 		case COMPST_ATOMIC:
-- 
2.39.2

