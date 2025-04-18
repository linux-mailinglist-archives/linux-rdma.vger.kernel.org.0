Return-Path: <linux-rdma+bounces-9570-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F33CFA932F7
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 08:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9540E16A8CD
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 06:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892D52C1084;
	Fri, 18 Apr 2025 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvA5N323"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1972C108C;
	Fri, 18 Apr 2025 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744958965; cv=none; b=kREl/v3EcjWkU2CchUDRUtXk2s9DCaqrMfN64tTJLtOxpjG1eT0zdTDgLdC4ETiE/wllss1Rx2UvJD/kw3lLaAvxZeg3dcj87SFqbDAFlg970oCWWTCe5Hk5rO3BE/C06gMVIbkrEnlVs7zPpfBa74cGXv6Gey62i6oqCR2fD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744958965; c=relaxed/simple;
	bh=ZmWyRBQtBXYnFAUam9EegNGXTM2dafni+nZlpDbR/pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDBohsSx+TW6GQ8yLR4aUQhC6xz4h0bW7+xeNc5z3j0UbPGW7jjS+ok7vWT96GjwPaD/N211byVo23NtjOuKfYzKMi9qNzi6WD1EWwVxViSIYSY7O8M0xoUuGwdgWW+T7dG6hB4iBu+OKfeAZCupCexsAwK486Xuk+4F04ahw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvA5N323; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB44C4CEEC;
	Fri, 18 Apr 2025 06:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744958964;
	bh=ZmWyRBQtBXYnFAUam9EegNGXTM2dafni+nZlpDbR/pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uvA5N323K7YoaK0z++h/D0NaORjnUqeBhTB4o1AFedYhbau/oE31cLwr+nGg4Ts3I
	 tXt/r86+e2WdJX0YxOswx5yUpYstS/V8XcPyfnheQBnBNrhlHR12b3KE4MN4AZXm2W
	 +vIFmMbr+U3d65F0YzPNWkThmPb4+m9RCOl0wHB42GWwpGXXyhX4DeDGGFpTQP6ZYM
	 k0zTNFF4GDl7acKuWAs80//BoTmdei1mnV/oWESJhAkuCC60tBdUryjqzYLFNdGgQF
	 8KDcNRWHQtL5x22y/7L5imlf+3V4UAnGMkZDZp4ASrxEsQOCRiEbrBcLkeQALfr2j7
	 JWt9r6gVp4+bw==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Cc: Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v8 23/24] nvme-pci: convert to blk_rq_dma_map
Date: Fri, 18 Apr 2025 09:47:53 +0300
Message-ID: <f06a04098cb14e1051bddec8a7bdebe1c384d983.1744825142.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744825142.git.leon@kernel.org>
References: <cover.1744825142.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

Use the blk_rq_dma_map API to DMA map requests instead of
scatterlists.  This also removes the fast path single segment
code as the blk_rq_dma_map naturally inlines single IOVA
segment mappings into the preallocated structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/nvme/host/pci.c | 508 +++++++++++++++++++---------------------
 1 file changed, 240 insertions(+), 268 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5deb492cc18e..8d99a8f871ea 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -7,7 +7,7 @@
 #include <linux/acpi.h>
 #include <linux/async.h>
 #include <linux/blkdev.h>
-#include <linux/blk-mq.h>
+#include <linux/blk-mq-dma.h>
 #include <linux/blk-integrity.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
@@ -26,7 +26,6 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/sed-opal.h>
-#include <linux/pci-p2pdma.h>
 
 #include "trace.h"
 #include "nvme.h"
