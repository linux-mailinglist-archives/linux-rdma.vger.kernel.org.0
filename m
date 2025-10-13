Return-Path: <linux-rdma+bounces-13836-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7897EBD4141
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E33401140
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1177313E0C;
	Mon, 13 Oct 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDwuT8Nz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE93126B7
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367242; cv=none; b=ngcSrXUI/WeQunj1l26RJdQqV7xKOqaeeSVqV52fP0yoHoEa1Irp59SxEyClsLz5sxWEf+kAn/Rao4JNRiJoS03/uTMDc31xCOb4Vh8f+HTb6oYCtnWfPhpSiwY9rMseOMcBCB9aoDmMgPkHgu4D+kDmpc9iOobFJXYMWfhG1iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367242; c=relaxed/simple;
	bh=kcyz3K/+ZD7+9nmDKS34MZXJ1XuGasqzh9S5BjHI38s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHBOMHyaNsokrJXrWm/5aCsTQ6F3B7m/82RcLvTHUOQwB+BDnAPMmhxW3No/i9EkKg0XoQLIr6QGPtahC8w2eAyW9MXEpdJHbyMoRaRKAUZ7ANLbf/eINxGW8lmcIIAm4doEcyGQ1o+pFHIJlOHIa5N6gEzGj0LDuH3BaAv73Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDwuT8Nz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so3810382f8f.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367238; x=1760972038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPtcW7QNRWzI4bwcgscdOvSibo3vgz0EjZuRg0ANq3Q=;
        b=QDwuT8NzZJdunMg3YXYd3RsLI9NvKi1uLf9Uryt7APKHpk6oJ6ByomF39v2EvrWzeM
         DV264vAssgiVS3K63j3MO+vUGDm3X6o4o/9pBhLXCyxX8FwCQyC/Q+SDXu+xp21fyvs3
         xByhwEDqo75Iv31lVd5bTdRijU8T99xGs9WEZ8L4hxRidP1uhaMkztyfdCifQdpIo8D/
         N4qvcdpedhV9plrfrPgiY1N0XFmw7k1C6tv0+ZH5rSyFAZZ6l229hbLA3RoFqehXdB+C
         YZewW+pW1QLrELF+iycsitZCSnhQqexbP/osrawMagtNb2HcaJtHs7g9WTsL9VWteJ5x
         yzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367238; x=1760972038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPtcW7QNRWzI4bwcgscdOvSibo3vgz0EjZuRg0ANq3Q=;
        b=OOwgW0YPirv7kaz3W1QEs/n9t4VCa0pkdxpduY6S1S5CYjuInDvcFFf2XCLTmCpDMO
         Mu082HEYjy3XgzUC74R1n18pZYSJUJg9xTjnj/U08nCPRVZSKX5EbDXctaPD4wEXGUX0
         JU2g5IttF5s+Y5qvtSrLCP0m7AMBDLKOPmU02XIVlmjuxnCL1uGkA1hHoEuDs8K8O8ZS
         hbTV+WmMclCGxmCVeAz9GQJoeZqnDri/KbMNEXaTLuQ1GuDLTI4M1cRlxZdQYhh1bPMl
         HI+sQP+BwYAMB8jHs0KbQColxsL5ha0ht96Oqfbbd+yGR+rL3QLN3r5/3j9ULDX1GBQR
         Gozw==
X-Forwarded-Encrypted: i=1; AJvYcCXrxpYxzRlRcmGkRS+LtH17OMGYB+6e6QbEkU4Rlv9iA+hQ+yqghAYLQUBXEOzARG6bGUHRx5olLOlI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0I3/CAT83nxZ8hWlRnoaCaJybriALFkliMAdny7uX3iU8bjKC
	itrCoFGXLb87c1BZIT1n92OtUuF+V9xxd6z772oC2jUSWebKRjFqFqbf
