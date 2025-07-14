Return-Path: <linux-rdma+bounces-12140-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F0DB04180
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 16:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A29A175205
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0659D24A07C;
	Mon, 14 Jul 2025 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmhsyiVg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01B248195;
	Mon, 14 Jul 2025 14:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503008; cv=fail; b=oeBDiHvm/WZczrnmc9McFifvTPrmNdL30U+xwebbGp3PePlixEhm/mDQbEZwPTjEfPmm/ihckFIgy0yy9P3+QKCJBBt3QDQU7iYIN0j8rMpv0Pt5Mk/BLj1Lgt0rpkDCqC79BsCZXAs4polaaM7MkF6vpmXz+urBA/ifZxzbFro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503008; c=relaxed/simple;
	bh=5BdM9vAs3ZjSLzFLIJ9k3TukaOA4HfO81Gdffy91AjM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OL3q6GG0Xo7AfU9FMtW5Arv/vDXHWc7cHUXg8pFZw+evPSXijsx96dQOkD68rY/fL7JNrvEuqvBZjeDEcOd9cOSwlPshtVr633lhjhnn9cQNbakjDDN4iRKmFaxliepmgXWjdcz7BkY55h4IsyNfJYPTE8EJtuGPlynnxIHUxI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmhsyiVg; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752503007; x=1784039007;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5BdM9vAs3ZjSLzFLIJ9k3TukaOA4HfO81Gdffy91AjM=;
  b=VmhsyiVgl6My9gaIr0qe5JtjUwYCUUdQTA1PkE2ynvwhHE5sruN13USs
   gYtVbBw460aJweyJsaaECMs5Fu/F8XuelheS1NtdiGNr7a69xM6AuCyJh
   1qkn1CDKtA1D3An8zk7oZ8R3pceKbsrBoKwQYFTFBpjXIjcwtltDp8SlT
   5jMz0rjSy6MHQPI3EyR8JJTz9PDwKhERmegEJ4QwfrbtekSapuD50IFsc
   6yOKddCwC46fxgh1qrX99zmaylzyCgjfLizP/Vs6yVuK3VZMvCWsp2JgX
   prbV6B9YN0a2JP/BZCj0EJL75J5SpwBxpef5UvbNTJtSwMZtnJlvJjEaQ
   g==;
X-CSE-ConnectionGUID: 0IMR3FOyRHCw2ALmhStHCw==
X-CSE-MsgGUID: 5Mrj4SZtRkGZLwUfq6/wOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66057048"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="66057048"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 07:23:25 -0700
X-CSE-ConnectionGUID: m9S8gMCWRkidB5PTpxzo8A==
X-CSE-MsgGUID: RrnbobX7TVyuhtUnB7Ffqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; 
   d="scan'208";a="161248050"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 07:23:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 07:23:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 14 Jul 2025 07:23:22 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.72) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 07:23:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qlc1gU2s/f0scQqW7nmpBAuUd1CET5Sjt5CjR4yHMireB4REiVDPoj6ahauV1EppT17Y7MWd/5YGgZWKBf0zVfDsvqSdcboQxlZGU6tdbepCeV6aInjeFldINabNLxPmjojun8YODDA65j8+CceS141N8RK420ko/snzC7l2+H4kdR1GREP6OzMyAYGpzM2QR5zYv6dXvC2qQRX4wZsNqfYCL3/thd5JGAidDQrLT89RVaThp3LRUVpDN76m3cLVrtIF87C/ue3mJommrZXa9da4/vnbkZz3yMnO/agXmpKM3XuULNDMw0qw3C1eVLEdFbVa3xfStlbZVv9YZNAAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0sSMOCbRW2K4SEcNgB4KC1kq3VPGHFdJlXm432ACjU=;
 b=L8TvEGfA5ljdNRPR9rwL0J+rwzXupQj4KOKNHPCbbbsTO3sRZz/eZTufFtPGHf+9kgaHguQqCpBFz061oUenmciIHb8XvdopWAPBm+BH3xIxj/dEz30Tnv5RBopZAMW2kx4Osyl9lDQHiBFXbg5CgfFQ7cQtLYfyp6r/Mr32S/Tfi3DrxDYXaPcPCr+ylkqHvQ5jFHMEq7SNSVQScEUc2xWXQWQjk3puxCACMlk4QOAIlsrQ5GRdXcLY0WMjtJdwc2IWUOJEtEVOZCeTApg5+Ib5Hn1Ma8dcTIiEjI1IwAPxkYhrqU6oB1ng/D++gHkrUjEg/25zH2xMyQKUJtolEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 14 Jul
 2025 14:22:35 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%3]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 14:22:35 +0000
