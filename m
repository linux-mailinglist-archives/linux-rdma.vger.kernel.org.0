Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A789F765C1F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 21:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjG0T3f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 15:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjG0T31 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 15:29:27 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CDC2D76
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:26 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56597d949b1so995881eaf.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690486165; x=1691090965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNAoAAHPcHhZFmhIslpmZ58QW7JAmbcneyNRSnwR644=;
        b=l4nYSebYHFMmkiEE8AlItH8EIBuYA1nzZIAzz92lt29SuO4HtNblR+VWOopcIN3f5i
         CmdzqSxQwkrVZ8qAg9vwsijD8IKnYtFqFXUxn51PiQlX92ECCHemr2JqPUxSJOEEQ00m
         8ZviOymc5cMrjI8B3vta5iycGwJ3cKcCMJGBg/9zdkniQ19ysgWblSQa4O/inFP3y/0m
         WA8unshFMG1CZDOcXTarrznxE7YIzmyj4C7tX2MYdOH0X6IJjAHPw7sln+toe+e8eqEy
         chSJGsdcn3M8xXB5CfbfwWk9gmcxxC2haobNmqowGsPBhKcHDJbeSEhON97R2TphueRz
         jXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690486165; x=1691090965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNAoAAHPcHhZFmhIslpmZ58QW7JAmbcneyNRSnwR644=;
        b=HS0+at35MkrLGkt2yd0eP0X+lpsKUWKHGD8++RF7jbg4EE7nbZNO1/N3ZoXyXN4rhz
         eflpEAY36BC7iyoKpo68wCO6L8L14kpyBdqgiEFF6qoPX8pDrpBj07SDAXozjRLBs39/
         r+bb6dAXxGMBstHxgreQW1K7+ec2IubHju+fRRFfjoZowQ4EenY+V/uulVMlqqWLUk9t
         UJWnIENk1LR31kxyIMlwS4ZH46dXsNdJEebjZAa4y4MBWHIZjvPyXoDldamttlV04KFg
         WRdoIQ+gwuDk+/J0warw3yw6VrjkXS+r/x2rbzQJce8GRFAd0dT80B7YpEmYcpUv5nNR
         vMhQ==
X-Gm-Message-State: ABy/qLaL/dASrTFU00jRywEWNUjpzf/Yo+hO5zQolSyyxC1Qb/pjR5LX
        4aplfJbF8dWfjkqV0uPeUAo=
X-Google-Smtp-Source: APBJJlHtLDqztWLUEHRr7++g3fOQvL81phv5KzlDPU0SiA3re8eTtMCR5rYYvs+ViaHbFIG4IZNPaA==
X-Received: by 2002:a4a:9c0d:0:b0:566:f6a0:87e4 with SMTP id y13-20020a4a9c0d000000b00566f6a087e4mr477677ooj.0.1690486165498;
        Thu, 27 Jul 2023 12:29:25 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id f185-20020a4a58c2000000b005658aed310bsm955354oob.15.2023.07.27.12.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:29:24 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 4/8] RDMA/rxe: Remove paylen parameter from rxe_init_packet
Date:   Thu, 27 Jul 2023 14:28:28 -0500
Message-Id: <20230727192831.65495-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727192831.65495-1-rpearsonhpe@gmail.com>
References: <20230727192831.65495-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove paylen as a parameter to rxe_init_packet() since it
is already available in pkt.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  | 2 +-
 drivers/infiniband/sw/rxe/rxe_net.c  | 7 ++++---
 drivers/infiniband/sw/rxe/rxe_req.c  | 2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 666e06a82bc9..cf38f4dcff78 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -90,7 +90,7 @@ void rxe_mw_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_net.c */
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
-				int paylen, struct rxe_pkt_info *pkt);
+				struct rxe_pkt_info *pkt);
 int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
 		struct sk_buff *skb);
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 0e447420a441..006c2d60f04d 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -511,7 +511,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 }
 
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
-				int paylen, struct rxe_pkt_info *pkt)
+				struct rxe_pkt_info *pkt)
 {
 	unsigned int hdr_len;
 	struct sk_buff *skb = NULL;
@@ -525,7 +525,8 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 		hdr_len = ETH_HLEN + sizeof(struct udphdr) +
 			sizeof(struct ipv6hdr);
 
-	skb = alloc_skb(paylen + hdr_len + LL_RESERVED_SPACE(ndev), GFP_ATOMIC);
+	skb = alloc_skb(pkt->paylen + hdr_len + LL_RESERVED_SPACE(ndev),
+			GFP_ATOMIC);
 	if (unlikely(!skb))
 		goto out;
 
@@ -541,7 +542,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 
 	pkt->rxe	= rxe;
 	pkt->port_num	= port_num;
-	pkt->hdr	= skb_put(skb, paylen);
+	pkt->hdr	= skb_put(skb, pkt->paylen);
 	pkt->mask	|= RXE_GRH_MASK;
 
 out:
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index c92e561b8a0b..e444e1f91523 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -511,7 +511,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 			pkt->pad + RXE_ICRC_SIZE;
 
 	/* init skb */
-	skb = rxe_init_packet(rxe, av, pkt->paylen, pkt);
+	skb = rxe_init_packet(rxe, av, pkt);
 	if (unlikely(!skb))
 		return NULL;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index fc2f55329fa2..7e79d3e4d64e 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -775,7 +775,7 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	ack->paylen = rxe_opcode[opcode].length + payload +
 			ack->pad + RXE_ICRC_SIZE;
 
-	skb = rxe_init_packet(rxe, &qp->pri_av, ack->paylen, ack);
+	skb = rxe_init_packet(rxe, &qp->pri_av, ack);
 	if (!skb)
 		return NULL;
 
-- 
2.39.2

