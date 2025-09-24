Return-Path: <linux-rdma+bounces-13621-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D112DB9A212
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 15:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8752919C821B
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 13:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD22304BDD;
	Wed, 24 Sep 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zq/D0avJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EE13043CA
	for <linux-rdma@vger.kernel.org>; Wed, 24 Sep 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722204; cv=fail; b=P2uwS34j+S7dFXOZc/SbrF0FX/O04kPpd58O3VMzcgceIiJdPQIKjPI1EaYSX3b85pCRCiIC21nBjR2HIOLHluT2qO2pZOVc0n2BsutpNyORQGiSXbSGgUnzmck522RHWywrcwTz9gJ3OP76N/2bpd9EgKDR6aSYJR/okk1Cqng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722204; c=relaxed/simple;
	bh=Amq8KNRhmDebZCgdRB5r25E5lTVJHsOfO/5szW2xZNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lqhnarS7NJE8OcNfuY5Yyxi/72wdP1uFxoncpqWmc4clWr6fm4MdNcp0L2s6c0U2F6Xjl93Hg38ynFhBQJKO5YlBAJNOaoMtuuVHVAHv3VmTOHmZDc6dbIrjlVpn1pzp3aQEwl5Mzn94N0F/IyM5UXVm9oU18O55/zexch4KVeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zq/D0avJ; arc=fail smtp.client-ip=40.107.208.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uzpgz7KgvTJqjPAJHJOyM5A7zu2J8rCM7/llGyMXbZbAHExPoiZNig8lzfOvaOWoSw8I59AS9+HgXaoZ8TpQk6dWgUv+y7gABeyBjv9EBaT24sq5vSf8vVQSybXzmlqUvEQAW26r9Ec4Hje+QFz/Of1RG1ySEEnTErbJB7UHJUuxBzJC0qp6UyduELa5tmmc8SLQ7sjeChpiL89jSsmruzEE0P4ajNe8uTGOQvA9Jru5uVGO3sWheCJiPhThISlqAWZv+UlFb5hjIh9mA33x662GRqxd5MhfXV+Liyq7CxadTnvuJBRLga4iLy5sKncMKft/elyqyq9e3hcsgWikAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHUSra0ydOjY42wmVEj4/M78MpXloyU8RwkkUxFOvjM=;
 b=y1O7LnenQxq/K10K7Jex1+7GWzTdukxROswwPNio3PNNnYjxUW8qY2pNnnk/nFB5jNFkfxv8XQMkAIHZcAhN2zP7orvHhCYyOxRYhe+SUBuj7ofN2820uQCZ/AExmOZRGZFQlgPIw2DSXZIKLo98m51xv9Jltd5yay2FTBoZHf4q1c53QU/KpCc/m5dV8dF7o5TGJuTc3le8LuPVVW8VDk4WLc6eu5XN1jpzfMzBzPG3eVSesX+ZrXmseEmV079hwLAdTlylUbaU5OPqphvoT5yP5+o0st5aX+1/txHvcpt29CPRSk/AMQc04EmKxfJ3ovB+hRMAs81HohWTtCKCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHUSra0ydOjY42wmVEj4/M78MpXloyU8RwkkUxFOvjM=;
 b=Zq/D0avJpf1l0Z2AYIdKQ6du28AAiJCTVPw+25tSQNX87ahsb9vRW11YtuuDkSHz8EpKj9vYNW7hfeh3xaIC3OPdAu4l8Lgi5U3LLK7oQ+il/M61ii1OyYrnduCRC3QgvMGorsAKImCuwJRhkYLivj0YMrVkUpKAPvbu8BP75D9vqs6KVrqVaRb7A6bN6qqRnRkJgYfmBIh5S8lHz+tpBdzLnWkX9aUfpu/EZEiwghfRWoIud+cSH4Dr322b3euVm4Zf/stIP1n8MnV0FZvUBSUZZZKa9J6oOxgq6VzhL7YYdKJz7gOnGzm2esFMdM1paeMowNQ+6K+Pg7RGczqaiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB7891.namprd12.prod.outlook.com (2603:10b6:510:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 13:56:39 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.021; Wed, 24 Sep 2025
 13:56:39 +0000
Date: Wed, 24 Sep 2025 10:56:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Moroni <jmoroni@google.com>
Cc: mustafa.ismail@intel.com, tatyana.e.nikolova@intel.com, leon@kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/irdma: Remove unused struct irdma_cq
 fields
Message-ID: <20250924135638.GB2674496@nvidia.com>
References: <20250923142128.943240-1-jmoroni@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923142128.943240-1-jmoroni@google.com>
X-ClientProxiedBy: BL1PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::19) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: cb339fb8-9e22-4345-a6cc-08ddfb722f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6tCBpI/iIlgyEgG+CLkrDiPOggfkCk7TkZWBAF+ABTvFzFWYD4zs9lhMMpP3?=
 =?us-ascii?Q?8XvPx0RBMo4jwKPC/cXSQwjnu2J2UlwAO2NglZWX358B5Vh7pqVB7i9gtgDW?=
 =?us-ascii?Q?/kk45QcSJaUhbub1q3mzdd0Vwf8H8MzIZ1AHgeGk0GJCqCZN+sqe5kLvsmdW?=
 =?us-ascii?Q?m8I7Xkt9V3hM9+d8fuC9O9G+cesxHgEggiF8+su9d0MmaWvlam3HK+F9ZGnJ?=
 =?us-ascii?Q?gxf1MnwT4K/hgxO04DoVZGDFd6Q91gvzYy/bDD24uVi9o8kCwdytqF3VzBRL?=
 =?us-ascii?Q?OM10riO7yTYgpfIgxSDice72JodsUYXfZ5Fq9rQwaxwMrHrsk8GVhL/BQMnK?=
 =?us-ascii?Q?YPsBKmPoqz8x1c2/B00NMv/qMAd00g3dHRPccikv5ZiycZ6gQGRFnViVlipA?=
 =?us-ascii?Q?/mzf5543dHcGtXdPxgaYH/CxOlypgRAVc5H3iW5uZIz+60fVYdTzawT4u1rM?=
 =?us-ascii?Q?fQMLFGxltlRAqOcp6sCw2DMv49DReZOwd7k/PLQLRxHfifQhu4fob0Q6YNVo?=
 =?us-ascii?Q?miZCT7NU5mKQT5xsAfz+7cqoVnbBxwwUxKYs7NLeHlu80qvL8Y34Ww8mYarD?=
 =?us-ascii?Q?l3R1lcc6TtbIFsHYKdjMKavKtWEbAHCS5iZ+q/9lGWYpMpioSfeKdEBYbDl0?=
 =?us-ascii?Q?9vZ/IUOeLdacf7FmwcxLxvTMAxOB1U8NWjaF9oH2EIrizm33gR3HQgCMN76/?=
 =?us-ascii?Q?OeCRhtOidctHQMWaZus16bPVcTh+xpBnP5Ac+Um/DzRSU+yLUNTwAYFgKARF?=
 =?us-ascii?Q?sEPlUwBj/yJlia3WoEUVtCZ+euoMt6b4Gn2dzQM3+/IjkxnTdijK4UGz6ZU0?=
 =?us-ascii?Q?tj3zsUGgetYut5X0jce7MkmgA0pxlEUxPIjzihqdjNYoQvhCeKpA9+SmG2GN?=
 =?us-ascii?Q?KDpba+MRIQvwiqcNrkKsLrZwAG5Ycf4a7451prz4csuEtryFxaNjM7VWhD+T?=
 =?us-ascii?Q?/HHrO2AiqGTWziK4lHiOutNpSkQAPZSHaQwfkqjV2tWYMFejKvRtedk11Y0O?=
 =?us-ascii?Q?99ZXhGE882yLvbckAKNsHTBJN/ZyCDGJ027NzFt8mJZb90yA1kEaHJvfTWfB?=
 =?us-ascii?Q?JBtCIiVx62j/QCGZB+96gERRz+e63PeVqxiT+ydo+j7AD7fW82hbtGTy2uYR?=
 =?us-ascii?Q?6aJW2h1vZqacNDdjEXznm+JqiCLuVRDxeI9jl/pt4nNafOAvjDsdSVjrhXPw?=
 =?us-ascii?Q?7PWb+LJAo0FssTE9e2LGnBQ66JxCg8qB4AsFii8PX/1QpHQdCUSc+JdTGtaa?=
 =?us-ascii?Q?frEf+0BYmgMtx/IB9XAzgdOukoMOp8VR5Q6Pve443aLuR55ae3ID1hphBIDK?=
 =?us-ascii?Q?tPQSihPviTgwGn3JrA3goSaZOXpXVx6ND6MsIwt/AsxoKqeVZkoBH+MBTf+W?=
 =?us-ascii?Q?AY00NvW/CZb/MiSh41W/QwjI32nz8Hh2I8F4hpK2G/jzA5VbPcccy5HGk3u4?=
 =?us-ascii?Q?N/r2yLI+ouE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0PWBSOTnlPajmWQDhNqBXcTvJ25lztgsJoJafY9ixdN2toW7EG3vN3YH4mqk?=
 =?us-ascii?Q?yxjg/0GMRv2Cd27aM6CcvB02zPFI25cV3oCBSHXaL42RdrefsQEmWbQeuPLI?=
 =?us-ascii?Q?JbU5S5mppirFIgMsk11Q/ewq9j9VYlAZ/1OUIof5d/n7MHskJ6onI/BH08TM?=
 =?us-ascii?Q?KZcqTTi8To37hhtZ9kUvLG22JeFcCzrj3qFWB7JqJxHvSRIpA2dERamtDody?=
 =?us-ascii?Q?L5JFigq2bc2QgWlVrXUUgIqrtx3ZX8syol721+SZYUp0aumY7jEDC5k4pGkp?=
 =?us-ascii?Q?33VarApQtNoXJDzCJUCVzYlG07rtYw31L7WR2gtNICf6E8+oFY93I3jYEiE9?=
 =?us-ascii?Q?CdTIRnayNJyk+uBs4M4+X9u7wgdNa7qwQyGxroFXEsaLNu5/HnvGyLa/E/cd?=
 =?us-ascii?Q?5iiNIpveteinh3Ris0by4xFARZjTMblNW156e3fzAOMuHRuexP7WZLzOTX7c?=
 =?us-ascii?Q?GH+Wy/VcewI1K7n5TYVB6mAkU17OHDrU2EQx0rV6q2NfuiPbvLasLIGPnEoR?=
 =?us-ascii?Q?6gOCXKsOrU43lsK8nghGQqj9KwtKAPDiLAEe/aNywTMw184t2dJN6Ay14h0m?=
 =?us-ascii?Q?U6W7qXrep1l17XRZKOnFnV/Niv8qrCShg7vrFUdxGD4DrtfrpW4219/AlswJ?=
 =?us-ascii?Q?EyvBtgXYmsiO+Yx7u5GRvm2tw7RnZgmzrNwYqdlRPXmD6U0O8opsLVyp7Ijy?=
 =?us-ascii?Q?c5ANAhK0KGYBmH8cUzBZ4BNitJGhV2h2yHnwmuPUvDQJQg/7Wu4BobcgfrlY?=
 =?us-ascii?Q?vaJ9tad8x8pLh80dQ5vmRQAm56j4urgFUdjVIRYXeDyR+fmlUEGQEXJigwoC?=
 =?us-ascii?Q?37ffBq9U3fNGtbZ++xpO/1pX/m/clzwq8dX+VAKmOP4eWoTH/8+Paou5MHNG?=
 =?us-ascii?Q?VfIZodzjOBROnTh4N6U+TA4D+JxKK+3lDmgomfDVAe89GXy0GU9RaT6vM1/s?=
 =?us-ascii?Q?0X65ol8SIFyG7QN4xIfIJ9j7H51smwUa2A/VdmgAQv2KCSzQs025D/9XpDV8?=
 =?us-ascii?Q?PKs9d6gP1iOLH096Itx3bsfk4Xo65lbikD0wJNGmdlH3miNcf+7r5csTsY6+?=
 =?us-ascii?Q?WwDJmPV8wnyiIMaH7OfSJLIH9nNjJHfGfbz/P2RTzW5iMCz+cTA2ozDjcLCF?=
 =?us-ascii?Q?E9CEkKta/zZ09VKWyDWZiGg2IaejUDU9NS5hcOIaxj2TSYiUTnzhD+KxKPPS?=
 =?us-ascii?Q?Arj+pvWONE/WrqVRFRcKFGuvEgIwSyuU687owTZeQYeDOpFWbtMONrihm+Zk?=
 =?us-ascii?Q?mOTYOnq0XcTqJ/oVCT71xg4zN9oiItEhFhtq/mhNefBisIdoX5bbFE41KSi8?=
 =?us-ascii?Q?AalTeN+s2kjznk4Uet1rLBhyMdKBHyGUtkotzlTLN5ytrP7X4uVD9pl4jOCd?=
 =?us-ascii?Q?pI7W/hr3xKi7+hOB/lz6S+8kqveWjcIcu+HJp8D2p9BRhPna6G3ShdpiIFEk?=
 =?us-ascii?Q?AFESTGxptRQilNf2ZrjHCQf4jx87cIracp0NthIOZE6MrWWo26C3piW8eknx?=
 =?us-ascii?Q?1pnSGyb6Vvutkgy/PjsE4VyNlfdDe9eKzbPskqvafvDJIYR1AIizSixVMTjm?=
 =?us-ascii?Q?AAKzun2y46OetS7yqkVtCaxpIEwIxzB+eQY9aOXd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb339fb8-9e22-4345-a6cc-08ddfb722f58
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 13:56:39.7153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHf9MIbGDG6DeW6pn/IBCXDaPjxwCRjvuDcLhlnILwaPAN6FIq3v3sqH2UYhRcrh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7891

On Tue, Sep 23, 2025 at 02:21:28PM +0000, Jacob Moroni wrote:
> These fields were set but not used anywhere, so remove them.
> 
> Signed-off-by: Jacob Moroni <jmoroni@google.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 3 ---
>  drivers/infiniband/hw/irdma/verbs.h | 6 ------
>  2 files changed, 9 deletions(-)

Applied to for-next, thanks

Jason

