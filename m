Return-Path: <linux-rdma+bounces-5612-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22069B6300
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 13:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D631F216BC
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 12:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF091E906A;
	Wed, 30 Oct 2024 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDbP9o6L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997541E7C0C
	for <linux-rdma@vger.kernel.org>; Wed, 30 Oct 2024 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730290937; cv=none; b=Vb3Ns1CHQTc3bmiv3RpN4cjwu2gLeAzkUfKSNaNWX13bp2EuzCByKOGuYiDGzldApP90Bvts0PFzep0uDjNaLPBpa4ae+1/NZofPwRFT2v7WVF7MfZJl4ypFBCuWtfCm0EFU+GUqB3EMlf6S/UQbwB+csYX41zNOrMbb4MgCbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730290937; c=relaxed/simple;
	bh=BLPJNh4v4xd+u63ngN98n02U5/HlLvTz/4rio80g73k=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XihK592r6S0rDpOut/tPu0nvpQCcFPGW40wdSgRPP3vZ+W7qEyizre9wMO60NJ29IJyR0NA7HqtQ412kjCQHsoDh59kgMEJUqZCgSq/GSfpPsurfsoyZwnTYkcNY8w+yRNgFKwf/jz+U9UxfeuCQJqPGinOtZMqpSRZjYGuVsS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDbP9o6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89914C4CEE3;
	Wed, 30 Oct 2024 12:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730290937;
	bh=BLPJNh4v4xd+u63ngN98n02U5/HlLvTz/4rio80g73k=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=WDbP9o6L3Fcu+vrMMwGoZkfOcChhF5ae5JERqzgF4T66pKbMcWj4KSIqPyMDzrp65
	 N0ibc2VS9IHLzbbeV6a4TSMHucSwTa8D7wlo7jdSnrY8g34bquPhTrHI+Al0+8UyeD
	 Hcb/0av3FT5Bgz+WAhDVkO5Gq5XFnJvwLnpGiGy/BIVQANm4HC45nfxFLWhjJZ1WjI
	 9m8ZiD6Rv39lquloSBzg2itSzM1aXb/KyIwGCDGbsQ+TP8/gAMg3jj35ik4oz943UM
	 tvxJKcf9sk5OB0Uj+KRxGs7aPRY2o4MBepPPOLQXK7f7dp7SV2oJLk87W0U8R9wdp5
	 Ih28CTWpNmTZw==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241025152036.121417-1-yanjun.zhu@linux.dev>
References: <20241025152036.121417-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix the qp flush warnings in req
Message-Id: <173029093335.61569.13915684466075750846.b4-ty@kernel.org>
Date: Wed, 30 Oct 2024 14:22:13 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 25 Oct 2024 17:20:36 +0200, Zhu Yanjun wrote:
> When the qp is in error state, the status of WQEs in the queue should be
> set to error. Or else the following will appear.
> 
> [  920.617269] WARNING: CPU: 1 PID: 21 at drivers/infiniband/sw/rxe/rxe_comp.c:756 rxe_completer+0x989/0xcc0 [rdma_rxe]
> [  920.617744] Modules linked in: rnbd_client(O) rtrs_client(O) rtrs_core(O) rdma_ucm rdma_cm iw_cm ib_cm crc32_generic rdma_rxe ip6_udp_tunnel udp_tunnel ib_uverbs ib_core loop brd null_blk ipv6
> [  920.618516] CPU: 1 PID: 21 Comm: ksoftirqd/1 Tainted: G           O       6.1.113-storage+ #65
> [  920.618986] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [  920.619396] RIP: 0010:rxe_completer+0x989/0xcc0 [rdma_rxe]
> [  920.619658] Code: 0f b6 84 24 3a 02 00 00 41 89 84 24 44 04 00 00 e9 2a f7 ff ff 39 ca bb 03 00 00 00 b8 0e 00 00 00 48 0f 45 d8 e9 15 f7 ff ff <0f> 0b e9 cb f8 ff ff 41 bf f5 ff ff ff e9 08 f8 ff ff 49 8d bc 24
> [  920.620482] RSP: 0018:ffff97b7c00bbc38 EFLAGS: 00010246
> [  920.620817] RAX: 0000000000000000 RBX: 000000000000000c RCX: 0000000000000008
> [  920.621183] RDX: ffff960dc396ebc0 RSI: 0000000000005400 RDI: ffff960dc4e2fbac
> [  920.621548] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffffac406450
> [  920.621884] R10: ffffffffac4060c0 R11: 0000000000000001 R12: ffff960dc4e2f800
> [  920.622254] R13: ffff960dc4e2f928 R14: ffff97b7c029c580 R15: 0000000000000000
> [  920.622609] FS:  0000000000000000(0000) GS:ffff960ef7d00000(0000) knlGS:0000000000000000
> [  920.622979] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  920.623245] CR2: 00007fa056965e90 CR3: 00000001107f1000 CR4: 00000000000006e0
> [  920.623680] Call Trace:
> [  920.623815]  <TASK>
> [  920.623933]  ? __warn+0x79/0xc0
> [  920.624116]  ? rxe_completer+0x989/0xcc0 [rdma_rxe]
> [  920.624356]  ? report_bug+0xfb/0x150
> [  920.624594]  ? handle_bug+0x3c/0x60
> [  920.624796]  ? exc_invalid_op+0x14/0x70
> [  920.624976]  ? asm_exc_invalid_op+0x16/0x20
> [  920.625203]  ? rxe_completer+0x989/0xcc0 [rdma_rxe]
> [  920.625474]  ? rxe_completer+0x329/0xcc0 [rdma_rxe]
> [  920.625749]  rxe_do_task+0x80/0x110 [rdma_rxe]
> [  920.626037]  rxe_requester+0x625/0xde0 [rdma_rxe]
> [  920.626310]  ? rxe_cq_post+0xe2/0x180 [rdma_rxe]
> [  920.626583]  ? do_complete+0x18d/0x220 [rdma_rxe]
> [  920.626812]  ? rxe_completer+0x1a3/0xcc0 [rdma_rxe]
> [  920.627050]  rxe_do_task+0x80/0x110 [rdma_rxe]
> [  920.627285]  tasklet_action_common.constprop.0+0xa4/0x120
> [  920.627522]  handle_softirqs+0xc2/0x250
> [  920.627728]  ? sort_range+0x20/0x20
> [  920.627942]  run_ksoftirqd+0x1f/0x30
> [  920.628158]  smpboot_thread_fn+0xc7/0x1b0
> [  920.628334]  kthread+0xd6/0x100
> [  920.628504]  ? kthread_complete_and_exit+0x20/0x20
> [  920.628709]  ret_from_fork+0x1f/0x30
> [  920.628892]  </TASK>
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Fix the qp flush warnings in req
      https://git.kernel.org/rdma/rdma/c/ea4c990fa9e19f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


