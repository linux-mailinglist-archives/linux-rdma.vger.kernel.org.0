Return-Path: <linux-rdma+bounces-18889-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEW8OlXqzGnkXwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18889-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 11:50:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACEC377FD2
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 11:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70B693006038
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 09:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88DD3CBE8F;
	Wed,  1 Apr 2026 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X1iwAytM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7CD38236D;
	Wed,  1 Apr 2026 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036022; cv=fail; b=lt1DpB1JK4jQBq6U+K94VajluDogoWlOx/syzKBMI4sMA2qkKqLF/raaf6GIjQhNDEjAX6aRh1XhRV94qSIet8Dxq5vIHL+oehwC7PMTNF8Bqaz2dpasPekug/DepKI7gBPxUvMAb5D5nnbWeFevOeYV8P2cUQwT19vQtR1WPM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036022; c=relaxed/simple;
	bh=Ewy2kWpSiBC8hzEjMAJVJhXnQ6aVsHIxoOUIiAJKXt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rXsV4ntnlM3fXv9OCnrYXj+YUaVhlZZGqOXnm+aLFV/N/YevlRCZ7BfWGR28X6EqCYVrqs5M2NnPt44i7ATM1VU4Izx/nsP8lzEtF6VIpBdzR33l0kC06axFFRIlQg2LkwPQXY+XiS84Z4X2Jw+jTQ5UoWj1HmbFGHTqS9CG2sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X1iwAytM; arc=fail smtp.client-ip=52.101.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udOQrxdiAFCy1kK+97MMEoN3kRWUCSaLIrKjl60dnWtlIFPh2BhstorE1sO5MJoXMEerFXHD64rkFXM3i+P0aT2JTueOxOIEcs7L4ZTz2Zh8CQL6RLXG7+H1FrXfR4am4y60LMJPhNehi1q1jlZq4PvHdPE6jRplzhu/OeAjYXhIPhF90iXOlWhPUOOs7P9YdgzWliScYSmaunssdsr6wu3N7+FZaqkr3D2dsfri3Oh8kNstM1YLnvoXGtw76P1g+2yPPkdM/e8PK9m4+Tb2yRUUfEwwE0F0TpkYhAAd2wdTbt0mePS3dXe8VDaptX/+FW2y8GIRB1bVnWJF2nXH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1FP+RNVSbin0fJjFywRM7LSFFfwPwTf/7oozaPJPV0=;
 b=GoMRptIpqtCkwmyjBmcDmF54vrIaMk1XMnwCW2/beTpgbQluly3D6nlxI7/3EDH0HxWS9mhJuaHoRXLCG+tTb+YOQi+Gmgd/ER9YNi6UHfSiP1d0hXWC/t/R7tARex66mu9IRVrGv85KIAab+ysOMNKpItP3vsBdDkH3JmfXx75fmAW3//LkJTwgZL5ipvtTcg7NIdpecY1qDMpz55sZgSkTADAs18lB1ERr8BxojY7tjrsJgid8vwaEYgJEVrMvmNmgg1AVliPfmnkwikPQwDpuW9yPxBydob3I0Ih3NdOAE6lEQiZAkm7CkgRVlyCevRDl/xik8Tl6UEmKO9uhdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=bridgetech.tv smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1FP+RNVSbin0fJjFywRM7LSFFfwPwTf/7oozaPJPV0=;
 b=X1iwAytMUogTnVV3cjCPdbfeuSR3F7F+namIf+YyBxH+l0Il+devSWThkEt5axeapQluiIsmr1DmBhu+7TDjgzWSg6lJzPO7FtVNlvtfUqg0IEOLWh1VKU3Vd30iVlXLeSd0tt1aQivoJVHtqTt1WRG9SdGbLYf8abH3pI8IWF9qgZkDo6NUcJqCyXTMzWphS/HGeXd+CeOdN8Kdr3TOf/Vn0hip5ey1jpgp/Xuffe75hKzkGLQjfKTAGL9gv5N3Q8ExXeO33+ihGw1K+hk8ceWk7v05YJd1+fuElPgw794oKkoRA59Z91vDGogxV0O8E49C1vCXxiwtBIVTCEBvMg==
