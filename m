Return-Path: <linux-rdma+bounces-6947-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F65A084AE
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 02:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E343A34FA
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 01:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F288C13EFE3;
	Fri, 10 Jan 2025 01:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPrIFx9H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD016415;
	Fri, 10 Jan 2025 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471931; cv=fail; b=WI2gHrDaAKcv8EkbinShPOiiRb5BeTgmhHCjEJITq5guw6qPBu81sLSpfnwRrZeiNlWx2ZiD7Gio4Lt+S48FLFb16wyb9c9KIHX8BaMugelSsl38U8PecsMbmxjV8sPMte8+PwmMAfejLHTB0ZGkjo2XF0Qmne8rGJy7clONtyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471931; c=relaxed/simple;
	bh=armsfCt0ak5ScagFIPnpePDl0wnDZlQ44xekBI4/msE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nHfdU4lbftp7rX3TbWNBo523LYVLIdGXJYVIjoZZYktiNZtMW4hUqfvPGabGqmhwthbUJBF5W8ok/eiwcFE3m6WpB26NT3lHBWIVLPXAqaSX2oysOBcob86Yf1Mud1f4rzDYvo8WkfhffuhXcXjSFwzeOhb3WIgj5tTF7ydR4yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPrIFx9H; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736471930; x=1768007930;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=armsfCt0ak5ScagFIPnpePDl0wnDZlQ44xekBI4/msE=;
  b=VPrIFx9HOs49w/MnMs9lShve00yQpz49fktUiZj7UclOuowvzuYS3dPj
   4IumDxtg87GwBuRkNAg5CEJvEg9b6HdyxkIlfo0G50wlJvEBruYJhbjfX
   Nv4rOdlhdWngu2TCS3gTcxes9epRFl50YbpMzhepok+3GyCrGcdDJ9U9U
   rLAllAmPMMxNKfaAvLqyUMVL//k4CCNL5R2JCUSRavucK0tZpVIyfKWP3
   ZfPm/umINnRFmAKO8BcQicr/yAZMGxqG4bhRlU99McgWhBGpP3Snxdyts
   20iVuQLl5b/3Gx0L3s3DKPfxjlCh+rXN9kGoJOu5XDofTnIADewMyiroP
   g==;
X-CSE-ConnectionGUID: KZkv/qb4QG+dGKWtAs3zFg==
X-CSE-MsgGUID: GmCqrAmOQc+IKhnloj3c1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36782057"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36782057"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 17:18:48 -0800
X-CSE-ConnectionGUID: fnS6rjyZS7Kon2KDV9iG+g==
X-CSE-MsgGUID: KnU8TLLfRHiK92ODdT2T+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="103542434"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 17:18:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 17:18:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 17:18:24 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 17:18:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXTG4dfW/ZUlpO8tAakz4CaAXe0T1963C8FIhXWuSQG8ehjhKAub9ATqVBfVsgZwY/Kpgt74DF3Urd4uBL1gU4S7DgcHOdfNmBIiItrdUOJJariCQjfIZxPbyhKueNAkY/369cFNbl+NJS41t0m57ziMPhbA2/U4R9bM/OeZujnSmkNE6LlywXlY5TNbtZU3kYXZUkuvvpKspWLkB2uMQryBdGtYH+wjwv93SnfXLkYYOU/T2B3dRq6L1GroAVLe8/akcV+re59vSgdmDfDBy27nYnHxcmapyGK/4Z8ua6etgv65VeI5OLJryberg1e6/ZLCSU8eaj8/KvtadHC3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bCOBjb/MVEtZnDl0pzosr4AgE7NKOioyNFUw++Knuc=;
 b=vmKscyM6/D01ZOGGoBacI83Sr4I5GBkwbEwGeRwl6pY/J3zN1SJo+h5W0mr8UhXljjR1/rUrHQn5/sgMaRoBPIz6Isr6Mp1esbNKoLWTHJtPlp85I0dRTwp9RfiQYjSk1h9Pz24rVU0WWqJToIm4OiYXBJXH2oEyJx3ZDs7kimWOh+PZhOd3EyFDEfHSMoiGcqgorBhK8MO6R85ZZK0QgGOnPGo3MIzLXW4fOKzHf4/wQ6YxPAxJNX6aa360qjffsLkNowvmInl7yDK96wQ4O1bnAH3xphOBM1790VEQC23UO5uyQZKWg76WGje5VidmXP/O/8MCAy3Y04kV8JpJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5269.namprd11.prod.outlook.com (2603:10b6:208:310::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 01:18:22 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 01:18:22 +0000
Message-ID: <6a7eeb3c-0142-4871-87c3-89f2aeb544fa@intel.com>
Date: Thu, 9 Jan 2025 17:18:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mlx5-next 4/4] net/mlx5: Add nic_cap_reg and vhca_icm_ctrl
 registers
