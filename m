Return-Path: <linux-rdma+bounces-13297-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17410B53CB8
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 21:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16941648E7
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 19:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C07262808;
	Thu, 11 Sep 2025 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqbEJ79U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B254523D28C;
	Thu, 11 Sep 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620285; cv=fail; b=Q9ym5BmjG7gbSxZy2G5yWKj/nCyGYXJBBidf251f668vqSRCZdEkFPutwL/Ll6rg3Vm2S4QiZxwEZXUQPa2/jdR9gN5UoFxSdr/8vbYzqB+Z5pvjwsHxyCu/mKaK0d7BEc8tbuqlZZL7xBMkMOhs/5Q36zrTfQ5Impks1yfyVqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620285; c=relaxed/simple;
	bh=46Q5MxuhMreCINodYRO3FiuQ7LG7HGhcfcWTUps2AYs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XkB754n2zaHBWNp2btUul8W8y2fBIl98ZWOMkuAomf2ez4cOZGcHNkBsD5mLfpUlpXinNG4jN/qHxqOSQDc1lK/vXV6243Luz3RMfAefHn4rORFGydeC3lL298QsZh9E9s4FQ9+jR0qsE/hMtllkmcbzkytkVhMdrrBi/NkNK2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqbEJ79U; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757620283; x=1789156283;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=46Q5MxuhMreCINodYRO3FiuQ7LG7HGhcfcWTUps2AYs=;
  b=lqbEJ79U5FKM0m55C2OJO/ffayLANbQsovR89YEVsW90q4T++5r5QyXY
   VdDTqA6aGy9tHOcAkM8UREsyvGWXLxdchFF0rpqb6++kQGZU09AkMGAqd
   EovBRToDKc+G+hqDrecpfZnumGXKf1A6ZG0l2RiA3kMurbRO0UIfIvGG4
   0WaquxlNU1dFc3VdFqLj8dmJVbllYN7lrx/asbZa3UOo/hk4CnaeKBhmj
   FuVuCA8fjPNKGLt02r+lyWg8VtoGrgnmEKZXeRx5FpEM1LbBBmpJwA/QP
   nF1L9cuhHuEMfrG+2RB+n5+E3R6agWRdKa8idBsek6iOnePi5zev1Bd9u
   A==;
X-CSE-ConnectionGUID: 3hg76Lh2RBeo07w3FJJ/ig==
X-CSE-MsgGUID: u1l1D1N7Qha54ESaiNG5Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="60037756"
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="60037756"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 12:51:23 -0700
X-CSE-ConnectionGUID: SGJw9YjISXKcU8cyu4LAdQ==
X-CSE-MsgGUID: lB2jSijQTpKaOKPXVDOOTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="210933649"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 12:51:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 12:51:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 12:51:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.73)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 12:51:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U22sQLJtI+tcuJedG87cQ/Ln59wJ+opGEjZThvzSKRPkeVTYF1i/GVJj8KF70GtXQfV96dzCBzrVu7jp3S2IE/8zy4gc6X2OgRUjjXh27nhcRZW5JDh7MXMWnMO2qS6+CzmGAzswhg/vxGLpVTJe2EOg/oRBSKVTXlb3l6x0DqnJvH6rLcFozqR31o1iy/9fg7oIuIHI2JDptLO5sJoKRM/7qDWB4eLc5Tn01V18rIBpNm4uF4wvJwu9DnsuPF93DkABUpzEdvsnK2So5gjd9x++hZR4U4QWG/bu+8BGEnJfD87IqRkQ3C7wKttD1OKXWWxyZSsJkKj8Ru79EGKjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXIovW/MJTpNsJYVjrd2I0qW9CBncwrxQoZUAYM1uLs=;
 b=iDglx5I9teVsoabOO3XFWhp2iV8yycaUQ+OjHtSE83k0R9jS8ktfneS+rDqI4Ifo6l2NGvWtTxp5+9U8ao0/TMtyDROOy3b9z4jvAZ3aH0tN317PjU7oBN2B9Ep6eqXqh8zIa40KL1SSxv7ClEPSnNK4JYSMKWOjbDNvkVsNwCPn3pA2dJ46mLG2WGDTQgXK1pFS86zEaE7Kb4d0SXJ6Jed8yDpHSL+9P7igblxIB2XrNVPuljKmds6WQgz+3xMZ766LIpwSEIO4z4fkeNgnzqAKxG8CyCdJlIaSnQN7Q4Kwph9xFQ/5cEJNbuDNzysBEGkump/nUvP/Y0Xlgs+JmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH3PPF9E162731D.namprd11.prod.outlook.com (2603:10b6:518:1::d3c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 19:51:19 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 19:51:12 +0000
Message-ID: <4513322a-28a8-4990-a7c6-f2a0d5675720@intel.com>
Date: Thu, 11 Sep 2025 21:51:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next] ice, irdma: Add rdma_qp_limits_sel devlink parameter
 for irdma
