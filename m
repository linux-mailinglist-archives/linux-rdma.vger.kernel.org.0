Return-Path: <linux-rdma+bounces-8886-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA48A6B198
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 00:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D564A28DB
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 23:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CE122A80A;
	Thu, 20 Mar 2025 23:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HWBeJ8Ms"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2288C22A4E5;
	Thu, 20 Mar 2025 23:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513138; cv=fail; b=QQxYhHBJMAGXf3xncpNBdanbYAxlZJC3q2whtsfAtTondkeO2IJr8NELV1x3F6XNW2+ECpDJbrbno6mfAa1cSLimFDAmVruKqi6poemuFJ4BFZhPiQJmuvbIjqTiozyC2PvhbwJYJMp28LRZmhceRfTArmHoJ8jMmsMYyGzWOhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513138; c=relaxed/simple;
	bh=QMNVCopcbKqA9e4jt1zKNPXmE/r6O5SsL1pW6M+uZGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sXPpStGv1IgmHouWqMNxn1YDmdVN5Ndayqjs8eNEsSH6BbkWn/I/lXtYNsRfYSVRUxGBYgrD5KcdiJbptmTeXfBG9DLOw4CYHGrqr7+lvuNw7Z7VUe+Bj8ANieJWsC/9FnFIHzQylyw68zV6YFfu+m82VVJ4wSANoCp+uwIbyCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HWBeJ8Ms; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnrq4f7GfSBk/1xcIGcGL8Y3HO5i1wZ5Nx8r28KghNfkWUiziByL+LmSRBNoPlRkTklPftRvbXSiMH8ti+/2eqPjoujb+JEDtRLnkLlHwJYHhywuotr7lWGo3yJVRU/7wFFtnnm4KiAbd97QkhKMzXgkTbgGYCp+WhVDGCCBg7KGJEsQFdun1ANjJRbf4NwHvC0UF6VvWikiGn+8sy34fPUz5UaFXkHq/qEDy3YkVUUGNOV5ATYXFJe/cq7vM+DfI95PoMF9+dzr9jJyDxzBuwLI/D9WyjZIJfDSNdApxNFTz65iNyajrwB3/tROUrzGBIuG3a81cFXDL0XEB1h0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5n1s/Wh9ca/1sXS6/G6S7qyzUe2qWdcWQKtag3Qdtgs=;
 b=O4Tj1HVju/5btBwuwUgOdn48LO4RVRjOZILcn8ep5kR8hrrXTy58L38rGeLCn8y2cWJU0JrUcCUdbd5Ql2mxurupDiKB8lP/HbAvY9+9Ci2m0RGiwMWRlv3MCLvREZu60lMdgcg+BkGy8ecD7OgC37goh/HRfQ9FNDMFLkzbXZWbHWX23K9SgOzEl5ZnLzg5OKPjrFl7qLJUZlByepqXT69t3jZDu7YiJZ+wLg9RIZmxaCJKCAv4VkEDzFzq/xarTvmVjt6/oefVXCu9DATxxXey0gMRG3+rIdN2m+ARoG1vMmYJ3C730bLo6hKSSYNGh2JC27rcSneNhVyAG2ZR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5n1s/Wh9ca/1sXS6/G6S7qyzUe2qWdcWQKtag3Qdtgs=;
 b=HWBeJ8MsCnkyYz/sQXdCQmYbI4qMyE1wW+CVF0YX5GVHmUjNTQBklcXt8A9r7FNbWmxh2KnMtTDo8sZo8opJRYSXqfjTKK0g8absi/rlBXxe3ZjlVQ3UC92QlWuFkURX6zsAs8/UWtPxiI5mSJYBL33tmP7/9gHPOwXzdjmpdNWOAXpx42khxruoJdw3RJR0OpAmvcYCC3Uqb0v7d3LqLBSbnbstU6nSk1bgJgrqJHuPMznfWX6P7v60B9rWiow0qk4ipuuxvcUxAkp2Dj7WO30MwZW5+HSje66EN7ZDhss/KR6fMWOtF4+PcsEFoA7fO3NeNrEfovcY1jwKBDZb8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB6402.namprd12.prod.outlook.com (2603:10b6:208:3b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:25:34 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 23:25:34 +0000
Date: Thu, 20 Mar 2025 20:25:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
	dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
	dave.jiang@intel.com, dsahern@kernel.org,
	gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
	lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	saeedm@nvidia.com, brett.creeley@amd.com
Subject: Re: [PATCH v5 0/6] pds_fwctl: fwctl for AMD/Pensando core devices
Message-ID: <20250320232532.GN206770@nvidia.com>
References: <20250320194412.67983-1-shannon.nelson@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320194412.67983-1-shannon.nelson@amd.com>
X-ClientProxiedBy: BN0PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:408:eb::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a0e1ba-1ee1-4288-4427-08dd68068344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qIuzes400/5qWcYr/TU1iBdb4zl2lomTQz2l5nbJA0DlESo+556fQEaR4m4r?=
 =?us-ascii?Q?jNJ4qXYdtNyaG8p60kDpLWKspAJ6kLdMT+1S3ef+wwkvgq9IYMyF35aAdYLR?=
 =?us-ascii?Q?6bFKJSGvLAliwX7Mnx7w6i/IoWzXbaWYZ96q4mjBghUWztXgrgpSjHmrmKDc?=
 =?us-ascii?Q?cZmOseNgTttHO1qQf8LSaW4NqzcpUboLQtkIZRr+B8jtoG4mLVU8S8c0yr9l?=
 =?us-ascii?Q?oD3AxPR+7aBxyTZmF8DMev740gy8voNC423HFYPAhLw6jlMeBJgvPIfHC2CC?=
 =?us-ascii?Q?3PK33kv/lUljhfCnt4vQjTtlqf4JI+c+EvBk1g8gbixSxkVTO51H5wW+oxgg?=
 =?us-ascii?Q?9GSuAnBy1yYmlQFGXkxYKpps4TyX+9u+VhK6JwRdjtjpyZetxmsWLsFkzhX4?=
 =?us-ascii?Q?NvWjq496GP7Mdcr2OJ0BaTIEvz7E1owaEdvW9zj3b334gRfIpc/7Vr1cU79u?=
 =?us-ascii?Q?ttuTTE5WzQu07L0hEtKzM9/q6p9xXv5YKnNuBJ6uAljiRehaj4gVlXi1iP93?=
 =?us-ascii?Q?7ql5KqFohwQmB22J7rQuzXz2pQrlkiIa9+WvgoNd398LgTh4F/FMD8a2I7MK?=
 =?us-ascii?Q?4VOwjNFly99C1JJZ56T0a6PZ6nsmdeBZGGF4HNUMW3QhP/TUoymI46DCxSOf?=
 =?us-ascii?Q?7SrngQVTvLtkGDMmpTr36e1lcTzm42f9F69veHiXhFjL0QsoFOAQaUuPcInK?=
 =?us-ascii?Q?PwWlt9RsbV57WkageQ6K752Uh6W/Psfs2q/kGtKpB74fJg0UgrFqZb7J8vmg?=
 =?us-ascii?Q?jyG3+JBYf+OsWqDPjhHpYPuG31e2kTU6y4wKVhq7Ef9zWeVnw0k9vwtI9S1p?=
 =?us-ascii?Q?W4f8yxTKCAOsal/NNq3qRMb8X5xue6SqnAgK8NBHYvwnd+AyzageCQ4vuaI9?=
 =?us-ascii?Q?Ve8HZeOYR5ckSpE+sDjFx/q9ZrRFeDh+R/6x4EdqkEGj++nI5BRBAjlY3BeY?=
 =?us-ascii?Q?uGm4VcRwcN4v/edWTqx4sP8xks4fD8SMGvRbKbsdwT8Mo+3XYNOMU1Pm5m+Y?=
 =?us-ascii?Q?6FlG6sYR/VGuO+csdkXxtFwwHl89HdwAfuQJTYk6m3LG4uB9AeCPY+ei32oc?=
 =?us-ascii?Q?VjuuGSmtsOr+OjKBqUqxJ/kqqittjJG+W7hO/6b3xLiz1GD9XKoouLK+5Adx?=
 =?us-ascii?Q?5lfxkyKZcd1lEMDTOLsOGnIhxRA+larn5dcqdz9k97M+T33iGs7DCLR3NX8m?=
 =?us-ascii?Q?aEhWMo7jEWFzz3rwESxx6tqFW8MDNGT9rRKFs9tkAlmdK8Y7O8UcWFlAUEQ8?=
 =?us-ascii?Q?KTijH2FfMa1aeG44wgfp7MoiOPhLIrLO1A8xZE57nJC8czFWGMD4KukqW18+?=
 =?us-ascii?Q?GbjdGVjMNR0VSrMCoJEsRpjeNT3maJo1uZhbKO7gMrrhey4tZcRr/FvPL8Pt?=
 =?us-ascii?Q?xOXMhz/om/QjkY67dw2abDgXL1oZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OEjMn23RqJUVxFIeX6OUi57IGmbnsmRuNSJJ5nQ6HtOQpvVjYyEGFrfaJYPb?=
 =?us-ascii?Q?e7JNvwfGsTI3+Jos4+eT2UnnFhgIos2Qh36NeO2vD7hA5m0LFBFmGFmhxV5p?=
 =?us-ascii?Q?aqwEh7q0OOk5zNjP07xjW9Bfhb+0nPMB/rxUgsudV4tIFf7oSYjZaSE1W8sI?=
 =?us-ascii?Q?SlkxrAbOLomQZB54a0FxjPNB4WDq9JahuJabbJElmTz1irFgk9V/s9fyPBmT?=
 =?us-ascii?Q?G7ijcpqpdxbqDwNrbjrIv+NLD9KpKyJsvLhvzvuvC3X39WldDCfDx9TlryL0?=
 =?us-ascii?Q?Rl1EwQoGJKPOJ45Hc+dsKNcM0vUFTYu10AyVSeo4GUeMI1kZ/m3f5/aj+TK2?=
 =?us-ascii?Q?boLj2NajYMWG4GYcl1kSrdS0tcyfcLeGIAUlg0yaEPJ7rsGweHleiytHA4YO?=
 =?us-ascii?Q?Zymzopj7SI+XFaQHbBrdX8YlXaget312Vol9VQyf0yuVgCvbKLYJ/JNVR89H?=
 =?us-ascii?Q?EvdRsew9D1FgQqlRdE1M9GP8XkGzWqElrijSFzwpwtxo2G/6BOyhUWgnLixQ?=
 =?us-ascii?Q?OcVt5GwUNRowYyDXXVghbrlEWTRf5LpSC1wR58G79WourwopaQNR6ureTvO6?=
 =?us-ascii?Q?E0sNMOcFq051jj7xruYONFxFXiHTfqLHymEBcaaIekyqGQu2Ql2L0b8ARQJ8?=
 =?us-ascii?Q?GSr/dxdqOGWZyeC9pWqYUTGfvYY+Hwisy4cTWaG+S8zTxhIXhkas2a9dFmxQ?=
 =?us-ascii?Q?XN2gfpyYEkiHBRRvTVDgVQi+4f9lhQEW72JFbWYNPPOY9McAiS2o+74EKeYp?=
 =?us-ascii?Q?4BjQsJRLAuHAcTRPizKRaXNn0PbKTk0MK/2UG/H5zLHKJau+K8yqLAq+H2B7?=
 =?us-ascii?Q?2G13GMAxKEGV+whl7paGk5z/C6kDFdmjQwXgmZ//ySlHbpUQqFYSiB+lCH4g?=
 =?us-ascii?Q?fACig9dkx979pHDavhaRdOA8naVvKP/tTR19oG6viYJd1vahbzMgP1PIly9G?=
 =?us-ascii?Q?hzQV6bJW3C5dfGC0bIbc7jsP6VQEOSudPWBdJJAl8bz5DQVc3ORai3+00+UD?=
 =?us-ascii?Q?PlDGOtpeDyRxYjd1xbgtsrpZD6zcYfPjOIR+Q94grJCkH9mD3WlX8P6K/u7X?=
 =?us-ascii?Q?GNEfsmUR+lQ97yosutuOg/4OOVLbdyK5pzN48wgAi/9eX3oJHJPiGnV5akBC?=
 =?us-ascii?Q?0rgqRSqzO/Ag/UeQCTrYy8hpY1Ciks6MdWMvU3ug4/x5i+Ibcw7Sp5m647nC?=
 =?us-ascii?Q?BrJDcufhNwhioazu0rQASc8WgB0BebrE1+pn+D0kzEdVAWlxBlKQgAozC204?=
 =?us-ascii?Q?h42JjnSCQ2JV3EuDobXqt7ff2iXxpqwVVkM9Hw3Xi5JxxM3DnBJiXBk+inE3?=
 =?us-ascii?Q?2iCDKbmTvTP0hfm3hLDeOnI0JVDABJ0zces4Szc0m6jLf23ZjZ4y5FiLSsml?=
 =?us-ascii?Q?5k0ERCQqrybp/MmDwYxU6mknzxMry6oGbt1G9LvTjl8DCSYi+y1LQYSlTtIN?=
 =?us-ascii?Q?bLcao8CjEuE87KHn7nrFFPLpwAxbi0OAaRfcxuv9t4Ju5B5RIoZCZsKhITha?=
 =?us-ascii?Q?6UX6+Ay0aLqpwjxgN9G0aG6OB8jQk5cCpynboqJ70M5MeRyxFbVdTH/PH627?=
 =?us-ascii?Q?hfkmX0f1ikn0Xq3yFP7u6Cc8ENsrY3EMwMaFWh4R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a0e1ba-1ee1-4288-4427-08dd68068344
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:25:33.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7M+pgGCub30M2XJ0Qex13HnDXdEm+9o2cXkzoQPpvwowaTh9a6eAvOfPhT53YTi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6402

On Thu, Mar 20, 2025 at 12:44:06PM -0700, Shannon Nelson wrote:
> Brett Creeley (1):
>   pds_fwctl: add rpc and query support
> 
> Shannon Nelson (5):
>   pds_core: make pdsc_auxbus_dev_del() void
>   pds_core: specify auxiliary_device to be created
>   pds_core: add new fwctl auxiliary_device
>   pds_fwctl: initial driver framework
>   pds_fwctl: add Documentation entries

Applied - though it has only been in linux-next for a few days, if
there are further problems or remarks we may need a v6

Thanks,
Jason

