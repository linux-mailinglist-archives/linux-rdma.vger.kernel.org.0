Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3674D367
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbfFTQPG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:15:06 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59350 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbfFTQMv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:12:51 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg6-00046W-67; Thu, 20 Jun 2019 10:12:49 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg5-0005wc-82; Thu, 20 Jun 2019 10:12:45 -0600
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
Date:   Thu, 20 Jun 2019 10:12:27 -0600
Message-Id: <20190620161240.22738-16-logang@deltatee.com>
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
Subject: [RFC PATCH 15/28] block: Support counting dma-direct bio segments
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Change __blk_recalc_rq_segments() to loop through dma_vecs when
appropriate. It calls vec_split_segs() for each dma_vec or bio_vec.

Once this is done the bvec_split_segs() helper is no longer used.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk-merge.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index c4c016f994f6..a7a5453987f9 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -194,13 +194,6 @@ static bool vec_split_segs(struct request_queue *q, unsigned offset,
 	return !!len;
 }
 
-static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
-		unsigned *nsegs, unsigned *sectors, unsigned max_segs)
-{
-	return vec_split_segs(q, bv->bv_offset, bv->bv_len, nsegs,
-			      sectors, max_segs);
-}
-
 struct blk_segment_split_ctx {
 	unsigned nsegs;
 	unsigned sectors;
@@ -366,12 +359,36 @@ void blk_queue_split(struct request_queue *q, struct bio **bio)
 }
 EXPORT_SYMBOL(blk_queue_split);
 
+static unsigned int bio_calc_segs(struct request_queue *q, struct bio *bio)
+{
+	unsigned int nsegs = 0;
+	struct bvec_iter iter;
+	struct bio_vec bv;
+
+	bio_for_each_bvec(bv, bio, iter)
+		vec_split_segs(q, bv.bv_offset, bv.bv_len, &nsegs,
+			       NULL, UINT_MAX);
+
+	return nsegs;
+}
+
+static unsigned int bio_dma_calc_segs(struct request_queue *q, struct bio *bio)
+{
+	unsigned int nsegs = 0;
+	struct bvec_iter iter;
+	struct dma_vec dv;
+
+	bio_for_each_dvec(dv, bio, iter)
+		vec_split_segs(q, dv.dv_addr, dv.dv_len, &nsegs,
+			       NULL, UINT_MAX);
+
+	return nsegs;
+}
+
 static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 					     struct bio *bio)
 {
 	unsigned int nr_phys_segs = 0;
-	struct bvec_iter iter;
-	struct bio_vec bv;
 
 	if (!bio)
 		return 0;
@@ -386,8 +403,10 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
 	}
 
 	for_each_bio(bio) {
-		bio_for_each_bvec(bv, bio, iter)
-			bvec_split_segs(q, &bv, &nr_phys_segs, NULL, UINT_MAX);
+		if (bio_is_dma_direct(bio))
+			nr_phys_segs += bio_calc_segs(q, bio);
+		else
+			nr_phys_segs += bio_dma_calc_segs(q, bio);
 	}
 
 	return nr_phys_segs;
-- 
2.20.1

