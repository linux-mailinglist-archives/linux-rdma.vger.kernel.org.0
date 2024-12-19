Return-Path: <linux-rdma+bounces-6657-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357B39F7C4C
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 14:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DE2C7A51DD
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4055F224B1A;
	Thu, 19 Dec 2024 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjtZzZp/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0315B224B0C;
	Thu, 19 Dec 2024 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614777; cv=none; b=H1eQnaYwUOAqiBUTOdNW2NgdALkeVp2AztTFjhjVK1CToi9Q/db6+vsCvmBggFceFLsAoxigqiiOti2maeql32CfutlNNmGiw49B3UwQD5/XNPgpLdiqlgpqCvBdNiThrKjrl9ORce/OivgcqzRvSJ8D2qmEqO9gu4HuvmMwRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614777; c=relaxed/simple;
	bh=vI9Shmm0nwdv8XdhOxp6m7r/LSGT4zlOwCvERf5GSEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQxFuDaYZMOdtGbGznNrgvQRV1Qk5yf9RmDVjwUEQVOF87r/cyaKOCSmMMNIdP6RFhZ9ater8olU8duXl5cgFFMJ3hH75gKpHg0RerCrzWBrjnsbT5CQSMBf3L87imn7lBVm6DHsNnyLWNa8lthSKL9tkIHJdAyDXQnbDuymosk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjtZzZp/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734614775; x=1766150775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vI9Shmm0nwdv8XdhOxp6m7r/LSGT4zlOwCvERf5GSEk=;
  b=MjtZzZp/bzT5l4TToK04+oOD3W4hkY9CyChb8LobwlAbfaD1/6VKo7QL
   KuqhXb9JW1E4R8NJhN9riHWqdOnU8g4UPtVTODjK7n/Ed5Vx5n0U552uy
   2b+5R+mCpY8pWGPJQRwCQUlA1Feu28YuX90pJLaRaEQnWgx7WTbq6cbA8
   U75qUV4iMLO1mzhFiFCjKYGBYPZo/G1eHq3C4JMXqsdfQ8EHej2v7lFn8
   u2pXfw85nCTbcng/LMYxYee156rg8Y/yhRQnTMlqEgVH+sk3RDcBoQ/wY
   v3wYcc2TF12/hND9b1pOavIADO6H85NlcwKBrRDSp/0XlFVlQUKvG9lGe
   A==;
X-CSE-ConnectionGUID: cXPqi60zQRW3L3ttdJ5tfg==
X-CSE-MsgGUID: t9SnK+faSTmdSKnrQwXHBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="37964367"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="37964367"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:26:14 -0800
X-CSE-ConnectionGUID: yPGKzD65TdmrZid8e14Ehg==
X-CSE-MsgGUID: 88JXXY3FRDmWum8F7+sdbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="129158240"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:26:12 -0800
Date: Thu, 19 Dec 2024 14:23:04 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
	Francesco Poli <invernomuto@paranoici.org>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next] RDMA/mlx5: Enable multiplane mode only when it
 is supported
Message-ID: <Z2QeOOzRpimm3pyc@mev-dev.igk.intel.com>
References: <1ef901acdf564716fcf550453cf5e94f343777ec.1734610916.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef901acdf564716fcf550453cf5e94f343777ec.1734610916.git.leon@kernel.org>

On Thu, Dec 19, 2024 at 02:23:36PM +0200, Leon Romanovsky wrote:
> From: Mark Zhang <markzhang@nvidia.com>
> 
> Driver queries vport_cxt.num_plane and enables multiplane when it is
> greater then 0, but some old FWs (versions from x.40.1000 till x.42.1000),
> report vport_cxt.num_plane = 1 unexpectedly.
> 
> Fix it by querying num_plane only when HCA_CAP2.multiplane bit is set.
> 
> Fixes: 2a5db20fa532 ("RDMA/mlx5: Add support to multi-plane device and port")
> Cc: stable@vger.kernel.org
> Reported-by: Francesco Poli <invernomuto@paranoici.org>
> Closes: https://lore.kernel.org/all/nvs4i2v7o6vn6zhmtq4sgazy2hu5kiulukxcntdelggmznnl7h@so3oul6uwgbl/
> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 2 +-
>  include/linux/mlx5/mlx5_ifc.h     | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index c2314797afc9..f5b59d02f4d3 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -2839,7 +2839,7 @@ static int mlx5_ib_get_plane_num(struct mlx5_core_dev *mdev, u8 *num_plane)
>  	int err;
>  
>  	*num_plane = 0;
> -	if (!MLX5_CAP_GEN(mdev, ib_virt))
> +	if (!MLX5_CAP_GEN(mdev, ib_virt) || !MLX5_CAP_GEN_2(mdev, multiplane))
>  		return 0;
>  
>  	err = mlx5_query_hca_vport_context(mdev, 0, 1, 0, &vport_ctx);
> diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> index 4fbbcf35498b..48d47181c7cd 100644
> --- a/include/linux/mlx5/mlx5_ifc.h
> +++ b/include/linux/mlx5/mlx5_ifc.h
> @@ -2119,7 +2119,9 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
>  	u8	   migration_in_chunks[0x1];
>  	u8	   reserved_at_d1[0x1];
>  	u8	   sf_eq_usage[0x1];
> -	u8	   reserved_at_d3[0xd];
> +	u8	   reserved_at_d3[0x5];
> +	u8	   multiplane[0x1];
> +	u8	   reserved_at_d9[0x7];
>  
>  	u8	   cross_vhca_object_to_object_supported[0x20];

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Just out of curiosity, don't you have mlx5-net or sth like that for
fixes?

>  
> -- 
> 2.47.0

