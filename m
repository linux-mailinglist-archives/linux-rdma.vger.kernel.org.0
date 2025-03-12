Return-Path: <linux-rdma+bounces-8629-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E79CA5E7AA
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 23:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A5A16B2C2
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 22:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0051F0E31;
	Wed, 12 Mar 2025 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4kez2mp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3C1EB192;
	Wed, 12 Mar 2025 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741819822; cv=fail; b=j2aTqWMQWMV6OyTMao2ebJkZt5sa+Gv7qIkaYnNW4OWPcBJOraL3Kwbl7M7CyCwpSCUA+YeQB4JZU5lTAjFtY7MRYsnG1ywKt4lhVd54T6ixKVUyw0QhFcsGM0y8zTXvKWNEXAmCpLboWEXl/Of7bI6EqxMU8WRI0Tn0j9GENyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741819822; c=relaxed/simple;
	bh=D3cjddMQI02UpJTo5bnSzQQvVDZziQAtFby8uDvvCbY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UldNoR1ozBqrKElzl8uJws1Zs67NzqyfW6rAKTqHeh8A0MmSGdNQv6y2Wt1DsfYZ84F7k1I7FKmeCE+cZ7Fp4Q5caHQxANCZLwP/t3Q5e1wT7EvR7JTNZiYAm77pPGLSNPJSWS4CqW2egFcyJhFSVwkGiwXp0Bg4KFVZffU3qRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4kez2mp; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741819820; x=1773355820;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D3cjddMQI02UpJTo5bnSzQQvVDZziQAtFby8uDvvCbY=;
  b=D4kez2mpUCUP5GLfONq34qTpPtq7U8i9fjsH+7Rsbe8LFMrG1mn3I0ZV
   QnfXIZUdnMR1f3SLnVfze13Xc2rZwKJgFSWeDQnCzoycFjiioankyUjL4
   h0FXmh3myPT1qX4qWbvBomhPoHpG4OGuEU7+8iVCQ9+XHs51gC28nzvfj
   y1io6MINhXrX6x3E+k5ftkugDe1DCeMjFhvV7P+5Reev1RwDPr27DMdUC
   bXM9E9QA2ooD+u5M1B8lbI8dR1lgzcDnv2IOiCxVH+NLUdLYCyD20Pntj
   fL6RL5eTmEcTCiggX5JnGF38gjXcxz8KPY9arbjlAnsWW+hKkLrT4+uGr
   w==;
