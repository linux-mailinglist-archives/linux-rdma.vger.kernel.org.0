Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E264D33F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbfFTQOZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:14:25 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59460 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732139AbfFTQM5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:12:57 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzgA-00046R-AF; Thu, 20 Jun 2019 10:12:56 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg4-0005wN-Oc; Thu, 20 Jun 2019 10:12:44 -0600
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
Date:   Thu, 20 Jun 2019 10:12:22 -0600
Message-Id: <20190620161240.22738-11-logang@deltatee.com>
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
Subject: [RFC PATCH 10/28] block: Create generic vec_split_segs() from bvec_split_segs()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

bvec_split_segs() only requires the address and length of the
vector. In order to generalize it to work with dma_vecs, we just
take the address and length directly instead of the bio_vec.

The function is renamed to vec_split_segs() and a helper is added
to avoid having to adjust the existing callsites.

Note: the new bvec_split_segs() helper will be removed in a subsequent
patch.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk-merge.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 17713d7d98d5..3581c7ac3c1b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -158,13 +158,13 @@ static unsigned get_max_segment_size(struct request_queue *q,
 }
 
 /*
- * Split the bvec @bv into segments, and update all kinds of
- * variables.
+ * Split the an address/offset and length into segments, and
+ * update all kinds of variables.
  */
-static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
-		unsigned *nsegs, unsigned *sectors, unsigned max_segs)
+static bool vec_split_segs(struct request_queue *q, unsigned offset,
+			   unsigned len, unsigned *nsegs, unsigned *sectors,
+			   unsigned max_segs)
 {
-	unsigned len = bv->bv_len;
 	unsigned total_len = 0;
 	unsigned new_nsegs = 0, seg_size = 0;
 
@@ -173,14 +173,14 @@ static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
 	 * current bvec has to be splitted as multiple segments.
 	 */
 	while (len && new_nsegs + *nsegs < max_segs) {
-		seg_size = get_max_segment_size(q, bv->bv_offset + total_len);
+		seg_size = get_max_segment_size(q, offset + total_len);
 		seg_size = min(seg_size, len);
 
 		new_nsegs++;
 		total_len += seg_size;
 		len -= seg_size;
 
-		if ((bv->bv_offset + total_len) & queue_virt_boundary(q))
+		if ((offset + total_len) & queue_virt_boundary(q))
 			break;
 	}
 
@@ -194,6 +194,13 @@ static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
 	return !!len;
 }
 
+static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
+		unsigned *nsegs, unsigned *sectors, unsigned max_segs)
+{
+	return vec_split_segs(q, bv->bv_offset, bv->bv_len, nsegs,
+			      sectors, max_segs);
+}
+
 static struct bio *blk_bio_segment_split(struct request_queue *q,
 					 struct bio *bio,
 					 struct bio_set *bs,
-- 
2.20.1

