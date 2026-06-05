Return-Path: <linux-rdma+bounces-21846-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6v/XIAcEI2rNgQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21846-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:14:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D22E64A0AB
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:14:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=HwaEyBZx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21846-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21846-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60060300DF70
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 17:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96943644A2;
	Fri,  5 Jun 2026 17:03:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9012D29C7
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 17:03:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679022; cv=fail; b=nlgT97Zg1JAQl5VOyjtAj7FXElcB1etHnZ1Kcx38cFj3rhjJx+x9YJXLr+XO6zJKeT7TjlSznx26YpdutIa7UvJh4nAH+7l0WLOR4a9G8vwqs5UxOEtC4XGSNuHOi5z9QzWTNxv99M6eZ9aLe+fLtqCz/B4CfJsefQk90hUnRWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679022; c=relaxed/simple;
	bh=qHdc036+2chdPIt26sW6tW1ywLPUK1S49XyJ/BS24Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QPv8D9460zdfcw9fbyFvYVE8lkXBtKlFoh0nmc1zhPBIazR9hMcFFsfni4TUoE101zaCrZvyVszlqYB4BCMqFIvu35++lcYbh/LO6IM7MmU0JodMZwLqyhXcGJjCTrBNePweiiIuZDk+xE9um0sKcHMv+0+n9D7fXBHCvX/qBA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HwaEyBZx; arc=fail smtp.client-ip=40.93.201.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKxlJ7Yjze+wyDfMpREHIGb0G2kqpadaKJeWAeXK+DfRVVnf6+N/oKGkY7X47DjroVBTMOXM009aOi8Nyp182Iu537Wg27WMy6gl3IUWT21K038p13v6oAgAfV87ai9Ry+Psr2aATAy+HqMbQrNaxyW0NMW+1vdQdFsOsSBcymNAl3xsO1QJd/6aAqdXFdEG5KENPNZfU5YXaGg86go03BfgW54ZH7DLx6GeHcxQVQt6H0vVmFzVptbnQmDZ35bd4U3iuCetBvfqRJQWlb8KzCuV6qGNE+PeXWftVpkYfIQZjLiPGB0mT17VDJOFfZp+0H/ikUeGmUnMHr3uYWLduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFs2L2DWa7QEVidubAKW//yilUiKaC4+zDUOa70f5Ao=;
 b=A+bUJ5NIfD/O0GDPFTeHSJzBGW7+LjmFfZuEFePqSi81bvQykWWaOHAziIjHI3Zyom9dmxF26ADv/97zOWGWWR8kOCyEuebt+DMMZRyKyKgQfYQ9p4cmYSiKthjyLY7gkVYwh6vuZQnhzRwXnuWiJbnc5XQvkWA3g3lC2Ed30svNMtCPANQwxwfOLi2WTp503TwxlxmD33JZfHkei4YutZkFjxM+jObjZ++u89Von3cbOLNHrDSW/l2FyGi5a+LMqdWyh1r32uJ3YStBUbZTP3yxD2AyxIPYT+x7vTqdQuLnlCXjJg9gpDOrNdR04N8qLdYXg7Xjqn2KxBW2HkPtKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFs2L2DWa7QEVidubAKW//yilUiKaC4+zDUOa70f5Ao=;
 b=HwaEyBZxQU06rf6MuXxMVRr8M733TS5VDddIeOUhppDMdhSKYR1fabVOkvCYOiaGEhku4A3cb+zYkglFSor6x3D5w9wuJXm1iq1kXr4/mLKb6iu66R7k823rqiLl6zMUJ5eXjuD20xUGGtQ88Lkr/CRV3LOYMdO6o9+wsawk+OiyAQJ/b+g4p907tkgTBfTP6IOYbCGhEj256Zk4B0Dj8JhxAmBkOGwdxeXtY0IIdmNq8gmZRludaVd3LNzLiKs5E0M58a5/JQf36WWailSzXKB6DY1d6K+kiB4Y3xCDd2PwhNaDAdJqKdGvxAMIrlyIarh5nxXaAI/Sch9nms92fA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 17:03:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 17:03:27 +0000
