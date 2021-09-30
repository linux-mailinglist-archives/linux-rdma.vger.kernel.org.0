Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09DC41D265
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 06:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346657AbhI3E3A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 00:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347733AbhI3E27 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 00:28:59 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1E7C06161C
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:27:17 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so5733873otb.1
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxLoSpQBwcYypLUoXkx1nNuISVxwJZaSG5YT/2mAQ9Y=;
        b=FbFxyC0YLB59LczchZn1vlqLChyo5Q3ylhih1vZFScan++o2tkoQHZkWtrT7R+qSKN
         ZEbLjDACoxGMVxvb6/u7YWwpcBXd44DkBS2X+sUYUzSTej2dmGVE9PQKheGhz27A9yFT
         aQMTTYRMHAVwUHz8qLmqS0yoMfq+Q/PYy66U3R67q1I0NvJsgHbcuAWRa0qToot91Hu+
         LDvQYtgmnJanUGf4Pk9YsULfJbUxLPvsXFhcCz+NAh+10g1hwJC6IpGYl4s6k9jKyXKl
         6WLwNi7kL+8hYOjWmfFiyOp5lTVACjqRi5kaEkOAxB+Dop52dm1btTj8e7+7f1qiARAA
         xW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxLoSpQBwcYypLUoXkx1nNuISVxwJZaSG5YT/2mAQ9Y=;
        b=xWgBEbZ/yA6AuhnwWllyHPRoaGR/zO3OAnSuZwVwRqf4ESocwI5hFLjiJQI0jDm7gi
         k0msQ2hUy64qEVT/ik7t8H/vzkiJGI33KGxs1R07doHPjPWM833Ktor1yy7i06QQPl6H
         ZsckItDLo3GdKuz16eODaB6qQ9F9Lxn6Qg7IZ91zc7osZT22d1EV0aa9ybq4G3gHGQuA
         HMSR6TWGnSaUc1N1NTdPDbO4mdFGbySUbY4TQy9kr5obC8vOQeark+/Br28x5SZ9hck/
         jyO18ZkCHhcHc4qBMJXhIsJ6I29rY8TfRZz6YQeot3az3gv6F4FXcodPnVhwCIiZuLvU
         qqJg==
X-Gm-Message-State: AOAM5305IL4a0w+E8W+KP4QRjRqDXcn+jeVLqhGLx6MQ4ZU5BdybfI6g
        S/lRS+IoWGJMQRAc0/9qkGrYCSDfwB8fHg==
X-Google-Smtp-Source: ABdhPJwQZ7s+WpqgYOwD3T0C69tWbpmR3CkdX12HH4P4dFTXOTL2/0dXX2c1HP6OImK/Da+nGai74g==
X-Received: by 2002:a05:6830:25ca:: with SMTP id d10mr3311628otu.27.1632976036468;
        Wed, 29 Sep 2021 21:27:16 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-48b3-0edc-a395-cab0.res6.spectrum.com. [2603:8081:140c:1a00:48b3:edc:a395:cab0])
        by smtp.gmail.com with ESMTPSA id a23sm373661otp.44.2021.09.29.21.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 21:27:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 5/6] RDMA/rxe: Lookup kernel AH from ah index in UD WQEs
Date:   Wed, 29 Sep 2021 23:26:03 -0500
Message-Id: <20210930042603.4318-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930042603.4318-1-rpearsonhpe@gmail.com>
References: <20210930042603.4318-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add code to rxe_get_av in rxe_av.c to use the AH index in UD send WQEs
to lookup the kernel AH. For old user providers continue to use the AV
passed in WQEs. Move setting pkt->rxe to before the call to rxe_get_av()
to get access to the AH pool.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c  | 20 +++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_req.c |  8 +++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 85580ea5eed0..38c7b6fb39d7 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -101,11 +101,29 @@ void rxe_av_fill_ip_info(struct rxe_av *av, struct rdma_ah_attr *attr)
 
 struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
 {
+	struct rxe_ah *ah;
+	u32 ah_num;
+
 	if (!pkt || !pkt->qp)
 		return NULL;
 
 	if (qp_type(pkt->qp) == IB_QPT_RC || qp_type(pkt->qp) == IB_QPT_UC)
 		return &pkt->qp->pri_av;
 
-	return (pkt->wqe) ? &pkt->wqe->wr.wr.ud.av : NULL;
+	if (!pkt->wqe)
+		return NULL;
+
+	ah_num = pkt->wqe->wr.wr.ud.ah_num;
+	if (ah_num) {
+		/* only new user provider or kernel client */
+		ah = rxe_pool_get_index(&pkt->rxe->ah_pool, ah_num);
+		if (!ah || ah->ah_num != ah_num || rxe_ah_pd(ah) != pkt->qp->pd) {
+			pr_warn("Unable to find AH matching ah_num\n");
+			return NULL;
+		}
+		return &ah->av;
+	}
+
+	/* only old user provider for UD sends*/
+	return &pkt->wqe->wr.wr.ud.av;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 2981b3ef3cc0..06f642f942f7 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -379,9 +379,8 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	/* length from start of bth to end of icrc */
 	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
 
-	/* pkt->hdr, rxe, port_num and mask are initialized in ifc
-	 * layer
-	 */
+	/* pkt->hdr, port_num and mask are initialized in ifc layer */
+	pkt->rxe	= rxe;
 	pkt->opcode	= opcode;
 	pkt->qp		= qp;
 	pkt->psn	= qp->req.psn;
@@ -391,6 +390,9 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 
 	/* init skb */
 	av = rxe_get_av(pkt);
+	if (!av)
+		return NULL;
+
 	skb = rxe_init_packet(rxe, av, paylen, pkt);
 	if (unlikely(!skb))
 		return NULL;
-- 
2.30.2

