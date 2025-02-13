Return-Path: <linux-rdma+bounces-7718-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDA5A33EDB
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 13:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E4316830D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE504221550;
	Thu, 13 Feb 2025 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TeBA9luY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48E021D3FB;
	Thu, 13 Feb 2025 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448690; cv=fail; b=aopIw8tf5ehq1eFHb9jKYG8C7kQNvShLQZNvEP03bNzDhoMOw1lR+jLz8clhq36vYqjmf5KuvM5Q0Oz7VXQEQ1gtJASvNExakMNUrIc37TdaswIo2IDgypsZbvGWpvLg0gVYVs3iEPjVMHap1fx/gIW9+iQY0lx9UYWz0YOUH7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448690; c=relaxed/simple;
	bh=PLid+Oqm8jtWEoitA7qZVSwo1PPeWgQQmWQStnMXA5k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qfvwLQ5WOYKvOLOaaIHnzOtKRDB5jVqvOUg3YiSIQie2DUbQ24WqpFnQFWn9Y1SB2vyVvdZRi8nb04Q2IJCPCqLXDpqM/VcQIVqvsO61hzwlUqt9DL4oRp5yVtMro78Zs20RG+d/f4DHKYaacYSYikkY1ZpVdeAYUmav7TYOrkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TeBA9luY; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739448689; x=1770984689;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PLid+Oqm8jtWEoitA7qZVSwo1PPeWgQQmWQStnMXA5k=;
  b=TeBA9luY35VbXtY4PaXsKAXh6UJCMbk5wTMOsVnclxIBi8CXhka09+Vw
   E4RMCzaKU6x4ycofJ+7Z7UySJqA/OkJjNFjwkSo9VcOGnNW7OPwP/W7vW
   AcF4hkD51vrQi6rptYmhfxvosGzgFYj5pl0lu/+3sUjX7IMk8GvtX+Wwp
   5YxWDFkKPm3YIytTbyJy0p0uphCAv44xThzTdj75Uj/nH1VL8cqA0kpkc
   MHGLU2XUXKbUYvOFo8+getO6qMQvgaVLy7woiZwtJTOZy/K8n+XYfuz0z
   uwqzpzO2abNpJJt1jTrUj1weiBDK9G9qwCEicpvujxpXI7t1lgV5uEqdY
   A==;
