Return-Path: <linux-rdma+bounces-12538-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A464B1560D
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 01:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6125E18A818F
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 23:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F27F2853F8;
	Tue, 29 Jul 2025 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GkfjBOeg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB8817BBF;
	Tue, 29 Jul 2025 23:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753832017; cv=fail; b=UugnSoqd3juUPuai1W1jxt6VrViarYKQRcDVrjgcovEJBYHOQXcmc5CQr2jMp0dCPENAGwh2651nz+zsXSt8gzLzZhmk4uhHYubDCqbHBTTQ9+1QCR2SvDN0neEFx2/MO1tAcAzGkcW34Ukww9xyGdUIrvfFf96Kmd5jcpK7oH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753832017; c=relaxed/simple;
	bh=XQlpzD+FdiTG+hoz7bLzwS75daYeoIKnnl8kzKyynH0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IPPfKT+lb1F8ooR3dbLbXlI3Jg4VDpltZeS7J4652HwmyfDooZ/EJoVETXJxLYdvEELNkIrK/ynMAZ6A7UQrLO4/cwiEPYgpV89a2+ObCVLDs8TIxvTo2VDB3AIs4CaFD2LEK0K3nO2ja6NcBaMYqG21wbLfssiCYrwyPtV76bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GkfjBOeg; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753832015; x=1785368015;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=XQlpzD+FdiTG+hoz7bLzwS75daYeoIKnnl8kzKyynH0=;
  b=GkfjBOegm27tzb9gKOxr5sxYmNm5v6zc9KdEoMNo/KJ92hnwwQx9E85g
   +Q5RFCuozi+Y9ZM78hx86CXk27eBgiRwsaZYDGnWsyQrwffQGZRd+EUDE
   mGoHRbJ+2QMo4st403SpMguc1F+8p4BbdSK68M+jJZfmshzzOJdf0xDto
   m5CJixTbTAxFHY7U4AXFoHQncdrX/bQ9P/WB45LdXU3P8XEUX0jSHf88z
   YfoP3XvY1L6rglUa2tI/C7iJuqkfDYbNV5Q2fLxl38aRpGoCjiW9WLHAk
   xz/dZjbzGADyIPIH60WBfg/lWqYAucqgYS+BH7rO2b1hDk180rELt0Kvc
   Q==;
X-CSE-ConnectionGUID: oXT5dNdcTfy8tkkG56aJbg==
X-CSE-MsgGUID: 9wSYexs+Q0iVqltqTr0mDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="67561632"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="asc'?scan'208";a="67561632"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 16:33:33 -0700
X-CSE-ConnectionGUID: pFAjUPU9TVit/i8gbCmrSg==
X-CSE-MsgGUID: +ofK7+irRGGJz7sy6WuBnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="asc'?scan'208";a="200012516"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 16:33:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 16:33:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 29 Jul 2025 16:33:33 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.41)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 29 Jul 2025 16:33:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWXwfhXPffvKjW+XWi5o3j/IPNBL9thgnLx0kp4h51C6VoRPHxEFqvSIBrkvEqdPG77H+PU0VXRVnKjFXdrD7fu41uq5iceuc1E0lOXyV1rQuK8LQ+JbHsEsJ243v21QpfXs7gVZTrxCDHl2HbEtXv6BQCTKTtRb+WMoTnjPK7jZrPZxZCKGQEEnVgXJDhaK/JiGQXGOu5f2embyMrxHbTalIdx5YSXJoHBdOk7ufdIFjiTaf1k9iTKtukGzAr4ljR8fyPkQZxFVqrCd08NCoy0IfpEQjN3uERtziUUiIfrirpyAtnsHoxaOM9N5WaW40zjXRH5G7iFNSIXRudLGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ork2xJeuaoPML600yIX43ms8H/oVqZjcXmev0z2YsyY=;
 b=UFJjP2g8759yIBhfGr2F7A6s9Ce70iW5YOV8vbM7dsMWfwV5tNZ3TqHf69eiDDl0W8SnUYPodEWOtuq1pT4GvxBb4pO0bhxXyEC7x8a9Zz1QaE76mE+8+wabhEaRAgwzyVUVG8wrCQiJ3AB4MmtB4ja6TRlfF4YJpZsKuIOy8qbsZZyYpIgFZsQpgoAX9HCy1oOKmEC2TUhY7JZCDMkJZyOLYliZgHF/HcnRzdDyoo51XK5FZ01jRD3HEWqqnYpcZik5zK8ls/zbTqLPfl8xsGgoHL72qYKwXYboidAJyd3uj5DEo9N0PEDNvhDVzzFkMTc/uG2RiSI6EWvxKlTQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB7359.namprd11.prod.outlook.com (2603:10b6:8:134::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 23:33:31 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%5]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 23:33:31 +0000
