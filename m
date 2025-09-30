Return-Path: <linux-rdma+bounces-13748-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2C1BAEC79
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Oct 2025 01:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98249323650
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 23:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA0B2BF013;
	Tue, 30 Sep 2025 23:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYa8DJSP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB314D283;
	Tue, 30 Sep 2025 23:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275307; cv=fail; b=JHJ9OsyOFkil6UymtFo0P5gNDMUW/kcZRJVfG6MuhE1ejx6hMAsQ+VkuBclvXkeXbQKxxZu83Cp0jJYe1Y+WMPyqP8OSH4S1YfML5QIveD/YjovKS+FiHuucxwQJQkhAr988vA7E/0lJRHz5laX+ziokOyQpe3mZOueiZ9KNmjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275307; c=relaxed/simple;
	bh=QaiD9rdITX4lTGDu46HpFQAI0/6Q19Zy5etiq3KDo/Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VLjjPv1fq9gcN7GBAQ/rZUtvcdN0JfXARnNKKe/vOxddQI/POxXJ6b6YybpwFlKGm4dCfVFJkfM+YE71NAcWlA23YYUjOYQ4lxUvKc0194+5EBvGS04ChJuR25V+GXXnZnvre8Srt7SgCRTYN8q0rEZnvOanBbr8SxCz6hWg1ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYa8DJSP; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759275305; x=1790811305;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=QaiD9rdITX4lTGDu46HpFQAI0/6Q19Zy5etiq3KDo/Q=;
  b=mYa8DJSPyRkOyBoUnwKTQQP0MFhueSnSVO+jeUogj/6QyFlcife0dTZS
   Y33sGHMz9a9vQE0W877MUxoAPA061+SF/sR5W5Z+zgrkfBKmJDw4/5MMR
   8WT+iYGrEREjlKuJIdHjHbDIy6AVrRKowASBamnchGN9PEHAKAzrbp6Vw
   MQe+ghAn2A7VgHdSNyTTIZBX2ltBQ6YCZPvd5x9goJXOARL/2RHxdlNaU
   maWRxl3Yt5gOh5qlJOkSRN2q95Pqg123eyUI2IE1Eed5zm4Pv154wEZUW
   Ej3YIdswjdpx0rk9gY3qkrPS1Y5K6ckad/HlWg/mvByQJbXw3/AnGGxfc
   A==;
