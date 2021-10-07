Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E85A425DBC
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 22:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhJGUn3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Oct 2021 16:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhJGUn3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Oct 2021 16:43:29 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1163FC061570
        for <linux-rdma@vger.kernel.org>; Thu,  7 Oct 2021 13:41:35 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so9145381otb.1
        for <linux-rdma@vger.kernel.org>; Thu, 07 Oct 2021 13:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R28ci1vfu6y2BAkpjnPtPdKQKjUHlIJGx5SO1oi5Sfc=;
        b=M68TJDklFdmZlj222a99vVIRadmoUMvId+iOk+pBun4sJ3aiLfVvYSQ+pzO3yl6xq/
         MQcZVx1E5DBrXsWldOmfMOKPLcUpZw3SM+jftKJs+o9sd0789BZNGLgxk/VgF1MYKsZh
         nl4ZUlKSb0pRm4J8KAWVuFpoJpcJTPlpcstFfPzCE9R8JkI+IyFDmivmDU2/4/RiesDx
         iL8Tt2mihlrNpY8yKUV31JAl7T/7vjczxEEHMa1glsk+WfdyfQH4rJFMy4Jq5NR3VwXX
         xkjIHcQe4nkJiSfga+8vp3SKakaeTKJjsiZ+gz8oRiYsKjUjh6aGD7WyNcSXnBIrlBG2
         5ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R28ci1vfu6y2BAkpjnPtPdKQKjUHlIJGx5SO1oi5Sfc=;
        b=TZ7qOqjkuKOjecQ7NJRgtEWMCS0lRJU66NBREIu54hzCQcdZCCPwCZq22pm4xZrcuf
         oImuOEoto7boJlnbGs+mHTqSSbN7vuvf7iZRDbjbqvNIKA2TgaRlar4GCpwxohyqo80E
         G1BeBz8/jKbY9D4/t87ecLFTD8kWZte8ak+zJtpQhYB8MqmPBXvkuwoLrNk2mX9/sEpA
         /1fSXF4RisE1pkOg4PdKTQCwkKgiX1jJiXb//esbPNJa6XquC4nsH/KN+1rcyUE3hvV1
         JQPcyCd73X58GBtPcy0meJOq3aqGvBn+5tKq/H2LgTImj8sCtj8G2XFCuLglkFnOr5He
         RQ3w==
X-Gm-Message-State: AOAM533myS40jD4fO5uuZmUzW50KETcsWBjhrQcwM44cMibMqOoQxXvz
        dcaDlpmDhGeaHlUkmGlIc94lF/cG3Cs=
X-Google-Smtp-Source: ABdhPJzLZwC75WgkRpB4GJ5Dhp0ZEVPoZFxRCCHnPdHon4NSOggtjp5TULUrGfTEOag/fbYeXQyKYQ==
X-Received: by 2002:a05:6830:1f54:: with SMTP id u20mr5298815oth.207.1633639294461;
        Thu, 07 Oct 2021 13:41:34 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-1259-16f0-10f5-1724.res6.spectrum.com. [2603:8081:140c:1a00:1259:16f0:10f5:1724])
        by smtp.gmail.com with ESMTPSA id f10sm71607ooh.42.2021.10.07.13.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:41:34 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 5/6] RDMA/rxe: Lookup kernel AH from ah index in UD WQEs
Date:   Thu,  7 Oct 2021 15:40:51 -0500
Message-Id: <20211007204051.10086-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007204051.10086-1-rpearsonhpe@gmail.com>
References: <20211007204051.10086-1-rpearsonhpe@gmail.com>
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

