Return-Path: <linux-rdma+bounces-9338-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5849A84A6D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 18:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED127B0BAE
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 16:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05F81EEA28;
	Thu, 10 Apr 2025 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2jrgzZ7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D041AAA1E;
	Thu, 10 Apr 2025 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744303739; cv=fail; b=bco8DXBg2DhXo0tlXm3bqsUIn+1fRgdvOZ49J4mG66e2mrfsyaYgJBgGwUgnBpWGtcVhrvt3cUgperBnEINhjL5LaUQwgr92Twt2BCUw2/pahFU1Ys8f6XoOxkbNnlPtAsSh2Yql8H6MQ3dWwBES+nMiWbgBcpvynDqWV/+h8x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744303739; c=relaxed/simple;
	bh=Rbvd737R9TQl98DkCz5S3omthWLnoOFtJmJO7isq7I8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nf8sLlxKNgjyAw8p09zNs9aDD6Bx3WEHptyCTb93KUR5rDPL/HLZbRFUO7L273Umysa2YxfdwYB2kIM1lWpfaY3X00GhJ+8eBEcsn6Mp7XAB0QSDS7afWQkVLMyS3hjBx20IKta8uvNanUIKEZYwe9a32el/vyZ7fzOtHpXokyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2jrgzZ7; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744303737; x=1775839737;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Rbvd737R9TQl98DkCz5S3omthWLnoOFtJmJO7isq7I8=;
  b=g2jrgzZ7++I35uHgEGLE+q/ZcaBf7vkZqgzKhaijVBuCZUUvfGihR1Ri
   RqX/uC3pTsIafHiZnChYgRMrm+bikIOVfVk/iM3u6YvmgS7Cunw9hD7MK
   VTt55k03fBsdF0YfIF9LYyOT1/esk+Gi/OpeslFao/LzH4fDdLVeUHMHx
   R8NTTG79qgLvjv354rBiV983L71cWAXe914sqOK3pu9hEaKL4oyT1++2L
   amMNN6LTfN1zrTNnV3cvXXtNpYz9N7A9fNSUwBCUec+bxkSZhQHhfV28p
   H0Gwpa5oKtUhRGmZ1J/iJlk+RrGrsPl2DC4903EKPK4QU59DMCSLowcvm
   g==;
