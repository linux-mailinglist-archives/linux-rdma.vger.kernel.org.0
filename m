Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDF168130B
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jan 2023 15:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbjA3O15 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Jan 2023 09:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbjA3O12 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Jan 2023 09:27:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81865212F
        for <linux-rdma@vger.kernel.org>; Mon, 30 Jan 2023 06:25:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 204ECB80CB4
        for <linux-rdma@vger.kernel.org>; Mon, 30 Jan 2023 14:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402B7C433D2;
        Mon, 30 Jan 2023 14:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675088755;
        bh=/1TfNXkq3YUd460YgVWP5Vp7tFX3R/qZEnQqHWZHWnI=;
        h=From:To:Cc:Subject:Date:From;
        b=b+BlhWE/mLSFOT9aXGe11zQa2d6Im8JDvfhCGEGdJE30Ge4MXS/fsoy8auQU4fzkL
         mjvJaYt47cl4Il5EwdEOXvOv/vepRCD7Thxnc5NpK00+Bhq+CjXAE+5YWrXMyZdCIO
         aleEZk4rChupsc4xqzMATo+rlEJAjcawHlWWHOcg+GN/M0s8KwGaxmwrQoLMxr5HWK
         5zYD+nOr9osJbj715Tv5Pcr+NV9ta6VC722sit46uSF87KWZONA3bdvVkjmu4NQbDL
         FTYW05Coxnk/4gbZoqbDSJInQj4Lr1LqKqyPH6z6qrUC4rU35iIl1s1pxwoKLkmhOu
         HHUvNsLPLrvug==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/umem: Use dma-buf locked API to solve deadlock
Date:   Mon, 30 Jan 2023 16:25:50 +0200
Message-Id: <311c2cb791f8af75486df446819071357353db1b.1675088709.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

The cited commit moves umem to call the unlocked versions of dmabuf
unmap/map attachment, but the lock is held while calling to these
functions, hence move back to the locked versions of these APIs.

Fixes: 21c9c5c0784f ("RDMA/umem: Prepare to dynamic dma-buf locking specification")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem_dmabuf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index 43b26bc12288..39357dc2d229 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -26,8 +26,8 @@ int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
 	if (umem_dmabuf->sgt)
 		goto wait_fence;
 
-	sgt = dma_buf_map_attachment_unlocked(umem_dmabuf->attach,
-					      DMA_BIDIRECTIONAL);
+	sgt = dma_buf_map_attachment(umem_dmabuf->attach,
+				     DMA_BIDIRECTIONAL);
 	if (IS_ERR(sgt))
 		return PTR_ERR(sgt);
 
@@ -103,8 +103,8 @@ void ib_umem_dmabuf_unmap_pages(struct ib_umem_dmabuf *umem_dmabuf)
 		umem_dmabuf->last_sg_trim = 0;
 	}
 
-	dma_buf_unmap_attachment_unlocked(umem_dmabuf->attach, umem_dmabuf->sgt,
-					  DMA_BIDIRECTIONAL);
+	dma_buf_unmap_attachment(umem_dmabuf->attach, umem_dmabuf->sgt,
+				 DMA_BIDIRECTIONAL);
 
 	umem_dmabuf->sgt = NULL;
 }
-- 
2.39.1

