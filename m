Return-Path: <linux-rdma+bounces-5382-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7353099A957
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 19:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38EA28406B
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6DB1B86F7;
	Fri, 11 Oct 2024 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OR4dNDGr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75CC1A070E
	for <linux-rdma@vger.kernel.org>; Fri, 11 Oct 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666025; cv=fail; b=baSwk6k8sjpmaSVW3CpoFuQTUGe22Wr4L6hS4vIaaiFVKvERukBqjh1t0JPkQ+v916BzUEc+Os7vhovZyph/ahtw6J6wdgWMWAZHm67iv6Sxnnc2WZfY5jNBlMbZIixVgKK1HHaEmlfpDmENnwalGS+CmvcLkSayQuFr9CESljI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666025; c=relaxed/simple;
	bh=02s+QFoHH7utQ2unrzYgxiKwIjuXqpuvcRNp/cu6brg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sZIf3WdK6OdbL/6OAscNMHMD3/L1tk/tpx8xHQXqp3M08zLbxgEQEf0Djbx3NjKySMvYIx1HPDxue1ebWWg7bziEiws2OSr1TfPOAevAeg2eUyy3im2k/4nRaTzbkDMpzE4HtojDpgoYbxdA5ZkdBM7TS8kmt/sX4O1883U8Oyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OR4dNDGr; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EM5SZufVUeUXH5XzxZRrPjAKtBqLrx7UA0K8T1x7RcQpBlz591kXWhQcofKgfXr56mrOFwR4JtR3f8JokJoUWbcxWPctFS5UZH/2YfPtqAU52c7N0atoBws8rt40HGEok21z7Na/gi969GobjDW77dffwur2rclBYBRQA5gLRxjdT2/SytVI9RogG9wz4lbkiuR0ZlxkqKLJTg4Ivq6vpdTlpDPVzshiz8Yf4IEWoVANrQngLcogVr15Lu/nUiNc0BeNg1Nb/PPSe9A+fbrf9otgEmSGJuKs1ODFjKRiDHhVZ9qYLtlpP3Xk/QT5QRCkT0pu2Z4BU1/uNgn7CcDg3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YxWpIkdm+R0qho9eiig3fqalA86kzw0dcRo/MoNRIQ=;
 b=Cfckpl7Nu+T0TatqJsIiXZgXZ3GcFfrEpBiMkSjPKKr1+rTBLfPnR/Z0rsKVWCkTSMPhYNb0GxiNNIBcTqMXqMxoVwgUYQaRVTrJG34gEhuQ7oBTpKOdL578rkp5npHJ2p183zPNh+QKlxycmZ7X0L5Tu6GEyEbupcoQPgGdriFqrdviS0XqAHv0BcCdb1ttmUN88eLl6x+ytIKFIxrB4K9LKTDK/UFlrnbuW3lsVzOidz8e44+j/OtjR0TwTYWUCtV1pPU/0BUSb4xbX3XG0lnCr5ClWpt8m0QSri8wOrdvOo9r8TQdBlMJuy2LqeW6vteQrZexTf2VrF9OmBr/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YxWpIkdm+R0qho9eiig3fqalA86kzw0dcRo/MoNRIQ=;
 b=OR4dNDGreiI+N0rV8Z4lPqFqu61W/KEFJsah0wWyFA6GUChN3jIe/qmthkUX9vF5EoiyljnyVDUG/l81ewaB3tNcBLXJNXN2fc3qg9ky6D20wJKuMhEzDjFhXMgvf7TsUiRNGCC8fGdp23oZLaq3Uk5KlEOMDZSq5I17BXyE9oOAYdnVE2QO8Ln6fzt+oXIgLYoKrqap3rVMVSgIS3lZ8HCjkamUY+ENDYSBaCvQKKc+Iy05JaTMpH+fFdQNfL4fZS9qoRaPKd7W4aUUf466bm0zTOTO9r+txr95LBhtE+OnrgFEEvtZ5aH7bZQoPCXqevostNnhSf5oh5fXjFw8yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Fri, 11 Oct
 2024 17:00:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 17:00:21 +0000
Date: Fri, 11 Oct 2024 14:00:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: leonro@nvidia.com, linux-rdma@vger.kernel.org,
	Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH for-rc] RDMA/cxgb4: fix RDMA_CM_EVENT_UNREACHABLE error
 for iWARP
