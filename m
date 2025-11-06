Return-Path: <linux-rdma+bounces-14284-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A676AC3D0B7
	for <lists+linux-rdma@lfdr.de>; Thu, 06 Nov 2025 19:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F84E1C58
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Nov 2025 18:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722BE33556F;
	Thu,  6 Nov 2025 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W23kw7+y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9929022A4DB
	for <linux-rdma@vger.kernel.org>; Thu,  6 Nov 2025 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453056; cv=fail; b=nH05osasEfvSK+6csbhkyglYkOGvUOa87mIYB+yEfsji+kxudk/4QEaXo+0SfocYShlz3l4F7vvRHf6Tw7OAUsqStm6zhFKzuyLDlvTQJRxCeZ6UzelxHWGOMp4z39Ls8DvMru72VVDLqM9UsB/RTjvaks0bUUNWHjJHLd9re14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453056; c=relaxed/simple;
	bh=b5hLi6TcbShg97zLeBHuN/ziaNFV5aPfbKcYgohsGzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m0rcIGF8cWLAZNsePS9PEb2Vu9AkHuDQA+3K3+hV8a5mhYDSFw9E3hdzrPFHzNcw8nXEbGQY3HLmqsZuJY4dkSGAGJ9j7cgo6eed5QOLQLIPnJPBRCnNPnFEfsGu3Omao+RQrxVHF3ZJCrlXjfEc7SpmjgLs8gEmVKw5zUSb4QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W23kw7+y; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762453054; x=1793989054;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b5hLi6TcbShg97zLeBHuN/ziaNFV5aPfbKcYgohsGzI=;
  b=W23kw7+ylgfLHn6frMEaBcPi5Muuj6/dPO5eF2mA6++P/nw5WZSS2+TH
   7SpkD1+uJHxlgHpS92k+2PhCz/R52QVj0CSxNQvK16hrFD6go1wR9mfYG
   Zft1HjsXhh+9CSiZRHmRU2kvsLDKhBXfzFmDDBdmrJXc26PFSUBerIrnX
   Rdroi7PSAubN2Es53WlcMqP7T4AGVhFi64IVQc/3iyEV5gTbVi9agjfEL
   +5JGhy6yT/fazd96aRnDEmdVSAXJBfyJ500QsZ/zehMAiPV6iYFnAoBR/
   yPQvoMeDMgvKjz1YHipb2Z/mJgC1+rM9AY0pzzJlf6NKpUQIm3vlLw4rW
   Q==;
