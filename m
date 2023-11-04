Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E40F7E0E40
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Nov 2023 08:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjKDH5H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Nov 2023 03:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDH5G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Nov 2023 03:57:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0921819D
        for <linux-rdma@vger.kernel.org>; Sat,  4 Nov 2023 00:57:03 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A46jSah006624;
        Sat, 4 Nov 2023 07:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/u8xU//gSNUGMM9Nw3Ti0OZRiyr3SQTjMOyPUOZsFto=;
 b=SWdVFC/OAPmDwZMOvxee386H3SC2Qw0LAXszl2UuMUMpGKALQ+pBeaf8jGoRgxUexFP0
 TAFm6tl2+a5cCfaJl5AVwSv3GgzJxIE2w4eQkSMYhiI3N4oiaX5Eq2Z9k0RBt+cj+WX9
 lOHkgdK0ZATFnOFDXuNOLEpPIwfTOSlDcrQmvlQLykIJN5O2lXTrP74H+VXVpsM25uGy
 5+gQTIppzPwYZBvh62ysck22xcUo8pyaYhTT+OVg2L6zrpCW3uk0xgzWaBkT7K5Cpk9c
 EeCDUWRG3VajHNkZcq+BOfhMoOd890ZO7CGrVHSJVUH9TnCqUJq7LlSfyE8uH68cfwWC 8Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u5gy9h54s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Nov 2023 07:56:49 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A47DICB006891;
        Sat, 4 Nov 2023 07:56:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1fb2tykw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Nov 2023 07:56:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A47ukrl5636696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 4 Nov 2023 07:56:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F9C82004B;
        Sat,  4 Nov 2023 07:56:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0722D20040;
        Sat,  4 Nov 2023 07:56:46 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.68.71])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat,  4 Nov 2023 07:56:45 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, leon@kernel.org, max7255@meta.com,
        dennis.dalessandro@cornelisnetworks.com, guoqing.jiang@linux.dev,
        benve@cisco.com, vadim.fedorenko@linux.dev,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH for-next v2] RDMA/siw: Use ib_umem_get() to pin user pages
Date:   Sat,  4 Nov 2023 08:56:43 +0100
Message-Id: <20231104075643.195186-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jOkgSmOKl40Xzhr-0SeVzPWfObs7c7kY
X-Proofpoint-ORIG-GUID: jOkgSmOKl40Xzhr-0SeVzPWfObs7c7kY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-04_05,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=737 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311040064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Abandon siw private code to pin user pages during user
memory registration, but use ib_umem_get() instead.
This will help maintaining the driver in case of changes
to the memory subsystem.

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
v1 -> v2: remove RLIMIT memlock check logic, now done in ib_umem_get()
---
 drivers/infiniband/sw/siw/siw.h       |   3 +-
 drivers/infiniband/sw/siw/siw_mem.c   | 109 ++++++++++----------------
 drivers/infiniband/sw/siw/siw_mem.h   |   5 +-
 drivers/infiniband/sw/siw/siw_verbs.c |  19 +----
 4 files changed, 47 insertions(+), 89 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 58dddb143b9f..6930586109d4 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -121,11 +121,10 @@ struct siw_page_chunk {
 };
 
 struct siw_umem {
+	struct ib_umem *base_mem;
 	struct siw_page_chunk *page_chunk;
 	int num_pages;
-	bool writable;
 	u64 fp_addr; /* First page base address */
-	struct mm_struct *owning_mm;
 };
 
 struct siw_pble {
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index e6e25f15567d..6cc44df2ece5 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -5,6 +5,7 @@
 
 #include <linux/gfp.h>
 #include <rdma/ib_verbs.h>
+#include <rdma/ib_umem.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
@@ -60,28 +61,17 @@ struct siw_mem *siw_mem_id2obj(struct siw_device *sdev, int stag_index)
 	return NULL;
 }
 
