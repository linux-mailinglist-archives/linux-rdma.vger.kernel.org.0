Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18511DB5AA
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 15:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgETNxs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 09:53:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56374 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726747AbgETNxs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 09:53:48 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ED924223CE8A558903BB;
        Wed, 20 May 2020 21:53:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 20 May 2020 21:53:36 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 4/9] RDMA/hns: Remove unused code about assert
Date:   Wed, 20 May 2020 21:53:14 +0800
Message-ID: <1589982799-28728-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
References: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

The codes related to assert are no longer used and need to be deleted.

Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_common.h | 4 ----
 drivers/infiniband/hw/hns/hns_roce_main.c   | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index 8e95a1a..f5669ff 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -33,10 +33,6 @@
 #ifndef _HNS_ROCE_COMMON_H
 #define _HNS_ROCE_COMMON_H
 
-#ifndef assert
-#define assert(cond)
-#endif
-
 #define roce_write(dev, reg, val)	writel((val), (dev)->reg_base + (reg))
 #define roce_read(dev, reg)		readl((dev)->reg_base + (reg))
 #define roce_raw_write(value, addr) \
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index fd3581e..50763cf 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -233,7 +233,6 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u8 port_num,
 	enum ib_mtu mtu;
 	u8 port;
 
-	assert(port_num > 0);
 	port = port_num - 1;
 
 	/* props being zeroed by the caller, avoid zeroing it here */
-- 
2.8.1

