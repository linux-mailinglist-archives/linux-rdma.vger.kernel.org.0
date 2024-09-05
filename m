Return-Path: <linux-rdma+bounces-4776-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8929696DA04
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 15:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6841F21DEA
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 13:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0134D19D8A2;
	Thu,  5 Sep 2024 13:17:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEF419D096;
	Thu,  5 Sep 2024 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542270; cv=none; b=nPZNcezGxwM1B/ZCnIifl/4EOrAGIQ4+X0I5Q6Vjp6TDIzleg2PlEv2o89Xyp7nIQUsfzMKrf+k8TYGy14T3xsWOP68Jyu+rAIf7HRMLDvFuXL7FO9uQR32VJo2Dvp3SiBAtD2GGNivRltTYJyLc5I5YfCmLkyWJXaXiQ066GEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542270; c=relaxed/simple;
	bh=ztvcn8LTc1wNPg6zZTSXEQJytmb853G+7kwMM5CIXXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+tKsedGQyc1eJKdO38P3seNFkoVKrw/PS7G/l84KoXfJwTKo+X8PF3/jD1j6w9EbwJ8WqD4k+lTIP+NjPqkwn/cRp128ziF6s8/4A41Ktzbwt3PuaFZAKpyQnFDNcxJxQbL5ZXniOYgnV0hdlOPjwwYav/w4QCOJgRBKK5YKbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X00Jg44kYz2DbnW;
	Thu,  5 Sep 2024 21:17:23 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 533E91A0188;
	Thu,  5 Sep 2024 21:17:45 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Sep 2024 21:17:44 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v4 for-next 2/2] RDMA/hns: Disassociate mmap pages for all uctx when HW is being reset
Date: Thu, 5 Sep 2024 21:11:55 +0800
Message-ID: <20240905131155.1441478-3-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240905131155.1441478-1-huangjunxian6@hisilicon.com>
References: <20240905131155.1441478-1-huangjunxian6@hisilicon.com>
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


