Return-Path: <linux-rdma+bounces-8607-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D30A5DCB9
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 13:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A5D3A404A
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 12:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D5024291E;
	Wed, 12 Mar 2025 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRks0Wav"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C4B1E4A9;
	Wed, 12 Mar 2025 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782737; cv=none; b=UeX+c5AvhcEedYUO/9riwcb2d/F1kKjqw9MrybSbsutGq8yuT5j7GyEo0pNOFs8dR3d+R6Lw8DTryVlu9/Ew5eUoOq6kbllMnaPDyxRMkpobxJZiA/DgGC5XpdLRMYtLHWDeKTQ+i/KuHqrelUVAxhlLQjk1SJT5abbcpN2S9AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782737; c=relaxed/simple;
	bh=6PfBLti2GCLyhb5+n+egYTKW5V8tKOVfCwhp5cNmf/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMYiDB6FH1XDUr0ROJo63Ez8Z9Vb+aj85SseP46HK6Xu46viP9o/JyPocqy3F8nq+bHDvnMMi3p5NH9O3Wz22EJSG8hev9ijZGCeUbwxQEHifh4f29AnypXLAEHDL/L3oU0go+EF/9Vx9BjXWeSug/7jmIV4afwxQLIebV1V9ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRks0Wav; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741782736; x=1773318736;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6PfBLti2GCLyhb5+n+egYTKW5V8tKOVfCwhp5cNmf/8=;
  b=IRks0WavRT05K58iiqVo9bPcLoPNOv57Kqc7btp9miCtZhfvlO0CAN3N
   wbnm16FGmjTLwVuE52lH1adEgGkGk2bRj37ybTNSBJ33dYqKLg50te/OR
   355UPlTpoWJRhD4hna3ZQUYTEiAUbRFNER5rwquEOgQwAtG+oYU5O+vTI
   IDmwA+q2Da/XgNmFBQVP/34TUQnATRGX8D0ieUQrpwSslZgDwh1Yh5x0A
   84Yrd6uHIwszYWl674fyyYMQvGlhQpBgAlQOHXmpumLoFf0QCfmLTAWOH
   BIvO6lkZbp2Sb5RNRzRtR4sBzuA/ca01vKhwJjkVN1eHUjts+b4ihS41e
   g==;
X-CSE-ConnectionGUID: 49yItcRcRbOuAgIC2VTfjQ==
X-CSE-MsgGUID: Yf8kgAuPQsG7HBiW2ZHrAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="43038352"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="43038352"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 05:32:15 -0700
X-CSE-ConnectionGUID: wKwWVNBrTja/NwUNPTtyEg==
X-CSE-MsgGUID: Lv2rZVgETySZXTKDLNe8kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="120325899"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.56]) ([172.28.180.56])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 05:32:11 -0700
Message-ID: <7d4ee477-f7e9-41b3-ab22-3af71054c60a@linux.intel.com>
Date: Wed, 12 Mar 2025 13:32:07 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net/mlx5: HW Steering cleanups
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1741780194-137519-1-git-send-email-tariqt@nvidia.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <1741780194-137519-1-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-12 12:49 PM, Tariq Toukan wrote:
> This short series by Yevgeny contains several small HW Steering cleanups:
> 
> - Patch 1: removing unused FW commands
> - Patch 2: using list_move() instead of list_del/add
> - Patch 3: printing the unsupported combination of match fields
> 
> Regards,
> Tariq
> 
> Yevgeny Kliteynik (3):
>    net/mlx5: HWS, remove unused code for alias flow tables
>    net/mlx5: HWS, use list_move() instead of del/add
>    net/mlx5: HWS, log the unsupported mask in definer
> 
>   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c  | 6 ------
>   drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h  | 3 ---
>   .../net/ethernet/mellanox/mlx5/core/steering/hws/definer.c  | 6 +++---
>   .../net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c  | 3 +--
>   4 files changed, 4 insertions(+), 14 deletions(-)
> 
> 
> base-commit: 0ea09cbf8350b70ad44d67a1dcb379008a356034

Hi, thanks for the submission!

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
for the whole series


