Return-Path: <linux-rdma+bounces-6944-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61212A084A7
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 02:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E75188BABF
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 01:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39DF3FBA7;
	Fri, 10 Jan 2025 01:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bf9s3se5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD852DF60;
	Fri, 10 Jan 2025 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471756; cv=fail; b=bLa0VBYbNUxU3OocnsYfsMjPubwte2UlvRjlPXNmMHZBrzHRL1SiSUke0rwT293Swom/K75ArZdPWEcv69sPwnjQrkcGsCSLJloDdu2wsO8WzPYd0fRzmQliHzuVOr0vThfCyN+8Lgqtcj8TL0pi2guLGSmO9LaXA1Q1DlqyaAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471756; c=relaxed/simple;
	bh=f+3MviRYcdmU7SmF2Pa/p7nrxRE7aHvz1jaklwsPMb0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K5qDy/0Gu0LJKRWpLs3Kqy8qzP1taGjllFOb6bDLftnpH8LZqdt03dCic47CB2Oy2BX0FSSWBrC+MDn58Guv6baeePWdyPk27ZVSw94cWhaIGydq78Ie+4UTDWr5QMl2A1brhtTzdKOpeHrvNUnr/1iQ+37LFu3Lk36Y4EGKQB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bf9s3se5; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736471755; x=1768007755;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f+3MviRYcdmU7SmF2Pa/p7nrxRE7aHvz1jaklwsPMb0=;
  b=Bf9s3se56No1hLGKP21LVi3rH9dX11ZNHb4iFWdhN+caajNX9N2bnW4T
   w1J8zBojQpIRyptpMJmIAFekyNVqI9PdKLH2aBw4PkvlUhczrRKo2Q03s
   m+tynmqepITRpLOBameKy3l/oLc9TwbaBLDu2JXh5vhIhrXQxAhkHExRD
   TeA/ogENGi8EfgTSziJbSt7RhTp1zsHDpnckfcO/p5LDGS3tUonPfQWYW
   YmcSpBnW9dL67GAFjO+UYAKhoulfctQHaUrwHVj379453T5iRBb5PGp6l
   k6KDjANxOMfcA0Px8SvPPFikjSgqsN+pf+6Z0YWfbRJ51x8PIG5PYVkCL
   A==;
X-CSE-ConnectionGUID: B2bB0bfMSWK9pYXcBKODFg==
X-CSE-MsgGUID: PDZUU+JYQu6xPNbub6gRBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36638843"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36638843"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 17:15:54 -0800
X-CSE-ConnectionGUID: l8NiRvaATuqoIj/AnKvgMg==
X-CSE-MsgGUID: mLsgwA0QQMKSJ5Uy4+q6ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="104123216"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 17:15:53 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 17:15:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 17:15:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 17:15:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlsMLFGGBGn/d1RvOJJ8vStogumsXia/WYhblGD7u8dvzehRMZquW5TSUtoVkDcPxj6k3R3gpun+PPgr4IMEbm+NZb9MZOjQ2/MNBzhWmpRrXQhcMBbH3eWU/C+CuFlWahWiw/s9B8y65V2LyBP0cNxsNPNDEOqck/vlBEQQrqHtZ2LubyH4gv3WlL4IvTLU6locSmvc2m1Jz3XytAvTp7EaAtSVw/G4ukrxeO3OQgItayRH/hOyDFijpZGd9T7cQBfWlb9BaBu01dMJ17rdutyEtPkt+IbAvrkG/SlcrUY8n/XsiXdK3IzaM/tOMj3bTwUE09unfLYM9B7zB+oiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyRYaSPQeMfUbhrNrK5by8xXkEIJXkgyyOrMqklqnlg=;
 b=f4Kf2Buguf1tIjMgP/L1I9+I1BT2AP5UDppUd/efZnF3rzzZ5iwAkPFDZOCLaWGruXQEdPZLvWdhLGGhdYy6XFz4o0YAWelQ3gzt4v3Su5Y7DQe3d7CeZm9vJ6l0RcFT1d++ZDyo0lYQQr3kAb7aLhwyDaAcUy7b9eq2NvlbO40a5OkGj0tB3gC0zlS+yWMD6tw3MEGemkHGza12gBZyrSJ8w5V8W6eYvxouA7SqC1If6jSQfjkCm6SAXu2feqFeaut5WOraRIjzWYe5sinQoBZ0jArSswKOyTR57mG92To30NGnRlVSvhj/uJZpcxy89FctRU/nblBUCKcZBZAtaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 01:15:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 01:15:44 +0000
