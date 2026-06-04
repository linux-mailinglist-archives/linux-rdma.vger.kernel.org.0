Return-Path: <linux-rdma+bounces-21802-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pq9LDJDSIWpCPAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21802-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 21:31:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE96642E9D
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 21:31:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="cEyH/lN3";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21802-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21802-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9D30303D2DC
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 19:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463923C457D;
	Thu,  4 Jun 2026 19:29:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF79438B7CD;
	Thu,  4 Jun 2026 19:29:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601342; cv=fail; b=JnwB/aKB0TuMeMQ8t0cu8GJfsz5EVfPihqb6G6x5XOLS8AtuB9TEVovgEFn1muD/R4Jl3kwTBY2mJf/WG/H7DWmUHEopBjuTI/ZeRRe/Rv2jWUJe+2dj65NYiLQ23q2+USP33PJ5Hx95j+TV/vn7kQdh902FJh78eg3bWLgNE8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601342; c=relaxed/simple;
	bh=l6u3h/0gCQoCaMVPm00xV3kNiIxdx7vnUm6d6HNFZ0w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B5JrXlB+7Pbv4x4iYieqneOLhdKgDvGgdQ5Z1JvWdk1267oVpgfMsBfITr1RZtjWFbvAvpQl1t3ofIg0AKx35NyBX3s0TV4DW+9jYvn1p0UgkOSzv2vXea/XUS2rjK3adyInS3I+xSAmGcCopI2KUcJyZwY4grzF7B+CsRk/NaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEyH/lN3; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780601341; x=1812137341;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l6u3h/0gCQoCaMVPm00xV3kNiIxdx7vnUm6d6HNFZ0w=;
  b=cEyH/lN3BMuUmkGFssdMbyJUMQmpcieWvBX18hzWdD2huWRHC90gXPh9
   qBJJi1MXvOz3MbzOfj/LUQaknk79EMvP6S10KyR6QD9/FFJluEy8nV3+F
   6gkFXddQCCW9e/EqufFigj9FOPIgJK24jPOhjUARAiNMAoyhl0WA4T4MT
   tHuL9R75bG5t2U44AWlT8M3iFSpUUTY+hCNnp+w3CHxWP5PyM/ga57q1/
   UrA8GyE4pXkY54cFELuRcM47ahf+hXQUALrGxJMGjUtpVDYuMsDU1GKl1
   CHFh4h2lVWxrIAS/stpa6i/7CzSwyBdZlesbQIPK6uvxBKY7+dA8H+iOw
   A==;
X-CSE-ConnectionGUID: spxj3ccpT4qjTut/z13WsA==
X-CSE-MsgGUID: nGk2wwU3RRObd4sk/UuNPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="104097456"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="104097456"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:29:00 -0700
X-CSE-ConnectionGUID: 2zraP/pVQeulOGP9xznd8w==
X-CSE-MsgGUID: lBCL3Q+/RmyeozqS4j9/cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="248970629"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:29:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 12:28:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 12:28:59 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 12:28:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eehFkQDvO9vz3Nl1cIJii7ODPDM+l5a21ICuwminCIXv98bOzVby/vdLzJtuqKogxmhCXXiV5ogPF5WkSheJ5m5tCCpYL+8FcefcyBKkMwPk3dSZHv3n2vmvO51zvbSRtWwDAfxD7r3Dj8UJOXNev3Qq7DQMjVd1KzLyQyJnQGieNqGRPBb+jZ6fMHQurG7kwvPPUZsUf4Kk7ZCztKFvja8QDEh0M/gvi8+RFFe7/0bYuw4sVoE4xCYMFMNt+pioW+EGd6+Hpi+H4nHOoGzcr02m1Is/vlaQco+yV8jN2W9Pk+fpGlxC1wxHx9FZ/y5YG0ItNhVrVIfyVmf8HcII1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJGmv9AH5TJufr/SdmnEBD+fXHP5to7WFQwhqlS/YC8=;
 b=K+I32A7gb3NFYFDDXOkyx+prh1FQqrtLS1oDlLF+EYyKx/AZnZ67xlT6RhMRwCuQk1iFXm6Rv8K8F++grR+6QiVFFuFxU+Ho7syucOLMbjYfBuB0RUuuUMWYfqYcCW3tZH2V66Al5YSPLOwvCF9OiByEfZ2RKFoF8Q67XRcSw5/c6gwA/PAdAVJrwW6tSIKnnLBVtjkgWO2QxfoR3W/GUYC80UNitxJWpM2Y6byVlMQkD/polNB7btdM6LMOTYwSWbgH9D7bGLbEWG4qqCtTV3ff1vJd0Ms/7HbTzBhnbrgyhlK8h5k77OwuygmXWEv8puub7omD81D2WiyrnQzzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 19:28:56 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 19:28:56 +0000
