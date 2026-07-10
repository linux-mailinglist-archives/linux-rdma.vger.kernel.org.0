Return-Path: <linux-rdma+bounces-22997-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +pR3O+7EUGpC4wIAu9opvQ
	(envelope-from <linux-rdma+bounces-22997-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 12:09:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6115C739798
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 12:09:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=aP+y7+2d;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22997-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22997-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FE2B304BD22
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE364028F2;
	Fri, 10 Jul 2026 10:06:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E83FFAC6;
	Fri, 10 Jul 2026 10:06:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677974; cv=fail; b=oAUFidqU8cTdJfieXaMaOfMMZI3ggZZhoSsdILU+fTqEo03i+zE0209nSbv8uUXUXGckuKjQqpbVXlEU/oJBdyhn4tBm6ISiltyPW4zgSw4j8MNXsguof+qdy2czuSUNWR2f+O64MUtbVaVrfaIXvTu97HWM8r4a5EDwXUildA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677974; c=relaxed/simple;
	bh=bW3Uvs/uroGhs/osnWJVHFrxZQMXd/7BtvU3yLacPjw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gCeUzJCB141ChYjbZx6bJr8xTVVqxjRfRyx6gOhI/jW0KGwi9Tpfpkq/nCPpLFiu0L9I/wcizo11t3DrSxTWVLtl7eTyyO8bHtYenisJ08fToAdYeI4clhcdAzqg3t9LjPOXHRKJWNMFhfTbV9k54XHK0WOSw9c/ICgp5z9EEd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aP+y7+2d; arc=fail smtp.client-ip=198.175.65.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783677973; x=1815213973;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bW3Uvs/uroGhs/osnWJVHFrxZQMXd/7BtvU3yLacPjw=;
  b=aP+y7+2dhvMZ9/E+0sBPnQAodHBXStWRdBfvqyi0nLE6dy7R00vP6Q24
   S7dHb5mNtETpvMloQ2ZQAnpdu6JE6T8UWozs96HF+8LPERaENa95XwTs1
   POj8ZP9Gns9Rp/zjqv4wuq8IEHJeTaqLxGUCDnBWAn3ERpc3071G8v5bt
   whCzcOQ3Ot0qyGiH1nDs+WkRP+RF5UYkxqChfXWFo0s5mVVS6fUmPtuM9
   dx2fS8q8ncSwfkSBJ38cjdWdvxOEJxt+TOAQbFA/wtqTFJ0chiygIEy51
   DTDNzqZ/9Wo0plo8rBf+xzZ2+ndxYydNhh0QbREqv8scCzHssW3Fu28AG
   A==;
X-CSE-ConnectionGUID: 7QvXYm2YTfulGkzsruI/Zw==
X-CSE-MsgGUID: UbSwbjWmQ/WutRyDlvy1dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95528697"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95528697"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:06:12 -0700
X-CSE-ConnectionGUID: 3QdZy63bQDqAXWBEOpq1Rw==
X-CSE-MsgGUID: ARyzo2lnTU21EU1jA4DBQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="278088531"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 03:06:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:06:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 03:06:11 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 03:06:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZ5aaigL5PYeiJEvIMRgjUtsTaeoJjVp3J4q2yAbbbIDMmdCerN7logQVtSTLZBECudPvDvlh5P+3Jye1Up44O/Ut2Cnzbe0SUsUWNhdQELj34BXpdR1vJog1GHf27AK1Vzik5CaAcvD9SNUxhf2kPCusi+KODPtteZrJZYKskBOxfNVlw1mV1/75HZWZtjACYGLY5V3vxzOuFpN7VJAQiHrngZ6c+wwg8Avm4HBFzwnjW5tQo0bqXlfqsLVJbe7s3B8v5OD0QYbzo6husDSL35ermeV1ZhpZV45afE/FAvhh3O7c0KsqRRD9HaAEAGzePB+3SbR3JhU0Gt92toFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9Cj4U1Ua9JKqutA27Y4LFFMDyhI6IUKnAOY4M8Daf8=;
 b=stdRNr2NDCsrv5gp315louGLiiREgpEjTqC4S4tGXoyhwvk7n3xVswKKxpLseZqB0ds9p8ywZnm2KBtgvBI7VJ3Yz0PtpWVBVbmVyrw6lFumsYqSjhRv4j2svcHjm/AhDUvVorUSUtTLjxZepu1xm/tAUg09yJjxlHW9gs0kx+TE14fxgH4RG01oG1PIf/gMwv8lkqDdokVg6VWKIHIpUSvWWUADQ4MH8QJyPCtNKiR3vUZUmcnnEeKTrLPt2klwBCrijQ8W49Fs3UNo/Z5CknercHmbqYFDJ90CfNUF1ma67tpfZYz3hYhQkZ2bdzL+dVHup8Eu06ADnOBVLp2GmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SJ1PR11MB6276.namprd11.prod.outlook.com (2603:10b6:a03:455::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 10:06:07 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 10:06:06 +0000
Message-ID: <c108a5ec-8740-431e-849d-581c136f404d@intel.com>
Date: Fri, 10 Jul 2026 12:06:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bnge/bng_re: fix ring ID widths
To: Vikas Gupta <vikas.gupta@broadcom.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <jgg@nvidia.com>,
	<bhargava.marreddy@broadcom.com>, <rahul-rg.gupta@broadcom.com>,
	<vsrama-krishna.nemani@broadcom.com>, <rajashekar.hudumula@broadcom.com>,
	<ajit.khaparde@broadcom.com>, Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>, "Yendapally Reddy Dhananjaya
 Reddy" <yendapally.reddy@broadcom.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
References: <20260704164747.1995227-1-vikas.gupta@broadcom.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260704164747.1995227-1-vikas.gupta@broadcom.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::10) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SJ1PR11MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 560b7725-96b0-43f9-9c60-08dede6adbc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|23010399003|376014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: T0rFOSkn99Ncg1RbXbtWKJRax/TuCzXaOq6nJU/nMI8UeZxMTAo9fnFnBLnz1NmO5jSu7YS4eZpziYWBTMXnJAKCdxkS8tTe+qysa0CP91Q/VlFrnZY2REzTJZhyII2DKz6GmLfnIcakLl1ZeiU2+gQjvZFv8rgBG1ft/CoMkfcdHwprfpSQ/SmUNAixzHTpPvI2ZA0GtGhQbLAgjl9lo8JbzLEVqjJVJitXoOBDPU3+5UrakRl7zoutcvHE3qzFVcauautqTcCkxAugn1Xem2b/AUToCPrCxanmx/XFIrHCsxytooqTHUbAW8SicRKicOm+dGOyNdUbIy5f3BF5IBpnz1Ur2JPDAmZ+TCuDVhPLyBWUgDFIpJ0uQg8nTUrLEP79lW6zT2aQADIZ8Cp1OliiPZVgqMd1eUj3jN+OxP39qsy5k+cMlLovAA9+dtzGJJpKzgIV1XO2mjjxEvaWEXRN2CiWWqCoFW+z9w6s0C+cUpouOgXCqYoloveTK/XykpbgYyIlEOHGMoW4Zqz7bWIDSD3XG7QGH91wFaLDHgBSubwUWa4PsafFnjTmy13Q6U/BmAt18pQgfaGz+k6501ndard09LwMssX/8sLEfzxOfAW5I8joRL95jjhhz5a669kv9yFXMErnnStxBGSTCrs3SrajYjNOTUAS3DteNd4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDFvUFd2SXFmUTNteEVjd28xRGVZRml2WmlDR2VMQUdMTGprWDdsTFNCRUlH?=
 =?utf-8?B?QlhqRXdySktZSzhmMlY4V1MyM1QzNVJVOVFxZCs2ektrY3F1Qzh4d2hyQng2?=
 =?utf-8?B?R2V2NVBvaFh2cU02Vi9UK3MvVlJLQUZxemRzUlFpM0NIaGpDVklhMnFMdFAx?=
 =?utf-8?B?NDRHZnJENWF5YmdvTnFjNWNtbkg2dWpSVElaM0tjTHJKYUNiOFk4Zno5TWUw?=
 =?utf-8?B?bzJxdWZvUDR6SXdBSDFhWmx4WlJOK3cxck1ONmU2YXRTR2NPeHBKUk9JaUlH?=
 =?utf-8?B?c0Y5OXdGQlFDMjZSNWZaZjlJZFo0UkNhbmo5dC9OZEpNcE1GMllHVUltendG?=
 =?utf-8?B?M1RIekQyT25iSUI1ZjNtdkZyUWl6K0E5TlhVV3lvVys2NGN2d2RPNDc5Y2xY?=
 =?utf-8?B?SzNIZ0N5bmVJSFYyclJEM1p1bWlSdXhIa2loKzhJcENvbXU3NXhleDdtdDYx?=
 =?utf-8?B?cDdUaGlETFRXZXB0ekV6OFhjVjBRWU1IREZaK3hJaUxyT3NMMTNKbGJTMjkx?=
 =?utf-8?B?blhlajlnYU9RQys3eVZkZXpJYng1VXlJcDRENU5STzNHUXNmSW84YmJVZXVN?=
 =?utf-8?B?S0FBeVRGZTFlelV6enVoVmJlYWo1akxwMitiYkkxbHUvNnQ2MnZaaDV6eDhr?=
 =?utf-8?B?Nkl6TUFBSVlGQzJCa0lId3JWY2hlemRDbVlCUEZxOFJVVFpVSm9kajF3Y3Ft?=
 =?utf-8?B?ejlLRUd0aFVHOXNQUlF4c3YzOFNYOTZHNEg2LzhLUldKTHhZaC9vR3U4OUwy?=
 =?utf-8?B?OTVnLzlJenlLSkNjNnFNQTFVUU9JUm11b094U1dPWlQ2SW04SGpSeG1RUXhw?=
 =?utf-8?B?aGF1d21mQVRTTldEOVhRZlhiZGFySlp0MjRaSjRhMXlkVFNIUnAzWXl2dnRW?=
 =?utf-8?B?NlZ2RHZjOExzSWwrSEYybHhqU3hWdTdNOXhCa3UxbllEWDdlaXN1alZSSWdW?=
 =?utf-8?B?d1BGNkJ5V0Fmd2hSTjRqcm1XMU9QL2lzb1pUVnNNVmpCRzUrUnJkTUNWdUZM?=
 =?utf-8?B?by9pT1FNZzVGWldNUzQwRjZuVjVhZWVSTUZ5RWVZdXVoMWVNYWpHdFhIVVFp?=
 =?utf-8?B?NTdkNFBYeWZvNUlINUJZaWlsMjYvTStaNzNnV1BoQ3NnR3NhNkRsa2IyS3hX?=
 =?utf-8?B?SHFHQWRUSXdjWmtuTXFRRm9MM0hEbTZvelMwcnpweUJpdlczUlI5UE1FK0hj?=
 =?utf-8?B?K2tHeFFmT09UYld4VVRSc3FFOGlHTlR0M0Q2RHNONmIybTBLODcvdEt5VWh0?=
 =?utf-8?B?eDR6bXd2K3JzTUExV3o2SWVHQ3RhT1AwNkhQWTZMaXBRVExpandJR0UxYyti?=
 =?utf-8?B?MEVqQ0p2Zjd1Qjl4U2lROFIyTHFNZXVWYUJ4NXBvZ0thU1Y3YXhtRVEyT2Rn?=
 =?utf-8?B?V0VVeWx2ZUh0Zk0rSWRHZGdrVHdJTGhRVy9YcDdSUXdXN1J0MkcyWVdVYXAy?=
 =?utf-8?B?aFJoVGttTlNjTzNDSlJvZEx0Wi9lekFzNWs1a2x6UDA1M2lFM0NYY3VXazNO?=
 =?utf-8?B?V1IyelZJSkt4a3RmaEgvSDIwaUFVYUo2TFM1bHpZZGQvTDduQjRqL2JRZzdN?=
 =?utf-8?B?emJXL3p1NjZWNnpmVnU1NnROMktYbTdjNlVoeXQ4NFljNHNHdDB6VjVsUUFv?=
 =?utf-8?B?VE5tKzdZYzIvcmJiMncvWnc0OE9NYk1WRmFDc2kxaW40OE53cjFrU1VXU3o1?=
 =?utf-8?B?TTZmVExxS0RleXBjMkF5S1NqVVlhRXIxWEtsbjBxbU9ST1dZTFplbTVkU2Fz?=
 =?utf-8?B?UFJDR1pUM3cvc1pLdXNQbFdhdGNFMDFLbjZnNnE3NXNkaTJNZDNYMUFOazV1?=
 =?utf-8?B?NzJjNmNyWXgxajdYRlVXbWdaY0JhRzBGN0ordmtuSGJQQ21LeDhFbTV5VCth?=
 =?utf-8?B?Rk9aeU03cWh0OFdzRHVIZkJxK3BjQTZKL3RZbjlKYnA0V2hGZ21jZXlSa21i?=
 =?utf-8?B?YTIwR1pVY2FIY29oY1FMTWhvZnZpb3p1T1AyOHJycStNRlVyVGc1VnZLeFRl?=
 =?utf-8?B?MjFUZ2dVbjFiZUc0QTRFRnBDOEpuU1EzR0duRDlaaytma2hBOHhtSUNvaVJM?=
 =?utf-8?B?Q29NSzZQZDJqdHZrclM0MW0xd3hyMnBsOHRYV1REcWkyZGNDaDFlejNoL1dk?=
 =?utf-8?B?Yy9hNnllK0puaW1tMG9GUUZELzhqOWJOcjBUckExQ25JYkpsS2NGSXN3alJK?=
 =?utf-8?B?NTJtd0xlbkttakZGOTF1aURBc1g5bEFLcDdWNitYZ0xmUVUvTmtockFMOXdw?=
 =?utf-8?B?U2tGYW9tc1YvdUh3Z1lPdzQ0Qk45SndUajZpRFQ1UlpZZnBjTDdQb2dGek9n?=
 =?utf-8?B?Mms4ZXRMVEw1U1p3Qlk0Wk1CK3RvOU0yQWhUYTNXVGNRZDBtalgwUzBDYlBK?=
 =?utf-8?Q?VScrLpk491wjiLN8=3D?=
X-Exchange-RoutingPolicyChecked: Vakct5txTXa7GPgmijZAcIyAbvZmP4eTz36Gzz3H6MPBo8EK/jZVUf/i/y3OFm8OkBZxtP++L7Z9Vn71Gbaif3XdDLODEnVt4BiPtis+tAdhYztJt7a2IoIwwmLXIIPx+rz6ReEngJlYtRAFbzDbRQPUqenlgEUFKwigwYbD3gookwG3ChRbOvExpdCluUZbOotOXZtzt3LyG9sGjbla4U4Spoyxt5G2mJazSNkuOmECSwK/l9v2dSoSmDhAd7s6QzOKY7Z9whqX0pbYbMxR3xYaxnZgu+zIvwqMIWl4k3xW22YryVv1iwaDCF58iTkb+ii2iJidRdg52Yyg5uIU4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 560b7725-96b0-43f9-9c60-08dede6adbc3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:06:06.9240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8ol+ms3TRMXsRAsNvB3ZBLDY90103VRo2SFRhRL7OUz8v4ooyxktMA+sR2mdYvissr/UF+mAapGCzV7ChV0Az6kSxrA9ZQOJb7ILUc0cRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6276
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22997-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[przemyslaw.kitszel@intel.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vikas.gupta@broadcom.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:leonro@nvidia.com,m:jgg@nvidia.com,m:bhargava.marreddy@broadcom.com,m:rahul-rg.gupta@broadcom.com,m:vsrama-krishna.nemani@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:ajit.khaparde@broadcom.com,m:siva.kallam@broadcom.com,m:dharmender.garg@broadcom.com,m:yendapally.reddy@broadcom.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim,intel.com:mid];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6115C739798

On 7/4/26 18:47, Vikas Gupta wrote:
> Firmware requires more than 16 bits to address TX ring IDs for its
> internal QP management. Widen the associated HSI ring ID fields to
> 32 bits. The values firmware assigns remain within 24 bits, bounded
> by the hardware doorbell XID field.
> 
> RX, completion, and NQ ring IDs are unaffected and remain 16-bit.

Here you mention Rx is unaffected. But you touch multiple places that
are Rx specific (some comments below).

[..]

> --- a/drivers/net/ethernet/broadcom/bnge/bnge.h
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
> @@ -36,6 +36,7 @@ struct bnge_pf_info {
>   };
>   
>   #define INVALID_HW_RING_ID      ((u16)-1)
> +#define INVALID_HW_RING_ID_32BIT	(U32_MAX)

OK, there is much more usage of INVALID_HW_RING_ID than places touched
by this patch.

[...]

> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
> @@ -1327,12 +1327,12 @@ static int bnge_alloc_core(struct bnge_net *bn)
>   	return rc;
>   }
>   
> -u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr)
> +u32 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr)

