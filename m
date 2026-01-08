Return-Path: <linux-rdma+bounces-15366-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D7DD02251
	for <lists+linux-rdma@lfdr.de>; Thu, 08 Jan 2026 11:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00674301D652
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jan 2026 10:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE46223D7F5;
	Thu,  8 Jan 2026 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ezeb+pzh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F42392B91
	for <linux-rdma@vger.kernel.org>; Thu,  8 Jan 2026 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868022; cv=none; b=VLfl6hX5goOwuxGVGV95Qt+RLB0jnGnSxwoi05H9nGiO1tarexgEvXyKXTPxmtSME8mKJiLsqPvwo6WuHPODz2fifcYaRNC9xzc3T13om8BVd+Dgi+lhZgpeZQKepAJW0EKUPcT7BTe0s7gb2X7Tvw7YJKNWW6ETm+SOZSXVP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868022; c=relaxed/simple;
	bh=f31CHMhQWqNlQtDA++NF7UwXwugjtlGMeu/v6z0UZNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=leZkALcGC3RJ8NDRUS0QF7rcmOGFzEGbE3ddPreHpbJbjy6HznvDYy6pqIU17YsW7K/FHPQ7VLPOGEWySLUlO0NbxiSbFopyDnCe2EhODRHx6gf0FRaV0gBCdh68PMSNdcXcMYrDpbZENB1wJq2ZZi26MF1r4+nUFSCxKgR4TX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ezeb+pzh; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a110548cdeso24270075ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 08 Jan 2026 02:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868011; x=1768472811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRGzylfuTGBzLuULxrttYZ/W8538Ph4NnSuvcrcPCLg=;
        b=SHMMzVy+Aw3XGQnMNduvo/lwrCx7x+i6lv8W5N7TdhpE2E9oPwwP76L9hAzNyt06BW
         /R8bymv9r2iFzUoUKzyCzYmTLibYy2ggfNV5E2Nmh3oy26btvyrHzFT68Wa0PhQA0bC1
         /IxIybccrD5JT5kNr52UUlBsCcAHCcDShlU7+UYN65oyPBw6uWmqGBMEPdPF3BZZU5ll
         Jwz+/QQ/9sXkKsVA70M/ud2FT8pDRPdp+pWV0IC9UNBmd2tn2YhFHxdNA0d+soX7cbQU
         XaKp2FQ6Q5kJhAKoLJYhmi9HC5GWFzmFL/KF3MFJ7TJwsVhVPzrWuUpEevCriM8z6gix
         u/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6qMWphQSl/LB1gVtYb7kAIaVFjHOGxbJ+Up//1YuYBuyx9hpQgUrBtRmNvAaH/h/TnURBMcUdf73u@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkq97rDfnvt8aalyaw2z6GDxm3HXG9+xcFtdeixdL6DgZkYDkE
	PjQbb2LVF4cH4W6CubsFRpdEHhdorqE0rznFJMYG/WnYpA4EG3NySvviKFIjFhp9Xljqe94cA/5
	DC5oTM4r4zflMFp2uHRsVaOXZqQ9z7EgRsf2SmkW8eTWV7DYlQLxipW4q/xiAAn6OIdllYWqKXk
	yBHDem83qaWlEOchPs/I81hbfw0ngxn3USy4zmuQAdB/el5E2ZtnFQ365UaRLUSbR5Tm8YHY8Gn
	RiK4NtUWFGe0FT/UEtxE/U=
X-Gm-Gg: AY/fxX7T9pPNAh3E/eTlxWScU+ZXfaOmoysVf2Rk8yr8K4p/pjvV2x0PC8mLhawxAgK
	2EmSNkNcWi6iUlY/jNXrdX/WaZxq6rjy5fYbWN4ianyHoZf1irvMbaMU2JiIwlP965Vf+H3nZkM
	ROX40q6CzSuEB49HdX9PsnWGYfOQWO8jt3a9ZUj46SBUEhjdzCOjzYskFtYNKziwcQqg5WfINzz
	aDZN+fCwZsUapC/RPDb0psyr5uxHgLxm6OrAA7S07C0fSdZNHrlIpW/5tgVMj2rwC8XHJSkkGFx
	Iy52LPz8rDEMu88AeHbccozyE4Jft6737Bw+mlhm5ioojnnkp5rHVbOw6A9TrmHNRk2Ht9grd/k
	Hz/ck/oOd+ufDaNj3HfV1Jv8CB2jtBCtmlFaOLMZzlNAqESc8Br6YlhzWr/5ol0dmgp0H7bVI+s
	poZ7xT+HqtGbklLCwbYD/XRR4uckQU5+u7mpsn3vhjXSq4Bw==
X-Google-Smtp-Source: AGHT+IEHn/j01HnKl0HTa4m68Vyy+R5Xgwv895tRELuih7MIww0HCD9WEpQyepIf4PZsoTWaBP7WzoiuISDK
X-Received: by 2002:a17:903:94b:b0:295:9b3a:16b7 with SMTP id d9443c01a7336-2a3ee43853emr57399085ad.4.1767868010735;
        Thu, 08 Jan 2026 02:26:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3d10af2sm8883415ad.0.2026.01.08.02.26.50
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 02:26:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ffb40c0272so46998911cf.3
        for <linux-rdma@vger.kernel.org>; Thu, 08 Jan 2026 02:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767868009; x=1768472809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRGzylfuTGBzLuULxrttYZ/W8538Ph4NnSuvcrcPCLg=;
        b=ezeb+pzhg/TTaNLxg+wY5Xs6RFtTL4oZzEkjIbt4LJd3OKKUf6ECcJdY5+ni10+l5L
         jchx129eOp5S/EVe7LThZQp4AkgCUDFgWfKmcutvguECXarVYMXtq6XrRvaXZGww86ff
         Vdv63MdhyGuNtHLp4t8M9r7qFdD1iqD/IwxgU=