-static void siw_free_plist(struct siw_page_chunk *chunk, int num_pages,
-			   bool dirty)
+void siw_umem_release(struct siw_umem *umem)
 {
-	unpin_user_pages_dirty_lock(chunk->plist, num_pages, dirty);
-}
-
-void siw_umem_release(struct siw_umem *umem, bool dirty)
-{
-	struct mm_struct *mm_s = umem->owning_mm;
 	int i, num_pages = umem->num_pages;
 
-	for (i = 0; num_pages; i++) {
-		int to_free = min_t(int, PAGES_PER_CHUNK, num_pages);
+	if (umem->base_mem)
+		ib_umem_release(umem->base_mem);
 
-		siw_free_plist(&umem->page_chunk[i], to_free,
-			       umem->writable && dirty);
+	for (i = 0; num_pages > 0; i++) {
 		kfree(umem->page_chunk[i].plist);
-		num_pages -= to_free;
+		num_pages -= PAGES_PER_CHUNK;
 	}
-	atomic64_sub(umem->num_pages, &mm_s->pinned_vm);
-
-	mmdrop(mm_s);
 	kfree(umem->page_chunk);
 	kfree(umem);
 }
@@ -145,7 +135,7 @@ void siw_free_mem(struct kref *ref)
 
 	if (!mem->is_mw && mem->mem_obj) {
 		if (mem->is_pbl == 0)
-			siw_umem_release(mem->umem, true);
+			siw_umem_release(mem->umem);
 		else
 			kfree(mem->pbl);
 	}
@@ -362,18 +352,16 @@ struct siw_pbl *siw_pbl_alloc(u32 num_buf)
 	return pbl;
 }
 
-struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
+struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
+			      u64 len, int rights)
 {
 	struct siw_umem *umem;
-	struct mm_struct *mm_s;
+	struct ib_umem *base_mem;
+	struct sg_page_iter sg_iter;
+	struct sg_table *sgt;
 	u64 first_page_va;
-	unsigned long mlock_limit;
-	unsigned int foll_flags = FOLL_LONGTERM;
 	int num_pages, num_chunks, i, rv = 0;
 
-	if (!can_do_mlock())
-		return ERR_PTR(-EPERM);
-
 	if (!len)
 		return ERR_PTR(-EINVAL);
 
@@ -385,65 +373,50 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 	if (!umem)
 		return ERR_PTR(-ENOMEM);
 
-	mm_s = current->mm;
-	umem->owning_mm = mm_s;
-	umem->writable = writable;
-
-	mmgrab(mm_s);
-
-	if (writable)
-		foll_flags |= FOLL_WRITE;
-
-	mmap_read_lock(mm_s);
-
-	mlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-
-	if (atomic64_add_return(num_pages, &mm_s->pinned_vm) > mlock_limit) {
-		rv = -ENOMEM;
-		goto out_sem_up;
-	}
-	umem->fp_addr = first_page_va;
-
 	umem->page_chunk =
 		kcalloc(num_chunks, sizeof(struct siw_page_chunk), GFP_KERNEL);
 	if (!umem->page_chunk) {
 		rv = -ENOMEM;
-		goto out_sem_up;
+		goto err_out;
 	}
-	for (i = 0; num_pages; i++) {
+	base_mem = ib_umem_get(base_dev, start, len, rights);
+	if (IS_ERR(base_mem)) {
+		rv = PTR_ERR(base_mem);
+		siw_dbg(base_dev, "Cannot pin user memory: %d\n", rv);
+		goto err_out;
+	}
+	umem->fp_addr = first_page_va;
+	umem->base_mem = base_mem;
+
+	sgt = &base_mem->sgt_append.sgt;
+	__sg_page_iter_start(&sg_iter, sgt->sgl, sgt->orig_nents, 0);
+
+	if (!__sg_page_iter_next(&sg_iter)) {
+		rv = -EINVAL;
+		goto err_out;
+	}
+	for (i = 0; num_pages > 0; i++) {
 		int nents = min_t(int, num_pages, PAGES_PER_CHUNK);
 		struct page **plist =
 			kcalloc(nents, sizeof(struct page *), GFP_KERNEL);
 
 		if (!plist) {
 			rv = -ENOMEM;
-			goto out_sem_up;
+			goto err_out;
 		}
 		umem->page_chunk[i].plist = plist;
-		while (nents) {
-			rv = pin_user_pages(first_page_va, nents, foll_flags,
-					    plist);
-			if (rv < 0)
-				goto out_sem_up;
-
-			umem->num_pages += rv;
-			first_page_va += rv * PAGE_SIZE;
-			plist += rv;
-			nents -= rv;
-			num_pages -= rv;
+		while (nents--) {
+			*plist = sg_page_iter_page(&sg_iter);
+			umem->num_pages++;
+			num_pages--;
+			plist++;
+			if (!__sg_page_iter_next(&sg_iter))
+				break;
 		}
 	}
-out_sem_up:
-	mmap_read_unlock(mm_s);
-
-	if (rv > 0)
-		return umem;
-
-	/* Adjust accounting for pages not pinned */
-	if (num_pages)
-		atomic64_sub(num_pages, &mm_s->pinned_vm);
-
-	siw_umem_release(umem, false);
+	return umem;
+err_out:
+	siw_umem_release(umem);
 
 	return ERR_PTR(rv);
 }
diff --git a/drivers/infiniband/sw/siw/siw_mem.h b/drivers/infiniband/sw/siw/siw_mem.h
index f911287576d1..562a693f7662 100644
--- a/drivers/infiniband/sw/siw/siw_mem.h
+++ b/drivers/infiniband/sw/siw/siw_mem.h
@@ -6,8 +6,9 @@
 #ifndef _SIW_MEM_H
 #define _SIW_MEM_H
 
-struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable);
-void siw_umem_release(struct siw_umem *umem, bool dirty);
+struct siw_umem *siw_umem_get(struct ib_device *base_dave, u64 start,
+			      u64 len, int rights);
+void siw_umem_release(struct siw_umem *umem);
 struct siw_pbl *siw_pbl_alloc(u32 num_buf);
 dma_addr_t siw_pbl_get_buffer(struct siw_pbl *pbl, u64 off, int *len, int *idx);
 struct siw_mem *siw_mem_id2obj(struct siw_device *sdev, int stag_index);
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index fdbef3254e30..5910207f60b1 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1321,8 +1321,6 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	struct siw_umem *umem = NULL;
 	struct siw_ureq_reg_mr ureq;
 	struct siw_device *sdev = to_siw_dev(pd->device);
-
-	unsigned long mem_limit = rlimit(RLIMIT_MEMLOCK);
 	int rv;
 
 	siw_dbg_pd(pd, "start: 0x%pK, va: 0x%pK, len: %llu\n",
@@ -1338,20 +1336,7 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		rv = -EINVAL;
 		goto err_out;
 	}
-	if (mem_limit != RLIM_INFINITY) {
-		unsigned long num_pages =
-			(PAGE_ALIGN(len + (start & ~PAGE_MASK))) >> PAGE_SHIFT;
-		mem_limit >>= PAGE_SHIFT;
-
-		if (num_pages > mem_limit - current->mm->locked_vm) {
-			siw_dbg_pd(pd, "pages req %lu, max %lu, lock %lu\n",
-				   num_pages, mem_limit,
-				   current->mm->locked_vm);
-			rv = -ENOMEM;
-			goto err_out;
-		}
-	}
-	umem = siw_umem_get(start, len, ib_access_writable(rights));
+	umem = siw_umem_get(pd->device, start, len, rights);
 	if (IS_ERR(umem)) {
 		rv = PTR_ERR(umem);
 		siw_dbg_pd(pd, "getting user memory failed: %d\n", rv);
@@ -1404,7 +1389,7 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		kfree_rcu(mr, rcu);
 	} else {
 		if (umem)
-			siw_umem_release(umem, false);
+			siw_umem_release(umem);
 	}
 	return ERR_PTR(rv);
 }
-- 
2.38.1

