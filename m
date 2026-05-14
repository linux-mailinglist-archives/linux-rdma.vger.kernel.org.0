Return-Path: <linux-rdma+bounces-20730-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIw9MMkcBmpDewIAu9opvQ
	(envelope-from <linux-rdma+bounces-20730-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 21:04:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCB2546281
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 21:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECC7730534E2
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 19:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3461B13AD26;
	Thu, 14 May 2026 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BucN69rl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984923A0EA6;
	Thu, 14 May 2026 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785441; cv=fail; b=EwaOv4g0s54b7w+3jvcxWdydyXGny6z8aDkdcmaNoYrMHjECuRIQYbb4i+cCs2Fi6ADlvWrTW/NkX9qW1a3+zZgs6N7EI2Bm+iLyurhOTbPC6FV7T1VZLS1FatNEu7eB6ou7bz+nE4Mm4q5UbZIW5QjCzDkk+FIlwob4gj6XSB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785441; c=relaxed/simple;
	bh=jFNH7aRK6lo8YzI7AnsxW5bzmTA513xcL0wNmnZ8WJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cTQHpK6iObWHZxlT3hW02HpvLYy3UTZ1jMyCrqAJl4n4jo7eQ+Z+lqYBGo/3n+6y2txLdN5q9Pi7XhOrSO8tIhHUxUfK2DLCYHhnpfF7TY+EqOuiWHXX3mZR/flBxjv2WXyszkHDrvpo9+mPQorfIh3kjYFLDokxfD3n85Xf2mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BucN69rl; arc=fail smtp.client-ip=52.101.57.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDpjb6ZSeaxZqyIk77SFH/ziAkE4YY4QCc7NJrlgrzRSZfwDDA+fkwsGwQklIIh1gXuI3qwfVsosMeTcRtImZPNlXAwzg3MrlyG+pVhbn5n1BMFE+xIOP/xBTxClZrB3gTXPtVzx0ERiRjOPk7sAyu+HpDU4s44z1NTKf+VMjWnp7MmJ2EsOgTkte1Lk9bSzJwmI3scUeBhpCKPEMteeO+5H6arRcS/irGLi3GROPaJoPXMbXED/3oCvn0ETtP2DulXqPQbMTQcMHkfB52tP+Hjh0lGYV4CA4YB+m9P2yv23m4+oa5N5Gqd3DTmozjMk5U0qUJJwkGLt2vkkouw8xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxwhw/j/EX2XAgsmJC82WEb1uqovdzgSsoVg2vAdvnE=;
 b=Bw35Be12AGNuDmWvCOoPdGKCwqO57Rlx2Fbwl5N4o4Re6Gd4LdlBKutZxmSVsa0LVfSL3VXpvU68HMKge6tku/UINmVOXt5IWWwn1R949aeqP6r9OcTOmqDSWoRECGFO86pp0HAdD4+tzmDweBWUlXI/lPsqLKHAsNrCXxw7rBdvKh8WcwwgfAbLD9wlcW8ITnrHEvUEc78Jcv8sWi9V+z3D9y7TzIkijIWzeg4NthlpbEn+VfNq+93H5FvX6Gk9sSO3oFgGlOmWPhTC8nFbpIQToPb7HAMRveKdpozIVY2riqRHJkZhIbhIts2AwGjk82W1Qm04x7q3JGutIQaaAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxwhw/j/EX2XAgsmJC82WEb1uqovdzgSsoVg2vAdvnE=;
 b=BucN69rlZjetN47I/MjuFuMs+j493DmvSrxIYPazYrTyTaSX46drbOC8Zy/ioTaCqYNF2+O1T132vRNZCnfg+K/f666ffKFUODvFkXO7HHbddFoCaGC/NbAJnpsp88xBqgLDtHXGYAeVAN3xCHq8v94AI25h6hWWUKkT+2XbUM3TQHwgeW4sNCOcLISTIa/x/Ycq9dfJye/8kC4ZQA+sUa/CV7OZWAIkmQZBA1ODuAW0UwLDXWBUXGMUHPXvokUqczqyTe0qD2wIuH3FuaZae+sMdp4OwpV+I9pzREXpEZVL7bcnNVxCK8MzpbOFYO8pJuPf15XUjW7jrf6a43JoBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 19:03:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 19:03:54 +0000
Date: Thu, 14 May 2026 16:03:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 05/11] selftests: Add additional kernel functions to
 tools/include/
