Return-Path: <linux-rdma+bounces-4478-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC9E95A89E
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 02:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A13282DC5
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 00:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E912582;
	Thu, 22 Aug 2024 00:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mYX41CqW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726DF4C6D;
	Thu, 22 Aug 2024 00:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724285681; cv=fail; b=sVkaSMkO7QoMPAcXdVvpRFJRuXHJ3DF/1on2ISPir1HlAfjxRhoY4tUarMr4pFgIf5sDv22E9xtthJqbWqwYz2xOtgFsCreyReif4Re1fVrugeokB5SGD3/W2KzWAOJ8+m2GeVt74nGpEzXKoKQ49aqTfdX7X/2IrBd4PDL52Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724285681; c=relaxed/simple;
	bh=lnGZEPPvkNmaYACfq+u11UOV8J8SPEjjz9XdDNB5MwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oTk0NCQxhXmhsAFQ4WuwKfuU77AnHFQhHje9iGxvAxADEcIuRD8ur1z5k8GvrVQxqw58vAFuNXwgVivESxnlS/0LvaTkxQ4P97/JJBSMjI7+6J4qGcpq1jiNE0kuMUMVb6Vk9dGIbL1kzRBmST9eQKrby8oVojYoSFQrRZW1C2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mYX41CqW; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7zyRgA8GeXxm2Iyc9V3en1qlrZNOhtG49cjhdONBzppxtgv24djz5sZCOCo4Cnl+QzBDCXzCG/RLQO9r/78zWjXBVCZUMErwsLWKmVdUS8OkAPkZbnOlf53HNo6mnUAr3AywK9ht8YQSxMHUp29TI3/d0ktI32Jq32Ytr3s58KyIILocCXUPo0vmBe1sEsf3+lCCe4vi1AXF4wPBlTZtBxYerAtvDB/CThW9f3n8owe/sonkzCUmyi+7Y4C81SQyQqMfwcT+hNMaPuRRrW2oqOngXFMl3jb4Vb9eGddtAPH1y8q/wVRdVa+wd3SUKOPJfzNeotqukRZv4KIf/uFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiyTkCmOEKrtMGXX0ovA2lLB2ReMDxGBiCwzRLKUuR8=;
 b=SeC446LmQFgEc47+1xaLXynjrNYRqzAA3qMVipx5VugzFq/OuHDAhCuR+Mxf5ItEAK9A0eCiHuLA1fx6fq70WyO99Twatl12gucMyc+7f97tUCvWNk7kFulQ+Uz42DcUeTd4rOadrwUaJ+uvMiiQVnW5tAk2NnnoBMFazVo+QqXfJa9TkdnOar5JjlbKmH0cTaz+4iKN8YulcP4Ulu2tJTeen0nzoW6tryUR9O+MBTdiwjqJZhJw32Q7Y2tYF4aIl6RYGPyH0kVOcvYMY/9CDwqTBu6on4yEDhKstBBbQgqw3Gh9FZ4zpqGrA3/kNHS9NJ1BKx4M5dzYdHBomnc2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiyTkCmOEKrtMGXX0ovA2lLB2ReMDxGBiCwzRLKUuR8=;
 b=mYX41CqW7pGqZ4QR1KhR5VHlrMdU9s4c8Tf4Y87VwPJjJFT5NH19al8G8BnluxRnDJ537drMg4ECcx8Y+GDphKQx/hJc0pND1D78y/XoHhO5S3zA4eC34neY419hGlngUiD2yGWlLorkM3oJWgWBx/ofxujsHOWBn7MVhAd/B7RpO64PFMf8OHoNLuwsBJ9O4kLKqoWVK4vvsGigCOeR+ecvElfhQcJskEr9+HTbBgK8zw8v0PD8cV/6eWSEJKaQZu/SGY5z1jf+ZWpZghbEvSQusewBmnZSs7IF+XXSfa7ezGJYjdYjkWsxaEvHNW7PCL+fZspHGRsuIZqNtFWvNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 22 Aug
 2024 00:14:36 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 00:14:36 +0000
Date: Wed, 21 Aug 2024 21:14:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH v3 05/10] fwctl: FWCTL_RPC to execute a Remote Procedure
 Call to device firmware
Message-ID: <20240822001434.GN3773488@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <5-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
 <20240821164950.486849ca@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821164950.486849ca@kernel.org>
