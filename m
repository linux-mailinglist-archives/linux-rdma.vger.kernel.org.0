Return-Path: <linux-rdma+bounces-21289-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FTUKKigFWprWwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21289-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 15:31:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFB45D6841
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 15:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2D6C3037BA5
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 13:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301E824E4C6;
	Tue, 26 May 2026 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HEZmHIje"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010001.outbound.protection.outlook.com [40.93.198.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F23DE429
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801728; cv=fail; b=o7B357GTnSH1rECE6bpy8CF5yMwrD0zxtwTdt9FHB+V7NaFsP5q2NrjsgflR4HiHwPwyZYijZ2/Ap50RgS+gVYp01FoFsa6JEiktte7YOaIQQnlbpDfFyV8zR1cAdPN4qiEMmt7S/LA60YZ9q8bNR1QLDeSYRTKLpwfegPAmojY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801728; c=relaxed/simple;
	bh=is6WMJG8u7TiWfVssbwqxadfNdFE12mCRFKfIOSRErI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ExKnKRWk5QRLodzSfYVaB4N4yNUfoNHts2zAZ4RXTasnKRIiKz9bhHUZxVLUKOSD/dxw7gg8ka/fJolGMpkYQt4EvYS/ZfLKf+ZqFfRwaQXBDHajSBtJTD+KuTqgOAev+qJHUFDfd7v03nsqVoLqRbLtfzQYP7t8oTE4hkGpDKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HEZmHIje; arc=fail smtp.client-ip=40.93.198.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joLWi9hIp4AceaaiVBfry17aBF3NopxrpP8nRjhP0H2fU7RlhN0s6E6ErZDrngkp97vm8wGHh7Wi0vqfqQOvOC8I+SrkvrxI5x/h1rrUQo68WZcellm0oWRByJySQXzNq/zPEslGmE1R7VonrSdD+x53gtcbLICRk5mr1XUkLiPyD79LMbnhkRINuQB2KdCVK8uF4R0ZSPj9sVfddeywPMwUwJAzr1VE4l/ZxvZXTxtavk44ryalpcjycdilfryrn3aOwvlDJgHxrlP5WakPOIUQl3pX9/i2pCbYT3c6rplXgH8PYQcJxxg/1990ulK9/LAMjkjeFMkYzysYFtFiSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CySETy/D5vKukf0FyKRQssqvP7La4tRPP0gBOuAwak=;
 b=i/vxOCl8LJzJCM2Bl9Vr3HWgm81dV+EUvm+2eLYJ2wZXKmwb4pTxaTTT7PKZiJp/G/gIK/k7zuXgbad3iu5IzWMptyT3NaQ9cPHJFiWWd1dWi1E93siOsatnBaVSx3ffxFTEvdfFzR7tSsQM0GfwrMjVBSSHK5CZnm3y19M2IJlC03ECk16YBYjfWHzGZO9FLXQfNn38AJN1lvleb2gsFgLot75weFnclmAvL5u7M2LFBH2qJwqyaGQNKVIn5Y8uUsTampzwJknLEnoHtNgThwHWOcVSJZNDltRUwhvoHeX5392W+hf5ciI2rWKrlQiguquyxQJgwUk9cAKjuA1F+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CySETy/D5vKukf0FyKRQssqvP7La4tRPP0gBOuAwak=;
 b=HEZmHIjeVrGH5CVZoHhz9tH+P55nPP32YNiUz6QRlvH9sosLgqiCFOFytsrpkBy0y1Oq2Cp0vJdcYy3b/9y5lFDiO/BnKjvm4DtfwqTeFpTiR4EBAMF5lqiHwDKVSor/JHUbouvCbY8StbCadxvjHNHj65O6WoeFUhUjKouIf6CbO55Spo+45vR/cqerbkYPTNkworQUhvB6UdYKPfXNQESCaUt/ZLRCCO4Cap1oIjfvwTcQMNcGJdzliJG+PSWbX9hacTS7sQ+2sX5kXtZEq0eBSDfR194/r4L7RXESdjN8ZoK/0w6WaNm5mgpm0ZjR/EccxQiOJ20Fx2bmWhctrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 13:21:58 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 13:21:58 +0000
