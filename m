Return-Path: <linux-rdma+bounces-12374-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED2CB0CE57
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 01:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC7D3B8D8A
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 23:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022DE24888A;
	Mon, 21 Jul 2025 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyWO8+ib"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE732441AF;
	Mon, 21 Jul 2025 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753141355; cv=fail; b=aMXivcdo8cp9ugWssz1OgbYLTOCSM06t5iQH76rob2lesij2aN/4aiN3w3TffapiNYU5HtmDASE0BPuNYjt5wN7RBD4RfL0fheHnUvf2e4f2Ya9n84ZZGPZ/QpEQTHI+V5mWiWV0J6CS3iScwcYRXKinXEsD6XLtswK6CK2jbe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753141355; c=relaxed/simple;
	bh=qApd2Ilxvx3HiChINBuTSj/5ytkZglU9ZOaMLw9G1ls=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JJjSc097tHEXlhvCVPaNW1WTVUhuw1Kc0ObOHBrHLkFcWMGhB5/yujmXAzSsWf4+jMwSqHgoEYuRVirGLgNukFrKeXwPnDa9456S6wxikmmRD34UnK0z+WtMBjypWSsPm6LG7qcCUmQ/eCyvMyAikpxl22XciNuuxtHJtlIXL5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyWO8+ib; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753141355; x=1784677355;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=qApd2Ilxvx3HiChINBuTSj/5ytkZglU9ZOaMLw9G1ls=;
  b=CyWO8+ibWpW/v1DsjC1LfupR+KJWD3X0l8mRxCt9RGrSKUJ5FIHFuFAm
   Eq7iXdSY8kQ4S56sFIeI16z30Msyuhz3omyvX7MK9kNRtHRswsTqUPoZn
   cL0Sq9GqAgwCp0gmj8cSzhI8H3h+ZL2c71W9946NDG24/C+Ook9QL/6Ol
   yhIoNWN91FtmXJmnaHzFgoL1BiV3M8ozs6J6WA5fkS2/slyyI1emQojm/
   DgfTBWxjonV+9ebOqUmJB8+v+9/Wkywivn7DGJOZ4vpGIio7LqEljW72g
   dBYJBrK2yPMQNNqOMGvVJIRyOV9L7F9wEiBFguR5FPaO2/x+p523Xu/Bf
   Q==;
X-CSE-ConnectionGUID: LVpwCsMPRBSQ83QXCDAYJg==
X-CSE-MsgGUID: ERASWfBoSmWFFwCwDFQHtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55486328"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="55486328"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:42:34 -0700
X-CSE-ConnectionGUID: c+OB/nWPQvOX91T/obKLOA==
X-CSE-MsgGUID: 9gkQ7rKjTySyucmaCfte2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="189924787"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:42:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:42:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:42:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 21 Jul 2025 16:42:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUDH+Nm1K/VzdkRaejV9BPpXrCrje761TJ/vgR3JiP1fxgHvB8jdnCSlVTBFguNub5doLTNJDYfkqoParWTs7qtjRnnNHrL6BIknR8W0nE0pZ7Ch3LVtp+G8TK6RSf9v+jBsBZEtTDJ9DDqmK5nD0G34QRRJtHIkyU3pQZlw8krCtqxZZ67qd1KdniaxX4Eq3JgYQAy4YeMAzCXDK8yzWjDeL1JVIz4cxBaNAW+2/eE5bzi7JWLo/JIA6dJLqMKjkl9I5x/FhkTmlcHjPgN5hBlkJ3pSw8BTkdQ7Dlc2bDqI6ibnhu00I9hs/samVG5VEWtVZwl7tvUfkEOQnUflqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qApd2Ilxvx3HiChINBuTSj/5ytkZglU9ZOaMLw9G1ls=;
 b=FH+IKyop6vP3Tnbo/vOXw1yom9tsCfJ/XlI/wfeq9Ql55KacRcxxw1xsE9Nk3fT/pvL80m2vtCjkTzZv07FwFQ/j44m/43+eQV20FAH+071y97GL3CXdTX+nwdq0JRBoVjwTydC3CwmtYR//Mq4qOyou9v+rEb5BuUqYnC9JGLiOwbDIJuwitRIQXnlCuAHcKCrtVrTcHk7vBXihMT9SXe+IZYx17i89GjvuPE70ximarLWso44PwwS1XAKN9C/pdF4P2QrEbhgw/6dWOWcDckNUneGhtttvgKkUn/GBSdVtnx6nm3wIPJO4haHOp0alJRnGI1RAJjpHqQjKmmIynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW6PR11MB8391.namprd11.prod.outlook.com (2603:10b6:303:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:42:30 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 23:42:30 +0000
