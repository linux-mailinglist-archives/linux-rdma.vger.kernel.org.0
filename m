Return-Path: <linux-rdma+bounces-3-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5497F237D
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 03:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96EA61C216AD
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 02:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9881172D;
	Tue, 21 Nov 2023 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="LGktvv6A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2923ECF;
	Mon, 20 Nov 2023 18:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JGU6K
	FKruZOeFPVjR6IpK0hLwoBGgsH3T/tqFT/aOhU=; b=LGktvv6AGKieT73AWCqGb
	dT1GP1D4TZ3yWgg/ZgH18DRqGn9NWEhQ4fLsK9w28fFPRRbQwJfB+WGrB3DNuIPT
	jAIrj0hJJRf155ZpRLbYvNQCpjiabFPPsKjuKioKzKrGrud7jql0MqTIvovFYPq/
	L6UI47JWP840pROXz5hIro=
Received: from ubuntu.localdomain (unknown [111.222.250.119])
	by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wB3_9UnD1xltn6HAw--.26642S2;
	Tue, 21 Nov 2023 10:00:16 +0800 (CST)
From: Shifeng Li <lishifeng1992@126.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eli@mellanox.com,
	ogerlitz@mellanox.com,
	jackm@dev.mellanox.co.il,
	roland@purestorage.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dinghui@sangfor.com.cn,
	Shifeng Li <lishifeng1992@126.com>
Subject: [PATCH] net/mlx5e: Fix a race in command alloc flow
Date: Mon, 20 Nov 2023 18:00:04 -0800
Message-Id: <20231121020004.115815-1-lishifeng1992@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3_9UnD1xltn6HAw--.26642S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrWkKw1kKFy5GF1UZryDAwb_yoWrtFWrpF
	W7W343AF4kGa1q9r40vF40v3W8A39Fg3srGF1I93Z3W3Z8A34kAa4DJFyjgryUuFW8tFy7
	JFWDt3W8Ars3XF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U-zVbUUUUU=
X-Originating-IP: [111.222.250.119]
X-CM-SenderInfo: xolvxx5ihqwiqzzsqiyswou0bp/1tbi1xsur153c1R7WAABsh

Fix a cmd->ent use after free due to a race on command entry.
Such race occurs when one of the commands releases its last refcount and
frees its index and entry while another process running command flush
flow takes refcount to this command entry. The process which handles
commands flush may see this command as needed to be flushed if the other
process allocated a ent->idx but didn't set ent to cmd->ent_arr in
cmd_work_handler(). Fix it by moving the assignment of cmd->ent_arr into
the spin lock.

[70013.081955] BUG: KASAN: use-after-free in mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
[70013.081967] Write of size 4 at addr ffff88880b1510b4 by task kworker/26:1/1433361
[70013.081968]
[70013.081989] CPU: 26 PID: 1433361 Comm: kworker/26:1 Kdump: loaded Tainted: G           OE     4.19.90-25.17.v2101.osc.sfc.6.10.0.0030.ky10.x86_64+debug #1
[70013.082001] Hardware name: SANGFOR 65N32-US/ASERVER-G-2605, BIOS SSSS5203 08/19/2020
[70013.082028] Workqueue: events aer_isr
[70013.082053] Call Trace:
[70013.082067]  dump_stack+0x8b/0xbb
[70013.082086]  print_address_description+0x6a/0x270
[70013.082102]  kasan_report+0x179/0x2c0
[70013.082133]  ? mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
[70013.082173]  mlx5_cmd_trigger_completions+0x1e2/0x4c0 [mlx5_core]
[70013.082213]  ? mlx5_cmd_use_polling+0x20/0x20 [mlx5_core]
[70013.082223]  ? kmem_cache_free+0x1ad/0x1e0
[70013.082267]  mlx5_cmd_flush+0x80/0x180 [mlx5_core]
[70013.082304]  mlx5_enter_error_state+0x106/0x1d0 [mlx5_core]
[70013.082338]  mlx5_try_fast_unload+0x2ea/0x4d0 [mlx5_core]
[70013.082377]  remove_one+0x200/0x2b0 [mlx5_core]
[70013.082390]  ? __pm_runtime_resume+0x58/0x70
[70013.082409]  pci_device_remove+0xf3/0x280
[70013.082426]  ? pcibios_free_irq+0x10/0x10
[70013.082439]  device_release_driver_internal+0x1c3/0x470
[70013.082453]  pci_stop_bus_device+0x109/0x160
[70013.082468]  pci_stop_and_remove_bus_device+0xe/0x20
[70013.082485]  pcie_do_fatal_recovery+0x167/0x550
[70013.082493]  aer_isr+0x7d2/0x960
[70013.082510]  ? aer_get_device_error_info+0x420/0x420
[70013.082526]  ? __schedule+0x821/0x2040
[70013.082536]  ? strscpy+0x85/0x180
[70013.082543]  process_one_work+0x65f/0x12d0
[70013.082556]  worker_thread+0x87/0xb50
[70013.082563]  ? __kthread_parkme+0x82/0xf0
[70013.082569]  ? process_one_work+0x12d0/0x12d0
[70013.082571]  kthread+0x2e9/0x3a0
[70013.082579]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[70013.082592]  ret_from_fork+0x1f/0x40

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Shifeng Li <lishifeng1992@126.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index d3ca745d107d..1f9c09065249 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -115,15 +115,18 @@ static u8 alloc_token(struct mlx5_cmd *cmd)
 	return token;
 }
 
-static int cmd_alloc_index(struct mlx5_cmd *cmd)
+static int cmd_alloc_index(struct mlx5_cmd *cmd, struct mlx5_cmd_work_ent *ent)
 {
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&cmd->alloc_lock, flags);
 	ret = find_first_bit(&cmd->bitmask, cmd->max_reg_cmds);
-	if (ret < cmd->max_reg_cmds)
+	if (ret < cmd->max_reg_cmds) {
 		clear_bit(ret, &cmd->bitmask);
+		ent->idx = ret;
+		cmd->ent_arr[ent->idx] = ent;
+	}
 	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 
 	return ret < cmd->max_reg_cmds ? ret : -ENOMEM;
@@ -957,7 +960,7 @@ static void cmd_work_handler(struct work_struct *work)
 	sem = ent->page_queue ? &cmd->pages_sem : &cmd->sem;
 	down(sem);
 	if (!ent->page_queue) {
-		alloc_ret = cmd_alloc_index(cmd);
+		alloc_ret = cmd_alloc_index(cmd, ent);
 		if (alloc_ret < 0) {
 			mlx5_core_err_rl(dev, "failed to allocate command entry\n");
 			if (ent->callback) {
@@ -972,15 +975,14 @@ static void cmd_work_handler(struct work_struct *work)
 			up(sem);
 			return;
 		}
-		ent->idx = alloc_ret;
 	} else {
 		ent->idx = cmd->max_reg_cmds;
 		spin_lock_irqsave(&cmd->alloc_lock, flags);
 		clear_bit(ent->idx, &cmd->bitmask);
+		cmd->ent_arr[ent->idx] = ent;
 		spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 	}
 
-	cmd->ent_arr[ent->idx] = ent;
 	lay = get_inst(cmd, ent->idx);
 	ent->lay = lay;
 	memset(lay, 0, sizeof(*lay));
-- 
2.25.1