Message-ID: <776aafbb-df2b-4dc5-9dca-80a5ad0311c0@intel.com>
Date: Thu, 4 Jun 2026 12:28:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] net/mlx5e: Bounds-check stats_nch in
 mlx5e_get_queue_stats_rx()
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Eran Ben Elisha <eranbe@nvidia.com>, Feng Liu
	<feliu@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Simon Horman <horms@kernel.org>, Alexei Lazar
	<alazar@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Kees Cook <kees@kernel.org>, Lama Kayal
	<lkayal@nvidia.com>, Eran Ben Elisha <eranbe@mellanox.com>, Saeed Mahameed
	<saeedm@mellanox.com>, Haiyang Zhang <haiyangz@microsoft.com>, Joe Damato
	<joe@dama.to>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260604135041.455754-1-tariqt@nvidia.com>
 <20260604135041.455754-4-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260604135041.455754-4-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0309.namprd03.prod.outlook.com
 (2603:10b6:303:dd::14) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ0PR11MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc45ac9-2617-4dc3-e15c-08dec26f84c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|6133799003|22082099003|5023799004|11063799006|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: TX0TFMfUpu7imwiDWKxqiDnZo9scJCWZXpiBhjAeU97egS7dzDvfxUTO9QVGtqOACuydsd0S5UqVOOENq0xDOtfKWESSE81OyOa1LkpoA3ecXjC3NUE/LcPVsV9VQRXWKxclx275Zz/vOClt36p9HCyLhKsNYOZDM88XCXq7U4rJiP6Z/und9Clm2MF2t1u57iJ3TerSPtkKYni7wPNwnCSqEQKFjVdh4MVEY3+446ygczeJI9HIKFXFFcYSTG4HVJ/G61HDHzenW/Zc2FZGxdSbPu883EEZ9LPW6pjnnj1d/RtlABG2Oo7YaY1mygQcalq4X3+J3P/Eq0pN/YN2guDmyYWKYPgLbfxtYBADme0kGZamOd7kD731S+qN9yXfn+c0dvuWgBDeNLZvV//foHIX9KbCnXOa8pIgL+AWz+ZCK9eyahg7pWGCkL2hjy+7b7tbcvouRvVCQK1uFBUvSDSaEed4QciXFwYJCxhPJVC2Kz+y4hsVA3qXQ63yVtZ32OZ+Q5yPbO7VoA2hPdMAinIghA7JvTsdwhgIV2RZpSRhsX6nO8dCdlgrhmqQy28tW03t7MaBDDOnsNWSSvwV/oKiYUxns2s0oWxX1kipuMnxH6TGe6PXhdi+YyDkWmBgSs3pSPtuIrK4K6qyUTP4W1mWozAB0BJZ0gm23OJCXBMn1MlCL7pv+9Lf27AaeNi1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(6133799003)(22082099003)(5023799004)(11063799006)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzRTTlQ1dVBRelAxemhwajdWY0hnQnBONlVCS1ZaVFhXMmVQckNSS0lycDY0?=
 =?utf-8?B?ZTdiTFEwOERZdXE5R1BwQkFOQVhWd2xpWXFtVDQ5aHlEZlhCVVY4TDA3U2Yr?=
 =?utf-8?B?aGppUjY5Z01QaWJKUzdTRXNzdmpyeWVNdWJRMEtseVZuRlRkSlpmWG41dDJB?=
 =?utf-8?B?WXhGVUZTbkRNRndaUUo4S1hueU00cUI4emJUeFV3bVc1bmdyOGhnQlduMEx6?=
 =?utf-8?B?SWVpcHh0aER6VXE3cVFacWxKU3VxNnBHTlNpSDJrSjMyMnpYc3dlbjBNdkp2?=
 =?utf-8?B?UzFjRUdybUZ6NEhWTzBXbVFRa1BOVFg4eUFqZ0pza091VmVGWW0yTnBXVEJ6?=
 =?utf-8?B?MXFrMkJYVW5aVFhGUEd1aEFjb2lNYW1xQmNPN3cwems3MkhaL092aFJLZEdz?=
 =?utf-8?B?NWZYMllQQmt0YlZ5eWV2bWxUVVc2UlNicXFkVkRUaFdIbUd6Y2V4TzVyb3hR?=
 =?utf-8?B?aWIxWHltdERkRm4zbGZTNmZOc1puZ0FqTkp3b3lBbjV6QXJET3FTaDFRczFk?=
 =?utf-8?B?R3dsWUxURk9PSElUa09wWEJOSG5CVVJrcXVqSXo5UzN5WkgwS3F2dkE4eVRF?=
 =?utf-8?B?aXlTZU9KaUtOOFErVE4vVnFVdHpUVkRUSlhwT21YMzB1QmEvcysxU2d0cjJH?=
 =?utf-8?B?NTl1WU5YQXJVMkIreGQ3WElFcStibEk2QllPRytlV3hFYzlhL2VhdnhPdmwx?=
 =?utf-8?B?R2x3MWp3WThLSHRtTjc0R1I0eUdlRStnK2hCK1Z4aDVjenBjK0FON1U4K2VQ?=
 =?utf-8?B?aWhvUC9GY01JRStrcU5kRVRickJ1Y0lGUFhUdmxSYklOM2RMdjJVYWRDWmp4?=
 =?utf-8?B?VUNoRlBnUVRnVXpCaU1EQitxcVpuOFhzdVdoTXpKY1o5c3lvNGpZNi81dDNo?=
 =?utf-8?B?R3NMekxYRlhxeS9uUi9QdmpIdXc1d25jTmNWMHczZDJOZHFYT1RKYUpPU0w3?=
 =?utf-8?B?MnJpYUhBclRPTTJzRUFlZ2NwTkpOR1MyK1VBYkFhWC9Ga0J3Ri9GUGEzZEVy?=
 =?utf-8?B?KzFOSFFlMXpjY0JjczRVem5MTnNBTGNYdE9URTZldXB3aysySmtYTDhrZENV?=
 =?utf-8?B?UC9NakN5b0U0R1B3bnFITDczdWV3YXEzWS9HSlpMeFZzdWRYRDZ0WFpoSTVr?=
 =?utf-8?B?UnlySTRIK25XYW5Id1lQZndYSi83aTVDMnJ2ZEt1VCsrKzN4NGFPZi9TRXdN?=
 =?utf-8?B?NVUzejFVcHVtSlphaDk4a0puTjMxb1UxdXA3YUxzWWpWTWlwamNGNm80WjEx?=
 =?utf-8?B?ckU4M2Y4YXo1RmxtNjRidUNoUU5vczBvR3kzMHRKRzFpWlpGY0UxOUdOSjhT?=
 =?utf-8?B?RjdhUCt6N3c3UGdtQnNEN0xrMXREL0hMM09Yd3dCdXVkdmxSazZQS3NmbDBx?=
 =?utf-8?B?SGN2YkFjVi9hb2M4OUpuSEJzZVFPeUZTQjdlaW9kMlU3dUZQOHRuTVozMjdR?=
 =?utf-8?B?SFFBVUhKeGJQdDJyZU5pdm5xdXBzcWFmNTB5RnI4cnRLZWhMTS9BTS9ZSkd0?=
 =?utf-8?B?ekdReWp0NEI0aHhDcnV6L2J1UUd4SElOUmpmZjQ0WHdaRDVyREc5alZDV1Bq?=
 =?utf-8?B?aFBQNmgrVHZIbWc0RGx0c1UrdzRBL0Y5bEpMV0crWDU4VzZtRUt6THZqWlMz?=
 =?utf-8?B?bEJKVGI4cjZyb2lkRTRyWjNiYlo2T0ZxZEU4ajlUSDFnVVFHQTZZenpLRlVk?=
 =?utf-8?B?S0JWaEM1akE4SVhYR3ZuYTZLaXpreWFDaEl5eHNVa3ZnU0luNi9YeHo5V3l5?=
 =?utf-8?B?L2krWUZSYXBORXJyUFJqMUliVFhTZitGOGt6R0JKa0pLQVJSVkJoVzJTSU9R?=
 =?utf-8?B?eG1OUlRyR3JITm8ydUFXc1pTY3krSnFTZE9rRkdJMXpxdjRxRXF0L1d6Sm1C?=
 =?utf-8?B?eitSL01RMi9tNWx6dTE2UVNPV0dUdEozUmROWHJib0poSHBRdmxuSGJ6Y2xJ?=
 =?utf-8?B?REkrelJUNEs1RHZ1RXQ4bzJwb3JDK1M3RnovZWtWVVNnMExtV0twS2JJU3g2?=
 =?utf-8?B?Mjk1OUVtVTNNMDFESGNtQkFCenJpTjVpMVFnc09VcWZhTFFhaHhSM0FIcytI?=
 =?utf-8?B?WEtNODl0WHZrczNURFRMM01ZREtwVFdOc21kL1ZZdmliTFdTM0NmY0hCZ05y?=
 =?utf-8?B?TFZDYkd5Qld5TFp2Y1NBN0J4WTVjbk5yQldhd25EeGljRHEvUm1hSmRrVFRD?=
 =?utf-8?B?cFkwaVQ5S0hkYklPbE5xV05DcDJVSjBtYmEvZWduMkVUZmZwbW0vUjdLYVgw?=
 =?utf-8?B?NVFGL1RhUHhncUhJRFdnNzhTZldHbGN1Q05rVmdPbm9IUCtBSDZmdHVzV3k2?=
 =?utf-8?B?TGZ6dVJTMTJXdVRvd0JNb3RSNzRyUzBwcGQya3EzUnFHb0xyOTcyVEZrelFj?=
 =?utf-8?Q?pL40i/7ofSl13gZE=3D?=
