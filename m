Return-Path: <linux-rdma+bounces-8446-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB143A55A8B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 00:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA0AF7A8A56
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 23:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF8427EC71;
	Thu,  6 Mar 2025 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="iHOUfJy/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E3F27E1CF
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302250; cv=none; b=H+5aNHvp5zwP6+isoIV08qvu1M5D1CTWP6mjlwPWMIpcj7IrAO9yXlhqKmN2ttfKw3/OIjsVI1ELaIMnFicH4FdZOfyYvax+eIsaokqzD9/AuhMkNANkxV9KdHCMMQGmhdwOih/NM9PcV6hwQAg7B5DxXRdGQRXH0yVJ7tv/fvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302250; c=relaxed/simple;
	bh=R/kZ61XsnXa7JkZ9eNlhtUWSSS5M9Pt+qwZTdVsBeSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwWBCjMZ2M4OuXLrbRZ8GaBlyPHIqBxagYoD2xOnsYxWNbr0yIyrJvOBpK7DyHY3X7n+CY0NtVCxiwhviTjlznDT+oCrba0yPhwbCK+54Uec7GFNOY9MyeQizjahaVC4HMwdnQvWpMKj8T03wf6k01cyJC58lcd9Zx4lEobLllw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=iHOUfJy/; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8fce04655so6484146d6.3
        for <linux-rdma@vger.kernel.org>; Thu, 06 Mar 2025 15:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741302247; x=1741907047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYVU6L/OlKky7XJzEMEAkcQ6curT0ppBzRueik5Aobo=;
        b=iHOUfJy/w8cClRd/mG90zhN+RBiD27j8q26YQthuYv+9a4rAG/4noIwAVuHABeMALs
         E9hvNiDulnDkvltWPcurZUeFaxxJtNWG8gwcWkkHmc9k/yK2S2Qehj7f6QC1S20KQ4QZ
         0YNTIh2xqXelBajYM5fZhQVmbCiHA93LBNe0vEbChqqPqmCS1CZJZBj13bUKuaShB8Q/
         /I9rwzdn+ZJ4sHJlfSULJXP/mPtMx0rCFC8Tz7SoLz36O7v750kb7UfiEeT+JEamytmr
         k3W3Gf5zz517juZlfha4XSXnI+Ubd7DBwBYa5eE8dPBO2EZyD0GZLHOoL1qgRhVC/ZTO
         qqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302247; x=1741907047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYVU6L/OlKky7XJzEMEAkcQ6curT0ppBzRueik5Aobo=;
        b=h5QD5vod+Ll/tK4Wq7+JCyfxqlmEMwOakoG3HToNt5uffMdQgov2ig1OTW72pvnQ5T
         ssydoUjzPaerVIbQW0Qwo10x2slnQWE6aIoqoqio5r/ArEHTsIkgqIHGPIOa25ETrEQF
         TmTXWbBP1vrb77Xp9ZnPOXV4nSINX6NzhNVhzGPYn6YfOpz8UgPJL5SSUwOW12bwA/MS
         XQY4Nb+KCv6wE1gXZGW8jK4YcubkCDGHvVSobB2rDPIBV7sgAKP2RimWXchVne1U9bh5
         a3oywzwiuuc7FP7ppxEKxT/oa2DKgUYOkqwsmWjkW+F/Xzz7WH0qJz0bbDfGs8icSBJ7
         7LJA==
X-Forwarded-Encrypted: i=1; AJvYcCVxI6ZL9ZtB/x2lLeDVTl/9K6yuDJBbBp4SRyBIBP5wvmKPjZnZ3zeaoc7DY/g5FSEUOo3vp6noCB+s@vger.kernel.org
X-Gm-Message-State: AOJu0YxHVQprLA1+JhClQDHfMC9jsZQSvBHNacr1k2pqSh7n3dpNGVeY
	npBY/+XHGhPJXnHbNdSTPDMYRg1yU6ZawP0Xn1DymKMc34p5kig0PT2vUBDKgk8=
