Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 013155F8A7
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 14:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfGDM54 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 08:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfGDM54 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Jul 2019 08:57:56 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B02A218A3;
        Thu,  4 Jul 2019 12:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562245075;
        bh=FTbIpsVzoltlh97L2txdOd+ZFMWjV3lJqpAPxDKAxwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Crou6deKznObAvWScXAJP3nJ89OVy5bct1jB0MRjbMvvfXdCZVxiFhczEapCgF5MK
         WnO2wVZ4nUc8ypaGFJVDdO3P2w1V8xwy6l+hm8V/EjQaWatdA50JZieBGzt+f8rrdw
         WS5WDmr1VIzGDFXfgvv+wr6UBCR77TT+IOLunTzw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>
Subject: [PATCH rdma-next v4 3/3] RDMA/nldev: Added configuration of RDMA dynamic interrupt moderation to netlink
Date:   Thu,  4 Jul 2019 15:57:43 +0300
Message-Id: <20190704125743.7814-4-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190704125743.7814-1-leon@kernel.org>
References: <20190704125743.7814-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yamin Friedman <yaminf@mellanox.com>

Added parameter in ib_device for enabling dynamic interrupt moderation so
that it can be configured in userspace using rdma tool.

In order to set adaptive-moderation for an ib device the command is:
rdma dev set [DEV] adaptive-moderation [on|off]
Please set on/off.

rdma dev show
0: mlx5_0: node_type ca fw 16.26.0055 node_guid 248a:0703:00a5:29d0
sys_image_guid 248a:0703:00a5:29d0 adaptive-moderation on

rdma resource show cq
dev mlx5_0 cqn 0 cqe 1023 users 4 poll-ctx UNBOUND_WORKQUEUE
adaptive-moderation off comm [ib_core]

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/Kconfig          |  1 +
 drivers/infiniband/core/core_priv.h |  1 +
 drivers/infiniband/core/device.c    |  9 +++++++++
 drivers/infiniband/core/nldev.c     | 14 ++++++++++++++
 include/uapi/rdma/rdma_netlink.h    |  5 +++++
 5 files changed, 30 insertions(+)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index f277cb7aea29..85e103b147cc 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -7,6 +7,7 @@ menuconfig INFINIBAND
 	depends on m || IPV6 != m
 	depends on !ALPHA
 	select IRQ_POLL
+	select DIMLIB
 	---help---
 	  Core support for InfiniBand (IB).  Make sure to also select
 	  any protocols you wish to use as well as drivers for your
diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index a953c2fa2e78..888d89ce81df 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -60,6 +60,7 @@ extern bool ib_devices_shared_netns;
 int ib_device_register_sysfs(struct ib_device *device);
 void ib_device_unregister_sysfs(struct ib_device *device);
 int ib_device_rename(struct ib_device *ibdev, const char *name);
+int ib_device_set_dim(struct ib_device *ibdev, u8 use_dim);
 
 typedef void (*roce_netdev_callback)(struct ib_device *device, u8 port,
 	      struct net_device *idev, void *cookie);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index bdf61499e6d5..7f4affe8a10d 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -448,6 +448,15 @@ int ib_device_rename(struct ib_device *ibdev, const char *name)
 	return 0;
 }
 
+int ib_device_set_dim(struct ib_device *ibdev, u8 use_dim)
+{
+	if (use_dim > 1)
+		return -EINVAL;
+	ibdev->use_cq_dim = use_dim;
+
+	return 0;
+}
+
 static int alloc_name(struct ib_device *ibdev, const char *name)
 {
 	struct ib_device *device;
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index a4431ed566b6..d9f2a30e6467 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -52,6 +52,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 					.len = RDMA_NLDEV_ATTR_EMPTY_STRING },
 	[RDMA_NLDEV_ATTR_CHARDEV_TYPE]		= { .type = NLA_NUL_STRING,
 					.len = RDMA_NLDEV_ATTR_CHARDEV_TYPE_SIZE },
+	[RDMA_NLDEV_ATTR_DEV_DIM]               = { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_DEV_INDEX]		= { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_DEV_NAME]		= { .type = NLA_NUL_STRING,
 					.len = IB_DEVICE_NAME_MAX },
@@ -252,6 +253,8 @@ static int fill_dev_info(struct sk_buff *msg, struct ib_device *device)
 		return -EMSGSIZE;
 	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_DEV_NODE_TYPE, device->node_type))
 		return -EMSGSIZE;
+	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_DEV_DIM, device->use_cq_dim))
+		return -EMSGSIZE;
 
 	/*
 	 * Link type is determined on first port and mlx4 device
@@ -552,6 +555,9 @@ static int fill_res_cq_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	    nla_put_u8(msg, RDMA_NLDEV_ATTR_RES_POLL_CTX, cq->poll_ctx))
 		goto err;
 
+	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_DEV_DIM, (cq->dim != NULL)))
+		goto err;
+
 	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CQN, res->id))
 		goto err;
 	if (!rdma_is_kernel_res(res) &&
@@ -870,6 +876,14 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto put_done;
 	}
 
+	if (tb[RDMA_NLDEV_ATTR_DEV_DIM]) {
+		u8 use_dim;
+
+		use_dim = nla_get_u8(tb[RDMA_NLDEV_ATTR_DEV_DIM]);
+		err = ib_device_set_dim(device,  use_dim);
+		goto done;
+	}
+
 done:
 	ib_device_put(device);
 put_done:
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 8c5383e28438..f6d54c0a0ae8 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -522,6 +522,11 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME,	/* string */
 	RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_VALUE,	/* u64 */
 
+	/*
+	 * CQ adaptive moderatio (DIM)
+	 */
+	RDMA_NLDEV_ATTR_DEV_DIM,                /* u8 */
+
 	/*
 	 * Always the end
 	 */
-- 
2.20.1

