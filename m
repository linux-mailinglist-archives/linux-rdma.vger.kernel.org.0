Return-Path: <linux-rdma+bounces-6059-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593449D5D94
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 12:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483C0283337
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 11:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF7D1DE8AD;
	Fri, 22 Nov 2024 10:59:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB5175D32;
	Fri, 22 Nov 2024 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273188; cv=none; b=HeGKCiUb8SlKhcRF0Vgi2ZSsBAvXvNkHvvkrwojWX+c+L/U4NLoB62HNbdrD1szTpImR2ryN03VUF/nfJBMwEn06+I1Emtgvt9wjbWKV4ZDMN/UZSBd59jYqQJnRordwvT7tlbezFFrOT23M2Ige0gP+ZUIvPyZfGXdyA9f/dEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273188; c=relaxed/simple;
	bh=UsxYxClk1FxUqkSF6XXWA9EKxDKAO/zX29C/GNFZEUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NICMTawSBQemhN6jy3j4NYNHcYQ2LH3ZYTBkucqKAbgPTGfox6MW4LK3JdaCz5HAFjqEum0USa8sr1CusWFYzdopelV19ghMggecFj6YZ0TIwRG1ZtOsSXsXIR30n1fQV02BuqhhlVqo8k1OqSgouQrSlcUuG1rSRCdmxqfuUUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XvsWS2VHRz2DhCd;
	Fri, 22 Nov 2024 18:57:40 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id DF3141A0188;
	Fri, 22 Nov 2024 18:59:41 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Nov 2024 18:59:41 +0800
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
Subject: [PATCH RFC 02/12] RDMA/core: Support link status events dispatching
Date: Fri, 22 Nov 2024 18:52:58 +0800
Message-ID: <20241122105308.2150505-3-huangjunxian6@hisilicon.com>
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

Currently the dispatching of link status events is implemented by
each RDMA driver independently, and most of them have very similar
patterns. Add support for this in ib_core so that we can get rid
of duplicate codes in each driver.

A new last_port_state is added in ib_port_cache to cache the port
state of the last link status events dispatching. The original
port_state in ib_port_cache is not used here because it will be
updated when ib_dispatch_event() is called, which means it may
be changed between two link status events, and may lead to a loss
of event dispatching.

Some drivers currently have some private stuff in their link status
events handler in addition to event dispatching, and cannot be
perfectly integrated into the ib_core handling process. For these
drivers, add a new ops report_port_event() so that they can keep
their current processing.

Finally, events of LAG devices are not supported yet in this patch
as currently there is no way to obtain ibdev from upper netdev in
ib_core. This can be a TODO work after the core have more support
for LAG.

Signed-off-by: Yuyu Li <liyuyu6@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/core/device.c | 60 ++++++++++++++++++++++++++++++++
 include/rdma/ib_verbs.h          | 17 +++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c60dd50d434f..0838a423ac82 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2788,6 +2788,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, set_vf_guid);
 	SET_DEVICE_OP(dev_ops, set_vf_link_state);
 	SET_DEVICE_OP(dev_ops, ufile_hw_cleanup);
+	SET_DEVICE_OP(dev_ops, report_port_event);
 
 	SET_OBJ_SIZE(dev_ops, ib_ah);
 	SET_OBJ_SIZE(dev_ops, ib_counters);
@@ -2881,6 +2882,58 @@ static const struct rdma_nl_cbs ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] = {
 	},
 };
 
+void ib_dispatch_port_state_event(struct ib_device *ibdev, struct net_device *ndev)
+{
+	enum ib_port_state curr_state;
+	struct ib_event ibevent = {};
+	u32 port;
+
+	if (ib_query_netdev_port(ibdev, ndev, &port))
+		return;
+
+	curr_state = ib_get_curr_port_state(ndev);
+
+	write_lock_irq(&ibdev->cache_lock);
+	if (ibdev->port_data[port].cache.last_port_state == curr_state) {
+		write_unlock_irq(&ibdev->cache_lock);
+		return;
+	}
+	ibdev->port_data[port].cache.last_port_state = curr_state;
+	write_unlock_irq(&ibdev->cache_lock);
+
+	ibevent.event = (curr_state == IB_PORT_DOWN) ?
+					IB_EVENT_PORT_ERR : IB_EVENT_PORT_ACTIVE;
+	ibevent.device = ibdev;
+	ibevent.element.port_num = port;
+	ib_dispatch_event(&ibevent);
+}
+EXPORT_SYMBOL(ib_dispatch_port_state_event);
+
+static void handle_port_event(struct net_device *ndev, unsigned long event)
+{
+	struct ib_device *ibdev;
+
+	/* Currently, link events in bonding scenarios are still
+	 * reported by drivers that support bonding.
+	 */
+	if (netif_is_lag_master(ndev) || netif_is_lag_port(ndev))
+		return;
+
+	ibdev = ib_device_get_by_netdev(ndev, RDMA_DRIVER_UNKNOWN);
+	if (!ibdev)
+		return;
+
+	if (ibdev->ops.report_port_event) {
+		ibdev->ops.report_port_event(ibdev, ndev, event);
+		goto put_ibdev;
+	}
+
+	ib_dispatch_port_state_event(ibdev, ndev);
+
+put_ibdev:
+	ib_device_put(ibdev);
+};
+
 static int ib_netdevice_event(struct notifier_block *this,
 			      unsigned long event, void *ptr)
 {
@@ -2902,6 +2955,13 @@ static int ib_netdevice_event(struct notifier_block *this,
 		rdma_nl_notify_event(ibdev, port, RDMA_NETDEV_RENAME_EVENT);
 		ib_device_put(ibdev);
 		break;
+
+	case NETDEV_UP:
+	case NETDEV_CHANGE:
+	case NETDEV_DOWN:
+		handle_port_event(ndev, event);
+		break;
+
 	default:
 		break;
 	}
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b5ee5e748a47..bc70299c42e9 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2177,6 +2177,7 @@ struct ib_port_cache {
 	struct ib_gid_table   *gid;
 	u8                     lmc;
 	enum ib_port_state     port_state;
+	enum ib_port_state     last_port_state;
 };
 
 struct ib_port_immutable {
@@ -2681,6 +2682,13 @@ struct ib_device_ops {
 	 */
 	void (*ufile_hw_cleanup)(struct ib_uverbs_file *ufile);
 
+	/**
+	 * report_port_event - Drivers need to implement this if they have
+	 * some private stuff to handle when link status changes.
+	 */
+	void (*report_port_event)(struct ib_device *ibdev,
+				  struct net_device *ndev, unsigned long event);
+
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_counters);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
@@ -4471,6 +4479,15 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 					u32 port);
 int ib_query_netdev_port(struct ib_device *ibdev, struct net_device *ndev,
 			 u32 *port);
+
+static inline enum ib_port_state ib_get_curr_port_state(struct net_device *net_dev)
+{
+	return (netif_running(net_dev) && netif_carrier_ok(net_dev)) ?
+		IB_PORT_ACTIVE : IB_PORT_DOWN;
+}
+
+void ib_dispatch_port_state_event(struct ib_device *ibdev,
+				  struct net_device *ndev);
 struct ib_wq *ib_create_wq(struct ib_pd *pd,
 			   struct ib_wq_init_attr *init_attr);
 int ib_destroy_wq_user(struct ib_wq *wq, struct ib_udata *udata);
-- 
2.33.0


