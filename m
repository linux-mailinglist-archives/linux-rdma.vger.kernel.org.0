Return-Path: <linux-rdma+bounces-21402-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MN8MGprF2oYEggAu9opvQ
	(envelope-from <linux-rdma+bounces-21402-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 00:08:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2292A5EA8CA
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 00:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ECDF30834E6
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 22:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57533C2B8B;
	Wed, 27 May 2026 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrWAxq1z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E471F938;
	Wed, 27 May 2026 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779919695; cv=fail; b=ONHWaguEsELFd/bKor2ZuMFxyszMgYH4l6aNLHnkphJA7vbk9siVrx3oShq7kYkQhnWEY7KiadWlWAIJmTbrNT1l87jtnSxeegp4GmOT/RiD4ypZqJVN/11hnyt3WYwl5HpwTMBOikMLjaYc+P+h9WzJbJtKS3SFvQ3w5bzYYLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779919695; c=relaxed/simple;
	bh=gpySjjm8bR+I8MkfcXNnj/dpS+X/kB6ggXocuc2yLFI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oiOi68RRI0k2058DWAQtkaaFzi7JuiYOG0tqCNiQZSsE6oWGypSDgEEPdoznkfie3cWq+8+umOOBp/MNE8rMVHoHSW0wFylyFKOx1EiQmEZij4KkOtbq0bAc/ryyTg8SHBlQFOf+p/Y41T53eOoNEDWqP9MOvX7q6mejv6aoTK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrWAxq1z; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779919694; x=1811455694;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gpySjjm8bR+I8MkfcXNnj/dpS+X/kB6ggXocuc2yLFI=;
  b=FrWAxq1z9uyupSeK4Wg3AcPO6eRgX5znmp0H3Lcek6Q91qT+ASgsL80g
   Y2S0RGDE1B5qAiOW1fmRQeA4rHU22yJqWmKKH+W7shpopNaO/wGrN51pi
   T5IJ1zHV8JeDKle2ZjUx+iocwc2rPfCZUF2QgWU/OSpWVXUPcWZNV3Jt4
   Z18+SKAW/Cx/uuNbv62kOrK06HArXGlgIa65St90f803OU9euIu6LE5KS
   eHOb1FdamkIT07MVY8C6GCPsDH1RZBO8h82vjs9ZIoG8nBpDttNSMWe7X
   2tl/EcQb7gGFTtUjsOWpHOOqTXzGjBQUERpIQKU9wDz5OGbg7b2ltqw0J
   w==;
X-CSE-ConnectionGUID: Y+nMF5PDRdG12GzcC/nDwA==
X-CSE-MsgGUID: RpqJT3VEQMqaxDc5pKygQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80794065"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80794065"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 15:08:12 -0700
X-CSE-ConnectionGUID: EK7vEsgKQwi7eM+/SRQGEg==
X-CSE-MsgGUID: hhPjv/C4Q7ub0ANB7e2FcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="242516181"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 15:08:12 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 15:08:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 15:08:10 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 15:08:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0Am/DvKlbBE10sMFxt66/y/5uYl6yze9vrtvsTsRQ21KKwxgmYiVwBCLqfbIrU/tXt4EfqBjg41a40h3Gk8zL5U4SOF7ZRRGPd1nP/1kgmgCGkZ9f54GMDGtzq1yRw7kRuKKovblfhjHh3uPWPd+L6tPUeufdGpnpFsjGpkJ08kyN/iP35h8O3duQKDidrnVJAsL7dTflEB5cIqtBdp4zH5MaawiC3xBPDdn+fqB3kmc+qWNDOcJcT2oOqM3zu/XRYf4Koh8YSJjP7Lzqsd1RdOZA8pDkMJZ5XTrNL69pwjj70Cj0vFcZEq+W9bAqdzx6D4oKnzbvTG5jV3DhU1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAhd1DtEhyobM1DR2SfO0AVD2P62BBCe7DNeLm5uMso=;
 b=T3w+omTr/j0IQW1I7oFcAS9eVh+di1ARtEzP5fDTxB5/ncnX21MDTxlVF9PR5T9bEbBSIHfnBX/yB4VgUgsIN2esW89jR8/sycKZFCgO0hsaYKcmMaHG4n1W4BvV7/EZGUlYgHKVWbitQietNUppS8Ra2Hy50WHoUf1APvn6hAL+VjI3D+ST/aRSDyVMYQ2ypMgJ3pSGjmLg0SdWjCqJDH37wrOc1tRWjeDeHtRDRn/QWSkZeui9Nw57jOgcc5SSL0nPhCd6KNSdmkdiPm7Q/zheR0twDV+Euay3YJsa1m6HRG8TY8zGtovBfy5UkPY8YX0vs5CxIPHWhFjGXKB7jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ1PR11MB6084.namprd11.prod.outlook.com (2603:10b6:a03:489::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 22:08:07 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 22:08:07 +0000
Message-ID: <0a432449-2409-4e55-b17d-9d2fe1cc4860@intel.com>
Date: Wed, 27 May 2026 15:08:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/13] net/mlx5: Add switchdev mode support for
 Socket Direct single netdev, part 1/2
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>, Shay Drory <shayd@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>, Maher Sanalla
	<msanalla@nvidia.com>, Simon Horman <horms@kernel.org>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260527125427.385976-1-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:303:8c::6) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ1PR11MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 20de13b5-c49e-4ee1-a5cc-08debc3c6ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|6133799003|3023799007|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2Jwt2i6cPzkzg3ZO9dHGvnA6hC29RzBwCaEMzg/iBXZ/0lJTt1Inkwztfij9tw0SUI0ysPff+YSCuPCPijutH5b1Gg1mwL4L1h8kf1NPN1HYOrpgS1EdJGtI9agCiBLhJyS9NPp6DVtjNXfXGSK1xoj2cH8vS8aql+tAUl3WF5VLCKz/kurWrILr9ry2T0pDjFLmgRuPVmgOAFKv/mIKqzZgOBsfD1KE2B1z0AUlFItLoLUS30Rbyzg0RcPpZA2XpWu5Mkh2YP4VkbYeP1K0T8pTY/Mnp4cCMAbvq/bqhA0QWw4VhHN2gmKEiJE3JEQFlb13En/Jl7g0UJr8wgq2jOhdQx7AuxH1GaG81bVDWZMpKEFgfwvsivGhKM4ojAbnKRMXDTvOO6yD11MfNhoxMTkQHakSog05wa3JLpqJC/TNJE3BXv1iadiomsjI9cazFLKOtuLOV0iZQ74jTGrepioKM19a5eqkbPmO52PvlaYpqk1iEyGegrkbAz+3HkWPllzKE89jJZGAd+L+MYSZKTvS5Jpn4UBvJiauvjh3c5XSdA65m1EnbO1cw2kGWacUuEb6Wn84hd+O4Qg5LME51vdfINQC4wwvj6upcnwSOYbHGf9R1bzyaC5vBZlYWTR99hsfcNJJF7l6UyvoS+yds5xVxYbqX1s1/3jUxelJ8OUuQbYf/XRFfuxGJRPvZSMN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(6133799003)(3023799007)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHVQQXVRUGRuN0VVNTFUTHdicHJNVDd6WEtiN0FlOGVmcm1oMmxlODcxeFRS?=
 =?utf-8?B?TnkxT1AwbHZFakVaaTlXeTU2UHBhWXZ2eUt0MnRacGE5d2g0dHhtZlFjeFVl?=
 =?utf-8?B?eXc3T3ZLZ3hQUWd5cytwUGRIMjNRMzN4V1d4VUdLT2UwMHRMTk0weXdpZEw0?=
 =?utf-8?B?aGYybVpMM3BHZUU4bWhoWDVLZ3VnV2ZXVW5pZDdYcEE0RncxdDBuR0R2Nmcv?=
 =?utf-8?B?QU5oTXlhcWVPQ3ZDMVhheFdGa3Vua3FUM3FlSkJSQkpERmkrb1ZoRjRXWmQy?=
 =?utf-8?B?bzVTbUdnLytZWkFwTEdNN1MrNUVxRjNPZFlLdTB4Q09VdCtHTlIyeU9JbkZ0?=
 =?utf-8?B?ajlFV09JQmJnV1ZaVGQ4YmdEWU0wTFg3S0pUam94SDFzMU9uQlpTdkw3Y0xz?=
 =?utf-8?B?L20rRjZ0YTVzcEZDQVNzWlhkVnpHRE9wMFlyVnh3M3ZQbVFSWklEckEwWHJk?=
 =?utf-8?B?VXVnVGZvTWNlaWFPVDIyakhWUG1MVHVaS21EOWtoWWdqOGswQXpmUkN4bHJN?=
 =?utf-8?B?Q3cwdThkYWFHSkNJUElWeklrVDhUYVlMUDl1V05PSGc5QVRhTituSjRWUXVV?=
 =?utf-8?B?UG9MSFJDeG00dWdrcHk1SThqQzE1R25VWnk3WmdnOUJ3UHNBbUNXaEpUbjhG?=
 =?utf-8?B?NHhTRFFqL0daMGZ2VFNhRm14a2VXN1RHZTU0cy9rcWhhWXJmSHdvcnJxcEkw?=
 =?utf-8?B?ckliZ2ZMOTVNNjU2Y1VmUXlmVDJwV29yWUhCZkdLeG5DS2orTmtacnpic2JU?=
 =?utf-8?B?aFZjbzBqRjFDc2VwVTk0Wi9PWjAzTTRpblR5dENCVVlXNEFPbVhMaEJ5bjRh?=
 =?utf-8?B?bWo2bVE0eFNObzkxL25MUHI5VUhJMG9vdEdLNndtL3R4Mzd1alVWS3VLK1Ns?=
 =?utf-8?B?ZmMrVDhvZEhQRUxUcmo4d0pCeTczUTgrZmVmUCtPSmpoWTBXVytLa09rcktq?=
 =?utf-8?B?RDQyUTJFWFFZcXlnbDNGaXVjN25YQnZmQUUzNXBoWGtkYWt3a0NzZ2Nwczlm?=
 =?utf-8?B?T0VJK0MwdVo5bU9jRjJOVGFxeEhFVk1BeHp2U1R3WDdSYmxMMmF4SEYxWVNp?=
 =?utf-8?B?SnpQV0h5VkkrdCsrZ3ZTVEREbWUyeWJCZ2duTGs1aWZHTFBvU0Z6OTJwdHp2?=
 =?utf-8?B?ZGljN1pJM2hXUGdDOXk0aWpDVDR1bXdwdzVUdkY0N2lXNVp5cDdWM1ROWFFx?=
 =?utf-8?B?WTBEajAyUlg5aUcyM1RXNGJKU3NoczVWQ2dYU0szYlVPMUpuUnF5SW5mT3o1?=
 =?utf-8?B?TWpKd2NiNi9qdTlWUHh2cFpnQU81Sm1MTGhUTGlPS0YyTG9JTW9qUGdwTU9O?=
 =?utf-8?B?b3YzMGdEVmxCeTA1Z0thdEU3UnhLRTFpUUZrN2szS0VkZURWNHFxWUZ3b1pX?=
 =?utf-8?B?TW1mZ1BWei9Fd2RhUEg4N3JaNzFCcjJmQmc1MUVMTHRkczZmMFNEYWxHNDBV?=
 =?utf-8?B?Yi85Y3B5SlhJWWFObDYzWEZ5TzFqU0hGZXFielJoQzI3WkdJcFlJWlMzSUlM?=
 =?utf-8?B?S0pIMkdvcHdvUXdxVDNMWWtJOXIybDhnWXZKeHpneVl1TTU3U3JNVDFPYUw0?=
 =?utf-8?B?YWQxYkhVQUVTRkF1RVdJZkErK25aTWFDcWNHUUFoMEN6c2d5THhIcXdSc1lo?=
 =?utf-8?B?UUpyd000emZJWjgwS3daTksrM092N0hNcVlVYlQvMnRhWTdhdnRGOTUvMDZF?=
 =?utf-8?B?UUl1VXduNWJSMFdRQ1pQWlVoc21MQjhna1hvTFlCejhvdHNCYWwrTEJtenhX?=
 =?utf-8?B?aVEwMklFZGZ6eFhYeTJyQlE5NjdxMTVXMFNaMEk3OTNyUmhaQTFUbWkwQnJO?=
 =?utf-8?B?ZzA0eWtRNDBod2M0UVJiVGd0Ym9mODlYWG1hNlp0QWJCTmxUU0RDU0poelBy?=
 =?utf-8?B?UXYxRDVJOHczTTdMLzNkQndFSkVrRjNCUnJaS0h5dUg0RXZyeXBXbCtNUXdM?=
 =?utf-8?B?aVlIZk01T05LYTQ2UGQ0ZTN2YklkdTg0QzVvZXFYbi9rM2pETldTYjRsTkZw?=
 =?utf-8?B?UEhJVHF6L0hvMUQ4Um1Ec1JURzFXOWk3VzVwVE4yWXI0SzVPNE01M05RcmtE?=
 =?utf-8?B?MzZNQXNqQ2RJQWsrSE9pb0lndEhSVFlhdVdWMnhpSWlNc1JDbWZ4RGkvN1hl?=
 =?utf-8?B?eFlhM016QlFkY0FSdkp4MGFadkNDYjluQ1piZmRtbTBTd0lEVWk4NktNUjlJ?=
 =?utf-8?B?UnVEekM1cmIyQUs1a0JlR0UrT2ZZdHprN1daMmdyVjIwRmZoY3BxckhGQncx?=
 =?utf-8?B?b3dpc0c0SGZ4U29kNEVKaFFLZ3dxZUh1UllSZ3YzeUx4bU11d1A3WktMcmZo?=
 =?utf-8?B?RUd5Qnp4NUhZUCtGNTgzV2hHVUhqa0dOdjVKc2FkNlVkdzFTSGFyUT09?=
