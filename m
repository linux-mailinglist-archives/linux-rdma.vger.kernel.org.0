Return-Path: <linux-rdma+bounces-4605-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E807C962007
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 08:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E4C2866B7
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 06:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512251586DB;
	Wed, 28 Aug 2024 06:51:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC1E1448E6;
	Wed, 28 Aug 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724827917; cv=none; b=pF6odG1Y/YRz60EnoWVt9kz5V1jtHHJXtmXoqB6fGzYFRhMq6+2FTcxTCalclyTS6h3e0mvq9MWzRyg+nw2/G40rL0r6oQGm1pXXvje92NnhaPqOkmhTv46dETM/ROIW1Ri3D2znmP9fW7UcjLbqVJYkdvt8ay8zfV4EJXL3lEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724827917; c=relaxed/simple;
	bh=ztvcn8LTc1wNPg6zZTSXEQJytmb853G+7kwMM5CIXXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKZ1chXtXHWtbbTdA6yq8Zjkao/rbvaW5jHmdffnCfUBlM1R8u0ViKEBONa/5QmK3z07mKAs3/P959uYB1sQPi4oU3YvOlGCgfzcbL8tcTKdwebUXd3/6VmqdjxJM5sFD2/N6JBL544M3pAp6AQKT7jozEzqhHy/hgdnBiftLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wtw5X5ZM0zpTrS;
	Wed, 28 Aug 2024 14:50:08 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 88B771402CD;
	Wed, 28 Aug 2024 14:51:50 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 Aug 2024 14:51:50 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v3 for-next 2/2] RDMA/hns: Disassociate mmap pages for all uctx when HW is being reset
Date: Wed, 28 Aug 2024 14:46:05 +0800
Message-ID: <20240828064605.887519-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240828064605.887519-1-huangjunxian6@hisilicon.com>
References: <20240828064605.887519-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 621b057fb9da..ecf4f1c9f51d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -7012,6 +7012,12 @@ static void hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 
 	handle->rinfo.instance_state = HNS_ROCE_STATE_NON_INIT;
 }
+
+static void hns_roce_v2_reset_notify_user(struct hns_roce_dev *hr_dev)
+{
+	rdma_user_mmap_disassociate(&hr_dev->ib_dev);
+}
+
 static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 {
 	struct hns_roce_dev *hr_dev;
@@ -7030,6 +7036,9 @@ static int hns_roce_hw_v2_reset_notify_down(struct hnae3_handle *handle)
 
 	hr_dev->active = false;
 	hr_dev->dis_db = true;
+
+	hns_roce_v2_reset_notify_user(hr_dev);
+
 	hr_dev->state = HNS_ROCE_DEVICE_STATE_RST_DOWN;
 
 	return 0;
-- 
2.33.0


