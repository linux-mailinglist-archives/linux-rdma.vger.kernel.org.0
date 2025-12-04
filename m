Return-Path: <linux-rdma+bounces-14890-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A29CA3B66
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Dec 2025 14:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 309F23007B4F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Dec 2025 13:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93CC33EAFC;
	Thu,  4 Dec 2025 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B9RR4269"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAFC2DF153;
	Thu,  4 Dec 2025 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764853564; cv=fail; b=Ow8h3ZN1tt3pHpQH4fURdvxw30ZyhkOq/MPz31QLX7aaAD3lyMQXCRwdT8Hj1OKxa0fgPJMc/depPCppC38q7I8zwNXDh8XZXRZ1R4DTg3I/srpKEFC8vpZFROyBiJu66Hw0xI1gJGoujY9PnUpfVW3yEav6lCl/6T2X38xP0Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764853564; c=relaxed/simple;
	bh=LglEYG717l+WF9IzluP6Ot18JU9JcqZ42IEP4OYtL8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q3h0Noy3nk14fgFUi29erFJ0/4/lNOBXzg3HTY4yyUzWGAg0tfoPIqJ51cB9SWFzwtpGGb2JZ2RQVOgSKYhlVTIBxSudVtgK1Q+t0hiQqYHF4RxI/fex6yZVkpBtM2u55lwlY4TNzsLLAkPZKHeKSn7fW1k69U5bv+PyOTWk0tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B9RR4269; arc=fail smtp.client-ip=52.101.48.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKG7mY06SmOYkp5iJZQjZxVknx87ih8NxDb72qnJ1c/oFPUvfy7AYq09GN03ssN6mNNK0jbIK0WEEuFKrXCLcYcsAsUTSLIYOT7S1aH7YpnuDQJC79jws8KDbfDukTZxaMZuxLBpTn/HwwamycBc19B6ry0Fjrx7cZaIS9N3jlqY6Nt5CRieqbiYLw2RTMHOPQx2F1Np2JDjX7DnYF9+kH74ZvAg4KLQZ0/IS5eiPTh8cGUsNiKkdbkB3ItIWQlwCDWYH/Mo58UtVTF/NAY54crzlrE4JNYMJUKmaax9pl2eSfmhQQ39iQEeFVDD14PEjlA/qDGdENlnASeXbyQVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLXoCZbufykOWBue8rOTODOFvdbppBaL6FytecZogow=;
 b=Y3+PWmtULfzQ/uTugplpartsx9QoT3LLAO7g0rlBSOx4sSeyCDigRpqvssNVjVsd3f6gk3Zi6GZaRJHw50m53ARnY7Bly6E9BXlsduQ1rnUhivqcY0GcjD0J4QssnNiHe4DzfOW2zUb0P3YuOscoPhMHvEnJBLPAw8OQHAv9zRrSrfriYPecW3KcjsgmzHLf9ngBQrH1FMf38bqiksVvKFFp7Rw8oV0a3AE8OUS4wjkxmgBZfPyf5WcptK1T0u8I78oV12jqid5tgrkeyMUZEd3IknIP5WKWnGxx74BJE+AF2+Avo0YZAZptZ5ah2uMyuLzIF+r762bxC8XXBCqqKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLXoCZbufykOWBue8rOTODOFvdbppBaL6FytecZogow=;
 b=B9RR4269uCJoE1CFSWvwoa1dCxKjM3NRuuvBdmZPyHBQMa6T4lTAHsGcuT+iPjBJttQieO4XmQQTbeRKgeij3lPtN+wUpjC3Xk72yiHpY5FrMVk33rUaMZFz5gcKs7q3qatvgGo208r8N66raDDsYELT6yutsq7d+KzpSPCnkO+Bdnf5RwiCHMWmkKrLpvlWnNqOvIo84wKUvd39dCzyb3fyM2YqSXDZLIUyHN2rqDFkjv5Ub7EqBLYjEZ0ZDcWw5FOJAdxTypnb0JWPUTyDdCuJjV9Z6/hEYGY+1dTefxizzvYppkGOKBA3QFUVHpL9anbBCRc17+qhcffEelcjCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 13:06:00 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 13:05:59 +0000
Date: Thu, 4 Dec 2025 09:05:59 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/rxe: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <20251204130559.GA1219718@nvidia.com>
References: <aRKu5lNV04Sq82IG@kspp>
 <20251202181334.GA1162842@nvidia.com>
 <5ac954bb-ad4d-4b4c-b23b-47350b428404@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ac954bb-ad4d-4b4c-b23b-47350b428404@linux.dev>
