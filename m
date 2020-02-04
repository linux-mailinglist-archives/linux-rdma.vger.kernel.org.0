Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D201516FD
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 09:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBDIYm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 03:24:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbgBDIYm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 03:24:42 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A012D67CE558807F94B7;
        Tue,  4 Feb 2020 16:24:39 +0800 (CST)
Received: from SZA160416817.china.huawei.com (10.46.14.205) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 4 Feb 2020 16:24:31 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH RFC v2 for-next 2/7] RDMA/mlx5: remove deliver net device event
Date:   Tue, 4 Feb 2020 16:24:03 +0800
Message-ID: <20200204082408.18728-3-liweihang@huawei.com>
X-Mailer: git-send-email 2.10.0.windows.1
In-Reply-To: <20200204082408.18728-1-liweihang@huawei.com>
References: <20200204082408.18728-1-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.46.14.205]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

The code that handles the link event of the net device has been moved into
the core, and the related processing should been removed from the provider
driver.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
 drivers/infiniband/hw/mlx5/main.c | 95 ++++-----------------------------------
 1 file changed, 9 insertions(+), 86 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 997cbfe..f202cbc 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -144,48 +144,6 @@ mlx5_ib_port_link_layer(struct ib_device *device, u8 port_num)
 	return mlx5_port_type_cap_to_rdma_ll(port_type_cap);
 }
 
-static int get_port_state(struct ib_device *ibdev,
-			  u8 port_num,
-			  enum ib_port_state *state)
-{
-	struct ib_port_attr attr;
-	int ret;
-
-	memset(&attr, 0, sizeof(attr));
-	ret = ibdev->ops.query_port(ibdev, port_num, &attr);
-	if (!ret)
-		*state = attr.state;
-	return ret;
-}
-
-static struct mlx5_roce *mlx5_get_rep_roce(struct mlx5_ib_dev *dev,
-					   struct net_device *ndev,
-					   u8 *port_num)
-{
-	struct mlx5_eswitch *esw = dev->mdev->priv.eswitch;
-	struct net_device *rep_ndev;
-	struct mlx5_ib_port *port;
-	int i;
-
-	for (i = 0; i < dev->num_ports; i++) {
-		port  = &dev->port[i];
-		if (!port->rep)
-			continue;
-
-		read_lock(&port->roce.netdev_lock);
-		rep_ndev = mlx5_ib_get_rep_netdev(esw,
-						  port->rep->vport);
-		if (rep_ndev == ndev) {
-			read_unlock(&port->roce.netdev_lock);
-			*port_num = i + 1;
-			return &port->roce;
-		}
-		read_unlock(&port->roce.netdev_lock);
-	}
-
-	return NULL;
-}
-
 static int mlx5_netdev_event(struct notifier_block *this,
 			     unsigned long event, void *ptr)
 {
@@ -219,52 +177,10 @@ static int mlx5_netdev_event(struct notifier_block *this,
 		write_unlock(&roce->netdev_lock);
 		break;
 
-	case NETDEV_CHANGE:
-	case NETDEV_UP:
-	case NETDEV_DOWN: {
-		struct net_device *lag_ndev = mlx5_lag_get_roce_netdev(mdev);
-		struct net_device *upper = NULL;
-
-		if (lag_ndev) {
-			upper = netdev_master_upper_dev_get(lag_ndev);
-			dev_put(lag_ndev);
-		}
-
-		if (ibdev->is_rep)
-			roce = mlx5_get_rep_roce(ibdev, ndev, &port_num);
-		if (!roce)
-			return NOTIFY_DONE;
-		if ((upper == ndev || (!upper && ndev == roce->netdev))
-		    && ibdev->ib_active) {
-			struct ib_event ibev = { };
-			enum ib_port_state port_state;
-
-			if (get_port_state(&ibdev->ib_dev, port_num,
-					   &port_state))
-				goto done;
-
-			if (roce->last_port_state == port_state)
-				goto done;
-
-			roce->last_port_state = port_state;
-			ibev.device = &ibdev->ib_dev;
-			if (port_state == IB_PORT_DOWN)
-				ibev.event = IB_EVENT_PORT_ERR;
-			else if (port_state == IB_PORT_ACTIVE)
-				ibev.event = IB_EVENT_PORT_ACTIVE;
-			else
-				goto done;
-
-			ibev.element.port_num = port_num;
-			ib_dispatch_event(&ibev);
-		}
-		break;
-	}
-
 	default:
 		break;
 	}
-done:
+
 	mlx5_ib_put_native_port_mdev(ibdev, port_num);
 	return NOTIFY_DONE;
 }
@@ -569,7 +485,14 @@ static int mlx5_query_port_roce(struct ib_device *device, u8 port_num,
 
 	dev_put(ndev);
 
-	props->active_mtu	= min(props->max_mtu, ndev_ib_mtu);
+	props->active_mtu = min(props->max_mtu, ndev_ib_mtu);
+
+	if ((dev->lag_active && ndev != mlx5_lag_get_roce_netdev(mdev)) ||
+	    (!dev->lag_active && port_num != mdev_port_num))
+		props->inactive = 1;
+	else
+		props->inactive = 0;
+
 out:
 	if (put_mdev)
 		mlx5_ib_put_native_port_mdev(dev, port_num);
-- 
2.8.1


