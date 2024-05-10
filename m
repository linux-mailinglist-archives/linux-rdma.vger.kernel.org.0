Return-Path: <linux-rdma+bounces-2400-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEF78C2524
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 14:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847791F25AEB
	for <lists+linux-rdma@lfdr.de>; Fri, 10 May 2024 12:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8689B127B7A;
	Fri, 10 May 2024 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzXGRain"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407C4127B5F;
	Fri, 10 May 2024 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345701; cv=fail; b=t3yvKnZC878XeJrq4pyh89tK2X84o5Kw4efOOGE+5BwXCzx5K5FJMwkxPWz5H7h2HbmibSC8ZqDMpEB+xQkmkew4gfIYpZpKoCawqPXT4m5S2WF1QNF+jJ29xVwuwllKsRrvNZAg3U9tYRgS0F8Re0ToofQMO8TRuMQEfIhACwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345701; c=relaxed/simple;
	bh=pRbIUaHsquY8u4Aah01HqvXWPRmLd2GYTpsImxFXDNg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qhzLJg+aTEZdb8zTjLoYtbuoLIOdh96TLRGUCKUHHpdQhslFqwrB7MkB7ZhcEx1NwjEnAAYQ4ueZXNIBmBWAu2sQDVh/jicV6ctjkyRk4A8+XbAQThMwJ+UQLu9UB8EMAOj2OhcOS+O/oR+Ywl4vbAM9uXnxSr326o1MvGNCA3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XzXGRain; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715345699; x=1746881699;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pRbIUaHsquY8u4Aah01HqvXWPRmLd2GYTpsImxFXDNg=;
  b=XzXGRainXP3FQG58qfSlGtZe1CD6ni347dc4e7S+RJ1OiOtA2OovDzeB
   xTZOQV0Qc6kqRwjRjwe624d5VlzwZ75nOHb9cCR9P7DCzhQu6PF0s5Aax
   Gd9x57pGQv4ari00pNJvcFGDMPd4nEgI2gOWuuRxirIi8ZxT+5AvuLiU6
   CZk+M1UVXYtg5U3yCXsD+AFeqPQdE5Ux73e0+vr3nBoqYBC923hxmKpf3
   jCCQt7SYJi3hxwsxNZ68m1unjbVT5K2oPJkTxMQpLQ5iXlDwzehQaomQU
   pYo767J1bz1C0r+RxaWFeL+4+PlPb/PsiVxEATTqY2lrY6AVy8nEzA/h3
   Q==;
X-CSE-ConnectionGUID: nmboYG33TCmjq7xBDApncQ==
X-CSE-MsgGUID: IVejFzODRKaUbB5COlFM1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15135530"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15135530"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 05:54:58 -0700
X-CSE-ConnectionGUID: mHCo2PQMRdWmbXR7vMV+Uw==
X-CSE-MsgGUID: pivWDXq+TD6iszJvKi4yPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="52816789"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 May 2024 05:54:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 05:54:57 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 05:54:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 05:54:57 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 05:54:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AL7yNXFu6KRhMnF+k7FIggyimERoccJXSN0I5QnW2s4QvGmq8LKW+zN/kExjU/W5XMbG1IRMFLqOPLz1UQdmx5jol3jcbbhZAyQGnYhiUS3NPfH6NIJKLTWmKTI/T0goFjUki4GNgb6FhikurXTn3BIqjv7otf+oaAE9tPC0j4DIfO9mQ1fSNcwiW0iV+C1vz8pR61evzkesORdIJNoGBWZ08x6P84HsHc06xu8nITW+qxNrceUy51MH3H0QXAsRKBpw8P0Z+WYAXtuKoI/ELnpr4auAAEwN+FIGJX2viF01R6gm7ub5gZ6zPaatm8vDXdW9HX3HmCN+BG/vjkG1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qwf0hJTYskOy/Bqucxe/NLajqT2ED/4IEF3BQ28/82s=;
 b=aNlhw7gv213IZUusV9WvUxA5Z71dPtyZtdnTzMHaudCmyt+h6Gwg/90dJ8KjNh/jEjymVyNjG0359IqKWtynoC0phVQSTGq5mYPxUBncf4gyvQc7G0hVv7UfIQUePgDw5U79wo2jB7/7y0j0iS3TLimpFOZcCWdOE6oOFmRof9REeIIR9g3eU9ef33RYiGLTFhC2EPlbOU9dRxVECpsrJlrbZO0QZMvF3zD+Idq8s0QXxZiSCJ7ZRS5pkkqopKzfMY+LVkhZE8fxiXwalF5/kUkGbg8QuOO0W17OpO65AV7iI1qo4L9rpTC+0SKBXQaFBnPSBWFOTLjmRnZ0Ncr0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ0PR11MB5199.namprd11.prod.outlook.com (2603:10b6:a03:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 12:54:55 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb%3]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 12:54:55 +0000
