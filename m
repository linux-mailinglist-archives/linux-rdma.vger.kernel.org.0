Return-Path: <linux-rdma+bounces-11974-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 220DEAFD88B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 22:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE454188F6CD
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 20:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300CD23E334;
	Tue,  8 Jul 2025 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYAG+J8p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7514A60D;
	Tue,  8 Jul 2025 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007216; cv=fail; b=ro+REaj70UZppFCWSvUj1g+a1ON8KZB2L3LdPMZDSwPYf4mup3emBgs4yI9dbWAmqAFfKnbvWe59Dh9BEE5VUmV9Osr017yczMC/5+ZUdxUNdUw1IumQaTL9ynTgy9S+BjWjshPJ8fvRCA93n1SiPcavfnxbplTFxQTOVoZZR6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007216; c=relaxed/simple;
	bh=CwnvjVWLqcnBhg2xGlmctm+RS+Z2cGJF+N9FdhJztBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jNRqnZ6HFyG2gfCc3SWCeG1EbY2pIGPK8fQIwt3YWFLZVn3ZHGpjhJlTJT5pSO/1dF0NTViXOwzXlezpEY0gSlKirEczUloTPuBNfa7QS2snllERxbDzO+GXmjir+VIUNuDI8bSw3dSsNbo66m6FqG0dkPwHVvnMPJ84Bzn4Bu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYAG+J8p; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752007215; x=1783543215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CwnvjVWLqcnBhg2xGlmctm+RS+Z2cGJF+N9FdhJztBg=;
  b=VYAG+J8pTQy6srCAOGwBVHp80077cX+0yMivmwrEQyOovTEqLkqgQB7s
   x1n2NAncjzXTIBvlvLp65EzPFRaaAAUCX4Xo8kWMGaSL89atSY9IBgKd6
   UJKPUKVq9fIliBOAZIc88lfLH4Nd/msngi80rvndhWiJaC9r+dFgn/oD4
   4QonN4oNnxJ+fa7U5tbKTUertg5NOJYNR0lW2sCSgcybl2YqCkUXj/MfA
   eRCqYKxm9Nrv4KX5CQZSclJyC9y9ZFn2nIVxYv+Ls7NW6E1wUm8qQSGXN
   yvRyf/RZE8tjBRoPkBl/bMY9YASmLFVuK8GacYNBqwOUCz2r7I+qDQBqc
   w==;
X-CSE-ConnectionGUID: zSc2rEDgS46gVOm4ek+24w==
X-CSE-MsgGUID: uPBN5iSJRVuVGNIESvr6iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="56868668"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="56868668"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 13:40:14 -0700
X-CSE-ConnectionGUID: Hd5+fvZwTJqBtUXjz/Jpaw==
X-CSE-MsgGUID: 1Izmnf3pSIiYfba+skNrtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161146117"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 13:40:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 13:40:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 13:40:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 13:40:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHdsoN0JQIViZZJziAy5FjOAh7VlZvpFW8C1sY8QxCYy0PEgSngjpMGVtPJ9Ej108MjwYdMwx8QFU1WHVsuWQBpr5eqP9jwa2LZQbdcZTR5738DcFCCAjEyuIEnlYsxxyWmP/Wxm3kF7t/dm1OqvWz8lgMzGVAhKhdRSRh5OcjgppwhkAAu1BTTwEuFqcXcU4zHNl+d7YnNCtALUOYQo8RwXbXAsY6DktnP0ZCiFieGpvZwW2AMzcxjz2nzbavaSqbL6QnI6uSO+YSQJlj0C+kaZ/4b8J161JZMlV9XBhfi8YVboaYlXsP6f4834y7RV8C5HTGqr0yL+1lhlU514/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwnvjVWLqcnBhg2xGlmctm+RS+Z2cGJF+N9FdhJztBg=;
 b=VR388gkUhWah21xgJ1Agqw1Sijn5j4cYtIqv1JjOdreYkeEa4PBD5gflRGVheG0t/hVF0xxB4dDjqINKxqUbQKd89gPSDncY8zV8GgMLL8g/SuwLtThXW8nIFEgx1q+Hoo4u3gGKEIOwnazyIoCV0LxmTMJoERBM2eiBUDww48q0pNUTUfS85dCkeWApexTWAirnwf+ziXJQMm9iKSowpmWC5YCpAPrF3vJaL9bMKXJhKYyVyeKtusjwIwAvOkI7PZKKRLAbMCHr8R78pUpbL6xR30aBSmVbJ1hkDUJOPS0+0E6tsoYuYgxzUTacT05I1mXIKzYmY0lC8AiMSKWycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17)
 by BY1PR11MB8055.namprd11.prod.outlook.com (2603:10b6:a03:530::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 20:40:09 +0000
Received: from IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::763d:a756:a0e4:2ff7]) by IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::763d:a756:a0e4:2ff7%5]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 20:40:09 +0000
From: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>
Subject: RE: [Intel-wired-lan] [iwl-next v2 0/6] Add RDMA support for Intel
 IPU E2000 in idpf
