Return-Path: <linux-rdma+bounces-15365-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B788BD021FA
	for <lists+linux-rdma@lfdr.de>; Thu, 08 Jan 2026 11:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0C1E3008CA3
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jan 2026 10:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2EF3A4AAC;
	Thu,  8 Jan 2026 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sp0DxZ3M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21912364E86
	for <linux-rdma@vger.kernel.org>; Thu,  8 Jan 2026 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868019; cv=none; b=naNlR0nuZbPcECAzqFvClmXCd3iSMxUqu6Vv+vyBY1MbkpeK+hKY4bHCuh8qMGCdg9wfPSalTGFqNXOp0NUCMrvzPO4TDBug/SbsEfxOUeiriWOEu0Qjy/HrgHqIi8JpiaUYoRlJRchqBF+gxM1aJd61Pe4NCUyLDan4eLFhj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868019; c=relaxed/simple;
	bh=zXlIp14bGuRNzKmm8Dku8f9Yb6RD5C9Q9gIjSx8ABmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n2C5tMrMG8HopWWvSi+rLej+GrJIiiDfiMG6oIVUBTE8y++3lcWlP0iCkwpLNrQrG//xCrR5wwB7BxaXCp+tdKv0qpY2Oa8ibRAtDmAyXK6M4HPw7bXMqkAVrb9V6hr4iC+inh5Yt/p/Pvitq1PO1nhTJUulhbD+kMeSp8mjJCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Sp0DxZ3M; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-7c76f65feb5so2357812a34.0
        for <linux-rdma@vger.kernel.org>; Thu, 08 Jan 2026 02:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868007; x=1768472807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tY2+t0l557GSsjMoRko+cZX+m7SpHKP0G/1LAwo4WgE=;
        b=I6bBlsePtibiWNQrUHEuUDcAgW4JWr0YexT9vFrDlmp9ApAYhVQDpDWzpyRY1JZhT1
         x9+pd3zU+VaqBv6zmZdYWTZY+hbH/oD9MA/2Iz9mh6ODWt44euOwZpqsSxxTXxpcSgeS
         ES9Lb8msGi/lPvNCLzFBJr7zE33uJzV8qV9IvpUnW7DQKqGigKa0ggn4VNV6LDSntuco
         k1PLLVKMlHcz5D7Vm7FJ77JFJcgpHWv6Zs96TSwu/zBNR8NxPhDRzTXCFD22thLW0+5n
         xCpSX+KSu2oSY9MHYC24WykrHSy+zf4OseyeC96v9mE+Y6brCOlkI15Iv5ic0nFXNeen
         DmkA==
X-Forwarded-Encrypted: i=1; AJvYcCV2FTbZ29e8Ur7xxYSHvpGrE8YlN4L85wNKNIrufXFvqLc/ckroWO/lUWGoxnPE4MT21xanFy4ZqNDQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ23TSRtcWO3X/OhUD2+U/PpLunUJNdhWuhw4XwUZOLXpkWCE6
	UNQz31lrdv3E+Iiyr4w+YRaRAUGjLIY/y+KNJmshWH63YBE7MwLoSRVxEfrrDes0zaeMrauNkSZ
	42wewBCT90Sb2bGZsyrr5muv1bBYtEifNKPazMZ9hc+yp28XzpkmQvO7K8iPehk/G1zp/5/3nuK
	70WXSIGDhytmq+LnXVsflmtlJd/YPs0uAtXKF+lGVNYDiQV/lxhYU+xzMvfUU8m382gkjPYzzDi
	gMpE71nC1Vg/24us/jSr8U=
