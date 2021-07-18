Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860363CCAD8
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 23:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhGRVal (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 17:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhGRVak (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Jul 2021 17:30:40 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD750C061762
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:27:40 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 42-20020a9d012d0000b02904b98d90c82cso16169392otu.5
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2uXvT2E/bOcgWhDkWg8W6+iY8xVb9gLWp8HbFjcf94g=;
        b=urOpH3RoYNLdLsmlTpU8Ooeo99rR/4YivbMmRVI17Bxq8j9IlYRa0r81dy6/ZoGIF4
         FpHEiJsoM3KQWB1Lz9lvaV36oxy6e62bUOcSSZWwu3KpXbLDyC4QIXRE/yBoYTGi0J5n
         SuXmpr4ihJo/su5TNj6iIuCxb25MTOAsiWsKAsVDrj2vh/R+Xn9MrTHz2gGmpjl29/aG
         /ILF0g7dPha5GMkmWp0C3G/y5XVEfRM5kWiD60CjpxI5n2yOvLu5u3Wh+uk4VjXIUJkE
         8ucaqKF13Rb4m7orshNOe4GnCNd1F+rW4H/8KEVxbNnPa8eKIYfXg9/7J2PhczRV4XyZ
         Z0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2uXvT2E/bOcgWhDkWg8W6+iY8xVb9gLWp8HbFjcf94g=;
        b=RuRvA+ObIEyGkOYLuPaKElIHVf819elRWo69e7m+5URNg/a9AvBWqES0RhTkkjHRQM
         XuY6fgU32wc3VaG5Re9YEvOJ616WvPb6TNbwp98QjlByoCrlQ5Ac0alu3KNEKtkFoMkS
         PH9NIe/rvcj0ykJNLVHHa2eLvF9P9zej6rfv2K1z/ESNAM6to1KxePs5IIJQ6eqCElIq
         dpmMAmVo+AOE68cQ1Ovz8jbTgue9ctSimUM5EPk9BtZo3nSsSxRj555avA/2eUZLoFGJ
         pyhMmpEx9BNYbdEeQLNisOSJj4+vPfpX1OfIJ4Sj2NO97tnRlvX42I4H9eVuaovTyyfo
         RSSQ==
X-Gm-Message-State: AOAM531zvJJVC5alnRpjg5JBo/+/RcfQejTTJW5QxJcQqTosf0wVtnPV
        T6+A/gR3kvbH26T9zPSc9Sw=
X-Google-Smtp-Source: ABdhPJy17ljcIyPh8i8ZwvMXH5FbgwYuZjKZaYarGOoitC34QiS+Pr5VLsCBq0804dMvIvJUkfEHsw==
X-Received: by 2002:a05:6830:120b:: with SMTP id r11mr16215104otp.173.1626643660366;
        Sun, 18 Jul 2021 14:27:40 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-0284-9a3c-0f8a-4ac7.res6.spectrum.com. [2603:8081:140c:1a00:284:9a3c:f8a:4ac7])
        by smtp.gmail.com with ESMTPSA id n9sm3245067otn.54.2021.07.18.14.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 14:27:40 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 4/5] RDMA/rxe: Lookup kernel AH from ah index in UD WQEs
Date:   Sun, 18 Jul 2021 16:27:03 -0500
Message-Id: <20210718212703.21471-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210718212703.21471-1-rpearsonhpe@gmail.com>
References: <20210718212703.21471-1-rpearsonhpe@gmail.com>
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
index 85580ea5eed0..38f75249588e 100644
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
+		if (!ah || ah->ah_num != ah_num || ah_pd(ah) != pkt->qp->pd) {
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

