Return-Path: <linux-rdma+bounces-21152-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP2KE605EGqeVAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21152-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 13:10:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE4C5B2C3C
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 13:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A28D7303D353
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9573CEBBD;
	Fri, 22 May 2026 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMbVUmi0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5143947B8;
	Fri, 22 May 2026 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779448110; cv=fail; b=SUAJvsgxe/BSVWYVRdFAL4ZBwwbbb2dXtUlGVyZispJ8O92p/vWQwxk/I57mZ2wpCaw7J/520967iPl7xXGX9aJoB9/5FvwYhwDc6B1DHM0K7gZYTxEXXadOMB04NPP3A71Z1+iq+ETZr38prW9QK14jfMNbLBaepbA+oI6vdV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779448110; c=relaxed/simple;
	bh=XQRnxOEMV1R0Gy//YCsa6yKM5h8o1Hrt3mY8iXXSH6E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bpRaiMcspaXUPJvtbmeu3SroT0f7a8rh4JYW7xdN++OWZ5fE1PTCaNaetN+U87HYjWD4aJLMzK3hNZy0tmpc980P8H0yzeYJyzl4IffMnnv7PaQatFlijFFFBtYoGKRJSNQenT3KjzkakprEhArlLGaCaFIB7n3xhO/184iGivs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMbVUmi0; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779448107; x=1810984107;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XQRnxOEMV1R0Gy//YCsa6yKM5h8o1Hrt3mY8iXXSH6E=;
  b=QMbVUmi07d3nvcA7EtmFb4UnVJwji0RsCROvJ5k5xr2N2vKQWDcgwt08
   gr3taceFascdUXS/emu/5weUV6mDUHBuYJFgfV9yIHTEmB2E7a7hxhKcE
   qazL6x3FCeo8aGH+GCF9eeSWsQs8rDQjb/8JIjVn7cMvjsFpbz335My1h
   UoYAGpjimJf/sH3AePzEi+y87aRyB0se85+FM+RcOWjizvr69HYUsA/ID
   F42cXw+m9/0aZNqfSI2yGFVukLmU0eDW0oempVZX18PJtyTgOIX5YmTlT
   o3M8DzyxSkrUsPZR6npaGqmsGkJ29Z9NdhC1XYNpk7SehHJnFkxRnuUtX
   A==;
X-CSE-ConnectionGUID: aeAzqtfkTh2AGjaYE7IgiQ==
X-CSE-MsgGUID: 07ObPb4nTsW0fWMQ6awE/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="84231961"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="84231961"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 04:08:27 -0700
X-CSE-ConnectionGUID: bIRAEN24T+21PFYBELBwOA==
X-CSE-MsgGUID: s6zGmp7pSie9SeMtzBaM+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="245948931"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 04:08:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 04:08:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 04:08:25 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 04:08:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8OiWsMyoHwPlpQQVbLsgQ8Dc1zrNH5jSkKsFKk2agDgY76S3g3TGnKNcO3FXSQgcTlQh9tqvUE+r55IBG3YXhvE4PSZMQ8EedW7YtYJbKKzyKT2+rEgyvd813cQR6fhAC2WxhJF3Q9QB/ywj1fJWDGcxd/0ZIC2nfZZ3v90qWsJHtms9m6tzeL8vr69Eu0n0ktjfZ59DAEUvKGERkq4X2EeyrzgKydgISHVGbTa7xufrfftjYJETK+RQDKRkva5FP4wfFzGaKg2suUUUVZaVRQqIQnoUYrHdoi8P6VP++JlNxedO+hmbW1MY0bC5QskOMxiDpCjoIyAOC55jdVwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q74iJH4XQtrdTE5zhyRZsju9ObjRwIOIDZaZl9KWjOs=;
 b=NT+ub3Ij/aGCY1Z7r9aYGRAjl+BZ9c2PevBQrHFmP8KJMzgxCevAFB5Xyb+13uv5kPAE/UyCY+LDZfynsJ9zcZumzBhCfyzXqr67yCFrsv3T0gDYJDcLiGy77ZKr59sogp0JS73VOQhTebyc3WiebBDuRcWS3hxvvX2pC7XnfMELOurikWAEzb9p+DQtMmCSe2KA/cu5VNzeySGZbpXUGaunmFyr2CnGviHjChmA3Z8yhi3JMsUwm8FkqUT8JsXjT/MQbXIwNZcOZpRA5L6LtdKH3ZXYAFtu0MFnVmZMXcBFMLBt0AYtatkQ5FahueCNj6lw2u8RwvW+RfDO+JaloA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB5819.namprd11.prod.outlook.com (2603:10b6:510:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Fri, 22 May
 2026 11:08:20 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 11:08:19 +0000
Message-ID: <5426379b-1201-4707-8d18-21dca3d1424e@intel.com>
Date: Fri, 22 May 2026 13:08:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/14] virtchnl: create 'include/linux/intel'
 and move necessary header files
