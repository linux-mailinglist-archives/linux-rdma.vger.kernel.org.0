Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404BB6100DB
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbiJ0S4k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiJ0S4c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:32 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FA318E0A
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:29 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id d18-20020a05683025d200b00661c6f1b6a4so1615778otu.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKi9h7WR9eMA4SBNRrq6cYz+ShYuF0Y3JvfUyZYr89o=;
        b=j7iBOKSHfJaPm/Y2NcipGr23x5FLCCl0zdS1Dt1kaADKXJMC0ZiUMU/9rH/OsEJTKk
         LwsVuHyPx0X/ubwLDCQFGdkLFXA7kbobfkXNiTrY6TsxjZeDe8DAaN8YH6XOd4mlPzwf
         vF92WDTMFYHFOUwxelYbQxFrvrVrH+yrlHB6cSOChjKdDPk8VGF8poK1IrUGevoY+Myu
         NLjyaFQ0q/gaRXTSKBD5H4SRwQk0bWBiEa0Y1kKkyHojf7OpnPIDT1QPMDModE1Chz8r
         iJqJ/sNLX6sndOMrzVGeOI1W7qUkHvM2Fj6dwAR4F1O6pfhZBhv7PQsqYLfEqVyR+N92
         79rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKi9h7WR9eMA4SBNRrq6cYz+ShYuF0Y3JvfUyZYr89o=;
        b=SuONx9OEmBKxQw9fNLcJwvK631IurSbdXwCwqFvv/SNQDbdDor5o7M+INWglJFXiuw
         bAbfV6HfA83KE5W4M6XaOLyTTYa8qE6VbpLre2Q5gG8ITh2wVx0tvk3r0b/KMEXhptOC
         5Wn8xxOD0OwTMH+UqBPMZzPBnGlF5D3Z7diNqx115WOVR60RUMiLC40nLRRkHwyc8ix3
         pksmtuKGWqgQWjFzAHHwxc92uIKZYrrbzHxxB2LMrUQN7VnVHPUI9/CAj3U8wcVp3LZf
         YSQHXgbmo5R2iD4m0GPbnvGRFxevejGFe/tCJ2qUSu3UrNbyzOh/9J9QmEqzVUqmKTR6
         duZw==
X-Gm-Message-State: ACrzQf3SBB6HQ6y+evjQtghy32BbpqBNfBjgce8reqHkZfRT0SxEzp/E
        RJaZi71BLgpN0pnhJ6nepXg=
X-Google-Smtp-Source: AMsMyM6PGlajGwjqcvgSZgENifM8+VP7y9QLTR3r8CbvlB0UUb4udmu3Itd9Yfaqh9+Iaz80exJ3hA==
X-Received: by 2002:a05:6830:131a:b0:666:fe36:1f86 with SMTP id p26-20020a056830131a00b00666fe361f86mr6897545otq.272.1666896989221;
        Thu, 27 Oct 2022 11:56:29 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:28 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 16/17] RDMA/rxe: Extend do_read() in rxe_comp,c for frags
Date:   Thu, 27 Oct 2022 13:55:10 -0500
Message-Id: <20221027185510.33808-17-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027185510.33808-1-rpearsonhpe@gmail.com>
References: <20221027185510.33808-1-rpearsonhpe@gmail.com>
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

