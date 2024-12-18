Return-Path: <linux-rdma+bounces-6615-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C45479F5E40
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2024 06:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CB01673F1
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2024 05:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA55214F9EB;
	Wed, 18 Dec 2024 05:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHgwd3Ib"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F65E154BE2;
	Wed, 18 Dec 2024 05:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734499362; cv=none; b=TS1uqwQRmKqTZzyYIxDmoKGR4tipefwvuSJSwdJG6+Bd8MKuOo9jB2vdWymgufmhF/FtIJrLCmipC+Mn9FKz+2i1eoFD9+PNsPqx2lSMPcb0iI/cEz3YjI9tuyB+cuAbFaGebpR1FiWYzrTSSo0UcFa74Oe7Rd9+MiNbznz6XAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734499362; c=relaxed/simple;
	bh=pKGixUq0wqQUsfZk5Td9IQcLTzvRWnZb+7UOXPDGSpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxX0zNvfK4IJNZBxsL/oXhS3KGsd0I4f9dq9ARFCoksQD3viDYtpBbMaEaeR0SbzNxlVOoGFy3u0IdiCB78XAvv2LjcLG37EAbFr1ebEay2Eh80WadXHZcI5tqb3quw+F1yozmQJdHL4xD+Madlx31+GW1sR55ixnt8x7JTE6aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHgwd3Ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC9EC4CECE;
	Wed, 18 Dec 2024 05:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734499362;
	bh=pKGixUq0wqQUsfZk5Td9IQcLTzvRWnZb+7UOXPDGSpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHgwd3Ibgj8KOhXD9Oua9LMFo5VsS250nMIXWQ16SF6PZAd9ksew8n5j1jeSlR8zI
	 hZ4oqxc7nT4g3E9VrnKyJUyqkE6mPYNqn6g/6pqnw0rqk54ipxgYxcDnIx9hNT5WXA
	 opK9pj20ZXYXhHloszLqB6FzMaiY4PZSOegxuGviCyoGv2M7o/rreOm2tpA+0igP0Q
	 XPCTgwvYrB6o1gsbnbApzosLjUxvu+mcetzrfs/yrpDXyZEbUQ5uhVmNZEZljY3u2b
	 00FGmjt4R0dh68ydP7Ob+RaF1SRVZ+UaZs7OfLPgVH6fiNNnnliAl1IpbuhWz9JsU6
	 EIHXbpy7zsrFw==
Date: Tue, 17 Dec 2024 21:22:39 -0800
From: Kees Cook <kees@kernel.org>
To: Moshe Shemesh <moshe@nvidia.com>, morbo@google.com,
	qing.zhao@oracle.com
Cc: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	linux-rdma@vger.kernel.org, Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 05/12] net/mlx5: fs, add mlx5_fs_pool API
Message-ID: <202412172115.C7FDE7BA@keescook>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-6-tariqt@nvidia.com>
 <20241212172355.GE73795@kernel.org>
 <70b3a7b5-abd3-4db4-8415-e0467a565847@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70b3a7b5-abd3-4db4-8415-e0467a565847@nvidia.com>

On Sun, Dec 15, 2024 at 03:39:11PM +0200, Moshe Shemesh wrote:
> 
> 
> On 12/12/2024 7:23 PM, Simon Horman wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Dec 11, 2024 at 03:42:16PM +0200, Tariq Toukan wrote:
> > > From: Moshe Shemesh <moshe@nvidia.com>
> > > 
> > > Refactor fc_pool API to create generic fs_pool API, as HW steering has
> > > more flow steering elements which can take advantage of the same pool of
> > > bulks API. Change fs_counters code to use the fs_pool API.
> > > 
> > > Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> > > Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> > > Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> > > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
> > 
> > ...
> > 
> > > @@ -447,11 +437,9 @@ void mlx5_fc_update_sampling_interval(struct mlx5_core_dev *dev,
> > >   /* Flow counter bluks */
> > > 
> > >   struct mlx5_fc_bulk {
> > > -     struct list_head pool_list;
> > > +     struct mlx5_fs_bulk fs_bulk;
> > >        u32 base_id;
> > > -     int bulk_len;
> > > -     unsigned long *bitmask;
> > > -     struct mlx5_fc fcs[] __counted_by(bulk_len);
> > > +     struct mlx5_fc fcs[] __counted_by(fs_bulk.bulk_len);
> > >   };
> > 
> > Unfortunately it seems that clang-19 doesn't know how to handle
> > __counted_by() when used like this:
> > 
> > drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c:442:36: error: 'counted_by' argument must be a simple declaration reference
> >    442 |         struct mlx5_fc fcs[] __counted_by(fs_bulk.bulk_len);
> 
> Thanks Simon, from code perspective, bulk_len should be now in the inner
> struct fs_bulk.
> 
> Keen Cook, is that going to be supported in the future? for now I will just
> remove __counted_by() from this struct.

I am expecting this will be supported in the future, yes, but there isn't
an ETA for it yet. Neither GCC 15 nor Clang are currently supporting
sub-struct members -- the counted_by member needs to be at the same
"level" in the struct as the annotated flexible array.

Is it possible to move "base_id" above "fs_bulk" and move "fcs" into
the of end struct mlx5_fs_bulk?

-Kees

-- 
Kees Cook

