Return-Path: <linux-rdma+bounces-7723-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1EFA34026
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 14:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2271E7A3718
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 13:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3411E227EAF;
	Thu, 13 Feb 2025 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lph9LQc1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC6A23F420;
	Thu, 13 Feb 2025 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452794; cv=fail; b=c6PeuwGf6YVmSM9yCq0bvQW3nWVYS68+AFngaf6hMaS5LVKsLEJsplOET0Yxnb3uVo9/qhf0zIWTF/ZhQgVsZy00oxNEmtPVOfl0ae3Xngshr+nkg8u5fkVlBXIaTmmdHotQ2CysVsc+Rz4kPEfvthfVaieLjhAE4LG5mrBN3xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452794; c=relaxed/simple;
	bh=23jb7II2FKM21LLAl7Zt0GTvO8OoIxplXMHc+lUePfc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gfu3PyO/m+x/2SVVvGwmqIKoJjIarDfsDGc67/7d7ELKbcBdeVLI3B5OER2MiXbhgQs9G3HU5wIxi+YgZgZnsZnUf4csilNnWvNrRgLPVq2KyClVZwQcsYr3tbaxxzqgWE0Fz55EH9u8RGqkexG1rRL//gdQJRtWH+2eaZMOwUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lph9LQc1; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739452793; x=1770988793;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=23jb7II2FKM21LLAl7Zt0GTvO8OoIxplXMHc+lUePfc=;
  b=Lph9LQc1QYa9gHkL9bnXF003czQls3apxbShMnysV+Ea0odM247yFvSx
   X99vdp7E7y3HoX1hL/i2CPdmNgpJfKoa0WksqwQHNHrbQrjV8L5FOac4W
   rGecMAIFM2IRp79cCbqdjb1LKW5HLD/xFBx9LyKJLfkn2uMfuFr7WuEly
   62q8pBrcUV8tEsjrFMl2UHVnfCAwNnbgr7+cJu3hDd26cNdmIrmbb3eH9
   mt++69/3AeCVpXXK5gE4N4bGTSEooJg8RuXaz0zWouvhT60DpbIN67xmA
   3PlH/P1zaEGWD+i4q0gLmSvELiQ1IIR0rx/6nf+sRPDwn+TBfhj1v0T5L
   g==;
X-CSE-ConnectionGUID: OINkaR+2Su+EsSon3z0aww==
X-CSE-MsgGUID: aL5Q6vf2TTC+EIiGkaN8dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40016808"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40016808"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:19:52 -0800
X-CSE-ConnectionGUID: osNgpWtVShaaVFJrPTk2Hg==
X-CSE-MsgGUID: h3pfjZiWSpekuf2Sq5gotA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="118230435"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 05:19:51 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 05:19:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 05:19:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 05:19:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4W2rkluiugz2E2xLytAWclpwYllkVZHBsjrQ6RvHDLEQtXEjyu43kGyCS88DFXIBcBjTi8QXLXhrHMDNBQW8gNsZy020R8KfgsP/Q0V/YMqBrYaIvOjQO/LD+mIfSA3XCZHjuZY2hz3agjcm5OXmGsjQBPjIa2wFIdf3TOIUWlHpl/fgoNdCjlyG3HjGXS1Kn95P/46B5T7iXKte1HIYNYeF+hWRvDvWtkrlqinks9zU1x2pJFXS84iYl6cHT46rJ3FTwITB6yctAeml37aB1/ZzcAb3THlQ7cS+vVpKMXF7BJk4CD2vszPwVXlFp6Vs3pLKYBqko8p8Eru1PQbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLnUw65q1ThTyoKuqLOegi1jrSmdcBzK2A5pfIMT/xE=;
 b=UTRx86LuV3x4Y5d8qUnCoxP2mXwZnvmb6Mvj4klpwPEpiwa1aK/LcxteJ5EhkrX/CThmQgKq1XZ7yZB4NOWp0i7NPEXrtkQQfDoL1hfuG3PRO1RQqz77K0o0PnFE+d6ITRh2S2BFMXeTgFK5tjwwe3hOmbhp6gvxOx6SmIrgLCYolClgenKIXbuCD4yNFXaMNKDAxgU84SahF797CFqfMcu++WhjHVsDvV36n/GFhavHZxKApKcDccyzB3wNhdgxHwQEhxUp0nFdlsyQUMY24LOkVEpx6y136IgASSw6yp7w6XP3cvOEK74WKHtrG5Vx0cqGnTq/mbM11BKSRg9J1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB6288.namprd11.prod.outlook.com (2603:10b6:8:a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Thu, 13 Feb
 2025 13:19:45 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:19:45 +0000
Message-ID: <daca71bd-547d-406c-83d8-05f8508703b2@intel.com>
Date: Thu, 13 Feb 2025 14:19:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] fwctl/mlx5: Support for communicating with mlx5
 fw
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
	<aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, "Daniel
 Vetter" <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, "David
 Ahern" <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>, "Christoph
 Hellwig" <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>, Leon
 Romanovsky <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, "Nelson, Shannon" <shannon.nelson@amd.com>
