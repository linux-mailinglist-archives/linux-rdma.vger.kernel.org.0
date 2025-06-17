Return-Path: <linux-rdma+bounces-11383-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEEAADC45B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A33318876A8
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0772328DF02;
	Tue, 17 Jun 2025 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thNdb9o3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0F9D2FB
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148042; cv=none; b=SjorSMpNdth7EPMnNFs2f6On8Ad13Sl/l/sOmuCkj7FA383Q7xYXCC6shDUgcFjMvMQIBddreb9bl7ap27aNFZ4chUpCRX/9kaA2vxGf3Z90y3BEU10Jz3qLftkdMZ2wAulKbVXUOqXIMzxBn8IugFoTp+dJEHH2d7ZXundUqJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148042; c=relaxed/simple;
	bh=feWZqRhHLGyQ7GdtLLYW/PG7KDvOtw+bKal1I0kMV3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SrOm+W9BPjZarPSFinvX0sV2ifo3yVihmjwTcl1nUaOToM0bvnZd8Kvy84SjpIJLDQ1VWGug3u49TbEo7a4OndA2ghoEY4YOTTrwQjupvbUZHOhbibXuj4i0tquzk/559eNJWKOkH8qLRaJ4k6fOitgj4f1N397GqNdkQNMuTVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thNdb9o3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F69C4CEE3;
	Tue, 17 Jun 2025 08:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750148042;
	bh=feWZqRhHLGyQ7GdtLLYW/PG7KDvOtw+bKal1I0kMV3o=;
	h=From:To:Cc:Subject:Date:From;
	b=thNdb9o3VioUaGkroAU05YkUUn22vTZOiJnW3xCVtoT+zh861WOEUe/GYpSDl279M
	 L5oBSWe2FgL/zoSkODcEcDxmh5gPDfEyZ6UreLXhi2oeLL6sb3h80TZsV4Rd4R66GY
	 sFTPmh3219UHarYqmBGOey8VjcvSzb0kEuYeNPbgzbdY+4VHVRBe1hKJKjvMjDE0B3
	 pvhiVNsLjSFW7PCbzZb6KOwWSI5JOC60pqqShKcuupxY6oj+uih2ZdEMdQ7rlpOj/s
	 agG3lW6GutLv2WgvermLmGC9IROjY/TK31IlqSkUzckKl2DcvxDwDiiHWV60rHhLk5
	 WtYpwH2K0UMoA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Initialize obj_event->obj_sub_list before xa_insert
Date: Tue, 17 Jun 2025 11:13:55 +0300
Message-ID: <3ce7f20e0d1a03dc7de6e57494ec4b8eaf1f05c2.1750147949.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

