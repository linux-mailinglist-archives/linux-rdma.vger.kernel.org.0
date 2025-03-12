Return-Path: <linux-rdma+bounces-8630-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B926A5E7AD
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 23:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F4C1899AC6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 22:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987041F0E45;
	Wed, 12 Mar 2025 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqUE4vG+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D918F1EB192;
	Wed, 12 Mar 2025 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741819868; cv=fail; b=es0e/8+KB2eFghysm6Mdy/b/TrjQlrin85/Ce4+Wzv9wAyXAmcvFmOKdByHyC7de6kiBGvNVIU5y9ht/EAtghBg8stZuKmxW8lhT0dX3QmH0RMBQGD9pxqq1wSeCmyMV3ztGUdMr4Bhw+mwOieZow+BGNq7u4EL4O6TQ4thRNj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741819868; c=relaxed/simple;
	bh=OntsMPsiRrwKmBCm8R7+q7hHFcXoDOk1YLzTtCdkG4w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j7zwdsAdVnZFLaSDk48n6k9H7T7nwQNkn2R2fRx/ESUofuNMXCURyHkdEb53MYNZ2bxyFsgo19dG32N2u2Btj7+aDHCdqlBkxObKFBDAND8IeAsq29gbbuKoGJqqc48T+cP23H2oOhyczgAvjnTW4nII/HawECKSQBKqPuBqUz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqUE4vG+; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741819867; x=1773355867;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OntsMPsiRrwKmBCm8R7+q7hHFcXoDOk1YLzTtCdkG4w=;
  b=YqUE4vG+xfA8kNxer0VxPXhudOUfX/PkKfIbvH8YPy2xlzBjoRObohBT
   raZ1M83SkFJb62yD+T4FXSmQbqde69YDkJTaPamVsiHq5XKborF4hDGBX
   J6IMk6IOzuEEzEpy1C4gXykqL1qat4WpYxG2CHiAgUAgX2z99xgcCpFZk
   U0zghchIMqdeIUzOwugnENWGga9uJqEfFJQ4BbivOULiFUnLyLeVQo51k
   5t7dhxjTp3iHFsLRJG32WA2adPviMv/hrdUEDcxBogPhEW5SIRR97YYQk
   Qvwzz29ADg1WcEnXoH3vyF8bfr0iQusBfeVvsbtEe0OVH179SZxgbKRwv
   A==;
