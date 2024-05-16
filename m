Return-Path: <linux-rdma+bounces-2520-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 843028C7D72
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 21:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBCD2840D3
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 19:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA0D156F29;
	Thu, 16 May 2024 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aj3A12fo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A27D271
	for <linux-rdma@vger.kernel.org>; Thu, 16 May 2024 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715888892; cv=fail; b=jd8WpatRgvrhB077ELrvJ50TskSrZtAQTIBTXLR0UNP2l757cYWxV7OcKuWxdWBQVxVEeyVZKDV7Nr6wSW0W+lwcSiLedkUx4zSj1+nHrI5+TA3s+VS7YTvPic6hSMQHNqsz+oli6SHuI6lQPS0xj6u9FFLRMWuYJC6KIAOY4wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715888892; c=relaxed/simple;
	bh=qOHVNe/1UuSSSDqGilAIXVLgAv5oR0Zy5sIDCBgbqQ8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=om+47i4BOXBHrLkR5jthLEMxe9DpdlUkbw2/63FD+6ACcCKAVTiPnZWykxhzFBanEpCrwNPgrx6W/EOdRNf7PZciVolqGwZOwLgEYK/KgOAD/vC/HQdrKmH5QnEtQaC1NNqDJQjWFQ5p/U7nBr7bZoXT1f0g0FhODgvEpz7GsO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aj3A12fo; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715888891; x=1747424891;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=qOHVNe/1UuSSSDqGilAIXVLgAv5oR0Zy5sIDCBgbqQ8=;
  b=aj3A12fo4bVzIJFbVNWc8J9pwQ/faNLuZeX1XCH4/SD7/qwFGrpVdzdi
   Q1L77ozF3J0/4LWPBGIFV/vs7cmSGcgu8AOSvd0gyIdQwH9MoVa65uyEx
   jOtbbuE2+ZBWfq4gdjClVEkusshBOkRVi/RhGdiT8PVrBEKMJBBkjJVyz
   0PBSrWFxunPqeiyNLNW36mY1WZH1nyMiVnGR6OR7eB1igzEYpwv0AvrIc
   sCXPn3i7V5eYRd+bnzF8Olpsl+w9P2OQCi6QGl4kfm2eamQyLYfWWa39U
   AXpnNyJNzOJSGHm52BDbHiElw+MUZJjqX4LfstPZ8dit251cqS4GT0JeE
   Q==;
