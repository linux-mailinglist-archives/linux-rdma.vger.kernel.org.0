Return-Path: <linux-rdma+bounces-9311-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739C7A82ECB
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 20:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2049618957A9
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B31C2777E8;
	Wed,  9 Apr 2025 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeIVwdJa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C35D1C84A1
	for <linux-rdma@vger.kernel.org>; Wed,  9 Apr 2025 18:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744223574; cv=none; b=Xch1N0UGh0JklQdb58Rdrr5bOYNtsHuem+Nc2YPrc9KTYbqMAnf0reloRQ1OjFm8c2O6e/dJAKemzAdr9NUfdH6jLUW83NF1XR1e5cfkKYiW8RahSg3xu4T0vEjJ9jEaVdAx6eR3cx/wd2SUac9WynYTx9bqyBYwIeD3K70cDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744223574; c=relaxed/simple;
	bh=WUafLLG7+3ywyIYiQgaCIJXRfJ4iGf1pHWmhh3FcmAc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DEGNjJB9kaumikrzOHq8AFvkYv8B76Ac38uco0xwc8u+f7wmv5wjw54IubjUq99eovEHaNnU9wWC0SNrKI9bnpWn5v1Edj+Psgp61iUb5ZTeOS4MZ7z767jbmosizEm49xfZpj8FNQu4YF9bhRrkmfwmwLd4sLYL+HqBc61rRe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeIVwdJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E416C4CEE8;
	Wed,  9 Apr 2025 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744223573;
	bh=WUafLLG7+3ywyIYiQgaCIJXRfJ4iGf1pHWmhh3FcmAc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HeIVwdJa4XuWnrReiISPX5DbAeprGiD57o8+wq559x9dgyInK6jwy8FnstM477CYS
	 NiTImq1dl6Piv9gLCCVl3FJ2wL6aE4RrFDfmMCavMEXH3ErLUTBWBu9oYOV3KSV97o
	 MKHc2Xv81ajIg1qvMZudca7CIb4Fw59bp91g7A5gv1pElCQQnRu0JylI7fWPmxQYNT
	 gGJvQopsnuVYaqDAAvDc4ka+WhA7rE3EwUVE9etGaskDb//wur+kwRh8zWnJsMtEMg
	 MkLEKxTqYCOB0c1ln3shIkmBZ+K9jZnpqK7tcIqCDHuHd8kSfj8GhM89xGuhUtYZgG
	 UjgUc+axqDkDQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org
In-Reply-To: <c6cb92379de668be94894f49c2cfa40e73f94d56.1742388096.git.leonro@nvidia.com>
References: <c6cb92379de668be94894f49c2cfa40e73f94d56.1742388096.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Silence oversized kvmalloc()
 warning
Message-Id: <174422357006.407748.731847457328791611.b4-ty@kernel.org>
Date: Wed, 09 Apr 2025 14:32:50 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 19 Mar 2025 14:42:21 +0200, Leon Romanovsky wrote:
> syzkaller triggered an oversized kvmalloc() warning.
> Silence it by adding __GFP_NOWARN.
> 
> syzkaller log:
>  WARNING: CPU: 7 PID: 518 at mm/util.c:665 __kvmalloc_node_noprof+0x175/0x180
>  CPU: 7 UID: 0 PID: 518 Comm: c_repro Not tainted 6.11.0-rc6+ #6
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:__kvmalloc_node_noprof+0x175/0x180
>  RSP: 0018:ffffc90001e67c10 EFLAGS: 00010246
>  RAX: 0000000000000100 RBX: 0000000000000400 RCX: ffffffff8149d46b
>  RDX: 0000000000000000 RSI: ffff8881030fae80 RDI: 0000000000000002
>  RBP: 000000712c800000 R08: 0000000000000100 R09: 0000000000000000
>  R10: ffffc90001e67c10 R11: 0030ae0601000000 R12: 0000000000000000
>  R13: 0000000000000000 R14: 00000000ffffffff R15: 0000000000000000
>  FS:  00007fde79159740(0000) GS:ffff88813bdc0000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000020000180 CR3: 0000000105eb4005 CR4: 00000000003706b0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   ib_umem_odp_get+0x1f6/0x390
>   mlx5_ib_reg_user_mr+0x1e8/0x450
>   ib_uverbs_reg_mr+0x28b/0x440
>   ib_uverbs_write+0x7d3/0xa30
>   vfs_write+0x1ac/0x6c0
>   ksys_write+0x134/0x170
>   ? __sanitizer_cov_trace_pc+0x1c/0x50
>   do_syscall_64+0x50/0x110
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Silence oversized kvmalloc() warning
      https://git.kernel.org/rdma/rdma/c/9a0e6f15029e1a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


