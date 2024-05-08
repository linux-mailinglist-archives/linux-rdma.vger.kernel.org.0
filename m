Return-Path: <linux-rdma+bounces-2333-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBBD8BF40B
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 03:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273B51F23596
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 01:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641D58F4E;
	Wed,  8 May 2024 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8zYU2E0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C33DC2C6;
	Wed,  8 May 2024 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715131465; cv=fail; b=iUcCplr4ZE3Gf3LUL36MzeuXbjtrsOFcOWChzX0EMGEswaaWfvFoUfr1du0k6k/0/sQIRxDzFlKCyvlbAe7ZNxV4rCxMcLAXo57jmsL2jCGg2Y5rnCfLxRBTI38skmiDOUSkvkyMrxy+9zvMPsAcyxn9bPpdnTgcKIDRAfjBL2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715131465; c=relaxed/simple;
	bh=R14JAwZjzH6XEn4fY/RxYRdTkiIu2GIE0kBERvlWWqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QAbe1aGF5ZHua23Y1kVIbbBlhfKLagnyhIWxrZd3GD2glP+xOgL3KxB17BxfHXPBQ9hOEdC0MnCW5HOT2VPpaki7eRHfwFActBFbwZfMFcMvfPvGLegl2w6L6aqy13sXy0dOWDcZ9J6kLFCxgyW5uHTk/jawTRsN434G6OykplY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8zYU2E0; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715131464; x=1746667464;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R14JAwZjzH6XEn4fY/RxYRdTkiIu2GIE0kBERvlWWqE=;
  b=c8zYU2E0UMeaKpK7vDsuWMZwQ5zGt6d6oFM+6zDz3wdgvxU0ALhqVsQu
   BXynNPm/1udNyADEuOXlU4P2lKcfcFtoLRL/CuystbE8waYVxK++3Ml75
   AWzShfOpqFCOXCZA79zCQmBooARluP/f2x21TMYaOPSTBPjNZVxv1Txqf
   8IveCTG8iFADwA0FORyKWlRxOJ7cPPI7Fi+Ed7XOUNZ2yxz+PRLo520LK
   8kA9L9Sz9SFuaYCOGsc4vcjTMvt4CUoia7rfe2B+PcVA99QWQNjCtRkBP
   wqEJzGfoKkFCeP9XQlT/+6yBhmVq5pKvPax76eHx+vvkFVR0MlBrY42DF
   A==;
