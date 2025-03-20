Return-Path: <linux-rdma+bounces-8884-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05453A6AF00
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 21:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E85D7B1EC4
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 20:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E5D2288EA;
	Thu, 20 Mar 2025 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JLC6p9K4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EEB227B9C;
	Thu, 20 Mar 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742501526; cv=fail; b=kssHhdnLTNdtg7Jf399OX8rPh/Z7AT6Fy2IfQRd8ZAoxh0752WMWToLNIxth9TUqdULkPYeojRM+/Osavq23uuoR9pXC0cpmV32gkdEjnchJCU8GyTeVbuf106M0yOulptwLr4674/pAdJPoVLJKsmors7vnbO1xuMhxwaDaKLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742501526; c=relaxed/simple;
	bh=SPEzGUgST2DY2gdcU7aZr2Z2uEENZIINDel0wQNHkSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AqqyQBNpbsfXRIi7Bb47dmkAGTHDLOqof/mj6QCp8u1pZ2DaUviKQMJmVwyLSeHap5HXqjSAwdmlUdC+w0OUMWtfenFSLPRMkt5y+nHlac2W6Z7latNZkqY/4bbrhDAUkhSdg84l+rjVwOClS6Q2FpqfTIu7ZGCNRF07a7GJ9yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JLC6p9K4; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fekHXmYuyY22lFe6rjlra6CRhy21PDLSmL428sKbO31RFkIm7DreC/3ayKecDdVD5tdGIWlIempiD+L3pFOjmIAyi49YImOrsbtEXj8b6SszmHI3rle0S+5FTH3SaFO3D7t8nJzM2lrNZbcsAap8/eaJLj8UfGYE23/vubZX3cTZKeJidm5toq3RiujtZDvzB36PKYaWEUkFIdbGF7l0g+vjdDxPiLkT7Lm+DD2YbnNL9xiEzQPme3vSS/IaW8OSENkU8wdJbFvXiMeEYm0C7BTGNwVxNc8PwBbdss83ujMl1ceKukITpmve0VTMn05sWVIWpB2Fnv8TBKIA6j3huw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kO3vw0ofpciHAKADVdTzXWP7a4KrMKyM9uW6R2LhF5c=;
 b=sWCHuNqyTv6VpkLULxoRegyAYBg+s8SNv/zROD/sWkQQVWyanGreliNiw36pGJQehxett2OhY85t0SMJScj3ZQATvOwbzYABdJjLRLttz36fNEhseSj6N6SHKQDIooSy74ddp/LnTxqFkUD+GtG16GIYVW/yevIIIFClEAbEdTTS02Alku1IJj0zQXvDr4tnwqvsbPLj53Kh7YOJUkNrsxnhWmf5qud9sYc2TBF4c5qOZS+k+SZEEA9EwFvrAGRz5DmbW46SfyI4yLEwX/zU2f6v1QaN3bIAV1tvEowmoki5mX6u0ms81tL4SpMPzHTB9WtjBSgVSQCAPiEhWvzcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO3vw0ofpciHAKADVdTzXWP7a4KrMKyM9uW6R2LhF5c=;
 b=JLC6p9K4bb1TEez1qz9dCqy0pxNxcnxDmvYuAvyWhK1NcSHShTxV+5tvQaRF133nYV3YY7+7/PenyQHP+xO1S1+JMCN5/HUrpgEvGYHaYFCtCePBSgI5xA9DOGsLTaoWJ0f1DwZCQbkfI2L++88BclTSqvFEHDyqk5eEYzpSNDsHHbH4JaKi6m+4POL/vy1BILZv2BRqR8A6yzG0rGEytZ7BsuClFsFv8jrBeN4NNO9JrXmS0BbHUpkU+pAfb4Iw1tm7lO9/Da2Y9ZZB7mwKNjIWaiB25rMLduw3JsEF+A/yFH4ImQQm6Oej/VosIKkvQZN12rvRabkLlJfb4bIjeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 20:12:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 20:12:01 +0000
