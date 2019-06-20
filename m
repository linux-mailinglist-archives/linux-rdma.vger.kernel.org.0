Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB704D2F2
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbfFTQM7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:12:59 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59476 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732170AbfFTQM6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:12:58 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg6-00046P-68; Thu, 20 Jun 2019 10:12:57 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg4-0005wH-If; Thu, 20 Jun 2019 10:12:44 -0600
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
Date:   Thu, 20 Jun 2019 10:12:20 -0600
Message-Id: <20190620161240.22738-9-logang@deltatee.com>
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
Subject: [RFC PATCH 08/28] block: Introduce dmavec_phys_mergeable()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce a new helper which is an analog of biovec_phys_mergeable()
for dma-direct vectors.

This also provides a common helper vec_phys_mergeable() for use in
code that's general to both bio_vecs and dma_vecs.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk.h | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 7814aa207153..4142383eed7a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -66,20 +66,36 @@ static inline void blk_queue_enter_live(struct request_queue *q)
 	percpu_ref_get(&q->q_usage_counter);
 }
 
+static inline bool vec_phys_mergeable(struct request_queue *q,
+				      unsigned long addr1, unsigned int len1,
+				      unsigned long addr2, unsigned int len2)
+{
+	unsigned long mask = queue_segment_boundary(q);
+
+	if (addr1 + len1 != addr2)
+		return false;
+	if ((addr1 | mask) != ((addr2 + len2 - 1) | mask))
+		return false;
+	return true;
+}
+
 static inline bool biovec_phys_mergeable(struct request_queue *q,
 		struct bio_vec *vec1, struct bio_vec *vec2)
 {
-	unsigned long mask = queue_segment_boundary(q);
 	phys_addr_t addr1 = page_to_phys(vec1->bv_page) + vec1->bv_offset;
 	phys_addr_t addr2 = page_to_phys(vec2->bv_page) + vec2->bv_offset;
 
-	if (addr1 + vec1->bv_len != addr2)
-		return false;
 	if (xen_domain() && !xen_biovec_phys_mergeable(vec1, vec2->bv_page))
 		return false;
-	if ((addr1 | mask) != ((addr2 + vec2->bv_len - 1) | mask))
-		return false;
-	return true;
+
+	return vec_phys_mergeable(q, addr1, vec1->bv_len, addr2, vec2->bv_len);
+}
+
+static inline bool dmavec_phys_mergeable(struct request_queue *q,
+		struct dma_vec *vec1, struct dma_vec *vec2)
+{
+	return vec_phys_mergeable(q, vec1->dv_addr, vec1->dv_len,
+				  vec2->dv_addr, vec2->dv_len);
 }
 
 static inline bool __bvec_gap_to_prev(struct request_queue *q,
-- 
2.20.1

