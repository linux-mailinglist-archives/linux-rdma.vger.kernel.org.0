Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF49070F42
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 04:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfGWCt0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 22:49:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726641AbfGWCt0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jul 2019 22:49:26 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BE7EACBB889C44CB166D;
        Tue, 23 Jul 2019 10:49:24 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Jul 2019
 10:49:18 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <oulijun@huawei.com>, <xavier.huwei@huawei.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] RDMA/hns: Fix build error for hip08
Date:   Tue, 23 Jul 2019 10:49:08 +0800
Message-ID: <20190723024908.11876-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If INFINIBAND_HNS_HIP08 is selected and HNS3 is m,
but INFINIBAND_HNS is y, building fails:

drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_exit':
hns_roce_hw_v2.c:(.exit.text+0xd): undefined reference to `hnae3_unregister_client'
drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_init':
hns_roce_hw_v2.c:(.init.text+0xd): undefined reference to `hnae3_register_client'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: dd74282df573 ("RDMA/hns: Initialize the PCI device for hip08 RoCE")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/infiniband/hw/hns/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
index b59da5d..4371c80 100644
--- a/drivers/infiniband/hw/hns/Kconfig
+++ b/drivers/infiniband/hw/hns/Kconfig
@@ -23,7 +23,8 @@ config INFINIBAND_HNS_HIP06
 
 config INFINIBAND_HNS_HIP08
 	bool "Hisilicon Hip08 Family RoCE support"
-	depends on INFINIBAND_HNS && PCI && HNS3
+	depends on INFINIBAND_HNS && (INFINIBAND_HNS = HNS3)
+	depends on PCI
 	---help---
 	  RoCE driver support for Hisilicon RoCE engine in Hisilicon Hip08 SoC.
 	  The RoCE engine is a PCI device.
-- 
2.7.4


