Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E787508E5B
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Apr 2022 19:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355509AbiDTR1E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 13:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243846AbiDTR1D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 13:27:03 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DB445065
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 10:24:16 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id e189so2799159oia.8
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DtsgZ1ds7jxE2AzjxjHhajOgNxFupSvPhZPQASbup80=;
        b=ZEErxYckjVlR/ndZa09Xb9qR/tE5xxZ2upBbVwdhhtAac2CWekjj0ctmEkALl///wG
         rRT0SwZhots9Q9yopyjaAUBiB3BDDtoCqVxJJ76GSkoMmZuLTc/okA6ZFC1Jj5oNLDFg
         1Y2jm13OGEpQQB9DYaxgI07buOpiWUpOD4qIXEDXgOnM61MMi5rD5xt1qZiCHkf5knQl
         LODtPQ4wbeiWlP/3meEeJk6M3uXSmp6ZWMiHjUg9npw12KCNtOOdrF10EBmB51nknzCs
         fKCuOcmsMcPRv51KqtT8C7KIOHb7O8Pfc2VAv6+OZXdWbt6HaUCaF0Mpey/3Y+TGqXsj
         kcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DtsgZ1ds7jxE2AzjxjHhajOgNxFupSvPhZPQASbup80=;
        b=av/kB+eXhNQ9B8MCUjAwyT22H5XQnFMB0ayr30uoodZprXr+9kJY1C27kAqVPp+BvI
         BgJHsH9ux7PY2874414ZqwQEonAxj4CSwYZ4havXp5cL7dNvWD85fKcdK60JZlwWGuKH
         /1W4LWho3SKUeibv7cMPgh72guVpO0XuZGMWrfS4h1+JYTr3sbMw6JXwXbwz0EKZfJpQ
         bwLtQP+HJRsFnF+T6byNhQ62p0o7YoBreAFIzbr68WjrPeQBmoT+BXMcWSqIAV0S3nfA
         jgcwG6ipM58yTpoZe0idEm997AT1ZpMDCE3UV1ZyhqxG3mkAkEl+76tOeZaRB4Z+be88
         oCwA==
X-Gm-Message-State: AOAM533z25HF8jCEGyhvbQd00tOJUPXKakV7uauILjGgLiD6X1OJMl0J
        zK7W667d8ikAGaGu6GDwFSjm7MCT9j8=
X-Google-Smtp-Source: ABdhPJxV8zMVqjbWM/55NV2fXK5/eU1eNMJpeFfe3DIAFUGrMCp5IF8PkT+uzjxQwjvEaHEZkRXYnA==
X-Received: by 2002:a05:6808:ec5:b0:2f9:a7fb:4dfb with SMTP id q5-20020a0568080ec500b002f9a7fb4dfbmr2322713oiv.156.1650475456161;
        Wed, 20 Apr 2022 10:24:16 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-02db-d105-a6dd-c1d6.res6.spectrum.com. [2603:8081:140c:1a00:2db:d105:a6dd:c1d6])
        by smtp.googlemail.com with ESMTPSA id w2-20020a4a7642000000b0033a2cdbe62fsm5022259ooe.45.2022.04.20.10.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 10:24:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix typo: replace paylen by payload
Date:   Wed, 20 Apr 2022 12:23:17 -0500
Message-Id: <20220420172316.5465-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
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

In finish_packet() in rxe_req.c a variable was incorrectly called
paylen instead of payload. Elsewhere in the rxe source payload is
always used for the RoCE payload length and paylen is always used
for the UDP payload length. This will cause unnecessary confusion.

Replace paylen by payload in finish_packet().

Fixes: 63221acb0c631 ("RDMA/rxe: Fix ref error in rxe_av.c")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index e2659663b283..9bb24b824968 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -435,7 +435,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 
 static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,
 			 struct rxe_send_wqe *wqe, struct rxe_pkt_info *pkt,
-			 struct sk_buff *skb, u32 paylen)
+			 struct sk_buff *skb, u32 payload)
 {
 	int err;
 
@@ -447,19 +447,19 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,
 		if (wqe->wr.send_flags & IB_SEND_INLINE) {
 			u8 *tmp = &wqe->dma.inline_data[wqe->dma.sge_offset];
 
-			memcpy(payload_addr(pkt), tmp, paylen);
+			memcpy(payload_addr(pkt), tmp, payload);
 
-			wqe->dma.resid -= paylen;
-			wqe->dma.sge_offset += paylen;
+			wqe->dma.resid -= payload;
+			wqe->dma.sge_offset += payload;
 		} else {
 			err = copy_data(qp->pd, 0, &wqe->dma,
-					payload_addr(pkt), paylen,
+					payload_addr(pkt), payload,
 					RXE_FROM_MR_OBJ);
 			if (err)
 				return err;
 		}
 		if (bth_pad(pkt)) {
-			u8 *pad = payload_addr(pkt) + paylen;
+			u8 *pad = payload_addr(pkt) + payload;
 
 			memset(pad, 0, bth_pad(pkt));
 		}

base-commit: b5a93e79df64c32814f0edefdb920b540cbc986a
-- 
2.32.0