Message-ID: <c663c8f9-597f-4d40-8b4f-0bb466eb1804@intel.com>
Date: Thu, 9 Jan 2025 17:15:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mlx5-next 1/4] net/mlx5: Update mlx5_ifc to support FEC
 for 200G per lane link modes
To: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"Leon Romanovsky" <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Gal Pressman <gal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>
References: <20250109204231.1809851-1-tariqt@nvidia.com>
 <20250109204231.1809851-2-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250109204231.1809851-2-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 6142ad75-0adc-4910-80e9-08dd31144e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1Y0N3g3UWFqRGx4K3lkQjNFaW5PMjM3NTZGb3l5K2RTa1NIY05SMFk5elJN?=
 =?utf-8?B?dlgvRWlvMWZlZm9zNjdnbUI0UkEvUzZ3WWcxTzQ5bk11aGdDSm9BK2UzcWo1?=
 =?utf-8?B?THpyWFpHQUtkUUEvVmNNVnk3clhIYjgxblRLYVFXK09NRlNNNUYwTEdVcEhL?=
 =?utf-8?B?VEhSSTh2VkZiY1FaLzBtRnFkR0xha2RGQlM4TWpybkpwMEJrTGRTTXhCQnB3?=
 =?utf-8?B?YmdGUjVLRUZiR1JJMjJDb3NQZXc2N1pPejNmblZHMWd0eXVESXBsN3NNOVUw?=
 =?utf-8?B?L3dINEEySURWWnIvbU1CanhKdnlwR3FjWXgyNHlodk9BM0JyOVBJcVZVc2lS?=
 =?utf-8?B?dHZyd0ZmeGxUeUJSSnR0VjRodU5FekxOMGpwUXduQXhMWE4wVzRJV1hZY21J?=
 =?utf-8?B?SUtNajFWOFZVcWo2MmVjcXdGZUdCamRpT3FTZFNZUzRXcjUwbmZ4SUd2RGZW?=
 =?utf-8?B?MkVQMzNSR0Rib3c3K090U2ZpTUVjeUliVkIvc3paODk4aGlIdWhmSkF2ZFlu?=
 =?utf-8?B?Wm02QmFiZGRuKzVIUkJpVytLUVllWS9MbGpuY1cySVhCSFJmQmR4NVFKMVBl?=
 =?utf-8?B?OGthcWFNV09RTnNRaUU2QjdaR0NYYUhiMm02VysxSENCY2UwVW03SHZqRG1Q?=
 =?utf-8?B?MkR5d1pHeDZIZmE3L2ZsMkdBdmZNb3hneTErdHdyYk0vZUFCbjRFL1JnWkNQ?=
 =?utf-8?B?WWZmRmVQQ3dmdDZleXF0eFFJcXFGSEg4eUYxWFl3SlAzM3BpWWRQR2UybUE0?=
 =?utf-8?B?VkFoTzQwdUd1SFN0Q3BhNFNsS1lSdGxnR3JXN3djR2U1N2NpUlAzZFl5NTdm?=
 =?utf-8?B?Nk9mclhoL09vb0IrWkRtSHRoVnpNaUhjQkxEYlZmNGtydUY1KzJhNFBNYlk2?=
 =?utf-8?B?anhLRXE5TlBIeDlmWS9zNFlUY05yWWtudjhwMG1qaEJWeVZEaGJ4dGdKZTU4?=
 =?utf-8?B?R0k5Y2dvZFlIck1hN3JmVUJSRFZiaXlsOXl1QmNGZEF3SmFnNGRhNVJDQUo4?=
 =?utf-8?B?Zm5tK2kwbzJYc1JaTTlEYlZ2eURJTEJTWnpIMENJT3huY2ZTVUh3c1dYV2ZH?=
 =?utf-8?B?allsNnpHcS9VYldFQnpKSWlKcDYzblJhc0N3cUdqcmQ5YVc5ZVc4S1dna2NB?=
 =?utf-8?B?NnlsQjZQdy81YTRpcFRxRlN6Z1VJaHh3WVdTVUJ5dXlUK3BBV1pic1UzRHdl?=
 =?utf-8?B?SUp3ZGlVaVdJYkhod3NBQ1lUNDhwQjJ2YzVVUlNoTldTRmIyMndvd3NaNk9F?=
 =?utf-8?B?MEt4c0J3UE13USszOGxFb2JWczRSRXVQMkxySUMzbkRaR1B1UHNhZzVZSU1w?=
 =?utf-8?B?R3RPdXJrM2s2M1J1ZlE3ZmFkRi8zK2djT3hpamhjS1U5d2RPVkV2Z3lWbGtI?=
 =?utf-8?B?R1ZOajh2SkJoaFREdHR2aXNXWkF4VmIrdm5Qcy9tNlNWcUxqNTlaa2RMU2lh?=
 =?utf-8?B?YVNBTk1RZ1VRR2NxTlV3eVdpUWFyVlZPTUZFQVpoRVhvdkxXbmdzNkZLeU5U?=
 =?utf-8?B?b0djWmlkRUdzZW82RDZjdGFxa3BveXFoUEk3NDdiL3BKUFpYVUhUdFVVMHVI?=
 =?utf-8?B?ZEd2Nk9mQnpTU2FGQlFtWTFUK3hxNHRFVHkvZ2RWSW52QmRDSUFwYkJoanh2?=
 =?utf-8?B?ZDFmQ0ZOZDkwSnFwZXA5S1JoZmgvWnRpZE92TDI2TXVMUTBCb202WTFiSWJS?=
 =?utf-8?B?TERRa2J6Z05mMS9iS0pXVU04UllyWjd1bzRnWVd3RU10RFBHeC9xbURhZHQr?=
 =?utf-8?B?QVJkQkVFOUxBTGgxempNWTNKay9lRUhVU29zL1JsUGxCRmtWU2hCTXBlSlNa?=
 =?utf-8?B?Tmk1TUs4NjBnb0p3SEhpOE9iZDgwQWVNZWZCTjVuTkJPUllRaldEdWFJeGtI?=
 =?utf-8?Q?o5fQcDKpZKIfJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXlkUklieEgxSHhKb3BMYkwveFJGeXhpaXdvSWhmZWxkeWlleVVEZ0cwaWZw?=
 =?utf-8?B?QWJwSjJzMWV3VHJwSnJaaXVxalBuUlhHQjRPQWlIdStNQ2pKS1hkL29md1Mx?=
 =?utf-8?B?UURmdWpIeG0xYUkwaWNSbVhqNjJWbmY5WnNtMG5QSzZhL0pYdjEvcC9JbjI5?=
 =?utf-8?B?L0VjVE1DVDl1YVNqTUhlVzRVZ0cyeVZJMk9yMEYyUnFCT0FDdEg5bWFsamtV?=
 =?utf-8?B?NnNESHpSUlc4ZERlT2xjOVFTRnNsRnNyTjE1MHpsbzlMQkRZRWRGOE12c2dX?=
 =?utf-8?B?emxrYXgxU3JzanIyclJzV3FVMFd4K0FSZnRoOEl5d1RKaFdwTUNIc3pGbjVt?=
 =?utf-8?B?eHo3LzJDUXdQekpSSzhlbjllTEUzcE9hUlF4bmFVWUN5SE9BWGs4VWdSc2Yy?=
 =?utf-8?B?bVJGTWh6bmNkRUl0UjliWEk5a3ZmeFBZTFlRUW1VUFhGa1dEVURURGtIaHBn?=
 =?utf-8?B?cUQwdmdDcENHRHNhNzhWZWRPaUFPR1BLWXhaSVFEcFdQVXJ6WTFlWXZPbGl2?=
 =?utf-8?B?QWRNY1MweUFjZFJjR29iMUFTWGJEMng5ZHVJL2QxSHUrRDEyY29xWTFnbTRG?=
 =?utf-8?B?ZHRsd0JSN041bE5jWDFCbVdSajc4LzNrRDJKdUp1L25MUDVPTkdnRUV0dUlH?=
 =?utf-8?B?dStML1U4Y2FpWHZwTmdJbm9RdzIzSlRhMndPM29FV3d1Vk5wV0hGRVFrQnky?=
 =?utf-8?B?eTQ3dytQc3FrbVdMK0p6V0lWYWdNL3M5STRyTFp1Unh3ZjY3Rnhoa3JZT1Yw?=
 =?utf-8?B?ZGpITm5tdGxRRmdYM3VHSmNnSFF1dUhKUmpuckRNcUIzYUE2YnVzOFhPVTJS?=
 =?utf-8?B?RGRndXZNRmNQMS9EZi9CSnhvVkFMYUJPMVBSMDEwRmgxMFlSRG83OXIvVzZL?=
 =?utf-8?B?SDByRDBhYlRvd1EwbThEOGhQaExwV3dja0hWcFA2Y25HQmZnZXAwNm92MVJh?=
 =?utf-8?B?a3NnN29wSWs2OEU0QXUyOVNld0ZMdk1oZjdTVGxEUmdNL3phbElKUnBvV0cx?=
 =?utf-8?B?UzNQOFB3WDdBeEN5K25peE9EWStldEd4blJCZ0h3ZzZkUDJjUnVjekFsanBJ?=
 =?utf-8?B?bDEvSEJIa2M4WjN2dkR6Ui9HaDg3UnlURlZpWGdzL211aWNnOVp3ZC9ma2Jh?=
 =?utf-8?B?T0FmZ0hSMWU0ancxbWJyMGk3Z2ltbFFRZUFOVWQvSlN6TitoKzdRZm9KL2lJ?=
 =?utf-8?B?ckJPWWxxUHhXMjF5VW15RW5iYjFaUU9lNkFXcXFjVm8rZWpqSzBmSmU3UWN2?=
 =?utf-8?B?aGNqaDVJS2pCcTcvdmtYcjUwWnNpclNjRXRVK1Y0R05tNTZaSnJiZWZpaDRU?=
 =?utf-8?B?MTVNNTgzbStZRzIyTm84dzRkeE9wdmVTbkNtVWQ4YTNmNnRyNG94bXZISC9N?=
 =?utf-8?B?NDJwTm90SFZiOUg5bVdlaDdwSDQ2dTAvNUtBcnliWlBzMEQrOTZlMHl1YlZJ?=
 =?utf-8?B?azZUWnZmRjc3K0RNSFVKUHVhei9pcVQ4UWZLdDFnamNFZmJwV0FzQzZMSkVa?=
 =?utf-8?B?UzhIVHVYQjl4TllnR0tHcTRJeDV4aWE3MndCVS9kTlVjZEpBQ0p0S2Zpc083?=
 =?utf-8?B?b3kzMEFKc1BjdDdsNWxVc0tvMUdaMm9mNHQxRisvR3BkemJhZVV1M2lLa0RN?=
 =?utf-8?B?dEM1WFRsc1dCYituSXlWVExmYjdoT0JBaW8wZ3gwcVh6OXZFU1VlNVN1dUMv?=
 =?utf-8?B?OGNUb3drSHMrYURwRHpsNVN4TTZJdFBQZy96S1NFOENobHJrdUViN2JlRXI3?=
 =?utf-8?B?N29CUWxKa0ZqQmNjVGQyTEZhRE9SQzFsRWZHcnM5S0c5a0Z2WVU0eFFpY3NS?=
 =?utf-8?B?ZHN5WUlBLzBKbVdUUCtLaUI2bWxwbzdWVi9oN2ZvZG1pVzdHQzZSeXpEQ3pv?=
 =?utf-8?B?ZGNLY0NLYWdnemlLd3RnbE9pRXc4OWxwWEtFR3RJak9QNEZtZW55SnQxZ1FM?=
 =?utf-8?B?Rld0ekRWVkE1anU3aVhEM0kvTXMxMWRwVXp5WkJlZGdpaUo2V0h0K09Ba0Z3?=
 =?utf-8?B?MTIzK0JDRGhTQytwZVFseWh1VzVseCtWTjFLWXFTL281ei82K09EQ3FRTnVq?=
 =?utf-8?B?U0FOcFZzM05lTTFCbzdiQk5pQ3JuaHQ3Mm1Pek5ZZVpRVHdBbjhmTTh5Uzhm?=
 =?utf-8?B?K1NpSGZPeC9YWUsrRi9nbk9CK3FFMzVIcXhaR0RRZXZzalYyUVpGZmJHME8y?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6142ad75-0adc-4910-80e9-08dd31144e60
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 01:15:44.2233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkGhrzS5JOGjxR3ZpHjP+BXgR/hX4+MAqDO85argkkBdm6xQdSdF8DMjgiz99bD0+cK6ByCOvGyLialQMEjh873BB3yxuLfCL+0NTpXeImk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com



On 1/9/2025 12:42 PM, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> Add FEC admin and override related fields in PPLM, and the bit in PCAM
> to indicate those fields are supported.
> 
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

