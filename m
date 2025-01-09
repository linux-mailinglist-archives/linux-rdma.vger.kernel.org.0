Return-Path: <linux-rdma+bounces-6933-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58F8A07D8A
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 17:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644FC188C58B
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FED5223311;
	Thu,  9 Jan 2025 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yc21FMUB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A5223302;
	Thu,  9 Jan 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440212; cv=none; b=W8HBzn77WB34xho6JenPIBtWLyyHsNBPoWF4/tRAbOBeMIld0aGEcdZdm+l9Dr5+fOggRemiZY/3GEadNiwS+h+56Fctjf7WH0jK6xtmPq5RVPUlsqR82tMSRWL2hcYqvJdyaYj39EsyGOmYH9l4dqWC9+BLHrUzyvyAmEE8IwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440212; c=relaxed/simple;
	bh=+ABfs5MDsTiHH5RwjEhf7ASlD/roZQ+NOq40W0NncDI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=somhufHingNH7A8TonGAb1s/ceABnvdrDssFnDz/HLmw3YyOlwl7FjS6RD53DMQ5RXZ7SFbvJTi2zKYPPloKiSEawWKhQz+ZjpwgNkebtnwT1UMzv6T8txlhgRti3ZjNuB/bh2qZrMtLnpOckog6L2cXipjUvdd16XpJOxANaxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc21FMUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EAAC4CED6;
	Thu,  9 Jan 2025 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736440212;
	bh=+ABfs5MDsTiHH5RwjEhf7ASlD/roZQ+NOq40W0NncDI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yc21FMUBahEmS6Z1A2/59o3LfqpyM2rc/vzmrilvZshJx+bMSHRiaCU6duk+3dft0
	 KO2MlbeDUFamtXfEO+14sfaOI/x9QzGBBBssS/80jp9hxLAHX8YePejLEum8t4F+8I
	 8HgePugyUhDCW+l4E9oGPVfMAG9JI3ZebATrM1jzJnpFqtVMRRa+lvGOP5W3Y2okQa
	 ixWr+LOQV6ecGjPCyiObk2VBXa5z3SvQreIMNXNM8vSqAia/A8A8LH+AuV63WhodZS
	 tnoLHzKqxL6DrJZQVSKIcv/HCQI+UxlC5J+erjGK1Ap4d+fQC1e50ahsqcqKTW9Dnp
	 WZWkeFm38DEnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E0E3805DB2;
	Thu,  9 Jan 2025 16:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net/mlx5: Fix variable not being completed when function
 returns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173644023374.1439025.12349410132405031646.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 16:30:33 +0000
References: <20250108030009.68520-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20250108030009.68520-1-zhaochenguang@kylinos.cn>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, moshe@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Jan 2025 11:00:09 +0800 you wrote:
> The cmd_work_handler function returns from the child function
>     cmd_alloc_index because the allocate command entry fails,
>     Before returning, there is no complete ent->slotted.
> 
>     The patch fixes it.
> 
>      mlx5_core 0000:01:00.0: cmd_work_handler:877:(pid 3880418): failed to allocate command entry
>      INFO: task kworker/13:2:4055883 blocked for more than 120 seconds.
>            Not tainted 4.19.90-25.44.v2101.ky10.aarch64 #1
>      "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>      kworker/13:2    D    0 4055883      2 0x00000228
>      Workqueue: events mlx5e_tx_dim_work [mlx5_core]
>      Call trace:
>       __switch_to+0xe8/0x150
>       __schedule+0x2a8/0x9b8
>       schedule+0x2c/0x88
>       schedule_timeout+0x204/0x478
>       wait_for_common+0x154/0x250
>       wait_for_completion+0x28/0x38
>       cmd_exec+0x7a0/0xa00 [mlx5_core]
>       mlx5_cmd_exec+0x54/0x80 [mlx5_core]
>       mlx5_core_modify_cq+0x6c/0x80 [mlx5_core]
>       mlx5_core_modify_cq_moderation+0xa0/0xb8 [mlx5_core]
>       mlx5e_tx_dim_work+0x54/0x68 [mlx5_core]
>       process_one_work+0x1b0/0x448
>       worker_thread+0x54/0x468
>       kthread+0x134/0x138
>       ret_from_fork+0x10/0x18
> 
> [...]

Here is the summary with links:
  - [v2] net/mlx5: Fix variable not being completed when function returns
    https://git.kernel.org/netdev/net/c/0e2909c6bec9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



