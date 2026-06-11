Return-Path: <linux-rdma+bounces-22125-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uyMTNvPcKmpUyQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22125-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 18:06:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3092C6734C4
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 18:06:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=GGGbtadx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22125-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22125-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68F7A3437693
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 16:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0024403126;
	Thu, 11 Jun 2026 16:02:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684B42C3757;
	Thu, 11 Jun 2026 16:02:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193738; cv=fail; b=qbHBg5yPzZLJdReekeChmiHoQXGEjrleXM9fCOITe1THHGmw8bW3HmOC0q5TFdbrYWrnd5SB03LawQty3LyBtB6pI5us0M0RTqOfhr3N/weps2/20Lf3sC9luYRT8DTPpo26lKnayBd4+TFoNiBTMmbAjqSvuc8jj9W4ahh4ULM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193738; c=relaxed/simple;
	bh=RhDhkJ5pyxif2ix+6VS3cg3UaxXhPGRVfLjNNaf304g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HSvPXnp7kRhdy9fVXKqHGWA9cFTfpy8Qzd9KBbAQqEHHQMBD7X97i8FD1IX462f1BfvSX2Frb/tvBYaL16p+JG7FxsMUvGFj4Xe0pxbXxrAHe3T7oUaQgu4uBSZZPl3ieH/N38lF16YvlmuVyN3o6Phejh5Plk+SaCGZq5D+1dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGGbtadx; arc=fail smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781193738; x=1812729738;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RhDhkJ5pyxif2ix+6VS3cg3UaxXhPGRVfLjNNaf304g=;
  b=GGGbtadxh1cjGhDbo01CNHl3QLp2EF0KClHpwSUFL81rVoEOLLXJbX9a
   eKMtmQSyGonpV0Yf/7d7rlEX0Pe65FZVSoR5HG9d0o3erR2DlxTkVtdrM
   zRdZ2kvur+SoCRhjERRHe13a2aVzfhHcjoBKk2PMQiL2G5/mG4ZFaV5Ta
   VVpil8VnbNKZqCUSqPeVQjZeJ8xoNQTOvnbkZGrFcmnLkWiVQhQYHNG4x
   nN9Sll6Z/Y4kdWSgIZhHzriCjmvpa02TQ54H1SJAXAkyT4Un4ZwoGuS0r
   Gm6ckLtaM7t+Xt6EHKTpvZRwV7e81lVUGVr17stINZ2zP2kgMtUaI+Yk3
   w==;
