Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC15F3BB3
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2019 23:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfKGWs6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Nov 2019 17:48:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46094 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfKGWs5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Nov 2019 17:48:57 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iSqaF-0007fq-Jh; Thu, 07 Nov 2019 22:48:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] infiniband: ocrdma: fix spelling mistake in variable name
Date:   Thu,  7 Nov 2019 22:48:55 +0000
Message-Id: <20191107224855.417647-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the variable nak_invalid_requst_errors,
rename it to nak_invalid_request_errors.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_sli.h   | 2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_sli.h b/drivers/infiniband/hw/ocrdma/ocrdma_sli.h
index 6ef89c226ad8..c2e0d0fa44be 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_sli.h
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_sli.h
@@ -2034,7 +2034,7 @@ struct ocrdma_rx_stats {
 };
 
 struct ocrdma_rx_qp_err_stats {
-	u32 nak_invalid_requst_errors;
+	u32 nak_invalid_request_errors;
 	u32 nak_remote_operation_errors;
 	u32 nak_count_remote_access_errors;
 	u32 local_length_errors;
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
index a902942adb5d..94d97bbb1254 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
@@ -423,8 +423,8 @@ static char *ocrdma_rxqp_errstats(struct ocrdma_dev *dev)
 	memset(stats, 0, (OCRDMA_MAX_DBGFS_MEM));
 
 	pcur = stats;
-	pcur += ocrdma_add_stat(stats, pcur, "nak_invalid_requst_errors",
-			(u64)rx_qp_err_stats->nak_invalid_requst_errors);
+	pcur += ocrdma_add_stat(stats, pcur, "nak_invalid_request_errors",
+			(u64)rx_qp_err_stats->nak_invalid_request_errors);
 	pcur += ocrdma_add_stat(stats, pcur, "nak_remote_operation_errors",
 			(u64)rx_qp_err_stats->nak_remote_operation_errors);
 	pcur += ocrdma_add_stat(stats, pcur, "nak_count_remote_access_errors",
-- 
2.20.1