Message-ID: <86471b96-fb30-450f-9934-ec76851791ea@intel.com>
Date: Tue, 29 Jul 2025 16:33:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] Support exposing raw cycle counters in PTP
 and mlx5
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>, Thomas Gleixner
	<tglx@linutronix.de>
CC: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Mark
 Bloch" <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
 <20250718162945.0c170473@kernel.org>
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
In-Reply-To: <20250718162945.0c170473@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------VqtA1xS0ZKrboCZW9yLjZoVE"
X-ClientProxiedBy: MW2PR16CA0042.namprd16.prod.outlook.com
 (2603:10b6:907:1::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 98da0cd1-ae46-4974-0081-08ddcef853c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q05XMEdzSlgrTjVFUHJGYmNWNGZsN01Hc21wcHNTOFBLUW1EOGVjU29rc001?=
 =?utf-8?B?eDZKZFlLM2MrMktZaWl5ZC9teUVKNG11M1VtckZ2SVhjbUNTTGUzUzF4dFJq?=
 =?utf-8?B?Tm41QXN2THQ5c2Uxb2M1d1ZYRWMwQVBuRU5JeElIeCtSamtUUFpNMVdVbUE0?=
 =?utf-8?B?THhzcmkvekpXVGNjK01vb29xaVpXTlVBUlc4ek1kSVZQd3o1N041d0RCZm1T?=
 =?utf-8?B?QmNsREd5NTN1YjRFMjR3blFza0hLalkwOG1nODVJMkNqcEZGSWxxNVlOMjNX?=
 =?utf-8?B?N09tVnpsam85Ykh3c2REOFl3NHZDOUxDMDZGY3JFaHpwMjhCb1V5SWFuYWpw?=
 =?utf-8?B?ODFDR01Lb3drQmQ2ejlOOGdNaGRIbWZXZ1lrd2dGdzl6NzBTMkFOR1JzVFBp?=
 =?utf-8?B?N2ROM1g1amNMT1E5aFBJL1lhd0YrMFFBZjB2M3RoZ3RZaDY3TzVBay9FbUkz?=
 =?utf-8?B?YjlxQXFjV3Z3SFRuY2xyeUhoOEdicGdjamFzUzNIcEJLZERpbml2VWt5UmVm?=
 =?utf-8?B?UmhKTDFpWTh0STV2a2l1Tk9MR3I3YVBEeTBrU1NsTTgwVy9lY0d1UHROTGY5?=
 =?utf-8?B?QlNkaCtvOSszV05vMzhLMGw4S2dOVmVDWCtIMWRrTzZ0N0cxRFIxV1hNdW5Z?=
 =?utf-8?B?UHRwdTNsOVk4TGRYNkhrZVUwQUFYbTh3aTA5dWZFc2Y0RTR2VENVTmtsWmZ0?=
 =?utf-8?B?YUFnOTlFdk1NR2VtSnIxZXpGemxVbEJOcE00Q2I5T3RESFlhNldGc2Z2ZzBy?=
 =?utf-8?B?a3pDN0pQOU1EWXQ3NXZGaVk1dG1DL1REeDJHcE1sU0JLUXpqZ2RTZ0JCQlN2?=
 =?utf-8?B?N3dMcUhiMHRwREZtWExvMzcyME1tb0Y5bjVnTmpwbk8xbzVRbElpRlBiWHhX?=
 =?utf-8?B?ZTVmNkp3YWQ5dHJOK3hSSE02VUs0aDh5bkxTRDQxZ3A5WERBRXJabmRsSWRt?=
 =?utf-8?B?VFIyN01oc3hQWmJKMlkvT21JYk1xdUtycWNrK1o3N0d6dy9kYnRYSnFFbzln?=
 =?utf-8?B?M0NFL1lFVGxqd0RtQ1I4VmpTK1d2L20xTmJudno0SmJzZnZLUGtjcVB0bEV3?=
 =?utf-8?B?M09LVStjZ1QwdTlQOWhXbDFESGxmcFVyNm5UQm45cWJ5NTRVQ1lGd3dZT1ZK?=
 =?utf-8?B?QkhDTFFhVmFJMVRmVm9NL2hwMnZVdDhYL05adkFwakJCYlg4enh2d3NVeFdk?=
 =?utf-8?B?clU0SlNWQlEzVjQrN1ZUTDVPWGpicm5iRmRMZDF0RG9DSlhkOWhyUzR1SVEx?=
 =?utf-8?B?VjNOSGZZZ0FFYTA5anNweFZKVkVNL3pzMnVRWGY2cS9pVms1UHIvTkQ0U0JB?=
 =?utf-8?B?QTRSUllZM1hzZUE5RnNYb0ZDSTg2K09nbzBTcDhSR3VOS1huVWllTmpmUzIx?=
 =?utf-8?B?QldlT1duV0lyN3NHOW9FckN1RVRhOXRKdDNqWTFJc1FFa1hWUldJMVRobkR6?=
 =?utf-8?B?YWcraXB4YVYxblFja0VBNmZqbUNzVk9DZkdkK2E4ZWt6SDc4MHFLaXVJVUph?=
 =?utf-8?B?M21wUURmZXpJZ3I3Yk5ZYVEwTkluZElUdXhWNVlCTXdHOGdnUVMxT2hGQ0Vn?=
 =?utf-8?B?M3k2SnNIWDBIem55amZSRWh5aUtKNFdqRCt5dFFOdXA0SDBDOVFiUXdsdFE4?=
 =?utf-8?B?R1JnZ0FJUTQvY1MwSDBLRVA4L2hMUGRYRm9Yc0svZlBQMXR2a21NbXJQNEhC?=
 =?utf-8?B?U1BjZ1lLYXRySkFIMDdwVDVDNVdLNHc1Z3djV2NnSHNHVUFNRWdTUUFRajd1?=
 =?utf-8?B?YzR1WFB0T25aVVhoNVBLblU1L09vbUxxVHRCRGZKU1J5Q3VpSGwwalVHMTEx?=
 =?utf-8?B?enRkMXJ0YjJuaWxzV2QvSHF2Z21rbkYyaFA3aXdObnhjRUtDVWtvUURDUlQ2?=
 =?utf-8?B?aEl6QTBtYklRWGZtajV2ZUtHUlRsaSs0K2t6VzMwd3pCOXIzWWt5cVRybE94?=
 =?utf-8?Q?2yFKM+UYpLI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzRzVExVRFIyZUhqMFp4MEhXc3JDbTY5ZmFMeVdMTWtzTXVvbnBoYXJvamRz?=
 =?utf-8?B?bmlBcGhJYm5ja0hRSW9GZXYwcTlKY3JrTGZRUitJM3ExdnprVm02bml1WDdV?=
 =?utf-8?B?OHFzRUEzTnJTOVBCNytNTWxHQkQ4MkxkdnFiOGVaSkNUc1E1TDFpMHdJd0Zj?=
 =?utf-8?B?QnFiL1p6SFRzVlRHaCtRd0ltcTVaeDdIU0djd1M5bEFoU0tkajJhRTVlc29l?=
 =?utf-8?B?aU5IWkk1V09XOC9MUDgvOVB5Z2hTSk1aRHJ6ZlF3ODZZSWU3RzhVS3plZHdI?=
 =?utf-8?B?S2U3dlF2ei9WaC9adGF1Z256Q2RLRW1aTmlIclQ0VlRCRE8yNk1TN095QkF2?=
 =?utf-8?B?R2xMcm45WW9sWnNzNThnYW15eVhHYlFqZE9FTWw1QnRxSW10K2gwRll6UnVt?=
 =?utf-8?B?a2ExN0U3ZkU1WTRNRmduZVgzblpIMEdhVnEvcVorU2Zxa1dRbWFiNms3Q3Bq?=
 =?utf-8?B?UU1EOGtXcVNVeHYrYUpjNTFrWUxhTXhLZHRtYmN2NmJjOGtTUHhzV1oxbGo4?=
 =?utf-8?B?ZllEb0tLdVBSdDVhR0k2VGY3T1dkSS9aWFA5TUtMR3AwVUhWN3dDdTZBRkdr?=
 =?utf-8?B?NVZxS0tlTXI2VEk3T2VjcjF2YnFjSjhLSGxFS3pBbUJHZkU2blFWZ0k1eW5z?=
 =?utf-8?B?d1BZVEVyYTJlRGJlNXVOYTU5L2VxUDBuTjd3cjFNallGMXhYZHRIL0h3VHo4?=
 =?utf-8?B?NkpHdVRTSjU1OXlNRkU3ODEyejliQ0xSOHpHUVcxb1hscmUybkkraGxOSzZN?=
 =?utf-8?B?VlJmNTljWlozamo0OW9XenV1ZS9SOGNwL0I2YmVxUzBPdmVOYzlJOG05WXgr?=
 =?utf-8?B?d2dISkJQQXdVOHd3aktLaGQ2UFFjbk03L0NjV1hPRUsvemg5N3NKNi9wbVEw?=
 =?utf-8?B?Y0Joa0hqbDdwdHErOGFVbmF2U0hPRWFVNXliUXlvSUs2clpncEt3NWFHRVFj?=
 =?utf-8?B?TkxBN3dhZUFMU29UZEZhMW12NlNMcGQ3c3F5cjVtdkVxUStHMjZ4N0lCMmRy?=
 =?utf-8?B?bkk2clBrRDQrZ1l6SW40TXpZT0hIYlVCQUE4VW5kU1NJNGZwZFcxekg1SUpj?=
 =?utf-8?B?cmJ0SEhMV1dVVWR0L3ZYVk1wR0FRR2VDQVNrNnBBZnhVUURyOUxBaEg4VEF0?=
 =?utf-8?B?ZUpSd04wR01ibkpOc3R3VDcrN1RuQUdHL285UCtoajhsZDl2a2VkUUpkTklF?=
 =?utf-8?B?ZTYzZkRBaWJkWVNpNml3Y1RDZEZxN0xZRGRycUZqQkZGMkFlR3Z6MGlNR2pv?=
 =?utf-8?B?WUdmQWZuMFlWcFE2RUdJNFFXNll3cjd1eGRxaXEyVXVKNlhoaTZlRTBXOEhu?=
 =?utf-8?B?NDk1ZUYzOUJleURpMStGTHB6eHdRL3loQlpIRnd0MXZwSWoxQVQ5QzNOaWxG?=
 =?utf-8?B?UWRVWjVETnhTMWxlUGxXOXo3OFNKOUJ5RTROaVcrWnJ1V3NNRmIvVGNBQXNo?=
 =?utf-8?B?aWRGTlU1L1E1Ym0rV1ZYVDZ3RU5EL1Y5Q0hMS0h2RjlsMVQ2MXArMDhSaWlo?=
 =?utf-8?B?MWhZWDVSOXBVaHRlMFhkWHFYdVU2OW41dGRyZ0xoOTdxSVZ5OUxNQkc1SUhM?=
 =?utf-8?B?VU5YSjY0UDdKK1JWTHRCYjJ4WER0bTVvSXlmLytiK2QzRHMzdXJZKzFVS2FD?=
 =?utf-8?B?ejRQdDVKbENMWUgyMVNsVk51bUVxalE5TnhNMlp0dGxET3RLOWVPSW5CMlZV?=
 =?utf-8?B?NjViYjdoMmlPSWNoY0psQThuN0RXdXZkbDg5dTBpSE1xNERhTGhvQ0E0cmdG?=
 =?utf-8?B?ZWdpS0hyZ20vWVd2Q2NBZzBERk1FNnFTK0ttUE9lZTdXQ1hhbG5MZ1ovUnMz?=
 =?utf-8?B?djBEMHNQYjEvcFJVYTJNaDRwNUE0WjRUQVljekJ2YXhMdDFYRGNrNEl4N1Y2?=
 =?utf-8?B?UmFPamVsajdPSDJmMkFFbGNaaWxEc1lpOFhkZy8xR0NsM0VtSmpsRVVhMGpQ?=
 =?utf-8?B?Y3BvQWFYOXB1ZnM3MFRxbjh4b1U1alViTkJ1dnBaeDZDK2QzUEpuWGl5ejFI?=
 =?utf-8?B?SG5yUWQyU2pYNDZsSmMvcCs4Vm9MZTd0YzhNa2RBYXpvTUhUYjJ6YXFmcm1K?=
 =?utf-8?B?eTM1KzUxa09TYkhEUnk5bkY2Y0dMZ01ocDVoQmZYWWFEOXVHb0VDTTBHTE11?=
 =?utf-8?B?RzB1SytxUnMzZkVKTEFZT04veTBmZTRFdE5kMmpieWtvM2J2UVdnZXJwT2da?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98da0cd1-ae46-4974-0081-08ddcef853c4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 23:33:31.0976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYfOyAE+NkaIsusYpYD3TJD8Fu9FL0TG+UgNzmbzyrrOzZMZ2jrz88/RJsOqDaW4vn5nHseAvqyTSav8RCxmdoYZnP73FluagysgpMB36M4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7359
X-OriginatorOrg: intel.com

--------------VqtA1xS0ZKrboCZW9yLjZoVE
Content-Type: multipart/mixed; boundary="------------A2l8hlkt2MBFxXQmK8P8icjr";
 protected-headers="v1"
From: Jacob Keller <jacob.e.keller@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Carolina Jubran <cjubran@nvidia.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Message-ID: <86471b96-fb30-450f-9934-ec76851791ea@intel.com>
Subject: Re: [PATCH net-next 0/3] Support exposing raw cycle counters in PTP
 and mlx5
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
 <20250718162945.0c170473@kernel.org>
In-Reply-To: <20250718162945.0c170473@kernel.org>

--------------A2l8hlkt2MBFxXQmK8P8icjr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/18/2025 4:29 PM, Jakub Kicinski wrote:
> On Tue, 15 Jul 2025 08:15:30 +0300 Tariq Toukan wrote:
>> This patch series introduces support for exposing the raw free-running=

>> cycle counter of PTP hardware clocks. Some telemetry and low-level
>> logging use cycle counter timestamps rather than nanoseconds.
>> Currently, there is no generic interface to correlate these raw values=

>> with system time.
>>
>> To address this, the series introduces two new ioctl commands that
>> allow userspace to query the device's raw cycle counter together with
>> host time:
>>
>>  - PTP_SYS_OFFSET_PRECISE_CYCLES
>>
>>  - PTP_SYS_OFFSET_EXTENDED_CYCLES
>>
>> These commands work like their existing counterparts but return the
>> device timestamp in cycle units instead of real-time nanoseconds.
>>
>> This can also be useful in the XDP fast path: if a driver inserts the
>> raw cycle value into metadata instead of a real-time timestamp, it can=

>> avoid the overhead of converting cycles to time in the kernel. Then
>> userspace can resolve the cycle-to-time mapping using this ioctl when
>> needed.
>>
>> Adds the new PTP ioctls and integrates support in ptp_ioctl():
>> - ptp: Add ioctl commands to expose raw cycle counter values
>>
>> Support for exposing raw cycles in mlx5:
>> - net/mlx5: Extract MTCTR register read logic into helper function
>> - net/mlx5: Support getcyclesx and getcrosscycles
>=20
> It'd be great to an Ack from Thomas or Richard on this (or failing that=

> at least other vendors?) Seems like we have a number of parallel
> efforts to extend the PTP uAPI, I'm not sure how they all square
> against each other, TBH.
>=20
> Full thread for folks I CCed in:
> https://lore.kernel.org/all/1752556533-39218-1-git-send-email-tariqt@nv=
idia.com/
>=20

