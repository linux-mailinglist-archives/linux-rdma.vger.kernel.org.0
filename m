Return-Path: <linux-rdma+bounces-13806-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8006ABC97EE
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Oct 2025 16:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341B03A9D22
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Oct 2025 14:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4879D2EA48E;
	Thu,  9 Oct 2025 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3d9T3kX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928912E8DF5
	for <linux-rdma@vger.kernel.org>; Thu,  9 Oct 2025 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019990; cv=none; b=jx40qNt+vDi06bZhkbo87/7p2qoCiECEwlxzmUjwlYjDzFkaiIspUBnrsLrL5nZyfp3ZeTdDLgVVTRMRit9+e2T+D4clJwhWUTJO63X+wZRu9ItWpJkxcssgQCsZf7zuccnwgJvKgYooy8/7buLSKgs6655rrMNVfik8ep8M4Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019990; c=relaxed/simple;
	bh=1EQ+k0Is4SQUV7DbcKmHd4Ar4CbmEbpFSYVPeTtkCyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=laIzmBpH/wAd0y+NBJQ/vhcYo6nKtAdYNQdWEizr147yWloudgx+VIQV90iE7yZJ7w42Aqsb67s3Xsyv2b4pZ1QLSaj0PrVrHjyVK3pPpTKIj92l+z3+DwLebkh83//U0XxNaJHD3228QJpYiurvGaQzjQLPZgRU2+504B1ttb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3d9T3kX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2698d47e6e7so1792565ad.2
        for <linux-rdma@vger.kernel.org>; Thu, 09 Oct 2025 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760019988; x=1760624788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N9xayOLtGYqN04REst1iXQRYejSaY8hLOB6Ydu+rwqU=;
        b=Q3d9T3kXQNzQ78XjVCbSOpVSjzOGV5JzmkS0NqGXu9sCpqOdsg60xf1MI7+cSOdeNf
         W5uIq2mTEtWI1mc2ZejM9IajX2MQ1z4FR4ARYJc8piJy0NDt9Hs4toRfvKs46xS/rhXJ
         1LJPmYIqwmRodgM5KcE0Wrt4u29tL8dvz9H6PwD8mMaFRq4AcCE4RysFCu79mlQs1X/i
         6CCVnwC3Sv3mi+/2UNiFikb/Wg9lMaOHs3zQ43nOrVgtZmEddQ+XJKnXjmhMdo8z+Sbs
         EKOgrjpAiVBBbguVgaYr1ikkmJGBrwH8/LNoeRe7g13fnWGLcFBQXowTqofINx54WCUF
         OULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760019988; x=1760624788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9xayOLtGYqN04REst1iXQRYejSaY8hLOB6Ydu+rwqU=;
        b=t/JQZUL0S5TxWwIgopICvx5PALdz58pXXLLHpw+q6GMMIoxvIZgTsbxPlcnDXRDe78
         LljNV0+Z76NEa+oDRIUz4iGhVpU4E8VxjtIrkX+HLM+slBI4XZHauYxXHu6o8cOWa9D6
         ufLDjOCJOHGBIMihRBgWNPjDHLFrFgY/DpRXS9ebDNj0erRcea67WvY4x/uqYexzrl0i
         sAN0GMF7js9B0c26cgJDfODdM9vRJs+vYJUt0ReOicZesbpPDElb13WjBj65gcmvk5Md
         n8kyoNijcQUFz+dcUioRmeRH8EkqoAnDJqAI9j9RLSqpZDpFMCCChbAMUePzLtz52Dq8
         AhYA==
X-Forwarded-Encrypted: i=1; AJvYcCUrrZQFlaCMYqEdUp5kK5RoDVPsTJI87uOJf5ySOU7Y8aPm6EotIp+CVxRDQ+K1lIoesR3Dl77GBBFA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3hgHmgh0q149Hs7IYCsN/WyZB81SKe8Uqwd/x5CAh3MxzGAzn
	rx5EBwaSgdZ7UYsMu2ZcIxbQn7ob0qLRgsWtZ3BGyZsbV8IacUhCrCGZxwOLNiP+
