Return-Path: <linux-rdma+bounces-19702-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBVRDuk38Wm/egEAu9opvQ
	(envelope-from <linux-rdma+bounces-19702-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:42:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E97C548CB25
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A84CE305AC52
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD7A389DE8;
	Tue, 28 Apr 2026 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceaYSdQo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C6381AE3
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416134; cv=none; b=fVBUaLqfv6JvEQVXcdcMpAGeRUmPXStAfIWUtRX+92b0qdCzgsVfYeCG9kxu8ZlsZB0/Pj6YHzE1o4dZvQF0+GxX3mne/Zi0sDYO4nAAs8tvND+idBQ3TSN0MyqP6NaNzJufgqeQadrvFtwm/vwErdPNNIL39omxcGYYuKjIpPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416134; c=relaxed/simple;
	bh=aKUYZj3dKoRf2r8cTorj5veYi8EvMq/P59Mop727o3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L+rHYnqZ7VssiOFg0jHXtZu5NUVJfTDxTFnXUr4I0g8veiFfb9NV5Flf9V68PE0sPXK7d9Dt3scuBm0t+4oVmQ7da48aYOEL8wXt2kixwbrnguXuWGQZsikgHXdd+htOfHAC72sG+I6mkfUwCU4cZtBeC8c6GAhQC5puyH6kr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceaYSdQo; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-793fdbb8d3aso129141247b3.3
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 15:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416132; x=1778020932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpsYT+KuyZIiwZWdP0lM/x4OtgL97fY3WCk6CAMYDUs=;
        b=ceaYSdQoRCa5WcPhevMa4RnDA4mD4/xxjtQDRSCG7GZoJyMjBs7T37+GTQoMbHx4yc
         XCmY7UmLu4i+YTw5NCnuEZsy45wD54vZoTjh/JZpcJip8SsvWSi9aN0mXAyj9Y7iCsP8
         jFSo+yLnZCsXH7a4MC1SdlBBvtR1ujhTPLawHgP0R659e8afLJxCYv9mxJeZ9L9/5Foy
         XM28JbfljSt+4JavYo15tdCMBQMgirHmoETh7nUEQC1ivLOpiouXgDZ0g+G+aEXDm3C1
         FaRX/re1OYGtbIQMyiNwyrxwQvCZzEIoNL3xGdnANJamY5kC82AFRAEBJHUXuzDk5JR7
         5GYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416132; x=1778020932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cpsYT+KuyZIiwZWdP0lM/x4OtgL97fY3WCk6CAMYDUs=;
        b=W9yA0DfdiFAnVB5F8cCvjg3iWgt0zJIBMk7IrYRQPsVaR/Xr/QAlcJpZYq11hlRWJn
         HrPU8jMlOATHVh7RYCxOJlQjO/qZUnvqBfU4uIJBBUOsVD6/QU3X9tmkVqskZtFuBrsb
         wkEV751Em9Mt51ouffVRMOZHhIPA6S4SWoylhGrJF0zWOAbveavG7LooO0sW9l58hl4b
         oy61jVPl/O3MzVKWimOo4UWgW/gpnnSZo2gL/dPJEXaHm+ztlzxi4U0IVUVix2GYb4sP
         OKwdxP+Y0RTlhakxfYN3ouTm0H1WlrQhp9Zdq7sEf8y0UwzocAo69N4qFAIbeyaUpoA+
         5grg==
X-Forwarded-Encrypted: i=1; AFNElJ/pkpQOxnkIFiaWNz3MUqbQ3tT0PwjVzmX50C9w4cHuCtoVRGEqqV8I1aOTjqZFTq0qMf3LSJrbw2W2@vger.kernel.org
X-Gm-Message-State: AOJu0YwEUEFS1Tw9IkDOF31tUd1LmW4ahvLw/cnXY+XfZvV4bI6PETIN
	/bR4xEDtMxDSw5z1yfXp9DKKoXZ2CKys8h8vnTpwHLoofddQu/9TarY9
X-Gm-Gg: AeBDieuSxKoIPk/Y5gZO1XJaV1XHTEFjufx8imEIPOLYPtLasJYOx47HEB3bNShJcP0
	Fbrz0OGYrubquh8jQkYGRNovS3d+tzey41B8eCXJZDY04CwlvnaH3eS6VNMn+hmGHsRZThrAHnF
	2JDOKQeiX58HC7itHwxFi1fdsx6p7FhccAvPCnjVQUB3e4AicOTqVBYNHKmTzhETOr+agjYFnIZ
	z4P2RBByeMsjkndj6B4w+1JKzZq3pJaSPa/Y7KIR/2pliY5/qUmRq2qetVOWyKVBDhua6vZ3F0M
	MtFyNrW2Zt4ZQCmt7IBs2lubfgADCPvRz2oQvUtCWEm/hK9c2s1eMb2BuN3qfFku2AB6y3GMw+a
	O9mp2/tQ3gL2p4yX1IczYP8s0eZ83vmS0W1ZQ2fRBdLh3riyEFmQ1gVMbgqIk1sSSIMdl6Q9gRD
	Ts1ZqOW5Ahds911+4mdwuvQ8CMgKm2vmi+
X-Received: by 2002:a05:690c:b17:b0:7b9:d6b8:b9ac with SMTP id 00721157ae682-7bcf558efe6mr52968327b3.26.1777416131438;
        Tue, 28 Apr 2026 15:42:11 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd258a2eafsm4650877b3.29.2026.04.28.15.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:11 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:41:58 -0700
Subject: [PATCH net-next 01/11] net: add netmem_tx modes that indicate dma
 capability
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260428-tcp-dm-netkit-v1-1-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
In-Reply-To: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
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
X-Rspamd-Queue-Id: E97C548CB25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19702-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Bobby Eshleman <bobbyeshleman@meta.com>

Devices that support netmem TX previously set dev->netmem_tx = true.
This was checked in validate_xmit_unreadable_skb() to drop unreadable
skbs (skbs with dmabuf-backed frags) before they reach drivers that
would mishandle them or devices that would not have the iommu mappings
for them.

Some virtual devices like netkit (or ifb) never DMA and never touch frag
contents, as they essentially just forward the skb to another device.
They are unable to forward unreadable skbs, however, because they fail
to pass TX validation checks on dev->netmem_tx. This single bit flag
doesn't give the TX validator enough information to differentiate
devices that will attempt DMA on the unreadable skb and those that will
simply route it untouched.

This patch fixes this issue by adding an additional bit to netmem_tx, so
that drivers can indicate 1) if they have netmem support, and 2) if they
do, are they DMA-capable or not?

