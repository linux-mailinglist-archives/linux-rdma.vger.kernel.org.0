Return-Path: <linux-rdma+bounces-8687-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BC8A60482
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 23:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE1C3BABDB
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 22:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6A31F7902;
	Thu, 13 Mar 2025 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzSRPFKM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F78722612;
	Thu, 13 Mar 2025 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905567; cv=fail; b=dWpBeMAGD2Z6AAklYa8GD7e2aTMXlnuGn/7B4//FeQWn0URIZOysWbZxbl19wVyXSsUl0kf45C+wsi35TtmbqhPHVaJfDKMh5U54Xt4n2YQ/ovuVLHIwdfF8fAktK0PIFikixDoyD9cxq1BSj4gKqnx8woAmoOFLP0vKuLLsgvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905567; c=relaxed/simple;
	bh=uoBLpwYhSVUhtR2zd204MsHoP2VJ6DeaHettywvwH+Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LRQ7nqV49S5snqIGdqvLhQTLVsMNsmN4tGUr4Z6wtcKAJt4a4fXMqqHIwnFoKLjHe1dwYuP9eE4sUfqrMnwMph/sBYKFAroMlnTiQ4GbDYylyaQRLSpV1/pNOUxTQoDkWAJH4m5HntOkTg9MATh6AIIaK9x9paw2syl1nMXGfHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzSRPFKM; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741905567; x=1773441567;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uoBLpwYhSVUhtR2zd204MsHoP2VJ6DeaHettywvwH+Y=;
  b=BzSRPFKModksnhvUoss5dNEnX8Ggu9IiAHns/+I60m0MwvOGG25zJnew
   O+zFFUUOCEkLl+Jeqvnr4bU+k/kQhPvSWvw5MH0jQK7EyzvTC5ajjH79d
   gJt4OsW8OWZidSrH6mNwRydSI7znblAFtF6q5kUqPholdI886LXv4fzAE
   TpK4qWcZXEIqfVC8BrNGdMgUTvZl4ud+rvaU40gPiPjWxAfqIbPg8Y+Ze
   aNU+HjF+HYGOKWdcUWP2/Zx8AE5Ky0eNVtHxtQcCxvfSMp3N9Btn/t0EI
   6hwPadFf7ao9l5v151KDsLBiHCvoM54c2WOXiXTWRY/8xrURj8X34c2fC
   g==;
X-CSE-ConnectionGUID: 65YdcSpxTq+4Xx/lMG9l4w==
X-CSE-MsgGUID: wSCGQTitSIq4gxtxW5ZXcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53253520"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="53253520"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:39:01 -0700
X-CSE-ConnectionGUID: qpiWSrxfQgiDz3yQu9BotA==
X-CSE-MsgGUID: 5ba2nod+SdC70gqTMxOQaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="121594999"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 15:38:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 15:38:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 15:38:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 15:38:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGDnuYkr0VISEybmOjtBs5gPxwtKJ/nGYYC9ggNrrKiiU6NDdPccxl36Bc7kNNuVyRyYENOkhGuZl+PNUqdIAY5BkUI4ud76BaaNLE4wEqs2wII4LoWGM7ehKTz/g/OBunMsEJzIrwbgwDzrmNo5ehhSySydyBK3Rwbo8RgKEZib/rIynRZXfgqh1cTFoAYyZY6EH7Nr/hIa61zkFb/JA01bXhBG444z0KRnLwwSMGwaFtwoh8JqG7YL1beCZEg5vaB++reSnBgN3CenMwh9Qw7DJS/cWkw0MUdG++qENGpqU8PmXVnenETz+y44XDDQq+WZmvNQ2yLfLoJdnoaZ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP5Sux5fE2QVIId8OeGVY0q6BOiEtMppiF86oz7cVD4=;
 b=qmuVEK5altktFsDtNYqO0x1pQypjvutpDC5xiOQYlUN2h3dpobLeT+go2Dw90JHSgKvnzUzLCrInvxczy5EtUdhm4FRKA1QKv73eQFsbGbEHNZtBCz+jOvDkt0EpyGevKD+cVZk+GfaVv0avPUBFPBu+RFKO3TU8oZs8x2CrNaM+vzGE1XXR3HoRZGDGwk7A8KbBKDcyN5lJRNtrFFWygol48NZgbddj6TK/+Dvr0U7Iu/nj8rpEaFcy7CLQjSsDhtZI3ymZEJvZN8+JjB23PCvpXBLAXvVpimrufiRY6kTzDWS2E757KqxipFn9VIf72vhZ8N+OQS4GkqxTCME9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6173.namprd11.prod.outlook.com (2603:10b6:8:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 22:38:20 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 22:38:20 +0000
Message-ID: <009beb69-fbda-45eb-bba1-9091d12653f9@intel.com>
Date: Thu, 13 Mar 2025 15:38:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] mlx5e: Support recovery counter in reset
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yael Chemla
	<ychemla@nvidia.com>
