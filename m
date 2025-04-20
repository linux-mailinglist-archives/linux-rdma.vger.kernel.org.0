Return-Path: <linux-rdma+bounces-9607-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24700A9476A
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 12:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88031892E17
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 10:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0971E4110;
	Sun, 20 Apr 2025 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krHzJKYf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD412647
	for <linux-rdma@vger.kernel.org>; Sun, 20 Apr 2025 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745143880; cv=none; b=s+f0uLiurT8iP+E5jtcCRs5Mi+9BvXRX4py5hksvJ+ikqFDtAtA93zQc9XQ9nOMrQztymCMaKPSgctCzsMsEklYWGsNXNCwXZ7YB3JkC7HSlVOt6+kxCcZOosFdw6FtP4ehzSUe7DoUxBHj7MwEa3kWWeVcPytsedqA33oOkqbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745143880; c=relaxed/simple;
	bh=rB0tTNzyP8EiD8+782moP4S5TiFHnAGMSz1ldKBL7B8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XzaVjA0rS7OuckfFXCoKwmL+6qa1igwmkvj0Ya4QRZsJzzWytowl7Up5P5JLxSNXr3PPMkQBZe4qfyxjxzI21bV6yh3rmceBe8fT52hzeMThT8GATFGFn6tyIAO5WcB5/DTX5rnM4tCt9vUJ9qlH1ptVUOO/as9hKa6QZyE1/30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krHzJKYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3191C4CEE2;
	Sun, 20 Apr 2025 10:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745143879;
	bh=rB0tTNzyP8EiD8+782moP4S5TiFHnAGMSz1ldKBL7B8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=krHzJKYfE+ATwVkM/swnvqJLXOCaHwvuLojF4N7F3DfH2rQIE6YE3NhAfDxqrryzc
	 nX1+dtdNO9zsKk0KQBqrNQA583ChjyhGvyysrRr0OzMVlXaOGqW6xbK/2d8AmagBF8
	 EdcWs6jAxcQoybZ40FVDGGsi0FxHku/T/p2KhF2XjucGqXIk4yb6GDqC1R5m0wNhje
	 72DHzHwpdJrOgKQwd4dYbhpUaHKX8r63YtoUu8KtGQ8zFeNp9CiT4N1jXDpoVydZy6
	 IkbDCkZEJexNF6jTxNnoEdEx0QAeZT/G4OwjyzVUhduoIV7Mqdt4h/WcOvm4WPyuF+
	 2Yr6oGpMribqQ==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: liuyi <liuy22@mails.tsinghua.edu.cn>
In-Reply-To: <20250412075714.3257358-1-yanjun.zhu@linux.dev>
References: <20250412075714.3257358-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix slab-use-after-free Read in
 rxe_queue_cleanup bug
Message-Id: <174514387559.677485.4728370832966108117.b4-ty@kernel.org>
Date: Sun, 20 Apr 2025 06:11:15 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sat, 12 Apr 2025 09:57:14 +0200, Zhu Yanjun wrote:
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x7d/0xa0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xcf/0x610 mm/kasan/report.c:489
>  kasan_report+0xb5/0xe0 mm/kasan/report.c:602
>  rxe_queue_cleanup+0xd0/0xe0 drivers/infiniband/sw/rxe/rxe_queue.c:195
>  rxe_cq_cleanup+0x3f/0x50 drivers/infiniband/sw/rxe/rxe_cq.c:132
>  __rxe_cleanup+0x168/0x300 drivers/infiniband/sw/rxe/rxe_pool.c:232
>  rxe_create_cq+0x22e/0x3a0 drivers/infiniband/sw/rxe/rxe_verbs.c:1109
>  create_cq+0x658/0xb90 drivers/infiniband/core/uverbs_cmd.c:1052
>  ib_uverbs_create_cq+0xc7/0x120 drivers/infiniband/core/uverbs_cmd.c:1095
>  ib_uverbs_write+0x969/0xc90 drivers/infiniband/core/uverbs_main.c:679
>  vfs_write fs/read_write.c:677 [inline]
>  vfs_write+0x26a/0xcc0 fs/read_write.c:659
>  ksys_write+0x1b8/0x200 fs/read_write.c:731
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xaa/0x1b0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Fix slab-use-after-free Read in rxe_queue_cleanup bug
      https://git.kernel.org/rdma/rdma/c/c95366ddbe99ba

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


