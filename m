Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50599698949
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Feb 2023 01:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBPAcS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Feb 2023 19:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBPAcR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Feb 2023 19:32:17 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D69842BCB;
        Wed, 15 Feb 2023 16:32:16 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id DCDEB20B96F1; Wed, 15 Feb 2023 16:32:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCDEB20B96F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1676507535;
        bh=v7pCRoeI7Z7YGxG0shsLcxNXnmdlouFyolFjYTL8FYQ=;
        h=From:To:Cc:Subject:Date:Reply-To:From;
        b=AWAtyx7VQobEjZFUefYPwIO7FBcnetDCjG8F78Q4lOoMJqNhUhhdpqRdxt29jizbO
         rD0Qfx7jmZBeZI+/QLSa2keb+Pgrj+sUW4WOyCN9Q82lUVOtT+IHEMawOQmbaCi4gv
         wS6OrZ3iSN1vJ9aXQggMWIoJgreRnHogI3FAEgqA=
From:   longli@linuxonhyperv.com
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>
Subject: [PATCH] RDMA/mana_ib: Fix a bug when the PF indicates more entries for registering memory on first packet
Date:   Wed, 15 Feb 2023 16:32:02 -0800
Message-Id: <1676507522-21018-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: longli@microsoft.com
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Long Li <longli@microsoft.com>

When registering memory in a large chunk that doesn't fit into a single PF
message, the PF may return GDMA_STATUS_MORE_ENTRIES on the first message if
there are more messages needed for registering more chunks.

Fix the VF to make it process the correct return code.

Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 8b3bc302d6f3..7be4c3adb4e2 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -249,7 +249,8 @@ static int
 mana_ib_gd_first_dma_region(struct mana_ib_dev *dev,
 			    struct gdma_context *gc,
 			    struct gdma_create_dma_region_req *create_req,
-			    size_t num_pages, mana_handle_t *gdma_region)
+			    size_t num_pages, mana_handle_t *gdma_region,
+			    u32 expected_status)
 {
 	struct gdma_create_dma_region_resp create_resp = {};
 	unsigned int create_req_msg_size;
@@ -261,7 +262,7 @@ mana_ib_gd_first_dma_region(struct mana_ib_dev *dev,
 
 	err = mana_gd_send_request(gc, create_req_msg_size, create_req,
 				   sizeof(create_resp), &create_resp);
-	if (err || create_resp.hdr.status) {
+	if (err || create_resp.hdr.status != expected_status) {
 		ibdev_dbg(&dev->ib_dev,
 			  "Failed to create DMA region: %d, 0x%x\n",
 			  err, create_resp.hdr.status);
@@ -372,14 +373,21 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 
 	page_addr_list = create_req->page_addr_list;
 	rdma_umem_for_each_dma_block(umem, &biter, page_sz) {
+		u32 expected_status = 0;
+
 		page_addr_list[tail++] = rdma_block_iter_dma_address(&biter);
 		if (tail < num_pages_to_handle)
 			continue;
 
+		if (num_pages_processed + num_pages_to_handle <
+		    num_pages_total)
+			expected_status = GDMA_STATUS_MORE_ENTRIES;
+
 		if (!num_pages_processed) {
 			/* First create message */
 			err = mana_ib_gd_first_dma_region(dev, gc, create_req,
-							  tail, gdma_region);
+							  tail, gdma_region,
+							  expected_status);
 			if (err)
 				goto out;
 
@@ -392,14 +400,8 @@ int mana_ib_gd_create_dma_region(struct mana_ib_dev *dev, struct ib_umem *umem,
 			page_addr_list = add_req->page_addr_list;
 		} else {
 			/* Subsequent create messages */
-			u32 expected_s = 0;
-
-			if (num_pages_processed + num_pages_to_handle <
-			    num_pages_total)
-				expected_s = GDMA_STATUS_MORE_ENTRIES;
-
 			err = mana_ib_gd_add_dma_region(dev, gc, add_req, tail,
-							expected_s);
+							expected_status);
 			if (err)
 				break;
 		}
-- 
2.17.1

