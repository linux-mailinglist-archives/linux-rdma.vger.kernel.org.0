Return-Path: <linux-rdma+bounces-12840-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6291B2DFD5
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 16:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F156A1C46AA0
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D163431CA51;
	Wed, 20 Aug 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ij2u+iZq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307202DE713;
	Wed, 20 Aug 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701159; cv=fail; b=fAklNnwa9c0Jor9eXHzti6hpC429Ghswjz1l8vt/sxGnMW0sI0qe3nJSVurMKPr2wyovinPrcXiN45mxpHA4xQ6mSWPWWsdEahj6pP0jJddBe1tMQ9Bar+px63/seqrUk8HJSCjY8X1yq1Llef6ELkIIhTaIkVaSIgoRdsKQEOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701159; c=relaxed/simple;
	bh=Bf17BIKwVyeGitBAqO7lH1G2TZWVqMITGbBh8npf9Ds=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RxWJOVthANgNUbKhw00UjUJniq/yGShgxVgx6owltRFt3GjiWsCid5v8EMwZQjGy9jplv3gETArUq6CLYBNXFjq3+dtDAFoxAUCG2sedZK/s7jf0SoV1u6TFiDOU//PMl9IJPOEvKYIqpGC9O5ZTeIhA5L/WlMG/fbLIj94DErA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ij2u+iZq; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755701158; x=1787237158;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bf17BIKwVyeGitBAqO7lH1G2TZWVqMITGbBh8npf9Ds=;
  b=Ij2u+iZqMZ+qycUS5ZivZGppfWTTjMHVwg6Vc3FM/Lod/Xxk93JbGrhX
   TR2GIpf2hRAV139AHwZTiGTIMScC7YQTXE8lA4etO06+FJCFrv0GDLm2b
   SzpQwQjR48nN86hDSPvqwo8ZvaX49VirPk4sau489jLZU7wDeaMrJLBC6
   QOvV2xqFjPC9R+mEZAHIlu6+sbu6o37bv8esR7D+4sQjKgrVqqR4ihftz
   EWvk4PBCm/nUBJQGLDhw+VcBO0lIeDYQSe2F4nevWmYKYSEt76xMcIchV
   WesPN6pIxbCr1k/zO9z2VdrPxwqWYcwP0TM8xKOwJMyKP8mnPfWXQBN2V
   A==;
X-CSE-ConnectionGUID: 3ApaNdTISsCjX9yaaJUdhQ==
X-CSE-MsgGUID: ilp6a7TPTe688ZI6/T5K6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69067007"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="69067007"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:45:58 -0700
X-CSE-ConnectionGUID: jILVzL7MSAqU//gS/ZQVWQ==
X-CSE-MsgGUID: Lgys4ylbT/Gp1YulzgDVhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="199015643"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 07:45:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 07:45:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 07:45:56 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.80) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 07:45:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeaAe7NsKgMEGDdQM7zFjDLxfhGL/okGW2OE+USw0U6X1Fj8SXAjO0mT2dU6Vcb/snCdFZp3vdE9o01Pj+nnslx8pxlPmzMEQvPB6/ACmFP4gCQ7bcagmHCX4CbQrG8oTfOwAARLDSuc1lWyo7+Zi0Lx3iMmCCvTaA1rZO4ZZ06EvX2a31pgWsX/i2VtjoK0vDFNpk6HU45kslh+ooUb7iW+v9RsnEZWzgf5W7nep+NFhDsFwrF4er23y9NLQkMWyXf2n6xxLEKmPuPtn8Lc5Abtez65TINBI8TY3cq3DcOQFzhJTdgoqXAK59iPAJ+Lws8cxnOVMBIIqxiLfXt3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kaa+devjf3XL8s8ymZ9trFWGNEPA+EAF4NlMxjmFHQ4=;
 b=w82N4hMLwf5CByWmFkZ8/fY4PC2Gaurr9lGfwyq5Hb5rFdUlEy+gfIDM4qiaJ/hkrAiYw45bohJXDv517XzcwkZK73JU5Jg5GnCw+egxBxAxD7zdvS7zJZtJehxVbEhzzFzpHmGRVUVFYLbVJIxbIb4IX56pPnbMNlWumJ91ipWQQyG0enqwqDsDHGXuB2R8jfwzaRceT2dCBaOpVG9/yKo0IgLw5LC8fLxpVm82RpBtHYcFXCHYA9MJ/vcFTTlGXC15pD93F7xN2nbQGUrhHoSgWGUqQKMe7673qwQmLPRMxOmW2PXG9HC5pH87TAFmMOq0kDiqvVj6Wqi5LUYFYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA2PR11MB4969.namprd11.prod.outlook.com (2603:10b6:806:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 14:45:49 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 14:45:49 +0000
Message-ID: <e6209c4b-c524-41dd-bf67-4dcd67e621fb@intel.com>
Date: Wed, 20 Aug 2025 16:45:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net 4/8] net/mlx5: Destroy vport QoS element when no
 configuration remains
