Return-Path: <linux-rdma+bounces-21433-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CASINyCGGp8kggAu9opvQ
	(envelope-from <linux-rdma+bounces-21433-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:01:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2248E5F6030
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 20:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7402B305B99C
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 17:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752E03FFADF;
	Thu, 28 May 2026 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhAplzi0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE53B6362;
	Thu, 28 May 2026 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991166; cv=fail; b=EoTntHvdPfjXEKYHqbICNdJKIV+dGDC/p0xwH6xLruEi7mpnNQpphTK84kp8aV9GzQXG1mF77OdSYIZbn+tgntmmw+fcidCTg9ryKNXSFSrymtGB/BQurp7rRjwHGSqFzG/XRhoDZLrgLj7T8EGpq3v8GMtGm0m0yBrfsXrdzgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991166; c=relaxed/simple;
	bh=MoE1zT7Txe10TZGUeB+wG913fTBnb9nCP2hLaXfgWc0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pmf27k/GK5BthpNV6ZDbMbUAC5nHXOrIpIrcY8Awhb9rPxOb+r56ILRrY5bK2m4KLnzFOfX53eP2iH8NgiPUqiYtNaQYRZILDz40rmNo18gr2+uOU3G+Z09UwdI9TmobuE/aqp0Mw5jxnu604s1vHDowpgelphpY2d52KnEw00s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhAplzi0; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779991165; x=1811527165;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MoE1zT7Txe10TZGUeB+wG913fTBnb9nCP2hLaXfgWc0=;
  b=lhAplzi081EpThhvl+U+/79LgflNidwlLZstCEIyFNP7kkwNXQZwBpwk
   9wIN/0z7p5LGD4frf+hGkIzx79gJsXlCL6C2Ved2mxX9iyahGA0bGDAaf
   oATldnGkf64xABNgsOrtJlhOMoh1LME9PBn9knVd7zd4QGBI5+SmfJWU5
   TUEz6Xk++dTBnnQKVM2K+JipIvIsGWcypMdfpSIvVeNuEaBGjxwScHaKS
   O4XaS9OV3aQvw8VOUgb/0Cx5AOqkDmEUFw8BjNJzT5rQo9ec6rg0s0hvy
   IxnykBdGrYVJ1/3+IMgKHAOO8+wdrFR+d2gqxWWSChn/ya7W9lyaAUSQa
   w==;
X-CSE-ConnectionGUID: m1aX2a01S1yA44Q5wxIGcA==
X-CSE-MsgGUID: PMYhNl2LQwa6AToMomrH8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="81025313"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="81025313"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 10:59:25 -0700
X-CSE-ConnectionGUID: G0eGaZV4RwKc7VB6a+d8Rg==
X-CSE-MsgGUID: LpB1ZVusRaW5mo5FoN+XLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="266226452"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 10:59:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 10:59:23 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 10:59:23 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 10:59:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=civfrgrIwfhEWuidhZo/TxRrT/IkidSLOaqIH3o8W23qvHe6S/OBrgYQy6pK+v9hGfQAjYj7fTmMENFRhSq0RjMLz660Zkt8RQONReHfOOGE5ICMtCsALFdyDjt520F5ROXsv9MrkM6k/BCCOOXYJUH5Z04OdhgZpLGwLBjVVJJrkB4IzkyhcPCmndYmZnhS+v8jpa9Wd4wKg+hTfIoWipr0FSbd2pKKAAO16+UBRsnGJUBo3/ZLA0GEnjlkRRrrYhPaoV5g18WhTGYiUlncRzRdA2sW/SuVAK1uLBO50F57vEGWp4OlEq6iVuOm9YSjvsws4eKNNDJw6Hz/P0IOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gl3Sj5XX9LNnJqBjx1/C/iwW0fmxFlhvZhNt1pE0zfk=;
 b=YuAtWEvu+54/2JKkts/r4SRIL2dK5NLJMwBnjuqw6NHQZCV9d+AzrKHMm5WwrL0a753QW9LbIL5xBmy4BdGiBsU3h5xbjpxve7GrpgkoYajU9hRRgs5ME9oezp9EqnLe2Tut98p/NN1YekjSQsp7Xb+2aVXoJPcXTdE3kSShcY1iWWki9AewUlEzO5Eq3apPQgzHNFeGN0aB4ADbh77+pmje0SGvUilkFVDZhJ2wnQ5Auq8ksfwhB6wzn/A+y5xYy49vwjXVcwUqqTlTrDZk/lQ2tls3v8450RaNglm0bartG4TMKeftAxTNw1uoPB5ViJXkFkx660BxTgakrP+ueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DS0PR11MB7959.namprd11.prod.outlook.com (2603:10b6:8:fd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Thu, 28 May 2026 17:59:18 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 17:59:18 +0000
Message-ID: <26ce1686-199c-4c60-825c-912a790dc0c6@intel.com>
Date: Thu, 28 May 2026 10:59:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/13] net/mlx5: Add switchdev mode support for
 Socket Direct single netdev, part 1/2
To: Shay Drori <shayd@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
 <0a432449-2409-4e55-b17d-9d2fe1cc4860@intel.com>
 <a2187226-2385-4aa1-9921-4e10e82400f0@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <a2187226-2385-4aa1-9921-4e10e82400f0@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:303:b7::8) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DS0PR11MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b9ec35-9861-44f5-dc49-08debce2d64c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|6133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: hIv1tc7pyX9xdcsV0ZEi+UxsppP+v5Tz7G0CWfNkrdfOiccm84Qb6aZ6u/QyCUAnTsBP3l18ByAR5KL3D0A6sVShPyk8xYLQ8JKHiXwccQf8l24EiUOVquw8JM5u1texuO6bFA5C/pW/WpYf6hV03PjVSc1VaFy+szNhzilrO3ACuM0JAAwTTjhSWpQS/kUpadkxR49G6SjL+4nkMS31PFLXGSj2Rb+JNWQqVSL8xq1rDQirhvgxi0Wi9EYHLx01jQHwB8PxXsmwHyPCTKT7dGNqbp0M2oWPqICX1/NFHF3ACRPme7PE0xEagQtOvsG8JfHhvrjuZ7Xulz3UT39iPSFfQWauEWax+jHWZX4FD7PO8N+obCKv0Yi8FCdic6c6y9KX+MvSdylwn1ipbBot7LhsvFa8SMp7pe5zGLKhDylBi9cTl4ywtLEjYTMMNOUuaNcyF4ZSIF2xsTgxhTC5jYlMsB9NR7UGTIwWiMYYmebk1nokUYwe2xV3J26ZfIz249wwDSqdcvEkGh2Qxx0zdSk2uopV6tut2Io2vO3z22IFN60MkXVkRwtHw7dYlUa7XvkG0KKxJkPsZnp0FL9nXOspfxy/6vfBKplPK3kgKSB+uILy28FriwOmm7a/MZP/SlFZSLcyY9wrOfm4OxmJ6DxAf1cGytI0BRG1iSVoKhZr/QP64L0kDHdo3U5o4jvU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjV4MENETW55MEZoRUcrS2lkQmgvMitLdUJ4SW5waC9vWmFzR2ZNZEp1dEVR?=
 =?utf-8?B?WlR2TXZYZGg1L1BnNXBjbHpXYzdZUCttZHlFd3pTK2lMb2tsS2V4aHkxb05D?=
 =?utf-8?B?U0U2Q3dESmx1YjU5Uk1XRkwvRXVCbVE3YnFxa1lmY2VmVlN3b2VqQkpaeEZq?=
 =?utf-8?B?TzNsNkZHTGMrU2xWQXN0ZXcxNTU2SFRuNndvcVd6Q3RsUXhtZ080QWtqaTNG?=
 =?utf-8?B?bHVkUXoxN0szSjF1UFRsYlBpWlBjOXo2c1VnSzAzU1RNNndkTVJwSW1MTWtR?=
 =?utf-8?B?RjU4cDE4UmxyWTd4eng5MFVVamF2TEt0S1ZCOTB2TFlubkxSSlZLVS9rN05O?=
 =?utf-8?B?OTBzQU9YVFJQUDZ3WXJSV1RnZ3ViYzBtWWxFV2tCdkhhdzZJYWpVbDlOS2c1?=
 =?utf-8?B?OTIrMWxDbHhzbXBpQkg0MGF5aGVEY0Q1R3dicTZiQmJ5U3VLRDNxUmFEMXNY?=
 =?utf-8?B?amNuVnAxREU4N25YS0JGYmY4M3JFTjdmT1RpR2VjNTRMNFpjZE05bk5uYnBY?=
 =?utf-8?B?cHE4YWJZN3krNWpEaEJxS05IRlVjUS8rdmZ0N1lJK01xa3gzV0dhNUJBb0dv?=
 =?utf-8?B?N3dRTXdXbkZtalRLWnVBVWJrL2ZkTEJ4NjJnY0hFRitDZlhmMjQzY0xtclJx?=
 =?utf-8?B?TGZTMnc1TUoxZE1rV3JBSHIyWmNoSEdBTmVmY2Z4TWlTS3FBS21mc2VlSE5J?=
 =?utf-8?B?S0RzQ1pGL2tHRnhXWHJTUGNIdVpwODQxL0w1ekljN0ZvNGR5aUpFYVFoNERh?=
 =?utf-8?B?SHhFUDJKTEQzT1doNkdZTk5ZWXRkak16QWRieDVrd2RlN0tJVnRndm1Ob3NC?=
 =?utf-8?B?Z2tYZ0QvT3ZTV3gwTGk1Q0JxRzVuUTc3M3hMY1hRZWluUWdyY1NmTEdWQkRY?=
 =?utf-8?B?ZVZyRHpFV0ZEY3pHL1BWRTBTRDBhT1gxSlV3VUUzeEQzbmpxWTlyazZIcUl3?=
 =?utf-8?B?ZEJIaXN0Tjc2aWMrQkVUaWV6cVBqN0V1NlJzRXBYdjFuOGJqbG9zTlR0VThV?=
 =?utf-8?B?R2cxSThjZ0wwL1pwTVNYak9adjlLdWFGMlhxUStUQzRrODVvRG1yQ2xLejVk?=
 =?utf-8?B?bUlHRFlPalB1V0xLSm5uQ1RoZkprbXhPSlNPckExR0lhLzdGWUFsQ29qQVdr?=
 =?utf-8?B?aEpwRzB3R0tFK1VqcCs0WUZacWtWMGdIM2NoOEhtSk96MVVRVnlyclNoOHQr?=
 =?utf-8?B?UFVMVWpUZnZqWVUxTkQ1TVlXMXBNSEVtOFJKUU0xVW1pN2JSM0pDOE5hZzNV?=
 =?utf-8?B?WjdZMFZzNmoxQkpxMFhVUjhPVXE1bkx4Q0VmamQ4L2JTaHpiYm5CSHhqSm1i?=
 =?utf-8?B?a1FvbkhiNzR3a2lKQTZKS0toRUdJRmZLQlBUSCtid3gvVUxIcHh3WHkrZkE0?=
 =?utf-8?B?WVRpZlZwell0Mm43N3BmemVWUkRjK2RJRlBZeTFUd1dDZFErOU0zOFJNands?=
 =?utf-8?B?UFd1MFFLc0hRV2FYbEtMRHVnRndEUUVYRVhKRzZ0bU9YZitYZlJOQm5VL0Nr?=
 =?utf-8?B?Wnp1WGdIWGVQYVBaYzJCcTkweFo5Qlh6bFBRRHVDSG5mOEFTNzluTFdZTzdm?=
 =?utf-8?B?a1BsbDZQemdpdjZ1VTk1bTFuSm5YS21xYXFKTk9wcHdRejBib1U2Y3VlbGdH?=
 =?utf-8?B?NWo0VlNpZHhFYzBjN1JISmxoTUZhWkJJQ2RISkE1QnByTkQ0QkhKSmZPa0Zj?=
 =?utf-8?B?MnlkamRWcnViWkdKWGdpMlJxVzVQUlZjeFVYNytUMVNMQk13aGxKUVZ5M2g5?=
 =?utf-8?B?ODdUSDBZd2JKYnV0WG1qa29RNUtFWFhGdFU2Sjl6NlZwK1Q2TW42M1VLRnBK?=
 =?utf-8?B?cjBxU0tObTVjMFExQ0Q5WnUzeGJjUFhwRHdwcExUK2hKam94UU1hM3NTSUFS?=
 =?utf-8?B?a1IrS0I1TSszang3OWFTeTlqMnI0d1lQY29VZXJjT0drZjZyOWkyOEJyUXE0?=
 =?utf-8?B?U21IZCtYYnJLZ3ZBdTd0cTlDN2toTlZXV3N4bWRKUVdkTDZiRTV5WUowOVAw?=
 =?utf-8?B?TVRTandWQWwrVkVtaUFTeVp6MVFKTTZORmxsdjU5SmxuVVJ5U3J5OHhBeWcx?=
 =?utf-8?B?V3hkckFUcldzdDhmTTJFQnV0S0dGL3JwS2ROYkNlRkI5N1NQc3FMVUpuN2R6?=
 =?utf-8?B?WFlZRi9iRHExdm14aW1UWlAvSytGYkZHQityaXJMWEtjMDBUaDBFSWdCMTNp?=
 =?utf-8?B?eXRTdWp0S3BjOUtNMG8rQlF0RUJEQjZxUmdXbDcybzBHbW92VExSUjZmeW9X?=
 =?utf-8?B?Q2lXdnFxVFpvZVg4d25qSkwzTERNdWh0b3VqamtUTWQ1RHZXeVc5ckJBaHhz?=
 =?utf-8?B?WGZpVS9GWWZxMk1jUldiczg1VUwwT3NYWU5YU1N1bnZiaTR0Rk1vZz09?=
