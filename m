Return-Path: <linux-rdma+bounces-4381-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ACE953EB7
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 03:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E20B21733
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 01:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60491803A;
	Fri, 16 Aug 2024 01:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeCoJkEm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9732F15E88;
	Fri, 16 Aug 2024 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723770484; cv=fail; b=DR6rm6u2ncGYNulVq/cONIbYj9KIkpYrCK9JjLPyliP0FRr/mbmPXc9jNakbTrAxfGL1lZc21IV24u/ENS8FWj/l1dcfd8pABEPTP4h3m5qQJahLhWTYGAj6fwg6SWBS5UcAttfBi1A6tN8apRvrDcZdjaoGk/0DH7ZmqeAqWuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723770484; c=relaxed/simple;
	bh=pVKHc/QkfK+hmUjlAKMpT/FhDA8DFsTjUyf/NPdl5uE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=aZYwxxelyWEiXzcxpP3fEKk8S7JnRng55QLNltcbNFsVUN8yR8gjoN5wwyIxuR71fK0PCzGqr7xDudHkgsQB9pmZOP2LIPxuWco9ZNyjFzq4oKnx7k2PXEYqLC7Xe8Xs59kdvj4gBtfHirPOsUZbfAGJP6EZnfdgemRIfZCLcr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeCoJkEm; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723770483; x=1755306483;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pVKHc/QkfK+hmUjlAKMpT/FhDA8DFsTjUyf/NPdl5uE=;
  b=eeCoJkEm0vOAoVrQut1bXb4VQQ154N/Xcztrlu9aE1TrvX9sZGs1qW6m
   cZTsJ9MbsoyeF3oSCiuEeSyYBqhAtbR2Vl+kfY5iJMokk9gcdWajn3Z7y
   zXfC5K84TwCxL6KKKlsBGDlaBphfkLHEPMHPUSMjcNqpRkfN6OupE/20m
   IrjnD6b6MRLy+L0v2Anw0nKoJ71XScNMNz0BBm81svx5lob4+lRZhkd6A
   RsBJSSvJfWye88VKrOvuEtquULKhV5/3WnbxgGF1lTP3ejMaJVgdeOmM/
   xlTQmv2lVUyvFTga3vDKOp21QEkOj9BXB9Ax/K/0YzUIRrFD6nOdPi5j+
   A==;
X-CSE-ConnectionGUID: UfiKW9L1QvGVS4ZFZ3buxA==
X-CSE-MsgGUID: pd8nf438RkG1vR48PWHr7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="39511136"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="39511136"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 18:08:02 -0700
X-CSE-ConnectionGUID: 0baQ6P4bQJSsitC2140Pmg==
X-CSE-MsgGUID: +D6IvoD4SFqRpfmLhrkyjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="59162725"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 18:08:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 18:08:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 18:08:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 18:08:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 18:08:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sk/uhDoU1Y4uDeTzAb2PoL76YerfyLAjimp4sm2AoVRnShDo9honfaTMLxEp9OL63oOyQ+Y/r98RREqhXkkDsAe4cZwCs5N5mipj+afJDFt9sGlm5XofGxgxiVgkJ6Wjzwygdl9JsAVFUmInWsHc8x7XAP7tXV9CXYRnoM+CNiDY20lQaylbuMlM8+SZwRQUu78QEjulmNDumCsl+67gh+XTzS70He14Aoglp3OJ6imyl5rIiiJPW7/037eujphNihi5VvYbqnnNdutGj+bMhhJHYMCL3Qf2w5WY9V2aXET+/bs5ej1bLEsW/nF3C5c3G/HPvsJleVKKNrnHwwzErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVL6TpI697cOyYhom+Ptc9KnlRYXgkmKueva0pegTuY=;
 b=HjSYyuKesO/M+vL2Zrkq0EooPSyhH9p3l5/X/qAITfDsNb6kKsQEELSq8XjUR4aoDXy0PYfRMGS9uhGtBBbJtzv9Uz5YlDWSBgsur+eQqhvv45A9pNNKpvsEmk68SwPbN3NEJrd9TIxNrEKd0nlIj+y5EJGtCTt9D60pgu29HH9SMYEW/FSW+As56FQLWDod0WGwYcySEKkUxulTW0V5EirQM/O3jd7OfobuY7ZvUM2F7eHJBnypAIuzDciDI+NXosnxvLDkxGv8RHSgXOtMvvEwMYpyNozsPmIBSQhtFB4w+CjBikAKBxHJ8VLdWix18mL+UFSiXA646YpDgj93CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 01:07:57 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 01:07:57 +0000
