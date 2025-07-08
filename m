Return-Path: <linux-rdma+bounces-11961-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12E9AFCA6D
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 14:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357101750DF
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 12:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6739029E0F9;
	Tue,  8 Jul 2025 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fz8+WzOz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B619E97B
	for <linux-rdma@vger.kernel.org>; Tue,  8 Jul 2025 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977791; cv=fail; b=XObBbrIu188U3LcGARlLyI4YeXOGkfqrpEJF2aoI1w5yE2ySIqENePDtoVCj0CvCmObo/UgBlWOXoLwqjsy6EyugHk+JzusHsa8JDTnHK473uMa25hNqToroUxVIvlrwJsXo5DHbqSgWQz8JZvWwddBNq02DKxZ5fbx5m8Ej8qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977791; c=relaxed/simple;
	bh=ggf17/3wG2T9eemMtKeq6+FAkRbax1WtLSDDgsIFV/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rgKsU2ahtbnjYQjerpqCkt/lgNWxJdaezbBT2lGaeKBYDrrQFe6G9k09IPwboVTAfzXRUtBf/vqEFzHSoiA0js89PJVIAfCsR4NMaVivFNIKl4P9mWjMIYGZMZ0k9wb/SPIhxu4+GBNjQCljqYE7lbdtID4INMNLaOIC7TZY6oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fz8+WzOz; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcazqLQYm3FU0UMWHHIU5oiBNlOHGnaC62LJjWa0tRVyHkREsz4DzoI3GRUHL+9v2qpTkOsBXIGICGb2x7XJKcfvOUEwjOBQpRmX0SUAqK5PKyTkhKMjUkH9b9LgHsnt+QkNET0xR8OjK341XGT08edUqpMGc8s/r5QoRDFrRZOKvQOVmWmg8PLYcVDif6yF2uJR6Dh9Bs/Z1rit/MbF4h2phFX5LpaM65yULphX1lr27QTs4SQUYj508hvwGELe73W8Jp/BbXQ28PM9pPCQCCTW3LFUniqKw/q/OfR6pdRVLzPUAWI3zl8lsoQPWe4d3h7z3WqflHXoEXRIEoDSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZtRbBE5LdqeehjHDyUn9MfzrotrGgzJIOSL+8brhZQ=;
 b=YPK/DtOzlngV6yNPYPsRs47p4Q61SGVhksIdo7GT4zObxPZQ5Ut628fFkzkg1IUU04kRqVl0nbAZvqrOgCo6GewD25Pm0IT99fGjZs7EqNh6sU1TsZoBn1J2nYt5qXq8iWJre9hkeXXM39p8CIS/uDQX3/j1XTP3E71XiDhov/lmZIkbQhk9nzuwO2yVv0XruDjsTh+he79sr26aTpjBbfigR9TNyI1g1HiHdm/9kAOPd+7Z/OR3uE4xHAURsSfDTBbyCuOJNROvjYpd1jsHUI9bKvQhB0hQrP5hrBWizMi+d9akwauXzsmansH7MGo1jcX8l2bsd6EQONFmPpWEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZtRbBE5LdqeehjHDyUn9MfzrotrGgzJIOSL+8brhZQ=;
 b=fz8+WzOzXa9UWi4QJ+5Ox/XGp9hcPYsBjuCf8mBo2ZryRguD9aOwSTbitRYNQd1UKiwWeLEaMoa5hjY56zj1ZFKSK4b7GxcfjOyDEjxH8aeyH8ISPuRGfrSv7SRAM5joDqdkps2CuPkQ5K75uiwrMNU1c4dFOYV7f4JavdNB++myjUAX777x/qZTri3GP69j1bdy5Z1nWApmue/RMHm+dWlNinxAPGNRSgdRaxh6s7Z/j4cehpXK7LCFoSK+S3OY63ft7D/xRmu8pOqXQT5dzBnNXSr1dzPgpSWDlNJHrnbkBdp62G8DbhcFi1+AuCPs7jA54y97fQ4CCiDe50V6Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH8PR12MB9837.namprd12.prod.outlook.com (2603:10b6:610:2b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 12:29:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 12:29:45 +0000
Date: Tue, 8 Jul 2025 09:29:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Gal Pressman <gal.pressman@linux.dev>
Cc: Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Christian Benvenuti <benve@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Edward Srouji <edwards@nvidia.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 7/8] IB: Extend UVERBS_METHOD_REG_MR to get DMAH
Message-ID: <20250708122943.GW1410929@nvidia.com>
References: <cover.1751907231.git.leon@kernel.org>
 <dede37bca92e66fcb2744ea68b629649d1b57517.1751907231.git.leon@kernel.org>
 <4e151293-76f5-b44d-5045-d699e16a316d@hisilicon.com>
 <079b29ad-593f-4fc4-b693-db3eeec9fc23@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <079b29ad-593f-4fc4-b693-db3eeec9fc23@linux.dev>
