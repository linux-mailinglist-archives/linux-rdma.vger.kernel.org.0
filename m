Return-Path: <linux-rdma+bounces-21235-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNeRL75ZFGofMwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21235-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 16:16:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 430155CBA4E
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 16:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D17A3026A80
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 14:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED05397AFF;
	Mon, 25 May 2026 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="stB8McUb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E8383993
	for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779718360; cv=fail; b=e11FPuXSEg4uE3nDekjZ6g+HFUSP0IJ5MgnttCanZmtD3Li4CXXJDpmt5f6voHmVUMmISeK+OzLfUe5eFTipoL4NGH5DzNTUP6Bxvdm1p/dSqmhnc97kHzs0itsjvm4qN5GMyopfDNB6qidH2L9qdCtatoHKscqinHOwVWfDts0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779718360; c=relaxed/simple;
	bh=qt3N5hF9on40QC3jI+biDypy+yb3/dCYmU+tkku1uJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rfqoQOWkFc5X5Xgr7FSkblQTkIb8XKrnQzRfovZp61mF7e9GkmAntLiasuo8YAue0KBbbgo/Gqh5wH1Gw3K3NA9PK0FpUc9QVtj0vVB7dOjrpXiLMhtkk2uW4uvRgnrxYRxcmMyfQ4oIZs+ZMS8bRmfWW9FZVJotCiBqVKDDL9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=stB8McUb; arc=fail smtp.client-ip=40.107.209.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENedLsetNjeMYs09jQg6NRrgZAhmjRnUlVuE1hI8+xvI80gaJXOjAFzzI5CWSknbJDCk3e4l5d3qBWldfSyX72Y+xL0yFdX4tsB+PMftdisEpshEZQyxYYSNfI2SmfFie+QwApW77i+XpzW4OrwrH3zXSRSsg9TdaQITABYxJz4Gjq3UoSYQna/Xx3l8moNTJupKQWE25UOWCNirvb3Fyp4v7qZJ2fE3ISOW/SiORXd8H3By31+h8SHx7Tqgl86edOMr1IDeqJngJlFq1v7YoKI/q87KOhEqrvob7rPm1iLBehHqQc1jlyFXh4SFTReiwrtB5bKA88LavsKinOhKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95iwO0Hajx/x/E6NCr2m+gqbd0pE3I0WAFexcV+IlL4=;
 b=fKKsBFP3Z7eOIC6uaaq0ZrPoXmM8jw67vp75x71hZbll4yde6V3SMMi42sw6AuQHNYj4f7UtXBPNS6Luc3VXlPVdskl3xWoMvPFDbrsYZdFYZbdfjvrkmMd+qhApjb/6WUYjMZxAhkxoUN0v9a/UV/BJeg8ZwADJ63CTKrlbtnhbXUCNWdL7I8rBy7Vr92ua306KwALsuyBsRdy5/450lDk6CkDvpyftl+w2XsczMPGe3pdmbKQapCZvIOKBKmdIufVcDVTZNAMotuCKD796DkEDzAoZ2JSApG9QpC5sCBoZrUuuIkrn9TFX8wBZmzJLlqHWaP0StEVb+Ml2f+PL5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95iwO0Hajx/x/E6NCr2m+gqbd0pE3I0WAFexcV+IlL4=;
 b=stB8McUbucpUlYo2KveP1VMqiKXBRUvBm7ViODiekk55o38auzKo1ZP29iAZ7m3ky7ZPtqh1FGvfqFNWijLxxqd8Bl6lXz+RSfocXTd+n2XLAXSksHOQA31D846KK9iR0U17izGjlZTbbPhXGHjxyxPNnxHanqYpfwgqq7vAxQ+VTXGl1FTEWDVhmwcoyqHph6WzMBR+6qoMt/7+9vNI2Meq6FQH9NbBtLFRKPjNe6VXc4BfgCHqrQ8MfLJ2l9p7RpxaWilWq2YTyaRHnizVTAkQfb243fuhJLdU/0wdOTKUNEd6mMNjt7QnHqLSqjZC2po87ZtWvMRNcHnYnBK00w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 14:12:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 14:12:34 +0000
