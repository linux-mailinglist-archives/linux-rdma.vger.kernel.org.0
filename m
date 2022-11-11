Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73EC6254A1
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 08:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiKKHvr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 02:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiKKHvq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 02:51:46 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F28DF75
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 23:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668153103; i=@fujitsu.com;
        bh=1hjiLZ/TRv5LSCVkQ8K21+lpE+B7hGvCA9WToglW/dc=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=eFGDDH+d1QU6A5x7uFNGErd2u+hXzyJzEMw82ql8NdE5ZHswpMYR0QwsR9NtDZCC3
         xdpxpY4Bmzv71O3iH7HU9gkroKPES2AYKuQk745g8feSFv100B33psyjrV4dOR0Ekn
         yrMIfLKxURmTeTNPNLBqn8+5Sk2k0c3b60ddaR5eeTAwkK/59ksTgjDVl0n1VYphFQ
         7Ej7HgMByorIlFWls4EWL4ScLu+gSs6iYihUxIZM1lAB4TKUuruDVOB3493jv8UFWS
         MQt403pCN33a0KFpk7MTT7mB8yRS3oKmw7ZS85sCL0bJQja+d5+QDryTe3/2z0L1xK
         PAKbO4MnUpdHQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRWlGSWpSXmKPExsViZ8MxSZfvf26
  yQdduAYv9T5+zWFz5t4fR4tmhXhaLhrdcDiweLUfesnos3vOSyaO3+R2bx+dNcgEsUayZeUn5
  FQmsGdv//WUqeKZYMffYd7YGxk0yXYxcHEICWxglGndfYYFwljNJnGhfwgzh7GeUOLntNWsXI
  ycHm4CaxM7pL1lAbBEBV4mGs88ZQWxmgRiJnV+WgNnCAv4Sy6fsZwKxWQRUJTZMuM0GYvMKOE
  pM/NnIDGJLCChITHn4HszmFHCSmLLlEth8IaCafz/vQdULSpyc+YQFYr6ExMEXL6B6FSXalvx
  jh7ArJGbNamOCsNUkrp7bxDyBUXAWkvZZSNoXMDKtYjQrTi0qSy3SNdVLKspMzyjJTczM0Uus
  0k3USy3VzcsvKsnQNdRLLC/WSy0u1iuuzE3OSdHLSy3ZxAgM+5TiBKcdjFOW/dE7xCjJwaQky
  rvPJjdZiC8pP6UyI7E4I76oNCe1+BCjDAeHkgTvqZ9AOcGi1PTUirTMHGAMwqQlOHiURHgnfQ
  RK8xYXJOYWZ6ZDpE4x6nJMnf1vP7MQS15+XqqUOK/JD6AiAZCijNI8uBGwdHCJUVZKmJeRgYF
  BiKcgtSg3swRV/hWjOAejkjDvl+9AU3gy80rgNr0COoIJ6Ai71CyQI0oSEVJSDUwr9u51+p4Q
  ES6zS2bVhmNyVqILroQdnOtpn88j+/rdsQMiR+/b3N7tzsT3s2elQve7rZGGvtm/NfsZT35jl
  NuwQmnRpZvSDDL55+yjtoSYLl572OYPW032mgTFjrjv7Ja3p8w4YVr7PWN30WoFBfH2dE1Lle
  PLNy26eePalBDBAzGdHKkGdbvnHDvetKzp4PJEs7/bjrOlGDx6FnUu7wIrr5u/sbS019nezIK
  zkZ8a7q05VXqu8sc9Va99gZI3qqqf81bFLwzYuJg/yWT33vN7lJvcT6jKryu82WnjKxpz6I74
  IVGhxA6JGzM0TsSFCWz9wB7ueX0bu3kI1zyzvCM7Xm5r6Hk0M9rp1uI+D0klluKMREMt5qLiR
  AAtI/KxggMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-2.tower-732.messagelabs.com!1668153101!614423!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16728 invoked from network); 11 Nov 2022 07:51:42 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-2.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Nov 2022 07:51:42 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id A3DB11000DC;
        Fri, 11 Nov 2022 07:51:41 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 9715D1000D5;
        Fri, 11 Nov 2022 07:51:41 +0000 (GMT)