X-CSE-ConnectionGUID: qTHd+hgcTPaYv7JRJ4yagw==
X-CSE-MsgGUID: DACpIHEVQg2hyOkfWmYeMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56505828"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56505828"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 09:48:51 -0700
X-CSE-ConnectionGUID: mlMFz59iQ16pVBkn8dxvvg==
X-CSE-MsgGUID: pCwftYjNRjmf3D8uZyu1GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129299918"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 09:48:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 09:48:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 09:48:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 09:48:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPutx0bv1THMuoCNyEJqlUjy9jirLmRrWS0ecsvb5AeBpQg+MJeNHW9tPq9j1kLl++gNl2nzxltaepGpA+exVgXkQidtTHy7Ud5yvW5Iqy7AYdY4Ohiwf/tDq6aOVuyO0ICujVKJlkh4krcg+cmUssR8ovXHBo/Rm/qxn4xRhbBByAk9zlKtYnRxdWkKG/BZEwlUfKnKeHbJLeyVbxYxzabJeAEN5hvxBhplHFZapyPRJCdf/rK/tXNWsTDbEdSC5Iw4f54rU9SmX+Cq7x6TQg8d3bLMwYj9YNMsafF2Rc7ZwjN1noMDrh2elU5KsS9KneU2bbqqEc0RJ8DAm52c1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2kO3dlEZelEYQZeuAbLx570FZGG4K74zrFcv6PCSwY=;
 b=qWT/3ANd2KPsfqp64oVmMJXParQT9JhkntcsJHsC7pboP2HOEv1E9GpU15+pItKZ2SVJlwKbhq/KdwKavT7pSVFVj39bgnsjThRchtoypbSTzklcJVfJzhtuhEQcJ9q7+ktLQ5O2xbPdoDtbRsBjLOvwWDEWPlug3K1jvwamr8GjbMCdGkaSYtNeLbReY4pNPVdhD3D1eXhR1nETDDEGv+8muJspDjCeLJoOQ1H4W6oegYLWAsnxyevuALDk4wznA8eJlAsU1gsJqMEJ2wGmjm04Yse8aEMXwIYEdWNyy6mrIyeCdiEU4HChs+BJrf2q57OttkTuk7/zMW2YI3K21g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 CH3PR11MB8185.namprd11.prod.outlook.com (2603:10b6:610:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 16:48:46 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 16:48:46 +0000
Date: Thu, 10 Apr 2025 18:48:39 +0200
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
Subject: Re: [PATCH net-next 09/12] net/mlx5: HWS, Use the new action STE pool
Message-ID: <Z/f2Z6xwAHMi/2yA@localhost.localdomain>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-10-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1744120856-341328-10-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: DB8PR09CA0013.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::26) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|CH3PR11MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: a9773eb5-6122-47fe-23dd-08dd784f8f73
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?buZ3UYlGDZJv42D1BFaCJlD1J8gZ4Jc0qb57fjMv20JVe1CQIZpNhxO1cbr5?=
 =?us-ascii?Q?iV3JxpsLJKGxTkH8FF1EGM3SxdGSJV/jeHU+FD0ero4iG7EGTm+oKDsk1aDL?=
 =?us-ascii?Q?BZoBJaVVut18R9ipM8EUKSu+S+dqzZ3AsY2zwKTaO+C1FNP8zGY9x0O2KPw2?=
 =?us-ascii?Q?mcOWC971z9S7yLDWlzApKJQnOlvu/l821SQIm3kacBB4ANwsuXLobVpd4LTM?=
 =?us-ascii?Q?SSHsJQ2aRgd2PVAiAZ15lGpiQdSJ5oXTaUyQmquqACyc0VS7mlMLoOAFGY4O?=
 =?us-ascii?Q?7a13RrlC7aWbBaDQY3jDmsU1c2nVyOqmS+vvjg4Dt76yPlAY+SXcGUdYCTQ8?=
 =?us-ascii?Q?br6hfHLngfHPlxvxZtthyCWwx7yAQ0uixM6phgIG16e8UpvChGuTkDk6fdJT?=
 =?us-ascii?Q?foKGLUq6vBD89NQCRDSGIGa0/QsDbU0X6ro2gjw2cg5XxLW4FpMosyX+cYiQ?=
 =?us-ascii?Q?I2DXvu9xmbb/uPOJHMyyw4Km77xYpby+69qXNPuAjpZhzBT02NaHwSENtpAt?=
 =?us-ascii?Q?IIm2rqH1q80AcL2MdbFA8pDdc2+NsfYLVOENc5SpaF8cI1HWXtLcA35gs5h7?=
 =?us-ascii?Q?KL9JhxTmhywcgFnv+Ruu09f0BKE2Sa0GFyJ5D4DUSiMauAWGCmZHkaMD6N2X?=
 =?us-ascii?Q?6nTng2Rs0/IN0HTFndU03jA+qrZeKd3upUXlmpGBMOqSV2wZYccSOYWJS4N8?=
 =?us-ascii?Q?GqpB0T7om8edCUtnXTu+MVEnLtJbBWH+9wTecF+uyYnjpmerQCVtQqni6fqn?=
 =?us-ascii?Q?ZC/8LoTyco0in+aQVvn/TbQAXKR1Sp55AFQhnS8MYimID/3cvwlx1t1vU+qU?=
 =?us-ascii?Q?KoO4Yyt7d8w7ik48widIYvFp3cwK4mI6Ps+URElVoewcYpKMzwpC3/4gieLL?=
 =?us-ascii?Q?RkpZ2EkdMkC9ML0FnwQxcPacgJLJk83ULA0PH3HH8JrIISOE7FqbUW3LX8Ha?=
 =?us-ascii?Q?k6uorNQSKQ4qZwFoWQqEmudvpwcwjlARUjBj+EYAsU+vTs2wh4F7vRxyNUWc?=
 =?us-ascii?Q?R8s/qDzOfooEQUfzJop4FA2BLj3yaPjqWbUQIsAZy9sRzSHE4hNmXtAipK9+?=
 =?us-ascii?Q?kblW6eRhssRA/ccxFsVJbSMal3DgjKgWNA+U59oqz2tASxCrLsAa+tgovV+i?=
 =?us-ascii?Q?4GmKkfO3V9gUKsEQ/hChvGWIQOi+34QTgA1S0AppN+O+z43s62DVJe06N4ia?=
 =?us-ascii?Q?VfgS/d+IK0Lw9L+3yg7tTFWBAqNOrrJoWl3+4GE0NCoUAgsBwSi53U/JJQDv?=
 =?us-ascii?Q?bHKjuBvl40frsfER3BFZ4RA7Mmn7cV/+DOHfIp/hm6Vr1N+pCeJZZrL43U5O?=
 =?us-ascii?Q?ryNOTeCnu+5fciOCTg9iIsryQwIAbhyjCF8UninlyenvHuxNslP9Z8wPelvC?=
 =?us-ascii?Q?3DOZ5yHFVheEURM6LXM95lTi4RpG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zRrCDONRgqA8ZLFwXBryiowaVasflm2oYZ17f2glEKsr9B7uhKNJRiMJfEVP?=
 =?us-ascii?Q?0KoKmJtcGT49H4zXnFyY5le40+z3nAfDvy/VZFKQ4WhdeN/FxxG5IUr0691P?=
 =?us-ascii?Q?cEtJLyUYAScV6CLCs2QNH4jJ2Z3LvDMh0AkzLFJGrBBTvJYJ1oeUUvRbVOeR?=
 =?us-ascii?Q?022Xf/5UinTgUFkLzGBwo5rx1xs09Zey59M0CGAvSvG3TwqaDARA+ZfbNqZd?=
 =?us-ascii?Q?nOYsTJ4KfE5M6yt7YfkQohtxATWV6xcTdqtKUyz0A9c8MOmXd6xiknU1Hl3Y?=
 =?us-ascii?Q?L0m3wU0lRr0za3c/83GpOkqVZOwprZEtckDCe5/sjlvkjIj3jfgkovVZzscn?=
 =?us-ascii?Q?vwa3uwYUthuVqPO076OGYb51iRl83IGLaPyaMCpgbgZqXuUbe5PGuBgQbp8J?=
 =?us-ascii?Q?idgPChXNyfvstSc6KeO5nQKuaPmDllTdPEIBl36INg1w4nV9P1kHtjQ+Z+hs?=
 =?us-ascii?Q?oevHPN3/3LIsHUZyhV5NtxguwUQXNngA3KY/APPEriXkFFsqZ4TBbACtOvQm?=
 =?us-ascii?Q?aWaBGTs+FSuBuVezT4ZSkcwrbGMen+uvWknQjk+F8YBQEwjjTPFx1A0GR4PI?=
 =?us-ascii?Q?z++K2O9js0WhvWYNaFkz06NhVntUtVYTvHW2o4wPAZmaIzWyrJ2rR8yfCS83?=
 =?us-ascii?Q?c23nV5fQg0dJ6WPcMbZPXt3uGq68WJtA72XJhexFxG3hv04YoAVoIwzoLBky?=
 =?us-ascii?Q?A/1vnYgOfbYTo2I8nkGCR99UnRGcOFfxPyADPazkYXoPE+HSzzZoeBE4bk55?=
 =?us-ascii?Q?6jEIFKYZvonZ2ySaFeSJHKvNhUBXC1wn4pDej+BqcUBAMIIS2hbqelPdvT02?=
 =?us-ascii?Q?7YdU8oyq0Ic+DJ5ngQhd1YwBSKRbCoKrWvS3u877XBZOwAIJpPnZlRJJ6FFE?=
 =?us-ascii?Q?Vdw/ITdhLSvWNvt28oap4XPn+llbzZ9Fp3KuRcR+4zKsJ8biIQLlVjRobOEf?=
 =?us-ascii?Q?KTaAC1RVIiMplskUUc7PqJD43aAjEGWSq+cSdZJ0SwESHuaq1JlmHaXAF52U?=
 =?us-ascii?Q?ckOe8GgF8ZJRkDOIXMDhjq7rH89Z9dfQdiDyBzo3bmBypLt9C2tPHrMcMMP4?=
 =?us-ascii?Q?h8MVdljk/1L61QNFL7CKBE2M5zUiF9QcSIS0WVKkeC/8beFVO8vmUUEOCL07?=
 =?us-ascii?Q?ydfA/KAF5yAAbMS0dFoa3uRchMM5rGoRvyAGaNw+776LRcWnAMpxYOuIlvi8?=
 =?us-ascii?Q?qKf8QVvGpqu0A5dK0S5TSbyJdLv3o8hocPKmL309UU3wZ+DAzSrYvYNjAXZp?=
 =?us-ascii?Q?GDZUeNtLq+aAYjvuySeP8Jl2PnjGa+lJPtuVHtXT9oWdiWI9voqxDbKU4PeI?=
 =?us-ascii?Q?RSYhPvyLuQpfF6SflmdUIxRRZNOCCHdbpZouMcT86ANZAODKVURx9NDmxSB/?=
 =?us-ascii?Q?Rl+8a+Xh+MnqSm2e4yzKI+cJ2UFSg9rHiBphB/i1TRFeuF7JRd9vBvB83M+8?=
 =?us-ascii?Q?rQ2Dg4VjR9xeVF85hx2PY03x8kt8J1G/8dSFGeyUkp/4BQnpo7k8CionO4f8?=
 =?us-ascii?Q?qPHxKZ7NuBbPIVobrWfLrFE8odpNA68Cc/7wJzhHlCM+WD0dLVk8E60UHApa?=
 =?us-ascii?Q?Gj/4DFb2LqJCgCiP2PA+sMBZIgNTziXhHZ55nBvDOKpq83nS8XX07fF5vnE3?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9773eb5-6122-47fe-23dd-08dd784f8f73
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 16:48:46.2632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3RdCvjCI8a+IWEA9gped/1vN4AUWLSneK5CwuE8sVBVKmBETIyCd6iQbelYXu3iTRK28tu943kpK4B+p3ZOrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8185
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 05:00:53PM +0300, Tariq Toukan wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> Use the central action STE pool when creating / updating rules.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


