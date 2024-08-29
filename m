Return-Path: <linux-rdma+bounces-4629-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A37964150
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 12:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994F11C20E6E
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1081940B0;
	Thu, 29 Aug 2024 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3j2YPlk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37035194081;
	Thu, 29 Aug 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926625; cv=none; b=J0JpMKEQedoZfyvKhbF1LRtf/wq8J6ASXptJkoekyd+64bYUrzVEaSsYE0Cs5W7r6OCFtCRwrG/AmSE6fKXUpDaNaWAVIOfcHc4iNRIE1cF5IrD16xusCvmfPKUjmCKHWPiKxLB5doH5E2hO/MjXAFz5AECKrIt30VM3HGu36zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926625; c=relaxed/simple;
	bh=OPy596UFuUNgIYpD1Xx8R1sbYfsep1TcTlYPrJFlXNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiVaDM5fFjj41iOyd1HIilvO2r/dABpZkpL88XTRnARLDyCo8Dg3zct1MI8jlBSJtZDA38PPhz1yaXy+nuKZhau6HrZO7gAHNBfPn/XxFGH98yjlNw0B3Jxx5B32sHEnBiaZGTt31jrYcYCQGPbQGi3ek49zZQyLSQZNtA9YfqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3j2YPlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25ACAC4CEC3;
	Thu, 29 Aug 2024 10:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724926624;
	bh=OPy596UFuUNgIYpD1Xx8R1sbYfsep1TcTlYPrJFlXNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3j2YPlkHTFy3hAMbNpM8FV26zWcYsCgzJtam1W9gNjEkikHp8VOTYk4DKEZ7iYez
	 nkWdGKFi2Kj0XqQruhimKIs5JV6U6wOmHlk1yfr3KcCPSSi0C4krcNQ4iMqHQsNwKx
	 mKzwkDmcoxmw8jdbvNdoPVjYt9kLQCnEuYBuEitw+SVGj5x047frVxZmwcH6eeO6Yd
	 9l+Ox4V4YtKrn8kZ7YIXqQoZmWX4yBzrUihqa/LEB1L44qwBZckZWx8q2ag8+j7dUq
	 GrjhMjMkFUt3Bz+riXaoxpgkNJiW5LK0K8oBzoj/Cn4kcSqKj888KKgdHQMgUt3mpm
	 ymqQbzIYncmBw==
Date: Thu, 29 Aug 2024 13:17:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Shen Lichuan <shenlichuan@vivo.com>, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] RDMA/sw/rdmavt/mr: Convert to use ERR_CAST()
Message-ID: <20240829101701.GC26654@unreal>
References: <20240828082720.33231-1-shenlichuan@vivo.com>
 <e8cb7488-aea2-4829-9942-dd55b127c25e@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8cb7488-aea2-4829-9942-dd55b127c25e@cornelisnetworks.com>

On Wed, Aug 28, 2024 at 12:06:17PM -0400, Dennis Dalessandro wrote:
> On 8/28/24 4:27 AM, Shen Lichuan wrote:
> > As opposed to open-code, using the ERR_CAST macro clearly indicates that 
> > this is a pointer to an error value and a type conversion was performed.
> > 
> > Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> > ---
> >  drivers/infiniband/sw/rdmavt/mr.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
> > index 7a9afd5231d5..5ed5cfc2b280 100644
> > --- a/drivers/infiniband/sw/rdmavt/mr.c
> > +++ b/drivers/infiniband/sw/rdmavt/mr.c
> > @@ -348,13 +348,13 @@ struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
> >  
> >  	umem = ib_umem_get(pd->device, start, length, mr_access_flags);
> >  	if (IS_ERR(umem))
> > -		return (void *)umem;
> > +		return ERR_CAST(umem);
> >  
> >  	n = ib_umem_num_pages(umem);
> >  
> >  	mr = __rvt_alloc_mr(n, pd);
> >  	if (IS_ERR(mr)) {
> > -		ret = (struct ib_mr *)mr;
> > +		ret = ERR_CAST(mr);
> >  		goto bail_umem;
> >  	}
> >  
> > @@ -542,7 +542,7 @@ struct ib_mr *rvt_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
> >  
> >  	mr = __rvt_alloc_mr(max_num_sg, pd);
> >  	if (IS_ERR(mr))
> > -		return (struct ib_mr *)mr;
> > +		return ERR_CAST(mr);
> >  
> >  	return &mr->ibmr;
> >  }
> 
> I don't think this is really necessary. You are not making the code more
> readable. It doesn't simplify things. So I'm not going to Ack it, but I won't
> Nak either.

I will take it because ERR_CAST is slightly better way to return error pointers.

Thanks

> 
> -Denny

