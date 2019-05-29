Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B6A2E128
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 17:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfE2PeQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 May 2019 11:34:16 -0400
Received: from gateway21.websitewelcome.com ([192.185.46.109]:35558 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbfE2PeQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 May 2019 11:34:16 -0400
X-Greylist: delayed 1283 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 11:34:15 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 08BC8400F069E
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2019 10:12:52 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id W0G4hcgi4iQerW0G4hD8jJ; Wed, 29 May 2019 10:12:52 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=47380 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hW0G2-001J3u-VH; Wed, 29 May 2019 10:12:51 -0500
Date:   Wed, 29 May 2019 10:12:48 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] IB/rdmavt: Use struct_size() helper
Message-ID: <20190529151248.GA24080@embeddedor>
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
X-Exim-ID: 1hW0G2-001J3u-VH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:47380
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
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

sizeof(struct rvt_sge) * init_attr->cap.max_send_sge + sizeof(struct rvt_swqe)

with:

struct_size(swq, sg_list, init_attr->cap.max_send_sge)

and so on...

Also, notice that variable size is unnecessary, hence it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/infiniband/sw/rdmavt/qp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 31a2e65e4906..a60f5faea198 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -988,9 +988,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 	case IB_QPT_UC:
 	case IB_QPT_RC:
 	case IB_QPT_UD:
-		sz = sizeof(struct rvt_sge) *
-			init_attr->cap.max_send_sge +
-			sizeof(struct rvt_swqe);
+		sz = struct_size(swq, sg_list, init_attr->cap.max_send_sge);
 		swq = vzalloc_node(array_size(sz, sqsize), rdi->dparms.node);
 		if (!swq)
 			return ERR_PTR(-ENOMEM);
-- 
2.21.0