To: Jakub Kicinski <kuba@kernel.org>, Larysa Zaremba
	<larysa.zaremba@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<sridhar.samudrala@intel.com>, <anjali.singhai@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
	<tatyana.e.nikolova@intel.com>, <krzysztof.czurylo@intel.com>,
	<jgg@ziepe.ca>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>, Samuel Salin
	<Samuel.salin@intel.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
 <20260515224443.2772147-2-anthony.l.nguyen@intel.com>
 <20260520175201.72f83c4a@kernel.org>
 <ag7QUgfpM5UAAE2z@soc-5CG4396X81.clients.intel.com>
 <20260521065609.248c7009@kernel.org>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260521065609.248c7009@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0014.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::8)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c1f0e7-d3d8-460f-c979-08deb7f26e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|4143699003|11063799006|18002099003|5023799004|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: CohmaVs9e+js5mhG2j6/FchnYXHV8bn0R6P7hxUmKuFh2OZ83e63nKmJheWfibvCirIPWF3L+by8U7zuFMxhbKlEEOIsVrLS4Ge8qxeTXAcytn5jhV0R3QDSGxDHLR0wCVbCg6wWBC81bB9B5nRb+LFIi7p9nysAXamy0WOjTZ/1RlkTUo77FlODeVyXaUBENAZL1loZM3X4n7Ag6BRGdBIUbQmsZ4kiEecU2M6R6Mlt4EZ4qI8MPIeVAtDx+E+sxq3IXMlShOfs4mw8XsmkOebQxSkPDjJVuf6jXcG9ohpInpG6NI/fRa1y1Rw1teOFBBIVlPQUjKNv36OT8YFZ5CGX0gE+ybgIvmPXn+2w+sAUP55fhCL6sI/ttnPMZBMw4fnSqO8iulfUb6tPQ6v+7Wk0PudcF4tD2TwNIPQrufW8VEaj6Ie7LQHyxMDoUkxnEylFDZuX8uxBXfpDq1GOsJ/PdW3LB2Opvs6bQDSIGfYedSOGiR/gYRKAB3BTf4Al6RD7qnx+ob6KEdPBuY+ylD4IQATXV3DA4osTMmZ4uAjHMnElABuda4HtZs7SFQMy1QeJ3bUXbIagkoCU/vU2CXD3nZebgp0+yeu2HifX85CqtdVu8rNiixlzbR6wG9OKLVOxrBMLozMMx1S8/30z2Osw4Ek7Eb+GbTo14Tw00MM/bhInwYLjAW4EWGc+bRMQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(4143699003)(11063799006)(18002099003)(5023799004)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTNReTJiUjVHM21KaS9GMnNSYmlQbXBZYXk3aitvTmhycWI4QWR5MWpUUFpn?=
 =?utf-8?B?dWdCb3U2RUtSN2tIYmNKbG8zWTJ1eDZlMnI4dW1GWE05SGVUQld5R1VVVWl0?=
 =?utf-8?B?WndtSEhKVGhkTWJWQy9tOG1Ta0NGMDNwbmtKK1IzaitxcHZ4MUtKTzdkcmhP?=
 =?utf-8?B?eTZaWjdUVFY1QjdiV1ZUNUFSU3VyZ3BaREFRekQvdmFOWHhTOENaU1dFSzNM?=
 =?utf-8?B?UGJrT0hzU09qUmk0OFczMFVSbkF0clo0bUw3em10Y3VLMGwyaEs4Nks3a2RH?=
 =?utf-8?B?MnNzdk14VWFsOXpDeFBla09TaTdmemhWNkJGQVdxNGlwek9tQzBBTTNuTGF2?=
 =?utf-8?B?elhaa29Ha2Q5QWNNeGY5VnluTng1dUMrcUplMWRaWmRUaUdHTlJvejN6RUYx?=
 =?utf-8?B?ZDZVNmxFa2tZb2lHRjVxa1lub2tOczZNeU0yUjdkWW1JdzNVckxnazU5eklM?=
 =?utf-8?B?Y1NxVEduNjZHSEZaNHQ4RU9Kd2VUMzNyVGxKVmVUK0c5NkhSYTR6eHR4dkRs?=
 =?utf-8?B?VDVQN00zUHhWdzF2WUI4cGhnSWVGOHYrQURGRDVjNGtRcHVDUlA4cE4vaWlU?=
 =?utf-8?B?dGVoRVd5RUsrL2JGelhCWTFDbm1iZnAyaEVPR1ZSMm84UE5ZQ3kweVRUd0JE?=
 =?utf-8?B?UU9iK0RRS213bHgzd1RSYjRLMTFNeG9FaVZKTHNsTzNHR2ZJeVhIWHplMkxE?=
 =?utf-8?B?MWh4S1NaZk1HRWd4cnkvZTh4V3Qzb0xuenVRRkQxbTdGdzdDdmRVZ0VPNEZD?=
 =?utf-8?B?ZEJiRzZyS3c0d2R2dDh6WldaRytzcjF0NDJ0Tm5KVGFDL2JWVDNlZHUrRUFp?=
 =?utf-8?B?dHhVL3d3RTNTZVRSNndmd0FBZ3FmRWNBWk8yUkhUTzEyYmdDWXRTd3RrV1hh?=
 =?utf-8?B?Mlpkd2RBeWJ0b2JqM0FKL01UTkpmb3FwZnJISVBlODJYbGFrTzQvOEQ1Kzc1?=
 =?utf-8?B?U2Y1YU9wUnNmUHhhbGNxcmx2dDJxMElxOEFMaHRFVUppa01mcjc1VStwODdX?=
 =?utf-8?B?eEpuWkFHbExKL3c0SDdhaWtOdUtzalBpMU9nUWRWSlZxQndzTjdMZUdZMVdm?=
 =?utf-8?B?bWdVbExpZWpBcmwrd3hMMWZ2T3ZtNjBJYVR2MGhqazJvQ2Frd2dxWlc5cEJL?=
 =?utf-8?B?cW0yY254cGRZTHd4ZXpuWjc2YXExMmpsZzZTZ21SMkJWT0l2bm04S0FEdmI5?=
 =?utf-8?B?QnpyUDU0MHp6cnk3R0RRbmtVdnBrZDN2dU1HMDBTOG9ONDR5SG1BZ1dyWGhw?=
 =?utf-8?B?YVlGQWR5U2o4NWtyVEZwUXJVcysvSGZMT0o5Q1FwODNxSkpDb2ZLd3MrUTBH?=
 =?utf-8?B?aTBKcnd1dWJvZFR6bVBhcW1uWlBVSkJYT3BHN3I2bVo0MHZVSlpxY0w5YklV?=
 =?utf-8?B?RjI1U3FMOVpnZlFHN0ZROFFGY2huYXd5TWxyQVhxVzZ0Z3M3aEpwZGhVeTFu?=
 =?utf-8?B?NDV2NjE1M0EvK0x5LzZCSU9ob3JvbnFleWo2cm1hbzhpZEhjVVF3M2lHaHpU?=
 =?utf-8?B?QWliQ3JPYlFmZ2ZWSXpDSmVhL0M4MXJvbXRlNUdXRFNrTEV5MWhJUFFhYWQw?=
 =?utf-8?B?aHNuTTBEWkVPUHNpdGR4ZTNBRFJZUTdGdnJOdVA4R04xdnBZYzNlSEtEaklC?=
 =?utf-8?B?VW94Q0ZqbXJKV3BZTXZDcHhydXRnZ0NXL1p5T054a05jNVlmMzZ6dXBpNzJx?=
 =?utf-8?B?MzJuZFpBbVFQVElmWFZNTGxoQmduK3ZGKzN6THFYU0Q2SEJubHZsV21zaG01?=
 =?utf-8?B?RGdzTzl0dE1TeFY0MVBEcXVnMUVSY0NzNTh0OFA3NmJmZ1RvZ1NzdGlTbnhP?=
 =?utf-8?B?MDZxcHViNjZNcU0yeXpvTVdZb0JueXR1NzF6dkh5RCtDNStaMlhpa2NFaER6?=
 =?utf-8?B?TU81Vmo5R0h5Ykx4UDdqNElKcnNwRElyN1BReUlVNktvMkYvdmFwUVFxNktj?=
 =?utf-8?B?dUo0emlhMTh1aFhLdU9md2FxTWN6eVdtVHFLcGRpYzZZTUYvRVFSNmNJSWJX?=
 =?utf-8?B?SnF6SURaWGI1UFZHQUNiM0QxbU9EZFc3SXQ5TUhsaDUwZWd2RDRrWUdBbG5J?=
 =?utf-8?B?bFpjNDJ0TWlkQmlBc2Y0d2FjNTVubE82MEsxc054dTVLNnQ5Z2Eza0FqSWlC?=
 =?utf-8?B?cmYrWkRXU3FvNnVBcko5enpON05TTGc1Y3ZoSmxnRzFrdklJdTdqNWJwZ2Mr?=
 =?utf-8?B?Z3d6SmlMaTh2amNMRXVaUEVrWWRSQjNHdXY1YUt5WXp0Uks1NzBVMk16VVVT?=
 =?utf-8?B?cDAzZ2FOMUZraVI0YjZtVWtrMXhINTdwa1NTNGp6aUlmcEVYVUdETEk2dGEv?=
 =?utf-8?B?WGt2NUZTOFp0djROQ1l1bGhEaWV5eTFsaDIyWG43aTl5b2Y1Mm93d1hzU3U4?=
 =?utf-8?Q?/GY2nDYIv3hZs7UY=3D?=
