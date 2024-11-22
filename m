Return-Path: <linux-rdma+bounces-6068-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470AA9D5DA7
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 12:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CAB0284608
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 11:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC841DFDAD;
	Fri, 22 Nov 2024 10:59:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F81DF725;
	Fri, 22 Nov 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273193; cv=none; b=o2lBSagT28r1r95z40Yr5I1DABPOjd84E+HcSeTjP6cwy9laL8cDooZXKMu4xrG0iXD6NI76qS45w/fP9qrnb0odmD7nOEuYAPtX9P65gPAYwYymg3xLqenPAZx6w0T1i1h1M2SBX72NKK1+7qjhbfRIhbaqAuorNY4v9v6eHzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273193; c=relaxed/simple;
	bh=1Wj7Yzu0E8RUt7Bj5dLwlLLTOlU0YaF8am7C9hxLaI8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZZtFC6qTT5yWn+8Su+aMG+VbIW/vvCUbaihIMvvGCfp8cmNz/0+sfYICihVCPqjn1zYmkgPHv1C1XPz8+2aKj0uhRNgF2R9EBipMMKOeY4F1+BHA3oYhL+IYp078TbMSQJvuVQfiDMbZU+dj9tDAfIrI4lVwWeyd4B3fp/+4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XvsSH0X8Mz1JCqY;
	Fri, 22 Nov 2024 18:54:55 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E89E1A0188;
	Fri, 22 Nov 2024 18:59:48 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Nov 2024 18:59:47 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <selvin.xavier@broadcom.com>,
	<chengyou@linux.alibaba.com>, <kaishen@linux.alibaba.com>,
	<mustafa.ismail@intel.com>, <tatyana.e.nikolova@intel.com>,
	<yishaih@nvidia.com>, <benve@cisco.com>, <neescoba@cisco.com>,
	<bryan-bt.tan@broadcom.com>, <vishnu.dasa@broadcom.com>,
	<zyjzyj2000@gmail.com>, <bmt@zurich.ibm.com>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>, <liyuyu6@huawei.com>
Subject: [PATCH RFC 12/12] RDMA/hns: Support fast path for link-down events dispatching
Date: Fri, 22 Nov 2024 18:53:08 +0800
Message-ID: <20241122105308.2150505-13-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241122105308.2150505-1-huangjunxian6@hisilicon.com>
References: <20241122105308.2150505-1-huangjunxian6@hisilicon.com>
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

From: Yuyu Li <liyuyu6@huawei.com>

hns3 NIC driver can directly notify the RoCE driver about link status
events bypassing the netdev notifier. This can provide more timely
event dispatching for ULPs.

Signed-off-by: Yuyu Li <liyuyu6@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 697b17cca02e..5c911d1def03 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -7178,9 +7178,22 @@ static int hns_roce_hw_v2_reset_notify(struct hnae3_handle *handle,
 	return ret;
 }
 
+static void hns_roce_hw_v2_link_status_change(struct hnae3_handle *handle,
+					      bool linkup)
+{
+	struct hns_roce_dev *hr_dev = (struct hns_roce_dev *)handle->priv;
+	struct net_device *netdev = handle->rinfo.netdev;
+
+	if (linkup || !hr_dev)
+		return;
+
+	ib_dispatch_port_state_event(&hr_dev->ib_dev, netdev);
+}
+
 static const struct hnae3_client_ops hns_roce_hw_v2_ops = {
 	.init_instance = hns_roce_hw_v2_init_instance,
 	.uninit_instance = hns_roce_hw_v2_uninit_instance,
+	.link_status_change = hns_roce_hw_v2_link_status_change,
 	.reset_notify = hns_roce_hw_v2_reset_notify,
 };
 
-- 
2.33.0