X-Gm-Gg: ASbGncuSRwcg7KjPTFKUDvq/Kggekf+Byh7Yd8+ayCwzp+2D+F5uNjKswR6GNAu8TDs
	Ei2FcucRVUpURIvZ+JrOhDGhLzvvWxOB5zg6+nFlwnooFWRAHmNOGOrTvy8A2e+5FFpFpeKIS38
	TtNuG7MyqHUsIqIYCQfeCiqqyODPh3hFOfcqB7LoNAG9Nj3P7pFNdb/2AvnrqNYbWMOpEROaVlm
	Wgc1LdVB2KXAyvJu1kZraknu5Ekl5flWarLaPZTXlxoLwGkXXYHAaYU8lp0skobBo3R1fceu5nK
	uShsNFsItYBOskzPBOOFpg6Q+XME9CO+nBLghH+zelsiUAHbaHKUxWHiDSIXM7E0C2gX
X-Google-Smtp-Source: AGHT+IEtncuowmhdYM7QMeqyKKQ2lcV0+26jElV9BIp23ZCGTdI3+CIK1QRj81WnI/qAY2PW8pDtow==
X-Received: by 2002:ad4:5cca:0:b0:6e8:f4c6:681a with SMTP id 6a1803df08f44-6e9005dc3eemr9045006d6.12.1741302247411;
        Thu, 06 Mar 2025 15:04:07 -0800 (PST)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac256654fa6sm14971966b.93.2025.03.06.15.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:04:06 -0800 (PST)
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
To: netdev@vger.kernel.org
Cc: shrijeet@enfabrica.net,
	alex.badea@keysight.com,
	eric.davis@broadcom.com,
	rip.sohan@amd.com,
	dsahern@kernel.org,
	bmt@zurich.ibm.com,
	roland@enfabrica.net,
	nikolay@enfabrica.net,
	winston.liu@keysight.com,
	dan.mihailescu@keysight.com,
	kheib@redhat.com,
	parth.v.parikh@keysight.com,
	davem@redhat.com,
	ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com,
	welch@hpe.com,
	rakhahari.bhunia@keysight.com,
	kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC PATCH 05/13] drivers: ultraeth: add tunnel udp device support
Date: Fri,  7 Mar 2025 01:01:55 +0200
Message-ID: <20250306230203.1550314-6-nikolay@enfabrica.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306230203.1550314-1-nikolay@enfabrica.net>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add UE UDP tunnel device (uecon) which is created for each context. It will
be used to transmit and receive UE packets. Currently all packets are
dropped. A default port of 5432 will be used at context creation. It can be
changed at runtime when the net device is down.

Signed-off-by: Nikolay Aleksandrov <nikolay@enfabrica.net>
Signed-off-by: Alex Badea <alex.badea@keysight.com>
---
 Documentation/netlink/specs/rt_link.yaml  |  14 +
 Documentation/netlink/specs/ultraeth.yaml |   6 +
 drivers/ultraeth/Makefile                 |   3 +-
 drivers/ultraeth/uecon.c                  | 311 ++++++++++++++++++++++
 drivers/ultraeth/uet_context.c            |  12 +-
 drivers/ultraeth/uet_main.c               |  19 +-
 include/net/ultraeth/uecon.h              |  28 ++
 include/net/ultraeth/uet_context.h        |   2 +-
 include/uapi/linux/if_link.h              |   8 +
 include/uapi/linux/ultraeth.h             |   1 +
 include/uapi/linux/ultraeth_nl.h          |   2 +
 11 files changed, 402 insertions(+), 4 deletions(-)
 create mode 100644 drivers/ultraeth/uecon.c
 create mode 100644 include/net/ultraeth/uecon.h

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 31238455f8e9..747231b1fd6d 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -2272,6 +2272,17 @@ attribute-sets:
       -
         name: tailroom
         type: u16
