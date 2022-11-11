Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839F0625292
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 05:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiKKEbQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 23:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiKKEbC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 23:31:02 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FAE69DD2;
        Thu, 10 Nov 2022 20:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668141059; i=@fujitsu.com;
        bh=6BOQYMvWVSi2uBbZfL1Bzz07XDsCbIwy+Optf2MNYVA=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Wl7LeVr8srVymoGxdKgmQAMbHmM6+bwnmfzzLVYbzLZOCNZ7eMkzmAcCUP17WBfK6
         2bAF/IG9DkwxOCM2lA2u8J5PiHCSB8QvaoP6QhDwyruzjpIogmV+erJ+U5MhMzKKHc
         I2W2UppcHCxJ80nhSlKL7lstMjHDY0s9gxN6P69gIxCagu/ift1fjA4QZ6S14k3APj
         PubLoCLVpB9FyvHKVpFwPf3IQYmPe3++EMraT/r/K5wiV3M0j8jecGg/iQnNN4Jc/A
         HP8IMX+l10b7mdhv5AWIBa/LrmR1VVTYOTOBdovSu9P7J6TcU/7XidRPWFcJrzPQvx
         2Mhl+sZeUBoUg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRWlGSWpSXmKPExsViZ8OxWZfpQm6
  ywZtNphYzZ5xgtJjyaymzxeVdc9gsnh3qZbE4f6yf3YHVY+esu+wem1Z1snl83iTnsfXzbZYA
  lijWzLyk/IoE1oy1y/6xFJxTqtg0aS9jA2O7bBcjJ4eQwEZGiflnMiHsJUwSO8/LQdgHGCUe9
  SiA2GwCGhL3Wm4ygtgiAp2MEtta00BsZgE3iU1vZrOD2MICdhIf7z9hAbFZBFQl3t9rYAOxeQ
  UcJRZ9PQ5WIyGgIDHl4XtmEJtTwEli+Z0vbBC7HCVOzbzDAlEvKHFyJsQcZgEJiYMvXgDVcwD
  1KknM7I6HGFMhMWtWGxOErSZx9dwm5gmMgrOQdM9C0r2AkWkVo1lxalFZapGuqV5SUWZ6Rklu
  YmaOXmKVbqJeaqluXn5RSYauoV5iebFeanGxXnFlbnJOil5easkmRmDopxQnOO1gnLLsj94hR
  kkOJiVR3n02uclCfEn5KZUZicUZ8UWlOanFhxhlODiUJHj1zgLlBItS01Mr0jJzgHEIk5bg4F
  ES4RXeDpTmLS5IzC3OTIdInWJUlBLntToPlBAASWSU5sG1wWL/EqOslDAvIwMDgxBPQWpRbmY
  JqvwrRnEORiVh3rhzQFN4MvNK4Ka/AlrMBLTYLjULZHFJIkJKqoEpVy3ny/dFuypy52bn2Qgo
  Pt/88+kRjsksG68afykKOb0lUGmFYqLCkl093Zfj7JcI/HuYkbjh+9Qfcx9NeFS49OI9OZ6fL
  q9sPlZ/dg/Juarx0UXvWN+qTzv9wyQlVJ9wLxHsPlQXcWilj8dsvhsTFxbp/1LjuXE09uSU22
  cMxD4EBPqfFZU4x3dKo1Qwebna95aqA1fc87m1xT4Y3ldtWexab81YFHfE5L/reaWdoQbvZ3h
  FhZkv3JnC9WlOenTYv+Ts0KsL6mz3SxTbuSUzdk1bZh4Vocj4UYN13q/c9Q8m2Tv2zG1YmHUv
  8uBDcdHa3Uzlp+cr9W+ZYZb2/sbx9r5FEjzTl4d/YUpYZxKnxFKckWioxVxUnAgAXtqlj3gDA
  AA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-15.tower-728.messagelabs.com!1668141058!608057!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14018 invoked from network); 11 Nov 2022 04:30:58 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-15.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Nov 2022 04:30:58 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 41D42156;
        Fri, 11 Nov 2022 04:30:58 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 34D92153;
        Fri, 11 Nov 2022 04:30:58 +0000 (GMT)
Received: from bc0da1a9c27e.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 11 Nov 2022 04:30:55 +0000
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH 4/5] RDMA/rxe: refactor iova_to_vaddr
Date:   Fri, 11 Nov 2022 04:30:29 +0000
Message-ID: <1668141030-2-5-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
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

For IB_MR_TYPE_USER MR, iova_to_vaddr() will call kmap_local_page() to
map page.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 38 +++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_resp.c  |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.h |  5 +++-
 4 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index c2a5c8814a48..22a8c44d39c8 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -73,6 +73,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
 	      void *addr, int length, enum rxe_mr_copy_dir dir);
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
+void rxe_unmap_vaddr(struct rxe_mr *mr, void *vaddr);
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 			 enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index a4e786b657b7..d26a4a33119c 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -120,9 +120,7 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 	struct ib_umem		*umem;
 	struct sg_page_iter	sg_iter;
 	int			num_buf;
-	void			*vaddr;
 	int err;
-	int i;
 
 	umem = ib_umem_get(&rxe->ib_dev, start, length, access);
 	if (IS_ERR(umem)) {
@@ -159,18 +157,9 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
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
-			buf->addr = (uintptr_t)vaddr;
+			buf->page = sg_page_iter_page(&sg_iter);
 			num_buf++;
 			buf++;
-
 		}
 	}
 
@@ -182,10 +171,6 @@ int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
 
 	return 0;
 
-err_cleanup_map:
-	for (i = 0; i < mr->num_map; i++)
-		kfree(mr->map[i]);
-	kfree(mr->map);
 err_release_umem:
 	ib_umem_release(umem);
 err_out:
@@ -246,6 +231,12 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
 	}
 }
 
+void rxe_unmap_vaddr(struct rxe_mr *mr, void *vaddr)
+{
+	if (mr->ibmr.type == IB_MR_TYPE_USER)
+		kunmap_local(vaddr);
+}
+
 static void *__iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 {
 	size_t offset;
@@ -258,9 +249,21 @@ static void *__iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 		return NULL;
 	}
 
-	return (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
+	if (mr->ibmr.type == IB_MR_TYPE_USER) {
+		char *paddr;
+		struct page *pg = mr->map[m]->buf[n].page;
+
+		paddr = kmap_local_page(pg);
+		if (paddr == NULL) {
+			pr_warn("Failed to map page");
+			return NULL;
+		}
+		return paddr + offset;
+	} else
+		return (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
 }
 
+/* must call rxe_unmap_vaddr to unmap vaddr */
 void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 {
 	if (mr->state != RXE_MR_STATE_VALID) {
@@ -326,6 +329,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		dest = (dir == RXE_TO_MR_OBJ) ? va : addr;
 
 		memcpy(dest, src, bytes);
+		rxe_unmap_vaddr(mr, va);
 
 		length	-= bytes;
 		addr	+= bytes;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 483043dc4e89..765cb9f8538a 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -636,6 +636,7 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 
 		*vaddr = value;
 		spin_unlock_bh(&atomic_ops_lock);
+		rxe_unmap_vaddr(mr, vaddr);
 
 		qp->resp.msn++;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index acab785ba7e2..6080a4b32f09 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -280,7 +280,10 @@ enum rxe_mr_lookup_type {
 #define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
 
 struct rxe_phys_buf {
-	u64      addr;
+	union {
+		u64 addr; /* IB_MR_TYPE_MEM_REG */
+		struct page *page; /* IB_MR_TYPE_USER */
+	};
 };
 
 struct rxe_map {
-- 
2.31.1

