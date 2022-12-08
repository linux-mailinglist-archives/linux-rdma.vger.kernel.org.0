Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325616477A4
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 22:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLHVGU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Dec 2022 16:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLHVGT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Dec 2022 16:06:19 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E42B554D2
        for <linux-rdma@vger.kernel.org>; Thu,  8 Dec 2022 13:06:18 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-142b72a728fso3287929fac.9
        for <linux-rdma@vger.kernel.org>; Thu, 08 Dec 2022 13:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4az7TRteRxLRSLDJFsJTC0GgkozEL5OI5plF8WEz9DU=;
        b=IPGLVjETJ7Tprr940tp+Wz7trKUfqmKwFa9DoDl4v+/KGZd2dOFGS6PM1BB/22lWBC
         qTk+nytp/Sal8DK1z+ihRidhD6tBZweDMTqFUNq1G2K5IYQPqUjY8SsJQLIya3RjwXuz
         8BsUl/k52ZmQxlZ7Nv7T2l3RPfZHrRAGRyXU+faxshNQ2Udj3eSf6ec+REKY3WRzfj0G
         Tuhyx9fq65GxOjZUBiPyWpGSJsQYDfWSKicHyX0YBpRIwuGnH3w7bqj7FAsw+3o9squi
         nFdYHGd+cng8y1xK8m4TojhkxqjCVYntY+ufNADXIljdcTu+8jRQMtSYwc3n6+S+PDnu
         fdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4az7TRteRxLRSLDJFsJTC0GgkozEL5OI5plF8WEz9DU=;
        b=epfAfGgKA9rqHuIc47kYdg3rsZvda5iIMM/qztu8BOl8ZP4ImMFaL3b3vryMR4e7AF
         SJzq2JyAvD4Z0/Tz9cIzV0qrEVQ2lzhmVfo47G0OVMU4V7Nf7xU/QEGm13RCcs+ZjsJp
         sOQ0SMWiz60uaR7VaDG/c0ezMDoHUUuZx6yqvBPC1gjM/LeKfWOng18FMNKmS7+Ze4+H
         F7by4PYd6KIhqOv4tIsdZEfvy1K3z3Q5UvicpL0v+37qM+FuQgJDUZirPHMGQH4VOQq0
         WWiycmOy5Fuexy0zJewk5MPovAyZ8Ie5tK/xAOkHpwWG4ELzYr1Vj4Sf3KMK6I+g3bXq
         dCwA==
X-Gm-Message-State: ANoB5pnDUVFkM5lT9zhWI+ZJmc2wwzWmyOErZUGtl+MHAvlkbCLtK3bj
        HlfZU+xf0tyjCT4vwyATwoM=
X-Google-Smtp-Source: AA0mqf5Pa2sNbvigZwQbEDKKGAL6oRwap1Ld/IB6l6IBXKO0tzJk0by8U/vbu2N2pYXMdk2f/1GCGw==
X-Received: by 2002:a05:6870:514d:b0:143:fb49:6f6b with SMTP id z13-20020a056870514d00b00143fb496f6bmr1846426oak.59.1670533577616;
        Thu, 08 Dec 2022 13:06:17 -0800 (PST)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a13f-9234-e395-548a.res6.spectrum.com. [2603:8081:140c:1a00:a13f:9234:e395:548a])
        by smtp.googlemail.com with ESMTPSA id t11-20020a056870e74b00b0012763819bcasm5739250oak.50.2022.12.08.13.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:06:17 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 2/6] RDMA/rxe: Move rxe_map_mr_sg to rxe_mr.c
Date:   Thu,  8 Dec 2022 15:05:44 -0600
Message-Id: <20221208210547.28562-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221208210547.28562-1-rpearsonhpe@gmail.com>
References: <20221208210547.28562-1-rpearsonhpe@gmail.com>
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
index a22476d27b38..11106c181e74 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -68,6 +68,8 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
+int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
+		  int sg_nents, unsigned int *sg_offset);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index b007ff05baaf..0dabd3897028 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -202,6 +202,42 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
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

