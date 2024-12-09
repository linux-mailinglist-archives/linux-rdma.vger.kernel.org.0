Return-Path: <linux-rdma+bounces-6348-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D46F79E9FB4
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 20:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E76280E72
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 19:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797D4194C6A;
	Mon,  9 Dec 2024 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KYkJx2vg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8BE14E2CC;
	Mon,  9 Dec 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772850; cv=fail; b=SRPn3mK7zaIaWF6fIYBAhVLADfneVwxPQHIQnygrg0tf/KGK9Axe7jlJ6Z/PFID+bjPykRyt3Sl+tq0Gru1aCz6EYlbDJ1WPCV9X2z3ccBFRB2rVRGII+T5gzDZOhmUFGg+wQFmgCMQ6Y8fcjOVU0T2TNTe5yd+qGe8CDOOo+U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772850; c=relaxed/simple;
	bh=lWX2DiQHUzfoOoIzX6k/Wxn6RqyeKuJsZt/AH0AvJmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oK2TeossgR6REXdfdXqlnnK9lO8QT2+ar7iyoSEKEFA8t8bMp8J+xzryae3gtCSqGqDYeCblLBjAcZAx8OwjoCoNDNHuqDEb5gWzYOBjTOGu6287uV+F8rw7sXWTUAj74C670LwJVyo+4sdoXBxTfzpmZxR54bjHSwhrpVWEJFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KYkJx2vg; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9UkqLVSM6LDAuoo3EsodgOWzLY7+U8MHxcwvB2F/tM/tmaqE4hPN751O1RD5FoUrDuyS7Xv68NeFG5vtCp+sQokUaliLhqa40w6bpXCkq1yO10kEOJvosNA5bDIAl2DBPHhowX3kTA9ItVDBIimvcUg2k2IoIlxNX08lC7dqvKPTBrr/xw7yVNVnw+9RSdzPrqWjFiONEfZ3yDgBxzzh7/pV9VkHVJ/Nf9nl4TwvMMLA0YS8J/6RvEjR5bpzJNgnJCcMbBsqwWVukFARepXijZ5pcrRTo4BNBz6qLGq6POf/ElxjEbJ59zTP1QOIMLZeuDIo3un8r4tI5LrZk4fkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmjOAfa3cH4j6dr9fIEQSSO8K09hGsdNZ5MwmpFDl6E=;
 b=JkN1+4/wv/hBpcTV1pJpCIWyzV3UTQrWizDyT7IzrE0ovm7C1RhNrPpAYeC4oaIPjapbCkBSg7RWGoRBZSaLW9Vu650YqhD/kzU5VXygqqb65cP+hOmYmZxCKvLABH7I2jAkR1HgfmjGgBtk0aRRdW4XXInEfpTUNhT3vDTen7B53JomfsibiIcH4qjFfOPtXtpyBqdXzOPjkGSJwYlErLf94LzRRNP7l9Hx10GRGxl3RwLJIDWNHTc92SwqcT1EeVpig+HpijMOLPKqAASyHAYi49I517hH0DrmLunB8FjSStyrAinHqsQcJ4vb9Bsq+mMWXFXvTLOJl+WgBFEuNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmjOAfa3cH4j6dr9fIEQSSO8K09hGsdNZ5MwmpFDl6E=;
 b=KYkJx2vgXlzExLn4hKHRKb5Zq6pSv/BGkXqnlQmgFk/bml/A9HsOGF/JRBh0fZ1VFUJGDuMK6JpGxevbKg985CnNmOo88uSE6wFS7rkzxscykDyBaFxApRWtkBdrXWh7u7rfFWABQb5iaPL4vsAdtjEaWi+WPBPHbpt3GlloONKc3OB/gZGFnN+im5nKit5D95Pec14GsJ1CJsuqRatjp68AXA3PYU+6EX/TKKuhBgBjBN9zxvq1OVcErm6DASlZKtToVQgepUYyNeOPGKPQzFC/vjpDgrVCC7oZl7ctSh6rXAqrU6ZvtA+a9GHhD6Uje92x9xBBLuAAJ4H97bHsIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Mon, 9 Dec
 2024 19:34:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 19:34:00 +0000
Date: Mon, 9 Dec 2024 15:33:58 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
	linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com
Subject: Re: [PATCH for-next v8 4/6] RDMA/rxe: Allow registering MRs for
 On-Demand Paging
