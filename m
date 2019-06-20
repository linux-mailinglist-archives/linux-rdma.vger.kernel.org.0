Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8254D308
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbfFTQNT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:13:19 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59638 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732248AbfFTQNF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:13:05 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzgC-00046I-85; Thu, 20 Jun 2019 10:13:04 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg5-0005wu-S3; Thu, 20 Jun 2019 10:12:45 -0600
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
Date:   Thu, 20 Jun 2019 10:12:33 -0600
Message-Id: <20190620161240.22738-22-logang@deltatee.com>
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
Subject: [RFC PATCH 21/28] nvmet: Split nvmet_bdev_execute_rw() into a helper function
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move the mapping of the SG and submission of the bio
into a static helper function to reduce the complexity.

This will be useful in the next patch which submits dma-direct bios
for P2P requests.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 52 ++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 7a1cf6437a6a..061d40b020c7 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -103,13 +103,41 @@ static void nvmet_bio_done(struct bio *bio)
 		bio_put(bio);
 }
 
+static void nvmet_submit_sg(struct nvmet_req *req, struct bio *bio,
+			    sector_t sector)
+{
+	int sg_cnt = req->sg_cnt;
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(req->sg, sg, req->sg_cnt, i) {
+		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
+				!= sg->length) {
+			struct bio *prev = bio;
+
+			bio = bio_alloc(GFP_KERNEL,
+					min(sg_cnt, BIO_MAX_PAGES));
+			bio_set_dev(bio, req->ns->bdev);
+			bio->bi_iter.bi_sector = sector;
+			bio->bi_opf = prev->bi_opf;
+
+			bio_chain(bio, prev);
+			submit_bio(prev);
+		}
+
+		sector += sg->length >> 9;
+		sg_cnt--;
+	}
+
+	submit_bio(bio);
+}
+
 static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 {
 	int sg_cnt = req->sg_cnt;
 	struct bio *bio;
-	struct scatterlist *sg;
 	sector_t sector;
-	int op, op_flags = 0, i;
+	int op, op_flags = 0;
 
 	if (!req->sg_cnt) {
 		nvmet_req_complete(req, 0);
@@ -143,25 +171,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	bio->bi_end_io = nvmet_bio_done;
 	bio_set_op_attrs(bio, op, op_flags);
 
-	for_each_sg(req->sg, sg, req->sg_cnt, i) {
-		while (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
-				!= sg->length) {
-			struct bio *prev = bio;
-
-			bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
-			bio_set_dev(bio, req->ns->bdev);
-			bio->bi_iter.bi_sector = sector;
-			bio_set_op_attrs(bio, op, op_flags);
-
-			bio_chain(bio, prev);
-			submit_bio(prev);
-		}
-
-		sector += sg->length >> 9;
-		sg_cnt--;
-	}
-
-	submit_bio(bio);
+	nvmet_submit_sg(req, bio, sector);
 }
 
 static void nvmet_bdev_execute_flush(struct nvmet_req *req)
-- 
2.20.1