@@ -144,9 +143,6 @@ struct nvme_dev {
 	bool hmb;
 	struct sg_table *hmb_sgt;
 
-	mempool_t *iod_mempool;
-	mempool_t *iod_meta_mempool;
-
 	/* shadow doorbell buffer support: */
 	__le32 *dbbuf_dbs;
 	dma_addr_t dbbuf_dbs_dma_addr;
@@ -229,11 +225,11 @@ struct nvme_iod {
 	bool aborted;
 	u8 nr_descriptors;	/* # of PRP/SGL descriptors */
 	bool large_descriptors;	/* uses the full page sized descriptor pool */
-	unsigned int dma_len;	/* length of single DMA segment mapping */
-	dma_addr_t first_dma;
+	unsigned int total_len; /* length of the entire transfer */
+	unsigned int total_meta_len; /* length of the entire metadata transfer */
 	dma_addr_t meta_dma;
-	struct sg_table sgt;
-	struct sg_table meta_sgt;
+	struct dma_iova_state dma_state;
+	struct dma_iova_state dma_meta_state;
 	void *meta_list;
 	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
 };
@@ -542,9 +538,14 @@ static void nvme_free_descriptors(struct nvme_dev *dev, struct request *req)
 {
 	const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	dma_addr_t dma_addr = iod->first_dma;
+	dma_addr_t dma_addr;
 	int i;
 
+	if (iod->cmd.common.flags & NVME_CMD_SGL_METABUF)
+		dma_addr = le64_to_cpu(iod->cmd.common.dptr.sgl.addr);
+	else
+		dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp2);
+
 	if (iod->nr_descriptors == 1) {
 		dma_pool_free(nvme_dma_pool(dev, iod), iod->descriptors[0],
 				dma_addr);
@@ -560,67 +561,133 @@ static void nvme_free_descriptors(struct nvme_dev *dev, struct request *req)
 	}
 }
 
-static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
+static void nvme_free_prps(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	enum dma_data_direction dir = rq_dma_dir(req);
+	int length = iod->total_len;
+	dma_addr_t dma_addr;
+	int i, desc;
+	__le64 *prp_list;
+	u32 dma_len;
 
-	if (iod->dma_len) {
-		dma_unmap_page(dev->dev, iod->first_dma, iod->dma_len,
-			       rq_dma_dir(req));
+	dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp1);
+	dma_len = min_t(u32, length, NVME_CTRL_PAGE_SIZE - (dma_addr & (NVME_CTRL_PAGE_SIZE - 1)));
+	length -= dma_len;
+	if (!length) {
+		dma_unmap_page(dev->dev, dma_addr, dma_len, dir);
 		return;
 	}
 
-	WARN_ON_ONCE(!iod->sgt.nents);
+	if (length <= NVME_CTRL_PAGE_SIZE) {
+		dma_unmap_page(dev->dev, dma_addr, dma_len, dir);
+		dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp2);
+		dma_unmap_page(dev->dev, dma_addr, length, dir);
+		return;
+	}
 
-	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
-	nvme_free_descriptors(dev, req);
-	mempool_free(iod->sgt.sgl, dev->iod_mempool);
+	i = 0;
+	desc = 0;
+	prp_list = iod->descriptors[desc];
+	do {
+		/*
+		 * We are in this mode as IOVA path wasn't taken and DMA length
+		 * is morethan two sectors. In such case, mapping was perfoormed
+		 * per-NVME_CTRL_PAGE_SIZE, so unmap accordingly.
+		 */
+		dma_unmap_page(dev->dev, dma_addr, dma_len, dir);
+		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
+			prp_list = iod->descriptors[++desc];
+			i = 0;
+		}
+
+		dma_addr = le64_to_cpu(prp_list[i++]);
+		dma_len = min(length, NVME_CTRL_PAGE_SIZE);
+		length -= dma_len;
+	} while (length);
 }
 
-static void nvme_print_sgl(struct scatterlist *sgl, int nents)
+
+static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
 {
-	int i;
-	struct scatterlist *sg;
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	dma_addr_t sqe_dma_addr = le64_to_cpu(iod->cmd.common.dptr.sgl.addr);
+	unsigned int sqe_dma_len = le32_to_cpu(iod->cmd.common.dptr.sgl.length);
+	struct nvme_sgl_desc *sg_list = iod->descriptors[0];
+	enum dma_data_direction dir = rq_dma_dir(req);
+
+	if (iod->nr_descriptors) {
+		unsigned int nr_entries = sqe_dma_len / sizeof(*sg_list), i;
+
+		for (i = 0; i < nr_entries; i++)
+			dma_unmap_page(dev->dev, le64_to_cpu(sg_list[i].addr),
+				le32_to_cpu(sg_list[i].length), dir);
+	} else {
+		dma_unmap_page(dev->dev, sqe_dma_addr, sqe_dma_len, dir);
+	}
+}
+
+static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
-	for_each_sg(sgl, sg, nents, i) {
-		dma_addr_t phys = sg_phys(sg);
-		pr_warn("sg[%d] phys_addr:%pad offset:%d length:%d "
-			"dma_address:%pad dma_length:%d\n",
-			i, &phys, sg->offset, sg->length, &sg_dma_address(sg),
-			sg_dma_len(sg));
+	if (!blk_rq_dma_unmap(req, dev->dev, &iod->dma_state, iod->total_len)) {
+		if (iod->cmd.common.flags & NVME_CMD_SGL_METABUF)
+			nvme_free_sgls(dev, req);
+		else
+			nvme_free_prps(dev, req);
 	}
+
+	if (iod->nr_descriptors)
+		nvme_free_descriptors(dev, req);
 }
 
 static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
