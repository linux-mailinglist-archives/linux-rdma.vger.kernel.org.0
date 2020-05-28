Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1063B1E656B
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 17:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404033AbgE1PEt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 May 2020 11:04:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58364 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403876AbgE1PEo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 May 2020 11:04:44 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jeK55-0007mV-Ry; Thu, 28 May 2020 15:04:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Lijun Ou <oulijun@huawei.com>, Wei Hu <huwei87@hisilicon.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] RDMA/hns: remove duplicate assignment to pointer raq
Date:   Thu, 28 May 2020 16:04:27 +0100
Message-Id: <20200528150427.420624-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer raq is being assigned twice. Fix this by removing
one of the redundant assignments.

Fixes: 14ba87304bf9 ("RDMA/hns: Remove redundant type cast for general pointers")
Addressses-Coverity: ("Evaluation order violation")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 8ff6b922b4d7..d02207cd30df 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1146,7 +1146,7 @@ static void hns_roce_db_free(struct hns_roce_dev *hr_dev)
 static int hns_roce_raq_init(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_v1_priv *priv = hr_dev->priv;
-	struct hns_roce_raq_table *raq = raq = &priv->raq_table;
+	struct hns_roce_raq_table *raq = &priv->raq_table;
 	struct device *dev = &hr_dev->pdev->dev;
 	int raq_shift = 0;
 	dma_addr_t addr;
-- 
2.25.1

