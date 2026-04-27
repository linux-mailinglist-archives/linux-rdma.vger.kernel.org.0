Return-Path: <linux-rdma+bounces-19582-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EuUNNlT72maAQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19582-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 14:17:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F3472568
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 14:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8CE33007509
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 12:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB803115B8;
	Mon, 27 Apr 2026 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h6gm1+na"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0FF3090F5;
	Mon, 27 Apr 2026 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777292247; cv=fail; b=ivo+fKCOTdAxJNQyrEVCPluKBtttRrtB7lviYs3mCBZcIBz3JMGnXOvI6ZOh9ZTs0dOB2J+R/FtyzY72pbJ3/LR9k5XcSvutv6Dyj5AnitqgTsFYJoVnB11dJ2UFc1Syb4Ftj4V1aLlbE6fkdBo+EEyd2J3FAWBDkL8CMTeVtOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777292247; c=relaxed/simple;
	bh=FeWxl1kZ/40ZXu5cXCFHhWAS8aGvNqQ41G6aL0EX+8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GasFmatJMp3jwu4FbQmL+MPBh2zOK6iNxmMajq25rkqg6EKXSvU5cnZGLKomlMVooHznpEYo8b8sR+SxoRrT2/9cSoENlH3dMXg3fr/jF78TXeI1+ImHmw1WNzenro5kbQf8i4lDFEeX0vvvK1XGO1l6sKCNfugLXelU5lE+hTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h6gm1+na; arc=fail smtp.client-ip=52.101.57.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3XWiCZsyergnI1n7T2oILrhOLE3a9SVfjdJuSnyh+cGPAvqpU7JYCbv2VuzGogbBiKKFt6lxLlwtpxmbSQ3RekP2+Rmmkey0KL5uVezKupGWyOkCfsqqzQgNVac5Zvux0k/DqVqiTZeqP6B8rZCJQFqeehkaCLLJMgUbv6jHzGVo7p9sS8fXbPr2XDEtsq7g4BTjtQQiMqVZWkXWFrnnkn2kvFjNyJ9AMgtScTvAZg8o0GbYLxcSabN1HpdBHHEKksUKMwcT0jfQ14PCFcanwHP4c2tlmLftvejVystWWGDWAHks2uU7HH8GGZ+lwbsp/l6qQl16NBHApbfJnKZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiKZhbmL++1u832i//An8ABBRMW7GkIU3ouKnAHx4sg=;
 b=W2S4rlViuArerrVRip4Hp5E/OHnb8np8W2rPxNEfWkdvq+F1xsbj/KwRVtaj2Yr1S89UAcHOswmY0ydV9UOmuONEVUUo0nn6+8w3cWQ7b9bsoye4ys0A3v+N4bubCuY1Hi7ktXELm0PkvzNxucECo5E7u2sJWpnR5EKxOBiXPhx+rwf839Dx1ApzQxqeC03nFfaC9KkVXT+bSL7n9RTubJr66FMLmu6BS0R3lcGOIiVrz7xPEYjs7NyKavvgUYwwAecstsN+QD/IRDCaP273As0AnaBFZgSQK15nCX0OppKcDu9xa2XGr4ffxWjXIko15mxP4jjWeadYrNXyNj/SAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiKZhbmL++1u832i//An8ABBRMW7GkIU3ouKnAHx4sg=;
 b=h6gm1+naawAMaHPwTxUt/wJS1Qw/D21Q/sTYwucGFiSfIRkWZTa3INXNiHKP5hQNh2E58ii7LlxDWXsALao9mwdqC/7P1mgRUIu2GE6LxtNbknyGen9oScEWRLOHA63X6DimVrDfCl/sbG4YQ7b0G+8G5T6iXNQQ2Rrl6ULKPbMF68Jvpmik4R6iSk/j6jWWrcm9W2znzMEnBeOQk9mkgzXbggDRALgRj9jjTEnbOG9GYwYioHn2RjpWG/DTiLSJKPsyN/hOx8GnDGJVct4thI4u7JGqY0Dt+oU1xwJOQJ7fp67G2SdO6RdGy+8kWBOz2xiGGmZ1jwu4o/u3fzlhAQ==
