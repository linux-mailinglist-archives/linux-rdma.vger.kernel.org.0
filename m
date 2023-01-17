Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BA366E4F4
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 18:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjAQRch (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 12:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjAQR2S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 12:28:18 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343AE49002
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 09:27:02 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-15eec491b40so11753678fac.12
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 09:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSc+ZeVhmJVAyrOad5GEnPdKs11Mmr6EK22kGWHehxY=;
        b=S0jxHlN9znCy3t3w9k126stS5Ohj1zO7XikB/+mF9v9N1ni0RX/s2imK5pOv5pjjJ1
         /C4Ri9B4laSdmpaWSzakHNHqcIhqwyzo4IQuUddun6384CfxWWexoz/cL79zUtxFrzl0
         /Yie/qXYLFoXBJIZSXwhAV3gkdm7J9LUGsfLcqaa6pw8J9KYmxRRmtEsJAIzplUY8abW
         WJD9rAkJ2YdNCrsYuVeo5kexn1J9eDFEwAH61jH7W5lh5IKQ67MK9KJMUecYX+Ewhe63
         X5WJVISZtLTx939lB4XELV3C/7u1WyCvZaTfyjxFb2yZXp/hnTMY/+KtzP7qhcgl+gxp
         nR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSc+ZeVhmJVAyrOad5GEnPdKs11Mmr6EK22kGWHehxY=;
        b=xaHcwHmvAYLJwuhKorYuibXdG7Pih05r1rRHlyKBZUT23IeBcohIwP80oMBYcN5uL1
         cSa0byka5qVu4bpqZrGv+pqS3mC6h/d26b5izVtInKN+Dm0DFQZDtx71LVGzQGiQoN7E
         t+2RMLKcOlyLdHy+vtdTEeeUx4/adnXXbnCf64HmmNj2bgtmv3aug8LuCj2aBjZoxWA/
         gZ5TxXi98q9TJyofRfeFE32wMbg+krG1tkKFLT7Ei023itgHhUEUGTdOZ0RKaySNyV0C
         ZEZWGWa4PoqIMo342PtNJpIz/Xm/RFx2ub07O2qShX2V/HUaXUL7cUp8aaWP6QEe6fLS
         hdqg==
X-Gm-Message-State: AFqh2kreM7WxJ23C7SjlFhaGgO6kO1bMzyBty/bkvFj0fSoewXXpITF7
        2H94O1Ib/0bZpKUYTaF+VRY=
X-Google-Smtp-Source: AMrXdXsWkvap8bkP/77/M7cK5O3ijVXC1L6iPZpencWvlgxmbfchGQI75cMxJl5gB8Edsa7wvRUjcg==
X-Received: by 2002:a05:6870:44c7:b0:150:329c:84f0 with SMTP id t7-20020a05687044c700b00150329c84f0mr2379365oai.45.1673976421993;
        Tue, 17 Jan 2023 09:27:01 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id l3-20020a056870218300b00152c52608dbsm16936489oae.34.2023.01.17.09.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:27:01 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 2/6] RDMA/rxe: Move rxe_map_mr_sg to rxe_mr.c
Date:   Tue, 17 Jan 2023 11:25:37 -0600
Message-Id: <20230117172540.33205-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230117172540.33205-1-rpearsonhpe@gmail.com>
References: <20230117172540.33205-1-rpearsonhpe@gmail.com>
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

