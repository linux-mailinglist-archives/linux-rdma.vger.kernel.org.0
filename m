Return-Path: <linux-rdma+bounces-13624-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BFEB9A269
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 16:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595FD7A63A8
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 14:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3029B2FBE08;
	Wed, 24 Sep 2025 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ASCS59sc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AD921773D
	for <linux-rdma@vger.kernel.org>; Wed, 24 Sep 2025 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722689; cv=fail; b=YsbeCD55By8tMyoid6Trk1NUyXbLHZK8g+9JICwqjMDogO4YOYXCAJg/eoDed7o1+6CopwGqO7kFKhd9QvEdX2UAdldLgJM4V3DYPDSoFpzxvLWiXv4wTXc0mQ62JUbBGvRwtVvJOjXLn91KXUYhkFpaqhg2uguKJ6Yb2aeyxFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722689; c=relaxed/simple;
	bh=dW4qMy9MJDQ/oOPq37CS6/0cGcq+nA2VwmVHxji/g28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gNUhe95iqdGF2wr5bO6PZ8Iq4u0+XVdICRV/oybMKglH6XbAVGhBYZhO55yaiUxEJAWYHtl+q2waeVPTXWCiEDhE79k66uvILyG9WyIosB7Ia8SbfWMg4O/Oc67LT+3f1XrtdCRK91cmSKGYNbBPI8NqVBCLJxbedq8PialCYLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ASCS59sc; arc=fail smtp.client-ip=52.101.61.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOL2EHH2gmabTVqWeq/Pnw3vVBDHWona0LoPe/44tLEbdN/wC/RFikFWS69+RzZp38jughxxwMMEnAjeGJ5sQRtztq1r+7c7dQI/XIkTfE2wE/frw6SygLnxgA6P+5t73LpUZKcABTd8ddprK9Yuw31CzaCpjlqicpc/V4cxiLARX9MgyYG8jSlmcLJbDwqJcrnP5PsU1dgH1wJpAyfJCvZQQ6528htp8PlYhYSTpx9Q89ofP04RpzsjU9hsVg8tWXkV/mNANB+IBscY7HOSAUfdz0q+2cNMMqBKckeyxOPO2pZqky+errHSHr5AOwVB6ov8pP3JUOIRb3CNd7PBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK2iK2TzXG2mNKvKx1PNGIWi1xmyoOaKTu8qNB5eWsc=;
 b=ES4nLrfpeV7iK1/BrfCWtySNKfZ93Sh3YzsIT/9fJv/bwn8f2PipxWG3KSCg/n6r3Hsia3I/WupkP3AcDmUlP01mV56GuGoVIBDeesgq1B4oD/cUeHLZ/s1A/phDlvrIrhH3yBz8fcaXX/SCsyisLTBpwy5fH+FojdjDktbVhm5cAhZPTAjYjPRpK2x8OGMJTKwBMUmhsY661HAXT9GLIch1M9MCBGXOxqG2DhpsrZ0b0ljEOucLaFpSF/XldPESM3vQ1xbiUBgLhJBZPRna8r6fy0a/L1PvdGYjSZbERpbkfoIPD17C8Via9VAToO1zLOOk1PRm10juVhGbQXcqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK2iK2TzXG2mNKvKx1PNGIWi1xmyoOaKTu8qNB5eWsc=;
 b=ASCS59scJGbGqQFuZVGeZlpna/EynpDS4WuqAmQBmZ564+bhl5KuPyCe29p+ssd28IeR+F+iUB4GktqKkjrbG41CpDCTGXSrryFO8M9kdYWwTYnLtWAxM8ZxjxIsDqRjfifFRH5nXr19Zw10qaGsl3ZjLmEX6odtc5ILhwZg3qbmaK/jpHas42teEysCxFYGxC9L+J/Xw5MIfzbz0yx6yNA/XuxryXXSE32+xJr1XFZBgVhhJpSp/Dz0MJ3Is44D6uYmxTc/EkzCBXwlXbvKDKz4+wjEj04q7IjZJ80SmMBnnIZcTeCvTEBV3sPLJed4CrCJjbp6buENeEb8QMdEjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.19; Wed, 24 Sep 2025 14:04:41 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 14:04:41 +0000
Date: Wed, 24 Sep 2025 11:04:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next 2/8] RDMA/hns: Initialize bonding resources
Message-ID: <20250924140439.GB2674734@nvidia.com>
References: <20250913090615.212720-1-huangjunxian6@hisilicon.com>
 <20250913090615.212720-3-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913090615.212720-3-huangjunxian6@hisilicon.com>