X-CSE-ConnectionGUID: BIpor2hmSju8EW7EIpFtSQ==
X-CSE-MsgGUID: qnuD56h6QcWlgSPK/1gVSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12223804"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="12223804"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 12:48:10 -0700
X-CSE-ConnectionGUID: D87JEow3RsOD1pIUMCbF2Q==
X-CSE-MsgGUID: Gj6ZHXC1SQ+458WCeokmJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="36444658"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 12:48:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 12:48:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 16 May 2024 12:48:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 12:48:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 12:48:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EA0Fo703/LHM7km/LFf+fpMQY19kRQmsTQ8qfvXlFP6ZLcmIRYthDwrhAiRi7GPvhsQbpXgK+VMbBY5D+6riCGxIWWdKzOpDhnxPPOLh4rPREXt2CbrutZVY4uvIhTCXVmSOnsurL+RjcHUviNJkLxkvLlP9wf/8k95vATu6Rm21iGmKCxU6FLPOHbPyjpk+mN0H2VvfVir0T08DLalKrbdqpH3QkCpn7wVbe8v80mMdy9OLhP95BlfGBJeSzx3UltgShnc7hMyCbPQtzvJLLdg6wEcnPrjPRql6RVBG5AAoTJBjWcQlfZZHtiS2TsC8uZnz+RUek+NoNPtN8mcTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9z2cAbDl0KSmIOOd5G4YjBSITEmLQ7eBDMq0/lkbFQ=;
 b=Yp0ws9HnoHHOctsR/b1WE3qCHNoOLsGZBtAoNDzlV6PX26rYXJuzyix0hUeDQrmzL1zZPlYINExjadDR761pbyq6rZRtEzK0Tg2NsbV8JzRwhOhgWG6kEEGdw3MbsYBks4/XNf4zt4+gFrvqcE2CYtSaF8xy1AAshhmRO1z2AkAFErfDBcLvLtR/huRujdQJd5QUrmMhFjf9e1D3HsFEugrLMQkcD7XLKvNzAAuxON5k30V/jeKkuRKmYXv4GNvvhIpu1Uttsbp0YUGRE8smziWTeiOKEyzo8VInmXgP+u2LUrayhl2/Fuce6XOB4LuRALf9r0zmbM0Vhl4t05asdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20)
 by PH7PR11MB8528.namprd11.prod.outlook.com (2603:10b6:510:2fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 19:48:06 +0000
Received: from SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::6773:908e:651b:9530]) by SA1PR11MB6895.namprd11.prod.outlook.com
 ([fe80::6773:908e:651b:9530%5]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 19:48:06 +0000
From: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "kheib@redhat.com" <kheib@redhat.com>, "edwards@nvidia.com"
	<edwards@nvidia.com>
Subject: [bug-report]rdma-core v51.0 build error with Rocky Linux 8.8 
Thread-Topic: [bug-report]rdma-core v51.0 build error with Rocky Linux 8.8 
Thread-Index: Adqnx6BozKwzKve5Tt+XbFDGYf6BwA==
Date: Thu, 16 May 2024 19:48:06 +0000
Message-ID: <SA1PR11MB68950882F65EE948009BF33986ED2@SA1PR11MB6895.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6895:EE_|PH7PR11MB8528:EE_
x-ms-office365-filtering-correlation-id: ad01caa2-b53e-4a3e-5194-08dc75e11b3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Vrj7Vva+ZuZJlsy8osBv/FM9EVj/N/kU78xCvBFYnaHXuwtTHdzzGA3bQCHQ?=
 =?us-ascii?Q?wyzsJ27Q8BQxfiSD+aKUB/QASAubGuG4gKHpwffgNnr2y/ibZU5DMlHmiZKq?=
 =?us-ascii?Q?GKhc4fCl4ifOPw2MVjQbzjxwxMU6XiHvZfDPmxsY1RctYKRZkdcBP+X/wE8s?=
 =?us-ascii?Q?d31nF16L2oY81rzlDRrtmdK80j+m6IYMoEH4lO3dmh8gVpPS7VP5dl4LxwEH?=
 =?us-ascii?Q?kzG48VS61RMGfADQhw4FUrMdaOV8vwNKxDZP/E8Dh7cUhqSYbUT1cAjIT/gB?=
 =?us-ascii?Q?7ZcVQK5pSGqrg7M6/L7z0QUh5V5L5ez0CQjgP9JsV8Bss25EzBlfLRdaaRlA?=
 =?us-ascii?Q?TBVht/xlmSxidxRF8abIC22+irWeDWzaX0yu41IOq+X67hlhG8gcZDp9Fzzp?=
 =?us-ascii?Q?/Co890zwlOuRpW4aP0/2O2TJEK1dodHjJSsNRvcz0bbhb30Z9L8zx8PvEdyH?=
 =?us-ascii?Q?jP987pmVLYGcIT33IWObucukpSKEoF8nmOGNUafjoKy1nyuFCpANZbNWIqAo?=
 =?us-ascii?Q?J4zPtlw8jtsNPaDdO4ZssFNTuXl3nR09yaSLixV5s9sMdi1NQ38/dzyIsF4G?=
 =?us-ascii?Q?ss6dXQCkbxFtx74XpjSI3YohGMoGrNQ7Q8hq/1ofhjOwjHAi8o8bSj8xRTJ5?=
 =?us-ascii?Q?itPfmi2kycpHhuIDRxPvTPBXKknSXvOWvLxLX858aQB011dv2alpld1VEHTW?=
 =?us-ascii?Q?TFJaeJfoOzzZFEaYlp7H1qqkuJj1wVJOVgrYBnYUodBGUaTd30xCyyv1ZQe0?=
 =?us-ascii?Q?NTdGeTASX3BWssd7cX6n11Y7vAxZ0KdFAWq/fa3cgfbQruOFr9AN4cGbQdXA?=
 =?us-ascii?Q?N3VrMx7hDkK2JxgHxXHZ6vXSfpkZ4hMrxB2tHso9XIhH86HYGdlEzldJkitk?=
 =?us-ascii?Q?Gj+WBbSA6bhtTW6eMpbodtMR4MRfoewq702AkSg/pKSbXXbfsuUCZwXHQbhn?=
 =?us-ascii?Q?uLk04xAjp2gsSSFMZfOTyVZe50TdQYHP9L56r8i5rVreYb5nbdHVFvaB/v5R?=
 =?us-ascii?Q?efk+bi+5D/pOTMWADT4q/ewmW5r1FljEqvn7P3uPp2HSCQK+ZD81FFGdVnyJ?=
 =?us-ascii?Q?cMkTE7KaZrWNE5KWvv8z4paFPdP2Hk68LM6wCEGJ6HRRMHsBIjE20i5lFG75?=
 =?us-ascii?Q?KuaSLFng1B70+Wn6xZDhuNAFu2I0XQrf2w31faSGeqg7ljq8dIIt56yr/jfK?=
 =?us-ascii?Q?W9nbsQtwV+TNsUmOEDr+4wNGGjSGaRrmboXWiTVCO5GF8bP8Lz1I+MuIE4q+?=
 =?us-ascii?Q?6otJS77JTEKDn6yi17huCGYYqCgSGxalit1kJvWCLQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ggVyGfhRQTvDJbs0Rksnbr2MGMFWlOETSvHbCg969Amj++RGww4fV6lIhOfw?=
 =?us-ascii?Q?2ypb6mH85ibP2gq28bAzeOTKfIIzGcjzDFUtdXAfmY+6Y8ctbOSntK5KJUWN?=
 =?us-ascii?Q?Zytc372NLCRNtqLpowl6UH3ive3IPiiQj+cB3KFDo4p/LZBGjE2OV4/Ff3e+?=
 =?us-ascii?Q?GiX8CgasAa6w+iLdN8by3fd/hgYXcS0p+UtwTJTT3WQXvlp0YZpDMjeF8lJn?=
 =?us-ascii?Q?7zWLx4nDbn4suy7s3q9QkjFcZZ2KrApYVC3UUzTd5/n9dRVZMdmP7r+X04Bx?=
 =?us-ascii?Q?JzCn8IR+LmDYTGPXdsaWifE/6K4hXYTJ26CAkM93fhilbpHLobtNgWUIn092?=
 =?us-ascii?Q?g0Q7IFLPx0fNmBk1QBtR+xwk1W+51U8F4ly78FMKgB1tVtcPlqQGk5QkzZ7k?=
 =?us-ascii?Q?oZKNINXJMZz7hT3h+BTNKQLd9TQ2PM1EjAIawg82pkNsgqRD5WcdTJh41YXM?=
 =?us-ascii?Q?hwmsPW2NF8YaeKY7e41C4g7w8pg5G6mhA2m8x+Di2v51BsRagXlL73Avdi+a?=
 =?us-ascii?Q?KzKwjKt5U8xpOXrCQ5tVHnkS0eXMeV5Fx+lHGRJXznpno6dTXWbHm7RgMyI8?=
 =?us-ascii?Q?dDpK2iIDe8T58vVdavF6D16zbEFo9k5uP53GSE6PVeFiiMGrwCiqt645v9eB?=
 =?us-ascii?Q?X3VSu/dYa17VtJBdXAFZ6KCjwED2D+GwpC4baKDbSBqCVODuxQ0lf0wzu5BG?=
 =?us-ascii?Q?PYzCzPMK/14W5ip6mI/XeRYedra2Hz6lLUhrXL2w5YDrf4lRIMMHq2zg+k2w?=
 =?us-ascii?Q?bvTDFANeix3XjXwbeLHtzVHFD+0S83Rv8uRQaYa6PVtFf/tPq35rL8gdWwh+?=
 =?us-ascii?Q?IVxbatmoNZYFyanpsJRTrVfpRoMflG35JkPkNnRbny4fvYc2rQIUL0147aYR?=
 =?us-ascii?Q?tU5L1WzjPU+XtAIGQ0z74WYBL9QW6IDlvf/PsVCgVR5bBurXjA4RIQ5RH6DO?=
 =?us-ascii?Q?LwaS5PRBnV8RybP5sbfCsIA6Xysi8R+O2lIIe3xNvTXvGK9E8qnt0KvfuLHW?=
 =?us-ascii?Q?mCiH8jNfQ/plrroDXrSfRo3lQqF9d4sDI2I3rRR+fNzwJenKrx9z8CQIzO8j?=
 =?us-ascii?Q?B7GCCQn09iESfsQU3gUWHp54hi7yBWlRnrsLG1LB8n8HQwRzhq/VTRoklVXv?=
 =?us-ascii?Q?R7orY52sK/u6GI2OKehgvFp9mgV95ekxm8y4+JCqo08GGiGw9UCEPxVe1Gv/?=
 =?us-ascii?Q?M02zdgbVOkWbTYFbSbkMPL3VRQeuXJQBzKbpLUukhMIdnScPnatddU8bMoGm?=
 =?us-ascii?Q?vEAstYcaAQ1MahniGYuwgXBvW5SQj0oxyMKgxErp/uEUpV5Mv8pirdxz2SuA?=
 =?us-ascii?Q?daGrYHirse6+82sPvRxHOZKAaLWkCQTwjohOWoEeJKd+Pk5VYvjlADUSdN8o?=
 =?us-ascii?Q?JkCIsxngreI8CU4ElUoxVnVMMhENeXn4N8ggSlrNz+jirZQFUQGH+iNfdIif?=
 =?us-ascii?Q?iRploLiSpxrxCdVQes38l7yVhWv06NEacAmC40fUKnB6PNDlwd6cCHZckHEH?=
 =?us-ascii?Q?eDHdk8amlmnwgGq1r1mvdGuSnH5wYIqVug+N35RLLATGsb0twnr/jflDQ5h1?=
 =?us-ascii?Q?IQfjTT0CFxV8iZ5E+g+kPyos3kRlK0nrbQ64B3qI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad01caa2-b53e-4a3e-5194-08dc75e11b3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 19:48:06.4161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTiIZyXSXe1fz5mqQKdrrgz32S7OuEr4xRcFyXP5l31YsYYsjqQd+GWrvpl7w87dyYz+3vuLtxlP+cZ2XXpm215wHlUtZC3s2pTOMSYw3O4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8528
X-OriginatorOrg: intel.com

Seen on Rocky Linux 8.8 with rdma-core v51.0.=20

I suspect 8.9 shows the same issue and I know the RC for RHEL 8.10 does as =
well.

The cmake version is 3.20.2.

The linux kernel version and hardware is not relevant since this is a cmake=
/build issue.

The hardware is also not relevant.

To reproduce:
1. download an untar the v51.0 tar ball to ~
cd ~
wget  https://github.com/linux-rdma/rdma-core/releases/download/v51.0/rdma-=
core-51.0.tar.gz
tar -zxvf tar -zxvf rdma-core-51.0.tar.gz
2. create the following directories
 mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS,OTHER}
