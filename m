Return-Path: <linux-rdma+bounces-4657-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C99965819
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 09:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BFD1C223FC
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 07:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27957153511;
	Fri, 30 Aug 2024 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NqC5PvJh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200B15217F;
	Fri, 30 Aug 2024 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001717; cv=fail; b=mUXxudMmlpEqVEeR9KAxeg9eDazoqbtmx3IQizQdxPWv8RFwPDMN4FvytfNKiqyOahf9UDowH+zRXwIugV98hhRcNQsoSjTi9VRX8f1QsNm8DlGbXo9XYJ4jl+Rdxvm7nBQyjHNdU+jR63VkA9OToCeLFFH+3y6c56xuvXVFG0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001717; c=relaxed/simple;
	bh=M1FS2/9IrSJZgz8zhAE6Menx5vQtLw8V4mxtyUwa+2Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hISr2Ym1dZMikpkqJhR1PLAwbW1jBXOpMuXRUS8aCWawmPmoSLAeFjjp4kjdA6t4GqQk0d10KUJF4YwqJGiwHWdS3gM1petBQ7l2lRAuX4o/q5fDuGxLAmpd2tkUeMjckgFtk32upbyld1OYtLK4/6dMmS18LI64v8cz5Sq4ULE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NqC5PvJh; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725001716; x=1756537716;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M1FS2/9IrSJZgz8zhAE6Menx5vQtLw8V4mxtyUwa+2Q=;
  b=NqC5PvJhTbeW8T549iGLMma5YpZ7gnp9yvF1T0pHgddgBvDEnxMY01il
   UqQmsKERc6mka6wh6LvFXkc1N5TRfpykGbux8VGQ9wWbE35bMxCZHGaL1
   Zo8/HYXrVRX7RUHXPr7MuwMaIMY5S0RC8HqpPC6z4y49n6qa2ENUNzZVP
   P9H8YltnP9M7NT95wBB9+7O7I8QGn5CpbXvnRRHGieXLOnwC8Se1tbSWe
   AmymDNR4+h54rDJyHUS1152E+rQemj34eYz8WJs8W84uSvzbb7XS90tKc
   1AFFpQHQpGqZGXhMhsDxslRNHJxvKgwB7fvXwGNoHpud5nilfJ8RBMsc5
   Q==;
X-CSE-ConnectionGUID: 0xWXkFxgReKUm0ZVlOl/+g==
X-CSE-MsgGUID: JStb2FqLSbWSlfpI0CQeFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23147118"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="23147118"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 00:08:36 -0700
X-CSE-ConnectionGUID: DL/wRQXbS4WFeVC/aRvuzQ==
X-CSE-MsgGUID: r3nFtWLrT7ajsT4H+BmIGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="63862629"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 00:08:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 00:08:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 00:08:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 00:08:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWxMi/Z8Iokrns+6otnYHowXXouK3BR91CO+InNCIaXUcNATyXuzk37wvKsjCHOOShkFXo6Z2hu/jfwqYSa/5tussoRKxjsZJrcNYPen7NVgFHuEpjWDTo7kUtI9ueJUIm1ss+BLXaNCqmQauGGL1npuuzdsJlZ24rJxCuInWD3rpsZYS1ijuGdXCJ5zlZwudPBxgyjmRwBkiEA5pBCde7gmrFEXnwLdqMOdxbk5ViiQ8DKILmadz/XAZCaC5GMKJtY8fYZNvrqk3kFnLAIweFThAiSptZm7Zbayp85oSd4/m32oWbaDxOfqoueEvANenh5iJuUquxdgM5VVro7gRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqBUsjFvSs6Q9Ux3EGyHX2kXjTVF2MJfLzUa7oXEkY8=;
 b=x9kne7RCP3UlAkhF4GZOz2eMr5LkLmrgV/JuLNOTdmodglkyAgJyVefrrPb+2+V2SD0EuAA06v/TqVzsATLOQ5Y8e0guSacyjlj/tkQio5WU8HkKZx80Gom1KNNKK60RM2O3TLb28UUazRNHRISwxL8W62s/TEYbB9v7pi2Fz4SYWgmWlAVF2YzmJ+O8QvfS7cdG5sZlPO75CLacBl4XFSDHoezkrp7ZrEMtXHQokJq7mj2e3Bbz9rvex5h6oU7OxmckSOb29qC2BJwrbKSVfoTvhzHJ0D5Dctmm2v8vHh1fwgI1W+tAlvdeZkalWK7wVdTmVFkVGnRybgFJXHcawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB8489.namprd11.prod.outlook.com (2603:10b6:806:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 07:08:26 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 07:08:26 +0000
Message-ID: <43e7d936-f3c6-425a-b2ff-487c88905a0f@intel.com>
Date: Fri, 30 Aug 2024 09:08:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] net/mlx5: Added cond_resched() to crdump
 collection