To: Leon Romanovsky <leon@kernel.org>, Tatyana Nikolova
	<tatyana.e.nikolova@intel.com>
CC: <jiri@resnulli.us>, <intel-wired-lan@lists.osuosl.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>, Mohammad Heib
	<mheib@redhat.com>
References: <20250904195719.371-1-tatyana.e.nikolova@intel.com>
 <20250909122051.GF341237@unreal>
 <33d327a0-72d3-4775-8842-6c4ceaff41e2@intel.com>
 <20250910121317.GQ341237@unreal>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250910121317.GQ341237@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0281.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::9) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH3PPF9E162731D:EE_
X-MS-Office365-Filtering-Correlation-Id: 35042abc-eb66-4726-23ed-08ddf16c8fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEVXZWplblNkUm5aaFlEZDNicS9FQXZtRlZhWjU3MWs3ek1BVXcrUGQxMDlS?=
 =?utf-8?B?ZEFsRVNwL2xOV3JvZC9Mbkh5Mm0wV01mbm9lQ2JSUVdRSlZGS3kwUElhMUFZ?=
 =?utf-8?B?MG5FUW43WmN2RTRWUlF1bzUrdjZvN1pQc2NVSnd0NHg0blBGcklqR2xBb1NY?=
 =?utf-8?B?UE5PalJFMHJRV09TczNXME1nemN1UG9Ga1o0UnFYckVzbThKZGhXd0dWNlhQ?=
 =?utf-8?B?OW9iUmpqQWtVajdZQzBsSmdrTHNTWUZPelQxSWNlNlpzczN4WXlna3gzUzl1?=
 =?utf-8?B?aEJOaGVBSFdCS1J2NHhJcUtuVlNBZ3EvNW1yT2dkbDJCazFFT0hGdHNFeXNW?=
 =?utf-8?B?dFYwcDRiWGl5YzJNUHlkTnpSS0ZmOTRIRmdETnFjNzJsRW5tdldxRWxOY3k0?=
 =?utf-8?B?QnZNcHlxK3lSeEdad25TM2xmalRjZzVpUHFjL1ltU2UxUVdiMSsybUdlWGox?=
 =?utf-8?B?RlFJZkQ5bEFEcC90MmxBTGRMei9rRUVCbzRUVVRLUEF4WmxBeGFxWFozdlAy?=
 =?utf-8?B?TVg3NmU1WWNOVm1CeU9WdnV1SVpDUTdndWVWRlpFNGdqcGxaWFZBK0h1SmpC?=
 =?utf-8?B?MTNVR2dIM0pKVWd0a1BKODVlZVhxdE9GaVY3cWRDZWsySmI5ejV3V1YyYlg0?=
 =?utf-8?B?enVaaFNNY2syNy9IZjNBaTNDaDhDaGZNVTZPYUhncWkxR2tsM2FnL3FkRzQx?=
 =?utf-8?B?VThtOHI3dEFuNk5qRW5UMDc4ay9rdWFNd0IzOE0rbkh2Y1pyUWhoREhBL0d2?=
 =?utf-8?B?WE5NMVhHNCttVGw0WkZhdGU5bVIvdlA2Sk9ybjFyeVZDZkd4R2JtWi9WblB1?=
 =?utf-8?B?UHVsWE1uYnZSRzRGU00rSDVYNW1pSnRvYmFLOFVROGJjdFBWNS9lNlE2SE53?=
 =?utf-8?B?OGxBQnNpNEF0MnpVR0JlamJjTTg1VVVtT3RFVnA2Uy9tMlhvOFc5VG94REdR?=
 =?utf-8?B?SGkvc1l1cjNqcXZsOW9rUEV0MW4xUThZdUl5ekNsN3IvRDR5c2pxTXcxMjJT?=
 =?utf-8?B?Q2NZQlBkcUJiMG1qcmdpdHM3NmlqVU9vcWQvbndXaldxWDgyK3lOQk8rTW9s?=
 =?utf-8?B?bGpobmRUUTdtMHhacmsxWm1KOEdybGVrbURBZE9GdDh6bVZwM3FFaXBZRWwz?=
 =?utf-8?B?dGpMNmNmSXR4aU5uSDhMM085aERXZUMxcFp0Y2djeTI3T0hRemZIdVRlVnhF?=
 =?utf-8?B?d1hqNUFPeGtFRFFDclMxK3VNVlVnMTN0R1I1bWhUTDBOT0FnbXRRZlZnbEY1?=
 =?utf-8?B?SzByWUdvLzJNL0ZLcGxlZ1d2MzR1VlhJYWdXM2lFcGd6Vm1wNzdaYk11RUJO?=
 =?utf-8?B?eVhaNU5POGs4NUpQNE5HbDQ2QmU2cGF0a01odkluSlE1SmlqcXluTzhNRTJT?=
 =?utf-8?B?eFBTdHRVdi90VjVKaVVYNzRIeW9mRFFUNFpxMDJETjVjVGVIK1hRbER2TStI?=
 =?utf-8?B?Umk0d1hsckx2WWdicEF1UFNuLzNyM3FMNkhJMDQvL2xFam1GL0FWMVJ3Mksw?=
 =?utf-8?B?cWpsRXZmekRldjg5QWxXYXdEZUFKcFpoOHZxSkNWbVZybUx2dGtxYlZqWTJ5?=
 =?utf-8?B?MmU3c2tycXROQTdqUUJLenNGNUFzcmJ5bVVSVGNIeStWQlNaL2VGeER5KzlP?=
 =?utf-8?B?anVBMGt5Vi9kd0dvT3FYZ1BUWTJxNWRsSXJIV29hcS9KdHc5MGJ1TEp5RW13?=
 =?utf-8?B?MnJGOHY1dnlNOS81bTZXQ2lqU2oyQW5jOThrSzlOTWpGZVBhalpJZE4xaUNu?=
 =?utf-8?B?dzBpdW9sWld6QVY1QmdKaXljaFZCK2RhUjFUZnpOUHJ3SVUzYlVCZE1MNUpT?=
 =?utf-8?B?Nko0amdmV1VYZGlZN0Y5SHFiRmRjcURqOEFpUk9heDVlcHBIbisvUWNybnow?=
 =?utf-8?Q?9EFt5xquCcmCH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDM3K3Nvc0s4dzl5L0tyT2xEMGlNYWNoek9GSHNBc3R2ZE5FbUh5WTlFc24w?=
 =?utf-8?B?TVo5L3lpeGNNTnp2NFNhMll3VzdadlNmdUZhQlQ0R0xKNDBrUVJVTS80d251?=
 =?utf-8?B?b2E2cERheWw3YTRWZzFpb3BrTzRwSy9CdS9USGVMK3gxMS9TZUdZYm02ZGwz?=
 =?utf-8?B?UXIydmJ6M3pNc2l3UzhxbjJCNlZHbExldkxnMFNHM2t4QkhrcSsvUDlFbjUz?=
 =?utf-8?B?ZFNBQktFTjFwVWc5YjVQdlI3cldsaURtQ3BNOEd5alJYaUc2dmFVM1lkWmhX?=
 =?utf-8?B?ZXozdVpuRW9lZFBrSUJlN00yNmxkV3QrQ3hOb0d0VkVvWGFEVzdrNWdpbWtI?=
 =?utf-8?B?K21HbW1JazVkUDZ0Ti9rL2tPYkJiT3hGOFUxR014cUxYUU82dnhlTU9PbWFV?=
 =?utf-8?B?SzRZcFNXNTlBQjZVVmVWc1c0MVFYUWRVeEtRU3AyOXhCbnJxeGp0NXNpOVNM?=
 =?utf-8?B?dk5Nanh2d1JpUjZrbDN2aW51OG0yV0JuS2ZZZEJrOGQ0TjJJbTkyMHRmWFpo?=
 =?utf-8?B?d211bldjbTVJNGh3R01abWFCSkVMMFRtTG5pK0E4TUtwMGRqY29pRXBOdGN2?=
 =?utf-8?B?OXdyd2ZEa1NsaU9kRWxkSERCdTNxQ0FGc2NTdG0vcXc0NzNPak5CL1lGdjBK?=
 =?utf-8?B?NWp2aGVocGR0YmtCQXhkTW55UmcxUWo2cnhlMFF6MUZsOVN4aDFJZlB4ZFJ6?=
 =?utf-8?B?MGJKRFdVT1k2SlNRb21iMjJnL0ZWclNROFB6eDdXVHdBVzZlaFZ5dTJNN0Q5?=
 =?utf-8?B?bzNQQkw0S1BFdUNWVGNOY01PUVlnekZLTklrTlNqNjRvZVlBWUFpY052Zk4r?=
 =?utf-8?B?SmxndVhBaFF4NVNtRkovd0NGaXdvZWkvV1ZwaGRnL1JUMklMcnVGMDNPdkhR?=
 =?utf-8?B?YUsvTDZOaFE1VjJBeEZDYmFYUWFMYUowK0VaUi82ZlFQNys5RnZkUkVOK0c0?=
 =?utf-8?B?OXVxMDZ5MXNzYmdKUU16S0t3TmNQdTJLRUFETDNjT3pTNXBDR3RTZGFGM0RF?=
 =?utf-8?B?QnN0TnFEc3VrTlA2WERDSlU4VWlDWU80d2FwSkt2MklDR0JtNGtDa1RkVmVt?=
 =?utf-8?B?VWtSd0xScEhqMjZrUjhGYVVDcFU3YnprOGg4QVpNMEhzTjNTdUNHRHNLQ3ZN?=
 =?utf-8?B?V1NuNEQ3SFJKeXF4M21leExxa2pJMnVRRVRpOWxkdHlYdzJibG5YSXk3Sm5V?=
 =?utf-8?B?VzV4ZnkwNk8vaFEwWnl1d0FaL2RvTy96RWlmS3ZiNEJFTWI2cTlWYk92d2Vx?=
 =?utf-8?B?ZFBocGljQUNEWDZTQnE5MmFZNUJPVDhRNlQzUTIxTGJRcklrZWYzUlF0RENL?=
 =?utf-8?B?bEMzRlFBK25zQVNpcCtWU1dKdStMRHYxZUdnODNhUUhhVkUrM21pT21palZr?=
 =?utf-8?B?Qnd5cHk4bkdFcXNsR0pPRXZoRXArMTJFeEp0b3JaNWdQOWlOeTZDeFYyWVJY?=
 =?utf-8?B?Zk96aWNrcWkvdTVoNDhpMndXYlF3NEM3WjNwcUw2d3lJeGZHZnA2bzcvckgr?=
 =?utf-8?B?eUMyZk8yVjBtSU5jRGhOVGw1akVqUlMzL1lXM0FCZXVBMkJZbFdIK0UxL0p5?=
 =?utf-8?B?YTVPa2ZOUjNVTFNSalQwUmoraWFrMmNOcENwS2dXS20vRlpFUG5QSzFJMjNF?=
 =?utf-8?B?blNVSDRBYkpKemJzcWYrQUZkNkp0MVh5OXpGblZPaEZXN2pJQm54cjArTk1J?=
 =?utf-8?B?M0ZKL1ZiYWhYSFhjelJSOFZ2elZLYURadE81NFY5RGpvUjZLZXgyVkxHdjZK?=
 =?utf-8?B?dDBDWldQUEw2aFMwRk01OVpnWmRML20rbEdPenRzWGhPK3hVV2dIWWtxaEdl?=
 =?utf-8?B?cUthN2tnejlkYzVieGhWNG9aTlgzcGtOMWpmanZCRmFFNEtJcGI4TlBRZEUw?=
 =?utf-8?B?MGEybE9nVHBNdmNkTTVPRENzSDFJOHlFeTdOSENJYXpRQUhmbUxsek1sQUVv?=
 =?utf-8?B?bnBGZXFzelYvdlNEL0RoakdGQ1JsdHh2U0FwbDNoNlFRd2hKM00yQ25sUytx?=
 =?utf-8?B?dTNEcFNBK3B5LzBneS9acWdpZWtISE1IZTNxYUMrcFE1UXpvb0JyVUxIaTNm?=
 =?utf-8?B?Tm9NRlJKZExjbjhnQ3RlOEluTFpXUi9NRXBjd1UwOHBOZFEwcnlNSDQ2SWtx?=
 =?utf-8?B?THZ3eGovZkU4RXBMWHVubW43bG9ZcDRCTWVnelBNQ3VCQnRkNTZIR3p2Y0FF?=
 =?utf-8?Q?b6vLr/0plV7juzGLcMLgA1I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35042abc-eb66-4726-23ed-08ddf16c8fb9
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 19:51:12.7782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeJ6PdzbWn8C8Iq2xiH1RzxzAZRmUnPB/fTTR4FUz744whMD5rAF0yKY96w9o1Z1NrOFX31IymORhMhecruJJnqmqVKf68ICVYUA5uxIssI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9E162731D
X-OriginatorOrg: intel.com

