Return-Path: <linux-rdma+bounces-11368-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1B4ADBCAD
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 00:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E411893175
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 22:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBF822576C;
	Mon, 16 Jun 2025 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1Xa/BYB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29881224B03;
	Mon, 16 Jun 2025 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111933; cv=fail; b=BwZfjh80Hlan6mbqtgn4ep10mx8A6xP5f/LjP9DMg52d1fee+mnpbBMFeuGPHeNuk9bhGijkrHqBx2IrnKzEdJHEluSUt159OLIW5xHmgI0F5yn+y3uLfhbW5cWl15hVQvICXmka0pt+BUNergOFAHMnG8zD3ccbBuyx9X5xj88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111933; c=relaxed/simple;
	bh=AbjpjKicwYmhAwhv+lPtQP3i/rp0Krnrm30FGPyACn0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c0ilpfS5VBtVxU6l7rRYKHX98yY/I546m67SkHAfBd/V8fQG/4AETp/mb8gOfjIgdBXQDEaoJO0njCTesttL9ZqzLBT034u8rz/AR2kRMn7z+mmyoWeVnHasphcI0bKmTGrfGaZCOYLGGNE3OrCLuM3ue2pPDoBNW2fj+AewPS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1Xa/BYB; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750111931; x=1781647931;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AbjpjKicwYmhAwhv+lPtQP3i/rp0Krnrm30FGPyACn0=;
  b=V1Xa/BYBMLFXaOWiEMPdyOrvDtJDJWlee4hU3eIrB2lX7J3I9rr4qqG6
   cS/3O+CozQCcn3SXtJwnjNh+30LPYuS1J5uaAmPTFbCPblvGo7yvNnpyn
   I7vylCfVAwAy3vxvmdaal9uIHsMLaplacqmZLdAvzX2CnJmSj46sIipIK
   ev8objOpQVfA7H2ddlzD+fVFTfGBa1jYUhOgSCAx35xYFI6KUEB7lrIYP
   BrmE20ab5+ddQUc1MurGh6ElriwRsWIqUUWnEfSq2AwxIWXcDB8bFUUL+
   2x3li+N81gaMV2GN3F8uiOWzroEm3TrocarVDRa/Gav4+FFs/CK9kY+iq
   A==;
