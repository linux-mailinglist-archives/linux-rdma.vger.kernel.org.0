Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD963D2F0C
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 23:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhGVUnH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhGVUnH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jul 2021 16:43:07 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD71C061575
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jul 2021 14:23:42 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id r80so8070374oie.13
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jul 2021 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kFKyck3dS3F6W5tdQpY8hIQHb+fJvz4kHfwtrIX/xPI=;
        b=A4MhcTXmM98rt6wNVlGIGKd1kC5D82dP6FV7a6YGu8+/xDkhFwhnpP+y9kYMR79K0E
         sufr2cn5XZKH2NTJuAA3fgk/bGssGqQ4gvZAycBSnVHveTidvZPfaRAdtQBSL9+SNnx9
         SjFxi8/m8/quk5KjPtwbH9A1NtoJFZqJKIy2fMYkGU/KLaXpw1TUL12xTOIQnPAM1Cyt
         YO6ZhrIq/mXnCQ64zSZDEOeXrDtXU5SKncgk/+JK6qIDQXzFChhEJkkGmDD8qA38rLvz
         lk8mdkepUjQ5IkN8hYvwLt8+Xr5GmZgKQsz513fBw7ge5n6y4GHYPQAT1Dd11yPKqdc6
         RFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kFKyck3dS3F6W5tdQpY8hIQHb+fJvz4kHfwtrIX/xPI=;
        b=G+5pWk15WeOMZs55F/U3+AckrkDMW4J/XhllbDM6vdzF2xBGTCtEKUwr1zQYGi2UhN
         afQ49Sn9dlfOAV3XEJ5j3bj5oehQKxgq5RygAQjqtHPJCfJV9OHK+bZbasblicpQsgFY
         /o1dhoVWhYxUzV7ZNb+UlvfhS80EPlyQnBAWzlTWYa5yofiYs6TGVKQ+nXNs/A8rM7SA
         YCbwsQNxTdePfbCQKqwvb7fNygsB47kHwKwURaW4cy49v2xvxKkuprOYtQDV02tisFlq
         Ho7LsWrMPH+4TQpNkD+mqgiXwKl1aFqQr5E730vrEOBJnKzCeQVI8xf6YEnBhJvPXFtF
         8YsA==
X-Gm-Message-State: AOAM533+wdAHSJYDhGAfaaOsLaiaaMT4TshgTL+fDmmwwpjDD8EFKNgV
        LDEL6A/9sNrVoIFkyjNBcnQ=
X-Google-Smtp-Source: ABdhPJyIzjb4xo+Qin0cS3QT6zBSXX98xTkPit+qFvI+fFLx0rMHaOr4shRcLxx2r3JGkJPiQ7V+Hw==
X-Received: by 2002:aca:c204:: with SMTP id s4mr2183843oif.49.1626989021517;
        Thu, 22 Jul 2021 14:23:41 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-d50d-298a-08dc-a5ed.res6.spectrum.com. [2603:8081:140c:1a00:d50d:298a:8dc:a5ed])
        by smtp.gmail.com with ESMTPSA id c8sm2452152oto.17.2021.07.22.14.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:23:41 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v3 5/6] RDMA/rxe: Lookup kernel AH from ah index in UD WQEs
Date:   Thu, 22 Jul 2021 16:22:44 -0500
Message-Id: <20210722212244.412157-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722212244.412157-1-rpearsonhpe@gmail.com>
References: <20210722212244.412157-1-rpearsonhpe@gmail.com>
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
index 3894197a82f6..86979a9e7afc 100644
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

