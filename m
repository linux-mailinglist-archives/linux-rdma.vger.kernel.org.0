Return-Path: <linux-rdma+bounces-8686-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CD7A6044A
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 23:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E497E17FCA4
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 22:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50D01F75AC;
	Thu, 13 Mar 2025 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYdYPJtT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45A01F5821;
	Thu, 13 Mar 2025 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904883; cv=fail; b=BVZCiSs1Ep2x2lMpHyjFu6HWcIkhhul5Q9ruEdUsxKkPjh8xBfaI+0TmG4LCrgBtZu6BfXoDwZ1fhZ5W/3tjSctvmcok2mK0Okmt6sOvzCf9bUmldMEYGaFYhr3uzxmcmthnQAbHl7bbsnX979/KAOvtiTa9DKRRj9qDrY/R1BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904883; c=relaxed/simple;
	bh=n8rywSAUHHrzoj8EpHZ9ri1bQHgujpg+8z4DLoV3mgc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=avaYDD4eMSrGKvg+Wgs6CqpLl776+fY3ExlrAHV94raTtjLads/kisKbVOo5yNa2p4VtS7aXyHkrU8K++1a3nxZ2uymErkmDEit2z9owZU0KL0Fv//nFtgRLNmLLfU870/i0EVUkNkkXG5MI010aIw9ngazJtX+bjnlwWSDRnio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYdYPJtT; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741904882; x=1773440882;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n8rywSAUHHrzoj8EpHZ9ri1bQHgujpg+8z4DLoV3mgc=;
  b=QYdYPJtTebL0Bf3hDp2BNdKHiFDzg9R93eOIqK6bKIK2he5VEmKI+tXN
   2mx7sd2GLyzFtmQxE8JEd2ddW6gZSDSRJL261EiIlGOv4cvQUWrA1RKxF
   1EuB79tYWbPipuCz7vD+uHxSL0A/QqtKQYt8aV83aUYJohJqkD6HXhnCN
   wWS8Z8GlPmVLP824zMppOlj8TlpiRTOl3PtcmwzV7T+rf3S9GMSsnSRzv
   tt81ELtjkc6rUmT5y+7Iv8GX0b1IP2OtpOk/nSpE7tR3AnB+dSeDQS79M
   E75C8dik02m+T8Pgek9iKQ9kbISdwlJE0X8iBkjvdjthtjFxXdwgxdo6Y
   g==;
X-CSE-ConnectionGUID: 6phvZfBJRCCBFrKCcQGNjw==
X-CSE-MsgGUID: fccN18KXTVSb6VX0iQpldQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="65503787"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="65503787"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:28:01 -0700
X-CSE-ConnectionGUID: eHfg+HGtQvK2udmgx9+oaw==
X-CSE-MsgGUID: DEyVQF7pQ++A8aCYwXUUXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="152026299"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2025 15:28:00 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Mar 2025 15:28:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Mar 2025 15:28:00 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 15:27:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSzlqC6k6wcnm0A921Td2qsPNEQ/uDVrIu2Sy77YKA73Xep3swQ4MEzsNqn1yY49h27e1p3m8sMjNqT6H5KUQC/Ce1XD/OyfXRv8Rn6qYnHSzGvHwEYVefrsZSaJ+uwdeuxsKvZfO8kEahQw8LvKbDK/bgAkOI3GNpP1cVMn/N9MugwhWyBBoDDpXqOCPr+aQQ3ygqD5Q9/GcvbnlC90AePcA2ayOW6znVa/GdR6LHmZxaqQLeIlxZiTKJkGznSQlqOLRe78mGBUQCaTeXLg3OBQOwBa435gjJgY3xAn1fUvp8/CMV0xXVyNJc/hKa+0JfNxI9vVAdR9McsUKzCMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhgE2ZqpNP6bbXc6rL3xg9aGyBF94rCkzLqE22ACNGA=;
 b=UEAjaQwTuPyRF7+igg16RzYszGyXKHBgKAUtWEJNyThDT2rWDqRBjfrxP3tXOUAoKlFSqewOIa+3b/DtoWuiN2UnLGQ7Tcb+WWavq3vr/A9r+wlPuJ5zXLqWYpmE8Caoa8Y0mxCzLxWJi7PZkDY1xW+DI9iWt52eRbBX93/vrLzPVMxZFlznJpdbBy5ESMHxGbt6lXTTWYLuwqreq0Rqr15kx6VwHfdgboBrz6WP9pGacDBS+qcg1wwhRRW0g9wyHkrK1mxjgIBin18jbFSsbv9DywZZJD+HACnZ/7C8+vjTUsgLAk4TixXP3aKg2PqwpQy0aUJHpfIZUTNAX4wR/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 22:27:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 22:27:19 +0000
