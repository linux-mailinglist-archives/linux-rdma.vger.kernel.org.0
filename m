Return-Path: <linux-rdma+bounces-11617-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD0CAE78FB
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 09:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493DD17EE14
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 07:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145BC1F463C;
	Wed, 25 Jun 2025 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMX1ag66"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70C41E47CC
	for <linux-rdma@vger.kernel.org>; Wed, 25 Jun 2025 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750837520; cv=none; b=UwPr27ofeyW5ZLdv2fXlXHhARCKtnOK5DXeAdQyfqRUl5SNGhoyZ1N3JLg0e+siF1zd0HaV1arL08LfpVMPzNVZpdxioHqILr+D9arYrdY+Hgm/QwaqDsOENHkdfW6GC6D+pDbM1AOj4qPBTS7l4pNF07iqjcREF/s2zjKyg9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750837520; c=relaxed/simple;
	bh=yVirwgGezba+qAbk07q451he48GlcEZclQgk4eAQrqs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MjmF+RAAQj60thTEklREoYlr/3dWpuhgXr+lCcT7hWBZ1RDQAMA7yNQvCCBjFOkGsIZqDWlp/o2jMgtGDDp+5HGxjTyvE4NRvW1QOSmzOWU8BEMcHdn8RosdPRTCy0+NkAm/3CZ5mRQH1g5GLSJrqLHpVU9mHP85700FBWesau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMX1ag66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED68DC4CEEA;
	Wed, 25 Jun 2025 07:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750837518;
	bh=yVirwgGezba+qAbk07q451he48GlcEZclQgk4eAQrqs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DMX1ag66UHosZVBAyA/P5Mk52ae/EDPuVrHGcktc0CiSBZuuAq56E/7zZeGOYODfw
	 oiwsZRJ5KQNAzsc3Jvx1IzXI8AjR1uD4IUCZAQJl5pzZ4xvn6BWrCdlwngfaK6zv5H
	 CE58KQ0YUIolk6DjWYVA6vhomBdg5ABUTvEccsnP9ykYdyxw2opC5+bepUJeYPi7Br
	 mq/dV9tF38eS9qqD6Zp0c/CoSrKzlW5r14Rlj4+jWXEvNs+vRf3EflllcCmGk0p9+x
	 rE99zNGIcmo/ksx0nJGsd6FuVz8fQe67vVaSko3TdaAgHTtPIOYQvqggeH4TGnI3YJ
	 Kb30s8sBHa4vA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Or Har-Toov <ohartoov@nvidia.com>, 
 Artemy Kovalyov <artemyko@nvidia.com>, linux-rdma@vger.kernel.org, 
 Michael Guralnik <michaelgur@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <3c8f225a8a9fade647d19b014df1172544643e4a.1750061612.git.leon@kernel.org>
References: <3c8f225a8a9fade647d19b014df1172544643e4a.1750061612.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc] IB/mlx5: Fix potential deadlock in MR
 deregistration
Message-Id: <175083751479.552151.9912992549513283361.b4-ty@kernel.org>
Date: Wed, 25 Jun 2025 03:45:14 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 16 Jun 2025 11:14:09 +0300, Leon Romanovsky wrote:
> The issue arises when kzalloc() is invoked while holding umem_mutex or
> any other lock acquired under umem_mutex. This is problematic because
> kzalloc() can trigger fs_reclaim_aqcuire(), which may, in turn, invoke
> mmu_notifier_invalidate_range_start(). This function can lead to
> mlx5_ib_invalidate_range(), which attempts to acquire umem_mutex again,
> resulting in a deadlock.
> 
> [...]

Applied, thanks!

[1/1] IB/mlx5: Fix potential deadlock in MR deregistration
      https://git.kernel.org/rdma/rdma/c/2ed25aa7f7711f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


