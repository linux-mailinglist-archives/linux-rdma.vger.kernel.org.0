Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2E97CFDCB
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 17:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346115AbjJSP0P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 11:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345938AbjJSP0P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 11:26:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7892112D
        for <linux-rdma@vger.kernel.org>; Thu, 19 Oct 2023 08:26:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F48C433C7;
        Thu, 19 Oct 2023 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697729173;
        bh=8lPy8rsZStYEVHbRVMx8WfUHPcgCULF0xCyPhT/GQIk=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=Xo0q5LOFCDxiiaJv+oB38nSmpPeW/PWuF0FIIepzw9Cqjt/OEzeNf7x5rynFqx5Dn
         8E6a60NqfmE/l1t90IJKPaM5ZUDVwkGL6N7BjBWmJHUPaCsZdkUGWgh5aWdhKiDtUz
         Rae1yqsuWb3KKTARu3X7xasIQQBfbMmLi4x5XXsiLzJjOS2kLcZ/jJ/XZcZqEgRdvU
         RyAafc1BvFVkIm3jX2R7xiBb33gzWAV/IMnqZhsgyxdJY5gN+cr6mj+9qYcMNtCYi9
         /cAIHkZ+Ox4TNaZWqhZ+w7rkngOU8qc7wPiBV0VlzPxbMsSvRDfIZBG5TMPYpbFskw
         HbcFh78x2iJkA==
Subject: [PATCH RFC 6/9] DMA-API: Add dma_sync_bvecs_for_cpu() and
 dma_sync_bvecs_for_device()
From:   Chuck Lever <cel@kernel.org>
Cc:     iommu@lists.linux.dev, linux-rdma@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 19 Oct 2023 11:26:11 -0400
Message-ID: <169772917192.5232.2827727564287466466.stgit@klimt.1015granger.net>
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
 include/linux/dma-map-ops.h |    4 ++++
 include/linux/dma-mapping.h |    4 ++++
 kernel/dma/mapping.c        |   28 ++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index f2fc203fb8a1..de2a50d9207a 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -75,6 +75,10 @@ struct dma_map_ops {
 			int nents, enum dma_data_direction dir);
 	void (*sync_sg_for_device)(struct device *dev, struct scatterlist *sg,
 			int nents, enum dma_data_direction dir);
+	void (*sync_bvecs_for_cpu)(struct device *dev, struct bio_vec *bvecs,
+			int nents, enum dma_data_direction dir);
+	void (*sync_bvecs_for_device)(struct device *dev, struct bio_vec *bvecs,
+			int nents, enum dma_data_direction dir);
 	void (*cache_sync)(struct device *dev, void *vaddr, size_t size,
 			enum dma_data_direction direction);
 	int (*dma_supported)(struct device *dev, u64 mask);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f511ec546f4d..9fb422f376b6 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -126,6 +126,10 @@ void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 		    int nelems, enum dma_data_direction dir);
 void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 		       int nelems, enum dma_data_direction dir);
+void dma_sync_bvecs_for_cpu(struct device *dev, struct bio_vec *bvecs,
+			    int nelems, enum dma_data_direction dir);
+void dma_sync_bvecs_for_device(struct device *dev, struct bio_vec *bvecs,
+			       int nelems, enum dma_data_direction dir);
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs);
 void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index e323ca48f7f2..94cffc9b45a5 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -385,6 +385,34 @@ void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 }
 EXPORT_SYMBOL(dma_sync_sg_for_device);
 
+void dma_sync_bvecs_for_cpu(struct device *dev, struct bio_vec *bvecs,
+			    int nelems, enum dma_data_direction dir)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (dma_map_direct(dev, ops))
+		dma_direct_sync_bvecs_for_cpu(dev, bvecs, nelems, dir);
+	else if (ops->sync_bvecs_for_cpu)
+		ops->sync_bvecs_for_cpu(dev, bvecs, nelems, dir);
+	debug_dma_sync_bvecs_for_cpu(dev, bvecs, nelems, dir);
+}
+EXPORT_SYMBOL(dma_sync_bvecs_for_cpu);
+
+void dma_sync_bvecs_for_device(struct device *dev, struct bio_vec *bvecs,
+			       int nelems, enum dma_data_direction dir)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (dma_map_direct(dev, ops))
+		dma_direct_sync_bvecs_for_device(dev, bvecs, nelems, dir);
+	else if (ops->sync_bvecs_for_device)
+		ops->sync_bvecs_for_device(dev, bvecs, nelems, dir);
+	debug_dma_sync_bvecs_for_device(dev, bvecs, nelems, dir);
+}
+EXPORT_SYMBOL(dma_sync_bvecs_for_device);
+
 /*
  * The whole dma_get_sgtable() idea is fundamentally unsafe - it seems
  * that the intention is to allow exporting memory allocated via the


