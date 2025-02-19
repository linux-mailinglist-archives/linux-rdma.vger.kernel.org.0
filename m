Return-Path: <linux-rdma+bounces-7871-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1163A3CDBF
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 00:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7147D3ADB8F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 23:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B9325C6EC;
	Wed, 19 Feb 2025 23:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdwruVDL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4741C1F13;
	Wed, 19 Feb 2025 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740008711; cv=fail; b=IylYBVAo4iLMvibvCRBveEHqAOwwfVs++XWPPTNYBzVsmUtnObbU64xNVMdM37fwgRV7qdEtJWsPVQCU+2fahtag6ATXNTTuNK+zQ1C1rT63IWCSa/gU3eAG4Ue3cSRiPAyKvASsw72ByKJ7Q7OFB/9/UOn0f+hm4Vk0glI1v84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740008711; c=relaxed/simple;
	bh=sa3qCeawEDAaTGuBhBnlZy4jioshs2cE6bhynYEX2Tw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NAJRq4gt8iDIYk3HTkCjtyU8GmeqvKKTYx51N1zuizM+Y4aBGWYK3gkt6OGeACxakpqPrgRYvU/40jT8VBzpS8zGBCLuUiIHGELm4EcAJ3IYkqtv3kBkFP09WlkVup9VqZ2ou0m7QALuQdiv1HK2o7xU6zXM1XFkE1zme7DHipk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EdwruVDL; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740008709; x=1771544709;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sa3qCeawEDAaTGuBhBnlZy4jioshs2cE6bhynYEX2Tw=;
  b=EdwruVDLt4lBPAfjwlh5nIAkXbz9QY9iCoTYHdfLTRxNeNhjwmahu8u5
   P6318rVUevUBRwUi8ZsVepSZi8wLcEgB7l7npxnyWMfPENUtxQ+7guNgr
   5j7TgxtXLSq/gi4FuUp6mctDg91VhqMkJrFrvpWqRs6qBYINHa4eEUNFK
   EWrXkzJTzhmP8kA9QtNEuINb0eosX3vHNm3oqZzqWuW6T19mrb7K8C6ZQ
   L5+OQRXCZxlR5WYIY6UBJR+NwNx9ce19cJ8PW+Mwh7vOsw0UofbcgkLMY
   e1ElTLZSrk8tHSOVcBvMtHgWBvP1I0RHmOaCDFZc2ZRuCNvE2511or4Ae
   Q==;
X-CSE-ConnectionGUID: r5l+UrrHRjqiDtZuDPDa1Q==
X-CSE-MsgGUID: G14F38DTTLGiwoX8l3w51w==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40909904"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40909904"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:45:08 -0800
X-CSE-ConnectionGUID: 6xFTnPpaTxKN8TDhVDC92w==
X-CSE-MsgGUID: qxSMTdsuTxyTF9eMXJUHhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="152071447"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 15:45:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 15:45:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 15:45:07 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 15:45:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1hzw7QB3oHxtODQTdXTc4EBIYz5EqGUbb5E2SpqDQDuo1s5bQEsEsV6TpJodFH5DQHG8smTWAaiBiyzPuU7+YYJ59mVNL8rbcOFv5uGEFaUyEJes4V001Phz3+htlWPAFM562yGt2ON4yegl09JqQIls0qa5P/AzzmzbjBFiTnJTMrUOp+x2AXXxOZ3GI/Kb/zEwvRmjS6fckC+774v40S6p3gycVWoxvx5CiZHdHG2dLRFwkW4tPKBNg8tqZjjdxKjo3lB+qYwnMXcmqtx7rqFr3FJIfqNgBeN6ry18wMXbf/iDTU2qCfQRV/QPoGM7d3G12GaOy83V8WFpupGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5cIIf+3+6dYgmKsb9z9MF2bK16h8NJpR/zul+TGk6M=;
 b=VcGO9HRRJLXrXe7y3rmKZGkCLhbMe08ZOJTEDhYFo8W8mLeOCNIKrz23VmISWH4QxdNDl9s+mI/6J7sQ3Tj+atgFIQdSzL+NoFAeAHdb8Vb7l46YO46ClVSKe1pKI3iVQiPXcC2GtDHzu1SR0zfXQqp3nEDQuJ0FUWsXbX8Covvz2MEKyqbJ1TxEzYjwA0wQ6bAijTj5rSohx+II4HsJ5ZSHbsk9ESUKfIUzrjTomgUGj6VHFaPeVmFBC4CGFZ9MKWbXQNdol3mBBx+NqJjydublaIcxWLyTs4/gc+7wB/Q9TcpobzWwWs59uP5A/4+2xRsFeg4KAnOykKj1npwpZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Wed, 19 Feb
 2025 23:45:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 23:45:04 +0000
