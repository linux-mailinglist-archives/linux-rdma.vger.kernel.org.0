Return-Path: <linux-rdma+bounces-12907-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C3BB34876
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 19:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F4D3BE363
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CED73019B0;
	Mon, 25 Aug 2025 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sFF4fhy1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CF32EC54B;
	Mon, 25 Aug 2025 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142426; cv=fail; b=N4I3Q40lrlJXjHn32keKUSCvCyw4L4J6B7GBMK97pxNF7PZnLVV1z1IzzqsPKQDtqm1iFvVvCnyboYVBCCs5vfHlbNfDlN7JigjystdVPzcgNpp6ZOcKAuAIJ7EIh7AfDiM0HYiG/rb9JQ7v8QyBuTSie8XuSP/EgBY2+us2/0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142426; c=relaxed/simple;
	bh=9R5PYn4pigF8CzeLP3Y7FWCk9Z2pWtRKivbeTlHgT8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZpboAlz9XKdnx23ZPkB9nAai/ko0HyXxj7JVc8vMjHL37j8Tsurx1CoApVQ25EKyz7P4381uU/9JsoSnEb1UB600mwnTelVk9/N7dZ3sfC+X/hzrwgk1Bx27EsXRbVm0+aDPenZ+OfsoyI1vutODnljBFFl1MqYFNJntfE9decI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sFF4fhy1; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J82F1glBQe3ZHP5HHjAncfG4Xm8AuAw33ixKasvpy65xeSmVY8tJwiBVBa5D8kzex8omWcDjS3KIrFPARUo+2dNi0FaYjKRn5Hv8YzeW07GDQciiMwxB82T6048pv6Ng0T8sVC+3/956BKdVbNjOf9Ok9bYZTTgxdu3XyP8ANA7GNovq59jURmlnNblsGwcyfuiv74hz4emaNvx8Ie1fu/f9Rvx6ebiby5G0thLYtPntBr5b0wdvBW2KkCSJKAnR2PVCrAmbbdXfH8ng62erOQ7Dloj2SeWOs9qGaKoJQuu6XV2Ncx0bafRs0hmEeTDdsgN0opqWsfo4wJ0DIjo8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1uPM9zjSQdqXBJKOkYQsK8T1Ef33n46FUplgI5ouTM=;
 b=w87pudmzCmukTGbJZpP1qbvJiQRz96ANEU4QP8I4TDfpSqGtxcfxNR/5Ua5fFiUAzJWrDcgpoCl3T7hhH3LUga0SytWD2VNh4jzDbhhT1Pmesjp7GUn6eYOPEKjboDxBrwh/EzwFYLtrqEoNb4VnhXWNYbnyfGQBCtMdfvj1FLRrywH3Ej70rTOpF3wbk+MjdFkjk2zNIP6Vdqz8hG+QVZqWcV3bV8tnvPmsqiWQDsH4TAuNbnMWdnhAWF2BGtsZyA+xV5el/DNp9O8hcyRtwJAfEMKgTGlB1rbUi/j1wANtl+5L6O0AYfNnGwzFnH6I6YMkgswQ/fh1s21CRjQXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1uPM9zjSQdqXBJKOkYQsK8T1Ef33n46FUplgI5ouTM=;
 b=sFF4fhy1NdfyEfJNORXhyYpbcMPRsuimucVV0IbiStO4zvGymXlmqh9AiWCwOL5uDe9XP2Jlt/FPhJA3nIDElgW7Ts2ymHP9q86JizKGNL4s9fCp9ugUQyYQzpE9GCPBiP7n5DGrY6m72pfQ4KUp2zv6R+QGNnTcPddfDxOSOhT2Y/QhxHHukmaucXCCNCIuM+KFdHJZGsTCp1MnTRWSk3gspV+EYPlpH/OZrQgPd8ZV1eHIQM9UZ2nc+PBADgHjfUca3UxEtQ1ZYGnKIr1gVq2sAR0cuZbtF+3ljBDQzJNbcT+kdgLt85ZwNVbtBxiouFe8hits5vK9BaCyWOrYPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.29; Mon, 25 Aug
 2025 17:20:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 17:20:21 +0000