Message-ID: <1bacca22-06d4-4b22-99cb-2023cabb45ae@intel.com>
Date: Mon, 21 Jul 2025 16:42:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 1/3] net/mlx5e: SHAMPO, Cleanup reservation
 size formula
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lama Kayal
	<lkayal@nvidia.com>
References: <1753081999-326247-1-git-send-email-tariqt@nvidia.com>
 <1753081999-326247-2-git-send-email-tariqt@nvidia.com>
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
In-Reply-To: <1753081999-326247-2-git-send-email-tariqt@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------90ObT6dBLZnN5Hx06oetO0Nn"
X-ClientProxiedBy: MW4P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW6PR11MB8391:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6c4b85-f437-4548-8a8b-08ddc8b041f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MldDa3I2dkJpUWJMbVF4Yk9QY2MvYU9pZ2orOW9CUDNhMkppUlVXQWdVUmQw?=
 =?utf-8?B?MGluWHVTOW5leldaUkFnRHU0NHZtV1pBRlBZNlh4a2lvWE9KZWRaaVgrbnpQ?=
 =?utf-8?B?VXArL2RqV3ZldFRwSlR6UVY2MzV2VU54YVIyR0h4VGFxN0gveFVLVk9QUkRU?=
 =?utf-8?B?blU1ckNEZDFqMm91S0RmUGNNNG5KQmgzTDJ2ajdGVTg5bWR4dmJGV3ZhZ3ds?=
 =?utf-8?B?eXZFZ3J6Z3pyaitpd3ZLclFmLzA3ZzNBYzVHSHpRTWR1Z2RZSUpnVUlLcVMw?=
 =?utf-8?B?aXBXdDQrWXZiaUpudklsRnhIT2c4bEorOEVqRkowQnRQZ2JHVldQWmgvVjhV?=
 =?utf-8?B?RDhsVEtiR3NJN0RYd0x6dVVSWjB6aHBqb0NWT3VjUzJzK0pYcHlwWER1bEdt?=
 =?utf-8?B?dHlSRTh0S1BjaE9HZ3I1Z1VLOUhkMWZta1FBbDJkR3Y1Mk1iWFdXbThUZHF0?=
 =?utf-8?B?Vnk1Y2V5bnoxTC80SXBlWlpiYkUrZndZVmFoSHMyVFpuRnltZlNVV1ovU0Jt?=
 =?utf-8?B?WTZYNmE2dG9MRWhyZkM0Y3JVbVRVMWhVTTRnN0FPaDdDWkNhTWtOdWplUWxt?=
 =?utf-8?B?N0tSNC9KTmIwSlBRQ3IvVHNtbzVxajFvaFN3WnRPdWNqbS8zTmRSLzJONHRU?=
 =?utf-8?B?VkRENENwTGdBRi9pS2xXUG1tcFJjZFp6ZS9FN3ZjVXhOVzBCSUQzTXR6Q01Z?=
 =?utf-8?B?YzRJcmpCNWNIY3NPdkkxZWYvTU5mUWxEbEM1SG4rdFgzQTlLZU9RQTZKV1pM?=
 =?utf-8?B?cVkzTFdSUDFpSmJ4d2tHOVRwZXU0RU16eEZvMkRQRUl3VGN2cGZXWWJQY2Zy?=
 =?utf-8?B?ZnlqR3NuNmVmeHUyMFBVYk9Dcm5Jclc1V1RYaDJHZXQ4dUtHWEtTYWEvR1BY?=
 =?utf-8?B?RGF5TmlBYTl5MnNOYW9NZXgxNlVrdkdUd1JtNkFqYm5OdlpML1FlRlVKbW1m?=
 =?utf-8?B?bnlKUFFVRm5WRXFGUFQva3daRFRBZXhPSnVvSHhSbkRYRk5iUHk3ZVdCcGRr?=
 =?utf-8?B?T25nRURnVTQ4TFhqQWhHcUZ0cEswVUwwS2pzeEZ5YSs5SnR4azFKZDQ3cC9Y?=
 =?utf-8?B?Z3MzU2JLYlE0NzVZZjBQQjV5ZDByK0w2VG5jRFExTWpYdFJJeTRnODJrRnJF?=
 =?utf-8?B?NG0xMFh2c1V5QXkzWEVBdG1KZ0RyN2lXV0VXZUtvcHhuam9kT0NQOGpIMUVO?=
 =?utf-8?B?bzkvTjU3ZFo1MTlGc3Bzd1FNNlNSTW55ZzN5Skh0dFhQZFRoUFZkdjRjWm9I?=
 =?utf-8?B?eEVqbHZqaDRSYXFCblBBMlF2OEQrU3NUWW5PSTJjaWRKV3dDc3Mra1NqcEhW?=
 =?utf-8?B?dUlYdHRSZXpkcm4zNmkxdWg5UG9maXJndHBYZWt2dUo2UFlzbUJ0blV1dlRu?=
 =?utf-8?B?U1E0NGNNL21mNHcxNnBVZlo3clBpQzYxWkRWWHkraFlPdnBnK3FoZGF1Zjc0?=
 =?utf-8?B?dURNR2hkWW0rdldPK2NCVWdCMUlLdXN2bzBUMlBJNWlLYTd0MzdOWnM5Mkhn?=
 =?utf-8?B?MXo0NkhxbnVuR2VlWWtFMk50NkRpbWtCWXBEYmNpKzRqUksxdFFBaDd3WWdH?=
 =?utf-8?B?ZFdKRWlIbW5BVjIzeXNDbzYvU1JIR0Jkb0Q3MmVnd1dEcHZRdjR2VndqaEpG?=
 =?utf-8?B?bWZoa281YW9yZjhHZXFDZUlva3VyaVFxTFNhWlR2VlhvL05USEJ0NkJzNkVo?=
 =?utf-8?B?bldrUXM3OFp5TEZSd0pmblRLdVVTbDZoT3Q1V05OUlJ3RkpOdXdVK1hFNHNS?=
 =?utf-8?B?VEVSSmRUMFRwelVhRFEvY0dwcm51VzU4NVB3U3MrSTNKTEVHaStKN0UyTzho?=
 =?utf-8?B?cC9FNmc4WmZucC9IbEpFc253S2J0cm92eHZEN2grOTJmZ1QvaHY2OVdWQURC?=
 =?utf-8?B?UWZsRFVKd0pybWFLek5nQTlaRTh3aS9OWWZYSi9KTU0wOGE3M2hUVUJaUktH?=
 =?utf-8?Q?OxJ4L1jlk7g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDNyT3ZKUXg5bUZSMm5OUURtMzA1ZS9xRGRSODVqcjU1Mi96ZS9YazF1M0tX?=
 =?utf-8?B?a09UMm03Z0tZaGh4RHM1NUVPemF0K1dnSlFhSXZxVTE1NE5lTHNEcWt6MFRl?=
 =?utf-8?B?b0tpOXhsYkZCSFFIM0tDRjhyQXNUOVAxdUI1UllFcHJuNEQ1M2JZL2x0T1hD?=
 =?utf-8?B?cStMVjNmN0RueUI3SUsyYVEzM2JxM2J6djVGV0tEb1QxeU1IQWUyRXBDOFVS?=
 =?utf-8?B?bXlqUUFMZ3RUcGNSd1UwdFNScUYzT1NjUmRTNW1LR2c5aCtHOFArRjVxeWJF?=
 =?utf-8?B?cis3bllOb0YxVFFvdXBiMm1WeW9ucnA2MGd4RFFLbG1ZNEl0U2FDNGlxbS9U?=
 =?utf-8?B?NHdLdHRzQ1FoL2hUNENFUGtXS214czR2Nm9taWVpOUJWTUp1R0NBUWYxVXI2?=
 =?utf-8?B?SndvMjYxMWtKZFdEZC81V0VWVWJkWGZOaWZBR01pL1N3TjVuSUxBNTNGMDcr?=
 =?utf-8?B?SytJUDNWejYrVktLWnk1aVBIZ2dIQ2ZSdnBKNHpEKzN6Q3BnT3RtME9nY1lD?=
 =?utf-8?B?RXlYUEtYWllxcktHd0ZuZGozeXNpNmJMNU4ybGtBRGxRUjBVQnpVRGxBUmNs?=
 =?utf-8?B?YWM4THdnbDBBcHVpMFIyYWl0OFpmS3ZHZ1JUQjdGdTZES2d0S2lUZ3BNelZi?=
 =?utf-8?B?K0pDRGpOUHovZmZYeDV3d2NvZFd3V05od0tqUzNkS3Y4MVlQRC83NHkwZ2t1?=
 =?utf-8?B?ZkoxeDdqR2FDeUVIcGVuR083QmJ2aVNBYjFsTTc2M0tEUG1uY3VVbW51L1ZR?=
 =?utf-8?B?VG9nRVRvdEN4L1JQQzFtZHRtK3lETjFUOFdER2s5djVyUTdOajcwWE4zZmJC?=
 =?utf-8?B?cEk3QkdZc0tKTlkwVTcwWXR4WUJzNDVSRUNRaFQwS1JjMHBrdnRLKzNaZXNv?=
 =?utf-8?B?QkdLR0c1RS9zZkRPQjFpL0VFN3VVblVabDNFRjZGODVRZWV5ZElmY3FBMytQ?=
 =?utf-8?B?YXY1c3c5RjA1WlhOWExta3h5cGVlNHJITGVyYjJCcVlOdmZ4dFlnTnE4d1hD?=
 =?utf-8?B?ZFFMTnhXK1pabFR2Z2pJdkpQc1hrOVJkMzlqbFljY213Ny90ZW5wSzJRU0h5?=
 =?utf-8?B?ck5EekVDcWZkNUo3aW1FVXJwWnArbmJrcThJa2JDTmE0UG5PSkdaYVJhSWs5?=
 =?utf-8?B?bXlGb1NHdndkdHNQNXpzeU11UTdRWDRWVURHR3JISWxSd2FsUmFyNzJ3UDZO?=
 =?utf-8?B?RHl3MlBtT0JHL3R2aVdEKzdYVXcyUEsyVTFmcFNCUHlFeUlrV2k2bFRtUE5i?=
 =?utf-8?B?L0xXUERxNkxiL3RReFQ5cU1DUWJuWUg3WEphK2xuOThIRURTbDBZbXVoQTJ2?=
 =?utf-8?B?Q2hwdUFQQmdCWG5QUTZFdTZ5elg1VDJCZGhXdnduWnRZYXZueFo0cjBBb2VO?=
 =?utf-8?B?bXdHMU5rcll0MWhmTVNnRnJZbVVpSUJLM05FTjI0R0lXQXhYU1d6US90QWti?=
 =?utf-8?B?K3dQOUMyQnh4NHIwcXovOXJkOGFTM0hLRFZuMCttcFBPKzhLcjliNXFST2dn?=
 =?utf-8?B?RExtV0p5UzZjUFh5a1BoSjA2QzFuMHpmR0sxa1hCbkgrV09oWFQyZjgwa1Zw?=
 =?utf-8?B?YzdhRkE3NmVKTkFsUnpBd1Z3Kyt5UEVTYTFrUUovZmU2Rkk2OFcyOEcxd1Js?=
 =?utf-8?B?SHdsTGtiTnRPVWdpd1AwTG44a3Y3RlZ6TUxnR1o4RlBlMklhWkt1QVE5Qm5h?=
 =?utf-8?B?Y0pyT0ErMmFhdjFNNTZDOEJZbTI5TUgxbzgwV0tWQWVsejlBWnJEWWtGb2Jq?=
 =?utf-8?B?UW4zN096Mno2dm1PeXZhd1hZVzY0MmdxL3pUdWo1eXpaKzNwa1daNm1zM0lh?=
 =?utf-8?B?VUQxaTR6bEdyM09xaFhWY0paQ1VVOWFNWXpDczUvdXpnSnVxUlRRaDQ2MUhT?=
 =?utf-8?B?QmhtTUg4MEMyNDFhOTR5a1IvM2QwV3BleTJuSmowbVhyaW1iTEIrQkY5b0M3?=
 =?utf-8?B?MzFMRjVUaGhXZGNaZTlqRVJXOUtTVjhqWjNzSmFURFVCTTdBdWtvOUFyZ2xQ?=
 =?utf-8?B?aGRneDJIUWxza2pPcTFRMXZCbU9GeXl5aUNWZU05YkVjOHNxSUlsWEh4WS83?=
 =?utf-8?B?bmU1bmFGNHNRdWl0eDlOdTMxZDNtellhaEJudnY4b3FSczNzOU4vU1FrejlI?=
 =?utf-8?B?cnpzaGtPRXhXOEFTQnd5YWlnbjRVT3BWOWJnSmFnKyszb0hudW9IRXkvMDda?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6c4b85-f437-4548-8a8b-08ddc8b041f8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:42:30.4944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KejVOvMWM+zUXLqXCXreZjGmNLPJfWsSNldbj3K8M4PR1WbUvlkDK+prlpw/v2a1X2XQKAho9ZtP2rJuYK2ub38+KUPKJ9/cynU+WAPw6Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8391