X-Gm-Gg: AY/fxX6B5Iqkpkh/bQGZxe+kpXrFA3a4NFyMlVYYcN5/ZSIj9m5BRcvxIr34vL+opgU
	OlTE7iXIDD8Fcqq1lXmGU7tOZdirB8aUwp4NpUAkNLkodzgm/2bZ7SAHbqTQVdoOcdAUqA0N4Dv
	onLOCtgYti6+0UhVXzp45OftSdI7MlEwqLOSvBUuOmgWR/Wls2LwM7CEY+iJUUYo+YlyCUUUxJP
	hYpveQAA1JfhgyX9nA66JvsiHtdSEn6U7pyvCi/bDYKWfL5lRg7/u3hU9EPuoVw+ukQwhkKhjn6
	ioVQ36xXlN3vGw9GtPWRfUHjQOL/ZJTGues8yCv2MUI8Nbgat0LoO4+JysvLalQkf/c5GhYvr6c
	5OYK0VC3+DvcnS5Y0Q0XWQS6/y+vhAxdwtO7ybdhDPHV2IaYqi+Jtd8+vjo42bhK2NHL/oxa//e
	ixoU0irxBW8T7OV1052nfGUfwk1BbtzwD5KeV3139XVefNcA==
X-Google-Smtp-Source: AGHT+IE+BTjGL2KQdNdQ+nAH85Kv70ZRkcx42VQr/Kt8ooihwbeSaO7w+0OT+tfo8tS7g8RohQgIgMqefeQ8
X-Received: by 2002:a05:6830:34a8:b0:7ce:519d:10bd with SMTP id 46e09a7af769-7ce519d1565mr2894491a34.6.1767868007194;
        Thu, 08 Jan 2026 02:26:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7ce4789e847sm1220078a34.6.2026.01.08.02.26.46
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 02:26:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ffb40c0272so46997541cf.3
        for <linux-rdma@vger.kernel.org>; Thu, 08 Jan 2026 02:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767868006; x=1768472806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tY2+t0l557GSsjMoRko+cZX+m7SpHKP0G/1LAwo4WgE=;
        b=Sp0DxZ3McFmgShx9No+V6z1tNltN4ThZO5AWF2jXJTL0jR+Ll1YjO63erxg6g83PcM
         NBDKvH4W0N7FNk8zho62rqD7VEuqQBx315unlwOIomOIaqoskYRloVAaLGIEynHDbPMq
         js7JMgGBQe3YJW0r4hLegzflSudBUougMq5Uo=
X-Forwarded-Encrypted: i=1; AJvYcCWkfDg+6xkWCAW74T7YT1x8NCVEeMg9BbBKwUQ0ylQtTaoQ9ZTFLfYOtYb7f4m3Z1gLqkXnWt5hsSjY@vger.kernel.org
X-Received: by 2002:a05:622a:188d:b0:4ee:2721:9ec9 with SMTP id d75a77b69052e-4ffb4b201b8mr74017091cf.73.1767868005700;
        Thu, 08 Jan 2026 02:26:45 -0800 (PST)
X-Received: by 2002:a05:622a:188d:b0:4ee:2721:9ec9 with SMTP id d75a77b69052e-4ffb4b201b8mr74016801cf.73.1767868005138;
        Thu, 08 Jan 2026 02:26:45 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e362fdsm45124721cf.21.2026.01.08.02.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:26:44 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	mbloch@nvidia.com,
	parav@nvidia.com,
	mrgolin@amazon.com,
	roman.gushchin@linux.dev,
	wangliang74@huawei.com,
	marco.crivellari@suse.com,
	zhao.xichao@vivo.com,
	haggaie@mellanox.com,
	monis@mellanox.com,
	dledford@redhat.com,
	amirv@mellanox.com,
	kamalh@mellanox.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 1/2 v6.6] RDMA/rxe: Remove the direct link to net_device
Date: Thu,  8 Jan 2026 02:05:39 -0800
Message-Id: <20260108100540.672666-2-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260108100540.672666-1-shivani.agarwal@broadcom.com>
References: <20260108100540.672666-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Zhu Yanjun <yanjun.zhu@linux.dev>

[ Upstream commit 2ac5415022d16d63d912a39a06f32f1f51140261 ]

The similar patch in siw is in the link:
https://git.kernel.org/rdma/rdma/c/16b87037b48889

This problem also occurred in RXE. The following analyze this problem.
In the following Call Traces:
"
BUG: KASAN: slab-use-after-free in dev_get_flags+0x188/0x1d0 net/core/dev.c:8782
Read of size 4 at addr ffff8880554640b0 by task kworker/1:4/5295

