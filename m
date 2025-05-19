Return-Path: <linux-rdma+bounces-10403-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 487F9ABB561
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 08:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B823D17288E
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 06:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD0C2580F1;
	Mon, 19 May 2025 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4VTDdJb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F562580D2;
	Mon, 19 May 2025 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747637618; cv=none; b=q1kAoXcuHBlFDjJHkkQTmcBzS+BAlJ++Ej2Nwxg59h5Q2g7NFGXtINPtgyQjj+RS46JM9kFlHcPPUcoTh0QhnpZKFYvElqFoILjZ/rBXA499CibQxCoCxiPKewpr58ZzNBcI5o/4Bu0MAI2Uw3YtczI4RLziVs53NxFzF2D9XjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747637618; c=relaxed/simple;
	bh=nBwP1grA6UIlhLhOYF5v2kN93NVunh0xAiFM5b1iJ/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1RHrUrp4S6aLBrUohfPgq1GWgiZFeJ0lB+jbrsyzX4AR1dYYAFBcjwuAQYB+/rqUCr1TqzwNr/jCDoE3b2t2+7hdqHyDyYagcyC0vM7LUZ/1P/lgzFFu8ORXUJ/LTYrPBgCjoKgaGg2vQkZpdjAZvtUioSOLhlQqQQuQIcnh84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4VTDdJb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747637617; x=1779173617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nBwP1grA6UIlhLhOYF5v2kN93NVunh0xAiFM5b1iJ/k=;
  b=b4VTDdJbZcTb+smaF9F5g+vcSYdtrOtUJflVnju13DND8vZ9oDaH0Plf
   hOnkT9lUNwLM1Sn6ckfHiBXVm4615dyqjoYyWOx0byMEdum6iDaZ1l7h4
   kShofN69a0KYo8qXWxy9BB3zjFZAXGQ65QGLLL/dAvgmS70MI1U9ZZCPz
   +aHGy5kbFjuUG7UA4saNScSpIaZ5oCyDpYtw389VDluCKadxA1aHGXWek
   j48OfjOttkpiav49mTbxmiDH5R1h1cOyeLDboNcMoKZddgryvBmndP9iK
   uLcqkpiJqe1o9r79lZ21OtI84aTh7XjQx+a87x6JYacc/Jc2DJxFP1gz5
   A==;
X-CSE-ConnectionGUID: 8Z3fqi1cTpiWkTne+ySwPg==
X-CSE-MsgGUID: AkmdLKvvThyJs2CAVoITaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="53197801"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="53197801"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 23:53:35 -0700
X-CSE-ConnectionGUID: 0IBbtwdSSeKHiGoetnGPqw==
X-CSE-MsgGUID: 6JJo0pwhQ5al/LNF9Dqz/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="144051944"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2025 23:53:31 -0700
Date: Mon, 19 May 2025 08:52:57 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: mlx5: vport: Add error handling in
 mlx5_query_nic_vport_qkey_viol_cntr()
Message-ID: <aCrVQOqV68u4AQkR@mev-dev.igk.intel.com>
References: <20250519034043.1247-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519034043.1247-1-vulab@iscas.ac.cn>

On Mon, May 19, 2025 at 11:40:43AM +0800, Wentao Liang wrote:
> The function mlx5_query_nic_vport_qkey_viol_cntr() calls the functuion
> mlx5_query_nic_vport_context() but does not check its return value. This
> could lead to undefined behavior if the query fails. A proper
> implementation can be found in mlx5_nic_vport_query_local_lb().
> 
> Add error handling for mlx5_query_nic_vport_context(). If it fails, free
> the out buffer via kvfree() and return error code.
> 
> Fixes: 9efa75254593 ("net/mlx5_core: Introduce access functions to query vport RoCE fields")
> Cc: stable@vger.kernel.org # v4.5
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/vport.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> index 0d5f750faa45..276b162ccf18 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> @@ -518,20 +518,23 @@ int mlx5_query_nic_vport_qkey_viol_cntr(struct mlx5_core_dev *mdev,
>  					u16 *qkey_viol_cntr)
>  {
>  	u32 *out;
> -	int outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);
> +	int ret, outlen = MLX5_ST_SZ_BYTES(query_nic_vport_context_out);

You can fix RCT here.

>  
>  	out = kvzalloc(outlen, GFP_KERNEL);
>  	if (!out)
>  		return -ENOMEM;
>  
> -	mlx5_query_nic_vport_context(mdev, 0, out);
> +	ret = mlx5_query_nic_vport_context(mdev, 0, out);
> +	if (ret)
> +		goto out;
>  
>  	*qkey_viol_cntr = MLX5_GET(query_nic_vport_context_out, out,
>  				   nic_vport_context.qkey_violation_counter);
> -
> +	ret = 0;

ret is already 0 here, no need to reassign it.

> +out:
>  	kvfree(out);
>  
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(mlx5_query_nic_vport_qkey_viol_cntr);
>  
> -- 
> 2.42.0.windows.2