Date: Mon, 25 May 2026 11:12:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	nasm <n4sm@protonmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix a use-after-free problem in rxe_mmap
Message-ID: <20260525141233.GA2447094@nvidia.com>
References: <20260515002537.6209-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515002537.6209-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: MN2PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:23a::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2150a1-3914-46a3-3005-08deba67aafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HbnfUVtXLZ06kXw5kY6YbZFwQeTp2xViV+XtVJmMIJwjj8SUluhUOOKjp2IiDWjfJvwRB/Zr7ggcdAes6MxjCFW0BoZ342aahjPL8B3vov9Jk2PfiQ8qYrDtFNZwkboBuMwEkL4DYb2enqVWzkrknlelNntvds60CI4ieDE2iidOYjTClMzvmtCQUIjUEoB6VN+3XBARSCI6TJuHuNYEab0acr9YaVS+gpsM5vo1Q91An7/LpdaA3ZwPBa8d96doQsKKkkT+4RzymnfRHayuXSxswMiTfaWThRue9CukB4DMnw7XSdEqsRyWGhF1dllcO378jYNlP7LVH6nF+yPNLn6kDeB2tlHvYl+max/hrq3yC0ei6w8PvaWbVyrHvsi6v06blJ7lqQLmNNb5Llf3oVt+FIXjEjTR+52CCzfWTKwvxp/VMXmMV1rVyVvytr0rIQAaNetsCsI3pf1CHNWedwNLh1RYgG7oSJtFZaLBweXehGeOdOjUfYNcBxBzYFKO7I3rlAxViHs9lcrQWXtrD/PCl3nBCeOdUtM9RCdkibHQaKv4Bts+tIAXwh60tDm9QeHvWMNCMC3FXlOloa9F3bq1g9JX+OyK8KfHhgUqjnT6SrVSQ0exWpmbDVo94DeYN1g2rWhIQfQk2gKrGwdWuJorDtj8La+ezLO9SHzsNvOzRq+u3dgFF61OJxIjBhuZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6JGjGZ/2ckXIXphDSnp9hu+hdgmLExug1Ahyay1Cbp1mKRz25tzIu9l6Ic4X?=
 =?us-ascii?Q?GLrIC0m+b77uLyW5gJhEOSBm7k3HynZdX5Ww0chfQIL9HHXpmoZ3NykRgy5S?=
 =?us-ascii?Q?yX4ZLW85qPYgvzWDozKyETIrkp9TnxnxiRz4MXUJEIGIHs0+PCfWAopnr/Cw?=
 =?us-ascii?Q?WxLRKr+Se3FgfxTY9QJnxOBFayq+mqPeUF6vuhYVj3d93g9nwRZd/KMbuc2h?=
 =?us-ascii?Q?kZS24+YZTNoCRbyqXe3pfUwXR8PM/gIBLiQHmDpDop6Tsg51BkMcXnVmjh7b?=
 =?us-ascii?Q?Z0ZGbZVR+uyllwwA3q89FPRedMhsIMjyJ1ZolJmKww3+HhEoVba1+oxm8iHH?=
 =?us-ascii?Q?Btyk/svT9FbfdBA3b+bt1URvhjTCx5WgvKdG2OpbycWOKYRitSVnB/WRC+as?=
 =?us-ascii?Q?xcU3irYsgmgWAogSysAclKyXVOYcGeEVh8BrMF9VwN+OCRKNiWSY+ND2kE1X?=
 =?us-ascii?Q?uUSHc4V13VfYx8sJxgum76Bg81+JpRDxVb1tCn5T+rZAv4HJJuTtc8KlbT80?=
 =?us-ascii?Q?p3LzMQ089M85k98vkZ8apex01IQox6Ra57bXWItl/lHPDGTnTNk5yy2RhCFg?=
 =?us-ascii?Q?glTr6SHXHw8TnblIyc/W/PavJM/fPtGvRIiJeXMsYGUZa+bj5geH8MBHPb0+?=
 =?us-ascii?Q?0o9j8mvdtEBusZxdYK5N9V/CH51wK0mhtZj1tLvWxzpNMBmCCSqB90BiQHXP?=
 =?us-ascii?Q?jzeBZ5HCrFCdNZnZdqvYgmVYfwy2kyfgYBj2HpTjzZ9fNAXRwP6DzIN0myUH?=
 =?us-ascii?Q?FfobMUuyhe54AANlk1zWWrlrAgUTK9lRGWzIwVc947gHeuypRMMYhQB96O2q?=
 =?us-ascii?Q?Ti8Ki3w5JTgpIGGIivV5cjEuh82MMSZHteSks19/0hn1S2snBRHT8OXT7s+0?=
 =?us-ascii?Q?LV8Uy8wvHxDqSrP4F7jf3fIIj0ys0LlCtllrqx+sXYVvVITlJHqY5pojZE2S?=
 =?us-ascii?Q?UJnAEGeDYLxGjfkOP07USAo/br7o/f+L/gvDsYl6+4zKbKpkeYTjgXSf9Frd?=
 =?us-ascii?Q?rwgS5lKsZ1t5YaaqAjhtTOBvDvfEaBY1xqV9JeicwN3YeSTtl4PD/9wWQ5NZ?=
 =?us-ascii?Q?idsLU2ErnfnpQYZMrBWQ1V26M8v0fRygMjo1ScpwBZb0DLFfdJZilwIR7foX?=
 =?us-ascii?Q?Z5Nm8PQ48RDWqdV985rKL45dZ1pV5jkcsVQNsrmRc0z3jeYN27tAVw+B+Glp?=
 =?us-ascii?Q?UCXvY4UxRxrOFpulAl6giFuA9Phspr70IHsdj5cURY263Lio8hAKHyQpfdZk?=
 =?us-ascii?Q?Dxhtq7XBuKTuWQebcxrXrZgcEgBrCp8HnK94Sn9p013orW29p55QENJCZhEB?=
 =?us-ascii?Q?6J1QQzc3JgbBz/IBBbPdLatNIMCwE0xK7YXXGrA5/7VWScP71/xCJ9FjoT6n?=
 =?us-ascii?Q?mNDpCbf1qcvZT3FMGfjxJ/8A5raUj9NSehsM5NZyS+8aN7fpN3/Hv0v9s+kV?=
 =?us-ascii?Q?3EAO4VwD0kB+DyBZ6CGe0V9IDlum6gkEsfLqahRxmJRM5k9cq7sqWrAI4Je3?=
 =?us-ascii?Q?7MIw1EA2cPjK+CzUW837lNYmgxFQR5VBu2C2P26gQWUweA5PjGKl1D7uMR5g?=
 =?us-ascii?Q?KcUGHb1WSPXOPWJEoS3E5Pr80YeIaAN8bjpa7s3qqAwMeji11FGP+X4h3ERb?=
 =?us-ascii?Q?J/CVoRS2BxIyTRGzHkSknLYdUOpyVI80ZddflvrwwY0rNH/bTUAPb/oC2Rfm?=
 =?us-ascii?Q?ixzx0BkN3Q3uBlW7m5kUdTFBj+4r/uPbUkq3sdz1q1sA5p/d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2150a1-3914-46a3-3005-08deba67aafe
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:12:34.8075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IlZPwhBuQqWlc98Gqyf4RKZGMKcItmquZZRrx00GlTmEVGmTiuM0XSctd2U0/Oc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,protonmail.com];
	TAGGED_FROM(0.00)[bounces-21235-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,protonmail.com:email]
X-Rspamd-Queue-Id: 430155CBA4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026 at 02:25:37AM +0200, Zhu Yanjun wrote:
> 
> Reported-and-tested-by: nasm <n4sm@protonmail.com>
> Suggested-by: nasm <n4sm@protonmail.com>
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_mmap.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

Applied to for-next

Thanks,
Jason

