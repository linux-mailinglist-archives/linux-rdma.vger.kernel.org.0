Return-Path: <linux-rdma+bounces-8015-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F655A40D66
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 09:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE2E3BE204
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 08:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC971FC0EE;
	Sun, 23 Feb 2025 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC6fuk55"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D405376F1
	for <linux-rdma@vger.kernel.org>; Sun, 23 Feb 2025 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740299613; cv=none; b=NIweVHpbsoK8LbH5GVwh6hulF6dBsGqNZX7s3UFO6iurypVUvH8nhK6Wk4D8TuSH1p5Oeo+lIp+e7KRschMyIoG7yQehHuPoh0Gi3zU70wtfjRJ8qSZ6Sm1R/k6bkCh6S/4eErZk40iBxUt0LdAG0/2IwaA+vBcNmqu2S5hii0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740299613; c=relaxed/simple;
	bh=bDpbIp7OZh5QPZ8sLKg3PlMCguLdaQflvLQPwlXuRqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TY7bTKudLHRtX3azTqlV/9MFCBEmOXYYNhY5AX05nFX+/h+DG6YC4zG1UpsEr0K22wsZZsz9PFvQzN5miOKoqDVikcxhZVZ3fcB6Zs+WOWpfDh4uSVuO7mBV/83ylzdnhB5aiNF0BS3QZMCagk+iapHkqoUZIJh7AsYOhurI56w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC6fuk55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9AAC4CEDD;
	Sun, 23 Feb 2025 08:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740299611;
	bh=bDpbIp7OZh5QPZ8sLKg3PlMCguLdaQflvLQPwlXuRqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FC6fuk55LxkzPr13tdZF9RSd5+s/8uzWpNRsFgxfnAOCtdRDXGYUUg1CBUko6EFRh
	 Xh+1wK+yPbM1Aq9bROpRklM5koaIYWP/vEdiQiBY3jOVWRTXUJ/LNUh+VGb9zxNDIB
	 dGSn72D+1eu7vtuFYwlZhkBzGEZ0MSKq2Z5I5Mgtpmp128xeLbW4/5kQ7axFQntse2
	 QzGP+9/U4PzOb8qRIO3e8jPVGAxynoRfiAfP/WjuiLgeBHdRP82XcFLdR7UhsC/pTM
	 E35+H1mSez7OV0LEpFWrDgvhdTmjWQGxAyrgfCNhdbHG42KkWJldtMtSlt3T6RSvSs
	 OULBUrCHUcGkA==
Date: Sun, 23 Feb 2025 10:33:26 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org,
	Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix bind QP error cleanup flow
Message-ID: <20250223083326.GV53094@unreal>
References: <25dfefddb0ebefa668c32e06a94d84e3216257cf.1740033937.git.leon@kernel.org>
 <1229cbb2-b7b9-4b47-8276-62bd9c79a7ce@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1229cbb2-b7b9-4b47-8276-62bd9c79a7ce@linux.dev>

On Thu, Feb 20, 2025 at 01:23:33PM +0100, Zhu Yanjun wrote:
> 在 2025/2/20 7:47, Leon Romanovsky 写道:
> > From: Patrisious Haddad <phaddad@nvidia.com>
> > 
> > When there is a failure during bind QP, the cleanup flow destroys the
> > counter regardless if it is the one that created it or not, which is
> > problematic since if it isn't the one that created it, that counter could
> > still be in use.
> > 
> > Fix that by destroying the counter only if it was created during this call.
> > 
> > Fixes: 45842fc627c7 ("IB/mlx5: Support statistic q counter configuration")
> > Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> > Reviewed-by: Mark Zhang <markzhang@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >   drivers/infiniband/hw/mlx5/counters.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/mlx5/counters.c b/drivers/infiniband/hw/mlx5/counters.c
> > index 4f6c1968a2ee..81cfa74147a1 100644
> > --- a/drivers/infiniband/hw/mlx5/counters.c
> > +++ b/drivers/infiniband/hw/mlx5/counters.c
> > @@ -546,6 +546,7 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
> >   				   struct ib_qp *qp)
> >   {
> >   	struct mlx5_ib_dev *dev = to_mdev(qp->device);
> > +	bool new = false;
> >   	int err;
> >   	if (!counter->id) {
> > @@ -560,6 +561,7 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
> >   			return err;
> >   		counter->id =
> >   			MLX5_GET(alloc_q_counter_out, out, counter_set_id);
> > +		new = true;
> It seems that there is no other better method except that a new bool
> variable is used. IMO, this method can fix this problem.
> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks

> 
> Zhu Yanjun
> 
> >   	}
> >   	err = mlx5_ib_qp_set_counter(qp, counter);
> > @@ -569,8 +571,10 @@ static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
> >   	return 0;
> >   fail_set_counter:
> > -	mlx5_ib_counter_dealloc(counter);
> > -	counter->id = 0;
> > +	if (new) {
> > +		mlx5_ib_counter_dealloc(counter);
> > +		counter->id = 0;
> > +	}
> >   	return err;
> >   }
> 
> 

