Return-Path: <linux-rdma+bounces-2714-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3489F8D547D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 23:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BF21C24BDC
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 21:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314F9158871;
	Thu, 30 May 2024 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxZv4C0G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1EA47A5D;
	Thu, 30 May 2024 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103792; cv=fail; b=O6WapYgzq2mhti6EBkkBPfcON9rCRS+vpymPyyGYUTdHHy14kosHbsfTvzUFpZPptIHTn/vDj5QGSqVlUR5IVjDPWIDORSLPOKJ/dMqMuNrsSmgVnRjzpYBsbWfASPNj7w0iboYZOGHHCD9uQS9j5WMV2DwIVV1wWJyHVfU2rT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103792; c=relaxed/simple;
	bh=gx11NhYOtgJkxVIjs6g/64pBsuFexSAZwsmzKQztLvs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=edPOBFmBNtEntgAzrVa9SNqMff89mq05ljJMak87YcoYsAM1pDO6izMuqR5CWth/hVTTaED3+zaSsE02wzVY9CcWcR7kNY9GSsAWCIgoFDvHJdHsqYVteHV9LzQ11IRdAsAlSkhmuBsr7iZlnRsGOd3Wdmn/J5zu99OdO8ZrfQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WxZv4C0G; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717103790; x=1748639790;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gx11NhYOtgJkxVIjs6g/64pBsuFexSAZwsmzKQztLvs=;
  b=WxZv4C0Gab8Z9a+yI1JdCuo3ioLCWuW6sUe6vatCMEH1gKMWiBOBFSPm
   O5umDWMXlOcNATY2uJEZtFKgj9gXz7e4d9VZNoGs797tHXFoqY1ctUvPH
   OHjbS6Y0bBIIMDPIet+RFltzLBS9jWkqSCsAGOi9yIw+aJ6u2adC8Tuz8
   S2b+Bc0Qcu7Yh0gkG54NeUMq8hK3JB5ZR0RPPjH+hFOGjjbxwJDrEcAba
   szVR5zkE4ns/1Gwhv0px4oTQ3nyjcT1VzInZz/zVjQ1IzbOdeTeCq8qbo
   R7wdaC4BidSVNliKHcxazdjYbdryYdpIVdYnt/wOcdWCgFeBvdbo3iEPn
   g==;
X-CSE-ConnectionGUID: UYPTlpmTTMKYCtKhWhHGuQ==
X-CSE-MsgGUID: xEk9K6nkSECsh9gklTHGZg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31118321"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31118321"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 14:16:25 -0700
X-CSE-ConnectionGUID: C/84QOPKStWFSsNiNQkZsQ==
X-CSE-MsgGUID: hgBmdVzpSki6CgZxaB5o0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="35877588"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 14:16:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 14:16:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 14:16:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 14:16:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grksA/yB8f6NW1t+Osjv3hZE6eO2rX0gJEAp6ZlENRgUUXcIe42608P0R8QpjR8zhs931dCM8YtDZW9ErJw3gaG+UWofrG0oT/a0PWTQoYXT8xIDYBZLDedkkQ1O2ezg1/3tRgjhAU+rEljnfj6nzmCaiqIuIYgDJmr60pVUQ0wxM+XvCTSNnW4zYls5fXUmy3DgaLYNc0QUgvXdmvhdMz/Vq3KcF8/txODyYxqNjj/VtcPuw7Yl0KYeVNWx4ycScmfv150fNiBrOI7O5uTzJYa0Q4K7bMljJJWC9HYwnAaKYOeBsS31mzEJdGpfkzr3YIJZtbrsGgW2/yZIkaN00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdlHKtXi/c/NQtD/VehGtja98nt789JaSwqMsTIuS3A=;
 b=OQZGhycpWHHx1uWa75V4pzlvlLF1MJ7jm2rKnuy+B8JLauntRjdL2wP/l9SY4AFegjtYLs9AYy1V8Bs6RmnwUFkACRl7jMe2PAL/fXeuMEUFmwi+hj5fN4YWU9w/U9nJdWJnzJa7Ll3pDI/E7TZurgujzJ4jS+SLis7oN3pF0pjEGQHFr+BB7ZfkMjqX70lWuUMUDCqXTh9E2UPtje8yOvnquFRbw6J9LmvU0kPoRa5N5zUP1TZGID8S89rRGpaKN8CqKxguk31q3Ve1qqq0Tf1olQt9s3Vm+iQe79XIfaevVlfurt+Iv/0RYNSmvtXwfi2LoewKq+XO9OYxSsAh0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM3PR11MB8760.namprd11.prod.outlook.com (2603:10b6:0:4b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 21:16:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 21:16:19 +0000
Message-ID: <e1119c31-f249-4e0d-b965-59967f38711d@intel.com>
Date: Thu, 30 May 2024 14:16:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v3 2/2] net/mlx5e: Add per queue netdev-genl stats
To: Joe Damato <jdamato@fastly.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <nalramli@fastly.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, "open list:MELLANOX MLX5 core VPI driver"
	<linux-rdma@vger.kernel.org>
