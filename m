Return-Path: <linux-rdma+bounces-16798-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMBcB0VXjmnHBgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16798-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 23:42:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B831A131921
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 23:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E6EC30649ED
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 22:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6875335B130;
	Thu, 12 Feb 2026 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mx/PA7R2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366AE3375AE;
	Thu, 12 Feb 2026 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770936119; cv=fail; b=rnf2IIg0Mw2Doq+R5CDV5N9OVQar8IR+P5qgUbOZFLaotIzsakh9pCagc82ZtpJ0YTvDYNRCsJdw2eRrmRu41l6WWmftW3mr0SlEeVqGjzek/oa5khjGGDtDPDoLZ1T73ZByL2/oLZu9VQ4YGfNstKjA6kyjGwPAqPPz8RYcMgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770936119; c=relaxed/simple;
	bh=PoY0ZOC6aP6j6jCuNsRJE4CsPM7QUEu80jNX2h/byu8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WveLdE2p0QStaMvD3EmOhA5aaxJDWuApJeE2r7Jl+jrx6ju2olFt8sTUX7ll17QCN5GKX1CE28dJG0dZ32dT7nHtlksIQVFMDyYchMMs/uwgRjylSnM/Gk1tJjgzSwHvUeREYsOFjufVCJFmSp8TB1+10BowH6e2LRTVcLiXWpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mx/PA7R2; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770936117; x=1802472117;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PoY0ZOC6aP6j6jCuNsRJE4CsPM7QUEu80jNX2h/byu8=;
  b=mx/PA7R2625wrtPOw+ALmm54wHo8hNk1AVetrc3Qw9JPg++kwxZvKOLP
   RLSU37fbFl6U9SbXwgt5yRvObFvLlpnmj/xIZRcN2+tXbA0r8rXJY46cJ
   Ik/vH7zWW5DqEbRI2elCu39egx3r7lK23fx7LAjGP6HgKAN7r0JSRC/m1
   1U9/Mv3m5n7mtQeOuI6SZUqQ+Br80e+ebGURnBbJPyAUjISRkW0RfgAnK
   MqQ3fdaHoFi5WiO7pOw1CkoShsE9XwYth6zhjT9xmg/jN3EcgPJv2eMNE
   pwXRHL4zPjRCmscbVunhmj3FwOuyAsA3Hi90FMi3v2+gNllsurbtqiOYf
   A==;
