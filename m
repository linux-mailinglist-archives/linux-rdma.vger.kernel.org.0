Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2FC45FBB
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 16:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfFNN6E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 09:58:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728378AbfFNN6C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 09:58:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EDnNDk076111
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jun 2019 09:58:00 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t4crpghqu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jun 2019 09:57:58 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Fri, 14 Jun 2019 14:57:57 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Jun 2019 14:57:55 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5EDvs1A46924016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 13:57:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 689704204B;
        Fri, 14 Jun 2019 13:57:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48DF842041;
        Fri, 14 Jun 2019 13:57:54 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jun 2019 13:57:54 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH v2 06/11] SIW application buffer management
Date:   Fri, 14 Jun 2019 15:57:45 +0200
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190614135750.15874-1-bmt@zurich.ibm.com>
References: <20190614135750.15874-1-bmt@zurich.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19061413-0020-0000-0000-0000034A2037
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061413-0021-0000-0000-0000219D5D21
Message-Id: <20190614135750.15874-7-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140118
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_mem.c | 460 ++++++++++++++++++++++++++++
 drivers/infiniband/sw/siw/siw_mem.h |  74 +++++
 2 files changed, 534 insertions(+)
 create mode 100644 drivers/infiniband/sw/siw/siw_mem.c
 create mode 100644 drivers/infiniband/sw/siw/siw_mem.h

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
new file mode 100644
index 000000000000..67171c82b0c4
--- /dev/null
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+
+/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
+/* Copyright (c) 2008-2019, IBM Corporation */
+
+#include <linux/gfp.h>
+#include <rdma/ib_verbs.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/sched/mm.h>
+#include <linux/resource.h>
+
+#include "siw.h"
+#include "siw_mem.h"
+
+/*
+ * Stag lookup is based on its index part only (24 bits).
+ * The code avoids special Stag of zero and tries to randomize
+ * STag values between 1 and SIW_STAG_MAX_INDEX.
+ */
+int siw_mem_add(struct siw_device *sdev, struct siw_mem *m)
+{
+	struct xa_limit limit = XA_LIMIT(1, 0x00ffffff);
+	u32 id, next;
+
+	get_random_bytes(&next, 4);
+	next &= 0x00ffffff;
+
+	if (xa_alloc_cyclic(&sdev->mem_xa, &id, m, limit, &next,
+	    GFP_KERNEL) < 0)
+		return -ENOMEM;
+
+	/* Set the STag index part */
+	m->stag = id << 8;
+
+	siw_dbg_mem(m, "new MEM object\n");
+
+	return 0;
+}
+
+/*
+ * siw_mem_id2obj()
+ *
+ * resolves memory from stag given by id. might be called from:
+ * o process context before sending out of sgl, or
+ * o in softirq when resolving target memory
+ */
+struct siw_mem *siw_mem_id2obj(struct siw_device *sdev, int stag_index)
+{
+	struct siw_mem *mem;
+
+	rcu_read_lock();
+	mem = xa_load(&sdev->mem_xa, stag_index);
+	if (likely(mem && kref_get_unless_zero(&mem->ref))) {
+		rcu_read_unlock();
+		return mem;
+	}
+	rcu_read_unlock();
+
+	return NULL;
+}
+
+static void siw_free_plist(struct siw_page_chunk *chunk, int num_pages,
+			   bool dirty)
+{
+	struct page **p = chunk->plist;
+
+	while (num_pages--) {
+		if (!PageDirty(*p) && dirty)
+			put_user_pages_dirty_lock(p, 1);
+		else
+			put_user_page(*p);
+		p++;
+	}
+}
+
+void siw_umem_release(struct siw_umem *umem, bool dirty)
+{
+	struct mm_struct *mm_s = umem->owning_mm;
+	int i, num_pages = umem->num_pages;
+
+	for (i = 0; num_pages; i++) {
+		int to_free = min_t(int, PAGES_PER_CHUNK, num_pages);
+
+		siw_free_plist(&umem->page_chunk[i], to_free,
+			       umem->writable && dirty);
+		kfree(umem->page_chunk[i].plist);
+		num_pages -= to_free;
+	}
+	atomic64_sub(umem->num_pages, &mm_s->pinned_vm);
+
+	mmdrop(mm_s);
+	kfree(umem->page_chunk);
+	kfree(umem);
+}
+
+int siw_mr_add_mem(struct siw_mr *mr, struct ib_pd *pd, void *mem_obj,
+		   u64 start, u64 len, int rights)
+{
+	struct siw_device *sdev = to_siw_dev(pd->device);
+	struct siw_mem *mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+	struct xa_limit limit = XA_LIMIT(1, 0x00ffffff);
+	u32 id, next;
+
+	if (!mem)
+		return -ENOMEM;
+
+	mem->mem_obj = mem_obj;
+	mem->stag_valid = 0;
+	mem->sdev = sdev;
+	mem->va = start;
+	mem->len = len;
+	mem->pd = pd;
+	mem->perms = rights & IWARP_ACCESS_MASK;
+	kref_init(&mem->ref);
+
+	mr->mem = mem;
+
+	get_random_bytes(&next, 4);
+	next &= 0x00ffffff;
+
+	if (xa_alloc_cyclic(&sdev->mem_xa, &id, mem, limit, &next,
+	    GFP_KERNEL) < 0) {
+		kfree(mem);
+		return -ENOMEM;
+	}
+	/* Set the STag index part */
+	mem->stag = id << 8;
+	mr->base_mr.lkey = mr->base_mr.rkey = mem->stag;
+
+	return 0;
+}
+
+void siw_mr_drop_mem(struct siw_mr *mr)
+{
+	struct siw_mem *mem = mr->mem, *found;
+
+	mem->stag_valid = 0;
+
+	/* make STag invalid visible asap */
+	smp_mb();
+
+	found = xa_erase(&mem->sdev->mem_xa, mem->stag >> 8);
+	WARN_ON(found != mem);
+	siw_mem_put(mem);
+}
+
+void siw_free_mem(struct kref *ref)
+{
+	struct siw_mem *mem = container_of(ref, struct siw_mem, ref);
+
+	siw_dbg_mem(mem, "free mem, pbl: %s\n", mem->is_pbl ? "y" : "n");
+
+	if (!mem->is_mw && mem->mem_obj) {
+		if (mem->is_pbl == 0)
+			siw_umem_release(mem->umem, true);
+		else
+			kfree(mem->pbl);
+	}
+	kfree(mem);
+}
+
+/*
+ * siw_check_mem()
+ *
+ * Check protection domain, STAG state, access permissions and
+ * address range for memory object.
+ *
+ * @pd:		Protection Domain memory should belong to
+ * @mem:	memory to be checked
+ * @addr:	starting addr of mem
+ * @perms:	requested access permissions
+ * @len:	len of memory interval to be checked
+ *
+ */
+int siw_check_mem(struct ib_pd *pd, struct siw_mem *mem, u64 addr,
+		  enum ib_access_flags perms, int len)
+{
+	if (!mem->stag_valid) {
+		siw_dbg_pd(pd, "STag 0x%08x invalid\n", mem->stag);
+		return -E_STAG_INVALID;
+	}
+	if (mem->pd != pd) {
+		siw_dbg_pd(pd, "STag 0x%08x: PD mismatch\n", mem->stag);
+		return -E_PD_MISMATCH;
+	}
+	/*
+	 * check access permissions
+	 */
+	if ((mem->perms & perms) < perms) {
+		siw_dbg_pd(pd, "permissions 0x%08x < 0x%08x\n",
+			   mem->perms, perms);
+		return -E_ACCESS_PERM;
+	}
+	/*
+	 * Check if access falls into valid memory interval.
+	 */
+	if (addr < mem->va || addr + len > mem->va + mem->len) {
+		siw_dbg_pd(pd, "MEM interval len %d\n", len);
+		siw_dbg_pd(pd, "[0x%016llx, 0x%016llx] out of bounds\n",
+			   (unsigned long long)addr,
+			   (unsigned long long)(addr + len));
+		siw_dbg_pd(pd, "[0x%016llx, 0x%016llx] STag=0x%08x\n",
+			   (unsigned long long)mem->va,
+			   (unsigned long long)(mem->va + mem->len),
+			   mem->stag);
+
+		return -E_BASE_BOUNDS;
+	}
+	return E_ACCESS_OK;
+}
+
+/*
+ * siw_check_sge()
+ *
+ * Check SGE for access rights in given interval
+ *
+ * @pd:		Protection Domain memory should belong to
+ * @sge:	SGE to be checked
+ * @mem:	location of memory reference within array
+ * @perms:	requested access permissions
+ * @off:	starting offset in SGE
+ * @len:	len of memory interval to be checked
+ *
+ * NOTE: Function references SGE's memory object (mem->obj)
+ * if not yet done. New reference is kept if check went ok and
+ * released if check failed. If mem->obj is already valid, no new
+ * lookup is being done and mem is not released it check fails.
+ */
+int siw_check_sge(struct ib_pd *pd, struct siw_sge *sge, struct siw_mem *mem[],
+		  enum ib_access_flags perms, u32 off, int len)
+{
+	struct siw_device *sdev = to_siw_dev(pd->device);
+	struct siw_mem *new = NULL;
+	int rv = E_ACCESS_OK;
+
+	if (len + off > sge->length) {
+		rv = -E_BASE_BOUNDS;
+		goto fail;
+	}
+	if (*mem == NULL) {
+		new = siw_mem_id2obj(sdev, sge->lkey >> 8);
+		if (unlikely(!new)) {
+			siw_dbg_pd(pd, "STag unknown: 0x%08x\n", sge->lkey);
+			rv = -E_STAG_INVALID;
+			goto fail;
+		}
+		*mem = new;
+	}
+	/* Check if user re-registered with different STag key */
+	if (unlikely((*mem)->stag != sge->lkey)) {
+		siw_dbg_mem((*mem), "STag mismatch: 0x%08x\n", sge->lkey);
+		rv = -E_STAG_INVALID;
+		goto fail;
+	}
+	rv = siw_check_mem(pd, *mem, sge->laddr + off, perms, len);
+	if (unlikely(rv))
+		goto fail;
+
+	return 0;
+
+fail:
+	if (new) {
+		*mem = NULL;
+		siw_mem_put(new);
+	}
+	return rv;
+}
+
+void siw_wqe_put_mem(struct siw_wqe *wqe, enum siw_opcode op)
+{
+	switch (op) {
+	case SIW_OP_SEND:
+	case SIW_OP_WRITE:
+	case SIW_OP_SEND_WITH_IMM:
+	case SIW_OP_SEND_REMOTE_INV:
+	case SIW_OP_READ:
+	case SIW_OP_READ_LOCAL_INV:
+		if (!(wqe->sqe.flags & SIW_WQE_INLINE))
+			siw_unref_mem_sgl(wqe->mem, wqe->sqe.num_sge);
+		break;
+
+	case SIW_OP_RECEIVE:
+		siw_unref_mem_sgl(wqe->mem, wqe->rqe.num_sge);
+		break;
+
+	case SIW_OP_READ_RESPONSE:
+		siw_unref_mem_sgl(wqe->mem, 1);
+		break;
+
+	default:
+		/*
+		 * SIW_OP_INVAL_STAG and SIW_OP_REG_MR
+		 * do not hold memory references
+		 */
+		break;
+	}
+}
+
+int siw_invalidate_stag(struct ib_pd *pd, u32 stag)
+{
+	struct siw_device *sdev = to_siw_dev(pd->device);
+	struct siw_mem *mem = siw_mem_id2obj(sdev, stag >> 8);
+	int rv = 0;
+
+	if (unlikely(!mem)) {
+		siw_dbg_pd(pd, "STag 0x%08x unknown\n", stag);
+		return -EINVAL;
+	}
+	if (unlikely(mem->pd != pd)) {
+		siw_dbg_pd(pd, "PD mismatch for STag 0x%08x\n", stag);
+		rv = -EACCES;
+		goto out;
+	}
+	/*
+	 * Per RDMA verbs definition, an STag may already be in invalid
+	 * state if invalidation is requested. So no state check here.
+	 */
+	mem->stag_valid = 0;
+
+	siw_dbg_pd(pd, "STag 0x%08x now invalid\n", stag);
+out:
+	siw_mem_put(mem);
+	return rv;
+}
+
+/*
+ * Gets physical address backed by PBL element. Address is referenced
+ * by linear byte offset into list of variably sized PB elements.
+ * Optionally, provides remaining len within current element, and
+ * current PBL index for later resume at same element.
+ */
+u64 siw_pbl_get_buffer(struct siw_pbl *pbl, u64 off, int *len, int *idx)
+{
+	int i = idx ? *idx : 0;
+
+	while (i < pbl->num_buf) {
+		struct siw_pble *pble = &pbl->pbe[i];
+
+		if (pble->pbl_off + pble->size > off) {
+			u64 pble_off = off - pble->pbl_off;
+
+			if (len)
+				*len = pble->size - pble_off;
+			if (idx)
+				*idx = i;
+
+			return pble->addr + pble_off;
+		}
+		i++;
+	}
+	if (len)
+		*len = 0;
+	return 0;
+}
+
+struct siw_pbl *siw_pbl_alloc(u32 num_buf)
+{
+	struct siw_pbl *pbl;
+	int buf_size = sizeof(*pbl);
+
+	if (num_buf == 0)
+		return ERR_PTR(-EINVAL);
+
+	buf_size += ((num_buf - 1) * sizeof(struct siw_pble));
+
+	pbl = kzalloc(buf_size, GFP_KERNEL);
+	if (!pbl)
+		return ERR_PTR(-ENOMEM);
+
+	pbl->max_buf = num_buf;
+
+	return pbl;
+}
+
+struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
+{
+	struct siw_umem *umem;
+	struct mm_struct *mm_s;
+	u64 first_page_va;
+	unsigned long mlock_limit;
+	unsigned int foll_flags = FOLL_WRITE;
+	int num_pages, num_chunks, i, rv = 0;
+
+	if (!can_do_mlock())
+		return ERR_PTR(-EPERM);
+
+	if (!len)
+		return ERR_PTR(-EINVAL);
+
+	first_page_va = start & PAGE_MASK;
+	num_pages = PAGE_ALIGN(start + len - first_page_va) >> PAGE_SHIFT;
+	num_chunks = (num_pages >> CHUNK_SHIFT) + 1;
+
+	umem = kzalloc(sizeof(*umem), GFP_KERNEL);
+	if (!umem)
+		return ERR_PTR(-ENOMEM);
+
+	mm_s = current->mm;
+	umem->owning_mm = mm_s;
+	umem->writable = writable;
+
+	mmgrab(mm_s);
+
+	if (!writable)
+		foll_flags |= FOLL_FORCE;
+
+	down_read(&mm_s->mmap_sem);
+
+	mlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+
+	if (num_pages + atomic64_read(&mm_s->pinned_vm) > mlock_limit) {
+		rv = -ENOMEM;
+		goto out_sem_up;
+	}
+	umem->fp_addr = first_page_va;
+
+	umem->page_chunk =
+		kcalloc(num_chunks, sizeof(struct siw_page_chunk), GFP_KERNEL);
+	if (!umem->page_chunk) {
+		rv = -ENOMEM;
+		goto out_sem_up;
+	}
+	for (i = 0; num_pages; i++) {
+		int got, nents = min_t(int, num_pages, PAGES_PER_CHUNK);
+
+		umem->page_chunk[i].plist =
+			kcalloc(nents, sizeof(struct page *), GFP_KERNEL);
+		if (!umem->page_chunk[i].plist) {
+			rv = -ENOMEM;
+			goto out_sem_up;
+		}
+		got = 0;
+		while (nents) {
+			struct page **plist = &umem->page_chunk[i].plist[got];
+
+			rv = get_user_pages(first_page_va, nents,
+					    foll_flags | FOLL_LONGTERM,
+					    plist, NULL);
+			if (rv < 0)
+				goto out_sem_up;
+
+			umem->num_pages += rv;
+			atomic64_add(rv, &mm_s->pinned_vm);
+			first_page_va += rv * PAGE_SIZE;
+			nents -= rv;
+			got += rv;
+		}
+		num_pages -= got;
+	}
+out_sem_up:
+	up_read(&mm_s->mmap_sem);
+
+	if (rv > 0)
+		return umem;
+
+	siw_umem_release(umem, false);
+
+	return ERR_PTR(rv);
+}
diff --git a/drivers/infiniband/sw/siw/siw_mem.h b/drivers/infiniband/sw/siw/siw_mem.h
new file mode 100644
index 000000000000..f43daf280891
--- /dev/null
+++ b/drivers/infiniband/sw/siw/siw_mem.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+
+/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
+/* Copyright (c) 2008-2019, IBM Corporation */
+
+#ifndef _SIW_MEM_H
+#define _SIW_MEM_H
+
+struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable);
+void siw_umem_release(struct siw_umem *umem, bool dirty);
+struct siw_pbl *siw_pbl_alloc(u32 num_buf);
+u64 siw_pbl_get_buffer(struct siw_pbl *pbl, u64 off, int *len, int *idx);
+struct siw_mem *siw_mem_id2obj(struct siw_device *sdev, int stag_index);
+int siw_mem_add(struct siw_device *sdev, struct siw_mem *m);
+int siw_invalidate_stag(struct ib_pd *pd, u32 stag);
+int siw_check_mem(struct ib_pd *pd, struct siw_mem *mem, u64 addr,
+		  enum ib_access_flags perms, int len);
+int siw_check_sge(struct ib_pd *pd, struct siw_sge *sge,
+		  struct siw_mem *mem[], enum ib_access_flags perms,
+		  u32 off, int len);
+void siw_wqe_put_mem(struct siw_wqe *wqe, enum siw_opcode op);
+int siw_mr_add_mem(struct siw_mr *mr, struct ib_pd *pd, void *mem_obj,
+		   u64 start, u64 len, int rights);
+void siw_mr_drop_mem(struct siw_mr *mr);
+void siw_free_mem(struct kref *ref);
+
+static inline void siw_mem_put(struct siw_mem *mem)
+{
+	kref_put(&mem->ref, siw_free_mem);
+}
+
+static inline struct siw_mr *siw_mem2mr(struct siw_mem *m)
+{
+	return container_of(m, struct siw_mr, mem);
+}
+
+static inline void siw_unref_mem_sgl(struct siw_mem **mem, unsigned int num_sge)
+{
+	while (num_sge) {
+		if (*mem == NULL)
+			break;
+
+		siw_mem_put(*mem);
+		*mem = NULL;
+		mem++;
+		num_sge--;
+	}
+}
+
+#define CHUNK_SHIFT 9 /* sets number of pages per chunk */
+#define PAGES_PER_CHUNK (_AC(1, UL) << CHUNK_SHIFT)
+#define CHUNK_MASK (~(PAGES_PER_CHUNK - 1))
+#define PAGE_CHUNK_SIZE (PAGES_PER_CHUNK * sizeof(struct page *))
+
+/*
+ * siw_get_upage()
+ *
+ * Get page pointer for address on given umem.
+ *
+ * @umem: two dimensional list of page pointers
+ * @addr: user virtual address
+ */
+static inline struct page *siw_get_upage(struct siw_umem *umem, u64 addr)
+{
+	unsigned int page_idx = (addr - umem->fp_addr) >> PAGE_SHIFT,
+		     chunk_idx = page_idx >> CHUNK_SHIFT,
+		     page_in_chunk = page_idx & ~CHUNK_MASK;
+
+	if (likely(page_idx < umem->num_pages))
+		return umem->page_chunk[chunk_idx].plist[page_in_chunk];
+
+	return NULL;
+}
+#endif
-- 
2.17.2

