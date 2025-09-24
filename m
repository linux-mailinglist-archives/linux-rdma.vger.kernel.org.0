Return-Path: <linux-rdma+bounces-13623-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55587B9A239
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 16:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640B61B25D02
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F1E1D88AC;
	Wed, 24 Sep 2025 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ezZkWZjf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6562D8C11
	for <linux-rdma@vger.kernel.org>; Wed, 24 Sep 2025 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722458; cv=fail; b=pJkKgZSJpUX+VjLDczbuDZdbQY1EmDI/ueUyPYtNjqPCcywfJG9CSnWo6nugNv4lNED6mmHxvVe9ws/wOiO1GsHZXAXEf2K9pOw2y3rQNailY+LYeiOJTahCbt+0rNc3x/UJ/a5ugL8A7hZuEjXcxHbOagWAaXgQwNhAVwcCSbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722458; c=relaxed/simple;
	bh=z8MIaOWBnDNN3Nt0naBvMszLL0f39iUIWGm1lIHacf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AhaTl5AOJOlLPAKrmtA+x9Ljceem0+qGpIqtpDjGEJHhsTRD2605lypAsamr09ujQwndCxfWzES0+X8qQCfXqjiG9HVU8Y/yrCRz8M9sGNkU6Te9RqWN8ZQy7RTeEEyuFKpVBin4tpYCG3N0jwrk6a2SU8JEMmU1ix1X0ytiC+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ezZkWZjf; arc=fail smtp.client-ip=52.101.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRMZSy95QIERMS3Ve4NuyE0XoxIXbU5T/I8675c+B75v6HiITuy91E6LjIpuz73ocH8SOCBLGka6Md/yUpm5KZSTnzDk/As+6WrvHGSjrAE7RC0nWMSCjRmHibnc9jT25SQOv6NXxGlJMfGoGRsqpJF3AY+KIdl6aSg5hnSAMEOOKxOCSY/6mmrKi4G3CAuBgmw79txKhksZiMP2u+AvV+XJEe/bHvY02GB6LUi1Df9LsipTjy33daP3u7zue2biDD4xtWWm9TzipAUs1p7X4IoRTfkmr3eUYJ4tFKWPtTurn3V15+fLcQEyXjVtls0BH4/q5TODFu+FoLvn6gsF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8MIaOWBnDNN3Nt0naBvMszLL0f39iUIWGm1lIHacf4=;
 b=H2rmpbyNFroslRlKRmc2xF8IsuLlFdg3sCijUAhUySva+OAfa5om4j1FxiZC36hdVXZDMGohB71ebMdDAgIMzQW8XytgrfRBx3alP9XAao/zPCRqayXwW4Ey5djXWYXEE9BYO6aEyy8z5FBlxxBo/ZcXj+nDUv48jvdbaXrFHtqvKmQ9brU6p2kKipOankZb1Rvky+Wu+o4VE2psrxrsdvm0lWSLQyXSJYwOodpEb7qhjjFsWhbPXDnfnaoUsjxIDCUAGfrSl+GXIq4JWcXHiu7ij/G/AD2rksoMp/IWgeIecgBLdLVgUJPJf0ZLEoPSB0SqrehIw6gYMIEU2fN8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8MIaOWBnDNN3Nt0naBvMszLL0f39iUIWGm1lIHacf4=;
 b=ezZkWZjfW8vFUUwvbTr28ZHWgE6Id2usvXN6s8JG1YEUj9p70evsZOcOXamdFsjrn4jZnyb7nlmqkldKxXMuR3vXibUWPgz6bOCCIQmOBtD9iq88Fhtiv04t2St53Xp2hSV5piEVX26CAcmTe/GnqctJkkhVeoehedJSWxyoc25EXTCAQI7r8gobqFnkbbsnjSCv9Z0YLFQ5F/11IhKlB5E3AYhgTI2nnnKykWYYyZ6FqQG6QtmvfHh2eRCgYV9lFvAbXnhIl98z274sicjQ3XgQW+Mh8L+kyRLR9jjJDKLIt3op0UlLmayaqxV9VSDY0Wd8X747LagnHsg/W6/W9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:00:55 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 14:00:54 +0000
Date: Wed, 24 Sep 2025 11:00:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next 1/8] RDMA/hns: Add helpers to obtain netdev and
 bus_num from hr_dev
Message-ID: <20250924140052.GA2674734@nvidia.com>
References: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
 <20250913090615.212720-2-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913090615.212720-2-huangjunxian6@hisilicon.com>