X-OriginatorOrg: intel.com

--------------90ObT6dBLZnN5Hx06oetO0Nn
Content-Type: multipart/mixed; boundary="------------c9AyhRwTeXRG0KJRqBifQz9w";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lama Kayal <lkayal@nvidia.com>
Message-ID: <1bacca22-06d4-4b22-99cb-2023cabb45ae@intel.com>
Subject: Re: [PATCH net-next V3 1/3] net/mlx5e: SHAMPO, Cleanup reservation
 size formula
References: <1753081999-326247-1-git-send-email-tariqt@nvidia.com>
 <1753081999-326247-2-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1753081999-326247-2-git-send-email-tariqt@nvidia.com>

--------------c9AyhRwTeXRG0KJRqBifQz9w
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/21/2025 12:13 AM, Tariq Toukan wrote:
> From: Lama Kayal <lkayal@nvidia.com>
>=20
> The reservation size formula can be reduced to a simple evaluation of
> MLX5E_SHAMPO_WQ_RESRV_SIZE. This leaves mlx5e_shampo_get_log_rsrv_size(=
)
> with one single use, which can be replaced with a macro for simplicity.=

>=20
> Also, function mlx5e_shampo_get_log_rsrv_size() is used only throughout=

> params.c, make it static.
>=20
> Signed-off-by: Lama Kayal <lkayal@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------c9AyhRwTeXRG0KJRqBifQz9w--

--------------90ObT6dBLZnN5Hx06oetO0Nn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaH7QXwUDAAAAAAAKCRBqll0+bw8o6I5q
AP9f3cQ7GdNVA4AEEGxE5Ig3UKbQZCw5bwR3m49s1LtltAD/escmpjYJsrxBuLZbQDRsxamGOfyY
lRquynPlZziOpgg=
=WFcD
-----END PGP SIGNATURE-----

--------------90ObT6dBLZnN5Hx06oetO0Nn--

