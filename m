Return-Path: <linux-rdma+bounces-2321-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2E28BE7A3
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 17:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238C3284789
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 15:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECEF1649B3;
	Tue,  7 May 2024 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctaAUDX0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46715F30F;
	Tue,  7 May 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096683; cv=fail; b=Rq+nH3YdHcTmhrH7ru9oCLg5dcMlapBVaA0GPIQU2KGJB9CrPL5bTejNU7QMMcTCwpVypMR4YpFwVYRyBvDJQ3h7S6twl98+0WebTX7a40/k9IASWJTsz2bhCq5iyXH5BN0Ng7LwIEF15qQPd1lAGZU03+njiHmH/7GnlJN5aRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096683; c=relaxed/simple;
	bh=XjxslpPhMwPrhx5gSA3QzBUB+zCp2MgO2Jtwk37+K6s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RlQtI21op3G4P3IP4ybZABVrf8Im++fx+fDP2TbCXJ4eFTrw2yevYMUPAZcWqdVe8UZvLRDr9kR1R+kXwzUV6VKWC/pDiOd/1GKp7AlTC7C3HlngCo3Su+IJ1SPFvyl+faw2z4Zk8qX7uvNqWpS9rIBFDGxAYHEPe8A6WrwkRw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctaAUDX0; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715096682; x=1746632682;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XjxslpPhMwPrhx5gSA3QzBUB+zCp2MgO2Jtwk37+K6s=;
  b=ctaAUDX0bxLVp+S0NKRO6A1mibgUnkF1mx34AnqVburcmfhID2fo/J59
   3u+9pIjJP3cgFRQzGrcwyTkC1lnjSNnvOD6BcVLG7gkz/ewA6nrH3PUwT
   /F1SnNWy3Gn/3xDRp9IL2Nn8Mh+q+7378qZeTFv/W7DN2l2kKKxpj32yX
   ZC8VE4T60TulfpcJJZ4XgWvfeYwfUNYJlwd/OISmvod5tXOkMj92TqDZK
   cfXJuS20Mk0gu3ZT/YpkOza2gksqYhJvpC7VOOjnF/nAhuYT3NOhTTL+z
   WEonMeY2MRWNtP8WutxKiy/n7NVsXMF2iBZ4l8tmdwrta9KKlMOndttHO
   g==;
X-CSE-ConnectionGUID: LcfKU7oSSrWBg43IBohGfg==
X-CSE-MsgGUID: j9gd8kssRleBc0If7FM3zA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22058693"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="22058693"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 08:44:42 -0700
X-CSE-ConnectionGUID: RTryS22xTS6PJqLmsNQXhw==
X-CSE-MsgGUID: CEkczbfnTFWvjldUTsA0nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="33364627"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 08:44:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 08:44:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 08:44:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 08:44:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 08:44:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6Pb3ZZ5lJYjvpuZqfrXvdn9WoQk+LnG6Y9a1qDU9GbHrtHgPmEQd5/hKDt3E+abDr9vPKC32KNbwytqUl14iURDzWefzJCO7cEfS5BaKfxyP2zx4O3w6cPRTI5EEdUq1rd0OYPnX7nywiVM8MPk19aUdoIekrcN3oQvw8w17WC4potXnWJtZ9jUoMRDn8khMWvPqonnbaUe+QXOxef2r5egk/DC1LQ/4Qj73HKmqHOepjMrumDRyrtI14MujjYLN63P1N4eOMzyxIaNSLbmzdNf/JFEqnnefGnIHRGBFOHI4tn6E+ZU9/Vt7b/3NkAIVxp5SQFGOm0jYCHlpFtBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClkrWQ/n3gfdtFH/UXBm1IjRIemAQWS7G8LvZde8k+c=;
 b=XxF4B/4ulbUzILAUfIYKdkVu2d+WKDVuvfE1i/R3D7hdDAubsfoA3ThHzxkp2P9qyUOpnS4nlHkbXOOx/vnL6OiIS0OQa0EmxuFiopYFitoNjkIWbokj99B7r7H5Y8qSFdw2dBUePAQ5TIWYBj6OE+PGm0DNf8J99P+ENg/d7ZOFu1u/DDkudoZtPCIHC0FlxVR8+W81jNzJUhv8SFmso7Gul1O4ZmH3k0UkoOw/R+foZvtOjT04QPRlPC8jH7FkD7gpgiKnCbZPS32/k+ogxnhuG8KQV0L8kMfMrOu24lzfFNEwtgcgD7JMzjA6XyrBAE71nBtzqIFEYFUci9nv2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA1PR11MB6266.namprd11.prod.outlook.com (2603:10b6:208:3e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 15:44:36 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::faf8:463a:6c86:5996%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:44:36 +0000
Date: Tue, 7 May 2024 17:44:27 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Joe Damato <jdamato@fastly.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<tariqt@nvidia.com>, <saeedm@nvidia.com>, <mkarsten@uwaterloo.ca>,
	<gal@nvidia.com>, <nalramli@fastly.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "open list:MELLANOX MLX4
 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/3] net/mlx4: Track RX allocation failures
 in a stat
