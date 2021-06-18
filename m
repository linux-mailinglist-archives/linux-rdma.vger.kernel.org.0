Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD813AC2B1
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 07:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhFRFCi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 01:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhFRFCh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 01:02:37 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84545C061574
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 22:00:28 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id m137so9203690oig.6
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 22:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6avt2oKazTUpNnHS78IcfZ7EDhGCVauqOO+MfFKryU=;
        b=DQjCoQLpm7ewWmBuQIVT+U7Odl43jDU6RILZlTBN8fb/J+BbvjzoL3/rAvBR1Np9rt
         mXL5ezDqA7xlQcBMjthxf0tFs2i+mY4ogylhocFS+YTt9Ob8TLEI9KyzA7mq4W5fXvCU
         owSP7822RMZAdz5ga2u6ehH4r9eBtpVlh5VBxCcftOm7S096H0fXnWhXpeRVbag0ixX5
         n70/sfqnoiY9hrF6T4IhWv09TYjLo/DyqW9qA3Lu0S7JT1gDOWXZXuucqSVOa/A4Wc9/
         4vSlYjJiscihnN8NoLpKMBhW/nO3imEzfi0BW34AgW1CmbTcf4GDBcN5Uf4q09FlfGaY
         BOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6avt2oKazTUpNnHS78IcfZ7EDhGCVauqOO+MfFKryU=;
        b=F+91XJgJi2OELYFf7rbUrukioLtPTkC2tqlEccwQ8JAcsNTldccf0qQ0o7ZzWelKJv
         IcxHR+y0hn60YZL585fIto7FNhHO+VlGtSUaDC+AaaDS9utKcdj/JH2nBa16UdNJ95ik
         TN8iUpvHHhhTAi/rIT6dn3ZQF2sEuXjI96TgM1/Vs80omuv3xkCKFDjafDwkVg2gedce
         E+jNxot0O8XE95hMajfsKi0IXiHCk+BNbj8Juh9uOVYVKcbzOnhnUFPvKl8iqbDoBSCo
         yk5VbqE47ZZk+ZpPLNNvVozw1W/9p0z243Gh5U7WBxqaSnbabibTaPW4LwtirmI97khV
         gcNw==
X-Gm-Message-State: AOAM531jkhHiMB+u5+fVNEX3TYHI92VnHElW64AbX6l34bG9Wrg7M17k
        hMi5JK6FwxFgEk7m8nZ/tWc=
X-Google-Smtp-Source: ABdhPJwfY5wvzR7uLOoVHf+HH3gC1NnGR9sOyVv+pUwr7BUkE40Y8Zkp0zaHwYJmFsBv4clqQUr7Fg==
X-Received: by 2002:aca:f488:: with SMTP id s130mr5596131oih.5.1623992427963;
        Thu, 17 Jun 2021 22:00:27 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-2fce-3453-431e-5204.res6.spectrum.com. [2603:8081:140c:1a00:2fce:3453:431e:5204])
        by smtp.gmail.com with ESMTPSA id e23sm1788418otk.67.2021.06.17.22.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 22:00:27 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 4/6] RDMA/rxe: Fix over copying in get_srq_wqe
Date:   Thu, 17 Jun 2021 23:57:41 -0500
Message-Id: <20210618045742.204195-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618045742.204195-1-rpearsonhpe@gmail.com>
References: <20210618045742.204195-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently get_srq_wqe() in rxe_resp.c copies the maximum possible number
of bytes from the wqe into the QPs copy of the SRQ wqe. This is usually
extra work and risks reading past the end of the SRQ circular buffer if
the SRQ is configured with less than the maximum possible number of SGEs.

Check the number of SGEs is not too large.
Compute the actual number of bytes in the WR and copy only those.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 5718c8bb28ac..93322d20c0ab 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -296,6 +296,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 	struct rxe_recv_wqe *wqe;
 	struct ib_event ev;
 	unsigned int count;
+	size_t size;
 
 	if (srq->error)
 		return RESPST_ERR_RNR;
@@ -311,8 +312,13 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 		return RESPST_ERR_RNR;
 	}
 
-	/* note kernel and user space recv wqes have same size */
-	memcpy(&qp->resp.srq_wqe, wqe, sizeof(qp->resp.srq_wqe));
+	/* don't trust user space data */
+	if (unlikely(wqe->dma.num_sge > srq->rq.max_sge)) {
+		pr_warn("%s: invalid num_sge in SRQ entry\n", __func__);
+		return RESPST_ERR_MALFORMED_WQE;
+	}
+	size = sizeof(wqe) + wqe->dma.num_sge*sizeof(struct rxe_sge);
+	memcpy(&qp->resp.srq_wqe, wqe, size);
 
 	qp->resp.wqe = &qp->resp.srq_wqe.wqe;
 	if (qp->is_user) {
-- 
2.30.2

