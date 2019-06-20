Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 079C94D32F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbfFTQOO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:14:14 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59490 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732175AbfFTQM6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:12:58 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzgA-00046T-NQ; Thu, 20 Jun 2019 10:12:57 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg4-0005wT-V5; Thu, 20 Jun 2019 10:12:44 -0600
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
Date:   Thu, 20 Jun 2019 10:12:24 -0600
Message-Id: <20190620161240.22738-13-logang@deltatee.com>
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
Subject: [RFC PATCH 12/28] block: Create helper for bvec_should_split()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to support dma-direct bios, blk_bio_segment_split() will
need to operate on both bio_vecs and dma_vecs. In order to do
this, the code inside bio_for_each_bvec() is moved into a generic
helper called bvec_should_split().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk-merge.c | 86 +++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 40 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 414e61a714bf..d9e89c0ad40d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -212,6 +212,48 @@ struct blk_segment_split_ctx {
 	const unsigned max_segs;
 };
 
+static bool bvec_should_split(struct request_queue *q, struct bio_vec *bv,
+			      struct blk_segment_split_ctx *ctx)
+{
+	/*
+	 * If the queue doesn't support SG gaps and adding this
+	 * offset would create a gap, disallow it.
+	 */
+	if (ctx->prv_valid && bvec_gap_to_prev(q, &ctx->bvprv, bv->bv_offset))
+		return true;
+
+	if (ctx->sectors + (bv->bv_len >> 9) > ctx->max_sectors) {
+		/*
+		 * Consider this a new segment if we're splitting in
+		 * the middle of this vector.
+		 */
+		if (ctx->nsegs < ctx->max_segs &&
+		    ctx->sectors < ctx->max_sectors) {
+			/* split in the middle of bvec */
+			bv->bv_len = (ctx->max_sectors - ctx->sectors) << 9;
+			bvec_split_segs(q, bv, &ctx->nsegs,
+					&ctx->sectors, ctx->max_segs);
+		}
+		return true;
+	}
+
+	if (ctx->nsegs == ctx->max_segs)
+		return true;
+
+	ctx->bvprv = *bv;
+	ctx->prv_valid = true;
+
+	if (bv->bv_offset + bv->bv_len <= PAGE_SIZE) {
+		ctx->nsegs++;
+		ctx->sectors += bv->bv_len >> 9;
+	} else if (bvec_split_segs(q, bv, &ctx->nsegs, &ctx->sectors,
+				   ctx->max_segs)) {
+		return true;
+	}
+
+	return false;
+}
+
 static struct bio *blk_bio_segment_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs,
@@ -219,7 +261,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 {
 	struct bio_vec bv;
 	struct bvec_iter iter;
-	bool do_split = true;
+	bool do_split = false;
 	struct bio *new = NULL;
 
 	struct blk_segment_split_ctx ctx = {
@@ -228,47 +270,11 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	};
 
 	bio_for_each_bvec(bv, bio, iter) {
-		/*
-		 * If the queue doesn't support SG gaps and adding this
-		 * offset would create a gap, disallow it.
-		 */
-		if (ctx.prv_valid && bvec_gap_to_prev(q, &ctx.bvprv,
-						      bv.bv_offset))
-			goto split;
-
-		if (ctx.sectors + (bv.bv_len >> 9) > ctx.max_sectors) {
-			/*
-			 * Consider this a new segment if we're splitting in
-			 * the middle of this vector.
-			 */
-			if (ctx.nsegs < ctx.max_segs &&
-			    ctx.sectors < ctx.max_sectors) {
-				/* split in the middle of bvec */
-				bv.bv_len =
-					(ctx.max_sectors - ctx.sectors) << 9;
-				bvec_split_segs(q, &bv, &ctx.nsegs,
-						&ctx.sectors, ctx.max_segs);
-			}
-			goto split;
-		}
-
-		if (ctx.nsegs == ctx.max_segs)
-			goto split;
-
-		ctx.bvprv = bv;
-		ctx.prv_valid = true;
-
-		if (bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
-			ctx.nsegs++;
-			ctx.sectors += bv.bv_len >> 9;
-		} else if (bvec_split_segs(q, &bv, &ctx.nsegs, &ctx.sectors,
-				ctx.max_segs)) {
-			goto split;
-		}
+		do_split = bvec_should_split(q, &bv, &ctx);
+		if (do_split)
+			break;
 	}
 
-	do_split = false;
-split:
 	*segs = ctx.nsegs;
 
 	if (do_split) {
-- 
2.20.1

