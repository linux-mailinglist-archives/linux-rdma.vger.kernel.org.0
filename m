Return-Path: <linux-rdma+bounces-2340-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3EF8BF997
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 11:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65501F242AC
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639D9757E7;
	Wed,  8 May 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNrz4HLu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BCF47F41;
	Wed,  8 May 2024 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715160875; cv=fail; b=sIUblt8cEEaXeF58KJsNw7KWtOlgSFtsiEj3Zua9FtkHxHHJfqtoix9tVXBvRcH1QSTkMZ01fTJkoNn7Mjn+E4x6t/NbrI7t0ecFvrlXZJezU6r6txOj1aRU3o5MP2t63+yy6WLP2ySIdvOS3S2JglS2/qOuUL57vQf3/gxotBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715160875; c=relaxed/simple;
	bh=hQgKcL5WqBLGhZuxAjll/Poql39AyFfjg7RxNGDsFIM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sQ0Ekm3rO6qwd7vAounir0bI6sMEGhIIT/5baJ3dOD5LVu7GNUobbtrD35H+DQXyYl/VROIlCfKo55anPepBs9+vcE44ujagkA+UuFJ3C99xrWIKjkQoEtvbFwsBeyNsJQphjKgaA/GGnSWYQGq8lMbFyoEqHRtrfZHSyFGWdtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNrz4HLu; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715160873; x=1746696873;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hQgKcL5WqBLGhZuxAjll/Poql39AyFfjg7RxNGDsFIM=;
  b=NNrz4HLumihahD7BwPJK2xS7oxRfZ6k13naxrMNDZRGanPxK2s408zHe
   7CKn5vOtiWeZbAEyExpYYJAc8a+Rl/YcgjH3wtLa88zNUGbNT9ZtEHUf2
   tuQudqL9VfnvTN6nAWH/jzivRnl4jWkySWH4+clWu9L1iPcIZ4NcmL1Ni
   6h9J0vr36MFZRKA/IBUmxF+hBEAQ/Vjp7znJ68AgTHa3gpE7u7hzKuesZ
   XsGUboYMDZ/5WA1tW/IaiUZzqgLxVVvCjIunSpjLtooI/fjOex+oVcoiL
   pj84fWUcs7j8xej81YWOveld4dIwnNB9Pi46euYeIqPQ0lG0frrHWMdEB
   g==;
X-CSE-ConnectionGUID: jUhLvc21SJCsJoy2ZOQpvA==
X-CSE-MsgGUID: wO+BEQvkT+Wis+lFIsQRGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="13958716"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="13958716"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 02:34:32 -0700
X-CSE-ConnectionGUID: rh6iGBnITJSOeVi6PXZVoA==
X-CSE-MsgGUID: xYzMzpV5RjOyPZeeq1jUNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="28772469"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 May 2024 02:34:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 02:34:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 8 May 2024 02:34:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 8 May 2024 02:34:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 02:34:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibU20XuFJ4gOUBH03LbEou1hDBvnLW5pbGGFZSCSagsO5pnx16N22hLV4DgxO/Y1PkbY2qHSu7abLYgpR2XfLZ8kmZqmkW3myg9hHE/6xT8YZ+kGzfFAZYX/3FocGZViD1ArgtrrFjr6seUAVya12SW/wVXogk3rrKKMwOwkSLmwC+7/H3SbmCgA/wMsgELe5yw53tbWHqnNm905XlX1ckFKOoJwy1Nc1+6V0hsL9yBWN5gM+pAf1v7c+qLQ5BPOcczHA33GP9wgQrUWlvUp2fXRKc1QmLJTYpudIJzbp/dITxOVUDSB6SuZIob+kAeax43UmbhyS923qA5XepkXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5opUhYNASDuQ2Rp61k9DboQR4PcOrBNc8OGWQ3GqcUo=;
 b=ZfpK9TiEfCGR+ZBw0yUwLnIz2CKCMy60oer5UxhKgrZxCqjHrxnBREQp3XpdEQSyoYyH7Vs0nb8x31lJSf1OzMRBi7uYpSDu8zwtpM7rPoUnJzQ+n6PmjMtkGlmp+qhIvGjI3giez5SNoKHSniUZG2n4ITxjcOg+mcYwUS6HCH3SWQk1pVx2Z50Cl8HCnVp/owI76AEswXMSLGuTSqT/ouXUhNz/zIBZqm6ArciO76XkQLqZ5WHa0vot8eR5hvwjx0famPeFkW0VPoZn9VZbixfNJx/V5FCVZBxYEAwp+yffznfNmhNSXVqLbVvX+bHwYz7/OmDGpBz62RjUw9lWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 8 May
 2024 09:34:29 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb%3]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 09:34:29 +0000
