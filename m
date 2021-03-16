Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17CF33CF64
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Mar 2021 09:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhCPIL6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Mar 2021 04:11:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:13937 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbhCPILu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Mar 2021 04:11:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F05Yz5P1xzkZH0;
        Tue, 16 Mar 2021 16:10:15 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 16 Mar 2021 16:11:42 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next] RDMA/hns: Support to query firmware version
Date:   Tue, 16 Mar 2021 16:09:21 +0800
Message-ID: <1615882161-53827-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Implement the ops named get_dev_fw_str to support ib_get_device_fw_str().

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 1a747f7..2b9e501 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -394,6 +394,19 @@ static void hns_roce_disassociate_ucontext(struct ib_ucontext *ibcontext)
 {
 }
 
+static void hns_roce_get_fw_ver(struct ib_device *device, char *str)
+{
+	u64 fw_ver = to_hr_dev(device)->caps.fw_ver;
+	unsigned int major, minor, sub_minor;
+
+	major = upper_32_bits(fw_ver);
+	minor = high_16_bits(lower_32_bits(fw_ver));
+	sub_minor = low_16_bits(fw_ver);
+
+	snprintf(str, IB_FW_VERSION_NAME_MAX, "%u.%u.%04u", major, minor,
+		 sub_minor);
+}
+
 static void hns_roce_unregister_device(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_ib_iboe *iboe = &hr_dev->iboe;
@@ -409,6 +422,7 @@ static const struct ib_device_ops hns_roce_dev_ops = {
 	.uverbs_abi_ver = 1,
 	.uverbs_no_driver_id_binding = 1,
 
+	.get_dev_fw_str = hns_roce_get_fw_ver,
 	.add_gid = hns_roce_add_gid,
 	.alloc_pd = hns_roce_alloc_pd,
 	.alloc_ucontext = hns_roce_alloc_ucontext,
-- 
2.8.1

