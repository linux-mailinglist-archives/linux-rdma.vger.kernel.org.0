Return-Path: <linux-rdma+bounces-20201-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FwnFNJK/WmUaAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20201-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 04:30:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D624F0CBA
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 04:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20EE23051A90
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 02:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337AF2877F6;
	Fri,  8 May 2026 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLpKlMdD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A126F288
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 02:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207302; cv=none; b=gz5+L76UyBM9z5HgAxZraiBW6muxbQl0fpk54u0NIBXAt6EjRSSOWKkdH/XjzvlgD+JUMepIK2nr+iWHNXHWjjZ2nbeHRCq/Bm7I3bzLs3vD+BeMEeefAC+z0XlLH29DAASQhh9s10YxECVRTJu03cPC0Gu2S4N9mSfsidChQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207302; c=relaxed/simple;
	bh=+7QTIX5Jfo66d6mEZMrs1AEpc/60dOeYIBi72Pnw4Oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ob8qrsCy1S4k5Av5DOmN/Xhczhdh7GR/Bj/wh//M/6wedrrXj9UIWe60d5gbYCt6Mk0TwRT4Rcn4KZ1YSwdjbCeHYWGaVBCNv81FXNW+FpK2oAlssXhRVguAIElG6hs2mkd+jGzlpm7ELuDuUgSWh1Xu+ZFImKil8lI/jphlIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLpKlMdD; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d736211595so105827585a.0
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 19:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778207299; x=1778812099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUYPma61DuZ861cw0OU1+Spsgt2qqloLMXWRlKAMWS0=;
        b=WLpKlMdDWf8ssoDqTXeiMepCA96DEA1XW7hGQxqGsGeLdlxdDtNoLM3wpEjNWyuNe3
         cfLunuPjxcWCJ1J5eXbthIGzawsbSJRSrwXL5XCyC961BZfOA2+sX9qNTkxhicO/TsC8
         77SPgredSwe/tLHa+9ZNPS8IB80caRPt67FU4LHsvRo/0BequWoPF4+mnIFsnCreqNCN
         kLEeg5pONNPf8Wxhda8EwLnHe6wCjJj4Jupm8Wab1WlMmdhDrM0kdbPv9GZMQ0b9PtOs
         kTvc8VgBSYRPw/7clbN2sKHer3AkBPIjlKMfA6jDy7I8vsENHdGBbQnPVyP3lgYrBU+9
         AU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778207299; x=1778812099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KUYPma61DuZ861cw0OU1+Spsgt2qqloLMXWRlKAMWS0=;
        b=m066sPi8mUJjVPUAMALGKRymFNwp73ifYIgg7dDcj9+3GpoE+asojtdSwlV9gxHJPP
         1pqeFIcHL3TmCQT+HRfgWD55rUYsbw85LVWFmseGnK8az6+s8fM8tBtPaXadp5fBcEMI
         X+WHBzVLhXlXU9w+jVSv45gi+euoYyy63jLAdLZX3u5bPsoCujrGcn+8dZTv/XKEPIzh
         /uAd+//bK+FPfELtkj5fomTfpW7HrRDfuDh7180uS2nh0A9Sw6Keg4o8l+jl9QhWsIQx
         DBED/RYu60FmRUMSFPLYNIeWO4BNyKMgXA/lFLY9+5eZ++Y59jyrfdLfMCtzPMUEOvhj
         6uiw==
X-Forwarded-Encrypted: i=1; AFNElJ/SIFYEzb97i4n2eA8f21rQg1Ar8TlD0q0QbkUQOargttIMCvr0sK2IAqXKlzuB5a390551NkK8D38L@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg+apMXAqDCDkmSLTfhJOL57Q1Iut99qDH7eDMCoXZmW6tLCPA
	p7+9anb37K927IsPn9BJXASLxERShrHYGIy7IWpRI5edGmj21RSo1tl4
