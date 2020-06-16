Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404DB1FB249
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2020 15:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgFPNhx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jun 2020 09:37:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6342 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726606AbgFPNhx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Jun 2020 09:37:53 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7F4388285EB187B7E074;
        Tue, 16 Jun 2020 21:37:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 21:37:33 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-rc] RDMA/hns: Fix a calltrace when registering MR from userspace
Date:   Tue, 16 Jun 2020 21:37:09 +0800
Message-ID: <1592314629-51715-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yangyang Li <liyangyang20@huawei.com>

ibmr.device is assigned after MR is successfully registered, but both
write_mtpt() and frmr_write_mtpt() accesses it during the mr registration
process, which may cause the following error when trying to register MR
in userspace and pbl_hop_num is set to 0.

[ 3307.615548] pc : hns_roce_mtr_find+0xa0/0x200 [hns_roce]
[ 3307.615554] lr : set_mtpt_pbl+0x54/0x118 [hns_roce_hw_v2]
[ 3307.707924] sp : ffff00023e73ba20
[ 3307.711225] x29: ffff00023e73ba20 x28: ffff00023e73bad8
[ 3307.716523] x27: 0000000000000000 x26: 0000000000000000
[ 3307.721821] x25: 0000000000000002 x24: 0000000000000000
[ 3307.727119] x23: ffff00023e73bad0 x22: 0000000000000000
[ 3307.732417] x21: ffff0000094d9000 x20: 0000000000000000
[ 3307.737715] x19: ffff8020a6bdb2c0 x18: 0000000000000000
[ 3307.743012] x17: 0000000000000000 x16: 0000000000000000
[ 3307.748310] x15: 0000000000000000 x14: 0000000000000000
[ 3307.753607] x13: 0140000000000000 x12: 0040000000000041
[ 3307.758905] x11: ffff000240000000 x10: 0000000000001000
[ 3307.764203] x9 : 0000000000000000 x8 : ffff802fb7558480
[ 3307.769501] x7 : ffff802fb7558480 x6 : 000000000003483d
[ 3307.774799] x5 : ffff00023e73bad0 x4 : 0000000000000002
[ 3307.780097] x3 : ffff00023e73bad8 x2 : 0000000000000000
[ 3307.785394] x1 : 0000000000000000 x0 : ffff0000094d9708
[ 3307.790692] Call trace:
[ 3307.793130]  hns_roce_mtr_find+0xa0/0x200 [hns_roce]
[ 3307.798081]  set_mtpt_pbl+0x54/0x118 [hns_roce_hw_v2]
[ 3307.803119]  hns_roce_v2_write_mtpt+0x14c/0x168 [hns_roce_hw_v2]
[ 3307.809114]  hns_roce_mr_enable+0x6c/0x148 [hns_roce]
[ 3307.814154]  hns_roce_reg_user_mr+0xd8/0x130 [hns_roce]
[ 3307.819369]  ib_uverbs_reg_mr+0x14c/0x2e0 [ib_uverbs]
[ 3307.824408]  ib_uverbs_write+0x27c/0x3e8 [ib_uverbs]
[ 3307.829361]  __vfs_write+0x60/0x190
[ 3307.832835]  vfs_write+0xac/0x1c0
[ 3307.836136]  ksys_write+0x6c/0xd8
[ 3307.839437]  __arm64_sys_write+0x24/0x30
[ 3307.843347]  el0_svc_common+0x78/0x130
[ 3307.847082]  el0_svc_handler+0x38/0x78
[ 3307.850817]  el0_svc+0x8/0xc

Solve above issue by adding a pointer of structure hns_roce_dev as a
parameter of write_mtpt() and frmr_write_mtpt(), so that both of these
functions can access it before finishing MR's registration.

