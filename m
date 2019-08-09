Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3369D87674
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 11:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfHIJp3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Aug 2019 05:45:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405764AbfHIJp2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 9 Aug 2019 05:45:28 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DE3FFEB024A772756ADD;
        Fri,  9 Aug 2019 17:45:26 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 9 Aug 2019 17:45:20 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 5/9] RDMA/hns: Bugfix for slab-out-of-bounds when unloading hip08 driver
Date:   Fri, 9 Aug 2019 17:41:02 +0800
Message-ID: <1565343666-73193-6-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

kasan will report a BUG when run command 'rmmod hns_roce_hw_v2', the calltrace
is as follows:

==================================================================
BUG: KASAN: slab-out-of-bounds in hns_roce_table_mhop_put+0x584/0x828
[hns_roce]
Read of size 8 at addr ffff802185e08300 by task rmmod/270

Call trace:
dump_backtrace+0x0/0x1e8
show_stack+0x14/0x20
dump_stack+0xc4/0xfc
print_address_description+0x60/0x270
__kasan_report+0x164/0x1b8
kasan_report+0xc/0x18
__asan_load8+0x84/0xa8
hns_roce_table_mhop_put+0x584/0x828 [hns_roce]
hns_roce_table_put+0x174/0x1a0 [hns_roce]
hns_roce_mr_free+0x124/0x210 [hns_roce]
hns_roce_dereg_mr+0x90/0xb8 [hns_roce]
ib_dealloc_pd_user+0x60/0xf0
ib_mad_port_close+0x128/0x1d8
ib_mad_remove_device+0x94/0x118
remove_client_context+0xa0/0xe0
disable_device+0xfc/0x1c0
__ib_unregister_device+0x60/0xe0
ib_unregister_device+0x24/0x38
hns_roce_exit+0x3c/0x138 [hns_roce]
__hns_roce_hw_v2_uninit_instance.isra.30+0x28/0x50 [hns_roce_hw_v2]
hns_roce_hw_v2_uninit_instance+0x44/0x60 [hns_roce_hw_v2]
hclge_uninit_client_instance+0x15c/0x238 [hclge]
hnae3_uninit_client_instance+0x84/0xa8 [hnae3]
hnae3_unregister_client+0x84/0x158 [hnae3]
hns_roce_hw_v2_exit+0x14/0x20 [hns_roce_hw_v2]
__arm64_sys_delete_module+0x20c/0x308
el0_svc_handler+0xbc/0x210
el0_svc+0x8/0xc

Allocated by task 255:
__kasan_kmalloc.isra.0+0xd0/0x180
kasan_kmalloc+0xc/0x18
__kmalloc+0x16c/0x328
hns_roce_init_hem_table+0x20c/0x428 [hns_roce]
hns_roce_init+0x214/0xfe0 [hns_roce]
__hns_roce_hw_v2_init_instance+0x284/0x330 [hns_roce_hw_v2]
hns_roce_hw_v2_init_instance+0xd0/0x1b8 [hns_roce_hw_v2]
hclge_init_roce_client_instance+0x180/0x310 [hclge]
hclge_init_client_instance+0xcc/0x508 [hclge]
hnae3_init_client_instance.part.3+0x3c/0x80 [hnae3]
hnae3_register_client+0x134/0x1a8 [hnae3]
0xffff200009c00014
do_one_initcall+0x9c/0x3e0
do_init_module+0xd4/0x2d8
load_module+0x3284/0x3690
__se_sys_init_module+0x274/0x308
__arm64_sys_init_module+0x40/0x50
el0_svc_handler+0xbc/0x210
el0_svc+0x8/0xc

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff802185e06300
which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 0 bytes to the right of
8192-byte region [ffff802185e06300, ffff802185e08300)
The buggy address belongs to the page:
page:ffff7fe008617800 refcount:1 mapcount:0 mapping:ffff802340020e00 index:0x0
compound_mapcount: 0
flags: 0x5fffe00000010200(slab|head)
raw: 5fffe00000010200 dead000000000100 dead000000000200 ffff802340020e00
raw: 0000000000000000 00000000803e003e 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff802185e08200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff802185e08280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff802185e08300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
^
ffff802185e08380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff802185e08400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
Disabling lock debugging due to kernel taint

Fixes: a25d13cbe816 ("RDMA/hns: Add the interfaces to support multi hop addressing for the contexts in hip08")

Signed-off-by: Xi Wang <wangxi11@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 0268c7a..f2c4fef 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -85,12 +85,13 @@ bool hns_roce_check_whether_mhop(struct hns_roce_dev *hr_dev, u32 type)
 }
 
 static bool hns_roce_check_hem_null(struct hns_roce_hem **hem, u64 start_idx,
-			    u32 bt_chunk_num)
+			    u32 bt_chunk_num, u64 hem_max_num)
 {
-	int i;
+	u64 check_max_num = start_idx + bt_chunk_num;
+	u64 i;
 
-	for (i = 0; i < bt_chunk_num; i++)
-		if (hem[start_idx + i])
+	for (i = start_idx; (i < check_max_num) && (i < hem_max_num); i++)
+		if (hem[i])
 			return false;
 
 	return true;
@@ -496,6 +497,12 @@ static int hns_roce_table_mhop_get(struct hns_roce_dev *hr_dev,
 		return -EINVAL;
 	}
 
+	if (unlikely(hem_idx >= table->num_hem)) {
+		dev_err(dev, "Table %d exceed hem limt idx = %llu,max = %lu!\n",
+			     table->type, hem_idx, table->num_hem);
+		return -EINVAL;
+	}
+
 	mutex_lock(&table->mutex);
 
 	if (table->hem[hem_idx]) {
@@ -732,7 +739,7 @@ static void hns_roce_table_mhop_put(struct hns_roce_dev *hr_dev,
 	if (check_whether_bt_num_2(table->type, hop_num)) {
 		start_idx = mhop.l0_idx * chunk_ba_num;
 		if (hns_roce_check_hem_null(table->hem, start_idx,
-					    chunk_ba_num)) {
+					    chunk_ba_num, table->num_hem)) {
 			if (table->type < HEM_TYPE_MTT &&
 			    hr_dev->hw->clear_hem(hr_dev, table, obj, 0))
 				dev_warn(dev, "Clear HEM base address failed.\n");
@@ -746,7 +753,7 @@ static void hns_roce_table_mhop_put(struct hns_roce_dev *hr_dev,
 		start_idx = mhop.l0_idx * chunk_ba_num * chunk_ba_num +
 			    mhop.l1_idx * chunk_ba_num;
 		if (hns_roce_check_hem_null(table->hem, start_idx,
-					    chunk_ba_num)) {
+					    chunk_ba_num, table->num_hem)) {
 			if (hr_dev->hw->clear_hem(hr_dev, table, obj, 1))
 				dev_warn(dev, "Clear HEM base address failed.\n");
 
-- 
1.9.1

