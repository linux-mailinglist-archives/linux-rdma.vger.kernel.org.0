Return-Path: <linux-rdma+bounces-7573-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEDAA2D1F2
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 01:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C98169CF9
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2025 00:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4B7A937;
	Sat,  8 Feb 2025 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSN8vdJp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70FFD528;
	Sat,  8 Feb 2025 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974269; cv=none; b=FUCBZ+ltJHi3rLmH7PtWh422YHRojTdD6u2EoRjGlLTGQ86vuPKd1umUhEEHXxpmvMcP5swdprc7Djol49a0kGVhz8xGJiWdrCy0lcljrKWqjVarDSvJkzNwU+0TbWhqgb6zrjLsDy/bYtV4LCLSEcOBuEpejBfk4qsswp1zul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974269; c=relaxed/simple;
	bh=ahQj+V5er1m7Zc89Bojm87PqLdkX1UrTeL6qrBYoilU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9TSmaaXpqY7r6YFkgTwhEqTq9bHXlMXhW3Nk+tT3TNF2k3cqhtSR6NnHtskSfV6IsIWnmd46hVu6vIBZfec0Ir+PSEgBK7jZ1pFcIMW9B7TVKVNck00QHCYsC6tfmMzJgwV9gMkwC9kQs9RjHeUWz+7Z8fw2sungCkldZ8r4eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSN8vdJp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738974267; x=1770510267;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ahQj+V5er1m7Zc89Bojm87PqLdkX1UrTeL6qrBYoilU=;
  b=HSN8vdJpT7qoOKLFSK9AKnCnWdV9zg9vMesDcQ1lAIR1JTqUfFk5L5wL
   thv17uqlS6z7D3YuAWE9/t8trjJ5M7cX5k+3wUnYjgqASKHAwhSirt/8J
   XcRTmK8Tn3Nf2ivyIx+cfYiIVQTU6okVQraUq3ytyn61hKqvvGJsOfAVI
   cpZjI2+XF2s9R06suEnP1nS9iYA6oK4tDcrj+7FiIgdPuJzVEE/U1+hI/
   PPLneC1QmYcdrU15VyKIs/aN7gnK1GN1g9oL1lww1n54TPGk/AZZAHkVP
   r/yLpHtIYuGtOxCfnXcKnXWuw8cAJTzmax/OvcWcM/l5cslo2+hXzWsr3
   g==;
X-CSE-ConnectionGUID: HyxGg9F6TBaN4jEDmRRe+Q==
X-CSE-MsgGUID: ijqWwnV1TVCtK3NnFBDPsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="49867994"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="49867994"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:24:27 -0800
X-CSE-ConnectionGUID: xfeSCHmOR3ikoIcfk1QtNA==
X-CSE-MsgGUID: cUEFhb4NSfy9sJcyZw1fMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112296017"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.111.68]) ([10.125.111.68])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 16:24:25 -0800
Message-ID: <1dbc68d4-355f-4baa-bbef-1e023959032d@intel.com>
Date: Fri, 7 Feb 2025 17:24:24 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] taint: Add TAINT_FWCTL
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, David Ahern <dsahern@kernel.org>,
 Andy Gospodarek <gospo@broadcom.com>, Christoph Hellwig <hch@infradead.org>,
 Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, "Nelson, Shannon"
 <shannon.nelson@amd.com>
References: <4-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <4-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/25 5:13 PM, Jason Gunthorpe wrote:
> Requesting a fwctl scope of access that includes mutating device debug
> data will cause the kernel to be tainted. Changing the device operation
> through things in the debug scope may cause the device to malfunction in
> undefined ways. This should be reflected in the TAINT flags to help any
> debuggers understand that something has been done.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  Documentation/admin-guide/tainted-kernels.rst | 5 +++++
>  include/linux/panic.h                         | 3 ++-
>  kernel/panic.c                                | 1 +
>  tools/debugging/kernel-chktaint               | 8 ++++++++
>  4 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index 700aa72eecb169..a0cc017e44246f 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -101,6 +101,7 @@ Bit  Log  Number  Reason that got the kernel tainted
>   16  _/X   65536  auxiliary taint, defined for and used by distros
>   17  _/T  131072  kernel was built with the struct randomization plugin
>   18  _/N  262144  an in-kernel test has been run
> + 19  _/J  524288  userspace used a mutating debug operation in fwctl
>  ===  ===  ======  ========================================================
>  
>  Note: The character ``_`` is representing a blank in this table to make reading
> @@ -184,3 +185,7 @@ More detailed explanation for tainting
>       build time.
>  
>   18) ``N`` if an in-kernel test, such as a KUnit test, has been run.
> +
> + 19) ``J`` if userpace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
> +     to use the devices debugging features. Device debugging features could
> +     cause the device to malfunction in undefined ways.
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index 54d90b6c5f47bd..2494d51707ef42 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -74,7 +74,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
>  #define TAINT_AUX			16
>  #define TAINT_RANDSTRUCT		17
>  #define TAINT_TEST			18
> -#define TAINT_FLAGS_COUNT		19
> +#define TAINT_FWCTL			19
> +#define TAINT_FLAGS_COUNT		20
>  #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
>  
>  struct taint_flag {
> diff --git a/kernel/panic.c b/kernel/panic.c
> index d8635d5cecb250..0c55eec9e8744a 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -511,6 +511,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
>  	TAINT_FLAG(AUX,				'X', ' ', true),
>  	TAINT_FLAG(RANDSTRUCT,			'T', ' ', true),
>  	TAINT_FLAG(TEST,			'N', ' ', true),
> +	TAINT_FLAG(FWCTL,			'J', ' ', true),
>  };
>  
>  #undef TAINT_FLAG
> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
> index 279be06332be99..e7da0909d09707 100755
> --- a/tools/debugging/kernel-chktaint
> +++ b/tools/debugging/kernel-chktaint
> @@ -204,6 +204,14 @@ else
>  	echo " * an in-kernel test (such as a KUnit test) has been run (#18)"
>  fi
>  
> +T=`expr $T / 2`
> +if [ `expr $T % 2` -eq 0 ]; then
> +	addout " "
> +else
> +	addout "J"
> +	echo " * fwctl's mutating debug interface was used (#19)"
> +fi
> +
>  echo "For a more detailed explanation of the various taint flags see"
>  echo " Documentation/admin-guide/tainted-kernels.rst in the Linux kernel sources"
>  echo " or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"


