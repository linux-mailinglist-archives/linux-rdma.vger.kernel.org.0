Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824C57CFDCD
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 17:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346191AbjJSP0a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 11:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345938AbjJSP03 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 11:26:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C1130
        for <linux-rdma@vger.kernel.org>; Thu, 19 Oct 2023 08:26:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CBEC433C8;
        Thu, 19 Oct 2023 15:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697729186;
        bh=h84l5x3ycK6LsY4vt1Jwfqds4V6VmRnYajmPxsipX0g=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=lISaPF2Bfw7noke+jKyafEMdYxClUp41lhCIB4QjSn0xkrVAyLCnND9478zuibbFC
         AwP/jnlgxz88zfdILf8m0AqYc7jW1xaT8aUoGKOuZmn/Yc0IoNYBGcKD+jqHVFC0Yf
         zSi3MxP5+Zc8nb3o2SC3CRrsMNF0ci/l2Uw22rMAPG6yPekE+Qp+wAvoS3Vkm/y3+B
         nFOeA/L5vhZa3dEn9pqLgqXPkGqQ6+JJ0GR8dxyJUFkhZJHHMU0ZRr6iv8O6CK4vpz
         J1me8rMaM9gp7Y6zkFQ9ceowLSubnfB67X8I45rxPAb1YJQo69FYZhqYNZ0WGj7qPK
         2kBMuXgoH4BIg==
Subject: [PATCH RFC 8/9] iommu/dma: Support DMA-mapping a bio_vec array
From:   Chuck Lever <cel@kernel.org>
Cc:     iommu@lists.linux.dev, linux-rdma@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 19 Oct 2023 11:26:24 -0400
Message-ID: <169772918473.5232.6022085226786774578.stgit@klimt.1015granger.net>
In-Reply-To: <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net>
References: <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Cc: iommu@lists.linux.dev
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/iommu/dma-iommu.c |  368 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c     |   58 +++++++
 include/linux/iommu.h     |    4 
 3 files changed, 430 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4b1a88f514c9..5ed15eac9a4a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -554,6 +554,34 @@ static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 	return false;
 }
 
+static bool dev_use_bvecs_swiotlb(struct device *dev, struct bio_vec *bvecs,
+				  int nents, enum dma_data_direction dir)
+{
+	struct bio_vec *bv;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_SWIOTLB))
+		return false;
+
+	if (dev_is_untrusted(dev))
+		return true;
+
+	/*
+	 * If kmalloc() buffers are not DMA-safe for this device and
+	 * direction, check the individual lengths in the sg list. If any
+	 * element is deemed unsafe, use the swiotlb for bouncing.
+	 */
+	if (!dma_kmalloc_safe(dev, dir)) {
+		for (i = 0; i < nents; i++) {
+			bv = &bvecs[i];
+			if (!dma_kmalloc_size_aligned(bv->bv_len))
+				return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -1026,6 +1054,49 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
 }
 
+static void iommu_dma_sync_bvecs_for_cpu(struct device *dev,
+		struct bio_vec *bvecs, int nelems,
+		enum dma_data_direction dir)
+{
+	struct bio_vec *bv;
+	int i;
+
+	if (bv_dma_is_swiotlb(bvecs)) {
+		for (i = 0; i < nelems; i++) {
+			bv = &bvecs[i];
+			iommu_dma_sync_single_for_cpu(dev, bv_dma_address(bv),
+						      bv->bv_len, dir);
+		}
+	} else if (!dev_is_dma_coherent(dev)) {
+		for (i = 0; i < nelems; i++) {
+			bv = &bvecs[i];
+			arch_sync_dma_for_cpu(bv_phys(bv), bv->bv_len, dir);
+		}
+	}
+}
+
+static void iommu_dma_sync_bvecs_for_device(struct device *dev,
+		struct bio_vec *bvecs, int nelems,
+		enum dma_data_direction dir)
+{
+	struct bio_vec *bv;
+	int i;
+
+	if (bv_dma_is_swiotlb(bvecs)) {
+		for (i = 0; i < nelems; i++) {
+			bv = &bvecs[i];
+			iommu_dma_sync_single_for_device(dev,
+							 bv_dma_address(bv),
+							 bv->bv_len, dir);
+		}
+	} else if (!dev_is_dma_coherent(dev)) {
+		for (i = 0; i < nelems; i++) {
+			bv = &bvecs[i];
+			arch_sync_dma_for_device(bv_phys(bv), bv->bv_len, dir);
+		}
+	}
+}
+
 static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
@@ -1405,6 +1476,299 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		__iommu_dma_unmap(dev, start, end - start);
 }
 