Message-ID: <98c8c7d7-4b1a-474f-86b6-884d79ea4e41@intel.com>
Date: Mon, 14 Jul 2025 16:20:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net/mlx5: Avoid copying payload to the skb's
 linear part
To: <cpaasch@openai.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-0-ecaed8c2844e@openai.com>
 <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-2-ecaed8c2844e@openai.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-2-ecaed8c2844e@openai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1777db-ea0d-4fd4-67b9-08ddc2e1e107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akpBSDB2Qkd3eTRITzBJTzU2OVZvTklaRTZYTHNleGducVZUUWtJVm51Y0NW?=
 =?utf-8?B?eGU0a1ZrM05nbGNWSFc0ZHhmQThaeWxsejVaUU5Tc1RWZEE5bmp6T1FESW5m?=
 =?utf-8?B?UHhTeFZxZ1k3QXBIcFhHZktaU3g0RUorRGhqY1pXSjJyT052dmpWMDlmempj?=
 =?utf-8?B?bWhqVFg3bWV5U29EbS8rUGVjOWpONWZ0UEl1OTNaZE10VHZwcGtidkY1TUhq?=
 =?utf-8?B?MVpTWGRmbzYzN0VKR3l4S2x5VlZ6NTNTU1lDZ2FwU1RxY1BLekVEU1AvQ2Nw?=
 =?utf-8?B?dTZUbVI5YTRMTy85U1JPd2M1aW1oRnJFTDRrZDNQQUd2d25ZVytvc1BpRTRM?=
 =?utf-8?B?U0pGOHpyOFlISkFFa0g3YUZjcEcxUzNLVXh4aFo3Zk9yK2d0RzNYTmdlZkZy?=
 =?utf-8?B?VXZadjYvdk9UQWpySkROZzlsWUdqVVRZOUxpRTQvRFlheDlaRHdvdndOQ1VI?=
 =?utf-8?B?bm1VUXBBa1VQTGszc01Cd1Rsa2lxaGliQlR0VDE3SDdzQmh3dnhrdndXUmYw?=
 =?utf-8?B?YXIrSVBrM1VqSHJNSXRwNUlYaWt4YWx3TlBEaDNQckhWMENrdlpCTEw0YjRl?=
 =?utf-8?B?OTBWQ3hOKzNabFJKWDFvZmpYa1A3Y2V0VVIrWDhHaW8zdU1JV08xT2tmSkto?=
 =?utf-8?B?Ny96d05FNzI1MDZYMXlEVFJUT2l3Zlc5UDIzdHlib0VmMXEvYXFvaW9xaCtC?=
 =?utf-8?B?ZVFZRjRyajhldGVESG9LdnFnRTc2M3U0S3pzM2pUWC93bDlzZnZRU3FaanRS?=
 =?utf-8?B?SDN5WEl5ZEorZ0ZwV24xMVpFS1JKdG1Pc014dTc5MjBCZTdHM05mNkpCVHNW?=
 =?utf-8?B?d3poaEZMS1d1ZjB0T0d1eTBBeGZXenhMN0pTbWxhNWw0UHE4S3BpWmJma2ZI?=
 =?utf-8?B?amJzbk9EdlJzZGtGZWc4ZnB6MGNPS24rR1BLWFREalVBcDVPQUtzalFSdDI5?=
 =?utf-8?B?VTVlc0w1Z3BaN2Jya1VRL2pHYjhXTm0xd0toZUpRcW9WYkNxMlFhbzZubTNS?=
 =?utf-8?B?T3FsUHV3YS9jZ2IyM2MrYnhDZ0M2WGdFTlo3SzhSWFhqNFhmYUJRUnU4cElz?=
 =?utf-8?B?WDk2MHBJZ2lzc3B5UjZkUWd5bjVFVEdtZURYSEFqSVA1YjVHMk1SaHdzQ3Rt?=
 =?utf-8?B?bDFrVTBGSnl0OHhiaTZ5L1duRkhWOGNkcjI3THNMRmZpb2IrN1I5eGQ0VTE4?=
 =?utf-8?B?MnRITS9HOUR3VlRDK0FJRWZ5eDJPeUovK2t6eG1hYzhMaWRJNUtmQ3lDQWtM?=
 =?utf-8?B?Tzh2NXlaT0tDL1BocGYyNnVoK1FyOEp3TmZOOGtmN1phYkNRa3I0aXRod3Z0?=
 =?utf-8?B?UVduM2tkU3lZbEVkZnR0b3lpdXNUSHBzam1JbXQyVkZkb2ZpUW5OUVVES09u?=
 =?utf-8?B?UVZSZldqYlFXd1dCcEgrUk5RRnRjODFTNWRjdGlGV1doSHE2TExvRVpyV21P?=
 =?utf-8?B?MnNpcWVSQzFKeEFRL3NGN3F5emJMMWpsQ0pQM1JtaXoxMFk0QWF4M0hvYnBq?=
 =?utf-8?B?UE16UVZ3WTI0REJ5R2xySzhMeVg5U29DN1A2dXhBajduNVE3clpWcjhZUGw4?=
 =?utf-8?B?MFJPRmRVa0VtaHVZWmM5dE5ydWFreXNBQjB5bmR3WVhwTWxVMk4zc2d5RThH?=
 =?utf-8?B?Q3VCcnVNcXAzdkVwc1FsSEhqS1E4R05uN09nSGFhcXhjcU55Y0lPSldIM1g3?=
 =?utf-8?B?RXJ3Rk1rQlVSQ2pKbkU5TkI0RE8wTGEyTlVVQVpBczFQakhFWUxNWWluRkJz?=
 =?utf-8?B?OVh5Z0pJWWxkVkliV0tXVjJBWStIU2xJdkIzbnZyanREQ242UHBkQ2lpNUpN?=
 =?utf-8?B?VVFVSXk4bWJmQm55aWo1bWhzWHNjemN2WkRkZ05hd0drWWxTOThqVmRWZkt1?=
 =?utf-8?B?QXh2UzRiSlF6ZnZ4UWxYRm5WbGFYWkcvUUxJeHVYY3JxVDRTa0NVUXZRNUVy?=
 =?utf-8?Q?ClhIdaAZP4I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1Y3TFpzUE9oSUVpVWdIYUFqY3lONkxUWFZzOVFJSEpFcDhlcHdySFg1V3Yw?=
 =?utf-8?B?YnBOaWMyaGRPRHVLbHphWDVsbDh6VDJvSDhpemlGRi81ZDNCdFBYUTNmYU5y?=
 =?utf-8?B?c0VCZzAwZlVmdmpuUjlPeFo5ZURNTHRsVXR3Q3lTUW5Sc3NGMDBSdHVmaGM0?=
 =?utf-8?B?eSsyTjFGUWVJa083QkJxaG5xQmdVbzZVc0o0UEs4bXFqblJjYWhtSHdKT29M?=
 =?utf-8?B?OXltdklaNHpzVk9TTXhiQk1KVTU4eVZVeDdZVnY2SXZ0NGNqRVJGaExXVW9k?=
 =?utf-8?B?YW1za2E4SVI0dnBCenRsUkhrb2ErbjRWaWNrdjRyb3ZHVVhSRjNsN0ZzNkFG?=
 =?utf-8?B?c29yUjVvc25zT1R5dFh6U0FuUTE0eVFnMks2eWVGREQwSlV6bVJTL1FWTFAy?=
 =?utf-8?B?Rk9NcnBYNUZNZ3VpeG9FQ0dpb0NjNGJBSnZTMHc1UlFFQTFBVGJ6c0dxNWt4?=
 =?utf-8?B?d0lvZFVxVWVRMjgyenFYSWdXdzVyYVFVTTZBbEhrT1kxZGcwWHdZVFdZU1JC?=
 =?utf-8?B?NTJaenZSZW5XVGJMdWNldFRNSm9xbDhaeWswZS96MTZMR0ticmp1WnB0RDI3?=
 =?utf-8?B?dkFIRHdjS1VBRkh1MHdmWFl6TkRPMlZsdkE4ck1rTXFyMTRJMTdqK2ZYSDQ4?=
 =?utf-8?B?UjZucUZPQ09lNWFDa1U5UnBwOGQ0MUxXUFFLeVM5S21heVVvbmNIUVY2Y2hL?=
 =?utf-8?B?enNpOEtZSnZveWlVSmZ4QXZlNGxNY2hoMS9QTkU4cXZlYVlDUzlyc25naElL?=
 =?utf-8?B?NHkxRVdSOGNVWjBEajNxbUNCUDM3N2daWE5hY3VvYlM2anZRdlJOb2dPaVQ0?=
 =?utf-8?B?UlVDSnRrblQ3cTZrSnhWbm5mS0xJNm5yMWtPdllkVVNLMG5wUzZSamFVV1N6?=
 =?utf-8?B?Z2N3L3NzY2d6OWxET2FpY2YzRUQ5RUhxZ1A2UUJqQ1FhN1EzdkVLdUNBclpu?=
 =?utf-8?B?WlgwM3AyempJd1k1UlU4RUNpdW1BUXpkd1RpV2VMVUNsTWlxNi96RWoxMjBs?=
 =?utf-8?B?cklrN3Y0Sll6cWNTUVZ3NUJscnNabXZSbEhsWTJ3dzJWUW5kSVVzOVpYTWpX?=
 =?utf-8?B?MUl2WVphbTJaYm1LcHZra2d4bzlWRWlYUWlHK0ZXSGp2ekU0VVZiQnM4TVZY?=
 =?utf-8?B?cnF4RHV2TlBsaThYc1QvczFVQWw1bUZqVzBtWDAwM2tRdEE3R3ViUW9WVk5B?=
 =?utf-8?B?bDA2Zkg5cDBtdlJ3MWNBOWJnSlBrUUgySFNwZWlwSVFzcTNiM0F1K1I3WkZj?=
 =?utf-8?B?YkVSLzhtR3Uvb2t2eGVlVnNyUTM1M1MxL3MvMGVwaWdqSUF6cnhobUMrK0tX?=
 =?utf-8?B?UzRXV2I2RjU4VkQ1aGF0VDNCT2hZenFnUjcwbERqZmE5YmsxS2twTk01alcr?=
 =?utf-8?B?RkRacVR0a0wxNjhReUdXQ1poWkdUaHpoQUEzY1pLZ0N4SktRMmZXd2RNT3hY?=
 =?utf-8?B?UUdrbW9mZTRIbnNGakl2UTdWZy8vUFZ1UHdpWmNneDhBMDBBYk4yWmxLT0Qz?=
 =?utf-8?B?dXpha0lpZjJUcExDMzNiZmlZeVhkVCtWMncrOUYzYXhvekQzY3BVVTZhbWVs?=
 =?utf-8?B?NlkzUFEzU2s3YzhmN3BXQ0RJMWF6cDdJeUpGd2hTT3pyWDBvcVUrcSt0eUV4?=
 =?utf-8?B?c0U5TFl6U2pTcVdzdWVENHNhQ0ppdnVKTW4zQXJpQWpSSXc0MjNsM0ZmMVVu?=
 =?utf-8?B?SFlhd3g4SmFJNlphK3E5TFcrSHplWEpKYmhCOGtjYlZNUy94d29tTGdlWkZ2?=
 =?utf-8?B?UjVZK1d6SVljRVpveW9NU2NPRWJzbzAxSzZJWTJUZXNoNTFWVVEveUsrL0JP?=
 =?utf-8?B?R0ZxazJtK0oxc3lXT0dueHI5UEQ2b1lXU2tZV08vTXBQbnNZdythZXdRaENY?=
 =?utf-8?B?cDg2U2doSktYd3FoNWo0dm1jR1NRWWxHY043bDhubkE2dkNaRDNXVUlUWm1D?=
 =?utf-8?B?Wm9hU3hCcGhuVjN1NWRKL2Y3TVlhelg4b1ZUWHNxeC9FYXovSWIvbVR3cU0x?=
 =?utf-8?B?cTZYOUd3R29xMGxabnlUOXJ2MGlURzdLUUtRTzlkbXBnUFVjMFhFMUI2bEMx?=
 =?utf-8?B?RlNnMytRSGhXZEZGTnliaTZFQnZVMzZrSEtXcWcyUXprT0Nid1pBOENBOTlH?=
 =?utf-8?B?YzZxdHFyRlphd0JuVnFFTHhkRDltSm5Wa2lmSkV6bVFHM0NxWXFBRVhQMVVC?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1777db-ea0d-4fd4-67b9-08ddc2e1e107
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:22:35.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+xPVrXzKhlXkrTAV+jn54PFEey7TlvfaIm7xku8RCIhMmUtVH/sFcd4NtAMmceSDVoWvfx0BXkHI3U255ln8ObSjgngzzdQYX2AP7jpE8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7200
X-OriginatorOrg: intel.com

