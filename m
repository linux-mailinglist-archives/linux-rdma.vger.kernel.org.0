Return-Path: <linux-rdma+bounces-2403-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202178C262A
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 16:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 727CDB2141C
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9632712C54D;
	Fri, 10 May 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYFzQo3u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72E127B73;
	Fri, 10 May 2024 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349681; cv=fail; b=ehmcrWNCA+Ly2v6bl9FsuyEm/RwH/M3/dpRPgpHfyEbPj6saOSDwYoUKz9EyAvUfTBXJvB74ybERUOetHYIyRHC2/UfHA3lx/E9JwL5NQdZ8s+xAZXbmyknUfA1p2klZQbEPssI/46heGePIeeF5eKrUpNssWcIyeakr2+khYt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349681; c=relaxed/simple;
	bh=H4tvMlCHATVBnoz7dkNcHsPDwAW8h7v7ifRxPgrZA2I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AYnT3mudjpSE6tX8N9SB60p6U6bMIE+QvTDo7tUUIwJnSJrRcd4o/t2SvC18qM1005ILyr2KqRk+83rzIgwxEEghHTllDruzSVGeg/5lVfVn8xT8gueMmn4t8Evon7VpqddDZY76EHYbxS4rTcaVHU5/kcqu3vM6USQ3hqiIX/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYFzQo3u; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715349680; x=1746885680;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H4tvMlCHATVBnoz7dkNcHsPDwAW8h7v7ifRxPgrZA2I=;
  b=iYFzQo3uU02ueF/xBHRLAK3qPfNNiCv+DpQCc26PM8oIyVu+htfQ3AVd
   InhczNsYiZCQX4wi3gQZMuCe9oTFCtFT4zbLNA8ZJW2jVnysOtX1PLIGM
   hDHXLJpKbp+jzTiHRSxG46d1eNN9toPluPPKOxHCBXG7hSVfI37exfK2J
   Qk/2TaX1J2CE3e3XJ3gi01zvkQWuYqsQFlnQoz0sQJ8rGLpfFMm1VDREp
   SV/f4SVg7acQNXJ6yxhpZNcHr2kaN4G6l8k3D20vG8RlXwxFIO822t8jY
   Wlcucb9Cwq0R600RujIhh9g40ybVVPNkRDUAg0FXaKA3e/fW1+bYablRQ
   A==;
X-CSE-ConnectionGUID: CHD6nxHgRuKr74JA7Z6oOQ==
X-CSE-MsgGUID: RW4W3jxYR4yqvJUSz5vxgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="22738377"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="22738377"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:01:18 -0700
X-CSE-ConnectionGUID: DmP+EDzVRuGKHpZhrkC8Tw==
X-CSE-MsgGUID: 3e/n8PPWQX+zTa3UaS1fJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29634560"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 07:01:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 07:01:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 07:01:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 07:01:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 07:01:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beb/IsSp07Sw42anFqNN/mzOV7+Q//uhMeF3o2xgs0deLTTxsbD44tORJr/hHQxhZG3taF8Ac5VcLBCgPjR60/3HZUKx45CN6k1jfx8cxHlsz425gcv9mEIT4uWg4d95Pzwf2rLeDi7SloVwgHXLAl8kTSudXVDtNVC0TvQsQ7IS/ajjulDr40Kt4p0FmVwod4yZo54QAsZbhGbA7GyWF9aglZVwDercYmL/Pst93412PXnfTwqHo+jlwtcExfpneBL9wGyQR2iU9P5a0QelHgMRtnJ41t8d0sgqblrRoGbDTaKqLC5ISAovChhnj3EG2Yh2w9BkPVxJJoJXyo5UpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO0K828B8Wb/qkbG07OdRdr4gBEb8bkXBvzIfZyJNDE=;
 b=C/2ZJztQjvk+1cAyFuzUq1C5A9fI2VjHhC5MtyLXfiZVcyP5/UUoyFyTv4nfW5d6vnFmKJKaY2MjRg8MkCOXs6fok19ihLBKGA+bD8rvssQ3IEItN395h1k22huMvLznBO9qf9TpPSc2HvOQaIBvRfcqutk40KyaYhycFP2j2nFQOetr3D/hXy1HMYGbJmBDSIhaRN5h+tJ7Dry2Q+N/nmgdInp7h/nTrZdykxLhzQV0z4FbyRzj0ZnpnKq3vgx9JFqzg22k+RWP4oMKLrb688Z3UVKLb51m6AXZNMdQvm3ngAnfoolkQ68bYjJKzHlgY5vKSQa/foEWXwV+H0IaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB6142.namprd11.prod.outlook.com (2603:10b6:8:b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 14:01:07 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb%3]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 14:01:07 +0000
