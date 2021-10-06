Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8794235A4
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 03:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbhJFCAR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 22:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbhJFCAR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Oct 2021 22:00:17 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B26C061753
        for <linux-rdma@vger.kernel.org>; Tue,  5 Oct 2021 18:58:26 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id a3so1880227oid.6
        for <linux-rdma@vger.kernel.org>; Tue, 05 Oct 2021 18:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R28ci1vfu6y2BAkpjnPtPdKQKjUHlIJGx5SO1oi5Sfc=;
        b=jqHCOHuYALL+hOLkAqQKzqjyD+iQDZrgpiaXPnhVntAT7zx+tfySr+5PVn5G2o/iX+
         ktiarojogUFg37hcyAeN/zLEy0XFMpPyAepMCT3R2j5yLdj9VJZFf59xTX1oanPV/1gd
         rgK/jAevT7/NSdLO7tAof7fVn8S1dpD8rkvJ3jOnsLW9pD2N71lSSlIurmHgTQanHAj1
         lRmBqkPEzo2C/Vt3y1dExb2oQ10Y+o/KAE6jYlGmZKhCnNi2UFqVsoEWA+sVC7nqcNnM
         +wfB/9jR733yi1DEyDWcsKEYTB491xgg9OXtB04AbIs+yFldOLhAQgCFTghBVJ+WtskK
         aLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R28ci1vfu6y2BAkpjnPtPdKQKjUHlIJGx5SO1oi5Sfc=;
        b=ocfjuM+wrB4wDLiL/H/KRhGWhP55YwbCunmNkMp3K1xjBdHXdw9eumuRCsMQmZfXw+
         yt4Z8XpQsJHJVWylajEpd2RgBdfRIU8yiBthv35OxWjlLLLI6ubKkd69RLvuJpsvP9pK
         1sGI9gCj1vl194WlGCrcEbbfadroWKt4N2LjQBQZyZ1TAO6IDHEGsp5n+iAKb9UYZhB4
         8AdMoOGQEsJory6BZ4ONJ7cO21sQdqoUI9EqtuZ2DJQwlWepTt9VcTT00dHpdm0xq2cz
         c7+Iktf2KKMheyzVpFlpolIKaGYJbW102uTxSIJvmIgnuGV9enyMNx8RmsSLL7pLTz+d
         1sFQ==
X-Gm-Message-State: AOAM533gYIHn3tlduyzBJAgq4oISzFnXWE0S9bnMbQpUK2eRZJ0MsuF9
        FAy2OlQAn2RdLWutYi8GpSI=
X-Google-Smtp-Source: ABdhPJxtROrsVM5K41FDCcPC6KxZsRWRT4lAN0YnWV2geK820cPJvgaZlvnF+uYifB3CpJuaXB70bA==
X-Received: by 2002:a05:6808:1441:: with SMTP id x1mr5135455oiv.77.1633485505727;
        Tue, 05 Oct 2021 18:58:25 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-2b16-c5f3-6fcc-9065.res6.spectrum.com. [2603:8081:140c:1a00:2b16:c5f3:6fcc:9065])
        by smtp.gmail.com with ESMTPSA id e2sm4016057otk.46.2021.10.05.18.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 18:58:25 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 5/6] RDMA/rxe: Lookup kernel AH from ah index in UD WQEs
Date:   Tue,  5 Oct 2021 20:58:14 -0500
Message-Id: <20211006015815.28350-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006015815.28350-1-rpearsonhpe@gmail.com>
References: <20211006015815.28350-1-rpearsonhpe@gmail.com>
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
index fe275fcaffbd..0c9d2af15f3d 100644
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

