Return-Path: <linux-rdma+bounces-11988-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE0CAFDC00
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 01:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F67F1C23A17
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 23:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1544223A563;
	Tue,  8 Jul 2025 23:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nL1cry+1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEB221CA02
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752019092; cv=none; b=rq7xDJD5gd9jq/50o3NbbPd7EHX9KW5NiPJZ2arLkEgTQTBqYPnBpHCqUVajVl7hRPFnQU+o75H/LvmeBzqzULvZHE6dzzx6kqEe+0FDEgTcglAJldWnl71Gq8qB5zosEdYf2Y/B2Jzb4MbmZ/SPh6+YnIjetjnX6rN7ElZM7vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752019092; c=relaxed/simple;
	bh=9361ghef/eDTTsJjWoy6HRS6XIQpk5gBomddJa6zPNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3mIjLTdN3FhauF7H2vQPFHe+I59nwngdwXhW4Ev+/ZNyA/HKeee1RNHMTwF2/JpSCxEW/FGGHwVnKEWpk3gL/2+G0KT1Fco8I/8NktkS6XPlcqJITtLttfBIgaaaYdCjG9txDGmEF27d4W4w++PbEo8D14AEo7JnA//0AzntFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nL1cry+1; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b202d1f7-7d73-430a-b725-58ca91a21b3f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752019084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l1FORc+tGKcauxUwXqeLOTIToMi+Az2I12s5bhJezkI=;
	b=nL1cry+1xzHAg86acLWSDnPg9ra1AwFzTa8yIzWdiWRr7iGKL/m6lgswhDhPmFEpymSYS5
	0azb93C3wKs5UmmMubI8+6NmRJI86GTzMi3tZTGS+/GRGDu9+01zsz5tE3x8H4kCJLADsO
	QBwPLYHGhhOCwbwJ7+wWP7gxNYYdSx4=
Date: Tue, 8 Jul 2025 16:57:55 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next] RDMA/uverbs: Add empty
 rdma_uattrs_has_raw_cap() declaration
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, kernel test robot <lkp@intel.com>,
 linux-rdma@vger.kernel.org, Parav Pandit <parav@nvidia.com>
References: <72dee6b379bd709255a5d8e8010b576d50e47170.1751967071.git.leon@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <72dee6b379bd709255a5d8e8010b576d50e47170.1751967071.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/8/25 2:31 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The call to rdma_uattrs_has_raw_cap() is placed in mlx5 fs.c file,
> which is compiled without relation to CONFIG_INFINIBAND_USER_ACCESS.
> 
> Despite the check is used only in flows with CONFIG_INFINIBAND_USER_ACCESS=y|m,
> the compilers generate the following error for CONFIG_INFINIBAND_USER_ACCESS=n
> builds.
> 
>>> ERROR: modpost: "rdma_uattrs_has_raw_cap" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> 
> Fixes: f458ccd2aa2c ("RDMA/uverbs: Check CAP_NET_RAW in user namespace for flow create")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507080725.bh7xrhpg-lkp@intel.com/
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   include/rdma/ib_verbs.h | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index c263327a0205..ce4180c4db14 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -4841,15 +4841,19 @@ struct ib_ucontext *ib_uverbs_get_ucontext_file(struct ib_uverbs_file *ufile);
>   
>   #if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
>   int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs);
> +bool rdma_uattrs_has_raw_cap(const struct uverbs_attr_bundle *attrs);
>   #else
>   static inline int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs)
>   {
>   	return 0;
>   }
> +static inline bool
> +rdma_uattrs_has_raw_cap(const struct uverbs_attr_bundle *attrs)
> +{
> +	return false;
> +}
>   #endif

The function rdma_uattrs_has_raw_cap is implemented in the file 
rdma_core.c. This file is included in the build via the Makefile:

"
...
ib_uverbs-y := uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
                rdma_core.o uverbs_std_types.o uverbs_ioctl.o \
                ...
"
As a result, rdma_core.o is compiled only when 
CONFIG_INFINIBAND_USER_ACCESS is enabled.

In other words, the implementation of the rdma_uattrs_has_raw_cap 
function is guarded by CONFIG_INFINIBAND_USER_ACCESS.

Given this, it is reasonable to move the declaration of 
rdma_uattrs_has_raw_cap into the scope of CONFIG_INFINIBAND_USER_ACCESS 
in ib_verbs.h.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>   
> -bool rdma_uattrs_has_raw_cap(const struct uverbs_attr_bundle *attrs);
> -
>   struct net_device *rdma_alloc_netdev(struct ib_device *device, u32 port_num,
>   				     enum rdma_netdev_t type, const char *name,
>   				     unsigned char name_assign_type,


