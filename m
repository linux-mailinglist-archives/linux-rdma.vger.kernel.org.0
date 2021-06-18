Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A010C3AC2AF
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 07:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhFRFCh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 01:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhFRFCg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 01:02:36 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ACEC061574
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 22:00:27 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id b24-20020a4a34180000b029024b199e7d4dso1829627ooa.4
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 22:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ymqT2WjawgPJiGJQkTrsKWJ5l7WxUoF1H69Grw7Loyo=;
        b=QLF58QRl/mY1dy7FdbZdHO3o85sKDm+dGb+24dtHMpTxUtHDRbMMani/uxJplHgqFY
         KtM9HCSpbnS8mwsF9SVvws8U/uKL/ttjoi3aluWSX//4UGTS7f/uECudyqpnMC+9YWT5
         0OW+hI1EgVllDzUxJQq9WyUEtJbxO4QHzhXUa3Qt1y9N/eKp2rpRB80FjpuBNIudtE9s
         SmoyC2E41zGjljJUPEQ5x9ZtGWzV24oXDn/fRisESnwjhJjfbESJvy60d2jIf+iWz/d8
         +414Sbax6YhY23S/xyDi/3LdBUCyPXH9htzhfkcWetqAZo6brK2UGIItR/Zj+hYCY+lS
         pUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymqT2WjawgPJiGJQkTrsKWJ5l7WxUoF1H69Grw7Loyo=;
        b=ACh1NGyI0Ukn9cQgpcoYE+eKOAxvu+Az0ej8ODLIXviAMW/ot7mlPoLobqN5+0yI/D
         OU/zElgp/TKCodQ1OTBFWzS2KRb+/AWOiyZ3RlcIc083Mzc5wuQLjBLeHFg/PEc0b+rs
         O7bIPxr/HftomtwCi3AgnL67QQN5+SnOAFBvlf8iZb8P+i2dhH1HTJepnR/sqhud2YKO
         NDnjO4z0uGmRV9jsDf8nEuGIH5CejXzaJj46qEoj5PGNgoBNQqfP6ZMA/7YIda7At94p
         8sc1r0uxC+0rkUxj9mZEn1Am8BJpEPpo+R677281w11n06V9L3j0gdfon3pqpBDoEf2l
         6JkQ==
X-Gm-Message-State: AOAM533R37y2PfUDqzkfqfS7+Gc6gOnTi4URviRHBVW9De6VZpHnY4Xw
        AeJcv06j4LyA10QAWPWnPpM=
X-Google-Smtp-Source: ABdhPJxLu5gBi0SqxlMqcxjfOofgpljLxLCy5TVljrNALfJLjb84q34+y/PHQcWheDnHMfsQdBMllA==
X-Received: by 2002:a4a:e6c7:: with SMTP id v7mr7514938oot.86.1623992427252;
        Thu, 17 Jun 2021 22:00:27 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-2fce-3453-431e-5204.res6.spectrum.com. [2603:8081:140c:1a00:2fce:3453:431e:5204])
        by smtp.gmail.com with ESMTPSA id w17sm1579168oog.44.2021.06.17.22.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 22:00:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 3/6] RDMA/rxe: Fix extra copies in build_rdma_network_hdr
Date:   Thu, 17 Jun 2021 23:57:40 -0500
Message-Id: <20210618045742.204195-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618045742.204195-1-rpearsonhpe@gmail.com>
References: <20210618045742.204195-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

build_rdma_network_hdr() in rxe_resp.c does more copying than is
needed. Remove this subroutine and eliminate the extra copies for
IPV6 and reduce the extra copying for IPV4.

Fixes: e404f945a610 ("IB/rxe: improved debug prints & code cleanup")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 29 ++++++++++++----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 5565d88e0261..5718c8bb28ac 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -785,18 +785,6 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	return state;
 }
 
-static void build_rdma_network_hdr(union rdma_network_hdr *hdr,
-				   struct rxe_pkt_info *pkt)
-{
-	struct sk_buff *skb = PKT_TO_SKB(pkt);
-
-	memset(hdr, 0, sizeof(*hdr));
-	if (skb->protocol == htons(ETH_P_IP))
-		memcpy(&hdr->roce4grh, ip_hdr(skb), sizeof(hdr->roce4grh));
-	else if (skb->protocol == htons(ETH_P_IPV6))
-		memcpy(&hdr->ibgrh, ipv6_hdr(skb), sizeof(hdr->ibgrh));
-}
-
 static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
 {
 	if (rkey_is_mw(rkey))
@@ -811,16 +799,23 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
 static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 {
 	enum resp_states err;
+	struct sk_buff *skb = PKT_TO_SKB(pkt);
+	union rdma_network_hdr hdr;
 
 	if (pkt->mask & RXE_SEND_MASK) {
 		if (qp_type(qp) == IB_QPT_UD ||
 		    qp_type(qp) == IB_QPT_SMI ||
 		    qp_type(qp) == IB_QPT_GSI) {
-			union rdma_network_hdr hdr;
-
-			build_rdma_network_hdr(&hdr, pkt);
-
-			err = send_data_in(qp, &hdr, sizeof(hdr));
+			if (skb->protocol == htons(ETH_P_IP)) {
+				memset(&hdr.reserved, 0,
+						sizeof(hdr.reserved));
+				memcpy(&hdr.roce4grh, ip_hdr(skb),
+						sizeof(hdr.roce4grh));
+				err = send_data_in(qp, &hdr, sizeof(hdr));
+			} else {
+				err = send_data_in(qp, ipv6_hdr(skb),
+						sizeof(hdr));
+			}
 			if (err)
 				return err;
 		}
-- 
2.30.2