X-Gm-Gg: ASbGncvNv1WobYEaunsTzdLsvnzFfjyWGUJxz95tTS7oDMVkVmRKYdWdrV9bnL0tq54
	QU4ABWLlY6TryjuZjx01PHe3iFQpg77VazGXgtPVAk9t0HsvK4xBzp7QmtCF+EgX5hrjo3hUGZ+
	5RGQ5s604Y2oAWR9/xOki3NNlAkpmqkTkTDe5YoZG5o13mOmJj86oqpcT8Ol7/3Yvr/4oWjLsQZ
	zNvgiouXmUIrYbeihZ784JWsriYd/tsqPCAPMfHVR8gI7Aa3AphNhZ4VIT1RNTWb6IuGa5yAtGw
	qZznhcsqbgbHVy7D/0qEKeao5WkZADalgbiXbSj3xcgWuGL46tut0Bh7RSQzt4V7Qv1cHRM7OrJ
	KpnLPG3Dc3vunrkgHDYVgKhcqV2Qsl2CWuFLX4FrUdow4K0yo1Q==
X-Google-Smtp-Source: AGHT+IFC5nApN7xasVLH8PyOEJqPD//4NCRVkoc4O2aKXaxWT6kjnC7X1qb/Is5ZtMhNRkz2ZV5PEQ==
X-Received: by 2002:a17:903:120a:b0:261:500a:5742 with SMTP id d9443c01a7336-290274555bcmr47539605ad.10.1760019987801;
        Thu, 09 Oct 2025 07:26:27 -0700 (PDT)
Received: from mi.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f9d177sm30487855ad.123.2025.10.09.07.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:26:27 -0700 (PDT)
From: Jian Wen <wenjianhn@gmail.com>
X-Google-Original-From: Jian Wen <wenjian1@xiaomi.com>
To: jgg@nvidia.com,
	leonro@nvidia.com
Cc: Jian Wen <wenjian1@xiaomi.com>,
	linux-rdma@vger.kernel.org,
	wenjianhn@gmail.com
Subject: [PATCH] RDMA/mlx5: Use mlx5_cmd_is_down to detect PCIe Surprise Link Down
Date: Thu,  9 Oct 2025 22:23:20 +0800
Message-ID: <20251009142326.3794769-1-wenjian1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx5r_umr_post_send_wait() will get stuck when the pcie link is down
as the call trace[1].

When pciehp detects the link is down it calls
pci_dev_set_disconnected() before mlx5_ib_dereg_mr(). Thus we can use
mlx5_cmd_is_down() to detect PCIe Surprise Link Down in
mlx5r_umr_post_send().

