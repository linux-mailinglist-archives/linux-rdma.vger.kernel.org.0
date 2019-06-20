Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F824D2F9
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbfFTQNG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:13:06 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59672 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732170AbfFTQNG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:13:06 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzgA-00046Z-NW; Thu, 20 Jun 2019 10:13:05 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg5-0005wl-Hn; Thu, 20 Jun 2019 10:12:45 -0600
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
Date:   Thu, 20 Jun 2019 10:12:30 -0600
Message-Id: <20190620161240.22738-19-logang@deltatee.com>
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
Subject: [RFC PATCH 18/28] block: Introduce bio_add_dma_addr()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

bio_add_dma_addr() is analagous to bio_add_page() except it
adds a dma address to a dma-direct bio instead of a struct page.

It also checks to ensure that the queue supports dma address bios and
that we are not mixing dma addresses and struct pages.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/bio.c         | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/bio.h | 10 ++++++++++
 2 files changed, 48 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 6998fceddd36..02ae72e3ccfa 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -874,6 +874,44 @@ static void bio_release_pages(struct bio *bio)
 		put_page(bvec->bv_page);
 }
 
+/**
+ *	bio_add_dma_addr - attempt to add a dma address to a bio
+ *	@q: the target queue
+ *	@bio: destination bio
+ *	@dma_addr: dma address to add
+ *	@len: vec entry length
+ *
+ *	Attempt to add a dma address to the dma_vec maplist. This can
+ *	fail for a number of reasons, such as the bio being full or
+ *	target block device limitations. The target request queue must
+ *	support dma-only bios and bios can not mix pages and dma_addresses.
+ */
+int bio_add_dma_addr(struct request_queue *q, struct bio *bio,
+		     dma_addr_t dma_addr, unsigned int len)
+{
+	struct dma_vec *dv = &bio->bi_dma_vec[bio->bi_vcnt];
+
+	if (!blk_queue_dma_direct(q))
+		return -EINVAL;
+
+	if (!bio_is_dma_direct(bio))
+		return -EINVAL;
+
+	if (bio_dma_full(bio))
+		return 0;
+
+	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
+
+	dv->dv_addr = dma_addr;
+	dv->dv_len = len;
+
+	bio->bi_iter.bi_size += len;
+	bio->bi_vcnt++;
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(bio_add_dma_addr);
+
 static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 {
 	const struct bio_vec *bv = iter->bvec;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index df7973932525..d775f381ae00 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -112,6 +112,13 @@ static inline bool bio_full(struct bio *bio)
 	return bio->bi_vcnt >= bio->bi_max_vecs;
 }
 
+static inline bool bio_dma_full(struct bio *bio)
+{
+	size_t vec_size = bio->bi_max_vecs * sizeof(struct bio_vec);
+
+	return bio->bi_vcnt >= (vec_size / sizeof(struct dma_vec));
+}
+
 static inline bool bio_next_segment(const struct bio *bio,
 				    struct bvec_iter_all *iter)
 {
@@ -438,6 +445,9 @@ void bio_chain(struct bio *, struct bio *);
 extern int bio_add_page(struct bio *, struct page *, unsigned int,unsigned int);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
+extern int bio_add_dma_addr(struct request_queue *q, struct bio *bio,
+			    dma_addr_t dma_addr, unsigned int len);
+
 bool __bio_try_merge_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off, bool same_page);
 void __bio_add_page(struct bio *bio, struct page *page,
-- 
2.20.1