Message-ID: <ae6e151e-0c34-4ff8-a9f7-40e4cbdb9dee@intel.com>
Date: Fri, 10 May 2024 16:01:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, Shay Drory <shayd@nvidia.com>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <david.m.ertman@intel.com>,
	<rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240509091411.627775-1-shayd@nvidia.com>
 <20240509091411.627775-2-shayd@nvidia.com>
 <2024051056-encrypt-divided-30d2@gregkh>
 <22533dbb-3be9-4ff2-9b59-b3d6a650f7b3@intel.com>
 <2024051038-compare-canon-4161@gregkh>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <2024051038-compare-canon-4161@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb3ac3b-c5a7-4509-f88c-08dc70f9a35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3lmKzRYWS80QjQyTGFrbnZkSjB3UFRvN2hwTDluUTBBUFRQYjZVZ0JJektz?=
 =?utf-8?B?aytGL3pRbzRxdHN4MFBVM2pPMk45TUdhRFdZbEpLT3dZRXhFQmhwWG9pSWZQ?=
 =?utf-8?B?a1BRMC9WdzduSm5SbjZ4SG1pNFlUZktPRzVCSU1FMXJucGlUWnI4WWZXNDRD?=
 =?utf-8?B?SEhYdlFCOVFhOGFtNVpXU3lUaEo2ZFFZQW50Tm5WTC9RMzZ4MVFDMEpDVFov?=
 =?utf-8?B?ZW1nWk9wYW5ETy9aaGF1cDFxeU53cDFNNkZscFl3WS9GL1A0TEdCblRWbWV6?=
 =?utf-8?B?ZS9TekFpVE9kUWdRM0l5T2FQelhwaVlQK2xMWTFMN0E0Kzd0RGJ5L0d1azNK?=
 =?utf-8?B?b3lVUktCdGZDWk1wN2l5ZGp4MklqWlB5a3lLQ1pSb2J1NUloR2JpbkxDZFNv?=
 =?utf-8?B?NC9xc0ZwUzErcUszaVdRUm43dFhlMGNUelU3S1hxVkdFbjJ2VXNkSm9zTnBF?=
 =?utf-8?B?Qm9PU1RSbU42MkxtTjV2NXRGYno4MytvT0cxZmQ0MFgxNlRNQzJ2REYvNGll?=
 =?utf-8?B?NWRXLzA1ZEpXMHJZWVFBNm1XYThGZ2xFVVVMd2p3b3VIekVKWTdlQ3daTEtj?=
 =?utf-8?B?ZVQ5NFdIeUxrT3RQSVliMmNnVnk1RTArcExpQXQ4NU56aG9OWEhIbkl3MXI2?=
 =?utf-8?B?TUl2YmJiL0hyMDFyWTlDM3BPdExMcGRkNC9ZSzNSUkE3KzNXS1h0U0x5THd1?=
 =?utf-8?B?ZHJGOUlHZy9DLzl2cEo4L3FaMG1pNW14THVWMHZKdXBVR1pJTndxS3BHZ1hk?=
 =?utf-8?B?bDNIOGxFUkU2dU9CWUtYem55UzdPWmp2WUYveHc4K21BbXBZODJHYXhWeVg5?=
 =?utf-8?B?SDBWcTk4Zkl0cW1FS0FEQ2w1VXB2M1oxa2xES2NMNjRiOGlEazZkUTdGSVBF?=
 =?utf-8?B?d0poamJmTll5bVA2RnNjSFVCaHlaM0xrUTdYWERjYW8xUnNIWmxVeEo3bGtO?=
 =?utf-8?B?SnV2WW53WWplaVdrL0pTMjlSWE9TKzg5b0FLZEVlcjBwSXcwUm1xMHZSUFgx?=
 =?utf-8?B?UGQzeUV4aVk0WUl5NFB6SS9BdVd3T21iS1NUWG11Y2E5Mm55ZlRHNnJ5YUpH?=
 =?utf-8?B?ZG53eGZXOHVxaFVUaWFHNW9aelIyV0g1TTQxNHdHUUxIcUxmSnkwZHdzUTha?=
 =?utf-8?B?YmRjWXhtVEdsS2EwQ25PUXluSFV2alJXS1YrU0NKSENwcHhRT1duWEczWW93?=
 =?utf-8?B?VCtwNWlHM2pXYmhUNVpQbWFMTVl6RDdXUkJqRHcrdGhESVQ0VEJQNCtKa3ky?=
 =?utf-8?B?S2xlNmc1RFJKOWtSY3lWeDBaRm1rZzRjc3ZMZzMyRlFPd3huSVd5c0puMFc5?=
 =?utf-8?B?RU5CVEhCdEtPNVNhK2duMGpwV2E1TG54VUJxVlE1WXRjOERiMS9SZUhGc2hF?=
 =?utf-8?B?cHh5SyswU3hzM3VGenI4TG9ibzlVL1FwOFZJei9vdCtzY05jTDVySExYM1Jl?=
 =?utf-8?B?TU5BZjdpaXNFb25pNW5NRFBBN214bVRtbWFBNHJOMThpWUlCQmEzaUdIOXZt?=
 =?utf-8?B?K0wwOFNxTTlUeXkweHZqMXdLSlJaby95WXdDdVpSZFkyc0dmbUNMNXFQbW5C?=
 =?utf-8?B?VDBVVWpPN1JycVY2UFNscTBuR2pZV05GTFdocDZPTm5FK0E2REM1NWg0VG9a?=
 =?utf-8?B?cjg1OXlxNERtM3M4NEFPTzFWeXQ4WTVwZzJFekRjOHFxbnlVa1ZNaXFqODMx?=
 =?utf-8?B?UWNsZUhBNmh6Wit3UGVCTnB2cTFzUUE5SVluRzFUQk04RVQyYW80L0h3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXA0NFJ0WitpN01SblJrYW1ReVh0QkUvZzdmOXQwOEp0TEluN0c1QWswaWoy?=
 =?utf-8?B?UVdrWE1VUzRpN2hieHFIdzl2ZkhVQVVydE5VUXlKL09qZ3FzdXcxWU9FUFZv?=
 =?utf-8?B?T09LSTR4VFJRZzAyZTRERnJlRk9CbHF2ZnJSWEZyTWFHR28rQUViWkM3eE9H?=
 =?utf-8?B?SU81V2ZEUnZ2OHR1NGNQZnFXek9aeW1YK1pLdUdRQy9lb1RaczFkMkpjMk5k?=
 =?utf-8?B?ZDlXQitZZk50MzI1MDdlUmhHTmlkWVRDMzV1cmRKbjFWZW5MaXpCWnczcDhR?=
 =?utf-8?B?UWRWbmlGUGF5RmlFM2tRbXl3dkdqYkdNR0RIMFM0clg3bk82QURDb3U4T2Vm?=
 =?utf-8?B?SU1wcjFEVFdrVHJVekc4SS9uc0ovUWNrc01kZDh2TjIwcjAyd25lbmVsajBG?=
 =?utf-8?B?WWg5WHdRdVlKZEpSZkl2K2lrSzU1QTJIOW1LOXdMMmZpcGJXTHc2ZEhrRHdx?=
 =?utf-8?B?b2pKa3cyYWhPN3pka2V6Q2tseGthV2hpeGFYdWduNmRDV2M2d0VuQXNtUVVO?=
 =?utf-8?B?eGR4V25TUlVWa3pQUWdCS21ZZ2Z4bDVhaXFZY0w4SlltL3J4eXZhY0pibHdq?=
 =?utf-8?B?V0EzSENVMVl5bW9EcnlLNUk5cjJyei8wbm9sd21mNWkyd3FUMkhSb21QU3g0?=
 =?utf-8?B?MCt1Z3lvZUdaUFJvZmN6MVVwYk5YSjc3amxkZ2o2ekNBMnJZYlM0VVQ2STQw?=
 =?utf-8?B?OHBhSDgvMjRyMk0yTkhUdnFUWHpHUXc0VFJPWU5qUGxYV05vK2VaMGpPbzhs?=
 =?utf-8?B?ZlZIcFFMbjJlMGFyWVdoU1FMOGZIWVI1djdCTWtJdGVpdzVoS2NKVGN0dTUz?=
 =?utf-8?B?RnhCdFpFV1RmVTVpclFNTStONlNTcDlwSkhJZG8raHRockNUNVN2REozTDZS?=
 =?utf-8?B?cThLZW9ibDFCV0toK3VRQmtHbVh5eEFMNEpzSVQxcms5cXplVlArRW9LWkU4?=
 =?utf-8?B?WXRET0g2MCtDTUVmTkxGMjRMeU5sRjVZRDdPVVduREh3L2NRYm52QUc0YzNm?=
 =?utf-8?B?aW9JY1AxRFFZRWJWZnFkTXpWZUFKY0pKdlR2WVlZMWI4eVRVdUlKUW81aDZG?=
 =?utf-8?B?a3VkSk5WenFUNTAvUDVWekVVczBPSFlLa1JPYUQ2QitrUGhkZnA1NVZreVk0?=
 =?utf-8?B?NkNTd2w3bmFhWi9HWmJGMytBV0tDYmoxaHJuMmFDVmswWmJnTUVVUFpHejdK?=
 =?utf-8?B?Q3EvNklPbHFKUWxkZUd5eFFUWDFJOVV6cm1zNHF1cDJGMHJNd0Vla2JaUmhN?=
 =?utf-8?B?Y3N6d3JtM0hQWVlVa2l6R2ZLbnV4QmdySytaODRCUlhIYmNYbjcrdHdDTGN2?=
 =?utf-8?B?S3dQK1pBcGpNdE1qZVBNdnI4ZExRek9HRnFpM0c2dGFQOHd4Q0F1U2cxaEty?=
 =?utf-8?B?MTE1SStxZStpVHNIb21yektEWlBQeWN4NzJIRkNmV2VuVUpJRzFCK0VWdUov?=
 =?utf-8?B?NVNMQjlBU3NEVExHaGpUcXdndUN3VWZCYU5mcGZCeElxTVM3K2xGQWI1S2FG?=
 =?utf-8?B?b0p5MWFPck1xejVLdUFKdzVqQTZSZytPV004UG1lamNxV081QmpFUWNsbHR5?=
 =?utf-8?B?aUtOaUlEMzhrZ29jTCtMcGpKb1pwbUFuWmgxdVphWjlhMEJ6VWVWb2JTUVQw?=
 =?utf-8?B?WUF6NUFtNkxaNVRYZ1RQTVFXb0Y5UXo5OWFyb0JHQmlLRTRQemUxMGtRdG4z?=
 =?utf-8?B?T1ZRN3dyekI4NytBZEhuKzhPSDhVZFlNbDN3ZEY3U1BQcGNGeEpCOC93Wi81?=
 =?utf-8?B?NFZmNVhZMlkrd1lOcGNkTW54Q1R5STFYKzFZTytvT0tiQ0Y5TGFXL0FKVjhC?=
 =?utf-8?B?Y2w1andUTjdkQVhxSjM5QmZ0SkUyL2c0RVFUMmwzcGZWcExYZWd0dlEwSkpn?=
 =?utf-8?B?Q3NDZUxyRXpLRDgrcmU1RVZyTVFuaG95MmtVb0c4eG0zTnd6S1oyNGkzZ2RI?=
 =?utf-8?B?K1ZoUmFaQzRwVVBaazFaWlZOTk8rOGtxZ0dTTWpzWWNzdytVTHZKbEtDVllZ?=
 =?utf-8?B?SHF3NmJ5QkovcXFyaER0VW1iYW1vMGNXTERGWFVVOW52c2l6Qm9LL3JuRnov?=
 =?utf-8?B?czN5RUxIaS9CVGpLQit4b1NlTlQ0UVFKQXl1ckhkeGVSbXVBeUF2bjluUkZX?=
 =?utf-8?B?c3M1c1pKbDg2Ni84NERmaVdUWlBicDdSUUVCbGJ2TWpmR1Bhck1PMHFmNTBE?=
 =?utf-8?Q?JgKef1b6zNC1HK9D6gD0NlM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb3ac3b-c5a7-4509-f88c-08dc70f9a35a
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 14:01:07.1502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlTWvWAjweBuHQJSLL7H69URhMnRwIwvf1nNfx9LrwUYzegt+kRluMkoDHVWbZ1F2YCwE00F6B6j1ZQj+Cvq1kmmrP20h7rJJt9ZbmHQzV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6142
X-OriginatorOrg: intel.com