CPU: 1 UID: 0 PID: 5295 Comm: kworker/1:4 Not tainted
6.12.0-rc3-syzkaller-00399-g9197b73fd7bb #0
Hardware name: Google Compute Engine/Google Compute Engine,
BIOS Google 09/13/2024
Workqueue: infiniband ib_cache_event_task
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 dev_get_flags+0x188/0x1d0 net/core/dev.c:8782
 rxe_query_port+0x12d/0x260 drivers/infiniband/sw/rxe/rxe_verbs.c:60
 __ib_query_port drivers/infiniband/core/device.c:2111 [inline]
 ib_query_port+0x168/0x7d0 drivers/infiniband/core/device.c:2143
 ib_cache_update+0x1a9/0xb80 drivers/infiniband/core/cache.c:1494
 ib_cache_event_task+0xf3/0x1e0 drivers/infiniband/core/cache.c:1568
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
"

1). In the link [1],

"
 infiniband syz2: set down
"

This means that on 839.350575, the event ib_cache_event_task was sent andi
queued in ib_wq.

2). In the link [1],

"
 team0 (unregistering): Port device team_slave_0 removed
"

It indicates that before 843.251853, the net device should be freed.

3). In the link [1],

"
 BUG: KASAN: slab-use-after-free in dev_get_flags+0x188/0x1d0
"

This means that on 850.559070, this slab-use-after-free problem occurred.

In all, on 839.350575, the event ib_cache_event_task was sent and queued
in ib_wq,

before 843.251853, the net device veth was freed.

on 850.559070, this event was executed, and the mentioned freed net device
was called. Thus, the above call trace occurred.

[1] https://syzkaller.appspot.com/x/log.txt?x=12e7025f980000

Reported-by: syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4b87489410b4efd181bf
Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Link: https://patch.msgid.link/20241220222325.2487767-1-yanjun.zhu@linux.dev
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: - exported ib_device_get_netdev() function.
          - added ib_device_get_netdev() to ib_verbs.h.]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/infiniband/core/device.c      |  1 +
 drivers/infiniband/sw/rxe/rxe.c       | 23 +++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe.h       |  3 ++-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 22 ++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_net.c   | 25 ++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 26 +++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h | 11 ++++++++---
 include/rdma/ib_verbs.h               |  2 ++
 8 files changed, 93 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 6769c42e46d4..976a771b1f31 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2254,6 +2254,7 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 
 	return res;
 }
+EXPORT_SYMBOL(ib_device_get_netdev);
 
 /**
  * ib_device_get_by_netdev - Find an IB device associated with a netdev
diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 0f8356cea293..1fb4fa4514bf 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -40,6 +40,8 @@ void rxe_dealloc(struct ib_device *ib_dev)
 /* initialize rxe device parameters */
 static void rxe_init_device_param(struct rxe_dev *rxe)
 {
+	struct net_device *ndev;
+
 	rxe->max_inline_data			= RXE_MAX_INLINE_DATA;
 
 	rxe->attr.vendor_id			= RXE_VENDOR_ID;
@@ -71,8 +73,15 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_fast_reg_page_list_len	= RXE_MAX_FMR_PAGE_LIST_LEN;
 	rxe->attr.max_pkeys			= RXE_MAX_PKEYS;
 	rxe->attr.local_ca_ack_delay		= RXE_LOCAL_CA_ACK_DELAY;
+
+	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
+	if (!ndev)
+		return;
+
 	addrconf_addr_eui48((unsigned char *)&rxe->attr.sys_image_guid,
-			rxe->ndev->dev_addr);
+			ndev->dev_addr);
+
+	dev_put(ndev);
 
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
 }
@@ -109,10 +118,15 @@ static void rxe_init_port_param(struct rxe_port *port)
 static void rxe_init_ports(struct rxe_dev *rxe)
 {
 	struct rxe_port *port = &rxe->port;
+	struct net_device *ndev;
 
 	rxe_init_port_param(port);
+	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
+	if (!ndev)
+		return;
 	addrconf_addr_eui48((unsigned char *)&port->port_guid,
-			    rxe->ndev->dev_addr);
+			    ndev->dev_addr);
+	dev_put(ndev);
 	spin_lock_init(&port->port_lock);
 }
 
