Return-Path: <linux-rdma+bounces-2818-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CA48FAF24
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 11:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4865D1C21BFB
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 09:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDDC140380;
	Tue,  4 Jun 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZa9g+Aw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D645F132C3B;
	Tue,  4 Jun 2024 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494254; cv=fail; b=bqg1JCKF6hhE/6hc2tiKK7EPgyeNGIXQ32XI8a3tAmVa4XPK5BK32CZtjL06kF54MMi3zBTyo0tpO+CtEtzbx3Kz3B8XBXQGKe60Na2dC5VYIn67w2Qbcgq9CVrxSvPKepcEd1ei9ZAWh74f+tWoatDnjUJPnZhc49ZoT1iw/AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494254; c=relaxed/simple;
	bh=8dKV3nagLq/T0MChC2u/SgWlhLNYsZDQjwDKQTSRqvE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W3bTLxjbKxVue0MCcSGcA8Kh+SHTYjdv90GmtzWqQTei4h0VThHT1bnMDjreuNKRDBKBP4Z48Noue6fQfoaKbcwLb07NaXMZ2GLpFDzT7RiiUDBfWtQkFOx61Cj/ZBPCCWkYdvJqjgha24KheSYZ7FGnts0RVt7ZZYz9gwoWocM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZa9g+Aw; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717494252; x=1749030252;
  h=from:to:subject:date:message-id:references:in-reply-to:
   mime-version;
  bh=8dKV3nagLq/T0MChC2u/SgWlhLNYsZDQjwDKQTSRqvE=;
  b=PZa9g+AwA3C6JOHpUNwSP07TaL0ll6+c+lOgp7+KNfBeMrntE5x04RBl
   wBPCgxmrf2uMh4NykaaAb2GquCaq86O6oJGadkil/h6Dpgcc+dm5BC4gJ
   oSHa9rzI1+qtpDfjUGcAy9TTsxCJKrFju7N8Gw2FKTD+HxhuwSFrfWd86
   Og0pNFVz91tVYjT06ZBG7cdCTFELpRM3fIWbzytKE0u0M8Slgee2NLL4F
   k9cKY/GYy9O2E3TTiaDWE7/yi+aOkOHjEqzrhbFLQbLgsnmiI3PvWCMdF
   ZdZn3stLlAEQ2WqSje+jePmDANYlCIrWyI/cVE7fWQHjj511K0unUnfIO
   Q==;
