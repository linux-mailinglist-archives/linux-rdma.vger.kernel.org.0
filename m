Return-Path: <linux-rdma+bounces-9201-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB54AA7E933
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D301E1889B6B
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 17:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A6121638E;
	Mon,  7 Apr 2025 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IQNO+qlX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C72063D0;
	Mon,  7 Apr 2025 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048585; cv=fail; b=CbWgchpTXcdheM3+VzA7yqJPtfQSK4G1jOmt+CuhL/eHc7O1QqNoqTnEIF3bRAk4j7p32QT/Z3iijkZEL52H6y16or013r72/Dps75Vk1/bdLRXanRKTYUp15Xl9YELcIFIQ/G5PjX9wEf3OzDZy1gS/ih6dB+UtA5HTujjUcUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048585; c=relaxed/simple;
	bh=kJsPF68VEa6v/B/ifT9aa5o0sPHCoPVMY2nZAZHwbqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q1pK4S5KridSsxdcpLgFwylwduZ7YWMeTYOQ8qhiicrk/benZ2vK5WleonX3LDQCODLB8MMN/G8r3O6VF+o6U1QqGVd+xM0S4JA8Mm3i8bTMl/prB8djw8aOmcLMtX8VJQ0JC28cbBBvfFN/1lCFvW+s93GojzfC0MgZOxibGvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IQNO+qlX; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rb8AtMxLUpifta2BoKS1wYTd/2wHxU9FkbDlF4h3ewKnoaNf07+BOMTxywh1M44L6/gAiilnz3FDbTEwMGrUqUtixDcF283X2cf5Rv6x2Xzx8HxPS2eEE48QIibmKG8nPs/2YHm8oqJcIaZ/tLsA3O+ZQgj8LqhaeB6po6qjBNdVNZuDpdjm4QTvrZ8EFLbesrygyV3wlQwPiLlFg4PIaPo7jVUidalgVySoLk2neLEdR+Hnewp9nhys7iIV46tSHKazvmjYcdlanOPrufZ3zG2snaf06DBJpbKM0g18B7sJvY+9ReSym5otpTTsa/GQNw5CurpufCjDZzZ5zIFe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoG+o00zqlbEJdg2cMVkoh7L6OPdQU6Zs2gz0lRqdhw=;
 b=CTGhNfK12U6/rt0RtmvRhKIWA7x2NYpejgA0ZWV7C1bUihaHCN8M63rnRyCA6AmFrl/111hrlwKQj3jaI37Dg7TfWOPOeb+/dWWNJ78oxjwychrvk9PYX61Rddxgg5X1rOj8mM3Z+mfV3EouTWTjWTwRtm+kK9sXYXELqTeHbtDkcnX0Z0v/C+ydc5e6bm0oXPx/zHdMFzHUkFmVttrSxGbr8rv0Byp7e6ZnkfxUu27dTNMLdY75XFsb2DvKWIOV0+gbuTRoAIbI7x3HKyUlmxM9slmJzDcucSAWTy3cRCbVlzfoumJCrSE50kTtzk7qwJLwtjJUyFXI2+RDqS8FpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoG+o00zqlbEJdg2cMVkoh7L6OPdQU6Zs2gz0lRqdhw=;
 b=IQNO+qlXD75huxSrIWFSNTYPeR171WAH440UBkjjweZGmtxUiKBjqIDbfHXMd0WUmkZC1QxZU4b0i9TM9FnILoC/bMNx2TRfvnTWMd13P5CZsh1VuVvzSESCty3p1HzW+xxn2hlP4wAnTcy9ONC++9+wHDlOJYlbYpMrpUzh1pjEPM/n/HCEOSk1Kp1OIp5JfMEurfZEvJKmUsv6158mJfXDLag2oYxGkFX2DTgL34cmdAVS7MA3wsyNVd9fRubakiSNBfadFrbHVHl+f9OrvCKdsBExp+yZTbdxk+q9V/qTM34TRELv9BAFfG2v153q/MMW7YfvDeSuuOiENk5zfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB7552.namprd12.prod.outlook.com (2603:10b6:8:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 17:56:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 17:56:20 +0000
Date: Mon, 7 Apr 2025 14:56:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Chiara Meiohas <cmeiohas@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inifiniband: ucaps: avoid format-security warning
Message-ID: <20250407175619.GA1730095@nvidia.com>
References: <20250314155721.264083-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314155721.264083-1-arnd@kernel.org>
X-ClientProxiedBy: MN0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c903964-2348-4d59-8ddc-08dd75fd80ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZRnES36a92/VBPSPPMwQo9izs7e2fnWI9wEJsYcj9zj9H3jAIeJ59EcsXaiF?=
 =?us-ascii?Q?/jN5edlC2GCKuRT8SH45fhpUqQJJqmSjeOts/SMSejxytheLQxSmX2NnbCzZ?=
 =?us-ascii?Q?M+oxYeQwKnLHt8s3dk6rlfrUywxJHY1SV0PLdfzSdqWnSE6rF/y3XFNNMmTG?=
 =?us-ascii?Q?bc4AMWoyqCybKORqfc++ZQcV8S1NiHyfrt8qsnatNNT6WX+pyWdKJKMJS+iB?=
 =?us-ascii?Q?o6qtdTnzTttdXyCymn0G4o6whVHf9RU/2s1pk3iqHTL5lYEKcXza9eVxN7f6?=
 =?us-ascii?Q?nJ/02ye/isQbWEgIah6Rqs7AcR8pYwBKqiEZVWziWPvI1uMWRAvoR5RvgG/E?=
 =?us-ascii?Q?U1ebCxAoyVu2Ch2aSIS6vFngRK619/OP5FEUK4ULO4/Mig3lD14gXFpEve54?=
 =?us-ascii?Q?ZZHVz3NnIFXZOaDyGRzRpzGw6eFlSmhb6TQDNcIPgCa2cOSOtYENQSV3CoQn?=
 =?us-ascii?Q?FBxSD0j/yXB4kSGHnB7emkUVffi+rQw9QBj4t10QsMfc5e7Q5iFiaKpxPp2u?=
 =?us-ascii?Q?41tDbXwWPdxIWdZK+eTSoHRUy1y8ywH43fPpZ7NcF93Zs7x+lpaoW0obJLtv?=
 =?us-ascii?Q?FjjBAXXR1g3G6qR6xc7uzgcIrhjlNQWxunJhTSjllfQ0XfJ/+6Nt2GvxMY/h?=
 =?us-ascii?Q?dghTHjJHq7d28f5o5OUprud9wP6ZZN1PkrdTfNnvUdbz1dRY7f0B0/JZWaB9?=
 =?us-ascii?Q?m+aGXsk5u0jvqQZ6lqPd+BSNI7/8+2ZX3dT2EuUTJ+P3gZ5wXAhpGfrj/vpA?=
 =?us-ascii?Q?Z3nR6T+c/5SlDpn3JkBrMJJyh0G3dOJhsQH+kcGCGzWSGu2GyWKUL/M3Lv/V?=
 =?us-ascii?Q?pXOom+xcBmu60HAz6umLa9Gpw7tmje4OOA8eBod3sPdqf42mS4bLzOyuKh7A?=
 =?us-ascii?Q?l1rjtnL3MxnPNqhbgYilTzfaAtNrHE1aGuwdIvnQfop2sGiVGtPpm95o1o0z?=
 =?us-ascii?Q?9LHN5SHtcqrO30f8QlF0w0bu0c7mq3bCJ9mLILJg0AncFtmThC06dd04TBTf?=
 =?us-ascii?Q?LYo9xKJ968jYgvA0eIiJvEUYOl9MwOpPbrl7Z8GvldmfqAD7kS5vqJSLLyko?=
 =?us-ascii?Q?x7aphmFcmMZp9Rl6n9KqmkR7mE5jaERgCkjjMyMKaAmHKzXzXVdSQ4tY2+aa?=
 =?us-ascii?Q?PCSdmcCFBdxqeykwGc00OS39y4g7NdfdiY5I/s/wiPRIqW1I1UzuPFLduITD?=
 =?us-ascii?Q?jQBT0fMYiphJuTJZa+YuBjGoVnCaYCWNMxJ22gcfzaNJ6pe4mPk6ULg/VQdl?=
 =?us-ascii?Q?dcybblBTxDOXCpNSs2Oi3GMY9Kk1U/2lZTdzwUVu4aRO9lnxbhFqpxtKT/FD?=
 =?us-ascii?Q?G+fYc7sKX6wlgKtfiZD2aED6Rdn+vL8ZbyUiiG9NqG4ACBfESj8sr5LwkWZ7?=
 =?us-ascii?Q?e6pf+ZaRF17RuvOgFOKMS6bXMAS3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C/WjO4vBKwpWC10zjaXp/sKcq2xWhLc9smKN5JTsjfBvmcbRkRHSk1RvfESV?=
 =?us-ascii?Q?jGZlox37y0Qs/q5vHyKuDEHuwOWFfJGuX+gSiSIlhWr52wYB7gqyDWudq5CU?=
 =?us-ascii?Q?iNKgWDeJrKNvRrNmTr3n754VnTkjBlCZXoxBG36gZj892umNNZ3t808/ACF8?=
 =?us-ascii?Q?9FUx1bhNBJGXha8ZPtLTiFlfVQCks+VGFHXpfr5ChLF2Fx03zy8jcPJ8dLRt?=
 =?us-ascii?Q?OsOvD8GVdguc4dNUdjbj2CERRkv291t+mnmkNE1XhVN7DUXuXGX+9kNhVKhM?=
 =?us-ascii?Q?ZOamEh25UaBL9/CTwq6rtsgvAy0lteK7r7pgZXIMKbakN648c4sevy+gd8wM?=
 =?us-ascii?Q?CaNPhmOM7/AiqSnorHYBZc4nEJCpY+5V8wbiajHwjVgt3GaAgB3waCpyFlXs?=
 =?us-ascii?Q?E95RNRhjwJLPJQBhkwr08EmP/NAtkmPFfSbjJ1ltGSh3+PzLhJRStFMPQ0pi?=
 =?us-ascii?Q?Ox9N0bdyZhydgp/Ep7TrzPRgY9fxEx9dnFQf4YtdERUI5DCD2/Eo9jwoNM9M?=
 =?us-ascii?Q?b3+OrrQdA3Cjhu1FPw/ZCZpZK2FMq0da8T+eHzrCOgYeCRecLQlD/x4Ifbvz?=
 =?us-ascii?Q?uddqG0CjMSXoQOEbD355EpETOc6bmyecocfOjnwqpsPXq3weOw3bsdUJZ0Hj?=
 =?us-ascii?Q?CpRtIoLRfs66/5U/6h6dFqaPM5KqUibGu85kyMqkk+AcqFl65yiuXs9nR1z9?=
 =?us-ascii?Q?4MzMvsjVGv7k3xVsU/TiX2MIWR1aCfn5e+MaK4s+yaJR2AuKSzaltsKT9IN0?=
 =?us-ascii?Q?UW/yb1IgAj3lWfTtB1sYIgN7Av8rNrJ1p3xzrhFMXG4YaEFenrMMT/wQ8Dv3?=
 =?us-ascii?Q?OAZBsM1SePEbF8GwgZRcAbv6xSyjR53gvLeHP72g/Nw26B7dJBSnap5woyZB?=
 =?us-ascii?Q?eCtCpY6A8RmsJOX4Op+YM/BYfC8wTCluXL/y6J4jlN5oIpHm4Jqwc9ZcwlEq?=
 =?us-ascii?Q?leYr0YHX01YJdDnGgYFcN/l0v02g6qGk8Wm/Q1Jm0J5pSaVYlhGNAL0ubds7?=
 =?us-ascii?Q?Nu1sVi1/nWtUwdaqRUOByiyhHfirPXHZtZgLI2Em33/SNHj/Oy7uPe0xLcRV?=
 =?us-ascii?Q?MqqUVJQKfaVwcV4Vegw68fj9rgB1jedWs8VtSzkLEJ3eCOvkE9iVhkzJs8dM?=
 =?us-ascii?Q?/VRA1YwIyFiI93psqL15OAH5BxrABLVt/7XfW3iExuKNvtZgxtqSh0kxNsms?=
 =?us-ascii?Q?fSHqs8m3JUNLYOVs5heQ4mVHvO8zfn29+Ow/srFwiLKZ0L8zA2ksHFm9c8J5?=
 =?us-ascii?Q?hyKrBixURTq8un4/qZflOgK0yix/I830NIKdRO7l7Q/CgN1pSdmUz0PFVpmI?=
 =?us-ascii?Q?OwlUcNppyjPPL0zUqGI+zmbqUHew/yPh9sFHCtgqk/DvlcYbRtA2gfJQCQsN?=
 =?us-ascii?Q?+68dI/QiHMd3qCEa5S6UkN6qnnHvFM/pL47qGsW0TuBmsqM0ZmMiPvskCzyI?=
 =?us-ascii?Q?2KV6zw9kWhlLpcI1qlheTxTqzD+YuIrEUDnQyJMqIVYl8n1/vqeUN3YL/0TI?=
 =?us-ascii?Q?oFgj7eSj6+vtPX1Etl3TAyiJrEVR4ouSrCqJysLCCm2zkR+vsU1LIrDV8oru?=
 =?us-ascii?Q?hOOFOKoE9RbEOihPKckXqsPGeg6D3FNZCFUCNaCS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c903964-2348-4d59-8ddc-08dd75fd80ad
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:56:20.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApLn73VxNz4laZ0PJBg9xJScSVzp8xaOsGgCmplMCby64KpYJ0flrP0QbvmpOtTS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7552

On Fri, Mar 14, 2025 at 04:57:15PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Passing a non-constant format string to dev_set_name causes a warning:
> 
> drivers/infiniband/core/ucaps.c:173:33: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>   173 |         ret = dev_set_name(&ucap->dev, ucap_names[type]);
>       |                                        ^~~~~~~~~~~~~~~~
> drivers/infiniband/core/ucaps.c:173:33: note: treat the string as an argument to avoid this
>   173 |         ret = dev_set_name(&ucap->dev, ucap_names[type]);
>       |                                        ^
>       |                                        "%s",
> 
> Turn the name into thet %s argument as suggested by gcc.
> 
> Fixes: 61e51682816d ("RDMA/uverbs: Introduce UCAP (User CAPabilities) API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/ucaps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason

