Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862AE39C85F
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Jun 2021 15:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFENPj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 5 Jun 2021 09:15:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48808 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFENPj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 5 Jun 2021 09:15:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lpW7X-0001I1-S6; Sat, 05 Jun 2021 13:13:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] RDMA/irdma: remove redundant initialization of variable val
Date:   Sat,  5 Jun 2021 14:13:47 +0100
Message-Id: <20210605131347.26293-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable val is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/irdma/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 8bd3aecadaf6..b1023a7d0bd1 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -3323,7 +3323,7 @@ __le64 *irdma_sc_cqp_get_next_send_wqe_idx(struct irdma_sc_cqp *cqp, u64 scratch
  */
 enum irdma_status_code irdma_sc_cqp_destroy(struct irdma_sc_cqp *cqp)
 {
-	u32 cnt = 0, val = 1;
+	u32 cnt = 0, val;
 	enum irdma_status_code ret_code = 0;
 
 	writel(0, cqp->dev->hw_regs[IRDMA_CCQPHIGH]);
-- 
2.31.1

