Return-Path: <linux-rdma+bounces-16794-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGeJKmJTjmmlBgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16794-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 23:25:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E7D131839
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 23:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86FB73018733
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 22:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487F2FE563;
	Thu, 12 Feb 2026 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwpObaQy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06802DE6FF;
	Thu, 12 Feb 2026 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770935135; cv=fail; b=XRbTJFvkZ46z8I/tpLdiKMupIg6F5eISvC9id+APDON8XvCRqQSksvO66sADg0K7I45x55fM3YZy1w5HwHCzqQGiSib3NOGqoAYs2xZB1FfOdXh+yRE8t/r7MOm0bxGr/KURBsk36lCTt2qBjNWZpsF71PODLQeYh7NlJf9XL4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770935135; c=relaxed/simple;
	bh=2RgcrkJfyIjzx6m4a8LKujK8YwJYK3tq0qO4a3tvnd4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FjoffOTpq1Qt/oE8dtBMdLxlWHVBO8l6QZDLOQ/R+fRrlVg50U4qsxZOGEyOSRjjXzOWdAyoiItQxnQQ7DgGQMrqvpUp7e1noPiOk/nI9/OYWbWkt2paNN6lsfb5b5mwE7tBpcbfSapyEIc+7VMiZkhACaf3pyPKs+63iz9lb40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwpObaQy; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770935135; x=1802471135;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2RgcrkJfyIjzx6m4a8LKujK8YwJYK3tq0qO4a3tvnd4=;
  b=kwpObaQys63bp0jRFrQVqTmlUuhUWDivz6kEThg0EsgEVR6rMmW10QYc
   yH9BCr/ZXyGK/V1DNwUw2GhnqO/vs/FySCBll85OkMgMXyVgUukYkMctP
   F8QW4fmFrT/vRoapfSubKaz5t3ekYbzFMomFMTiWWBpCPBZ8RBJtCrAev
   EUEGJ5/R9x6NckWnRTS4CAJ2gAwqKeQa7g548v2fd4yk+rN1BVd/lHBL8
   blD0Jae+SeCUKZpNzNZQ8WvYCY5v2wk1xFuGHHiQDm3dtWy9Sy2MbL/4m
   fk9XyjctViUtkPlVd60yyP65pUunGXR0Y3IxvsxRd/PJFnB4hfdHy4W9w
   w==;
X-CSE-ConnectionGUID: 91gwNT5kTfe2LPXtzqVblg==
X-CSE-MsgGUID: LfHydoYORa+Sg3iu8PBQgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="82445617"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="82445617"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:25:35 -0800
X-CSE-ConnectionGUID: 5qYqYWdvR4++PyEk0uNLPQ==
X-CSE-MsgGUID: MhVL1pKcShewHop98mRnsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="243337243"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:25:35 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 14:25:33 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 14:25:33 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 14:25:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ta7fXAcPO6QRZt1Mq5t6KWPOkO8/vlV8slgOAL6Yqp8fWYqIIvdaAR/hu+cGB1uQ0gPh2eWR6kBzG+tj7EfARtxPUq5JeDGjHfSykU2tjhtjsktV/sZlaAMWd42Da4kO1rMgKUwuhoUaCZNLiAmAN+JRGqfahpDjxhHHHF1IIX/12r5to6PVOmBbfwN91n6X1vRF/Sp3GzTy1G307WVWHBZEyRvePja8Nxd1L+O+4cUgQMlU3mPJ7uewdLltW0+cryGBAnrIX6NmczXXVz1jIu+4gncivRtDO+jfVWXQ2Zyfs+eoIvTGzQnhYgVhVh30SVHNVWWWCVYJ47NgBbkJFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8sfR++29kPa0eb7bQN13caGiWpy07ta7VJvSCMUZKQ=;
 b=LSE8fjhIGWYVFU3PhY2OdP9JNubnoRVa9NQVV/WBju2ALEtT+5I+bZ3gHkTVd5zWV/5Kj8627VcaSZLtFyKnk90LP4rtx8sfLh/+PpJSQfhk6tf8Bx7jqyWcFFr4S0k4iWzrb1/i04RMn+NMeyOpv1wbZyfKVyw1Pv5vkB76mTXlLAhxqQSJrPBqLKCVue4thOj9Stu4zgZlLUP3TVK7Knnde3W7siCRyHXDEhcWDt9u26F9jPTnAMTqmwUjIbjEyqJKLHOzWUniNYFn/bTWeygiOU918aoBx5kTyZY3kkcsg8uuZ5PLMF5FiK/0aDbg1CxSTDsUxGjyP4vGLBwgDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by SA0PR11MB4590.namprd11.prod.outlook.com (2603:10b6:806:96::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Thu, 12 Feb
 2026 22:25:31 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%5]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 22:25:31 +0000