To: Mark Bloch <mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mohamad Haj Yahia <mohamad@mellanox.com>, Saeed Mahameed
	<saeedm@mellanox.com>
References: <20250820133209.389065-1-mbloch@nvidia.com>
 <20250820133209.389065-5-mbloch@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250820133209.389065-5-mbloch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0065.eurprd06.prod.outlook.com
 (2603:10a6:10:120::39) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA2PR11MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: f84f6596-2a1c-4caa-9025-08dddff840ca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2VvMmNlWi92YUV6K04xcXRnbXY3bjdEQWZoM290bUtNVXdYbnFlbk1HeTYz?=
 =?utf-8?B?NmRHYlhjMXJnaVVla1FpNDRnK1NWUTZidWZxWG13ZXUwK0ZQb3BGUmFqdkhi?=
 =?utf-8?B?YVljMGVKVDB0cVhrY01sMzdlVERHNHA3aDBvS1lNS3NzdVcySGFNWUVVVVg3?=
 =?utf-8?B?R28zYStUYVlJUGpTOTVKaHphZVc5aVc0WVZWQ1BTdnNtVkdRL0h1c05nUU1U?=
 =?utf-8?B?Zlk0ZHVMWU12cklMeURZbDcwaGdRRmQzVllaeTlDRkZPcXE5WUZSNUN4aVVt?=
 =?utf-8?B?OUFScytQSTdScnkyc0E5eklKZTRPZWdkVDNXUFVnYmRTcWpZOWQ0a0Y0a1V3?=
 =?utf-8?B?c2k2Q2pQM0llL0xMcGdGazArazU2cGZ3R0MveEN2LzZOclVmeGJGcXZ2ZnFu?=
 =?utf-8?B?S0FMYXlSR1U5OUhIMEpnZXFUMyszSksxeTQ3Y01MYXM0MjlldmpvcDlCZGRH?=
 =?utf-8?B?QndQN0VTZ3F3ZVBEV3dMdDlMTWhNQ2cvQUNxeW1ndnlrUFBwNTFveisvS0lv?=
 =?utf-8?B?dzVHMHlCSFlIbjZFVWpDQ21tRy83ZjFZeEpwVWxwVlNRTmhnOWMxTVloTnVN?=
 =?utf-8?B?cEtad1o5eHZnRWhFdTBhWkNTYm9YNmE3d3lxeHFIN1daWFpZUC9TekU4WkRx?=
 =?utf-8?B?amVEOWJrSWg2b1pkNENoaE9GNG5rZUhZQkp3cVFYanJXcEtzanBnSnRtWndt?=
 =?utf-8?B?UUxhU1lmNUJaYWoyTEJmdHdJUXZjV1F0aFdlc1dsMFowRXVVOUxqL3VnZ24r?=
 =?utf-8?B?endzdlQ1YjUwTzJ5YXhZN0d5L3VLZHhNMHRrQkZPM0Z3YVdPcitXSWhjOEM0?=
 =?utf-8?B?MUJDOXhFQ25ZWHlOM0JaN0JPV0NDTkliUmNhcnM2ZXdVWVpZRjdsTUlNU3NR?=
 =?utf-8?B?R3J1S0hvTzVZUzFUYktjSTV5U20zbjVVNXBjZnFLZXhQa254RThMSVBmbjB2?=
 =?utf-8?B?S0lzR2hYUkpMY0gzWkFqalAwTHhzV0pMMXRUVGkxU2ZGbWhQRnBld3ZRR1Zi?=
 =?utf-8?B?ZENrUERPNmRlOThyQi9xalFxMTZVTnk5K0hCajhpSFpTaGFzcC9aNVlKMndw?=
 =?utf-8?B?RzVFZE4wQjBRN0YxRGFuU1c3dkVSVTNZc0pYWFVmOVN4dys1RUVGRkxlWWxF?=
 =?utf-8?B?MndtQVk0OUdKZktCK2QxR1JQbFY0MTltVG4rWWU2SnZoZGVZbVRURG5uYkJO?=
 =?utf-8?B?UVo4MG40ZjJlMTZibGlHaDhyQXJ2VTcrYmxxNDd5TlgrWGVqaWVFWG40Q1Fn?=
 =?utf-8?B?ejlpb3VKZmkwUGFycXQzQ0E4MGdoWUlXb2ozWFdJRWRlbjliMmMxMFI0YzhT?=
 =?utf-8?B?Z3dRbGxqekJsblc0eWxmMGpNalhvMDB4Y29EVzZvbmN3NWdHQXlWY2k1UzUr?=
 =?utf-8?B?cUtkYytjaUY3elM0ZnFnSjZDR0lzRTZMOHEwVk51a2ExRzdLVDhtRVNCVzg0?=
 =?utf-8?B?NzhINThBSk93MFBGeE9DM2l1S1JHejRwZ25UdlEyYzh2bVJFOW1ha0FWY2Ra?=
 =?utf-8?B?V004K21mTDcxNVpUcWxCUU1YcHRZS0pNOFhvUWdscjgwV3B4R2dOUll6UitV?=
 =?utf-8?B?VDFHWmNYbWd1NDFTaWhodlhIQlBmL2x1bi9OWkRhaHRnaExMN083YUhpazEy?=
 =?utf-8?B?ZHBvNEJVWi9oeFFsSVJpVjJsbkR3b2tCcDZ4c0hvYklnK1htUC83U2U2M3ly?=
 =?utf-8?B?b09FampEQ1liRHBWZ2tuZG91a2ttalRmRG5kZVdRWlZWWFh0TkJEUWRtN0c1?=
 =?utf-8?B?OGRGSnh1NStMZ3QxMkh4bndnTGhnWURzcnJaUStSQUI1S1NXQXhkYjZ5QUFh?=
 =?utf-8?B?eFJQSDJvWXd6alNJSTlIUy9vZEhKYTcwbHpTOEZnWWE3RVk4WXBhTFQ3dWNQ?=
 =?utf-8?B?MTlmZnMyUFZySzl4ME41K2hTeXhQbnZMakpnaG9mSUVneWV1ZW9JQWVaZnk1?=
 =?utf-8?Q?dn2zoHhzwKg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enpXY1E0ditGd0dNYUVCc2xFbmlVTmJVcDQ1NkRESEI1allGOVdYRFZjWHRq?=
 =?utf-8?B?MVVPUXVtbnZIVmt2MkY2SE92QTJxNFU5OUQ3N3NlcTdYRCtuSEVoQXdaZHFm?=
 =?utf-8?B?RjVDZk5vZm9SREdlRE9Pcy8vbk1ocEY1Q3ZRM1A0eXRGQzFxM3ZORW9oeHF4?=
 =?utf-8?B?ZFdac1lWTkhDUFhnaVM2N1kzaGRhZ2JJN2lmRVlIc2M1aldkWlplbFBjRFZv?=
 =?utf-8?B?YmQ5VzVJdmJIem03THVGMm9mYnIwUzF2OXFLNzd4dVV3NFpzYU10emF4TXNT?=
 =?utf-8?B?NGxHSUM4dmYwekVuUXppUUVwT0xsZFRBaldCYTVNalRYd3ZNemk5N3ErZ0ZV?=
 =?utf-8?B?blRyR3ZidWw5NDR5elNXWDNDYXkwaWdQZU82TnZqUTNVRXlQcGNWeFR0RU1o?=
 =?utf-8?B?Yy9qZjFtY0xuQWxDMC9tUkxzZEVPRERlYUxpSlpyM1hOaWh3WVBrelBqS3Nm?=
 =?utf-8?B?eE5wOHBoUUlRekN1N05ZVGlYRzRxdDFaY2pwWlk3WTkrZVlXQVhjRVdGYXdZ?=
 =?utf-8?B?UHlTbWhwNStoaU05Unl1QWJEcktibGRtUm81cUR6d2wzR1ZWQkpraGdyeTBk?=
 =?utf-8?B?VHE0OXBtV1Vsd1d0NXlpN3F4LzVKei9wcHhjeTZnaXg0U3RYMFV4RlVTT09M?=
 =?utf-8?B?aGVJWXhIRzY0OHF2NHZaMTc2ekhFSTdIVC9ZVzBxUXpmYzl0MW96cG9Ka1Q3?=
 =?utf-8?B?SmdpRURNaXltaHE4RXVGd2pMMjNRb0JBRTBOWjcxdXl0cis3dDl1N1JBV242?=
 =?utf-8?B?QXFqWEsrdHpBbDFoWVoxTUowSlFZZzBqWUtkWlBaSmRSeG9kdjJFRW5GZjlI?=
 =?utf-8?B?eWoyb0xGS2d3ZGpUYmtPVXk1QjN4ZXFHK1NrWXhhb3dPeHZzazBPR2x1aGh6?=
 =?utf-8?B?VUFDUUloWlBhTXZVc3FjbVpZcmNReDRJVGgyY0JPL0JQanNhanFQSDNicGh5?=
 =?utf-8?B?Snk5L3pKMy9RclBNNUVMVXZHMnVNc3M2U2FXdHliYytpTTNUTTFDYmhQV1Mw?=
 =?utf-8?B?K1FOK1c1Zi9kWUdqa0VNbXZ6R2diMWEzaXFnb3V1TXhxdGR5dGpzaDFmdHV5?=
 =?utf-8?B?UTZPbnFxeHE4WWpnMHpmRVN3TVFSNVVpYnl5ZFVtL2d6YWtiYm40dVErRlN4?=
 =?utf-8?B?YjVXMXRZcnRWZndwYWxmQ1RZWEtkQnlZMnk2WlJleEhqemhPbjJHa0tDSjNh?=
 =?utf-8?B?dXVWSXBsbXh3TDEvenRSd095ejVoUHo5cDlRWEgwU2k1SmJIeGpTOTJzNElF?=
 =?utf-8?B?b0ovVEQ3T2JHZDdNNGNaSUMxMUpxSEM3L3VLcHl5eHRoZmtYR2E5b1BxOVhn?=
 =?utf-8?B?SlB3RFRPSXJ3elNkUFAwMm1hM3hJNHJQSFg5ZnZqb3E1VkRCOFpjSnBpSHh5?=
 =?utf-8?B?SHpLK1dzUDMxUHNyT1Q5VGc3aVFxVTk5VjFscDRWRFY3cm1aRTYwUU14clZ1?=
 =?utf-8?B?ZE1NVElyN1ZTMFdDYlVsa1FObDZ3NEE5dmtjbjFSeG1ENXlnbGk3MncyMDhm?=
 =?utf-8?B?VUtQaytBWjJVb3pMZVBrS1FnMTJwS01ubVRIakxjU1lIVWw1T0FOSmRpc2VQ?=
 =?utf-8?B?OEd5WjAvZXpoZENCbFlPbEtKSVN1dFo0R21nSFpGT2diT0diOVBEdUJibkZ2?=
 =?utf-8?B?dE5PQ2VFbEJXSHdHY3RyQTdpSEUxRlRwazgzUUVYWXAwVXdUbzZVZVEyUzNx?=
 =?utf-8?B?akUvdFhWRVhjd252VUxvb3EvSWNRZkEraEh6RHVlcEdFQjJHZ0d5L1lLK3ZI?=
 =?utf-8?B?U0RiVGxuKyt2R3B4YnVINFJNenVCVi8wK3prNGxESFB5NzMrNFovYk9nSnNF?=
 =?utf-8?B?RXFsaUpCanRlNnFoOEl0R0xQeU9NbWFpRU80VFJscVc2dzh3YldudklkenBP?=
 =?utf-8?B?YWVKeUtoc0lCaStaUUU3NlJJbktCTDU0T1QxU2N5N2lmb3JTN01laWNnRTFr?=
 =?utf-8?B?dDdlK0FSVUY1TWZHUlBsZG5Bbm83VGdEUjJ5b2MxTGdjNW8zOHJEaGk1SVRO?=
 =?utf-8?B?MjJSUER6Nm1PbzRPYkp5SHI3WVg5V2cxUFFWdzZidDY1L2FMYkR3OHJhaFVW?=
 =?utf-8?B?NUNYT0lqYzdsbUdEb0JhUjcvK2diWmFidGFXZkZUOWUrT0d1eVVrSk9PT1F4?=
 =?utf-8?B?bVl0dHJFMWFnWUR2KzhGb0JJbXpEazZhL0tEbkpYZmgwYTEwMi9ib3FFeUtB?=
 =?utf-8?Q?beXgDX2wBAM0D/SkCxmBC68=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f84f6596-2a1c-4caa-9025-08dddff840ca
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:45:49.0999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkNPG8/TdNrAmzcp7wFWqcwVjl8MgVy3dQTQDPz65DpGHXx+be9J2fUUrxn9+XoGf5uz+ofKZu0cgbgy4DTAGa57c+7SzFUZUXp5olQmS3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4969
X-OriginatorOrg: intel.com

On 8/20/25 15:32, Mark Bloch wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> If a VF has been configured and the user later clears all QoS settings,
> the vport element remains in the firmware QoS tree. This leads to
> inconsistent behavior compared to VFs that were never configured, since
> the FW assumes that unconfigured VFs are outside the QoS hierarchy.
> As a result, the bandwidth share across VFs may differ, even though
> none of them appear to have any configuration.
> 
> Align the driver behavior with the FW expectation by destroying the
> vport QoS element when all configurations are removed.
> 
> Fixes: c9497c98901c ("net/mlx5: Add support for setting VF min rate")
> Fixes: cf7e73770d1b ("net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 57 ++++++++++++++++---
>   1 file changed, 49 insertions(+), 8 deletions(-)
this is much better, thank you!
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

