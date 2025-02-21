Return-Path: <linux-rdma+bounces-7980-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B26A3FD15
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 18:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F0617D846
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 17:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12621D5AA1;
	Fri, 21 Feb 2025 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gt+6UjNZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6A424C69B;
	Fri, 21 Feb 2025 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157957; cv=fail; b=PBOW7sFLZ499jSTp9PMhuB8P6mdF0oczyYfZ/4XOhwus8t+smYpa6j0unJssbDYrFsXpZXXqwgiDsJ4UrEFrsmJeEXr73VX73o3wZ1+iyE7EXcs9mqdlIbQIZA/7Cxk5hxi3mqGkbbT883zyg0O16MMcd98woLpExRH0s8u3gHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157957; c=relaxed/simple;
	bh=xctlqTxWVoalNuBcEdR0Gq8wraFoaIKNjKF9Q6eWgT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=erSc9L8t4xrcgIJ6ZAIhwSVT3FX2Sy6Prj0o6guJQbh19VpE5yqei0ZfTfkZv6KzkZjdBX60Kb16fhw5ztoWvkxCk15om+brinlbo/eiateSbU3HzKcUpyhYFGfVj6PzrA12sKk6Xx/Tqf0P1gzDHWv3BuLtcJ7rPc3GgsmCBuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gt+6UjNZ; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOrPWI/sj/YhK8qkSrYQzdyFAipkJtWHjMhE6Emy7MmW7C0MoxWuT9yRvaxawUgRSSoPkU2c+GGl9ST+yufuZJG1px0h8/WzlQUeg4KuLg8QV7IO46PuC3UwAGmBeZxGJAahwb1WzJlmFgDlsOnj5zw8pj2efwPZXBaYiBDFxaTS6XeU6TTaWs/b236L6lRIEF09UxaXbB2g+vTcIPab30iT2486TbrlREtTGkjrRb2taW+GadLRfWJpUMITLLyWNds7KtlF+8Gv65zTUIhBjkQmFPkoBQOfIE29B/+gwAZbPuzPACs1m/wxxlbzwM/fmRWuG4YtmeolgikFd14mIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StzNpkHZd45lbGOwHoAnIx5DmGt2s//ob56JYG3O6Yw=;
 b=PhHVOKacZkuNMdifxL0Y7Po5rqNwqzIsSZ3SUxPNyoUlr0wxWsoB7Bvz81VfeF/fG7vC4IUGyfJVJ5LytFWcRaTP0L+lWV0zrRlRjEXdgkrcYmD2ruxKPLSRHpjHZ1P73fCUw/oOZIq1Zbwo3jYUBKK3k0zjOr/d/xFhHjJ+IudaKn8VuoshicohXwddDxuQPIgZyLw9cej6P9qB/i7LkKFUAVFo1DZMNrB7p1V/CcwnZuJDCTjWoR5XG20OVmtprR8yzu7N4qmRrqKPqt6MyJDcd0cY6d2XOON8JmJJCuGzxz14qXh3auqQFJ5DnbyVR0pZ4eyMaEypKGyhabMSuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StzNpkHZd45lbGOwHoAnIx5DmGt2s//ob56JYG3O6Yw=;
 b=gt+6UjNZdIPGPf6xfras8FPQJDlfmcoz11Kp23GdMz6guqRt7RJf6dxsJ1dkOznP0ITDxexqJt92/2gzTLwWSYSFhnG6lT6y1jAfo0NExhdFtpdTFTNKU+UFpqzQ0DqzYr5WIBYlJvi+ltugtpMOe2eb8v07PmyOHXIbj6ma38pwy8nq07xKTCMDWQVoPE0yMsD91WvO101sQ3w1cF+4i4T6GkiNdzV8kb9r1KIiQdVscHM4XRtnkWYqr5L9WPN0wkoInWnoQ11vX/VBcn4dalLrfi0JysSiQap0OXiTPvhKMBN2N2Ory8cheeoC1odrMVMdG8vr7u9/mqfNtZ/k5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 17:12:33 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:12:33 +0000
Date: Fri, 21 Feb 2025 13:12:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
	linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com