-		struct request *req, struct nvme_rw_command *cmnd)
+					struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	int length = blk_rq_payload_bytes(req);
-	struct scatterlist *sg = iod->sgt.sgl;
-	int dma_len = sg_dma_len(sg);
-	u64 dma_addr = sg_dma_address(sg);
-	int offset = dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
+	struct nvme_rw_command *cmnd = &iod->cmd.rw;
+	unsigned int length = blk_rq_payload_bytes(req);
+	struct blk_dma_iter iter;
+	dma_addr_t prp1_dma, prp2_dma = 0;
+	unsigned int prp_len, i;
 	__le64 *prp_list;
-	dma_addr_t prp_dma;
-	int i;
 
-	length -= (NVME_CTRL_PAGE_SIZE - offset);
-	if (length <= 0) {
-		iod->first_dma = 0;
+	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
+		return iter.status;
+
+	/*
+	 * PRP1 always points to the start of the DMA transfers.
+	 *
+	 * This is the only PRP (except for the list entries) that could be
+	 * non-aligned.
+	 */
+	prp1_dma = iter.addr;
+	prp_len = min(length, NVME_CTRL_PAGE_SIZE -
+			(iter.addr & (NVME_CTRL_PAGE_SIZE - 1)));
+	iod->total_len += prp_len;
+	iter.addr += prp_len;
+	iter.len -= prp_len;
+	length -= prp_len;
+	if (!length)
 		goto done;
-	}
 
-	dma_len -= (NVME_CTRL_PAGE_SIZE - offset);
-	if (dma_len) {
-		dma_addr += (NVME_CTRL_PAGE_SIZE - offset);
-	} else {
-		sg = sg_next(sg);
-		dma_addr = sg_dma_address(sg);
-		dma_len = sg_dma_len(sg);
+	if (!iter.len) {
+		if (!blk_rq_dma_map_iter_next(req, dev->dev, &iod->dma_state,
+				&iter)) {
+			if (WARN_ON_ONCE(!iter.status))
+				goto bad_sgl;
+			goto done;
+		}
 	}
 
+	/*
+	 * PRP2 is usually a list, but can point to data if all data to be
+	 * transferred fits into PRP1 + PRP2:
+	 */
 	if (length <= NVME_CTRL_PAGE_SIZE) {
-		iod->first_dma = dma_addr;
+		prp2_dma = iter.addr;
+		iod->total_len += length;
 		goto done;
 	}
 
@@ -629,58 +696,83 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 		iod->large_descriptors = true;
 
 	prp_list = dma_pool_alloc(nvme_dma_pool(dev, iod), GFP_ATOMIC,
-			&prp_dma);
-	if (!prp_list)
-		return BLK_STS_RESOURCE;
+			&prp2_dma);
+	if (!prp_list) {
+		iter.status = BLK_STS_RESOURCE;
+		goto done;
+	}
 	iod->descriptors[iod->nr_descriptors++] = prp_list;
