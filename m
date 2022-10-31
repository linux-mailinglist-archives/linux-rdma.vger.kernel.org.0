Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2C4613EF7
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJaU2b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJaU2a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:30 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ECA65C1
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:29 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id r76so7424876oie.13
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEmM98qWgdC7JibJI9d8dkTVJi2BBzT4fZsK+PNxQ0c=;
        b=LhXphGaQbFkko/hOvbhUZhvsXGT4pLXhSF8t4T0UMvvDC0hcj7WcaPE4XrhRcshp+d
         QLmuGR29k6PqJ1IyMlbDLa+FmuTCKP4+1mU9Fql5y8SqdqUqE6N+kAfg1wsyg+7OV7ep
         mRhzQjxku5h/EjCzo2Hb8/I4/FeQEQJRTAhZ66U2ahn0s5l9fb0fm73Wz+M/QgD5NRnj
         ekbCsk8Xs+nQ1LFtz1PFdpLFbcctwh4wwYC5juwrRW3Ser5YHRrWBgrX9/4cXVp4jqJ6
         VCCNfyc53ujUPVZOmLQJQtLXkpDl5W2X8x0YRur9qrZcKQgZkyL9GMddvRpXh2F4V0SS
         gq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEmM98qWgdC7JibJI9d8dkTVJi2BBzT4fZsK+PNxQ0c=;
        b=ynzmS55If85TUB8xbf3h9GDJPGGQt5KAups12gcq2KudwotKEUHwHSfSz6hSmPcsCt
         BT/E/5wA1yxyc3BWEF+Nn2ePVn8t8XKKk4B1VOF6ckAxxy+/bUGm9rcn6SX1SIpwbTMu
         lfPyUQCMv5aWTvYaC9I8jM1qnqoTWdWjkCeKlOvvKr55IqhpIV6ZS8zGfw1EO4vMSUd7
         djOhomDb/1S0+qHGYEZ1l0PvcIX5fGBsWyuytYpbY6u5ge7YU3u9DOdLXQlsY4XeqIzJ
         7OgAfjJOTNwpDs1sdVW06vJIoQFmHr5blMX8koGtdvRKcnHhp+vhrMp6+kx+OG94dN0I
         vUIA==
X-Gm-Message-State: ACrzQf1/Z1F7K6WktCF0V1jqQQyroCyNin+9WRkuCOf2/vcUHQiBskxF
        tldM+6IxLm6hmVZ92c2Nc2I=
X-Google-Smtp-Source: AMsMyM4hpfFC9LoUhXbZe6FFpb/pBPn4rIftuwKlui//dFVaIGjpE66MqiuArCDY60IPpno7pcQqww==
X-Received: by 2002:a05:6808:17a7:b0:355:3cba:7d41 with SMTP id bg39-20020a05680817a700b003553cba7d41mr7490165oib.244.1667248109234;
        Mon, 31 Oct 2022 13:28:29 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:28 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 02/18] RDMA/rxe: Isolate request payload code in a subroutine
Date:   Mon, 31 Oct 2022 15:27:51 -0500
Message-Id: <20221031202805.19138-2-rpearsonhpe@gmail.com>
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

Isolate the code that fills the payload of a request packet into
a subroutine named rxe_init_payload().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 34 +++++++++++++++++------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index bcfbc78c0b53..10a75f4e3608 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -437,6 +437,25 @@ static void rxe_init_roce_hdrs(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
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
@@ -473,20 +492,7 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,
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
 		if (bth_pad(pkt)) {
 			u8 *pad = payload_addr(pkt) + payload;
 
-- 
2.34.1

