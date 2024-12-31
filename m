Return-Path: <linux-rdma+bounces-6773-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0163A9FEFBE
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2024 14:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C09207A057C
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2024 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2445E196D90;
	Tue, 31 Dec 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rg5ChQdU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C8B19CD1B;
	Tue, 31 Dec 2024 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735651591; cv=none; b=LaUg7grF7Zyw5JCK7mxbCittLbYgvr5oxRL62ugi6WhRSlIPlP1pd/ZhoBQid+OghLcfRCufr4SY9440SsMhu6KhZMMf13eQ0VfMTfiI67dSAy0ri5LXGrRH4QxrjVCTws7Acw5KmRmkcykvdI0hiv5IfYLsE5PV6dIN8BpR4mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735651591; c=relaxed/simple;
	bh=r5UvqoEad6R+Hjg0ebLc+U3SWBci4S/eO/PhP1PjWDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SQU5JrlOlBBVpD9pR9mYyTp6V2k6hZpd6LfZ3sNQW6ow7vjnciCZlfZ26chVVXe8HRmHUAvJlIbfaPMSszZ/b1qzYEWcI1Y81mZuC7nve2S5GVRs5HgOKN/bkdeIGKH8sLd9iacpj85sDD7df6tq10nTnuoLyMT3Pquq6S9vqtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rg5ChQdU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B0EC4CED7;
	Tue, 31 Dec 2024 13:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735651591;
	bh=r5UvqoEad6R+Hjg0ebLc+U3SWBci4S/eO/PhP1PjWDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Rg5ChQdU4kBs/sOt6bmoYfAPsycaNSATuh0SHgXkiwFpro0790GTlsA7NL7sYcReQ
	 +N4GhWsZf74oGaq7zp7i9SiRR6401i8UlGgPCNQQEHhe3YcRuQsEhJMp15JmtlRN+N
	 1iXSDJvz3aDqLJom8QzNg/fTVANJaBaiy+xTUwADFm+scQEo9+/1Zd/epsjg8/w/Ry
	 K3VNq9k4ogRtscwYYkUosI1AwE79GCVW7UPde9RU1acrgnx/BwYu2c6FbUOKbxsmZk
	 dewMfi0NEv9xTg4nI3yF6JnhcFe6NTf/Sh9dN5S2wtd3V+7jLyTIdT0nItOm/6At6e
	 YCXdfirQ0NmKQ==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Cc: haris.iqbal@ionos.com, Jack Wang <jinpu.wang@ionos.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
 Zhu Yanjun <zyjzyj2000@gmail.com>, shinichiro.kawasaki@wdc.com
In-Reply-To: <20241231013416.1290920-1-lizhijian@fujitsu.com>
References: <20241231013416.1290920-1-lizhijian@fujitsu.com>
Subject: Re: [PATCH] RDMA/rtrs: server: Ensure 'ib_sge list' is accessible
Message-Id: <173565158807.103567.13486575461708378140.b4-ty@kernel.org>
Date: Tue, 31 Dec 2024 08:26:28 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 31 Dec 2024 09:34:16 +0800, Li Zhijian wrote:
> Move the declaration of the 'ib_sge list' variable outside the
> 'always_invalidate' block to ensure it remains accessible for use
> throughout the function.
> 
> Previously, 'ib_sge list' was declared within the 'always_invalidate'
> block, limiting its accessibility, then caused a
> 'BUG: kernel NULL pointer dereference'[1].
>  ? __die_body.cold+0x19/0x27
>  ? page_fault_oops+0x15a/0x2d0
>  ? search_module_extables+0x19/0x60
>  ? search_bpf_extables+0x5f/0x80
>  ? exc_page_fault+0x7e/0x180
>  ? asm_exc_page_fault+0x26/0x30
>  ? memcpy_orig+0xd5/0x140
>  rxe_mr_copy+0x1c3/0x200 [rdma_rxe]
>  ? rxe_pool_get_index+0x4b/0x80 [rdma_rxe]
>  copy_data+0xa5/0x230 [rdma_rxe]
>  rxe_requester+0xd9b/0xf70 [rdma_rxe]
>  ? finish_task_switch.isra.0+0x99/0x2e0
>  rxe_sender+0x13/0x40 [rdma_rxe]
>  do_task+0x68/0x1e0 [rdma_rxe]
>  process_one_work+0x177/0x330
>  worker_thread+0x252/0x390
>  ? __pfx_worker_thread+0x10/0x10
> 
> [...]

Applied, thanks!

[1/1] RDMA/rtrs: server: Ensure 'ib_sge list' is accessible
      https://git.kernel.org/rdma/rdma/c/bc0f6099b7c272

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