X-Forwarded-Encrypted: i=1; AJvYcCU/et3bu4bVu6PvpmkvfEF4JhKspodE1kAeYq3TU+yPFr3K3Aetn86Kt538xc7rL/5yJihVeyihzGu0@vger.kernel.org
X-Received: by 2002:a05:622a:14d3:b0:4f4:c0ac:6666 with SMTP id d75a77b69052e-4ffb4b592e4mr72784711cf.77.1767868009556;
        Thu, 08 Jan 2026 02:26:49 -0800 (PST)
X-Received: by 2002:a05:622a:14d3:b0:4f4:c0ac:6666 with SMTP id d75a77b69052e-4ffb4b592e4mr72784471cf.77.1767868009156;
        Thu, 08 Jan 2026 02:26:49 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e362fdsm45124721cf.21.2026.01.08.02.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:26:48 -0800 (PST)
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
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 2/2 v6.6] RDMA/rxe: Fix the failure of ibv_query_device() and ibv_query_device_ex() tests
Date: Thu,  8 Jan 2026 02:05:40 -0800
Message-Id: <20260108100540.672666-3-shivani.agarwal@broadcom.com>
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

[ Upstream commit 8ce2eb9dfac8743d1c423b86339336a5b6a6069e ]

In rdma-core, the following failures appear.

"
$ ./build/bin/run_tests.py -k device
ssssssss....FF........s
======================================================================
FAIL: test_query_device (tests.test_device.DeviceTest.test_query_device)
Test ibv_query_device()
----------------------------------------------------------------------
Traceback (most recent call last):
   File "/home/ubuntu/rdma-core/tests/test_device.py", line 63, in
   test_query_device
     self.verify_device_attr(attr, dev)
   File "/home/ubuntu/rdma-core/tests/test_device.py", line 200, in
   verify_device_attr
     assert attr.sys_image_guid != 0
            ^^^^^^^^^^^^^^^^^^^^^^^^
AssertionError

======================================================================
FAIL: test_query_device_ex (tests.test_device.DeviceTest.test_query_device_ex)
Test ibv_query_device_ex()
----------------------------------------------------------------------
Traceback (most recent call last):
   File "/home/ubuntu/rdma-core/tests/test_device.py", line 222, in
   test_query_device_ex
     self.verify_device_attr(attr_ex.orig_attr, dev)
   File "/home/ubuntu/rdma-core/tests/test_device.py", line 200, in
   verify_device_attr
     assert attr.sys_image_guid != 0
            ^^^^^^^^^^^^^^^^^^^^^^^^
AssertionError
"

The root cause is: before a net device is set with rxe, this net device
is used to generate a sys_image_guid.

Fixes: 2ac5415022d1 ("RDMA/rxe: Remove the direct link to net_device")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Link: https://patch.msgid.link/20250302215444.3742072-1-yanjun.zhu@linux.dev
Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Tested-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 6.6.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/infiniband/sw/rxe/rxe.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 1fb4fa4514bf..50c583a55464 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -38,10 +38,8 @@ void rxe_dealloc(struct ib_device *ib_dev)
 }
 
 /* initialize rxe device parameters */
-static void rxe_init_device_param(struct rxe_dev *rxe)
+static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
 {
-	struct net_device *ndev;
-
 	rxe->max_inline_data			= RXE_MAX_INLINE_DATA;
 
 	rxe->attr.vendor_id			= RXE_VENDOR_ID;
@@ -74,15 +72,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_pkeys			= RXE_MAX_PKEYS;
 	rxe->attr.local_ca_ack_delay		= RXE_LOCAL_CA_ACK_DELAY;
 
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
-	if (!ndev)
-		return;
-
 	addrconf_addr_eui48((unsigned char *)&rxe->attr.sys_image_guid,
 			ndev->dev_addr);
 
-	dev_put(ndev);
-
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
 }
 
@@ -115,18 +107,13 @@ static void rxe_init_port_param(struct rxe_port *port)
 /* initialize port state, note IB convention that HCA ports are always
  * numbered from 1
  */
-static void rxe_init_ports(struct rxe_dev *rxe)
+static void rxe_init_ports(struct rxe_dev *rxe, struct net_device *ndev)
 {
 	struct rxe_port *port = &rxe->port;
-	struct net_device *ndev;
 
 	rxe_init_port_param(port);
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
-	if (!ndev)
-		return;
 	addrconf_addr_eui48((unsigned char *)&port->port_guid,
 			    ndev->dev_addr);
-	dev_put(ndev);
 	spin_lock_init(&port->port_lock);
 }
 
@@ -144,12 +131,12 @@ static void rxe_init_pools(struct rxe_dev *rxe)
 }
 
 /* initialize rxe device state */
-static void rxe_init(struct rxe_dev *rxe)
+static void rxe_init(struct rxe_dev *rxe, struct net_device *ndev)
 {
 	/* init default device parameters */
-	rxe_init_device_param(rxe);
+	rxe_init_device_param(rxe, ndev);
 
-	rxe_init_ports(rxe);
+	rxe_init_ports(rxe, ndev);
 	rxe_init_pools(rxe);
 
 	/* init pending mmap list */
@@ -186,7 +173,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name,
 			struct net_device *ndev)
 {
-	rxe_init(rxe);
+	rxe_init(rxe, ndev);
 	rxe_set_mtu(rxe, mtu);
 
 	return rxe_register_device(rxe, ibdev_name, ndev);
-- 
2.43.7