X-Gm-Gg: AeBDies+GNSKy6D62qWEUCIXfo2omumWCwAnK96eySOWC4jELSW3nLzW0otnHnydSa3
	efweDJ5rnFvzvHY1c3VVxPWFhMKP7Sh4722gRa1D5RtwdHtoDtdGHtNajG/CHxeOc+VYlmudGYR
	ZBwNWcTu7ihSAYAy4fxrQx8RQ2pfVSO3KwFV8jVyFDL3Q0/9NdU1N+5bsjItp6Aa9WE0M5OPScu
	Q8iOR4vpu62cINcnCE51LfFVQN3CMuwIwXnYKwxttnKXLmvW7Lv7Mft+ws4Wqk0AfkPqA0qCyOv
	eYwQp7616xZTHyJar1zuJ3MTx/DtEPc0AvG50AslG+YonrsF+Z5+4Y+9m+f5zJZDYLenYwAADaY
	ueeGi4Vx//t0ydCpmBz9A92u0JgATdgxpcOaVFKRyTuY2RHb4sJtVg7lTppBH/b6tbks0IvCU2E
	BX297PYYC9sv1qA52qdi+n8MvrW2LRZflA
X-Received: by 2002:a05:620a:bd3:b0:8c6:d309:f9c0 with SMTP id af79cd13be357-904d3fa42e0mr1519549685a.8.1778207298730;
        Thu, 07 May 2026 19:28:18 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:45::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8d9eed0sm63298085a.19.2026.05.07.19.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:28:18 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 07 May 2026 19:27:48 -0700
Subject: [PATCH net-next v3 3/8] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-tcp-dm-netkit-v3-3-52821445867c@meta.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
In-Reply-To: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: dw@davidwei.uk, sdf.kernel@gmail.com, mohsin.bashr@gmail.com, 
 willemb@google.com, jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, 
 wang.yaxin@zte.com.cn, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: E3D624F0CBA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20201-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_GT_50(0.00)[70];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

When a netkit virtual device leases queues from a physical NIC, devmem
TX bindings created on the netkit device must still result in the dmabuf
being mapped for dma by the physical device. This patch accomplishes
this by teaching the bind handler to search for the underlying
DMA-capable device by looking it up via leased rx queues. The function
netdev_find_netmem_tx_dev(), used for finding the underlying DMA-capable
device, can be extended to support other non-netkit NETMEM_TX_NO_DMA
devices in the future if needed.

Additionally, this patch extends validate_xmit_unreadable_skb() to
support the netkit case, where the skb is validated twice: once on the
netkit guest device and again on the physical NIC after BPF redirect or
ip forwarding.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v3:
- Fix validate_xmit_unreadable_skb() bug for non-devmem
  unreadable niovs (should not be dropped)
- Major simplification of validate_xmit_unreadable_skb()
- Fix prematurely released lock in bind-tx handler (Jakub)

Changes in v2:
- In validate_xmit_unreadable_skb() to check netmem_tx mode before
  inspecting frags (Jakub)
- Lock bind_dev around netdev_queue_get_dma_dev() when bind_dev !=
  netdev to fix lockdep (Sashiko)
---
 net/core/dev.c         |  3 +++
 net/core/devmem.c      |  6 +++--
 net/core/devmem.h      |  9 ++++++--
 net/core/netdev-genl.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index fbe4c328a367..268417c9ef22 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3999,6 +3999,9 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 	if (dev->netmem_tx == NETMEM_TX_NONE)
 		goto out_free;
 
+	if (dev->netmem_tx == NETMEM_TX_NO_DMA)
+		goto out;
+
 	shinfo = skb_shinfo(skb);
 
 	if (shinfo->nr_frags > 0) {
diff --git a/net/core/devmem.c b/net/core/devmem.c
index cde4c89bc146..644c286b778f 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -181,7 +181,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 }
 
 struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev,
+net_devmem_bind_dmabuf(struct net_device *dev, struct net_device *vdev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
@@ -212,6 +212,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	}
 
 	binding->dev = dev;