X-CSE-ConnectionGUID: C+Naqbt0QW+Dp269KIXs3g==
X-CSE-MsgGUID: AVV+4LYQR5aRwRCvVvY4qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="63301169"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="63301169"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 15:11:52 -0700
X-CSE-ConnectionGUID: ezEGa0TrRySb1p6QPv7NVQ==
X-CSE-MsgGUID: 1GsdHBEuQgGoSzdmKCRx7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="148581468"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 15:11:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 15:11:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 15:11:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.76) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 15:11:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIYLS6+alTFLPfoPD+GXCTMRczYHytvomxaYcb+ark05sshUTOLkf2HKR+YuDTsqjlapB7At3QTvgE19rMnFVyCNFdoza6GD0angHTmsX5+3CO23h1Axr18wzK5mRwkhvLu20us2pPm7lCYKKPmU1SoyPLV07IQwVGLdZ9+eNb+yzuXsBM49H+MB86jtPl7OX87HL0JpuxzNbuOpiJ3BZ0zV+f19VSj5S/D9V8uzieCC9bMWL0xN3ksOlW0ySxCRxrF9xLjXQwCBzMsPozImWlfdB9Ze8VI5Sw3t4AjY/u4GPHaEfb/HEIHDJbpjwE1iPFSXiRqTZww4BzDXZvpqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjKWQOUXbJt+5ucRvC9kqfh6KMWEG439vVSHZR62Z5E=;
 b=hGLvSrEp+UIu+bFy523twEnBhQe/IIHc95Qo4Sl5gjTBnt2Y23OTT1IVUxQYlg8+p/MxtnJBz96+VwH880PwB5zXV2HJfMUzJZi+oMCmcE8YnJgNHJcxJTvEdeZDPQLKv2S6G1svd5CWghUVtZnDD3pRBx9G4S8FCM2uWki7s/Z8xsXPTgmj4vscOHf3KDGp1YRDs0yHHY+UUH2ngAfIiUu+9Kb+jy+rXBgzxQtE8EnDJyMFrCYV4R+qZIT/KlfdyrmJDKUlDW3hxCv40uKeCKEXXWle0podyWTX4kTXb+mh5Y5ZwGa+sob50pnm1AEqP+svXhim849OQgaN+uLJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7292.namprd11.prod.outlook.com (2603:10b6:930:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 22:11:47 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 22:11:47 +0000
Message-ID: <4e3e501e-d89b-4eec-afa1-3ec78d5a6527@intel.com>
Date: Mon, 16 Jun 2025 15:11:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx4_en: Remove the redundant NULL check for
 the 'my_ets' object
To: =?UTF-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>, Tariq Toukan <tariqt@nvidia.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
References: <20250616045034.26000-1-a.vatoropin@crpt.ru>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250616045034.26000-1-a.vatoropin@crpt.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:303:b4::35) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 305bd6ec-3e5a-4fbf-71b3-08ddad22c8db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3gxVTZqTGxWT3MxdjdpYWdQNG4yeEw4aFp5RGZLdVV2UkI2bFkrWXZ0dkU1?=
 =?utf-8?B?OU5TWW5HMEdnSHUrY29MY1pESDl0eTVrOW9aQmJsWS9YK21hSWlmMVpxMGZR?=
 =?utf-8?B?UTZhenFjeDB4K1N5Qmw2YTk2YmNvczBzek1UUkQ0WWlyT0lBRVFVNUQzZjZR?=
 =?utf-8?B?Z21BWDdHVGk4bmxIQURJbUJOTUZEZEN0eW5KT0JxVHJld0JvL3JPQitnNERQ?=
 =?utf-8?B?RFRUQ0ZSYlVyOUthQnhhN2taTDBmR2NnRXpKUzVVSy9PTlVCa3A4Z3B0Z0Jo?=
 =?utf-8?B?ZjBBT2xPTTNMNnI1MTBNazZHRjlYYjU4T1VMblZobGlsSVVpQlJmSkpjeE0x?=
 =?utf-8?B?Rk1EYVJBNWVmK25PeTlwVUUzMlA3dU9NNzhMK0w3Z0xHcmxha1FJUnBXTVdy?=
 =?utf-8?B?dUt5U1hyVXVTbGpOTGNJT20vSDJRanJIOGFhN2szc1R4cHB2M1dUUVI4clVv?=
 =?utf-8?B?UHBOOXlBeW5rQkcrUDR1Q1EyOHliaE9MV1l2QTJTZHYxRUJGOU0va01McDNZ?=
 =?utf-8?B?TmpJUHIwSTNZa2xxTEYxeWMrYXpZZ0R4RS9qeExvUWxuMzRLcU14YTFwMG9j?=
 =?utf-8?B?YWZEbDUxSGhQamsyUGR5blQxNzNONlQ1L3VZZHZEcHB3MDB6d2ZmcDdJUDFo?=
 =?utf-8?B?OC9ibTlYem9jc2RrMGpSbXVrVmR2NEpTL2tTd0xKc2pFbVJFNGs2bnAwdTFz?=
 =?utf-8?B?N2V4MFhqbitFSitheTQxa3dZelpEWFNSQktlWlZrRldXdkpxejJZUUpwSDV0?=
 =?utf-8?B?S2I2OVdYVzVGdHhKaFFaaWQvYzFNeTc3eGF5eUdzWloyaTFocUdMSG54UmFp?=
 =?utf-8?B?MXY1eTltSDhvdGVUNmM3STd5bGFkdGFub0N2dEZHSDQwcFZhbXhKelBLYnM3?=
 =?utf-8?B?ZWlWQUJSUGVLMlNVZ1BHR2dnSk1Iandsb0FHczVKMXEzSXBXb09PNmdGTHJP?=
 =?utf-8?B?ZURhUi92cytWN3Vyb0hZVVBNYjVEeHdtWUFpOFJ4SCtyWVRWZWxuTjZSTUlu?=
 =?utf-8?B?UEFVN0lRREc0bTZXMDVnUGdPN2RkSFEreWZ1WFREQzFTQ1M2SWlwUElKUnIv?=
 =?utf-8?B?RSt3em9MVEZtbzVKeHFYUHdVVGk3bzdCcmJBa2gzL2RndlpEenVJZlB0SlRH?=
 =?utf-8?B?OU1OajNFLzljQ0lOcnh3cG9YVGJUWVRGV0k4UWtBZGxuSjJIcUZWR3BqMStG?=
 =?utf-8?B?eEFxanFjYjkwZHBlUWNyT0xJaHBRbzd4Zm5GY1lLRlFwL3N1V0JDdTlKbkVN?=
 =?utf-8?B?dmt1SmtSdlF1UUdUZkpDa3dHYVZ4NnY3S3FDS0JUdkVKVlR0RXVEbWFFbEhl?=
 =?utf-8?B?MjE0UkNJamNVU05zcE5yQlVJSTlQNnROVXFWejE1YkZQa2dacitxQlNybDU4?=
 =?utf-8?B?Ni9YdzJkV1JuL0tRYnR5aE1ZQ2MrQVBkM3p0YWJjZmZVVllpWGYyRnN0Mllt?=
 =?utf-8?B?TlZUL25qb1NKN3llSlhoMnMrOXVSQys2TnpDY1ZpZXRLNVhnNmIrTkhMc053?=
 =?utf-8?B?NmRWa1d4cGpwU3R1ckI1RTNPUUpwVE1rT3ZGb2c3RjVieUs5OTJXMjYvdGth?=
 =?utf-8?B?R1ZnT0NUNVRiWWFUU05HR3NjdWFESURtUm1BL1RHdnJyVEhMT3YvVXF0YW1B?=
 =?utf-8?B?Z002OWZ4TjFwSWYrN3R1bXk0azN3dVBFKytuc2p3Vmx0dkZzWG9qT080d1Z2?=
 =?utf-8?B?blptTEVLd1pRSEZ5eGgycWM0Tk9jN21XUk9zTnFSa3V6OU1DR25LNC9jUkhZ?=
 =?utf-8?B?R3FrOGF6MUduSDU4SGtvaFhZeE1PcW42cXY5Ym9VQldGQmdMTTgrREpIWFRw?=
 =?utf-8?B?dVpGQzMzZ1FWVEF5a1owK21ZMnhpVFJVMVRNdUViVGpPNW8wbWYrSFlXc0o4?=
 =?utf-8?B?NGlLbTduVnV3NVc0WGgrS3pvckN0a3MzdGl1SHQ1MlVpS2FHbXo3KzVxZG1z?=
 =?utf-8?Q?1oqi6HB8lrc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmthSXlaVkVBTGhqdDVpQS9nUXNPay9XbjQ5OTQ1eHBLb050NUt5WWN5eU1i?=
 =?utf-8?B?UEVaRGlNUXFNUTdlNjB6Z3NLV0s3WnFmcXBtYlhJVmsycS9LTit3QzFreUtO?=
 =?utf-8?B?dzN3b1JkeW1qdG5LQ0ZhNWg1Mm0vaVc5UC9oZ2Ivd05aNElGeHpXRDQ5SHRw?=
 =?utf-8?B?Z0M4ZWFhaHZYaXFBZjh0M2Fway9INmFmNVBhcTVKcGZuYkZIUzk3RWpYano1?=
 =?utf-8?B?eGJ4YkJOaDNpMHd4T0hpY003a1ErLy9LdGlPcHV2eG1CSTluR3JHZHE5M1NV?=
 =?utf-8?B?MFJpVk8vMFlQY3JKbldDaTNOdGtpQlN5Z0xqRlg1VE1IblJuTlFpLzFlNmFZ?=
 =?utf-8?B?M3ExU3E5SS9mMTBrVkdaVk1VU1lOVVdnT0NNNWh4c2txUndoUnp1M2dsQ0wy?=
 =?utf-8?B?Y1hpbC9BZHhERDk0YTZPMm5oUjR0UTQ5QlFFb3BIaW9wVEVUY3ByUHVwa3FL?=
 =?utf-8?B?ejZXamhka0N0aTFsV2tOVkxEKyt5MjVEK281VEJTMVFBVjBoWjdNZ0pUemV3?=
 =?utf-8?B?M0kxd2ZBaGNJS3YzUmZ1enNMbGQzZ1V1MGZFVGptUW82S1VsWnRWUEFOSUh5?=
 =?utf-8?B?RUpLQmV2YVlmcjIrSXBIRWVWQnZ2QklXUkNhQVFlZzgydVdteFErTVluZmd2?=
 =?utf-8?B?cUdTZkVycXgzUDFSbGpOc25KcHNHR0N1S2ZJaXdxTlh3R1JKd1o1bGhZTCtw?=
 =?utf-8?B?WDBmSzQwMUIzK1JBLzJIZTQwMWhETi81aUVpYUdWTlFKUUJTYU5vS2JZNFFr?=
 =?utf-8?B?bGVnSStRclluNUc2UEtFZmhoZGt4YXFvMmxwOHF2Qzh1am1wVXZ6eDJBOTd0?=
 =?utf-8?B?WXplRllBSDdlYjJMcGJDWnRlQWE0ZzlYWjFESTQybnJYbGVEYnJlbDdpYzZk?=
 =?utf-8?B?U0tOM25qRml6bGh6WXhZNDh0NVVleHZJbnMrdWpsWWJUeExwYkV4eThWSDFC?=
 =?utf-8?B?WUExMkRnSmUyUWN2OUdhWnVtaks5WVE4R2hFSU5PY3NkT3ZDRldyYlNDVVFQ?=
 =?utf-8?B?OUVBb3B5UjRBZEwvcTJKRE5CQlQ3ZUJVUU1UQXpGbEI3d1J6ZGRFUHJvdDZG?=
 =?utf-8?B?UU04RG1jaGhSOU95UHYvVkRVMmJzZkRvT2xXNTZhYUFBdXoxNHhUOGtXSzg4?=
 =?utf-8?B?ZmNGM0NITURTSFFEYmUydjVyNWdIeWtWMTVtZ0YzWi90dGpUaEdOVVlpRzZh?=
 =?utf-8?B?Y0Nrd2F5c0RBMDltaTR3M2ZNQWwvVzFVcHIxVWFKT2M0bGpqN0oyK2dHaVU4?=
 =?utf-8?B?UnJwUmRmdGxIcEIrZ2RPVnEyUzBveE9nczhYWjUySVhNR0E4RGpRR3Z4Ymgv?=
 =?utf-8?B?ZmtVUUY5UkhRN0NEbCtVdDRNZDRpRzRUN215anR4cmRFWXZrYkwyTDJGcU5U?=
 =?utf-8?B?ZVYzVEVZd0dDWXE3Tk10SmtkWkpzTVNPRmUwS25oWjhhTjRodGUwQ0pUR2Z0?=
 =?utf-8?B?YWY3M0RaQjhFeXZnTjNyTUFUN3dRZ2tXWlBrOCsvUzNsZ1lrVC9kUld6QTc1?=
 =?utf-8?B?YVpiQ25qZ3k0WnUybHJqTTFRMlpqWVhsYXh3TWY0eE1HenkvQ2xTNXRkNDBS?=
 =?utf-8?B?L1hoaE9aSDBlUGJIRFk4ZVNBVmkzM0VkdzRYTlV4SUlmWWIvVkI4N3B3TjRa?=
 =?utf-8?B?UHZuNU9TcnkrQW12dWV1WUExMlVIY2lkbHFlT0ZmbWIyajRQOExpWHl2MVdv?=
 =?utf-8?B?Uyt1OGZkU2h5T3lsNlBiS2JydHN1YzR2UUpxY0tVZVh1NUhkaEpxS2tpdmFw?=
 =?utf-8?B?SlhVYkxRTzRZVFF2VmtQeDllYzFrUFV0MkVMSTYrL2FoNEdRNmJYR21zMUhk?=
 =?utf-8?B?eUE5Wm1sTHV5cWR2cHZZcDBjeE5xQVFNanZQZTFuNlpVb09vNWxrNTZlUFFt?=
 =?utf-8?B?RHVoVDkveWkvamxwbk1hZXFVVlhzd3pLNEhoQUJvRHNkZlFVQkt0QXpvaFRQ?=
 =?utf-8?B?YlpnWlFYU0dLMjBWdFZYZjNWU0IyOWtGNXY4bURmVStnWEt1OGdSYlZHM0lz?=
 =?utf-8?B?azlQcHNKL0IzV2hBS3puQ0JnMGhsSm1UaWF6KzFINndld1A0ZnYvbXMxVmpt?=
 =?utf-8?B?bW8yVEdlcW1UTGZFWHNzd1RKblJyRUlVY1lXOHVzMnBJRlVacVR2SWQvM1h2?=
 =?utf-8?B?d3pGVHNONC85cWY4ZHIvWGdjbzBmbEZSZDBBc3FUWERtSHJ0S2R6dWRYbkl2?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 305bd6ec-3e5a-4fbf-71b3-08ddad22c8db
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:11:47.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuTVOLtzF2Sdg2nN/0r4hcoMgCFtcyS+0puTzpNAp9ZCKPcn1pq2iX9E+9JpFSXUwv5aSzjb7vgC/p1VqCLRT9MG3Za82twHi6G/iqHqnXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7292
X-OriginatorOrg: intel.com



On 6/15/2025 9:50 PM, Ваторопин Андрей wrote:
> From: Andrey Vatoropin <a.vatoropin@crpt.ru>
> 
> Static analysis shows that pointer "my_ets" cannot be NULL because it 
> points to the object "struct ieee_ets".
> 
> Remove the extra NULL check. It is meaningless and harms the readability
> of the code.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> ---
> Resend for net-next. Link to initial thread:
> https://lore.kernel.org/netdev/20250401061439.9978-1-a.vatoropin@crpt.ru/
>  drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c b/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
> index 752a72499b4f..be80da03a594 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
> @@ -290,9 +290,6 @@ static int mlx4_en_dcbnl_ieee_getets(struct net_device *dev,
>  	struct mlx4_en_priv *priv = netdev_priv(dev);
>  	struct ieee_ets *my_ets = &priv->ets;
>  
> -	if (!my_ets)
> -		return -EINVAL;
> -
>  	ets->ets_cap = IEEE_8021QAZ_MAX_TCS;
>  	ets->cbs = my_ets->cbs;
>  	memcpy(ets->tc_tx_bw, my_ets->tc_tx_bw, sizeof(ets->tc_tx_bw));

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

