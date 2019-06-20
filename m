Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB9054D35B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbfFTQO7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:14:59 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59378 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731870AbfFTQMw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:12:52 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg6-00046K-69; Thu, 20 Jun 2019 10:12:51 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg4-0005w2-39; Thu, 20 Jun 2019 10:12:44 -0600
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
Date:   Thu, 20 Jun 2019 10:12:15 -0600
Message-Id: <20190620161240.22738-4-logang@deltatee.com>
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
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [RFC PATCH 03/28] block: Warn on mis-use of dma-direct bios
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a result of an audit of users of 'bi_io_vec'. A number of
warnings and blocking conditions are added to ensure dma-direct bios
are not incorrectly accessing the 'bi_io_vec' when they should access
the 'bi_dma_vec'. These are largely just protecting against mis-uses
in future development so depending on taste and public opinion some
or all of these checks may not be necessary.

A few other issues with dma-direct bios will be tackled in subsequent
patches.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/bio.c      | 33 +++++++++++++++++++++++++++++++++
 block/blk-core.c |  3 +++
 2 files changed, 36 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 683cbb40f051..6998fceddd36 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -525,6 +525,9 @@ void zero_fill_bio_iter(struct bio *bio, struct bvec_iter start)
 	struct bio_vec bv;
 	struct bvec_iter iter;
 
+	if (WARN_ON_ONCE(bio_is_dma_direct(bio)))
+		return;
+
 	__bio_for_each_segment(bv, bio, iter, start) {
 		char *data = bvec_kmap_irq(&bv, &flags);
 		memset(data, 0, bv.bv_len);
@@ -707,6 +710,8 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 	 */
 	if (unlikely(bio_flagged(bio, BIO_CLONED)))
 		return 0;
+	if (unlikely(bio_is_dma_direct(bio)))
+		return 0;
 
 	if (((bio->bi_iter.bi_size + len) >> 9) > queue_max_hw_sectors(q))
 		return 0;
@@ -783,6 +788,8 @@ bool __bio_try_merge_page(struct bio *bio, struct page *page,
 {
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return false;
+	if (WARN_ON_ONCE(bio_is_dma_direct(bio)))
+		return false;
 
 	if (bio->bi_vcnt > 0) {
 		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
@@ -814,6 +821,7 @@ void __bio_add_page(struct bio *bio, struct page *page,
 
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
 	WARN_ON_ONCE(bio_full(bio));
+	WARN_ON_ONCE(bio_is_dma_direct(bio));
 
 	bv->bv_page = page;
 	bv->bv_offset = off;
@@ -851,6 +859,8 @@ static void bio_get_pages(struct bio *bio)
 	struct bvec_iter_all iter_all;
 	struct bio_vec *bvec;
 
+	WARN_ON_ONCE(bio_is_dma_direct(bio));
+
 	bio_for_each_segment_all(bvec, bio, iter_all)
 		get_page(bvec->bv_page);
 }
@@ -956,6 +966,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	if (WARN_ON_ONCE(bio->bi_vcnt))
 		return -EINVAL;
+	if (WARN_ON_ONCE(bio_is_dma_direct(bio)))
+		return -EINVAL;
 
 	do {
 		if (is_bvec)
@@ -1029,6 +1041,9 @@ void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 	void *src_p, *dst_p;
 	unsigned bytes;
 
+	if (WARN_ON_ONCE(bio_is_dma_direct(src) || bio_is_dma_direct(dst)))
+		return;
+
 	while (src_iter->bi_size && dst_iter->bi_size) {
 		src_bv = bio_iter_iovec(src, *src_iter);
 		dst_bv = bio_iter_iovec(dst, *dst_iter);
@@ -1143,6 +1158,9 @@ static int bio_copy_from_iter(struct bio *bio, struct iov_iter *iter)
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
+	if (WARN_ON_ONCE(bio_is_dma_direct(bio)))
+		return -EINVAL;
+
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		ssize_t ret;
 
@@ -1174,6 +1192,9 @@ static int bio_copy_to_iter(struct bio *bio, struct iov_iter iter)
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
+	if (WARN_ON_ONCE(bio_is_dma_direct(bio)))
+		return -EINVAL;
+
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		ssize_t ret;
 
@@ -1197,6 +1218,9 @@ void bio_free_pages(struct bio *bio)
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
+	if (WARN_ON_ONCE(bio_is_dma_direct(bio)))
+		return;
+
 	bio_for_each_segment_all(bvec, bio, iter_all)
 		__free_page(bvec->bv_page);
 }
@@ -1653,6 +1677,9 @@ void bio_set_pages_dirty(struct bio *bio)
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 
+	if (unlikely(bio_is_dma_direct(bio)))
+		return;
+
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (!PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
@@ -1704,6 +1731,9 @@ void bio_check_pages_dirty(struct bio *bio)
 	unsigned long flags;
 	struct bvec_iter_all iter_all;
 
+	if (unlikely(bio_is_dma_direct(bio)))
+		return;
+
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
 			goto defer;
@@ -1777,6 +1807,9 @@ void bio_flush_dcache_pages(struct bio *bi)
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 
+	if (unlikely(bio_is_dma_direct(bi)))
+		return;
+
 	bio_for_each_segment(bvec, bi, iter)
 		flush_dcache_page(bvec.bv_page);
 }
diff --git a/block/blk-core.c b/block/blk-core.c
index 8340f69670d8..ea152d54c7ce 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1467,6 +1467,9 @@ void rq_flush_dcache_pages(struct request *rq)
 	struct req_iterator iter;
 	struct bio_vec bvec;
 
+	if (unlikely(blk_rq_is_dma_direct(rq)))
+		return;
+
 	rq_for_each_segment(bvec, rq, iter)
 		flush_dcache_page(bvec.bv_page);
 }
-- 
2.20.1