Date: Fri, 5 Jun 2026 14:03:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: lirongqing <lirongqing@baidu.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Fix state and counter desync on loopback
 enable failure
Message-ID: <20260605170325.GA2765215@nvidia.com>
References: <20260601095818.2227-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601095818.2227-1-lirongqing@baidu.com>
X-ClientProxiedBy: YT4PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3aa8c2-2a0f-4045-d7fd-08dec3245c5e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	9QUf9Lk3HRPCCvDWAqmII6IiLKhk2dpiSYG9KdqLS80Bkbj/++VPFStf1PjmD3YI+AfMXvS1ewjo9RuA768VVCzxZEQC+HPIQYlLGkGkxD5noQOD3Dcz2g8QDOjGTy1ztXgIJe/mMIYlwuHCR6F1nZlDipQ/JaIIQPXoFPd4PmFV7rTdRH9649029VCAEMIzUgIoRBGYv7aSy9FAaizom0GbwK1e05EAqbnvGN+g6IYHfYG5CxGs5yLcj7Ci4qrGy29g/fAA2zd7rc9CWnnGl25hweLHJIZLKScfDb5YyUusNSI4KvyMTvplYRf0btelNqB5ItEhOoSkmoOh+7q51tnuzY/S2gpImeaYs/VdEWSXpJ3O/i4OBOPXT6R3BZJzgG7XTcL00S+fS17knSv4YHpj5YgtKUyxmA+6FPNsVNk3eeIUGkRLXm3iSC81VKBI0c1TehkPYJku+eAxtJ1w1Bsuk7ssHgHoelfVvgVthySorp5ONtp558CQ+BNwuTI8sC0+LqM05ZgtWjPMPLrBdejuR9ShOFccy19BaCUMAeDxCslPaXITjuSoxjxXsZ3TNqTznJbDjX0aKVe8vPU76nqQXIpF0BAhoBWftZXhDyAIJ8umSmS5EmJKag/TQ5MupVUAvLBuHoZPxYFtSEKx9xu0ujcKOzB6lYCKr5Y66ZToKz3efTToy4GLN8S9TSAI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x+XqyCKViEdGnIarCOpNDPEDW3aHVNpQxEE91uMPtDb29Jim8IY9K6f50Ps8?=
 =?us-ascii?Q?ZMhXcZyCTzSSMjbUw4A66KowZUbZhizlBLFCQ8WSWoG+F6LTN1/Xiv/pSNDF?=
 =?us-ascii?Q?wtna8F7LScEHfZeEKz04GB/eftAd8PrxFGLcBXFFVMbHwLryps2rerL/ABp1?=
 =?us-ascii?Q?smqx50Mbiy1OUTTK8HQ7m9Afmi8fSGab2LFZ/BLyr9XY0IF54CaMLeZ5jFA9?=
 =?us-ascii?Q?xudaQFasiR/QJ4ZuMQHH+n10TbV79IEgvCVTkWH4QATHWNJW1XxS+e4MASxq?=
 =?us-ascii?Q?UurU/G1BjPrhyi0+VpIffQus3XOaR+SO4I2hGGqFM8fTrcYQJZPe6df/MkBF?=
 =?us-ascii?Q?g3OGCtWimkkLWwKONVmoWu0iAkAbHxccSQCJ6uhG3t+b2Lrxbo5ENMMjUw8k?=
 =?us-ascii?Q?QwVSvltRl1yNw4bZ7ZPtjuXM1a8I/mS4PnVNeI4mQedJZlaYnyDONcwr/LsU?=
 =?us-ascii?Q?TSxA0xNvyRDSUDVPzzaA48uD6qipBcd7lvrnI7vkcRC26qgTCEvfOD/7YXMk?=
 =?us-ascii?Q?7geCYexzrz9UOvQLv0EQyWRnGzyMmHR+rgcIMRrphzQlvfaGgyyieRGlKsYL?=
 =?us-ascii?Q?+X0AfSHsZlH0s5zqophTTwIn6pguElD6JdZiXOuCZ1Ym9oAN4igzYZmaaA+6?=
 =?us-ascii?Q?ThI5XZu/7fyG1OPj8u3Qo2a2bI4K0Zj36FP1QRqgigfBdDkZ0S9ntlNpqG8p?=
 =?us-ascii?Q?wezZDRSVNsUxV862BlJHzKPf3a9Ey9SCy2Bl5pk73Uv7IzHKUxH+7RAJwAoa?=
 =?us-ascii?Q?ml6cs0Hv8/Tws9boXcINWb0ncMF8oBkGuXUibWuG+YAuZ5YgzG2OoC1Pd1yI?=
 =?us-ascii?Q?bYnyLUKsxUexiWyryamg2/usvB+9UfgrqzlXP3SKHn2LJEsnJF5QkmxJDqWR?=
 =?us-ascii?Q?EzmpeQ/OI0h2hDLh64KUdPUp3lodXa/c4TOcghq8CQth0dPaYoiH7zOfrkBZ?=
 =?us-ascii?Q?8jSSny8guotlBXfdU6JQoB8SO4KlfXLjc7+51FHu6j8s+1ME8azaYC0q8VLZ?=
 =?us-ascii?Q?/woTwNuT5JErjx4TWtR3hZIzyhoZDdfltoZxFDIlsUs0AOg2sFaQbBwEfNqo?=
 =?us-ascii?Q?0S3f/gkZdbEY3ewoTr8K890SB4+AhJHnsDJCahuto+BRjPjaOB77WW5TBK8D?=
 =?us-ascii?Q?dGwHI+b7/Egqe5me/OqaCYsk2KcJrgLiSEwYSZYLWcgaYvI7vv2u/8LxYDEe?=
 =?us-ascii?Q?9Crs3Ja+YowzF88BBcvLuDBQJ32AHjLkkgzqIWYwS3rOP+OSYvwFNjpw18RG?=
 =?us-ascii?Q?Sy3n/YCJIYM+cLRX0ek5sz/g4cbXpE6wrVntUjQQLZpkPN+v0+1A+ILZyDmb?=
 =?us-ascii?Q?ftq5hvh8IeqDLpg9ERf0d7sywN89H6pz+ib2b0Kk2yefMl7uDmt3p9c1EcVh?=
 =?us-ascii?Q?psvJ8LXes+gM7z1jZPP8lSMYFSB0D4Gdp88MJOxg3+9P12WP+Azo9AlgHwMz?=
 =?us-ascii?Q?czIQNOj7JIzZCtYxlQdOCWvSa6AbMpUdrZW+yiEPPtiRQIn5pcrwzLXO8nDo?=
 =?us-ascii?Q?O50x19HqcQceuObG/DABGCasETwMZTd46EIh4kxNAFTcAcHn0OpeSqo8eCy9?=
 =?us-ascii?Q?hzwBLsRBGV15cfazibGr/31nIM2ChHJXgu4Mb0y8tnSpCMOAOaBn96CgYRpa?=
 =?us-ascii?Q?o6/O7Vs+cyIz96ULb16JDIttlXh40+0WYqjBleOihWLB2na8dmy6F93hypvl?=
 =?us-ascii?Q?1DDKk9gpHYHzkW1ahBwOYI8381xKfyKmNq7wKUCJ9kwsQ/Fu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3aa8c2-2a0f-4045-d7fd-08dec3245c5e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 17:03:27.0806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3TxjoKd/o1TkK3t9KwTFvoYs3wTmQd7hBq/WkGgWPFMtuJB4haOhsD7SPciweWM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21846-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lirongqing@baidu.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:mid,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D22E64A0AB

On Mon, Jun 01, 2026 at 05:58:18AM -0400, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> In mlx5_ib_enable_lb(), dev->lb.enabled was unconditionally set
> to true even if mlx5_nic_vport_update_local_lb() failed.
> 
> Fix this by only setting dev->lb.enabled on success. On failure,
> roll back the reference counters and return the error.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied to for-next, thanks

Jason