Replace the boolean with a 2-bit enum:

NETMEM_TX_NONE   - no netmem TX support (drop unreadable skbs)
NETMEM_TX_DMA    - full support, device does DMA
NETMEM_TX_NO_DMA - pass-through, device never DMAs

Subsequent patches update netmem drivers to the new flags.

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 Documentation/networking/net_cachelines/net_device.rst |  2 +-
 Documentation/networking/netmem.rst                    |  8 +++++++-
 Documentation/translations/zh_CN/networking/netmem.rst |  7 ++++++-
 include/linux/netdevice.h                              | 11 +++++++++--
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 1c19bb7705df..c85784259544 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -10,7 +10,7 @@ Type                                Name                        fastpath_tx_acce
 =================================== =========================== =================== =================== ===================================================================================
 unsigned_long:32                    priv_flags                  read_mostly                             __dev_queue_xmit(tx)
 unsigned_long:1                     lltx                        read_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
-unsigned long:1                     netmem_tx:1;                read_mostly
+unsigned long:2                     netmem_tx:2;                read_mostly
 char                                name[16]
 struct netdev_name_node*            name_node
 struct dev_ifalias*                 ifalias
diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
index b63aded46337..217869d1108d 100644
--- a/Documentation/networking/netmem.rst
+++ b/Documentation/networking/netmem.rst
@@ -95,4 +95,10 @@ Driver TX Requirements
    netdev@, or reach out to the maintainers and/or almasrymina@google.com for
    help adding the netmem API.
 
-2. Driver should declare support by setting `netdev->netmem_tx = true`
+2. Driver should declare support by setting `netdev->netmem_tx` to the
+   appropriate mode:
+
+   - `NETMEM_TX_DMA`: for physical devices that perform DMA.
+
+   - `NETMEM_TX_NO_DMA`: for virtual or passthrough devices that do
+     not DMA, but still support handling of netmem-backed skbs.
diff --git a/Documentation/translations/zh_CN/networking/netmem.rst b/Documentation/translations/zh_CN/networking/netmem.rst
index fe351a240f02..320f3eacf51b 100644
--- a/Documentation/translations/zh_CN/networking/netmem.rst
+++ b/Documentation/translations/zh_CN/networking/netmem.rst
@@ -89,4 +89,9 @@ dma-mapping API 去处理。
 使用某个还不存在的 netmem API，你可以自行添加并提交到 netdev@，也可以联系维护
 人员或者发送邮件至 almasrymina@google.com 寻求帮助。
 
-2. 驱动程序应通过设置 netdev->netmem_tx = true 来表明自身支持 netmem 功能。
+2. 驱动程序应将 `netdev->netmem_tx` 设置为适当的模式：
+
+   - `NETMEM_TX_DMA`：适用于执行 DMA 的物理设备。
+
+   - `NETMEM_TX_NO_DMA`：适用于不执行 DMA 的虚拟或透传设备，但仍支持
+     处理 netmem 支持的 skb。
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0e1e581efc5a..11d68e75eb4f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1788,6 +1788,12 @@ enum netdev_stat_type {
 	NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
 };
 
+enum netmem_tx_mode {
+	NETMEM_TX_NONE,		/* no netmem TX support */
+	NETMEM_TX_DMA,		/* DMA-capable netmem TX (real HW) */
+	NETMEM_TX_NO_DMA,	/* no DMA, e.g. passthrough for virtual devs */
+};
+
 enum netdev_reg_state {
 	NETREG_UNINITIALIZED = 0,
 	NETREG_REGISTERED,	/* completed register_netdevice */
@@ -1809,7 +1815,8 @@ enum netdev_reg_state {
  *	@lltx:		device supports lockless Tx. Deprecated for real HW
  *			drivers. Mainly used by logical interfaces, such as
  *			bonding and tunnels
- *	@netmem_tx:	device support netmem_tx.
+ *	@netmem_tx:	device netmem TX mode (NETMEM_TX_NONE, NETMEM_TX_DMA,
+ *			or NETMEM_TX_NO_DMA).
  *
  *	@name:	This is the first field of the "visible" part of this structure
  *		(i.e. as seen by users in the "Space.c" file).  It is the name
@@ -2132,7 +2139,7 @@ struct net_device {
 	struct_group(priv_flags_fast,
 		unsigned long		priv_flags:32;
 		unsigned long		lltx:1;
-		unsigned long		netmem_tx:1;
+		unsigned long		netmem_tx:2;
 	);
 	const struct net_device_ops *netdev_ops;
 	const struct header_ops *header_ops;

-- 
2.52.0


