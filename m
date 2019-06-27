Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E535844F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 16:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfF0OPR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 10:15:17 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:57150 "EHLO edge10.ethz.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfF0OPR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jun 2019 10:15:17 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jun 2019 10:15:14 EDT
Received: from mailm214.d.ethz.ch (129.132.139.38) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 27 Jun
 2019 16:06:57 +0200
Received: from ktaranov-laptop.wifi.oracle.com (209.17.40.23) by
 mailm214.d.ethz.ch (2001:67c:10ec:5603::28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Jun 2019 16:07:02 +0200
From:   Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
To:     <monis@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>,
        Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
Subject: [PATCH] Make rxe driver to calculate correct byte_len on receiving side when work completion is generated with IB_WC_RECV_RDMA_WITH_IMM opcode.
Date:   Thu, 27 Jun 2019 16:06:43 +0200
Message-ID: <20190627140643.6191-1-konstantin.taranov@inf.ethz.ch>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [209.17.40.23]
X-ClientProxiedBy: mailm113.d.ethz.ch (2001:67c:10ec:5602::25) To
 mailm214.d.ethz.ch (2001:67c:10ec:5603::28)
X-TM-SNTS-SMTP: 71F0F69EFD8D260647BE368A89C5D9FC1E9D3BBB6B0511BCEDD71816AF0D984A2000:8
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make softRoce to calculate correct byte_len on receiving side when work completion
is generated with IB_WC_RECV_RDMA_WITH_IMM opcode.

According to documentation byte_len must indicate the number of written
bytes, whereas it was always equal to zero for IB_WC_RECV_RDMA_WITH_IMM opcode.

The patch proposes to remember the length of an RDMA request from the RETH header, and use it 
as byte_len when the work completion with IB_WC_RECV_RDMA_WITH_IMM opcode is generated.

Signed-off-by: Konstantin Taranov <konstantin.taranov@inf.ethz.ch>
---
 drivers/infiniband/sw/rxe/rxe_resp.c  | 5 ++++-
 drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index aca9f60f9b21..1cbfbd98eb22 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -431,6 +431,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 			qp->resp.va = reth_va(pkt);
 			qp->resp.rkey = reth_rkey(pkt);
 			qp->resp.resid = reth_len(pkt);
+			qp->resp.length = reth_len(pkt);
 		}
 		access = (pkt->mask & RXE_READ_MASK) ? IB_ACCESS_REMOTE_READ
 						     : IB_ACCESS_REMOTE_WRITE;
@@ -856,7 +857,9 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 				pkt->mask & RXE_WRITE_MASK) ?
 					IB_WC_RECV_RDMA_WITH_IMM : IB_WC_RECV;
 		wc->vendor_err = 0;
-		wc->byte_len = wqe->dma.length - wqe->dma.resid;
+		wc->byte_len = (pkt->mask & RXE_IMMDT_MASK &&
+				pkt->mask & RXE_WRITE_MASK) ?
+					qp->resp.length : wqe->dma.length - wqe->dma.resid;
 
 		/* fields after byte_len are different between kernel and user
 		 * space
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index e8be7f44e3be..28bfb3ece104 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -213,6 +213,7 @@ struct rxe_resp_info {
 	struct rxe_mem		*mr;
 	u32			resid;
 	u32			rkey;
+	u32			length;
 	u64			atomic_orig;
 
 	/* SRQ only */
-- 
2.17.1

