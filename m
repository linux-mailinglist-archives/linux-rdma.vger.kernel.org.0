Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4454D7BE74
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 12:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387656AbfGaKdu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 06:33:50 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:26186 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfGaKdu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 06:33:50 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x6VAXjSj021431;
        Wed, 31 Jul 2019 03:33:47 -0700
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     jgg@ziepe.ca, bmt@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com, krishn2@chelsio.com,
        Krishnamraju Eraparaju <krishna2@chelsio.com>
Subject: [PATCH for-rc] siw: MPA Reply handler tries to read beyond MPA message
Date:   Wed, 31 Jul 2019 16:03:10 +0530
Message-Id: <20190731103310.23199-1-krishna2@chelsio.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

while processing MPA Reply, SIW driver is trying to read extra 4 bytes
than what peer has advertised as private data length.

If a FPDU data is received before even siw_recv_mpa_rr() completed
reading MPA reply, then ksock_recv() in siw_recv_mpa_rr() could also
read FPDU, if "size" is larger than advertised MPA reply length.

 501 static int siw_recv_mpa_rr(struct siw_cep *cep)
 502 {
          .............
 572
 573         if (rcvd > to_rcv)
 574                 return -EPROTO;   <----- Failure here

Looks like the intention here is to throw an ERROR if the received data
is more than the total private data length advertised by the peer. But
reading beyond MPA message causes siw_cm to generate
RDMA_CM_EVENT_CONNECT_ERROR event when TCP socket recv buffer is already
queued with FPDU messages.

Hence, this function should only read upto private data length.

Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
---
 drivers/infiniband/sw/siw/siw_cm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index a7cde98e73e8..8dc8cea2566c 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -559,13 +559,13 @@ static int siw_recv_mpa_rr(struct siw_cep *cep)
 	 * A private data buffer gets allocated if hdr->params.pd_len != 0.
 	 */
 	if (!cep->mpa.pdata) {
-		cep->mpa.pdata = kmalloc(pd_len + 4, GFP_KERNEL);
+		cep->mpa.pdata = kmalloc(pd_len, GFP_KERNEL);
 		if (!cep->mpa.pdata)
 			return -ENOMEM;
 	}
 	rcvd = ksock_recv(
 		s, cep->mpa.pdata + cep->mpa.bytes_rcvd - sizeof(struct mpa_rr),
-		to_rcv + 4, MSG_DONTWAIT);
+		to_rcv, MSG_DONTWAIT);
 
 	if (rcvd < 0)
 		return rcvd;
-- 
2.23.0.rc0

