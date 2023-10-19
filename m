Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B918A7CFDC7
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 17:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345812AbjJSPZ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345747AbjJSPZz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 11:25:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9F412D
        for <linux-rdma@vger.kernel.org>; Thu, 19 Oct 2023 08:25:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395E2C433C7;
        Thu, 19 Oct 2023 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697729153;
        bh=uRB/mEHfqFq0/byWOeHcx/c9OoEQMOSFmfHR/6Welrw=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=pBszrRJEaabi/HAj3x4dLEgnsXeaQstPQgO5SWx8hri66P7BPSMLEddMGoMgwk8Rb
         vYsJsz/31e9umLykgtY6i2FT5B5l6uBrEEbOkDzb76vzzuzuxkvm54OGulXNog38fA
         A52O3hiGE8pcK2UsjjuxnjwTBv965Nf8MzB2m7AJKIi2TqzBIQPWKYdId8ojwp8BYG
         dyQuwOaj5EcLrwyukTvpe9a+NQ4S0d5M25wZitveCajb8Qe0DIS0j0QkTzXq+TMg00
         cNI2S46YGgysF5R/Z5QBFj/snPaHptT5YHKd7siTEcd3+aB0vuyct3jLirrfEZKqRZ
         DHl3s80M+58VA==
Subject: [PATCH RFC 3/9] dma-debug: Add dma_debug_ helpers for mapping bio_vec
 arrays
From:   Chuck Lever <cel@kernel.org>
Cc:     iommu@lists.linux.dev, linux-rdma@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 19 Oct 2023 11:25:52 -0400
Message-ID: <169772915215.5232.10127407258544978465.stgit@klimt.1015granger.net>
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
 include/linux/dma-mapping.h |    1 
 kernel/dma/debug.c          |  163 +++++++++++++++++++++++++++++++++++++++++++
 kernel/dma/debug.h          |   38 ++++++++++
 3 files changed, 202 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f0ccca16a0ac..f511ec546f4d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/dma-direction.h>
 #include <linux/scatterlist.h>
+#include <linux/bvec.h>
 #include <linux/bug.h>
 #include <linux/mem_encrypt.h>
 
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 3de494375b7b..efb4a2eaf9a0 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -39,6 +39,7 @@ enum {
 	dma_debug_sg,
 	dma_debug_coherent,
 	dma_debug_resource,
+	dma_debug_bv,
 };
 
 enum map_err_types {
@@ -142,6 +143,7 @@ static const char *type2name[] = {
 	[dma_debug_sg] = "scatter-gather",
 	[dma_debug_coherent] = "coherent",
 	[dma_debug_resource] = "resource",
+	[dma_debug_bv] = "bio-vec",
 };
 
 static const char *dir2name[] = {
@@ -1189,6 +1191,32 @@ static void check_sg_segment(struct device *dev, struct scatterlist *sg)
 #endif
 }
 
+static void check_bv_segment(struct device *dev, struct bio_vec *bv)
+{
+#ifdef CONFIG_DMA_API_DEBUG_SG
+	unsigned int max_seg = dma_get_max_seg_size(dev);
+	u64 start, end, boundary = dma_get_seg_boundary(dev);
+
+	/*
+	 * Either the driver forgot to set dma_parms appropriately, or
+	 * whoever generated the list forgot to check them.
+	 */
+	if (bv->length > max_seg)
+		err_printk(dev, NULL, "mapping bv entry longer than device claims to support [len=%u] [max=%u]\n",
+			   bv->length, max_seg);
+	/*
+	 * In some cases this could potentially be the DMA API
+	 * implementation's fault, but it would usually imply that
+	 * the scatterlist was built inappropriately to begin with.
+	 */
+	start = bv_dma_address(bv);
+	end = start + bv_dma_len(bv) - 1;
+	if ((start ^ end) & ~boundary)
+		err_printk(dev, NULL, "mapping bv entry across boundary [start=0x%016llx] [end=0x%016llx] [boundary=0x%016llx]\n",
+			   start, end, boundary);
+#endif
+}
+
 void debug_dma_map_single(struct device *dev, const void *addr,
 			    unsigned long len)
 {
@@ -1333,6 +1361,47 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	}
 }
 
+void debug_dma_map_bvecs(struct device *dev, struct bio_vec *bvecs,
+			 int nents, int mapped_ents, int direction,
+			 unsigned long attrs)
+{
+	struct dma_debug_entry *entry;
+	struct bio_vec *bv;
+	int i;
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	for (i = 0; i < nents; i++) {
+		bv = &bvecs[i];
+		check_for_stack(dev, bv_page(bv), bv->offset);
+		if (!PageHighMem(bv_page(bv)))
+			check_for_illegal_area(dev, bv_virt(bv), bv->length);
+	}
+
+	for (i = 0; i < nents; i++) {
+		bv = &bvecs[i];
+
+		entry = dma_entry_alloc();
+		if (!entry)
+			return;
+
+		entry->type           = dma_debug_bv;
+		entry->dev            = dev;
+		entry->pfn	      = page_to_pfn(bv_page(bv));
+		entry->offset	      = bv->offset;
+		entry->size           = bv_dma_len(bv);
+		entry->dev_addr       = bv_dma_address(bv);
+		entry->direction      = direction;
+		entry->sg_call_ents   = nents;
+		entry->sg_mapped_ents = mapped_ents;
+
+		check_bv_segment(dev, bv);
+
+		add_dma_entry(entry, attrs);
+	}
+}
+
 static int get_nr_mapped_entries(struct device *dev,
 				 struct dma_debug_entry *ref)
 {
@@ -1384,6 +1453,37 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	}
 }
 
