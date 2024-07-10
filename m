Return-Path: <linux-rdma+bounces-3803-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C65BD92D416
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 16:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4537D1F2382E
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 14:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E771C193455;
	Wed, 10 Jul 2024 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlzYA0V3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBE419046A;
	Wed, 10 Jul 2024 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621197; cv=fail; b=lSTQobATSE91VIc/sepJWqys4OdjrYCQuD/Th4vhMqWgMdhW2859/S49ephS20tYl5NmPaehaBVxdZbMWQ1UERm8FKTz6GLn5xtRm/rQqmc6mS8PzayaH1dG3ZwMotV1sgO02KifBYs7N40Xr4cwQ7rUknqNbV9a8GWyP8Sk38w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621197; c=relaxed/simple;
	bh=bQmGgX9aXcu5n/I2cwV2mgXj79Xx7fS1Zv/3tGmzC2c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FywZ+8nhqPt5nYFeL/Io8TeFLiR+/wYuxbhyYYJLVhRjVouqPSJigRbFLO8h2CCw3gtFXlMkv5Mpd0lrSxuE5h+kDLhHJ7yAdLHwL8cNKhUhdIHR+VwWb+eOVkjuZrxm+b3mYKgZyKcai6i6+AI5uiAh+mDM/Uu8FEda7Q6pYBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlzYA0V3; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720621195; x=1752157195;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bQmGgX9aXcu5n/I2cwV2mgXj79Xx7fS1Zv/3tGmzC2c=;
  b=BlzYA0V3pLyWmLXG3rF3UnOZz8iVk6b56VLe+r6nB7UphIUPk07csGZ0
   JEaBxlYcySUJ5jy6TK4WT+P5W2lSnF8nnnd+B4neFqmOYLBf8N4wjbxPQ
   U1uaBeqCV4gecBs3yAmUDGBgImuwgn2GlFHUj0g5n4PbLhEOHzYBIKHre
   0so7Z9OdIj5LScaSRy0qLP2T6P9YWEp9SDdnMXcnHftvPpfJZgFD8v1Tp
   E0wGUDDQrjsQtB8Z9Wa5KHT927+Y10NeczZj42Z8jW9RgL5hF9+ZhdFc5
   3pttl+bGHDMWlFkelGTqX+8xu+92hiEj9tWo0K1Csj0pwjORDiAHic5V0
   Q==;
X-CSE-ConnectionGUID: xw2tSNGjSry9gAYEyIgGiQ==
X-CSE-MsgGUID: tPu4HImxRom94ndpwx+/4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="20849541"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="20849541"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 07:19:54 -0700
X-CSE-ConnectionGUID: p9Dp5zFpQ1yYtPj9bU5GqQ==
X-CSE-MsgGUID: B/U+vuGrTiicVAKyrHLSBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48242925"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 07:19:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 07:19:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 07:19:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 07:19:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSlKai7s7C22RaqSgDmaFK05Grlg0o7EFZee9tEbOvr40a3xmmLYSPgC015d8YXa1i/uTCDvX9h0mXcUzYLUSMeQBlTqbt7fN0gNu0LjHywKDKl3OX7pvMxLZqA6IQNjT5sMA72Jy0yqP+lbocbCbwP/zLr+dAJ5bGM+4GfsrNUDm/UQIU8DA7GNVFCL15AcD1OFtT70vtnnQn9LXrU/iPN9JkkwKvNChQ5IKMZAwQ2VazHC2WefQXaKFpC6Sh/iH1OEdgUi9do0wVy4VL1EWA1rDN4CrmZLw0Oq+qdzz/m7hTaxPoHlwd8pp1KDHOQBnuj3H08pSGs8Uts7v3zc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JN3zQGrVLnwYkG5iYDgi7AghJyOrmunjosuxUn1rFu0=;
 b=JcFRA1JxyJa838Ar4jGHZauryBpmgzu6UfheaFYs9LNmIATtlaoKiYXl3b0VUoDH98NSOhr+b7bNy7yEO3XOnalBggcY/jTPeeWvNEGT9mjLp2G5POFsXFygHrv36SCTM+9Wl8w0sco6U+Ze7t068fyBRkr+YVX7Y3+NpMmzieTp2DhBKf7FWl+Wj3UoF3bCbBe/F1qzBxhu1InS8AH8Pov6yuBB3g99y2EoHtxz6/v/ZrEffWa897EQMlXHtKP5sR+Wi9RCLsKSuJ66/ME98NTnjLvwr6ENj3eKkwn2LvRHfUtJke9Z36Y+x1lVGoXEbwJmW2mGGnkMTIVhjlRMyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CY8PR11MB7875.namprd11.prod.outlook.com (2603:10b6:930:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Wed, 10 Jul
 2024 14:19:50 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 14:19:50 +0000
Message-ID: <9b9d0088-7773-41bd-b36f-de60ce4a7589@intel.com>
Date: Wed, 10 Jul 2024 16:19:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 0/2] Introduce auxiliary bus IRQs sysfs
To: Shay Drory <shayd@nvidia.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>, <linux-rdma@vger.kernel.org>, <leon@kernel.org>,
	<tariqt@nvidia.com>