Received: from CH0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:610:cd::11)
 by SJ2PR12MB7797.namprd12.prod.outlook.com (2603:10b6:a03:4c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 12:17:17 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::ed) by CH0PR03CA0096.outlook.office365.com
 (2603:10b6:610:cd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 12:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 12:17:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 05:16:58 -0700
Received: from [10.80.1.56] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 05:16:56 -0700
Message-ID: <bc0fcb45-c3f6-44ba-9448-ce4a09fad49f@nvidia.com>
Date: Mon, 27 Apr 2026 15:16:53 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma v1] RDMA/mlx5: Fix devx subscribe-event unwind NULL
 dereference
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yishaih@nvidia.com>
References: <20260425010107.19586-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <20260425010107.19586-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SJ2PR12MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: bc50eb80-f0ac-4662-ae11-08dea456ec5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fTbCoq1Dhu3e/L6G15YsoCXkSLzYfiTjKNOiQGCmC5cYQsS2IsvuUVC9q1gIa2urrbVCqzWDaXKPKxOhiB5psuEcoe10slv/BMuEM+fmERDRpSupJKmasWLuS8sJSlL6RqGuyq3WxVUVhQGUx3L0VI74PE8HdfUZ+jZO3Rp1XMSs4D0ixH77OOvhM3mgb9niF0vsRgOF3IgMR1UXar1tCBxEXXWIbKC50YZYDpyHM7TwziwCHbPZYM/5Bb1C//VBYPoO1z/voPMnj8uzyZoeGySB3npYbtMg15kJKwwp4zgdwPIdgbaOrvxMaKPaFS1sVuWie3+AWpDWQkVlY1WiYAcJqqIAID3c1JKFtkGfY9l9mlz8bi5f1RDDgZdmv9uSZsEosqYzXBuH6CLF0Eo9BRGLaQWVvAGhYACzyoTIM1vDXWWoUFXlXz825TCfvVYFOfSg+39Wkl862+ioviWtaBV0kZ+DRJU4scPyQxdfZg/bsln8z6fZtNtdrK98InN50e8afdx5T50bi3DKGj5dkE73cXla4qxkI3zEKyrdwCepI/QlJdMnCSVdZ7Y7WryxlUqjmSSq5tEzP6JmnJOWjtmHvou6gAtV6/2nYSuPH0m4+ckEdXCVGZ/v03ui+zg861IywzLIw/1Y4v00hngGJG/ZDcwQHOT2V2NyK2dkZXeLf4JMmGkeN9SwJYbJa+348ABRRg3mwfEJd4e7q0i/krH/RZURYG/XwFXBHh5qi4btauXO7JnrAtrYif1uG2EdOYkEgeagoL6bYdOjwp6eFA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j4oB+OW5C9zB+okwfCBN/2Z5v1epsFCDKpKTZz4PnlxQ8mTx964ne6VI5ELB/l/fgrV364CTvSlNtSb0O3Xdls+aIVCxyA+0+pBKD/EY88r7ku4adpDV/UoKN1buZMH+HZCFainkjTo2xyefhkjbAo/mNkdhxbT6Xmt5s0vGPWbOKZubC/TWrl0KKakDSGF2byRC1MmFSflCsDzP/I+SPV4VS3GjjCzYgYdNwqJT3BIADfLL1VTWT8wAjV4ZBhUVQtbu//CyfyovgSODkwttkRskVQ81005fvaB0gm6d+NAUG2+HJrWrVmuyMmiWzQn0aYIym7p6rj3C7tB3NqU08Bg9lSbPciLzG5NHhDUfQoAr5yaZW+OCKO9zsy9S2Bz+LXx02Z8OI3/Zq1dhjUXNfs3WlwB1RVSM+28FCo/5XhaRxc2d2Mzcubl01aMVjHJU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 12:17:17.1473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc50eb80-f0ac-4662-ae11-08dea456ec5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797
X-Rspamd-Queue-Id: 612F3472568
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-19582-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yishaih@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

On 25/04/2026 3:59, Prathamesh Deshpande wrote:
> MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT() links event_sub into sub_list
> before initializing the fields used by the shared error path.
> 
> If eventfd_ctx_fdget() then fails, the unwind path dereferences
> event_sub->ev_file in uverbs_uobject_put() and calls
> subscribe_event_xa_dealloc() with event_sub->xa_key_level1 still unset.
> 
> Also, if kzalloc_obj() for event_sub fails after
> subscribe_event_xa_alloc() succeeds, the current iteration is not yet
> tracked in sub_list, so the shared unwind path cannot undo the XA
> allocation.
> 
> Initialize the shared-unwind fields before linking event_sub into
> sub_list and explicitly unwind the XA allocation on event_sub allocation
> failure.
> 
> Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over DEVX")
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>

LGDM
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>

> ---
>   drivers/infiniband/hw/mlx5/devx.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
> index 645ebcc0832d..3d1528b1c816 100644
> --- a/drivers/infiniband/hw/mlx5/devx.c
> +++ b/drivers/infiniband/hw/mlx5/devx.c
> @@ -2160,10 +2160,16 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
>   
>   		event_sub = kzalloc_obj(*event_sub);
>   		if (!event_sub) {
> +			subscribe_event_xa_dealloc(devx_event_table,
> +						   key_level1,
> +						   obj,
> +						   obj_id);
>   			err = -ENOMEM;
>   			goto err;
>   		}
>   
> +		event_sub->ev_file = ev_file;
> +		event_sub->xa_key_level1 = key_level1;
>   		list_add_tail(&event_sub->event_list, &sub_list);
>   		uverbs_uobject_get(&ev_file->uobj);
>   		if (use_eventfd) {
> @@ -2178,9 +2184,6 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
>   		}
>   
>   		event_sub->cookie = cookie;
> -		event_sub->ev_file = ev_file;
> -		/* May be needed upon cleanup the devx object/subscription */
> -		event_sub->xa_key_level1 = key_level1;
>   		event_sub->xa_key_level2 = obj_id;
>   		INIT_LIST_HEAD(&event_sub->obj_list);
>   	}


