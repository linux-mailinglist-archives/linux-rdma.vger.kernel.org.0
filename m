Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6757A24669C
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 14:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgHQMq4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 08:46:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42456 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728284AbgHQMq4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Aug 2020 08:46:56 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 62EB674C3199D88A22EB;
        Mon, 17 Aug 2020 20:46:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 17 Aug 2020 20:46:42 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/4] RDMA/hns: Export hardware capability flags to userspace
Date:   Mon, 17 Aug 2020 20:45:41 +0800
Message-ID: <1597668344-48575-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1597668344-48575-1-git-send-email-liweihang@huawei.com>
References: <1597668344-48575-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

The libhns in userspace for HIP09 will use the hardware's capability to
enable some features. So export the hardware capablility flags to userspace
by reusing the reserved fields in structure
"hns_roce_ib_alloc_ucontext_resp".

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 1 +
 include/uapi/rdma/hns-abi.h               | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 5907cfd..98945df 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -313,6 +313,7 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 		return -EAGAIN;
 
 	resp.qp_tab_size = hr_dev->caps.num_qps;
+	resp.cap_flags = (u32)hr_dev->caps.flags;
 
 	ret = hns_roce_uar_alloc(hr_dev, &context->uar);
 	if (ret)
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index eb76b38..5c38758 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -73,7 +73,7 @@ struct hns_roce_ib_create_qp_resp {
 
 struct hns_roce_ib_alloc_ucontext_resp {
 	__u32	qp_tab_size;
-	__u32	reserved;
+	__u32	cap_flags;
 };
 
 struct hns_roce_ib_alloc_pd_resp {
-- 
2.8.1

