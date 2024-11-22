Return-Path: <linux-rdma+bounces-6063-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5436C9D5D9E
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 12:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4426B23041
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 11:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0C01DF720;
	Fri, 22 Nov 2024 10:59:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839BA1D7E4A;
	Fri, 22 Nov 2024 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273190; cv=none; b=g1EjmY6LITuAKE12YKpMS1xd6j0QyhBwdtOgMEbJffdZAlf5s/m9KN+5kQcftr+LrGlBp9+OTHw0epfKf3lMP/sfgueBvNDVTX06H5osDThnQ8U8mMFYIpdVlPlzkJsJnF83JzrpVHr5XXyV0n02c/7oekoFMVKH9iAnvkAZiXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273190; c=relaxed/simple;
	bh=XkOCaFnxflTxzHG2twtFcHoRpCgWljRAUKLbcUbNlSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQDqPEIyQ582OABAfHMBKkLLly0jti/ct1LaPNwONadUQKwHoyJ1afgSHtVzBOtCkE15r8dMSyi3p5ZL7MVKaDigP+3PfQwQECNwU7UUT4LfIJmmg349USSa3742nM6yzOgyNiI4R6g5vVaagoG5wqLjOrIWfvJt8u1JDCMrmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XvsWS3Wqxz10WSk;
	Fri, 22 Nov 2024 18:57:40 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D08F1401F4;
	Fri, 22 Nov 2024 18:59:44 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Nov 2024 18:59:43 +0800
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
Subject: [PATCH RFC 06/12] RDMA/rxe: Remove deliver net device event
Date: Fri, 22 Nov 2024 18:53:02 +0800
Message-ID: <20241122105308.2150505-7-huangjunxian6@hisilicon.com>
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

In addition, remove the setting of port->attr.state in rxe_port_up()
and rxe_port_down(), as it is only used in rxe_query_port(), and it
can be replaced by ib_get_curr_port_state().

Signed-off-by: Yuyu Li <liyuyu6@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c   | 22 ++++------------------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  1 +
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 75d1407db52d..0fde8974d6c6 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -563,11 +563,6 @@ static void rxe_port_event(struct rxe_dev *rxe,
 /* Caller must hold net_info_lock */
 void rxe_port_up(struct rxe_dev *rxe)
 {
-	struct rxe_port *port;
-
-	port = &rxe->port;
-	port->attr.state = IB_PORT_ACTIVE;
-
 	rxe_port_event(rxe, IB_EVENT_PORT_ACTIVE);
 	dev_info(&rxe->ib_dev.dev, "set active\n");
 }
@@ -575,11 +570,6 @@ void rxe_port_up(struct rxe_dev *rxe)
 /* Caller must hold net_info_lock */
 void rxe_port_down(struct rxe_dev *rxe)
 {
-	struct rxe_port *port;
-
-	port = &rxe->port;
-	port->attr.state = IB_PORT_DOWN;
-
 	rxe_port_event(rxe, IB_EVENT_PORT_ERR);
 	rxe_counter_inc(rxe, RXE_CNT_LINK_DOWNED);
 	dev_info(&rxe->ib_dev.dev, "set down\n");
@@ -587,7 +577,7 @@ void rxe_port_down(struct rxe_dev *rxe)
 
 void rxe_set_port_state(struct rxe_dev *rxe)
 {
-	if (netif_running(rxe->ndev) && netif_carrier_ok(rxe->ndev))
+	if (ib_get_curr_port_state(rxe->ndev) == IB_PORT_ACTIVE)
 		rxe_port_up(rxe);
 	else
 		rxe_port_down(rxe);
@@ -607,18 +597,14 @@ static int rxe_notify(struct notifier_block *not_blk,
 	case NETDEV_UNREGISTER:
 		ib_unregister_device_queued(&rxe->ib_dev);
 		break;
-	case NETDEV_UP:
-		rxe_port_up(rxe);
-		break;
-	case NETDEV_DOWN:
-		rxe_port_down(rxe);
-		break;
 	case NETDEV_CHANGEMTU:
 		rxe_dbg_dev(rxe, "%s changed mtu to %d\n", ndev->name, ndev->mtu);
 		rxe_set_mtu(rxe, ndev->mtu);
 		break;
+	case NETDEV_DOWN:
 	case NETDEV_CHANGE:
-		rxe_set_port_state(rxe);
+		if (ib_get_curr_port_state(rxe->ndev) == IB_PORT_DOWN)
+			rxe_counter_inc(rxe, RXE_CNT_LINK_DOWNED);
 		break;
 	case NETDEV_REBOOT:
 	case NETDEV_GOING_DOWN:
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 5c18f7e342f2..0101e4d4d694 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -55,6 +55,7 @@ static int rxe_query_port(struct ib_device *ibdev,
 	ret = ib_get_eth_speed(ibdev, port_num, &attr->active_speed,
 			       &attr->active_width);
 
+	attr->state = ib_get_curr_port_state(rxe->ndev);
 	if (attr->state == IB_PORT_ACTIVE)
 		attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
 	else if (dev_get_flags(rxe->ndev) & IFF_UP)
-- 
2.33.0


