Return-Path: <linux-rdma+bounces-7160-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A11CA18503
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 19:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED901160D36
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 18:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735011F5438;
	Tue, 21 Jan 2025 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eRR1Eptw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67771F5404
	for <linux-rdma@vger.kernel.org>; Tue, 21 Jan 2025 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737483253; cv=fail; b=fQr/4dBmDdhwtGZhjhZ8pEd1Byrb0iZMziKs5YHtaKm3AihbWSOaB6xwihCm1W7N1qak20RT+LCjtVbyBEUeXpNd/KA79uZgSBQo90AiwrNbdki//2pH4p9VjhJ7NGa4NIsJa2Pw/2ooD5Slu82COdoXJd5hutBIzhZ0bAhAgYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737483253; c=relaxed/simple;
	bh=7FM664iFfXIzw/LaH1U16b0HtKRGkI7dj9eXSaOGdrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TO5gahcHYViyubWJ7VEyNSacoAdzPGax7HmKLUql2NhsZWkbY55EqXxxCkKoWxWi1wmRdnczAJM9I3FdC5joNFhU1LteWyiQHPlQOExzspg17jjRx94TqXDJLLeZzDS1RP54u7ztDfxlICqvuNfOmyJbPlD3Nvm1us+PcyMKkzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eRR1Eptw; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLT6kUaMG+1hK2zgSTE/xzlTLMjL/Hlwuvf6zlSDB5OoUZ/t61nBlJTuhdWjdPibU4rLroDX3M1Qvjj3H0vKiTxlg8iO5mVdP0YeVo8mc1mPDEoufEjoxbBqb/G5Is71rFbHYLMaqkUpXRNIJsnMOlOky4SoK53PSVSN3FKO7Wv86DdXBpIs34T7iEedLV1sbC7PJ3TfwIerMLiY4agCZlJUfJjkbIeh/monHczQ/FqU90sntopVf56+mVecnax5ApaVPFcMCqBDwXG2Ct6dNxeZ6ACgCdVmzTEUKYl/PRNJJ7CsASNAfQaBuv8gYJxb4S7jTiY5jhZZSSD7NE0p6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxhpNTWqc4kZdsFf0LHbOx02iMmNSvwQZYVoAERLelQ=;
 b=e0HiKGU8C64HkyEKCZ3PCNNR8VqJH2cT93dvRBQfRZ3t+Vw+qTnW4ObZiKV5YTGKnwnaOrOZxlL/kiqo5TqiDZYZ/p+3VxKQRvDIEu6/d36dkhM+JxFO7tACOopKBdhG1HH2qMw8XVBNFRCbWwmYfT6f0d4JySEwK8x50UsJysez0Og/DEBDtI/1iman3E/dlOaiwmGTOGGNJ2zb21+emyq6nNFbKoi6gPpVtvsy1J0fgwPabDcz8dizpzDaoOo34RoDp5SwkOHcIWcYcKgINbVW85I++mvwOQLTYYPnaNPMXqXjxev+ZpizIfkhy73kD+1cciKdLztANNFLqWyEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxhpNTWqc4kZdsFf0LHbOx02iMmNSvwQZYVoAERLelQ=;
 b=eRR1EptwCuTFAXofHDKP45tsutB8aMTkko5H0PsA4znr1Qg+4CSVIX5cYBLf2Vcp1F+4Vd1MbiIQ/JIwyD3oPMd6QLaftca5FfFzn+Yzs+t+C5OS664icDPrCTZAhiAzw6QmFmSUnAHcKVz2SdMAi1vnopH5alnHh5Uef9pmEFQcMDjUBH/uPnskqfVPhh6KWpmncyHVWHDxmWcKj8GU1AmYlUsaHku2FAFsEV+9Zde/FJ2s6rZsDnvOKGRizePiuaJ/eO3J4wfU3F1fU/4sKh5NeDfR1k/lRb/HC8OEqLgifpD7+B3urf8XIzj7p3Zi1snOYDvKJjnp3oXylTvPAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 18:14:05 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Tue, 21 Jan 2025
 18:14:05 +0000