To: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"Leon Romanovsky" <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Gal Pressman <gal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Akiva Goldberger
	<agoldberger@nvidia.com>
References: <20250109204231.1809851-1-tariqt@nvidia.com>
 <20250109204231.1809851-5-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250109204231.1809851-5-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5269:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e16cb5-2a74-4948-7141-08dd3114acab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmFBS2lpMXlCYUtRdXFSYmNnUUJFRmtFd25nNlZzdkE0Nm5XMFhWSUI0Znhk?=
 =?utf-8?B?cHJ5OHpDeTVRemVZdm56czVYOHNwT0FZMUk3Vmlaa0Z5bHN3Q2liVm0zSlJV?=
 =?utf-8?B?S3FzZjluOW0yanhpbWtJaVJUNlB5c0xRWThoa0pvWVdMVjJQNzdZSzk0Z1pk?=
 =?utf-8?B?Znh0ejdwRmREUFFtN28zdldYR2lEbHAydWNURWhOYy9mRkdObFl4RS8wY0Jy?=
 =?utf-8?B?SGs3bTJ3M3I5cTd1ZHovMXhKWVNUeXJaU29NbXFvcGNZMktQRGExb1pmZ1Uw?=
 =?utf-8?B?Zi90OERaaExzZEVHaE9LRHdERmJsMVVTRFl2VUhhN0xNUFZYV2NyRHpOelQw?=
 =?utf-8?B?ZTZTYWZ5SUhwSUZnRU5DQnNrWEdkRE11Mi94eDFkNStpOWRMcTVPT25EVlhC?=
 =?utf-8?B?cTRNbG90VE4wbURHZ1RNU1djVTZwUGxQdTE0UFhNb1l1MGNkL094dXFZOUpO?=
 =?utf-8?B?S3NoOVBvNm8xSmJDZm5hc3NmbGw1L1BJNVM1ckJ2alYzWVM2VEV0N3J0Nk5o?=
 =?utf-8?B?MXNvRVlicG8yV2hLaG56ZTZsS3c3YTNRZVlQbXdDbGJ2MFBlUGVUbjk0bk40?=
 =?utf-8?B?OGZDUHVsTndZUzF5b1lqTkh6d2pBcDFCL3FidG1ZUVEwR1pTa1pKdjlSSjBI?=
 =?utf-8?B?QVhFZUxXaWV4dm1nTnJ6VjhZcFVNdDZSR1pTUVBScU84TzdXaFVnV3VydE8x?=
 =?utf-8?B?Q1E1Rm1IV3l5MmFxMWptQjl4Rkw5ZXZQNWpSY0V2c0dpLzh2aVdZOUhOcmJh?=
 =?utf-8?B?N3NBQTJTK2t5ODkvdElmRkJBV3pEU1NJUEtUMDJsa3BjUjRFcTlZSjl2Rlps?=
 =?utf-8?B?U1ZodlQ0WGxXNkxPSEIwcFBDY2taWGs0clhMcjB4OEhLVytvNXRNUk50Z21R?=
 =?utf-8?B?cTlzWENqMnlObE94bHVJanZiM0xlSUlEbTRRR3RNOWc4QndzdGlGQmNRZVFv?=
 =?utf-8?B?MDJQbmtNTFJZZTlBT2RRcy9FOHBzV3k1dGlwMW53QmdTaFlwaE1EaXFDY0k0?=
 =?utf-8?B?STVheXlLUFRvdk4vSFNpQ0ZGYThuZmdSaVpkZTJGZ0pHNDBrRnJKdXFCRHVQ?=
 =?utf-8?B?T09pdDlKMlpMTnFmUFNLdHlXbU1ZRjJndzI5M2diYzBaeFJIOU1zc1hSVi81?=
 =?utf-8?B?ODcxWDFVRjBESThDTzJ0SWVieEFxY2dVcUVYWklhVGhnZ1dqaDVTcHRTQ0ZO?=
 =?utf-8?B?MXVubE1BcURKSnJqdisxRXNJa2Q0TElMWHNiTlpLZDY0NGEyeWdkUXdsRmZY?=
 =?utf-8?B?ZFEzb1dBTm1KeWZDWUFUaWZHem9hQlV1YVpYeURuSzY4R1VTOTgrV1BvSGsy?=
 =?utf-8?B?OXBKdmVrSEJjMUx1ekttclZMcmhkRnJWenpKZlY4NHlSYUdlM21ORlExWno4?=
 =?utf-8?B?LzZTUU1QRjJqRC9iUXQrRklteTRpaUdIL3hiMUVoY3ZPbWNhUXAvNlFEVGVD?=
 =?utf-8?B?SG1KejB4ZFNNMlh3aFQvMTloak9qR1NlR2w3SW41OHU4aFpPS3FSaVpaYzJP?=
 =?utf-8?B?eXo4cDcwek83S0h5ZEsyTm80UkZpTnRBdnY3UHY3a3lQMXJnSDg3aU52Y2Y4?=
 =?utf-8?B?VUtGWHYvNXFhRk1FbDdUTzR0WDRhc1ZPU2UrRGFUN3hXY3JWdmZxZmhRaFZM?=
 =?utf-8?B?UUZvV2ViSit4QmJadDk5bktiUTM4b0dGdlRMdzRGcVhBY2xnblpOdDFIRTk2?=
 =?utf-8?B?cmlpZUNoR2lELzdQdjA1dk9OeGRFVE5ISCtFY2hWQmZhd1FGMGt4T2I3UElt?=
 =?utf-8?B?N0RlbncxQktwa2s2TVJxRmNrR2ExNEc4T0hEZ2hYTkNGYnlVL1hkOElEZFhT?=
 =?utf-8?B?QU1TSVJ0SnNlSVBYZGNOcXF5R3VScG1wOStzbXprQWdob29OUTVKOFJsNHpN?=
 =?utf-8?Q?bEhcj1xD+vosk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0NEMzNYaGRQL0UwZHNVVkZUSHJPcWZ6ZmRQRUFKeVN4UDlUaEpIbDgvTGhh?=
 =?utf-8?B?MVVJRGtKSUpRMVY2Y2pnSXY5dVlHY1ZWNE9QRFgyeldnQ283QjMzM3BldTA0?=
 =?utf-8?B?c2xsNzFIVEZBMjB5MTFjcTRvbEJkdFhjemhQb2FpTjhvcHMyMUVyZEl1a3hn?=
 =?utf-8?B?SmkzL0swNlorNTRJbGptSjZmZDJqVHJ5VmFYUUhLWVh6S3EyMzBpN2ZvM05T?=
 =?utf-8?B?VlMvZU9EWGhrZnlJUitRaUdlbHhEYmN6YStiUGM2RlBSNC9ZVXlJcHZPWVZM?=
 =?utf-8?B?QmRDYkJMbG5aemVTd1lvNkgyclhubGNOcjR0SFVZclp6US9KWjd5b21SVDZT?=
 =?utf-8?B?V00zMnBPYXE5Ty9KSGIxcnRTeWx3M1hUOWJPR2lSVWVhL3lCbUxvb3JlOUk5?=
 =?utf-8?B?RlQ3MmE5aGRsSTU4SjdtRndpQ3IweUk3U2dFRkFmb3hQaW5ucHdzN3BTbURO?=
 =?utf-8?B?S0l2bGl4ek5GQklqQzdOTmNRMEgwVWVKMWVrVFJPNXFhNDFJQ1lVT01EYTFU?=
 =?utf-8?B?NGJ6c05aNldHbkNieUlYakRoK2ZsUnAyaVNuMWtWVXUydmF3MUpUUnhZVWNB?=
 =?utf-8?B?Y1B1RkI3ZlFNYmJFRHduTXNkdUhNdGl2QklLbTdySDd2T0dQd1diUmNYeEpy?=
 =?utf-8?B?anJBRVhwRzF3SUltdVRqTkVqb1N0ZzZjTEJudjRRbE9WNWxQdTBZUWFUM0N0?=
 =?utf-8?B?RSthZHFuWld0c3NhL3FUVmluQUZWOUxDTUs2Y3dCNURkK2NUclB1QlZCdEwy?=
 =?utf-8?B?MFYxOVNLODdDUnFlRE9kNkNLV04vaTZnWU1WZ0VReFZDeTBXaG5rQVRPNklk?=
 =?utf-8?B?U254SG1IVFQwcG9NbW5wU2ZjMS9iVXYrb29keUcwb0J4cTVUUm1HUXFoWnhH?=
 =?utf-8?B?bVdYUnluVTV6YXhqb2pFZmg3Sy9qRmpIS0xkL0wydEE1L0RMeHlXUGVCVSsz?=
 =?utf-8?B?ejRmTGdrakJ4UkdRZDdVaE1CTkRzajN3aE9tSC93TU1BaTJvTXI0ZUZmWU5y?=
 =?utf-8?B?UEFEMHNzTmpLaUVyVmF5M1ZtOFdsRzYzcjN1Z1pJbDJxbTk4SElnd0w2T3JZ?=
 =?utf-8?B?V0lBRGcyUVR3RmFQcWVuK0xWUUZqNm1FcDRoM1IvaWVWQTZweVRoVTJ2cFdv?=
 =?utf-8?B?ZE4wVUlmdE1IcWswREJiMytSbmFaOGk4WFdnOWZsaDlBcERRSDJlay9TMWhT?=
 =?utf-8?B?OGd6c2ZuZUMwSHVZSHI5MUtQSEJyZys5RmFmR2UrdzBnUFZCUC9ZTG1KT2dQ?=
 =?utf-8?B?ZkRBRWJVMDJzZC9MQmROK3J6bEJTdWpJd1ZEQWJoWlhrN1llZ1NjV21nSGlv?=
 =?utf-8?B?VERtcUM1ZlJINGVQQ25HUjVUMzlTVkt3QWdYR0VGb05RV29HSEdDNHZwcFB2?=
 =?utf-8?B?S21UdXcrblpMZDdnQ3pQMk9kQWpUTWxYU20rVVRRblZXQThrL2dlSlN1dmpT?=
 =?utf-8?B?a0JRTnU1Y0VMREdVYnRGS2k4eGc3Z3JHOGEwci92c2pGUkorK2V4ODVpZlV1?=
 =?utf-8?B?VDB6bjNzKzJsRGc3UEplZmZ0OFp2aDhuT0NVODFMZDBmWlQ4TDdwVEs0aVNB?=
 =?utf-8?B?T09rR3ZxcXJzYTVFQmMvUXVoZ2RkYlIvZ1hNcEE1S1k5L0ROcnk0eWxpTDZz?=
 =?utf-8?B?UE9iQmR1N3krbTJJc1hFUitnZGY5QTJkWjkwbmxodkVwWVVLMDNraXFYL21Z?=
 =?utf-8?B?MUxuWkViMEY1R1NiUWdJYWkzenFNRUZEbTdxc0N1UDZnRCtaK2NBbUI3a1BV?=
 =?utf-8?B?MGltUm4xdmF4WEJ1NG05Y1NXeHIrRUhTNkNPWlkxVnNlL0paWjc0VUY3LzRk?=
 =?utf-8?B?VUpuN0tzajArLzA2TEoyU3liQURKNnovZE5JOWk5eGM0aWxiQ1FxM0h5eTNr?=
 =?utf-8?B?SlByU1B4WVdvdHhScjFDRDYxZEs0cytGQjVGcFRobXVxdG5PODliY3dYMzE3?=
 =?utf-8?B?L1Zta0YwcUVTSEFCaE5TZDZleDNRbERUNW1MV2ErS1hzUUlyS2VmT2FYNVRY?=
 =?utf-8?B?WlFVbTRQYjN1aWJZa2pyUmRZMzZyZ0laMjJRSEVjN2pmV2VrYnVyYXVuQllK?=
 =?utf-8?B?Y1U4b0tmdFBTWW83YlZVY2pNZnJCeDNVUXVnaFFmcENNckpZbjU0OURCdlpI?=
 =?utf-8?Q?1zQmQLPydwDjrFg2To9cZ2IWP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e16cb5-2a74-4948-7141-08dd3114acab
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 01:18:22.5263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOmRWDcI7Q6ujONxqCa98UExkNz7XyseOXacSifJg40XxfQMoWFo//2nP21uqxllV92xB/MxBW53sfPo08ZKja/1xGdsFSu5gYPhUEzVk2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5269
X-OriginatorOrg: intel.com



On 1/9/2025 12:42 PM, Tariq Toukan wrote:
> From: Akiva Goldberger <agoldberger@nvidia.com>
> 
> Add nic_cap_reg and vhca_icm_ctrl registers interfaces for exposing ICM
> consumption.
> 
> Signed-off-by: Akiva Goldberger <agoldberger@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

