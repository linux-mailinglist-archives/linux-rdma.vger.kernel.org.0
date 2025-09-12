Return-Path: <linux-rdma+bounces-13310-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C0AB54AAA
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 13:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A7C1C28057
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBC22FF64C;
	Fri, 12 Sep 2025 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqy7BlXI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896462D660B;
	Fri, 12 Sep 2025 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675284; cv=fail; b=L4P2Yf94ej0PFycHWwi7TZGLng+HZb1ajOghOELZro2Ga2exmPewe5GMkfk6jg8ZbfNHD3t6GeeLDaFSQALb76ZxuwOHIog8imt+vuqAPwl6xvuDIwnFVqLJPXY/ZVJ0tcj3qxghgocFSBqlMYO4POgmOfsiNfHFx7oXqMlx/1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675284; c=relaxed/simple;
	bh=eO6Y+YLMC9ngwhItQAvYRct2jbb3lwHi7GYGjhqB62Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f1w8b8MtR1idonwqJ6X43k14I7KwX7WF/ezUsEBI+KPPwf+XBv7ib774Z6+fcfGTpcfjrofTa3B9u0J5CRxgg0PG2kfgNCAY0DVbvYmLzTm1r8/MMILH1/NpRCS/s4BhTDv9g6SOoDqQwnhZIz48puVbXnUX0kOvHsIARy8aWs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqy7BlXI; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757675282; x=1789211282;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eO6Y+YLMC9ngwhItQAvYRct2jbb3lwHi7GYGjhqB62Q=;
  b=nqy7BlXIOpPDIi2qvKQ6T/5PLzffgOBKPk3bxoAefW8sZZQabv9leeHO
   8FRzezZvJJO1+RWE/TXLKE/tuDUoJk5j6Jh505ZEuwFYt5goBGWBHXR91
   B7fA9SosK0hdrTIcLuSeYuwueRVoNTVAQ5QIKHj5Ne6hbijcBOwcWAF47
   27QD/oEHSGhUiRy1lU249716zsSAKTToYAbDS6/gMzJu2GTHGxYdXvzyh
   LDxiyph2loWdtil2e74o1jb6903vgVL7Csb1jYjwhVa4BlJoOUozPlZmm
   6b2CKgl+sIZe4tJUHBqqDvxpzErf3bG3T6mXEwCojX/d9yg4O2rx/MdnM
   w==;
