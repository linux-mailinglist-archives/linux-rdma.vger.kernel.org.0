Return-Path: <linux-rdma+bounces-4522-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0338095D03C
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 16:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F27283509
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 14:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15256188588;
	Fri, 23 Aug 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X/C9rytk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E61018455B;
	Fri, 23 Aug 2024 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424251; cv=fail; b=UpW0M/ij0v0aOKrhOBbXpnDKGn5PHdHZD3UNYk1N8lEQNC0kSp8vc2w8t8On7f6+6XIsqglx6vCjQDxaTbJk2NPSjbYta4zkIrlLKhetGmiUxtLvvI4LEzVmHn8s3RlcjOl4kil+arBBs3d1UJgDiEmB/KfZiOboygnaTionLq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424251; c=relaxed/simple;
	bh=M+QHarBE/UVUyZuvFHB94BQNhrOBfWH0atzPa2VEx30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XMIIVKtQwkMjPW7e1VHg9BJqdbcRDZCUEDHghmiIZKmA5dcEdqO0PwJiSUXKSTo9vSM8cvT8EQh3sMlYVSZJysGY01CZjQ3K6kbGN8rIKA6MacosY4BuGXuu1bgaCcRA+I6dVSGR0U+qk3czcz41BPZFzHjNYOibpoJsV+Q/ZnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X/C9rytk; arc=fail smtp.client-ip=40.107.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTAjtRcpni/XUXKpiYEPxy1Pz78GRKP+2lfm7MoAt4kZsWj+YPewCaxIZCnrqof2vmHpKqhWzBZAwGwj+LDaZiTMWBzc+r6LC1wsHM5VvzHe3qTc/bLLEVdD/EteIwpTD2fUt70mBARam5DsgpchCe8SFA1hQS6jKw/ewROH7Ty4Jzf1oFMwzD6NisNk452GFYtbrbDe0B2t2z6Y8dDSmrAXXBXLZgL1rH28s4frtlUtWCxNLnUjxnCxbUCXyVHjpND6Bm2Dvkk4aWG8NRkat7QGy0VlqyYYrCY4mhNe+MHvD1neKB09krLnwEy7wxMro7isvL8x/FCTCTJ/F6r33g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJqSgesNpqTCuDJhldqaRE7JdudldCdmcmXo18x2h0Y=;
 b=dooiJAplfc5mWjMZGu5K9ulQr62EgWIJFmHBuEXswvDYVpJt7AqjsEKHbAnBb3MWMyK2UGDcCuPBc0gP0bILwEkmZUGlggBqPeJVX9oCmHzxHU6/A0/iHcMFSZLzsHE3Ns1qw/pz8sR55n6MYzbEts8o9zuU1PBfN85swGE/TeCPKH3RYLcvO0fZnIXmGjopuLgrBYpHGV9ufM4Sime/ptcLYs3e+vF/JF/kBkyagWHT0tNqeD/v4whVHgBGBoymVX0gAjTsO78n2ZFmox74cdjoIUKGS9mDHfRWEm2YBZiS4rVUxD7Lq8v5WWj4ra+r3+/8VHTAX6HUGEwDeX3V6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJqSgesNpqTCuDJhldqaRE7JdudldCdmcmXo18x2h0Y=;
 b=X/C9rytkkL1YtzZf9dVfvf8CvWZQWDAQn9d8uY8jbgSeClC5avy6FzCM6EuCpLUnqXxBF+C0HbOR0kukiiW1nXPtLCHpZZw5fRNcWYixblYt/fHNntGVUUSqwr/SGkEHQI7qioMH7xnlG3g/xRK3AyZ1oT3Pbx82MNXdU+AZkqRDu7Rk05FsuyNVMRDgn5CRJJviKZOdDbJKJaQt7kHRezSZXEjjTwqj8SfygzLzUFamsK8DNPHIXpVmOwS+b3ZqqhKkC/bKYBuusD7mpVKsX3mnkVx/twjN5zq5OtHW3I5nyKiG8BUWmHnlZJlxrrwVxiQlW8XYMTh4uZyHwgeq/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 14:44:06 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 14:44:06 +0000
