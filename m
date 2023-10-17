Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9887CC3B7
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 14:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbjJQM4A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 08:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjJQMz7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 08:55:59 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61A1F1;
        Tue, 17 Oct 2023 05:55:57 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S8v6J2Fm1z15Nd7;
        Tue, 17 Oct 2023 20:53:12 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 17 Oct 2023 20:55:53 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 6/7] RDMA/hns: Fix unnecessary port_num transition in HW stats allocation
Date:   Tue, 17 Oct 2023 20:52:38 +0800
Message-ID: <20231017125239.164455-7-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231017125239.164455-1-huangjunxian6@hisilicon.com>
References: <20231017125239.164455-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The num_ports capability of devices should be compared with the
number of port(i.e. the input param "port_num") but not the port
index(i.e. port_num - 1).

Fixes: 5a87279591a1 ("RDMA/hns: Support hns HW stats")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index d9d546cdef52..e1a88f2d51b6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -547,9 +547,8 @@ static struct rdma_hw_stats *hns_roce_alloc_hw_port_stats(
 				struct ib_device *device, u32 port_num)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(device);
-	u32 port = port_num - 1;
 
-	if (port > hr_dev->caps.num_ports) {
+	if (port_num > hr_dev->caps.num_ports) {
 		ibdev_err(device, "invalid port num.\n");
 		return NULL;
 	}
-- 
2.30.0