Message-ID: <20260514190353.GA1394801@nvidia.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <5-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <afkUO56H6KPy5afA@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afkUO56H6KPy5afA@google.com>
X-ClientProxiedBy: MN0PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:208:530::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d959c4-e315-4f9c-b287-08deb1eb8af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799003|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8ronLshH2w0+haHswjLW/eFQAqm/MxO1aCa9nw0i6JBXGPqM2p5zxgFcuzbLwDltEgzuKg1mJejEwgEDcsptKoDxJh68Js/97H5/9jy7TfFssJZmxpHlAn1wsXiGcUW/DfhxE3UazZ78xY/o8IRwH6NfczIhJYIXbA19E6zN98OEjL+7NyP6I1hZoznNx2iNPUS16N4f8vGwoznLpl08Ubtbp4MtM8GNjVCgIFK77ZPo1pepteULYk1ggR3Bv9xdhPxIPfNPkPUIx6bSwlzMzzjzNIoC9pnEy/i1Kyy6E0flXXAUPerT0qhTLWz7ObA+pMmdAfqaWkoIUxa3Ft+sBUuR2AkA68k154fVm2lQxDuB48A4Abw/B4FOAoV91DhVVKdWhvPMN0YdD0v1RfV/MW/60OZXIBto3TbmgjHFRyOzs6IaEPxGKTTwiO4phF8kdZC6MA/I9TYG0ILshhBGs0AbVtOeiY337rBa/UkKuW14Hb94PJ5yHenVzxbG2tItuT0FE99UTdSGxQkuZCNur1FegWveQWdw1arHkAF++TIkuPJDUCt97mndHm0FmxOwmbL0dxEl0uBLNE7/MXga4zaHymzUKgdHsMpOZwnUqUXew0O0tM+avr/CqrOKJpcQBrHWHnFSn0biVHFcJhd3/zilJ9KdkJ4le9T2e5VQT3DRDF2T7KXiRuzxvHMxR9p3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799003)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GzEStwcX8eWpBixoBczQeswPfZWeXGiZGadbb1T/o5P7OrYnr+nRU0/1CVha?=
 =?us-ascii?Q?iOJWPBuC/PWVnUrje1ykO+cync9yHOJomY3LhVng88942Qvjk3gVokoNej6M?=
 =?us-ascii?Q?WUYQTJrJp1Fzq/jrMkljD/5Adjoao4KNWQMeibuAVmbwpeK4MKvyHuLMoeTV?=
 =?us-ascii?Q?clXPRc1CM7ap9fBae1OoXxTASEzWe3o0AFDR7vq5mpgiow6MJoLiVYeiqo6/?=
 =?us-ascii?Q?mWbLawtnX2qab/j8n7bPH3AVb6bP7nSAgHWMeqhjm5bDFycqnsc+fV8YK5Wp?=
 =?us-ascii?Q?Vr3aGzOsSk8hEfH7x7QTEm9LtUs/9TnX5i2YfaifjQpyFLsVZ2hk2AX9VdDk?=
 =?us-ascii?Q?iEyLWOy1rt73Gb5m20S5b8ahq3sf95kEaI1mJDuE6bS59IqPbpE7VrENwXZS?=
 =?us-ascii?Q?zq35F0qbNTXlClzjo/v5n8hGGe38/OPMOm5vDE2pvp2EOLRsh+6gxsVZ8DkH?=
 =?us-ascii?Q?BY9V77XiJMijqJeimVvgCMnjk7ixG8fNaXirsxY63JEacqeTgEAhguCMSUMm?=
 =?us-ascii?Q?CaAg+PBMThghqv/3qWNvyCK1Izn6vNiqldCrUiIuktVsrrk/Y1hHtzqXghuI?=
 =?us-ascii?Q?9yZpS+LaKjfmoJoCqr/cocrEByW9V/XRO0DD2p6IDBdBlLQWrEBF6XQVJ5UH?=
 =?us-ascii?Q?glEElv2jaPlzWQKdlcQo/ch/CDU8kKOmw5LeAarMJLVbo3x6UIaN+2u2eu4J?=
 =?us-ascii?Q?XDTWjk7VMOJIU084TSGg5wQl9I7xvhbVex7C1SRLzOyIpVvPSuuWW6nbuhXn?=
 =?us-ascii?Q?U0XIezhh2qNr+W25yB4iZIZLd9FecobxQ0oyYqCQVyVhkyjBjNZDJ6zeSxsN?=
 =?us-ascii?Q?zDKwLUE9mMgTKMOL3odZG25cnh9UkxBHdCmPCfpFgce5YstdcIQ8O4rr/1ZT?=
 =?us-ascii?Q?zKu3p9fm2X0o6wcboxgirj+m7e7jeFVRpTSWtSPHMs0k5yMFylFn07An+ghr?=
 =?us-ascii?Q?Y4qTMhmErWinP7NJ3Y39ZYo6porp+L9oFOYivAUen8c+XE5AGCFEafJpIblx?=
 =?us-ascii?Q?7nIK7LRPcOX8ruXM62TU9H+MzaLK7lLOS3SFbzob2hiiR0FAd+jVV/FyPoZ4?=
 =?us-ascii?Q?zWRFTQOXAw0XY2VozzQ/vBOpON+x7DbHaHj52aQPbCfFIGLjbOLjp0NvjMK0?=
 =?us-ascii?Q?yglSboWb3lPDwjVSCsYJwx4NEYEjd5qRPR+v8Ot/diOuv2UzdCAsqLlmf+aO?=
 =?us-ascii?Q?YuXbN9p/OdxEEDuAPqC7pIK56OdvgWKoRU0fk4gn4J+mZY/gsrDJZ6dqOzbW?=
 =?us-ascii?Q?QQnfCuJNSqA19gfr6JstO6HcB42TlLZQEDkP2jL/nvkYiP55AizuQkttVRpc?=
 =?us-ascii?Q?Uq2cY80mBnZRDC3UwkVe4h32oJI+HK0DDHJkHcn6q7k6ie8c91x/D95Luehd?=
 =?us-ascii?Q?S+c4leJXcY++APCMhC43OrDtCKgqLCdUZLu4vT4ZKXMjudL1m4V7Z7OM+VHy?=
 =?us-ascii?Q?wWO9BjPzNqs1Kb1IHfnDL9Lc2ZddXGhzdWmL+31b8QlaMF/CfG0UXY/7Jft/?=
 =?us-ascii?Q?6tOp50HnuE4GzrDKwdMjtLM05tj/d5IAXClTjJcccaFBX3k/ptQA3KRHTWUU?=
 =?us-ascii?Q?ivO9LzZBzS8SJGwfhteD+sYkTZNyDZR3hn488xrCOw7Iw/CA2+MW2XmGB/gW?=
 =?us-ascii?Q?q5ofK1oCln9B/UAUCi06wnB9tmQzRu2Sbf15XVr831OR+6nzGu1oy7STQ1JJ?=
 =?us-ascii?Q?dzS1/huBfeR3T+Ar3gW2LW1+WQnwm3Psa090q+3V2J6WptDR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d959c4-e315-4f9c-b287-08deb1eb8af5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 19:03:54.2758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEHBRZzglpCyUgQdTJ3TNFq1/5pou6AzywU47O7sWxY5if/8AE38SHrAVsf3fakL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
