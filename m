Return-Path: <linux-rdma+bounces-11809-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47F2AF0524
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 22:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6599D444742
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 20:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7652FEE0B;
	Tue,  1 Jul 2025 20:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+7RN3cs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD131C3306;
	Tue,  1 Jul 2025 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751403215; cv=fail; b=feZV/0VyG9y3Z+zmBxyysVMK7iC58HPpGqWDS9jIHiYSmI42KOMFfp0lpPPKyLyZ7x+j5roi0WlcOVP305ADdfLZyQgxRDB8Z8IbB3fkajGngHzK1WC2kuz3ddwDJAWIdN2MCGooR3hGmnSdTNw654ovUEig5frGx+QE3c4+d+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751403215; c=relaxed/simple;
	bh=z4s+eVRRb6RjM0jMrRMyRFfaORWJl+5HHUGKteJubtw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=niGrfuKq1CIsCVDU2NvTpsOMbvsbl4frQSq7ZpfmWmPs1JYcynqX1OT6NogwEoP3xd++esrdCdFH25xgoY4SMIJTgf1PLvZe2QmVvqHDF37xlLTJim9rmDg9wVxAETAwVUZsym9tFO74n2VBVoB3w3Km0D/LZ8J41uuuPC2OM9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+7RN3cs; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751403214; x=1782939214;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=z4s+eVRRb6RjM0jMrRMyRFfaORWJl+5HHUGKteJubtw=;
  b=E+7RN3cs9oVPqYHpmWzMjuIbhLz2hWUv2VoWrZTBTTF+0XlTJZSkIHwS
   OqeTbnpOxMfG7eIQNEfsRmvOe0wKua1NEu3JH9fcVAqBWh4JrdcS08a24
   o11aEviysI2qZYGqlcIWVvWG3G6AtHuclRQXXVJOEmz7YQMQr18ROC8Lz
   /yz/1qXqGK07G7fmeeikofqHr2gCzA51SIjKWoUy2++4bJMt9acLmm36Y
   THLHgBO7ZfNL1xOjAoM7wr9bbGQU1S8CegYgWZ3zC5vCZOO83itDgqV4B
   3WyirFIE5PrMaY8aVGd9DQZc8oVd38braQA6nmMWFpRAAs8xOOByOV5RT
   Q==;
X-CSE-ConnectionGUID: r0jsn7/lT/2U7LcKlc3HMg==
X-CSE-MsgGUID: LtFj0umqSWCQIqzZjBuNnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="63932083"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="asc'?scan'208";a="63932083"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 13:53:33 -0700
X-CSE-ConnectionGUID: R3a/4JJMT0CPfNK9Ht3rog==
X-CSE-MsgGUID: eMeuRYZJSxiEXrlZ92+vng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="asc'?scan'208";a="154416472"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 13:53:32 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 13:53:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 1 Jul 2025 13:53:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.81)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 1 Jul 2025 13:53:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlj71t61GUFaJMWBLSmkXAd+Cj0411sV1Wc/I7dibeiUrc12qZ6AYsNrqjjSLFFZgoWDFWWtoita20kXOTXSRnrXBtiTGf6LsafNHqgbQ36/jg9pO13CcdpzwXkge5CrQ+b2LdIhKQB+cA36Dwj551dgD5Am3cs1JSFbbfB95d+MvKkDpiDDV/ygwh9n8zZ4BFDobNylFXyiRzlwUs3Ukr1i1aVjLzrmxCfrqvPLlxwAkXpHZ0AIbgcgo+K4RNh8l9kqn3wX+XFnZOscssPM2dsrjPw+AYJTn0fjMUkuHxj3S3LJAZwSVXwe7mvteEVFNCURgEMSkB5ZnJb4ZJSvTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4s+eVRRb6RjM0jMrRMyRFfaORWJl+5HHUGKteJubtw=;
 b=aKUvgPuhuKRssncC0bhNMZIH8tD4dnHd3QRL50UD+oiT2QARKyIZKrLL/MSpBFVjzerk7jYptJiI3qKAWM210rVYtZktaA9q2jf+/FPuiFWSuX7Y0xRmgxc3onpRglEo3d7M7IA25GEQJKQgCGqH2w5NOvUtjSH+1TcjM8KPzomhsOKtjMt19L1/bJCUma5OsqVPDGo2p4bJL+vWjPDiOClGgMkVClaTC88q99WSD0gShllsMKjT+Z74NUHbclc82JTJ4ztoJXSYLQztxCMobRsJyxqcLjhzKZVm8z5XjVUFOVzFWVHGJeMGnyiksASToufG4gIcCIFwctPwrhY1EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV1PR11MB8791.namprd11.prod.outlook.com (2603:10b6:408:2b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 1 Jul
 2025 20:51:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%4]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 20:51:55 +0000
