Return-Path: <linux-rdma+bounces-8790-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C43CFA67A36
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 18:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C7E188BC5B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 17:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55D520D4F9;
	Tue, 18 Mar 2025 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6CPLZWh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6E2225D7;
	Tue, 18 Mar 2025 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317310; cv=fail; b=m5FUYAaKER+/mPLd/OV3fxsbai0yOLO5QD1XUQREC6ll8gDoSd7Tq0WEa1yBFcRof31UXvbfzapH6OW3ta3oApQg3a+lOH2KIG3I6QoKsyi68SvR0diWznyAG4ZW4dDsNIcMXO3t+5wuoosv3Nx2q4/bZyAyku4J9UZ6TVdKZq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317310; c=relaxed/simple;
	bh=DXuCt12+rdu6S/VkTddp7COKfoVpUUoYEXCT1sooSN8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mBW0jjJpRUYVjv4w/ufD0KKtDGCpYAGqvij3eEwSETlg1nslaP8tJ1ltdn+EcHPT9nDL0Ts99Dod3Sy79lPRlwNj4gIzZm/yhWW/1ONJvFXXNvUztC7rU53pDMxHlZHXpOowwe4M+GMUmu4zwJDp9erGwp3o8DcfaZ09L3LgY3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6CPLZWh; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742317305; x=1773853305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DXuCt12+rdu6S/VkTddp7COKfoVpUUoYEXCT1sooSN8=;
  b=Q6CPLZWhkc/9rSCTkMJl6JLjjt6N7hz5mwFoUwG3z1j1q8O/Qkr1MEAV
   onIJPMZpDRMmjWuQpSnxZQTDMGgxoOk3AwRhuW38p/+TEp39OIeZgBWd+
   plyDlfIZubaRuDtErYSNjntho8k5JU6jLq0fHxmteoH6X9mT0gXUPR4fY
   WMqZh2EtzUUYSO/Au4qm0ER23gyOyAghfYDYk6qREsZ+Tes74KuU275us
   oauWecfNfVandtaobvVBzI/86dDPkaCxL55qFtoiXn7nWV1RyEy7cVJn9
   v1MMpl3Ci5fkdoZLaGn7XkZ6y9ckJCPXUZEYVQZ/4+qCgo+lhB50O9nsz
   Q==;