X-CSE-ConnectionGUID: Powf0gCXTtSkHd261O+8NA==
X-CSE-MsgGUID: nk1t0/YUToyImyRTXxPpKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="90071892"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="90071892"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:17:33 -0800
X-CSE-ConnectionGUID: LQ0CyxUDSuyY5mz1eHGstw==
X-CSE-MsgGUID: oVZJL/0PTPq/h4s1fDyf4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="218576711"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 10:17:33 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 10:17:33 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 10:17:33 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 10:17:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKd2HPFLWUdsEoNyfxsWIPA2a4IJSVZPQ4bYxFG3TnvL403ydMWBFHwiAVuqkF5qNv62ZIgReXcss+j8Kkr1+6j975F14IBPwa9p1VhaSCs1fTM56P4duKNh4UxbDcW+dWdIf4BAT2QLfhKoYCNpNvpyjQmg/Xc2ZbGJNrgInvSC91Z1nDWFxFlPP0WzafFb4RBKJ5vyHOqagDolV88uWKc+c+YjbZXMFGlPBwa9P5esvZ2fSy1kXF1QDYyCPl4x5nrTNogr2G3L6b0cFKQZgDpf7DegPO2onGMgplkGFMG9MHpQmpuAZCTwoF0/jbfRlPQFjLDZNQ8r2aGwjIOrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5hLi6TcbShg97zLeBHuN/ziaNFV5aPfbKcYgohsGzI=;
 b=V4e8qG9ach58Xwfmec1SSYdKSvuIaJuEiA12KX9keUkhfoZEEZ2TMsS5wkPty+sYIblJxllh9hx7w1Mj08cjfmSsNGq6+jS6iQsVge6xWjgyh1B8v+Oe3tY6MSAoOwZBt5wYzsxkqaWgqu2cAB95x7KMbZi6hdPBcsPq91IRsxPEpZ4ans55EpibKAtQkiXJSncbK4gFT9Q8bY6cY5wdoyy0JbNCmlnIOYicmpwGUGfYldkmOTAyD9yfW1gIuztxa640lLGWSWZ5y4eB1oXPIJS1hpFvkQFnBSbd2b2YmD51khq/Hzzh8IXemid/XeUTQP4mLyTeENh3MefQ+qPqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7727.namprd11.prod.outlook.com (2603:10b6:208:3f1::17)
 by PH0PR11MB7422.namprd11.prod.outlook.com (2603:10b6:510:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 18:17:27 +0000
Received: from IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::763d:a756:a0e4:2ff7]) by IA1PR11MB7727.namprd11.prod.outlook.com
 ([fe80::763d:a756:a0e4:2ff7%5]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 18:17:27 +0000
From: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To: Jacob Moroni <jmoroni@google.com>, "Czurylo, Krzysztof"
	<krzysztof.czurylo@intel.com>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/irdma: Remove unused CQ registry
Thread-Topic: [PATCH rdma-next] RDMA/irdma: Remove unused CQ registry
Thread-Index: AQHcTnFYep/YZ3AP1UiqnYH1l+MQRLTl9ZhQ
Date: Thu, 6 Nov 2025 18:17:27 +0000
Message-ID: <IA1PR11MB772789E3D355AC2EA3133ACECBC2A@IA1PR11MB7727.namprd11.prod.outlook.com>
References: <20251105162841.31786-1-jmoroni@google.com>
In-Reply-To: <20251105162841.31786-1-jmoroni@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7727:EE_|PH0PR11MB7422:EE_
x-ms-office365-filtering-correlation-id: daa503bd-f7a1-4aeb-5f05-08de1d60be09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?c09MUkhhM1BoUzJxWksrWXgrNTFvZFFIQzZhMlRxMG5NQlFiQXhwYUdJY1U4?=
 =?utf-8?B?dG9DY1Y3akFyUEk4ZWtINkNYRkNOS0IzeFo2bXB5bU5ZM3RDT28xNk9Yemhy?=
 =?utf-8?B?K1YxMUNyY2wwQWRFQ3I0OU5wU1dJUDJNY2dreXUzTEZxOTlOcnRzbHJyYklM?=
 =?utf-8?B?eE9NaVlDaVdlOWtmbzN0QWw1b0NwOFBXMElDZ3pRdElUQjNycjNpSlBVWUhh?=
 =?utf-8?B?dVRxeEVzQjdWd1VUWXV3ZWV4UytEWTIvbkZaYmlGZVRuVDVROVJCc0lKM25x?=
 =?utf-8?B?MXMvTVFteWNGSFJsTk1ieW1oSjkzbWwyZEF6OUlhMEhoYUVmc3lsc0d3aW8r?=
 =?utf-8?B?bHJpbE54TUhjaGlraXRJcFBsYkRrVFpIcU1nVFVtMlk3Q29FeXNreitvelZp?=
 =?utf-8?B?V1YxNU5veEw5UHlnYVRaNkJ5bDJvek5ucGdIYmF3WU9DbGxxZ2RFK05GbEZD?=
 =?utf-8?B?UURYS0tjb2hCZVFjcytSeHZxVkhPOWYyWWQ4YmpOV2FRSVZWUlZTdjFBNWpO?=
 =?utf-8?B?ZlRPclNCZ2FHdTM5UFRSKzJuYzMra0Q4eTAyV1pIaEx1WEIza0dQOW5QWUpG?=
 =?utf-8?B?Sk5lZlhCeXBpYWM1cDY2SktJUlhLVk11ZndKN2hPc05JM0NYTU9jQ2NUb0xC?=
 =?utf-8?B?MElKblM1bXRLWURLcmVsbEUxREVycklpQVpYbllvcmtkeW5NY0FRQ2QzSzdq?=
 =?utf-8?B?SnNBUVllTG5WRWtvOS9RQXlGYVdZaGlnY2tBTG5lWmZlSkJVRkFFblBPQWpD?=
 =?utf-8?B?c0sxaWZaNEVxN25lTnRaVDJjbzZyWWlzdUo2SGFzelpIbWUzT202YnNlaVND?=
 =?utf-8?B?RzBMOHpJRTdNRGZpY29xYStOUTRKV01QMDMrdUtFeHVmcC9OcmtYOGlRZHU4?=
 =?utf-8?B?NVBWR1prUjN2b0s2VlgveHdKRUJUTkpYMjVLMXZka0tmcGJRQ2VucFlmV2pD?=
 =?utf-8?B?azVOcERPbEUrWlVXdCs4cm9pOUtLVUJOOXJkYU1MRlQvc1R3MUdnZjBVSm1P?=
 =?utf-8?B?akNjbXlNYzdhd213SUZSN3QxTERJVXBiNk5XM0F0ZHp6UFhNYzA3cCtDOGRY?=
 =?utf-8?B?WjFXcDhSWXhUMXBuUWF4T1YwUG1ZYVMrcE5MdW9uSCtwZitQbnpSZjB1T0VF?=
 =?utf-8?B?MEtGSUZ4WEVsZE5NWnVYS1pmenZqbi8rR0JkRG5JYXVMYXFRc2oyTXMySDNU?=
 =?utf-8?B?UWxZSzNVelhHYkdBZlVMMFJyUzcyUS9VUUhMNjAwVDlOUHZ0ZGZudXJkWjZQ?=
 =?utf-8?B?UlFwMWI1dXF3aVl6ejU4WmNVNHJUSCt5UFlEODZ2MmtOQ0R0SUJNRWJFSEVj?=
 =?utf-8?B?NzVpVmdpLzN6bGJaMmFTcXRyUHI5Um0zMDVYNlVZYWZXWGVLMGl6VjN1RUtk?=
 =?utf-8?B?NHdlY0oxSkFhMkxXM3plK1VLNWhlbTRBY2IrS2IzU3NUempWRlQzVmVNVlFr?=
 =?utf-8?B?aE82OE5TV2FINFB6aUJ5d1hnVm1jWlRZOTI2cDdXcE80K3VNenRDWE5mQXAx?=
 =?utf-8?B?Qk1Oa0l3VzJrM1ltUmhjaUNCNTZmM3JRZUswQXhWWkF1MUlQbERoWk55VTJz?=
 =?utf-8?B?a0lWZ0lUb1JaanoyakJnZ1BVUVNXUGhlU2pQOHdRcG16dnZCVTVnVlRRbVJt?=
 =?utf-8?B?WEJSTm9rWkRMNUVCdkg4OWo0TG5pYVg3MU5QZytDTkN1elg1TncrQmorMFAy?=
 =?utf-8?B?UFFwYU91dlk3NUp0YWwxd0VrdWJka0ZBWHJXZUF6dDFZQ1pRUmlPZXhHZ2k0?=
 =?utf-8?B?YXhoWEhybE9Ic1dhM1dJN215YlgzUUFrZEt1dDRURWREMUpBQW5id0ZWbXlM?=
 =?utf-8?B?RDd1b0h2bGxVcHUrZnc5UDJubEt3UXBjQXRCQzFKZ1VQNWZVdnZ4TWx5TzB6?=
 =?utf-8?B?bi90TWh5SkY4R2RCc2NhUVQwTWo0T1J4YVN5MUk1YkJabERzd2lWQXpoSUZB?=
 =?utf-8?B?dE1ZNG5sNXZUZVk0dGlkZUpsbjVUQ3BuL2ZSMFhoYmZLMXBMTFgxSGhDSkVH?=
 =?utf-8?B?d2NQS0VVMmdPZldud2pORldHaG90UkkxZU1uVUEvSWVVSkxITkMwckdLMGdv?=
 =?utf-8?Q?G5aYcZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXArbWNpcXBxV2ZGd0pLU1Z3Wmp3Zjl3OVJpOERzdUhLZjBnNFd0WFZzR1FC?=
 =?utf-8?B?eXZHa2srNk1JeXd5cGVHdlZvM3lCSFlHWlZWb2tCUEhVeTg2LzBGTHRrNEls?=
 =?utf-8?B?bm9IYWw3OWRTcERaZ0h6czNYQ1RRNWR6QWpwL0cvTEo1T1Fpc1c0RzRVc3h0?=
 =?utf-8?B?SVN2VDNBSVhZdlVkZm14cWdnNzE2cEFXREp5b0tSa0xIdk1vdkpKdkZtbmta?=
 =?utf-8?B?U2htK1VESzUvRlpZcFp1M00rRTV2Zm1GcG1ZYlJpbW1VZ0tabnBrR0I1Q1la?=
 =?utf-8?B?SXJHZDVaZzNyN0kzUmdKWGpYdFBtREtTMHFPNnFka1lIVFZPRzV6UXdvaUVZ?=
 =?utf-8?B?Q3RuSHVNaXdjZWlBV1RYTGZCL0VIdlF3ejA1UjlGTWFBcXlsdUF3R3U2dDBl?=
 =?utf-8?B?MUVLUlJEdFdPWXJWU0tSaGFISnJIYjl1cjgwYVJqZmx5Q0FIdkd1aDRrRWMz?=
 =?utf-8?B?TlRRWXcvT0VYUmhpYVBqbjJwak1PODFBYXVyYlZiQkZvQm8zWFJSNitrczJH?=
 =?utf-8?B?Qi9xVzFlZU5YNGRTbTJ5c2RlMVo2eG0wQlZhS3ZPMXRmZTRWMk9qdnY1dWZW?=
 =?utf-8?B?WmlhaWNwWXhBZmJacVZ0bzZDZDNnVjdCVzF2VG1Jd0p3dFdoT21MNW0reER1?=
 =?utf-8?B?bEFYblRtT3VNTEs4UHlFVTdacE9Ya0RYcEl3VUZjTnp0L1cxZWVQRHh5MlFL?=
 =?utf-8?B?NzFZeitiQnNwTTJ2TTdDTDNPRmViUTJoVHJnR0RTNjlBTE55RTNWMXpqMFh6?=
 =?utf-8?B?c1BTR01JTzJEaEF3SFFOR00yQ2diSE9ja1Y1bFYxREFpdTQ2djFWQXJNejcz?=
 =?utf-8?B?UVh4RzJubU9LUEFvN2ZLQWNXcG5WRmQ3WXhKc05lTm91Rkk4Nm5BZzRGSi8r?=
 =?utf-8?B?UkVUSHV1TWdoTVZqY093K3R1UExWalVPVnVKN1czcU9QYTNvNkY0TWgyTVFx?=
 =?utf-8?B?WWNjRkxvcExFK1krSFAzN2gvYkt2SmZlYXNSZjFWRGxHYTRIUWp6ck9JWEJr?=
 =?utf-8?B?Vjd3MWRRZmdZNG9zRUpEYWczTjdHN0xrcWF3UVp5ekxpYWlqUVRMdmgraVZB?=
 =?utf-8?B?OVkyY09zYlRmd0QyVzBRK05tYkY2YjUyYVh4TURaWWhuMURja0VUZjhGTUUr?=
 =?utf-8?B?VkNmRVJnbXBnZmIrWU5JbmsraG5MeXZEN1ZMcUhBUjVWTSs0VjFJRTFGYUti?=
 =?utf-8?B?dFlRQ0tLNUNRbUI0eXpaMWpLOGpPQWE5Y0ZoY0RnbkY3Wi9VOXAwdk5ZZHBk?=
 =?utf-8?B?NkFUUGdjamp0RDJBZTZVemNFVy9vUFdKbzZkMVdMUDNkcXc4VEFBQjd1RFFI?=
 =?utf-8?B?eThVcndpa2x0ai9MVmJNSi9ZMDduUXNFdVFjL1hTUzVjbkI1eE5odC84ZkxN?=
 =?utf-8?B?TkNVV0tBN1c3N2s3VElJNHVndkh2WWpzWHZxSHcvbUFxeU9LNENMYXl4Uzh6?=
 =?utf-8?B?WnAzZksyR0Z5S1hNVkUvM3ByOWM1ZmIvK2ZoYnp0MnZkYXV2ai9XSi9TdEU1?=
 =?utf-8?B?WVBqZ2xjZmI4dXBwV2tQeFdpQVN5SDBGa0NkSUVmUzlmVksrRDQ5Z3VnL3Jt?=
 =?utf-8?B?WTdqdG9aL2dqbXZOM2wvUG1STHlidTJTdHB4UFVjNXkvN2N2MkFNamlXcmNN?=
 =?utf-8?B?aUVLZm9mTG9IbVp1OGlKTGVEMDA5bE5teVZneXRUbVhYUlFkVGducURnS0Jz?=
 =?utf-8?B?dlEyQXdFUkdmL3pDZ1lGT1NWS1hlektyYWFTRm1RN2tzaVd4REJWV2V5c1Yr?=
 =?utf-8?B?N2tGNTZERVZwSS9MYUJJRTJCWVJwTkdtV1RnRXI0dldKQ3pkTWlLY283Uk5q?=
 =?utf-8?B?blFUZmdMM3dBRmhBUGVpRGsvNytwRlI4QllSRVBJZkt0akYrcklYVmpxTjdl?=
 =?utf-8?B?T0xLUGw4UGthOHlhV1YxVTlWbEdaWXBoZGNLTDVMZXI2c1lRd0lpQ0hQR3Iv?=
 =?utf-8?B?eDE5T0hkbVJOSnFYU1hLZXJHYi9mTFlrTFpHYWlEWEF0NFNuNGY2Q010R1VD?=
 =?utf-8?B?QWNpZDJjanY4TTF6bDBSMWZ2RTVJcC9ZWG5XanY1MVJoM0tVTVBZaUg3U2l1?=
 =?utf-8?B?MWp1TmV1RjZNY21DVmxBSTRCMENkczZIOG5VTWdJV0NkZkNuZGZwakczdUtZ?=
 =?utf-8?B?aXdNVVlKRHI2S0NZSk5OeFA2ODNSeW45OGVoVzh3YmtUTmxnM3hhNnprRzFR?=
 =?utf-8?B?emc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: daa503bd-f7a1-4aeb-5f05-08de1d60be09
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 18:17:27.5240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SmQRAEhBZm/Vf574h2I28CX+QujCuOxTpxfhNXeoVYoc20OO8RuXOtD97fi+HuD49UnzkVoFQXB7ckoEUejEzD77Kt75y3Uk8LE3qWD4520=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7422
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb2IgTW9yb25pIDxq
bW9yb25pQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgNSwgMjAyNSAx
MDoyOSBBTQ0KPiBUbzogTmlrb2xvdmEsIFRhdHlhbmEgRSA8dGF0eWFuYS5lLm5pa29sb3ZhQGlu
dGVsLmNvbT47IEN6dXJ5bG8sIEtyenlzenRvZg0KPiA8a3J6eXN6dG9mLmN6dXJ5bG9AaW50ZWwu
Y29tPg0KPiBDYzogamdnQHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmc7IGxpbnV4LXJkbWFAdmdl
ci5rZXJuZWwub3JnOyBKYWNvYiBNb3JvbmkNCj4gPGptb3JvbmlAZ29vZ2xlLmNvbT4NCj4gU3Vi
amVjdDogW1BBVENIIHJkbWEtbmV4dF0gUkRNQS9pcmRtYTogUmVtb3ZlIHVudXNlZCBDUSByZWdp
c3RyeQ0KPiANCj4gVGhlIENRIHJlZ2lzdHJ5IHdhcyBuZXZlciBhY3R1YWxseSB1c2VkIChjZXEt
PnJlZ19jcSB3YXMgYWx3YXlzIE5VTEwpLCBzbw0KPiByZW1vdmUgdGhlIGRlYWQgY29kZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEphY29iIE1vcm9uaSA8am1vcm9uaUBnb29nbGUuY29tPg0KPiAt
LS0NCg0KQWNrZWQtYnk6IFRhdHlhbmEgTmlrb2xvdmEgPHRhdHlhbmEuZS5uaWtvbG92YUBpbnRl
bC5jb20+DQoNClRoYW5rIHlvdQ0KDQoNCg0K

