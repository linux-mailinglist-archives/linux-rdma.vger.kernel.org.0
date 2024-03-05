Return-Path: <linux-rdma+bounces-1282-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A6D871FC2
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 14:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B0C7B24390
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 13:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A446485928;
	Tue,  5 Mar 2024 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JIq2eEE4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD37085926;
	Tue,  5 Mar 2024 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709643820; cv=fail; b=Gfz9BO7BD4tjuCR2dxjmU2a6+Y3pPRdjKHlUC7PWxemQNN6hIhh8S5A+F9Yze39Oc5BYpFi5yYCuL9RW99EebusraxyqH7uYTwZAWBfWVDWfLcc6Iq4ENiha1wg+qWMbNo8/35m6ZgGSUtDFr3P2rFAUSXlZVsKDqnm9Sufnajk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709643820; c=relaxed/simple;
	bh=+7sFZPgjxVVJP1Dk9KMn7/7Zi22hoPp9Mszg0CcB0bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d4Ytu/jbNac9D/xWYiCX/FoYHfoDfZhNFxw3c0Z8tRIyvUoT/YcB1hXwfaWDGvitW28FeqPFHfvjVQEAnFtnA7pLb8UfmcjP1rLVafgOgwOGc2IMLZIRSP8SskSxAu9vUGNuWz2FLpmMujnnahyX6O1NeP9osgTXAQMdSp5hQzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JIq2eEE4; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nk6bKto4JH2EiCW0gUV+FUfK7XaI46k9qc1o6OuhJKbD5jLptPjiEj5e6Hmqi69Zy9BJDk8DwIHNdK80L9FPu6i6/zPZ+mIP/HmoFN0TawoAKK391adBpnrRiBAQ3MrC+L8MIpJN87VDtC/Io/LvdUHFK3Sbr+EwwpEZbDt7wXv7lX9YiM3+j9bkFXHmE/xj0wT0WEB7zlKuo3CiOp4KIrP5NjTq2jNHAuRg/iRlznVwwflc+uGMSmf5A77X/qT6mZkfbUf8RjdQO6afwasE6HwA01suI3jck/OpnG60AUgpwaOZvbByHeZmXnVOAOwHbU5hTMYCFDqLu3s0PUA8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhHwbZzITGLPTfIFD3JHAs0kEoquccRUXZ5cNo9x4ew=;
 b=hUeqNxIzoIdt19N0qt0SGdRTSDPNrrveJMRpVkn1XN63pd4OCW9CLd4KlDyP23XEU1dm4e71PpS+O81A5m0JFoVn2ULye6w6TVrd/NTOgQk5QADZJTUddDUqZ4WDPDssUL4H4Mv+qOiWe46VwwQuHIo6jLyb5UiPI91klM9+nmKwyFMWKJmlAdPUSk8XmsSN4liDvX7ektAQ0l/e8+XFFoPZi/ZPnMS9ykGDUqi7DAiRuplxBQVGqw1vc18QNkxFtgrkOQRgqqYmlXSrlDJjCPtB5+2sXHg2hXoyvIHN/TcBmz8JjdfXbZTzRedRsWWw2CCxFTFfM6q/g6nUBB+0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhHwbZzITGLPTfIFD3JHAs0kEoquccRUXZ5cNo9x4ew=;
 b=JIq2eEE4g+wR2zcoDgwozB4QI6zspZk299rv16Kz+9bfe2TBBp/oAPTSApkn0aVALefiGCGmd5DHSQ6NzEyikVPACM4Gr01zeaPmMYH+ErFEt9WOEPwsSLAXDnZku5f/AJtTOhBiV0VFvYyZCIVq3bc+a7HaAaN5lEIDnCC60iBXxRVkRZxqWYrF2EtFJNL654OMxVPLWh63BOzOtisSVQb4TFT9jFlUFhqlvfH+nJVXmZX86eG0lBFsOqn8IlYEvXjhdQIdMXYckgB3KfdYM/b+6ymbskc7gOrLv/Xd+zPqzBosqsJ/H5qvVxpyVR114Q9rNDXZypI5y9eF2YHERQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 13:03:32 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c33c:18db:c570:33b3]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c33c:18db:c570:33b3%5]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 13:03:32 +0000