Date: Fri, 16 Aug 2024 09:07:47 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	<linux-rdma@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [RDMA/iwcm]  aee2424246:
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
Message-ID: <202408151633.fc01893c-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ff9a57-c699-423c-4276-08dcbd8fdd5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NQvSwlHBvsYC8jX96J1AWLJ83fwPNVNPwf+nQ7Kf0PYBl7LcwlmkCGIVkdY5?=
 =?us-ascii?Q?IMlt2wTvQmyqXDF+4YDPiWIsDfljb1NVD/V6YFKK3feZouVJEme/1VQJVgGo?=
 =?us-ascii?Q?P9wCRErdNICTH5KdYltqnHqOwEOcPJinPJBh/aTwzTOacu68nn1jyI9OE491?=
 =?us-ascii?Q?tq7ATmHzfK0aOJpy83wg879bF5WUymveGvquQiP5/Zg6J0yDcPWGgYfHYOBV?=
 =?us-ascii?Q?GWIMuIngt5wfRbpaYMqgB8zQ6+imzPDnTgD0khTVdzT/ywHQlELNsiB7D8uV?=
 =?us-ascii?Q?E7p/FXky2Y5EOIOb+48zdo68C4CogJP5eh2D6XrEC8xCj80HEz+OpdJSDPg4?=
 =?us-ascii?Q?iugQal3Sp+enK3GP2PIc3ApQWfWo9Xih9HqDKbEaDeDeMVp3pFhyLWrs5wux?=
 =?us-ascii?Q?olu0lH1teB/7rvpn++m66VzsAJfb2hfu/Ls1QQrxVhF5wVJejfZGIZfO6AEM?=
 =?us-ascii?Q?hiM+KZEyaXaaz0nSZp6/OttngwusRlRS2aikStk+CEDxg00nr+d78T2wFBBh?=
 =?us-ascii?Q?r+/BErRWICu7MyS9kifg1ZQLl6F2JYEoBPBD1CR5kpxCGVqKTTllneju5XII?=
 =?us-ascii?Q?hNInltdipUaKXFUQFH+i/pFftEV7q0vWBU6qS9EzokFvcC8x9sUQF6BW1fRs?=
 =?us-ascii?Q?CZsF4eQgpkRiXQyVQoH6P3RVtOoshDlS7JcYy4UhvBm4eQkygnAFrAoR2Kad?=
 =?us-ascii?Q?UuNhnN4BYBap0e5HnKAiCrgoqaIr1+vijcijI9MzWuNPFQt0OgL+6ToXZWZD?=
 =?us-ascii?Q?kxtBlR9/ndFhPWlryQBgZEjo88IxDIzp16DsOZt3PI0tmkiJSXIziIjyBZab?=
 =?us-ascii?Q?WBQjJo4WehlfuAwTEtQCCNOvWLvW9xi5w0Jp9UsniNUNzZpOt+aUswL+iIn0?=
 =?us-ascii?Q?ooJcMnSXCf1IeFFTjL+ZQGO8DVyjdkKgWb+95Va+ZX4YgNZ6oJ+MBl7repUS?=
 =?us-ascii?Q?/ri5n0j1Bqbnw04jWYhLLI4GLYPjias4T9uHcG09bmc0ytKHpriWJ83yHpZs?=
 =?us-ascii?Q?qyyORjcudOGOMTcXeW5c3PCyDAokByCYhPxq79KjcSipL7JS8I1mlqSu1dnA?=
 =?us-ascii?Q?GHYUMaPqHmGZW/+AVPp/NG7VV57orwSQ/x9ujuY3K3Twxl2gQRt5oIDKHeUe?=
 =?us-ascii?Q?44v/z0701GMNnByCBa24317338f/xFfoDL8SRCRWr1HV+dqA7bjvA7v56vn5?=
 =?us-ascii?Q?pXj0FWYprCowgR7JR+uqXj8WYEwhXsXnnQU29djHwfd5DIFJihDFw71fbD7F?=
 =?us-ascii?Q?HcU1UcXXDScSNaA9ATMVt5P+d7FhmMmfF4odGO2Lgw7WckxaH2FRmcvtegY0?=
 =?us-ascii?Q?3rXl2L2JH6O3BV6rh6KfIAnT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QxHLCWs46Mxn/vyKU3FjwhFDQESJ+OX5lAKqTJErcrbUX3tTFlz+rIWXk8p3?=
 =?us-ascii?Q?6xdp36ZtB0gQP4W4gHKqT9y7lc0o4tCPdO/vNi7n5KQinbDqEiGJcri/uU4R?=
 =?us-ascii?Q?8zrPIIXE/njW/5LGckfsSEgdjowZZ3eS9QMYAmT47aiqZBMK1GARaWZvrV9K?=
 =?us-ascii?Q?UTf9LwDtTbqOgoVPISUxYLPEEbAeqyo9sOoM8MOhww4Y31XhH+ZL+a3vZqLW?=
 =?us-ascii?Q?p5s2N/3+wyG0oEHD21jgrfSHF0bnD5byMOUZaEYkUFjLbcauKMDjE6d+HN5w?=
 =?us-ascii?Q?fxqsUIh2hztGr2YmEcB0odKZYE8WNmGPu2zric5BjrifxbaiNcZZFfGcHTUA?=
 =?us-ascii?Q?6W8urpBNDOgaSggWy0VO+eD7SD+tkzohKXq50dxzE+/c5lLf6lz1xA4OVrSZ?=
 =?us-ascii?Q?m3c3JvSeCaU96y9TeSg7V21no6aiVmhneH10+cwldIsk5xZbzLceGOXhqWE1?=
 =?us-ascii?Q?1SDpv3kk2AJKMWL9LTKaRQLaVQWGUdIvaLL7U6zXjcFYk166nu9wtIimN3aR?=
 =?us-ascii?Q?rM8nzqHxqL/0b7j09/QlLVfSPbQcZ56Is9LTcXdTlOD2YJ+TgWBQEViSMiib?=
 =?us-ascii?Q?dX9nWe7F5wvCxYj2G3EmeTxKltT1qDP52p6dfsMJ+sGU7rs9pk1uTy2rh3m1?=
 =?us-ascii?Q?UEMZ7NXq3oLm9oWBngJcgJxIpkUevEZLb+X9a/xijIJyD8bSXZjNAnU2IumU?=
 =?us-ascii?Q?efj+y9zvC/qzoAsJ93no5ilbyjm1C5gQHBVEWiUPo7cSzB9GiwYX77vlNxO7?=
 =?us-ascii?Q?b5hA7g+Ew731XpOBvfgukN1JAC/Ikstw+/gqaJcUBXsV80icd1EZ9SPHqhVe?=
 =?us-ascii?Q?km8c9a+GTHOXdH3bYcEXxRVTz5SJlOOEH+036Qq6pQGDapYEicyq6Liuu73W?=
 =?us-ascii?Q?sIwrWHpnxGrXo68W6JUPCuImYS4w2OX9cBjhUrtGFiI9ie20dbi3pSYvk2GO?=
 =?us-ascii?Q?IDVJjj1c3bgovcSKXW3n3+bsdv7XuytU8YmAW+LjgF27jySyX2YFIKh1Kbmi?=
 =?us-ascii?Q?zpbwR/iKFQ7g+O4M97iPnVoC8fxNqXJSLRJ8WBBJRTySjDUYjtGCUO4AydGn?=
 =?us-ascii?Q?htaWMLAwUieE1YNrTIBKPO9LTn7on2ulP/A5IAxTG3nvNXpIrvHyEiD0SsgS?=
 =?us-ascii?Q?IsL7AlJTK1Eiyqss/FIOsR51FC1dHbfo9QNTUVtYM1zkshGeoBRn3NW9rZxs?=
 =?us-ascii?Q?AVCPjkPDoP4xO04V45DI7jfHQEBuDMbcOLzinxn0r8qvJHWaUELieRs/aS1P?=
 =?us-ascii?Q?k0MPmxOt4bOGLJrBOW+9e7Ov4rKAmMq/ThCFMA1qfhuvRBuIrb8POoQW/miW?=
 =?us-ascii?Q?ZDqVuDntASrBOJFFNxiwBk6LefNqSNf07BNcw4GMQXebOHDK0MaOLPmO4LD8?=
 =?us-ascii?Q?Q6J4biJshPyz9plZdjyz0c32QLwBLy/qCntRLyG1ulQuLqboLf7agxoUnTHn?=
 =?us-ascii?Q?IysW2GiBJG0Ijx8OMKA8PyfsL+8Ii7V3UKOc1vhsa9btjtoRQ0gNhhyAxYQy?=
 =?us-ascii?Q?Se4X9/clP0eP3b+0fHCi9u+JKadY/U+QonfRyVq647ZDWU9K62o5k0tbYglt?=
 =?us-ascii?Q?VeeP+LOuGgBYFAQs1Cg2aT0WdZU7kZgLrirhGCzk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ff9a57-c699-423c-4276-08dcbd8fdd5b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 01:07:57.4797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jcQzmcxC97I+gja0WGbh+W6mozJ0FPVU0uLhXtuGCyx/2qh5hZfJ7PKj8NefmXVrX0CnKwNLlVKsTw7hoaaYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/workqueue.c:#check_flush_dependency" on:

