Return-Path: <linux-rdma+bounces-20724-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JYCOTUFBmrFdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20724-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 19:24:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E9154535D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 19:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF9EC3070216
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 17:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A3A393DDC;
	Thu, 14 May 2026 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kld/8bot"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C5391835
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779372; cv=none; b=FcivJwbD4PzOJ//n0ke+ksSzeZyW1CTOpEhSgIUriWA8kMniv3kXau+Fua2ILKbR3Cnq93POIKtJLPyepWrxS2y7XPkUC+BXRywx32XNjvsStbVxvgyDgkOvhz8Kd+51uBqgpo+hSS5Tk/CgpYgEE8rctLd4UxCP5ayk2GU9lZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779372; c=relaxed/simple;
	bh=8LTP/NFszKg1m9DiKbOV+XH39o0HnFYg4YrJ0MdNLT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JdAjqrHFmd4VrTosOXVtbwH6+GsbD93djzVv6VbrK0rlZEV0ErB3HDNJkiLQMZNM87/H770dicx0OfFPPzbQgzLZF9cHpe1tzGGEg7oYErwgTrXVgF/6Y9Vv4KLhn6O6HDxUnX1FQ8RcyNmb4MxoSHoW1ARq4QInVDIhAfe8cZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kld/8bot; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-439c3768d56so1452458fac.3
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778779368; x=1779384168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0KuaJtzt3M5KTpkegLP3WJoGkmy0+cTdZFwIB1803c=;
        b=Kld/8botLzMtziur/NgC9ORB7H7UHJ4Kvz/87/bZ33M/gzjsUl9f34RDD1dC9amY8V
         TbCfDNwkAPKiDD/vx5Q/Mzr+OcrP15X/EUlVaDlmQXQmpDLD/diisXq4wtmLHdg2RIvO
         UGJl9pss/unFf0spD5qJlfrRVJVahXteT2mbviGCPvDR1IjcKL/GQHP6+4c/PKV9GW7A
         n7358s3rNUVo/Re3EaHMfBsg6g9g7w7pGulL7oOv6Up6TfmSczAMRDb+vmTUf4S8C5Kc
         DcZ9xMJ4F81XlVxzvQGJXmR/7NxVd50HhnEYzeDTLdracpikl3Xtm0VEs/dHF8V8xDZB
         X5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778779368; x=1779384168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J0KuaJtzt3M5KTpkegLP3WJoGkmy0+cTdZFwIB1803c=;
        b=RRmQJst7+uU/iiGykAjPUj1ZHSLkaXEnBJgxQaeKwKw/S9qdvaRNTtLg/wGxGewISh
         7v8w62PfQxQF1qm2oT73ETmIPPrqDlVnPz/bYBpxcbJbbnwnQXxySciQ6L58l7Twu69h
         4iqF6D9KSB72G1wT9KZ2p1RS9v1E+I8wmid7mrCKESJGJKpgs7el+9hbtML3bp8RgcKl
         z5ifWofESLv+biNGrYY6AyFoG7gqVUc3ERiZKQYLxj8xiTuXDBa+1rSwZgwVAZQT/zVa
         qewT7DJ2MgV997z5eC5DgII6U8DZ/2m17kerVMgo9Hp4gDvbv2nPN4T2iYQX2XJSolun
         Ykng==
X-Forwarded-Encrypted: i=1; AFNElJ9wag8qfiDSfN6+l2eb7VRBk7Qgmayqa4Ki8OjqlEzqBvYIukOB4IBczSo7L1sIQMMGke8y8QZHaaWK@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzg7ei8MVO+MPbecxC20AhZl1urXgu1sYhbo+6yZ7zzX71P37
	LIkQAYF5Kg8q2KbAnLbizCrCZ/iVid3TX3Dty69vqyJpXMbRIf+0vIX0
