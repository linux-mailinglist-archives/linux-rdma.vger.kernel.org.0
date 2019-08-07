Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57DCF842E9
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 05:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfHGDak (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 23:30:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfHGDak (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Aug 2019 23:30:40 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 65D60DBE13CC5B121D41;
        Wed,  7 Aug 2019 11:30:35 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 7 Aug 2019
 11:30:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <oulijun@huawei.com>, <xavier.huwei@huawei.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] RDMA/hns: remove obsolete Kconfig comment
Date:   Wed, 7 Aug 2019 11:22:28 +0800
Message-ID: <20190807032228.6788-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since commit a07fc0bb483e ("RDMA/hns: Fix build error")
these kconfig comment is obsolete, so just remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hns/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
index 5478219..d602b69 100644
--- a/drivers/infiniband/hw/hns/Kconfig
+++ b/drivers/infiniband/hw/hns/Kconfig
@@ -8,8 +8,6 @@ config INFINIBAND_HNS
 	  is used in Hisilicon Hip06 and more further ICT SoC based on
 	  platform device.
 
-	  To compile HIP06 or HIP08 driver as module, choose M here.
-
 config INFINIBAND_HNS_HIP06
 	tristate "Hisilicon Hip06 Family RoCE support"
 	depends on INFINIBAND_HNS && HNS && HNS_DSAF && HNS_ENET
@@ -17,15 +15,9 @@ config INFINIBAND_HNS_HIP06
 	  RoCE driver support for Hisilicon RoCE engine in Hisilicon Hip06 and
 	  Hip07 SoC. These RoCE engines are platform devices.
 
-	  To compile this driver, choose Y here: if INFINIBAND_HNS is m, this
-	  module will be called hns-roce-hw-v1
-
 config INFINIBAND_HNS_HIP08
 	tristate "Hisilicon Hip08 Family RoCE support"
 	depends on INFINIBAND_HNS && PCI && HNS3
 	---help---
 	  RoCE driver support for Hisilicon RoCE engine in Hisilicon Hip08 SoC.
 	  The RoCE engine is a PCI device.
-
-	  To compile this driver, choose Y here: if INFINIBAND_HNS is m, this
-	  module will be called hns-roce-hw-v2.
-- 
2.7.4


