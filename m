Return-Path: <linux-rdma+bounces-15362-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27403D014DC
	for <lists+linux-rdma@lfdr.de>; Thu, 08 Jan 2026 07:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 951A73003856
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jan 2026 06:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB51F2FFDE2;
	Thu,  8 Jan 2026 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AcNgBLns"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251B322097
	for <linux-rdma@vger.kernel.org>; Thu,  8 Jan 2026 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767855242; cv=none; b=JWYUpzRSLaU+YkSjgv2SQ6fv38dQcPURFnYtmShvoMU7jDAb8xto23AxEc/ppSfa55TK8WngZRuPw9TZLA0L3wxbkIb4AdZX+Xl4y8C3P5YV2MrjArw7y/1zBqs4yKd48cfGI37fO7KynHk+Fp3MhSFzCGv5SUH4hLQmxGFCLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767855242; c=relaxed/simple;
	bh=QTCHsVNO16iQZrixVaQuQTrLrmA3Roxcubh4/31nZXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qpQjzpHz/z8s1XlbGoFDyjUzToCH0fcldr6YSkFtP7/dHm8zPXs1TRaoiaFEtBMFqqKvQxeA4T1p6yIawCIBOnu41gxiKFZpZFyAPJeuWtLUKI4yqO88j5lj2z9PctWU1Ta9YFRpPQJ9MO/8/S97QqQVXbwMK3kcqiGUP7lHpnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AcNgBLns; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a0d6f647e2so32119225ad.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 22:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767855240; x=1768460040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzc6jMotlPlOBqmj2BzruiYM6jJIxp4NUV9AgKZ5VJ8=;
        b=EPqlz8PStomC0cB7+WbzcCRpyJ+5Gq3sgHROOvzngmwJ2sjMSr+wvdv/x0kxToiixx
         ZpV5umWjJ2mXB6ITA2dbqVaRlf3O12JcHTa1E/kVHWuIyfz2STuaEC4UsaRUWS8tiEUB
         eUOW5RGM6lQLikUKMx1Q/DCO2IrXSvXzZkszR2ziiyVwQcJUNtSF+bQxM+9Ahs/9RVyG
         vVbD5XO6c1IpJ0X3rOnAjs2Se85uGQzMOeBxlvGi7GBpaO16b7fFSj36jjM6Ui+m3hej
         q9gImniMVBLvj8xjLYXu5RtZslK+gd5k8phrYkpFR9tqgP9oYZToLrNcZbA96+i7sxVL
         A1BQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+sugceau82q/ETwVMCa0afq2etaqRM06rG4dNNxzrvyxXsmcM8/LQDG+4lR8Em2yQzd4kxsMOnxR9@vger.kernel.org
X-Gm-Message-State: AOJu0YzVusgsF0XgQdpYS5Cp9h+bAmk4ORRCh1M3ZFJ0q1c0peiqc3lL
	hFMo3k3N2C5juFsUaGx3KDcBRHi1rhLUzKAixO1TMdu1SqkFFT4dNJbXa12nggOaSbsT8951C2h
	k1r2oHyOceCcqiBNBuPvIbWQPiKBhyiQloTYSeuI7DUxFeknuMxrY4xyrTjEviItSXdGa7u/fwv
	DCmqOFct2qT4Blf+R9DA4E3MsVt8/Cb327nfxB6TAEsuRX6y/BAgJ9ENupSwqPOSlh6ESZ/yxcK
	mL/D0UxusvCz5opw3KDATE=
X-Gm-Gg: AY/fxX5xObWeJ5yvCRYc+zSoMSsaggd4QLKcQjYU/zI8FHqyJeCYWl/XGxhGVhdZk5P
	NPwWXpCsdrBJ++V22TZwPeJV60bI/07oGbiesHNuyrLdZDG4lH8eE2YQnjXtVft0lJlj2klWRnP
	+oIx7356IebSRoYyRhMlGUL8v2OrB1fWrr5QhVAr/ofjTinW+tl2kFbIZiKAv5GwQe+gOVcxI/R
	cIpz0HHKF5JAggZDAH1sTZVGJlBq5tNM4W3JrzNHCD97Ro/R7jlvLwXO6D9ScSREUQpaQ64g7Ar
	Acd6iD0cGVlxB+N9HT0JTSglKB/u5hmqQiTomAivd5gRuWH1g5AQt3UmDBp6QQP8hKdy4q/uwkB
	FpJilpFqXTZ5x6hG81m/owD702+wZ4Aq9GvT07t9YcdJadAEcmkJWudrqXstwLKtDgwmtchCWtV
	4O/bVqXQ5U/HQMCPS6/S8tESuonadO4Itzu7ujqZ4baUliBrFmv70=