Received: from BN9PR03CA0245.namprd03.prod.outlook.com (2603:10b6:408:ff::10)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 09:33:32 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::52) by BN9PR03CA0245.outlook.office365.com
 (2603:10b6:408:ff::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 09:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 09:33:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 02:33:16 -0700
Received: from [10.221.194.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 02:33:11 -0700
Message-ID: <76a4680f-b3e9-44b2-9661-7219d7e3442e@nvidia.com>
Date: Wed, 1 Apr 2026 12:33:03 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: fs, fix invalid pointer dereference in
 mlx5_fs_add_rule tracepoint
To: <kenneth@bridgetech.tv>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260328192008.3525475-1-kenneth@bridgetech.tv>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20260328192008.3525475-1-kenneth@bridgetech.tv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd49ddf-2d40-4d0d-2951-08de8fd1bda8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	AEX3nYUc0xkR5fTEdrk54/8YvOs4psLChKMtR31+HIsxwaqBAH+yrGQOPckHOghsI/OqesFFBFyZRilQbzG3a7qts6CqPvffC2x85cMkSc7aiO+3KHKzwPtWO4Y7QvAmnZy054ASCyv3FZGmaRL3Efbv2YcrL9UGWf8ORDF7NCjQ7PuN7EO3ndyjL71nwDRz+NrbY5GjqszeqUPrNPa7AX1djGCznFmNQFYca2aci+FTJ+PyH+v1eev5FXtVZuOke9ocqsA5jCP+pmlwZSTLGenRFpvpLrFHfDZTx8djhACOQ6DWi7vAR4JxQYdyPSRyG1HgzTxs1FuYGCr3w/mze+KhvNno5+Woo+ZF9GpXZyu2raVYe7S+zpO4p5ke5eiw4KH6PBiEtegkagciSVwIHvXwQvqfy7X26OPKcxwglYna24LzSvD1ZbrpyJy3ZphJJAqZryGFOEXBksyX8V0ZoTfMP8sSUGYd2ThlG7N3IN1KkWKqKvD9TlV3smXQKleg482wgBJMWLdbEp35n3v/KWrCJuIgXlZC9MwrSxtSFZHC6VbkHuG0kvrrDw6LKpafOaYqvGoaFjRDjEeHffm8YUjCNrX0rhYYD5/avjFTDHYBrBNgDNAe46XstfurlhBcId+lkOlq9RcMqfqr8dsUUkonZLiarxfPbvaYuTbskvgYgkPMTMMws4CqqyODz/wlJzO113KSDElIfyMLodAO8/xRxkfL52d0uiUBsF8SZQNORHw01SOV9p3RBJQpLsbg4h5s4nTVgQJDKophegTGo185ggVjouFmWN25tfRqoF4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NWum415tCRKjbHiqwy37kWMfgo7sqQh/UNAD8y95RLgWxeQT5XlaeC1KjngKqSvNIUQ/DEQQFtBXCzDhmLsfM325VHDoSIfP1meZ4r0GwX6c7G3pS7shN7+8U6ySyVnt9s5q49G9kouh1Xw3cMC6ZxJ9D6SNyp3fxqk/i+TiEny+JdVzDU/OyYFAWhHkwon3cNR3N2LAAQwWEpApx2GLMvyNss55Wnc1T4T4Z0lij0StqoOa62yi9mYCciroj0Sb0mKFhNIb5s/txwYI9UCOQ67v9QhYMP7DJMWHjgEhd7s1TV0k4viO16TsNNrv6/i9532KJbQaunkSrS8/gxfTkOfysvT8Yqr3ISm5KPUHr5OvAO4SbpWO8g3AeLJqxxG9qfiX/mjnR17q76b9gDeMqipO4EP/D6aIfl8d3THhU/rgGGYKSgRvpVJBKVrgUhpX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:33:32.4193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd49ddf-2d40-4d0d-2951-08de8fd1bda8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-18889-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bridgetech.tv:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moshe@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2ACEC377FD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/28/2026 10:20 PM, kenneth@bridgetech.tv wrote:
> 
> The mlx5_fs_add_rule tracepoint has used the flow destination type in
> a bitwise test since its introduction. However, that's not a valid way
> to treat it anymore (if it ever was), and after commit d639af621600dc
> ("net/mlx5: fs, split software and IFC flow destination definitions"),
> this mismatch caused nearly any destination type to be mistaken as a
> flow counter, and thus stashing 32 bits of the mlx5_flow_destination
> union into the counter_id field of the tracepoint.
> 
> Later commit 95f68e06b41b9e ("net/mlx5: fs, add counter object to flow
> destination") exacerbates this issue by converting the counter union
> member from an integer to a pointer. Now the tracepoint dereferences
> whichever value is in the union, and in cases where that's not a valid
> pointer, it can lead to a kernel oops.
> 
> Fix the check. Reported by GitHub user whi71800.
> 
> Cc:stable@vger.kernel.org
> Fixes: 95f68e06b41b9e ("net/mlx5: fs, add counter object to flow destination")
> Closes:https://github.com/knneth/mlnx-ofa_kernel/issues/1
> Signed-off-by: Kenneth Klette Jonassen<kenneth@bridgetech.tv>

Reviewed-by: Moshe Shemesh <moshe@nvidia.com>

Thanks.