and here you change Rx ring ID width.

>   {
>   	return rxr->rx_cpr->ring_struct.fw_ring_id;
>   }
>   
> -u16 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr)
> +u32 bnge_cp_ring_for_tx(struct bnge_tx_ring_info *txr)
>   {
>   	return txr->tx_cpr->ring_struct.fw_ring_id;
>   }
> @@ -1375,12 +1375,12 @@ static void bnge_init_nq_tree(struct bnge_net *bn)
>   		struct bnge_nq_ring_info *nqr = &bn->bnapi[i]->nq_ring;
>   		struct bnge_ring_struct *ring = &nqr->ring_struct;
>   
> -		ring->fw_ring_id = INVALID_HW_RING_ID;
> +		ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
>   		for (j = 0; j < nqr->cp_ring_count; j++) {
>   			struct bnge_cp_ring_info *cpr = &nqr->cp_ring_arr[j];
>   
>   			ring = &cpr->ring_struct;
> -			ring->fw_ring_id = INVALID_HW_RING_ID;
> +			ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
>   		}
>   	}
>   }
> @@ -1637,7 +1637,7 @@ static void bnge_init_one_rx_ring_rxbd(struct bnge_net *bn,

ditto Rx

>   
>   	ring = &rxr->rx_ring_struct;
>   	bnge_init_rxbd_pages(ring, type);
> -	ring->fw_ring_id = INVALID_HW_RING_ID;
> +	ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
>   }
>   
>   static void bnge_init_one_agg_ring_rxbd(struct bnge_net *bn,
> @@ -1647,7 +1647,7 @@ static void bnge_init_one_agg_ring_rxbd(struct bnge_net *bn,

ditto Rx, and in some other places too