Date: Tue, 5 Mar 2024 09:03:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	linux-rdma <linux-rdma@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [LSF/MM/BPF TOPIC] [LSF/MM/BPF ATTEND] : Two stage IOMMU DMA
 mapping operations
Message-ID: <20240305130331.GA3662014@nvidia.com>
References: <97f385db-42c9-4c04-8fba-9b1ba8ffc525@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97f385db-42c9-4c04-8fba-9b1ba8ffc525@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:208:234::14) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 761a7a9f-e14a-430f-dd32-08dc3d14a901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZivhwCcABrNQEdwgznUEl8x65NVqsYo1AWT0IHK/ytnF2Geg+m5l8BdXMBo2g948TNNqxbYWlUuxIaPaKJYpRvofP3sO09OF8ZNLIeF/Xhso8NMdSRXVnDuUoEGvPJtJYkcHrFswz91OceKqhmZUTgHrQDdQjaV9W41D7oou6EuaONXIViq2cxSl5plELK9r8PNJYlLfStQlJ+HaeSxM47blawTDgBmnZGUgMVrY6Kv40MI59YrutvU5FRQ6TQpPVXleChCIc4klAzhFYymocdJl4Xf65hU357Nyd4b690YQovZyTi2rIFIAHILoPvnQwJff9FNkEUABukS3foKzHiRzyUBidM5lPIq+doc+VIZgWD2JOgM5s5i92NtGXwwKGJg+7fSeo1H8VUcaAoakmMlNfxT2Ay/n96SGKtQvmhL9PilNDolxUvMPSMHZV7qKik5m4W0XNs/018P7WWtYBROMrsmLEa+81Uvj372S0gYGfYtMHnwSKJuHoaYXnR/IHNVTrNy0Edzl5weNBg6iJisfbf3pus+TsMWuyqAuBnemv2L+rmsWCwuRjyiJkJmq3Sfe2VlIhhBCjyVugWQ3yToYV2vM8LtrR0V55JTyChNKfbow5ARwWuHhvLyOnz7+G8dajVS2/8lCpB8SGPjUoiirCdaRHo5n6yt/7t8Rpx0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Z58lEAKeFXJ73KUifURIaSg/7c6NRl1e+75Mao/7tdTsws6Dy6t+2yIVfVd?=
 =?us-ascii?Q?T5E+qNRJc5hLmnP9FswKiXckU60qTIrLaIn9QmCGfxIP2VjDay3IDjr7e/AA?=
 =?us-ascii?Q?tk7H9OobtK1oyEk8Ks5BD/IfOUXRpfeH4GYnlbaEXuf3CtguVz2P93qFDFP3?=
 =?us-ascii?Q?hw9PD3HI9/tYfhuLjRrhQStHlJCaM4efAmAYtTeofpyN3Od2mNGn6m6N/Fmv?=
 =?us-ascii?Q?SWUQTD9o1fztYypEYcglMRpkn8F0wu18Pvu2m92qMoCwuNTl8lKLbrFD94DW?=
 =?us-ascii?Q?D7kCuOwyaJ2/hFMmXuiTas4IgDyiBgHPMdzuylU5QK2jBEnlWe2loBE8GPNh?=
 =?us-ascii?Q?YF0jBli71/SNCGX6OhGph3mULTSHlfBSL3v0S7ZRjoc37WQiJpf45hXQF1Ag?=
 =?us-ascii?Q?K60rwCZTBiHuSvZJOcXp7R7OMNIUpsGaXDcWYkBiSIsuq2BcIBDftdPxLYP0?=
 =?us-ascii?Q?6IXmigZAZeFb6VNuhX+CIAVvQBIE93MzOU5E2p7xwGPSZFao2GArRDASAR4Y?=
 =?us-ascii?Q?b8X245pn+eVyW3nypmy/sgSUktJWZk9bdsQq67uZbubuM1oTMZhrK82O128B?=
 =?us-ascii?Q?vtbEncGos3HpQZNUDpN94Pzu14u9cz9pDrr45RAG8+UTgcx1tdLbgcYyOuTe?=
 =?us-ascii?Q?9/TmB0/gd5hd1c5ATYyLzFrobpXG//s/Rdml+GKQsiE4lJMdO+/q63NhSqzV?=
 =?us-ascii?Q?LKb+qQm61K92TL/mMLE51nfBjEMM5fkeNRSpD9TKeeRT8BdoeEJtAgVYVUPj?=
 =?us-ascii?Q?MG3nWSm8sl51Skzvqta/RucmVGzdEsWJZgxqhjQwx1g5AbTrFNzXK5srnWKo?=
 =?us-ascii?Q?A10OVUZ/OM36JiHsKKfhIOTLgVuxl9bF74cFeh290tayKdddQFPPsoWFyr6P?=
 =?us-ascii?Q?5kwysK3Y5HMWU9H+JgYSFWSgAFtuW5euddln/TOPiUaxzUGSnsjPvZd9evCO?=
 =?us-ascii?Q?nLk5SZOIO2Xw5nXXWTZ8tmtaVUQcMnAC0GOQIc9DUPxjMKRNHLWdaExwTM/r?=
 =?us-ascii?Q?dUGQGeTPtDlipaJ7H7VdH7fac079qGjlGtiPPNvajN4gFkDjwPmZNcKYydJX?=
 =?us-ascii?Q?o/rbSDq7jOMs0qnwSGqvcdeH+bNb/sm9Umpb6NhNI/WH7qg3HxxgUS3qwUUR?=
 =?us-ascii?Q?tzyvMZt5R2FTPhNHqDhDrEYJ+7purM8yjJM0IShwlf0p5NVdLWsiMAWthpAA?=
 =?us-ascii?Q?z3pFdvCEkUCC35q6w2nrBrD/oLP8c4+cb+BKA3SVMM61xv9K8wFlh1gYqZ4t?=
 =?us-ascii?Q?iNjjCdVRhxqH/5YOjl1LGZ+nRmEB7NIgErCrKBecAWXNws7Rqi+3xE8cO7AA?=
 =?us-ascii?Q?Mt/yGEcwXhUYC3y4S8Oc9vUNBboxUSLuDO8pszij4ZQh6Nc4uaiuo4g5nvuJ?=
 =?us-ascii?Q?LR+8V68WWB8RuaobVaDyszN86ZNPnKOwh/e5ZULrLew/+dQr8oQeX/3rK6J2?=
 =?us-ascii?Q?Uue6yGc6R9WutOBfKJWxMFxbFdtYlS5GRFiU2CyZuHUQ2p+ON+b6H3+TUpWd?=
 =?us-ascii?Q?rRMTPq9BITEAhN9bvosYi/Ji33A9MMsb8cpbpBQa8mSfmLFZfwK4MiYRLAtQ?=
 =?us-ascii?Q?lTWb2vfdYhSVeAGC/eiJvf7Ub7nwgcYAy7QK56ns?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761a7a9f-e14a-430f-dd32-08dc3d14a901
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 13:03:32.5512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuZW6Q7xbI32S1XWEWBwJlxiAg8MB31KwiFpkVb9euxpo9tu/9FZWtbom0UPcURi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283

On Tue, Feb 27, 2024 at 08:17:27AM +0000, Chaitanya Kulkarni wrote:
> Hi,
> 
> * Problem Statement :-
> -------------------------------------------------------------------------
> The existing IOMMU DMA mapping operation is performed in two steps at the
> same time (one-shot):
> 1. Allocates IOVA space.
> 2. Actually maps DMA pages to that space.
> For example, map scatter-gather list:

For clarity, this has come out of last years topic on the "physr" - we
agreed to a general direction where instead of adding a parallel DMA
API surface for a new scatterlist alternative we'd improve the DMA API
so callers can efficiently bring their own data structure.

https://lore.kernel.org/linux-rdma/Y8v+qVZ8OmodOCQ9@nvidia.com/

Jason

