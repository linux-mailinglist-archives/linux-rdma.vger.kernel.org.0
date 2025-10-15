Return-Path: <linux-rdma+bounces-13876-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BEFBDFE8A
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 19:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 845A3507F27
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 17:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FFC3002DF;
	Wed, 15 Oct 2025 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YQEcipS6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986F61E51EA;
	Wed, 15 Oct 2025 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549780; cv=fail; b=owpsPIXD2eO+EQVZHsOgCO5ALO4k4eRcs4kED7Jie13f7hckyJq67T1jdajvuCe0tHhx3mozgEkwNecm411f5Ay8uzzS9XaKfZGoL+a8e48+a1ByC6DCnok3MyHwylSNv5HGK8XwlVFzWKh0N6+27b6B1Oxh/g1gxKUG4TeJlzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549780; c=relaxed/simple;
	bh=murbqqz7HdC9XjknPazHMoXS1AZ0NAtGWyf9Pp0CC0c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C2eo29g8YTvofXPJGk91RFZEWeznganCAerijex6SIszX5QAT5+8ydvHjl+hDgWHcgH4OnxSlMXO8Xw/F+uQKAQ9iPFOYpLL2/dYIlO7bUppzmYo/H8bZUrHkbkvthcCmKDhIkdWGoQZgp3QaCr0Ar+wHLtTcK2FpeERk543B6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YQEcipS6; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760549779; x=1792085779;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=murbqqz7HdC9XjknPazHMoXS1AZ0NAtGWyf9Pp0CC0c=;
  b=YQEcipS6zdJABaIODLqmpt9wl6YC+5K4sWqvlIGe0Snf5FR21EaDhSdF
   FqyE0zxw0qtDl+e6otMm68mrNM4MLfuFEb0Nj0Vr5HxK2P3ApcmYcmFrs
   SLLMQZGUA8eEG6mowUz5IkXoLUJ9lkemcS2N1YG42/lyLhOcIsuOvUoHT
   bQYez/rXtqwktAf2sWFE1y6EAgLVqFaaTE1PkNMut54pgxtYpmOWEx6BO
   yN6Ih5LBmO6BOcZKk6O7lNeEPEUpq8KnLQt3Bo38E4XO8cpKJuqDXxGLG
   5nR4tYO02ADKwysiNvV4I1RNdkEpM764TrKo8HlIPT+d7MNUEITT26tEp
   w==;
X-CSE-ConnectionGUID: xW4NYeYySgGCk0etGwRLDA==
X-CSE-MsgGUID: 9A0JUCwDTZur9VfgOSFD2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="50300542"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="asc'?scan'208";a="50300542"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 10:36:18 -0700
X-CSE-ConnectionGUID: 4rkwQzTCQFudq/DQtAwJwg==
X-CSE-MsgGUID: n2BKuOtPT3umUYItDTCx8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="asc'?scan'208";a="205935546"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 10:36:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 10:36:14 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 10:36:14 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 10:36:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzcK1QJBCCOLJEDFJ7x+E2tVE4r4vyTL42gNs+0CDA9/cHbO2RXWr6UjpfWDMO5bwFm+NXMvKgRlKA1ah+wK/TsvJ4PTj1WyKaQ871LV7vlY2zf5BBWDErnhxup/bZdueKz8HNFkFZpgg72skTXPFbZbMFsPB1lvhR/HedNwfkpBQ1BoFQD39bYPIXn4bNDG2i+/HrI0JoSN4rVwPVALF8NXNruSgIcjFrW/0QD00G9I0rMKUj/NvnCfdeRVsX3nbv2jHUXYm0ErTP4Mk6h0FEY3bZxjEvqBokB9WNiyiuRvTbYZXPAMjCKeSfY3fBAvxz/kGdMYGqF5w0JlMDPRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TieThJ8fbsKBpeoduGynUY5ucSudJYNYZcSUDcSHymM=;
 b=FbSdLwkK3EXFx9wqcxeu275kVH0SqEDQOchflXMahhxm20vJqlEcpHfg9TE7Bsp0lAX8qMXUDvk4DIPkCV+FwHfaiKrtn6213BXC6YC9OUyUyc2nPQH/58wnfQzUYX7mtnHE8U+qi8Qx1zGf9l5gtWXQxl1AHQ4tbh5DiPy3eBfWFTc42FJ+H29jsfI8OX4yB4dAAlmKM7xYYDuT/w1yCtyDpdLD+h9bN18O3lR3Sv/9Y8STNpttp0meskBM2aZsMVlmKVbG0oAlJv15pbetit8xwa9Kniw2XxTcW5wrC61HMlIiDrwQqRTgus0fOaEr7UcpCbKK8nguWcCeAvtraw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB6900.namprd11.prod.outlook.com (2603:10b6:806:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 17:36:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 17:36:12 +0000
Message-ID: <7314721e-3822-43d1-b9bc-acc1e56d610d@intel.com>
Date: Wed, 15 Oct 2025 10:36:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page
 size
To: Mingrui Cui <mingruic@outlook.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <dtatulea@nvidia.com>,
	<edumazet@google.com>, <kuba@kernel.org>, <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<saeedm@nvidia.com>, <tariqt@nvidia.com>
References: <324e376c-8f66-4ae4-af2d-eea7e5a8e498@intel.com>
 <MN6PR16MB545089E086BF99087773B76EB7E8A@MN6PR16MB5450.namprd16.prod.outlook.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <MN6PR16MB545089E086BF99087773B76EB7E8A@MN6PR16MB5450.namprd16.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------JUIOECgS8NyDOC7Bo0WKnpok"
X-ClientProxiedBy: MW4PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:303:8c::7) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ada4398-79ed-4bbf-f280-08de0c115566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGpzUC9zb3pja1drUnBVTFNKZHpiNU1ZaFI2VDBVMHVhZWw5KzZPNk93ZHVk?=
 =?utf-8?B?dXhpODd5ZkVBU0lrcFBLTHUrMGdSaTRLOHVqNU9vd0RmelZ5Q2Y2NmxHSjRk?=
 =?utf-8?B?Y0xobldBYk1ZMHpCb0Z5UHRCbUpQcXNtMnBWajJ6MTE5L0V0THJOTHhGdGRQ?=
 =?utf-8?B?ODRuMnZzQktxRW9Yc0p0NXN2U0N5TVNnRDZiRHprajN1Sm9SMTB1RU5uWGhh?=
 =?utf-8?B?eXFLUTJrWFlxejhxRlU4bGo1azJVM3RydUNzWVNvMEkzdWZnYmFKNGF1UG05?=
 =?utf-8?B?Z0VJQTdDekgrSzIyT3FTVnpTZ3E2bjhRakltOWJRaTcrTERCNTdVUFRvWDM3?=
 =?utf-8?B?Z1lsVlV0TjU5QXBFSTFrNHFPb2hWOFhqV3h4L2V6am14Y3l1akNWbEZST3Rl?=
 =?utf-8?B?WUMxUDJzeThKaUhwaXhMVDI5K3lQb3ZXV2FKSjJUb09MK0NONE82a2hpdmxN?=
 =?utf-8?B?V092T05palhQRnpkRmxBTTJTZGJUVldwL2l3L1phcjhqRnR4R2JyMTNQWDJF?=
 =?utf-8?B?eVRkVDBYZnpwYVozejAvYURqaVNZL285KzBpMjVNRlJ4VE9xWUNKRmVFcTNy?=
 =?utf-8?B?T21CMW1Xa21ZV0J4UmhkOHQyZFB1R2kvUWR6c2pTNVpHUVZwTGM4Y2NMNjBz?=
 =?utf-8?B?RDlPN0FYSGpzSm5yV0M3K0NEUFNzRHhtcldYUWpJTTVocUNQbUg3UHRPSk5w?=
 =?utf-8?B?N2tOSjJzYkxIZkQrUnIwUllWcXMrRTJodHVabW0yVERwRG1BUVFDOXVnTXZy?=
 =?utf-8?B?ZnZ4TnhCQXVPM1dXcElUd2NOaXFQK2YzUzltdUZBQnVSbGx5K1hLaFY0VHNq?=
 =?utf-8?B?UXk3dmgwYngrV1BVVjVzenR1eUxWeGtZSjdHaWo0YVRBV3h0V3drQ0lEUFVH?=
 =?utf-8?B?UjIyZm9MME9UWUtFSi9mR2swZ1ZHNEEvNlNIbUFPR2h1WEJYMUNzQ3l0TGkr?=
 =?utf-8?B?Z21aREZWMlBtaHpqOGc0MkMrTG5jSTY5S0hlZjhVcWRoaDRiblhxWUwvelRs?=
 =?utf-8?B?Yk9BcmMxOGlGWjhlWWxxK0VsbHlzTjZ5QmN5RjF5NkQ5Y3A2dWpKdnltaUh5?=
 =?utf-8?B?bW9GUUVDVi80eklrZ0t2TEpOVVhIZHhhNElKWmlGaXJITVBFdktTRkJlZHgv?=
 =?utf-8?B?VGpRc1YrOXZOVW1obTVrM1JScytCak9jVFBuOE0wRm00UEpuVTFQdjJ5cElB?=
 =?utf-8?B?dUU1TEVETFRiS3RjVXA2NmQyQ1djWmhISzVvZ3Q3dlB5U0RkdmxGb0pxZnRR?=
 =?utf-8?B?ejcrbUVrZG40d3E0bW1yWGF0bVlGR0JyV0ErMWpFTXdqeEFjNWxUbmR6UjBN?=
 =?utf-8?B?clRJdXhtQXYrVzZPV3lac0lYajRxYUQwOVlqbTVPUUYwZ3ZucW5FeXI4N0Zv?=
 =?utf-8?B?dFg3SFVXUHRVRHlxVk83cDNVT0lBWXppVWptUW5RNFdmclBqTzlNSTBVNUhk?=
 =?utf-8?B?ZTlTZnlBWDBTUzFpNjk4NGtUWWx5M2ExeWhDWld1WmNlODVOeDNLMitHMlNC?=
 =?utf-8?B?eFFsOEphRWpPc1AzMDQ2cmw1bUtLZVVUZ284NmhXa1JHMXZmYXFiNDRSaHlV?=
 =?utf-8?B?bzlJS2NkZXk5MmwxMzV2bVhSVi9vdnZIK1J5cnNRUVZIVlV4RnpDL3o0UXRq?=
 =?utf-8?B?ZVpIUldyay9ldVMyL285NVJjbTcycHZrSGdNRG5taFkxUy85cDl1QmNMSGJT?=
 =?utf-8?B?dTJqZjFVaUxCOENFLzJTY3ErTFVCYWxST0dxcjRvRjV6QVNRRFcrTVBOcHJL?=
 =?utf-8?B?Q3BzMTA3djBHcHVsenp6eFpSdE5HYURYNlhtRzNIU2ZsMmJjb1NHcHZ2NXkz?=
 =?utf-8?B?RStuSjlPU29tK1VJeEw0eSt4cW9zTExRWnBlK0hEdlZpQ3oydlRscTQvUkVE?=
 =?utf-8?B?ZnBvWlF4ODM0VG8zSTFTVzdPQnJlNFRRQjd4bUpybFpjaGc1djRtNDNFTHZx?=
 =?utf-8?Q?mgoVhm2iBx8luoXhJCKF/v6sZrhYKRIj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzdybnYvbHNDNjlnb3psNmdQS1kzMVpvU1FZRFg5QXdiU2Q3Tis5MUhsazBo?=
 =?utf-8?B?bkZCcXAxMVliNi9QWDBHUU5wSkxLRjhrVGhjczJKa1VDd2p3S1ZLcnUvNm11?=
 =?utf-8?B?OW5yekI0R0FNM2dkZWQ0N3dKclRJdTZIZEJTQURTV3Nua1dTSE4zZ2RVeSti?=
 =?utf-8?B?dncwdEdiSGRpUFRNV0RheUhJMVR6YXFyL1NHWFJFZ2h6Vm5tc0VhQ1lzRGli?=
 =?utf-8?B?SEJad29MNkRUTTVMV20vK2VIN0I2SGYyek9ud3lzZjVrMWtDMFBmcW9nT1VS?=
 =?utf-8?B?UnBMTHhWdW1Ra3UrNXBXb2FRVGhxbGI3SjJWSGZsV0NsTlF4aXEvRXd4OTJn?=
 =?utf-8?B?SHcvL3F2RzVsbkp6V1c1V0tRZENEVW9GMGg1bGFIRS9QOVNRa1EzalFWOUVj?=
 =?utf-8?B?OVNuTjJaTkE5WjQ2Q3ZWZzY0SFg4OEJOdmdWK0lscEwydW12WEsyMFh3YTZG?=
 =?utf-8?B?UjlWbU9UeDVYZDI1M0NPQzRUZEdmZktscCs3clVKQmpxaUFXOWdNOURaM2tX?=
 =?utf-8?B?eDNxUElHVjQxT013aFpVTjE2eEJqR3Z1amU5ZEJiYU5kcS9KNkg3TWlrQlRF?=
 =?utf-8?B?bVpvREt2TnY3Zy9qekhTOSt6bkpUWjlYZFdGZTRHQmVFM01JRWt1YVRpbVJL?=
 =?utf-8?B?SkZTQzJqamo4cmhKQVY2MWh5THl1d0I0MkcycXd0UHhudS9yOTdiejRWMHlP?=
 =?utf-8?B?L3BwNmppWGIrSk9XVm9uNTNZZjlUMVoxTDhNMGdWQTVqb0hMU1VPbGFFOFQz?=
 =?utf-8?B?dzczS3JzbjE2cjRuR1kxc3FSSDYwVUVmamt2R0NqZndpZHdEV3I1UkNlOFh6?=
 =?utf-8?B?RFBzdmFOV3ZyQWZFRS9VWXRQYTd3a09mR0VuVlpwNENNTmhkRUZKUXRKODZD?=
 =?utf-8?B?a0x6TXpZdFAvczBiamxuWHp0dXk5em50WStndHk3SGEycSs4WGExSUl1WHFl?=
 =?utf-8?B?NWtGYmxNVTNWUm5XWmhnQm9laHU5SWVrdDlSZmZCZDI1bnFDQ3F6QTZBd3VE?=
 =?utf-8?B?NW5la3U1dVRmN3cyYUdNTzlyZ01NR1pSSFVZYkY4T0lkZGg4R2lKaU1GQnM2?=
 =?utf-8?B?akZWVTI3R094N2p6VkdkNFFjYXU3VnhUMzVnWGNPVGJ6RDltblZOMVdzenF2?=
 =?utf-8?B?eTFrZHVXYkJMQ1NabGRiZjZvRC96cU9qblA0b1ZQV1ArMW1Kems1NTJ2QkFJ?=
 =?utf-8?B?SkFsdCtzc3FyeisvZXZTeHM3WldGOFRXU1VIQUZaNXF3OEh3Qk01eEdXTTFE?=
 =?utf-8?B?WXpCQWtOMzl5Q3FjL3Q3ckFyL2hLb2FaWE9Pc1B6cXRnRHU4UHlZUTBpOExi?=
 =?utf-8?B?bktTYjZ2a1A1RjlMVjhZS1RGNW10Vzc5WFU0akNXczljSDVnNUZUUldYN1N0?=
 =?utf-8?B?bjhuVTFqczZVVUE5bjBhL0dhZ2NyMDdMak5ybUhUb2lTZVUwM21PNlRlUHVD?=
 =?utf-8?B?dHRWWlpnUGNLZml1eWJiNXhWUWRaMkJFVFQrZWVkaDJHbXdBV3EwRCt1d3Jm?=
 =?utf-8?B?ZnZtaS9SajlDVGVOTlJ6N05MZzArRk9rbXRYejRRQlZNUlNFM3JzRUpMREdK?=
 =?utf-8?B?MEE0VnRva3hVUUxOOWFKKzNicnloWjlQUHQ2UEFtanY4NGRmSG5sTTF1czlT?=
 =?utf-8?B?ckVBUW9YUmpwYStiL0V5NzkvZGZPVlJWVEJQbW0vVVQrUnNkMlBNVlZJN3c2?=
 =?utf-8?B?L2gxeHU4VEN6aTNWbVVnUkhOTWFOeFZ0d2xRbmZFRFNxRUJKTzhlMXVrTWI5?=
 =?utf-8?B?WG1Bb1puWTdqN1JuOFJlV1Z5azNqWDF6YTVRdUtGMS9iRjM1a1FybW1qbFBm?=
 =?utf-8?B?eldZbDQ4OEIwZDNkTXVsS25rbFJTbFhoci9YSExtOEY2MjhrYm9FdGdOYjdI?=
 =?utf-8?B?bm9WNWs2V0NmVkpBMDd0NWNISUgzWXZMWitvQm01d3l3WmNHd2dEeTBpeEhp?=
 =?utf-8?B?Z3Z0dXArUERRYzFzaGVSYWNPWTN4MEsxKzd6bjd4S3BLUHNiRWF4cmxyTXR2?=
 =?utf-8?B?cU1yMkloM1dqa2w3YnBualRINUdZSGhEaTc4LzVnanhMeFN5RDMxQUhudnpM?=
 =?utf-8?B?Y3RQeDk1MVRQTU42RkNDclJmOTk5RnVKSWVYUEtxalRLNFFzcGliQUZqRHgr?=
 =?utf-8?B?NGVTUzdXQlVvYzBXQ01EdVp6Slh6aXZmTUVYNFRiSlVOaFB3c1ZPVDk5ODVY?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ada4398-79ed-4bbf-f280-08de0c115566
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 17:36:12.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: niYXU/bIMchCSj0oxrfpLYHOVkQ0CD9Mja8JL3OKvQL1C3L1qAza1k6b5ymeIZ4aljibcvP3rGBbc07IU8HV3m0DVZIPDvYVoOwjMAJHPV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6900
X-OriginatorOrg: intel.com