@@ -169,12 +183,13 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
 /* called by ifc layer to create new rxe device.
  * The caller should allocate memory for rxe by calling ib_alloc_device.
  */
-int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
+int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name,
+			struct net_device *ndev)
 {
 	rxe_init(rxe);
 	rxe_set_mtu(rxe, mtu);
 
-	return rxe_register_device(rxe, ibdev_name);
+	return rxe_register_device(rxe, ibdev_name, ndev);
 }
 
 static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index d8fb2c7af30a..fe7f97066732 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -139,7 +139,8 @@ enum resp_states {
 
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int dev_mtu);
 
-int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name);
+int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name,
+			struct net_device *ndev);
 
 void rxe_rcv(struct sk_buff *skb);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 86cc2e18a7fd..07ff47bae31d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -31,10 +31,19 @@
 static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	unsigned char ll_addr[ETH_ALEN];
+	struct net_device *ndev;
+	int ret;
+
+	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
+	if (!ndev)
+		return -ENODEV;
 
 	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
 
-	return dev_mc_add(rxe->ndev, ll_addr);
+	ret = dev_mc_add(ndev, ll_addr);
+	dev_put(ndev);
+
+	return ret;
 }
 
 /**
@@ -47,10 +56,19 @@ static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 static int rxe_mcast_del(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	unsigned char ll_addr[ETH_ALEN];
+	struct net_device *ndev;
+	int ret;
+
+	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
+	if (!ndev)
+		return -ENODEV;
 
 	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
 
-	return dev_mc_del(rxe->ndev, ll_addr);
+	ret = dev_mc_del(ndev, ll_addr);
+	dev_put(ndev);
+
+	return ret;
 }
 
 /**
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index e5827064ab1e..e2859bbc9a71 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -509,7 +509,16 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
  */
 const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num)
 {
-	return rxe->ndev->name;
+	struct net_device *ndev;
+	char *ndev_name;
+
+	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
+	if (!ndev)
+		return NULL;
+	ndev_name = ndev->name;
+	dev_put(ndev);
+
+	return ndev_name;
 }
 
 int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
@@ -521,9 +530,7 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
 	if (!rxe)
 		return -ENOMEM;
 
