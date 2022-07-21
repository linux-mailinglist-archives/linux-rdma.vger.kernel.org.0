Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8257D763
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 01:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiGUXgC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 19:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiGUXgB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 19:36:01 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA68C220DD
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 16:36:00 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10d8880d055so4525068fac.8
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 16:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqPncNr1790+/TKdwKDj5JlwKQwGpBR65F3ORqf/4yI=;
        b=L8tiY0NTjwwD2DgdHJkFFl5GZovaPhqOz1N44ihDOZYEJB44XwnHdsaYRHYAR2U3ch
         Ed5dKN2yCsUmDr3fKXJROzu5hZfdvdoBU4PbrlskmjR8FdkUD4yK86/ZneXQO0cTXBg+
         Tv+WuaWGtdsvBOe4qiS1wfKv/KwOVLagSbZMS7/8D0L+YC2/h5fbLkheWhM4CDSs1CHI
         ywLaTJGok9wngZuZk6TVph9/3cuR8c/E3vz0gWDE6Fx5nUaFsG7oE3jpHIC5mTxrLuE+
         3+6I/dg9pZNJfaemBrvUck+GJCe2UsSFCO1OG3AcVJR5kus6oxeeimeIIC3kX7HES/Zt
         Z8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqPncNr1790+/TKdwKDj5JlwKQwGpBR65F3ORqf/4yI=;
        b=cXxfFyMterjl9PswwVH5+P3aXDjs0t+g3zDPw7EcLDahGyfDhaoLoAPdaGHGZpuFQv
         D9RKy0L2FUcdRACNegkDdqol0P06W4KvwgeznpEnsYm+/tMd5F1XZM+5fdPLj9CQuAxd
         QfnPsO4USSZqCL2EDDBwrmkhNRzbJTMLpTkgfHs7MJZ0tORr+/HtIWNJK4DPdbSvy5x/
         /nkcpHF7W4vibh2pWAzMbR3bYLAC7E25BpbphPIQ5nrTtnmvcthUlDa2gyHPeuPRFbPE
         wXzzf3fnnsE6iuonXcEm1S+ZX4124VexEEtBQ4hOs3ZaAMoDDErgW27YI9tg3b1Ub6Qn
         0CQw==
X-Gm-Message-State: AJIora/VaK2uPGrt1MyFDyu91jgGimkFjRyg3pJotlGsjf/Z81krcTiX
        2+Ipj8XcC+kqTcuCzlt/PI0=
X-Google-Smtp-Source: AGRyM1spY80dmdVSmZYq2xc/9FxyXRmVmsgSoRGpir3KoOPAkHx/4L+z0tlB0REWgmJPvjiF1qTEAA==
X-Received: by 2002:a05:6871:8a9:b0:10c:29ec:d06d with SMTP id r41-20020a05687108a900b0010c29ecd06dmr6634246oaq.204.1658446560250;
        Thu, 21 Jul 2022 16:36:00 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id s33-20020a05680820a100b00339bf4473bcsm1169154oiw.56.2022.07.21.16.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 16:35:59 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     lizhijian@fujitsu.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, haris.iqbal@ionos.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH RFC] RDMA/rxe: Allow re-registration of FMRs
Date:   Thu, 21 Jul 2022 18:34:54 -0500
Message-Id: <20220721233453.57693-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch allows the rxe driver to re-register an FMR
with or without remapping the mr. It adds
a state variable that shows if the mr has been remapped
and then only swaps the map sets if the mr has been
remapped.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 38 +++++++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 15 +++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.h | 13 ++++++++-
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index d19580596996..b7886de1b7a4 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -241,6 +241,9 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 	if (err)
 		return err;
 
+	mr->remap = RXE_REMAP_INIT;
+	spin_lock_init(&mr->remap_lock);
+
 	mr->max_buf = max_pages;
 	mr->state = RXE_MR_STATE_FREE;
 	mr->type = IB_MR_TYPE_MEM_REG;
