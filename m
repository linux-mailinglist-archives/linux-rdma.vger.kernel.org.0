Return-Path: <linux-rdma+bounces-2948-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2DD8FF03A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 17:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE878B2D94E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9FB19922F;
	Thu,  6 Jun 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UvqQK2mR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88524197552;
	Thu,  6 Jun 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685306; cv=fail; b=i8XdTCyX83E5lENmnNYtt7buO6fuGiU/HRZ/T5YjOor6ZWMHhJB2fdnb57XCxHhMEfcQMp6WfEreCmTa4XbxotC1wkru5DaL18/betrkAtVkrDEYN4MrSLq4OEdg5sQhI0SZPbElomar2RXTpq9GrO0H/6lT9nf7lfTvE2qsKq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685306; c=relaxed/simple;
	bh=5Kctp+pKPe9tvXbvhhEc7GTDnQml7mqF+yIc4Cuvri0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AQQzmeMCX18ZUEscWxaZcLvZO5SVcqwolOPBWjUMS06jSsleTUYgTCVIQRdPgLGKkCWXX0dR5WRh2mWVjXzjaI/0s3OpMkjpDp+eDu7VDFkr2aMcnJV9zQ+0haJuWw/9XS8L/6CRXKf1WuzKHWYGbZwYHXpMrZSQbh2yH6ssZ1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UvqQK2mR; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gzd0kIKyHt4AfHPYxS6eiFHSX7RYN62mIXc95K/TzSVLCRaZ1YyafY/LP0d3Rk+KScVbVhcAT+YhynXhLP8u33yHul45jAGPkvQMI1KUf+kjONY6MY+PhnFRxRGwGJgaoc2eqrfl5SnH0wWq3lpYmBrs3yfDU+NgNCOhV7v13tgmo8FMDm0Rcld5XqoisOf1H1Xs09YdvU8gRbgGz5xuRKQw8xUM+GmN8JFnzfBWP7SaLMt/K9aFTckfPY621cTkYWswyhoFAD44TGp9cYnJHyDJQaRh5K7dxZrfqAG/2OwzZm/yo94zEhEPmVdnEEhXvfjihcPZNUvKFFQniyfXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Kctp+pKPe9tvXbvhhEc7GTDnQml7mqF+yIc4Cuvri0=;
 b=i3HMIXBqk4x83uD2K5w+c/A8Hj1KpAvQXVn76phcVXMFLo/ZWAAfFKwpaNAlfwSo8kGyipKzoGutxpGrOcOxRffNt+xOMxf7J9/5/NTd5uc8iGN9vctn8pNMkSzA9teynf2cmCrWSFnCv5gqo0lmMlvB3yis35tAWx4U9Ejey1m9gxeOcGwouq14xbQkMDE13IBOK3Vafk/dkY7FH1DoS/oKVijrZFH/53OJgxtwYaULBXvJTIf81pocYwh7KOJSzbYRV03FUqWOBIUIUE+0sRrwWw+IaL38qu88Sa/MWVFyBXg8aOFzkZnwKeCwosIIXMj9IUZLxAd0xW3P1RgwDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Kctp+pKPe9tvXbvhhEc7GTDnQml7mqF+yIc4Cuvri0=;
 b=UvqQK2mRICars4kpv6VtcEMzLZg1bdO/mOKhlmm1xGrhX8JsMtOAHkQTSC/xzB/anqstI86m7CV2iobwlylAT7tbH6V8cp9EjogYYGf7ZlkeyLQg9Zv8EbAZns1i/U/LUPn5Spzxf3WGWV8Kupoa69CPadud7xuQGTDdif4omwSmO3OBMFqOBydTzbEFpJAbnGSKRZDsax6QXDmH2yWGUurz+Ya94wgxj977qFHmRz3PRaazfz/+uUxOuvEKe9z4dQ91W84Xxq9odo6JDy6Geb1NjDF/LHtyf48NzU3PJ/GCHs5EDY0ea/EmnWH3RBMHABbqDnqAAd1N/MxjAkCdDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 6 Jun
 2024 14:48:21 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 14:48:20 +0000
Date: Thu, 6 Jun 2024 11:48:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240606144818.GC19897@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <d97144db-424f-4efd-bf10-513a0b895eca@kernel.org>
 <20240606071811.34767cce@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606071811.34767cce@kernel.org>
