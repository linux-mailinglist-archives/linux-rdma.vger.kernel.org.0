Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9545C1CCCF8
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2020 20:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgEJSmR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 May 2020 14:42:17 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:48490 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgEJSmR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 May 2020 14:42:17 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 04AIg6Ps009516;
        Sun, 10 May 2020 11:42:12 -0700
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: [PATCH for-rc] RDMA/iw_cxgb4: Fix incorrect function parameters
Date:   Mon, 11 May 2020 00:11:57 +0530
Message-Id: <20200510184157.12466-1-bharat@chelsio.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the incorrect function parameters passed while reading TCB fields and
completing cached SRQ buffers.

Fixes: 11a27e2121a5 ("iw_cxgb4: complete the cached SRQ buffers")
Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/hw/cxgb4/cm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index d69dece3b1d5..30e08bcc9afb 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2891,8 +2891,7 @@ static int peer_abort(struct c4iw_dev *dev, struct sk_buff *skb)
 			srqidx = ABORT_RSS_SRQIDX_G(
 					be32_to_cpu(req->srqidx_status));
 			if (srqidx) {
-				complete_cached_srq_buffers(ep,
-							    req->srqidx_status);
+				complete_cached_srq_buffers(ep, srqidx);
 			} else {
 				/* Hold ep ref until finish_peer_abort() */
 				c4iw_get_ep(&ep->com);
@@ -3878,8 +3877,8 @@ static int read_tcb_rpl(struct c4iw_dev *dev, struct sk_buff *skb)
 		return 0;
 	}
 
-	ep->srqe_idx = t4_tcb_get_field32(tcb, TCB_RQ_START_W, TCB_RQ_START_W,
-			TCB_RQ_START_S);
+	ep->srqe_idx = t4_tcb_get_field32(tcb, TCB_RQ_START_W, TCB_RQ_START_M,
+					  TCB_RQ_START_S);
 cleanup:
 	pr_debug("ep %p tid %u %016x\n", ep, ep->hwtid, ep->srqe_idx);
 
-- 
2.24.0

