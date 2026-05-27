Return-Path: <linux-rdma+bounces-21367-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCYYJmH+FmoJ0QcAu9opvQ
	(envelope-from <linux-rdma+bounces-21367-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 16:23:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1017D5E5CF7
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 16:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6753930594D8
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991AC33CEA9;
	Wed, 27 May 2026 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T3NxkvSh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DF133BBB9;
	Wed, 27 May 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891625; cv=fail; b=I8lsD4pgZLQJpmcdA6c+Efdfk8hNOUXvnJaeL1o6uyrMRAdINF4nGNGTagSS76Z5dTxDbjnvT55ubYIhRtzZALvktnrSPjt6G3phrUGdi8waLT9hFOV5MoBL1VKRDu7djs/CyLWCgZMwMNuKDkbamXavosDfM7DbYGH9hSAt0hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891625; c=relaxed/simple;
	bh=haJEZW3SRmxAOSuD/HXiWplj8PMbZG7jB4wktP52xYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h1U3dAQ0yPZu+m6cdjTqq+iDy+vHH64KfDNvXqygx6HGgPMzot++FYKQvzmOl4OeKn1dI2Qrs4Be7Zmm5Ijh1zoEj9WRIjTRREicJY/YtIrPAaNVUilR8JwRzJVHXoiZE+HT7ujudmTPPtZNDx8aAX0FDZjRVkIGpW74VM1Anio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T3NxkvSh; arc=fail smtp.client-ip=40.93.198.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMQpfA4YTwP+PR8PuzAFZZOCKkZA0QexBu5Vtn+oWucYU7A4yEDdYyAQMaw92aqM4iD8b6KuzoTKNUOefWlhPnqNI5HfHvGcFcv/UJ/gopLCdnLSJGhPSOIl0TA/lvpulYf6cMpu1AuWRJbwZIiENv269Gc/TRu4xEF8qm8SwuxV0UW/TOJ4VFhwQDDLS79seoiQn91i4KwyJ0vXleehkKSqp7d+iGBVCUuerryqOvovs+XKPpq4fciQ4EQn1SYrQcn25Ts26dnno2YmCrG5Bst7SFHbuKcc3N2FV2E7l2UeMwcwnV9eYiH9OuVB4El2GBn//qNHcdk1fEEhqapKsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFdzGkDkWo2PeKQMZ+vZa6ht/jv3Q/9fOlr77ITbfyU=;
 b=vUA/DkQGhtAxo8czmGFSJLYA/w0dd3xg6KSGnBvgf/OVT5cPNJ1w3jIu5ROaMR6dH/MxkNes4SuWYxu24xcayGqlOo0x2lkZtQd+D69De+OuuLoDIbsvkO9jYO4wtLkMlTVLd+bfzKuqPw9pdWeXNX9XjcSqcTiM/vg903ihhwJAswrmaw1/+JaHClQsT4oeoawmh+URTOw1wXVExRMj2FiAwpXN9cboCii6xCVU1I9M26F+/HBcFelSAWB0olleZH5CoS1DPbfI8yY3/m+SmbSuZtNgSPlcDCP6b1uBUuwnhsYV87u1KTMAk0T3OSp1qiIprij09Bk78nyGQ22Mlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=yandex-team.ru smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFdzGkDkWo2PeKQMZ+vZa6ht/jv3Q/9fOlr77ITbfyU=;
 b=T3NxkvShVQUCXzT46BMj4/agtaUHXcxafuqGOC4+6X9N2OHXgsFn3WVcpTssz8qJ/dv9O6lypwWBmlcl9n17WbPc0p5u+d7nVXu/sligvu3wwFLBkNJGqqwBJz79dZ+6i+2MmM0uQDJcBU4i//HOfru5NVipVmp58csmM3yZP4C/g+v5gPfPXepvqdpG4tghjqi/VnvLhXxm2bIePpEJziRHAFIIfW45IgNskO/+wzZ+4p9SySxTsYdNCjwbbjz2siTbvH9FluJ28icJkyEby/YYvEIqCTk/l5mPJk9DRGV81sMzRABTDizxwUf7z5Iehj8J/tXXUgieoK7xIrrhDQ==
Received: from SA1PR03CA0019.namprd03.prod.outlook.com (2603:10b6:806:2d3::21)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 14:20:18 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::ad) by SA1PR03CA0019.outlook.office365.com
 (2603:10b6:806:2d3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 14:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 14:20:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 07:20:03 -0700
Received: from [10.221.194.170] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 07:20:00 -0700
Message-ID: <fe5a2ed1-2fdd-45f8-ae1d-656e5e89a354@nvidia.com>
Date: Wed, 27 May 2026 17:19:58 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Reorder completion before putting command entry
 in cmd_work_handler
To: Nikolay Kuratov <kniv@yandex-team.ru>, <linux-kernel@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, <stable@vger.kernel.org>
References: <20260526162932.501584-1-kniv@yandex-team.ru>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20260526162932.501584-1-kniv@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f954574-8a7b-4680-5989-08debbfb13cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|11063799006|5023799004|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dQuCqohIaWm1J7tGF2CfuMdxUCPzl3vbeakgRbyke8rqpAmN/wCivX2mNMp7CgUn25qqKNG1fGozElUTxDRCi2AeJ7Ov9dfrl0RE9xdaEivkFqyjWgYhXvsyckM17PD542+KUektqiaS/9BLIvUxlNo7rvp9mrxSdemRATR4u+ydI+XBA7LNAI2dJOz0gA0tMo68ECLzZ0J2suVGpp34pihmtd9AIofrBmHDrlKgb5wT0W5CCP78VJN36Scux4QYX5G1vRmC63HspDE4SVhptJ7NDnv9rHt6EWiADTcvEgBKZQZXOqOSqWec8oRlwEPFwwGPzhBFvWgxL0W3exMtUzVXONyV8RyUPE05mqwWiTJxkkQJu/VotPUncSAeJNloFJP4COHdiHBikrCTOtMe7uOaP56rkK1tgWe5Gp+T03er2qhF+bOcUcUXJGsirKxbnPgMySpgdpS5FCQzqtC0a19RzbMtRrt7WfAZHKq414xsFTZskqs6hJDyVYqnJcM3/divDQuHyRSgTyFlZ2RKGD3zuzaThy4yHFVnXdrYNW8KrF3ZTh60fze3CG4hJyPDqpEyyRGGEA3bzV++8nB/lmu3tfuvxlAB+ApbW++PGA/++fM8s7YRLuo6ABIB9OHjcFgwiA5aV0Fiypxxq8jEsnykMHkyo3qEB/BWXZYD3lSUs1wnDEbkASuxYfRzjILFWhTl0cwKMD/2w1SldTzG4/QLMPA7ucacqu3mM20rB3A=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(5023799004)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A7iUTHjanmhLMd+FyQIvlLRermj8LIy9SMyEqqfHNucFZwTwP7lLvmfWprY7a149zQoZ/Xr22CzXl3yfHuuK72F4AQzIv2zlEO78/a8CAVHQqRoncY5UDmoSr9l0SMVIqjSNYk5UqzE5fP9AAM0s8bR/+emvxNrvthiCFnl9mk/hhrAoChb6PZAKbT0cxLua25rmGcCzPQwCPnSacDGUZSnIYStcxW5Gyr/Khs0rj7LHt++oILW1+6nmKvsU4HjIPPlnipbW1tX3a1LMOpNy9MN6afYhurFyZeA66foupLIz4U34O9bneEEl5g7IENkqtRvhdUkDcZ/p/2ledZJStqVhQt48bKrLv6BhvDQzaSZaZGueScbmym1zcF6TTAM4OaTbWyUIZM4atERH8JZexmkOJDU46gAJVgoSUuHaYHj35CwN7wmFywtg4QX7WBbi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 14:20:17.5109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f954574-8a7b-4680-5989-08debbfb13cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21367-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yandex-team.ru:email,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moshe@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1017D5E5CF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/2026 7:29 PM, Nikolay Kuratov wrote:
> Assuming callback != NULL && !page_queue, cmd_work_handler takes
> command entry with refcnt == 1 from mlx5_cmd_invoke.
> If either semaphore timeout or index allocation error happens,
> it does final cmd_ent_put(ent). To avoid access to freed memory,
> notify slotted completion before cmd_ent_put.
> 
> This is theoretical issue found by Svace static analyser.
> 
> Cc:stable@vger.kernel.org
> Fixes: 485d65e135712 ("net/mlx5: Add a timeout to acquire the command queue semaphore")
> Fixes: 0e2909c6bec90 ("net/mlx5: Fix variable not being completed when function returns")
> Signed-off-by: Nikolay Kuratov<kniv@yandex-team.ru>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Moshe Shemesh <moshe@nvidia.com>

Thanks.

