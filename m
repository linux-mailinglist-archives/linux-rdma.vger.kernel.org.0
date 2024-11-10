Return-Path: <linux-rdma+bounces-5883-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671429C31F6
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Nov 2024 13:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274F5281522
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Nov 2024 12:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92765156C52;
	Sun, 10 Nov 2024 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NXjnnAHW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300B8154C0C
	for <linux-rdma@vger.kernel.org>; Sun, 10 Nov 2024 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731242141; cv=none; b=hLmBNLDiYnL90ZTDk7ToAcG6BgN+8VxibPYqjxJ9Y8uYUNMiWlRWWB9yCwnG3r2ZvRHmoaeKvqp2cMd04XWMmrKdxMhLzn86yqFqxXVNcAGShcc41Yg3abM4pY7dr+RSD9LiZPURmvTaF09tsIqQ9JGHXXGCirQDFlPtNDMbXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731242141; c=relaxed/simple;
	bh=x0w0CUzjso+e+FMeV4nO5ZYZzE4kixiK4nsHVrqB8bc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hOhlhjglZjyqN2Ym2qF+J/MAlDLqP8Y+g9P0uxFEovLTZv53ZsrYX2r1FA+R2j2QPMJRdribuAOVG2fuTRQIcQVyPBmWgWBw1IRuX4DwWMXpXazCncc4fuqsOYPgmKa7ZC9sq/Jfp8H2BqbQr7k+87pb/nT65IoiXi4wcA1+Pv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NXjnnAHW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c8b557f91so39476715ad.2
        for <linux-rdma@vger.kernel.org>; Sun, 10 Nov 2024 04:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731242137; x=1731846937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zf1mveJKRAJEuOVsfXfMXAx6FpiGUZY8/ERXCoqyxjI=;
        b=NXjnnAHWtL785lpAIspwBxlM4vDcE/H0iqfag89Oa9bNJfy93rw7h3OQ7p7I24Y9NN
         l1JfkyWxRs2xouerUYLfx20+rJe+93uSMg6QHA60MPnP5zlk7ZWifNJ86ksu6Cfw896T
         rpxkILawIhMYJI8e6n9usJBmyLyKnwbWQvxfDsub163s5LFfgsNU9+Gz70pO77EY997+
         HmKzeKZFNQpO/eXJlvrsdkFyJWMv2OT6gexfVcBQruQYP/XNzJXFLN2cHHrEQr6Pl6EL
         0OTYZKMePDH2V9y2NS0k0KterViiwcQBndzNlxNXynVmCczIn+TdM3knUlOlH3FX98tp
         pUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731242137; x=1731846937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zf1mveJKRAJEuOVsfXfMXAx6FpiGUZY8/ERXCoqyxjI=;
        b=VDs6o8m6VpV/3Rqcz6IAaxZg35pKQaetgUyi6OfVXFBYxOvJpLD7C+3Eiee72DB2k5
         ejGY1opwP6RFfTKQPuF8yxgVu/N8edF7VfzFw1GhSKPY+ze7Cruvhzg7TdF6lsoe1n3h
         ZdoUcSt3bShatxNGsUgJAb7/LENq3mSHr4IRG/TCUgtJqQZSJP/UV2KIdnQDPWXmcxew
         T8W6+K3f1I+dvgzs8Dt9Y0d+NvzhSHmDf3yxlyQSGYuIbdDEaGeoeXsl9TdgzEa7kp5k
         qZ5JMyJjdCRonaSzS7kXzZwtEvqz6mgu5di2N8efvzdgknyD/uLJo7dXYoAlpouEkyVd
         Gwvw==
X-Gm-Message-State: AOJu0YzZnd/UTVXTajOB4BMoz0ZZyB09V3GhrabhNrLlMIaAlUKIVnaJ
	dMe7ZkjH6e4QqIwcvN/xAmvXOoU1IKaIJcczX4/SAuWi67WDBvPJertxIlYR4fo=
