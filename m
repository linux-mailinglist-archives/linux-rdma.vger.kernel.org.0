Return-Path: <linux-rdma+bounces-12146-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3339DB045A2
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 18:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818174A7506
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 16:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C041226136D;
	Mon, 14 Jul 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hg9bIS9g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20925263F4A
	for <linux-rdma@vger.kernel.org>; Mon, 14 Jul 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511198; cv=fail; b=gqsOZAssW/0zFk+qQSjAYMcO6r/apQLKDD6GF0LsfnNB8vR3C30+Qf+17Pan8fAfm6FKS1Y8qE6yZEJc1xJb1GEdi6Nc6SiZm0CtH3XR3K80anaVCHV5tAdaFC7MDo7fx2iTGtxZbmw79z3P3e6gwaPEaCo7azmiRhOMZboclZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511198; c=relaxed/simple;
	bh=JkHglm7ts8Use+UHBdpNIr4idGSJG7eiXMX+Vq9vsYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DE5jLla2iaQqLDiNQ3olYKrwIVMjuF+8ejLYZuw2M5qr+ISvTtgZVjkq545wFNJJEQI1ShlEFwpEBUxeWXPG3IFuMz9Ykc4zlIbkQFIf4uHKUiGByESZLej74vOc+wbIo/9BJUVxNnbIrwscjnLJwO1zEp1CRJMCKBAltCrHzWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hg9bIS9g; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL4z1EtDcCzUgCGzBSqP86fDtGQxtn5pFoQCpwqX2JVtZ9XPnHDDa5ixCwJKO+JajoXLmarNj9YKDXkTUobPWOs0Z7GQzJ7eaVkCtPDCWzgM62oZyjXEYMwhNhvW5/7A3Iu8PaR3+N/1pmI0p5Wc3KEqFTa6W4z7Z7Iv3POj+5mg0RR6PBz21zbrzGzCUuLmSNtHE8NkIOLPnDKyRIN6C7GcALceVpG4HyaRhTjIDjpJGW0AoyPOlMI+ckmNxlOopiMzVQbN7zCpvEOSr+8lvP4TphjPHxDRcgM+rvSSoDyKN6ka9Sm4ryuGT4290UajmP+vq3RHpBoxkNmCw1dXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AT0rdYbLWyfeChEhX/jmZl2VTSzo3NvB9WyV4eVjHKE=;
 b=Bae5i/mPg3CA+2Nc4jRzkt2VY+KoI65lYOTQp/+dzT3yq+Wpmt3g2lnTwgkt8dtnSBRqzn0vWNt5Ry+x10utRqMvOPB05bDAGjI8qohtCyY+Mmt2jkedsiCIPQfEqKhbCAJIKIm4+snK0LBvz3w9/v9LLHZwfEA4Yx8uV3FHxg0j0BuNHt2aIrQsP6XM95ZghG1Y32sxrSrJRjtszmImKhoP1LmKSs6/T9CJI9XOfToEiTtCIURH2CAixOeLRg7SBej0c3jHC7uRh2AwCEJ1AmpRunPFfFDBMpK3V72tuIHTeXu2oU7mQy221vCxBAkSM94CM0FD4Se8crNQ0gXjHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT0rdYbLWyfeChEhX/jmZl2VTSzo3NvB9WyV4eVjHKE=;
 b=Hg9bIS9gknN/zN8huni3B8z3Kmq9cZMh6YFQiDmDCKgxFNU+SPnSzHnPgcR0aW3xncb2gTg8S0YDapvYJF63RjYPNJq9lGVXDYUC7Jsbf/V25uQO97MV1/p28ZsFUlE1mBgAwcVS46hfeHAhA4yI1f2Izn966vTRxMo/D41e73E8lqPaybFCPwEpkl3bNWrc42tMTx5HPoSDH/ysJLzOlEr3RVjwmwacCL7qn++q6MlD5BOWH1NxBzuRU4YaMwO3mKZC1FaOFZPvUk/m/03bEsxjm//l7jJ/DTJ2oUaOzjpM51Pj8LkBz8CMswaCuHwTMswv1KF+hCLYWkLnDIgcUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6524.namprd12.prod.outlook.com (2603:10b6:208:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 14 Jul
 2025 16:39:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 16:39:53 +0000
Date: Mon, 14 Jul 2025 13:39:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 5/8] RDMA/core: Introduce a DMAH object and
 its alloc/free APIs
