Return-Path: <linux-rdma+bounces-9414-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5AA88851
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 18:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5345B167BA9
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19DF27F73B;
	Mon, 14 Apr 2025 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWpzG6by"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2FB2749F7;
	Mon, 14 Apr 2025 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647363; cv=fail; b=m95kkSnki1FfBI+OoAGkj1MUP8YrYj/KwKFXFB4/rOsXfnJZosdlKuKdCA0dS6PdW59I2g2qGkdUVxQ+n1/Hn5UDdSayBjZE+WQLM7UrQKlFFBj84WWrGwIGppWgqlmnrsrQCl9RJen/jJMlshQSQVTlwbVRLtbzhrz2lcN20hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647363; c=relaxed/simple;
	bh=D+WfUAilB87v9mvKCuONVlgkp8EQBMs8OtfywKu74uA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iqQtgeqRsif9/FqQmwC0lLYYL10Dm7rFb78QRTdxdvVgHYl68QJBIWQ7ObAcluwZcjL+u+bGy04bRI17EWcT2JWWUVd3GnNlYSc3QrRBK10EWuYO9IZ8x3sHRdsNJEnZtBR0LC61jXrzIDRW3uktrCP9E41Cepwl8m9XB25HktE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWpzG6by; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744647362; x=1776183362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D+WfUAilB87v9mvKCuONVlgkp8EQBMs8OtfywKu74uA=;
  b=nWpzG6byhDEf4tKZGadejB6AZE7qiGDWCYzpidiO20HbIBneKz9vEUVk
   swlLeyZ+GQMsjyME++2U8SE7DvPoeUj/dtVTFTK1HALMlYLj9ixcAY/qa
   8ENN3OxUO3mwc5OY5VS8RW+p2O70kElCgLSaXH6ckeklMcxxveyk0SrNr
   Cx3SDGG6CLnnvf656fgFeQEaPXlAV5tCl4WsibWQV8wkCAISoCI4nfvBB
   WnQ85PLpburDAtHC397qzLSdkgO+1P6dy80T94nBP2A6RBKpfqqdBw2ZY
   xrha+kgAh0IOmwzEnbBmHlOZ0yttANhhNsqTGP4sQITt59MKdMXbWYE0d
   w==;
X-CSE-ConnectionGUID: OQojogQATBGQPnIMNuZgkA==
X-CSE-MsgGUID: 3TT0ldJ7SZySYz3hOMLTSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="71515182"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="71515182"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 09:16:01 -0700
X-CSE-ConnectionGUID: 7WTOWZwdTSGbP7RcoG+kRg==
X-CSE-MsgGUID: FwiN2OmtSDqxAoGJmt64kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="129828904"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 09:16:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 09:16:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 09:16:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 09:15:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVG7EvGNbCNfwAbHRr5q+y3YvoPsL7W2llxLFdM291CSXi9dS/4aI84aDQ97onOvg3feK/45iFyQudadtr2F77mQkMysCFHVgXW61+2z7EUquPhTl2R/MYJf3VtMlNGYveoCrTin/4LLspXOqeeR7C0bRlx5C9mfDkYF5RKqRTdqgFWt+wHZpf1uQNxCES/rV777lxKFgV/pn9Yf6EgIJNqo3AwCIkvSspF4GEd5B/nr1gu8GkI1f5bIRYbZD8wjTFWtIylfS34ugTkSmnTA45adoasE9xyE7Y0S5L3lB0cVNBsTygDEFU58FzO/QeBvj3h/QJfJmT6vh4O24B/hAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+WfUAilB87v9mvKCuONVlgkp8EQBMs8OtfywKu74uA=;
 b=mbGY6FIEP2zbg5RrQ+Thac12+c8Xgb4GrRyyqXYJWWPHYIOWvIKA82uqUou7NR+FRgJG1DlXrQQOFKUJEhwrGNF6E7UgAoeZVwR8dl0Uoqo1FOTRQeSUfk8KJAJOvY7dPktDqHh0bUXcRRlWVcEL3T9UmEV0/n+ttJxXy1uya02oKCbQuaj+wFzGWrs2s0Pzf4f79mHGpHQgZPM2Pxl9gkysEV+hHy0sT+9Vogco4s7drcOL9x96RrukJJ04iyXl+ImOWuXVoXtygPmp0NW7PoQp/lClS7onUdKaRpJlu+n8vo3QcU9KEKpnfO+MGBiLUV1Si1iEiNauEwiOY62ASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by PH7PR11MB8250.namprd11.prod.outlook.com (2603:10b6:510:1a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Mon, 14 Apr
 2025 16:15:38 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%3]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 16:15:37 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH net-next 5/7] wifi: mwifiex: Don't use
 %pK through printk
