Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5ACD765CC7
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 22:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjG0UCU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 16:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjG0UCS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 16:02:18 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525EF30EA
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:16 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bb0cadd372so1192355a34.0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690488135; x=1691092935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VUZAH4t9v/jJjvjtu/ipb6pZgkz7czIPNVSSXt6MCk=;
        b=ASJ+W8DOCv4XOCoSQOXF9ouDf8qeigMCpDB9xFgigt5yh1buIa2i9mQomLrtAjNrHh
         ukobirvHeU7cbWQwBSQ56rX2ksS3rJrm1aH2dQL3llBp6d92O5mWGh9Be1TR30Ajib4M
         AAFkfREqoJk2MgsyCIXLG6jxVdxBIHQzfReqQrxkMHZoSUcMhuiO4Iv3+ClzVVdhOQ5I
         3+YnF0aAnJy4UeEe5uoVBt7FpqwCycByVRQNRHjjpsZFEEfJdq5HYDOr4zlFT+EkQD3q
         wecVl0WXQ7O+1L/XLXkprwtB2+Axq9+lQI1BYi8cEqRevjVyg7zNbUuIBh1QHArJlMeu
         h0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488135; x=1691092935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VUZAH4t9v/jJjvjtu/ipb6pZgkz7czIPNVSSXt6MCk=;
        b=dZpQTfpnzXUHVJnaKSaIpbyNzIPsvM8veBCjNj93rFWHvO4jkRaFEwJZX7VVrYkX8c
         Dm0hVTzHLZZuXWe2JPSTlP/G8CyG2hHFrx+av8fTF/aiNlJKVX+378jD/8apMj89pjvx
         4waFYztf52zDWryeaTNxnRGqann8zuaKnozCn2di6PxfhQtA2OrjYA1VPmihUi5aK3tW
         uoWcZug2ZFlTo8eRlBVSGu+P1cgN7abpRp94O3GyOic0dEyE0/R4W2CXLN1n/QKjeB2B
         wYU6YHFVzMoiFwjvVod8VaFF+l9jkLLDWAce5mwNnYiwHy+g9MnTvZFdmtldvNsYG6yn
         aqQA==
X-Gm-Message-State: ABy/qLZc5XV2fp7q/idzREOK7o1M7DrFvmd1Em2itTWTVq+jPdY3/iVE
        5D6cSW+nOCS0gdNeGKdP8tw=
X-Google-Smtp-Source: APBJJlFUYX7Th9jeAuXY4Y6xC8O6NYCOKuMIDH79MoRSXzb4y+xny6OV7cNtraaiQYhAqWQZOmG4Kw==
X-Received: by 2002:a05:6830:1481:b0:6bb:1036:46de with SMTP id s1-20020a056830148100b006bb103646demr166639otq.30.1690488135586;
        Thu, 27 Jul 2023 13:02:15 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id m3-20020a9d73c3000000b006b9acf5ebc0sm938142otk.76.2023.07.27.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:02:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 04/10] RDMA/rxe: Extend rxe_init_packet() to support frags
Date:   Thu, 27 Jul 2023 15:01:23 -0500
Message-Id: <20230727200128.65947-5-rpearsonhpe@gmail.com>
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

Add a subroutine rxe_can_use_sg() to determine if a packet is
a candidate for a fragmented skb. Add a global variable rxe_use_sg
to control whether to support nonlinear skbs. Modify rxe_init_packet()
to test if the packet should use a fragmented skb. Fixup calls to
rxe_init_packet() to use the new API but disable creating nonlinear
skbs for now.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  5 +++
 drivers/infiniband/sw/rxe/rxe.h      |  3 ++
 drivers/infiniband/sw/rxe/rxe_loc.h  |  4 +-
 drivers/infiniband/sw/rxe/rxe_net.c  | 58 ++++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_req.c  |  4 +-
 drivers/infiniband/sw/rxe/rxe_resp.c |  4 +-
 6 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 6b55c595f8f8..800e8c0d437d 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -13,6 +13,11 @@ MODULE_AUTHOR("Bob Pearson, Frank Zago, John Groves, Kamal Heib");
 MODULE_DESCRIPTION("Soft RDMA transport");
 MODULE_LICENSE("Dual BSD/GPL");
 
+/* if true allow using fragmented skbs */
+bool rxe_use_sg;
+module_param_named(use_sg, rxe_use_sg, bool, 0444);
+MODULE_PARM_DESC(use_sg, "Support skb frags; default false");
+
 /* free resources for a rxe device all objects created for this device must
  * have been destroyed
  */
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 077e3ad8f39a..b334eda62c36 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -30,6 +30,9 @@
 #include "rxe_verbs.h"
 #include "rxe_loc.h"
 