X-Exchange-RoutingPolicyChecked: jeV1xoyf9owNUuPm1hAJMsM8uoPz5PoPF7acOjQkM732b4akDfRSqU4wQ+Ne/jREhc6B6xMc47NkEDHCuBAaIPCD+50OkWTzge4kNkiaoSSabPF883PEbyobxODAYbKJwHiitGsRPb7Jkg9jdSG/XNub7ael92sh2ohhPEs5KPIHOe+dOl0CF6TDFtSW9bugFVcAKCBjPJfiMLRINxkFQPjCgv0IuJqvBFaRCHARtpI519WaTOH1PkxYzk+db0kG/nkck+27muWnzyfif8v4AkK6Sw4OMMJthsa7P0Pm37hHG20fGINeLiGTJsSSydJ9R/w54d7zxWJD9vc42XDcww==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b9ec35-9861-44f5-dc49-08debce2d64c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 17:59:17.9799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNMZa89odE28tdAz0ZyVcqD8jgYb05g5m0ihno5DgrjY6zTEobQ+/e8zwn7P1HVgTM/3GsLNZ6319L03hkg9Btcr5uJr+caOw5n21rwyjJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7959
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21433-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2248E5F6030
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/2026 2:18 AM, Shay Drori wrote:
> 
> 
> On 28/05/2026 1:08, Jacob Keller wrote:
>> On 5/27/2026 5:54 AM, Tariq Toukan wrote:
>>
>> The patch 13 being the "enablement" is a bit confusing to me since I had
>> trouble understanding how the patch description is "enabling" the socket
>> direct stuff..  But the description does say "part 1/2" so I am guessing
>> thats addressed in part 2?
> 
> Thanks for the review
> 
> the word "enablement" here in the cover letter is a bit confusing... :(
> This commit prepare RQT layer for SD-over-DPU, which will also be enable
> by the series.
> in SD-over-DPU configuration, a device's vhca_id ends up failing the old
> range-based check.
> 

That makes sense, and clarifies the misunderstanding for me. Thanks!