Message-ID: <48456fc0-7832-4df1-8177-4346f74d3ccc@intel.com>
Date: Wed, 19 Feb 2025 15:45:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Use secs_to_jiffies() instead of
 msecs_to_jiffies()
To: Thorsten Blum <thorsten.blum@linux.dev>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250219205012.28249-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250219205012.28249-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:303:8d::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: c47b44fd-0ec8-4f18-b6df-08dd513f6ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFdOV1djcWViZkJWUFMyRGdKVGV1eTMrT3J1Y1hQOExOMUN2Sk0wNnBCQUdk?=
 =?utf-8?B?dkpFMzVrU252d0hZYmNKWDExemhiTkVudzBZZS9YYUxsK1NCQlBVWG4vWkxi?=
 =?utf-8?B?Mi9ndGtHcHA2STFNYmNTSSsvWENrM2hGeTNLOXVaMkRBdng2c0l6YTRFZy9T?=
 =?utf-8?B?dHkrVDh1VVEyblpFOW4vbE40ZkFuRlVQQUdQN2dDT3ZIcThSS2ZwbGRvRW42?=
 =?utf-8?B?NW05bHQ1WVQvV2ZqY3pHUzh4cWc4WUFlbTBIWTQ3aCt3allpVWxZR1hqYW9i?=
 =?utf-8?B?Yi83MXFBL1FYK2Z6QjdEREIveERicTJyVkM2VFZaZWJTWWZPdytrTG9nMUUz?=
 =?utf-8?B?MmU4QWhmc1FPYUR0Ykx3R29rN3Q4MzZ3OGpXUEE2OFl3dGNkV2JXRzh6NlJW?=
 =?utf-8?B?QklCUE4vZnRVblNaQUl4WjB0bEtyYWFZTFFuVktBNERnc3hCRHlxQmw1OEVY?=
 =?utf-8?B?Q1huS21PelBGQnBNdXJwT1NmblZBd3pvaDFPVlBuSmlLQmdVRUhoTzVYWDk5?=
 =?utf-8?B?SVdlY2tsZlE3emFIN0p4UFY5R0g3YnZJSjh0dWFEeXhyZkxOTU1SSkpCcDJD?=
 =?utf-8?B?bi9TZFZKVUNhQlBMM3RlSUdJMFI2Ky8yNTRTdTNtTFkwSStrRlBvcVZqS1o2?=
 =?utf-8?B?KzA0bmp2NjFxSXRYRExMUEVaaHhuelMvczFnNnpTSjF3aCtvN20wZnJyb1d4?=
 =?utf-8?B?cDFaTTkzdDNtOHlZODVQck5oUmhCeFovMzkvZGtyMHVFeVdNQmtKNnNJRURK?=
 =?utf-8?B?OVZobDBLSld4RGh1MzBQM25FN0toaUxzeERRWmRlakZFQ2JxUEtHQWtINnhP?=
 =?utf-8?B?dEJBLzduMWVjN3E2WmhrdWFBcDVqMHIxemNleXpKUEUwc3ZVNEh4amF0MHNw?=
 =?utf-8?B?S2ZNckl4TlgwMXdXNi94c1l3bWs0cm9zeTAzdmt1TjJ4ckxpTUpSMFBHT1Rs?=
 =?utf-8?B?ZE5ycHFkNzlsOFpWZit2U3BGVEhDb2ZUMVN4T2lIZzh5S2JNTWN6V3YzQ05B?=
 =?utf-8?B?VW1uQk1GcHhqMG5wWEtxTXkxZGU4SllzZ3BkQ3pTRXRIclc3WmZWSG4vWDFG?=
 =?utf-8?B?NG0rYnZielRwTXBVMnBWMlQxam1yeTRKdW1YOFBhYllTZi9WNUNrVkZVS1pX?=
 =?utf-8?B?S2lHUFcyTlkxcjZZVWZpMUhUeHNtT1B1Yk5pd1J5V1JzT21CdzhwZDBkMDlK?=
 =?utf-8?B?M1JOeFBxaFlVMmNDZjMwWEViMDdYdytsajNNSWRYdDZ5Qkhhd3o0dVYyMktL?=
 =?utf-8?B?dGdUc1FRSzlXVlZqdHNjMDJZdlhNUExRWGgvQ0lvejQvR21wNjAxTWJlRm5V?=
 =?utf-8?B?b1R4UnpvaUp3VDFndmRkdWRFbTZtTjFDUzRCdU9mZEdwUnRvVkt6ZXQ3T29w?=
 =?utf-8?B?WU1BSkJTOXR4bStGZDRYVjVnbURwSFl5VktsM3hPSk9iUStsb1pTUTBUdUdH?=
 =?utf-8?B?aGhPN0VXMXd6VDY5NFJmZFAzWCtGNnlxNVF5TlB6Q3h3VllVNURFTVMrTHRs?=
 =?utf-8?B?ZkUvV2RGM216WTMwVFo5YnVQZ2tHZ3J4aXZselNqT0VHYy9WRDl0ZlllWmVp?=
 =?utf-8?B?cm9Eb0N0NDRDZ3BtWllra0tYMTRRQkwxWXc5cFd0U2ZXL2g1dXp0cTZXTitB?=
 =?utf-8?B?OWRhWHpib0dCNVFEZTd4TlBlZ0t3bGl3d0lEV3hJdUF1VWh0TlRPRXdEMHcv?=
 =?utf-8?B?ZGJWNE9oR2Frb1VoaGpkaysxemdpYWVwazJ1YlBjSXZNWGF1MFlETzhNODla?=
 =?utf-8?B?Vk9uZCtWT3BhbG82VTd6TFJVRDVTdmYzK2dwekRlZGtlRmJnanNPNDFqUWsw?=
 =?utf-8?B?Z0pkR3JsM002aVRSYmFpcndwd2ZHVzBTSHRWKzhuNHhHZFpwQWplRkR5VXJU?=
 =?utf-8?B?MXVRQnN4VTRMZlN2NDhwK2h2aWpDUU5vOFhlVkVuNHV5bDNqem5RVEVZNjI0?=
 =?utf-8?Q?5eCSTCsmX9g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGJxR2RLd0paU2hmVmhZTnZDeW04cUttN3FVSE8vSmxxbW5UQy95S2MxWVpD?=
 =?utf-8?B?Znl2VnpkWUh3SXUwcFJCQnMyM3hNcVFyYm5CNGRLQlA4VGdVRURPVFZVQ1BD?=
 =?utf-8?B?TDJyelFpUm9ZUkxrSlFpM0dWaUdrVXZPM2ZXQmNkVko5SVJqMUFMVThqZmtm?=
 =?utf-8?B?UmtZbTRjd2dVamJuY2ZYUkNCVThnSm41M2xOTmhYQzY2Q0lUMDhpckppOUtF?=
 =?utf-8?B?eE9xM3lYWUhFZHk1Wms2d2t0N3J4TC9WaEJheDFGSGhOcmQ3SnNJUmlRTzRq?=
 =?utf-8?B?bC9idU5VRlg5M0NDbXdhTytmb1EwbW16d0hBQnlqejVwSnpRMkJiaU9kRnQ0?=
 =?utf-8?B?dDRScHNkMmRzZE1Pejk5enVFbmhNV2JwdC9CY2pJQ1Y4SDRDYjltNnRiM0FQ?=
 =?utf-8?B?c244SExQWFpWaW5aS0pVN09wSWZjZ1E3bDFTSy9ldkM3aWtQNDU3Y0M0VW5L?=
 =?utf-8?B?cUw5ZXg2S3BEdGRleEh0ekNNMm1uWDNiNXVSUVd1L085dFdPYlVwbjZtMk84?=
 =?utf-8?B?Y0tQdW5iMDFPQ1BUa05pMVNvNXUxRUxYUTZEOTAyaXY0WHJjQTgzZVA4Z1k0?=
 =?utf-8?B?dDNCK0FhR3NiZ0J3czkwOU0zUGFSSGwyWU5pKzF4alF2a3hlVHlicGp3SFY3?=
 =?utf-8?B?d2ppYlduNXVOcEU1L3AxUFVoTGExNjVmc1RrRlZoK2lxbmdOSEgwUEs3aVFO?=
 =?utf-8?B?Mkk4bWZqYWVoc0ZTN3RnUXhhSmtPVVIybUUrbDNtY3pCSkU2Q29LM1oyWjhy?=
 =?utf-8?B?cFRYRkNTSFcya09uem1MVkRRTHZaSllLNFFrUVdpVkxPL1p3STVKNU9tVGFZ?=
 =?utf-8?B?UGthWmZzSUN4VXNEQ3lLaWtWK3FZUE4rYkZ1K04xbjA2Q1RPRWd5M0thVFhv?=
 =?utf-8?B?amZNYnVrMnhNRlpiSVJwTFQwN0xuK1BSd0R2d2NTb1JoK1BBU0hINGtSUnF4?=
 =?utf-8?B?Zm1PUFRzSHAwMHBmV092SDNIQWhpa0I2bG1rc0ZBcVY1cmVNNmtXS1JWN3NI?=
 =?utf-8?B?amxER09rb0g1Y21CTXZJckdIS3BnTDRnVHFUK2ZtTVZTRlE0TGRrVmV5SWhT?=
 =?utf-8?B?M3cvZHNNTUkyKytoM2JtOHRpd1B2NE9selNTeVJqeWFzT0hzajlMTTZiYTZZ?=
 =?utf-8?B?OXBpYXVqT0YvRE1LTGVES2lwRjFKMkU3LzFWaW4zVVlYclNEK1hjQ0FnRldo?=
 =?utf-8?B?aDI2M1pTdU1nQUs4ZWlzKzM2M0U2RUVEWmUxWFY2bE1PZGNxc0JZOTgwNERw?=
 =?utf-8?B?c21md09sd3lYU0ZjYTlqT0Yydk1jUW1HcWNIWUIxOUdUdC94cTJlQ1pKSDdw?=
 =?utf-8?B?dkRSTlNBeUlaYXpLRmhBZmExWnFJQmZPaXNtNm16MDhuTEpFcHZIY3BoUm5h?=
 =?utf-8?B?RHJWcmRtODZXN0ZaNlAvYVVuMTVBYVhYU3pXZStjUmttWW9Bc1Uzenk4cWFE?=
 =?utf-8?B?bWNzekprbm9MTUtqMFFTbFp6QlI2UWxPMTMrL1dVSWlsOXdxdDlVbkJzVGJX?=
 =?utf-8?B?R1gyOGNXVzdYdVpvZmx0YkFQUjFRUXloOCtEY1lDVUFuWEpUdlYva01ZcC9K?=
 =?utf-8?B?R0paRGttLzJNYjBiMGRqRys3OUZuNGhLLzU2UlZUelUwaHV6VG45WGJ0MXQ3?=
 =?utf-8?B?aFN5ZVlqYTFFU0M1VFltNXdpRVpTVkNKQ3dwaXpxSVg4T3lVeXVaU3JxaDMz?=
 =?utf-8?B?YnNPMlZSdytCOHFCMTFwcGNlaEJwaXhqeGdleWxZc2tpd244Yll0dmpIZjZo?=
 =?utf-8?B?MWxpN21ZNDYxR1duSGk5NjlHUThwQk93ZFlpOEl4ZGE1VG00OVlPSll4cFFZ?=
 =?utf-8?B?eWUvT0RvVTlpaFVWdHFFcXBlbUt2bW9hQWppSzlFcHdLOGxoNEpkWC9tRHM3?=
 =?utf-8?B?ZkpaL0V3ci9sNllkcVMwRjVQVXN6bk1ER0R3VTNBZzdKbHZIbGFHZkNmMFda?=
 =?utf-8?B?OHZoTXVIZnBRdXJxV053L1c1cHhGaW5rbGtZWWdjcCt3UGtBeTlVb25oRExS?=
 =?utf-8?B?ekdxakN5NjFSSlo0elhaUFU4WWlRQ3N2cVE5aDJWbUlCNFhiSVQwRTlDdTRS?=
 =?utf-8?B?ZmFVMkdpK3N0NHpxdUkzVVFDYWt5cklSK292V2EvVWdpclBvRmRQN090NkNi?=
 =?utf-8?B?c0VEVG1zUlRpejY3bWZtSFEzYkpxa0hSaHV3TzBSZjk3TEVVMjk2QTVDVUdm?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c47b44fd-0ec8-4f18-b6df-08dd513f6ec9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 23:45:04.1425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CB/SWtWOdkCh4RL/RKTpZfw8rq3IaWvlG7YWzecV1ojN8qGJ2xum3HtccL/BRrZaPmMWq+JqBbXgXtVKUacpjX3rjAjCfE1dC16orIXOgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7164
X-OriginatorOrg: intel.com



On 2/19/2025 12:49 PM, Thorsten Blum wrote:
> Use secs_to_jiffies() and simplify the code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

nit: this is a cleanup which should have the net-next prefix applied,
since this doesn't fix any user visible behavior.

Otherwise, seems like an ok change.

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> index 3dbd4efa21a2..19dce1ba512d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
> @@ -220,7 +220,7 @@ static int hws_bwc_queue_poll(struct mlx5hws_context *ctx,
>  			      bool drain)
>  {
>  	unsigned long timeout = jiffies +
> -				msecs_to_jiffies(MLX5HWS_BWC_POLLING_TIMEOUT * MSEC_PER_SEC);
> +				secs_to_jiffies(MLX5HWS_BWC_POLLING_TIMEOUT);
>  	struct mlx5hws_flow_op_result comp[MLX5HWS_BWC_MATCHER_REHASH_BURST_TH];

This looks like it violates RCT ordering now though.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake

>  	u16 burst_th = hws_bwc_get_burst_th(ctx, queue_id);
>  	bool got_comp = *pending_rules >= burst_th;


