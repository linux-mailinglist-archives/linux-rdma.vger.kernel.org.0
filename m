Return-Path: <linux-rdma+bounces-8758-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE308A65F67
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 21:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA94189EF69
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 20:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF891F5842;
	Mon, 17 Mar 2025 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6xcHGE3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DDC146588;
	Mon, 17 Mar 2025 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244120; cv=fail; b=YNpo0A0cTN0sJ7LjE1m1Z2DSEM9D/J6qILQ2gCmDe4LWaxUQbudUytwir8SWauv1BNONP92l6B6m32wL62O/A0vkCmAsD2005GKxtVN/5YNSLO6jp/Tv+EU7h3xGEoez74OzpbVkHNHJn9w+uPhQdtys72S8IYoqDB9XXObn1zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244120; c=relaxed/simple;
	bh=Zt2L1lx79DswRwDvDAwcTE6aAwP8tn+zFwxlfEVLmcw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dKJlUWFXcVR/Sk42ZK/FKWsREDtACKL4z2USIxohjl9vOSoBBmekSHungeBaK2xkFZfyoHKIuuhyvWZ202B4vtxSM7yMjA2fG5MBKHmRRA/jUpoyCfvjYQ3VO7NVQqK9P6Ag/VK5itFY0/ErzgpIRb0dTgYn/N8NPFwA+nZ9aKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6xcHGE3; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742244118; x=1773780118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zt2L1lx79DswRwDvDAwcTE6aAwP8tn+zFwxlfEVLmcw=;
  b=J6xcHGE38jho8JfJFAtwtTNCP9yJyThmBYcSJeQV6AcATQlJyix1o0DV
   2XBNXtBXI1NOLYWUmTtQMa88G7AUSYHFVZLI0p6hIO1qk1KXM3yN8GDTO
   j8IuB723SaZ8IIumUapAdiiY2OXRzV/s9YH6p5uyUsKygFCP1usTgO6Hg
   tuxBQLlllY8bwgiHIeYhlvNJ+qS6ROWUNxMbfoDPHHCWiK0g5uYV1OzIp
   7jUdjtqVe4qOJjbQPhBvAslsa6H1KkhW9URaP5e8hpg6Uoqes27XlVAdB
   jYtVRHoFAClZmgdIK6XQc7WM6c3V5AB4o/83PptiPl1m3la3arp3lDtHd
   Q==;
