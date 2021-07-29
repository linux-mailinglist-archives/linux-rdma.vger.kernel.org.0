Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C59C3DAF85
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhG2Wut (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbhG2Wur (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:50:47 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85368C061798
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:43 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 21so10527181oin.8
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iF8ZKl65ur4InZCGAnaUDd4r4zm2LFpKfwy0uOdsUNQ=;
        b=t0j+hpbeLlJw/OjV80YM3KuWuRXrW9XvEdoqvJi62+hrC8hpt+k44vR87Dfav4ONGT
         6iiJEXywdGGKVBrpm+bhHjMinLJIeOA67CFmxOkSZRov7tg4BzeLx9eCYn0C+hjniLM/
         iltiNMseUxjL11S6TexjTWTrk2B9wwlhc6Lg0KRR+0UhpdGnZiHgkTAU572tGtMI1Ksu
         ynXsJznV0dK4CYCoM955gyGhMuky5mx9rmpUQKI237bCd0+IbID76FkKZ92JqwlCkTYM
         aG2K0+iHjCGNq6I831zvBEhQc/qcNIfuXztfjQwpmTsy0zL5Ylw+3GENGOiSZ4j3td+u
         CPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iF8ZKl65ur4InZCGAnaUDd4r4zm2LFpKfwy0uOdsUNQ=;
        b=VntbiR0zuhrc59NSI3uZgOoWHwE/o+VRw0grBem8Sv1epJr6P9yrIQhEQThj7uDq4u
         458NgtklvJtYsu9urRKWrkMCVuyr0dtePnVcCUt9DUFVfdMk69ZuNIywInurYu5XSbbS
         mSup7qLkjXXHTSJaJCVpBJO4yzrbFRSx+JkgWo72p0SBr6SuzpSZWtIA9vBSWMy2iZ37
         diokNEVIWvDe5uG8yeTYIQ/gFOdPCeHsMFW0FwsNy0q6yNhj8yZV04DkqhUBN9aoqOjG
         8nNe0vBG1yKtf29/GmtNw9Q/bgCdXYWdgSo0JiayO72//Gels4TgS81+Gx3wo1R6w4Fv
         Qsqg==
X-Gm-Message-State: AOAM530gszTrfCnNiXvvrIK0yOePz9DLfZjCob4SaRnng/g5Quv4zqrr
        x6PXOSV20qgwIXlAqlz0aF0=
X-Google-Smtp-Source: ABdhPJxeqw3PamWPiKBdICMkhCtYmmlkUfjU51fIdZU9Wj7OLeOyuLGG7aqrhkIS8wf/2MU8cCs0Pg==
X-Received: by 2002:a05:6808:1490:: with SMTP id e16mr11204725oiw.91.1627599042951;
        Thu, 29 Jul 2021 15:50:42 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id 190sm729172ooi.36.2021.07.29.15.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:50:42 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 12/13] RDMA/rxe: Extend rxe send XRC packets
Date:   Thu, 29 Jul 2021 17:49:15 -0500
Message-Id: <20210729224915.38986-13-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729224915.38986-1-rpearsonhpe@gmail.com>
References: <20210729224915.38986-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend the rxe driver to support sending XRC packets. This patch
  - Expands lists of QP types to include IB_XRC_INIT and IB_XRC_TGT
    as appropriate.
  - Fills in XRCETH header in XRC packets

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c  |  4 +++-
 drivers/infiniband/sw/rxe/rxe_net.c | 14 ++++++++++----
 drivers/infiniband/sw/rxe/rxe_req.c | 13 ++++++++++---
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 46cd7e2d2806..05d4cb772dc6 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -108,7 +108,9 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
 		return NULL;
 
 	if (rxe_qp_type(pkt->qp) == IB_QPT_RC ||
-	    rxe_qp_type(pkt->qp) == IB_QPT_UC)
+	    rxe_qp_type(pkt->qp) == IB_QPT_UC ||
+	    rxe_qp_type(pkt->qp) == IB_QPT_XRC_INI ||
+	    rxe_qp_type(pkt->qp) == IB_QPT_XRC_TGT)
 		return &pkt->qp->pri_av;
 
 	if (!pkt->wqe)
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 6212e61d267b..b1353d456a4c 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -114,7 +114,9 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 {
 	struct dst_entry *dst = NULL;
 
-	if (rxe_qp_type(qp) == IB_QPT_RC)
+	if (rxe_qp_type(qp) == IB_QPT_RC ||
+	    rxe_qp_type(qp) == IB_QPT_XRC_INI ||
+	    rxe_qp_type(qp) == IB_QPT_XRC_TGT)
 		dst = sk_dst_get(qp->sk->sk);
 
 	if (!dst || !dst_check(dst, qp->dst_cookie)) {
@@ -142,7 +144,9 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 #endif
 		}
 
-		if (dst && (rxe_qp_type(qp) == IB_QPT_RC)) {
+		if (dst && (rxe_qp_type(qp) == IB_QPT_RC ||
+			    rxe_qp_type(qp) == IB_QPT_XRC_INI ||
+			    rxe_qp_type(qp) == IB_QPT_XRC_TGT)) {
 			dst_hold(dst);
 			sk_dst_set(qp->sk->sk, dst);
 		}
@@ -459,8 +463,10 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		return err;
 	}
 
-	if ((rxe_qp_type(qp) != IB_QPT_RC) &&
-	    (pkt->mask & RXE_END_MASK)) {
+	if ((rxe_qp_type(qp) != IB_QPT_RC &&
+	     rxe_qp_type(qp) != IB_QPT_XRC_INI &&
+	     rxe_qp_type(qp) != IB_QPT_XRC_TGT) &&
+	     pkt->mask & RXE_END_MASK) {
 		pkt->wqe->state = wqe_state_done;
 		rxe_run_task(&qp->comp.task, 1);
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index b6f6614a3f32..166d4aeef5e9 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -423,7 +423,9 @@ static inline int get_mtu(struct rxe_qp *qp)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 
-	if ((rxe_qp_type(qp) == IB_QPT_RC) || (rxe_qp_type(qp) == IB_QPT_UC))
+	if (rxe_qp_type(qp) == IB_QPT_RC ||
+	    rxe_qp_type(qp) == IB_QPT_UC ||
+	    rxe_qp_type(qp) == IB_QPT_XRC_INI)
 		return qp->mtu;
 
 	return rxe->port.mtu_cap;
@@ -487,6 +489,9 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 		 ack_req, pkt->psn);
 
 	/* init optional headers */
+	if (pkt->mask & RXE_XRCETH_MASK)
+		xrceth_set_xrcsrq(pkt, ibwr->wr.xrc.srq_num);
+
 	if (pkt->mask & RXE_RETH_MASK) {
 		reth_set_rkey(pkt, ibwr->wr.rdma.rkey);
 		reth_set_va(pkt, wqe->iova);
@@ -562,7 +567,8 @@ static void update_wqe_state(struct rxe_qp *qp,
 		struct rxe_pkt_info *pkt)
 {
 	if (pkt->mask & RXE_END_MASK) {
-		if (rxe_qp_type(qp) == IB_QPT_RC)
+		if (rxe_qp_type(qp) == IB_QPT_RC ||
+		    rxe_qp_type(qp) == IB_QPT_XRC_INI)
 			wqe->state = wqe_state_pending;
 	} else {
 		wqe->state = wqe_state_processing;
@@ -730,7 +736,8 @@ int rxe_requester(void *arg)
 			goto next_wqe;
 	}
 
-	if (unlikely(rxe_qp_type(qp) == IB_QPT_RC &&
+	if (unlikely((rxe_qp_type(qp) == IB_QPT_RC ||
+		      rxe_qp_type(qp) == IB_QPT_XRC_INI) &&
 		psn_compare(qp->req.psn, (qp->comp.psn +
 				RXE_MAX_UNACKED_PSNS)) > 0)) {
 		qp->req.wait_psn = 1;
-- 
2.30.2

