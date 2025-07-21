Return-Path: <linux-rdma+bounces-12375-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F6CB0CE5A
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 01:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C09516E29E
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 23:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A0324678A;
	Mon, 21 Jul 2025 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kx8hD/Bp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF26D246770;
	Mon, 21 Jul 2025 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753141405; cv=fail; b=Z5oRoJXlhqUI8J0WpHrLfd9SS/QJgHwhCdhasUVFp2uVJDHfuqLoT9sVYnYB2bPfUJvnkyq8Xkyz+5CysYLxSiax9lGbOqroGPnrepZ+vu6ZJTPgnH9IXhYJZ48qaCt/DEgDuPolPyK65Sxo4zGTPwJUwThHT1/RH1FXXl65JUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753141405; c=relaxed/simple;
	bh=6t61kh8f78PWg4ORMwnj1c87oY3FmDisCtkbEoRLBOw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V8KfI+ZeVPaBIxFQH5rZjb4tGDHV2KCiweHHPKOWg5Zrh1KAhrJbOzeBZsrCNAlkCSg1kwQIEJ+xA0tyfDVRgWvMvygAN5wkRTc6KNexIEcAwRGvAVGOvWzIKwbmR+tLhrGrbUom7uHm/030soAoga2gGkMM2QE3Wnk9O+1f0l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kx8hD/Bp; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753141403; x=1784677403;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=6t61kh8f78PWg4ORMwnj1c87oY3FmDisCtkbEoRLBOw=;
  b=Kx8hD/BpSswRLhqJZ7S3yXacFePwMlFcAXUB+nLMqGlExNoSzOhNCnJA
   zsWYK3d7HXZXP16Rr6/qOEQrx1OSi//0xFvt7DozS78C0xZsJtQn5HcT5
   njMDoY26rq12gbE9kpOuu30CS/UVLXPhkM9Gi4li4bq+OH5x0sByDs+lt
   HvGGco4Qgg/S4/kLvwew+apKWRk3JD5z0r79WQ4UrNfiN/u+0rCFxoy8j
   mSNkzAIjEpVStxfCGg9mes7ms6nnBje6KPTTt7NqiqP0j1r9kAChK4QhV
   k+slHIC/v2j5pQIW7VqQKF3fEUFWYvrv+Pnh1D12blXxggRXLcSzHgRJw
   Q==;
X-CSE-ConnectionGUID: K3UEhHtyQ9+/uEnWtbav7Q==
X-CSE-MsgGUID: 4w2m4RufQ26bnzYFN0gNqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55525038"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="55525038"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:43:23 -0700
X-CSE-ConnectionGUID: Ip25VB+ZRkSKzcGwiPFG6g==
X-CSE-MsgGUID: WyrJaEXkR/GqLGm4TamYlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="189925030"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:43:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:43:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:43:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:43:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUzwG/Huip2cfIcx6L8fUpP8qElsGuYfzx4qMDPkVSKYyaxZp95qSwAXKfd95zbw8kq1HZquaquUWfhWm2kP8RmO1U1XDRFxdDIxwxT5vxs4UDLQQawZszj2BUn2mZ3oZHIqnBsGMnhtDsn+BgPQueGw+8cq7hEtv9l81SwGOZa3orKN7UsZEindjFD3xAB5B5WChvo5oNKdTNC7wfZzVQLMFC3/fLz1/8muNW8fmFO5486+c/UpT/Omv1BckiTNW3bcwjiZqm/5JhYZuYqf651O1htUegVIRig81HzhpGA/8maMu7UYsng9XbokAgZakubPmkqpFZy4IcatoQcu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6t61kh8f78PWg4ORMwnj1c87oY3FmDisCtkbEoRLBOw=;
 b=v6FZKT4N53Niur6KI81u1cxhEa3juLuQ50w0TYtvYN5wfBvLDPxS7m5EOCHHT9pBW1Ry4t590XAHZhdWjvGsVTo9L/LvEfjKaI5dePKJml8OPvCJ/hIvc05qFJFTqFZTJEyFt1zhgwJOWjTJBTTwtg2zv4PBajIlGLkNk3UiZBYT9n4x/Djw77ZIYF6LmvI0SIfT3PMixetWFJvkQa3hYiPcgSv+CdBICbE4qxKrKK3oGdRH5QhYNvQygiPUVHpPyOOkdY38FVfvNygEEdmyJ66V3vLr4u2VCJVgQT1oApImUyo+BCGWFwELVaRPYIRxk9deHqkSNjR1zvSTDIMh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW6PR11MB8391.namprd11.prod.outlook.com (2603:10b6:303:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:43:07 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 23:43:07 +0000
Message-ID: <64d23ae9-cdc7-4cc9-a0b2-782ffcc27e83@intel.com>
Date: Mon, 21 Jul 2025 16:43:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 2/3] net/mlx5e: SHAMPO, Remove
 mlx5e_shampo_get_log_hd_entry_size()
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lama Kayal
	<lkayal@nvidia.com>