References: <7-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <7-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0069.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::46) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 848cce9c-3b0d-47a4-f815-08dd4c3115a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SExSblNaZjY4cnhRSXFyc0Y2amJqV2IwY2pTRXgxbnNMTnBtREMzU1BzekNz?=
 =?utf-8?B?Y0NQVnFES3lSTVE0dGFaUXlGTVFzUGx1VWRVREVINnREVHBwYUwrUkRjQXM4?=
 =?utf-8?B?V0lldm1aLzZRaW1Uc0FmRnp5c2E2RHN0NHA1dzBZWm1wTlE5eFFaaGRQVUJU?=
 =?utf-8?B?dkc0UDFIZy9SZHY5dXoyaVhYMmcxMWo3QWhaSmJQMnlpcFlzRll0OXFhMEFx?=
 =?utf-8?B?NjgvS1VQeEVsWDlpNitsRkZRNFpCM3JpWjllRE0yL3puaEdLWWF0K2xwZTFR?=
 =?utf-8?B?VkdlUEMxUU9ONFVSalQzUTdMUUxGZ2tUMmpKS1JvNUk3Nmtid21mMDNOTmN6?=
 =?utf-8?B?NCtNL0wrNUYrM2ZPdTNtd0QwZDFLTC9KbmVUV0sxMnVZb1hnNW9FY3ZBaFFM?=
 =?utf-8?B?cDJNdkUyWk5RZXhJMnVMZ0FRM2hUUG9kbHBvRlprYmpEQ3V5eXAxZnEwYTRs?=
 =?utf-8?B?VVNZU2pWVkdZQTU1YkRia1oyRTdXVndrY2NXOFBjUXd1RzluRGhaSWFhOUJx?=
 =?utf-8?B?VUpiZVdvemJpVHJmQml0WGRIWlpDQU1EMU12ZDlCLzdMZEE3RDM2OTRSOHdX?=
 =?utf-8?B?S3NwZXV4Zk9UZVBvZlQ3UlVJeURvUWlMWC8vbjhnVi9hemJmb1pCY1BCMTRF?=
 =?utf-8?B?dmxkMFkxQWNCb1ViZEljTElIdnJmNW5CcjFUOWZBa2ZjbUQ4c3pVUnVqdis0?=
 =?utf-8?B?SndSS1N4eGxiTlVpYlhjTmM0SmJsZUMyWWtHaTNaWDNMTUpqUGZkR1g2WGhh?=
 =?utf-8?B?NTM1Y2NIUDd3WnQvRzBtM3JoaG56MTNxN3JkQm5uMTJwVk9jY3o5eW9qUWtL?=
 =?utf-8?B?MFZIQmIvNDJpYnBPRXJJY2s2MXo4N3huWVB3bSt0bE9zQjNKT2I3dDVaVVB3?=
 =?utf-8?B?cGk4akZJT0ZNQjlzSXlldGRSWXRUN2wva0dlZjA4VFYzTm4zMzFtS0RueU9W?=
 =?utf-8?B?V1BNeHgxTThrdDZzck1WVS9pRkFrbSt1V25MYTJjMUN5WUxhWkFpOURNKzVJ?=
 =?utf-8?B?RkVzakZ0WHNhajZIb2VST3lxTTdxOERDc1owZ3o3MS9SZGgzOHlxQjN1WGJo?=
 =?utf-8?B?OVdjRDJ1THRIR3g3V2VVRXVIdFM1dnFyVDZGNUEwVnZFQmk3TWVCZU5GZ3pq?=
 =?utf-8?B?YkxKOW1BZFVlQUt3S1lzV1NpUnJaajZzUW5ERXNaLzc5V1NTQmk4UG5IemF2?=
 =?utf-8?B?THloQ1Q1OGI1S01sT1NIcGZIZVJnZ2wveFd4YUIrU3diTWNuU293QmZDdjI3?=
 =?utf-8?B?UEMybUxBSGJ6NmxIQWtSUGxyQ3owbUp2ZzZITjhuSUo0U3dZd1krZnNVYkIw?=
 =?utf-8?B?SUFnMjhGZFlsZWp2d0I4UkI1c25XUlQ2N1NWYUNOdlh0QkVxT213czVVK3Zv?=
 =?utf-8?B?cmNVamdGdHYveFhyUmNvT0RoQjhWSEU5VTEzZVJDWUd6Vk5lYjh2MWhwWC9N?=
 =?utf-8?B?cWNmb0dyK2Y5YkJGL3JxYWpXVGVtK2ZtNEJYTWpIWkhWc1U0V1huNWF2NU80?=
 =?utf-8?B?aDJCVUZNd0Vlc0dreU9OMCtsQlRqT25STGRCcStnbkNCdXEvSStwVGFSNGZ0?=
 =?utf-8?B?YnhPV0JWZWVPdjdtejlqNkRiMmN4ZzJNaU9UZ3Q4cE9LdXVQUmY3b0huN05i?=
 =?utf-8?B?SUI3UGU0WEpqOTBlYk1lOUdvbVZLbHFPeFgyekViVElNc0dTbWViNFJ3ZVlj?=
 =?utf-8?B?KzhjV0Z0cml4N3N0OWdGd0RSeGFOY3pMQUlpZlA2alZKMDRBSlM3UnE2MHlZ?=
 =?utf-8?B?b0taOHRXY1dmbEVoNjBVZDBzcW0xbWdaVHlYM0Y3YUFRU04yZ3lvaGRBU3dD?=
 =?utf-8?B?K1BhQm5xOGZyRnJNOEE1UmVvSG5IWWV2ci91aHA2bjlGbHdJOWNDTTVPaS81?=
 =?utf-8?Q?0OquRD75QpyN4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzZrdzFORlRxV3pQUmx0c3E0M1FDTXJTSlowZWtDYWNOU3oxL1FYb2NXS3JT?=
 =?utf-8?B?WjFOcWRZTnMyTUJvVUlRNW5weThFOTBBU1daaGhsV3VPNnROQnh1azFRS0VM?=
 =?utf-8?B?dXNIaE1RRmg0enRuZkxWZlgxWkV6V2p4ZTI5YXRuWXVoR1FEZkRrclI3ZGdh?=
 =?utf-8?B?Zy9JbUwrREhnRkhURmluVFNRa3JLU0hPM202OVgyU1IybjBBcC8xVkw2TlBD?=
 =?utf-8?B?VlI2S1VsQUkwc0JUWjBmM1lnWit6enYxNnZmM0hmS05XZlJRYU51WkUxL1Ra?=
 =?utf-8?B?Z0lEWWZhK0c3dlZxWkI0TFUyc3pTc3RpRWhISmNPRHhZVHpHS3c2TDdTL2k1?=
 =?utf-8?B?T3NQdzgxS0gzbEtQMGNuTlJqQWZPUm04Vk9Xdmt2R3lvTUg2NDNqajE0SmVz?=
 =?utf-8?B?TSt0ZThRdUFIa3lJMmVnL0R2UVFKcW9sRmRqejh5ZXdPRGQ4bTJLN3BoN3Nv?=
 =?utf-8?B?L2o4bHV2UkVaWXU4aDJqSXhncit1cnQweUYyMnZEbzhWcXZ2QU5GTlk3OSsx?=
 =?utf-8?B?M3ROdjBXSFFUTmJaV0Iza0lNc0VNejlneXQxdGc5STdqdXJsbHZmY2UwMlll?=
 =?utf-8?B?S3lMUzNvNVYwcmIraVhPY2Qxb0RsaXhnUWpsL0w2VHlldHJ3ZEVjYVlxS3JV?=
 =?utf-8?B?Q2pLa2VqY0Yzb2k3YVhDRkl2RjhpdEhDUm5DMnhwL2pEVVJWMU9Rc2thZE43?=
 =?utf-8?B?WDA5eXFGSXdMcFdPT0F1MHo4eXV1WFgvdFo3WWlmM0QxdkpjZGl3MEZFWFRF?=
 =?utf-8?B?ZmFmc1hPclAxcEFvMWp5cm1FQW1Zak5OZTZVRFV3VVV4Q2F6WDFudFY0TU1s?=
 =?utf-8?B?UWNpUWYyUnJsd05YQ24zeDR0bXVqUHRCVktTMFJmc2txVVVVYW5ESFplbzZ0?=
 =?utf-8?B?VW1nZkczQ1hPREYvbEVIN1lUckZ3ekFObDliVWVBMHVjVmJPak4xMlJGT05Y?=
 =?utf-8?B?QUl1RHFOMnorWGJpM1ZiaGRYWVQxTU9WbDFkb3FPVzhEMU54UFpEWUdIV1pS?=
 =?utf-8?B?OHZzTWRzbWYrYVFjRFZ4eEl4RE5pVitCa0VNUUE0WjkyQVRaRE1sMnNoOWVo?=
 =?utf-8?B?NlU0Zml0R3JJd1hNbDJLZndyd0diNEV0UGduRWlOc0RCN1MxY1VyZ2xac2Nr?=
 =?utf-8?B?dnlZN2hSZ3VuT3VCNG5zOXVuZXpEU1V1UTNEbkk0R2dSalhTTFVGUHVjcFJH?=
 =?utf-8?B?VjRQeTFDa1ZwTXZiVGlVUU1hT2IxY0I4TllFMHk0elZEWjhaa0ljNXRwZ282?=
 =?utf-8?B?dXBvVDMraHpCQVA3Vnc0NGRBTjlYTDB5MFpnTDFjUjJKTG9Qd1ZUbmpWOFRU?=
 =?utf-8?B?eERIcnVBMDVQb3ZMalhYTFV6M09NVktWNHh2Tm12ZlIrVlUyQUptaEh2dGpu?=
 =?utf-8?B?aGdacXNwRisxTXZkam1pdXd3TkpJclZzcU9vVm5KY1hld3pyaFZwRUlIb3pR?=
 =?utf-8?B?Sll4R01ZWTJrazBmQUNNK3Y3VlkyRkVsWXpMWUlaOWkzNnV5L1o2aTZTVENi?=
 =?utf-8?B?OU5ZUkVZeHpEUWRYMzg3RENMNkgwaFhaUHdNQWo3a1kwOTB6MkorUWJpNWxa?=
 =?utf-8?B?cSs2N1NOTkFIYTRLUk9lRVlYZ2o0WE5vVzdTd1BTdllYUEJTb3pScjAwSU53?=
 =?utf-8?B?Nlg5VGF0WlpJYk14Z3lkNnNibC9WZjJ3VDlaK2tGU3QwRjlvNEFVMlkxczlE?=
 =?utf-8?B?a3J0b2tmNnp6UjQ1WWRFenRTbS9VaDRZeFFic3VjU3ppbHpiUUxpWHpOeVhN?=
 =?utf-8?B?U1BTRTFqb1gwbzlkUW5Ydjd3ZDkzSHZQQ1VjNjZocll5bUw5czV6V1lkdzA1?=
 =?utf-8?B?Wlk0N0QxdHV1L3FwTkVvTmh3cGhtd1h2UWx6TXpaMG1lNFJ2a2NmYUg4WUl6?=
 =?utf-8?B?bmpYQldNZDJucUJxRmczRWEwS1AzMTFDMnRaTVk4NGNvU3ljZXZHNW5PS0lI?=
 =?utf-8?B?TTFyVjhobDJzMncyeFk4K3orU254TXlQcllHNVIrbFZmV2N5TVpsTks4YnI2?=
 =?utf-8?B?aER4REpXOFYrRHo0UHdCS1doblpRNjl3KzVlRDI2K0Z5VXRLckFBTHNtaEUr?=
 =?utf-8?B?MnFvbUhhQ28xTmlySU53TUxPdmJ6bitBeS9GOTBFUVZ1VUVsV2dpSjhQRUht?=
 =?utf-8?B?Z25tZDNTa1FOWEduUzcxc0VFdnk4bXpaM1JnMXQyK2RyQ0srTURwcHNicmFL?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 848cce9c-3b0d-47a4-f815-08dd4c3115a1
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:19:45.7667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w24TL4t9soLJzEA/y9D7dPiQhjPxTgKaySvTHo7sRT8QxdBhJ+yPPTq+a1Hun7qwaqN5sU2JD/a7N66dq+MwMrJ0cdQ9LnCxeMLYNg0A/3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6288
X-OriginatorOrg: intel.com