I agree with Jakub about the need to properly explain the use cases and
goals in the commit and cover letter. AFAIK there are no current public
APIs for reporting cycles to userspace, so this really only makes sense
with something like DPDK. Even the XDP related helpers expect nanosecond
units now. Its unclear if we will need other parts of the APIs to also
handle cycles, or if simple ability to get the current cycles is sufficie=
nt.

The API also doesn't directly provide a way to query the expected or
nominal relationship between cycles and clock time.

If you try to just use PTP_SYS_OFFSET_EXTENDED_CYCLES to compare a
cycles value to a clock value to adjust a timestamp, that requires that
some other process is keeping CLOCK_REALTIME and the PHC clock
synchronized. When handled within the driver, the software typically has
an assumption about the relationship based on expected frequencies.
Thus, a conversion from cycles to time uses this relationship.

You don't appear to expose that relationship through the API, which
means you can only infer it either by knowing the device, or by assuming
CLOCK_REALTIME is already synchronized with the PHC?

I guess userspace could also simply build its own equivalent of the
struct timecounter using this API.. hmm.

--------------A2l8hlkt2MBFxXQmK8P8icjr--

--------------VqtA1xS0ZKrboCZW9yLjZoVE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaIlaSAUDAAAAAAAKCRBqll0+bw8o6Pp/
AQCAoZ+8uKIEeYwzpXX0fgcFenfuRw+R9BolDv98SPx8ygEA7Y8BCcJpXqcetGWcVwTc0KS9ig+N
lMy3TkMWVPVTYw0=
=Sw3L
-----END PGP SIGNATURE-----

--------------VqtA1xS0ZKrboCZW9yLjZoVE--

