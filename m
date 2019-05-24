Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88E83291C9
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 09:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbfEXHco (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 03:32:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17559 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389030AbfEXHco (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 May 2019 03:32:44 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8F92BF778FABEB56D0A3;
        Fri, 24 May 2019 15:32:41 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Fri, 24 May 2019 15:32:31 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 for-next 1/4] RDMA/hns: Remove unnecessary prompt message in aeq
Date:   Fri, 24 May 2019 15:31:20 +0800
Message-ID: <1558683083-79692-2-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558683083-79692-1-git-send-email-oulijun@huawei.com>
References: <1558683083-79692-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

There is no need to prompt when communication is established,
especially while lots of qp used by application.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b5392cb..1c7e6e6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4682,7 +4682,6 @@ static void hns_roce_irq_work_handle(struct work_struct *work)
 		dev_warn(dev, "Path migration failed.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_COMM_EST:
-		dev_info(dev, "Communication established.\n");
 		break;
 	case HNS_ROCE_EVENT_TYPE_SQ_DRAINED:
 		dev_warn(dev, "Send queue drained.\n");
-- 
1.9.1

