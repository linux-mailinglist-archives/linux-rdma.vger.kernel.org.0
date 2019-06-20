Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D10C4D344
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbfFTQOk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:14:40 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59438 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732122AbfFTQM4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:12:56 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg6-00046U-6A; Thu, 20 Jun 2019 10:12:53 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg5-0005wW-1p; Thu, 20 Jun 2019 10:12:45 -0600
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
Date:   Thu, 20 Jun 2019 10:12:25 -0600
Message-Id: <20190620161240.22738-14-logang@deltatee.com>
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
Subject: [RFC PATCH 13/28] block: Generalize bvec_should_split()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

bvec_should_split() will need to also operate on dma_vecs so
generalize it to take an offset and length instead of a bio_vec.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk-merge.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index d9e89c0ad40d..32653fca53ce 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -206,23 +206,25 @@ struct blk_segment_split_ctx {
 	unsigned sectors;
 
 	bool prv_valid;
-	struct bio_vec bvprv;
+	unsigned prv_offset;
+	unsigned prv_len;
 
 	const unsigned max_sectors;
 	const unsigned max_segs;
 };
 
-static bool bvec_should_split(struct request_queue *q, struct bio_vec *bv,
-			      struct blk_segment_split_ctx *ctx)
+static bool vec_should_split(struct request_queue *q, unsigned offset,
+			     unsigned len, struct blk_segment_split_ctx *ctx)
 {
 	/*
 	 * If the queue doesn't support SG gaps and adding this
 	 * offset would create a gap, disallow it.
 	 */
-	if (ctx->prv_valid && bvec_gap_to_prev(q, &ctx->bvprv, bv->bv_offset))
+	if (ctx->prv_valid &&
+	    vec_gap_to_prev(q, ctx->prv_offset, ctx->prv_len, offset))
 		return true;
 
-	if (ctx->sectors + (bv->bv_len >> 9) > ctx->max_sectors) {
+	if (ctx->sectors + (len >> 9) > ctx->max_sectors) {
 		/*
 		 * Consider this a new segment if we're splitting in
 		 * the middle of this vector.
@@ -230,9 +232,9 @@ static bool bvec_should_split(struct request_queue *q, struct bio_vec *bv,
 		if (ctx->nsegs < ctx->max_segs &&
 		    ctx->sectors < ctx->max_sectors) {
 			/* split in the middle of bvec */
-			bv->bv_len = (ctx->max_sectors - ctx->sectors) << 9;
-			bvec_split_segs(q, bv, &ctx->nsegs,
-					&ctx->sectors, ctx->max_segs);
+			len = (ctx->max_sectors - ctx->sectors) << 9;
+			vec_split_segs(q, offset, len, &ctx->nsegs,
+				       &ctx->sectors, ctx->max_segs);
 		}
 		return true;
 	}
@@ -240,14 +242,15 @@ static bool bvec_should_split(struct request_queue *q, struct bio_vec *bv,
 	if (ctx->nsegs == ctx->max_segs)
 		return true;
 
-	ctx->bvprv = *bv;
+	ctx->prv_offset = offset;
+	ctx->prv_len = len;
 	ctx->prv_valid = true;
 
-	if (bv->bv_offset + bv->bv_len <= PAGE_SIZE) {
+	if (offset + len <= PAGE_SIZE) {
 		ctx->nsegs++;
-		ctx->sectors += bv->bv_len >> 9;
-	} else if (bvec_split_segs(q, bv, &ctx->nsegs, &ctx->sectors,
-				   ctx->max_segs)) {
+		ctx->sectors += len >> 9;
+	} else if (vec_split_segs(q, offset, len, &ctx->nsegs, &ctx->sectors,
+				  ctx->max_segs)) {
 		return true;
 	}
 
@@ -270,7 +273,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	};
 
 	bio_for_each_bvec(bv, bio, iter) {
-		do_split = bvec_should_split(q, &bv, &ctx);
+		do_split = vec_should_split(q, bv.bv_offset, bv.bv_len, &ctx);
 		if (do_split)
 			break;
 	}
-- 
2.20.1

