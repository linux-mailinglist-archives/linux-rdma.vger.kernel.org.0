Return-Path: <linux-rdma+bounces-7198-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BE3A19D3D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 04:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01EFA188DB00
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 03:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FE454918;
	Thu, 23 Jan 2025 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZTuM0tF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EB3335C0;
	Thu, 23 Jan 2025 03:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737602594; cv=none; b=b0j8iKHoU8NwuH2PN5g7+Ro20huZ2Bs1p58+15psm2aEG/UQ/YmH9dWL2DMNr5zQK6AQSDgCth4zjEjcsa3GZpri9MgoxlkO80Nng0WHVTaM8rYQtW9TVBDv7czI6BvtA5gEl7meSIHPFc69DGKgD7msNnZnUp7VZ6N1afS9kR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737602594; c=relaxed/simple;
	bh=esc9p8uRAAcKQAeYH0qKOI77SqoRSioVkN8/jCoFF2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBEfSvmtcFYJaQLS3igFft5KFnrw2JhzXdt4WvmiMLRyoYjrn4+VoQr2nMTy8yho4NDk3aQOM3nKdqPmVPAuR+Y8ppp5DlR0aq+Jfer07RlM1lCENOqYesOpVH79CT4ZB+FVUmRVTk6dDUpDC9B7ot9O+UPUQea6wX8pKSzJ3FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZTuM0tF; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso709351a91.1;
        Wed, 22 Jan 2025 19:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737602592; x=1738207392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S2lwk6lg/hcsK3tR10SuqMwZBkERsQ/DxupetFfAsnI=;
        b=GZTuM0tFtJ58OwW+fYHHGrtSkmGqvbBGmwd239rkuRYS1FrH2ZLR9bV55j8OzSoP8p
         Aoha8beSsNxW2R7ILa3QOVzWoFOqfUZB/uaHKbQcPrErnVfelbyz2ZucebNyZAnQrmw/
         tX/9AcDRbDgwBzG3TbsqNEoAIU9zozMisgl07tjGpYb7LS87qi/UkLYGnlvpBUrJvvGT
         m9iOqJB/uJazMK2yEnOLHWIYZ7OtvODk9ten1nLSRVMz99gmefG0Q/LReXXaUBVUAlpD
         4Rtih93Ya7kgSRzZxHGcBUPg3mEJNh6sVLAYR2JnrhDi7fasYTSWJ28hKiLugMkN+5VK
         XhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737602592; x=1738207392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2lwk6lg/hcsK3tR10SuqMwZBkERsQ/DxupetFfAsnI=;
        b=kTEA8USAAbH/1dNvn6+g/H3SPDD2Hnso0L3QEzdZ9p0cGxxbKqMdxpHAm32j9N6F+R
         nTATHS66Bakdg/hcQi1stzbuzr+CAUgJlMAwSdRNRws4q50Wht4PPEZgrTfnQM2eWz6/
         vtCJxy2A6n+V7gjFh7zBbRaUYFamzgxI7GgO7uRnMdlvCb992cnzAba8vwMYP7QQLhN/
         oZOR989d/syLJgZ2BGaA9+Edjn8NBfgV/naAtYNMpnA7gJrWg7ihPi1g3+x9jR1zmSNu
         T2UempBzpLGnPQRiT9SIxqldK9VvRpXvsWHdK9LmkvjyoCfStGMemAS+H3IE7zud3iW4
         bRLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuQXYnF9GFsktMVLnVuIx7/LJcqmZLQ5fHSukOFuOQoWybs2EjfiGmCPON4M+dQpZLrlT44K2X@vger.kernel.org, AJvYcCWQjptA6KBu5J9eKryr9S5PFPEUDRtituVnpMs7HmHHoAnsOZUKoCdDJm6fFwerKAo5otx8wlxbCdglIw==@vger.kernel.org, AJvYcCWXUUbww8ZYb8RLvsO6Tyl5iggsyYXvRliSi6R6bcSKnXuTist3U9cLUMUByOXPEWwZZ8f4JlSUCN+nj44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB6SU3oLOWs9mXu/MwOU+tpK2EglgkyjDDjjCLVZ1lvfQJom+A
	+R4r2UxAI89KLtd+5U5jKqN9MR8LmzmcSWY4pHOZws7FRZiov/lYpFwDNUJx
X-Gm-Gg: ASbGncuGgdFF3U0mShox/u2HcTgUePaIsy4ULp+0aWKKQLnOa2jfj250tRDveT6nlg5
	3Pdq7Ju+TfE061JEz73Ss7hRWIuS9Y9Oxftzkw+tvGU3rDc22vNIumH2f8tRxOJuR4cq17OhfaC
	d+eFLEDOIvNMfP4aucD4Xv8utrKSkrncn8OetlJ2V3ILldFSC4tv32EjV/OMpw1sCv05kgLhOGS
	zVFLoB6b4UieChRHi8iX3McCcwTG+bj99kymtZk/vKiuvu4+9d77FpPGTrHVyT4fxCQMWBwE5P8
	Z+hLLasRZTPf+GfiSLbKGTvkDiL8jQ==
X-Google-Smtp-Source: AGHT+IG/nhSi0IwQlKVL7jrc+VPm3/7CeXeXjuo1Bqdbblsv39vZjCseJch/hzD3/cpysAUqvrtUGA==
X-Received: by 2002:a05:6a00:190c:b0:729:1b8f:9645 with SMTP id d2e1a72fcca58-72dafbd02ecmr40258688b3a.24.1737602591672;
        Wed, 22 Jan 2025 19:23:11 -0800 (PST)
