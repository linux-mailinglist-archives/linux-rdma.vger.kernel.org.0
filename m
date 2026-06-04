Return-Path: <linux-rdma+bounces-21736-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fI4YLjkVIWr2+wAAu9opvQ
	(envelope-from <linux-rdma+bounces-21736-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 08:03:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1148F63D207
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 08:03:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=AN64Ki25;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21736-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21736-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13FEA300FC48
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 05:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD4C3D3480;
	Thu,  4 Jun 2026 05:57:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBBA199385;
	Thu,  4 Jun 2026 05:57:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780552666; cv=fail; b=uNnWz9SGf4VYnll6xleKSZlcvMnU4opMAfeDOfBfcQpoF1Xc8rNb1ZlRk+Q8aEHcx1Pym8sxuUGAzT4El1s62dx5OF61DZ5YKhTPNXOOqAWey5EBJy19iH/CnevoTs+UBacgRUeSoEpmLCXdEX4kUFR5NGcQ0CMxN/rJxkGIkaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780552666; c=relaxed/simple;
	bh=mbSGeMjnO5AfmgKzVxse4mXRdgydDJrBXMkf0Sg7rpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=os+yrBTWLl6KCCYBE6/nZ6eU9vg+IL9Xpr6aXmqkWBzHLuwcnb/t211+9tHevVTyKAMbs7zcU/ZQxhx/nZ9dZgXM92YKcGw8YFwtVll526AQZBtcHysFUfR2EcQKdcgjjdcjQnw0VE3aoyxCQW2m1aC7tf7NvhVJzFXi7nitCJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AN64Ki25; arc=fail smtp.client-ip=40.93.196.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odn3gahXbYXSeD6Zqrlua1JBAC3P53Vo9yMm0QIeb8UpjO8ArEFJCVIzITrBcAVFp0dRo1IeNgD/Q5oxvNIJG/KgXQ89hHUfw9pAUjnniMJOWFI3JqYPcjz4G9pD2N4hkv5PxroYNr75DJJZqKdQRpFd2ptHO62+XusfmbO9Yq7MHfcZzp8t0p3FL7MJjRR1ieLkkIA9KLMfwRuXwFsp4cHnrhf0+YqhIweVuzhT7LG3nyzcb+Rv9vvrUynYOBQcCEdtQosYlXJUquedjNtGOcjJ5SrbOhSbzl0+S6UPdaj0s2ZgL/12JHHRw4+MKSCBHgRX7gU1REeJboyivhd7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+44trmclcKLQlHmuTlMQo9eK6/WD3vO0yhZqRbaXUUQ=;
 b=a+5ADoP+poeSC6LgYTKDgNyoTbkQyasKsoqAkeZYdO4VE6lTyJijVFjF8Z3KRCPV1oYrLtVnyX03Mpme/XLEXu4GJVOgfB9nw1kBbtRwqhp2BdGeW4wOVbPYBwoJxxI6JMw7XAbuHF0O4SxRD36d90PlXmJb/F/Xf0fr3av5SrrA9fIAnl0uK+5LVjv8wYeFYog0/x13bzUb22E/mOQJgm+jl3cgxCzMt2Wi6UK1ZUhrlxA7PpQ1e367qV5KsbC+Mjg3IM3bf6pI26YSl1ZY45xbXZJ5JPfbtNrJdxJk/19kipv7HjcrScIUDZ5i46CQSvdTuw3pCA2OkfaIgQ/8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+44trmclcKLQlHmuTlMQo9eK6/WD3vO0yhZqRbaXUUQ=;
 b=AN64Ki25LwEPzA64sp11FV2FF7qAJUleJd9gtWEYTwW9CMpkILcLqm5Q22jXzJ1971t0A/VUxKR4CUwF0O38krJj1qjNVJqWMKAJ+5CA6HjWK0m8wRdCcvXfs6AoplYrwaInuv5QQFyFejA5qa+EHvNdv1xYa5OPzeAO0ujHNNuONOY6/5uf7oM+W/JvrPBg+riCNdeg35moucnxlCIdHD5OzKgKPAWvZGysWPupSLDKew43caxxDL5Yffn6zir4woc/SMCLSIVqrcR3xhSoOetHpa5hjaxlnLXVJxebmSUpThecANZTyvp4uAMUPnrAINORdryoQ1XJ7UTft743IQ==
Received: from DS1P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:453::12) by
 DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Thu, 4 Jun 2026 05:57:38 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:8:453:cafe::90) by DS1P223CA0004.outlook.office365.com
 (2603:10b6:8:453::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 05:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 05:57:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 22:57:21 -0700
Received: from [10.221.198.226] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 22:57:15 -0700
Message-ID: <a6bf6365-b338-43b6-86c0-8dba3c946980@nvidia.com>
Date: Thu, 4 Jun 2026 08:57:15 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/mlx5: Simplify cpumask operations in
 comp_irq_request_sf()
To: Fushuai Wang <fushuai.wang@linux.dev>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <tariqt@nvidia.com>, <mbloch@nvidia.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <parav@nvidia.com>,
	<moshe@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <wangfushuai@baidu.com>
References: <20260603072657.10868-1-fushuai.wang@linux.dev>
 <20260603072657.10868-2-fushuai.wang@linux.dev>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260603072657.10868-2-fushuai.wang@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 4454d256-5e6f-4cb5-95bc-08dec1fe2e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|921020|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EeTl7IXUUjho0csT/Bikhe+W9XXSYJhsV70Pl9yfaJ5SWavF+RJehZGrKtXVyt/S5d5YRDNHFjONoo5ST5n1rYxIextyl6dg8bDMiQTyjsgmcPIENVudkg6v/G196sBIOOuj6Lx4fi4wlDk5whM4iRPmp2gTBYSJFR3/HkYN0zqB7MTO2JpKkhYIQDg2lwFqhZ86UN19Rk3qtJbW9TH2Iev3Bf0vjApTyO0rsjVXdFCmvJaB9R7QhkNVvN653erzHjL8Uob3OCe8wmm51J6y3ne7eE36mg70grgoq0JdvjHX6hc0cs9Ih4uIhv6lS5PmNzJVHssOwWabLRwBgWcYla416Vp3JDSUQVWJF0otcHO3Xsa6d25zxO5CMwAsclrysHBgj57OvvXivAltsu1Wq0l+U6VFR7tuu2p44MxSWeE1S0faQS1qkog+iE11EgDOAlQgerBNeQp8J1s0rMUX3bSaN+J+/8AaCQ64hIwvB7xKKmUZAyPYA70NjE+FRHPkWzWssnElcmBaHhc+LEPlypRZNpVykIjuPho/yMDOx+QDjK8hmh0BoR4hL7dsVMkfjTebNNiD6vhC9vJoxmvaUB0ODk5Ni/KHPUa0EVVCeDMhtZN8b46CPK72P0N5Ps3q2vfOYWwgAfvGwr0Azo9Ja8cv9VNCQP9jGawE3fnKRniZkftiMJWoeL4FJObM4O2eiNVPO5gtXMG8aXJCiWWtGMWrxdVMLR76S/W2OYX2kr4gdn5NyJKY0BKU/BFAPIeuBGu/3qilD62y1kfZSnmDlg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(921020)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jqIARkFNDPkjlgEgoPyAXOFOl095HEPeQrrFOt2mXcQIM0nw41E9kun3VpMvj6PkI8oBowpZTt/zlezLDx9ErYQncnK3PjAz5+ZSdtLPvK+7iKxPVZ8AmwY1SZ9zDIaG4waUB7apBWKBMn6AYjoW5S1l0ihjNDM/DycItl/q99eHAgfcvGgkAyTpE0flz9gRmC61+iwQvlmtvGPcB+byx3SIwGuDe+3M3tji/jPqeAg8LoOuSinzFIiC8lUT3LtV8kTONgEPUmLreEErruKtDON+5G1uG+Qz8LRlptddcIHulMtlNUR62O4lZjDPsuzvqxTDJZmZ2HP9ALKuHuKyKUc9G7XSz8l6xFX0EoQS/K6EpWaH9+AiMbP14cy1hvhL9aK95gWNSyITCHk0pzJlkqqpAaaFH4kh64sYeFLpOSAGsFP5Ci43jXcBX5RjZ149
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 05:57:37.6082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4454d256-5e6f-4cb5-95bc-08dec1fe2e65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-21736-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fushuai.wang@linux.dev,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:parav@nvidia.com,m:moshe@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wangfushuai@baidu.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,vger.kernel.org:from_smtp,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1148F63D207



On 03/06/2026 10:26, Fushuai Wang wrote:
> External email: Use caution opening links or attachments
> 
> 
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> Combine cpumask_copy() and cpumask_andnot() into a single
> cpumask_andnot() since the function can take cpu_online_mask
> directly as the source.

Reviewed-by: Shay Drory <shayd@nvidia.com>

> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/eq.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> index 22a637111aa2..d11ec263d53c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> @@ -886,8 +886,7 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
>                  return -ENOMEM;
> 
>          af_desc->is_managed = false;
> -       cpumask_copy(&af_desc->mask, cpu_online_mask);
> -       cpumask_andnot(&af_desc->mask, &af_desc->mask, &table->used_cpus);
> +       cpumask_andnot(&af_desc->mask, cpu_online_mask, &table->used_cpus);
>          irq = mlx5_irq_affinity_request(dev, pool, af_desc);
>          if (IS_ERR(irq)) {
>                  kvfree(af_desc);
> --
> 2.36.1
> 


