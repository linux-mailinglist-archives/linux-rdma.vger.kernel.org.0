Return-Path: <linux-rdma+bounces-3988-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4429993C357
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 15:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675681C21996
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AC919B3EE;
	Thu, 25 Jul 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRNc4K+k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E1613AA36
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2024 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915542; cv=fail; b=ZuTclk8Yrj/LNpLlFvIj7a9tzVpNixoUKoGA7LGoZE5zQ5YSzdyqfnoxYzw6VgnUD1/FznVxXyJDibIT4k7JAVFZrmyMNBxkrOZld4RfdCz4xWE7+pMXoyyiktk/F3Bbg3iY1u8fA+I6LZfbeYndYIZw1dqTA67ju7IREYXOCcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915542; c=relaxed/simple;
	bh=QqO3FMSW8E1sb/fy8xOUcmB6q4+uUGWoov26qy64oho=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ILnQ0KXJKB8YctLdzUiINAzpyUl6UUQfxf2KbguEEVELuKsI5c3WBG3rspsHRNWN+EI11yzSXRNUj4Tjc8kZf8sfeMtkfTeY4UyXTt7Mr/Mqch+wn39SaqY9D6jDT1k2IbrUR6gIESg2gAMGgP9UTzt10Icd5Nq35kPG2lwodhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRNc4K+k; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721915541; x=1753451541;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QqO3FMSW8E1sb/fy8xOUcmB6q4+uUGWoov26qy64oho=;
  b=SRNc4K+kKT3fgHWvct+ya4zMiZAXEga29bySmh95jlrGcx/vO7lEn6HW
   5M5SVLq2oujGML/yWL5tE+ND86PkhH/c8cC4m+iPHwaYX/jVHBBxzbRJp
   nm3zldREE/QnpcIfWobtSO6j6jS+4NsyKZwToXl2XzCB4Gtg8NL7y/gxf
   q39ufKKcpg9bR2CFeqXhdyLTXs/sWV2XeRqo+MlLfocPxIkSQDfX2f85C
   1w8A2VpbdES7m4QcRoKSRz8/vN64l+oTkOXgd9H7jZm02NHe/zlrQeyVK
   zUBP2JoxtVq0ax89kvJHalCMynsBSpg29M/MlhsrRNrQdBVeyuGJiZM/J
   g==;
X-CSE-ConnectionGUID: o1WYadVAT+yk+kA+yaRmWg==
X-CSE-MsgGUID: 51lqkzneS8+tyn/8PNw2ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19502912"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="19502912"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 06:52:20 -0700
X-CSE-ConnectionGUID: WI8006xmTRa0Xm1D2G1u1Q==
X-CSE-MsgGUID: TS+jhK97R3aOfzOjjR//5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="53550395"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 06:52:20 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 06:52:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 06:52:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 06:52:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Skp0MWCNU+t6hn8F8Fuj+oDPtdfhycYbqtGtVW4CXX+UVp6aZ/3K5OM+YD0f16K6Gop4xrPb4/6zI5vAVLTY2L55GmztpQ1KsqyJTy1UZ0ou9uY26sAxdNb0YBbB+OK+pKt8UjXsBCE7Ca2+0Y6ReQ06MvSa8WZWsmV3E9G2J9oBZyAiIdneUcMpEargh+NG8QSjyAFmUenr5wOr/xoUs5nDzdUj6+lojyb0NDo7cHsVrbiHvnyLwUAVw0+ZaJdFaJCCvNyYiddsxZCf8zmLYll145uXY+TPvpgVQMmw4Ad2UvXytDbtVCeuDkFGYz+lBRAQ2rz/UOByT2qPCBS3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aj3iMYMwPMP2DpDyVmmlyku5lwh1NzUR6r4eVESx/xk=;
 b=CCe9C06UGjuTzMFweuXjzXq4CY0gEUiFvuvxrsyAvVmroh3xii09QZ2EhWhTcqXezX8Scts3lXgBEUkjnmHhmP/WmdMVH72KAy7zoth9zcLLhjnochIH1PM77d95LXIPhY9Cc6h2GrgaHe73mIfJro0DnGGtscB8nXvzV1/BqUrnCdvqf8yWSfzJV5k1iKtg2rBaHOzkCKK0JiTCNwtRpjqyAsp52LOKDElsU7efh+0pVS8Fg5d+oQ0EhbSvFCG5b9vkMsbia4IBpRzjPjLVGUirKNVrlAk7ozQPrg9k/661oIw7saUPDHiTOc5hNyBp7z90Rq7EkWi9Pjm2ZSQ9SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB6705.namprd11.prod.outlook.com (2603:10b6:510:1c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 25 Jul
 2024 13:52:14 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 13:52:14 +0000
Message-ID: <004c46e4-b308-40d3-a3f6-ec00545dca4f@intel.com>
Date: Thu, 25 Jul 2024 15:52:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/25] idpf: implement get lan mmio memory regions
To: Joshua Hay <joshua.a.hay@intel.com>, Tatyana Nikolova
	<tatyana.e.nikolova@intel.com>
