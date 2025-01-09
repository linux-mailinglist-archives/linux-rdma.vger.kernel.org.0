Return-Path: <linux-rdma+bounces-6932-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92489A07D7F
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 17:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EED188C3B1
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B813C221DA6;
	Thu,  9 Jan 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmLzs+1z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724BD21C9EE;
	Thu,  9 Jan 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440159; cv=none; b=Lcn75o76Ff7RpnQ/D7mJLz8CTyu1LslKGQ5wIyprCUwerVwd2vkQKQv7u4g7ZmUsX467lzYUDBA6GsDfqWmAPU9y6xSTtKoXAg19psTWOkaw1zrDHXjguWxVmZ/dgUOCe11GwipKb0zqTopldYMW59/wdqaNwJYtZIVlrLttxFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440159; c=relaxed/simple;
	bh=OYw+w2MrOLYhD58fPp4ryNf8rh9JJfI3LCxVnUlJm0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvCAmHM/6XZPPkzePW/mSGxsYRFg6YTYrcAncbxIFJE94DDzDo54HssV41CcLfwwF059d7FePQVqfxyU7LpY2X9zrlF9Dt5SdAU4GJap6ubNznJUF9xZKGVQ/UsjZ5zU8/xcSkGfvecl4NCm1cMQkkN02vOwShqSmST3w3RuItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmLzs+1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92949C4CED2;
	Thu,  9 Jan 2025 16:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736440157;
	bh=OYw+w2MrOLYhD58fPp4ryNf8rh9JJfI3LCxVnUlJm0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TmLzs+1zsJ9RQwuSu2/QzPQVtzcLfPPJ/iqsBo9tVFLAlUCDvHe4xraUTP3n/WwbJ
	 FSstMcwtWrq7xdjMVNKXreP3EYTAY6e4thIzzTYcW2dlAKa3oE55KxlsQhepqGh/VF
	 9JqEEWeWQYZIhAjvgZW/yInv1nqFy6g7XXFvBeT+g9kNCb2AJSx0Myl5TXZei5bFpa
	 +xN6boJTTFNyUY5MyW3uGrNHHQgF7MGQPddqZDfTJc8kGacq1cOQHl3Xe47w05muVO
	 9IZbzdEFqFVXNvmocv3yuLkymCkCW663m4/Kyjd9uIlzBIXanQHkuPMYUzq5bhbJno
	 nNJilqezCI09Q==
Date: Thu, 9 Jan 2025 08:29:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Moshe Shemesh <moshe@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] net/mlx5: Fix variable not being completed when
 function returns
Message-ID: <20250109082915.3b011415@kernel.org>
In-Reply-To: <f6e79987-a48e-4546-b55e-ec95f7f0befe@gmail.com>
References: <20250108030009.68520-1-zhaochenguang@kylinos.cn>
	<f6e79987-a48e-4546-b55e-ec95f7f0befe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Jan 2025 15:25:36 +0200 Tariq Toukan wrote:
> >       mlx5_core 0000:01:00.0: cmd_work_handler:877:(pid 3880418): failed to allocate command entry
> >       INFO: task kworker/13:2:4055883 blocked for more than 120 seconds.
> >             Not tainted 4.19.90-25.44.v2101.ky10.aarch64 #1
> >       "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >       kworker/13:2    D    0 4055883      2 0x00000228
> >       Workqueue: events mlx5e_tx_dim_work [mlx5_core]
> >       Call trace:
> >        __switch_to+0xe8/0x150
> >        __schedule+0x2a8/0x9b8
> >        schedule+0x2c/0x88
> >        schedule_timeout+0x204/0x478
> >        wait_for_common+0x154/0x250
> >        wait_for_completion+0x28/0x38
> >        cmd_exec+0x7a0/0xa00 [mlx5_core]
> >        mlx5_cmd_exec+0x54/0x80 [mlx5_core]
> >        mlx5_core_modify_cq+0x6c/0x80 [mlx5_core]
> >        mlx5_core_modify_cq_moderation+0xa0/0xb8 [mlx5_core]
> >        mlx5e_tx_dim_work+0x54/0x68 [mlx5_core]
> >        process_one_work+0x1b0/0x448
> >        worker_thread+0x54/0x468
> >        kthread+0x134/0x138
> >        ret_from_fork+0x10/0x18
> > 
> >      Fixes: 485d65e13571 ("net/mlx5: Add a timeout to acquire the command queue semaphore")  
> 
> Also for the Fixes tag.
> 
> Other than that:
> Acked-by: Tariq Toukan <tariqt@nvidia.com>

rewritten the commit message and applied, thanks!

