Return-Path: <linux-rdma+bounces-6946-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2C3A084AD
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 02:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BF21888648
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 01:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BDF38382;
	Fri, 10 Jan 2025 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKz/+aRL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4AE259495;
	Fri, 10 Jan 2025 01:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471929; cv=fail; b=U3jffdFemw4Aff7hQILE3r4Iu1RIglscveFjhCG1SgjWzVAno3MdpfVExSYEWRdmvEb5jOre8e2Z58FZHsCSYVLsuERvuYxpNsbawsz6FLCna12Xspa9Y0MX6COzVgGd0tY4fQNvL87TzzM+ALKA6xMzMOYuGiUdnxhlSWbghzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471929; c=relaxed/simple;
	bh=diEGIdX8+CH7ndF8d/pq7zWz8O1gWzqE0TUalb+LJeE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DyZVpPk/iphxmtECrN1AdVIT+F7NlqtFRwePlCkpbUrwZ3a35UXl5DB85rcHpTrZAFH3oa4+0jHB4kbUsj3acOWfYLDmkjlzYer3VBWHgSggzvXbZhOT8lKA2beGZC4KRao87zYNqYlffhebS0QMdUKTb7IAikiukdcMFKHwqWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKz/+aRL; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736471928; x=1768007928;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=diEGIdX8+CH7ndF8d/pq7zWz8O1gWzqE0TUalb+LJeE=;
  b=eKz/+aRL8RJ7xRgmLEJamHGUZ/5dYsRWkM0PeWEXw093NVccs28kPqI5
   kv7R/oVzJvIROQ7rnQtoJaCwZIIRVRe63865rdguqU1KHUEFYiSRZ46Gq
   2inZ0knl0X7pgTe0GL3AqdqnCJqQOIkNQstyEnagpTik5tas+tEyYKPeM
   lv2YWSnsSEWhhB1mZaLEkFsuaSQxL+fl3FICGkBaqtP+Bi5FK7Dw+m81v
   a+vOaIo/CmE3TYocOXAFaHXrf3P5NFMiSkTLdp66B/1CN80hew7g0KwGD
   RrDKYpMoudYmGsedx+WWObcxuYcyMXW7p7ziy3ARs7ohjze4HavvBpcKi
   g==;
X-CSE-ConnectionGUID: n5CyLNFBTeSD9hl+njLbTg==
X-CSE-MsgGUID: 1+EfQqlCQMeZUGiz6xMaYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36782046"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36782046"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 17:18:47 -0800
X-CSE-ConnectionGUID: U1aBDll7QNGEiTaA9+OZoQ==
X-CSE-MsgGUID: WMm0kJ4AQuKfrslWLf2joA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="103542412"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 17:18:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 17:18:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 17:18:24 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 17:18:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwE68LYNXT4c5HLOlPXbRmQQ/4Skji0UNJ48pusCinDxT5MoThhXTCloS0ulohxnzI6CMRBSobGpN/ZIy0veIhIDORTTMgA3CFJ7SoVrFbaZQTMB4LdJI6hYs1kOGUTKS4+18mHdJgbNtsHM7bK8FnFswY5T2xm4OTP9+Gy/yNVqsnNoLA811CgeRIm3y7TRuaWyj0fl60gRgur+f35wGWLYa2ls4kPXaY4o+Qcs9lFmxkGq/gNZ5nACdRP2Ar+tipyiqI37wo+3AlTTXvR8MDpimnmDm/h9X5gVl1bXulstHdd8JUIVhKJUUhMRXF/7AxkJMg8+e0UnZamcrInPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF9nArjO5uOmK47T66I8Y8LG3xW+JmWwJcgdeIRmxJ8=;
 b=cNaDebCEVouBkdWd6N3aKN1+S2JQjwsP7tBqDJjhXZCH4rYD7+MRiomR6s3/EjhxonGMi1tQTR+ikFFObDeajmYMSmCv1WgoPxwXihuvSBLuA563kyJoTj5wHY4J9JktCvVk0CqJF3KYkgnIV0QcKLWXliJ8EXjFzs7QdRFWR84XqsLNUxjJQUFi9fTOzHgNF1Q2bZ5Yxn8Ylif/lz4GtT3z83OpDRSdcJRC1jGpF3CboPY8Yuf3IASjJSegNlU2Eaf0EeebqyYyW+I4gE93nb5LPFoee36nOQ9qxfcSiHfWt6pCz5POaG+00ktD92Hix5DUJ/aznoxhrvCs8KW+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6295.namprd11.prod.outlook.com (2603:10b6:8:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 01:17:49 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 01:17:49 +0000
Message-ID: <e6ff7e97-4cff-41e7-bcce-12cb9699a63f@intel.com>
Date: Thu, 9 Jan 2025 17:17:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mlx5-next 3/4] net/mlx5: SHAMPO: Introduce new SHAMPO
 specific HCA caps