CC: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<mustafa.ismail@intel.com>
References: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
 <20240724233917.704-10-tatyana.e.nikolova@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240724233917.704-10-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0060.eurprd04.prod.outlook.com
 (2603:10a6:10:234::35) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e04a72-0511-433f-2379-08dcacb0fd4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmhPWWR6ZDl2elpEdnNOMlFtY2NrVUhLVkZRUkRPQkMrOFlMZDArVUlsZXRt?=
 =?utf-8?B?eVlHM0RVWUkzSEFDYXp6VW1GQVdTUlZNTUJLYW8yeTg0YWhLV1pFTHNoYzIy?=
 =?utf-8?B?OUtjQUg5Nmc3a3pXTmU2NWpWcU5vL0l1TUhuYVR2ODQ5ZmRaWFBvMEZjeDQ2?=
 =?utf-8?B?Sm5WS3pqZ1FSKzVZY25qbDdYK1NYb2F3UmQxOVptZS9VZFF0a3ZRb3FuSFpz?=
 =?utf-8?B?U2JZWnRxajlDSHpUNkduNTBoQzFTTWc3VndVZE1RcUtKRU8xODlUUUd1b3po?=
 =?utf-8?B?dk9GTWdNNVJuNVZSanh2UFpReDZXNzJ2RU14VzZ2eVNiUWNJTncvYXBTWmE1?=
 =?utf-8?B?MnpRck02azZTUGZla3dnODQ0OENUR3p2azNXVDZhZUNGa0QxN3Bnd1N2Ym5D?=
 =?utf-8?B?alQ3bENtS3JPWDJJN0NHMFhGN3E4TEJEL01BWkJraGtsaGxFWXRWN3RqWFN3?=
 =?utf-8?B?VkF0SmU0R2dIYzY3eDhjc01JNlg0a21hdjlJWDdpM0VNdTFBNUJQYksvU1NQ?=
 =?utf-8?B?djFhYlU2K3pnVytQZ2ZLUUJSK1h1b0hGNkdUZlJzeEYvSWo5L1B3YlQvTjl6?=
 =?utf-8?B?Z1BRb1drRDdIRWZzclFYNjJHWTRvK0JISGFIN3FVeWVaV2YxbDJOeXVyU1c4?=
 =?utf-8?B?SnRXWUFtQ1lHOVVaV2xiTWhWZkVZWFpiaHBLTlVQb0tTVDhEZEZUaldjSlFk?=
 =?utf-8?B?ZlJ4VGR4K3dyR3RCMGVyalpoUWxKbk9BRFgvMU5udXUyLzBDVUJGUUV6dW50?=
 =?utf-8?B?Ky9sWFNtcURLREZYTTN4eEo1UmhWaSttSUNBNXVMUjA1RWROK0RCQ1NmWHdZ?=
 =?utf-8?B?MXRjU3NrRXoxQmtwM2RFZ2RKd1EzakgzTVd1N1liWHltQml5Rjl2RFVyR0Rm?=
 =?utf-8?B?MThEcGpqdllzWndnWEJoQ3lyUXNJaC8rMXlTUmY4QmJ4ZnFtYnlCY0l6SkV4?=
 =?utf-8?B?UTM2UVVKQjA4RGVqeDBMWDgzdW5pQ2dmb2ViYzAveEYvWkx2cU1aMmVCQ2xh?=
 =?utf-8?B?NHl2dDZ4bURDdlZSemV1c25vUDVZNXNRbWlWMWVUWVFaNHY0S2Flb0dmbFVC?=
 =?utf-8?B?WmY0Qlo5T2trK0FjSkhNUStDQVk0R3JvUklZSXRya0l4UndQNlVPOFJKcTJo?=
 =?utf-8?B?Zkg4NGU2ZGJUcnhxSkRyeHNTTnk4WHlaODFsVmFlQi9wd3JkOGlPRWpEQjlQ?=
 =?utf-8?B?cXIxbzg0RGJJQURLaU1ZSVQvMFJYZUo4WDNNL244OFEvYlh5VFQxRVN6ZHdj?=
 =?utf-8?B?SU5mbm5ITVJTYXJGaFA2aHFzN0Y4VFhNK3o2UHppMWZqWW9URXhEa3J3dzhk?=
 =?utf-8?B?bk5IWTRVc2ZId2JFQXBjTmJKaXJWaERPSEU4L1dSOEMzRW5QM0xuQUZpRUN0?=
 =?utf-8?B?eDZZMklBR0dCUDcwd05Pc3pReTZpRkNGQXd0MGhMam9LT3R6QlJGYnpqZkZp?=
 =?utf-8?B?cU5KSUMrVEw0MW5BM2hDaW5rTFVid1BaeDhITklGTUU5VFhDY1U0aVhNcWxK?=
 =?utf-8?B?SWV3QmNwdlhIVzFqdTBpWERLMlA5Z2RqZzZldXluaVhJYjU4TWtsRjRjVUht?=
 =?utf-8?B?M2oxZldDU2NrbFJFVklMOW9tQXc3aWkvem1POG5MYjYvWURSUEFMRWl4VUdt?=
 =?utf-8?B?Y3AzRzNoYzFjQlJXd3NnTzNJL1hBQTc4cXNXNFBreXY0UEZabTJMUldUaVd3?=
 =?utf-8?B?V25mSW1kR28rc0VSYkl4TXdBUGVXM1pacEI3cnM4b0xLb093V3ZMWktRNjZa?=
 =?utf-8?B?TjlsVnkyelVYaFpLaEdmZFFVWHE3bWEwMkFlUjF2ZlFCbEVGaW1LdFZ4L1U1?=
 =?utf-8?B?WnZtTHIvSWVMbnVIbnNWZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3Q5NC9lVnp5UHFmWFlxWllGcStFblBKODdWWVBzZDdOeHRwWUZkbmxNZ1Rp?=
 =?utf-8?B?SXJUKzRMNFVzdGJ1SmRRMGg0OVBLR2tYUCtsQ3B6RGhxUWhDSUxyQlpveEda?=
 =?utf-8?B?R3dCalRTVk1ET3MyWTF1RjdsendRSnZRRnZ6Zys4OTc3ck5KTFhDZk5NaWxS?=
 =?utf-8?B?WDZod2NpRlVLWklMYU5UbEFaRDg0MkJCNTlwbDdnUlB3YnVLaGdsWW9hVXNV?=
 =?utf-8?B?WitWMXZod1dYYjZJZml1SW1tdGwyT1VnTUlkZVphRmhodlJpZ0xzZi9hVXli?=
 =?utf-8?B?Mno1VWNoa3ZqWXRvbGVITFJJejBuZjlRSGd0Sm1UTllIMHhvVTk0YS9PNkxG?=
 =?utf-8?B?N1lrL3dEZjZJQkFXL3M3WXM0MkY5aFpDaWswSWw5ZmY4d3VwYU5KVlBrTVNj?=
 =?utf-8?B?bVFRZmdwcm05ZktuTDc5K0NIUmorT1F1VWFEdzNaT3A2VkhiTVBpNDUwcStI?=
 =?utf-8?B?L1MxaEw4aVc4ZjMvODdySEVQek44Q1hNMkM3V0Vnc3BON2lleHVId29qcHpu?=
 =?utf-8?B?cWdoQXFuSWhSMG1FcWR5YmZXZXRvUjFyaEhQWUlLcVl5UVpQUCtsT0xFNEZW?=
 =?utf-8?B?MWxCcTc5MjkyR0JKMzRsNGJBdE5BNXRXZ0xNaTlKWlMzbDdXeU5vN3BxQlJj?=
 =?utf-8?B?Y2crMGxUOXhZcDBqc01PblNWeldBci96MjRQZlJMQis5K2llMDdVMUNMaEEr?=
 =?utf-8?B?OTNDVHM2RlZKSCtKYkl0UkI3Y3JKQ3Z2VEE4RzBjTVcvZG1JSHlFS0l2WUYv?=
 =?utf-8?B?cG95SzJ4bmFpMm94UEk3VUJvT2VPTkk4SWdoM3JJUy84YlYrbnVCK3JWeC9X?=
 =?utf-8?B?bTlSWlk2VldnSkU3blhKTCt6Y0x2RW11YlpvcEZUaWRNWmNrZ3BVQ1lhMkpJ?=
 =?utf-8?B?Yk15M0lCdkZnRlYrbGVZdXhYUHBVRlZYWjlYTDVBYlZDclZrVUFmQzNGQ2dt?=
 =?utf-8?B?aWdnb0NGdGova0trNGVEaFN5M0ZDK1lqOG5aZFdZaFZaRFdjV0pCa0hVSjhz?=
 =?utf-8?B?TVNLZFVJVUhpdUpjUHVaaTJuU3NNeTlFaFZsMUlwQ1dZQzlLaVZJVGs0bmU3?=
 =?utf-8?B?MW8wc2xHTjRJWDZrVXFrWVROZ2ovTzlCYXAyVVdWeUxxVThGdEgySnJ0OEVx?=
 =?utf-8?B?UVlqa2RSSmFydE9WNzRycTBrSitZYyt6ZGxDdWsvMVNTSkNWaHpESTMrSlQ0?=
 =?utf-8?B?Y0dIWk85UVQvVEN1djBoK1BIdWZ6bnFtQVRZRWRLK2FDbVdUSjBPU0ExdVlD?=
 =?utf-8?B?SjRvMVVvNnE1M01KY1RSUHN4U1hNYUh0Q3czNldTRk5IVVFUV05CNE16MWI4?=
 =?utf-8?B?dUQySDdwR3Z3V2JMenVLRXFvYytDS3N4QWdUMVJ3TGdPTmJkZzFxSjdBVXBu?=
 =?utf-8?B?Y2NGSFA1alFRY3RyMnozWGVFakpTVEVwNHZVcnAzbXdnbjR1YmhjVjZhY0Zv?=
 =?utf-8?B?S2MwOGQrb0ZMZlp4aEd2TWt4WkNXQTNRbE5kRjlMMzJLV3hGZCtEdlJMa1Yz?=
 =?utf-8?B?V201R0pUbmVZZ2c2ZzVjYlQ2K0pqR0JGVERPazh4UlRSMVRjdHNvbUowWEtD?=
 =?utf-8?B?c3Z0NDFnUnNPczlJcVlSUzFkOFFQbmZ6SDV4WmJhNTVvSHY2bGdJMWVDUDVz?=
 =?utf-8?B?cXJlVlpGeDBUdTR2ek5JYkVUQWJDV2pSYzBJMTVuUzdIUFkzZitYYlpRL0xs?=
 =?utf-8?B?TlE3VGJyUnA0TmRJRzFPUExjWWFLM0U0ZFBZV1lGTHVHTWJ4QUh1SG5QUmxy?=
 =?utf-8?B?ZkhicExxNnhueHJldUFlVXpYY21VZWF0OFVhV1Iya2xGbTlEN3hKczl6REJQ?=
 =?utf-8?B?cEs1cktIellnZ0s1bE5GbkhNWVpEMUtneXo0SWdjMEljcGVOM1lzV1BxRkcw?=
 =?utf-8?B?UkVDZGZjV0Fva1V6V0Y5OGVaUTRMVVUrZWF4T2xHbmUraTRXSnV0Y3RHKzdZ?=
 =?utf-8?B?dDd1ekgvdlA0N0R5MjBtNDMyUDRwRC9rSEpMSjhWcmhWNld3Tkx0MjZwNFRj?=
 =?utf-8?B?WW9VbGRndUVibWQxcGRLZThWRGVSY2U4ejJNL0d3YWMzSk9nTXplSmRDOEFN?=
 =?utf-8?B?RHJMYWpEM24xRDgxQlBGT1BBMzNZenY5SnJGSUpoRnJmZnNaYjdBZDJQRWtF?=
 =?utf-8?B?bDVXZlI0eFRZWGtEKzd5Y2QwbWNhSWd6RUtIQzRpb3JuVk16c0REQ3BLcWhN?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e04a72-0511-433f-2379-08dcacb0fd4f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 13:52:14.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euCFBAAnN3L5zzv5FyJrqOHALtl66h28yudfn531iiIFqc+HvENgshDoXRzNq0qmIujeVOpUE4PZ3OEbGJTcojXDVFbb7x07NMcBeeqp0ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6705
