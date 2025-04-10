Return-Path: <linux-rdma+bounces-9327-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F892A841D0
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 13:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F0507A928F
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 11:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E92281533;
	Thu, 10 Apr 2025 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHzN/i5B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A04267F64;
	Thu, 10 Apr 2025 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284912; cv=none; b=h0LsQx6Y+5qc4Z6hZYcg+CA8TexxcYmzBdVJfiEoQugmrHkvG9XvFHzjRqEOG1izq8E090kGTCfI3rkmo2fG3LnItfBkrO+BwImFkKLohEEFwTG/VdSfSF4u/IVFTNDzrpjEwLbxWYwUDZ4ITgA8gNiteGkNTC+dIpgUGH99PoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284912; c=relaxed/simple;
	bh=qT1SDunM9lk0LW0G4uMkqlmGvlTW24J+C7Wob2INTz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wc3sAH7eGheBEY9AwkWgTKscYdNU3k5P3Eczkwf4+X5LGDjYjm+NYbQCMigbnzrp8l8jBMRDooBxjgYFjJsv0U5TMtHgs2UZ49JldiTBFTNV/ioQyy9Sq3NVy0+l1GX08RcLMQtmOGSkhouTYGBqZeFv7/BVKsopviT4cX07IjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHzN/i5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DF3C4CEDD;
	Thu, 10 Apr 2025 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744284911;
	bh=qT1SDunM9lk0LW0G4uMkqlmGvlTW24J+C7Wob2INTz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pHzN/i5BPWQhd2Y0Ql5xjD/GqJeCWzGv5t++6oSRkemvlBRB09GiO/lMk2OSc4uRT
	 QURoqgPYbm7PiUfmUwQr+/Z+tVB5oDcLdlWzGm2/OK53EdiUuPIFsgB03EcKYbuVwm
	 bmycdDa58wsZkk5tM8DRNORO2+jVLMD6X8vEM8U3Pp39q1t/Spi0qgo8pVHQxccEvT
	 0AEZVuGV5rAxbLJjZhSJkpCGgouJ1Sr12K6O8h2ccPWXEc0Rbiiym4xVdHJFUP0pXX
	 6ixA77Tuead/2ufG2YV6K/XORTTnldbi8dzWMlxsjpISneu3csesANMoAA11BdwzR3
	 QCQ8oCZE6PYag==
Date: Thu, 10 Apr 2025 14:35:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "jgg@nvidia.com" <jgg@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] rds: rely on IB/core to determine if device is
 ODP capable
Message-ID: <20250410113505.GQ199604@unreal>
References: <bfc8ffb7ea207ed90c777a4f61a8afe1badef212.1744109826.git.leonro@nvidia.com>
 <20250408122338.GA1778492@nvidia.com>
 <20250408123413.GA199604@unreal>
 <20250408123814.GC1778492@nvidia.com>
 <20250408191138.GF199604@unreal>
 <94c8e113c11ec18c5e9330d7f2175a4469518e44.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94c8e113c11ec18c5e9330d7f2175a4469518e44.camel@oracle.com>

On Wed, Apr 09, 2025 at 12:54:39AM +0000, Allison Henderson wrote:
> On Tue, 2025-04-08 at 22:11 +0300, Leon Romanovsky wrote:
> > On Tue, Apr 08, 2025 at 09:38:14AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Apr 08, 2025 at 03:34:13PM +0300, Leon Romanovsky wrote:
> > > > On Tue, Apr 08, 2025 at 09:23:38AM -0300, Jason Gunthorpe wrote:
> > > > > On Tue, Apr 08, 2025 at 02:04:55PM +0300, Leon Romanovsky wrote:
> > > > > > diff --git a/net/rds/ib.c b/net/rds/ib.c
> > > > > > index 9826fe7f9d00..c62aa2ff4963 100644
> > > > > > --- a/net/rds/ib.c
> > > > > > +++ b/net/rds/ib.c
> > > > > > @@ -153,14 +153,6 @@ static int rds_ib_add_one(struct ib_device *device)
> > > > > >  	rds_ibdev->max_wrs = device->attrs.max_qp_wr;
> > > > > >  	rds_ibdev->max_sge = min(device->attrs.max_send_sge, RDS_IB_MAX_SGE);
> > > > > >  
> > > > > > -	rds_ibdev->odp_capable =
> > > > > > -		!!(device->attrs.kernel_cap_flags &
> > > > > > -		   IBK_ON_DEMAND_PAGING) &&
> > > > > > -		!!(device->attrs.odp_caps.per_transport_caps.rc_odp_caps &
> > > > > > -		   IB_ODP_SUPPORT_WRITE) &&
> > > > > > -		!!(device->attrs.odp_caps.per_transport_caps.rc_odp_caps &
> > > > > > -		   IB_ODP_SUPPORT_READ);
> > > > > 
> > > > > This patch seems to drop the check for WRITE and READ support on the
> > > > > ODP.
> > > > 
> > > > Right, and they are part of IBK_ON_DEMAND_PAGING support. All ODP
> > > > providers support both IB_ODP_SUPPORT_WRITE and IB_ODP_SUPPORT_READ.
> > > 
> > > Where? mlx5 reads this from FW and I don't see anything blocking
> > > IBK_ON_DEMAND_PAGING if the FW is weird.
> > 
> > As the one who added it, I can assure you that we added these checks not
> > because of weird FW, but because these caps existed.
> Hi Leon,
> 
> Thanks for the patch.  Is there a commit id for the FW checks we can see?

It is part of FW checks to provided access_flags. In this case, you are
asking for IB_ACCESS_REMOTE_READ and IB_ACCESS_ON_DEMAND.

The check of IB_ODP_SUPPORT_READ is used when you need to dig which
transport actually supports it.

The thing is that ODP was always supported for RC QPs, from day one.

> Maybe we can just add a little more detail to
> the commit description to make clear where they are and what they're checking for.  Thank you!

Sure, will update it.

Thanks

> 
> Allison
> 
> > 
> > RDS calls to ib_reg_user_mr() with the following access_flags.
> > 
> >   564                 int access_flags =
> >   565                         (IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_READ |
> >   566                          IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_ATOMIC |
> >   567                          IB_ACCESS_ON_DEMAND);
> >   <...>
> >   575
> >   576                 ib_mr = ib_reg_user_mr(rds_ibdev->pd, start, length, virt_addr,
> >   577                                        access_flags);
> > 
> > If for some reason ODP doesn't support WRITE and/or READ, ib_reg_user_mr() will return an error from FW,
> > 
> > Thanks
> > 
> > 
> > > 
> > > Jason
> 

