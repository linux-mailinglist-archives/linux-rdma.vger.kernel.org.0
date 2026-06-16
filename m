Return-Path: <linux-rdma+bounces-22279-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2pp2AqhnMWpOigUAu9opvQ
	(envelope-from <linux-rdma+bounces-22279-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 17:11:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83960690D0D
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 17:11:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=WjVZBGdn;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22279-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22279-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D9D432348F1
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749AD1D7995;
	Tue, 16 Jun 2026 15:05:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA236F42B
	for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2026 15:05:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622302; cv=fail; b=A2d1e1SnWqowM1zlpKzkvSL3VLQvGwF4z2V+6uCKGHZOjkrgZbBiHzrsdajzoYhqsuHEMIJqXY8FJek0AWnrjgrTQw9mZ5NzC1bLSLSP5Ye2VPCDPIX4CIyhV0jGEfai4H2PH+dhoWlt6nYAmeX83N0sZ6XhyJ+Nzzn+ELNHOvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622302; c=relaxed/simple;
	bh=olQe5i+RakHuFp1YVpvVt2PKdg9mGG5I+77b58ySSFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gzdF/BfWRViLYvRvtCwDdVqCP4PKi8237SGWqNeJls1XeED5eRACWvmcVEc3XD5ZMHS/Way9fVjufcw9iM4cTno6miDAWi1xY5rDWAo8pXwtq55fbr+gHBR4qI9NoFcIWr1Z/0NQ12evoNiGZGDv1bTO29PDxwMHK42CbrUgQnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WjVZBGdn; arc=fail smtp.client-ip=52.101.62.32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngusFr3kjPRHq09YLbjuISQuw0szm5cag/Dr+eQzUTJu5NrFjQIKAcpNNgZcDbw6B6GRsjeTxj9gCWqRLU3GkpM/1tC/IrsO7AoM6PZWA3mTi89MGHPWIzgh3npN2tzuU1ZErnLVI7sy5uEwJ4TcgCAecpA2Tj2JokIc4e58gA6liDni5rIzoYhNTDP11DWbagqtnyOOhX8NzGMnNqpLN5S1u+OjkjbbLRa9Xl3urgZSR55Uj8tNEtRbYOVfHoOEFsxuVbgQvMResNl1/iac1g2nX1vgcoNzffqBiIGRhYKxi8ycrXk8lXKge1CbxPrf6V59H+ndDSjAhte+eGWqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olQe5i+RakHuFp1YVpvVt2PKdg9mGG5I+77b58ySSFs=;
 b=imXA1yFIg/wrpMygKUGKXVARnyOEN+Im8yNxFzvwkU9pHpLQ3bU4+uxhYa/1EZCmKsAgFVH1FVi2kx3NmmBDuU0jgGf23ucVUP+blCn90lW5hQUG8jL3RT/drXd3+PEWyXrMXaMJwRPdl99fPcjfgXkLNUIqqxH8Oe8DAE4xs9whtGmey1gQ9Rusm/FJmNNVXjnFeUpwQV+7ULYnfQQyp8J1V6U48IixnumWLSQStUkiN0dnteWjfJgNCOJpSphJ/5ljWtLOkYY3Oy4Mvz8MfykUEMCawmmFmCKYMT4WCk5yRsV1VOXcjIKP9bu8gscVqyLz/H4lL/V3sHzMtHQmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olQe5i+RakHuFp1YVpvVt2PKdg9mGG5I+77b58ySSFs=;
 b=WjVZBGdnxPkzWrLrcRVchsZVNQEiAEIVQzrMNe1WEz1VpG/g3aiqmptLXlTcx76JfeSsA0G2+7rrvVGkb1Ec1SVAzXW/P0gtFjzcQNG336GIYfpt/nt7Cc1iyT9FneHoee4wugkZXOLunQdqAJCu75IzFSF1w+mDHktsNb7l2P9lmANI5T2ZF2kAuuXGykekssaTrq+mVjV449bJVTMrUJZQEs1axiPgpcLMCdurWTiz2STmMjWzskLD+AMFubuCmWRRwgbB6jcQBeBSxdnFBQPFxsuAYV05MiXhluSrkuM1WvX7umIA0imBIjwuO2Uv2jca1nw2hhMacQv9gtNWZA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH1PR12MB9671.namprd12.prod.outlook.com (2603:10b6:610:2b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Tue, 16 Jun
 2026 15:04:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 15:04:55 +0000
Date: Tue, 16 Jun 2026 12:04:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com
Subject: Re: [PATCH rdma-rc v2 06/15] RDMA/bnxt_re: Add ownership check while
 getting the CQ toggle page
Message-ID: <20260616150454.GB3885854@nvidia.com>
References: <20260615224751.232802-1-selvin.xavier@broadcom.com>
 <20260615224751.232802-7-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615224751.232802-7-selvin.xavier@broadcom.com>
X-ClientProxiedBy: MN0PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:208:530::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH1PR12MB9671:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d5e2b4-fea5-41eb-f5de-08decbb89fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|4143699003|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	7C+ZzAAP4yTnwldDq3i0krl/UDLQg3gDT4EbsbQWy0jxsAYS7zhzd0wG8u16enxU6qdLS5heRlN2RognSHd9R31YwLrWMr+bISZSVJZ0HTTBpSavTma6fwL+W+JlEDyWStkFg0W3sUnh8h1N9NOz6dH8FsKf2sRrevutqOsmN/o0lgpsZuA1b6e/7I4ViPRRHBtjyqu7GgiqBh3pfAnuAMZ4NSCJYamd6WqdtwiW7dQpMG6AMrFmPBG6kZi5P4ihtV39TcEr42U3rkE453szHOiLM2M+MLbYvvwAAm9NCJ8HZOvvGa8AaLsHhmONibYEGDvaJjGYOC5X4XPmpvAgc6Z+L/9khOJsutcZOuqlrRQ0/8E4K1t8KcnI20Yiqg717y7xZOkwpjZwdLnusqsQPG9nsDMZv2KBUynKIeMkhgwSZiqjD32O0sF0tfzRQdKtSDKVIieNDNhUCd5Qiz8XfSekvuCISeRT9lNElWCtLvNhDkbxW2F+gMAT6d8TKhPbWGSYoxI9N2uF891f9hZRR8ncVnLPSWre7yHllPMY8+AR+iMNxs8Q5RljJMJdAo5Cn3QWY9mD90+Grq6vgcwzkV5onWR9HKKXi0hj6IRVXT4Oaozv9IGDXOSiT2xbj/rcMwVXaJPqBMj5xNRDGHzyZ0WiKvSM6OiAkW6NCDkzc0jFuopXctrQeM6puthf1cPP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ErClwGq2RcLc8mMuiWmAn6hMAqPji10Rb7ANew+/pRAANCHpQAe+KFuTUNcR?=
 =?us-ascii?Q?HIY6UOn3BZ2XUfhrqCBuB4y+xyl6cFCNobsuRkIskBsFbuSoGOnoJ41zOd6w?=
 =?us-ascii?Q?57BHDVI1OufGdWrttdQoEyy3O7R5JoADuCeYdt/RQRkSz7MgdbkOj/dSPAui?=
 =?us-ascii?Q?jMTO3lKKyyg7XOtVlJ8VHJmA/UVmugS1bzYbS6XfaBR2FkgIOsZjmmaXTBdp?=
 =?us-ascii?Q?WsZxNI29juE3+BYp7sY11SL9Xuhpnee+YQjY5APwN/NAxrBUf8VDqjrQaxKD?=
 =?us-ascii?Q?AiWwsArpypbmiaVE3P8OdtGJvzNpeW8GxGJ/UxdiRl7GWKF0Y9pyYCeUoncq?=
 =?us-ascii?Q?Qz2rR9Glx+egWHOsERof8TNN12M3vRcvLEMJVjnIx8/lQapJ/nhl538R10Kn?=
 =?us-ascii?Q?zIRHvJ2V2tmpBozPe3Nn3XwlftPfnmCbBH/jvA+1UwwsxQBJY4PPt98xtcK5?=
 =?us-ascii?Q?0wAVB4+ZrSIMhKmQOnTuOYC8UbGpk2V3rx9Mh/7lBJqY9PbjbJRKfj+sdar6?=
 =?us-ascii?Q?oVMqK7Puczrhghw+orx4iNYmknjKs7xp8ve+4UuUIqA9y+Q1JlRxLT/L1uuw?=
 =?us-ascii?Q?3iVZmujF0UbigmqRi7NMa9+AXciAu1KVk8XlD4qkmIbi0ypPci1xbfBYxIJ5?=
 =?us-ascii?Q?EMayy7dHVgkaP3l+uLUFIMvWk+pg96o4sJcc/e+u3bc7sN1DnYuDA8fsABFC?=
 =?us-ascii?Q?6cOFsdChxwcf6+2oDYXYCoakbB4kmBxgQAlw9AtK4n0kj/szUBz2bDFbTyE3?=
 =?us-ascii?Q?ueEUlHDNS4MayG+uFcsRsp7PQAS1bjQsym/BPx8wfpmvaDTQd7GCQIr40CMN?=
 =?us-ascii?Q?ASFH12sXnLWqaQT47Bs8AXfdmJxgXFCLvxlmcu6635xrxLJ2DHk6xM0UJOhw?=
 =?us-ascii?Q?QkZgNgpPZtRryCc/XJZnSRTSlrB9kzytXrCUEhD6eELT0IfqvvsZbkQx1luG?=
 =?us-ascii?Q?n4k1WKswxUhZgivUYqYS/wae8MfrnBLmZPJVtTi+gxfxcfW5AYkZCFCEAiOI?=
 =?us-ascii?Q?8KZ5PIql/FULaEzZpshdx4E2sna4Ap3sdurdLOLya5WpIMx86n/7zcG1j7yl?=
 =?us-ascii?Q?dfw2hXeYyn/1sQo5x4BE1btRXvDZhrUl9Wso5eR7HuE1U2NgTKydKNmi8ARp?=
 =?us-ascii?Q?YIiH61/Wu5PUMo/YLOCmOijV60Qh4ko6Ed8a/CKDkykDzb0wiRe1hHW095Vc?=
 =?us-ascii?Q?bLewP+bPE0saOP1yHF6Myj8mznWr28opNBbcfzOXb5WheRYxmGL1dHyT+lR4?=
 =?us-ascii?Q?7DWgqMQ7dhMfADjHZDGFZfgAnNtY4IkrFOrfybSOB5FmfUh0Mp9UEyDxie0C?=
 =?us-ascii?Q?cgmQtWOJ1Qx0z4XMPik04kQfvDQ81jrWfpwSXiVCykO1lMJzZHIvfAOpqJVI?=
 =?us-ascii?Q?ZPaKVL6f+y8nCK5a3+myNf2KQGgftqwiJkWnRqnKjjb99RA4l27eh7aWJeCI?=
 =?us-ascii?Q?DNrZm+i147iTLee8WOboouydfBTgGCQvp9vrsztQtlkfdJIJxMw24FxNwpcM?=
 =?us-ascii?Q?r1aXyVHOcz17unjrmlsfd/SN/+Oaida1Xgvu2fK95O/znCc279yQtW0n7pBr?=
 =?us-ascii?Q?96j1hIurlqZw9f1HtFLCDBUOENuJh6I+1Zx6xDfwn8Bj3hhBKgR+jA9zv9QH?=
 =?us-ascii?Q?Rw4KWn2V3irzE+qYmveKXj9tkAe/7X2BucpNSrizGiFf2q/PXSkus1MEUaAH?=
 =?us-ascii?Q?lEBU2oiKFDD1pFuTSYOwR9/p1e0su/RVSrjLzBVQ2fuZYg94?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d5e2b4-fea5-41eb-f5de-08decbb89fe6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 15:04:55.2078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZTj9YaIaTY9RlXrbMBDlRoCnK0eyDqDvYzRLDd5EfixYNeRQNdw8CAXtLullWHS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9671
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22279-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:selvin.xavier@broadcom.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83960690D0D

On Mon, Jun 15, 2026 at 03:47:42PM -0700, Selvin Xavier wrote:
> The cq resource id provided by user-space is used for
> searching the driver CQ structure. Validate if the context
> currently issuing the request is same as the context
> created the resource.

Hah, just like I said - again fix it by using uobjects correctly, not
adding more junk into the driver.

Jason