X-ClientProxiedBy: BL1PR13CA0309.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::14) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH2PR12MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b0a8a9-cb35-4590-613c-08de3335dec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M/0MNRI2bOw6OG/j5B918r70e+MJYT7H8fxpvbPzHRDiN25W2akwWz/EnMUM?=
 =?us-ascii?Q?7+ZwOvPPTpnbUyIRnIz+3LnD/jowzctnsbXb52t0s3a45NFd7g7O/RZ7zsDd?=
 =?us-ascii?Q?QyWJYIqJfB1Yq9GltiCb4p+sXbT96h1RL0GLOOBsU3EMi0d/8/dr2GiBeV5/?=
 =?us-ascii?Q?RzYS/1Xgr80QnxgLWRMbD9oOT6DsQ9lbjTRsGZ3y3qoDfnnFUSPXC2Skl8zI?=
 =?us-ascii?Q?JAXPlh00A/4HHB3RbF49mgx0DQAg+SyVX6it/Yri1eECZUFfi8fwo9YqU3O3?=
 =?us-ascii?Q?Mrdebfr2xhhqt7jYbgE89VqIv5uy7NazcuvOyBFBMYDk6rrEmLsDhPHJisz5?=
 =?us-ascii?Q?3N1I/sNcmJxFuEJzVrjdkjW9lvD6zJhi/gBXcxrFJmGGdj9hcSZaCa54mWUU?=
 =?us-ascii?Q?Cpnqq49ZpjNhdRuTxJgvXKglz/g7CLlTJV3Wkpoz/3MYGsgKcf7uVWgoi2uS?=
 =?us-ascii?Q?ThYfiynE7uqNxRgQz11j3YJmO4VoUBQDRN1X/Hg2JJ4sHx7t1cCJ9ke+eXc4?=
 =?us-ascii?Q?yAZPJmEm3Dlk+xLj8ohklgFlYqsXQgqDxiOII61EiR+WKJVNOhVPTLDzK6di?=
 =?us-ascii?Q?krCFvYb0lIyLyke3HfPqqqRmVMwbTGrqKLwGlvPasHZvkjNGyVbu6dBOAQlR?=
 =?us-ascii?Q?wovd6IvUx9e/VlG7Dc8PIs8ozsVDg4jcYDm7MmFuwkxL4mTC167jWykzYHo3?=
 =?us-ascii?Q?n4lxSboi89ZtpAk8Id4ekufS01vwbTeX5nrEXL/1RIodi9tPUcTXJt42K9CC?=
 =?us-ascii?Q?gbV23jNObCofayo/JyRHZXGWTq7h58JpGzYTBVym0R9Yv3YkXS32F6ZjV3oO?=
 =?us-ascii?Q?4D8s1I+dBE4r6zhlTrvo7v/jo+Ls/fgVHGTQH7UFomlyvASlVfc0dhTfmpdM?=
 =?us-ascii?Q?7/Kb8nZp20sYC/wgcd/blpXevfoaslAeB8hhEvs+60jDUwH7/9JJH6n3PXZ9?=
 =?us-ascii?Q?6dIxiQB23nDcnwvAlNnAyuTaPX9Y3s8hnQhGi+Nk0K/k6YXtmb1L4TFVO/jo?=
 =?us-ascii?Q?0/8K3i5lP7/ihb2m16b8AtOGSe2OoC0Xq31kmK4iEpAv1xcDJ6Kj+jOI2h6a?=
 =?us-ascii?Q?6pqEXzqOj0e9JKDyDjjp9SNpovqVEibkMnqQibOGxyLc0aSEkyLW89TYYtnD?=
 =?us-ascii?Q?MhAAHv7NC2ZrtAuju6QdgbN1RocPJgW3vEdD73VaVTGGUpp5VnP1MhGVzp0u?=
 =?us-ascii?Q?R2TLqloZ8YEdb2wPllHtB0dg06WGocU0GaEFiUMLJR1F5XSRLt1l8no2PMjs?=
 =?us-ascii?Q?x96Ho2rRfoLB8nXeVXduucVmKbufKN5Kz99qIWvPgwXYUCIEIvPITT4pDpqN?=
 =?us-ascii?Q?9y+uG38blbcnV3G2PMDYLGwtObhM8QTC5YMv7eJDJ+7G5ii+r0HfPf7e1o1r?=
 =?us-ascii?Q?7KU/ItFK0B8gqb1/5vfNnafP0L77T7XvLPKehe7l6GS0mX83EOI1sDW8zA+D?=
 =?us-ascii?Q?FXjZjCa2PDjKye6psXjk7i0o8qw5b+1f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mqypK9htD35IIekfjIfBN3RT8RNUvzCWNcOmX4rUipMrhmrQxBE0iYLkGrH5?=
 =?us-ascii?Q?b4OIVFBUzTbaiF0GkD6Z2bbOScdqowen1Pt6ITTXTO2j8y0jRVnJbqYfiiU9?=
 =?us-ascii?Q?7qBhXwwXBCgMAOX/HUHFKzmBB+nLuHv4itd84GGpKNviRt1cXON5J4K7dR5O?=
 =?us-ascii?Q?Aa8xcxtunh37nFxxZ7fdnNCPGBJTPlwAd4dSQVReW+bg+HAkKBbIvXc50GnE?=
 =?us-ascii?Q?zyL9E99YVx8AZGcNr25z4ERteuSLlbUj6vElrqy+HjMTfcMxL9+crNgijl4c?=
 =?us-ascii?Q?LMocTrw1f5fQFqN5+P2ccMGC1t18GDEzc7mL2Kg2iYo/Ikl9G9a5hBSP1WZz?=
 =?us-ascii?Q?kAvDlQG51ayavfr5M6xB+zc42PzQ3O1RVgKHVjHDajRINXUAQjnL94cuEGmB?=
 =?us-ascii?Q?6HmMJy2ciUTbQAjUf/yMEI3pliH//tE45VSlo7TWEcAvJdjVZKp07diiVkvW?=
 =?us-ascii?Q?e+rK7OrdHY4vcCYblZkU9HX9YO4XBochrHrTeq6k2ULmhOUoVTFCW/C1OPkZ?=
 =?us-ascii?Q?jVCbIj/xNoi+reS+vzUjKEzwZz7QbKp7KCd/jnC85kXlv7oE+PUacjNO2G3o?=
 =?us-ascii?Q?7PKhO/VrfBuONmkZXoCP0heLs6aYI+gzLVY5XmF8xaI6u5NuLkxkYc4PMaRA?=
 =?us-ascii?Q?+lVPtFkSc63fJWaTshAoJO5YPihG+XMpI3YfC3g1yEi7wQcy77Jp+bBklnqc?=
 =?us-ascii?Q?p+9ZSUoeNAHfb2HQ3Q3YfgfugkP41R3+fCCafvZ11xEPne2XzCQYTGl93k+a?=
 =?us-ascii?Q?vJhrOnVRrtpfngHWahoqfvnACsG/hULVN7SnVs65U7lvZN/QpuUqF2DXl1Ki?=
 =?us-ascii?Q?I/y3HPFAwbI/ZN3aNZJEodQGdEl3L8MleW5zIbEX8VmxOeaalrpfZakuVdYJ?=
 =?us-ascii?Q?XejSdlC1O5G2W0iwfjGyV2tVZ/0utpBLHjEB5ndTVGLCr+Zgnr24ysYLVkXM?=
 =?us-ascii?Q?YWnQ7NOPmz0cs5WHkwmNr2wq4SEPEi+LPFObv4xp9z/QHi3upX9UcgqoFoyK?=
 =?us-ascii?Q?RGGiUq8ZCDIfjBYLI0okzvnHEVFCyY5G6fmtLuXRAeD0muqqaemdHcWMEVqD?=
 =?us-ascii?Q?4Jkqy8MMAQ0nrwqzT+6ebPfA4Z0jp8URKJCZbUKLozJg9aLIFGeMbC+ccK0V?=
 =?us-ascii?Q?ZJRZphI88NvWYFF11CEWBI44U3JenlWKhlM4M2VVpXWFH8dftxGamTuGf+wC?=
 =?us-ascii?Q?pno/9IhWQhYmbfaL8VQMETp7y+KwoilO8rh9db8SZk7/fnOOsx4muy6Cea0i?=
 =?us-ascii?Q?MIlJ3rCuQ+sPMEVVe8Gyrs9ntgzCqmgqVAiN+oO1nrzfvKt46/Hy4pLh7VLA?=
 =?us-ascii?Q?bkRP36ekLO5bsSEWME9EBmM+XJqrH3kMwUfYetT8EJ02tz9mohnSEiXcRs3K?=
 =?us-ascii?Q?bz/Mu8at5/QPlhSthQ8A6pc3PqZ7fxSNGGOBOUXy0JB8APixvpk8g3EdaxTy?=
 =?us-ascii?Q?6P3gTJz4WtBrQJGZXaqRrCj7lDaFa+CJG7+aEbggtOgkGvJmrM6o4br8gx0y?=
 =?us-ascii?Q?nfZIFWKmIkh5F7IbgX5WwZI+O3B48/92UKGCaqvYXJd1NvYiXKOIQfupsARf?=
 =?us-ascii?Q?qHRUy2S7t3yrJnCedbE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b0a8a9-cb35-4590-613c-08de3335dec1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 13:05:59.8276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsMwtgcNg2cMpmDngRksAvOV+WV1ADtc6d561DeAPp+IhlV5HJu+BFXGqAz/V44W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9541

On Wed, Dec 03, 2025 at 09:08:45PM -0800, Zhu Yanjun wrote:
> >   	unsigned int		res_head;
> >   	unsigned int		res_tail;
> >   	struct resp_res		*res;
> > +
> > +	/* SRQ only. srq_wqe.dma.sge is a flex array */
> > +	struct rxe_recv_wqe srq_wqe;
> 
> drivers/infiniband/sw/rxe/rxe_resp.c: In function get_srq_wqe:
> drivers/infiniband/sw/rxe/rxe_resp.c:289:41: error: struct rxe_recv_wqe has
> no member named wqe
>   289 |         qp->resp.wqe = &qp->resp.srq_wqe.wqe;
>       |                                         ^

I didn't try to fix all the typos, you will need to do that.

Jason