X-Google-Smtp-Source: AGHT+IFK2gHSqEJABJ3aNgCrVNumlMbeSHj8bQUZDY6ok/3lYEHwNNqzJ7S9YedxTp/Hkzb05M5C8ddRKEqk
X-Received: by 2002:a17:903:19e5:b0:290:c516:8c53 with SMTP id d9443c01a7336-2a3ee499fcemr55405165ad.40.1767855240317;
        Wed, 07 Jan 2026 22:54:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3c3bd5bsm8088405ad.13.2026.01.07.22.53.59
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2026 22:54:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1219f27037fso10711854c88.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 22:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767855239; x=1768460039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yzc6jMotlPlOBqmj2BzruiYM6jJIxp4NUV9AgKZ5VJ8=;
        b=AcNgBLnsXF8blkFI+S3hVadeuJ4TOCpqx71LQuYX4o9n/O/l15uwb3GYdRDfVic1o9
         7Y27q6BpYx9+T2RfDh+MLn15g1/z56sVk1SX0nQEF2yf7vYaxQ2sMJ4TJYnJILS1AVAE
         DIJnIBwsAvLtcBqskeMKY9NLMiQDd4wWLI48c=
X-Forwarded-Encrypted: i=1; AJvYcCUZUyxGDJV+8wIUjgRJ+jQ7AEsP9XbENSPo2CHktkGOKSYuq/TN73pZxFDWJa87tri7AxYJuo93Ncj8@vger.kernel.org
X-Received: by 2002:a05:7022:79b:b0:11d:f44c:afbc with SMTP id a92af1059eb24-121f8b5fb5cmr4806085c88.37.1767855238723;
        Wed, 07 Jan 2026 22:53:58 -0800 (PST)
X-Received: by 2002:a05:7022:79b:b0:11d:f44c:afbc with SMTP id a92af1059eb24-121f8b5fb5cmr4806050c88.37.1767855238207;
        Wed, 07 Jan 2026 22:53:58 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm12592287c88.12.2026.01.07.22.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 22:53:57 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mbloch@nvidia.com,
	parav@nvidia.com,
	roman.gushchin@linux.dev,
	markzhang@nvidia.com,
	zhao.xichao@vivo.com,
	wangliang74@huawei.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	jackm@dev.mellanox.co.il,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	syzbot+e2ce9e275ecc70a30b72@syzkaller.appspotmail.com,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10-v6.6] RDMA/core: Fix "KASAN: slab-use-after-free Read in ib_register_device" problem
Date: Wed,  7 Jan 2026 22:33:00 -0800
Message-Id: <20260108063300.670981-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Zhu Yanjun <yanjun.zhu@linux.dev>

[ Upstream commit d0706bfd3ee40923c001c6827b786a309e2a8713 ]

Call Trace:

 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 strlen+0x93/0xa0 lib/string.c:420
 __fortify_strlen include/linux/fortify-string.h:268 [inline]
 get_kobj_path_length lib/kobject.c:118 [inline]
 kobject_get_path+0x3f/0x2a0 lib/kobject.c:158
 kobject_uevent_env+0x289/0x1870 lib/kobject_uevent.c:545
 ib_register_device drivers/infiniband/core/device.c:1472 [inline]
 ib_register_device+0x8cf/0xe00 drivers/infiniband/core/device.c:1393
 rxe_register_device+0x275/0x320 drivers/infiniband/sw/rxe/rxe_verbs.c:1552
 rxe_net_add+0x8e/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:550
 rxe_newlink+0x70/0x190 drivers/infiniband/sw/rxe/rxe.c:225
 nldev_newlink+0x3a3/0x680 drivers/infiniband/core/nldev.c:1796
 rdma_nl_rcv_msg+0x387/0x6e0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2e5/0x450
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

This problem is similar to the problem that the
commit 1d6a9e7449e2 ("RDMA/core: Fix use-after-free when rename device name")
fixes.

The root cause is: the function ib_device_rename() renames the name with
lock. But in the function kobject_uevent(), this name is accessed without
lock protection at the same time.

The solution is to add the lock protection when this name is accessed in
the function kobject_uevent().

Fixes: 779e0bf47632 ("RDMA/core: Do not indicate device ready when device enablement fails")
Link: https://patch.msgid.link/r/20250506151008.75701-1-yanjun.zhu@linux.dev
Reported-by: syzbot+e2ce9e275ecc70a30b72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2ce9e275ecc70a30b72
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[ Ajay: Modified to apply on v5.10.y-v6.6.y
        ib_device_notify_register() not present in v5.10.y-v6.6.y,
        so directly added lock for kobject_uevent() ]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/infiniband/core/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 26f1d2f29..ea9b48108 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1396,8 +1396,13 @@ int ib_register_device(struct ib_device *device, const char *name,
 		return ret;
 	}
 	dev_set_uevent_suppress(&device->dev, false);
+
+	down_read(&devices_rwsem);
+
 	/* Mark for userspace that device is ready */
 	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
+
+	up_read(&devices_rwsem);
 	ib_device_put(device);
 
 	return 0;
-- 
2.40.4


