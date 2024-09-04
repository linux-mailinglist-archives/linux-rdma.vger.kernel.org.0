Return-Path: <linux-rdma+bounces-4756-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 513EF96C3DF
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 18:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17C41F22286
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5B1DB55E;
	Wed,  4 Sep 2024 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rBHH9PRC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE1647796
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466725; cv=fail; b=aB7Egvj6Qx59lrekmrt2I9+jwEH/mew8s5j5/uLgSbKA7P80FzCvu5JqBeW9dvfTNts0JLe5MJMaXfnoxIqkT2fJjNn8xqTR6w7blEZ9T+qt+yI0Gf6OgHfigkOS8tggjpLGrruKOfKQTDzzIWrdsDShUoW9fZz/bGItJZ+ffiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466725; c=relaxed/simple;
	bh=umVO+Q+H4woF689eKLpLUZD4dIAaWW/bj5Xs/txzh1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pOCdMrZdC36fS30Jb/eS3E9YbKIlRdNGNIWJ2Q2fCPS4XKoyEh/GP9ptvFGRQrdJs45DJlZdjcpKOPsa4ZHW5MAjEQNkpFIAZQkjYcoWc3nHoe7R0y8BkPpUH9lf47ZqpICVfWifHefyayTT4ijnOVP1Vnh6ic0az0wNfsHMgwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rBHH9PRC; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBvdIaaUVz1KlxTqltri1RoyUEWKstFILmyRg/NeYYf7kEJrpTfoctfJjLXUJDVYVGvCac8HWcRy11sZTa1/bQkHxZayflmeBfAKKwvplCmkqjPEI+EpmGzOMUIzf9s04OH0dR6u6F7uQyyRpsX5wjxHJy9vWtxxOfUf4H4Em9tNCl8qLWAbKhR0fNXOsSXtoC7jzf4jHggz8Cz8z8HeWw0XXDVGti8JLBxi/vHXAdtswkP9aOcep4OkJM2TG0glxb1uypRcabtGgevK5ZRGm6hDj0k8r0Ddg5k+9kjTtiDyaAWy8o3QqUp9uZEG+D43Aas+95D8y1nr0li7h78Tew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFJvYioU/kIXLE1ala7GtkNvHndSImG0ljlnBtUcSPc=;
 b=OyZ7htn5kGoMlVUXDQO6y5bZ27hnTNKZSc4aSCv8zCRyxg84FPRnKZ+EJiuOvE+VjLbjggtGaW5mrV7Hke/cuY3ocySaluQSPTt5wXF92LRd2L2QrQ/fL8U5GPdOGTOE1MCjd6BWI8DwOJTLoM6eTdf+6WyP0mtofiGZbBy+k9qRpGSNu85xbE8GyUE1WQKE2v+2y6Bweiact5yDDFyv4bWUBp8Ym1tZPvsYlhXdxOrP0dqDf00eK6w9jC/eVRd05U7fH3PYfGgh83duVybrtQKeCBgCSMqErXkYV8nG1FT8lbhJQTvbm96EgTqvNqzw9NkeVsu58j3E8zT2bT+lYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFJvYioU/kIXLE1ala7GtkNvHndSImG0ljlnBtUcSPc=;
 b=rBHH9PRCg9h3Dd5qvBi9Y063VI4Mk1nRf5gyx1Jty9QzbNXmef1zqXHDwO0SiesexzQ8GUzazFCo0F6u602e+S0tuWd8/vkNgjU/cbr8tSuNEyYG3p5bgft2QbVGkw4RvHBRbqMnZUB26cgaDSLxGHz/KAWiEeAM3PF6KDnosUJ8gXofjSLI8hJ4PxRR4aLbeLxY6fpGB7AT4SHdjty4vLAO0UuJlBD7k3IyyZB4w2i+Cr9nBb6SKDJKJkLuS68w6bjuSCxrxAGyz10i/dnXfJ0JPJrMH4EBolgzmOuU+SfYWHUI0p5nROIark9Mg4EdFEt28UUgRBuT8+uTs6oYTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 16:18:40 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 16:18:40 +0000
Date: Wed, 4 Sep 2024 13:18:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Guralnik <michaelgur@nvidia.com>
Cc: leonro@nvidia.com, linux-rdma@vger.kernel.org, saeedm@nvidia.com,
	tariqt@nvidia.com
Subject: Re: [PATCH rdma-next 1/8] net/mlx5: Expand mkey page size to support
 6 bits
Message-ID: <20240904161839.GM3915968@nvidia.com>
References: <20240904153038.23054-1-michaelgur@nvidia.com>
 <20240904153038.23054-2-michaelgur@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904153038.23054-2-michaelgur@nvidia.com>
