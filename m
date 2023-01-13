Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A12E668855
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jan 2023 01:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjAMAW3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Jan 2023 19:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbjAMAWB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Jan 2023 19:22:01 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF095E09C
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 16:21:59 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id d2-20020a056830044200b00684cc404c8aso956520otc.0
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 16:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSc+ZeVhmJVAyrOad5GEnPdKs11Mmr6EK22kGWHehxY=;
        b=i4KEUd+ZJW8qb5KZVKNFLZWTChSuJR8rxAqpzwvxEDzLbC58I1vEs5mvMbP2zv0UZS
         976+r7sMXYk5ohXQariFys/Zwug4DV5pj+Mqe094nmTaMNoPsyZwZ3goBmX43lFYoQwM
         avSTvsR0OnLnV0VNl2q0SwAZCtD61im3vxgBpY+Gjv7hgVmpoj6oU90kxaEEyUZtVb3C
         LOpOfj2MqoLirDgwy4yGveyyS2jWkVXw07d1b3KiiEgtuaM2RBTYOJruWiAVY7PHkDSO
         gcYuVznW9Mk4EgTqYpI6TC665LBgMgaJkCrHBKxD3GJtjM9cANJ+FA2XdYAsQxd/OIV7
         hgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSc+ZeVhmJVAyrOad5GEnPdKs11Mmr6EK22kGWHehxY=;
        b=U0iS/BVVc6GlFmdxsCsrZm+vuYqMPWM6LQEzP/rPZT0LRK1FmKxcCl+jWYByHKO8vK
         TuGKjew2VObOcrYYE4eyK4UpJZFFjPAwjgjT4mIRutQQ2Vxuzj8QjxKhHCg3nw3vzNED
         vZSPKYXXge3nP1zA4f916PvzsnFdtFXUYYvo/vCBqYr6JeO0fq1LsaJmDPBf4cq/0C0M
         d3CaG+V/4cuKKnOfgTzrDR+4/u1ffmvqS0FZSBif5rN2UjOW2EmFUnppPnBXQSfVamFi
         OYiAfyiYrIdb+YzWBCyfMOVVp3LC3iFOg413RyG/Mcq9jvrAIaljfGyFXz518IA81xk+
         QAzA==
X-Gm-Message-State: AFqh2kpAcdwOh6dWOT3LVKcuK2ft1VY5BFm7IMm/7je1qS74tJ9K1gBl
        vNyDorCF+OXFFyAxAaexp/Kzv2BeUs9bKw==
X-Google-Smtp-Source: AMrXdXsKmm9Or8yCK8XHnDGMa7MMBXKOaQF/TWYSMUc6tzDDEACFSYGR4MyGHsnRWYBe9aNxDQE+4A==
X-Received: by 2002:a05:6830:1457:b0:684:d25f:ad37 with SMTP id w23-20020a056830145700b00684d25fad37mr63294otp.2.1673569318815;
        Thu, 12 Jan 2023 16:21:58 -0800 (PST)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-550f-93bd-b210-47c2.res6.spectrum.com. [2603:8081:140c:1a00:550f:93bd:b210:47c2])
        by smtp.googlemail.com with ESMTPSA id z25-20020a056808049900b0035a9003b8edsm8480471oid.40.2023.01.12.16.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 16:21:58 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 2/6] RDMA/rxe: Move rxe_map_mr_sg to rxe_mr.c
Date:   Thu, 12 Jan 2023 18:21:12 -0600
Message-Id: <20230113002116.457324-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230113002116.457324-1-rpearsonhpe@gmail.com>
References: <20230113002116.457324-1-rpearsonhpe@gmail.com>
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

Move rxe_map_mr_sg() to rxe_mr.c where it makes a little more sense.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  2 ++
 drivers/infiniband/sw/rxe/rxe_mr.c    | 36 +++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c | 36 ---------------------------
 3 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 948ce4902b10..29b6c2143045 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -69,6 +69,8 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
+int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
+		  int sg_nents, unsigned int *sg_offset);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 632ee1e516a1..229c7259644c 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -223,6 +223,42 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
 	return err;
 }
 
+static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
+{
+	struct rxe_mr *mr = to_rmr(ibmr);
+	struct rxe_map *map;
+	struct rxe_phys_buf *buf;
+
+	if (unlikely(mr->nbuf == mr->num_buf))
+		return -ENOMEM;
+
+	map = mr->map[mr->nbuf / RXE_BUF_PER_MAP];
+	buf = &map->buf[mr->nbuf % RXE_BUF_PER_MAP];
+
+	buf->addr = addr;
+	buf->size = ibmr->page_size;
+	mr->nbuf++;
+
+	return 0;
+}
+
+int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
+		  int sg_nents, unsigned int *sg_offset)
+{
+	struct rxe_mr *mr = to_rmr(ibmr);
+	int n;
+
+	mr->nbuf = 0;
+
+	n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
+
+	mr->page_shift = ilog2(ibmr->page_size);
+	mr->page_mask = ibmr->page_size - 1;
+	mr->offset = ibmr->iova & mr->page_mask;
+
+	return n;
+}
+
 static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 			size_t *offset_out)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 025b35bf014e..7a902e0a0607 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -948,42 +948,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return ERR_PTR(err);
 }
 
-static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
-{
-	struct rxe_mr *mr = to_rmr(ibmr);
-	struct rxe_map *map;
-	struct rxe_phys_buf *buf;
-
-	if (unlikely(mr->nbuf == mr->num_buf))
-		return -ENOMEM;
-
-	map = mr->map[mr->nbuf / RXE_BUF_PER_MAP];
-	buf = &map->buf[mr->nbuf % RXE_BUF_PER_MAP];
-
-	buf->addr = addr;
-	buf->size = ibmr->page_size;
-	mr->nbuf++;
-
-	return 0;
-}
-
-static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
-			 int sg_nents, unsigned int *sg_offset)
-{
-	struct rxe_mr *mr = to_rmr(ibmr);
-	int n;
-
-	mr->nbuf = 0;
-
-	n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
-
-	mr->page_shift = ilog2(ibmr->page_size);
-	mr->page_mask = ibmr->page_size - 1;
-	mr->offset = ibmr->iova & mr->page_mask;
-
-	return n;
-}
-
 static ssize_t parent_show(struct device *device,
 			   struct device_attribute *attr, char *buf)
 {
-- 
2.37.2

