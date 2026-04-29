Return-Path: <linux-rdma+bounces-19729-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHqLCubj8WlZlAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19729-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 12:56:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A169F4933FB
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 12:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5059330A26DA
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 10:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492893EF654;
	Wed, 29 Apr 2026 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sxAKkHxG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E93EE1ED;
	Wed, 29 Apr 2026 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459928; cv=fail; b=uYnrQdiXecpN+Zy87pBA2/E0KSyNvylPCnZygttSbSiO2uZLsqd2/2JP6M/nKPURrT3PSRDUNxzjolRGn4pPxA4gStIwJ0gtVOS+8b2UCyyZ78ZqhaJtlg9l9EWi9Gin3Bl/MKcgX9kNRYyK5MnxWd6f0qM345ab/8ekDA4GdYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459928; c=relaxed/simple;
	bh=FHJB/GSXg5dY6J58/1ockukv4/+YnE5nW4Z9wDWRyPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tNa896bmeM7+N0TEb//z9i1deUJmbutl9bOU2SO9dPhWVP8SUUSCpUY7D8GNKvOLyyBBGYpkyTledZypQ4rrX5XLIveY9vPRkuECqQmc8UBfQ0Q598qTL/OjhqQy2ldFpSJQaW39pljk6+K0BfMRg2pcz/3fZuxqWHA6gLw8kDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sxAKkHxG; arc=fail smtp.client-ip=52.101.48.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tymbqevEVHMcKlYuZTmFrAHQ2BEwWaaWt210MFlEZIUTDXPQHjkB83S7Bvw5Sxsen6V0I9VK9W2f1XZ430GlwHwAwVvydf9XxEDRs2FSd0R7sVHXr2K6Aa7FGzWXWmvNHC7qlNK/aVOZSN3AC3Z/qBdJkU+9q7Lgd+o3bk30xNcvOByGXJCP20244vgYTX3XX4YRPB3RTG5TBTiyqX4b+L9oQJGt0gTHChyzvpJlQEUvpFmUIw6v/UIIKUtnK3jzZwAVRIm4sL/0O/mqfC8Dxo66KZ4KsTRUOLMlyevyeC0aOC9G5KvchrWFkoMrydzOp2sWYm6O140PoSWUKvCeiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZJk8sCUw5BxdVTf2nnSx9TbUXVB66m0dcueduMV8WI=;
 b=yO+HfQICo/7RlEkz7W+Mp+l7m3IIegyvh43+WqRR+gyLBPDZOTBKxB+5fFNefyaa87qfwwFXsvju/W9GTODz4hP4uDqY/PCFCxJ0FCDsKVFanl7+9lmfE6deFNgUXemntfXlLC4vPmksoD8CA0fxGrBmYQlW9xyoIIQ6IWjIIz6wfV3hV3uFazLDfr7ZIi/6kP+RDOjcWpFPo+/nRkiGztf0to6Ba1z9kl/BGnZMTw8vuALxcXHhq/a/o2s0JfXL3ocwuEvH7QEzMv1Fy4jkmD5K8qCoIHHBsZQMV7fUpA0/KgAkXpcpHBNF7iVv4iaaN7sHuYQgkHKpoeOZqe/vXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZJk8sCUw5BxdVTf2nnSx9TbUXVB66m0dcueduMV8WI=;
 b=sxAKkHxGFYCFJpM9etF2Lh4V7dWQEC71BaUUcaMmVtPu6qMIJPxZ4x1ASWIQENjXjju/GprEt5oLZUmU0tb/0pW4bYFPGn7tliNm83YcUodMWWf4qKTwB5dqBB/L97PJvfVPW1mANQ9Gf0+r9pkCOZMUPNyapijhXr6cwGvf0pA4DLXgRAR2r/MmskhCLaS/bD4rPEk39XtBDwZj760B5H6PddEkwWgMbo/1py5luYUf5LMcrBf4sSUQsjI7JO2xNA+xMQplYXvmDYlti1JizuavT8Cmx95Zhlkr/nMoHEmw6VQ+dZ7eUuIw5t8Lo0MdIE4fB9W15WIAUDPJ+z4QkA==