--------------JUIOECgS8NyDOC7Bo0WKnpok
Content-Type: multipart/mixed; boundary="------------X9doj7605N4SL87pljtHnySw";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Mingrui Cui <mingruic@outlook.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dtatulea@nvidia.com,
 edumazet@google.com, kuba@kernel.org, leon@kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, mbloch@nvidia.com,
 netdev@vger.kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
 tariqt@nvidia.com
Message-ID: <7314721e-3822-43d1-b9bc-acc1e56d610d@intel.com>
Subject: Re: [PATCH net v2] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page
 size
References: <324e376c-8f66-4ae4-af2d-eea7e5a8e498@intel.com>
 <MN6PR16MB545089E086BF99087773B76EB7E8A@MN6PR16MB5450.namprd16.prod.outlook.com>
In-Reply-To: <MN6PR16MB545089E086BF99087773B76EB7E8A@MN6PR16MB5450.namprd16.prod.outlook.com>

--------------X9doj7605N4SL87pljtHnySw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 10/15/2025 5:32 AM, Mingrui Cui wrote:
> That's all the effects of changing DEFAULT_FRAG_SIZE. DEFAULT_FRAG_SIZE=
 is only
> used as the initial value for frag_size_max. It is primarily used to ca=
lculate
> frag_size and frag_stride in arr of mlx5e_rq_frags_info, representing t=
he actual
> data size and the size used for page allocation, respectively. In
> mlx5e_init_frags_partition(), an mlx5e_wqe_frag_info is allocated for e=
ach
> fragment according to its frag_stride, which determines the layout of f=
ragments
> on a page.