X-CSE-ConnectionGUID: ZVSE2Hj0QNypZoEGDC2cjQ==
X-CSE-MsgGUID: MIyRnjNBT6yF/EJ7CToIcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17817190"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="log'?scan'208,217";a="17817190"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 02:44:11 -0700
X-CSE-ConnectionGUID: nYrCAoAISkqh5FAHLm5NOw==
X-CSE-MsgGUID: LrVo2Y+bSqSTsH8QrWjm6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="log'?scan'208,217";a="37055143"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 02:44:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 02:44:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 02:44:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 02:44:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejQ6HF/GH13Mrm2ZfzB+c87hg8UN7yedwF40ZmTp+2tQ8JYGptzYp7jhN//elOvMtGqdb/lAAvKHoVUK1hEQ5plHXB28US5D4gnxWn3CTpz1UOs6ye1PEKlgkzqJ/zrShxFFA6RiXmwVeTVwSzXU7sZWTda7QCfYb4qbrsk/9qiemP/7bbQZk7ZkXIpJOzAyHAf7Ug2LNBmoubzwmRKpsEmbdeIZSDJ3fy1hsX9gEwhEAyhuSmXEPKGhyR8+O82MDi+8zCgyAjfk+fqTnTtKiH1X0CzN4Y2Du1MgRpVT5ZdR1zZDfvAWzlJygCEQXyB6FpJ//MYIwNC0nDTps3k9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USwvQq5ns1r3yQI+/QofQ1kXGlkbDs9gXXe4mo1xReI=;
 b=YJy1/HZ7q3/T/ZSIbTOjsys6i54s07lzqP9eRtzYNkQBFU0Y9/7+oMRQUdrtblGDhECOXY5GflUDTh1bqWSlBE+DKQRxgrAUuHsRxituZLNkCoM1YQs8IesrKo2IRq0foUYjqJWCGGHlTeF6hIusFfXjaCRWX7ic/Phah17aaKZtvpwErbNd2x05KJw+pjnOG7wMzMGOGjILQpkDJN2hESfUQBRMWJexNtMSdtKRoCpgOzKy8z9/1IKdVq3usPN8CiPiqdP9zOvpaWbJy9ylKZ7shDt6c2cmsI1SPVDyiiVnKjYFdCg0I4Q0jNtQTPEoZDal89i62xPptkDGsU+4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20)
 by IA1PR11MB7919.namprd11.prod.outlook.com (2603:10b6:208:3fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 4 Jun
 2024 09:44:07 +0000
Received: from PH0PR11MB5159.namprd11.prod.outlook.com
 ([fe80::e7aa:f8cd:6386:5562]) by PH0PR11MB5159.namprd11.prod.outlook.com
 ([fe80::e7aa:f8cd:6386:5562%6]) with mapi id 15.20.7633.018; Tue, 4 Jun 2024
 09:44:07 +0000
From: "Berger, Michal" <michal.berger@intel.com>
To: Shay Drori <shayd@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "moshe@nvidia.com" <moshe@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"phaddad@nvidia.com" <phaddad@nvidia.com>
Subject: Re: Kernel panic triggered while removing mlx5_core devices from the
 pci bus
Thread-Topic: Kernel panic triggered while removing mlx5_core devices from the
 pci bus
Thread-Index: Adqtr4L1Ysw2QWzPS/S9Q/FUKTvMrwBubLaAAFcaIU4AaMMUgAD+omM7
Date: Tue, 4 Jun 2024 09:44:07 +0000
Message-ID: <PH0PR11MB5159A3CA682964B9B77A06A9E6F82@PH0PR11MB5159.namprd11.prod.outlook.com>
References: <PH0PR11MB515991D1E1AB73AFB7DCBD03E6F52@PH0PR11MB5159.namprd11.prod.outlook.com>
 <c51bef25-e8c5-492d-bb80-965b7f8542f7@nvidia.com>
 <PH0PR11MB515990257791E24CF6E0E51CE6F12@PH0PR11MB5159.namprd11.prod.outlook.com>
 <ba2adb79-7783-45cc-9597-a99d25c5db62@nvidia.com>
In-Reply-To: <ba2adb79-7783-45cc-9597-a99d25c5db62@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5159:EE_|IA1PR11MB7919:EE_
x-ms-office365-filtering-correlation-id: d4d11e8f-0e16-41c4-9850-08dc847ae0f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?1vCj+HjQdxiWClrQvEWlxZJ98otE/jg9pCLnbIbEWPvTWvr53P+w8vTZSDJq?=
 =?us-ascii?Q?3L8B7aLi5cCZb6UEJ3ipd5Pv8zTO7GDHUZnzlirE847DpEGR+Xgv7x5lrqZ4?=
 =?us-ascii?Q?nV6SI5tunZvHJLpJ6vViwr6bqZLuHqwMIQLT8fN7bfnf5/xRTu7iQ9yxfg9H?=
 =?us-ascii?Q?4FMn8bD4xhRq3/NN5d+AuxHuoCGER2f2fcBOw6u09d4FxaVYnhx+Qa4unZck?=
 =?us-ascii?Q?9g+Q8qQdGuuB0qfyK64KSvDjE43N+3tXAWIH5EIAds4HSF+V/ihJMme9rrGY?=
 =?us-ascii?Q?WpircD2AIGVhm+mNOBlUOqgFBPRUyXoy3Yaf+Q+tsxmlGvtHEjadV2FsbYbm?=
 =?us-ascii?Q?gn0XPbxqq/CAqRzBFvH6Wsc5jla3K3RRF9yVFQPToawgGrwrtW2Sv3T10gCE?=
 =?us-ascii?Q?XTN4J0VWXx+1gGeNVvB0MjaBddVIBPvNemjh7qW1a342V6zTktKKxCnYbUM6?=
 =?us-ascii?Q?Z/qaYuEmIAuNa5tiqHtY7sZ6UZVTjnBqRCaiNGsunvThIwi6Rt0hvA9Xt/Rt?=
 =?us-ascii?Q?grNM+31JLf+HusXEQU0SQWSUPK9l4BVR/KngPkUGcn9LlxIGIfC4ITqd2zVT?=
 =?us-ascii?Q?FagDfIeoq3uyWZKGZ8+gBPRWt5drhCGUKO71vcPvWYUOC8WNbE08ONGhtltV?=
 =?us-ascii?Q?vV8T7nBUuhcrrfRw4JiSBmOJQ5pHV79MVfGWjiCwDlB0iLnRu7+0qVvJItkq?=
 =?us-ascii?Q?QVTqlMAQLNL1N6J6Ceg3j+EfTyH3AL0ziHlIlZeyZ1efWEj5DE64cRPyHzyN?=
 =?us-ascii?Q?d4BGIL4r5wsiQyRX3cH17KFBUZCJu95MXncPno3ASwWxDuY28owvfv+NL04T?=
 =?us-ascii?Q?6XRN0/+N03+xD5tWyuabmnGGjjQHac0RdHDHhqpWM8kHpq0zULzjmLgCgwhv?=
 =?us-ascii?Q?vrgx+AXdnnQFNzOhEMR6LbNQRvhMfPLgxdJaI56yiGZSZX0C0WD98vlr29tj?=
 =?us-ascii?Q?GEQBAaYasEoAqRMuYdETMhespvClGFPBgMu6VYdbRfD5RXlkHYzWjQt75Czd?=
 =?us-ascii?Q?xrqOADf/d5ILxwpV250a/h2fQMZpjE6UcbN/cdSNiK14/aNhskJvAKdgXwW+?=
 =?us-ascii?Q?jsft7Kd1eCtMkdiMGYjoHaBOAqEVQ4kjrxb2o4/Rw5wDfynWlofl1A3tVo1/?=
 =?us-ascii?Q?GX4O7f3qEKwo5SHgOZF71HGjyxOQEriiCAf9D4OkLHzrN7ZlxBcqb9uANcA/?=
 =?us-ascii?Q?ArGBWLVWHQ/MFSFD6E+HHKYgXwyo8ukk+r0zu770jcF2RU/KQ1TQW2lf3nEK?=
 =?us-ascii?Q?uBb2mUIvcY0mYCwaQswD343RwVKeR6qXf4tMObX3RElO1FElpEi4oHjJbLuq?=
 =?us-ascii?Q?lJiUl79A5w/PumceE4QwrQtFAYT3bwIzyGUN2bwV6wrYEw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5159.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SPW3XQBLN5p9kW5lDr2IgadzeBk68ddwtmKGKflj+Le+2iFD/KPepm9Y0fJP?=
 =?us-ascii?Q?r834rslotkB3xzyrIzxoblwvETVhbg+lbmBwmSDtbG/lPvATmwOM8Tzr5Bxk?=
 =?us-ascii?Q?IxPqYE/pVrGmKPAzHb/DA2ETISWaspJ0Qslm5W9aIGExog+W4juEgOcxmJ3o?=
 =?us-ascii?Q?hVqwBlwvDjYqrLsp+3iqrOakpH/wObbKFlF1QK7JqyIC/UZSJLGGBjr3jb5V?=
 =?us-ascii?Q?Hf5JCyGfpAheuNph2gtRTYuzSFuvwUcztGDhG+/izSrfRvsfVtUvXqIvreJM?=
 =?us-ascii?Q?gDSS9CSN5umgnsTih4HQbG1ZjtQPHktLemaAedQkPjDIRN+ek1ZuiQtf10Kk?=
 =?us-ascii?Q?95N8JcYVLcYrVKveDOMD9kcmMnCO5nq+O9eEkPKE6G0kB083taAVoY1sbsSA?=
 =?us-ascii?Q?ZTax4LZSGyEKBg0ycnzk4h2ncVtYocmKqUbaJlJ36uu7qKmSze7CKu8aUja/?=
 =?us-ascii?Q?66Bmkuu8MRDonY5AqNB3Q9xN1ChulEpM5LpoaNK3ob41VuzgTDOJXL92nY01?=
 =?us-ascii?Q?VW42eDSKh3Ln4QTdLBlT6D1pQzf4PgrmruORh8IvgLoe2HGoWde9UkqweDiS?=
 =?us-ascii?Q?PgSbbPcixGzTVRk6uQmpWTGAh67qYIFIsjD4sfpIR4/3O0u0g/Sc1sQGfGwl?=
 =?us-ascii?Q?z7MRh17v6oIBO7huX9x0pulKv9z7gw1xfJQ14LD6WmhnTwmvYvYMSGOhMxxW?=
 =?us-ascii?Q?0LoarHNsD4Rq1IP9cOoZAvuafAW9ghKVdY681GU0YFIWE1eerbOsc+BukHzz?=
 =?us-ascii?Q?TvVPZBXScY55lfoOIvaN1XW7ogtYzWXQm43EtgcIcgtzvqakLksWXhmyAMQI?=
 =?us-ascii?Q?Cze/3o+XaAXzaPdVNDz0zZBS7ZQxti5lhuSN3cYMZnLsZpvtDTyztlpNdrby?=
 =?us-ascii?Q?JneFY+iNY/cRXgHCWJuifJqOfmA/lhYrG/MQM2BllmBlswNDCHRa3mcyCed3?=
 =?us-ascii?Q?z5xyrv/+ag3ypIWExx6Z79MkgLfdZ1NBSGORTR6yvpRzzJKIIqkds4ElOKrw?=
 =?us-ascii?Q?MYQCQV4Zfd+LjTZ0O2g8uwPLTzPmfDlWbkJqi83S2Ql4NlL1rlI74rRnJffu?=
 =?us-ascii?Q?ugzyaYZCQqs4+MLkBvlJHSlgASf/vswcytMvCdDdICe44AhWEyHiYix8ZVcM?=
 =?us-ascii?Q?A2CNFCtvSGo/YZGUzyP0/5SczRiqVVm+4JQARzV0NdaEQAVHjs4bUFMjAdcm?=
 =?us-ascii?Q?kCC4/ojuo7TPTAb/Wpgir4OiHl3jgrYfiw+DGXWxreHRkxD29MSr2TTcO0WJ?=
 =?us-ascii?Q?NvobZwDnQny20kwGTu1vEY/JXoUTcjM1ho1fwBv1amFz3QPO9DvJieavu57G?=
 =?us-ascii?Q?zHFIT0w1+2nQpVSgU8XFohJOBPgqu/f8SG6hwmbe87rx7GTT4J4HbE1r6K06?=
 =?us-ascii?Q?GSErpSbnGO5MgdqUFhK6CyNoa1HOqXZidsbIVvCwV9JruLnyigzI7JQh8Yu6?=
 =?us-ascii?Q?eIv2F+xrCMxUU9Vht4PwAMq6vgtPlWUurBMlcm4XKfKoWLZqE2B8IvJrk8a0?=
 =?us-ascii?Q?BdbxSbq+/PgzwGR9Te0Akk3ojSNEdd0nol0otLzbavg/z2e4OzXdZVZHn7J/?=
 =?us-ascii?Q?DKqEpuwEbbeW4+xU5TzrMbm7olfLwck5FTrwMF0P?=
Content-Type: multipart/mixed;
	boundary="_004_PH0PR11MB5159A3CA682964B9B77A06A9E6F82PH0PR11MB5159namp_"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5159.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d11e8f-0e16-41c4-9850-08dc847ae0f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 09:44:07.4311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrKTnS4LRRZIHQhFVb3074hPLCCrPhMwTDCtM+Vl6VAmYFEth2FIaWAlWCv8UY9TWxbMWBpPxI/9Z8kQfygRFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7919
X-OriginatorOrg: intel.com

--_004_PH0PR11MB5159A3CA682964B9B77A06A9E6F82PH0PR11MB5159namp_
Content-Type: multipart/alternative;
	boundary="_000_PH0PR11MB5159A3CA682964B9B77A06A9E6F82PH0PR11MB5159namp_"

--_000_PH0PR11MB5159A3CA682964B9B77A06A9E6F82PH0PR11MB5159namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi Shay,

I am afraid that the suggested change didn't help (I applied both patches n=
ow on top of 6.8.9), kernel still crashes with very similar (if not the sam=
e) traces, please see attached.

