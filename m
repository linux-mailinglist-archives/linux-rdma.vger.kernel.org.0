Return-Path: <linux-rdma+bounces-21989-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KfheCWlQJ2rkugIAu9opvQ
	(envelope-from <linux-rdma+bounces-21989-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 01:29:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA2565B2AC
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 01:29:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=bAUlI4d3;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21989-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21989-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 578B43037DE1
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 23:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B688233C198;
	Mon,  8 Jun 2026 23:27:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0D832B13F;
	Mon,  8 Jun 2026 23:27:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961232; cv=fail; b=TJ3cgoe2me7eyCWNI17fG2PeLD3DCFINcr4ax9PYbkKY/+4kivuTFlP2Vt1V5MjQMCWP5Cdbts4zyd5ALNLvmXPrd0z7hugiR0OzLxn9Pc1e9ohTjGT2bqpYtGHVPAblnjzU4dXVFv5tr7AL0lnQE9eVkvfREh5uNHtaqkqi+Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961232; c=relaxed/simple;
	bh=Dz7LXC6ifYRumrfx/c/DF9EDP/eh97ck1RW2qek1o+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WHyTy/d+jSxuNmJ5InWA2jo4D7ibAYGPh29lkoJ48TCKhfS2pYMutYURVl46BDg609D9taWbyiUX4ms6mkcEgzdrBNiYgH50yaHiOktAhJU+HHo8Esqsx+PN8uzGVEvCrMlA/A3BuOHTHvWOEb4gkja7uYomSXYAkGD0dLFY/Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bAUlI4d3; arc=fail smtp.client-ip=52.101.43.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdxc84PpMKKKY/VfHMegJbxLfrzvoK6VZZacHdqyHtsOkFas/iNQyGBQToSMF4Ea8ZlWL+B+sr5Kbo0ZtMyVpRCi+RgRcu/uteuWGm9ydhBz0MQhl9khXYVdmuWtMT692mLHsONpRwEktqsaORiyIfJ85U2HWvO+QWWCXMChnZ0FTAW7zMMucL6f2c6hX05J62eIOdl4aba9fV0X1h0Jou5cYxC9zHPYcv2PkYPX1j3PCleH/A4kfMpe+WHq3VfAreRw/pS3kH33dOMmtHy2tVUrDqa8T7bMkDXcpM49wTKDGUz8RpfhHm92NoyBE8NB/v/pC1m5MWGyQPUE/lOGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz7LXC6ifYRumrfx/c/DF9EDP/eh97ck1RW2qek1o+w=;
 b=UrYZRWzMEF9qorDNYIQgZEkMlbExuJSRHlQVRQVveGjJODYWx0lTYwRpmO0c/st1TD5UgGiRMCrLPg1QLzTqoR6mRPR+0bG7l+jTYgurrQBQaT7qVjyyIar6peYZWPtxRMRPB0AvFaYFf3Jd9E8axH0MYFebjvFsLpdpE3fBclTgHqFzQ6OwdGtOhIS1dhWPsZ9ufjhy1nvM+kaX7m3Z0qy2erMsuc0Miq0Gdd1rNyzY/9kUJUq9w5kycbNZ+O5OOQ21OtnVlGINm20u2HFG3UrZ0997fGuUSLPg52mS9nY+XuNsYIr75N1Gf1Ry6rPy+mpbZ+JdiExrDj8o019lEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dz7LXC6ifYRumrfx/c/DF9EDP/eh97ck1RW2qek1o+w=;
 b=bAUlI4d3jAao0PR4x/Q6CJfAUBINUn4KUk6mn2xQNwJJZ8okTUhSD2AC99SDMQsdRyct56nz++8b+0qTA821YhyAh5tSJkgjLOr1TKKzRgs5q2l7+bN7rScb9u1/jEKKWngBsmt5onzhkJ4jcUG7sHSBJUG4T6WvK6cGg6MwkxjKw10XJZJRbnp/9DPJKvMGHWZ4S/H1FgUjJsAto0QNrO2IzV2xPmJpy9qRrDZSkvALA0S72VatyElNd8Ddi/guInnQZE7mMQxnGNH4pg92Tzx8WbUj6Qfh7p9E2Z2BgbCSOhCVLw2jkiklW/yyqBev7nzY9n3V21v2/Pf5NTFXIw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 23:25:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 23:25:46 +0000
Date: Mon, 8 Jun 2026 20:25:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: Junxian Huang <huangjunxian6@hisilicon.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	linux-rdma@vger.kernel.org,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Leon Romanovsky <leon@kernel.org>, patches@lists.linux.dev,
	Philip Tsukerman <philiptsukerman@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] RDMA: During rereg_mr ensure that REREG_ACCESS is
 compatible
