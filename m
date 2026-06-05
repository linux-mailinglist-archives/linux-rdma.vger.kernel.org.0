Return-Path: <linux-rdma+bounces-21844-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D0YWFNb8ImqKgAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21844-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 18:44:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5163649E17
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 18:44:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=lGexmyfL;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21844-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21844-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7556430D4A22
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411443FFF85;
	Fri,  5 Jun 2026 16:19:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065393B42D4;
	Fri,  5 Jun 2026 16:18:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676341; cv=fail; b=JbgKznasJ3EOJb+znGspUp1gI/qcTM1QhNgR0N5Dwvk/0HCiGY2nl81H/QgUb8H0/V4Q5X5DVClTCCiu9i0RTtZKYCaVVL5gqZe5G/rxK4ZlAVP+pmh9xgz0gpCmGS/8+UbdNTQheDCTy6AEGxXMDDtV3/tZ7eOP6i9y6Jpw8HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676341; c=relaxed/simple;
	bh=dEC5tESL2vf66C3z5lRoreTw9B42/ROOQUaduP0Zvg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AdpAuE6ylrdzYi0r/6lxBj3thoe61d0A7XxEaHhcy6c4pwISyDJwfWr9GdSQ6+yWsvleuLvut0CDFSZ8rA9h8bF4IZTDS5rwYdCU6jRIq+RW4WF11nQmZ0UheC7b6reilOTOhsprIwTa8EGi6Wv9ehV5HGA4Ppv6/vCbEc9EwDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lGexmyfL; arc=fail smtp.client-ip=52.101.43.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtdpHWiKaMO/4587wbICiARCw4/8ihl1i2+uwGJKw3eAp/uGo+5jMOLfnaXpo7AmAsXsJQnC81P/ayhv7E5lDRntzxaeyF1QOb55Sw8USN0ZNK73wd8vQihQe2NvYKiaZnb9RSnEbnjeLhvVQXujUAs1YkDKJkeUVD+TgF2XYcv2kckBS0PSY17XLcfUP4vfeDyjx6LeUeGnRKcgJaqGXUr5ygSY0WJnXznr/2IPzM1Q1dG+WoeCbkcBHxDCwX9l++lsST3WlRof2WZGqUVXECNr403+J4lQkkI+bfR77GRPXU2fpeAodhihYkO6awhaF1A/A35ocdUBh3SuhrlCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3619t1pSZqCtVB6MYH0tSQsF+pMHB4M/DtaLpAiqMWw=;
 b=WzYzsLwuVCR3xtaYfU8/BrcV38xQlqSTr15ZZZuLNXDmQ7KFxFEZzQCdwnd1SSHnEeU6DJoJAp5QPe0RYh98bo7cL4aRNIT6vO2vTmvsALcznV9BYUYNDMVdcuWSfRZ3jjz0nJCjp/LxVdPtlTeKRnhNUEUFGjXV8ocqatGDgQcCKyz5IMgAGDS6h8J7uINl8uYGCO4I5aOyvMTHOFz66YEJXBQE1t5O3vysKE6M3M7QHmOdXzzNfrh/Wsee4uAEM82+E85Qggbhrf7zjcwvn4G750+uBulo24+/rMi8dkeoFwDyDWImaj9P1QfuhzgVNomG26KDFm5jdnD7B4AqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3619t1pSZqCtVB6MYH0tSQsF+pMHB4M/DtaLpAiqMWw=;
 b=lGexmyfLuxljvzGlLkiefm50XQFAokNHeS5y/MdKKar+uhvwzZFGevBTUfcPelzRyNVQWuk4BO7eAh6pQ7JeRxcpPGj+FAMvkEgvYaFAr2DQUDRtN4ngofvscq2fXPy7QAYQZzT+APk7SqmXl4kYo9tm//3N2cKSLJIn1BgsMx30zhukqfkVnECRBFOHzFFMoVptA0n2NseZuNkHSWyk2Yx9BJNow0y70+DJDz7lGrGSNoA8Txf+NOU9o3JC7CkGqOMaX3WsOj97ELQC8g34XLDzHvVwNt+nrW5JaHhwaZAueMhAEpoXQiw3xI6HVAjrGkXgfWnBO3cQapNrnPrxAg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 16:18:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:18:30 +0000