Subject: Re: [PATCH for-next v9 0/5] On-Demand Paging on SoftRoCE
Message-ID: <20250221171231.GA313938@nvidia.com>
References: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BN9PR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:408:fc::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: bb059601-e3a0-4ace-82ed-08dd529aee06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vDdYk4mkbQ38AHRlywfhSmfAWYzMJoF6kfcPPSG62prsE0DIMOnJ6BI9fjV8?=
 =?us-ascii?Q?yAOClYBmsIpcay5NZD2CK4ORByqIA5N7C+sjJSKFNLHb8BULbfq2frfTSWnB?=
 =?us-ascii?Q?zlZ+GnOeq8FKy3Sn2r7/ZkLpAzgfseAk7IV/boyu2lFfdUHwZ+fpqipZV5Oy?=
 =?us-ascii?Q?yAIuG6Tr8TdDG71gbMkvjIVrI2wzEiNoz/ATgqbnkRhS0MYon5t4c0r9f8FX?=
 =?us-ascii?Q?y73Itoh8oZp4jgLB7oXPPim/rGo8y6i9XEAGL5Tn8EpZqpjtTvAaXOl7bjDO?=
 =?us-ascii?Q?DMhrNWZN3pORVb3r2DPivrmzbwCge4It8Da5o9gbD9jajKTrS8fIkxqOfCeu?=
 =?us-ascii?Q?LFkkF4HyyW/3/9Oe7ZqXEFXAwV5YdvF+gxmMCkUZEeEYRGBuQ7fssb5iydfb?=
 =?us-ascii?Q?eG6FlzOdzSYlBdsGAsNKGmC6jZ1rQFifVMikZqAfeZO9B18IRq74Kfl4BbZX?=
 =?us-ascii?Q?0dEJuz1dtJyL3zc6g/gMCVshvNIyrroOcK8b90+adTVtaGX3RK99z5gpvPLv?=
 =?us-ascii?Q?gu0N/6RNmNzTT1rNwB+n5KotMjrTfCzdJxRbSnL92ONMpKb9vzSdsh3Gp0+A?=
 =?us-ascii?Q?Q56oCcdyYPdEMnP5FSYsraLOfMjK5GhCKixhaP5MvFPjh98f6vYt7WOdOOLz?=
 =?us-ascii?Q?nIAiUxPcMAvsJxIEQSELVi1tw+DPpyF87sBA+GCRyrmQWi7mQTMP/ateb7jH?=
 =?us-ascii?Q?WWyQuv4HW9KCz4aeK4a0aHK63d82z0P2lgDJMRgwkxn4Jp2k4A08Ie/QcK6x?=
 =?us-ascii?Q?3ZjW7iXsZqxmpMZwG7vFJb3caxp+IGOGGNRXibC/8MczBKgfn5Ad4SN6M9KV?=
 =?us-ascii?Q?qY233UPUt4Aya/nUeuLyptl6wUDwSlU6j3u6Skv0iHKrHn/Y5am+BW4AhOfe?=
 =?us-ascii?Q?GrMWSR+N++1Ybd0StekoKaxyx8zQd1aMQUKuzRsi3uwewvcDr4bqFMYLD2T4?=
 =?us-ascii?Q?doKB+dMEX8v6JfuNNqPitbxV98mdBjfoO7msQUIMhncAwgJNqsKp/S34II6K?=
 =?us-ascii?Q?U3mwznPklUcwHJvCfR6zVaNQgvtbt4dhTzJwOUIdQXaLkxolEef8Zx/ytowk?=
 =?us-ascii?Q?mg2U84XCDshOMKjSCajWoHLikpBgWvlxfnRonVZzXIf73dbR4MiPyFmTlPDB?=
 =?us-ascii?Q?T1g82gXTrFZAxSd/W9Giv/wG9dCnnpshdcloZ0SyceZkaN+cbgqiETTUafp1?=
 =?us-ascii?Q?mOT7gV7rNEPdtL5S7Q/Ub3ONDTNA8RjBZvoFJwJAjYQltAOYv1HmFt3U3m/Q?=
 =?us-ascii?Q?1xfSNbL2VqNvM47rXHBD3LzEwfYRKCTbI+t8mgSlcxra4ehRGpoTOo1nNJKt?=
 =?us-ascii?Q?dih9a879+jApmvUheBiE6pY+sepjQU5TsUKiHQ6BWFxM7TZYKxqbEHn+R9A6?=
 =?us-ascii?Q?on6c5tb15l0m1M0rsZzg4fLFIdRs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ML7qEUDpKvi35Z8Q9ThbHJOhJYm24LMunQ3qPQUwryCH7QdImgpcQSwB/1h4?=
 =?us-ascii?Q?zukVjdbeUfIYRI9wSRZBR/HolNZfVuWp5gJBRWIz110ghQwisYBCv0DJ1wr7?=
 =?us-ascii?Q?m4YVZcwTIt0U55p8pXSHlNFAitirf2gjs1/lRSh8fsd8aiwvxIMBXOsYQMgW?=
 =?us-ascii?Q?RFJrCQ+rOx7/Uky9q560X7TlIlbwYrVAacxA7eDFN1zTTZtaCHae7pX5k4qg?=
 =?us-ascii?Q?8WXsQu1qZfqXwjHs5c4Kj2cTc6VjJy0TBKJd1XpWSr659fvxIKz/IWdHtmae?=
 =?us-ascii?Q?+GZPOb/uB6Xp6HsqWiW2VYx9rI9HTwY/adu+rDHIctpOHlxoCO6v5XDUNkB1?=
 =?us-ascii?Q?7ZRv6hqDlLfovDuWqslcogN2U823DGWwNc7ROhgJT7dXD67+DhMTl49FARNg?=
 =?us-ascii?Q?dYkG8xV9zNdF5xCTVtJNl2nGGKFt9AqWejfNcbuoJhX1sizz+0eNtDngWLh1?=
 =?us-ascii?Q?i19xTRA67o/zdWd3JFETKUJMBvBb2NjHu1qjyMJ8ao7Kdhr3Ynzm8PmzKsoB?=
 =?us-ascii?Q?asHpn4Fk/Rpw24zmqt6JX6hvg7VYVJQA7eP5tpjGNtxLVnOLHshUouafrHV5?=
 =?us-ascii?Q?8D0k+hDdGuDtY+6P+gniaiBY1MJKkhoawajwdIX/uP+ejW4ioM2mtyd5MHiB?=
 =?us-ascii?Q?GBhHH8tz0wF7EAyXsiedouyIlNsa+7TeetuZC00KDV+avF7c1k0ZVxoEWWs5?=
 =?us-ascii?Q?CY2ApKpZ15pPInBzD7pLxjBjhcElcLULx/ggzk4F0EKsjPSo6vpK9dBGay6S?=
 =?us-ascii?Q?bP5fVwUDdDN0CUDdra65BOEuQpGB4mplO1FlZupjZyMqw5yjRHRVPha5chK3?=
 =?us-ascii?Q?CxRtimNaqBBWi9qydjB2t9GCmlISCy3HIVPfaB0f0AWIwzPxc+0d9VNGlafC?=
 =?us-ascii?Q?5R0PxoFzARXuAzdE/X81eZ0avpgOTHURZybEElpc7zmvqQ3KnWBQlFjgTlHz?=
 =?us-ascii?Q?I6FRGQvqVk6vbueHUWcAue70mc0x6v2TDcRM8i1Hh14CVMIk5/B9MJv7+mSG?=
 =?us-ascii?Q?0cG9G5A5slCNAOHX2qwO9wD+qndCa+praWB6wol5XgYAAtmm58boXmaBJkQF?=
 =?us-ascii?Q?lCKTh4aBl8pEFtgWkjo612+vRblUlcmvEpGbDEOZJyRyYtvRZyMei6/rF7sG?=
 =?us-ascii?Q?+Gg/xXPWaj+4nGhImulRWvY0fKARgY9fs358WRod6MtlgKfhBmOosYcRNE+3?=
 =?us-ascii?Q?FszXB3Zw/fpWB4n7Dv4r+UrZxbtdCSAwC8Q+pPqleXz0NcmRO8/Gt0BI0NsI?=
 =?us-ascii?Q?tQ4kZEr1ugvXI8RlFUto1769bZagLt6K7sqGQjF4r3jsxskbZiWAFB6+r7mi?=
 =?us-ascii?Q?3jpIv//c1Aq0TQiApaDphDOLm/dON96do43VE2zxxG8/e/JtQJ4s+WIOtlNR?=
 =?us-ascii?Q?Qvc+mSGeU+wNebqoxV4H7dQLGtYN+Q80ZKjDRT2ztZXs8wrGlNiexGToHpBj?=
 =?us-ascii?Q?nd8w/uZSHkYsDBTadyIjsgbJf8LIoZBZuWaEJm2xHDnau5YjlokLhLlyc/9Y?=
 =?us-ascii?Q?kJDlFZP8X/lpXrj7+sQMMe/iS9l1eqfkM88XX+q7WjERrpVHvF/wR3J8BvlW?=
 =?us-ascii?Q?ZocewF/vHo8NKgLjTWI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb059601-e3a0-4ace-82ed-08dd529aee06
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:12:33.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mfqiWceFmjqSyL9RPet+BjwgeSDPmtrNdvj+2D2DdDgZmPNmN+WZ6lj1rQTs6p0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046

On Fri, Dec 20, 2024 at 07:09:31PM +0900, Daisuke Matsuda wrote:
> Daisuke Matsuda (5):
>   RDMA/rxe: Move some code to rxe_loc.h in preparation for ODP
>   RDMA/rxe: Add page invalidation support
>   RDMA/rxe: Allow registering MRs for On-Demand Paging
>   RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
>   RDMA/rxe: Add support for the traditional Atomic operations with ODP
> 
>  drivers/infiniband/sw/rxe/Makefile    |   2 +
>  drivers/infiniband/sw/rxe/rxe.c       |  18 ++
>  drivers/infiniband/sw/rxe/rxe.h       |  37 ---
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  34 +++
>  drivers/infiniband/sw/rxe/rxe_mr.c    |  13 +-
>  drivers/infiniband/sw/rxe/rxe_odp.c   | 324 ++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_resp.c  |  18 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c |   5 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  37 +++
>  9 files changed, 443 insertions(+), 45 deletions(-)
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_odp.c

Applied to for-next, thanks

Jason