Message-ID: <22533dbb-3be9-4ff2-9b59-b3d6a650f7b3@intel.com>
Date: Fri, 10 May 2024 14:54:49 +0200
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
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <2024051056-encrypt-divided-30d2@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::23) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ0PR11MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: b6701776-3e84-400a-7639-08dc70f063c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzV5c04vOU5CbnFUT2E0WjIrc3g2L1c3SkpXd2ZRUWtqLzBtMEp6OEIxT2l4?=
 =?utf-8?B?QkJrbldDNGJFV0NkQXdxY1FzejB6T1FWeDVNR3BTemR1bVdUWDBkZlRxbVN5?=
 =?utf-8?B?amtvSDN3TmNRa0E1TmRJREpyMWZrR2lmVE1jMWxMNlhjUUd5Q0hFb1lnck5D?=
 =?utf-8?B?ZHkwSDRyMmpqbVlQeTJvVStzMXY3M0tpNTVlY1o0SVpyQ2I5a2k2UWxNenR0?=
 =?utf-8?B?RXZNNjRMdTREVVRJeDR3TXZLdGJsdStxYjBGTEp2ZXVPcWp0dUdWY2RCRllR?=
 =?utf-8?B?cFZYWVdybkg2NCt1VmR3a1B5ZElaUGF1aU5mNUlJVHFmQWJTYVNvTUtSMGta?=
 =?utf-8?B?a3VwZU1VYkhZSkJGOGNrSGRXMnI2SXJvZGp2YUNiMTM1aGVZb1dXTmpKTDBC?=
 =?utf-8?B?WEt1aDd4MDcrRHVHclQxT0pLemxoTEpQVmV4R09wQjRwM0tKUnJST29pcmJo?=
 =?utf-8?B?ZUU3OHBuWVVZeDU3MENSTk8ycHRUUmE3MUNiOEdWeFlIRUR3dFREV0dIUGwy?=
 =?utf-8?B?d2ROcEtYQ1VJVmErZ0d2bUxWVHBDZlJSYWp0VlFLUCtNOE8wQVZsYnk0MUhi?=
 =?utf-8?B?dlRhVkoycDhIalFpczVoeWhYZ2tFRzRrWm83OS90WEV5ai8veEFhZ2xyL1Ux?=
 =?utf-8?B?blhWc29DeDRXcXNBZHBwZlZWTXJDOC9WN3hWRldJV0Z5dUNrWmhnV3RxN2RL?=
 =?utf-8?B?Vks4SEU2OWZZZU01UGVDT2hsemp2ZUdKcENIcnFQRW5leml2bndGQTZwSW5B?=
 =?utf-8?B?YkxWbUhCOUl5SDZmYVd5aG1IaXdkMmQyMFJ0eS81aWcxYlRQRFVEUEwvbmJQ?=
 =?utf-8?B?Y0llMktXTmZrWDR4RjAwdXZ2VVhKQnFmcG1URFNZZE1PQno4aExIemNkR3Jh?=
 =?utf-8?B?Q0VnWUlVRTRZSk5BNUJ2ZDhTUWgvRnA1ZkVwV2x5S1RQbzg1SlZyMEJhWXIy?=
 =?utf-8?B?OWduVVZFcWpNL09sTEZ0MXVLcGdqa21yUU5KbUY2VldZUjNqNTRRWUNJSWIz?=
 =?utf-8?B?MmR6aEhxSFltUGZxalN2bXp1dW1DNUpCYXlsVVNxSVpVWEQ0aCtQbDZLMEFC?=
 =?utf-8?B?eks5S0pQQVN3UGlwK3V0WWhtMVZqUXJpRTcwUVREQkN1RzFTendXQkNUeENO?=
 =?utf-8?B?cHJoc3pqZmtjRnFwRk1qM0FMem91OWdVektRalZDY2hEcFR1N1l0cVRLZzhr?=
 =?utf-8?B?UFlMb1VPQjlFNHdaMERUSGE4WUZITGtrMlQzY2R2VDJNNGZlQ05oZml4WXVu?=
 =?utf-8?B?VHJrVEdIRDBvMmxWU0YxVWVZMjVSY2xLeEtyV3hSdEpkM3ZlNnFya3ZXWW1w?=
 =?utf-8?B?R1ZTYzN1NU5kZTR1UGIzb2tSNU50d1pDWXJoQXhZYjROQlQ1eVAxVzZCczNr?=
 =?utf-8?B?M05WaWEreHozSlBRWjVmTlZCdm5yNWx0cGhGUUhGMmxtU0E2aXRkOStmOElR?=
 =?utf-8?B?TlBObnJORDIwQTlLQ3ZYMDI0Q25Eb2czblh2eGVIbk1LQnB6L2pxTURHVTBJ?=
 =?utf-8?B?SklwT3VQZlNzQWxKdzhJVEdlL3lyYlF4L3JWMjN5Nm1Id1VyT053dUExdU8v?=
 =?utf-8?B?ajZ2cy84WXlWSEdYOTg1VDRNRjhFQzdpc3VjdkVYcjVVeVRqMGgzTjBFVnZ0?=
 =?utf-8?B?ZlZ6WVNUUlRRNzBYcXRhbnVyeldsQWsrUng4SFltWllVNXJKNnd5TEF6aFgr?=
 =?utf-8?B?RjZBVk1UZVAvcFo4ZXdVSHZyWjJFU05PL2lxeHJWcnBlc1ZzUVljWHRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGJKSmMxTXJCYndtUDFQdkdrd1FWaStOdk5RVEFiOWFWMUx0Yzc0VEdZOFoy?=
 =?utf-8?B?dTlPMnRqU3N2MzFGcmtzTWFzbnlINzRTbUc1Sys2NUJOOWZUb0NHekxqY2FN?=
 =?utf-8?B?RkxrYkM2c1R6VFJPQWtYWmtQRndqaTJtNzRCYmZKa3gzVThJZ0d4aWcxZkI2?=
 =?utf-8?B?NUpHL3QvUEpWQ0RsdTE2eHJSb1k1U1F0ZEUzekJHZEZpSDFsNklHd1E2b0xy?=
 =?utf-8?B?VnpSUVVUcnJnVmt0TnBnNm5UN1l0K2J4d09ZcEs1ZU5pQm1DWTAzZnBCTmt6?=
 =?utf-8?B?QTY3RE8rSGF1TyswUEVPazFvNDJjOVZNczJlZjVGRUFkdjB0cStrWTN0MTJF?=
 =?utf-8?B?WVVxU0J5ellOR3kweXkxeXBPWHMvNU9HaUJ4TGJucFd1MFJLS05zMndScjU4?=
 =?utf-8?B?ZmZWQWZKaHVMRzVqOUpEREtsempMQTdhelV1WEhHa2FLYjhWcmgxZ1B6UUJF?=
 =?utf-8?B?RzFlYlhDRDAyTWtlNHhnc3RiRWpBZ3BwMzNoMHlYYnJOejBNM0ZPTGhTblIr?=
 =?utf-8?B?bzdFOFhkYk04Tzk0c1RqV2xnSzV1TGt3YWx6a0ZsSFhNMGV3My9sRVhVeVhQ?=
 =?utf-8?B?UXlZRDkwajBZeVJUWGF5bldaSzZ2UWMxL3BacSt4bG9sS2ZndmgzSWdpeVpl?=
 =?utf-8?B?ajMzTFhVUENuMzBrYnZLWXlrbitDVjhLME9wcnhablVDS1UyQnVTaFJlU1Y2?=
 =?utf-8?B?YWxMSU02c0lVYWgvWUJhdE1zb2FaTng0S1NMVitzeDFTYUZ5T3g5LysweFhv?=
 =?utf-8?B?bE1iODltRTdPTGMxeVVQUUErWjBUb2lVRStJMGZIVDNZRE9YWkt2T3RpV0I0?=
 =?utf-8?B?TXVTQ2JRU0I5a1RMYU5EZnBuMytmWnlrR1JlU1FvVWQ5elRaSmVjazJZWkU1?=
 =?utf-8?B?bVpGeitSQ3g5STNGOUo2VlNPVkdycXArT1FRMG5zQ1lmbkl2aU1KemwxeXJr?=
 =?utf-8?B?aHZoRFFKREEycGFGMTAyLzgvZm1yUXZBaWgxNFNoR0ZudFJGdGs4M0NpUTd6?=
 =?utf-8?B?VEtVQ2ZsNFFQSDZJSXJYM2pSOXBRZ0tpT2Y3RnFxSXF0Z3ZsSTF4ZWhjc284?=
 =?utf-8?B?Z0Q1Z2lIZWlhN2pCdU9FeStDRkdscUpuS3JLSXZPbk5pNFBHVGsvd3pjekM0?=
 =?utf-8?B?eWpqUEtkUld0cmNtYjBoYlI3dUJrQzJDRzdKUkZEc25QckQ5dUprYUtDVVdy?=
 =?utf-8?B?MGVaNmh3RWwrYy9zVHlnTGk3SGdjRUZoR1dEb09ia1pjVldaQkdzK2pwZytU?=
 =?utf-8?B?SUs5NUc4Q1MrSUVTcGU0eGF3THpFWEp5b3B4aWgvS3ArbTA4cWhrQmFUZTd1?=
 =?utf-8?B?UEdyTEFuUW5qNVo2dTNqUjYvdCtwSnY3RU1LWm9obHlWUyt0THc4UjRtSTdU?=
 =?utf-8?B?R0FBamdHNS9uUFpFbFNRclNhTDV6M2kxN1Qza2pLbHV4SUpTYXE2RUUzSFFw?=
 =?utf-8?B?R21KN0tYMDMrbEZ3ZExhQjdod1RTbHNoMzlpRURyY2lkU0JDcXYxeE1XY2tO?=
 =?utf-8?B?eEVOWG5zLzc1L0JVTzd3RUJqM25JWTlZK0FXdUR6SHZMSjE2U1c4SlFQVXRx?=
 =?utf-8?B?SFQ2dXBYbk5YWlZrQTBJODVKYnMxd3pXUU50NjUzUWdzOGR2Q25SKzR3alcy?=
 =?utf-8?B?T3pRM285c0YraEJjSmZ5RnRDK0lEWkxUZDRhWG1HSEhDeWtZanJoRUc0SDV0?=
 =?utf-8?B?SWJOeXFKQ0tJbTV4eWRnSUhvdzN5VSt2MTRBY3RaelBkR2RhcEltSnA1SWsz?=
 =?utf-8?B?T1BmNTE0YTFxcjM3bUw1WUZydzdoU1gvUTE5LzcrSnB5K1dQaUpTSDRQcy9i?=
 =?utf-8?B?SmdLZTRFenBCbFhRSjJMWEFsZ3VTRmlaUkxLTW5oWmdxcWd2MGFBMkw2TUNm?=
 =?utf-8?B?bGtTemM5OXl1S1pSTjRvOFlyOWEycXhKdTRNRjNySEoyMlBob2NsNGlQSFRw?=
 =?utf-8?B?MUFPTlpvRGJWQWxQOHV5UEVIWVRGYlU5VlRGbGdDamhZc0JHa2JTK3BVVTY2?=
 =?utf-8?B?ZnpUYTNQdCtmdnFzeThlZnJWRVIxMlNteE1TTkkvaGU2S1dqRXF3ZFo5aGp1?=
 =?utf-8?B?UGhLWXdZWlk3YlM4ZTZaQVVhMVo3VmF5aFhYSmZ4UnQrVnRlaGh3T3BaZmlJ?=
 =?utf-8?B?WkxrM3gwOTUzTXhLUUVuNmFhemk0eGRVbmlkR2NCVndwc2g2RHdsUW5ZZWhv?=
 =?utf-8?Q?7DyRyTYWlMV8/JU5Kih2JVU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6701776-3e84-400a-7639-08dc70f063c8
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 12:54:54.9479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s99j88b18sn8bxcjqWojNetcXlZCqB6r5tkihb7vLpe96fV+bIJ8K4oTFX/vzwpj2vAioUF9DzIoec4cYhybHBrfggqDZod7LWuwgBf+kYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199
X-OriginatorOrg: intel.com