Message-ID: <06e99d8d-a6de-4687-b109-0d1557ac2779@intel.com>
Date: Tue, 1 Jul 2025 13:51:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next 1/1] net/mlx5: Clean up only new IRQ glue
 on request_irq() failure
To: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"shayd@nvidia.com" <shayd@nvidia.com>, "elic@nvidia.com" <elic@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anand Khoje
	<anand.a.khoje@oracle.com>, Manjunath Patil <manjunath.b.patil@oracle.com>,
	Rama Nichanamatlu <rama.nichanamatlu@oracle.com>, Rajesh Sivaramasubramaniom
	<rajesh.sivaramasubramaniom@oracle.com>, Rohit Sajan Kumar
	<rohit.sajan.kumar@oracle.com>, Qing Huang <qing.huang@oracle.com>
References: <7cb171c4-3c36-42ea-bd6f-52dfe6bc5dab@oracle.com>
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
In-Reply-To: <7cb171c4-3c36-42ea-bd6f-52dfe6bc5dab@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------qhk5rjuiNB88m0G8fI708cAM"
X-ClientProxiedBy: MW4PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:303:dd::10) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV1PR11MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: f702842c-38a7-4b94-9a5a-08ddb8e11d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2VaZ2szMHRIaE8yRlVsKy80VjUrWFZiZWpGVVNPRUhGR3ZEbXI5YXcwcXQv?=
 =?utf-8?B?Z2FGd245V2dHVzM5SzN2MnJUd1NlQW1HSzRRVHpqeWY3L280MHNDcDFhTWR4?=
 =?utf-8?B?NWFZTThydS9VRXZ3QmJYZTZkZm1hOC9uZTVzVFVKcVNyTFhleUJjVkRCZExo?=
 =?utf-8?B?TFVCK2VMbWtncTl1MzBEMUdxVEJ2L09oTEhtRzBtNXRrMG5UL0lDSy9BTkpD?=
 =?utf-8?B?b0RpMmlGSmVwVnNkZG40N3N5ZU5CQ3UvYTJJa1VaMkZBdmV6b1lZaFRWbUVt?=
 =?utf-8?B?L29CZkFIVEFMMlViMzZ1MGFhekF2ZFVCRXQzVzF1Q0dtbmQ5ankrbTNTUjVq?=
 =?utf-8?B?bDM1UUErc1AwakJJdEVRajZ5YVNPQXNQMEUxVUQ1d0RqZmNPb3VFcDgvMXo1?=
 =?utf-8?B?RUhhU0Rtc0xiblNsQlRCR0RGNVZIUUdJQXhaUGNjNE01aExiTXNPYi8yUnNs?=
 =?utf-8?B?dUFuOXc3SEUyMTdrWGx2TGtObUJZNmV5R0pKSktzajR4c204K2RMd29OR3pv?=
 =?utf-8?B?Q0UybnEwaDRENjd1bUdBdWFHd2tMSlhUSWllSzRUUzA4blpDYmltbjNYZWU3?=
 =?utf-8?B?bVJoSnovZFN3TGNLUUM4UHFDQk5wVXQwL2hpQ0w3M254elhsYmFkbUFuVUM1?=
 =?utf-8?B?cDk3c1RJQXhzc05kU2JZeTdUWG1JWXFYNUFUbGZHVUZTYWlUY1B2b1RnWUJH?=
 =?utf-8?B?SlhPWUc2R3I4SGNZWDNwQ3ZaTTgvVURCa3BFYVc4NWJ6cUpWVjE5bmJIeFMy?=
 =?utf-8?B?eVNKelpBeTlYQlAyYUxVbTVkbUdGYTZyb0lqTC8zVWhGSEJKRjlSQ0lpQmsr?=
 =?utf-8?B?aDV2MzNIaEprM0QwU1gvN3VQdEljT1BmVUlrTkR3QUtYbDZuZ3BVOUZLSGZC?=
 =?utf-8?B?a0xYc1haenYzTkNUb3FsUjVmaVF4aUJNaXNNelFiQXlGeHhhNnNrQ25sM2li?=
 =?utf-8?B?WWUzVEJDcFRqUld5czBxT0JPRCtobTBPQWdtMXk0emhNb2lUejdLcUZCT0N2?=
 =?utf-8?B?a3FodkY5eXZqSUlkVGtkcFo4bWN0ZFV2Z241K2l6MmluaXVtWGZQcngyZVNY?=
 =?utf-8?B?MkNoTFh6VHQxR1FDN3lnL2FDTmY1Tjk0bU1qdkwvdzZrZVpZL2Z4b0xjdnlS?=
 =?utf-8?B?dXEyZ2RLMXpML28ySmlsL25td29WRFVzNXFVVjJyeE5PbmtyTU1GYVBJUVcr?=
 =?utf-8?B?bk5nNG9udWFQZ1kva3dtSWt4SnljU0JVV0hhS05JaHVlczFCL0t3TVNuTnA4?=
 =?utf-8?B?dXYzMFhlT3pRMThFc0xpYWxPSU11bVU3bUJYT0RWdFkvM1hpK1p0clNjNWxo?=
 =?utf-8?B?elF6Zi9QaStIeW9UV2hoNnFkVzZxeVI3eVA4MmlkL0IxOXREWjZjaVJhR2Y3?=
 =?utf-8?B?by9lOEdNWTBudDhHVkFGRUxsYlBTQTdrdUhNdUpWeXdZTHhPQ05lSHBSdmxi?=
 =?utf-8?B?MGdJRStpTUlHcnMvMlNzSk9ka0FtVHJyN3JBVE9yUFZsUmlFQ2cyTU9OQUVa?=
 =?utf-8?B?cnNEOU5JQTZxVzgrNXRrZmlaNHV3eHZiUmhXd3poYlN6N3BqL21BRWxZQ3VN?=
 =?utf-8?B?dzFkcDIxNy8wRGxSN2pRem1IbUZXYVZBV3J3eE56UGhCUTVFMi9HVmUydTJU?=
 =?utf-8?B?SHpEQzBYa1FjZ0xrNUlST091bktmbitFYTJIYXdxY3BwOHZLdkVhWWJjTDhu?=
 =?utf-8?B?RHRLaG5GRVJzN2JqU3k4NzZYWnBZYXptaG9FWGNwbitTNHZJbTdtVWxIdVNF?=
 =?utf-8?B?YmZieFpNa2ZWUEFGWkZVb2RsdEdBS2Vsc081K0FwYkM2TmZWNERMeEp3TFUy?=
 =?utf-8?B?TUEvdWE1a1BWODZMWVZxZ2oyc2NibFIrRHNwMnlVQUJwSndBUGNTUWY3YUVu?=
 =?utf-8?B?WGN6SmFMVS9meDFUTmRQSHlDSUl1cUkwM2lNUXR4ekpZTy80d1ZtRHVoOFBB?=
 =?utf-8?Q?U+vQVqm7KtM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnRLbG9YcmFvQ2xadUx5UEJZZzEvd2RPaFdOOC9HcHpQbkpQUVFRYmxWYTBw?=
 =?utf-8?B?VEIwdGtQTklCVVFLV0cxMjdSYnBBQlozWlhZY1BaNmpTWUZxTXdRbWtpbFRv?=
 =?utf-8?B?TXBuZVorVXFBOEhTTWV5MlRBRURMdlhtbkVDTkpPcEpUREZkYm84S09FQUFL?=
 =?utf-8?B?TWhwMW1uRGdBNW1NcUFBdUdxL2FXLzkyWXl6NFVFOXFzNXIvMFc3TjRNQWRo?=
 =?utf-8?B?K0tQOHBHUGlvbU90T1NVTlVqNnRMcFZUbFVhWnF3WWRaUE9ZL1ZiN21EYmFX?=
 =?utf-8?B?Ty9CVUJRZDVialhhTzRNbktxNEExZitYckJyZjhOVXlTcnZBcDZZK1IxMkt4?=
 =?utf-8?B?bGxrWG41ek9DUXVoNGFSbWUwUDBoUUdab3g2dXpwTGdYeUNXNXowazdrVHpD?=
 =?utf-8?B?MG1zN3pUaHhvMHJvV2t4eUR1emF4VTJlL0RISEltOVdXL1BybGlOM1g2T291?=
 =?utf-8?B?QUk0UTlTNkJaZWZSSmhaYmxLZ2wyMHZ5RGR5RVVMVXJYaEpoNityVlAvNzNr?=
 =?utf-8?B?c3F1dnAvanFhdUNvZTJjS1kzVC95QkgveTVHcWVMY0R0c3J6blZvWmVnU1o2?=
 =?utf-8?B?SnhncDRuVW5FNXdLVVBWN3V6NU15Rm01QjlLMzQ4YUpMd2tvUzROa3FiU0dh?=
 =?utf-8?B?OW5MdTJFcDJXVkNTalBrYnovRGk1RDk2OUI3WXU5SytheHpsTVVETGh5cVNi?=
 =?utf-8?B?c2w5QUlYd0U3MkJyZ3hXT0NQd1YxNEpFTUtlbnFrWCtzWHJacXVnTkMyNHJQ?=
 =?utf-8?B?TVIwL3lvbnBqb3c1UHdqVkNsdVVNOVlXbFUxVnp3cW81MFRVUFJMZjRxMU1N?=
 =?utf-8?B?bnlHbWtPUWg0RG51eDVvcGN2djA4dmdBTFBxUWgzNXFyRytNNW1hVy9nd3RR?=
 =?utf-8?B?MEpXQ0R6ajZDU2NXNjVGUG5GbVFlWXNNNndXWlBveUpUbTBGODlZRXdIT1g3?=
 =?utf-8?B?NHY1T2FVYWZHSjZHTVhxRHNZYThaVjNzNUplbXMwR3RtSUZzVzhBUk9JdE5O?=
 =?utf-8?B?bWQxQjk4WjlRUXhEVWxRVW4xOVh5dW5jMDRESHRkck5ZYmxVNWdnVFlTd0k3?=
 =?utf-8?B?dU5YTVpVMEY0K0V4Mjl2Q1RpdXl5KzNwZDRQdkZCYWZ2eGYyWmVCa1dteWdj?=
 =?utf-8?B?WGFLbWRKNElEYWVncUtXSm1kMXJZT3B6anZCNWFhaFlFdnEyVnRNNW9FYmRQ?=
 =?utf-8?B?bCtCNzdIeU1BQzVEN0FRMmNKRitzOW9vdUdRY09IZGJtNlRsNTh0OVZnT3dV?=
 =?utf-8?B?QWZEcWJRUzcvSmR2UUFwcVFxVFNSd3h3MVdsQzlhMUYyR2RucERzRWZJOFRp?=
 =?utf-8?B?S0dibXVyVTl6b290aWxOSFhKQVhTREdJdWMvNEFnY2cwSEg2VVkvVFE3OUp1?=
 =?utf-8?B?QTNndzdPK2V1QVdLdHVHRTFYekFaMXF1YVg3T2xTcTZDMUs5Wm41dnZpL3Vu?=
 =?utf-8?B?YXBrSDNZTmg1d3U2cHdkaWRqa1JBT0FJNCtHRE9ud1VQMS9ORkcxRGxac2JH?=
 =?utf-8?B?WkM0UkFPUVdGaldLMEZVdjdRSFVLaTZiV3ltRWlkZW1KcHd5WUdkaG9oNnBW?=
 =?utf-8?B?VFBSRFl4QjZsQ0dETjY3ZUJ0TGZRb0psYXRGUisxcUJmbUEzdDlabTRvb0p5?=
 =?utf-8?B?RHR1TmM1Q0o4UVk2OUUwcTZDVjJJcFhPNVlQNUZnSE1CN1IrQmtvWTRsQU9z?=
 =?utf-8?B?V1JWOW9kTkR1SmloYU1UYmtMRW04b3lJV0lSa1Noc3ZrVWk0Y3NYNWFjYmNu?=
 =?utf-8?B?ZnZlSVRwODRLcTlxYThjakhxbldxOUNnY1JnOWxnbEtQMFljd3kxUklMMHZP?=
 =?utf-8?B?Wk13RlhCTS9VVXVvN3o5cmh0bnA2WDlRWXJNc0RwK2ZhdytlMmF6OTBFeEVB?=
 =?utf-8?B?MFZ2S2FIcUhFRTFwTVBYTXQ4Vy9qT1JId0NjOVZlMGQwbjJtNUFNb2EyQmlw?=
 =?utf-8?B?WFpiT3E0VTErYnJ6bThveWtEdVMzUkpVaWVLR3UwYWlLTnpkTDBScDh3NE9w?=
 =?utf-8?B?ZVhzd1l1WVBOdmhIaHhtMFFFWlRiUnFYK3BHVUtuSi9HWVo0RGgySVM3bHlP?=
 =?utf-8?B?MXBPVkV6UGFOQTVjUzhNSGVGcWszcWJ3czhnNHBibFJXZWl1cno1TUpCMzV3?=
 =?utf-8?B?WFVIY2svS2lCN0lqaHFVbFlQUWd6aVNzRkYvN3pxRDJKb2kxRnFURFVUUXdW?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f702842c-38a7-4b94-9a5a-08ddb8e11d0f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 20:51:55.2457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsN9QsbGMnmo5ApAIED/faPZkbocozc7FVBERSU3RLJZAgNCKUlvXyWc4cHGUrkMAYYzQ191VVIP2MWpE5t4DG2MTM7yMfvbwGekUoiArCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8791
