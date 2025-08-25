Return-Path: <linux-rdma+bounces-12903-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8FAB34472
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D933B5794
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7642F0C42;
	Mon, 25 Aug 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GJRgdbvy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1018B47D
	for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132984; cv=fail; b=LlVOWqjAJaYgv1J0v1c9H+3RYkNvI9ZQMxEBe75AVgXCvLIY9w9G3xfRg66Uukh/16k06ovDp3/SeRPnQeQWrrQG3NRHAEHgdY1NZ4Cqk97Lw2n7YKNdtVera7xcIY65zEThCCIhGfVZQND4cFHrybnuYegW5LpcWM/KUBNl3jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132984; c=relaxed/simple;
	bh=PV+NgbNRuBxIwYAvzh/e6Q0ybuSZGDheSruk5n5nYzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FLvaXEEezLCkiyjd5xzH77G3+sUOmloq2KvhNnwPYWgseOmpJQXDyLwI+kEupeJ6D9gYmOuB7PCcztR02Vntu26yDSPe1D/XUK++6U/C9nZPH/blpbPwGYrVe6dwiRhQ8si7/KuoeOrrr5J411ZXCYj2aS7XLnGylSyxexUFfNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GJRgdbvy; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCtnV6zZ7CbtSc4DD2o+c9gI8+mOaUka4lREfsd6A/7R9pLKnkAB7TkFZmZOQCpBAcUGD6G/lBUJUTS+OjLfMBDbhTeWNvAEz0S75Ll625kZZUXEmPCUhDtvE5/uXJ8S+s4mYWIYyWPWCNm38HS8J5hQwRavEGHrGJWd/k+L9OiIjRQlxgzYsmRvf+X/gzFcmttOtQcZzgapX4DND9m3ELip+LaOHk2YdMm7GHtlNPUwjTH58KlJhMa/4tcp8xtEWikzft+/bjL+UYZVOGJOn7B802Wd2qdNRqBPNjCKh0ItXs52oCTxmKlepJMOftE8J324yoDIKVE8KbHXj4Zi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UdBTS1HigHtgXwVOvVIbRPIfL6n/JIkCdS5vhvc260=;
 b=DP22btH5UWAyA3tYRL44waQEMMcgfbIiKHnaTNsnsD4KcDLrMpF6ToOBeXG1VyWykRrkr7Vbglqu5J80elaYhm8VeGUAifs1JMDuptpLxWhZISf0iMDmwDPsjfqHJEcAEabcg3ZaPXvBgqfyr00/BoWGAB2XqCpWo8m8FXlJDYZTAAz1VfOG3qWV1RltvcG5sXaLuXHhs3FAZHUVjJ9F+PUgTCsC0A7bYBMy4071fUvZADosiq8seDuipTAmpJ22kXiufij7a7Aam/VbN9E4IxSyW1IbnWwcuJsiZuekLhLvsTczGaSTJqQZIcJJCG9H5FzJRFbaIz080lw92YjQEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UdBTS1HigHtgXwVOvVIbRPIfL6n/JIkCdS5vhvc260=;
 b=GJRgdbvyJ9Rm2jf2wvhp7Cv1mUr21SxqJ9Oq9lola4frS2APXENYyv+M/n18SsPXV/rqljKH8I0vrKL5CDFJBhQqc44O1w83ZiHZZJMwH04pHOGm5gO1WA/qdB0ys7zbmor2KTANgEEzw/RMVGFXylzTtykiAHdgqmIMCXEEDj8oBW8Dehkj11QcWDc7myKYfFLMA6ZRE8zp6lCvmrissg89OBBAJT1xGVyNJS7DvVZRn1ZsLW5UH/lHGcvPvD9LldPO5rYmdZmXlhwvhnfQylvZxS627ng0oAAtMfokMdFu9PNee8UcafBo0vH6G9RVIz2opNdRwpeCPRyCfii0wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 14:43:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 14:43:00 +0000
Date: Mon, 25 Aug 2025 11:42:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: leon@kernel.org, Dean Luick <dean.luick@cornelisnetworks.com>,
	Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 13/23] RDMA/hfi2: Add system core header files
Message-ID: <20250825144258.GB2070157@nvidia.com>
References: <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
 <175129745337.1859400.18028867979647760264.stgit@awdrv-04.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175129745337.1859400.18028867979647760264.stgit@awdrv-04.cornelisnetworks.com>
