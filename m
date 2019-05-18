Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2FC12236F
	for <lists+linux-rdma@lfdr.de>; Sat, 18 May 2019 13:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfERL4X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 May 2019 07:56:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38922 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729852AbfERL4X (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 18 May 2019 07:56:23 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 32ADC3ECED9DBAC22A73;
        Sat, 18 May 2019 19:56:21 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Sat, 18 May 2019 19:55:59 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/4] RDMA/hns: Move spin_lock_irqsave to the correct place
Date:   Sat, 18 May 2019 19:54:59 +0800
Message-ID: <1558180500-93157-4-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558180500-93157-1-git-send-email-oulijun@huawei.com>
References: <1558180500-93157-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

When hip08 set gid, it will call spin_unlock_bh when send cmq.
if main.ko call spin_lock_irqsave firstly, and the kernel is before
commit f71b74bca637 ("irq/softirqs: Use lockdep to assert IRQs are
disabled/enabled"), it will cause WARN_ON_ONCE because of calling
spin_unlock_bh in disable context.

In fact, the spin_lock_irqsave in main.ko is only used for hip06,
and should be placed in hns_roce_hw_v1.c. hns_roce_hw_v2.c uses
its own spin_unlock_bh and does not need main.ko manage spin_lock.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c |  5 +++++
 drivers/infiniband/hw/hns/hns_roce_main.c  | 10 ----------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 26d4ed4..722134f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1743,11 +1743,14 @@ static int hns_roce_v1_set_gid(struct hns_roce_dev *hr_dev, u8 port,
 			       int gid_index, const union ib_gid *gid,
 			       const struct ib_gid_attr *attr)
 {
+	unsigned long flags;
 	u32 *p = NULL;
 	u8 gid_idx = 0;
 
 	gid_idx = hns_get_gid_index(hr_dev, port, gid_index);
 
+	spin_lock_irqsave(&hr_dev->iboe.lock, flags);
+
 	p = (u32 *)&gid->raw[0];
 	roce_raw_write(*p, hr_dev->reg_base + ROCEE_PORT_GID_L_0_REG +
 		       (HNS_ROCE_V1_GID_NUM * gid_idx));
@@ -1764,6 +1767,8 @@ static int hns_roce_v1_set_gid(struct hns_roce_dev *hr_dev, u8 port,
 	roce_raw_write(*p, hr_dev->reg_base + ROCEE_PORT_GID_H_0_REG +
 		       (HNS_ROCE_V1_GID_NUM * gid_idx));
 
+	spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 8da5f18..05a0f7d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -78,18 +78,13 @@ static int hns_roce_add_gid(const struct ib_gid_attr *attr, void **context)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(attr->device);
 	u8 port = attr->port_num - 1;
-	unsigned long flags;
 	int ret;
 
 	if (port >= hr_dev->caps.num_ports)
 		return -EINVAL;
 
-	spin_lock_irqsave(&hr_dev->iboe.lock, flags);
-
 	ret = hr_dev->hw->set_gid(hr_dev, port, attr->index, &attr->gid, attr);
 
-	spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
-
 	return ret;
 }
 
@@ -98,18 +93,13 @@ static int hns_roce_del_gid(const struct ib_gid_attr *attr, void **context)
 	struct hns_roce_dev *hr_dev = to_hr_dev(attr->device);
 	struct ib_gid_attr zattr = { };
 	u8 port = attr->port_num - 1;
-	unsigned long flags;
 	int ret;
 
 	if (port >= hr_dev->caps.num_ports)
 		return -EINVAL;
 
-	spin_lock_irqsave(&hr_dev->iboe.lock, flags);
-
 	ret = hr_dev->hw->set_gid(hr_dev, port, attr->index, &zgid, &zattr);
 
-	spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
-
 	return ret;
 }
 
-- 
1.9.1