On 9/10/25 14:13, Leon Romanovsky wrote:
> On Wed, Sep 10, 2025 at 09:41:14AM +0200, Przemek Kitszel wrote:
>> On 9/9/25 14:20, Leon Romanovsky wrote:
>>> On Thu, Sep 04, 2025 at 02:57:19PM -0500, Tatyana Nikolova wrote:
>>>> Add a devlink parameter to switch between different QP resource profiles
>>>> (max number of QPs) supported by irdma for Intel Ethernet 800 devices. The
>>>> rdma_qp_limits_sel is translated into an index in the rsrc_limits_table to
>>>> select a power of two number between 1 and 256 for max supported QPs (1K-256K).
>>>> To reduce the irdma memory footprint, set the rdma_qp_limits_sel default value
>>>> to 1 (max 1K QPs).
>>>>
>>>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
>>>> ---
>>>> Since the changes to irdma are minor, this is targeted to iwl-next/net-next.
>>>
>>> <...>
>>>
>>>>    #define DEVLINK_LOCAL_FWD_DISABLED_STR "disabled"
>>>>    #define DEVLINK_LOCAL_FWD_ENABLED_STR "enabled"
>>>>    #define DEVLINK_LOCAL_FWD_PRIORITIZED_STR "prioritized"
>>>> @@ -1621,6 +1723,7 @@ enum ice_param_id {
>>>>    	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
>>>>    	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
>>>>    	ICE_DEVLINK_PARAM_ID_LOCAL_FWD,
>>>> +	ICE_DEVLINK_PARAM_ID_RDMA_QP_LIMITS_SEL,
>>>>    };
>>>
>>> I was under impression that driver-specific devlink knobs are not
>>> allowed. Was this limitation changed for Intel?
>>
>> I'm not aware of such limitation.
> 
> It is possible that my impression was wrong.
> 
>> It's always better to have generic params, but some knobs are not likely
>> to be reused; anyway it would be easy to convert into generic.
> 
> Unlikely, you will need to keep old parameter and new at the same time
> for backward compatibility reasons.

