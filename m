Return-Path: <linux-rdma+bounces-3820-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BC992E4A2
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 12:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D682810A5
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 10:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA404158878;
	Thu, 11 Jul 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5w4w6Dj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D2015A85A
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693573; cv=none; b=dld1Y004lOUTls6QIXq6ppTGZVcsS3U43gC2lUxWvBVRVCjgMek7KzI9vRX5tjfRx3SyzWCcBCxSVaIhOQaDPFD1+PLOO8cVm7o+nBNaEhe/tg+Ki480XeJxq7aPgOtZWLUr57471QcIjeTvhM6Y8stlpK4SRpVyuwPIyKEmWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693573; c=relaxed/simple;
	bh=dWJ2lhUr3TDrK2SvrT3xGyIyIPBAZgj7KjwJyn99NMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yb6RfLnmv172+xjgH70E+zMLnX/GdyQ/2H93Wo+TCjb7luc+Fgeq7/apb3Nc/X/50ntFcqCCT8ZQos4RLTj2XoO4W92jDmKPZm5+/js2tHoPzHmQEUnGMmTcOohTaI6c06c0PWN6EhWB9QM22C3OZo40kslRmcf05Rz8+KPPFMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5w4w6Dj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23807C116B1;
	Thu, 11 Jul 2024 10:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720693572;
	bh=dWJ2lhUr3TDrK2SvrT3xGyIyIPBAZgj7KjwJyn99NMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5w4w6DjVIbXFFivIpJ9OVtJoyW3GNoSaILfdrV74/I5wY2cmuQ3kPLEcyW1pOH8m
	 glrNJpfFcpbJVl2KfnaDN4H1VV+HuO3Jusd3AZEABguvm7ELnp7JlEyvVGGPTm7YfG
	 GQUE7tAZbarcMkLYUkKqdfqh45XJ3OeM8ce+p/NcmpO0OtLfGAjiQFqngYO7Gl/YeE
	 w5nV42iI16gruCeRdI8nOJeIkxYZuTOcbiojp2UtAMM1idIYl3Lz8+TJzsE4ZQsmR8
	 SrPw5YtF+dJ1EJq/iFEub6BizhiRExd1EJjXbtrD9hqGpQUqo+6xt4/TP1guSF8Mpx
	 x22mdQN02oj0g==
Date: Thu, 11 Jul 2024 13:26:08 +0300
From: Leon Romanovsky <leon@kernel.org>
To: flyingpenghao@gmail.com
Cc: gg@ziepe.ca, nathan@kernel.org, linux-rdma@vger.kernel.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: Re: [PATCH v3]  infiniband/hw/ocrdma: make function ocrdma_add_stat
 as noinline_for_stack
Message-ID: <20240711102608.GR6668@unreal>
References: <20240711085647.81004-1-flyingpeng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711085647.81004-1-flyingpeng@tencent.com>

On Thu, Jul 11, 2024 at 04:56:47PM +0800, flyingpenghao@gmail.com wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> clang report:
> drivers/infiniband/hw/ocrdma/ocrdma_stats.c:686:16: error: stack frame size (20664) exceeds limit (2048) in 'ocrdma_dbgfs_ops_read' [-Werror,-Wframe-larger-than]
> static ssize_t ocrdma_dbgfs_ops_read(struct file *filp, char __user *buffer,
>                ^
> 
> A 128-byte array is defined in ocrdma_add_stat and is called multiple times
> by multiple functions (up to dozens of times), which results in a large amount
> of stack space being accumulated in ocrdma_dbgfs_ops_read. mark it as noinline_for_stack
> to prevent it from spreading to ocrdma_dbgfs_ops_read's stack size.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  drivers/infiniband/hw/ocrdma/ocrdma_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I merged this patch with https://lore.kernel.org/r/20240710091657.26291-1-flyingpeng@tencent.com

Thanks

> 
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
> index 5f831e3bdbad..0b26c4e6de53 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
> @@ -46,7 +46,7 @@
>  
>  static struct dentry *ocrdma_dbgfs_dir;
>  
> -static int ocrdma_add_stat(char *start, char *pcur,
> +static noinline_for_stack int ocrdma_add_stat(char *start, char *pcur,
>  				char *name, u64 count)
>  {
>  	char buff[128] = {0};
> -- 
> 2.27.0
> 
> 

