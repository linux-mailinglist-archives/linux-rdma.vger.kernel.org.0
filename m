Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2CA39DB69
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 13:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFGLfk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 07:35:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44122 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhFGLfk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Jun 2021 07:35:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lqDVp-0002eG-Og; Mon, 07 Jun 2021 11:33:45 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] RDMA/irdma: Fix spelling mistake "Allocal" -> "Allocate"
Date:   Mon,  7 Jun 2021 12:33:45 +0100
Message-Id: <20210607113345.82206-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a literal string. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/irdma/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 2f078155d6fd..8f04347be52c 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -636,7 +636,7 @@ static const char *const irdma_cqp_cmd_names[IRDMA_MAX_CQP_OPS] = {
 	[IRDMA_OP_SET_UP_MAP] = "Set UP-UP Mapping Cmd",
 	[IRDMA_OP_GEN_AE] = "Generate AE Cmd",
 	[IRDMA_OP_QUERY_RDMA_FEATURES] = "RDMA Get Features Cmd",
-	[IRDMA_OP_ALLOC_LOCAL_MAC_ENTRY] = "Allocal Local MAC Entry Cmd",
+	[IRDMA_OP_ALLOC_LOCAL_MAC_ENTRY] = "Allocate Local MAC Entry Cmd",
 	[IRDMA_OP_ADD_LOCAL_MAC_ENTRY] = "Add Local MAC Entry Cmd",
 	[IRDMA_OP_DELETE_LOCAL_MAC_ENTRY] = "Delete Local MAC Entry Cmd",
 	[IRDMA_OP_CQ_MODIFY] = "CQ Modify Cmd",
-- 
2.31.1

