Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9A62E13C
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 17:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfE2PhA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 May 2019 11:37:00 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.239]:36798 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbfE2PhA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 May 2019 11:37:00 -0400
X-Greylist: delayed 1411 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 11:37:00 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 1FC7441407D
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2019 10:13:28 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id W0GehpKUz4FKpW0GehAY7M; Wed, 29 May 2019 10:13:28 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=47384 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hW0Gd-001JMv-1L; Wed, 29 May 2019 10:13:27 -0500
Date:   Wed, 29 May 2019 10:13:26 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] IB/qib: Use struct_size() helper
Message-ID: <20190529151326.GA24109@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hW0Gd-001JMv-1L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:47384
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace the following form:

sizeof(*pkt) + sizeof(pkt->addr[0])*n

with:

struct_size(pkt, addr, n)

Also, notice that variable size is unnecessary, hence it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/infiniband/hw/qib/qib_user_sdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
index 0c204776263f..97649f64e09e 100644
--- a/drivers/infiniband/hw/qib/qib_user_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
@@ -904,10 +904,11 @@ static int qib_user_sdma_queue_pkts(const struct qib_devdata *dd,
 		}
 
 		if (frag_size) {
-			int pktsize, tidsmsize, n;
+			int tidsmsize, n;
+			size_t pktsize;
 
 			n = npages*((2*PAGE_SIZE/frag_size)+1);
-			pktsize = sizeof(*pkt) + sizeof(pkt->addr[0])*n;
+			pktsize = struct_size(pkt, addr, n);
 
 			/*
 			 * Determine if this is tid-sdma or just sdma.
-- 
2.21.0

