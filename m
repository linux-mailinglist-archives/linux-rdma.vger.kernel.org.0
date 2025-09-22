Return-Path: <linux-rdma+bounces-13565-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3241B8FE64
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 12:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DE3188CD7F
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 10:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5DF2D97A9;
	Mon, 22 Sep 2025 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKdxg8o0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346ED24167A;
	Mon, 22 Sep 2025 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535504; cv=none; b=CRfdn063Ysl1sY0hysfuvAE9OVyvRoCu9B5YklIRhA4kCkChWjqUV9zIXHpwsaIspL++IILHA7dv6i2JXwUppAtn4+ww7+InFj7LeRKanI4ycCEP6heiuOfls0GNI7u4BK+6K5m3k0qUTTGhrk2wkaga7r/JK9sMg22RIzr9vaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535504; c=relaxed/simple;
	bh=WB8GQ5RsepoYi2eFGEtfbChCX1TN6uBkef1VC/5PxZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQY0scQZxIqB2bjmakSrpw0SDZZIp7KkyhVY/XDPLUmymiUHRE9Pxj+D9HnxiHR8CdNPWHurNlOuucNSa1f48esfVOw2Q/pGNZe6hdunLJ/1MQ4RtsYKYbiQ9p1ZUJD+i39jcbuTEDAMQsRR0LCYGdaMmADLPWxjuKCIvte+OVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKdxg8o0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758535502; x=1790071502;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WB8GQ5RsepoYi2eFGEtfbChCX1TN6uBkef1VC/5PxZ8=;
  b=ZKdxg8o08fJWoD1uy5ByViiSqsbiP3qkzAYKXj8xTnC1vPcRghczW3Xf
   cP95VDcep8FeCOhJdro3zSsElf8IsyllgSIy040q38wEswu83AxuW7ODq
   Wc3yiqdVOi26UmduoEvSSGkbJs9YtSKL0Wqdndx2Lfv8+GJJAotx3NHxP
   Un6Cmhg3vYR3r4VVuPeF3Y4hMyGYqYC+nUZH7KR+p8SgKJWyMDM4xZf78
   mnb5ADBlm+6Mcz/6mn8Elww+v4E8//bZsgL9Loftaw0izyZQKVj0YP6vn
   FIMRQ6bkNX480gurq5IegbiCVD9djVEFNJLi95u6wTlUGx3uuWv1+m/gK
   g==;
X-CSE-ConnectionGUID: tOhN9DbPRa2nw0NwlGI+Jg==
X-CSE-MsgGUID: /tAajN2JRbuCRLMMmhOzKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="72218546"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="72218546"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 03:05:01 -0700
X-CSE-ConnectionGUID: Ai8W4B+aTiKldxgsb2qz1A==
X-CSE-MsgGUID: G6NnfLnPQDaymjrIefS/zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="207180385"
Received: from uniemimu-mobl1.ger.corp.intel.com (HELO [10.245.80.13]) ([10.245.80.13])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 03:04:57 -0700
Message-ID: <2a927881-e0c7-47c8-a455-7ba3b1413648@linux.intel.com>
Date: Mon, 22 Sep 2025 12:04:54 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net: page_pool: Expose size limit
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <1758532715-820422-1-git-send-email-tariqt@nvidia.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <1758532715-820422-1-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-22 11:18 AM, Tariq Toukan wrote:
> Hi,
> 
> This small series by Dragos has two patches.
> 
> Patch #1 exposes the page_pool internal size limit so that drivers can
> check against it before creating a page_pool.
> 
> Patch #2 adds usage of the exposed limit in mlx5e driver.
> 
> Regards,
> Tariq
> 
> Dragos Tatulea (2):
>    net: page_pool: Expose internal limit
>    net/mlx5e: Clamp page_pool size to max
> 
>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
>   include/net/page_pool/types.h                     | 2 ++
>   net/core/page_pool.c                              | 2 +-
>   3 files changed, 5 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 312e6f7676e63bbb9b81e5c68e580a9f776cc6f0

For the series:
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks,
Dawid

