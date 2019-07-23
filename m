Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A05D70F3A
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 04:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfGWCqG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 22:46:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46614 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfGWCqG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jul 2019 22:46:06 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EEFFA18F37956D206519;
        Tue, 23 Jul 2019 10:45:58 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Jul 2019
 10:45:49 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <oulijun@huawei.com>, <xavier.huwei@huawei.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] RDMA/hns: Fix build error for hip06
Date:   Tue, 23 Jul 2019 10:45:35 +0800
Message-ID: <20190723024535.61412-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If INFINIBAND_HNS_HIP06 is selected and HNS_DSAF
is m, but INFINIBAND_HNS is y, building fails:

drivers/infiniband/hw/hns/hns_roce_hw_v1.o: In function `hns_roce_v1_reset':
hns_roce_hw_v1.c:(.text+0x39fa): undefined reference to `hns_dsaf_roce_reset'
hns_roce_hw_v1.c:(.text+0x3a25): undefined reference to `hns_dsaf_roce_reset'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 08805fdbeb2d ("RDMA/hns: Split hw v1 driver from hns roce driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hns/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
index 8bf847b..b59da5d 100644
--- a/drivers/infiniband/hw/hns/Kconfig
+++ b/drivers/infiniband/hw/hns/Kconfig
@@ -12,7 +12,8 @@ config INFINIBAND_HNS
 
 config INFINIBAND_HNS_HIP06
 	bool "Hisilicon Hip06 Family RoCE support"
-	depends on INFINIBAND_HNS && HNS && HNS_DSAF && HNS_ENET
+	depends on INFINIBAND_HNS && HNS && (INFINIBAND_HNS = HNS_DSAF)
+	depends on HNS_ENET
 	---help---
 	  RoCE driver support for Hisilicon RoCE engine in Hisilicon Hip06 and
 	  Hip07 SoC. These RoCE engines are platform devices.
-- 
2.7.4