X-Rspamd-Queue-Id: 5BCB2546281
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20730-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[Nvidia.com:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 09:48:43PM +0000, David Matlack wrote:
> On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> > These are needed by the VFIO mlx5 selftest in the following patches,
> > which includes some headers from mlx5 and also needs a few more
> > MMIO-related features.
> > 
> > - DECLARE_FLEX_ARRAY in new tools/include/linux/stddef.h (wraps
> >   existing __DECLARE_FLEX_ARRAY from uapi/linux/stddef.h)
> 
> Is this needed? I don't see it used anywhere.
> 
>   $ git grep DECLARE_FLEX_ARRAY tools/testing/selftests/vfio

Turns out it is needed implicitly in existing headers:

In file included from /home/jgg/oss/wip/mlx5st/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h:16:
/home/jgg/oss/wip/mlx5st/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_ifc.h:4352:3: error: type name requires a
      specifier or qualifier
 4352 |                 DECLARE_FLEX_ARRAY(struct mlx5_ifc_rq_num_bits, rq_num);
      |                 ^
/home/jgg/oss/wip/mlx5st/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_ifc.h:4352:51: error: type specifier missing,
      defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
 4352 |                 DECLARE_FLEX_ARRAY(struct mlx5_ifc_rq_num_bits, rq_num);

Jason