On 5/10/24 10:15, Greg KH wrote:
> On Thu, May 09, 2024 at 12:14:10PM +0300, Shay Drory wrote:
>> PCI subfunctions (SF) are anchored on the auxiliary bus.
> 
> "Some PCI subfunctions can be on the auxiliary bus"
> 
> Or maybe "Sometimes the auxiliary bus interface is used for PCI
> subfunctions."
> 
> Either way, the text here as-is is not correct as that is not how the
> auxbus code is always used, sorry.
> 
>> PCI physical
>> and virtual functions are anchored on the PCI bus;  the irq information
> 
> Odd use of ';'?  And an extra ' '?
> 
>> of each such function is visible to users via sysfs directory "msi_irqs"
>> containing file for each irq entry. However, for PCI SFs such information
>> is unavailable. Due to this users have no visibility on IRQs used by the
>> SFs.
> 
> Not even in /proc/irq/ ?
> 
>> Secondly, an SF is a multi function device supporting rdma, netdevice
> 
> Not "is", it should be "can be"  Not all the world is your crazy
> hardware :)
> 
>> and more. Without irq information at the bus level, the user is unable
>> to view or use the affinity of the SF IRQs.
> 
> How would affinity be relevent here?  You are just allowing them to be
> viewed, not set.
> 
>> Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
>> for supporting auxiliary devices, containing file for each irq entry.
>>
>> Additionally, the PCI SFs sometimes share the IRQs with peer SFs. This
>> information is also not available to the users. To overcome this
>> limitation, each irq sysfs entry shows if irq is exclusive or shared.
>>
>> For example:
>> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
>> 50  51  52  53  54  55  56  57  58
>> $ cat /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/52
>> exclusive
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Shay Drory <shayd@nvidia.com>
>>
>> ---
>> v3->4:
>> - remove global mutex (Przemek)

