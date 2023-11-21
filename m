Return-Path: <linux-rdma+bounces-8-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7EB7F2C6E
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 12:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D92B20EF6
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 11:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBD148CFE;
	Tue, 21 Nov 2023 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="d6qwFxww"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF2A110CB;
	Tue, 21 Nov 2023 03:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0nbt5
	Iv6Psgndc9/7xheezuoX2tizM5FTvQBexU/VpI=; b=d6qwFxwwscbDqWjScE9wr
	rRtRKKFeRXTaO3gkBNm+KhJKY+1KdIz6vFFxLILJ8za6Hx34ueTJhRlQKlvo71Qi
	KzttJ8gNcDXt2AXVCK4f0s5bXHnlgZWovuHLs+ZrD8XYWtWGkDle9EgyYlpn2GUZ
	7qlUgYejoifPVD5b6IKgGM=
Received: from ubuntu.localdomain (unknown [111.222.250.119])
	by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wD3f_oWmlxlBnazCw--.33745S2;
	Tue, 21 Nov 2023 19:52:58 +0800 (CST)
From: Shifeng Li <lishifeng1992@126.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jackm@dev.mellanox.co.il,
	ogerlitz@mellanox.com,
	roland@purestorage.com,
	eli@mellanox.com
Cc: dinghui@sangfor.com.cn,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shifeng Li <lishifeng1992@126.com>
Subject: [PATCH v2] net/mlx5e: Fix a race in command alloc flow
Date: Tue, 21 Nov 2023 03:52:51 -0800
Message-Id: <20231121115251.588436-1-lishifeng1992@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f_oWmlxlBnazCw--.33745S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrWkKw1kKFy5GF1UZryDAwb_yoWrKF4UpF
	W7Wry7AF48Gw4q9r4vqF40v3W8C39rK3srGF1I93Z3W3Z8A34kAa4kJFyjgryUuFWxtFy7
	JayDt3W8Arn3XF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U-zVbUUUUU=
X-Originating-IP: [111.222.250.119]
X-CM-SenderInfo: xolvxx5ihqwiqzzsqiyswou0bp/1S2mtgUvr1pD4QWXJgAAs-

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
---
v1->v2: fix code conflicts.

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index f8f0a712c943..a7b1f9686c09 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -156,15 +156,18 @@ static u8 alloc_token(struct mlx5_cmd *cmd)
 	return token;
 }
 
-static int cmd_alloc_index(struct mlx5_cmd *cmd)
+static int cmd_alloc_index(struct mlx5_cmd *cmd, struct mlx5_cmd_work_ent *ent)
 {
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&cmd->alloc_lock, flags);
 	ret = find_first_bit(&cmd->vars.bitmask, cmd->vars.max_reg_cmds);
-	if (ret < cmd->vars.max_reg_cmds)
+	if (ret < cmd->vars.max_reg_cmds) {
 		clear_bit(ret, &cmd->vars.bitmask);
+		ent->idx = ret;
+		cmd->ent_arr[ent->idx] = ent;
+	}
 	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 
 	return ret < cmd->vars.max_reg_cmds ? ret : -ENOMEM;
@@ -979,7 +982,7 @@ static void cmd_work_handler(struct work_struct *work)
 	sem = ent->page_queue ? &cmd->vars.pages_sem : &cmd->vars.sem;
 	down(sem);
 	if (!ent->page_queue) {
-		alloc_ret = cmd_alloc_index(cmd);
+		alloc_ret = cmd_alloc_index(cmd, ent);
 		if (alloc_ret < 0) {
 			mlx5_core_err_rl(dev, "failed to allocate command entry\n");
 			if (ent->callback) {
@@ -994,15 +997,14 @@ static void cmd_work_handler(struct work_struct *work)
 			up(sem);
 			return;
 		}
-		ent->idx = alloc_ret;
 	} else {
 		ent->idx = cmd->vars.max_reg_cmds;
 		spin_lock_irqsave(&cmd->alloc_lock, flags);
 		clear_bit(ent->idx, &cmd->vars.bitmask);
+		cmd->ent_arr[ent->idx] = ent;
 		spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 	}
 
-	cmd->ent_arr[ent->idx] = ent;
 	lay = get_inst(cmd, ent->idx);
 	ent->lay = lay;
 	memset(lay, 0, sizeof(*lay));
-- 
2.25.1


