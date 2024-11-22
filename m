Return-Path: <linux-rdma+bounces-6061-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330849D5D99
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 12:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CFB1F21798
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD00C1DEFDC;
	Fri, 22 Nov 2024 10:59:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A431DB54C;
	Fri, 22 Nov 2024 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273189; cv=none; b=EU9KAg+S3C0HixYI6uD5xjpnssEuSTEpg75lRLO6wtruSn+OzV4rufx31UydSUQo807jVwXizLKGEM2UJbEez/g7RRPGXBQIdOcdq2Fvl5YCNgfxmpLLCuKK4iVphhdhDwUu39l493mFqcBQQHj0exSatShrRbkzy3SyPvgmt+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273189; c=relaxed/simple;
	bh=RFZxQe0J3d8y2UkzHkH7HH8QrfLEOqQzDZQGiOaxJs4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnTwGiBvvUghbScZK9yxyuzVTrsTSHmBRknt14WIRrl60sdIBUFUynLav0yHY01e1HdC4Q5zHLx3g9DwJrp/ocrS/an6h2IBVgx5ioReSbFROqvm5PzXljB8hJbEnwf0P/LGXR8PyFtAeG2uZsF8gVuYnUXV6WXsKt+u/vCMjRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XvsVm0bbXz10SBk;
	Fri, 22 Nov 2024 18:57:04 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E260180106;
	Fri, 22 Nov 2024 18:59:45 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Nov 2024 18:59:44 +0800
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
Subject: [PATCH RFC 07/12] RDMA/siw: Remove deliver net device event
Date: Fri, 22 Nov 2024 18:53:03 +0800
Message-ID: <20241122105308.2150505-8-huangjunxian6@hisilicon.com>
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

Since the netdev events of link status is now handled in ib_core,
remove the related code in drivers.

In addition, remove sdev->state as it is only used in siw_query_port(),
and it can be replaced by ib_get_curr_port_state().

Signed-off-by: Yuyu Li <liyuyu6@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/sw/siw/siw.h       |  3 ---
 drivers/infiniband/sw/siw/siw_main.c  | 16 ----------------
 drivers/infiniband/sw/siw/siw_verbs.c |  6 +++---
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 86d4d6a2170e..f5dc4b3e0e60 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -76,9 +76,6 @@ struct siw_device {
 	int numa_node;
 	char raw_gid[ETH_ALEN];
 
-	/* physical port state (only one port per device) */
-	enum ib_port_state state;
-
 	spinlock_t lock;
 
 	struct xarray qp_xa;
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 17abef48abcd..a9dc20f241ec 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -380,16 +380,6 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
 	sdev = to_siw_dev(base_dev);
 
 	switch (event) {
-	case NETDEV_UP:
-		sdev->state = IB_PORT_ACTIVE;
-		siw_port_event(sdev, 1, IB_EVENT_PORT_ACTIVE);
-		break;
-
-	case NETDEV_DOWN:
-		sdev->state = IB_PORT_DOWN;
-		siw_port_event(sdev, 1, IB_EVENT_PORT_ERR);
-		break;
-
 	case NETDEV_REGISTER:
 		/*
 		 * Device registration now handled only by
@@ -410,7 +400,6 @@ static int siw_netdev_event(struct notifier_block *nb, unsigned long event,
 	 * Todo: Below netdev events are currently not handled.
 	 */
 	case NETDEV_CHANGEMTU:
-	case NETDEV_CHANGE:
 		break;
 
 	default:
@@ -443,11 +432,6 @@ static int siw_newlink(const char *basedev_name, struct net_device *netdev)
 	if (sdev) {
 		dev_dbg(&netdev->dev, "siw: new device\n");
 
-		if (netif_running(netdev) && netif_carrier_ok(netdev))
-			sdev->state = IB_PORT_ACTIVE;
-		else
-			sdev->state = IB_PORT_DOWN;
-
 		ib_mark_name_assigned_by_user(&sdev->base_dev);
 		rv = siw_device_register(sdev, basedev_name);
 		if (rv)
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 986666c19378..137819184b3b 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -182,10 +182,10 @@ int siw_query_port(struct ib_device *base_dev, u32 port,
 	attr->max_msg_sz = -1;
 	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
 	attr->active_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
-	attr->phys_state = sdev->state == IB_PORT_ACTIVE ?
-		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
 	attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_DEVICE_MGMT_SUP;
-	attr->state = sdev->state;
+	attr->state = ib_get_curr_port_state(sdev->ndev);
+	attr->phys_state = attr->state == IB_PORT_ACTIVE ?
+		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
 	/*
 	 * All zero
 	 *
-- 
2.33.0