Message-ID: <20241209193358.GE2368570@nvidia.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <20241009015903.801987-5-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009015903.801987-5-matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: MN2PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:208:23c::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cdb02f8-4176-4e6f-603e-08dd18886e18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?83TUSYeAcY1V3banF/tyGN27y8ZSaazoK6N2sIRpwQEXq9e38bLn2RqVxGCK?=
 =?us-ascii?Q?11QwEZWHD+YP+gkkC2fNuspZI0iLUcRstEoUZyYhgZjBRkLoqZpvdG2Sd7kC?=
 =?us-ascii?Q?S64I7VYs53E2lNOuq8HjcERsD2zM6DRSwU7b6j2/I8XA0882HH/rcDAtWOnd?=
 =?us-ascii?Q?wWEQuWJHag7AmPloIhwOKPZagJsyQMQQlRBw6vtfZVXaSsH4EI6LJ7nixw4v?=
 =?us-ascii?Q?4QgF/zWa/mg/vIa5B00+dGy9sbNNjizOriDJokEH/CDsWiJCZdnBrjcDQ73z?=
 =?us-ascii?Q?n/SbgOmz06YnFH1Ywax84xg3XyW3WLusC1DYN6ArIwkqJ185DZizaiE2VUZZ?=
 =?us-ascii?Q?nPKyKGenoRyb5WFtrAg/S8Oqy182Wws8uGdiXwSG8Lfo/IGVRyEHcSo4vZC+?=
 =?us-ascii?Q?sP6WD00rOs4Uq+xCN9jzdqf6cIpDBLD7SLFhgC7EAmmQXLaTTFnRSG6emZ9A?=
 =?us-ascii?Q?lbGAxTBk/0DjI+Kvl0E/cAUgrRyrptf5qeu0Q6ym1SKKV2cDCzsvSXhqu/nG?=
 =?us-ascii?Q?qZDazHtUvZO0eX8JRasMTJyXQdaUdgM/mO1bNk4Loi1u60sVRtXjcK0UlUt4?=
 =?us-ascii?Q?CZSRK6eInVVy4hzQhbN799qqp+4o2+m99jQKo+YO+VJXP8rBjHzy4iFfd2Ht?=
 =?us-ascii?Q?uQkMhHarHR8Gz9In38RCOF5b452nShO22ETtalk0lDnmTZBJ/94tgYCqThac?=
 =?us-ascii?Q?PNzd3QLN+ObiSUgRkVNiFST6fL1jgIUrxcWHDg4z9EXI0kiJD0Som9syWkqT?=
 =?us-ascii?Q?VJ+k83sem+7/nor8ZBr5qZf1hqkInOQeiuwyuQ756xW+iC0HNvKFMRqClV4C?=
 =?us-ascii?Q?gz9Jdx8NcsiG/OVPXwPoEDxpWfNB2zU5HX6iWKHajTB+FyBmQAqLcBNSMfZz?=
 =?us-ascii?Q?Khq1yDD/39F/L7mqW5b/HGUhwBEITnCUwXeVpU7kt7XoTQcv60sWNjakptsX?=
 =?us-ascii?Q?DKGFh4iP7y1eA9c8rkm94bU3uViGiU2nfj3VzpKCHa1XQqDFn5T20aOnGhAE?=
 =?us-ascii?Q?LLKc2roHxP3goK9yW0KHdTglvh2Bpf4h5ohaDtxU7WiaVMzodQ2hpf3PufPY?=
 =?us-ascii?Q?w4jZT6AI2WpMJgEVNr7GCC06lLIX/rswmV2KRrhbW/zE51s7HLH9xBK1ttcp?=
 =?us-ascii?Q?X560SVjPQdQs2jiP/F1rXt9qwvXgzMMAAytX/V7ZcrE2D70XwnAJ7CYM5Vel?=
 =?us-ascii?Q?Ma44vlTxDN2xzkYqf/iCd/ZFkN6wf/hQXQSmebXXH3RIq8FG20rWI3WjTIE7?=
 =?us-ascii?Q?poDzAjktT5QRGBjGlukHR4Q8WwNjcW0GcnBj2DQdNqoZOxEh5Ao1n9jK7wjv?=
 =?us-ascii?Q?PFB4tC5YdZoQWcNwQEl6OoR2ID3SKfocYz/hSj9CdWLVsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uxc3uSHKedtu4HbPHFUvCZKw+jj4SylV90bWpJa3rcPblvkyUkmD74eB5Cxm?=
 =?us-ascii?Q?f8EF3iqSj8rKNyQw4gobMulwwkdFMSLRUIaX66/iMDs2C05A2J90DwZ9Gh1p?=
 =?us-ascii?Q?noH+ujWA8/B/YeD6M29GscRtG6PFBJdoGO7A0htPIqfXitJJJJCewKAskBLK?=
 =?us-ascii?Q?mp9beg2bqZIb3n54ISHiFsALxzu3+rX+NQ9N1uFf3pFxoI0cZKXc6zUiNvCy?=
 =?us-ascii?Q?uPV6Q5fqryMxoUUcs6eB5Mc48TRBdfZAhVn+z2TqXNnGvCSeIOhvUCboVldw?=
 =?us-ascii?Q?aY6C2QYWkg2eIBvBxKsyPkZHXpM7QX/pfAtEqLZfiMNBTi9f/P9czD05LH93?=
 =?us-ascii?Q?6eBsYCfHP5CicarNq1vdApyKIhYrRahFNesgN9ub5mPrcg890m1L/V6eGAij?=
 =?us-ascii?Q?KiAp5WT3gfC8EQ9dbAcjmTbk9J30ztRKizdOc0j8QITYUZiHRxfPI0E3L8N3?=
 =?us-ascii?Q?iNdT6L7+HBkf214v2fPEXzrP477wbjV6QVG9YXTtWCHtxvnGXLC8OR/E8efi?=
 =?us-ascii?Q?4oQwwA/5NWj06O73lt3Vz4w7o98Pt++wiFOb/kDZKpF15CPLjStdcbzCrREW?=
 =?us-ascii?Q?GbaxAX74eRDrN5cSPwR5W6QyZAhNdrqUNMhsEEQCLixOk/S0NB4wd6sgM12U?=
 =?us-ascii?Q?t+NRWAbcBduaFKgnPmSdpSCWznJlWFFPi83IlzKR8QcSMecYMrf9R4UCU64Y?=
 =?us-ascii?Q?DYflAdRszKCcX/7zjrbjVgcGN5fEYJ8qCwHLZno2I6ol4R0EjLiojf7T/2Bi?=
 =?us-ascii?Q?lsyxN6qenPLJ6zzwuH0ITHJws6MzX/udGrTW5HGngt8CEkfdusfP0/b17z1H?=
 =?us-ascii?Q?F8SObQ1NmwFbdT4Jao6FxbRbikTaYhN27WFwsltwmRuvrg9D56b3SmVh9uG4?=
 =?us-ascii?Q?yXAUJ66YHjlWd3CrwK7XNRBCUtBl69bTKs+aY8Cq4r/HZtd/A8kQFHHomikj?=
 =?us-ascii?Q?43taKnVdpskQSYoTllFOMZBADnFn702h98KCm7HOQHebLom6S/lXzISQnNjG?=
 =?us-ascii?Q?lKtjVSRhhecz143WDxOrzKMaEH+QC93yvmfdCD2X58Azl1UMvJc0BoElrkQq?=
 =?us-ascii?Q?38XjtsrjW0DnyxgiBmfk5oBKuq+hFrZ5xqmGEojSL8kFs/0fPtkKbYJeDRTA?=
 =?us-ascii?Q?YTObzeBIMFyvfRJh2kfdAdlnZSBC6d4Le6Jajx/brH7UYem2O9GdfDLZsxWR?=
 =?us-ascii?Q?HhHNC7JrHA8BCGv5R4pOxjhMjMq5Et2nNAe21RvPtYii1MlNz/erHylSTUD0?=
 =?us-ascii?Q?3JPibPVVh6vyRfuLMYeRwoMCExX/XG0EsPFBczjNoVIXq2CTgboJksTm9tdV?=
 =?us-ascii?Q?0obllj4Is6g+Ca1fDeVRLxc4s3H91je6E6IlH826t7czcUltvraF3Jesk/WQ?=
 =?us-ascii?Q?Ll53TSxVygS+8yvEvGGvVxqFn118howFtrQl2kxL7a9D2lb4qibzgBq+8RKV?=
 =?us-ascii?Q?o+oS5DT2d19iSZjInjZiJ9nukvW39Y0+6zM9bIhg3MiychBBpJ8aq0oNXDRM?=
 =?us-ascii?Q?nD/i4c5QDQpBZHM+6cbBABEfMYuxIFXsxVe+zBtG/IUJ/Uia1Tkvo6YhCymT?=
 =?us-ascii?Q?aMTytAObDNj4XomEIzCwowjO4amC3djiT4yM7ZXB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdb02f8-4176-4e6f-603e-08dd18886e18
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 19:34:00.0303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esnoPtqJ60b8R5bPE5i12inf7CGghYMdzwTr8JmYS0hozkoyz1XDQif4qVVr+RqL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192

On Wed, Oct 09, 2024 at 10:59:01AM +0900, Daisuke Matsuda wrote:

> +static void rxe_mr_set_xarray(struct rxe_mr *mr, unsigned long start,
> +			      unsigned long end, unsigned long *pfn_list)
> +{
> +	unsigned long upper = rxe_mr_iova_to_index(mr, end - 1);
> +	unsigned long lower = rxe_mr_iova_to_index(mr, start);
> +	void *page, *entry;
> +
> +	XA_STATE(xas, &mr->page_list, lower);
> +
> +	xas_lock(&xas);
> +	while (xas.xa_index <= upper) {
> +		if (pfn_list[xas.xa_index] & HMM_PFN_WRITE) {
> +			page = xa_tag_pointer(hmm_pfn_to_page(pfn_list[xas.xa_index]),
> +					      RXE_ODP_WRITABLE_BIT);
> +		} else
> +			page = hmm_pfn_to_page(pfn_list[xas.xa_index]);

Like here:

> +	rxe_mr_set_xarray(mr, user_va, user_va + bcnt, umem_odp->pfn_list);

So this is just copying the pfn_list to the xarray? Why not just
directly use pfn_list instead?

Though, you'd have to lock it with the mutex, is that the issue?

Jason

