Return-Path: <linux-rdma+bounces-9313-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A2AA83345
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 23:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF2C169362
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 21:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81803213E61;
	Wed,  9 Apr 2025 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzcrLEuB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5E2155C97;
	Wed,  9 Apr 2025 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744233798; cv=fail; b=iBt8rxG4kgBn8p1b56D5pAURXF9yWNbbLAyfWyEsblIex6r8+LxeToqdE1Xq2lAPQ9HcaxV3PsuiCSahoROyStmezeI6zHWxMsQfoOR6xQvAVfTEyBNdPcCIe8bgLSdHF59FMTsviEGX54cvt9YyulGdHAOe0j1KeoBqOT47uTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744233798; c=relaxed/simple;
	bh=iJcCz4FI6l44zOeoLWKsAY/WUaKI/hq8eUuCNsd7rEA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SxxEktHUriy4tACBkJsjmjuucKg2ODhTIJ+9wiiYPlgPMGoctR+3qoTNGrIx5Y0wDOj1JiqPC7NEokk9z9ZZhFLO9ZmOROinGvnWA7G7SGypNlagtVy2wu6tSlhVCLZMGnQpqGwTmEfZifAlaqUGBEzw9mNWlxpM2q5uhl7xKMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzcrLEuB; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744233796; x=1775769796;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iJcCz4FI6l44zOeoLWKsAY/WUaKI/hq8eUuCNsd7rEA=;
  b=TzcrLEuBPs4GIixgrMOy+vZZtz5+DPOxHvhgoOqCsj4EaJespnIYzRxg
   McyphFriqz74N3+ckjahqVJCvaBSis6Wt8uj+OijfpSCvUlQT7xBMI1b6
   AFuZG/6akfc0x997cG3bdGdyFqJPYrIyaIGrWRQ/O7gZOlwx7VeahCqpC
   WOl+l6Nwq1Lr0V+4w/cTRXLsTC0wwPyWQLt4ib7uyv55MvovVc5h9J5sH
   1uLj7O3ZTULmDHQkscIWKbzEyWHlJEBBgeJHNmcm+k4m5ww4RmZXSL29e
   DEcg1wh7NsHKM+uxDn7CzjXRndYov9xgTmmrgOv77pyumqruW0IaUDdq5
   g==;
