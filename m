Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0732F7C6829
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 10:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbjJLI3p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Oct 2023 04:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjJLI3p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Oct 2023 04:29:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF4E90
        for <linux-rdma@vger.kernel.org>; Thu, 12 Oct 2023 01:29:42 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BLJbC8015089
        for <linux-rdma@vger.kernel.org>; Thu, 12 Oct 2023 01:29:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=IgTvexqou6+QndyLyrp00fnaSqILY5NN2Sio+7dmHaw=;
 b=Kc7Uk1M71v4l/843S6k0MiPq45vYX9eTgvkPbLBLekqsIzTURLe8w/yG7htf6btCLkmZ
 zuV9wc8/uBoVuCVFzWaXAGPrwynIEE0pRMNciqT0v2xeHmiteN0UylpgL5o1xsWxbCB7
 jwGb5HZ2pR1H94SuCptWiRej2CF2J/072687c6Pr9ViPmt8Qhqvvj27FdRNaYd7i2LNw
 cYVQhFoVb/g1bDZG6FH0YE+czWqUylO2yFcmuXRAAye7g7CeBBXpzqygiDGbt+cFlhU1
 O+f010TlsE4jhNJR9gO9rrEmX0E++LmIrVtl0TSgJntcbFa9GfXWaoCKMFLsgcGRKuOf lA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tp168fnaa-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 12 Oct 2023 01:29:42 -0700
Received: from twshared5159.02.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 12 Oct 2023 01:29:37 -0700
Received: by devvm5855.lla0.facebook.com (Postfix, from userid 605850)
        id 56946410E4BD; Thu, 12 Oct 2023 01:29:33 -0700 (PDT)
From:   Maxim Samoylov <max7255@meta.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Christian Benvenuti <benve@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Maxim Samoylov <max7255@meta.com>
Subject: [PATCH v2] IB: rework memlock limit handling code
Date:   Thu, 12 Oct 2023 01:29:21 -0700
Message-ID: <20231012082921.546114-1-max7255@meta.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: gTpI_DeJKrgcDpGO2iT1aQlwCU2hHTvP
X-Proofpoint-ORIG-GUID: gTpI_DeJKrgcDpGO2iT1aQlwCU2hHTvP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_04,2023-10-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch provides the uniform handling for RLIM_INFINITY value
across the infiniband/rdma subsystem.

Currently in some cases the infinity constant is treated
as an actual limit value, which could be misleading.

Let's also provide the single helper to check against process
MEMLOCK limit while registering user memory region mappings.

Signed-off-by: Maxim Samoylov <max7255@meta.com>
---

v1 -> v2: rewritten commit message, rebased on recent upstream

 drivers/infiniband/core/umem.c             |  7 ++-----
 drivers/infiniband/hw/qib/qib_user_pages.c |  7 +++----
 drivers/infiniband/hw/usnic/usnic_uiom.c   |  6 ++----
 drivers/infiniband/sw/siw/siw_mem.c        |  6 +++---
 drivers/infiniband/sw/siw/siw_verbs.c      | 23 ++++++++++------------
 include/rdma/ib_umem.h                     | 11 +++++++++++
 6 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/ume=
m.c
index f9ab671c8eda..3b197bdc21bf 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -35,12 +35,12 @@
=20
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
-#include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/count_zeros.h>
+#include <rdma/ib_umem.h>
 #include <rdma/ib_umem_odp.h>
=20
 #include "uverbs.h"