-	iod->first_dma = prp_dma;
+
 	i = 0;
 	for (;;) {
+		prp_list[i++] = cpu_to_le64(iter.addr);
+		prp_len = min(length, NVME_CTRL_PAGE_SIZE);
+		if (WARN_ON_ONCE(iter.len < prp_len))
+			goto bad_sgl;
+
+		iod->total_len += prp_len;
+		iter.addr += prp_len;
+		iter.len -= prp_len;
+		length -= prp_len;
+		if (!length)
+			break;
+
+		if (iter.len == 0) {
+			if (!blk_rq_dma_map_iter_next(req, dev->dev,
+					&iod->dma_state, &iter)) {
+				if (WARN_ON_ONCE(!iter.status))
+					goto bad_sgl;
+				goto done;
+			}
+		}
+
+		/*
+		 * If we've filled the entire descriptor, allocate a new that is
+		 * pointed to be the last entry in the previous PRP list.  To
+		 * accommodate for that move the last actual entry to the new
+		 * descriptor.
+		 */
 		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
 			__le64 *old_prp_list = prp_list;
+			dma_addr_t prp_list_dma;
 
 			prp_list = dma_pool_alloc(dev->prp_page_pool,
-					GFP_ATOMIC, &prp_dma);
-			if (!prp_list)
-				goto free_prps;
+					GFP_ATOMIC, &prp_list_dma);
+			if (!prp_list) {
+				iter.status = BLK_STS_RESOURCE;
+				goto done;
+			}
 			iod->descriptors[iod->nr_descriptors++] = prp_list;
+
 			prp_list[0] = old_prp_list[i - 1];
-			old_prp_list[i - 1] = cpu_to_le64(prp_dma);
+			old_prp_list[i - 1] = cpu_to_le64(prp_list_dma);
 			i = 1;
 		}
-		prp_list[i++] = cpu_to_le64(dma_addr);
-		dma_len -= NVME_CTRL_PAGE_SIZE;
-		dma_addr += NVME_CTRL_PAGE_SIZE;
-		length -= NVME_CTRL_PAGE_SIZE;
-		if (length <= 0)
-			break;
-		if (dma_len > 0)
-			continue;
-		if (unlikely(dma_len < 0))
-			goto bad_sgl;
-		sg = sg_next(sg);
-		dma_addr = sg_dma_address(sg);
-		dma_len = sg_dma_len(sg);
 	}
+
 done:
-	cmnd->dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sgt.sgl));
-	cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
-	return BLK_STS_OK;
-free_prps:
-	nvme_free_descriptors(dev, req);
-	return BLK_STS_RESOURCE;
+	/*
+	 * nvme_unmap_data uses the DPT field in the SQE to tear down the
+	 * mapping, so initialize it even for failures.
+	 */
+	cmnd->dptr.prp1 = cpu_to_le64(prp1_dma);
+	cmnd->dptr.prp2 = cpu_to_le64(prp2_dma);
+	if (unlikely(iter.status))
+		nvme_unmap_data(dev, req);
+	return iter.status;
+
 bad_sgl:
-	WARN(DO_ONCE(nvme_print_sgl, iod->sgt.sgl, iod->sgt.nents),
-			"Invalid SGL for payload:%d nents:%d\n",
-			blk_rq_payload_bytes(req), iod->sgt.nents);
+	dev_err_once(dev->dev,
+		"Incorrectly formed request for payload:%d nents:%d\n",
+		blk_rq_payload_bytes(req), blk_rq_nr_phys_segments(req));
 	return BLK_STS_IOERR;
 }
 
 static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
-		struct scatterlist *sg)
+		struct blk_dma_iter *iter)
 {
-	sge->addr = cpu_to_le64(sg_dma_address(sg));
-	sge->length = cpu_to_le32(sg_dma_len(sg));
+	sge->addr = cpu_to_le64(iter->addr);
+	sge->length = cpu_to_le32(iter->len);
 	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
 }
 
@@ -693,20 +785,25 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 }
 
 static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
-		struct request *req, struct nvme_rw_command *cmd)
+					struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_rw_command *cmd = &iod->cmd.rw;
+	unsigned int entries = blk_rq_nr_phys_segments(req);
 	struct nvme_sgl_desc *sg_list;
-	struct scatterlist *sg = iod->sgt.sgl;
-	unsigned int entries = iod->sgt.nents;
+	struct blk_dma_iter iter;
 	dma_addr_t sgl_dma;
-	int i = 0;
+	unsigned int mapped = 0;
 
 	/* setting the transfer type as SGL */
 	cmd->flags = NVME_CMD_SGL_METABUF;
 