X-CSE-ConnectionGUID: xy/dzSbyRQyGx1H1f0MJzw==
X-CSE-MsgGUID: Pk1xxSH/QSWIvKOyeC/Rlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="61002774"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="61002774"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 10:01:44 -0700
X-CSE-ConnectionGUID: om7ZmfbgTemVAjdUZu6g5w==
X-CSE-MsgGUID: OGt7b1aBRtmVlSISUZfpcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="145505651"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2025 10:01:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Mar 2025 10:01:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 10:01:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 10:01:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aknAZ+s7mhTtyO26mj/zPgUaMSHt1sS/56JNf2FDD7kRDzNakcPpyo6vUnuDh7pH+79BbUGzsttowhez/8CCakDgXjj1Ky91UykE7lQcrYiycU8ZvpBo4wqMe0LokigzL9KexCcrP6na1RVd8UKQ0f4yDDuy5dsrqGyA0BRzSNZ7w9sVn02vH5KkpiCXp6SRYAL2jZy/qV6QMJwvrHJuL4EIl4mCMihZNrT58lagEyfP9xmPXxThbcl4Vb78uB4N3tDnfqah1Uv6ny4U9JBaduB1ZmeRsBSuS7QDUz+Xt9BBo967/JEvc14ZCG+HSFhD5DPBU8Jf35pW5xB5KVvz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nl7n24RLKaZugPZTJYQVasflq7aQV2Ayk1SXGAM8Nsc=;
 b=pDx97e0LJSkVOu3OS4kuiVdTohoBBlqNG0nXGauuFyS74hpmJ+0cMVjeJmqOALkjmphKv9QmblPb/5sJCbJsuZ/RfIIvyISUXKU7x5SssK922BiExqUdno7DSGYl0jC3LlxQNKT+7PfagzxcJ26T0kl708uVaDwfsd+axjMPgxnqXahLOb84zw3+fIivdM5nX2d1PSlvufjNNHVCoMfUTshVkPOKRs1jIFFumNUi25+2Uo9dQa1VS0z8nFgQ6EibtE+SUa1VVvPz5sQZ6ma6vHEGqMJYRHLxCQNlpQpgvt/M7VcxD+yq3D1jnxcvuLc5WjZzOWSUpr5xMhDRJ0L3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by SA1PR11MB7697.namprd11.prod.outlook.com (2603:10b6:806:33a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 17:01:39 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 17:01:39 +0000
Message-ID: <dc96e73c-391a-4d54-84db-ece96939d45d@intel.com>
Date: Tue, 18 Mar 2025 10:01:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to
 support multiple consumers
To: Leon Romanovsky <leon@kernel.org>
CC: "Ertman, David M" <david.m.ertman@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
References: <20250225050428.2166-1-tatyana.e.nikolova@intel.com>
 <20250225050428.2166-2-tatyana.e.nikolova@intel.com>
 <20250225075530.GD53094@unreal>
 <IA1PR11MB61944C74491DECA111E84021DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>
 <20250226185022.GM53094@unreal>
 <IA1PR11MB6194C8F265D13FE65EA006C2DDC22@IA1PR11MB6194.namprd11.prod.outlook.com>
 <20250302082623.GN53094@unreal>
 <07e75573-9fd0-4de1-ac44-1f6a5461a6b8@intel.com>
 <20250314181230.GP1322339@unreal>
 <8b4868dd-f615-4049-a885-f2f95a3e7a54@intel.com>
 <20250317115728.GT1322339@unreal>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20250317115728.GT1322339@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::16) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|SA1PR11MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: d505a328-e360-4dcc-956b-08dd663e8c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2tCdUNKcStZeDdSa1o4eTdjU2hIdDA3MTgyNGZhVEVKazBrMW9WalBnOGh4?=
 =?utf-8?B?KzE1dFVZVUtwd3laSFl4UGdrcmFVdDJ2L3FWd1Z1bnFaZXhqUkdJeCtCU0oz?=
 =?utf-8?B?eDBEZzNjVFJDVjRHMjV3ZExPbnRha3Jzb0MwYmhKV2xvMHFadUx0ZzFYQXdE?=
 =?utf-8?B?cVRQbkFickhQSk9EVDNTZ2VFMkRtVUtJU3I1WXZDdHdWalh1bVBIcnY3c1hJ?=
 =?utf-8?B?L1hRSmtlNVgrU3puZUNqRGJnSzVJbWM0UmJ6UTJua05PZ0IxWWhlNzhmTkFM?=
 =?utf-8?B?dzZCTDNjRTVhaVdnQ2RiekN1ajhwVGs3d0lONGNjU0hxeFVYUWRNaXYwaE1j?=
 =?utf-8?B?cEtCaG9SWEFuMHExN1VUSncvQmRxYW5NT3V5RjFIcWhLVm5UQXI4RnVsUmIr?=
 =?utf-8?B?dEp4anlKeldXbHZaMnBPSXU2M3l3TkVocURobDRnNTAvOTd2WVBDdllGaTVw?=
 =?utf-8?B?djdLQjhMd2kvSUYwTmRZZG0yUTJiV2JNUkVyK2FRRDBwc2pCUDhXZGY5dDZV?=
 =?utf-8?B?RE5wWGlWekFwa1N2VFNYZG53K0p6TEVzRVIzWWZoZTZEd0oxcTV3WFNnS2Ey?=
 =?utf-8?B?Uk5rMmZ1UkhkbVhUTFh0bUd2UjBrSm8wK2x0cTBqQjJPUEd1dzZqV25OeTRD?=
 =?utf-8?B?MEI2bGNqMWMzcmpYVDZNQ1VtbzRIQnNqMCt0T0JDb2RVVkR5NW1tbExiTXZU?=
 =?utf-8?B?ZldoS2xDaXdGdmNPdk9ETFRBN1lGL0NlVlVic3F6SEhUSkN3MHZ1d2tVR0Vq?=
 =?utf-8?B?TDZoM012RTlZN0wvU25VTlJQU01BUGdWb1VOejBJRkt1VlNWMTNPbmp1cFhB?=
 =?utf-8?B?MmkyemZtejlzQkpYYm5DMXVQZ1ZTcU1TOXRPQXJ4bFlYemtzMk1PMEtMcCs0?=
 =?utf-8?B?YTlORThaOVk1MldJUzVhU2JLemdZQUhLUzNuOG5BeXY4WXJCT2VqSWJTZTkz?=
 =?utf-8?B?L1BBTXpUNFBlR2czekUxeG5CZmVOSVR0cEQ0emJVN3FNcDdpQU1nbGpNMUJQ?=
 =?utf-8?B?NWxQeTZQY3VMY2tpRGZxRUJWRTEzd2owMFZjQldyNlk4Q01rczFHYjN1TXkz?=
 =?utf-8?B?bkFkZ0pVcUhWbWV5ZHhvc3lxSCtNM1VvaURUWENmbVBkOG43RWFSb3ViaCtX?=
 =?utf-8?B?RHJCazZUdktaSE9vKzlHZ0hJSTNOZXQ4aXpxUllBTlYyQ0c3VFd5cFhHVlJD?=
 =?utf-8?B?aDhMR3hJZXpKNTh4dUFpeldVeFR0QnZodkY0Wk9xQVVpZGhPZGhUUFd1YVg5?=
 =?utf-8?B?dnRXTmphUXJ3WmZWTmg5VWJsREs1SUt1Mmx2TzlUWXp2U0d4cFNVYk9GM3RY?=
 =?utf-8?B?Z0twUUxlbXhXV2kxL0I1NTdhRlNmRGpWcFlOc2J2K1dqU1cxMlVkOERYalp3?=
 =?utf-8?B?eXphL2tqYmdpSDBXZ1JlNmpWUG1mSzAxaEluR1ZwWlQ1V250d20vb2xXc2xR?=
 =?utf-8?B?a0ZOb3F3OVFsR1J0dnR1RDNkWFAxdFRQWW8yM1NzZU1NMEt6REh5aEV2bisx?=
 =?utf-8?B?VVJKSHhuWWtVclJTU0JhdU5CcG91ZnV5aDN1cVpMZWsvRVVDVERYSHg4N2po?=
 =?utf-8?B?TklsbUFjVEtQNFNRVzNvTzVDV2ZqZ0c4all4QmEzUy9hQlo5OEFPVDBrYUhC?=
 =?utf-8?B?aUJqMjlDQWwwWFkycnZ2NUF2Rzhyd29Fc1EzUXVpOGorNWxBWDVRbzB2TWlZ?=
 =?utf-8?B?WUNuVjBYajY5NmNtMEpzOXFKQUdyNHZRS3QvNHR4MVE4bVExSTk1cC9TTHNl?=
 =?utf-8?B?S1N0RFV2S3pOVFhtT3lGbXdRMFJHcFRBUjRQN2krQ2VQYXlXbytEK1VGOVJF?=
 =?utf-8?B?L0JGNitqSjFFSFJ0K0RzeEZXaTRLUi80ckR5TFpCbzNBYUR1MkhXamRheVd3?=
 =?utf-8?Q?+FH8f9Ux4ftMF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWpabnlkc2NtdGYzaGtTSU9XTHp3TXNzcWVwUEpHalJERUEvSGd5Z0NrMkVI?=
 =?utf-8?B?YjROMUFQOTgzRVRGaGdWZ0V4YUQrYmlwSFBZbllGQU15RDA0S3NSekJJUm5o?=
 =?utf-8?B?eUF2SjAxS3VIN0w2bCtEdVVMdVV4bHRhS2F2dEN0RUtxRFJmRW9pVWc5Um13?=
 =?utf-8?B?UDNjVUh6SkJyMWU0QkF0cEYvd0J3d284YW1qcE5jRzFrVVV2ZC9qNXVkRzBV?=
 =?utf-8?B?OW1LK0s3d3hKV1V0V1orcnU0emlGcVlrMkNPblk1Z0FCRGVkWnFPK05DRDBY?=
 =?utf-8?B?VENNZ0k1UDZhZ2crWU9jZ3dDZll3NWtuWUdSUHpRRzd4VDBZRGVPb1FhMzRo?=
 =?utf-8?B?RjRsNG55anhTV1BQL1lmUDluam9kWktiaEtVL3JZN0ZIU1k4ZHZ2Wm1Ld3Uz?=
 =?utf-8?B?blNCTm9rNmloTzYzd25iaUtjeHFYSGZZWThScmNNbHJpWCtKRnhtWmREbmFz?=
 =?utf-8?B?NkJ1cmxrb2FYWTJmanA1RHN4QUw0RFdkc1l6RVVqUlVmcnRIUTNiNXJDYTZS?=
 =?utf-8?B?T3pnU0xjdWI1NXhjZExaNzgrYm13bXpoUTRGSElDdkw3NUgrSGhYckJzRXZ4?=
 =?utf-8?B?cEpjUGV3ZkFYYTJ4VHIyajlTUDRqbWFlazdnaTh5T0pBcEJZa3EwRTBmallV?=
 =?utf-8?B?eDRneE1BRzY2TEU4UVVINjhWV0xOMTduK0VTMDBodFZVdnFjZTd5cGNWSXhF?=
 =?utf-8?B?R2l4TmRWTFNsMFZYWXhWaGtNeGJ2WXRkNTFJTXE3NlJjM2JmdDR1S1dFWHZD?=
 =?utf-8?B?ZTh5TEVkQVVuSW1VRjZRemg1dFA1RUl2YmY2NTUrVEEwSmdKUVk0T1ZKZ0xX?=
 =?utf-8?B?ZVowNDVwTUtSZXBuNGpKV3BERXlhcVR3azA5QVh2UzFTTm5Bc1dFNzEzaUtS?=
 =?utf-8?B?UzlWZjY0eDBVTStLTVZWSWtrdW9jSkpzQ3BHWllYTFZUaS8xcFFPT2VVSmNx?=
 =?utf-8?B?aElLOGYrK1c5TVFobG14WTB5Sk45VmZOTVRCS1dHeEpXTXh2WnNSY2pLMHl4?=
 =?utf-8?B?UmticFdIZ0VleFNCL2kyU3ZCVTBhVmY4KzVOaVNWSDRhWkM2cTVFQUNuV25T?=
 =?utf-8?B?THl4VkJ3Q2MyMFdmaFhoVHkvRkx0Ym4zRmxrbGN1T2lvYmwvTmtSMVpPM09J?=
 =?utf-8?B?eXJNNkpUaFA2YS9WQ3JNVFJJQUIxcDNCK3k3K2dld2hZQWNlWVo5OTRrYkR0?=
 =?utf-8?B?eUt4QVl4M3BzWVp5U0Y3VGtMeVVxZTRFalA3M3JxTjhwUUNUK0FYUlRKc0Ez?=
 =?utf-8?B?bFR4T3EyT1owTGp4TWUwYjdPTnl1Y0xwdytUcThFSERwdjR2eEQzT3FsSUlL?=
 =?utf-8?B?ckNQZk05VkxCYUNXVWNxMTA1ZGZMbnJlZ2FmcDFqRkc5NUl4aHdiK001blF1?=
 =?utf-8?B?ZW5QUk1NVkZlTW5sT3NXdUtNT2xnQjJRenRZQW93T1ZGRnZoQ28yTVl0dTVC?=
 =?utf-8?B?UmVvaEVRM0FwOEd4U3VjVjZLaE8xWDY4TnVwVEFWWW9YRExGRk9NTlFNeW8w?=
 =?utf-8?B?YTZlWC9VMkV6Tis1cFRxUkV0ZzZkUXgwMEh2dElteVdUVWpoN3M4UUxhdWZE?=
 =?utf-8?B?MnFWM2ppS2hsKzBGWXdzdEhibVVKRGdwSzNIdUZhOXFvZmh0czYrUmlaZHps?=
 =?utf-8?B?Y3kxK1RIN21obDBEcjN2WW5CL25qQ3lhRGF1S3NoY3BiM1ptaXN4TnAwK3pR?=
 =?utf-8?B?NGg3Y1dsSGI2QlVoNnBrbzRsc2ZCTDdYRldjcytKSDVTM01vSTN3Ny9pK2ln?=
 =?utf-8?B?dVJhV2V0eGNlWCtrd1RYbVlreXBWdlJxYUN1N3pCcktDcllqbFU3d3JxblpB?=
 =?utf-8?B?SENyZEJINUlhd3hZV01ya3QrSGVNUndwazVvTG9qSFNDQjR1SThvNUxqQnRM?=
 =?utf-8?B?dDJkbUt3VlZiaUoxbVZNUWE2Q1kwMXRPL3JsU0JpODVNSkNvVVJuL0VlcE40?=
 =?utf-8?B?elZCb1NOV2R4QXZLeEw0b28xUk5qR2V4ajg3cGFTazNWeEZrNVQ2ZURTSkFs?=
 =?utf-8?B?aVJjR3Iyb1dzZFdNWDkxd3N1akVCb1Z3WkY5NFdMcmxEM3NXWXRyWlBVVHdt?=
 =?utf-8?B?T1Zqd0dKNWYzZDFxN29veDM3ZENjMWcrejRQcjFUbGUvN1JRU3pua3M1TmFV?=
 =?utf-8?B?MFd4d1gwWXZLRWtXWisxenVCZWpVM0RQdnlGNHh0THlIQ1U0MFhZbllRdElu?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d505a328-e360-4dcc-956b-08dd663e8c99
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 17:01:39.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I31j/u1y7v5/NB/2wwU7CpGyr+ysL2O91FR6CWgv51JTBvY0o/nlD/d6sWSlH7Sv0lJyHJDMW8oqD/EjvQ4tMyc8rsLfjSqAXaAjWTpeQeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7697
X-OriginatorOrg: intel.com



