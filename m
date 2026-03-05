Return-Path: <linux-rdma+bounces-17503-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ6zDJfrqGnnygAAu9opvQ
	(envelope-from <linux-rdma+bounces-17503-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 03:33:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A22D20A378
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 03:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E2743014F69
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 02:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B79261388;
	Thu,  5 Mar 2026 02:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RO96ySkQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CA3260566;
	Thu,  5 Mar 2026 02:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772678032; cv=none; b=owU0HylcZtCoaNipHFnXH6G0xyMBtIIqzqyGoIreAOzgpLyhVodypp1s+9FjUu5IMmYwKvg0fpJuEQoYNk+DEO7YMFbIQdiYt4l5oAbTzC2ahzZzEN2NF7lmBJE1D2caZ7PW2F1bSG1IL9uX4eRGQ1sUy+IGQeYxh3Ht/UOC/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772678032; c=relaxed/simple;
	bh=Qdlq5KGmnjJxn2Wl3W6FzAOFl9UbpgQNhmvpFQUzLI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bOKWkp/rH29SZV42eWrqFn/VtywQHm9Keh/eBZE3jgKrCIgO0bU6wBuntUy/z7SfmV/GDWqCxqoWgrER9V3wMlaTgTps7UlY9aueQZhluzsBzXttqOFj+qMksvZDqlQRLSpZBBATB0dGIeXCSah4eYKtGmbKcqDH2iW3y+YPaFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RO96ySkQ; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=23ZnG4Mnc932KfWkIsCruwfLV+eS6MINzcq9AdU1pWI=;
	b=RO96ySkQ1rqpBUWJ5BogKUV7vzcCLp/9r651B2fX3zOvEHlnQ4IE46hlYj5ZuEz1THDalQFJR
	oQfTtk+f14pcuZf9fs/wzxcf04k/l1R3AoT1ht5OaIyyvTwW3LQejyvzuOH5ZUvkBUfBByYNSIS
	dQ9/HjQLJlv+YnfTl6AiBIo=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fRD4k0pvnznTbP;
	Thu,  5 Mar 2026 10:29:10 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C8E6402AB;
	Thu,  5 Mar 2026 10:33:46 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Mar 2026 10:33:44 +0800
Message-ID: <e8e2fed1-f7a2-e107-f571-52f3e87d642e@huawei.com>
Date: Thu, 5 Mar 2026 10:33:43 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net V2 5/6] net/mlx5e: Fix deadlocks between devlink and
 netdev instance locks
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
References: <20260218072904.1764634-1-tariqt@nvidia.com>
 <20260218072904.1764634-6-tariqt@nvidia.com>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260218072904.1764634-6-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-Rspamd-Queue-Id: 3A22D20A378
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17503-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruanjinjie@huawei.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,huawei.com:dkim,huawei.com:mid,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 2026/2/18 15:29, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> In the mentioned "Fixes" commit, various work tasks triggering devlink
> health reporter recovery were switched to use netdev_trylock to protect
> against concurrent tear down of the channels being recovered. But this
> had the side effect of introducing potential deadlocks because of
> incorrect lock ordering.
> 
> The correct lock order is described by the init flow:
> probe_one -> mlx5_init_one (acquires devlink lock)
> -> mlx5_init_one_devl_locked -> mlx5_register_device
> -> mlx5_rescan_drivers_locked -...-> mlx5e_probe -> _mlx5e_probe
> -> register_netdev (acquires rtnl lock)
> -> register_netdevice (acquires netdev lock)
> => devlink lock -> rtnl lock -> netdev lock.
> 
> But in the current recovery flow, the order is wrong:
> mlx5e_tx_err_cqe_work (acquires netdev lock)
> -> mlx5e_reporter_tx_err_cqe -> mlx5e_health_report
> -> devlink_health_report (acquires devlink lock => boom!)
> -> devlink_health_reporter_recover
> -> mlx5e_tx_reporter_recover -> mlx5e_tx_reporter_recover_from_ctx
> -> mlx5e_tx_reporter_err_cqe_recover
> 
> The same pattern exists in:
> mlx5e_reporter_rx_timeout
> mlx5e_reporter_tx_ptpsq_unhealthy
> mlx5e_reporter_tx_timeout
> 

On 7.0 rc2，It seems that similar problems still exist, causing the ARM64
kernel to fail to start on the Kunpeng 920 as below:

