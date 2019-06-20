Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD284D368
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbfFTQPH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:15:07 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59352 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbfFTQMv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:12:51 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg6-00046L-69; Thu, 20 Jun 2019 10:12:50 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg4-0005w5-65; Thu, 20 Jun 2019 10:12:44 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 20 Jun 2019 10:12:16 -0600
Message-Id: <20190620161240.22738-5-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190620161240.22738-1-logang@deltatee.com>
References: <20190620161240.22738-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, axboe@kernel.dk, hch@lst.de, bhelgaas@google.com, dan.j.williams@intel.com, sagi@grimberg.me, kbusch@kernel.org, jgg@ziepe.ca, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [RFC PATCH 04/28] block: Never bounce dma-direct bios
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It is expected the creator of the dma-direct bio will ensure the
target device can access the DMA address it's creating bios for.
It's also not possible to bounce a dma-direct bio seeing the block
layer doesn't have any way to access the underlying data behind
the DMA address.

Thus, never bounce dma-direct bios.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/bounce.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/bounce.c b/block/bounce.c
index f8ed677a1bf7..17e020a40cca 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -367,6 +367,14 @@ void blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
 	if (!bio_has_data(*bio_orig))
 		return;
 
+	/*
+	 * For DMA direct bios, Upper layers are expected to ensure
+	 * the device in question can access the DMA addresses. So
+	 * it never makes sense to bounce a DMA direct bio.
+	 */
+	if (bio_is_dma_direct(*bio_orig))
+		return;
+
 	/*
 	 * for non-isa bounce case, just check if the bounce pfn is equal
 	 * to or bigger than the highest pfn in the system -- in that case,
-- 
2.20.1

