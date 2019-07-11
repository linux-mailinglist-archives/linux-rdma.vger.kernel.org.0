Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D3165B96
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 18:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfGKQeT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 12:34:19 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.251]:35121 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbfGKQeT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Jul 2019 12:34:19 -0400
X-Greylist: delayed 1318 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jul 2019 12:34:18 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 4158DBD99
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 11:12:20 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id lbgChk4g290onlbgChf4w4; Thu, 11 Jul 2019 11:12:20 -0500
X-Authority-Reason: nr=8
Received: from cablelink-187-160-61-213.pcs.intercable.net ([187.160.61.213]:11787 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hlbgB-002TCu-9Q; Thu, 11 Jul 2019 11:12:19 -0500
Date:   Thu, 11 Jul 2019 11:12:18 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] RDMA/siw: Mark expected switch fall-throughs
Message-ID: <20190711161218.GA4989@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.160.61.213
X-Source-L: No
X-Exim-ID: 1hlbgB-002TCu-9Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-187-160-61-213.pcs.intercable.net (embeddedor) [187.160.61.213]:11787
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/infiniband/sw/siw/siw_qp_rx.c: In function ‘siw_rdmap_complete’:
drivers/infiniband/sw/siw/siw_qp_rx.c:1214:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
   wqe->rqe.flags |= SIW_WQE_SOLICITED;
   ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
drivers/infiniband/sw/siw/siw_qp_rx.c:1215:2: note: here
  case RDMAP_SEND:
  ^~~~

drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_qp_sq_process’:
drivers/infiniband/sw/siw/siw_qp_tx.c:1044:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
    siw_wqe_put_mem(wqe, tx_type);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/sw/siw/siw_qp_tx.c:1045:3: note: here
   case SIW_OP_INVAL_STAG:
   ^~~~
drivers/infiniband/sw/siw/siw_qp_tx.c:1128:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
    siw_wqe_put_mem(wqe, tx_type);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/sw/siw/siw_qp_tx.c:1129:3: note: here
   case SIW_OP_INVAL_STAG:
   ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---

NOTE: -Wimplicit-fallthrough will be enabled globally in v5.3. So, I
      suggest you to take this patch for 5.3-rc1.

 drivers/infiniband/sw/siw/siw_qp_rx.c | 2 ++
 drivers/infiniband/sw/siw/siw_qp_tx.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index 682a290bc11e..f87657a11657 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -1212,6 +1212,8 @@ static int siw_rdmap_complete(struct siw_qp *qp, int error)
 	case RDMAP_SEND_SE:
 	case RDMAP_SEND_SE_INVAL:
 		wqe->rqe.flags |= SIW_WQE_SOLICITED;
+		/* Fall through */
+
 	case RDMAP_SEND:
 	case RDMAP_SEND_INVAL:
 		if (wqe->wr_status == SIW_WR_IDLE)
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index f0d949e2e318..43020d2040fc 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -1042,6 +1042,8 @@ int siw_qp_sq_process(struct siw_qp *qp)
 		case SIW_OP_SEND_REMOTE_INV:
 		case SIW_OP_WRITE:
 			siw_wqe_put_mem(wqe, tx_type);
+			/* Fall through */
+
 		case SIW_OP_INVAL_STAG:
 		case SIW_OP_REG_MR:
 			if (tx_flags(wqe) & SIW_WQE_SIGNALLED)
@@ -1126,6 +1128,8 @@ int siw_qp_sq_process(struct siw_qp *qp)
 		case SIW_OP_READ:
 		case SIW_OP_READ_LOCAL_INV:
 			siw_wqe_put_mem(wqe, tx_type);
+			/* Fall through */
+
 		case SIW_OP_INVAL_STAG:
 		case SIW_OP_REG_MR:
 			siw_sqe_complete(qp, &wqe->sqe, wqe->bytes,
-- 
2.21.0