Message-ID: <ZjpMW7KKdtfXv2dd@lzaremba-mobl.ger.corp.intel.com>
References: <20240502212628.381069-1-jdamato@fastly.com>
 <20240502212628.381069-2-jdamato@fastly.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240502212628.381069-2-jdamato@fastly.com>
X-ClientProxiedBy: WA0P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::10) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA1PR11MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 495043be-4800-4089-78aa-08dc6eac9956
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8T9hDJlnzNWcWEDWkIw1oQC1luYjDXZd9TG+k8KTVvOrmleXYlCipbZWFFl7?=
 =?us-ascii?Q?HAk8S+X/8z81Q+kSyqNTSYMZNVFOU4xhN0hRf4ofkwfjgIOWv1uGHzbVkBof?=
 =?us-ascii?Q?+m32R9LsB940JzLqEhROrTH8KAzPV2lZR+NVWCU8dvfrHrZuC+dfbrGUcIFK?=
 =?us-ascii?Q?8+/T1pSgkRmecnKLJxbFtZnzdDoIx3MetxNZFobCWSotGLdpjwubxacu0xE5?=
 =?us-ascii?Q?LDb+HzDp/NL3AwdoaqMDRqthix0/vNaS7RHx1y6w8j5BByUgoF9gRkNwtvY8?=
 =?us-ascii?Q?Ei1eM5pEkHV7juZy82vvGN3rjeLXXN60tK9ehx+N7e0BPGlEw/hNQeCRJ0Np?=
 =?us-ascii?Q?rXY8s8O92xQmv+TdzHkP/w4p+fESmVbgOJvY6FETTxIy9akdEQZjQ5NEcozN?=
 =?us-ascii?Q?ygMN7Q620AqqMJa147646z3hNBDa2KQDcl+AEZP42sGAy49pdFVlquUTTPPC?=
 =?us-ascii?Q?GVds7jFwCUd6br9AwC+tQYneqs9yD8KET2cEZvTMi0Ri1duVJ0nlqJAGKe9o?=
 =?us-ascii?Q?BJoAlFONAR6wdHIkXoR2mDfq5imiEg9wXouQWG4L+FhNYrnRxm5UUizjsejm?=
 =?us-ascii?Q?HTm0pj2FHIlZec3KEs07yn0xzgxi4XFfVSijjqLYn3/CB0yA6JKZf/bZ/pvy?=
 =?us-ascii?Q?ad55BEK+iW8T4cT+tazt9j3EoZDJ5pUXZBfg3QFwX1ImGU05sznkTTYYLidt?=
 =?us-ascii?Q?kwreT34tatNzeEDm/FWZmKYtwerRRDCvsZthAxNv4cE8O9H3GltjM3XWFxPD?=
 =?us-ascii?Q?uDNg55gQOxGk8UnJPWwrCwBUOnZeVqlPvFVjq+B7Lmy9Vodnm98MhfoAAFQ2?=
 =?us-ascii?Q?vnjfhyCeSWfTbKYJD6a6aCqFICnvR2LMwAqNWYTcDXimKWoT9QEKZkF8g/8X?=
 =?us-ascii?Q?LrXzhFfoxow7bAVfxhCS/oHkE8FX4m0+xdARxAUayEhq50eoeegnymhIWShr?=
 =?us-ascii?Q?Qr0bzSaKhF0li6dyPxKXMrwtT6h9XqsWMnfXNF/K9Hqrods6iWlrd9CaXuk8?=
 =?us-ascii?Q?HSTb2fIzr3iUDY8MQQU7KAc5UeQUvWFZ/KBtffHEiX5OlOfKDpId/tOkzQLz?=
 =?us-ascii?Q?idHXCRSodgGZ7uifKmWeIgP7h/lQom1vlgVd4hTyVJyONTrcW1daasQUJ1DD?=
 =?us-ascii?Q?3Clcr+2y+xBRn/ph8LVGecRv1LFVCnVcX5IhQYv9+epn3QIxZUyqLe1ay9N/?=
 =?us-ascii?Q?JdSDmP3P5rQ7aJvAc27fRoxSOJYipQ9yW59sCvXX68sZizEiU3Bjg5BWuSQV?=
 =?us-ascii?Q?n4Ew6W27Jt9n/shf77U2ginyk+h1UA6dL23L7VRhBg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UxgrjCtwKu4jT5BeWoKQIAwCcmxIbwywQj7buYsb5yHyBTgiC4qnOeZh/c4h?=
 =?us-ascii?Q?ZsQJeW603fZWALIppsFgN8muMYDfU3HSdKPhvsHeX0HKLh4INXHBO7+pKEhg?=
 =?us-ascii?Q?eQ71eqiYcqSPWuRDJcepoEL70S5y0n7A/7CnJNrcf35QmZMGbK34SfyiqKkB?=
 =?us-ascii?Q?kxngsFBiJluj0qdXFeakHFqTXZB1SnV0C1G7j77IkY3TIPeZoHapo95EoBuf?=
 =?us-ascii?Q?DO1S5Nhvs/TdtGCviG0mf/rW2vB0U6sW6uzB/T++XIQbTIedwahg82q5sxkq?=
 =?us-ascii?Q?AYaeA3v+3xQQ9bRj5hGwYaWoE+Svi8Gt+HAtrjG3l10YxY8pcSvaUwMOprzV?=
 =?us-ascii?Q?vnnVhb09vwVxxihW+j+ZRsF2Cycpv/5w7YhXwhlVjPDCb2SV0m7GJWHnCzzN?=
 =?us-ascii?Q?uWs7KT80R/zooCoRCxhkSxj6h8hVtkgQ8X28mkVig66IljiIj5xcOr99RR66?=
 =?us-ascii?Q?mNTv6GUd1+PDHHrShIy7AvoVK6uWzaYHYpw9H1PhLW+kxWnuNX/27tJ/TPTE?=
 =?us-ascii?Q?sVLUWZye+0dYS134ReK1wXWK0yxFRx7S9JOtpmUJZqhx9laITvLnASk0urBa?=
 =?us-ascii?Q?9PfuPxKTYmiyw0GPbWjnupjsXzQ05huI144wMd3cu2RHbP2VfueUR2QklZLO?=
 =?us-ascii?Q?Ww/6SKmwJdQKertJzvAAx4wOi6e1rQ6MkwVlIi4DEAjqq8NLUSIzAFlZq8XF?=
 =?us-ascii?Q?av6UCMPam183/cGTGX25dv1I6nDMSpy3l4Royw+11/x6/n39Zn1dKmxAxFLQ?=
 =?us-ascii?Q?BwCyqHseWDyqwLUPaffWNYp9uzffpb+8VAAi0zVNssrGqbvYE8OQzKGWHCzz?=
 =?us-ascii?Q?pIENQ7HXsGxE14EYREsarEaAHwqXKIYuxiUtWkTZA3UbwZtiHxENuU6S8d1G?=
 =?us-ascii?Q?yuh6n3wCncNF4EIX9DtUxOtRqeYhztbNEG6S1pZ9lBz5Ktq2wr4LLkwwJ0zS?=
 =?us-ascii?Q?3dyJVndgTDEM5D2NuHPi5pX+PoWoW3Y/Ld6kNAomAccLKlO3HqL2R1adl0eZ?=
 =?us-ascii?Q?lRXxO3IlKl6zpRv6w0sC/p+fJqf7zllhRRSu3JJHweE2PDI2fiVt+4BE29Cs?=
 =?us-ascii?Q?NJ3bN4lZiZX1wpkkjxRmRtIUFOt1tfzgSSDmoJPU1GFPt/ry1jFhSN4oCl/j?=
 =?us-ascii?Q?f08WXy4pHn30DFBRWDiWisRjs9abaGeBSK1avFtZEqKQf/AJM45An4YGEmDq?=
 =?us-ascii?Q?EgGrvizmNtNWau2PniF26lkPETcHYhosDdynAYMxD3bbuJLPbN+Y0xx1B67a?=
 =?us-ascii?Q?2V/YR5KN8/xcbDsCng7nYGF0rbXktN98iZKCXU7D+j2piI29Nu8S78CrOc4T?=
 =?us-ascii?Q?yIsCwrCTV2vSafb581acyxoof98ZjMZv72PKApVnQPWkkaJHFlr9d5cAdfWg?=
 =?us-ascii?Q?HVfJ4DuRgugkbS/zzDDXiHVDjrLzqJ6wUs4QaBp73SUp62j4P4MUF1lsW01W?=
 =?us-ascii?Q?5XcFtwiElN/4pcka83g8q99uRX7U2eb5Mka/WOQsQt5n8fbPk0A3zagFtXFd?=
 =?us-ascii?Q?TR9M5Heq/wtF5u1SBGOnovVvz0owfX/6x78e1A46YDLzGSGFU+qUWZvVDP+3?=
 =?us-ascii?Q?Nzl2y3GZYUdHMhpdIZh2iRfG6mjW5mvjc+Ge6ZdU6ey0io+B4e/FdZcCpU8M?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 495043be-4800-4089-78aa-08dc6eac9956
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:44:36.7453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: In0FJef1N0A/fg/i4gID4UFiHI9dDndex25hXeWzrtabNnXZiL94lGw6RTMS0eZu3DPIBBs+PoP04IdhCHqIFpJ9Xnmbi+mJf2t8XxQZntU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6266
X-OriginatorOrg: intel.com