commit: aee2424246f9f1dadc33faa78990c1e2eb7826e4 ("RDMA/iwcm: Fix a use-after-free related to destroying CM IDs")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      5189dafa4cf950e675f02ee04b577dfbbad0d9b1]
[test failed on linux-next/master 61c01d2e181adfba02fe09764f9fca1de2be0dbe]

in testcase: blktests
version: blktests-x86_64-775a058-1_20240702
with following parameters:

	disk: 1SSD
	test: nvme-group-01
	nvme_trtype: rdma



compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408151633.fc01893c-oliver.sang@intel.com


[  125.048981][ T1430] ------------[ cut here ]------------
[  125.056856][ T1430] workqueue: WQ_MEM_RECLAIM nvme-reset-wq:nvme_rdma_reset_ctrl_work [nvme_rdma] is flushing !WQ_MEM_RECLAIM iw_cm_wq:0x0
[ 125.056873][ T1430] WARNING: CPU: 2 PID: 1430 at kernel/workqueue.c:3706 check_flush_dependency (kernel/workqueue.c:3706 (discriminator 9)) 
[  125.085014][ T1430] Modules linked in: siw ib_uverbs nvmet_rdma nvmet nvme_rdma nvme_fabrics rdma_cm iw_cm ib_cm ib_core dimlib dm_multipath btrfs blake2b_generic intel_rapl_msr xor intel_rapl_common zstd_compress intel_uncore_frequency intel_uncore_frequency_common raid6_pq libcrc32c x86_pkg_temp_thermal intel_powerclamp coretemp nvme nvme_core ast t10_pi kvm_intel qat_4xxx drm_shmem_helper mei_me kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 rapl intel_cstate intel_uncore dax_hmem intel_th_gth intel_qat crc64_rocksoft_generic dh_generic intel_th_pci idxd crc8 i2c_i801 crc64_rocksoft mei intel_vsec idxd_bus drm_kms_helper intel_th authenc crc64 i2c_smbus i2c_ismt ipmi_ssif wmi acpi_power_meter ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler acpi_pad binfmt_misc loop fuse drm dm_mod ip_tables [last unloaded: ib_uverbs]
[  125.176472][ T1430] CPU: 2 PID: 1430 Comm: kworker/u898:26 Not tainted 6.10.0-rc1-00015-gaee2424246f9 #1
[  125.188840][ T1430] Workqueue: nvme-reset-wq nvme_rdma_reset_ctrl_work [nvme_rdma]
[ 125.199152][ T1430] RIP: 0010:check_flush_dependency (kernel/workqueue.c:3706 (discriminator 9)) 
[ 125.207527][ T1430] Code: fa 48 c1 ea 03 80 3c 02 00 0f 85 a8 00 00 00 49 8b 54 24 18 49 8d b5 c0 00 00 00 49 89 e8 48 c7 c7 20 46 08 84 e8 ed 8b f9 ff <0f> 0b e9 93 fd ff ff e8 a1 bf 82 00 e9 80 fd ff ff e8 97 bf 82 00
All code
========
   0:	fa                   	cli    
   1:	48 c1 ea 03          	shr    $0x3,%rdx
   5:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   9:	0f 85 a8 00 00 00    	jne    0xb7
   f:	49 8b 54 24 18       	mov    0x18(%r12),%rdx
  14:	49 8d b5 c0 00 00 00 	lea    0xc0(%r13),%rsi
  1b:	49 89 e8             	mov    %rbp,%r8
  1e:	48 c7 c7 20 46 08 84 	mov    $0xffffffff84084620,%rdi
  25:	e8 ed 8b f9 ff       	callq  0xfffffffffff98c17
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 93 fd ff ff       	jmpq   0xfffffffffffffdc4
  31:	e8 a1 bf 82 00       	callq  0x82bfd7
  36:	e9 80 fd ff ff       	jmpq   0xfffffffffffffdbb
  3b:	e8 97 bf 82 00       	callq  0x82bfd7

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 93 fd ff ff       	jmpq   0xfffffffffffffd9a
   7:	e8 a1 bf 82 00       	callq  0x82bfad
   c:	e9 80 fd ff ff       	jmpq   0xfffffffffffffd91
  11:	e8 97 bf 82 00       	callq  0x82bfad