X-CSE-ConnectionGUID: 5I2nvfh2QH++FVAOTZhSnA==
X-CSE-MsgGUID: f+1zJQ0fTauiwuya06M8Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="57104144"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="57104144"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 14:23:14 -0700
X-CSE-ConnectionGUID: u9WlGZ0kRLKJRJeE4vaFzA==
X-CSE-MsgGUID: szse9sstSWWF7PPfVr6N+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="159689760"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 14:23:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 14:23:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 14:23:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 14:23:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7Ehs6wVJ/7IBZYBzUhExCKWxLE8ZDZcRgF0fZqX5zsRWyqSmrxn/+lA87Osu/ugV8ql6uSfg3l8qWDp2G66ulifbEsavFlzcDJQ+w0sdZhKbvS0oc5xhKuyTWbaXKzqIGTGdsqK6At1bzMeMPjlmk+8tYDyiw+vlI8y3dEUVhDjscUfB4jXtzxxXeWUeiMuRtLc/A3goAVIgbFosRMXJMT9JRMwlyHvTKzqQaVTpDBiXREtxTIDaI6OSJbuXOmc/n2ZpPPnpEeUktGYkDEXDMC3SilX/FU2SlRUN4A+KtLjFaI3Bq2+Z41MiuiBXs+329eJDNHPluVfEvk52Sm6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrVWt4H9HQ2A92S4Vwn/nX8j+hUXxlzFJAeQ1XGDDZE=;
 b=RyuLTLAyH2vd6af96CBeLqlrR9nEU+/YC9izb+qXG54jDCeZc5gg0m7j5s/umwKG34uy3WZgfYCD/Fr++6SC/VbZQrq+bjHu9LU13XkLPpp9HPL6vxW9JOBBI6n4bMPyLTZ83WbEdqH8dup0Bi+XXLMs0RsINRJ+tpExZ/PPPwgEdaDis7BPPDbxvzR8efH/kzpCOIwvgchlLr4cm+QJozjnWveNnTrcxHhayZzaahztJJPQwL3syhCNdrMiqUzQyIjPXYioACT8Carnlhy1BbndGg+4NF1TFGNEZ4Lto7v25FdKiwUTGqOczNbkuXShlGHnSPKU24F5+p6QJZAV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 DS0PR11MB6328.namprd11.prod.outlook.com (2603:10b6:8:cc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.23; Wed, 9 Apr 2025 21:23:11 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 21:23:11 +0000
Date: Wed, 9 Apr 2025 23:23:04 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>
Subject: Re: [PATCH net-next 05/12] net/mlx5: HWS, Cleanup after pool
 refactoring
Message-ID: <Z/blOLHROwFdhv20@localhost.localdomain>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-6-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1744120856-341328-6-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|DS0PR11MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce4a09f-729f-4475-9e7e-08dd77acbadf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?24g/ZkdmieFc4QU3bXfI0eOwuiwo6JDa2V5ptMaFbEb5YViRxwYQL7r6aYDy?=
 =?us-ascii?Q?U+ygkJc5zHsY4DpDhVrvvZST6FKypqeyZ0Bm8y8agmCs6IkUPRKD9Xux+fEw?=
 =?us-ascii?Q?AJDzSbFmQwW1OpjEadl3l+zPTf33rC4svEv0uTiqyrXUfSZiL3Q4jlDSi+a6?=
 =?us-ascii?Q?Lu9W5vRiUvmLDRaZYo5ptoKPciVyOD857j9sv2Tnl3Pm6L7zQyrmb0q2sVua?=
 =?us-ascii?Q?FFqDP9V4VLt1AAmZNNssb0a844LOelGjHwL0idFiymvxE13OkTY601L24+fc?=
 =?us-ascii?Q?BLRJ7DuWyvPuLXJsuLSp+bPyM44hTOUD9BifuU94BEz2stAPNxB3NQ97FOtp?=
 =?us-ascii?Q?PlocTAmvLWeLHe1wZEfdkTgn/pGBN7/RhlTbSjL3hJbjWVMnv/9NiydhlkM2?=
 =?us-ascii?Q?Ai8rKxH5DanOqjHqcUoD6tVrXEmqtVGpBNOrde47bRRi38DEisCs9cy5fqa+?=
 =?us-ascii?Q?IbzlgUmYhgjG4wHeMW1KLL/KeAy0PI8tw4VXzsmDKDqMUhRz5ltRsz7MIICT?=
 =?us-ascii?Q?rZz8kJ8x8NPTVub15IVwVcZTJKNj5lpNSisoq99HSSLLVchJFVQCwJZE8PJz?=
 =?us-ascii?Q?HPGJVB40PMqNBImB0c/k/qmLm8G0AkaVKhs6yxtZEQl7RNftmwP8kvOjdGON?=
 =?us-ascii?Q?FwP1LqN+byo9OklSmF7cATz9Dui2fBoRJzQ/QBxB4aUGffkZF4XZvQcgxEri?=
 =?us-ascii?Q?jML8JuYEmV1OqEK4wVyKtoekgunTv/PJjgMzRI/so6hHczahelCys2xspHAq?=
 =?us-ascii?Q?n7t7ONjsDYoHiW0DL/3ULaAF0A+kd8OTJvGQzAxy6EstvHDnvJuPBaQ6e1r4?=
 =?us-ascii?Q?JeCrtRQ/wf6BgGYdHRR0byBpVOLoTg1FWWNtQR7Mq9pJlSc+E5CXilA4D4PT?=
 =?us-ascii?Q?WSpcAolAxeVbEci0KlBf6mISBW3KCXU29yABT3PXWg/uuSRhplblPMtLGOcv?=
 =?us-ascii?Q?LZQZ2TduFHICdyDuPaChhGdOJHH8QnYA4MGplXlv05LL3TIC/P3gNTiEQww+?=
 =?us-ascii?Q?GFV8iwLymWkQtQa+DsZY16nDpxPVArPl2+Vmzr5753i5rQahDyBartGkYBY7?=
 =?us-ascii?Q?aGqmP0wIXc6vVcEv1yKg+klgwwCOyd/uUxoLE3KZd07Kmin5ztNuLVYTaxLx?=
 =?us-ascii?Q?QlXmP7SaCKMZTaaZQ/gd/Cog1zmrlfdsSkXDPBp1WjNwOe1IfK2TkXyF1eY5?=
 =?us-ascii?Q?DB3eHJriTA32XX+1FgcA/8XaJx6Yhk10gXCLKMj/DvbVA3kHxZi4vzHE8MwJ?=
 =?us-ascii?Q?7CFYUtmpED3evdkGlWdOO5jyuTWJE42oRd66d4GUxRWiaso2iuUElTQ+IwwI?=
 =?us-ascii?Q?xaUq/mzLiAtr2axcsM5gV4mStw+ZzOJ2fcvyg4k8n9OfW/hIuhGMS6bLRlVG?=
 =?us-ascii?Q?wHpp4a0IouX6JR4mdh8Vs4aVdZZoO95Xh/bAO6VN4yEXHysZjGLSBUH2w5ic?=
 =?us-ascii?Q?YDa7jE/S9Zc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ikkkWQZYfa+Hv2cG5d+QhWn0g0Fe7Fi+yb2Z04Pzj0VGegYfpFrMKxv2A+qR?=
 =?us-ascii?Q?WS4fAtmZusEVXRR2/Uy6SlIY78krbAAGBzwNCkA4ZkeLa97hsnGoyR77vo5y?=
 =?us-ascii?Q?1t+R1pFADVtIHFqGW7LNGY+FqRN7p4zgkg6rctO6567dM4hbtqTQizT6w1Lz?=
 =?us-ascii?Q?F0R2eSM9NDwTq2ul+YCcy/GCNB4G47mY8jvbKO/JVq8FY7vq3PuvwKTmBBuk?=
 =?us-ascii?Q?lsXwhN86jCILzrWyx3ZM/SNRj30nqZnkwaO8ma3ZCo2J2gbBnbu91HmquSO5?=
 =?us-ascii?Q?Kkgsx0DwlFbhV1q+W98PI9vWCL/qK2YGn4mJOI4lNI1ggklxE9cSyeLY3+rG?=
 =?us-ascii?Q?l8xTnGk3htBmalhG7qVMym3D0vtcJ2lk7lT5gyCv+ktTgwK9QyH2XNWCScbM?=
 =?us-ascii?Q?d7NEeiBw9gb/9+hgW6lJJ8NurGVYY1HiUf8CKMsStp9BaOsmJIFYX9NTZMEY?=
 =?us-ascii?Q?sEf7T0WuKXwXJGpKV1phkJho68aeb0jkdnoviGpwncNECR7mw6j/sltpYwUj?=
 =?us-ascii?Q?vd151cGzmB6koo5Fu8q15ldB5imRZziDbZJm1ZOn37hXKayflthXNHy17VIe?=
 =?us-ascii?Q?7BO6YcXhm0mpVN3EaPAyDXkMwdLAPrr9WTIAI7nBS9RBfBbBfZuo6BKUKg8S?=
 =?us-ascii?Q?SUI39h+vsXvGWefyGlXgXhZiKYGXAeoduzOQ2pRumGEDGgJ5uxljE2YqrbQQ?=
 =?us-ascii?Q?fx4pEaj1x3mu5SP5j/fzWcpCiNOxq6vAo3Hp8TsRFDPFFlcmnU5GKFlk7YPC?=
 =?us-ascii?Q?nJ+1hHSBB8zlC7gtZT0BoHOY6doGo/m/F6BPEgBpTphTIbApDVf+lG3lemDl?=
 =?us-ascii?Q?yVU2WjZxP/k1PodD96T2jA1pWl71VAljj9AwDljtTdQ1WXOt4z4vzbF60czO?=
 =?us-ascii?Q?VgNUoj9c1H0iPP2RYS3hqFE8XogRp/0bmaodhQx6GYt3dGyj1Wa3w0dwOql8?=
 =?us-ascii?Q?KA3CHRI3B3ou8zr/ljXjsE/fuis68Oar+rqDAZpIbRPv0dUrnudAH062FUew?=
 =?us-ascii?Q?VulU/j2b94zv8GMmkgHZUalZDeAZLMDt2o3Ba2X0EI0Y44GhWZEliCpyA0W6?=
 =?us-ascii?Q?RGpWJFG62+S2pPfy1MS/HZBmrnDT7BGhRKWmGNjRRjom2yW9UyFm3pHBDaxV?=
 =?us-ascii?Q?7DZlLWbZdnbVPOBNdZHRu85qp676x1We0PRl0J6HLpcRoPRBl40pxq1LTjnI?=
 =?us-ascii?Q?avtRhe68S/U5eErgQGjMTpBnmWVFWSZ8iCsIaKnCku5/uiZP1+Ifup5wsSDP?=
 =?us-ascii?Q?aPMHZwkj29VgOoVAd4vfu7iOZxQICQCoDCl6lukKdEbDYBjK6DTaRMSU8weo?=
 =?us-ascii?Q?62yUtqw9GLwOp6QNaGmiFqI4xoIjmX56FW5MJAbra5PIVEgp6pmaTOszW3TQ?=
 =?us-ascii?Q?DrVUWwQGvoigu+7iFoNMC6VgCFMKrd9beTto1OChIBe6isKachdJQDeNMfdW?=
 =?us-ascii?Q?+XjZPUdPP8tn3Ci18jiPEQAFSvzS1N7sUEg+ykYLTbNVuIb61Yd412jCNZyD?=
 =?us-ascii?Q?z2v4zKum/cC/91VyfZ/2da9DJZPJ1INcAUln7X+5KEdjXtDw39RvaZ+uXJU8?=
 =?us-ascii?Q?wzeDw0zpT3iCnr04Q2nMuhAJJx+NP/FPc78n1J1gJWcROoeHTyeVqeUUb1c3?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce4a09f-729f-4475-9e7e-08dd77acbadf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 21:23:11.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ri6dUg8J5PXNWaL1HEflYFOJrV91ToYQSUrqJ3zZD3LU5lO0xG7wE39+eT68k1PU1aZJ9JDLlGP6FHus5HWVmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6328
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 05:00:49PM +0300, Tariq Toukan wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> Remove members which are now no longer used. In fact, many of the
> `struct mlx5hws_pool_chunk` were not even written to beyond being
> initialized, but they were used in various internals.
> 
> Also cleanup some local variables which made more sense when the API was
> thicker.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../mellanox/mlx5/core/steering/hws/action.c  |  6 +--
>  .../mellanox/mlx5/core/steering/hws/matcher.c | 48 ++++++-------------
>  .../mellanox/mlx5/core/steering/hws/matcher.h |  2 -
>  3 files changed, 16 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
> index 39904b337b81..44b4640b47db 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
> @@ -1583,7 +1583,6 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
>  	struct mlx5hws_matcher_action_ste *table_ste;
>  	struct mlx5hws_pool_attr pool_attr = {0};
>  	struct mlx5hws_pool *ste_pool, *stc_pool;
> -	struct mlx5hws_pool_chunk *ste;
>  	u32 *rtc_0_id, *rtc_1_id;
>  	u32 obj_id;
>  	int ret;
> @@ -1613,8 +1612,6 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
>  	rtc_0_id = &table_ste->rtc_0_id;
>  	rtc_1_id = &table_ste->rtc_1_id;
>  	ste_pool = table_ste->pool;
> -	ste = &table_ste->ste;
> -	ste->order = 1;
>  
>  	rtc_attr.log_size = 0;
>  	rtc_attr.log_depth = 0;
> @@ -1630,7 +1627,7 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
>  
>  	rtc_attr.pd = ctx->pd_num;
>  	rtc_attr.ste_base = obj_id;
> -	rtc_attr.ste_offset = ste->offset;
> +	rtc_attr.ste_offset = 0;

Is the `rtc_attr.ste_offset` member still needed? Can it be removed from
the "cmd.h" header? It's always zero right now, isn't it?

>  	rtc_attr.reparse_mode = mlx5hws_context_get_reparse_mode(ctx);
>  	rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(MLX5HWS_TABLE_TYPE_FDB, false);
>  

[...]

> @@ -300,21 +289,20 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
>  
>  	rtc_attr.pd = ctx->pd_num;
>  	rtc_attr.ste_base = obj_id;
> -	rtc_attr.ste_offset = ste->offset;
> +	rtc_attr.ste_offset = 0;

Same question here.

Thanks,
Michal