thanks, and sorry for not catching back in time on v3 disussion

>> v2->v3:
>> - fix function declaration in case SYSFS isn't defined (Parav)
>> - convert auxdev->groups array with auxiliary_irqs_groups (Przemek)
>> v1->v2:
>> - move #ifdefs from drivers/base/auxiliary.c to
>>    include/linux/auxiliary_bus.h (Greg)
>> - use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
>> - Fix kzalloc(ref) to kzalloc(*ref) (Simon)
>> - Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
>> - Fix auxiliary_irq_mode_show doc (kernel test boot)
>> ---
>>   Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
>>   drivers/base/auxiliary.c                      | 178 +++++++++++++++++-
>>   include/linux/auxiliary_bus.h                 |  24 ++-
>>   3 files changed, 213 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary b/Documentation/ABI/testing/sysfs-bus-auxiliary
>> new file mode 100644
>> index 000000000000..3b8299d49d9e
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
>> @@ -0,0 +1,14 @@
>> +What:		/sys/bus/auxiliary/devices/.../irqs/
>> +Date:		April, 2024
>> +Contact:	Shay Drory <shayd@nvidia.com>
>> +Description:
>> +		The /sys/devices/.../irqs directory contains a variable set of
>> +		files, with each file is named as irq number similar to PCI PF
>> +		or VF's irq number located in msi_irqs directory.
> 
> So this can be msi irqs?  Or not msi irqs?  How do we know?
> 
> 
>> +
>> +What:		/sys/bus/auxiliary/devices/.../irqs/<N>
>> +Date:		April, 2024
>> +Contact:	Shay Drory <shayd@nvidia.com>
>> +Description:
>> +		auxiliary devices can share IRQs. This attribute indicates if
>> +		the irq is shared with other SFs or exclusively used by the SF.
>> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
>> index d3a2c40c2f12..def02f5f1220 100644
>> --- a/drivers/base/auxiliary.c
>> +++ b/drivers/base/auxiliary.c
>> @@ -158,6 +158,176 @@
>>    *	};
>>    */
>>   
>> +#ifdef CONFIG_SYSFS
>> +/* Xarray of irqs to determine if irq is exclusive or shared. */
>> +static DEFINE_XARRAY(irqs);
>> +
>> +struct auxiliary_irq_info {
>> +	struct device_attribute sysfs_attr;
>> +	int irq;
>> +};
>> +
>> +static struct attribute *auxiliary_irq_attrs[] = {
>> +	NULL
>> +};
>> +
>> +static const struct attribute_group auxiliary_irqs_group = {
>> +	.name = "irqs",
>> +	.attrs = auxiliary_irq_attrs,
>> +};
>> +
>> +static const struct attribute_group *auxiliary_irqs_groups[2] = {
> 
> Why list the array size?
> 
>> +	&auxiliary_irqs_group,
>> +	NULL
>> +};
>> +
>> +/* Auxiliary devices can share IRQs. Expose to user whether the provided IRQ is
>> + * shared or exclusive.
>> + */
>> +static ssize_t auxiliary_irq_mode_show(struct device *dev,
>> +				       struct device_attribute *attr, char *buf)
>> +{
>> +	struct auxiliary_irq_info *info =
>> +		container_of(attr, struct auxiliary_irq_info, sysfs_attr);
>> +
>> +	if (refcount_read(xa_load(&irqs, info->irq)) > 1)
> 
> refcount combined with xa?  That feels wrong, why is refcount used for
> this at all?

Not long ago I commented on similar usage for ice driver,
~"since you are locking anyway this could be a plain counter",
and author replied
~"additional semantics (like saturation) of refcount make me feel warm
and fuzzy" (sorry if misquoting too much).
That convinced me back then, so I kept quiet about that here.

The "use least powerful option" rule of thumb is perhaps more important.

@Greg, WDYT?

> 
>> +		return sysfs_emit(buf, "%s\n", "shared");
>> +	else
>> +		return sysfs_emit(buf, "%s\n", "exclusive");
>> +}
>> +
>> +static void auxiliary_irq_destroy(int irq)
>> +{
>> +	refcount_t *ref;
>> +
>> +	xa_lock(&irqs);
>> +	ref = xa_load(&irqs, irq);
>> +	if (refcount_dec_and_test(ref)) {
>> +		__xa_erase(&irqs, irq);
>> +		kfree(ref);
>> +	}
>> +	xa_unlock(&irqs);
>> +}
>> +
>> +static int auxiliary_irq_create(int irq)
>> +{
>> +	refcount_t *new_ref = kzalloc(sizeof(*new_ref), GFP_KERNEL);
>> +	refcount_t *ref;
>> +	int ret = 0;
>> +
>> +	if (!new_ref)
>> +		return -ENOMEM;
>> +
>> +	xa_lock(&irqs);
>> +	ref = xa_load(&irqs, irq);
>> +	if (ref) {
>> +		kfree(new_ref);
>> +		refcount_inc(ref);
> 
> Why do you need to use refcounts for these?  What does that help out
> with?
> 
>> +		goto out;
>> +	}
>> +
>> +	refcount_set(new_ref, 1);
>> +	ref = __xa_cmpxchg(&irqs, irq, NULL, new_ref, GFP_KERNEL);
>> +	if (ref) {
>> +		kfree(new_ref);
>> +		if (xa_is_err(ref)) {
>> +			ret = xa_err(ref);
>> +			goto out;
>> +		}
>> +
>> +		/* Another thread beat us to creating the enrtry. */
>> +		refcount_inc(ref);
> 
> How can that happen?  Why not just use a normal simple lock for all of
> this so you don't have to mess with refcounts at all?  This is not
> performance-relevent code at all, but yet with a refcount you cause
> almost the same issues that a normal lock would have, plus the increased
> complexity of all of the surrounding code (like this, and the crazy
> __xa_cmpxchg() call)
> 
> Make this simple please.

I find current API of xarray not ideal for this use case, and would like
to fix it, but let me write a proper RFC to don't derail (or slow down)
this series.

> 
> 
>> +	}
>> +
>> +out:
>> +	xa_unlock(&irqs);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>> + * @irq: The associated Linux interrupt number.
>> + *
>> + * This function should be called after auxiliary device have successfully
>> + * received the irq.
>> + *
>> + * Return: zero on success or an error code on failure.
>> + */
>> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
>> +{
>> +	struct device *dev = &auxdev->dev;
>> +	struct auxiliary_irq_info *info;
>> +	int ret;
>> +
>> +	ret = auxiliary_irq_create(irq);
>> +	if (ret)
>> +		return ret;
>> +
>> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +	if (!info) {
>> +		ret = -ENOMEM;
>> +		goto info_err;
>> +	}
>> +
>> +	sysfs_attr_init(&info->sysfs_attr.attr);
>> +	info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
>> +	if (!info->sysfs_attr.attr.name) {
>> +		ret = -ENOMEM;
>> +		goto name_err;
>> +	}
>> +	info->irq = irq;
>> +	info->sysfs_attr.attr.mode = 0444;
>> +	info->sysfs_attr.show = auxiliary_irq_mode_show;
>> +
>> +	ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
>> +	if (ret)
>> +		goto auxdev_xa_err;
>> +
>> +	ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
>> +				      auxiliary_irqs_group.name);
> 
> Adding dynamic sysfs attributes like this means that you normally just
> raced with userspace and lost.  How are you ensuring that you did not
> just do that?
> 
>> +/**
>> + * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the given IRQ
>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>> + * @irq: the IRQ to remove.
>> + *
>> + * This function should be called to remove an IRQ sysfs entry.
>> + */
>> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
>> +{
>> +	struct auxiliary_irq_info *info = xa_load(&auxdev->irqs, irq);
>> +	struct device *dev = &auxdev->dev;
>> +
>> +	if (WARN_ON(!info))
> 
> How can this ever happen?  If not, don't check for it please.  If it can
> happen, properly handle it and move on, don't reboot the box.
> 
> thanks,
> 
> greg k-h
> 


