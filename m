Return-Path: <linux-rdma+bounces-4336-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A450794ED96
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 15:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2775B1F21087
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 13:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F7017C224;
	Mon, 12 Aug 2024 13:02:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99BA17ADFE;
	Mon, 12 Aug 2024 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467742; cv=none; b=VNmbwRcv9NfvxZLKQwpYTn9ITegeiiqPm7y5fZ0Fxd8/XYkxjcQUXRew75eYvK1BsWKtJUfZuOhV/Bp4X00WvLwlsSl0RuNWrodJS/iS+WycKxHm34TUCtIOIx6bLDzHzUN2bIYHwojClsLe8FnJmdCIdZAqX/fH45GMBaw6yic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467742; c=relaxed/simple;
	bh=j91RiwEaFhRZ12K10kri7az6g9P3d4C2oyNIcGBE6o8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orqL2CReVYQ2mjwt5bDfAUwn6/3bUX9UB6V38UY3xhzRdtQ20P8kmmx8sfBvq9y/nZUNGtt4DpjeUXnnczYFfxaJi2FdHngRnNWyZ0VWT/w1LEQ5AIIupg/cuyRUTcJUOc0iq+LXmWYRifed2DFmMu3F5UC4ASi8Fv+xWmnV8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WjF2q2TV8z1HFwv;
	Mon, 12 Aug 2024 20:59:15 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 97A931402CF;
	Mon, 12 Aug 2024 21:02:17 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Aug 2024 21:02:17 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 3/3] RDMA/hns: Disassociate mmap pages for all uctx when HW is being reset
Date: Mon, 12 Aug 2024 20:56:40 +0800
Message-ID: <20240812125640.1003948-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240812125640.1003948-1-huangjunxian6@hisilicon.com>
References: <20240812125640.1003948-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)

From: Chengchang Tang <tangchengchang@huawei.com>

When HW is being reset, userspace should not ring doorbell otherwise
it may lead to abnormal consequence such as RAS.

Disassociate mmap pages for all uctx to prevent userspace from ringing
doorbell to HW.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 621b057fb9da..e30610a426b3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -7012,6 +7012,20 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 
 	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
 }
+
+static void hns_roce_v2_reset_notify_user(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_ucontext *uctx, *tmp;
+
+	mutex_lock(&hr_dev->uctx_list_mutex);
+	list_for_each_entry_safe(uctx, tmp, &hr_dev->uctx_list, list) {
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
+		rdma_user_mmap_disassociate(&uctx->ibucontext);
+#endif
+	}
+	mutex_unlock(&hr_dev->uctx_list_mutex);
+}
+
 static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 {
 	struct hns_roce_dev *hr_dev;
@@ -7030,6 +7044,9 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 
 	hr_dev->active = false;
 	hr_dev->dis_db = true;
+
+	hns_roce_v2_reset_notify_user(hr_dev);
+
 	hr_dev->state = HNS_ROCE_DEVICE_STATE_RST_DOWN;
 
 	return 0;
-- 
2.33.0


