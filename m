Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB09E39D708
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 10:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFGIUF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 04:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230203AbhFGIUE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 04:20:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B18CE61029;
        Mon,  7 Jun 2021 08:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623053893;
        bh=MQNmsMRLh50u5YgoPb0WTwWwP+h/W0qOGpxA6Rzdt/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ckvA+xDLma9x6c3nHTl3HfV2BTv/WG6l+sMMvcWDryf21JJyAwNjEzSVvAkymDmxh
         IJLBCw+oDzzmLDATSFQVKl9/aWHN/uufpKr+OvzF1te+5VxdeJCB7gm097mIQ+T05n
         /bSZm59nxzhIcdDDTEwDDrpoHXsJR6+OooS0IiyaReMD9Tigdqe98y0e4B2FhLrX/5
         UcsLyQg22ufOWtGuVyfHT7ukBaz/vtBA7GociuLSdhZsMmDhMINpOllmlG2o/nD/rd
         JJBu3Cp/LZhNS1Bi0DpnmF+t4JWFMX9W8gWbJtLssqfyTV5kTv4WM6siKjjrUMJNPp
         yd7wi2Znmrsog==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next v1 02/15] RDMA/core: Replace the ib_port_data hw_stats pointers with a ib_port pointer
Date:   Mon,  7 Jun 2021 11:17:27 +0300
Message-Id: <6477a29059b1b4d92ea003e3b801a8d1df6d516d.1623053078.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623053078.git.leonro@nvidia.com>
References: <cover.1623053078.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

It is much saner to store a pointer to the kobject structure that contains
the cannonical stats pointer than to copy the stats pointers into a public
structure.

Future patches will require the sysfs pointer for other purposes.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/core_priv.h |  1 +
 drivers/infiniband/core/nldev.c     |  8 ++------
 drivers/infiniband/core/sysfs.c     | 14 +++++++++++---
 include/rdma/ib_verbs.h             |  3 ++-
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 29809dd30041..ec5c2c3db423 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -378,6 +378,7 @@ struct net_device *rdma_read_gid_attr_ndev_rcu(const struct ib_gid_attr *attr);
 
 void ib_free_port_attrs(struct ib_core_device *coredev);
 int ib_setup_port_attrs(struct ib_core_device *coredev);
+struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev, u32 port_num);
 
 int rdma_compatdev_set(u8 enable);
 
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 01316926cef6..e9b4b2cccaa0 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -2066,7 +2066,8 @@ static int stat_get_doit_default_counter(struct sk_buff *skb,
 	}
 
 	port = nla_get_u32(tb[RDMA_NLDEV_ATTR_PORT_INDEX]);
-	if (!rdma_is_port_valid(device, port)) {
+	stats = ib_get_hw_stats_port(device, port);
+	if (!stats) {
 		ret = -EINVAL;
 		goto err;
 	}
@@ -2088,11 +2089,6 @@ static int stat_get_doit_default_counter(struct sk_buff *skb,
 		goto err_msg;
 	}
 
-	stats = device->port_data ? device->port_data[port].hw_stats : NULL;
-	if (stats == NULL) {
-		ret = -EINVAL;
-		goto err_msg;
-	}
 	mutex_lock(&stats->lock);
 
 	num_cnts = device->ops.get_hw_stats(device, stats, port, 0);
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index d11ceff2b4e4..b153dee1e0fa 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1031,8 +1031,6 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
 			goto err;
 		port->hw_stats_ag = hsag;
 		port->hw_stats = stats;
-		if (device->port_data)
-			device->port_data[port_num].hw_stats = stats;
 	} else {
 		struct kobject *kobj = &device->dev.kobj;
 		ret = sysfs_create_group(kobj, hsag);
@@ -1053,6 +1051,14 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
 	kfree(stats);
 }
 
+struct rdma_hw_stats *ib_get_hw_stats_port(struct ib_device *ibdev,
+					   u32 port_num)
+{
+	if (!ibdev->port_data || !rdma_is_port_valid(ibdev, port_num))
+		return NULL;
+	return ibdev->port_data[port_num].sysfs->hw_stats;
+}
+
 static int add_port(struct ib_core_device *coredev, int port_num)
 {
 	struct ib_device *device = rdma_device_to_ibdev(&coredev->dev);
@@ -1171,6 +1177,8 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 		setup_hw_stats(device, p, port_num);
 
 	list_add_tail(&p->kobj.entry, &coredev->port_list);
+	if (device->port_data && is_full_dev)
+		device->port_data[port_num].sysfs = p;
 
 	kobject_uevent(&p->kobj, KOBJ_ADD);
 	return 0;
@@ -1361,7 +1369,7 @@ void ib_free_port_attrs(struct ib_core_device *coredev)
 			free_hsag(&port->kobj, port->hw_stats_ag);
 		kfree(port->hw_stats);
 		if (device->port_data && is_full_dev)
-			device->port_data[port->port_num].hw_stats = NULL;
+			device->port_data[port->port_num].sysfs = NULL;
 
 		if (port->pma_table)
 			sysfs_remove_group(p, port->pma_table);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 849a06441e29..7a4cb7022f91 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -50,6 +50,7 @@ struct ib_uqp_object;
 struct ib_usrq_object;
 struct ib_uwq_object;
 struct rdma_cm_id;
+struct ib_port;
 
 extern struct workqueue_struct *ib_wq;
 extern struct workqueue_struct *ib_comp_wq;
@@ -2182,7 +2183,7 @@ struct ib_port_data {
 	struct net_device __rcu *netdev;
 	struct hlist_node ndev_hash_link;
 	struct rdma_port_counter port_counter;
-	struct rdma_hw_stats *hw_stats;
+	struct ib_port *sysfs;
 };
 
 /* rdma netdev type - specifies protocol type */
-- 
2.31.1

