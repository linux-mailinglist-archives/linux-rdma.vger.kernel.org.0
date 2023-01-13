Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B3F66A70F
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Jan 2023 00:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjAMX2H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Jan 2023 18:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjAMX2F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Jan 2023 18:28:05 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE128CBF2
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 15:28:05 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-15eeec85280so2817096fac.11
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 15:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVD4hXw6D0oLF7hPL29BBmRza9euKRPXQEHZZZmWvOw=;
        b=koFgt9L2AG4w57NJcD+oGkhUooIIggW/c2toEaSsLIcJXdhYRrcjnLrZrwkIpNb0Af
         QWp6U+JsAZTLOciJwXDqKuRP+E9/znpx+a3CM2WVrQnkurTPvxLj1ZKO19VfkKu8pv1i
         yiuuIrXUOWZycQHSGi6MTq4PaVu8LZnjbrxoR2lLw3vkApbieGxRiTkuoFio2pIqO9cT
         Gr5tBvm5d7dlkojmE36MPF4/lo0Tz0zqgfL65AqzAXmyT6LGHxPhZpitFd8v/cQdh/Zy
         yd+x81JI3BLggIXM4y4KlrC7goc1EIfOfUBU+D/FZ2cNeuSFm/SnZAVrsurk2P4ExxVd
         Dp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVD4hXw6D0oLF7hPL29BBmRza9euKRPXQEHZZZmWvOw=;
        b=aSyE885vki9D7MhUxGM62MJpevdUFMOeG54I/aylaEch1jt42k93wA91462VcvyaBr
         qMye6kCv8A6rJKmsUjDo+31xuBlqRU9GPpJKE+6cp1ZC8of9YngfodJ+hzxqbVkbBi23
         mEaHfbzHhrQiTZmhHmJq5yGuhMhPbWobwdU2ky8iciTyOVRJFxi0QHQizcTR/vYaskg2
         f4/IbqRMj+RTjvFmbVjgCE7wuaiGv1SDUMo8u5BLEVTtS10mVdtT5ZfVN4d+yj8wIYvD
         JB+wCmQc3wh+a8W9SfPjzQO5/J4dF7AgJU3NnhVZvIp7yHCzJl/h/jUjD5i/u5NrvmQh
         uEyw==
X-Gm-Message-State: AFqh2kpDEUEsrzRNfIqewNthgAJ2UOx7sEc0xeF6MXL4aP7XmGiWbcAz
        tOIMmnPRHNc65pr0mVCPjcM=
X-Google-Smtp-Source: AMrXdXu5pUkgQlhk0RGacHuEqZTrNydZZvrfEFKgSXKjNubFNE+dp3Wk8D/ralyoSFOe4+cZ2QghqA==
X-Received: by 2002:a05:6870:f705:b0:14f:e8c0:3cdf with SMTP id ej5-20020a056870f70500b0014fe8c03cdfmr31566782oab.5.1673652484436;
        Fri, 13 Jan 2023 15:28:04 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3f47-8433-ec70-f475.res6.spectrum.com. [2603:8081:140c:1a00:3f47:8433:ec70:f475])
        by smtp.gmail.com with ESMTPSA id q13-20020a9d57cd000000b0066871c3adb3sm11297433oti.28.2023.01.13.15.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:28:04 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 5/6] RDMA/rxe: Cleanup page variables in rxe_mr.c
Date:   Fri, 13 Jan 2023 17:27:05 -0600
Message-Id: <20230113232704.20072-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230113232704.20072-1-rpearsonhpe@gmail.com>
References: <20230113232704.20072-1-rpearsonhpe@gmail.com>
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

Cleanup usage of mr->page_shift and mr->page_mask and introduce
an extractor for mr->ibmr.page_size. Normal usage in the kernel
has page_mask masking out offset in page rather than masking out
the page number. The rxe driver had reversed that which was confusing.
Implicitly there can be a per mr page_size which was not uniformly
supported.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 31 ++++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 11 +++++++---
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 1e74f5e8e10b..fd5537ee7f04 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -60,6 +60,9 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->lkey = mr->ibmr.lkey = lkey;
 	mr->rkey = mr->ibmr.rkey = rkey;
 
