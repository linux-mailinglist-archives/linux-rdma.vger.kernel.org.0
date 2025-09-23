Return-Path: <linux-rdma+bounces-13601-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002C6B96825
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 17:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D3918A056D
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 15:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E051325A34B;
	Tue, 23 Sep 2025 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eL52vjof"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF12B14A0BC;
	Tue, 23 Sep 2025 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640362; cv=fail; b=nX6stHhvzii+EqZ8NWLKJr1GU/MEzzNd1d1rN+J++aYImrZMfaXqwbw1y+QVXDIGHYMZSnGnGQY2LI9ueuxwxu/y3+pLvRBquwqcXsdSqoKwzNfZVS+CKsJFXpHRwwlw4Xo0MhZ0gpGeXQHs/wZHeuWGFK6gaAcBi4fjg/EbINQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640362; c=relaxed/simple;
	bh=gZf/XI1GLFNkisBO+mP751O4qV3kp89bTTFXQA+BPgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rZ9Xhe074/m/VQ2OlfG3faj5DlPIDDOm+VP5eDM273a47IonTpohFWsxm36AVJq+/VTm9cSPbvCqB3eot+XekDhMZRbPwz/c9TukilDvkzmp0jYPdsqWtXIIfU5ybOjg+VMQuXIeFLVteutGcj+Y64YymBVWWdDIL/BDTFPUbL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eL52vjof; arc=fail smtp.client-ip=52.101.46.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=no/lMtlU4j0l18sr5dBWyGxJI8pe+TtIAtx0g4aTNTycuFcDLX4anjlTLL8fwSvZa3C/Eq6RYHijlHdHeExUeUKynD3NROLXXd23l3QMdrX4NGERKiYUAL4kdJstn4+eY6Zhq9/8CLBXrz7jyhsDy0mRCkdDdXDtXfZfi/lyu43YYDZAATHZk+G2gHVu8ptZjztrUE37sW+gIJIrOvEpprkVue21Ec5YlQcq2Yoyf9fj+/Q2xi/GoPj8SXYgSNUw7MYqBIfRJXEZjUzl7ZkeeDFN8Hw5ch9A7AmunommZKvGWU0AHEfzU/acMPq7kSEPMwMfC7mJeOUZJqL6SZrAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJaRQ1HYZlsbhhGYuk0bVcdGpFUtVcRmr6ZLMgZiMWE=;
 b=PghBlFHigb5UNc5pWK4UPSa7V3bWlymOs3DC5SfAjCtw87bcp8XNShcp3REBKcvf4BFll0iEr3PwOJ1gCuAUptaGehKfJIVoZAbwvxEUYHh0DB1Wb6oXvZSfTZuK6JfkyIzGjsaeNnRYmfIOFbi/TjE0Y+7XgOX8xfQw1hdWH1IEL76lW+1AUM/7WROpwyuNvCJYi3b8HUIV7AUYQbmAJv/vKn9dgwM/m6LQPuQlDfmbSh/vvw3GMqdkOdOpXpAgGqMv4WKYFZxA2b8TEBzz4EcCc4b0WjtkamwP7UraYxEx6sNaxsLLI7kEaw/DBOtPuWciDMmrnYFP8STC0Hc7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJaRQ1HYZlsbhhGYuk0bVcdGpFUtVcRmr6ZLMgZiMWE=;
 b=eL52vjofsaoCZqVyu4Mhkhpl7mAZgYCexTgDqnRKuodLqbw+eBss5qaNOoPnj2MPv77VuIdFQyVvO0CWB+9Pguv2cTt8Aje8s20X1B0gtFvgCk+19Lh2xfaMeseoamWy9/SE8tB30P8yrXqMumhaD0lkhfH2xvYDR2cb2UYdLelPKs48Xm+XIOxaex4zqNiEEKg+5gme8QCnuYxCcwzp/NTOabXzF/jferB5u0/Hk4rnKzegLObR9WUMK4sVUcjop0NqTTQ/Rh65ywoiROrCw8oPcCWgNAA9iGGn7386YdEsRTESuxs5Mg/3Sxi8levd6W7IfbUV429Q00HuDeirNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SA3PR12MB7904.namprd12.prod.outlook.com (2603:10b6:806:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 15:12:38 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 15:12:38 +0000
Date: Tue, 23 Sep 2025 15:12:33 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5e: Clamp page_pool size to max
Message-ID: <a5m5pobrmlrilms7q6latcmakhuectxma7j3u6jjnamcvwsrdb@3jxnbm2lo55s>
References: <1758532715-820422-1-git-send-email-tariqt@nvidia.com>
 <1758532715-820422-3-git-send-email-tariqt@nvidia.com>
 <20250923072356.7e6c234f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923072356.7e6c234f@kernel.org>
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SA3PR12MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 01cccfcc-74eb-4571-a81e-08ddfab3a1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4XEycC3AVtIhunqymqZzD9m+JmAFw2YOsQuQNRUDbcURYSEutuzjdxCxj8eT?=
 =?us-ascii?Q?LmmZfG8xGooqzHXC85B0faEGka/FNJcjbQ1j4zoxzqsQx+idl7h/WRe/kPqP?=
 =?us-ascii?Q?4KyXlxiI68LJIN59nXVCiASoba1Rl5CcQm+4GK3SmAebYeoWMKCVqhckWU5N?=
 =?us-ascii?Q?9lKh8HplffqxMVLwtFxrL50krLV2xhKk2CTthVLiT0swuAWoHwLJrkvzcD0V?=
 =?us-ascii?Q?0Gu36DGJrFr6MWsdCCs11TPw7FuAZgrdLB/HXwf8H7MxshsIiA9WGbhUgK9J?=
 =?us-ascii?Q?N/gU5CKsQHnechWHeoWK9HovEGOgByLviTOE1rb4uhg+0Lak4gpncP24+BlH?=
 =?us-ascii?Q?w8HLEkssHByxBR/cZcyEiZ8iWgjzat9VkXxuEoc9oBVGuDpsrU0Q8kV+ZXNW?=
 =?us-ascii?Q?dPU4qW9QYqqmxfwsZUDGVkh4v+GiCAG0xvNi9UEQsun3OG/AbHRngFEvIerG?=
 =?us-ascii?Q?HGw6lz5Xw9NTErdFB95IG3zoOnL6mnl+G+JBBHRYlix8RcIVqRp1VV3wx6Gb?=
 =?us-ascii?Q?+bmf10FHZQPu/hF6B2v8ufnhztvfOs2JxOxEEH4KVQaXX5KSsHzHupGXtV2b?=
 =?us-ascii?Q?MGBnHEKszStWx1gw8EvcRgEV9kgR3k9HfVdonBeBh1aovf5BQi0Fqn1loxqD?=
 =?us-ascii?Q?P3eK/tkOhomRS021gEiqSwcQ26l2CGUBl6cx/wrWVrZ5caqThHI9uQXmU4WZ?=
 =?us-ascii?Q?0qLoeA70UjThKMheio2Rcgb0/8BBFGl+EURXbdfTIUPFp8tVaQHB/Xt1UcIs?=
 =?us-ascii?Q?+jDfNKr+CSyP10c2rnlVrG/uUmqUK324Q9WVkKIn2oPvu2XaZf0YB6eVFZdj?=
 =?us-ascii?Q?y6VT0zdpupkw9mwp/JKKsGAA/EZBs1Rgi4JmiT8LoYQshA1bgMleeaotw9FZ?=
 =?us-ascii?Q?Lmc8/qjSU9gMCn4VYNU2/MDQ47CremvIB6xEs5oyAzLJpQGPha/gyiIfWTZO?=
 =?us-ascii?Q?wZLMXKxEfZHLXWlDffyW06uCo8902chaRp+3dc3z4pb2vM2NCFVmnuoR0Erw?=
 =?us-ascii?Q?9b1JHZ/ahvVRsZJHEqKQx3dJFyc1ZVD/OlAduVLOUOHufpZbREXA9oHSVmPk?=
 =?us-ascii?Q?foqxtahnaRDlxtgP5X/35UJKQXukMj+MRoCGUNVJPS9iruGHj40pHLbnnONt?=
 =?us-ascii?Q?kyd3deebmBjIssvDVKYCEsnJP64aOH89S1Ff4x1b/kny68U4EInpfoKmfulU?=
 =?us-ascii?Q?qqU+BnQNSDjikynQGhefJkUBf51rbq0xAnh1FsctK4EWJcyaCfEh5VfNPepa?=
 =?us-ascii?Q?Q6c5uigw176JR+/2pFAuS6y1eN1co5tNXfyVbml61IfJ5/cZ9g8ThOqc22lC?=
 =?us-ascii?Q?pLwVhgfXwAOeMuliWmE8UYBtNCkH0f/AHW2W3EvnvAOnyre3Qcgp4JjIrRx6?=
 =?us-ascii?Q?QvFX05BSzXpRvzmBXyTu1HNagfoCo8AaQKJOerGiYV6FxI7LPBDEjz7HsBPp?=
 =?us-ascii?Q?LhIr5UeFH5E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HW/BOLYc80zAn/4bCzTdTHSkTd8+SUkID6fk+zX33kbdj4WxrwTjbdB+KJI5?=
 =?us-ascii?Q?Ji03B+QYeL954ABgxfEBlmi10PJL57lw+lvpU4xoAXtc5/Py6yWAy6yG4WSh?=
 =?us-ascii?Q?9P+Okrh8cCKTm/OPkId4ItIrd/fdvYd1jeCB0c3Aol0TCZdfTmLcSh4MfNFO?=
 =?us-ascii?Q?/GLJEKBFlCdwTn2vHGV3/PH2U+3TUxOHcZ0qQAUSgjMRecyTdQrsAN5V36ES?=
 =?us-ascii?Q?Qd4VE8DAVEb4QwW6qNeLXBe6n01KGGtZB/F9QZ1sHqNWAV9qHrs2b9aFBqUY?=
 =?us-ascii?Q?jv2tC1rqH1nLyYDFDh0g6deS9CWczFq9TUbdwhoC9wc+QYq0n5CZ5wWczUqL?=
 =?us-ascii?Q?wMKBij8JgjO+GwoaeTQQBb8fjqP/N1DQOlYzgCk/yJREkhsZRCHNf7YiPZsN?=
 =?us-ascii?Q?B3jAt/KICErLqeYtYDPsl8+BKwwdmGSptvbW1N2z8nNR81XW1sZvjE7T69Cf?=
 =?us-ascii?Q?70nzQK6Y60/qcbWXf6y/42D22D8xhot8dzVk63uYpH8bMW9nn+4OUzZHuvkp?=
 =?us-ascii?Q?/SlqrlcM3P3FpL0QIKoAjODMWsIYi3JYpZWBxZ0BM52/zuowUDHd9Znj4jW2?=
 =?us-ascii?Q?iqeedhYyBemBZzZ2ju2/lNpkt7nrTzKUBdsXknIuXTTdHB1ZdrDqhYaJMWAM?=
 =?us-ascii?Q?1o8S/Scf57u02CaEsajFIrn2YZ4G8m5Gx7uc7sxAFPAq8FLlH6WpPPM+tPCn?=
 =?us-ascii?Q?p7b2PU9uvg9glOcj4VI56s19h+vHhIZMTvZXH3/pji/85/sLccC3wU18d+rl?=
 =?us-ascii?Q?KMgEAlu1A9flUBvTpadr4s+YyXmKHuGesGoF0J4BDdVJ8vcFYtxx13dmsE5q?=
 =?us-ascii?Q?AkWsUpYUMTFJa5RXi0irYdG1V1g9S6ACUOj8kK0t5SohmGRv5BVGQWFCuPHp?=
 =?us-ascii?Q?qmomJUxbLx2ITVvX2KSqhzB5Swvrs9qvjtr5KOJVlvLUsuXBPf/F9sV5nTDj?=
 =?us-ascii?Q?9H4OX0QvBp6rGPUyK6+i8MY7kCHMnST/O814Q74RsrgMpd7dAj130UElOnuO?=
 =?us-ascii?Q?AFeyUZYnzZhZJOyxCJgzNtulYLaUu24XF0pXeq/g5FkBFoPP/1LQ3CmiMILf?=
 =?us-ascii?Q?FkgvaBCEMFOk4NpDCJj9g8hr/rHBnHAeo2Yfk18UtpFIsrdbhZmLbJhAn/KI?=
 =?us-ascii?Q?WHhCCXIZRcdrwxlebTT+SHjXpWR0WDNt0yDjlO1poGhpVttFNpi8zlSl9jtl?=
 =?us-ascii?Q?6Dv8PXlrVQ5AxsEJEwpMCvZFJq6U7OObzSWU7cJITHrxDivh3g0WOFkz0kRK?=
 =?us-ascii?Q?/NPNCx9lxoTt2JfJCuROS5TrJxdDHCH2kA+wuLfKQTb5ks0bBb27c824QMJ6?=
 =?us-ascii?Q?3rJ0KOD0lXf6Zd5Vn1sDMeI7CiBqv7nc7XAmsS5eZ51hiRZmkUTEvp26PUeR?=
 =?us-ascii?Q?Z8c4aszEiEeaSJsokkYgQhBT48G8K5KTQ9okyDh3yKT6RIJ0HNFUvFDxeqZr?=
 =?us-ascii?Q?yG2c4k99f7DFwYxmhJb+Q4i7OLy7p2daIyafpR/qqVy7ywTxv5DZKR2yEuID?=
 =?us-ascii?Q?gwppI10lyDYDVtatDXVuz2vjiPTKC5JhyBXt88BQAkJWCKrtLS+j6avwJfcv?=
 =?us-ascii?Q?M5bKpKNFatoW1yMg5qjIKz31puFxP+KP6amfW6en?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cccfcc-74eb-4571-a81e-08ddfab3a1dc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 15:12:38.1526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmPdSvyHHPz+0UiHZcNkAmvhoVpw4sSGV9j7Ox9ccrVjP/8Z8QPv7zbteWWV2G/QZhK2xAfvTUdCpDE3X4u4gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7904

On Tue, Sep 23, 2025 at 07:23:56AM -0700, Jakub Kicinski wrote:
> On Mon, 22 Sep 2025 12:18:35 +0300 Tariq Toukan wrote:
> > When the user configures a large ring size (8K) and a large MTU (9000)
> > in HW-GRO mode, the queue will fail to allocate due to the size of the
> > page_pool going above the limit.
> 
> Please do some testing. A PP cache of 32k is just silly, you should
> probably use a smaller limit.
You mean clamping the pool_size to a certain limit so that the page_pool
ring size doesn't cover a full RQ when the RQ ring size is too large?

Thanks,
Dragos

