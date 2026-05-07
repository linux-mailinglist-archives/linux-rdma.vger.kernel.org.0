Return-Path: <linux-rdma+bounces-20132-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH4pMdVv/GmkQAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20132-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 12:56:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFA54E7184
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 12:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D0A13010620
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC13ED120;
	Thu,  7 May 2026 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nL0d5s49"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012024.outbound.protection.outlook.com [40.107.200.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CD92DF136;
	Thu,  7 May 2026 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151371; cv=fail; b=N7mU/vEtb1urajls0nHyPZo7ikzEkrtygrR0Jfy1Pqrs9CWzXaxfYqlnkd+nTHWI81IOGNYixxuq1wEnLmXgKkG3EmB2RvDyBS5Jb7fuTgS68v05wk4uXB2G9O9QSx8cztfwQ/Jq0l+8zPM2+i1TPRRtrsCia6f6FNQ/InaqdOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151371; c=relaxed/simple;
	bh=q7V88fgP0LO+AWiCawboINHkUxwUD1r79w4+kG/TEUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IMCt3FzGu+3obx+aBczhS1vEqzD2OThILiEpYxcOyXlR5Vq8RIhPPnrlUfdWXE3DIW+hq+m+o43V+T8jth8FhShD14APaavgyqLsYVwcv/+r5YWweVhl1AQYB5Ovlhvo1w+n8hQpRyOo+MswDxM57+BFQd33cSXYlBQjegjjNW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nL0d5s49; arc=fail smtp.client-ip=40.107.200.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWoDW+xso8Thxbkuob4fLCvIp7tCIOVzIFkvNWApJfdHQ3z6sH+dMbU6uuG6kI6BfvNkeL8SsAThLZeFP8cJOvgXhyV0Ic2VaBe70J7yGrCsA4T2cQT6lS7jcXrMCA1hm+Q25QfgBM/WBM8uuoToP5WN0QkPOSW6RDKkdLr5Zw8i9R50bXVRS+BxQDlX9SA3/D/YyW7EhuRtD6xVsbB2FQeaf0VSi9tUVpQxglQt5cedZKB2vf5EpcObFue3zz9VdZQzf0bOpRKt0wzydrn4Vww8fu0kM3+jVpSFWUBZYcGPR8l2fcmHvZnp16B9dVqCStdz0aQJI/BTMXBgyXJC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhj6ydLyNz93vJ5EO/izu11icAaFwK6uVJdyKuDKkGc=;
 b=IU5++pLSj1Nf8PIhBQ6nxlvQmR7LRJDziIriTl7I2d89RLEX6v7yBR1j77e9UG2EUcnsA3SAJ3pvmjE22WhwZotm44NnooCtFvKv3HbW3G2D7ECkK18QCAYymQqv1QU8jdxS02acbxvByWxeGPy5m5hfMW3bomlvwP+TkUJZb1DjkNSSGICENEXKSMNs3gaeA/HnlkehZw5Qvf25mtHD6vYa3b3EeqGtU2N0FXQF9itwwjKNqD9z+MzPbQW+bIhKU5kUOwWRrqm3A25E+Xfyl4WeSeBpuvGucdtNz6SDhP+VT0CfPuq8HS5lXX3vK7DdAUzcnKN4TVeqH0UFbrayWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhj6ydLyNz93vJ5EO/izu11icAaFwK6uVJdyKuDKkGc=;
 b=nL0d5s49GQkQLeNz6JBjLaOqLnsy45dX6BoB9U2cuLdKFJjm3q2eIhjUBzBu0enCvCVmUuLsM4CCTMmSsm89NdFAXu7TAoSFLoTVh/LeoG79sHh45lM1gh54GCnhz3jcbCo30nFDesZS17C5u0xiNO/6XldPN/ApRU2RO9QAaFqB6btizpEd4fg12/G7VWHIARCiN3Mi+61BUqVtng6+xvxXUGxc5wg9MFN8OKvJ0PxHbwINkQSk/0kgrBabrEjYNPAriz+EGGAfRBeiryMLOPMVoJFiPrOhsjL+ezfo/7GOo+L/ejsouc+g9IbIYIbZqqFY8yDjdQQIMPYD/ygDPA==