X-Google-Smtp-Source: AGHT+IFd7AGCmnFwTGeIG/0ReF0vb4yjUHCAuAnetctJfYH2NQ0O2YUokXMioTvO57gm40HJEQdBtg==
X-Received: by 2002:a17:902:cf0a:b0:20c:dbff:b9e5 with SMTP id d9443c01a7336-21183d16b33mr129861875ad.33.1731242137345;
        Sun, 10 Nov 2024 04:35:37 -0800 (PST)
Received: from G9KHXL406Q.localdomain ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e68cb0sm58586605ad.224.2024.11.10.04.35.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 10 Nov 2024 04:35:36 -0800 (PST)
Received: by G9KHXL406Q.localdomain (Postfix, from userid 501)
	id 038CA13CC747; Sun, 10 Nov 2024 20:35:33 +0800 (CST)
From: yuezelong <yuezelong@bytedance.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuezelong <yuezelong@bytedance.com>
Subject: [RFC] RDMA/core: Fix IPv6 loopback dst MAC address lookup logic
Date: Sun, 10 Nov 2024 20:35:32 +0800
Message-Id: <20241110123532.37831-1-yuezelong@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Imagine we have two RNICs on a single machine, named eth1 and eth2, with

- IPv4 addresses: 192.168.1.2, 192.168.1.3
- IPv6 addresses (scope global): fdbd::beef:2, fdbd::beef:3
- MAC addresses: 11:11:11:11:11:02, 11:11:11:11:11:03,

they all connnected to a gateway with MAC address 22:22:22:22:22:02.

If we want to setup connections between these two RNICs, with RC QP, we
would go through `rdma_resolve_ip` for looking up dst MAC addresses. The
procedure it's the same as using command

`ip route get dst_addr from src_addr oif src_dev`

In IPv4 scenario, you would likely get

```
$ ip route get 192.168.1.2 from 192.168.1.3 oif eth2

192.168.1.2 from 192.168.1.3 via 192.168.1.1 dev eth2 ...
```

Looks reasonable as it would go through the gateway.

But in IPv6 scenario, you would likely get

```
$ ip route get fdbd::beef:2 from fdbd::beef:3 oif eth2

local fdbd::beef:2 from fdbd::beed:3 dev lo table local proto kernel src fdbd::beef:2 metric 0 pref medium
```

This would lead to the RDMA route lookup procedure filling the dst MAC
address with src net device's MAC address (11:11:11:11:11:03),  but
filling the dst IP address with dst net device's IPv6 address
(fdbd::beef:2), src net device would drop this packet, and we would fail
to setup the connection.

To make setting up loopback connections like this possible, we need to
send packets to the gateway and let the gateway send it back (actually,
the IPv4 lookup result would lead to this, so there is no problem in IPv4
scenario), so we need to adjust current lookup procedure, if we find out
the src device and dst device is on the same machine (same namespace),
we need to send the packets to the gateway instead of the src device
itself.

Signed-off-by: yuezelong <yuezelong@bytedance.com>
---
 drivers/infiniband/core/addr.c | 95 +++++++++++++++++++++++++++++++++-
 drivers/infiniband/core/cma.c  |  7 ++-
 2 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index c4cf26f1d149..d194e6b7f2b9 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -545,6 +545,29 @@ static void rdma_addr_set_net_defaults(struct rdma_dev_addr *addr)
 	addr->bound_dev_if = 0;
 }
 