[  242.676635][ T1644] INFO: task kworker/u1280:1:1671 blocked for more
than 120 seconds.
[  242.682141][ T1644]       Not tainted 7.0.0-rc2+ #3
[  242.684942][ T1644] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  242.690552][ T1644] task:kworker/u1280:1 state:D stack:0     pid:1671
 tgid:1671  ppid:2      task_flags:0x4208060 flags:0x00000010
[  242.696332][ T1644] Workqueue: mlx5_health0000:97:00.0
mlx5_fw_reporter_err_work [mlx5_core]
[  242.702324][ T1644] Call trace:
[  242.705187][ T1644]  __switch_to+0xdc/0x108 (T)
[  242.707936][ T1644]  __schedule+0x2a0/0x8a8
[  242.710647][ T1644]  schedule+0x3c/0xc0
[  242.713321][ T1644]  schedule_preempt_disabled+0x2c/0x50
[  242.715875][ T1644]  __mutex_lock.constprop.0+0x344/0x918
[  242.718421][ T1644]  __mutex_lock_slowpath+0x1c/0x30
[  242.720885][ T1644]  mutex_lock+0x50/0x68
[  242.723278][ T1644]  devl_lock+0x1c/0x30
[  242.725607][ T1644]  devlink_health_report+0x240/0x328
[  242.727902][ T1644]  mlx5_fw_reporter_err_work+0xa0/0xb0 [mlx5_core]
[  242.730333][ T1644]  process_one_work+0x180/0x4f8
[  242.732687][ T1644]  worker_thread+0x208/0x280
[  242.734976][ T1644]  kthread+0x128/0x138
[  242.737217][ T1644]  ret_from_fork+0x10/0x20
[  242.739599][ T1644] INFO: task kworker/u1280:1:1671 is blocked on a
mutex likely owned by task kworker/240:2:2582.
[  242.744002][ T1644] task:kworker/240:2   state:D stack:0     pid:2582
 tgid:2582  ppid:2      task_flags:0x4208060 flags:0x00000010
[  242.748447][ T1644] Workqueue: sync_wq local_pci_probe_callback
[  242.750654][ T1644] Call trace:
[  242.752793][ T1644]  __switch_to+0xdc/0x108 (T)
[  242.754882][ T1644]  __schedule+0x2a0/0x8a8
[  242.756946][ T1644]  schedule+0x3c/0xc0
[  242.758951][ T1644]  schedule_timeout+0x80/0x120
[  242.760903][ T1644]  __wait_for_common+0xc4/0x1d0
[  242.762796][ T1644]  wait_for_completion_timeout+0x28/0x40
[  242.764670][ T1644]  wait_func+0x180/0x240 [mlx5_core]
[  242.766533][ T1644]  mlx5_cmd_invoke+0x244/0x3e0 [mlx5_core]
[  242.768338][ T1644]  cmd_exec+0x208/0x448 [mlx5_core]
[  242.770153][ T1644]  mlx5_cmd_do+0x38/0x80 [mlx5_core]
[  242.771974][ T1644]  mlx5_cmd_exec+0x2c/0x60 [mlx5_core]
[  242.773848][ T1644]  mlx5_core_create_mkey+0x70/0x120 [mlx5_core]
[  242.775712][ T1644]  mlx5_fw_tracer_create_mkey+0x114/0x180 [mlx5_core]
[  242.777609][ T1644]  mlx5_fw_tracer_init.part.0+0xb0/0x1f0 [mlx5_core]
[  242.779495][ T1644]  mlx5_fw_tracer_init+0x24/0x40 [mlx5_core]
[  242.781380][ T1644]  mlx5_load+0x78/0x360 [mlx5_core]
[  242.783256][ T1644]  mlx5_init_one_devl_locked+0xd0/0x278 [mlx5_core]
[  242.785231][ T1644]  probe_one+0xe0/0x208 [mlx5_core]
[  242.787159][ T1644]  local_pci_probe+0x48/0xb8
[  242.789038][ T1644]  local_pci_probe_callback+0x24/0x40
[  242.790876][ T1644]  process_one_work+0x180/0x4f8
[  242.792731][ T1644]  worker_thread+0x208/0x280
[  242.794578][ T1644]  kthread+0x128/0x138
[  242.796427][ T1644]  ret_from_fork+0x10/0x20
[  242.798277][ T1644] INFO: task systemd-udevd:2281 blocked for more
than 120 seconds.
[  242.801795][ T1644]       Not tainted 7.0.0-rc2+ #3
[  242.803542][ T1644] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  242.807056][ T1644] task:systemd-udevd   state:D stack:0     pid:2281
 tgid:2281  ppid:2256   task_flags:0x400140 flags:0x00000811
