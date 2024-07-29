Return-Path: <linux-rdma+bounces-4090-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C721940136
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 00:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDEEFB2179A
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 22:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F37019004B;
	Mon, 29 Jul 2024 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxEvYNi1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E618FDC4;
	Mon, 29 Jul 2024 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292639; cv=fail; b=ZZCN9B0qZUOy44S6S0HIOC3jCUOLZj0LUp3HZf/YmHJ4OHkLTBZ0fTN3ut32aSOQk8AT67+vzK/zwc2s23vTQoahHBWGAbBXGhdO+4CWYvw8y1S/Pk4ztw/8s4p6l+CobV65qbXjaHz3WawdLkgTtfdQ44SXc4mjANsd+YRfZ1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292639; c=relaxed/simple;
	bh=FsXQM/1sNJjXNQH2NGU4UAmYIcwP/NCLarnnykauye8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H0D8CDil8vR/Be57tY/hf7FcdJX2u1Bas/nRkZkpMUneGYHLavSHd5bMS0cvewjDSGa8rTDKGY4zjH7+Q0H1kVvDqcSIjGbjsQXm9LUeaM/M1Y6JN3D1N2fwYtUhMCADZlHOGZui0SMXb59oDP0HQY9dBAQLoaFrhg2wOzIUPcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxEvYNi1; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722292638; x=1753828638;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FsXQM/1sNJjXNQH2NGU4UAmYIcwP/NCLarnnykauye8=;
  b=mxEvYNi104ATTwilFfc1jUCnMeFSghxX7FNx8mS4Yq7oDlV0yGIAPpYS
   +Vlx4upq7wNDmSX3NMFB7wofb6mQayO8MDcOJW54J7hGnw1tbG8Nt7vOo
   /irB0sDXBbtWXanLFCmj/Qh5yiQks4dez41KvKwZ/hUAA65WhJz97XuRw
   SP5LMmJqVChqGe8Vh1bh/Y5M1t4T4cgL7PxQsBmukCsADKBE2q110lrHU
   hYgQLLL4yMpP3Hw2tEoWCYLHT0WSZ9saBpslD1cn1rPvNe5gEfLnnfHEg
   OAjbUb6y/OS7Nl8VUebUYCNxwYQ+zfdlAoSGXw0lSjMU4osFriOLOBTt/
   g==;
