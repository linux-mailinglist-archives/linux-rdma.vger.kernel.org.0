Return-Path: <linux-rdma+bounces-8868-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54747A6A899
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 15:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A836C16F7BF
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3512B1CDFC1;
	Thu, 20 Mar 2025 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FZcVI1MT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7B51B81DC;
	Thu, 20 Mar 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481181; cv=fail; b=eGgrak4hx9LfByQrSyl6naDeiG3qlvys+LOOATLYmSzbwxaOS/c7d5irmVV7FlbvLBZTOeKpro60yBA0rZCXvTKJmvWD9bqIUPmtWG5dkW0bGcdqIMdjOh+grgKGjhQz65Or98rcIJArq9ubVzh+ypA2lLaU/zTHJtutbb7D7OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481181; c=relaxed/simple;
	bh=COQQUeFnVcXI+Rbf8CH0dJYGUaCK/pA8GcoXG/Pd/Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RdvHI+AsDKCO99aishw4Io1j9e+NzdbpTmUnr7oIn2Et1WpJmIEjE8dXaTpA0njIpCK+O43vT3XLLDc7GUUHoux07tPJ4pWb1KpN3K2SmkXIyLGngaKbqPDSuuoGjdxWP6Q3s1XQyD6DDm4ZQKFSNhtdzacuYUdKf4XjsodzLwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FZcVI1MT; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kv5DrdIhj7Z6/7udeYCbhPLx0n4pjK5cih7guXT4CD5LtNi8b9/wsdWLmFPfkS1zX1gEje4LvFVKiUIeEVg47FWsNfoAgQSdPeqpWlczRxSMjDZ70v63wKlKPd1C/PbLYiTzZiQ7aqemNl+zpUmqpfXIbVAgeqqGmZzmYbb5LH9E56BVzMM3dGbJSN6f9DZKW43Qr7XNhSBsWIwVaKZyTrI2UO1tjMbV8E+wSuBgqJ86LOBT5AUZpOD5S02D4HvwJ259WQjb82dbUHH0da+pFpKDmmfj4Du5wNEcf9+Md6+VPgvLC6GJJcxbxyPUw3X1oS49GQK9yz74illUkI2IAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COQQUeFnVcXI+Rbf8CH0dJYGUaCK/pA8GcoXG/Pd/Hg=;
 b=pJ5TmSniLho9bynn4gY791FvB9kOulQfF66z00W6bLXynvGCyYwStvbNItVQrN+H+z7ewhdA5uoS12mIEsvSlIHfl+MXwxGuCWISz2i0XHfWgONopjgvElZZEG3pu7E15ABCj2Oi5lkbFh19/PjVWneimFHNTZbVgaO0FPAIvOD4ihennyXx4O5KI8l3fLubzayO8r1tlxnTL3OZtt23lHYwFGGwqvsBdpKOhzmP2t5zhxmEHorfWyGO0HJUGpXQgC9mX1xIvZ/qkARqaUy1CsX1qd9eTHgS/+v2oGDmIdsh9wejHviqUJHBd9q5iQMKkxmuarvtYsDVpAIy+mI6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COQQUeFnVcXI+Rbf8CH0dJYGUaCK/pA8GcoXG/Pd/Hg=;
 b=FZcVI1MTS5ZQBm8tZpoIRF64wUUHToqOaeDgb8n38czSxGAFvNqO22VDNn8OoTLE1vAsxDgK4Wc6CGfBgOv6WQGDwKtNMxLJ9cFc6SvRdMfr4WTvRXRiK3Un6K7u3O1+ZTFnB0V4PTKTU44/JG5tc6P2hWOpQpV2YwaLFj1tjhrFAQeVpQPoMEHW3EDwnUn/pMwPr5BZPaGGBqrOWM/EqnPkJrbR//83nfNw/fsy0IUzgIM6UTXPZKd1Y8whH3lMbk85xwC/s3cSZHYY13RwbDxRl+GscRjLNZJlQDLC0MzFAgB3my52T9uNEpR2fh6m0nTXP7uzlM2EsWw1LhnouQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 14:32:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 14:32:54 +0000
