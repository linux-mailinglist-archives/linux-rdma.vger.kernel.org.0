Return-Path: <linux-rdma+bounces-15241-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2787CE9362
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 10:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32E4E300EE4D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BC0275114;
	Tue, 30 Dec 2025 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRit5Jun"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8B23EAA3;
	Tue, 30 Dec 2025 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767086876; cv=none; b=q667wE3+i9mm+6q2KBvW4b6aHilpDERrDXDrVX6c1PP0J8dKMZ99pjAx9LcRoGvXDkVZlCEX3a6Fkc7wkgSv6a3GIVacrUiRjD+YBeFHlbsDFFu1G5iaAmD23fDjW5vNk5inH1n8h59zBdbP95J61U5j8g+ygGC60B0RxK361Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767086876; c=relaxed/simple;
	bh=XHE7kh7hBhQnYbduh3bf0GVWbdi96gSo5WavIDvDTUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4jmf/uLORYcX9FepAgZiPcQo8OZ6hhvumbIh1qw0zvsKMl831iyJ2fYqYbdFm39zsG7YJQP89NY/8L0Phsp1Gn8yj0zEvYdspyQPrOYwI6SS9T173wG0N7VY5MpGGfaDlax+v9qLmyR7Kk6nxL0djjUoEj7XfujmIzgDxpVdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRit5Jun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66B4C4CEFB;
	Tue, 30 Dec 2025 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767086876;
	bh=XHE7kh7hBhQnYbduh3bf0GVWbdi96gSo5WavIDvDTUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SRit5JunD86NpiSLHQFXJTB101IUmCTzDro1FKs5JuMXclNIcBgS+kI8W3g39zMyE
	 RaXxCibWWvrTcZwsVhO4Oe6+A9/Gr0E5p2T9AovjONBxFp8G6ULQ7d8tK8fMEQUIJq
	 U1uTKjNNFxtN4p5JItwGAunI2dJfsWTCXnJxycx+cx63MniiSirl8X9nZU8G4eE1JK
	 32dbc7T2XfA2/C8dwbOyQoQOUM9eqM0c6EcY1TDvsdsahmAz5euKJ7fvJRwfMx+F1p
	 A4hD/aaFOV4SZOlinUiso/Mx3ip7uOVfqxG0Uk1VaooGlUd6GdrmEP6RAFZQVysIvR
	 SWt/vngln+LCA==
Date: Tue, 30 Dec 2025 11:27:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, zyjzyj2000@gmail.com, jgg@ziepe.ca,
	Daisuke Matsuda <dskmtsd@gmail.com>
Subject: Re: [PATCH] IB/rxe: ODP: Fix missing umem_odp->umem_mutex unlock
Message-ID: <20251230092751.GA27868@unreal>
References: <20251226094112.3042583-1-lizhijian@fujitsu.com>
 <deb756fc-dc58-4689-ac0e-632944830871@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <deb756fc-dc58-4689-ac0e-632944830871@linux.dev>

On Fri, Dec 26, 2025 at 05:05:09PM -0800, Zhu Yanjun wrote:
> 
> 在 2025/12/26 1:41, Li Zhijian 写道:
> > rxe_odp_map_range_and_lock() should unlock umem_odp->umem_mutex on error.
> > 
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > ---
> >   drivers/infiniband/sw/rxe/rxe_odp.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> > index 8b6a8b064d3c..d22b08da2713 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> > @@ -178,8 +178,10 @@ static int rxe_odp_map_range_and_lock(struct rxe_mr *mr, u64 iova, int length, u
> >   			return err;
> 160 static int rxe_odp_map_range_and_lock(struct rxe_mr *mr, u64 iova, int
> length, u32 flags)
> 161 {
> 162     struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> 163     bool need_fault;
> 164     int err;
> 165
> 166     if (unlikely(length < 1))
> 167         return -EINVAL;
> 168
> 169     mutex_lock(&umem_odp->umem_mutex);
> 170
> 171     need_fault = rxe_check_pagefault(umem_odp, iova, length);
> 172     if (need_fault) {
> 173         mutex_unlock(&umem_odp->umem_mutex);
> 174
> 175         /* umem_mutex is locked on success. */
> 176         err = rxe_odp_do_pagefault_and_lock(mr, iova, length,
> 177                             flags);
> 178         if (err < 0)
> 
> 179             return err;
> 
> If the function rxe_odp_do_pagefault_and_lock() succeeds and run here, the
> mutex lock umem_mutex should be held.
> 
> Thus, if rxe_check_pagefault fails, the mutex lock umem_mutex should be
> released.
> 
> as such, I am fine with this.
> 
> But IMO, the commit log is too simple. The above explanations should be
> added into the commit logs.
> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

I made a few adjustments to the commit message, added a Fixes tag, included  
your Reviewed-by, and applied the patch.

Thanks

> 
> Zhu Yanjun
> 
> 180
> 181         need_fault = rxe_check_pagefault(umem_odp, iova, length);
> 182         if (need_fault)
> 183             return -EFAULT;
> 184     }
> 185
> 186     return 0;
> 187 }
> 
> >   		need_fault = rxe_check_pagefault(umem_odp, iova, length);
> > -		if (need_fault)
> > +		if (need_fault) {
> > +			mutex_unlock(&umem_odp->umem_mutex);
> >   			return -EFAULT;
> > +		}
> >   	}
> >   	return 0;
> 
> -- 
> Best Regards,
> Yanjun.Zhu
> 