Received: from MN0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:52c::21)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 10:55:49 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:52c:cafe::71) by MN0PR05CA0017.outlook.office365.com
 (2603:10b6:208:52c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.7 via Frontend Transport; Thu, 7
 May 2026 10:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 10:55:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 03:55:29 -0700
Received: from [10.242.157.67] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 03:55:27 -0700
Message-ID: <1d7235ce-8354-44bd-8f2d-fb3eca35bb65@nvidia.com>
Date: Thu, 7 May 2026 13:55:24 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net/mlx5: Fix HWS action unwind NULL dereference
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: Tariq Toukan <tariqt@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260504220725.46686-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20260504220725.46686-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3909e1-8de0-4a04-2ff7-08deac2732ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zhGhBTEu+CvEYmoxZwMb05PuUd7RDKEMKTkHKpueYRu+yMfVlp3/ULsYUAbNgW6Kr2I2C3PoMXZdzViY5hJISKEIJYOdgP8iDmWUpb9waYSaEJeRQtShyZd8oLuBMSgJBW6RJQe+CCCdpQeko0ey6EazCqGTWIZPPbDPYbClCXNiWKP4yXBI4zoSApCGX2N/+rj2837HISmaRFzsskRGOpQWRApzIsnly/p9Ra6LeKSxhhbgpI5OerNfTXTpi0rINXjK1ty0Key2XZkAewFAfVUxW9UIvmvgT6VC8hFdd2YQsGjfE9GdXuoKBcXAKZI/dIaS25AI3G9k34IKkFI7Yioa4mLUQqP7c9H3lpKeWKmGMahBIJG7Hfyp6P3qa7+fOdqpzy4JkUjSD5WRrhkT8gp8nPhjzAGCBKLgP1VLfxwEEpKUF6YcDRJbOLM5nn/qE9CppU2iJr1cd4AdxffAEpUPYlw+32MuO18+GG+0FXiVZUbbVvRBno1ps/vkAETNgGA9imW5fUaYHe/KTsZF+07fWDR6hxp1JHi3BufBuyt/wondSxuYP5NOKyREg6rVuo/XGW+NmHzhprEv+WujfnCCmhy+mLJv3tbu6OREPwbubZ527YYXBNjsTaSs+U7wpiwGqLvWdPnYntgdzvzNYQnAD1Ud0lHXh72smBOsTbBaZCgfbUHuiPtYL6lzTywe98WEGtbGrHptn9/v2oB1WIxOvOv4ASWaZC/U52BM3Jg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	a6QUC+Yn3o8LvjcD0Tt4/4MdD+7CxVWgblD6YcgsHeklzgHRNkzq/o6fZWc3HWq+u++Y6uRHqj6I4LfWGReocvWFOLcVbgb/DfIihCiMqhQ/mVSdYrD1qJpL9Cpl+DfVWeEbxD/HCabk2AvGmN2xOsWkppOMsTuvQ2WmDTyb19uv7y+AJcKC0hgexQMFlICahcljbUHuotXbAPTwXH+/+JkdpDczqcuaLyeJ+4Ye9P7MeAia0SB3/83TgjRMjFsc5Eb7tjEefuEGibZYm2dxoXgMsrBsKLnNmGfIhQpC2CvTGjBoHb59+ZC2K9U/91A3L1Aa75nYLcTIhpxLhxrV3eO3xVBHr6hH2JrqVZjIA84KavEFZzfuTRffnLGCa1Vj+ACEkcrumf1wJJCb81qL60idSJbz+YrkqONYLeXL/a3YO54mxN9NayKKHt7pl8oU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 10:55:48.9351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3909e1-8de0-4a04-2ff7-08deac2732ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270
X-Rspamd-Queue-Id: 6BFA54E7184
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20132-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moshe@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action



On 5/5/2026 1:06 AM, Prathamesh Deshpande wrote:
> mlx5_fs_fte_get_hws_actions() stores some destination actions in
> fs_actions[] before checking whether action creation succeeded.
> 
> If creating a table-number or range destination action fails, or if
> fetching a sampler destination action fails, dest_action is NULL but
> num_fs_actions has already been incremented. The shared error path then
> calls mlx5_fs_destroy_fs_action(), which dereferences fs_action->action
> to get the HWS action type, causing a NULL pointer dereference while
> unwinding the original failure.
> 
> Track whether the current destination action needs fs_actions[] cleanup,
> but append it only after dest_action has been validated.
> 
> Fixes: 2ec6786ad0a6b ("net/mlx5: fs, add HWS fte API functions")
> Fixes: 32e658c84b6d ("net/mlx5: fs, add support for dest flow sampler HWS action")
> Signed-off-by: Prathamesh Deshpande<prathameshdeshpande7@gmail.com>

Acked-by: Moshe Shemesh <moshe@nvidia.com>

> ---
>   .../mellanox/mlx5/core/steering/hws/fs_hws.c     | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)


