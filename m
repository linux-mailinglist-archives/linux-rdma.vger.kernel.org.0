Return-Path: <linux-rdma+bounces-9510-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB956A91801
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 11:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B403C3B34C3
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 09:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39C3226165;
	Thu, 17 Apr 2025 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="freJbo+Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D715F41F;
	Thu, 17 Apr 2025 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744882424; cv=fail; b=FPo1omfsUvDVd6Az5v4cuk1hUvwGlqqj210OJ2fKgBC+ZwqqiuYxNZDXPf8eVwWpsrDf4hlXxRkOZHRLkt/l5eFEQQTSNYn2bOHtZzyat+a6djKTENJAp1ZHaABxneYeU0IIQ5f5gqG5eRItdFd5YYiirPq9wRuJGDlPBr5Z11c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744882424; c=relaxed/simple;
	bh=nYeXFTgV9RcecnSTl/7Pw1nf0BkrLVUmCvSBS2d/noo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J0Aoih0xEY0XvDVlwl/P1F+M35h5WtQQI++MKwrks3fnMOMvPku+84tZwVr0Q7qvfrYhP51FU0etMNV/QeFgcMLs0w8o4OOhM6rsnmTiO+Msxojp/rwAWOtPcdujDGQsFIFBRRN4z1dS3pdGjcXqYWDiwlrohZbRC94JAbQdqiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=freJbo+Y; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744882422; x=1776418422;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nYeXFTgV9RcecnSTl/7Pw1nf0BkrLVUmCvSBS2d/noo=;
  b=freJbo+Yyu+i+3MmeKaL/hMX8MzdrpvieN29Sup84/LilyEvumJqWbOr
   tDVkh+ac+4YUnYL6pd+syTQAvpNQzybRyh/Z1b9QtzrkC3tSH+bhnID0v
   Xp3fSMVFVLunpdbrWR3phW3feDqQW9CrjpT5h86Bckd2YsqNqGnmw4iVm
   7UuAAHz/Zd2et5+27Nwx/2HpzueBnGr/tRhotzNNC/1rS1AMVkbUxQoXd
   U1axx3uPRwuGHLNuf27CG1z7bU72MP8vALI8mv7F7KlM9Bk8DfN+wnojn
   QMmdK2ZeSlnLhNCEu7EZ+nv2XtvtS45Qwa3QeH0+WU8e9Ftjiy7HF9pBV
   g==;