3. copy the spec file=20
cp cp rdma-core-51.0/redhat/rdma-core.spec ~/rpmbuild/SPECS
4. Create SOURCES
tar -zcvf ~/rpmbuild/SOURCES/rdma-core-51.0.tar.gz rdma-core-51.0
5. load build dependencies
ensure AppStream, BaseOS, PowerTools repos are accessible
sudo dnf install -y dnf-plugins-core rpm-build
cd ~/rpmbuild/SPECS
sudo dnf builddep -y rdma-core.spec
6. Load an additional pythion interpreter
sudo dnf install python39
6. do the build
rpmbuild  -ba rdma-core.spec

The build gets the following errors:
error: File not found: /home/mmarcini/rpmbuild/BUILDROOT/rdma-core-51.0-1.e=
l8.x86_64/usr/lib64/python3.6/site-packages/pyverbs
error: File not found: /home/mmarcini/rpmbuild/BUILDROOT/rdma-core-51.0-1.e=
l8.x86_64/usr/share/doc/rdma-core/tests/*.py


RPM build errors:
    File not found: /home/mmarcini/rpmbuild/BUILDROOT/rdma-core-51.0-1.el8.=
x86_64/usr/lib64/python3.6/site-packages/pyverbs
    File not found: /home/mmarcini/rpmbuild/BUILDROOT/rdma-core-51.0-1.el8.=
x86_64/usr/share/doc/rdma-core/tests/*.py

Earlier in the build this is seen:
-- Found Python: /usr/bin/python3.9 (found version "3.9.16") found componen=
ts: Interpreter
-- Could NOT find cython (missing: CYTHON_EXECUTABLE CYTHON_VERSION_STRING)

The issue appears to have been introduced by:
1462a8737 build: Fix cmake warning

cmake appears to find the 3.9 python despite having:
-DPYTHON_EXECUTABLE:PATH=3D%{__python3}

The issue will impact 8.10 because valgrind-deve/valgrind will bring in pyt=
hon3.11 100% of the time.

Mike

