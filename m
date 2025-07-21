Return-Path: <linux-rdma+bounces-12376-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C76B0CE5D
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 01:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A0E1AA2EF0
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 23:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80F5246770;
	Mon, 21 Jul 2025 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CrA5OQR+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0384C223323;
	Mon, 21 Jul 2025 23:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753141490; cv=fail; b=IwGnXI24w0LCuN9ncqdZoQKQ4fFfgF60luefBQedPz0wIiD3CNRA0ISbrX7G0dwr8IXRTtI2RikkPuUnngRmFUY6DwkvPWfQUw/KkH0+V2qgvKymyOgQrYzPy96vh1RObgJ4Mp2tL/uBuvEWjiCD+WMjHG/JnFshRT4sHdNabUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753141490; c=relaxed/simple;
	bh=XBDqShM4KunQycqlVBtPg3K4I0cvaAzubdwABu1IZfY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WPFH7YUHZTYw1upEkuE/sUShQBh5iQRs5FQriRzLmdmcVJlWaf7Zo3vH2WoN+SHPk1+moFgAgMTuHZy4ESJ4+tLoKSOmzzhf4uq3BsSD3YQC+LKq+bZ/WeY0fH3lr42Bm4GTy/S4ntlGs1vt/O7FqzuTMla6h9yAdx2//R05kjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CrA5OQR+; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753141489; x=1784677489;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=XBDqShM4KunQycqlVBtPg3K4I0cvaAzubdwABu1IZfY=;
  b=CrA5OQR+8u+HpKAKnp3hxddGwLnwsNvZgBLvw8tis34QjhzeqVYjriRu
   0+GkDQYa5xOzzkFuvFJ5Fzr19gfoQ9BwiTrgK+mMdX3NG2ONjt3CfLqpY
   iG+y+gD8/USV6CakPeJco4dwK6VLmU8/HZyQMPeGCr0qid4FpTsOS9oFj
   mMqdKX0jPz/bNEyfRQ/BmJgAc38Vw5CJCV69MDSJ+MX4GZFlY1ManKz8I
   oGyLhPdE9cicExzBViuhdiAAG7RUlXG7dFIrADcaPYkfv9PPusgvIG06t
   ZIPYMNxgDwF4v12Y7QVNZk+jsgxt7VpQEiF/2iKmHkjdYefMZ1faHYnVA
   g==;
X-CSE-ConnectionGUID: ub6wpyOHTe2JHjLhT/timw==
X-CSE-MsgGUID: USnYwMHLTVKl311mQGb+ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="72944779"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="72944779"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:44:49 -0700
X-CSE-ConnectionGUID: kpocznuISVKlaD0Ebja3IQ==
X-CSE-MsgGUID: 2BX3qYpjQfK2+mKpW/wgwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="asc'?scan'208";a="163535895"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:44:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:44:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:44:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:44:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9qMpi8duP09crML6Whlsf83U/OBFRb4cvCVJRlQkpQ1Ct7SLA2wJ2j4UbK7148iXePG0dbrsZv8eaGPx0uBnhA1qwPMs+oMfrodMkGvqgaYhZr6qxdncrSu9lVjM8MBMSFvPXBgkpx7zv63i/HZeaanMSbb1pQ1CxZW5wJ9AgdxTHXbJMkNLkj3dtfc7VJd8WT/Kd15QVMh1D6nubj2nSuuQ+RT1NxGL2vLEanG1s0WYKtzzAdr0PsLMQwIClu4FrJVTx6kRzaSTtRFGgcnThE9VfUYc6GT2jungckHXKgZqxn6Fyd4mjmThxC76qi9jnHtm6zF0EZqZtQPm9/zpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBDqShM4KunQycqlVBtPg3K4I0cvaAzubdwABu1IZfY=;
 b=VWtg+CA5O9xdUtDKhdss9iUas8ElXuCCtSLddo2VfEgssbEUoekK4aXpDPEoSqq6n3hbuXDdH6OlxyQBPIJJ+6VQ5f+6GMxNI3Juy1TH/FxMZyM4+YDn76VKQxoVX1gFwpu8iieXfhLceeXngJm1YXxY3sA1ZkM1J4kexVHm0jN8Jd+eSU/jvwPMbwlziU0NonVVajFvCWvWjSfpjKClYP6+eM2JP+f6kYCe6pylJRwZLiebpGZo/Adpj9txmKn8Jwu5NYRBaJBsf75uIdAEXy26xxKsrkZd4bstgrx3IQmLOB4Kifnpvrq7UMkUMqPqa9hIKB7XA25dBFSQeNKetQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW6PR11MB8391.namprd11.prod.outlook.com (2603:10b6:303:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:44:32 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 23:44:32 +0000
Message-ID: <ff7796c1-c8c7-4dab-89e6-75aed80224c7@intel.com>
Date: Mon, 21 Jul 2025 16:44:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 3/3] net/mlx5e: Remove duplicate mkey from
 SHAMPO header
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lama Kayal
	<lkayal@nvidia.com>
