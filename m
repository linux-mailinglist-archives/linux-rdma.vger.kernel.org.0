Return-Path: <linux-rdma+bounces-7791-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D034A37BDF
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 08:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647261689C7
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 07:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED7E1990DE;
	Mon, 17 Feb 2025 07:08:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D1A198A36
	for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2025 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776137; cv=none; b=cDong8tazOa1ncZdGHuc1OEtUPlMnJ0Usztu1Jfp/2BtfA2eSe2eqkZ6PvnI6Cv/B7BSw97oolaICdNtDMRLQVQRZR9+kAwXbLDEuS7dijUzMXsm/hSqyhz7WVSHFBYzNj4nwB1cuSEwiB47JWEQnvaRczJsC8pFayrDbPPPX5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776137; c=relaxed/simple;
	bh=p6Yp2cDP9dwvPaBhSLVNnO2Yox90hQPL3/mahjX3dHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDquaNLW41F+kvB4Oh5CluVnhaNnWr2Ybafvr3bM53OfWvN9yt12VQCW0Eic+7RvvF99Ljj3kHQlgDIPmwlk5VaU+G7NeWy+ssvzVTs4EwTKnCd7jhyB4mbnVyzybS/HuNkux2TO2HEID1gEkynp43aCz5EV2UbcTYoce24jjKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YxDFK2sdTzgcY8;
	Mon, 17 Feb 2025 15:05:25 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 062311401F2;
	Mon, 17 Feb 2025 15:08:48 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Feb 2025 15:08:47 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 4/4] Revert "RDMA/hns: Do not destroy QP resources in the hw resetting phase"
Date: Mon, 17 Feb 2025 15:01:23 +0800
Message-ID: <20250217070123.3171232-5-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: wenglianfa <wenglianfa@huawei.com>

This reverts commit b0969f83890bf8b47f5c8bd42539599b2b52fdeb.

The reverted patch was aimed at delaying resource destruction when
HW resets to avoid HW UAF, but it didn't accomplish the task perfectly
as the problem still occurs when read_poll_timeout_atomic() times out.
Besides, read_poll_timeout_atomic() spends too much CPU time and may
lead to a CPU stuck under heavy load.

Now that we have a delay-destruction mechanism to fix the HW UAF
problem, revert this patch.

Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 86d6a8f2a26d..75bfd2117699 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -33,7 +33,6 @@
 #include <linux/acpi.h>
 #include <linux/etherdevice.h>
 #include <linux/interrupt.h>
-#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
@@ -1026,14 +1025,9 @@ static u32 hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
 					unsigned long instance_stage,
 					unsigned long reset_stage)
 {
-#define HW_RESET_TIMEOUT_US 1000000
-#define HW_RESET_SLEEP_US 1000
-
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hnae3_handle *handle = priv->handle;
 	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
-	unsigned long val;
-	int ret;
 
 	/* When hardware reset is detected, we should stop sending mailbox&cmq&
 	 * doorbell to hardware. If now in .init_instance() function, we should
@@ -1045,11 +1039,7 @@ static u32 hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
 	 * again.
 	 */
 	hr_dev->dis_db = true;
-
-	ret = read_poll_timeout(ops->ae_dev_reset_cnt, val,
-				val > hr_dev->reset_cnt, HW_RESET_SLEEP_US,
-				HW_RESET_TIMEOUT_US, false, handle);
-	if (!ret)
+	if (!ops->get_hw_reset_stat(handle))
 		hr_dev->is_reset = true;
 
 	if (!hr_dev->is_reset || reset_stage == HNS_ROCE_STATE_RST_INIT ||
-- 
2.33.0