Date: Fri, 5 Jun 2026 13:18:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/isert: reject login PDUs shorter than ISER_HEADERS_LEN
Message-ID: <20260605161828.GA2734548@nvidia.com>
References: <20260602194642.2273217-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602194642.2273217-1-michael.bommarito@gmail.com>
X-ClientProxiedBy: YT4P288CA0072.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 498e7357-369f-4118-c7b3-08dec31e149c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	12c87aoIrEFyaxnI7sc5qPgbw2TsQp4DlZDcieNB9QmzEEWZSlamsEywu49gY0x16U6pofsHVW9yRA42crBRJK7jzsCOlvmO2SOhW3Z3SUYXjzo57ZA1rQzOtZ82Ey9a4pAU+1G6fbe5X/7j81LlagftNRvysi6D8vNwv7ZDBKI41XHvpJblu5COhxwVIU/7LntInYw50cCnQi0pvZY326+pB4KcGYE6ObUG8I2Vfr5/bzW3ytY2t8haD/NLIcC4+z9ybUM6tiHLOPG60VerjYlAS9ER4mPhC/hB60DrV1eGDMKIOeI+giorUGqJZ4XZSUbj0OgYlUX46TPu/fuz+YeCvQKJ0HcRXzgPO/xlaqQP7NqsKDMz0xjjbIO22v7nK8RKVkWiZ2CaoGNn0Ybr8oM2PSMoDjB/LzU/M15oZV21DVGQ2bZEObWPvekraK4+arpjj/K8Cu5Zp5gm7cpzZYhJLcRIUjZXKThkI6RWulkPArkqIXzhJb1h0RaEgZuvcpiSDh/GRtr+lSWlLM91+8OAQstln9qO2rM7oRVz3BC/DiFTm/93IfPkqMtAKwzncAXoB9v8yf7GXtYHhbWhBhyqLas6pdunBKv+XxTIS0elJQ3Pegcd5Q9akv0FM+kd+OZPWtI6MiUuZ+FiQddhunE3C6S4N7d7EXzuih17azgfS5LvojP7VwdYh9wBILK5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ahq1ls0o5PLNSqBRJwFBfZzijGGBZMca8/3om2Za15JcqPXSXb1Sf1qxq/tM?=
 =?us-ascii?Q?cKjh1FUvgqMt/TQ2X5blFU5yosd9v6b+EXRZda5oLCv2Oug0qn0YcMAaWzRo?=
 =?us-ascii?Q?v8jIctzD79FaT4G3PjHCLNlZRa2TOTexfY6PnZgUBAsAKotRAYjMSUvsgKE9?=
 =?us-ascii?Q?XZUFl1ATZvR4QobNNZcjeN59UrJcY4vgy9+iUOXygtR4nynEcIe4yzjX008F?=
 =?us-ascii?Q?OhY6FC4O3bBhfC2eZyb3SpBpJTpBTrc0HkgDbNIBEzLTIFym482X/C/QVqSZ?=
 =?us-ascii?Q?ozONyYwHTBWvyPN3elWj1R1V9bx23wGgHbpHh+OMCQu6tKkCcmoEYpOhvTog?=
 =?us-ascii?Q?KLw8PNTVSXvQSrpCk77+I3uhb5Kfj2rEu9ujkP+jRpg2FnVnKdGmjlcB1m9l?=
 =?us-ascii?Q?6c+zmvI8EIwq2AaHNvFkRPkRkvAbiVcJ2JUQZCEMbje3wcTbbtdAcN8kXQHW?=
 =?us-ascii?Q?LSMUGC8Lh4ixlrqobuu/OEwqqezNSej/S8HsUw+zbAIYqyiK1YqEZHpjDM5j?=
 =?us-ascii?Q?gjBs07pE6MAe9dP9Hgg3Q/lqMrdrfc2tGVmf23QVfzwfqEMVQskRWhLjVCf9?=
 =?us-ascii?Q?lct/aKP9YOsEkrZggWGqM7dz99PzTXrBfwLIELFJfbhBUhgwly3wXJ6ZbLfc?=
 =?us-ascii?Q?cn4VRRh6z5K8S4lF+lx5Y3KwTMgOM0xHqlGvgGyx6WqBUTRKV5OLybf/3A7f?=
 =?us-ascii?Q?N6Xw553K2LIc/21XoulAr1WWb12lcaQmGbl6hYDzoBe5Jyx21ooTHB9sscq9?=
 =?us-ascii?Q?yg9N2NdNEiSSjLUpX5vnL7BM3FF2LjM8MtvTj6AzI+k4SiJqw+IkXUOjYSmP?=
 =?us-ascii?Q?LxBTQvoH3mGEwqbJ9knDDaXWlc+8nYHFzvIW6flbFARxNPWIDqa7R95g8U4s?=
 =?us-ascii?Q?YmGgQi5bo+Yz7U+27FR5sUxitbmH0bin3wCCWw96lb56jx7rpbwR5cDQutP5?=
 =?us-ascii?Q?za1k1AUEzAWZnkPL8xIIo3t/fYm0Xw1O8d0RPsv4TmXW2GHZFGsE3PLYafzh?=
 =?us-ascii?Q?KKaDmDc+QEw9UKySDci/2OI5LOLV+ngvDlfZMDpItkL0uLDVP8su6/wDNSM7?=
 =?us-ascii?Q?AJ840mXSaZ+7Jgb7rpv0+bjeCjwsG53CHkGC10iq1HTu4qv5PMFzMW3sm0DO?=
 =?us-ascii?Q?Xu657W6w1eGgt5c3diqYwRKcHy4iIs89bai44Rauu1fTa4nBJSvDcz0o+ut/?=
 =?us-ascii?Q?0YWAj0HmwCioSipzR8nb/7MIQ2lIZmxAmb5CnK0xy08wc0D/fx4TpCYyCVPk?=
 =?us-ascii?Q?do3/DWnNuUPH/xDJMCboEsNtjpGdNQDuY7SMFK/Xw+OU5coO8vcfrKu+VTw6?=
 =?us-ascii?Q?/umQPxxIijeGwhgSFc221/BpkOX8BqhWuCpSDdFiHLuqTBK1jvDyF1+YaNk5?=
 =?us-ascii?Q?9vU/a1XOsuUeeAjUZf8PeWeFsFBIaAcvujiLxfSVd2nEWb4oXl2yS9yeWmyv?=
 =?us-ascii?Q?rHxSO6/u9HhLpSWKfiIIS8lulQarjZAbdDAIwdmWb4mBoq3sgmlmjmqjMYEE?=
 =?us-ascii?Q?cVflbBh4CBapfGUAmvTOeZxr3zpz5eM9ZtzmUwv2qWYExjVFXJfjaW3HyhAK?=
 =?us-ascii?Q?5aH+bJlDwlcNE99IHpQuOCpMSwCnpIn+2qnvEPnSLmfw2UolGS6htk4lJ1Kk?=
 =?us-ascii?Q?tEe+PSk11u8c4VPBYENXSWCNuLEQQUJSpB4ATh9NXqhy1qc5IDOhb+vPFXoJ?=
 =?us-ascii?Q?CDvCb4FnJyM9SkswC0eSeWhyTtXVgRIldoE9gFa5czBsIQkj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498e7357-369f-4118-c7b3-08dec31e149c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:18:30.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H12MMkp3lRMIF4EI6fqZX9eWpuSGrrEBX6KPsQMbGCwHuiYX4a1niEBBjTFYkb6V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21844-lists,linux-rdma=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:sagi@grimberg.me,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5163649E17

On Tue, Jun 02, 2026 at 03:46:42PM -0400, Michael Bommarito wrote:
> @@ -1383,6 +1383,12 @@ isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc)
>  	ib_dma_sync_single_for_cpu(ib_dev, isert_conn->login_desc->dma_addr,
>  			ISER_RX_SIZE, DMA_FROM_DEVICE);
>  
> +	if (unlikely(wc->byte_len < ISER_HEADERS_LEN)) {
> +		isert_err("login request length %u is too short\n",
> +			  wc->byte_len);
> +		return;

I changed this to isert_dbg() since we don't want pre-auth log DOS
either.. Applied to for-rc

Thanks,
Jason

