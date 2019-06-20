Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF5754D2E8
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFTQMt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:12:49 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59328 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfFTQMs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:12:48 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg6-00046V-6A; Thu, 20 Jun 2019 10:12:47 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg5-0005wZ-4g; Thu, 20 Jun 2019 10:12:45 -0600
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
Date:   Thu, 20 Jun 2019 10:12:26 -0600
Message-Id: <20190620161240.22738-15-logang@deltatee.com>
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
Subject: [RFC PATCH 14/28] block: Support splitting dma-direct bios
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If the bio is a dma-direct bio, loop through the dma_vecs instead
of the bio_vecs when calling vec_should_split().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk-merge.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 32653fca53ce..c4c016f994f6 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -257,14 +257,44 @@ static bool vec_should_split(struct request_queue *q, unsigned offset,
 	return false;
 }
 
+static bool bio_should_split(struct request_queue *q, struct bio *bio,
+			     struct blk_segment_split_ctx *ctx)
+{
+	struct bvec_iter iter;
+	struct bio_vec bv;
+	bool ret;
+
+	bio_for_each_bvec(bv, bio, iter) {
+		ret = vec_should_split(q, bv.bv_offset, bv.bv_len, ctx);
+		if (ret)
+			return true;
+	}
+
+	return false;
+}
+
+static bool bio_dma_should_split(struct request_queue *q, struct bio *bio,
+				 struct blk_segment_split_ctx *ctx)
+{
+	struct bvec_iter iter;
+	struct dma_vec dv;
+	bool ret;
+
+	bio_for_each_dvec(dv, bio, iter) {
+		ret = vec_should_split(q, dv.dv_addr, dv.dv_len, ctx);
+		if (ret)
+			return true;
+	}
+
+	return false;
+}
+
 static struct bio *blk_bio_segment_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs,
 					 unsigned *segs)
 {
-	struct bio_vec bv;
-	struct bvec_iter iter;
-	bool do_split = false;
+	bool do_split;
 	struct bio *new = NULL;
 
 	struct blk_segment_split_ctx ctx = {
@@ -272,11 +302,10 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 		.max_segs = queue_max_segments(q),
 	};
 
-	bio_for_each_bvec(bv, bio, iter) {
-		do_split = vec_should_split(q, bv.bv_offset, bv.bv_len, &ctx);
-		if (do_split)
-			break;
-	}
+	if (bio_is_dma_direct(bio))
+		do_split = bio_dma_should_split(q, bio, &ctx);
+	else
+		do_split = bio_should_split(q, bio, &ctx);
 
 	*segs = ctx.nsegs;
 
-- 
2.20.1