Message-ID: <358039ad-930d-464a-9a77-9bc1554ed6c5@intel.com>
Date: Thu, 13 Mar 2025 15:27:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] mlx5: Support setting a parent for a devlink
 rate node
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
References: <1741642016-44918-1-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <1741642016-44918-1-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30)
 To CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA3PR11MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 63dac4e0-de06-4c33-8c9d-08dd627e377d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWJJK20wVytoVTBVYStZc0JrcjhqVnpGLy83dUluN3JFbm1vWHFjWGVYT0pl?=
 =?utf-8?B?STZPTTlKbkZHWEJDK0FjUmVFNHhDZE1qbUpuVSt3MWo5bWJBUkMvQ04vWHB0?=
 =?utf-8?B?K1FMZlRWNzRMcCtVSG5DOXg2NmlsWUl0clhKQWZLZUh1cnRDdFJ2Tk4wVnV4?=
 =?utf-8?B?LzZoOFcxSnRHQ2dVS1RSZFJYd3FmQkxTSk1nSy93NjlWY1NSV2hERWdkVXNP?=
 =?utf-8?B?eFgrb1B4R0dEUVNjQnQxNGdkb1BMaFU3SzZ6a29meCtQc2M2R2pEZjE2ejNG?=
 =?utf-8?B?WDZhb0NNYlEvMTJEUG1XTUpyZ0U2T0dpR01HL3czQVFoaVpibEsyTnZUQlhZ?=
 =?utf-8?B?UW12WW1GYlFQdW9GZWczQmhiRkRybjFuTXZudXo4b0ZHZzJyZWdlSGZTWHdF?=
 =?utf-8?B?ZTFpcFlWU2RYTG5XbjRtdHYyby8xV0pSRyt0RXo4THV6aDNrWEg3MmxoZzJO?=
 =?utf-8?B?bFAxOWxjMi9OT3ZUckRUYy82RjAyYjNIaW5BUFBpT0FTTVFRQ1phc2FaY25C?=
 =?utf-8?B?V252UFQzMjE5T0dIYjZWbkpEcERVMWt4N2FoVFc3T0dhNDgvY1l0TWN4ekJG?=
 =?utf-8?B?b0ExeHhyL0R3SWo0eko0NEhnNmZpRTRXVW54VXJUV1lDVjJTOEhDVWF6djJa?=
 =?utf-8?B?WE5qMWJ6d1RMNjl5dE1uRkJPajM1UG5YUGgrWG1TbXlqSjhCZEJyK1ZmbERQ?=
 =?utf-8?B?OWZpV0M2Z3dpY2JPbE1kNzBQOWo5WkJ2R3JBY2pjYUVTK1BaRXpUVGt3cVdI?=
 =?utf-8?B?VnFtNzFTUDk4K3Uya2lYTThrMUZEYW9pN2YxTWUxV3dGQlhWWlp0aDNQdk8x?=
 =?utf-8?B?YzE1QU1reFhGTXZmSG9adEZ1VjYzM08vZ05VRnI2SnFTdGQ4enl2Z3BEVTR2?=
 =?utf-8?B?Y3psRytOU29NZWYzZ0x5QnoweDQvUmhTUTd2VmFTdTJjdXM5bzF1Y1NSUFVr?=
 =?utf-8?B?UWxmeVhPZ1V4a2l2T0lnMktoZWpwdDEvcG1kN0l3NjlsK0dOTkp2ZEorQ0R3?=
 =?utf-8?B?a0FoVmNSOThuL2xiaXl1ZXlJek9vVFVtYjFVVlR0M2FTR1pkZjI1UGplZUgx?=
 =?utf-8?B?V3grc2VZQ0RzYW81RnVPSFVMVWxTdnJGTUVWNnk3VDl3dCtyZ21vZFhmd3FG?=
 =?utf-8?B?d0ZJc0hua0tKWFZBdXgzbUJHa0ZkbFBnL3dLdFRkcFBML095WFJZUCtNV3dV?=
 =?utf-8?B?b0RGdzFkRGpFWEJwK25KSlhqRE1IQk5KUHNLR3RXZExLRU5lR014Wi91c1BM?=
 =?utf-8?B?QWcrdm5ORXh0cjdNTWo3K2NjaUpLTExpeWEycmp1QTFOeFBEWktSWFJGWU1w?=
 =?utf-8?B?KzVXWTczVGNxTEhZQU9sUWtDNGMzT2VaRE12aWs1K2FKTzNCOFVZZmNOUG03?=
 =?utf-8?B?MGVJM3dsbEZpYlBxa3Q4K0VGdE9lU0NRb2hVQkVUVFNJUUtIR09WbTdMUkFq?=
 =?utf-8?B?NjUzN00xbnBCMm1oMU9tZFhrRDBpVVREdWhERkhwanIveUs5OTVFNUc0aUdG?=
 =?utf-8?B?OW9lS3ovNEc1aWVyM005ZHRkZEFWcFdGRWVuNHdvczhJUFdQSGlUSTBYY0l3?=
 =?utf-8?B?MEN1ZVNITi9hOHR6SDZ0a2FweVcxenlIMk84QTlIWlBUVnFpYmt2L3dtZDZB?=
 =?utf-8?B?VS83V0RlTFlJSkVMRDFwTjVpTlZubnRMMWxTeEFGRkpKd1A5OXRyMnR6VkNH?=
 =?utf-8?B?TjZId3UwTXFNT25kNEZvNmlPb0k1RU1CazJ2SEFqZnF5TTdBT3A5TE5iT2hq?=
 =?utf-8?B?MUEwbXdyK0tpcVlINjExMHJzMy9PY2tpMkYyT0FuTDl5eWZQMm1aNjRhSkhO?=
 =?utf-8?B?ejcyMHFDQWpXZVN6czMwUEpQTG1Yb2dqQ3F1a3d3ZldTL09TQ0ZscmpzVENt?=
 =?utf-8?Q?xI2Qc/1Dg/LRy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDkxVmxWUHpTUnJEckFPVGhvZkNUZHYzeTFwNWdCam5DTFRucys4QXN1ejRk?=
 =?utf-8?B?bmU3RjhkOXJvakxQZVBUSCtZN0VycEtxVFo3MUNlc3gzMjdoNWhFQnpKeTlt?=
 =?utf-8?B?QzREQzhDRFRLSGVKajNUc1lVZGJQTUxNMUwrNnBLbWJUcUlOZTBybGxkTXNV?=
 =?utf-8?B?Rlg0YXpBWFd0Wnh5MVBXWVM1dGxPb3lERkJWMXpSS0Rud3dCaGpLTmxtdEpK?=
 =?utf-8?B?T0hqeXpQcHBxVXlaZW5pVmEwL0V3SStTa09sNUh2ckl3bXk5ZWF1bm1YcjF3?=
 =?utf-8?B?SlhQY2JidzdwTE52THVpSUttZlB1TFg3RTV4cllvUzVpQTZqSmxrRzRaWi9Z?=
 =?utf-8?B?K0tJSURzMW5SbHVXOGh1RTdqbDFmRG8zSjJ2YTAyUmNiWUdBZzBXbmh3aHAv?=
 =?utf-8?B?bklPRFlKLzZvcHRTeHpYcjRLWmVmNkl1bHJpMHlwaTg5amlwRXkrVTBuWEhy?=
 =?utf-8?B?V1EzaE03TDNHdXYrNjY0b1pmZTlwWTBUODlMMlpnSkE0MklxSVJVcnBFZ0Fw?=
 =?utf-8?B?K0lNT1o4NERhYjNjVCsvbS9NdC9CcC80ZkhyMFI1QmZ0Uy9VUmw1eXQ4c0tJ?=
 =?utf-8?B?b2ZOTUlKdU1LR2hzUXRDSFBsVFByQlNMNm1RZ3lHZGZuWnN1RUswT3Vqajly?=
 =?utf-8?B?ZkZoYU9JejY1RU9ITGp5RllvQzlNbnpPQ3BVTm9GOGI1d1FGZldNQWxvYnFB?=
 =?utf-8?B?cDhwbDZqcGp1UGsvaGJnTUZrYTc2VXh3ZXpmSnlCK3VmNUFPeFJJWUU0aGdZ?=
 =?utf-8?B?eDFxQ2YzU0x0SVJ5aWJJZlhtWnIxQjZDbHZrci9JdGpwSVRYZUdaMDZJcWE5?=
 =?utf-8?B?aHhWL2ExRnljRCtMQkZIem9LOEwycmlnMi8wblVnczhhVjNGenI5eUxReXJC?=
 =?utf-8?B?RGg5akZrZDhDVTZUc25zMlRpWFhkeVFTMm5hVlJDQ0RaR3ZJL3lUV3gvWjgr?=
 =?utf-8?B?bmdZdkYxVDl0YmpHZzExdnRnL0s5ZVNPL21kbjFVTVhoRlZMT01Zb2NUdUJw?=
 =?utf-8?B?L3I4TVBUUVJSdDJyekNrVWxxTU01ODEwNjVqa2daRXNOQjhtTXJZOVR4ckk4?=
 =?utf-8?B?T0VXdVZJRzhzbW5rT3lTNXFJYkJwc0RhWTkxUUdRUVUrY0FXcC9hODkzSmEw?=
 =?utf-8?B?RnlhNkxIRVU0RXhRUzkyK0lyL1RuLzNwc0V1WENWWHhqdGU1OU13R0NuZHZB?=
 =?utf-8?B?TWt3UDZlSldBdm5UaXk2clA2TFViUnJHcHlhclR4RitNUzNOR083aFdrQmd2?=
 =?utf-8?B?akw0UTAyaVI0bXUzU3hqaXkzRnF4ZmtvdGl3VDkyTFpIazgwSjJtUnEvR2RJ?=
 =?utf-8?B?eXZ3ejN6SWpvQkFMbDVSeUlRWlpVQm95cEJzSmlKK2RHYVllWFhBZlFkNlBP?=
 =?utf-8?B?eGVRZTFWVVdSWGxXRzQwaWdteWRTeDFacllzSTZyQzlHRm9adS9HM0RZZUhq?=
 =?utf-8?B?ZXVqcDNsZ2NnK1llMUZSWFIycjF1LzM1Z2FVUVIxSVVSOTJYaW93UGtqQ21C?=
 =?utf-8?B?MU0xS1pkcFhvekx4Q2IweVNzZGJrWkthcVVOa1lWV2oyWmp6OVg3L0FTMnJo?=
 =?utf-8?B?RXhockpidGdvVjlqYXduSFdZeVBHTStIZzV0SmlTSmF0Y0RCaHRmc1FwY1lK?=
 =?utf-8?B?WDRwT2xSaHBGSEhGWXNtSWRVaE9XWER2Rjk0T2xJYlI4d0tqbFVkdXg0WmNV?=
 =?utf-8?B?SXk0UjlKaEgxRWhJSkwwZUp0Vyt1NHdQZ2s1TnVMN252YkoxbFZSRFhpL3NB?=
 =?utf-8?B?c0U1alRmSVo5TDNMZThzWFRVQThOKy9CdnNxdWZtdUdVNzBxVEU1bDZzU3JQ?=
 =?utf-8?B?S0pkeFhTZ0c1Z0VSQ0lkVXFHd0Jrc0Ywdi9wemVGTU44RnNEZkpQMmwxL0h5?=
 =?utf-8?B?WkNSWER5SG11TUF6VWxtbWdYN1lBNjFoU0JRMW1ubklidW5jRmRFd2ZCcnQy?=
 =?utf-8?B?amlhclZoVVBoZmdubU42WWhXTUI1QzFLNWJhck5lbVZ3Y21Ld3hOMThLVC9x?=
 =?utf-8?B?Q3FpWkV1YlQ5dHlDTXVXdkR4SmRxaStRcUJZSUdOUWZ3RW1FdWlQQmpCbjdG?=
 =?utf-8?B?NVZidSt2UmNWZzdhTnN2aWM2cTJEdUNlcTU4Si90aDQvcC9wR2s0RHlta2hu?=
 =?utf-8?B?NGs1bzdiQzJxTFV5TmU1WEoxR09RUzdJU2ozUzlLeVRWRFkxdUpUVWZxaXZV?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63dac4e0-de06-4c33-8c9d-08dd627e377d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 22:27:19.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFClLOV/01MBCxPahcJUZFfriYArCyw+tOhHsYoh/QSfCqlflQaU8dyFR/sGirx/WKXhsnbbf1tWOxZFwrxDlJPBwIRr87Tx1ecjHBcE2hE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com