-	if (entries == 1) {
-		nvme_pci_sgl_set_data(&cmd->dptr.sgl, sg);
+	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
+		return iter.status;
+
+	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
+		nvme_pci_sgl_set_data(&cmd->dptr.sgl, &iter);
+		iod->total_len += iter.len;
 		return BLK_STS_OK;
 	}
 
@@ -717,168 +814,94 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 	if (!sg_list)
 		return BLK_STS_RESOURCE;
 	iod->descriptors[iod->nr_descriptors++] = sg_list;
-	iod->first_dma = sgl_dma;
 
-	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma, entries);
 	do {
-		nvme_pci_sgl_set_data(&sg_list[i++], sg);
-		sg = sg_next(sg);
-	} while (--entries > 0);
+		if (WARN_ON_ONCE(mapped == entries)) {
+			iter.status = BLK_STS_IOERR;
+			break;
+		}
+		nvme_pci_sgl_set_data(&sg_list[mapped++], &iter);
+		iod->total_len += iter.len;
+	} while (blk_rq_dma_map_iter_next(req, dev->dev, &iod->dma_state,
+				&iter));
 
-	return BLK_STS_OK;
+	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma, mapped);
+	if (unlikely(iter.status))
+		nvme_free_sgls(dev, req);
+	return iter.status;
 }
 
-static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
-		struct request *req, struct nvme_rw_command *cmnd,
-		struct bio_vec *bv)
+static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req)
 {
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	unsigned int offset = bv->bv_offset & (NVME_CTRL_PAGE_SIZE - 1);
-	unsigned int first_prp_len = NVME_CTRL_PAGE_SIZE - offset;
-
-	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
-	if (dma_mapping_error(dev->dev, iod->first_dma))
-		return BLK_STS_RESOURCE;
-	iod->dma_len = bv->bv_len;
-
-	cmnd->dptr.prp1 = cpu_to_le64(iod->first_dma);
-	if (bv->bv_len > first_prp_len)
-		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma + first_prp_len);
-	else
-		cmnd->dptr.prp2 = 0;
-	return BLK_STS_OK;
+	if (nvme_pci_use_sgls(dev, req, blk_rq_nr_phys_segments(req)))
+		return nvme_pci_setup_sgls(dev, req);
+	return nvme_pci_setup_prps(dev, req);
 }
 