X-CSE-ConnectionGUID: EvtwP4itQHWE4s5Y4pISWg==
X-CSE-MsgGUID: HCmBAcfvS4yn1KAZEoyIAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="63997909"
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="63997909"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 02:33:32 -0700
X-CSE-ConnectionGUID: xojDZub8TMGpur6hWAdAgA==
X-CSE-MsgGUID: NDGXWMJNTb2R9ekQql4jQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="161796413"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 02:33:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 02:33:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 02:33:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 02:33:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWd1SG7ouS00FvaoWhFu8W7GPF70kPhknQNQgE5DSAQRPAq6HrtQ8TWBEWl2kgLqmN5W/bonp1f77r+NnyqQncyK4QlHeu127jLds1G9+oDFngGMhAiQArN1dcQGGk/QutqDVHiSF3CJ0eHxYTZL3H0Om6VFTsrzfnliBUfjtGpZuO45J9uqcKltE/0m32nWXIOZplykdu1x2HwWizcpidCY6dchojcO993Ge6FFc+SBCms5lHStrIccUQMJQW/S4vorDfKabAMXRdqB1KwBE/CueGhWLBJO5hIMC5T7R76LMWF+XAxKA7cgXeX0uTB2laszeTp3Hth1qdL1T0yNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhueWJUuQoWMXQBNcaXhkdg3LdkrZsNbOP+yziQ0DfQ=;
 b=P/XXCjcRFJ1TAZup0EtonMtkTB4O0YAkj4SNfHqWfkm3IUUwxaYSdX68hJlbErI0hcuQ51dgACuYQmDucKTvIAKK2LZs31xwC7T/MiKXq8laDYttJ/Sh8gL/rz0GrshcUkt2y3s3Q09sNOTEuv9KXVRGFnHNuWcZ/SMCDaMj+FFsophazwxD6ZIQAj6Ae5kRp/b+qCTG4xryq/xGnwBEJUZl5a9m8+Zjfk5mTlMX/UNOWAgFCDdwDofjQnTLQGvBq41I+zar2oU+VwrBylDj+4jBbXskVlg18pcL9De9WDp4/083ul+fbIhH3eYnRtqhxh6OtVDTBKd1SasCzc6auQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22)
 by IA3PR11MB9400.namprd11.prod.outlook.com (2603:10b6:208:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 09:33:14 +0000
Received: from SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38]) by SJ2PR11MB8452.namprd11.prod.outlook.com
 ([fe80::d200:bfac:918a:1a38%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 09:33:13 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "donald.hunter@gmail.com" <donald.hunter@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "Dumazet,
 Eric" <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Olech, Milena" <milena.olech@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH net-next v2 1/4] dpll: use struct dpll_device_info for
 dpll registration
Thread-Topic: [PATCH net-next v2 1/4] dpll: use struct dpll_device_info for
 dpll registration
Thread-Index: AQHbrjNlBVggsGiidUqSYEyB0X0N67OmNXEAgAFiVLA=
Date: Thu, 17 Apr 2025 09:33:13 +0000
Message-ID: <SJ2PR11MB84526DB089614BD2972F6BA49BBC2@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250415181543.1072342-1-arkadiusz.kubalewski@intel.com>
 <20250415181543.1072342-2-arkadiusz.kubalewski@intel.com>
 <zurfm4rox22l3dnffbfloax5mu6csiycqqfoyh5nrcsd4ada6h@wmeh5ks4gli6>
In-Reply-To: <zurfm4rox22l3dnffbfloax5mu6csiycqqfoyh5nrcsd4ada6h@wmeh5ks4gli6>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8452:EE_|IA3PR11MB9400:EE_
x-ms-office365-filtering-correlation-id: 236fc2ec-c6aa-434e-14ee-08dd7d92e047
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ovvKX83VBEXFJV8vSk6rx8w371Fj3jw1huV+xww/Q11KvZvHO1E5EsXqWQ9j?=
 =?us-ascii?Q?k/yRXD+MbETAWNTNyyRhWmF79yHEiX748cD/V30/Z/8Cj7lrpza4o8X8qR+m?=
 =?us-ascii?Q?+qKx0hQev8lW30MNK23wLTNR5BZ4dLAeEPVGM56lXXW8rVJ46hAFD9TLZfRU?=
 =?us-ascii?Q?yBrGEsVIJUttExnY2YcMNbeDBG+zoxMyHx6ksJ6pmCxQ6C6dGsYp/ua90tsY?=
 =?us-ascii?Q?FNlgtl2wFGwGAe1CD1vMGs/Gp47SjwDkijgdkVALQdQJCJMPzhC4urg/cKkv?=
 =?us-ascii?Q?Of8jAKQ3y0/yyLk3bj7wQb39WseK7XBATB52uaZVDjOZVKBBZzNaquB3S4Bf?=
 =?us-ascii?Q?as+aHRkOxZrZPIvzyDb8kfubSYZmh7aiZOriUoKhO1WAEH8vXjJMwrWGaFxZ?=
 =?us-ascii?Q?+ZGfzFBtA7rwBJzYlG1675tZQVPF9LrpRjsVj2cu1jd4hMT7/s6+kUgRYagP?=
 =?us-ascii?Q?NiH7rN5wJXfZ0cQZUvy13ZLeQw8LTpQ900aa88WCYq72m0Ut5ZUdvHLhNvGz?=
 =?us-ascii?Q?2JRznDfXQBhAg3DFWeQLvJimcxQJEMTDLXpnL3c+ZR25/X+tBQz6S6Q8soZZ?=
 =?us-ascii?Q?DF/eE8cH1X5tiY5S9nre4X712N5i/fJYVYQs8KG8+vMFi84MNn3KLuxcXWez?=
 =?us-ascii?Q?9CxYb/umF5LeRs515Yqiv5HJl06Yf0U8GURD0R+63GNu5fpS0j4VkwFBFj77?=
 =?us-ascii?Q?hJ8rm12uyIsz5hkJwUd/8BMnIx0lK6IshfxdXDfB0lbt0rj2KvFJZwilFbeB?=
 =?us-ascii?Q?Rp+xAonmYuODgnTi/NfcC2Tx8iKY0LUAxUbBVP3G1buM3C14MSoxA5RxTfGI?=
 =?us-ascii?Q?+6c/psMpkvRHjk7+gd99Su1X4+v0f3nOEtft6GJnaPlh93f8JDX1is8hW4QC?=
 =?us-ascii?Q?dMTU8v4JRSobNH804jne7bBHyUWV6I6G2qghpiV0hP7aQJNRJuxAOB8hMwZp?=
 =?us-ascii?Q?zCxodPPBKkdm2BOoGub2r3sabX/eCgHK9ItsgQYqxQE3OI/FA9GSIzADMQyf?=
 =?us-ascii?Q?mFzVEkQrp3sJJDFn0NZWRZUwntTD1zqW5CQFfsXWfHzwpUNtPA5kDwEUmgl8?=
 =?us-ascii?Q?dBdMgJIPGs0SLblB3lSf65Hd+i77KPobp5lZDEbjmEm+YC9xedgm/e6wEUk2?=
 =?us-ascii?Q?y3nEgJTbk51ThIKtsZapawvO0vAFIu4jlej3Qhv+O6FBj1REJdvCfVdCVO+A?=
 =?us-ascii?Q?A3fVA5A4YD5RfmxCWQnHiguC5mTpYJW9r2QACuX6ky4Wf4OFa34nmJrVgOZN?=
 =?us-ascii?Q?HQLPw9LKA1ZYKlI/sZZrp9uWjAX48EUpGYAaQtZaZlT+M+B8RRF2/H0xPPjr?=
 =?us-ascii?Q?1983xipUDbM1Za08kLcg6uaREHR6qNZwLvxUvMWZ6B9dIeS9W1XJRmxOPAgI?=
 =?us-ascii?Q?fax8jroq/z/dHWxDSbpJ/OwU8bSwU8l0BmvZSL8dRNk2lk+/ATzPBZ3r0BqY?=
 =?us-ascii?Q?KrrlP6qbNpO3QB/QZeU3D5iJQJY+MI4/KUaOALpuha1OBIobDfL9kw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8452.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7prgrGN7pNqGmQNh6g3y6BZHqGIc4CI7zfeB8VNDF+0U/b8UkLt/Rw9l6OE9?=
 =?us-ascii?Q?p98FU/2EPbTTO1wcYO9KdLvPuNBBkV73wffTvBwtF+z2YauD+PiVdyRy3nus?=
 =?us-ascii?Q?xYTGKwrP3qV+gC3Oco6bi3dt81gvADnl19Dr9QuBPx+JREboc2GPxV0aZShJ?=
 =?us-ascii?Q?MFQpjYpfGc33MZAdTReMBjfcBrRRcFGxOCjF4sswJhY7r0kyMntHY9q4hFkd?=
 =?us-ascii?Q?HuEj5Dn/w/J4csfgw/nuCPqD5jgw0gq+zUQIRfgaD6sd8BLzYJF8GCdtJkGZ?=
 =?us-ascii?Q?iiYwVknc2wJiixTW10TJhxz3V3Pvmk9OAoRpLv9ciP5bcbsAqGNNhBs4j9Os?=
 =?us-ascii?Q?EAu0NxAFAU/hTLVUmaCDGTi7CtCgua7/7nMfqXa7cqt4EBeElb40XGGR9olK?=
 =?us-ascii?Q?yjSGsR9+qfYqgxoXaYEAhOqRdhzZZkxXlXyeHr87mzmjuunb0q8AIFsgud0n?=
 =?us-ascii?Q?NgHK6/wryYl07MsD5wxKocZ+WQTSP4+rGWcfvgCEHAXQTaedqN/+f96f8gZL?=
 =?us-ascii?Q?MlEpprx7Gw86NF4BomGomW4xdEZ7SPG9vrQIJGdLFEQBA2q2LQJWKSlSsdY3?=
 =?us-ascii?Q?EF+ZubJkhXt1G3iH+B5JFUP8/PoACmsOtPg5rtznwaTWkDvKi4FDYltXxlPq?=
 =?us-ascii?Q?wvfLxBh1YQ81LNryil/X8LEbe89mr5gNmGnP/YTAlCoIxeEgCXa7ioDJe325?=
 =?us-ascii?Q?FZ5o3OuI6EBIcABbjEo4gVsjiLBasEnJe9x/qZkBClmqZcIwLxNlfxdP1N0u?=
 =?us-ascii?Q?hLiAVVfM/L1lnHvBOsJ3TjzgdFc7Q2KWXj/MXqREKHMfZmKdCt6KLpsytFKp?=
 =?us-ascii?Q?X9pXfFEm+OzN3BYphBgq/OWlJiYGC1W2vvf/M45qFtG2gcbEUJBRuLaf1uSY?=
 =?us-ascii?Q?l3alpnt3bRjvP5fkj2vhSOkkXUBBSaNitCEHuf/WhBAf5oCJqFvpSfxELL6n?=
 =?us-ascii?Q?3UoGl3hT9ziJLixvvPUzsPue83jRw/uL4qqP8JyTXgoAp5whIZhrA0rdMbk/?=
 =?us-ascii?Q?tsffgapZDsvseHwBGzwmEvtQFZWDV+9HYijGFGXcmGpJXs/jA1fkLd4glpYo?=
 =?us-ascii?Q?lc7mg/bn8EGTG+W79cSzyTMPLtDovL8KagPWR157UuayGZuGarmrJFQXrsBL?=
 =?us-ascii?Q?BkPKXSdsS155cqBPMz5IUhd8q7+ZxeNxsOsm0jchT8wCLrWsGw1XdUz21eqg?=
 =?us-ascii?Q?27/eWfTyiG2eyHqaQwS1RGO4FhHaOvpd5EwnXKAXXGcieUy2u+2ZRxhJpkPi?=
 =?us-ascii?Q?HPzczdk/0Ja1R1OcBfkYGrc7/IOo+gUO9NQlmwd06i2d5+Y+pRbI2Ov0/g0V?=
 =?us-ascii?Q?oF8RvunRckCgi0ng9lJ8SyqFm4fTb+EI0nM9oI2NW7AzV4S55k01hyh+9Mlc?=
 =?us-ascii?Q?A05OYB+A+qFbhBkdXsKMMX5tEuZo9oG+QtehgYZb+Pxy4sdW+BRqDOIVR3Qe?=
 =?us-ascii?Q?amZRolzfdd3E5lwMgDywxf+lyXv8kn7DKrmqZ5gTgBpkJ5U+/KePpnmfbEih?=
 =?us-ascii?Q?DiWDLutKk+83kkEcFKDVNIyDlrOLklZ91/KasiRIdohuJfJw2ocmBj8QZqNC?=
 =?us-ascii?Q?PbNsf8Rh/sgzfMsl4uVo8sybxFgwwZxFnYIg6M7nMww5j8nsvY4Bl+ahDXBQ?=
 =?us-ascii?Q?ZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8452.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 236fc2ec-c6aa-434e-14ee-08dd7d92e047
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 09:33:13.7644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zG0w7yeE/r0hLP0K1zU1M2WhY831kUtAK1BNWwkVcpFV2uH49+rhpEDvlWW/MR8LuuUeUV1LwTaLdmvacM/p62aP6jHL17ozEuO/99vGnik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9400
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Wednesday, April 16, 2025 2:13 PM
>
>Tue, Apr 15, 2025 at 08:15:40PM +0200, arkadiusz.kubalewski@intel.com
>wrote:
>>Instead of passing list of properties as arguments to
>>dpll_device_register(..) use a dedicated struct.
>>
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>---
>>v2:
>>- new commit
>>---
>> drivers/dpll/dpll_core.c                      | 34 ++++++++++++-------
>> drivers/dpll/dpll_core.h                      |  2 +-
>> drivers/dpll/dpll_netlink.c                   |  7 ++--
>> drivers/net/ethernet/intel/ice/ice_dpll.c     | 16 +++++----
>> drivers/net/ethernet/intel/ice/ice_dpll.h     |  1 +
>> .../net/ethernet/mellanox/mlx5/core/dpll.c    | 10 +++---
>> drivers/ptp/ptp_ocp.c                         |  7 ++--
>> include/linux/dpll.h                          | 11 ++++--
>> 8 files changed, 57 insertions(+), 31 deletions(-)
>>
>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>index 20bdc52f63a5..af9cda45a89c 100644
>>--- a/drivers/dpll/dpll_core.c
>>+++ b/drivers/dpll/dpll_core.c
>>@@ -34,7 +34,7 @@ static u32 dpll_pin_xa_id;
>>
>> struct dpll_device_registration {
>> 	struct list_head list;
>>-	const struct dpll_device_ops *ops;
>>+	const struct dpll_device_info *info;
>> 	void *priv;
>> };
>>
>>@@ -327,12 +327,12 @@ EXPORT_SYMBOL_GPL(dpll_device_put);
>>
>> static struct dpll_device_registration *
>> dpll_device_registration_find(struct dpll_device *dpll,
>>-			      const struct dpll_device_ops *ops, void *priv)
>>+			      const struct dpll_device_info *info, void *priv)
>> {
>> 	struct dpll_device_registration *reg;
>>
>> 	list_for_each_entry(reg, &dpll->registration_list, list) {
>>-		if (reg->ops =3D=3D ops && reg->priv =3D=3D priv)
>>+		if (reg->info =3D=3D info && reg->priv =3D=3D priv)
>> 			return reg;
>> 	}
>> 	return NULL;
>>@@ -341,8 +341,7 @@ dpll_device_registration_find(struct dpll_device
>>*dpll,
>> /**
>>  * dpll_device_register - register the dpll device in the subsystem
>>  * @dpll: pointer to a dpll
>>- * @type: type of a dpll
>>- * @ops: ops for a dpll device
>>+ * @info: dpll device information and operations from registerer
>>  * @priv: pointer to private information of owner
>>  *
>>  * Make dpll device available for user space.
>>@@ -352,11 +351,13 @@ dpll_device_registration_find(struct dpll_device
>>*dpll,
>>  * * 0 on success
>>  * * negative - error value
>>  */
>>-int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
>>-			 const struct dpll_device_ops *ops, void *priv)
>>+int dpll_device_register(struct dpll_device *dpll,
>>+			 const struct dpll_device_info *info, void *priv)
>
>I don't like this. If you need some capabilities value, put it into ops
>struct.
>

Hmm, this would seems strange, the _ops indicates operations, would
have to rename the struct..

In theory I could decide on capabilities per ops provided from driver..
i.e. If phase_input_monitor_feature_set()/phase_input_feature_get() are
present then capability phase_input_monitor is provided..
Makes sense?

>
>> {
>>+	const struct dpll_device_ops *ops =3D info->ops;
>> 	struct dpll_device_registration *reg;
>> 	bool first_registration =3D false;
>>+	enum dpll_type type =3D info->type;
>>
>> 	if (WARN_ON(!ops))
>> 		return -EINVAL;
>>@@ -368,7 +369,7 @@ int dpll_device_register(struct dpll_device *dpll,
>>enum dpll_type type,
>> 		return -EINVAL;
>>
>> 	mutex_lock(&dpll_lock);
>>-	reg =3D dpll_device_registration_find(dpll, ops, priv);
>>+	reg =3D dpll_device_registration_find(dpll, info, priv);
>> 	if (reg) {
>> 		mutex_unlock(&dpll_lock);
>> 		return -EEXIST;
>>@@ -379,9 +380,8 @@ int dpll_device_register(struct dpll_device *dpll,
>>enum dpll_type type,
>> 		mutex_unlock(&dpll_lock);
>> 		return -ENOMEM;
>> 	}
>>-	reg->ops =3D ops;
>>+	reg->info =3D info;
>> 	reg->priv =3D priv;
>>-	dpll->type =3D type;
>> 	first_registration =3D list_empty(&dpll->registration_list);
>> 	list_add_tail(&reg->list, &dpll->registration_list);
>> 	if (!first_registration) {
>>@@ -408,14 +408,14 @@ EXPORT_SYMBOL_GPL(dpll_device_register);
>>  * Context: Acquires a lock (dpll_lock)
>>  */
>> void dpll_device_unregister(struct dpll_device *dpll,
>>-			    const struct dpll_device_ops *ops, void *priv)
>>+			    const struct dpll_device_info *info, void *priv)
>> {
>> 	struct dpll_device_registration *reg;
>>
>> 	mutex_lock(&dpll_lock);
>> 	ASSERT_DPLL_REGISTERED(dpll);
>> 	dpll_device_delete_ntf(dpll);
>>-	reg =3D dpll_device_registration_find(dpll, ops, priv);
>>+	reg =3D dpll_device_registration_find(dpll, info, priv);
>> 	if (WARN_ON(!reg)) {
>> 		mutex_unlock(&dpll_lock);
>> 		return;
>>@@ -807,7 +807,15 @@ const struct dpll_device_ops *dpll_device_ops(struct
>>dpll_device *dpll)
>> 	struct dpll_device_registration *reg;
>>
>> 	reg =3D dpll_device_registration_first(dpll);
>>-	return reg->ops;
>>+	return reg->info->ops;
>>+}
>>+
>>+const struct dpll_device_info *dpll_device_info(struct dpll_device *dpll=
)
>
>Makes me wonder what you would need this for. I guess "nothing"?
>

Now using it to get info struct from dpll.. if struct is removed then yeah.

Thank you!
Arkadiusz

>
>>+{
>>+	struct dpll_device_registration *reg;
>>+
>>+	reg =3D dpll_device_registration_first(dpll);
>>+	return reg->info;
>> }
>>
>> static struct dpll_pin_registration *
>>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>>index 2b6d8ef1cdf3..baeb10d7dc1e 100644
>>--- a/drivers/dpll/dpll_core.h
>>+++ b/drivers/dpll/dpll_core.h
>>@@ -30,7 +30,6 @@ struct dpll_device {
>> 	u32 device_idx;
>> 	u64 clock_id;
>> 	struct module *module;
>>-	enum dpll_type type;
>> 	struct xarray pin_refs;
>> 	refcount_t refcount;
>> 	struct list_head registration_list;
>>@@ -84,6 +83,7 @@ void *dpll_pin_on_pin_priv(struct dpll_pin *parent,
>>struct dpll_pin *pin);
>> const struct dpll_device_ops *dpll_device_ops(struct dpll_device *dpll);
>> struct dpll_device *dpll_device_get_by_id(int id);
>> const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref);
>>+const struct dpll_device_info *dpll_device_info(struct dpll_device
>>*dpll);
>> struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs);
>> extern struct xarray dpll_device_xa;
>> extern struct xarray dpll_pin_xa;
>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>index c130f87147fa..2de9ec08d551 100644
>>--- a/drivers/dpll/dpll_netlink.c
>>+++ b/drivers/dpll/dpll_netlink.c
>>@@ -564,6 +564,7 @@ static int
>> dpll_device_get_one(struct dpll_device *dpll, struct sk_buff *msg,
>> 		    struct netlink_ext_ack *extack)
>> {
>>+	const struct dpll_device_info *info =3D dpll_device_info(dpll);
>> 	int ret;
>>
>> 	ret =3D dpll_msg_add_dev_handle(msg, dpll);
>>@@ -589,7 +590,7 @@ dpll_device_get_one(struct dpll_device *dpll, struct
>>sk_buff *msg,
>> 	ret =3D dpll_msg_add_mode_supported(msg, dpll, extack);
>> 	if (ret)
>> 		return ret;
>>-	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
>>+	if (nla_put_u32(msg, DPLL_A_TYPE, info->type))
>> 		return -EMSGSIZE;
>>
>> 	return 0;
>>@@ -1415,11 +1416,13 @@ dpll_device_find(u64 clock_id, struct nlattr
>>*mod_name_attr,
>> 	unsigned long i;
>>
>> 	xa_for_each_marked(&dpll_device_xa, i, dpll, DPLL_REGISTERED) {
>>+		const struct dpll_device_info *info =3D dpll_device_info(dpll);
>>+
>> 		cid_match =3D clock_id ? dpll->clock_id =3D=3D clock_id : true;
>> 		mod_match =3D mod_name_attr ? (module_name(dpll->module) ?
>> 			!nla_strcmp(mod_name_attr,
>> 				    module_name(dpll->module)) : false) : true;
>>-		type_match =3D type ? dpll->type =3D=3D type : true;
>>+		type_match =3D type ? info->type =3D=3D type : true;
>> 		if (cid_match && mod_match && type_match) {
>> 			if (dpll_match) {
>> 				NL_SET_ERR_MSG(extack, "multiple matches");
>>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
>>b/drivers/net/ethernet/intel/ice/ice_dpll.c
>>index bce3ad6ca2a6..0f7440a889ac 100644
>>--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
>>@@ -1977,7 +1977,7 @@ static void
>> ice_dpll_deinit_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
>> {
>> 	if (cgu)
>>-		dpll_device_unregister(d->dpll, &ice_dpll_ops, d);
>>+		dpll_device_unregister(d->dpll, &d->info, d);
>> 	dpll_device_put(d->dpll);
>> }
>>
>>@@ -1996,8 +1996,7 @@ ice_dpll_deinit_dpll(struct ice_pf *pf, struct
>>ice_dpll *d, bool cgu)
>>  * * negative - initialization failure reason
>>  */
>> static int
>>-ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu,
>>-		   enum dpll_type type)
>>+ice_dpll_init_dpll(struct ice_pf *pf, struct ice_dpll *d, bool cgu)
>> {
>> 	u64 clock_id =3D pf->dplls.clock_id;
>> 	int ret;
>>@@ -2012,7 +2011,7 @@ ice_dpll_init_dpll(struct ice_pf *pf, struct
>>ice_dpll *d, bool cgu,
>> 	d->pf =3D pf;
>> 	if (cgu) {
>> 		ice_dpll_update_state(pf, d, true);
>>-		ret =3D dpll_device_register(d->dpll, type, &ice_dpll_ops, d);
>>+		ret =3D dpll_device_register(d->dpll, &d->info, d);
>> 		if (ret) {
>> 			dpll_device_put(d->dpll);
>> 			return ret;
>>@@ -2363,7 +2362,12 @@ static int ice_dpll_init_info(struct ice_pf *pf,
>>bool cgu)
>> 	if (ret)
>> 		return ret;
>> 	de->mode =3D DPLL_MODE_AUTOMATIC;
>>+	de->info.type =3D DPLL_TYPE_EEC;
>>+	de->info.ops =3D &ice_dpll_ops;
>>+
>> 	dp->mode =3D DPLL_MODE_AUTOMATIC;
>>+	dp->info.type =3D DPLL_TYPE_PPS;
>>+	dp->info.ops =3D &ice_dpll_ops;
>>
>> 	dev_dbg(ice_pf_to_dev(pf),
>> 		"%s - success, inputs:%u, outputs:%u rclk-parents:%u\n",
>>@@ -2426,10 +2430,10 @@ void ice_dpll_init(struct ice_pf *pf)
>> 	err =3D ice_dpll_init_info(pf, cgu);
>> 	if (err)
>> 		goto err_exit;
>>-	err =3D ice_dpll_init_dpll(pf, &pf->dplls.eec, cgu, DPLL_TYPE_EEC);
>>+	err =3D ice_dpll_init_dpll(pf, &pf->dplls.eec, cgu);
>> 	if (err)
>> 		goto deinit_info;
>>-	err =3D ice_dpll_init_dpll(pf, &pf->dplls.pps, cgu, DPLL_TYPE_PPS);
>>+	err =3D ice_dpll_init_dpll(pf, &pf->dplls.pps, cgu);
>> 	if (err)
>> 		goto deinit_eec;
>> 	err =3D ice_dpll_init_pins(pf, cgu);
>>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h
>>b/drivers/net/ethernet/intel/ice/ice_dpll.h
>>index c320f1bf7d6d..9db7463e293a 100644
>>--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
>>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
>>@@ -66,6 +66,7 @@ struct ice_dpll {
>> 	enum dpll_mode mode;
>> 	struct dpll_pin *active_input;
>> 	struct dpll_pin *prev_input;
>>+	struct dpll_device_info info;
>> };
>>
>> /** ice_dplls - store info required for CCU (clock controlling unit)
>>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>>b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>>index 1e5522a19483..f722b1de0754 100644
>>--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>>+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
>>@@ -20,6 +20,7 @@ struct mlx5_dpll {
>> 	} last;
>> 	struct notifier_block mdev_nb;
>> 	struct net_device *tracking_netdev;
>>+	struct dpll_device_info info;
>> };
>>
>> static int mlx5_dpll_clock_id_get(struct mlx5_core_dev *mdev, u64
>>*clock_id)
>>@@ -444,8 +445,9 @@ static int mlx5_dpll_probe(struct auxiliary_device
>>*adev,
>> 		goto err_free_mdpll;
>> 	}
>>
>>-	err =3D dpll_device_register(mdpll->dpll, DPLL_TYPE_EEC,
>>-				   &mlx5_dpll_device_ops, mdpll);
>>+	mdpll->info.type =3D DPLL_TYPE_EEC;
>>+	mdpll->info.ops =3D &mlx5_dpll_device_ops;
>>+	err =3D dpll_device_register(mdpll->dpll, &mdpll->info, mdpll);
>> 	if (err)
>> 		goto err_put_dpll_device;
>>
>>@@ -481,7 +483,7 @@ static int mlx5_dpll_probe(struct auxiliary_device
>>*adev,
>> err_put_dpll_pin:
>> 	dpll_pin_put(mdpll->dpll_pin);
>> err_unregister_dpll_device:
>>-	dpll_device_unregister(mdpll->dpll, &mlx5_dpll_device_ops, mdpll);
>>+	dpll_device_unregister(mdpll->dpll, &mdpll->info, mdpll);
>> err_put_dpll_device:
>> 	dpll_device_put(mdpll->dpll);
>> err_free_mdpll:
>>@@ -500,7 +502,7 @@ static void mlx5_dpll_remove(struct auxiliary_device
>>*adev)
>> 	dpll_pin_unregister(mdpll->dpll, mdpll->dpll_pin,
>> 			    &mlx5_dpll_pins_ops, mdpll);
>> 	dpll_pin_put(mdpll->dpll_pin);
>>-	dpll_device_unregister(mdpll->dpll, &mlx5_dpll_device_ops, mdpll);
>>+	dpll_device_unregister(mdpll->dpll, &mdpll->info, mdpll);
>> 	dpll_device_put(mdpll->dpll);
>> 	kfree(mdpll);
>>
>>diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
>>index 7945c6be1f7c..b3c5d294acb4 100644
>>--- a/drivers/ptp/ptp_ocp.c
>>+++ b/drivers/ptp/ptp_ocp.c
>>@@ -382,6 +382,7 @@ struct ptp_ocp {
>> 	struct ptp_ocp_sma_connector sma[OCP_SMA_NUM];
>> 	const struct ocp_sma_op *sma_op;
>> 	struct dpll_device *dpll;
>>+	struct dpll_device_info	dpll_info;
>> };
>>
>> #define OCP_REQ_TIMESTAMP	BIT(0)
>>@@ -4745,7 +4746,9 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct
>>pci_device_id *id)
>> 		goto out;
>> 	}
>>
>>-	err =3D dpll_device_register(bp->dpll, DPLL_TYPE_PPS, &dpll_ops, bp);
>>+	bp->dpll_info.type =3D DPLL_TYPE_PPS;
>>+	bp->dpll_info.ops =3D &dpll_ops;
>>+	err =3D dpll_device_register(bp->dpll, &bp->dpll_info, bp);
>> 	if (err)
>> 		goto out;
>>
>>@@ -4796,7 +4799,7 @@ ptp_ocp_remove(struct pci_dev *pdev)
>> 			dpll_pin_put(bp->sma[i].dpll_pin);
>> 		}
>> 	}
>>-	dpll_device_unregister(bp->dpll, &dpll_ops, bp);
>>+	dpll_device_unregister(bp->dpll, &bp->dpll_info, bp);
>> 	dpll_device_put(bp->dpll);
>> 	devlink_unregister(devlink);
>> 	ptp_ocp_detach(bp);
>>diff --git a/include/linux/dpll.h b/include/linux/dpll.h
>>index 5e4f9ab1cf75..0489464af958 100644
>>--- a/include/linux/dpll.h
>>+++ b/include/linux/dpll.h
>>@@ -97,6 +97,11 @@ struct dpll_pin_ops {
>> 			 struct netlink_ext_ack *extack);
>> };
>>
>>+struct dpll_device_info {
>>+	enum dpll_type type;
>>+	const struct dpll_device_ops *ops;
>>+};
>>+
>> struct dpll_pin_frequency {
>> 	u64 min;
>> 	u64 max;
>>@@ -170,11 +175,11 @@ dpll_device_get(u64 clock_id, u32 dev_driver_id,
>>struct module *module);
>>
>> void dpll_device_put(struct dpll_device *dpll);
>>
>>-int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
>>-			 const struct dpll_device_ops *ops, void *priv);
>>+int dpll_device_register(struct dpll_device *dpll,
>>+			 const struct dpll_device_info *info, void *priv);
>>
>> void dpll_device_unregister(struct dpll_device *dpll,
>>-			    const struct dpll_device_ops *ops, void *priv);
>>+			    const struct dpll_device_info *info, void *priv);
>>
>> struct dpll_pin *
>> dpll_pin_get(u64 clock_id, u32 dev_driver_id, struct module *module,
>>--
>>2.38.1
>>

