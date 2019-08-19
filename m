Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA147921E4
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 13:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfHSLOe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 07:14:34 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:14577 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfHSLOe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 07:14:34 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x7JBEIWU016238;
        Mon, 19 Aug 2019 04:14:20 -0700
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     jgg@ziepe.ca, bmt@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com,
        Krishnamraju Eraparaju <krishna2@chelsio.com>
Subject: [PATCH for-rc] siw: fix for 'is_kva' flag issue in siw_tx_hdt()
Date:   Mon, 19 Aug 2019 16:43:38 +0530
Message-Id: <20190819111338.9366-1-krishna2@chelsio.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

"is_kva" variable in siw_tx_hdt() is not currently being updated for
each while loop iteration(the loop which walks the list of SGE's).

Usecase:

say a WQE has two SGE's :
 - first with "assigned kernel buffer", so not MR allocated.
 - second with PBL memory region, so mem_obj == PBL.

Now while processing first SGE, in iteration 1, "is_kva" is set to "1"
because there is no MR allocated.
And while processing the second SGE in iteration 2, since mem_obj is
PBL, the statement "if (!mem->mem_obj)" becomes false but is_kva is
still "1"(previous state). Thus, the PBL memory is handled as "direct
assigned kernel virtual memory", which eventually results in PAGE
FAULTS, MPA CRC issues.

                if (!(tx_flags(wqe) & SIW_WQE_INLINE)) {
                        mem = wqe->mem[sge_idx];
                        if (!mem->mem_obj)
                                is_kva = 1;
                } else {
                        is_kva = 1;
                }

Note that you need to set MTU size more than the PAGESIZE to recreate
this issue(as the address of "PBL index 0" and "assigned kernel
virtual memory" are always same for SIW). In my case, I used SIW
as ISER initiator with MTU 9000, issue occurs with
SCSI WRITE operation.

Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
---
 drivers/infiniband/sw/siw/siw_qp_tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 43020d2040fc..e2175a08269a 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -465,6 +465,8 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx, struct socket *s)
 			mem = wqe->mem[sge_idx];
 			if (!mem->mem_obj)
 				is_kva = 1;
+			else
+				is_kva = 0;
 		} else {
 			is_kva = 1;
 		}
-- 
2.23.0.rc0