On 2/7/25 01:13, Jason Gunthorpe wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>

In part this is a general feedback for the subsystem too.

> +FWCTL MLX5 DRIVER

I don't like this design.
That way each and every real driver would need to make another one to
just use fwctl.

Why not just require the real driver to call fwctl_register(opsstruct),
with the required .validate, .do_cmd, etc commands backed there?
There will be much less scaffolding.

Or the intention is to have this little driver replaced by OOT one,
but keep the real (say networking) driver as-is from intree?

> +++ b/drivers/fwctl/mlx5/main.c
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES

-2025

> + */
> +#include <linux/fwctl.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/mlx5/device.h>
> +#include <linux/mlx5/driver.h>

this breaks abstraction (at least your headers are in nice place, but
this is rather uncommon, typical solution is to have them backed inside
the driver directory) - the two drivers will be tightly coupled

> +module_auxiliary_driver(mlx5ctl_driver);
> +
> +MODULE_IMPORT_NS("FWCTL");
> +MODULE_DESCRIPTION("mlx5 ConnectX fwctl driver");
> +MODULE_AUTHOR("Saeed Mahameed <saeedm@nvidia.com>");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index 7a21f2f011917a..0790b8291ee1bd 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -42,6 +42,7 @@ enum {
>   
>   enum fwctl_device_type {
>   	FWCTL_DEVICE_TYPE_ERROR = 0,
> +	FWCTL_DEVICE_TYPE_MLX5 = 1,

is that for fwctl info to be able to properly report what device user
has asked ioctl on? Would be great to embed 32byte long cstring of
DRIVER_NAME, to don't need each and every device to come to you and
ask for inclusion, that would also resolve problem of conflicting IDs
(my-driver-id prior-to and after upstreaming)