+/*
+ * Prepare a successfully-mapped bio_vec array to give back to the caller.
+ *
+ * At this point the elements are already laid out by iommu_dma_map_bvecs()
+ * to avoid individually crossing any boundaries, so we merely need to check
+ * an element's start address to avoid concatenating across one.
+ */
+static int __finalise_bvecs(struct device *dev, struct bio_vec *bvecs,
+		int nents, dma_addr_t dma_addr)
+{
+	unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
+	unsigned long seg_mask = dma_get_seg_boundary(dev);
+	struct bio_vec *cur = bvecs;
+	int i, count = 0;
+
+	for (i = 0; i < nents; i++) {
+		struct bio_vec *bv = &bvecs[i];
+
+		/* Restore this segment's original unaligned fields first */
+		dma_addr_t s_dma_addr = bv_dma_address(bv);
+		unsigned int s_iova_off = bv_dma_address(bv);
+		unsigned int s_length = bv_dma_len(bv);
+		unsigned int s_iova_len = bv->bv_len;
+
+		bv_dma_address(bv) = DMA_MAPPING_ERROR;
+		bv_dma_len(bv) = 0;
+
+		if (bv_dma_is_bus_address(bv)) {
+			if (i > 0)
+				cur++;
+
+			bv_dma_unmark_bus_address(bv);
+			bv_dma_address(cur) = s_dma_addr;
+			bv_dma_len(cur) = s_length;
+			bv_dma_mark_bus_address(cur);
+			count++;
+			cur_len = 0;
+			continue;
+		}
+
+		bv->bv_offset += s_iova_off;
+		bv->bv_len = s_length;
+
+		/*
+		 * Now fill in the real DMA data. If...
+		 * - there is a valid output segment to append to
+		 * - and this segment starts on an IOVA page boundary
+		 * - but doesn't fall at a segment boundary
+		 * - and wouldn't make the resulting output segment too long
+		 */
+		if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
+		    (max_len - cur_len >= s_length)) {
+			/* ...then concatenate it with the previous one */
+			cur_len += s_length;
+		} else {
+			/* Otherwise start the next output segment */
+			if (i > 0)
+				cur++;
+			cur_len = s_length;
+			count++;
+
+			bv_dma_address(cur) = dma_addr + s_iova_off;
+		}
+
+		bv_dma_len(cur) = cur_len;
+		dma_addr += s_iova_len;
+
+		if (s_length + s_iova_off < s_iova_len)
+			cur_len = 0;
+	}
+	return count;
+}
+
+/*
+ * If mapping failed, then just restore the original list,
+ * but making sure the DMA fields are invalidated.
+ */
+static void __invalidate_bvecs(struct bio_vec *bvecs, int nents)
+{
+	struct bio_vec *bv;
+	int i;
+
+	for (i = 0; i < nents; i++) {
+		bv = &bvecs[i];
+		if (bv_dma_is_bus_address(bv)) {
+			bv_dma_unmark_bus_address(bv);
+		} else {
+			if (bv_dma_address(bv) != DMA_MAPPING_ERROR)
+				bv->bv_offset += bv_dma_address(bv);
+			if (bv_dma_len(bv))
+				bv->bv_len = bv_dma_len(bv);
+		}
+		bv_dma_address(bv) = DMA_MAPPING_ERROR;
+		bv_dma_len(bv) = 0;
+	}
+}
+
+static void iommu_dma_unmap_bvecs_swiotlb(struct device *dev,
+		struct bio_vec *bvecs, int nents, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	struct bio_vec *bv;
+	int i;
+
+	for (i = 0; i < nents; i++) {
+		bv = &bvecs[i];
+		iommu_dma_unmap_page(dev, bv_dma_address(bv),
+				     bv_dma_len(bv), dir, attrs);
+	}
+}
+
+static int iommu_dma_map_bvecs_swiotlb(struct device *dev, struct bio_vec *bvecs,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	struct bio_vec *bv;
+	int i;
+
+	bv_dma_mark_swiotlb(bvecs);
+
+	for (i = 0; i < nents; i++) {
+		bv = &bvecs[i];
+		bv_dma_address(bv) = iommu_dma_map_page(dev, bv->bv_page,
+				bv->bv_offset, bv->bv_len, dir, attrs);
+		if (bv_dma_address(bv) == DMA_MAPPING_ERROR)
+			goto out_unmap;
+		bv_dma_len(bv) = bv->bv_len;
+	}
+
+	return nents;
+
+out_unmap:
+	iommu_dma_unmap_bvecs_swiotlb(dev, bvecs, i, dir,
+				      attrs | DMA_ATTR_SKIP_CPU_SYNC);
+	return -EIO;
+}
+
+/*
+ * The DMA API client is passing in an array of bio_vecs which could
+ * describe any old buffer layout, but the IOMMU API requires everything
+ * to be aligned to IOMMU pages. Hence the need for this complicated bit
+ * of impedance-matching, to be able to hand off a suitably-aligned list,
+ * but still preserve the original offsets and sizes for the caller.
+ */
+static int iommu_dma_map_bvecs(struct device *dev, struct bio_vec *bvecs,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	unsigned long mask = dma_get_seg_boundary(dev);
+	struct iova_domain *iovad = &cookie->iovad;
+	size_t iova_len = 0;
+	dma_addr_t iova;
+	ssize_t ret;
+	int i;
+
+	if (static_branch_unlikely(&iommu_deferred_attach_enabled)) {
+		ret = iommu_deferred_attach(dev, domain);
+		if (ret)
+			goto out;
+	}
+
+	if (dev_use_bvecs_swiotlb(dev, bvecs, nents, dir))
+		return iommu_dma_map_bvecs_swiotlb(dev, bvecs, nents,
+						   dir, attrs);
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		iommu_dma_sync_bvecs_for_device(dev, bvecs, nents, dir);
+
+	/*
+	 * Work out how much IOVA space we need, and align the segments to
+	 * IOVA granules for the IOMMU driver to handle. With some clever
+	 * trickery we can modify the list in-place, but reversibly, by
+	 * stashing the unaligned parts in the as-yet-unused DMA fields.
+	 */
+	for (i = 0; i < nents; i++) {
+		struct bio_vec *bv = &bvecs[i];
+		size_t s_iova_off = iova_offset(iovad, bv->bv_offset);
+		size_t pad_len = (mask - iova_len + 1) & mask;
+		size_t s_length = bv->bv_len;
+		struct bio_vec *prev = NULL;
+
+		bv_dma_address(bv) = s_iova_off;
+		bv_dma_len(bv) = s_length;
+		bv->bv_offset -= s_iova_off;
+		s_length = iova_align(iovad, s_length + s_iova_off);
+		bv->bv_len = s_length;
+
+		/*
+		 * Due to the alignment of our single IOVA allocation, we can
+		 * depend on these assumptions about the segment boundary mask:
+		 * - If mask size >= IOVA size, then the IOVA range cannot
+		 *   possibly fall across a boundary, so we don't care.
+		 * - If mask size < IOVA size, then the IOVA range must start
+		 *   exactly on a boundary, therefore we can lay things out
+		 *   based purely on segment lengths without needing to know
+		 *   the actual addresses beforehand.
+		 * - The mask must be a power of 2, so pad_len == 0 if
+		 *   iova_len == 0, thus we cannot dereference prev the first
+		 *   time through here (i.e. before it has a meaningful value).
+		 */
+		if (pad_len && pad_len < s_length - 1) {
+			prev->bv_len += pad_len;
+			iova_len += pad_len;
+		}
+
+		iova_len += s_length;
+		prev = bv;
+	}
+
+	if (!iova_len)
+		return __finalise_bvecs(dev, bvecs, nents, 0);
+
+	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
+	if (!iova) {
+		ret = -ENOMEM;
+		goto out_restore_sg;
+	}
+
+	/*
+	 * We'll leave any physical concatenation to the IOMMU driver's
+	 * implementation - it knows better than we do.
+	 */
+	ret = iommu_map_bvecs(domain, iova, bvecs, nents, prot, GFP_ATOMIC);
+	if (ret < 0 || ret < iova_len)
+		goto out_free_iova;
+
+	return __finalise_bvecs(dev, bvecs, nents, iova);
+
+out_free_iova:
+	iommu_dma_free_iova(cookie, iova, iova_len, NULL);
+out_restore_sg:
+	__invalidate_bvecs(bvecs, nents);
+out:
+	if (ret != -ENOMEM && ret != -EREMOTEIO)
+		return -EINVAL;
+	return ret;
+}
+
+static void iommu_dma_unmap_bvecs(struct device *dev, struct bio_vec *bvecs,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	dma_addr_t end = 0, start;
+	struct bio_vec *bv;
+	int i;
+
+	if (bv_dma_is_swiotlb(bvecs)) {
+		iommu_dma_unmap_bvecs_swiotlb(dev, bvecs, nents, dir, attrs);
+		return;
+	}
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		iommu_dma_sync_bvecs_for_cpu(dev, bvecs, nents, dir);
+
+	/*
+	 * The bio_vec array elements are mapped into a single
+	 * contiguous IOVA allocation, the start and end points
+	 * just have to be determined.
+	 */
+	for (i = 0; i < nents; i++) {
+		bv = &bvecs[i];
+
+		if (bv_dma_is_bus_address(bv)) {
+			bv_dma_unmark_bus_address(bv);
+			continue;
+		}
+
+		if (bv_dma_len(bv) == 0)
+			break;
+
+		start = bv_dma_address(bv);
+		break;
+	}
+
+	nents -= i;
+	for (i = 0; i < nents; i++) {
+		bv = &bvecs[i];
+
+		if (bv_dma_is_bus_address(bv)) {
+			bv_dma_unmark_bus_address(bv);
+			continue;
+		}
+
+		if (bv_dma_len(bv) == 0)
+			break;
+
+		end = bv_dma_address(bv) + bv_dma_len(bv);
+	}
+
+	if (end)
+		__iommu_dma_unmap(dev, start, end - start);
+}
+
 static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