Date: Mon, 25 Aug 2025 14:20:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] RDMA/cm: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <20250825172020.GA2077724@nvidia.com>
References: <aJxnVjItIEW4iYAv@kspp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJxnVjItIEW4iYAv@kspp>
X-ClientProxiedBy: YT3PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: e1adc0b2-67a9-4e56-2753-08dde3fbabb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JDLcKAo1/Zl8TG1CI6g+aFBVIxqtZ1p0e+KeDEUSo8X2Sk/YHrE1kKrD9VDE?=
 =?us-ascii?Q?PTIAm1Zt+Iy/FZ4PeyHPZJwAaufcj0Km2xCYUYVnkCqyyA7WR2+RVueCcXTq?=
 =?us-ascii?Q?TXCWCAAl/yVbQEAkGXSiC1yh1GtOYz/3Xp6lJCp4i2svr74pAZM6wBK/XfM8?=
 =?us-ascii?Q?fLUhliSLFW/hn+xy1NQ/5fGmu54YGKMNidNRc2BMi5YX++5JDYi/5ZZbKoSC?=
 =?us-ascii?Q?j/ZW50ifgN9ed4iOM3ihuW+u8bd6Nd8PphIdJ1Tx4B0N/4XvmJdKc1qQEBM1?=
 =?us-ascii?Q?lCXUJjv71iE5Rf861/6BXmPakolBKmRsqt42XUDGoFy2lVVFbZWQCfMjJ0go?=
 =?us-ascii?Q?EwvqP6hP7iswfRhrYJGmioaBNNkS1Mlz98wlUzUK6lJmmsOdErcHxEOpmkcf?=
 =?us-ascii?Q?uWYw/VdlEa0gacngBJIXWhn0qyz84s3h3RgZ+onRNSxUjA4QWpxfnwuLbf9Q?=
 =?us-ascii?Q?iK+oa9bm4rKJM9Ar3UtffneYofcpO/+TfDKeEObvwgMs4WF5NzwMRISqM1gI?=
 =?us-ascii?Q?pSJHhuME5tLJ43HaVtKPc06JUTOc15jCPY3zbMzy5VpciW/FQyCpYpG+RUt4?=
 =?us-ascii?Q?iGtHe2EDwCUR89LNvvLkH9+vsxaDwXPQxf/4T9gTXItKqmV8kfCd7KEe42D7?=
 =?us-ascii?Q?4krD9G7uJpAwti6uTPoETrIkI5e1E0RQKjWZc5neq/Uq5PxRu3crTdoBwprm?=
 =?us-ascii?Q?j4eBBhtr33WJMspK1IQTUiJvdz/jNhMx+Ot+rgwKsQAZRdco1ud0B/Q3ShiG?=
 =?us-ascii?Q?r3YTqKx52NMT2D/fGC7KfE8j3wUteAHZIijtJn9Tgwl4j/aORMCnvRh/Lxhz?=
 =?us-ascii?Q?fWX+jha3BqUNJ0BWz+6cF49oEHglq3of5d3UrjttsIT/EgU8NJUU0T9m6OI/?=
 =?us-ascii?Q?nS69Z8tqAImQ1k7hWX888HYc7IxIDHUUVqYYLZwmSE6lB/Qd3nK2KFaD81z3?=
 =?us-ascii?Q?fe3GdzM34PudaG2fBXHUYcf8oTb0qhDfv8UKgJ/lFQFXoLyTK1PPgGG8yy9V?=
 =?us-ascii?Q?RnB4o3JELMnMMUAIGWWMZHaT8o8GCHzx+fD9a1gRQUiOJ5ctEEQWcuthbidv?=
 =?us-ascii?Q?a+mAqLk57alfIaPf0e9aeSAIv2a353NniLk6gTgeNG8KaRbWCcxOctx6UpRr?=
 =?us-ascii?Q?QKvibG99E++sTrjKs+8mjpLeh+9+eYojYHqDNpjXf4CJrg0NnltJNL0vOdKg?=
 =?us-ascii?Q?6aaVDwMUkDQjm/rLXNVWyfa3TieZRim5uhf0EG5If1TdNFuzPwrCgzONZA2v?=
 =?us-ascii?Q?zhNObojw8e38ZQ0oNcAYIXtij9gUUGxpEv5XglCqAA5a+toRvgZQLdDhiCFx?=
 =?us-ascii?Q?w0qzAJe8yggVwkxGq2vAjakZYtp+bgrkdlIndDf5Ba2mNAadgdlWouROY40m?=
 =?us-ascii?Q?4Z8mG7EuxMBEGnW6qg9xwMHgxULs3zII1uqWkhUaSHaf+e1VEHxLxMQMug7T?=
 =?us-ascii?Q?28PULgKy24U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qs08PgRwSDLdZATWcCq5UdWJjX0bLLm1Kbk11Pgga9xAPFYsSZzBHbjml20f?=
 =?us-ascii?Q?0COW5nkLY0vCq9LHAdNFUF52Xps8sBwv1FggBtbDHRtRmvyhX/P8/ykwNXmq?=
 =?us-ascii?Q?Mg88U16piyETjVTE3aylEBy5ORkJnhwp0gSL33CvGr7R0xhig7Eu3KmOf0Ua?=
 =?us-ascii?Q?SLrY1HQq5RFtDpElWBJschkSp/k39SeUu0pPf2iY00SD62WSPH+16hOE2VaI?=
 =?us-ascii?Q?rdV6+2Oy3NZh8wCPr+2mXuuaTHU4qefqcCfawxf/2usXdBnkm3yYcVyQTOT6?=
 =?us-ascii?Q?NlOxZ7FSMxKiR4zCUYm4zsXf8pd6zyYnYSC4ywnVJmfhFy/ZQxfyAds36fhs?=
 =?us-ascii?Q?MBoG4vJGRXAME1P7GasRwSV6ykeEid2zmvitMrGkmF7lzAXRbqaKZfQaQaEP?=
 =?us-ascii?Q?IIE42gLRBx/+XIcNsRs3t3PIiqYFXNZVi/X4T9lHK9Wtd/RI6I5zu7xBNMAi?=
 =?us-ascii?Q?s9W0ujHtNMcZCY12MbwW9ccQNb2BNlzwWG9w4Fd9Qwtw03j7ZUbwVZH7S2E6?=
 =?us-ascii?Q?MtXG1/sdsMdMeryuEY8Z9jokHlJ3BPoFhWeZMP0mynAmVu3T0dz/nGXEQDjx?=
 =?us-ascii?Q?F5+vWePWOK1kaENmCZKcHSL2P25lUTfwSqbRo7JZKbwx/OXkM167K1YZoZlB?=
 =?us-ascii?Q?sfKsmdPC+qKLTKBBwA5aYfo8/kbWo+unOoAauPlTrL3G7ZpZZ0kbN+rMS5c5?=
 =?us-ascii?Q?0fQObYJRz+JaLcd7fEcfM/KirWPMTe08Vg1yWXIui0y3MZ7e7jw8BUi6CYgz?=
 =?us-ascii?Q?Yu+I2uFBQg33lyBFXhuHIuvfBKMuPkDDWcPEqHDnp0Tsdc233b2Unur2Ldtc?=
 =?us-ascii?Q?UVLEOR0qDvVq97hClilmRxTEu3FCJblt+g2y0P4iYTwV0Tq797sEVTq9IuA6?=
 =?us-ascii?Q?WODEs0OU0M6mw4zyPj2tymBbXnSyn5ISLVaTpxcZH0i5lG67aHgQeDhjWxWC?=
 =?us-ascii?Q?2bj5RfXpLMh5hKX0Cb2AN0Dw5oOnCUnjw+mW4R9b662DTY31jMR9brki55/i?=
 =?us-ascii?Q?gWgBFmA9QBAxNWNSRhFOt/08a16U3MYmJTNkSkxB7fHRf+jP+xoFYrGhvd0d?=
 =?us-ascii?Q?cwB4gy3RpS8VSvz2xuxcZsDH6wX3+VtmcdUE3BW/x07QVSOhZ+xCkSRQGPrm?=
 =?us-ascii?Q?2iDze3IjJWvOgwoV1NeyF760mZdT1dMSOZ6lLWkVkqyzcJCg/oJh1PPmnObl?=
 =?us-ascii?Q?ypRydfJ3W7VOLsYLEpfoIIgj7TIxFW4hTiRD4d8Ha2YK4dhKb4f5GuB5A6uw?=
 =?us-ascii?Q?NVA5fu8E+jNau0iQPvXpZnG+pX5LhCuzWwQyLtVvBquUG7vpG/WyFAbcTXcJ?=
 =?us-ascii?Q?KWAKLDHzASmzzmiZGoZG/euO9FpxAzxwMw4DykqBkVwiyYnzQ8NfQeHgpVDr?=
 =?us-ascii?Q?QyV5kBLFDWHlCGqx1PPdFf93Q7VcDCmU/awBud23Ew9XAmrh/xPzJaK8O188?=
 =?us-ascii?Q?aBeb9OWnJpvad2QxiF9UvF1h3/HWCA6L2WDd/fzadHQSOiBBS6tBaBbNcoAs?=
 =?us-ascii?Q?wx0t4Cbke9E59J68W1JobFO+fqAy6bsnhigLKk7eIIwxGDoyXRqbQSS9lzaZ?=
 =?us-ascii?Q?E9mdU2xLRhLe+7xpQko=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1adc0b2-67a9-4e56-2753-08dde3fbabb6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:20:21.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAg8uSuA4OvserXfkIuJRDosKTdacwmnczCaq+hgisPBauqizvkne2FWgZVJzlj/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576

On Wed, Aug 13, 2025 at 07:22:14PM +0900, Gustavo A. R. Silva wrote:

> @@ -1866,7 +1872,7 @@ static void cm_process_work(struct cm_id_private *cm_id_priv,
>  	int ret;

I think if you are going to do this restructing then these lower level
functions that never touch the path member should also have their
signatures updated to take in the cm_work_hdr not the cm_work struct
with the path, and we should never cast from a cm_work_hdr to a
cm_work.

Basically we should have more type clarity when the path touches are
to be sure the cm_timewait_info version never gets into there.

And to do that properly is going to need a preparing patch to untangle
cm_work_handler() a little bit, it shouldn't be the work function for
the cm_timewait_handler() which has a different ype.

Also did you look closely at which members needed to be in the hdr?
I think with the above it will turn out that some members can be moved
to cm_work..

Thanks,
Jason

