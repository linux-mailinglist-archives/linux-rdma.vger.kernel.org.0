Return-Path: <linux-rdma+bounces-17026-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH/TFAqNl2lv0QIAu9opvQ
	(envelope-from <linux-rdma+bounces-17026-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 23:22:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ADC1631DC
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 23:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1818D300D4C0
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 22:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CA332B99D;
	Thu, 19 Feb 2026 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLjgFDbu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CD332ABD0;
	Thu, 19 Feb 2026 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771539719; cv=fail; b=BboLqyP0WbIh4zT1iLdsW0F/xJ4fN8ZgAwskJoMP/C7MLLHExWLxtw5xnD+kyh4q/m01gx0gzfoGYDMLvHKe06GqYUiWG80ySLgMo0Slo+T4qzKU2O9Dz7oQAsgmzWbE0WCSYSrbBCfey78Cmcm6aV2ja0BjNP/pE5GcqBw8Wng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771539719; c=relaxed/simple;
	bh=pKmEVqhfdz1vY0ARXyHtULnSZQiCrBE400xz+vodUc4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2QOVSxNa8ox3N8oD3iIAuNBlr+aYt/hiGXWpLUQ7ovYe5NY6HDOvLBKE41BAH91iT3xbL9CoC04qAtt7wtSCcLuSMu7yKmstUib8IGmz8UTPG1CfP5DhMfQIswLfMBGua8bsmARTi9UbbEv2c5yhpN2NrzsMrVcgA/NO8MSGa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLjgFDbu; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771539718; x=1803075718;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pKmEVqhfdz1vY0ARXyHtULnSZQiCrBE400xz+vodUc4=;
  b=lLjgFDbuKmAdp5mMqRmmFL1Rd8W7bJjvQCIgSqDT/CxHHiR8bqTCCArL
   25iZoNii/Vsa8wuvKRO/i0WkNRxKotc7a7OimFQgkx1tJTQCDLxlO5QG7
   5etTYGwAZPiAjWvk52tPei/HgVe0GphIzs9TfEZ3TmlYiJ0DVOsvicyiJ
   0d0+4B0MbpX3BBm21P9PDnvvRf2j6c9dh5jjDW6faSqK1aTanOTbC4zSh
   Ig2XoxD7UWLmLX6Bkx2Mpfj9FCxY0qMQAIz96uO8Nl1sF+ZdqpZkjGsWf
   Ju+lHq7sN5716BDpAl/jLMwwKKxRafAVsnBq8gkr05+CapfaB0mCslQXO
   Q==;
X-CSE-ConnectionGUID: 0KTt3s7eROysOrWz5Y/I0g==
X-CSE-MsgGUID: 52weru1wRWWpTjTB/7d8Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="90223667"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="90223667"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 14:21:57 -0800
X-CSE-ConnectionGUID: XrR11qvcT9qzlE0qwFSgOA==
X-CSE-MsgGUID: AG/I1RXGQ2uhuzMWtdGD+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="243232602"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 14:21:57 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 14:21:57 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 14:21:57 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 14:21:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3uJbs/ZlpX7PGwRrlsgGP7hJZkSP78BMvKifi5tbfCzRMndG4G65fVxWxGCwlLOVVzL6CpfV6gjJv/9idy2btLDKfBSo4ePfYfp37+llm9EuSH9LDSj2pQKgX1KZdti4NDerijelhy+uxPuypVZ7uVhOcqF2rNneqtcZyX8TV2HAH++6C6TPI1/+tRyPE7D6yqAnFs2WcDjItD/yydKwGEN19z3NbWWps532gOXLsUXNRbTbqd5QisD+wHGeR8b2SLr60JqqdoNzju+91tvfNqLdg9QVjmEJLg5BkCJVI3WC3uPNfaIuGr8uPF855zSs7cVSObk8Jy2LifH69EoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/Jd087MjXNKXKIzGre5+QThXaEanHiR8tU+3ae+9v8=;
 b=e7V85q3XCwDMrdFkoGJyt3CpJcQUnhTrc8ykeHlx+AzxJ3axkNmpxEYGBmSpfhLyxq0aw+4BNuOg2u3Y41+gFzQI5M8ClMBYYo6rzmNpQbQYUAWcJnzdy2I3ymsKofW/lcZOTnCU99C/rkEKXGcLGuU9/XxpC2PmbHfYqyZvqKCLbrfoCfdKpDm3fBDlUKf6kI/fptjx0K9oQ50QbBFyJW1y9ERQc6fqK/Z/b7C1JVOBrKsasdcIaWSOnPVpZuTWZ/qlY+pYFMbmLpslaOq3lvxdQQruWQpWSBsAx3Vijwx3RpPWkWJbjnt66CT3Kkg6UsESJ5X3+yeCJblMtvdWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) by
 IA1PR11MB6123.namprd11.prod.outlook.com (2603:10b6:208:3ed::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.15; Thu, 19 Feb 2026 22:21:53 +0000
Received: from DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e]) by DS0PR11MB7579.namprd11.prod.outlook.com
 ([fe80::4199:4cb5:cf88:e79e%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 22:21:53 +0000
Message-ID: <34a19eb9-57c3-4191-a0a0-215a249b2a40@intel.com>
Date: Thu, 19 Feb 2026 14:21:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] driver core: auxiliary bus: Fix sysfs creation on bind
To: Tariq Toukan <tariqt@nvidia.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"Danilo Krummrich" <dakr@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <driver-core@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
CC: Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Amir Tzin
	<amirtz@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
References: <20260219210435.1769394-1-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260219210435.1769394-1-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:303:b7::6) To DS0PR11MB7579.namprd11.prod.outlook.com
 (2603:10b6:8:14d::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7579:EE_|IA1PR11MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbf80fe-8246-446c-b018-08de700548df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2d0RnF5T0FIZkRFTHh6MkxhZEdKVkRYTVZ0UVRPT2ZlOHFydnlXN25qMHBI?=
 =?utf-8?B?aWpwQ0RKOEdRVzBxaTd2alRMQTNjQkFrYjhZclhmd1FvMFVnb0lxKzQ4UFFh?=
 =?utf-8?B?MjExMWZNdnZ6b2NNaEhEZWhpOVlTcHd6NGEzZ3JuYzREeE5lYjByeHRHQklN?=
 =?utf-8?B?KzZVQ2ZSSWt4emZDck91VkZ6cEZDdjFRS0NCQktvd3ZHTGpoYmgxc3NaSHVR?=
 =?utf-8?B?c01vbk8xT09TZUh0aHFpdEpub3lJeXpKblNZOFV6SFFaV2NOZ2VwL1UxcjVL?=
 =?utf-8?B?b1dyQ3BrNFRjMDdzZGp1ZTJyUWZHRXBzZXlFUVBNOTFnbGN1UG5ld0p5ZUVx?=
 =?utf-8?B?bDk5T2RwYTJ2VFRjQ3hGQ0I3V1V2TnFYNTUyeDRXOVZzdWh0TTV6eVhndVNG?=
 =?utf-8?B?S2xxVUEzWVQ5VS9UemVOV1prNEVrYmZVVGhnK1RMOTlRSGpRNUhhZVNrcm9I?=
 =?utf-8?B?c3YvRnlqRVU3ZUFwbnRmWjdYOGtVUEZQT3VnUGZSOEQ5UjF3WEZOZUloNzcw?=
 =?utf-8?B?eHY0WEVabVNNV2pINFhBLzJMaGRGUXJobjFGQjZUZi91bkhRQStab2QrZDVQ?=
 =?utf-8?B?RGkvNGpSRHo1WjB6RUxYa3llRUZYSEZYVTFIb0NJOXkvUiswZEM4alhCUUsw?=
 =?utf-8?B?ME5yYVZCVlBiNldwWmZCcEFKeFZMbVhwYUlSTDVKUW02cU5NVjlSeGZmUUhu?=
 =?utf-8?B?MHY5bnROZjcveHpJQncreEIzc2lFWjdkNFVjSlhaK25jV0M4WVlkQ3dQeFk2?=
 =?utf-8?B?UUUwUjJMQm1IdUVwWENMdW5Za3ByY1IwZWR2Q1djbzJRWFRDYlZsYnYwdE8w?=
 =?utf-8?B?YXhNN2ZKa3lqTnlSVWpsd0paYlVLMU9Bd0E5Y3RuSXgvRTR2UUh1dUk0VEhu?=
 =?utf-8?B?Vm94NWs0TTRWMDRSYnplR25NcFRuZmdGVVZvTlpwUk04U3lCRjlDSmRXUzhS?=
 =?utf-8?B?L2c2ZVlRSGZlVm5Ycjl6RTZHY1I2MGU4QkpZd0d5MmZzMTBEMS9aOUVqa0Uw?=
 =?utf-8?B?YXI2VHpWc3lGSDlHZkEvYVdaa1ZDQ2IyZ0ZtNThTWUx0NTlKTFpqYlczZDIz?=
 =?utf-8?B?VmdpS3R6MGcwdExLR2dFRGQvbGpvcWlMc243Nkx1VlloYWxxeEg3dU9DaGxq?=
 =?utf-8?B?UlBhS1VJWHlvbnRLNFZWenNCUVdHOEJXZldDcGQ2SC9TaFZsckRCT09BK213?=
 =?utf-8?B?NEdYdzdLNklZTHVLQ1RNMEF0OGE4czRZZVVyR1FlSVlKU2RCN2VFNVlPTUFa?=
 =?utf-8?B?VWlOb1dtMTVncXA0VkJJSG51dDkyWFVKZ3RJRHhYMWVpdzNhS3NUdVkvMG43?=
 =?utf-8?B?Tzl0QThCQjFjM0JwOUJaUnVoZE05VU5EaC9ReXFoczVlWXlrSDJWTm9XY1B6?=
 =?utf-8?B?MncwQ0h6MkhRNnc3MDhQMFBRaGNMVEo1U01GVWwwQ2taZ0NFalp4U2pPWGZC?=
 =?utf-8?B?QWQ3Vm9DSjhLK1FLODd1Y2hKSjNsbzBzWnl4bTgzRDhsR2kzZ0U5OEc1NTdu?=
 =?utf-8?B?UEdqWFNLYlpKOFlVL20zcHZXWWp3YUw1b2VjbUlldXlXT2E4L01RdUhnVG03?=
 =?utf-8?B?U3Z6VFFSNkNXNEV0V0JDL1kxRUZCdm43RmxsSUtFL3dBYVduNjNsd2pzS3FZ?=
 =?utf-8?B?SGtCSVY2N0ZyQ1hLUnBZYlhDZ2ZTRVlnV0ZCM2NkekZhdW42a2JZbnRSU1lp?=
 =?utf-8?B?MjYrVHBsc0dOSzJ1QzBTMFVSOHlxTmxKbS9OYmRRbzNyQXNkNzgxZ0F0Sndr?=
 =?utf-8?B?aElOMFhYWHVXMTVnTURiUmRYeGpPNGU2WmZCWldwWndWZUNheGFZUnR2VEdE?=
 =?utf-8?B?NUJDbUZNVGhHd1hQdnNXVk5aUklkdno4bkM0aDVSVytYRkM2bnZ1RXRWNkx2?=
 =?utf-8?B?MlNoU2t4NVE2Qzdxc2tBNDhjZktZNk1MMCtxbFl3cmZxaGpVZGlzMnovb0Rn?=
 =?utf-8?B?cGU3eTFzaXAzUFVFeXQzMGVaRDc2M0ExR0UwSU56ZGJoQjIzQS9VK3dkWlNk?=
 =?utf-8?B?ZHhaTFl4NkdtdlVlejRKTStQcWJnbFdTZEpsYmFNTDJ0QUNOamNYVDhCUjRN?=
 =?utf-8?B?bVluWEd0VHBoek9ZL21uTlcydkdmZm1iSmtFY3lORDJWTU9jYUU5WFh4dVpN?=
 =?utf-8?B?a3VoSUJubFZ5TUhuVytoSStUT3hmRE96YUMveWRucUs1Um1vclloWWJuWC9T?=
 =?utf-8?B?TlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajJGSXR0L1ZuVHZaajhLb21NSWYwc3B2ZFdMYS8vaDk5RXJ4d0dhaFNienFp?=
 =?utf-8?B?eEp4TVJvOVkxVWFCNEs1WGZTMG00ZHIxNzcwS1dSQWQ1R3Z6MUhicjBkZ3dB?=
 =?utf-8?B?SjJJMSt1WEMrWWhxZHN1NkRhY3h2dmhIcTVGUEYxK0FqTy9GRDZKM09aR29S?=
 =?utf-8?B?L0FhZUgxeXFRZFVWWU1rMVNWcUFnVXJCNW52L29aREVwaVhoYURZZ2dPSUdk?=
 =?utf-8?B?blFLQ1g4ZkFMTUdLLzQwZnBGTG1BZlk0S1dvT2hEU0M5REtyRUREVGowclI5?=
 =?utf-8?B?Mi9ZUDUwenZCOTcreUVhL2hlWmduN0wveFRjbE9kSytDS2dEK0pQR1ppeC9E?=
 =?utf-8?B?WVlyK3dDWWJBRGhidnBPTFBCOVJoaS9JV2p1UGVFNzJQSm5BaUFNcW5RZTlC?=
 =?utf-8?B?NUx3U21Iem95QlF6QUpHV3Z5TzZpWFBoeFZlZGRnSmlYVlhUUkhNQ1Bjdm9t?=
 =?utf-8?B?aWVGanIvaVBGNUZYNjJRQnVNNmJsZEZYYlRFMjhEa3FHS0p4Vm5CSmk4aHds?=
 =?utf-8?B?SUNVT0Q1ZEZrUXZMRUNlbWR0SXJCSWdjNWxsMVBINlZQSktwa3pvNGwxUWRu?=
 =?utf-8?B?bVc2K2czS2d2R1loVlErL28ydnhLYzlkOTRvazQ2Rk5UN0lvK1hnanlCRk03?=
 =?utf-8?B?YWFNaUJIbXRBaXNCNDV1emQzMVJuTTBWRm1Gb014Wk94QkgwdjFIbERka00w?=
 =?utf-8?B?a2c0M0haNFJmd3pFcjJoQkhtQWtkWEpLemFVWDVLQ09HUFR5VTBHZ2dSbDRE?=
 =?utf-8?B?WW8wNC9TUm0zWnpDcG81OFZ5cnRuWkZJWFZYcXEvd3Z2dWRadTFlOWJCcFpH?=
 =?utf-8?B?b1RURTNLejAyZHdZMkcrK2ZXV1AvNWNwajVkWnNJUkpXS0Vkc2RxWWFUd0cr?=
 =?utf-8?B?L1R6enQwckk0V3htS3BNMVFTMGpXUm9UUzVhSnZKdGZCS3NtR1dFUkVLSjJz?=
 =?utf-8?B?YzZsais3b3BRalFhdmNvbU9LWGcrd043eEVmTDQ4aTc5SnZFaDNhajlhd01Y?=
 =?utf-8?B?Yzd3QzkyOHRwbTNvc0Z0c1psUWlHbWo0VmtDaW9scHhBaUtaeCtJRVVNY0Jp?=
 =?utf-8?B?cW5IQ3VwUDVZZHZLMnhUd0JXOStaWjE3U2NnR1g4THdSdUJ5MHg2VUViUnpO?=
 =?utf-8?B?VFFiYVpJYll5NVJOdUJ0SjdmdnRRZ3ZzOCswTC83QnpuRlZkemhSTHJvZi93?=
 =?utf-8?B?Nm5rb0t6SXE4SVN6T2NJZWFIMTNQa3pMSTNZNnlHbDBnb2VMekxXSkRWQ0M1?=
 =?utf-8?B?MEhpNFovS3RQSXZycWVsQnNSMDVtK0JBbVIvTmJGMlE4QW9oOFlXSXd1N05L?=
 =?utf-8?B?d0JGOUtQTDZnOThkbUxSRTViZDN4QVhtRG40am00NVhIV09WR1l6SjM2aC9O?=
 =?utf-8?B?SG9ZR25vaFN5MnYxcklYNlpDRWFpZTd0aHc2VE8wanRab0pCR2xCa1ArQmRw?=
 =?utf-8?B?bU9CVkJBSmlla0M0aFd6RkhBajFlSGxaQjBSaUFWM0I5U09ueVZmZWQ5ZDBj?=
 =?utf-8?B?aDhzTXE1L21EV0Ztb3c5M2kvNGx6KzFoYVZIdVp1K3k2dkRUNnRqaE0zdUZh?=
 =?utf-8?B?ZllhTTV2S0F4d1NtcFJIU3BWd0NDQTJ4T1A3Z1NzTmhoVStiOFJySldSMmFD?=
 =?utf-8?B?ZTk5U3N3SGNyWk9tYSt4Umh3dzdQV1B4enhzK2hJYkRyMzI5TEI0NjZmQzM4?=
 =?utf-8?B?VTdUQ3hac01tM1pEcWhHYTA2VUFPckpmVDhoSmhLNFgxS1JhNXhsWXIrM3Zv?=
 =?utf-8?B?dHpOblNuZEltaEVMTUFjdXR6YlozWi9RRjNVTGkxaUNtOEVaVnhXQ2RudTdj?=
 =?utf-8?B?MG55RlZmcS9veUhheDA4dWRzcHBvbWRIekNWeWUyM04ya0VJMFVhUHVDZkxW?=
 =?utf-8?B?YTM0K0oxWnVtVVRNbU11cjF6OU5nam5UZDNPc1ZxRHlNTWFnK1dmR1paalRs?=
 =?utf-8?B?TFp4LzBieFg3aEE1WXd5R0hBamVVNGJjZTFOR205cW1KQlNtdVB2UG00dVdu?=
 =?utf-8?B?ZXNyMHkzSlVQaXVlWDAxcGJaMFhUOFBFQ2R3UDdpRTk4U0xqUVpzM2E5dk4w?=
 =?utf-8?B?L2JCOEhSbHJoRlkwcjJDNEJJc04yS3luZ2tsaXVYamN6UWJaQW52eUgrMUFC?=
 =?utf-8?B?d1I3aitBQnhYUGp3VjQ3U3ViL0FLbTRCSEN2d0ozcDQ5cERUdi9BcTVCeHU3?=
 =?utf-8?B?bXJVSFBWUWJ6V2xrNWpIS3dHNFdVSDlPZGQ4cmw0VHZwSzg1VElhdS9zM0FI?=
 =?utf-8?B?UkJJenA5ck9OQkpJM09TbVJGU2pYREphYVhxcFNGQlp3SzVjMVIxZG1RS1Zm?=
 =?utf-8?B?eHJURk5OeXJZSGFtSFU3cFZER3NOTVFQNWd0WHRLdnFveS9jRTBkc0Qvc09u?=
 =?utf-8?Q?fKQF1wfc8SDikBvY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbf80fe-8246-446c-b018-08de700548df
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 22:21:53.4735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTcVqi14rQgis1K+igvSKuoK+B7u6I2UvCPJId+zJrxKXCX6Fo0LOEvhh+8p4Fnzb2wQtYR1ExWIAZZEu/wtSVAtKAJN27jdixPPspnPp1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6123
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-17026-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: C1ADC1631DC
X-Rspamd-Action: no action



On 2/19/2026 1:04 PM, Tariq Toukan wrote:
> From: Amir Tzin <amirtz@nvidia.com>
> 
> In case an auxiliary device with IRQs directory is unbinded, the
> directory is released, but auxdev->sysfs.irq_dir_exists remains true.
> This leads to a failure recreating the directory on bind [1].
> 
> Expose functions auxiliary_device_sysfs_irq_dir_init() and
> auxiliary_device_sysfs_irq_dir_destroy(). Move the responsibility for
> the IRQs directory creation and destruction to the drivers. This change
> corresponds to the general concept according to which the core driver
> manages the auxiliary device locking and lifetime. Now the auxiliary
> device sysfs related fields, irq_dir_exists and lock, are redundant and
> can be removed.
> 
> mlx5 SFs, the only users of IRQs sysfs API, must align. Create the
> directory before a SF control irq is requested and destroy it upon
> its release.
> 
> [1]
> [] mlx5_core.sf mlx5_core.sf.2: mlx5_irq_affinity_request:167:(pid 1939):
>     Failed to create sysfs entry for irq 56, ret = -2
> [] mlx5_core.sf mlx5_core.sf.2: mlx5_eq_table_create:1195:(pid 1939):
>     Failed to create async EQs
> [] mlx5_core.sf mlx5_core.sf.2: mlx5_load:1362:(pid 1939):
>     Failed to create EQs
> 

This approach looks sensible, and managing the lifetime in the parent 
driver is easier than exposing the extra locks and adding more potential 
issues for mismanaging those locks.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