X-ClientProxiedBy: BL1PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::21) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a434455-bc9a-4cd2-9432-08dcc23f67c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1FayWTVuuJ+q+b4XBkgfWAU/rPWi+sX9gPSqS/ZLXzwqY3ifOby9NJDCuAd+?=
 =?us-ascii?Q?Uug4bybwQaLLEz1FymeWDtI56hDOuPYhh1LlinnBE7hMCMPwj7URl59ElEA5?=
 =?us-ascii?Q?qjAWzHHOe4WHSFUSGnRUH/VdtxHw5J9QzgXaguHrRoH2Z1bF1EJgGwxegulw?=
 =?us-ascii?Q?2jfkF9u/2QPaDW094quDPOHvGbKPw4zDEV+774oBwyfXsnlC0Xag2LotqTnq?=
 =?us-ascii?Q?FnVQrlSEM+2Evcy3Ef4zg4GRPgtsJ3WDDFOZdDZ4LOd45Sj7OIILefr/VkK1?=
 =?us-ascii?Q?oHJph1UJQ5DEUo4NnqLqtlvA65SSxipglp4m4R3bNSi8ClujqyrtoksFTajb?=
 =?us-ascii?Q?lph3LndhTMHCRVyfxo6QMK6iw00l6QoLhOAJwhg/+Shq2Rxp0FQcuH0qRfh/?=
 =?us-ascii?Q?IbqzgDwsp0YcRnAb1aYRL7GLibzio7JmIN3V2HQVtvUE/SFNk4YnEALgGiGd?=
 =?us-ascii?Q?KPs7itjsJO1KpI/M/+wud6EziQ20TeUEl+ekT++OW+zi2X6FfJjRPk3/9RBX?=
 =?us-ascii?Q?GUCWohxPTm2q6OhL3HjjwbwuMaAdWUQvGzsD2yUsBQnRm2RQnQyqFNPbfsWS?=
 =?us-ascii?Q?PkjcFJPQP1UB4tOKyZVAw5LwMTuM4oJR6pPiq9NUqTvZhBcEa6B7qtkC3zlM?=
 =?us-ascii?Q?jFmAP4t3JWwFRsMJK2sca7F3WRP64Iej0OGCZOA+klIii06Ce8MnpE2vYOss?=
 =?us-ascii?Q?myfmag6mv1GFUwxHZE6KGAb/4/OeAvthISXurct/+HQ5EBUU09oiThbEnFCC?=
 =?us-ascii?Q?DsiiffhY/cVGCThH/3RvaBjzWeOExaBOpL72NPEn+vc3VMTu36WUWjVm22ns?=
 =?us-ascii?Q?/lyeSZ0YD8Nyo5VEPRsRNtC29innzB1j5/XBqCgJeYKpjRpV2WjeUOkwHvlC?=
 =?us-ascii?Q?K3s7jXzo222iJWXZ/FvGihPLjqaOJSVlpTqv3y6ldujQRkgiu85MRfhT5zwf?=
 =?us-ascii?Q?6XTA+NX2mZb56jNQnXnEEsNnGorkQQvWNahNY9YcuSMApMs97VmMMmZrnjWx?=
 =?us-ascii?Q?yE4JFH1q/ijORyRX9a5FE3oP1RPW058gFuC2BMLpx5W3nowavKagbeL9B9td?=
 =?us-ascii?Q?98ca5/Li6pUAVxf7Srx9u44caLwaJv3MxwlJxac7tsA2X1hLhTY7gx4gAX0g?=
 =?us-ascii?Q?k+KZYxWVwNuCjq+Ye0HjbC80va53S3GCXvbipMZS0iGSGL4gOkSh6w2KyJQt?=
 =?us-ascii?Q?9he4whoxdoVENhMracNF59kGpPb07D695kkygrl5k/xyyuS4drLX1thQnC42?=
 =?us-ascii?Q?60xZ8A3MSTvl7ol23HN/3Ehl6qGgbovthwvzMF3qCepU6EKnx/IbKL+heC7d?=
 =?us-ascii?Q?cqLCQN6V59B4VcDBLxEY23b1sJpteAZSbTvgwCsEtwRALA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z5Jug1YZwdze74WP9kjlvcbMK/u6MJO5Coz2ci99jj6TzZbAE6ia6rxpDX8p?=
 =?us-ascii?Q?KZRrKlfbeROMJADQev1UZROogkNoek9yJ0etMK9G9V9ATTxm3Wz3N+R7mfFj?=
 =?us-ascii?Q?j9uAu59puUxKx2iyCIGr3x5V9Z85/n4grgMOun4bscTd1B0toRIiCNUKJWi9?=
 =?us-ascii?Q?6CGK0Q5pp3zwtXJsKuQuKUoqXC05FMI/e5UN5uGUcpk16sDRhwPiEYHeE64F?=
 =?us-ascii?Q?qdnCz9iSxTjgRWA6z8CDeUoWFQ5799ghk13fniKpHJP4foc84RbbVkgcr07O?=
 =?us-ascii?Q?YDkBirDTMZ1Z305MPBq38pqvLsIYEcc1dxaCITf4b62YJW5W5D1jAVULESNJ?=
 =?us-ascii?Q?nton1tqAuGt7Zz4MpheJIINKHIRiJ53XI1pXRXuyvirht3N0WzJ+J6TFD+7K?=
 =?us-ascii?Q?Hj51NXPu1QsXEkHmBBN5S0o5zF/E2cptKJSkCmEt8HXZpaE1Ek/taVpmFYSU?=
 =?us-ascii?Q?up9B+Zv4poJxlj4zG6kYhW+IHWf3tp+GrHxuDQQ0PgyXfxQK1ociqH2rIloH?=
 =?us-ascii?Q?gtDrJHZYfLgLiTQciDMgxpdZ+hBe6TazUNPLkHWYNvKqxr3r8BYBSy52TfBe?=
 =?us-ascii?Q?wj2SeiEljEHItSGprUnp0d073CIxXoNRJWA5wFx5JTcZ3poBBYzGGEEZdKqR?=
 =?us-ascii?Q?zESweIVuGCjP9Bt0X/kD884Ecsw3IetaZZ0PMPMWn7x705SlQWFA8bP5aeVs?=
 =?us-ascii?Q?D9VoX8dmgHMLmKzP1Puw3bn2iEzX2/kU7f9YAPcEgJpezfUPqmQyxLRSHfeD?=
 =?us-ascii?Q?Aob+TEPCJtTgLTZKkHFJyDxi+yXu/UbJBJNTK6Rsq5mSGDXTdpfJEvjNZ7iK?=
 =?us-ascii?Q?H/xoA/d3WVgzHRMC2nqwonpKtD8kSQGNSJYjrlfAQ7p+95QDx6PIAIpUckqk?=
 =?us-ascii?Q?4k40pcJ59DdC30Wvv0SBS0BgUMgWm6/jQMLzq16hPxqxqdBSI8CNjI5/Zum6?=
 =?us-ascii?Q?WIFwoFmOM6MkuuUDKsY1PpJA+1c7kjbe/yTn8O3x7IDIJT5KHm/5s1ZWD+Ch?=
 =?us-ascii?Q?ioTYJ++yqB1Q52+8neEHLvJAv/UkT2tujLEYV3sNrFYGnaFhUebMWg/at0PB?=
 =?us-ascii?Q?oSDRj6wia4imoMRKj70sFzFRGXeTVsgYxtp97vSqURNLomuwcwOJNcaUxIqk?=
 =?us-ascii?Q?wDSp0Z9z6cD0JuJ3ztLidK1QIDDoFeLDJHzbOn+nPyXMyX0l+VcDju4GA/G/?=
 =?us-ascii?Q?4RsTFx1k+DUcmcZBnltZ1v1wRpFlafjKPWLUjA7uMNrG7M3sUmGZM/8Cw9QO?=
 =?us-ascii?Q?RPjmgtFAGpu5tHN3YK9AW42q+M2xVFuqYaAsDIImSzrk4lHiVAY3yNqCTVSu?=
 =?us-ascii?Q?GESqMwkRT5UKOcuwT+JIdIQV8Glz1zq2mdJbFN6qlKirIVnzkt/dOgDhC5Gw?=
 =?us-ascii?Q?u59gg3pNx3Wr/wRGarP56qrsDiwO29Xmahc+uOD4okMFJ1dQSN7f7P9zFG1E?=
 =?us-ascii?Q?9JB2Zisf18zLc6exWdcGc423cJFp2pFTo7b6gvvGBiZ/71GASI8RV9nFtl7c?=
 =?us-ascii?Q?FmTwuYo+6iT5c9v8U9TwioMerv/tUiO3P8a4xuqc26NsqIUk6WQbaMqDAGtf?=
 =?us-ascii?Q?aQylejXJeYmrhlmaZiJtM8U2nrKSuE4R2Crfdogq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a434455-bc9a-4cd2-9432-08dcc23f67c5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 00:14:36.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIE75wX+lsbcQ8ISn9ooIiKWNVUPO5gsCBhUYdmeTGTnQvbv9QYv29U4dqTvNUZi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004

On Wed, Aug 21, 2024 at 04:49:50PM -0700, Jakub Kicinski wrote:
> On Wed, 21 Aug 2024 15:10:57 -0300 Jason Gunthorpe wrote:
> > +	case FWCTL_RPC_DEBUG_WRITE_FULL:
> > +		if (!capable(CAP_SYS_RAWIO))
> > +			return -EPERM;
> > +		fallthrough;
> > +	case FWCTL_RPC_DEBUG_WRITE:
> 
> Nacked-by: Jakub Kicinski <kuba@kernel.org> # RFC 3514

Your "evil bit" thing has been responded to already and that isn't how
it works.

> How many times do I have to ask you to keep my tags, and to CC netdev?

It is on patch 6 which is where I said I'd put it:

https://lore.kernel.org/all/20240605120634.GS19897@nvidia.com/

You never asked me for netdev ccs.

Jason