Message-ID: <6da0b4eb-717b-4810-951c-b59edf32e422@intel.com>
Date: Wed, 8 May 2024 11:34:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Shay Drory <shayd@nvidia.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240508040453.602230-1-shayd@nvidia.com>
 <20240508040453.602230-2-shayd@nvidia.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240508040453.602230-2-shayd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0047.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::16) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 903a5cd0-8e97-4910-6ab4-08dc6f420f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWhnN1pmekdIRUkvYXc0QlpvdVh0bDYzZ1RyenNqWlNTdTZrZHpMVWJjRkJj?=
 =?utf-8?B?RG1EK3hvN2xvLzF3UVRLOThxREtFaUp5Zi9UcXROMGtPK3pCLzRsQWptY2p2?=
 =?utf-8?B?cHkrYmIwNkhaalhRR09XOU83Uk1ybFJWbkZrbTBxTXlHdG5qcUpLcUkvT2I1?=
 =?utf-8?B?OVJETklNU0txMW9RK1BMSTBKWDFzaUNYWlhVZWwwem1WWDVoSDZCSldISEd2?=
 =?utf-8?B?dG90cmxvWElTTm1PRnd2K1Q1em03OG5Jd3VjU3cvVHpadHBpdkYwekZsMUZ5?=
 =?utf-8?B?SlIwRWdHNTVUQmkrQ3p2eHEvL3hrS2QwWTNla1M0T0pic1FEVEtEL0QvMUhM?=
 =?utf-8?B?VWZNa0lYdzB4WU84ajZVVWpNZG00QXRWb3VPTnJNK3A2a1VZcTI4Y3ZlRjIz?=
 =?utf-8?B?QzVtM2Eyb2sxdSs2Y0N1WmxIZGJKYWxwWFU2ZGRnNGJYQUgvbVRJdGJGY3VG?=
 =?utf-8?B?MGVmRHhIOFNzOXNmYlJML203UVlTOU9oeHhyOEwvK1Z0ekxBeDRKdGpjb3pz?=
 =?utf-8?B?V1JaU2tscmVJV3VUY3IzRytVSlZid1BubUhUeFZUYkNhdWFYNURtL29TZXBN?=
 =?utf-8?B?dThvVUNIRmFNMnAzc3BGdXhPQ1psV0lpd3pOVHVGeDhCV2phVUpmTmd6QWpK?=
 =?utf-8?B?M3I0dk5mMWhqTTlZY2REckY5SEJMRzNQWXRaVzFXSlNKb1U3UzZHMWNUaG5q?=
 =?utf-8?B?cExEN0tUQUJGMURyb1pqbWpCbWVRbjBlcGY1TDRuVzVESll4dGY3a3RFWkRI?=
 =?utf-8?B?VjlDeVNqaDhEYkVPYlZzeHA4T1RXSFE0MEhjdFNZVUVRc3UxbzcvS2pkUDFC?=
 =?utf-8?B?WTlySWxsL2pTaW9LSWNyRFAxNFFYa0NaOWhlWkt2eTVCU0tjSm5GY3hyYXVN?=
 =?utf-8?B?UU4zVTcxWnlWYTQzeCs2bjZRZ3ZmWSsycTlKWDBFdDJrZ3VQRGZpQlFxQnVi?=
 =?utf-8?B?MVIxWVFtQWdGYXJmM1NmcDhkWG41dGh0blFENEZkOUVqaE4xWE5NYXRkQjBk?=
 =?utf-8?B?SzlicU5xdEliMG1RbzlMKytBZWc3V2JzWFZPTnVxZUhNQ1FEMHNScS9YU0JJ?=
 =?utf-8?B?RGF6MnVIYlJHVGJFUmNWRzAzMUhLZCsrUzlCcVlVT3RnOXlRSnhaYnBpWTBC?=
 =?utf-8?B?c0VWbVZicVhybzlHdnc0WUFRbyswOURzNWZ0ajRqT3V3djB0RnNLVlhOTDVB?=
 =?utf-8?B?V3grN0h4YTMwMzlYdlVXWm9uUnBocktxdGVGeUZ5WkJ2c2NtaHU3N3JSLytD?=
 =?utf-8?B?eHowM2U3QlJSbUtGTFhBK0MwQ0tmbThxUHVuK09OR2crNWR3cVpjeDJjdDVr?=
 =?utf-8?B?Y2dOZDJhL2NhTzVWOGNEbDlnRWMvSytOYnhrbzBhNWJaNFpsS2xVWG9jWTNR?=
 =?utf-8?B?TW9pVW9pSVpjUFJwVno4ZFM1NE5sSDRlLytXYUE5M09pQUsvVUc4dTZ3Nk05?=
 =?utf-8?B?b3lBcW5nSVZBWkp5NWV2dHZxd0wzUGh6LzdXdnlDYXdjVFQ1SXZLRjVmd0xV?=
 =?utf-8?B?UjZ6TFhrOWxabXI4bnMrVmRzUDJ4ZDFrMkpoVWlqUTZ2QnF4bkN3clhsTnc1?=
 =?utf-8?B?QzdaNUYxLzBQK1Q0MnhmbmRJMXlsK2VDeFU2K2NTaldaYWxqYVVwbmg1YWJx?=
 =?utf-8?B?eit4Mm1ud3Nvb2ZBekU3Si9EeWNZRWJOMGJWZFF3V2phZzRKK3FOT3kzczEy?=
 =?utf-8?B?YmJtY3hOOFo3SnFaOFh1YWZTb3RnUEc3UHFhdEhCRUx6clVBdUpVOUNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3dtd2lHVGRBYTRDT2IyclFjemhhWWVTb1FiYzQ3bm1iTUN4dllYVU4zcC85?=
 =?utf-8?B?a3J6V0R3U21tUE9VL3lTczV5ck9iUmh2bUxHdVRrdHNLS2FRMHRvaitsVzFC?=
 =?utf-8?B?OE5ETnp2RFdwNGpDekoyNHBhN3VaVzJVSFByY1hBZDdPR2tNWEtLbjRLYmtS?=
 =?utf-8?B?T2tHSWQwaUwzU3lBVTdzV0NSV041aVNKNExXT0ZSYkRZY1BlWFlFQXhmSUow?=
 =?utf-8?B?VWZuWTNSWFlWQ1I3eEErdTZVVmppajNzeFRaTFhiOUYzaHNzL2lxRUdGZHBr?=
 =?utf-8?B?b1lmRE1RYTFOTlRNL0djMWtQMUwyaWJVdDBOR0tSbHdPRzZQK2xQMGwyYzFl?=
 =?utf-8?B?aW84WGlUZFlOMm1OSm9tY1RLcCtINU81enNhMmVyS0FjN2xiaXRqalJFYnlC?=
 =?utf-8?B?cFlVSnVDM2M1NXVOcnNZUDRCQnVuUHYySE1nL3FEWUdyZjVSL1JNc0JYUWtK?=
 =?utf-8?B?R0o5YkprMVppMCtDUWRCbTFocFNRaWFTT0lJZkkvUEx4QlVlR2FOeVN1OElQ?=
 =?utf-8?B?c05iTkNLVGJXSm9YajJ6amFJcm50Vmd3amc0RXNGa21oL1kwbjU3c3hySjJT?=
 =?utf-8?B?cFhTUlpiUHlmaTZ4amJZczBrc0ZySEhaWGJhZWs2VlNDdDhFTEhYODF1V21k?=
 =?utf-8?B?UmVCbkFkU1lRWW9lT2M5MDNhY2M4bHU2YjdwOUxTcnNZVlZsWXpUaEtLMFZr?=
 =?utf-8?B?REFpRHVpUlBwTzNwTVVrSzBKT24rNlVET1FCcXFnemtBbGk2QVNiVEFoTEEv?=
 =?utf-8?B?dDhLOEVKSHhyNkVOUmhIYWt6VXhYVEF4RWxKSXhLYzc1SFR2VEh6cUJlL2lE?=
 =?utf-8?B?anlTY25RUjVoWUg3YVQ0cWs0NzNhMk5aYWtIUGw5UVVsTHhZdGc5MStOQXg4?=
 =?utf-8?B?VXFGMU0xdCtvRWJSdEc2V0dBZC9PK2NSdGpsVitUbEdxeVBCTytHMFZtTmdV?=
 =?utf-8?B?VGYrcGNSNHpVbjN2WnFlZjlteHZ2NjBQcDZDbHRQTHFEcjVxczJPQmZIdGkz?=
 =?utf-8?B?OFdKS21lRk8wU2l4RmdjZWQwcGJlTTdVcmVlcnhWN3B5MjNhckppMFg0SXpU?=
 =?utf-8?B?SkMrT0hrcDEvNE5yS3RNNlhYNno3Y0F6UDlRU1ZJYVppb0NEbDFBTjBYL2ZT?=
 =?utf-8?B?cW5RZ1pDWWh2RGlYTVdlUmJ1b2E5OFA3RDZySGFzYW5WUXZUY0dVZmY1MW02?=
 =?utf-8?B?VThiM0NoZ2QxeDZ1d0tQOXdyZGpzTnNNeVBKY3JiNERjc0pZQWcrajRxbW54?=
 =?utf-8?B?YTN0RVNvMVJJd1V1NE9XZFJlMGJyMXErNGFFUFl1SDg2TUNqbDMzcXg0Z1Vl?=
 =?utf-8?B?YjRHb0J3ZUVMREFQOWUraXhWY20vUWgzU1IvWkJPZ1NvS3NRT0w4enRJbmFt?=
 =?utf-8?B?Vm5yZElLeEpMOFVZZXJEanZRWW1zKzY1a3RUcGp5anZMU2VRck5nSGZJT2pV?=
 =?utf-8?B?Y3NjQmFyMk1nWXhPYjVvN1ZWck9VdzhWVjVMUDUyMGFDYkptOUZQOXZBaWUw?=
 =?utf-8?B?ZUVKcWlLak5iMG1mRWU5c2dQY2lCb1dBSVJOWW01UXFKTzM2OXhqa1RYanlx?=
 =?utf-8?B?ZENxTWczSHhQM3p5b21lL3E4SWh3ckdBTEE1R21NUVRtVm1vWHpGUWRHOFdM?=
 =?utf-8?B?UStJQnJUMFk4N1FJZEhjK1FlUzYyeDdxVytoWWx4cVNZczhjOFVrSm85V2dJ?=
 =?utf-8?B?QjMyeExLUGNnbWxDSngwekZRVTF1QzNqK1dQNTZtdFFzL0Z0bTB3aWk5VXJo?=
 =?utf-8?B?SDNVMm5KRC85K1BlREFXUmFEaEJKQ3ZXYkFGeFA3V05oNWpuTXhYckUramla?=
 =?utf-8?B?eTF6UFovYUU1TzZGWUl0VlBFeFRYZTgybERwWER6VkhoRWkwOWF6YnhQWmd3?=
 =?utf-8?B?WnFWOWZBb0ErTFN2VnZuenpRaEtCaE1Wdit2eEdNb1hDbTFnNjBFbHZFM2Zh?=
 =?utf-8?B?Yk1JejdOWHQzaFdKU21FNllDRi9GRFByaGYzN01HQXMyLytCS0dSaWlQMndI?=
 =?utf-8?B?eE9MV3VlUXA5cEVtQVFScE0yUXNjRlRIZHgrejBFdnBBdlB6c2tDNG0ySGZT?=
 =?utf-8?B?cGVFdjBvQ25LQkpWWitFVUI0dnNiWUpSc09aSjBueFBlZHU4OVE5bmQ1SFpT?=
 =?utf-8?B?YzNKbEl3djJrL3c2UVp4MEZnbUk4eWF4Ry9HcE55c05SRHhUR0ZWcm1SbUJ6?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 903a5cd0-8e97-4910-6ab4-08dc6f420f16
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 09:34:29.2344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsRUAq8Ds9V07HZFzGNXZazsCTka4PUhrQyUyTqPapp9jXkllijrkHLCnSyi+6EsMLZMvwqVgVY0+Rj6qd/idfSdo2lmpraAOV5dVOhGYyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-OriginatorOrg: intel.com