X-Exchange-RoutingPolicyChecked: F4vzbHi0jwTPg0pfjVbxA4QLvIU6nO8wbNNiSDk2t4XocbYxXx/2JC5EWZkT3XVHHa8sECI8WwsGtfLZNURDiKG+LqsCYhqmV0M9Mcy5iciRyFe2alldc6jphghFA/N+oqZDVwg4h06BtFpQHh9LTC3S3rEkedjjM8UTiColHoWy8KLLRH3JG7vnc50UCAB7iExEOR1KPjvkf/R0ik1TFMOBn2Io3w6o/oRvYYrRwFFMDX2ap2EyRXhVy5TPmrM7DyIQzAf4yPI36aEIFUJDAMdmNhWgGlmo7H84tOKfM1YTcXQOsVE/FI9ssmaFQPy063dzTybYxnovuxUcDS5Lpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 20de13b5-c49e-4ee1-a5cc-08debc3c6ea0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:08:07.5213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGh+uHfkFM7KeOAeWug2ZY1K5PHzs7zpL0e3gPPDK/zz1sx+jyRoeN+D8Mv7Av7twRuX84Ikli+tZSVjk3uegquX+uu+gmo8xNOf2rFGdn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6084
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-21402-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2292A5EA8CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/2026 5:54 AM, Tariq Toukan wrote:
> Hi,
> 
> This series enables Socket Direct single netdev to operate in switchdev
> mode with shared FDB. See detailed feature description by Shay below.
> 
> Regards,
> Tariq
> 
> 
> This series enables Socket Direct single netdev to operate in switchdev
> mode with shared FDB. SD single netdev combines multiple PCI functions
> behind a single netdev interface. To support switchdev offloads, these
> functions must participate in virtual LAG (shared FDB).
> 
> Design
> 
> Rather than introducing a separate LAG instance for SD, this series
> integrates SD secondary devices into the existing LAG structure
> (priv.lag) created at probe time. Each lag_func entry carries a
> group_id field that identifies its SD group membership (0 means not
> part of any SD group). An xarray mark (XA_MARK_PORT) distinguishes
> physical port entries from SD secondaries, enabling a single unified
> iterator that filters by group:
> 
>   - MLX5_LAG_FILTER_PORTS: iterate port-level entries only (existing
>     behavior, used by bonding, FW LAG commands, v2p_map)
>   - MLX5_LAG_FILTER_ALL: iterate all devices including SD secondaries
>     (used by MPESW shared FDB across all devices)
>   - specific group_id: iterate only devices in that SD group (used by
>     per-group SD shared FDB operations)
> 
> Existing callers use mlx5_ldev_for_each() which maps to
> MLX5_LAG_FILTER_PORTS, preserving current behavior for non-SD
> configurations.
> 
> Lifecycle and ownership
> 
> The SD LAG lifecycle is tied to the SD group, not to bonding events:
> 
> 1. At PCI probe, mlx5_lag_add_mdev() creates the LAG structure
>    (priv.lag) for each LAG-capable PF. e.g.: SD primary devices
> 
> 2. During mlx5_sd_init(), after the SD group is fully formed (primary
>    and secondaries paired), sd_lag_init() registers the secondary
>    devices into the primary's existing priv.lag by calling
>    mlx5_ldev_add_mdev() with the SD group_id. The primary's lag_func
>    also gets its group_id set. No separate LAG instance is created.
> 
> 3. After all the devices in SD group transition to switchdev,
>    mlx5_lag_shared_fdb_create() is invoked with the group_id to create
>    a software-only shared FDB scoped to that SD group. This sets
>    sd_fdb_active on all lag_func entries in the group. No FW LAG
>    commands are issued since SD devices share the same physical port.
> 
> 4. If MPESW (multi-port eswitch) is enabled on top of SD groups, the
>    per-group SD shared FDB is torn down first, then MPESW shared FDB is
>    created spanning all devices (ports + SD secondaries) using
>    MLX5_LAG_FILTER_ALL. On MPESW disable, per-group SD shared FDB is
>    restored.
> 
> 5. On SD teardown (mlx5_sd_cleanup or device unbind), sd_lag_cleanup()
>    removes secondaries from priv.lag and clears the primary's group_id.
>    The LAG structure itself is not destroyed.
> 
> The sd_fdb_active flag is set on all lag_func entries in a group (not
> just the primary), so any device can detect the SD shared FDB state
> during lag_disable_change teardown without needing to look up peer
> entries.
> 
> SD shared FDB is a pure software construct -- unlike regular LAG modes
> (ROCE, SRIOV, MPESW), it does not issue FW create_lag/destroy_lag
> commands. The software vport LAG for SD is implemented via eswitch
> egress ACL bounce rules, managed by the IB layer through
> mlx5_eth_lag_init(). And the software LAG demux is implemented via
> steering rules that utilize new destination, VHCA_RX.
> 