X-CSE-ConnectionGUID: l+zfmmN7TBq0MygY4icwCg==
X-CSE-MsgGUID: mnsWgUsQQwuoq2ae8ckkhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82202924"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82202924"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:01:51 -0700
X-CSE-ConnectionGUID: hEdWRegVSx2jbl6qnvYzag==
X-CSE-MsgGUID: 7Orw+3mkTMiJ4wyAuYm2kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246602502"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:01:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 09:01:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 09:01:49 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 09:01:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfZHwFU9aEfU1Fcx7dcgq9cvveZS8pzbIqCMjQRyl/gZ8rR0GsxV5WpR8+905RKcA7qcABiKxZN97WzphT1A1JQzXBvuR3rZY/jJVU9jJrUao2YDL4h2R+iVsviM7S5aVRiB5HmdK0E6oY4lGMGyKXSqtxXxCgXHK935kTHbCV/mvVXRmVLmcVeI5JERI7ERVSezLtbpPClDSpjZ4PbHL0Bib3xVeyma9NapQCJi3dfALNGwzAc93vdBAcfarFCUVWzXSfeRo7qwMpZl/rLneonQlZ6AHlwBdxaAZOgo6vgt9QvFF0d+LMWb1RdwjoXDkoOrldgn3j6JL57SJuWYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NyIJJ7kOlQeFgqwyM3Ve8b2aAbA2T7Dd6b+5F0XV4o=;
 b=Rh/4+yu30kiUY122m5av1RQE5Kr85RqgoQK3ZD4bfPl0d+Z1xbkVi5eWTCGdAbGm6M8p03vKH5+V4KQpfwsvDJjTAf89ARL7AXsgF4+XovaiXYXu4cnqD1XJLaBUv/jgDkW/fguq0wFgW7kBOY08MPC/RpT3eGFOBuJ4PL2zeRULwXjHkDNjtWZ+PFgmYh/ynFv4JtKIy4DKlCzmJ3/jfDvq1oMn7rrnuzoBLtf6xqdM87fLfuuG4usrR/kCQWclxAtfOTTCQ2vNdV8SMxSOI2CDW11V64Vj9pHq8luDcWB6mkr87pOM7nIJ4BOCZk0mZy3/zwHPL7pdDaHcEUyKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB6854.namprd11.prod.outlook.com (2603:10b6:510:22d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 16:01:37 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 16:01:37 +0000
Message-ID: <c11af82e-0adb-4ebe-a9f1-7c4a543d0a5f@intel.com>
Date: Thu, 11 Jun 2026 18:01:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Fix oops from ERR_PTR in act-miss restore
 teardown
To: Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Vlad Buslov
	<vladbu@nvidia.com>, Paul Blakey <paulb@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
References: <20260611134836.534015-1-tariqt@nvidia.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260611134836.534015-1-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc59dbc-1614-4cc7-45a0-08dec7d2b67b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: y7TWxQ3SJJW9BsbruYSDIx0cfkecNxnD5Pni6OFwX5sqthrw+p9qRfKYNFXa5RCefeySnxq/EhMCaLaMTnY8QuH83H2WMomC31czhqxhxw3gVnBEPNJoZwJOSgP9HPztsh/PVhQBjBDRymkotjmzDJB5ptvMSBR4c5WB5SHViaJDeMDPvVcxrU3T9qf6x+vj4uws5M0gQv1Kq7DqvWkxRqWfynf/1ZdrePGIfSQMj+NA5zj2YW5M9wc9L8Pnh90wVm0u+Mjr7b8O18EKK7CaoOE4gnQCTjenSFFwxfXAMtgteGV8rv2T/jkj+7Q1MJCcgIBekgq4yKuJc8BOidEMKrIenPtsAT3TTOk9iu27ag+wMJ7bF/YOEDwhSVHQ7iWEdySuWXBlgcLzShjeG5yzslA62MyxfLCI3tQifcA++69qlDxd3UyAnaBpV3oNq0EZvJv26ynnGsX++cEAeIB0dXVqHI6A4Haci5KG+jVj42gXAy68wKbLhQo0j5LSJHxkXNeC2VBpx+v5zmW+rNGLnvLOlMgRun9YTvZ8H0QbivdDJ+YfQzUbleOPzbdWNwKVc9pugKCquvv15ILp/bcD4b/145Jj2+0un8Kuk4EN9EfXb9wb7NeSE5yN3iU+exHhOBzjbcy1nfIHrVegIOxHi/WL4HY1KqFaAPGbMoXQ5HIfzeKNbpdGtUg8F2yt4TI7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGx6T0pDMFZZY0ZOclhhNDdZVWVPckF2dkZWR3U1ZnRVSWpFcGlsL29Udktv?=
 =?utf-8?B?YkErUWxjWFhmRUQrejJSYVkvSm5FQytCUmlzV1pUak9SblJwRnA0QkRhNlJM?=
 =?utf-8?B?bFFyMjNoNWU5eml6cUJLN0wzMjBkeWZNVDAxWUswQUpWUWhDU21wRmlFN0xa?=
 =?utf-8?B?VkFFQ2RxMWl1STZCd3lsUTQrNDBRWmFUZENZQjVMdFdwQ0ZZeFk2UXVLdmpV?=
 =?utf-8?B?RFE5Z0ZUOXMrbzN0VGZoakVic3VQNDJzWko5Q21VSmdMZkdrTEVEVnkrTkh6?=
 =?utf-8?B?ZHFBMWN5Q01uNmhGSnEvZ1BRTVB2N3NHM3FkRDl2N3NWRUVQbGp6bjZXczRq?=
 =?utf-8?B?MzdrSkxZMlVsWVZMYnV1R090VGlOUzFQdU1EMlIyY2lheGxOTU1OektaQmpL?=
 =?utf-8?B?QjZ0bFppODM2dzVVVGNFWDNtYlgwY2FsRWVpckpkSS9hZCs5bjQ4M2ZKazNy?=
 =?utf-8?B?a0kxdm54YVhrRXkvb2t3NDVvNFc2TW9qU0dPanR0V3lTMU1ET3NuTDFlc3ZR?=
 =?utf-8?B?S3lBcWppb08yNXQ1ODRSMFhseFF0a1JzSnNyaXljcUtqZnhsVVRqS0pBNWxm?=
 =?utf-8?B?bG84eEY1VktVRytSbS8yTG9ndjJZajlySi9YQ3RIa0dveU41VlVrYWh3T2x4?=
 =?utf-8?B?Y3ErYzN6R1M2Wmx3TEVYcG9EdVphcUx0cURjUklCYWFnMkd3bTlvQVBkVm1s?=
 =?utf-8?B?c0ZpU2hmdW5vWERXNkFRMUxZZDI5VWtEWFByUmNBcDhyditwbk9FQlFNQ2p5?=
 =?utf-8?B?aTZBYVd4MmVhUXdPU3BkTG9WcVRXeFdYVjZ2TlV4WlVPTXZIWHRQd0ZuQkxE?=
 =?utf-8?B?SjI3N2ZUVDl4SEt6Y1UyeUorZFR6aVQreWpDL0oxc01qNVk0K09Na1BZdDU3?=
 =?utf-8?B?WVBKQ3oyQWVqQ3BWd3dJZnd1T0FYejJ0TVR6cXlRaFcybUdlZVA3U1pReWlZ?=
 =?utf-8?B?d0NSZjRKY0RqZmdmTjBwZ1BMaCsxL1YxaWFxclpJYVZkaGcvWEU3WWxLM1JK?=
 =?utf-8?B?aVJHRVBtMXJFdFFhaGNEc1NDNi95dTd3b0UvbDJYcjArc1RTSzYwRzFvbGNL?=
 =?utf-8?B?R1FIN01PQWh5anBCalNnREc5SzY4WklxTWZSVk0yMlhGYmV4VGVRbUw1Wis4?=
 =?utf-8?B?OEhWR2FDd054OEJIbWllVUs0TzNVeFhjUFNZZWtNNU1ZMXBZWDA4a3pGUFlW?=
 =?utf-8?B?WU5zUDlTeXphUHFHbUJwbDZwRWtGMGp0dlVpSFl5UUNLZDZ1OWU3VHA2OHhW?=
 =?utf-8?B?d3ZPckt3NFBPb1RMUk03d1F2WXFMK1JZc0tlbUVqRWo3ODh1UGxpdTkvbHFs?=
 =?utf-8?B?T1lCQkJPbUt2QzJMVkRuR2dUN2JBSyt1dmpLU2NPMTNaTkloVDJvc2YydkRW?=
 =?utf-8?B?Z3hWWmJWNjAwODFZbXU2WElNTUFWMlJDNmg4QWg2aHRTTG1nRmJGQzh4dUZz?=
 =?utf-8?B?dTVYejk1ZEtpS0tZZ05jSWlGWVZtL3FHL2YrSGpBZ0UwL0JLUnBlOWttT082?=
 =?utf-8?B?MTVKMjRxd3pwWVlhOXZWdllZU0pXU1oxNE90b0VmUVlJazZhWGdNS2gzek9W?=
 =?utf-8?B?V3V1TnRHVjFsdlBGZ1lMZkYyRXVKNHZ2WHFKQm50eDlKRlh1bjM0NXBvT3FN?=
 =?utf-8?B?ZDJpQU13TVFVN0o2UldEWjFSUExpd2ZKdmRySEdoTmYwOG81YktjTzdkcEN5?=
 =?utf-8?B?a2kvcWlMdHM2aXByZm8zY0tub0Q5WkkxRnZmenlxNTExWjZJaHlFQjV0Vjlo?=
 =?utf-8?B?RDhxM25lYmZLcktXa3k2cXZkOEFWcEoyZ1NtdGIzdVljOTk3N1BkamxzbktN?=
 =?utf-8?B?VFFMRmY3OXpMbUJJeFNOaEIwVnVlbVV1RDFGZk5EeURxYzdmRmJhRWR6RTRS?=
 =?utf-8?B?dzFlVElVSzMrOEJqOElpS0hEVHBHRGU3a28zUkNhRUU3NHV2ZTlQaTJ1em16?=
 =?utf-8?B?dFVTbUJlYklmM0trVUhMZFd6cVA4UkM2VjMyZTJMSG5WdE82cGRsemVtWWFY?=
 =?utf-8?B?R2xuQnZjd1ZrM2hINitTZXh4YVhRWnNRQVE2Qy9RR0d0clpOQmMxY0NreWU2?=
 =?utf-8?B?QU5NSzVoUG96K3llTkFxcHYvaDlpdkhsUGVEeTRJdUQ4MnpCY3pyVVp4V0xv?=
 =?utf-8?B?djlMRG5NNGZGbGJaVmhJZ2hRWkZsc0NRSVlsMUorSldFdFQ5dzkyQjlDZSta?=
 =?utf-8?B?ZUovcFRGblVzVGlTNTg2N1lvRDdSZUlTeTdaK3RtWEY5cTlWOFZWMjRwODhi?=
 =?utf-8?B?b24wOWlOQUlSTnh4NEtqOEZlSTJVRmZPWEJFbFM2bElrUmswMEQ4VGt0a01p?=
 =?utf-8?B?Q3ZWeW45aDlPbUxFSmFuQWVDZTM1UjhZQ3BBdC9sei9ZOVpGUmwxREhOTnR0?=
 =?utf-8?Q?BiEZC6bvKoBUQ39c=3D?=
X-Exchange-RoutingPolicyChecked: kWm3HvwR1ScPDymDRwc4wIM4Lj0wt3sySTkOTcwH36zd5kaUCCFaFQBqHUYOskfX7VzE7VSfZqd0GgOPWOhmkmk6xCrXFDGAU1f0ytrqWkStYi8Z/tN8ZZ0ehsiGwTjhX7dBaLDw+Sh2SamGGj6/2ylUxZAgvEuYok0umKF47thJF/hOuYAROoC+E93HEUzU0FCDPoaZgQZbFjuJf38f2kBQRu4jeEDXf/5O9JH0Idfik0LxXlRSuBwL+sVdnVfJOKRJp35jMeMN1+fKYAcjR7a1Gs2Y3F+dtjNnShgj+dUrCw05zvb6+3YBxXN0WUmNJpcazO23cQslIv1HYT88Ww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc59dbc-1614-4cc7-45a0-08dec7d2b67b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:01:37.4343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPktgWGHJ+nkoYT+u+4ZN6hw1saK5tqbbUAzQouZPqDBkk4zXJ/IA1qmP9lb79zKs42+iSYHPPymsY2hyEKWMueixD8UwocMjq7D6PoQ9EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6854
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22125-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[aleksander.lobakin@intel.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:vladbu@nvidia.com,m:paulb@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:lkayal@nvidia.com,m:cratiu@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,nvidia.com:email];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3092C6734C4

From: Tariq Toukan <tariqt@nvidia.com>
Date: Thu, 11 Jun 2026 16:48:36 +0300

> From: Lama Kayal <lkayal@nvidia.com>
> 
> Restore-rule creation stores ERR_PTR(errno) in act_id_restore_rule
> on failure.  Teardown still called mlx5_del_flow_rules() with that
> value, which dereferenced it like a real mlx5_flow_handle and could
> crash.
> 
> Clear act_id_restore_rule to NULL in the error branch after
> esw_add_restore_rule() fails so teardown only sees NULL or a valid
> handle.
> 
> Call Trace:
>  ? page_fault+0x1e/0x30
>  ? mlx5_del_flow_rules+0x12/0x140 [mlx5_core]
>  mlx5e_tc_action_miss_mapping_put+0x49/0x50 [mlx5_core]
>  mlx5_tc_ct_delete_flow+0x4d/0x70 [mlx5_core]
>  mlx5_free_flow_attr_actions+0xd2/0x160 [mlx5_core]
>  mlx5e_tc_del_fdb_flow+0x15d/0x210 [mlx5_core]
>  mlx5e_flow_put+0x23/0x40 [mlx5_core]
>  __mlx5e_add_fdb_flow+0xf3/0x430 [mlx5_core]
>  mlx5e_tc_add_flow+0x2ab/0x9c0 [mlx5_core]
>  mlx5e_configure_flower+0x2f4/0x620 [mlx5_core]
>  tc_setup_cb_add+0xca/0x1e0
>  fl_hw_replace_filter+0x143/0x1e0 [cls_flower]
>  [...]
> 
> Fixes: dfa1e46d6093 ("net/mlx5e: TC, Fix using eswitch mapping in nic mode")
> Signed-off-by: Lama Kayal <lkayal@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