Received: from d55ea0a62e71.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 11 Nov 2022 07:51:38 +0000
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <jgg@nvidia.com>, <ira.weiny@intel.com>, <linyunsheng@huawei.com>
CC:     <lizhijian@fujitsu.com>, <linux-rdma@vger.kernel.org>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v2 2/2] RDMA/rxe: Replace page_address() with kmap_local_page()
Date:   Fri, 11 Nov 2022 07:51:25 +0000
Message-ID: <1668153085-15-2-git-send-email-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668153085-15-1-git-send-email-yangx.jy@fujitsu.com>
References: <1668153085-15-1-git-send-email-yangx.jy@fujitsu.com>
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

page_address() will be broken when new in-kernel memory protection
scheme[1] is applied in the future so use kmap_local_page() instead.

[1]:
https://lore.kernel.org/lkml/20220419170649.1022246-1-ira.weiny@intel.com/

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  |  2 ++
 drivers/infiniband/sw/rxe/rxe_mr.c   | 44 +++++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_resp.c |  1 +
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index c2a5c8814a48..a63d29156a66 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -68,6 +68,8 @@ void rxe_mr_init_dma(int access, struct rxe_mr *mr);
 int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
+void *rxe_map_to_vaddr(struct rxe_mr *mr, int map_index, int addr_index, size_t offset);
+void rxe_unmap_vaddr(struct rxe_mr *mr, void *vaddr);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir);
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 4438eb8a3727..2e6408188083 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -118,9 +118,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 	struct ib_umem		*umem;
 	struct sg_page_iter	sg_iter;
 	int			num_buf;
-	void			*vaddr;
 	int err;
-	int i;
 
 	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
 	if (IS_ERR(umem)) {
@@ -154,15 +152,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 				num_buf = 0;
 			}
 
-			vaddr = page_address(sg_page_iter_page(&sg_iter));
-			if (!vaddr) {
-				pr_warn("%s: Unable to get virtual address\n",
-						__func__);
-				err = -ENOMEM;
-				goto err_cleanup_map;
-			}
-
-			map[0]->addrs[num_buf] = (uintptr_t)vaddr;
+			map[0]->addrs[num_buf] = (uintptr_t)sg_page_iter_page(&sg_iter);
 			num_buf++;
 
 		}
@@ -176,10 +166,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 
 	return 0;
 
-err_cleanup_map:
-	for (i = 0; i < mr->num_map; i++)
-		kfree(mr->map[i]);
-	kfree(mr->map);
 err_release_umem:
 	ib_umem_release(umem);
 err_out:
@@ -240,6 +226,28 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 	}
 }
 
+void *rxe_map_to_vaddr(struct rxe_mr *mr, int map_index, int addr_index, size_t offset)
+{
+	void *vaddr = NULL;
+
+	if (mr->ibmr.type == IB_MR_TYPE_USER) {
+		vaddr = kmap_local_page((struct page *)mr->map[map_index]->addrs[addr_index]);
+		if (vaddr == NULL) {
+			pr_warn("Failed to map page");
+			return NULL;
+		}
+	} else
+		vaddr = (void *)(uintptr_t)mr->map[map_index]->addrs[addr_index];
+
+	return vaddr + offset;
+}
+
+void rxe_unmap_vaddr(struct rxe_mr *mr, void *vaddr)
+{
+	if (mr->ibmr.type == IB_MR_TYPE_USER)
+		kunmap_local(vaddr);
+}
+
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 {
 	size_t offset;
@@ -271,7 +279,7 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 		goto out;
 	}
 
-	addr = (void *)(uintptr_t)mr->map[m]->addrs[n] + offset;
+	addr = rxe_map_to_vaddr(mr, m, n, offset);
 
 out:
 	return addr;
@@ -318,7 +326,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	while (length > 0) {
 		u8 *src, *dest;
 
-		va	= (u8 *)(uintptr_t)mr->map[m]->addrs[i] + offset;
+		va = (u8 *)rxe_map_to_vaddr(mr, m, i, offset);
 		src = (dir == RXE_TO_MR_OBJ) ? addr : va;
 		dest = (dir == RXE_TO_MR_OBJ) ? va : addr;
 
@@ -339,6 +347,8 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 			i = 0;
 			m++;
 		}
+
+		rxe_unmap_vaddr(mr, va);
 	}
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c32bc12cc82f..31f9ba11a921 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -652,6 +652,7 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 
 	ret = RESPST_ACKNOWLEDGE;
 out:
+	rxe_unmap_vaddr(mr, vaddr);
 	return ret;
 }
 
-- 
2.25.1

