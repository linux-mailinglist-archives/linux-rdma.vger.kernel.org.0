Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D721769BA
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2020 02:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgCCBAd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 20:00:33 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11858 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCCBAc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 20:00:32 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5dac220000>; Mon, 02 Mar 2020 17:00:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 02 Mar 2020 17:00:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 02 Mar 2020 17:00:31 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Mar
 2020 01:00:30 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 3 Mar 2020 01:00:30 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e5dac2d001f>; Mon, 02 Mar 2020 17:00:29 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <nouveau@lists.freedesktop.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v2] nouveau/hmm: map pages after migration
Date:   Mon, 2 Mar 2020 17:00:23 -0800
Message-ID: <20200303010023.2983-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583197218; bh=VM/GObbgHQMpS+HiC4HrNLp5DB1tYqNPFUeLAghZ4TE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=bmAF3JWZrjJw+REMWKCRILuRkCfGsGeAHORL/SiS4W8k3LK4FJEPqHkUvKbsTuarQ
         J5cTpBVw4fAcoi3sAHehaQUbLGVOOr0d/PdP9LFE/8JCHw+U4gdYyEKzE0cNyqqu6e
         irbKhY+GsJqgGv6l+U0tOYIg9AbnPeGXJpSxMQXytATjPTvataSBsFl7jSKh72VLyL
         j0QM2CBaEPyNLVtMo1QccpxSwvQipx5Nb2E4nRHReREXhgy/XsPFzBQ2Q/9wNuZirC
         LYWcOG8089kbDtjG7mdLdEd+9ck0QpFlovQKGxktrZRDDnaypi/N4OfaFUa+ETUaTh
         gV2wTNRHHXzqA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When memory is migrated to the GPU, it is likely to be accessed by GPU
code soon afterwards. Instead of waiting for a GPU fault, map the
migrated memory into the GPU page tables with the same access permissions
as the source CPU page table entries. This preserves copy on write
semantics.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
---

Originally this patch was targeted for Jason's rdma tree since other HMM
related changes were queued there. Now that those have been merged, this
patch just contains changes to nouveau so it could go through any tree.
I guess Ben Skeggs' tree would be appropriate.

Changes since v1:
 Rebase to linux-5.6.0-rc4
 Address Christoph Hellwig's comments

 drivers/gpu/drm/nouveau/nouveau_dmem.c | 44 ++++++++-----
 drivers/gpu/drm/nouveau/nouveau_svm.c  | 85 ++++++++++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_svm.h  |  5 ++
 3 files changed, 118 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouve=
au/nouveau_dmem.c
index 0ad5d87b5a8e..172e0c98cec5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -25,11 +25,13 @@
 #include "nouveau_dma.h"
 #include "nouveau_mem.h"
 #include "nouveau_bo.h"
+#include "nouveau_svm.h"
=20
 #include <nvif/class.h>
 #include <nvif/object.h>
 #include <nvif/if500b.h>
 #include <nvif/if900b.h>
+#include <nvif/if000c.h>
=20
 #include <linux/sched/mm.h>
 #include <linux/hmm.h>
@@ -558,10 +560,11 @@ nouveau_dmem_init(struct nouveau_drm *drm)
 }
