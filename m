Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C721AFA75
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2020 15:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDSNUx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Apr 2020 09:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgDSNUv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 Apr 2020 09:20:51 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7020521744;
        Sun, 19 Apr 2020 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587302451;
        bh=yaXZpoIjE58QIRalYbskWrzei+/nTC6pZqDn8sBWf1s=;
        h=From:To:Cc:Subject:Date:From;
        b=liV7DvJm5kIKBNP0MgqJyAsa0hf0iTtnYzahGyG5W3I/vc69gJuqwsTQNOMm5Fd1i
         u1W8lfm/DNCxyKhZ/K2LRjx7OShS8/49ooR9kMH3h3zRQD28B/4J7domiM45OwXhyl
         x4zD9tZBvDmW3wZ+5aFNUrzhiuCJPq5t+ZUGOxEo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next] RDMA/bnxt: Delete 'nq_ptr' variable which is not used
Date:   Sun, 19 Apr 2020 16:20:46 +0300
Message-Id: <20200419132046.123887-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The variable "nq_ptr" is set but never used, this generates the
following warning while compiling kernel with W=1 option.

drivers/infiniband/hw/bnxt_re/qplib_fp.c: In function 'bnxt_qplib_service_nq':
drivers/infiniband/hw/bnxt_re/qplib_fp.c:303:25: warning:
   variable 'nq_ptr' set but not used [-Wunused-but-set-variable]
303 |  struct nq_base *nqe, **nq_ptr;
    |

Fixes: fddcbbb02af4 ("RDMA/bnxt_re: Simplify obtaining queue entry from hw ring")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index a4de56bdd6e8..c5e29577cd43 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -300,12 +300,12 @@ static void bnxt_qplib_service_nq(unsigned long data)
 {
 	struct bnxt_qplib_nq *nq = (struct bnxt_qplib_nq *)data;
 	struct bnxt_qplib_hwq *hwq = &nq->hwq;
-	struct nq_base *nqe, **nq_ptr;
 	int num_srqne_processed = 0;
 	int num_cqne_processed = 0;
 	struct bnxt_qplib_cq *cq;
 	int budget = nq->budget;
 	u32 sw_cons, raw_cons;
+	struct nq_base *nqe;
 	uintptr_t q_handle;
 	u16 type;
 
@@ -314,7 +314,6 @@ static void bnxt_qplib_service_nq(unsigned long data)
 	raw_cons = hwq->cons;
 	while (budget--) {
 		sw_cons = HWQ_CMP(raw_cons, hwq);
-		nq_ptr = (struct nq_base **)hwq->pbl_ptr;
 		nqe = bnxt_qplib_get_qe(hwq, sw_cons, NULL);
 		if (!NQE_CMP_VALID(nqe, raw_cons, hwq->max_elements))
 			break;
-- 
2.25.2