X-CSE-ConnectionGUID: ygWsFDEdS1OUKSXJwb3qTA==
X-CSE-MsgGUID: SMmyKbxvQwS1RpcLfLQbng==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20206796"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="20206796"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 15:37:18 -0700
X-CSE-ConnectionGUID: 0vXWiET6SQynTCj88hIrGw==
X-CSE-MsgGUID: DdCyr1sKRguHW2YvL9LMAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="54006802"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 15:37:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 15:37:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 15:37:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 15:37:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 15:37:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdIs3AReN7uKOESr8hd2I8GJV/Axfb+2561ikMFnzurkxvTxskxc2Ajw0GgiMAejW4q0H2gkY7zICVThzSLsrpOtrj0EHkDqRHusoQJzAp+oIBlKA5qx8U4ZyUswiBoj5SXI3fzLXcW7VNf+CRGPkpVl4DIXArU3lXwFdamMrezJTUx2YUrp/8gw+B5FLG9NccWnyVu7ioGP5hK1N/M+ueSxR8CHGhUXKbIFueA0qPToqxR3j7EgAcYfULVfYte8eQ+WdRMhSt0gqi4glOs8qNDrQAEEsrcLidxtcsQVV8PpaQ9JKCp8ZaZZniRF8nRDSe33I5q48C1ATqR7/h+xHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iq9gHLaFeFeBbHhht+GsDZNBrDe97cq5MS4qBvjBBa8=;
 b=KkpH4wAdT6xgM6NvytqkezI85FiGgCwp6kD/DH2daqWWTWGQo8m/0NWdawrzlxia8RtteIaF3nSrB2jdXtcjHFGh3+0zHaDawaa0I9lOjInOorufKvsj/dhmhqcmbRGV9TdfkIP2TT7UkN00TJVLdneV33ATdEtroItDYaEPszkxXuqYz9okw6px4MYkp5+RtcooJmUh8gJ2bbuDIiuHNd00k7xTh6kp3ox0KFflZxMes4qOli/uSWTx5itWP+XR33o0WO41iQXcp+ChCCpKAzhGhvMQG8u/iZWSpudl7uuuOsQW/J7G7JC3L5cBb4ecoQyNQxKHx7g1fD3zI8wmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5169.namprd11.prod.outlook.com (2603:10b6:303:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 22:37:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7807.009; Mon, 29 Jul 2024
 22:37:13 +0000
Date: Mon, 29 Jul 2024 15:37:10 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Dan Williams <dan.j.williams@intel.com>, <ksummit@lists.linux.dev>,
	<linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <shiju.jose@huawei.com>, Borislav Petkov
	<bp@alien8.de>, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <66a81996d4154_2142c29464@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240729134512.0000487f@Huawei.com>
 <20240729154203.GF3371438@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240729154203.GF3371438@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:303:6b::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5169:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ded9be8-7b75-47de-ad6d-08dcb01efdd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oMNQhL4orPx73ct0kRm8XErXhslReLXpObmcW90pnHJNWMIXo5CGPv+EFnqY?=
 =?us-ascii?Q?6OVytnD/vzVntQJR/rf3gmGu22H4ckCGmF+zVKeB8myKqOtlaDePtLdsq7Sb?=
 =?us-ascii?Q?r6AA7TMJ0WYl+ygIQX/qWDCHJZ2DBYbWoK4S7oLlSVdjOYuqhAbBP37Xv/2W?=
 =?us-ascii?Q?OwNaexYIFj6yZjCpvIuV/t6caAH65sFiUlgRGWexB48eIYA0wnhmGboa2pFh?=
 =?us-ascii?Q?LGKSQnU8Kokvo5Lmg+dTynhS8svqK2xecs3HpkqTjqH1YVorD0xJrVjUidWV?=
 =?us-ascii?Q?YHWAPg87av43fkXuzztpJeZDzSGi8uMSqB3l7bs4W6B1EdV9gEYQMrciKWgS?=
 =?us-ascii?Q?IHKTmELgahXhiYuU2LcRH1TfblP5yXGEd58LKYo04JrocnUQmoXobmvjNz3u?=
 =?us-ascii?Q?oLAX5tbOgEQ8M6p0oiULqMXjYQHm7ab25OEVmzFXmeS8xivK4oN64+y00i5j?=
 =?us-ascii?Q?VL62duldKCaTFNhs73yTYBckD4UsBSbsuU8MLUvP0yjxrgD/RXBtTsfWVNsT?=
 =?us-ascii?Q?837kNy2aEOebIOueIpExpNsA/gb62eojVp+jUpuACWVN/jbHUQuCwbZlQkga?=
 =?us-ascii?Q?9v47Lb2qYUQ6IsvovMOUSB0DJPr+VI4SOHsXl7yBVuZ1vEu3g6EjnP3LKpp0?=
 =?us-ascii?Q?O4I/l70Mm5t51WQvrJeCyEt4SgkWVA73vtzs18UG4W0+hNlsG8geYndm+9uz?=
 =?us-ascii?Q?L5P7RqrpCyLpQ/4Y0Xy5QDY+IWybJirc8Jhpdey6YzQYhK7xe9D6lOMTFus2?=
 =?us-ascii?Q?h+XB+GxNGyxHznYgE4wMxodTddBs9BBi4WdQxrC8qGmHPCvkMh6AP1fC2Z8G?=
 =?us-ascii?Q?fwvQyC0zPn0XS0u8LPKXJFStkxPze2PhCgdhrPMRUXaHBK1r71qXlANzqUUr?=
 =?us-ascii?Q?SKLYQ9EBvk//Qnyr8UjMy2xz7aLlcpimdRBYJyvUkemcvZ51AP7aF8AuavBG?=
 =?us-ascii?Q?+Pdr0A89ILVZwnA9bxCYjLHdOhv8dRfeoCICD0XH6KGeQwqPldwNA4zajg0Z?=
 =?us-ascii?Q?FyoqTIZ2lokfmDGgHe63CdeuTho427KmOlLa9ZYD9YmeVgnIL/9y1Do4cc/C?=
 =?us-ascii?Q?0GyEPm15078huVskEi1AWwYmKKiRVgYt5Vf9UBxHuWLs6rSK4qylF5DsTVYF?=
 =?us-ascii?Q?Mwmxe0B0iJwFwKx/+BaXOvN+sjOWHRS7YxIFeNCN/l1MicD/sgiRgKbAY9Lv?=
 =?us-ascii?Q?ovABNmwHg1lDlK83PCc8fteNflbJurHfvy1kGtXNKop+N89xejilaDUVTog/?=
 =?us-ascii?Q?LvSX94E/p2tzSdrxZ9eKtTWux+/niDtMW+pKN0ymMyhvqaPH0MKosZg8PnpZ?=
 =?us-ascii?Q?eIqa3WovI3hNejWzHgBc4fa7VgFkNBp2ocUAU3e+yzufYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NKzPXXDgtLh1QBjCc5Y1Jwu5elREMAjzc1vIs9/hCu131LhuUzRh8vohiQIN?=
 =?us-ascii?Q?zKuE/heB9fiyC7+MA8hxIdizx+3N3MN8ZXVx4Dm+z3IuV/W+U4EhJ00hu9eh?=
 =?us-ascii?Q?M+qK2zZp4lg7pwMZZ3dW9CmZNNI5az32E6S6/BF9iwDCG2wSbAr5/SjyqgoM?=
 =?us-ascii?Q?ZuF3+kbwX/DpAArPgb4hSOFr7ilKHVFlKXxlK8dc54+emkvvRmJJRhF5qzmK?=
 =?us-ascii?Q?uT182krzB1qVNeFCooXnyrcUlbZeFwWyFlUcnSHVv5Njku2UoVCo/u1L3Oj5?=
 =?us-ascii?Q?CjsTjTBNWLHg5oaYIgsme79BXPsEEUA9Zb0gLUZe0fZ+l88KntEIoMr699qU?=
 =?us-ascii?Q?hEHMocbNAh0iSzk/KFUXup2dYAJx8DXttieAUywrXo2q/XRVqXizFhXAnKsD?=
 =?us-ascii?Q?KMnF1MGIpUQOiazf5pozR6oI6+PapgeyQ8WfFECDToi7o7i+X5309m2Z8Dja?=
 =?us-ascii?Q?d76vgQVEe7d4oJ4NhjinF5G4YTLzHDyKTbmTCnRIylHEycQ/h5UJSajLLOzr?=
 =?us-ascii?Q?+4HulmDEqRpS0fUXyDzL+qQvtx7c5BfsKySuKF1fz2pomHTAe2A0rNhWJBrn?=
 =?us-ascii?Q?6xhFWWsDXmilH/4O678ovAIiOOlpBv/0gRz+mGuQxgIagIMF3NPwT+6JpOJ9?=
 =?us-ascii?Q?XZptoaXBQeciPjCkFMNJM6oTT0z3/T8lstqgUM3S+6vV9tl3KpRqjJB4M0nE?=
 =?us-ascii?Q?ifhUFIr+4EYpSuZYYaGPuztaNqXZH/pnCTXnUVVKrE77BCAG65NYEsqzR/NI?=
 =?us-ascii?Q?WKyiH7haHte29ivh9nLBHAwUeB4Lm2wrv2ifTfVoupp0DnSvQxMxD7t6lzjF?=
 =?us-ascii?Q?yAUEJ22GNgxrUmhsnORC+ccmhxQXxDVWvZ/thlORON51Si1+/02EA8S1/7JO?=
 =?us-ascii?Q?aPCC+bELl2A6d6LpxjyBrLganp7p8Sbem7mMrRq/aybX2eNP2kSHJWmAvuV8?=
 =?us-ascii?Q?DQ+1hiXDFwjOBYwbNwDVW1yfFNZIyF25u+Vr9WNMSREWEvzn25DRVfEVxkHs?=
 =?us-ascii?Q?IBl6gfNxSSg4egxsT5FgAGzDHu+G52QysQBkqtGT0a9T1iW/7GusIw/Vrcpz?=
 =?us-ascii?Q?hERj+75VrlucesApXrR3b31OtLxLofy1slju0BJrD9v89GTcDmvQAF7YaY4i?=
 =?us-ascii?Q?fFJiAyeEn0j/qzd712zx3in1/AQGYxgpj6XB2i75ZX5O+Da6gau/RlDc4h60?=
 =?us-ascii?Q?EprIvhbcxo0wmUkR2xGfhX6rdfRew2W8xCQwJVJxuoC8LnckhCDQg0bbPuho?=
 =?us-ascii?Q?57l/54BAfjtfMuvwIO3s5u8xfOnpa5esWK9/fOFd2AeR60OhKQm7Qt0R+s42?=
 =?us-ascii?Q?YLNRlPqsnj6px7x2g935G1PA+EiqIf5pjs4RycThx7K3DWb+nJLWE6T1nebR?=
 =?us-ascii?Q?HFg/euU4Q0Qk4e2Bk0e/h8K09V0nwh2yuYRknGw9mj1Aa/5sWZFhImOCnr9M?=
 =?us-ascii?Q?o72vjBwoKjD6CteWU1sJC5dE7+FE3/rRfM72HDqk0VvSQyfMdHKMvh5o5CEY?=
 =?us-ascii?Q?5kz8fsAtQPIh3bvYcqZUbMhDKoo0wAhxSuEi0X20S/7eQ8S4HIenqXraOMz/?=
 =?us-ascii?Q?8FyzDH+g8hBxtNkYjuAa/L6rlWJ2KxO2fUmYSIDXZOArDPoQjBHbCD7d+4nr?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ded9be8-7b75-47de-ad6d-08dcb01efdd0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 22:37:13.6170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4z1hbhsZf9RyatyINAulQU2L1B9OfjDg4utrj6/EBdm2BAgL/AM6MzvEMRR4cF42ZSYUYeU9pDvQH+sIH2EkTGrAqFctT9keRtZgURTlic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5169
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
[..]
> > We could say it can only be used for features we have 'opted' in +
> > vendor defined features, but I'm not sure that helps.  If a vendor
> > defines a feature for generation A, and does what we want them to by
> > proposing a spec addition they use in generation B, we would want a
> > path to single upstream interface for both generations.  So I don't
> > think restricting this to particular classes of command helps us.
> 
> My expectation for fwctl was that it would own things that are
> reasonably sharable by the kernel and userspace.
> 
> As an example, instead of a turning on a feature dynamically at run
> time, you'd want to instead tell the FW that on next reboot that
> feature will be forced on.
> 
> Another take would be things that are clearly contained to fwctl
> multi-instance features where fwctl gets its own private thing that
> cannot disturb the kernel.
> 
> I'm really not familiar with cxl to give any comment here - but
> dynamically control the single global scrubber unit seems like a poor
> fit to me.

Right, one of the mistakes from NVDIMM that was corrected for CXL was to
explicitly remove the passthrough capability for global state machine
controls like scrubbing.

Many of the "Immediate Configuration Change" CXL commands fall into this
bucket of things that may want to have a kernel-managed global view
rather than let userspace and the kernel get into fights about the
configuration. So, I think it is reasonable to say that scrub has a
kernel interface that goes through EDAC and not fwctl.

For the "anonymous" "Features" that advertise an "Immediate
Configuration Change" effect those need CAP_SYS_RAWIO at a minimum,
possibly a kernel taint, and/or compile time option to block them. Maybe
that encourages more "Configuration Change after Reset" Set Feature
capabilities which carry less risk of confusing a running kernel.