On 3/10/2025 2:26 PM, Tariq Toukan wrote:
> Hi,
> 
> This series by Carolina adds mlx5 support for the setting of a parent to
> devlink rate nodes.
> 
> By introducing a hierarchical level to scheduling nodes, these changes
> allow for more granular control over bandwidth allocation and isolation
> of Virtual Functions.
> 
> Function renaming for parent setting on leafs:
> - net/mlx5: Rename devlink rate parent set function for leaf nodes
> 
> Add support for hierarchy level tracking:
> - net/mlx5: Introduce hierarchy level tracking on scheduling nodes
> - net/mlx5: Preserve rate settings when creating a rate node
> 
> Support setting parent for rate nodes:
> - net/mlx5: Add support for setting parent of nodes
> 
> Regards,
> Tariq
> 
> Carolina Jubran (4):
>   net/mlx5: Rename devlink rate parent set function for leaf nodes
>   net/mlx5: Introduce hierarchy level tracking on scheduling nodes
>   net/mlx5: Preserve rate settings when creating a rate node
>   net/mlx5: Add support for setting parent of nodes
> 

Nice work. The whole series was a pleasant read.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  .../net/ethernet/mellanox/mlx5/core/devlink.c |   3 +-
>  .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 146 ++++++++++++++++--
>  .../net/ethernet/mellanox/mlx5/core/esw/qos.h |  12 +-
>  3 files changed, 143 insertions(+), 18 deletions(-)
> 
> 
> base-commit: 8ef890df4031121a94407c84659125cbccd3fdbe


