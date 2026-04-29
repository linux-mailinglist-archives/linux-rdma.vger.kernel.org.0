Return-Path: <linux-rdma+bounces-19743-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBTZAgdg8mnqqQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19743-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 21:46:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB41499DDA
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 21:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A573C3038A72
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 19:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027DC346A08;
	Wed, 29 Apr 2026 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hh1WZIJ1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010024.outbound.protection.outlook.com [40.93.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583942F360A;
	Wed, 29 Apr 2026 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777491969; cv=fail; b=hbXykUoyM6Vk+v8Fkb6ToyRyjuOtd32CsX1AUPi8QjVwE5C2cwSIpmjLEOvlKhR0pkfUxdyt5Dfpt5iFeRcHBT/Um+/yex9J4oCr8dbCg52/0XqjmcVKq4zOQSVmUgP8uDoxV9BlRoMfmFn1Cn2Qzyb8oeUPv1xHRhl8yFiRxEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777491969; c=relaxed/simple;
	bh=pPDvj/fEZoZ4TFZeZUwQvPr5ey597pATVe116/0ega0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pn9k3wfRHne4v4F59i+lbmdMUMcKr/dhUWXWNy21xkwDlkTQaKYs9CSWyuE+d14qkOkQr5lvA8x59NcEHv1+c19PoostTIT6ts3rtNjI5ZEtrTYOdYD8caDNWj/PTF02eiastlWybnJsldttbv2yh+lhgiZWlt2vz7fu7AjqrNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hh1WZIJ1; arc=fail smtp.client-ip=40.93.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUXLjKQWeae8fJKkPD2Onx5rK7D3njeUmO2RHOOFnjHCa4509/IUUzNs15kPd0J7natE9ZnuM4dVRxX2xIAIuhVzom15bhnWwA+AXqAJmz0s2aBsnrbTZ0QZQUYlpxqT4akCfC5Qtgc0BYNNsPbXFQ1Z5wuPLjCU6vK/yVdRQsyABtgVDXz9YcJyVU7Tmjz9WZ0q/oekpQ1nydRL2NbIEiZgM7b5CizAguROWEkjG9cL0y+H440WjUKP405W8HBY8wqLXA4+KjnnMSDajA1uDC1KRyEk9a0v9I8dKTxAMkAZNsr57uYmER+Sht1Ae15aiYiA+jqfRu0Zl6L28ERCMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2ezGzY9JpMHaLBAqC/KxbmgKpNQ4jhqwYQnaUgdS2w=;
 b=UOceXNbGf7/k2l0EuSnUrD/IToKn+Ze6Lel3bM/0aMLlQz+2DThdaoe4ZJPiEMi3zyGpwN6NCBge5A4bNoj70RU02nmxYAAXtkjtiMzU7ay8DSCQNCE5Bbs45hrLJ841KR9GS18su2Iqlb9FnOi9domRxztIrkgJoPMbghCyD35fQTbOcyK3qo/qOeg3Cge1yoSrkpulJdSzEb07EJF27pwQo+Ju+tMaV1Ue5fv10FGlgrhkuNlEKeKVuTtCoz/U/wGd5ca7Z9PN5+3aL5US3qwvT3XDPf/rOVoQcUssCSK8j95Z0LFBBAnOAmyQ2v2nCsyJELB+dyDCqiZ9DthlLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2ezGzY9JpMHaLBAqC/KxbmgKpNQ4jhqwYQnaUgdS2w=;
 b=Hh1WZIJ1v7954jtzAqIcPiFQRnP3fKm3U3z76ZIB7RZHlS7GUaUvHtD4foRZqO09sMk35dUngE0+kctC6YmSwrv9MgIKjdlfq/Q3fPyFyXQb1T0RQssrN+7T0oZU1gG+/nPtl/rdJCM4nu1sVqHu8DLbo16A4eE4OWAJ+twKEDPV9Txas2LON2wv+YJA3OyeRm8dKtsFJZV40h+NXY+dIME9f2thMWUky4fxufRGpx5mP7ahuPC+jj8IJnCpjLJccgUiK5DXWonrG8jZ4DNr29IwyY1iKY7Sa8nRZW6R0kDgZQs8GtvJQtYOc1o2ib0hI5CTdiDx8ZHXb1C45KFCrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 19:46:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 19:46:03 +0000
Date: Wed, 29 Apr 2026 16:46:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Chiara Meiohas <cmeiohas@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Gal Pressman <galpress@amazon.com>, Mark Bloch <markb@mellanox.com>,
	Steve Wise <larrystevenwise@gmail.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Neta Ostrovsky <netao@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Doug Ledford <dledford@redhat.com>,
	Matan Barak <matanb@mellanox.com>, majd@mellanox.com,
	Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next v3 2/5] RDMA/mlx5: Fix UAF in DCT destroy due
 to race with create
Message-ID: <20260429194601.GA478597@nvidia.com>
References: <20260427-security-bug-fixes-v3-0-4621fa52de0e@nvidia.com>
 <20260427-security-bug-fixes-v3-2-4621fa52de0e@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-security-bug-fixes-v3-2-4621fa52de0e@nvidia.com>