X-CSE-ConnectionGUID: FRteJmeZRlqI4oIjKxl+xw==
X-CSE-MsgGUID: ok3Ymwl3RsuFwbxp4uKBfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59717540"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="59717540"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 04:08:02 -0700
X-CSE-ConnectionGUID: 6Jdqfu/8TgaLC5bE/s0lvQ==
X-CSE-MsgGUID: j9A0P9h8TuK00AVrfAIcxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="204937477"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 04:08:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 04:08:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 04:08:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.83)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 04:08:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDTGcN70Y7VOEHMWtudOrI1hj1ex+RP14cX9XsNthJn0973Y10pfn327fOESaY8mp6wokZSV1uRr8oMrNyRK8SIV6SdCmp1S8SDf341041OGNKD9A79xx1qwzgxNqrvtATDXhLb3R2MmJqy8RFvG18UWNZJ5KYKcTEyahRpy7QGQb5Lf+9mbCCH0TWGQZg4mAdAaNqIMJCBtM/f0dJXdxvNefJIOVToAvfzZVRvxCeMcnQYyZcfWOKm8fpmqHLmB03SPQTET9zkPko19Tv1W+tPOY8439rRdqoaGe8K3jrTrXjt6DLImmjBvjX/8v7EyGtRrh+zGCX5xRP5J5hs4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6vc/DEAXpxzmdMvzdZw691HGolbAjdLKpEUWS0fakc=;
 b=lAljpF3+FVeLt3LNXQ1YzepxPKpfO+WTRkPTLmp6geRkBxpALLt2R3OrvpsLTuffeFBlLX9XXS+6uUQY97Yjlq1e4OFTV9dh6sVjCeg0OGzQvBilbtw7YNu3SEo1Muwtf9RzwrQ0txXc2e2m8GoZuec9Vs3S0G7TeZ4YnkRPJHT1IDjWhOdfOl9hs6IYx4FLtL74ktPt3BUdDSGbkmAk43+UzUqshCA89d5rBV9aH/p2PQ852sJl8HjGjo16CtSkzJPrpZwCW7RsSt8nnqm6C7PtHbAEDdr6l7cQfEEzEjIA4Tz6Pd2S9cYFjhzdG4AwRjmlg614svyHfGbWSdrtgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW4PR11MB8292.namprd11.prod.outlook.com (2603:10b6:303:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 11:07:58 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 11:07:57 +0000
Message-ID: <dbabdfb6-e6cc-40a4-97ee-fcfd29371e8e@intel.com>
Date: Fri, 12 Sep 2025 13:07:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net/mlx5e: Harden uplink netdev access against
 device unbind
To: Jianbo Liu <jianbol@nvidia.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jakub Kicinski
	<kuba@kernel.org>
References: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
 <1757326026-536849-2-git-send-email-tariqt@nvidia.com>
 <20250909182350.3ab98b64@kernel.org>
 <cc776b20-7fc0-4889-be27-29d6fcb3d3ad@nvidia.com>
 <20250910174519.2ec85ac2@kernel.org>
 <9bbac284-48b8-4377-85f9-9dd3c60410cf@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <9bbac284-48b8-4377-85f9-9dd3c60410cf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0328.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::13) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW4PR11MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: c37922b8-0da5-475c-b545-08ddf1eca0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGJtbGhPWmUwcHRvaWRpamc5aHp6L0V4RHFMVHo0aDRpdi9rK0g0QTdSK21q?=
 =?utf-8?B?UFZ1WG91bVp3bUgveFRUTHZzWWt1LzRVNnpiNG1LU1BENmc0Q1duUXNrKzR3?=
 =?utf-8?B?aDJTT2M2RDRMMW9MeER5ZGJEd1dGb0lqYVg0U3BTV3VGcGhYRjAzM1RvMmJT?=
 =?utf-8?B?RjFpT3Z4RUg5eGtyaHVXTXk4NFVYNTFmcHdXbEowUTI0d0x3MnJYc1ltR1lF?=
 =?utf-8?B?NmpMSUdLZW4wRVRCbUxJYkFsNGt0V1BFZVVwUEpKRTFoOWpZaGYzUmpkK2Zt?=
 =?utf-8?B?Vzc2aFZGZ0ZDbzV2QVRESld4eWdXRExFZ0JZUDI3T3EyY0RTMDBEQWd2UThC?=
 =?utf-8?B?RUpXSE9hRDVnMDk0TnhQWU1rT2dTWnRyeFhWQStqWi95OEQ1bXhvUTlMZFho?=
 =?utf-8?B?Y1FXdVIzN1pTbU1OakZGTytBRlhRSHNDdyt6cWxrSjQxSC9GMEtINHgyWm9R?=
 =?utf-8?B?VjhDS3RiUHBCamRBZ3VzT0lZV0ZtS0prRmQ5SnJGcnJlM2VKZi9GSlFTYzdX?=
 =?utf-8?B?UDN6MU9ramF3cnVIMktFbVVta2NQUmtNOVo3WHZ4VUxMRUtpM0FiRmtKQXE4?=
 =?utf-8?B?Ym9VWVlSc2JiNFVDRU9jMFgxNGM5VC9peXBQd0R1aFA4VStwWDVLd04xWUp2?=
 =?utf-8?B?RVE2Z3RXSjNjVytxQ1hrcDAvNzZBdXNSUStycWsyQndZVU9YQUxKak5EVlJT?=
 =?utf-8?B?ZFVDSFlianhTTnF2dC93Rml6NG5DZk9oUjI2bFFWYkZiT2VXMG1rZWVwc013?=
 =?utf-8?B?d3BXOGlFazlHQ2ppRUgzODg1WU44THNOZmJac3FIbjZwb3RmbjZyaHY0NnBn?=
 =?utf-8?B?RzI5YkVnK1FsZ1BEQUpRNzNsM0VoN1ZUcVBUQ0NoSzBnVjNnVFpQV2dYRWM3?=
 =?utf-8?B?YlUvMVgweHZKSDBmVGhNSExDd0g3RkhwMGo0Ny8yZWZLOUdtSmJ0Qk13bkpT?=
 =?utf-8?B?Nk9EZGQyTHQ3dVp0RnlVVmJKZWFEem1nR042N21EbEFjSDByUmp3Z0E3WXla?=
 =?utf-8?B?eCtRWHFKWWpwais2dHpDSHVSNVh2OTBia2FwOEkxZTJPMnBCQU52eEVPRFBD?=
 =?utf-8?B?eStScFF1UFN0YVg4ejdqRGxmcnFpZ3NIN1NtMjYrbUpzMzhHM0F4REFvYWdx?=
 =?utf-8?B?dE5VblVIdHRkYjc3Ry9xNnUvNHVwRHp2Kzc1ZG43YkFkZzZ3ZFYzL1laQm9N?=
 =?utf-8?B?cGQ0d2Y4KzVpR0FKTTV2V3NCYU0rNEtRbFcrL2hvSms0ckZibEJLVTFERVVR?=
 =?utf-8?B?cUxoNGUvbHVwUnloVFZGaFpRY05mM1JPMTBvcVJ4K1lYWGVsdHNNVXljNTNr?=
 =?utf-8?B?bWZSY3pzTU05ZldtWE1DNERhaWFvUWpaak9LeUZUNHNkWDN0NGlkZTZXTys4?=
 =?utf-8?B?T0JHelpIdEthWjZ0YjA5a0liMGt4QldYYXdSeVFpSml0ZEtWY3d6M2dBZCty?=
 =?utf-8?B?TWlZNCtqQWwwczNoV0F4MndHV0wxQjhrZ0E1K090Zm50aVdYZzkyYUxsdmlq?=
 =?utf-8?B?S2ZvOEI2eWFRTXo0YmRTY2JtSy9ERmtLVktuTVV5d2RDM3lGR1FRNHEvNW5W?=
 =?utf-8?B?b2ZjaDBrVitkL2ZuVktiKy9aYUVTU1plclRIT1NCZ3htdnZOWldleVNLZXJY?=
 =?utf-8?B?aHBOMUZ6dG83WW1td0IwUzdta2pBSnNoaktrNHNXOFJxMG1Qdmp2LzVndmpC?=
 =?utf-8?B?Q3NhU3lWdlhvcjdHWmhGbi9XSzdQbHhQbmlkS01aRWltaXY1ZUdvNGZuSzA4?=
 =?utf-8?B?MDBSUEVmNW1YMHdnb0FsVkNFK3A4S096d1NiYVlPOGlicFZ2elg3WTdVcmc1?=
 =?utf-8?Q?IzjFlYVbO1BtKEaKg+C8UN0ZPjpeOCxaBL9nk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWRocEt2NmFiSGZjYUtuWHFrR0x3MU5nVmRGTlRBWVM5NWpKc0N2TFNZZ0Vr?=
 =?utf-8?B?UlhmWUlFeGdFaEUvTnBlTml2VDBKUUZ5b2h3VFBvcEtUcXlOSzBLd1lwaHVE?=
 =?utf-8?B?VmN1QW04ZFhFdmJkR3RiR3pFMjVsWDVvYnk5bjRjUXJ1czNvS2pWODN6OXJo?=
 =?utf-8?B?aVFtbFM0R2pkdzVvS09GZmVrMjBvVXhPRmplcmc2ZnFlbCt3NU5scVVSd2t5?=
 =?utf-8?B?bjY1dG1MOU5EbkZNcmFrK2Zrb1dLMEhWelNGalhEK1Mzazl4SU9qUFVTOWtB?=
 =?utf-8?B?c3BFaU8vejFtNDdOQUZwWi9uaEpMNGx1dHJyaUQ3R0p1RTF1MVhCM2xTWTNE?=
 =?utf-8?B?b0hUbUQvWnhORUxyTzIvazVDVXZucVR6SVhFV3l3aFgzN1ZBVzNoR1JNMXNP?=
 =?utf-8?B?MFdxZWUzam9YNEx6aG9PQnFtSTUvVzNXd3pFcmtxR3pvZTZNU2JPRE1TKzJz?=
 =?utf-8?B?WEgzVVYrUHpRNVR2di9iUkpNNWYrNUdQMUEraEttc0R3d1BQY0pWOVlTU1dj?=
 =?utf-8?B?WElsZDFwWEg0UFd6R2kwdVY1NWg5am5XOXEzTjZCRnE3SnFma0szT29HYUQy?=
 =?utf-8?B?UVhxOUtpSFN0U1V2TkpvdlkrQ254MlZQd29jUVU0U3ZGVkxwdjkwTm5yN2xm?=
 =?utf-8?B?MTV0M0JXbmxwR2FsRnI0RFVRN1BIckJXYkFmNDVmb3JDM2lIQmRkbDZXRlVx?=
 =?utf-8?B?a1BDcEl3VzYwMzNXVUpKbThtSnR3U0JMMHZKejQyYXYzendiWGRnVU02bXU3?=
 =?utf-8?B?WkVOV2NTbDhrZ0w3WWpBUi9YUmJ0WjRiTDVWMVhjZDF2NkFMVEtNYnlWdjdy?=
 =?utf-8?B?aVl2QW50TS90K0JJZUxUNmpDK29QK0lUelc4MjFuVEVUYUVqR21raDBQZHN2?=
 =?utf-8?B?dC9WelNLaTFLMndvbHY4VzFKaHpPYVdwam9EaG93elBoUGNFWEdBQ2tWMmtJ?=
 =?utf-8?B?dmVVK3AyNGVXbWNqRDlFQVpwalpJVWRUYnR2dGZUN1VHc3JwcG9Cc0YrcHRj?=
 =?utf-8?B?VVV6SEczWEEreXNwZG9sOVVCaU5ZZ2p5Y1pBQTQ2S01CMkVDVHNzUGs3Ukg2?=
 =?utf-8?B?NnVZalJMR3ZRS1dGQkw1WkplUUJ4SlR6WGVVVWN0dE1xcGNNS2cyY0MvblVY?=
 =?utf-8?B?azd5dHhzcXEvZE56OHdrenMwNktLMUF0WmhNZXUxalNzVWZZS3JoWkZlWGpU?=
 =?utf-8?B?bkFIdC9HeFFPV2VhRWFiV3ZPdmJxeTFyNTdrZkZmU2hqRmZsOForVnlRU3I4?=
 =?utf-8?B?N3d6WUpnbFMycnFkVWlvZVNBQkZ1UkJKWDlkUFFDK0FGQ1lUTHR5dy9HeGtD?=
 =?utf-8?B?UzBNUmRUOVgyS2V1RmlEWlpDNEFhb3Y5Q3R6ekg2Z0FhRTVDK1VkZHVDNDEy?=
 =?utf-8?B?MXhBWWd6ZGJWSzZQbnNRNC9TVXlwVmNsSzlJdWJVRE1YZjg0RTlpcDlBUSta?=
 =?utf-8?B?VDZCV0hXK1NuaGFTbFdJemdTOXFySmhaZUhZekV2TXRvOUI0cm1JRmd5eWJm?=
 =?utf-8?B?Rm1sOUVrbVFOOEsxQTB6cFo4UUNJZXVmNEJFZ1VyZGJuWmkybm5VZ25oRFVa?=
 =?utf-8?B?eExKZUxpL2dhMTl5Qi93M2dKM1c3NmlZYllzMmw5TFhMczdNeThiS2ZxN2dl?=
 =?utf-8?B?V2YzV0RzT1dqVTE2ei9BUkJMRTUxSmJ5Mjc1eFF5Nm9MRnpuekZKcVRzOGVs?=
 =?utf-8?B?QWVMY2hBWk8xN29YOTNvRUNhZFNxTFEyRXBQT0xVOTFUenFHTCtMZWNYZGhZ?=
 =?utf-8?B?eXd0ZmZ6Y0h0OGtMKzUveXNEa1Q1SkN4dkl1T1IvZ2xuSG9PUnhwVGNOa2Rm?=
 =?utf-8?B?Ty82SW5ZdnU4d0pocVNyT3Q5SDRPc05vQk1GZ2dkTll2OHZ5T1BwZi90cGJB?=
 =?utf-8?B?VCtzblA1d0hoSGxnbERwSTdmYWRZcGZ6SnVISXAvMVpkTlc4Z0FqeWVuTWpz?=
 =?utf-8?B?Yk1nazFJNFhRZlJYcEdSK0xIWXRpYlJGY2VPZUpWNXpqeVZJVlNQdkI0SjlQ?=
 =?utf-8?B?VUxFajBmNXFmOUF5a3RuZWRXMkxMTGJKK21SRW9CeHBUTHc5Yktpd0JBQWox?=
 =?utf-8?B?ZmRzckQxbE0yZU9WTXVWd0lZdVRZdHViMWl5aG8xV0ZKcWVTaWNTa3NMaFJj?=
 =?utf-8?B?ZjE3b2x6bVlqd3QrNGJ3ODdBaFpSZVBpRGltV3RPK1JEcVF3Q1dCY2JkOVg3?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c37922b8-0da5-475c-b545-08ddf1eca0d5
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 11:07:57.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxkePAtarsfgQiVmbdzeMvCfZQ6dr2vECsgm8g9KW3x9SIrdr9q8VCaEjjB8v+8T3PBoa3Dm452k/U7VSNJmli4Xmc2+tQwp05OqE4gx7nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8292
X-OriginatorOrg: intel.com