X-Exchange-RoutingPolicyChecked: P7F7Y3PRTc35srEg7eaXXn43kjbg6CMBZ1YcVyxzA4u+EwVjx54PsZ6opH1O5qrvPqpRZkzTjT+M3SCPsJjGRY54ZuraIXpq2E2b3E8w9jSHjMs0CCCCUBWR5SaTWUFEr+nAYXXkGxKcrDuYZv8+RvvF1gQPpA50ifVNRe1y/apNxbmBgW/u0lmWCn8doLKYGR/66s3oLUQm818saaXsGHQMEWSTWl5fbM74N7Rvo5zWRJlb7/W79SOjlm/qtZjq84utTru7SVpK4txNJAoDjLY3GJtkqVFYor4rtD63cfsj721LrzuE3XQiMFj/uttVcVeUxMjqhyfuXb/MISa0ag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c1f0e7-d3d8-460f-c979-08deb7f26e3f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 11:08:19.6701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXb7qMl4g32oezDrmyxodC86izGkUKMkVL1qBBzcKRwDfqYa7dEZN8IRFLxOI8VDBkdaBkMM6NkB9JciPnjqXKMwkgIcp++WSzvTiFPFE4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5819
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21152-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 0CE4C5B2C3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 21 May 2026 06:56:09 -0700

