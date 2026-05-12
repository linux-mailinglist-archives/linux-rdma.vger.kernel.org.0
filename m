Return-Path: <linux-rdma+bounces-20437-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE3VFzmAAmpDtwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20437-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 03:19:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF29E518232
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 03:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6D303018BC7
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 01:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52674296BBA;
	Tue, 12 May 2026 01:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6OLNnaJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06185256C6C
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 01:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548698; cv=none; b=Eq3Fcuud49QEJ90XZYLmsPGD1nWQ10nkQWXwRv1NYLVMoIT9DDtnKkG6PqAD+CJSqUsLici/RiHcvhgxtmoDr1MrQp2csFPJh+fNDciOjTHLClymEoaocc+2RqdVh4SYIAYvDBLjtlnzYXF8nKz5Yz0CV+u/2gf4CFeEnyvAvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548698; c=relaxed/simple;
	bh=FkpSFBB/bX+rp9bKDxdBiyERkKc6SlIj+UXp0PrCs9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FImuNvs9H4+e2lnbUfvpgMhp/nE9NetnGTmO7L1V2PZ6/7X+6b2QtYUVt0qt0JK7Z1yc/qyDu2e2JLlb+XSKmpR7ri0Tf79xmonAxpOGg6Ip/jQnvCo3OT8jZ6lPJguQchZDlcjYB+dVGsvzUYW/FSBWfuubpGPmWO4zg6qDCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6OLNnaJ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7c307937816so16208207b3.0
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 18:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778548695; x=1779153495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLDMf75sSoZOlrolBDWd/AGNeQyGKtHDPvvwXPguYtg=;
        b=O6OLNnaJx+MlTLz/ACEqApos1UX6Lf8jPn6qF2GzWoOG7H3kLU2kMTVP9RetkuoDXw
         m2sov/ke7KXA/8S7iQnIWncNcOezzK0uPuMA9T1RGmbqSufQV8snuc5vzWruiJCtQa3O
         bsTPCZyPhtqtbf1CteG8pmrqXdFvguGGZB+dbdkGr4Sx4o0bUooZEYks0zmyK3gRN2Cl
         Dq6eQKCERmJphsLVqMHcFSz/DnY9+M9bsVQPXZV3udWhJiQ8TPJ7ZPLPXVF3zFiuVvB/
         WF5M8HakH6sIHLNCJYcC1XpY+Tzka2RS0koVy+SPnFBkGEBGTB0DQcV86Ja7q71vuL5B
         R3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778548695; x=1779153495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HLDMf75sSoZOlrolBDWd/AGNeQyGKtHDPvvwXPguYtg=;
        b=Kf+dz3zVvTHRCp1oVZGts9lJijv/sG2caO8K6mZFvOXmamtLTZxpX1rwD76BUY7wv+
         uMy0JHO1jKlY9vPQjinHeVEKFlF8UA+HwT/Hzd1puEw1tj/j84vafR2pxVbWleOheykF
         z9rUFy8DBS1rBbUwN5VE9EfPoR68H/ArCyw0lmQsXRKwsWj9xs+tIDTZHZylN7UxjA97
         Zz2fWi31cHbOqrT2t4A7HfOSuor+V0pOxl/PGOlTMR+20c1JiDutRPLIv9N/uR+X2oUv
         oxwHpjxZKtRjJtcBWGDI3eVlz0PcMj/PLOosexFEKfTA2XlXbwrt+1EQhSCAoiuNnEVL
         tLSw==
X-Forwarded-Encrypted: i=1; AFNElJ+CXkq2sSISv8RywSQOM3OWaG3CqpPsNdWiQ31nvgOXqPfzQNPVv2KJyDjz/vplvbPj3+sK+iUjnWnw@vger.kernel.org
X-Gm-Message-State: AOJu0YyBgyniZuYMfn9Tdav/ezGM85JsuxeOjDnD4SFUhPd85p4qYJRa
	RrW/22OKVTRZcef6ksssppLL7r9b850I5a/ErOrejuv6yz6fHqKb0dNf
X-Gm-Gg: Acq92OHFyQ4TyHGRLQsNTiUM9uoTK8RGVYTWdGpYRlV52rFQZJi/JIsbV0my7aEvnX/
	f3/W2QD2LY9hPrPwHCZEYdxJXTG7a5XNiR9FJCYWZU2pcF9fLieWMY6l1a3m9PkNQNOax8vvSGr
	tTXoKEDH2ioP/kuvMCQU+RznwDn0oRQREkSy/sc9wj/7XFsOAwKJkbL3xJTHgBHfe4E9PUSE3Va
	9AZpdTVoHidW/KsVBRsNwfQ02ekemnDRp/08WoLehpNPkLLCwhddwA7hlzrJltj4Bi+zzLG/Xod
	JKDWdMTw5cAbSqLcnS5nFZZjEck5bS6SlSna6/Vdr66KEAJP6UiKatpDTMuKOxsxvh+b0gD1WDw
	TWIhKQatq/zioD51tOy72S7xQ4FGeXxhS876a3tYmG+SHa6NUfLL4QFXcoUvMdaDi+UN6EsAqMY
	sUhlhXM7t4EWbLwdeCbwd8tA==
