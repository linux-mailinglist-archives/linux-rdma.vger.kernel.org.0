Return-Path: <linux-rdma+bounces-5653-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0E49B778C
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 10:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A56C1C22335
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 09:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8FA1946A0;
	Thu, 31 Oct 2024 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/oEktC4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D6192B83
	for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367081; cv=none; b=W3ub2MPjsKD8RQUq4j8GDZ4LAvq9Q4kJpqwKL3pApKICNtVLREs4DFmenHurICJyyWN/W8fWsP06bD+aPVWi896SaBnV2z7+K+HDJvojE16ZQHAfp99MgeZ95cUEMpIyWYpqqRt903QSpiUub2oB7WcfkbW1ZXgRGlp5WuGl40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367081; c=relaxed/simple;
	bh=HEhPYWwgEEz6gzsscNS2mW0Sa6bVheQeYHiJUqWjx0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0BtjNDeQm1yiZA7tdggOLXMk6OfOsxr6sM41qbiu0fSPC+LsMt3BK0Puvn3Gaz1zrxEMnMkReu7uofTErZPp7h6fsvHlWiDhezL5s+lcckiat/+Dt1jySYh9K8peN1cL9AtowZJq/8rxXn3ctCGd9MhK4lTcWcZ9knFximyfNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/oEktC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E17C4CEC3;
	Thu, 31 Oct 2024 09:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730367079;
	bh=HEhPYWwgEEz6gzsscNS2mW0Sa6bVheQeYHiJUqWjx0I=;
	h=From:To:Cc:Subject:Date:From;
	b=s/oEktC442asMx09rLs0/0SmXM7+z6fRH2l81c5oxT/P9LP5HHzuUN/iQvzphI5QY
	 84sUZCXh2D5wf3AxE1UhkfHW8hBZAa2AAwAT4rXmUFY93iokDeMbLClBk7MToVPVUm
	 h+WgLGo4Q35oBxxbrihBKj+hfJjO1WO/OQhqRBZBRbYDOG/kqIrwUmDuDNmC7Cscrc
	 QXGq84tbdXhpiRgtSBFo52FfMf9asBLOMmXNkDB2NlkC4+puUXt47aWjb4ubYPaNZ1
	 PscR4s+WuFME4gFYfLGWQe7uj+3FJiZOoZkRmJIySbM+uczpZKVCpCU3cyffGSSeaV
	 23T30zspLtV+Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/nldev: Add IB device and net device rename events
Date: Thu, 31 Oct 2024 11:31:14 +0200
Message-ID: <093c978ef2766fd3ab4ff8798eeb68f2f11582f6.1730367038.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

Implement event sending for IB device rename and IB device
port associated netdevice rename.

In iproute2, rdma monitor displays the IB device name, port
and the netdevice name when displaying event info. Since
users can modiy these names, we track and notify on renaming
events.

Note: In order to receive netdevice rename events, drivers
must use the ib_device_set_netdev() API when attaching net
devices to IB devices.

$ rdma monitor
$ rmmod mlx5_ib
[UNREGISTER]	dev 1  rocep8s0f1
[UNREGISTER]	dev 0  rocep8s0f0

$ modprobe mlx5_ib
[REGISTER]	dev 2  mlx5_0
[NETDEV_ATTACH]	dev 2  mlx5_0 port 1 netdev 4 eth2
[REGISTER]	dev 3  mlx5_1
[NETDEV_ATTACH]	dev 3  mlx5_1 port 1 netdev 5 eth3
[RENAME]	dev 2  rocep8s0f0
[RENAME]	dev 3  rocep8s0f1

$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev
[UNREGISTER]	dev 2  rocep8s0f0
[REGISTER]	dev 4  mlx5_0
[NETDEV_ATTACH]	dev 4  mlx5_0 port 30 netdev 4 eth2
[RENAME]	dev 4  rdmap8s0f0

$ echo 4 > /sys/class/net/eth2/device/sriov_numvfs
[NETDEV_ATTACH]	dev 4  rdmap8s0f0 port 2 netdev 7 eth4
[NETDEV_ATTACH]	dev 4  rdmap8s0f0 port 3 netdev 8 eth5
[NETDEV_ATTACH]	dev 4  rdmap8s0f0 port 4 netdev 9 eth6
[NETDEV_ATTACH]	dev 4  rdmap8s0f0 port 5 netdev 10 eth7
[REGISTER]	dev 5  mlx5_0
[NETDEV_ATTACH]	dev 5  mlx5_0 port 1 netdev 11 eth8
[REGISTER]	dev 6  mlx5_1
[NETDEV_ATTACH]	dev 6  mlx5_1 port 1 netdev 12 eth9
[RENAME]	dev 5  rocep8s0f0v0
[RENAME]	dev 6  rocep8s0f0v1
[REGISTER]	dev 7  mlx5_0
[NETDEV_ATTACH]	dev 7  mlx5_0 port 1 netdev 13 eth10
[RENAME]	dev 7  rocep8s0f0v2
[REGISTER]	dev 8  mlx5_0
[NETDEV_ATTACH]	dev 8  mlx5_0 port 1 netdev 14 eth11
[RENAME]	dev 8  rocep8s0f0v3

$ ip link set eth2 name myeth2
[NETDEV_RENAME]	 netdev 4 myeth2

$ ip link set eth1 name myeth1

