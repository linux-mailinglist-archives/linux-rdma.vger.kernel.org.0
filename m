Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B25613F06
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJaU3E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJaU2w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:52 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ABD13FAC
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:50 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13bd2aea61bso14790801fac.0
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKi9h7WR9eMA4SBNRrq6cYz+ShYuF0Y3JvfUyZYr89o=;
        b=bBxzCMlJIKmqxS1ioSNPDGCGwRJAyOYa3geQo5Q0DNKM61WpA0gc+KLt0e/LTd+24D
         xokQH1vwpGwgNnZjE4JyV8E9Q3nBXpjdx+xhCfFqyE8PeR4Hrw0cYj9xl9/82oXja1If
         3+PLglat0LJwXxX6uGljz4Zj5qCCLafy9JXNplZS/IEUgXH0QJ5I648OKdkClFBvtxDC
         jMTznTTJW9vlvoikIrtuRvNphWVLGTFycgkE1pBaVHn4oIIhnRkb/JW4Sau9jrHzaakU
         Dv00q8C97/J1YLBIdkqAdzU/M9+9c7UkrMD6L6Ol2WFTvWnDfjCHOE7t4xI+EGXHgkiO
         dMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKi9h7WR9eMA4SBNRrq6cYz+ShYuF0Y3JvfUyZYr89o=;
        b=AdTgMLnsLoSKCuj1SgX/u4IZh5RGNf6w5FmY+zysV8NlJGI150MwK+eULk/t081CVV
         C1wBiIp6z3UGEunuHbh5itf9djQQbru2TbDocl6VHlsl6LOHPl4yWoHIR+bRX3JB8yM4
         b1rj/Hpl+2ELKkc7ahO4NQ+fCev1NwyKToBQbzzzEfPLe1H0zqRYfNwMUtTPgt03jknk
         GWskfpDbLQvaJes6EifUf5D/CaS+BZ29UBycoZJM41hmYL21SZaNfTvCFbB24hvPgzm+
         tIXwFVKTDXyrC4zYIgPI6xdGsj+IvTgb9wCe6z716KVM0yJu+jSGz7r6cR7DLk/2i/HP
         hNCA==
X-Gm-Message-State: ACrzQf3+3NSO+ANHiTcOWYtaJ30icfwxh5I4ZtExJM2SuuxXc6wfilGY
        4VxmGxO/aTERjToSUyt0UyKUinXAgKg=
X-Google-Smtp-Source: AMsMyM5FXNXjst4LtqVRv1cJaQpFuffqFbUsU/CDrsqUnYBSTM5I9ZCJukhJnb0hArllUTxie83cbQ==
X-Received: by 2002:a05:6870:b392:b0:136:71ed:c874 with SMTP id w18-20020a056870b39200b0013671edc874mr18225570oap.66.1667248130094;
        Mon, 31 Oct 2022 13:28:50 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:49 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 17/18] RDMA/rxe: Extend do_read() in rxe_comp,c for frags
Date:   Mon, 31 Oct 2022 15:28:06 -0500
Message-Id: <20221031202805.19138-17-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031202805.19138-1-rpearsonhpe@gmail.com>
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
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

Extend do_read() in rxe_comp.c to support fragmented skbs.

Rename rxe_do_read(). Adjust caller's API.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 40 ++++++++++++++++++----------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 3c1ecc88446d..85b3a4a6b55b 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -348,22 +348,34 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
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
-
-	ret = rxe_copy_dma_data(skb, qp->pd, IB_ACCESS_LOCAL_WRITE,
-				&wqe->dma, payload_addr(pkt),
-				skb_offset, payload_size(pkt),
-				RXE_COPY_TO_MR);
-	if (ret) {
-		wqe->status = IB_WC_LOC_PROT_ERR;
+	int nr_frags = skb_shinfo(skb)->nr_frags;
+	u8 *data_addr = payload_addr(pkt);
+	int data_len = payload_size(pkt);
+	enum rxe_mr_copy_op op = nr_frags ? RXE_FRAG_TO_MR : RXE_COPY_TO_MR;
+	int skb_offset = data_addr - skb_transport_header(skb);
+	int err;
+
+	err = rxe_copy_dma_data(skb, qp->pd, IB_ACCESS_LOCAL_WRITE,
+				&wqe->dma, data_addr,
+				skb_offset, data_len, op);
+	if (err)
 		return COMPST_ERROR;
-	}
 
 	if (wqe->dma.resid == 0 && (pkt->mask & RXE_END_MASK))
 		return COMPST_COMP_ACK;
@@ -625,7 +637,7 @@ int rxe_completer(void *arg)
 			break;
 
 		case COMPST_READ:
-			state = do_read(qp, pkt, wqe);
+			state = rxe_do_read(qp, pkt, wqe);
 			break;
 
 		case COMPST_ATOMIC:
-- 
2.34.1

