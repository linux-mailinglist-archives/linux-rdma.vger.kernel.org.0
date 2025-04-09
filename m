Return-Path: <linux-rdma+bounces-9293-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27292A824E7
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 14:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95ED93BE87E
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 12:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A18026562A;
	Wed,  9 Apr 2025 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiAt4ZzI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E44265618;
	Wed,  9 Apr 2025 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201740; cv=none; b=K1fdB/n+6BaFHGUt6BrvdNCgWAZy6GGY2My3nCqdfY5Sq1+hcb7ATJAx1LoelD74BUPVkfjzznaQBWSvxzAYVlLQl1oImzjPDiwhgKXTIk5bBJ5WNpq9yWAWieSWZfc+nxC/PBCIc5wlnCQOrBKA8kG+zvMPzxeu4oANs47+GAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201740; c=relaxed/simple;
	bh=wtupdBKCKrsUK/6yLonOTlHqsvrp3OSZjPjDOieysM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1SXQfo+w/HlduaoR5Io9oFtTGG6wr5taoBMHAjRBdIJpTF24qSBPCrFYiiU9AMJbG33AluAMYyPVvc/RVqXP2LGyO3IFM04160S1e13rggg3+vwG3MqnwCOE6TLysEpMOPlIYs2J6M4GVxZiO8C9fv02TAxg5S00D6yCXwvOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiAt4ZzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEAFC4CEE3;
	Wed,  9 Apr 2025 12:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744201739;
	bh=wtupdBKCKrsUK/6yLonOTlHqsvrp3OSZjPjDOieysM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oiAt4ZzI0ge1UviUR5vYKMvOh1APL+QvIBXs4FuOaWv68jJtua/7H93an4tjTEBKZ
	 TJ8f9t1aGLIRAq3vN5XBl2YPrTWM02HaIpvm1uH7oosvpGNLrc+nrfMMKsYPoh7ePK
	 jonWBx+/1z/R2Eqz8yIOIv/C2xPROQdYfb4q5zlRc2EeJbqAaYPkA1R7tOkIoL0fwe
	 j1ZfcTZu4ytHiLPocPdRnRMt658lOJ5dS6L6R2WSBhi+0aN8X2UmkPYIwUF+aUA1BU
	 bmUvd2/GI3jMc6zqksr6xd0Y7q/pFRwvSHGoHsta/W8yCM8TrA08JVdax74h8IT354
	 5lz4nMrsb8EtQ==
Date: Wed, 9 Apr 2025 15:28:52 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, pabeni@redhat.com, haiyangz@microsoft.com,
	kys@microsoft.com, edumazet@google.com, kuba@kernel.org,
	davem@davemloft.net, decui@microsoft.com, wei.liu@kernel.org,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/3] RDMA/mana_ib: Access remote atomic for MRs
Message-ID: <20250409122852.GL199604@unreal>
References: <1743777955-2316-1-git-send-email-kotaranov@linux.microsoft.com>
 <1743777955-2316-2-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1743777955-2316-2-git-send-email-kotaranov@linux.microsoft.com>

On Fri, Apr 04, 2025 at 07:45:53AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Add IB_ACCESS_REMOTE_ATOMIC to the valid flags for MRs and use
> the corresponding flag bit during MR creation in the HW.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/mr.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana/mr.c
> index f99557e..e4a9f53 100644
> --- a/drivers/infiniband/hw/mana/mr.c
> +++ b/drivers/infiniband/hw/mana/mr.c
> @@ -5,8 +5,8 @@
>  
>  #include "mana_ib.h"
>  
> -#define VALID_MR_FLAGS                                                         \
> -	(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ)
> +#define VALID_MR_FLAGS (IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ |\
> +			IB_ACCESS_REMOTE_ATOMIC)
>  
>  #define VALID_DMA_MR_FLAGS (IB_ACCESS_LOCAL_WRITE)
>  
> @@ -24,6 +24,9 @@ mana_ib_verbs_to_gdma_access_flags(int access_flags)
>  	if (access_flags & IB_ACCESS_REMOTE_READ)
>  		flags |= GDMA_ACCESS_FLAG_REMOTE_READ;
>  
> +	if (access_flags & IB_ACCESS_REMOTE_ATOMIC)
> +		flags |= GDMA_ACCESS_FLAG_REMOTE_ATOMIC;

Can you enable this flag unconditionally without relation to running RW?

Thanks

> +
>  	return flags;
>  }
>  
> -- 
> 2.43.0
> 