X-CSE-ConnectionGUID: XkRkpUCdQaKZQQc6BC+pEA==
X-CSE-MsgGUID: tnhcUgVSRhaURwGjkEUl7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43244408"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43244408"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 13:33:44 -0700
X-CSE-ConnectionGUID: A85ox0NZSmyj3JamJR+3Xg==
X-CSE-MsgGUID: rIo/ipiMR5S9kpP+gwwcYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="152901585"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 13:33:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 13:33:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 13:33:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 13:33:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Etw+7bNATGbFu51ERAogBbAjmAF9+3rYxtisDZqdXv/T/tCsR+Na0DisMZL3wiQTVR8pMM1I1wUn2J7Lxndnu5bEa5paFFIQYB+y9AKo9W5oFJF0R7c6Jid7QarZj+SJWtoMrQx3be18CfmGbluOAN0mpkEIBT+rj6psihjMpyI2j9qEButE861FtqRLR0QOW/BQBGC9vcWbiiQ90M/np+Ga2rRnww0p/aKKnZYv339H60uup/qLiceqkRB42SerWD72Ddae8kiUJQlM71q5yGP96kOqu244kwONuMe0bzOApwmrHT1GYBNDlr/IkKqMtEf187nZUkama7HQoucegA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt2L1lx79DswRwDvDAwcTE6aAwP8tn+zFwxlfEVLmcw=;
 b=jHpaVpcLBKuQaMG13XDqnzsfA2mz4gOGUkd3OCnHrPhW0p9wknK2ny6VgBoHLNrvLnsKA3i5kzu+TAONV4SaQdw9MfCRNBYClKGqAbZCiZcG3QWnnn7NEOJET5P/VcAmbXwwHmhIi9mlRln8uYKb/9TGWO3ivjdb1Rv71tv9dshwH5Cf6cRARhyPzSvFcr5ZYfqawjjnSEQ4eNNKYayy1bfMcbYY43/0SDpyu87Izu0rFFJBh73XzkFJdqkRQ17KvmKwd4Erl03adF7cdjFWXv6envY14qXVVnV+H7obuzOlpk2wpd5UqK6jrTuW0f0ExmZL36DaGOgMF0l1PZKX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN0PR11MB5985.namprd11.prod.outlook.com (2603:10b6:208:370::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 20:33:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 20:33:04 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: "Nelson, Shannon" <shannon.nelson@amd.com>, Leon Romanovsky
	<leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski
	<kuba@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Andy
 Gospodarek" <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>, "Jiang, Dave" <dave.jiang@intel.com>,
	Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Sinyuk,
 Konstantin" <konstantin.sinyuk@intel.com>
Subject: RE: [PATCH v5 0/8] Introduce fwctl subystem
Thread-Topic: [PATCH v5 0/8] Introduce fwctl subystem
Thread-Index: AQHbiXePa8N9PItF+EWGRwtFqKO2hLNiPacAgADLBACAALM5gIAA118AgAAaqYCAADTOgIAAAzuAgAwuoACAAAUBgIAAeEcAgAFzvoCABFkNgIAAbCyAgAAZqnA=
Date: Mon, 17 Mar 2025 20:33:04 +0000
Message-ID: <CO1PR11MB5089AB36220DFEACBF7A5D1CD6DF2@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org> <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>
 <20250313124847.GM1322339@unreal>
 <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
 <d0e95c47-c812-4aa8-812f-f5d7f6abbbb1@intel.com>
 <20250317123333.GB9311@nvidia.com>
 <1eae139c-f678-4b28-a466-5c47967b5d13@kernel.org>
In-Reply-To: <1eae139c-f678-4b28-a466-5c47967b5d13@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|MN0PR11MB5985:EE_
x-ms-office365-filtering-correlation-id: 9ac9762b-a661-47b8-d1c8-08dd6592eb83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZXpwZ2JBTisxRjM1cENJRUpVazc5Qkk4S1R5R2lPeDNSYVo5TWZrOHFObzdu?=
 =?utf-8?B?S2hIMDJvZXA1bmltYUtPWFh4RmZaSGVlMTNVTTd2Y2xoZW01NmVDTUVxTXhV?=
 =?utf-8?B?SlJwYVlWeW5iOENEZjhXS0ZWUUtqZXhYMUd6TS9FL0dVOE1UTXRWaElLRndO?=
 =?utf-8?B?Q1RWcGkwdE9wb2tuamVCN3pReVllcCtZa3FscUFBWjNXU0xwUlRrYVQwdFl6?=
 =?utf-8?B?cy8zNlpnTzVsdlluY29KbzZBUUtZY0NSVENiY3BkdnN5YkJqc1dza1l0YmNv?=
 =?utf-8?B?WHhKMUwvdUZSWWpmeWZ3VU9pQUEwZGtJZDYrYVdsbmd4Y3gra2xKN09XeWJO?=
 =?utf-8?B?WGV2UWlIZ0s5Q2VnSDB0UXozYTE4STVCNGFJaFZxbUYybThEclVpNEZJSVBn?=
 =?utf-8?B?LytJWkJpZi9sRUxJRjdLSFdQQmp0VHVXWWU2UjRPTmNVcGRrYjVyOFpGOFJt?=
 =?utf-8?B?T1IyU1ovUjc1QUY1bHdTSWF5TTJFc2hyTEI0ODBpYnBMZktJTGs3WGxpS0pE?=
 =?utf-8?B?aWhocHhLMTE0bUd6OCs5MXdPTi9RWlk1c3NzdHN2ZEkvYjJSNVIvckhkaFE2?=
 =?utf-8?B?ME5Pcm8vRVJ0Z09MZElZL2R2UXg5VXpuQTNKcjEzRUovN2NCL2thbG0wS3o0?=
 =?utf-8?B?b1RpUnE5NkNXblhqLzZ5c0UycjBVNlIreWI5K016WlN6VUdYU2pUQzIrMjRO?=
 =?utf-8?B?NVQ3NkcwZEVvSm9KdlJ4YWY5NTM1SVl2NWRsTk5QL1JFTnNFM0dLT0JiTlor?=
 =?utf-8?B?VUJIbXVpOWZPTmxlcHhybHR0SmNJTGtmSHNsWnFFNWc5SzFPNGEyNEhld2t2?=
 =?utf-8?B?bktSd2k2VHBPWW5QT0dpWXpDTVY4Vm1hTVVKWGpSRUlJK2Flak52N0tIVGhS?=
 =?utf-8?B?ME4wbDZQRWxZMEtiYlNGRGxOTzZocXEzNVFITTdOTFFvN2hzb0t2ZEtldXJE?=
 =?utf-8?B?dTEyb29mRlh2L0NGNzBlQzVXZjVKTGlBQVNHejBFbUwwYW0vUHQ3SnQ5WEdh?=
 =?utf-8?B?d08zZG5YcUZtYS9oemE0aXQva0JyWHBXVHIzKzIvbEdobTI1SnhFbGV0UHgv?=
 =?utf-8?B?ZVNWRmpkOXVUWEliQU9kczM4ZE9sa0pPVno3dW1RcDVrRjFVeFJZSEc5TTUy?=
 =?utf-8?B?SHNMekcxaVRLRTUveXF2bmtCdGphLzQ3eURBajZTRU44M0Qyc3VXR0tJTzI2?=
 =?utf-8?B?cXNnS1VmMlNCZ2xkRDdOL1NRUWpxdnlUN3JXTEJHRk1uT0gvZXdkNXBDZlJT?=
 =?utf-8?B?aHdPVytkZU9UQys1REZlNHBDekEwR0NkM3RlTEdzUjZyeTRnZ3FUajlZSS8z?=
 =?utf-8?B?L0RrLzZZaTNiVUpHZnAwejlyclNCam1YSlJmL21YSWVSa3JZOEJmRnllVG9R?=
 =?utf-8?B?a2s5M1RyMllqY3IxWVNiWThoaGFJZjFTNHdpNE9QUmxYSU5QNzBNSFIzTGZx?=
 =?utf-8?B?L2JXYjllaTJiWWJRSG1UVlYyTmRnbVdvM1pEdGRJT0h3NXVhUUR4ZmRvSmdH?=
 =?utf-8?B?MlhrRENpQ3QvcG9ZRk5sMk1UazdoK1BCWWxaNUNZbnFXZkZvVE92SEFlRkxi?=
 =?utf-8?B?Z3pSYThtMXlQTStSSFZURUZmY2Z0bHczejAxYmV5WjNRQ2Fpa3dnWU55ZmFo?=
 =?utf-8?B?dFA1aTBwSEpKdllVZ0NPUjJkaXU5dWhjYWZjZFN6dzFMdGpOUC9aYXBqVXNk?=
 =?utf-8?B?ZHVmWUY1UitBckJtK3BkbUlPaFJkNFArY3FLOG9FSkQ4MlN3bXA2a01aV2ox?=
 =?utf-8?B?WDhwSFV3Z3dkUzQyTi9GT3Y0bW5LVjAvWUpCV1dOdU42VmwvTHR4ZmxZOHJj?=
 =?utf-8?B?TUZvajcwenV4MnRKZGVmN0RHK2tpT3dIWEFxRWl3K2c1dU5UNERBTGR6RjNG?=
 =?utf-8?B?WDMyMG9BMi8rVjRqMWtiOXF1VWJ3SG9iL0hrSkZvUXhpWHkvc0w2SkJMRExM?=
 =?utf-8?Q?UglH1hSE/8/DtwyPrxtrdjML8UZhwFzY?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHcwMm54Q3dRVk8wS09PRFJFNVU4QzFoc0VnUGhVeFg0NFE4VUVXcUdPdzJa?=
 =?utf-8?B?Q25IMUtLU0xLbGdxaEZycjlIUzlHV3dTRXJRZlR3MUlRZllEMnZQeUZQajlr?=
 =?utf-8?B?b1U4b0x6a2IxR2xYbVZsV0prYWdNdFJlOG9HZ1p3UTltZFpYVDhTMC9aeEFp?=
 =?utf-8?B?anNWUE1ybmZDMDQ1aW9JZUJZTWZkdStjSkYzeXEwVCtSS3J3WkFWOHk3M2JW?=
 =?utf-8?B?b0VTa25nenNONE0vWnU4VmxXaWd6Rk9qd2pZVDJVZC9YbHhxWXFHUXE5ajhS?=
 =?utf-8?B?MS9PYXN1dVhVV3ZNbklGYmh0UnBWWDJaa2JidHMwMHA4THhTK2k4dkFoNHFm?=
 =?utf-8?B?aHlCaHVVa1dZMDlBYmIzMjQyUHkwTDhOYTFDUHJkaXc1dW1iSDJLMjN4S1Zo?=
 =?utf-8?B?dG1PSjFQYi9HVGxkMWV1MlN3OVllSnIvcXJCWDduKytlSGdaVEdiYlhWcXVC?=
 =?utf-8?B?aDNUbUFZVnp5Sk92NDNRd1Z1MzZWZ2U1SHRZNEtWSHU0cmNrOUFIenpTSDBt?=
 =?utf-8?B?RHYvY3N0OGxZRkhpL1JXaW0zaFd6c1Q3RVpqQ1hNSHpBcGYvOTk4R0x3THhM?=
 =?utf-8?B?ZGZ4NWltSk9udjFNVkFRSVJjYW5jU3JUcHNTZWV1VkZWQVhPL0Z3NUh3Q0tI?=
 =?utf-8?B?MkxTU1RyandBZ2ZMOE9IY1g1cEp0WE80a040U0Jkc2k1R3d5SGI2ZGdhUmR3?=
 =?utf-8?B?UVRuelg4T0o1QklXblNOVnBzRGwrL3o2Sy81L3hyT0U5L0ZYTXVnMCtQWFMv?=
 =?utf-8?B?YWlqMmdvSnZmMHhsMzdNR0hLTWQ4ZkR2TFBFVlR1NVJVM1kwM1dBV3ZhRUlF?=
 =?utf-8?B?WGhpemVWeEZwRENKQWZjOUsxRjR1SndNbHVyQVArWHE1bVRQQS9xS2RtQjRO?=
 =?utf-8?B?ekRRbXdZWVVqMlVpK01kZm9MaGFPdVNIRUVCbkNtSmhMY3lmbjYxNzRYZnVi?=
 =?utf-8?B?NHZ0YzkvWk9oa2hUMXB1ZzJxWDdsNVhLWWNKQlV2T1FiNWxldHhWZE9YNC8v?=
 =?utf-8?B?MXprd0djQ2tVY3VUcEFUSzhOSUErU2xOUVRPRS9jMlVsTElMeDA5QUdKQnEx?=
 =?utf-8?B?WldhQlhkOFlKNGhtVnM0ZlA0UndxeVdzcjVSNWNpcHlOQ202YnZ3RkJGSzlv?=
 =?utf-8?B?RW9UUWl0NHd0bG4vbVZuWmFNeFdwZG91dDU4WHU0L3NjczBiV2NPTk0zendR?=
 =?utf-8?B?bU9JYkFqVVhLMnRQa2FscFUvUTg2WUhMU0VDSFY0ZlF3ZHlVQmM1MEV0aGhp?=
 =?utf-8?B?KzYzNlI0VlVlNy9hZTRLbE9ObVZObU1odTI0Z2ZTZk5zMFlKazY0a0V4SUFL?=
 =?utf-8?B?UDlTV2FJQUlER3RxSHFrQjBmbG9VRC9VUnArNkhjZGgyK0NKQ1VMTnphZkQ3?=
 =?utf-8?B?ZmVWUUx1ODBNWkJFNUN0UE5qb0RLdG80eHduL0tjOUFPaElLYlRlTkNPT2Fa?=
 =?utf-8?B?YkRuTDgyamZrRTN4WmJRNGlGMDZIaStZTFVxWFFlbGRHcWovekM1OHoyM21l?=
 =?utf-8?B?elZ2WVlUZmt0elZUUjU5YWIyc3A1RFpMTm0zVnliYktxb0tsa2NBN0RkU3Y3?=
 =?utf-8?B?M3N5NEZVc3UrM012WFI1N2w1eUVoekFuNE1zcHBNaVZIczBVbGtqUEhuMy9B?=
 =?utf-8?B?NjArbHRRY2wyYTFwbFQrK2ErSTNFWlVDSUxzQkxyaitDMVIwMTY1WHdjUTI3?=
 =?utf-8?B?bmovcmNVTTgzSGgzTnlOTUF1UG9ZcWx6MWlXcWFmN1VxeDhwL2kyU3c3dUtN?=
 =?utf-8?B?QWFGV0I2REtlaUZ4TFkvMEk2Wlg0cHpQZ3NqenJ5RmovbVhUWnl3ODVKNlZ4?=
 =?utf-8?B?TjFkVkFkL2RUYUF1ZEpJbnBoUExINmtnQTVFb2tkT1JIRW5FMzFMdWtKdnJu?=
 =?utf-8?B?MDZsRlhtbWZFZno2L1E3RDZKckkzRERvRE5iWE82Vm5xbGRDTFJMZ0x4QUZx?=
 =?utf-8?B?OS84OWFCazlFV0VCWW1rcExpL0xpSDBWS3dKMkYxN3RwcWFPY2UvVE9JZnFJ?=
 =?utf-8?B?a1JBc3pBVllPVHh2QndEa1cvVEdiVnZPZlF3TzZ2K0dNK0NKd05VNGw5ekUx?=
 =?utf-8?B?M01DYThWL1JJVzF4dDRqQVEvZjVwTXpZVzZjbWMrMmV4QkN5MjV6NXplbTlM?=
 =?utf-8?Q?F7SS7z1wmosSR+td7MIwBSnpt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac9762b-a661-47b8-d1c8-08dd6592eb83
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 20:33:04.7369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZptKaSJpeuGYN5+e/rXM3UPbVwtq1XpaKO9YzPxEKPb/EaZI5TtFbABUx4ZjyZD76efCdeU3h/JoNNEncC8YXcLDAAmVTBj2uoiO3GTQJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5985
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgQWhlcm4gPGRz
YWhlcm5Aa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAxNywgMjAyNSAxMjowMSBQ
TQ0KPiBUbzogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IEtlbGxlciwgSmFjb2Ig
RQ0KPiA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBDYzogTmVsc29uLCBTaGFubm9uIDxz
aGFubm9uLm5lbHNvbkBhbWQuY29tPjsgTGVvbiBSb21hbm92c2t5DQo+IDxsZW9uQGtlcm5lbC5v
cmc+OyBKaXJpIFBpcmtvIDxqaXJpQHJlc251bGxpLnVzPjsgSmFrdWIgS2ljaW5za2kNCj4gPGt1
YmFAa2VybmVsLm9yZz47IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+OyBBbmR5DQo+IEdvc3BvZGFyZWsgPGFuZHJldy5nb3Nwb2RhcmVrQGJyb2FkY29tLmNv
bT47IEFyb24gU2lsdmVydG9uDQo+IDxhcm9uLnNpbHZlcnRvbkBvcmFjbGUuY29tPjsgV2lsbGlh
bXMsIERhbiBKIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+OyBEYW5pZWwNCj4gVmV0dGVyIDxk
YW5pZWwudmV0dGVyQGZmd2xsLmNoPjsgSmlhbmcsIERhdmUgPGRhdmUuamlhbmdAaW50ZWwuY29t
PjsgQ2hyaXN0b3BoDQo+IEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPjsgSXRheSBBdnJhaGFt
IDxpdGF5YXZyQG52aWRpYS5jb20+OyBKaXJpIFBpcmtvDQo+IDxqaXJpQG52aWRpYS5jb20+OyBK
b25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+Ow0KPiBMZW9uaWQg
QmxvY2ggPGxibG9jaEBudmlkaWEuY29tPjsgbGludXgtY3hsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtDQo+IHJkbWFAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBTYWVl
ZCBNYWhhbWVlZA0KPiA8c2FlZWRtQG52aWRpYS5jb20+OyBTaW55dWssIEtvbnN0YW50aW4gPGtv
bnN0YW50aW4uc2lueXVrQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAwLzhd
IEludHJvZHVjZSBmd2N0bCBzdWJ5c3RlbQ0KPiANCj4gT24gMy8xNy8yNSAxOjMzIFBNLCBKYXNv
biBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gRnJpLCBNYXIgMTQsIDIwMjUgYXQgMTE6MDk6NDdB
TSAtMDcwMCwgSmFjb2IgS2VsbGVyIHdyb3RlOg0KPiA+DQo+ID4+IEknZCB0aHJvdyBteSBoYXQg
aW4gZm9yIGRyaXZlcnMvY29yZSBhcyB3ZWxsLCBJIHRoaW5rIGl0IG1ha2VzIHRoZSBtb3N0DQo+
ID4+IHNlbnNlIGFuZCBpcyB0aGUgbW9zdCBzdWJzeXN0ZW0gbmV1dHJhbCBuYW1lLiBIb3BlZnVs
bHkgYW55IGlzc3VlIHdpdGgNCj4gPj4gdG9vbGluZyBjYW4gYmUgc29sdmVkIHJlbGF0aXZlbHkg
ZWFzaWx5Lg0KPiA+DQo+ID4gR2l2ZW4gR3JlZydzIHBvaW50IGFib3V0IGNvcmUgZHVtcCBmaWxl
cyBzb21ldGltZXMgYmVpbmcgaW4gLmdpdGlnbm9yZQ0KPiA+IG1heWJlICJzaGFyZWRfY29yZSIs
IG9yIHNvbWV0aGluZyBhbG9uZyB0aGF0IHBhdGggaXMgYSBiZXR0ZXIgbmFtZT8NCj4gPg0KPiAN
Cj4gTm90IHNlZWluZyB0aGUgY29uZmxpY3Qgb24gZHJpdmVycy9jb3JlOg0KPiANCj4gJCBmaW5k
IC4gLW5hbWUgLmdpdGlnbm9yZSB8IHhhcmdzIGdyZXAgY29yZQ0KPiAuL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3Bvd2VycGMvcHRyYWNlLy5naXRpZ25vcmU6Y29yZS1wa2V5DQo+IC4vdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvY2dyb3VwLy5naXRpZ25vcmU6dGVzdF9jb3JlDQo+IC4vdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvbWluY29yZS8uZ2l0aWdub3JlOm1pbmNvcmVfc2VsZnRlc3QNCj4g
Li9hcmNoL21pcHMvY3J5cHRvLy5naXRpZ25vcmU6cG9seTEzMDUtY29yZS5TDQo+IC4vYXJjaC9h
cm0vY3J5cHRvLy5naXRpZ25vcmU6YWVzYnMtY29yZS5TDQo+IC4vYXJjaC9hcm0vY3J5cHRvLy5n
aXRpZ25vcmU6c2hhMjU2LWNvcmUuUw0KPiAuL2FyY2gvYXJtL2NyeXB0by8uZ2l0aWdub3JlOnNo
YTUxMi1jb3JlLlMNCj4gLi9hcmNoL2FybS9jcnlwdG8vLmdpdGlnbm9yZTpwb2x5MTMwNS1jb3Jl
LlMNCj4gLi9hcmNoL2FybTY0L2NyeXB0by8uZ2l0aWdub3JlOnNoYTI1Ni1jb3JlLlMNCj4gLi9h
cmNoL2FybTY0L2NyeXB0by8uZ2l0aWdub3JlOnNoYTUxMi1jb3JlLlMNCj4gLi9hcmNoL2FybTY0
L2NyeXB0by8uZ2l0aWdub3JlOnBvbHkxMzA1LWNvcmUuUw0KDQpJIHdvdWxkIGd1ZXNzIGl0cyBw
ZW9wbGUgcHV0dGluZyBjb3JlIGluIHRoZWlyIG93biBpZ25vcmUgbGlzdHMsIG5vdCBuZWNlc3Nh
cmlseSB3aGF0IHdlIGNvbW1pdCB0byB0aGUga2VybmVsIHRyZWUuDQoNClRoYW5rcywNCkpha2UN
Cg==