References: <1753081999-326247-1-git-send-email-tariqt@nvidia.com>
 <1753081999-326247-3-git-send-email-tariqt@nvidia.com>
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
In-Reply-To: <1753081999-326247-3-git-send-email-tariqt@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------2NBXpiPAKLkId67bkqVeEoDY"
X-ClientProxiedBy: MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW6PR11MB8391:EE_
X-MS-Office365-Filtering-Correlation-Id: c41de670-5a62-4e6d-8a93-08ddc8b057ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c01XSGxNV0FuVFJoSFNxa2F4ZUljUm1EdkgvQ1lGTlh6Tjh0VjRnb3U0OG5P?=
 =?utf-8?B?RWxnL3E0c0hDL3Q3RkJ2R3paQlpJL2xiZ0R3dnVXdCtsOEo1b05wdU1STm9O?=
 =?utf-8?B?MVRuTlpFVEd6TUh0OGRRc3pUVnlFWHBHb0pBbENwWVFSNmVmNnlxd2dtZTBM?=
 =?utf-8?B?dG5LbW5uekI1VTRRZFVFamRVRGRuMU4yMFFKZG9VOVcwQmJ4bU5YVzBoRXV0?=
 =?utf-8?B?ZVVlQ0dRV2NmMFRsZC8zSHppaUVwSkhGckJTUHZ4b2dEM2ZoU0p0YlVROGVt?=
 =?utf-8?B?VUdVWkZwU21WSkZ2NmY3VngxdHRqVC9HbjJWYXU5RWlLZW5odnhLWXkzbEg2?=
 =?utf-8?B?bG1seklvSHlMSmsvZXBnZmJmaU5LclIyZzlXRkJSa3dZd2lkd01zTVpid1FH?=
 =?utf-8?B?S2liUENRMkU4SDR2bmRPc2cvUVFXN09BNkFtU09sYjNQNFVsY0xqUENFQXpt?=
 =?utf-8?B?dWpDazRGY09xQ0lJbE42Z1ZTT0NKYSs3dnlvTDZ0M2dSdDFsQXJGTEJicVNp?=
 =?utf-8?B?MXJvVTZLZ0hCQ3dJUS93bHJFYmRWRDhTZkQ4SVNWY25FUXVSV1AyenNIb3BD?=
 =?utf-8?B?QUtYUFZHOEo4SDNoVW90bVlMTEdwUDhqbWZ6SnJKbVFtd3B1c01oS09jRHBa?=
 =?utf-8?B?RkVGclhFTWwrZEQxNmE4R01sRksxZS81OFJkVHM3MFhSaVJxVko2K2k4TmtS?=
 =?utf-8?B?My93bVRCTFVkZW1UbWpSbTFsV016S2xrc2VSNjVwb2tpUDF6L290QWp6ayt2?=
 =?utf-8?B?bnFqWXhzZnBYeVl0RXNIaE5RUkgvSk8wTHpYeUY4a0txUFB1S09BWXlKSXpz?=
 =?utf-8?B?dEN2cjVoekJXZ0luMjN0dk5BSWhzWXR5SzBaQlhNaEJDSFI1U0wrVW1WK09Z?=
 =?utf-8?B?Z3RsalBSNG5iMlpxemw0QXpxREkwdzdleWprcy9HcUp0MEJzSHY5ZU5POHkv?=
 =?utf-8?B?UXl1QmZIMWlwRHVLb2dKWjYyL2hsMGhVR0VSWkJESTF3Y1RyVVpMbjVEKzlL?=
 =?utf-8?B?cHJKVmpaVzA4eVhCaFZ0akFoZjRJZklaN2l5Q1Q0SG9rMGNlRlZrQnJrZzRZ?=
 =?utf-8?B?c3hRMjg2dmNRUE8xVUhDOWhkTFcwQm5JRGl4RVRyb3MzSjVhYUZScGRoK0hV?=
 =?utf-8?B?aHFWUzJWUXcwbGZPY01CVGZtZSs0c3c1eVpzWFJXd3NxMFFRQXZFZXpoQU5K?=
 =?utf-8?B?d2lsYTl1MHFCa1ZrTmV3QzJSK0tlUUhlVktEdndkZW9UOXN4c3ZmVWVxTjlL?=
 =?utf-8?B?b1lpMDdKODJtNEFRYjV2d3JpRG1qRnVacVJaRUFUQ0p4VnQ5dTNBRnh0Wmdl?=
 =?utf-8?B?bWpxN2xHMTJranNmZFo5T0pNMjNlVzYwOG5PL3pNU3VKK1piMmdnS0lmTXEv?=
 =?utf-8?B?K3ZOSy9LUWZVSXJDbW1IUXNBRlYrWmQrTlIrVFU1RXl0RDlTTWhuYnJ5N0lZ?=
 =?utf-8?B?YUFyN1FsSDVFSk5UMzJOeHU2Y2ZDR2NQN2VNZythSk40ckY0WFdlL29YaElo?=
 =?utf-8?B?aGRLbHY5TXI5ekw0Ull3VFRCOEltOWZnT2hCdEQvMERlbXF6VjR4SDlzWUdF?=
 =?utf-8?B?aEhUTlBDSm95aE13c2dnZS8zVFNod0RrblZORUZUb3ZoV1YwRzlCSU9pdE4r?=
 =?utf-8?B?djFGWnEyU2I2OWx1ZWZld2xtSkIyblRBSGxBdVhwbXZybzJLdUd4bTdiY3Js?=
 =?utf-8?B?eXBpTjdUVHZkU2Z6WE8zcktITFBjanQwa1ltc1dRZ2RRdnpFWWF3VUptS2Fj?=
 =?utf-8?B?VUhnbWhHVE9rc0dyN0tsK3FYUnZxbHhIMnh1M3FuWkljNkxHNUlKNXBOdXZL?=
 =?utf-8?B?VS9oZ00yYnpMMzd0VndsVFdFMlpZc1dlZ3RmNGxrZlQ1SXRSNGFhM3lRdDRI?=
 =?utf-8?B?MmtuMk5RejN1WWpiS0pDYnpzSFdKMVh2ekZzWVBQRlhWRGhTbG9sbU9XQjJU?=
 =?utf-8?Q?U4d1p/sw1GM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUpvWUg1YzFkazdXMTQySTlRUmZ2VnU0RzIwNDM5SzN2M0xaUmdyaUp2M0l0?=
 =?utf-8?B?VkRrVTlqZHRZcUdDeWVuc3VaazgyNEJ0cmQ5bWF0ZnZQaSsrUmU1NXV0ZWJ6?=
 =?utf-8?B?NDBQSXdVVjQvQU5zR0FUbE1wV29rWkZEeTg2dEhZQkM3SVkzOUdzZXcySEht?=
 =?utf-8?B?ZkI2SWVaTHU5K0NFODgycG9sVmZEaG9OQU80UUdpSjAwRCtxR0FUeFlGVEdr?=
 =?utf-8?B?QVlocWtqTWEvNGxhTWRHMEptZ2RKQXRCNjZqOWtnRlR0TXBURmJ6K0dUcEdt?=
 =?utf-8?B?c1RKQ2dpUXpQYXJpbEhrY0d4aEhodEo5MDFzYWpoejF6V1Z1aVorTFNMUGl0?=
 =?utf-8?B?NkJSZ2xHRHliWEdDYmVaQVpiUHlRT1hxeU5iNkUycno4UVd5dzVaQzh5aEV3?=
 =?utf-8?B?eWtHM1laT3h0N3RjNHg5TS9XY2x0Vnk0OXVHMnFYRklQazBEdUZTdEpkVTFo?=
 =?utf-8?B?Njh5bFRrdjVoMXpMaGd4ZlFoeEVDYUxWUWxTdXNqeVQvMzdzNk5aenl5WnJJ?=
 =?utf-8?B?UDMxVGh4aDVRUmNXZmFkMXh6Wks3SUI2Y21wZ0FCeVBOdkczVzJPbnFoN29V?=
 =?utf-8?B?UVpJSm1oMkhKa2hlNnJoNVR5cW1DRnV3K3FUZGk3d0tkdGNONTB6MTdaK0F0?=
 =?utf-8?B?WlNuQlRSUVlkMmFGMmcxdHoxQ1Z0cVh3VmF3MHhOc3R1RFV5OHZta2lKYytz?=
 =?utf-8?B?NVgxZ0hXS1Rvb29YaTJvSjdlcWJlWEtSOTJUSVF6ekxLbVdKMXdBT21UTmFz?=
 =?utf-8?B?RDhMK2E3cFEwUnRDT1MzMi8vNDg3dlFRU3FGVG56K2FZR3pNbUQ1VWtDRi92?=
 =?utf-8?B?NUJjcUNIdlJKVU56TEpVNW5vWHZjN2lBQ2Q2K2lGM3RIRlVvWlRFOFBSemhq?=
 =?utf-8?B?eERINER2ZDI3cFYrUW81SW93NjFhUnhydFN6L25JVFhVTXNFeTZCN2VtbW0z?=
 =?utf-8?B?Smk3N21yeU83TFd6b0lNK2FBTU9KTDUvN0JuZC83L0d5dDBTaXZ2WEVNTGNM?=
 =?utf-8?B?RUhoUDd6VE5RMDhQclZqZXRWZTMxNnh6U1dHUHU3eFFQT3dNZHBmbUFlM1Vx?=
 =?utf-8?B?dDV6UmFiNERqenlDdFpGbCtYbXZXeWNCSG95eVNCRFVydkZSUkZabUZwUE1C?=
 =?utf-8?B?dy9YV3RyeTFKZEUwWGhGYnBMWTBHTGx5SFh1OTVhUjVybUZwdjhnUC9TN3gy?=
 =?utf-8?B?Tzl3UWZ5Q2x3SGRsajN4dUE4cDFiM2huYjRha3dsNmh5bC9kOHd0VWxYTDJP?=
 =?utf-8?B?NENHaGZYdnNLNkNpbk1MYWMzeU8yU3pwZmE5TE8xelk2Slh6T1EvOGgzdjFR?=
 =?utf-8?B?S2pob1lsSno5RHYyTzVneTBKWWNudTZuUy9hdWVocHRDaWpVdUhnaXJzNldJ?=
 =?utf-8?B?TnB5U1daN2FDU1pYdERKeWZoOWJjbmZQSlZQU1NUWGRIc0NSaTFINnJSVGVa?=
 =?utf-8?B?dDE3YTRkQWo2MHFkQitNOWpDdGNoMGVNdTc2Q1NEcW5QOUxIMFlFNXIvVExw?=
 =?utf-8?B?dlovWTJ0VDVyTUVmWXYzanFhcjE2RHdnRGt4MFNrek43d2JjZFJyU0paS0dy?=
 =?utf-8?B?STNSTWdLaDBxOEdvTFBsQWZmSG9pUEFBdUpQajlhVFQ0dG5COXkvUmtqaXlY?=
 =?utf-8?B?a1ZwbERpcGhlb05UVGdIRHErQkRpb05Jb3lqcjFBaDBiMkRyL09lb1FCNHZL?=
 =?utf-8?B?aTgzanNGNlJpL0NxQXNEaUlEaDJVd1dSTDhkVDdNWjdFa3NJQ0YySFU4OWc5?=
 =?utf-8?B?L0h1TkoyRVFING9zb2Z5eDVHTjlTemVralRLdHJBNHdza0pEWU1MdUFmZUdo?=
 =?utf-8?B?U00rdzNqbWR1UkNXREVRdFN5VlVBamtidG1aL0cwWjAxN3FZSXF0TC9zaTcw?=
 =?utf-8?B?ZmRWMjE0QXNPN0RqZW5lZnl5V3dLS1FuMlBJZkpjamlrR0RZYlYrTGNBQVdU?=
 =?utf-8?B?eEhncjFkbTVPdkorNTNOeW9GOG4rK1RmVG9WYkhlcCs3M0hUR09ST1Z3WW0x?=
 =?utf-8?B?WVN1OHJIK0Rub21TRGJCZ3ZoZEdQMzZJbVMxNWt0MWxnK0NUTHBlekJuNEJB?=
 =?utf-8?B?bUNncXNZSHVUaVlRREsrS3dnR3lQZ1VBcXhqenN4NU1CRmdwMnQ4ajYrRlFG?=
 =?utf-8?B?c3JDSGxTWXFZTC9URERQM2wvdUpMTktwNklDMFZVTkEwMWRYKzYraUZ6Yjdy?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c41de670-5a62-4e6d-8a93-08ddc8b057ff
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:43:07.4050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsJpf3VInptsMy6I7DYy6l60Kd2ctfG/Q/D/P3OqTGgSQ+J1/wMGKcRXNlDQrPMoybqOxxdYArMcZcaXXmhFnajRVOxPBFV8GdNNIbQWjAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8391
X-OriginatorOrg: intel.com

