Return-Path: <linux-rdma+bounces-3484-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A109170D3
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 21:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE521F23095
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 19:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3613A17C7A3;
	Tue, 25 Jun 2024 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ITKHN6zT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C071DDF8;
	Tue, 25 Jun 2024 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342225; cv=none; b=kdI+xmzv/7YTah28rSH5h752UvSzpVh6R2MgYtrHlwpRJuCPjkEqj2LCWg4Ih1bBHw5k4JEIxEopA/Q8IGONOO9FRa5CkUhy8Aid4qGWHQ3H/pI1lAN6ofAKNwO/Qmt1r0Tq0nRsbCzPR+3HmrTj5qHZdYMmPngG9pGE1qKac4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342225; c=relaxed/simple;
	bh=JI9GDj3ulVpvf2zTRea2Df/zqs1xKQepL3nAf2RdH9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kT6dr4WwFghh8DOwxLuebCGs7l3TL+UWtsTVNlPdSMG/XUET/3kaVep1Bmvv634A2YlTFWtus2ccBJJzLFVXx/aZXUjXM4i4woREFJGtebnsZxD8mlgLDKXcnG8ml0KU70tBxS3gPtGqVGDPyK9OnrT7IyO8dnkiCvYqdqn5wQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ITKHN6zT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=del2IawhL2LDxT1v3/P46ZsGeJnPo7oM5A0i38LokGg=; b=ITKHN6zT66z8ErRMCTqE+jVNdm
	aifAPFQ/TeaYHXcVhjDil4jV+s0oZ5UpLaOxBpRNT+cYkoXOIsy3jd61cwgPeY0VYGgt3NSd72fxm
	c/rYxKsxctjYar4GbZzJWayRJkBHDb7+RQCAyPEclG9lr3QQ9/HiDETaBa6H7M3Ddspedc5EIPWDz
	EgqGueUTMLj4QKShGJTfXUl/00UozYDKiBmIyiTe/pI+YlD24pDkJvl20cEDAyNTVSi/CYxnKo60h
	t6sg2Epolbj3KXWz1SRq47WcLM2EAiH3h2TtjlTG/xRl08xv258cjuNwITZ8rX6NDmlEix0Gs11c+
	I17vseCg==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMBS7-00000004CWp-0nMl;
	Tue, 25 Jun 2024 19:03:39 +0000
Message-ID: <0120d73a-0d15-440f-99bd-4c3e0a925183@infradead.org>
Date: Tue, 25 Jun 2024 12:03:35 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] taint: Add TAINT_FWCTL
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Itay Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
References: <4-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/24 3:47 PM, Jason Gunthorpe wrote:
> Requesting a fwctl scope of access that includes mutating device debug
> data will cause the kernel to be tainted. Changing the device operation
> through things in the debug scope may cause the device to malfunction in
> undefined ways. This should be reflected in the TAINT flags to help any
> debuggers understand that something has been done.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Please also update tools/debugging/kernel-chktaint.

> ---
>  Documentation/admin-guide/tainted-kernels.rst | 5 +++++
>  include/linux/panic.h                         | 3 ++-
>  kernel/panic.c                                | 1 +
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index f92551539e8a66..f91a54966a9719 100644
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
> @@ -182,3 +183,7 @@ More detailed explanation for tainting
>       produce extremely unusual kernel structure layouts (even performance
>       pathological ones), which is important to know when debugging. Set at
>       build time.
> +
> + 18) ``J`` if userpace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
> +     to use the devices debugging features. Device debugging features could
> +     cause the device to malfunction in undefined ways.
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index 6717b15e798c38..5dfd5295effd40 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -73,7 +73,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
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
> index 8bff183d6180e7..b71f573ec7c5fc 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -494,6 +494,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
>  	[ TAINT_AUX ]			= { 'X', ' ', true },
>  	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
>  	[ TAINT_TEST ]			= { 'N', ' ', true },
> +	[ TAINT_FWCTL ]			= { 'J', ' ', true },
>  };
>  
>  /**

-- 
~Randy