X-Exchange-RoutingPolicyChecked: N1lfuMM8A17TG6TVZNoP8d9+xLuxvU8+1NWDVKnuYqAwYFHpP1GUIpNEvzIj3axC8bLOB0bAyiQCF5LrUFZxTRZRbRhFBrsHWZ/3YuVhfFbyHTn/Z3RFIPZQc4b7Y8huFwCrxNlaEh/12OrZiX0C5F9qHoOYva5FFEtyeS+r3on35lc8DjJB0aoXVfFRBWELeHOuhTdrS8cxbQdsy/0iC56bHe7RB+UH6BV9dJmuqUHO1pX4nV0sYnbTCk0HlhfCC6wpWwIAhDlmaVsNFxxyeG39g2/l4QYEtkr/wyJej/6yDgOUNNJKoW8vMY6fQtZD1FOyd5ZmdLLlY/N9zDZBbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc45ac9-2617-4dc3-e15c-08dec26f84c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 19:28:55.9517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTsz1XGAPyRQzfqpUfeY9WyWH01Yr74eAScA7o5yFz1Sdq7i1ZmZktSNyrtGt1vHcdYpJgFnERG84X7RIomAnJCRYr0rOk+WpnOppUMs+48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-21802-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:cratiu@nvidia.com,m:gal@nvidia.com,m:horms@kernel.org,m:alazar@nvidia.com,m:noren@nvidia.com,m:cjubran@nvidia.com,m:kees@kernel.org,m:lkayal@nvidia.com,m:eranbe@mellanox.com,m:saeedm@mellanox.com,m:haiyangz@microsoft.com,m:joe@dama.to,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,vger.kernel.org:from_smtp,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FE96642E9D

