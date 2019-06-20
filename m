Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABDD4D31B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbfFTQNz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:13:55 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59582 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732225AbfFTQNC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:13:02 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzgA-00046X-NP; Thu, 20 Jun 2019 10:13:01 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg5-0005wf-Aj; Thu, 20 Jun 2019 10:12:45 -0600
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
Date:   Thu, 20 Jun 2019 10:12:28 -0600
Message-Id: <20190620161240.22738-17-logang@deltatee.com>
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
Subject: [RFC PATCH 16/28] block: Implement mapping dma-direct requests to SGs in blk_rq_map_sg()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

blk_rq_map_sg() just needs to move the dma_vec into the dma_address
of the sgl. Callers will need to ensure not to call dma_map_sg()
for dma-direct requests.

This will likely get less ugly with Christoph's proposed cleanup
to the DMA API. It will be much simpler if devices are just
calling a dma_map_bio() and don't have to worry about dma-direct
requests.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk-merge.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index a7a5453987f9..ccd6c44b9f6e 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -545,6 +545,69 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 	return nsegs;
 }
 
+static unsigned blk_dvec_map_sg(struct request_queue *q,
+		struct dma_vec *dvec, struct scatterlist *sglist,
+		struct scatterlist **sg)
+{
+	unsigned nbytes = dvec->dv_len;
+	unsigned nsegs = 0, total = 0;
+
+	while (nbytes > 0) {
+		unsigned seg_size;
+
+		*sg = blk_next_sg(sg, sglist);
+
+		seg_size = get_max_segment_size(q, total);
+		seg_size = min(nbytes, seg_size);
+
+		(*sg)->dma_address = dvec->dv_addr + total;
+		sg_dma_len(*sg) = seg_size;
+
+		total += seg_size;
+		nbytes -= seg_size;
+		nsegs++;
+	}
+
+	return nsegs;
+}
+
+static inline void
+__blk_segment_dma_map_sg(struct request_queue *q, struct dma_vec *dvec,
+			 struct scatterlist *sglist, struct dma_vec *dvprv,
+			 struct scatterlist **sg, int *nsegs)
+{
+	int nbytes = dvec->dv_len;
+
+	if (*sg) {
+		if ((*sg)->length + nbytes > queue_max_segment_size(q))
+			goto new_segment;
+		if (!dmavec_phys_mergeable(q, dvprv, dvec))
+			goto new_segment;
+
+		(*sg)->length += nbytes;
+	} else {
+new_segment:
+		(*nsegs) += blk_dvec_map_sg(q, dvec, sglist, sg);
+	}
+	*dvprv = *dvec;
+}
+
+static int __blk_dma_bios_map_sg(struct request_queue *q, struct bio *bio,
+				 struct scatterlist *sglist,
+				 struct scatterlist **sg)
+{
+	struct dma_vec dvec, dvprv = {};
+	struct bvec_iter iter;
+	int nsegs = 0;
+
+	for_each_bio(bio)
+		bio_for_each_dvec(dvec, bio, iter)
+			__blk_segment_dma_map_sg(q, &dvec, sglist, &dvprv,
+						 sg, &nsegs);
+
+	return nsegs;
+}
+
 /*
  * map a request to scatterlist, return number of sg entries setup. Caller
  * must make sure sg can hold rq->nr_phys_segments entries
@@ -559,6 +622,8 @@ int blk_rq_map_sg(struct request_queue *q, struct request *rq,
 		nsegs = __blk_bvec_map_sg(rq->special_vec, sglist, &sg);
 	else if (rq->bio && bio_op(rq->bio) == REQ_OP_WRITE_SAME)
 		nsegs = __blk_bvec_map_sg(bio_iovec(rq->bio), sglist, &sg);
+	else if (blk_rq_is_dma_direct(rq))
+		nsegs = __blk_dma_bios_map_sg(q, rq->bio, sglist, &sg);
 	else if (rq->bio)
 		nsegs = __blk_bios_map_sg(q, rq->bio, sglist, &sg);
 
-- 
2.20.1

