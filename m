Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2354E8767B
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406120AbfHIJpe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Aug 2019 05:45:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55538 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405773AbfHIJpe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 9 Aug 2019 05:45:34 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C585D7AD63B6C701E89A;
        Fri,  9 Aug 2019 17:45:31 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 9 Aug 2019 17:45:21 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 6/9] RDMA/hns: bugfix for slab-out-of-bounds when loading hip08 driver
Date:   Fri, 9 Aug 2019 17:41:03 +0800
Message-ID: <1565343666-73193-7-git-send-email-oulijun@huawei.com>
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

kasan will report a BUG when run command 'insmod hns_roce_hw_v2.ko', the
calltrace is as follows:

==================================================================
BUG: KASAN: slab-out-of-bounds in hns_roce_v2_init_eq_table+0x1324/0x1948
[hns_roce_hw_v2]
Read of size 8 at addr ffff8020e7a10608 by task insmod/256

CPU: 0 PID: 256 Comm: insmod Tainted: G           O      5.2.0-rc4 #1
Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0
Call trace:
dump_backtrace+0x0/0x1e8
show_stack+0x14/0x20
dump_stack+0xc4/0xfc
print_address_description+0x60/0x270
__kasan_report+0x164/0x1b8
kasan_report+0xc/0x18
__asan_load8+0x84/0xa8
hns_roce_v2_init_eq_table+0x1324/0x1948 [hns_roce_hw_v2]
hns_roce_init+0xf8/0xfe0 [hns_roce]
__hns_roce_hw_v2_init_instance+0x284/0x330 [hns_roce_hw_v2]
hns_roce_hw_v2_init_instance+0xd0/0x1b8 [hns_roce_hw_v2]
hclge_init_roce_client_instance+0x180/0x310 [hclge]
hclge_init_client_instance+0xcc/0x508 [hclge]
hnae3_init_client_instance.part.3+0x3c/0x80 [hnae3]
hnae3_register_client+0x134/0x1a8 [hnae3]
hns_roce_hw_v2_init+0x14/0x10000 [hns_roce_hw_v2]
do_one_initcall+0x9c/0x3e0
do_init_module+0xd4/0x2d8
load_module+0x3284/0x3690
__se_sys_init_module+0x274/0x308
__arm64_sys_init_module+0x40/0x50
el0_svc_handler+0xbc/0x210
el0_svc+0x8/0xc

Allocated by task 256:
__kasan_kmalloc.isra.0+0xd0/0x180
kasan_kmalloc+0xc/0x18
__kmalloc+0x16c/0x328
hns_roce_v2_init_eq_table+0x764/0x1948 [hns_roce_hw_v2]
hns_roce_init+0xf8/0xfe0 [hns_roce]
__hns_roce_hw_v2_init_instance+0x284/0x330 [hns_roce_hw_v2]
hns_roce_hw_v2_init_instance+0xd0/0x1b8 [hns_roce_hw_v2]
hclge_init_roce_client_instance+0x180/0x310 [hclge]
hclge_init_client_instance+0xcc/0x508 [hclge]
hnae3_init_client_instance.part.3+0x3c/0x80 [hnae3]
hnae3_register_client+0x134/0x1a8 [hnae3]
hns_roce_hw_v2_init+0x14/0x10000 [hns_roce_hw_v2]
do_one_initcall+0x9c/0x3e0
do_init_module+0xd4/0x2d8
load_module+0x3284/0x3690
__se_sys_init_module+0x274/0x308
__arm64_sys_init_module+0x40/0x50
el0_svc_handler+0xbc/0x210
el0_svc+0x8/0xc

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8020e7a10600
which belongs to the cache kmalloc-128 of size 128
The buggy address is located 8 bytes inside of
128-byte region [ffff8020e7a10600, ffff8020e7a10680)
The buggy address belongs to the page:
page:ffff7fe00839e840 refcount:1 mapcount:0 mapping:ffff802340020200 index:0x0
flags: 0x5fffe00000000200(slab)
raw: 5fffe00000000200 dead000000000100 dead000000000200 ffff802340020200
raw: 0000000000000000 0000000081000100 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff8020e7a10500: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
ffff8020e7a10580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8020e7a10600: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
^
ffff8020e7a10680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff8020e7a10700: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
Disabling lock debugging due to kernel taint

Fixes: a5073d6054f7 ("RDMA/hns: Add eq support of hip08")

Signed-off-by: Xi Wang <wangxi11@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c6b55a1..d33341e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5543,7 +5543,8 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
 				break;
 		}
 		eq->cur_eqe_ba = eq->buf_dma[0];
-		eq->nxt_eqe_ba = eq->buf_dma[1];
+		if (ba_num > 1)
+			eq->nxt_eqe_ba = eq->buf_dma[1];
 
 	} else if (mhop_num == 2) {
 		/* alloc L1 BT and buf */
@@ -5584,7 +5585,8 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
 				break;
 		}
 		eq->cur_eqe_ba = eq->buf_dma[0];
-		eq->nxt_eqe_ba = eq->buf_dma[1];
+		if (ba_num > 1)
+			eq->nxt_eqe_ba = eq->buf_dma[1];
 	}
 
 	eq->l0_last_num = i + 1;
-- 
1.9.1