[1]
pcieport 0000:b9:01.0: pciehp: Slot(2-4): Link Down
pcieport 0000:b9:01.0: pciehp: Slot(2-4): Card not present
mlx5_core 0000:bb:00.0: E-Switch: Unload vfs: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
mlx5_core 0000:bb:00.0: E-Switch: Disable: mode(LEGACY), nvfs(0), necvfs(0), active vports(0)
mlx5_core 0000:bb:00.0: poll_health:1083:(pid 0): Fatal error 1 detected
mlx5_core 0000:bb:00.0: print_health_info:491:(pid 0): PCI slot is unavailable
INFO: task irq/105-pciehp:1246 blocked for more than 122 seconds.
      Tainted: G           OE      6.8.0-54-generic #56-Ubuntu
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:irq/105-pciehp  state:D stack:0     pid:1246  tgid:1246  ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 __schedule+0x27c/0x6b0
 schedule+0x33/0x110
 schedule_timeout+0x157/0x170
 wait_for_completion+0x88/0x150
 mlx5r_umr_post_send_wait+0x15f/0x2d0 [mlx5_ib]
 ? __pfx_mlx5r_umr_done+0x10/0x10 [mlx5_ib]
 mlx5r_umr_revoke_mr+0x98/0xc0 [mlx5_ib]
 __mlx5_ib_dereg_mr+0x24a/0x740 [mlx5_ib]
 ? wait_for_completion+0x114/0x150
 mlx5_ib_dereg_mr+0x21/0xc0 [mlx5_ib]
 ? rdma_restrack_del+0x59/0x160 [ib_core]
 ib_dereg_mr_user+0x41/0xc0 [ib_core]
 uverbs_free_mr+0x15/0x30 [ib_uverbs]
 destroy_hw_idr_uobject+0x21/0x60 [ib_uverbs]
 uverbs_destroy_uobject+0x38/0x1d0 [ib_uverbs]
 __uverbs_cleanup_ufile+0xcf/0x150 [ib_uverbs]
 uverbs_destroy_ufile_hw+0x3f/0x100 [ib_uverbs]
 ib_uverbs_remove_one+0x147/0x1c0 [ib_uverbs]
 remove_client_context+0x95/0x100 [ib_core]
 disable_device+0x8f/0x180 [ib_core]
 __ib_unregister_device+0x108/0x170 [ib_core]
 ? __pfx_mlx5_ib_stage_ib_reg_cleanup+0x10/0x10 [mlx5_ib]
 ib_unreister_device+0x26/0x40 [ib_core]
 mlx5_ib_stage_ib_reg_cleanup+0xe/0x20 [mlx5_ib]
 mlx5r_remove+0x52/0xb0 [mlx5_ib]
 auxiliary_bus_remove+0x1c/0x40
 device_remove+0x40/0x80
 device_release_driver_internal+0x20b/0x270
 device_release_driver+0x12/0x20
 bus_remove_device+0xcb/0x140
 device_del+0x161/0x3e0
 ? is_ib_enabled+0x52/0x90 [mlx5_core]
 mlx5_rescan_drivers_locked+0xfe/0x350 [mlx5_core]
 mlx5_unregister_device+0x38/0x60 [mlx5_core]
 mlx5_uninit_one+0x39/0x160 [mlx5_core]
 remove_one+0x55/0x100 [mlx5_core]
 pci_device_remove+0x3e/0xb0
 device_remove+0x40/0x80
 device_release_driver_internal+0x20b/0x270
 device_release_driver+0x12/0x20
 pci_stop_bus_device+0x7a/0xb0
 pci_stop_and_remove_bus_device+0x12/0x30
 pciehp_unconfigure_device+0x98/0x170
 pciehp_disable_slot+0x69/0x130
 pciehp_handle_presence_or_link_change+0x71/0x220
 pciehp_ist+0x22e/0x260
 ? __pfx_irq_thread_fn+0x10/0x10
 irq_thread_fn+0x21/0x70
 irq_thread+0xf8/0x1c0
 ? __pfx_irq_thread_dtor+0x10/0x10
 ? __pfx_irq_thread+0x10/0x10
 kthread+0xef/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x44/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

Fixes: 6f0689fdf19e ("RDMA/mlx5: Introduce mlx5_umr_post_send_wait()")
Signed-off-by: Jian Wen <wenjian1@xiaomi.com>
---
 drivers/infiniband/hw/mlx5/umr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 4e562e0dd9e1..f3700ef6ea07 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -254,7 +254,7 @@ static int mlx5r_umr_post_send(struct ib_qp *ibqp, u32 mkey, struct ib_cqe *cqe,
 	unsigned int idx;
 	int size, err;
 
-	if (unlikely(mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR))
+	if (unlikely(mlx5_cmd_is_down(mdev)))
 		return -EIO;
 
 	spin_lock_irqsave(&qp->sq.lock, flags);
-- 
2.43.0


