Return-Path: <linux-rdma+bounces-13230-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A82CEB51362
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 12:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8540F7ACB2F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D723F26B;
	Wed, 10 Sep 2025 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0ArAIPW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960931D361;
	Wed, 10 Sep 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498466; cv=none; b=Bk+vO1qsbIEE3j8EMTdRCFVkDYBdttnO9IgFo6GjkEj0nD2YFbc9SIo/IMlObFkGXCczpi1lE+vtov6XO89sqdYyE1j54oyRFIqUKl9vsg47EF8dE8sixUo5ACKz49e4kk1fitjVHQ4uqI8yI2phQ0OujvimQb8YGXEHfJcskNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498466; c=relaxed/simple;
	bh=G54EZvV6TYh/6aRiLS/VHoanwwYRL6VCM+nMKElEI20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHFWDcql/xNyXSH8EZgQ1hF0A9azztCfH/0aCnqyDj+N4Qgt3Fz6eUnkcwkkkFaY8q+V40SFrqBOynayr3fnxLeuJKeUJRfDK4wmdLII+VDM4MxqhWfKDfV8aPEtdSQsbGm9BFz1wy43fVXQqeBHiY4jnOzKtQd8kQK1+CK6NPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0ArAIPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D25CC4CEF0;
	Wed, 10 Sep 2025 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757498465;
	bh=G54EZvV6TYh/6aRiLS/VHoanwwYRL6VCM+nMKElEI20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0ArAIPWssOq42cLhTYSaTOOEJ3f4TBdM/d8YerpuWgBriQtXuyvU+81knfjxYXt5
	 NV1+P14kcqIt+EbTzbRGCUbdEM/UHfatAA2R5KTwKqiapdE1S25UYnLqPh7ObG7Lgv
	 YeDAqGlHqMjJ7uhjLZU4hA1VFYuuIYBwwYRkkjN8rUoURyeU8StIcihBmdnXggdn1A
	 sAug9yL8h/isBavawkJzfdFyz5tY01zNuSYyK+Nw3NzLC61UPM89My7GuKULLmoVte
	 cVgTrHOnuIjWrK16Yok8x6ljiChFtIx+9pPfoP2Lnvy+XrJSa0QGT6mV886AjC6Ehz
	 o3ai+1/N+usZw==
Date: Wed, 10 Sep 2025 13:01:00 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] net/smc: replace strncpy with strscpy for ib_name
Message-ID: <20250910100100.GM341237@unreal>
References: <20250908180913.356632-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908180913.356632-1-kriish.sharma2006@gmail.com>

On Mon, Sep 08, 2025 at 06:09:13PM +0000, Kriish Sharma wrote:
> Replace the deprecated strncpy() with strscpy() for ib_name in
> smc_pnet_add_ib(). The destination buffer should be NUL-terminated and
> does not require any trailing NUL-padding. Since ib_name is a fixed-size
> array, the two-argument form of strscpy() is sufficient and preferred.
> 
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  net/smc/smc_pnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 76ad29e31d60..b90337f86e83 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -450,7 +450,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
>  		return -ENOMEM;
>  	new_pe->type = SMC_PNET_IB;
>  	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
> -	strncpy(new_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX);
> +	strscpy(new_pe->ib_name, ib_name);

It is worth to mention that caching ib_name is wrong as IB/core provides
IB device rename functionality.

Thanks

>  	new_pe->ib_port = ib_port;
>  
>  	new_ibdev = true;
> -- 
> 2.34.1
> 
> 

