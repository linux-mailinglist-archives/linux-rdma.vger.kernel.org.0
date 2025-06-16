Return-Path: <linux-rdma+bounces-11338-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82953ADAD9F
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 12:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3533ACBE0
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 10:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D312980BF;
	Mon, 16 Jun 2025 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcI1/e5H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFD6274FE7
	for <linux-rdma@vger.kernel.org>; Mon, 16 Jun 2025 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070568; cv=none; b=SIG9bPc3PLTkT4UfpZ8o/QrdVtk6FbQa2lmAUpwYbi68+tNy+LyRD1R2IOnBXDWnCugcszS6Iz518zUnZ4rvk5nVmdesnh+3GWN+PjULT94gK+bHaOhuNnW7IE0yM8bpe7qYbDtI3oT8cWBbjO3eSrx19hAlcr8h5OJzotZA9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070568; c=relaxed/simple;
	bh=YuDOGDUvd+W0LY/ZPtRpn+4ER7OhsjN5aT7/Y5ZEuoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MblZi7UBTVmt82KbVeNJM5By+QTANYg/M8nQTQ0K1X57anPH3e2l19P5ZBZMzSGUCjW+lCbHt3BMPmFEUvDLLgVlCVde05EdCrELaFwP9ekHPuxqDvV6zPlAptbn1XQ18kY7ioKJ0YtESxRZ8vo5JlbhOKgPbIDdOymp14ptM8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcI1/e5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9148C4CEEA;
	Mon, 16 Jun 2025 10:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750070568;
	bh=YuDOGDUvd+W0LY/ZPtRpn+4ER7OhsjN5aT7/Y5ZEuoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YcI1/e5Hmt9bvW8VBlYK+jTUsqsMO+f6vvCQKkTYUivE5yMsvosfFg/ObtBtI8pto
	 9yxQsUFzW5HZnrqBW7chV4bRPNUwCKhYz2OyaE2XYIFPrNEQfnV4iujj9hvn4i8uFd
	 pCsaQPZcqja63M16sLtVxudOC3R1TX89gWjwRVs5mg1e5MNdTt9cFM1oXDzUzHKAvW
	 SVygwzZJgZZZWrqYfalcpnuXzaPrt7b+pILfbbSUghqCLeKjejNwv3ftC5jrXIfU12
	 JInwwyTWEMrT7qP6tLd2487oA50W/tBu61VO49wepXxDwP7ZXxFofpG6fzuLPwfqG5
	 +dfswjA9tOU1Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Support driver APIs pre_destroy_cq and post_destroy_cq
Date: Mon, 16 Jun 2025 13:42:38 +0300
Message-ID: <aaf0072f350d1c7e8731f43b79e11a560bafb9e0.1750070205.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <b5f7ae3d75f44a3e15ff3f4eb2bbdea13e06b97f.1750062328.git.leon@kernel.org>
References: <b5f7ae3d75f44a3e15ff3f4eb2bbdea13e06b97f.1750062328.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

- pre_destroy_cq: Destroy FW CQ object so that no new CQ event would
                  be generated;
- post_destroy_cq: Release all resources.