-static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
-		struct request *req, struct nvme_rw_command *cmnd,
-		struct bio_vec *bv)
+static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
+						struct request *req)
 {
+	unsigned int entries = req->nr_integrity_segments;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
-	iod->first_dma = dma_map_bvec(dev->dev, bv, rq_dma_dir(req), 0);
-	if (dma_mapping_error(dev->dev, iod->first_dma))
-		return BLK_STS_RESOURCE;
-	iod->dma_len = bv->bv_len;
-
-	cmnd->flags = NVME_CMD_SGL_METABUF;
-	cmnd->dptr.sgl.addr = cpu_to_le64(iod->first_dma);
-	cmnd->dptr.sgl.length = cpu_to_le32(iod->dma_len);
-	cmnd->dptr.sgl.type = NVME_SGL_FMT_DATA_DESC << 4;
-	return BLK_STS_OK;
-}
-
-static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
-		struct nvme_command *cmnd)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	blk_status_t ret = BLK_STS_RESOURCE;
-	int rc;
-
-	if (blk_rq_nr_phys_segments(req) == 1) {
-		struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
-		struct bio_vec bv = req_bvec(req);
-
-		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (!nvme_pci_metadata_use_sgls(dev, req) &&
-			    (bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
-			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
-				return nvme_setup_prp_simple(dev, req,
-							     &cmnd->rw, &bv);
-
-			if (nvmeq->qid && sgl_threshold &&
-			    nvme_ctrl_sgl_supported(&dev->ctrl))
-				return nvme_setup_sgl_simple(dev, req,
-							     &cmnd->rw, &bv);
+	if (!blk_rq_dma_unmap(req, dev->dev, &iod->dma_meta_state,
+			      iod->total_meta_len)) {
+		if (entries == 1) {
+			dma_unmap_page(dev->dev, iod->meta_dma,
+				       rq_integrity_vec(req).bv_len,
+				       rq_dma_dir(req));
+			return;
 		}
 	}
 
-	iod->dma_len = 0;
-	iod->sgt.sgl = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
-	if (!iod->sgt.sgl)
-		return BLK_STS_RESOURCE;
-	sg_init_table(iod->sgt.sgl, blk_rq_nr_phys_segments(req));
-	iod->sgt.orig_nents = blk_rq_map_sg(req, iod->sgt.sgl);
-	if (!iod->sgt.orig_nents)
-		goto out_free_sg;
-
-	rc = dma_map_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req),
-			     DMA_ATTR_NO_WARN);
-	if (rc) {
-		if (rc == -EREMOTEIO)
-			ret = BLK_STS_TARGET;
-		goto out_free_sg;
-	}
-
-	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
-		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw);
-	else
-		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
-	if (ret != BLK_STS_OK)
-		goto out_unmap_sg;
-	return BLK_STS_OK;
-
-out_unmap_sg:
-	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
-out_free_sg:
-	mempool_free(iod->sgt.sgl, dev->iod_mempool);
-	return ret;
+	dma_pool_free(dev->prp_small_pool, iod->meta_list, iod->meta_dma);
 }
 
 static blk_status_t nvme_pci_setup_meta_sgls(struct nvme_dev *dev,
 					     struct request *req)
 {
+	unsigned int entries = req->nr_integrity_segments;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_rw_command *cmnd = &iod->cmd.rw;
+	struct nvme_rw_command *cmd = &iod->cmd.rw;
 	struct nvme_sgl_desc *sg_list;
-	struct scatterlist *sgl, *sg;
-	unsigned int entries;
+	struct blk_dma_iter iter;
+	unsigned int mapped = 0;
 	dma_addr_t sgl_dma;
-	int rc, i;
-
-	iod->meta_sgt.sgl = mempool_alloc(dev->iod_meta_mempool, GFP_ATOMIC);
-	if (!iod->meta_sgt.sgl)
-		return BLK_STS_RESOURCE;
 
-	sg_init_table(iod->meta_sgt.sgl, req->nr_integrity_segments);
-	iod->meta_sgt.orig_nents = blk_rq_map_integrity_sg(req,
-							   iod->meta_sgt.sgl);
-	if (!iod->meta_sgt.orig_nents)
-		goto out_free_sg;
+	cmd->flags = NVME_CMD_SGL_METASEG;
 
-	rc = dma_map_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req),
-			     DMA_ATTR_NO_WARN);
-	if (rc)
-		goto out_free_sg;
+	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_meta_state,
+				       &iter))
+		return iter.status;
 
 	sg_list = dma_pool_alloc(dev->prp_small_pool, GFP_ATOMIC, &sgl_dma);
 	if (!sg_list)
-		goto out_unmap_sg;
+		return BLK_STS_RESOURCE;
 
-	entries = iod->meta_sgt.nents;
 	iod->meta_list = sg_list;
 	iod->meta_dma = sgl_dma;
+	cmd->metadata = cpu_to_le64(sgl_dma);
 
-	cmnd->flags = NVME_CMD_SGL_METASEG;
-	cmnd->metadata = cpu_to_le64(sgl_dma);
-
-	sgl = iod->meta_sgt.sgl;
-	if (entries == 1) {
-		nvme_pci_sgl_set_data(sg_list, sgl);
+	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_meta_state)) {
+		nvme_pci_sgl_set_data(sg_list, &iter);
+		iod->total_meta_len += iter.len;
 		return BLK_STS_OK;
 	}
 
-	sgl_dma += sizeof(*sg_list);
-	nvme_pci_sgl_set_seg(sg_list, sgl_dma, entries);
-	for_each_sg(sgl, sg, entries, i)
-		nvme_pci_sgl_set_data(&sg_list[i + 1], sg);
-
-	return BLK_STS_OK;
+	do {
+		if (WARN_ON_ONCE(mapped == entries)) {
+			iter.status = BLK_STS_IOERR;
+			break;
+		}
+		nvme_pci_sgl_set_data(&sg_list[mapped++], &iter);
+		iod->total_len += iter.len;
+	} while (blk_rq_dma_map_iter_next(req, dev->dev, &iod->dma_meta_state,
+				 &iter));
 
