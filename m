Return-Path: <linux-rdma+bounces-9312-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48411A8319A
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 22:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A25E3AD78F
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 20:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88342211491;
	Wed,  9 Apr 2025 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BROwbz0n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F42211479;
	Wed,  9 Apr 2025 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744229074; cv=fail; b=p6D8+nueCpVSTxdD7fbZcl/VphUXKamss83ii29+6Xd07Yk8epeoKWSkp/bY/2Sei2Feq63LeFf+t3F6c6Rfa04oCisGm8YBmJGPc+oHaZxZlGjtdOt7+MYJ6iV/APo4ZGSmc+rW7CFdedD+57PSfSRZOSnQmX+CtRwRs4/FAwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744229074; c=relaxed/simple;
	bh=hBWBJJAMRrhGFIHgyrymH55mo+SWE4v1AQrPiCGB5sc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X1SIJy+xu0k02niyBkrN5EmAuveUicPD9jxTnlRP9+fJ60Mkct3CMqSeSGAFA/n0LRr1qI5oY3gHLYHxcyKPSYn70PQDJkUzXCMqKhyI9zrE6O4wDq6S5apHnL/nUVFRC3aWdhAq3WA7/4XINJag7tHPZ1nJyVgAcQuZbtln/Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BROwbz0n; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744229073; x=1775765073;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hBWBJJAMRrhGFIHgyrymH55mo+SWE4v1AQrPiCGB5sc=;
  b=BROwbz0nUoptFPbjua0uiwt2tFlQcwLALCsy6+TzpFtguhQ4E1cRVfGi
   TqDHCaTj3YRVH5HQM4AxBTKGa2FEmoALErGx2o0CqloFoI2z0llGiF973
   MIYhrkvIZvA8koe34RneEIkBRBAFeuTGUsV8YN9Mu8701uU6fY9qFUAhP
   Xq9LyDdZUCjZUhXV+WIGai7hWh447jye6/ReJN+6lSZaeAKwS0l6rJep/
   /mGZ3GGUuKpSOqG1l1di7ZeX4VsbfOt3AeVlju9TfhKh//hk4wgCkz/jE
   6Y/urg7+RueHsYA6VzaGmN9aFJo9L8IVdLLUILIhTeuUzJSdg8MwtEZ+R
   g==;
