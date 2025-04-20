Return-Path: <linux-rdma+bounces-9615-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD52A94830
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 17:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1883B14BD
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E03204581;
	Sun, 20 Apr 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cfv6guV1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7864D13FEE
	for <linux-rdma@vger.kernel.org>; Sun, 20 Apr 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745162800; cv=none; b=PDkwOg5C+aoXoUcZSS0Z7BjbNlD6yOaatLP5+z0H2u11zU5azBN7P6FEDv2EI0T90rD+mGLXvIFZ7zweX+fkRjdbzKbjA5dq6s5dLesjLZj77NRNYI3MegzuM6TWx6bQazs0BTnAj3i6ZEcc6eSU85QMGjsq4iX+nJ9SNeqZeQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745162800; c=relaxed/simple;
	bh=Jfczzd8CVTOIN9kF858iySCA+Qh5m5G+bOsDd6i3IfA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jfvK5uHcGaQyJWCsi0R3/2jWgmlI7dIiSGjt9n9mlo0BkjVN2CtLyxuKhGCkkJLickZbBagBHSleFjiesXhS6aMFPWUbpucV/9pBWdJpTAR7k2dvga6Vhf3J3B4T8We8TLBNz4gkCx1r561q+ipVOWDPEh1EouR/Z42yjgyB5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cfv6guV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DA0C4CEE2;
	Sun, 20 Apr 2025 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745162800;
	bh=Jfczzd8CVTOIN9kF858iySCA+Qh5m5G+bOsDd6i3IfA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Cfv6guV1eEBhGm7eSMllnxtqju8JHkBFfOWLBmKp7S1D9AmVCJwv3cE1IMJc9XrL9
	 Wuqejy1xFsS7i7vZnRmGS5lZ0Oaq3bm32bLs1usxW7ApQU98j70eSfWwCPv4HSP6CA
	 qTxCOvP4ilyZnddycNvhh99ULPJt/dOnYeKfMK6zESiIu9GEaktQLEiNiefaJccitX
	 FemvgdXRb1Auh0U/MlT7udEXnabTNa/VdU/8LMOvQ5BgPVLzcy07nkHYyOJaWVU1l2
	 2hR/SNI+/RbyWD+me1HZFWNBIDFapWtIjdewQDdH6u4gnOXn+/nibiPsFXjkaA+U/V
	 KBf0IQViZhXYw==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: syzbot+4edb496c3cad6e953a31@syzkaller.appspotmail.com
In-Reply-To: <20250419080741.1515231-1-yanjun.zhu@linux.dev>
References: <20250419080741.1515231-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix "trying to register non-static key
 in rxe_qp_do_cleanup" bug
Message-Id: <174516279738.722044.3994618859935049405.b4-ty@kernel.org>
Date: Sun, 20 Apr 2025 11:26:37 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sat, 19 Apr 2025 10:07:41 +0200, Zhu Yanjun wrote:
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  assign_lock_key kernel/locking/lockdep.c:986 [inline]
>  register_lock_class+0x4a3/0x4c0 kernel/locking/lockdep.c:1300
>  __lock_acquire+0x99/0x1ba0 kernel/locking/lockdep.c:5110
>  lock_acquire kernel/locking/lockdep.c:5866 [inline]
>  lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
>  __timer_delete_sync+0x152/0x1b0 kernel/time/timer.c:1644
>  rxe_qp_do_cleanup+0x5c3/0x7e0 drivers/infiniband/sw/rxe/rxe_qp.c:815
>  execute_in_process_context+0x3a/0x160 kernel/workqueue.c:4596
>  __rxe_cleanup+0x267/0x3c0 drivers/infiniband/sw/rxe/rxe_pool.c:232
>  rxe_create_qp+0x3f7/0x5f0 drivers/infiniband/sw/rxe/rxe_verbs.c:604
>  create_qp+0x62d/0xa80 drivers/infiniband/core/verbs.c:1250
>  ib_create_qp_kernel+0x9f/0x310 drivers/infiniband/core/verbs.c:1361
>  ib_create_qp include/rdma/ib_verbs.h:3803 [inline]
>  rdma_create_qp+0x10c/0x340 drivers/infiniband/core/cma.c:1144
>  rds_ib_setup_qp+0xc86/0x19a0 net/rds/ib_cm.c:600
>  rds_ib_cm_initiate_connect+0x1e8/0x3d0 net/rds/ib_cm.c:944
>  rds_rdma_cm_event_handler_cmn+0x61f/0x8c0 net/rds/rdma_transport.c:109
>  cma_cm_event_handler+0x94/0x300 drivers/infiniband/core/cma.c:2184
>  cma_work_handler+0x15b/0x230 drivers/infiniband/core/cma.c:3042
>  process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
>  process_scheduled_works kernel/workqueue.c:3319 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
>  kthread+0x3c2/0x780 kernel/kthread.c:464
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Fix "trying to register non-static key in rxe_qp_do_cleanup" bug
      https://git.kernel.org/rdma/rdma/c/1c7eec4d5f3b39

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


