Return-Path: <linux-rdma+bounces-4521-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF195D026
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 16:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59041C2085A
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC2718455C;
	Fri, 23 Aug 2024 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qoID9Tcj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462D5185932;
	Fri, 23 Aug 2024 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423950; cv=fail; b=GO6GZgJWGJJcVsc3vl7Humw1yXj39GugkP70lMoix4e0sZDAZIspX/daJOM9vSp5mPOw48BESxlX932FrmToTF01kgleHysEmZ1IhYVWASUi8ClMJTXe/ES+IwNIPBo9WbnhusQf0m48WXGL/gsUbEz4Ofj7vRoqAWUZnRG9hsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423950; c=relaxed/simple;
	bh=Z5WsyJmIVW5niiqVEBLMo0rbr4EZebWfIDlDfNASmjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tnWovQNrZ0At0VWHAMAKA73lzwneogFee++TbntAqNMsdkGVhZ7Qb0xqp2ElwWIwvwNJaI0SUKyl70VxyRquAzTcMQYF2MMQO+IZ4Ici8oVFb8P0P/xF9egk7PRJiWlV9MZk6edvH9IKNQEfhKciSrJGyHK23/dO1sEaetGs7dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qoID9Tcj; arc=fail smtp.client-ip=40.107.95.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCBsCZPwUhxJE3wy7oNjdpZCcAE7DCOZOql6oMVIDxze+riVyNo0QjbCJOCuVyjDYHW10lNcwHYlUVTuifTn0hX9pZfsi2zycdUH0FDmnk2rqxbVh0QZe01PV8s767vQRhWNzXIhfs5Cd08Vtn0JdPNYwOHBrlWmrBlrGQq4jpL728IoqeMZ4SNcjiFwihZL5HCVnbEV/jNdQR0mfSxw4nwy4fHcL9R/zBMX/71A1dRWRD0WFEuCzqAXtAZOlk3JjNxmA6yzUp0c4CvqP7Zm0s+ii+Dr/1abjLm1Huc95BkBPHj7dsYPZEi4BTNVr00iGaXRDlwSvDaup5c/sH5EFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1hDf8Mamw3mKMJek6wDJHSepROA/ae468xczMM4HEU=;
 b=vr2I7EH+Gm0+opSy/AiWyIfLxIlNBG9mZM8jpu9Z4F+e1cKqPCtk4Bz3TEDRfumRSsmHa9HnT6kZSveGvlcz+WPsSuso2wXeaCGeyX/ckH00KJeDOaJAiBswiWGzPrnWEnG0mY8LRg4i0vu9UmJPq/iEBLn5PMCrhN4PDEvPSEUHOqVkfl7xrr6OZi7cuBaclhhHPuJb0eBS+sZrxkHoYlT+yp0rraEX24nva/fUpRoCwHvPRucFi99jo3V6sqX0TDOQY9kGs89DN1l9AOPP9JUOwrcqjkvwCBCwqGSmOZbtWepNxkXoEJsFMaqPT+gmplO1NmApO6lbRLi3mEviAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1hDf8Mamw3mKMJek6wDJHSepROA/ae468xczMM4HEU=;
 b=qoID9TcjYT64bahimLSZN6sV4anqqMcLHDMBrsQ+KXYbL6uiR56njNT0S9P+zKGAYRIHu0um1kFhvuG6AKFXKuvv6BfWmJLfQNYxOggPOotJ6UKbj6JXepRgEznOp/ZsI3bkYQo/HqsTpdrSncigZMth7cTjlCCdk6g0HdBmlIBjeAM5DUSuyTeZ03OogVmiaRy0w8EBH6129UGiNJvGlQFX/WwEJ45p1R4RGCVfZfpLuAfqs+knFxwVr4hoQ4wL1J9JWpIjwXxPheNmL+ZWrZJM/TNQDTPB1P1jPzDPofkHEiMmTOvN0YduGbuZOzMDtAK1SCRawwxFWk8u6zmWhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Fri, 23 Aug
 2024 14:39:02 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 14:39:02 +0000
Date: Fri, 23 Aug 2024 11:39:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: dennis.dalessandro@cornelisnetworks.com, leon@kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	bvanassche@acm.org
Subject: Re: [PATCH -next 0/4] RDMA: Simplify multiple create*_workqueue()
 invocations