References: <1741893886-188294-1-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <1741893886-188294-1-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::24) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: e16e7445-1067-45ab-16e4-08dd627fc190
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elQ5SGkrS3o5RW5FRlVmU2xqV1VtNzdVNnU1aGhSNytEVW9GbzkzWVExVXhw?=
 =?utf-8?B?WWNzVE9jYXNtK2o3UVlpa2xDZHpZdHZzRVQ3bkMvRWtOR0VGTDlkbmFzZkN2?=
 =?utf-8?B?SWZHcmhlRG5MUXMwZDhkNGZTUlFtRDFlVHJsbk1RSWowemVEcDV5cFQ0ZEd2?=
 =?utf-8?B?dzJGTFFKYWlmWS83by9yVHhya1BvejIzZ1YwcXhHQmoreWt2THJ5blFYU1ln?=
 =?utf-8?B?dE4wdTFLcitSci9nN2IyQ2ZwM2dxSWYyaEhCNTJlK3A5SXUwTm5uSWQwd1oz?=
 =?utf-8?B?VnRTNm5NN0d3Wm8vbmFuT2JYSVo3K1FYNkZ2dGNLSjJPcW1NR2NPeHpYR21Z?=
 =?utf-8?B?aDlPYlNjcHJCdTRsb3FGamFXOHlLc20zYXdHSVpxVlhieFVrSlBYVzBrbWRK?=
 =?utf-8?B?R1paQ2VmdTluZ1FLVDY5S1lOTG56c09uTlR0aFV5ai9qWTRKMzF3eVpSWnUx?=
 =?utf-8?B?Z01ocmFsMWx6RTZKUjNWR2tnSW50TkhBNFlOaGFHd0hwbTFmaW95Rm5BTWQy?=
 =?utf-8?B?YXVMNkJKVXZCckwvNUk2N2RhY29LOXM0Z01jTExROFJ1S016QkRuMzlqRTdl?=
 =?utf-8?B?Sk9rdEZMVWFxb2dENDNSdytLeDNXTVl6a2hQdzlxZUtMOTMxMlNhRnIrODlU?=
 =?utf-8?B?NzhWNS9rcXZYL2xsVWhmSVNXSk54MzdMVzNOSkNsUWxKMktXTlhLOWJrTWww?=
 =?utf-8?B?RFVRMVhmZ2N5UEpabHlaeDErYXlNbDBCZEpHSElVWTIwWmF2MFQyeWx1cERh?=
 =?utf-8?B?WXJ4Z0lBZDdrd1J5WkFwbEZHYnF6Y1FNMXdwdzZUUkdyM0xKT0ZWTVpKTUx4?=
 =?utf-8?B?R3FCQjVTSVVvNUNYYjZPUWtLYmg0RTFVSzJvdHEvRUI5WXRyV3VHUFB3bUZy?=
 =?utf-8?B?VXVLYk9KL3ZwVWt0Q2czK1dwYmlIWVU5bi9VanJ5QmtuZTRIS0xNWmhiaUJX?=
 =?utf-8?B?eEZxdm9DaVZvZDBMMjBWZmtoSmhEKzUxbmFoWVRBT0IwRkI0aHNyaEVnaXRl?=
 =?utf-8?B?NTh3L1Uzd1U0UnowVFBYZmIxVFB5OHZUK2ZvWk1laitMWGRTYUt5MVRlcm93?=
 =?utf-8?B?blhwekJ5ck16RG5vbFBwOFZGNWh2S09IVFVnaGdLREZqSi9iaGpBVXNhQXFF?=
 =?utf-8?B?Q1E3N3dQMjkzcEZDTnVGcm9BN0I1MzlCWHhxeVVWdlpMVCtXeUtrRUVpb1R5?=
 =?utf-8?B?QW95QytFSTB4bkdydVhsUVZFOGY4R21rYW5ocVFEbktKZlBFVlBGWUFXSGJZ?=
 =?utf-8?B?cndvbWllOGpKbTQyM2dGUDAyL1RKSXM3anAxeDh1YWRLdzU0VW80SC9DZVp0?=
 =?utf-8?B?TFhOZzVqeXoveVB1VHRZMXJRT2ZWT2xGbzZCVGJXVXdmLzdTWGpiUGl0d29W?=
 =?utf-8?B?ZCtaV3l4M0JNeURHWGNEUGUwZytwajZBbkhoR1lVbmFJYWJoSDdQRVhFMUhX?=
 =?utf-8?B?K3JMMmovZ0c4RmpKZHAwMi9tOTRiVnpId211YTFyWlhTbkl1aWRPME9kRkNv?=
 =?utf-8?B?cHlSMmR0VW1nMWVtVmdqL2doeFJvdTM5TWprOXJBWW80Q2NkSEl1ODIzWFpV?=
 =?utf-8?B?TXdxVW4vZ1E4VTBZZVNualNzOHZLQkluN2VqbjNGM2libThvaStmWENFajJM?=
 =?utf-8?B?UG5IQUoxVjREODF3NjRZV3EvRzNpaENCajk3aHVSM0MzckJiaE9vWkdyYmJO?=
 =?utf-8?B?S3cxMks3dGd6WUowVkVTMm5nMHpIZkVicWpwak9HRm5pL2wvc05UeitFVUhn?=
 =?utf-8?B?elNvY0M3dUxLZlE4VTc5Rlh5amVTaWRTVXJPWFE1c2FPRDNINnIxQ1lZTThJ?=
 =?utf-8?B?UitNWkhSaVpEWTdUeVl1Yk9sRnJKQlhrVjRTRDc1YTRuNmlSSFFwUldRc01l?=
 =?utf-8?Q?vUFcS84i84Q7Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzBoUnhlZTB0M08wdGxKVUI5MHFnQUFsaUhmbUM2N1IwQlE0cy9VY3VwOUdt?=
 =?utf-8?B?VjNhK2VPdEt1Z05CTFpsemNtSXliOTZtckkyS0NOSVhrOWw5TE9lNkFadEp5?=
 =?utf-8?B?a1RYVldsVitYWUxFSjBrN1lnM3Rja3FjNEpwTXI5VGxPWDIrcGM4WWNrYVBo?=
 =?utf-8?B?b1V3R2MzQkw2a3hGOS9lUlQ0ZGZMLzlQd2ZNYldCaFBreVkwUkFnMVJZR2M0?=
 =?utf-8?B?TlQ2QWZyaXFXcW9YelVnRUhjTTFUOXM5SkhaK3UyRzlIV0YwbytCSUdhK1A0?=
 =?utf-8?B?dUZhT0JIWXE0UUlJUVFQMUFFSTRtaFJzZk56czFSRVJWY2dxeFRxWitaUlAz?=
 =?utf-8?B?NjhlNnVOK1hjd001Slp5QTFEN1czN3ZCckNZSjBSSENaWEk5MWFnSUJ3a2Jt?=
 =?utf-8?B?LzJsUDZJYTgrQUx6a05DeERjN3Vac1k5enpHOFlEdjNoc1AwbEJkV3BHakl0?=
 =?utf-8?B?REtLa05icHdoNysxYWRJVXdqN25pTGFEd0MwdzNYcjVReEpiSWNaTjNMNmVn?=
 =?utf-8?B?WWNDRGJGVjJnWVVaY0tJTGsyRmxBTEZzV3AxcGUvaG1KUE1zMGpKQzlXUkNQ?=
 =?utf-8?B?UDd0VE1LL1BVN0VHUDJ0Q2tDV3pKNHlJclFCcnM3RWR0R0J1QithVHRJQXky?=
 =?utf-8?B?a3c3eGZuOC9QQVZTUlFUUlRRc01FS2d6aStzVjhaZlZSU1hORk9XRFowN1dR?=
 =?utf-8?B?ZUo2VzJwQU9TQUJuRHFta00vQkl1ZGJTWTJLQnhYemRqZ3owY0M5Z1JROTFK?=
 =?utf-8?B?MndqdVRqdnE1b3pucWVjV2FoNndJb3lTMXBRcUJ0ZHlUMncrdFowZkVJdDU0?=
 =?utf-8?B?OFJaWS9ZdFZTOG5vU1JrYTJqaU42eTNPeDdldVg2U3VCU3hoVTl2VWsvMndl?=
 =?utf-8?B?eEpWSWhmWkxyQ0VCZVFjWmd0d0d6TXJueDJ5cVAxWW5OR0NuTldhV2FEdmRM?=
 =?utf-8?B?eDFlalJEK2k2YWZEYzBoK25oOVBJLzZodVlqbGQ5QW9DZTkzTHRTOURHRm50?=
 =?utf-8?B?TWI4NkVaazRCcjJrUndTT1VEeDdTUEorYi9wcCtLeGVFV0hzcEY4cUVEV1RH?=
 =?utf-8?B?Z0ZOdTFVK1BzQUM4OHFsUi9xTlFhVExHZmpWeUpMSUYxOW8yc1FJOGdKNnkw?=
 =?utf-8?B?aG5jMDJKNlFWUVd6K0JFWURnN1MyODFjNTRJQ1Q0MHMrMWVxVkFkaW45b2Nn?=
 =?utf-8?B?cW1MYW5YN1VQUUdTdmJZNUZFeTdMNFRGZ24wL0pLdjY5YjFlZ3BrR3dFaHh3?=
 =?utf-8?B?NnNWUEVQME9OalVuT1dJbU1MRlgrN1hTV1dnT3BYZ1NIVVVCOGkrYUxKT3BF?=
 =?utf-8?B?U0ViMFpNR0xxKzVyMHJUT3FkYTMxNllQckNESDlicWpCTDIxSVZ6YzZVR0VK?=
 =?utf-8?B?T3VHQUk4NmFOUDV6RWFIU0JiRnpVaUo5Zlg4bERSVDdWS3hhcFc2ZzVGcFBI?=
 =?utf-8?B?WDZZRHJtczVUV3VNUUxFOWt2U0lQdlUwdFFCUlJtdUozU3h1TlRIZEVXbkJ1?=
 =?utf-8?B?NFpoemgxNXp1NjhSNlVkVjRVeENMd2Z0Z2ZqY0tmWFo2YjBwVlNDL2lRUGJL?=
 =?utf-8?B?ZC80QkEvaGlQVXR3VGhqS1AwckdBUitVRTRvYkplWTUvYm1DejRRbTQzendO?=
 =?utf-8?B?SE8yUWE4OS9XdUF3Rno4cUQySnF2aVdmcm83TERuY3JoZy9QNWhQNWJJU3kw?=
 =?utf-8?B?RFdZQUNIdFl3dE5lS05vRWlWYzk5dFppNXBFbytacWljQ3NMUlVZQ2ZxSXdk?=
 =?utf-8?B?ZGJJZzB1VStNc1QrQ3MxOWNHMW1NNUFJVHJ0N2V6NlJNbTRMNTc4NXBnL1ov?=
 =?utf-8?B?ZzM0amZTK3pwNWc4ZkcvZGtMaHVJVjZTRnBIVE9TTldLS2o2am95U0lxSnRV?=
 =?utf-8?B?eUpWNit4dGpMRTVYdGoybVFRMmtYUWhySjlYaTVxVWNnM3g2VVk1eEFqTGVX?=
 =?utf-8?B?QUh5NXJTa3dDUUJZRGFweGRKbmpNZnprSDBHR1ZPNzVmQjJKdmhFaG1iMTJt?=
 =?utf-8?B?TmxXTmlWNmVBazk5RkhFbE96MjRNUEMvWGY3cnJEN2l4bk9PdVV6aURGQW4x?=
 =?utf-8?B?N2RrbDdmZlRNeFE4a1dDL0t3WHNNdXhpN2EyTENSOXI4VUVYWDdCSGwzWURR?=
 =?utf-8?B?ajY3YjNnUzd1NnRiVG96V0orNHNMVGMrSUlNZllDK3d4SmNPSGFvTzNFYk9E?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e16e7445-1067-45ab-16e4-08dd627fc190
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 22:38:20.5781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwHWtX6ek1EOF55NXIT7asGL3zVTSClqNpcZFny7FjCYKUf9Lu0wredUsZG+JsBau4egCmAiCebA0LahOssepRciw7Z3likNBtZq3kudX54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6173
X-OriginatorOrg: intel.com



On 3/13/2025 12:24 PM, Tariq Toukan wrote:
> Hi,
> 
> This series by Yael adds a recovery counter in ethtool, for any recovery
> type during port reset cycle.
> Series starts with some cleanup and refactoring patches.
> New counter is added and exposed to ethtool stats in patch #4.
> 
> Regards,
> Tariq
> 
> Yael Chemla (4):
>   net/mlx5e: Ensure each counter group uses its PCAM bit
>   net/mlx5e: Access PHY layer counter group as other counter groups
>   net/mlx5e: Get counter group size by FW capability
>   net/mlx5e: Expose port reset cycle recovery counter via ethtool
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  .../ethernet/mellanox/mlx5/counters.rst       |   5 +
>  .../ethernet/mellanox/mlx5/core/en_stats.c    | 119 ++++++++++++------
>  .../ethernet/mellanox/mlx5/core/en_stats.h    |   4 +
>  3 files changed, 91 insertions(+), 37 deletions(-)
> 
> 
> base-commit: 89d75c4c67aca1573aff905e72131a10847c5fda