I appreciate the overall details on the lifecycle and ownership. That
made it easier to follow the patches and understand the changes.

> Patches
> 
> Infrastructure (patches 1, 5-6):
>   - Factor out shared FDB code into a dedicated file
>   - Extend lag_func with group_id and sd_fdb_active fields;
>     add XA_MARK_PORT and unified iterator with group_id filter
>   - Extend shared FDB API with group_id parameter
> 
> E-Switch preparation (patches 2-3):
>   - Align eswitch disable sequence ordering
>   - Move devcom init from TC to eswitch layer
> 
> SD group management (patches 4, 7-9):
>   - Replace peer count check with direct peer lookup
>   - Register SD secondaries in the existing LAG at SD init time
>   - Block RoCE and VF LAG for SD devices
>   - Block multipath LAG for SD devices
> 
> Switchdev integration (patch 10):
>   - Keep netdev resources local in switchdev mode
> 
> Steering (patches 11-12):
>   - Track peer flow slots with bitmap for selective peer flow deletion
>   - Enable TC flow steering for SD LAG
> 
> Enablement (patch 13):
>   - Verify unique vhca_id count for cross-VHCA RQT
> 

The patch 13 being the "enablement" is a bit confusing to me since I had
trouble understanding how the patch description is "enabling" the socket
direct stuff..  But the description does say "part 1/2" so I am guessing
thats addressed in part 2?