X-OriginatorOrg: intel.com

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Date: Wed, 24 Jul 2024 18:39:01 -0500

> From: Joshua Hay <joshua.a.hay@intel.com>
> 
> The rdma driver needs to map its own mmio regions for the sake of
> performance, meaning the idpf needs to avoid mapping portions of the bar
> space. However, to be vendor agnostic, the idpf cannot assume where
> these are and must avoid mapping hard coded regions.  Instead, the idpf
> will map the bare minimum to load and communicate with the control
> plane, i.e. the mailbox registers and the reset state registers. The
> idpf will then call a new virtchnl op to fetch a list of mmio regions
> that it should map. All other registers will calculate which region they
> should store their address from.

Pls Cc netdev and IWL next time.

[...]

>  /**
> + * idpf_get_mbx_reg_addr - Get BAR0 mailbox register address
> + * @adapter: private data struct
> + * @reg_offset: register offset value
> + *
> + * Based on the register offset, return the actual BAR0 register address
> + */
> +static inline void __iomem *idpf_get_mbx_reg_addr(struct idpf_adapter *adapter,
> +						  resource_size_t reg_offset)
> +{
> +	return (void __iomem *)(adapter->hw.mbx.addr + reg_offset);

Why so many casts to `void __iomem` if you already has mbx.addr of this
type?

> +}
> +
> +/**
> + * idpf_get_rstat_reg_addr - Get BAR0 rstat register address
> + * @adapter: private data struct
> + * @reg_offset: register offset value
> + *
> + * Based on the register offset, return the actual BAR0 register address
> + */
> +static inline
> +void __iomem *idpf_get_rstat_reg_addr(struct idpf_adapter *adapter,
> +				      resource_size_t reg_offset)
> +{
> +	reg_offset -= adapter->dev_ops.rstat_reg_start;
> +
> +	return (void __iomem *)(adapter->hw.rstat.addr + reg_offset);

Same.

> +}
> +
> +/**
>   * idpf_get_reg_addr - Get BAR0 register address
>   * @adapter: private data struct
>   * @reg_offset: register offset value
> @@ -740,7 +780,27 @@ static inline u8 idpf_get_min_tx_pkt_len(struct idpf_adapter *adapter)
>  static inline void __iomem *idpf_get_reg_addr(struct idpf_adapter *adapter,
>  					      resource_size_t reg_offset)
>  {
> -	return (void __iomem *)(adapter->hw.hw_addr + reg_offset);
> +	struct idpf_hw *hw = &adapter->hw;
> +	int i;
> +
> +	for (i = 0; i < hw->num_lan_regs; i++) {

Pls declare @i right here, not outside the loop.

> +		struct idpf_mmio_reg *region = &hw->lan_regs[i];
> +
> +		if (reg_offset >= region->addr_start &&
> +		    reg_offset < (region->addr_start + region->addr_len)) {
> +			reg_offset -= region->addr_start;
> +
> +			return (u8 __iomem *)(region->addr + reg_offset);

(same)

> +		}
> +	}
> +
> +	/* It's impossible to hit this case with offsets from the CP. But if we
> +	 * do for any other reason, the kernel will panic on that register
> +	 * access. Might as well do it here to make it clear what's happening.
> +	 */
> +	BUG();
> +
> +	return NULL;