=20
 static unsigned long nouveau_dmem_migrate_copy_one(struct nouveau_drm *drm=
,
-		unsigned long src, dma_addr_t *dma_addr)
+		unsigned long src, dma_addr_t *dma_addr, u64 *pfn)
 {
 	struct device *dev =3D drm->dev->dev;
 	struct page *dpage, *spage;
+	unsigned long paddr;
=20
 	spage =3D migrate_pfn_to_page(src);
 	if (!spage || !(src & MIGRATE_PFN_MIGRATE))
@@ -569,17 +572,21 @@ static unsigned long nouveau_dmem_migrate_copy_one(st=
ruct nouveau_drm *drm,
=20
 	dpage =3D nouveau_dmem_page_alloc_locked(drm);
 	if (!dpage)
-		return 0;
+		goto out;
=20
 	*dma_addr =3D dma_map_page(dev, spage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
 	if (dma_mapping_error(dev, *dma_addr))
 		goto out_free_page;
=20
+	paddr =3D nouveau_dmem_page_addr(dpage);
 	if (drm->dmem->migrate.copy_func(drm, 1, NOUVEAU_APER_VRAM,
-			nouveau_dmem_page_addr(dpage), NOUVEAU_APER_HOST,
-			*dma_addr))
+			paddr, NOUVEAU_APER_HOST, *dma_addr))
 		goto out_dma_unmap;
=20
+	*pfn =3D NVIF_VMM_PFNMAP_V0_V | NVIF_VMM_PFNMAP_V0_VRAM |
+		((paddr >> PAGE_SHIFT) << NVIF_VMM_PFNMAP_V0_ADDR_SHIFT);
+	if (src & MIGRATE_PFN_WRITE)
+		*pfn |=3D NVIF_VMM_PFNMAP_V0_W;
 	return migrate_pfn(page_to_pfn(dpage)) | MIGRATE_PFN_LOCKED;
=20
 out_dma_unmap:
@@ -587,18 +594,19 @@ static unsigned long nouveau_dmem_migrate_copy_one(st=
ruct nouveau_drm *drm,
 out_free_page:
 	nouveau_dmem_page_free_locked(drm, dpage);
 out:
+	*pfn =3D NVIF_VMM_PFNMAP_V0_NONE;
 	return 0;
 }
=20
 static void nouveau_dmem_migrate_chunk(struct nouveau_drm *drm,
-		struct migrate_vma *args, dma_addr_t *dma_addrs)
+		struct migrate_vma *args, dma_addr_t *dma_addrs, u64 *pfns)
 {
 	struct nouveau_fence *fence;
 	unsigned long addr =3D args->start, nr_dma =3D 0, i;
=20
 	for (i =3D 0; addr < args->end; i++) {
 		args->dst[i] =3D nouveau_dmem_migrate_copy_one(drm, args->src[i],
-				dma_addrs + nr_dma);
+				dma_addrs + nr_dma, pfns + i);
 		if (args->dst[i])
 			nr_dma++;
 		addr +=3D PAGE_SIZE;
@@ -607,15 +615,12 @@ static void nouveau_dmem_migrate_chunk(struct nouveau=
_drm *drm,
 	nouveau_fence_new(drm->dmem->migrate.chan, false, &fence);
 	migrate_vma_pages(args);
 	nouveau_dmem_fence_done(&fence);
+	nouveau_pfns_map(drm, args->vma->vm_mm, args->start, pfns, i);
=20
 	while (nr_dma--) {
 		dma_unmap_page(drm->dev->dev, dma_addrs[nr_dma], PAGE_SIZE,
 				DMA_BIDIRECTIONAL);
 	}
-	/*
-	 * FIXME optimization: update GPU page table to point to newly migrated
-	 * memory.
-	 */
 	migrate_vma_finalize(args);
 }
=20
@@ -632,7 +637,8 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
 		.vma		=3D vma,
 		.start		=3D start,
 	};
-	unsigned long c, i;
+	unsigned long i;
+	u64 *pfns;
 	int ret =3D -ENOMEM;
=20
 	args.src =3D kcalloc(max, sizeof(*args.src), GFP_KERNEL);
@@ -646,19 +652,25 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
 	if (!dma_addrs)
 		goto out_free_dst;