X-CSE-ConnectionGUID: cY4wkxmfTreqa943gmsXTg==
X-CSE-MsgGUID: 0yhv+qW3Tm63Tc76xrlN6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="49523376"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="49523376"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 13:04:32 -0700
X-CSE-ConnectionGUID: xC18FLFdQm+2kmlf5UghVA==
X-CSE-MsgGUID: s29r0Ug4TVubs2f5Ni2GIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="132823437"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 13:04:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 13:04:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 13:04:30 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 13:04:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOgjtC1j7QFevI8/8/+/vdY3N8OlZ9Y5kL+G6p9ycrQkuWdZgLAm+1bEZetiB9skxb4immoKUNoY7re1aR1GAGbE61Pas1PlPQde0uN/Qs5EgHtMxyBiKaZoWLwCzUuxkzdPCD4VMrTV96gV/+Aafmr85w+5sGCmv2TQAmmrPVrEJXnup+kfQvhgTihHcCa5o2mKMYfXMjrBFAvsegqa51sOJqzaDhc2/LKMiWKEihABrqEbTppBBFzeeAMwo/my1lxEiNWM/TMHcEgIuSFm7x8fPwVs6AkdU/zrJV7uGjuNmHn6kuYmruP1SypTHjeM4jqBecjLz9owozAOlxJ9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JptZK7/f3Kn8ihtQWWKGVPR5GcSj9m5KsqJviiYT2ac=;
 b=RYRs652QNTX3AGEg/oM856n5I9FRwKZQtRpTLXoJh+jsZDR5mzT5CA4tgbr8u+OckF3rqLCDh/Moo4cFzvBXxELneT4Qi4EIikndBXTLQLdbOm61G+CnpTYD4/DCjxkObxNVPVS1qboo0LD4poG9rnXrBrVBKkMMWrKGi30GbwWdfZfGUDmuOWu6n+YMWBYnobtDiLrgv5VpOmZ+2sdIucQYHcMYbosyrTjJWR2EsLPyNdgxsZk2TCwk2iqBLqJy0OAkleEQkhjcMcIrKJWzIaZbgrCS8x0sO1kJOqeG/i5VVOwoLX5Ewm3FW6nhYNCpN1eYMT4s2ZjUywww2LzRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 CO1PR11MB5155.namprd11.prod.outlook.com (2603:10b6:303:91::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.22; Wed, 9 Apr 2025 20:04:27 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 20:04:27 +0000
Date: Wed, 9 Apr 2025 22:04:13 +0200
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
Subject: Re: [PATCH net-next 03/12] net/mlx5: HWS, Make pool single resource
Message-ID: <Z/bSvTuAD5P8iHxQ@localhost.localdomain>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-4-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1744120856-341328-4-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: MI2P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::9) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|CO1PR11MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: 6602ab6c-8bc5-4cc6-8f11-08dd77a1bb69
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?otrKghqkTzNIXC1KTn8NpIdifg+1F3Q4QjFo0sS3dWGFTilYJgajwuQAJrSm?=
 =?us-ascii?Q?yYMvVc9tAyj63Z8OIigLGhmLBulHjcwIQF5BZhWY7V31ICbuZbGSby7fU6GR?=
 =?us-ascii?Q?0OnbSzYgJt7rb8S8m4NB5pLr58+M/dtW5Ee6KQk0BrRe9NImxMvAUdYgbAUm?=
 =?us-ascii?Q?zqtuZr+kHi+Xa7g4nPnOSTed2n0tH1AEtkbiQ/R5pRHe1izzrWwxqsbY9l3F?=
 =?us-ascii?Q?0ek4rMNZ5sZJywyS68wqAUMSKDzloQ6aVyI+1Ks6vuD9EfS3Qdmh7P2k8yau?=
 =?us-ascii?Q?ozQGVbcCa7AD8+6DLMDIypNeJve60g7Z/CUZuMrUZfSAPXc/6AnDycThHP+B?=
 =?us-ascii?Q?pihYkQR6dmyuYDpuyeNmCfHMY18CKR4B2JRwB0rdr6t+P24kA81h23SpDI4q?=
 =?us-ascii?Q?o5CPMfm5+QappCdirhbYGSUhlbltw6HTanxw129y0RPQyP7jJ0Sf8Y742xMG?=
 =?us-ascii?Q?G3SqlR25fkpDrXRED8h8i/tIRKPRMRLwyVG3dkLNjE0rS0fpAhsRZO/e7DUt?=
 =?us-ascii?Q?rPOCmiEx0lZcqSPQk+AkKpiv54YXyywqvvpsKSb9TuOspaSroisO8v/4dUUW?=
 =?us-ascii?Q?jxqcBJtvGkLaC8SlwMs6eEY5wWlZAr7t2ky91eqiOSlMo2bNocBURQohMagf?=
 =?us-ascii?Q?pgsswV0GLJJzFGBbf+FyeC5foW2f1tSwmP0ZLxD1zbsupTlQMLuFGffRGjte?=
 =?us-ascii?Q?NF+YgKdx9kHBffXknxp5Wcn43SlL6dJ5n0MxDhJciDmfpc3KaY0UMz0UDQNp?=
 =?us-ascii?Q?raIdCxQcJRQAhFj1qYxqaBe2/fBnxoeVmcwDRsQ4e/3Eb6+24kv8CTd3QKt2?=
 =?us-ascii?Q?QeCDZ2xlcIpmQy5I4c7VBnlKa7eGDXYqeZVOa0BNB/aebtasgeY2DMuFGOe5?=
 =?us-ascii?Q?Z+U3ascqecwd5B8hMeYIDV4eqf1/CxY0rTQD0sVeizuAeTgkanbSqc52XKX7?=
 =?us-ascii?Q?XcoFBVrnf9+C9exuRJB9D+UNZEBuFE5lLEo8wcgvaCFMOmpR6Mpfev6Q/4Aa?=
 =?us-ascii?Q?39C8fEURJoMsb5j0wxqspWpVPksRziUKhbDbhDwxOGl0QMQXS9FMbzoDFcw/?=
 =?us-ascii?Q?/cHZP0JsAJZiI0GLvq2AtYGdcQhaaSJ2PzBSNtJcgiByr0FCGhlNyNdCdTiB?=
 =?us-ascii?Q?KRV2L1g/Uy1VH/i6/C3Ty1SkoZMvAzM2IyG1pShORH6+T+RNLxnUtv5f4Nug?=
 =?us-ascii?Q?KksAuKsGTWu6fMorioxLyoNiSIf/mtKt4KVH/bT1w4qqUtG94J46Mc2EbUbj?=
 =?us-ascii?Q?6HPTFKd/cs4TMoVoUMAbnGVHwEZkrtmSbbHqpqE/tjlmDhrii26J4bm80OY8?=
 =?us-ascii?Q?a6CcqnLVL9UI9RrrByHeWUVxuu7jQyX4qpL8cXcOt+JM+euUwzOHQOpa7N2t?=
 =?us-ascii?Q?40ilKfda091l0shyXpxy4WAjP9m8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LJkldddhQzhPd3IffVvaew14/I9F6rtC+hvCuThr67Ymc4v0yqyOhQbzv51s?=
 =?us-ascii?Q?xconSmX/NORSmSWh5BDtXn4Xqq8uDxxz2fIqibRtaxk9b6rEefVhU/etswmH?=
 =?us-ascii?Q?fjtsQwah81kkCWqZY+KRStfzh6+vxtJxqe18S76kcQJmBUiPDPvDGAzm5njX?=
 =?us-ascii?Q?UXi2dPmAMs/MEEZvhB3fXgDfJ1Zzc5HfSJ+oMfY70IK9jGNdo1rbU3HQvAqG?=
 =?us-ascii?Q?uws9rrQfLv9QJSjbmOOw4ENPLs4ToDH+XjTlyfURhLW2X5aOvPm5EZyTzBKW?=
 =?us-ascii?Q?Nmtm1I6+ZXthdtXQi7jpNiRV0zin3F/ALH6l6XBs7MfPwn+axrm6GSgq/zFb?=
 =?us-ascii?Q?ifEtWFF/8QJdnjCH2gDVE8Pcu2CCOoAFqTsC1ch6JzSiotZElzmbscojalkR?=
 =?us-ascii?Q?zJYWcXaKQQtIseNNO4oZzxHPQl6374tf6/jEQYaOFPs+vgh1BBcd3O3AHlOD?=
 =?us-ascii?Q?8sdFn8q9Y8bl6YJ7OHUdqFQ+hLclYZKp56V9gRA6h/hJOPk9eI7BqC5MoJEf?=
 =?us-ascii?Q?V10/HxmOb7nwhbfTsqirYbtn3sp15dgjR7CAJflkjPQwd1ESQ9fVGFJ2bs1t?=
 =?us-ascii?Q?JJEGxwm6E8RzbOabnA2kRv9R/X8QpAHP4DTFlU7LF7nOcoLhfgTCei3o4liW?=
 =?us-ascii?Q?vOfzrH+B7n7hiZzpNdL4DuxTn88cKFrDGwvVvk2oGtTx4LJYn7PtO+1w2HJ5?=
 =?us-ascii?Q?/4KZd1jgiWQzuyKFhwQZahpjmDiE3xcgh13KElZpkoNHJvif2g+jroiLENh4?=
 =?us-ascii?Q?xY2JBBp/VZjSs6gvPVb8266/WE8ZhPbQ9VjPYnMZ4KzlKRl83HSF6kH8dKwi?=
 =?us-ascii?Q?jA48mP7FaMTUQjBTGkktyDG+igAGl+aiGOHJ/BNf/MdOSrqFOWOLGTx8rFRE?=
 =?us-ascii?Q?J15TJMtXoViY4e+2kP+8wM0fdSlqETe8po4cqkOfHF2HeM+7O9nSuxpuMCtj?=
 =?us-ascii?Q?U5HM6yENj40X8fvrNTWTcQ8zNDpKFsVGdeiusOWYNVG/aoFZ+ujHgN2qij7M?=
 =?us-ascii?Q?TAFjeT830soy+KXgTZ4WazgLIngTzk1Ugr+DnbjIRpOjKEg0GjN83wM1twaM?=
 =?us-ascii?Q?xSRMnEVHqjbbyPiV8pku8zhv10/Fu64HbHKK2UBynnXGDrTUc5PR3p0GSb6O?=
 =?us-ascii?Q?4pV5VVGiIjiL//bXQK6COdLk5c9PVQBPeJficKin+YRMri5XhWFXPhgYreTl?=
 =?us-ascii?Q?BvAFFqx+xPNq/+TodZHnMhU9Qasyuh0lr9108/SpFBJMe6tSuo8wFw0oyNpp?=
 =?us-ascii?Q?QYJ/1PRQmIjv9UIE8/FJv4cYB1ZGdJIKCDnymD/drupNve1/qRXOASMwg+lL?=
 =?us-ascii?Q?i84jnzQ2FIiMWiPnTC2BVzyXVgoykdJgAYDONbnxyOYSsapUGdd3GaKNNGXl?=
 =?us-ascii?Q?zWDSEKVHmX48v35exAq9PTltfDbHlCYmZs3UgvV7hwPMKtY2FzYLVKTxKTCn?=
 =?us-ascii?Q?AEzNjOqqkzRVEdXS2UFUlCW9Yp5mOyqLFDK8PU+gGRvbDj5oMkXCI2OV6yrU?=
 =?us-ascii?Q?0fR/g99CgzR1JQnoNnCy/o6KYn9b5PzOq+DM9yXdgiHdF3vpPmNfxomBYIwC?=
 =?us-ascii?Q?wsfSHqNmuUqLunf5KpjPBibri32xyr8GE80SICzEcLIFw3Q6xqhhTvhrhoFd?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6602ab6c-8bc5-4cc6-8f11-08dd77a1bb69
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 20:04:27.7259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlvDllh7kA20kPF2VvX7VCZ+1Oj3yyIAGWMMCAiJ0rKZ4voFCtNbOyta0WvzTgYx9r9gRY5SrwOaidT4C4hsTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5155
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 05:00:47PM +0300, Tariq Toukan wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> The pool implementation claimed to support multiple resources, but this
> does not really make sense in context. Callers always allocate a single
> STC or STE chunk of exactly the size provided.
> 
> The code that handled multiple resources was unused (and likely buggy)
> due to the combination of flags passed by callers.
> 
> Simplify the pool by having it handle a single resource. As a result of
> this simplification, chunks no longer contain a resource offset (there
> is now only one resource per pool), and the get_base_id functions no
> longer take a chunk parameter.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Nice code simplification!

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


