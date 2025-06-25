Return-Path: <linux-rdma+bounces-11618-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847D3AE78FC
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 09:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED27B17DEB6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 07:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF22A2046BA;
	Wed, 25 Jun 2025 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APxkGVBy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E11F9406
	for <linux-rdma@vger.kernel.org>; Wed, 25 Jun 2025 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750837523; cv=none; b=lFQYLaKMBxTPzyWe5f0t1oz7Je8zu25dCa1sQrUejT3N1ohBViLT7f2/Rak4x0ewIDj5JGPlIem6py5E0Z3ZVNi64SIFuOnlrzi+2z7byX2a7cZpD5kBSnSRgeJ5vetihI8eD/U1YVkY4r+DUgOuvLnJKN/FKC262Bh2Xqgmg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750837523; c=relaxed/simple;
	bh=VzWcHcqe7SYzZ6DCOl/d7HWFLzqUuPC9ajNLD0ZQM54=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=spAP0uU/o1fTghN7yppat95smfNthFR//m3wQcg7kjNOrsYk7GDuhYyKbtyk5LDZuhIfGluLNEHaZ6QjsBkZ4lBAj+2+JhPxQJRH8efOxghQ0VHtqfOI1MR5QtE7aKCvfPEpXwiQ0w7+z4hriwG233lnE86G3PputVHvxHhswHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APxkGVBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A30C4CEEA;
	Wed, 25 Jun 2025 07:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750837523;
	bh=VzWcHcqe7SYzZ6DCOl/d7HWFLzqUuPC9ajNLD0ZQM54=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=APxkGVBy9L6UpvfcTR0jA2VbAACE0RhV3LmcevUw107klCssZRJoL0No1FAEhCjIG
	 Sa0qnOi+ZwpW91hyLBbpYnaOyGwcrjYzLBkLelRTm9BiiEhZ00K29lPynKmrKH2et5
	 ijLkOvtbHQITkJHTT9rcHWkPbjPbLNiUQpmJb7nan86eMnfYDWK1XxaJPj3NjkBaxc
	 JVF3Hsb7nSA0/vreWYDYfJkdNydIVFNLXfq8a+1Gg9414jMxAtGsN+YY2RzRplrXO1
	 Rz1Qw5kgghpFqobEnS6N2JniotFdtLKc1otb+tcIFF8ZFK+yfTqtnLsKGuwH2Ua9gn
	 gZKCLffc2/pgg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Or Har-Toov <ohartoov@nvidia.com>, linux-rdma@vger.kernel.org, 
 Michael Guralnik <michaelgur@nvidia.com>
In-Reply-To: <9d31b9d8fe1db648a9f47cec3df6b8463319dee5.1750061698.git.leon@kernel.org>
References: <9d31b9d8fe1db648a9f47cec3df6b8463319dee5.1750061698.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc] IB/core: Annotate umem_mutex acquisition under
 fs_reclaim for lockdep
Message-Id: <175083751878.552151.13689394188848442455.b4-ty@kernel.org>
Date: Wed, 25 Jun 2025 03:45:18 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 16 Jun 2025 11:16:03 +0300, Leon Romanovsky wrote:
> Following the fix in the previous commit ("IB/mlx5: Fix potential
> deadlock in MR deregistration"), teach lockdep explicitly about the
> locking order between fs_reclaim and umem_mutex.
> 
> The previous commit resolved a potential deadlock scenario where
> kzalloc(GFP_KERNEL) was called while holding umem_mutex, which could
> lead to reclaim and eventually invoke the MMU notifier
> (mlx5_ib_invalidate_range()), causing a recursive acquisition of
> umem_mutex.
> 
> [...]

Applied, thanks!

[1/1] IB/core: Annotate umem_mutex acquisition under fs_reclaim for lockdep
      https://git.kernel.org/rdma/rdma/c/3f5f6321f129ad

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


