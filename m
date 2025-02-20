Return-Path: <linux-rdma+bounces-7873-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8723AA3CFB4
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 03:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B72189D1A7
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 02:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFE91DC05F;
	Thu, 20 Feb 2025 02:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBDwQpZk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8621D8DE4;
	Thu, 20 Feb 2025 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020224; cv=none; b=aCjZL/oG3NRnWLs9Ag0AQwtWO//mYd3gZyuSBpVBPzrI3KGdCZtxvPJFWC4DsQawR+AEKdZXvircARYUQvt2RXlCTqnnhc+YDetmMeej0czQhHwgF+hMgQWCzMDzEYkQnTz9iScP3oqHFa6aMkMNTLPAA/xRpFPZHXvuoNrFhdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020224; c=relaxed/simple;
	bh=zVgovuXVZ4q88QdyAkhcTS22Eyu+EFR2/CUYe3ib2Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ws7JnK2UWltmlimAuX4AawqdIQ/vQoRcxoTrhMOtpBhh1dynzsUFCnEfhRLouUYxReFGqlcqadoKs6x6kM5FHClTd5mQvKdtm1Xw16cYGV/iSu390YUMJB8ToLAaWNdNO4JDfthxJVBjF86RDd9upuCglqlhoQdGQ1cYl/rtQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBDwQpZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6A7C4CED1;
	Thu, 20 Feb 2025 02:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740020223;
	bh=zVgovuXVZ4q88QdyAkhcTS22Eyu+EFR2/CUYe3ib2Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CBDwQpZk0/WQCm0LwestZJXWcJ2/fpBma3zlL4bttI3M56xlVAwPKPCXcXzbGP1vS
	 ldHiUHnri9YU+/oiAaGFOKK3AV96xuhL/Ym3pzn+2HmDWfe+/hYn2DLAc3u4Ojeson
	 toK1B7bpX9WXxXhnEmBlw9r+kzhYKinHwb2ROKCwCnA9PS9iDeU/7TLHqtJ8iUC5xT
	 qMLsfrGu2pCHhT0I/Uzq9noSus8SXV2sCiJ/0a/dNmabh3WjeeG8ZlDHV9pWDXrYBL
	 gyEwU07tKH61Gj73V866rO5ga3l01bBbCb7/yZVJZ4R1NqMwHKUH0lEN4FFEaP6MXV
	 /4x+iHXm3Kydg==
Date: Wed, 19 Feb 2025 18:57:01 -0800
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/rds: Replace deprecated strncpy() with
 strscpy_pad()
Message-ID: <202502191855.C9B9A7AA@keescook>
References: <20250219224730.73093-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219224730.73093-2-thorsten.blum@linux.dev>

On Wed, Feb 19, 2025 at 11:47:31PM +0100, Thorsten Blum wrote:
> strncpy() is deprecated for NUL-terminated destination buffers. Use
> strscpy_pad() instead and remove the manual NUL-termination.

When doing these conversions, please describe two aspects of
conversions:

- Why is it safe to be NUL terminated
- Why is it safe to be/not-be NUL-padded

In this case, the latter needs examination. Looking at how ctr is used,
it is memcpy()ed later, which means this string MUST be NUL padded or it
will leak stack memory contents.

So, please use strscpy_pad() here. :)

-Kees

> 
> Compile-tested only.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  net/rds/stats.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/rds/stats.c b/net/rds/stats.c
> index 9e87da43c004..cb2e3d2cdf73 100644
> --- a/net/rds/stats.c
> +++ b/net/rds/stats.c
> @@ -89,8 +89,7 @@ void rds_stats_info_copy(struct rds_info_iterator *iter,
>  
>  	for (i = 0; i < nr; i++) {
>  		BUG_ON(strlen(names[i]) >= sizeof(ctr.name));
> -		strncpy(ctr.name, names[i], sizeof(ctr.name) - 1);
> -		ctr.name[sizeof(ctr.name) - 1] = '\0';
> +		strscpy_pad(ctr.name, names[i]);
>  		ctr.value = values[i];
>  
>  		rds_info_copy(iter, &ctr, sizeof(ctr));
> -- 
> 2.48.1
> 
> 

-- 
Kees Cook

