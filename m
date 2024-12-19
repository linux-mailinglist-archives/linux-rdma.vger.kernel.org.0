Return-Path: <linux-rdma+bounces-6658-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F40139F7CBF
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 15:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F1F165DB9
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 14:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A348322576B;
	Thu, 19 Dec 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuMhjjkY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA3A225411;
	Thu, 19 Dec 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734616905; cv=none; b=BAw+NUw8FZ+rQT0SRgvDQH2HI+wTDddwc5esAOvslB01Ipz4WBRNxq4yu7g9wyAp3Hs3IjxxR2qvgisYBcVg4/+F4vn9TFfTBn6PRCXELKD7ws3qE/csn9bMjbNg+FYha5i55oBwcLOwOBTia1ciTBqZ+YpLialh+mh+1Wba+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734616905; c=relaxed/simple;
	bh=hSZhEtM6UOgAO96Kze7oeKsO79Zojos2sg8GTS86sYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6IFi+wez4tH3oXiTYg5GwMzaK9VeREU8c6kFYLXCsq6CB5Ne3H1szHLTdU0sp77PQnkvHftdBXLRA+TeGOpM59ZZ6NL98pKhx/NO7DbiO6bzRP37E/ntjDpXgOa5zlCz5c/Zyhih+eDEudWQ+1EvXwA7kjaIZ86yAb7uawbO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuMhjjkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F47C4CED0;
	Thu, 19 Dec 2024 14:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734616904;
	bh=hSZhEtM6UOgAO96Kze7oeKsO79Zojos2sg8GTS86sYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QuMhjjkYvCuvLVvq6QuQclUAE/QglkMkX8Ic8W+/QJlVl8SX5BVuR74eIOnrY7y0W
	 4VU1Rv2Lnx4PLBf4htBxnxfVgl8WLe+vWmB67/oujlgXczpTCW0wuwTSEOXAW8m/XQ
	 WWWJb6kGvl44HGHhQXFPH2BbsqWmyFQKpCYtDtRjkJwMJw0yB3K2qAK2vhE1GRcyMB
	 C1DcR8Q82ijGyq1pH/LNp8hv1wAPIhC2DqJknz7ULOZxkwWy2MvRrw1KKkLDBY5W04
	 xpOGiZNzSyERLyXScOJwWgohOMCV/0etIkTIglksc+TySiZw0rmW5xNhTkJWO91UTE
	 GdpNHCnU9IAwg==
Date: Thu, 19 Dec 2024 16:01:40 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
	Francesco Poli <invernomuto@paranoici.org>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next] RDMA/mlx5: Enable multiplane mode only when it
 is supported
Message-ID: <20241219140140.GE82731@unreal>
References: <1ef901acdf564716fcf550453cf5e94f343777ec.1734610916.git.leon@kernel.org>
 <Z2QeOOzRpimm3pyc@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2QeOOzRpimm3pyc@mev-dev.igk.intel.com>

On Thu, Dec 19, 2024 at 02:23:04PM +0100, Michal Swiatkowski wrote:
> On Thu, Dec 19, 2024 at 02:23:36PM +0200, Leon Romanovsky wrote:
> > From: Mark Zhang <markzhang@nvidia.com>
> > 
> > Driver queries vport_cxt.num_plane and enables multiplane when it is
> > greater then 0, but some old FWs (versions from x.40.1000 till x.42.1000),
> > report vport_cxt.num_plane = 1 unexpectedly.
> > 
> > Fix it by querying num_plane only when HCA_CAP2.multiplane bit is set.
> > 
> > Fixes: 2a5db20fa532 ("RDMA/mlx5: Add support to multi-plane device and port")
> > Cc: stable@vger.kernel.org
> > Reported-by: Francesco Poli <invernomuto@paranoici.org>
> > Closes: https://lore.kernel.org/all/nvs4i2v7o6vn6zhmtq4sgazy2hu5kiulukxcntdelggmznnl7h@so3oul6uwgbl/
> > Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/hw/mlx5/main.c | 2 +-
> >  include/linux/mlx5/mlx5_ifc.h     | 4 +++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > index c2314797afc9..f5b59d02f4d3 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -2839,7 +2839,7 @@ static int mlx5_ib_get_plane_num(struct mlx5_core_dev *mdev, u8 *num_plane)
> >  	int err;
> >  
> >  	*num_plane = 0;
> > -	if (!MLX5_CAP_GEN(mdev, ib_virt))
> > +	if (!MLX5_CAP_GEN(mdev, ib_virt) || !MLX5_CAP_GEN_2(mdev, multiplane))
> >  		return 0;
> >  
> >  	err = mlx5_query_hca_vport_context(mdev, 0, 1, 0, &vport_ctx);
> > diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> > index 4fbbcf35498b..48d47181c7cd 100644
> > --- a/include/linux/mlx5/mlx5_ifc.h
> > +++ b/include/linux/mlx5/mlx5_ifc.h
> > @@ -2119,7 +2119,9 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
> >  	u8	   migration_in_chunks[0x1];
> >  	u8	   reserved_at_d1[0x1];
> >  	u8	   sf_eq_usage[0x1];
> > -	u8	   reserved_at_d3[0xd];
> > +	u8	   reserved_at_d3[0x5];
> > +	u8	   multiplane[0x1];
> > +	u8	   reserved_at_d9[0x7];
> >  
> >  	u8	   cross_vhca_object_to_object_supported[0x20];
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> Just out of curiosity, don't you have mlx5-net or sth like that for
> fixes?

No, we don't have such as it is so rare situation that we have fix for
shared branch. I wrote here mlx5-next target because this patch changes
the shared mlx5_ifc.h file and for the visibility, but it doesn't affect
mlx5 eth devices.

Most likely, we will end taking this patch directly to rdma-rc and sending
as part of usual PR to Linus.

Thanks

> 
> >  
> > -- 
> > 2.47.0

