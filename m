Return-Path: <linux-rdma+bounces-19975-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOdmALY6+Wkn7AIAu9opvQ
	(envelope-from <linux-rdma+bounces-19975-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 02:32:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C9C4C5743
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 02:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8E7030A872D
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 00:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426542E06E4;
	Tue,  5 May 2026 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSEHvFsH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DAC285060
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940884; cv=none; b=I4vTXbqbiLE+d/anyff29gEoeGZJr3CYKStFqSpEw8Y3t219BXM29rFhhCXybR9kt4did8hajvAB3M1Myn5Qi7lsuYCG2BO+TNrPKq/JAH0Sd3nLaEvYsa82YDMEar1rAl3K6+V0JUrVN1RJDjcsehzdtfCxZF5iLU98qk7zEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940884; c=relaxed/simple;
	bh=wYDT0PJRMb31ZP24JWbTT5WalVrfTU+LMPYR3Vi4pjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PgwLQPF+a604XgDj7/NEeOop8buKhmVMcHrSTT+dO0UFgxv9jVNgunNiR6qgrEcwKHS7dHp6r5O5mKDzA81dOa3A2y18gUuWlz6Lf6pjToJJIbzvrO7aJO7vIVvsVhuMOcJEnDmrkR/+aV74dL2xa6Ed+XL1G/a+NrkEJ0vhK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSEHvFsH; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb40149037so462980885a.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 17:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777940881; x=1778545681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9ipZOgYycgUpmB4or1YqF/hBfNlU6IbZyyWfKcKJlQ=;
        b=QSEHvFsH4fGK4QO2chcgiHWNVyXkDjnoVbH0rZBsHm4qbkUODXDIlL5ZupAhl0dfPt
         VVNwNHSTsej/UokzDsJKI668k0eJ3YsxpeI70FWDWCWp/K6ZBD5TP+shEKGgmYHDUQNi
         wAi+qaMPf7IvEBk5yXzvPaxNj0+IZes0q9XG7upcYaJkkTqVaTZM0kXUlRqh41Etx03k
         qW84+QqI6psspkL7YKhKQ7QFVcWHvZozYsFujO7Fx0aiEzuK7HVQZ4NuSIAa9ImW/wo4
         411AxWVt5sPmm+aNab0qQRUldEzLBJrEPSkcoyt1xZ3rCjd2/5TZzaUqGdrOixLVOQbi
         qArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940881; x=1778545681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m9ipZOgYycgUpmB4or1YqF/hBfNlU6IbZyyWfKcKJlQ=;
        b=Dg0JwUQu5MqoFqbt8LW+D1QcZ18sIE1DBB+XVZxM9Sn9XxCbSnMuxKNIEoigk2r+Es
         gBg5t6qYn3lnEQDh36QAM2biX2C+zUFWYR9sg/M68iqbDnxTZ868AFLRj7gp4wKxIR4B
         RXExfkwKBEP4aUhmFoChksC/7mNJ4HpFnal1V6ut/sGSJwvLUT6FT9oL0/uTOZjoJCd2
         lcMlu4sJhjMxkjRR0tyL2vd/cSkXf/qJdgY17F6P0D0JNE5N4RC0pcoNWlbyaO1OS78R
         lHtHsJEidl0BCro+Nh5slNo9PeUnp8Y6CcB1miJ3TBvZuZld/rUTHUCemcEJ9Eyekp+r
         62jg==
X-Forwarded-Encrypted: i=1; AFNElJ8NADvlqQsnuvNE+hSNic4tGxYZn4x32DHV3fYx9vNjsjRsVAyLJbV9VUuh6bk1WXnNIIJZS9GvDDCk@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjwy4X7WR6uHXAEkxUDTBfXCFS7e4fcMhA1d/Ol8Z9kqNztqT
	FMBLkyoRitq4/KXO6j/qoUGANgny22oZKRDkaL2CdUXBIUUxKDvXlLuM
X-Gm-Gg: AeBDievsc0UWEwoT4dfojQy2T3PlMYLHfSE0ONEHJwcwCuXtL/FwEcbfGSBxxeeOk0r
	pgX2Y6kvmLASc0z0ZR97nsoqxRuOPzdfUehRttgoX3+RSGZR1WYBgu0tfM5lXADCLwpdpTlobVa
	0d16XKKreuOs9opwpdwh86zFTal+eozUMNE1yFnMS0yPEDltrzj+1bhJCnx0c1AOSreIYloGc89
	6iBADkgspGdciFdgsM8JdlBF8NhsLik4X8lY9hlYWvE7t33Wv25Jn47L8sWIHNg3Z3syBVHTL+8
	RP2oFdfcxv+POz8AcDuNk0eZ+gP1tnYPIOwC67G2uYYtYidn3B1z+NuhtAzfpbF9L8ksY9PKTEL
	hTmxRhIdlFSMwhPvXX1WmNd+ZG9Krh3fZ8CponA3YixQCdxKKq4Gj1IcbdLOneWujWhJhMDWMme
	6oIj6uP2QSbsQJL6bYTqhjV/Vs1zfCtJnZ
X-Received: by 2002:a05:620a:4694:b0:8ec:c4a7:f8e5 with SMTP id af79cd13be357-8fd17b547c6mr1945417685a.31.1777940880547;
        Mon, 04 May 2026 17:28:00 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:13::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91b976sm1219584885a.39.2026.05.04.17.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 17:28:00 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 04 May 2026 17:27:49 -0700
Subject: [PATCH net-next v2 2/6] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-tcp-dm-netkit-v2-2-56d52ac72fd4@meta.com>
References: <20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com>
In-Reply-To: <20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com>
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
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 55C9C4C5743
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19975-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
Changes in v2:
- In validate_xmit_unreadable_skb() to check netmem_tx mode before
  inspecting frags (Jakub)
- Lock bind_dev around netdev_queue_get_dma_dev() when bind_dev !=
  netdev to fix lockdep (Sashiko)
---
 net/core/dev.c         | 21 ++++++++++++-------
 net/core/devmem.c      |  6 ++++--
 net/core/devmem.h      |  9 ++++++--
 net/core/netdev-genl.c | 57 +++++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 06c195906231..74eb4eb170cd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3990,23 +3990,30 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
 static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 						    struct net_device *dev)
 {
+	struct net_devmem_dmabuf_binding *binding;
 	struct skb_shared_info *shinfo;
 	struct net_iov *niov;
 
 	if (likely(skb_frags_readable(skb)))
 		goto out;
 
-	if (!dev->netmem_tx)
+	if (dev->netmem_tx == NETMEM_TX_NONE)
 		goto out_free;
 
+	if (dev->netmem_tx == NETMEM_TX_NO_DMA)
+		goto out;
+
 	shinfo = skb_shinfo(skb);
+	if (shinfo->nr_frags == 0)
+		goto out;
 
-	if (shinfo->nr_frags > 0) {
-		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
-		if (net_is_devmem_iov(niov) &&
-		    READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev)
-			goto out_free;
-	}
+	niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
+	if (!net_is_devmem_iov(niov))
+		goto out_free;
+
+	binding = net_devmem_iov_binding(niov);
+	if (READ_ONCE(binding->dev) != dev)
+		goto out_free;
 
 out:
 	return skb;
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
index b8f6076d8007..0e296c3bb677 100644
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
@@ -1119,9 +1119,42 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/* Find the DMA-capable device for netmem TX binding.
+ * For NETMEM_TX_DMA devices, returns the device itself.
+ * For NETMEM_TX_NO_DMA devices (e.g. netkit), walks leased queues
+ * to find the underlying physical device.
+ * Returns NULL if no suitable device is found.
+ */
+static struct net_device *netdev_find_netmem_tx_dev(struct net_device *dev)
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
@@ -1164,16 +1197,30 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_netdev;
 	}
 
-	if (!netdev->netmem_tx) {
+	if (netdev->netmem_tx == NETMEM_TX_NONE) {
 		err = -EOPNOTSUPP;
 		NL_SET_ERR_MSG(info->extack,
 			       "Driver does not support netmem TX");
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
+	dma_dev = netdev_queue_get_dma_dev(bind_dev, 0, NETDEV_QUEUE_TYPE_TX);
+	if (bind_dev != netdev)
+		netdev_unlock(bind_dev);
+	binding = net_devmem_bind_dmabuf(bind_dev,
+					 bind_dev != netdev ? netdev : NULL,
+					 dma_dev, DMA_TO_DEVICE, dmabuf_fd,
+					 priv, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock_netdev;

-- 
2.52.0