Date: Thu, 20 Mar 2025 17:12:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sean Hefty <shefty@nvidia.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>,
	Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
	"alex.badea@keysight.com" <alex.badea@keysight.com>,
	"eric.davis@broadcom.com" <eric.davis@broadcom.com>,
	"rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
	"roland@enfabrica.net" <roland@enfabrica.net>,
	"winston.liu@keysight.com" <winston.liu@keysight.com>,
	"dan.mihailescu@keysight.com" <dan.mihailescu@keysight.com>,
	"kheib@redhat.com" <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
	"davem@redhat.com" <davem@redhat.com>,
	"ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
	"andrew.tauferner@cornelisnetworks.com" <andrew.tauferner@cornelisnetworks.com>,
	"welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	huchunzhi <huchunzhi@huawei.com>,
	"jerry.lilijun@huawei.com" <jerry.lilijun@huawei.com>,
	"zhangkun09@huawei.com" <zhangkun09@huawei.com>,
	"wang.chihyung@huawei.com" <wang.chihyung@huawei.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <20250320201200.GL206770@nvidia.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <e798b650-dd61-4176-a7d6-b04c2e9ddd80@huawei.com>
 <20250320143253.GV9311@nvidia.com>
 <DM6PR12MB43132490CF7D1CC16AF6D42CBDD82@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB43132490CF7D1CC16AF6D42CBDD82@DM6PR12MB4313.namprd12.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN6PR12MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: b250fa81-ca56-49de-d7cf-08dd67eb79dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9XkOPWTriyeBmnbDW8yWHUMRdRuXXKQNEZPQSz4q0VVpi8ymOAyRcTCB5WA0?=
 =?us-ascii?Q?jeN90FRAWhXesKiRrz2F3txqFOfLI4kOAwgp9b8dS1sfNjJ4x3j9w7OFwHl5?=
 =?us-ascii?Q?89UNwt61ALZSwQVyS5hDVk3EWwirg3VYTk7UG+IcUOLGckRwodAVrW1yEvXi?=
 =?us-ascii?Q?YcrFj+11wl3E/9IDaxLzAfcAi5gk/ru8kITTRc+PM/l0Ds1q8RqrEQLuxxQE?=
 =?us-ascii?Q?9RI9AvdxOkdydKR4Sdubr4ZkdHEm5tweMcx7HLcCZZaZyICcmKQMYz+qEDxS?=
 =?us-ascii?Q?79xlPslwLBzT5B/tc4E8i7uKtf1aQzxL9uX2OTkDTVDTwvTJtYINtIBPWdqP?=
 =?us-ascii?Q?lxQGVGHZ3sn4C9XO/NM/Oyk0VwTcnsPfu3gEb7RY3WE+FQxx6KujcdxhNwPB?=
 =?us-ascii?Q?l2N/WYGf8RIQSQarVjfRNjdqEc2B4pTw9t2Cia5pUifPSGrfSgKuiHoqRy3N?=
 =?us-ascii?Q?J3uFQpdcbp1h6ifn78jEthRn4C9gWGl5U0wzPIs5m3tHf8DdsTPZjFo0R0O1?=
 =?us-ascii?Q?mzZxxXlGEedKt3FitomAP41wjkXu6UX3zitMStutpxZUuY+AUzcJiO6j3l5q?=
 =?us-ascii?Q?CQpi6pabyn74PHq03CtByrbzCvjvqYgQyAE2LL42H/uVkfa+rsYXQxOwuWnE?=
 =?us-ascii?Q?WX8FKcJhm2FxdCMeqLQaii3QF/YF6m3aDxjHYcNilNKFXRNq+/Bnsl/JaXgD?=
 =?us-ascii?Q?APHJqYN8BPtmTuYFivX0o2pmgGVRgs/wk+gIbF8GIBtHzvuz2BMjGalvrNXT?=
 =?us-ascii?Q?kYfCvBO2xQUna28m2GZUj5ooskJOcB5CQvYIsCfoBtYdO3tXEVwh2pITRSiR?=
 =?us-ascii?Q?SUg+RGxRsFcSb7r1f+h1eXwuvSX/NL+MRs4cMys887uB+VzbJp4FfOWBB4qW?=
 =?us-ascii?Q?hMfVyv8GGsjlO7GEKn9QkPpklntWQMnvURi1rh5jx7tiXPZe+BaQwKDi2UBU?=
 =?us-ascii?Q?3JPiRTrvgIcw+1EcGUt91dJJBlh3My1dJ0oQuSGw5/gXy/6RCtPUISYumLYe?=
 =?us-ascii?Q?TaNTBoXYnLSadDjPD7hzMXvYqs2G9vqc/iTezw/xWiXuwaFNbi88k3spwEDL?=
 =?us-ascii?Q?B8kz5mrGwxRoix9ImncC4X2SMLxajmE3NJXpLiPwnJz5mrKbozog7fxTPwNS?=
 =?us-ascii?Q?0DWpCa2Hawu8FoS3C67XJVknwWBlxOnTYPMW6cn3gzL6S7gWav1BkuC+Piux?=
 =?us-ascii?Q?OTrtiUrRU8eLEdg+3ymbRwSZA2NfZdcdIQiZIAYCYRerX25NB2Q2HVvEHbNd?=
 =?us-ascii?Q?yi5xkNcif5X6VNMwdCuG+KdomFk3aC+Qc0IwJh58ZIhCQUj7Y8j5IJfXSgOQ?=
 =?us-ascii?Q?bJacagoIMlbhCw14YqtGVyaHzYxaRYEFxzFh//K9Lk3agIpuPXaN5yuDBgFA?=
 =?us-ascii?Q?8Rt5BYgJG+lsZfVqQpi3uAtNKcIF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I07HUSj1YwD2jvs0pMEJta5OD36tnPaVHCz63gp9ytMMmPzqjGdlw7IVgFni?=
 =?us-ascii?Q?aAGb11KXKqEfMpcKK3ja6YoSGBAYi2alg/d4YBDy8y4RVfwDinJ2+2V8uf0J?=
 =?us-ascii?Q?uBwyCkJh3Wmo8E93MWIg5EGswhfM7GhnqRBAkQD2Ub8vgTjKFH8NKu//ba2y?=
 =?us-ascii?Q?rGlb7nXTr2VVZMx+Ysyi4KJbas4vHrm9WWtR5Ah05mv6mtfyB/EJ3i5cLNSL?=
 =?us-ascii?Q?xkVRKNurCWgAbxBWmTzljBaOICAoz6nhrfIw5mQAyncSNMUBMxZWujz3KJXl?=
 =?us-ascii?Q?nUk4px++CL2NQoptodg6ts8CqL4rC+Z+tShnyakz7L+QnIlBLaCQu/67m1Vm?=
 =?us-ascii?Q?SHSBvR/SvWpp2OmCdmzwjlLErInMw9W7IZp5U+FVd0s4FwV2TS0O3Bhd+z11?=
 =?us-ascii?Q?3ZLb7e4NsA7UrLtYkuOntR8tSWacrpokWjMrAlAeUB3rZ25nw64IfjyzvHHW?=
 =?us-ascii?Q?etZNOd6WCGej9AOHZ/Hr4RL7iZWoz2sqwGNKgA/4Ffoi68NDi0zRac2pYQwL?=
 =?us-ascii?Q?NFgEWsGfFGPioTS/2MUPyXqq3xxhn1XrWWDEcpFRPVxvTlNjHfPV0jtUXJ5n?=
 =?us-ascii?Q?3ijqpaDlL8V68uc27ZYJBCZZrVTDmcNEKbGCoybCuMRUYxBcA9uK8vukICEp?=
 =?us-ascii?Q?6D11lGmXnvb7T0qQ9cY89jWXpgxrF9KfscQimxDmqny/vtvQrz/bJkFCCACQ?=
 =?us-ascii?Q?rLiyPutJvF+GcjPOVegR9GalnKBqi24ExTFMWkHFJgzh/8hyY6gn4hmY04xO?=
 =?us-ascii?Q?gg4jHacLHp2pkCniaC4oFKvCNlxDyGCRppnJ/ayJRQCIuKNWkPVeCaoiLEOX?=
 =?us-ascii?Q?ey0qQ4uKQj9JcMsspmNtBRVYdzJJSbszxu0loRS5pjrHfZHZiiozKPRmOrO/?=
 =?us-ascii?Q?Odx+qwhHRTPM16W954vjIEwat8rqhqyoVRDHBCm9mw+/BSTsmEAmcAjHS2B9?=
 =?us-ascii?Q?7uu/3hKCBtX8+HVhgXWQDcAOJUK9YkjYky6fwJr+HrUV2QMfdYm4OTQqpgEl?=
 =?us-ascii?Q?CbF80GQcMx/cWzXLHZrHPwfVw905nExdg0nUTI2lseNlqAicy514U7kndWcD?=
 =?us-ascii?Q?bGzTgqWBcqJMMa1egT0LQhUuqgDDySFV01EzLAwYMHaW9T/PfZ0D2aznfDR+?=
 =?us-ascii?Q?flwIhQMtpN4PWzlP4e9p4lvXHlO+ecrmx1HmnFayRQlMoybrCY7mb9XrjO8u?=
 =?us-ascii?Q?MyFO0WZet2/dM7NT42/Z7EtEEuqYInUlWwUic0SmIm7GSPR8PfoX9jLHU9CM?=
 =?us-ascii?Q?1Y5W1uzhsVY1bSS7mrFlZloA7rQzdaupiH3Z7XapduFj9VSt5LRVIewtPMpY?=
 =?us-ascii?Q?Hlnj/Lb0ot/lErlTwT60Ih5uwLxwxGK592gNy3XAnyv1s+zM83BCZjYmEpR0?=
 =?us-ascii?Q?k4mbmGynFbPF79VcmNyDyMhDVrCZcOeFsuPK7gFQmaZ34YXHwF407KL+KhIt?=
 =?us-ascii?Q?t9WPIcztMdBAm7VK7ushFTPBdSbOCKUJbk4OEUVFqiYz9HZ4QYrCLXfwlrhM?=
 =?us-ascii?Q?cFwnxa6UIF32tfak04J4vn0J7vSehArieQ8R0x4S3UVUt979ZR52N6yS6M2e?=
 =?us-ascii?Q?cLJ6xhEqj/oeEOj/4uoWsg/tN1P4VQfr4H3oIAPB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b250fa81-ca56-49de-d7cf-08dd67eb79dc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 20:12:01.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QjYwHHIq60OD+cs9rmG1ZUR6GitrQjVx5i0NLjSEO9/UyX2IfGA1PfgOi7oe05H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592

On Thu, Mar 20, 2025 at 08:05:05PM +0000, Sean Hefty wrote:
> > > As the existing rdma subsystem doesn't seems to support the above use
> > > case yet
> > 
> > Why would you say that? If EFA needs SRD and RDM objects in RDMA they
> > can create them, it is not a big issue. To my knowledge they haven't asked for
> > them.
> 
> When looking at how to integrate UET support into verbs, there were
> changes relevant to this discussion that I found needed.
>
> 1. Allow an RDMA device to indicate that it supports multiple transports, separated per port.
> 2. Specify the QP type separate from the protocol.
> 3. Define a reliable, unconnected QP type.
> 
> Lin might be referring to 2 (assuming 3 is resolved).

That's at a verbs level though, at the kernel uAPI level we already have
various ways to do all three..

What you say makes sense to me for verbs.

Jason