References: <20240708055537.1014744-1-shayd@nvidia.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240708055537.1014744-1-shayd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CY8PR11MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 2360a244-22e9-433a-1f1a-08dca0eb5c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QytkaHQweWtYRWRONVo2UmFrRDJ3by9YSFpvVEhKUlgzRWhZTEpzc1RxcWdo?=
 =?utf-8?B?a1VINCtJblFHcXYvanlYYnY4NHRYV0k0NFJjSGkwMzI2Z3hxTHJKamZ3b3NG?=
 =?utf-8?B?ZldhamhaNW5XeU9oSWYrV0lHbkt3aHdFZ21ZaTZOazVYY2JqU1JvdTZoVk1Y?=
 =?utf-8?B?cXI0YTNlYzRxN2lqazlKNEtlTERTMExneDBIa1pyRkNRSXNvVk4weVFmRmMv?=
 =?utf-8?B?b2pwczVvUTlRbjJRRHBUT2Rtd2x1ZS9LRWpTYi9IRXNHNS8zMzh1QWs1cnlI?=
 =?utf-8?B?dmxxQVhDZ2R2Q2xsekRmb2xhYlprbm9zZ2ticnprdHNUY1h3YzdHT2E2anpT?=
 =?utf-8?B?cGJHcC8vRWVqa1A1eXVtdG5QbXA3R1BqZ3hVY3A0Yi9aSTA3UDZhR3RMc1Ay?=
 =?utf-8?B?N2k4SVVrYmpTRjYzVXBYNlowSS9ObGwrd3R4SG1pMjZFdjVGVlc3elNDY24z?=
 =?utf-8?B?UXRVaFlYdFovcW1iVkRoWGc0ekY0MHlqNzVTYTJyT3JtVm9yU250VW85b3ZC?=
 =?utf-8?B?NVF3OXdONVlwY3dob2p5ZkhvYTZEeG41QTZ6bE9zOXFIYVpMQXpJejhiOEFT?=
 =?utf-8?B?RThoM0JsVmtWQ1BIbWs5SnQyUU1JRTJ0ekVVWnN1WVpjMjYrRzdhRW50RDNT?=
 =?utf-8?B?dktVc1ZIWm1PZkx1c3k1UVFHSlIxck9uZW5Tdmhaa3YwQVdrZWJwRVdQdC9V?=
 =?utf-8?B?MlVrQUwxSHZKajhZQTc3UWNTalU1cGpuc0d2aVIrcUw5OElzYVI2SUltZUNi?=
 =?utf-8?B?ZzlGNWRjUC9pbnFmZ0xuTlNKK1RSUFdDbWJxcjFkMUJpVCtEQWdIQnJGVEVs?=
 =?utf-8?B?R0hWQ21wdGN3M2RFZjJjc3Jpa3RzN3Eya1JkSk5USGxjT1hOeURnYXVpNERs?=
 =?utf-8?B?WDRSVW4vUTNqa3oyc3hZQjBzdnBsbWJBMld2VlpwRzRMNUpnY0RwMUk5WDhN?=
 =?utf-8?B?czRsZ1lRSVFOWjFzdXUyeTRjMmNYWUtOU3JDM0NKUTBxYkkxZi9LbkRwVFBr?=
 =?utf-8?B?dHZiSEpxZG4xNUx6N1BsMkdnd1ozM2VMZGRjVGJlMHVINnoyVXdEY3VXOTBr?=
 =?utf-8?B?K1U3N0RGdHByaWNzS2lRcU9nSHM3andENE9uQUNudW1xeXJWakFKSnNlR1BO?=
 =?utf-8?B?Y09RRWtyckp0QlFqaWdCWnYwTHd1allQNlJicjhFelR5cFlidDNBc3RJZm54?=
 =?utf-8?B?djNjTVNvNDU2dFdkeWkzRUQ4NVkzQU1LMFFCa1NkbTRDT2MzcmdIbi9SM1pY?=
 =?utf-8?B?RGdRdXFnN3p3VnRqQlJnZmNyaW1mMjEyc1QyZUF0SEtsSldULys5dmJVMUp6?=
 =?utf-8?B?a084Vy8rV000QXlhcldFaXlwbUJRU0RUM0t2d0tta09yWU1XUU5UUHRTSHJs?=
 =?utf-8?B?QVBjTlRUaVFpeHArVklQSUNNREJncDBXb0xVUlRrTEZOM1RjMmxZV3prNEsr?=
 =?utf-8?B?R3hPc0U2MzVpWi84bHJIeGFFZWFnNFpHL2M0ai9ia1dERThDY1YrdHJTK3Ba?=
 =?utf-8?B?K0w1LzJuUzlNY1hPamtpRE8yYm15QWp6eS9CU2M1TkVqbUplTU42azd5RGM0?=
 =?utf-8?B?SEIwcG13RUtscFI4RjVOUk82T2ZaM2FHanF1RFJhREtaM2VWU2ovOUZDUzAx?=
 =?utf-8?B?czZ0MDZmY0xUV0ZmUkJsSUtQZGY3eE90MDZkVGtRVnNvNXNvK3ZPZUxpQ0Nw?=
 =?utf-8?B?SXVnTEgvQWxGWlNDeFNIdVJDR3JMQlViby9iejYvamJYRmJ6WXFjSFA0czB0?=
 =?utf-8?B?WEh2dnJ2akNxK0I0ZmVlZmJoakcxME41b0R2dCt2U3loK096M1h5Qis4VUo1?=
 =?utf-8?B?V044Znh1djkzV2l0dTQ4UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHJnc3lCbWxrclRzUFBybk5lb2E4QUVlVFhuVGM1YzhLK2JWKzNJVGRuZ1Zp?=
 =?utf-8?B?QkxraVJFUGh2cUdCMUc2NFg4NG5sNG9Cd1R1SGlvalQ4d2dGS1QwQytRT2t0?=
 =?utf-8?B?S0lFeVJCK2FRS2FhbGFsU29oY2hDdTZDcTdmNXF4MWZlci84M3k5eGFScHBV?=
 =?utf-8?B?dmhMKzNUdXRQRms3eG9TRGRoZzdkR0IrTko1Q0ZkTkhUdWFpc3JCeXltaW9R?=
 =?utf-8?B?aG1QS0RHUWlCVW9yc281UjBaNFB0TTF0SldRZURlaWV0YkdaSGtTRkhrdWxu?=
 =?utf-8?B?MzVacXZybFJ4OFNvMytUYksvV3Zicm1GQXQxQ0pkb1dBZ2tMUFU4T1FZcThG?=
 =?utf-8?B?bDF5azRlS0phMFBhbU4vZ1IwbHBPRTI0RExqN0lMZW9GcndMTkxOT2dMbkl0?=
 =?utf-8?B?OXBVT2wwdTE2dE5uSXF6RHFob0FISEowclhxQWpiTUhQTEZiNlpSaitZUzhM?=
 =?utf-8?B?WTcrQjVjdm1PcmEyUmwwZlhJZmdwWThXcGNBSjUzWU85TkRkcno2a01GSE5G?=
 =?utf-8?B?UmpNQzBJVjJjbzdaRnpTdmowRGRhTlRrSk10M2NyZkRiV0I1anB3UUxJUk9Z?=
 =?utf-8?B?YzlBdEhKMEtYYWgrSkxtaHh0dUpZMjJIU05meG5nYlFCZjIxSTlSRWlWWmh3?=
 =?utf-8?B?blNTeU45cW1WakMzeEJxMUJVZEJOdEZMckNBTm55NDdpV0RzcGlmUmg4V1Vs?=
 =?utf-8?B?Wjh5YXdGYXlpSGcvR1FPYVpUVE9iMS9DeFBGMFJLYkw0WERETDNLVGZmVG9p?=
 =?utf-8?B?VHN1djVJalJlMTZXYitKZnIvUXZOaXRmWlo5b0NYMlNUMnduNFFCTHJlK084?=
 =?utf-8?B?ZC9zQmxydHpXcm5rM1VLWTBBOGZGMHJqbXh3ejRXWk1XUXZ4enphekhDNnFm?=
 =?utf-8?B?UjI0ZEcvc0hYN0JLZE44UGlIaXBKTitQT0lYRlp2Nm1adW1sZkZIRTFtTE1P?=
 =?utf-8?B?R2tHWFJWZENOQkJDczlYWFRBM09PMjhXREpRaXdxZXB2WmRuWFczQ3JCSndI?=
 =?utf-8?B?K3dLaXhIaVN2QU1UK2NyQUw4cm9hcTgvb1RoTzB6ZmFZcUlMamgyY241MkZl?=
 =?utf-8?B?cUdQaFJnZHdxempQdlVYZ0x2MmcrWktLWVhJNE4rVVJucFZZUHc5NTBFR05h?=
 =?utf-8?B?YklpcTAvTW5FWWFKcExoeVZTQkVvemxBSFJOeElCbk9PN3MzamJNQXZsSUZn?=
 =?utf-8?B?RnZ1UU0yK0x6Si9UYTRXMXZkL1NtRkZDVVd1ekx0TUxlZlRsSXlpc3d2N1ox?=
 =?utf-8?B?SHpBcWNPeExkbnhkdnZ3WWpHQ2ZzZlZYc2xKczYwa3g1Z2w1NjJZaEhIVkkv?=
 =?utf-8?B?SnkwYnZBZEVtR3JzbkZDU1lDWWJQNGxoTXBXb0ZBM1EvS1Fub2twRU9KY0xw?=
 =?utf-8?B?d1JBUC84aG5CazJVMXFGTVFTSnMrYzZHOUtLaXRhQm9UWENiNDdYNzJRay9h?=
 =?utf-8?B?cDZBc1Mra0pUdG1meWZ1YnVlS2JLampYNU9Wc0xZQUVJQWxlK3ZiYzZrRGVl?=
 =?utf-8?B?VSt4bU1xK3grNzJ1azhYZmd5TEhPbjY3RWo1L3BmNVg0NDVlT2daS2lvN2hh?=
 =?utf-8?B?c29Cb1V3amhDKzB3SWZLRmxENXYvc0RrNy8yVGNDZmNNUE9IWVpGeUZqY3p6?=
 =?utf-8?B?THdoZGxVZU1GUTNjdzJ1emMvNjhPVTJRRjV2enV0VVpsTzh1a2pUS3RZcktS?=
 =?utf-8?B?azZJUXFQZ1c2aHI5M1V2UUx2TUlicjkzY2ZQNWR1UnROeGpSQy9SSVJiam5H?=
 =?utf-8?B?R3phY3FGZ2x6MHB3SFEzd0JFNWIxUDR4UE84QkpHYlBUTTBvdW5mSHpkalVz?=
 =?utf-8?B?TnB3ZklvZ3dUdWMyUXJtRmJHbyt1aEFUd0luY3dwUWs5c0RRcHlwcGNpWGxx?=
 =?utf-8?B?M1V4TGgzUTVaTjByRXNTenE4WUN5M2VpM3UrbUlUbEV0RFRCM09UNTNsRHBr?=
 =?utf-8?B?OGRkWU5pWGFwaHh4QzBGaDBHSkpDSUJVcWRmMmZmUTBCOWlTd3JGUTBwMnRv?=
 =?utf-8?B?RHM1Zy8wVEVaVmNkb05EQVBZOVM0Zi9WZUV5bURWMCtMajhSVisvMHR0Mnh2?=
 =?utf-8?B?c2VuVnpUZHpydTM5TVV1NHBVUEpTMnNOQTR5NURZNlZZMm9yOFhSNWsraEZX?=
 =?utf-8?B?V0FhYThvOUViMlZ3dVJrdHFlMXdqaTUyNnpGbGxnNGhubWJkb2h4SjRKUUt1?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2360a244-22e9-433a-1f1a-08dca0eb5c4b
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 14:19:50.7936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwOWi0CQ3j0tHTMH5bcP0xe4mSQG5opKJUO9Ph64pR9oT0yJrgE+b2wtdrKGCijb1kQtew4KJdsTDpzZQ8dZZ7SpUuj8uBsKiDTfAbjKwAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7875
X-OriginatorOrg: intel.com