X-ClientProxiedBy: SJ0PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::10) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c40acc7-45eb-4143-f438-08ddfb734e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?29qzqYAYqdhEoo6dDQ0G/UneZ2DWPP+gQDhwYckZAeirIhJj621OxiPt/zaU?=
 =?us-ascii?Q?H94az/xZeZY+FAIqXLxwRkdaDpa2KQxbuJqc2sG4IOe9mvvSjkGeI1W1dcuu?=
 =?us-ascii?Q?NKC/39ke+KAwn5rbZGxiczYQMYmFoX684sVrB3KE8PMzVVc0/GJz3V2uupSO?=
 =?us-ascii?Q?GbfQxrvvm7oqesTeaSVev6awFCd7y3qeK4BvfKe/LgXWfqt2LCTAGoqQYR0T?=
 =?us-ascii?Q?p/3Cb3zVsQwxL038yB2HV3MUGps6OWZmi1NKKnn2myQbzp+vu/dco8Z47izg?=
 =?us-ascii?Q?DsVXyX0BcxRmvgBE9de5UKY7jT4rW0+GmTnyeFD9RkDRo6gJ7Pl8K4BqF3XM?=
 =?us-ascii?Q?Uyki1BULB1Sk0StJA8GmhvW9dd95dKhQNYjvVZ4FJA0hMz9R0qDHKu7jMlMy?=
 =?us-ascii?Q?Fks6oMPJQGJIzCzJmWADvq/2u3DgIA4B5PpbMGSmBFgsEtxnhC3VDu/wacSG?=
 =?us-ascii?Q?pdAxVflQ0X5Ox7h9bhdSPuvVTtCXXvv3m9EbgtxfH/O+ZjiXd28Rz+SyO5eA?=
 =?us-ascii?Q?5nhn5wCcQx98eiUlTWrIK7yrqR5hfo3kRlzpSMiAQs7ee4cXpZB+TnsuZq4n?=
 =?us-ascii?Q?JIGzi0ZsZ8FUGO5BTxgUUnSyWB86a+oYkcs7B/JNYBth2h8lTSWFNtg+9H48?=
 =?us-ascii?Q?PaVI4WxMc7O1843evkzB9heJlqSnmVPEC6MLnb7+J0xkQ5oW6BXlvIN+O180?=
 =?us-ascii?Q?l/Un2KFQAnHEdK5AjjX+oRHcA4jKzMQSHfa4wpnec3ZwhQrduXB6/eiHyPfZ?=
 =?us-ascii?Q?WatNtw3484G44ccpC1B4pZNflZW0TbWp3dthyfKRXRpgXacKM7OGeUg9Fiae?=
 =?us-ascii?Q?C0F7CnAaJcJJcm4GIrOtsNJ5VOnmIKc0CY8VLjt+c0nM5yWlSEte15qzdBbc?=
 =?us-ascii?Q?LJFnq8K36OBRzmLilu+j3ciYmBQSsmHuPEOi/X3JJHAaiUe4xDnaB3Y13CLg?=
 =?us-ascii?Q?+DHfkTH5cMITWaIdkGlHKm5KccuICvkcc7SaTT5XToWi+gPv6JuyEJrv9RJT?=
 =?us-ascii?Q?6rtlLJeHsAR7iXFSIZq9PxBoGxby5molw7Xls27jMNeKPTUPGnShxir3s7KH?=
 =?us-ascii?Q?IV20d9QNTdm2WCzsrCt5Xmwewmu6/fgkhbVhhzFGsL656Q+DL8+pRxoB2lMN?=
 =?us-ascii?Q?HViNNw7Tf5H3354LypiOnbYYuaI9kXst43b2aM0BxgJhUsMEvOAGzpFiwxVD?=
 =?us-ascii?Q?irEaDTO8U+8L3q02tZXn4VetZ26L0B9EtadvZZgvtqGqRMjPicYKlaQYVU6Y?=
 =?us-ascii?Q?mZ0LHhvHDVQfioHVcPiXepvni2ghZSo6Vkq+ZAI8eez3QzdCue41dy/YyyAr?=
 =?us-ascii?Q?vjdlxMY7sNHKLWTcPgp6dMcJzDikONQ0l8sJDCy2rjFxXOElXqAoGo3vW4VU?=
 =?us-ascii?Q?xXgQshoaAqkOsc9VEUHgwCxXKwOWtWmwli2A9o5sBrlUmL0wGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fiI9KWE/kKzXaKa0cIx3UGnHBmtNCiMgcV9va2Z73b2lZ9wSidvioopFphS2?=
 =?us-ascii?Q?EPo1qH3Kt7TIqUYr5OvqROHuU6Qh+8W+wU4lgTT39J7gZ6BO2xFEI0R6ASsn?=
 =?us-ascii?Q?AiX37cq2rhRE5EGqWgCRautqVAmG1QVZ5BYvdxqritPvssIZesxYVFMLyomd?=
 =?us-ascii?Q?EJ0QJ6MpXTSrBlKoMIDYH+7tFNavEUDVYEL7XPEILTy1yddrPgWlZyvplVfS?=
 =?us-ascii?Q?wMsEHIJH5Ce5jb7yt8nAptFzf+wgmeMN77Uyh50eY8n4l4vMDl4K1Q+OJf3g?=
 =?us-ascii?Q?4Zz+Fr7+oxG4le8+kizO3isnccWMxP8riznBWoJSRXwFlGhepcDHp8iPkdfT?=
 =?us-ascii?Q?j3RFkrlzEgAXbqikMyguIE9XvQwGWMDnzMg3zG9muy0p7o4eFrtx3w130r0F?=
 =?us-ascii?Q?IYMh6hguAOjGkdoX3bX6omS9M8CprMt+LzL7d/waaCf1LR/CdW5XQ9H3soJl?=
 =?us-ascii?Q?ru1SJI+ohyiB29PhbpNue9SIr/+IyoCRctRF2DptDYf8wV2lT16sYeit3TVH?=
 =?us-ascii?Q?9IUshkW6xGKSksLqLpzyNTerAwOEjBZ/91UJZCYTTd82jUO1Dke13CwYYvFe?=
 =?us-ascii?Q?PcTXK0mCCAG14ADZs9Ie+wEakPI7bGN6LHCdFG8kyLFLys7SrqztBBVuXPXv?=
 =?us-ascii?Q?uKwr+r+/koSYdh/wDcU3+UpLMP+TzKP6Sy96xn1HJlyATDYVN6UrwQcjfVLi?=
 =?us-ascii?Q?/yDySSFuPswkyfeSNORAJ2+3yZgo75lpYGzz32WiugajMd+oEoj4DY2pYAt4?=
 =?us-ascii?Q?BlPXGjoSpWL8uOU5I07HnlrfOImp8toMnwONJ5OZ/hQT1sKC+sbgH6qWl0bO?=
 =?us-ascii?Q?Xt6QOFwmCpUNTvQClkXdg8QJs4lzVnV55kvmB7WUAHFMP55PV4UHUle3o3t6?=
 =?us-ascii?Q?ieJ4qg2HSz5ia9S05khnjjq/UY41kotUBOtyv89Tz1wThCAuV+alvGMdKE/c?=
 =?us-ascii?Q?FQj/6jCnQVlPjaX4ZmyX7G3Za/YBTbX7SSml7cnr55jQMVHNTZY6V9EK3BI2?=
 =?us-ascii?Q?fOsi/IrUvoTvzCI2bFW8YpEQWnKFkKaYttgZABD1lDC4ryoESAdkRgEZaKqG?=
 =?us-ascii?Q?PD1b5SE1ojqJyvP+9/LgUThSdCAPrVMHdrwbBjvwEI5U69O0T+aLPBjFNQFK?=
 =?us-ascii?Q?i+2zu3u6AWTvauKsUnc1G36spjW0F/TMXCltZC12D+Sie74g4pJAo4FyHVFY?=
 =?us-ascii?Q?Ltk3Cug51XeShZ2dD6whvGc4QTtVfn2yaq4jqxwymY877dH/P9+1vJrOgNon?=
 =?us-ascii?Q?LowFQB/y/0WHE/c3QEmKHUzMjnXuD4+vAlfzjEoQFNYwTacgbqyk0wtlzYsH?=
 =?us-ascii?Q?0bTx1f07B40FU7yCpbfDtcV/yVPd4HSw3kr7Gt5TTb2OtebWwulr0oVT4giU?=
 =?us-ascii?Q?CHNtW3ihbzR0usAy9sagRldwpfTFeb9FkpnRHOb3fiIuec+d11XlR5UsHiq0?=
 =?us-ascii?Q?RprUBGBAHjn1WOFCo4Md433YkYlQxP1A6XDWS0bt7xKZwcdG1ZVVISiwoWOL?=
 =?us-ascii?Q?58YTz0OtTe/SD4DyleaQ+0jc8Ej7jqH+RoQvtBb53zfJ8UDtF6hYHsZSqRUv?=
 =?us-ascii?Q?jKTZkb4Egk7q1yXWTDn5hz5EJSaxfREXVhOm2qf2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c40acc7-45eb-4143-f438-08ddfb734e3d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:04:41.0635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myj/UTT5kqLwFvQkPPshygN9JG0XQXTfHrMwSlGjLsw7SjHfpxyIbOEyR+sof/lq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472

On Sat, Sep 13, 2025 at 05:06:09PM +0800, Junxian Huang wrote:
> +static struct net_device *get_upper_dev_from_ndev(struct net_device *net_dev)
> +{
> +	struct net_device *upper_dev;
> +
> +	rcu_read_lock();
> +	upper_dev = netdev_master_upper_dev_get_rcu(net_dev);
> +	rcu_read_unlock();
> +	return upper_dev;

upper_dev cannot leave the RCU without refcounting it.

> +static bool check_vf_support(struct pci_dev *vf)
> +{
> +	struct hns_roce_bond_group *bond_grp;
> +	struct pci_dev *pf = pci_physfn(vf);
> +	struct hnae3_ae_dev *ae_dev;
> +	struct hnae3_handle *handle;
> +	struct hns_roce_dev *hr_dev;
> +	struct hclge_dev *hdev;
> +
> +	if (pf == vf)
> +		return true;
> +
> +	ae_dev = pci_get_drvdata(pf);

This isn't how you get a drv data of a PF.. Use
pci_iov_get_pf_drvdata()

Jason

