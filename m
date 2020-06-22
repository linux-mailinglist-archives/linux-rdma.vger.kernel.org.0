Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6BE203483
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 12:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgFVKHo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 06:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgFVKHo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jun 2020 06:07:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DB9C061794
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 03:07:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so14274499wmh.4
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OlYae0rVzSm/nwi6wzox4rVecwx/Gi9dzTErMpIMioM=;
        b=XXPQIL/j4JA87k9MtPmwjLZEJqL15ddGm4U0lhuT+PFdYJcFLA6rU2y9Mr0MUYtLLG
         TvfWuVB2bwX728rggj5O1scsxBajFC/M4sdHuiYxNsMUj1UNApEtdGQ8PdetGrTtD6f2
         qzCEmnw35vG1HysybOJdaLOLVj0EcRohhfo8caNLxJvhtrbiIRKBy5EoChLXhE3twQoc
         f4Sj2LGFryhV2fGRn9qLlq6yV3rqhMOuEQG3KR491RhnI9S29oTPtddR4n7KbLcnfdxR
         Jljf/LeLsp5rz5fqFPD2HEcjL9TMAMYfex6/PAJyl+y0mW05qMYD5pxRcG23tcKGNU/U
         xIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OlYae0rVzSm/nwi6wzox4rVecwx/Gi9dzTErMpIMioM=;
        b=UlAbsW1zBXh3X5ZwHiS1xY5QXlSRNlr0FO62uV3nFx3oTXdJwX5SLq+AHI1NJzg6RA
         td/Lv3HdxZHyvfEbv7uIZXi5yOqb4GZ7QOTZSQ/PIRl3Fgpxf4xRcRlAF81LdD/VAkzP
         b8S7VJRt1TVZAVpt3tIbtInSivDQTr9OwTW9jLyuwYom+mA+E9hUmB3gJlhwiyEEgqb3
         G+GzPnOulkMz69e8zqWEX2LBqnFjQmHAtExA9VbE4hxcm+/92E+eeXLi59kJAqwI4V1x
         vJc65xfwM2+jSp6NMAaYCULY0hTwuPvxgDsnwGT7v3JBkXTfhRfYd14aT80d/DFnYhjs
         s89g==
X-Gm-Message-State: AOAM533LYca9j4gQBwKEHEi0BRBPvkdl059Rs0fHFeSYzlLYERxWar8C
        VD4te5b0wOizw6vAWDUrm9ZXSAtB
X-Google-Smtp-Source: ABdhPJxammthONaEOhCLyeNXHE0Dgu9iefJwH2nPIx//d/ET8Mbu7sXzr+R4l4d4Sya1cTCHJYoKwQ==
X-Received: by 2002:a1c:9802:: with SMTP id a2mr16862232wme.64.1592820462695;
        Mon, 22 Jun 2020 03:07:42 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id d2sm17474779wrs.95.2020.06.22.03.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 03:07:41 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjunz@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v2] RDMA/rxe: Remove unused rxe_mem_map_pages
Date:   Mon, 22 Jun 2020 13:07:31 +0300
Message-Id: <20200622100731.27359-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This function is not in use - delete it.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
v2: Add fixes tag.
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