+void debug_dma_unmap_bvecs(struct device *dev, struct bio_vec *bvecs,
+			   int nelems, int dir)
+{
+	int mapped_ents = 0, i;
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	for (i = 0; i < nents; i++) {
+		struct bio_vec *bv = &bvecs[i];
+		struct dma_debug_entry ref = {
+			.type           = dma_debug_bv,
+			.dev            = dev,
+			.pfn		= page_to_pfn(bv_page(bv)),
+			.offset		= bv->offset,
+			.dev_addr       = bv_dma_address(bv),
+			.size           = bv_dma_len(bv),
+			.direction      = dir,
+			.sg_call_ents   = nelems,
+		};
+
+		if (mapped_ents && i >= mapped_ents)
+			break;
+
+		if (!i)
+			mapped_ents = get_nr_mapped_entries(dev, &ref);
+
+		check_unmap(&ref);
+	}
+}
+
 void debug_dma_alloc_coherent(struct device *dev, size_t size,
 			      dma_addr_t dma_addr, void *virt,
 			      unsigned long attrs)
@@ -1588,6 +1688,69 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	}
 }
 
+void debug_dma_sync_bvecs_for_cpu(struct device *dev, struct bio_vec *bvecs,
+				  int nelems, int direction)
+{
+	int mapped_ents = 0, i;
+	struct bio_vec *bv;
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	for (i = 0; i < nents; i++) {
+		struct bio_vec *bv = &bvecs[i];
+		struct dma_debug_entry ref = {
+			.type           = dma_debug_bv,
+			.dev            = dev,
+			.pfn		= page_to_pfn(bv->bv_page),
+			.offset		= bv->bv_offset,
+			.dev_addr       = bv_dma_address(bv),
+			.size           = bv_dma_len(bv),
+			.direction      = direction,
+			.sg_call_ents   = nelems,
+		};
+
+		if (!i)
+			mapped_ents = get_nr_mapped_entries(dev, &ref);
+
+		if (i >= mapped_ents)
+			break;
+
+		check_sync(dev, &ref, true);
+	}
+}
+
+void debug_dma_sync_bvecs_for_device(struct device *dev, struct bio_vec *bvecs,
+				     int nelems, int direction)
+{
+	int mapped_ents = 0, i;
+	struct bio_vec *bv;
+
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	for (i = 0; i < nents; i++) {
+		struct bio_vec *bv = &bvecs[i];
+		struct dma_debug_entry ref = {
+			.type           = dma_debug_bv,
+			.dev            = dev,
+			.pfn		= page_to_pfn(bv->bv_page),
+			.offset		= bv->bv_offset,
+			.dev_addr       = bv_dma_address(bv),
+			.size           = bv_dma_len(bv),
+			.direction      = direction,
+			.sg_call_ents   = nelems,
+		};
+		if (!i)
+			mapped_ents = get_nr_mapped_entries(dev, &ref);
+
+		if (i >= mapped_ents)
+			break;
+
+		check_sync(dev, &ref, false);
+	}
+}
+
 static int __init dma_debug_driver_setup(char *str)
 {
 	int i;
diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
index f525197d3cae..dff7e8a2f594 100644
--- a/kernel/dma/debug.h
+++ b/kernel/dma/debug.h
@@ -24,6 +24,13 @@ extern void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 extern void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			       int nelems, int dir);
 
+extern void debug_dma_map_bvecs(struct device *dev, struct bio_vec *bvecs,
+				int nents, int mapped_ents, int direction,
+				unsigned long attrs);
+
+extern void debug_dma_unmap_bvecs(struct device *dev, struct bio_vec *bvecs,
+				  int nelems, int dir);
+
 extern void debug_dma_alloc_coherent(struct device *dev, size_t size,
 				     dma_addr_t dma_addr, void *virt,
 				     unsigned long attrs);
@@ -54,6 +61,14 @@ extern void debug_dma_sync_sg_for_cpu(struct device *dev,
 extern void debug_dma_sync_sg_for_device(struct device *dev,
 					 struct scatterlist *sg,
 					 int nelems, int direction);
+
+extern void debug_dma_sync_bvecs_for_cpu(struct device *dev,
+					 struct bio_vec *bvecs,
+					 int nelems, int direction);
+
+extern void debug_dma_sync_bvecs_for_device(struct device *dev,
+					    struct bio_vec *bvecs,
+					    int nelems, int direction);
 #else /* CONFIG_DMA_API_DEBUG */
 static inline void debug_dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
@@ -79,6 +94,17 @@ static inline void debug_dma_unmap_sg(struct device *dev,
 {
 }
 
+static inline void debug_dma_map_bvecs(struct device *dev, struct bio_vec *bvecs,
+				       int nents, int mapped_ents, int direction,
+				       unsigned long attrs)
+{
+}
+
+static inline void debug_dma_unmap_bvecs(struct device *dev, struct bio_vec *bvecs,
+					 int nelems, int dir)
+{
+}
+
 static inline void debug_dma_alloc_coherent(struct device *dev, size_t size,
 					    dma_addr_t dma_addr, void *virt,
 					    unsigned long attrs)
@@ -126,5 +152,17 @@ static inline void debug_dma_sync_sg_for_device(struct device *dev,
 						int nelems, int direction)
 {
 }
+
+static inline void debug_dma_sync_bvecs_for_cpu(struct device *dev,
+						struct bio_vec *bvecs,
+						int nelems, int direction)
+{
+}
+
+static inline void debug_dma_sync_bvecs_for_device(struct device *dev,
+						   struct bio_vec *bvecs,
+						   int nelems, int direction)
+{
+}
 #endif /* CONFIG_DMA_API_DEBUG */
 #endif /* _KERNEL_DMA_DEBUG_H */