To: Mohamed Khalfella <mkhalfella@purestorage.com>, Moshe Shemesh
	<moshe@nvidia.com>
CC: <yzhong@purestorage.com>, Shay Drori <shayd@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leon@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tariq Toukan
	<tariqt@nvidia.com>
References: <20240829213856.77619-1-mkhalfella@purestorage.com>
 <ZtELQ3MjZeFqguxE@apollo.purestorage.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <ZtELQ3MjZeFqguxE@apollo.purestorage.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::8) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 3785678d-4cdf-4128-0464-08dcc8c28ad2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDhRMnpwV29zVjhGUE1iUVRucmZ3RGZqclpxSy9zT3pDZTY3a3BoU3RoTlZn?=
 =?utf-8?B?MGY2UURsOFR2RTcvOEIzK2ZIQnhKN2w3bWRPd1o4cE1tNmhVbE42UFlvMk0x?=
 =?utf-8?B?SURzM0s3dDFqS1F0eUxOaGtJbWxEVHoyYnV0NWRaTGl1SUhpY2NaU1kyYktU?=
 =?utf-8?B?eElJUFM4MzhHUHpBMWZIOGVXV21TMEFtaVpaY3pIWkJWTE1xQnljTUJXU1FI?=
 =?utf-8?B?VVMrMTNwSllTLzhEOTk4RGdtbWZ1UVNMaCtkcjhkeDk3ZG9GTmZUVFdUd1pu?=
 =?utf-8?B?dmpSU04vNHp1V1ZET0RoK0pNM0xKbVNkZ2pTQ2pYMm0rMEdlK21BZHFXY1Nj?=
 =?utf-8?B?VkNTSjViTWJqSkMva1d5bUx1aVhZN1BIK0FhUUNhaUpTM1oraTNxYUZUWFdW?=
 =?utf-8?B?anQ2YXpGNXhEbmhaRnlUa2t6eUpISzlaV3pHNXoydEZkTG5sRGFYVGwxWEdr?=
 =?utf-8?B?MGtweXJqTEJ3a2VBZjdLN3d1elNsMUJGVXJ5dFo5V3g2aVhTUVgyUHpIeXdD?=
 =?utf-8?B?SVlneldxZm4rL3k5a01EUHJtNEg2cDZabDM0T2dpbVA5eGt5UFU3MnJwZkdr?=
 =?utf-8?B?clA1Z2pCclB1dCtpclRSR1VUWVdpYzdKV0Ftc0R6RUMrTkduUXN4Ym9KVlRN?=
 =?utf-8?B?ejJlUzRZTjJRWXNvcXlnZDRHc08wc2FaaEFoOW9kWEZ0dFphWjBhQTBJcjhF?=
 =?utf-8?B?VHd1cHE0QmxncmowU0tZMU1PSVZ2Vm5wdlhwYXFXOVJOZHF2bjY5QjlkbTVp?=
 =?utf-8?B?eWlZZVYwWnNITktkUUtiek9ma2tmbjdvZE1xMXJzbjNzY2pDektZb0c4bGI3?=
 =?utf-8?B?QXk0clg1Sk16YXBscVpCRElGengxb2FNNlpTTWxQUDZiWGkvNXplckZISzYy?=
 =?utf-8?B?bFBBQXJ4bnlpbE56cFBjUWVDWTJJUDJIYVRXSzhjU0JyNlplYStjTC93Q3hs?=
 =?utf-8?B?VnNyeGNIVkNMWGRpRHZVVi9Ebnk2NS9HZ2p6Mk0vdThSaGR4bEhGTWNZN21p?=
 =?utf-8?B?bE5tTkVPSE1YdUVIbnJEZFlMSVk5a1lncnU3dHIxWmN6dndGVUZjWWgvUm1n?=
 =?utf-8?B?UFhnRUowSFUyMytNZDdIMEl4U1Ywa0x0SHdyUm1GS0MyMVh4NC9wMGdFdWh1?=
 =?utf-8?B?WTg1N2h0cTAyallOK21LTUhiTGw4UU1XcUdJU05pYnVqZTZab3pwWmN3bDk2?=
 =?utf-8?B?dmdpNWpLaTlBb0x0b2pDM0lLSjRXZmxRNXdkZ2dDeTIzRktwWlZTK0lrd2po?=
 =?utf-8?B?Z1pIR3Q5c3dmOE1kNjF1M1BOSHNCYlBhWW1GQ3FCVmdCUXpEdURrMEtFdmNn?=
 =?utf-8?B?U0V1RmtLWEJERFJCbUZoYWYwQjMwSjQvQ2JrTk5MR2poOE1qelNWaCtOekdi?=
 =?utf-8?B?cG85UHhoUS9ZWi96Q2hmNnhaQTVsak1TbVVGeDVOaS9XZENUZktmRTV2S2dT?=
 =?utf-8?B?bjdUUUFTbFdaZlZqSkk4TTkrVlFUNVdMZG9vbXVPNHByNmV6bVZ0eGdrNndz?=
 =?utf-8?B?YjlnTUpYdVFGcDV4VWFvcWVQc1Nqb3Voa2l0dlhaMDQ3TmlJU1pGd1QxNy9W?=
 =?utf-8?B?dW9Jam1QU0FkVzIwQ0ZpYmRrRFF1UkZwK2x6U2tkRXYwdVA2RGxIQ2V6NCtR?=
 =?utf-8?B?TndMTGZlUk9uRGdvRW1lUCtoY3h0bngyOUh3Y3ZBZHIzQzdVZFFDb28rdU4v?=
 =?utf-8?B?QjZ1TUJYZHZSUktBSzlWeVYzaDd0NFJZc2J6ZHFmdVhud0pnb08yS043VFNo?=
 =?utf-8?B?Zi9sa2I1M3FhTUhEMlhQc09QbDRtZzVrYzBYeVIzaDdGcmpqc2pHaXhGb2gw?=
 =?utf-8?B?aFdrbHNabGZRb1gvenR5dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEVLQlh6MmxqcStFUXJIODdCUWRLU1NINmhYQ1E4ZHVqcFQ4RlJFS2grT1ZK?=
 =?utf-8?B?eWZLUHNZREt2U0xlcGUxcG5sMnBlVXNZcDhPY0E1RlU5MjhhZDMvblFpMzlF?=
 =?utf-8?B?eGJJNmUwYmRkWm1UZTdseWRxS2V6ZTNHcWU2MkJSMCsrWXNsMXdDZUNncElT?=
 =?utf-8?B?eTQwUHk5VXVlWHc4SDBYMTNLeFVjSzk2dnNqM2JPc0p2cWlXY3Q2TFVqYVZi?=
 =?utf-8?B?V1VxYXpCclUrb2tpUjdyUkY5RGN4MG1DRjlZY2lacjFad3h3OGdJNHVuWkpv?=
 =?utf-8?B?ajlFRVFYY2F2dU1iTzZJdEMvODQzeCtMRm9uejNoZzd0N1J6VXFzaXF6bEV5?=
 =?utf-8?B?cWFZTXdaL1NFQnNiUUlrNmhqaG51OEFValQvQjhlSTRNTnJSd2hHRzBTVGsv?=
 =?utf-8?B?RU1Zd24xVktkSEdEREM3Yk45NkRlUy83R0NMb0Z5NDIrSGZmMkdyUjdIU0lF?=
 =?utf-8?B?ZUhOODdHMlEzSUZIL3BhZU8xTlRPSTBjdGVRSUVYSm1BeU1mZkJwU0xXMnFi?=
 =?utf-8?B?Y2RPdVVIRkxxR1REbVUxWk1OblJXZnBQaWxMVG51bjJwVnIydnJsaktoRlpQ?=
 =?utf-8?B?UVBlLzJrMGY5SnhFRURJeHRnYnd5cEdxa0ZCWU53Y01yS0R4N1J1d0VMUGV1?=
 =?utf-8?B?Y1FvSldySVlKY1pwQWFIWktSSXp0cXViRjVEa2phb0JlemtGY0EwcG83K0gy?=
 =?utf-8?B?LzhUcHdkdWVZWndVRFBmWG5lN1Q1R0UwZ3NkRDI5K1RGL2Fob2J0TGl4SXlT?=
 =?utf-8?B?R0crdDkwdEhEQWU0ZitMTmZFVUMwbGlKa0xyOEVVOERqZ0IwQXpKdmFyNjk0?=
 =?utf-8?B?K1p3QUVIejUxSkJnckcxSTV4NU0wWUk1VVNUSnVBY0FrUGN2bU1QZnQ5NkJM?=
 =?utf-8?B?Zmt1UGJQUVcwb3RvckVQRkM4eTE4L1JUNEs1NXFuNWFJNEdpYjdiOGsxZDZL?=
 =?utf-8?B?akMwS0VuQXBkUE5rc0gzbzYzZjE4MlljQU9BeGJoQ2hzb2U2SkNLaytTN2x1?=
 =?utf-8?B?VnhUWXdDMlUxSmlFNWlIMkFJa3E5YTNrU3N1SkFhMjNCM2FSWjc2NXZDWG1h?=
 =?utf-8?B?OEZFRzFmVzJJZjUzYjVEMmZ6SzhPWTBKeWpzSy9panRpWUFhcnowWEpENTRi?=
 =?utf-8?B?eGNPVHV3T2gyeDVZVEF0c1YwNXBtMnlDZmpxaE5lUlduMnBYeGRhWU51Qito?=
 =?utf-8?B?M2wxT3FkaGVqZGs4Mm8zMkVxcDkwNk9IOTA3eW1HL0M3c1RrOWlGZGNPcmpy?=
 =?utf-8?B?eFM1N2gxeDRlYTR2MWtacE9PRDJuUWxQcGhMRVNiZ0svU1h1TGJVME40aC9t?=
 =?utf-8?B?SmY3SURLRS9MNDVVM2VURFVueDBEV2JOQUZ3aUN6RVlJbzVGR3JLWWhobmdw?=
 =?utf-8?B?YnNQNXdpWUowa1FSbGNyYTluT2srTmFnRE9MWTI3WmpqZEpINEgxTDlCM2Fs?=
 =?utf-8?B?OEF3eThGVG1sZXVFU0RhNVN5YjRxdEp0aTQvblpCUU03eGtNUXlzb2VtRXY3?=
 =?utf-8?B?OWRpbWQzZWcrR1Y2UXMxcGQ1d3JaeXNyWVJ1cGhYblpGYitvQUo1VHVKWjht?=
 =?utf-8?B?cy8rM2Q1N012TEM3UW9WcjkyNFBCTlYrYUVpNDFvMDQ0dm5ENjR4Y1hLY2tv?=
 =?utf-8?B?dXFaOGlHMjEya0hMbDBWVlo2aHBhdHdFaWpxOHg1dWVvT25xR0xKSFhUaXNr?=
 =?utf-8?B?TnVlbXZ1R3gzWitZRmpjUFJkV0NYQkx3dEF4Z0x6Zk5JeUV3VXNHcS9GWGlT?=
 =?utf-8?B?aDc4UG5IRlVxL21IOUxlUnpMTjhJa0F0Y0dYaENlemxKdTlrTjlweWdBU243?=
 =?utf-8?B?NWhYNU1KTUE0YjdZUU8vQ2pqVnJLM3ZqdEpyQlNGUXpSbkRBeWtrTnhZZGJu?=
 =?utf-8?B?eGhadStLY3BvbHA0Y1R6WFNSdGJlRnVNdXVYWkR1NWZzQlN3Y2Nwc2RQNTVS?=
 =?utf-8?B?NGJ0dk01NTFuWUwxeFA2M2lGZ2J2TTJ1WkpJOVZQeUNhSG5RelZUamxTV1Vt?=
 =?utf-8?B?LzN4emJEWlNVQ2VkWXppSjdDc2ZKS2dGOUxJWlF1ZVRvWDRMdUZoby9CREJO?=
 =?utf-8?B?aERzeWNQaHowZ1J3VlJDRCt5OGVHNk9tTkdySGlNNnd6WGEvS1Zaa1BLN1Fl?=
 =?utf-8?B?MllxODY1RUJuNS9NU1BCaFllVVN4a0JKL09sQksybEJnRDlLWWw5VHJtYUlh?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3785678d-4cdf-4128-0464-08dcc8c28ad2
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 07:08:25.9814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6OYFuZkwDhMDHjPTVPb4qx671gHMOGHT9reQatDGNBboYTAaWlq3Mm2imGytyqPsneqIvFctEuNqSKbBu5BPFoMJKKwChXK65hPfoyflSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8489
X-OriginatorOrg: intel.com

On 8/30/24 01:58, Mohamed Khalfella wrote:
> On 2024-08-29 15:38:55 -0600, Mohamed Khalfella wrote:
>> Changes in v2:
>> - Removed cond_resched() in mlx5_vsc_wait_on_flag(). The idea is that
>>    usleep_range() should be enough.
>> - Updated cond_resched() in mlx5_vsc_gw_read_block_fast every 128
>>    iterations.
>>
>> v1: https://lore.kernel.org/all/20240819214259.38259-1-mkhalfella@purestorage.com/
>>
>> Mohamed Khalfella (1):
>>    net/mlx5: Added cond_resched() to crdump collection
>>
>>   drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> -- 
>> 2.45.2
>>
> 
> Some how I missed to add reviewers were on v1 of this patch.
> 

You did it right, there is need to provide explicit tag, just engaging
in the discussion is not enough. v2 is fine, so:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