X-CSE-ConnectionGUID: 2/JdwNQCSOu6AMt/KI4S1w==
X-CSE-MsgGUID: fUJg2+DATJWGsnfg9YW53Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="30508919"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="30508919"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:51:06 -0700
X-CSE-ConnectionGUID: 4ftHP9lxRlelNSxawt5MlA==
X-CSE-MsgGUID: D4DCb+fXR4yAH+/U4ozrZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="125957346"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2025 15:51:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 15:51:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 15:51:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 15:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GI9zeBsOPxeF+34FDjht0zjwsE7lKzsPCio4TQ52cVWgNp9IBzQjKhbOmNte9XTx0HR3koReFB9pruUIZndTd8ItxdO8akA6l8q79mW9EILQNj8zM9DaIHb0QRhJYscA8W0j+93esF6oTOKyu/JEI34YZnWDmumNEycuqnAIe0y2EtrSq/TgIyUd+MksPTrIdgKcHZXxW29rTXI/lZJH7+RIU17raKMtmgbr7OWNIiEwuTigMeaGMPQDadUGpXGlnc16yfkjFLZg+COfDNTWDjjBGEBoomUCGivZXi/Zi+S7DVmVlFM77fPY7GpDzTvnU/XGV5MMZbM0ltf4SaZaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA4rQXT0Lm6NHTXL4XWbD6Wt5erhhG4xQdNR0mcsUGE=;
 b=wvuLPC5kEtjUP9MgiaSCzRMGaEpJvFwVgE5nex8SVVB3+/SvYR71rAc4ovdfk4wKa6SDjPbKYMvCDcQIIdOdyGt9KZ9cqXL4MZK3Jx/W5SI9HhACJN38F/iOdG3u1X4TwhmzW3fpGbErQZ3lEDrpSorFVlkoPjiML0AwNhrRoTsbYNWLO3/fIS5a6BgzviDxXX2JDfxq6u9maM6ytLnWDfST0Ysa3cTFv4HJ34mtWI3HUykmqkDptTuLDtC2I/rjdZPUKOGrStEOzU8W/S7xFBXfXPxiyO1WvezTyH5KbaDQdKZKSAeHC8ORl3mzFtgvUNn11t2niz5N1qw7O7Xtpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5283.namprd11.prod.outlook.com (2603:10b6:610:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 22:50:40 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:50:40 +0000
Message-ID: <097d2ddb-9dfd-4b71-a491-47e99642220b@intel.com>
Date: Wed, 12 Mar 2025 15:50:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5: fs, add support for dest flow
 sampler HWS action
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1741543663-22123-1-git-send-email-tariqt@nvidia.com>
 <1741543663-22123-4-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <1741543663-22123-4-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:303:b8::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4293c8-ac55-4094-363d-08dd61b8501d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWhDWjdMYTJRaW9oc2RzdVBhVi8yQUIvVHZNSHZHMllvRk1iUU1NalBhWnVr?=
 =?utf-8?B?eWhINEkwaG16Z1J5MDM0eHlYVkpRdlA5R0RXTEoyOEtzQlhOdnIvb0t2Vnpw?=
 =?utf-8?B?UmRhWnh5djlHQk5EUTZxQ1pzbFVDSGlKZ0ZuNUpKcndjOURlcE04M2lLN29J?=
 =?utf-8?B?SENlNUllUjBGS3psckNxSkhKejFzQURGeXVWTWVUWUJJQk5mU1gya0hqY3dW?=
 =?utf-8?B?S1ZuR1dPSTQybkN5d0ZkNFpDZkpBYkkvYUpQNTJFS1RQNmJhUkNnVjdiZ2Ry?=
 =?utf-8?B?UmRJeEY3VjBRS1BrdDE0MWxuTEFhNWRNNzYrOC9uT20xZXRYRmZyYlVOd3ZF?=
 =?utf-8?B?akh6QXlkSFAxZDllcWtoMlJUU0N1UWdMejB0Q1JmZkQ4U090SDhTdnAyWFNw?=
 =?utf-8?B?ZW56bGtMV2V1aWVtbVROZTV3UVRSTGZvT3lhbjF4dFQ0T1JvckJPQ3Y3ZjBJ?=
 =?utf-8?B?ZXZaOW41a0tMZkJaQWw2KytDZ3JUTFdVMGxLY2o5MW5QQVUwNE50ZHdXMDRm?=
 =?utf-8?B?czJnRDlsVmJQdnhWaVpDWnpEdWVoQUw2MzhVV29oU0tiQUw0SnNKaGEzaWtm?=
 =?utf-8?B?cmV0Mlo0MnZVS3hMUTNaQTc3VGF5TmhLSzZXN2syc3ZiWTgxU0JrOCtycFBl?=
 =?utf-8?B?dEpVczkvRjJoNHYvUlVMYlpXemU3UGdOR0hxWnJ6SDlsK1dUd3RlQXpHWTRU?=
 =?utf-8?B?QzExdy9PbHc3SUhiK3p1VllEVVl0Rm5wZHJPNzV3bys5Qy9meXRITGpOWUdl?=
 =?utf-8?B?SEJDN1BRblhoZUplUEZrd2xyOHJNZzdDQWg0KzZ5QnQ5RXNaV041UVltTnUx?=
 =?utf-8?B?WWdyTytrMTE4aFhDaUtBakNFN3ExZVI4dzVid0VoWE4xZTkxVXpQYi90Skwy?=
 =?utf-8?B?bHRRMEdhbVRoclQyOXdKU0x6Q2VhNXZaV2tIeW1sYzVxbk9nd1RyNGMzV3lE?=
 =?utf-8?B?ZEYrZjd0UmhxV1hyUFZiMi9KWkdRaTVraEVJcjNVQWZqV3E4N2RQQ2o4K09q?=
 =?utf-8?B?TTFPNTlaU1grMDY1WEhTTWdhZUgvSkw0QW1QZzJMNStJOTFOdjZ1anhlZ2JN?=
 =?utf-8?B?am9NSDUxaTRPUXQzTTVpSDYzcWJXZzY2ZXZFT09MZlFkNlQrRWRua2ZTRHI4?=
 =?utf-8?B?YUExSE9DZHY5VWhwbGg5VGFTU05ESkUxaWRUeVNkeGtqcXRQYlFMbC9SR0Z4?=
 =?utf-8?B?TlFFYmNob3NnQlU3d1RsYTI5WnVrV3BjOXltbDNkQThoU0VBNWtlaER0V3RU?=
 =?utf-8?B?WUxzRTc0MWdXSVBjZTZHN3Z2N0l4K0RERCtLa0hwa2dYZzEvNE05YU1iS1kx?=
 =?utf-8?B?S0JpdndvbGJtQWFVZmFoU1VpRytITk9ieXJwKzZLbHd5TkttOXJ6bTl3ci91?=
 =?utf-8?B?ZWFZODFUMUQ1aEFlOG5xVW1aYWY5eCtZdGxwMGRobWRzaE5DUFo4MVJ5Rkp1?=
 =?utf-8?B?UnJBR0dkWFgzaExMdWpWT3N2bjE0UXlaMW1pMWkzU0VkKzVkSi9LcjZKWmFy?=
 =?utf-8?B?U1QxOG94UDY0bzhQVGJYaFhHeHgwVGVybitvdXVucS9jNFJCMGlKbWs5TlVU?=
 =?utf-8?B?YTFqRWtrbjRxZ3BFdFYxM3VscE4yNVd6UHAwZ3QyZitadFBVSmRyYWJwK2xn?=
 =?utf-8?B?WHFEbUF5dmY2OW91ek9EbkdpRHo5Uml3amhWNmx1cStzVWtXWHpGa1ZvVmV6?=
 =?utf-8?B?akExS0VQSTNXZG9EQUNYS295cFNRblBFdHNOb052a2FLbDg2dEZOUXc0NmY5?=
 =?utf-8?B?UzBhcVBNWHFJWjczQzFFOGh0MWVlaERMRVF0MUplRkVwVlBxR2hCVkNYY1JU?=
 =?utf-8?B?TnZpUFNCd2hYRkFBdTBZVTlnM01lT0dpdWoyWGRCZkNjUGtyZXlxcjRQWEJq?=
 =?utf-8?Q?UmAZ1E+zcWa3o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmJqZUdReVNUY0k4SGNWNWlMSVEvYWtpWVBaNnNkQXY3eUFDb01sMks1VVZV?=
 =?utf-8?B?RUNiY3RBUjdPaFZ4ZlE0WjBPOWhuWFUxNHZSc1phVWdkakJsOXFxZE9uZUtC?=
 =?utf-8?B?OEtCSm9UMnZ4eDJyQVpTL1A0d0U0c2t2UjM5Y2dQTS9CNVMvQzUzMi8xUStC?=
 =?utf-8?B?WjZhQVQ5Vk1wTnNOeG1IQjc2OEVDaUs3Z1dCQzNqZzc0ZWFnNDNwcEV5UzhB?=
 =?utf-8?B?TXFMSHZiOEp6YU1KaUJSWGlWdjJvUVdRYmRNN3VkdXJhSE5hTk12ODUvVGlj?=
 =?utf-8?B?K2VaQ3F3N0NvNWJTUU1Bd2o3M0I5K08yMHdjeGhZZW0yempDY0J1cVRUREFY?=
 =?utf-8?B?enhXZU5jOGt4SXJ0SEpiS2dGeVh0ZHdWRVFTTEt1N3l2NkdWZEluKy9obFpW?=
 =?utf-8?B?T1hBRkIvTjRacThLOU1sdXJnWnJEN0d6Z3RLZEUxMnVwdk8ySUtLcys3VG9N?=
 =?utf-8?B?RjVTUHlweUpubll2R0ZRNWVWUWNLeFpidHYzanpYYWozTUw1UGxPMTQ0eUl5?=
 =?utf-8?B?dTlvSkc0cGxoV2QzS2FpM0RiLzAvSjB3aFhRWG5YdWNEN2JhZEpaVStRVGJs?=
 =?utf-8?B?a2Q3K3hlME5RclUrRHEzOURHRW02dlIzdFFiM3JKWU1sYk1DMjVJT0wwcWVa?=
 =?utf-8?B?RkF6cDBZZkNtWEhUR2FSTWRMVEtrQVpEb0crdS9lL3ptTk1NNGhqSEFqTno3?=
 =?utf-8?B?U3pQS2tCV1Fpck0vcURVZitzWGFpM2JnZjZZN280N2RLTTI4Z0wvOGRwT0Vr?=
 =?utf-8?B?QW1kellkY1h3bmtoUTlaOTYrY3BERWxXWis1NURNTjJDblYvWHM1Ky9tS2pO?=
 =?utf-8?B?TE9sT052UEkweVFLMkgzVGxLanhUUFZNb3ZrL01QRlU2MHJGWHIxSkY1QlpR?=
 =?utf-8?B?Y0ZlK1JHVUFCc3NlUjlicVZDVlRhTW82aU9PMWhiUUlBbTlNemZMN2UvYTRa?=
 =?utf-8?B?TlFjMDFBSjI1ZC91MGF5aFpVV1lpRW1WMVpXOG55eG1oRG5jamRjWS96VUUy?=
 =?utf-8?B?bDhpQUhON2EzUjlrbmFGV3NnNk5zYnBXNGdvNWJjT1hMZ1RpSTJzYVdhWG5w?=
 =?utf-8?B?dXg1WVN6U1NRSDRJUXAwMi8va1V6YkpUQWJ4U294bUxtOVNqbFBhYVRsejNK?=
 =?utf-8?B?aTBlNUdabWFGUmkxTXNLeGVObUN4T0h2dU1zQzFmaU92UEk0Y0RzMW4yK05p?=
 =?utf-8?B?STVTZEFiOHJySVU0MlJhcnl1SnBqVkxOTlZPejMxb0NWSHBtTEFVL0xMK0Rv?=
 =?utf-8?B?dWVNMzNqSGExZ1dvekxpdE5XeTdTWGdKMnhvM1Y2T2QzVGxITnZSZDV5THNy?=
 =?utf-8?B?Umg0ejhJUEMzcXRHdUoxQloxS29QQkxiMnN1Y3hRZndBZW5QVForbEsvd2tr?=
 =?utf-8?B?WFpPdWNOR0UwUE1VeDB6YUs5aEIrcy9wU0RNSmp4d29wRDNPMTRSUjZzbjBt?=
 =?utf-8?B?UmVFOVIvd21BNllLKzdWcDA3TEQwTmcvVzhoOUFnTnh1RWM1Y0w2c0VJeGVV?=
 =?utf-8?B?QVRzRE9aWk5VSm9sRkw5TTE2amlvTXBDTzcvaFI5WEFwTC90U1VTcGltTEJ0?=
 =?utf-8?B?NnpNZWVFMTFiR2laZ1JuWmRRWml5K2pnUmNpaWlBRmZEYjZRSmZieTRGMmxK?=
 =?utf-8?B?MkoydDM1enZjb1EyT3BwdGYvMzFSd2xKa3c1TXVHbUFlZVlEbmlpdmZ1bGkv?=
 =?utf-8?B?UVptdWRnYlBGaks0TnBzcGFhT2lRWWt1SHJWWElydEhXd3FRN2luajRVQ0ZW?=
 =?utf-8?B?RTZUaGpIZExFZmhKdlBRdUgvZVNZSHNIN0pweHRLa0ZjYVh3OWcvN2x2Y0NF?=
 =?utf-8?B?ekdZQzIvZkFmeEtRL0o0bm9yQ1lnOXQ2T09mNkM1QmovYjBpTEIrSXpUQTZE?=
 =?utf-8?B?YVZnU3RTZkw2M01Ca3FhdURubHh0cUZvL1U3ZVRXOHZOdzdNcXdaV0lMTE5Y?=
 =?utf-8?B?bEVRWlkyenlpd3Rib2RWR2RmSDNZNXhBVTl4cmVQaU5IUVArQjdZL0tqUnAr?=
 =?utf-8?B?bVBrKzFNRG1NcGwvei9Zck15YllrV3J1UWo1bWtBOWhBWU9wb2s1RWJ4MENJ?=
 =?utf-8?B?MEwzVFVsZWtFRG85d0ZHMmw0b2VNcmYzRGd5UW1ac25tT2N5M2dFR0tKYlBL?=
 =?utf-8?B?bHZwcXU0Y2tBUysycmRSbjBCY3ZHdHdoWFIxYVhLNFdLK2Z6RmFOSmRabVh1?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4293c8-ac55-4094-363d-08dd61b8501d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 22:50:40.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLj1q3GcTwWSSB3PcnEZPbfP6tkzt7/NcS4jzUheTaLoVvp3kcpV8+x1fVz1FJ+riSSu9Czm2eqRWriyuj6J5YMbtfvBQazYIotkSPm0cz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5283
X-OriginatorOrg: intel.com



On 3/9/2025 11:07 AM, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Add support for HW Steering action of flow sampler destination. For each
> flow sampler created cache the hws action by sampler id as a key. Hold
> refcount for each rule using the cached action.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

