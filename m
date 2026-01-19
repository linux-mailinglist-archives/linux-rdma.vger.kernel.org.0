Return-Path: <linux-rdma+bounces-15707-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1040D3A987
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 13:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B186430150CB
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 12:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9F735E55B;
	Mon, 19 Jan 2026 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYxWvzCv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF31333ADA0
	for <linux-rdma@vger.kernel.org>; Mon, 19 Jan 2026 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827234; cv=fail; b=KtqAK7fbx46sI7GtIvtNwAwIuSxwpRDIJubLhi2pMMDrTv6UHCIXbvE6Eridxx/3Txz7U0Ok3deu0AiENGodOqE+7r3OmCggrdDbXN/M6BPZ/QgOO6ImcywLBAX58CA+9v55TUQliCSFgNYcGqwHjz8buDUIo8dsxHGxqFGGEmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827234; c=relaxed/simple;
	bh=qzcMpriNKDLI0LSPZvjdQK/iN1KZ6lksIlIU9Ol58kI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qLP2Lmti06hOLU5AD7h1fmFjnakTt4Pq20U7Qoq1NODuKLS83HJHk1IFZdSbq1rohCsX34zvIAEtTRLT3QUlXRYYamtA4SWuenYiXcrgjlsYOuf9IuB7trQ/FFyri5MWXNxCdEZCpcGFrC3HMFgNs7xcJG8jWg44gia0DKU6Mts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYxWvzCv; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768827233; x=1800363233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qzcMpriNKDLI0LSPZvjdQK/iN1KZ6lksIlIU9Ol58kI=;
  b=KYxWvzCvA3s5sdxZCvHldW0/z2pa35syeXdpRooYtjcJVuz1Fz9I7t8O
   G7o3mqWWfUzbv4uk4fgNM9OtqB5H//blNDvx5F+oZAi2IUIW2yurQjmYT
   itkZri8upMyUSruB+Nhp4entaJDamj7qGSyEbmT79Vu5t9BJ4COv8hBmC
   ZR8JAu0GQlIdpwBQNcqtKA/ibA5TRdw/sJ0Wn615ROiMNOwepVCQeXAOm
   6+FZxYQlhWI/DhDyiIMRPsyfaS6tBvSdX69O1WsBByZRI6UyUScBYO8MA
   YzVdNWAnaHuTMDQmQi7Q5nfT8dYpN50p9iZ1u1QhLdXNJGICsqHG3hifb
   w==;
