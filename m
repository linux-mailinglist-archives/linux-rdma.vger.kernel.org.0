Return-Path: <linux-rdma+bounces-20198-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIWTDldK/WmUaAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20198-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 04:28:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E424F0BE7
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 04:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C559F302D948
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 02:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA82271A9A;
	Fri,  8 May 2026 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhD8ywl8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9BD2F8E97
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207296; cv=none; b=eKTctabMXSWonjML+l2le5Wqi/oOjGsyg/gJob3Jgc6d0hDqEl8hOuHs9Uef4DJWGyEcNrdpEX7yYOC3NwUit5RGIs1USGCN9fzzvL7/mG2rtgCLglhnc+uYD+tKi1c4LgLPtCepYeLeow6elnbvy3iZg8YVYtbtOp2KEbQc+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207296; c=relaxed/simple;
	bh=/lNahW0qH8K0+NIvZOluCBfxYa6+/OAUPOrP6arGj7c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nWnawDP2s3+zb5kfSevS3sK5FixhnzI/hXaJhY9DPug9Vbrc3QDfonEvZj4s3HHixTmaD2WqYiuKqQyZ+isIIgwvcjrUJBpzgFNr3zaaXU1cSVSewgiOzcbKkqa0/kylEkVw6OgN9jseEdXIUwYrTLDmYLLDHfCKKVbUs9iGvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhD8ywl8; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8ef5776530bso154658085a.0
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 19:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778207293; x=1778812093; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R4fDbIAs9UGsG5BRjIV/zutXsgn+/A8hyIYyhPO4W8k=;
        b=JhD8ywl8YTG+oe9AKARZqGyR6Z6S/zxlPtSDoZNErOEbpMBzzuzOZ2WFKZLN7fKUbf
         7c6NjfsFmN1pGfTfV0s1itkQ2H5eTAhbpkmaXA4bWMrSqxL+F/JxpCBNIm40u8dBPsLS
         xOrGOzTkTkqks7KaqmF65W3NoI8KdTKLmhpyEV0+52lVWW8dOTpUsj30+zP0Shhpid2H
         WTmsGg9I+XQdo1lr1p6tlq8eoxrfhUCSjZGyjteGOb87GAzHqfT7RfzM+MPaRlLd++VU
         gylL5ddgdHa9thRiDMrjmeSIHHd4HyXW6WdfFWXdQpUCnqYRfD9fiw9XkwECVm2KgZib
         L9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778207293; x=1778812093;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4fDbIAs9UGsG5BRjIV/zutXsgn+/A8hyIYyhPO4W8k=;
        b=J1KAqy6mRXbkvwgU10Fneo5I2T+rKRvCC2xxrRl/LIufSnFUUENPfxy6+9oR7IfZE6
         7phyZS1ydaa3F8WO3D+Mp/V/jTZzqoJJow2j10X0xBkdiVvScMvcFN/zUs5l/8IWIEcu
         62OkhLd+YY/sXkE45BdAeyRrxWISteGEgkNBO8/M3x5XgvSE3OaKEDVt/zOOe3ALRhkM
         QmFOBzdwvncHxBEMZvw+x7b8QrcJB4+xl3RkkhgNM98ai7ln90Uyf0Vf6TMecYubKcqQ
         ORv3d/zrkr0RQStmjmBtsB3rWbeh26WDbJouEsAV20cOdy7M3436wE0v91Ltdh8mHKjv
         Xj0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/JyFSTxTq9sLXuHpx2u7wA0Fc7DYwksUs/wM7JizR5oUrhp8aq/NL6xl9aqvngWn3J/G/qPokn8C7S@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2NL4K3mEc3kMQSmP1ac7/0uMhRUcHPPM/10bi749pWyy18xUT
	i+XxOsa0sU/yYO/Gff9CWosBwn9pcMJwtft1FH90g5nn1A1Hmr+AZI2b
