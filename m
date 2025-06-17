Return-Path: <linux-rdma+bounces-11407-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF73DADDACE
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 19:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 894F07A5717
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 17:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD2E2ECE80;
	Tue, 17 Jun 2025 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PjnU5W5T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6112ECD3C
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182065; cv=fail; b=uHgPCHo/xlU85Ib63p4C541jN+O6+VDKDj+Vpi8XshQWntdvIOyMuBv+ma0P4CFBLTEXzQj98RPLaK3jq2X/KucKCDF2v0ySQQv6cl6z/TKNkKahg6hrSRN+SHD338OofTlum1U0lnYk/4qCCAJ/DQFAaw33GKvMmDvA2V2WQAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182065; c=relaxed/simple;
	bh=G3PCX2y7i88qh+3rvfyUerl8zRgsOe70qr7QRlosIKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ccxv/p5lJmoEhSSQ+UE2RFlTBfS1DSqIH+vmjxbETfeef8amQklAKGAuzf5dPHrlKy3RVqtCChZte/ON/W4kGzGU3KmikOg0ZtTaw0AmOHHCwN81kcc6+0NpW8McmkFQ4/4CC2NfRYmNA/zW5RBw8gQL7WQQyaVBFO9BEUu+n6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PjnU5W5T; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRg1Qv91mMPBAK3yYInmHQd11mw3YuOI7n7VR/m/S4/Pkk7MKiUhSUY3HBwY/1wp3CIvNg2F5IR2dREjAcJGg56O3ZPHJblZVD97DD+wYtZozOAHyaLj2SsNVbZWGrqDmAuRwVru+nWbRpUALoyfrNbA8+XVmxKwxpfI0UbMDj+MKxvacOyYxC8rgvNAmxNEBoAaa9jWiwJ9bOJcjH94wvamXHUZ8KxmBSihwS0CtPpiPWfczkEwqfJo1Pbor8FMdau6ca42P2dGHZsI+jHCXlkVwdiJLK1PV8gISDX9R5VAYZqn8CdU1BGZB7n1Y5wNI1KUn/knxMV2qj7K+pvqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sL6m6MIS6lAiR8VXthMuwVjw7hI6IE5O84/o6G4Mbx0=;
 b=c6hzGJEHdHyycEU1JVStJBizQbYSipaHpNOxzs2V/DadEaVfZ0iEP+6J42f9bNpyenaZYXCbuTV7Z0J1uJd4v5pPStz5sI8TQ05ZHmNzxjMnVXdqsJUWvzYItoZ6IAvR2s/Dm/FSpo1lfZQblv3Z5RJAjJEBdTjnYS96mI2IcIEzwkZG8DBh2Gvccgd2f9j8llBqM/uUkflNWzZsImERe3vYOFqzYOcz1/qtbPJGRLL4Y5a1yzwO1uv0sKaBrOVsjWtbZAeNoySfetWagaoOLVFlMel/69U4T2h0lDz96gCk3FW9h0XMyREK+qWwoVKCtE++uj5Q0hQtHqJUBZG1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sL6m6MIS6lAiR8VXthMuwVjw7hI6IE5O84/o6G4Mbx0=;
 b=PjnU5W5TfnF2spWpwJYrJQDbBvv5RFxuVTj8m41UKPNcIL1yr1nymjs4ZoWTDZKf25X6r41b3sLP926qqpPecsZt7Kqkf96O7ILlL9kCQqneqvqKKC4ihs0qMERqWBmjBQV1RwquHi8l8xDv3xGfyLtK1fvuq2AEHWuj3bQD93obYuU1Y6Wg7Tz8sVljfWsHypJ3rgCSxuovmye7cp085/jwNb5eeKOJOD2layfDv8SRsURoEIuZ2l+4VlJCH9fzYyq6lIj1v1ub0uaAmFepwLQrpcaTdsxJmv/5ZYyRnF+QWpYurkydcnmCodTgVr2NnGjS/dN00csrKWDWHMGFjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 17:40:58 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 17:40:58 +0000
Date: Tue, 17 Jun 2025 14:40:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Rate limit GID cache warning
 messages
