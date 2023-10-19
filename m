Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99127CFDCA
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 17:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345977AbjJSP0J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 11:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346191AbjJSP0I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 11:26:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1338612A
        for <linux-rdma@vger.kernel.org>; Thu, 19 Oct 2023 08:26:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71121C433C9;
        Thu, 19 Oct 2023 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697729166;
        bh=yQhqxZwOMDPJhW7Xwgk5yIT4GMSsV4nf1//lo7TNLyc=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=cThuabzcIkYl5Bb/AuPXihl2As71NbsV8Y+T8/Gjhqg7BNgYJq0gqZnAOpEfcKTbM
         mdF0zvj/3fr0s7HHqevttUTIXT0Aqs5GRUq57aNQ7Savc7LCtuNCbIuNcqJtdpJHQl
         QrliO9wy1A9STmaFNVO33BCbgLnS1ZIpDFZdgj9U6jTVL4jJPTljBLIVyKmxCJOFWB
         qi9AbUoN4GtRS/UlIeXxiAmUCyjUP3WGtMbLJwhqmSQJT7WzthVhC5G71Us8wklNdR
         K/vSa390seTwSDQBBoH2grw5rQtIV2fVi6cg9+teWglZcSAKqmvXZ7WgqBREECCaIW
         4xj8/3VAPP/9A==
Subject: [PATCH RFC 5/9] dma-direct: Support direct mapping bio_vec arrays
From:   Chuck Lever <cel@kernel.org>
Cc:     iommu@lists.linux.dev, linux-rdma@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 19 Oct 2023 11:26:05 -0400
Message-ID: <169772916546.5232.14817964507475231582.stgit@klimt.1015granger.net>
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
 kernel/dma/direct.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/dma/direct.h |   17 +++++++++
 2 files changed, 109 insertions(+)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 9596ae1aa0da..7587c5c3d051 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -423,6 +423,26 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 					dir);
 	}
 }
+
+void dma_direct_sync_bvecs_for_device(struct device *dev,
+		struct bio_vec *bvecs, int nents, enum dma_data_direction dir)
+{
+	struct bio_vec *bv;
+	int i;
+
+	for (i = 0; i < nents; i++) {
+		bv = &bvecs[i];
+		phys_addr_t paddr = dma_to_phys(dev, bv_dma_address(bv));
+
+		if (unlikely(is_swiotlb_buffer(dev, paddr)))
+			swiotlb_sync_single_for_device(dev, paddr, bv->bv_len,
+						       dir);
+
+		if (!dev_is_dma_coherent(dev))
+			arch_sync_dma_for_device(paddr, bv->bv_len,
+					dir);
+	}
+}
 #endif
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
@@ -516,6 +536,78 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	return ret;
 }
 
+void dma_direct_sync_bvecs_for_cpu(struct device *dev,
+		struct bio_vec *bvecs, int nents, enum dma_data_direction dir)
+{
+	struct bio_vec *bv;
+	int i;
+
+	for (i = 0; i < nents; i++) {
+		phys_addr_t paddr;
+
+		bv = &bvecs[i];
+		paddr = dma_to_phys(dev, bv_dma_address(bv));
+
+		if (!dev_is_dma_coherent(dev))
+			arch_sync_dma_for_cpu(paddr, bv->bv_len, dir);
+
+		if (unlikely(is_swiotlb_buffer(dev, paddr)))
+			swiotlb_sync_single_for_cpu(dev, paddr, bv->bv_len,
+						    dir);
+
+		if (dir == DMA_FROM_DEVICE)
+			arch_dma_mark_clean(paddr, bv->bv_len);
+	}
+
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_for_cpu_all();
+}
+
+/*
+ * Unmaps segments, except for ones marked as pci_p2pdma which do not
+ * require any further action as they contain a bus address.
+ */
+void dma_direct_unmap_bvecs(struct device *dev, struct bio_vec *bvecs,
+			    int nents, enum dma_data_direction dir,
+			    unsigned long attrs)
+{
+	struct bio_vec *bv;
+	int i;
+
+	for (i = 0; i < nents; i++) {
+		bv = &bvecs[i];
+		if (bv_dma_is_bus_address(bv))
+			bv_dma_unmark_bus_address(bv);
+		else
+			dma_direct_unmap_page(dev, bv_dma_address(bv),
+					      bv_dma_len(bv), dir, attrs);
+	}
+
+}
+
+int dma_direct_map_bvecs(struct device *dev, struct bio_vec *bvecs, int nents,
+			 enum dma_data_direction dir, unsigned long attrs)
+{
+	struct bio_vec *bv;
+	int i;
+
+	/* p2p DMA mapping support can be added later */
+	for (i = 0; i < nents; i++) {
+		bv = &bvecs[i];
+		bv->bv_dma_address = dma_direct_map_page(dev, bv->bv_page,
+				bv->bv_offset, bv->bv_len, dir, attrs);
+		if (bv->bv_dma_address == DMA_MAPPING_ERROR)
+			goto out_unmap;
+		bv_dma_len(bv) = bv->bv_len;
+	}
+
+	return nents;
+
+out_unmap:
+	dma_direct_unmap_bvecs(dev, bvecs, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
+	return -EIO;
+}
+
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 97ec892ea0b5..6db1ccd04d21 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -20,17 +20,26 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
+int dma_direct_map_bvecs(struct device *dev, struct bio_vec *bvecs, int nents,
+		enum dma_data_direction dir, unsigned long attrs);
 size_t dma_direct_max_mapping_size(struct device *dev);
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_SWIOTLB)
 void dma_direct_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir);
+void dma_direct_sync_bvecs_for_device(struct device *dev, struct bio_vec *bvecs,
+		int nents, enum dma_data_direction dir);
 #else
 static inline void dma_direct_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
 {
 }
+
+static inline void dma_direct_sync_bvecs_for_device(struct device *dev,
+		struct bio_vec *bvecs, int nents, enum dma_data_direction dir)
+{
+}
 #endif
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
@@ -40,6 +49,10 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
 void dma_direct_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
+void dma_direct_unmap_bvecs(struct device *dev, struct bio_vec *bvecs,
+		int nents, enum dma_data_direction dir, unsigned long attrs);
+void dma_direct_sync_bvecs_for_cpu(struct device *dev,
+		struct bio_vec *bvecs, int nents, enum dma_data_direction dir);
 #else
 static inline void dma_direct_unmap_sg(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir,
@@ -50,6 +63,10 @@ static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
 {
 }
+static inline void dma_direct_sync_bvecs_for_cpu(struct device *dev,
+		struct bio_vec *bvecs, int nents, enum dma_data_direction dir)
+{
+}
 #endif
 
 static inline void dma_direct_sync_single_for_device(struct device *dev,