@@ -587,10 +590,22 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
 	}
 
 	if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
-		pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
+		pr_warn("%s: mr->type (%d) is wrong type\n",
+			__func__, mr->type);
+		ret = -EINVAL;
+		goto err_drop_ref;
+	}
+
+	spin_lock_bh(&mr->remap_lock);
+	if (mr->remap == RXE_REMAP_READY) {
+		mr->remap = RXE_REMAP_INIT;
+	} else {
+		spin_unlock_bh(&mr->remap_lock);
 		ret = -EINVAL;
 		goto err_drop_ref;
 	}
+	spin_unlock_bh(&mr->remap_lock);
+
 
 	mr->state = RXE_MR_STATE_FREE;
 	ret = 0;
@@ -634,10 +649,23 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	mr->rkey = (access & IB_ACCESS_REMOTE) ? mr->lkey : 0;
 	mr->state = RXE_MR_STATE_VALID;
 
-	set = mr->cur_map_set;
-	mr->cur_map_set = mr->next_map_set;
-	mr->cur_map_set->iova = wqe->wr.wr.reg.mr->iova;
-	mr->next_map_set = set;
+	spin_lock_bh(&mr->remap_lock);
+	switch (mr->remap) {
+	case RXE_REMAP_MAPPED:
+		set = mr->cur_map_set;
+		mr->cur_map_set = mr->next_map_set;
+		mr->cur_map_set->iova = wqe->wr.wr.reg.mr->iova;
+		mr->next_map_set = set;
+		mr->remap = RXE_REMAP_READY;
+		break;
+	case RXE_REMAP_READY:
+		mr->cur_map_set->iova = wqe->wr.wr.reg.mr->iova;
+		break;
+	default:
+		spin_unlock_bh(&mr->remap_lock);
+		return -EINVAL;
+	}
+	spin_unlock_bh(&mr->remap_lock);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 831753dcde56..ca729c7153e9 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -975,6 +975,17 @@ static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 	struct rxe_map_set *set = mr->next_map_set;
 	int n;
 
+	spin_lock_bh(&mr->remap_lock);
+	if (mr->remap == RXE_REMAP_INIT) {
+		mr->remap = RXE_REMAP_BUSY;
+	} else {
+		spin_unlock_bh(&mr->remap_lock);
+		pr_warn("%s: mr#%d not in REMAP_INIT state\n",
+			__func__, mr->elem.index);
+		return -EINVAL;
+	}
+	spin_unlock_bh(&mr->remap_lock);
+
 	set->nbuf = 0;
 
 	n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_mr_set_page);
@@ -986,6 +997,10 @@ static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 	set->page_mask = ibmr->page_size - 1;
 	set->offset = set->iova & set->page_mask;
 
+	spin_lock_bh(&mr->remap_lock);
+	mr->remap = RXE_REMAP_MAPPED;
+	spin_unlock_bh(&mr->remap_lock);
+
 	return n;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 628e40c1714b..8b6b5cdacd6c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -265,6 +265,13 @@ enum rxe_mr_state {
 	RXE_MR_STATE_VALID,
 };
 
+enum rxe_remap_state {
+	RXE_REMAP_INIT,
+	RXE_REMAP_BUSY,
+	RXE_REMAP_MAPPED,
+	RXE_REMAP_READY,
+};
+
 enum rxe_mr_copy_dir {
 	RXE_TO_MR_OBJ,
 	RXE_FROM_MR_OBJ,
@@ -308,11 +315,15 @@ struct rxe_mr {
 	struct rxe_pool_elem	elem;
 	struct ib_mr		ibmr;
 
+	enum rxe_mr_state	state;
+	enum rxe_remap_state	remap;
+
+	spinlock_t		remap_lock;
+
 	struct ib_umem		*umem;
 
 	u32			lkey;
 	u32			rkey;
-	enum rxe_mr_state	state;
 	enum ib_mr_type		type;
 	int			access;
 
-- 
2.34.1

