Return-Path: <linux-rdma+bounces-3766-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABD992B969
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 14:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340441F26232
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 12:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D6E158A11;
	Tue,  9 Jul 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8r+Y+Qp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5352155A25
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jul 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528062; cv=none; b=dDnKStqhcS7SgRxH1rj0h9UkbmOhtD71LhlH9+VVfc8wYDwUACw/J8xMUjDcdYf/rLCNpDkghYSJpKobJTQWijr0VpTUkKlPzI5pVaJCJUrUxd8csfKIukC7wvBTbQZvMjO2zKxscSq5/rrm9+d0GHF/pvBV118kgXzR0KibKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528062; c=relaxed/simple;
	bh=pdPIKBcCgkEfbePTTNgIV2bPs6tSbPT1iQ5SQ8s0M7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ8Za7VSp43lxVNwMJ8imWEshfgXCSzXFGVnaqo0whemOUB4kG9H170acKRkTG+tezMXnho4Xq0kDx4yfzEEfGtAUdAuycIX3Oyic+LQOWlZoh9TwmdO1ZHCy0XwYS/j0MmEGMIyNQMC+Gw6BFjnOKUtQZuL/hLSJjkc5YXwaPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8r+Y+Qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4633C3277B;
	Tue,  9 Jul 2024 12:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720528062;
	bh=pdPIKBcCgkEfbePTTNgIV2bPs6tSbPT1iQ5SQ8s0M7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8r+Y+QplZxX7Fuyc79wBuBOmw9hl03GWh6dNfoACLrOxvVEZd/bd9VaiFtmLu6zr
	 w4yXzm3NY2XjsyUp/grH6Hkg8ShzIZqkJKO1lBumm4CaEfs7YbzWVpexNPujkgj2n3
	 dMfp4AArcRw0dnde3/+i4O6Zp008MNIyRLizfiEACpopXndS/zjDxKEyKRpLXvx5tt
	 yD7jUk3AH4xE+nvT02xawK/dOGTlLFDUNofD8B+gp3FyUD4SgAxAXUqoHS/p1yZQHL
	 1EwKcrxH3szMo1Fb9MUPHhatWuiM9+ppdkJKsPo8Lpy7EL1EJT6wVENyVbNfcg/++W
	 lnHuBFTu68eow==
Date: Tue, 9 Jul 2024 15:27:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: flyingpenghao@gmail.com
Cc: gg@ziepe.ca, nathan@kernel.org, linux-rdma@vger.kernel.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: Re: [PATCH]   infiniband/hw/ocrdma: increase frame warning limit in
 verifier when using KASAN or KCSAN
Message-ID: <20240709122737.GD6668@unreal>
References: <20240709105242.63299-1-flyingpeng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709105242.63299-1-flyingpeng@tencent.com>

On Tue, Jul 09, 2024 at 06:52:42PM +0800, flyingpenghao@gmail.com wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> When building kernel with clang, which will typically
> have sanitizers enabled, there is a warning about a large stack frame.
> 
> drivers/infiniband/hw/ocrdma/ocrdma_stats.c:686:16: error: stack frame size (20664) exceeds limit (8192) in 'ocrdma_dbgfs_ops_read' [-Werror,-Wframe-larger-than]
> static ssize_t ocrdma_dbgfs_ops_read(struct file *filp, char __user *buffer,
>                ^

Please fix it, not hide it.

Thanks

> 
> Increase the frame size by 20% to set.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  drivers/infiniband/hw/ocrdma/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/ocrdma/Makefile b/drivers/infiniband/hw/ocrdma/Makefile
> index 14fba95021d8..a1e9fcc04751 100644
> --- a/drivers/infiniband/hw/ocrdma/Makefile
> +++ b/drivers/infiniband/hw/ocrdma/Makefile
> @@ -3,4 +3,10 @@ ccflags-y := -I $(srctree)/drivers/net/ethernet/emulex/benet
>  
>  obj-$(CONFIG_INFINIBAND_OCRDMA)	+= ocrdma.o
>  
> +ifneq ($(CONFIG_FRAME_WARN),0)
> +ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
> +CFLAGS_ocrdma_stats.o = -Wframe-larger-than=22664
> +endif
> +endif
> +
>  ocrdma-y :=	ocrdma_main.o ocrdma_verbs.o ocrdma_hw.o ocrdma_ah.o ocrdma_stats.o
> -- 
> 2.27.0
> 
> 