X-CSE-ConnectionGUID: cB9hWk3KQa6cJI5ij5JeHg==
X-CSE-MsgGUID: s6JWGjWFQWuKDgE+hRB7zA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43102342"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="43102342"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:50:14 -0700
X-CSE-ConnectionGUID: GoQR2FmYTOWWTqXccxPdgA==
X-CSE-MsgGUID: r4Om1TOsTGKJDs2Dmwqt8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="151600284"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2025 15:50:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Mar 2025 15:50:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 15:50:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 15:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBmfXLsalE2xdP6uk7Xtui6qDwhUDqmHs7/6hqbf8sIJWG3rx7YwPFCtOASVu4MjLqqp7Ph8Fy0kvz2ro1ikpNFp8sxPPt+KQDDOkiW3WnKtVKMSrdxeF5X6mJpZ+3GL4LfyknGxvlafe/YAYBkfiNMO+6tUy6cfJ6f1PpvE/XZGumnJnuYS8rABmpMVcHqYnMJWdW+qN/t5y1ljf37OIujjqy6kwIgaCvhCrCm//3SOYEb2pxqoQyqtQVQipl3SYCs+sas9HybI/QcL6jFWZ7X28j/Rp6crksUxpLZRxiq7O1IqVdxlW5BYFNXs0cNVY0d4DXOrkbR61rFrwHAeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B9OgEYgFMF7udVgmktgbTv4nG9RTXXwRBJ1dkXsvWw=;
 b=u6y6rofh508XZRyNxF0KGkqPLRjleIfWyWwvj59KEGee71wNh0UGo6tqkawZ8NYYzKMVXnXYc/eA3hNbVEOLi5L629QCGanSjS8cwQqLE6/TtlXRzucVjKWwbpBzPa+5H2uijAr8QICX1dNoFXtsVGVaaobgpd1SB+QWB4sMq7H2eBASCVRaXRCMxPPLKU20C2+vcGGdE4fwhSjaj/Am2tUfc9GDoR/Ai6eSf7ThOyqMiGHyKV3KeIaoy4eDnC9qH36K2C3Fm0c462YBoRdRnq6uFz8O3rEQmG8csOMsaurSE6Mxhwk22Z4edEG3tH2pfZIs3OErB/ofAMDPn/qD3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5283.namprd11.prod.outlook.com (2603:10b6:610:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 22:50:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 22:50:10 +0000
Message-ID: <73362b53-52b5-4d60-8845-524df01b2905@intel.com>
Date: Wed, 12 Mar 2025 15:50:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net/mlx5: fs, add support for flow meters
 HWS action
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1741543663-22123-1-git-send-email-tariqt@nvidia.com>
 <1741543663-22123-3-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <1741543663-22123-3-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:303:b8::32) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: 8089cedb-44a0-471b-b94f-08dd61b83e51
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVpqTFhoVWFIYkFmUHZvL3ZWZkxDTTUxdytrRmJneGNNZGMzSldPMGxOd1Vk?=
 =?utf-8?B?ZFBIb01rVHVESWxMcGcwWFl4U0xUWk5HbzhCSEFWU096SStnMXV6bVB1TXpK?=
 =?utf-8?B?MGpERjZsRWQ5UWNIYkJaZTB4ZkxXRVAxUVRIeEJjMUYreFpEQTJONFlNV0NM?=
 =?utf-8?B?WkRVdEJZNHFFUTl0c1Z0anhqRUVZOUVndTNobDhLNmt6anhFT3doY1IxT3I4?=
 =?utf-8?B?VlJKQzJmSHplYnJlNWJVeURJSnBHWHpKZitoSTI2di9HOUY3TElDaS85VDJh?=
 =?utf-8?B?bTNUM1ljdkZLVmo4aXhENUtnTnEzRlVOZElMSWVHNHdXcTcwejg2Z21qTGhw?=
 =?utf-8?B?QzlTYjkrNlY1UE1IMEc2OVpWNjhac1BVdHVIVE9DaGdmMEt4b3FlSk1lSjYz?=
 =?utf-8?B?Z1AxUHE5WlZLVjhaWmd6NGVxYTRhMXkwdXNoRldEZmQrcmVyRU9aYXRuWHRo?=
 =?utf-8?B?S3dOM0hBeEF1dFFnbW9yekpHUzBMdGJEUWo3dVFZQklkZllMRFZaZE5BdjUv?=
 =?utf-8?B?YzdZc0FLTStVU2IwTkNZM1V1N1UwM2ZURmhYU0dmaVk5RU1xR0JXbFlLSUZu?=
 =?utf-8?B?TE1IT0ZyRytYZ2oydWUyV29RdlBSRHh5cUhlc3hLUEtNQWhqbXVKU2tXaXA5?=
 =?utf-8?B?Q09WTkQ3SVNCL3FZVkgzbzdBWGRiL2RWQ2xDUEVhczlrRzM1Z21kMHJkRmtX?=
 =?utf-8?B?VkJGQ3VnUzR0Z01jKzljV0pXQkVSbTgzZjY2VnFxYm1wV1dpOUQweW1qOE5l?=
 =?utf-8?B?YUJYZTFQVjh0WG5GOHB0OEJaQTlXZEVBSVRidVBzanNPV282eVQ1eU01QXlZ?=
 =?utf-8?B?OEw1SWg2cVpOTUdZQk5Za2xiQkRPSkhYUVlJbEgrZmF4dHBjSzEyTWdKYTZP?=
 =?utf-8?B?SEl5WS9GWDc5NzVRUU5UNWllWlBSa0NCZzQ2NXpTakUxR1o5MHpwejZXN0g1?=
 =?utf-8?B?aVFHU2s3bDR1bE8xU2VmMlVZSkcxSzN2dlJVTHlxTmU4SXVqYjdKMUNubUN0?=
 =?utf-8?B?SE1CNkxzVDFtTzhWNlc5a2dPMnBHbXF4NWFPZTg5UVNDV1NFSmh1Q2RzSGZP?=
 =?utf-8?B?Z2RLWjFHeFRJK3c2WFkwOGp5dzFkREh6TlNkcGZFOEd3Y2o1MTNrN2R1bWpo?=
 =?utf-8?B?Q0wvbmFKd0RzSjFzWDR5UHVUVGNGbm5RV1JYT0dYUzIxYmduVTRQeUJabU8x?=
 =?utf-8?B?VmNJSlVFNC9vaEprbHl4UmpKeWZvUDlXRU04RjhxOXpTaTloWG94MGhCOS92?=
 =?utf-8?B?TVZHclVZVDQvbFNXM0VVNmg2SmhSWnJWK1JNaHd1NXVPQVBvQ0NueXNjVmhJ?=
 =?utf-8?B?T3dmQXZYUmdEdW82VUhJQTBRZlh1T0FCM0FDbUlra2RmTTN3RlRZSVhsZ2FW?=
 =?utf-8?B?QVlCcUJ5TERsU0xhSU00a2pkUnQwUStuNkhhazIwMXNUTFVFWTFuRFBjSDlo?=
 =?utf-8?B?a0tnUmZIbDNTZjUwSENNZUozSjYzajRUcUYrbmZDMWJwQ2hRYmw0Nmg3WjR2?=
 =?utf-8?B?d3FjWEluN0dhS2FLT2ExaVpQRHhPRlYrQmNFOXJaeHNZU0dHMGt2U0lJK2lN?=
 =?utf-8?B?UzRleVp5VE4zTGpPcHhPdWVtWi9MaWlZSEFPaDFVaDcvMlRtSVVjT3ZwSmNj?=
 =?utf-8?B?SG5FbmszaVFjU0tDMUdqRHdOUmNveUtaTG94QnFuM0RsMGVvVVJBRDRiUU0x?=
 =?utf-8?B?MW9tRTQ5MUtmWTJMdVVNK1p5dnk5WmJBN3RNNHpnUjAzZitiejhGMnRySldi?=
 =?utf-8?B?amVQR2VqRHhIK1FyTklsTVJHUGxjcFl0TElaR20rREF1L2o0dFkvL3dyVXVo?=
 =?utf-8?B?RTA0bm5Fcm5DZ1RsdDdhNUU1N0E0Rm9QNjk1Q0FzYmNUSjgzMTlvdk5LdFVM?=
 =?utf-8?Q?Uln6UJwaFhuNG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUhvMTB4clArdjAxeGRwbk00ZUVHZGlBTHBDd3RxQlZQaVVXQU5SNzVoc1Uz?=
 =?utf-8?B?ZGttTTc3OW84VVdtQUFvMDg0SWlRL29aRUdzdU1oYWZmb1dRMmNJbWlrUTRn?=
 =?utf-8?B?ejZ4Y1BMbGtZSXc0OFhWVUhpQkdPaEtzYThrOFVUUGhLNnRBRGN0cXJMcVZF?=
 =?utf-8?B?bWQrbDNCUjR3QjBndWJtaUFQTmNTaWZZRUowdkpLeGFDNkprV2N3MENiZlAr?=
 =?utf-8?B?M3A4NStSSnZLNEFuYnpCT1VtOUsyeCtaMnhpcGdSMUR1S1NpQzFpVkNGcUZM?=
 =?utf-8?B?QTMxdW45SEp6cDR0MVN4a0JLeVNHVW5oaDN3TjRzdlh0a3JnbzY3czhqNG5U?=
 =?utf-8?B?YUNmWC9iMzJrRHQzdzUvdVE0Nkh4OVJKUngvOE1BcWFoUGJERFllTmU2MVFu?=
 =?utf-8?B?cXo3MXJOQUdyeFhzR09CZ2ZURE1FQVRIWWJSMEJYM2N5OHUyVnRYUHpPbVBZ?=
 =?utf-8?B?bTV1UXgwV0xJVThJa2RhVWRXQ09STkNFZG1id2NNTUNGVHBSb0EvUG95aVVx?=
 =?utf-8?B?dE00ZGoyK05ja0t4U3lSdHVFWGU0YnVZOEdzNzlvQlZ5a2FpWkhoWXpYUjJ3?=
 =?utf-8?B?ZDNXbnM5YVVHOG1scEVmVTFSZlh3NGN4UmcvbEdyczd6RnkzVHVjdXdWUEZr?=
 =?utf-8?B?UjB2aVdzb2ZVcm9WWGJ4dXMrNDlDUDN3MHM1bnhlYW5OTFpsMjcrUk9DTUZm?=
 =?utf-8?B?ZGcyanZmU25TcWk4YzV6RFhEUlJJeHByWUVEbkkreXNPLzNHSlRoaEVDMjBT?=
 =?utf-8?B?dUR3UVdaNFovUHFwU1hMVFBmS1RHYlVDaXR0a0VNVjNmSFNMZzEwK1ZEb2tk?=
 =?utf-8?B?MFBudWZvTG1xUWU3T3RCNm5uWmM3TzBocHlrcXlUZ1pRNHFmZUdjaUlJMDF2?=
 =?utf-8?B?aTQyY2x3K29pdlBmRk02NEJqWlJwTDBhZTJwamdaQk1BSk9TUkN2d25jUUdQ?=
 =?utf-8?B?aGwvNTJRN0N5WjBJdjYzMmdKZ29rU1kxQXZoNnZFZXgzMlZRREEyRmZNV0xs?=
 =?utf-8?B?TmRzcnA2alErcGEvdUpDdUEzT1F2SVdnQkptaFBXNUJSWFFNNU45aEEvTjFs?=
 =?utf-8?B?Z2F3OWd1dFpFaVppTHg0VmRoWWgxVVNyRWZMK3VaWFVwazFFUzF0cStEYnla?=
 =?utf-8?B?ZjBTd04wbThsSGR3SkVualcyTnNjY0pMeWJ1aSt6RkhzZjhnZFRyUk85WStF?=
 =?utf-8?B?b3d1UHBLbUkyZy9ZbjgwZTYrVkcxVGl1NlVWMXpWa1B3V0ZMSnJnQ013cTBs?=
 =?utf-8?B?MFZ2TWx3b2JSOFJXb0RlanZpTG0zd2o2VURwc1JGYnRDdDcweUtmVklRMVBQ?=
 =?utf-8?B?TjNKZStmVWxzaDJ4Sjg2b2RIbGc3MEJDcTVyS01DVWlOYnNBNVdtSVg4Z0RT?=
 =?utf-8?B?U0ZTR1pCVHN3QlF6VjlDbkhXdFhvRDZvdlUzTDlKMTh5ZFRWVjE1TEhoYWpR?=
 =?utf-8?B?MlZDUmFDTWR4L2JxeEFseGorcHhxQytCZUVZRE03czBmeXAvdjFud2VJNmp4?=
 =?utf-8?B?WkZWR2R4QjFVSHp0MzRrOVBGZGNwTEhEa1k0clF1ZkI5dVVhRjVPUjJySTRL?=
 =?utf-8?B?bUZCOUN1WXNOZTQxT0MwemlzRVdBL2JObHdXR0V0dG5sNUc0RU9qUHJSWlpj?=
 =?utf-8?B?bk5yM3FUL1QwZFNZdXFveU9lemwyZlB6RndRU2FRR0pScXc4S0FSUjdHTjhY?=
 =?utf-8?B?cVpmWmN6L3BLbC9ZZkV3TDRnRDJ1bUR1dFByVnE4L0JZTGEwU2pHS1pRb0x5?=
 =?utf-8?B?c25hTk1VYzVIWDMzZXRjWEdpMHoxWHlqYllESDNnQVhWQllUV090ckpyQndC?=
 =?utf-8?B?cW42cmpOaW9VcFhVVUZwNDUwNGQxVGZtM2tTS1ZxVExsaVpVTmxadFZFSlAx?=
 =?utf-8?B?Wjl1TkZuaDVKRkdIK2dUbW42UGJRbVF3UmlUeUFzWXZ3dU9FL3Vsbk4zZGRs?=
 =?utf-8?B?Q3U5WFNPZVJLV1llMlNnN2pxMXgxUkRkaXJ4OCtObTgxaWF0Y0MybnRTazVK?=
 =?utf-8?B?ZlJHZ1phaEI2eE4veng1aEQ3bzI5eDlEYUJrVVU2aEd2dHNDcXVtSUdISm9K?=
 =?utf-8?B?b2toU0l6TzFwZnFiUWRnUHV4V0dMaTFoczN3UkVnSmJXTGRXYVlRK0lPSnkr?=
 =?utf-8?B?ZEF5NkUydUF4Q1E3eGNrZXRWTWxsWU82ZjdxdjZ1U3NoK1RhaFlldXByajB2?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8089cedb-44a0-471b-b94f-08dd61b83e51
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 22:50:10.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fVYQ9S8DXSP+dKQa+9OilKz7+7/OI0TiYhYpjlJu/VJM3PiGAlZuGOhfm5AAuB3pZq6TRyo/KvBEufjmEvr869xFhu70ISJ9l5tNUzmMBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5283
X-OriginatorOrg: intel.com



On 3/9/2025 11:07 AM, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Add support for HW Steering action of flow meter range. Flow meters
> range can use one HWS action for the whole range. Thus, share a cached
> HWS action among rules that use same flow meter object range. Hold
> refcount for each rule using the cached action.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