Regards,
Michal



________________________________
From: Shay Drori <shayd@nvidia.com>
Sent: Thursday, May 30, 2024 10:09 AM
To: Berger, Michal <michal.berger@intel.com>; netdev@vger.kernel.org <netde=
v@vger.kernel.org>; moshe@nvidia.com <moshe@nvidia.com>; linux-rdma@vger.ke=
rnel.org <linux-rdma@vger.kernel.org>; phaddad@nvidia.com <phaddad@nvidia.c=
om>
Subject: Re: Kernel panic triggered while removing mlx5_core devices from t=
he pci bus

Hi Michal

can you please try the bellow change[1]?
In addition, the bug/trace is in mlx5_ib driver code, so I CC rdma ML
(linux-rdma@vger.kernel.org).

thanks
Shay Drory

[1]
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -614,7 +614,6 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq, int
num_entries, struct ib_wc *wc)
         int soft_polled =3D 0;
         int npolled;
-       spin_lock_irqsave(&cq->lock, flags);
         if (mdev->state =3D=3D MLX5_DEVICE_STATE_INTERNAL_ERROR) {
                 /* make sure no soft wqe's are waiting */
                 if (unlikely(!list_empty(&cq->wc_list)))
@@ -625,6 +624,7 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq, int
num_entries, struct ib_wc *wc)
                 goto out;
         }
+       spin_lock_irqsave(&cq->lock, flags);
         if (unlikely(!list_empty(&cq->wc_list)))
                 soft_polled =3D poll_soft_wc(cq, num_entries, wc, false);
@@ -635,9 +635,9 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq, int
num_entries, struct ib_wc *wc)
         if (npolled)
                 mlx5_cq_set_ci(&cq->mcq);
-out:
         spin_unlock_irqrestore(&cq->lock, flags);
+out:
         return soft_polled + npolled;
}


On 28/05/2024 9:18, Berger, Michal wrote:
> *External email: Use caution opening links or attachments*
>
>
> Hi Shay,
>
> Appreciate your feedback. I applied the suggested change on top of our
> 6.8.9 kernel build, but I am afraid it didn't solve the problem.
> Granted, the stacktrace doesn't point at the mlx5_health* anymore, but
> the panic happens exactly at the same time - it takes couple dozen of
> tries to trigger it, but it's still there. Attaching latest trace.
>
> Michal Berger
>
>
> Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk
>
> KRS 101882
>
> NIP 957-07-52-316
>
> ------------------------------------------------------------------------
> *From:* Shay Drori <shayd@nvidia.com>
> *Sent:* Sunday, May 26, 2024 2:35 PM
> *To:* Berger, Michal <michal.berger@intel.com>; netdev@vger.kernel.org
> <netdev@vger.kernel.org>; moshe@nvidia.com <moshe@nvidia.com>
> *Subject:* Re: Kernel panic triggered while removing mlx5_core devices
> from the pci bus
> Hi Michal.
>
> can you please try the bellow change[1]?
> we try it locally and it seems to solve the issue.
>
> thanks
> Shay Drory
>
> [1]
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index 6574c145dc1e..459a836a5d9c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -1298,6 +1298,9 @@ static int mlx5_function_teardown(struct
> mlx5_core_dev *dev, bool boot)
>           if (!err)
>                   mlx5_function_disable(dev, boot);
> +       else
> +               mlx5_stop_health_poll(dev, boot);
> +
>           return err;
> }
>
>
>
> On 24/05/2024 11:07, Berger, Michal wrote:
>> Kernel: 6.7.0, 6.8.8 (fedora builds)
>> Devices: MT27710 Family [ConnectX-4 Lx] (0x1015), fw_ver: 14.23.1020
>> rdma-core: 44.0
>>
>> We have a small test which performs a somewhat controlled hotplug of the=
 net device on the pci bus (via sysfs). The affected device is part of the =
nvmf-rdma setup running in SPDK context (i.e. https://github.com/spdk/spdk/=
blob/master/test/nvmf/target/device_removal.sh) <https://github.com/spdk/sp=
dk/blob/master/test/nvmf/target/device_removal.sh)>  Sometimes (it's not re=
producible at each run unfortunately) when the device is removed, kernel hi=
ts
>> Oops - with our panic setup it's then followed by a kernel reboot, but i=
f we allow the kernel to continue it eventually deadlocks itself.
>>
>> This happens across different systems using the same set of NICs. Exampl=
e of these oops attached.
>>
>> Just to note, we previously had the same issue under older kernels (e.g.=
 6.1), all reported here  https://bugzilla.kernel.org/show_bug.cgi?id=3D218=
288
> <https://bugzilla.kernel.org/show_bug.cgi?id=3D218288>. Bump to 6.7.0
> helped to reduce the frequency
>> of this issue but unfortunately it's still there.
>>
>> Any hints on how to tackle this issue would be appreciated.
>>
>> Regards,
>> Michal
>> ---------------------------------------------------------------------
>> Intel Technology Poland sp. z o.o.
>> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII W=
ydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52=
-316 | Kapital zakladowy 200.000 PLN.
>> Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu u=
stawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w tr=
ansakcjach handlowych.
>>
>> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adres=
ata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej=
 wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jak=
