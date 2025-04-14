Return-Path: <linux-rdma+bounces-9415-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51221A88853
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 18:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0BC1673FE
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DB327FD40;
	Mon, 14 Apr 2025 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRYNBZM3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BD923D2A6;
	Mon, 14 Apr 2025 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647378; cv=fail; b=p6yFruGYr9k7MkFn1lg74+QlGCSFhwUV+0CHLjl9W5sNQo7SYx7k3XguhdoX6Fc02w1c/ZbYW6bynkyrHUHLY/SpaN5Y9UqJNnPeM2uh5QUtb97TRbdgMD/s9+wS6MAJpQkLXMahglWhaAshnKRFSLvpgvZjYAv8UBQcHWyXbIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647378; c=relaxed/simple;
	bh=ffIq5VRjSZHhFyskgC786pQ0v7toy58UAHViQDAFXdA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FexnCVB2YIrj06FmDrSTuY27zk/pMSxSf7mZjapUya40Ja6yue+4rJKZo2WpHjuTy9xZz+6B7WSMES/KSgihTKXLC24Oj48DUzQdDgg3K670GnCjSZQ0TF3m6aS1peGcV/Ra7fJMAfH9cpe8E3qk4gqwvSvyd9ymXuSUTC3M17o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRYNBZM3; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744647376; x=1776183376;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ffIq5VRjSZHhFyskgC786pQ0v7toy58UAHViQDAFXdA=;
  b=VRYNBZM3xPqWbLeSZ/l8KakL4H2kD5lRx5er66Fu2AeNLXX0Z54+/KAU
   F2/AaGWnRfispXlkHNH89V+544it41XmsDotuvye+Dc663vmDAyUMHtFl
   F4FUz8ceQ27RbdbktW0Fa1bP2uxkoahzKJrPusLjo4V+NUwABz1gjtVQ+
   vYFCmWrATFPBpySixZMBShJqEwg/dwajfw10/fmT5a0buJLstqreNq4jZ
   1bRTLKxSeeIFKZsdtRNmPqeeDZAxlH2qCFzKFJt17/9qeuJ8Ow/DTVpGF
   XHbLjxNSORJEwBudqp9uvqIgy2jRGTjkHm4BDa+hoB7Yh+sPSFlucgVOe
   g==;
X-CSE-ConnectionGUID: 0GKgJXYOQ1+HaVwlzfxcnQ==
X-CSE-MsgGUID: n3Ozfwc4Re2U5NHpB4zlPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46217608"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="46217608"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 09:16:15 -0700
X-CSE-ConnectionGUID: eL00awO+TgieS6Ga57ARUw==
X-CSE-MsgGUID: tr3Pxp1RQGG73ycaqceAFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="130411024"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 09:16:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 09:16:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 09:16:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 09:16:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7CQIjqEfsBbOogtsjqVG4Ak3+8G1xcIREUcyIN2HTEK2DiXM10h3hIj3IcIbq0eNsX5YwweK+AkQSTVfvyhjpyctpDOFtYt9caq8n2OvzclERUUN6+kkYBtHri2XJJc4HgUXUIm/MSzgjwHlobqzEH4K7jx7SeOTwA14VnPZGanVNf/rk30PTJqAlW3x4BXQ6MvEHcWWQySF6D4AwzYvrXTP2qUEjGEd6DvVijOWfZ5fevW73U+mWMxEeTuwWFnHszBTINX1j9tkvdW82cVFQr+eotLWN/asMb1dvgGC+fSjgFFHgtS/C4FqPwrM84+1voOsMa2CyhbOs+jVfAlug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffIq5VRjSZHhFyskgC786pQ0v7toy58UAHViQDAFXdA=;
 b=SLm/mOrdT3KJA4OROIe6AwCQOpW+lXsHwZ6i7tSVwAMxnhdHC7i1iRzFHax1CWTkQ+Ljlz8jhKFS9Aa6qLIUzQrbcDh29uZRfHK+IJ9AFTwF38XKTIj3XBXUbceA6rwaOJtwLkuThjBP9dn3SwLrb2BB02bUVQCCSlJlh23zAJWiEg3qgPVvzv4xwGZIp+tEDCSg+fdH8dxY6uvcLHdp5QlLojrrlq9vyFQLIsOs22JN7KQC9T2VVz1dvK6Vsp/EoQ70809UxG60ec+zU2vtBSoo0qEMhE7VOM4tiSxgi8XJnH4UuDKloDMzMTZlAbW7DpcbG7NEVhOwvS0359rdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by CY8PR11MB7394.namprd11.prod.outlook.com (2603:10b6:930:85::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 16:16:05 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%3]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 16:16:04 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>,
	Jeff Johnson <jjohnson@kernel.org>, Loic Poulain <loic.poulain@linaro.org>,
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini
	<francesco@dolcini.it>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Dumazet,
 Eric" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
