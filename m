Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567E76254A0
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 08:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiKKHvo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 02:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiKKHvn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 02:51:43 -0500
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E6ADF75
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 23:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668153099; i=@fujitsu.com;
        bh=Upj4A6qeXOo8xYPwH+ryFEx5gmJFTmEdYJbEi0Pk8eA=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=mr1DdJxXXZzW1/jOPzVlLDbypuGJ3INt/5hhNyajim0Tcf/1Sp1CGNu+ZRVvF7Sug
         FtNxsR/tXWamqnfuClToWpB+1rSYU8VsKeriSxkOJgjKPnlfi3JT5fe1SEh8ZtRPsl
         3fz+ZpzD3V+pLLkT17vvN3p8T3jMtsxofIyGOLHjXCyvOacicn70f4SipEuhAfy7zV
         Sgo6CMlCrSGdF22uw82PrDilTpppZhR7fXUAn4tz+/o8ZyPmS89Txl6ZDQ+VnBDj7z
         l00JwsK4U4bERjFrJn4Cg9xueVfqDjOZD8crAZ8nMQfxBVarMcq4aib2/jfi2tbP3e
         g7zDZr863IbLA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRWlGSWpSXmKPExsViZ8ORpMv9Pzf
  ZoLmR3WL/0+csFlf+7WG0eHaol8Wi4S2XA4tHy5G3rB6L97xk8uhtfsfm8XmTXABLFGtmXlJ+
  RQJrxp62rILXmhVLFs5gb2C8p9jFyMUhJLCRUaJl/hlGCGcJk8SematYIJz9jBIHP3xl7mLk5
  GATUJPYOf0lC4gtIuAq0XD2OSOIzSwQI7HzyxIgm4NDWMBG4tBHZhCTRUBVov2+J0gFr4CjxJ
  otP1lBbAkBBYkpD98zQ8QFJU7OfMICMUVC4uCLF8wQNYoSbUv+sUPYFRKzZrUxQdhqElfPbWK
  ewMg/C0n7LCTtCxiZVjGaFqcWlaUW6VroJRVlpmeU5CZm5uglVukm6qWW6panFpfoGuollhfr
  pRYX6xVX5ibnpOjlpZZsYgSGb0oxk/sOxqPL/ugdYpTkYFIS5d1nk5ssxJeUn1KZkVicEV9Um
  pNafIhRhoNDSYL31E+gnGBRanpqRVpmDjCWYNISHDxKIryTPgKleYsLEnOLM9MhUqcYdTmmzv
  63n1mIJS8/L1VKnNfkB1CRAEhRRmke3AhYXF9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMz
  75TvQFJ7MvBK4Ta+AjmACOsIuNQvkiJJEhJRUA5NL3wWHLzksf9X7ND0DV+86KLxli2vp9fDH
  ksL+OiXLf5afmGa4PbPYRj1F5P/5M7eS9B7/eC55uGXGkYtec6Sf9DOxNL5SsKi0XaYrEsxdU
  VhRNI+XyztP5+PyppefZ5WaKhqs0FMNOHD189JFcZ+nXbGbNf3kkhnrurm+tLTY13oek4sq8T
  5hxDUv1u5G4m2LlV26Jz6IvAgVMZ/f6ywnfX5Rm/jSnS5tn1zz2XU1Yw2T/zYyvb65+9H+L/b
  vUzLuqJ5j1jQ2FZm0zW3S17Qsvfnf92neTu2y2z47b81K2ax/qVPU5vZmrvZI3fLLX3D2ym9y
  sz7sf9CjMoXl6vlzDZ5bH7tENn0UV46zU1diKc5INNRiLipOBABUc7CLZgMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-8.tower-587.messagelabs.com!1668153098!277008!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8444 invoked from network); 11 Nov 2022 07:51:39 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-8.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Nov 2022 07:51:39 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id AF5F81AF;
        Fri, 11 Nov 2022 07:51:38 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id A40C51AD;
        Fri, 11 Nov 2022 07:51:38 +0000 (GMT)
Received: from d55ea0a62e71.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 11 Nov 2022 07:51:35 +0000
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <jgg@nvidia.com>, <ira.weiny@intel.com>, <linyunsheng@huawei.com>
CC:     <lizhijian@fujitsu.com>, <linux-rdma@vger.kernel.org>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v2 1/2] RDMA/rxe: Remove struct rxe_phys_buf
Date:   Fri, 11 Nov 2022 07:51:24 +0000
Message-ID: <1668153085-15-1-git-send-email-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