Date: Tue, 26 May 2026 10:21:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, patches@lists.linux.dev
Subject: Re: [PATCH v3 0/6] Remove driver dependencies on ib_uverbs.ko
Message-ID: <20260526132156.GA3221769@nvidia.com>
References: <0-v3-43aba1969751+1988-ib_uverbs_support_ko_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v3-43aba1969751+1988-ib_uverbs_support_ko_jgg@nvidia.com>
X-ClientProxiedBy: BN1PR12CA0011.namprd12.prod.outlook.com
 (2603:10b6:408:e1::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f57e60-ffa8-4984-d345-08debb29c356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|6133799003|11063799006|5023799004|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	cE8Z8UoQzl8YqPAPi2ofm4tzyEF7FO+X9qmN6JhhlzN0bDozqv8MV5KStTJNT9lgpWjwFl8l94hkev3wnJr9NrL3PhpfggZNU/UdtkCNfZeMfg3kFYRNRMwJBJZp3tNYfr2yD5iqSVfn/+8+0tGLaRMOrno/A+3An/FSxDn2SbVSVruz3XeNWfUHN+nAHRMZ6SWOZaJOC75gtbuwAY145IC8L9+MnFBKSW5WDN/TL9gbd8kqE5sqazsOrSbxYWoULYBbpnFptHoB+qpb4TWjLIziBiMtlvGLKJuSjkuweBjA8oTop4bjGtfUN9/OWJ6noDAYTPD8EOQVeMLOtw0t5rcM46r/6AvaIWrSrrYIBiYRknA/VVg2ptHkKSfEuwb3hB22KCwBVub3r2eGEvrn+jzynpDsSyDWNhZ2GlPY179Wqvyt8GO0xFmq+BUe/vXSygopbaHtZ6SDrd5GApFqrWjzMqbnBpII/fOhZeg1oAiX1di+7EhUsUHsmL4aF1swr2oj8Gly3JrTbZDMta4CmhETK1eyNF8CXkgEsumaTeZdRofKdzq4oC31o7YlNJfV4+JwohLrsheUs+YGgbM+AhoppIkjp0IBG/XHnCl13uvoLGMyAEY18nf8VA5r52+Sw7tc0sPZZ1oUCKbZ7puSOhCmnJMdHv6v6RzkVWSuTa50/XjsyL/bkJ5aueCbhWIcV/yP+rozp0xeNnjCO396vA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(11063799006)(5023799004)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r+cUnidIcuhKKUN0M3buuDDE9aZrOm+2JM7O/d4o3RLLFlhU2ICb/5CHJwgd?=
 =?us-ascii?Q?zusmfgFD71KXlh/PrtvCn2CZvGrfeiqdauZEaU/sF2F5s5paWD8HRpxKYRsJ?=
 =?us-ascii?Q?cwveUpAE+yt7ERIOBhTW5g3vXkT1XkfPbOf5wLnpVhE51o3ExJaa10Ah63ro?=
 =?us-ascii?Q?vEVXrLFoJXW8xdzNppbvIhr54FcACX7K4g5PUtB08n3faTKMpBSxIkEOgiQu?=
 =?us-ascii?Q?oEUi0SsIyBAblZG8hrrAqOgYolCZMu2pExhHnVd3OF4Y6VtV0NQ21tGyaRuq?=
 =?us-ascii?Q?Oy/fsOsVgPaWUmqfwwzOoKSo5GUB1I10+5g/OSMy7mgM/83DMMW8U+4Ou/dI?=
 =?us-ascii?Q?/GrItgPtkHawMyuRBJQCpbg9G2V/7XCoJULtIqnkITN5gY6RCs5ODLrWfZIB?=
 =?us-ascii?Q?inoqyd5T3yh98o02vjryaGa/OYg6zhfP0lb4ugZVtWTb91MQq2vD5eXmRzei?=
 =?us-ascii?Q?hHVNuqroHXdHKQZDptu+V8TPyy5kh2m3NuFMMIRtlDadae1kRMqDupN3VrTg?=
 =?us-ascii?Q?d1goBxlvtx3ot6kMusPpVBB0g0jrHiiYaA9UyQbhPrKU5zxf3b9M4it8Eqqf?=
 =?us-ascii?Q?pUvNJH3jGjfkTq7ZbXEbIn515VWqL8KhH8YnZoj2hWso7DNiyBhfJi+nzp/9?=
 =?us-ascii?Q?RBR4HB0fbFgzo7PrtRzp4vC8HEdqG4Qg7u6P17ub7O4I1AbxkSz3EksldR9l?=
 =?us-ascii?Q?vfnW8h3UnhQANnP+OlHObiwRCN7018uUywsdtAPhAGNO/11aA5P7azJBkrrS?=
 =?us-ascii?Q?qB6V7i5SH5IfdArEXkgy5zE3DVbTK4T4y4KReqjZMsZPJ7jat68eoTrm1m+f?=
 =?us-ascii?Q?azvzpoatq0+6bGC67KoFamcf8IT+k4Gtn3kCAWWH4MbfvHgigPCEadnWQR+j?=
 =?us-ascii?Q?LCm7QtOCKyRf/gLbGYji3cNSzid8/fI2HGNyXQ8rNVmLcWCofTRCv/3UKZng?=
 =?us-ascii?Q?Ug/ahtUes0mdr0XDwAGSM+Yq9s7HWvJX7/ZSRl/6Z9vFe+yUyBHADYyacgEy?=
 =?us-ascii?Q?FPgaqfUULRedkm9CyX61I+1NZ66zZ9rErgZnjCB73MeRhVZOT3pEFay5xlGO?=
 =?us-ascii?Q?d/3RihDn2AFqmClDRpFjWtImzpG+yqUzJhiGMEeWRBBbEsOk135EehnVytrP?=
 =?us-ascii?Q?V2HjXYN5oJya6sCsp1ftMc4685E0MCLqS7ErC5uLJkzQXChbFLvGiLJJAeaB?=
 =?us-ascii?Q?5RiSQY6RdznZyPMANfe1pqYVuEUeUjBwOdJf4o6zjijtt6/4H1s56ANKZJfY?=
 =?us-ascii?Q?e+yO6PZMCNz1wTdjvq+vpBu1KeGbjfkKHWE4z4Y+T85CDhQ/+jo8rR8YvG9d?=
 =?us-ascii?Q?XNNq+RLUyPhiRAA1YyJEoTTJfRRjmNplmAKvM5OiwKTnH3YSvBrPqJUhsMmA?=
 =?us-ascii?Q?J3vZaynrjGKKZ+FGaxZTCM0o6RURE4Q2xkB25hFxdvLvYZXoYE63IieP1LHY?=
 =?us-ascii?Q?qVeY3saWr/JqDKnb3MJZ8eGDfZYXj2bIM/V7yk8MrqNVyHg+yfNQJ9e/i+Uc?=
 =?us-ascii?Q?yBEqgcNSCx1GxQ0phBj4EtfELN6kKDT4RI4h/pyhKrWjMgHrDYzfLHaTL9r/?=
 =?us-ascii?Q?q8/9z7PhBOk3+6RR+jcrlOqDQS/rVJ/hYj2w7iqRJ0tqLAIaug10f0J5nJKB?=
 =?us-ascii?Q?40gy4XcAanrFk6KbAb86/EZ3wyeUjTpBsndL2eKNf20VKGxJ1VASp5A0mAjs?=
 =?us-ascii?Q?vQjJjhrDgjJhPvQEAfiRyoG5IGvJwGlCjE+UDmUJy76evELb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f57e60-ffa8-4984-d345-08debb29c356
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 13:21:58.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpzXjbrDw3jRmpgo2HuE+lHxWCBbYodxHOimLJIfj/c6NV8yvdNjXBL9ItdUdj26
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TAGGED_FROM(0.00)[bounces-21289-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: EBFB45D6841
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 10:22:36PM -0300, Jason Gunthorpe wrote:
> The original design was for user facing modules like ib_uverbs to be
> independently loadable, if the user didn't want to have those char devs
> then they could block the module.
> 
> This has slowly gotten degraded over time and right now every driver is
> depending on ib_uverbs.ko. Fixup everything except
> rdma_user_mmap_disassociate() in hns by moving code around and adding a
> new module ib_uverbs_support.ko to hold the driver functions without any
> of the uverbs cdev code.
> 
> After this series mlx5_ib and bnxt_re will use ib_uverbs_support.ko.
> 
> v3:
>   - Handle core=y uverbs=m cases using a new kconfig
>   - Remove doubled rdma_user_mmap_disassociate() inline
>   - Add missing _exit
> v2: https://patch.msgid.link/r/0-v2-4a21959414f2+3d7-ib_uverbs_support_ko_jgg@nvidia.com
>   - Rebase on the rc branch
>   - Fix ucaps module mistakes
>   - Add a patch to not build ib_core_uverbs.o without
>     CONFIG_INFINIBAND_USER_ACCESS
> v1: https://patch.msgid.link/r/0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com
> 
> Jason Gunthorpe (6):
>   RDMA/core: Do not compile ib_core_uverbs without USER_ACCESS
>   RDMA/core: Move many of the little EXPORTs from uverbs_ioctl into
>     ib_core_uverbs
>   RDMA/core: Remove uverbs_async_event_release()
>   RDMA/core: Make a new module for the uverbs components needed by
>     drivers
>   RDMA/core: Move ucaps into ib_uverbs_support.ko
>   RDMA/core: Move flow related functions to ib_uverbs_support.ko

Applied to for-next, I fixed the two new minor Sashiko remarks about a stale
comment and a READ_ONCE in uverbs_uobject_fd_release().

Jason

