Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47D641A34C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 00:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbhI0WvM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 18:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237934AbhI0WvM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Sep 2021 18:51:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67DB561058;
        Mon, 27 Sep 2021 22:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632782974;
        bh=oU6PdWNS+nBwKhjJCjhmDOzrVXmX+Fbx7QwmM4/qz1s=;
        h=Date:From:To:Cc:Subject:From;
        b=jZgCDR+7yLPoGTB6XHmcuKSrtRQoLRfmFBAB37WvF615AZQp86NJ1l3Blop8B2THs
         68xRVlBW5hwiNZ5/e1zT79aouujGV96OkuCySegTIE7bOAK/vxXLlPSttrqLV6w4L9
         z0ivsOJAgvAcgdVBPKAmjw3/a9Nld+sUR1NjF+kuLZmnIzwVQBnxounVTcsACe/mG8
         hEXGRVFJqQe8Yw58XQkE33zBHTSx3P0iS0QeYfVkE3Z5Ez6aC0Zli7Eppsuw+zZtnp
         DMgHHbyxGEdWCEI35BMtEmkTbTxPySTZoUCANsJ9QEUv/hjgqaKSD+PGxTJUxKUkwH
         tIqlrBTcXCd8w==
Date:   Mon, 27 Sep 2021 17:53:33 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] RDMA/hfi1: Use struct_size() and flex_array_size()
 helpers
Message-ID: <20210927225333.GA192634@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make use of the struct_size() and flex_array_size() helpers instead of
open-coded versions, in order to avoid any potential type mistakes
or integer overflows that, in the worse scenario, could lead to heap
overflows.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index 0c86e9d354f8..186d30291260 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -692,8 +692,7 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
 	 * Allocate the node first so we can handle a potential
 	 * failure before we've programmed anything.
 	 */
-	node = kzalloc(sizeof(*node) + (sizeof(struct page *) * npages),
-		       GFP_KERNEL);
+	node = kzalloc(struct_size(node, pages, npages), GFP_KERNEL);
 	if (!node)
 		return -ENOMEM;
 
@@ -713,7 +712,7 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
 	node->dma_addr = phys;
 	node->grp = grp;
 	node->freed = false;
-	memcpy(node->pages, pages, sizeof(struct page *) * npages);
+	memcpy(node->pages, pages, flex_array_size(node, pages, npages));
 
 	if (fd->use_mn) {
 		ret = mmu_interval_notifier_insert(
-- 
2.27.0