Message-ID: <20250714163951.GG2067380@nvidia.com>
References: <cover.1752388126.git.leon@kernel.org>
 <b1ff9b142f785a52009b288567bf4e15dd34ecb8.1752388126.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1ff9b142f785a52009b288567bf4e15dd34ecb8.1752388126.git.leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0399.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 1767d357-b6e1-43fc-ca21-08ddc2f50ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C4TH19Q/WQlPGGf270/YwGAPf+YQdxOzzW+8IKsR3pewbA4y3Bbop3kReQCX?=
 =?us-ascii?Q?tGRLfiu+V83SLamhlJ5GKtEMAZ+AepndOuFst7wZ66LOGeQuz5zglAMzYgUo?=
 =?us-ascii?Q?5mYuRLTYJGjIRGf03FbMmmtiA6l/QNlGLYQjsnAB6tShDOtNXHmbl/V4x8jS?=
 =?us-ascii?Q?VlXfgW+ON/gwRLJspFl7nxcP3UmeZWFDr9gpONkHmfdTpZUUSu3bpKmU3IOG?=
 =?us-ascii?Q?c8YbZ2kchJo7WhUTrURGKAQuYtoDLAnuIDHk2PTpZX/phWh/AN5T7nZ9w5id?=
 =?us-ascii?Q?L3Z03mLupp6BBsDkNrWmUqN3LhhUkdUh0HP/uLsjy/CXu3jgcjQyFPxUvkZn?=
 =?us-ascii?Q?ZYAsjtT8Ujss9m5Ikj3Z8wxeHCumFKWegxGyvgpAheISHbW0TG8u/vc59VW5?=
 =?us-ascii?Q?SWwJJ8BwABcsZ3wpKp5z4Z/pHR42k1Unf6d3WfPbvs6Lq9puWEQiQ+ns/sp6?=
 =?us-ascii?Q?TZDFHHH8x2c5uUkQl0jbrDx5sMY9XWBHvHYwxeukvhe17ikfzEljWVnGjHuH?=
 =?us-ascii?Q?g+FimFdV/Jw/edQe4byKIvBOVsu4CUhZVVA+9woP0AVxr1NDPnLUt2Wz+44Z?=
 =?us-ascii?Q?plPgMA84QTBjoxbDGKEFICrNlDUmNjhipTE/JhANkK0qEOSQ4+mSSouNUWqN?=
 =?us-ascii?Q?EPrabVMWKoF0Op8WZ2Th7o68AdaSllGU4C9O8aeH0YeZUG/bTKQIQ1WmGJSS?=
 =?us-ascii?Q?y0k1rsYodKUeceN82BzmGTtKt3XahIAIviTLytvWOEr0EPfiBFYX0RI55rB4?=
 =?us-ascii?Q?/qQEMsevbQ/5YwtL3y0XF2QmaIkTFD2j4XyQ17Dr9dCv690G483TH0reKTiC?=
 =?us-ascii?Q?ogHDIlGpw6E/5trYnefwKbzsZYgFJByrl16F63VhUPkfJz9WnboeQtnYYJLn?=
 =?us-ascii?Q?96M0o5Iylu3HoIAhq668RWGIoYrfOK+ja0d+j5pmwZtuTr0Al8ld4As5zKTR?=
 =?us-ascii?Q?vUpPgYaBLLNzPdPn6gmozkm4CcVRVDu8FY7m00BlTIBgRCmUOMDlHKQMwQZA?=
 =?us-ascii?Q?JOO+DkChckdjS07Kidy+/HUFPLiFEbuGePRAEY9X4LkioJY8PjTMqaJhv6DN?=
 =?us-ascii?Q?2b5AMozJpsg7B5Mjxt6lYfuHhmZo4n/ia2B2G3u4g+9BRLhUKyagk3zWZou7?=
 =?us-ascii?Q?Nxk96dY9Naq4xiFVnK3fjwr0T2tS1aIYNusX2dsuINhEMISwfR9SJLdmo2EA?=
 =?us-ascii?Q?b9vSlLAvXXd0ulDfMuRBmAQTm2GBrUleig5ehkwMDg0AlsVYeFG3ZGtESINY?=
 =?us-ascii?Q?Js3sLToNfYyExy06m2yoH1ZtJsZhCWi6QtdhGoCyKgAnsYRKN6QiArQKX0kr?=
 =?us-ascii?Q?YDy+6LY25spH7WvZRARHWZ0mD5ip2MbmN1y+C38dqn12hYFraVRg76Z0ablG?=
 =?us-ascii?Q?E3yhEy7zSfCsyNmolnrAMpGtkTgjHdY/Q3do1mD3wrjGQpYrmfy7mskkKezn?=
 =?us-ascii?Q?8DLDv9xjXww=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nalcxmFyWDGs0QTLqxP1LFe5p5SymCe5h+Rvg3SK5upmMnPyF4royB28JEhu?=
 =?us-ascii?Q?NTWw1fUVrhmK0htDGZHjm6hVmmOyT1VkWfrDCIs42QhCc0lCJznhmWfrzgc/?=
 =?us-ascii?Q?Z4jraBy5hKEjYM0WV93x/Nkmkkod7ecCrDAeioPMfaBpjVHwz6ubLa9icTyP?=
 =?us-ascii?Q?4EReujxsarZd3E4Qz1JD5dtq+w/fWMGkGrJrAisWzLaAkNdZm8pSw6YLitHj?=
 =?us-ascii?Q?rXjPSXEfxVciy8X1slzArKDumk7tVSk8wB9I3zCjMtutM6GHtwbYP5DquLTM?=
 =?us-ascii?Q?z7Tra7yA7h7akfq2aFUDuZdai5AuKAcjtX/JAgsvZ89ie2UNe1HXJm4Rps7X?=
 =?us-ascii?Q?owPGMzts/lUERxi6x5w309KN+OGWb+vjgCj3kvs6kxnrkFmLXlZFxhPGF2Zz?=
 =?us-ascii?Q?C4Czgf+l8fTTAjHJXqiwlrOpzPA+Pf9TE2aJYx6xHGDq8eAbGDq1kk2sGyo0?=
 =?us-ascii?Q?o0wSfNvawepuXlDFlbfsCHVJHnBqbfHLpBV7Fv8GG4Zy3D5dqbPFQdRE5gFE?=
 =?us-ascii?Q?d/BQXgc2QEwycir63q2UETYE7P2OJG5Ui9mQrJq44uTvbJ+epgwlvtkRNZv7?=
 =?us-ascii?Q?S4iUkp3uovKNMw6Yr1Yu8MT/8K9uqevysNxZ8DMs0aJH99x05OPmWRA7WcE0?=
 =?us-ascii?Q?17a+T9ruizm0Ncxpn2IxM49eD/4TW79bLMhPccZCBnl7rkJesgH+P7HeO7O+?=
 =?us-ascii?Q?aw1p9T+1NMVEBeWQQFnUbVjtHEZbqcVX0P50YY/SXI2ImexvTmP/0A/KUz9y?=
 =?us-ascii?Q?25WEn3f1NAIQY7UohluV2Mi/MyKnnH/foMk8go9Y7ONxGRLjcLHdmSQEza7+?=
 =?us-ascii?Q?OTWu6AGSS8/JBOwY+065HPiS++DQMRSAPqEC+N3e9RETnIp3dQTX2xhmYfdd?=
 =?us-ascii?Q?ySSTTB5z42KxqCYFSVc8NIWvuKZTeyaLUqgTIz5VFG6Q+jxlTWEvcIgUJ0WS?=
 =?us-ascii?Q?/RfJ4VBFYMriXA6hN0Qt3NT95OMeauMgc794CmDGJ7kvruqvJH6gSUKs6em8?=
 =?us-ascii?Q?Ufkp6fyEoH9CF7Z4wt6uLL+owrICnb9wf4tybb2mam6+swWebD1ED75+6X5e?=
 =?us-ascii?Q?vi5wAmWxVi3XgJNwRjhkNG7JqkvQLc/oYyzQqNmUoLd3wwS1xdkr+BqoNcle?=
 =?us-ascii?Q?gQ4rqJYTUwWqDF7eYvSa4OuMvGg45ClTl+E8KJWhnYgYjTWloBf1OGrJVi97?=
 =?us-ascii?Q?dubBR7gVs0ElKL0HUFkEpRy606l3WP5kVBJ/EnBnOCPEv5FzvAoBYX/lpKiY?=
 =?us-ascii?Q?Q8qhxoVXUXa5Ys4GzjxKb70FikVyL8/ZGJmNiK3YPjZNzTmt1jGuk4kHVpk4?=
 =?us-ascii?Q?uMHdPEqaWao86wmr6Bj5p3bsdyhqtmHFtO0JnnkT2lk34PNO3/OMOvwAeMw5?=
 =?us-ascii?Q?n3xpvcAuCXzn42YT+35TRIQNWRjYF4CSd8l5Y0SHfj8Qv1adfY26lmRXiBbq?=
 =?us-ascii?Q?Ua+z7gGEHnjngh/TOcS07W+zPoaU/nNAr/mEM46GfgSbUgXPm/nGXQaYE7rq?=
 =?us-ascii?Q?hrsyh4n6rBn6tgeDqmP2vaME6wDeUaTw/x9yIBu8mYgDw+PldVt1K70S0YEl?=
 =?us-ascii?Q?2OFwqOkDMiD9CEPX/gQXgV8P8siQUJK5u9kMYcde?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1767d357-b6e1-43fc-ca21-08ddc2f50ec1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 16:39:52.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qj2sh7NXTsH+ShdiU5Qz2T2aWlyoWpI2K6YveMNQBBIzkulTCUTiLRBDDM2yI/RT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6524

> +struct ib_dmah {
> +	struct ib_device *device;
> +	u32 cpu_id;
> +	enum tph_mem_type mem_type;
> +	u8 ph;
> +	struct ib_uobject *uobject;
> +
> +	u8 valid_fields; /* use IB_DMAH_XXX_EXISTS */
> +	atomic_t usecnt;
> +
> +	/*
> +	 * Implementation details of the RDMA core, don't use in drivers:
> +	 */
> +	struct rdma_restrack_entry res;
> +};

Also this struct shouldn't have so much padding inside it

Jason