Message-ID: <20260608232545.GQ1962447@nvidia.com>
References: <0-v1-06fb1a2d6cf5+107-rereg_access_jgg@nvidia.com>
 <22629c63-ca98-4af7-9e3b-480b89be6ce1@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22629c63-ca98-4af7-9e3b-480b89be6ce1@linux.dev>
X-ClientProxiedBy: YT4PR01CA0422.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cffb4a3-2f25-4218-0de7-08dec5b54497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	t3PoCfiSs+QdDpcYtPK1Db4jMAiGZJ/ySKUuQQsuoHB59l54RAXd7zDehjY+s3nILDh28bgGCj/QiAclDFBl6QLXuMqKkdhOYTyGtKZ9K0V8gixUdFzjg9cHD5M8jpH5FuTUhskQKeloQ/TfJv/roHWHjVOIC9gCPupBN+8STLqeYraRGjMhojZAQDVc5a5ACBOr+/2Rg04WMr8+Tdrk3NqrAQY9zbZ/Owsen3etDQUAflahcAK6xuHGqkSoj9G1N7zJ+AZgPMPtopfx71h4jVyzFn7co3ZFcit6Gy8D30+5f3DsVynNeyiAQO9zsuR97zFwyXBeZ/DLlXw8Q+hCwneJ6WrRt0n7VsqzT59Sn5lRkzGo15HZ51n3JEBPMm0xHQo/+HTvR2SP+BHdDwJsgDsC9VWBfiy2itryEnOxd2WW2miRBaaxeGVYLhrT14Vs39ErDjj2xr1Vk2t/xXQc3cMRuUCBLHRRgI/zQ5jmWdvQT1yhAyzpnws/Gs1+dUunO8vp3gd8Y3O0JsL2l3jFl5MMyneBceMSRXFN8Gm/zCDr7ieQHPjK3lKxIRXszkTaytNha7nl9AHikU3ioPKypWoUyXxXMHYSW6gf07Bcb8AqOkP6KQH+50eA8ctM32Il6fnPGP9mw0RZR4w7YNUIT8+qQPVlwnqfCRm73Ik8zQrvhX3Pgoru/gGxWb7kJuac
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uktdh4RR7VZrRy8mHqNU6rABzLLWm9nPw+UBdQuDNDAgGkkwS/Ny9/N5L4GL?=
 =?us-ascii?Q?xB2gkgfGlWynN3P8ryYX7RJhyy2OFWZFYAvlr70gFwZyNguFo/5q8qq5mzCV?=
 =?us-ascii?Q?0a3AmLqQqtVlHkkAQFzT33h5mPITTSAGzbdnHJqsImhJha6JTGGOUgXn93x+?=
 =?us-ascii?Q?11uMKerdrMZApNYYUSH1du0jIq7gbJ0YmFf/OP7jXYrImUhPzluwdtls6qWg?=
 =?us-ascii?Q?nikIuY+KuqgtkG59iJOgKpPFxjm/bejb5fXIL2L1ONbc2J46bps2v1h1g+Cn?=
 =?us-ascii?Q?YLCJUOGreLZUsgv/mo8PCy6slKEDJI99eJLU39wtIwhGHPZKwYnMhR6mZYdo?=
 =?us-ascii?Q?COgPNn7fvPvvEmCJ+udI2KIl6b5uJftdbBgd+FPxWxKi+WnemD0M2OpJnU0B?=
 =?us-ascii?Q?zsktr4rBDXixk2onZDGa4vkj5A9L8iTYSjqNPUJ2Nf3VhFmLWCjoYwZgUWnO?=
 =?us-ascii?Q?7GOQzdI7It6HrDujjTFLN/fJEqzP2SKGebiouvNc1c2txv1lSiS/mL13DTFs?=
 =?us-ascii?Q?fZ0mUrIvHdFoBfhG8Z8wlUzRsDYyplYxBF/y4nBsOm+LhtYRF8ZbndcQb2Se?=
 =?us-ascii?Q?wGr/CZdRY+mtTyaTkQlwYD2kCy9FHEcfGX6aww2HzLxSz/FU6fBB2aQxifX6?=
 =?us-ascii?Q?TApQkeJsW44TMgGNv8b5KPzvoN5J8wB6v7i9WdlNlxJwwmYB7tb1BHZwxbge?=
 =?us-ascii?Q?JieXelUJ1wMU8npyKPjIbD0ie4MtV7T5WG4YHrPc5gbUnJDOvoV7bAp8iqJa?=
 =?us-ascii?Q?5lfDs8nJEmjmDgTNCqdMo1pdyHzTd3aHoFDp1pj3oZieq2tTf+HcwBt9VuWn?=
 =?us-ascii?Q?ZcfNJaG8qYuZnShjSyayFVG/u/MWAdkktF1D7vIwpuyG15NRIDyT9C3VQ89Z?=
 =?us-ascii?Q?+lDTB9YNnOEKrdseYTg4q4NB/Ahv7pNQOxXfww/MXg0GopI7CIxExyrwAOGn?=
 =?us-ascii?Q?QeQIx4E2yd27g9dv0u2a/WfXfoFVY3re+iuygpmjXO4uCZASPFNZZVVfnpSN?=
 =?us-ascii?Q?yzz+fxD+aRmF8owCZZ+YdBr3kfzT80iiIRJ3myBYVh8Qi126GGDaUL7Pk/yo?=
 =?us-ascii?Q?xK1kZ0oLoJQ0wUZqO+PVfZq++Y+CaL+dPNPaCleEhSlif2hgYlwLyRRid1w5?=
 =?us-ascii?Q?CoKj5kSuuDC5W4IfPKegEgZ+T+Y+0/5RQ/ZYCoLyDC/dgdfk8erQVUFgjuTP?=
 =?us-ascii?Q?2PlNu6CB5RTxZTxK8VJHax8Q23c6XmTROpYiQx/KcEcm185sOa0alkaOQYPu?=
 =?us-ascii?Q?CVOxLJilDEyhBqEfAoOHcwllqYKT8f8IOlb5Ak8g2uh6iKCl4BPshrUdSf6x?=
 =?us-ascii?Q?1tuH06vwRa3W0VYOkAKthIy8KD5Nzg3PsdVEJyLQuzcVyntSKnUTQaDF3477?=
 =?us-ascii?Q?ckNm2CkyV0YVhZVIIwQeHOhP44+E1DIucdeAMK/4nYvqBKDvi0K08XJYNggn?=
 =?us-ascii?Q?XWukPIWUx8/NOAiHJoWlXjrFnbhN3wXVsc/BjzaqpJlsiVLsCcQ9DwGHDjY9?=
 =?us-ascii?Q?YwuTBx/HhB8vAOQCVzgX+4JkWYBpXqA9TtNHj7/jdJpUIPqiAlWejJz+aZzI?=
 =?us-ascii?Q?MRkKL5nwjJpeAsrIBFsse+KKyyLVDm8fC1B0SFADd/RKThN5FQlQU9UvVbuB?=
 =?us-ascii?Q?h7z+0fpdjnT9RJG+v2zhS5/VYoOAuoeNtxBJo4WZ0IDYIj2Mamn/MPQCStAO?=
 =?us-ascii?Q?C7pqXjAQTWZzb8geqtQN1WAuZhRhQghLkU5IysxstyMj8jHm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cffb4a3-2f25-4218-0de7-08dec5b54497
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 23:25:46.5176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghoKJaHLkKMoJzRQPQFwZ4ffC77T7zutyH7Lp+Ffv4sAvlF0h/tDsCSkiAyzZkHd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21989-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:huangjunxian6@hisilicon.com,m:krzysztof.czurylo@intel.com,m:linux-rdma@vger.kernel.org,m:tangchengchang@huawei.com,m:tatyana.e.nikolova@intel.com,m:yishaih@nvidia.com,m:zyjzyj2000@gmail.com,m:akpm@linux-foundation.org,m:david@redhat.com,m:leon@kernel.org,m:patches@lists.linux.dev,m:philiptsukerman@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[hisilicon.com,intel.com,vger.kernel.org,huawei.com,nvidia.com,gmail.com,linux-foundation.org,redhat.com,kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FA2565B2AC

On Mon, Jun 08, 2026 at 03:38:32PM -0700, yanjun.zhu wrote:

> But I found the following problem. I am not sure if we fix this problem in
> this commit or file a new commit.

The core code does all of that

Jason

