Return-Path: <linux-rdma+bounces-3547-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6493F91AC49
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 18:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84C6EB217D4
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 16:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957CE199252;
	Thu, 27 Jun 2024 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNWKs6cc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346731991C3
	for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504641; cv=fail; b=BW75jrY/0wr8mHLEvrjjqszf0jI97498KgzHF9n8IqyWd6eykP98Jq1MmzslEqXbsCPmeCjwrEhbZWd7PYffzjlKKN2C23Py54YvijcXMtFhtrs2+35mBJ6+fJ8h7bPSwPjUDclO4ytCtG6og7MJDYE/2qsOhvSoqybC0B/zggU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504641; c=relaxed/simple;
	bh=pC+jRMRFlZe7/tu+MFR7/sfDVOiEzjNph7fBZKiiddw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u2cblp23VA6idtmIUfGUHTwddLPmFRSAh2Gqo+Ak46fd6VRz2QxZLUBNrv8HQdtEU6n/7ThsgilvJ3vD7l7SoG2rCw/aoBupYd7ZE6DVr6Oy0TZTDmf17mssfT3ZNPgGEPKrOnYe+M/246Un9IyjCZ7SKz3r+0FixeL2X2BOW/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNWKs6cc; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719504640; x=1751040640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pC+jRMRFlZe7/tu+MFR7/sfDVOiEzjNph7fBZKiiddw=;
  b=XNWKs6ccMoJTH2Wbd8+GUMjUd0CJdVH3Tuq3A+B/KuxB52CSA02Q81x4
   mjOwkbDa4s/TRw9X8sUXBoMNgKDzotfOUz+PpqpC//0cTZ+hyupE/NHHs
   CyfALmDcSHB5h/GPWjYgXQfRfaUBnvs7mkmjyXahh282HLq1LrkRj6IMW
   Ci+95vAkTDvb7lZLfjYa0tDQVa41TIzaUJ9OalW7U8SZFfam/Xsb5LoA3
   gdRIFoh4Apn7SXKb3cfjmX1hdOArIQeBdorWnXbWHzsfTLvDQncSPI21K
   bByVBRao/AjBOeJ2/j1mNvltiCJ69F4l6DlT/ILCCaVqku81QEwAC/eQH
   w==;
X-CSE-ConnectionGUID: EZM4YbVVSiqeda4sUSyC4g==
X-CSE-MsgGUID: +Uc6cD9NRbaw69NzSsZPrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16484642"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16484642"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 09:10:04 -0700
X-CSE-ConnectionGUID: WWpmUrn6RB2YFJJtWr/z8w==
X-CSE-MsgGUID: q1/gcJ9XRLm+Ept4/x9Yzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="75626750"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 09:10:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 09:10:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 09:10:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 09:10:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcPRBnxeUaSMVK/oQCxqlqoKugxeVvi3qh5c/hfCXLyOWio2P5o5jM7C9NI+hHBn3n78HN3PjiFWbdb4DRqMFeX2L4lQGu6F00j2tx9AHY+DRLF3P5hy69E9BZmUSsSgS4iqJ8Itw1QgJrgdmVckpLGtvEm3VyXEpSQKcBYKzkaBWjd1a4tmc2JmOTnRhyME7eKqGaSHYOo1kxyVA2+xZAp8xY8xeC8CmE8jgB0RX4s3wAAOZ0Hyd73KNnbR2brNbxIqb5eGXFNvNvVDntF+UmEJ4Ot0u7EoYIPMN47WV/BbYe1nEyO2gJsD5cME6uuCrMaEst3Wb6+kJGv2mEaEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6v+dCbPF920U45E23K/IoK9xmnisWeEWQXRRROo9vHw=;
 b=QDvZCz/0ITxXYD+OozY7gPAUS1qQI+CpeGaSKLEjoxUzEDCqMeJbKGjvuEdMm/34hCxhp/+TWYZ4rHZQfDWftaipVtynN+TGD3N1j7NFx4mMrRKoteYxcYuscecfybeL9nNOke94vpTcvMcMDLEwoxy7syzR1Ica5OmlNBISWNz2c8rlSiXJG3F94GuNGtnMknddvQq6Sch3GdWMjRpPcYNDF52tf5U29I5ssTwDjgs6O9ctPU7qL5X08ySeXzpUjD9t0dXfJWnJOvL74Vi02hSPJUSYhD5+kvKEN3UvkP0913xEC8Th1A9HjXNGbVq2LUkD+eUy124vXJG9hcXL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17)
 by MW4PR11MB6692.namprd11.prod.outlook.com (2603:10b6:303:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 16:09:58 +0000
Received: from IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::763d:a756:a0e4:2ff7]) by IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::763d:a756:a0e4:2ff7%6]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 16:09:57 +0000
From: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To: "Saleem, Shiraz" <shiraz.saleem@intel.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Saleem,
 Shiraz" <shiraz.saleem@intel.com>