[  242.810829][ T1644] Call trace:
[  242.812779][ T1644]  __switch_to+0xdc/0x108 (T)
[  242.814681][ T1644]  __schedule+0x2a0/0x8a8
[  242.816609][ T1644]  schedule+0x3c/0xc0
[  242.818499][ T1644]  schedule_timeout+0x10c/0x120
[  242.820388][ T1644]  __wait_for_common+0xc4/0x1d0
[  242.822267][ T1644]  wait_for_completion+0x28/0x40
[  242.824168][ T1644]  __flush_work+0x7c/0xf8
[  242.825983][ T1644]  flush_work+0x1c/0x30
[  242.827816][ T1644]  pci_call_probe+0x174/0x1e0
[  242.829652][ T1644]  pci_device_probe+0x98/0x108
[  242.831455][ T1644]  call_driver_probe+0x34/0x158
[  242.833261][ T1644]  really_probe+0xc0/0x320
[  242.835082][ T1644]  __driver_probe_device+0x88/0x190
[  242.836843][ T1644]  driver_probe_device+0x48/0x120
[  242.838607][ T1644]  __driver_attach+0x138/0x280
[  242.840355][ T1644]  bus_for_each_dev+0x80/0xe8
[  242.842095][ T1644]  driver_attach+0x2c/0x40
[  242.843830][ T1644]  bus_add_driver+0x128/0x258
[  242.845564][ T1644]  driver_register+0x68/0x138
[  242.847285][ T1644]  __pci_register_driver+0x4c/0x60
[  242.849038][ T1644]  mlx5_init+0x7c/0xff8 [mlx5_core]
[  242.850871][ T1644]  do_one_initcall+0x50/0x498
[  242.852561][ T1644]  do_init_module+0x60/0x280
[  242.854220][ T1644]  load_module+0x3d8/0x6a8
[  242.855856][ T1644]  init_module_from_file+0xe4/0x108
[  242.857470][ T1644]  idempotent_init_module+0x190/0x290
[  242.859022][ T1644]  __arm64_sys_finit_module+0x74/0xf8
[  242.860544][ T1644]  invoke_syscall+0x50/0x120
[  242.861996][ T1644]  el0_svc_common.constprop.0+0xc8/0xf0
[  242.863457][ T1644]  do_el0_svc+0x24/0x38
[  242.864914][ T1644]  el0_svc+0x34/0x170
[  242.866361][ T1644]  el0t_64_sync_handler+0xa0/0xe8
[  242.867839][ T1644]  el0t_64_sync+0x190/0x198


