Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15D67CFDCC
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 17:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346189AbjJSP0W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 11:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345938AbjJSP0V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 11:26:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EB8121
        for <linux-rdma@vger.kernel.org>; Thu, 19 Oct 2023 08:26:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CF9C433C8;
        Thu, 19 Oct 2023 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697729179;
        bh=vrWYcWHb8JepDA5UyhONANsPwTqHXa7W1d6oKXTubOY=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=QNbUWcaeUcIQohwIKnubZ84iKB50FmE8IcYi+P/RZtk2Vl8HjcbVh+j2A1RN1vlGu
         NGKqi+p8Is/6wVh4TAyYQTekxIP5urv6k6gcZc06Q42o7RO0pH57A0w307oi60lK/9
         AH3r9+2rRDYHYa15qnnu1FwTJN1y2xPSd8TxGueFDYUhJvedOg4qCBwcK4gRt6ejdg
         HdqSdkkkbIV6hQ6MUApeE3cd70sGjb0ia5WOrUqTpZNUneqllfnHNjySjTYQWxXOxI
         1oYVCdP3Q/ZM/5aSokK6uhB9QHll/7MBxxrZXTg6Mr0mTyI3OEHKOhFV7KMfoNVkUN
         IpbpQeNn9xIQQ==
Subject: [PATCH RFC 7/9] DMA: Add dma_map_bvecs_attrs()
From:   Chuck Lever <cel@kernel.org>
Cc:     iommu@lists.linux.dev, linux-rdma@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 19 Oct 2023 11:26:18 -0400
Message-ID: <169772917833.5232.13488378553385610086.stgit@klimt.1015granger.net>
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
 include/linux/dma-map-ops.h |    4 +++
 include/linux/dma-mapping.h |    4 +++
 kernel/dma/mapping.c        |   65 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index de2a50d9207a..69ecfd403249 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -60,6 +60,10 @@ struct dma_map_ops {
 			enum dma_data_direction dir, unsigned long attrs);
 	void (*unmap_sg)(struct device *dev, struct scatterlist *sg, int nents,
 			enum dma_data_direction dir, unsigned long attrs);
+	int (*map_bvecs)(struct device *dev, struct bio_vec *bvecs, int nents,
+			enum dma_data_direction dir, unsigned long attrs);
+	void (*unmap_bvecs)(struct device *dev, struct bio_vec *bvecs, int nents,
+			enum dma_data_direction dir, unsigned long attrs);
 	dma_addr_t (*map_resource)(struct device *dev, phys_addr_t phys_addr,
 			size_t size, enum dma_data_direction dir,
 			unsigned long attrs);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 9fb422f376b6..6f522a82cfe3 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -114,6 +114,10 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 				      unsigned long attrs);
 int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
 		enum dma_data_direction dir, unsigned long attrs);
+unsigned int dma_map_bvecs_attrs(struct device *dev, struct bio_vec *bvecs,
+		int nents, enum dma_data_direction dir, unsigned long attrs);
+void dma_unmap_bvecs_attrs(struct device *dev, struct bio_vec *bvecs,
+		int nents, enum dma_data_direction dir, unsigned long attrs);
 dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 94cffc9b45a5..f53cc4da2797 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -296,6 +296,71 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 }
 EXPORT_SYMBOL(dma_unmap_sg_attrs);
 
+/**
+ * dma_map_sg_attrs - Map the given buffer for DMA
+ * @dev:	The device for which to perform the DMA operation
+ * @bvecs:	The bio_vec array describing the buffer
+ * @nents:	Number of bio_vecs to map
+ * @dir:	DMA direction
+ * @attrs:	Optional DMA attributes for the map operation
+ *
+ * Maps a buffer described by a bio_vec array passed in the bvecs
+ * argument with nents segments for the @dir DMA operation by the
+ * @dev device.
+ *
+ * Returns the number of mapped entries (which can be less than nents)
+ * on success. Zero is returned for any error.
+ *
+ * dma_unmap_bvecs_attrs() should be used to unmap the buffer with the
+ * original bvecs and original nents (not the value returned by this
+ * function).
+ */
+unsigned int dma_map_bvecs_attrs(struct device *dev, struct bio_vec *bvecs,
+				 int nents, enum dma_data_direction dir,
+				 unsigned long attrs)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	int ents;
+
+	BUG_ON(!valid_dma_direction(dir));
+
+	if (WARN_ON_ONCE(!dev->dma_mask))
+		return 0;
+
+	if (dma_map_direct(dev, ops))
+		ents = dma_direct_map_bvecs(dev, bvecs, nents, dir, attrs);
+	else
+		ents = ops->map_bvecs(dev, bvecs, nents, dir, attrs);
+
+	if (ents > 0) {
+		kmsan_handle_dma_bvecs(bvecs, nents, dir);
+		debug_dma_map_bvecs(dev, bvecs, nents, ents, dir, attrs);
+	} else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
+				ents != -EIO && ents != -EREMOTEIO)) {
+		return -EIO;
+	}
+
+	return ents;
+}
+EXPORT_SYMBOL_GPL(dma_map_bvecs_attrs);
+
+void dma_unmap_bvecs_attrs(struct device *dev, struct bio_vec *bvecs,
+			   int nents, enum dma_data_direction dir,
+			   unsigned long attrs)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+
+	debug_dma_unmap_bvecs(dev, bvecs, nents, dir);
+
+	if (dma_map_direct(dev, ops))
+		dma_direct_unmap_bvecs(dev, bvecs, nents, dir, attrs);
+	else if (ops->unmap_bvecs)
+		ops->unmap_bvecs(dev, bvecs, nents, dir, attrs);
+}
+EXPORT_SYMBOL(dma_unmap_bvecs_attrs);
+
 dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {


