Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC096450E6
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfFNArE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:47:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44166 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFNArE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 20:47:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id p144so604484qke.11
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 17:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HtqvQYxioHMeLm/iJCQkrb9XOVms7ULSO8Ju2Fow8+4=;
        b=T/fvljVc8i8gx5dgQSJh5uLpoLyCcxMNgfp06miIhhfMVEFOMjJaBdvzkOBsjs2fCz
         oyZUeQCyKmlImPyEIh/ZO+R46wgf+wg0BiQw5QUgfEGxhdivSAEDgTgmAeidPKXocwbm
         i8hD91eyDr3OJWN5YGuDlYzi7YAEUovdrRizIqB1/E1DFPet6p7nutOZKIpHh0dHQut/
         Q1VGz0rtXYtk3L0PsbuQVZ6DFf4Qh5mTXyd5XTlqWP/W4UOveFJQK8ki+IQsqyPaKX4C
         i/OXF6bmGHhP62bJGOdeYZ6jCRj7d5Yhf8KKt1qGdNWL/YoHGDNNIwKyoekHkty5GgdW
         1jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HtqvQYxioHMeLm/iJCQkrb9XOVms7ULSO8Ju2Fow8+4=;
        b=B/hVco4mpyR8reQNXUEkt9NQ2eFKMmkf5XfeQAtzrfR5iCnL5dsyTfp3fEz9fZw3AJ
         W2f9qIsFLz1pDQfhYsA+HCN0RvQgPsmQ5kXANeYcoiLHdHGiv04p2FH8RWoHSJGF55B7
         i5VvSLiuxFY3eeqGuGa4mIbOOTWLLP4k4H1JWI6DvvNGaIPHm3i+1L5mjfw57/c0Eg/c
         LXq5KdyYeUFjkneRKIFxkJswF7M1g9GGgu3yGD2/VaEFzeFovZZ8ms8dtFX1KW1Gv/fM
         N5xZah88TKg7XcKwI1GqhCwNcIRkvvCrb/08ywR1+L0lgpjtd46uBYHTUtv4HTpJKBCR
         J9/w==
X-Gm-Message-State: APjAAAXYj6B0p1SGqA2bhqEDekQDnn7VZL+c3iXBjk6JIo6pon7IvfC8
        710K4evWTBmPjqR2rsft/M2QogBLROdSrA==
X-Google-Smtp-Source: APXvYqxG20RdacrLk+Tqh5DUn2uBLKVUw5Ze+3GCQpaiAzgxKNskFCNjQ8RtV5ablwKS6mRswp6h3g==
X-Received: by 2002:ae9:c30e:: with SMTP id n14mr67771672qkg.220.1560473223226;
        Thu, 13 Jun 2019 17:47:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r186sm700104qkb.9.2019.06.13.17.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 17:47:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaMw-0005QD-EM; Thu, 13 Jun 2019 21:47:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH] RDMA/odp: Do not leak dma maps when working with huge pages
Date:   Thu, 13 Jun 2019 21:46:45 -0300
Message-Id: <20190614004644.20767-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

The ib_dma_unmap_page() must match the length of the ib_dma_map_page(),
which is based on odp_shift. Otherwise iommu resources under this API
will not be properly freed.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 9001cc10770a24..bcfa5c904a4bbf 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -726,7 +726,8 @@ void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
 
 			WARN_ON(!dma_addr);
 
-			ib_dma_unmap_page(dev, dma_addr, PAGE_SIZE,
+			ib_dma_unmap_page(dev, dma_addr,
+					  BIT(umem_odp->page_shift),
 					  DMA_BIDIRECTIONAL);
 			if (dma & ODP_WRITE_ALLOWED_BIT) {
 				struct page *head_page = compound_head(page);
-- 
2.21.0