1) Remove rxe_phys_buf[n].size by using ibmr.page_size.
2) Replace rxe_phys_buf[n].buf with addrs[n].

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 45 +++++++++------------------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  6 +---
 drivers/infiniband/sw/rxe/rxe_verbs.h |  9 ++----
 3 files changed, 18 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index bc081002bddc..4438eb8a3727 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -115,7 +115,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr)
 {
 	struct rxe_map		**map;
-	struct rxe_phys_buf	*buf = NULL;
 	struct ib_umem		*umem;
 	struct sg_page_iter	sg_iter;
 	int			num_buf;
@@ -144,16 +143,14 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 
 	mr->page_shift = PAGE_SHIFT;
 	mr->page_mask = PAGE_SIZE - 1;
+	mr->ibmr.page_size = PAGE_SIZE;
 
-	num_buf			= 0;
+	num_buf	= 0;
 	map = mr->map;
 	if (length > 0) {
-		buf = map[0]->buf;
-
 		for_each_sgtable_page (&umem->sgt_append.sgt, &sg_iter, 0) {
 			if (num_buf >= RXE_BUF_PER_MAP) {
 				map++;
-				buf = map[0]->buf;
 				num_buf = 0;
 			}
 
@@ -165,10 +162,8 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 				goto err_cleanup_map;
 			}
 
-			buf->addr = (uintptr_t)vaddr;
-			buf->size = PAGE_SIZE;
+			map[0]->addrs[num_buf] = (uintptr_t)vaddr;
 			num_buf++;
-			buf++;
 
 		}
 	}
@@ -216,9 +211,9 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 			size_t *offset_out)
 {
 	size_t offset = iova - mr->ibmr.iova + mr->offset;
+	u64 length = mr->ibmr.page_size;
 	int			map_index;
-	int			buf_index;
-	u64			length;
+	int			addr_index;
 
 	if (likely(mr->page_shift)) {
 		*offset_out = offset & mr->page_mask;
@@ -227,23 +222,20 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 		*m_out = offset >> mr->map_shift;
 	} else {
 		map_index = 0;
-		buf_index = 0;
-
-		length = mr->map[map_index]->buf[buf_index].size;
+		addr_index = 0;
 
 		while (offset >= length) {
 			offset -= length;
-			buf_index++;
+			addr_index++;
 
-			if (buf_index == RXE_BUF_PER_MAP) {
+			if (addr_index == RXE_BUF_PER_MAP) {
 				map_index++;
-				buf_index = 0;
+				addr_index = 0;
 			}
-			length = mr->map[map_index]->buf[buf_index].size;
 		}
 
 		*m_out = map_index;
-		*n_out = buf_index;
+		*n_out = addr_index;
 		*offset_out = offset;
 	}
 }
@@ -273,13 +265,13 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 
 	lookup_iova(mr, iova, &m, &n, &offset);
 
-	if (offset + length > mr->map[m]->buf[n].size) {
+	if (offset + length > mr->ibmr.page_size) {
 		pr_warn("crosses page boundary\n");
 		addr = NULL;
 		goto out;
 	}
 
-	addr = (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
+	addr = (void *)(uintptr_t)mr->map[m]->addrs[n] + offset;
 
 out:
 	return addr;
@@ -294,8 +286,6 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	int			err;
 	int			bytes;
 	u8			*va;
-	struct rxe_map		**map;
-	struct rxe_phys_buf	*buf;
 	int			m;
 	int			i;
 	size_t			offset;
@@ -325,17 +315,14 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 
 	lookup_iova(mr, iova, &m, &i, &offset);
 
-	map = mr->map + m;
-	buf	= map[0]->buf + i;
-
 	while (length > 0) {
 		u8 *src, *dest;
 
-		va	= (u8 *)(uintptr_t)buf->addr + offset;
+		va	= (u8 *)(uintptr_t)mr->map[m]->addrs[i] + offset;
 		src = (dir == RXE_TO_MR_OBJ) ? addr : va;
 		dest = (dir == RXE_TO_MR_OBJ) ? va : addr;
 
-		bytes	= buf->size - offset;
+		bytes	= mr->ibmr.page_size - offset;
 
 		if (bytes > length)
 			bytes = length;
@@ -346,13 +333,11 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		addr	+= bytes;
 
 		offset	= 0;
-		buf++;
 		i++;
 
 		if (i == RXE_BUF_PER_MAP) {
 			i = 0;
-			map++;
-			buf = map[0]->buf;
+			m++;
 		}
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index bcdfdadaebbc..13e4d660cb02 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -948,16 +948,12 @@ static int rxe_set_page(struct ib_mr *ibmr, u64 addr)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
 	struct rxe_map *map;
-	struct rxe_phys_buf *buf;
 
 	if (unlikely(mr->nbuf == mr->num_buf))
 		return -ENOMEM;
 
 	map = mr->map[mr->nbuf / RXE_BUF_PER_MAP];
-	buf = &map->buf[mr->nbuf % RXE_BUF_PER_MAP];
-
-	buf->addr = addr;
-	buf->size = ibmr->page_size;
+	map->addrs[mr->nbuf % RXE_BUF_PER_MAP] = addr;
 	mr->nbuf++;
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 22a299b0a9f0..d136f02d5b56 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -277,15 +277,10 @@ enum rxe_mr_lookup_type {
 	RXE_LOOKUP_REMOTE,
 };
 
-#define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
-
-struct rxe_phys_buf {
-	u64      addr;
-	u64      size;
-};
+#define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(u64))
 
 struct rxe_map {
-	struct rxe_phys_buf	buf[RXE_BUF_PER_MAP];
+	u64 addrs[RXE_BUF_PER_MAP];
 };
 
 static inline int rkey_is_mw(u32 rkey)
-- 
2.25.1