+  -
+    name: linkinfo-uecon-attrs
+    name-prefix: ifla-uecon-
+    attributes:
+      -
+        name: context-id
+        type: u32
+      -
+        name: port
+        type: u16
+        byte-order: big-endian
 
 sub-messages:
   -
@@ -2322,6 +2333,9 @@ sub-messages:
       -
         value: netkit
         attribute-set: linkinfo-netkit-attrs
+      -
+        value: uecon
+        attribute-set: linkinfo-uecon-attrs
   -
     name: linkinfo-member-data-msg
     formats:
diff --git a/Documentation/netlink/specs/ultraeth.yaml b/Documentation/netlink/specs/ultraeth.yaml
index e95c73a36892..847f748efa52 100644
--- a/Documentation/netlink/specs/ultraeth.yaml
+++ b/Documentation/netlink/specs/ultraeth.yaml
@@ -16,6 +16,12 @@ attribute-sets:
         checks:
           min: 0
           max: 255
+      -
+        name: netdev-ifindex
+        type: s32
+      -
+        name: netdev-name
+        type: string
   -
     name: contexts
     attributes:
diff --git a/drivers/ultraeth/Makefile b/drivers/ultraeth/Makefile
index bf41a62273f9..0035023876ab 100644
--- a/drivers/ultraeth/Makefile
+++ b/drivers/ultraeth/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_ULTRAETH) += ultraeth.o
 
