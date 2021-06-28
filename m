Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66D33B6AC2
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 00:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbhF1WE6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 18:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbhF1WEC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Jun 2021 18:04:02 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C35C06124C
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:01:35 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so20529559otl.0
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MEyGuPKeUddZhaw30N5dtanpUK1tdzdpPP/MHcDXAoY=;
        b=M0QUPu1T9jsX055wQiDPK0hl9uBoRF1DG51wDbQz+PnaS08xEx4OtmrFElEXnptiKY
         UqkGCEu9fz4BVmZzeJ/ssP38ibDRPclzkxzfjNkFYOf7x7A8jNw0H0EdaOeemZa4r427
         QVY893bJksLKdVf3cCW8iYpEPT6geSpfil1981f9UA1ZdkN9wcjzXjKXwVdIfEcKUQyR
         jSnDUzSx8xBGk7x32ibZSF4qHf9UoMNulPblRDzxwPrJLuWrBE2crEqXxh5HfJDmEs5X
         ltbhQydRYJBrUJJpJpgi+fgE8iHVNm6Hi0TC7gHIWDThdD4W9rnjWCbixu/iEW6J4jeq
         MRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MEyGuPKeUddZhaw30N5dtanpUK1tdzdpPP/MHcDXAoY=;
        b=es/VsZdDsjr50PxAOdoN14/eM88kXiJnLNZ5HjWwW/FWpXr6l3963Q7EBwhX+47ccb
         AoxK7t0Vn1N5CeLHntbWzNHz6HzlRcav78vv+jhQjGRMK1rFC7IZNLfPuGHj0dC0DBgN
         OCKSaMWIkrw1cZprSaO32lAHBk5gMJ/GHNkBjgOSMf/XGuTcH6tG7ggLwXWrhZv+QejF
         RT7saa9DAN8zvrWvMVqrPbx2EBDNm1yAvhSy8l9CpH4edpEzmxv3rfigwJJlLYJakxV0
         CHPLGcWo2x/q2kvxKg+NHFE7sZ2TxNq7ff1zuKL1yYS57nooxCH48csjMfMCepPt/xxv
         UrgA==
X-Gm-Message-State: AOAM530ibJe/YgE5p+3n+YRGQKz79V5laMFibtKFu0xijEjvJu6DIg1z
        9pWeJQPU0d5skeSF25g20UE=
X-Google-Smtp-Source: ABdhPJzlIlDcVKWeeZy4IEV1hXey+w+RB89Rx87jNDLazPzyjOIHoxIgfpBpmFTMS1Z3N1xJykru1Q==
X-Received: by 2002:a9d:609e:: with SMTP id m30mr1544712otj.168.1624917695300;
        Mon, 28 Jun 2021 15:01:35 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id f138sm3462639oig.21.2021.06.28.15.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 15:01:35 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 4/5] RDMA/rxe: Lookup kernel AH from ah index in UD WQEs
Date:   Mon, 28 Jun 2021 17:00:43 -0500
Message-Id: <20210628220043.9851-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210628220043.9851-1-rpearsonhpe@gmail.com>
References: <20210628220043.9851-1-rpearsonhpe@gmail.com>
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
index da2e867a1ed9..4176e00fe9df 100644
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
 
-	return (pkt->wqe) ? &pkt->wqe->av : NULL;
+	if (!pkt->wqe)
+		return NULL;
+
+	ah_num = pkt->wqe->wr.wr.ud.ah_num;
+	if (ah_num) {
+		/* only new user provider or kernel client */
+		ah = rxe_pool_get_index(&pkt->rxe->ah_pool, ah_num);
+		if (!ah || ah->ah_num != ah_num || ah_pd(ah) != pkt->qp->pd) {
+			pr_warn("Unable to find AH matching ah_num\n");
+			return NULL;
+		}
+		return &ah->av;
+	}
+
+	/* only old user provider for UD sends*/
+	return &pkt->wqe->av;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index c57699cc6578..01485de2cc7d 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -390,9 +390,8 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
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
@@ -402,6 +401,9 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 
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