Message-ID: <06db9958-e5b3-46db-a8f5-1c2aa8cfac4f@intel.com>
Date: Thu, 12 Feb 2026 14:25:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/6] net/mlx5: Fix multiport device check over light
 SFs
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>
References: <20260212103217.1752943-1-tariqt@nvidia.com>
 <20260212103217.1752943-2-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260212103217.1752943-2-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To PH0PR11MB7588.namprd11.prod.outlook.com
 (2603:10b6:510:28b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7588:EE_|SA0PR11MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f471f16-3818-4c45-a903-08de6a85a1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3p5NjJhWVBDTWRZQk16UnkwZHg3ZG5GaGtIcXplbVdSVWtLcFBpd1VkVWhq?=
 =?utf-8?B?TWlNZFAwK1BEemVpNTlBbC9BQmNLc0xMcDgwTHZoQ0hhMTAwaVJZbmJRME00?=
 =?utf-8?B?SVZrTndVS2VPeFlHYW94Y1RNWHUvd2JscHpQdW14dW4zVmpySVBEWHlhV2xY?=
 =?utf-8?B?cTNuUDNOakVvb0FQWUtiU2RiUCt6RFhFb09nb2dHcVF4U0RILzBONFNNRmhy?=
 =?utf-8?B?eGV0TEdjQ0xaUXhLYVVBNEc3NjhhTHgyZi85anV2UG9nQU9KUGl1aFo5ZEFX?=
 =?utf-8?B?MFpCYlFJNGR6RERyV1VGUlovNW9JUk0zMENGZzJQOXNYQkxvRGwvbFN1S3h1?=
 =?utf-8?B?OTVrbDd1YkFYeUdZNFZXUUFxZkk1UzNSKysyK1U5MXAvWDRla29GaDJTZmRt?=
 =?utf-8?B?NmcrUm5ZVGx5ZWtIMUFIQkN3LzN5cEJHa25Zdk1qQmZBQzYwK3RhejZFNGdH?=
 =?utf-8?B?MDhJc0pxVDFoUkxaZ0lRaU1UL2JsS01vb3RldXdyclVJcW9VYkw0ak9GT3Ry?=
 =?utf-8?B?RmVzdHdyb3d6TEg1MGZ0Nm8vV3llTXBxcEdQMVNGTlErQ0g2RGE5WWU4NGU0?=
 =?utf-8?B?YkRkeFRrM1dSNjk3SllUeG1DOXBpRElpNWV0S1pHa0I3ZWFocUNwakZvdkhX?=
 =?utf-8?B?bDdEMFFmbjFveUorcTdGNy8veFpNaCtjdFR5OHROOGxUU2l5TVBZNzRXTVBX?=
 =?utf-8?B?NFVsWkUxcytDaFhwb3lCVEIzcUlhSEhTQmpNTEFjYzNESEc1UkJ3aVdMTXM2?=
 =?utf-8?B?MHRiMVRFQkwxU1hKNG1qM25JQkdDWlFnYy9iNVZSK2ZhUnJjdUFIeW4vbXh4?=
 =?utf-8?B?aDdDYndmTVNWa3VtVmJXVDBCOS9SeGtGZUplRW81QmQwOVpzT0cxRlNRajYv?=
 =?utf-8?B?Y2R1QTN0VTR0WE9mMWtXYmRBLzhHSkw5ZzJQdWpQMUY5bFpTblJvYm5MOHhL?=
 =?utf-8?B?eWMrRWRzSHBkeUVzeXdoSUpCM2I4T1Y2VnZ0NTc3d3diNGRtSHowRnh2NG1P?=
 =?utf-8?B?QXkvaVcwU002TTN4enVWdlhvaUZvQVBQOThaWkRGeHZuU3RCVkNkdGdXQUI3?=
 =?utf-8?B?RVNFaWtKYUF3ZVhKdzFHTDRwTG1aSytISFNRa0xrSFE0clBIKzJKWmVtcDFR?=
 =?utf-8?B?OFdwdEpzcXlWNmUyNlkvSEhoeVNWbU1EQnVWOGsyZEhLVmFranJYdk15dU5t?=
 =?utf-8?B?MmY1amtBNm4wSWx5UFF1L3BCNWxNYytuTzBtVitWNTZ1STBRSkRIMFlKcnFs?=
 =?utf-8?B?VkNhRnY1UTUxWWVqR0Nqc3dxZGZ4amRZbmhabTJvT3c3ckJtMkE3aVR5ZzJJ?=
 =?utf-8?B?YVE3RWZnbEhmellZR1FFcHFxM0RDR3cvSDdQQWNEUkFMbW8zVTdmOHIwK2ps?=
 =?utf-8?B?NzI2c2RESm5aQUFoNVMwT0FreXBYQnArQVNWZTVLd0pYTVNZeE9kL0ZaaGtY?=
 =?utf-8?B?WjdieEF1RnE3V3J0OUpQTlE2NktWK0VRMUNITzliMzVUSGQ4eVBLdmFNV1d6?=
 =?utf-8?B?UW0zeEk5bUNwT05uTmkxL0VKbGRNZlBvZDJxdWRaWlMyM0ZET0h6Y3hYQWp4?=
 =?utf-8?B?bTgvMFN0MmZiakZ4ZEQ4eVdNb29Qc2lJTGR5SXQ2M3kzVGx6SXFBUmdSNEtw?=
 =?utf-8?B?UmdyTzZSdjB0RU9CZXA1dzNkMWdtZUhxNjZpL1g3RHhkU3hLTlVTZ0ZZREdD?=
 =?utf-8?B?Wm1nL2daT2VyWTAzaVo3R3NLSzRleG5WTnFJZmFMc25veDhqSTJobzJBQWtL?=
 =?utf-8?B?VWVDRE90VzJSeWpMNDNJejhPZ2VNcVJ5bGQ1aHUvUlBNLzE4ajZPbExhZHpK?=
 =?utf-8?B?ZHFHREV3N3hwbmF6ZFFzYTVqU1FXSUgvT2NQMmdNaU1mWTcyblBIOUkwMnB4?=
 =?utf-8?B?Sk0yV2ZMZ3A4VmhtMzdSb3owNGxWUzl5S09PMkhXYzU2RTV5OFFJbkJHRG5j?=
 =?utf-8?B?L3lWYWh4SE9yNDZnOVp0VFNGOEx3QkZwYU41Wm8rQWIycXVIS2doSTNsRHZk?=
 =?utf-8?B?dzhyeEhMck9kc2hpNW9pcUdQMXdaYmtKdkFFZ2hIRVdkZi95QUpsclNxZ3Ft?=
 =?utf-8?B?dWZjaU40WC9OZWs0eXk4M3VJVG1oZGxsa2JXRk5tVVVmT0t5RE9IMEhjcVJk?=
 =?utf-8?Q?Q7FE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7588.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTBTUzhxc24zcXdrRm43c1BkUURNVllsNGlrNW1NNWZWVUM4aDZZSWcwT29u?=
 =?utf-8?B?RE5ZcE5OR1hlY2lEVzVuQndoQ2xpK0VSWW5yM1QzRVVxWVEzcVRheGliS1E0?=
 =?utf-8?B?NFNPUjBzbEtBdkZrM1hJZHZudVp3NGplRDNyTXZTeklSRktzRnRXSDhOZnlW?=
 =?utf-8?B?RHVXVVorVDBCenAyb3J5c0VoSkx4QVorMk9rejJRV0p0VDVBSUZOQnZaaDdR?=
 =?utf-8?B?dDZPZ2xkWERCQWxwNjVQbHZaS0Z4VkloZllOUHZSV0JBNEtOc1F5T2VLWEtE?=
 =?utf-8?B?TFM2d1FZUkltVHFoVnJQSTllTDI1Y25TTWRWdUdBU2RxZkxmaEpBVkRTQ0Jm?=
 =?utf-8?B?VFZFNVBDeWtudjBKZndtZTcyVFJYTzNhYnI1MXBsYS9Mb2o2TFIxektJV2xX?=
 =?utf-8?B?dmxpUGdvWnVZOGRiVnZjTHF1bktaN2VvUm02ajJ0dnQxL0hIN1RoVWZ3cDRV?=
 =?utf-8?B?MWZ5V2pCWU8wRnFLVExCbXl6OTVMWjR5K3Q4dXRXU29PTkZsYy90aE4zbU1S?=
 =?utf-8?B?ZTJRN0tLcjUwTTZuZXVUWUF4QkUvSUZnbHVVUHRJcFJpdU90QkZyUDVXSHpV?=
 =?utf-8?B?dmRXWnVrYU44S3FXV2FCMWd1ZVowd2xsM1lkUi9oQ2hwUTFHT3dKbE0wekVo?=
 =?utf-8?B?VmhEbFNERzdjdFZCN1ZvRDRwa3J0ZmtETThlTjBuVGw3ZVBuVjkwL0VWQlZT?=
 =?utf-8?B?RWgrOEUyQ2RsdkNSaU1aaFN4T2ZTalFPbGFJeHNYaDhtYkJEZWhIZWVTaEF6?=
 =?utf-8?B?dURxNHpUQm1xaHMwWWhjUHdXRGYvREhPVkhpaC9YZWpxUDhqWDBjeEFqd2pB?=
 =?utf-8?B?K0ZnYW1jOTQ5ZUhOTG5QaldwOWMrMHdROWh6NHNoVWNETzRiTXBFYmNpQ3RC?=
 =?utf-8?B?VmRyVjZkRDdvZWxiWU8wR25JOFE4ZmxzVjZhSVVtamVTSGxOZ3A3TjM4c1lX?=
 =?utf-8?B?QWVGdGJ6RCtoamMrdVJqOWZvMW96Mk4yMEw3SmJERXVORDRrYnlobjUwbHZO?=
 =?utf-8?B?cGlpci8vWTAyMnRZUlJJRHNJVXRjQlVmd0p6TXVuN3l1RVMrOVVJZTVNY044?=
 =?utf-8?B?Z1A4emdXOFZURnNJY3BCa01LVDUxRXFqWXlPU1lncjJnZDd1QUZLRmZLZlJl?=
 =?utf-8?B?V2x5SjNOYUtiSnMxTGU1SGZVdFlCSFdxQ21KYWpmWEt3MmE3ZEk1R3JFcTd4?=
 =?utf-8?B?V3NMQzdLT3NLY0ZDZWZkMXhhZFRxRDlNVjRZdXpxdjBMZ0VXMzUwb0xmK3NE?=
 =?utf-8?B?elRaTVdpQUdhSGJadUFqOGE0MCtMRnBxdXhNRkNvWlBHRDYySkxnMktBMllz?=
 =?utf-8?B?cnQ4L1ROays5ZWh2dW1FUlptNGR2cEt2R0x5Zk1pTTlZV0k1QW9EOFVycmsr?=
 =?utf-8?B?N0g5cTU0ZFpnQ3B6UElFQzVhVGMxdW1FaWN1VVlOcmgxS01aMU5yeWxESXdL?=
 =?utf-8?B?dGFZbE5aT0k4YjJtMXgxcGpPaTdqUjdDTEpEcmVIQWtoMGRxeWF3cjUyTE15?=
 =?utf-8?B?YkhaS2Z6K0toRWhIcXlwa01OUy9BU29aZzMxUmh2a0hrUUQzMUxyeFZUakFE?=
 =?utf-8?B?dGZZTnF4eXJKZ0NBbTJDZ1FqNWFZa2tDUWJWOE1sOElXYjNlRStySlVHSklz?=
 =?utf-8?B?TEdtY3cxUUgrREJsWW1YcGJPdHlkc01DYWpQZWJZVmdZWmhyTFUyMWtYSEZr?=
 =?utf-8?B?Qzh2ZzlXbGpuMktvdkRCeXZUNm1lcnZlTnozOW5RNmtPQnBkVjBHOHpHZmVj?=
 =?utf-8?B?clFwcXFPVUUwMUlCN1JYeG5NOVFMYktnbmk2SGlWdUYrSGcxZW5NRFoyRHBY?=
 =?utf-8?B?L1VHbFArOVZuWEFqMGZKVXkxNTZkaU50cnhtT3RsWEFSUnB1UTZONXpmMGYv?=
 =?utf-8?B?bUZVSm16UVQ1aC9QZjBwNHlJUnIvYWN5dFUvckRzUEpNNWxSQm81OUs0MWl4?=
 =?utf-8?B?emFDeCtzTS9sdDZKeU0wUGROZVVqSkJqaXB4dGIwNnB3bHZpRko3ZjhBRmVa?=
 =?utf-8?B?TGN4SytzMHBieVlCM2s2UDRQcmxwNlJjQlcyeWttNnBiWHRBY1VsZ0toVW11?=
 =?utf-8?B?aHQ4czZoM1k2RHpUaE11aWRVV2xST3BtVm1sRGFwLzZmWlljalhUQnlkRzEw?=
 =?utf-8?B?VGRpL2loT0xINi9OZkNxQ3YrL1NEMkM1SDR3TXgrV2Fmd0drUlJlQUIxSDVG?=
 =?utf-8?B?Z2VETTVEUEZMOVZwTUhXT0Y0akpvVU03akRuWVJUdTF5MWh0WTZaeWhybTVj?=
 =?utf-8?B?QXJ3NTc3S2ZHVGN4NGFIK0lRTnpTRFVzSUlycFF5VUJsRGJOdjZQdXhCSi9R?=
 =?utf-8?B?djJXR3VkZWgxY2dubjhoRklWaXJjK3JzVEViOGl5aGh1YTlZT1VYSE5VSUVh?=
 =?utf-8?Q?cvoVytMW2MytxJNU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f471f16-3818-4c45-a903-08de6a85a1ee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 22:25:31.4787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzVFMn7/lPU8WWtxkXYmyJLAnBEHiG3ILLtztiCSFj2gQVIuiz/oYZNnB0uiNV4RM5FgGG7UySrTqz+7IhAGl/7VHwkxwcb4JDIN1MgkXv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4590
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16794-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 52E7D131839
X-Rspamd-Action: no action



On 2/12/2026 2:32 AM, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Driver is using num_vhca_ports capability to distinguish between
> multiport master device and multiport slave device. num_vhca_ports is a
> capability the driver sets according to the MAX num_vhca_ports
> capability reported by FW. On the other hand, light SFs doesn't set the
> above capbility.
> 
> This leads to wrong results whenever light SFs is checking whether he is
> a multiport master or slave.
> 
> Therefore, use the MAX capability to distinguish between master and
> slave devices.
> 

So we were previously checking the number of VHCA ports, but since SFs 
set this to 0, they would always be ported as mp_slave, even though they 
should be mp_master.

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