Message-ID: <20250617174057.GB1569186@nvidia.com>
References: <fd45ed4a1078e743f498b234c3ae816610ba1b18.1750062357.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd45ed4a1078e743f498b234c3ae816610ba1b18.1750062357.git.leon@kernel.org>
X-ClientProxiedBy: YT3PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 6347fd9b-ba25-4d52-0b52-08ddadc61e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?85RXuLCfPiwVaskV6FxsdBIm1UoAtnPowe8vIIMOr3yklaZgkKGcKtpMglnQ?=
 =?us-ascii?Q?bL8eTWADT92psenMLM65ufaCsHZNku9Yu3gO2wCsfwU081FVLiVK4ymIPOvd?=
 =?us-ascii?Q?8sV3we1ab0jgOPDA9EAkivY3kjI6j7967U09Kjr7GtzwBhVPXTU+2JXMvi1v?=
 =?us-ascii?Q?XzgTZOQcTi/Z17V70D5z5TgtDJy8If/7QzJQLb6F9KJkzez199n2uh47JvOi?=
 =?us-ascii?Q?Te7bbx9uugTuDOkWJVg8UsIjXMEdXpHqZUPB0+RoKgNZ1M19a+DC4ES6oJcm?=
 =?us-ascii?Q?dWp+nKcBJjOUOK9RWOGmllV5LxhFl7a2wfPMiXFpp6NOTN2vuXmrigbpw/sY?=
 =?us-ascii?Q?a0saAJZ+1TBr6f81omsTDTebs2KLRi23vjwrXNb7Ywgo+EmkaG+MxF+i2OxY?=
 =?us-ascii?Q?7l6gSkz4R9JkVGO+5QogCzv3YeDrmfgO6hq7bvKrV4Fv0owpnNt3QoGHtHw7?=
 =?us-ascii?Q?bGozsgjoQUtBANYvEmEhEmDugNDFB9tJat/m6p3A98VkXcDIG+Iq57rOHUN7?=
 =?us-ascii?Q?gH+q2HIdS2jwk/XxbtzvVXfxBP81cxtIs32ei7azq6QWyS3oq64q1fiuCOZi?=
 =?us-ascii?Q?blTMcLvXYLy5DY43ieEVZ0Lb6LwVsKGKdhNvmiiWCSjIEojMEaDVLaGZ4C62?=
 =?us-ascii?Q?n8W7X/yGvmhNk6bn71RY+bpB2Rl/SQ1eLJmumCSzXh0LHsaxmPWKMdJCGeyz?=
 =?us-ascii?Q?VvNy3r0k2Y7OdGVkaPSxWqGGw5F7dWEOXw9wLg0KbYgLV+U1oZa7TID9uEgp?=
 =?us-ascii?Q?KnT5HWZPZ6Wgv3f3TYQnXP7s18ZKjmVuTGICOWCOhjL3HSCQgcqhqZhJKzpn?=
 =?us-ascii?Q?tlAeohjNNb9dMzo6Ul1YKrOCQI+SlqDlDcEcMs+8EDZgNB5j5/8/OL7Og5di?=
 =?us-ascii?Q?PQnx8fOF5sEjdnPFa0jfxQ+x9PQ6IN/Kkfl7aSEvVyrlLp9wEga2TzNM967g?=
 =?us-ascii?Q?k+3JxhxREXiW2P9+i0AuTl4DTqNaBQYu3xG+omOjEosofEt4/GXdFZaynhxT?=
 =?us-ascii?Q?QYEUTQ2ftzoVEL3vO2VNNiwAedJCzANFaR9u3XKNP/BPJQkT0GojiYY1oLvK?=
 =?us-ascii?Q?3YM2CBSHbxDS/5xJ5dz+v4e9B4HPHsqclzRg1tH732v9TAQ6a2kf0RyjjoSz?=
 =?us-ascii?Q?6o0cKJOmk3xu3oAstKuPDjUkh9lieuv4GmvswLd0cwrzhe1z9zXA6n+G3eGv?=
 =?us-ascii?Q?P9Ft3yISUu2KdnGYc+icAQST2bplei9MiORFP2/ZHQohpS4AV7XhkkLhHzmd?=
 =?us-ascii?Q?wH8O4EgIKp5f5xr2IwvLpd8DfBmnJ/Rt5+AWgWTA5VuOb5mTqXWu2i+mDEaB?=
 =?us-ascii?Q?XvWs+ufPCLr4f4HaeLodT2S75fzoGN3YFAVtsp9IWCvkUhwV/5oy7zj4h9Pg?=
 =?us-ascii?Q?WKAeOOZ3rFBUdv9mxXQhsUkuCgsILXMzjYHIo7M8iDZgUmfoFSWK6bQFn/1e?=
 =?us-ascii?Q?5SDS3e7I19c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xwRyWxWRGvxCgB5PTx9ne/d0wm0sjMgb+ueRl7NWNz0PX8smvVMGjGOgOS2v?=
 =?us-ascii?Q?9I73o0TZEPrB1wLpvXBZHdpc1i5Ktp3YfqA3z2rgTaVbS/G0XQgA1S+ORj8A?=
 =?us-ascii?Q?F3DxGpM3x9ir4x2ZaRoMGIswQDT1E65/bZzgys5Y6j23ZA/kHCSvorl4xABW?=
 =?us-ascii?Q?FwbQX/4QUl1+6doPYmUBBbhPv5YtT4/ZQn54glEQJVaM6zyVjIAB10zASu5F?=
 =?us-ascii?Q?zlYHSAn2D5s2CrMlFoeekIsnFNxXQojY+a5k/LVOq06jKAbMBLGBEz8RhzWN?=
 =?us-ascii?Q?MQioHVysdvMLGOaXxR9dJd4AlYYrBDecol1RSxIRQaTHz3aC1F0tNN1BlRPf?=
 =?us-ascii?Q?3NJ8PN40xJI/K44s9dogjaJDV6AHXu8h+WOeoExKhvdzFR7iu67PSEfmPJhI?=
 =?us-ascii?Q?9B2HAxEtnD2oMNeKmHnw8cyMvPiSwaOvMMnJNd4hFRaVcDuG9rQ1GNf97LUy?=
 =?us-ascii?Q?ca8cv0t9DZXsRUgEQ635Tz9sQhsmqB8bfeMQGdtkrMASpJgtuzLwmDP3923s?=
 =?us-ascii?Q?FVeYEAbUumzccfQr27iNBWDF6ucbtU/yixTL+8B3v/zCMZFY31RlcfRQYQ+a?=
 =?us-ascii?Q?fSG0jnUKNP/UhDlZ6JeD40W+TWRu+peJ0APZVOIVKa/qmMvpBEJjG/nqUcPt?=
 =?us-ascii?Q?dLBrkY0qPfE5M+ZtTqAHDHxOq6J/QtaC9coO1BwYbWe0ShNo41ojHoU0rZDN?=
 =?us-ascii?Q?WG3SVrUqlaMA+OD+4AFkcINqYg/vGJLOP4sHaRXHPCbeTT/yiBRVtenVxp/p?=
 =?us-ascii?Q?siVUXr6p8cfBvkRALR+BNqowfLXFgGVkF9MtIoFERQmCx/ZmqELUY6NDVoXj?=
 =?us-ascii?Q?6lk6CT3Fj/+sNApR9RLfyQbMk93BtdZ0U8nxHMHHbkZRMThAvNaWqSepq89U?=
 =?us-ascii?Q?cQS+DG8e/mhlJOk4Jf4D+R7ibFXgDaKDx0CmqbUrVNCNhfFkg5/o6tMBXcZx?=
 =?us-ascii?Q?Pz/2+NEo/LWaVziC1pYV8Twawp+0FRh25hcocBhdBr5IxLs6X06mvU611NcQ?=
 =?us-ascii?Q?6KKeSdL6kw4dME1BKCWZexvRwJ/9qPI3Oq2YnWw7QwU1DlEa0om1yYMSRH1s?=
 =?us-ascii?Q?WF+D8ZH3/p3d6EOEhB1cTyhX9xEgJc4GH6LWVeahWTgPV1s44htk3AJeZHcQ?=
 =?us-ascii?Q?NGjEkSB06FhGrdTbv5oLgVp957TH6AhJTurPiPxc45G0kpmXfILuMjU4flM+?=
 =?us-ascii?Q?yOkveuyYgaw2vHmOEY+JfLBtNDtFhE+nTV77CMbs+mOoLkI6vLSpHVL15LN/?=
 =?us-ascii?Q?EuyNGBrTEYrj8eUUmotgOw2B/1+GnipU54JCu8+PptgvR2M8SrJC2NpBS4DJ?=
 =?us-ascii?Q?FT9wfNrpUZAS30Q8rGCNAw8pObfY9GX2SXNu0LKOue45B41AgMyYuwvaVFJm?=
 =?us-ascii?Q?YXiRIZaB8Xtp7lsPBR6GqDC71xDHFxG9nAeaTxVcwCpQ6UChHku8bgSMdjhS?=
 =?us-ascii?Q?Gfs5PITkjhw6OG7CQ0MpiMQPhWr+IbXBFbGHsCgf9x7OdB8Rw0pujkdIDG9q?=
 =?us-ascii?Q?B1RYKFnuQx1c7ki60toHUkk1tfqJplDyK71IObtbQhDX6zRdMhcy6tveZUkU?=
 =?us-ascii?Q?SL9yzIwyiW2DZn//7HIBUzuqJ/DEHhYmvhZ8MgLo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6347fd9b-ba25-4d52-0b52-08ddadc61e94
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 17:40:58.7573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFv/77Kw+bg668jnJ7daqyHxsa4aQyw+WT2SRNxONf5JRlWte7kFDx3lL19nJibb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045

On Mon, Jun 16, 2025 at 11:26:21AM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> The GID cache warning messages can flood the kernel log when there are
> multiple failed attempts to add GIDs. This can happen when creating
> many virtual interfaces without having enough space for their GIDs
> in the GID table.
> 
> Change pr_warn to pr_warn_ratelimited to prevent log flooding while
> still maintaining visibility of the issue.
> 
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/cache.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason

