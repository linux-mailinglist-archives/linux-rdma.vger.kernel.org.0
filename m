Return-Path: <linux-rdma+bounces-22721-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qgYaA7CrRmpZbQsAu9opvQ
	(envelope-from <linux-rdma+bounces-22721-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:19:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AC86FBEE7
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:19:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=qR1QGPIl;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22721-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22721-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68CFD30786FA
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF7B353A8D;
	Thu,  2 Jul 2026 17:22:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD19234B183
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 17:22:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012973; cv=fail; b=rPeozjGDB5XjM/ohvWFQ2k5kYfIkq8AM861I+SEgu/n6RVYJg3ATJrmysTXceo/z1lh708hQvPoeKwN3FVy85oknZdjl6mIPUiKtei7nZlHx5J11ttf/rcX9rKCuuA7hvepmhpIgcusQ5e/PGEHMqsE5asjtwHBzUAdectN2JCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012973; c=relaxed/simple;
	bh=4mzyHdwiq3NQKbKrrfEdWqbFsnKs25BfONggn0xpteg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LOVA4ROHdKOriCevkJkHQJnFWy8FrBmAwe6b3idONbmbZhplba5uR4TMgTiWVE/qWkZR/JF7ECEt6nxrpR+R+yXtPRVSbexC9LuZekvzbSq3WjN4eiE8XfaTfn4DYfLnKc5n+U2pTUajZoxe1fo0vU9e04sSzc8CAEErE8HfUnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qR1QGPIl; arc=fail smtp.client-ip=52.101.53.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2e1R6FYrnPY3cuxc5s9+L+0t++aGqQVf25YLz+TYjCEA+6uItmLC6hquGMoOL7KTH7QUgR8Dj76uPgl0a7+cYlMDywLZTXkOoE8NSL3zynJnS0h3zrbVZTH6+sh/6yx4oy6z4ZGtDwrWiq6IMY2vHHycGyBym6FlxEda7Gl4NJtvfC4ZZx0aO/UDNcWc0SkBVcjZC3QF7j81kiQzoSP6yK7LNawjoEFskEGE75sGXAQcwhVDTJ1RZRyfG6ukjTozrp+RH3Z2uYlx7qfPWBNOOR2MKl8PqqEUUL4xjAHeaYIvrZd/YILOaSQc/DEkANrcIcEG4ZSst3F74Ql2X5I9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W21q+yKVXaUcGRm55FsOsmkLcG6W3GcB+Awr206dvk=;
 b=rYax0x/xK0bESCsZf/dQ9RFcvBOHjl8oi8CgW5GXFU6BD5+yVgY7vPc12tkixUWFUYZSJH9WHBExMjAxsZYAlRJkRc8JUdjRQbje62Z6uRpfiVnOpDInYNrP5DhclP1O5NlZ2k3qCnc22eVNb9Zu2ZtO0dpvMG0rNT+1LDntl+kRsev+nt1YLcN53K4MTIyPIjCL4bEy+lETHBw2WtXSihykmfAw6XvhpUMmvkw/QqYzPF5i97H22BJ4LxHRrH6mu2w025guGzqs7R05tjr97mzvSfZClK/5EvyJ6UY3Jp9jsATqwGxTRoyK+qTUft0qyAHENHqhVQdHWjyp2UZe3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8W21q+yKVXaUcGRm55FsOsmkLcG6W3GcB+Awr206dvk=;
 b=qR1QGPIlSvFXNYK1GNDN7cbhFQZvMGrCWnXAjGz2RVqR1wLqyeMvVdHchW+Z6OsL7x0kndqJCO7HPhu6CYBxF8g5RnC3DflV/XaaqGQDHJRJiNsJWiyAvppwO2lZe4k9Zgo2uOZaNJu5FTIUWbOuBkblU3YOJgmeiL9wKorcT3urAL8TZUlcDfyxwQghUtwRg1RConxErxwo1OcnOxliUR+vUDMSmBLGyhGVM6l1NfaIUSQeQEacv6ILre0diJjPyuWvWh9sLlB9VMv/KdNHJzfzD+FcR98V4ack1VNmqMjG8tPZTY87vjJzv1qgxyHaRAgIQ63EvqB1oyFtzD3awg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:22:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 17:22:45 +0000
Date: Thu, 2 Jul 2026 14:22:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: leon@kernel.org, edwards@nvidia.com, mbloch@nvidia.com,
	michaelgur@nvidia.com, msanalla@nvidia.com, ohartoov@nvidia.com,
	jiri@resnulli.us, kalesh-anakkur.purayil@broadcom.com,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/core: Fix memory leak in __ib_create_cq() on
 invalid cqe
Message-ID: <20260702172243.GA1507559@nvidia.com>
References: <20260624025949.306783-1-zhaochenguang@kylinos.cn>
 <20260625020148.224537-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625020148.224537-1-zhaochenguang@kylinos.cn>
X-ClientProxiedBy: BN0PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:408:ec::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4c06a1-fb23-44eb-8969-08ded85e87bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	C4R7My7rsitxhPfQjYNDVUkvD8rgRbTSU/mN6TmJMh474u8VGpXK0vgn8wyOYV5yFws6GuvNF719KNXrFRZ4nhwy3+curM5k/W7pINgtTmqt9Uj46ny9r7FTVD5FMAjHTBIBAi0n0rv1fCM+FZE7v2vDTvRQZ+sZ/bSx5lxOx2TekA209M3p7m93Y8KAHqHt+kbrqvhSHpU9+rwLYwI6IXhdaZOtxoiQe4qownzNzMSeZfdUe60dGd2Go+pVtKt7P3wrXKn5b67tFazoCKf2IeKsn7xW8ZjsDrdXxv2JV1i2TqLhH7u5HKCBrFImMoR9DE45JuWJJ1ynV64WGRch/frHXyJtbHXvFAicpJqoqRInCJHwhcz99qwGm7GaAYgpLSoU30ZO8sp+CKfvIYqaMrntZDAqG0Xq0fUpBMnMqEr5bgt9t7BelQZ7bJH2/pcX+R1khr2PWA8g7CtJS/UkepKsa3ePmNZ0emKf11x00JoFfguS4pBGCHB2FjxfL2IehS8ltFxFazA6uZQo6CEKTJarvWFqKo78R2Q2ycyXxwr3syCU5fm+u7ePdXQ+XZTZtSclvt8Prxaq8YPF/fV3if6o7o8y5ViFImbnvehILCovaWSAT9usNMlO7FE1MNfeisCY7+ZoX06US8TcQXYTkZVJ4QtcoXcpCW3M0jdeksQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ClzIQ9QS4Lg85bnNc3Cmx1sGKDzWITDXKphSguTeX8Z9DmqlbfOxB1dCeCEw?=
 =?us-ascii?Q?7GpdzapMCA6r7mfD8V+4FUo/I7WXWJqSZ0GnJK93rQEBQXoLAXmaU5yEVb/a?=
 =?us-ascii?Q?NvZreKd5GQHxEZZn2vZFPr6dkzYs5vf5jJnYjtmip7Xal2UbmYORjZCxsVgD?=
 =?us-ascii?Q?knhKwDC3Jf3lqpb/6Whao1jHWOYn8ZT2k1cBmeptpoqr0Dzt8WPcQYiwvJDn?=
 =?us-ascii?Q?Jjkse3SrBnhMeC8BwiKnb38OpU+Pstj/BCXlhCUE8Eul2PUmM/fATQMjFLJv?=
 =?us-ascii?Q?v7rmc+AXlDVlvvgqRjHXSgdG/Cy7PcLMo+pM4bapRh5KD3UdsJE963d3AO9V?=
 =?us-ascii?Q?1VuMmvZrxyCB2UgncdEdqwWy3OKe6wuNDhlryvAbu0djgmrc9AjLO5ajbITP?=
 =?us-ascii?Q?9GrQC4q+OK/eJcTQ67Tpnt8NXIghcj2jy4lI8x/j/pXIOf/1dsTwqWPE+Hpw?=
 =?us-ascii?Q?9oaqzyr9mDNpGZ80pXhstWaEbKfSpLE6dr8AIENUopDOu2bXDMypUcEKql7S?=
 =?us-ascii?Q?IYqLHTWHHxYTLsM8m+BzJiZSKQ1ZvkQZFtfnEvbQWjBk1dU/Q9dWcTGiHZTl?=
 =?us-ascii?Q?3Cq55HV64syfLWnCgCUDGNlabaYJXPFxwqCC6rzUgafU2/tfDMX6TzgdKyyh?=
 =?us-ascii?Q?bYZru4RS95A/kaqX6ATHd2Zyg020tLQmyL3JIbmkWl7e33ltZITiS65UgHfi?=
 =?us-ascii?Q?tkYngzgFQCoyrDTkMgGCEp2+oaxVz7UMyj45vxCI5uRLBr1DY0RHEkbUebbZ?=
 =?us-ascii?Q?TZy2EfPKs8od2avKL8fat7E97x1PK3ObeRdDJOjoG3yN4La+JNDnEyoQRR5T?=
 =?us-ascii?Q?mJwXqXw+Io8vkpfnPDtglPLqfAjB0HthKL53x6YKhOSC3r8rd8saQ/d7na/H?=
 =?us-ascii?Q?eoz2nl01+FJsFX3MWrT3WMkOTwSgyGUipE1n6a9u3VSNv/cqhzDHWo9aIwjS?=
 =?us-ascii?Q?5V60/H0XJBJT2J8Id8bAshfQB+nTbRtR7MERrFp4EPD/xdtoBwbSuM9v3/ap?=
 =?us-ascii?Q?sT7vDSbhUpfmuTR1EXJDIU9/WRSA3Ffb2BL5VFbB5O91c/bsBNFufxsCqhUK?=
 =?us-ascii?Q?qR02mPNP2zoIYroFi1AwR0yjyP+TCIz1NRZ3codhUxCY5HZo1WhlyZAC36nZ?=
 =?us-ascii?Q?KJLlhs1bMSbQwjLbGxmBEvGRWDEJckoFmVG3W9vxGSbiZdEFFRG89aOX+qB1?=
 =?us-ascii?Q?llzRwj78sGWcuMyg9KJp0zWXpcLa3BDWrKVlyldb+Ab19U3vj3toEdtEURyR?=
 =?us-ascii?Q?ET0O4b6J0s4D8WuO1UAHBfD06EARBEqVUs7Kiralne3fp28v4LoQLFOkV734?=
 =?us-ascii?Q?UAtlIIgR7Qmf6k85WNH8IgFKYRUZJrsEnONpKJnU0lKoOWy28t4YD+1toGWu?=
 =?us-ascii?Q?lTBL78YwAvxx92+NPQYDHYEziRxiVpZxZt/WVQKGX/0GV8oNiZLlyxlCyhhO?=
 =?us-ascii?Q?kBAB+oL7nRVDSZCCYZVpMwKo2wAA6lpvnkwfjF+0gQ24+hSwFIB2vs5KVXzD?=
 =?us-ascii?Q?AZYxUq93It0e4KgDUZenUtwiNXL+cwE3186ljdaT2mYlP2VLHAlEH/fDJql7?=
 =?us-ascii?Q?EAZd4YAmHQe/pUswiRu2GoAzyXGsLiVBmG6AcYYTB9TZ0b3Vvbhd7OFL03ab?=
 =?us-ascii?Q?yTfjPtwhx+8mbrsyzD8xsSBpH3hY28swKQgOXQzGbQfmJEkPvy/DA0m1jYix?=
 =?us-ascii?Q?f4UeqcNl05ttfHDa6DHcf6uk+oIBafleoREzjj3TeQvNt1mA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4c06a1-fb23-44eb-8969-08ded85e87bc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:22:45.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Y2YreTHGiipk2rk3ojNRVKVwtguIgk5RyEMnqv3HMmnuhB+2d7Du5X4WnipT46G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22721-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaochenguang@kylinos.cn,m:leon@kernel.org,m:edwards@nvidia.com,m:mbloch@nvidia.com,m:michaelgur@nvidia.com,m:msanalla@nvidia.com,m:ohartoov@nvidia.com,m:jiri@resnulli.us,m:kalesh-anakkur.purayil@broadcom.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,nvidia.com:mid,nvidia.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,vger.kernel.org:from_smtp,broadcom.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08AC86FBEE7

On Thu, Jun 25, 2026 at 10:01:48AM +0800, Chenguang Zhao wrote:
> Move the zero CQE validation before rdma_zalloc_drv_obj() to avoid
> leaking the CQ object when returning -EINVAL.
> 
> Fixes: a2917582887a ("RDMA/core: Reject zero CQE count")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
> v2:
>  - move validation before rdma_zalloc_drv_obj() as suggested by Kalesh.
> ---
>  drivers/infiniband/core/verbs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to for-rc, thanks

Jason