The obj_event may be loaded immediately after inserted, then if the
list_head is not initialized then we may get a poisonous pointer.
This fixes the crash below:

 mlx5_core 0000:03:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0 enhanced)
 mlx5_core.sf mlx5_core.sf.4: firmware version: 32.38.3056
 mlx5_core 0000:03:00.0 en3f0pf0sf2002: renamed from eth0
 mlx5_core.sf mlx5_core.sf.4: Rate limit: 127 rates are supported, range: 0Mbps to 195312Mbps
 IPv6: ADDRCONF(NETDEV_CHANGE): en3f0pf0sf2002: link becomes ready
 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000060
 Mem abort info:
   ESR = 0x96000006
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
 Data abort info:
   ISV = 0, ISS = 0x00000006
   CM = 0, WnR = 0
 user pgtable: 4k pages, 48-bit VAs, pgdp=00000007760fb000
 [0000000000000060] pgd=000000076f6d7003, p4d=000000076f6d7003, pud=0000000777841003, pmd=0000000000000000
 Internal error: Oops: 96000006 [#1] SMP
 Modules linked in: ipmb_host(OE) act_mirred(E) cls_flower(E) sch_ingress(E) mptcp_diag(E) udp_diag(E) raw_diag(E) unix_diag(E) tcp_diag(E) inet_diag(E) binfmt_misc(E) bonding(OE) rdma_ucm(OE) rdma_cm(OE) iw_cm(OE) ib_ipoib(OE) ib_cm(OE) isofs(E) cdrom(E) mst_pciconf(OE) ib_umad(OE) mlx5_ib(OE) ipmb_dev_int(OE) mlx5_core(OE) kpatch_15237886(OEK) mlxdevm(OE) auxiliary(OE) ib_uverbs(OE) ib_core(OE) psample(E) mlxfw(OE) tls(E) sunrpc(E) vfat(E) fat(E) crct10dif_ce(E) ghash_ce(E) sha1_ce(E) sbsa_gwdt(E) virtio_console(E) ext4(E) mbcache(E) jbd2(E) xfs(E) libcrc32c(E) mmc_block(E) virtio_net(E) net_failover(E) failover(E) sha2_ce(E) sha256_arm64(E) nvme(OE) nvme_core(OE) gpio_mlxbf3(OE) mlx_compat(OE) mlxbf_pmc(OE) i2c_mlxbf(OE) sdhci_of_dwcmshc(OE) pinctrl_mlxbf3(OE) mlxbf_pka(OE) gpio_generic(E) i2c_core(E) mmc_core(E) mlxbf_gige(OE) vitesse(E) pwr_mlxbf(OE) mlxbf_tmfifo(OE) micrel(E) mlxbf_bootctl(OE) virtio_ring(E) virtio(E) ipmi_devintf(E) ipmi_msghandler(E)
  [last unloaded: mst_pci]
 CPU: 11 PID: 20913 Comm: rte-worker-11 Kdump: loaded Tainted: G           OE K   5.10.134-13.1.an8.aarch64 #1
 Hardware name: https://www.mellanox.com BlueField-3 SmartNIC Main Card/BlueField-3 SmartNIC Main Card, BIOS 4.2.2.12968 Oct 26 2023
 pstate: a0400089 (NzCv daIf +PAN -UAO -TCO BTYPE=--)
 pc : dispatch_event_fd+0x68/0x300 [mlx5_ib]
 lr : devx_event_notifier+0xcc/0x228 [mlx5_ib]
 sp : ffff80001005bcf0
 x29: ffff80001005bcf0 x28: 0000000000000001
 x27: ffff244e0740a1d8 x26: ffff244e0740a1d0
 x25: ffffda56beff5ae0 x24: ffffda56bf911618
 x23: ffff244e0596a480 x22: ffff244e0596a480
 x21: ffff244d8312ad90 x20: ffff244e0596a480
 x19: fffffffffffffff0 x18: 0000000000000000
 x17: 0000000000000000 x16: ffffda56be66d620
 x15: 0000000000000000 x14: 0000000000000000
 x13: 0000000000000000 x12: 0000000000000000
 x11: 0000000000000040 x10: ffffda56bfcafb50
 x9 : ffffda5655c25f2c x8 : 0000000000000010
 x7 : 0000000000000000 x6 : ffff24545a2e24b8
 x5 : 0000000000000003 x4 : ffff80001005bd28
 x3 : 0000000000000000 x2 : 0000000000000000
 x1 : ffff244e0596a480 x0 : ffff244d8312ad90
 Call trace:
  dispatch_event_fd+0x68/0x300 [mlx5_ib]
  devx_event_notifier+0xcc/0x228 [mlx5_ib]
  atomic_notifier_call_chain+0x58/0x80
  mlx5_eq_async_int+0x148/0x2b0 [mlx5_core]
  atomic_notifier_call_chain+0x58/0x80
  irq_int_handler+0x20/0x30 [mlx5_core]
  __handle_irq_event_percpu+0x60/0x220
  handle_irq_event_percpu+0x3c/0x90
  handle_irq_event+0x58/0x158
  handle_fasteoi_irq+0xfc/0x188
  generic_handle_irq+0x34/0x48
  ...

Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over DEVX")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index e5551736ee14..b690b58ec91d 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1958,6 +1958,7 @@ subscribe_event_xa_alloc(struct mlx5_devx_event_table *devx_event_table,
 			/* Level1 is valid for future use, no need to free */
 			return -ENOMEM;
 
+		INIT_LIST_HEAD(&obj_event->obj_sub_list);
 		err = xa_insert(&event->object_ids,
 				key_level2,
 				obj_event,
@@ -1966,7 +1967,6 @@ subscribe_event_xa_alloc(struct mlx5_devx_event_table *devx_event_table,
 			kfree(obj_event);
 			return err;
 		}
-		INIT_LIST_HEAD(&obj_event->obj_sub_list);
 	}
 
 	return 0;
-- 
2.49.0