X-Gm-Gg: ASbGnctMVa48OPaPcgcxfMcWVoNytuvvaNQl1aSpdUvdeWnBxlddUVphNm6IkF3MImW
	FmZaA5xF3svN0eYchxzrSf/55MGjegYvCphyr4y7jvBb6iVMtkEwQRweMTFFOvtylj6m84Ae7ZL
	duSnG33BnvrUuG4Zet4oi+zEYUiOHyiotjzI5I1QVmouGSkiM0KwcabOMHptFmTegsxeFyDJrZm
	dwXmS8TcAmz1cfTzvmuF4JnVic5EZGd3LHyby+Vz1w1Qftq1xtj6TZIrCnx3BUEU9YrALuoM/8W
	aHI2ScDtLxcK2qXGZEN7vkpqCUQYATkMFznmL7uR9UQ0lpKZZ6lSS8lUw3SwLYFD7KDuqb8g2ZS
	U0Rx0dcVzgAuEpFbzhzSIH6DmYBjKvC4ryyo=
X-Google-Smtp-Source: AGHT+IGyTqxu1DQCG+uMhIMrq/BG38kVog29PB2V4zE54HNR0YJmUqUkMsN2dpw+NIfVGZjdAr5iZA==
X-Received: by 2002:a05:6000:310b:b0:3d3:b30:4cf2 with SMTP id ffacd0b85a97d-4266e7beaa3mr12850184f8f.19.1760367237484;
        Mon, 13 Oct 2025 07:53:57 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:56 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 19/24] netdev: add support for setting rx-buf-len per queue