X-CSE-ConnectionGUID: MywJsi5uTZ+JwiZ7ua43rQ==
X-CSE-MsgGUID: u2+9nrBEQoq0uOBJAuetXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75968867"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="75968867"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:41:57 -0800
X-CSE-ConnectionGUID: qtUsIAhbRG+C4hwpVVIP1A==
X-CSE-MsgGUID: ES5A4As3QHWEErgY4ou6XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="217279944"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:41:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 14:41:55 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 14:41:55 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.6) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 14:41:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYscfgLy2p0YLeXrtOtCw7s2m5tVybvBI6wKgs+30qh8AbkEbEgPLt63vyuFmpChRww5bQmyknNo5OfKuYR8C/PYdSJ7D7KqJwbNWUJXVo1Bp7Ds4aQv0JogKrfqJJ+9UE9HbzLkbY+wVF81EFv6Iui4dBeKbzgxlbKa1SJhSgGA6209Q9FNpWBEYVv7EY/LR7OtTxOHqjTkfvsILcf/ukLjGLapv9nlYMboaKUL2k8CVb3I/QY8cc4UAuR4yP2kSEYOtyiIJLg/0YywwXAejveIyfXEdJx5+7Htn6nxuSB2lXfC+yYzBKOdFaXqlF0CMmLYnxvXUo0ZnaA9ZzIaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nz5/3+xlq9tuUnvju+hUwnOfMm5OeSt1tjUmH64vyP4=;
 b=ZMfwVT6o9RvID1HtLTwtlJcHkYHxHf2Pe9P/3LBgP22bMifYpowc4DqMLYBmjeQ9v+jQBC1n8RJrEnD7PyMJ5OmdhJRI5Q2C9oLc7cG3sbJ1XqGIKSZrpWS2w+tENDCaD/by/9vPa+rlTfUpT/gcNajN/E3aWXzAonYWFZyogNa2vnkU7McFwXV0qRmRZKpE7rojjg0MnAfnPR+J59Noh2qppO+mM+sRaxhy5kaPUMmt6Y7LTv8pwKVtNdeX3qbZ5jyIPlb21oLKQ5Lvwil6ez05HaOAq60gproKKKttJPH0bafF9RBKFcgrHTcIIWMBGu6wAyH//g2CgkgxzuH0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7588.namprd11.prod.outlook.com (2603:10b6:510:28b::16)
 by MN0PR11MB6086.namprd11.prod.outlook.com (2603:10b6:208:3ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 22:41:46 +0000
Received: from PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3]) by PH0PR11MB7588.namprd11.prod.outlook.com
 ([fe80::42ad:6451:1ae2:edd3%5]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 22:41:42 +0000
Message-ID: <41b541a4-640d-4ada-99b7-5452dc81852c@intel.com>
Date: Thu, 12 Feb 2026 14:41:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 6/6] net/mlx5e: Use unsigned for
 mlx5e_get_max_num_channels
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260212103217.1752943-1-tariqt@nvidia.com>
 <20260212103217.1752943-7-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260212103217.1752943-7-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:303:b9::30) To PH0PR11MB7588.namprd11.prod.outlook.com
 (2603:10b6:510:28b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7588:EE_|MN0PR11MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: dffe92a6-2bc1-4b09-6fa6-08de6a87e486
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGtKOVBJU3dLaFNMK3lFbDNOSTU5VGJNSzJkRnlvNzRPbG9WYUtybmcxQXhC?=
 =?utf-8?B?UGJxdDlkQVZLb21oSk9RaGp6c293K3hYcWc5Lyt4ZS9Pc1pDNWxRR01UUmFD?=
 =?utf-8?B?Q2ZBaUcvWVlnaHlROHpzcmdMTWVrb3JqUWM0SGNRZ1A0SGt5V0hwVDdhVnpZ?=
 =?utf-8?B?T3VMbnJhME1iWjhyWng5RFBLdHZFdCttaXp3QU5aRzI5d1dxN3FxY09Ta0JK?=
 =?utf-8?B?ZkNkbEVSLzlLaDhzRFVucUVBekhjZFRLd1hXTXk1Y2YwQVRLanNxNUxUSGR6?=
 =?utf-8?B?NXhRekdDQkVmR0FJMCtqbFJhR2NQYkVjM3lHU0JERGtHU0RxcUdNYmtPYmdI?=
 =?utf-8?B?emRmY21jVHBhSmpDQ2phVFVSdU1tclNMNnZZTEYrdmNEU0ZIcUsyN3FiOVY4?=
 =?utf-8?B?cVhEaCtSQm92WU5WajRaNlVqQkUwSGV5blJ0MlFrUjcyTk1IT01VTUlDcklJ?=
 =?utf-8?B?bUxBLzNrZjNLV3Z6K0VtTVVheFd0alEzUko3aUFmVTJFanNVU1lrWHJleno3?=
 =?utf-8?B?WlpFdzVxT2tmSXdMbTZCcCtVUXNsbE9Qb2lUU2haV0c2T1U0MlBTRlBLNHBC?=
 =?utf-8?B?ak5RM2tQK1h4OENmaVoxcFY5ejN3ajZyRzcrTk5iQ1pPZnJ6ZDJmeDhZMDhW?=
 =?utf-8?B?Y0dSdm1hVVZPU3U4WjZuUC94ZGN1MDBjOFFPeEhhdnZpRWtDZE9KQmw0UHJJ?=
 =?utf-8?B?Q2pzSWhEWDdTcitCZEltenNhdS9VL0xmZ0VlZVo2aU9yRWpqWEtvazFhbGVB?=
 =?utf-8?B?SmsrR09wbXVETkpTd2hDNWJ0Rm1CaE1yNE1RZFViemQ3eUhhdzdvbXhwTnRZ?=
 =?utf-8?B?dGVwS0FIMHJWZEEwRUYvYXQ3c3hkMFJsMkljQk5RTThDNk5sU2tvTHlBMmth?=
 =?utf-8?B?czBjd2VkSnNacytGamxmQnJvL0IzYXMwNWd5WkF1WkhnOXBNalFCU0VCUFVY?=
 =?utf-8?B?eGI5OWhIYngrSlROdDB5V3NNd0hiTm1Hd3orMG1TbmJZQ3NIc1VrR21TdW5W?=
 =?utf-8?B?SUZIb2M2TWxvazYvQTNoK2x0QWZFSWNoT2hlQUZCVzEvSEtaTWswYlU3M1dK?=
 =?utf-8?B?Y0hBYmNZaWRtNk11bXd3V1czRStybWF1N1FIQ0FubXZDTjdXMnN2Q1pZaEFY?=
 =?utf-8?B?My9LZHlQTXVOaUNuaHhUQzVuK04yeFVxbHcvV0hTU1JCNk5Gc1RGSFR4R3dx?=
 =?utf-8?B?b1hIM0RILzI3UFBTREVoclE3TkN2QVVFenJiOC9OeGNNcGZMa2VuMHF5dEF3?=
 =?utf-8?B?NVJZWUtZN2o3OS9GeG5HSm9PR1Y2OHVyQ01JZnFQcnVaTDVITkVNUnI1dlB1?=
 =?utf-8?B?SFI0OW1USFFkeHpJd1ZDTmVnS3Q5U0xOMTJnMmp5ZWhIOGxVQU1DZU5jOVoz?=
 =?utf-8?B?eUN1K1l5aW83bmh1Q29ieFEySGtrOXNzTW42bUF5YlQrL1M1SDVhRnpET29R?=
 =?utf-8?B?WGE3TDdGMVJUOStWZmU4U0EyK0wrL2Q1RG9MK2dMTFkxNGJCSmYxYzlZZjA2?=
 =?utf-8?B?UzBMRFYrSnVrVDZHL2lYZ1YzVWRvVnJsZXdGZHdXWFhCNzZOaWQzRWhrdEM4?=
 =?utf-8?B?TU9WSVpQMDB3aFYxbFRLNXZzb3FscVl1Tkh2RWQwWSsyTXNGR1hBRUJaVTdu?=
 =?utf-8?B?K0JtOWRRdU5kMDhkb0Y5alVoVVRkQTdJVUtraXQvRU1xblN0aTJ5eFhSSEth?=
 =?utf-8?B?WUl1MFZrUFFVZUN0S0tZd3M3dUhWNXFQemZXODdBWXAwSGJya09QU0p2N2ph?=
 =?utf-8?B?RHdBNTc1Qk9ONERQVDFRMllDTS81UEFNT2tWajFYL2wyU2R4MUcxa2hyNHdo?=
 =?utf-8?B?bjg2ZWY1UEg2KzZnaXVSNERzTWZyQUV4cEtZVkhHYzVMWURpUEZJazFyamZP?=
 =?utf-8?B?TjRWNDROR0MvaXhCTG5KcU9Fc0tvQVlsbEpqKzNlLzZ0ZmhkNUIvRkNMRXFq?=
 =?utf-8?B?Slg2YStFU0RqYzUvdFp5Skdudmx2R2VaTElldldxaVU3dEh4WVkyNll5SWdq?=
 =?utf-8?B?NUVpZXFVVkhETjhlNHozN3RPQTVqaGF0b0d0ZnZUbWU3YzFVUHhwQ3lPMmN1?=
 =?utf-8?B?Y214K3lNYkxUdlZDWGkzZWd3T2tCUUo0RXNZYW1qYWhYNjZ0Tkt4aDZuMkIx?=
 =?utf-8?Q?BXJg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7588.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVFjaDlXOTUvbUVDc0YvOUJuRDg2OGxRTTVYWS9HRGI1NXlKdENHa1dkL0My?=
 =?utf-8?B?SmxNOExNeDhTbDZiUng1SDR3d2M1a203Nmd0K0ErcUtRTFIzdDJLRThiNXpN?=
 =?utf-8?B?TWtiSmM0SVp6My8rZHVLaWc4cS8xSWJYQ1h5Vjlpb3IvR2pQK2lCK0UvS3Zu?=
 =?utf-8?B?QVU1SVVCVGFQMWJsNDZPRjdjeWhkTWVqLzh4azE3aG1kSERuaG1OZjMxU2lk?=
 =?utf-8?B?MVR6ZnBJSjVKZDVxZVBMT3dYWmhHSzByTG9tbmZkUy90eFgrYXZLVU1NLzFm?=
 =?utf-8?B?UGVQbmIvOFNkdDRzV2FOa0RDUEsza1ZGTkpDZjErQ29Zc1RJelF5ekcrTTVQ?=
 =?utf-8?B?ZXptMXVrcmhGUmdKQmVVdXpkcjlGOTRmRS9JRktxcEhiVEQ2UzVabGpxeGNJ?=
 =?utf-8?B?U2YwQWdOd1BkVjFkbmRBUDc5MzNuT1MwZXBHdEpNVlllMEQzamUyWFpYdmZF?=
 =?utf-8?B?ak4xRlMxU2Erc1RMcmdtbkFKZmRQYWlqeFdkdGRGSlk5dWVockxVZk84K0ly?=
 =?utf-8?B?eDdwUW91aVBGTkNCeGR5U0MvY1ZQY2xVaWh5Z01xWUhxbXVnS3pGZklUU0FI?=
 =?utf-8?B?R2VjanQ1ZmxBTmY3ZVpQWmxpQWlyNDM3MkY5MU5EbVJKWTBya2JHRHJTQ1BS?=
 =?utf-8?B?dHJlZmY3MFV0amEycG9nZnVUVk55UmE1bG00bXpRZTVjUDNHbFBod0s5RG8v?=
 =?utf-8?B?T3FRMTBqWFJoaHBPWm5BdzFmZmZ5c203cmNVeWF1Z2pBODVtdWdvQk1ZWHBv?=
 =?utf-8?B?WHFQUVNLQmNsMXlwV3hNYUZTZzlWVGxvM012MTgvWHdYS3pkOEZEK1Jpa0Z0?=
 =?utf-8?B?ei8rZFE1bGIxbE9vV1MraVFob090NU5xSndSNURRMGpVeU1EcDdPREZoOUNY?=
 =?utf-8?B?aUxrL29JQWRqY3Zjc1lKWHFPM1gvQkpwUWQyZGVZWVNaQ2VydU5LNExxWXFy?=
 =?utf-8?B?MG5adnVReFV5UCsxc1ZRelpnaVFNbTA5TjZJdXhrOHVTdFprZVNycFRCaDh6?=
 =?utf-8?B?THFucm5QRTJQVVV2L3pUYlRNNVNIbzA0cVF2NmY0a0tvVFdyb1hZd09NaXVz?=
 =?utf-8?B?YnEyMURQUTFjRWxLRHZkblR1eG45dXdRa3NQZSs0Z3RjY05TeTAvakIwdlh0?=
 =?utf-8?B?RUhQeTlVOEV4S0pFaEMwMTVwK015T2J1cFdUMklYSG1sM3VqT1lINkYvZVp1?=
 =?utf-8?B?WW5uNGtFcHRHMi8yS1VKbTc2aHZCUlJSV3ZqOEVyeWlPNE5QZTd1cnpEMWFD?=
 =?utf-8?B?T3ExZUtLYmlHRWZzY2VMWmdpMWo3bTdVV2tLU0hLYnNJb0NxUVd6bE0vL3BR?=
 =?utf-8?B?OTdIdFVCRkZONW5tK1RFdTVQaUVzcUFHbGhUcXVFZ2JVMDJ4OXBKWEFZMUFD?=
 =?utf-8?B?QlhheXdoSXVhd2JPQUpWUDlkeG85N05pSDZycVNMK1F4dG8yRGk5UUxpMmVT?=
 =?utf-8?B?L2p6Z0NRZTlMV2NiU2JvVVBWVmExbjVyRGhxUXpmN0pFUE14TVdKUzA3Z2hu?=
 =?utf-8?B?YWlJVlNoMzk4REQ1Z2NoZFdYL0tYNEtwUXZFekNPczY0cHhjdHpHTGJWMjVz?=
 =?utf-8?B?RVNjOVE3UEhkbUZ1ZHFaUTNhQ3BlVWVRVEtJZytOZ3NHaGQ3ZHg5RDdhc3lq?=
 =?utf-8?B?UThSWEZpRENuc3FIejU3Y012eC9vOHhYRVJnUzl0M05abGFKa2UxOU5kS3lD?=
 =?utf-8?B?RDJYQjdYdDJiTklNTzI1dVd5ZURKL2FjVGpsOVFCMlVUdWREMnNPZm16TTM0?=
 =?utf-8?B?ZTBaNXU5eVRibHQxZjlVOG04aDgreE1BUk1xaFhXanRlbnV2ckRnckJMK1pQ?=
 =?utf-8?B?NWNxRjFLVnFKdjN5VzAzV1RIN1RzLzVPSlFLUEVxeWRPa0c2MkVoSENqeHlB?=
 =?utf-8?B?aU9ZSHRBMlM3QXlaMjE5SC9wYklDcE83UFRLYmV1L0lMSDk5MjI1aEVDaW9a?=
 =?utf-8?B?VWxndFpzeTVyRFpiVkF2V0xSSEZKZXpYZm9GblYyc2lmVUlZYUhWV3dnTEdn?=
 =?utf-8?B?UnowWGdwZHZ4cFBKREYvSzJReHA1blVaMFZyOVlvNDEwbmU3V1E1d3d0eTQ0?=
 =?utf-8?B?Zkc0c3RpVVRPZmtkTlYxZXdCSkZkdXlXTE1QNHc1QnZpQWxtUndQN05UMTZi?=
 =?utf-8?B?eU5pbld1cytwMXVsQUZ2THFURUZacnQvbDRpdVhnNEYzNkdHYmVCM0pMQ2V1?=
 =?utf-8?B?elV0NDM0MXpBQVdUZ3hyNm5MYjFkcFV0ck9aV00zd2NaTjFBQVVUVzEzcTky?=
 =?utf-8?B?ZFNmNmdMR1M4WUlWUW8wMDF5cUsxMVRBQ2NYZ0F3WDNSWEV6VmlTVXNubGN3?=
 =?utf-8?B?cWNSbkYrMDUrbUcwWXNKL2tUM2Y2eG02TzhidnlHeXlFZ3I0bzVYZ2dlL2la?=
 =?utf-8?Q?XHFCS+ezvUY/SW88=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dffe92a6-2bc1-4b09-6fa6-08de6a87e486
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7588.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 22:41:42.1983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxcojAGCl1kRa6kJ8dVpGT+WRfQpX+abs+EoqOQb0hXyRzgEKxenYja/XSRd/q5X5wCDoINUzjGm3wtncjKXXTq8v8JmAIWQM6c8bhpuZdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6086
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16798-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B831A131921
X-Rspamd-Action: no action



On 2/12/2026 2:32 AM, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> The max number of channels is always an unsigned int, use the correct
> type to fix compilation errors done with strict type checking, e.g.:
> 
> error: call to ‘__compiletime_assert_1110’ declared with attribute
>    error: min(mlx5e_get_devlink_param_num_doorbells(mdev),
>    mlx5e_get_max_num_channels(mdev)) signedness error
> 

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

