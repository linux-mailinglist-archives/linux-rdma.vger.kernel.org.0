Return-Path: <linux-rdma+bounces-9292-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989C9A824C5
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 14:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 072A17A941A
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 12:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7FE25F7BB;
	Wed,  9 Apr 2025 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUpXhjBS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827AC25E465;
	Wed,  9 Apr 2025 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201672; cv=none; b=pAUX8arppOiv+dg6i8cEpfYv7hXmBh2XHuBer00wh76e7DIBzd83ryp/DQsrSz+ycXoyxagqWZ5vfSI+bLNEGtPu+zRyunx6p1B3R2EcVE14ZVfpH+Gy52mXLsMksWTPF6ycXhh2NtU5Ksbj8urxlKAObHIXJorndYB37XEGkWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201672; c=relaxed/simple;
	bh=UWUJ/zhiy2NQqCWwL7gQRmfhzYNLNaLkHxcVvofj1mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAwSwTVL9/rAqdsBWBVHvBIHmZ8t03eF7AxBAeltDSJ9YftLiVSQN6CWDynM+omIaveMiOI3d7bjkC2YSA6odJHuBzv+j7MznNbqJmXGC4QDOPm10Pg9gURX9LUYp7UbcQ3fgOOHAY+aBt0Rbiq+/9sk4oYapIYtxJgI2L+8ZDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUpXhjBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D723DC4CEE3;
	Wed,  9 Apr 2025 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744201672;
	bh=UWUJ/zhiy2NQqCWwL7gQRmfhzYNLNaLkHxcVvofj1mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EUpXhjBS6zdYG83js+g7kEId6IQBIkY45mfX3eyQx3VUrWXLgLPXFmDl4iNTiUqyw
	 rP5WHnytSnug2Er3NhwEKw2qNyQH/NfH+ZvWrtBfLiXBxmOwC8k8yEhqHf8Ro/Fw21
	 14djSkCJW7XYbtDUeyYYF0rA4lceQt29nHfBaS5UMDddwG7H690P0nwjG+ilJTWiIN
	 ly/evac72+JpDRMUazSHH5al2N5smf/op3u109fbgelPA00t/Js5Y5feH4waS5hQaV
	 SakSFk2zyHm1/pch2/7Vt4qQ5OubW8i+hGWmu47gHVRtf65l5M8ulkHguzEjOJcnqq
	 su7iVg0j//Gjg==
Date: Wed, 9 Apr 2025 15:27:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, pabeni@redhat.com, haiyangz@microsoft.com,
	kys@microsoft.com, edumazet@google.com, kuba@kernel.org,
	davem@davemloft.net, decui@microsoft.com, wei.liu@kernel.org,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH rdma-next 3/3] RDMA/mana_ib: Add support of 4M, 1G, and
 2G pages
Message-ID: <20250409122743.GK199604@unreal>
References: <1743777955-2316-1-git-send-email-kotaranov@linux.microsoft.com>
 <1743777955-2316-4-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1743777955-2316-4-git-send-email-kotaranov@linux.microsoft.com>

On Fri, Apr 04, 2025 at 07:45:55AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Check PF capability flag whether the 4M, 1G, and 2G pages are
> supported. Add these pages sizes to mana_ib, if supported.
> 
> Define possible page sizes in enum gdma_page_type and
> remove unused enum atb_page_size.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/main.c             | 10 +++++--
>  drivers/infiniband/hw/mana/mana_ib.h          |  1 +
>  .../net/ethernet/microsoft/mana/gdma_main.c   |  1 +
>  include/net/mana/gdma.h                       | 30 ++++++++++---------
>  4 files changed, 25 insertions(+), 17 deletions(-)

<...>

>  enum gdma_page_type {
>  	GDMA_PAGE_TYPE_4K,
> +	GDMA_PAGE_SIZE_8K,
> +	GDMA_PAGE_SIZE_16K,
> +	GDMA_PAGE_SIZE_32K,
> +	GDMA_PAGE_SIZE_64K,
> +	GDMA_PAGE_SIZE_128K,
> +	GDMA_PAGE_SIZE_256K,
> +	GDMA_PAGE_SIZE_512K,
> +	GDMA_PAGE_SIZE_1M,
> +	GDMA_PAGE_SIZE_2M,
> +	/* Only when GDMA_DRV_CAP_FLAG_1_GDMA_PAGES_4MB_1GB_2GB is set */
> +	GDMA_PAGE_SIZE_4M,
> +	GDMA_PAGE_SIZE_1G = 18,
> +	GDMA_PAGE_SIZE_2G

Where are all these defines used?

Thanks

