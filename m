Return-Path: <linux-rdma+bounces-12037-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F72AB008C3
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 18:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE395A5B7E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85CD2EFD8B;
	Thu, 10 Jul 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyiAUpb5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F432AF1C;
	Thu, 10 Jul 2025 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165021; cv=fail; b=Y4uCSTrwvzuj3g11JBW2bu56PA+x8vDhHVFbPv9ki582Z7I7Vyt55ro2PNMtGBobqTIVuQMOQl1Ad/VozKtaqo6Y2mhhKUh2EcTAkMeJGocafUAKm3Rdls/FSdyIpWzhjJmAced86Lchq6AVAAx5cGk1JwxAcgW+mTxLnfodR6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165021; c=relaxed/simple;
	bh=YVOprMVsODg6dk+/NY9ilBmRAEQWll6blh80zmpNfVA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u6LtF/NsBaTJ4fxUjGRa52r9mSGRE1PiMapvMmUD54Dn8QZoXPuS1wA3wLx6IPbCyFW+b9rvDyPyJmycEthijHtDEJcFn51QrZs3fiPLdzd9q3EG69NqdY+ql4StzdLe/qItcSCtEgFw+XJ1pM0GJj7Tm3u0zF0LWtlULgGDmlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyiAUpb5; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752165020; x=1783701020;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=YVOprMVsODg6dk+/NY9ilBmRAEQWll6blh80zmpNfVA=;
  b=CyiAUpb5OsQWTYH463fYKMllfoKrym28WmPCghXXW12AKQNClCXZQeBT
   gdloSANcoXDOf5Z4YkS8JZhqTEU8TI8yf7zFyejPv3Avi5N78m6frVs0v
   cdhaHovgpk4LO2kTftYQ7KMlLnaWw5U9VWaklLxBzzpOMSOY/Vksnt1Dw
   aMj/hrVpxwxkK29wiNKCSnVjZy+dfyflETRIaAGBsmvcA4QjvEeQwfTRu
   PEMhNG0EooqolWASdEhTUJkVZSahFh1UZPc3E5vg3ItracihxFO3gGLcZ
   OJzU55DjEUkucct2Y9CYEITcUR0b+ho9f2GoWLirmdn0pIGBAdtMoudTY
   g==;
