Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5B6765C23
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 21:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjG0T3i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 15:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjG0T3f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 15:29:35 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A339D30EB
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:29 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-55e1ae72dceso945572eaf.3
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690486168; x=1691090968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Nc50FVncZ2IVPM6QTujb5QZN24UXhvEl5eqKrdS9c4=;
        b=ABfBgav1XwUr5fXXota8QbJqoTxtzuiXwbhK/Yeedw0mp6SqP9G3qY7kD9S/gTxO3j
         LpBo2kozXQzeBOZb+15eDxGD5bMXacNk+eqX8/Ab1+n+NypwRgf4K9e9Fbaa2/F6YN4u
         3p4LMcT5a55xFby8JNsyALpMbnFSo1Pi0sUPLwydj2OV53V2x+Ow2bwCUbm0MuooOQj/
         d5IrbiI/Nm5dd/x0OMTJz78h56m/ZFxHBHoPmQcheJJ3u8KLYovBtBTuUcjtmgdXG3c0
         KYs3/EXORqC52SJE9m2yhFEOsXvHTc68rWqOFLFqleaYdH15KyFsJXa88qpbQ3Oc05Jd
         /DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690486168; x=1691090968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Nc50FVncZ2IVPM6QTujb5QZN24UXhvEl5eqKrdS9c4=;
        b=YmDdgdIMifOsFkxrmikXCkPijjopg6XhB1p+GWRswOT4psfiMvoq3NXbjdXd89m0Qy
         Ef0cliM4gOf3zZsuEvcqNla/5tMi2M5xye8xrIVpup78kOs2GAyCLbHoo6KM38CP2aJJ
         xCLLUHZ2xCJ6FSS7oytDzIY6XavRnppZnOLYOnqL0fAIjMmI/JGz8aKruj6NI9e0WUOR
         LNq9/LWC+A2poYWxkgfZozJEv6XVBe0icYBDZMtBGjm+scv0rJdBy1WkHZ39kGLy9fYD
         KsPc6WjTz32weDZTsGCPJcVHn7f+d6TKWI72oWzSl/W6h3wwxwCNwRilNWRR8OiHYhJ/
         7R0w==
X-Gm-Message-State: ABy/qLb57ZZht2oRHKLWNAYVh8Q2IBZ9QggAfoelWi0gVpY6pzQvBgjX
        TV1GsSsE8NIiLjPCElXxM5GGAaQ7s5s=
X-Google-Smtp-Source: APBJJlEAKySnwwtanHi4jovHqwFT/ill+IiFtXOqNADMZpN+BisMz06gotu26t6drkNF5wm2f6cdYw==
X-Received: by 2002:a4a:7656:0:b0:567:27f4:8c45 with SMTP id w22-20020a4a7656000000b0056727f48c45mr348876ooe.8.1690486168361;
        Thu, 27 Jul 2023 12:29:28 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id f185-20020a4a58c2000000b005658aed310bsm955354oob.15.2023.07.27.12.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:29:27 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 7/8] RDMA/rxe: Combine setting pkt info
Date:   Thu, 27 Jul 2023 14:28:31 -0500
Message-Id: <20230727192831.65495-8-rpearsonhpe@gmail.com>
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

Move setting some rxe_pkt_info fields in rxe_init_packet() together
with the rest of the fields in rxe_init_req_packet() and
prepare_ack_packet().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c  |  6 ------
 drivers/infiniband/sw/rxe/rxe_req.c  |  4 +++-
 drivers/infiniband/sw/rxe/rxe_resp.c | 12 ++++++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 006c2d60f04d..94e347a7f386 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -516,7 +516,6 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 	unsigned int hdr_len;
 	struct sk_buff *skb = NULL;
 	struct net_device *ndev = rxe->ndev;
-	const int port_num = 1;
 
 	if (av->network_type == RXE_NETWORK_TYPE_IPV4)
 		hdr_len = ETH_HLEN + sizeof(struct udphdr) +
@@ -540,11 +539,6 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 	else
 		skb->protocol = htons(ETH_P_IPV6);
 
-	pkt->rxe	= rxe;
-	pkt->port_num	= port_num;
-	pkt->hdr	= skb_put(skb, pkt->paylen);
-	pkt->mask	|= RXE_GRH_MASK;
-
 out:
 	return skb;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 8423d259f26a..4db1bacdfdb8 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -512,7 +512,7 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 	pkt->opcode = opcode;
 	pkt->qp = qp;
 	pkt->psn = qp->req.psn;
-	pkt->mask = rxe_opcode[opcode].mask;
+	pkt->mask = rxe_opcode[opcode].mask | RXE_GRH_MASK;
 	pkt->wqe = wqe;
 	pkt->port_num = 1;
 
@@ -535,6 +535,8 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 		goto err_out;
 	}
 
+	pkt->hdr = skb_put(skb, pkt->paylen);
+
 	/* init roce headers */
 	rxe_init_roce_hdrs(qp, wqe, pkt);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 7e79d3e4d64e..8a25c56dfd86 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -768,6 +768,13 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	struct sk_buff *skb;
 	int err;
 
+	ack->rxe = rxe;
+	ack->qp = qp;
+	ack->opcode = opcode;
+	ack->mask = rxe_opcode[opcode].mask | RXE_GRH_MASK;
+	ack->psn = psn;
+	ack->port_num = 1;
+
 	/*
 	 * allocate packet
 	 */
@@ -779,10 +786,7 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	if (!skb)
 		return NULL;
 
-	ack->qp = qp;
-	ack->opcode = opcode;
-	ack->mask = rxe_opcode[opcode].mask;
-	ack->psn = psn;
+	ack->hdr = skb_put(skb, ack->paylen);
 
 	bth_init(ack, opcode, 0, 0, ack->pad, IB_DEFAULT_PKEY_FULL,
 		 qp->attr.dest_qp_num, 0, psn);
-- 
2.39.2