On 5/8/24 06:04, Shay Drory wrote:
> PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
> and virtual functions are anchored on the PCI bus;  the irq information
> of each such function is visible to users via sysfs directory "msi_irqs"
> containing file for each irq entry. However, for PCI SFs such information
> is unavailable. Due to this users have no visibility on IRQs used by the
> SFs.
> Secondly, an SF is a multi function device supporting rdma, netdevice
> and more. Without irq information at the bus level, the user is unable
> to view or use the affinity of the SF IRQs.
> 
> Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
> for supporting auxiliary devices, containing file for each irq entry.
> 
> Additionally, the PCI SFs sometimes share the IRQs with peer SFs. This
> information is also not available to the users. To overcome this
> limitation, each irq sysfs entry shows if irq is exclusive or shared.
> 
> For example:
> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
> 50  51  52  53  54  55  56  57  58
> $ cat /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/52
> exclusive
> 
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> 
> ---
> v2->v3:
> - fix function declaration in case SYSFS isn't defined (Parav)
> - convert auxdev->groups array with auxiliary_irqs_groups (Przemek)
> v1->v2:
> - move #ifdefs from drivers/base/auxiliary.c to
>    include/linux/auxiliary_bus.h (Greg)
> - use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
> - Fix kzalloc(ref) to kzalloc(*ref) (Simon)
> - Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
> - Fix auxiliary_irq_mode_show doc (kernel test boot)
> ---
>   Documentation/ABI/testing/sysfs-bus-auxiliary |  14 ++
>   drivers/base/auxiliary.c                      | 171 +++++++++++++++++-
>   include/linux/auxiliary_bus.h                 |  24 ++-
>   3 files changed, 206 insertions(+), 3 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary b/Documentation/ABI/testing/sysfs-bus-auxiliary
> new file mode 100644
> index 000000000000..3b8299d49d9e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
> @@ -0,0 +1,14 @@
> +What:		/sys/bus/auxiliary/devices/.../irqs/
> +Date:		April, 2024
> +Contact:	Shay Drory <shayd@nvidia.com>
> +Description:
> +		The /sys/devices/.../irqs directory contains a variable set of
> +		files, with each file is named as irq number similar to PCI PF
> +		or VF's irq number located in msi_irqs directory.
> +
> +What:		/sys/bus/auxiliary/devices/.../irqs/<N>
> +Date:		April, 2024
> +Contact:	Shay Drory <shayd@nvidia.com>
> +Description:
> +		auxiliary devices can share IRQs. This attribute indicates if
> +		the irq is shared with other SFs or exclusively used by the SF.
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index d3a2c40c2f12..6293c6707e1e 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -158,6 +158,169 @@
>    *	};
>    */
>   
> +#ifdef CONFIG_SYSFS
> +/* Xarray of irqs to determine if irq is exclusive or shared. */
> +static DEFINE_XARRAY(irqs);
> +/* Protects insertions into the irtqs xarray. */
> +static DEFINE_MUTEX(irqs_lock);

