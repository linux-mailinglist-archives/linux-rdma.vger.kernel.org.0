Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917A97CFDC6
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 17:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345550AbjJSPZt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 11:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345747AbjJSPZt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 11:25:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBB6132
        for <linux-rdma@vger.kernel.org>; Thu, 19 Oct 2023 08:25:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A8FC433C8;
        Thu, 19 Oct 2023 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697729146;
        bh=rHw641BxoEniSZKS3TqYaiuJRFAhMpJhe6yrKgKV3tA=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=BnlHbiv/wGrZr62VlehUMM5I7UG1UFVZkdo7FRvv4kGbpL6WpDAEzXH3ZQn0OBn9a
         ir40Aj9VBGeoL46O7FHBrW+tfz0NqfpfQm0lDRtoRTyF+HqDR6Wd1qBJ2/6w5zVznB
         RRuBsjIx5RA+wqJIo943V2DU3wwKRLOvWq6q9C5ltYgLfansfJDlTJ2/VuEyJEk6c6
         xIL0OcMC5QOyms4UtJvxWRzM4qMMAumwYAQFvK66m2GpN/8BzU1Ebwlno9DVs+PybA
         M3K1OQnVM37n7wmH3RaqFhdD3B+AzpBw99ZrRUbvCyrwN7W/VG/dGajR1e9i6auu43
         ZOhcgbm9tvzdg==
Subject: [PATCH RFC 2/9] bvec: Add bio_vec fields to manage DMA mapping
From:   Chuck Lever <cel@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>, iommu@lists.linux.dev,
        linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 19 Oct 2023 11:25:45 -0400
Message-ID: <169772914548.5232.12015170784207638561.stgit@klimt.1015granger.net>
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

These are roughly equivalent to the fields used for managing
scatterlist DMA mapping.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: iommu@lists.linux.dev
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/bvec.h |  143 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 555aae5448ae..1074f34a4e8f 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -13,6 +13,7 @@
 #include <linux/limits.h>
 #include <linux/minmax.h>
 #include <linux/types.h>
+#include <asm/io.h>
 
 struct page;
 
@@ -32,6 +33,13 @@ struct bio_vec {
 	struct page	*bv_page;
 	unsigned int	bv_len;
 	unsigned int	bv_offset;
+	dma_addr_t	bv_dma_address;
+#ifdef CONFIG_NEED_SG_DMA_LENGTH
+	unsigned int	bv_dma_length;
+#endif
+#ifdef CONFIG_NEED_SG_DMA_FLAGS
+	unsigned int	bv_dma_flags;
+#endif
 };
 
 /**
@@ -74,6 +82,24 @@ static inline void bvec_set_virt(struct bio_vec *bv, void *vaddr,
 	bvec_set_page(bv, virt_to_page(vaddr), len, offset_in_page(vaddr));
 }
 
+/**
+ * bv_phys - return physical address of a bio_vec
+ * @bv:		bio_vec
+ */
+static inline dma_addr_t bv_phys(struct bio_vec *bv)
+{
+	return page_to_phys(bv->bv_page) + bv->bv_offset;
+}
+
+/**
+ * bv_virt - return virtual address of a bio_vec
+ * @bv:		bio_vec
+ */
+static inline void *bv_virt(struct bio_vec *bv)
+{
+	return page_address(bv->bv_page) + bv->bv_offset;
+}
+
 struct bvec_iter {
 	sector_t		bi_sector;	/* device address in 512 byte
 						   sectors */
@@ -280,4 +306,121 @@ static inline void *bvec_virt(struct bio_vec *bvec)
 	return page_address(bvec->bv_page) + bvec->bv_offset;
 }
 
