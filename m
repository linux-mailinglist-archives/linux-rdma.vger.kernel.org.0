Return-Path: <linux-rdma+bounces-9215-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7615BA7EBB2
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5E03BCDC5
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1918D27CCD4;
	Mon,  7 Apr 2025 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j+Wky39W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C327CCE9
	for <linux-rdma@vger.kernel.org>; Mon,  7 Apr 2025 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049902; cv=fail; b=dRQS2U/eKx+ZAqGMxy+AcNc0hWbVahmurP75riPaC4DZVvMR/DrM9XKg+7jIcOnJUN74elbsaVOwSON2/q0pHYlAH8L2M6OneQLelWleU2wT49uW9pywxKoKtDgrOwtb2mBdNkWvPFRjTsNVB4VHkse3RpBWtyI+FXyISzicgtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049902; c=relaxed/simple;
	bh=7/aEEcYqXuM/nLUth5wSnz60aqM3tP+9H40uXXjiBl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oepMw6CkB4k+KWHyU/OHC9UnceARMMCqbF91CUe+27+n64nMJ+bsOJyReHAeCnaZCsxvKFjoQriyNE5BqGBUKnuSzUiUTYewM/5yhBY6TueOAYO6VBLuSFx54NWsqgrNwcOomCGsYiu333CjJZy9WcVbTpGZpXnod7E8dTrCH5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j+Wky39W; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFR0Wp+kYE3PgPQSbb2Qgi3x9Na2FshN7SPdhMp7grLH5w/fFKHqs4jJ3iogUESu5oBO2fqGEpssS3qeJt1XeJXOfmEKW0SxGHML8MDSV2JpCJgD5ULizsqrf8cL/qB4Fhg4l7pAaTgeLLmrxLdtv8ueRXApZxJdp8FhWrLcxv22fcdL0738i42j7oNSOYc1baR+kSio88Zdk1oUuXR7YKLDJFx3Toz4EtC2V0YVWlzu+H9u/wYRmmmlgXK1eHRWRw4azZ00BxvwGKooLau61SXZx1Cxs6Pin/YI1skjBG9KAxQCsGxpi+bZCQK6KJZ5A3mNWpQayQRnnD7WAtl2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjuWQTFYOTPskRMrjw4TvtNeTQ96W/YdxP459WLsPUU=;
 b=llDwLfQfyZTF55nd4XpazW/xJrEUpE9/hhigbiMMn0OSOX1TRuQhrPvq1b1zaQh46+VgxKd8CuJ4S4h4MMqlhUbyoDOsbgAeXi1AY/E8p/r8N6td5JenKtgICHWkAMZgXDrPKY90GTsU5qhnEmVtIVSBcAmCDdoivNNw/uyv66RhSNKF4ZG31qyl/S9AxnMPS9WuvH4SwOrj5XeeEmOTXCq80T5GvEg5W6zCCnGEjmsZzsHkDs/XUCzAuT79Lk+Tn9JHPo1MIxfRehOUl6E5cVgoCJZKV5zKVpGgOrA7AwrEHZUmcWt5c7QVwUFr1CQK/7IxQWeu3/VjgPDXg56/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjuWQTFYOTPskRMrjw4TvtNeTQ96W/YdxP459WLsPUU=;
 b=j+Wky39WPsQqFQL7RJC5SWlvQ4DfZRcwJ98CG1YUezowpcX7FgyKymY1WNnVsKdpDGacYS6ycAxdpXCf6NR6FY9GlxI5kxx5J+m0zThGDjclfFJxyW4L5VhChv3r+e6BupYT2HORfCek1R5ZkXAIF9fXiNJ3aV3c0j++amjARNcSVGgtp6uK7WVa6+E29yBtwusZN1uW7zhhuuolKVj/TkbPu5d37T4qlHJtDtBl3nSO9EHtuYnttXI2ZzX5mm/9nYmAufpdP0ODXuBYRWFgOCuwarG7LoA+uwF2qlXIStTueZr27X3t20fUmpaN5/veqfj/SFBcByND9mTaGmW1HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 18:18:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 18:18:18 +0000
Date: Mon, 7 Apr 2025 15:18:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
	Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Fix compilation warning when
 USER_ACCESS isn't set