Subject: RE: [PATCH] MAINTAINERS: Update Maintainers for irdma driver
Thread-Topic: [PATCH] MAINTAINERS: Update Maintainers for irdma driver
Thread-Index: AQHayKo2/4EMCyfhGEmf8ABHIYsJfbHbxuOw
Date: Thu, 27 Jun 2024 16:09:57 +0000
Message-ID: <IA1PR11MB772758F25E421780A84D45D8CBD72@IA1PR11MB7727.namprd11.prod.outlook.com>
References: <20240627155304.219-1-shiraz.saleem@intel.com>
In-Reply-To: <20240627155304.219-1-shiraz.saleem@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7727:EE_|MW4PR11MB6692:EE_
x-ms-office365-filtering-correlation-id: 931e2bad-6c43-4494-850c-08dc96c3972a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?A3B8OMFC462zxzFEEm+dC+FKx/7TQBJKQUxLfyIHsptSlbzz2mEhTRkXa/C/?=
 =?us-ascii?Q?hXTpLhvpWDXQANA4C0g+9YIiJVAOsHoWBWJ50abtIot+6QG6VXSl5Q85VV9q?=
 =?us-ascii?Q?H0Z7UT51rTBGmLwICDe1EBQ2pXRfa/T1UDWP3YeV0rqwituxibhSUnrsXDXE?=
 =?us-ascii?Q?vvI1HfxGRdKD1ost4cUUA4djcmBzNKAVFOIlfGJV3Rtlis3YmkzNBTiFFlBh?=
 =?us-ascii?Q?R4dVn9/YwSf35GdXTk6vntO4z72q4SWZ2taknFNlTP1QlJaaw/8Vb3NgW+ZG?=
 =?us-ascii?Q?qkRLeGHewGIF/JXMyQYyQ0zIZFpshaV3ryZtuiF3J9MahdXzXrqwaH7PZV78?=
 =?us-ascii?Q?HFl8HmKNfZfGVtQuoNFyHWPgoBJP7xbf2Z4BBedxQRVB0V8YBJYhXp4LjjwW?=
 =?us-ascii?Q?9mKlxDr0TVY/VBwM29eTxrjBqGu7ZDQ5i/gonnql1Ih0OOz4qjEMrtosRzZF?=
 =?us-ascii?Q?B6pyK//fSZgDIrUBAha//dy7hcQqssNEO5OAfQ4BEx/bjvYoDQjZgYrl1te2?=
 =?us-ascii?Q?OeWupG/+ZKdNqi4YjsKNk/7hqMI6dTiwY+u8PwgB0V9d+/ZYyIVBH4ri3Puz?=
 =?us-ascii?Q?LzOJJoH8a+rlRsSCOyCwzwHmA7a+WtV8DhAShrlGdhPkvffRf8gn/6ODHIZo?=
 =?us-ascii?Q?nmuikPH661rTw5cG0LHBwmEgtFk5XZqryV+DYJJyuYRj9vyd/1c+sqtWf0UU?=
 =?us-ascii?Q?xSB4EmSLfeu6Jg17ZZ/NkoTlJPseOEeEg+MscbELGxLJUkdxeSWGWUvMwYDC?=
 =?us-ascii?Q?bDurMDJC7KZyj2VdwVJsTsLKr9DkP6vMySG6VAW1CnINNU9/r3HJ17LtcR8n?=
 =?us-ascii?Q?mPQpKdSPxnHxtR7KNOoaMVw6B1+GikS2zUw3pLhr61zfBjdCel7Y85hiZRiz?=
 =?us-ascii?Q?7TxXUoQwbHOk1sT2ISb6T2JvyNdGdlvqr/1iaU7J9d2uyL70IYttiell9MRv?=
 =?us-ascii?Q?XEtrtC2L//b2n5FwuP7cnyiy3aZCye6iOmX61IqqeYcZcsEku4lNJLOHME/z?=
 =?us-ascii?Q?NC5IJHqE9KBc4SmOz3/Syc0SWFF9srFrohJyCF/n1wsdCCpAi8IcJoyCJCfu?=
 =?us-ascii?Q?kNj7/S51J66YMTM0AiPXST1U774SgUw9dto/men2x+MO0mp8a1SZ3QPnRAUk?=
 =?us-ascii?Q?snlXc72A1OQqjQ3PQEeR3PM1Mty2jrp4tzp6uOASF3CssHOAgJYxMJkAs6ce?=
 =?us-ascii?Q?IjSz4BLUaBQJkOFFb5crjCIk9Twa4YYCBpp81wXGafG2XEq7jGDrgZTVymMR?=
 =?us-ascii?Q?siw8DT8Fzkceantd56JFnbg182PggfCgTlDbVfO5iOWulASTHcEFVpDydaqI?=
 =?us-ascii?Q?Bc9Yx4nz8Bdcz3cAiy6B569IoeXJ2W5tt1QMAkbL95xpGyCPtTHrnynpZJ2c?=
 =?us-ascii?Q?1S6uipcwOqWnJCfeP8aHCp6S2BN//0aczV+9cvls+7XoOxEeDQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NUgAl/atmpV16omqZgUTtFDP+fBzd8ntKe21PnUafZyMeKuWK17LD2sPdBYD?=
 =?us-ascii?Q?ZXJvZkbuHN+tDL3c99lHzkMKFnFsph7G8fqWllyWFzfAEpNkammzlTbMbpgf?=
 =?us-ascii?Q?jf7bzfKntLRJ7upwNtnxXdDAIqpMeN+HwMMFS3MUEPdWpTsqPn1ZqYxg/zQ6?=
 =?us-ascii?Q?Lfm8e5PPeNhBNgrqUhkdP/spcVHFNEx2OoWFF9f0pgo+kiuCX16zLMGbiAtY?=
 =?us-ascii?Q?bH+ijk7xnQ2rxIUWuiNWV/656N7ztX0Qux4fg4xyN8/IiEqxCpF+yZunATSE?=
 =?us-ascii?Q?zBqdLAPOfopZ16TDbqPv7Aob/AzQ8m+PRNVLqrYUv9IMGXTgWi12+gmU5Q4r?=
 =?us-ascii?Q?+Co4egyt6GtMh3imTJiifccSSvnwXOnTA3ngd2xbX9yPnPfiHkWMXcnM5PYx?=
 =?us-ascii?Q?praIvwab4QJgez0RV30kKFWzEqy38/eP9N84s8a3Xr7eA00elIZWYFmGB2wP?=
 =?us-ascii?Q?qmdNyGVSvhbTH81gOzWdmmZ0KuoyqTzdWt2LEslD12Z6JvXdQwSDidBvAsBo?=
 =?us-ascii?Q?i7kURXQM2CSI/Yx5u6zkmMlys0X1hCYU7qkdq30NY59nGy5qWItiNLhmPog/?=
 =?us-ascii?Q?elapbfi+0i2DtLdznNCil+x002TMkl3iA8IPtQ+ZoyHRUzxuGMp+AVMSzh5Y?=
 =?us-ascii?Q?mJk9en8JcS9MUgZ/yQEe4sW3YXWK5tU8/x1dQcdA/kyPR9Bv+yGGyw2hUr8Y?=
 =?us-ascii?Q?spB/sM4JCg82hWGD8XkkH+qMzCKjtU55GLyhZ0Mi9AyS3puuamBzdRvyJDpj?=
 =?us-ascii?Q?PRhEjAMTuGqN0epC4TLMIh8DV447rKGNyggfVPpMVirTNjD96oddqXrUa74t?=
 =?us-ascii?Q?y0vFU59L1EMEhPnW1NO3+M3Wsgxmdk8rD16CJwZ6LXWwNSndOxRh1kwbCSYN?=
 =?us-ascii?Q?SemU5rP96poCTzeTwHedFhpl1I5AC8Voh7ZJ94PIafDh2+Wz0egvrXkf+a2I?=
 =?us-ascii?Q?vBNfCD4oh050LMg8Gugh0UPzL6jOZSYvjZhRcK0jBFT8q5jLMQs1JdqNP+77?=
 =?us-ascii?Q?xOCW9RldirBf2BTzDKPpfNXwyakEmIcn2DzUXTHE4w6fnxD6P1HitUP/qD3P?=
 =?us-ascii?Q?I70abTFyIqKRK51NsGLzQzBRRk6INtApEvoLJ72sOFVJLlev15ChM1Y1jPAx?=
 =?us-ascii?Q?U1AefFX63guq/NYV3mKR/TmBahlRRtWRp8s0Mnt/hnZ43vQNAHqx/LuY6ps9?=
 =?us-ascii?Q?LWHMsI2zrz4xIEHgaYGrVyvLnFTYbhMju2KvdMQpAyhdeZ/GABouzBWlO9hm?=
 =?us-ascii?Q?Oi3M4KWPSHNgs/Um0lE3hzwE4sYqC7j8ytmO0Ps2iMGXotw7DzjUv+2GVghT?=
 =?us-ascii?Q?SbeDt+yQoNGecVyp4C4f/l2Gc9PNmd1j+ZIdhoLOWkPmSSMSZwdvRomVZZND?=
 =?us-ascii?Q?cyChTgP9/4R9WJIzknkw+DIEZ7jdzvtOd/jUoZjxFZLv36x2pbKgRrAc8wId?=
 =?us-ascii?Q?XGr/ZftDHYIiVVoeWU96RNF7Lzf6GmKUGFDDPoNKcacZ9zZrjCiPKMlOGtBB?=
 =?us-ascii?Q?nqZMzvfj2HR0tHIyMMa4FsPxg2a/TJb9ZkjqXXZRp9LVpGEfVtCjPmd32dC5?=
 =?us-ascii?Q?D+MIMh0wh+ZWMGl5fcHDg+3gT/t7kg9PuogpMcFjPOTKLLeR9xJtUjWsQvGJ?=
 =?us-ascii?Q?uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931e2bad-6c43-4494-850c-08dc96c3972a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 16:09:57.8370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EiX7aXXL/HEa64fBg+pq/WCFAaSg8uuDeMEogbpdXijVExdZN+EVEvYKLx6Tn1FUZg+zioHOgdTqBYYnTsCE3d4BrhYWhDFNnLXlE+kuEhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6692
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Shiraz Saleem <shiraz.saleem@intel.com>
> Sent: Thursday, June 27, 2024 10:53 AM
> To: jgg@nvidia.com; leon@kernel.org
> Cc: linux-rdma@vger.kernel.org; Saleem, Shiraz <shiraz.saleem@intel.com>
> Subject: [PATCH] MAINTAINERS: Update Maintainers for irdma driver
>=20
> Remove Shiraz Saleem and add Tatyana Nikolova as co-maintainer for irdma
> driver.
>=20
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ca8f35dfe03..b46161f61ff5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11066,7 +11066,7 @@ F:	include/linux/net/intel/iidc.h
>=20
>  INTEL ETHERNET PROTOCOL DRIVER FOR RDMA
>  M:	Mustafa Ismail <mustafa.ismail@intel.com>
> -M:	Shiraz Saleem <shiraz.saleem@intel.com>
> +M:	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
>  L:	linux-rdma@vger.kernel.org
>  S:	Supported
>  F:	drivers/infiniband/hw/irdma/
> --
> 1.8.3.1
>=20
Acked-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>