sorry for not catching it earlier, you don't need a separate lock,
xarray provides one, please see below [1], [2]

> +
> +struct auxiliary_irq_info {
> +	struct device_attribute sysfs_attr;
> +	int irq;
> +};
> +
> +static struct attribute *auxiliary_irq_attrs[] = {
> +	NULL
> +};
> +
> +static const struct attribute_group auxiliary_irqs_group = {
> +	.name = "irqs",
> +	.attrs = auxiliary_irq_attrs,
> +};
> +
> +static const struct attribute_group *auxiliary_irqs_groups[2] = {
> +	&auxiliary_irqs_group,
> +	NULL
> +};
> +
> +/* Auxiliary devices can share IRQs. Expose to user whether the provided IRQ is
> + * shared or exclusive.
> + */
> +static ssize_t auxiliary_irq_mode_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct auxiliary_irq_info *info =
> +		container_of(attr, struct auxiliary_irq_info, sysfs_attr);
> +
> +	if (refcount_read(xa_load(&irqs, info->irq)) > 1)

I didn't checked if it is possible with current implementation, but
please imagine a scenario where user open()'s sysfs file, then triggers
operation to remove irq (to call auxiliary_irq_destroy()), and only then
read()'s sysfs contents, what results in nullptr dereference (xa_load()
returning NULL). Splitting the code into two if statements would resolve
this issue.