I hope this function is not called anywhere on hotpath? Have you run
scripts/bloat-o-meter on idpf.ko before/after the patch to see the
difference? I'd like to see the output in the commitmsg.

[...]

> @@ -102,13 +107,34 @@ static int idpf_cfg_hw(struct idpf_adapter *adapter)
>  {
>  	struct pci_dev *pdev = adapter->pdev;
>  	struct idpf_hw *hw = &adapter->hw;
> +	resource_size_t res_start;
> +	long len;
> +
> +	/* Map mailbox space for virtchnl communication */
> +	res_start = pci_resource_start(pdev, 0) +
> +			adapter->dev_ops.mbx_reg_start;
> +	len = adapter->dev_ops.mbx_reg_sz;
> +	hw->mbx.addr = ioremap(res_start, len);
> +	if (!hw->mbx.addr) {
> +		pci_err(pdev, "failed to allocate bar0 mbx region\n");
> +
> +		return -ENOMEM;
> +	}
> +	hw->mbx.addr_start = adapter->dev_ops.mbx_reg_start;
> +	hw->mbx.addr_len = len;
>  
> -	hw->hw_addr = pcim_iomap_table(pdev)[0];
> -	if (!hw->hw_addr) {
> -		pci_err(pdev, "failed to allocate PCI iomap table\n");
> +	/* Map rstat space for resets */
> +	res_start = pci_resource_start(pdev, 0) +

Why call this function multiple times?

> +			adapter->dev_ops.rstat_reg_start;
> +	len = adapter->dev_ops.rstat_reg_sz;
> +	hw->rstat.addr = ioremap(res_start, len);
> +	if (!hw->rstat.addr) {
> +		pci_err(pdev, "failed to allocate bar0 rstat region\n");
>  
>  		return -ENOMEM;
>  	}
> +	hw->rstat.addr_start = adapter->dev_ops.rstat_reg_start;
> +	hw->rstat.addr_len = len;
>  
>  	hw->back = adapter;
>  
> @@ -155,9 +181,9 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (err)
>  		goto err_free;
>  
> -	err = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
> +	err = pci_request_mem_regions(pdev, pci_name(pdev));
>  	if (err) {
> -		pci_err(pdev, "pcim_iomap_regions failed %pe\n", ERR_PTR(err));
> +		pci_err(pdev, "pci_request_mem_regions failed %pe\n", ERR_PTR(err));
>  
>  		goto err_free;
>  	}

Why not pcim/devm variants of all these functions?
Have you considered introducing a generic API which would do something
similar to what you're doing here manually?

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_mem.h b/drivers/net/ethernet/intel/idpf/idpf_mem.h
> index b21a04f..d7cc938 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_mem.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf_mem.h
> @@ -12,9 +12,9 @@ struct idpf_dma_mem {
>  	size_t size;
>  };
>  
> -#define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
> -#define rd32(a, reg)		readl((a)->hw_addr + (reg))
> -#define wr64(a, reg, value)	writeq((value), ((a)->hw_addr + (reg)))
> -#define rd64(a, reg)		readq((a)->hw_addr + (reg))
> +#define wr32(a, reg, value)	writel((value), ((a)->mbx.addr + (reg)))
> +#define rd32(a, reg)		readl((a)->mbx.addr + (reg))
> +#define wr64(a, reg, value)	writeq((value), ((a)->mbx.addr + (reg)))
> +#define rd64(a, reg)		readq((a)->mbx.addr + (reg))

If you hardcode ->mbx.addr here, the names of these helpers must be changed.
First of all, I'd expect 'idpf_' prefix.
Second, they don't reflect they're for the mailbox *only*.
IOW, I'd expect something like

idpf_mbx_wr32()

etc.

[...]

> +static int idpf_send_get_lan_memory_regions(struct idpf_adapter *adapter)
> +{
> +	struct virtchnl2_get_lan_memory_regions *rcvd_regions;
> +	struct idpf_vc_xn_params xn_params = {};
> +	int num_regions, size, i;
> +	struct idpf_hw *hw;
> +	ssize_t reply_sz;
> +	int err = 0;
> +
> +	rcvd_regions = kzalloc(IDPF_CTLQ_MAX_BUF_LEN, GFP_KERNEL);

__free(kfree) for automatic freeing.

> +	if (!rcvd_regions)
> +		return -ENOMEM;
> +
> +	xn_params.vc_op = VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS;
> +	xn_params.recv_buf.iov_base = rcvd_regions;
> +	xn_params.recv_buf.iov_len = IDPF_CTLQ_MAX_BUF_LEN;
> +	xn_params.timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;

Most of these can be declared right when you're initializing the
structure itself.

> +	reply_sz = idpf_vc_xn_exec(adapter, &xn_params);
> +	if (reply_sz < 0) {
> +		err = reply_sz;
> +		goto send_get_lan_regions_out;
> +	}
> +
> +	num_regions = le16_to_cpu(rcvd_regions->num_memory_regions);
> +	size = struct_size(rcvd_regions, mem_reg, num_regions);
> +	if (reply_sz < size) {
> +		err = -EIO;
> +		goto send_get_lan_regions_out;
> +	}
> +
> +	if (size > IDPF_CTLQ_MAX_BUF_LEN) {
> +		err = -EINVAL;
> +		goto send_get_lan_regions_out;
> +	}
> +
> +	hw = &adapter->hw;
> +	hw->lan_regs =
> +		kcalloc(num_regions, sizeof(struct idpf_mmio_reg), GFP_ATOMIC);

1. Invalid line split.
2. sizeof(*hw->lan_regs) as the second argument.
3. Why %GPF_ATOMIC here?!

> +	if (!hw->lan_regs) {
> +		err = -ENOMEM;
> +		goto send_get_lan_regions_out;
> +	}
> +
> +	for (i = 0; i < num_regions; i++) {

Declare @i here.

> +		hw->lan_regs[i].addr_len =
> +			le64_to_cpu(rcvd_regions->mem_reg[i].size);
> +		hw->lan_regs[i].addr_start =
> +			le64_to_cpu(rcvd_regions->mem_reg[i].start_offset);
> +	}
> +	hw->num_lan_regs = num_regions;
> +
> +send_get_lan_regions_out:
> +	kfree(rcvd_regions);
> +
> +	return err;
> +}
> +
> +/**
> + * idpf_calc_remaining_mmio_regs - calcuate MMIO regions outside mbx and rstat
> + * @adapter: Driver specific private structure
> + *
> + * Called when idpf_send_get_lan_memory_regions fails or is not supported. This
> + * will calculate the offsets and sizes for the regions before, in between, and
> + * after the mailbox and rstat MMIO mappings.
> + */
> +static int idpf_calc_remaining_mmio_regs(struct idpf_adapter *adapter)
> +{
> +	struct idpf_hw *hw = &adapter->hw;
> +
> +	hw->num_lan_regs = 3;

Hardcode?

> +	hw->lan_regs = kcalloc(hw->num_lan_regs,
> +			       sizeof(struct idpf_mmio_reg),
> +			       GFP_ATOMIC);

1. sizeof(), see above.
2. %GFP_ATOMIC, see above.

> +	if (!hw->lan_regs)
> +		return -ENOMEM;
> +
> +	/* Region preceding mailbox */
> +	hw->lan_regs[0].addr_start = 0;
> +	hw->lan_regs[0].addr_len = adapter->dev_ops.mbx_reg_start;
> +	/* Region between mailbox and rstat */
> +	hw->lan_regs[1].addr_start = adapter->dev_ops.mbx_reg_start +
> +					adapter->dev_ops.mbx_reg_sz;
> +	hw->lan_regs[1].addr_len = adapter->dev_ops.rstat_reg_start -
> +					hw->lan_regs[1].addr_start;
> +	/* Region after rstat */
> +	hw->lan_regs[2].addr_start = adapter->dev_ops.rstat_reg_start +
> +					adapter->dev_ops.rstat_reg_sz;
> +	hw->lan_regs[2].addr_len = pci_resource_len(adapter->pdev, 0) -
> +					hw->lan_regs[2].addr_start;
> +
> +	return 0;
> +}
> +
> +/**
> + * idpf_map_lan_mmio_regs - map remaining LAN BAR regions
> + * @adapter: Driver specific private structure
> + */
> +static int idpf_map_lan_mmio_regs(struct idpf_adapter *adapter)
> +{
> +	struct pci_dev *pdev = adapter->pdev;
> +	struct idpf_hw *hw = &adapter->hw;
> +	int i;
> +
> +	for (i = 0; i < hw->num_lan_regs; i++) {

@i, see above.

> +		resource_size_t res_start;
> +		long len;
> +
> +		len = hw->lan_regs[i].addr_len;
> +		if (!len)
> +			continue;
> +		res_start = hw->lan_regs[i].addr_start;
> +		res_start += pci_resource_start(pdev, 0);

Again calling this function multiple times.

> +
> +		hw->lan_regs[i].addr = ioremap(res_start, len);

devm/pcim/etc.?

> +		if (!hw->lan_regs[i].addr) {
> +			pci_err(pdev, "failed to allocate bar0 region\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}

[...]

Thanks,
Olek

