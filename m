Return-Path: <linux-rdma+bounces-23238-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qV3aOHnUVmrPBgEAu9opvQ
	(envelope-from <linux-rdma+bounces-23238-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 02:29:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 721CF759B5B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 02:29:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=hc+w2sIF;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23238-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23238-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D857D302A7E8
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 00:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5567246BD5;
	Wed, 15 Jul 2026 00:29:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827D82222D0;
	Wed, 15 Jul 2026 00:29:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075381; cv=fail; b=Dy6g+HuA2oOqhxBGoAeb0SwuaBjObtzj0yseQge/a53RPbO1BodBQk0I2CirLFStEkiO0hHPwNupK+UNg9weFih+OmOfXbg1isQtk/fFw7hC265kyoVabbul7drFILQ6tWu3AfunKYHwoZz0WkGc280dCO4ByeN54PNetDoP00I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075381; c=relaxed/simple;
	bh=EldilIMOE8t6xAzLvjOGKLsMP3++Brf0k0y2+OhSdJk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=juVPfK6AzLxwMHZdWh9WQAI6zjVuHIzXhXSIQeahq51xSIq/2G8gO+gbtqr2F2/F3X0kIGvdCZcBNFb/2vA170/NMwozM3x5vWis6MUEM46cAk7yfHWhdQzS2WO0xhYtDXv73rUeGsIosJ9XRz0TW3yIhRPRRu+ds2dQeLaQ1rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hc+w2sIF; arc=fail smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784075376; x=1815611376;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EldilIMOE8t6xAzLvjOGKLsMP3++Brf0k0y2+OhSdJk=;
  b=hc+w2sIFEPNHRklEZvNdBTbYUgiu6/Ue+72SrTKNODfQgx77zCf8rXxQ
   0TyMqCsssmthA6uZcDtiaDy8yQnl0Hixoyo8VXO8I66rdxPfWkGyKSnUU
   NOItZ8Tt7XNCJtSB82az74Y4jEg+yl7qEH3oTfApCTbu9jAqd5Muw7bQ7
   blcL/zl7m+rPHQATUfHKF80ZgnR4MPy+C3GlI6B2bLXZVy89gfp8Ww90C
   urrLtWzEFq+UyQkFWL1E5pBiS4KrX3KwSlnOyBmNUTmHtOeyyiWyLMNXC
   CKWT+v50UN0RyguVbeNhupqOwZWkIEV4/rKgedZaH5HWdvBs6uyaaALAP
   Q==;
X-CSE-ConnectionGUID: up0xWzd/R76xbVptl6PRXw==
X-CSE-MsgGUID: Cty/WxIDTOC3pOaV6aw7Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95306612"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="95306612"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:29:35 -0700
X-CSE-ConnectionGUID: eFnEqdI9TMuyMUSXrsoL+w==
X-CSE-MsgGUID: zwKqVZEET6WR2pcIKzeo9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="259585016"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:29:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 17:29:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 17:29:34 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 17:29:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVteYtUAvLMliL1igQ+BUOV2nJVQXHixP0LmVoymO/ejM0cqqDbuHhJH9/gjkeqtOCAP7A//vao6rwekOQNK7z/2lB78k2zkzYvKOX87MHRbMcxd+NY6kpItEbVPjbGimk6oL4s2lUR1YNH1tTTmp7qpkbhPEBwkeU5yzdEA45TqKIlC8+K75SCqVuetiTsL4ArQ74Wfo2XcCFfpYUqtV4YKQPRy4LuWMrAIMNSuRandaBNdbNX0RJIyLPXu1nrn+Sf5CB7KuhwOsh4bhD73lt0tvber9PGN4nEK0ahZSp5q5obMi6bDgMeCGQiNIoCWlXYBWnq7efW2bm9xpU7UcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNrP9c2/w+oH5/a/OCBztQOkEXcKhiyqokeRAB3Ctgk=;
 b=IuXD/Q+UwpukCI2UUzRY/53d3/kHIzkiP8rOtB3Jfnbl8TDFiKBPEjJSbTyOFSOgYdP0FkrkLGKhmsON3WMAb5qyicdc3/3pS3OyYVDxoc1NhnbFBqAmEYLSW4ltyP6g3RIztlsC0bB98FDnhCQyxqFXhFDpP7c8sLNthV7O5wLX4vAJYPEKqUufMXL/1VPogHfLFhkeKPgrBOELYPM5Rflc3Wmty1KRzCVNZWezHo/Pgi1boaSfaTw3rvvGDJ79zNbfRxBZb+j5AYCwZi8HfakRHtgBivpxehStFOQd/NA5phUCeHXu0wG25m3r5HOjCn2L+IVpykx3rSTg9NZk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ2PR11MB7504.namprd11.prod.outlook.com (2603:10b6:a03:4c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Wed, 15 Jul
 2026 00:29:23 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 00:29:22 +0000
Message-ID: <0635b996-9bfc-4786-9453-7b09a66b3dfb@intel.com>
Date: Tue, 14 Jul 2026 17:29:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mlx5-next 0/2] mlx5-next updates 2026-07-13
To: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>
CC: Alexei Lazar <alazar@nvidia.com>, Alex Vesker <valex@nvidia.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Cosmin Ratiu <cratiu@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Dragos Tatulea <dtatulea@nvidia.com>, "Eric
 Dumazet" <edumazet@google.com>, Feng Liu <feliu@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>, Kees Cook <kees@kernel.org>,
	<linux-kernel@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Parav Pandit
	<parav@nvidia.com>, Shay Drory <shayd@nvidia.com>, Simon Horman
	<horms@kernel.org>, Yevgeny Kliteynik <kliteyn@nvidia.com>
References: <20260713084320.1015240-1-tariqt@nvidia.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260713084320.1015240-1-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::21) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ2PR11MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba559f0-427a-4c2a-51dd-08dee2081dfe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: tF6lRHc4bZa7CdN6nDR7IFW0xokIES5kGGRn0zXQTRROgQLAk7gB5NoBE3KKQbu07Zn3zafiDNQ7KSEUZoUEYmZxBM5jqGoqRYZj3PglUA0jB/Pz780i30HePA4ufu5eQeZiq5yT8D/BHP1srcpEMpZGhVRJyyst4UHiJgyVDKClMnW5gpQbc36zfEe2Wg957HoUjEF3wbtcV7yax0ZJ/AvACIfxlz+ivCCCieW050qcfy++j5aEcUP56Wn5ImHc/fyzfOSAognqDZPsf5CcJ8eDIWvU2QMWP40YO1N3O8AHWVjjIojrjk1LbSI8DNeKMaA9rpETB/Qh1MCpJG7TlDvssTuZb7h2Vxfnz/eWUCamD6C1jw43Gt2cWPB6VFyGwqySfMd6dzcRx3xqqj1Lh1j5mesC7lg+DVY8cr4sEHflUwfvbNp22Xfph7bv27/iJXYY8b6hq4F4kEeqWhTj1OhxEqvuzAH1JmWAbf6BWazfQdBmNV7X1WnAXkdupn+idc5uRz8q/tEHVePUnN5KLhUML1b4n+/uCFjKTtCP4lsSaS36uPbV+7GH1cQs4nPw2m8Cp+3vJ++KBwBPbTkkuGG5DmIArXg1yUUzNTciHkmWuEjMnmnSxCPCLWHnirxuaHnXeCoXvAFM4bKi8EORzcAOkXhMLn2atltczY+AW5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUlyTFBWbUJ0M2l0clllK1Y2OEdTcVBzY05aclhON2FPMnR6b2w2bTdyT0hl?=
 =?utf-8?B?SEliWEl5NWtLVEpFaG5nNXNESGV0TkUzRHdoQUQwN3hLMU1ZQ1E5YUZyQlIr?=
 =?utf-8?B?Z3plVkp0eXczZG9nQXhKNENHTVBNd1VMTzBjdlVNM1VqMXJRMjBKMGJzWThK?=
 =?utf-8?B?SmFmSFhNS1N2bERteUZ2WUVKaENOc1VrUjdBREJrRGEvL2Vya3RBN2N5SWpw?=
 =?utf-8?B?bmphc1VvMmY1ZEt5TnZHK1BxTFZlUWNlcUNrcVpoREt4a3QzT2hkWnJYbGRj?=
 =?utf-8?B?Q3VKblY4S3kwc3ZEa1QrNGh5UWludnNkQWIzOGhKODUvTUxxbUIwb2NaZFJk?=
 =?utf-8?B?TXdIb3hadm9STEE5c2F2QUJyVnN0V3ROZVNBS1hGcnlLQWU2VUY3UHIybkxQ?=
 =?utf-8?B?Um9pb1kyMkxFeTZPMWZ0Y1pDbXliaWxqSkRrdFdiOExjc0k1elZLd0pncVFV?=
 =?utf-8?B?ZnJob2hYb2xkck9jejk1QVd5ekdWUW53dHFscGZMcHlrdjBDVmlkRjV1cFJi?=
 =?utf-8?B?dGx6N0ZBZjlldllEVGxPNlo0MEVQUWV4U0t2R0xvZjlhemkyL2xVc1JxMGM2?=
 =?utf-8?B?NWN0K1BHRWNuUUtzS29sZk9xWHZmNFBYaWtWK0lHMEt5clRScVcxSTlzdVFt?=
 =?utf-8?B?SjExK1NGRTM2RVhISTc4UlFCS1pSTWhodSthSEZkdXV0dkMyK2RwM3VlK0J4?=
 =?utf-8?B?cndiWTV2elNWWTZRbGJ0U1pGM2dZUi9QYlVPdGdtMmJDSmxLb1pJcEttQ25F?=
 =?utf-8?B?bDBLYXRUNncrUUhrbkg4UEc4YUdJakRRMWo4M1V1SjVCVjBubnpCM3N1bmJE?=
 =?utf-8?B?bnExbUNFSTMxVUo5Z2h0bnJMSyt2Vy9XZUx1VXVwbjFYU2ozVGx4M01pYjBz?=
 =?utf-8?B?SU9sWVViVms5NGN3VE1nNy9vY0NvSkVWYVNGRzZRYnYyNCtwSFVxbGVTTTFx?=
 =?utf-8?B?L1B5UzVPb09JUktuVGJCL01uU0Vqdi9VdXdZWDFxUk9GeFNRQU4rQkU4MGZG?=
 =?utf-8?B?QU1hTmxlMGJQNkVydWJXb0ZJWVZPMTNFUDFrcW5qczJUSTFyRVhEWnRyR1Iw?=
 =?utf-8?B?ZS9pYkZkLzdJZG9HM1pBS3ZFcVZhV3RoTks0NVRLT0I4T01icmtQL2hYR2dO?=
 =?utf-8?B?SnNmSnZqcS9wbDBPNWZ4OWJhWHppV2k1MDV3NVBKaDQyMWlTVHVTWFN0cWVl?=
 =?utf-8?B?YU9XbVhmRFhpZDJWbWJPOHdlWFNndy9vOHNVV3dKOTZISFpMSHZXTjZBL1Vu?=
 =?utf-8?B?NzJ0RENhVUxiSThKKy9RNE90K3h0UnE2T245elI1TVRWek5RbWp0b3F2SkNs?=
 =?utf-8?B?YW5jdFVBSFQxZ3dWTUYvNXNuS09PQks3b2J5eVJWSzE1bGdpcCtrQXFhdVd0?=
 =?utf-8?B?Y0YxNEpCb1MwQjY1RVRqNkoycjhNRzFNSEhTb2N1bHpEOTdPY1YzUDlzL09D?=
 =?utf-8?B?MTZTdmNSQVA4bXZpeW44MnU3dnI0MlpiYWI4VnpzVHc0ZHhnZElUeXgzeU9V?=
 =?utf-8?B?ME9QMTBtcnpIeHJnK3p1MHA5NDFJcG1EQXc0clo1RDB4QnJ4MHNqV0ZPR0ls?=
 =?utf-8?B?VGRYTWNYKzVjWWVKKzI2QW9XYkd5Y2NSS0hGU3BScDNDbkRYTDFwUEJ5WDJx?=
 =?utf-8?B?dVdjZHR4TUtIdi8vQTdzVkNaRnpXYm1KMGpGcGZlb3FLYk84SjVta1BXcGpY?=
 =?utf-8?B?TTRqS2hicklwNVVwNi9HRFNrdzhhSjNrM0g1MlRuTklVOUdjNTBnTmRhM1VP?=
 =?utf-8?B?RUp3WFBoem1wUzJpOTBXcGhtWlJ3OVBVcWxsaDZoZ3pmRUdGdjNqRVlIL0FM?=
 =?utf-8?B?RVc1U3RQTEpTL2c4eGhKbmEvdGMxZUVKWm53THEyOUJabkZzam0rZndHbGhT?=
 =?utf-8?B?VTFOMXlPd2FIcWNFQ09YZSt0c2ZCWVhZbFJJT2VDOUN0WkFPM2laMW5leHJH?=
 =?utf-8?B?d1kvcWFCYUlJOGtydG1IQWZyalU3WC9WZGdpYXN4RjVPaTVDMUQxRm5qR1VQ?=
 =?utf-8?B?ZEt6SFRYQzFVMkFWSHhITUVMY0xaRW9sN2JqRkQyTWZFbGZpZmxvYkxMaFhu?=
 =?utf-8?B?TW9MWjkyem55aHRnc3cvYkFvT3hNOFhPYXdJVjh3b1JXWXNGaTVwQUN6b3or?=
 =?utf-8?B?aVNnekxQbWUzMS9lb3Y3U0Zka1NJSTQzQ3RxUnBCZU1GbktVN1pHZWc4Ykov?=
 =?utf-8?B?Q0I0S0FNaGxLVVB2SXJZdktORm5IcW9JRnc2YU1tQkdYRURDRWh3ZEVKZmF2?=
 =?utf-8?B?emtKSjlhRjBTSGorRjBFT1JNWVpOVTczQU41Q0RXcSsyNkdDNjZMekdlOFBn?=
 =?utf-8?B?TVNaMklhRGhEbXhlT2FuUkVsT2pEVXJNd2I2SHUzWGNNRWJpT3Y5dz09?=
