Return-Path: <linux-rdma+bounces-16644-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACuCOdXHhWnAGAQAu9opvQ
	(envelope-from <linux-rdma+bounces-16644-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 11:52:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 913ECFCD5A
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 11:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F4C8308A036
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2661F38F249;
	Fri,  6 Feb 2026 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8y+V1Jr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622EE3793BB;
	Fri,  6 Feb 2026 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374945; cv=none; b=sPw+0XSOFO5DLD1RT4Dm/KvmxHDO31Le3O1Ri4piUKwg+orakc9NQT1oPZOwjhpqByZk8mER75caVtuLMmbxiIsAl4UFl9GE0KhRh4v7ydIvo3ZnSbx5KJYnYn9AVyBdP2rkPnqtJv+hEwI73B1OmoXe3S0GEsFTGiWDmicZ4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374945; c=relaxed/simple;
	bh=E3is48nCJBRGPdqXNixf1iJnUmoQc1bz645I0QrY9Jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C33xdFL+WAagGCL4T+D1ZbNK+jiFbP49kgTif11b2wYOLZvg3ZPR+5gHOYFFeGLLS/9ZCZLKvWUkoQkXiDuVdFryNwWmxGZU1FkqqqmPnfdg0hJY/pZgUoxFKyHVR16wH7JyrdRX2nBIw6v0+FFpphOgHkeYgmZqdHB3W95+r7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8y+V1Jr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770374945; x=1801910945;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E3is48nCJBRGPdqXNixf1iJnUmoQc1bz645I0QrY9Jw=;
  b=H8y+V1JrMXkv6aydoFR1gIzXWCbiUpOffXPtbOiR/aSgr5gx+ISoX7cM
   aklY65iXrITo/Nh7Rujsg9+1P2mFG59l2qxWBpzMcxIsgP9HiLaR0b23q
   9tOVtAnxAROQxY31PerlYq3Snbho90x8YPUswuWbhrtwyWpl9vJYxc3dv
   /HPc+eEqW6o/iZMt7k+urMC+Rz0pS/bjmKHrGuL4WSBHk8TawEPVpmefL
   r99VA5PDNijJWfpdcd0ysy/P1pwDgFj30d2c6XCTZMWSkVGN7T7PIk2Xv
   DjpQotaVVu26PqGOvy1L9af6E1ODoY9UuTldrAKs0N8RKgFq/RjVHbpau
   Q==;
X-CSE-ConnectionGUID: L1AY1Yn0T9KylNAcy0mmuw==
X-CSE-MsgGUID: KxPmgfSbQGu96NE7pQKsZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="75436132"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="75436132"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 02:49:04 -0800
X-CSE-ConnectionGUID: L5oLL47BRpaMkoIGzL+qow==
X-CSE-MsgGUID: 5jy0tHp3QDijN1tNuWmGcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="210663466"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.107]) ([172.28.180.107])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 02:49:01 -0800
Message-ID: <68fe9c87-c8e3-43eb-a40b-4b05267fa236@linux.intel.com>
Date: Fri, 6 Feb 2026 11:48:58 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Fix 1600G link mode enum naming
To: patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, leon@kernel.org, jgg@ziepe.ca, saeedm@nvidia.com,
 mbloch@nvidia.com, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, gal@nvidia.com, moshe@nvidia.com,
 ychemla@nvidia.com, shshitrit@nvidia.com, Tariq Toukan <tariqt@nvidia.com>
References: <20260204194324.1723534-1-tariqt@nvidia.com>
 <177034620683.657894.2565367947070195735.git-patchwork-notify@kernel.org>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <177034620683.657894.2565367947070195735.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16644-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawid.osuchowski@linux.intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdevbpf,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 913ECFCD5A
X-Rspamd-Action: no action

On 2026-02-06 3:50 AM, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Wed, 4 Feb 2026 21:43:24 +0200 you wrote:
>> From: Yael Chemla <ychemla@nvidia.com>
>>
>> Rename TAUI/TBASE to GAUI/GBASE in 1600G link mode identifier and its
>> usage in ethtool and link-info tables.
>>
>> Reported-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
>> Signed-off-by: Yael Chemla <ychemla@nvidia.com>
>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>
>> [...]
> 
> Here is the summary with links:
>    - [net-next] net/mlx5: Fix 1600G link mode enum naming
>      https://git.kernel.org/netdev/net-next/c/215b53099b60
> 
> You are awesome, thank you!

Hey Kuba,

I noticed that in the commit message on the net-next tree the following 
tags are duplicated:

Reported-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Signed-off-by: Yael Chemla <ychemla@nvidia.com>

Is that by design or did the bot break something? This is purely out of 
my curiosity.

Best regards,
Dawid