X-ClientProxiedBy: BLAPR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:208:32d::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: a12599b4-3c70-451d-7031-08dde3e5b071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ESaPNEyWad6DzV9gOoE7TITYNzqEtpVgCcmjTWsCcJfDAIH1Yaij4GTD6+yl?=
 =?us-ascii?Q?LoHQhM2LuGs/JWy0dswJJzar4GudxyUzd87iLk99R490nL4WExeF4OcBTuyx?=
 =?us-ascii?Q?9ktIyUxVqXfhV11EXbKrXCBTPQhE/0aJNBCnpg64vi1LEyBud3sW1mOWRiN+?=
 =?us-ascii?Q?OGM6wAY5ed+fL9BzEAaH7UoCFXhnsO0Q9/gU3qwUiD8PzKk0Ejo09yLEKOHA?=
 =?us-ascii?Q?Gt3gNnTvhJGck3ky2UCPrG04bPfmKxDtQfVBiGwqO5fLhYWBoRjasEw7/yuF?=
 =?us-ascii?Q?kf+faffzeSIFcZZ/8R63vSCZDoBHjSgrJ2MPeQb1aXwmnitcSkGrdqT9+HBw?=
 =?us-ascii?Q?Wklh3fPX+1CONb72Wy/GnNvw5p86iUCfeNJnuChXq4IwUvt6GJSONMgy+nF/?=
 =?us-ascii?Q?Wx4phb8PiLEggeEpyXDPm2cKQFoUI+0wj6EaV2fKTsfR9FokESmmrgBT0/b8?=
 =?us-ascii?Q?0TfzwdjfEKLbmu2CLfncm9+/VYi0XJYWuaJlRugz5V0q+UV8hM60H0951vaA?=
 =?us-ascii?Q?+GED7OGXFkabx5VWeQwBYSfdVdcmkoO0eeXqGx/f5GXbl1v9RIc2BIsG124C?=
 =?us-ascii?Q?rJ8jNf4cXZT9Xi9g7ojNFx4bu+u9JTd6poTTytyxbuJoXTWH0I79rJV70Ejw?=
 =?us-ascii?Q?/1BGhZId945EHGPd8o3aPzRTwXAKmBQPwwpiA6ge6jfkkI651WBVcwAnzFTl?=
 =?us-ascii?Q?rxoxr0rI9Hf1gwm38it9ULYlBV3XRl72LwARcvFOCfSTfDosHbYgzhD0ta9z?=
 =?us-ascii?Q?pbRaz8YFnJVO1Nc0DoQdpwMl5O5LERHcPT2A0lfeJ9NiFR7StfTY45GBZ6el?=
 =?us-ascii?Q?tpJiuulCK1AykL7KDKUeq9Uj2Awd2wk0iZ1mgnY3i4nst+bgqnmWU/i5SDFV?=
 =?us-ascii?Q?/KzA/QfuJltDOS2jSgi6Xiicvo5rd0juGLELt/lj3korqFxuYm+RrQfaPAh1?=
 =?us-ascii?Q?ja+9Px3t00s2ItDvnSrbdE3LgzZ33mctnKwtHDjUokGCVcs7wt9u7FnsWHU7?=
 =?us-ascii?Q?W5ASN1vuXjPGFbaWc1qHwkwMCd9mkSHUlz0tvlYLuZAiZd9eHgdW1UShJxoT?=
 =?us-ascii?Q?tQfKBfXoB7yDn5x+BnDejFQPwaCkC1FRD8Fy46wCOharkWRjlLmAHRxhs14I?=
 =?us-ascii?Q?r5dnu8jutaynR2DXSt6UYQ+Prmwpx9a45WXz3T7FHgejedp5PE313An1RpH5?=
 =?us-ascii?Q?Tc+7OPVd/SX3FNEjnzWQB0dU5UCfTMcypPVidbtCScNQMc2k91xMVcP14YaV?=
 =?us-ascii?Q?cfc+yv90W7GV1UbXwmmw6LWpsErMrWtULGqcHcQJjNvCzMVDIGug7JcKtGPL?=
 =?us-ascii?Q?lMB9tGjIAVNdr2wmPw0LJj2dRBQhqHPBkOiRVPrO6qNQHeOgnH5wrWfi5aG4?=
 =?us-ascii?Q?nMtvNvvq/rScZarkCsY3ycJaZwnqZN1t8jrIOMtTFs/Uy+iZAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZUTWAAHkFr41EsF3Vl2Rt6VuVcB1rJ3I/K6AvlVPI3a9OPzRjMza1BiNSoos?=
 =?us-ascii?Q?jfWn98sH7j+6PrYB9ifAhvEa6fs0MRKgrAowjDQvC0KnkMa4sIIz8HS0xtdX?=
 =?us-ascii?Q?97olHbdzN5a2AdF1bPkmCR59fo2tTDjGRHtrvcO+goMeBcsL0B2JvNJtcn5n?=
 =?us-ascii?Q?t5DEntBXb6O8fpleUmOY7t65mAVdcDeVzHLUq0j8lzAa4vnWfH2JOrd9LRoC?=
 =?us-ascii?Q?2o9QBy5anZ9cUNtqzo7VPs9z3J+yUPXPALvDjbyHXoyYcm5KZS7OOQbgIwUx?=
 =?us-ascii?Q?zyWpOAnEeDOcmNj8fEcnLvaHCWaIzx1SlWuklQIjfbZOAbFdqKWdE9OxAkkZ?=
 =?us-ascii?Q?Upu9cZ1A4Ah+ukENgSOquU/szMpA9x4bL5gEWalFV3AqvTnBnJfBAcd8CiW5?=
 =?us-ascii?Q?IBrHp/9etxboBEubswILZWdwIK59OChFk85bGbgb+DsOqiyvwYLk8TKfWDzp?=
 =?us-ascii?Q?g5J9ckx9Klwg/NpvpoMbZJ8uEjpnP6bZ70LVKUPAGJLjp2fk87JLlgrkYwLf?=
 =?us-ascii?Q?qJNMUguZRZDov5nz6T+9XsXAvGlcrYTdRQ7e36LjOA2jOAOxjRJx28sxAXm7?=
 =?us-ascii?Q?cmYGa20xI1WMATQT4Q6VHuziffGK9jjFuOqPLnpkJ27I7LJQXIqwoX509bqn?=
 =?us-ascii?Q?mJW9xe5MfPfQK3RF2JYzXUft0sLA0nzcPqgbH57oOCLXcCiSf2WmzyMNzFfs?=
 =?us-ascii?Q?wm/QpMHWUu0AHqvvPuFOpty38O5vao/po4hx7WxTWXT0A2K+aM9WpGZ+/uwW?=
 =?us-ascii?Q?ckDF7+brRhOGvKJOixbUJtdmXCWyFcSf848z5bdYiDj4XKHGiIdw5r56DuMg?=
 =?us-ascii?Q?xdTLw71kWmcM4UyR05T4wNjnkef6BWMLGK3JaWm7PI0LsYC+fOJJF/2GmuFB?=
 =?us-ascii?Q?WC0qUhasg0UoLZxrhlx6T+QY23Q7M0FSST97/VywTcBVOLFfnyD1FRQrIWUd?=
 =?us-ascii?Q?LXidhA7zs5AqQafiVkzTYeiN3CBWGt56FPVK5r3u9J8mEApBU3RNJzbIKC2p?=
 =?us-ascii?Q?TydGf9zWNb7zY7PMCPxdKC4043wC6w3nG2nurE0EyZAnLKK7VL2vYoPPSCuG?=
 =?us-ascii?Q?hTzY6IKddBsjE221QY8uh1Y1lGnOVg/st86Qg9RcP69tRfPl8i1eLkdLNadQ?=
 =?us-ascii?Q?kPjwXCTtHQfnPcJX+KYPn9z2l3vHpoHB9eAMpvkPmcnAOJuADzDuBsSOpkUJ?=
 =?us-ascii?Q?ADi9njAAjfc7aTHfWtUY2YxUoEk2Xq1ugBm55fWadtEVJi2Xmgbsv5rBzA/T?=
 =?us-ascii?Q?0bOd8/kKIRuMFKkhXmSbbjq30m3ndvkzoVJvYShNjbp0iZdrDQ/b2/wWdlbG?=
 =?us-ascii?Q?G6lpW9spVWQVE4vaPJjMP2Dwq5MmJG+m6pZn0+IZWgbHAXmR1+u0keGUu2rM?=
 =?us-ascii?Q?l4AJD5ZoiTEiP8kk3LcOYP2mDlnLCp/JLt5cVLgEYbIOBw0EQ/u/6cYXRbVo?=
 =?us-ascii?Q?/yd9/8QTnNcuZ2rP3UsEZWRl6nXji1LStCu4M340zXvgJ6/yPKBuUp0pU8wV?=
 =?us-ascii?Q?FChzAIo6mBGeRP5rQH1iV5E3P1mbc59NJv14kd8nxS0Ov7hLOMlhwea3n7cx?=
 =?us-ascii?Q?ySASM2JTRzHIoqZB/Rg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12599b4-3c70-451d-7031-08dde3e5b071
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:43:00.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bqbtqif22H871Cbg390gdbsIWCHFRuF+NWE4/d9IPXr27NLZtzlkSe4bCZOPPcjM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407

On Mon, Jun 30, 2025 at 11:30:53AM -0400, Dennis Dalessandro wrote:
> diff --git a/drivers/infiniband/hw/hfi2/device.h b/drivers/infiniband/hw/hfi2/device.h
> new file mode 100644
> index 000000000000..8948b9a48ac4
> --- /dev/null
> +++ b/drivers/infiniband/hw/hfi2/device.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/*
> + * Copyright(c) 2015, 2016 Intel Corporation.
> + */
> +
> +#ifndef _HFI2_DEVICE_H
> +#define _HFI2_DEVICE_H
> +
> +int hfi2_cdev_init(int minor, const char *name,
> +		   const struct file_operations *fops,
> +		   struct cdev *cdev, struct device **devp,
> +		   bool user_accessible,
> +		   struct kobject *parent);
> +void hfi2_cdev_cleanup(struct cdev *cdev, struct device **devp);

Seems like these are never defined, should be cleaned up

Jason

