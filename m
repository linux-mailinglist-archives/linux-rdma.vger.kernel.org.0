Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A7E765C1D
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 21:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjG0T3e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 15:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjG0T30 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 15:29:26 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A46B2D75
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:25 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5661eb57452so914838eaf.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690486165; x=1691090965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AW2eisZB8LFflZPdRQNrvlYPitHp5FxyhEVepQEMqXQ=;
        b=WFNJbAcYSC2d8swdv6RSfUFnhE7eXAdb+dicXRPsyxCUvkR2cXFK2N5YU8nqfU4JcA
         0jyQnnePww3V/EGF9s6zWSyHh5EE8cb0su/FUNRGvlt0FuAgIMD5JSGKlDa5BqLDXn0Z
         OdkRTDXd9mxO5d7cEOqdeiu8DnwPZMAKuS95W9PPV/bRtZCi/BzA/blKuvTDZUHjoQ9M
         BpLLzcFKXNqj8JRS59bVbIm0ZyevFRq/pXFRIull+pdESc7zK0OBiS0w8w18vVPqFhL3
         CBfqenEgvlFK5Y6bM1QdltqDsFEvVxhmIUm7y3B2TvLofGMEkbtHFmXqZQX9g/ixCAPx
         wAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690486165; x=1691090965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AW2eisZB8LFflZPdRQNrvlYPitHp5FxyhEVepQEMqXQ=;
        b=V73V5065q+5CEnYXxqJERJCR1w9pJeh+QlB7bQ6wJU3XspNANYMen4EXupxcI5c9r4
         n1FSK9hDJpk1k/NIXnyJFx5l17vLukTeTAYo61bC/xPAZem83QbtqgCBLG6yI5lffgFX
         basYeP6NEWMFsgalEgDT7FEEtd5jWvbsLGhgrIudAV3FaHW7Mu5xwcdIzmVKGIv3cgWd
         QYqGjAi2JIFd89wapMXMbEP52fTE1EglMFc7fNvVTPffJVIvNpmuDw5D4fXScT8f5Oop
         9riEMG/KA3Qc6YIBKxmtCnrXxL+31MSN5JPfKLh1QV8L1iFOm3/LveGt0ECaoVc0QnlJ
         DCqg==
X-Gm-Message-State: ABy/qLbAwKwylwHvlpfHsPG55O+pqaA5bGmOeNzjTHJ0aF1ErvQ0xzVW
        tvmB4hgHLA8tT/pBcXAPUdQ=
X-Google-Smtp-Source: APBJJlEPyZHdkVefhYzdss+dga/Nt4gNLWh96AEj3P/YXojElMDSN31r1YWeZ+4nhEaFufDP2jN29Q==
X-Received: by 2002:a4a:3003:0:b0:566:f2b9:eb86 with SMTP id q3-20020a4a3003000000b00566f2b9eb86mr409326oof.4.1690486164432;
        Thu, 27 Jul 2023 12:29:24 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id f185-20020a4a58c2000000b005658aed310bsm955354oob.15.2023.07.27.12.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:29:23 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 3/8] RDMA/rxe: Isolate request payload code in a subroutine
Date:   Thu, 27 Jul 2023 14:28:27 -0500
Message-Id: <20230727192831.65495-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727192831.65495-1-rpearsonhpe@gmail.com>
References: <20230727192831.65495-1-rpearsonhpe@gmail.com>
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

Isolate the code that fills the payload of a request packet into
a subroutine named rxe_init_payload().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 34 +++++++++++++++++------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 6e9c8da001a4..c92e561b8a0b 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -477,6 +477,25 @@ static void rxe_init_roce_hdrs(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	}
 }
 
+static int rxe_init_payload(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
+			    struct rxe_pkt_info *pkt, u32 payload)
+{
+	void *data;
+	int err = 0;
+
+	if (wqe->wr.send_flags & IB_SEND_INLINE) {
+		data = &wqe->dma.inline_data[wqe->dma.sge_offset];
+		memcpy(payload_addr(pkt), data, payload);
+		wqe->dma.resid -= payload;
+		wqe->dma.sge_offset += payload;
+	} else {
+		err = copy_data(qp->pd, 0, &wqe->dma, payload_addr(pkt),
+				payload, RXE_FROM_MR_OBJ);
+	}
+
+	return err;
+}
+
 static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 				       struct rxe_av *av,
 				       struct rxe_send_wqe *wqe,
@@ -513,20 +532,7 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,
 		return err;
 
 	if (pkt->mask & RXE_WRITE_OR_SEND_MASK) {
-		if (wqe->wr.send_flags & IB_SEND_INLINE) {
-			u8 *tmp = &wqe->dma.inline_data[wqe->dma.sge_offset];
-
-			memcpy(payload_addr(pkt), tmp, payload);
-
-			wqe->dma.resid -= payload;
-			wqe->dma.sge_offset += payload;
-		} else {
-			err = copy_data(qp->pd, 0, &wqe->dma,
-					payload_addr(pkt), payload,
-					RXE_FROM_MR_OBJ);
-			if (err)
-				return err;
-		}
+		err = rxe_init_payload(qp, wqe, pkt, payload);
 		if (pkt->pad) {
 			pad_addr = payload_addr(pkt) + payload;
 			memset(pad_addr, 0, pkt->pad);
-- 
2.39.2