On 3/17/2025 4:57 AM, Leon Romanovsky wrote:
> On Fri, Mar 14, 2025 at 06:18:00PM -0700, Samudrala, Sridhar wrote:
>>
>>
>> On 3/14/2025 11:12 AM, Leon Romanovsky wrote:
>>> On Thu, Mar 13, 2025 at 04:38:39PM -0700, Samudrala, Sridhar wrote:
>>>>
>>>>
>>>> On 3/2/2025 12:26 AM, Leon Romanovsky wrote:
>>>>> On Wed, Feb 26, 2025 at 11:01:52PM +0000, Ertman, David M wrote:
>>>>>>
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Leon Romanovsky <leon@kernel.org>
>>>>>>> Sent: Wednesday, February 26, 2025 10:50 AM
>>>>>>> To: Ertman, David M <david.m.ertman@intel.com>
>>>>>>> Cc: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>; jgg@nvidia.com;
>>>>>>> intel-wired-lan@lists.osuosl.org; linux-rdma@vger.kernel.org;
>>>>>>> netdev@vger.kernel.org
>>>>>>> Subject: Re: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support multiple
>>>>>>> consumers
>>>>>>>
>>>>>>> On Wed, Feb 26, 2025 at 05:36:44PM +0000, Ertman, David M wrote:
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Leon Romanovsky <leon@kernel.org>
>>>>>>>>> Sent: Monday, February 24, 2025 11:56 PM
>>>>>>>>> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
>>>>>>>>> Cc: jgg@nvidia.com; intel-wired-lan@lists.osuosl.org; linux-
>>>>>>>>> rdma@vger.kernel.org; netdev@vger.kernel.org; Ertman, David M
>>>>>>>>> <david.m.ertman@intel.com>
>>>>>>>>> Subject: Re: [iwl-next v4 1/1] iidc/ice/irdma: Update IDC to support
>>>>>>> multiple
>>>>>>>>> consumers
>>>>>>>>>
>>>>>>>>> On Mon, Feb 24, 2025 at 11:04:28PM -0600, Tatyana Nikolova wrote:
>>>>>>>>>> From: Dave Ertman <david.m.ertman@intel.com>
>>>>>>>>>>
>>>>>>>>>> To support RDMA for E2000 product, the idpf driver will use the IDC
>>>>>>>>>> interface with the irdma auxiliary driver, thus becoming a second
>>>>>>>>>> consumer of it. This requires the IDC be updated to support multiple
>>>>>>>>>> consumers. The use of exported symbols no longer makes sense
>>>>>>> because it
>>>>>>>>>> will require all core drivers (ice/idpf) that can interface with irdma
>>>>>>>>>> auxiliary driver to be loaded even if hardware is not present for those
>>>>>>>>>> drivers.
>>>>>>>>>
>>>>>>>>> In auxiliary bus world, the code drivers (ice/idpf) need to created
>>>>>>>>> auxiliary devices only if specific device present. That auxiliary device
>>>>>>>>> will trigger the load of specific module (irdma in our case).
>>>>>>>>>
>>>>>>>>> EXPORT_SYMBOL won't trigger load of irdma driver, but the opposite is
>>>>>>>>> true, load of irdma will trigger load of ice/idpf drivers (depends on
>>>>>>>>> their exported symbol).
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> To address this, implement an ops struct that will be universal set of
>>>>>>>>>> naked function pointers that will be populated by each core driver for
>>>>>>>>>> the irdma auxiliary driver to call.
>>>>>>>>>
>>>>>>>>> No, we worked very hard to make proper HW discovery and driver
>>>>>>> autoload,
>>>>>>>>> let's not return back. For now, it is no-go.
>>>>>>>>
>>>>>>>> Hi Leon,
>>>>>>>>
>>>>>>>> I am a little confused about what the problem here is.  The main issue I pull
>>>>>>>> from your response is: Removing exported symbols will stop ice/idpf from
>>>>>>>> autoloading when irdma loads.  Is this correct or did I miss your point?
>>>>>>>
>>>>>>> It is one of the main points.
>>>>>>>
>>>>>>>>
>>>>>>>> But, if there is an ice or idpf supported device present in the system, the
>>>>>>>> appropriate driver will have already been loaded anyway (and gone
>>>>>>> through its
>>>>>>>> probe flow to create auxiliary devices).  If it is not loaded, then the system
>>>>>>> owner
>>>>>>>> has either unloaded it manually or blacklisted it.  This would not cause an
>>>>>>> issue
>>>>>>>> anyway, since irdma and ice/idpf can load in any order.
>>>>>>>
>>>>>>> There are two assumptions above, which both not true.
>>>>>>> 1. Users never issue "modprobe irdma" command alone and always will call
>>>>>>> to whole chain "modprobe ice ..." before.
>>>>>>> 2. You open-code module subsystem properly with reference counters,
>>>>>>> ownership and locks to protect from function pointers to be set/clear
>>>>>>> dynamically.
>>>>>>
>>>>>> Ah, I see your reasoning now.  Our goal was to make the two modules independent,
>>>>>> with no prescribed load order mandated, and utilize the auxiliary bus and device subsystem
>>>>>> to handle load order and unload of one or the other module.  The auxiliary device only has
>>>>>> the lifespan of the core PCI driver, so if the core driver unloads, then the auxiliary device gets
>>>>>> destroyed, and the associated link based off it will be gone.  We wanted to be able to unload
>>>>>> and reload either of the modules (core or irdma) and have the interaction be able to restart with a
>>>>>> new probe.  All our inter-driver function calls are protected by device lock on the auxiliary
>>>>>> device for the duration of the call.
>>>>>
>>>>> Yes, you are trying to return to pre-aux era.
>>>>
>>>>
>>>> The main motivation to go with callbacks to the parent driver instead of
>>>> using exported symbols is to allow loading only the parent driver required
>>>> for a particular deployment. irdma is a common rdma auxilary driver that
>>>> supports multiple parent pci drivers(ice, idpf, i40e, iavf). If we use
>>>> exported symbols, all these modules will get loaded even on a system with
>>>> only idpf device.
>>>
>>> It is not how kernel works. IRDMA doesn't call to all exported symbols
>>> of all these modules. It will call to only one exported symbol and that
>>> module will be loaded.
>>
>> If we are using plain exported symbols from all the parent pci drivers and
>> make direct calls from irdma, i would expect that all the drivers need to
>> load based on module dependencies.
> 
> Are you doing it already?

Yes. Today irdma uses exported symbols from i40e and ice and loading 
irdma results in both modules to be loaded even when only type of NIC is 
present on a system. This series is trying to remove that dependency by 
using callbacks.

Your responses seem to indicate that even when using exported symbols, 
all parent pci driver modules will not be loaded. Do you agree that this 
is not possible OR am i missing something and there is a way to only 
load the module that is required at runtime? I can only think of 
request_module() approach to do this.

-Sridhar