X-ClientProxiedBy: MN2PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:208:239::7) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 9178e485-df82-4080-1309-08dc8637b59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U7o3dQu8pDVah2dgpx8oHWIDfA/ttleCd4C2Z3LdQ6xf0rMZ2pzAtGYYN9Va?=
 =?us-ascii?Q?VUiP3VQrp+BZYBfUuSAmvjAhoULfiCM6u/eO/ov2N77SvPUBiXAtuHgLugVk?=
 =?us-ascii?Q?0x26VQK15jkV9BWLPnDB7z81iswLaK1IC7OckdP3kaP5Jf+FV8NAQrPCPNTs?=
 =?us-ascii?Q?pIpeFifv1wTAXDfHdtOZQ4LwcxG5Kr8mgzw/eDoWVuPgWBdZOArJkU5F960s?=
 =?us-ascii?Q?xLq4rC1EN7XT9+ZIgvRo3SD/sMnFtrnfygGYzkUKd3br82T8s6M/FnXkOhTc?=
 =?us-ascii?Q?OrFvPU++dg8V5POTpa0gwsoMtcopJKf7ZQXIk09sfro86EbLq1ueDOLEV64T?=
 =?us-ascii?Q?XmZS5a6sTBr1Pv+kxMOQoFF7mEZcgsQezT+TSrohKb/9t/w9A6sRcOPiMvNQ?=
 =?us-ascii?Q?pTNP+tnL05ivPt5bWtw4OktkDKC5RqlpbyMSoLfyxeTD1xqjkx/bQW700qae?=
 =?us-ascii?Q?PvqZCB0Sx6bokib6VaBU7nZGrcQn79xBm1LWBpx6F4qvLNrXOdGtxvVEohLi?=
 =?us-ascii?Q?6TLsLIdQzH+SMNuWMUjfYnX60lYhhjPdHA1ByNoqnQ7sdbLklouOofDi1L/T?=
 =?us-ascii?Q?QyTVQQh2TMRcP5eUCduVJRx7CtvDsXyvYz6kiMJscuUhYFnoZZ7TYUgeDb4T?=
 =?us-ascii?Q?06ljnFfTt/VxoDsORrV/bpKSTJF0y0LzlW2abXWDArqHBcg50gedvCaHoqYQ?=
 =?us-ascii?Q?z13l2RCYkGbV0PMgi6kxNqTfx1Det70qYQ3VYYXkvOrp53PM4u5ZYRrw88F3?=
 =?us-ascii?Q?H0MrxND405hI6V4SQ80nkim/k8mc3LgaRtH49eaRdofbgvOHqftN040hnT7D?=
 =?us-ascii?Q?7oC4HOqgpGGNuqAF6p2QfU3ok3EWEOIyBZVWwLBmQ8VvY4LDe8BQQXqIFzTv?=
 =?us-ascii?Q?ikVVGjnkpmP2i1Ta3ZvVcuBZWhJf6rXdb8PEMCqw2aMbuZAtiBPSyGvjpNqn?=
 =?us-ascii?Q?WgcmTnMTQZHGskcdk8mb8Z7T0LIXz5JT73swpPy6Huh4zg+JdNp3/P8CkQWX?=
 =?us-ascii?Q?hupSrzU4zmFNHOS/r/A7kfbzAjtdksqbIJHuj+Io/2mCUwLUhDHfvO7oV5r7?=
 =?us-ascii?Q?MWktOH9lDD/AHoKXfrPwK4TqA7nMUuZH1C46tBf/PPfJkeA3QWYm15VF7CaL?=
 =?us-ascii?Q?/UPCNXJqEUAaAH1+ySUQI15Mkznl9HJLyTWk/Nf3a9RZFBZuGzkV41Tk8LjA?=
 =?us-ascii?Q?nWhuC4/YP+jImvtOYWnWYYFXoh9Ib9aj2i0LWndoVEOtzP0oS4NTsQULg2fX?=
 =?us-ascii?Q?P3o/FMKpqBJ/Wj2nSbMMVnxeLozKmLvkce/Vn/bSrkrhiRXOCChdDj+Nw66y?=
 =?us-ascii?Q?GiTHxbtQkZt7qTAZYa3/53e0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+FpPl6MThnNfgWbZsldfT+kqmpR5ueBKrd3ad962RqMnvdzgXWLJlpuRL61?=
 =?us-ascii?Q?h8WdoaAAnS0aBaC6xNvlR8Zp728tVWB0f3VnPJxe8RSpVYb+unW/ukvGQxuz?=
 =?us-ascii?Q?MLdGfna0L79boOsGHKtL/+ZFRfdfh4WRIy9MmDC7fg8lXF/hZ+TRffoT0sHe?=
 =?us-ascii?Q?ZLxsx0VVjEs2I5m6bxwZKXua2YkQ9Hzo+uuBHmxJDkagGUlFaEbcKM847JpD?=
 =?us-ascii?Q?X24TaPZbr8YCEkTlaELiI5bh22/wJBC41NKGocAxHx3Zc3rtMMT1oFWv+v16?=
 =?us-ascii?Q?9hAK2TiSlXN28Md8Eu1Y2DI99O970PjTMhrByCH9yHI/XX9zF4C0C5PxqGri?=
 =?us-ascii?Q?JEXm0BZ1JbIRvIbb+mzMz5kayoa/Rl4W4hA+ZoFPI0wU8MGcjDHvxGSLF13r?=
 =?us-ascii?Q?47nHEjNB/gsm5b38kq8ljDrWaGXstDmjshXP9EV9a6KukJT9UtQ4tFZxwzG/?=
 =?us-ascii?Q?k4K4ncchmFDrdWULZEfnts+Baai/8ciecaiGebgdjQR14M1LNv2O/cIYLWSV?=
 =?us-ascii?Q?U9neX+W/Z4ck6vjX/rXbkaKuSwrBG5xTnAKf4cTqENFeC8jPOu2t1LcupvZn?=
 =?us-ascii?Q?LYEvCgaQ01GNQ2g4CzotymvWFHOZ+Ejz7WUm8CgrnVHa+jRcr6+Pqi2Rxhky?=
 =?us-ascii?Q?axKSSI02L3uUGxzy94yXJDuT2AXZqR266sy4G2dx99n40iAQgn7ONOpoO82n?=
 =?us-ascii?Q?E6Gg8lBRDLLa4/9OkKbaqEMpWUnsaiH5Ibv0ohbeckrGOhVvudLD/qTBigwl?=
 =?us-ascii?Q?5LVi7UkIaJGBQdb1FzqLJJFUgyqNF20bVyr4ei0co0X7HRYz5y1kHFSVriJN?=
 =?us-ascii?Q?8AiGy0Lj63pCUzRU+oMLBhCTw/DqcTqbGYqQBtQUHEyQvfSRw3vRe3g+XHga?=
 =?us-ascii?Q?3Cfp0/gFm3Rx3FoI6CCo8lmwz4csgKza9AyN92gpESaJJ+4ISJZTcDdaDcBD?=
 =?us-ascii?Q?UQh6Ucr/elVFrFvHAHzKbleJDcmMkG8JLfQS9wi+DnfHtcFcmRG4I08H5RE3?=
 =?us-ascii?Q?FhTHOhsLNHNjuyZgvSloeiwW0bLfhiaB+x8+MHcVJjTxLUpALBlpUjhq0fdj?=
 =?us-ascii?Q?/QdTkpVP/+AsekMUlIFng3wen1No1E+9Raaggfx5hZFPrccm6B+lHy3Irtu1?=
 =?us-ascii?Q?ZQkP9wu2wH6OvUI+4rOnD/E87Mq7OJP7U5OCdZST/NqBZY4tr/BL+YwKlyct?=
 =?us-ascii?Q?xWstrJEHtf3lcamB6sxxd7tBVUJhirWqKL9OZTnC7XRtCpL8TL8q/fBU+8O0?=
 =?us-ascii?Q?1279zNfS4oDmZOi7CMcLd2E9vvvyELVhNAFIIztdm4kfwNQVEJd5mnPIbgl9?=
 =?us-ascii?Q?c/zm+2z8QewTp+4B4VjAG2cLVVendwwwUFd93rrtnt66OmkQekdhAg9gpcY/?=
 =?us-ascii?Q?FRIFWsYYIJTra6UtxAZ2trEFqM8gYCzi+Rbd4BdIT9cA/Zaf8vRcxANoyAJW?=
 =?us-ascii?Q?07pKpK6zD7vMrUB983WK/AJCOjaYpVu72AnulWbThlvpc5kzSohWarXekGQF?=
 =?us-ascii?Q?0gjb1Cq0hKDaBinemTVhbX56vXwqNteagyiIYcrdbzbQWQCGYxFBOBmi9H8n?=
 =?us-ascii?Q?2YKU+K9+I8kbz9OuKkp+m/zhOuYWOGGBfdRPRR4L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9178e485-df82-4080-1309-08dc8637b59c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:48:20.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJWUmJmvCmIOkgLe1t95GPEAnvDyPjKZZuHInhRZsLJVajgrLEpp1Z8UY8YdQdhk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171

On Thu, Jun 06, 2024 at 07:18:11AM -0700, Jakub Kicinski wrote:

> An argument can be made that given somewhat mixed switchdev experience
> we should just stay out of the way and let that happen. But just make
> that argument then, instead of pretending the use of this API will be
> limited to custom very vendor specific things.

Huh?

At least mlx5 already has a very robust userspace competition to
switchdev using RDMA APIs, available in DPDK. This is long since been
done and is widely deployed.

I have no idea where you get this made up idea that fwctl is somehow
about dataplane SDKs. The acclerated networking industry long ago
moved pasted netdev in upstream, it is well known to everyone. There
is no trick here.

fwctl is not some scheme to sneak dataplane SDKs into the kernel, you
are just making stuff up.

Jason

