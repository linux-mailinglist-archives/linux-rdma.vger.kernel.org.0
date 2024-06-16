Return-Path: <linux-rdma+bounces-3176-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939A5909E63
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B67281786
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339811BDCF;
	Sun, 16 Jun 2024 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euh5/jLH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27311B806;
	Sun, 16 Jun 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554161; cv=none; b=V37HqJi3JFL7YIiQp7pfKrW36S+73cV9z01+Ux9uX08XWCIfWtj5Gn0alpvYrhwTe5NcfnUewl2bHD1HmPibfRgnrKlGoL0Qcsr1YQTtg8mYQv8Eyub/gQ7eUPny3OnJFT2mqtLT/VomuJvSBCw3X+4aOrZPzOX19gZ8aQl0frI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554161; c=relaxed/simple;
	bh=wrtT1ShcvISRqi3aDhodopWwGFJiZQdVPaXZ8YMED+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAG2DLmroqcNBcMkKeJ8HyBN7SND+xVYKDQ1J0F8VMsF52Q/+vGSgh/phMZ+hdw6FpHxo4XpZAcRhgEMgGNy0MWquP+n2zZHQW0EsMJ2iQpuUAmnB4KxjTA0IMJeaeLENGSH7+NFq6t7A23aMVXr2UNB6Ca7tpoj7qK68oIu9es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euh5/jLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6BFC2BBFC;
	Sun, 16 Jun 2024 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554160;
	bh=wrtT1ShcvISRqi3aDhodopWwGFJiZQdVPaXZ8YMED+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=euh5/jLHGHitfnwbmVIIqBzQNwRYT9+UUAn3uogXavSklG75TBMdeUZSe/MHOYgo4
	 fYg7gUqxh7xpNpaK2FD1Zx7Xe6hJIqZN9kU2jW32v46l0s6iSLMQ0f8uQr6cRrAw4w
	 0bDUx6bfiHWkInTgHy1bWMC8S7pxJf+QDwcnuhbCkqDGIR9zf1AQw2pGlc8+tugztz
	 lOm8nkrbmjmgi4THhPDH/xDfhAMEH6B7/ffCCR/KZmPGyUyecauaiJVnV5BoedDGGh
	 TQoPjEyLY/s27BiGjEgfSMulI2WvA2vfaqYI0UlGmS46zIanZxOJzNnyqnVJrJHPIJ
	 pC9uCj7K3NRHA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next 08/12] RDMA/nldev: Add support to add/delete a sub IB device through netlink
Date: Sun, 16 Jun 2024 19:08:40 +0300
Message-ID: <77cbf1b36359642be8a8d8c5c2f4e585b544282f.1718553901.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718553901.git.leon@kernel.org>
References: <cover.1718553901.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

Add new netlink commands and attributes to support adding and deleting
a sub IB device with admin privilege.

Examples:
$ rdma dev add smi1 type SMI parent ibp8s0f1
$ rdma dev del smi1

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 59 ++++++++++++++++++++++++++++++++
 include/uapi/rdma/rdma_netlink.h |  6 ++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index bc79ee630d8d..b5f87e7a1cfd 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -167,6 +167,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_DYNAMIC] = { .type = NLA_U8 },
 	[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE] = { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_DRIVER_DETAILS]	= { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_DEV_TYPE]		= { .type = NLA_U8 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2548,6 +2549,56 @@ static int nldev_stat_get_counter_status_doit(struct sk_buff *skb,
 	return ret;
 }
 
+static int nldev_newdev(struct sk_buff *skb, struct nlmsghdr *nlh,
+			struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
+	enum rdma_nl_dev_type type;
+	struct ib_device *parent;
+	char name[IFNAMSIZ] = {};
+	u32 parentid;
+	int ret;
+
+	ret = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			  nldev_policy, extack);
+	if (ret || !tb[RDMA_NLDEV_ATTR_DEV_INDEX] ||
+		!tb[RDMA_NLDEV_ATTR_DEV_NAME] || !tb[RDMA_NLDEV_ATTR_DEV_TYPE])
+		return -EINVAL;
+
+	nla_strscpy(name, tb[RDMA_NLDEV_ATTR_DEV_NAME], sizeof(name));
+	type = nla_get_u8(tb[RDMA_NLDEV_ATTR_DEV_TYPE]);
+	parentid = nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
+	parent = ib_device_get_by_index(sock_net(skb->sk), parentid);
+	if (!parent)
+		return -EINVAL;
+
+	ret = ib_add_sub_device(parent, type, name);
+	ib_device_put(parent);
+
+	return ret;
+}
+
+static int nldev_deldev(struct sk_buff *skb, struct nlmsghdr *nlh,
+			struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
+	struct ib_device *device;
+	u32 devid;
+	int ret;
+
+	ret = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			  nldev_policy, extack);
+	if (ret || !tb[RDMA_NLDEV_ATTR_DEV_INDEX])
+		return -EINVAL;
+
+	devid = nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
+	device = ib_device_get_by_index(sock_net(skb->sk), devid);
+	if (!device)
+		return -EINVAL;
+
+	return ib_del_sub_device_and_put(device);
+}
+
 static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	[RDMA_NLDEV_CMD_GET] = {
 		.doit = nldev_get_doit,
@@ -2646,6 +2697,14 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	[RDMA_NLDEV_CMD_STAT_GET_STATUS] = {
 		.doit = nldev_stat_get_counter_status_doit,
 	},
+	[RDMA_NLDEV_CMD_NEWDEV] = {
+		.doit = nldev_newdev,
+		.flags = RDMA_NL_ADMIN_PERM,
+	},
+	[RDMA_NLDEV_CMD_DELDEV] = {
+		.doit = nldev_deldev,
+		.flags = RDMA_NL_ADMIN_PERM,
+	},
 };
 
 void __init nldev_init(void)
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index d15ee16be722..bd52fb325e22 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -301,6 +301,10 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_RES_SRQ_GET_RAW,
 
+	RDMA_NLDEV_CMD_NEWDEV,
+
+	RDMA_NLDEV_CMD_DELDEV,
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -564,6 +568,8 @@ enum rdma_nldev_attr {
 	 */
 	RDMA_NLDEV_ATTR_RES_SUBTYPE,		/* string */
 
+	RDMA_NLDEV_ATTR_DEV_TYPE,		/* u8 */
+
 	/*
 	 * Always the end
 	 */
-- 
2.45.2