> Shay Drory (13):
>   net/mlx5: LAG, factor out shared FDB code into dedicated file
>   net/mlx5: E-Switch, align disable sequence with switchdev-to-legacy
>     transition
>   net/mlx5: E-Switch, move devcom init from TC to eswitch layer
>   net/mlx5: LAG, replace peer count check with direct peer lookup
>   net/mlx5: LAG, prepare for SD device integration
>   net/mlx5: LAG, extend shared FDB API with group_id filter
>   net/mlx5: SD, introduce Socket Direct LAG
>   net/mlx5: LAG, block RoCE and VF LAG for SD devices
>   net/mlx5: LAG, block multipath LAG for SD devices
>   net/mlx5: SD, keep netdev resources on same PF in switchdev mode
>   net/mlx5e: TC, track peer flow slots with bitmap
>   net/mlx5e: TC, enable steering for SD LAG
>   net/mlx5e: Verify unique vhca_id count instead of range
> 
>  .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
>  .../net/ethernet/mellanox/mlx5/core/en/rqt.c  |  27 +-
>  .../ethernet/mellanox/mlx5/core/en/tc_priv.h  |   7 +
>  .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  83 ++--
>  .../net/ethernet/mellanox/mlx5/core/eswitch.h |  11 +-
>  .../mellanox/mlx5/core/eswitch_offloads.c     |  26 ++
>  .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 429 ++++++++++--------
>  .../net/ethernet/mellanox/mlx5/core/lag/lag.h | 100 +++-
>  .../net/ethernet/mellanox/mlx5/core/lag/mp.c  |   4 +
>  .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  28 +-
>  .../mellanox/mlx5/core/lag/shared_fdb.c       | 233 ++++++++++
>  .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 227 +++++++--
>  .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |  23 +
>  .../net/ethernet/mellanox/mlx5/core/main.c    |   3 +-
>  14 files changed, 914 insertions(+), 289 deletions(-)
>  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
> 
> 
> base-commit: aa064a614efcfa4c300609d1f01134e99a12ad10


