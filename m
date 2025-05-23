Return-Path: <linux-rdma+bounces-10611-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8D2AC1D89
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 09:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3000B17D906
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 07:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C921C9E0;
	Fri, 23 May 2025 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZRIYEg9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C721C178;
	Fri, 23 May 2025 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747984796; cv=none; b=jONkYGLH/AhPSFOuMxMKXyWxfw75diYza5AzZuMO8tfi9zNGIhmWzsoCgObJOFEAKAK21TLTyGk95CnZsF9X7BPxHGeGXwJgUuoq1W/KtTR5ODAyh4j3aMYazsCf82SmFa8va8WmCcN95OPDQLH40IdjIlL7fazI8/FY87nfTJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747984796; c=relaxed/simple;
	bh=aEtUCaVHTrmJDEuedumuApTBnp00wSWAxrbB4vvfuSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF4xdCsgtdz5gtZzjTo5U++Xnrm6BMX4b1jyjTOr9ZJrBFyzi4sZdBXkcX079En/1V7WO0uIgEgKEOS7HWnN6RY42aecOM035InHQ/zbf2EMqOLWjt28Ws4HdRnO/CAxPf/RKJnmRj6LcwnCAx1Ws21M/7TvFOGlXVWiOJbNSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZRIYEg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC9AC4CEE9;
	Fri, 23 May 2025 07:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747984796;
	bh=aEtUCaVHTrmJDEuedumuApTBnp00wSWAxrbB4vvfuSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZRIYEg9qsgPAtly1UXn8khOlwhVwJ+LaiirtAQd1lEtfXDBWImjwIhfM7Ctr06Zx
	 aPV1gW7rrIZUpc3pkx9JTbEuBnMVRXZdKdl4C5UkgYPVi7zF0QOp01Y9uRtUs3Pzj4
	 z6XBtTZ2kvFnlYpUCuNDabtv0h+rvqNuQusUVSeYznJCsXsXh46QG/C/SweEh+qJP2
	 UtgMBaNs3ikjpA5Zd6fSZdEBR/xaaBSA2fk6RUCPlegprwVdTMRezE+WCV3jYzILaw
	 x3r0/bcrCySpCuML91lS6O6ooSXPbjESvfBR65Hls0bOmh1qSAl0xAmgKy6PiKOsb2
	 BoVVMfYNb0T/g==
Date: Fri, 23 May 2025 08:19:50 +0100
From: Simon Horman <horms@kernel.org>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net 2/2] net/mlx5e: Fix leak of Geneve TLV option object
Message-ID: <20250523071950.GP365796@horms.kernel.org>
References: <1747895286-1075233-1-git-send-email-tariqt@nvidia.com>
 <1747895286-1075233-3-git-send-email-tariqt@nvidia.com>
 <20250522191651.GL365796@horms.kernel.org>
 <1a8cb838-d487-4c56-8dfa-8179f305de02@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a8cb838-d487-4c56-8dfa-8179f305de02@nvidia.com>

On Fri, May 23, 2025 at 09:58:57AM +0800, Jianbo Liu wrote:
> 
> 
> On 5/23/2025 3:16 AM, Simon Horman wrote:
> > On Thu, May 22, 2025 at 09:28:06AM +0300, Tariq Toukan wrote:
> > > From: Jianbo Liu <jianbol@nvidia.com>
> > > 
> > > Previously, a unique tunnel id was added for the matching on TC
> > > non-zero chains, to support inner header rewrite with goto action.
> > > Later, it was used to support VF tunnel offload for vxlan, then for
> > > Geneve and GRE. To support VF tunnel, a temporary mlx5_flow_spec is
> > > used to parse tunnel options. For Geneve, if there is TLV option, a
> > > object is created, or refcnt is added if already exists. But the
> > > temporary mlx5_flow_spec is directly freed after parsing, which causes
> > > the leak because no information regarding the object is saved in
> > > flow's mlx5_flow_spec, which is used to free the object when deleting
> > > the flow.
> > > 
> > > To fix the leak, call mlx5_geneve_tlv_option_del() before free the
> > > temporary spec if it has TLV object.
> > > 
> > > Fixes: 521933cdc4aa ("net/mlx5e: Support Geneve and GRE with VF tunnel offload")
> > > Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> > > Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > > ---
> > >   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 7 ++++---
> > >   1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> > > index f1d908f61134..b9c1d7f8f05c 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> > > @@ -2028,9 +2028,8 @@ mlx5e_tc_add_fdb_flow(struct mlx5e_priv *priv,
> > >   	return err;
> > >   }
> > > -static bool mlx5_flow_has_geneve_opt(struct mlx5e_tc_flow *flow)
> > > +static bool mlx5_flow_has_geneve_opt(struct mlx5_flow_spec *spec)
> > >   {
> > > -	struct mlx5_flow_spec *spec = &flow->attr->parse_attr->spec;
> > >   	void *headers_v = MLX5_ADDR_OF(fte_match_param,
> > >   				       spec->match_value,
> > >   				       misc_parameters_3);
> > > @@ -2069,7 +2068,7 @@ static void mlx5e_tc_del_fdb_flow(struct mlx5e_priv *priv,
> > >   	}
> > >   	complete_all(&flow->del_hw_done);
> > > -	if (mlx5_flow_has_geneve_opt(flow))
> > > +	if (mlx5_flow_has_geneve_opt(&attr->parse_attr->spec))
> > >   		mlx5_geneve_tlv_option_del(priv->mdev->geneve);
> > >   	if (flow->decap_route)
> > 
> > Hi,
> > 
> > The lines leading up to the hung below are:
> > 
> > 	      err = mlx5e_tc_tun_parse(filter_dev, priv, tmp_spec, f, match_level);
> >                if (err) {
> >                          kvfree(tmp_spec);
> >                          NL_SET_ERR_MSG_MOD(extack, "Failed to parse tunnel attributes");
> >                          netdev_warn(priv->netdev, "Failed to parse tunnel attributes");
> > 
> > I am wondering if the same resource leak described in the patch description
> > can occur if mlx5e_tc_tun_parse() fails after it successfully calls
> > tunnel->parse_tunnel().
> > 
> 
> Yes, I missed that. I will fix in next version.

Thanks, much appreciated.

