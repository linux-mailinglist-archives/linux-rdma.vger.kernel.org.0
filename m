Return-Path: <linux-rdma+bounces-20200-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKmTCVhK/WmUaAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20200-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 04:28:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 641534F0BEE
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 04:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDE2B3014DA2
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 02:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A37282F3B;
	Fri,  8 May 2026 02:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUimMc2F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F4D274FE9
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207300; cv=none; b=snZV0qNaY7v7L5HR4GnMeyX1Okqjwwt0dH8RcguCN70Xpjb34ZsVYICGmwuTKsS/x86n646qUTjJ9zitcGe2HcP5O4yhL4IWIUkK8dZbIyZv0LOEz6V73w9/jfYnikMTLhG+Xe3DFYCmSBLUg3kAtNjCujx4H8KyWE21FjyklH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207300; c=relaxed/simple;
	bh=GjN+txHCuGhk6KpGtuJRi/w4OZ+vPPWTjBtg1/w6tJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2oNGp86NdSPliGRZ/3yA2XsL7zlqryiawRRctSGJYPSLUaKT7dJtWNYxnj5BbwGS6WukU3gapETkHXwSJAFJTB54HPwLCigSXGukyHwoy5K2D7ZdLh4ezAQkRFQw6WnkKn60bzQTJEuIKUcecm7xfEJB6TZIGZDovcpw/nyznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUimMc2F; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8b6dd874471so19630356d6.0
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 19:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778207297; x=1778812097; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKyr+spA0neYAx9lJFUt4Ya16cMDVZqVWltu3Xv0UPc=;
        b=dUimMc2FX1tEOz5SEpCSqC7TsT5gpcpYp0+3Qa+utdT5OpVK2GH383nfeoHNlC9nAH
         8naG7Dqvlj3XryW2GDl1nuZt5Voq66iKSnEhGZxtmUOb33BW+gwUs44wG02tUj0Xjalg
         wTJjInpFVAdBN8upHg1x6KN5qRm0I6Dc2tncNg6/wZGZjC/1+Di9bpl+r/tGMkHgK/JD
         Z2nPqWrjCm1rcAIZP8hgb0AMDgI4GbpSR7/3fSCTuwQZpDKQh4ZBwJYvub9Jc8GQpcsk
         VW/cBD0z6vJwuSDG+Ac0oxZKYOMRlf6xbd7lVZZjDSgPw95sjDRlFVfbXnZetl9a6Z64
         CTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778207297; x=1778812097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AKyr+spA0neYAx9lJFUt4Ya16cMDVZqVWltu3Xv0UPc=;
        b=Cv3jOqskphkzWJD80UwktaEdNXwmibxo6guohoQ8ykEAPOsKh5ESJKxnUQ+/xQDnpY
         Qt44WKxVsE5f95Lsy75X5rug2+T6bJKCVmpb6d4fp4M3wGArE1tU+nfKsnwa1qtl5VvE
         zoRitB2+01YquPM0EUuN7yitSMrICr8OBM61jwpWSqrWZxGsXkmhXQfJ7CdvTNRvyefO
         Xqma8jA6SSC0uEg50jkbR8FuFcyIrcDj0GY2w+G7TO3dvr2mAI0WcB2TeMCsMItFdG7B
         9tgzGdLCxjUPZ37MlJIBv5SPje7oqmNIuRLbEHnQy6cLS5BgZpkN096DI2E2l+bYwgzy
         PfAg==
X-Forwarded-Encrypted: i=1; AFNElJ/Dg5rV1464oD+yf+KljRDHKPv2i1G69dPsmuqnrDYM1cRN3vVkuY+0C6CDaAboo2BZtfEd58tQ7VZS@vger.kernel.org
X-Gm-Message-State: AOJu0YzxL02iEqKM9KiuAnx5iIi03jeweOaDiTeFKnjc02U5VBgEuuyU
	GUctH6R1v6cvsfRR/KjVSmW8t+YeVojMpvGM8/KJouQheR4yp8xj/nov
X-Gm-Gg: Acq92OFQcYviEwS/tLhDIracTI5rEzzvIfnpFpKYlXL/YXXEGMYtS+PXNu6Tn8yW+8v
	5Q/mUQsm+vr42Zk5FEhgm+mBmur9sDEUGOsyVysNLYqtXHft5kJ7Wh9RLLCk4JPaUU1x1Nn/7SM
	QW05+S5527YuG99HWvIXK+dVOed1RA8EKHUcx687Cczim+9Fx+H/PiO1FcA3ZZGpnnez6ohHBPl
	mnpHxBrvfiZbFrUoM7q/tvemJ88oj9S4FTLtHxqatdjCKfU/pW9SgxBUz8nW94t7f53B0orqh7F
	lE97T3XpdWCctWn8bmnSW3AD1J8OVyof2WD95D5cH3k1y10syc8ndZXQRed9+j2we9DkgpQKicC
	C8jWRlY3RhA4rR3QLICLbh9wwO1SK79gk8IFt5M3BfDj234yupKqK0DhqbAU1pqeoAqQZ2sjtL+
	lYpUct5n3l9Hb+DqtPCJuOfg==
X-Received: by 2002:a05:6214:5b85:b0:8a1:34df:bbe3 with SMTP id 6a1803df08f44-8bc443d5a41mr158397216d6.28.1778207296694;
        Thu, 07 May 2026 19:28:16 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:3e::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3a43636fsm5524446d6.21.2026.05.07.19.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:28:16 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 07 May 2026 19:27:47 -0700
Subject: [PATCH net-next v3 2/8] net: netkit: declare NETMEM_TX_NO_DMA mode
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260507-tcp-dm-netkit-v3-2-52821445867c@meta.com>
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
X-Rspamd-Queue-Id: 641534F0BEE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20200-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[davidwei.uk,gmail.com,google.com,zte.com.cn,vger.kernel.org,fomichev.me,meta.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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
 include/linux/netdevice.h                              | 7 ++++---
 5 files changed, 12 insertions(+), 4 deletions(-)

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
index 580bccb118a0..11d68e75eb4f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1791,6 +1791,7 @@ enum netdev_stat_type {
 enum netmem_tx_mode {
 	NETMEM_TX_NONE,		/* no netmem TX support */
 	NETMEM_TX_DMA,		/* DMA-capable netmem TX (real HW) */
+	NETMEM_TX_NO_DMA,	/* no DMA, e.g. passthrough for virtual devs */
 };
 
 enum netdev_reg_state {
@@ -1814,8 +1815,8 @@ enum netdev_reg_state {
  *	@lltx:		device supports lockless Tx. Deprecated for real HW
  *			drivers. Mainly used by logical interfaces, such as
  *			bonding and tunnels
- *	@netmem_tx:	device netmem TX mode (NETMEM_TX_NONE or
- *			NETMEM_TX_DMA).
+ *	@netmem_tx:	device netmem TX mode (NETMEM_TX_NONE, NETMEM_TX_DMA,
+ *			or NETMEM_TX_NO_DMA).
  *
  *	@name:	This is the first field of the "visible" part of this structure
  *		(i.e. as seen by users in the "Space.c" file).  It is the name
@@ -2138,7 +2139,7 @@ struct net_device {
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