@@ -150,7 +150,6 @@ struct ib_umem *ib_umem_get(struct ib_device *device,=
 unsigned long addr,
 {
 	struct ib_umem *umem;
 	struct page **page_list;
-	unsigned long lock_limit;
 	unsigned long new_pinned;
 	unsigned long cur_base;
 	unsigned long dma_attr =3D 0;
@@ -200,10 +199,8 @@ struct ib_umem *ib_umem_get(struct ib_device *device=
, unsigned long addr,
 		goto out;
 	}
=20
-	lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-
 	new_pinned =3D atomic64_add_return(npages, &mm->pinned_vm);
-	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
+	if (!ib_umem_check_rlimit_memlock(new_pinned)) {
 		atomic64_sub(npages, &mm->pinned_vm);
 		ret =3D -ENOMEM;
 		goto out;
diff --git a/drivers/infiniband/hw/qib/qib_user_pages.c b/drivers/infinib=
and/hw/qib/qib_user_pages.c
index 1bb7507325bc..3889aefdfc6b 100644
--- a/drivers/infiniband/hw/qib/qib_user_pages.c
+++ b/drivers/infiniband/hw/qib/qib_user_pages.c
@@ -32,8 +32,8 @@
  */
=20
 #include <linux/mm.h>
-#include <linux/sched/signal.h>
 #include <linux/device.h>
+#include <rdma/ib_umem.h>
=20
 #include "qib.h"
=20
@@ -94,14 +94,13 @@ int qib_map_page(struct pci_dev *hwdev, struct page *=
page, dma_addr_t *daddr)
 int qib_get_user_pages(unsigned long start_page, size_t num_pages,
 		       struct page **p)
 {
-	unsigned long locked, lock_limit;
+	unsigned long locked;
 	size_t got;
 	int ret;
=20
-	lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 	locked =3D atomic64_add_return(num_pages, &current->mm->pinned_vm);
=20
-	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
+	if (!ib_umem_check_rlimit_memlock(locked)) {
 		ret =3D -ENOMEM;
 		goto bail;
 	}
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniban=
d/hw/usnic/usnic_uiom.c
index 84e0f41e7dfa..fdbb9737c7f0 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -34,13 +34,13 @@
=20
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
-#include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/iommu.h>
 #include <linux/workqueue.h>
 #include <linux/list.h>
 #include <rdma/ib_verbs.h>
+#include <rdma/ib_umem.h>
=20
 #include "usnic_log.h"
 #include "usnic_uiom.h"
@@ -90,7 +90,6 @@ static int usnic_uiom_get_pages(unsigned long addr, siz=
e_t size, int writable,
 	struct scatterlist *sg;
 	struct usnic_uiom_chunk *chunk;
 	unsigned long locked;
-	unsigned long lock_limit;
 	unsigned long cur_base;
 	unsigned long npages;
 	int ret;
@@ -124,9 +123,8 @@ static int usnic_uiom_get_pages(unsigned long addr, s=
ize_t size, int writable,
 	mmap_read_lock(mm);
=20
 	locked =3D atomic64_add_return(npages, &current->mm->pinned_vm);
-	lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
=20
-	if ((locked > lock_limit) && !capable(CAP_IPC_LOCK)) {
+	if (!ib_umem_check_rlimit_memlock(locked)) {
 		ret =3D -ENOMEM;
 		goto out;
 	}
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/=
siw/siw_mem.c
index c5f7f1669d09..fe11379e6928 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -5,6 +5,7 @@
=20
 #include <linux/gfp.h>
 #include <rdma/ib_verbs.h>
+#include <rdma/ib_umem.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
@@ -367,7 +368,6 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, boo=
l writable)
 	struct siw_umem *umem;
 	struct mm_struct *mm_s;
 	u64 first_page_va;
-	unsigned long mlock_limit;
 	unsigned int foll_flags =3D FOLL_LONGTERM;
 	int num_pages, num_chunks, i, rv =3D 0;
=20
@@ -396,9 +396,9 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, boo=
l writable)
=20
 	mmap_read_lock(mm_s);
=20
-	mlock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
=20
-	if (atomic64_add_return(num_pages, &mm_s->pinned_vm) > mlock_limit) {
+	if (!ib_umem_check_rlimit_memlock(
+		atomic64_add_return(num_pages, &mm_s->pinned_vm))) {
 		rv =3D -ENOMEM;
 		goto out_sem_up;
 	}
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/s=
w/siw/siw_verbs.c
index c5c27db9c2fe..e98a4a239722 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -12,6 +12,7 @@
=20
 #include <rdma/iw_cm.h>
 #include <rdma/ib_verbs.h>
+#include <rdma/ib_umem.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/uverbs_ioctl.h>
=20
@@ -1321,8 +1322,8 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64=
 start, u64 len,
 	struct siw_umem *umem =3D NULL;
 	struct siw_ureq_reg_mr ureq;
 	struct siw_device *sdev =3D to_siw_dev(pd->device);
-
-	unsigned long mem_limit =3D rlimit(RLIMIT_MEMLOCK);
+	unsigned long num_pages =3D
+		(PAGE_ALIGN(len + (start & ~PAGE_MASK))) >> PAGE_SHIFT;
 	int rv;
=20
 	siw_dbg_pd(pd, "start: 0x%pK, va: 0x%pK, len: %llu\n",
@@ -1338,19 +1339,15 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u=
64 start, u64 len,
 		rv =3D -EINVAL;
 		goto err_out;
 	}
-	if (mem_limit !=3D RLIM_INFINITY) {
-		unsigned long num_pages =3D
-			(PAGE_ALIGN(len + (start & ~PAGE_MASK))) >> PAGE_SHIFT;
-		mem_limit >>=3D PAGE_SHIFT;
=20
-		if (num_pages > mem_limit - current->mm->locked_vm) {
-			siw_dbg_pd(pd, "pages req %lu, max %lu, lock %lu\n",
-				   num_pages, mem_limit,
-				   current->mm->locked_vm);
-			rv =3D -ENOMEM;
-			goto err_out;
-		}
+	if (!ib_umem_check_rlimit_memlock(num_pages + current->mm->locked_vm)) =
{
+		siw_dbg_pd(pd, "pages req %lu, max %lu, lock %lu\n",
+				num_pages, rlimit(RLIMIT_MEMLOCK),
+				current->mm->locked_vm);
+		rv =3D -ENOMEM;
+		goto err_out;
 	}
+
 	umem =3D siw_umem_get(start, len, ib_access_writable(rights));
 	if (IS_ERR(umem)) {
 		rv =3D PTR_ERR(umem);
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 95896472a82b..3970da64b01e 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -11,6 +11,7 @@
 #include <linux/scatterlist.h>
 #include <linux/workqueue.h>
 #include <rdma/ib_verbs.h>
+#include <linux/sched/signal.h>
=20
 struct ib_ucontext;
 struct ib_umem_odp;
@@ -71,6 +72,16 @@ static inline size_t ib_umem_num_pages(struct ib_umem =
*umem)
 	return ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 }
=20
+static inline bool ib_umem_check_rlimit_memlock(unsigned long value)
+{
+	unsigned long lock_limit =3D rlimit(RLIMIT_MEMLOCK);
+
+	if (lock_limit =3D=3D RLIM_INFINITY || capable(CAP_IPC_LOCK))
+		return true;
+
+	return value <=3D PFN_DOWN(lock_limit);
+}
+
 static inline void __rdma_umem_block_iter_start(struct ib_block_iter *bi=
ter,
 						struct ib_umem *umem,
 						unsigned long pgsz)
--=20
2.39.3