On 7/8/24 07:55, Shay Drory wrote:
> Today, PCI PFs and VFs, which are anchored on the PCI bus, display their
> IRQ information in the <pci_device>/msi_irqs/<irq_num> sysfs files.  PCI
> subfunctions (SFs) are similar to PFs and VFs and these SFs are anchored
> on the auxiliary bus. However, these PCI SFs lack such IRQ information
> on the auxiliary bus, leaving users without visibility into which IRQs
> are used by the SFs. This absence makes it impossible to debug
> situations and to understand the source of interrupts/SFs for
> performance tuning and debug.
> 
> Additionally, the SFs are multifunctional devices supporting RDMA,
> network devices, clocks, and more, similar to their peer PCI PFs and
> VFs. Therefore, it is desirable to have SFs' IRQ information available
> at the bus/device level.
> 
> To overcome the above limitations, this short series extends the
> auxiliary bus to display IRQ information in sysfs, similar to that of
> PFs and VFs.
> 
> It adds an 'irqs' directory under the auxiliary device and includes an
> <irq_num> sysfs file within it.
> 
> For example:
> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
> 50  51  52  53  54  55  56  57  58
> 
> Patch summary:
> ==============
> patch-1 adds auxiliary bus to support irqs used by auxiliary device
> patch-2 mlx5 driver using exposing irqs for PCI SF devices via auxiliary
>          bus
> 
> ---
> v9-v10:
> - remove Przemek RB