X-ClientProxiedBy: DM6PR06CA0076.namprd06.prod.outlook.com
 (2603:10b6:5:336::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5b36bf-3f01-4b00-15f7-08dea627f228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	viFhn/Xe+P+Xo8UyheMgLnkaQWgYvtnYRJP+zR62/FBR/mmls8F8j6TpkLLnYnwn1Xo4dBk5S1/8IY6edE5NpwA5Yu0XblgDY2+NcVp2JEDgMNx95D+vOanuluP7X5q+ZVo0IVW08uPsyy0cIeGdnaYxbC0H+w+TuVACPdCyEUGS29YVMIUNufolaXBB/73X0xKfEnyynO2c0Ett1wpUeWkLxR1f5c/D7Kprzk0+LYy5l/6DZxMHNFeuBFsPel2ZkUPcuV46pG409e2Eybw2i8BzG0aw9azQFPAFXmGjwH+2PSjmFPQQFOhmjyw+bTV9FgDEKtiRVUSpA4qrAB4eo5bZITfZqkW7sIJWZzdo9KQfrH3I5tq06bxzhU5HEW+CY23ISRhOwAET6qK0YrlZ3VLqYwmkfQGSSQfGas+j1wjc7expvSSwXfRsvp1/Ym90X8J+P7yzkCK5ctGWYrsTRw8dw/MOUuiiVTYgqLbjLV3r794zJCrc6hMnFEP4Gf6nJs9pvptY3iEmJNqZs1I/ZtbWTdHbs8m2TG7iz1auxCJ5qCbPWcEKUClzaafLwbip1u+VlIKnnZ96Yt+7+uSVNBytGZvS6i4Xp2OauB01XE4Pp+2EZfAE+5xhR6LjlqUx6O/S3N++sxr9C+YIk9Hx0drGgy7G14SjTBDWDxmRnUWTLUrxyz+5/unTwqhzRuhP2LSyHF+wueNwQJKV8GtiTpgOxPwQrDUNk9hDphSbIYU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oUZmkj65qG9M5dvBSgTpqNSCHU7sssdZyNv+GLnafCkMJGMOHwmuSu0E91NA?=
 =?us-ascii?Q?+JBcwKeiRer/eNVQsMhdX9UGPtkznEYZlQbXqXy/QAo/JDyaK+P9MoRo8Jm3?=
 =?us-ascii?Q?yg5GduqpMVHRco7W9Cgzei+bxO795eClnxMbhrNPCAkljHN6GhNFK4cREcXN?=
 =?us-ascii?Q?vDoRYizgSaZsHeWCwvg1RAAw5t930Cz+5pEsAuJTPcdrOsXv5/O6fWfMgLxN?=
 =?us-ascii?Q?GpyBaoIgKDdzuEVjwhz16DrGrMaJMDgQMloCHUYSKxv5TwmDEc/5RDG83KXB?=
 =?us-ascii?Q?FxerxGhN0MGshw2KncPz6NtSRXVD+1WkdGsEbYOSbxC7Hp85WgZMJRkKkC2T?=
 =?us-ascii?Q?uZvyCFqJPCRpS5FDvXQ3EU5CHOJwyD131/eCgTQjfGpvgA3dDNczn54ViD2h?=
 =?us-ascii?Q?xcbz3tOqTQIFqCYZ0aLuv5/B+F07GBjrs6ZsJYKrtXYgFAVBaoz+6bJsfUJA?=
 =?us-ascii?Q?dzSpTCCphmAtJpGbas/kNvJhqY8PIS4MSD+VvscywoJ/EPi5LU7hfAm0gu/E?=
 =?us-ascii?Q?NgnHM3Isaxv9TE/1aEE0L0CEVaXorZpLWvp0D0C1iAGoOP5E72pZJv1VPhwy?=
 =?us-ascii?Q?wBbEF3RuFnTVO7UmhZk+9+O9CBfrEGYQt/C0/aunZHKiJEqSfBWDxJk+PcI0?=
 =?us-ascii?Q?sNLelSXmishbFpXzK9mxvFJu90pkDV/vuSB+zDF+B+ODjkDwVALcoePsgaur?=
 =?us-ascii?Q?aVVO91rFCIq26799mCrdQ/1l+OlcF0iINL4AK8ueZOQWM89TWIWXUUHSeJxK?=
 =?us-ascii?Q?hvaog64wh1p82vIu38mPxFGMHwD3HnT+6Gq9/vj17HCO5CDHCYKJjDp1qmi1?=
 =?us-ascii?Q?dOD3UDkmV8zSoua7nIY1ZkHLe+SXBhep9tL+wntr1BJY8Adpfp/YElQWm8Gc?=
 =?us-ascii?Q?OvRjyprbBmpoXNsPpXSvs4s+LTd9C9Aafj5DszHzN0tNDPkoTqFsPRwTMSk3?=
 =?us-ascii?Q?yHVCwWLPUVoksn/gcXLcoDuhEsW+7JrGBPm94Q5zGDH+9VIeT1tBEExxlRLR?=
 =?us-ascii?Q?nbsWRo3lwlxDz3D7f+pCP4BVE7V4MFun/tcgvv+/DfR4g0so21Jhn6GaaUok?=
 =?us-ascii?Q?k0z/dGlbX4L1PXG9qdL4zo5Am43GtoymJtVVJoPagg1d8t4lJow0kTW1DJNH?=
 =?us-ascii?Q?5dxVQ2G9tOYenY/Npil3CZ2Yhw5S0Z/OugR+TJPn0r2XhC0uNYMl63oL67lu?=
 =?us-ascii?Q?ChVpmpGbr8kmmjaLLD0FOg7OSzMFuB5/b7jk1VlG3bDCgj3fu7buRTrTWcDh?=
 =?us-ascii?Q?CvqzDMimnVKRRyftQpxZ0r+1HLdklZT/OD7UdHYtvyUOdyGmTjXlsB8WokPf?=
 =?us-ascii?Q?cY/AwZ4yOSWIt/syiIl+vKvFy/ShMNkjbjZgStdMkPDK0Juqu04obyxZwnT/?=
 =?us-ascii?Q?zMQOugYFk9GkG1K3mI3pbmU9hKACtwIwQ+SEfGHiPyKxFA2T6BPNd85zezR7?=
 =?us-ascii?Q?4fkf9BIz30L3lqkbaBpkqiI6U1IZXO+h1IT8FzvvX+7a0L9/W7YofNlDnkSC?=
 =?us-ascii?Q?Je5IAkPP9VMpcA80wHNyX/JUQbkYTkWdDluPnTlcGddi2KcNbZK6OeYao0Cg?=
 =?us-ascii?Q?c0cAgUz/qssFY5+a3v+0zN/1zVPCfW+j68jwVdZY05R9BTH5jS8HI83Y/GSD?=
 =?us-ascii?Q?rfEkoFUJNOzhPq75RHIIbQdi5x+YWQ/1eODEpyDANznnHzLIIiWNPCFmuaRQ?=
 =?us-ascii?Q?6H9um9Ukef6D1vLir03wDOau2S3khqbVCOSdbY0RZHr0/YRL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5b36bf-3f01-4b00-15f7-08dea627f228
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 19:46:03.3158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cNtzfjCnGmLnzf8AxMDGfWzsWDcy5nhewnJiF7VC7M8TYQZpO7QGHsOCDXFZJMg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
X-Rspamd-Queue-Id: 4EB41499DDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19743-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 02:02:33PM +0300, Edward Srouji wrote:
> A potential race condition exists between mlx5_core_destroy_dct() and
> mlx5_core_create_dct() that can lead to a use-after-free.
> 
> After _mlx5_core_destroy_dct() releases the DCT to firmware, the DCTN
> can be immediately reallocated for a new DCT being created concurrently.
> If the create path stores the new DCT in the xarray before the destroy path
> erases it, the destroy will incorrectly delete the new DCT's entry.
> Later accesses then hit freed memory.
> 
> Fix by replacing the unconditional xa_erase_irq() with xa_cmpxchg_irq()
> that only erases the entry if it hasn't already been replaced (still
> contains XA_ZERO_ENTRY), preserving any newly created DCT.
> 
> Fixes: afff24899846 ("RDMA/mlx5: Handle DCT QP logic separately from low level QP interface")
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/qpc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/qpc.c b/drivers/infiniband/hw/mlx5/qpc.c
> index 146d03ae40bd9fd9650530fba77eb7e942d5fe79..a7a4f9420271a228e161aaac1ffa432d304ce431 100644
> --- a/drivers/infiniband/hw/mlx5/qpc.c
> +++ b/drivers/infiniband/hw/mlx5/qpc.c
> @@ -314,7 +314,14 @@ int mlx5_core_destroy_dct(struct mlx5_ib_dev *dev,
>  		xa_cmpxchg_irq(&table->dct_xa, dct->mqp.qpn, XA_ZERO_ENTRY, dct, 0);
>  		return err;
>  	}
> -	xa_erase_irq(&table->dct_xa, dct->mqp.qpn);
> +
> +	/*
> +	 * A race can occur where a concurrent create gets the same dctn
> +	 * (after hardware released it) and overwrites XA_ZERO_ENTRY with
> +	 * its new DCT before we reach here. In that case, we must not erase
> +	 * the entry as it now belongs to the new DCT.
> +	 */
> +	xa_cmpxchg_irq(&table->dct_xa, dct->mqp.qpn, XA_ZERO_ENTRY, NULL, 0);
>  	return 0;

Sashiko is right about the 

xa_init_flags(&table->dct_xa, XA_FLAGS_LOCK_IRQ);

Please make another patch for that.

The think about the xa_cmpxchg_irq().. I think that is not sane.. If
the FW has returned the ID back to another thread then the FW is no
longer allowed to fail this destruction, it is already destroyed.

In this case the xa will go wonky, but we are already pretty lost at that
point.

The logic here is probably not great though, if the xa is mangled then
we should still try to do the firmware call

Jason

