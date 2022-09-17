Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED475BB5CE
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIQDLy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiIQDLW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:11:22 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0BC4DF25
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:20 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-12c8312131fso4530250fac.4
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Qv+MFCfjBy9qlntNACjCRozVQRuJY60ehMS3GyMG2/8=;
        b=ixdvqOTXOHRkBAZgeXHmG4i/sUug4F3bSGOFmPP20d8lB6m+KmMF6LBHy/1niEEZBy
         5A3hg70lifLhDV6q8IJiinrmcW3ZuKFerx14tInHj8jVXTPF70PAwunl1rEr79wd211K
         Hacy1uy5yal1YbINp4+waO0xU4HgCIM8vE36JYqQSRrrsU2UB3yoXOyr94jP19j7K2yr
         nWHGNgqCCPJL8sDq0ktXQ7BcSWZbtyDrgCDK0fe6joz5TmS8xgtpO/jhE93cvdrasCt3
         apU/Wli83rChIJA1ufe92v3BZWHJF17WUFI9ylIOOHBRNxbFaU0BYqhDlFDXGW8iTMM3
         O9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Qv+MFCfjBy9qlntNACjCRozVQRuJY60ehMS3GyMG2/8=;
        b=Vb7NYJHpR5DyJRU6dG7yiJbBli5/880CIzHeRzOJewbYI/Z+SianOvdEqu/4vPtkSU
         p3N+mIALD+ojfQyvrDfESjIk0zj0jrQwvmfG7oIUU/02KQrEF3rEfKnrf9Le/N23sGWi
         IFHAiS2GPA215MlI11ZvdSFeqcn/RnLOrC7Z62jfvm4cVwrhG5qapypQfG/KFzpY6hWg
         sMFTc0UeHQmkY77VhndAYkbDMYCowNO0rTCniaFAeRX+8RuqTulS5oMh+ePfPcIesPHl
         2XPBn21wMUxyOMm9qCmurRo2Ym66zQJMDN8zo0mvnd0srqsfvkROwFC9WXxKiZYuEZwV
         erQQ==
X-Gm-Message-State: ACrzQf0zghCmX9VCq8yl5wvcaKNFHnsbUh/1Sop3QIneYRE23tOPiUsu
        G3fJ6BPiWOEY2+QcJ+C74WE=
X-Google-Smtp-Source: AMsMyM527px44S7PwMcOFSVxE7sAeFgHKG/yi7pABUjaROyVJCD2fj7QyrqXC215LPfJ/JylBr+yPg==
X-Received: by 2002:a05:6870:c14f:b0:12b:1ca6:8f4a with SMTP id g15-20020a056870c14f00b0012b1ca68f4amr4676226oad.90.1663384279385;
        Fri, 16 Sep 2022 20:11:19 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id q17-20020a4a6c11000000b00475f26931c8sm921422ooc.13.2022.09.16.20.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:11:18 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 12/13] RDMA/rxe: Extend rxe_net.c to support xrc qps
Date:   Fri, 16 Sep 2022 22:11:03 -0500
Message-Id: <20220917031104.21222-13-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031104.21222-1-rpearsonhpe@gmail.com>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
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

Extend code in rxe_net.c to support xrc qp types.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index d46190ad082f..d9bedd6fc497 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -92,7 +92,7 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 {
 	struct dst_entry *dst = NULL;
 
-	if (qp_type(qp) == IB_QPT_RC)
+	if (qp_type(qp) == IB_QPT_RC || qp_type(qp) == IB_QPT_XRC_INI)
 		dst = sk_dst_get(qp->sk->sk);
 
 	if (!dst || !dst_check(dst, qp->dst_cookie)) {
@@ -120,7 +120,8 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 #endif
 		}
 
-		if (dst && (qp_type(qp) == IB_QPT_RC)) {
+		if (dst && (qp_type(qp) == IB_QPT_RC ||
+			    qp_type(qp) == IB_QPT_XRC_INI)) {
 			dst_hold(dst);
 			sk_dst_set(qp->sk->sk, dst);
 		}
@@ -386,14 +387,23 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
  */
 static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
-	memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
+	struct rxe_pkt_info *new_pkt = SKB_TO_PKT(skb);
+
+	memset(new_pkt, 0, sizeof(*new_pkt));
+
+	/* match rxe_udp_encap_recv */
+	new_pkt->rxe = pkt->rxe;
+	new_pkt->port_num = 1;
+	new_pkt->hdr = pkt->hdr;
+	new_pkt->mask = RXE_GRH_MASK;
+	new_pkt->paylen = pkt->paylen;
 
 	if (skb->protocol == htons(ETH_P_IP))
 		skb_pull(skb, sizeof(struct iphdr));
 	else
 		skb_pull(skb, sizeof(struct ipv6hdr));
 
-	if (WARN_ON(!ib_device_try_get(&pkt->rxe->ib_dev))) {
+	if (WARN_ON(!ib_device_try_get(&new_pkt->rxe->ib_dev))) {
 		kfree_skb(skb);
 		return -EIO;
 	}
@@ -412,7 +422,6 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 
 	if ((is_request && (qp->req.state != QP_STATE_READY)) ||
 	    (!is_request && (qp->resp.state != QP_STATE_READY))) {
-		pr_info("Packet dropped. QP is not in ready state\n");
 		goto drop;
 	}
 
@@ -427,8 +436,8 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		return err;
 	}
 
-	if ((qp_type(qp) != IB_QPT_RC) &&
-	    (pkt->mask & RXE_LAST_MASK)) {
+	if ((pkt->mask & RXE_REQ_MASK) && (pkt->mask & RXE_LAST_MASK) &&
+	    (qp_type(qp) != IB_QPT_RC && qp_type(qp) != IB_QPT_XRC_INI)) {
 		pkt->wqe->state = wqe_state_done;
 		rxe_run_task(&qp->comp.task, 1);
 	}
-- 
2.34.1

