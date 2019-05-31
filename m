Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F69F30B4F
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2019 11:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEaJVK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 May 2019 05:21:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42123 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaJVK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 May 2019 05:21:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hWdig-0004Hk-1h; Fri, 31 May 2019 09:21:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2][next] RDMA/hns: fix inverted logic of readl read and shift
Date:   Fri, 31 May 2019 10:21:01 +0100
Message-Id: <20190531092101.28772-2-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531092101.28772-1-colin.king@canonical.com>
References: <20190531092101.28772-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A previous change incorrectly changed the inverted logic and logically
negated the readl rather than the shifted readl result. Fix this by
adding in missing parentheses around the expression that needs to be
logically negated.

Addresses-Coverity: ("Logically dead code")
Fixes: 669cefb654cb ("RDMA/hns: Remove jiffies operation in disable interrupt context")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index b3641aeff27a..a8e9329cbf4e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -378,7 +378,7 @@ static int hns_roce_set_hem(struct hns_roce_dev *hr_dev,
 
 		end = HW_SYNC_TIMEOUT_MSECS;
 		while (end > 0) {
-			if (!readl(bt_cmd) >> BT_CMD_SYNC_SHIFT)
+			if (!(readl(bt_cmd) >> BT_CMD_SYNC_SHIFT))
 				break;
 
 			mdelay(HW_SYNC_SLEEP_TIME_INTERVAL);
-- 
2.20.1

