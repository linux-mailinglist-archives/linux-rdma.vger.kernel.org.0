Return-Path: <linux-rdma+bounces-6729-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C130A9FBF0D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 15:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D58166860
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 14:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6511C5491;
	Tue, 24 Dec 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk+6EYpM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F4D1BD9DC;
	Tue, 24 Dec 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735049492; cv=none; b=AXf1LjarPewSshVAnLBNpqjo1QZ1z5Ut7ngiCF4fRb6+jO0pw9qUZFTNT8+jRL8y8S1w3ASzaQYmruRXrM+cmkHFcpYH+FLyhpmTzRMTR942Y6uCLDFIC1SAL4ENv96uBnlolPxMXiRsidg0z7HCiBm8KpgJsEjBP1IReUu6HaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735049492; c=relaxed/simple;
	bh=eYIGAzSIfGDGlaRSoQ/lPv7690qmuqmpbXYYcfMF3jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJUuFiJ7xqrwzq2gMFi64Xe2kVAInMzVNQAFE64vyYnZctZImY/i2akVmzqxdgZ6GBstJ5eTQF+5l+ZKbZ13DPLk0S/a9XvlNl9BxN8fJHafyewcyzKqf0tJmros1/qRtxbXN6PhlFPlZ5ink9glMsuYrhJI3r+pCyOG+hjU0xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk+6EYpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5672BC4CED0;
	Tue, 24 Dec 2024 14:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735049492;
	bh=eYIGAzSIfGDGlaRSoQ/lPv7690qmuqmpbXYYcfMF3jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dk+6EYpMcJ+RA8E9b0kP4cNz5Qn3T2eUIZpWMlXeuFAy+nWJE0u3eyyF5r8Se3+Or
	 nLwrKRyW+PPMpWSb5j8OMQfud8uKkboUzC6vwQyKF1m80fVJUOImJKdwoGKUsaSySb
	 b+o4mm4YIxLRLQyWGFnewT0Ay/U/TChhKHJVGcYjkdovi45rjlfLj0UUrsT8pO7b6p
	 FEudZ89eiUlciy0u9Mg6F9KP7wElx6DntYeptLuzb09Sd0nNZN2kBC0fd8HSJ/avCQ
	 UhCzx4Dw2dDzWGEogfLqy+G6eUl/uO4UHUJveXB2trzY7EmNlpQJKb4RY3SwrnG4yl
	 sIPztlzE4KipQ==
Date: Tue, 24 Dec 2024 16:11:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: jgg@ziepe.ca, cmeiohas@nvidia.com, michaelgur@nvidia.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] RDMA/iwpm: reentrant iwpm hello message
Message-ID: <20241224141127.GH171473@unreal>
References: <661ee85f.a4a2.193e4b2f91b.Coremail.linma@zju.edu.cn>
 <20241224092938.GC171473@unreal>
 <103c061b.e87e.193f84b0840.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <103c061b.e87e.193f84b0840.Coremail.linma@zju.edu.cn>

On Tue, Dec 24, 2024 at 06:51:27PM +0800, Lin Ma wrote:
> Hello Leon,
> 
> > 
> > I'm not fully understand the lockdep here. We use down_read(), which is
> > reentry safe.
> > 
> 
> Really? To my knowledge, though down_read() itself will not trigger locking
> errors. But below scenario will lead to deadlock, and that's why this
> WARNING is raised.
> 
>    CPU0                CPU1
>    ----                ----
> down_read()[1]
>                   down_write()[2]
> down_read()[3]
> 
> If CPU1 thread not exists, the CPU0 will run smoothly (However, it will keep
> looping and the PoC cannot be killed by any signal, causing Denial-of-Service).
> 
> When CPU1 calls down_write(), it will wait for [1] to be released.
> However, when [3] is called, it will then wait for [2] to be released,
> leading to a deadlock situation.
> 
> Please let me know if I understand this correctly or incorrectly?

The thing is that down_write() is called when we unregistering module
which sent netlink messages. It shouldn't happen.

Thanks

> 
> Thanks,
> Lin