@@ -1613,10 +1977,14 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.unmap_page		= iommu_dma_unmap_page,
 	.map_sg			= iommu_dma_map_sg,
 	.unmap_sg		= iommu_dma_unmap_sg,
+	.map_bvecs		= iommu_dma_map_bvecs,
+	.unmap_bvecs		= iommu_dma_unmap_bvecs,
 	.sync_single_for_cpu	= iommu_dma_sync_single_for_cpu,
 	.sync_single_for_device	= iommu_dma_sync_single_for_device,
 	.sync_sg_for_cpu	= iommu_dma_sync_sg_for_cpu,
 	.sync_sg_for_device	= iommu_dma_sync_sg_for_device,
+	.sync_bvecs_for_cpu	= iommu_dma_sync_bvecs_for_cpu,
+	.sync_bvecs_for_device	= iommu_dma_sync_bvecs_for_device,
 	.map_resource		= iommu_dma_map_resource,
 	.unmap_resource		= iommu_dma_unmap_resource,
 	.get_merge_boundary	= iommu_dma_get_merge_boundary,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3bfc56df4f78..a117917bf9d0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2669,6 +2669,64 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 }
 EXPORT_SYMBOL_GPL(iommu_map_sg);
 
+ssize_t iommu_map_bvecs(struct iommu_domain *domain, unsigned long iova,
+			struct bio_vec *bv, unsigned int nents, int prot,
+			 gfp_t gfp)
+{
+	const struct iommu_domain_ops *ops = domain->ops;
+	size_t len = 0, mapped = 0;
+	unsigned int i = 0;
+	phys_addr_t start;
+	int ret;
+
+	might_sleep_if(gfpflags_allow_blocking(gfp));
+
+	/* Discourage passing strange GFP flags */
+	if (WARN_ON_ONCE(gfp & (__GFP_COMP | __GFP_DMA | __GFP_DMA32 |
+				__GFP_HIGHMEM)))
+		return -EINVAL;
+
+	while (i <= nents) {
+		phys_addr_t b_phys = bv_phys(bv);
+
+		if (len && b_phys != start + len) {
+			ret = __iommu_map(domain, iova + mapped, start,
+					len, prot, gfp);
+
+			if (ret)
+				goto out_err;
+
+			mapped += len;
+			len = 0;
+		}
+
+		if (bv_dma_is_bus_address(bv))
+			goto next;
+
+		if (len) {
+			len += bv->bv_len;
+		} else {
+			len = bv->bv_len;
+			start = b_phys;
+		}
+
+next:
+		if (++i < nents)
+			bv++;
+	}
+
+	if (ops->iotlb_sync_map)
+		ops->iotlb_sync_map(domain, iova, mapped);
+	return mapped;
+
+out_err:
+	/* undo mappings already done */
+	iommu_unmap(domain, iova, mapped);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_map_bvecs);
+
 /**
  * report_iommu_fault() - report about an IOMMU fault to the IOMMU framework
  * @domain: the iommu domain where the fault has happened
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c50a769d569a..9f7120314fda 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -8,6 +8,7 @@
 #define __LINUX_IOMMU_H
 
 #include <linux/scatterlist.h>
+#include <linux/bvec.h>
 #include <linux/device.h>
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -485,6 +486,9 @@ extern size_t iommu_unmap_fast(struct iommu_domain *domain,
 extern ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			    struct scatterlist *sg, unsigned int nents,
 			    int prot, gfp_t gfp);
+extern ssize_t iommu_map_bvecs(struct iommu_domain *domain, unsigned long iova,
+			       struct bio_vec *bvecs, unsigned int nents,
+			       int prot, gfp_t gfp);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);


