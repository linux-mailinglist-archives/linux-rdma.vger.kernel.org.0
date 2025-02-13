Return-Path: <linux-rdma+bounces-7714-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE93A33C4C
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 11:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180901883E61
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 10:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE567212D95;
	Thu, 13 Feb 2025 10:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oyd6OyXe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F85212B3B;
	Thu, 13 Feb 2025 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441769; cv=fail; b=sZdQFopd/i6uHmWL/Ql3c6LPUTs/Z/hYWfYBS89PLx9ff+rZAPoP9E+334girVHsMsbZ8rs8v5weiR3YrXymj2mXMCM+zTHDKyTskoWG+hRXaZPece0iJ4RXKVFYNysdaeqpBoM+vFhQofjOyAdCJaVcuunpFcfOpn1Fn8LG4lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441769; c=relaxed/simple;
	bh=/7vNFiAsyQrer6++ddeOGcpCXsqJY/Gv1UcQUcdWqlc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b5d74o1F2MaudrZ9c4aR0WFMsKd+Uw6Ap6hcbIapgjq9tb98g/JzV3UVMS8Pk/C/jNOzoTVCdUt3R8hwTB0ol2HXJUequd/vduzX6kLGnSdZZKKDpkd/AP71JKowhhoBWZS1NeM0Rj0QGZFHe0QiEXUzVHDN7nG9jim2wiGSiRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oyd6OyXe; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739441768; x=1770977768;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/7vNFiAsyQrer6++ddeOGcpCXsqJY/Gv1UcQUcdWqlc=;
  b=Oyd6OyXe0MahgIt3Hj4c8xHQr2+I5yvuqb1a1jr+DB0gDvb7YNeBGVr1
   8f5v317geMDJU14J897s1NfX6VVC6+15y0PsRN0kv0nFrc9G4SJy6p4qf
   XJ10Tf8WvbcmGhJz4NfC5vHXqXt/DBSuJgNnVHQPDqZk0S8YGMh93JbwO
   fCRPDRsKiKOHgEbJn9sVYPEwmBACl0wturCusDtf1vpkfU4NFsUuIfO/5
   aorn6W1LbEPWubhcI/Q8G9+gKpBiB7carKsc6vKMcJsQahuPlK3FddKdH
   U630eZ5hibtwzirq/b50o/Sxns6p0rgd3ajmfsiKzCUJDT8M8GiusxUf/
   A==;