On 5/10/24 15:07, Greg KH wrote:
> On Fri, May 10, 2024 at 02:54:49PM +0200, Przemek Kitszel wrote:
>>>> +static ssize_t auxiliary_irq_mode_show(struct device *dev,
>>>> +				       struct device_attribute *attr, char *buf)
>>>> +{
>>>> +	struct auxiliary_irq_info *info =
>>>> +		container_of(attr, struct auxiliary_irq_info, sysfs_attr);
>>>> +
>>>> +	if (refcount_read(xa_load(&irqs, info->irq)) > 1)
>>>
>>> refcount combined with xa?  That feels wrong, why is refcount used for
>>> this at all?
>>
>> Not long ago I commented on similar usage for ice driver,
>> ~"since you are locking anyway this could be a plain counter",
>> and author replied
>> ~"additional semantics (like saturation) of refcount make me feel warm
>> and fuzzy" (sorry if misquoting too much).
>> That convinced me back then, so I kept quiet about that here.
> 
> But why is this being incremented / decremented at all?  What is that
> for?

[global]
This is just a counter, it is used to tell if given IRQ is shared or
exclusive. Hence there is a global xarray for that.
And my argument is for this case precisely.

[other]
There is also a separate xarray for each auxdev (IIRC) which is used as
generic dynamic container [that stores sysfs attrs], any other would
work (with different characteristics), but I see no problems with
picking xarray here.

> 
>> The "use least powerful option" rule of thumb is perhaps more important.
> 
> Yes, but use a refcount properly if needed, I can't figure out why a
> refcount is needed here at all, which is not a good sign.
> 
>>>> +	refcount_set(new_ref, 1);
>>>> +	ref = __xa_cmpxchg(&irqs, irq, NULL, new_ref, GFP_KERNEL);
>>>> +	if (ref) {
>>>> +		kfree(new_ref);
>>>> +		if (xa_is_err(ref)) {
>>>> +			ret = xa_err(ref);
>>>> +			goto out;
>>>> +		}
>>>> +
>>>> +		/* Another thread beat us to creating the enrtry. */
>>>> +		refcount_inc(ref);
>>>
>>> How can that happen?  Why not just use a normal simple lock for all of
>>> this so you don't have to mess with refcounts at all?  This is not
>>> performance-relevent code at all, but yet with a refcount you cause
>>> almost the same issues that a normal lock would have, plus the increased
>>> complexity of all of the surrounding code (like this, and the crazy
>>> __xa_cmpxchg() call)
>>>
>>> Make this simple please.
>>
>> I find current API of xarray not ideal for this use case, and would like
>> to fix it, but let me write a proper RFC to don't derail (or slow down)
>> this series.
> 
> Why do you need to use an xarray here at all?  Why isn't this just tied
> directly to the aux device instead?

for [global] above I find xarray suitable soultion, for the [other] I'll
leave defending it to @Shay :)

> 
> thanks,
> 
> greg k-h


