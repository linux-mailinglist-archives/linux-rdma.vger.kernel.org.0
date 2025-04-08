Return-Path: <linux-rdma+bounces-9271-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9EBA81594
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 21:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBD318964CD
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53878236433;
	Tue,  8 Apr 2025 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDhLcGrX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103231DE894;
	Tue,  8 Apr 2025 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139507; cv=none; b=joPQPlnTFsF1wBGqk5JnobEAtP0gcMF1KN6orsHeb1bdiuAmBAZkgqvXJMcRfqfbMFArPIBSXdDtq/NrFFnQ5O8Vvs63Av/We0ysGk49KEKjEdWqr0vwqiBOMiWzE141uHvCCEpCpceZUNq0GU+ojj3tnWpgNlYFb21U5XR9jJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139507; c=relaxed/simple;
	bh=rvyNXRGr97O6fKSIuIw20r6W2J4nM2TGAOvyPpoll7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgqzT/niaowH5eXegV7DcSmW19TPhzh/yBQR0trpqfztkiALu/MXnbfjFs153D9KPcNDZZGw0QMwdZlKmeK2PguAmqV0SFjpJ5K3BV5eXbdP3+L6/eTDJMUyyXOZ3ih+4mwYC+M/lFFhp2ypd+N5BfmvAKXS0BdT2Pv/tIgZAzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDhLcGrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49255C4CEE5;
	Tue,  8 Apr 2025 19:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744139504;
	bh=rvyNXRGr97O6fKSIuIw20r6W2J4nM2TGAOvyPpoll7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gDhLcGrXILPU77ehqJ+R362YMFadQGANx7aquJNjrMNTNBIx04AwIqYLB8J2xHq6D
	 9ULK+7EmQStDFIylO5k1o8mI4zqFKq+xKd/bjsbB0md1WcrmeSTCMmkI4SCe0+1zrw
	 /rOAQRujwewDTU9/kTSMMalQocoBboOY/Zx1ghVUvAKbc7YUoOghuF7cEA4viI9vtb
	 lf/kRqkk2Crbr9mtOgqfQpKo55iOsiO56ovKjBpAWwhoZrnrhXegSrQRVKEwJi9NWj
	 qb5C6kuRd79LS6/a5/5fEqhkeBQBy7/2Hg8ubfscWoCkO85d6oKpyzdLG1AQWdjBQ1
	 l6rlC1rIjw3MQ==
Date: Tue, 8 Apr 2025 22:11:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com
Subject: Re: [PATCH net-next] rds: rely on IB/core to determine if device is
 ODP capable
Message-ID: <20250408191138.GF199604@unreal>
References: <bfc8ffb7ea207ed90c777a4f61a8afe1badef212.1744109826.git.leonro@nvidia.com>
 <20250408122338.GA1778492@nvidia.com>
 <20250408123413.GA199604@unreal>
 <20250408123814.GC1778492@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408123814.GC1778492@nvidia.com>

On Tue, Apr 08, 2025 at 09:38:14AM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 08, 2025 at 03:34:13PM +0300, Leon Romanovsky wrote:
> > On Tue, Apr 08, 2025 at 09:23:38AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Apr 08, 2025 at 02:04:55PM +0300, Leon Romanovsky wrote:
> > > > diff --git a/net/rds/ib.c b/net/rds/ib.c
> > > > index 9826fe7f9d00..c62aa2ff4963 100644
> > > > --- a/net/rds/ib.c
> > > > +++ b/net/rds/ib.c
> > > > @@ -153,14 +153,6 @@ static int rds_ib_add_one(struct ib_device *device)
> > > >  	rds_ibdev->max_wrs = device->attrs.max_qp_wr;
> > > >  	rds_ibdev->max_sge = min(device->attrs.max_send_sge, RDS_IB_MAX_SGE);
> > > >  
> > > > -	rds_ibdev->odp_capable =
> > > > -		!!(device->attrs.kernel_cap_flags &
> > > > -		   IBK_ON_DEMAND_PAGING) &&
> > > > -		!!(device->attrs.odp_caps.per_transport_caps.rc_odp_caps &
> > > > -		   IB_ODP_SUPPORT_WRITE) &&
> > > > -		!!(device->attrs.odp_caps.per_transport_caps.rc_odp_caps &
> > > > -		   IB_ODP_SUPPORT_READ);
> > > 
> > > This patch seems to drop the check for WRITE and READ support on the
> > > ODP.
> > 
> > Right, and they are part of IBK_ON_DEMAND_PAGING support. All ODP
> > providers support both IB_ODP_SUPPORT_WRITE and IB_ODP_SUPPORT_READ.
> 
> Where? mlx5 reads this from FW and I don't see anything blocking
> IBK_ON_DEMAND_PAGING if the FW is weird.

As the one who added it, I can assure you that we added these checks not
because of weird FW, but because these caps existed.

RDS calls to ib_reg_user_mr() with the following access_flags.

  564                 int access_flags =
  565                         (IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_READ |
  566                          IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_ATOMIC |
  567                          IB_ACCESS_ON_DEMAND);
  <...>
  575
  576                 ib_mr = ib_reg_user_mr(rds_ibdev->pd, start, length, virt_addr,
  577                                        access_flags);

If for some reason ODP doesn't support WRITE and/or READ, ib_reg_user_mr() will return an error from FW,

Thanks


> 
> Jason