References: <1753081999-326247-1-git-send-email-tariqt@nvidia.com>
 <1753081999-326247-4-git-send-email-tariqt@nvidia.com>
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
In-Reply-To: <1753081999-326247-4-git-send-email-tariqt@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------13ecYHq273qxFRFZ05F9GxCL"
X-ClientProxiedBy: MW4PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:303:8c::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW6PR11MB8391:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eaf2643-4e09-43b2-7972-08ddc8b08af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjJ4UVJIRzNsRjZKZkMwWCtXYjUxT0JHUU5pSzAyMktoeGJTSE1DdGRyRVE1?=
 =?utf-8?B?bHU4TnlPZW55Q1FFT3ZCTGdacGxHR0lQUDFMdVQ2QURIcEVrelVqbnVFdXR1?=
 =?utf-8?B?WHlEOVU5aitWN1Z0WS93T1BGS0tEWnUyNHlEaitDcTJ5bEIzalZuSGF0Z0Mz?=
 =?utf-8?B?L0dDSTJuSEVldjJWM1JtVG5JVE95M0FRYnZFc0liTmJDaytlOWVnYmhHQ0tQ?=
 =?utf-8?B?Y1hJblVFMDZjcjRLelZ4bmNTaFViazFmZkk2YlZaaCtSU0RlRVNGR0ttbXJE?=
 =?utf-8?B?c3FzNU5meXlwSjBMMjZUbTNjcUlaOHBlcVllQUZOUDM5RDlOT0czYnVaWkpv?=
 =?utf-8?B?ME12NFJJYkc3V2duaVNsL0MzZkplcG5kWTBsTSs5c0dRV003RmFSRHI2SVpF?=
 =?utf-8?B?S3FYV0dqelZDSUs4Y0F5QWx6OEYzV09KdmJTQ3NQYjk1UW1kZWo0OHJDNkov?=
 =?utf-8?B?eXF2Mnlzc2NrWXd4Q3dtek5TRTl4QkUyNENlUVlSeGlNUkFVaW1OQVkzbEVh?=
 =?utf-8?B?cm1GRWZNYU1yb0QxNUxHNTYySHNmUUVvcmFPZWJjZktzVjQzTk5pMlFFQ2xM?=
 =?utf-8?B?VzllS0x0cEgzNGN3ejB1Z0xkZnZxMU4wb25FWFlVM2wwcHpIMTE5S25PMDV5?=
 =?utf-8?B?ZWYwN3phVTFob2N6ZEgwZWdMbWdUSjc1MUQ2SmFqaEtIUk5CRTZpYi9oWWlo?=
 =?utf-8?B?UHptSVJabWRudmRxVFhGZlZIb0Fxbm03S1N4N0xmY25TUmI3VFhnVTBJcXV3?=
 =?utf-8?B?S3c5KzlZTmVMQXhsc1J1NWVleWRsVUZpSlhDTHJrdVpRa0xtOFBlN00ycmZy?=
 =?utf-8?B?b2xXQm5KUnZOU1lvdHliUXVrTXRzTGpvUnRrZ0R3YlVpeFhZWURmZ2xtVWsy?=
 =?utf-8?B?dUxZL1dPTGNubVQvcTJnczdHNW8yTzhaOE9kNWlQTW44Vi9rUjhDRWNwL1hi?=
 =?utf-8?B?RkVVTm1jK0hoQ3B4VENwNU1JcUN4Q3FTUUo4RmZPMWNUL1dzWnVsNUI3UU9h?=
 =?utf-8?B?clorR0srYjhrUTM2TnZidUpnUEJ4VnppWTU2MmE1M1dlelJmUThQdk5HdnJI?=
 =?utf-8?B?bFhqSUVobE1lVVNYckROSG5Najc2VlpVenI3eXdybjZWK2xoQ1JJdDNkWHZr?=
 =?utf-8?B?SVdzRGZnREZ4enpEQjFXaHo2QW5wRU02bFREeFAzd0wxYmtJNm10RlFRY1lV?=
 =?utf-8?B?YW5TSzR1KzBGSFBBNTNBNjRqZXF6alVoNVBud0FBSk44YlhvMnFhSVZKVWtN?=
 =?utf-8?B?b01Zd01RZGtFOGtRZk14bnhaWkZkdFdvZFQwdDJULytjVzZiQ3VITjRPeTE2?=
 =?utf-8?B?a21Vdllka2huYTZjK1NVZUR3OUl3NmVYRENQUDZzNG9jYzRXTi9vbC9SL0d0?=
 =?utf-8?B?K1BkNGw3S1JSWHc3T2lpZDg1aENxMXdWd2xuNmpOQ0tnUWMrdDZFUk42VEE3?=
 =?utf-8?B?TmM0OUxtRXpsT2liZjRZT3M4cjc4QkxwZGpjc1RBTDVjWnB6OXpyVG5mUGFi?=
 =?utf-8?B?bU1ES09KaVBHekZqZkFUV2tyMCtvV0hmNDI2L1Q2Z293K054QnRnQ2tKaEpM?=
 =?utf-8?B?aFlGMFozS1RHUXlkY0gxNkthOWlnYlVHRUJKeVRwMGEzWkNsR01VdmU2N1FT?=
 =?utf-8?B?SlcvSEdGd2dkNEZ3UE82aDhoT21VRnN0M2oxY01CTk0vYXZtQXFuNU1UUEs2?=
 =?utf-8?B?czVmc00rZmIvQ3VLcEk1enlZUk8xTlJvL0R6eVVGaTBzRHFLcE8wU2daT0tI?=
 =?utf-8?B?a0ViWVRZNUxodFdzendaMUo0WTBtVlBwcTJ2M0Vscm5LUzF2WjhHYzRSd3N4?=
 =?utf-8?B?VStNTFVTZ2hNSzhnOWhhMzdGUitXTEVHeXo4bW5ZYkZYbU9MNVhZaXFTWm8z?=
 =?utf-8?B?QzcxZDJNK21kRUlrUmZUejBHdU5XRHp2eGo0OUx0aS9obEtDWWNOcitIL1pB?=
 =?utf-8?Q?OaDtxp1fuxk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnRON0loK2ZRK0hXQ0h2dmRMbExVZ1lMcWVBZ3U2S0NlMUhockpqRVZsU3RW?=
 =?utf-8?B?Q0ptejRKUHJEZnd6Z2RLSHl0SE83MDJZNWlHc3Nhd0ovUUE0Z3hqV2Y1WEJR?=
 =?utf-8?B?YXpDTk5nb2dOTWZhK3Z6bDZaTVd6R1RGYzM5VE44eHRNMzQrandIK3BXbzZ4?=
 =?utf-8?B?OExEQTRpeFo2YTlhMDhMQWx3TlJKdFN3TER1ODJaaldOeTFnSjF1SXN2MWVi?=
 =?utf-8?B?SjRyVDU3V1l4ZExOZDJOQ2lwV2kvOVlpY1NvelRWNWpKdlNUekw4dGNZa0t3?=
 =?utf-8?B?cTN5UzgzSmRhV0pFN3VucFpmWVBVczA1VFczV0tUdXd4Z1l1d3JBNXRQQi90?=
 =?utf-8?B?anlJVnZpWDJJQWFEVDUraktMQnBuS1hDUXRsOGhXZnNKSzh2Skltc3JQeU8r?=
 =?utf-8?B?R3o5RFE5ejZFQ2x2UGlwZmpzUDNyazZtRmIrYkZFd0IwN3o4Vzl0cGkxMTZP?=
 =?utf-8?B?S3JxQ3RlaUxjZlJxRU8vN3ZwSGdFT1FhM1UyVlovanEweHE5a3l3UlQ5K2R6?=
 =?utf-8?B?ckUzZStXSGZYRi92OW5vN1B4bnlhQnhnRVMwZENnR1IzN1VSVXNLMmpwZ0I3?=
 =?utf-8?B?SW4vTkRxcTEvcUxqakcrZHF3REJIaGtjbCt0WENQcFJCZ0puMUxqQ2FvcDdr?=
 =?utf-8?B?ajNaZWlxZVFLMDZRT2x0ckVid0pNK0UxTzdpSkViZmU0aStvNTV4TUluQTV1?=
 =?utf-8?B?cVVEUWxvVkUrbzBpSG5nWXFhMUptV1EyZ2Z6WmhRWEN4MnNVZnlCRHh3TUdi?=
 =?utf-8?B?WUxSM05NMVZLZ0k4YXY1VE52TWliWDcyd3piaTI3aTFIczBCeitMSi9MQm1E?=
 =?utf-8?B?dXJ2dHREMC9Oc0xQQTBYMkJZazNzU0tQMFkyS21VSVlQbWxLWVJpZWZYaWtk?=
 =?utf-8?B?RUNYMlAyNlFBeHpyZCt6OFR4anA2NGVPL2pHQUR6SmhwOUJZYS8vWjU1Und3?=
 =?utf-8?B?NVlHZVVPdmt1VGZDTzVQZTJ3WDNVVjZIY1lNWE1DYUhnRU9rVXJFVG9XWWNC?=
 =?utf-8?B?QTd6OXRTZ2crb1NGb2VwUkh1MSszOFFqQXIxTlF2QjdYNjFzS2xKeDlRSFpG?=
 =?utf-8?B?OVZFYjA5OTF6UzhVckJoNmtheTlhZEQ3dWxKekVEekNwT05qTEJyOW0yYjdE?=
 =?utf-8?B?MTk1Qy9XS3A5MkRFUXlMQ1JjeEVLdzRxV2ZvTUJuV2dWZDMxTWhEOHdTd0da?=
 =?utf-8?B?RzR2bmo2Z0w0YytrQTN5enVJTkhXeFh1VVBzT2ZKSTVtT1p4OTJiL1JYdkNT?=
 =?utf-8?B?enREbmlCOVMwZkp6cjMyZCtTWkRpQ085VTRMaEFvN0RtWXV6My9vbERmS3JW?=
 =?utf-8?B?dWY1Y0RYazZqK0hGdlg0UVE0WXV6b3dOdm9vYWdSMWFQSURJNkp2UHVYS1BJ?=
 =?utf-8?B?RnMzbFgwdGtZa0xBeVQ4dHFZSUFzcng3cXlRanhqZ3ZXdkR3eWlXWXJ0Q3BP?=
 =?utf-8?B?ZkpmVTNtM2ZGei96K25SRzd1RkFiZlFnWVhjTWhyd29KMUJTNU1hK2twTDVO?=
 =?utf-8?B?TStMYzNpaktmSTNQRjRGT29jSU5obmUxRXdBdjZnRTA0NkhlWkRtUmthZER1?=
 =?utf-8?B?ZjN0OGsyUGhoOElHN1RCejR2Wnh0Vit4T2tvaEhBZjFRZCtIN3BXaWlJNGxS?=
 =?utf-8?B?Q0xLU2xBOHF6ZkkralRDQjdEQWM5blY4ZzZGT1N6TkFldGZoS3RmNVRiTFdk?=
 =?utf-8?B?V2Q5Vk1wbytCL21jdkc5cmo5UTl0d3ZlRFkvdEpNUExlYWh1blhJaENNblR5?=
 =?utf-8?B?U3FiQTZYYkw4eUYvdUxqaEIyUzN4VFk0U05GNkZub3I1MU9Jbno3TzZmeDBS?=
 =?utf-8?B?enhJamlia1U4UXlMQmR0ams2eloxVW5iSUFVTzgrWUFjT3pPR0lvUlErNVlq?=
 =?utf-8?B?UTR4bEJLMGpuQ3gvbWNHdnFxK2lHSi9tL3d5VmVGNUtDR2lGZGpDUUtEeUlv?=
 =?utf-8?B?UlA1RE05OE9zNC9IVy8vRUtWdUx6eXVNSzdROWJEN1VZWllJRkRsQmoyQ1Rl?=
 =?utf-8?B?NFpyYldKcmYwZUZ0SWh2akU5MStTRnJqUUdEb3U2MWg2Sk5sNngvYjQvWDNN?=
 =?utf-8?B?dFQ1WjkxLy9OYzhpc2g3WXhUbmNjMjEvaVczRUExcXZIWUlBMG4vakE4KzJO?=
 =?utf-8?B?U3lkQWU3MStCeUZGNnBwWm1tUGFGVVJtaWhaMUt3bFFUdElMNDFidVNzdUpI?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eaf2643-4e09-43b2-7972-08ddc8b08af3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:44:32.8414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYM80d8Hs9BXSYL1ly5uOtakZVyGhZRJdTo5ugfUIbxI3qS55vA+e0E5GDxQEjs3EH3g2/LbUmfzLC3HS9Gv0yzXpwsnUR7MaWjRpIwJeZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8391
