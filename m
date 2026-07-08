Return-Path: <linux-rdma+bounces-22899-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t1iMHDtRTmqYKgIAu9opvQ
	(envelope-from <linux-rdma+bounces-22899-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 15:31:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 602F2726D1A
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 15:31:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="nOq/3eOo";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22899-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22899-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50E273002F51
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCA634A773;
	Wed,  8 Jul 2026 13:29:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AAF274FDF
	for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2026 13:28:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517339; cv=fail; b=UD/9XL9PxC1yOWqP1ei74M6CQcYioOXWwFunAklHFyOhTpyC5OnNI6+KC3Ni2qm08XpNGfLNdI95umkq0cYFKjBwD88xRf8DqgL0vboCGswyxwRNi72ktrWYUs3VFKmbFnvzIpBLUSuaCqsx0wUI+mdFdBets6UVD6wLOScm4Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517339; c=relaxed/simple;
	bh=p+JLUF9GyvvTGfpSg9lpp4OQPFNNHCWfJnsr2YzDJWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ev0or8wSRCPC7ab+wRJKvSNzdqqAVpbsiChmRBwozgy7cw+911Ap1080ol0PNy0PUF/nvfxVSsxIsw0kfEKlGCR8MfpsRt53Wiy/IVbxDU1CC9uWwE+6ZeKMH5N7Na5E3cch7f3/l7nG6eklbIrMRSUCFqQsBvzC68G0bZFTvwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nOq/3eOo; arc=fail smtp.client-ip=52.101.57.51
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bagc0CehCZDGhdCle0eNCjr/PjSnPyFKzoMlQ6vLSxoUi6wn9KT09lzCIkm16G+PXalI/wfLdB70jU0ItIPK8gsm2zz+AQXER8XWzgBsjNaznJrghbB4l3O8HP9nTr0OnuLrYTtNMt2uvkp0zq7Hl6CgmD6vOao1HBgBD2NhFno135Xbp6balX1+EAlj60sipgibd5jRD5INgYpu4sSnoRrs/gW6FirEXkO0u8GWBOCynCBUzmKwLRZOc2uVlWKPTdZYESTsrrNec4r9ElwxYLTntzn/9Kq4SjgS+EAJnhGtntLF5sPvuWIZ2rdxucA7yHVXQznpVtkRG1W+Qv8gcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkD2yo3g643Oivlm75mxFwlD6vCE/dUKBO1j2eJopss=;
 b=gnre/3FJp3dT6iqArGJfcDnTQE3Fd/P2+EdeBhtbX05z1eoiqlnauZIPhoZh7GTTGhuDV57yQQPz6zB2J1BUWkOdohJIOOpMrvseIeU7TSLlV3XynUEPGed/cgxTXeAeInSPp5eFFTMvGl5XevtzAGxVYLXUYiWkHXSWk0LvpWFf+0g1PftULF2uN9wo/YbBCS6ngLz9Y9YS0Xxm9lAPXXAEBpOMhZOLP1YydkJDTwOMLzotKneuiDt6TqVEmeHimkoz4eNuAFrxOphy9l9jOgUpgiNTkhK5C0/Kgtml/D1XvEwuZVLiIEMYx9fSzL5cGcQ8DBFTWa0l5A1XQ1Kr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkD2yo3g643Oivlm75mxFwlD6vCE/dUKBO1j2eJopss=;
 b=nOq/3eOoUEwhIbya3rpAk6/roF9///buGwLW1RyIpOWcrnXgjs68f0PC33rv1jxzO0OtP34FaCnoIlkzJLBi1xsztv6jJ/YFAYimKeHe+iszF3Hu+tANWSL9hvN/6TzE0pdbxxbvl7Kjgmw8mihccJwPbzAvb46W7GS4aDkOyBCgbE8/+1JsFgtnexCxFmNO/OcTc/kszN9gDJ4m5F1JuIUNJQSfauKcmBZ73v8otfZWNyp1Qf3+9osuXtxgtc9zILbaCdNNgnWXiRj3Y6YNWTLei/3+zNhs2nge/7Y93PI/dNmkcGF8EDs7KcM53cQRaLU32m0UAFbDqj3Ruhqf8A==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 8 Jul 2026
 13:28:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 13:28:50 +0000
Date: Wed, 8 Jul 2026 10:28:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [Q] RCU usage in infiniband
Message-ID: <20260708132849.GC674038@nvidia.com>
References: <20260708092316.Qb39F_B0@linutronix.de>
 <20260708131727.GB674038@nvidia.com>
 <20260708132105.5c0kDr8S@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708132105.5c0kDr8S@linutronix.de>
X-ClientProxiedBy: MN0P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 43194e17-c843-47a4-281c-08dedcf4d8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|11063799006|4143699003|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	xmD6sJ3YtYv5uRFRRgBrIjq4ZborDXe1mycLyEM9Qyw8h9y1ZWpfljwzca7KD+bMpPLKdr5rfTa7FThXgVAggI1QKq+5EE9X8SNTFiMsV4NlXlnkP49CyeVBjJEscOQzWPzpr97q8Wl7qtSH74kR2HOf4KaNOXzaArD3z9bAO5Uuch/3ZxxWh3jxCaGBa8S4CGcrbxHwdYa6UCy5B85ZaDoxDj53kca5ck44LQFiVDwzW1bVQw2bhpE4LiJ5sxSmVi3PZek5MxvlDo06yXEVoa3Q6ARqwkOf4fq9S6AuMOePdj0Te3erPSy7PRYmkUXnZhgknvE5AUPStl9NwSmi+MfFk/mzcnM4DzfRrpaUU+JOGWEm4HPoF600VPpOw21oSYrVjwZbbPQv/0xmH0SuZSYL24Ka1pqDLof7TVBj37TzijZSvDYhwuDoRjGVXsK15pIflUr/9xv4xV4Hb3QVOqyh1xahRCDR0erJrUYFvobWegekfixlsABa3OYMGIiVOIhV6IBNAwNTBhV+U9Rf37Np5xBJsOgbwnFOzrHZI3GAGnkbUZyyTSZ5ja6MkdKrTkcYFky5gQ6WB8n7JSCmQDlYcdf6T0bsjmzeBjB83fOO/WEk7dI2VrxHqy5L9+xCoITzcWkB44MjPEibqt4pUba0ms936xB4fZ+l2h/RRHQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(11063799006)(4143699003)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8eNkx5mHJnshAmQ7LEeMJ2vS7GoMP4GXGQaEWoWmnmpcApeA+Xt6Mfq5/eQD?=
 =?us-ascii?Q?ZNcHhctwuXaE/v7hwnsy108iQvCV5WAJLRZxgPkuxsusBAQZIZXHZn7aSaN7?=
 =?us-ascii?Q?DYIazHQpjbOTMTpR69klhQvZvHS4ulFg71lV9rka6yGozUfdF6xzIA/AzlNP?=
 =?us-ascii?Q?306F6s8td9/qKiEXvQV0cJRY2Q6/Jp3V5qNXBWiiIlylmq6l8hSpXVUg1eT7?=
 =?us-ascii?Q?D5PEO22RsUphb3kVo72BI4pHdF+ORxFT2MefSxzQBquPyVU7R2rQ40gvV/qJ?=
 =?us-ascii?Q?cO+u1ZllhHn2vP3RaaZyz9bYuwwGDDr1QZaiUSrDefyRW7nyaMJ5fFOHIwHG?=
 =?us-ascii?Q?oLx2gVPt/6lk4Q1wbHAdGO6GmsublZ7+8wC4wJMBIt4UqIKW6UIdftDj0ksG?=
 =?us-ascii?Q?us+ID0CfIEiJkYpJOJ6CV/26D7Xlfmhn4v5DPXmiEWJs6ll9fv2LD9Br7EES?=
 =?us-ascii?Q?p8KB2gEDR7LGDT7SfPsV2rkpvPPTkqvL4XFp/4y27UHApVSFfqZva94zGsOY?=
 =?us-ascii?Q?APlcHEiAQ7yxeY4fS12ISKd5mTrGzkeeJwoWiupTme+qGhr6oXUnlAm3G385?=
 =?us-ascii?Q?oWJpqpeLGfFIkw+vir0lkIAbI5UgZ/hjyYt27WKfN0TMBlPEDO0eJGvM5rOF?=
 =?us-ascii?Q?7THBwZg6Uv88/lNpWJR1aj3DBOFJTvsbmPm+jm8G8bebnEaU/obpJ8/bBcsQ?=
 =?us-ascii?Q?9gj36lIIFMcnL6iNZOf7FOetJY0nTxJAxcjcnqPAxyytGI9D3rinmFCFhnIB?=
 =?us-ascii?Q?vlvzxRhIrsnOXJfOOFKp+BEIYGVbrLMD8Y3tLx3iSKVUoEQB90ELglDrb0er?=
 =?us-ascii?Q?dMBQIuDZfCrqartsE/ZX6nG+FdkTE7WoYNN3MLtuXTRgQPouW8/XGQTbIf3E?=
 =?us-ascii?Q?DXkw/zeRO8cnBp4UhH98Jx2QIt7F9cBGhXi4aPVoU8SubwZ6tb400PbwaVJj?=
 =?us-ascii?Q?TI4891CI+tcZq8okHgWUV9ZeEmAfpAi+AkkV8EUif4M3yxb7RWSqca6dSGUg?=
 =?us-ascii?Q?fCd8D51XfACcf8JfvArPcFNtypmnnOyYaeScB8OxSpgyO34mlLl+r8bMk8cp?=
 =?us-ascii?Q?K496HRdshTHCOgcQ5ySo6/3X2ACajWSadz+7sGBW2L0gt+hWwirgq8TOyQlE?=
 =?us-ascii?Q?NeUzfRCWvIx83b05u99pPzGA7gh/Mm80rK/4MvPUdYX6P9UgYnF6wzOy6y/i?=
 =?us-ascii?Q?nlFrrq/pMfqbOXWq2cdqbflnRU8I08ZYW00/ybjSZEP/9gx0yNC4wOUthWk2?=
 =?us-ascii?Q?6bxLKAWmC/1AkjhFWY5J22d3kX0LxBQ9vlRZOhOQYxjR8LAmAvn3Cmq/pRi/?=
 =?us-ascii?Q?OZwH0kzBNFIniWhQUOeXD2FHtb56azOGzcrmh4E6DB2/x4aDp+lXa8OUI3u9?=
 =?us-ascii?Q?qAOykAGISWfCZiCUJqqDWCCWo97lOEvn3WVdGdB3ARGj2NBSg7kqIf9mS3hS?=
 =?us-ascii?Q?bRCYRF3WwoKsIAjF7hn/30MyY6nLfgytIyb8RYXbN3ADgn9EwTekP+QyFwup?=
 =?us-ascii?Q?s6Sj9yeIZWmc/bglOl3qasq5/RXOyQ1c7/zOPCOo0BBIDgMSySfAQ/FPGGyS?=
 =?us-ascii?Q?7XW8F0eVz0k5ConiMPP+1k5uWNGK4xEeFMbJ6zoiOFYYxoi51kxXFNxSxRkb?=
 =?us-ascii?Q?GDXOosLuE4Kk2scXPAOL+qOEuR1NmQXz3pJc6CJi3IrNgIJqAj1U9JXJy8Uf?=
 =?us-ascii?Q?BD/exUUUHLtxndQJZ2Uu+Xo1kw2WSQz2XEz/jWAhWIwMmryj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43194e17-c843-47a4-281c-08dedcf4d8f5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 13:28:50.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZodCy1v0qRCRAPeLpxlg3yBgBQk8rUyeMLDebRvhQu1ZLiMdbBqNKkrrkZ+F5fT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652
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
	TAGGED_FROM(0.00)[bounces-22899-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:linux-rdma@vger.kernel.org,m:leonro@nvidia.com,m:petr.pavlu@suse.com,m:paulmck@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 602F2726D1A

On Wed, Jul 08, 2026 at 03:21:05PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-07-08 10:17:27 [-0300], Jason Gunthorpe wrote:
> > On Wed, Jul 08, 2026 at 11:23:16AM +0200, Sebastian Andrzej Siewior wrote:
> > > Hi,
> > > 
> > > I've been randomly starting at infiniband code and noticed it uses
> > > call_rcu() with a callback from its module. 
> > > 
> > > | drivers/infiniband/hw/mlx5/devx.c:         call_rcu(&event_sub->rcu, devx_free_subscription);
> > > | drivers/infiniband/ulp/ipoib/ipoib_main.c: call_rcu(&neigh->rcu, ipoib_neigh_reclaim);
> > > 
> > > I don't see synchronize_rcu() and rcu_barrier() there so I've been
> > > asking myself what ensures that the callback completes before module is
> > > gone (via rmmod)? I would expect a rcu_barrier() in
> > > ipoib_cleanup_module() for instance.
> > > 
> > > Is the unload path so "late" that the callbacks run before the module is
> > > unmapped or is there something between the APIs that ensures this?
> > 
> > It wouldn't hurt to have a more explicit unload synchronize call, but
> > there are already some existing ones on the path to unload a module
> > that would cover anyhow
> 
> Where? Within the module core or somewhere within infiniband?

Eg the uverbs path has a srcu synchronize IIRC before allowing the FDs
to close which holds the module as well. But it probably isn't wise to
rely on this

Jason