iekolwiek przegladanie lub rozpowszechnianie  jest zabronione.
>> This e-mail and any attachments may contain confidential material for th=
e sole use of the intended recipient(s). If you are not the intended recipi=
ent, please contact the sender and delete all copies; any review or distrib=
ution by others is strictly prohibited.

--_000_PH0PR11MB5159A3CA682964B9B77A06A9E6F82PH0PR11MB5159namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Shay,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I am afraid that the suggested change didn't help (I applied both patches n=
ow on top of 6.8.9), kernel still crashes with very similar (if not the sam=
e) traces, please see attached.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Michal</div>
<div id=3D"Signature">
<p>&nbsp;</p>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Shay Drori &lt;shayd@=
nvidia.com&gt;<br>
<b>Sent:</b> Thursday, May 30, 2024 10:09 AM<br>
<b>To:</b> Berger, Michal &lt;michal.berger@intel.com&gt;; netdev@vger.kern=
el.org &lt;netdev@vger.kernel.org&gt;; moshe@nvidia.com &lt;moshe@nvidia.co=
m&gt;; linux-rdma@vger.kernel.org &lt;linux-rdma@vger.kernel.org&gt;; phadd=
ad@nvidia.com &lt;phaddad@nvidia.com&gt;<br>
<b>Subject:</b> Re: Kernel panic triggered while removing mlx5_core devices=
 from the pci bus</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Michal<br>
