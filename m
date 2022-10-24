Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E98609CED
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 10:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJXIjR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 04:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJXIjP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 04:39:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F30960504
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 01:39:14 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MwpJs1N5rzmVLn;
        Mon, 24 Oct 2022 16:34:21 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 16:39:10 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 16:39:08 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>, <xuhaoyue1@hisilicon.com>
Subject: [PATCH 2/2] RDMA/hns: Fix null pointer problem in free_mr_init
Date:   Mon, 24 Oct 2022 16:38:14 +0800
Message-ID: <20221024083814.1089722-3-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221024083814.1089722-1-xuhaoyue1@hisilicon.com>
References: <20221024083814.1089722-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

lock grab occurs in a concurrent scenario,
resulting in stepping on a null pointer.
It should be init mutex_init first before use the lock.

[ 2658.042814] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[ 2658.043738] Mem abort info:
[ 2658.044024] ESR = 0x96000046
[ 2658.044337] EC = 0x25: DABT (current EL), IL = 32 bits
[ 2658.044883] SET = 0, FnV = 0
[ 2658.045196] EA = 0, S1PTW = 0
[ 2658.045516] FSC = 0x06: level 2 translation fault
[ 2658.046011] Data abort info:
[ 2658.046309] ISV = 0, ISS = 0x00000046
[ 2658.046698] CM = 0, WnR = 1
[ 2658.047032] user pgtable: 4k pages, 48-bit VAs, pgdp=00000001304e0000
[ 2658.047678] [0000000000000000] pgd=0800000140c4f003, p4d=0800000140c4f003, pud=08000001415f0003, pmd=0000000000000000
[ 2658.048730] Internal error: Oops: 96000046 [#1] PREEMPT SMP
[ 2658.049276] Modules linked in: hns_roce_hw_v2 hns3 hclgevf hclge hnae3 [last unloaded: hns_roce_hw_v2]
[ 2658.050208] CPU: 1 PID: 378 Comm: roce_test_main Tainted: G W 5.18.0-rc4+ #1
[ 2658.051063] Hardware name: linux,dummy-virt (DT)
[ 2658.051562] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 2658.052307] pc : __mutex_lock.constprop.0+0xd0/0x5c0
[ 2658.053109] lr : __mutex_lock.constprop.0+0x98/0x5c0
[ 2658.053646] sp : ffff8000088db640
[ 2658.054009] x29: ffff8000088db640 x28: 0000000000000001 x27: ffff0001016a6980
[ 2658.054785] x26: 0000000000000010 x25: ffff8000088dbc18 x24: ffff000100f098a8
[ 2658.055548] x23: ffff000100f098a0 x22: 0000000000000002 x21: ffff8000088db688
[ 2658.056313] x20: ffff00010019b000 x19: ffff000100f09898 x18: 0000000000000000
[ 2658.057076] x17: 0000000000000000 x16: ffffb61915c77270 x15: 0000ffffe5c8dfc8
[ 2658.057847] x14: 0000000000003880 x13: 0000000000000000 x12: 0000000000000040
[ 2658.058614] x11: ffff0000e07cf478 x10: 0000000000000002 x9 : ffffb61915c76c18
[ 2658.059386] x8 : 0000000000000238 x7 : ffffb619169ec008 x6 : 0000000000000000
[ 2658.060150] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff00010019c000
[ 2658.060919] x2 : ffff00010019b000 x1 : ffff00010019b000 x0 : 0000000000000000
[ 2658.061687] Call trace:
[ 2658.061958] __mutex_lock.constprop.0+0xd0/0x5c0
[ 2658.062444] __mutex_lock_slowpath+0x1c/0x2c
[ 2658.062919] mutex_lock+0x44/0x50
[ 2658.063280] free_mr_send_cmd_to_hw+0x7c/0x1c0 [hns_roce_hw_v2]
[ 2658.063923] hns_roce_v2_dereg_mr+0x30/0x40 [hns_roce_hw_v2]
[ 2658.064538] hns_roce_dereg_mr+0x4c/0x130 [hns_roce_hw_v2]
[ 2658.065132] ib_dereg_mr_user+0x54/0x124
[ 2658.065559] uverbs_free_mr+0x24/0x30
[ 2658.065961] destroy_hw_idr_uobject+0x38/0x74
[ 2658.066431] uverbs_destroy_uobject+0x48/0x1c4
[ 2658.066926] uobj_destroy+0x74/0xcc
[ 2658.067306] ib_uverbs_cmd_verbs+0x368/0xbb0
[ 2658.067769] ib_uverbs_ioctl+0xec/0x1a4
[ 2658.068187] __arm64_sys_ioctl+0xb4/0x100
[ 2658.068630] invoke_syscall+0x50/0x120
[ 2658.069039] el0_svc_common.constprop.0+0x58/0x190
[ 2658.069552] do_el0_svc+0x30/0x90
[ 2658.069912] el0_svc+0x2c/0xb4
[ 2658.070248] el0t_64_sync_handler+0x1a4/0x1b0
[ 2658.070718] el0t_64_sync+0x19c/0x1a0
[ 2658.071122] Code: f9000e75 d5384101 a90483f8 f9002fe1 (f9000015)
[ 2658.071777] ---[ end trace 0000000000000000 ]---

Fixes: 70f92521584f ("RDMA/hns: Use the reserved loopback QPs to free MR before destroying MPT")
Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7f5a4769cee0..1435fe2ea176 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2801,8 +2801,12 @@ static int free_mr_modify_qp(struct hns_roce_dev *hr_dev)
 
 static int free_mr_init(struct hns_roce_dev *hr_dev)
 {
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
 	int ret;
 
+	mutex_init(&free_mr->mutex);
+
 	ret = free_mr_alloc_res(hr_dev);
 	if (ret)
 		return ret;
-- 
2.30.0