** no events received, because eth1 is not attached to
   an IB device **

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c | 38 ++++++++++++++++++++++++++++++
 drivers/infiniband/core/nldev.c  | 40 ++++++++++++++++++++++++++++++--
 include/uapi/rdma/rdma_netlink.h |  2 ++
 3 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index e029401b5680..93c6d27b5d8f 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -437,6 +437,7 @@ int ib_device_rename(struct ib_device *ibdev, const char *name)
 		client->rename(ibdev, client_data);
 	}
 	up_read(&ibdev->client_data_rwsem);
+	rdma_nl_notify_event(ibdev, 0, RDMA_RENAME_EVENT);
 	up_read(&devices_rwsem);
 	return 0;
 }
@@ -2852,6 +2853,40 @@ static const struct rdma_nl_cbs ibnl_ls_cb_table[RDMA_NL_LS_NUM_OPS] = {
 	},
 };
 
+static int ib_netdevice_event(struct notifier_block *this,
+			      unsigned long event, void *ptr)
+{
+	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
+	struct net_device *ib_ndev;
+	struct ib_device *ibdev;
+	u32 port;
+
+	switch (event) {
+	case NETDEV_CHANGENAME:
+		ibdev = ib_device_get_by_netdev(ndev, RDMA_DRIVER_UNKNOWN);
+		if (!ibdev)
+			return NOTIFY_DONE;
+
+		rdma_for_each_port(ibdev, port) {
+			ib_ndev = ib_device_get_netdev(ibdev, port);
+			if (ndev == ib_ndev)
+				rdma_nl_notify_event(ibdev, port,
+						     RDMA_NETDEV_RENAME_EVENT);
+			dev_put(ib_ndev);
+		}
+		ib_device_put(ibdev);
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block nb_netdevice = {
+	.notifier_call = ib_netdevice_event,
+};
+
 static int __init ib_core_init(void)
 {
 	int ret = -ENOMEM;
@@ -2923,6 +2958,8 @@ static int __init ib_core_init(void)
 		goto err_parent;
 	}
 
+	register_netdevice_notifier(&nb_netdevice);
+
 	return 0;
 
 err_parent:
@@ -2952,6 +2989,7 @@ static int __init ib_core_init(void)
 
 static void __exit ib_core_cleanup(void)
 {
+	unregister_netdevice_notifier(&nb_netdevice);
 	roce_gid_mgmt_cleanup();
 	rdma_nl_unregister(RDMA_NL_LS);
 	nldev_exit();
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 39f89a4b8649..0034c495cbbe 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -2729,6 +2729,25 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	},
 };
 
+static int fill_mon_netdev_rename(struct sk_buff *msg,
+				  struct ib_device *device, u32 port,
+				  const struct net *net)
+{
+	struct net_device *netdev = ib_device_get_netdev(device, port);
+	int ret = 0;
+
+	if (!netdev || !net_eq(dev_net(netdev), net))
+		goto out;
+
+	ret = nla_put_u32(msg, RDMA_NLDEV_ATTR_NDEV_INDEX, netdev->ifindex);
+	if (ret)
+		goto out;
+	ret = nla_put_string(msg, RDMA_NLDEV_ATTR_NDEV_NAME, netdev->name);
+out:
+	dev_put(netdev);
+	return ret;
+}
+
 static int fill_mon_netdev_association(struct sk_buff *msg,
 				       struct ib_device *device, u32 port,
 				       const struct net *net)
@@ -2793,6 +2812,18 @@ static void rdma_nl_notify_err_msg(struct ib_device *device, u32 port_num,
 				     "Failed to send RDMA monitor netdev detach event: port %d\n",
 				     port_num);
 		break;
+	case RDMA_RENAME_EVENT:
+		dev_warn_ratelimited(&device->dev,
+				     "Failed to send RDMA monitor rename device event\n");
+		break;
+
+	case RDMA_NETDEV_RENAME_EVENT:
+		netdev = ib_device_get_netdev(device, port_num);
+		dev_warn_ratelimited(&device->dev,
+				     "Failed to send RDMA monitor netdev rename event: port %d netdev %d\n",
+				     port_num, netdev->ifindex);
+		dev_put(netdev);
+		break;
 	default:
 		break;
 	}
@@ -2820,14 +2851,19 @@ int rdma_nl_notify_event(struct ib_device *device, u32 port_num,
 	switch (type) {
 	case RDMA_REGISTER_EVENT:
 	case RDMA_UNREGISTER_EVENT:
+	case RDMA_RENAME_EVENT:
 		ret = fill_nldev_handle(skb, device);
 		if (ret)
 			goto err_free;
 		break;
 	case RDMA_NETDEV_ATTACH_EVENT:
 	case RDMA_NETDEV_DETACH_EVENT:
-		ret = fill_mon_netdev_association(skb, device,
-						  port_num, net);
+		ret = fill_mon_netdev_association(skb, device, port_num, net);
+		if (ret)
+			goto err_free;
+		break;
+	case RDMA_NETDEV_RENAME_EVENT:
+		ret = fill_mon_netdev_rename(skb, device, port_num, net);
 		if (ret)
 			goto err_free;
 		break;
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 39be09c0ffbb..9f9cf20c1cd8 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -638,6 +638,8 @@ enum rdma_nl_notify_event_type {
 	RDMA_UNREGISTER_EVENT,
 	RDMA_NETDEV_ATTACH_EVENT,
 	RDMA_NETDEV_DETACH_EVENT,
+	RDMA_RENAME_EVENT,
+	RDMA_NETDEV_RENAME_EVENT,
 };
 
 #endif /* _UAPI_RDMA_NETLINK_H */
-- 
2.46.2