+static struct dst_entry *get_default_ipv6_route(struct in6_addr *src_addr, struct net_device *dev)
+{
+	struct flowi6 fl6;
+	struct dst_entry *dst = NULL;
+
+	memset(&fl6, 0, sizeof(fl6));
+	fl6.flowi6_iif = dev_net(dev)->loopback_dev->ifindex;
+	fl6.flowi6_oif = dev->ifindex;
+	fl6.saddr = *src_addr;
+	fl6.daddr = in6addr_any;
+
+	dst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(dev), NULL, &fl6, NULL);
+	if (IS_ERR(dst))
+		return NULL;
+
+	if (dst && dst->error) {
+		dst_release(dst);
+		return NULL;
+	}
+
+	return dst;
+}
+
 static int addr_resolve(struct sockaddr *src_in,
 			const struct sockaddr *dst_in,
 			struct rdma_dev_addr *addr,
@@ -597,9 +620,77 @@ static int addr_resolve(struct sockaddr *src_in,
 	 * Resolve neighbor destination address if requested and
 	 * only if src addr translation didn't fail.
 	 */
-	if (!ret && resolve_neigh)
-		ret = addr_resolve_neigh(dst, dst_in, addr, ndev_flags, seq);
+	if (!ret && resolve_neigh) {
+		if ((src_in->sa_family == AF_INET6) && (ndev_flags & IFF_LOOPBACK)) {
+			rcu_read_lock();
+			/*
+			 * When src net device and dst net device is different device,
+			 * traditional TCP/IP loopback won't work for RDMA. We need to find
+			 * gateway for src net device and send packets to the gateway, then
+			 * let the gateway send it back to the dst device. This is likely
+			 * be problematic in IPv6 scenario, the route logic would likely fill
+			 * the dst MAC address with src net device's MAC, but with dst IP
+			 * belongs to the dst net device, leading to packet drop.
+			 *
+			 * Thus, we need to figure out gateway's MAC address in IPv6 loopback
+			 * scenario.
+			 */
+			struct net_device *ndev = READ_ONCE(dst->dev);
+			struct net_device *src_ndev = rdma_find_ndev_for_src_ip_rcu(dev_net(ndev),
+										    src_in);
+			struct net_device *dst_ndev = rdma_find_ndev_for_src_ip_rcu(dev_net(ndev),
+										    dst_in);
+
+			if (IS_ERR(src_ndev) || IS_ERR(dst_ndev)) {
+				ret = -ENODEV;
+				rcu_read_unlock();
+				goto exit;
+			}
+
+			if (src_ndev != dst_ndev) {
+				dst_release(dst);
+				dst = get_default_ipv6_route((struct in6_addr *)src_in->sa_data,
+							     src_ndev);
+				ndev_flags = src_ndev->flags;
+			} else {
+				rcu_read_unlock();
+				/*
+				 * For real loopback (src and dst is the same device), we can
+				 * just use the original code path.
+				 */
+				ret = addr_resolve_neigh(dst, dst_in, addr, ndev_flags, seq);
+				goto exit;
+			}
+			rcu_read_unlock();
+
+			if (dst == NULL) {
+				ret = -EINVAL;
+				goto done;
+			}
+
+			/*
+			 * Though we fill `in6addr_any` as dst addr here, `xfrm_neigh_lookup`
+			 * would still find nexthop for us, which provides gateway MAC address.
+			 */
+			struct sockaddr_in6 addr_in = {
+				.sin6_family = AF_INET6,
+				.sin6_addr = in6addr_any,
+			};
+			const void *daddr = (const void *)&addr_in.sin6_addr;
+
+			might_sleep();
+
+			/*
+			 * Use `addr_resolve_neigh` here would go into `ib_nl_fetch_ha` branch,
+			 * which would fail because of `rdma_nl_chk_listeners` returns error.
+			 */
+			ret = dst_fetch_ha(dst, addr, daddr);
+		} else {
+			ret = addr_resolve_neigh(dst, dst_in, addr, ndev_flags, seq);
+		}
+	}
 
+exit:
 	if (src_in->sa_family == AF_INET)
 		ip_rt_put(rt);
 	else
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 64ace0b968f0..744f396568cd 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1612,7 +1612,12 @@ static bool validate_ipv6_net_dev(struct net_device *net_dev,
 	if (!rt)
 		return false;
 
-	ret = rt->rt6i_idev->dev == net_dev;
+	if (rt->rt6i_flags & (RTF_LOCAL | RTF_NONEXTHOP)) {
+		// TODO: how to validate netdev when the device is loopback?
+		ret = true;
+	} else {
+		ret = rt->rt6i_idev->dev == net_dev;
+	}
 	ip6_rt_put(rt);
 
 	return ret;
-- 
2.20.1


