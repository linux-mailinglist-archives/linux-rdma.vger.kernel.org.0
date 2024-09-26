Return-Path: <linux-rdma+bounces-5115-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A136987606
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 16:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F6F1F23423
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 14:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B5149E16;
	Thu, 26 Sep 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qyRAbiDa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF101494AC
	for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362469; cv=fail; b=F4HFuIgdW8WjLqLuNinnnMGRxGpSz8NcovK5/3mvqIA50mhJdU3EMacLo9T2ra8GCi08ipiXJNaz5dsgvkfB2jDzIGQhqtJw3CKzaIzicEVyfvGYaC8l9CGLJq/MZZ/oDyI81ckGUvjFCq7EzJRthGvMMV9/1FCE7d6cbJsw2cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362469; c=relaxed/simple;
	bh=MmGgCwFt+SX82coJm6e9f3hzLaJs3plosUgO45zPN7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dWuDme5ZildsJo//wqi2zhSBhn5N7acdfSnFgvyjeiXaWHMpt2JdwUpY96SlgcczwvcC/ChTKd/6ttyPS5BkDLYDC3XAvfuvuBdzzlbldGjZ0Tdpt0SVk2Txmw9wqp+nPgSReh8bPOFuJ1xo6iq/GiznmlRLOJad8IJ5dI0u50Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qyRAbiDa; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqUaF9jTt7R2hNtV/meOOTC0f22vxBe1RI9UMAC07c2ZMjWuTPADVXBlfN4IvDFh1LYgzqz0k+7gQQUYMGEys0jpuZu3ACX55aO0RLSi5/sskhrcNqFROR2KHMxzc68pRxKsyXqsMtS79p6CBNP9YDpBqONPtLaK/K/3FKhPKH2Ij0Df6+A8hHv6Gj//bob/6BEjBAXTwVioRItndHp4TnPgIWNKZ+N9h30r8F4ESrrmBasBCnYwPhWUn1zcmT62VQdykUGV8ETFf5Dm4h0aCR4NkvUcBEE8tUV4Minn3A4xmld7DTqkNuw9u+EdlncIKOdQ/RBWzXNi8xcrSN3puA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmGgCwFt+SX82coJm6e9f3hzLaJs3plosUgO45zPN7Y=;
 b=rxMenYFCYRmbBSfP2SILLwuRYJCPDXvnzEIFy50Zya8N4VY8LmSd06EsqRY7vio9zJ6L6zeMh/UyUViBx8TpVR4VML4Xb1qb9ohrPYmeQqi19G9V0fAg6evVYaAsLGaRdKmn93OWRKGl+J3M3yIFQgHLSpHiJIt8sjhQao8phAJcE22re8BAm48sLGbEbaCp8dIN3AgcIMN7rbxpDun7eUdNnEA9SQRqKfv0A+z+pDOyJT1sS6EAZd75t0/iKMkgomm+XHd2ShaHSituKc6A6AE3hY8oBDb91f+4W3oiprctGRAhRSV2RTP1J52S32MBhn30DQmUvxQxlJF2toQXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmGgCwFt+SX82coJm6e9f3hzLaJs3plosUgO45zPN7Y=;
 b=qyRAbiDaYwnsLUSedXqkjZmuxvu1kDmGleh3RQ8fXt7UfsOW20AOpONDu1kHvfTV8ko6hzDsMhaB73e6Fqda2vL0e6LrjsUuUkHZPP9Wge09Uf9xkgpLOA+4K0hAcb0gMz5Ln+r4BklKSB8AWcHSSM4IxpBtxnDCmx4yGScYgRdwDAcMDVER7VoVh275jkuDlgidetQBcnCdj/2Ov/fCjGHIfiNrcKxKbp+CJcr/ET51xw8hTRUThWgDq+K61zGfT0VRGPhTyqQUn6Y4T9SGfOiew0dtYxzvSXP9wWlfUaTHG/gsVV8zj4B86Mxnrdl3laPuOD0huXGinWuE0b8dqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Thu, 26 Sep
 2024 14:54:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 14:54:24 +0000
Date: Thu, 26 Sep 2024 11:54:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	kernel test robot <lkp@intel.com>,
	Yehuda Yitschak <yehuday@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH] RDMA/efa: Fix node guid compiler warning
Message-ID: <20240926145423.GB9417@nvidia.com>
References: <20240924121603.16006-1-mrgolin@amazon.com>
 <20240924180030.GM9417@nvidia.com>
 <7aa4bf5b-17aa-474a-b6c5-c4b0600f30a3@amazon.com>
 <0aa53dd7-7650-4d53-b942-00903e41dd9e@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aa53dd7-7650-4d53-b942-00903e41dd9e@amazon.com>
