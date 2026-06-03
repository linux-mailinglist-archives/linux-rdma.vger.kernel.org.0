Return-Path: <linux-rdma+bounces-21702-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /JYrEepwIGoQ3gAAu9opvQ
	(envelope-from <linux-rdma+bounces-21702-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 20:22:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6833063A83B
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 20:22:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=GGMsj8MH;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21702-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21702-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB50F30B03C9
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 18:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D6B3DB339;
	Wed,  3 Jun 2026 18:16:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C436379979;
	Wed,  3 Jun 2026 18:16:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510570; cv=fail; b=GqVHtHS+3fSS+zuW9vbbR4y8+w4gpN8NrgWfYORJtQ0qEZfOaRx/hd/LnuED/wvteBCQ/OzCkMwHZT5DXhD6d+qSs6d2qeSpMI6byvXa1aJzPyQy7frtZTKWbH9NjOcfqwoHEvBXnkyfuckNv9LfQ33bO9Pwnohqk/AMuqGbXcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510570; c=relaxed/simple;
	bh=kTasd+riWLlA53rzP0V7p8CgA02Lwe3FbpNlajdt1y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=huLJ3dRvuWCulr0RLJD75PX8E3Fc7Qlmuy8zNRsjULxtYwjfpp3UYLzfy0NPaJeDe2YRO32ObDSXi/q9R/G22FLj42vkZbmcz0d1/ohGwEG2BRlgv02jigPoH96oQHIE7sCqqefmkgy//4k3AxYmESXsMfu4O8D4Uf505klXgvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GGMsj8MH; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsfomjkgwHHzLUfSaxImRv/2F6/d+Gs3zrcWCkBTptvNqJl+ehWgCyecmzdJXEiRxIbPvi1UwidtBmKvTXFQXG99UFKpg3XL5Jmvn00CjBAYffUfXjc+K0QdbekcETc/KxImUhugSDAjLvZWk1swaSITh6mge+qEVJeAy/58L6gJUfxYA8vSBcaukqpkd4bsUCWdu/0tsLQtOCe6URZhBzkDkY9tDatEjzoAE7Mb43MuUHWEK7N0a/E4ybog3cG2u4mUgEdi2qUYKREt+I0TYBqDnYl2sidoOHpKPANlQIdBbYE/hg/1DyO5Jdh9nBCJUTF403bDT2gtIZN2zHVDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmXDY2uJ8qYv9rGyVUqFL+C0JAzRG8ZZq1suRG5hXt4=;
 b=kUy3XL6qoCPvD8B9WR7UFXnInDDgFRi8La3W4aEjz8UGtunM+yHOMDR/KkSJNaRHFzJ26RcQ1IdWjq8JOr9Unl6lCeUedT0R5G6M/t+Dx6hFuvGGDHoQd2jzCTYqeamsQsU0XxzJcT7KEmTgI8KjN043eqNOdGFkpG+4NmEdNYZhb3kDMiC8OLLcx9xTNGPITn2F9kZ4O+Cx9d0o36I2ET93En5R/jNiB32g1S2gvUHxjIVqb8vlfl5rFCTPkor/FJPkrZ8zbtHZa+QcSt+W7HHWrbLGGb3hP3rv0GR6T46kWtFQLjThKnjM0JTH9pqWOyX3zPUZoW0xmOia3OllZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmXDY2uJ8qYv9rGyVUqFL+C0JAzRG8ZZq1suRG5hXt4=;
 b=GGMsj8MHqW8LonyUCDRXRx3NIXGv/ACKlJ5IG1ZjYga1uv6MfiDOkFiGH6wglY36/O2mk4SU+JC+N13G1jdRd5BLwcaHmg1JdmApgN5B0Q4KGMJ3H5FO4q/2Ee34M1B2zGrqh7h4K5gd2yqdcrGlmValW1o3RyTtUStdonmoO5wgDSpv2xUyRVl+Vp0lAB9+eC/AkOY9zjr1rS4FwXeJ2Bb07gI/fWxa4OE4prxQfcrL6ZziL4v7ZPmpqvaaPUiTRM2bHWlkwlJSKaewGhJLk5XEWq5gA+axR2dUwgxMOUymODHAduaS8oEzuq4kGFPLpxsno1vqtfhVuAvUd0JpLQ==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 18:16:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 18:16:03 +0000
Date: Wed, 3 Jun 2026 15:16:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/hns: drop dead empty check in setup_root_hem()
Message-ID: <20260603181602.GA1568873@nvidia.com>
References: <20260521132045.3430906-1-maoyixie.tju@gmail.com>
 <20260526054653.2054800-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526054653.2054800-1-maoyixie.tju@gmail.com>
X-ClientProxiedBy: MN2PR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:208:23d::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8e11e0-834e-4e7f-a8da-08dec19c2c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	YKt+gqCsOQtl5yEi11vLAlJoE0TqZ+3pl8Tr4b5R9VyCDt2ZrNx1Gca3u+KKIWTTYzePIfnZhCpPkOCidmDYEMINyDxdNAWmCDlSKNy6aPjgqNOQPOb7/eob9TsST1yLyHFy4cB5vwqLCENq1Mhw/18mGijDQLzRd5R7EG2H/QICXA64a0FkgWWG4ZEGOomGlscbrYjt99y1DmWP5gwqxhtOBYjIQEXTYbhAzj0VIxsDoU/gx51lEAWxtqfE8QfCEfOajJMC6DHHSkwe9TxBIxMLFw75bq60G/0vb/QrcT9UB98kRVl68A12likVKYiIWsv7OVNS5ZuZk1QXWnOWbnAbnEAYMCgvhy/0OroAr8EV3Fw/kQbD3NM7JTio8BH2BDOG10eH5MR7xNmRFS5pld1Xvcv2xOXzWhcWx0feNJiSMA17P5vhw0Ez/aAzNXA/zx8gq5mMnSIwGmNewQ9y6gx7fPkiE9SNhn72RmdgUGZGtchV3496DDtJozdMOHcVZGeCwSrYVokwAG4kxGNY2oDXg6Neubx7geXPnLhnSwgOTbOqKuSTWTAfSeJzslhAE04kkyFf7W5AwvvVI7CT5drsXtIbKTN3fmZNifvBsCl34V0ulhVnCpNk+bxmxig2pBy0qd+ZbKXCEKoRMlyRKnqzcoPw1kViPHOlI/VMKcnmWiU32h74kajMdp8k7fTF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lFMizaSWcYI7/BJ09aJJZGwZ+GmF29bQnl13kq7tNwFpz6URWHx1V7KAFGhl?=
 =?us-ascii?Q?ljSW6jjBojMO7OTaSZzrIEU9i04K9VaksuA85JIU1I0VB+Ogpxvwdw5fwl6D?=
 =?us-ascii?Q?M6EQs4DM+tm38MDs4ONaFll6s5muub4WBMerXrEah2KYRmZmTCktcxFTOXvr?=
 =?us-ascii?Q?eCExAMa1RhHU7hPaI8YE8zOYg7fxIqtaTAqLX/sw6JR2cmDGnRKrLT2F8svL?=
 =?us-ascii?Q?TVBD4KhFCb6/VSLMF1p1Eeoxa0ilzyI5eGerfRrw1F5hBLl+sSnZYJYbkk1d?=
 =?us-ascii?Q?Rz710xeEWPkdh3x9KwG6m2ziHAfjMkmNTgLq3PBSmPdXh+oFdIQ5+tCpnvPs?=
 =?us-ascii?Q?4C7AxCvHWIU1BJJ5V4AgQfL4ebsNEPw7bWSFiieSC+oikdd2u/fw0jEwr8um?=
 =?us-ascii?Q?ex4iyQcRFuRWk0RVxla1bcUDmkf0HtbzQUxm7jGgQbT7rNreYrF9X/jYmHnN?=
 =?us-ascii?Q?MQvq6dCXdnwG8m1u1Qr4rnPykKAQ3RGJN2kmwIKO/LoLngog3aE9lWqzIBob?=
 =?us-ascii?Q?oBRZc2U/P038t9oa27LrmGWhUjTwGb7NSctzIN7fMMOnTCMxeHd7ErZdMLBn?=
 =?us-ascii?Q?DK0r0Afy+/51/svy9i5V5Oum73ja5ZJ71nMXLP3At5H8J+0XGU4R/S9S97Gl?=
 =?us-ascii?Q?B3NiZslvA12oTlMiqpqYxtr1+cquMocHA4KBDTgG8wrCX3WfplySHm3Nw0yH?=
 =?us-ascii?Q?/rHVAwBULKaufIBAKerZREjHIo/6rrSqBEUWbYfSo0cvdXlgC+SjODxegEIW?=
 =?us-ascii?Q?HXvR0g4XyPgranLCcC+xG/lTcGQQepaBbwQljJ1P4nYZEgStfSrJ6SQ1iVJu?=
 =?us-ascii?Q?ol7nra50EdqhYAkj7EA5SW/niKmTa0oyWVPbFoD7lhZxpe6GbQLyYe3yiEFk?=
 =?us-ascii?Q?l2opkwEQk5HJlGKSDC/tZfBDDde10QS1HLYgCANEjtaspE5PSKSoWsdKadUD?=
 =?us-ascii?Q?i0RJqLMMlYURh8d8vXJ85xrM+mmJdTfG3NJPPS6WMKKi66JzyQNlwStObnn8?=
 =?us-ascii?Q?WWd5e99a85engY5PQcO+uG6b1TgeA2i8Ky7vB/eYppJXowv0mrJniIsHxzbp?=
 =?us-ascii?Q?Q/BRsBS9p3R7abAJm4Np07s7J/5LeIgvtWq6nutfprkqP0+aCoxe+wRW6p7T?=
 =?us-ascii?Q?iOnRacmMCXkRjNuFP7aaW8IAYMJAW99xXbSKa5t2smgRAaDOKYFLTXMzciQ9?=
 =?us-ascii?Q?bPzfT7ODZha1E9kayhDy5T32sxX6l2os+gsLLCduaMfvKox42+aP8lwsaT+4?=
 =?us-ascii?Q?gNHHeLlGVfrk8/Xq5N/gS1LQtVOxKn1b7DfnPPVhFhaxCohvvGEH2HU8mBt4?=
 =?us-ascii?Q?NiJ0HR7iLoFklHwbBx3HfCZ4wulSeT10OBaxw7ncsXF/y6ONNY7ympmEeWRD?=
 =?us-ascii?Q?q4yQ9m2f720DDZIe1a1yA3hWawLxjtQtomRsVoVtjclg3Xas5fSYhQzNNxNj?=
 =?us-ascii?Q?QbpUH8Pm5SAH0oXNtE58mnNsKLDqroAuGXDFQCI6eqbfwzNlkKtZo6tg8Ybi?=
 =?us-ascii?Q?0pGLepFoUydTwj4pcXOD2tAVnxRSz8Q/nqPkXlK137hKhvB5XPJOg7hLolS1?=
 =?us-ascii?Q?6vqihwKkbUR7QfNoUNF5QPy56opyZdcSywoqP06bVquoAW1cmaUmyvKDd9Nm?=
 =?us-ascii?Q?fmyPELj3LvNDOKyxtz1NAsx4irF5KfzBaxHEw0q6iXuffrLyB1nqqvC1dl9E?=
 =?us-ascii?Q?qsuEf2cRqK82XfIfXy69RzOfEB8bSw3RxKQnWEdMPZ7lekWQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8e11e0-834e-4e7f-a8da-08dec19c2c69
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 18:16:03.9301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 737+n6p+HB7YSrChpSmRWp6mY7EOsKMfDEzu5bTjV+w1oq5YTtESVsBxl4GTg3jv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21702-lists,linux-rdma=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:tangchengchang@huawei.com,m:huangjunxian6@hisilicon.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6833063A83B

On Tue, May 26, 2026 at 01:46:53PM +0800, Maoyi Xie wrote:
> setup_root_hem() reads the first entry of head->root and checks
> the returned pointer against NULL:
> 
>     root_hem = list_first_entry(&head->root,
>                                 struct hns_roce_hem_item, list);
>     if (!root_hem)
>         return -ENOMEM;
> 
> list_first_entry() never returns NULL. On an empty list it returns
> container_of(head, ..., list), a non-NULL garbage pointer that
> aliases the head. So the check is dead.
> 
> The only caller adds an entry to head.root right before invoking
> setup_root_hem():
> 
>     list_add(&root_hem->list, &head.root);
>     ret = setup_root_hem(..., &head, ...);
> 
> So head.root is guaranteed non-empty on entry. Drop the check.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
> v2: drop the check entirely per Jason's review, instead of
>     converting to list_first_entry_or_null() as in v1.
> v1: https://lore.kernel.org/r/20260521132045.3430906-1-maoyixie.tju@gmail.com
> 
>  drivers/infiniband/hw/hns/hns_roce_hem.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-next, thanks

Jason

