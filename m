Return-Path: <linux-rdma+bounces-6190-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE949E18B1
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 11:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E52D286364
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 10:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842D71E0B6F;
	Tue,  3 Dec 2024 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3YYm5go"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6311E009A;
	Tue,  3 Dec 2024 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220147; cv=fail; b=LH1EVTzh8TcR2LQue2vw2UnGTebbq1dB3bKqMBW9jpVi+eFq6o5P+FsikzDMB5C18hfSh4DKLXBkOjkHHarxcU0T296FkXLdGixO8N5LC6ZlGQc8rJQxyAi5ItM8H8Xj73FchWI/cNtWxjSfbZDWKXdFkIRhIr4sw3QPHieZXzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220147; c=relaxed/simple;
	bh=yPxCL9393zDrWHGE0aniZQIRf44f8ZR/oYfYV2DxM9c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JhDfmLhHSI6ZngpnIc+++lNTolkTTl7It4vcxvyTzustIlrip0Ue0hCWW8L/ww+rACKZNBczza+HYzozuhKO6TKznc/2AmsPFuAnFcfHsaAt8X1MdPFPOAg2qvQQLslqjhKXl9hztm1A5cb9V3Q2684iV/8+3DSGKcfORxF0Eqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3YYm5go; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733220145; x=1764756145;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yPxCL9393zDrWHGE0aniZQIRf44f8ZR/oYfYV2DxM9c=;
  b=Q3YYm5goO5V8/CrP71zf0tuq9ArVjm67Jy42zBQTllWWJq7GoTfuQqKc
   0uujXPAFhRbLTnS0bmocTPrAWTZBzw5iiiS24BqEnu0Lv4icomykiuQBx
   PxGAuuvGSNwiYdUie7mOAYLa2mlYLYPvy2O6e15f50Z9xk7P5YdXAfEzS
   r9MGO8lx3Kkr0A/nAnL7G6bOyYTC56FTJKBdf7PCVovcVetXtFiySkYtD
   da+8Dq3TTyM2H9Jg704KnNP2oM02NDGihTavqPyiO5AqxN4Tfj81CdCvF
   FhDLaVA/Pl7ije5yzpLo36Au80UH4eNnr2SI9ywHH5UBWEfsBWEZG/PX1
   w==;