On Thu, May 02, 2024 at 09:26:25PM +0000, Joe Damato wrote:
> mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
> fails but does not increment a stat field when this occurs.
> 
> struct mlx4_en_rx_ring has a dropped field which is tabulated in
> mlx4_en_DUMP_ETH_STATS, but never incremented by the driver.
> 
> This change modifies mlx4_en_alloc_frags to increment mlx4_en_rx_ring's
> dropped field for the -ENOMEM case.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> index 8328df8645d5..573ae10300c7 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> @@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
>  
>  	for (i = 0; i < priv->num_frags; i++, frags++) {
>  		if (!frags->page) {
> -			if (mlx4_alloc_page(priv, frags, gfp))
> +			if (mlx4_alloc_page(priv, frags, gfp)) {
> +				ring->dropped++;
>  				return -ENOMEM;
> +			}

Correct me if I'm wrong, but ring->dropped is added to rx_dropped stats in 
mlx4_en_DUMP_ETH_STATS(). You have already established with Jakub that 
allocation error does not mean dropped packet, but the counter contributes to 
dropped packets stats.

Also, I do not think that using a `dropped` counter for something that does not 
neccessarily result in a dropped packet is plain confusing.

>  			ring->rx_alloc_pages++;
>  		}
>  		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
> -- 
> 2.25.1
> 
> 