+	mr->ibmr.page_size = PAGE_SIZE;
+	mr->page_mask = PAGE_MASK;
+	mr->page_shift = PAGE_SHIFT;
 	mr->state = RXE_MR_STATE_INVALID;
 }
 
@@ -149,9 +152,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		goto err_release_umem;
 	}
 
-	mr->page_shift = PAGE_SHIFT;
-	mr->page_mask = PAGE_SIZE - 1;
-
 	num_buf			= 0;
 	map = mr->map;
 	if (length > 0) {
@@ -180,7 +180,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 				goto err_release_umem;
 			}
 			buf->addr = (uintptr_t)vaddr;
-			buf->size = PAGE_SIZE;
+			buf->size = mr_page_size(mr);
 			num_buf++;
 			buf++;
 
@@ -189,10 +189,9 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 
 	mr->umem = umem;
 	mr->access = access;
-	mr->offset = ib_umem_offset(umem);
+	mr->page_offset = ib_umem_offset(umem);
 	mr->state = RXE_MR_STATE_VALID;
 	mr->ibmr.type = IB_MR_TYPE_USER;
-	mr->ibmr.page_size = PAGE_SIZE;
 
 	return 0;
 
@@ -246,29 +245,27 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 		  int sg_nents, unsigned int *sg_offset)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
-	int n;
-
-	mr->nbuf = 0;
+	unsigned int page_size = mr_page_size(mr);
 
-	n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
+	mr->page_shift = ilog2(page_size);
+	mr->page_mask = ~((u64)page_size - 1);
+	mr->page_offset = ibmr->iova & (page_size - 1);
 
-	mr->page_shift = ilog2(ibmr->page_size);
-	mr->page_mask = ibmr->page_size - 1;
-	mr->offset = ibmr->iova & mr->page_mask;
+	mr->nbuf = 0;
 
-	return n;
+	return ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
 }
 
 static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 			size_t *offset_out)
 {
-	size_t offset = iova - mr->ibmr.iova + mr->offset;
+	size_t offset = iova - mr->ibmr.iova + mr->page_offset;
 	int			map_index;
 	int			buf_index;
 	u64			length;
 
 	if (likely(mr->page_shift)) {
-		*offset_out = offset & mr->page_mask;
+		*offset_out = offset & (mr_page_size(mr) - 1);
 		offset >>= mr->page_shift;
 		*n_out = offset & mr->map_mask;
 		*m_out = offset >> mr->map_shift;
@@ -342,7 +339,7 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length)
 	if (mr->ibmr.type == IB_MR_TYPE_DMA)
 		return -EFAULT;
 
-	offset = (iova - mr->ibmr.iova + mr->offset) & mr->page_mask;
+	offset = (iova - mr->ibmr.iova + mr->page_offset) & mr->page_mask;
 	while (length > 0) {
 		u8 *va;
 		int bytes;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 19ddfa890480..bfc94caaeec5 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -310,11 +310,11 @@ struct rxe_mr {
 	u32			lkey;
 	u32			rkey;
 	enum rxe_mr_state	state;
-	u32			offset;
 	int			access;
 
-	int			page_shift;
-	int			page_mask;
+	unsigned int		page_offset;
+	unsigned int		page_shift;
+	u64			page_mask;
 	int			map_shift;
 	int			map_mask;
 
@@ -329,6 +329,11 @@ struct rxe_mr {
 	struct rxe_map		**map;
 };
 
+static inline unsigned int mr_page_size(struct rxe_mr *mr)
+{
+	return mr ? mr->ibmr.page_size : PAGE_SIZE;
+}
+
 enum rxe_mw_state {
 	RXE_MW_STATE_INVALID	= RXE_MR_STATE_INVALID,
 	RXE_MW_STATE_FREE	= RXE_MR_STATE_FREE,
-- 
2.37.2