Message-ID: <20240823143901.GA2284836@nvidia.com>
References: <20240823101840.515398-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823101840.515398-1-ruanjinjie@huawei.com>
X-ClientProxiedBy: MN2PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:208:e8::17) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: edae886d-778c-4119-b2d0-08dcc38154df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?05qcJCfbRx7CEtJXi8YRhIHZX5pk9/DH2x+yoNC5F+ZwqL8vi284lrFm9I3J?=
 =?us-ascii?Q?GtedRrpSTAqWnNH8undKmg69PCXsDgDUqtfkSBB09XXLE6rSqDHtisL7ztot?=
 =?us-ascii?Q?R+0L8aWssBrsqpxgbkbHLz97hJQNgEI3uaLhXsEXA7EUcB2gkgdQbNLawBnQ?=
 =?us-ascii?Q?TwuDd7TUZlU602SZsn458CwOMSEgFaaH/6TbM5ITZ0y5rjxLUTEPjMxDRzdu?=
 =?us-ascii?Q?cDiVpQ6oeMnj32CnnfuQeR3TB5Oi9gJFvMxC8E4rAOO46ZMaz2ynPVdSSA8/?=
 =?us-ascii?Q?iM2brdRaLNlITM5MDgo0d1znuuyKR9XQF98ChJXtqL+y3iFDuMzJt/7YAkln?=
 =?us-ascii?Q?zitIQFwARzINe5CZMiUzeEpRkxmrgcSplqts0jeQoaxHyYNwsmiHvDp8Xhma?=
 =?us-ascii?Q?fnJexfA0KCVILstQFrtXGVjRUhDHViaE23j8j5ESZJVe3gpPjzbZfZ9Nvr98?=
 =?us-ascii?Q?qDqDC+FrGyHQ9Mah0MbIUaRMdDCgSODI6czScKNk1gIx/n8iPgXxOJc/MynE?=
 =?us-ascii?Q?L6mA58pHJasSAunqT4W3zPF62uLZPzIBwChJ6bO301oHS380CnRpONujWD45?=
 =?us-ascii?Q?6ZozTXTwujCtW5AECGpzMRvsUhqJaP+phbFR2qh06PEp8qaX66ATMD9NA/Wp?=
 =?us-ascii?Q?3/2qeBSR3tx6yEszSAd4oSMx2gx/oK2w7Q/hv+BxR/0nEBsdF8n3zE3kMLIr?=
 =?us-ascii?Q?nCLXS/c3Aftu1fX/BEIpOt6RQzzH7CGxWy87i7Ot2okA8t6jLnw8J3xF9PBB?=
 =?us-ascii?Q?jjnEJwrGcNYUhyadyX52nEa7rsMAgtjtbMVtfGA+DUawp+T5mC/gil780W39?=
 =?us-ascii?Q?RNNoCd2vimuPOO9Uwn/7e60r5GLVcKSLoJKuEt7mKaBnQdDN/Eo5aLcOG0xQ?=
 =?us-ascii?Q?cdmrK2yYMoPx9Psn37dsRSxwDqTjYT84vzHw42vR0Af42SP5TJqTIWRjUNEY?=
 =?us-ascii?Q?1LCE2cxnYjKYvddEBAPATEpj3rY5b0Fewk2Vhz0FV3+b/6cXcHunHjxfZiHE?=
 =?us-ascii?Q?tKUPM2NDdAJzBrsjW0pGfiSR9bADp7duUN9rExEJyW8Oc7tZLdby1ntyxA0l?=
 =?us-ascii?Q?IKp/IHHQUpTlPWPucFllWBPCZqZBKUPDMMUwOUeMPPVO08lf5blG+Ob2XtcA?=
 =?us-ascii?Q?bstFlZwEWUlGOJTV2xAdbzCzy2mLx/zIj2X/MYo1WIOg7uvOM67R288zalag?=
 =?us-ascii?Q?1RzuZzTrpC6pxBJdXTF7ju+DRwxBxFSB/fDF+oeL8pt4TyVJeD6N78IHfKmN?=
 =?us-ascii?Q?trVkA55tZkQTnYWIguCYWtcaPmu3xXm1pghFeRfxmaHGb7gzjoqN8Vx7z0Hf?=
 =?us-ascii?Q?8rP4UoC3l7l2mXgPGwPTRkkWSwGwiHAZiQUl4ZiYCRwLhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R0ty2xXFEDKnAp6ulmj5wF4FqFKJtRIfZcX9s+9x8vQmQxOZEQ4cEw+pnTDp?=
 =?us-ascii?Q?AeYfgQeeQb8WRw1uisLOiXe2T3mSeLt/ersrXL5qXrQNOuQf4xarq8QX4cd7?=
 =?us-ascii?Q?Y2Ht7yvXpNhw2KxSYUXXoya3KKLB+RrxIFDd/jg4QYS1cFiqdeD4Jfpg8uXb?=
 =?us-ascii?Q?NXn6WMSMjWe+440//xgB1H4kdWMoaFXZPTttcnvwxWahUOeTHoaescfYQW9n?=
 =?us-ascii?Q?ooO388ko8iLWHP3ksOgk8Masr2+HyVe5RkD2tM1ygVuIWFn6gxGFIv5XoSCj?=
 =?us-ascii?Q?keI7FrEi2/0pnmVrAh3+B+agiQC4r1/L8pVRsQ0dNFWmsz7blITjVbbS/xwD?=
 =?us-ascii?Q?T+xs42uwdbqfOPQkA8yHpqAQKElYV+uPoJZyFQBGIidNZ5wCY48R32MG2Klu?=
 =?us-ascii?Q?tKvM81/zd5tcMWDT4hh/VUt7dYCj4Vu0KDGPY5n7XWZRrDf1i5MxWSaBgsY4?=
 =?us-ascii?Q?8PoeuC5WBpRIvmmGHn+APFZwZ0lwaYuuRLqt3V6bxThVAHFI+HVLKNxbiqVN?=
 =?us-ascii?Q?Anj0wDwFhZUNGtst2UY6UpAAXJfDxbOZISxKWKZURcCUo4IzuE3+z+J+ma2T?=
 =?us-ascii?Q?Yv55oCDVa+VulSZJ1dO3BKffQd+zuGs6ScoN63OB+abzTstGkqJeSOvAtU3G?=
 =?us-ascii?Q?BwFh3OLlkLiJ4yNU5/UPsqhukTushqCtneMmlTwwsE13cEIKweGdTBpH+2Qr?=
 =?us-ascii?Q?l8+ohc0NyvrqMj/7QSlVPakQeJUUkMcD6niCmjowJh9yzHkI/mxzUcyIxyxL?=
 =?us-ascii?Q?MtfN3uCWo/QytreEQ0Xyf0853NRUTnsiOlwYN+poY+gofPDxSRQxWGy3qU3K?=
 =?us-ascii?Q?7WzgHxKnXqJsPgJaPsJyR4BeEiKjCgR3u2/HDkxngdLXM4ehCwK9tkCpvYRc?=
 =?us-ascii?Q?CBk8fiJyHzHsQ3Zrst0ZfYmflm/diJL1dcZx7Z4rOtbBk6sdNyISBgduDkbY?=
 =?us-ascii?Q?gh3jkQ9Ir1ZHuieo4BXviAmkRkqPP+bo3/V/f3zXmRqEu4rdSUG5swka3lHP?=
 =?us-ascii?Q?lCabKkGPONDR8Duu7mL1vxcSun2c+Zq+g/RtTIZ2HXaclAMdntK8gjwYD/a9?=
 =?us-ascii?Q?9XzAlvkzEgkIKfTM06kOdsguQ05UFZt4uoach2QOxRAAjDjmsvBfsOx5tuiU?=
 =?us-ascii?Q?rBvZF8AL9aqy4R/VNgPRMnHXNUfjFYw2v+09AXFkVtebGAVLPcUygi9nsp9K?=
 =?us-ascii?Q?xz9ZpyIE1k65P1AgrL2dwS1mbl1Uy0KN2VoMhzf93of/lo3wAuPcmudo529+?=
 =?us-ascii?Q?/CTTK/AerxZTOu5OJqU1AtL8e06cAruZjJ6dT5FZZRyHwB+QAFShc36PP1jV?=
 =?us-ascii?Q?jc+A1oQxen+0ZyoPR7269ftBI1gu9SlJnw/aZq4DOml1NzTXNYZGeKqvKE+r?=
 =?us-ascii?Q?KJM5YWsfamDHKZmqg4ES6UhLHFzu4zfDUjTlMLNJzgrAlImJGUX+Y3iIcRtf?=
 =?us-ascii?Q?nyw2zUH7gcaTOp0EGlOTh0ZyCIykfIMJYUGi136QqavLqJwiaFy9g2I9qjpF?=
 =?us-ascii?Q?VGH+4TDKJOEodoVRWuroSbdRCdSQxXphpuonwJ2p/RbfTPSAL+h63GvTYTz5?=
 =?us-ascii?Q?GMpykW/qxnBkXkx9n5CcSFSx1ePTgESfZNRz3RJc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edae886d-778c-4119-b2d0-08dcc38154df
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:39:02.2962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYCyFMY0WxG6dxP2Q+iW5VBOeYHUz2BI1CfKPPLp3uItiwSVODVj4pB6akBDlJSB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170

On Fri, Aug 23, 2024 at 06:18:36PM +0800, Jinjie Ruan wrote:
> This patch series follows the SCSI patches of Bart, simplifies snprintf()
> to format a workqueue name code by passing the format string and arguments
> to alloc_workqueue().
> 
> Jinjie Ruan (4):
>   RDMA/qib: Simplify an alloc_ordered_workqueue() invocation
>   RDMA/mad: Simplify an alloc_ordered_workqueue() invocation
>   RDMA/mlx4: Simplify an alloc_ordered_workqueue() invocation
>   RDMA/mad: Simplify an alloc_ordered_workqueue() invocation
> 
>  drivers/infiniband/core/mad.c           |  5 ++---
>  drivers/infiniband/hw/mlx4/alias_GUID.c |  4 +---
>  drivers/infiniband/hw/mlx4/mad.c        | 10 +++-------
>  drivers/infiniband/hw/qib/qib_init.c    |  9 +++------
>  4 files changed, 9 insertions(+), 19 deletions(-)

Applied to for-next

Thanks,
Jason 