To: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"Leon Romanovsky" <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Gal Pressman <gal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
References: <20250109204231.1809851-1-tariqt@nvidia.com>
 <20250109204231.1809851-4-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250109204231.1809851-4-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7e9452-dda0-41cf-e622-08dd311498cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rjg4dmxKRXFPRHFtb2RRd0JRQnNuMWthWTVZOEc2eVpuenRiWlBocTNseTFM?=
 =?utf-8?B?TXR3ZFpHSnh2V2VOUmt3d3Bmc0FlMktzbHN0VEcvYm5OZXN3ZThRMW43ZmxD?=
 =?utf-8?B?czdELzVwWHB6Wk5oOTZPV2pjN1VmTjNUV25XSXZQdVMxc0tGT213UTlPWCta?=
 =?utf-8?B?N2JqSVNEa0NBb0dxN2dGN3Q1cm1kYU5TU1Z3U0hKZHp1UHlCeWNiOC9GcWRK?=
 =?utf-8?B?VWVWb3dPMG5lUE5EVm1wR05hL3JURXJaMlRRT2lTejRYRHQyTmQxZ1V6Z1o3?=
 =?utf-8?B?NjQ2c3phWkI0QjZPQXJoS0l0Ni9NNXZKbEJsSzd0a1ozMTFQVVZIVGdTb2Fx?=
 =?utf-8?B?Z1h1ZlVyR3ZmMDJxTnk3U3kwamx1VjlTUlB1azBvK0xtSkJDcDVnczNWbWNE?=
 =?utf-8?B?bE9VN2lqMGJta2k1QVdsRUhLQ2ZFR0JMcDBOd3JiNEh1OXJkMnlNWlNleDh4?=
 =?utf-8?B?WWVLVlBncTNGbXYwOUFVOWVRU2tKeEVjc2VZbUExZjMyVk9qb0RxTEt4cnRo?=
 =?utf-8?B?TG9vSlpKa1QwTUh0TnBKYWF4WXIyL2d2bXFCZWlnWXJsNTk2MmRQTjB2NGQ2?=
 =?utf-8?B?QUNPRG1ZQ3VHWkRpTWR2ODVXL0N4bzNtNWhKS2xEZCtBdkIrS284YTdSTGFE?=
 =?utf-8?B?ZkxPZEdycVNRcHFMNHhhQ1VmY3ViOU1CUGRndkIzZEJZdThTVVV6SHZ6MnRZ?=
 =?utf-8?B?a0I3ZTNVVXhEY1JwSnQwT0ZpNkxrY3grWWtVV2srWTY0MGpHOXlIdHlKRGN3?=
 =?utf-8?B?ZFFBVnNJWTVhZ3BIMzFRbVJDUnNvdlF1MXc0RjFhR28wN3djSkhpL0J1ZEh5?=
 =?utf-8?B?bzRsWXB6WVVKWFNkeEptUVVpMFBnVndTcllsTEZmQ1pxVzJyMFB0RVp1S1RQ?=
 =?utf-8?B?Z0JGTjhlNkg3WGNrUnNxZDVqN2lzVXpjNnVad1NycHhjZ21MQUhNWUo5NXk4?=
 =?utf-8?B?NzhTTTc4NU51eUU5TkVBdWhVZmI1UVZlQUI5NmJaY2FacWN2RzJpM3FsNitN?=
 =?utf-8?B?QUo5ejJ5U1dWajVkdmpFb2NBZlZkU2pCOUhRN0Y5VkhONDZFVE42VGJCZE5m?=
 =?utf-8?B?RUtTY1dYMGRleG0rb1ArdDRuekhXc3pmTEVjWngwRHZoSFhJaXRCNVo1RnFz?=
 =?utf-8?B?anVrT3F3THpFVXg3dkdCazZTUWpscWJ0K0l1YXJ6c3BZTEJ5bDFaUENuNXcy?=
 =?utf-8?B?alVSTUhlMXMrN3hHZFdFWDFHQmJCWlpTZmV4KzNmZWtFT1JTQkdKTkRtb1Zi?=
 =?utf-8?B?Vk5jNU1QZzY2MGZ6U3lFL29ud21YTEptNEhSOXAySEVoY0htUmNPaUg0ZTcy?=
 =?utf-8?B?eTFXZ1dXUDA5RlJnMnA2YUdGSkFWdENvMCtrVk1mdXNXWm1DRFJYUG42S1Ry?=
 =?utf-8?B?c1JvblRGcjQ2MmlLYzdPTDZIYllDU1ZuWnhmVUJ2R0tNdnVNS1c3ZkJzR2hJ?=
 =?utf-8?B?VTZ3empDT29Ba252TG1mVmhDcGlKM1lKQzhONmlLZ25uWWJ6RUQrR2VJcm1k?=
 =?utf-8?B?a25MMXp3WEdZQTgxSElhVTVjbi93NzdPbzhPblZ4czlIV1d2NThiSmJMd0Rt?=
 =?utf-8?B?eTlTVmxUNVk0cUNyTC9XNkZzUUxzODBYckdLdWhWYW5jRXFNTTEwbkZjT2hR?=
 =?utf-8?B?Y0Q5UjRicG5qVER5WFRvdGRFQWFXeXZtc0FPYXFrQnRGUTZrRThjZ0lHeURy?=
 =?utf-8?B?M2JpUGNlM0RGT2krcFdBV1l4eWFaS0JEdWNVeXlXT0pnWmhMVUNlWG1YY05a?=
 =?utf-8?B?L3JzVTVHd2NvUDV4dXphU2U0SVlhSE9UeTN2eFo5Y0V0cUc4WjlXNUZ1ZFQ2?=
 =?utf-8?B?L2R2NnEwdkd6K3NMTkVkMkFFWk5ZaWY2cUFDT0lpbVpjVVo4N2daRUZTMmp5?=
 =?utf-8?Q?cA/vLiHqfj8R+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFBWQXM0bXpKUDZ1TTkzNE5XWTNJWDlxVmZYUnNPSGRUUHpqbi9jQXUvaTNB?=
 =?utf-8?B?OWZVamlPVWM5dHVzS05STHVSclUwbU9BdmFNSzFEN2xyVWZwMzBQTzF1eGpD?=
 =?utf-8?B?ZVVaOVBLbExBNnpUMmVUYmdJS2plWXZaNHhEVy9telZFTVJ1TzZRZ1BJSEUr?=
 =?utf-8?B?S2JYaWwzUE1VdEhZRlEvME00YktYa3pmR0tOV0NvZjhjNzhKbkRPck9DQkxS?=
 =?utf-8?B?Z0kzV0RrVUJGMVFPbWJlM2VSSnVzWXhBMnl3SDdFSmt4V3Foc1pzRithV1pK?=
 =?utf-8?B?bjlDOGdkVjZaYWx3Mk5jVjhpMTZxQlVPWTlNdW5jNnQxdlA2M09MdnJua0xt?=
 =?utf-8?B?cjIwdmFCVkljUFlXYk9RSWNXeTZkcXUranR1aVMrQVcvSEFoQmlUNDM5N05i?=
 =?utf-8?B?QVVmY2ZsdCtmWGREOW1kZ0J1Nk5keG50RDczcjF4S1hpZTEveSt4UHpUS3lz?=
 =?utf-8?B?TkVMZEh4RHU0KzZkL3l5VzhHdFE5dTNMTUhKRWRjUGRXVDl0eVhOTzJIRUo4?=
 =?utf-8?B?MVhXV3NsTUtDS05Ia1BQaVVrS2VVMm5RYnhVcFNWM0pwb056N0hKT1lvRlBV?=
 =?utf-8?B?Ny9LSkRSa3dCR1c2TEtiTVZZaWd0aW8rVXNiQ3ZXOVU1c3FOZ2pCR2ZpcGF5?=
 =?utf-8?B?K0pld3k0Vk5ReDlPdTUwK0JpQzNhV3NTbTVLcVg1UWdnSEdTR1VUVjJWNk5j?=
 =?utf-8?B?d3dTb1pmV3p6VUQxYjUxV2luTlVRMmJtMnhkWTI4RFRlOGVEcHhFbzRRb0Vi?=
 =?utf-8?B?SmhyclZ2S1g1bkd1WlB2aFRGeGlXVjFNemh5bncvbjVOUitHeUlGbFdYeHY0?=
 =?utf-8?B?dnc0WWJPcUwrWk5TSkkwK1BRQWVKaFNGMlJTZ0x5ZVFNdUhtMVNIUTVGV2Jy?=
 =?utf-8?B?dk5sVDl2R2lFcXNpa3MvdmRQQlRrMnBqL2xMSkJFR1dBRTBnYTFLTWFRT09h?=
 =?utf-8?B?Tkh0T0xKTVI5cTFVSXlEZUtPRnkxU01mTmwzQ1lVMWxZOG1EVW5ocXdNbWpJ?=
 =?utf-8?B?QmdWMVE1SFBHTEFQNWhaZDQ5ZjBIREFaYXZURU9rc1ZSbW9IdE93WWoxY0p2?=
 =?utf-8?B?Tk52WkVYb1FsbFoza0Y5dlRPaFRNd1krcTVVOEowaDZUVkVjeTJhMk5KWFlI?=
 =?utf-8?B?aWc0Y2o2QW9KOXgyYjBKbStJOFptR2Z4QlFiZEZJWDcrd0NBTVFSUFJBL1Fu?=
 =?utf-8?B?UEpLQUFqYUlsZWlpRDlXdjZBU3Z3SzBYbHp3M0JBeVZFcFBITkRPKzNQVWYw?=
 =?utf-8?B?dUFTK0tjYTZmTzFMQUJOQVUzQ3NoUnZxVTBKdlMwSU42YXcrSnpqTklTWDl2?=
 =?utf-8?B?UVFYc1ZmcURyemh3dVA3OGhlRXZ0WEFvZnpGemplNFZKUDd0N2gwMHROUmVj?=
 =?utf-8?B?OWlWNmxuaFhHNlg5c0JVWUxUdHl4OXNNUXJJWjdUTXJDeUZYbFE4Rm02c0o4?=
 =?utf-8?B?MFRpaWxjdDFWTFRSMENDVmZER0FhM2U2L2lMY0tnbU5hYnpPZWFwNldwSjhY?=
 =?utf-8?B?dFBoTUwvYlMxZDFsckhVK0ZjNUwxc1pSR2lPQStMMWUrdHlQeFpJMUprTzVI?=
 =?utf-8?B?VjNlWk0wc3c5MHJUQ1lXUFkxTzcwMllxQ0lTUXFMRUZyZktEb0pmKyt3Z2RD?=
 =?utf-8?B?Rjhvd0VXUjZjT0dzVE9MZFN6dEhaMTFrNEhtZ3pZclpQSnROYU0vSW5JZnA1?=
 =?utf-8?B?b3FVenk1d2Y2QUZxYmhNUmpwSDVzSlBEYmJGeWlyR2l3YytSdGJrYlBLcnc5?=
 =?utf-8?B?Vy82VWR3V2xWT0IyQllQN1pucTRtZVV5Y3VNUHhYU3VCRTE5YlIwUjlkcURL?=
 =?utf-8?B?eHdMdS9rREhxay8yY1E5RGk2aFl6dXFuUjNWcmlDc2I0WWo2Mmx4c1d0TWoy?=
 =?utf-8?B?bGNJaFU5d2Y3Q2RnanFLTzNQbm9iYm1Ia01BSkNwekdZQXBNTVRwTHFYVDFX?=
 =?utf-8?B?aS9zdnQyK2VBWGFKM2tycnh4QzY5UTRWSUIvd01NYXdsMXBWQUxzcWg5Zzdz?=
 =?utf-8?B?dGI5dTRIbVo1U0pTbWRsb3krak9nRFVidms1KzB0a244QlYrZUExcWhQc3h5?=
 =?utf-8?B?RThkcUk4NUhjRTcvUXlmaTlhUHRzMzRISFNOdzNYc0xDbU1jZVE4M2lMOXBV?=
 =?utf-8?Q?E14N08PbMpRxsis7fVQCf0Won?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7e9452-dda0-41cf-e622-08dd311498cc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 01:17:49.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVczH7E0FNFlHGugW8qrU+nleh8W9iZZkNCAfH1vKcQX3NzdanChwZnRQmS5cMV2jY+AhYu5fACtObAXLFeVn3efkfFTvMxy54k9sNAV7C4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6295
X-OriginatorOrg: intel.com



On 1/9/2025 12:42 PM, Tariq Toukan wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Read and cache SHAMPO specific caps for header data split capabilities.
> Will be used in downstream patch.
> 
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

