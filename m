Return-Path: <linux-rdma+bounces-13625-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DE8B9A284
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 16:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CD2188A374
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297BF20B7EE;
	Wed, 24 Sep 2025 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ntvlCP+B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EDDCA6F
	for <linux-rdma@vger.kernel.org>; Wed, 24 Sep 2025 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722745; cv=fail; b=Abx8WGtDcIYHDHGnqe79HsV+/0hORUgEKDO6HqsIDYx5dIF/RDYE82mpi6+NUooCu4KIX5wBkZQLkmzrlGbsg+CPduo6jZkhFIh6d6XBosDuJSABG8m6Y3SxmZKS/qWKBBycWqm5qIpE9HJw0E+mrTaryn/yMVPqTOdPEwWUFSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722745; c=relaxed/simple;
	bh=p1H5Wqsc2yAOstOxjuPJ5kXowl3sOZiyFv/5IMbr5hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sod/rmqt1XxIOk/k4pYHyKz0bswFr61q4W7rpDOSTcuCHU9Qui+wVRhrcrAIm4/zVcRQs/bHjqGt9qk31Rd6wx7fqW/w9DOpg07GMHLLs1LQ4CMwhONZLFzcPF6Pvn1p7nCdPSxNNshPYNy5N6w+du2RWQvXVhCDIdfv9h7qzhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ntvlCP+B; arc=fail smtp.client-ip=40.107.200.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVge7jDy8p6ENfylV/E2qraGtzf6zHFiDBBLLsogKybXcoxNPP2yZmj6+yuciytRQ3FmlS9XFlTXwF5+qENI+V1Vi9GsqHRoFj63+EYG01iVIM65Dxk5r6ubfXC/JnmU0/kZLunJx1qWK4BkQv2fqqDlNrCKoZzzEey5cVeU5Lsg6IW5BffdS1b8IOVsuHeyK5CCIqC1pcrPSNodK4dlUt5OPtULfZ1dHuLbhMM2OjQ65bo6gvd7GsmMPCXsFmsgYqcTamMTMGEHiExVbJrTznZ/OV317BlQBvITNCWdoKjGwtvGl3/pQzbfA/2MNkUv7K/6CGoW1I1z8ERFNBtcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFiY+sbXsMBIY9ir757SSceF2WyIibd1BqZgfyUYioc=;
 b=wXB/sRiApeRCBeMNnPhh6skjILqivpbum1Bi8HHWwlBsGSdiQPt63t8cBt9cYRT0Rh5KXtHpFesCxNAUN6Nkppcxd4xx176M20VBNiLJXjSdwa+1L7OqHDzoRKr2Sg87tk9xMm6XFh6S/WJBKhaEvmTz2V8/1o7xxvcE685fYc8zWRjX4L7KeAcW1tBMueO5QykKt5ykFoN6qWlq6Zzvo/uiQ6USBEGEVIv0xYbXfNPkDk8NAELAolL5gKQCnjvRMzcSTk2id9rHSz7lBW7sWPtMf20LvixQuisYtqq1ulmHEBSNiJ1i4gUefd6tVOkAYnG7ne2cdNV4CQVBbTiydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFiY+sbXsMBIY9ir757SSceF2WyIibd1BqZgfyUYioc=;
 b=ntvlCP+BmAxSVnVWYtHlBEIidWNQV5bsAlr/esOfcfvKwh4Z60Os8mvBS16qXTYfLS+F0Dhd3S3SQjDTEILWm9uMNmlt8mQba++Z8sHHjEYGt0vqMqZSe1n4H6n5aWXbIl52yOAjtGomw2wYRlLQaI4MMmAA8CzqEhaHUA0aSPX/Uw3Q9WtRly5Rn2iZenJ51H9aSG7+/AGVtFaDtFCByeTsfehDKmR/5nzF/qq2xBB9C4cODNgzBlgmIFHvH7KUjLLdA4nAQlZnTOPnABw6Xfg8nb2jSnLKiUZ+NwMQlYdvHRlXSCz94/otSei2B9zO4OQ2jFnMLbwIKZnQZsIG8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 14:05:36 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 14:05:36 +0000
Date: Wed, 24 Sep 2025 11:05:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next 3/8] RDMA/hns: Add bonding event handler
Message-ID: <20250924140535.GC2674734@nvidia.com>
References: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
 <20250913090615.212720-4-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913090615.212720-4-huangjunxian6@hisilicon.com>