CC: "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
	"wcn36xx@lists.infradead.org" <wcn36xx@lists.infradead.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next 3/7] wifi: ath12k: Don't use
 %pK through printk
Thread-Topic: [Intel-wired-lan] [PATCH net-next 3/7] wifi: ath12k: Don't use
 %pK through printk
Thread-Index: AQHbrVDXiFRbaY30nE2Y1mOHGhcw77OjVlag
Date: Mon, 14 Apr 2025 16:16:04 +0000
Message-ID: <SJ0PR11MB586613B64EB5DFF057332B33E5B32@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
 <20250414-restricted-pointers-net-v1-3-12af0ce46cdd@linutronix.de>
In-Reply-To: <20250414-restricted-pointers-net-v1-3-12af0ce46cdd@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|CY8PR11MB7394:EE_
x-ms-office365-filtering-correlation-id: b79ae39d-546f-4258-e0cc-08dd7b6fa824
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S0p5ZmxPTG9pM0NDc1V1UFpOU1MwSUxSQzBkS3U4Q280enhJcmpIb0s0NHVU?=
 =?utf-8?B?Q2hsd1dHa0JCTXVEb2NGZDg5QkNSamZob2xoVTB3ZGVPUXJsd0ZHUTNMQUdN?=
 =?utf-8?B?YWVzeXJKRWp4OExxU0Q1cHN3SHJ3SEVRSnhyVTcvMWtyTXl5cWtmazgrQjdI?=
 =?utf-8?B?OTA3aWhnc3pQbEhKdm9QVjZNbHA3UFhnLytoQVllZHUwYitydUUydmFLTHRZ?=
 =?utf-8?B?aGdUV254Wk9SZjZ3MGxFU3JPZ3h6a3JjV2EwMjVMQTVjVm9iNS85eDNJMTBP?=
 =?utf-8?B?V2tobCs5WlJkNURkYTUrcEZhMkNJd2ZxYzd0dE5uazNrWDYwM3pEUGNtdUVR?=
 =?utf-8?B?N0MxelZodXpQWlF3TlZZL1BSRExDZGVBWGV5bFovWkxmRXpjbXJwSmR3WENE?=
 =?utf-8?B?NGhBb0doaVRqcitqRitnWWN0VWtRQmJtZGVWSlkzN1JPUi9ONTBhcTk1NW5S?=
 =?utf-8?B?c00zWEczbVJoVzJvdEJXeTVpUzk2VzJSR0ZVV0t1VWY0aEZCTVBscUFzUkpO?=
 =?utf-8?B?QkxieGFTR3prQzF0VmlBbTV3a0VQQlJkSnFtR0FORVBqblZPSXY0dW52N05p?=
 =?utf-8?B?cXFVdGFDZEdiYis2Y3BVaXQzaEN0Y2VVenpXbXp5Q3Z4SUlKL01uUGhFcFZU?=
 =?utf-8?B?WWpmWGlrc3hRNGVsWW05dlBxTGdDVVhFbm1WTUpGcjNPemFldElLU0VXSVpI?=
 =?utf-8?B?aWJoUTBWd01qSWprcVlzQk1CbWU4MnpCWkRxdGVocDhucGNQMEVHMnBzaG1R?=
 =?utf-8?B?Ky85bStCdGFBNnRUNzNuY3FaUU9iWmxVc2ZqZFgzbmt0MXdCZVRCc2lKaHJl?=
 =?utf-8?B?bTZ6OFUzSllyaFBXYS82bW1YZzRqVnJ6SkgwWnh2NWE3MmRWNmF3Y1NEby95?=
 =?utf-8?B?MFIvOGp1ZGp2dFJSenMyQkdSWUZBSXJSTjNwdG9kT3E5WW5CNExaa1QwdjBl?=
 =?utf-8?B?VUZ0dld3RzJZZFE5cG92eXdzc1U4c1pXZXVFaTZTbEdrY0RmTGJOUkpqMFcw?=
 =?utf-8?B?ZFZSTG5SNWwrL0xLbUVVQTVYZkZmVUtJdnBEOGZwTVN0b3ROUU5RTzBrTEJt?=
 =?utf-8?B?b3ViVjJ0V0xTUmdOUzRMQTBlZHdwa1JUNE5IQW1mL09oUnNwRkFwbVNzZWJ4?=
 =?utf-8?B?M2UvcFNRVnRaYzh0V2RiOHdZWkp5Mm1NblF1UEZ6RC82WXg0SnhHOHRHUkkz?=
 =?utf-8?B?OEdKNEVPY1VieXpwOW5SUEFRbzBDcldCNmliNkRQWGtLeXpyNFNYRzJ0Vmlm?=
 =?utf-8?B?OXR1by93NHlGTUFSTFJQMkRJeUx6K3B2djN1SGM5V2N3RmpDRm1qSksrRW9J?=
 =?utf-8?B?WVczTG9ZcFJMZGJVdlJBVEdJMFcxajJYZ3BtSVk5VWovL2JsUWZzaWtmZFN6?=
 =?utf-8?B?M0pMNkthVGpqenJ6T0FscFg5dnQzNjYwU2RRLzlyUWNOeVBiSGlseC83cjM2?=
 =?utf-8?B?Q2pGdTl6dWVZanYvMzBuY2gxQmI3UXhvZlVhdDJpZjdERzc5aU90b01WVCsv?=
 =?utf-8?B?Ujk4WVdNM3Njbnl5cVZ6dk1vUzlQMWxENU85S1pqQXVUTFRXUVA0aWhYazlw?=
 =?utf-8?B?WGpDUko2N3ZqYWI5Ky83TU12ckVBWGFUc083ZTVRNTNFS0tGSXhWTHFmQzhH?=
 =?utf-8?B?TVFvRk5QZXhCQWdyc3F6Vjl2NHkzM1NKZVJFVzRZdHkvT2lqcVRPdlJPSElE?=
 =?utf-8?B?cWhTK0FQNmIwMWdPVGszU3R2aXRWbkd1QjR1N0ZESWlmOHA4ckZBb1N4RUwy?=
 =?utf-8?B?bjRobTRHbXhMbS8yMHV6ZnJKZHgraGt1UVFYL2hLelR1UG04N1owT2dxa3RP?=
 =?utf-8?B?UkhzbU1WU21yU3hKM1NjZkJNZnZYc05oM0lYb2taeVdOcGFNVHE1bmZaQlhw?=
 =?utf-8?B?emhmckk2TU1ldklRcXpqSm41SzZldXZFeHMvM1cwdXpjUFVnOU1sUjdRS2Jx?=
 =?utf-8?B?SHRneURMOGwzRUVwVmhCa3BXMFBTaXE3eWxta1YrL2tMWmdKZ3pYVFhvWkhp?=
 =?utf-8?Q?ops6YPEWHjeuwcgWqMF1EOQLFnWJ6M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnA1c3RmRXZHUmhqTzlNcTFSVFVNazNFNXpkK0JIa2ppRW1GeDdUdVF6SUoy?=
 =?utf-8?B?c21RbVFsTVdMOThoOEZlUU5Qd0R4SzRhb3BQLzdDdE9yK3ZMRjBqeGFKYS9X?=
 =?utf-8?B?TStqeGhLUW4zOXhOZTU3ZFo5dGhicHYrWUx0bmJkWG1WcllRZXRuRWJ4OSs1?=
 =?utf-8?B?dGI3L0doTDF6dXpOV3ExQnVEU2hyeUdqbHlidFNQMEtUUTFxcTJ4b3hEeTlC?=
 =?utf-8?B?bDZqa2NFMFpnNkZMdW13WGpMOEcya1Fwck1SM25VZyt5TEMzVnRMbmUyMklp?=
 =?utf-8?B?Sk55bllONnJsWll5RC85SkFWWVpMd09UdjM5YTd3ODB4eHBLZGt4VENoQlly?=
 =?utf-8?B?MVVlMjI2Uk85V0syL2UzdkFXNTJTL1hORm9EV28rTVNvUkxTQVhjY3VWa3No?=
 =?utf-8?B?UjkraFRDNXgxa295K2Y5RXdPRzdTdjFoWUg0djhiV1BKY0FPY2dkSFdJRW9D?=
 =?utf-8?B?bUJhTkJJSDM3OE02ZERKNnlLcGlJTERlT1hoc08yTTlFell0VlptOTVJbEdL?=
 =?utf-8?B?MisrVXF3elBjZG5neHl5YVZKMU1wQVJWSWVxbkFOcHhvbmNJZHcxY1lxMkZQ?=
 =?utf-8?B?RHlrd0NZVmtFTjh6M0FRdlBpUGx5THpVVENIZnJHVnRHaHkyK1gwV21KcHZv?=
 =?utf-8?B?ZE5oS1dDeG9nNWg5TitrZytLRkVHRThieGlCamJFVG5kU1pGZjZqSWhPNUR0?=
 =?utf-8?B?dWt3Z0FmVzJQSXZXQndzc0ZndnBHZy9kS1hUall6RStna1VKWGRBRnhXK3Qy?=
 =?utf-8?B?NTAvVUxRcHptQjI0MHdMT1hJTkszV0diNTN1N1FRSFo3SnBBNGNBaE9JVlN1?=
 =?utf-8?B?THMzaWQ3RnR6ODYyZ0R2emdQcVVaMEg4UGlzQWYrNnduTkh2YjdaRG5yck9C?=
 =?utf-8?B?dWI1Y1NTRm5WZC85UXQ0MytRZFJMM3k4dzB0YWhBZmZwSG5ORThwdVIreDF0?=
 =?utf-8?B?OW44aFI5dUl6b1ZuTVNuQ1VLSVNYT0wvVU14OHk5OW1QU1Y3RFl2a0xSaFor?=
 =?utf-8?B?UWpFQVEzSDUwSGJMSndXSXJYQ0ZKcW5WT2hXc2pjaU1FVWs5Zm5NQkhSOXlH?=
 =?utf-8?B?M1phQ05NQ2J1ZFE4L01xcFBlcU9IMEdsUFdWU3Y4cUJrSkk2dVpubWExRkNO?=
 =?utf-8?B?NEZObTdlNUJ0aE9xa3JlRmJNUFloOGxjaG56N01tN1lMVE5oSFZrYmszNG9r?=
 =?utf-8?B?c09ZY2p3NEs5TWpBamFzTmFGSmQreER6L2UzcFlhSmhHZE93ZjFtRzV3UkFa?=
 =?utf-8?B?R1A2bTYvc1gzK1ZIbkZHejVyUlNFODF4S3gwczRSMXBsT3dhejJ5OU1NVWFS?=
 =?utf-8?B?TDFOb05iVFBtdHBrSlhwUUNKSENHUE1BZTQxenVhWlRYRCtxb0pMSVRkQ2lp?=
 =?utf-8?B?aVR1SGVWUzdnV0xLdXZWS2hsOUNqN3FXMEQ0d1FZY2s1eUNYTTJHdXJsZnU0?=
 =?utf-8?B?TkZrZ0VDcEJkV252cWNaL0Y0OXJrN2VBYnQ1TWZBNkRhODE5U2hJU3YxNUxy?=
 =?utf-8?B?RFBYejMrQTBabkhSK0FKNExDRE9sTlhMMHpxZ0d4NURnQ3E3UDZzVDZ3aEVF?=
 =?utf-8?B?ZGZqR1VCRzg1K0dSUHhWUXlTWmxQNWlzNWRNTWV6ak4zUzc0ZDdNN1NjZEI5?=
 =?utf-8?B?T2dIUDNYSkdXREJGMHJDVkl6TE83Nm9WR25XZ2xwUjdlejllTWQ0YzFRTGo1?=
 =?utf-8?B?Zk12M01wZnpvUE1ZRk9TUGhVdVczVmludWlkSHA0Q0lERFVmMDRQOTZjOEZs?=
 =?utf-8?B?N0p3eHRBTzR1RWV5SXFzNWg1RFF6WGxQYkxzdWlLT0xOZ3pMaFBQWkNEL1Z6?=
 =?utf-8?B?UHNxVFJrQy9HZHE5bmhYZnIvRWRzS2Z6WkJtaThOZ0RMdjR5ZkRvWXNkS2RV?=
 =?utf-8?B?UG9TaXh4SXQxUXljdHYrTjZzNW5VaDhqUldvbjJ2MnMwdEdQN29iK2VOTGcy?=
 =?utf-8?B?TG9mVThmUlkvdTJoTUVnK2QzYmFlSnJlZU5pVGxrWjNRTFI4N3NBOERzNWEr?=
 =?utf-8?B?dThkYzNxcHpESFZoYzBPalk0WWF4cEFoNmp2MnlnK0IwMDBSUnVNbGFmUWVR?=
 =?utf-8?B?eC9zRWF5bzYvVUJrbUdwTlZ6N1JHOGh0RXJhNHRMemNMTTFuYkpPNVF3alMy?=
 =?utf-8?B?Yi9nUHJGTnFZSG01R1BkZndXQkFYZmc2ZUttM3JNNHpZS3FOcHBRY1BTSXJK?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79ae39d-546f-4258-e0cc-08dd7b6fa824
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 16:16:04.8632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGnoXot3A47vIOwlvs4XRFZxIfkWpZL0WdJUKxPX4UTyxG5qV8eiJhEl9ARAYyFwo0BaYaaSXrpWTgp9rRbhT2WefWk+sMhTOO7u1fiKaZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7394
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYgT2YNCj4gVGhv
bWFzIFdlacOfc2NodWgNCj4gU2VudDogTW9uZGF5LCBBcHJpbCAxNCwgMjAyNSAxMDoyNiBBTQ0K
PiBUbzogSmVmZiBKb2huc29uIDxqam9obnNvbkBrZXJuZWwub3JnPjsgTG9pYyBQb3VsYWluDQo+
IDxsb2ljLnBvdWxhaW5AbGluYXJvLm9yZz47IEJyaWFuIE5vcnJpcyA8YnJpYW5ub3JyaXNAY2hy
b21pdW0ub3JnPjsNCj4gRnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjb0Bkb2xjaW5pLml0Pjsg
Tmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0c3pl
bCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IEFuZHJldyBM
dW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+Ow0KPiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRh
dmVtbG9mdC5uZXQ+OyBEdW1hemV0LCBFcmljDQo+IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFr
dWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pDQo+IDxwYWJlbmlAcmVk
aGF0LmNvbT47IFNhZWVkIE1haGFtZWVkIDxzYWVlZG1AbnZpZGlhLmNvbT47IExlb24NCj4gUm9t
YW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPjsgVGFyaXEgVG91a2FuIDx0YXJpcXRAbnZpZGlhLmNv
bT4NCj4gQ2M6IGF0aDEwa0BsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBhdGgxMWtAbGlzdHMuaW5mcmFkZWFkLm9yZzsgYXRoMTJrQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+IHdjbjM2eHhAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtd2lyZWxl
c3NAdmdlci5rZXJuZWwub3JnOyBpbnRlbC13aXJlZC0NCj4gbGFuQGxpc3RzLm9zdW9zbC5vcmc7
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOw0KPiBU
aG9tYXMgV2Vpw59zY2h1aCA8dGhvbWFzLndlaXNzc2NodWhAbGludXRyb25peC5kZT4NCj4gU3Vi
amVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IDMvN10gd2lmaTogYXRoMTJr
OiBEb24ndCB1c2UgJXBLDQo+IHRocm91Z2ggcHJpbnRrDQo+IA0KPiBJbiB0aGUgcGFzdCAlcEsg
d2FzIHByZWZlcmFibGUgdG8gJXAgYXMgaXQgd291bGQgbm90IGxlYWsgcmF3IHBvaW50ZXIgdmFs
dWVzDQo+IGludG8gdGhlIGtlcm5lbCBsb2cuDQo+IFNpbmNlIGNvbW1pdCBhZDY3Yjc0ZDI0Njkg
KCJwcmludGs6IGhhc2ggYWRkcmVzc2VzIHByaW50ZWQgd2l0aCAlcCIpIHRoZQ0KPiByZWd1bGFy
ICVwIGhhcyBiZWVuIGltcHJvdmVkIHRvIGF2b2lkIHRoaXMgaXNzdWUuDQo+IEZ1cnRoZXJtb3Jl
LCByZXN0cmljdGVkIHBvaW50ZXJzICgiJXBLIikgd2VyZSBuZXZlciBtZWFudCB0byBiZSB1c2Vk
DQo+IHRocm91Z2ggcHJpbnRrKCkuIFRoZXkgY2FuIHN0aWxsIHVuaW50ZW50aW9uYWxseSBsZWFr
IHJhdyBwb2ludGVycyBvciBhY3F1aXJlDQo+IHNsZWVwaW5nIGxvb2tzIGluIGF0b21pYyBjb250
ZXh0cy4NCj4gDQo+IFN3aXRjaCB0byB0aGUgcmVndWxhciBwb2ludGVyIGZvcm1hdHRpbmcgd2hp
Y2ggaXMgc2FmZXIgYW5kIGVhc2llciB0byByZWFzb24NCj4gYWJvdXQuDQo+IFRoZXJlIGFyZSBz
dGlsbCBhIGZldyB1c2VycyBvZiAlcEsgbGVmdCwgYnV0IHRoZXNlIHVzZSBpdCB0aHJvdWdoIHNl
cV9maWxlLCBmb3INCj4gd2hpY2ggaXRzIHVzYWdlIGlzIHNhZmUuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBUaG9tYXMgV2Vpw59zY2h1aCA8dGhvbWFzLndlaXNzc2NodWhAbGludXRyb25peC5kZT4N
ClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGlu
dGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTJrL3Rlc3Rt
b2RlLmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0
aDEyay90ZXN0bW9kZS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEyay90ZXN0
bW9kZS5jDQo+IGluZGV4DQo+IDE4ZDU2YTk3NmRjNzRjNGY2ZWFiODdlMzU4YzE0ZDRmYWVhNjQ4
ZTIuLmZiNmFmN2NjZjcxZjQ0YWU0YmQwMWNkDQo+IGU1M2ZiYTM1MjdlZWQwZDJkIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTJrL3Rlc3Rtb2RlLmMNCj4gKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEyay90ZXN0bW9kZS5jDQo+IEBAIC05Nyw3
ICs5Nyw3IEBAIHZvaWQgYXRoMTJrX3RtX3Byb2Nlc3NfZXZlbnQoc3RydWN0IGF0aDEya19iYXNl
DQo+ICphYiwgdTMyIGNtZF9pZCwNCj4gIAl1OCBjb25zdCAqYnVmX3BvczsNCj4gDQo+ICAJYXRo
MTJrX2RiZyhhYiwgQVRIMTJLX0RCR19URVNUTU9ERSwNCj4gLQkJICAgInRlc3Rtb2RlIGV2ZW50
IHdtaSBjbWRfaWQgJWQgZnRtIGV2ZW50IG1zZyAlcEsNCj4gZGF0YWxlbiAlZFxuIiwNCj4gKwkJ
ICAgInRlc3Rtb2RlIGV2ZW50IHdtaSBjbWRfaWQgJWQgZnRtIGV2ZW50IG1zZyAlcCBkYXRhbGVu
DQo+ICVkXG4iLA0KPiAgCQkgICBjbWRfaWQsIGZ0bV9tc2csIGxlbmd0aCk7DQo+ICAJYXRoMTJr
X2RiZ19kdW1wKGFiLCBBVEgxMktfREJHX1RFU1RNT0RFLCBOVUxMLCAiIiwgZnRtX21zZywNCj4g
bGVuZ3RoKTsNCj4gIAlwZGV2X2lkID0gRFBfSFcyU1dfTUFDSUQobGUzMl90b19jcHUoZnRtX21z
Zy0NCj4gPnNlZ19oZHIucGRldl9pZCkpOw0KPiBAQCAtMjI3LDcgKzIyNyw3IEBAIHN0YXRpYyBp
bnQgYXRoMTJrX3RtX2NtZF9wcm9jZXNzX2Z0bShzdHJ1Y3QgYXRoMTJrDQo+ICphciwgc3RydWN0
IG5sYXR0ciAqdGJbXSkNCj4gIAlidWZfbGVuID0gbmxhX2xlbih0YltBVEhfVE1fQVRUUl9EQVRB
XSk7DQo+ICAJY21kX2lkID0gV01JX1BERVZfVVRGX0NNRElEOw0KPiAgCWF0aDEya19kYmcoYXIt
PmFiLCBBVEgxMktfREJHX1RFU1RNT0RFLA0KPiAtCQkgICAidGVzdG1vZGUgY21kIHdtaSBjbWRf
aWQgJWQgYnVmICVwSyBidWZfbGVuICVkXG4iLA0KPiArCQkgICAidGVzdG1vZGUgY21kIHdtaSBj
bWRfaWQgJWQgYnVmICVwIGJ1Zl9sZW4gJWRcbiIsDQo+ICAJCSAgIGNtZF9pZCwgYnVmLCBidWZf
bGVuKTsNCj4gIAlhdGgxMmtfZGJnX2R1bXAoYXItPmFiLCBBVEgxMktfREJHX1RFU1RNT0RFLCBO
VUxMLCAiIiwgYnVmLA0KPiBidWZfbGVuKTsNCj4gIAlidWZwb3MgPSBidWY7DQo+IA0KPiAtLQ0K
PiAyLjQ5LjANCg0K