From: Christoph Paasch Via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Sun, 13 Jul 2025 16:33:07 -0700

> From: Christoph Paasch <cpaasch@openai.com>
> 
> mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> bytes from the page-pool to the skb's linear part. Those 256 bytes
> include part of the payload.
> 
> When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> (and skb->head_frag is not set), we end up aggregating packets in the

How did you end up with ->head_frag not set? IIRC mlx5 uses
napi_build_skb(), which explicitly sets ->head_frag to true.
It should be false only for kmalloced linear parts.

> frag_list.
> 
> This is of course not good when we are CPU-limited. Also causes a worse
> skb->len/truesize ratio,...
> 
> So, let's avoid copying parts of the payload to the linear part. The
> goal here is to err on the side of caution and prefer to copy too little
> instead of copying too much (because once it has been copied over, we
> trigger the above described behavior in skb_gro_receive).
> 
> So, we can do a rough estimate of the header-space by looking at
> cqe_l3/l4_hdr_type and kind of do a lower-bound estimate. This is now
> done in mlx5e_cqe_get_min_hdr_len(). We always assume that TCP timestamps
> are present, as that's the most common use-case.
> 
> That header-len is then used in mlx5e_skb_from_cqe_mpwrq_nonlinear for
> the headlen (which defines what is being copied over). We still
> allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking stack
> needs to call pskb_may_pull() later on, we don't need to reallocate
> memory.
> 
> This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
> LRO enabled):
> 
> BEFORE:
> =======
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.01    32547.82
> 
> (netserver pinned to adjacent core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52531.67
> 
> AFTER:
> ======
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52896.06
> 
> (netserver pinned to adjacent core receiving interrupts)
>  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    85094.90
> 
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 33 ++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 2bb32082bfccdc85d26987f792eb8c1047e44dd0..2de669707623882058e3e77f82d74893e5d6fefe 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1986,13 +1986,40 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
>  	} while (data_bcnt);
>  }
>  
> +static u16
> +mlx5e_cqe_get_min_hdr_len(const struct mlx5_cqe64 *cqe)
> +{
> +	u16 min_hdr_len = sizeof(struct ethhdr);
> +	u8 l3_type = get_cqe_l3_hdr_type(cqe);
> +	u8 l4_type = get_cqe_l4_hdr_type(cqe);
> +
> +	if (cqe_has_vlan(cqe))
> +		min_hdr_len += VLAN_HLEN;

Can't Q-in-Q be here?

> +
> +	if (l3_type == CQE_L3_HDR_TYPE_IPV4)
> +		min_hdr_len += sizeof(struct iphdr);
> +	else if (l3_type == CQE_L3_HDR_TYPE_IPV6)
> +		min_hdr_len += sizeof(struct ipv6hdr);

You don't account extensions and stuff here.

> +
> +	if (l4_type == CQE_L4_HDR_TYPE_UDP)
> +		min_hdr_len += sizeof(struct udphdr);
> +	else if (l4_type & (CQE_L4_HDR_TYPE_TCP_NO_ACK |
> +			    CQE_L4_HDR_TYPE_TCP_ACK_NO_DATA |
> +			    CQE_L4_HDR_TYPE_TCP_ACK_AND_DATA))
> +		/* Previous condition works because we know that
> +		 * l4_type != 0x2 (CQE_L4_HDR_TYPE_UDP)
> +		 */
> +		min_hdr_len += sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
> +
> +	return min_hdr_len;
> +}
> +
>  static struct sk_buff *
>  mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
>  				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
>  				   u32 page_idx)
>  {
>  	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
> -	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
>  	struct mlx5e_frag_page *head_page = frag_page;
>  	struct mlx5e_xdp_buff *mxbuf = &rq->mxbuf;
>  	u32 frag_offset    = head_offset;
> @@ -2004,10 +2031,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
>  	u32 linear_frame_sz;
>  	u16 linear_data_len;
>  	u16 linear_hr;
> +	u16 headlen;
>  	void *va;
>  
>  	prog = rcu_dereference(rq->xdp_prog);
>  
> +	headlen = min3(mlx5e_cqe_get_min_hdr_len(cqe), cqe_bcnt,
> +		       (u16)MLX5E_RX_MAX_HEAD);

For your usecase, have you tried setting headlen to just ETH_HLEN here?
Fast GRO should still work for this case, then VLAN/IP/L4 layers will
do a couple memcpy()s to pull their headers, but even on 32-bit MIPS
this was faster than let's say eth_get_headlen() (which involves Flow
Dissector) or open-coded header length assumptions as above.

(the above was correct for 2020 when I last time played with router
 drivers, but I hope nothing's been broken since then)

> +
>  	if (prog) {
>  		/* area for bpf_xdp_[store|load]_bytes */
>  		net_prefetchw(netmem_address(frag_page->netmem) + frag_offset);

Thanks,
Olek