X-Gm-Gg: AeBDiet/YdTnfb5xpkGZmGjnUQPs4KRkcAOoaAOznrZ2c3scRqFReK1tnJ34GAMh5FK
	wk01RmmZxwxXQ9iY8dk9jypJfKQLIYGrjjRI/weMFKUjGjWd8kdSEQ1/HgnUU2bcYokwo9K/CXU
	+QejWVWjVWK8B9ownia3BxPdFU0oUNCCLb6pmiQUarQ4Z7TuozfAATJmrAgXJimeMOnvFvScL2F
	IOGpI6eQ9+ZZaX+/SaXImObgk/N0atR6o2ATRi8eLCTP33I2m7j5DCrRuOAc9Y9etSzcWAJuDGA
	hyvBLSI5sWoJKfXuIRI+Q3GESfiqJ1N9lU9itpk7OOUt3AZ53r4h83d929kg+U8Gc865HD2WLeb
	VOWviIzY22L0ILjUw22RoXIC+CjvxZTWRBeXS/a3CaNwbFDdhJ+UkFe6AHBeEcmCWJ2Mt4CyARW
	Kjvu0h/CtruLtBAnnYgHJqPA==
X-Received: by 2002:a05:620a:454f:b0:8c6:a2f2:d874 with SMTP id af79cd13be357-904d5d0d5bfmr1616784585a.39.1778207292615;
        Thu, 07 May 2026 19:28:12 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:25::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cd7dsm2077258785a.37.2026.05.07.19.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:28:12 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v3 0/8] net: devmem: support devmem with netkit
 devices
Date: Thu, 07 May 2026 19:27:45 -0700
Message-Id: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACJK/WkC/13NTQqDMBBA4auEWTslTPzDVe9RXGgy1qEYJQnBI
 t69kGXXD753QeQgHGFQFwTOEmX3MChTKbDr5N+M4mBQQJpaXZPBZA90G3pOH0lIs+v6uTW9Mxo
 qBUfgRc7ivcBzQs9ngrFSsEpMe/iWUabSi9no+s/MhBqb1jU02Y4WVz83TtPD7huM933/ANASU
 N+zAAAA
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
X-Rspamd-Queue-Id: 93E424F0BE7
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
	TAGGED_FROM(0.00)[bounces-20198-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
   DMA-capable netdev exactly matches the bound device, guaranteeing the
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

---
Changes in v3:
- Fix validate_xmit_unreadable_skb() logic for non-devmem
  unreadable niovs (should not be dropped) (Sashiko)
- Simplify lock handling in bind_tx, no premature release (Jakub)
- split NO_DMA changes into separate patch (Jakub)
- fixed some pylint issues, one required an additional patch ("selftests:
  drv-net: make attr _nk_guest_ifname public") to rename a variable from
  private to public
- see per-patch changelist for more detailed changes
- Link to v2: https://lore.kernel.org/r/20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com

Changes in v2:
- Squash driver conversion patches (2-5) into patch 1 (Jakub)
- In validate_xmit_unreadable_skb() to check netmem_tx mode before inspecting
  frags (Jakub)
- Lock bind_dev around netdev_queue_get_dma_dev() when bind_dev != netdev to
  fix lockdep (Sashiko)
- Move require_devmem() into individual test functions so KsftSkipEx goes up to
  ksft_run() (Sashiko)
- Add nk_devmem.py to TEST_PROGS in Makefile (Sashiko)
- Link to v1:
  https://lore.kernel.org/all/20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com/

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Bobby Eshleman (8):
      net: convert netmem_tx flag to enum
      net: netkit: declare NETMEM_TX_NO_DMA mode
      net: devmem: support TX over NETMEM_TX_NO_DMA devices
      selftests: drv-net: ncdevmem: add -n flag to skip NIC configuration
      selftests: drv-net: make attr _nk_guest_ifname public
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
 net/core/dev.c                                     |   5 +-
 net/core/devmem.c                                  |   6 +-
 net/core/devmem.h                                  |   9 +-
 net/core/netdev-genl.c                             |  65 +++++-
 tools/testing/selftests/drivers/net/hw/Makefile    |   1 +
 tools/testing/selftests/drivers/net/hw/devmem.py   |  77 ++------
 .../selftests/drivers/net/hw/lib/py/devmem.py      | 218 +++++++++++++++++++++
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |  58 +++---
 .../testing/selftests/drivers/net/hw/nk_devmem.py  |  55 ++++++
 .../drivers/net/hw/nk_primary_rx_redirect.bpf.c    |  39 ++++
 .../testing/selftests/drivers/net/hw/nk_qlease.py  |   8 +-
 tools/testing/selftests/drivers/net/lib/py/env.py  | 109 ++++++++---
 21 files changed, 549 insertions(+), 138 deletions(-)
---
base-commit: 790ead9394860e7d70c5e0e50a35b243e909a618
change-id: 20260423-tcp-dm-netkit-2bd78b638d30

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


