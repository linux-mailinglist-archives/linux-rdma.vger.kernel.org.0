Return-Path: <linux-rdma+bounces-3296-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A53490E57F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 10:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC301C212A2
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 08:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D67A7A158;
	Wed, 19 Jun 2024 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLGSriFk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F7A79952
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785851; cv=none; b=Gl4rmvs6JbxyXKNtSP/3NY704CPO/TgTAhCcsYARPsZ4h2AChioJeKL4R5Tzuh5zUvv0HfLLJctc327ZAI6IoFeLhIecPn5BKvVJth3IjwkRiQeazbKVIEsrbO89sYX4VVuvPJAXUERHdAPFklxn8C5qBS/OHy1452WzlPqhy6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785851; c=relaxed/simple;
	bh=4Z+2TwGM013hWxrUQnTDaV9IqqUhdx+8+KFfxv17uY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEIxHj+bDLP95zg4xY/pYM2XQ1NphRtGJA50x/L2HDYd0C6ZZd0JJMSz0M6CTGTqCBZELU3YFmiF7jwmAp9mpT5yNoImoPcZ07GhyZZQg+r3bDi6ZuDmICmrSrJ7+k+KUz9L0f+zpQeOfKqF6pViimsmU6ZAzIkQ0jFKDpRNeRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLGSriFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BA0C2BBFC;
	Wed, 19 Jun 2024 08:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718785850;
	bh=4Z+2TwGM013hWxrUQnTDaV9IqqUhdx+8+KFfxv17uY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLGSriFk9vjl4GBol0VXRF5XcUsuamxyUQkFYZmEPJfzVmdhvjRHPP4vOnovnLmK+
	 Y5lYe0g3QVPBC/1KmHseWgudLCrY2lAiTiYMS2u+rcreySkr8d1m1IYVdoALYD1DY1
	 B6JFpwT1eoZofkN7qSFqfvlCel//Qeb4gmxKc8wdwRYYw21pRyVjiwgODkF1dnkxuf
	 KfCDdc1EPkFn2ySPEm8JV0xHaEn7ux4loqS0zXC+F0x+emnTDvDDtMO4ckQAiRE+K8
	 sAYfgzMrCVFdeLQ+IaoIEabzzDaRxrUKmcgF4zLUCKewgmDp4fl10vIT8LISndJ6Me
	 fd82LpFWuSgHg==
Date: Wed, 19 Jun 2024 11:30:45 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Jianxin Xiong <jianxin.xiong@intel.com>, linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Set mkeys for dmabuf at PAGE_SIZE
Message-ID: <20240619083045.GJ4025@unreal>
References: <1e2289b9133e89f273a4e68d459057d032cbc2ce.1718301631.git.leon@kernel.org>
 <20240617135905.GL19897@nvidia.com>
 <20240618120814.GF4025@unreal>
 <20240618130233.GA2494510@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618130233.GA2494510@nvidia.com>

On Tue, Jun 18, 2024 at 10:02:33AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 18, 2024 at 03:08:14PM +0300, Leon Romanovsky wrote:
> > > > Set the mkey for dmabuf at PAGE_SIZE to support any SGL
> > > > after a move operation.
> > > > 
> > > > ib_umem_find_best_pgsz returns 0 on error, so it is
> > > > incorrect to check the returned page_size against PAGE_SIZE
> > > 
> > > This commit message is not clear enough for something that need to be
> > > backported:
> > 
> > This patch is going to be backported without any relation to the commit
> > message as it has Fixes line.
> 
> People doing backports complain with some regularity about poor commit
> messages, especailly now that so many patches get a CVE. We need to do
> better.

It is always true.

> 
> > > RDMA/mlx5: Support non-page size aligned DMABUF mkeys
> > > 
> > > The mkey page size for DMABUF is fixed at PAGE_SIZE because we have to
> > > support a move operation that could change a large-sized page list
> > > into a small page-list and the mkey must be able to represent it.
> > > 
> > > The test for this is not quite correct, instead of checking the output
> > > of mlx5_umem_find_best_pgsz() the call to ib_umem_find_best_pgsz
> > > should specify the exact HW/SW restriction - only PAGE_SIZE is
> > > accepted.
> > > 
> > > Then the normal logic for dealing with leading/trailing sub page
> > > alignment works correctly and sub page size DMBUF mappings can be
> > > supported.
> > > 
> > > This is particularly painful on 64K kernels.
> > 
> > Unfortunately, the patch was already merged, so I can't change the
> > commit message in for-next branch.
> 
> How is it already merged? There was no message from your script - are
> you loosing emails??

In this specific case, no.
I switched too early from branch and my thank-you message (b4 ty ..)
simply wasn't sent.

Thanks

> 
> Jason