<br>
can you please try the bellow change[1]?<br>
In addition, the bug/trace is in mlx5_ib driver code, so I CC rdma ML<br>
(linux-rdma@vger.kernel.org).<br>
<br>
thanks<br>
Shay Drory<br>
<br>
[1]<br>
--- a/drivers/infiniband/hw/mlx5/cq.c<br>
+++ b/drivers/infiniband/hw/mlx5/cq.c<br>
@@ -614,7 +614,6 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq, int <br>
num_entries, struct ib_wc *wc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int soft_polled =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int npolled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;cq-&gt;lock, f=
lags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mdev-&gt;state =3D=3D =
MLX5_DEVICE_STATE_INTERNAL_ERROR) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* make sure no soft wqe's are waiting */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(!list_empty(&amp;cq-&gt;wc_list)))<br>
@@ -625,6 +624,7 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq, int <br>
num_entries, struct ib_wc *wc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;cq-&gt;lock, f=
lags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(!list_empty(&=
amp;cq-&gt;wc_list)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; soft_polled =3D poll_soft_wc(cq, num_entries, wc, fal=
se);<br>
@@ -635,9 +635,9 @@ int mlx5_ib_poll_cq(struct ib_cq *ibcq, int <br>
num_entries, struct ib_wc *wc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (npolled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mlx5_cq_set_ci(&amp;cq-&gt;mcq);<br>
-out:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(&am=
p;cq-&gt;lock, flags);<br>
+out:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return soft_polled + npoll=
ed;<br>
}<br>
<br>
<br>
On 28/05/2024 9:18, Berger, Michal wrote:<br>
&gt; *External email: Use caution opening links or attachments*<br>
&gt; <br>
&gt; <br>
&gt; Hi Shay,<br>
&gt; <br>
&gt; Appreciate your feedback. I applied the suggested change on top of our=
 <br>
&gt; 6.8.9 kernel build, but I am afraid it didn't solve the&nbsp;problem. =
<br>
&gt; Granted, the stacktrace doesn't point at the mlx5_health* anymore, but=
 <br>
&gt; the panic happens exactly at the same time - it takes couple dozen of =
<br>
&gt; tries to trigger it, but it's still there. Attaching latest trace.<br>
&gt; <br>
&gt; Michal Berger<br>
&gt; <br>
&gt; <br>
&gt; Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdans=
k<br>
&gt; <br>
&gt; KRS 101882<br>
&gt; <br>
&gt; NIP 957-07-52-316<br>
&gt; <br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Shay Drori &lt;shayd@nvidia.com&gt;<br>
&gt; *Sent:* Sunday, May 26, 2024 2:35 PM<br>
&gt; *To:* Berger, Michal &lt;michal.berger@intel.com&gt;; netdev@vger.kern=
el.org <br>
&gt; &lt;netdev@vger.kernel.org&gt;; moshe@nvidia.com &lt;moshe@nvidia.com&=
gt;<br>
&gt; *Subject:* Re: Kernel panic triggered while removing mlx5_core devices=
 <br>
&gt; from the pci bus<br>
&gt; Hi Michal.<br>
&gt; <br>
&gt; can you please try the bellow change[1]?<br>
&gt; we try it locally and it seems to solve the issue.<br>
&gt; <br>
&gt; thanks<br>
&gt; Shay Drory<br>
&gt; <br>
&gt; [1]<br>
&gt; diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c<br>
&gt; b/drivers/net/ethernet/mellanox/mlx5/core/main.c<br>
&gt; index 6574c145dc1e..459a836a5d9c 100644<br>
&gt; --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c<br>
&gt; +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c<br>
&gt; @@ -1298,6 +1298,9 @@ static int mlx5_function_teardown(struct<br>
&gt; mlx5_core_dev *dev, bool boot)<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!err)<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mlx5_function_disable(dev, boot);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mlx5_stop_health_poll(dev, boot);<br>
&gt; +<br>
&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&gt; }<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On 24/05/2024 11:07, Berger, Michal wrote:<br>
&gt;&gt; Kernel: 6.7.0, 6.8.8 (fedora builds)<br>
&gt;&gt; Devices: MT27710 Family [ConnectX-4 Lx] (0x1015), fw_ver: 14.23.10=
20<br>
&gt;&gt; rdma-core: 44.0<br>
&gt;&gt; <br>
&gt;&gt; We have a small test which performs a somewhat controlled hotplug =
of the net device on the pci bus (via sysfs). The affected device is part o=
f the nvmf-rdma setup running in SPDK context (i.e.
<a href=3D"https://github.com/spdk/spdk/blob/master/test/nvmf/target/device=
_removal.sh)">
https://github.com/spdk/spdk/blob/master/test/nvmf/target/device_removal.sh=
)</a> &lt;<a href=3D"https://github.com/spdk/spdk/blob/master/test/nvmf/tar=
get/device_removal.sh">https://github.com/spdk/spdk/blob/master/test/nvmf/t=
arget/device_removal.sh</a>)&gt;&nbsp;&nbsp;Sometimes
 (it's not reproducible at each run unfortunately) when the device is remov=
ed, kernel hits<br>
&gt;&gt; Oops - with our panic setup it's then followed by a kernel reboot,=
 but if we allow the kernel to continue it eventually deadlocks itself.<br>
&gt;&gt; <br>
&gt;&gt; This happens across different systems using the same set of NICs. =
Example of these oops attached.<br>
&gt;&gt; <br>
&gt;&gt; Just to note, we previously had the same issue under older kernels=
 (e.g. 6.1), all reported here&nbsp;
<a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D218288">https://bu=
gzilla.kernel.org/show_bug.cgi?id=3D218288</a>
<br>
&gt; &lt;<a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D218288">h=
ttps://bugzilla.kernel.org/show_bug.cgi?id=3D218288</a>&gt;. Bump to 6.7.0
<br>
&gt; helped to reduce the frequency<br>
&gt;&gt; of this issue but unfortunately it's still there.<br>
&gt;&gt; <br>
&gt;&gt; Any hints on how to tackle this issue would be appreciated.<br>
&gt;&gt; <br>
&gt;&gt; Regards,<br>
&gt;&gt; Michal<br>
&gt;&gt; ------------------------------------------------------------------=
---<br>
&gt;&gt; Intel Technology Poland sp. z o.o.<br>
&gt;&gt; ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc |=
 VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957=
-07-52-316 | Kapital zakladowy 200.000 PLN.<br>
&gt;&gt; Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumi=
eniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznienio=
m w transakcjach handlowych.<br>
&gt;&gt; <br>
&gt;&gt; Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego=
 adresata i moze zawierac informacje poufne. W razie przypadkowego otrzyman=
ia tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usunieci=
e; jakiekolwiek przegladanie lub rozpowszechnianie&nbsp;
 jest zabronione.<br>
&gt;&gt; This e-mail and any attachments may contain confidential material =
for the sole use of the intended recipient(s). If you are not the intended =
recipient, please contact the sender and delete all copies; any review or d=
istribution by others is strictly prohibited.<br>
</div>
</span></font></div>
</body>
</html>

--_000_PH0PR11MB5159A3CA682964B9B77A06A9E6F82PH0PR11MB5159namp_--

--_004_PH0PR11MB5159A3CA682964B9B77A06A9E6F82PH0PR11MB5159namp_
Content-Type: application/octet-stream; name="oops1.log"
Content-Description: oops1.log
Content-Disposition: attachment; filename="oops1.log"; size=8647;
	creation-date="Tue, 04 Jun 2024 09:43:14 GMT";
	modification-date="Tue, 04 Jun 2024 09:43:23 GMT"
Content-Transfer-Encoding: base64

MjAyNC0wNi0wNFQxMToyNTo1NCswMjowMAlKdW4gIDQgMDk6MjU6NTQgMTAuMjExLjE2NC4xMDkg
WyAyOTkzLjE1MTI0N10gbWx4NV9jb3JlIDAwMDA6ODI6MDAuMDogRS1Td2l0Y2g6IFVubG9hZCB2
ZnM6IG1vZGUoTEVHQUNZKSwgbnZmcygwKSwgbmVjdmZzKDApLCBhY3RpdmUgdnBvcnRzKDApDQoy
MDI0LTA2LTA0VDExOjI1OjU0KzAyOjAwCUp1biAgNCAwOToyNTo1NCAxMC4yMTEuMTY0LjEwOSBb
IDI5OTMuMTgxNzY5XSBtbHg1X2NvcmUgMDAwMDo4MjowMC4wOiBFLVN3aXRjaDogRGlzYWJsZTog
bW9kZShMRUdBQ1kpLCBudmZzKDApLCBuZWN2ZnMoMCksIGFjdGl2ZSB2cG9ydHMoMCkNCjIwMjQt
MDYtMDRUMTE6MjU6NTQrMDI6MDAJSnVuICA0IDA5OjI1OjU0IDEwLjIxMS4xNjQuMTA5IFsgMjk5
My4yMTYxNDFdIEJVRzogdW5hYmxlIHRvIGhhbmRsZSBwYWdlIGZhdWx0IGZvciBhZGRyZXNzOiBm
ZmZmZmZmZmFiZTIwNjYwDQoyMDI0LTA2LTA0VDExOjI1OjU0KzAyOjAwCUp1biAgNCAwOToyNTo1
NCAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuMjI0MDc3XSAjUEY6IHN1cGVydmlzb3Igd3JpdGUgYWNj
ZXNzIGluIGtlcm5lbCBtb2RlDQoyMDI0LTA2LTA0VDExOjI1OjU0KzAyOjAwCUp1biAgNCAwOToy
NTo1NCAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuMjMwMTQ3XSAjUEY6IGVycm9yX2NvZGUoMHgwMDAy
KSAtIG5vdC1wcmVzZW50IHBhZ2UNCjIwMjQtMDYtMDRUMTE6MjU6NTQrMDI6MDAJSnVuICA0IDA5
OjI1OjU0IDEwLjIxMS4xNjQuMTA5IFsgMjk5My4yMzYxMjNdIFBHRCA3ZTM0MmQwNjcgUDREIDdl
MzQyZDA2NyBQVUQgN2UzNDJlMDYzIFBNRCA4MDBmZmZmODFjMWZmMDYyIA0KMjAyNC0wNi0wNFQx
MToyNTo1NCswMjowMAlKdW4gIDQgMDk6MjU6NTQgMTAuMjExLjE2NC4xMDkgWyAyOTkzLjI0NDE0
NV0gT29wczogMDAwMiBbIzFdIFBSRUVNUFQgU01QIFBUSQ0KMjAyNC0wNi0wNFQxMToyNTo1NCsw
MjowMAlKdW4gIDQgMDk6MjU6NTQgMTAuMjExLjE2NC4xMDkgWyAyOTkzLjI0OTA4NV0gQ1BVOiAx
NCBQSUQ6IDM4MSBDb21tOiBrd29ya2VyL3U4NTowIFRhaW50ZWQ6IEcgICAgICAgICAgIE9FICAg
ICAgNi44LjktMjAwLmZjMzkueDg2XzY0ICMxDQoyMDI0LTA2LTA0VDExOjI1OjU0KzAyOjAwCUp1
biAgNCAwOToyNTo1NCAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuMjU5NzIyXSBIYXJkd2FyZSBuYW1l
OiBJbnRlbCBDb3Jwb3JhdGlvbiBTMjYwMEdaL1MyNjAwR1osIEJJT1MgU0U1QzYwMC44NkIuMDIu
MDYuMDAwNi4wMzI0MjAxNzA5NTAgMDMvMjQvMjAxNw0KMjAyNC0wNi0wNFQxMToyNTo1NCswMjow
MAlKdW4gIDQgMDk6MjU6NTQgMTAuMjExLjE2NC4xMDkgWyAyOTkzLjI3MTQyNl0gV29ya3F1ZXVl
OiBpYi1jb21wLXVuYi13cSBpYl9jcV9wb2xsX3dvcmsgW2liX2NvcmVdDQoyMDI0LTA2LTA0VDEx
OjI1OjU0KzAyOjAwCUp1biAgNCAwOToyNTo1NCAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuMjc4MzMz
XSBSSVA6IDAwMTA6bmF0aXZlX3F1ZXVlZF9zcGluX2xvY2tfc2xvd3BhdGgrMHgyN2YvMHgyZDAN
CjIwMjQtMDYtMDRUMTE6MjU6NTUrMDI6MDAJSnVuICA0IDA5OjI1OjU0IDEwLjIxMS4xNjQuMTA5
IFsgMjk5My4yODU0ODNdIENvZGU6IDQxIDg5IGQ2IDQ0IDBmIGI3IGU4IDQxIDgzIGVlIDAxIDQ5
IGMxIGU1IDA1IDRkIDYzIGY2IDQ5IDgxIGM1IDAwIDU2IDAzIDAwIDQ5IDgxIGZlIDAwIDIwIDAw
IDAwIDczIDQ1IDRlIDAzIDJjIGY1IGEwIDNjIGMwIGFhIDw0OT4gODkgNmQgMDAgOGIgNDUgMDgg
ODUgYzAgNzUgMDkgZjMgOTAgOGIgNDUgMDggODUgYzAgNzQgZjcgNDggOGINCjIwMjQtMDYtMDRU
MTE6MjU6NTUrMDI6MDAJSnVuICA0IDA5OjI1OjU0IDEwLjIxMS4xNjQuMTA5IFsgMjk5My4zMDY5
NzJdIFJTUDogMDAxODpmZmZmYzA0MmM3ZWJiZDQ4IEVGTEFHUzogMDAwMTAwODYNCjIwMjQtMDYt
MDRUMTE6MjU6NTUrMDI6MDAJSnVuICA0IDA5OjI1OjU0IDEwLjIxMS4xNjQuMTA5IFsgMjk5My4z
MTMwNzldIFJBWDogMDAwMDAwMDAwMDAwMDAwMyBSQlg6IGZmZmY5ZTg5ZmE3YTllMDAgUkNYOiAw
MDAwMDAwMDAwMDAwMDEwDQoyMDI0LTA2LTA0VDExOjI1OjU1KzAyOjAwCUp1biAgNCAwOToyNTo1
NCAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuMzIxMzE1XSBSRFg6IDAwMDAwMDAwMDAwMDEwMWYgUlNJ
OiAwMDAwMDAwMDQwN2ZhOWM4IFJESTogZmZmZjllODlmYTdhOWUwMA0KMjAyNC0wNi0wNFQxMToy
NTo1NSswMjowMAlKdW4gIDQgMDk6MjU6NTQgMTAuMjExLjE2NC4xMDkgWyAyOTkzLjMyOTU1NV0g
UkJQOiBmZmZmOWU4OWZiZTM1NjAwIFIwODogMmM2ZjZjNmU2MjJjNjE2OCBSMDk6IGZmZmY5ZTg5
ZmE1OGQ2NDANCjIwMjQtMDYtMDRUMTE6MjU6NTUrMDI6MDAJSnVuICA0IDA5OjI1OjU0IDEwLjIx
MS4xNjQuMTA5IFsgMjk5My4zMzc5ODFdIFIxMDogMDAwMDAwMDAwMDAwMDAwZiBSMTE6IGZlZmVm
ZWZlZmVmZWZlZmYgUjEyOiAwMDAwMDAwMDAwM2MwMDAwDQoyMDI0LTA2LTA0VDExOjI1OjU1KzAy
OjAwCUp1biAgNCAwOToyNTo1NCAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuMzQ2MjQ2XSBSMTM6IGZm
ZmZmZmZmYWJlMjA2NjAgUjE0OiAwMDAwMDAwMDAwMDAxMDFlIFIxNTogZmZmZjllODlmYTdhOWUw
MA0KMjAyNC0wNi0wNFQxMToyNTo1NSswMjowMAlKdW4gIDQgMDk6MjU6NTUgMTAuMjExLjE2NC4x
MDkgWyAyOTkzLjM1NDUwMl0gRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY5ZTg5
ZmJlMDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KMjAyNC0wNi0wNFQxMToyNTo1
NSswMjowMAlKdW4gIDQgMDk6MjU6NTUgMTAuMjExLjE2NC4xMDkgWyAyOTkzLjM2Mzg3OF0gQ1M6
ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KMjAyNC0wNi0w
NFQxMToyNTo1NSswMjowMAlKdW4gIDQgMDk6MjU6NTUgMTAuMjExLjE2NC4xMDkgWyAyOTkzLjM3
MDY0NF0gQ1IyOiBmZmZmZmZmZmFiZTIwNjYwIENSMzogMDAwMDAwMDdlMzQyODAwMiBDUjQ6IDAw
MDAwMDAwMDAxNzA2ZjANCjIwMjQtMDYtMDRUMTE6MjU6NTUrMDI6MDAJSnVuICA0IDA5OjI1OjU1
IDEwLjIxMS4xNjQuMTA5IFsgMjk5My4zNzg5NjddIENhbGwgVHJhY2U6DQoyMDI0LTA2LTA0VDEx
OjI1OjU1KzAyOjAwCUp1biAgNCAwOToyNTo1NSAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuMzgyMDM2
XSAgPFRBU0s+DQoyMDI0LTA2LTA0VDExOjI1OjU1KzAyOjAwCUp1biAgNCAwOToyNTo1NSAxMC4y
MTEuMTY0LjEwOSBbIDI5OTMuMzg0NzI5XSAgPyBfX2RpZSsweDIzLzB4NzANCjIwMjQtMDYtMDRU
MTE6MjU6NTUrMDI6MDAJSnVuICA0IDA5OjI1OjU1IDEwLjIxMS4xNjQuMTA5IFsgMjk5My4zODg1
MDNdICA/IHBhZ2VfZmF1bHRfb29wcysweDE3MS8weDRmMA0KMjAyNC0wNi0wNFQxMToyNTo1NSsw
MjowMAlKdW4gIDQgMDk6MjU6NTUgMTAuMjExLjE2NC4xMDkgWyAyOTkzLjM5MzQzNF0gID8gZXhj
X3BhZ2VfZmF1bHQrMHgxNzUvMHgxODANCjIwMjQtMDYtMDRUMTE6MjU6NTUrMDI6MDAJSnVuICA0
IDA5OjI1OjU1IDEwLjIxMS4xNjQuMTA5IFsgMjk5My4zOTgyNzZdICA/IGFzbV9leGNfcGFnZV9m
YXVsdCsweDI2LzB4MzANCjIwMjQtMDYtMDRUMTE6MjU6NTUrMDI6MDAJSnVuICA0IDA5OjI1OjU1
IDEwLjIxMS4xNjQuMTA5IFsgMjk5My40MDMzMDldICA/IG5hdGl2ZV9xdWV1ZWRfc3Bpbl9sb2Nr
X3Nsb3dwYXRoKzB4MjdmLzB4MmQwDQoyMDI0LTA2LTA0VDExOjI1OjU1KzAyOjAwCUp1biAgNCAw
OToyNTo1NSAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuNDA5ODc4XSAgX3Jhd19zcGluX2xvY2tfaXJx
c2F2ZSsweDNkLzB4NTANCjIwMjQtMDYtMDRUMTE6MjU6NTUrMDI6MDAJSnVuICA0IDA5OjI1OjU1
IDEwLjIxMS4xNjQuMTA5IFsgMjk5My40MTUwODddICBtbHg1X2liX3BvbGxfY3ErMHg1ZC8weGU0
MCBbbWx4NV9pYl0NCjIwMjQtMDYtMDRUMTE6MjU6NTUrMDI6MDAJSnVuICA0IDA5OjI1OjU1IDEw
LjIxMS4xNjQuMTA5IFsgMjk5My40MjA3NTRdICA/IGZpbmlzaF90YXNrX3N3aXRjaC5pc3JhLjAr
MHg5NC8weDJmMA0KMjAyNC0wNi0wNFQxMToyNTo1NSswMjowMAlKdW4gIDQgMDk6MjU6NTUgMTAu
MjExLjE2NC4xMDkgWyAyOTkzLjQyNjU3NV0gIF9faWJfcHJvY2Vzc19jcSsweDRmLzB4MTgwIFtp
Yl9jb3JlXQ0KMjAyNC0wNi0wNFQxMToyNTo1NSswMjowMAlKdW4gIDQgMDk6MjU6NTUgMTAuMjEx
LjE2NC4xMDkgWyAyOTkzLjQzMjI0Nl0gIGliX2NxX3BvbGxfd29yaysweDJhLzB4ODAgW2liX2Nv
cmVdDQoyMDI0LTA2LTA0VDExOjI1OjU1KzAyOjAwCUp1biAgNCAwOToyNTo1NSAxMC4yMTEuMTY0
LjEwOSBbIDI5OTMuNDM3ODExXSAgcHJvY2Vzc19vbmVfd29yaysweDE3Ni8weDM0MA0KMjAyNC0w
Ni0wNFQxMToyNTo1NSswMjowMAlKdW4gIDQgMDk6MjU6NTUgMTAuMjExLjE2NC4xMDkgWyAyOTkz
LjQ0MjY3NF0gIHdvcmtlcl90aHJlYWQrMHgyN2IvMHgzYTANCjIwMjQtMDYtMDRUMTE6MjU6NTUr
MDI6MDAJSnVuICA0IDA5OjI1OjU1IDEwLjIxMS4xNjQuMTA5IFsgMjk5My40NDcyNDZdICA/IF9f
cGZ4X3dvcmtlcl90aHJlYWQrMHgxMC8weDEwDQoyMDI0LTA2LTA0VDExOjI1OjU1KzAyOjAwCUp1
biAgNCAwOToyNTo1NSAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuNDUyNDAyXSAga3RocmVhZCsweGU4
LzB4MTIwDQoyMDI0LTA2LTA0VDExOjI1OjU1KzAyOjAwCUp1biAgNCAwOToyNTo1NSAxMC4yMTEu
MTY0LjEwOSBbIDI5OTMuNDU2MzExXSAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMA0KMjAyNC0w
Ni0wNFQxMToyNTo1NSswMjowMAlKdW4gIDQgMDk6MjU6NTUgMTAuMjExLjE2NC4xMDkgWyAyOTkz
LjQ2MDg3Nl0gIHJldF9mcm9tX2ZvcmsrMHgzNC8weDUwDQoyMDI0LTA2LTA0VDExOjI1OjU1KzAy
OjAwCUp1biAgNCAwOToyNTo1NSAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuNDY1MjcxXSAgPyBfX3Bm
eF9rdGhyZWFkKzB4MTAvMHgxMA0KMjAyNC0wNi0wNFQxMToyNTo1NSswMjowMAlKdW4gIDQgMDk6
MjU6NTUgMTAuMjExLjE2NC4xMDkgWyAyOTkzLjQ2OTg0OV0gIHJldF9mcm9tX2ZvcmtfYXNtKzB4
MWIvMHgzMA0KMjAyNC0wNi0wNFQxMToyNTo1NSswMjowMAlKdW4gIDQgMDk6MjU6NTUgMTAuMjEx
LjE2NC4xMDkgWyAyOTkzLjQ3NDYzNl0gIDwvVEFTSz4NCjIwMjQtMDYtMDRUMTE6MjU6NTUrMDI6
MDAJSnVuICA0IDA5OjI1OjU1IDEwLjIxMS4xNjQuMTA5IFsgMjk5My40Nzc0NzddIE1vZHVsZXMg
bGlua2VkIGluOiBudm1lX3JkbWEgbnZtZV9mYWJyaWNzIHZmaW9fcGNpIHZmaW9fcGNpX2NvcmUg
dmZpb19pb21tdV90eXBlMSB2ZmlvIGlvbW11ZmQgcmRtYV91Y20gcmRtYV9jbSBpd19jbSBpYl91
bWFkIGliX2NtIHVzZG1fZHJ2KE9FKSBpbnRlbF9xYXQoT0UpIHJma2lsbCB1aW8gc3VucnBjIGJp
bmZtdF9taXNjIGludGVsX3JhcGxfbXNyIGludGVsX3JhcGxfY29tbW9uIHNiX2VkYWMgeDg2X3Br
Z190ZW1wX3RoZXJtYWwgaW50ZWxfcG93ZXJjbGFtcCBjb3JldGVtcCBrdm1faW50ZWwgbWx4NV9p
YiBrdm0gaXJxYnlwYXNzIGNyY3QxMGRpZl9wY2xtdWwgY3JjMzJfcGNsbXVsIGNyYzMyY19pbnRl
bCBwb2x5dmFsX2NsbXVsbmkgcG9seXZhbF9nZW5lcmljIGdoYXNoX2NsbXVsbmlfaW50ZWwgc2hh
NTEyX3Nzc2UzIHNoYTI1Nl9zc3NlMyBzaGExX3Nzc2UzIGk0MGUgaXBtaV9zaSByYXBsIGlUQ09f
d2R0IGliX3V2ZXJicyBtYWNzZWMgcGt0Y2R2ZCBtZWlfbWUgaXBtaV9kZXZpbnRmIGludGVsX2Nz
dGF0ZSBpbnRlbF9wbWNfYnh0IGlUQ09fdmVuZG9yX3N1cHBvcnQgbGlic2FzIGkyY19pODAxIGli
X2NvcmUgbWVpIG1nYWcyMDAgaW50ZWxfdW5jb3JlIGlwbWlfbXNnaGFuZGxlciBkYXhfcG1lbSBw
Y3Nwa3Igc2NzaV90cmFuc3BvcnRfc2FzIGlvYXRkbWEgbHBjX2ljaCBpMmNfc21idXMgd21pIGpv
eWRldiBpcDZfdGFibGVzIGlwX3RhYmxlcyBmdXNlIHpyYW0gYnBmX3ByZWxvYWQgbG9vcCBvdmVy
bGF5IHNxdWFzaGZzIG5ldGNvbnNvbGUgbmRfcG1lbSBuZF9idHQgbmRfZTgyMCBsaWJudmRpbW0g
dmlydGlvX2JsayB2aXJ0aW9fbmV0IG5ldF9mYWlsb3ZlciBmYWlsb3ZlciB1YXMgdXNiX3N0b3Jh
Z2UgbnZtZSBudm1lX2NvcmUgbnZtZV9hdXRoIG1seDVfY29yZSBtbHhmdyBwc2FtcGxlIHRscyBw
Y2lfaHlwZXJ2X2ludGYgaWNlKE9FKSBnbnNzIGl4Z2JlIG1kaW8gaWdiIGkyY19hbGdvX2JpdCBk
Y2EgW2xhc3QNCjIwMjQtMDYtMDRUMTE6MjU6NTUrMDI6MDAJSnVuICA0IDA5OjI1OjU1IDEwLjIx
MS4xNjQuMTA5IHVubG9hZGVkOiBudm1lX2ZhYnJpY3NdDQoyMDI0LTA2LTA0VDExOjI1OjU1KzAy
OjAwCUp1biAgNCAwOToyNTo1NSAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuNTgwNjA5XSBDUjI6IGZm
ZmZmZmZmYWJlMjA2NjANCjIwMjQtMDYtMDRUMTE6MjU6NTUrMDI6MDAJSnVuICA0IDA5OjI1OjU1
IDEwLjIxMS4xNjQuMTA5IFsgMjk5My41ODQ3ODNdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAw
MDAwMDAgXS0tLQ0KMjAyNC0wNi0wNFQxMToyNTo1NSswMjowMAlKdW4gIDQgMDk6MjU6NTUgMTAu
MjExLjE2NC4xMDkgWyAyOTkzLjY3NjU5N10gUklQOiAwMDEwOm5hdGl2ZV9xdWV1ZWRfc3Bpbl9s
b2NrX3Nsb3dwYXRoKzB4MjdmLzB4MmQwDQoyMDI0LTA2LTA0VDExOjI1OjU1KzAyOjAwCUp1biAg
NCAwOToyNTo1NSAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuNjgzOTY5XSBDb2RlOiA0MSA4OSBkNiA0
NCAwZiBiNyBlOCA0MSA4MyBlZSAwMSA0OSBjMSBlNSAwNSA0ZCA2MyBmNiA0OSA4MSBjNSAwMCA1
NiAwMyAwMCA0OSA4MSBmZSAwMCAyMCAwMCAwMCA3MyA0NSA0ZSAwMyAyYyBmNSBhMCAzYyBjMCBh
YSA8NDk+IDg5IDZkIDAwIDhiIDQ1IDA4IDg1IGMwIDc1IDA5IGYzIDkwIDhiIDQ1IDA4IDg1IGMw
IDc0IGY3IDQ4IDhiDQoyMDI0LTA2LTA0VDExOjI1OjU1KzAyOjAwCUp1biAgNCAwOToyNTo1NSAx
MC4yMTEuMTY0LjEwOSBbIDI5OTMuNzA1ODczXSBSU1A6IDAwMTg6ZmZmZmMwNDJjN2ViYmQ0OCBF
RkxBR1M6IDAwMDEwMDg2DQoyMDI0LTA2LTA0VDExOjI1OjU1KzAyOjAwCUp1biAgNCAwOToyNTo1
NSAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuNzEyMTY3XSBSQVg6IDAwMDAwMDAwMDAwMDAwMDMgUkJY
OiBmZmZmOWU4OWZhN2E5ZTAwIFJDWDogMDAwMDAwMDAwMDAwMDAxMA0KMjAyNC0wNi0wNFQxMToy
NTo1NSswMjowMAlKdW4gIDQgMDk6MjU6NTUgMTAuMjExLjE2NC4xMDkgWyAyOTkzLjcyMDYxNF0g
UkRYOiAwMDAwMDAwMDAwMDAxMDFmIFJTSTogMDAwMDAwMDA0MDdmYTljOCBSREk6IGZmZmY5ZTg5
ZmE3YTllMDANCjIwMjQtMDYtMDRUMTE6MjU6NTUrMDI6MDAJSnVuICA0IDA5OjI1OjU1IDEwLjIx
MS4xNjQuMTA5IFsgMjk5My43MjkwNDVdIFJCUDogZmZmZjllODlmYmUzNTYwMCBSMDg6IDJjNmY2
YzZlNjIyYzYxNjggUjA5OiBmZmZmOWU4OWZhNThkNjQwDQoyMDI0LTA2LTA0VDExOjI1OjU1KzAy
OjAwCUp1biAgNCAwOToyNTo1NSAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuNzM3NDcwXSBSMTA6IDAw
MDAwMDAwMDAwMDAwMGYgUjExOiBmZWZlZmVmZWZlZmVmZWZmIFIxMjogMDAwMDAwMDAwMDNjMDAw
MA0KMjAyNC0wNi0wNFQxMToyNTo1NSswMjowMAlKdW4gIDQgMDk6MjU6NTUgMTAuMjExLjE2NC4x
MDkgWyAyOTkzLjc0NTg2OV0gUjEzOiBmZmZmZmZmZmFiZTIwNjYwIFIxNDogMDAwMDAwMDAwMDAw
MTAxZSBSMTU6IGZmZmY5ZTg5ZmE3YTllMDANCjIwMjQtMDYtMDRUMTE6MjU6NTUrMDI6MDAJSnVu
ICA0IDA5OjI1OjU1IDEwLjIxMS4xNjQuMTA5IFsgMjk5My43NTQyOTBdIEZTOiAgMDAwMDAwMDAw
MDAwMDAwMCgwMDAwKSBHUzpmZmZmOWU4OWZiZTAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAw
MDAwMDANCjIwMjQtMDYtMDRUMTE6MjU6NTUrMDI6MDAJSnVuICA0IDA5OjI1OjU1IDEwLjIxMS4x
NjQuMTA5IFsgMjk5My43NjM3ODZdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAw
MDAwMDAwODAwNTAwMzMNCjIwMjQtMDYtMDRUMTE6MjU6NTUrMDI6MDAJSnVuICA0IDA5OjI1OjU1
IDEwLjIxMS4xNjQuMTA5IFsgMjk5My43NzA2NThdIENSMjogZmZmZmZmZmZhYmUyMDY2MCBDUjM6
IDAwMDAwMDA3ZTM0MjgwMDIgQ1I0OiAwMDAwMDAwMDAwMTcwNmYwDQoyMDI0LTA2LTA0VDExOjI1
OjU1KzAyOjAwCUp1biAgNCAwOToyNTo1NSAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuNzc5MDgwXSBL
ZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogRmF0YWwgZXhjZXB0aW9uDQoyMDI0LTA2LTA0VDEx
OjI1OjU1KzAyOjAwCUp1biAgNCAwOToyNTo1NSAxMC4yMTEuMTY0LjEwOSBbIDI5OTMuNzg1NDMz
XSBLZXJuZWwgT2Zmc2V0OiAweDI4MDAwMDAwIGZyb20gMHhmZmZmZmZmZjgxMDAwMDAwIChyZWxv
Y2F0aW9uIHJhbmdlOiAweGZmZmZmZmZmODAwMDAwMDAtMHhmZmZmZmZmZmJmZmZmZmZmKQ0KMjAy
NC0wNi0wNFQxMToyNTo1NSswMjowMAlKdW4gIDQgMDk6MjU6NTUgMTAuMjExLjE2NC4xMDkgWyAy
OTkzLjg0MjE1NV0gcHN0b3JlOiBiYWNrZW5kIChlcnN0KSB3cml0aW5nIGVycm9yICgtMjgpDQoy
MDI0LTA2LTA0VDExOjI1OjU1KzAyOjAwCUp1biAgNCAwOToyNTo1NSAxMC4yMTEuMTY0LjEwOSBb
IDI5OTMuODQ4MjczXSBSZWJvb3RpbmcgaW4gNSBzZWNvbmRzLi4NCg==

--_004_PH0PR11MB5159A3CA682964B9B77A06A9E6F82PH0PR11MB5159namp_--

