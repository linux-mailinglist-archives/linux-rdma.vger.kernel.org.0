Return-Path: <linux-rdma+bounces-8707-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0D3A61915
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 19:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C1719C4BAD
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E21204581;
	Fri, 14 Mar 2025 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hP55KJ+F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4CF20371A;
	Fri, 14 Mar 2025 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741975798; cv=fail; b=io9xPA7qUx9aq11YBVggYyZNNj65p/OVtu+o63A5a7I0LFhsYsgJR34R3ffnXvFrpnpCV8I8A6VlosCaaYiqgqR0VXSZK+UJk/LabpP+yYzuymwNzPtEhjrdCrHPNqAABKcW1gYYPI0EhpB/m4m6j+u7DJSP+oYTVUHj27XVL0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741975798; c=relaxed/simple;
	bh=U3OpJts9S3ERQC1dezUP1SJiHzftvjp114Ts4N4bi+4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uwEuvloYAB31hRfuxsXHYPls7HvldEuNRiyuTuAeUnP9Hde2ZSo3/h9jrwHdJLI2tzAQU4dWwUm3KpYu/QbL62wLw8yvZo5HS7ejfMrzI8VDr9nMNLVaCacaXEpwxpIvGHu8rcxB5fpACjBa+d5ZclmTGvHAmcDUdpMIskPVrJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hP55KJ+F; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741975797; x=1773511797;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U3OpJts9S3ERQC1dezUP1SJiHzftvjp114Ts4N4bi+4=;
  b=hP55KJ+Fpypknvwz24mI8Pv4QU8motl0RLxeG8gZtQn8+MWH33DCsM4n
   UHer6nF5sKA1z1LQ6qOqX4bjHwBzAESVlqB+AXGdLMoS79QVMdTyXC7Th
   4xuFN1fRyx3469gsbfGdFXbIGIQyXEn+grVr0J/zLLLI9N8PEpduzbYo9
   jauMvUbl66ye5QJC+I1OChm+v07lxSwCk+fTH2XU+o90+W3i2bjjQDb7v
   LUStNRCBwzeQFB+45AHdXwkNlJxyFbbCawsI0u5MuXB1Zd80PEEdrQDKi
   8RfSUSsh/j9vjdZ2O/tWswOhXA8YihiG4D62RhVvnVT1TY+uNv6j6QukH
   w==;
