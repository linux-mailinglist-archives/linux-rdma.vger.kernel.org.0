Return-Path: <linux-rdma+bounces-3149-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0DA9090A8
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2024 18:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C93D2825B8
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2024 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412F118FC65;
	Fri, 14 Jun 2024 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="da2wXT2I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255449638;
	Fri, 14 Jun 2024 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383326; cv=none; b=cG5uWAEVCXDlla8pMFqgX7vplGUCzncMLK8N+N4Ptd0eXw1adt7Ir5dx3tcOxgOaVr4W0GqBHFYBSJZrDefnNjDXbRCt2GGyow+7/kS+0szpo4WTq5Sv0FekiunKClm7p0hDjMvFZvTcf3UylEK1Ad/5Iimsjz+ibP+v3kIQpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383326; c=relaxed/simple;
	bh=Tu5NT+/HC6v33/UcbBllxGhe377ayPb6xdMlPgPUz4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ed9I+dUdLGIICsWmyzB2whKsBJZnR9LsTyhgjcpGuxJylRBSUu7wdlxKjpGGecK6NDTa46eAn2nY9P+g2kgn2EGRDgXkAQrsUEUS2M/8kwPrfVEdA0SdhA2qoEhsxHbGL3t6zqBQ3oZQaoQBQ1+l+c7tn4zpRyIOv/1T80f1ks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=da2wXT2I; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718383324; x=1749919324;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tu5NT+/HC6v33/UcbBllxGhe377ayPb6xdMlPgPUz4Q=;
  b=da2wXT2I8MdrDCYJS4zeeHNOSEZcIvYFOhgLWQJcjg/Wcm7QPG2vRz2T
   ff+R48K2QZEjNztk/nnXQJR86CMFqweFVzlybziNFWtxjPfgVKAbeR0H1
   Z1Ko+Kh1eDFLpAx8NJQlBtiL9aI7IU1COWCODrha4bQpif2q1aX1A1R/K
   JoFVFHADXPik/2zG5b4mtUNZPAPLLl3pMIYq03fXxBb5MNTPPtfPT7CWI
   HiTkmXTSEVms658Lhz18hfcdWVONwFBjgxf+KbQGfRD2sAbBPH1qSGKw7
   ZXf2teVb1wbYhnn3tS1/L9CVMvsdtzCuXbFaOcFktVAj8rdsFsG7I60jO
   g==;
X-CSE-ConnectionGUID: LX1TCqNpTfOjjRl/Q9DCBw==
X-CSE-MsgGUID: pEvqF8N/QoKPZiRtmZZJrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15114716"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="15114716"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 09:37:53 -0700
X-CSE-ConnectionGUID: xAAM0oc6R0qoOzVa51X18A==
X-CSE-MsgGUID: MWl63vUuR+mg54xeFXB5wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="44921621"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.95]) ([10.125.111.95])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 09:37:51 -0700
Message-ID: <8078be0c-58cb-4288-bbee-639483675501@intel.com>
Date: Fri, 14 Jun 2024 09:37:50 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] fwctl: FWCTL_INFO to return basic information about
 the device
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>, David Ahern <dsahern@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
References: <3-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <358d2e11-59e2-46eb-a7f4-3c69e6befe02@intel.com>
 <20240613234002.GH19897@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240613234002.GH19897@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/13/24 4:40 PM, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2024 at 04:32:44PM -0700, Dave Jiang wrote:
> 
>> Are you open to pass in potential user input for the info query? I'm
>> working on plumbing fwctl for CXL. 
> 
> Neat!
> 
>> The current CXL query command [1] takes a number of commands as
>> input for its ioctl. For fwctl_cmd_info(), the current
>> implementation is when ->info() is called no information about the
>> user buffer length or an input buffer is provided. 
> 
> Right, the purpose of info is to report information about the fwctl
> driver. It is to allow the userspace to connect to the correct
> userspace driver. It shouldn't be doing much with the device.
> 
> If you want to execute a info command *to the fw* then I'd expect
> you'd execute the command through the normal RPC channel? Does
> something prevent this?

Ok that makes sense. I should be able to do it through RPC with some tweaks. 

> 
> This is how the mlx5 driver is working where there are many info
> (called CAP) commands that return data, and they all run over the rpc
> channel.
> 
> Thanks,
> Jason

