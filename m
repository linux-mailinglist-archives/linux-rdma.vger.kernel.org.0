Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663FA422FEC
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Oct 2021 20:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhJESZ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 14:25:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:51058 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJESZ4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Oct 2021 14:25:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="212941952"
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="212941952"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 11:24:05 -0700
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="488157159"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.212.26.51])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 11:24:04 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-rc] RDMA/irdma: Process extended CQ entries correctly
Date:   Tue,  5 Oct 2021 13:23:02 -0500
Message-Id: <20211005182302.374-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The valid bit for extended CQE's written by HW is
retrieved from the incorrect quad-word. This leads
to missed completions for any UD traffic particularly
after a wrap-around.

Get the valid bit for extended CQE's from the correct
quad-word in the descriptor.

Fixes: 551c46edc769 ("RDMA/irdma: Add user/kernel shared libraries")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/uk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index 5fb92de..9b544a3 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1092,12 +1092,12 @@ enum irdma_status_code
 		if (cq->avoid_mem_cflct) {
 			ext_cqe = (__le64 *)((u8 *)cqe + 32);
 			get_64bit_val(ext_cqe, 24, &qword7);
-			polarity = (u8)FIELD_GET(IRDMA_CQ_VALID, qword3);
+			polarity = (u8)FIELD_GET(IRDMA_CQ_VALID, qword7);
 		} else {
 			peek_head = (cq->cq_ring.head + 1) % cq->cq_ring.size;
 			ext_cqe = cq->cq_base[peek_head].buf;
 			get_64bit_val(ext_cqe, 24, &qword7);
-			polarity = (u8)FIELD_GET(IRDMA_CQ_VALID, qword3);
+			polarity = (u8)FIELD_GET(IRDMA_CQ_VALID, qword7);
 			if (!peek_head)
 				polarity ^= 1;
 		}
-- 
1.8.3.1