X-Gm-Gg: Acq92OEcLOx5ofQA3o8ay+RExnAPbiJvdPfwVnJwX2TVBrhJAI4ddqxGf2sJAoYFFQW
	H0pLAYajZEPSafgUbpGx582zLDRpdXhk7/RExKybq0BGR64yOI01gD+xPuPe3YnMxT8ntSKfg5C
	CvJ4w5EKSfFFA8dMOP6ErvMH868PVXBJwBW9km9ijY/cRHSCjAX2WHnEiElBaWYj2ED8g0S5SM5
	vZQXioPapYSl/Q1z0XQp5snlhqM2ZAl5jeKPZIlT/BKgDnuSN2C8AeNBv1T2tdECs0/Tj5oCXtH
	7Av54HT7Q5159Rwj1Y0v0Qe0KX7PY0LcqV3ZvZb6YpjTed4rgTiTLWHin07DnYK2FJMkLCtHtAU
	kK5ArCQyKysNs82kIqcpsy5hR42PJ52xEzNO/GSPbkfcZ42XoM12lF+p/ov8SBmlRTm9zyVE0ra
	Jtl86z88ZqXG98lloXI9Fhlg==
X-Received: by 2002:a05:6870:90ca:b0:417:3be0:4e4e with SMTP id 586e51a60fabf-43a2da2c6acmr366882fac.16.1778779368215;
        Thu, 14 May 2026 10:22:48 -0700 (PDT)
Received: from localhost ([2a03:2880:f812:51::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc542218sm2206434fac.16.2026.05.14.10.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:22:47 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 14 May 2026 10:22:30 -0700
Subject: [PATCH net-next v5 3/8] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-tcp-dm-netkit-v5-3-408c59b91e66@meta.com>
References: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
In-Reply-To: <20260514-tcp-dm-netkit-v5-0-408c59b91e66@meta.com>
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
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 97E9154535D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20724-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email,meta.com:mid]
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- Fold the `NETMEM_TX_NO_DMA` check in `validate_xmit_unreadable_skb()`
  (Stan, Jakub)
- Convert `binding->vdev` to void* opaque cookie with comment (Jakub)

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
 net/core/dev.c         |  3 ++-
 net/core/devmem.c      |  6 +++--
 net/core/devmem.h      | 10 ++++++--
 net/core/netdev-genl.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 2da2688fe490..bbc93b181ef9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3993,7 +3993,8 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 	struct skb_shared_info *shinfo;
 	struct net_iov *niov;
 
-	if (likely(skb_frags_readable(skb)))
+	if (likely(skb_frags_readable(skb) ||
+		   dev->netmem_tx == NETMEM_TX_NO_DMA))
 		goto out;
 
 	if (dev->netmem_tx == NETMEM_TX_NONE)
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 468344739db2..893643909f6a 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -181,7 +181,7 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 }
 
 struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev,
+net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
@@ -212,6 +212,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	}
 
 	binding->dev = dev;
+	binding->vdev = vdev;
 	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
 
 	err = percpu_ref_init(&binding->ref,
@@ -396,7 +397,8 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
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
index 1c5c18581fcb..3852a56036cb 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -19,7 +19,13 @@ struct net_devmem_dmabuf_binding {
 	struct dma_buf *dmabuf;
 	struct dma_buf_attachment *attachment;
 	struct sg_table *sgt;
+	/* Physical NIC that does the actual DMA for this binding. */
 	struct net_device *dev;
+	/* Opaque cookie identifying the virtual device (e.g. netkit) the user
+	 * called bind-tx on. Used only for pointer comparison. Never
+	 * dereferenced.
+	 */
+	void *vdev;
 	struct gen_pool *chunk_pool;
 	/* Protect dev */
 	struct mutex lock;
@@ -84,7 +90,7 @@ struct dmabuf_genpool_chunk_owner {
 
 void __net_devmem_dmabuf_binding_free(struct work_struct *wq);
 struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev,
+net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
@@ -165,7 +171,7 @@ static inline void net_devmem_put_net_iov(struct net_iov *niov)
 }
 
 static inline struct net_devmem_dmabuf_binding *
-net_devmem_bind_dmabuf(struct net_device *dev,
+net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
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


