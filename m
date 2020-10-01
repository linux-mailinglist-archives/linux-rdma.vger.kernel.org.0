Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615B72805DF
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732958AbgJARtM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733007AbgJARtK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:49:10 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031E8C0613E9
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:49:10 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id y25so1701269oog.4
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nY3c0i5sSwIiPTOZv8oxbrrUu6cJ8Pc0aLiiNAKAzRk=;
        b=Wz5Rkhw+FMvBi8arQbMveOy5RZ7E55W4G/xJDvG/oKd+HGfmSyyZ+WCfglpZVT/p5/
         7C7dYmNyhR17KTlzZ8yb1Kpnjuct0GNaBHv+SvMgn1ClZumEorzzdKj/a13sKpJUqjd6
         dwMIhST42iHWuF1uOAjGi89Yf9y27zoAPYc5Bxm/YkZsMSzpBBwhqMq4U0H1Hgm9Neqk
         IXiZH1c0VY75z6mYaBnlL3kWPVlMQFDH7Y34mABgD6npUg1Q6g72DK+IUOeL1he3Wb8V
         +2ZCTNmJPQ1wWefdpSgQroatvwwQt+LcFGcjlfJddXtK1TFYYio1r2lix3DZvZwDJfXq
         4GkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nY3c0i5sSwIiPTOZv8oxbrrUu6cJ8Pc0aLiiNAKAzRk=;
        b=XjkpHYiqdUQXmBNUlPe+PDiwevKY/B5PRhbkoKK3urFlL5ILHvQsYRSn1P/CYkswaA
         NZBUepNUYsDE58rT9GbF5YxgAql1sl1n2cK9zFnjRuAolqUDTMdxLLZDXtEawWxUbiwq
         8OEKi55/PhukrVXCqEO6p9+wPJL3ZpdeRDVUAjsuP1VZPzkZDLuT/5B1HdgGpoO4bPX6
         1pp87HTNRhFsIhAuScNuEMvy/xkohe94cMP0ptvz+l8RKceYPufiDRSfMm0WtOJrgLI0
         6K9dywJhbfNkxmKbiF/wOMMXkawu9P+2o2CLBhtKZgzW8aMSaJynwHyC9Rw19HvJbNaK
         9j4g==
X-Gm-Message-State: AOAM530qMbxN2PzynkhjW5awpua+TU+yM4YbxrilYjaV/aKW8uhsU87D
        Jfsk55V73H/fOxKczZD06b4=
X-Google-Smtp-Source: ABdhPJyk3igjrzCaCPqK4/wfrj6YBX6xshv5H1Kw7SV6UtaO2XhnUhMOO3feS0h6FKgRl/V2wyVpQg==
X-Received: by 2002:a4a:9b01:: with SMTP id a1mr6537406ook.51.1601574549442;
        Thu, 01 Oct 2020 10:49:09 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id p1sm1361299otq.7.2020.10.01.10.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:49:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 18/19] rdma_rxe: add rkey validation checks for MR and MW
Date:   Thu,  1 Oct 2020 12:48:46 -0500
Message-Id: <20201001174847.4268-19-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Added checks from 9.4.1.1.3 r_key validation for remote memory
invalidate to MR and MW invalidate routines.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 49 ++++++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_mw.c | 10 +++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 1901f388c747..2cc3487d3f77 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -522,8 +522,57 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
 	return 0;
 }
 
+static int check_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr)
+{
+	int type = mr->ibmr.type;
+	int qpt = qp_type(qp);
+
+	if (unlikely(type > IB_MR_TYPE_INTEGRITY)) {
+		pr_err("invalidate: MR of unknown type = %d\n",
+			mr->ibmr.type);
+		return -EINVAL;
+	}
+
+	/* o10-37.2.13 */
+	if (unlikely(type == IB_MR_TYPE_MEM_REG ||
+	    type == IB_MR_TYPE_USER)) {
+		pr_err("invalidate: MR created by reg_mr or user_reg_mr\n");
+		return -EINVAL;
+	}
+
+	/* o10-37.2.17 */
+	if (unlikely(atomic_read(&mr->num_mw))) {
+		pr_err("invalidate: MR with bound MWs\n");
+		return -EINVAL;
+	}
+
+	if (unlikely(!((qpt == IB_QPT_RC) || (qpt == IB_QPT_UC) ||
+		(qpt == IB_QPT_XRC_INI) || (qpt == IB_QPT_XRC_TGT)))) {
+		pr_err("invalidate: MR with invalid QP type\n");
+		return -EINVAL;
+	}
+
+	if (unlikely(qp->ibqp.pd != mr->ibmr.pd)) {
+		pr_err("invalidate: MR and QP have different PDs\n");
+		return -EINVAL;
+	}
+
+	if (unlikely(mr->state == RXE_MEM_STATE_INVALID)) {
+		pr_err("invalidate: MR in invalid state\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int rxe_invalidate_mr(struct rxe_qp *qp, struct rxe_mr *mr)
 {
+	int ret;
+
+	ret = check_invalidate_mr(qp, mr);
+	if (ret)
+		return ret;
+
 	/* TODO there are API rules being ignored here
 	 * cleanup later. Current project is not trying
 	 * to fix MR
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index d2d09502a28d..ecda634ab7f0 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -316,9 +316,17 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 static int check_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
 {
+	int qpt = qp_type(qp);
+
 	/* o10-37.2.26 */
 	if (unlikely(mw->ibmw.type == IB_MW_TYPE_1)) {
-		pr_err_once("attempt to invalidate a type 1 MW\n");
+		pr_err_once("invalidate a type 1 MW\n");
+		return -EINVAL;
+	}
+
+	if (unlikely(!((qpt == IB_QPT_RC) || (qpt == IB_QPT_UC) ||
+		(qpt == IB_QPT_XRC_INI) || (qpt == IB_QPT_XRC_TGT)))) {
+		pr_err("invalidate Mw with invalid QP type\n");
 		return -EINVAL;
 	}
 
-- 
2.25.1