X-ClientProxiedBy: SJ0PR05CA0105.namprd05.prod.outlook.com
 (2603:10b6:a03:334::20) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ffa349-4f38-4146-93c3-08ddfb72c71c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xhUadX9HFdoHJL/Ktx8BM/UIMmEfo09ymYet3DJs70SgWHDCOh0xNuqewUjU?=
 =?us-ascii?Q?N8A6izdfemv79Ci7fKBhm14tsUBJ8Et/f5aYOgtOo+nD0scfKnBMQWSN4Zht?=
 =?us-ascii?Q?3226QFZo9oU6dmboSgb+ZCYEz/tHBW0Kaxg/6zcOuD/V44crrZtL6MFkziss?=
 =?us-ascii?Q?/42kszhtxtI9QKq1zs/df6UV0kiH7XenyjxQmf1ecZMYjV1I3VnyrtebadSD?=
 =?us-ascii?Q?EbzYoApm82+3vZZk51isMLWjVfwwiTyeCl3tj3oSUSFHbv+hst6vzMrYblxt?=
 =?us-ascii?Q?jBdm7ZCU/P8QMrKtaFSaVjDgzRy+9xKijr6/9IQo+GvdyDL1LZRh0qZm0B8C?=
 =?us-ascii?Q?uamUpUOLDWA9GkQMVVus9Ogvp87je2CkEeLFVXdwNqO/93okjRJeTOftJQgu?=
 =?us-ascii?Q?5K7OraJ4QYS/pmjJdwMrPCWm/rOEt9gx3TmqGigwjAm28IvDlU0Ngl55dPlA?=
 =?us-ascii?Q?TlHenQzGbnt+mdqB2QK+Hq+WgCM2zohBooXddHmW6Z1NV+IgHE0jiKjesW/S?=
 =?us-ascii?Q?tr/UnRkVXIVYORbj974WO0Ftw6W9CiGjV5TMNW7vq/3gosshBIFuFqzI7gg+?=
 =?us-ascii?Q?Mcx2RDSNxikSw1FAmnU1RPFlhpppNZ51jL+8rJQAl9BiG4oE+AjUv6qMeH96?=
 =?us-ascii?Q?evs6ahYhDIsO4szKHIEqvyKWidnpMRx+BJpZZci539SNNTfe+V9Md4olpvRA?=
 =?us-ascii?Q?O0eXRYs7Iy/B71/5acHOCVUdYL8eNnApL6uZ0le++Ri7hlpHvkSowbSIn0MJ?=
 =?us-ascii?Q?J2EW+3VkYtbOHVmNqyGNexSTccwk440WqGQcKYTXFQ3Yk137EonqxM/xWVEn?=
 =?us-ascii?Q?NeNrxv9NQx0c4Rldl0cqA83pNgp33WLBsRkV6/IxzH44DTVma0Rx7GOxHQsV?=
 =?us-ascii?Q?XaYOpOo6q/pVeLSDW/HG9zmmC3D9i2plBgg351Oorc1p1i+HevXfykYHiryo?=
 =?us-ascii?Q?rti0SPUQD5G6M8kXGsf6fWGlYbwP3W7Fst9utC6m628djQVyh4HCqi+wKPOM?=
 =?us-ascii?Q?vEFkkqEpnFPIyd4FoDOXfFO2JW69i/OO12dqYy3ZrZKdxLPhL2fZ9c+C/Yfz?=
 =?us-ascii?Q?FHwFhJN2NhKHSns5ZflD5EKk4zPLXYazyV0Un48+9KkQtwaFiKl7XlE0PCNP?=
 =?us-ascii?Q?Sqj2Ac7XdY6Efv5PAmALvw11c84zl7tyY2Y6YdcSaJnho/2nQ1PsOAqkkJzO?=
 =?us-ascii?Q?r2sWnm8nyO84s9npzchmQH7q+5T3SU1yJQfuQLRH3bKhfU5/QkbXHRtFf3DR?=
 =?us-ascii?Q?EL7psGEj5ZVdimeXeGjSKa60JjNBBNgTuxU+XxCCy1anAYlamCfUcX+8M6PO?=
 =?us-ascii?Q?F+cvNcamX+pAeKcnWskQuSBs3mYSOeSKBF5BzRHx8l1OByPdjZkxLzKNYb92?=
 =?us-ascii?Q?hOoUokt+/IJPRPhvupv74pEDeZ7WxAh61dF8jDfBIjqkTaB+bTQ36y0oPVrz?=
 =?us-ascii?Q?xYVt/3ybwfs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0U3jkp34fNzGNEUIg/gNf/uRN1CeZ4t/6rzKzmW9MrN66NG5zGe/SLBmXUEX?=
 =?us-ascii?Q?hgYgZcyxi41SO7ObqUOSaAaa07Q0DDq1VwSm1tTrUYqdbnq6H/TGuv3rhydC?=
 =?us-ascii?Q?kvpjEEUIdvAjsY4of7qMToi1TaTnYCInVuIUWvQ0yJpdklURT16KgMXIHluu?=
 =?us-ascii?Q?dN3Al9z2kh+6wrAMAe9MNqIg871voT2n1ml7kfdY8CVWAbmNPjgjhEyujk70?=
 =?us-ascii?Q?fmi4xMJDZZxhbkonEg0ula8PELOBe1jG3FwMMPEOZpkvlaufWWWKRtQ+l1F2?=
 =?us-ascii?Q?JOWRDjHO+b9FcxS6VRbze9EsdDpYuvUDmZsTIlYh33li+UlogK/Hoqh3R9g/?=
 =?us-ascii?Q?dCx+KVz2eOc6PNa4e/s35eHt2lvVSv7ra0z1Y3FNFPlv4/FhiVrgRgV25NZV?=
 =?us-ascii?Q?FTiPmU2yIVik/tTNzaiVt6Y8XTQEvvAtuiMXb4j+CPGVPfXkyXeQw73rzv0e?=
 =?us-ascii?Q?vhNIq/lsdsyKRHkDLZjT1GpMtaaRRqlFlqHObsLAtLpvAjfQ6xtRmHeSOMQ5?=
 =?us-ascii?Q?KRL/Pml/fI4sgv0OjslmOWavSkFcDg2OxnU8Z5SBRc0tL4fDST6cCz5Ku71R?=
 =?us-ascii?Q?G+nAXSHf1+3c9vwanBg3BbNdKxzabbRRW17G4XUiqS2ptUoRys242Gq7szZC?=
 =?us-ascii?Q?fhxWExlSnkIdmytuTQJjHVME2K5XN5lvIM1+5lE1dMMJUCwhuGQDZJbQVcY/?=
 =?us-ascii?Q?uXedWwM8vOsGqFjwSoym1p3mmyqlY3969vFMEMQrUbf6tJ9V8hr751VEZss/?=
 =?us-ascii?Q?hTihWq0MhZces8Ue5miADwroD52zaRuhhjmW29QkIas3m6phVAeKI3+72xEK?=
 =?us-ascii?Q?Jde+svyFyALhjbxzabXF1cINikFP57eJyUU4eXRVEnR/bPzNUUHB4JebKGKj?=
 =?us-ascii?Q?odjtRSxd8OOzkWiMzkZjvq+PESMNnbDU7SjY0bKFzFq2qd8EUMDCHYaHkwF6?=
 =?us-ascii?Q?RX2IbjgUjvdwuz3wQTXbip87fYXYQvXjmF7ONfi1u35yctA5wKeOGSt7Fa7I?=
 =?us-ascii?Q?X8hUBtiL+wXTHzwucpSPOz8dMnBWOORBp8910i/zIXVmihVv5X81NRTWoGQ5?=
 =?us-ascii?Q?+rxi0BWR/9kx6/1B05+tKAG3csduybI70aHkvwiGkTXxzvbpBf+eFFi1qNCi?=
 =?us-ascii?Q?mw/ROZqtYTcZp1k+fNGfylxhyX5AQksPMMN8Dzwt8LV/MiHKD5efgPRbVqUo?=
 =?us-ascii?Q?z62TfOQSDxScDncXEILDoZdMblVYDnDwGW07xoQTjwBXSF2vKD99YVjacG2k?=
 =?us-ascii?Q?pa98jAF3jY6rOI3kGOPex4BfLDJ9X2tNxAJsT2JeFTztN6OGVEWBSVePIys2?=
 =?us-ascii?Q?/MY1RBaUmINAus8oE3YUUqzcmh/DMKxsq/W9qBhtfoxmVZqJpep41nDGsl5u?=
 =?us-ascii?Q?Wg5j2mjq6gASJ8wkKJ4g8dp0nw19ZTAHHEO7aql72lanoxnjcJo2WcZn3YMO?=
 =?us-ascii?Q?VrcqCOw72u9x6AeHBzZYllfaB/gaNNVstK+tjfdIuOmMCxtiQrDW29EpRX27?=
 =?us-ascii?Q?ZF6Tt7MH1pRWXu7cFXlmi/xcnDC4AyHVJUORCNBKmkRX682DxkIPVbUA/Cwz?=
 =?us-ascii?Q?9Mj7x3e9yZn++J5VkUQL8qjFTav8CaiyxHoVpcWm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ffa349-4f38-4146-93c3-08ddfb72c71c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:00:54.3578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9b5pAc148dV4pum3vxwTmn9aZBZftISHLzuFpf5LDfjydIcVNYTMom6r+zWzB3VM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891

On Sat, Sep 13, 2025 at 05:06:08PM +0800, Junxian Huang wrote:
> Add helpers to obtain netdev and bus_num from hr_dev.

bus number seems like a strange way to do this? Aren't your PFs a PCI
multi-function-device? Shouldn't it check for same-function instead?

Jason