Message-ID: <20250407181816.GA1769225@nvidia.com>
References: <20250402070944.1022093-1-mbloch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402070944.1022093-1-mbloch@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:408:f6::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 795d3672-1e9d-46f3-2d28-08dd76009218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OUtTb5hUaawCVBLFJ6IxZYZE9iry+S1hSqEyaZs6lwsIey/cd38QT9Tth8am?=
 =?us-ascii?Q?1WWKpIIILYxZPgP2avWjwyLFRN2/0P7keGJkqHnAY9yk8h3soTeDYaCY8QRv?=
 =?us-ascii?Q?QoBi5Myh/U8Npy8WMGs8o8ANUZyoy3+vcNQe1OZ9uyoyo1MMCWW+g6yin5gN?=
 =?us-ascii?Q?uQs6aEhM4+D9767zxETOxNpTKPilclCZI+L73Hl85AxclmvSQV+Q0n6FPYol?=
 =?us-ascii?Q?E8eThSm8XcnRMwokMgo9lztdvFS0cHlr64N85pCKNMR3/Gp9fyjnL3v6lUPb?=
 =?us-ascii?Q?KKiJJb+Y36azNbkEab1wJfhKOoj/ndZdreBQz6hnvdEok13F7lLMlJCd3rV9?=
 =?us-ascii?Q?boreIEdhgwfIwTL+F0tlayuoF5aCoimQHxi46LruoP9/Cw7lPTupl9eUNVDi?=
 =?us-ascii?Q?/cn62CsILaV+70tyTemcaHn9ByA95k71wQV6uO1BC2Q3q3A9//tvOzDJuP57?=
 =?us-ascii?Q?4dwFwtcPUf04LeMp0ZZ8NRf/G3GebrywdFXTRKGQokzQzPajEQYasjHtw60g?=
 =?us-ascii?Q?COrQhkM5c11A2ae3EpSmkp+bqOcYyRBGVqhbovm/OzAkMohabSoYHZmvQGrB?=
 =?us-ascii?Q?PlYC+tP9WwD80eS1yPCuR1Esy7NkEeGuCdo1TyKjk0hSqXeMuXLB54twnvmH?=
 =?us-ascii?Q?YhSOimRsNEYVsVVz2pAPKM7GjrK5+xkXe2A/Fc5E2jHUX+7hSZJWvJ5kmoLW?=
 =?us-ascii?Q?BwLvbBRe24MAah1SA1/AhalfhBdCGjKh2ywgm7RL9/+1dDcGLKFUnnGX7qUJ?=
 =?us-ascii?Q?i/T4//PNELzh1FmUMaJDhRnVMY5TYrOm9gg2eIvkQB9yBi0TyuOmT+tGGTpL?=
 =?us-ascii?Q?ccIJ4y7OLGJIvAt7R5SRjaYR3s1BDXWlhUJhnU2zKS8R0dHGwsd9mF/5eQD/?=
 =?us-ascii?Q?lvhU4tJXKNj4PwTVAVhAN82fQD80ckq6sJtT5r1YnBFQRrZD9sWt8Fe7SBtH?=
 =?us-ascii?Q?xqrAgZ6snF8I0852ABoHsqL3nk6qeC1kDOR5R9/+CowiLuRPFvqmCIPz9cTS?=
 =?us-ascii?Q?zx7FEwDRw1DneLhZ+XU9f+vL1y2XXFYwmI1qXnOnzksh+17SVsbKEgWxD8aY?=
 =?us-ascii?Q?2YWldd/v9Kxd9nlIjqoMBOwnHXbGyhitxBiIZ07o8RBuTO+VrlIBasE1qeHN?=
 =?us-ascii?Q?auqc3g0XB0XrP+3aLxqRut5ceufPQSQaSNMcbIIqAPj6TNClhJfmHsY4T4gv?=
 =?us-ascii?Q?eAefLmEWkq1OCRtAaXrXhFsG2/t4129LteAVFETlBotn3peuRLGtKdpy+6Jq?=
 =?us-ascii?Q?C1vlVm3OraMtR1plOp8TRO7t2bK/edUF3mh9NK055I7ULWI6SwVxlgO1Ynzm?=
 =?us-ascii?Q?ip4gHdyMJqCzeSX108106k6ojW4GdZ0OuuDkNJRWbv/ruFQD/iFcxtau1kf/?=
 =?us-ascii?Q?VWSwSILb8Ly1Yg7w7NHNzWy6becc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dTD8I4hJ/pyHLTtGY+i3XO2XCUiVxxD15N9nVq6ffavaza5OH9bRXUp50beF?=
 =?us-ascii?Q?IAiiGRNbww/kfqOy3ZuiGvX4XE3iQu1fEGS0dHSfM4Bo67YqvcMXgIDXwwJl?=
 =?us-ascii?Q?jhpSMrzqDaGyNNgj5YrJKezFQPOkvImZiec+AKwzZalg85FTHt5lcLN2zmen?=
 =?us-ascii?Q?6r4GxP0+573aaplnB9KYwTR963J8TZRLMpvyUb3ClI9Yb4p9VB6VD3Ujp2sY?=
 =?us-ascii?Q?1e244px91Pb0VJgaYo15+6f0YhQbUzfUVaU4luwNd/BkjGrZgU/xpEfzCHDD?=
 =?us-ascii?Q?x/5rMynPoZnNCC5SdJ1zTavNNKubPx1O9Q4f5Qs+7mQ2OeSA1tbx0bqBewET?=
 =?us-ascii?Q?y2b8m/32/0+DGU9KgnhcA8hdxsDHb4+TT/O8bIZHt9erbR0RorlT2zVD05rY?=
 =?us-ascii?Q?fR5U/zxAgw65WFYZ1I4bRcuQobmQ+Es5kqUkFijPepmHfXXlgluZI/tKnJDx?=
 =?us-ascii?Q?DR/do5RSw8P2jffc4zPQ3MdsNgmcBCCmlRNyKN0F8y4q5tQkbswXiBwJ0L/2?=
 =?us-ascii?Q?gz6jxVnI+80lARKls216OM4I4cw1n+8ppnDQQI67QazC1uu0ZfSN0fXC6fqd?=
 =?us-ascii?Q?HYFFNsQAkKVPHXDCfb66+JPo9Zj8yDM5o/6cEAyLq0+Srt7zTQkvm+YzUPwt?=
 =?us-ascii?Q?19wdE8RM7HTjWUsW9mwUI2Dbo15cqVC1xGgTwFVmEz9rkl6gzBzeyavZMWPj?=
 =?us-ascii?Q?E7EUYAc0S+lpUXAFH4nF2/4fzcknsl/pUy3Fd4LgOuIfPUqQJ6QF7qlcpwkj?=
 =?us-ascii?Q?L0KowOGKWNDnEV7P7Zn9lhJyC8zageW0OnMZMjpjCRDNAYVBuGXiVpmbXoif?=
 =?us-ascii?Q?jdmcFLer53KfGYH2UrnQeyyD+yAH1jX1fbo2P8JYyL2sB4SVPuCa2SHL8Pla?=
 =?us-ascii?Q?81/3sth461z8TKIyF4HW9XZlOIT4cjuw75/IZ7ESEl6u/vEE2qv8fzoDlOkL?=
 =?us-ascii?Q?G/dJXPCRcJTAxhZ75jC+w5sVm6ppdw1fQIxg5YiD7PQ8DSedb6Wk3CjOWXoW?=
 =?us-ascii?Q?E1TTDV2Z1duu6xUDGFyIUkPREVTuGMgdKakidq8g/dRLdTopzlI19x3VcPfT?=
 =?us-ascii?Q?stTExxUFP7Z+if4+514NS87QwRy2NLDdIhnwjZLITZHfNu7dZuOPA7BqLCzA?=
 =?us-ascii?Q?HOrER7VViv7dT8E5n4710e2AxGYthYXh8jHZ3nuHYxPQ1HG5W+8cJiNMqBTz?=
 =?us-ascii?Q?sT8YvP8a5MobmIi+tw0AyTKL/mZt/GE3HnyDaRFjwcMKaWmNH+o6gFsIEqOu?=
 =?us-ascii?Q?XBo0eIvljyQItV70VpRj5b22KuEWU20ztQU6FpSQzB/OlccP3Omyq2zp3LJF?=
 =?us-ascii?Q?AZB1qgg1tQ+dF6qkVorYcWcpyUz2Q6pFWOaERU86nk4DbUcssanXSbYmCmAg?=
 =?us-ascii?Q?NXmbuilvgKTM1nW8cUpBWn0pvzEkpZdDzcZ7TUeUyxEH9gs15hf2tr+HUu+i?=
 =?us-ascii?Q?R6K64I+Kzs9G+lx9TvjvwIXC/hDvTvohyTuZXtPqX+VYsD7GkIOSQ1iBWY87?=
 =?us-ascii?Q?RdAZ9/WKMPIMWB7yTqqEtsfhUlWRruwXrWsR164pksAZEvMFsaFhbWZ4Sf2a?=
 =?us-ascii?Q?gDdqJ1ZYKtvVN6DSiJ+e00jnsE484y5HUXKbtPPO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795d3672-1e9d-46f3-2d28-08dd76009218
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 18:18:18.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMEIJsGUw93prH5oykH3R1BhvKwyh6xiC5oyRVxB3CSEibPQZtl/TXGkFdiVDWJZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

On Wed, Apr 02, 2025 at 10:09:44AM +0300, Mark Bloch wrote:
> The cited commit made fs.c always compile, even when
> INFINIBAND_USER_ACCESS isn't set. This results in a compilation
> warning about an unused object when compiling with W=1 and
> USER_ACCESS is unset.
> 
> Fix this by defining uverbs_destroy_def_handler() even when
> USER_ACCESS isn't set.
> 
> Fixes: 36e0d433672f ("RDMA/mlx5: Compile fs.c regardless of INFINIBAND_USER_ACCESS config")
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Tested-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/hw/mlx5/fs.c | 2 --
>  include/rdma/ib_verbs.h         | 7 +++++++
>  2 files changed, 7 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason

