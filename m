Return-Path: <linux-rdma+bounces-9420-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721C9A88876
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 18:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5653B3384
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78097288CAA;
	Mon, 14 Apr 2025 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThltX/+G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF6B27FD66;
	Mon, 14 Apr 2025 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647519; cv=fail; b=lX3PbbvT8/HTs2wXGVVTR+aZmmCXjTn31YtGj9biyZAnWXKWAdEvPbASoIHIKWCZ9BiWTh4AVDe6jKgZRhQnRBc5YlRVLmfS/rJhpUw8IcAxWZseGa0VzTAe0e9eWGM1v8CqDtiAUBRkf8jLE79NfFIdjytwz2/6pbJQ36ObC5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647519; c=relaxed/simple;
	bh=NYxSH34ASDmlMsYIANysKRmTvpXRHXEvSIJgw/FeE/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OvUJSWmtiSmNEa9/AvwN11cRaHfYbpBqqVSms6tfUJLADFLpTgJq6eWyPeLak8nfpNil50Nrdi9O/DEuemrhK6xz8hbluQXtcXpND4sLcFhbMERppc0i9h+2aMlXE+VWy6LgqIbYuwSJsKxYBZev6hbqjYYNW0gYFKJ26Wxq5Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThltX/+G; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744647517; x=1776183517;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NYxSH34ASDmlMsYIANysKRmTvpXRHXEvSIJgw/FeE/o=;
  b=ThltX/+GFRYeHKI/IyOGClaAfwisE9HS49/5/k1T9O/o872qON3EmlME
   gDwnf4uqjiR83gRGZmyS9PSa6G3Ud0cUGesyIAZsKOOG7462g/xvWc3Uf
   syqwVLMdGz6uTMYsgJ3myo/sszVJQq06PjE0LARKlZxp7L0shIMB7X4o4
   p6mQWYS/rldzf9/Khq0rT7N+S7hhUiwnsKzJTRt+I+REKZCvrEwgPGb+g
   pgyX+rF08q2rzARE2PHIxuJdFaM1cAAmpevNADKZMLPnKKIewCRWhOu+l
   IWfTQrApBekAyFM0un+5Pm7dqAUefrz4zKRDHAwd1HXR1JaLNAJUZIFLr
   g==;
X-CSE-ConnectionGUID: Nwd0jDBvRJeGFsfhZ0mauQ==
X-CSE-MsgGUID: 2hKi+VJ+Txy8C2TxAaoYAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="71515838"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="71515838"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 09:18:21 -0700
X-CSE-ConnectionGUID: 8PI9kl7GTjunQ0vgjY5KCw==
X-CSE-MsgGUID: qP3X5XaZQvC9qk7Fu4NTiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="160825314"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 09:18:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 09:18:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 09:18:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 09:18:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnLcS6kFNy4SrGkovCDF/QxqLdOgKjPb9IAf3/i4l9VYSid4d4tp8DXdCy+3JeGhzLWkrJMCKOU0Vl2enahUXwrs3QdEnOm9B06C/EjKd/hOTqlpXkNaMU1DdG39xarFkhUF7wcpzl1+jvOTWE0t1+L2gKpUI1CUYfWaDrJFcTq4fDsUPYkdjIt9OHZleMn/yldxGGR3oj/DfGpsT5c+LLDdgoY59b/BvCt0F+a/TKDh+Iofv/MK4Kv7YjrskLYn2FqDE5sc9N1Ysu+EutVGryf1UM8qVdkhVydVjTqTa9SnBbn5Yk313v6COi9HwlvLkdzL2iJOmEyskPVaTpCDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYxSH34ASDmlMsYIANysKRmTvpXRHXEvSIJgw/FeE/o=;
 b=jE6m86bsrRwP1DbhFthoX6ZRNR11LVvufis5xbdFlDQ0cIKdMariegzRsECyvnVGtb456fbtP7RlTouByZgAaLTlOfhVkulO9t9PpZIdEEL6VmSB1HQy4dIc7GsEhpCpl+9+5KRrO6az5tE7R8k1ZzeUwPnPHCHxYIK52rWka55wX2tNNI/VNEctytZMGpajJijhPguf94xd4R4srmczJjouLO4BNRWrdvKLTt62AGqLJN1uZXhNxm2rcfKfFa3N0W1RhX3KDQU4LTEUMchoFri5kjIofefsMEeuA3DCybNLpJ3i/jtko6XRPa/b1jw5V8rU1OE2cDM7zo+97cfuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by PH7PR11MB8250.namprd11.prod.outlook.com (2603:10b6:510:1a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Mon, 14 Apr
 2025 16:18:11 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%3]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 16:18:11 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH net-next 6/7] ice: Don't use %pK through
 printk or tracepoints
Thread-Topic: [Intel-wired-lan] [PATCH net-next 6/7] ice: Don't use %pK
 through printk or tracepoints
Thread-Index: AQHbrRbeloob9dr3h0WMWdzdYnyqhbOjV1vQ
Date: Mon, 14 Apr 2025 16:18:10 +0000
Message-ID: <SJ0PR11MB58664D9F5D2A679872B9739CE5B32@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
 <20250414-restricted-pointers-net-v1-6-12af0ce46cdd@linutronix.de>
In-Reply-To: <20250414-restricted-pointers-net-v1-6-12af0ce46cdd@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|PH7PR11MB8250:EE_
x-ms-office365-filtering-correlation-id: ab24a63b-daa4-4d7d-8fd3-08dd7b6ff346
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d3cvMFBwZmNwamZHdS9XZmo3RlgxRzdPVVEyakZEYzFHU2k1VkRwWThMZWZv?=
 =?utf-8?B?WElVMGhDQlRmaHZtTUR5Z0MzOGZGKzdaOUF0UkpFQmJ6UHQrTXpBRCtHcS9D?=
 =?utf-8?B?RVV1ejhwRnlBdy9KVVRFUWh5YjFUOGV2STRCcDkrVWw2dkF2SlZKWkpRNUs3?=
 =?utf-8?B?dnpseStwVmdvaFBhRnYvRndSMFlSQXlVVERHV09uU2JMbFJyY29FMU04eUJ2?=
 =?utf-8?B?QW1GYWwwR29yNVMwdnJ3bGxUSDAwZS9PenBuYVJNLzY1dW5YNjRybFNQWEpK?=
 =?utf-8?B?RnVrYzZyVllRNUNiT3ZmK1pXZ1dHVEc2UmtrTndPSVdqcWNISUptVm1VU2NF?=
 =?utf-8?B?dnRPNDkrUzZkU0ZWZHQ1WEs0MzRDMklJSjNJNTR0WXBWVTN1M2c5T3grOFMw?=
 =?utf-8?B?cU9odmRqQlN6c2VZK2gybnIranFXTWNwSVY4MDZvUHhRU2svVEx5c01YNk5J?=
 =?utf-8?B?Sm5VeEhOZnBxcXIxNUtYUE1rdjNLUVg4RWdBTlhBWlp6Z1RXZUpLZEZsbHRB?=
 =?utf-8?B?YktpclFiNXJOdWpiTTZ1ZFZxUTl5NDBlQkhmaGkxaHAzQnlySm1OZHZzd1ZB?=
 =?utf-8?B?NjRiNTN6T3lFMThvb2U0VzNCbktBVXBVREtBUDFrTE8rUFpZL2ZZNUhWSVVr?=
 =?utf-8?B?VHorcHhRZWcvQ3lwVGZBU2d3RlJ3aEJvc3J5QUZtV29aS2ZQSTd6VWlHVjZx?=
 =?utf-8?B?YzljcVNVNDd1NGdGNnlTQXZFeW5rckdDbVRyT1N3emVXQ1pROTAvVDNGRStC?=
 =?utf-8?B?RVZjUEdiR3NkemdVSlZzcXJHY1I0d2VXYTlJSVRKa3BSWXFrQSs5U0lNRERC?=
 =?utf-8?B?eGxLblJhVTR4cEVkdkJFVjNuN2haeU4weFRpRU55SWdVU2tLdGFtWDNIVTVJ?=
 =?utf-8?B?dndEYnlkNWg5TTJMNWJrNCtubDl4anppUHhYeXBhSmhZYkRsNnZFVHhiTXpj?=
 =?utf-8?B?bE91Uk5md0hscnVsVkpZUUVEa2R1QjVoYXdxM2s1WjhpRGkyakhRU0VVWkNX?=
 =?utf-8?B?N2tkaDhvM2JZY2N5WnVrSURZSVduUktROFNwcXJTZ2xtaEZiREJiTjVodzhO?=
 =?utf-8?B?clhKY25taSsrSDJhSUVLL3o1b3loTDJKOGJhV0J3TXJMOVl3eExmVGtnSGp4?=
 =?utf-8?B?d2RBWUNDa0k5UVJnUGtpQUZ5VnVET0g4cjZrZlBFT0ZZbGJIOStyL3lCd1cy?=
 =?utf-8?B?cnhXM0RoMW05QVBmcUtJRm1Ic0ZlZHFZREVYdDFDdEIwR1hiT2hVVkhEbHVs?=
 =?utf-8?B?NkZNTk1vRG5HblRnMmVnc1ZnV0U3cHdRcDYwbTlaV2dtYmZVdFo1VXJIOEhx?=
 =?utf-8?B?TzkxaDVtMXd5ZE1pYmVPNS9Vb29PNk82dzFqWkhKTEhqT0U0SzUrSURUUTFU?=
 =?utf-8?B?aW96eFR3ekFPUmViUlRLNVlaVlAyUU1LdHg0aGVXMEZJdXFsMXpMOW5qcEdI?=
 =?utf-8?B?WkdVRTdTSUdqV2x4ZXd5NkNNaXp3WExTTGRnVFJIWFZkdzVsSHE1SHNkT1Nv?=
 =?utf-8?B?VjRBME95Qk5TdDJoS2h2blE1VEp6MVVzTE56aWJWTmdRWEtMVWJoZTRtOHMy?=
 =?utf-8?B?SWtFNVcyZ1IrMHJYQmN0RUNlbStVNmREQmFIcTFkRDNOcGZ4bXNwUzBiLzAx?=
 =?utf-8?B?c2wvaEt2S0x2RUk5d0hiT3FJei9WWGdIOUdJdVoxajlxOGNnaEs5dzdlUWd3?=
 =?utf-8?B?MGFTOTlEWUdUSmR4N0pva3dxQ1JIeStoZ2dJVDRURjF1cHRVUWtDUmNlem4y?=
 =?utf-8?B?bEhjRFJseUQzQnVpZDd2bWJZQ2ZxUzJycDQ3blU4WDd5YXpvRzNvaWRvczRD?=
 =?utf-8?B?cU9OUFBTcXBoM241ZU42MGJSU0VTZGlMNHg3ekpZWHNSMzhHTVlCMXJlU0I3?=
 =?utf-8?B?RjJ6dWFqakswdjNKVnJPWVVLc0dWK29HaEFYcE1zYU1CdGVsWUJWaGE4dDJW?=
 =?utf-8?B?ZzVibmZLeE96Mm5ubVo2SnF2aFBEN1NIWVlaajRVWGt5T1NxZmd6YmQrbHJu?=
 =?utf-8?Q?bHTpq/34Abd+08EawsX+o0Yk8v81W4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWhpWVZnWTA1akZkVXhkZkJqSFpPUkFBWjdGTk5LYVRRY0IyUStGeEFmK2Fz?=
 =?utf-8?B?WWQrSGg2clhxWGVQblV6UzEyVWFMMmFHNWZLdS9KREYvYTJKQk5EbUFPQ2Fu?=
 =?utf-8?B?Ri9MckdhTysxcFJjTDd0WURkZTFMcmVaSzJ5Ulc2SldtVGR5ZVhnUEN5MDF6?=
 =?utf-8?B?VXJoU0EydGs0VUtPTkZDVnFIQTJ1YXFVU2ltRzAyZUR5OC9tYnlNOXVkWHhH?=
 =?utf-8?B?ZmIwQmZqdzNQSERPdDRMS3JwYlFETXF0cGNiQ0t4VGM5c2FXYmkvM002NjRt?=
 =?utf-8?B?dk01SzZEb3BnZVMyVTVKYzF1NGoyNUEzbXNFeDZvb3lrSGpHaVJKNFEzY0Js?=
 =?utf-8?B?UnhzS2cwQlJYUUpHOGF2dWlxR1B4Ly90M0VoY1JOQ0tCMlkzUnNZNjNvVXdC?=
 =?utf-8?B?dkNVcmVaWXIxb0tHTzltOGJuTlpCOGNBTzBrTjQ5bXhhcDhrM3RYcWZmM3BP?=
 =?utf-8?B?VDk3SlVwT3JkQ0tXTWI3UkVyVFBvWmNvNTNJTGR2TEFaZ3UvVWJhOWhOcXZD?=
 =?utf-8?B?MFdQTGNmNnFTRjNOREpDSFpCMHZkcTFGc2JmeXQzbklOWWN1U0FETjh6TDZz?=
 =?utf-8?B?b2RjdUV6aTA0VGZBVzBTRUNwdTZQUGdCVGlaRm5YTXU4VkpOb0F0ejhLVTNr?=
 =?utf-8?B?NzVzb1R2WVdJemlJY25Rd3pNMVVtVFJsSmIxUW92bzFha1ZEeVBaYjlNT0FK?=
 =?utf-8?B?T0ZiTFdlRHFqV2JyeURnZzVENStaMlk4Z1VKRElmbHdkcmZBTTNTUzc5TUI3?=
 =?utf-8?B?eVl6cW1jZHBFeGRadEtBNVpPS2tySnhLS1o2anl6TXRoZ1BPakRQM00xaDht?=
 =?utf-8?B?UnlsL1lpUGsyR3paWEZUa0N1dXlyQlBUSTlLZXdWVmVJam9KeWhVQUowY2tO?=
 =?utf-8?B?bzNOSzlLTHJUVGdTVE1YTVo5NmtqY0pCQ3RIYWtiVnhoOXpuYlpNczFwN1po?=
 =?utf-8?B?dGRaSEF2N1ZHMW9nQmUzZFUzYUFYamdBMCtHT2tKT1psc2N4eGRGZnV6Yy9C?=
 =?utf-8?B?UGZzcVREdDlxYmRUb253cllZZ1pyUE9rUURFU2xWRXN3TzZaWGNVcXh2VW9P?=
 =?utf-8?B?T1pkeDZWRHp5UXJpY1NqSDFlN2UyZGFZV3FCYXlkVHp6YkZud3ZHN3pnRkFW?=
 =?utf-8?B?VHduYnZjakN5T2FVMVo4ZjA2R0krWHBYaDc5ckcxKzl0NGlBWHRmV0h3NmRK?=
 =?utf-8?B?MnhhaXd0eXFmcTBwRjBTTSs1WHk3azNsVGNqOHFxTmIxK0l6OWg1eVZpZUdy?=
 =?utf-8?B?S0JhYkFPbCthWnVQVmdpeUQ1TFBIOWcvclNJMkxlS1A2VzdHbm9JTWp3U2l1?=
 =?utf-8?B?bDBGVjdQRFZrc21yUVdJZ25qL082U3FkdVlWc3dPM2xWcFlQRGVtOWtLeXd2?=
 =?utf-8?B?eUFiM3ljdngxWC9NTXQzdEUrM0NMbktnU28xaUtXaGlDT2pZRS9nWHgvNWl5?=
 =?utf-8?B?cjd3aTBFa1F2cmFqK2tRV2xQS0M4emVNZlNhcW5NeDJNb2EzZkM2K3ZVVFF3?=
 =?utf-8?B?bFZKWGhXeGozNk9wOWFaSndWemZDMHN1T3lDWnRKeDluNytJQk0zcjdRSU9Q?=
 =?utf-8?B?Y1ZDa2F0WHQ1V3pGeUNSTzJLSldNSEgvUk9Uc3dSTHJIVTlqbTJrMUNOZ3pm?=
 =?utf-8?B?aVZwWEJwVXFqMjZOUktHVkF0UzZzbEhaVWJ6VFZkVWZxOEp3bG9GN211VWR2?=
 =?utf-8?B?MXRrSzVjbDJveHpOYTVQMTcwWTJ0MTd1a1BHcndVeVc1REFmeWEycVBxUkts?=
 =?utf-8?B?UEhnS1cwSEN5NnFvK01KKzNNczBDd1FWZjg5eGptVXIrNkRCSjVwRlgvdW53?=
 =?utf-8?B?eEZzU0I5YkRqUkhvcEhqMis3OXZQZ09DQmoyK2pCMW5Wb2Q3K3RTOFVja1dR?=
 =?utf-8?B?R0R2bU1NRUc1RlhmSUQvWHFiT01vTkNjdE1yZHI3d09vSUNqREwrTlJPMUp4?=
 =?utf-8?B?S29qV3hSOVhTL0I1UFRNOEZOSFptRTFiT0cxdnhURzJOWXRPbGx0NktQZzdp?=
 =?utf-8?B?MnIrS0NoMVBqdjhWL0ExRzhXN1VqN1NzenREZmhta2FBdEh2RjFKZFZxRmJh?=
 =?utf-8?B?YWUrT240MFNWcFJPWDNnejRJYUQ0VUx1aE0rb1BXTFpXZlF2aVErNHZ1elI5?=
 =?utf-8?B?YWpuK3lzTE9EaGJKd042WHlmc3JmTVZyZUlXQnVaSlR2M1ZETjlFYkl2cnFM?=
 =?utf-8?B?NGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab24a63b-daa4-4d7d-8fd3-08dd7b6ff346
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 16:18:10.9109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySclbgqLU6tuy18cBZhymIl8n8UQQR3vaUsdgHSPPw+0/bMlPmBFWNTUjCRl6HOUhSLzHuLtzbywKiFL0zoLph+3hxKpbAoT2PMdX4XVawk=
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
amVjdDogW0ludGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldC1uZXh0IDYvN10gaWNlOiBEb24ndCB1
c2UgJXBLIHRocm91Z2gNCj4gcHJpbnRrIG9yIHRyYWNlcG9pbnRzDQo+IA0KPiBJbiB0aGUgcGFz
dCAlcEsgd2FzIHByZWZlcmFibGUgdG8gJXAgYXMgaXQgd291bGQgbm90IGxlYWsgcmF3IHBvaW50
ZXIgdmFsdWVzDQo+IGludG8gdGhlIGtlcm5lbCBsb2cuDQo+IFNpbmNlIGNvbW1pdCBhZDY3Yjc0
ZDI0NjkgKCJwcmludGs6IGhhc2ggYWRkcmVzc2VzIHByaW50ZWQgd2l0aCAlcCIpIHRoZQ0KPiBy
ZWd1bGFyICVwIGhhcyBiZWVuIGltcHJvdmVkIHRvIGF2b2lkIHRoaXMgaXNzdWUuDQo+IEZ1cnRo
ZXJtb3JlLCByZXN0cmljdGVkIHBvaW50ZXJzICgiJXBLIikgd2VyZSBuZXZlciBtZWFudCB0byBi
ZSB1c2VkDQo+IHRocm91Z2ggcHJpbnRrKCkuIFRoZXkgY2FuIHN0aWxsIHVuaW50ZW50aW9uYWxs
eSBsZWFrIHJhdyBwb2ludGVycyBvciBhY3F1aXJlDQo+IHNsZWVwaW5nIGxvb2tzIGluIGF0b21p
YyBjb250ZXh0cy4NCj4gDQo+IFN3aXRjaCB0byB0aGUgcmVndWxhciBwb2ludGVyIGZvcm1hdHRp
bmcgd2hpY2ggaXMgc2FmZXIgYW5kIGVhc2llciB0byByZWFzb24NCj4gYWJvdXQuDQo+IFRoZXJl
IGFyZSBzdGlsbCBhIGZldyB1c2VycyBvZiAlcEsgbGVmdCwgYnV0IHRoZXNlIHVzZSBpdCB0aHJv
dWdoIHNlcV9maWxlLCBmb3INCj4gd2hpY2ggaXRzIHVzYWdlIGlzIHNhZmUuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBUaG9tYXMgV2Vpw59zY2h1aCA8dGhvbWFzLndlaXNzc2NodWhAbGludXRyb25p
eC5kZT4NClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2FuZHIubG9rdGlv
bm92QGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2Uv
aWNlX21haW4uYyAgfCAgMiArLQ0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNl
X3RyYWNlLmggfCAxMCArKysrKy0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvaWNlX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2ljZS9pY2VfbWFpbi5jDQo+IGluZGV4DQo+IGQzOTAxNTdiNTlmZTE4NzNkZGFiNzgzMjNjZGMw
YmJhZWE2YWQwYzUuLmQyN2U4ODE2YTQ4ZmVmNTAxNDE0OA0KPiBjYWUyN2U1MmMxODAxZWFhYWRh
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX21haW4u
Yw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX21haW4uYw0KPiBA
QCAtOTExOCw3ICs5MTE4LDcgQEAgc3RhdGljIGludCBpY2VfY3JlYXRlX3FfY2hhbm5lbHMoc3Ry
dWN0IGljZV92c2kgKnZzaSkNCj4gIAkJbGlzdF9hZGRfdGFpbCgmY2gtPmxpc3QsICZ2c2ktPmNo
X2xpc3QpOw0KPiAgCQl2c2ktPnRjX21hcF92c2lbaV0gPSBjaC0+Y2hfdnNpOw0KPiAgCQlkZXZf
ZGJnKGljZV9wZl90b19kZXYocGYpLA0KPiAtCQkJInN1Y2Nlc3NmdWxseSBjcmVhdGVkIGNoYW5u
ZWw6IFZTSSAlcEtcbiIsIGNoLQ0KPiA+Y2hfdnNpKTsNCj4gKwkJCSJzdWNjZXNzZnVsbHkgY3Jl
YXRlZCBjaGFubmVsOiBWU0kgJXBcbiIsIGNoLT5jaF92c2kpOw0KPiAgCX0NCj4gIAlyZXR1cm4g
MDsNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNl
X3RyYWNlLmgNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3RyYWNlLmgN
Cj4gaW5kZXgNCj4gMDdhYWI2ZTEzMGNkNTUzZmExZmNhYTJmZWFjOWQxNGYwNDMzMjM5YS4uNGYz
NWVmOGQ2YjI5OWI0YWNkNmM4NTkNCj4gOTJjMmM5M2IxNjRhODgzNzIgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfdHJhY2UuaA0KPiArKysgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3RyYWNlLmgNCj4gQEAgLTEzMCw3ICsxMzAs
NyBAQCBERUNMQVJFX0VWRU5UX0NMQVNTKGljZV90eF90ZW1wbGF0ZSwNCj4gIAkJCQkgICBfX2Vu
dHJ5LT5idWYgPSBidWY7DQo+ICAJCQkJICAgX19hc3NpZ25fc3RyKGRldm5hbWUpOyksDQo+IA0K
PiAtCQkgICAgVFBfcHJpbnRrKCJuZXRkZXY6ICVzIHJpbmc6ICVwSyBkZXNjOiAlcEsgYnVmICVw
SyIsDQo+IF9fZ2V0X3N0cihkZXZuYW1lKSwNCj4gKwkJICAgIFRQX3ByaW50aygibmV0ZGV2OiAl
cyByaW5nOiAlcCBkZXNjOiAlcCBidWYgJXAiLA0KPiArX19nZXRfc3RyKGRldm5hbWUpLA0KPiAg
CQkJICAgICAgX19lbnRyeS0+cmluZywgX19lbnRyeS0+ZGVzYywgX19lbnRyeS0+YnVmKSAgKTsN
Cj4gDQo+IEBAIC0xNTgsNyArMTU4LDcgQEAgREVDTEFSRV9FVkVOVF9DTEFTUyhpY2VfcnhfdGVt
cGxhdGUsDQo+ICAJCQkJICAgX19lbnRyeS0+ZGVzYyA9IGRlc2M7DQo+ICAJCQkJICAgX19hc3Np
Z25fc3RyKGRldm5hbWUpOyksDQo+IA0KPiAtCQkgICAgVFBfcHJpbnRrKCJuZXRkZXY6ICVzIHJp
bmc6ICVwSyBkZXNjOiAlcEsiLA0KPiBfX2dldF9zdHIoZGV2bmFtZSksDQo+ICsJCSAgICBUUF9w
cmludGsoIm5ldGRldjogJXMgcmluZzogJXAgZGVzYzogJXAiLA0KPiBfX2dldF9zdHIoZGV2bmFt
ZSksDQo+ICAJCQkgICAgICBfX2VudHJ5LT5yaW5nLCBfX2VudHJ5LT5kZXNjKQ0KPiAgKTsNCj4g
IERFRklORV9FVkVOVChpY2VfcnhfdGVtcGxhdGUsIGljZV9jbGVhbl9yeF9pcnEsIEBAIC0xODIs
NyArMTgyLDcgQEANCj4gREVDTEFSRV9FVkVOVF9DTEFTUyhpY2VfcnhfaW5kaWNhdGVfdGVtcGxh
dGUsDQo+ICAJCQkJICAgX19lbnRyeS0+c2tiID0gc2tiOw0KPiAgCQkJCSAgIF9fYXNzaWduX3N0
cihkZXZuYW1lKTspLA0KPiANCj4gLQkJICAgIFRQX3ByaW50aygibmV0ZGV2OiAlcyByaW5nOiAl
cEsgZGVzYzogJXBLIHNrYiAlcEsiLA0KPiBfX2dldF9zdHIoZGV2bmFtZSksDQo+ICsJCSAgICBU
UF9wcmludGsoIm5ldGRldjogJXMgcmluZzogJXAgZGVzYzogJXAgc2tiICVwIiwNCj4gK19fZ2V0
X3N0cihkZXZuYW1lKSwNCj4gIAkJCSAgICAgIF9fZW50cnktPnJpbmcsIF9fZW50cnktPmRlc2Ms
IF9fZW50cnktPnNrYikgICk7DQo+IA0KPiBAQCAtMjA1LDcgKzIwNSw3IEBAIERFQ0xBUkVfRVZF
TlRfQ0xBU1MoaWNlX3htaXRfdGVtcGxhdGUsDQo+ICAJCQkJICAgX19lbnRyeS0+c2tiID0gc2ti
Ow0KPiAgCQkJCSAgIF9fYXNzaWduX3N0cihkZXZuYW1lKTspLA0KPiANCj4gLQkJICAgIFRQX3By
aW50aygibmV0ZGV2OiAlcyBza2I6ICVwSyByaW5nOiAlcEsiLA0KPiBfX2dldF9zdHIoZGV2bmFt
ZSksDQo+ICsJCSAgICBUUF9wcmludGsoIm5ldGRldjogJXMgc2tiOiAlcCByaW5nOiAlcCIsDQo+
IF9fZ2V0X3N0cihkZXZuYW1lKSwNCj4gIAkJCSAgICAgIF9fZW50cnktPnNrYiwgX19lbnRyeS0+
cmluZykNCj4gICk7DQo+IA0KPiBAQCAtMjI4LDcgKzIyOCw3IEBAIERFQ0xBUkVfRVZFTlRfQ0xB
U1MoaWNlX3R4X3RzdGFtcF90ZW1wbGF0ZSwNCj4gIAkJICAgIFRQX2Zhc3RfYXNzaWduKF9fZW50
cnktPnNrYiA9IHNrYjsNCj4gIAkJCQkgICBfX2VudHJ5LT5pZHggPSBpZHg7KSwNCj4gDQo+IC0J
CSAgICBUUF9wcmludGsoInNrYiAlcEsgaWR4ICVkIiwNCj4gKwkJICAgIFRQX3ByaW50aygic2ti
ICVwIGlkeCAlZCIsDQo+ICAJCQkgICAgICBfX2VudHJ5LT5za2IsIF9fZW50cnktPmlkeCkNCj4g
ICk7DQo+ICAjZGVmaW5lIERFRklORV9UWF9UU1RBTVBfT1BfRVZFTlQobmFtZSkgXA0KPiANCj4g
LS0NCj4gMi40OS4wDQoNCg==