Date: Fri, 23 Aug 2024 11:44:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	zyjzyj2000@gmail.com, leonro@nvidia.com
Subject: Re: [PATCH 0/3] RDMA/rxe misc fixes
Message-ID: <20240823144405.GA2293859@nvidia.com>
References: <20240822065223.1117056-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822065223.1117056-1-pizhenwei@bytedance.com>
X-ClientProxiedBy: BN9PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:408:fb::30) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: d7151de6-b689-4c30-a191-08dcc3820a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fhvUbM4n6y32LfAvoLq/aUCgl3bIkucser339UuMFMEdSr439+RK8RB0BmW/?=
 =?us-ascii?Q?IXmEeXfpsXH6qB6selAtY7VLpFSUjAMr7QcAUmcxAblR6mev42zVN6h34X8B?=
 =?us-ascii?Q?OUv2WMKfFi5SPcgavJQZV2QpGw9IabFg3WC7I9PuI30L/ODwk2ZofWiPUGDH?=
 =?us-ascii?Q?fgbF9JEFOxeR7gwS0aN53+GtNzUtBn+w7C0onwHZ11TuBjOxpIy8rHePFNTJ?=
 =?us-ascii?Q?482fYa6uvD9uiko5RkCm9dOqUQtxwdsg+EB5qdxU3Sxh4NvO0ySOm+hRzR03?=
 =?us-ascii?Q?V+dUePfacfpvDF5+yXWAK4QLeoBZ0/33BkEKNLU3mfQi2tuMxn8w1Q5vI8Gu?=
 =?us-ascii?Q?0ivlFwHlr/kiw6o6Hk1L5eU3ZvV0TRKpc5ydOFwvngvogMKwYz48RAUcF/p1?=
 =?us-ascii?Q?K4yMQ7UVJwAS+uxJ0YJ25/eWuyFeO5n+CitgMosdAWpbJELI0rfNqVq2NpGP?=
 =?us-ascii?Q?R5FC30DMxbsl72aGOsb1pGYlGMmR/1zNFlY6H7CAad5qOZudmGoU1amdc0bl?=
 =?us-ascii?Q?SZIW6gEBsLUEFkJfxqvO9up3C6qNCXWJfr4axQzU0hLtnCoTgla6vntFbnpU?=
 =?us-ascii?Q?D4wZ1DDXpVLvYME0y+P4CaUSP7eOSNSF67vaQJMBuFkey8kgwfhifws6W+3A?=
 =?us-ascii?Q?8KMv720VWh2vqjCmyKqBus6JUMNuaGiUMJdE/V9ox0EuPfpuHrGPUTvXNS3P?=
 =?us-ascii?Q?MS/pd5GOGF3FVe4ZCn0ywVtOCwNjUusVQ9ELnMMo28m6gT+FHcBtj7vrPKAW?=
 =?us-ascii?Q?5jgna8dBVqw856gf6cQpfShOHo05Ht9X5cNnRhy3tTU473Hbu66fM/+H0LQz?=
 =?us-ascii?Q?COai/NTjx7qVepLncEZ5JmB3zjpp/9XdmFOIW/w/Wen8HlRSGOxSPb4Vt8qy?=
 =?us-ascii?Q?mBuNU3sMkL7u+aYYWTW2dMzpx79Rmjh5aWysLnRO0JPqAbgYut2hXjwClE2h?=
 =?us-ascii?Q?k9Fano+vglwG0gCRQRU6BEPqLoGBlIJckts+qLivwMSNPDK20qDAsLTPEZlz?=
 =?us-ascii?Q?gUeCrdFGqhUqOb3+keqcVm7Ngyqsn+Yv6LCDK8q2Hx82QCP+OyrYjL0JjBO7?=
 =?us-ascii?Q?1GT48RkDJLB52kRBdF/FjAEnzB24/z6G+5nYMgohg8ldowBZz6MN14/vC/Gv?=
 =?us-ascii?Q?yIS7p0SSQftk94GQQ2A2yGsWmzyD7NCeytEjLCHx2dAzKp8qa7D/3fj3T3yq?=
 =?us-ascii?Q?PPrd0QCEXp6TNRIQvGbk+z+Uwcs7Kv5loFz+3bEngm5tcoFNecOZQuJ6qOup?=
 =?us-ascii?Q?v3tPmk9r6nr0SRH2kvvr6y7UxNXeObCLrVTC0w3oooKhoJwTNBEFx5Ki1Rnl?=
 =?us-ascii?Q?krUwN2igB94r9hzJhTwONW8CItiwC2v/KCZvAs5vN8250g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nS+Y8hXeCnRM4QiViM+K2Y+2vwU/QR+Ewasul4phhNThXfS6IwNQAxH/D8i2?=
 =?us-ascii?Q?QsfJ+/X9E3bq7nZGZaNK5ri7Y+2Ns4NJorXAoZoeNOqGgd0GO5187GE3NIKX?=
 =?us-ascii?Q?ozarvNQiRD2LsAFDT6l5bhgnz6SITqC9suGSOKyXF/iEcQTRsx4Ed968fb0F?=
 =?us-ascii?Q?OGCMES+42D072CaTqv573eMh4dRRXrvx622NsDNMWklOQQNxJHGwvCYZw72F?=
 =?us-ascii?Q?PGXbYiVEWpDn8fSb9//UyLuPwe265f2S9jrTyH7qhjXL50TFE01IwDhz/IJN?=
 =?us-ascii?Q?xScsM8DKrOFhsGz/L1vgwPkKctUc3iIMys7K5bhP81Q5wdWprMDNa+O4qV8L?=
 =?us-ascii?Q?5NxddkSTHtCNpz8b5Rdv5RBBAH1cjjgLetMDo3P2DBBAuK0kbN7nd/wDYJe6?=
 =?us-ascii?Q?0Dk3lbtZo1sqxtGfI/gKiPSZElZXau5vGg7HWaWNqMnGoH1xRxqNrA8m09gw?=
 =?us-ascii?Q?cbk/e7xonnzZXzvqK+I2hiIcE9wfZycWuJsZwKBB3A+5H8q1xT37rQ62d/bA?=
 =?us-ascii?Q?9yXdxAkzlgN98al3YU/D+c5dLAWRAM2ZoOBAwuFeFHahJxIZwK19owpe+KHf?=
 =?us-ascii?Q?vS8fAgDOwlpDuVdRWoJw6pGnJMFMOW1PIP6WC+YhMaDU7kZLpo31FsRcUgrf?=
 =?us-ascii?Q?Puh9H2PqiVnbEiS9qkswsevh4wLZid2ZSI7r92rI8DYN5se6ECzq+8oT7n2u?=
 =?us-ascii?Q?XzqZBgImdz9DrbmJhIzdkzzhVU7G5qjlyrb+sY5o/LumHPt3ecNfhgPwmpx7?=
 =?us-ascii?Q?T4UjEtwD1X/X3wMT7Jf/hutr8ogLm5q0aSvBiWNPq8X0YmHDcASliqRrxcpE?=
 =?us-ascii?Q?YWHChtGNfRPU6OU70khQny5fmHhGlMflntRklSeLyWieMhf8jHZ0X3jKonaI?=
 =?us-ascii?Q?T6+17H1/kGceYPgrkKti6Bl2aP0sIyAS35kvS9cvriDxQZawkdktEwzyPsuJ?=
 =?us-ascii?Q?tkpt7NjyAK3BSAyA5RbuFbDxdwWTcWLmhIO21TiZwkrIX1rYnJYdhJvaJyDZ?=
 =?us-ascii?Q?tn8I0HgldTDBvugbEipbxgxoJNHV/V1Ta0K1Kxs7/03UzEq6+IcXxmnr8zA7?=
 =?us-ascii?Q?p3Yd94QXFmE2vEHl1Yp8E/iuQV6DG/+iJmxl15ulXcqz19lh8uUeXAjlfiWS?=
 =?us-ascii?Q?hRXbXD8GoUEb45A7dq0A6nTZIOE/6Y5Ppu+NNstV/SLanqLZVEgWDekPzbSm?=
 =?us-ascii?Q?pNIkXvxWQhFuZsms/HjcbmC99QrghWoInVtROFbRisXojCFEFUgovbdhEpyN?=
 =?us-ascii?Q?szidM/QQd/s2ieQ98pSqaNqz7NJa0dRWITw0zw++tmblm9uaRZWXqy+Z3cwt?=
 =?us-ascii?Q?XHsG3ViXYX7xQ+z9nIzXlAKZQAfLTK80UD5mCDt2vHHZeMBYAtDhuYjy/RxY?=
 =?us-ascii?Q?m+R4zUGMWkZteGwW4dZeNyHaw8RXc/j/aVaA97ZPf2ohKUpc3ONC3h0Dm75a?=
 =?us-ascii?Q?s/ETkZzpDjRY86r/K+Dfh9iwWQUrlwNgQNKZ5E4LGLZ02KRo//7WREXNA5Rx?=
 =?us-ascii?Q?kMmNNbC7aZPXGNjfIphbo8yi/y44QpnKB2OC3q7MgL+fuHHtgdOaqte+k+Gl?=
 =?us-ascii?Q?UyWCD+KRuDmr08NuvC0NpBaXmYGmoR2InR9Or5Yg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7151de6-b689-4c30-a191-08dcc3820a35
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:44:06.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTIBr3MTT5NR+++HtBhv6eq90/9HJTVmmyrxwWp7G3lYmonkNJClaogsg/JU4cYg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664

On Thu, Aug 22, 2024 at 02:52:20PM +0800, zhenwei pi wrote:
> Hi,
> 
> Please review these minor fixes of RXE. Thanks!
> 
> zhenwei pi (3):
>   RDMA/rxe: Use sizeof instead of hard code number
>   RDMA/rxe: Typo fix
>   RDMA/rxe: Fix __bth_set_resv6a

Applied to for-next, thanks

Jason

