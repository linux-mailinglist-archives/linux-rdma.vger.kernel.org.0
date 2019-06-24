Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 294E550A20
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 13:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfFXLu5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 07:50:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729420AbfFXLu5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jun 2019 07:50:57 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B30B29875C0AF8081776;
        Mon, 24 Jun 2019 19:50:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Jun 2019 19:50:43 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 8/8] RDMA/hns: Clean up unnecessary variable initialization
Date:   Mon, 24 Jun 2019 19:47:52 +0800
Message-ID: <1561376872-111496-9-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561376872-111496-1-git-send-email-oulijun@huawei.com>
References: <1561376872-111496-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Here Clean up unnecessary initial value for some variable.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c   | 2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
 drivers/infiniband/hw/hns/hns_roce_main.c  | 2 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 2acf946..5ba87be 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -162,7 +162,7 @@ static int hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
 				  u64 out_param, unsigned long in_modifier,
 				  u8 op_modifier, u16 op, unsigned long timeout)
 {
-	int ret = 0;
+	int ret;
 
 	down(&hr_dev->cmd.event_sem);
 	ret = __hns_roce_cmd_mbox_wait(hr_dev, in_param, out_param,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6a1ba18..c8d5844 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2021,7 +2021,7 @@ static int hns_roce_v2_chk_mbox(struct hns_roce_dev *hr_dev,
 				unsigned long timeout)
 {
 	struct device *dev = hr_dev->dev;
-	unsigned long end = 0;
+	unsigned long end;
 	u32 status;
 
 	end = msecs_to_jiffies(timeout) + jiffies;
@@ -3019,7 +3019,7 @@ static int hns_roce_v2_clear_hem(struct hns_roce_dev *hr_dev,
 {
 	struct device *dev = hr_dev->dev;
 	struct hns_roce_cmd_mailbox *mailbox;
-	int ret = 0;
+	int ret;
 	u16 op = 0xff;
 
 	if (!hns_roce_check_whether_mhop(hr_dev, table->type))
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index c0e819e..cb6cf11 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -310,7 +310,7 @@ static int hns_roce_modify_port(struct ib_device *ib_dev, u8 port_num, int mask,
 static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 				   struct ib_udata *udata)
 {
-	int ret = 0;
+	int ret;
 	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
 	struct hns_roce_ib_alloc_ucontext_resp resp = {};
 	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index 8134013..0f34b19 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -94,7 +94,7 @@ void hns_roce_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 int hns_roce_uar_alloc(struct hns_roce_dev *hr_dev, struct hns_roce_uar *uar)
 {
 	struct resource *res;
-	int ret = 0;
+	int ret;
 
 	/* Using bitmap to manager UAR index */
 	ret = hns_roce_bitmap_alloc(&hr_dev->uar_table.bitmap, &uar->logic_idx);
-- 
1.9.1