--------------2NBXpiPAKLkId67bkqVeEoDY
Content-Type: multipart/mixed; boundary="------------9pLg4ki1NRJ4W7an2Jfd1IHj";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lama Kayal <lkayal@nvidia.com>
Message-ID: <64d23ae9-cdc7-4cc9-a0b2-782ffcc27e83@intel.com>
Subject: Re: [PATCH net-next V3 2/3] net/mlx5e: SHAMPO, Remove
 mlx5e_shampo_get_log_hd_entry_size()
References: <1753081999-326247-1-git-send-email-tariqt@nvidia.com>
 <1753081999-326247-3-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1753081999-326247-3-git-send-email-tariqt@nvidia.com>

--------------9pLg4ki1NRJ4W7an2Jfd1IHj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/21/2025 12:13 AM, Tariq Toukan wrote:
> From: Lama Kayal <lkayal@nvidia.com>
>=20
> Refactor mlx5e_shampo_get_log_hd_entry_size() as macro, for more
> simplicity.
>=20
> Signed-off-by: Lama Kayal <lkayal@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------9pLg4ki1NRJ4W7an2Jfd1IHj--

--------------2NBXpiPAKLkId67bkqVeEoDY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaH7QigUDAAAAAAAKCRBqll0+bw8o6JA+
AQCq6ljwA/LcIIJTwWIGsEtRbaNk7bltOvg1jHaDmPTNLQEAuqSoh9sDw34vT36S21EJKc0kPpie
8nz6PSvRj5Qa5g4=
=7Boy
-----END PGP SIGNATURE-----

--------------2NBXpiPAKLkId67bkqVeEoDY--

