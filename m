Return-Path: <linux-rdma+bounces-8232-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 186B2A4B165
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 13:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD25816CC6F
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Mar 2025 12:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB7B1DC07D;
	Sun,  2 Mar 2025 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKPhAY2g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38E4C85;
	Sun,  2 Mar 2025 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740917233; cv=none; b=HBKx/9dise6SvPd/IwPTXbJyPJ9uJY2Im/YRQKssAmsrhC7jfNw+hi3/gDm66CPmG27kcYRf7prSJYYkAnrTj4w9UbPcg0s+LgxghO+zWtr5pyOrwaEKLf3Nv5L9Pb98vEHIw/WVmmBAuUUFZ+wguYGeGmkzlLR/BQ6EVp5k7dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740917233; c=relaxed/simple;
	bh=/RSBfQEI2zdhlk9ejfT59kdi9zLXsGuCWOXvxKkgj6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dfztuAj6tMdfEec5HRgL4al4xR6m5uIIxu+mOaZ+w++tQQSgVtgv/MAC9MVkZOmPNxH/+csLQhpnwms9EgogNRWyfEs0OtcENsVy32+HFjlp1priKy7/3KGdyUUlaS1c/PWeW2Eg5PJiv/sqSMZlXiIX4xclWBlpBaQg4MCD0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKPhAY2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAB0C4CED6;
	Sun,  2 Mar 2025 12:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740917233;
	bh=/RSBfQEI2zdhlk9ejfT59kdi9zLXsGuCWOXvxKkgj6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WKPhAY2gIEL3spzazA+gsqb3n18Uw4oProuVSqIsp/3j34ZlFa/hxcLX+FVS/mJ0/
	 7SAdeurCPP7dA2K0nAzomEl7hGAtBuiVvXFOnzvQJIhZ9qMvB0zb0PAB2CgA21MWSF
	 6XCkZj4l6i/v6Hf9hrqaIuMd5iZdaK0pJgeMijnnN+JGbZpHYwoRaFk5+eK6ekSbqy
	 VNB5qt4RTzEX3GRiINwb7bvvd0LgzhS83GbSEADKTHpf5e46ebxkVYescknRTG5iuN
	 37jf2pPJQxfHCeyBE40y5SwqjIFlvaLkYO4Y3jMOhG4s4b/fAzEM9x0xiKM2f2HHOc
	 iYyL6WePMG0mg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Parav Pandit <parav@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250227165420.3430301-1-roman.gushchin@linux.dev>
References: <20250227165420.3430301-1-roman.gushchin@linux.dev>
Subject: Re: [PATCH] RDMA/core: don't expose hw_counters outside of init
 net namespace
Message-Id: <174091722955.677839.2203678675814984398.b4-ty@kernel.org>
Date: Sun, 02 Mar 2025 07:07:09 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 27 Feb 2025 16:54:20 +0000, Roman Gushchin wrote:
> Commit 467f432a521a ("RDMA/core: Split port and device counter sysfs
> attributes") accidentally almost exposed hw counters to non-init net
> namespaces. It didn't expose them fully, as an attempt to read any of
> those counters leads to a crash like this one:
> 
> [42021.807566] BUG: kernel NULL pointer dereference, address: 0000000000000028
> [42021.814463] #PF: supervisor read access in kernel mode
> [42021.819549] #PF: error_code(0x0000) - not-present page
> [42021.824636] PGD 0 P4D 0
> [42021.827145] Oops: 0000 [#1] SMP PTI
> [42021.830598] CPU: 82 PID: 2843922 Comm: switchto-defaul Kdump: loaded Tainted: G S      W I        XXX
> [42021.841697] Hardware name: XXX
> [42021.849619] RIP: 0010:hw_stat_device_show+0x1e/0x40 [ib_core]
> [42021.855362] Code: 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 49 89 d0 4c 8b 5e 20 48 8b 8f b8 04 00 00 48 81 c7 f0 fa ff ff <48> 8b 41 28 48 29 ce 48 83 c6 d0 48 c1 ee 04 69 d6 ab aa aa aa 48
> [42021.873931] RSP: 0018:ffff97fe90f03da0 EFLAGS: 00010287
> [42021.879108] RAX: ffff9406988a8c60 RBX: ffff940e1072d438 RCX: 0000000000000000
> [42021.886169] RDX: ffff94085f1aa000 RSI: ffff93c6cbbdbcb0 RDI: ffff940c7517aef0
> [42021.893230] RBP: ffff97fe90f03e70 R08: ffff94085f1aa000 R09: 0000000000000000
> [42021.900294] R10: ffff94085f1aa000 R11: ffffffffc0775680 R12: ffffffff87ca2530
> [42021.907355] R13: ffff940651602840 R14: ffff93c6cbbdbcb0 R15: ffff94085f1aa000
> [42021.914418] FS:  00007fda1a3b9700(0000) GS:ffff94453fb80000(0000) knlGS:0000000000000000
> [42021.922423] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [42021.928130] CR2: 0000000000000028 CR3: 00000042dcfb8003 CR4: 00000000003726f0
> [42021.935194] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [42021.942257] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [42021.949324] Call Trace:
> [42021.951756]  <TASK>
> [42021.953842]  [<ffffffff86c58674>] ? show_regs+0x64/0x70
> [42021.959030]  [<ffffffff86c58468>] ? __die+0x78/0xc0
> [42021.963874]  [<ffffffff86c9ef75>] ? page_fault_oops+0x2b5/0x3b0
> [42021.969749]  [<ffffffff87674b92>] ? exc_page_fault+0x1a2/0x3c0
> [42021.975549]  [<ffffffff87801326>] ? asm_exc_page_fault+0x26/0x30
> [42021.981517]  [<ffffffffc0775680>] ? __pfx_show_hw_stats+0x10/0x10 [ib_core]
> [42021.988482]  [<ffffffffc077564e>] ? hw_stat_device_show+0x1e/0x40 [ib_core]
> [42021.995438]  [<ffffffff86ac7f8e>] dev_attr_show+0x1e/0x50
> [42022.000803]  [<ffffffff86a3eeb1>] sysfs_kf_seq_show+0x81/0xe0
> [42022.006508]  [<ffffffff86a11134>] seq_read_iter+0xf4/0x410
> [42022.011954]  [<ffffffff869f4b2e>] vfs_read+0x16e/0x2f0
> [42022.017058]  [<ffffffff869f50ee>] ksys_read+0x6e/0xe0
> [42022.022073]  [<ffffffff8766f1ca>] do_syscall_64+0x6a/0xa0
> [42022.027441]  [<ffffffff8780013b>] entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: don't expose hw_counters outside of init net namespace
      https://git.kernel.org/rdma/rdma/c/57b9340c0728b0

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