> On Thu, 21 May 2026 11:28:50 +0200 Larysa Zaremba wrote:
>> On Wed, May 20, 2026 at 05:52:01PM -0700, Jakub Kicinski wrote:
>>> On Fri, 15 May 2026 15:44:25 -0700 Tony Nguyen wrote:  
>>>> include/linux/intel is vacant  
>>>
>>> I don't see any other vendor directory under include/linux  
>>
>> There are at least
>>
>> include/linux/mlx4, include/linux/mlx5 and include/linux/bnxt.
>>
>> Those are per-driver and not per-vendor, but intel ethernet has too many drivers 
>> to have separate folders for them.
>>
>> I just do not think this creates a precedent neccessarily.
> 
> You just said the other ones are for specific drivers.

Right, but according to your earlier suggestion they belong to
include/net, not include/linux.

My understanding is that they're under include/linux, not include/net as
mlx5 is not only about Ethernet, but also RDMA etc. The same applies to
Intel's headers.

What's your position after all this? Still include/net/intel? This
commit is about stopping scattering Intel headers all over include/linux
and set one place for them.

> 
>> Folder structure is for you to decide as a maintainer, but it would be nice to 
>> have known about such doubts earlier.
> 
> I'd love to know if you any suggestions for improving the process.
> Otherwise please keep your venting off list.

I think Larysa just wanted to say that you disliked this commit after
the series went through several iterations on IWL and 3 iterations here,
nothing more. It's not about the overall process.

I also had a couple such moments in the past, but well, a review or a
comment can happen (and are valid) anytime before the patch is taken to
the tree, sometimes even afterwards and then we send fixups.

Thanks,
Olek