[  125.231266][ T1430] RSP: 0018:ffa000001375fb88 EFLAGS: 00010282
[  125.239626][ T1430] RAX: 0000000000000000 RBX: ff11000341233c00 RCX: 0000000000000027
[  125.250304][ T1430] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ff110017fc930b08
[  125.260878][ T1430] RBP: 0000000000000000 R08: 0000000000000001 R09: ffe21c02ff926161
[  125.271664][ T1430] R10: ff110017fc930b0b R11: 0000000000000010 R12: ff1100208d2a4000
[  125.282387][ T1430] R13: ff1100020d87a000 R14: 0000000000000000 R15: ff11000341233c00
[  125.292984][ T1430] FS:  0000000000000000(0000) GS:ff110017fc900000(0000) knlGS:0000000000000000
[  125.304552][ T1430] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  125.313446][ T1430] CR2: 00007fa84066aa1c CR3: 000000407c85a005 CR4: 0000000000f71ef0
[  125.324080][ T1430] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  125.334584][ T1430] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[  125.345252][ T1430] PKRU: 55555554
[  125.350876][ T1430] Call Trace:
[  125.356281][ T1430]  <TASK>
[ 125.361285][ T1430] ? __warn (kernel/panic.c:693) 
[ 125.367640][ T1430] ? check_flush_dependency (kernel/workqueue.c:3706 (discriminator 9)) 
[ 125.375689][ T1430] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 125.382505][ T1430] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 125.388987][ T1430] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 125.395831][ T1430] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 125.403125][ T1430] ? check_flush_dependency (kernel/workqueue.c:3706 (discriminator 9)) 
[ 125.410984][ T1430] ? check_flush_dependency (kernel/workqueue.c:3706 (discriminator 9)) 
[ 125.418764][ T1430] __flush_workqueue (kernel/workqueue.c:3970) 
[ 125.426021][ T1430] ? __pfx___might_resched (kernel/sched/core.c:10151) 
[ 125.433431][ T1430] ? destroy_cm_id (drivers/infiniband/core/iwcm.c:375) iw_cm
[  125.440844][ T2411] /usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-spr-2sp1/blktests-1SSD-rdma-nvme-group-01-debian-12-x86_64-20240206.cgz-aee2424246f9-20240809-69442-1dktaed-4.yaml&job_state=running -O /dev/null
[ 125.441209][ T1430] ? __pfx___flush_workqueue (kernel/workqueue.c:3910) 
[  125.441215][ T2411]
[ 125.473900][ T1430] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 125.473909][ T1430] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:161) 
[  125.480265][ T2411] target ucode: 0x2b0004b1
[ 125.482537][ T1430] _destroy_id (drivers/infiniband/core/cma.c:2044) rdma_cm
[  125.488511][ T2411]
[ 125.495072][ T1430] nvme_rdma_free_queue (drivers/nvme/host/rdma.c:656 drivers/nvme/host/rdma.c:650) nvme_rdma
[  125.500747][ T2411] LKP: stdout: 2876: current_version: 2b0004b1, target_version: 2b0004b1
[ 125.505827][ T1430] nvme_rdma_reset_ctrl_work (drivers/nvme/host/rdma.c:2180) nvme_rdma
[ 125.505831][ T1430] process_one_work (kernel/workqueue.c:3231) 
[  125.508377][ T2411]
[ 125.515122][ T1430] worker_thread (kernel/workqueue.c:3306 kernel/workqueue.c:3393) 
[ 125.515127][ T1430] ? __pfx_worker_thread (kernel/workqueue.c:3339) 
[  125.524642][ T2411] check_nr_cpu
[ 125.531837][ T1430] kthread (kernel/kthread.c:389) 
[  125.537327][ T2411]
[ 125.539864][ T1430] ? __pfx_kthread (kernel/kthread.c:342) 
[  125.545392][ T2411] CPU(s):                               224
[ 125.550628][ T1430] ret_from_fork (arch/x86/kernel/process.c:147) 
[  125.554342][ T2411]
[ 125.558840][ T1430] ? __pfx_kthread (kernel/kthread.c:342) 
[ 125.558844][ T1430] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[  125.561843][ T2411] On-line CPU(s) list:                  0-223
[  125.566487][ T1430]  </TASK>
[  125.566488][ T1430] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240815/202408151633.fc01893c-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


