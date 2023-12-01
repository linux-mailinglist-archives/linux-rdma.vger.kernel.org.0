Return-Path: <linux-rdma+bounces-180-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBC28010E8
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Dec 2023 18:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B541C20FD2
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Dec 2023 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D2A4E1B3;
	Fri,  1 Dec 2023 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McSw4rfD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7774F4E1A5;
	Fri,  1 Dec 2023 17:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5705DC433C8;
	Fri,  1 Dec 2023 17:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701450904;
	bh=9imA+PjoLqrLOoxVi5/Iuh+gS6tq7jj9z41mCaKLv/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=McSw4rfDke1GqvtRIDhNNjX31uBPm9qmLH+CAeZwguyMrSxef3daTaF+FmgfBin0u
	 9Yr+z1+Mima2f5S3LXQFZ9DufF/fA65MVsRxDsi3ScXv0gLI+SCvBzIx0t+7HGF6kW
	 R6hrYBRFwF/A/pyLDtd5awdUfy0KvNW9oOhsM8eKOcjUax++UdjgUqAvM8b0emAfCU
	 TtA8KavuqwoR1534313VAMu1Q+EsVR/1E/vzMA02wQFjV5RRr/L+tl9B/d3HFdbAyg
	 bTnKVAu6YwYhUFVN8kK8TeQx5X8mjuS9b+P/aM/k/ZYMQJfotmPtzL5BtTO/I84gGZ
	 fHFZOq7fDrqnw==
Date: Fri, 1 Dec 2023 19:15:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Shun Hao <shunh@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH mlx5-next 2/5] net/mlx5: Manage ICM type of SW encap
Message-ID: <20231201171500.GD6535@unreal>
References: <cover.1701172481.git.leon@kernel.org>
 <37dc4fd78dfa3374ff53aa602f038a2ec76eb069.1701172481.git.leon@kernel.org>
 <20231130181611.GL32077@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130181611.GL32077@kernel.org>

On Thu, Nov 30, 2023 at 06:16:11PM +0000, Simon Horman wrote:
> On Tue, Nov 28, 2023 at 02:29:46PM +0200, Leon Romanovsky wrote:
> > From: Shun Hao <shunh@nvidia.com>
> > 
> > Support allocate/deallocate the new SW encap ICM type memory.
> > The new ICM type is used for encap context allocation managed by SW,
> > instead FW. It can increase encap context maximum number and allocation
> > speed
> > 
> > Signed-off-by: Shun Hao <shunh@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> 
> ...
> 
> > @@ -164,6 +188,13 @@ int mlx5_dm_sw_icm_alloc(struct mlx5_core_dev *dev, enum mlx5_sw_icm_type type,
> >  						log_header_modify_pattern_sw_icm_size);
> >  		block_map = dm->header_modify_pattern_sw_icm_alloc_blocks;
> >  		break;
> > +	case MLX5_SW_ICM_TYPE_SW_ENCAP:
> > +		icm_start_addr = MLX5_CAP64_DEV_MEM(dev,
> > +						    indirect_encap_sw_icm_start_address);
> > +		log_icm_size = MLX5_CAP_DEV_MEM(dev,
> > +						log_indirect_encap_sw_icm_size);
> > +		block_map = dm->header_encap_sw_icm_alloc_blocks;
> > +		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -242,6 +273,11 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *dev, enum mlx5_sw_icm_type type
> >  						    header_modify_pattern_sw_icm_start_address);
> >  		block_map = dm->header_modify_pattern_sw_icm_alloc_blocks;
> >  		break;
> > +	case MLX5_SW_ICM_TYPE_SW_ENCAP:
> > +		icm_start_addr = MLX5_CAP64_DEV_MEM(dev,
> > +						    indirect_encap_sw_icm_start_address);
> > +		block_map = dm->header_encap_sw_icm_alloc_blocks;
> > +		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
> 
> Hi Leon and Shun,
> 
> a minor nit from my side: this patch uses MLX5_SW_ICM_TYPE_SW_ENCAP,
> but that enum value isn't present until the following patch.

Thanks, it was my mistake to reorder patches, will change to right order
and resubmit.

