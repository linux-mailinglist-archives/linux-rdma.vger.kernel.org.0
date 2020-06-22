Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DB020335B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgFVJbx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 05:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgFVJbw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jun 2020 05:31:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AD8C061794
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 02:31:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r9so14177311wmh.2
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 02:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YLWgkgrgynaQs324bfzM58o2pA3MybQmz35lA2dR2Q0=;
        b=XBvqquNjZMJdjZBlCHZamwf80vYzsodrlpmbFpbMsIX4q5wlFesdXbi72FKs4pvDok
         JrI+Q0iXTqYqLYteoNgFFbX5Erq9ceBt9qLqTsyT9Jr39NzRHc+szQbph1uvgmIlRmnU
         MYXyDYhAy4fMORORvnzI7q9U6i4h/EnnqAVLOtRDkj47wsIcE3kTA2JSyHLB57K8Bklp
         reW6gzLjSkX6JPQDJINEpxw4smMg9HKwOy/qiCFJxwXYdP30I8rAxzYwMVhIgF3B2fWv
         8gXejkCMDlPix4HT13RwTlTDnOpPg9hxF75Lm+8AijLJcFjwUcio6573A+9yXX+m/RXJ
         NIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YLWgkgrgynaQs324bfzM58o2pA3MybQmz35lA2dR2Q0=;
        b=Cfg7UY/qbL1NcTpChiAbqEitz7OaUHR5/Eq7rLq1pFV/472uuoHrZhwZLb4pjnQjRO
         kuy2LQFxPZyMDLMkeUgfkc+Vl9unbetwBoSSrAq1n8Q5CvwrLnbRGu7T30iGJ5VQDEoI
         r2oPE6lVnjIYEIQ+faELGdluAopp6QPeMouKe0D5G3xK6H4H6RHTPSYAzUCFCNReb50V
         jlwwkWNCndh22wMeC4g7KUhAQF0ez1v4YuCG9vUyaT4EWby+9tJiDSA7L/4Tumt2uki5
         XBUgPpzC2VvugLRRkfcqsU2n/slCxHYhtLuw1OR9axfYtTReiFLHBiRx3eWxURpVw51Q
         Hz1g==
X-Gm-Message-State: AOAM530X/TEpC/cOJpcKapddHJ8LYW5pLO/KYgwBymoW1q3AmgTethxo
        7CGAZjSyeosWEuIfk8Lph35wStrg
X-Google-Smtp-Source: ABdhPJzksAVGgF1CW1H/dkIjtcu2ou+WBMATlEimxgtC8eQ+sdhXwfzjFIy/JvexL2tqaYTki8IGnw==
X-Received: by 2002:a1c:2d54:: with SMTP id t81mr18651161wmt.154.1592818309644;
        Mon, 22 Jun 2020 02:31:49 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 104sm17394726wrl.25.2020.06.22.02.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 02:31:49 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjunz@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Remove unused rxe_mem_map_pages
Date:   Mon, 22 Jun 2020 12:31:31 +0300
Message-Id: <20200622093131.9238-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This function is not in use - delete it.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h |  3 --
 drivers/infiniband/sw/rxe/rxe_mr.c  | 44 -----------------------------
 2 files changed, 47 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 775c23becaec..238d6a357aac 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -132,9 +132,6 @@ struct rxe_mem *lookup_mem(struct rxe_pd *pd, int access, u32 key,
 
 int mem_check_range(struct rxe_mem *mem, u64 iova, size_t length);
 
-int rxe_mem_map_pages(struct rxe_dev *rxe, struct rxe_mem *mem,
-		      u64 *page, int num_pages, u64 iova);
-
 void rxe_mem_cleanup(struct rxe_pool_entry *arg);
 
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index e83c7b518bfa..a63cb5fac01f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -587,47 +587,3 @@ struct rxe_mem *lookup_mem(struct rxe_pd *pd, int access, u32 key,
 
 	return mem;
 }
-
-int rxe_mem_map_pages(struct rxe_dev *rxe, struct rxe_mem *mem,
-		      u64 *page, int num_pages, u64 iova)
-{
-	int i;
-	int num_buf;
-	int err;
-	struct rxe_map **map;
-	struct rxe_phys_buf *buf;
-	int page_size;
-
-	if (num_pages > mem->max_buf) {
-		err = -EINVAL;
-		goto err1;
-	}
-
-	num_buf		= 0;
-	page_size	= 1 << mem->page_shift;
-	map		= mem->map;
-	buf		= map[0]->buf;
-
-	for (i = 0; i < num_pages; i++) {
-		buf->addr = *page++;
-		buf->size = page_size;
-		buf++;
-		num_buf++;
-
-		if (num_buf == RXE_BUF_PER_MAP) {
-			map++;
-			buf = map[0]->buf;
-			num_buf = 0;
-		}
-	}
-
-	mem->iova	= iova;
-	mem->va		= iova;
-	mem->length	= num_pages << mem->page_shift;
-	mem->state	= RXE_MEM_STATE_VALID;
-
-	return 0;
-
-err1:
-	return err;
-}
-- 
2.25.4

