Return-Path: <linux-rdma+bounces-13675-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B12BA4944
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 18:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E9FC7B0B56
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B82264B9;
	Fri, 26 Sep 2025 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fl/V/toj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013058.outbound.protection.outlook.com [40.93.196.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97941AAC
	for <linux-rdma@vger.kernel.org>; Fri, 26 Sep 2025 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903340; cv=fail; b=AXp5PNhpqpP4Ib56OQwftX1Par7EY3TYr13t0tIotAc3uDSU2PANLVGf5xZQeZUK8OjxlAwlfakWDtB56JozzVjEv3fUicOiY5kCcZCQ3H6Wa4h7uYskPK6PsnQGSeMEB2s6ecFsBroSscO9EdcKcS/SVnAnk+ewuTeiZfvDFQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903340; c=relaxed/simple;
	bh=FwRUTI7JAR8u3MrQLTPakNLe11AQ0afWf6ASaoh4I3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=koWhqD4lM2qiwPfTNGHE+6vE0IyEJXS1az/8+8O9EhmiSKrLy+QnP7HeYPRcdGjPb9KlPePUJPtismGL8IRYEARhxs4ndTNEUno47jrVo336DeHOKk1yuYt6GuEQeZjHN97mrb5hxTh+w38lbJEqvs6u9DOK4rIKQrBqezNZV3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fl/V/toj; arc=fail smtp.client-ip=40.93.196.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSwX7V2rAzzn8Zr7lHGtfJdRatB49WJMyBYx4za5rYM/RTfAHMSffI6cIH2Fux1Z1yu1L1OuRTWuy3aXNrgj4DpBSD60mM4Qf/hhDgO2A2ddF1nr2yrEnXkO3m3Wfhssp1VvVxXm17YUd/IVNL3z1V3VbN9CS8eoIBUzDZjrkolX19Mlh2qNQ5lNcK9Ee4TD6ahCPGBn8Un+SlQbO0DTMFBByHQHKtQ8NHUJlZk1hR7pCfWHwBb1bya5Awdsm8UpGjxN/iPrXlYLCT4VjKROKiXUut9zvFgYQXxdURMnyLlj2/4PIeQSxHQMuXG94A6XCtNXVba+K2UkvubylutUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfzvPSxZfysD065uCK6NgDBqPSKNiS1D79GjoLt3guc=;
 b=g3lMcpxhu8bhJWTM51Pb165fnXbJm1pM3XzrU+e9WcPSKXxTebhjDpnSxHDY/5GAgjUS0WtENW8rwbMfM6tklpgcLBjqhSu6le6uviaGujMeKcoqbMvap282CyQffjxNsI7r304siDcBHBPg6OdMrc7nCWzOk9YUEFnpJxZAmT5fDC7qIbHi4Z9yUFQ9DRs/Miga69VSFtQLgmPRdwNxmcVl0tLD3oVBWHA4bNamTXbixF8lAE6nw6nDN2uMrKQKnDfstW1pp5uB2XaKEHxQTquT8EO5APZ6IMry+QIby1gay1uM00VdTjk/lEviKGZ1igvippnyyQl6PQb6uaVIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfzvPSxZfysD065uCK6NgDBqPSKNiS1D79GjoLt3guc=;
 b=Fl/V/toj58Cc/+WLknV341W3IBM57qY0GJ9oLJJT18Awb8cQ39miepSiMOE56ns5OOo3C54AzANjluyttOEJoH41BKYUiDsvHgKRgjovMT1HhHa9HA9Ay8gqW2fE4kJnolKYB65S+HW0PuUXatS6X03jH7p1vN9zDLeYxaxmsXLBMR+niUco9jIFd6h2eiERuBJUWt70/7SL1EhXoCxpQyRZ1TnmMPYTCzA0mZkNQAX9n9gQ3l9e2EKQ1cshhaBWcaGt4hcPIFUi31AdtugHfk8JbrB23j9oktsRZ3Ijbh9Ker6idzXvt7SqLSJbIfulE6D9w8EfJLi6etRKI5eKNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 16:15:33 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 16:15:33 +0000
Date: Fri, 26 Sep 2025 13:15:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: bernard.metzler@linux.dev
Cc: leon@kernel.org, metze@samba.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Always report immediate post SQ errors
Message-ID: <20250926161531.GA2827732@nvidia.com>
References: <20250923144536.103825-1-bernard.metzler@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923144536.103825-1-bernard.metzler@linux.dev>
X-ClientProxiedBy: YT4PR01CA0315.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::28) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f37536f-35d6-4afa-bddc-08ddfd17eb79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TexFgIb3cudTn8lmh/AcflWblTP00Q4xRTto4+x8dfI0jvgbaGcZ/0vojJBj?=
 =?us-ascii?Q?lt9Muk/sNfRDKlQ3V6SsGIylS5uCxBVfLC9xz2niFUsdJgbVaQUF/VQ03oOZ?=
 =?us-ascii?Q?jWY2aKbv5nmCxQM2vhhn5ntGYj3lB/HWIFQ34zgEl6yrY6cDyBtFofW2WeqV?=
 =?us-ascii?Q?oV6TPLLoD2NcXsn3Gp61GjoCtbKCIZZA7RKxbf4Tn6n6AnsCe0W2L5s5lz/1?=
 =?us-ascii?Q?TgHefaMyUAk5TEM0xp5AqielbJQRHI0llJf5c7BVvgG4P5P0fxGX4v/5PgR+?=
 =?us-ascii?Q?mBgmwCV8+TqagLp7LMX0CGj+3UaEywNk5+xwm0TvZmL8f/mrLjSF8PKn88Qw?=
 =?us-ascii?Q?lmaqZv6zPHPvxC/RoIs8mtPUf4hrfFAuM5pSdqRTdyTm1utN+h7R88ihRuw5?=
 =?us-ascii?Q?LTJBqfuqBw7F2m6oOwJ8AKMB5LNeUswxmjobe3RXsK6iOC9e+mIwLBn9MFtx?=
 =?us-ascii?Q?YhuHudlvo91uMq9axckHSAviY7Wpd75rFxgKu7yZ67W8yvunP1C9fOrbtmTJ?=
 =?us-ascii?Q?aHALg3VrpIxwhBN57hl2PancvMM+Y3v7ffHOVIjy9Hft01iDPe6DUMcl2wcf?=
 =?us-ascii?Q?CwUcnE5wGSlmrZsev3m3EWZ5hWGEvj9iOApbBDZXtvRzQPqOm418TUMYO4dT?=
 =?us-ascii?Q?IiW+Jg+7oosR67NOPiY9DMW4WOh5FxmytXHhCCI13JP933Pp6jYy7rWdiAb3?=
 =?us-ascii?Q?bqBfeEaDt++nhyiz5VmmubzU7p5ogvKBrMOW/3uStxAV0Ebpi7NAfBHB4E2J?=
 =?us-ascii?Q?9k6Lcv6wXVFWfVP/Rd8BHeCTxlYtLSo8Gzc4CtpSy6uqBLT8u1kQA1yMQte6?=
 =?us-ascii?Q?0yirX5arsaxF5vwwrOYkUxvdCesMRW1lWL8+V+uamBlORsBn2esZsP3V0fYR?=
 =?us-ascii?Q?Xc2pLOVAv2iTNjc1ZsZHHpJCRKRuQ7pJAdnjf4g//gj2zeqOM5Aa2YAs4Y5M?=
 =?us-ascii?Q?Tvtzxr8aX87lXnVZy+w8k106GSffliQKUZKL7q1JBzIzL78141OqrDS2kQ4s?=
 =?us-ascii?Q?uVHZx2H5xPTFEuXKfw6SvTZ75nJuZqbTiMMdr4LC6aNYKZsGzncRHn4dH8mB?=
 =?us-ascii?Q?7S5Ig0ApL7fInMaJNdvgPzVR/CuMKGJb2A4ewzmGc/IFrurNrLAxz0A+JrGq?=
 =?us-ascii?Q?VhtSDnAMPm8SVU8Jde4NcmE1AOhcuMnv5rLks+qWC3Xz8YT/jtDAQpBQwRi+?=
 =?us-ascii?Q?O6jtgVwHln34MfWx7nMaKGm6PuMLjbrXMe3LvmEof3bWLPjNXqe0n/9HQtH3?=
 =?us-ascii?Q?Yj4/BD02AW41lUXMYOdA+Qk+r5V5X1hoQ8x8SS73RqdSOHO6wlA68URilQ2b?=
 =?us-ascii?Q?sKzJFjSroEA5BrbOuK6QMIWEkGCu2M33YSQr1IyfHy2t6RNhV7SwHi9gqX0+?=
 =?us-ascii?Q?LyZFIS8Qhy19JU9b8CAg2vov4CRcMzlvtEufqYQ+eZ1Ov//7xXi89H2GVFiT?=
 =?us-ascii?Q?MY5reLAp16tAl7KYd4bbkzao2fBWOMh4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D3CoYCgorSW1BLTBxrcvhSJL7YiNQBNOmfWyUxbIWz5weW45dEpRyEj2vVkt?=
 =?us-ascii?Q?6kRoW/mvtgfYJRJ87kl72rXwc5fF14t8oKJF20mU/KYXAIlaAWVXDJ0oIzg/?=
 =?us-ascii?Q?9qO7TR/Y6+aEnH94YIDBxbDyAzBpQfuYnqkxbsP5UvFSrzcpDjfXP818sESN?=
 =?us-ascii?Q?p2aJJCT8wj69uktClnIiZvRleC834dZ2jYz3aMSX+GmTG3cICMaw90PB5IPA?=
 =?us-ascii?Q?b0D+4Y+EaaDZ9DNkmIbuhIEvIMUeZyojjMjQ2qIsfvd8MX5ZQznhibOqFNMK?=
 =?us-ascii?Q?/DySaSTXifhv5jttXfG94q+M4VpXjlxydVK2SsSJUPMhxnXeUX3Izdicrvys?=
 =?us-ascii?Q?/2IVINsox4Dh341u7vDvF7QtWf4pNRCSBujQDouOGSZ9LsmVgErjpBjXsYmc?=
 =?us-ascii?Q?SzBFDVfcMDP+hIJQIABhm85y2OZZpMl0K+YkFsh4FtUmreq/Lrboum5Zt9CR?=
 =?us-ascii?Q?OuulqAmvGLKPJxDajXJbN5JDLZwplK03fG/01CUgRzDVGKWi8mapSX2babJv?=
 =?us-ascii?Q?mKKMffeavD2yAK82NQzECS+33gxBccCc9FrpyMooTAVvkZAe/n/RhYMeP8w7?=
 =?us-ascii?Q?Q0hbtWG57VIzHXyp6yglXB0uFY76wtjEp3Gzy7GnIhiIo/5j3pKIBhefDSNG?=
 =?us-ascii?Q?qsnOhBCveEj9sb5FnPHX6u4jV6zrFqQ/zHEJA5L037/iPFaPZweBrpDJE2Zd?=
 =?us-ascii?Q?Tlg1wdcOoGrSj/RipT5DQSF7+5EMUAIJPJxAxF2oJMqKMW1cMgA314uVxZ7h?=
 =?us-ascii?Q?6aKjmtzvusKeQQcXliw/5vnrBrJNGs5XlbtLHHQfWfH8DI1KMh9pNGwrHAn+?=
 =?us-ascii?Q?TrXLZeej/UfZ45iN7A3a4YRJy7UcGZD+KOepNY+nFTVY/BkCEnvJG+oPRw8v?=
 =?us-ascii?Q?9gAqo5744/RllWFlOlBAZatliPC/CSOX8jVEItDXY9yqzPHWvkn19t1aCBuN?=
 =?us-ascii?Q?CCrL+gCxOUoDaWMu/Czg08HBqvH5tfb5KR3lBixzwIEYUrBEmS+Gl013ktL4?=
 =?us-ascii?Q?MAGiw9KlJ0GVf3CD6Bah/GHt/WXLDyEVxj8L4oq85i5T3z15QxDaXysXUVJ+?=
 =?us-ascii?Q?FOpGMhs8QnL0Mqpz6+U+oviNrCSxp+gAr9imj6dN0buHMi7LKqzPxuvGZ4oj?=
 =?us-ascii?Q?FDXJdp+l45X/UdlAs0IF6AMmX/byyvpRySzMwB9o9HtW/tzMPpUm0pjEaCTZ?=
 =?us-ascii?Q?2Sa/+WQXIMRb3FJVxlWvUmpWLEyiFLFfNJFiu6qpKcxS8nvEVRIyZOwes5/+?=
 =?us-ascii?Q?8c4o+eFyM/RVb3Q90E5jwpDeSRQzj2igrdR6Hle/o5w9OPoGw7WJo7J/Jmb2?=
 =?us-ascii?Q?KzUk3tstvSvO39lxbpsGp+8r9w05Kiq2ZpPctYt4FR30cjAYAulF0SU+TwYf?=
 =?us-ascii?Q?jSsbUutU+ySLG5t8SdmVYynpivblqrJdKOEHbexqX/dYPeiEp3Zgxw5EH7FG?=
 =?us-ascii?Q?TeAr4Ab9X58zFgDDD3GJeVZVmlzlqFuz+va4lDEW65RkZ228FxCxdD9jpmkV?=
 =?us-ascii?Q?aaJdWuqO4sYEUI8V+43tNCi42FJViRbI1rzRR6x6ahQs1Su/NnHiZP0sUbfF?=
 =?us-ascii?Q?hdJG1/Cba3YlBymqjTY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f37536f-35d6-4afa-bddc-08ddfd17eb79
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 16:15:33.4443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shpQYGGkf+d8SjW9P3+mbZWNz/rIRtaxaYeS3uMPZl97mDixGPPS68y77ptLlX33
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882

On Tue, Sep 23, 2025 at 04:45:36PM +0200, bernard.metzler@linux.dev wrote:
> From: Bernard Metzler <bernard.metzler@linux.dev>
> 
> In siw_post_send(), any immediate error encountered during
> processing of the work request list must be reported to the
> caller, even if previous work requests in that list were just
> accepted and added to the send queue.
> Not reporting those errors confuses the caller, which would
> wait indefinitely for the failing and potentially subsequently
> aborted work requests completion.
> This fixes a case where immediate errors were overwritten
> by subsequent code in siw_post_send().
> 
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Suggested-by: Stefan Metzmacher <metze@samba.org>
> Signed-off-by: Bernard Metzler <bernard.metzler@linux.dev>
> ---
>  drivers/infiniband/sw/siw/siw_verbs.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)

Applied to for-next

Thanks,
Jason