Date: Mon, 13 Oct 2025 15:54:21 +0100
Message-ID: <d346957874e6a628e613957478aecdc1f4797965.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Zero-copy APIs increase the cost of buffer management. They also extend
this cost to user space applications which may be used to dealing with
much larger buffers. Allow setting rx-buf-len per queue, devices with
HW-GRO support can commonly fill buffers up to 32k (or rather 64k - 1
but that's not a power of 2..)

The implementation adds a new option to the netdev netlink, rather
than ethtool. The NIC-wide setting lives in ethtool ringparams so
one could argue that we should be extending the ethtool API.
OTOH netdev API is where we already have queue-get, and it's how
zero-copy applications bind memory providers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 Documentation/netlink/specs/netdev.yaml | 15 ++++
 include/net/netdev_queues.h             |  5 ++
 include/net/netlink.h                   | 19 +++++
 include/uapi/linux/netdev.h             |  2 +
 net/core/netdev-genl-gen.c              | 15 ++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  | 92 +++++++++++++++++++++++++
 net/core/netdev_config.c                | 16 +++++
 tools/include/uapi/linux/netdev.h       |  2 +
 9 files changed, 167 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index e00d3fa1c152..fabae13f45e8 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -338,6 +338,10 @@ attribute-sets:
         doc: XSK information for this queue, if any.
         type: nest
         nested-attributes: xsk-info
+      -
+        name: rx-buf-len
+        doc: Per-queue configuration of ETHTOOL_A_RINGS_RX_BUF_LEN.
+        type: u32
   -
     name: qstats
     doc: |
@@ -771,6 +775,17 @@ operations:
         reply:
           attributes:
             - id
+    -
+      name: queue-set
+      doc: Set per-queue configurable options.
+      attribute-set: queue
+      do:
+        request:
+          attributes:
+            - ifindex
+            - type
+            - id
+            - rx-buf-len
 
 kernel-family:
   headers: ["net/netdev_netlink.h"]
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 532f60ee1a66..4b59ca9d5a4b 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -39,6 +39,7 @@ struct netdev_config {
 
 /* Same semantics as fields in struct netdev_config */
 struct netdev_queue_config {
+	u32	rx_buf_len;
 };
 
 /* See the netdev.yaml spec for definition of each statistic */
@@ -141,6 +142,8 @@ void netdev_stat_queue_sum(struct net_device *netdev,
 /**
  * struct netdev_queue_mgmt_ops - netdev ops for queue management
  *
+ * @supported_ring_params: ring params supported per queue (ETHTOOL_RING_USE_*).
+ *
  * @ndo_queue_mem_size: Size of the struct that describes a queue's memory.
  *
  * @ndo_queue_cfg_defaults: (Optional) Populate queue config struct with
@@ -174,6 +177,8 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  * be called for an interface which is open.
  */
 struct netdev_queue_mgmt_ops {
+	u32     supported_ring_params;
+
 	size_t	ndo_queue_mem_size;
 	void	(*ndo_queue_cfg_defaults)(struct net_device *dev,
 					  int idx,
diff --git a/include/net/netlink.h b/include/net/netlink.h
index 1a8356ca4b78..29989ad81ddd 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -2200,6 +2200,25 @@ static inline struct nla_bitfield32 nla_get_bitfield32(const struct nlattr *nla)
 	return tmp;
 }
 
+/**
+ * nla_update_u32() - update u32 value from NLA_U32 attribute
+ * @dst:  value to update
+ * @attr: netlink attribute with new value or null
+ *
+ * Copy the u32 value from NLA_U32 netlink attribute @attr into variable
+ * pointed to by @dst; do nothing if @attr is null.
+ *
+ * Return: true if this function changed the value of @dst, otherwise false.
+ */
+static inline bool nla_update_u32(u32 *dst, const struct nlattr *attr)
+{
+	u32 old_val = *dst;
+
+	if (attr)
+		*dst = nla_get_u32(attr);
+	return *dst != old_val;
+}
+
 /**
  * nla_memdup - duplicate attribute memory (kmemdup)
  * @src: netlink attribute to duplicate from
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 48eb49aa03d4..820f89b67a72 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -158,6 +158,7 @@ enum {
 	NETDEV_A_QUEUE_DMABUF,
 	NETDEV_A_QUEUE_IO_URING,
 	NETDEV_A_QUEUE_XSK,
+	NETDEV_A_QUEUE_RX_BUF_LEN,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
@@ -226,6 +227,7 @@ enum {
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
 	NETDEV_CMD_BIND_TX,
+	NETDEV_CMD_QUEUE_SET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index e9a2a6f26cb7..d053306a3af8 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -106,6 +106,14 @@ static const struct nla_policy netdev_bind_tx_nl_policy[NETDEV_A_DMABUF_FD + 1]
 	[NETDEV_A_DMABUF_FD] = { .type = NLA_U32, },
 };
 
+/* NETDEV_CMD_QUEUE_SET - do */
+static const struct nla_policy netdev_queue_set_nl_policy[NETDEV_A_QUEUE_RX_BUF_LEN + 1] = {
+	[NETDEV_A_QUEUE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_QUEUE_TYPE] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NETDEV_A_QUEUE_ID] = { .type = NLA_U32, },
+	[NETDEV_A_QUEUE_RX_BUF_LEN] = { .type = NLA_U32, },
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -204,6 +212,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_DMABUF_FD,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= NETDEV_CMD_QUEUE_SET,
+		.doit		= netdev_nl_queue_set_doit,
+		.policy		= netdev_queue_set_nl_policy,
+		.maxattr	= NETDEV_A_QUEUE_RX_BUF_LEN,
+		.flags		= GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index cf3fad74511f..b7f5e5d9fca9 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -35,6 +35,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info);
+int netdev_nl_queue_set_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 470fabbeacd9..61529b600c87 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -386,6 +386,30 @@ static int nla_put_napi_id(struct sk_buff *skb, const struct napi_struct *napi)
 	return 0;
 }
 
+static int
+netdev_nl_queue_fill_cfg(struct sk_buff *rsp, struct net_device *netdev,
+			 u32 q_idx, u32 q_type)
+{
+	struct netdev_queue_config *qcfg;
+
+	if (!netdev_need_ops_lock(netdev))
+		return 0;
+
+	qcfg = &netdev->cfg->qcfg[q_idx];
+	switch (q_type) {
+	case NETDEV_QUEUE_TYPE_RX:
+		if (qcfg->rx_buf_len &&
+		    nla_put_u32(rsp, NETDEV_A_QUEUE_RX_BUF_LEN,
+				qcfg->rx_buf_len))
+			return -EMSGSIZE;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int
 netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			 u32 q_idx, u32 q_type, const struct genl_info *info)
@@ -433,6 +457,9 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		break;
 	}
 
+	if (netdev_nl_queue_fill_cfg(rsp, netdev, q_idx, q_type))
+		goto nla_put_failure;
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
@@ -572,6 +599,71 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
+int netdev_nl_queue_set_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr * const *tb = info->attrs;
+	struct netdev_queue_config *qcfg;
+	u32 q_id, q_type, ifindex;
+	struct net_device *netdev;
+	bool mod;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
+		return -EINVAL;
+
+	q_id = nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
+	q_type = nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]);
+	ifindex = nla_get_u32(tb[NETDEV_A_QUEUE_IFINDEX]);
+
+	if (q_type != NETDEV_QUEUE_TYPE_RX) {
+		/* Only Rx params exist right now */
+		NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_TYPE]);
+		return -EINVAL;
+	}
+
+	ret = 0;
+	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
+	if (!netdev || !netif_device_present(netdev))
+		ret = -ENODEV;
+	else if (!netdev->queue_mgmt_ops)
+		ret = -EOPNOTSUPP;
+	if (ret) {
+		NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_IFINDEX]);
+		goto exit_unlock;
+	}
+
+	ret = netdev_nl_queue_validate(netdev, q_id, q_type);
+	if (ret) {
+		NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_ID]);
+		goto exit_unlock;
+	}
+
+	ret = netdev_reconfig_start(netdev);
+	if (ret)
+		goto exit_unlock;
+
+	qcfg = &netdev->cfg_pending->qcfg[q_id];
+	mod = nla_update_u32(&qcfg->rx_buf_len, tb[NETDEV_A_QUEUE_RX_BUF_LEN]);
+	if (!mod)
+		goto exit_free_cfg;
+
+	ret = netdev_rx_queue_restart(netdev, q_id, info->extack);
+	if (ret)
+		goto exit_free_cfg;
+
+	swap(netdev->cfg, netdev->cfg_pending);
+
+exit_free_cfg:
+	__netdev_free_config(netdev->cfg_pending);
+	netdev->cfg_pending = netdev->cfg;
+exit_unlock:
+	if (netdev)
+		netdev_unlock(netdev);
+	return ret;
+}
+
 #define NETDEV_STAT_NOT_SET		(~0ULL)
 
 static void netdev_nl_stats_add(void *_sum, const void *_add, size_t size)
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index fc700b77e4eb..ede02b77470e 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -67,11 +67,27 @@ int netdev_reconfig_start(struct net_device *dev)
 void __netdev_queue_config(struct net_device *dev, int rxq,
 			   struct netdev_queue_config *qcfg, bool pending)
 {
+	const struct netdev_config *cfg;
+
+	cfg = pending ? dev->cfg_pending : dev->cfg;
+
 	memset(qcfg, 0, sizeof(*qcfg));
 
 	/* Get defaults from the driver, in case user config not set */
 	if (dev->queue_mgmt_ops->ndo_queue_cfg_defaults)
 		dev->queue_mgmt_ops->ndo_queue_cfg_defaults(dev, rxq, qcfg);
+
+	/* Set config based on device-level settings */
+	if (cfg->rx_buf_len)
+		qcfg->rx_buf_len = cfg->rx_buf_len;
+
+	/* Set config dedicated to this queue */
+	if (rxq >= 0) {
+		const struct netdev_queue_config *user_cfg = &cfg->qcfg[rxq];
+
+		if (user_cfg->rx_buf_len)
+			qcfg->rx_buf_len = user_cfg->rx_buf_len;
+	}
 }
 
 /**
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 48eb49aa03d4..820f89b67a72 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -158,6 +158,7 @@ enum {
 	NETDEV_A_QUEUE_DMABUF,
 	NETDEV_A_QUEUE_IO_URING,
 	NETDEV_A_QUEUE_XSK,
+	NETDEV_A_QUEUE_RX_BUF_LEN,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
@@ -226,6 +227,7 @@ enum {
 	NETDEV_CMD_BIND_RX,
 	NETDEV_CMD_NAPI_SET,
 	NETDEV_CMD_BIND_TX,
+	NETDEV_CMD_QUEUE_SET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
-- 
2.49.0


