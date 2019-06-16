Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66B574746D
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2019 14:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfFPMGE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Jun 2019 08:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfFPMGE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 16 Jun 2019 08:06:04 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C116A20870;
        Sun, 16 Jun 2019 12:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560686763;
        bh=OrDp2iJdJS0lKbdaGdPU5dghXyGquWMeJqu5gvJ0+Pk=;
        h=From:To:Cc:Subject:Date:From;
        b=lAE2FsH+6HVdkC1Rcmw1n9eC9zURhv4PKnfK3axDwPp0SbvHjFXEHfUw7bKjKlSZT
         /z1e14dxTnoR1RVgMwannvuTepPe1XgSduhb4A0Xvb4xwz73sPmno8/LbHr0eWljup
         lmmhGtWjHVnvXyjcRdA2MQjFPE3r/PObixoMdWYM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Lang Cheng <chenglang@huawei.com>
Subject: [PATCH rdma-next] RDMa/hns: Don't stuck in endless timeout loop
Date:   Sun, 16 Jun 2019 15:05:58 +0300
Message-Id: <20190616120558.12960-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The "end" variable is declared as unsigned and can't be negative, it
leads to the situation where timeout limit is not honored, so let's
convert logic to ensure that loop is bounded.

drivers/infiniband/hw/hns/hns_roce_hw_v1.c: In function _hns_roce_v1_clear_hem_:
drivers/infiniband/hw/hns/hns_roce_hw_v1.c:2471:12: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
 2471 |    if (end < 0) {
      |            ^

Fixes: 669cefb654cb ("RDMA/hns: Remove jiffies operation in disable interrupt context")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.h   | 2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index d9d668992e49..258682cbe532 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -34,8 +34,8 @@
 #ifndef _HNS_ROCE_HEM_H
 #define _HNS_ROCE_HEM_H
 
-#define HW_SYNC_TIMEOUT_MSECS		500
 #define HW_SYNC_SLEEP_TIME_INTERVAL	20
+#define HW_SYNC_TIMEOUT_MSECS           (25 * HW_SYNC_SLEEP_TIME_INTERVAL)
 #define BT_CMD_SYNC_SHIFT		31
 
 enum {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index cc1ea69d0f29..056a6873df7a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -2468,7 +2468,7 @@ static int hns_roce_v1_clear_hem(struct hns_roce_dev *hr_dev,
 	end = HW_SYNC_TIMEOUT_MSECS;
 	while (1) {
 		if (readl(bt_cmd) >> BT_CMD_SYNC_SHIFT) {
-			if (end < 0) {
+			if (!end) {
 				dev_err(dev, "Write bt_cmd err,hw_sync is not zero.\n");
 				spin_unlock_irqrestore(&hr_dev->bt_cmd_lock,
 					flags);
-- 
2.20.1

