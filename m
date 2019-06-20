Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F18F4D336
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbfFTQOY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:14:24 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59446 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732134AbfFTQM5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:12:57 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg6-00046Q-68; Thu, 20 Jun 2019 10:12:54 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg4-0005wK-LN; Thu, 20 Jun 2019 10:12:44 -0600
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
Date:   Thu, 20 Jun 2019 10:12:21 -0600
Message-Id: <20190620161240.22738-10-logang@deltatee.com>
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
Subject: [RFC PATCH 09/28] block: Introduce vec_gap_to_prev()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce vec_gap_to_prev() which is a more general
form of bvec_gap_to_prev().

In order to support splitting dma_vecs we will need to do a similar
calcualtion using the DMA address and length.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 4142383eed7a..c5512fefe703 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -98,11 +98,19 @@ static inline bool dmavec_phys_mergeable(struct request_queue *q,
 				  vec2->dv_addr, vec2->dv_len);
 }
 
+static inline bool __vec_gap_to_prev(struct request_queue *q,
+		unsigned int prv_offset, unsigned int prv_len,
+		unsigned int nxt_offset)
+{
+	return (nxt_offset & queue_virt_boundary(q)) ||
+		((prv_offset + prv_len) & queue_virt_boundary(q));
+}
+
 static inline bool __bvec_gap_to_prev(struct request_queue *q,
 		struct bio_vec *bprv, unsigned int offset)
 {
-	return (offset & queue_virt_boundary(q)) ||
-		((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
+	return __vec_gap_to_prev(q, bprv->bv_offset, bprv->bv_len,
+				 offset);
 }
 
 /*
@@ -117,6 +125,15 @@ static inline bool bvec_gap_to_prev(struct request_queue *q,
 	return __bvec_gap_to_prev(q, bprv, offset);
 }
 
+static inline bool vec_gap_to_prev(struct request_queue *q,
+		unsigned int prv_offset, unsigned int prv_len,
+		unsigned int nxt_offset)
+{
+	if (!queue_virt_boundary(q))
+		return false;
+	return __vec_gap_to_prev(q, prv_offset, prv_len, nxt_offset);
+}
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
-- 
2.20.1

