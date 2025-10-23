Return-Path: <linux-rdma+bounces-14029-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B165C020F5
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 17:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C838618953E8
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C21337BB5;
	Thu, 23 Oct 2025 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IzF6tikp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328A30CD8A;
	Thu, 23 Oct 2025 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232703; cv=fail; b=oxDYoccNWej+XlfNbjDjFZJpTSDfprjr0ckKFsO7AprIo5RFs8AfyDAtWZ9dCiB28SFvnjd9NyF6oRpcnsKLrDUoGVTFTw0qq/zyJyB+DeZj6f0g+u1BUI7u/EdYxRuWf9zqo0GWueH9mTHakV07OmGyD6XDUN2TXYMQp/9hGh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232703; c=relaxed/simple;
	bh=GW84WklPHpPfZJTLpbGX/dHXTduYHdinox3KDzh7MMc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hhsXy3hHvEbVGupFCUm/sItAJtl6HYOdx/GDG7nEc6FuWp/fpIyzdDQklaTLHTWcEMKwUHMERNLS9A0nhQW1ARKBF4Ki8YFoJ2u/fyHEwD/9DUGxLa/C7/RzL8ywlzE08mQ7Yz9N+CV0qhkg3QqIuN2FkigCr1HJdUEFs8ZN4bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IzF6tikp; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761232703; x=1792768703;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GW84WklPHpPfZJTLpbGX/dHXTduYHdinox3KDzh7MMc=;
  b=IzF6tikpJ4kvLY8FqPHF8+K8TUZ8Cu586q03c3LdXzlql8HKjvGVPKI7
   kRP/szAiK+1jLtP7R/ZAxlVgkr0KV5YN9GfB44WR387XeQMVNCMIzE8nT
   ofir/ymsw7mnWTTFsBc+TYvIntTClMKF8uNGGxz72rdembjGwXGb3xcPD
   1/MBAasVqzJ6VJ8Ha3kG2XfC+O28aahA8MMzZucJcXewRqy07EifYtzVS
   lP1fkxEWoFhKz69He3LnN+dpbv7XsBdT4NcSW4K1zY4ZU6qE06Fw/A8Bi
   tzVQa6rKXHCRUkPtRO2leAH8tKzj4Y3FTHFlSiLUEXxMUEKgGFmVoBPgU
   w==;
X-CSE-ConnectionGUID: lC/lQT8RTim7xbGkJoSrDg==
X-CSE-MsgGUID: 5IQgEK9hTpCtVCzEY6bxIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74843297"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="74843297"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 08:18:22 -0700
X-CSE-ConnectionGUID: qIJLucqwS7yTZMPTUXq3jA==
X-CSE-MsgGUID: XMbGy6lXSr6qFw4efDyruw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="188578681"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 08:18:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 08:18:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 08:18:20 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 08:18:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAEvoyi64PDUetWxlUV6OsrBzSf9alVaqo19hCEoPBu0ILxrLARvyv7higepASZJu00Wt9JGpZoaxBwyPTkgxXpa9o+f07AK+NUWI0nTNAyMoZyAvBZEpT6BgyS4KTPb7SjAdVWJ1DyqpOZJU6UJGih75gw7zHMhR6BT6Sj31bAtMkvXsitBA4c/BgvjIlKHtfuHRDdHj+5HXJB8WaAzhovWaNEVszDf0mI4zOYTuld7tHiu6PhHBKl2egpj2OD7AYWe7THfjxrDPsP8JjCw4vcBfMK+1wISxNSUekeKL4GfrVnzOGy+3Ge7SZ4HMe2QIdCf0VnFsFrDAQmBBo4ITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQdrR5msjUP/V1bDKdGxwYUL/BwFYwE6y8r4tkAEKEU=;
 b=hBlj3Qh6PVTtL1w2bYvQQ5+N6dU4mdHm1ewgpxtQiZIpQubuZMOXYUGYx3J1WzEpxEHng1Rxn5LtmUMZu+fFKwTplHGai+3JDj5+EbfYO6cb6TSpiPIqe5QD+31BTsvboWZ69qTMSVDPO39L2ZoZ+EaQGN6J933zMz/xspe9DcRBXadhv08m8Ntbn0OIlaX9akgaKhQ9rl6enu+WWK1bZaW7uuEytHwSMwnDP3k3MlfcldORMTfpDju8b0RSd4SjQCzvfFKFCApn+wxyaNxTX3mlZ+QtHDfzehlB9SzEX4fMwTdSslpa76ZdQH1YtUblqKsJFYg1Q9TdbvMApr2XTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA1PR11MB6492.namprd11.prod.outlook.com (2603:10b6:208:3a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 15:18:16 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 15:18:16 +0000
Message-ID: <00eb725b-1e0a-47ec-9352-72c2623f6ab9@intel.com>
Date: Thu, 23 Oct 2025 17:18:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] dibs: Use subsys_initcall()
To: Alexandra Winter <wintera@linux.ibm.com>
CC: Julian Ruess <julianr@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
	<wenjia@linux.ibm.com>, David Miller <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Mahanta Jambigi
	<mjambigi@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu
	<guwen@linux.alibaba.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-s390@vger.kernel.org>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
