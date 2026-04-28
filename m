Return-Path: <linux-rdma+bounces-19701-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MjiAso38Wm/egEAu9opvQ
	(envelope-from <linux-rdma+bounces-19701-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:42:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BD348CAE1
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD21E30054C9
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCF33845A8;
	Tue, 28 Apr 2026 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkQS6h2n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF70937D11E
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416132; cv=none; b=FpXctJktydTBmLsI//koicwxIaX9jZyf6q9XM52cmRyDdHlTtX4dSG3DV5JP0yrCbmEYtdzDWhEMw+D5lsR1S7LcuIHoEP5O7lizEqV0g96+4q9mTw1aa7qDf8UtuiWc/aEsMLr7G3TXYL/XsVhSZAAfeWUrqiKEQFGrN0YR8r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416132; c=relaxed/simple;
	bh=QdD1HKJpAgzhykKzsagdptin62NeoKdrKUGBDM0LtX0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PYzEnmUt+gQWnbo17xNT0vft8CPFWQqEuZvSu6nbNBzO1GKGLi2SBNNYK6fvWRoMgSI9UWmuVefGoRPAlmTVMOx+WGs+AO+fo6YQE/xpBysj6apctOD3IzVdMB45G/Q787oiuxe1D0pn25k9jzFN7CP9afh03trUAPWk2xBkdH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkQS6h2n; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-43034c0fd27so1271906fac.1
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 15:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416130; x=1778020930; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3EHr1+KPBD6HcP0YlQsw18iawEYZpzFd0IofqOG3VI=;
        b=lkQS6h2nEEeIP3FeXukbv5K6lErX5QBDwdcKnnOICY1RpNvcZhquv0qqs0FWrXr3an
         yaP1OI6u7dKbwNykyY4Q+kctebxvpUWB5Sc3da4dA5ENZs93lQ02TKRVVm2bBLF7S3ER
         x6nWnLH6JXW94QAxP2XjSQvfNJ9nwYgny8qnFyF/+avYpy62ALQ29PaVcPx3d8mCER0z
         In8YnFbKlRXZqljv3gr3LU5nHmFIaWNxEAPFJbjhwe9PLeJLgy0OKHraXVv2Lu1YsMla
         je0zDnNU4X6Wqy7It6EXb62/Pb9zf5MJ/nyK4oyHl0AnyE2tY9zia+i4vn33VADau/iD
         rOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416130; x=1778020930;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3EHr1+KPBD6HcP0YlQsw18iawEYZpzFd0IofqOG3VI=;
        b=N0RahQbRQkmRJRuX+Xaz29ZH9ivAxZKDiRhdy+7YROiqSOHAE6/wXJIryWwGuwTWsa
         NAsYO3ADRh0AfY9SaSO7ykXpTN8wN4g/rSqep/SHgeTy7/wU+k0Ov4Bq7W/XpO3IyNAP
         eprRJOis5dDG0wamgefiVmXNG9xSRoSpxvEkNb1GZ5hDCdxw8+fLuT8cmmgErgx9H/5L
         W85LNZkQZD71HtB38EYKK1CEQd6Ces4I/48A/ITNt5+KcdYFZsLLPM2gdoyNRnS4hEcm
         8xrQUaU/JsShrYYaS4I6x5fSKDICQcEO0oBW3+ZLcixhuyWIK2VLjpBRv238zCm+7/TD
         SUZw==
X-Forwarded-Encrypted: i=1; AFNElJ+6BSPFp4o0Cx3C8Bc8iWrdKLbGyNVsGDA90f2q7Nkq+ZMlTRVgNvG94yql9Us4+uT38jf1F7cDECgg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm7fVo1Jej8gFFqEalp3O3zUzObA9jFgTL7MCpEtVJlCDiQXNF
	ieBA6T+GHxljSvIDTrg82jkjLv2ITSS9Sd5JznZ+W22wgz1dU+xG2zTS
X-Gm-Gg: AeBDiev4cRSaVfkl5/tF86y4PjhlRLg7eAuTOPwcR62qwM7mZoh3e3l+tEIWxsSAC9f
	5IoK1WqArJmLxggiNTl8ARFCK+MExmwW5RTQsVsSJiGIgW5RVEi6DGWwCxr5WhDh7Ci4RSmwwwU
	eeIV6fOgftsEaSq+SiVQYTW+d3VgjhnMAORErwTiZw2igH45oeeroxpOsjsfdw3ZbSdhgzt41Z7
	4zmMcDonuBkpg4qG1Ow8OateOxzqv39mrq6ta9IKcyxhuFS99c3FDlYFPKmQNUlrPkZDLcx2sUO
	mIkmxbi7MqCmi3QLQmxkXV0PK9zMHabdDCtBCeUr1vKJTFfppuh8z2uf1T2mbbSYZU34RR82eWn
	m5YYfQjPlRJXwK1SX4gwLaSCYtNS30dKyi/Qx+qpaAulTqxQzc3Guk7Ek63kIjO6u6iGNP9qGMp
	CtOc7176YMp3t/7p+xnjCs7YSw1MjHj3Dl
X-Received: by 2002:a05:6870:8914:b0:417:2daf:6aa1 with SMTP id 586e51a60fabf-433f3bd6bcemr3008770fac.37.1777416129894;
        Tue, 28 Apr 2026 15:42:09 -0700 (PDT)
Received: from localhost ([2a03:2880:f812:18::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4340e9d05eesm382404fac.17.2026.04.28.15.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:09 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next 00/11] net: devmem: support devmem with netkit
 devices
Date: Tue, 28 Apr 2026 15:41:57 -0700
Message-Id: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALY38WkC/x3MUQqDMAwG4KuE/9lA14qTXmXsYdpsC2OZtEEE8
 e4DvwN8O5pUlYZMO6qs2vRnyHTpCPP7YS9hLciEGOIQ+pjY54XLl038o85xKtdxGtJYUkBHWKo
 8dTu/G0ycTTbH/Tj+94qwWGkAAAA=
X-Change-ID: 20260423-tcp-dm-netkit-2bd78b638d30
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
X-Rspamd-Queue-Id: 86BD348CAE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19701-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:mid,meta.com:email]

This series enables TCP devmem TX through netkit devices.

Netkit now supports queue leasing. A physical NIC's RX queue can be
leased to a netkit guest interface inside a container namespace. This
gives the container a devmem-capable data path on the RX side (bind-rx,
etc...). On the TX side, the container process binds to its netkit guest
interface and sends traffic that netkit redirects (via BPF or ip
forwarding) to the physical NIC for DMA.

Two things in the existing devmem TX path prevent this from working:

1. validate_xmit_unreadable_skb() requires dev->netmem_tx before it will
   forward a dmabuf-backed (unreadable) skb. This protects skbs from
   landing on devices that don't have the IOMMU mappings for the backing
   dmabuf or that don't speak netmem. Netkit, however, does not support
   DMA, doesn't attempt to read unreadable skb pages and so doesn't
   break netmem (it is pure skb routing and redirection). It is
   functionally capable of routing unreadable skbs, but there is no way
   for the TX validation pathway to distinguish between a device that
   will actually attempt DMA-ing the skb and another device
   (like netkit) that does not DMA but also does not break
   netmem.

2. bind_tx_doit uses the bound device as the DMA device.  When the user
   binds devmem TX to the netkit guest, the bind handler attempts to
   create DMA mappings against netkit, which has no DMA capability and
   no IOMMU mappings.

This series solves these problems as follows:

1. Extend netmem_tx to two bits, assigned to one of three values:

   NETMEM_TX_NONE   - netmem not supported
   NETMEM_TX_DMA    - netmem supported and performs DMA
   NETMEM_TX_NO_DMA - netmem supported, but does not DMA

   With these bits, phys devices can set NETMEM_TX_DMA and devices like
   netkit set NETMEM_TX_NO_DMA. The validation TX path ensures that any
   DMA-capable netdev exactly matches the bound device, guarantee the
   correct mapping of the bound dmabuf. The validation TX path also
   allows devices with NETMEM_TX_NO_DMA to pass, knowing these devices
   will not misuse netmem or run into IOMMU faults. After redirection or
   routing and the skb finally makes its way through the stack to a
   physical device's TX path, the above NETMEM_TX_DMA check is performed
   again to guarantee the device has the appropriate binding/mappings.

2. On TX bind, the bind handler recognizes NETMEM_TX_NO_DMA devices and
   finds the phys TX device and binds to that instead. For the netkit
   case, if it has been leased a queue from a DMA-capable device
   already, then the bind action is performed on the DMA-capable device
   instead and the dmabuf is mapped correctly.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Bobby Eshleman (11):
      net: add netmem_tx modes that indicate dma capability
      net: bnxt: convert netmem_tx from bool to NETMEM_TX_DMA enum
      gve: convert netmem_tx from bool to NETMEM_TX_DMA enum
      net/mlx5e: convert netmem_tx from bool to NETMEM_TX_DMA enum
      eth: fbnic: convert netmem_tx from bool to NETMEM_TX_DMA enum
      netkit: set NETMEM_TX_NO_DMA for unreadable skb passthrough
      net: devmem: support TX over NETMEM_TX_NO_DMA devices
      selftests: drv-net: ncdevmem: add -n flag to skip NIC configuration
      selftests: drv-net: refactor devmem command builders into lib module
      selftests: drv-net: add primary_rx_redirect support to NetDrvContEnv
      selftests: drv-net: add netkit devmem tests

 .../networking/net_cachelines/net_device.rst       |   2 +-
 Documentation/networking/netmem.rst                |   8 +-
 .../translations/zh_CN/networking/netmem.rst       |   7 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   2 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |   2 +-
 drivers/net/netkit.c                               |   1 +
 include/linux/netdevice.h                          |  11 +-
 net/core/dev.c                                     |  24 ++-
 net/core/devmem.c                                  |   6 +-
 net/core/devmem.h                                  |   9 +-
 net/core/netdev-genl.c                             |  53 ++++-
 tools/testing/selftests/drivers/net/hw/devmem.py   |  73 +------
 .../selftests/drivers/net/hw/lib/py/devmem.py      | 215 +++++++++++++++++++++
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |  58 +++---
 .../testing/selftests/drivers/net/hw/nk_devmem.py  |  40 ++++
 .../drivers/net/hw/nk_primary_rx_redirect.bpf.c    |  41 ++++
 tools/testing/selftests/drivers/net/lib/py/env.py  |  67 +++++--
 19 files changed, 498 insertions(+), 125 deletions(-)
---
base-commit: 790ead9394860e7d70c5e0e50a35b243e909a618
change-id: 20260423-tcp-dm-netkit-2bd78b638d30

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