X-CSE-ConnectionGUID: GS8tay/mSGC5ourEdN89Zg==
X-CSE-MsgGUID: Drl3ccxbSq2sWiOh/gU33Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="43177174"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43177174"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 11:09:55 -0700
X-CSE-ConnectionGUID: lUj1892dRFyjYoZfycTJzg==
X-CSE-MsgGUID: QQkDB914RyGzZb9Xnf7Eow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121544491"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2025 11:09:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Mar 2025 11:09:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 11:09:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 11:09:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P89LC7Bjh5mlfWY3eNdwPBZmKgTGz2QLGjh62S3mhGc9upNvCacdnFxHWbbI9HanDaTykpyuyjyGc4IYH3usLdL4R3/pwvnUCQmR39U8bKBDkI1ScXmAXgaZpBG4I7oxHDqyK6V2ifxMJKcB+o+sGL29tdNGGgnDBfv1UseaNSgEv1zNxi3TsOKG2UJ84nSfIUR6icm1Z/nhqbruRIq3ESWxIWxJD2D/bE07g0w/iJsD6ZcRzaAEazNvfQ8XTwWkQQDxHEs+fFKQ3BOuOnNJcEB1eo/L7BD83gVrFdKyZt0ODIrLuvjTBLRqFtp1If785oaN36w6QAWoXys5CBSjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwJQQ+nSsvJ+4JvheYhhFL7/jUyUxbq4DKQ6m+sdhkI=;
 b=VMqG0ycbfq1+9nGHZkDiT4YcpIIFY+omVcZXUjccRmGHwAgHV5OigVtFfjUS8N1bAg1UUtTtOUKUv7lFugDDxqLWWiOXsB5rXCTvnoCqhxs8U9rUUOnX5uVoZq/tKQRDg34+5rp0xbpLRc3dOHaRMtw/zgd7obk0blQzTpLz74/fkXbSctGDsfCm/a6Iqj3u71pOXj0FIFX52yeAyLnXkjuvmcDMwznwlnAiAWQssgnpHl0spwH0Ee4VS0aO57gMOgwcsqtSQM0V0/WAhntVeKg2iiwqlvrYRL8JfY+5k1i1vdhb/GYr5lGu8GnMsDaJBeHTDQmcbyCTF7R+ACBU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB7536.namprd11.prod.outlook.com (2603:10b6:806:320::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Fri, 14 Mar
 2025 18:09:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 18:09:50 +0000
Message-ID: <d0e95c47-c812-4aa8-812f-f5d7f6abbbb1@intel.com>
Date: Fri, 14 Mar 2025 11:09:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
To: "Nelson, Shannon" <shannon.nelson@amd.com>, Leon Romanovsky
	<leon@kernel.org>, David Ahern <dsahern@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@nvidia.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, "Daniel
 Vetter" <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
	"Christoph Hellwig" <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Leonid Bloch" <lbloch@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, "Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org> <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org> <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>
 <20250313124847.GM1322339@unreal>
 <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:303:6b::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA3PR11MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 7259f1dc-a377-44bc-d139-08dd6323694c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVNJcWRCL1I3cldIOVRmeG1oYnZpRklTbkt6cVlZYk1GQjRqeitMRjBUazA1?=
 =?utf-8?B?bTZmZHEwTjJDbEFPOHBWbjlUeG5YQlVFbWc4Z2JQdW56cHNPazRKZFIvSEkw?=
 =?utf-8?B?UmtlZlZGYjB1Z0Z2MjMrWHBoZmFrNDh4a3pmRGxGUXhrVGFPWmNBTnVsVllQ?=
 =?utf-8?B?WDlCeXZseFdJOVdqZlN2NU9PRXB6ZnVIdHBvdUNXOXVsMkxULzl1ZmRBekR6?=
 =?utf-8?B?MFpmWlNONEJHVW1KNDIxYVplTlV2NUdGR1ZocjZQL3A0bzIxNjlicTBOZXZw?=
 =?utf-8?B?ekcrZ3haUGY3bjQ4bDAvZGFFb3NnNUFUankvekluTGh4K2pTRGpnSXBBUWRS?=
 =?utf-8?B?b255ODVZKzUzb3BsWUxIN0p1eTFvTmNta3FreDZTRHFFZWFnWk14T2ZOUXcy?=
 =?utf-8?B?dkhhclZNbGtXWHhFczl3NHZTT0RoVTVVMnhhMWVMVVlFVDZIUTc0WVdWYmJE?=
 =?utf-8?B?bWp1ODRvUUYzSnBPVnJ1RmY4ZnA2RmVlUmplSkFLMDRJZ1hBb0ZlcWgwZWdQ?=
 =?utf-8?B?ZjYvamJGd1dFeVFFQjJ4UVdJUGR2T2tDcnRjMlYwUkVod3B3TTR1Z0pKd25Z?=
 =?utf-8?B?Z3MzRFVXMG1MRE5xZSt4OU03cWlZSitzR3ZzWXJqaDI5eGFnTDcvMkR5eURD?=
 =?utf-8?B?YVpQVmZ2aG1OTGlXTzZ3a1h1VWRuNStLbzdxTHZYMlRxcnlUVmx4S2IyVjNB?=
 =?utf-8?B?OU5ESEJuTkhZWm83TVdXRUEyS0RwWXJNZ3pGVUpjRzBlTkgzcEVobENkVlVJ?=
 =?utf-8?B?cE5EMVhuaWttUXlDWkpYekFlZ1FYUzBncHdtNnIwWlRwT3I3NHQvcTJ2MzR1?=
 =?utf-8?B?UXRtSnNIdCt2d2YzRDhIYnRIK0RncVR5QnZna3pyWXpHM0I3TmNNangwRENw?=
 =?utf-8?B?eDY4MGdTTnlhQTNYMWUyK0ZKZHJrOXBRMk5ueGhrdnB2TkVHaisrVkovRGM1?=
 =?utf-8?B?Y1ZVTXQ0dllSM05may9zbDBaWmQ2U0VlOHNBZWNqMnJ5MmxjMVIwanZuRFll?=
 =?utf-8?B?WVJKaDlGTi9aWEFCVUlXUkNwblBzYXZzMGdWNXM4OFh1Ym1JVitEeHhzODcr?=
 =?utf-8?B?cmZJMUdVeDkyVHZ6RHhGSEI5dkFjeHlYZjUvaEt3aTZydUkzOFhSTktUTzN6?=
 =?utf-8?B?MXhIM2tVaHBLdFk4cUV5Zk1uU3hLakdGakcxQms0d1h4NW9XUDR6b1ZXM054?=
 =?utf-8?B?cS83VWFicGpSQWN3Z25VSkM1anZ6eEZ6TG9KWGVqc0VhNEQwYkpmU0ZiMVQw?=
 =?utf-8?B?MGRsaUZINW9GNXdYNEl0ZzNscDhWMmd6cnd6NTkzanlWblEvWFh4RGNYeVll?=
 =?utf-8?B?d0dnTWVBd2xEOHc0aG5nbzJNdTFybG1YVlNZT3JWL0xTaS9CUUJLem4zZkRD?=
 =?utf-8?B?L2FBaDhTSjRpQzVrcWpMcHhEck0vUXBOeHN4V2VCZTN1VlphSExCd3QyMW1H?=
 =?utf-8?B?OG5JazVXYTZuNHNNKzR5cmc1Zk1ZQTlldXVFZVZ5SG4zZ2EvZG1QWnUxb1dN?=
 =?utf-8?B?b2dCNlY3eHVlM0ZsSWllaWVnSklpVHppRVZIOElCS0dWd2Via2tNdjVWMTk3?=
 =?utf-8?B?eWR2dHZsdTFEZWhjdmhtOER6NTRoSDR1VFU1SGhQZEZRbjVqVTFwV3o4WHZY?=
 =?utf-8?B?WndFRXlCQ24vQWZ6TjJTeFNYZDl0NEVKMjNRcEc0MENnZFQ3TWJxWWF4MWI2?=
 =?utf-8?B?TlFxSW1Fc0t4WTI0RnhtYTBralF3Rm1IdEhKNWk5WllFL0h2dy9Fc3VVYi91?=
 =?utf-8?B?OXV5K3VtMS9KbXZLc3V6Yis2OFMzR1gvN2laeFUxNnJhNGpPRmpTR0VDUTQw?=
 =?utf-8?B?a3dxZkFxb04zTDhzbmpkYmVaYThpYlJDQnp2RnFnSnJQeC9UNys1VEVhZHY4?=
 =?utf-8?Q?4BHpYM0+TMEo9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHNWelZ3Z2htdnRyc05OU3lwcXpLaHlMTzJzOGg3S1YwVDg0clpYMi9LN3lK?=
 =?utf-8?B?UFo1NW9PNE9GUXg2Y081ZDJJSzNtMzE5a3BBb2hPRTg0cUwxTVJMT1NETFdP?=
 =?utf-8?B?ODZvRk9SYUtPb05aVVRlS2FDYTJ4NjdTeDZWR01XODBPcmpISzMvRG9XMFFl?=
 =?utf-8?B?RHVZRmhkZ2RuUFNTdVRmclZDcXY2Z3RnY0ZWMElLanZ2MTVNbm1tRU1xUmE3?=
 =?utf-8?B?YVdmV1MwQW00c2UzOGx2WHhNaUxscjUxZytZMEV4dTJUeVpXbjU2OTExalRC?=
 =?utf-8?B?azB2RktwYkVkL0xrK29ZRkdqZHVYYUhJK1NzaFRHOFBCdWRsMTZ6Q3prZFR6?=
 =?utf-8?B?VGVIU2NFSmZmQU5QYkNWSjR4ek5YZk1OYVp0a3Fwbm1RZGdMcUJ4WWhPcEZj?=
 =?utf-8?B?bXZPZzJOTWZnNGhLRWx3NkdjbCtXNVBVY1BBY3BqQTh1S2trM2hvRERiQSs5?=
 =?utf-8?B?T3Jla3FIVnZNVWg0VE9QaVRHR3NXaStlVmllbVZ0R3dTYmVwSkNlQkxsZFJr?=
 =?utf-8?B?V2dyUThXdGRVaTUycFJuelpqWEk1aUhmdGIyRG1JNDhFZ1ZrL1RXenFGU0Rt?=
 =?utf-8?B?Q0pwb1B3U0dHcFc3VUhPSnlDSG9xMUVnNFVTKzJ5RjR3RjJmaDViYzJ6T1c5?=
 =?utf-8?B?R0xLNHVHWUEwcGYvNmlYK3VFVU01NjlNZWZoT3VNejV3bFd0eHQ1VDZaM2tO?=
 =?utf-8?B?MktBRlRFNDM2MWVsTW9Vd05JYzgrZlh3b0VrWEtmMVh1OStKQVl0OWFhZ0FQ?=
 =?utf-8?B?bjZYK01md2RKMjlzRHYxenRmUzhuVWFQQXlZellFV2oxZVhwclZCNmR5NzNt?=
 =?utf-8?B?SXVMeWJtcmtZTitaTTBBVkxnU3RlTythbEN3U08zWHdXYVkwclpCdm9NK3VM?=
 =?utf-8?B?OUFsQWZaeGFPRzN5VXN2aVk2Zk4vdy9vNGdwM0Q1RWxSSnRERzVLaUJ4UXZq?=
 =?utf-8?B?aDdZZkZUNlpxWElwWjJZT1hhQzV0a0RubXFWdEVuc09remhseitwTUVIcHBv?=
 =?utf-8?B?cm00T0JUL3RjT1RNS0FZK1hyWFV5OUJ2Wk1qUGpmb2E2dE81NTcvc1VhOTVJ?=
 =?utf-8?B?M3FPanM5ZmxKd2xod1huTFRrMG8wWjZEeGgzdFV1Mkp4OTFVNVd5WFZoZmcw?=
 =?utf-8?B?aTgra3BEall6ejhvT2VkcjQ4VHlzV3lqZlpKTE5yTUpONEhVanUzVngyQnB6?=
 =?utf-8?B?MTBzSnhERTV4dkdWWHV0VmhLUzEvQkhuUGp5b2tmclNzS3JZV01EWjdNTzdh?=
 =?utf-8?B?MFNWUlJ5SS9GQVJ4WjdpLzBkSTlUR3hnUmNvREdvWW82TnNPMTJnMm5TeThu?=
 =?utf-8?B?UXl4RENXSkJIY29rTUFZcC9Nb1UyZ1VvZDZmLzRoWG5nOVVnSXFaRGtiTXFo?=
 =?utf-8?B?bFFPNE5yTVltUnAvdkQxcGw4ekpUMHNGam1XM25DeHlhYWFqdVhjdXhyY0hw?=
 =?utf-8?B?ZXVOdXIycjRtTHBic0Z2aHRGTWgwRlh0b2N6Q2szVFRmRWRrOXBBNVRIait5?=
 =?utf-8?B?cVQ5NWoydElodWx1Z0lOekFrc2hMUW5vUEY4WXpGQTg2ZS9DY0xFMS9ackhi?=
 =?utf-8?B?OUlDWGRtcjRXRnJRT2huMXlPeTl6cGxDOEpnZm5XYXNEV0dUTlNyVjRDbHpz?=
 =?utf-8?B?LzFVSlptWCtITWFnb05WejdUcjJSWDgvSVpJTk1JRENDL1FrRXF5YVUyVjRW?=
 =?utf-8?B?ZmtZSTlRblhhNnM2Um1SUWlyM2ViY3VNTnFzRHhDRkxlUXBkZUZndU1BQVJQ?=
 =?utf-8?B?M1Ywd2l4VDNEUjNHbTVwbWZFQjhBWEtlbmdHTDVxcHJQUDlqck4vd2RJemlN?=
 =?utf-8?B?WG9sRFRXNmJlbXRJZ2RwREwwdS8ybG90TjlWSys2UVN5QnZRSjA2eUdTeGNw?=
 =?utf-8?B?YVh2ODVqVHVlV3Z0RnhRRWJ6Y2NHOU5aT21XeWFxUVM5V2tNaFdvRmFjUERX?=
 =?utf-8?B?OVVSeHVBYUI5bVdQNkhYNHIyeENiNnR2OUtFVzhGRGhrWVh5MVFzZTNuWUpM?=
 =?utf-8?B?dnA2VDhIeVlML3dxVjFMWGdtN2psNFBlTk9FdGlDOU10V0xnVURsbHQ5a1k4?=
 =?utf-8?B?MGtUb2F2S084dUlHNWhPbTZoUVhPVmkza2ZuLzZJYjVUd0ZobjJzRDFnRjhD?=
 =?utf-8?B?T0IyajhzLzVlTSt4Vlo1NzBwNDd4ZGtRM0czRlFFVnAvamFSSGhpalFqMm9h?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7259f1dc-a377-44bc-d139-08dd6323694c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 18:09:50.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEjDB/M/yXjwuUiguHQd1DT1gxM88foh5nekTToGFmKuTu6CRmIm4vp0tnOckZ6g20DZ5JxCpFNATh/ew6IJ0szcb6XNQpdqChngiysYsJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7536
X-OriginatorOrg: intel.com



On 3/13/2025 12:59 PM, Nelson, Shannon wrote:
> On 3/13/2025 5:48 AM, Leon Romanovsky wrote:
>> On Thu, Mar 13, 2025 at 01:30:52PM +0100, David Ahern wrote:
> 
> 
>>> So that means 3 different vendors and 3 different devices looking for a
>>> similar auxbus based hierarchy with a core driver not buried within one
>>> of the subsystems.
>>>
>>> I guess at this point we just need to move forward with the proposal and
>>> start sending patches.
>>>
>>> Seems like drivers/core is the consensus for the core driver?
>>
>> Yes, anything that is not aux_core is fine by me.
>>
>> drivers/core or drivers/aux.
> 
> Between the two of these I prefer drivers/core - I don't want to see 
> this tied to aux for the same reasons we don't want it tied to pci or net.
> 
> sln
> 
> 

I'd throw my hat in for drivers/core as well, I think it makes the most
sense and is the most subsystem neutral name. Hopefully any issue with
tooling can be solved relatively easily.

