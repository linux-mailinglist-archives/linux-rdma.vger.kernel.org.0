Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C857CFDCE
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 17:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346277AbjJSP0e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 11:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345938AbjJSP0e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 11:26:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E8124
        for <linux-rdma@vger.kernel.org>; Thu, 19 Oct 2023 08:26:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A56C433C7;
        Thu, 19 Oct 2023 15:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697729192;
        bh=78EBrsEYDbjqzKz6oikO8SaOCUrBd4svH1Rn6ZfGLCE=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=rswgT3YhnWkT3o0G6MojVzyCpe1SD39xHMrPipMZmSgVISLih5aNMWaWjg0idGwlR
         wr1ngmFiei5XhT7c+Bu0NDL/fXh4/s7CIqIKFFPFWNoEYEuA8oQFX3jQ9CBPbBczrH
         KX6RdenvTZNcABi7dkWPz+b61ZF7orVMEZSuh78HlmyDoT3ATBRLAiRnXOUlkXDbFu
         qoskSLR5ffA7+QCiaPDrFep6sEAilcxP52iiAf6f4m0sON8DaScP9t0vKWNIYZNnSt
         65qEPZJWJJZyZNDRRA4SThj1yBcY53wJs1tU1afsX5b6KqbKu+THc4hyXRfHqHjmnm
         nqTECaowlRAmw==
Subject: [PATCH RFC 9/9] RDMA: Add helpers for DMA-mapping an array of
 bio_vecs
From:   Chuck Lever <cel@kernel.org>
Cc:     iommu@lists.linux.dev, linux-rdma@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 19 Oct 2023 11:26:31 -0400
Message-ID: <169772919129.5232.11342896871510148807.stgit@klimt.1015granger.net>
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
 include/rdma/ib_verbs.h |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 533ab92684d8..5e205fda90f9 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4220,6 +4220,35 @@ static inline void ib_dma_unmap_sg(struct ib_device *dev,
 	ib_dma_unmap_sg_attrs(dev, sg, nents, direction, 0);
 }
 
+/**
+ * ib_dma_map_sg - Map an array of bio_vecs to DMA addresses
+ * @dev: The device for which the DMA addresses are to be created
+ * @bvecs: The array of bio_vec entries to map
+ * @nents: The number of entries in the array
+ * @direction: The direction of the DMA
+ */
+static inline int ib_dma_map_bvecs(struct ib_device *dev,
+				   struct bio_vec *bvecs, int nents,
+				   enum dma_data_direction direction)
+{
+	return dma_map_bvecs_attrs(dev->dma_device, bvecs, nents, direction, 0);
+}
+
+/**
+ * ib_dma_unmap_bvecs - Unmap a DMA-mapped bio_vec array
+ * @dev: The device for which the DMA addresses were created
+ * @bvecs: The array of bio_vec entries to unmap
+ * @nents: The number of entries in the array
+ * @direction: The direction of the DMA
+ */
+static inline void ib_dma_unmap_bvec(struct ib_device *dev,
+				     struct bio_vec *bvecs, int nents,
+				     enum dma_data_direction direction)
+{
+	if (!ib_uses_virt_dma(dev))
+		dma_unmap_bvecs_attrs(dev->dma_device, bvecs, nents, direction);
+}
+
 /**
  * ib_dma_max_seg_size - Return the size limit of a single DMA transfer
  * @dev: The device to query


