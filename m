Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753AE639553
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Nov 2022 11:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiKZKaO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Nov 2022 05:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKZKaK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 26 Nov 2022 05:30:10 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519E428711;
        Sat, 26 Nov 2022 02:30:09 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NK7JX6J8Cz15Mmc;
        Sat, 26 Nov 2022 18:29:32 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 18:30:07 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 18:30:06 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xuhaoyue1@hisilicon.com>
Subject: [PATCH for-next 5/6] RDMA/hns: Fix error code of CMD
Date:   Sat, 26 Nov 2022 18:29:10 +0800
Message-ID: <20221126102911.2921820-6-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20221126102911.2921820-1-xuhaoyue1@hisilicon.com>
References: <20221126102911.2921820-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

From: Chengchang Tang <tangchengchang@huawei.com>

The error code is fixed to EIO when CMD fails to excute. This patch
converts the error status reported by firmware to linux errno.

Fixes: a04ff739f2a9 ("RDMA/hns: Add command queue support for hip08 RoCE driver")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 26 +++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  5 +++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6e74735bbcf8..f32100c6f1d9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1277,6 +1277,30 @@ static void update_cmdq_status(struct hns_roce_dev *hr_dev)
 		hr_dev->cmd.state = HNS_ROCE_CMDQ_STATE_FATAL_ERR;
 }
 
+static int hns_roce_cmd_err_convert_errno(u16 desc_ret)
+{
+	struct hns_roce_cmd_errcode errcode_table[] = {
+		{CMD_EXEC_SUCCESS, 0},
+		{CMD_NO_AUTH, -EPERM},
+		{CMD_NOT_EXIST, -EOPNOTSUPP},
+		{CMD_CRQ_FULL, -EXFULL},
+		{CMD_NEXT_ERR, -ENOSR},
+		{CMD_NOT_EXEC, -ENOTBLK},
+		{CMD_PARA_ERR, -EINVAL},
+		{CMD_RESULT_ERR, -ERANGE},
+		{CMD_TIMEOUT, -ETIME},
+		{CMD_HILINK_ERR, -ENOLINK},
+		{CMD_INFO_ILLEGAL, -ENXIO},
+		{CMD_INVALID, -EBADR},
+	};
+	u16 i;
+
+	for (i = 0; i < ARRAY_SIZE(errcode_table); i++)
+		if (desc_ret == errcode_table[i].return_status)
+			return errcode_table[i].errno;
+	return -EIO;
+}
+
 static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_cmq_desc *desc, int num)
 {
@@ -1322,7 +1346,7 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 			dev_err_ratelimited(hr_dev->dev,
 					    "Cmdq IO error, opcode = 0x%x, return = 0x%x.\n",
 					    desc->opcode, desc_ret);
-			ret = -EIO;
+			ret = hns_roce_cmd_err_convert_errno(desc_ret);
 		}
 	} else {
 		/* FW/HW reset or incorrect number of desc */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 017462e52843..47fad456839d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -273,6 +273,11 @@ enum hns_roce_cmd_return_status {
 	CMD_OTHER_ERR = 0xff
 };
 
+struct hns_roce_cmd_errcode {
+	enum hns_roce_cmd_return_status return_status;
+	int errno;
+};
+
 enum hns_roce_sgid_type {
 	GID_TYPE_FLAG_ROCE_V1 = 0,
 	GID_TYPE_FLAG_ROCE_V2_IPV4,
-- 
2.30.0

