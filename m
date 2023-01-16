Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAA466D37A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 00:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjAPX7J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 18:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbjAPX6q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 18:58:46 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE472C669
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 15:56:50 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id n8so24686673oih.0
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 15:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSc+ZeVhmJVAyrOad5GEnPdKs11Mmr6EK22kGWHehxY=;
        b=dzSCCWKiOF8AhsJPVQsUwHpoBoPGpnRpCX/xAobpftA5kwfwRiv+rTCNGp7rdSJIuK
         G/UxzeTNdRB52GWFA1mCZivfuc7dQZVywoNjKsM1ql/kFleMDQ3aQMzCYt96T9y/mrju
         0Qjlt8Itl/Hich9L2++FJJGHvxne6C6CB9c3O4ueMZ+mlcTwC9HE51o1kqZYKu9AuKlD
         mFjOiIY1Z5gXC0jbvoZkqCij0WFoSzTsUs7XteUel6Sqe+oFZOttv8lpg0tRcPvPCOlb
         pDMBFqVFZynvOm4eW4K1Eo1QlknKyZYM6GwZj0YHVGu3lWM2eogzVwqhaz3joh8ou6fK
         wTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSc+ZeVhmJVAyrOad5GEnPdKs11Mmr6EK22kGWHehxY=;
        b=yR1N0p/CEuKX5i1GaESq9hqAeBvmmA99jWNIiYcBOsc9cX/PySCE8Q8Ixhp7i19UH7
         tc7Rrn3mQwR3d29z4xy57YtpKjYDxcxmIvk+9dlQ1ruR+/wQxilJWEXVEeUvacEJaDNr
         +TwVlt0lYbMVOQw8vs3GTGskUerJh3bKpevjvpHLGJA1wek4abXicNnl+b/Zs6ZZKZDV
         XHIoA12PPn/rotTxmVzVpCNSlpfzWt+xu86NNr2WYDX4lk+Iz9aOcbKAO/pIFxwCsMrk
         HpC0hYSVZHwbCWc4ge66L/q4JDpsuiwi3VVtFS4sKvKwkZ5ROSd+1Pc2mVyjCPvP52rX
         Ayww==
X-Gm-Message-State: AFqh2kqDzN3rc9OLGHLc1/+wFrTm101VAzZzsnMnY3mjcW7udvZ7oGIV
        rI9ns7eoevDiwJTjtuAy2c06ReXNhZ7/eg==
X-Google-Smtp-Source: AMrXdXu30HIDO7L4jYRnbWftmMukO9kOSZbCH2j/mJEyu8ud1ZgyRV00EWtBP/F/Y57tpdWWY/tblg==
X-Received: by 2002:a05:6808:128e:b0:35d:d646:3d02 with SMTP id a14-20020a056808128e00b0035dd6463d02mr849688oiw.28.1673913410364;
        Mon, 16 Jan 2023 15:56:50 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id w17-20020a9d77d1000000b00684e55f4541sm3540546otl.70.2023.01.16.15.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 15:56:50 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 2/6] RDMA/rxe: Move rxe_map_mr_sg to rxe_mr.c
Date:   Mon, 16 Jan 2023 17:55:59 -0600
Message-Id: <20230116235602.22899-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230116235602.22899-1-rpearsonhpe@gmail.com>
References: <20230116235602.22899-1-rpearsonhpe@gmail.com>
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