Date: Tue, 21 Jan 2025 14:14:04 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Artemy Kovalyov <artemyko@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1] RDMA/mlx5: Fix implicit ODP use after free
Message-ID: <20250121181404.GA883574@nvidia.com>
References: <c96b8645a81085abff739e6b06e286a350d1283d.1737274283.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c96b8645a81085abff739e6b06e286a350d1283d.1737274283.git.leon@kernel.org>
X-ClientProxiedBy: BN8PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:408:4c::46) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 0afeeaf6-271b-415f-238f-08dd3a4763f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SrnIYD0T91ADfl2lbBIvupOO6+TncVq6XnjlbsWrtxPXAxWwQXvb8idHbwuN?=
 =?us-ascii?Q?2uVApMXsFQ5fZHZeVCEp5EiCyp6hC5bhTGzLbtYXioCXIuOz3+lSzh9icV0x?=
 =?us-ascii?Q?UEVgxewAA34j8SeC1zqoeSMFg/x3s8h/UxEFqN3h9H70pd7qvhkEHBSLAeFY?=
 =?us-ascii?Q?YPc3+mYWy4i+KEeTS0rZnm/kj8yZowc8LzMocZEIBU+X8uLQpd2suJ0iWJGZ?=
 =?us-ascii?Q?loi+5JkUcQ0XDRI0Onge1uezvXG929wiMLTFP+k2ksAGCOYd9Yyi3oq78WnB?=
 =?us-ascii?Q?pMR4csOUHwiM/FWyZTpbcmY+8rfHLvGazXB7VC4Af0j7f4TA03XKnv7kVhOJ?=
 =?us-ascii?Q?o2xKfIEOVHE84OmQEqLhANjkk1loQUbTiw5O/OcX9Vm6u0RA5soMcInAVyUb?=
 =?us-ascii?Q?WQqNK0+qdxWCi7X9CVmXJ+0GcTPu7Pel2DhlTYsF65NeCoXiNTJZm9J4e2Mu?=
 =?us-ascii?Q?HXeutAQBho3+fr7FEn6rtW3gcJFHu2RkbQJRWO+1VQxWlryT4u+jUu8fol6y?=
 =?us-ascii?Q?/vH6ib25ayQPrFhno2IQpjlbWHHOAzC4pgc0O64P44D0Djg7FsRm72uLOIug?=
 =?us-ascii?Q?7fDXw5txM18WgRxfch0c+8VZqGpI8rVY+VlPuwKMiLi8V5963Raed4Q7dlMT?=
 =?us-ascii?Q?XYsybpMNDC0HINKW7mvQXP+/LjB+76WxlQcrKRWWmk3e6FIMWUokqzcDKDgn?=
 =?us-ascii?Q?/J+meyqPc6NYyyzjeIE/g8eRuaJTcbiG2xULdnp489cbHDHrVyuUg2FeEwVh?=
 =?us-ascii?Q?RgvWWtKUWZkYRH1H9k4Q7F9rlQqm7tVx/0WWuv4LLP5BUMdHqoUp25tutrzj?=
 =?us-ascii?Q?w6Cl6KXLxJVwlPAxp+Y/QHnX87OqkeD9cbGHaXY3enb57sb9MFnjYTFKJoW8?=
 =?us-ascii?Q?XkJbtVDsc9TtGCf62TmD/0uTacx3nE/emGRbHDWZGeMlQiS2iGM9U+uabA1T?=
 =?us-ascii?Q?XkG94JYzep/v9h0pPdBRWqV2gM1XudTKJLd6qjvBUcmlcjHGe8gfuSAGJ6Lo?=
 =?us-ascii?Q?Tx/dtsH7tx5fYvXOIXF8r+cn35iNGguP/DNon0oA3I7vCqB3GEbiPeIVIALt?=
 =?us-ascii?Q?T8pqv3yZjNM4S7s1E8HWGNBsr3CUZuZKI9pKrWcSfaPtCcAefge0tjxyJef8?=
 =?us-ascii?Q?xyRilRPOob7A+ar5lysJ7VsFYr/nkDswA6gkuEJ0sss9v0B53GtjUfGGvS36?=
 =?us-ascii?Q?cVw3B/7MjsqiOfuOgEZBFm28qvbi4Gr2EYJpSM/PHmBONLqsy79zt4ewYG/I?=
 =?us-ascii?Q?rgMtIW6GLvaDTL4/4edL4y8FcZ94+nDKvHlMVrF2h7AqFE6PcgLab1ykOS3i?=
 =?us-ascii?Q?s+MsiK0op+860sSflHXuDEA4NQ0/qkyt3CLFsYPqH4uBB4D1ZepMxUcZInvs?=
 =?us-ascii?Q?fqlRvRH5aMMXpHRGfgUWKrlZXROC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?22YVj572AQESe6rO17NYjh59wfoAMP+gcZsCyx2gSas7HgxXD+ohKjGf6D6t?=
 =?us-ascii?Q?FzRqfIzQVyvOqH1vT18wABQ6J+XA7LUgY0WuBRaaCqTHyVSETHKYoX6bbQry?=
 =?us-ascii?Q?vNchgja5nGIG1S35Bu1gN5PQ+g/SimDZQ1C66Ly1M6O8Bx8J8fUhaf2aqthw?=
 =?us-ascii?Q?AXvnJkXumXSOXPiGwjiWzqaBhNC7SfcXLECCZUx2k1S+yWdxtfOX2VjDESOd?=
 =?us-ascii?Q?3PpVAad0va9wPM/qzoen8zgHRuW8TALIVgRbHzFZ1YA2lmojMlVKUgElSedp?=
 =?us-ascii?Q?VayvFt3nzBd2zsZxfoyTw4ybBduA7LinEmT5WA3fG2iVwMZh5K5wjtX5k8b9?=
 =?us-ascii?Q?JlQdKxCnzFNoUwRdySFW5fX1l3D+bNtF6/kxfDLEguRKVA0Ml0kR7CcRFAKZ?=
 =?us-ascii?Q?L2Y2TqBEvWc9moZC2aTU7ybn5buUbuvWMuKx+lsXJDGlGr9ynxHWt36pUJ4/?=
 =?us-ascii?Q?67UbggIzSlvyTXvnd1FC39E3d8Aww1YXPwDBJgRiLQY/91O7Uk6/zGxa+y0t?=
 =?us-ascii?Q?q+5uNyL3iRHQpVxZXLxitYtzzNZQSZSbOEgBfhn5CAM7E0XMUWpyhykowZRv?=
 =?us-ascii?Q?Jw+cbIpi+GcuGS9W3Vz0MuAkjSAdYv3jSXQiCUI5HgQP2M3Zuyt1LF/+/fat?=
 =?us-ascii?Q?dFebZi7YQre83XRTQyWfwosXEZnCi+7A8bh3mFTW7Sl5XtTKx0R4rOHS1hYO?=
 =?us-ascii?Q?xKzWTPGbY9JK6B8Cocd+U81yg+xAwJKyD4V4+yci9I6r9HYXxpr/L9lTeDy7?=
 =?us-ascii?Q?/loncNUXFKFrCe5Xa7GuQPo/MECm9z/5nQnrg4+hGyhW+A3BAbsLDU/OL0SQ?=
 =?us-ascii?Q?HzjfdBwOFv63bSneN7jNl9WGcIlosIB8qQdfYwBEJg4bP9xfzXmBDnPcaJG/?=
 =?us-ascii?Q?NJQsPkS3sXslnoh7cES+zltQR2/AD9Th6CdZa9rd8vg/mECpZ1U3ek7GmVlG?=
 =?us-ascii?Q?FelR0hloUaYYtrfVVBnUgr7zR42+bhAXLSsOpkTqYawr/e/ITOllVjAoAHXn?=
 =?us-ascii?Q?tgKfR+TXCtpTZj45PlHAltNZ4uFuPUkCbmxPlU9C1Ej2wPBQe8pUdPn5wVeV?=
 =?us-ascii?Q?g0oNHV3wIXnWYqWbXQZFedbH519tZLw98JxdfAOLXU/52Vg1SNEVWv1CbatT?=
 =?us-ascii?Q?EDz6vX/etI1WkeZa/p0przCXdy4qbolSQyHRvLjQikJo+rjj1LJeiVvpoVQu?=
 =?us-ascii?Q?5oFy6rFrySSdx9fkzc5qTeX5kOpGQORcDThPGNkjWcK+gAUcmc8+FpTadnF5?=
 =?us-ascii?Q?ux1G4/eLwxKUBA3EtIoFvTpljt+tW/pHtBHzrIiNO+eRGPn3YoLbZvkLAexy?=
 =?us-ascii?Q?gSoxJeKtEzB/psE3WhuZOK1pZEsiaaJ+VdKOgOxPXcABcuaOOFSUcms6htV/?=
 =?us-ascii?Q?D7+2IQ5F4m8KiOlllTH/JXn/1mC1KBY1A+/aM6Fe+JvlT1qi/2aJDCgpQ9Ck?=
 =?us-ascii?Q?1EgIYJHZ8NfsD3udwDrK/ButTQemasYfQolQtPV7Psa4EgN26VO+9fCAzB4g?=
 =?us-ascii?Q?HIf5ptarVKX2AlGzvuvtMGUpeaEL89JukkuSKLUFG8PDpomP81qN9Na+73/t?=
 =?us-ascii?Q?C1XKuqpYZI9wAvTDzZuF/osZMS/zJC13CItDu1N3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afeeaf6-271b-415f-238f-08dd3a4763f7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 18:14:05.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVBlURooO/Ixeccpd/0cogvYq3CluLFwNXxG3vwmo6D0w3PZlqJsUJlCeiPRMeo+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052

On Sun, Jan 19, 2025 at 10:21:41AM +0200, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Prevent double queueing of implicit ODP mr destroy work by using
> __xa_cmpxchg() to make sure, this is the first and last time we are
> destroying this specific mr.
> 
> Without this change, we could try to invalidate this mr twice, which in
> turn could result in queuing a MR work destroy twice, and eventually the
> second work could execute after the MR was freed due to the first work,
> causing a user after free and trace below.
> 

>  drivers/infiniband/hw/mlx5/odp.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)

Applied to for-next with the change I noted

Thanks,
Jason