X-ClientProxiedBy: BN1PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:408:e1::32) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d246308-4d51-4c9c-fcfc-08dcccfd3cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ztjSdNmFVG0qT4TDPVTWhe3EfbiAE57ZBhjOTA4+FfIw3B2XlJr+BFPuIqzi?=
 =?us-ascii?Q?L4Od43eM+ZsLt0c3YHCArKjbgf6T4Y4Ux1kr4QjghW8skHBEK/50JQ3pMvVI?=
 =?us-ascii?Q?NthTep3/o6jk6SIIEwMbpry7GZLSEJD/ilXAxe1ZNPgAEMkV8Z711b3vByxb?=
 =?us-ascii?Q?LiDn4F9ZCbCk1ukbcIs84F6Lvn1qmFsDHHilQDqJlu2h/9seXCRuD5cCCbSV?=
 =?us-ascii?Q?UIir/65sGQ1jsjqzwYuBOFM3eXib3f0X3oAKZ2jFfqJP+AVpJGTK+O45gJjx?=
 =?us-ascii?Q?g5m6yzmGLkmVsTKY4wuxbubt+T2+Nv9VhwTEVvUxxi8PMy9DuD65VkzFSTyy?=
 =?us-ascii?Q?GKVb3ql9XasqrqlAsaf9CQoQLutABX7mhCfNbHDWrZABEIwzzZxuxn+DjJVO?=
 =?us-ascii?Q?bxIG2BE3MHZ46q0r0IvbI3izGPagHACfOdzQacmGc6enU0CSZOoXzQ9/6c9W?=
 =?us-ascii?Q?3uJ8JjLziymdWR0qKYQw4Y6L1/9DPq0dmS5tmK8RWFFjeB7DR/xaMSkFfJLL?=
 =?us-ascii?Q?RBzjbXHFhVnT9GJfmyfBJOIUgPo2UpLYYWyscRHvwZRUTWrezdUVZmKlDhQm?=
 =?us-ascii?Q?imGxIR8BEqTXrd+PF7x8/EuI7OKFUrM4/P8zj2gA7FI7Hl8Xrx4NKk/g3JbS?=
 =?us-ascii?Q?udST59tTiRO1xMWjtztdoFoecMIV6hmtQxJrTPXhzLkXZIgFtinXkRP466Fk?=
 =?us-ascii?Q?F0QrPYeGjnME636+vJncckG1Eq49i6GnhKq3yKqZbgFRXvK+cmbEUs+MR59K?=
 =?us-ascii?Q?VeVJfomPgktb3xxOcGDbU1XNh/ZUsCEN/rDyupofSFCFSLtypSkKtOOwRWU+?=
 =?us-ascii?Q?eYuSdnmC+F+UYrJTj88k8JJkMI0iWM0b0D8bU6hPhcONKDmgnoIiUdMP5lLj?=
 =?us-ascii?Q?/GJAWrqea4rDpled2+1yAgxf1ePHJTItCPugspqGEfW7Nj+0d5UKYa6jbw8G?=
 =?us-ascii?Q?5CufbA5E7PhO4Po0AgvpP3gPSFGFWLkjaXLhA4l0PlNq+R1t28d/uQ7K//7w?=
 =?us-ascii?Q?PFld24Yr8XFptPgto61mpUelcmBi6FNvjjJ1fjcMMC3i5LtzR94IqGN7T9Fn?=
 =?us-ascii?Q?hTtI6sW5fyHJfTgGDHWDxEt9EivP7xovVL5m2daTRdtPFMlP1TC7R9BeAFSU?=
 =?us-ascii?Q?CADNZBVyXNK1qZCHumLa8CBzXDcVg+337mo1dnbaagmFqF1bXZbrkjBIULPt?=
 =?us-ascii?Q?CDkjXulXYvPCCfVifM0DjpJJEI2N84HggepyIiClHMJ7Tr1Go5rrN3K6ok5F?=
 =?us-ascii?Q?Jotq8dnvWKFAzTSMIn+mlSLOjpk7D6IXsx82UKtn5XW19nXnLpa/RgYTWFgg?=
 =?us-ascii?Q?d8nC5Pcw8+fgrP7Zszm5TDWvTwU0J11qarkiuJ29nGouWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kHssPhbskV1p0o+A06yctqbLGykUFvCS+a3cdI6z7oDnsY8BnapcLckJbYKB?=
 =?us-ascii?Q?c06XhEBfMTdHfig2VuEY3sylSSqeqWsR7Flg61ycj582Yn1u3cRL6vUXo2ir?=
 =?us-ascii?Q?fd2vCqQBG2npl/xs5a9bmsHjSPhYRWcxD/Uui+JBE9gzcwFoyXrHp0djC14a?=
 =?us-ascii?Q?mWak1xbvdO4zOvHl/g+9vntvYB5umbTXI2gPsBolUr/ByT8gqJB2hpzG8dBG?=
 =?us-ascii?Q?0PcsV+2h2Nvi4c2L9BstmZ1U/4ud4OQpWcOt8gJQgrsiuWFC+BZk/N6wqtJZ?=
 =?us-ascii?Q?qvEp0uB+lXa7GzJZ/qnBXy2j2VuP8bUQGvS35Yq2CRlvWIMXjfboaCB3tBMN?=
 =?us-ascii?Q?LobtaZItxXfhYnCRyJkrIWvUt99W2u9JUWXm6YtUAK5txk8PmBDdHKf1vLf7?=
 =?us-ascii?Q?ATqACl89O1bjayiqNrzKGUkduLEjY49BnSSEXc0NZSlMAA7M8fBIJgVRVcnU?=
 =?us-ascii?Q?jg1KFZnPAJ90ExCFT4BMFf6Z51MskNC9ff7WElCYPQ/otbAzQ/UgDfYTtwPR?=
 =?us-ascii?Q?RwZd+YAbbRjjZ74SVh149YY4tixwO1Qef2LHmWRrtM93Xd8tidz4UWBHiht4?=
 =?us-ascii?Q?9yEg50DGFGh0mYb7eAOS74/ygqvMgpy1V61+Lq0EYKToW25ZWek/wpL50QvC?=
 =?us-ascii?Q?cXd876q/FBFEWjiprfBVEvtmUnLRxEp/K4NOoyVO9QoAOhIT2w5oBNj/BEYc?=
 =?us-ascii?Q?UKbTq5zDiKCCYD34bv2J2QtBCEbos2dADAilq/lj0IQLKz3wj+GgkAcB+nBw?=
 =?us-ascii?Q?CNEsc5gbk2P2BRB9VMvT57ZLJnEyMNWTj4JfuEuYBkSmPUqLYi1ZJUxwwlck?=
 =?us-ascii?Q?Yyy2fXVCn2BqJQf8ks0hH8k8snYRAlUZe69zD3K+mxamQySJc0DFlIlQppnv?=
 =?us-ascii?Q?x1+WLC6JCXdLY0oROpHzQRaQpXSL8MKXJhJxPUNG5XyQItVCcJut+cwUS1OH?=
 =?us-ascii?Q?mJ54jYUPu6UQYmCqhX9ibNQOI9k/embxpUlpRPbk6wKOBPN/WhtW3KsAG1x/?=
 =?us-ascii?Q?PoKptTZQ/zHWw1ahCxpw3KSt+CT0v3crMZfvTgBBk/+euZFiUJL3jCYTBUeF?=
 =?us-ascii?Q?AsPpQaVs5JfgGj6tNrw5isj2MhQJtXH5qu+jnYc6F4TmSBO8GezvkAYQ+5ZJ?=
 =?us-ascii?Q?e5XJq3CCGx+2+No8SoWkKuFyZ7IKjGlHm8Tk5Kza5/FHMz7HqRQAc/Mtrwsk?=
 =?us-ascii?Q?S59XI3Ssk6kyEOZgV64BkHb8pcL97QDRErinINxuCl1jMwY0aUi0AZMAM/fO?=
 =?us-ascii?Q?P7QsIzyXk6Od4yk7SFA1NYBWMu4eHcYG7uRqiO2dTMe//a7o2BQ/2wyxnmVG?=
 =?us-ascii?Q?a6u2ZUGVPvv9Z10R19WzHGvr48NvI8EncB4McRjQn8gvRnY36STwNCW+Fryl?=
 =?us-ascii?Q?DlORbDHtnCZ8WlyaWYsBfYdu9uHwDp/ctxI+RcU12PZE5SfrnKBFYEVUQ03G?=
 =?us-ascii?Q?y6rOwkWm5frRjgExaXwkKH9jRB3G9+bz2uMgFT3vs5xNVar/9o7L2vMBYTnc?=
 =?us-ascii?Q?vr88s1IvyBloV637tEOYFn0OTg8b4ILUU+rDd5JsJH3PvL++MYm8K+xdiIr4?=
 =?us-ascii?Q?Hlr4SD2Pskx2IDVFv3eXNPVKGSnrF1ln+c0KO1cs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d246308-4d51-4c9c-fcfc-08dcccfd3cf8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 16:18:40.2929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxmS8Kc++RC0EVryatxcXHKbp8wC9VXqalMfHl2XWR8vpqNQAxt3WiGc70JlkjSf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607

On Wed, Sep 04, 2024 at 06:30:31PM +0300, Michael Guralnik wrote:
> +#define mlx5_umem_find_best_pgsz(umem, dev, iova)                              \
> +	ib_umem_find_best_pgsz(                                                \
> +		umem,                                                          \
> +		__mlx5_log_page_size_to_bitmap(                                \
> +			MLX5_CAP_GEN_2(dev->mdev, umr_log_entity_size_5) ? 6 : \
> +									   5,  \
> +			0),                                                    \
> +		iova)

This can go in a real static inline function now.

Isn't is mlx5_mkx_find_best_pgsz ? It is only for mkc right?

> @@ -4221,8 +4223,7 @@ struct mlx5_ifc_mkc_bits {
>  
>  	u8         reserved_at_1c0[0x19];
>  	u8         relaxed_ordering_read[0x1];
> -	u8         reserved_at_1d9[0x1];
> -	u8         log_page_size[0x5];
> +	u8         log_page_size[0x6];

?

Why is this change OK without more changes? Doesn't it move
log_page_size forward by 1 bit?

Jason