References: <20240529031628.324117-1-jdamato@fastly.com>
 <20240529031628.324117-3-jdamato@fastly.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240529031628.324117-3-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:303:86::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM3PR11MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c06106-1f51-4076-2a5c-08dc80edbfae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEh5dDVQUkJlSEZsQ0hIcldXVXBZMnJmVDRtSk9PMWpBS0dJTDFpM3YwQTVk?=
 =?utf-8?B?SURjbWZHMHNQTTVoTHpKMHFLYXMxcXNXQUhOSmdxLzN0RDNzREtaT2VQdUhY?=
 =?utf-8?B?WTJ6bDUzRlJqTzZnSXhmbXNPK2hTRnlWdWZSUUFTWDBqdy8rcXBzV2hReFNn?=
 =?utf-8?B?dDBSZFBMWmw3STBlMkFQKzRjK0pEaURmanJMMXNSZHhYMUJudEc4RzVuY1ZH?=
 =?utf-8?B?UWhTbVVJUER5dUZOdzY5QitXV0E3WVhOSHJFVHlsdkgrRVd1Z1dpK2VTSnFl?=
 =?utf-8?B?anl3OEUxY2NNN2VsVFJ1WW85ckk5MXNGNDlIMEErOElQSGdib0xCMlVxUTNE?=
 =?utf-8?B?YWtoS3NScGJjRllLNnlaWSs0aWlhTTA0VU96OUVZRFV3bys0ODYySXFEcE1w?=
 =?utf-8?B?V3hERWMvRDNlalZDZmNxU0Ixck1aR2dpcWNCT3lyVjlNT21CSFdkdERLWk5T?=
 =?utf-8?B?VWlNYXpqYUpGaThPT3gwSjVFdnpDQ2JnbTNrN2hoUUNaUTdVRW9vMEZGTnEw?=
 =?utf-8?B?SWQ5cGJGRWRQb1BCa2FZOUxUQkpJbndtQ3ZnZGpiK1V6R3NrRFA3TVg3NDVL?=
 =?utf-8?B?T1J0d1NQTzFKa2owL3JQTWJuckZ1eHVZMDlHbUE4OHJaM3pCb3ZJdDRNN1ZS?=
 =?utf-8?B?a3FvYVFEMmV1RXhpd3d4WVB3YlFjSUEyc2NleStLcFZPbXJDREVTb1RqKzRi?=
 =?utf-8?B?cXVobWN0Z0hOSkhPQXlGTHRnMWppQ1ZRS0tYRmVwUlJvVEhpaXZYNmlUUHVh?=
 =?utf-8?B?TmZodlE4MkZEbk1JMjNWNG55dFJzenpzTTJMTFNMblpGUUxnd29sZ0M1V1NS?=
 =?utf-8?B?OEx3Nnk2bkk1Q0tWUFBtQmk3RXZJcWVmNktFQ09JaFR6cmJ5ZVdPZDV2RUN2?=
 =?utf-8?B?MkhMQmlrRjAwdHlRMlpwdTFubUYwUDZERmhXWmlJdVM1Z1Z2VW16WTBpeUpH?=
 =?utf-8?B?M3plTWhLS1pHa2ljYk9nQVhTeWcxYU16MVRSK0p1UlQwaEFIdjFRcmpMblhN?=
 =?utf-8?B?K3AyS2xRR1VwTHdnT0VMaG9GQi9uWjRJNUo3Z0lidmhZUkJUeUZOSitZUHV2?=
 =?utf-8?B?TmJGeUdha2t2SE1WSHRNVnY1WVdhY05ZVEFhOER4ZHQ0aTk5RytCOWtOMnR2?=
 =?utf-8?B?a2pLeUNPLy82ZEZzdUtEM2RxVk9OeC9jQkNmMVBNdW1XWmZjNTBlOUxSUTVO?=
 =?utf-8?B?TzROVUJJeGtQc3NSenZoWC92OG5EMkF3K1RvQXdUU1J1K1Z5endkRVJhMyti?=
 =?utf-8?B?c3JqY1AvQUQ2LzF6MEJ3ZjJ6VlhUS0pNaWxacmNqOXQzWDR5UUh1OWZiUTVa?=
 =?utf-8?B?YzJIZEc5bGpQNEJReUNmeGRnTzJMWS9iQzUrclVxSEJmSWhDY3d2cFFLUE1Y?=
 =?utf-8?B?VHNjYmxSbG1DUExwMnlSc0hRT3Joc3RmYy9YMWxEekQ3Y3grbjg1Vk13L21x?=
 =?utf-8?B?M3N3ZDRHMU9uSVNKYmNjbyt2YmF0bXNnZlRyU2Z3VUpvY2ZpZW9sa015OFl4?=
 =?utf-8?B?amJGQ3lldnJUd0VSL01nY0V6MnZTZ3BMaXUvQmx4Sm0yQ29OcFZkcCtoUVY4?=
 =?utf-8?B?VU1SeGt5d1FPYi80NnFEK2VFekFSN0F6aW5WUGxNOUtDNFBMeGVBcmpZU0Na?=
 =?utf-8?B?alR0cWlyOHFPZWNKcUpHaXQ2R1kxYVlZcUVtYWVVczB1dkE1WHBSaGtQTkY1?=
 =?utf-8?B?N3FNN2pUYmlEREJZdjZ6U2xHdWhIRU5TbVlDaWJkQnNXTTJWai9Sb2RRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnhUR0RVd1lnbExxYnBqd2ZGUHBRM0xWZlBXN0pOWmRKV0hwcGptbi8rV1Zs?=
 =?utf-8?B?MHZXVEVHYk5SeEVhZlNIV0lZYWoxdlh2YlZ5eEdWOUFpSDU4enhnUGpKdG1T?=
 =?utf-8?B?NGpMa1FmbytsM1k3UVFNZEF1WXNqWHV6cXRldHdVZ1JGZHl0bHhpMjlnUG10?=
 =?utf-8?B?MzZMMXF5enFibmJmQ1U2UDFxODk1QmZlQ0YzS3RNT0lwMWo1TFdESXBWL2pQ?=
 =?utf-8?B?WnVRL3BhSkN3RTl4R1pVVnFvNXJ2Y0pjN0ZHdzhkTCsxRElnKy9DamltRHdk?=
 =?utf-8?B?b0ZPNW5nb1NUSDF6TE1JcVVnMkhWc29UNWpvNU9DRGhpOTBoeVE0ckIzK0hM?=
 =?utf-8?B?WHdnK2R2WDhRb3JBam4vQjc2N01BdEhXeXRrK2kyQTFPQzJjZVhodDJkb01z?=
 =?utf-8?B?azVxUTZnaG54WFloa0ZjRGZQNXB3aisrcTV2azYxQ2xpU3cxcWk3ZzlQS1d5?=
 =?utf-8?B?VUcyOHJrU21lR3hObmJWSXJMMGZiR1VURkQvSytMSERIdGh5M1ViMm81RUpq?=
 =?utf-8?B?QmZ5VWloODNFS3laUjZTMEhsei9xOWI0d1ErR21FN0NhVjZjdjFVZllBVjV6?=
 =?utf-8?B?aXFpd1FxZHQrWmV5SUhnRUtqdXBtSUdTVXI1dU1IaGRjWVJmOFNrU2JPblUx?=
 =?utf-8?B?Sm1LQTY0aUptRDM3Q3l3K2l1SFBZUjFYWkZNOGxJakoxVDlLRFkyTmtzOCtw?=
 =?utf-8?B?djRXYnZGRVB1cXlCa3R0TDdpY3QrMDFUR0h2Rk9hazJsZ0NXUjhUbUxvSzFu?=
 =?utf-8?B?SCtLVzlFVGlLRENidXJMVFFzU21HcnQ4amo4eHlBZUcvMERuUFpObytmbjFi?=
 =?utf-8?B?MVQyTURRZWVHK1ZDcURyODZIdlJnV1FqajdQRVJmVU8wQ215bVFnUVd3Lzl2?=
 =?utf-8?B?UzU1TEx5SHpsZnFDVHVXU3UwSXJDZW1TUkNSaW1CYjhUNUFTSnFUajYxTHJh?=
 =?utf-8?B?UWNpUG5tRTRCTDJwZC8yQTVPQVFWUGRmWUhtTnJ6cDI3OGRDQStqOGRRczFB?=
 =?utf-8?B?NWc0bnFIN3RuOERSVXJ5Wm1GQjJ1VUJ3OXI1Tjg5V2hEZkViYUhnTFdSM1pq?=
 =?utf-8?B?WCtuOGk1dDQzTE5uR005b0dlSm9QM20vLzlLcXg1MVNEMnFSeFY3d1UxU3c1?=
 =?utf-8?B?Sm5jNWQ0R1kyMkNWdk1JbThaNnk2VHEwWWpha1FqVmxtUjY3dXZVVEh2VlVq?=
 =?utf-8?B?K01hRmFsd0h3dU1BUDVWWnJ2azRzYXMwb2FodVhKNTUvOUlrMjJOMXpoMDdX?=
 =?utf-8?B?L2I3SUxVY3NNYTZuSUNrMWxzb0s2KzdDVlgvaFBIUkVVRnpKR2U2ZVpNMWtB?=
 =?utf-8?B?bmN2N0I3MkkxMGNFQWVUUmkwR0szRXZTaTl4UDVmQ25kNEU4M1R0YTZFTGhk?=
 =?utf-8?B?bDlHNDQvM1dKQ0FtK0lncG5JNk1HZDdGTkQ0ZFRzVTdPMUVTWmlXc2RVREVJ?=
 =?utf-8?B?WXhrQThDeitsTkJyTlkyaERlZmpTNk84QU9yazNnVm05aFVra0JVaHl3QzhR?=
 =?utf-8?B?UGN4bFU4ak9wOEZVVkJQOVhUeHlRSXYrRWU3NmdhY3dLWjVsT3pxd2crUVdE?=
 =?utf-8?B?YmRvMXNLRXBINU12dnNEaU43UEYyMTR2bFFtQXlMUUk3WXhHNFp0TmJacEpQ?=
 =?utf-8?B?SXNBSG5id3RoRDkwdXhKeW5oNVNDa1o1c1BSM2l6S0dYVE1KNGNHaFZ0UHVs?=
 =?utf-8?B?dm5wMGNGOElGbnZ3TXFrb1dLYmxxYWhINS83UFhYeC8ycTJUVmsvRXZMYjc5?=
 =?utf-8?B?c3c3dG4yY2tmNDh4WjRNR1BOOER3QnRJQ0VMT2RlTEN1UTVpSEtGNThTaXo5?=
 =?utf-8?B?R1cvaHFvZzhqQnk2OERXQ2tjTFRiRDhCa0FCenZXcUlVZzZycys3UEV3UUFq?=
 =?utf-8?B?YldqZDRoVzUzQ3lOVHhCUlNSSER5TCswOXlVNHQ1QUI5Y0VYaEJMNXRzdmpP?=
 =?utf-8?B?bG14Z21KcU1zZTVkZ2hEU2tXZXpXZDhRd1FtVGxmZFl0RVlaZ2hSVGE4K3hk?=
 =?utf-8?B?NEp5a0FIbTF1bGRXTWhHakE4V29uNVpsMVdmaGc0L0N6UzdNdkhiTzFQd2ho?=
 =?utf-8?B?K3hPR3Y2M2hGK0hMekZ6NVh2RDJEM1hGS1dxWlA5YTJoM05ubGVjeXRxclV1?=
 =?utf-8?B?dStRSDhQTnpkSTJXR3gzTVpjVG1ha1ZOTTYyTnRiTU1ZMjRMOER6RjFtYnJN?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c06106-1f51-4076-2a5c-08dc80edbfae
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:16:19.2089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FyDMQ6ASQAbHqOZ+Rd/xpBldAr82s1B0jPUZCBvge8gKldQ3N7sxrNAEU4TI2YdQ6v+pT4VKwS1+3mho33rZecT6/cMstl7BktZ3Ja8p1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8760
X-OriginatorOrg: intel.com



On 5/28/2024 8:16 PM, Joe Damato wrote:
> Add functions to support the netdev-genl per queue stats API.
> 
> ./cli.py --spec netlink/specs/netdev.yaml \
>          --dump qstats-get --json '{"scope": "queue"}'
> 
> ...snip
> 
>  {'ifindex': 7,
>   'queue-id': 62,
>   'queue-type': 'rx',
>   'rx-alloc-fail': 0,
>   'rx-bytes': 105965251,
>   'rx-packets': 179790},
>  {'ifindex': 7,
>   'queue-id': 0,
>   'queue-type': 'tx',
>   'tx-bytes': 9402665,
>   'tx-packets': 17551},
> 
> ...snip
> 
> Also tested with the script tools/testing/selftests/drivers/net/stats.py
> in several scenarios to ensure stats tallying was correct:
> 
> - on boot (default queue counts)
> - adjusting queue count up or down (ethtool -L eth0 combined ...)
> - adding mqprio TCs
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

