Return-Path: <linux-rdma+bounces-1401-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98600879284
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 11:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539FA2810E1
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 10:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A6577F00;
	Tue, 12 Mar 2024 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moPpmblv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4B23AC2B
	for <linux-rdma@vger.kernel.org>; Tue, 12 Mar 2024 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240853; cv=none; b=Zb62GpniwtE85Nw535Al1lHn0fjJ8ExAruv191EvCaeGrh0um3Zqq1UAbxNink4fqtOvGESQLzsbdRkWKFWYzFlu8xsiJeWmEuwj/+XZ12qfdR1JQ8pbJuleK9Rybj69XRcmTehtg0uTbZdERpSKDkA/XQMmZrH27kh5LtvlepU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240853; c=relaxed/simple;
	bh=8W3oxireQHVgTmYyHEGSvlooAzZbM+wj1T1awXSKr90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oub6ffWydkD/OXxkINY9PM0/56j7EPVuL0YgFunHr5v0z7UQtjDG0pS4WOOQmeGJ4FllTsGJXTD/EydFSi6OpQGBhcIthBUYNkTa4UPkoFJsWJvNAmvWCYn6XjfiO3l8Os0g3KreTYgnLzfTK4SUI3HE/5MiNyrqpQC6l2u1OVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moPpmblv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF81C433F1;
	Tue, 12 Mar 2024 10:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710240853;
	bh=8W3oxireQHVgTmYyHEGSvlooAzZbM+wj1T1awXSKr90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=moPpmblvRiOGVB7Dwq0SmEYkBHKAZYvxP3mIfi03Jc04Em9M/OupK4vCuTuKKOJ/0
	 xPWpB8EUGorhJwUUZQM3MSDgBXBgRNhQZyB2vvty24Iyn3ojkBRdoFF9WeoreubPdz
	 hX4Hm78M4JpNFK6VFo2u8/gem0rwAaoFy/BjExWwf8k7swSkeeqMMyKvqCQ10w7HpE
	 KOncKf6NemOOWjLcX1n2P1HnAKT+VEEiV8GWWmjHCql2tbzSLNjRYesyvhoC3h/6/Z
	 vh7lRDtSAmjJa20o00alO99/iVb2Zn3s2NfCiiQCC+ROhu/u9P/bniy8z4wZZO76j5
	 i2aq3eERWuaKA==
Date: Tue, 12 Mar 2024 12:54:09 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Boshi Yu <boshiyu@alibaba-inc.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, chengyou@linux.alibaba.com,
	KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 0/3] RDMA/erdma: A series of fixes for the erdma
 driver
Message-ID: <20240312105409.GS12921@unreal>
References: <20240311113821.22482-1-boshiyu@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311113821.22482-1-boshiyu@alibaba-inc.com>

On Mon, Mar 11, 2024 at 07:38:18PM +0800, Boshi Yu wrote:
> Hi,
> 
> This series of patchs introduce a new dma pool named db_pool for doorbell
> record allocation. Besides, we unify the names related to doorbell records
> into dbrec for simplicity. By the way, we also remove the uncessary
> __GFP_ZERO flag when calling dma_alloc_coherent().
> 
> - #1 introduces the dma pool named db_pool and allocates all doorbell
>   records from it.
> - #2 unifies the names related to doorbell record into dbrec.
> - #3 remove the unnecessary __GFP_ZERO flag when calling
>   dma_alloc_coherent().
> 
> Thanks,
> Boshi Yu

We are in merge window now and don't accept new features till -rc1 is released.

Thanks

> 
> Boshi Yu (3):
>   RDMA/erdma: Allocate doorbell records from dma pool
>   RDMA/erdma: Unify the names related to doorbell records
>   RDMA/erdma: Remove unnecessary __GFP_ZERO flag
> 
>  drivers/infiniband/hw/erdma/erdma.h       |  13 +--
>  drivers/infiniband/hw/erdma/erdma_cmdq.c  |  99 +++++++++++---------
>  drivers/infiniband/hw/erdma/erdma_cq.c    |   2 +-
>  drivers/infiniband/hw/erdma/erdma_eq.c    |  54 ++++++-----
>  drivers/infiniband/hw/erdma/erdma_hw.h    |   6 +-
>  drivers/infiniband/hw/erdma/erdma_main.c  |  15 +++-
>  drivers/infiniband/hw/erdma/erdma_qp.c    |   4 +-
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 105 ++++++++++++----------
>  drivers/infiniband/hw/erdma/erdma_verbs.h |  16 ++--
>  9 files changed, 181 insertions(+), 133 deletions(-)
> 
> -- 
> 2.39.3
> 
> 