-out_unmap_sg:
-	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
-out_free_sg:
-	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
-	return BLK_STS_RESOURCE;
+	nvme_pci_sgl_set_seg(sg_list, sgl_dma, mapped);
+	if (unlikely(iter.status))
+		nvme_unmap_metadata(dev, req);
+	return iter.status;
 }
 
 static blk_status_t nvme_pci_setup_meta_mptr(struct nvme_dev *dev,
@@ -910,15 +933,15 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	iod->aborted = false;
 	iod->nr_descriptors = 0;
 	iod->large_descriptors = false;
-	iod->sgt.nents = 0;
-	iod->meta_sgt.nents = 0;
+	iod->total_len = 0;
+	iod->total_meta_len = 0;
 
 	ret = nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
 		return ret;
 
 	if (blk_rq_nr_phys_segments(req)) {
-		ret = nvme_map_data(dev, req, &iod->cmd);
+		ret = nvme_map_data(dev, req);
 		if (ret)
 			goto out_free_cmd;
 	}
@@ -1022,23 +1045,6 @@ static void nvme_queue_rqs(struct rq_list *rqlist)
 	*rqlist = requeue_list;
 }
 
-static __always_inline void nvme_unmap_metadata(struct nvme_dev *dev,
-						struct request *req)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-
-	if (!iod->meta_sgt.nents) {
-		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req).bv_len,
-			       rq_dma_dir(req));
-		return;
-	}
-
-	dma_pool_free(dev->prp_small_pool, iod->meta_list, iod->meta_dma);
-	dma_unmap_sgtable(dev->dev, &iod->meta_sgt, rq_dma_dir(req), 0);
-	mempool_free(iod->meta_sgt.sgl, dev->iod_meta_mempool);
-}
-
 static __always_inline void nvme_pci_unmap_rq(struct request *req)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
@@ -2855,31 +2861,6 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
 	dma_pool_destroy(dev->prp_small_pool);
 }
 
-static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
-{
-	size_t meta_size = sizeof(struct scatterlist) * (NVME_MAX_META_SEGS + 1);
-	size_t alloc_size = sizeof(struct scatterlist) * NVME_MAX_SEGS;
-
-	dev->iod_mempool = mempool_create_node(1,
-			mempool_kmalloc, mempool_kfree,
-			(void *)alloc_size, GFP_KERNEL,
-			dev_to_node(dev->dev));
-	if (!dev->iod_mempool)
-		return -ENOMEM;
-
-	dev->iod_meta_mempool = mempool_create_node(1,
-			mempool_kmalloc, mempool_kfree,
-			(void *)meta_size, GFP_KERNEL,
-			dev_to_node(dev->dev));
-	if (!dev->iod_meta_mempool)
-		goto free;
-
-	return 0;
-free:
-	mempool_destroy(dev->iod_mempool);
-	return -ENOMEM;
-}
-
 static void nvme_free_tagset(struct nvme_dev *dev)
 {
 	if (dev->tagset.tags)
@@ -3248,15 +3229,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto out_dev_unmap;
 
-	result = nvme_pci_alloc_iod_mempool(dev);
-	if (result)
-		goto out_release_prp_pools;
-
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
 	result = nvme_pci_enable(dev);
 	if (result)
-		goto out_release_iod_mempool;
+		goto out_release_prp_pools;
 
 	result = nvme_alloc_admin_tag_set(&dev->ctrl, &dev->admin_tagset,
 				&nvme_mq_admin_ops, sizeof(struct nvme_iod));
@@ -3323,9 +3300,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
-out_release_iod_mempool:
-	mempool_destroy(dev->iod_mempool);
-	mempool_destroy(dev->iod_meta_mempool);
 out_release_prp_pools:
 	nvme_release_prp_pools(dev);
 out_dev_unmap:
@@ -3390,8 +3364,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
-	mempool_destroy(dev->iod_mempool);
-	mempool_destroy(dev->iod_meta_mempool);
 	nvme_release_prp_pools(dev);
 	nvme_dev_unmap(dev);
 	nvme_uninit_ctrl(&dev->ctrl);
-- 
2.49.0