Fixes: 9b2cf76c9f05 ("RDMA/hns: Optimize PBL buffer allocation process")
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  7 ++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  4 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 15 ++++++++-------
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  5 +++--
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a77fa67..479fa55 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -898,13 +898,14 @@ struct hns_roce_hw {
 	int (*set_mac)(struct hns_roce_dev *hr_dev, u8 phy_port, u8 *addr);
 	void (*set_mtu)(struct hns_roce_dev *hr_dev, u8 phy_port,
 			enum ib_mtu mtu);
-	int (*write_mtpt)(void *mb_buf, struct hns_roce_mr *mr,
-			  unsigned long mtpt_idx);
+	int (*write_mtpt)(struct hns_roce_dev *hr_dev, void *mb_buf,
+			  struct hns_roce_mr *mr, unsigned long mtpt_idx);
 	int (*rereg_write_mtpt)(struct hns_roce_dev *hr_dev,
 				struct hns_roce_mr *mr, int flags, u32 pdn,
 				int mr_access_flags, u64 iova, u64 size,
 				void *mb_buf);
-	int (*frmr_write_mtpt)(void *mb_buf, struct hns_roce_mr *mr);
+	int (*frmr_write_mtpt)(struct hns_roce_dev *hr_dev, void *mb_buf,
+			       struct hns_roce_mr *mr);
 	int (*mw_write_mtpt)(void *mb_buf, struct hns_roce_mw *mw);
 	void (*write_cqc)(struct hns_roce_dev *hr_dev,
 			  struct hns_roce_cq *hr_cq, void *mb_buf, u64 *mtts,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index d02207c..cf39f56 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -1756,10 +1756,10 @@ static void hns_roce_v1_set_mtu(struct hns_roce_dev *hr_dev, u8 phy_port,
 		   val);
 }
 
-static int hns_roce_v1_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
+static int hns_roce_v1_write_mtpt(struct hns_roce_dev *hr_dev, void *mb_buf,
+				  struct hns_roce_mr *mr,
 				  unsigned long mtpt_idx)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(mr->ibmr.device);
 	u64 pages[HNS_ROCE_MAX_INNER_MTPT_NUM] = { 0 };
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_v1_mpt_entry *mpt_entry;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c597d72..bb86754c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2529,10 +2529,10 @@ static int hns_roce_v2_set_mac(struct hns_roce_dev *hr_dev, u8 phy_port,
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
 
-static int set_mtpt_pbl(struct hns_roce_v2_mpt_entry *mpt_entry,
+static int set_mtpt_pbl(struct hns_roce_dev *hr_dev,
+			struct hns_roce_v2_mpt_entry *mpt_entry,
 			struct hns_roce_mr *mr)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(mr->ibmr.device);
 	u64 pages[HNS_ROCE_V2_MAX_INNER_MTPT_NUM] = { 0 };
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	dma_addr_t pbl_ba;
@@ -2571,7 +2571,8 @@ static int set_mtpt_pbl(struct hns_roce_v2_mpt_entry *mpt_entry,
 	return 0;
 }
 
-static int hns_roce_v2_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
+static int hns_roce_v2_write_mtpt(struct hns_roce_dev *hr_dev,
+				  void *mb_buf, struct hns_roce_mr *mr,
 				  unsigned long mtpt_idx)
 {
 	struct hns_roce_v2_mpt_entry *mpt_entry;
@@ -2620,7 +2621,7 @@ static int hns_roce_v2_write_mtpt(void *mb_buf, struct hns_roce_mr *mr,
 	if (mr->type == MR_TYPE_DMA)
 		return 0;
 
-	ret = set_mtpt_pbl(mpt_entry, mr);
+	ret = set_mtpt_pbl(hr_dev, mpt_entry, mr);
 
 	return ret;
 }
@@ -2666,15 +2667,15 @@ static int hns_roce_v2_rereg_write_mtpt(struct hns_roce_dev *hr_dev,
 		mr->iova = iova;
 		mr->size = size;
 
-		ret = set_mtpt_pbl(mpt_entry, mr);
+		ret = set_mtpt_pbl(hr_dev, mpt_entry, mr);
 	}
 
 	return ret;
 }
 
-static int hns_roce_v2_frmr_write_mtpt(void *mb_buf, struct hns_roce_mr *mr)
+static int hns_roce_v2_frmr_write_mtpt(struct hns_roce_dev *hr_dev,
+				       void *mb_buf, struct hns_roce_mr *mr)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(mr->ibmr.device);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_v2_mpt_entry *mpt_entry;
 	dma_addr_t pbl_ba = 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 4c0bbb1..0e71ebe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -180,9 +180,10 @@ static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 	}
 
 	if (mr->type != MR_TYPE_FRMR)
-		ret = hr_dev->hw->write_mtpt(mailbox->buf, mr, mtpt_idx);
+		ret = hr_dev->hw->write_mtpt(hr_dev, mailbox->buf, mr,
+					     mtpt_idx);
 	else
-		ret = hr_dev->hw->frmr_write_mtpt(mailbox->buf, mr);
+		ret = hr_dev->hw->frmr_write_mtpt(hr_dev, mailbox->buf, mr);
 	if (ret) {
 		dev_err(dev, "Write mtpt fail!\n");
 		goto err_page;
-- 
2.8.1