X-ClientProxiedBy: MN0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:208:52f::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH8PR12MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd18d73-e261-41c1-dc25-08ddbe1b1eed
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nh+32MlWdxMkYrXBmJEBXWcqs1dD/EEYSScPC/Wkqj/vXVO7GoqCCNXQ7I2q?=
 =?us-ascii?Q?PrhvcXQZdsHYdALc3suLuXVgprxRnDTbqLv4TBMhfy1/wif/qQRtUNhSNjXN?=
 =?us-ascii?Q?L98rLkhZ6N5cocooc+iB6V51rzAssPvPXdj/kzCA4XCwCuTsr0l1cQ4Qeon0?=
 =?us-ascii?Q?o7egc7WqhAMYk37nSgeoWJMuahWP2eh0l0Z12+EK92qHdRAoOvYCyTztzW/G?=
 =?us-ascii?Q?5OfsGP/u6ZBAphz6CyHjuLbVAuVW3LcScduzf5Mri5ll3boAylDf1P0lUi/7?=
 =?us-ascii?Q?0YNMfn+83Qcd21gNuB9mBFzA/L9MpacukB6WI9zvTo+q7Oq5Rt6XK9XJWBh9?=
 =?us-ascii?Q?da0wm8q39cfc5TtcVTpCKTzdSvAoPYjvPKoj8Qqxcz9ZKOv4QE5KcZzEtQeT?=
 =?us-ascii?Q?lQYkqj38d63bRCYkYBGghyhMkY2Y/cfH6VKmuzEJHrgoLyO7O1xVTWbBDAd5?=
 =?us-ascii?Q?k11xCGp6kkgX0tFZtew2YQLye+SOgHpfDgpO007iYrml6uIpug4ls4ba43VH?=
 =?us-ascii?Q?fQHmXOyNxmDLL8ncRLgCt2md02Hc/BOz1gIBi81VEDucTmWmdo+i740ZUyFq?=
 =?us-ascii?Q?Lfi079HazjP9rtN8/LYRbTl1HDkbcYgn46V3cGBr7ibQ2gfhB0y2J8Z0XEo2?=
 =?us-ascii?Q?m9L3dRAgQ8B+CcSKMLKgUdAYw/rZfrrS58tt7FomU8S6I0xdWh0hMoNtrFB8?=
 =?us-ascii?Q?n9dGvjgDKXkPSN1aezVkK0SenmOOJ/QoaCN6sdTX4ldImgVWU81UIaKv6K6p?=
 =?us-ascii?Q?p3Lw3KPoDgh9U1gkelxqtGFSUJmYFU8wNa4VrWHtOjv8xhUws9AU12REx/Bz?=
 =?us-ascii?Q?Y0N6p7Pxv40CH7IFf5TcCCWzat5+93Soo1WcsRMTw9dFcEGw6VRAvpErUm7K?=
 =?us-ascii?Q?8JAUYBwLIlB/aI0cPzbYRWjh7QN3DVhhJi/NLluWFTFhBDuBVRu6aguSTbPV?=
 =?us-ascii?Q?/AxpKrOKaWQtzem8SHtPp6759NSYAbqbiY61bE+3cwFgasv5w2kUqSruH5P2?=
 =?us-ascii?Q?61d55uU/OtLC8iWo7CEhqGEhfCBinbOkHi0Pbn0hm0mx3qmZRBK4kImKHjPM?=
 =?us-ascii?Q?6iUkEJGW+WyJPYrnKdpRa0vzGWwYwTQ9aGJC98u5aeVYduoWns9gfljy4DEc?=
 =?us-ascii?Q?HR6kGPbYgz9S24D61jY5jydo3GZsZYQzxVyjYrmJjOHY7x1vldQQeufrKuEn?=
 =?us-ascii?Q?T6eGn34Gbuh0Vr3b5CSL/nTSx2u8jNzbhYuVN9c79XPjOT4yDEGzrmKcDJpH?=
 =?us-ascii?Q?RqTwTMNWqFzipYWu0skAoHT7XuBcQkeD3g5yp5honnsC51RNTDKGc0NGAXUC?=
 =?us-ascii?Q?D46dhWRCs9JHSPDXJaaEk6QsBtl1cnfmsS0DyGwsJQrVo6aW+Ip+E/o9rjk5?=
 =?us-ascii?Q?V1xVm0cYuaPjl793q1ZRBeCZ4OTTMopthC3hJKriJkHXuDEkyVfVPBVB16Fi?=
 =?us-ascii?Q?xvTLLlwp7v0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FWiv4R2mCDcLF87pNeDexfjfYGoCrVZYd/yJxdXXbhTWtL76I9vUwfY6lpU4?=
 =?us-ascii?Q?X51vTZ8h+3fM5VgIkL+0k4bNLEVzys3WbdjZ4coZ+z03rx1xwwPe6lMo32lb?=
 =?us-ascii?Q?noWefhkPNzt5F3487yXiDVp1EGXYBeFnMXh6zFs6LVgbU04j5Q1+Qu5ChpVB?=
 =?us-ascii?Q?C7QNfb1emveG08RvjrQXd9kWwZJCNaYxddvi8MocBCSooS7N/g7Jem8sZEZZ?=
 =?us-ascii?Q?5lJdwJeuRsvGMdEGiwBIZ4M2+N4eZ3d8hiIUYGgR9/txCBfdZuxrCnv9he3z?=
 =?us-ascii?Q?7WTxB+Bqw2OHYFuk169DUOkCaHzXLXLARFih4I6KiIoofqgiMtqXQTY2fMwU?=
 =?us-ascii?Q?wu/Mdkx20tjfjHHsb3ruABok96ZW/WMoGcVgrhDC1370G43xrPbWND/OufsE?=
 =?us-ascii?Q?IneuKT1rVfEYg3jIr/OuBbOVeH9Ew3JJydbOcwAB+ziHZmnBModt6Lto28X6?=
 =?us-ascii?Q?St/pigNj8nb58qlYMSJt978xqbVB5Rw3QJx8QOqLUKzspuGknzIP2CEW2kqC?=
 =?us-ascii?Q?+OBmxehutlhm6lF1SOhPrulKSagkBkPgLnEC1WjL6ZWuys3zN0fqTYM9Bt63?=
 =?us-ascii?Q?1gWD+jdBpexWpX5rLoGlOY+ahhFIYM4X1l3mm/oD/uZBYL1Aa5gWpi3agR24?=
 =?us-ascii?Q?Ez9+ECGdgQBh1DBlMDivwHDUBwvm9gbCo7cN8aosTmvIYHP1f6f1IrkN6+yx?=
 =?us-ascii?Q?0rwIVNEKNRrheeYYm1GW8CgXeTHoCr6KpwIy5eMQL9G5cQ9/U3rFRT/sfDJ4?=
 =?us-ascii?Q?3gozhg84R+sPCHd0R9Hi2eav+E4ZLOvbk5701TmErCmtek7yFodCrLhXXQqB?=
 =?us-ascii?Q?hoJiIM09+29z7uYJRufEvt0ylylAmf5/9ENlbGNeeARUoC6d5z4kVeLMVS7A?=
 =?us-ascii?Q?aSKveR/eUIC4DdO0RFCUVmJmlXLlW+wLvG2YqPjss/aKAND7Wx061ECt+AeG?=
 =?us-ascii?Q?wWLaYGMVXImBBR6NO9R61jSeXXFSycG+GNAQdCUEKMEVmj6DgIf3BfT38fUN?=
 =?us-ascii?Q?9ACguWeVp7YuRsrzKELNi4q3SGqtOZXqPbLjXF7TURdV56OOK2uofD81tvE2?=
 =?us-ascii?Q?BkuENGkp57AlJJlKJuxAby7ZWfKLYQNbkyZBQzgr8bmIDJt19JAObererSs/?=
 =?us-ascii?Q?+LLNHAYKXCh5RXfiTIts7wgjvTTIokyZEZohkoo3V12YxF/2lnbLaffMeAvp?=
 =?us-ascii?Q?uLbiKTPwSAmbP2ky9QXmSpYTq4x9IzBCeA2smqt+s41emS2zRpztr9TwWsnW?=
 =?us-ascii?Q?raKj7BDdC83aG2GHybahlpLWVe8psUi7kw0NwELI1GxHvcghjhnIQRrdfxpI?=
 =?us-ascii?Q?A9zlVxr/WcbrQCSECmY2+244/WHv8LxIPowFos9aMJNZohiieduejwT3wtAi?=
 =?us-ascii?Q?7ODIxC+zBpWNdRX1EtmbD0sDzffmga7BocPhLDGOVnW7TldhBlxoNGsXMaPS?=
 =?us-ascii?Q?9v8bgb9i/4Lt4dCZnJV2I3tnWAADKFn46wne4y5P4G/omqkyvXwXK9VUia7D?=
 =?us-ascii?Q?WaEEdZFw/AsZhd4weYV77ro1+0BxiE23FCbyTP8jRO1jtGzdp4lKQDFttwT0?=
 =?us-ascii?Q?Zr3nza0UHev+bF9vjQSxLf0akxC1BlEdeUJrtlX4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd18d73-e261-41c1-dc25-08ddbe1b1eed
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 12:29:45.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+qEFp3+W2VHPvvzznjI/7nDoebHnCnL9Qb+SViqiijddVaItVeqgcVZ+LUtUng4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9837

On Tue, Jul 08, 2025 at 09:03:12AM +0300, Gal Pressman wrote:
> On 08/07/2025 5:27, Junxian Huang wrote:
> > Could you change hns part as below? We have an error counter in the err_out label.
> 
> Same for EFA.

Yuk, why?

If we want to count system call failures it should not be done in
drivers.

Jason