Thread-Topic: [Intel-wired-lan] [PATCH net-next 5/7] wifi: mwifiex: Don't use
 %pK through printk
Thread-Index: AQHbrVDX6Lbm5ACE3EW81UyohnQy2LOjVhog
Date: Mon, 14 Apr 2025 16:15:37 +0000
Message-ID: <SJ0PR11MB5866ED90242FAEE4602FCBE1E5B32@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
 <20250414-restricted-pointers-net-v1-5-12af0ce46cdd@linutronix.de>
In-Reply-To: <20250414-restricted-pointers-net-v1-5-12af0ce46cdd@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|PH7PR11MB8250:EE_
x-ms-office365-filtering-correlation-id: 7848feb2-1471-47c6-3f86-08dd7b6f97a6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MDJTUnJGazllYldvM0xueWZtMytnNDFlUHpuQ21EN01qKy9QbHM2em5yWjFR?=
 =?utf-8?B?cGtDZk9DcFRkNDV2eVZObEtKR3A5MVJKdVA5V2pTbmY3NjdXMktYclpQMHkw?=
 =?utf-8?B?cm8ybnoyNFdRZUwxaDJPNkUrVGd5Y2Z3elhFWUZuanpUNThOTEtyUkNWTG5n?=
 =?utf-8?B?SDJORWI4NVgzTlE3aEd3NFFKNHNSdW01OHZSN05NbVJ1V2dzSVNDZVpyUjVD?=
 =?utf-8?B?cTN2OEUrdjlTN1VWRERRRzIxdlZLSkp6S25WWHFmRkYxL3BRbHc1eTVCUzBX?=
 =?utf-8?B?NnRqZFFnWDdKK05Wckk3TWh4djFoem1NYXc4Ly9RMFBaSWE4RElGbWw4L1Vl?=
 =?utf-8?B?MDkxSkhRMWZ5bkkvbENkQThZcW04blBUMTVoNzBVYW5YUVZqc1VRb3NqQzRV?=
 =?utf-8?B?WmxkY1l6Q0lxemJHZEtDSUcwV0w4MXpTcWgxeml4U3Qyd3dvNmxEV3JQYnBq?=
 =?utf-8?B?WXhTRlBoSDh1SDNCZnJhbi9yMEFyczc2S25ndmNjeFlSSys5YkQ5VS9ZeFZF?=
 =?utf-8?B?T3kyOFB1dW8yUWE4aEF6Qy9INVE2S2hMQ3VrdFAwTUlyQ0huTVJ0SWRuUGE5?=
 =?utf-8?B?MWhyUzFadEtRaVZ0UGlZblJOSVhVaU9XSHRFaVU4QTQxZG1HeVArQ1MvNndE?=
 =?utf-8?B?K0lzalRSMXIwME5WN0ZVSVhGbENxeDdNRW81QXo2emhtZVZiUVlYV1hzdnRs?=
 =?utf-8?B?MTlIdkhpa2g4bWE2NzdocG5FM21vVU8vR0tldWFwVy9Yb1lmaUxWZTBLdCt0?=
 =?utf-8?B?SXVFb04xQVcrOStNdlhsQ2MxeWtBWmNzd0g4NDNzRDVNS3lQTHhvc2ZYcDBu?=
 =?utf-8?B?LzhoMjN3Q2tXYnYvNXRRZld2SWE0TGJqc01YVTZxTlBBbmFkODV0cDdoMjla?=
 =?utf-8?B?WEIzMFlyK0VENWljN3JrMkttWEFrVWMxdGF0ZDQ5R3haNHpkeVJDdGFjTU85?=
 =?utf-8?B?ZGZLQ2YrRXN4ajJYOS9qTmUxVnpoc1FmYTRLaWVpZmFVYzRKdFVCdzNYb2xw?=
 =?utf-8?B?elRJRmRFZm53aG93cndzY3oyaGw4czZ5QlBsTFBmV1dydHZWVU82REg3R2Jk?=
 =?utf-8?B?bVZTZEMxN0NJNVI3VHFGeGhScy9qaDcvQ0VBdWFTVVM2bGhtMGNMQXZveTlC?=
 =?utf-8?B?aHdEZEhCUnVnVGdLa2dsK0ovejlqRTZyeHM2ZDFFQkhQZzd6WFZJTS9MaFph?=
 =?utf-8?B?RmtReEZYanJ2N1hzNlF6Uzl5QllqWkp2Vm5za1lJZ1pJY3JIdlpvU3QxVzNP?=
 =?utf-8?B?Vmx4Z3IzYTBSSnl1R1VkSzRWcGMzQmdoVUFMeVF5b2xJQUg4cFNvQzBXTzdM?=
 =?utf-8?B?WjBWMjRaUU9EQ1E4V0JHMGFUT3B0WFZ3VWFjVUdidXJHR2wrNUVvT1Y3bEN5?=
 =?utf-8?B?MUFpQ2RBTm9hbVZMdlAvTTBHbVQwcUZaZTZJUlpEQ3JndEdOOTRPMURxMmZq?=
 =?utf-8?B?Q3Vjd2ErWU5neWIyNGpSRG45b1NNTldueFJKV1pSNTRxQ0VIWlp1QTIvc0RK?=
 =?utf-8?B?Z0FWQVBOMjYrSEVTUmx6U284Qk1qTFBtTHhsODNuOXpmcERwdnA2SnVqSlNI?=
 =?utf-8?B?UzZzTUZ5ZlFkWXZTY3RuUjd1QlBTNlpNU09BaWZhK0V0UEZiVTlXdWxOVzR5?=
 =?utf-8?B?N3d2TExPTjFnZFo3VHYyNlZwQ2ljU05sVlpXaVNkc3FlZCtWOFRtRWpWMWVH?=
 =?utf-8?B?THRMemhBQWV5ejRQV0lIdURXY3l4SUtDa0ZkUVl2THRsQzRyYTl0RXNvdWF3?=
 =?utf-8?B?T0xGVHJtU3hNbGdzSitQUHQzNStlZ0pXNzVOTG94RzlseWZtMWM1dGJkenNp?=
 =?utf-8?B?WjRIZGN1QXd6VjdNVHNkVm8zT0lxL1ByQTlsWERsRjV4a3Z2UmVoSHowWmdE?=
 =?utf-8?B?V2ticm12eHc5ZFVFSFMwTDdtVi9rWi9iSkdjWXJ0eWFlT2dyR2hrT0hiNjlR?=
 =?utf-8?B?V1Mzbi9YZmx3ZS9oRXh3WHRONTQvaWNVQUJzcUF4VWR2LzJtdFc1UEp4SjNR?=
 =?utf-8?Q?vfHdw/oIL1A699FIucyiv65t6PlsNA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVh2MFQ5bFdnTEkwcE1MRDdvMkZSUmRKL0FncVNFcVg0VjM1bUk1WE5VaUNP?=
 =?utf-8?B?RW1IamQxSldHVWhKR29IcXFkSHNocy9GVDFuaE5UcnNvZ3crQzl6WmliVjlk?=
 =?utf-8?B?WmIwZGVsOEVmZHJvdHVzeWRIRDlxOStCdHpkT0J5ODNOaDBLd0FyRzZMTnlo?=
 =?utf-8?B?YnN5cFZRQVQxRWxtU1doTjAyNnhUWGxycEZmWFVjNVZob1dmbS9ORGV5NElQ?=
 =?utf-8?B?Zkd1NGhUYWRRbG5HUVc5Q3lOT09rcTZ2SGJBZGtIaUh4QmlqVktqVkMvTjlq?=
 =?utf-8?B?b3VSR1V6VWxjY2J0UklQK3oxN0JPRGw4WWRiTXUxQ3VzWWFaMTdDNDFXTnZR?=
 =?utf-8?B?M050SGZRcHNHQXJDVW5FV2c1bjh2QWJ6eElBeGF4YTlwcGpsWllSS2p6VnZv?=
 =?utf-8?B?c0RWNlEybFkxbnBLOTkxUTI4dTdxVEU5OHZSbzJ4am9mMmJ4MXRJNCtYenQ4?=
 =?utf-8?B?S0hWWllCeXlEUWppanJlR0Q5OFZBZCtLQ21UM0lrblFEdWxaSUFINEtnMDdj?=
 =?utf-8?B?ZE9UU0hQWEhGVlMybjJ0RG5FR1J1Wi92L2tGbWlxM0tESGsrT2NacU1EcXVS?=
 =?utf-8?B?ZkMrWHV4MlFaWUpraUZ2ZThYTVhsd2swdUt3NnFuSE4yNk9lc21qVGFuVEkr?=
 =?utf-8?B?WXRoRjR3M1dTYmYrbnhCcGJwNlo1T0dsNjFIcXhWODFVOEJqM09YL0RTR0JM?=
 =?utf-8?B?SWcwemUvbWlRTmxwRUdmSVRTV0JjcFpkVDlQRDY0K3VwY1ZxamRCVkd3c0Vl?=
 =?utf-8?B?V2xRNWl4ZjFMNWdib2NnY3FTT2tMdlI1OGdFa0dZblFVWVpNSTI4VytFUnQ3?=
 =?utf-8?B?SnVXcmJWUS9FT2JzNmpzL1lxcDgzV0ttNzZwZWJoZmJXYloyNHM0S3lEdTRB?=
 =?utf-8?B?TWlhcTJDaXFnSkgwSHFTNjhlYjNEbmxEc0FwZitBTHVtNEtHVzlKM0NadjVl?=
 =?utf-8?B?Y2IxQ2l5SU9yTElxaFpyRVg4UU9BUG9Ma1IrWkJZK1hXem5rZkxOZ0IvM0Q1?=
 =?utf-8?B?MDdHOUs1amxwSjlTS05kWDhaWENEa0dBRGRIK01SdUM2aEhIMSt2YVZ5WmFV?=
 =?utf-8?B?MHY0L0R4aTBDZVE5VGVsemMwQ0J1bW55Q21MM2R6WFRFWkZxMFlNd25JcWNu?=
 =?utf-8?B?ZVZIdU1hWjYvcXkveUdIM2dFeEZwbWwyeURMQzNJc2NEbjNTSzVNbXNGRC9M?=
 =?utf-8?B?S2p6MEQ2NlRXaWxUQjQ0VGZQRjRDOVRoY29yaUMwK0JRcHVtdmlLc3UwK1ph?=
 =?utf-8?B?Wm1sa0xSSFZuQVpVU3prYmxJbE50eXh0ZFR2azdveU9KaGI3SWprNjZxblJu?=
 =?utf-8?B?N1YvS2d3eGprU3dnRW9oOEw0WFpwaTFFbmsvbVRlcXRpOW1EQ05JeUQrWjFZ?=
 =?utf-8?B?VHhCL1NzemZDQkE1OGo2QUZ3eVhIcDVXa1VtYkxteEhkeVdZRnJkQXNVQzla?=
 =?utf-8?B?MmZ1V0dPUkJFNVh4WkxMbjFMYnFCSHMwVUthNDJTV3FaOEM5OXljL1RNcXFD?=
 =?utf-8?B?RjhhSk1LUUswWXVjV2FveTNLOTF0UHFJRHBYTHlzSERZTmorQWdxMnIweFFX?=
 =?utf-8?B?djd1N2ViOFNWU0dWdXZhYURITUg3OW8vOHlGNmNwSGxxR0d1blVtWHgva255?=
 =?utf-8?B?bzRpZXI1b0RXUXlVTEYvZ1FuS0FyaVVOTzMvWGJDY1l1aW9kUXZBOUpTZW9J?=
 =?utf-8?B?SllwWUxjdU9xQXo1VzdhWEw1Zll2b3hGWklJNHE3bGNJbURrWFJ3bU5PUDNj?=
 =?utf-8?B?Q1lvMVB1RmY3VU5Ka2hCb3ZsU0ZsK1NrR2RZdG1rQWgyeUVDVVlxSkJtZXI4?=
 =?utf-8?B?dHhtRlNCOHlaVzNoSFV6SlVHTzJHK0lJcHNWY0VUUXAyV3R6SVo0NWt6d3V5?=
 =?utf-8?B?c0QvYzZZVW0zY2MvVmh5aUlQQmNCUkVUeVpIZEd6cCszNkVZNFdlYWJxWHlQ?=
 =?utf-8?B?WG1TUjJjeFAzVVNUQm93MWYwZ3BNZlV4Q1lZU1BzbzNaUGw4azd1dDZJM3Mw?=
 =?utf-8?B?SFRXdHdRdW9CSDVtWWcxVnNvWHg1KzhvamJmRWhXSmY5NEloc2pPaVRkU2pp?=
 =?utf-8?B?ZkJYZmNMUG91TjRCY3dGQWF0YzJkc215NDN0cElsYnVncnFlVXpGekk2T2tB?=
 =?utf-8?B?aWpjN1pwcXM0Rjczc3NuUmt3ak9qczExV1Z2UFdvMlNzN254NGUrSUJCa21C?=
 =?utf-8?B?aEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7848feb2-1471-47c6-3f86-08dd7b6f97a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 16:15:37.2274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9lEznY3vI0E+zjWk9DBUcEnKpwH0DgDjcf6tJ4ykXZTltiE+YnJYiHat0T5x5bAP9ZCnWFBO3pdlX6ANvvii/T6QGEEwM23dricwR9wHfuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8250
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
amVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IDUvN10gd2lmaTogbXdpZmll
eDogRG9uJ3QgdXNlICVwSw0KPiB0aHJvdWdoIHByaW50aw0KPiANCj4gSW4gdGhlIHBhc3QgJXBL
IHdhcyBwcmVmZXJhYmxlIHRvICVwIGFzIGl0IHdvdWxkIG5vdCBsZWFrIHJhdyBwb2ludGVyIHZh
bHVlcw0KPiBpbnRvIHRoZSBrZXJuZWwgbG9nLg0KPiBTaW5jZSBjb21taXQgYWQ2N2I3NGQyNDY5
ICgicHJpbnRrOiBoYXNoIGFkZHJlc3NlcyBwcmludGVkIHdpdGggJXAiKSB0aGUNCj4gcmVndWxh
ciAlcCBoYXMgYmVlbiBpbXByb3ZlZCB0byBhdm9pZCB0aGlzIGlzc3VlLg0KPiBGdXJ0aGVybW9y
ZSwgcmVzdHJpY3RlZCBwb2ludGVycyAoIiVwSyIpIHdlcmUgbmV2ZXIgbWVhbnQgdG8gYmUgdXNl
ZA0KPiB0aHJvdWdoIHByaW50aygpLiBUaGV5IGNhbiBzdGlsbCB1bmludGVudGlvbmFsbHkgbGVh
ayByYXcgcG9pbnRlcnMgb3IgYWNxdWlyZQ0KPiBzbGVlcGluZyBsb29rcyBpbiBhdG9taWMgY29u
dGV4dHMuDQo+IA0KPiBTd2l0Y2ggdG8gdGhlIHJlZ3VsYXIgcG9pbnRlciBmb3JtYXR0aW5nIHdo
aWNoIGlzIHNhZmVyIGFuZCBlYXNpZXIgdG8gcmVhc29uDQo+IGFib3V0Lg0KPiBUaGVyZSBhcmUg
c3RpbGwgYSBmZXcgdXNlcnMgb2YgJXBLIGxlZnQsIGJ1dCB0aGVzZSB1c2UgaXQgdGhyb3VnaCBz
ZXFfZmlsZSwgZm9yDQo+IHdoaWNoIGl0cyB1c2FnZSBpcyBzYWZlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogVGhvbWFzIFdlacOfc2NodWggPHRob21hcy53ZWlzc3NjaHVoQGxpbnV0cm9uaXguZGU+
DQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBp
bnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4
L3BjaWUuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwv
bXdpZmlleC9wY2llLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9tYXJ2ZWxsL213aWZpZXgv
cGNpZS5jDQo+IGluZGV4DQo+IGRkMmE0MmU3MzJmMjM5ODg5MjkxNWUxYTNhYzg4YjdkM2ZiNGVk
M2YuLmE3NjBkZTE5MWZjZTczNDAwNDBiMQ0KPiBiYzc0ZWZiMzVjZjUyY2U4MzY4IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9tYXJ2ZWxsL213aWZpZXgvcGNpZS5jDQo+ICsr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC9wY2llLmMNCj4gQEAgLTI5
NzEsNyArMjk3MSw3IEBAIHN0YXRpYyBpbnQgbXdpZmlleF9pbml0X3BjaWUoc3RydWN0IG13aWZp
ZXhfYWRhcHRlcg0KPiAqYWRhcHRlcikNCj4gIAkJZ290byBlcnJfaW9tYXAyOw0KPiAgCX0NCj4g
DQo+IC0JcHJfbm90aWNlKCJQQ0kgbWVtb3J5IG1hcCBWaXJ0MDogJXBLIFBDSSBtZW1vcnkgbWFw
IFZpcnQyOg0KPiAlcEtcbiIsDQo+ICsJcHJfbm90aWNlKCJQQ0kgbWVtb3J5IG1hcCBWaXJ0MDog
JXAgUENJIG1lbW9yeSBtYXAgVmlydDI6ICVwXG4iLA0KPiAgCQkgIGNhcmQtPnBjaV9tbWFwLCBj
YXJkLT5wY2lfbW1hcDEpOw0KPiANCj4gIAlyZXQgPSBtd2lmaWV4X3BjaWVfYWxsb2NfYnVmZmVy
cyhhZGFwdGVyKTsNCj4gDQo+IC0tDQo+IDIuNDkuMA0KDQo=

