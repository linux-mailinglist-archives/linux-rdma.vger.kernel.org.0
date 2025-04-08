Return-Path: <linux-rdma+bounces-9242-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77324A8085B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F994E152D
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FEB26FA70;
	Tue,  8 Apr 2025 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivCjJrUd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF426F457;
	Tue,  8 Apr 2025 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115660; cv=none; b=RLkhy6f+DXTdfN0CE4Ox+pY49PTiv74WR86ItCqhd/zhELxjZMhtgbj6Nls4Mgkgvc0a+vSet5AXcGqtdjBKCQjGZ5bkDjkCEoW4Q3PmwcLszEGPJikowlOArriaIECobSUeJtwI3z+xJEfwgwjNKtEZJLiPEfW/zZ6HfytHocA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115660; c=relaxed/simple;
	bh=36PuOkPXw44eUIjU+xm2UDDFanAsTjoWOT71fUiHoEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucfhdwNzqQrkMl+5dmtn4yGe5MguchzqFWL3O3/eOj1t1jOATp3hn6WoPJNVPy4jVVKWDMNSIjlBYHP/aVIOkfyaXhnTqKDGkrBPbfeetvFELKRocbydVlowP4JIcH9M9jGJL7tyCnX7B9SxB2lrWFtiRrHvUmmSPhxLpDY0B1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivCjJrUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2BDC4CEE7;
	Tue,  8 Apr 2025 12:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744115660;
	bh=36PuOkPXw44eUIjU+xm2UDDFanAsTjoWOT71fUiHoEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivCjJrUdr4OXRaR5VQykfDcGtcT0Wvjn8PTk6DFq4yDdSM+gYZSybptPOOJ5YfqB+
	 AyjPOwCmKJnoJku86byyv0wQstFrXl765BgEZYO4Bq9WntmX+ONyZRH+IhS/4AOjl0
	 ArUvzeR0f+C1RYrrPw1Qeu2iOCtllWxzXd14NYWkt8nJ6pWELJKCrDejssc/IbRZRu
	 /mPdjs5RFSXyxd7aD09zMzW3g9xxDVrAI7lBDSvNenynpT+2IfLt8UBVlxxgw2bIw0
	 ypONUETV30o5yLnAK4UkP/CdAfPi76In/D9jU2+oeIiJEdQ7EfznQpDxzTjlvwl5yo
	 50V1ul86lzJqA==
Date: Tue, 8 Apr 2025 15:34:13 +0300
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
Message-ID: <20250408123413.GA199604@unreal>
References: <bfc8ffb7ea207ed90c777a4f61a8afe1badef212.1744109826.git.leonro@nvidia.com>
 <20250408122338.GA1778492@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408122338.GA1778492@nvidia.com>

On Tue, Apr 08, 2025 at 09:23:38AM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 08, 2025 at 02:04:55PM +0300, Leon Romanovsky wrote:
> > diff --git a/net/rds/ib.c b/net/rds/ib.c
> > index 9826fe7f9d00..c62aa2ff4963 100644
> > --- a/net/rds/ib.c
> > +++ b/net/rds/ib.c
> > @@ -153,14 +153,6 @@ static int rds_ib_add_one(struct ib_device *device)
> >  	rds_ibdev->max_wrs = device->attrs.max_qp_wr;
> >  	rds_ibdev->max_sge = min(device->attrs.max_send_sge, RDS_IB_MAX_SGE);
> >  
> > -	rds_ibdev->odp_capable =
> > -		!!(device->attrs.kernel_cap_flags &
> > -		   IBK_ON_DEMAND_PAGING) &&
> > -		!!(device->attrs.odp_caps.per_transport_caps.rc_odp_caps &
> > -		   IB_ODP_SUPPORT_WRITE) &&
> > -		!!(device->attrs.odp_caps.per_transport_caps.rc_odp_caps &
> > -		   IB_ODP_SUPPORT_READ);
> 
> This patch seems to drop the check for WRITE and READ support on the
> ODP.

Right, and they are part of IBK_ON_DEMAND_PAGING support. All ODP
providers support both IB_ODP_SUPPORT_WRITE and IB_ODP_SUPPORT_READ.

RDS doesn't need to check more than general ODP support and can safely
rely on internal driver logic to create right MR.

Thanks

> 
> Jason