On 6/4/2026 6:50 AM, Tariq Toukan wrote:
> From: Feng Liu <feliu@nvidia.com>
> 
> mlx5e_get_queue_stats_rx() is invoked by the netdev stats core with
> an RX queue index 'i' from real_num_rx_queues. Today it only guards
> against priv->stats_nch == 0 and then dereferences
> priv->channel_stats[i] unconditionally.
> 
> During interface bring-up channel_stats[] is populated incrementally
> by mlx5e_channel_stats_alloc(), so a concurrent QSTATS netlink dump
> can call into the helper with i >= stats_nch. The non-zero check
> passes, channel_stats[i] is NULL, and the dereference panics.
> 
> Replace the non-zero check with an upper-bound check against
> stats_nch, which subsumes the zero check and prevents the
> out-of-bounds dereference.
> 
> Fixes: 7b66ae536a78 ("net/mlx5e: Add per queue netdev-genl stats")
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Eran Ben Elisha <eranbe@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 8f2b3abe0092..42a658402592 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -5489,7 +5489,7 @@ static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
>  	struct mlx5e_rq_stats *xskrq_stats;
>  	struct mlx5e_rq_stats *rq_stats;
>  
> -	if (mlx5e_is_uplink_rep(priv) || !priv->stats_nch)
> +	if (mlx5e_is_uplink_rep(priv) || i >= priv->stats_nch)

i is a signed integer, but from the way its used its clear that it
shouldn't be negative (indeed, direct indexing with a negative in
channel_stats would be strange..). The API could be clarified to use an
unsigned int, but in the assumption it always ranges from [0, MAX] then
this check makes sense. If stats_nch is zero, the check is trivially
true, and otherwise this now also prevents access to stats which weren't
yet initialized. Ok.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  		return;
>  
>  	channel_stats = priv->channel_stats[i];