-	rxe->ndev = ndev;
-
-	err = rxe_add(rxe, ndev->mtu, ibdev_name);
+	err = rxe_add(rxe, ndev->mtu, ibdev_name, ndev);
 	if (err) {
 		ib_dealloc_device(&rxe->ib_dev);
 		return err;
@@ -571,10 +578,18 @@ void rxe_port_down(struct rxe_dev *rxe)
 
 void rxe_set_port_state(struct rxe_dev *rxe)
 {
-	if (netif_running(rxe->ndev) && netif_carrier_ok(rxe->ndev))
+	struct net_device *ndev;
+
+	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
+	if (!ndev)
+		return;
+
+	if (netif_running(ndev) && netif_carrier_ok(ndev))
 		rxe_port_up(rxe);
 	else
 		rxe_port_down(rxe);
+
+	dev_put(ndev);
 }
 
 static int rxe_notify(struct notifier_block *not_blk,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index dbb9baa4ffd0..102fc5f56ca7 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -41,6 +41,7 @@ static int rxe_query_port(struct ib_device *ibdev,
 			  u32 port_num, struct ib_port_attr *attr)
 {
 	struct rxe_dev *rxe = to_rdev(ibdev);
+	struct net_device *ndev;
 	int err, ret;
 
 	if (port_num != 1) {
@@ -51,19 +52,26 @@ static int rxe_query_port(struct ib_device *ibdev,
 
 	memcpy(attr, &rxe->port.attr, sizeof(*attr));
 
+	ndev = rxe_ib_device_get_netdev(ibdev);
+	if (!ndev) {
+		err = -ENODEV;
+		goto err_out;
+	}
+
 	mutex_lock(&rxe->usdev_lock);
 	ret = ib_get_eth_speed(ibdev, port_num, &attr->active_speed,
 			       &attr->active_width);
 
 	if (attr->state == IB_PORT_ACTIVE)
 		attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
-	else if (dev_get_flags(rxe->ndev) & IFF_UP)
+	else if (dev_get_flags(ndev) & IFF_UP)
 		attr->phys_state = IB_PORT_PHYS_STATE_POLLING;
 	else
 		attr->phys_state = IB_PORT_PHYS_STATE_DISABLED;
 
 	mutex_unlock(&rxe->usdev_lock);
 
+	dev_put(ndev);
 	return ret;
 
 err_out:
@@ -1428,9 +1436,16 @@ static const struct attribute_group rxe_attr_group = {
 static int rxe_enable_driver(struct ib_device *ib_dev)
 {
 	struct rxe_dev *rxe = container_of(ib_dev, struct rxe_dev, ib_dev);
+	struct net_device *ndev;
+
+	ndev = rxe_ib_device_get_netdev(ib_dev);
+	if (!ndev)
+		return -ENODEV;
 
 	rxe_set_port_state(rxe);
-	dev_info(&rxe->ib_dev.dev, "added %s\n", netdev_name(rxe->ndev));
+	dev_info(&rxe->ib_dev.dev, "added %s\n", netdev_name(ndev));
+
+	dev_put(ndev);
 	return 0;
 }
 
@@ -1498,7 +1513,8 @@ static const struct ib_device_ops rxe_dev_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_mw, rxe_mw, ibmw),
 };
 
-int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
+int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name,
+						struct net_device *ndev)
 {
 	int err;
 	struct ib_device *dev = &rxe->ib_dev;
@@ -1510,13 +1526,13 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	dev->num_comp_vectors = num_possible_cpus();
 	dev->local_dma_lkey = 0;
 	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
-			    rxe->ndev->dev_addr);
+			    ndev->dev_addr);
 
 	dev->uverbs_cmd_mask |= BIT_ULL(IB_USER_VERBS_CMD_POST_SEND) |
 				BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ);
 
 	ib_set_device_ops(dev, &rxe_dev_ops);
-	err = ib_device_set_netdev(&rxe->ib_dev, rxe->ndev, 1);
+	err = ib_device_set_netdev(&rxe->ib_dev, ndev, 1);
 	if (err)
 		return err;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ccb9d19ffe8a..4242b24a47da 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -369,6 +369,7 @@ struct rxe_port {
 	u32			qp_gsi_index;
 };
 
+#define	RXE_PORT	1
 struct rxe_dev {
 	struct ib_device	ib_dev;
 	struct ib_device_attr	attr;
@@ -376,8 +377,6 @@ struct rxe_dev {
 	int			max_inline_data;
 	struct mutex	usdev_lock;
 
-	struct net_device	*ndev;
-
 	struct rxe_pool		uc_pool;
 	struct rxe_pool		pd_pool;
 	struct rxe_pool		ah_pool;
@@ -405,6 +404,11 @@ struct rxe_dev {
 	struct crypto_shash	*tfm;
 };
 
+static inline struct net_device *rxe_ib_device_get_netdev(struct ib_device *dev)
+{
+	return ib_device_get_netdev(dev, RXE_PORT);
+}
+
 static inline void rxe_counter_inc(struct rxe_dev *rxe, enum rxe_counters index)
 {
 	atomic64_inc(&rxe->stats_counters[index]);
@@ -470,6 +474,7 @@ static inline struct rxe_pd *rxe_mw_pd(struct rxe_mw *mw)
 	return to_rpd(mw->ibmw.pd);
 }
 
-int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
+int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name,
+						struct net_device *ndev);
 
 #endif /* RXE_VERBS_H */
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c7e9ec9e9a80..de1d88d41270 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4444,6 +4444,8 @@ struct net_device *ib_get_net_dev_by_params(struct ib_device *dev, u32 port,
 					    const struct sockaddr *addr);
 int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 			 unsigned int port);
+struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
+					u32 port);
 struct ib_wq *ib_create_wq(struct ib_pd *pd,
 			   struct ib_wq_init_attr *init_attr);
 int ib_destroy_wq_user(struct ib_wq *wq, struct ib_udata *udata);
-- 
2.43.7


