Return-Path: <linux-rdma+bounces-12049-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596ACB00CE6
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 22:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7930AB4066F
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 20:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22FD2FE37B;
	Thu, 10 Jul 2025 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HBhLjKoR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8912FD59B
	for <linux-rdma@vger.kernel.org>; Thu, 10 Jul 2025 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178390; cv=none; b=C8Okn4CmtRROwwYALgCw6bfG/oAXB0W33iEFiF/8KUoF6LEEBmJrhnNYLasmWGh/9G0/l99AYzrzM/qbFfPLWMwTOu4wPtYSqO09c+0ViKSnKY+TA5RIW5ttZcT3dFIzyYyzZFdHEvdGlSPCrfyYha7R+VSDG23mt6N/BwTO2hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178390; c=relaxed/simple;
	bh=QCPVg61VylJXSuOMu9ZsxYQ07cmHN5/YuDlXLVOQtMQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QszbfbipAKUQUy5+rBdu/PDhzIFZlDw+vfVigxru/+6kXVmFETe7rAxCzP0hfeGBLxDVac0XFHaOO7uosJ3Ub7P5/xO8x2UZLU4ptOC10VDnyJOFJB712MrezCh3/ougBYl2DgVdCSJU1qtqqZKq4T9qb9zQiN0p54oEddZAOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HBhLjKoR; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <94e50246-5182-4b73-be59-9ce8e9afcfbb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752178377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMIXZWRDryeb5XrtMvENUKhI8DusK3gp45x6ISsgw14=;
	b=HBhLjKoRBc0StGL3Mt+MLswKCg4OuIXp/T9z+rXzDnaXp1HF4xV6ufxE3FnGqCZBqSTyPV
	HmUsvWp5IWjRXcXo/IsDzIkf3hZf+/XB61OTKUIysI+cuJBbDqqD1BBlxRz1cbXYr2wefz
	/lPXB8Yukao5pVW/JRkGPPEnWnq5Iq4=
Date: Thu, 10 Jul 2025 13:12:52 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
Subject: Re: [PATCH] RDMA/mlx5: fix linking with
 CONFIG_INFINIBAND_USER_ACCESS=n
To: Arnd Bergmann <arnd@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Parav Pandit <parav@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Bloch <mbloch@nvidia.com>,
 Patrisious Haddad <phaddad@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250710080955.2517331-1-arnd@kernel.org>
Content-Language: en-US
In-Reply-To: <20250710080955.2517331-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/10/25 1:09 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The check for rdma_uattrs_has_raw_cap() is not possible if user
> access is disabled:
> 
> ERROR: modpost: "rdma_uattrs_has_raw_cap" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!

https://patchwork.kernel.org/project/linux-rdma/patch/72dee6b379bd709255a5d8e8010b576d50e47170.1751967071.git.leon@kernel.org/

The issue you described seems to be the same as the one discussed in the 
link above. Could you try applying the commit from that link and see if 
the problem still persists?

Yanjun.Zhu

> 
> Limit the check to configurations that have the option enabled
> and instead assume the capability is not there otherwise.
> 
>  From what I can tell, the UVERBS code in fs.c is not actually called
> when INFINIBAND_USER_ACCESS is turned off, so this haz no effect
> other than fixing the link error. A better change might be to not
> build the code at all in that configuration, but I did not see
> an obvious way to do that.
> 
> Fixes: 95a89ec304c3 ("RDMA/mlx5: Check CAP_NET_RAW in user namespace for flow create")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> If there is a better way of addressing the link failure, please just
> treat this as a bug report
> ---
>   drivers/infiniband/hw/mlx5/fs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
> index bab2f58240c9..c1ec9aa1dfd3 100644
> --- a/drivers/infiniband/hw/mlx5/fs.c
> +++ b/drivers/infiniband/hw/mlx5/fs.c
> @@ -2459,7 +2459,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
>   	struct mlx5_ib_dev *dev;
>   	u32 flags;
>   
> -	if (!rdma_uattrs_has_raw_cap(attrs))
> +	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS) ||
> +	    !rdma_uattrs_has_raw_cap(attrs))
>   		return -EPERM;
>   
>   	fs_matcher = uverbs_attr_get_obj(attrs,