X-CSE-ConnectionGUID: DVmm4VklR8+biW4t5n64ng==
X-CSE-MsgGUID: lPZWmDNjTJmcqe01ZMtssg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22357937"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="22357937"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 18:24:23 -0700
X-CSE-ConnectionGUID: Z8MCKHxjR/+t7tEF7wZt8A==
X-CSE-MsgGUID: 9qN5Tu0KTuaAsShPXauhrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="51913745"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 18:24:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 18:24:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 18:24:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 18:24:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 18:24:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8if9xRywYYmQ4MFOjtRXh6pYs6eEIEBS7MBU7e0NczqgOdhH9ez8CQ/N5zhf5ZjR1LiuYFXXobS4fEDrU8PPSsFQfCdmc8PDHRHABHzcihCI0GAZlHQ/fS0igTtd/Z+hDvVKCXjxU4WXuQVoE442CT03ENNJNavcCa/bo7ntgc+954y18SMI8N8MfXInf/rSG5jJXhJq7N/zL/05romnKf62KbgJhha06IGaZBFbd66odFV3CjG+1UAe51RP7hqXWYl8VAKltovJgrxhQ4JbM0hh8Aq6Cbe3iQgDmAcfGUdpOJw0DMDHhXtEu0v2dQUS8IQND7Jw8h0drKVcGuA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R14JAwZjzH6XEn4fY/RxYRdTkiIu2GIE0kBERvlWWqE=;
 b=Nh9IoEv5CHcmBkT2Nqa37mcHjHuGhQDk03GXirmKo17TcoGmoXjy9lWWeoK8XHJ6tpUrRvDQI4NLh0uInMSOYwEzZ0IxZ5PxMiYPyd545PJkGkkiK5YwGLOlFIdS5TB7xN9sB9suRokobfJ3Ki13UdoiacUtuJgSUXVe1aJxC72bjoiyPw4JIb2+vBPzkzU2rp0w/g7mqGgTwk7Fr8j4mN3px337k5ShdPiyfYMwr9MirfIBpCIz11/qzxWiJZXvW9Qo1Zm811Ztpg4DxVx5Y5+0G787DMwXtmsV9zQvwyUlpEmSfouJ+IU2iQGL6vl0qF2pc+JEkrpKxg7Mo9cG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7317.namprd11.prod.outlook.com (2603:10b6:208:427::6)
 by CY5PR11MB6415.namprd11.prod.outlook.com (2603:10b6:930:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 01:24:18 +0000
Received: from IA1PR11MB7317.namprd11.prod.outlook.com
 ([fe80::1ab6:9756:350b:dba8]) by IA1PR11MB7317.namprd11.prod.outlook.com
 ([fe80::1ab6:9756:350b:dba8%5]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 01:24:18 +0000
From: "Saleem, Shiraz" <shiraz.saleem@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <yanjun.zhu@linux.dev>
CC: Konstantin Taranov <kotaranov@microsoft.com>, Brian Baboch
	<brian.baboch@gmail.com>, Leon Romanovsky <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"florent.fourcot@wifirst.fr" <florent.fourcot@wifirst.fr>,
	"brian.baboch@wifirst.fr" <brian.baboch@wifirst.fr>
Subject: RE: Excessive memory usage when infiniband config is enabled
Thread-Topic: Excessive memory usage when infiniband config is enabled
Thread-Index: AQHan8k5Y8WRIS0mX0GO22EGrPRY7LGLo4UAgAAeMQCAAATbAIAAH0SAgAAUb4CAAG6LIA==
Date: Wed, 8 May 2024 01:24:18 +0000
Message-ID: <IA1PR11MB7317B56B84421912ED6E856CE9E52@IA1PR11MB7317.namprd11.prod.outlook.com>
References: <2b4f7f6e-9fe5-43a4-b62e-6e42be67d1d9@gmail.com>
 <20240507112730.GB78961@unreal>
 <8992c811-f8d9-4c95-8931-ee4a836d757e@gmail.com>
 <PAXPR83MB0557451B4EA24A7D2800DF6AB4E42@PAXPR83MB0557.EURPRD83.prod.outlook.com>
 <fa606d14-c35b-4d27-95fe-93e2192f1f52@linux.dev>
 <20240507163759.GF4718@ziepe.ca>
In-Reply-To: <20240507163759.GF4718@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7317:EE_|CY5PR11MB6415:EE_
x-ms-office365-filtering-correlation-id: 946cb930-5b2a-4313-6d69-08dc6efd94d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZnluY3hCb1ZmVmpXWkNYSmRKSzJabjBtVlVENFl5aXF5eE1qcTJVL0QxVVBt?=
 =?utf-8?B?K1gvZzJPVXVzb3R0eWVUY3ZCS2tla1VIYkVDVk1Ua242RWxRbW44SkJnekRz?=
 =?utf-8?B?TFpTcmF6cjE3bWF1YnF2Sytoc1Zaank1WXZwVG9TZmk3VG9XVnZsS0l0eGYr?=
 =?utf-8?B?TTIrVzlpUnJwcEp4b3ZSay9iaFBuLzhxSFlCK1VzUnBJbXZ1REJTQmtoQndX?=
 =?utf-8?B?M040T2xYQ3gzKzlhbHVNSkUzVlAxdlFOY1ovS3FkM01NRUtpbWl4UFZMNWN0?=
 =?utf-8?B?b2cwS1ZkTStqNXkydHMrd1dsM2tVbitpYVl0V25maURnUm90bm5RdVAvYkxH?=
 =?utf-8?B?T0oxbjB2MlovZUMvL3MwcmlkTE1lVWxGanhqRkJKYXVhU3UxS3NBWFhzaTBt?=
 =?utf-8?B?UWZFcmJDRnZpMjF3alVVcGdHWUY1aVhickpRUGEyL3VqMVNaUGlrZVhINzZ0?=
 =?utf-8?B?UXZCQW9LYlFRZDFhSkFFWnFtQlRlMUQ3Tjk5TThOWW8rc09wbkx0SHN5MGhL?=
 =?utf-8?B?WW0vSUpsQ0FkaVZvUGtBYVY0bUxacUwvY3hxbDk1RVIyU0ZkbmJsaEU2d21a?=
 =?utf-8?B?OW9mMml0alE3WDVRNFR2aFEzNGdZZHE2azRMdEI3QkQrZ2VQTEJ0ZEZIbUZG?=
 =?utf-8?B?elBwY1FIWFBDb29SZ0Ztck5tQlRQbUE4UGlrVTg0alBiQmZHRW5aMlMydUxo?=
 =?utf-8?B?OTZZTkFqM25vVVVFbjdwbVRNczJIWlpNcTRoQVV2V0tZM0hxczMvQXNpaXJv?=
 =?utf-8?B?VldEdmlkbWNGWG1SUE0vSTZHTnU4R09YTG8rdjJCVXd3a0J5S0x1eDhRbmhL?=
 =?utf-8?B?Q1dvZDdKWjRtNlZUTlM0ajNlRml3cm43cXp1YndyZ3FFdCtnclhqeC9rc01h?=
 =?utf-8?B?REJlbDAxWHAxb1NZUzdnWU01RDY4eVUzWkoyNTRUdzlmUkFKKzNzeERsV0FJ?=
 =?utf-8?B?bGtPcVl2SGtQUVJ0M3kwUEk3SDJ6N0QrUng0UEJwTlg3Mm1LMmMxQTd0V3NZ?=
 =?utf-8?B?c0piRGE5UlBOeTdDcDE5dXNVNnk3WXRFalBJbmdMQVVOS093YXdnS0t0Z3li?=
 =?utf-8?B?TndkbHhnSjNzcWJoUkdDbERQYW5nRXZGQWl3L1VNQTdmREpmdHV0ZUtPa3c0?=
 =?utf-8?B?WVJETzh5VE9XZjVzRktKSUJkSW52YUhBOXZSYXllWm5qZGYraVp0ekxtUEJ5?=
 =?utf-8?B?b3BEUVV3WXVVTmc4K0NCY1Y0ZU15RCtCVjhCSzhqcldBU1hOZDhJNXNJNElY?=
 =?utf-8?B?STVJSis2MGxTUi9jbHA0dnNDb0dKWjBDd0ZiQTE1MHFjYlc3NW5lM3hzZloz?=
 =?utf-8?B?RGFrZGNJMnFDV1B2YnRhaHE5OWhhRFVNalhIY084ZXlGR1p1MEdiUm85Wno2?=
 =?utf-8?B?b0VxZktHY2pFbE8yQXRjU3NZN0k4OWRuMEJnSHlEQmpwNDVVNkpnS1VtUEFo?=
 =?utf-8?B?UEIyWUdsa2ZaNWIyUzh2TnEwNG5NZHN6VFM0c21LVWU5TDZtZUp6ZFFTamlJ?=
 =?utf-8?B?ZHNzT21mZ3lmUmlwMFVKZ2xwRHRNR0hYU0FVVi9HUGozNVVCUFBBMVVlUk5n?=
 =?utf-8?B?M3grZk9CdjlaQWFFNkZ0eGt1VGxOZ01CLzVzSU1GOWpZSTJYeUU2QlAzTzN0?=
 =?utf-8?B?Y1lHUVZ6WTFhZm1YdW4valBhM0JxN0h5Mis1OEhYRWtaMFhVUUVEZzZhN2Rs?=
 =?utf-8?B?ZGVqMFFldkNIUkNMQnRxZWVOSGFxRHNGNE0wR1VzQVRtZWFtNWgwa29hWmR5?=
 =?utf-8?B?RWZlcjQ1bjhMRytwczFBRUV1UzB2T05meXBDc2tYVjFpMStVZ29KY0xuRDFD?=
 =?utf-8?B?S0lvcjNkWURldnRCelVYUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7317.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3lIYTBObmltSksyY2JBN0s5TUxTaW5RcTFvZ1czanZ4elc0Ky84WlBUQ2Mw?=
 =?utf-8?B?NEZ3V1k0RGZxNzBKUXVQdUJNNG1WUytGcDB5clJoMnVYeDdWanFBcnRHbjRK?=
 =?utf-8?B?U0w5anA5SEdiMC9XNFBGbGd1MkFRTEJaejI3WXk1V2ZVQjZ3T2hJNWZpYldR?=
 =?utf-8?B?b0hUVjFIQVMxVmZxTGFDNVdoNUNyUDhtTC85WkVSZzVad0ltVHJudXM2RElM?=
 =?utf-8?B?QU1JaHo0UmxIeHdzR2JhaThZVC9UN1NseXVFRmgzOEovUUVGMFRzZmRTc2xV?=
 =?utf-8?B?WDd4TDRVWXhQVUFURnJFUGFLNWpXb2xHT1hYVDhRTmZNNVhTZzRtZTZmUUhi?=
 =?utf-8?B?YndMdnh4ZWtFWnJCMWx4NERBUlpaUzhwOVZTTjZOa0E4dUZIc0NxUEFJUS9W?=
 =?utf-8?B?T2FaU1QrZGZuTGNNam51SzJmNDlHWnAvdDVYSDVuQUxFdE5XQm0vOU52M1Jh?=
 =?utf-8?B?WEY3WHEyRXdZc1RDamhFSDgrRzJ4T3NWRmF5RklQUnFmdG1SS0ovWTEyWDRI?=
 =?utf-8?B?Vkh3UmJwZzUvS0RCQ3JxbndKR1RMblUyNDd6UVNyVDNBd25ZYnNjNTczTkdO?=
 =?utf-8?B?ZzNwNi9iSXhXS2xDRDY0QUhxVkNFUGJoRTdFTXlHREdoQklVRnN6elhKZHBr?=
 =?utf-8?B?SVVGbXlBTkp1N3J0ME1mem5NeU9yTHdwWGpYbnhNQTNVMHZ1bS9VS0sxc25V?=
 =?utf-8?B?d2M2OGEzemZUSkxWek1TQ01GOEdWZmRqSjFsREJ1ZE1haGdaM09YeGNUY0JI?=
 =?utf-8?B?bW9CQk9sMEZoaXVWNG1EQUlDLzMwczNINlNvQUVvUk4vdDNobkx4aHYzd0lL?=
 =?utf-8?B?MEZLbUgwMFRSaWRhbnJDd2JNVE1MakxrWWZoYTZOeXpzR3R4RER5a29aT0Qw?=
 =?utf-8?B?VHE0TUZuOFB5bnd2L0oyenlGVVNUZWhrdnhCSFhjeDFhaUd0UGNNWjhTSTQx?=
 =?utf-8?B?RHZmSXA5ZmY2YnRhcEwxbndMSGcrQ0F1Q0w1bG9SZWRSVW9RTWNpZUdZNFpm?=
 =?utf-8?B?ME4zV3cyQUgrYnZsdmxxTitDTURGVmpjRlI3RysyMkVINURxeGJvbjRPajVB?=
 =?utf-8?B?NDAzM3lFZnpEMUIwNTJuVnZEaER3S2tocTJST3FxRU82Ty9yaFRsYWVuQnhk?=
 =?utf-8?B?QUVQSEVXVXAxQmtRcG5lUXVxZXhSQjF5Sk5YR1hzODN5UVBVSTYvWkZ0VWJJ?=
 =?utf-8?B?VHdPbnNpWDdoN01iWlBLS0Q2SlJWZyt6eVpveXVrc0txcjh1Vi9CalJUb3FL?=
 =?utf-8?B?RjZEbkdQZ3FzUkpWSmFKaHBFd3NsUCszV0phS0l4c3NwSGhacFMrZXVEQlNh?=
 =?utf-8?B?cndRYkRCN1VBeGs1eVJrSjNLSE1EbG11Z2lhYkdleTJOY1ZFVXZ2MWRwcDRr?=
 =?utf-8?B?RlJoTzNGWlpxSVZtSFA2K2JuWkROQWk4VThTMElXTWVIeHFpdjRZem43SEJ0?=
 =?utf-8?B?VXlISWFOdnpVeUdsclZUcEVDeDZmQmo3N3VRejd3TTZacEN1NjRkR1Qzb3pz?=
 =?utf-8?B?aDhxOEFZOStoYWRlNjdlSHhhT0RRRlVyTjBWWFRFU1A2d2dTMHk1Y05LbmpB?=
 =?utf-8?B?ZDY3L3E0cml5SkNYdFd4UHp6ZnZVUVAxZ0lJaFkyR05UOXRpNzVwVzZKdmF0?=
 =?utf-8?B?N3hsSCtxcjUyQ3VtZDFuOEJiRVZ0eXBUc0JyWUpVbGhraFlBOC96Q1VsNE9K?=
 =?utf-8?B?ZkVoRHlUa2ZpcllHZkY1OXhtaXlqMHozc0YyNlZJaGRsbzhZVGN4MW5nRkU4?=
 =?utf-8?B?cXNudEFrVjRaR0o2R1Q1Mjg3K3Z4elJZZ2tuT0hFckxCRkt6NHZQWUZXUnVW?=
 =?utf-8?B?V3hmZG1JZ1YvVjFIMm5wdXpDaEt0R1hWanlYUzdrR01KK3gyVU0wTE14a1Uv?=
 =?utf-8?B?SzZEQlFnYkkvYk5SZnFEYnR0ZEdsNGlTZVBpZkVGNXBsVDBSdDA3czZ1OEpC?=
 =?utf-8?B?VXl0UGlaaHp4Zjd2b09nNmxGZ3I2bkRPcFZNSm94Q0ttVXpFaDZuT24zbGpa?=
 =?utf-8?B?R3RVR2lIVkpOVFBicXMvUmc0YU9YczB0bit2aVNYTFlMUzYySnhTZzZ0ZXR6?=
 =?utf-8?B?S2F4N012RlplMURkSFJ6ZHBPa1RKQ1FuemppK25lK3l2WlFBZ3pobEQwSTRk?=
 =?utf-8?Q?jTh4xSt30Xh/hvCPuqD3lM9p6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7317.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946cb930-5b2a-4313-6d69-08dc6efd94d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 01:24:18.2084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuM6pk2+ZuDuFvAtyqhTzZ0U0b1iT2XyDZjtixO+2DFtIi6NJggqMdO5amWg6l37prEaPm+ce1X1cQAMIysWAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6415
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSZTogRXhjZXNzaXZlIG1lbW9yeSB1c2FnZSB3aGVuIGluZmluaWJhbmQgY29u
ZmlnIGlzIGVuYWJsZWQNCj4gDQo+IE9uIFR1ZSwgTWF5IDA3LCAyMDI0IGF0IDA1OjI0OjUxUE0g
KzAyMDAsIFpodSBZYW5qdW4gd3JvdGU6DQo+ID4g5ZyoIDIwMjQvNS83IDE1OjMyLCBLb25zdGFu
dGluIFRhcmFub3Yg5YaZ6YGTOg0KPiA+ID4gPiBIZWxsbyBMZW9uLA0KPiA+ID4gPg0KPiA+ID4g
PiBJIGZlZWwgdGhhdCBpdCdzIGEgYnVnIGJlY2F1c2UgSSBkb24ndCB1bmRlcnN0YW5kIHdoeSBp
cyB0aGlzDQo+ID4gPiA+IG1vZHVsZS9vcHRpb24gYWxsb2NhdGluZyA2R0Igb2YgUkFNIHdpdGhv
dXQgYW55IGV4cGxpY2l0IGNvbmZpZ3VyYXRpb24gb3INCj4gdXNhZ2UgZnJvbSB1cy4NCj4gPiA+
ID4gSXQncyBhbHNvIHdvcnRoIG1lbnRpb25pbmcgdGhhdCB3ZSBhcmUgdXNpbmcgdGhlIGRlZmF1
bHQNCj4gPiA+ID4gbGludXgtaW1hZ2UgZnJvbSBEZWJpYW4gYm9va3dvcm0sIGFuZCBpdCB0b29r
IHVzIGEgbG9uZyB0aW1lIHRvDQo+ID4gPiA+IHVuZGVyc3RhbmQgdGhlIHJlYXNvbiBiZWhpbmQg
dGhpcyBtZW1vcnkgaW5jcmVhc2UgYnkgYmlzZWN0aW5nIHRoZQ0KPiBrZXJuZWwncyBjb25maWcg
ZmlsZS4NCj4gPiA+ID4gTW9yZW92ZXIgdGhlIGRvY3VtZW50YXRpb24gb2YgdGhlIG1vZHVsZSBk
b2Vzbid0IG1lbnRpb24gYW55dGhpbmcNCj4gPiA+ID4gcmVnYXJkaW5nIGFkZGl0aW9uYWwgbWVt
b3J5IHVzYWdlLCB3ZSdyZSB0YWxraW5nIGFib3V0IGFuIGluY3JlYXNlDQo+ID4gPiA+IG9mIDZH
YiB3aGljaCBpcyBodWdlIHNpbmNlIHdlJ3JlIG5vdCB1c2luZyB0aGUgb3B0aW9uLg0KPiA+ID4g
PiBTbyBpcyB0aGF0IGFuIGV4cGVjdGVkIGJlaGF2aW9yLCB0byBoYXZlIHRoaXMgbXVjaCBpbmNy
ZWFzZSBpbiB0aGUNCj4gPiA+ID4gbWVtb3J5IGNvbnN1bXB0aW9uLCB3aGVuIGFjdGl2YXRpbmcg
dGhlIFJETUEgb3B0aW9uIGV2ZW4gaWYgd2UncmUNCj4gPiA+ID4gbm90IHVzaW5nIGl0ID8gSWYg
dGhhdCdzIHRoZSBjYXNlLCBwZXJoYXBzIGl0IHdvdWxkIGJlIGdvb2QgdG8NCj4gPiA+ID4gbWVu
dGlvbiB0aGlzIGluIHRoZSBkb2N1bWVudGF0aW9uLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGFuayB5
b3UNCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBIaSBCcmlhbiwNCj4gPiA+DQo+ID4gPiBJIGRvIG5v
dCB0aGluayBpdCBpcyBhIGJ1Zy4gVGhlIGhpZ2ggbWVtb3J5IHVzYWdlIHNlZW1zIHRvIGNvbWUg
ZnJvbSB0aGVzZQ0KPiBsaW5lczoNCj4gPiA+IAlyc3JjX3NpemUgPSBpcmRtYV9jYWxjX21lbV9y
c3JjX3NpemUocmYpOw0KPiA+ID4gCXJmLT5tZW1fcnNyYyA9IHZ6YWxsb2MocnNyY19zaXplKTsN
Cj4gPg0KPiA+IEV4YWN0bHkuIFRoZSBtZW1vcnkgdXNhZ2UgaXMgcmVsYXRlZCB3aXRoIHRoZSBu
dW1iZXIgb2YgUVAuDQo+ID4gV2hlbiBvbiBpcmRtYSwgdGhlIFF1ZXVlIFBhaXJzIGlzIDQwOTIs
IENvbXBsZXRpb24gUXVldWVzIGlzIDgxODksIHRoZQ0KPiA+IG1lbW9yeSB1c2FnZSBpcyBhYm91
dCA0MTk0MzAyLg0KPiA+DQo+ID4gVGhlIGNvbW1hbmQgIm1vZHByb2JlIGlyZG1hIGxpbWl0c19z
ZWwiIHdpbGwgY2hhbmdlIFFQIG51bWJlcnMuDQo+ID4gMCBtZWFucyBtaW5pbXVtLCB1cCB0byAx
MjQgUVBzLg0KPiA+DQo+ID4gUGxlYXNlIHVzZSB0aGUgY29tbWFuZCAibW9kcHJvYmUgaXJkbWEg
bGltaXRzX3NlbD0wIiB0byBtYWtlIHRlc3RzLg0KPiA+IFBsZWFzZSBsZXQgdXMga25vdyB0aGUg
dGVzdCByZXN1bHRzLg0KPiANCj4gSXQgc2VlbXMgbGlrZSBhIHJlYWxseSB1bmZvcnR1bmF0ZSBk
ZXNpZ24gY2hvaWNlIGluIHRoaXMgZHJpdmVyIHRvIG5vdCBoYXZlIGR5bmFtaWMNCj4gbWVtb3J5
IGFsbG9jYXRpb24uDQo+IA0KPiBCdXJuaW5nIDZHIG9uIGV2ZXJ5IHNlcnZlciB0aGF0IGhhcyB5
b3VyIEhXLCByZWdhcmRsZXNzIGlmIGFueSBSRE1BIGFwcHMgYXJlDQo+IHJ1biwgc2VlbXMgY29t
cGxldGVseSBleGNlc3NpdmUuDQo+IA0KDQpTbyB0aGUgZHJpdmVyIHJlcXVpcmVzIHRvIHByZS1h
bGxvY2F0ZSBiYWNraW5nIHBhZ2VzIGZvciBIVyBjb250ZXh0IG9iamVjdHMgZHVyaW5nIGRldmlj
ZSBpbml0aWFsaXphdGlvbi4gQXQgbGVhc3QgZm9yIHRoZSB4NzIyIGFuZCBlODAwIHNlcmllcyBw
cm9kdWN0IGxpbmVzLg0KDQpBbmQgdGhlIGFtb3VudCBvZiBtZW1vcnkgYWxsb2NhdGVkIGlzIHBy
b3BvcnRpb25hbCB0byB0aGUgbWF4IFFQIChwcmltYXJpbHkpIHNldHVwIGZvciB0aGUgZnVuY3Rp
b24uDQoNCk9uZSBvcHRpb24gaXMgdG8gc2V0IGEgbG93ZXIgZGVmYXVsdCBwcm9maWxlIHVwb24g
ZHJpdmVyIGxvYWRpbmc7IHdoaWNoIHdpbGwgcmVkdWNlIHRoZSBtZW1vcnkgZm9vdHByaW50OyBi
dXQgZXhwb3NlcyBsb3dlciBRUCBhbmQgb3RoZXIgdmVyYiByZXNvdXJjZXMgcGVyIGliX2Rldmlj
ZS4NCkFuZCBwcm92aWRlIHVzZXJzIHdpdGggYSBkZXZsaW5rIGtub2IgdG8gY2hvb3NlIGEgbGFy
Z2VyL3NtYWxsZXIgcHJvZmlsZSBhcyB0aGV5IHNlZSBmaXQuDQoNClRoaXMgaXMgc29ydCBvZiB3
aGF0IGxpbWl0c19zZWwgbW9kdWxlIHBhcmFtZXRlciBZYW5qdW4gc3VnZ2VzdGVkIHJlYWxpemVz
LCBidXQgaXQgaXMgbm90IGF2YWlsYWJsZSBpbiB0aGUgaW4tdHJlZSBkcml2ZXIuDQoNCkJldHdl
ZW4sIHdoYXQgaXMgdGhlIHNwZWNpZmljIEludGVsIE5JQyBtb2RlbCBpbiB1c2U/DQpsc3BjaSAt
dnYgfCBncmVwIC1FICdFdGguKkludGVsfFByb2R1Y3QnDQoNClNoaXJheg0KDQo=

