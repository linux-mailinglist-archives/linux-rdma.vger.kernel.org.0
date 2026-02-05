Return-Path: <linux-rdma+bounces-16576-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DQQEjOQhGkh3gMAu9opvQ
	(envelope-from <linux-rdma+bounces-16576-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 13:42:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A07F2B8F
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 13:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C7A930066A6
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 12:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D053D3D0F;
	Thu,  5 Feb 2026 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agdjkHHE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B53B8D5C;
	Thu,  5 Feb 2026 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770295342; cv=none; b=JNN3uFiiRERYoZ67xTVOY/Wk7sj7KKutq1lnfmDNbKVtGLx7hHNbipmUN6W3zvlFfJf4tIlarZDU7yJ/1vBNvRzVv0nB0ErV25EnOmlpqEfit3XIVFT9/dDvTTDMLO+O0oq9cKDr3UAaSTh9H1aa9SM3Gjma2Dt3VuyLm0QIcbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770295342; c=relaxed/simple;
	bh=0uzoJci9LsR/6L9PBaljPmEo2tqKa2wS4nOz/2OSA/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0kh0hJPdPjJK1rEr7lOe9JFETpruJuOcroNnTdKAp5NtbHHozKXKjNzzHrAhM5kUA2a477EACsgSfukU2wn3bADvxK73q4uifaT2B4kVm64LKPHt8cTPT9IfiQAhzX20j0F1L7CNtFxxBC/Qd4PDjT+l1S8mF9ohHFTsX5vSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agdjkHHE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770295342; x=1801831342;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0uzoJci9LsR/6L9PBaljPmEo2tqKa2wS4nOz/2OSA/0=;
  b=agdjkHHEd44MYDJLcvwzV77VyogMWMQI49Sze5vXlRrW2w0Z1vPq0YrR
   Go71lM7NItfWnKts9j0AlkG569oZ7Omym7e7rinxgqskDDvw3EKtRezyu
   ZMYVCu5jHTHQxh3gMxQtfSUVS0/2Y1YAkRc7JjugktLxmD7L+h9sNYDyN
   bNCD66wexvVPFdjiQqoeC6NQR8w0qQnpiTM0MiiUdmaJ+XZr9A/7Msw7w
   PhgNOTXA1IGHomqf41RDlxFS44wLeD0WBSmBhm0amIIfkCPtABU+KozIg
   0A5BW087/AmYGEymoqhQfwh+zkOQ3UgGb7SSIhHVWeEPve+I8QA8kaOch
   w==;
X-CSE-ConnectionGUID: pF9Tg49IRAWrSEDfGXxSAg==
X-CSE-MsgGUID: 4cRcLwzYSuyI74FB2popCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71393614"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71393614"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 04:42:22 -0800
X-CSE-ConnectionGUID: NwUJ1b2dR7yCCl/XoI1WeQ==
X-CSE-MsgGUID: q1SPpRGsR+aeS14HWfhlog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="209600216"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.200]) ([172.28.180.200])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 04:42:18 -0800
Message-ID: <99b57ed5-f0bd-4ce9-a665-b949df755b39@linux.intel.com>
Date: Thu, 5 Feb 2026 13:42:16 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Fix 1600G link mode enum naming
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Yael Chemla <ychemla@nvidia.com>,
 Shahar Shitrit <shshitrit@nvidia.com>
References: <20260204194324.1723534-1-tariqt@nvidia.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260204194324.1723534-1-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16576-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawid.osuchowski@linux.intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.intel.com:mid,nvidia.com:email,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 32A07F2B8F
X-Rspamd-Action: no action

On 2026-02-04 8:43 PM, Tariq Toukan wrote:
> From: Yael Chemla <ychemla@nvidia.com>
> 
> Rename TAUI/TBASE to GAUI/GBASE in 1600G link mode identifier and its
> usage in ethtool and link-info tables.
> 
> Reported-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Yael Chemla <ychemla@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Checkpatch is complaining:

------

scripts/checkpatch.pl --strict 
20260204_tariqt_net_mlx5_fix_1600g_link_mode_enum_naming.mbx
WARNING: Reported-by: should be immediately followed by Closes: with a 
URL to the report
#13:
Reported-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Signed-off-by: Yael Chemla <ychemla@nvidia.com>

total: 0 errors, 1 warnings, 0 checks, 32 lines checked

------

But I raised this off-list, so that's fine :)

Thanks,
Dawid