X-Received: by 2002:a05:690c:389:b0:7bd:6a98:58d7 with SMTP id 00721157ae682-7c1059649cbmr113947997b3.38.1778548694820;
        Mon, 11 May 2026 18:18:14 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:16::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c535f8e757sm5443377b3.34.2026.05.11.18.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:18:14 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 11 May 2026 18:17:56 -0700
Subject: [PATCH net-next v4 2/8] net: netkit: declare NETMEM_TX_NO_DMA mode
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-tcp-dm-netkit-v4-2-841b78b99d74@meta.com>
References: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
In-Reply-To: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
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
X-Rspamd-Queue-Id: AF29E518232
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20437-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,meta.com:mid,fomichev.me:email]
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Some virtual devices like netkit (or ifb) never DMA and never touch frag
contents, they just forward the skb to another device. They are unable
to forward unreadable skbs, however, because they fail to pass TX
validation checks on dev->netmem_tx. The existing two-state
NETMEM_TX_NONE / NETMEM_TX_DMA doesn't give the TX validator enough
information to differentiate devices that will attempt DMA on the
unreadable skb from those that will simply route it untouched.

Add a third mode to the enum so drivers can indicate 1) if they have
netmem TX support, and 2) if they do, whether they are DMA-capable:

NETMEM_TX_NO_DMA - pass-through, device never DMAs

Widen dev->netmem_tx from a 1-bit field to 2 bits to fit the new value,
and declare netkit as NETMEM_TX_NO_DMA. Devmem TX support over these
devices comes in a follow-up patch.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v3:
- net_cachelines/net_device.rst: align the netmem_tx row's type column
  with the rest of the table by using "unsigned_long:2" instead of
  "unsigned long:2"
- Split this into a distinct patch (Jakub)
---
 Documentation/networking/net_cachelines/net_device.rst | 2 +-
 Documentation/networking/netmem.rst                    | 3 +++
 Documentation/translations/zh_CN/networking/netmem.rst | 3 +++
 drivers/net/netkit.c                                   | 1 +
 include/linux/netdevice.h                              | 3 ++-
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 1c19bb7705df..7b3392553fd6 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -10,7 +10,7 @@ Type                                Name                        fastpath_tx_acce
 =================================== =========================== =================== =================== ===================================================================================
 unsigned_long:32                    priv_flags                  read_mostly                             __dev_queue_xmit(tx)
 unsigned_long:1                     lltx                        read_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
-unsigned long:1                     netmem_tx:1;                read_mostly
+unsigned_long:2                     netmem_tx:2;                read_mostly
 char                                name[16]
 struct netdev_name_node*            name_node
 struct dev_ifalias*                 ifalias
diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
index 5ccadba4f373..217869d1108d 100644
--- a/Documentation/networking/netmem.rst
+++ b/Documentation/networking/netmem.rst
@@ -99,3 +99,6 @@ Driver TX Requirements
    appropriate mode:
 
    - `NETMEM_TX_DMA`: for physical devices that perform DMA.
+
+   - `NETMEM_TX_NO_DMA`: for virtual or passthrough devices that do
+     not DMA, but still support handling of netmem-backed skbs.
diff --git a/Documentation/translations/zh_CN/networking/netmem.rst b/Documentation/translations/zh_CN/networking/netmem.rst
index 9c84423b7528..320f3eacf51b 100644
--- a/Documentation/translations/zh_CN/networking/netmem.rst
+++ b/Documentation/translations/zh_CN/networking/netmem.rst
@@ -92,3 +92,6 @@ dma-mapping API 去处理。
 2. 驱动程序应将 `netdev->netmem_tx` 设置为适当的模式：
 
    - `NETMEM_TX_DMA`：适用于执行 DMA 的物理设备。
+
+   - `NETMEM_TX_NO_DMA`：适用于不执行 DMA 的虚拟或透传设备，但仍支持
+     处理 netmem 支持的 skb。
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5e2eecc3165d..0ad6a806d7d5 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -466,6 +466,7 @@ static void netkit_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->priv_flags |= IFF_DISABLE_NETPOLL;
 	dev->lltx = true;
+	dev->netmem_tx = NETMEM_TX_NO_DMA;
 
 	dev->netdev_ops     = &netkit_netdev_ops;
 	dev->ethtool_ops    = &netkit_ethtool_ops;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a54a37fab8d9..8ece36815ff9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1791,6 +1791,7 @@ enum netdev_stat_type {
 enum netmem_tx_mode {
 	NETMEM_TX_NONE,		/* no netmem TX support */
 	NETMEM_TX_DMA,		/* DMA-capable netmem TX (real HW) */
+	NETMEM_TX_NO_DMA,	/* no DMA, e.g. passthrough for virtual devs */
 };
 
 enum netdev_reg_state {
@@ -2137,7 +2138,7 @@ struct net_device {
 	struct_group(priv_flags_fast,
 		unsigned long		priv_flags:32;
 		unsigned long		lltx:1;
-		unsigned long		netmem_tx:1;
+		unsigned long		netmem_tx:2;
 	);
 	const struct net_device_ops *netdev_ops;
 	const struct header_ops *header_ops;

-- 
2.53.0-Meta


