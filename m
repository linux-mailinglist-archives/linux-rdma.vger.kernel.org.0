Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8BD3F1022
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 03:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhHSB53 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 21:57:29 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17041 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbhHSB53 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Aug 2021 21:57:29 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Gqnpq21C2zbfpS;
        Thu, 19 Aug 2021 09:53:07 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 09:56:52 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 09:56:52 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [PATCH v2 for-next] RDMA/hns: Solve the problem that dma_pool is used during the reset
Date:   Thu, 19 Aug 2021 09:53:04 +0800
Message-ID: <1629337984-24459-2-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1629337984-24459-1-git-send-email-liangwenpeng@huawei.com>
References: <1629337984-24459-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

During the reset, the driver calls dma_pool_destroy() to release the
dma_pool resources. If the dma_pool_free interface is called during the
modify_qp operation, an exception will occur.

[15834.440744] Unable to handle kernel paging request at virtual address
ffffa2cfc7725678
...
[15834.660596] Call trace:
[15834.663033]  queued_spin_lock_slowpath+0x224/0x308
[15834.667802]  _raw_spin_lock_irqsave+0x78/0x88
[15834.672140]  dma_pool_free+0x34/0x118
[15834.675799]  hns_roce_free_cmd_mailbox+0x54/0x88 [hns_roce_hw_v2]
[15834.681872]  hns_roce_v2_qp_modify.isra.57+0xcc/0x120 [hns_roce_hw_v2]
[15834.688376]  hns_roce_v2_modify_qp+0x4d4/0x1ef8 [hns_roce_hw_v2]
[15834.694362]  hns_roce_modify_qp+0x214/0x5a8 [hns_roce_hw_v2]
[15834.699996]  _ib_modify_qp+0xf0/0x308
[15834.703642]  ib_modify_qp+0x38/0x48
[15834.707118]  rt_ktest_modify_qp+0x14c/0x998 [rdma_test]
...
[15837.269216] Unable to handle kernel paging request at virtual address
000197c995a1d1b4
...
[15837.480898] Call trace:
[15837.483335]  __free_pages+0x28/0x78
[15837.486807]  dma_direct_free_pages+0xa0/0xe8
[15837.491058]  dma_direct_free+0x48/0x60
[15837.494790]  dma_free_attrs+0xa4/0xe8
[15837.498449]  hns_roce_buf_free+0xb0/0x150 [hns_roce_hw_v2]
[15837.503918]  mtr_free_bufs.isra.1+0x88/0xc0 [hns_roce_hw_v2]
[15837.509558]  hns_roce_mtr_destroy+0x60/0x80 [hns_roce_hw_v2]
[15837.515198]  hns_roce_v2_cleanup_eq_table+0x1d0/0x2a0 [hns_roce_hw_v2]
[15837.521701]  hns_roce_exit+0x108/0x1e0 [hns_roce_hw_v2]
[15837.526908]  __hns_roce_hw_v2_uninit_instance.isra.75+0x70/0xb8 [hns_roce_hw_v2]
[15837.534276]  hns_roce_hw_v2_uninit_instance+0x64/0x80 [hns_roce_hw_v2]
[15837.540786]  hclge_uninit_client_instance+0xe8/0x1e8 [hclge]
[15837.546419]  hnae3_uninit_client_instance+0xc4/0x118 [hnae3]
[15837.552052]  hnae3_unregister_client+0x16c/0x1f0 [hnae3]
[15837.557346]  hns_roce_hw_v2_exit+0x34/0x50 [hns_roce_hw_v2]
[15837.562895]  __arm64_sys_delete_module+0x208/0x268
[15837.567665]  el0_svc_common.constprop.4+0x110/0x200
[15837.572520]  do_el0_svc+0x34/0x98
[15837.575821]  el0_svc+0x14/0x40
[15837.578862]  el0_sync_handler+0xb0/0x2d0
[15837.582766]  el0_sync+0x140/0x180

It is caused by two concurrent processes:
	uninit_instance->dma_pool_destroy(cmdq)
	modify_qp->dma_poll_free(cmdq)

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cmd.c    | 12 ++++++++++++
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 8f68cc3..3dfb97a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -198,12 +198,16 @@ int hns_roce_cmd_init(struct hns_roce_dev *hr_dev)
 	if (!hr_dev->cmd.pool)
 		return -ENOMEM;

+	init_rwsem(&hr_dev->cmd.mb_rwsem);
+
 	return 0;
 }

 void hns_roce_cmd_cleanup(struct hns_roce_dev *hr_dev)
 {
+	down_write(&hr_dev->cmd.mb_rwsem);
 	dma_pool_destroy(hr_dev->cmd.pool);
+	up_write(&hr_dev->cmd.mb_rwsem);
 }

 int hns_roce_cmd_use_events(struct hns_roce_dev *hr_dev)
@@ -237,8 +241,10 @@ void hns_roce_cmd_use_polling(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmdq *hr_cmd = &hr_dev->cmd;

+	down_write(&hr_dev->cmd.mb_rwsem);
 	kfree(hr_cmd->context);
 	hr_cmd->use_events = 0;
+	up_write(&hr_dev->cmd.mb_rwsem);

 	up(&hr_cmd->poll_sem);
 }
@@ -252,9 +258,12 @@ hns_roce_alloc_cmd_mailbox(struct hns_roce_dev *hr_dev)
 	if (!mailbox)
 		return ERR_PTR(-ENOMEM);

+	down_read(&hr_dev->cmd.mb_rwsem);
 	mailbox->buf =
 		dma_pool_alloc(hr_dev->cmd.pool, GFP_KERNEL, &mailbox->dma);
 	if (!mailbox->buf) {
+		up_read(&hr_dev->cmd.mb_rwsem);
+
 		kfree(mailbox);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -269,5 +278,8 @@ void hns_roce_free_cmd_mailbox(struct hns_roce_dev *hr_dev,
 		return;

 	dma_pool_free(hr_dev->cmd.pool, mailbox->buf, mailbox->dma);
+
+	up_read(&hr_dev->cmd.mb_rwsem);
+
 	kfree(mailbox);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 0c3eb11..90d8ef8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -571,6 +571,7 @@ struct hns_roce_cmdq {
 	 * close device, switch into poll mode(non event mode)
 	 */
 	u8			use_events;
+	struct rw_semaphore	mb_rwsem;
 };

 struct hns_roce_cmd_mailbox {
--
2.8.1