+/* if true allow using fragmented skbs */
+extern bool rxe_use_sg;
+
 /*
  * Version 1 and Version 2 are identical on 64 bit machines, but on 32 bit
  * machines Version 2 has a different struct layout.
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index fad853199b4d..96b1fb79610a 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -97,8 +97,8 @@ struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
 void rxe_mw_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_net.c */
-struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
-				struct rxe_pkt_info *pkt);
+struct sk_buff *rxe_init_packet(struct rxe_qp *qp, struct rxe_av *av,
+				struct rxe_pkt_info *pkt, bool *is_frag);
 int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
 		struct sk_buff *skb);
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 94e347a7f386..c44ef39010f1 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -510,12 +510,47 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	return err;
 }
 
-struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
-				struct rxe_pkt_info *pkt)
+/**
+ * rxe_can_use_sg() - determine if packet is a candidate for fragmenting
+ * @rxe: the rxe device
+ * @pkt: packet info
+ *
+ * Limit to packets with:
+ *	rxe_use_sg set
+ *	ndev supports SG
+ *
+ * Returns: true if conditions are met else 0
+ */
+static bool rxe_can_use_sg(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+
+	return (rxe_use_sg && (rxe->ndev->features & NETIF_F_SG));
+}
+
+/* must be big enough to hold MAC+IPV6+UDP+ROCE headers */
+#define RXE_MIN_SKB_SIZE (256)
+
+/**
+ * rxe_init_packet - allocate and initialize a new skb
+ * @qp: the queue pair
+ * @av: remote address vector
+ * @pkt: packet info
+ * @frag: optional return value for fragmented skb
+ *	  on call if frag == NULL do not use fragmented skb
+ *	  on return if not NULL set *frag to 1
+ *	  if packet will be fragmented else 0
+ *
+ * Returns: an skb on success else NULL
+ */
+struct sk_buff *rxe_init_packet(struct rxe_qp *qp, struct rxe_av *av,
+				struct rxe_pkt_info *pkt, bool *frag)
 {
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	unsigned int hdr_len;
 	struct sk_buff *skb = NULL;
 	struct net_device *ndev = rxe->ndev;
+	int skb_size;
 
 	if (av->network_type == RXE_NETWORK_TYPE_IPV4)
 		hdr_len = ETH_HLEN + sizeof(struct udphdr) +
@@ -524,8 +559,18 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 		hdr_len = ETH_HLEN + sizeof(struct udphdr) +
 			sizeof(struct ipv6hdr);
 
-	skb = alloc_skb(pkt->paylen + hdr_len + LL_RESERVED_SPACE(ndev),
-			GFP_ATOMIC);
+	skb_size = LL_RESERVED_SPACE(ndev) + hdr_len + pkt->paylen;
+	if (frag) {
+		if (rxe_can_use_sg(qp, pkt) &&
+		    (skb_size > RXE_MIN_SKB_SIZE)) {
+			skb_size = RXE_MIN_SKB_SIZE;
+			*frag = true;
+		} else {
+			*frag = false;
+		}
+	}
+
+	skb = alloc_skb(skb_size, GFP_ATOMIC);
 	if (unlikely(!skb))
 		goto out;
 
@@ -539,6 +584,11 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 	else
 		skb->protocol = htons(ETH_P_IPV6);
 
+	if (frag && *frag)
+		pkt->hdr = skb_put(skb, rxe_opcode[pkt->opcode].length);
+	else
+		pkt->hdr = skb_put(skb, pkt->paylen);
+
 out:
 	return skb;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 525e704c12c2..491360fef346 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -369,14 +369,12 @@ static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
 			pkt->pad + RXE_ICRC_SIZE;
 
 	/* init skb */
-	skb = rxe_init_packet(rxe, av, pkt);
+	skb = rxe_init_packet(qp, av, pkt, NULL);
 	if (unlikely(!skb)) {
 		err = -ENOMEM;
 		goto err_out;
 	}
 
-	pkt->hdr = skb_put(skb, pkt->paylen);
-
 	/* init roce headers */
 	rxe_init_roce_hdrs(qp, wqe, pkt);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index a6c1d67ad943..254f2eab8d20 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -788,12 +788,10 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	ack->paylen = rxe_opcode[opcode].length + payload +
 			ack->pad + RXE_ICRC_SIZE;
 
-	skb = rxe_init_packet(rxe, &qp->pri_av, ack);
+	skb = rxe_init_packet(qp, &qp->pri_av, ack, NULL);
 	if (!skb)
 		return NULL;
 
-	ack->hdr = skb_put(skb, ack->paylen);
-
 	bth_init(ack, opcode, 0, 0, ack->pad, IB_DEFAULT_PKEY_FULL,
 		 qp->attr.dest_qp_num, 0, psn);
 
-- 
2.39.2