X-CSE-ConnectionGUID: ZZFAaa9jRBO3fxeFdiKxSA==
X-CSE-MsgGUID: 5HsybnKsQRWPjcPLmgjJ4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="50350038"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="50350038"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 02:15:55 -0800
X-CSE-ConnectionGUID: JFLOgTuPRg6CLyHpaS+QBQ==
X-CSE-MsgGUID: Tg9sd/lhQz+XT5tSySuCvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112934688"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 02:15:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 02:15:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 02:15:54 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 02:15:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1sR6gJTi8E7Bc6qdANbt/emvGpuuO1/15NHG21bVzy8OtpszQGRMIcJWwAJXd3LjVxH7lyXfWYwt2fOlB0URWQ0DSapNWZZDmgkbIEeZx3AEyePf8Vjs2FAcTuSs0oIy0EwnMICGuH4Wpr/1yBdV881O6ZF5C65v964tDipTVmC1uPL/guo+0ygri0C/WKWdQL2AnMuRxERaXBAbO+Qj4DKPx65yYGcDF8T4Ud0HWTQlpimKv/Usj1BvYrj7j2SNylLlD8iBWwkp/jJgKPpeUcP4/XflCB0pyrk6tJL9mo0JIRJqy/MPFTEoJcB3TYtFanxbbkytmkkGDtA9AJ6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK65QxmLsa7ZwY4JowKF6sRxiSvqWAWIJmMpnZiTolk=;
 b=HM0Z6vHx0QFwEDSK54+G5itNJdVEyf9qKsArMHqvWqkephdoVnsKL3y7GX8/X16UtQBkzpEgK0Ytl1NsTflmGrUF7X00nOA/I01gs2Xw9KpADSnlUcnjtWUBo0onBxqorabXt5cZ0elLQQpGTAzqWYhzkxgpLCPudJmOtzK2T6ujbRQGD78/EkdPyav3sLOECJGFGSuxxfAXg2/wGSzzf2u+kAgToi/gUIF7G3SQIn6ORrcebqDsohSJ91v6rMPRJnHEkuOotdRsriiE2IXQY46+dKZxbB2vQNk/r1arDjE9v3bNgRYNt1k5pTEqQi0XZXMfF2fisx1hilx9XpK7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by CH3PR11MB7769.namprd11.prod.outlook.com (2603:10b6:610:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 10:15:50 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 10:15:50 +0000
Message-ID: <f1fe6175-c00b-4ba4-9091-84b09a0acdde@intel.com>
Date: Thu, 13 Feb 2025 11:15:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net/mlx5: Apply rate-limiting to high
 temperature warning
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Shahar Shitrit <shshitrit@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250213094641.226501-1-tariqt@nvidia.com>
 <20250213094641.226501-2-tariqt@nvidia.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250213094641.226501-2-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0031.eurprd09.prod.outlook.com
 (2603:10a6:802:1::20) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|CH3PR11MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0f6272-ea8b-469d-8e0c-08dd4c1763f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c21vNDNVY0ROMDlsdlFBWHNnNWttN1F3ZlZpYWpqeitMSWpQazBnejBFQnBO?=
 =?utf-8?B?RzlqVW5QcnJmRVBkUWk4K0s2dlI3Ukx4WjJoSWpkdzJzRUlJMXBsWFdnU0ZI?=
 =?utf-8?B?VlF5Vng2bE9pMFhFekdJeHNNTFZLL2lKV3FjNklpL1AxdkxlRDVPRlRYdjFi?=
 =?utf-8?B?WXc3bEFqMW4ySlVmWGxUQlZhZjZoSW44YWlpOFRRTHFxcGNkZENXMXZvOU5J?=
 =?utf-8?B?NmljWGgvNzljQkROYUp0R3hLL3c2TlBPaHRSYllsdGlyVmt0TWJ3Y1lLMnpC?=
 =?utf-8?B?ajIxQnRmaEhGanp4Z3k4N2VLTE9kL2hldVhBSFp1T3FxUlV6dERRYm9QajFm?=
 =?utf-8?B?UDRrTjZQNFd2STJVMHcxZ21jSWlsclU4UXNIbFgxSTcraWVCcklZWW9LakNC?=
 =?utf-8?B?eHVZYlA0aEZDS3A3ZDllRnBJYVpMOE8yaFc2ME9FVEZKdUpxd0VVYTdtNTFp?=
 =?utf-8?B?UmtEU1VWbTdpRGhHTjBIays0RVBoTjQ3bm4zYnFMLzI5WE9WUWNzTml0UW83?=
 =?utf-8?B?U3FzOUhhNnRReGU5ZlRrcHhaNzZaWXdvek51eVAxVTJtd0JHTzlFU0hMcjJD?=
 =?utf-8?B?M3owbUV0T3prOE8wMkhoV29hNHdlZlJ0NGNvZEhGZDgvT0dqK0JwdlljcHJz?=
 =?utf-8?B?anVDYnpzVGpSbGdzc3JaQmYwMDI2QnN1ZXNmM1J0eG5mbmYvV3JpQkVoR0x2?=
 =?utf-8?B?SWdzYmlkanZndFRCdDRyYWtMUmwzNW1IYytsYTU0TGRwNVdUbHQrRGRyYjlp?=
 =?utf-8?B?eUVZMUJRVDk1MFFqdXhKZVJFYlZBTnBWMEVnRlk5Rmo3c085ZmZGQWNFSTMv?=
 =?utf-8?B?cnlMbDZFUk14M0svZlU4YkJtSzdSaDBXSmhMNFFGUUdFenNDMjM1aFJKY3Zt?=
 =?utf-8?B?RUxEbjlZbkRxZjg0bWtyc0laWHFuZS8xOE45cTJIRUw2Nyt6M2htS2VKTEYw?=
 =?utf-8?B?TjlTYmFWRnlVRk9nclpNSXdiT2YwZndqQ2kwRkdSeGIxRGo5cVVqZjg4Nnpq?=
 =?utf-8?B?QzZlNmJRRCtPdWdsaVJXKzBXYzBrd3lJVk1LNTNTVHZJL1l1bnZBZ0g3NzA2?=
 =?utf-8?B?QytYTUYvR0tqQUUrK21mWlR0L1hFNXd1VysrMmp3KzVLVmxMc2htd2N2emV3?=
 =?utf-8?B?ZVhPOCszeTRwOWlSa2hpTDVRZXNRY2xnbnRiN3NPZitVT0FoMnJSOGtiSTRk?=
 =?utf-8?B?amdSZXFJYkJBdVlWV2tYdUxvY2NRVTArK0dqRUlrdmZtaG8vYzloVGxwZXN5?=
 =?utf-8?B?ZGlTUGhlbE9nNUdJNDBPSm9FcGxtWjFRRWRYdlZQT1c5RFFqK2RLdmlDamFo?=
 =?utf-8?B?NzUxaVluWHlQMWFjdXNMbnFSNnp6alBXVVlrcEpVb0Y4dzM2b2JJU3VoTU8r?=
 =?utf-8?B?UTZKMnllYm9QSG0vNE9oeWsvcnREdEtmMjBIMVlNdDYvNmpIdnRmMGk3a2Ez?=
 =?utf-8?B?SU9uMVJ1OEx4L3Z0ZzdRcG9OQWtyZ1YvaXh4VXdCRzFXUWFFQ0U5YTVHekRs?=
 =?utf-8?B?NTVjUHlNaDQrMS84TmczQmxseHFjNU43a1dld0ZPTktJSlY5cExkOXdUUmM4?=
 =?utf-8?B?R1NETW9iazgyandJaXZ1WlpYdC9SMjVvS3hwQTloMFRMbGJwR2FpRVhGZDJ3?=
 =?utf-8?B?VFRJajRHQmMyVFNuL1QwK2ZJbXBzc3NHRWxURTFVWkRONmFYblZSQnF0NFFR?=
 =?utf-8?B?Q2JjZWJTejdiWTA0Sm14NjExUnRmSlM0VlIzRTgrMnVCVmZHdEYzWXF2bnVx?=
 =?utf-8?B?bWNKYVBZOFJ3U2RRakJUOWx4R1NrMTBjMFFzZlZuaHdNVFBYMVkvb0ZqS3k3?=
 =?utf-8?B?eEJ5MkNiM2xEYllaWUQ5d0ZsVFJzcVMwWU0xeXhQaVFBa1A0QjBBZFlEZXJo?=
 =?utf-8?Q?RpIgQV6ccwWML?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejREa0VUUE1Ia3RadEs2OWZZZVJjeTJTd2lxVm1JSVpQWFBQdEs3bUJVMGh3?=
 =?utf-8?B?WWxrRG5sVlpZcythazJ1YjlUeTVhMFE4Wi92TUIxMnU1a2hQNGJHbnhxM0hU?=
 =?utf-8?B?bGhGSmJZRkFOWXVxTjE4cVpIVnNRSE9rZWszbFFKd1JiMndiTWVBVXZpTUxi?=
 =?utf-8?B?aElIUlVoQmpRU0s4Z1VTOWU2MEdPZUZYY3IyZXRXZzFpdFZwNEJ5dmUzK0pr?=
 =?utf-8?B?M2dQUTExcXBmZVhlKzRWRUJOT3p4WTBzVlpsVEwraWNJUWU2M2ZvZTY2MllT?=
 =?utf-8?B?K0pobEowZkhtV09OaXRkdXFrVzZHTTFxVjEyaEdsNFhkMmdtNW9xb0lyRDFB?=
 =?utf-8?B?Q2Z0UUhncU5aZ0dkanNsSWgrTmdROEZiNGViMWRnQlJBVVF2blNndnl2UGJz?=
 =?utf-8?B?R01JcG9PVVpCSVE4MVUvVzJSZ0JjbkJYOVI4cFd5bSs3RDVxNk9hMkFXT0Ur?=
 =?utf-8?B?S2EzVVJOTzFXdjVLZU8yZWtyTDgxTE8rL1poSmRnSjZJaGlPUGJieHlrZTlC?=
 =?utf-8?B?ZTl2cmIvS0pXTlM2Vzc3YmNaNHRTdjRhSytOQW55Z1I2Z3JCcmFROGNpcktt?=
 =?utf-8?B?akRrTzZhclhzOFlBSGxlb0hYSGhQZjM4c2NYL1UrSjZudFh6UHJCVFc3TlBE?=
 =?utf-8?B?dnBEVWNKVDhBVnAyOGt5UE5kSy9rdEVvai9KOU5WdEZWU2ZiZ082Y2RwUi9Q?=
 =?utf-8?B?aE8xNHdRZURPS3hLajN1dVJCUEZnejBJTG5JN2sydjNFZGhhUGZBQUhTK2xh?=
 =?utf-8?B?Sk1ZN1p1SlVYWjFYVm9Jci90bDBubTNjSzNCQlloMzdWUWNra2JrbHRGeEhH?=
 =?utf-8?B?SDIvWVRqNGtVcno4c2xtNkJWSndnOTdtb05jR1YxS0xrekpJcElLNHRibHc4?=
 =?utf-8?B?bGpON2lwNGM4L0w1QTFCNVhYdDZ3aEp4eEVpWUlPN01CTDJNRTRybldCUUZR?=
 =?utf-8?B?UlZ4Mysydk5vZHg1SUw1TEgvZm5QWGxJelNxbGdObmU2NVVIT1Q3bWtwZmZl?=
 =?utf-8?B?SEpqSGgxWWdiTDR0OVRQdm5JYk9uUk1jaGZQUzEyMkhaRUtETDhld0o1WHBn?=
 =?utf-8?B?Tkp3aWkydGxrbExhQzE1VGhSZEdDQ2FNOGtwYUNVSHhkek1CMzNYT0p4R29V?=
 =?utf-8?B?NUpZYVFUV2plVWhVblk2VkpxMnVsL1FxdU1xcFlmVzROalVXWmxWdittOHNC?=
 =?utf-8?B?WmJlWlRJL1AwUG1PWksxeWV0TUxuc1VQUjlYcWFUUXlvK2o2d3NiQ1lUK2lo?=
 =?utf-8?B?NnEvT1dhYnBpQ0ZtbHJkYmFYVXBMb3FDbVliM2hlTVRaSXIyZVFzQnVpYklW?=
 =?utf-8?B?MWtkdXg3NUpwVE4vdWY4S3BIbHEzYjZLejU5K3dOVmgvQ2dleXZJVFhPaE5h?=
 =?utf-8?B?akRpeWhyckFQRURTWTVtTCtldDVES0RYWTUwNWFpUXpka2dOWVl2U0xDM2wy?=
 =?utf-8?B?cDFNeDduaGR5a0tjQkZ4UmtIQnpyVVhpUXZBVUhQcUVFVERvUGVUTjVlS3Jk?=
 =?utf-8?B?SXFzdFd2Y0hEM1Z3bVpKWFNseGNGclNxQytTdC8rWElad3U4Z2R4Qi9YTi9y?=
 =?utf-8?B?N1dzdHk1OE1mUE0rK2VLbUxtZU9mcG9tS1FCMjJpcjIyN0dOYXZ3VkVrdDZw?=
 =?utf-8?B?V2lxVENwV1VWT3hDN3JiZTlGMXYvZkhIa3o1UjhzcEJOY2xIRHJVTXUyWmda?=
 =?utf-8?B?U3RqMHJhZDlQNjlyemlKMk5lTFcwRDh1MmF0dXdNbU51WGZTRTBEMDRFRzV2?=
 =?utf-8?B?Sk8rR1EyMlBZeFIvVU80RU93WTU5NGYrOU4vQ1hGRzZac094RFZUL3lKeFZW?=
 =?utf-8?B?TDYvUCtPaWk0aDVneHlSMXNmV2UrMXg1VEM4a0R0citxaHdsMi9mQm9kc256?=
 =?utf-8?B?c2t2YTlzUExlWGtjK3JINWVwczZVOFpvQ1A3SGgzdkl6Vy9BaTJkbkpFYWtI?=
 =?utf-8?B?QXJNSld4a0kxSklMMkhma0JWajFodFRKRS9PdFd4TjZwVU1ldVdhcHp0djE4?=
 =?utf-8?B?Z0M2b3cvZWNDNjBaUW50TFZ3ZzVhNFpoRXJYb0ZSTjRXdXVIRjdKRTNMWnpI?=
 =?utf-8?B?UlhMQ0ZNcXJCdW9pNnR6OWJYeTQvamFQMnExQmo4bGNpcnhrS3hpSG5HYnY4?=
 =?utf-8?B?cU5kTWoreFFRUGg0WGt3aStTcWpPVHVHcjNkN2lkVXFKZVRhY2RZRzk5N2lT?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0f6272-ea8b-469d-8e0c-08dd4c1763f8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 10:15:50.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKYBj2imcWeA2A0At2pfd4QzE3i9cCKoH/ER/GP3Hi5mNg83Vwf+JMeOSiWCyZYaY1cx4S5FabF07UtegX5HaKi2aSz+9eqeR2KR3hLTlNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7769
X-OriginatorOrg: intel.com



On 2/13/2025 10:46 AM, Tariq Toukan wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
> Wrap the high temperature warning in a temperature event with
> a call to net_ratelimit() to prevent flooding the kernel log
> with repeated warning messages when temperature exceeds the
> threshold multiple times within a short duration.
> 
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/events.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
> index d91ea53eb394..e8beb6289d01 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
> @@ -165,9 +165,10 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
>   	value_lsb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_lsb);
>   	value_msb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_msb);
>   
> -	mlx5_core_warn(events->dev,
> -		       "High temperature on sensors with bit set %llx %llx",
> -		       value_msb, value_lsb);
> +	if (net_ratelimit())
> +		mlx5_core_warn(events->dev,
> +			       "High temperature on sensors with bit set %llx %llx",
> +			       value_msb, value_lsb);
>   
>   	return NOTIFY_OK;
>   }

Nice improvement, thanks
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

