Return-Path: <linux-rdma+bounces-4862-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E124E9738D2
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 15:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998111F25D3D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 13:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409F71922F6;
	Tue, 10 Sep 2024 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVolWiYk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0114414F12C
	for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975696; cv=none; b=ReFxopj0G2fzvqzr9Atfj4BbGlsgdORrXD/PYbxA+/CDdmcwmNGKffcu2fo11p4xGvqbX9SMJ6SBITRxRMIaLqzcipLqDVmTH9pHraLFtOoI1n4Xv72u+K9D7tBQi9LkM3IeMlX6uE7xLxVwyfIdTxPDvUoYbB48gS5J2Ge8hcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975696; c=relaxed/simple;
	bh=VAvi8ritMA2J0jyT0oZTLRDWsIt1RyYW5hrqcSniR5g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RQ1FoBzb1OdsJnobboFY9UQSOkH4WhhWZfGX28Ii71lqnQG700RLOzFIyV7P4m1nTLmJUHvHBZCkOLoT7Hu1BK8oH+tsJuENlDc4Jr5F+0s+6mZq/iXzqa8d9iqqf514KGtUwPxX2/dEu5fUVnKYn28g+uOGcIrAlwMxWet2A0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVolWiYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EB6C4CEC3;
	Tue, 10 Sep 2024 13:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725975695;
	bh=VAvi8ritMA2J0jyT0oZTLRDWsIt1RyYW5hrqcSniR5g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bVolWiYkyiTgl/yPs3AojxUOHZ9gc5DDaruz4f8PTNCitI8vXXFurZyn5pDd3CZvX
	 LOX2CpxnPi8ta62KBq3b1oNo+oIOmedvCGXcyTZH/n+LrWPCcjAH5AvB9DULyVtmyF
	 aXuHNWxjEQ2uEDX3dwEXPhe6QeVsXjGt+O50wAVztRz7B2Gz7c9sI/J9CA4ZEKhzKt
	 v6E8RdJklKY44yROmaI0jt3GeegC7mXL6qxbLk6Tt3DHhxRFvqmXUwIF6bZJY0GHwp
	 UewI8LtL0+CiG3SVPvVdRMhNez6Fp5LC8fz4RxxNdjlCtJgBIC0fXcIb6IxwX+xTFc
	 QzkkzUTgFmuXg==
From: Leon Romanovsky <leon@kernel.org>
To: sagi@grimberg.me, mgurtovoy@nvidia.com, jgg@ziepe.ca, 
 linux-rdma@vger.kernel.org, dennis.dalessandro@cornelisnetworks.com, 
 Zhang Zekun <zhangzekun11@huawei.com>
Cc: chenjun102@huawei.com
In-Reply-To: <20240909121408.80079-1-zhangzekun11@huawei.com>
References: <20240909121408.80079-1-zhangzekun11@huawei.com>
Subject: Re: [PATCH v2 0/2] Remove unused declarations in header files
Message-Id: <172597569066.3394624.13683501522235760185.b4-ty@kernel.org>
Date: Tue, 10 Sep 2024 16:41:30 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 09 Sep 2024 20:14:06 +0800, Zhang Zekun wrote:
> There are some unused declarations in the header files,
> let's remove them.
> 
> v2: Fix the spelling error in patch subject of patch [1/2]
> 
> Zhang Zekun (2):
>   IB/iser: Remove unused declaration in header file
>   IB/qib: Remove unused declarations in header file
> 
> [...]

Applied, thanks!

[1/2] IB/iser: Remove unused declaration in header file
      https://git.kernel.org/rdma/rdma/c/e4ed570122544d
[2/2] IB/qib: Remove unused declarations in header file
      https://git.kernel.org/rdma/rdma/c/9cd30319bbd497

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