> Fix these by moving the netdev_trylock calls from the work handlers
> lower in the call stack, in the respective recovery functions, where
> they are actually necessary.
> 
> Fixes: 8f7b00307bf1 ("net/mlx5e: Convert mlx5 netdevs to instance locking")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en/ptp.c  | 14 -----
>  .../mellanox/mlx5/core/en/reporter_rx.c       | 13 +++++
>  .../mellanox/mlx5/core/en/reporter_tx.c       | 52 +++++++++++++++++--
>  .../net/ethernet/mellanox/mlx5/core/en_main.c | 40 --------------
>  4 files changed, 61 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> index 424f8a2728a3..74660e7fe674 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> @@ -457,22 +457,8 @@ static void mlx5e_ptpsq_unhealthy_work(struct work_struct *work)
>  {
>  	struct mlx5e_ptpsq *ptpsq =
>  		container_of(work, struct mlx5e_ptpsq, report_unhealthy_work);
> -	struct mlx5e_txqsq *sq = &ptpsq->txqsq;
> -
> -	/* Recovering the PTP SQ means re-enabling NAPI, which requires the
> -	 * netdev instance lock. However, SQ closing has to wait for this work
> -	 * task to finish while also holding the same lock. So either get the
> -	 * lock or find that the SQ is no longer enabled and thus this work is
> -	 * not relevant anymore.
> -	 */
> -	while (!netdev_trylock(sq->netdev)) {
> -		if (!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state))
> -			return;
> -		msleep(20);
> -	}
>  
>  	mlx5e_reporter_tx_ptpsq_unhealthy(ptpsq);
> -	netdev_unlock(sq->netdev);
>  }
>  
>  static int mlx5e_ptp_open_txqsq(struct mlx5e_ptp *c, u32 tisn,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
> index 0686fbdd5a05..6efb626b5506 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2019 Mellanox Technologies.
>  
> +#include <net/netdev_lock.h>
> +
>  #include "health.h"
>  #include "params.h"
>  #include "txrx.h"
> @@ -177,6 +179,16 @@ static int mlx5e_rx_reporter_timeout_recover(void *ctx)
>  	rq = ctx;
>  	priv = rq->priv;
>  
> +	/* Acquire netdev instance lock to synchronize with channel close and
> +	 * reopen flows. Either successfully obtain the lock, or detect that
> +	 * channels are closing for another reason, making this work no longer
> +	 * necessary.
> +	 */
> +	while (!netdev_trylock(rq->netdev)) {
> +		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &rq->priv->state))
> +			return 0;
> +		msleep(20);
> +	}
>  	mutex_lock(&priv->state_lock);
>  
>  	eq = rq->cq.mcq.eq;
> @@ -186,6 +198,7 @@ static int mlx5e_rx_reporter_timeout_recover(void *ctx)
>  		clear_bit(MLX5E_SQ_STATE_ENABLED, &rq->icosq->state);
>  
>  	mutex_unlock(&priv->state_lock);
> +	netdev_unlock(rq->netdev);
>  
>  	return err;
>  }
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
> index 4adc1adf9897..60ba840e00fa 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
> @@ -1,6 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Copyright (c) 2019 Mellanox Technologies. */
>  
> +#include <net/netdev_lock.h>
> +
>  #include "health.h"
>  #include "en/ptp.h"
>  #include "en/devlink.h"
> @@ -79,6 +81,18 @@ static int mlx5e_tx_reporter_err_cqe_recover(void *ctx)
>  	if (!test_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state))
>  		return 0;
>  
> +	/* Recovering queues means re-enabling NAPI, which requires the netdev
> +	 * instance lock. However, SQ closing flows have to wait for work tasks
> +	 * to finish while also holding the netdev instance lock. So either get
> +	 * the lock or find that the SQ is no longer enabled and thus this work
> +	 * is not relevant anymore.
> +	 */
> +	while (!netdev_trylock(dev)) {
> +		if (!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state))
> +			return 0;
> +		msleep(20);
> +	}
> +
>  	err = mlx5_core_query_sq_state(mdev, sq->sqn, &state);
>  	if (err) {
>  		netdev_err(dev, "Failed to query SQ 0x%x state. err = %d\n",
> @@ -114,9 +128,11 @@ static int mlx5e_tx_reporter_err_cqe_recover(void *ctx)
>  	else
>  		mlx5e_trigger_napi_sched(sq->cq.napi);
>  
> +	netdev_unlock(dev);
>  	return 0;
>  out:
>  	clear_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state);
> +	netdev_unlock(dev);
>  	return err;
>  }
>  
> @@ -137,10 +153,24 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
>  	sq = to_ctx->sq;
>  	eq = sq->cq.mcq.eq;
>  	priv = sq->priv;
> +
> +	/* Recovering the TX queues implies re-enabling NAPI, which requires
> +	 * the netdev instance lock.
> +	 * However, channel closing flows have to wait for this work to finish
> +	 * while holding the same lock. So either get the lock or find that
> +	 * channels are being closed for other reason and this work is not
> +	 * relevant anymore.
> +	 */
> +	while (!netdev_trylock(sq->netdev)) {
> +		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state))
> +			return 0;
> +		msleep(20);
> +	}
> +
>  	err = mlx5e_health_channel_eq_recover(sq->netdev, eq, sq->cq.ch_stats);
>  	if (!err) {
>  		to_ctx->status = 0; /* this sq recovered */
> -		return err;
> +		goto out;
>  	}
>  
>  	mutex_lock(&priv->state_lock);
> @@ -148,7 +178,7 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
>  	mutex_unlock(&priv->state_lock);
>  	if (!err) {
>  		to_ctx->status = 1; /* all channels recovered */
> -		return err;
> +		goto out;
>  	}
>  
>  	to_ctx->status = err;
> @@ -156,7 +186,8 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
>  	netdev_err(priv->netdev,
>  		   "mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(%d).\n",
>  		   err);
> -
> +out:
> +	netdev_unlock(sq->netdev);
>  	return err;
>  }
>  
> @@ -173,10 +204,22 @@ static int mlx5e_tx_reporter_ptpsq_unhealthy_recover(void *ctx)
>  		return 0;
>  
>  	priv = ptpsq->txqsq.priv;
> +	netdev = priv->netdev;
> +
> +	/* Recovering the PTP SQ means re-enabling NAPI, which requires the
> +	 * netdev instance lock. However, SQ closing has to wait for this work
> +	 * task to finish while also holding the same lock. So either get the
> +	 * lock or find that the SQ is no longer enabled and thus this work is
> +	 * not relevant anymore.
> +	 */
> +	while (!netdev_trylock(netdev)) {
> +		if (!test_bit(MLX5E_SQ_STATE_ENABLED, &ptpsq->txqsq.state))
> +			return 0;
> +		msleep(20);
> +	}
>  
>  	mutex_lock(&priv->state_lock);
>  	chs = &priv->channels;
> -	netdev = priv->netdev;
>  
>  	carrier_ok = netif_carrier_ok(netdev);
>  	netif_carrier_off(netdev);
> @@ -193,6 +236,7 @@ static int mlx5e_tx_reporter_ptpsq_unhealthy_recover(void *ctx)
>  		netif_carrier_on(netdev);
>  
>  	mutex_unlock(&priv->state_lock);
> +	netdev_unlock(netdev);
>  
>  	return err;
>  }
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 4b8084420816..73f4805feac7 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -631,19 +631,7 @@ static void mlx5e_rq_timeout_work(struct work_struct *timeout_work)
>  					   struct mlx5e_rq,
>  					   rx_timeout_work);
>  
> -	/* Acquire netdev instance lock to synchronize with channel close and
> -	 * reopen flows. Either successfully obtain the lock, or detect that
> -	 * channels are closing for another reason, making this work no longer
> -	 * necessary.
> -	 */
> -	while (!netdev_trylock(rq->netdev)) {
> -		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &rq->priv->state))
> -			return;
> -		msleep(20);
> -	}
> -
>  	mlx5e_reporter_rx_timeout(rq);
> -	netdev_unlock(rq->netdev);
>  }
>  
>  static int mlx5e_alloc_mpwqe_rq_drop_page(struct mlx5e_rq *rq)
> @@ -1952,20 +1940,7 @@ void mlx5e_tx_err_cqe_work(struct work_struct *recover_work)
>  	struct mlx5e_txqsq *sq = container_of(recover_work, struct mlx5e_txqsq,
>  					      recover_work);
>  
> -	/* Recovering queues means re-enabling NAPI, which requires the netdev
> -	 * instance lock. However, SQ closing flows have to wait for work tasks
> -	 * to finish while also holding the netdev instance lock. So either get
> -	 * the lock or find that the SQ is no longer enabled and thus this work
> -	 * is not relevant anymore.
> -	 */
> -	while (!netdev_trylock(sq->netdev)) {
> -		if (!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state))
> -			return;
> -		msleep(20);
> -	}
> -
>  	mlx5e_reporter_tx_err_cqe(sq);
> -	netdev_unlock(sq->netdev);
>  }
>  
>  static struct dim_cq_moder mlx5e_get_def_tx_moderation(u8 cq_period_mode)
> @@ -5105,19 +5080,6 @@ static void mlx5e_tx_timeout_work(struct work_struct *work)
>  	struct net_device *netdev = priv->netdev;
>  	int i;
>  
> -	/* Recovering the TX queues implies re-enabling NAPI, which requires
> -	 * the netdev instance lock.
> -	 * However, channel closing flows have to wait for this work to finish
> -	 * while holding the same lock. So either get the lock or find that
> -	 * channels are being closed for other reason and this work is not
> -	 * relevant anymore.
> -	 */
> -	while (!netdev_trylock(netdev)) {
> -		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state))
> -			return;
> -		msleep(20);
> -	}
> -
>  	for (i = 0; i < netdev->real_num_tx_queues; i++) {
>  		struct netdev_queue *dev_queue =
>  			netdev_get_tx_queue(netdev, i);
> @@ -5130,8 +5092,6 @@ static void mlx5e_tx_timeout_work(struct work_struct *work)
>  		/* break if tried to reopened channels */
>  			break;
>  	}
> -
> -	netdev_unlock(netdev);
>  }
>  
>  static void mlx5e_tx_timeout(struct net_device *dev, unsigned int txqueue)

