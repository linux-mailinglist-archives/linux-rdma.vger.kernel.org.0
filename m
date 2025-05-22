Return-Path: <linux-rdma+bounces-10535-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC9DAC0CE8
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 15:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D8E1BA5247
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 13:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D039B28BA8D;
	Thu, 22 May 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVD8iVDa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1493010C
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921041; cv=none; b=E/kXfnAh0OHHdSxp9e0KZOMiDYi4me5AC/qpLtN+ji+v1VWBt6Vf7TXrmTx4sev7fBAxRrpZrzPxuQViVIZ68Q097v/XsjZKJcmYKDURY0kU+0Aqx3QlNHRDw2P3/DSlirBrfNLtq1EE0mIDJyTIVXHdMJmsk4n89yo34jyAGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921041; c=relaxed/simple;
	bh=hnL55V/PxG/a2G9Yeybh1YQBC7SfFFdDyUCAJ4MELto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lf82uDMpdQsH70HLeKRBv85vn51qAe+KwgUXVB4C90BlfPgOwbZJjqs2/gc1WI8Kxjv2o1DjehwE5L0MYmudC7R61DLahMgjX8eqtgggm+fa1Vfism/LimNDC/lHZ24E4zcqMCZC/VL239mIhjLkLTsUWpfFxDe5kI5sy2n9+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVD8iVDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906B2C4CEE4;
	Thu, 22 May 2025 13:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747921041;
	bh=hnL55V/PxG/a2G9Yeybh1YQBC7SfFFdDyUCAJ4MELto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bVD8iVDaJpPf9YxFTi4uBPDweXDkU9VRFt1J1pRSYSzJueqJwC7wU7Oiw/1nlxcN9
	 9creFqIQhxsTL8XZXUuH1sZNC/PPqWC/HQGOh9wCj/CfyrHhdcq3UwWqMfiVn49fd7
	 TbqIRbukKjvsaJTTZY66eatUtTzAhrPl0aYCy+wVpz/jFBHWCG8O0J57BSWaP0aCo7
	 cWmb4G9pvB7r2BTtifuPdVIRgmvmn4Y/FzcdKmzu+l6DkdPoxP84m31boikb+cSmrF
	 UDfeYFxO7LvXOwpwXvcWk0IbUzw7Wt9wjyrVufXrzLJy2mT7ZnZ1tn+VA/heNUkMab
	 NscNjBR25azWw==
Date: Thu, 22 May 2025 16:37:16 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Break endless pagefault loop for RO
 pages
Message-ID: <20250522133716.GQ7435@unreal>
References: <096fab178d48ed86942ee22eafe9be98e29092aa.1747913377.git.leonro@nvidia.com>
 <72a82333-b005-4383-888c-7632bf1ce4ae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72a82333-b005-4383-888c-7632bf1ce4ae@gmail.com>

On Thu, May 22, 2025 at 10:29:02PM +0900, Daisuke Matsuda wrote:
> 
> On 2025/05/22 20:36, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > RO pages has "perm" equal to 0, that caused to the situation
> > where such pages were marked as needed to have fault and caused
> > to infinite loop.
> > 
> > Fixes: eedd5b1276e7 ("RDMA/umem: Store ODP access mask information in PFN")
> > Reported-by: Daisuke Matsuda <dskmtsd@gmail.com>
> > Closes: https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> Tested-by: Daisuke Matsuda <dskmtsd@gmail.com>
> 
> Thank you!
> This change fixes one of the two issues I reported.
> The kernel module does not get stuck in rxe_ib_invalidate_range() anymore.
> 
> 
> The remaining one is the stuck issue in uverbs_destroy_ufile_hw().
> cf. https://lore.kernel.org/all/3e8f343f-7d66-4f7a-9f08-3910623e322f@gmail.com/

Thanks, I updated the link to point to https://lore.kernel.org/all/3016329a-4edd-4550-862f-b298a1b79a39@gmail.com/

> 
> The issue occurs with test_odp_async_prefetch_rc_traffic, which is not yet
> enabled in rxe. It might indicate that the root cause lies in ib_uverbs layer.

Unlikely, up till now, it indicated that driver didn't release some
uverb object.

> I will take a closer look anyway.
> 
> Thanks,
> Daisuke
> 
> 
> > ---
> >   drivers/infiniband/sw/rxe/rxe_odp.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> > index a1416626f61a5..0f67167ddddd1 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> > @@ -137,7 +137,7 @@ static inline bool rxe_check_pagefault(struct ib_umem_odp *umem_odp,
> >   	while (addr < iova + length) {
> >   		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
> > -		if (!(umem_odp->map.pfn_list[idx] & perm)) {
> > +		if (!(umem_odp->map.pfn_list[idx] & HMM_PFN_VALID)) {
> >   			need_fault = true;
> >   			break;
> >   		}
> 