X-ClientProxiedBy: SJ0PR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:332::17) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 73dd8f77-7c29-4bc8-9429-08ddfb736f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WSFsQrpv1BCHQ+WIwOp+J79c5+8GELWSml6cvKJHlAFSijoyCdCK2gpNsIqy?=
 =?us-ascii?Q?xX5GABVK+2vr96hd8n2AUD7RyOXeAIPuF5GYZuHw/N8Y1NGi8aB9cwB61iPP?=
 =?us-ascii?Q?32XTfw9UtRoiOBET8M+giKy1Pev5Gih0fiPuFs/lu1oJ/3jzyToUHWrYN2qA?=
 =?us-ascii?Q?NHCCXM2yla6jKPCzn5TXOxIRiBbxz2B95wi61hYrFKCnEtTjSy/SIgohB2uy?=
 =?us-ascii?Q?lavnTBoiKpFTNe1IuAIg0ozeCQXUR5m+UwQqWwbhH6VxX9n3DXEZCLAblL/w?=
 =?us-ascii?Q?dDJdGxII1lI4CqPtUKxKB6hF6sb2UJ8CCZMAWmwc2VVozNgXjXjh3mq5rPmi?=
 =?us-ascii?Q?B6oQLesKTv4hsTVMkNcwlr2YW862A1lIxTWHKKkg4sGrLPZx8jhHljOJSJPE?=
 =?us-ascii?Q?FgQ6Qm5XKz5KQ15EBmGOjqlowcLvnkL2hYyN31wSNX/uvuIKScEL/D1TFvxi?=
 =?us-ascii?Q?4+1ltkLdD2XhI96PPZ58HcByT1MzKrhpDuIszHcf8QLu9w+jD+bO0Fpryfbq?=
 =?us-ascii?Q?TmkGnbUco5wx90hYaHsPMuxIEtBkzkUiDyioOpISlhynqVHWresFU4u+hgAH?=
 =?us-ascii?Q?cXi/0WcDMEpTNoMdqFxItmhIh4XAUKY97ftyLqgmr6B7nhtVuex0O1McTBGh?=
 =?us-ascii?Q?deCKVd7GTmL5BmhNOc8bRjQEfRk87932G4paSxcRqpmBNHT5Hwv47TrcySlb?=
 =?us-ascii?Q?e/SfBFPShVC0GUcHzn0WgZJSNRoB0wMiShz97Mz6zWVWEeNylV2Qr78L7czZ?=
 =?us-ascii?Q?+Hnxw49QAUKoFRKoBkmsOna28RA50diqfqtwq/K+6XpLIjv7dAuwXBs+V63y?=
 =?us-ascii?Q?FI2MQE0bk35f51tw8enL94AuvuwEtLE3St/nM6c8vHUcsmbau7EfxlzoAeBz?=
 =?us-ascii?Q?kv22mYzcUtRfG+dBshqj1arqBEKlhlf/18E0WRvgYdGUdJmyMEm+ehpFI8Vw?=
 =?us-ascii?Q?iccSUJ1rLOEtrAWvDQCuWJ+575kqL9zoU76oKBPC5JuI7uEhfuzFJ8vAJ63L?=
 =?us-ascii?Q?cVm4RLlt2CnuzuQttO2XEVQfySxbh4oj9SkrQcgL1alItTPtCiNjwn+rFBol?=
 =?us-ascii?Q?G99dZ5vhnxyOL8Kv+vbE0ml7lNcUPKtVeSmrxOB2iDtcq8b81pDIa/jg2hKZ?=
 =?us-ascii?Q?j8I1RBRhbbDSnbsTEJRobNlLsSmd/B0mrao6ybgd6OQRvgyqBNf/ymysHBZ6?=
 =?us-ascii?Q?ManwZhGK6h6E/waTaXfVfFwrSWT5PCPmdiFQN/x8vqDXZi5SgAYJ5pWAkpHr?=
 =?us-ascii?Q?SV1Su+0fHhNEwrD+fZugPLueL0LqSIdqwxZoVupFx+cxZVtWG6B3KOH7unos?=
 =?us-ascii?Q?4kv9EnBP4jWN2JZufUUK71u0O5QZQBnhDjS/07fn8S3HmUxu+0j6uTxUAxCj?=
 =?us-ascii?Q?hpdOTJVYq4y+eKKut3C3effXaXRWs/Spmzz4AJzK+BKtroaT8Y+oTUizr8I6?=
 =?us-ascii?Q?67v3TdwE8Z0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VoCMQ4dg308OuDQVBqv/YPtzCJ5dZUacPx0OgHsIszNNM3jrJrMVkRT7Kx39?=
 =?us-ascii?Q?3vahBd2wjc/tcsTXrehZd0Ca9dKJX7IVaZxIWwIHmvOapAf/BqZRkD5sY77K?=
 =?us-ascii?Q?wntSJ3NbvWjKRVaQEGD4Mzgi28YSAafwbkHUxJcURiG+fYPUhAZofSfNMy/i?=
 =?us-ascii?Q?H9dtEhTgoUjXjLNtehd8DiAz8UavfR8shM5+L5H6WN4dNpmhgT3oNAC6ru2H?=
 =?us-ascii?Q?UlRckbqH0iRjUgp3OUB3kGeau+Dzp2s54fBrIO8eu75js/uD8B9Sh9ToWvoG?=
 =?us-ascii?Q?ccIxin4CYfbpIjYolorYa3I53BBb8YbSzWXW9SpHJpl3O4q3BOfS5VPZfWv8?=
 =?us-ascii?Q?L9//8mG4P9wj6xFonATLzTXL8rYCA1dSOF3om15GBaQxQ5lu3HcaCx8Dg2gf?=
 =?us-ascii?Q?iXaPhUGuooTc2tfBZ5MLy0vuBji/OKaZXiqm2y9yXMojYny9D2bD30m4UztJ?=
 =?us-ascii?Q?T0nekQNV8MOtVx9YJHsQ+vrgeWhhXc2sA45ZA/DsNPvPzjB6pFyxxqUdfHHy?=
 =?us-ascii?Q?QJtgAuGmotyUGeidnsyGLOtg6VLPEr/ZAw/pAb9++cQLcD60oRCU/6gnCXej?=
 =?us-ascii?Q?T7NEJIouk2Muq9Lz9U5gKfw9AjSfiyQZhjhPMYfWVswEBCgH2Z5wCFPnFa06?=
 =?us-ascii?Q?4uWj61KhVZLE4nNO7+CuzRwxim6FAVWeOAZWBTzp06q17jZGJnvHBWW2IMQs?=
 =?us-ascii?Q?YxlnJZQrWRLfykMRF8H98SB41Xw6yRHEzPi9AM4lXPGUJiwstjv+GyX7w0qv?=
 =?us-ascii?Q?4kz6kf/zR/Q8ih2U8bGK0NWQcHqMzt6bW79THGjTcI6guLXy0z7SkiaHGv7V?=
 =?us-ascii?Q?xSBrsx7WCM0b8TJ/5Up63GbqGJi9bRzDPjepmI3BAbewDwUl6QwIUS0Ii0Xy?=
 =?us-ascii?Q?d/V4698dFvnsSMYFB9iv4FVA5b/YrTh7Az6GBktNEfz5f88s7tgQqtDc9IaM?=
 =?us-ascii?Q?PrJgG5RAEl3pvovbSdrvXGg+drKyTcp78LA/wEJvFb1mvuLzEw4PykWQ8Lxh?=
 =?us-ascii?Q?DzZa9ATB1NZI4uvcVz27eBLJWZDO9YMm9RrExzzJW2zdS/7KXjJ07R5GVYZu?=
 =?us-ascii?Q?v0jGfVgMktQ1DyC5JKaydolMaDKG0w4sJ9S2UyqPvbYvdf9bTvzSrQSgjZ66?=
 =?us-ascii?Q?LAJRjC5tfGzmKh7CYRc6Mo6hP3EBfkWjyxIEFCnDMgbnRVFLMr1g6b3AMMY+?=
 =?us-ascii?Q?vcNyUiGgM2XkKJY4ceKyWBwTO0pyL+5WBunVc6FyzAhtNdkinylcQ5XoAQ+p?=
 =?us-ascii?Q?43WEHrTpichachmPo7NOiVIEkdf7lvRg6sEU5/jEVtLlRYu17/VXLMw7u3jL?=
 =?us-ascii?Q?HCvp1t8k1yzX5Magr/PH57P+RFSc1wtitDfzhP0SWGVx8vFlagCFnsS+JsXg?=
 =?us-ascii?Q?YHKnSJsWklJQ2QsXexNnSON5ISLqNzZcD+JOMotL/Hd4q4+vkoxauEioYdKE?=
 =?us-ascii?Q?0azI0DxC0eUcAlohuSw9IYwNJsdcI7EpAnMM92icszYbePelTvVgk41d7agv?=
 =?us-ascii?Q?bNDQmIwObAlB1CfX53Ipi8wtBhJi9OYk9xiEhDJnz2E5tuhzijQYbhEIwG/O?=
 =?us-ascii?Q?RB95yIXQqbWgeeGnGOJhlwn8zznCcJG53Z9Prxmy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dd8f77-7c29-4bc8-9429-08ddfb736f7b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:05:36.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otJd8gXoc51xByvwI2Ri0QHE8Xi6+gRdM6g6SvvQjRZkGbk2wPdr0C6CGVPf1CxB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650

On Sat, Sep 13, 2025 at 05:06:10PM +0800, Junxian Huang wrote:
> +static struct hns_roce_dev *hns_roce_get_hrdev_by_netdev(struct net_device *net_dev)
> +{
> +	struct ib_device *ibdev =
> +		ib_device_get_by_netdev(net_dev, RDMA_DRIVER_HNS);
> +	struct hns_roce_dev *hr_dev;
> +
> +	if (!ibdev)
> +		return NULL;
> +
> +	hr_dev = container_of(ibdev, struct hns_roce_dev, ib_dev);
> +	ib_device_put(ibdev);

> +	return hr_dev;

Huh? Put the refcount and then return a dangling pointer?

Jason