=20
-	for (i =3D 0; i < npages; i +=3D c) {
-		c =3D min(SG_MAX_SINGLE_ALLOC, npages);
-		args.end =3D start + (c << PAGE_SHIFT);
+	pfns =3D nouveau_pfns_alloc(max);
+	if (!pfns)
+		goto out_free_dma;
+
+	for (i =3D 0; i < npages; i +=3D max) {
+		args.end =3D start + (max << PAGE_SHIFT);
 		ret =3D migrate_vma_setup(&args);
 		if (ret)
-			goto out_free_dma;
+			goto out_free_pfns;
=20
 		if (args.cpages)
-			nouveau_dmem_migrate_chunk(drm, &args, dma_addrs);
+			nouveau_dmem_migrate_chunk(drm, &args, dma_addrs,
+						   pfns);
 		args.start =3D args.end;
 	}
=20
 	ret =3D 0;
+out_free_pfns:
+	nouveau_pfns_free(pfns);
 out_free_dma:
 	kfree(dma_addrs);
 out_free_dst:
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index df9bf1fd1bc0..8c629918a3c6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -70,6 +70,12 @@ struct nouveau_svm {
 #define SVM_DBG(s,f,a...) NV_DEBUG((s)->drm, "svm: "f"\n", ##a)
 #define SVM_ERR(s,f,a...) NV_WARN((s)->drm, "svm: "f"\n", ##a)
=20
+struct nouveau_pfnmap_args {
+	struct nvif_ioctl_v0 i;
+	struct nvif_ioctl_mthd_v0 m;
+	struct nvif_vmm_pfnmap_v0 p;
+};
+
 struct nouveau_ivmm {
 	struct nouveau_svmm *svmm;
 	u64 inst;
@@ -782,6 +788,85 @@ nouveau_svm_fault(struct nvif_notify *notify)
 	return NVIF_NOTIFY_KEEP;
 }
=20
+static inline struct nouveau_pfnmap_args *
+nouveau_pfns_to_args(void *pfns)
+{
+	struct nvif_vmm_pfnmap_v0 *p =3D
+		container_of(pfns, struct nvif_vmm_pfnmap_v0, phys);
+
+	return container_of(p, struct nouveau_pfnmap_args, p);
+}
+
+u64 *
+nouveau_pfns_alloc(unsigned long npages)
+{
+	struct nouveau_pfnmap_args *args;
+
+	args =3D kzalloc(struct_size(args, p.phys, npages), GFP_KERNEL);
+	if (!args)
+		return NULL;
+
+	args->i.type =3D NVIF_IOCTL_V0_MTHD;
+	args->m.method =3D NVIF_VMM_V0_PFNMAP;
+	args->p.page =3D PAGE_SHIFT;
+
+	return args->p.phys;
+}
+
+void
+nouveau_pfns_free(u64 *pfns)
+{
+	struct nouveau_pfnmap_args *args =3D nouveau_pfns_to_args(pfns);
+
+	kfree(args);
+}
+
+static struct nouveau_svmm *
+nouveau_find_svmm(struct nouveau_svm *svm, struct mm_struct *mm)
+{
+	struct nouveau_ivmm *ivmm;
+
+	list_for_each_entry(ivmm, &svm->inst, head) {
+		if (ivmm->svmm->notifier.mm =3D=3D mm)
+			return ivmm->svmm;
+	}
+	return NULL;
+}
+
+void
+nouveau_pfns_map(struct nouveau_drm *drm, struct mm_struct *mm,
+		 unsigned long addr, u64 *pfns, unsigned long npages)
+{
+	struct nouveau_svm *svm =3D drm->svm;
+	struct nouveau_svmm *svmm;
+	struct nouveau_pfnmap_args *args;
+	int ret;
+
+	if (!svm)
+		return;
+
+	mutex_lock(&svm->mutex);
+	svmm =3D nouveau_find_svmm(svm, mm);
+	if (!svmm) {
+		mutex_unlock(&svm->mutex);
+		return;
+	}
+	mutex_unlock(&svm->mutex);
+
+	args =3D nouveau_pfns_to_args(pfns);
+	args->p.addr =3D addr;
+	args->p.size =3D npages << PAGE_SHIFT;
+
+	mutex_lock(&svmm->mutex);
+
+	svmm->vmm->vmm.object.client->super =3D true;
+	ret =3D nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args) +
+				npages * sizeof(args->p.phys[0]), NULL);
+	svmm->vmm->vmm.object.client->super =3D false;
+
+	mutex_unlock(&svmm->mutex);
+}
+
 static void
 nouveau_svm_fault_buffer_fini(struct nouveau_svm *svm, int id)
 {
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.h b/drivers/gpu/drm/nouvea=
u/nouveau_svm.h
index e839d8189461..0649f8d587a8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.h
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.h
@@ -18,6 +18,11 @@ void nouveau_svmm_fini(struct nouveau_svmm **);
 int nouveau_svmm_join(struct nouveau_svmm *, u64 inst);
 void nouveau_svmm_part(struct nouveau_svmm *, u64 inst);
 int nouveau_svmm_bind(struct drm_device *, void *, struct drm_file *);
+
+u64 *nouveau_pfns_alloc(unsigned long npages);
+void nouveau_pfns_free(u64 *pfns);
+void nouveau_pfns_map(struct nouveau_drm *drm, struct mm_struct *mm,
+		      unsigned long addr, u64 *pfns, unsigned long npages);
 #else /* IS_ENABLED(CONFIG_DRM_NOUVEAU_SVM) */
 static inline void nouveau_svm_init(struct nouveau_drm *drm) {}
 static inline void nouveau_svm_fini(struct nouveau_drm *drm) {}
--=20
2.20.1