X-OriginatorOrg: intel.com

--------------13ecYHq273qxFRFZ05F9GxCL
Content-Type: multipart/mixed; boundary="------------CoElzJMD7vrCkGFCadNOY00V";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lama Kayal <lkayal@nvidia.com>
Message-ID: <ff7796c1-c8c7-4dab-89e6-75aed80224c7@intel.com>
Subject: Re: [PATCH net-next V3 3/3] net/mlx5e: Remove duplicate mkey from
 SHAMPO header
References: <1753081999-326247-1-git-send-email-tariqt@nvidia.com>
 <1753081999-326247-4-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1753081999-326247-4-git-send-email-tariqt@nvidia.com>

--------------CoElzJMD7vrCkGFCadNOY00V
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/21/2025 12:13 AM, Tariq Toukan wrote:
> From: Lama Kayal <lkayal@nvidia.com>
>=20
> SHAMPO structure holds two variations of the mkey, which is unnecessary=
,
> a duplication that's repeated per rq.
>=20
> Remove duplicate mkey information and keep only one version, the one
> used in the fast path, rename field to reflect field type clearly.
>=20
> Signed-off-by: Lama Kayal <lkayal@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---

No reason to waste the bytes if you never need the host-endian mkey anywa=
ys.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

--------------CoElzJMD7vrCkGFCadNOY00V--

--------------13ecYHq273qxFRFZ05F9GxCL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaH7Q3wUDAAAAAAAKCRBqll0+bw8o6KIX
AQCS34H6lhmPhE9nlKaKNEIkgwi5RB5KcpatIY1ypQPivwEAn4x2lDFn4kpl72kCNX4++n309Q25
oY2bO4ysW08+JgI=
=+LS7
-----END PGP SIGNATURE-----

--------------13ecYHq273qxFRFZ05F9GxCL--