X-ClientProxiedBy: BN1PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:408:e0::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 31355e9c-3b4a-4f24-8649-08dcde3b1c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e9Cjv4gh6TVc5NJquvdndzVExFZ1ZHVr0w1PxGau73zQ8Jb/GromSHC1iUor?=
 =?us-ascii?Q?HCyGpSmbZhSA4+7cgzBbkZcvC+kpoDncrac9MxbmtXDCoZ1LVzmocd4O+ufg?=
 =?us-ascii?Q?Ocxs+3AX4bdOEjM4bFLJc5mm+0ANsPPRNRruCJLd8SYCkYfxZqTv8ZN0VhUr?=
 =?us-ascii?Q?E+8IjYl9T8l8yU8rWBrStz86+ZS4LvQQchpXwF3FD/Qg1xAqkUoFSgae6vC+?=
 =?us-ascii?Q?ynY/8L0iMi2zfwT2NldE+5L/7Z4XOLePFqy3WE/2y1qwpz/mc71BH6ZpfZua?=
 =?us-ascii?Q?wyan9+lM/iNulQrwXNKPFKo36T4SxwC7DRGP42yGgFZRmpE1MaHYTNzyKIxn?=
 =?us-ascii?Q?mbvfpA8UsKnvMXXkBwTZTyih00Q3Fab1IxTRUsKj0X4Nizhxuu2HmuHAzA5B?=
 =?us-ascii?Q?OAM84EQf9XUk8I6lab7W/dKcrJfRUO5HkNK6k8S6rU7ISxb80ECbDQkcAtpd?=
 =?us-ascii?Q?4CpIyZstPImyYSrS5nCEHhW8XpnUom/fWtwLu2haJWpJyLRnp7Uhp6sEjyNi?=
 =?us-ascii?Q?e/5PTqzFvrrrctVSWy0GC4RiUsTV9I/UPihP4qPAlSdaVF3JjuhyC1CXhEda?=
 =?us-ascii?Q?Mbr7ziC3MJicVES7CHuX/kmRbd/ndXpdDhG9BzL9q6rtEpnsfdMyIeagJPIW?=
 =?us-ascii?Q?GoVqZeC8YqGGYdzllKAVAoR8BwBRGtghbLrmm3hX9YkSgJF8dDRTUPfhuN62?=
 =?us-ascii?Q?DXcnuCD+01IBkY7DHzq9BHMdidjOpBa/FeEnZXclIp+L4AVQb5e1P0+JzA5K?=
 =?us-ascii?Q?dFhvd0Y5Q4pzha3mwT4bcdHsc35INPHimbObeqcbqirt3ymL6MotWiyI1Fco?=
 =?us-ascii?Q?FLtRBaSo2QpdBtVCa9Wdd5Fex0Z/SxEkPqcPxPZuOUmHk5sH1FCdD6vbt8+i?=
 =?us-ascii?Q?zD3nuxjtE41fdqTkijJO2El3ym7jXRuT3rq6GCBJ//kHyPeO1klpusXAiV2h?=
 =?us-ascii?Q?dPOtxIMo70iFNPbjRc8DfIbS0uOC5u2Ng4BPzVyRhcUlgj3NuWFfWIVN2hOp?=
 =?us-ascii?Q?vRRqeJeVO8Q+UzqokxC22lGP3vMb3+tYz3FYYI3cJCMJbXjVcY7+LJ8V0s7J?=
 =?us-ascii?Q?y7ffoIeGUyS4B0XTXrCAhffxReJZPBa83d4WpYLX02Ie4tt2DS1bYt7ii8EJ?=
 =?us-ascii?Q?CJnq9XMGJTQiBmudhZTg7xVIE5vfuEudcbyFQq7L8nxU5OpOBL1VHHLNcFkL?=
 =?us-ascii?Q?ryyBNZbfQh9QRANYy/SzqaIu65Fqb/PpqBCTdTk0uQaa8rDlKuN/kaJ8q8pG?=
 =?us-ascii?Q?ahdNs/Xj6uNJzt/102ENchBHUQ+J+7w6XoZd2/yg3AF8Tww/LRtT5cOIluVY?=
 =?us-ascii?Q?vBKmZLqYSxfqsaJXgXoghESF9t34b24aR94c6bsMfs4h+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RcnWHtB3cSyGB7Nte+xALFPxhhe1mwMBU5P8HiPfh5GCF8XTn4F2qjtmUQaZ?=
 =?us-ascii?Q?8IlcN1usZD0e2EKGlZ+LUK0WhCan67Fs20dL8uutlp2pk4Doe7ASwxq6QuXb?=
 =?us-ascii?Q?ImcN4KP4q7NbQC49XAxamAgDbChb4w2erHPc7od/oFoIl6l8bJ88bqhoyuUs?=
 =?us-ascii?Q?Cy4HHBS8FDrMs4ASkVWGbSOXv8GxgYeS1TCSRSVIOpBPLO842vM5hcT/p5uh?=
 =?us-ascii?Q?FWOkKgo0ngPEkErYSaQRn0CfaL8jhkQpgGdtwxf4h3FUewcytPWsRQRlNVdx?=
 =?us-ascii?Q?vqlqK0TJOHxDlBwTbRdkmBhs/6qxa6NNwaFueIXw49wGYsuvg4cFirAOcAZz?=
 =?us-ascii?Q?fHgvqS4NSAawn9Dkg/eXCB+pfGv/pFD5DsFt1SBb0CKQwCUvA83j4K68WTKi?=
 =?us-ascii?Q?izecxccqO7vziNbTMWvmK37+fAOjasgzEMXO4DDeCKXtVeL4MYUb9DZut4Hj?=
 =?us-ascii?Q?JNrgYrzj+TDmLlT0oG/8Nf7P7/+ditn8qbgracKnB2t+XhmY82LYoyekQesI?=
 =?us-ascii?Q?ofq6LnqMGWxPFlVk8qkKOMX+YvJRkhdbU2bnbU99x5cCUYm9tv4czmZlxJ51?=
 =?us-ascii?Q?7HICU5II50Y6lDAoc2liAWjVeluF0m6TdytZFOhG08IKPr1AKlE7W5zsWtEz?=
 =?us-ascii?Q?BH3y6NI3Dle9UenPnTZUMeIUBvhk8aqKbeC1kFsRb8wwnbkJgB9c+8XhvPqG?=
 =?us-ascii?Q?32mITiO/oOxAJNdT8zutlBa2cIcew/4z6Xcg7my7+LXrkQ25PrtMn+FktT0+?=
 =?us-ascii?Q?cs4M9zhzLEaFwWgpytzhUg7mG6D/Al7zo+WQ6p71XN8Lk4M99C+WXNTej1at?=
 =?us-ascii?Q?cljkQ3dK4Eg2te8eLEO2YlQOEJQbus8IBrDR3u/M7LELAc3tt6Zqk3/vtVDw?=
 =?us-ascii?Q?gcV2oSKBv7XjO28bi7GZAq65DR5sn2EPWfDjTp24DRhOtFAfRIeXotybx6u2?=
 =?us-ascii?Q?YI+FFjm84RhdFAUgvJBuYJMBpfEbkGmCzfpQX5YyOVet/vxOjXQBy7WfetuO?=
 =?us-ascii?Q?5r+3AtPgacQyKy4wsPBZ2zOrJ9BshE87e14hZZPHMrSbfz883zhXfL0gjHLJ?=
 =?us-ascii?Q?6mLbHUv8E0Qid1T6Mj7esPZxPxhxRtp3/cqK+E8PcUxNr+LMSnh0M1zfooLS?=
 =?us-ascii?Q?db206aVBEAy2DrUIgyw9mvmL0261hJ5s08t5e3Y6Y+iWjjlq8WnilWp1k1Tw?=
 =?us-ascii?Q?PgoLJHsFWLmkVEZTbS2MKN2TTeJ9Tx/BO8VbyjoOubCe4ZhfWGCouD44Kp9W?=
 =?us-ascii?Q?K1H9JAKcGrjkR/VqT5LECjj1ivAUdst8g6Fl5+0tSGYIKHoWwwSfGw+jeFrK?=
 =?us-ascii?Q?zkkiOcvxdgMsJmxkAUcJyWiFLkSrPN1s4RKGuOiWPR/xljkr1A1leJXzmT3N?=
 =?us-ascii?Q?aflpzNztV49cY8T+SDbaio4zxo1cXhTo6G6xV4VHBqdiWP3IHSPm7rUxjqSX?=
 =?us-ascii?Q?+qRNIM4Dqrclw1/0skBbq7+B5hyNVjggSyRIV2Mza0ZSko2gjntlRzsft1xl?=
 =?us-ascii?Q?hTHf4N122YVdwb+cDRBM/vHb/iAbiEcUgCSVfk8J91YA9DWniZOjy9CjTlPx?=
 =?us-ascii?Q?bmpTo8kOg1Xg0Eh3zNc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31355e9c-3b4a-4f24-8649-08dcde3b1c67
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 14:54:24.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBiTNOOyGakxnz4an1Zst0DeRmOq/Mn14Plv/k+9KONh3DjpZrNjB7UEKT2y/tEw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139

On Thu, Sep 26, 2024 at 04:25:19PM +0300, Margolin, Michael wrote:

> Actually that's wrong, the device always sets guid in BE order so no
> swap is needed in the driver in any case.

They you just mark it as _be64 in the struct and there is no reason
for the __force ?

Jason