X-OriginatorOrg: intel.com

--------------qhk5rjuiNB88m0G8fI708cAM
Content-Type: multipart/mixed; boundary="------------3FAJeKWW3ICtpxjc4CWsDAVi";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org"
 <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "shayd@nvidia.com" <shayd@nvidia.com>,
 "elic@nvidia.com" <elic@nvidia.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Anand Khoje <anand.a.khoje@oracle.com>,
 Manjunath Patil <manjunath.b.patil@oracle.com>,
 Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
 Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
 Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>,
 Qing Huang <qing.huang@oracle.com>
Message-ID: <06e99d8d-a6de-4687-b109-0d1557ac2779@intel.com>
Subject: Re: [RESEND PATCH net-next 1/1] net/mlx5: Clean up only new IRQ glue
 on request_irq() failure
References: <7cb171c4-3c36-42ea-bd6f-52dfe6bc5dab@oracle.com>
In-Reply-To: <7cb171c4-3c36-42ea-bd6f-52dfe6bc5dab@oracle.com>

--------------3FAJeKWW3ICtpxjc4CWsDAVi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/25/2025 10:32 PM, Mohith Kumar Thummaluru wrote:
> The mlx5_irq_alloc() function can inadvertently free the entire rmap
> and end up in a crash[1] when the other threads tries to access this,
> when request_irq() fails due to exhausted IRQ vectors. This commit
> modifies the cleanup to remove only the specific IRQ mapping that was
> just added.
>=20
> This prevents removal of other valid mappings and ensures precise
> cleanup of the failed IRQ allocation's associated glue object.
>=20
> Note: This error is observed when both fwctl and rds configs are enable=
d.
>=20

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------3FAJeKWW3ICtpxjc4CWsDAVi--

--------------qhk5rjuiNB88m0G8fI708cAM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaGRKaQUDAAAAAAAKCRBqll0+bw8o6J5w
AQDaNRpgUmJiJms15UHsFPismqXS3tWdKEkc1x7Cwr3pYwD8CUomLmCgmsCp2Npg+ADbkTNwyQSq
9BabLNF9GZD2gwo=
=Qgpz
-----END PGP SIGNATURE-----

--------------qhk5rjuiNB88m0G8fI708cAM--

