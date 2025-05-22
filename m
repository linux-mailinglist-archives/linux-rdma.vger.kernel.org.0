Return-Path: <linux-rdma+bounces-10547-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EEFAC10B8
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 18:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D20717EACE
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 16:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D50299ABC;
	Thu, 22 May 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQfg1Ras"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690F19F461
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747930031; cv=none; b=V0QVTv9Lsq0nJC/OsEhTi1bInx67ib1SyjKMNXNxXwTUsit5ORY8+uDyoQk2BvrWtYWFT+kTOb6/K67oSlGl7jLb1CnSnOAaDNhag7eeCOPKJ8b/dc6RfG/6kxusA2JaAfNsXFZcaxAvTvBzJI0daSLpzolWepE42Tg/gCvhwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747930031; c=relaxed/simple;
	bh=HmIwLBR/xjGkOHwjxtfpmMduSM1bmHBLMW3jQbMev3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDOI42ZYLWimmlHNUV6tLZZh6Rcd41qErcYNLSRKAQpQIOcjSn0B0yfJlgFr61tVY5MdVN3rmRQy5SD0zK7YUOtLK2prRMQSLFoQvI7jBXbr6hv+x0umCzPpWvmJs9CNNTJfrlvbOf4MDD9aO/2Sj0pVlYSh1tVeahSmGPcsznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQfg1Ras; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774E4C4CEEA;
	Thu, 22 May 2025 16:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747930029;
	bh=HmIwLBR/xjGkOHwjxtfpmMduSM1bmHBLMW3jQbMev3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQfg1RasaK/4jtJfURbJEAXazBv0E2vQ9lDI7jvAwo907IGIi62hkT/V7/oDag8ar
	 z7qTce2reMV9g9HtYaga7lVjMiDArD6SQR822j+/AFnXhcb8CK33d+kEvbSR2rtkF7
	 L8uvWNhUzOeKfarnQFAj5gnO8yoQx0s0mHKnhDJTMhHRdPfJNJcmz5tgNYOEVNkm20
	 a+7tTUdaGgPIKVSZsiUdAY+u0nQh1K9Iti/XF1sYk6V60Ym8vzY2K+MmpCCKhKT6qH
	 8z67M92klTYjFAsf4VlJqXFtoT0CcdmQMCrDwGSbpJHATAlnHNldq0YYVDnZqppD8D
	 BchajdLJA56qQ==
Date: Thu, 22 May 2025 19:07:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Daisuke Matsuda <dskmtsd@gmail.com>,
	linux-rdma@vger.kernel.org, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Break endless pagefault loop for RO
 pages
Message-ID: <20250522160704.GS7435@unreal>
References: <096fab178d48ed86942ee22eafe9be98e29092aa.1747913377.git.leonro@nvidia.com>
 <bb5dcd1c-669a-4e23-8b41-4dc018331b82@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb5dcd1c-669a-4e23-8b41-4dc018331b82@linux.dev>

On Thu, May 22, 2025 at 05:40:38PM +0200, Zhu Yanjun wrote:
> 在 2025/5/22 13:36, Leon Romanovsky 写道:
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
> 
> Because perm is not used, it is not necessary to calculate and pass perm to
> rxe_check_pagefault. The cleanup is as below:

Thanks a lot, I folded this cleanup to the fix.