no need to drop my RB after you had one and applied my additional
suggestion ;), for the record, the diff is still fine, for the series:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

and congrats for the patience!

> - add name field to auxiliary_irq_info (Greg and Przemek)
> - handle bogus IRQ in auxiliary_device_sysfs_irq_remove (Greg)
> v8-v9:
> - add Przemek RB
> - use guard() in auxiliary_irq_dir_prepare (Paolo)
> v7-v8:
> - use cleanup.h for info and name fields (Greg)
> - correct error flow in auxiliary_irq_dir_prepare (Przemek)
> - add documentation for new fields of auxiliary_device (Simon)
> v6->v7:
> - dynamically creating irqs directory when first irq file created, patch #1 (Greg).
> - removed irqs flag and simplified the dev_add() API, patch #1 (Greg).
> - move sysfs related new code to a new auxiliary_sysfs.c file, patch #1 (Greg).
> v5->v6:
> - fix error flow in patch #2 (Przemek and Parav).
> - remove concept of shared and exclusive and hence global xarray in patch #1 (Greg).
> v4->v5:
> - addressed comments from Greg in patch #1.
> v3->4:
> - addressed comments from Przemek in patch #1.
> v2->v3:
> - addressed comments from Parav and Przemek in patch #1.
> - fixed a bug in patch #2.
> v1->v2:
> - addressed comments from Greg, Simon H and kernel test boot in patch #1.
> 
> Shay Drory (2):
>    driver core: auxiliary bus: show auxiliary device IRQs
>    net/mlx5: Expose SFs IRQs
> 
>   Documentation/ABI/testing/sysfs-bus-auxiliary |   9 ++
>   drivers/base/Makefile                         |   1 +
>   drivers/base/auxiliary.c                      |   1 +
>   drivers/base/auxiliary_sysfs.c                | 113 ++++++++++++++++++
>   drivers/net/ethernet/mellanox/mlx5/core/eq.c  |   6 +-
>   .../mellanox/mlx5/core/irq_affinity.c         |  18 ++-
>   .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   6 +
>   .../ethernet/mellanox/mlx5/core/mlx5_irq.h    |  12 +-
>   .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  12 +-
>   include/linux/auxiliary_bus.h                 |  22 ++++
>   10 files changed, 189 insertions(+), 11 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
>   create mode 100644 drivers/base/auxiliary_sysfs.c
> 


