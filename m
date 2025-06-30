Return-Path: <linux-rdma+bounces-11763-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE35AEDA9F
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 13:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0CF3A65CC
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23C0235046;
	Mon, 30 Jun 2025 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcMD0xQf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B321DC988;
	Mon, 30 Jun 2025 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751282311; cv=none; b=uUOpI3tXP5IFKLBus/A9a2UD3ZICQpfA0ngn4vqq1CXW2mzs/jP5CbGpViy8RAhqYq0+bmJfmErFARdjwOwwnEvp1QA5UKz6YwcfXf1X+ES5qgLP9E+txKwbQyax2qqa/6dxNwhsp1BQzsREvGGf+HiVG8QtV4enKoZUk+fSAww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751282311; c=relaxed/simple;
	bh=9gThfWOSowAx4Kc3l4vZYGdweF31noC/qdGXalTIOPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDSnALMlgXAMuUsYTtowgC644jxjY8lWBU75VXmVZdvx9v7l7pmpa2KbL+Y1lXbrbthXyXSH+SIRVayS4ZKjFPOMMSRBjXLfLn9OLEMvP1L76+0YnqUj8DEU3jfkCkfhpGbOttzZE+KcXXl5fUxF6CPNrnaMh09izl0lnqRaHjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcMD0xQf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751282310; x=1782818310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9gThfWOSowAx4Kc3l4vZYGdweF31noC/qdGXalTIOPw=;
  b=ZcMD0xQfT7hcnZsmF2N2rNtkSw1RLQrtLZs5LIdsShpGg5WfTn/FKcuG
   e7ExDAg2A/CkhBY1EU7o2g436dGtiw+eYuHsNiKuJmPQ5Pa/VM7hib+ix
   IepY9yj1g68muFSoaUrJ3j7pEqAY24Od8xYGW5J0pOwpvZOPu2uLSLjbU
   6wx0FRqNq9vA1owfTTKAEq3MtjmDkuIirtvRxpEgfdOCORI5K1dvmHY5K
   a8pyDZ+TyzuvqWAFeSpwEWRhtXnq+13WygZToCxdbguTXZoYbpIrS1co4
   PhasiP8U9QGyZ/Uwawj7/Dleq5+a94OED4ibuu18dsD0UPUmPTki4bus8
   Q==;
X-CSE-ConnectionGUID: oYZaErT9TSmBjdM6C8hjhg==
X-CSE-MsgGUID: hJjjoEqwQYCYeU3fDfA2ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53227976"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="53227976"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:18:30 -0700
X-CSE-ConnectionGUID: 3hy1gCpjRsmQrnY/oWw3CQ==
X-CSE-MsgGUID: Nj6v/XxrTP+AYrscaB7dTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="153736522"
Received: from mdsouz-mobl2.amr.corp.intel.com (HELO [10.246.2.119]) ([10.246.2.119])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:18:26 -0700
Message-ID: <ecd14fd4-91b2-4bdf-af9c-cc6f555f989b@linux.intel.com>
Date: Mon, 30 Jun 2025 13:18:22 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mlx5-next] net/mlx5: Check device memory pointer before
 usage
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Stav Aviram <saviram@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-rdma@vger.kernel.org, Mark Bloch <markb@mellanox.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <e389fa6ef075af1049cd7026b912d736ebe3ad23.1751279408.git.leonro@nvidia.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <e389fa6ef075af1049cd7026b912d736ebe3ad23.1751279408.git.leonro@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-30 12:35 PM, Leon Romanovsky wrote:
> From: Stav Aviram <saviram@nvidia.com>
> 
> Add a NULL check before accessing device memory to prevent a crash if
> dev->dm allocation in mlx5_init_once() fails.
> 
> Fixes: c9b9dcb430b3 ("net/mlx5: Move device memory management to mlx5_core")
> Signed-off-by: Stav Aviram <saviram@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Given this is a fix, the net tree should be targeted instead of next.

Best regards,
Dawid