X-CSE-ConnectionGUID: 9rr0L55jRQSj6XmXuHpl+Q==
X-CSE-MsgGUID: AE1HycQuSPOtnrItTexMcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54304674"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="asc'?scan'208";a="54304674"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:29:48 -0700
X-CSE-ConnectionGUID: YKeJi3xnStymd+lMbqCfWg==
X-CSE-MsgGUID: 2MNI3hmGSoOcfTlWnfhuPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="asc'?scan'208";a="187141042"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 09:29:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 09:29:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 09:29:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.74)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 09:29:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyF32ewCSN9J2X8zunjIuVfBbJK9E24potEAWBS6tWTK6i8ug3ekP+WAiUcj8gv5+kNGO6XGmCzeKNdf+3/rCnpjVzuz7etjlaMN4pC/rpuvTvKLYPVI+yQzAxp3kUKv88G23UDrjgD8aH/evSk80PEVW/6AvGaIBWPSzYMeg3GDULaDvX+dB/PtN3pqavdnMiqvGsu+usAH9fXfxtstw9b+N+GbF6WrKfQGJDBrnWQ06rtfAe1Q0sS8mSZwygyKp0xHbX5IAiPmcwtztf0RkeT9uftZOTX+mBqZF7DktfSsbgelxwmaHMpTqIPwhWlfxHvm7fg6rvViFfV5D6/nfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEJD6zNOIu0BoNdZ2Hezt1PfBcbVPMUf9JLQ8wmZPvo=;
 b=SU2hsify2bXgAtYpmMcWlE0op2orIy6iXpRvb8hZsQuAKCJLlsxHOT9nWytorLvrrRvK824FyxBj+kWByI8QRBuJEQenRiSgg2ysZ2CPZV3Ep4dYaZ57kXyqfXel+Kp5NNIgjXfIMXOO1lhkhEcIWwsjyLL8cA1j+2kmU/ytkmn2RRHn09aC6R/i5OKYhaPkq+PEFCPWgJzMROlZnj/EAXLz6TtW0BiwWtBypFpwcByas0Ou4kIE+S40AYsBmfdGeFLKV9v+bL6WMqS/y76t8ymLBcw6KcnEGlJb8fcyXhtUsK6Bvu3d16c28TddD116DqCNSjU8P31r3SxAQ1gn7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN6PR11MB8172.namprd11.prod.outlook.com (2603:10b6:208:478::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 16:29:45 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 16:29:44 +0000
Message-ID: <0f0afb12-14e4-46a1-9d35-fa304f861503@intel.com>
Date: Thu, 10 Jul 2025 09:29:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net/mlx5: Reset bw_share field when changing a
 node's parent
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>
References: <1752155624-24095-1-git-send-email-tariqt@nvidia.com>
 <1752155624-24095-2-git-send-email-tariqt@nvidia.com>
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
In-Reply-To: <1752155624-24095-2-git-send-email-tariqt@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------92c4RgIG3ckzvB0gN0KqTndw"
X-ClientProxiedBy: MW4PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:303:b8::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN6PR11MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c00347e-5468-47b5-ca8e-08ddbfcefa76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zld3R1RYd1dQdjY4bllNS2FjY1Nub0JWcmMwZ1ZJaXg3c3hmZ1pJUWxrSTJR?=
 =?utf-8?B?ZUNoUUVQRThEY2RnVkxaZmkvQWhSaXVWcUxPZ0J5b0JiSjQ5WjF4MTdBL1hD?=
 =?utf-8?B?MVJtcWhPTjhKUURBbmMwcUhqbnpSN0Zidm1nWmw3WXArWVVUekg5ZkVNVEM0?=
 =?utf-8?B?bnpOT3o1ckNjT1RqcWhnb1JDZGswTVV6UTM1c09IS0Q4Q2dNcXlrQWYrUTRB?=
 =?utf-8?B?SkliYWRtYnVSbmNES2FkYzk1VEo4bDZTdDBzZkdVLzJpbUc3WWlsYmtnY25j?=
 =?utf-8?B?SUNzRm1MUG9jOExiVkdYWENUNlJYZFB5cUxPNnoxa0lOSU45MnJsR2Y2dVRz?=
 =?utf-8?B?d0U5STA5YTVpaUZUT2pLaldBQzVtSlpsaWhHQzc3b1F6dGk3WXVZeldRT3FH?=
 =?utf-8?B?NTJEMTVCRHV2MDgraWlYSnpMSk02OTd5L2ZRWncxVWk0NnpIbjVRcFhIcUhm?=
 =?utf-8?B?OU1SOHBzTElhNUtOLzRUcVMzZy95ZXVHWG53VVkxbUxqYy9QNVdEdDRVczdB?=
 =?utf-8?B?RG50M2NpZHlSOHA4YnROSW5YYW5ORlZCK2EvT3JtTDR2ek5WOVpoREt1dzdX?=
 =?utf-8?B?c01zN1VMdG1OcFBaR3dwSGZKYWhBYzJXeUxkRitmOGdmcmpFME1lNnRqUnBJ?=
 =?utf-8?B?T1AwWlR6OUhTZkE1TFZVai81SmJvTTZuT2ttZGc5M1RiVTd5Q2dCTTBEOURB?=
 =?utf-8?B?YXl5QWVGSjRGOHdvRGZFdW00UUZDaDR6VEFpSE9CNGJlMnlkRVMxc1JzNlRQ?=
 =?utf-8?B?Z3dWUWxBRXh0bXFtK0d6TmRIcmtnMldvdk83T1IzNDBoS3pnaHFyM28zQXFL?=
 =?utf-8?B?T0o5dW1Fd015SU95SWNGYkw1MlpLcTRIN0pGWnBkcUVtNFBva05Hek1KbXRX?=
 =?utf-8?B?a3hsS2JTdlFKSk5VQkd3bnducmI0MTFRY1ZSTlpoRElPNFRTTlhqa0YwNkpj?=
 =?utf-8?B?UmNJcDR4V01ua1owaWFiTUQ4RVc1U3pLeUlyRkc0ZWtMVGVaWVhuc0VmVlZy?=
 =?utf-8?B?cng2cXpCMWMrS2Z5dVNrSVZrYVFXQUdQN0lIWTM1OEo4c3FyVlFab1RrdnFF?=
 =?utf-8?B?dHc1ank3b2V0T3RQTTVyTm93ZWdwUWpORGdFSndadFpkSTI1bzFYdFJrVTJh?=
 =?utf-8?B?Vmhud2R5RkVONjJSa053K2FKWmRCbkZEZVpsdm1XK3VENDNzUEpLcHlCWHZS?=
 =?utf-8?B?OGdDM1g4K2tsZ3AzcmxtZWxUQUZnWEVsVjY0R2pRV3VDc21QZ0Nxa2RNMWg2?=
 =?utf-8?B?RFhMWDNVeFI1VDZCOVgrdldlR1ZnMklQYXJ1eGZSV3JrYlNBTGkvcDFqRDJo?=
 =?utf-8?B?ODJCaG03SW80LzRjblI1dXZ6b2FxaXU0OXJycWpiQWpFSjhma1c1Q2IzZWw3?=
 =?utf-8?B?UjZmSk9TbHJqMWVmNEZmbEhqcnRTbmpsekc1UlBrYlppTGY0Q25pZXZSSlNi?=
 =?utf-8?B?Y3lkcVpaenJJRXNMeFJncS80QkxnNXR5aEFMR20vdndkNWNwZWFCKzVoc3B5?=
 =?utf-8?B?QkZMK29hZ2pDazYwN1IyMzArcDZJaGtscyswWDRzL1JHQmhjaGc5Tnh5OEpp?=
 =?utf-8?B?Y1hPOXI4allDMnY0MktleGQwRlIxQ2FqaWlhRHU2bXNvYXdiTlBZQ1NwM2M5?=
 =?utf-8?B?UTdaYmtnMEp2Vkk2Q0VrdUZtT3pmZ3FHK2hYbDdZak1JQXlrSVNEYmtHUit2?=
 =?utf-8?B?VFVhR05DaXdKZ1ArVHdWalFFZEhKN1JBRnlOektJWmNScGJMbG1NclFJREx2?=
 =?utf-8?B?N1NWc2lBODRnbG0yaVkwMW1pUzBOMVlScGxpaVRmRjc0M09CTEV1K1V6UHlk?=
 =?utf-8?B?THQ5TWszSER2SmpRY2drT29LWXg3c3VFRU9vY1ZzSURUZEpDMnhsVkRGWTdY?=
 =?utf-8?B?T1oyY3hUSXowMGkwQnZRdS9GNkIwbGdVNWJrM2xmVERDR2syaHppSHp3Zjk0?=
 =?utf-8?Q?a+mabAQAAzc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnIwdU9Sc2VDTVBmakZZOVM3NHFEam5rKzZFNnZYalFpeUYvckwvb1ZrSjN4?=
 =?utf-8?B?RjllQTVkRC9tSkFPVjJMUU5lNjF2Y3VxTmdjNEhsWWx3cVdNRkMvMTNXWFhx?=
 =?utf-8?B?ckpPRHVVLzRYbHpCVFYycnhMZUhzalVSbjhDcXQxcEZ5MzhyN21sYTJUbGd5?=
 =?utf-8?B?LytVQU5XZWtkSTJ2ZWxjbm83U3JKejBsTDZtdEpOcVMvVXVuUEVHWVBzb2Q5?=
 =?utf-8?B?elVqK0M5SS9mNk1RYmRCa00rckNrTjI1b2d5ejJScDdybE92cjZwMXRvOHIz?=
 =?utf-8?B?elk0T0tjY1FDVHRNUmg1MXZnWHo0WnRlNGg2MmI1R0d5UmlYRlJET3BXSmRX?=
 =?utf-8?B?dGVOMFc4c2NsUElxTjJkUzlpdXU3YW0zc1U1YklOT2FRQkxYRHI1Z2dlcm5s?=
 =?utf-8?B?R1kyZlFJQnY1QWlOZVhKMVhHdEVRc2ZiUUxBMEdEbEkvbXJGYWREaDB3QU5G?=
 =?utf-8?B?V0Z6b3ZxRUY5azRjZXIrblU0M1BEY3RXaWRJY3pHQW4xM2xHZEw3NlNHTmNm?=
 =?utf-8?B?K1RJMUZYL0NxVDkvVGc0V2haRTE1S2JpR21uTnpIK2RMZ09BZE9hb3Q1UHYw?=
 =?utf-8?B?YWQwRHdsdk5hbXRsanNBYjd1cXU0Zm1WRlZOZXpKYXhtdG1VbWpFWW5aY3B2?=
 =?utf-8?B?R2U4VzMyVThTNjdXbzVmcnU4QmsvOUphWGlpOG51cUdBaUhIWkFHSnpseUx4?=
 =?utf-8?B?UklhenYyMnJoZUZPaC92Ukt1RnNWOUEwOTJNcDRXWU5TTFlvMUhEcmVScFE2?=
 =?utf-8?B?Qlk4Um1kdG1wQXhOWmJ6WS9PaGdodnV0SEw5SkFpZmU4aGFmeGZvZ3F0amx5?=
 =?utf-8?B?MytFMlJ3UGxOcTlyZDJJRVRRc0ZudG1KbENHdDUyTjRUczUzbWxPV0piOUx3?=
 =?utf-8?B?L05jMGh3U0hnYjN2TEVRd0FkV0p0dGNMV3BWamk3dUZSTlBwZlNEQ2V2YTBE?=
 =?utf-8?B?a0RRZWFOdFVTbjVZK0pITWhUSFRwZVBrUnBVZlR4eEJqSng5Q3hSRHFQSXJX?=
 =?utf-8?B?NHEvcnFHM3h1c3lxV2NGem9RcjNIdzZLR1VaMVRSTTdQNkVvaGhUOUxKSkhk?=
 =?utf-8?B?MmRMYlNlZnFLY3dQTW84bEl4VE1IU3gyMHpsc1N0ckM5Z3VtTkJVWElCVUFs?=
 =?utf-8?B?T3RsQXlwZ0doODVHZlprMWhxcmNTVGtLcFdCK2M4M2phNXN3T24vRHVqMDN6?=
 =?utf-8?B?dHhJSkZOTEFBcE8wd2FDSTViQVE4d2pRaE13SXd2N2ljaXVpZ2pSc0Y3aW9H?=
 =?utf-8?B?OWhuR3JwTWozMFFVOTJwWDFTNngxK2d5b1lXZE5udU5ob1NDSnFlSk42Z2E0?=
 =?utf-8?B?VW1GMEFrT0FuRTViRkU2MEpyN1RMUkxsN0x1MGZZVHJqWVp2ZTFPVk5oQkFQ?=
 =?utf-8?B?WXA3dmR2UEtNaGVWOXY0NW9FNit0SmdLaHJqQTBydjFCeTc0ZHMyUFR0Y002?=
 =?utf-8?B?RlRUN3NvaVcvNXhXTmE5akpxSi9ROUxSTUdpSEpidGZ2N3JjNFFXSWc0bTM1?=
 =?utf-8?B?YjRCeWhFUHpKRVBXTk8vb1lvd1ZLS3lRNE9sYm5xMThpOFJlY3M2V1RmY2Zt?=
 =?utf-8?B?ZmFpSjYxdVRIa2xSbzJ2RXZXZEt6akE5M0tBdFM4alpZM1NIZW0rRHFaVUo5?=
 =?utf-8?B?WDNJaDFIdkxzTW0yVFJFNm5kcnErRkxoZGgyQmJTZ1ZneU5JUGk0UnN4N3Zs?=
 =?utf-8?B?RUpCUmphbnloaFo0U1lQaS9YUExCZS9Ncjk0YngvZDVLdk9RRjhjOWFKZThK?=
 =?utf-8?B?cVlOcVlEV1pMUmRTcDB4Qy92SU9BcGE4YkRrWmNYY2dZd1E2UHJmOTltbjhX?=
 =?utf-8?B?TFFWQWM3bmh0V3Y5ZDJ6SXBmQklvWW9yWmJBYlc5d3FIam4rUzlVRFEvcjdW?=
 =?utf-8?B?V0N5MjVMRm1ueGNmcGMxSGRZaHludElxUFFyeExPN2tYcjBRUjgzL2xYS09O?=
 =?utf-8?B?eGdxazkyb09OY243RWd0SWZwbWtOYVBNY1R4Q2JKSlR0dlB4dFdtZTdzNUpu?=
 =?utf-8?B?b0JJK1JpVGxMalFzaWlaaTcrN0RNTSs5SEtNck5uUHRlV0pJWWZiWXFoWkQ5?=
 =?utf-8?B?RVMxWXJvU2lCanpSclBJc2ZMWnc1TlJGaGcyblZoM0FRbElXSEcreWI1Vm5R?=
 =?utf-8?B?M3hVbTZsdGZnWGpOc0habkRXUC9nbGlocmlLTlpMZzZNd2E0Mnpxd0xCb2dN?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c00347e-5468-47b5-ca8e-08ddbfcefa76
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 16:29:44.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7J1uByNgugurcqwkCy8SFmgek4ehkEXIIVM/m9hMTG8f69qhPoLRrkwL/STlinXzuhgSmGnnQv0Ksccd7kaYyK4FJfKRoVHuPv9RbF/LBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8172
X-OriginatorOrg: intel.com

--------------92c4RgIG3ckzvB0gN0KqTndw
Content-Type: multipart/mixed; boundary="------------pZmG0Tj03sYfavm38DII5ulu";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Carolina Jubran <cjubran@nvidia.com>
Message-ID: <0f0afb12-14e4-46a1-9d35-fa304f861503@intel.com>
Subject: Re: [PATCH net 1/3] net/mlx5: Reset bw_share field when changing a
 node's parent
References: <1752155624-24095-1-git-send-email-tariqt@nvidia.com>
 <1752155624-24095-2-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1752155624-24095-2-git-send-email-tariqt@nvidia.com>

--------------pZmG0Tj03sYfavm38DII5ulu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/10/2025 6:53 AM, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
>=20
> When changing a node's parent, its scheduling element is destroyed and
> re-created with bw_share 0. However, the node's bw_share field was not
> updated accordingly.
>=20
> Set the node's bw_share to 0 after re-creation to keep the software
> state in sync with the firmware configuration.
>=20
> Fixes: 9c7bbf4c3304 ("net/mlx5: Add support for setting parent of nodes=
")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/driver=
s/net/ethernet/mellanox/mlx5/core/esw/qos.c
> index b6ae384396b3..ad9f6fca9b6a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> @@ -1076,6 +1076,7 @@ static int esw_qos_vports_node_update_parent(stru=
ct mlx5_esw_sched_node *node,
>  		return err;
>  	}
>  	esw_qos_node_set_parent(node, parent);
> +	node->bw_share =3D 0;
> =20

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  	return 0;
>  }


--------------pZmG0Tj03sYfavm38DII5ulu--

--------------92c4RgIG3ckzvB0gN0KqTndw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaG/qdgUDAAAAAAAKCRBqll0+bw8o6Lml
AP92BqYMElyb00M/mP1uI/xrwZYMaD+Gy2bloWNQFt93wQD+On9DCIBeFWOeJq2sK58tXwep7afp
hvk+63seTddFDgA=
=WZKX
-----END PGP SIGNATURE-----

--------------92c4RgIG3ckzvB0gN0KqTndw--