Thread-Topic: [Intel-wired-lan] [iwl-next v2 0/6] Add RDMA support for Intel
 IPU E2000 in idpf
Thread-Index: AQHb2+V3yG1jJU/BzEyMWQbJRc/s6LQAr6sAgCgDGQA=
Date: Tue, 8 Jul 2025 20:40:09 +0000
Message-ID: <IA1PR11MB77275BF8E2885AC02204309CCB4EA@IA1PR11MB7727.namprd11.prod.outlook.com>
References: <20250612220002.1120-1-tatyana.e.nikolova@intel.com>
 <1dbe36d4-c272-4af0-a83b-0ab7ff0464c3@molgen.mpg.de>
In-Reply-To: <1dbe36d4-c272-4af0-a83b-0ab7ff0464c3@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7727:EE_|BY1PR11MB8055:EE_
x-ms-office365-filtering-correlation-id: 9fc7975b-7e7f-42ff-af7f-08ddbe5fa18e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZlRUTjhzRUR5Y1JaazUwMFRJelBxTmJZZEVkSXpBVitvWkZEYUNwaGIwM1NW?=
 =?utf-8?B?VWIwNVZ5UGFPbnRKblJYdW9EM3lIbW80SGg0WDVWaitwRFFzbkdSWk55Z1g2?=
 =?utf-8?B?Q2h2cm5ZL1E2YTdDYytwc1dEcFdvUi9jL004ZTA2SlppUXArUlpHL3BQeGF4?=
 =?utf-8?B?Z25LVVF0bTBseWNUQTJaT3cwbStvZEx0aXN6Z29Zdm9Ua1M1T3NrTG9VR21B?=
 =?utf-8?B?emx2ZWVYckp5ODl2dmh0Q0hOVWV0cm14MVJTLzdIcktaSjNPazVUdGRrS29V?=
 =?utf-8?B?Zmhad1FHNm5MWmw2aHRTSDZiYkpndHBEcGZHbEdqUTkvTTF3UnFUS0JRbHdG?=
 =?utf-8?B?ODgxS1BreUtTSlBBbm1PSm9DRENnSktZSXlOSUsyVDNEVHMrTHl3bzU2Nkx1?=
 =?utf-8?B?Q0czUXN6b3lRazZJcFVZM2dSMEZkQ29IeWM4UDVkYVErdmlzVzVQOGxabUhD?=
 =?utf-8?B?Wk5Ha3p0QVFHRHJUSkV6TWk5aW4yeXQrOG1mRTl1RnVkclY2TXlXZEFxNGhx?=
 =?utf-8?B?RTFzUVZ6bFBCNnhwQ1IxS0Z2VkRFanoyc3ZON2VITW1NWVBvL1JUUUwrWEo3?=
 =?utf-8?B?cUhQRzZqTzVEN2huNTNsUXZ0ZEVTaTZKYlVFSXRzYlVPWFJGYmhzd1FBTlVW?=
 =?utf-8?B?L05ud1RERUhMR3pEL3FvWUdqcHhvTDFDZGYyZUZSNUJHSENhVDNSTG5TL2V2?=
 =?utf-8?B?b1ZyOWJqdW9qN3B4TGxVbTY4R2U4QmlRcU9qQVgyNU10MHUwbkgwdkYvdlpI?=
 =?utf-8?B?dHpNY0V2VE0yMk9KeU5PS3ZNb2o0MUROR3lCbDN1eEdOdmtGRDZUcWk2clRB?=
 =?utf-8?B?RVlITGx5eHBWeHFtdVlXRDRHdlZPSHV4bHNZSkJSQzdWZk1Zdk9BU2NBanhs?=
 =?utf-8?B?SnpjNEZpaUIwSEkzcWxibjlORnRyeTJXOTRBUVMvVEhHWU01bWNtVUQ2Y1pR?=
 =?utf-8?B?bVZpRTdLbGtEWmloRWowL3lGcHQvbUhjMlp6VDhjb3lqeER0bGl0ejFwODMr?=
 =?utf-8?B?ekRvS2tMeXVqNCthR3g4d0hsMWZHQkNMVy84Tk5VOGdSZC9mV3dseFpGcFVR?=
 =?utf-8?B?a3VYSDltUW9IUEREWHJUdHF2a013QkNuRDNFb3h4bEFkZ3RIM2Y1WU81a3oz?=
 =?utf-8?B?M2UyN3ZSS0pPazJtd1hhY0g1WUYzWWdRNUsyY1hLT2k0bHZVOTJRU0JoSERy?=
 =?utf-8?B?WlJRMElKS3lJdFNqdE5PYTY5L2pydkVteW1XUk9OOWh3cjRTeTcrdC9VQU5y?=
 =?utf-8?B?T2YzdUNqdmdrZWJISkdJSlFUckhmdURTc0twb0VXSnFIdlpERHJsTnNpQzJq?=
 =?utf-8?B?NlYyWnBoSXZLMTlRTElQelhkalhxdnBkS0xib3FSaC9CZUdWT2lxbjlsNi9y?=
 =?utf-8?B?Q2lycDhvMFVGV1ZCazZZUTk3cCt6SVQxRVB3UEZFWUJReXU5cmdPM1hDTXFM?=
 =?utf-8?B?eGVWbjduV0xUYzBhUlVEMWk3eCs1MFZudkI1Y3Y0cmJPdlJ1NEJqa051Szk0?=
 =?utf-8?B?THVyR1FVdW1JU1E5KzVibWVQN0Q1akpiMGtvNExVQ2pMTDFhUnNOYlNGdWpr?=
 =?utf-8?B?cWZtVmtzVUNaMW1pNXpDNW9uTi9FbjNOcHZrSnFZNDZDblVueHZrMjJjZE9x?=
 =?utf-8?B?QlZVZ3ZuSnhuSGR3OXNPYzVNbGxXbnhLTDd6QytrR1UzWUM0aTJ0WEhUSjZB?=
 =?utf-8?B?M244WmdMMVE0aW9XUlFVSnlhYkhDblB3UjFhTy9lUHVuSVEzWm92VVFJVGpZ?=
 =?utf-8?B?SFRxVnBaT1djeHlSbmxMSW4xQ1lUakZ4QzBiR1RFT05VU0lrckJscGJwL25T?=
 =?utf-8?B?eklZY2Z4dHoyRUFWNWpZenBBSFJBdzU0ejBnWVpYbmJ3aVo3clBHd0dOM2h4?=
 =?utf-8?B?WElNRE5yaU9MU0RZVTR5WUVkakNmT1RMUndmdnJoYjJjejZqb010V1ZWTGsz?=
 =?utf-8?B?VERIR3pKOVNGZEZlV2UrWG9CbCtKQUtwRDMzR1g1UVFyR2RvTlhPKzM3b2pI?=
 =?utf-8?Q?oeP9a3Y9JTLKKNKDouYZULTIIcLexw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eW93WHB1d1Mxb09kc0NNR3UwVUxRY1ZrTHRHRWp6U2xkdlFBeFo1cDN4VnM1?=
 =?utf-8?B?NnJZeDV2TEVpS3pEcHFuUVdZTktaQXF2RkNMblMyNFNCYW1sTzNCOStmTTZj?=
 =?utf-8?B?emJEVUxNT0NXdUR5TFRJZm1mZTBmaWY0MmMvaTZ5TTZPbmZORXA3MkIxM01L?=
 =?utf-8?B?NzJRaWZ5Y3dOZnY2VUt3ZFluS2NSQ2p5ZUVtMHBKNUY1WnQ0UExRcllDbmt3?=
 =?utf-8?B?ZEZUa1VPVWg1YjdHMHRpYkRObThTdWlrdlhVVkN1N1U0Q000MFR1T3BXcFBn?=
 =?utf-8?B?WDh1djFubWsvR2JLeUVReko0N2ZFbTJBUlpCVVdlc1pqNHVSdEJrbE5xK21K?=
 =?utf-8?B?YzZkTGgyRVQwZitOMmdVZ0d3OXhOREFGZGgzWE1MQWcyRFZnYWF4eGw5K1U1?=
 =?utf-8?B?SXo2NUFNRFpnM0tIelZEM2xOWThHeVVETHZWOWltMkJyL2Q5VVJZVis5cDk2?=
 =?utf-8?B?NlhPMVZPd0hxcUNuVU9WNnZDRGVRdlM1NnFoVjdqTjBkdkJia244endvc1d6?=
 =?utf-8?B?WVBzaFByaVd3MElyK2lzZE9OMDVjTjZsVmJaUkU1K09MTjJod3l2ZlYzWDBz?=
 =?utf-8?B?R2k2TlZVZnFRRXAzKzcrZTlOd21SSEhnMGxkNkVJbzlYTnJEcmhtdEFxa3F2?=
 =?utf-8?B?Nlk0blFwb0RhK3ZtM1VZVmt2bnl5Y2pqZW11dm95dEVsSnhqYzlWdm5sc3VY?=
 =?utf-8?B?MkEyUGUycWxzbkN6bWVTclpkOGNacENKaXNsbGRuWGtjVXgxdHlrU3dMTCtC?=
 =?utf-8?B?Vktkditpc0owZkNKTlRIOEI0aWZsc2tYS2VNR2Fidld4QnVXRXk1dHlqdzFG?=
 =?utf-8?B?RXdrOWM1c1o2S3ZXUHdKMHhvQ2phamRvajhBOGVhWkZNZytwM2wvd2w5d296?=
 =?utf-8?B?L2s3ZWJxcWhLZFJCYTZFMkpFY0p6d1JiTkVKWk5iTWpUc1ZFS2VIQlF3c2hQ?=
 =?utf-8?B?bzFkRGpaRGc2eXpKOC9PV2Ewek5LV3c4dGVXWFZ2Wm1VQk9RKzJFNDRwTFBt?=
 =?utf-8?B?YXZJSlhlb1EvTzNDOHVKdW9TK0FQTnkvS0UzOEx0Rmx3RzhBb25BVFN6eWp1?=
 =?utf-8?B?Z3BwY2pLQ1lFbzgxc0p6TUxwNTNDWUNBSzNKSkN5TjVDL21YWlkrNVFNNnZO?=
 =?utf-8?B?T3NGTG80eGxvZ0ZVVlNsbFlISmwyOVV4RnpRNWZmMTVpNVFEL2J2aEtWeTFS?=
 =?utf-8?B?dkJRb294Q2RyQjBsWWhZa2h3c1ZwWDJvSVpWOHNaRXd6ZGFSUUloUURPV3pX?=
 =?utf-8?B?VWJJdWlLV0Uwb3l0ZVZhaTNkeSt6MmlDSzF6Vk5BcFFSYlNvb0Y5Qk5mKzlL?=
 =?utf-8?B?VU1QZVBtYmh5N0F6bXNNcEpiQ3FZT3YwZnpXYTdxc1pEbytYeTc2L1VvZkNk?=
 =?utf-8?B?cWx6K1g4aWFaQklaTUdsNG5tc1BnZWo1RmV4QW8yYmd4L3o1TDUySmJzZm81?=
 =?utf-8?B?U1N3SWNNTSttSGlnSmRzcC8xc3NsN0xwcHgrUlVraFZDMzlrVlJOamdGN1hS?=
 =?utf-8?B?UVEvS25aU2ZWWXh5Nnk5T3ZCbnNZakRlQm9CaFZWVXRBd2U4L1VZalJMNnZT?=
 =?utf-8?B?dmRLaG9ZdEV4SVpPRytZbnlWNmxMV1lFVDNoTXl0elBRbHFoTDFaaHRTZjJY?=
 =?utf-8?B?TnVOTFZnamRwZWFYZStCQ3VpSzFrSHd1L3l3VzVPREMvdGptTGRQbjlJcUVD?=
 =?utf-8?B?TzNhdWdBZWlyVWtybVUzeWd4V2dSS2FPS3BLZXNnZ2xOZUFubXdPZkpmY3Zy?=
 =?utf-8?B?a1JlU1NXQi85ODVHcG1NVUhTSE96aHBzY0NIVTdGbTJVS245dFJkRlp3MXIr?=
 =?utf-8?B?dUhZZU9SMDEyV1dtTU1aZ0VFd2Z4aXdYcXlSSEcvb0ptWUdUMFczU2w3TkQy?=
 =?utf-8?B?Mm9zbWk0cTE0b0V6VmczZU55ZjhjcER0bDU2NWNCVUN6K0dXU1ZCbEx0U292?=
 =?utf-8?B?TEd4cWh6UG5DR3BNRG44ZFhVdXZrZzZvRCtwL051Mndha0J4SlRhYlRsV3lJ?=
 =?utf-8?B?YzF6QzVxSWFxcjZGblhRNFVaVDY4MUVUeDFaUzdlcTNwMjhSbk5UekZPL09m?=
 =?utf-8?B?UGpLc21RNXNTeDJ0ZjJKbXp2ZVErQmNZTGJMS2o1WnhzZkVyYkIwMjJVZFNC?=
 =?utf-8?B?MTFsOTAyYWdDMlVEOURQeEMxLzFoQnhrVjM1cmpEWDAySVg1SU51ZXZmY2hh?=
 =?utf-8?B?VlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc7975b-7e7f-42ff-af7f-08ddbe5fa18e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 20:40:09.7930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3z9/ZXPVO+pq+/6lHotmJizgDSGhhZ6eJMmhT8s/XzZmy86nmVS0MPSVBkr+GRJPusvCtIRV01nhaJNKj5avTxyiJsHw3OJH9ExJmPnuD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8055
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNZW56ZWwgPHBt
ZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU2VudDogRnJpZGF5LCBKdW5lIDEzLCAyMDI1IDI6MjEg
QU0NCj4gVG86IE5pa29sb3ZhLCBUYXR5YW5hIEUgPHRhdHlhbmEuZS5uaWtvbG92YUBpbnRlbC5j
b20+DQo+IENjOiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgamdnQG52aWRpYS5j
b207IGxlb25Aa2VybmVsLm9yZzsgbGludXgtDQo+IHJkbWFAdmdlci5rZXJuZWwub3JnOyBuZXRk
ZXZAdmdlci5rZXJuZWwub3JnOyBrdWJhQGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtJbnRl
bC13aXJlZC1sYW5dIFtpd2wtbmV4dCB2MiAwLzZdIEFkZCBSRE1BIHN1cHBvcnQgZm9yIEludGVs
IElQVQ0KPiBFMjAwMCBpbiBpZHBmDQo+IA0KPiBEZWFyIFRhdHlhbmEsDQo+IA0KPiANCj4gVGhh
bmsgeW91IGZvciB0aGlzIHBhdGNoIHNlcmllcy4NClRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nIGl0
Lg0KDQo+IA0KPiANCj4gQW0gMTIuMDYuMjUgdW0gMjM6NTkgc2NocmllYiBUYXR5YW5hIE5pa29s
b3ZhOg0KPiA+IFRoaXMgaWRwZiBwYXRjaCBzZXJpZXMgaXMgdGhlIHNlY29uZCBwYXJ0IG9mIHRo
ZSBzdGFnZWQgc3VibWlzc2lvbiBmb3INCj4gPiBpbnRyb2R1Y2luZyBSRE1BIFJvQ0V2MiBzdXBw
b3J0IGZvciB0aGUgSVBVIEUyMDAwIGxpbmUgb2YgcHJvZHVjdHMsDQo+ID4gcmVmZXJyZWQgdG8g
YXMgR0VOMy4NCj4gPg0KPiA+IFRvIHN1cHBvcnQgUkRNQSBHRU4zIGRldmljZXMsIHRoZSBpZHBm
IGRyaXZlciB1c2VzIGNvbW1vbiBkZWZpbml0aW9ucw0KPiA+IG9mIHRoZSBJSURDIGludGVyZmFj
ZSBhbmQgaW1wbGVtZW50cyBzcGVjaWZpYyBkZXZpY2UgZnVuY3Rpb25hbGl0eSBpbg0KPiA+IGlp
ZGNfcmRtYV9pZHBmLmguDQo+IA0KPiBUaGlzIGNvdWxkIGJlIHJlLWZsb3dlZCBmb3IgbG9uZ2Vy
IGxpbmVzLg0KT2theS4NCg0KPiANCj4gPiBUaGUgSVBVIG1vZGVsIGNhbiBob3N0IG9uZSBvciBt
b3JlIGxvZ2ljYWwgbmV0d29yayBlbmRwb2ludHMgY2FsbGVkDQo+ID4gdlBvcnRzIHBlciBQQ0kg
ZnVuY3Rpb24gdGhhdCBhcmUgZmxleGlibHkgYXNzb2NpYXRlZCB3aXRoIGEgcGh5c2ljYWwNCj4g
PiBwb3J0IG9yIGFuIGludGVybmFsIGNvbW11bmljYXRpb24gcG9ydC4NCj4gPg0KPiA+IE90aGVy
IGZlYXR1cmVzIGFzIGl0IHBlcnRhaW5zIHRvIEdFTjMgZGV2aWNlcyBpbmNsdWRlOg0KPiA+ICog
TU1JTyBsZWFybmluZw0KPiA+ICogUkRNQSBjYXBhYmlsaXR5IG5lZ290aWF0aW9uDQo+ID4gKiBS
RE1BIHZlY3RvcnMgZGlzY292ZXJ5IGJldHdlZW4gaWRwZiBhbmQgY29udHJvbCBwbGFuZQ0KPiA+
DQo+ID4gVGhlc2UgcGF0Y2hlcyBhcmUgc3BsaXQgZnJvbSB0aGUgc3VibWlzc2lvbiAiQWRkIFJE
TUEgc3VwcG9ydCBmb3INCj4gPiBJbnRlbCBJUFUgRTIwMDAgKEdFTjMpIiBbMV0gYW5kIGFyZSBi
YXNlZCBvbiA2LjE2LXJjMS4gQSBzaGFyZWQgcHVsbA0KPiA+IHJlcXVlc3QgZm9yIG5ldC1uZXh0
IGFuZCByZG1hLW5leHQgd2lsbCBiZSBzZW50IGZvbGxvd2luZyByZXZpZXcuDQo+IA0KPiBTdGls
bCBtZW50aW9uIHRoZSBkYXRhc2hlZXQ/DQpJbnRlbCBoYXMgbm90IHB1Ymxpc2hlZCB0aGUgRTIw
MDAgZGF0YXNoZWV0IGF0IHRoaXMgdGltZS4NCg0KPiANCj4gQWxzbywgaXTigJlkIGJlIGdyZWF0
IHRvIGhhdmUgYSBwYXJhZ3JhcGggb24gaG93IHRoaXMgd2FzIHRlc3RlZC4NCldpbGwgYWRkLg0K
DQo+IA0KPiA+IENoYW5nZWxvZzoNCj4gPg0KPiA+IHYyOg0KPiA+ICogTWlub3IgaW1wcm92ZW1l
bnRzIGxpa2UgdmFyaWFibGUgcmVuYW1lLCBsb2dnaW5nLCByZW1vdmUgYSByZWR1bmRhbnQNCj4g
PiB2YXJpYWJsZSwgZXRjLg0KPiA+ICogQSBjb3VwbGUgb2YgY2Rldl9pbmZvIGZpeGVzIHRvIHBy
b3Blcmx5IGZyZWUgaXQgaW4gZXJyb3IgcGF0aCBhbmQNCj4gPiBub3QgdG8gZGVyZWZlcmVuY2Ug
aXQgYmVmb3JlIE5VTEwgY2hlY2suDQo+ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHNwbGl0ICh2MSkg
YXQgWzRdOg0KPiA+ICogUmVwbGFjZSBjb3JlIGRldl9vcHMgd2l0aCBleHBvcnRlZCBzeW1ib2xz
DQo+ID4gKiBBbGlnbiB3aXRoIG5ldyBoZWFkZXIgc3BsaXQgc2NoZW1lIChpaWRjX3JkbWEuaCBj
b21tb24gaGVhZGVyIGFuZA0KPiA+IGlpZGNfcmRtYV9pZHBmLmggc3BlY2lmaWMgaGVhZGVyKQ0K
PiA+ICogQWxpZ24gd2l0aCBuZXcgbmFtaW5nIHNjaGVtZSAoaWRjX3JkbWEgLT4gaWlkY19yZG1h
KQ0KPiA+ICogVGhlIGlkcGYgcGF0Y2hlcyBhcmUgc3VibWl0dGVkIHNlcGFyYXRlbHkgZnJvbSB0
aGUgaWNlIGFuZCBpcmRtYQ0KPiA+IGNoYW5nZXMuDQo+ID4NCj4gPiBBdCBbM106DQo+ID4gKiBS
ZWR1Y2UgcmVxdWlyZWQgbWluaW11bSBSRE1BIHZlY3RvcnMgdG8gMg0KPiA+DQo+ID4gQXQgWzJd
Og0KPiA+ICogUkRNQSB2ZWN0b3IgbnVtYmVyIGFkanVzdG1lbnQNCj4gPiAqIEZpeCB1bnBsdWdn
aW5nIHZwb3J0IGF1eGlsaWFyeSBkZXZpY2UgdHdpY2UNCj4gPiAqIEdlbmVyYWwgY2xlYW51cCBh
bmQgbWlub3IgaW1wcm92ZW1lbnRzDQo+ID4NCj4gPiBbMV0NCj4gPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvMjAyNDA3MjQyMzM5MTcuNzA0LTEtdGF0eWFuYS5lLm5pa29sb3ZhQGluDQo+
ID4gdGVsLmNvbS8gWzJdDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwODI0
MDMxOTI0LjQyMS0xLXRhdHlhbmEuZS5uaWtvbG92YUBpbg0KPiA+IHRlbC5jb20vIFszXQ0KPiA+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDIwNzE5NDkzMS4xNTY5LTEtdGF0eWFu
YS5lLm5pa29sb3ZhQGkNCj4gPiBudGVsLmNvbS8gWzRdDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjUwNTIzMTcwNDM1LjY2OC0xLXRhdHlhbmEuZS5uaWtvbG92YUBpbg0KPiA+
IHRlbC5jb20vDQo+ID4NCj4gPiBKb3NodWEgSGF5ICg2KToNCj4gPiAgICBpZHBmOiB1c2UgcmVz
ZXJ2ZWQgUkRNQSB2ZWN0b3JzIGZyb20gY29udHJvbCBwbGFuZQ0KPiA+ICAgIGlkcGY6IGltcGxl
bWVudCBjb3JlIFJETUEgYXV4aWxpYXJ5IGRldiBjcmVhdGUsIGluaXQsIGFuZCBkZXN0cm95DQo+
ID4gICAgaWRwZjogaW1wbGVtZW50IFJETUEgdnBvcnQgYXV4aWxpYXJ5IGRldiBjcmVhdGUsIGlu
aXQsIGFuZCBkZXN0cm95DQo+ID4gICAgaWRwZjogaW1wbGVtZW50IHJlbWFpbmluZyBJREMgUkRN
QSBjb3JlIGNhbGxiYWNrcyBhbmQgaGFuZGxlcnMNCj4gPiAgICBpZHBmOiBpbXBsZW1lbnQgSURD
IHZwb3J0IGF1eCBkcml2ZXIgTVRVIGNoYW5nZSBoYW5kbGVyDQo+ID4gICAgaWRwZjogaW1wbGVt
ZW50IGdldCBMQU4gTU1JTyBtZW1vcnkgcmVnaW9ucw0KPiA+DQo+ID4gICBkcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pZHBmL01ha2VmaWxlICAgICAgfCAgIDEgKw0KPiA+ICAgZHJpdmVycy9u
ZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmLmggICAgICAgIHwgMTE3ICsrKystDQo+ID4gICAu
Li4vbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl9jb250cm9scS5jICAgfCAgMTQgKy0NCj4g
PiAgIC4uLi9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX2NvbnRyb2xxLmggICB8ICAxOSAr
LQ0KPiA+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX2Rldi5jICAgIHwg
IDQ5ICstDQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfaWRjLmMg
ICAgfCA0OTcgKysrKysrKysrKysrKysrKysrDQo+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9p
bnRlbC9pZHBmL2lkcGZfbGliLmMgICAgfCAxMDIgKysrLQ0KPiA+ICAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWRwZi9pZHBmX21haW4uYyAgIHwgIDMyICstDQo+ID4gICBkcml2ZXJzL25l
dC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfbWVtLmggICAgfCAgIDggKy0NCj4gPiAgIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl90eHJ4LmggICB8ICAgMSArDQo+ID4gICBk
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZHBmL2lkcGZfdmZfZGV2LmMgfCAgNDUgKy0NCj4g
PiAgIC4uLi9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX3ZpcnRjaG5sLmMgICB8IDE5MCAr
KysrKystDQo+ID4gICAuLi4vbmV0L2V0aGVybmV0L2ludGVsL2lkcGYvaWRwZl92aXJ0Y2hubC5o
ICAgfCAgIDMgKw0KPiA+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi92aXJ0Y2hu
bDIuaCAgIHwgIDQyICstDQo+ID4gICBpbmNsdWRlL2xpbnV4L25ldC9pbnRlbC9paWRjX3JkbWFf
aWRwZi5oICAgICAgfCAgNTUgKysNCj4gPiAgIDE1IGZpbGVzIGNoYW5nZWQsIDExMDIgaW5zZXJ0
aW9ucygrKSwgNzMgZGVsZXRpb25zKC0pDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWRwZi9pZHBmX2lkYy5jDQo+ID4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgaW5jbHVkZS9saW51eC9uZXQvaW50ZWwvaWlkY19yZG1hX2lkcGYuaA0KPiANCj4gDQo+
IEtpbmQgcmVnYXJkcywNCj4gDQo+IFBhdWwNCg==

