Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3870F352442
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Apr 2021 02:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhDBALL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 20:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhDBALK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Apr 2021 20:11:10 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16A6C0613E6
        for <linux-rdma@vger.kernel.org>; Thu,  1 Apr 2021 17:11:08 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so3659044otb.7
        for <linux-rdma@vger.kernel.org>; Thu, 01 Apr 2021 17:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UzvN7SdfyeRiJzF+OWQUztNqohVT7lsd+uMFpxa+vOg=;
        b=pjTbkKaf67nGbrRfw/zpx1CI0oQPu1OtlO7/pBs0HPKYWnWY9Cf5TPpzCFWabSAVrP
         s4n4WQa98U/G55Yom+ecmkYys2xhfG1iCEhfyxs7DARSHhqdsBwcx06ISHyiqggIwQch
         dD+aWE08B2uSmJxItrq8JefRGJX3H13LqQiT5ADoJeADP5W8RlUfCix+o0XP7TqZagSP
         hgImRi4kBVpai+EDD7p7SX7N2teLwaIJokpmGKnBhvBYgRmvJcLzUY4LgEJm0lBe2nTq
         4AVvvSEn0P5OBJVVtgaiH3ice3L3+a9N0Zn7XYwY5EBjMoqoYI00amFRIf3Hu6fmbtLU
         ST8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UzvN7SdfyeRiJzF+OWQUztNqohVT7lsd+uMFpxa+vOg=;
        b=W2gvA3l+v9tYtKb92q18DemUmNrePRcueorLx2PF+Zq1s8XuO1iDLkhSxyv68Q9t/M
         7bWU5vzw0BxD69KWvDNakk6J+mc829SZAvG7zmOBYltAQVsohjnZuhXuf4FuZ319hqfU
         gMzAIKwBjsv5OqT+pDRVMLl60nq3dn4pViH5w45LkL2SrBMge4IeLL3m5ls8IufvcSHs
         8T0YHm9XtOSDQLvXtAGwxBGOncNY8vxSSBdsI+nISj2mlTqQJ0KNvkNWPrbpIx2TZMZ5
         w/VLAGg+d3bHtvd/+vBC2Hipci0b7GmFUnm9dOAHWR3zUBGLf8o1le2GYPAQr2LT4dkg
         5AVA==
X-Gm-Message-State: AOAM532BIfg9d8axf8ZyZ9NPxB9GhPBISr3yFFKZX7Un7fTIm/njArlq
        UmuzkkjyllocCNYMhzesLz0=
X-Google-Smtp-Source: ABdhPJxhZN3kXzS28tLwaHENQZgxxuCYi5X3rPILgaSLv7zhw15+S4iRHuVIk9+slmBGE92CI8feCg==
X-Received: by 2002:a05:6830:40b3:: with SMTP id x51mr9049140ott.106.1617322268343;
        Thu, 01 Apr 2021 17:11:08 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-37e4-2523-bb68-61a6.res6.spectrum.com. [2603:8081:140c:1a00:37e4:2523:bb68:61a6])
        by smtp.gmail.com with ESMTPSA id j35sm1514201ota.54.2021.04.01.17.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 17:11:07 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] RDMA/rxe: Fix missing acks from responder
Date:   Thu,  1 Apr 2021 19:10:17 -0500
Message-Id: <20210402001016.3210-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

All responder errors from request packets that do not
consume a receive WQE fail to generate acks for RC QPs.
This patch corrects this behavior by making the flow
follow the same path as request packets that do consume
a WQE after the completion.

Link: https://lore.kernel.org/linux-rdma/1a7286ac-bcea-40fb-2267-480134dd301b@gmail.com/
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c |  1 -
 drivers/infiniband/sw/rxe/rxe_resp.c | 18 ++++++++----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index a612b335baa0..2af26737d32d 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -676,7 +676,6 @@ int rxe_completer(void *arg)
 
 			/* there is nothing to retry in this case */
 			if (!wqe || (wqe->state == wqe_state_posted)) {
-				pr_warn("Retry attempted without a valid wqe\n");
 				ret = -EAGAIN;
 				goto done;
 			}
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index e0e9984a3cce..6c43df7bf9bc 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -816,8 +816,8 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	struct rxe_recv_wqe *wqe = qp->resp.wqe;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 
-	if (unlikely(!wqe))
-		return RESPST_CLEANUP;
+	if (!wqe)
+		goto finish;
 
 	memset(&cqe, 0, sizeof(cqe));
 
@@ -917,12 +917,12 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	if (rxe_cq_post(qp->rcq, &cqe, pkt ? bth_se(pkt) : 1))
 		return RESPST_ERR_CQ_OVERFLOW;
 
-	if (qp->resp.state == QP_STATE_ERROR)
+finish:
+	if (unlikely(qp->resp.state == QP_STATE_ERROR))
 		return RESPST_CHK_RESOURCE;
-
-	if (!pkt)
+	if (unlikely(!pkt))
 		return RESPST_DONE;
-	else if (qp_type(qp) == IB_QPT_RC)
+	if (qp_type(qp) == IB_QPT_RC)
 		return RESPST_ACKNOWLEDGE;
 	else
 		return RESPST_CLEANUP;
@@ -1056,10 +1056,8 @@ static enum resp_states duplicate_request(struct rxe_qp *qp,
 	if (pkt->mask & RXE_SEND_MASK ||
 	    pkt->mask & RXE_WRITE_MASK) {
 		/* SEND. Ack again and cleanup. C9-105. */
-		if (bth_ack(pkt))
-			send_ack(qp, pkt, AETH_ACK_UNLIMITED, prev_psn);
-		rc = RESPST_CLEANUP;
-		goto out;
+		send_ack(qp, pkt, AETH_ACK_UNLIMITED, prev_psn);
+		return RESPST_CLEANUP;
 	} else if (pkt->mask & RXE_READ_MASK) {
 		struct resp_res *res;
 
-- 
2.27.0