you are right in numeric sense, but the command will be the same
(so we will end up with one wrapper func/redirection),

or perhaps we could go crazy and say that we have stable uAPI
(on "string name level") instead of stable uABI (given number mapped
into ice-set-rdma-qp-limits) :)

> 
>>
>> To have this particular param more generic-ready, we have converted from
>> our internal format (values were 0...7, mapped into some powers of two)
>> to what one could imagine other drivers would like to add at some point
>> (perhaps multiplying the user-provided value by 1K is unnecessarily
>> complicating adoption for small NICs, IDK?).
>>
>> Do you believe this should be switched to generic now (instead of when
>> there is a future user)?
>> What about a name (this should be kept forever)?
> 
> mlx5 has .log_max_qp in mlx5_profile which looks similar to what you are
> proposing here, so RDMA_QP_LIMITS sounds fine to me.

thanks!
"SEL" part in our current proposal somewhat implies that we have a whole
bunch of limits that this particular number imposes/causes
for just QP, I would even say "rdma_qp_limit"

> 
>>
>> side note:
>> We are also going to add yet another param, now used only by intel, but
>> we do so as a generic one: "max number of MAC addrs for VF in i40e", see
>> https://lore.kernel.org/intel-wired-lan/20250907100454.193420-1-mheib@redhat.com/T/#t
>>
>>
>>>
>>> Thanks
>>