-ultraeth-objs := uet_main.o uet_context.o uet_netlink.o uet_job.o
+ultraeth-objs := uet_main.o uet_context.o uet_netlink.o uet_job.o \
+			uecon.o
diff --git a/drivers/ultraeth/uecon.c b/drivers/ultraeth/uecon.c
new file mode 100644
index 000000000000..4b74680700af
--- /dev/null
+++ b/drivers/ultraeth/uecon.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+#include <linux/etherdevice.h>
+#include <linux/if_link.h>
+#include <net/ipv6_stubs.h>
+#include <net/dst_metadata.h>
+#include <net/rtnetlink.h>
+#include <net/gro.h>
+#include <net/udp_tunnel.h>
+#include <net/ultraeth/uecon.h>
+#include <net/ultraeth/uet_context.h>
+
+static const struct nla_policy uecon_ndev_policy[IFLA_UECON_MAX + 1] = {
+	[IFLA_UECON_CONTEXT_ID]	= { .type = NLA_REJECT,
+				    .reject_message = "Domain id attribute is read-only" },
+	[IFLA_UECON_PORT]	= { .type = NLA_BE16 },
+};
+
+static netdev_tx_t uecon_ndev_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct uecon_ndev_priv *uecpriv = netdev_priv(dev);
+	struct ip_tunnel_info *info;
+	int err, min_headroom;
+	struct socket *sock;
+	struct rtable *rt;
+	bool use_cache;
+	__be32 saddr;
+	__be16 sport;
+
+	rcu_read_lock();
+	sock = rcu_dereference(uecpriv->sock);
+	if (!sock)
+		goto out_err;
+	info = skb_tunnel_info(skb);
+	if (!info)
+		goto out_err;
+	use_cache = ip_tunnel_dst_cache_usable(skb, info);
+	sport = uecpriv->udp_port;
+	rt = udp_tunnel_dst_lookup(skb, dev, dev_net(dev), 0, &saddr,
+				   &info->key, sport,
+				   info->key.tp_dst, info->key.tos,
+				   use_cache ? &info->dst_cache : NULL);
+	if (IS_ERR(rt)) {
+		if (PTR_ERR(rt) == -ELOOP)
+			dev->stats.collisions++;
+		else if (PTR_ERR(rt) == -ENETUNREACH)
+			dev->stats.tx_carrier_errors++;
+
+		goto out_err;
+	}
+
+	skb_tunnel_check_pmtu(skb, &rt->dst,
+			      sizeof(struct iphdr) + sizeof(struct udphdr),
+			      false);
+	skb_scrub_packet(skb, false);
+
+	min_headroom = LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len +
+		       sizeof(struct iphdr) + sizeof(struct udphdr);
+	err = skb_cow_head(skb, min_headroom);
+	if (unlikely(err)) {
+		dst_release(&rt->dst);
+		goto out_err;
+	}
+
+	err = udp_tunnel_handle_offloads(skb, false);
+	if (err) {
+		dst_release(&rt->dst);
+		goto out_err;
+	}
+
+	skb_reset_mac_header(skb);
+	skb_set_inner_protocol(skb, skb->protocol);
+
+	udp_tunnel_xmit_skb(rt, sock->sk, skb, saddr,
+			    info->key.u.ipv4.dst, info->key.tos,
+			    ip4_dst_hoplimit(&rt->dst), 0,
+			    sport, info->key.tp_dst,
+			    false, false);
+	rcu_read_unlock();
+
+	return NETDEV_TX_OK;
+
+out_err:
+	rcu_read_unlock();
+	dev_kfree_skb(skb);
+	dev->stats.tx_errors++;
+
+	return NETDEV_TX_OK;
+}
+
+static int uecon_ndev_encap_recv(struct sock *sk, struct sk_buff *skb)
+{
+	struct uecon_ndev_priv *uecpriv;
+	int len;
+
+	uecpriv = rcu_dereference_sk_user_data(sk);
+	if (!uecpriv)
+		goto drop;
+
+	if (skb->protocol != htons(ETH_P_IP))
+		goto drop;
+
+	/* we assume [ tnl ip hdr ] [ tnl udp hdr ] [ pdc hdr ] [ ses hdr ] */
+	if (iptunnel_pull_header(skb, sizeof(struct udphdr), htons(ETH_P_802_3), false))
+		goto drop_count;
+
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb->pkt_type = PACKET_HOST;
+	skb->dev = uecpriv->dev;
+	len = skb->len;
+	consume_skb(skb);
+	dev_sw_netstats_rx_add(uecpriv->dev, len);
+
+	return 0;
+
+drop_count:
+	dev_core_stats_rx_dropped_inc(uecpriv->dev);
+drop:
+	kfree_skb(skb);
+	return 0;
+}
+
+static int uecon_ndev_err_lookup(struct sock *sk, struct sk_buff *skb)
+{
+	return 0;
+}
+
+static struct socket *uecon_ndev_create_sock(struct net_device *dev)
+{
+	struct uecon_ndev_priv *uecpriv = netdev_priv(dev);
+	struct udp_port_cfg udp_conf;
+	struct socket *sock;
+	int err;
+
+	memset(&udp_conf, 0, sizeof(udp_conf));
+	udp_conf.family = AF_INET;
+	udp_conf.local_udp_port = uecpriv->udp_port;
+	err = udp_sock_create(dev_net(dev), &udp_conf, &sock);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	udp_allow_gso(sock->sk);
+
+	return sock;
+}
+
+static int uecon_ndev_open(struct net_device *dev)
+{
+	struct uecon_ndev_priv *uecpriv = netdev_priv(dev);
+	struct udp_tunnel_sock_cfg tunnel_cfg;
+	struct socket *sock;
+
+	sock = uecon_ndev_create_sock(dev);
+	if (IS_ERR(sock))
+		return PTR_ERR(sock);
+	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
+	tunnel_cfg.sk_user_data = uecpriv;
+	tunnel_cfg.encap_type = 1;
+	tunnel_cfg.encap_rcv = uecon_ndev_encap_recv;
+	tunnel_cfg.encap_err_lookup = uecon_ndev_err_lookup;
+	setup_udp_tunnel_sock(dev_net(dev), sock, &tunnel_cfg);
+
+	rcu_assign_pointer(uecpriv->sock, sock);
+
+	return 0;
+}
+
+static int uecon_ndev_stop(struct net_device *dev)
+{
+	struct uecon_ndev_priv *uecpriv = netdev_priv(dev);
+	struct socket *sock = rtnl_dereference(uecpriv->sock);
+
+	rcu_assign_pointer(uecpriv->sock, NULL);
+	synchronize_rcu();
+	udp_tunnel_sock_release(sock);
+
+	return 0;
+}
+
+const struct net_device_ops uecon_netdev_ops = {
+	.ndo_open		= uecon_ndev_open,
+	.ndo_stop		= uecon_ndev_stop,
+	.ndo_start_xmit		= uecon_ndev_xmit,
+	.ndo_get_stats64	= dev_get_tstats64,
+};
+
+static const struct device_type uecon_ndev_type = {
+	.name = "uecon",
+};
+
+static void uecon_ndev_setup(struct net_device *dev)
+{
+	struct uecon_ndev_priv *uecpriv = netdev_priv(dev);
+
+	dev->netdev_ops = &uecon_netdev_ops;
+	SET_NETDEV_DEVTYPE(dev, &uecon_ndev_type);
+
+	dev->features |= NETIF_F_VLAN_CHALLENGED | NETIF_F_SG | NETIF_F_HW_CSUM;
+	dev->features |= NETIF_F_FRAGLIST | NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE;
+
+	dev->hw_features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
+	dev->hw_features |= NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE;
+
+	dev->priv_flags |= IFF_NO_QUEUE;
+
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
+	dev->type = ARPHRD_NONE;
+
+	dev->min_mtu = IPV4_MIN_MTU;
+	/* No header for the time being, account for it later */
+	dev->max_mtu = IP_MAX_MTU;
+	dev->mtu = ETH_DATA_LEN;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+
+	netif_keep_dst(dev);
+	uecpriv->dev = dev;
+}
+
+static int uecon_ndev_changelink(struct net_device *dev, struct nlattr *tb[],
+				 struct nlattr *data[],
+				 struct netlink_ext_ack *extack)
+{
+	if (dev->flags & IFF_UP) {
+		NL_SET_ERR_MSG_MOD(extack, "Cannot change uecon settings while the device is up");
+		return -EBUSY;
+	}
+
+	if (tb[IFLA_UECON_PORT]) {
+		struct uecon_ndev_priv *uecpriv = netdev_priv(dev);
+
+		uecpriv->udp_port = nla_get_be16(tb[IFLA_UECON_PORT]);
+	}
+
+	return 0;
+}
+
+static size_t uecon_ndev_get_size(const struct net_device *dev)
+{
+	return nla_total_size(sizeof(__u32))  + /* IFLA_UECON_CONTEXT_ID */
+	       nla_total_size(sizeof(__be16)) + /* IFLA_UECON_PORT */
+	       0;
+}
+
+static int uecon_ndev_fill_info(struct sk_buff *skb, const struct net_device *dev)
+{
+	struct uecon_ndev_priv *uecpriv = netdev_priv(dev);
+
+	if (nla_put_u32(skb, IFLA_UECON_CONTEXT_ID, uecpriv->context->id) ||
+	    nla_put_be16(skb, IFLA_UECON_PORT, uecpriv->udp_port))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static struct rtnl_link_ops uecon_netdev_link_ops __read_mostly = {
+	.kind		= "uecon",
+	.priv_size	= sizeof(struct uecon_ndev_priv),
+	.setup		= uecon_ndev_setup,
+	.get_size	= uecon_ndev_get_size,
+	.fill_info	= uecon_ndev_fill_info,
+	.changelink	= uecon_ndev_changelink,
+	.policy		= uecon_ndev_policy,
+	.maxtype	= IFLA_UECON_MAX
+};
+
+int uecon_netdev_init(struct uet_context *ctx)
+{
+	struct net *net = current->nsproxy->net_ns;
+	struct uecon_ndev_priv *priv;
+	char ifname[IFNAMSIZ];
+	int ret;
+
+	snprintf(ifname, IFNAMSIZ, "uecon%d", ctx->id);
+	ctx->netdev = alloc_netdev(sizeof(struct uecon_ndev_priv), ifname,
+				   NET_NAME_PREDICTABLE, uecon_ndev_setup);
+	if (!ctx->netdev)
+		return -ENOMEM;
+	priv = netdev_priv(ctx->netdev);
+
+	priv->context = ctx;
+	priv->dev = ctx->netdev;
+	priv->udp_port = htons(UECON_DEFAULT_PORT);
+	ctx->netdev->rtnl_link_ops = &uecon_netdev_link_ops;
+	dev_net_set(ctx->netdev, net);
+
+	ret = register_netdev(ctx->netdev);
+	if (ret) {
+		free_netdev(ctx->netdev);
+		ctx->netdev = NULL;
+	}
+
+	return ret;
+}
+
+void uecon_netdev_uninit(struct uet_context *ctx)
+{
+	unregister_netdev(ctx->netdev);
+	free_netdev(ctx->netdev);
+	ctx->netdev = NULL;
+}
+
+int uecon_rtnl_link_register(void)
+{
+	return rtnl_link_register(&uecon_netdev_link_ops);
+}
+
+void uecon_rtnl_link_unregister(void)
+{
+	rtnl_link_unregister(&uecon_netdev_link_ops);
+}
diff --git a/drivers/ultraeth/uet_context.c b/drivers/ultraeth/uet_context.c
index 3d738c02e992..e0d276cb1942 100644
--- a/drivers/ultraeth/uet_context.c
+++ b/drivers/ultraeth/uet_context.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
 
 #include <net/ultraeth/uet_context.h>
+#include <net/ultraeth/uecon.h>
 #include "uet_netlink.h"
 
 #define MAX_CONTEXT_ID 256
@@ -106,10 +107,16 @@ int uet_context_create(int id)
 	if (err)
 		goto ctx_jobs_err;
 
+	err = uecon_netdev_init(ctx);
+	if (err)
+		goto ctx_netdev_err;
+
 	uet_context_link(ctx);
 
 	return 0;
 
+ctx_netdev_err:
+	uet_jobs_uninit(&ctx->job_reg);
 ctx_jobs_err:
 	uet_context_put_id(ctx);
 ctx_id_err:
@@ -121,6 +128,7 @@ int uet_context_create(int id)
 static void __uet_context_destroy(struct uet_context *ctx)
 {
 	uet_context_unlink(ctx);
+	uecon_netdev_uninit(ctx);
 	uet_jobs_uninit(&ctx->job_reg);
 	uet_context_put_id(ctx);
 	kfree(ctx);
@@ -166,7 +174,9 @@ static int __nl_ctx_fill_one(struct sk_buff *skb,
 	if (!hdr)
 		return -EMSGSIZE;
 
-	if (nla_put_s32(skb, ULTRAETH_A_CONTEXT_ID, ctx->id))
+	if (nla_put_s32(skb, ULTRAETH_A_CONTEXT_ID, ctx->id) ||
+	    nla_put_s32(skb, ULTRAETH_A_CONTEXT_NETDEV_IFINDEX, ctx->netdev->ifindex) ||
+	    nla_put_string(skb, ULTRAETH_A_CONTEXT_NETDEV_NAME, ctx->netdev->name))
 		goto out_err;
 
 	genlmsg_end(skb, hdr);
diff --git a/drivers/ultraeth/uet_main.c b/drivers/ultraeth/uet_main.c
index 0ec1dc74abbb..c37f65978ecf 100644
--- a/drivers/ultraeth/uet_main.c
+++ b/drivers/ultraeth/uet_main.c
@@ -4,18 +4,35 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <net/ultraeth/uet_context.h>
+#include <net/ultraeth/uecon.h>
 
 #include "uet_netlink.h"
 
 static int __init uet_init(void)
 {
-	return genl_register_family(&ultraeth_nl_family);
+	int err;
+
+	err = genl_register_family(&ultraeth_nl_family);
+	if (err)
+		goto out_err;
+
+	err = uecon_rtnl_link_register();
+	if (err)
+		goto rtnl_link_err;
+
+	return 0;
+
+rtnl_link_err:
+	genl_unregister_family(&ultraeth_nl_family);
+out_err:
+	return err;
 }
 
 static void __exit uet_exit(void)
 {
 	genl_unregister_family(&ultraeth_nl_family);
 	uet_context_destroy_all();
+	uecon_rtnl_link_unregister();
 }
 
 module_init(uet_init);
diff --git a/include/net/ultraeth/uecon.h b/include/net/ultraeth/uecon.h
new file mode 100644
index 000000000000..6316a0557b1f
--- /dev/null
+++ b/include/net/ultraeth/uecon.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+
+#ifndef _UECON_H
+#define _UECON_H
+#include <net/ip_tunnels.h>
+
+#define UECON_DEFAULT_PORT 5432
+
+struct socket;
+struct net_device;
+
+struct uecon_ndev_priv {
+	struct uet_context *context;
+	struct socket __rcu *sock;
+	struct net_device *dev;
+	__be16 udp_port;
+};
+
+extern const struct net_device_ops uecon_netdev_ops;
+int uecon_netdev_init(struct uet_context *ctx);
+void uecon_netdev_uninit(struct uet_context *ctx);
+
+int uecon_rtnl_link_register(void);
+void uecon_rtnl_link_unregister(void);
+
+int uecon_netdev_register(void);
+void uecon_netdev_unregister(void);
+#endif /* _UECON_H */
diff --git a/include/net/ultraeth/uet_context.h b/include/net/ultraeth/uet_context.h
index 7638c768597e..8210f69a1571 100644
--- a/include/net/ultraeth/uet_context.h
+++ b/include/net/ultraeth/uet_context.h
@@ -17,6 +17,7 @@ struct uet_context {
 	wait_queue_head_t refcnt_wait;
 	struct list_head list;
 
+	struct net_device *netdev;
 	struct uet_job_registry job_reg;
 };
 
@@ -26,5 +27,4 @@ void uet_context_put(struct uet_context *ses_pl);
 int uet_context_create(int id);
 bool uet_context_destroy(int id);
 void uet_context_destroy_all(void);
-
 #endif /* _UET_CONTEXT_H */
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 318386cc5b0d..1ba189ecf9da 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1986,4 +1986,12 @@ enum {
 
 #define IFLA_DSA_MAX	(__IFLA_DSA_MAX - 1)
 
+enum {
+	IFLA_UECON_UNSPEC,
+	IFLA_UECON_CONTEXT_ID,
+	IFLA_UECON_PORT,
+	__IFLA_UECON_MAX
+};
+
+#define IFLA_UECON_MAX (__IFLA_UECON_MAX - 1)
 #endif /* _UAPI_LINUX_IF_LINK_H */
diff --git a/include/uapi/linux/ultraeth.h b/include/uapi/linux/ultraeth.h
index a6f244de6d75..a4ac25455aa0 100644
--- a/include/uapi/linux/ultraeth.h
+++ b/include/uapi/linux/ultraeth.h
@@ -6,6 +6,7 @@
 #include <asm/byteorder.h>
 #include <linux/types.h>
 
+#define UET_DEFAULT_PORT 5432
 #define UET_SVC_MAX_LEN 64
 
 enum {
diff --git a/include/uapi/linux/ultraeth_nl.h b/include/uapi/linux/ultraeth_nl.h
index d65521de196a..515044022906 100644
--- a/include/uapi/linux/ultraeth_nl.h
+++ b/include/uapi/linux/ultraeth_nl.h
@@ -11,6 +11,8 @@
 
 enum {
 	ULTRAETH_A_CONTEXT_ID = 1,
+	ULTRAETH_A_CONTEXT_NETDEV_IFINDEX,
+	ULTRAETH_A_CONTEXT_NETDEV_NAME,
 
 	__ULTRAETH_A_CONTEXT_MAX,
 	ULTRAETH_A_CONTEXT_MAX = (__ULTRAETH_A_CONTEXT_MAX - 1)
-- 
2.48.1