X-Exchange-RoutingPolicyChecked: OPDn6FuTI/dn2X+1cBgOEX+QEkPLp4+zs0DEhIgZ4zISm57ajGEBHPbVa5rYBRcShJ4D1r+53nE0HuxcvZUE7VStKE1VULQOGZOHzEkzjs9CZkZLuXHgrgkUPV8LatNww2bibOQgUXvHJ1WU2UifNSOiA4NMEptsT0Zw2wM705L6yBGOJDHBVt4lnPY0l6vbL2o2VyiaUpIjAghiZ5gGVMSClYVW4YMOeVWvWKXjppDBDqpwrKMvHNwYfJiaA4yau4o0nt2QTE9Qd8Vqe5HzhPMEe6WLpJYfWmWL68Zc6d+tIgHTWbXJeU3KA2ywBd28lt7RvBJbFzyIVwix8/McNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba559f0-427a-4c2a-51dd-08dee2081dfe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 00:29:22.8920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5/MJoD727c4m9EBp9bwkXG9zY3aIfJXdiBN7zQj7dbyI24i28P/I0vAQC+hF/dC6TN/Xivjpv2RLu04hcWgIDppnea39la1CU8I6YJh9qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7504
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23238-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:alazar@nvidia.com,m:valex@nvidia.com,m:andrew+netdev@lunn.ch,m:cratiu@nvidia.com,m:davem@davemloft.net,m:dtatulea@nvidia.com,m:edumazet@google.com,m:feliu@nvidia.com,m:kuba@kernel.org,m:kees@kernel.org,m:linux-kernel@vger.kernel.org,m:pabeni@redhat.com,m:parav@nvidia.com,m:shayd@nvidia.com,m:horms@kernel.org,m:kliteyn@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:mid,intel.com:email,intel.com:dkim];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 721CF759B5B

On 7/13/2026 1:43 AM, Tariq Toukan wrote:
> Hi,
> 
> This series contains mlx5 shared updates.
> 
> Regards,
> Tariq
> 
> Cosmin Ratiu (1):
>   net/mlx5: ifc: Add PSP related fields
> 
> Shay Drory (1):
>   net/mlx5: Drop redundant esw_cap, reuse e_switch_cap
> 
>  .../net/ethernet/mellanox/mlx5/core/fs_core.h | 12 +-----
>  .../mellanox/mlx5/core/steering/hws/cmd.c     |  6 +--
>  include/linux/mlx5/device.h                   |  1 +
>  include/linux/mlx5/mlx5_ifc.h                 | 38 ++++++++++---------
>  4 files changed, 25 insertions(+), 32 deletions(-)
> 
> 
> base-commit: ddbddbf8aee54bee038149187270c93a45478473

For the series:
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