+/*
+ * These macros should be used after a dma_map_bvecs call has been done
+ * to get bus addresses of each of the bio_vec array entries and their
+ * lengths. You should work only with the number of bio_vec array entries
+ * dma_map_bvecs returns, or alternatively stop on the first bv_dma_len(bv)
+ * which is 0.
+ */
+#define bv_dma_address(bv)	((bv)->bv_dma_address)
+
+#ifdef CONFIG_NEED_SG_DMA_LENGTH
+#define bv_dma_len(bv)		((bv)->bv_dma_length)
+#else
+#define bv_dma_len(bv)		((bv)->bv_len)
+#endif
+
+/*
+ * On 64-bit architectures there is a 4-byte padding in struct scatterlist
+ * (assuming also CONFIG_NEED_SG_DMA_LENGTH is set). Use this padding for DMA
+ * flags bits to indicate when a specific dma address is a bus address or the
+ * buffer may have been bounced via SWIOTLB.
+ */
+#ifdef CONFIG_NEED_SG_DMA_FLAGS
+
+#define BV_DMA_BUS_ADDRESS	BIT(0)
+#define BV_DMA_SWIOTLB		BIT(1)
+
+/**
+ * bv_dma_is_bus_address - Return whether a given segment was marked
+ *			   as a bus address
+ * @bv:		 bio_vec array entry
+ *
+ * Description:
+ *   Returns true if bv_dma_mark_bus_address() has been called on
+ *   this bio_vec.
+ **/
+static inline bool bv_dma_is_bus_address(struct bio_vec *bv)
+{
+	return bv->bv_dma_flags & BV_DMA_BUS_ADDRESS;
+}
+
+/**
+ * bv_dma_mark_bus_address - Mark the bio_vec entry as a bus address
+ * @bv:		 bio_vec array entry
+ *
+ * Description:
+ *   Marks the passed-in bv entry to indicate that the dma_address is
+ *   a bus address and doesn't need to be unmapped. This should only be
+ *   used by dma_map_bvecs() implementations to mark bus addresses
+ *   so they can be properly cleaned up in dma_unmap_bvecs().
+ **/
+static inline void bv_dma_mark_bus_address(struct bio_vec *bv)
+{
+	bv->bv_dma_flags |= BV_DMA_BUS_ADDRESS;
+}
+
+/**
+ * bv_unmark_bus_address - Unmark the bio_vec entry as a bus address
+ * @bv:		 bio_vec array entry
+ *
+ * Description:
+ *   Clears the bus address mark.
+ **/
+static inline void bv_dma_unmark_bus_address(struct bio_vec *bv)
+{
+	bv->bv_dma_flags &= ~BV_DMA_BUS_ADDRESS;
+}
+
+/**
+ * bv_dma_is_swiotlb - Return whether the bio_vec was marked for SWIOTLB
+ *		       bouncing
+ * @bv:		bio_vec array entry
+ *
+ * Description:
+ *   Returns true if the bio_vec was marked for SWIOTLB bouncing. Not all
+ *   elements may have been bounced, so the caller would have to check
+ *   individual BV entries with is_swiotlb_buffer().
+ */
+static inline bool bv_dma_is_swiotlb(struct bio_vec *bv)
+{
+	return bv->bv_dma_flags & BV_DMA_SWIOTLB;
+}
+
+/**
+ * bv_dma_mark_swiotlb - Mark the bio_vec for SWIOTLB bouncing
+ * @bv:		bio_vec array entry
+ *
+ * Description:
+ *   Marks a a bio_vec for SWIOTLB bounce. Not all bio_vec entries may
+ *   be bounced.
+ */
+static inline void bv_dma_mark_swiotlb(struct bio_vec *bv)
+{
+	bv->bv_dma_flags |= BV_DMA_SWIOTLB;
+}
+
+#else
+
+static inline bool bv_dma_is_bus_address(struct bio_vec *bv)
+{
+	return false;
+}
+static inline void bv_dma_mark_bus_address(struct bio_vec *bv)
+{
+}
+static inline void bv_dma_unmark_bus_address(struct bio_vec *bv)
+{
+}
+static inline bool bv_dma_is_swiotlb(struct bio_vec *bv)
+{
+	return false;
+}
+static inline void bv_dma_mark_swiotlb(struct bio_vec *bv)
+{
+}
+
+#endif	/* CONFIG_NEED_SG_DMA_FLAGS */
+
 #endif /* __LINUX_BVEC_H */