References: <20251023150636.3995476-1-wintera@linux.ibm.com>
 <20251023150636.3995476-2-wintera@linux.ibm.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20251023150636.3995476-2-wintera@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB3PR08CA0018.eurprd08.prod.outlook.com (2603:10a6:8::31)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA1PR11MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a4c3cb-0dbe-42b2-9d23-08de124763e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVdNczVYTDRXR0w5WXlCa0NWcldBVUIyR255Z1F4TGFHRXRuM1ZMZ1JlTFBi?=
 =?utf-8?B?TlhSODNVWllXem1pOWVuTk1Zci85UTNVVytza0I0L0p2YWQ4QlROTGUxcmNW?=
 =?utf-8?B?VENDWWJSTzdKeEJiNnBWWGJUMkJHWnNNbmZqdjh6aUNMVEZrSC9yL05NMlJt?=
 =?utf-8?B?dHBkSkgwSVJzUTM2RmRhOStZTlJIRlM1MEZ4RXBBYjM3VzBqMC91WVhpUlpj?=
 =?utf-8?B?NUFyNTlOaUpSTmIyVk91YVZqOWtDMG9ibHR6cTN0SWw3Z25sT0hkQS9IWE5V?=
 =?utf-8?B?d2wwbW1ob1o2VkoxWGM4dGFqZEE3OEZyZ3lwMDBSWWtwWXUvdDRvdHhkL0M4?=
 =?utf-8?B?cjZjaWV4WFo4TFlTYnhLR0k1SHNOOUhZZEJkZG9xdVJPVUNEWEVwMVpTVTJY?=
 =?utf-8?B?cUxNcGNTdjhOdmt4VHR6WE03WEc4K2ZUWEhvNkNyeHgwRCszQkVuRjIrSFAr?=
 =?utf-8?B?U1pwekRFTW1PYUpqR0lzc1VJQTRSWFBhcjl3S1VPa0hVMXJ3WVJRT3Ntd1d4?=
 =?utf-8?B?SnByMkM4cUU5c3FLZWp4dEVqTXpVdnF4T1NoVGJWcTVsOW9oLy96MTFTRlZl?=
 =?utf-8?B?NUpwTEVOcm43S3BoZzJPVHo0MGFUczVaNDlFQTFyWWdqc0tYSVY2c3Fmendk?=
 =?utf-8?B?Wms3SXB0OFRVNzRoZmpnRy81MHg1R1cwTEFhZzYxYzJzR2ViY1N5cWYyQlhn?=
 =?utf-8?B?bFFPdGVJUmxGbUlUa3BQREdsRmpxVXRnQjdsS2xsalB6WTM0aVF6QUhLL0Nx?=
 =?utf-8?B?WXNvb3dCZmxESDBkSkF1bUZLaU83L1ZiMUpHeVluYlk2YVRlRmxObmNTc0ly?=
 =?utf-8?B?azRlbHZPU3VBWDZWazkrOW1zOS9hOXpBNURGb3ZES09GeGFVYm1JUnVvL3c0?=
 =?utf-8?B?Y2xPcmIwMHZ2MXZmTzF1bGJjTFlGNWxpUHQvZ3ZCNjNEa3ZLa3R0WEhmbUhr?=
 =?utf-8?B?YWdEZFFBZUxBNkRaYUJHanhjRzU1RGp6YXhqYnZ0SHJ3cEx0VzVyMW0reFpu?=
 =?utf-8?B?TGsrcnhxK3l2empJdFVEQWpkaEtpaElkNmxTSXY1b0dXMzA4NEIrYkFXYkJ1?=
 =?utf-8?B?elliWEtXcFB4SndqUytFUXQ5NUlwYjl6Q0JkMnFPSlVhNUFGakVwL2F1WVNs?=
 =?utf-8?B?ei9UOXBaWktsN25pQVpRNHZXTEYxcTBRdlJZWCtKZVNMb3hiM1VRMzVYRGpx?=
 =?utf-8?B?QjBYWm40N2I5SXhkbVhMYUZHRzlyUDRIZnlaNitIZTZPSExoOUpYRE5GYVdK?=
 =?utf-8?B?cUlzSjBLdnhOTzg0R2hlcHZWL3BzNmFIUmRYaERXNHltL1NNcE9NZzlVUnpW?=
 =?utf-8?B?K2pQM3NhRkV1WWNXNGtJNS9MRFovSVYxMXZWbVpIVVBldmNlSk56MUNaYXg4?=
 =?utf-8?B?bDltdWFjMWdHdU5NOGt3bU51d3BGUG83WExuVSt4MkdzbGtKRWFqNE9YMlJ6?=
 =?utf-8?B?SXExSVh4akdRRlo0dUIzdUM5RXh2bnoxMlZ0dDNpZnRZaGMwNVZHMDlEd0VF?=
 =?utf-8?B?cmlEL3I5OW04OXhBbisyUEUxMWJGY09JanEwS0JZdUQrQTRGVmx0V0R1Vkcy?=
 =?utf-8?B?RExVM1pPZ3BrWUJPS09GKzJ5VVJ2ZUxlczFUUUxTYkt0K1pIZGEyMjUxcnI2?=
 =?utf-8?B?Nzc5QlZnVlJTRmFoajZaS1RhV2xOWU40OWxzTzZCVlhzWDVYMkFrSE5OaW9w?=
 =?utf-8?B?Ny9hRUlXUUVRaDNUNm5vQlRIVmFDaFZCbC9yVFFmTmRXL3I0SHFXbXhMbmR5?=
 =?utf-8?B?bFJLWVRBdFI3dzh6Q2pwaUNLcGk1Y2x2SGEwNk1JT2srZEJ0S1ZoL2JzeEpj?=
 =?utf-8?B?aklqZmR1OGpxdW9ycDVsYmhGYmIwZDBaN1d5UHF1OU9GeVNPK1c1ZG9ZcHU5?=
 =?utf-8?B?S2pmNUhRVUZWNFplVlV2VjVSZjRseTk1UVNtMFZzODBibTlwbkxhdDU0VGpB?=
 =?utf-8?Q?E04infHWDXO2El4wELUoq0b8WEL54QKA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEJHb1JDVE1ObTNaT2FyOTdJMWNqNkVJb3FYakk3YWxKQWE3RzhhS2V2QVFj?=
 =?utf-8?B?cUZTV240eEh2UDZaNWx5ZStybFd1bmlmeHBPRkIremFzR1dtV2Q4TW1lQ2ZX?=
 =?utf-8?B?VktKTXF4bm8zMlVXSDIwb1hMS3dDSW50TTA3ekxUbUpqYkFDTzZROVFGQTM5?=
 =?utf-8?B?SU5odHJaVVBDVXFjbHZ1UUdSQWVNWXFuQ2VOR2lxejFreDJ3YjVnZFh3QUZx?=
 =?utf-8?B?UkM3TTZrVGZPOWpsdFJuTUY2cHlmZGtCb2JSbTVyYlE2VUhGRzBpUFdESVF4?=
 =?utf-8?B?MW5RR2x6cGRtK2Nud3Z6N3VQV09iOEI1OEU5WG11NVZQL2dDREhVMDhGYnQw?=
 =?utf-8?B?TzFrZllGa2JLNzI1L3hWNStDL25BZHhwRDdsaEMySUFtcXZGcmRBMndZRDlF?=
 =?utf-8?B?alFqNERZTXI3eXBuRUh5QSs3U00yRzNFUXlYNGNia1MwOWxBSUNYWjdLelpM?=
 =?utf-8?B?N0JtZ1ZkYjZvMG1VU3p1R2xZWmJCOWZ5eWRROXVqYzlFenJYYTNRbnpLcXp3?=
 =?utf-8?B?ZlYwYnV4bE0vZzZqVDFGTXpuQ3VHWnc5elhMN1FFbnAvNkhackhsNklFd3Rx?=
 =?utf-8?B?Z1hyOHF3a0VkVWZDZnVpUzNKSHFRbWczekJJdEpTdGZUeUc0dTFDTDNHaXA0?=
 =?utf-8?B?R1REcUI2MEVYb29vd3dyRkIxU1BzSUlDNnNhZDcyVkhFUkdMMjBhTHk4Z1pp?=
 =?utf-8?B?WC9SU3RYV05EcmY3N0VZdVVEOUZkUzhuK3B4aStmMmtDbkg0V1lleUNwUjhU?=
 =?utf-8?B?WkpoQ1lpNUM2M2xJcTZBRmpHbnlJb3huQ3lZSGFTQ1RFTGNtR1NTOFZPaGty?=
 =?utf-8?B?WWVtZVNBcGZKbEhYa2EwcUUrUFBpSVBueFJZMnZQZnFFVWZXbmorQU83TG1Z?=
 =?utf-8?B?WmhIYVhrbTg0VW5NRHExUnpHVVlxY0djclp4U0hlbkNVOC95MklIQzNWSHRF?=
 =?utf-8?B?cENSSFNEWlE4M1FUUk9BUTgyODFEZFl0WE5XejM1U2J5bDhvRm9ldDhuSTFG?=
 =?utf-8?B?SVR0NWpTbWpOMVNQT1VFMkZVblVBbUQxT0ZGMEZCNWFuZDZzZ0l5akN4K1l0?=
 =?utf-8?B?aENoVURMdTF1RjUvWVdsWGpmdWVxWlZyczl6cEZ6Szl1akpReUN0dkdJRkww?=
 =?utf-8?B?a0kwc0p4UHdCUm83bWNuZ1pybExLNnppU2ZQOE1US1JMdzR1dHF6aWp6WGox?=
 =?utf-8?B?STVoYkt6czFZRjRneUNMWmNtRWNUR2xSZGVYWVJha0FWRHZKMjFyOStQSDFT?=
 =?utf-8?B?ZHBzOFNoU2I2M3N5M0g3ZkhFdERDSzBEMmIyK1R3M3pPRGZBYlkrRnBMTVNU?=
 =?utf-8?B?cmlDMldVQnZPNDZaRG9oQkJmRlhxcFRTbHczakJtYU1kV1JqQUd1cGdNZ2RT?=
 =?utf-8?B?WTVkR1JzZ0I3NHluWlZIZnNTeFBZSklFUEhnd1Yzc25zU3RRaHNxRUpOUlVa?=
 =?utf-8?B?cVdOYXROTGhlS2JzZnMwYm4zS3RQN3YwT3drL0xIWnl2ckxhQ2tqbDIzQ3NF?=
 =?utf-8?B?SE53OEpNZUk3eWx1TndvQ011cnZLL1ZsTHVXOHRVbG5sZElqcUJWQitwUENK?=
 =?utf-8?B?UEdqVnFScUNHYUpwQUhoT014SXFPZEhnQUpFSzNKNHF4OXl2QUQ4UVNmL0x1?=
 =?utf-8?B?VE92d3VmYjdRQjN6UFFiL2M4ckw3YlptcnF4UUhlQjNsMmxOQ2YrSmdWWGpR?=
 =?utf-8?B?ajBzSjM0QVRvOE5vZG1IdFJrWWE2YllPNHh2VmRqSlRENmdBQ2dTb0FsblZs?=
 =?utf-8?B?Z24rUVN0Sml1WDc0THEvZXRlbjR2RVVQTHhHenpGMlRDT2RONnA2czlsYk9H?=
 =?utf-8?B?ZXJKMXJNOHk0OVdMeWZNU21UNHZhL0o0eDFFSS9PSndHQVJpeTZncTR1dm5T?=
 =?utf-8?B?NkFtZmNDZHpyUlBrSlRFZXNleFpzaVZYcFRDL3FPNThlZU82WWN1VjkxaHNG?=
 =?utf-8?B?RWhXdUpwejRKenRLZ1hscml3K2w2eEtIeG04K0hLZkQyVytNa2hXVXNRbExi?=
 =?utf-8?B?MThHbUlIWGxMczFobGFnTmZmVzRoNDNYWTFTYlgwSWJyVGpaR09XdEtYWlVi?=
 =?utf-8?B?NmEwczVNKzlXUlhEbTl5aHZVR1dPTkhFRmxtOGhvcGd5RXhRVkZhVytCNi8z?=
 =?utf-8?B?SHlOdHJJWWpmUE8wam41WWEzMEIzeTNVeWI5MmozZVloRUdUOVhkbVdEbjZH?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a4c3cb-0dbe-42b2-9d23-08de124763e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 15:18:16.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewm+kZpjdRy0E4Uu1QaRjXS0t4+bU4HG/9LBroCF6W+GKR/TyteN7RpAubjWS2KKl7xgRW4sKzZeb21JeLIznjdnnWwfpIrKZaDSai0QPzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6492
X-OriginatorOrg: intel.com

From: Alexandra Winter <wintera@linux.ibm.com>
Date: Thu, 23 Oct 2025 17:06:36 +0200

> In the case of built-in modules, the order of module_init() calls are
> derived from the Makefiles.
> 
> Use subsys_initcall() for the dibs module, to make sure dibs_init() is
> executed before dibs clients like smc and dibs devices like ism are
> initialized. So future dibs client or dibs device modules can use
> module_init() without the risk of getting the order in the Makefiles wrong.
> 
> Reported-by: Mete Durlu <meted@linux.ibm.com>

Was this reported on LKML, so that you could add a 'Closes:' tag with
the link here or the report was internal?

> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Either way,

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  drivers/dibs/dibs_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
> index b015578b4d2e..dac14d843af7 100644
> --- a/drivers/dibs/dibs_main.c
> +++ b/drivers/dibs/dibs_main.c
> @@ -271,5 +271,5 @@ static void __exit dibs_exit(void)
>  	class_destroy(dibs_class);
>  }
>  
> -module_init(dibs_init);
> +subsys_initcall(dibs_init);
>  module_exit(dibs_exit);

Thanks,
Olek