Message-ID: <20241011170020.GB1871991@nvidia.com>
References: <20241007132311.70593-1-anumula@chelsio.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007132311.70593-1-anumula@chelsio.com>
X-ClientProxiedBy: MN2PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:208:e8::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: d3474139-921d-4861-a88f-08dcea1630d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O/398iaghCvP7qbUW7/E86stN6H09BHx4OfLpa3LNRN1E8yzE5X9CEIZj8hY?=
 =?us-ascii?Q?Sws2Bw7Vaxhtb0yX7nBkYdM3Z1x1GBTfnOuP2q2V5HNBqj0FF6ivz8sc1qYw?=
 =?us-ascii?Q?imV2GFB6iw/T3xsUt0cB/5F30ewLBoM2fRgaFuPEelxrHh82KdNg63KbuylD?=
 =?us-ascii?Q?9tNtSQj5Iga845Ssg7badDEfqMJ4mA4Csmb/HN13tEeE0QWIzFv1gcZpjnAY?=
 =?us-ascii?Q?tfjhWnd02jWbgakbEHGzu0uZMoueLDj/qhs/j9E0UUeL1d5nPVXoZgN6D/H9?=
 =?us-ascii?Q?PjwRJEtdfOnq8odsupJAx40QaeIqGMTS/ecymmu/GaxiHGsFMUIynsYX4eKd?=
 =?us-ascii?Q?Ei0zswICG+1ekjPFGutLg7P0PjQANJ7hG1iWdhAJkEm1YTSztqJbap5HJQ4J?=
 =?us-ascii?Q?YzuSJDJIO/R/0QNnRGzhB3rbMhdSWY+diSNqnyoiu5qBVEE+BUbYrYiHn4Gp?=
 =?us-ascii?Q?vIk2SFiTsP1hFYVsjWRHHxwkJp86G6kPJI1HGxXJVbnp2HVuwFaWzV1CN/Va?=
 =?us-ascii?Q?bxROCuTB+Dzy7f+TXmlJ5czJfCFAxsRqckWHhobJhcs5MLLi39v5gwnYg7xn?=
 =?us-ascii?Q?ycxg+mUZnLyxxYEdEPdUFE/k7kVFW1JoWjwtSdjurTOflRQuEqHnqSLFfpyb?=
 =?us-ascii?Q?/uWAXeIh9VKzviTTeJLnIImzjzQ9c5qH25bUMqi5B4JWX5DpiGC3OFW1Xx+0?=
 =?us-ascii?Q?AtI8aXFpiMshnkbYgrSFaEuJpfzK9yb7h4lwBiqdDUwWTg8Uu0CZx1RBzuhq?=
 =?us-ascii?Q?tPGl0efku2dQMYd61/QImJX8XRGHZLXSjD8slRNOEhhM4q6VaLZW+JuDtnTT?=
 =?us-ascii?Q?gL1wAhjAwciJJMuOT0sEkGoh9AUZMMayC+U4fxWb/cW7a8aJ/l2lfJ8BX5mr?=
 =?us-ascii?Q?HpZwGmM4lFbP4Pkvx2+yrdsGNru7mi8JzRIVZrIkeAXj3qE3S1xSQ+ikWo6r?=
 =?us-ascii?Q?rnRkxtViCjzMlbadi/olOEGHQNMMjlPkt3VebnJQPXsNFA9xWgJ1zc40Piav?=
 =?us-ascii?Q?pEW6uJc8nziTHKRuZfxgvfAxEM76xM/vqnIk8bwMoYtRJSbsTLVKSNl9Z450?=
 =?us-ascii?Q?YGL1mZ3Othhy8Xxcy7SX89fUYlbr7URqpemrbHhidVXAlpsCBG249h06x/tU?=
 =?us-ascii?Q?d7OQQ/sGR2pudGSHnOl2BqwF71tZVnreGZmtuQpfsThcpFTagtK1D+Z51Sdm?=
 =?us-ascii?Q?Yz9WdH8TeM9vkNUCgDYFOrMWoCFiXSHyOmoajdwMzCZ6YrtkbtycqDahe/G9?=
 =?us-ascii?Q?OoXUz//LPt+iYXsnwqA0wrTRwBfmv25I1B1nLGBDbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WLbx/6X52/UXlviqZqTA7CcDJ1PhNUI0TzzBCAMxmoF+5/K1CJCm6DUM5Tx2?=
 =?us-ascii?Q?8mcifcodC1iC6e+JqobhsSa3lgGEmL53J/IgTAkAx78RHnhTKTyi5tNoffDp?=
 =?us-ascii?Q?E8fJ/rMjvE9Z4MTshx5OLD5aYriqsbhJv4quaYEHo5HwrBMSMrYVFXeoctgo?=
 =?us-ascii?Q?yUtd6xlERd8YrYkoTilL6YviYKSXHvYtxhD/sJovfCbk+MSRnihB/V9P6Pnb?=
 =?us-ascii?Q?Zt0PaFrn/nLidK8+w1FulJFE4/3se/mpGkQ/KUJAvhZMrRjTMvHqv5PVJjSF?=
 =?us-ascii?Q?j9d+OnDPfxYurZl3xhXBSawKjqf5f56i30Mx/+1fhMFn0/tsSvehSqlg3NWa?=
 =?us-ascii?Q?1OQacL6H/b0wL+KBgv3BfcWba/ti6aWWYoXqRGKuPRyBwtfmnVK3nSGKB/dF?=
 =?us-ascii?Q?s3x6xb3dtiAFHd5VVhKEhHhmDk2iKFTEj0gFP5CnaPs/NOvJZRuz0AnlmR6/?=
 =?us-ascii?Q?sXB24n/+rCKtf281k5fNcKRs5/09oI1ghfmh4HlgLRof/WfXdwcMvmdrDrLy?=
 =?us-ascii?Q?BEpDvGA0OZ9O1Scmtogk+D2jmwki7uW3XnfhxO0qzzTXWCsf5bj/vbY2C4sZ?=
 =?us-ascii?Q?fK2yZ1L5IxPJ0bpAGcvJz5O2lEwF1CfNNpiM7nbB6dfp5K/7nlHwjScO8plu?=
 =?us-ascii?Q?MxiEiz2N9mi/5v7RyeEMF9vbl+N6y+LVX4aGa1mg9ccRTbgh8uyJ3qRLriuq?=
 =?us-ascii?Q?4PuiBWQfhHc9pO3C4msTt54vZMXfG4KQydjOmmpDWQeFNfMa5Wjezysl4I4M?=
 =?us-ascii?Q?vtskDQZN2s2JrI+bcm+xYeZtSplfDaEGZ40BOfXUzAnJrFbT5Wpy4woCq61M?=
 =?us-ascii?Q?uJZIwBafzj/j8TRvPSk7JHZ+MdHJfwGuT34HJgTkDs0hM4y9mY2tdovcVWZz?=
 =?us-ascii?Q?gyfFX/nBJ++KerprgoNndPVsqAvU/fDWa1KQNofAVL3DO1DctkoiDtTacAtR?=
 =?us-ascii?Q?WxNWghYbarPsh1FqzY4OVU+pqNA1xstvRdWJMcuBhmv32F0sVXHNuduRUWeB?=
 =?us-ascii?Q?fxlRgQnIRdOWozTZ05kBQUSu+g37g5hqb7mK24YG2lRizx69VtmMv9LYVY5S?=
 =?us-ascii?Q?raOsx8wd2DYKf2ow/qKXYFjsE4DJ4UdbqFnbtLYHEqi/ye2OnvgJ5TN4qrtj?=
 =?us-ascii?Q?gzNLobvbZm5p+Ig1luAyw55XWVQUyyVdQNpxpCz5800PLLWFKU7zfQla08b0?=
 =?us-ascii?Q?6yPid/mnjyecQoNpNOlwd5H7zLlQw/+XpWlaCfYkraNcM8enxmysAIWHzOE+?=
 =?us-ascii?Q?njoondTGBQnZEi8Lh87Iol8itY2BfEJvU5p60xTnVXjrpnRa4FoN1o9CDq4U?=
 =?us-ascii?Q?lu8n1k1YRLg/dZuicp4r6fBQ4UcFgwgJKFSUSHJgVcvaF43dKrQ/4VshtMtC?=
 =?us-ascii?Q?o+KJ9Riprmtjz1TRptujCKV4wVFdOpT4N+q8s3JVlEpttAsp/YnBDiczmbM+?=
 =?us-ascii?Q?knpDVlmUqLgygCo7+ao6fnXuKiruExJyCj7vW9tWkyUCOSk4AvgSfkjwiGIH?=
 =?us-ascii?Q?YtC21RMAFO+RDo3t42/+XXllQlQeqMN5/VGZ5pHoIYOxO4dTi4QfzQq08z1Y?=
 =?us-ascii?Q?Wbvjq8YebAp7XyBr6zc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3474139-921d-4861-a88f-08dcea1630d4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 17:00:21.0550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52aWwB+GdnTk8x4l3VFHgq4E/S3uycYso/xCUyRkENRT8gmwJh9lE1AUArKOrSHD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927

On Mon, Oct 07, 2024 at 06:53:11PM +0530, Anumula Murali Mohan Reddy wrote:
> ip_dev_find() always returns real net_device address, whether traffic is
> running on a vlan or real device, if traffic is over vlan, filling
> endpoint struture with real ndev and an attempt to send a connect
> request will results in RDMA_CM_EVENT_UNREACHABLE error.
> This patch fixes the issue by using vlan_dev_real_dev().
> 
> Fixes: 830662f6f032 ("RDMA/cxgb4: Add support for active and passive open connection with IPv6 address")
> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Applied to for-rc, thanks

Jason