Received: from DS7PR05CA0064.namprd05.prod.outlook.com (2603:10b6:8:57::26) by
 DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.18; Wed, 29 Apr 2026 10:52:02 +0000
Received: from DS2PEPF000061C1.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::7b) by DS7PR05CA0064.outlook.office365.com
 (2603:10b6:8:57::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.20 via Frontend Transport; Wed,
 29 Apr 2026 10:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C1.mail.protection.outlook.com (10.167.23.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Wed, 29 Apr 2026 10:52:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 03:51:44 -0700
Received: from [10.221.198.136] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 03:51:42 -0700
Message-ID: <168981ee-8e7a-43f4-9631-ccc3fa178cae@nvidia.com>
Date: Wed, 29 Apr 2026 13:51:39 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RDMA/mlx5: Fix devx subscribe-event unwind NULL
 dereference
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260428224319.37682-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <20260428224319.37682-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C1:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 867945b3-1f1b-4aa4-a49e-08dea5dd584d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kkeD6cEjM17Q6wG8aPtNplbrrttmXIspnxho1h+Cp6Plio4icdDi5ZhK2kk3H9TdQDah7WToz5R9LwNSHRyE3sC2cB+DAu8EA9vZ0GN0lJzOtssyUu2za+2PqeehIJ3oCl/MOhUIvPW/SW3TmQQTh3FYrDdGfCilJ+TF3ZOeLKnFde1kg9fZRusTFrk8jHd6QsZO2WNxv4uyP87lTO2el7uauzDVsCmrddK4a5N/ENxI3GU0dBzhsOmpSUizpyxsxiqLC1J49k5fEu0RW/nUy9aWU6T056AD7+/QJ7g80aKdLwYqY220pINqGYYy3lyp5UUrf0JAtrN2jt6FQExf5nfJrNICm2RlSzpYCJaODirXJF9/l6TCWM+bdwCLn+6LJX6s36qto9byrqBrBnl+QUT8ZQT//KLHCt5dzfZN1XeoNxgH9muIR25J+zS1JrXA9a8Ovhcrbbv2WZTNPU1HaSJMhTX/UVwpSdq+ZIPMru/p/pl+dJ6ZbzCv2ikZaJagnKzK85LP6nbugHVAMEVy+zIS08cFZKoW6NyDB5+GhXgyxQ/puIFHLcPA8LBTeZ36Be5aX+S8mezaQx6de3c0ZJS/eCC21KS+1MKzBendEF8w7YKPF+Wnz7acsUQgKBiJsP9/43/mmECAcSFvYRxuvEdMMLp5I2wjXEf+zl6sCu6oSlEW4zDwyXLRO+mHbNdlNxuNJFJAkd99WnhD/8JFlea5DBpFL5ZrcDpj63RWRRlYwLBY7wJRts7GZL466jKXqBi1T6/y0JrNKd0ZqAew4g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l6dAvBUXoB3IU2k8B4B3WPzoepYILkODgyI1fbzAYy0ZQmuMrS58pUYvnHgp9pwURKqXqEdBUSjvp1MYp44792EYjcVKI6dwhotlwMyGRYBF+2/CgOsxv12HvDL0jr/s2JJA97t0DGZ4PkPkgG+wMRsoHOPDBagMKMztOXue48lAeCyD8NDFTWa8tfPyazO9bZoslLCDegkWI95JDZtVlkvJA3eCPKXnh/J/i/dUmbeWjUGXzmmZzog/W1FeflxLE/IPliNovtE97aX3uVWvdaB6OnyWW1uHRRv4Ao3DWE49ab9Rl/iHeV/6yDast3dZ3uvQFcVWz2i+q7VHe941sUCXJu65i4Z4f3GeEgJzudnuCuGMax1P9/VuEosEmG6KnSMMTTWn/4iLnId+U89P276JFPowcte/sIkw0c9qLYT4z4aJnh5pELiHGXJ0ADUn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 10:52:01.9456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 867945b3-1f1b-4aa4-a49e-08dea5dd584d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
X-Rspamd-Queue-Id: A169F4933FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-19729-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yishaih@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

On 29/04/2026 1:42, Prathamesh Deshpande wrote:
> MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT() links event_sub into sub_list
> before initializing the fields used by the shared error path.
> 
> If eventfd_ctx_fdget() then fails, the unwind path dereferences
> event_sub->ev_file in uverbs_uobject_put() and calls
> subscribe_event_xa_dealloc() with an unset xa_key_level1.
> 
> subscribe_event_xa_alloc() creates the XA entry exactly once for a given
> key_level1, on the first occurrence of that key. The unwind path must
> therefore call subscribe_event_xa_dealloc() exactly once for it as well.
> 
> Enforce that by adding devx_key_in_sub_list() and calling
> subscribe_event_xa_dealloc() only when the last matching pending entry is
> being cleaned up.
> 
> Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over DEVX")
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> ---
> v2:
>     - fix duplicate-key unwind by deallocating each XA entry only once
>     - add devx_key_in_sub_list() to detect the last matching pending entry
>     - keep event_sub->ev_file and xa_key_level1 initialization before sub_list insertion
>     - update commit message to explain the duplicate-key unwind rule
> 
>   drivers/infiniband/hw/mlx5/devx.c | 30 +++++++++++++++++++++++-------
>   1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
> index 645ebcc0832d..c2ae5a140471 100644
> --- a/drivers/infiniband/hw/mlx5/devx.c
> +++ b/drivers/infiniband/hw/mlx5/devx.c
> @@ -1913,6 +1913,17 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_ASYNC_QUERY)(
>   	return err;
>   }
>   
> +static bool devx_key_in_sub_list(struct list_head *list, u32 key_level1)
> +{
> +	struct devx_event_subscription *s;
> +
> +	list_for_each_entry(s, list, event_list)
> +		if (s->xa_key_level1 == key_level1)
> +			return true;
> +
> +	return false;
> +}
> +
>   static void
>   subscribe_event_xa_dealloc(struct mlx5_devx_event_table *devx_event_table,
>   			   u32 key_level1,
> @@ -2160,10 +2171,17 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
>   
>   		event_sub = kzalloc_obj(*event_sub);
>   		if (!event_sub) {
> +			if (!devx_key_in_sub_list(&sub_list, key_level1))
> +				subscribe_event_xa_dealloc(devx_event_table,
> +							   key_level1,
> +							   obj,
> +							   obj_id);
>   			err = -ENOMEM;
>   			goto err;
>   		}
>   
> +		event_sub->ev_file = ev_file;
> +		event_sub->xa_key_level1 = key_level1;
>   		list_add_tail(&event_sub->event_list, &sub_list);
>   		uverbs_uobject_get(&ev_file->uobj);
>   		if (use_eventfd) {
> @@ -2178,9 +2196,6 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
>   		}
>   
>   		event_sub->cookie = cookie;
> -		event_sub->ev_file = ev_file;
> -		/* May be needed upon cleanup the devx object/subscription */
> -		event_sub->xa_key_level1 = key_level1;
>   		event_sub->xa_key_level2 = obj_id;
>   		INIT_LIST_HEAD(&event_sub->obj_list);
>   	}
> @@ -2225,10 +2240,11 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
>   	list_for_each_entry_safe(event_sub, tmp_sub, &sub_list, event_list) {
>   		list_del(&event_sub->event_list);
>   
> -		subscribe_event_xa_dealloc(devx_event_table,
> -					   event_sub->xa_key_level1,
> -					   obj,
> -					   obj_id);
> +		if (!devx_key_in_sub_list(&sub_list, event_sub->xa_key_level1))
> +			subscribe_event_xa_dealloc(devx_event_table,
> +						   event_sub->xa_key_level1,
> +						   obj,
> +						   obj_id);
>   
>   		if (event_sub->eventfd)
>   			eventfd_ctx_put(event_sub->eventfd);

Reviewed-by: Yishai Hadas <yishaih@nvidia.com>

Yishai