> +		return sysfs_emit(buf, "%s\n", "shared");
> +	else
> +		return sysfs_emit(buf, "%s\n", "exclusive");
> +}
> +
> +static void auxiliary_irq_destroy(int irq)
> +{
> +	refcount_t *ref;
> +
> +	xa_lock(&irqs);
> +	ref = xa_load(&irqs, irq);
> +	if (refcount_dec_and_test(ref)) {
> +		__xa_erase(&irqs, irq);
> +		kfree(ref);
> +	}
> +	xa_unlock(&irqs);
> +}
> +
> +static int auxiliary_irq_create(int irq)
> +{
> +	refcount_t *ref;
> +	int ret = 0;
> +
> +	mutex_lock(&irqs_lock);

[1] xa_lock() instead ...

> +	ref = xa_load(&irqs, irq);
> +	if (ref && refcount_inc_not_zero(ref))
> +		goto out;

`&& refcount_inc_not_zero()` here means: leak memory and wreak havoc on
saturation, instead the logic should be:
	if (ref) {
		refcount_inc(ref);
		goto out;
	}

anyway allocating under a lock taken is not the best idea in general,
although xarray API somehow encourages this - alternative is to
preallocate and free when not used, or some lock dance that will be easy
to get wrong - and that's the raison d'etre of xa_reserve() :)