X-CSE-ConnectionGUID: JhBeCrv3SImIf9fFtMAmMw==
X-CSE-MsgGUID: JglVxjPdSeyrIrLy9E227g==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="50950122"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="50950122"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 02:02:24 -0800
X-CSE-ConnectionGUID: M2MRi1QETSSLI9+DmKxdUQ==
X-CSE-MsgGUID: tUa3r917ShinYOErVsCjRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93474044"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2024 02:02:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Dec 2024 02:02:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Dec 2024 02:02:23 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 02:02:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGiBBcJ3GTE1AVnvkoJ+mZahLkUuG63xkdbalI3wcC4QauN8zKiwUKQO5kDP5JLWOQnb+BGdKdWovYSddYdjRbNj3KUG2dgLyu3GzT1wX2e9K5bjZr8RHm+O70DJmxmlYmhQcS34QqSYvtVMyIzPTTl40ibOz1EzwybuELVuTG6VRH9dQ9sky6ZivOQOmnNZSdwUJhHS7azgN6K2KqJyV8P9+GuHoTDTZKAlp83ow5QMINIuoq+gLdqnYrrJmkjHPwbgoIqHAYiybwPHF/HKh0wmXiWNcXfAbjIEfzS3bGo12kBa0/FAUZjxA0UDfMl+wV9RM1gmYcEBhgTnuez15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yodLZCItpxom3CNtO9UEULq0kNMqzba0kYh2EijE1Xk=;
 b=DnZJHgWZGtHr0ZN0U3VEmpA9zQT7X4XhNBeHHTIytdWki7iO6YJCzUMQbmcL5Wcx+nqOfxkrL5m55zpoRSPGu2aoxB+2g/1cvzPgJjxZwHxqS/m8c0+bLAX6/XPMHHwSNuQSZ8ZEwYYS4PR7jJS3Tu8i4JtAFnU67yChM9BN6Uaefp/XxmRIvEZLxDrLjzl6Uq7obK683XrpmTgW5/lMMua6TPa/3erYQpZOVVwJXkmuG56hm0TYWJHJVxvsnBuBxcZtkBzZkTTAv9cSCdQREfoRYJb1CAISDKq68MjwSSOX/u8LZ4hZzU8xw3quJOVtLO5GetxLMz5/cCevQpjFbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5399.namprd11.prod.outlook.com (2603:10b6:208:318::12)
 by PH0PR11MB5158.namprd11.prod.outlook.com (2603:10b6:510:3b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 10:02:21 +0000
Received: from BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc]) by BL1PR11MB5399.namprd11.prod.outlook.com
 ([fe80::b8f1:4502:e77d:e2dc%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 10:02:21 +0000
Message-ID: <93a06b66-ab5e-4722-9270-cf892470d004@intel.com>
Date: Tue, 3 Dec 2024 11:02:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: DR, prevent potential error pointer
 dereference
To: Yevgeny Kliteynik <kliteyn@nvidia.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Muhammad Sammar
	<muhammads@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
References: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
 <ad93dd90-671b-4c0e-8a96-9dab239a5d07@intel.com>
 <bf47a26a-ec69-433b-9cf9-667f9bccbec1@stanley.mountain>
 <4183c48a-3c78-47e2-a7b2-11d387b6f833@nvidia.com>
Content-Language: pl
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Organization: Intel
In-Reply-To: <4183c48a-3c78-47e2-a7b2-11d387b6f833@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To BL1PR11MB5399.namprd11.prod.outlook.com
 (2603:10b6:208:318::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5399:EE_|PH0PR11MB5158:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a062f4-bc7f-405d-7864-08dd138193da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0l2Wmc5YjIyOThIaEY5dER5aUllZ1cweEFWNVJYWEE5WmErbEdhSFhoMFdp?=
 =?utf-8?B?R0FKZ0t3c1RtMEVDR1VOV2V4bjFURXlxZGc3dUR2anMxeWlKelJHa0hUWGlo?=
 =?utf-8?B?YzB4Q25EOVo2M1M0WDhKRlQwRENVeGhzTS9TazFlVitUMnhvWllzNkVHSHNx?=
 =?utf-8?B?U0xRcVZSL1FrWTRTSXRydlB5ZHVYVWIzNzkwU3NwVWk4Smt0ZUJwYWR4NzU1?=
 =?utf-8?B?YVllbWpVQWJ4TWJyRm1TekFjbzU3TTFPNHdyOGYzZ1lpUmZkcVMvSkRFVElC?=
 =?utf-8?B?QzFTRnFYNWhScVAreFFGZndTaEJUblcvVVhSb2tKUUVLY3IyWFN1M0swUUI4?=
 =?utf-8?B?cmkwSW9jaldrb2kwNWJlMitoOFloLzYvWjhxUTJ3ZmttMUVaaVp3dFdkbE9p?=
 =?utf-8?B?NHNYZHhwd0FFdXJ2Y2ppeFBqdEY0Um16RnJjS3pBSTc2bTVhdXZwaDBzMXZQ?=
 =?utf-8?B?UTJxazdXdlBMTGZJRDVJUE1lcnhvY2ZicGFwaGExUWZEWExaQ0poRjg4Y2VD?=
 =?utf-8?B?Sk9senJWbFRXemdVTnNYdUVWajkwSllVeGdiY0hpTWw2emFhMU1oSzNtTUxJ?=
 =?utf-8?B?aTcyQ2lRSGNZUUh6UGR1eTJLRW1kK2VNMWJTT2Y2akg5OUhMWG4raUhwMW5p?=
 =?utf-8?B?WEtoZHV6ZDk0eHB1WGRORTBObkVtdGNWZWlKTHR1bCtibWVTNExuRHN6ek43?=
 =?utf-8?B?ZUFUbGU5MGtYOG11enV2S1AwMEpPOVorNU5hd20xR0NKcmhYaFY5R1RwcENv?=
 =?utf-8?B?Z1JTMjAxdE1INEhCSVVtbUpIbzRxVTJiR2lZOHNJbmJqUHM3cGt6bE1MTGcz?=
 =?utf-8?B?WVg5YUVnQm92Y1VTUHdtSExUZTBYeC9PMjJYUFI4czlCblhXM1hsR0hnTlJ6?=
 =?utf-8?B?V1Y5dFdSY2lNL0J3NkRPUEg2d3paN1RHU3JNSHZ4VW80Y2RDNjhmbURUVm9H?=
 =?utf-8?B?bHptK0RDaVJrS2RzblUxVE9HSjZsMmZacHVQc3hZS3NMdGlCU1pMQVN2VUNT?=
 =?utf-8?B?NFBLMFlUK01TZDJWSlR1OURXb1AxaGdXdjFnRG1GcGk1OXRYQUhaNENocGdp?=
 =?utf-8?B?RExBVW5DLytvRE5PMjVKakFza3N1RkpLcHpPdG5Bb09KQ0h4b3BqR0xXS3pv?=
 =?utf-8?B?RzBYVjM4SEpTTWJXNFBlc2ZjOGJpcitjRS9SUmtnQUNCNFh0cjNkSEI5dGRU?=
 =?utf-8?B?ekwzSElPYXUxSVVCVW5mb2NLTnJPYjd1RFhiek9YdzhBMXJrUWhnMElsc0dr?=
 =?utf-8?B?ZU16Tm9WVUlGRm1SUXl2Z3N4MXhpR3d2QjBFLzBsTlRkdkFaVDB1YTM2TFdq?=
 =?utf-8?B?ZkFOMzAwMWh2Z1pqc29FdkUxN2lndVRIL1lMWk1LVkQrM3pxaUJDbnlJeVp0?=
 =?utf-8?B?VXlTRll0R0tiTW9zZzVmRnJFWXRVUXhmRkRnY3BHN1RlR1p0eTk3MFJCaUE2?=
 =?utf-8?B?TzVRbytsSGU1dDFSQTlpd0w2dGNicGRlTVkrMFJQM3pQZWFiZ3dkUFdnQmp4?=
 =?utf-8?B?K2plRVZZN2lrcS9xNEpKbTQ4YzBpdkdMNzhSUFNuVklCN0RoK2ZaRkVjajY2?=
 =?utf-8?B?WjJEVUJsVkN6RnY4eGlQQzNQeFJobkJsZ2NPbkJYamdORERHaG50aVR5Rm4v?=
 =?utf-8?B?WkxyTnRqaTgweklSZjBrb0hnWGZvMXoxUWM1Wi9xNWhFWDc2Y1BUcjkyZmRI?=
 =?utf-8?B?d0RZMUlYc01KY0ltSkVCLzlnVVYvSWVZYkVqVDBlNVRNazlRTkNNanFOQzM1?=
 =?utf-8?B?cnR4OFhKVmR0M3pnUDNJeUdqelJMZGxlT3NLR2ozUjEveFhtOHpMcEl3Q2dv?=
 =?utf-8?B?Wk12OG50cVZsWTB4WjFFdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVVxbElEVFArL0pvVEVralNubHYwZ2F6YWYvVHJNM1lOeDMvaTRtaTNXb1FG?=
 =?utf-8?B?TDZTbDd6VVlrTExxM3ZBdFBBY3BsMldKaTFYV3hOVklJWlkrNWFralErL2hV?=
 =?utf-8?B?MTFNVlM3alJIMmdxaE5yMkx1RlpOaHRNdE4za3Y4LzhYSHBQVi9oaElwSzg4?=
 =?utf-8?B?b3RZd0RFZGs1blFraEE0VlZQZk00YzJPaGFYdjBCdFVhcTFHNCt6ZGl6M0Vu?=
 =?utf-8?B?WGtwSFFYV1c0WjhJQkFUbndYSHpQOUJVR2JudkJYYkZMS0JBanYzUUQ0RHZF?=
 =?utf-8?B?OGgvdVJTSnNSWVZ1d04zQzlSdkkrbU5XSzgxRmI0NGtkSHhpakZZcGtGd1dR?=
 =?utf-8?B?NGlkNHJ2S3ROVzlJSm5seEJaOEdiMHVkM2o2N05rNVJjcDUySDZJcytCMndl?=
 =?utf-8?B?Vy9jVDMrL04wSlpQdHpLT3AwYTBuNEE4Unhva0VPalZOZHpMMEhCeXppLzZ3?=
 =?utf-8?B?UUl3ak13SzZqOGdKRUFCNTlFNjh5dnpKLzF2NVZETWRMZ2hRV2RScnQwZ214?=
 =?utf-8?B?LzdhdGZvWWx3ei83OUc0ZWcyZ0srMFJKSjVGdCs4OFIrUzN3cTNWTElLTFRE?=
 =?utf-8?B?bEU2TDduRHhYNmhHQkY2blVVSTdmZE1OejQyVTRZTFdxRW11U0gyVkllNmow?=
 =?utf-8?B?clF5V29BZ1BpU0VmZVM0VExpcTBKTU1LOUhnM0JiajNwOVlsbkxma0kxRjVG?=
 =?utf-8?B?aThhRWV0VEtZS2Z0T2pXZXhrbEpvSFFhRk15amJMVEhZWUFidTVpd3pkMnRz?=
 =?utf-8?B?Tnplek9tWmlwV1laaXNhdThoMW1YZlZhckxFVmVRN0NrYTMxQ0RMa3lRUlVn?=
 =?utf-8?B?NkFqM3FtK2dhNDZ5UzJxOGlibmI1MnJYQU04b0tZYVZDdTdUWmhqRXJQaWxW?=
 =?utf-8?B?Q2NVdzN0RUhjK0xRK1Uvak5la2syZC9SZ3Y4YTlOVFd0L0hsV2o1RFdnV2JP?=
 =?utf-8?B?dGozSVNJWXJsb2xwd1FhS2RDV2MxQ1JRKzlPOGpXYmdKZmtld2c3RHJCVGFK?=
 =?utf-8?B?SnN4VHZqOVd5T2lMSTl1TEFJM25WWGR2QTVQY2dlQ1NUNFhzWEFRMmNrYTZU?=
 =?utf-8?B?TVltN1laVmNCc0drY1F6TFlUZVIxanFmY0VwOU5sbkRNOG81SDUvdFhzSFpq?=
 =?utf-8?B?V1B5QktablBycU8vLzN3RFhucTFEZmNyeXMxWmxmbWZuYkprYzRTa2hFTXZv?=
 =?utf-8?B?SEd5YW9aalFkNFJTRS9ubjhTNEd4Q1ZUZUxKQ0xHam1oRklLY2FpR1RSMGd4?=
 =?utf-8?B?NlVzbGZJWUQ1RHRsUGNzQ1hkNk5oaDdERldUQkZDaTZQSmF4RHlzWXVkeHlx?=
 =?utf-8?B?UVA2ZEpXdjgyajF5S0xCNytjbWZCNmFKd0JONXVMQXFXQkFWc0JtNWdjSDZX?=
 =?utf-8?B?ekNod2FxRW9kVHhmTnAzTGVpRUhoWDZMUHIzWlNML0tudVh6RWpjYkNQbkpR?=
 =?utf-8?B?T1BYMEFxNVBvRGk3T2JlWG9sQW92R0ZlYUJVSzR3QjFYek9ONFFnN0krZTFj?=
 =?utf-8?B?OG8vNUEvcE5WM0dCcUV3ZmtQc3FkV2wxdXRuNm9iRll1bXJoY29CVUVtaytB?=
 =?utf-8?B?eGxpSGZ0ZnFyWFR4UVdIaU5xL0dvR0ZmdEVFUU1EU255V21qTXF6N0c0Wmdr?=
 =?utf-8?B?VXBKRGpLNG11bEtXTGpVV2pkbUNTaFhVU01MdTB5bVlTWnVnaEI5end1NVRx?=
 =?utf-8?B?SHgyaHdoczdMZHZsWHo0OEFmQnlsanFqbFBPaWxnL3R4TjFQMGw1dm9hRkg3?=
 =?utf-8?B?b0tLWFpCZUl5RlIxdnNSVnRuRkNhT290TzJuQVlmQlZrT082UUVXK1JLLzY0?=
 =?utf-8?B?dW0yN1NYQWh4YU9kajRJRTRHVWo5cEtOSHo4bTNacGYzeXJ0U3NLempHWU1G?=
 =?utf-8?B?LzN0OXJ4MGM0Rkd6WE1rY21ETWk5OE9UL3ZwWi80bjYwUU5PcUZkVUVwOVpu?=
 =?utf-8?B?QnRERmRtQmlQRUR4WVA2OUZwajZJR0NvRVd4N3NCQWJ0YlZhVUFONElVYXlJ?=
 =?utf-8?B?N2cwYk9OUWM3ZmFmSnBqZU5FYTNXcnRxd0xoVExNaGhZemlRSEFFV3pHWEdp?=
 =?utf-8?B?SWZkcXdGR25YY3M2UUVUNUJpSXlIdklrNjRnZVRkL09kbGNLWW12OVIzNEZ4?=
 =?utf-8?B?STFuRTZydUlVNDRMbEplN29tMHVOcDM3MFVVdVo4My9OcDVYc29jMS85TDgx?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a062f4-bc7f-405d-7864-08dd138193da
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 10:02:21.0657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HV/v7fcOYCVBmf1zgCB0Q0ayy153yfrUVGp2VGS6KKF5LOKMbeDvlqT7NqeFWYErKjyAjTwdyR2SSU8LloMX+Bu5EauTPQiUyBAs/f607ug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5158
X-OriginatorOrg: intel.com



On 12/3/2024 10:44 AM, Yevgeny Kliteynik wrote:
> On 03-Dec-24 11:39, Dan Carpenter wrote:
>> On Tue, Dec 03, 2024 at 10:32:13AM +0100, Mateusz Polchlopek wrote:
>>>
>>>
>>> On 11/30/2024 11:01 AM, Dan Carpenter wrote:
>>>> The dr_domain_add_vport_cap() function genereally returns NULL on error
>>>
>>> Typo. Should be "generally"
>>>
>>
>> Sure.
>>
>>>> but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
>>>> retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
>>>
>>> Please remove unnecessary space.
>>>
>>
>> What are you talking about?
> 
> Oh, I see it :)
> Double space between "retry." and "The"
> 
> -- YK
> 

Yup, exactly. Sorry, I could point it.


>> regards,
>> dan carpenter
>>
>>
> 