X-CSE-ConnectionGUID: meo1G/MlQl6Awjnt9OTXvQ==
X-CSE-MsgGUID: syonijTsRTKilkaKiy6pgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="72646687"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="asc'?scan'208";a="72646687"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 16:35:05 -0700
X-CSE-ConnectionGUID: DCqUnU9DRb682J27zym3SQ==
X-CSE-MsgGUID: MAtScVuuRhSuIUduE//+4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="asc'?scan'208";a="177926537"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 16:35:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 16:35:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 30 Sep 2025 16:35:04 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.42) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 30 Sep 2025 16:35:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOKAklrLsqF975XQ4YpI9DSwTd80QKpm4kqkQGhccvcJ8GkKGAQbGLtWybl8uVU7LVZNqHKoQHqlEzUrC0Ffh9yCQxVUgJvrYi4+jnMsN2QXyXZ3ezTGRxSY6cyVcDVwacfIhQVEOTGN2V0QRsBcFunfxFRV/mz42o0+2RBXawQfHeEmLAiB1ZVSrj5E8sM3wCxieDe/xIswKLRj8AYUOD0s9Dgu7RxNkuY1T7usVEBSQbUDsQFyDpWmKcVkI8ZPmAiGciidGd8ymgkFNM5GeNQt+xKWurg1bEOdk9sUB4vC3DkWNX+UoHEMbFdM2KY8vwxRVdXyhDiOqkAWnu0+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWKCQvmaA8SDDmPtMefWaM5pgno9FCIS1qiIvSol+Hs=;
 b=obKX86UYZ59rS1IHtqSiNcnuULY7WN7UU20I2PAvU4giKMUpf/NthZIJAabzRUd2B/hwEOrH/0y6TT77Wfy40Gr3hHFVAquaiSFO6178Gw/9Y9UQCtgtg5Nqs7zgMwUUuA7epB5esj3qZJMCp9KqB30iML4wsa48XhHfOhPd+KyVeKaOTAYRlydwpr0EMZjF0bOcBx1/MIvvC25kWnJAM+ww+LDlt1HzBK2J2H/c5rPH6ZrKBOQMeNHvDf+K8ivnO2P3GHMTlAzFYZZyztSa0ET5LeX4xmivIIjt5q8KXHC8L2tj+kseKW6pPiRo6cNCWOVaa+BqDwQVib+uQFhabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB7660.namprd11.prod.outlook.com (2603:10b6:510:26f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 23:35:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 23:35:02 +0000
Message-ID: <324e376c-8f66-4ae4-af2d-eea7e5a8e498@intel.com>
Date: Tue, 30 Sep 2025 16:35:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page
 size
To: Mingrui Cui <mingruic@outlook.com>, <dtatulea@nvidia.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <leon@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <saeedm@nvidia.com>, <tariqt@nvidia.com>
References: <MN6PR16MB5450C5EC9A1B2E2E78E8B241B71AA@MN6PR16MB5450.namprd16.prod.outlook.com>
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
In-Reply-To: <MN6PR16MB5450C5EC9A1B2E2E78E8B241B71AA@MN6PR16MB5450.namprd16.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------FHL8F0i5lo557C8lMnYcD04j"
X-ClientProxiedBy: MW4PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:303:6a::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f63c12-55b8-421a-62d1-08de0079fa41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UE53TWN6cTMxQm9vQVVpRVpkYU9tZlduTC9kWFdnNXh5dllUUUlOdm80TFNM?=
 =?utf-8?B?eHFPalBUd3p5MnIvbk1uZHF3c1I3RUgzZFg0TE4zSzVOQ3pZeUErMi9WMGpq?=
 =?utf-8?B?ZExqb2VQaWpNUnoxQnZ6V3Jzb1FNZnZsM2hURVltR3REZzdlZSs1d1NXZm5V?=
 =?utf-8?B?UDRWTm5NYVNlVFVSUVBtamdXTXdIQjI0VjV2cFV4bWRCaHJCR1RtVFlnMDMz?=
 =?utf-8?B?SjRIWHRUb0JWMzJQb2lLanN4dGpqUjRuQW5VZDZ3bEd2Tkw5UkhuVGlpVVZF?=
 =?utf-8?B?V2lrSEE1YjNLdlpaOFdOcWlnazR2OWVYYkZhSmJjbzdBcVF0RGNTb2s5V1N5?=
 =?utf-8?B?b2VHbW1QVnh6Q05qcDFpS2FndHdLQ0tzRW9uallGR2FYNnVCRWtQSGczU0Ry?=
 =?utf-8?B?L1RRTWNGTGdRVnpkK2xIc0U4bWZZMVMxbXFUUTBaN0thNWhZTFpOWDRWVHFr?=
 =?utf-8?B?V3NEbG1MWndmTjFBV2p5dGpxa3lTNXdjTWw2YkFPV1RXN3N5QW9wZWE5bEU0?=
 =?utf-8?B?cFVyOWllbkhTTVFQSVJzVXNFZDAyV0tTcVd1YU1wOWhTb0RlNTNEaUtvU2JP?=
 =?utf-8?B?M1hVdWQwTFZYQzVPeTJkaHlQN0JWWEF6aENOUHhJQjhaNTJPWWNGaEg0cUpu?=
 =?utf-8?B?V3FkVStpZVN3K2lSS0cybHdhWmNnajlsaStkbUNEd2xqMGxGZEVlbm4rOE5V?=
 =?utf-8?B?bTFqY1JzaUttc0RxWE9Ybkh3Q0N6elhXdlE3Ti9vY0dGdVIrRkZPUjFiSDhY?=
 =?utf-8?B?YlBLYm1Fa3cvRGozalVtMW5aczRQM21VOTlKb3JCZnpkRk51SUduZ0xoLzVk?=
 =?utf-8?B?T1phU1JrVllZM05wYnZjVmJZSUVWQUZYS2JpSnh6ZE9XQkZxNkZtalZzNmVz?=
 =?utf-8?B?QUZwSjR6eGsxSXRUZG90c0tOSlVTOGFvQ2N0aGpMdisyOUdLR1JSb1VSNkZD?=
 =?utf-8?B?QWRWTmxyYWcybkRWTEc2dVBXdkxLa3gyc3BycTRIOUgvajZDd0NXSG5IaXRn?=
 =?utf-8?B?TXQvclpjL3lHSnVOQ0NVQzVhSWlsWVF1ZEJHQ2Q0YXRzMzRtOEkzZm1kN2xX?=
 =?utf-8?B?MFhTME93Y2xIN0p3VlZncmZlMWZPbWNYR3pBV3NJTGkveFJqa21BM1M3enRx?=
 =?utf-8?B?YmtZR3Vtc0tVaUt4dmVlbmNlVFp2T3ZVdGF0cnRVM0oxeTg2alVodDVKL01G?=
 =?utf-8?B?RmJkU1R5dnZNYVRORTVXdXpGaWQ1Q0pWblNMcHhxVnRwOFRoQUdlY2pCZ2xC?=
 =?utf-8?B?VmxyeFEzT2Y4b0lBekRybTcxellqNXU4MkxEWmFiYTNKUE5XR3h5RWFWODBq?=
 =?utf-8?B?b3pRWWxObm9yekNONnZPQUw5cGlDRlorYUcyTHViN0tMN095eVFCekUvUWE3?=
 =?utf-8?B?cmt3bkZWbmdQcmdyR3NOWld5Sk8wYWdIZm9VNVlJVXhRQ2RPVWRzWHFvWkY3?=
 =?utf-8?B?TmJuQVQzSElwTkVNbUdtSTVDdUpVRWRid1p6b2s4VVp2UUU4UUF5TzVxZzNt?=
 =?utf-8?B?OW9tdVI1TEhKd3J0d0o4MHI5RDhscFNHMTIrZmtOSENlZ3JSbG1JVUt3Zi9U?=
 =?utf-8?B?QUZZWURzTmNoNDZuSEFzalh5NHpIR3lJejN3VWRJZUw0d1RnMjlKNTkxVzUz?=
 =?utf-8?B?dU1yWUY2b2ZQYURDSU1KdHN5Zno0UER4a2V4enorakFFbi9US1p0bnNNb1Zz?=
 =?utf-8?B?djlzZy9lY1d1MExvZTBXczlJdHlobysra1htZ2gwUXRPYTE3aWY2S0ZrVkY5?=
 =?utf-8?B?VGJ1N05nR29GczZTQmJ5R0xlb0UxMjdlUFJkY1Mvb1FTTkcrUE9HdThjaFJm?=
 =?utf-8?B?Y1BROE02ZER0RkNWRmxDVytQYlMyd0JtMDh0QUU2UURnb29nSGRQVnBndlhV?=
 =?utf-8?B?VHZ6RW1vcVRBbXFDWTlWUmZJWGIrSzhEakxObUdoRlVjR2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUx1SVRQNVlDN20xeXFjQnJaMEkrU3FMZlExSGF2SHhYMlg5N0VKdmFKeTJm?=
 =?utf-8?B?QStUSGtzdGNodko4K0MxTlQrak5sWC9yaVh2TzZMRldndkFyYytLRU9WZHVK?=
 =?utf-8?B?ckMvWFlxZjREU1F1YXI5UFpvU0ovUWF5S1JWSkxpNFNzVzg0M0xxMnRLK0Zj?=
 =?utf-8?B?bjRtMnhrd2I1aHRmSUVsWjBnUmtIYmNkd0w4aVFQVkpROXNldzh5MWNkd1FN?=
 =?utf-8?B?cklyNVpEcFdQUmI4SDVFL29HUzBpazF5aTloSDJwKzZFb056L3dyY2RKOVVM?=
 =?utf-8?B?N1JzdVBmcjU5TXJ2R1E5QlRpNklkanZDQzZtUjRNZHN1Z3hrWGJsQlZOQVI5?=
 =?utf-8?B?SnhaemtrcWMzWDN3am95aXlSaTdSWlI4VS9YWWczMmVUWGNCZHJUWXNjbnBm?=
 =?utf-8?B?Q25nZFBSVFhHSmVmMDVJclRhZmNLN0NGUDRZVXpiM0lOLzNFcnlEaklUMWpz?=
 =?utf-8?B?NTFENjA2OHVOWkNLaHRySWdESmlQcHlJbGY1WlZ2QXc4Y3BQUkRnOTByTG9O?=
 =?utf-8?B?cUNXdmpkMUJFNDYyMGJzdDN5UU4zQy9jLzNqL09yRmxVVk5ydThDUHJ3N3cx?=
 =?utf-8?B?WFlqbkVaTmkvVFRqdEJyQXBDQlhIWmpvWS9ud21VN0U0VDY2UTV2YWFmTHVy?=
 =?utf-8?B?dUY1TXQweEY1UHVVN1VYejFINVFYbXhTUVFVdWhTTm5TbTVmU05uZHJBNVhi?=
 =?utf-8?B?Vk5VckhSenhxbUpkdUFpcENlckRjQ0VNaFhEVUJtbVIvem5SWkU2MzlUUk95?=
 =?utf-8?B?eTlaK01zYXJ5TGVaVGJiS3ZoUHE2RnQ2aTlnTW0yQkRYN05GVUNmNjBDZXhE?=
 =?utf-8?B?emJxWmE5eFJKNHYrVGM0cElYaUp5QnhqYk9jRm54Mkw3c2hCU1EwMy9KQVdZ?=
 =?utf-8?B?ZnVvWmJsZ3hPMnlQajBKYzRyMy9IN25rSHVXWE45R1daWmF3Q0FUUVQwSy81?=
 =?utf-8?B?RlpvcmJ6SkRQYlM2dkVIb2Vqc2dvak5BZEN2eW1KdkFrcFlySWxwNVlMS1FS?=
 =?utf-8?B?cjhqcG4xckN3KzMyOGdGeWZwSzJZWXNPY3ZncDVTZXJWRFZHZkFydXh3TGN2?=
 =?utf-8?B?N3FET2Zza2pUYTZGZm5XUzR4QVRPU2RZREtLay9JL2pSMDVjV093SjN2cFdC?=
 =?utf-8?B?cHc4dnpyeCtIbDlwN0djOE85WEl6V1EwSk1ybHV0dlFPMEJWb3NoaEF3d2xa?=
 =?utf-8?B?QWJtWkduTHRsWTBLK082cE5MRXZ6TU0weVYzYURIdVE4RktxbDkwY3QrSGJu?=
 =?utf-8?B?SVQwUG1wT0Y1MGtkZ09QLzdPYjlFd2kvOUF3SEd1VTJFQ1pITWNEN2F2SUJ6?=
 =?utf-8?B?OE94a3ZBVnlKU2k4S0ZRcFFCYU95WFlsRm9wQlpNMythNTV6dnpWVHFJT0RZ?=
 =?utf-8?B?aFY0ZUVYYU5sbDEwY1Z4UGp1NjJ2RGh4dkJXa2RNNklHZmVraUU0bWN0MXRk?=
 =?utf-8?B?eUt1Qkt6M2R2Kyt4ME9Qa2pDWXQzUXVBWkU5azZsNERYOEFRMmJLL2MzRU5R?=
 =?utf-8?B?ek5obnBOaDZta25GVUVyY0xuV2xETmNYMVZicG9rc0hETkNKY1UwdWUvZXgv?=
 =?utf-8?B?UVphd2dabklraWZvdUx2aVl3bG9FdFpkSVdDd3hNTjU2NW5JWmNCeTZxMFFw?=
 =?utf-8?B?aDhNUUh3RWhPd1hFMmh5YUhuTFViOWhXRHREdGdDQm1EcUV6cFdDUUtBdVR4?=
 =?utf-8?B?Z0RXb25MbkVkWm5OVisvUmdyTWh0d0xNOGtNTGVxUEZiMTV6S1Z1V0NwSnVT?=
 =?utf-8?B?ZDM3TkFyKzlMNWs0QnJIS2pKWERzWnFSRWhVVU9lV0ZzaFdSSmZRYzQxOTZa?=
 =?utf-8?B?L0pVdVFSQ2RyK3ZValhQSlJRRys3TFdTaHJndVRPcnZIb2VFN2VPVmJwbnpl?=
 =?utf-8?B?YlZpS0YwbzJBbWhOWThibERBOEdJcE9tdGZpOEhQaksyTnJYL2hQMkthSXdo?=
 =?utf-8?B?akpPV0pmemU0eHhiWGpQb0NHNGg0KzdYblNmQUNNbm85dThndWtuWDk3cTZJ?=
 =?utf-8?B?VjRsbWVRTG5yYlFzUHA1SW5nOVJOcnRKNmxaYStDL2VKSTkra3JEbnJvYTcv?=
 =?utf-8?B?b0w4Q2x6OEcwV0hNeElSZDgwWi81YTMyQ2hFNURCQXB5aXd4ZFV5aXRVV3NQ?=
 =?utf-8?B?bGF4ZHBQOG1taDhrb0JWZW5wcFd3T2RYT1MyVTk0YzZoeWZRRDhSUHdEUHVX?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f63c12-55b8-421a-62d1-08de0079fa41
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 23:35:02.4112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/m7kWZSHBD+MroJ9yBzkX2kXu64QNoPUmRuTZub4uuKOvq885cK3xwSs12yzbx1KAQP3yNqFPJU7xsDyMC6iEy7Gf8LuNceXdF3ChjeAS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7660
X-OriginatorOrg: intel.com

--------------FHL8F0i5lo557C8lMnYcD04j
Content-Type: multipart/mixed; boundary="------------6vqlWkL8cnX7c2YgV30gtXnm";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Mingrui Cui <mingruic@outlook.com>, dtatulea@nvidia.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com
Message-ID: <324e376c-8f66-4ae4-af2d-eea7e5a8e498@intel.com>
Subject: Re: [PATCH net v2] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page
 size
References: <MN6PR16MB5450C5EC9A1B2E2E78E8B241B71AA@MN6PR16MB5450.namprd16.prod.outlook.com>
In-Reply-To: <MN6PR16MB5450C5EC9A1B2E2E78E8B241B71AA@MN6PR16MB5450.namprd16.prod.outlook.com>

--------------6vqlWkL8cnX7c2YgV30gtXnm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 9/30/2025 4:33 AM, Mingrui Cui wrote:
> When page size is 4K, DEFAULT_FRAG_SIZE of 2048 ensures that with 3
> fragments per WQE, odd-indexed WQEs always share the same page with
> their subsequent WQE, while WQEs consisting of 4 fragments does not.
> However, this relationship does not hold for page sizes larger than 8K.=

> In this case, wqe_index_mask cannot guarantee that newly allocated WQEs=

> won't share the same page with old WQEs.
>=20
> If the last WQE in a bulk processed by mlx5e_post_rx_wqes() shares a
> page with its subsequent WQE, allocating a page for that WQE will
> overwrite mlx5e_frag_page, preventing the original page from being
> recycled. When the next WQE is processed, the newly allocated page will=

> be immediately recycled. In the next round, if these two WQEs are
> handled in the same bulk, page_pool_defrag_page() will be called again
> on the page, causing pp_frag_count to become negative[1].
>=20
> Moreover, this can also lead to memory corruption, as the page may have=

> already been returned to the page pool and re-allocated to another WQE.=

> And since skb_shared_info is stored at the end of the first fragment,
> its frags->bv_page pointer can be overwritten, leading to an invalid
> memory access when processing the skb[2].
>=20
> For example, on 8K page size systems (e.g. DEC Alpha) with a ConnectX-4=

> Lx MT27710 (MCX4121A-ACA_Ax) NIC setting MTU to 7657 or higher, heavy
> network loads (e.g. iperf) will first trigger a series of WARNINGs[1]
> and eventually crash[2].
>=20
> Fix this by making DEFAULT_FRAG_SIZE always equal to half of the page
> size.
>=20
> [1]
> WARNING: CPU: 9 PID: 0 at include/net/page_pool/helpers.h:130
> mlx5e_page_release_fragmented.isra.0+0xdc/0xf0 [mlx5_core]
> CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W          6.6.0
>  walk_stackframe+0x0/0x190
>  show_stack+0x70/0x94
>  dump_stack_lvl+0x98/0xd8
>  dump_stack+0x2c/0x48
>  __warn+0x1c8/0x220
>  warn_slowpath_fmt+0x20c/0x230
>  mlx5e_page_release_fragmented.isra.0+0xdc/0xf0 [mlx5_core]
>  mlx5e_free_rx_wqes+0xcc/0x120 [mlx5_core]
>  mlx5e_post_rx_wqes+0x1f4/0x4e0 [mlx5_core]
>  mlx5e_napi_poll+0x1c0/0x8d0 [mlx5_core]
>  __napi_poll+0x58/0x2e0
>  net_rx_action+0x1a8/0x340
>  __do_softirq+0x2b8/0x480
>  [...]
>=20
> [2]
> Unable to handle kernel paging request at virtual address 3938373635343=
33a
> Oops [#1]
> CPU: 72 PID: 0 Comm: swapper/72 Tainted: G        W          6.6.0
> Trace:
>  walk_stackframe+0x0/0x190
>  show_stack+0x70/0x94
>  die+0x1d4/0x350
>  do_page_fault+0x630/0x690
>  entMM+0x120/0x130
>  napi_pp_put_page+0x30/0x160
>  skb_release_data+0x164/0x250
>  kfree_skb_list_reason+0xd0/0x2f0
>  skb_release_data+0x1f0/0x250
>  napi_consume_skb+0xa0/0x220
>  net_rx_action+0x158/0x340
>  __do_softirq+0x2b8/0x480
>  irq_exit+0xd4/0x120
>  do_entInt+0x164/0x520
>  entInt+0x114/0x120
>  [...]
>=20
> Fixes: 069d11465a80 ("net/mlx5e: RX, Enhance legacy Receive Queue memor=
y scheme")
> Signed-off-by: Mingrui Cui <mingruic@outlook.com>
> ---
> Changes in v2:
>   - Add Fixes tag and more details to commit message.
>   - Target 'net' branch.
>   - Remove the obsolete WARN_ON() and update related comments.
> Link to v1: https://lore.kernel.org/all/MN6PR16MB5450CAF432AE40B2AFA58F=
61B706A@MN6PR16MB5450.namprd16.prod.outlook.com/
>=20
>  .../net/ethernet/mellanox/mlx5/core/en/params.c   | 15 +++++----------=

>  1 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/driv=
ers/net/ethernet/mellanox/mlx5/core/en/params.c
> index 3cca06a74cf9..00b44da23e00 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> @@ -666,7 +666,7 @@ static void mlx5e_rx_compute_wqe_bulk_params(struct=
 mlx5e_params *params,
>  	info->refill_unit =3D DIV_ROUND_UP(info->wqe_bulk, split_factor);
>  }
> =20
> -#define DEFAULT_FRAG_SIZE (2048)
> +#define DEFAULT_FRAG_SIZE (PAGE_SIZE / 2)
> =20

What else does changing this DEFAULT_FRAG_SIZE affect? Presumably we're
allocating larger fragments now for 8K or larger page sizes.

>  static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
>  				     struct mlx5e_params *params,
> @@ -756,18 +756,13 @@ static int mlx5e_build_rq_frags_info(struct mlx5_=
core_dev *mdev,
>  		/* No WQE can start in the middle of a page. */
>  		info->wqe_index_mask =3D 0;
>  	} else {
> -		/* PAGE_SIZEs starting from 8192 don't use 2K-sized fragments,
> -		 * because there would be more than MLX5E_MAX_RX_FRAGS of them.
> -		 */
> -		WARN_ON(PAGE_SIZE !=3D 2 * DEFAULT_FRAG_SIZE);
> -

So previously we would warn, but now we just fix the DEFAULT_FRAG_SIZE
so this warning is redundant.. Ok.

>  		/* Odd number of fragments allows to pack the last fragment of
>  		 * the previous WQE and the first fragment of the next WQE into
>  		 * the same page.
> -		 * As long as DEFAULT_FRAG_SIZE is 2048, and MLX5E_MAX_RX_FRAGS
> -		 * is 4, the last fragment can be bigger than the rest only if
> -		 * it's the fourth one, so WQEs consisting of 3 fragments will
> -		 * always share a page.
> +		 * As long as DEFAULT_FRAG_SIZE is (PAGE_SIZE / 2), and
> +		 * MLX5E_MAX_RX_FRAGS is 4, the last fragment can be bigger than
> +		 * the rest only if it's the fourth one, so WQEs consisting of 3
> +		 * fragments will always share a page.
>  		 * When a page is shared, WQE bulk size is 2, otherwise just 1.
>  		 */
>  		info->wqe_index_mask =3D info->num_frags % 2;

Would it be possible to fix the other logic so that it works for a
DEFAULT_FRAG_SIZE of 2k on 8K pages? I guess if there's no negative to
increasing the frag size then this fix makes sense since it is simple.

I guess the noted fixed commit limits to 4 fragments, but it make some
assumptions that were wrong for 8K pages?

--------------6vqlWkL8cnX7c2YgV30gtXnm--

--------------FHL8F0i5lo557C8lMnYcD04j
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaNxpJAUDAAAAAAAKCRBqll0+bw8o6B1W
AQC0RyRrvG+Vdg28izzeqY0rnYAZpD+uxAxVfvwjG2EfjAD/Xu7k+ys/U8cQvLjPTHVWCCGBL2YZ
IA65nCHqb3cE8QE=
=PqaJ
-----END PGP SIGNATURE-----

--------------FHL8F0i5lo557C8lMnYcD04j--