X-CSE-ConnectionGUID: 9ME6F8DvQKGDgpAk52aOcQ==
X-CSE-MsgGUID: 0nMVWlyoQ7KiSDk7KDl0ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="80758176"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="80758176"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 04:53:52 -0800
X-CSE-ConnectionGUID: sndi4f/oRKypewNbQvecuQ==
X-CSE-MsgGUID: ZX8vBYZMRwW5M6aSVDuzLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="210348394"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 04:53:52 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 04:53:51 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 19 Jan 2026 04:53:51 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.57)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 19 Jan 2026 04:53:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUuF1GjqKpqbjvJdvL4TyqoOaWr1OwYduCLvJ5jK62/YTA1+OeewhJQIS2fTJf5q/qf211vPs+FaQb7Tl8JO44V/yz4qoVY+HaKdvuc6avIizBTMOX8uQWj104luO1+UaUDW+749JXt1pveYfSqiVjNRD04/+5b65shrPkl/9hczu0JTHUejMmMRxllCbbOAl6HWHtoR6WlOUVsZv+Wuou8TR03a2R+rJNdgRp/9ZG6MwPZug3YzT/JHE3aRn54Wj3q6GP3KzQURWUnkj9Nco7uzF+aIQjAlzjKvhVNh9LGSeXfc0Aio9t9bSchyy1vIJQAC6aVW0lb0V7qv1wwXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzcMpriNKDLI0LSPZvjdQK/iN1KZ6lksIlIU9Ol58kI=;
 b=VH4glRdqRdIT/cLs4P0ZeMc8a6NrBFza8E8hotOtKHpy8LJlMoam5d20E7J5ryXcZbcrtN3Rd9/fKEyeBnW60dRIbPhOGJgnXuOrcE7PnBpgu+NGmG4krsjC1YiEscpTRPOL8x0lkCB2qJcyaforarBgVVssnna+S/fcvBlq1Z47KjR9ZvRZxFK9yDl7E6ooxdqaxK4i/Ef5c+039QeVF10b+fnp3n9nBUNzHVrdsKjYiO4VLeFsxpyhAM5ekTCzwdEjfZ9ZSmqyPzq4hcXX311x12KLkJln58pvJdyE3/8RCN/AUSIMp9lxHyeVv/yHQQwVbXqrr5tbuQbMbMW5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) by
 DM4PR11MB6454.namprd11.prod.outlook.com (2603:10b6:8:b8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 12:53:49 +0000
Received: from DS0PR11MB7736.namprd11.prod.outlook.com
 ([fe80::f7c7:f271:a7b:7a68]) by DS0PR11MB7736.namprd11.prod.outlook.com
 ([fe80::f7c7:f271:a7b:7a68%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:53:49 +0000
From: "Czurylo, Krzysztof" <krzysztof.czurylo@intel.com>
To: Jacob Moroni <jmoroni@google.com>, "Nikolova, Tatyana E"
	<tatyana.e.nikolova@intel.com>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Czurylo,
 Krzysztof" <krzysztof.czurylo@intel.com>
Subject: RE: [PATCH rdma-next] RDMA/irdma: Convert QP table to xarray
Thread-Topic: [PATCH rdma-next] RDMA/irdma: Convert QP table to xarray
Thread-Index: AQHciBlXIGhYayPmnEaWvnUoJcBFILVZaMTw
Date: Mon, 19 Jan 2026 12:53:49 +0000
Message-ID: <DS0PR11MB7736349A3D51CDE681CFBD4BEB88A@DS0PR11MB7736.namprd11.prod.outlook.com>
References: <20260118012500.681672-1-jmoroni@google.com>
In-Reply-To: <20260118012500.681672-1-jmoroni@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7736:EE_|DM4PR11MB6454:EE_
x-ms-office365-filtering-correlation-id: c1b92941-f8b2-4199-d559-08de5759ca81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|42112799006|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?M3NpSllhL3M1SDVNZkUyOTlFR2xmc2g5SE1TcXdqMUhiOEhoTGJIUjJNZ1Ft?=
 =?utf-8?B?WUQ0RlF1enhxWFRZbzViZXRwYkM3YWVENjRJNGVRM2lKSDV5NHlSUGU0cnB1?=
 =?utf-8?B?Q3B1VGtUQnhNcllpTlhlOWRBd2c4a09tY0kwQjRWbytkRWdPSDVyUFpscG5J?=
 =?utf-8?B?cmFwa0Vkd1VhTjRuQTNNQkpJdjluWUpDa0xwcEpGSVVQWS9nZ0tvODFIMzgy?=
 =?utf-8?B?M2R5Q2Z2djR3LzZ0OXA5VW5wczhMcVdycGJoeTBpQVNQTGVjbzNzMmJpcjhl?=
 =?utf-8?B?cWhmQ0Vza1dEa3hIQzBaUlV4MmxzcWlTZytCRG1FamY1MUgyWENGS2tNN21u?=
 =?utf-8?B?cS92WExjd0kvdXlNamREWE1naGtMd29lRzVDa0llajZMcjVNQUgwVDdKbjdY?=
 =?utf-8?B?Rm1GUFhiRitQb0xCQW9YeGdIeXdxdDZkeWkvb0VyTzF3aTBJaEc0UVlRV1pW?=
 =?utf-8?B?SXUzMUtoZ1E1NHpyRHBnNlhTc3lRYnVSNytsQVB0VkVUb1dRZEN4OTlUaWIy?=
 =?utf-8?B?cDZyOUxiTXJlK2o1LzFTTWtUZS91dWRUYVoxaTVFaHgxVHZNc3lSNldSeTNl?=
 =?utf-8?B?MWVKSi83Uko5V0o1a1ViQVp2YjlzVjY3SUpwcGUxY3U1NUFtb1lNN3JTYzA2?=
 =?utf-8?B?c2l3UER5RFJzODQrcXFlajVsQlpKemY4a01BVFgxNy9RV0RXYmljb0ozam56?=
 =?utf-8?B?aTdkZVpranA4N1pydjN3bWtFOHRDdDVEVGFGSFJiVThkSnZKOFFMMW1vRXFj?=
 =?utf-8?B?OXZOM3pFTTY3UW1SYkFWbHRTeU9OV2RxYjJSd1l5WUczSkZYYTBCZ2JybDVM?=
 =?utf-8?B?Tyt1NFRjQjdTRXlaajB4RXJndUV5MWVOM3VZa2hsOFlxOUZPTFp1dmwwbEV6?=
 =?utf-8?B?ZDF4ODZ4R2lMU3dDbzRoZXZoQkk0YitVRjBXbW1nd09VUEw5Zjl3ODhBalR4?=
 =?utf-8?B?ZjV0WldqK2laV1J0M2VZeGZNUEphczVLb2U5SjNjOUdPTUNRVXp5Vzg2bm9B?=
 =?utf-8?B?bzU3VENVWDZyYjNTbXN2SXQ5ZjB4Q0Vnc3N5djh1bXU4MzhNNFBSNi9iSFBp?=
 =?utf-8?B?UFIySUl2amRzZkFBa1Z4NDJ3TDFvSktHNVhUNDBZNGRDWjVVckFuVXIrSFdn?=
 =?utf-8?B?Y1FkMGFndkJOVHVla2xnZytxRE1mcmI0U1d2UFJmbkdPOFBFajM3TCtoNThh?=
 =?utf-8?B?Tk5jZHFpdmZOeTl3ci9iMTVES2ltUVV0MmRuNHk5ZkluaDRPZFVoL3JrSm9q?=
 =?utf-8?B?ZWhoeDRPajZ3OG9zSTJtK3ZNTkJhNVpoblpXbld6U240enhpd0VGbWU0eGNX?=
 =?utf-8?B?NHpKdlRvaDRxQkV3LytvOGZCVURrOGgvUjJnSm0vOGhYZ0dYMlZ6dCthd2Zr?=
 =?utf-8?B?NnAvdWp0REtXZHJRYnNnWHB6U3FleGk0Qmh1eE53ZVFOUkxvbTEwYWdmYW9h?=
 =?utf-8?B?Uy9yK1VwWDExc0IvMGNDc2ZqV2tCcFV1bDR3NGk4NG15bGRZUzRlMXhzNStl?=
 =?utf-8?B?Ykp1YzlvVk56SVNucDd4UC9RQXQ2YU1KcTBVYit3SUU2d3BMUE5tNk90T1B3?=
 =?utf-8?B?bUZERXRNQ2tHYmdQQ1VURUU0MXdnZmxjU29TVElrdGtCazRuNi9YVXJoT0Y5?=
 =?utf-8?B?TUsveFgyZFFGeXlKbW5DOWNia3lORW1oUXRjOEZLR0JYTEdMaGRMaXl3dkhF?=
 =?utf-8?B?SnhjdEZGVVdIVTZwck83NGlBM0lSZXpkOFpKWlVtdCtJZDMzY1VqcWs1WjlB?=
 =?utf-8?B?ZEFwU0JTRjZRTWozMzZ3dTVPRktKOGM3dW1GQTZHYXJXcld4RnJFWjdmakJ3?=
 =?utf-8?B?WlN5dlB3L3VkM093NFJwTHNTdGdLVmZxOFdlZU9QbUlMeTh0VEo2bm5SWDIr?=
 =?utf-8?B?ZVVSdkV2LzdjaEd0dzVBOVVPK1BZTE9qZ21WbThJQUpPNWQ4bzFnMVRBYWtT?=
 =?utf-8?B?MktOdVJQTytob3hhaGNmK2VqSlczcmZvZWZQRTJHcWUwZ2ltMUs1YWtWRGxi?=
 =?utf-8?B?VlhuNjhwaXJJbzA4ZEY1c2hYNUJ4S1BWaVhmMXpJNnJBNWY2QVVMWjdRK1hX?=
 =?utf-8?B?WkVUbjBUK1JzWDVtdEZtRy9tcThOTTJFcUh0dDEya2pSSG1XNHRWbVFITGQ2?=
 =?utf-8?B?R2lGNVBJMXFzWE9SNFlNVHlTeEVld0RQRi9SL29Na3UyR1h5bHl0T3hycHZi?=
 =?utf-8?Q?Kuiqc9tmXKstUzJuAdZTZVE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(42112799006)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDY2YTlZODZiVmdaVWc4SzZIWFhMbVAyTVpvZVpqcmJQK2JoZlU4TkxlSHBV?=
 =?utf-8?B?OCtiWDgrRkVRcDFMNGljbkhGOWk5dGI0ZG1KKzE2SHRUc1BrTGZpQTNBVFRv?=
 =?utf-8?B?WVRxcDZHdjFwbWxRM1M1T08yKy9PNTFlSDdOSHcvUVZJODg5c2NpZDlpeC9v?=
 =?utf-8?B?c3hVcklLVVpnUk1kZkcyRU5oT3p4U2hWQXI4d3NncWRpeHI4cE1HZ0R0eThx?=
 =?utf-8?B?aFU2TVZONzNncXZLRjRidVNGbC9xcDRxcTIxRk9JVW1DLzZ2WnJsMGwvS0tr?=
 =?utf-8?B?WFgvTkYxam1MOVlwK2hnK05ONnJaeFhnRkdkOEVhREpOUnRWU0IzTTQvNmdh?=
 =?utf-8?B?ejY5THdEUVVVRDlMbjlTWFU3OFhEazR3UWN0UnZ1OUQ4eUxtMjJ0ck94Vmd0?=
 =?utf-8?B?NWtwbWs4blVPN1lvMVZodStBaEw1c2Fxb2VqVnJHNFhoRHBVRU8vZVd1NE5L?=
 =?utf-8?B?blppb2ZsUElRcGNrSUdzamhxZVJLOW96ek03RUN1ek5hVVJtV2xxUEgyVmhO?=
 =?utf-8?B?K3EwWXRvZHljR3BKWmtISWZva2lZT3JwSGhBRnBDeng3Umd4TEgrY2wraDNl?=
 =?utf-8?B?czFoSU11WkFVOEJhOUIzUlRTc3VTRGl3MVNXOVBWMk1EMURUallyeXd6d3BF?=
 =?utf-8?B?akhlMkx5TmQ2R2JpbmxjOERFWmJxeXQ1UGdUYmcxWmJSQXhXOTRUeEdBUkVB?=
 =?utf-8?B?elhqdmZSQXNRd2dzSkxiMDRuK0JoU1BIbUtnMUozcFdOcmlKNGFsdTQ2Qyt5?=
 =?utf-8?B?d1dlS0VJQUpuM0w0QnBQYWdENzdiWFNCZTRlcGpzMnFBZFVuK29Ra1hzalVZ?=
 =?utf-8?B?djNnQVhjaExPRklsc3Qyc3JtaEd1TzFNK1JQamtRMkEyWUh6SnIvMWxuanlF?=
 =?utf-8?B?aEh2R3RlN3JDbEprcHRDZCtEWlRHVnpheGhFYVFQb0JFNHNWUld0YktmbGxm?=
 =?utf-8?B?WFU1aG1VTTZER28xK05nWTl0eUZuQnUvcitJRDBuZnNndnlnK29hWVhHY29Q?=
 =?utf-8?B?em9DWUlsc2VwaXdQTXJ0YWJSWXg3SVVzY3NYNlZYZzBXbzNSUHd3Z3cwczMr?=
 =?utf-8?B?VmJ6SGJMeVhXNGNkT3RZWXdSNVVUWWZTVHppcnNjTmtEUkpEUjBBaWFYNyt1?=
 =?utf-8?B?WXdXNHlxYkVBV0llcmhnUkJDaGpuQlBQdmxyU09rQU5vZnVsVDBDVWF6M0Va?=
 =?utf-8?B?S201UEViSTlkazh1czU1RU96ZDZpVFhUZGFVSS9oS3R5KzJGMmlUNWpvOFpP?=
 =?utf-8?B?R0I5bG9FbWtNaVJNT0lnaVlZYk9MQUprekU4V0lLTHdUK29qaUF3WXAvMVdm?=
 =?utf-8?B?amw0SmE0dVFFbFVqZXM5cEZOc01QYWwzcUlDa3kwOFNValY0YUJXWXB4UGRD?=
 =?utf-8?B?cnhQQlpLUzdLMjJyKzR1a3djL2dRTHQ1V0FMWTRKNFdaSzZlUkJVaWJvZjg4?=
 =?utf-8?B?Q3BvSGM1MUJxajlWYkVwcHJ2c1MxTE1YOUlWdHZYOWIxS3lqaE45NFQ2S1NZ?=
 =?utf-8?B?YVh3NWU1Mit0ZXUrbktOSG9va3JsV2Rna2xwWHRIdk5RTWVPZlJxTmh6cWxZ?=
 =?utf-8?B?eEI1OFdNUE0wYnplQUtueUJHS1lldFJweWVnLzZ1UWoyOEYxdWtmOURTVkcr?=
 =?utf-8?B?eWp6amE3UnV0aSt1UER0U09oc2M2WEtpZDhZQlp6OTMzdS9iaFFRY2w0bUVG?=
 =?utf-8?B?dnFjQ3lNa0M0dzNWeExMOCtYQlVudjc3amg0RSszQXZpbUs3TlpwaTVQRjdk?=
 =?utf-8?B?eE9SZ0V3M0hLSW1EOVdydDAwYmFmb05aODNqeS9hc0JKenk5UGRqSWUxK3By?=
 =?utf-8?B?dW0xdzk4Mm8rMmVROHdCdUYzd2YrckRMdG5wMnhZdTFlUGsvWHFYc0w2bmtD?=
 =?utf-8?B?dHoyYUtUQjZ0bTNEUERCcW9kRVdGY1lCcWRJMGpHZkRmcmptV09xWk9HaHRv?=
 =?utf-8?B?dVJ5dUhyOHMzN0ltZjVlZFM4eDBSMjdYT05hSlVta1Y0UU4rZHh3ZE5TTFNT?=
 =?utf-8?B?RWppRi9mWExHZENPUExLa0kwZmpBSUsvdlRzR0t6eEJuKzBWQUFaYTRlNFkv?=
 =?utf-8?B?d1RraHRIbzFYUmNxY0o0b21iWGgrRkpFZnlTdEV6NFlGOXQwaWt6WnVVVWVz?=
 =?utf-8?B?b0FlN2R4SGYxUGQwQW9zN2plZTRDL21nYVloMHBuNU9KYzBTcmhxTmZtVnpB?=
 =?utf-8?B?MXhUc3ZMTFhDU2h3b0YxdnBJNUphVS80a1VZOFNZRnBzQno5akVUR3dnWmNB?=
 =?utf-8?B?SXZ2WWk3VkZTRlFaVDFMVCtvNE5JQ1F4OS9nYVZ3Nk1YWmRVbjYzdmZpUndo?=
 =?utf-8?B?MHQ4emZTTzZCalhFWkI4T21MTzBSRVcxK0hBNVRNS0xUMUVrOExIZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b92941-f8b2-4199-d559-08de5759ca81
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 12:53:49.4356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9dTREKRM22qmNKmwI2yll/BLAyZdcu3uQZp4FgbhfKP+1ExRttlcRo6ZpgjAaNjGMEhaIOAurqM13Bd37RfcAF4haKmQrLPzlkPiVJYCBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6454
X-OriginatorOrg: intel.com

SG9uZXN0bHksIEkgZG8gbm90IHRoaW5rIHRoZSBxcF90YWJsZSBhcnJheSBzaXplIGlzIGEgYmln
IHByb2JsZW0uDQpBbHNvLCByZXBsYWNpbmcgc2ltcGxlIGFycmF5IHdpdGggYSB0cmVlICh3aGF0
IHhhcnJheSBhY3R1YWxseSBpcykNCnNlZW1zIHRvIGJlIGFuIG92ZXJraWxsIHRvIG1lLg0KDQpF
dmVuIGlmIHRoZSBkZXZpY2Ugc3VwcG9ydHMgdmVyeSBsYXJnZSBudW1iZXIgb2YgUVBzIChlLmcu
IDFNKSwNCmJ1dCBpcyBub3QgaW50ZW5kZWQgdG8gZXZlciB1c2Ugc28gbWFueSBRUHMsIHRoZW4g
c3lzdGVtIGFkbWluDQpjYW4gcmVkdWNlIG1heCByZXNvdXJjZSBsaW1pdHMgdG8gYXZvaWQgKHBy
ZS1hbGxvY2F0ZWQpIG1lbW9yeSB3YXN0ZS4NCg0KT24gdGhlIG90aGVyIGhhbmQsIGlmIHRoZSBh
Y3R1YWwgUkRNQSB3b3JrbG9hZHMgb24gZ2l2ZW4gc3lzdGVtDQptYWtlIHVzZSBvZiwgbGV0J3Mg
c2F5LCB1cCB0byA2NEsgUVBzLCB0aGVuIHdoeSBub3QgdG8gcHJlLWFsbG9jYXRlDQphIGZsYXQg
YXJyYXkgZm9yIDY0SyBlbnRyaWVzLCBpbnN0ZWFkIG9mIGR5bmFtaWMgbWVtb3J5IGFsbG9jYXRp
b24/DQpJT1csIGlmIGdpdmVuIHN5c3RlbSBmb3IgbW9zdCBvZiBpdHMgdGltZSBpcyB3b3JraW5n
IHdpdGggOTklDQpyZXNvdXJjZSB1dGlsaXphdGlvbiwgdGhlbiBkeW5hbWljIG1lbW9yeSBhbGxv
Y2F0aW9uIGRvZXMgbm90IGJyaW5nDQphbnkgaW1wcm92ZW1lbnQuDQoNCkZpbmFsbHksIHRoZSB4
YXJyYXkgd2FzIGludGVuZGVkIHRvIHJlcGxhY2UgcmFkaXggdHJlZS4gVGhpcyBpcyBub3QNCmEg
dmVjdG9yLWxpa2UgKGR5bmFtaWNhbGx5IHJlc2l6ZWQgYXJyYXkpIGRhdGEgc3RydWN0dXJlLg0K
Tm90IHN1cmUgaWYgdGhpcyBpcyB0aGUgcmlnaHQgYXBwbGljYXRpb24gZm9yIGl0Lg0KDQpLLg0K
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb2IgTW9yb25pIDxq
bW9yb25pQGdvb2dsZS5jb20+DQo+IFNlbnQ6IDE4IEphbnVhcnksIDIwMjYgMDI6MjUNCj4gVG86
IE5pa29sb3ZhLCBUYXR5YW5hIEUgPHRhdHlhbmEuZS5uaWtvbG92YUBpbnRlbC5jb20+OyBDenVy
eWxvLCBLcnp5c3p0b2YNCj4gPGtyenlzenRvZi5jenVyeWxvQGludGVsLmNvbT4NCj4gQ2M6IGpn
Z0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnOyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsg
SmFjb2INCj4gTW9yb25pIDxqbW9yb25pQGdvb2dsZS5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCBy
ZG1hLW5leHRdIFJETUEvaXJkbWE6IENvbnZlcnQgUVAgdGFibGUgdG8geGFycmF5DQo+IA0KPiBT
b21lIGRldmljZXMgY2FuIHN1cHBvcnQgYSB2ZXJ5IGxhcmdlIG51bWJlciBvZiBRUHMsIHNvIGNv
bnZlcnQNCj4gdGhlIHFwX3RhYmxlIGFycmF5IGludG8geGFycmF5IGZvciBtb3JlIGVmZmljaWVu
dCBtZW1vcnkgdXNhZ2UuDQo+IFRoaXMgc2hvdWxkIHJlZHVjZSBjb21tb24tY2FzZSBtZW1vcnkg
dXNhZ2UgYnkgbWVnYWJ5dGVzLg0KPiANCj4gQWxzbywgcmVtb3ZlIHRoZSBzcGFjZSB0aGF0IHdh
cyBiZWluZyByZXNlcnZlZCBmb3IgdGhlIHNycSB0YWJsZQ0KPiB3aGljaCBkb2Vzbid0IGV4aXN0
Lg0KPiANCj4gVGVzdGVkIHdpdGggS0FTQU4rbG9ja2RlcCBhbmQgYSBmdWxsIGN5Y2xlIG9mIFFQ
L0NRIGNyZWF0ZS9kZXN0cm95DQo+IGZvciB0aGUgZW50aXJlIElEIHNwYWNlLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogSmFjb2IgTW9yb25pIDxqbW9yb25pQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9pbmZpbmliYW5kL2h3L2lyZG1hL2NtLmMgICAgfCAgOCArKysrLS0tLQ0KPiAgZHJp
dmVycy9pbmZpbmliYW5kL2h3L2lyZG1hL2h3LmMgICAgfCAxNyArKysrKysrLS0tLS0tLS0tLQ0K
PiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2lyZG1hL21haW4uaCAgfCAgMyArLS0NCj4gIGRyaXZl
cnMvaW5maW5pYmFuZC9ody9pcmRtYS91dGlscy5jIHwgMTUgKysrKysrKysrKy0tLS0tDQo+ICBk
cml2ZXJzL2luZmluaWJhbmQvaHcvaXJkbWEvdmVyYnMuYyB8ICA5ICsrKysrKystLQ0KPiAgNSBm
aWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvaXJkbWEvY20uYw0KPiBiL2RyaXZlcnMv
aW5maW5pYmFuZC9ody9pcmRtYS9jbS5jDQo+IGluZGV4IGY0ZjRmOTJiYS4uMzEwNGYzODcwIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvaXJkbWEvY20uYw0KPiArKysgYi9k
cml2ZXJzL2luZmluaWJhbmQvaHcvaXJkbWEvY20uYw0KPiBAQCAtMzQ0OCw5ICszNDQ4LDkgQEAg
dm9pZCBpcmRtYV9jbV9kaXNjb25uKHN0cnVjdCBpcmRtYV9xcCAqaXdxcCkNCj4gIAlpZiAoIXdv
cmspDQo+ICAJCXJldHVybjsNCj4gDQo+IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJml3ZGV2LT5yZi0+
cXB0YWJsZV9sb2NrLCBmbGFncyk7DQo+IC0JaWYgKCFpd2Rldi0+cmYtPnFwX3RhYmxlW2l3cXAt
PmlicXAucXBfbnVtXSkgew0KPiAtCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZpd2Rldi0+cmYt
PnFwdGFibGVfbG9jaywgZmxhZ3MpOw0KPiArCXhhX2xvY2tfaXJxc2F2ZSgmaXdkZXYtPnJmLT5x
cF94YSwgZmxhZ3MpOw0KPiArCWlmICgheGFfbG9hZCgmaXdkZXYtPnJmLT5xcF94YSwgaXdxcC0+
aWJxcC5xcF9udW0pKSB7DQo+ICsJCXhhX3VubG9ja19pcnFyZXN0b3JlKCZpd2Rldi0+cmYtPnFw
X3hhLCBmbGFncyk7DQo+ICAJCWliZGV2X2RiZygmaXdkZXYtPmliZGV2LA0KPiAgCQkJICAiQ006
IHFwX2lkICVkIGlzIGFscmVhZHkgZnJlZWRcbiIsDQo+ICAJCQkgIGl3cXAtPmlicXAucXBfbnVt
KTsNCj4gQEAgLTM0NTgsNyArMzQ1OCw3IEBAIHZvaWQgaXJkbWFfY21fZGlzY29ubihzdHJ1Y3Qg
aXJkbWFfcXAgKml3cXApDQo+ICAJCXJldHVybjsNCj4gIAl9DQo+ICAJaXJkbWFfcXBfYWRkX3Jl
ZigmaXdxcC0+aWJxcCk7DQo+IC0Jc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmaXdkZXYtPnJmLT5x
cHRhYmxlX2xvY2ssIGZsYWdzKTsNCj4gKwl4YV91bmxvY2tfaXJxcmVzdG9yZSgmaXdkZXYtPnJm
LT5xcF94YSwgZmxhZ3MpOw0KPiANCj4gIAl3b3JrLT5pd3FwID0gaXdxcDsNCj4gIAlJTklUX1dP
UksoJndvcmstPndvcmssIGlyZG1hX2Rpc2Nvbm5lY3Rfd29ya2VyKTsNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS9ody5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5k
L2h3L2lyZG1hL2h3LmMNCj4gaW5kZXggMzFjNjdiNzUzLi5kMDFmY2JhN2YgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS9ody5jDQo+ICsrKyBiL2RyaXZlcnMvaW5m
aW5pYmFuZC9ody9pcmRtYS9ody5jDQo+IEBAIC0zMTMsMTEgKzMxMywxMCBAQCBzdGF0aWMgdm9p
ZCBpcmRtYV9wcm9jZXNzX2FlcShzdHJ1Y3QgaXJkbWFfcGNpX2YNCj4gKnJmKQ0KPiAgCQkJICBp
bmZvLT5pd2FycF9zdGF0ZSwgaW5mby0+YWVfc3JjKTsNCj4gDQo+ICAJCWlmIChpbmZvLT5xcCkg
ew0KPiAtCQkJc3Bpbl9sb2NrX2lycXNhdmUoJnJmLT5xcHRhYmxlX2xvY2ssIGZsYWdzKTsNCj4g
LQkJCWl3cXAgPSByZi0+cXBfdGFibGVbaW5mby0+cXBfY3FfaWRdOw0KPiArCQkJeGFfbG9ja19p
cnFzYXZlKCZyZi0+cXBfeGEsIGZsYWdzKTsNCj4gKwkJCWl3cXAgPSB4YV9sb2FkKCZyZi0+cXBf
eGEsIGluZm8tPnFwX2NxX2lkKTsNCj4gIAkJCWlmICghaXdxcCkgew0KPiAtCQkJCXNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJnJmLT5xcHRhYmxlX2xvY2ssDQo+IC0JCQkJCQkgICAgICAgZmxhZ3Mp
Ow0KPiArCQkJCXhhX3VubG9ja19pcnFyZXN0b3JlKCZyZi0+cXBfeGEsIGZsYWdzKTsNCj4gIAkJ
CQlpZiAoaW5mby0+YWVfaWQgPT0gSVJETUFfQUVfUVBfU1VTUEVORF9DT01QTEVURSkgew0KPiAg
CQkJCQlhdG9taWNfZGVjKCZpd2Rldi0+dnNpLnFwX3N1c3BlbmRfcmVxcyk7DQo+ICAJCQkJCXdh
a2VfdXAoJml3ZGV2LT5zdXNwZW5kX3dxKTsNCj4gQEAgLTMyOCw3ICszMjcsNyBAQCBzdGF0aWMg
dm9pZCBpcmRtYV9wcm9jZXNzX2FlcShzdHJ1Y3QgaXJkbWFfcGNpX2YgKnJmKQ0KPiAgCQkJCWNv
bnRpbnVlOw0KPiAgCQkJfQ0KPiAgCQkJaXJkbWFfcXBfYWRkX3JlZigmaXdxcC0+aWJxcCk7DQo+
IC0JCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZyZi0+cXB0YWJsZV9sb2NrLCBmbGFncyk7DQo+
ICsJCQl4YV91bmxvY2tfaXJxcmVzdG9yZSgmcmYtPnFwX3hhLCBmbGFncyk7DQo+ICAJCQlxcCA9
ICZpd3FwLT5zY19xcDsNCj4gIAkJCXNwaW5fbG9ja19pcnFzYXZlKCZpd3FwLT5sb2NrLCBmbGFn
cyk7DQo+ICAJCQlpd3FwLT5od190Y3Bfc3RhdGUgPSBpbmZvLT50Y3Bfc3RhdGU7DQo+IEBAIC0x
NzAxLDYgKzE3MDAsNyBAQCBzdGF0aWMgdm9pZCBpcmRtYV9kZWxfaW5pdF9tZW0oc3RydWN0IGly
ZG1hX3BjaV9mDQo+ICpyZikNCj4gIAlkZXYtPmhtY19pbmZvLT5zZF90YWJsZS5zZF9lbnRyeSA9
IE5VTEw7DQo+ICAJdmZyZWUocmYtPm1lbV9yc3JjKTsNCj4gIAlyZi0+bWVtX3JzcmMgPSBOVUxM
Ow0KPiArCXhhX2Rlc3Ryb3koJnJmLT5xcF94YSk7DQo+ICAJZG1hX2ZyZWVfY29oZXJlbnQocmYt
Pmh3LmRldmljZSwgcmYtPm9ial9tZW0uc2l6ZSwgcmYtPm9ial9tZW0udmEsDQo+ICAJCQkgIHJm
LT5vYmpfbWVtLnBhKTsNCj4gIAlyZi0+b2JqX21lbS52YSA9IE5VTEw7DQo+IEBAIC0yMDkxLDEz
ICsyMDkxLDEyIEBAIHN0YXRpYyB2b2lkIGlyZG1hX3NldF9od19yc3JjKHN0cnVjdCBpcmRtYV9w
Y2lfZg0KPiAqcmYpDQo+ICAJcmYtPmFsbG9jYXRlZF9haHMgPSAmcmYtPmFsbG9jYXRlZF9wZHNb
QklUU19UT19MT05HUyhyZi0+bWF4X3BkKV07DQo+ICAJcmYtPmFsbG9jYXRlZF9tY2dzID0gJnJm
LT5hbGxvY2F0ZWRfYWhzW0JJVFNfVE9fTE9OR1MocmYtPm1heF9haCldOw0KPiAgCXJmLT5hbGxv
Y2F0ZWRfYXJwcyA9ICZyZi0+YWxsb2NhdGVkX21jZ3NbQklUU19UT19MT05HUyhyZi0NCj4gPm1h
eF9tY2cpXTsNCj4gLQlyZi0+cXBfdGFibGUgPSAoc3RydWN0IGlyZG1hX3FwICoqKQ0KPiArCXJm
LT5jcV90YWJsZSA9IChzdHJ1Y3QgaXJkbWFfY3EgKiopDQo+ICAJCSgmcmYtPmFsbG9jYXRlZF9h
cnBzW0JJVFNfVE9fTE9OR1MocmYtPmFycF90YWJsZV9zaXplKV0pOw0KPiAtCXJmLT5jcV90YWJs
ZSA9IChzdHJ1Y3QgaXJkbWFfY3EgKiopKCZyZi0+cXBfdGFibGVbcmYtPm1heF9xcF0pOw0KPiAN
Cj4gKwl4YV9pbml0X2ZsYWdzKCZyZi0+cXBfeGEsIFhBX0ZMQUdTX0xPQ0tfSVJRKTsNCj4gIAlz
cGluX2xvY2tfaW5pdCgmcmYtPnJzcmNfbG9jayk7DQo+ICAJc3Bpbl9sb2NrX2luaXQoJnJmLT5h
cnBfbG9jayk7DQo+IC0Jc3Bpbl9sb2NrX2luaXQoJnJmLT5xcHRhYmxlX2xvY2spOw0KPiAgCXNw
aW5fbG9ja19pbml0KCZyZi0+Y3F0YWJsZV9sb2NrKTsNCj4gIAlzcGluX2xvY2tfaW5pdCgmcmYt
PnFoX2xpc3RfbG9jayk7DQo+ICB9DQo+IEBAIC0yMTE5LDkgKzIxMTgsNyBAQCBzdGF0aWMgdTMy
IGlyZG1hX2NhbGNfbWVtX3JzcmNfc2l6ZShzdHJ1Y3QNCj4gaXJkbWFfcGNpX2YgKnJmKQ0KPiAg
CXJzcmNfc2l6ZSArPSBzaXplb2YodW5zaWduZWQgbG9uZykgKiBCSVRTX1RPX0xPTkdTKHJmLQ0K
PiA+YXJwX3RhYmxlX3NpemUpOw0KPiAgCXJzcmNfc2l6ZSArPSBzaXplb2YodW5zaWduZWQgbG9u
ZykgKiBCSVRTX1RPX0xPTkdTKHJmLT5tYXhfYWgpOw0KPiAgCXJzcmNfc2l6ZSArPSBzaXplb2Yo
dW5zaWduZWQgbG9uZykgKiBCSVRTX1RPX0xPTkdTKHJmLT5tYXhfbWNnKTsNCj4gLQlyc3JjX3Np
emUgKz0gc2l6ZW9mKHN0cnVjdCBpcmRtYV9xcCAqKikgKiByZi0+bWF4X3FwOw0KPiAgCXJzcmNf
c2l6ZSArPSBzaXplb2Yoc3RydWN0IGlyZG1hX2NxICoqKSAqIHJmLT5tYXhfY3E7DQo+IC0JcnNy
Y19zaXplICs9IHNpemVvZihzdHJ1Y3QgaXJkbWFfc3JxICoqKSAqIHJmLT5tYXhfc3JxOw0KPiAN
Cj4gIAlyZXR1cm4gcnNyY19zaXplOw0KPiAgfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZp
bmliYW5kL2h3L2lyZG1hL21haW4uaA0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS9t
YWluLmgNCj4gaW5kZXggZDMyMGQxYTIyLi42ZmQzZGJlZjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvaW5maW5pYmFuZC9ody9pcmRtYS9tYWluLmgNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5k
L2h3L2lyZG1hL21haW4uaA0KPiBAQCAtMzIxLDkgKzMyMSw4IEBAIHN0cnVjdCBpcmRtYV9wY2lf
ZiB7DQo+ICAJc3RydWN0IGlyZG1hX2FycF9lbnRyeSAqYXJwX3RhYmxlOw0KPiAgCXNwaW5sb2Nr
X3QgYXJwX2xvY2s7IC8qcHJvdGVjdCBBUlAgdGFibGUgYWNjZXNzKi8NCj4gIAlzcGlubG9ja190
IHJzcmNfbG9jazsgLyogcHJvdGVjdCBIVyByZXNvdXJjZSBhcnJheSBhY2Nlc3MgKi8NCj4gLQlz
cGlubG9ja190IHFwdGFibGVfbG9jazsgLypwcm90ZWN0IFFQIHRhYmxlIGFjY2VzcyovDQo+ICAJ
c3BpbmxvY2tfdCBjcXRhYmxlX2xvY2s7IC8qcHJvdGVjdCBDUSB0YWJsZSBhY2Nlc3MqLw0KPiAt
CXN0cnVjdCBpcmRtYV9xcCAqKnFwX3RhYmxlOw0KPiArCXN0cnVjdCB4YXJyYXkgcXBfeGE7DQo+
ICAJc3RydWN0IGlyZG1hX2NxICoqY3FfdGFibGU7DQo+ICAJc3BpbmxvY2tfdCBxaF9saXN0X2xv
Y2s7IC8qIHByb3RlY3QgbWNfcWh0X2xpc3QgKi8NCj4gIAlzdHJ1Y3QgbWNfdGFibGVfbGlzdCBt
Y19xaHRfbGlzdDsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS91
dGlscy5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L2lyZG1hL3V0aWxzLmMNCj4gaW5kZXgg
MDhiMjNlMjRlLi4zNGUzMzJiYTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9o
dy9pcmRtYS91dGlscy5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9pcmRtYS91dGls
cy5jDQo+IEBAIC03OTgsMTUgKzc5OCwxNSBAQCB2b2lkIGlyZG1hX3FwX3JlbV9yZWYoc3RydWN0
IGliX3FwICppYnFwKQ0KPiAgCXUzMiBxcF9udW07DQo+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsN
Cj4gDQo+IC0Jc3Bpbl9sb2NrX2lycXNhdmUoJml3ZGV2LT5yZi0+cXB0YWJsZV9sb2NrLCBmbGFn
cyk7DQo+ICsJeGFfbG9ja19pcnFzYXZlKCZpd2Rldi0+cmYtPnFwX3hhLCBmbGFncyk7DQo+ICAJ
aWYgKCFyZWZjb3VudF9kZWNfYW5kX3Rlc3QoJml3cXAtPnJlZmNudCkpIHsNCj4gLQkJc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmaXdkZXYtPnJmLT5xcHRhYmxlX2xvY2ssIGZsYWdzKTsNCj4gKwkJ
eGFfdW5sb2NrX2lycXJlc3RvcmUoJml3ZGV2LT5yZi0+cXBfeGEsIGZsYWdzKTsNCj4gIAkJcmV0
dXJuOw0KPiAgCX0NCj4gDQo+ICAJcXBfbnVtID0gaXdxcC0+aWJxcC5xcF9udW07DQo+IC0JaXdk
ZXYtPnJmLT5xcF90YWJsZVtxcF9udW1dID0gTlVMTDsNCj4gLQlzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZpd2Rldi0+cmYtPnFwdGFibGVfbG9jaywgZmxhZ3MpOw0KPiArCV9feGFfZXJhc2UoJml3
ZGV2LT5yZi0+cXBfeGEsIHFwX251bSk7DQo+ICsJeGFfdW5sb2NrX2lycXJlc3RvcmUoJml3ZGV2
LT5yZi0+cXBfeGEsIGZsYWdzKTsNCj4gIAljb21wbGV0ZSgmaXdxcC0+ZnJlZV9xcCk7DQo+ICB9
DQo+IA0KPiBAQCAtODQ5LDExICs4NDksMTYgQEAgc3RydWN0IGliX2RldmljZSAqdG9faWJkZXYo
c3RydWN0IGlyZG1hX3NjX2RldiAqZGV2KQ0KPiAgc3RydWN0IGliX3FwICppcmRtYV9nZXRfcXAo
c3RydWN0IGliX2RldmljZSAqZGV2aWNlLCBpbnQgcXBuKQ0KPiAgew0KPiAgCXN0cnVjdCBpcmRt
YV9kZXZpY2UgKml3ZGV2ID0gdG9faXdkZXYoZGV2aWNlKTsNCj4gKwlzdHJ1Y3QgaXJkbWFfcXAg
KmlxcDsNCj4gDQo+ICAJaWYgKHFwbiA8IElXX0ZJUlNUX1FQTiB8fCBxcG4gPj0gaXdkZXYtPnJm
LT5tYXhfcXApDQo+ICAJCXJldHVybiBOVUxMOw0KPiANCj4gLQlyZXR1cm4gJml3ZGV2LT5yZi0+
cXBfdGFibGVbcXBuXS0+aWJxcDsNCj4gKwlpcXAgPSB4YV9sb2FkKCZpd2Rldi0+cmYtPnFwX3hh
LCBxcG4pOw0KPiArCWlmICghaXFwKQ0KPiArCQlyZXR1cm4gTlVMTDsNCj4gKw0KPiArCXJldHVy
biAmaXFwLT5pYnFwOw0KPiAgfQ0KPiANCj4gIC8qKg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
bmZpbmliYW5kL2h3L2lyZG1hL3ZlcmJzLmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvaXJk
bWEvdmVyYnMuYw0KPiBpbmRleCBjZjhkMTkxNTAuLjlkODAzODhmNCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L2lyZG1hL3ZlcmJzLmMNCj4gKysrIGIvZHJpdmVycy9pbmZp
bmliYW5kL2h3L2lyZG1hL3ZlcmJzLmMNCj4gQEAgLTExMDQsNyArMTEwNCwxMyBAQCBzdGF0aWMg
aW50IGlyZG1hX2NyZWF0ZV9xcChzdHJ1Y3QgaWJfcXAgKmlicXAsDQo+ICAJc3Bpbl9sb2NrX2lu
aXQoJml3cXAtPmxvY2spOw0KPiAgCXNwaW5fbG9ja19pbml0KCZpd3FwLT5zY19xcC5wZnBkdS5s
b2NrKTsNCj4gIAlpd3FwLT5zaWdfYWxsID0gaW5pdF9hdHRyLT5zcV9zaWdfdHlwZSA9PSBJQl9T
SUdOQUxfQUxMX1dSOw0KPiAtCXJmLT5xcF90YWJsZVtxcF9udW1dID0gaXdxcDsNCj4gKwlpbml0
X2NvbXBsZXRpb24oJml3cXAtPmZyZWVfcXApOw0KPiArDQo+ICsJZXJyX2NvZGUgPSB4YV9lcnIo
eGFfc3RvcmVfaXJxKCZyZi0+cXBfeGEsIHFwX251bSwgaXdxcCwNCj4gR0ZQX0tFUk5FTCkpOw0K
PiArCWlmIChlcnJfY29kZSkgew0KPiArCQlpcmRtYV9kZXN0cm95X3FwKCZpd3FwLT5pYnFwLCB1
ZGF0YSk7DQo+ICsJCXJldHVybiBlcnJfY29kZTsNCj4gKwl9DQo+IA0KPiAgCWlmICh1ZGF0YSkg
ew0KPiAgCQkvKiBHRU5fMSBsZWdhY3kgc3VwcG9ydCB3aXRoIGxpYmk0MGl3IGRvZXMgbm90IGhh
dmUgZXhwYW5kZWQNCj4gdXJlc3Agc3RydWN0ICovDQo+IEBAIC0xMTI5LDcgKzExMzUsNiBAQCBz
dGF0aWMgaW50IGlyZG1hX2NyZWF0ZV9xcChzdHJ1Y3QgaWJfcXAgKmlicXAsDQo+ICAJCX0NCj4g
IAl9DQo+IA0KPiAtCWluaXRfY29tcGxldGlvbigmaXdxcC0+ZnJlZV9xcCk7DQo+ICAJcmV0dXJu
IDA7DQo+IA0KPiAgZXJyb3I6DQo+IC0tDQo+IDIuNTIuMC40NTcuZzZiNTQ5MWRlNDMtZ29vZw0K
DQo=