X-CSE-ConnectionGUID: LDURW4mbTZG+gQ0DPugzTA==
X-CSE-MsgGUID: /abxdk4AQxuvqmH2e4ajPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="50793565"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="50793565"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 04:11:28 -0800
X-CSE-ConnectionGUID: 800uzmIxRc6W34IOgnU7SQ==
X-CSE-MsgGUID: LJjZd3R/RUiTh3Ai4xNsqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150293234"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 04:11:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 04:11:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 04:11:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 04:11:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IssFXRV8PKZwKoVb+L/ix7Q0MyljmBIkDi0TA8/2zq+QjZn2pPn5JNQlchKFgRHdtOgpo0cQyCGuBqB1iOOwBJpJKevW1m8hgWhpAQaH9ABlFt7dQYk3/C3FTYp2AypGvov9UYMbxv44MNbtA3QU5k+d2/cHPTa0PNa4NqCAqZHTm5dXc22YfLS8u0e64aXtRKVvEFtgoL78f1o0rIs/ekTTt8A9gkjwi2TleeF9nKbq6q/hakaxXlSNS/ca1mUbHAZzV5t+UPXjK7t9x+y1qMgcx6CoUWs2OZwjojia455LnJvWT9RcXont2WKeAfaeDDtnnRBQHS78rKAyOpsPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsKEYdjzzzytkyhqWi5dBBDaHgg79OQKRZbYkovZF2k=;
 b=tsqbO2nX51MY4Zr60qUWYiH0VMKl39jxZxoGgxDKuLgbaEU/ILQDs+suXgyFanAe51gF/ka/a+RSA4eqCHatAUmF61YEFKt0vRERWhyvPH0i/hBTZ4b4lm7a86vtW8JRddBNwZlQPpnNMYCUrhlzSFsnJidaBvK0k1Sc38Uj4XlO8TALc9oLXu8rWcdDE4lEfEURoCu5JIZHu5153BA9boC330p4iInDp534GN2YzycnD4fzKO94ahJ5HYiTx9ZDGoQFfo4ZaO6YH8qYhLGfYRXWf+w1xdGBD/XupQB+iTDNgjhJgJwMLBPTaKTpyMOZdvJVj8qEoHrbtex+K/sJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6682.namprd11.prod.outlook.com (2603:10b6:510:1c5::7)
 by DS0PR11MB8229.namprd11.prod.outlook.com (2603:10b6:8:15e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 12:11:23 +0000
Received: from PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51]) by PH8PR11MB6682.namprd11.prod.outlook.com
 ([fe80::cfa7:43ed:66:fd51%4]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 12:11:22 +0000
Message-ID: <c8ff6414-c7f1-4a0e-8318-62dd0506a52c@intel.com>
Date: Thu, 13 Feb 2025 13:11:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] net/mlx5: Modify LSB bitmask in temperature
 event to include only the first bit
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Shahar Shitrit <shshitrit@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250213094641.226501-1-tariqt@nvidia.com>
 <20250213094641.226501-4-tariqt@nvidia.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <20250213094641.226501-4-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0047.eurprd03.prod.outlook.com
 (2603:10a6:803:50::18) To PH8PR11MB6682.namprd11.prod.outlook.com
 (2603:10b6:510:1c5::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6682:EE_|DS0PR11MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 360ff72d-c260-4c05-bd39-08dd4c27880c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlFPalpZRmtzL2ZWTlI4bXd3VnhqdEUyLyt4U0NrbVgzYzhlMThJVlB0ZVdI?=
 =?utf-8?B?ekcwbjN4cTB6YkVBaHFQL0ZuVTg1T1o5UVJhL2xlSmwyQTJ5ZnpwU05EOFhR?=
 =?utf-8?B?VWp4QkZTS2U2SkV0NlQxMzF3Q2pHNXo3d2VrQkQyWmFhaVV3TFNmdGx0UVRK?=
 =?utf-8?B?d3VkSnlnUmFqOXcwWkpva2RsMi9xUWsybzBPMHNTNExLMDBCNllXeHpkeHd5?=
 =?utf-8?B?YWgzZWJmd2RSMnRLWG5oZlRiaDgraGlScVF0NkR1VlhUbmwweWU2YytQemp1?=
 =?utf-8?B?dlY0Z3dlb3V6dHBMNUJPNVdJZjAxVCs3N1oxMTRGbzRCWEhWYUprejlLRzZT?=
 =?utf-8?B?WCs2Q0ZaSVhEZzM0cVVYa1ZVV3ZEajlUVldvV0hoYUxUS0lxYWpNNE92RWdX?=
 =?utf-8?B?WWxhT2NJZGVLZlloRXRvV05OVTdaekNMK2RZZTNMamZXS2FZWGZPYlJSTzRB?=
 =?utf-8?B?SWptOEsxU2N4MERqSURmSHd4Q1ZOc3IxcDNZVFpPNkVyM0dXOFdEWmdLT3ls?=
 =?utf-8?B?YVBCYlFjWm12TmVEbmY0VGJqbDFYZ3AxR3RXN2p2SWFZbS9EeTNqcjRHcVVJ?=
 =?utf-8?B?S3E2bzZvZE1pNTN3NUN6RXZYajdETXJldC9BWFBTMklkSVNoZ1VXQ0FrNDJ6?=
 =?utf-8?B?M1RlclJKY0had0JLTXNZZENjamtac0lwUGdZWnlibGpxM3hiMXJ6a3RHMHJW?=
 =?utf-8?B?V1V3K2R6SnZUNkRjMXQ2TDVXUlRUcEhiR3pLdWsrbGVlN3l5VWJzNXgrSFJS?=
 =?utf-8?B?VWQrWmtCWUozRE5JRi9ROHN3TmdhTGhGbnExcnJ6SnEra0pTWFpITlRScHBm?=
 =?utf-8?B?RE5MZXE3dk1YRUpwVlZYZVRSb2UwL2VTQ2dxd2dmeUVrYWxXVVJoV3RiUmxw?=
 =?utf-8?B?M0hQcWhodThuQzQxRTFIakc1aVVOU2F2RUMrQytIK00zeXlNaCtOL25uMjVU?=
 =?utf-8?B?azFZN1o4c09DVUQxcU5hT1IvUExveUtYVmxycS9KTjMwTzVrYVlZTEI4aHk4?=
 =?utf-8?B?d25sL2hnMmNVQnYxL3pWNGFyTTFCNWFhNXRJY24xaXhCdk50bHpuV20vRElR?=
 =?utf-8?B?K2pUL2VhR3orZUNaeVI5U0YyTXFpOGIrdVg2aWM3Tk9UTXdscmRSMWxoODFi?=
 =?utf-8?B?V2hlNStwK3JVYnhxMlAzYzE3c0o2UmxGdnBTQXhpd2hDeVhlK20vMzRpZnA3?=
 =?utf-8?B?ZDJDVVkyNnMxemNnN1pHQ3NOZ2U1ZWEzY2RyRThHdmkxU1hBdnZaY2FEWFJN?=
 =?utf-8?B?MzE2VWE3NUV6ajhjVDgyVjNNeGd5RWR6cG1MamFlVFozL2RhUyszcFA0WTdG?=
 =?utf-8?B?NFhnZEwxdXJjMzVodUo0T0t0aUI4ekswWTZ2KzRVbkhhQkc5VC9vSVpxZmF4?=
 =?utf-8?B?TW4xTDN4S2daUnRqbjJUREJHd2w5eG9VNVd4UjVjd1F5MnY0YzdhZUN6ME02?=
 =?utf-8?B?OU92OFhRaThuSXhjSEhZZ1gzaFhtZXNhV042d3VXWnoyWVIwTDVhVU84Y3hS?=
 =?utf-8?B?WTNwZzhpUjJDTG5kKy80WDFEN2Y0SldHUERJZ2NZWXBZK3YxRmlvLytQdkFz?=
 =?utf-8?B?TUcyeXlwRlNyUEF5QXFGL1NuMGNtWDNuUEh5UGRRZUo5UUtHa2F6RU9hUWg1?=
 =?utf-8?B?bXM4Z3g5YmhvNG54Q1hUeWhCUEIrM3VxakVQdGd2VnNOMExUUE1Dd3p5RTBF?=
 =?utf-8?B?M2hieERBVERWN00veVgxUnFBVjBQdENUc2ZSYkRWWXUyWjJZdExUVnM0TnFD?=
 =?utf-8?B?OS9GcExzbnZ6VEQzU1V4aGdzRDZtUjdmNWNoWC95dnQ0QWFVVUJpSlBhdWJT?=
 =?utf-8?B?dXdiRysxRzdNaXo3ZUc3MkZYVXh2bXVMV0ErTW5obGhLT1lyakJ5ZmlVUitL?=
 =?utf-8?Q?6LyT4Fyv+Y1ld?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6682.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US90TUdYcTFLaWF1Qk5VbXViUVBYb2ZJUWErVXozSTdINW84N2NrQzhBTnhx?=
 =?utf-8?B?Vi9IaDRvaXB5RmJhRDJSTzFoTjV0NkxGbVo0UU1sUDQwR0NsQXJrYmowRGpL?=
 =?utf-8?B?QmRuZmpXYTR2ZFR4V0Y1K3VRdy93Z25JejNPbEdwbEFEUEVHMVBmbmFxOUtK?=
 =?utf-8?B?OWxHWGd0cjlPbUo2U1NhamdBWVhCMS9UMk4yWlhVank0REhadVJZQjUvQkJP?=
 =?utf-8?B?K0g2ZDFQWTJBdW9XSkFMOG9DUmUrelVGR3VjWWZLeVd6akFlVXMyZ3VFemRM?=
 =?utf-8?B?Mys0dExqUDh6cnI4dXFvaXoxSTA2YmdIbWc1WVBtU0oyaG9jcWpJVC9Ia0lv?=
 =?utf-8?B?MSthOW9BZEpJT2NHU2dvd0tjUk54a1A3Tkl5aUo2M29ULzc5SW5lZm55Tlo3?=
 =?utf-8?B?SWc0TXh6bVFXRWswUmtXOTd6UWN5aTJXRzFiQzJDZXBWbEtvMTgrOTlwNzFX?=
 =?utf-8?B?Rm1ZZGFvRWxkZEdORGxmdHVhQTdNbzVhTmNlQ1EwNnRmL3o3ZUJRNjB3MG00?=
 =?utf-8?B?amZRdTNmWjBtOHhCYzk4TnhIazNncHlVVDM2dWtsZzk0R0x2K21IZzJCTStY?=
 =?utf-8?B?ZlZsNWZ6bkIwTUNBQUlONWR4Q2hZK0NKQ2dicnpkaHVZOXc2UnNkMWRQR0NG?=
 =?utf-8?B?SjhrdWRyakxNOHVsbGVtZ1c3YS81SWFZUS9uV051WmUxblBGbHlGQnhmcTBT?=
 =?utf-8?B?ZHBmY3Y2QXpZaTRVNVQycURZb2lqU09TajlFb0M4SHYyaWRzd2s1Y0FaalRD?=
 =?utf-8?B?RWtaWTdBY1hiRVFXS3NwNU5iSDBTeUJYR1ZHUFVub201Y1NKOVRpY1hxRUVy?=
 =?utf-8?B?VDQ1TTZIUW5mNUNHMVBnZjdSZzRqVHdqbnBiRmY4QmRlRGF4Yzk3ZEFHN1pt?=
 =?utf-8?B?SzFFeFlsbjNxbHdaMjR6S24rWWx6ZDBlWktGYmRsOVEzeWRQS3c1eE9oa29T?=
 =?utf-8?B?b3QwbUVRK1R1V0JBSXlvWDJpY2RJcHZjbkVNQVM4QWlPcS9oaWIrRmo5VHQ2?=
 =?utf-8?B?dmtZNFNReWlwcldqSjhwM3ZWZzA1WDc1LzJVSDZOTU9QQ2h1N2JKVlZnQWx0?=
 =?utf-8?B?MnRjcTJPMmFxTjVZKzJSWEhsL1N0VGpxb05hbGFtMzljU01tVTZuOTBWQnk0?=
 =?utf-8?B?Rm9HTzVOdFNWWlRQRW0wTmU3ang2RHgwS1EwUjNkSFAzUVl0bHBLMEdoMlZ1?=
 =?utf-8?B?V2k5TUFiN3FOdjN0NHBSQ2dvSVNpejZNZHRjSWRsbTQweHpPVzFaMjBQVWdw?=
 =?utf-8?B?bkdCUU51Z1IxN05Ja0ZDOU1PV0x1MjhFbU9GdFhMM3hkTVNEV2NHQ2w5RjI4?=
 =?utf-8?B?N2ZyZDNXd3NWWkZHeFNNRmNtTlN4VmQvRTM1TjdLSVhsME9acGpPdHZjY1Ay?=
 =?utf-8?B?eU1Dd3Q4cGhFZVBoUU82MGhYRHFuckpCdHRER1cyYU93WldKbmg3RzFlbXdQ?=
 =?utf-8?B?ZG5IQzBpT0gya3hXdnRiRExjVnZkRnJEdmFqOUEySVJDMm5ma014Ynl4cXlR?=
 =?utf-8?B?amxtS0NuamFTdGhEY3lPZHhWTHM1ZWJZVzhwYXd6aWszeSswanNUQjdlRWF0?=
 =?utf-8?B?SGIyMFE5UHNZcElRWW0rM3NMMlZaekhXZGxnOGI1YkRWd1lGQnJPeFBlZHQ3?=
 =?utf-8?B?b2tmV3h6K0tlZVgxQWJ0bFdGQjJ0NTVxd1piSTIvUHMrKzNmdTVOK1ZCQ3Fh?=
 =?utf-8?B?NGdmOUY5TWlpRWZ0dmpoTXJnUzk0eDh6bzJQbGJwYzcrbnhYcE9sVWRBLzFV?=
 =?utf-8?B?OVBMdTdqQkFHaCtLc0RvbGJQLzVWVWZlVzRORWhwcFA3OFI2TGRsNXFjc0FY?=
 =?utf-8?B?RzU0RWkwMjd5ZS9paWVWdG0rQm95OTgwZVd6T1V6MnJNckdVNDUyWlJsNFg4?=
 =?utf-8?B?ZzR2eG9BWGY0SU5HWis4ZHJSb0JDeTZmV2o3YjZpTG03MnBRU1U0cGNxTk5W?=
 =?utf-8?B?SkIyMTU3MHJNb3ZTbUtMU2xjRjE2MzFuSjVlR3ZKcUcyMlVlNzkxNm15UWwz?=
 =?utf-8?B?aVY2d1BOYjBZZmFPNjVCREd5NGh0QzZWTEcvUTRYTkNiVE1CeUNleFdYR2x4?=
 =?utf-8?B?TGloV3pmbkF6OXpzSGtzNS96cDN2K3NSdWt5UllxUXlQZVg0aTY2RmhrcVRm?=
 =?utf-8?B?cDIxUnhBanJrV01DSHhrSlRMMUxCMmN1dXE2MlRwRi9PVC80N21DbldyRUc1?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 360ff72d-c260-4c05-bd39-08dd4c27880c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6682.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 12:11:22.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UQm540lkI2R/8B+bjRIQJBnCoe47fRIILPeu9kzpIlC2zgh1djWQ7XNo1YVxujdVh5ydqFwezucsrPVyKF7DStADsikIN3G2wGviRDt5w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8229
X-OriginatorOrg: intel.com



On 2/13/2025 10:46 AM, Tariq Toukan wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
> In the sensor_count field of the MTEWE register, bits 1-62 are
> supported only for unmanaged switches, not for NICs, and bit 63
> is reserved for internal use.
> 
> To prevent confusing output that may include set bits that are
> not relevant to NIC sensors, we update the bitmask to retain only
> the first bit, which corresponds to the sensor ASIC.
> 
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/events.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
> index a661aa522a9a..e85a9042e3c2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
> @@ -163,6 +163,10 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
>   	u64 value_msb;
>   
>   	value_lsb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_lsb);
> +	/* bit 1-63 are not supported for NICs,
> +	 * hence read only bit 0 (asic) from lsb.
> +	 */
> +	value_lsb &= 0x1;
>   	value_msb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_msb);
>   
>   	if (net_ratelimit())

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