Received: from jren-d3.localdomain ([221.222.62.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba48eb8sm12208725b3a.136.2025.01.22.19.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 19:23:11 -0800 (PST)
From: Imkanmod Khan <imkanmodkhan@gmail.com>
To: stable@vger.kernel.org
Cc: cratiu@nvidia.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	roid@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Imkanmod Khan <imkanmodkhan@gmail.com>
Subject: [PATCH 6.6.y] net/mlx5e: Don't call cleanup on profile rollback failure
Date: Thu, 23 Jan 2025 11:22:53 +0800
Message-ID: <20250123032254.34250-1-imkanmodkhan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cosmin Ratiu <cratiu@nvidia.com>

[ Upstream commit 4dbc1d1a9f39c3711ad2a40addca04d07d9ab5d0 ]

When profile rollback fails in mlx5e_netdev_change_profile, the netdev
profile var is left set to NULL. Avoid a crash when unloading the driver
by not calling profile->cleanup in such a case.

This was encountered while testing, with the original trigger that
the wq rescuer thread creation got interrupted (presumably due to
Ctrl+C-ing modprobe), which gets converted to ENOMEM (-12) by
mlx5e_priv_init, the profile rollback also fails for the same reason
(signal still active) so the profile is left as NULL, leading to a crash
later in _mlx5e_remove.

 [  732.473932] mlx5_core 0000:08:00.1: E-Switch: Unload vfs: mode(OFFLOADS), nvfs(2), necvfs(0), active vports(2)
 [  734.525513] workqueue: Failed to create a rescuer kthread for wq "mlx5e": -EINTR
 [  734.557372] mlx5_core 0000:08:00.1: mlx5e_netdev_init_profile:6235:(pid 6086): mlx5e_priv_init failed, err=-12
 [  734.559187] mlx5_core 0000:08:00.1 eth3: mlx5e_netdev_change_profile: new profile init failed, -12
 [  734.560153] workqueue: Failed to create a rescuer kthread for wq "mlx5e": -EINTR
 [  734.589378] mlx5_core 0000:08:00.1: mlx5e_netdev_init_profile:6235:(pid 6086): mlx5e_priv_init failed, err=-12
 [  734.591136] mlx5_core 0000:08:00.1 eth3: mlx5e_netdev_change_profile: failed to rollback to orig profile, -12
 [  745.537492] BUG: kernel NULL pointer dereference, address: 0000000000000008
 [  745.538222] #PF: supervisor read access in kernel mode
<snipped>
 [  745.551290] Call Trace:
 [  745.551590]  <TASK>
 [  745.551866]  ? __die+0x20/0x60
 [  745.552218]  ? page_fault_oops+0x150/0x400
 [  745.555307]  ? exc_page_fault+0x79/0x240
 [  745.555729]  ? asm_exc_page_fault+0x22/0x30
 [  745.556166]  ? mlx5e_remove+0x6b/0xb0 [mlx5_core]
 [  745.556698]  auxiliary_bus_remove+0x18/0x30
 [  745.557134]  device_release_driver_internal+0x1df/0x240
 [  745.557654]  bus_remove_device+0xd7/0x140
 [  745.558075]  device_del+0x15b/0x3c0
 [  745.558456]  mlx5_rescan_drivers_locked.part.0+0xb1/0x2f0 [mlx5_core]
 [  745.559112]  mlx5_unregister_device+0x34/0x50 [mlx5_core]
 [  745.559686]  mlx5_uninit_one+0x46/0xf0 [mlx5_core]
 [  745.560203]  remove_one+0x4e/0xd0 [mlx5_core]
 [  745.560694]  pci_device_remove+0x39/0xa0
 [  745.561112]  device_release_driver_internal+0x1df/0x240
 [  745.561631]  driver_detach+0x47/0x90
 [  745.562022]  bus_remove_driver+0x84/0x100
 [  745.562444]  pci_unregister_driver+0x3b/0x90
 [  745.562890]  mlx5_cleanup+0xc/0x1b [mlx5_core]
 [  745.563415]  __x64_sys_delete_module+0x14d/0x2f0
 [  745.563886]  ? kmem_cache_free+0x1b0/0x460
 [  745.564313]  ? lockdep_hardirqs_on_prepare+0xe2/0x190
 [  745.564825]  do_syscall_64+0x6d/0x140
 [  745.565223]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 [  745.565725] RIP: 0033:0x7f1579b1288b

Fixes: 3ef14e463f6e ("net/mlx5e: Separate between netdev objects and mlx5e profiles initialization")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Imkanmod Khan <imkanmodkhan@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 6e431f587c23..b34f57ab9755 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6110,7 +6110,9 @@ static void mlx5e_remove(struct auxiliary_device *adev)
 	mlx5e_dcbnl_delete_app(priv);
 	unregister_netdev(priv->netdev);
 	mlx5e_suspend(adev, state);
-	priv->profile->cleanup(priv);
+	/* Avoid cleanup if profile rollback failed. */
+	if (priv->profile)
+		priv->profile->cleanup(priv);
 	mlx5e_destroy_netdev(priv);
 	mlx5e_devlink_port_unregister(mlx5e_dev);
 	mlx5e_destroy_devlink(mlx5e_dev);
-- 
2.25.1