Right.

>=20
>>>  static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
>>>  				     struct mlx5e_params *params,
>>> @@ -756,18 +756,13 @@ static int mlx5e_build_rq_frags_info(struct mlx=
5_=3D
>> core_dev *mdev,
>>>  		/* No WQE can start in the middle of a page. */
>>>  		info->wqe_index_mask =3D3D 0;
>>>  	} else {
>>> -		/* PAGE_SIZEs starting from 8192 don't use 2K-sized fragments,
>>> -		 * because there would be more than MLX5E_MAX_RX_FRAGS of them.
>>> -		 */
>>> -		WARN_ON(PAGE_SIZE !=3D3D 2 * DEFAULT_FRAG_SIZE);
>>> -
>>
>> So previously we would warn, but now we just fix the DEFAULT_FRAG_SIZE=

>> so this warning is redundant.. Ok.
>>
>>>  		/* Odd number of fragments allows to pack the last fragment of
>>>  		 * the previous WQE and the first fragment of the next WQE into
>>>  		 * the same page.
>>> -		 * As long as DEFAULT_FRAG_SIZE is 2048, and MLX5E_MAX_RX_FRAGS
>>> -		 * is 4, the last fragment can be bigger than the rest only if
>>> -		 * it's the fourth one, so WQEs consisting of 3 fragments will
>>> -		 * always share a page.
>>> +		 * As long as DEFAULT_FRAG_SIZE is (PAGE_SIZE / 2), and
>>> +		 * MLX5E_MAX_RX_FRAGS is 4, the last fragment can be bigger than
>>> +		 * the rest only if it's the fourth one, so WQEs consisting of 3
>>> +		 * fragments will always share a page.
>>>  		 * When a page is shared, WQE bulk size is 2, otherwise just 1.
>>>  		 */
>>>  		info->wqe_index_mask =3D3D info->num_frags % 2;
>>
>> Would it be possible to fix the other logic so that it works for a
>> DEFAULT_FRAG_SIZE of 2k on 8K pages? I guess if there's no negative to=

>> increasing the frag size then this fix makes sense since it is simple.=

>=20
> To maintain 2K DEFAULT_FRAG_SIZE on 8K pages, one of two alternatives w=
ould be
> necessary: either find a method to calculate the occurrence period of
> page-aligned WQEs for the current MTU to replace wqe_index_mask, or use=
 a more
> complex logic to manage fragment allocation and release on shared pages=
 to avoid
> conflicts. This would make the page allocation logic for 8K pages signi=
ficantly
> different from the 4K page case. Therefore, I believe directly modifyin=
g
> DEFAULT_FRAG_SIZE is a cleaner solution.
>=20

Makes sense. The cost of the more complex logic doesn't seem worth it.

> Please note that frag_size_max is not fixed at 2048. If the current MTU=
 exceeds
> the maximum size that 2K fragments can store, frag_size_max will be set=
 to
> PAGE_SIZE. Therefore, changing DEFAULT_FRAG_SIZE to PAGE_SIZE/2 should
> theoretically be safe. The only downside is a potential for slightly mo=
re wasted
> space when filling a page.

Ok.
>=20
>> I guess the noted fixed commit limits to 4 fragments, but it make some=

>> assumptions that were wrong for 8K pages?
>=20
> That's right. Specifically, on 4KB pages, once a small fragment and a 2=
K
> fragment are placed, there is no room for another 2K fragment. This res=
ults in
> the predictable page-sharing pattern for 3-fragment WQEs that breaks on=
 larger
> page sizes.


Right.

Thanks for the explanation and answers, helps understand the logic and
solution.

For the patch:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


--------------X9doj7605N4SL87pljtHnySw--

--------------JUIOECgS8NyDOC7Bo0WKnpok
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaO/bigUDAAAAAAAKCRBqll0+bw8o6GZw
AQCbqzY+pc0gpu413f9L7qlFqM2EKfRPdeA4jZsPPx3ugAEAoTErx4omvIaphY+/l6WME22O+ETj
qDuTZswILVt2aQk=
=zDOW
-----END PGP SIGNATURE-----

--------------JUIOECgS8NyDOC7Bo0WKnpok--