+	binding->vdev = vdev;
 	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
 
 	err = percpu_ref_init(&binding->ref,
@@ -397,7 +398,8 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
 	 */
 	dst_dev = dst_dev_rcu(dst);
 	if (unlikely(!dst_dev) ||
-	    unlikely(dst_dev != READ_ONCE(binding->dev))) {
+	    unlikely(dst_dev != READ_ONCE(binding->dev) &&
+		     dst_dev != READ_ONCE(binding->vdev))) {
 		err = -ENODEV;
 		goto out_unlock;
 	}
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 1c5c18581fcb..f399632b3c4b 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -19,7 +19,12 @@ struct net_devmem_dmabuf_binding {
 	struct dma_buf *dmabuf;
 	struct dma_buf_attachment *attachment;
 	struct sg_table *sgt;
+	/* Physical NIC that does the actual DMA for this binding. */
 	struct net_device *dev;
+	/* Virtual device (e.g. netkit) the user called bind-tx on. Must be
+	 * NETMEM_TX_NO_DMA.
+	 */
+	struct net_device *vdev;
 	struct gen_pool *chunk_pool;
 	/* Protect dev */
 	struct mutex lock;
@@ -84,7 +89,7 @@ struct dmabuf_genpool_chunk_owner {
 
 void __net_devmem_dmabuf_binding_free(struct work_struct *wq);
 struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev,
+net_devmem_bind_dmabuf(struct net_device *dev, struct net_device *vdev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
@@ -165,7 +170,7 @@ static inline void net_devmem_put_net_iov(struct net_iov *niov)
 }
 
 static inline struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev,
+net_devmem_bind_dmabuf(struct net_device *dev, struct net_device *vdev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 4d2c49371cdb..b4d48f3672a5 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1077,7 +1077,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_rxq_bitmap;
 	}
 
-	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_DEVICE,
+	binding = net_devmem_bind_dmabuf(netdev, NULL, dma_dev, DMA_FROM_DEVICE,
 					 dmabuf_fd, priv, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
@@ -1119,9 +1119,43 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/* Find the DMA-capable device for a netmem TX binding.
+ *
+ * For NETMEM_TX_DMA devices, return the device itself.
+ * For NETMEM_TX_NO_DMA devices, walk leased RX queues to find the underlying
+ * physical device and return it.
+ */
+static struct net_device *
+netdev_find_netmem_tx_dev(struct net_device *dev)
+{
+	struct netdev_rx_queue *lease_rxq;
+	struct net_device *phys_dev;
+	int i;
+
+	if (dev->netmem_tx == NETMEM_TX_DMA)
+		return dev;
+
+	if (dev->netmem_tx != NETMEM_TX_NO_DMA)
+		return NULL;
+
+	for (i = 0; i < dev->real_num_rx_queues; i++) {
+		lease_rxq = READ_ONCE(__netif_get_rx_queue(dev, i)->lease);
+		if (!lease_rxq)
+			continue;
+
+		phys_dev = lease_rxq->dev;
+		if (netif_device_present(phys_dev) &&
+		    phys_dev->netmem_tx == NETMEM_TX_DMA)
+			return phys_dev;
+	}
+
+	return NULL;
+}
+
 int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net_devmem_dmabuf_binding *binding;
+	struct net_device *bind_dev;
 	struct netdev_nl_sock *priv;
 	struct net_device *netdev;
 	struct device *dma_dev;
@@ -1171,22 +1205,41 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_netdev;
 	}
 
-	dma_dev = netdev_queue_get_dma_dev(netdev, 0, NETDEV_QUEUE_TYPE_TX);
-	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_TO_DEVICE,
-					 dmabuf_fd, priv, info->extack);
+	bind_dev = netdev_find_netmem_tx_dev(netdev);
+	if (!bind_dev) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "No DMA-capable device found for netmem TX");
+		goto err_unlock_netdev;
+	}
+
+	if (bind_dev != netdev)
+		netdev_lock(bind_dev);
+
+	dma_dev = netdev_queue_get_dma_dev(bind_dev, 0, NETDEV_QUEUE_TYPE_TX);
+
+	binding = net_devmem_bind_dmabuf(bind_dev,
+					 bind_dev != netdev ? netdev : NULL,
+					 dma_dev, DMA_TO_DEVICE, dmabuf_fd,
+					 priv, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
-		goto err_unlock_netdev;
+		goto err_unlock_bind_dev;
 	}
 
 	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
 	genlmsg_end(rsp, hdr);
 
+	if (bind_dev != netdev)
+		netdev_unlock(bind_dev);
 	netdev_unlock(netdev);
 	mutex_unlock(&priv->lock);
 
 	return genlmsg_reply(rsp, info);
 
+err_unlock_bind_dev:
+	if (bind_dev != netdev)
+		netdev_unlock(bind_dev);
 err_unlock_netdev:
 	netdev_unlock(netdev);
 err_unlock_sock:

-- 
2.53.0-Meta