On 9/11/25 09:09, Jianbo Liu wrote:
> 
> 
> On 9/11/2025 8:45 AM, Jakub Kicinski wrote:
>> On Wed, 10 Sep 2025 11:23:09 +0800 Jianbo Liu wrote:
>>> On 9/10/2025 9:23 AM, Jakub Kicinski wrote:
>>>> On Mon, 8 Sep 2025 13:07:04 +0300 Tariq Toukan wrote:
>>>>> +    struct net_device *netdev = mlx5_uplink_netdev_get(dev);
>>>>> +    struct mlx5e_priv *priv;
>>>>> +    int err;
>>>>> +
>>>>> +    if (!netdev)
>>>>> +        return 0;
>>>>
>>>> Please don't call in variable init functions which require cleanup
>>>> or error checking.
>>>
>>> But in this function, a NULL return from mlx5_uplink_netdev_get is a
>>> valid condition where it should simply return 0. No cleanup or error
>>> check is needed.
>>
>> You have to check if it succeeded, and if so, you need to clean up
>> later. Do no hide meaningful code in variable init.
> 
> My focus was on the NULL case, but I see now that the real issue is 
> ensuring the corresponding cleanup (_put) happens on the successful 
> path. Hiding the _get call in the initializer makes that less clear.
> 
> I will refactor the code to follow the correct pattern, like this:
> 
> struct net_device *netdev;
> 
> netdev = mlx5_uplink_netdev_get(dev);
> if (!netdev)
>      return 0;
> 
> Thank you for the explanation.
> 

that would be much better, and make it obvious that there is
matched get() and put() calls

would be also great to minify stacktrace
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages


