Return-Path: <linux-rdma+bounces-7697-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E56A3378B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 06:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1491168569
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 05:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAC2206F18;
	Thu, 13 Feb 2025 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9LQT4rh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE3E2063DB;
	Thu, 13 Feb 2025 05:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739425855; cv=none; b=R2Eui1oP2xqEfxvkm1MUA7CV61hGAFhimpAYTYaim5IYZ5hXBs73mlkRoSCZuEKUHa1ezE5lnP4TROgkDOCs61sTy1JgUlIDGe4Qi0XxjTegAqFnlOSjlu85LoEuXIfIjJjVA4H4LCqF71CIZRsJEl3/Mh7JYn2ZhAM7jESGYUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739425855; c=relaxed/simple;
	bh=lHllTOckj62DvxFMO4ex25j5C0vpTrjk+U+h4A/42pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuS/7oPKExdUTkAAe66kYnTU3Si+vDmAjbFa03S/xMzFpZo6W2x6ZQ+/3PDQjV2gKh8/Yo11AyfSiKvaLYtXQ2DmpkyyoRg51Yijya7horJmmvXrfa1NlY5n9D2En0sm56MNoExBFkpXOtARtarbxdHSuT3pUXhxv/afjyyjAQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9LQT4rh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739425854; x=1770961854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lHllTOckj62DvxFMO4ex25j5C0vpTrjk+U+h4A/42pQ=;
  b=E9LQT4rhveleK6EeruG3ywgnLHd8biziDQ+ozMjyy9NGJ5B+gGW1308l
   v0/7WNz0EQOOa2Ih2Ny3WQMdC9AWouGKpkS0PKdhWrqrK6zp2zGiIPLS+
   Z7RdFyulcMWXHMr1eVhSaw3ppaM8SQGsE2CmKiKiYIwnWS41SoC/K1/Dk
   glHqgxjPytvN+e2APvp1sG86uJvy/AMiFBE+OUUq8tmOHCJzWFTr14gUv
   uUn4SSX4Wm2wUGkIqBzthTgBpJFXAWJVi+m4iBHUVr5qj3uriLQu1wk8n
   JQ3SSiajUhkq8eZkSmxEeXd1k0UvG9WUrkgYOeMKybzYGbPC4fWEtxoLS
   w==;
X-CSE-ConnectionGUID: mO/7qVxOS2igOQ//KBk8Zg==
X-CSE-MsgGUID: 6edW2TbzSrOnZCZteUywRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="50735646"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="50735646"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 21:50:52 -0800
X-CSE-ConnectionGUID: 0eLb8kH0R9WbKxHK25TPGw==
X-CSE-MsgGUID: z8+jw21CQ0aS1HnEzgCRxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="118043724"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 21:50:49 -0800
Date: Thu, 13 Feb 2025 06:47:16 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] ice, irdma: fix an off by one in error handling code
Message-ID: <Z62HZM0xjSWSSBiL@mev-dev.igk.intel.com>
References: <47e9c9a0-c943-440c-aea7-75ff189c5f97@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47e9c9a0-c943-440c-aea7-75ff189c5f97@stanley.mountain>

On Wed, Feb 12, 2025 at 06:25:44PM +0300, Dan Carpenter wrote:
> If we don't allocate the MIN number of IRQs then we need to free what
> we have and return -ENOMEM.  The problem is this loop is off by one
> so it frees an entry that wasn't allocated and it doesn't free the
> first entry where i == 0.
> 
> Fixes: 3e0d3cb3fbe0 ("ice, irdma: move interrupts code to irdma")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/infiniband/hw/irdma/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
> index 1ee8969595d3..5fc081ca8905 100644
> --- a/drivers/infiniband/hw/irdma/main.c
> +++ b/drivers/infiniband/hw/irdma/main.c
> @@ -221,7 +221,7 @@ static int irdma_init_interrupts(struct irdma_pci_f *rf, struct ice_pf *pf)
>  			break;
>  
>  	if (i < IRDMA_MIN_MSIX) {
> -		for (; i > 0; i--)
> +		while (--i >= 0)
>  			ice_free_rdma_qvector(pf, &rf->msix_entries[i]);
>  
>  		kfree(rf->msix_entries);

Przemek pointed that in the review, but somehow I missed that :( .
Thanks for fixing:
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.47.2
> 

