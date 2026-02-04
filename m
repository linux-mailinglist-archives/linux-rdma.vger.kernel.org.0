Return-Path: <linux-rdma+bounces-16552-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKQ7IrzOg2kFugMAu9opvQ
	(envelope-from <linux-rdma+bounces-16552-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 23:57:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2894AED218
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 23:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 414B230166F1
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 22:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054C4399008;
	Wed,  4 Feb 2026 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrAlQC4M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208C314D37;
	Wed,  4 Feb 2026 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245761; cv=fail; b=SttXFG8p+CNSsF5iZeXs6c7DcQQQpMORXh4IBwGUdY0ONvCX4vOAuxkAULHrEzXUExFaxVjsWjspd+dxWKt4DUPk5QsWhuDD9Z4eg4Pj7RHxEEQfLNTHpIBfZxt+HjcSj+NiPsFUSRVTIXK6KwbYMTO39pSk08ckDqpWjGwUL08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245761; c=relaxed/simple;
	bh=Lz0Qgitof7Avpxn4/D9JJRhZM7vX1ucgR0/RtX6lU4E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fAnl2ydkkxxE8I6eOWJ1rMltm07nkcfKV6IN68X99kwgGvNK/q0oVwoyZkcNTQOu79p6h3J7p4T0w4WlqSvRJZRlhvDH2jBNZl/utuz1XM+4TFEgbENEYDKPuNVNhUftZxl1U3LAvtDyhLj8rtaYYltrUf67w+YnlppwrRuDgiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrAlQC4M; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770245761; x=1801781761;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lz0Qgitof7Avpxn4/D9JJRhZM7vX1ucgR0/RtX6lU4E=;
  b=RrAlQC4MwXnMxS2iqd/mONfc9TyzihKby6/HJctLmImUNkQvYh3y8/fW
   AJSy58fOdF80wOv4rKhcsoS3inIaXVWXhXL0dBX2uN87LG8mz7f3WHBS6
   FhbM2RYxdRPcfO/LsLWlKFIqCvgwmpFOCLYVKfiIffYYmEEtbVvG+FB+J
   XJao/UH8acv1H1qKlMvAYIzjpNG9Bp8oGDecDpOIqGhjGgtPHcsiI0ToO
   yRnWTfqxjQu95MPuDfrmnCt6PQSahSWUtC7e9LvtfOq4R1+pzLZVG+TNB
   jlE+Y/NHxMO+O3jS+MZBstgf1ZHYmjuMiNxG2Uh7qQXEtzynlyaHTF3hd
   A==;
X-CSE-ConnectionGUID: KF7BhchpQNezwPddXKcyuw==
X-CSE-MsgGUID: paJ+A4BUQ0SROSyV0cuNUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71338327"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="71338327"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 14:56:00 -0800
X-CSE-ConnectionGUID: 7gyEj2IeRsadeyPRunCp/w==
X-CSE-MsgGUID: n9QXCaVIRq2wvRVw0IUdaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="214826068"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 14:56:00 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 14:55:59 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 14:55:59 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 14:55:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvgIj215TkpP7ETixo2bls3M/8d0Tiz0bzTryZh/GiXxF+qBl+309JY0W5SixZeQgXzRKML4BDlTbnYdAXi4hU5pKFZCc5lVPZMIpnDvtIYHTAw4O8f0IH+0hl9ph0maz5TMBllpdclObYvf/MRtuHySgdkYp5rBnF7ed+UddiAML6w0Y2HvqzK51xPfGD0eT3/zUYvKFekKf05p+ZdlHMWlHMc7eaKG9NHu9QDQqtki9lkUFmylRvdynqpp9nYLldHRg64x8WkTT0vNdvFdwGK6N/gxrUZUyzmOIK9PtmtCi5XptM3wtzxk0h50/aYng2ZA2OIJsB6zPuG43b8THA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46dKRZdSoSpquou/Bj1brsLIBsTuROICbNi/fjC4VT8=;
 b=XCNapf645lGW9XEDohlhxP7uqNmzaRiL9/1hb3Z8eSjnZjbbyw/akw2KS/Fp14pT4sOOSsuShvn+f0Itf0RwRnQL44tqpoi17Pk0M4aS+tS68d29u8UlA5T47+qxuOxpM9lfJ16acUdnEmUlk7XAd6wnPfa8sPNK+DCryWncnt+ITQi9ylbqOl5LSF8PBlz1rd0sHq8WMAWPQxxWAhzzUH3OQRLcNEGpAiyTjiPCX3SOMWVbNUxAb+BCOfvz1zR+qdHFTC4rK5Wxq5vc5ALMPBxSp3ghrzWnBsLmBylfn4SklpkMLIzrF/AMyGs058GMYMh13CsINQG0w0/noL/oLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 PH3PPF1BAF94C4A.namprd11.prod.outlook.com (2603:10b6:518:1::d0d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 22:55:56 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 22:55:56 +0000
Message-ID: <9d3d6128-41fb-4f72-acca-3bb9d6798e3c@intel.com>
Date: Wed, 4 Feb 2026 14:55:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 1/2] net/mlx5e: RX, Drop oversized packets in
 non-linear mode
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
References: <20260203072130.1710255-1-tariqt@nvidia.com>
 <20260203072130.1710255-2-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260203072130.1710255-2-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:303:8d::27) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|PH3PPF1BAF94C4A:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ac70ad-cc1a-46b5-742d-08de64408e8f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWRlaTQyVkFYeVozSUdlMDBsQVBwaGk1SlVlbGczdmJOMHNhY0tTZlYxU2Vz?=
 =?utf-8?B?TFFhZEpoWGVDd0xZcGxyMDE3NG5uMGVnQWVYUW81bHo1cUVkSk1tbTJ1UFBt?=
 =?utf-8?B?OEltVUJHbzBYOXJibGd1REtYczlwODZOYjNaeHBQaTJ4RUNVdUlPcVJiWnlK?=
 =?utf-8?B?ZFVvYkFlSmRpQVQ2eTlXY09ORFQxMWswbVJlTDgwQ0szcXg0QkRKNHZ2R2to?=
 =?utf-8?B?REpBR3VzTEdQNEtDVG9tVWVVVnkxdjltaVBtYjlRb251Y2h0WFJxWDlsS3Ax?=
 =?utf-8?B?ZStDemNPWDVIZUpWTUtJckhPd0dNaWRHTmpGWGc5NFpyYmJ6UTE1TXVnY2hk?=
 =?utf-8?B?d056K21tUmZxR0ZOU3QvUVVuZC9ZT3lqUWIxYVgzYnlYRlp1SFlGMDRMMmNL?=
 =?utf-8?B?WnU2cHQwaTgyYnFLaWVuNk9BVmFjR3YrSm9yaUVLT0VGYlVzdnA3ZWFTa1FG?=
 =?utf-8?B?ei9yMThCbGc3ZnR3bEVacFdLN2s5TGtmNmRMR1FkdkJmR2F2ekRXNHFNNU5j?=
 =?utf-8?B?ZVBFc0pINldobkFwQmNyczBKMVNSR09iVzY5RkFJR3liQnl4TkNrRzlBVUNk?=
 =?utf-8?B?RWVnZmx0aWpLVFhmdXhGRGdTQld2MkhNUHkyanNSTERCNm5xSVNZUnlNMzFy?=
 =?utf-8?B?VkEvejdiSzhWSGVOdTUzSWdSYVJrTmpHY3ZKSzFrWlpUZFJzbC8yM21ybVBL?=
 =?utf-8?B?T2x1MUY2cyt6M2hlOENDYUxJbTdodUgrbWVOYWo2RTBHOENZcnlBQm9Lb0xw?=
 =?utf-8?B?emc1d2JxKzBtK09XTEVtK3RIa1d0TG1yRUJSM2tCd3RYVytGdlFMYUNGWlY5?=
 =?utf-8?B?QnN1bjk0SWhIS2pyK3pSZ29qUEQxcHcwdmdISm1ZSGloWFVuWGladHZuR0JW?=
 =?utf-8?B?YmpxS25KTXMySmRFclRvREpuZXZlS1dubkZRMXVxTUQ4S1p6UmlocEdSTEtL?=
 =?utf-8?B?UXJKaXdEa2dMc3Ezekdaa3JsdEU4ZU1ueGs2elRUNjBSMDE3emd0eEt3Z2N1?=
 =?utf-8?B?dFd5NWwzUDZ3bEc3Q1BaN2lFZGQvckVXRzBnTUxRTk82ZmFZSXZwdHpxRlkz?=
 =?utf-8?B?SlgvOGdpVjZWai9vNmZEdjExc2E5QXFwWGxJNFZTQzVuQWxUWmpzZXRWOTZL?=
 =?utf-8?B?ZG5pV3pkUkozS1p6L3dPQWhoTVRtWG41MkJLTTRwcDhMeXBwZDFQaitvOTNa?=
 =?utf-8?B?UlhBV2E4eVI0Nnl4WGpnaW5pU0tnOUx0QXRpMDlDdU1NcjE3SEoyUXE1Y3Qy?=
 =?utf-8?B?U3d1bjR1N0FVbE5Qc2srZnlMRFVmV3BqeGdhOVF5OUdRc1MvZTh0LzdUMlNi?=
 =?utf-8?B?Wm91amI2NThBWXlXQk4rd254eFFkT0puc3dNR1ZCejFLMGNNcytuQm55OVUr?=
 =?utf-8?B?em14UWZ1WFc3eEJQMHZYbWorNUJUNUIwZjFXOFVDc3k1dWQ4V0VpOEhaaGRQ?=
 =?utf-8?B?eWc5SmZOZ0gzQ0FSR2l5VjBDWDZjaytVNFdZLzZYQnlGRzdaZWFkRVFqdFZz?=
 =?utf-8?B?bkU0dGNlS1pLQ1UvRnJtVE5KVFJES2N1NlVkOFR3cno1cDVxVng4N0UrK1RK?=
 =?utf-8?B?bXBFVFNMTUtZeFN6NXlkeldQbkt5aWM3UzdYQ3k3ZU41SkJCYmxHT0tKei9r?=
 =?utf-8?B?N2ZFT0tWdGlreCtudFg1NHpYTngyTTNGMWxoelN1RTd6OW43NEE4cGxXYnVr?=
 =?utf-8?B?akFYallLWjcxY2t2dVFEeW9rVmVMblJ4QnJ0UFlyQ3ZYM2hOcUlFRUlUUDVZ?=
 =?utf-8?B?QzRteitJTmRXZnFETlZYSFhqSEFYQjgzTEVCWXd2UUdnT29tOHlydXczWFFw?=
 =?utf-8?B?ajlKaFgrakFLZE1INC9ibm1CRFU5SWFYaWUrSXplbzZKeGY2OWNwYkcvNXJK?=
 =?utf-8?B?SnQyVGpaT1p5OThuK1JKMitNdzZjYmtWekdyMHZ3UWpvc3N1aWNVYzloUkZt?=
 =?utf-8?B?ejRtb1I3R245Q0l0M3RxVWNCRlhlOGFsQVlzb3dQbXRQUkNKQmFLRzh5a0FX?=
 =?utf-8?B?TEViUDU5UzNIQzFKU3Q0cm9tb3NiV0cxVjdMTWszTGdRakJzcDM3aENYbUNR?=
 =?utf-8?B?SERzaHVNKzBnaGZYTmwzWEdZK0xTandKUVE4Sk9MRTNBeEZkalVLRU1oeUZV?=
 =?utf-8?Q?VKh4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anE3aVlDdWVEVjRzV0Ewc1VIWksvUGdkdk5yVlBHSUcxdWVici84d1ZVTjN1?=
 =?utf-8?B?YlNJMktKUE5RMkd4Wm51Q3lkR0FEa0lGSkJCeWNNSUM4ajR3UWxWWjB1SVZR?=
 =?utf-8?B?OXNLK1FkZXo5Zmp6R1Myekpia0ZHaHdVQUVzYVFzRHpTZURva0pQckQvZnNW?=
 =?utf-8?B?VVpweGhaTmVXREE2cW01ci81SXRubnhGcENTanV5M01jR2kzU2xBS3JDYU1y?=
 =?utf-8?B?THhoeDVUZzA0NUZnQ2sxa0gzeDA4M3BkMXRvTzk4YzdWSEVobndEZHA0RVFw?=
 =?utf-8?B?Um9QNjJMeFhyY0trNWJVUHM3dlRIUVVycUZSNjJ5cHAyOU52Ly9mNFE0UFM4?=
 =?utf-8?B?UUhzYWhKWVYzMDZaTHZNaXVTZElnckgrZmZ5aFpxbGNMMUVjVE9FR1paRURl?=
 =?utf-8?B?MjU5SDZnRVFCMks2VDVsMEZETEdzTEJkRGVQbUNtSHNMVnJUS0ZrZjUvb083?=
 =?utf-8?B?VUppdmN5aDQzVTVCVGg3Z0FxSWZEQy9wd2NoclB6enJQdTVNdTNRZTdGNnhJ?=
 =?utf-8?B?VFZ6ZWI1UWkyR2pncE9ySzVoTktTTTRDdC9hWmFSNzdrVEtTUW15Z2VhcEpo?=
 =?utf-8?B?dG1MUDM1V25UdlRDV1JoRHdVSFhVQ0JUeWpWS1JiNWE3c3FqRW0wR3FnTDZp?=
 =?utf-8?B?ZTNzSFpLOUdjanZEWVk5Rk54dGxRU3FFWEJvWWZNQ2lZMGpRQzBOL2o1Ukxk?=
 =?utf-8?B?dVdkRnFOMDBGeW4vbEdLRU5wQ3ZmcXlsbk9ZYTBZdG4weGJpQzRlbi9BR2F0?=
 =?utf-8?B?VnV0MDgvMGpCbHhOWnhXRTU3VWJCWVlVTWNtc05kMkY1OWdkZjMwY1pVSWVL?=
 =?utf-8?B?eDQ2UTgwTnN3K2hiNlpwQ0I3ajZoaGVDUFNvUzBwbUk2QzdIRi93dU5jVTY4?=
 =?utf-8?B?TlJWZy9LSktKLzdQSHY5cmlGT094T0owSGV5ajQ4am5oQVFLTjR5cWk1SVhJ?=
 =?utf-8?B?UEdOSHJmdXJ1QjQ4U0RZcXUzSVEvbmtpMzJVdWl0TE8rN2VCZlRadC9VRm1n?=
 =?utf-8?B?VlphZEgzMHlMaTVWTXpjZ09NS09MRzFDTU54a3F4WStCWEFwSXJGUGRTVVVY?=
 =?utf-8?B?S3I3SXk1YVJNUDFVUTBXd2ZBb1p4cktWNUYvSlU2OUJhS1V2cTNXeHFXQzgv?=
 =?utf-8?B?Znp5TlBEVkFwbjlydDVjUGRJaUlCQUVOV0dpNW94TWJPZXRCR0dxWjNGc3Na?=
 =?utf-8?B?bDRITmVDSnJxUnVVVkt2dnV5ZnBGY3IvY0Niakg4dFpadCtwS1J4L3JwTmV4?=
 =?utf-8?B?bGU5NGRMd1FMU3FacHJoRjZlMUVOR28yWWVmUXkzOC9zMFZKT0hVN1Vsd3ZB?=
 =?utf-8?B?ekVib1hIMklyUkZza2c4cUcrdGQ1L3ZrRXl6dWVJYzJzbjgwQXUwYld6OWNj?=
 =?utf-8?B?MjJHaFgxYTVJNFZPSTBKNjdPUEh3eDFXdG1WNGVBOTRYQ3hVY0tvTndlbGVJ?=
 =?utf-8?B?VnQ3QXAzYkwwRTJTM0Q3UlRmMW02VGV6SzZmUjVlZU1iNzBVam1Gd0JTU3BG?=
 =?utf-8?B?TXlCUXhaQnpXcnlqTGc3QTZQSnVYbUVRSmVSODc0QU5OYXVwekpYOFBzcitY?=
 =?utf-8?B?ZG00N1hzNEJTckVtbTNVSzQxS01JYWpKOG9sU08rNHMrRk5mMHpVZ0FjRzBH?=
 =?utf-8?B?blIwNXlON1JYOHN2bHpYZnZsRCtWaVBkdDVQaHd3eVM3Y0xNejlUOExsMmhQ?=
 =?utf-8?B?ZzUyUVd3VXNiRG1MSHpmOG5wbWp5OTBKcHhrSWdkNzNxd2NsU05aWUJUTVZt?=
 =?utf-8?B?ZnRiRUp3NXVGekJBdy8yUVhxeHZtZ252bHBjZXlmVCtCTnhja05FTngwZ1NN?=
 =?utf-8?B?L0V0b0gyU0ZjeUFFVFFFSks4SEhESjNyU3lCSUpMNFowYXVEeWZVN2RFL2tY?=
 =?utf-8?B?T2hSY2N6K1ZrcVJNekxxMDhYUWxQU3pwT1ZQTVlMOWNFSkVvamRjcW1lMWdl?=
 =?utf-8?B?RUtsbjg4RUNJYzJVbzUvYUZPZE14bnR4K2NNcHpPV2FRRm5MMnkwak1DVE92?=
 =?utf-8?B?cTVxd0sxQ2pmZWpBZ2VJSEkxM0QvY25sVFhFWnpQd1ZZbWI4T1VidEcvazd5?=
 =?utf-8?B?TnZRYmhUYmRCcEtna2pXbS90Q3Z1amZDeWxkRnliblVBTzcrYWRIQXJ2VHZq?=
 =?utf-8?B?dmdCN1FkYnJWRVlieERDUUFQTWhzRysrZ2o4MHZsdm9hbXNNY1hBa1pkWUtp?=
 =?utf-8?B?eWtCMnBsZHp3d3VqVm5udHJWV1UwbFZITlVOdGNoQW1CTXduUVpEc2NrY2Ry?=
 =?utf-8?B?SkExWWc1MFEwQkxSclhrY0FONlAwMFFzUHpSOHZvYTlFVjRPL0duSWhEOEZo?=
 =?utf-8?B?REpvVWxOYmhpM2VaalNHbGErZ3c3aC9odlljeUNJZERpM0xqZEdWaUQ0dm9r?=
 =?utf-8?Q?vjPNyRp2jAq0RbIY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ac70ad-cc1a-46b5-742d-08de64408e8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:55:56.7162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2n+P2gq7zN9xXLnR15Wwmppon4n6CvKrPUubAaOA7zU+hneNbsNgVU114eg8qfku3OXTFm+dmGpv+jomFi6O5CUDpFtrX7kx9Gapw5svDtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1BAF94C4A
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-16552-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2894AED218
X-Rspamd-Action: no action



On 2/2/2026 11:21 PM, Tariq Toukan wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> Currently the driver has an inconsistent behaviour between modes when it
> comes to oversized packets that are not dropped through the physical MTU
> check in HW. This can happen for Multi Host configurations where each
> port has a different MTU.
> 
> Current behavior:
> 
> 1) Striding RQ in linear mode drops the packet in SW and counts it
>     with oversize_pkts_sw_drop.
> 
> 2) Striding RQ in non-linear mode allows it like a normal packet.
> 
> 3) Legacy RQ can't receive oversized packets by design:
>     the RX WQE uses MTU sized packet buffers.
> 
> This inconsistency is not a violation of the netdev policy [1]
> but it is better to be consistent across modes.
> 
> This patch aligns (2) with (1) and (3). One exception is added for
> LRO: don't drop the oversized packet if it is an LRO packet.
> 

The doc also says that the preference is to drop packets, so this makes 
sense.

> As now rq->hw_mtu always needs to be updated during the MTU change flow,
> drop the reset avoidance optimization from mlx5e_change_mtu().
> 
> Extract the CQE LRO segments reading into a helper function as it
> is used twice now.
> 
> [1] Documentation/networking/netdevices.rst#L205
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