> +
> +	ref = kzalloc(sizeof(*ref), GFP_KERNEL);
> +	if (!ref) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	refcount_set(ref, 1);
> +	ret = xa_insert(&irqs, irq, ref, GFP_KERNEL);

[2] ... then __xa_insert() here

> +	if (ret)
> +		kfree(ref);
> +
> +out:
> +	mutex_unlock(&irqs_lock);
> +	return ret;
> +}
> +
> +/**
> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
> + * @auxdev: auxiliary bus device to add the sysfs entry.
> + * @irq: The associated Linux interrupt number.
> + *
> + * This function should be called after auxiliary device have successfully
> + * received the irq.
> + *
> + * Return: zero on success or an error code on failure.
> + */
> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
> +{
> +	struct device *dev = &auxdev->dev;
> +	struct auxiliary_irq_info *info;
> +	int ret;
> +
> +	ret = auxiliary_irq_create(irq);
> +	if (ret)
> +		return ret;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		ret = -ENOMEM;
> +		goto info_err;
> +	}
> +
> +	sysfs_attr_init(&info->sysfs_attr.attr);
> +	info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
> +	if (!info->sysfs_attr.attr.name) {
> +		ret = -ENOMEM;
> +		goto name_err;
> +	}
> +	info->irq = irq;
> +	info->sysfs_attr.attr.mode = 0444;
> +	info->sysfs_attr.show = auxiliary_irq_mode_show;
> +
> +	ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
> +	if (ret)
> +		goto auxdev_xa_err;
> +
> +	ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
> +				      auxiliary_irqs_group.name);
> +	if (ret)
> +		goto sysfs_add_err;
> +
> +	return 0;
> +
> +sysfs_add_err:
> +	xa_erase(&auxdev->irqs, irq);
> +auxdev_xa_err:
> +	kfree(info->sysfs_attr.attr.name);
> +name_err:
> +	kfree(info);
> +info_err:
> +	auxiliary_irq_destroy(irq);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
> +
> +/**
> + * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the given IRQ
> + * @auxdev: auxiliary bus device to add the sysfs entry.
> + * @irq: the IRQ to remove.
> + *
> + * This function should be called to remove an IRQ sysfs entry.
> + */
> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
> +{
> +	struct auxiliary_irq_info *info = xa_load(&auxdev->irqs, irq);
> +	struct device *dev = &auxdev->dev;
> +
> +	if (WARN_ON(!info))
> +		return;
> +
> +	sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
> +				     auxiliary_irqs_group.name);
> +	xa_erase(&auxdev->irqs, irq);
> +	kfree(info->sysfs_attr.attr.name);
> +	kfree(info);
> +	auxiliary_irq_destroy(irq);
> +}
> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
> +#endif
> +
>   static const struct auxiliary_device_id *auxiliary_match_id(const struct auxiliary_device_id *id,
>   							    const struct auxiliary_device *auxdev)
>   {
> @@ -295,6 +458,7 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
>    * __auxiliary_device_add - add an auxiliary bus device
>    * @auxdev: auxiliary bus device to add to the bus
>    * @modname: name of the parent device's driver module
> + * @irqs_sysfs_enable: whether to enable IRQs sysfs
>    *
>    * This is the third step in the three-step process to register an
>    * auxiliary_device.
> @@ -310,7 +474,8 @@ EXPORT_SYMBOL_GPL(auxiliary_device_init);
>    * parameter.  Only if a user requires a custom name would this version be
>    * called directly.
>    */
> -int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
> +int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname,
> +			   bool irqs_sysfs_enable)
>   {
>   	struct device *dev = &auxdev->dev;
>   	int ret;
> @@ -325,6 +490,10 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
>   		dev_err(dev, "auxiliary device dev_set_name failed: %d\n", ret);
>   		return ret;
>   	}
> +	if (irqs_sysfs_enable) {
> +		dev->groups = auxiliary_irqs_groups;
> +		xa_init(&auxdev->irqs);
> +	}
>   
>   	ret = device_add(dev);
>   	if (ret)
> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
> index de21d9d24a95..760fadb26620 100644
> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -58,6 +58,7 @@
>    *       in
>    * @name: Match name found by the auxiliary device driver,
>    * @id: unique identitier if multiple devices of the same name are exported,
> + * @irqs: irqs xarray contains irq indices which are used by the device,
>    *
>    * An auxiliary_device represents a part of its parent device's functionality.
>    * It is given a name that, combined with the registering drivers
> @@ -138,6 +139,7 @@
>   struct auxiliary_device {
>   	struct device dev;
>   	const char *name;
> +	struct xarray irqs;
>   	u32 id;
>   };
>   
> @@ -209,8 +211,26 @@ static inline struct auxiliary_driver *to_auxiliary_drv(struct device_driver *dr
>   }
>   
>   int auxiliary_device_init(struct auxiliary_device *auxdev);
> -int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname);
> -#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME)
> +int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname,
> +			   bool irqs_sysfs_enable);
> +#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME, false)
> +#define auxiliary_device_add_with_irqs(auxdev) \
> +	__auxiliary_device_add(auxdev, KBUILD_MODNAME, true)
> +
> +#ifdef CONFIG_SYSFS
> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq);
> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev,
> +				       int irq);
> +#else /* CONFIG_SYSFS */
> +static inline int
> +auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
> +{
> +	return 0;
> +}
> +
> +static inline void
> +auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq) {}
> +#endif
>   
>   static inline void auxiliary_device_uninit(struct auxiliary_device *auxdev)
>   {