This patch, along with last one, fixes the crash below.

 Unable to handle kernel paging request at virtual address ffff8000114b1180
 Mem abort info:
   ESR = 0x96000047
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
 Data abort info:
   ISV = 0, ISS = 0x00000047
   CM = 0, WnR = 1
 swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000f4582000
 [ffff8000114b1180] pgd=00000447fffff003, p4d=00000447fffff003, pud=00000447ffffe003, pmd=00000447ffffb003, pte=0000000000000000
 Internal error: Oops: 96000047 [#1] SMP
 Modules linked in: udp_diag uio_pci_generic uio tcp_diag inet_diag binfmt_misc sn_core_odd(OE) rpcrdma(OE) xprtrdma(OE) ib_isert(OE) ib_iser(OE) ib_srpt(OE) ib_srp(OE) ib_ipoib(OE) kpatch_9658536(OK) kpatch_9322385(OK) kpatch_8843421(OK) kpatch_8636216(OK) vfat fat aes_ce_blk crypto_simd cryptd aes_ce_cipher crct10dif_ce ghash_ce sm4_ce sha2_ce sha256_arm64 sha1_ce sbsa_gwdt sg acpi_ipmi ipmi_si ipmi_msghandler m1_uncore_ddrss_pmu m1_uncore_cmn_pmu team_yosemite9rc6(OE) vnic(OE) ip_tables mlx5_ib(OE) sd_mod ast mlx5_core(OE) i2c_algo_bit drm_vram_helper psample drm_kms_helper mlxdevm(OE) auxiliary(OE) mlxfw(OE) syscopyarea sysfillrect tls sysimgblt fb_sys_fops drm_ttm_helper nvme ttm nvme_core drm t10_pi i2c_designware_platform i2c_designware_core i2c_core ahci libahci libata rdma_ucm(OE) ib_uverbs(OE) rdma_cm(OE) iw_cm(OE) ib_cm(OE) ib_umad(OE) ib_core(OE) ib_ucm(OE) mlx_compat(OE) [last unloaded: ipmi_devintf]
 CPU: 83 PID: 59375 Comm: kworker/u253:1 Kdump: loaded Tainted: G           OE K   5.10.84-004.ali5000.alios7.aarch64 #1
 Hardware name: Inspur AliServer-Xuanwu2.0AM-02-2UM1P-5B/AS1221MG1, BIOS 1.2.M1.AL.P.158.00 08/31/2023
 Workqueue: ib-comp-unb-wq ib_cq_poll_work [ib_core]
 pstate: 82c00089 (Nzcv daIf +PAN +UAO +TCO BTYPE=--)
 pc : native_queued_spin_lock_slowpath+0x1c4/0x31c
 lr : mlx5_ib_poll_cq+0x18c/0x2f8 [mlx5_ib]
 sp : ffff80002be1bc80
 x29: ffff80002be1bc80 x28: ffff000810e69000
 x27: ffff000810e69000 x26: ffff000810e69200
 x25: 0000000000000000 x24: ffff8000117db000
 x23: ffff04000156b780 x22: 0000000000000000
 x21: ffff04000ce6c160 x20: ffff0008196a4000
 x19: 0000000000000010 x18: 0000000000000020
 x17: 0000000000000000 x16: 0000000000000000
 x15: ffff040055a364e8 x14: ffffffffffffffff
 x13: ffff80002318bda8 x12: ffff0400358836e8
 x11: 0000000000000040 x10: 0000000000000eb0
 x9 : 0000000000000000 x8 : 0000000000000000
 x7 : ffff04477fa20140 x6 : ffff8000114b1140
 x5 : ffff04477fa20140 x4 : ffff8000114b1180
 x3 : ffff000810e69200 x2 : ffff8000114b1180
 x1 : 0000000001500000 x0 : ffff04477fa20148
 Call trace:
  native_queued_spin_lock_slowpath+0x1c4/0x31c
  __ib_process_cq+0x74/0x1b8 [ib_core]
  ib_cq_poll_work+0x34/0xa0 [ib_core]
  process_one_work+0x1d8/0x4b0
  worker_thread+0x180/0x440
  kthread+0x114/0x120
 Code: 910020e0 8b0400c4 f862d929 aa0403e2 (f8296847)
 ---[ end trace 387be2290557729c ]---
 Kernel panic - not syncing: Oops: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: disabled
 CPU features: 0x9850817,7a60aa38
 Memory Limit: none
 Starting crashdump kernel...
 Bye!

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cq.c      | 19 +++++++++++++++----
 drivers/infiniband/hw/mlx5/main.c    |  2 ++
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 ++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 9a157349bb36..cf1ca6e17610 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1055,20 +1055,31 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return err;
 }
 
-int mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
+int mlx5_ib_pre_destroy_cq(struct ib_cq *cq)
 {
 	struct mlx5_ib_dev *dev = to_mdev(cq->device);
 	struct mlx5_ib_cq *mcq = to_mcq(cq);
+
+	return mlx5_core_destroy_cq(dev->mdev, &mcq->mcq);
+}
+
+void mlx5_ib_post_destroy_cq(struct ib_cq *cq)
+{
+	destroy_cq_kernel(to_mdev(cq->device), to_mcq(cq));
+}
+
+int mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
+{
 	int ret;
 
-	ret = mlx5_core_destroy_cq(dev->mdev, &mcq->mcq);
+	ret = mlx5_ib_pre_destroy_cq(cq);
 	if (ret)
 		return ret;
 
 	if (udata)
-		destroy_cq_user(mcq, udata);
+		destroy_cq_user(to_mcq(cq), udata);
 	else
-		destroy_cq_kernel(dev, mcq);
+		mlx5_ib_post_destroy_cq(cq);
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index df6557ddbdfc..b0aa6c8f218c 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4190,7 +4190,9 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.modify_port = mlx5_ib_modify_port,
 	.modify_qp = mlx5_ib_modify_qp,
 	.modify_srq = mlx5_ib_modify_srq,
+	.pre_destroy_cq = mlx5_ib_pre_destroy_cq,
 	.poll_cq = mlx5_ib_poll_cq,
+	.post_destroy_cq = mlx5_ib_post_destroy_cq,
 	.post_recv = mlx5_ib_post_recv_nodrain,
 	.post_send = mlx5_ib_post_send_nodrain,
 	.post_srq_recv = mlx5_ib_post_srq_recv,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index ef627e2f8e6d..021724697fab 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1372,6 +1372,8 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		      struct uverbs_attr_bundle *attrs);
 int mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
 int mlx5_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc);
+int mlx5_ib_pre_destroy_cq(struct ib_cq *cq);
+void mlx5_ib_post_destroy_cq(struct ib_cq *cq);
 int mlx5_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 int mlx5_ib_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period);
 int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata);
-- 
2.49.0