Date: Thu, 20 Mar 2025 11:32:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Nikolay Aleksandrov <nikolay@enfabrica.net>, netdev@vger.kernel.org,
	shrijeet@enfabrica.net, alex.badea@keysight.com,
	eric.davis@broadcom.com, rip.sohan@amd.com, dsahern@kernel.org,
	bmt@zurich.ibm.com, roland@enfabrica.net, winston.liu@keysight.com,
	dan.mihailescu@keysight.com, kheib@redhat.com,
	parth.v.parikh@keysight.com, davem@redhat.com, ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com, welch@hpe.com,
	rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	huchunzhi <huchunzhi@huawei.com>, jerry.lilijun@huawei.com,
	zhangkun09@huawei.com, wang.chihyung@huawei.com
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <20250320143253.GV9311@nvidia.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <e798b650-dd61-4176-a7d6-b04c2e9ddd80@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e798b650-dd61-4176-a7d6-b04c2e9ddd80@huawei.com>
X-ClientProxiedBy: BLAPR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:208:32e::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: cf59962d-441c-4dc7-f3c9-08dd67bc1a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FzSkl5mwM7HvXuu/BWdUcxb6c07wYN4Sakk/hm3EnYQzVC5sQ6Pf0HTKOayf?=
 =?us-ascii?Q?6Oc0wSJfn2eHUbarPuGzayQHOFfKzex4oXDJYtR/ulvhVzwU0x09IjCPbLGp?=
 =?us-ascii?Q?bI5Yak10HeU1ZmOAKjvA1qFtikIlXRH3GljAmqV1wt7bFVUWN7oGJHP8Nykg?=
 =?us-ascii?Q?MtGcz7f25vnOhtlz4sGmNU7o3AJ8a/2hPymme+AGlVJVlqpWhui998FCfMHB?=
 =?us-ascii?Q?KfqA9x8Rki1DnIWEc+2WQ7PBehTresf+sCBaZ7zi8U7fi4Twn9jpVs7gjLBL?=
 =?us-ascii?Q?vsle1ACVm+LZtuFr/NTjlon+YcfGN0fWSOiuL7pHhCWF6xUufWJnCjPYH9WS?=
 =?us-ascii?Q?FPVs7+34Mc6f92abKN/AzzJPXgCgZQlH/0NX6yK0lPaYDdVOrMGey637ABip?=
 =?us-ascii?Q?IhN5pue+6Qje0hw3LWXe9lSrh7unjHDErEcPixYNCg6Jg9m54rAp2xoJ/2Do?=
 =?us-ascii?Q?GZ2ObRMPxRSM+h43+mppRs0rH17id4/2AlpFe1VBUDHZD6OXENf0VGFcoVk1?=
 =?us-ascii?Q?JviygcSJo/5yq4FO652EbJMAMRA8Mw93tZPyVyibTSMSDclnQn01QaOcnXrG?=
 =?us-ascii?Q?J16I6TaqsDMur2exvq8O95Bfue0oPNJeX8htXXFugEXSOpVlMPA+2dWe7Dpp?=
 =?us-ascii?Q?9K840H1dC6IqZfS4JlT7JPYKQ/AFLFxiiqdtoau4VZwBP73f6yNyXv42TE1L?=
 =?us-ascii?Q?nXvYHBYhBswwcpKKoiktQ8tmmPVdK6FK0GBHksyU8wQLXWJrX2BrgU5Z6twM?=
 =?us-ascii?Q?tAehC+PSpjsZihpY3FieO06nrC79TAzaOlT29ANGuASIRrmJzCHlc14BYKkF?=
 =?us-ascii?Q?r7rRvbFMU5Vh5d4rsWLKYC88oUGbmbql3K+D+qeoGk8oRUaIlsGMuaWIwpa2?=
 =?us-ascii?Q?tNRP47kqIshFDiVpHU96aUG4udYB/6m/yOs4BRQAs1PmvbxLEUbyI47sy2Rr?=
 =?us-ascii?Q?oUbsT/7DF9B/OSCzhkjVTmCE/6HnH/iYPWbteGSR20eFAQACawlzaipGllgK?=
 =?us-ascii?Q?dy0l3xq9IDL4cDnBFBK61DMakM2vgJzk/lVUP/+60zrwVLkjEKQHLJv86KLx?=
 =?us-ascii?Q?K4Zf7eZ4gvTuuUCQK1n90z+xEjGge8bR0Xx5tqPDSOgG7508V/nnnj56zlca?=
 =?us-ascii?Q?ub19TDMqrYCfDvwFJjdIs8k0ibQx1Naqq20iP3WXfeOC3UNZyIkpjPk2KdPv?=
 =?us-ascii?Q?LfhtShL/9sKJDNFQQayDhGQtn/vgsL09+tFCDzRDSQQZxccN34vQCJoIWobw?=
 =?us-ascii?Q?4ah5F4mTj5UGCerYL0jMzfI2Jrp3JhcPS+oCQcchyZB4hDBYXOi7JH4d0t8v?=
 =?us-ascii?Q?vxYY+jPgcOMpiDuhMKoBhkTpjLVizRsj/tb45xlDFuRZ/w3ynLfiWC4aGbJF?=
 =?us-ascii?Q?f9wfl9vOkpDtQR/Kwi9boEo+/x5g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UR7Tpkb1pRK0eI0+0h3MtzfmNugYJ2Stu7HOAgNSl4L2scK3sRVqS0pad9vS?=
 =?us-ascii?Q?Bj55x9+PAGwKwerO5XWqDMzIRwMc9QUgo7DH6E06qTJ9M01c1CRC6sDMMftM?=
 =?us-ascii?Q?BTlR+4Jlo81Z8T5xC93hRQzw4r7sfCp+L2J7R9Aeg3DjpyYtHFtnTa5pwTct?=
 =?us-ascii?Q?h/dtK3rcq7+LIsVG4oMtewjqrVYf5m416au80aA0IR7JkCu7AJt9YcSioHbb?=
 =?us-ascii?Q?y2Wpy2zThp6BfOMvtHGaKzYjIx57bXW+H2XgQtVH4zKD9+9Nmd8sXFykqQwH?=
 =?us-ascii?Q?6cVjnIhl66YsCK2KfNWcYMozzu3WwiYAzm8xLJUqa5tsNMi//zLZVVGKDTyc?=
 =?us-ascii?Q?bT1MdcWDYUZHOa57xuASCiZxnmStn2bfRlquNNLDIfQSm8oYW6POOOFqRzdd?=
 =?us-ascii?Q?N4VfKh7vmwBozkxmmwEzKQWvnEWbfpRk16FzNtMomHb7QY3RWFgcNJl0yADJ?=
 =?us-ascii?Q?f/dEEA05gOX4BsMVfl6xg2ZpyB8xx0Uazr41dT9TQjLlQyFXZBa40yfNU/2E?=
 =?us-ascii?Q?YXeoYWxfVQn2e5xqRi5mHZKmBiFDkdI7kHA0qpQBOrVTfogzOtx6003Ln45W?=
 =?us-ascii?Q?VCrB1MFiNdRGYDdw0ql4f2RMwzuhUvTZclCRUVUr42x3Se8lw6Y0FEo+oYyv?=
 =?us-ascii?Q?lt5MpeokeN6lW8NJRsNOLXbJtxefCl3khzYDxtR57eidtJFvKKsDSdHV4ExK?=
 =?us-ascii?Q?VXVjR727wDrcDnRvxljlgufHk9bCSP30ck3toDPRmkp8vgRRSUH67PJ7bg5X?=
 =?us-ascii?Q?wNoaNE20E3wrj9v1r6itLRqN0AiiNTFmyf0UmjpKOUKA2W8ebIphRY/uxfk8?=
 =?us-ascii?Q?NDpIPXn8GUeVXirtGnicklgN9VvuEj//bw5c85BaRBiQUFhBbjqlwJtr/G7X?=
 =?us-ascii?Q?kIkUJUJyA/GScwuIsTDqrbWkoHVwPkeGVqzb48+Ul1jBw8WlVK8bUaQRUgAj?=
 =?us-ascii?Q?9Cz/VIjxpPhXx12HEuL/EaH9D1fcOpHnx72Qy3KSVncpGMdGa3v7xJ4iOBNI?=
 =?us-ascii?Q?4Uumlp4rBLhzeQacfGGf0lNe3+YMrJM7hxaA+PMg/Dt4BsMlbfsjTwK9zNZq?=
 =?us-ascii?Q?pFla9WpXWSoqJUx6CvpA03r4S1a3HSVX164DDIqg3Tf7s4KRxQxHBIPt5XGU?=
 =?us-ascii?Q?tOFLysLnOPdiYsAmPcA//G8W6MEwZWOCQvGeIwMTPas0TrCRxuAlqOGPq69o?=
 =?us-ascii?Q?4cA+iiFhytNgoDmloHLGMzFGF3ovTVHXzAi4k4WdGobV/BVGfydWtGHJ1Oyl?=
 =?us-ascii?Q?G96c4esvpp4tRrxWYazJ+JGRDaNebhWpVaiDqlCxSXttu47m6NUDh9Fwb6E4?=
 =?us-ascii?Q?akM32EO93LawGbsdN3D7CrfPfQKqCI4Koqui0lsXpybJqy9xbzR/+3PfjMdJ?=
 =?us-ascii?Q?lY6SzhE1xOT3ZqmCUofzr0FuXUko75AwM6G36ajDkNUhJFIOxwayy9OEAFpr?=
 =?us-ascii?Q?WmPhb3GUrSg1tJZwF7wIji/g9VO+o25HGbu0Vm+YtxLgKkFjmd3U9/Qzk6xf?=
 =?us-ascii?Q?Jcjui1rMaSt2Wp1A2dGTOdxGtEBVsSVlzo7YRtngifRv/1v6A6aOmTKyWbfx?=
 =?us-ascii?Q?tK+arv1atxQ5u2QaRLM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf59962d-441c-4dc7-f3c9-08dd67bc1a01
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:32:54.6504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0+HQJLWHjIMcFSA0bozA5gJA3WRZLx485yg3UY4ZDiZmjeN6PE3X1h8SMkxllcM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301

On Thu, Mar 20, 2025 at 07:13:01PM +0800, Yunsheng Lin wrote:

> As the existing rdma subsystem doesn't seems to support the above
> use case yet

Why would you say that? If EFA needs SRD and RDM objects in RDMA they
can create them, it is not a big issue. To my knowledge they haven't
asked for them.

mlx5 has all kinds of wacky objects these days, it is not an issue to
allow HW to innovate however it likes within RDMA, and we are not
limited to purely IBTA defined verbs like objects any longer.

mlx5 already has RDM like objects <shrug>

> As the existing rdma subsystem doesn't seems to support the above
> use case yet and as we are discussing a possible new subsystem or

If you want something concrete then ask for it and we can discuss how
to fit it in.

Jason

