Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B853AFCE9
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 08:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhFVGQl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 02:16:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:25148 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhFVGQl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 02:16:41 -0400
IronPort-SDR: 04FZbNjMBOOreiP3CNuzHXsD8xj+i4HlI4+oZIuVe6LUQ066Y/Q/T7wxVxHuoyJWeK5s98T4pg
 VK1aNyBmUcwA==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="187373703"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="187373703"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 23:14:25 -0700
IronPort-SDR: Ir+4ZlduStZgrjV86BlzGR1j2rSP/gVwinsIwzf8uS6DKa9u2BFNJr8pwmgAY7ZlpP/SEd2p5G
 mZ4K/f7QIlzw==
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="641551752"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 23:14:25 -0700
From:   ira.weiny@intel.com
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kheib@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] RDMA/hfi1: Remove use of kmap()
Date:   Mon, 21 Jun 2021 23:14:19 -0700
Message-Id: <20210622061422.2633501-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210622061422.2633501-1-ira.weiny@intel.com>
References: <20210622061422.2633501-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap() is being deprecated and will break uses of device dax after PKS
protection is introduced.[1]

The kmap() used in sdma does not need to be global.  Use the new
kmap_local_page() which works with PKS and may provide better
performance for this thread local mapping anyway.

[1] https://lore.kernel.org/lkml/20201009195033.3208459-59-ira.weiny@intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/infiniband/hw/hfi1/sdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 46b5290b2839..af43dcbb0928 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3130,7 +3130,7 @@ int ext_coal_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx,
 		}
 
 		if (type == SDMA_MAP_PAGE) {
-			kvaddr = kmap(page);
+			kvaddr = kmap_local_page(page);
 			kvaddr += offset;
 		} else if (WARN_ON(!kvaddr)) {
 			__sdma_txclean(dd, tx);
@@ -3140,7 +3140,7 @@ int ext_coal_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx,
 		memcpy(tx->coalesce_buf + tx->coalesce_idx, kvaddr, len);
 		tx->coalesce_idx += len;
 		if (type == SDMA_MAP_PAGE)
-			kunmap(page);
+			kunmap_local(kvaddr);
 
 		/* If there is more data, return */
 		if (tx->tlen - tx->coalesce_idx)
-- 
2.28.0.rc0.12.gb6a658bd00c9

