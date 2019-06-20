Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 748284D31A
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbfFTQNC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:13:02 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59544 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732211AbfFTQNB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:13:01 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg6-00046S-68; Thu, 20 Jun 2019 10:12:59 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg4-0005wQ-RP; Thu, 20 Jun 2019 10:12:44 -0600
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
Date:   Thu, 20 Jun 2019 10:12:23 -0600
Message-Id: <20190620161240.22738-12-logang@deltatee.com>
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
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=unavailable
        autolearn_force=no version=3.4.2
Subject: [RFC PATCH 11/28] block: Create blk_segment_split_ctx
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to support dma-direct bios, blk_bio_segment_split() will
need to operate on both bio_vecs and dma_vecs. In order to do
this the code inside bio_for_each_bvec() needs to be moved into
a generic helper. Step one to do this is to put some of the
variables used inside the loop into a context structure so we
don't need to pass a dozen variables to this new function.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk-merge.c | 55 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3581c7ac3c1b..414e61a714bf 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -201,63 +201,78 @@ static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
 			      sectors, max_segs);
 }
 
+struct blk_segment_split_ctx {
+	unsigned nsegs;
+	unsigned sectors;
+
+	bool prv_valid;
+	struct bio_vec bvprv;
+
+	const unsigned max_sectors;
+	const unsigned max_segs;
+};
+
 static struct bio *blk_bio_segment_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs,
 					 unsigned *segs)
 {
-	struct bio_vec bv, bvprv, *bvprvp = NULL;
+	struct bio_vec bv;
 	struct bvec_iter iter;
-	unsigned nsegs = 0, sectors = 0;
 	bool do_split = true;
 	struct bio *new = NULL;
-	const unsigned max_sectors = get_max_io_size(q, bio);
-	const unsigned max_segs = queue_max_segments(q);
+
+	struct blk_segment_split_ctx ctx = {
+		.max_sectors = get_max_io_size(q, bio),
+		.max_segs = queue_max_segments(q),
+	};
 
 	bio_for_each_bvec(bv, bio, iter) {
 		/*
 		 * If the queue doesn't support SG gaps and adding this
 		 * offset would create a gap, disallow it.
 		 */
-		if (bvprvp && bvec_gap_to_prev(q, bvprvp, bv.bv_offset))
+		if (ctx.prv_valid && bvec_gap_to_prev(q, &ctx.bvprv,
+						      bv.bv_offset))
 			goto split;
 
-		if (sectors + (bv.bv_len >> 9) > max_sectors) {
+		if (ctx.sectors + (bv.bv_len >> 9) > ctx.max_sectors) {
 			/*
 			 * Consider this a new segment if we're splitting in
 			 * the middle of this vector.
 			 */
-			if (nsegs < max_segs &&
-			    sectors < max_sectors) {
+			if (ctx.nsegs < ctx.max_segs &&
+			    ctx.sectors < ctx.max_sectors) {
 				/* split in the middle of bvec */
-				bv.bv_len = (max_sectors - sectors) << 9;
-				bvec_split_segs(q, &bv, &nsegs,
-						&sectors, max_segs);
+				bv.bv_len =
+					(ctx.max_sectors - ctx.sectors) << 9;
+				bvec_split_segs(q, &bv, &ctx.nsegs,
+						&ctx.sectors, ctx.max_segs);
 			}
 			goto split;
 		}
 
-		if (nsegs == max_segs)
+		if (ctx.nsegs == ctx.max_segs)
 			goto split;
 
-		bvprv = bv;
-		bvprvp = &bvprv;
+		ctx.bvprv = bv;
+		ctx.prv_valid = true;
 
 		if (bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
-			nsegs++;
-			sectors += bv.bv_len >> 9;
-		} else if (bvec_split_segs(q, &bv, &nsegs, &sectors,
-				max_segs)) {
+			ctx.nsegs++;
+			ctx.sectors += bv.bv_len >> 9;
+		} else if (bvec_split_segs(q, &bv, &ctx.nsegs, &ctx.sectors,
+				ctx.max_segs)) {
 			goto split;
 		}
 	}
 
 	do_split = false;
 split:
-	*segs = nsegs;
+	*segs = ctx.nsegs;
 
 	if (do_split) {
-		new = bio_split(bio, sectors, GFP_NOIO, bs);
+		new = bio_split(bio, ctx.sectors, GFP_NOIO, bs);
 		if (new)
 			bio = new;
 	}
-- 
2.20.1

