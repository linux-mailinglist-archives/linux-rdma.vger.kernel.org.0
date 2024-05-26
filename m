Return-Path: <linux-rdma+bounces-2613-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D548C8CF4B9
	for <lists+linux-rdma@lfdr.de>; Sun, 26 May 2024 17:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F76E1F2120F
	for <lists+linux-rdma@lfdr.de>; Sun, 26 May 2024 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B901755A;
	Sun, 26 May 2024 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sjp1Pc6a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C3879F0;
	Sun, 26 May 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716737041; cv=fail; b=ATnVEOiALwWgpljJ/paHtU+YJeaPGzv5uB9Q8U3tVJ6nDweyZ2//NWeSKQI61b4kSB00mFMDj3yezRxvF58htFAUf+Tru5yL58Wb7Bte6VWbjWyOTVx0TOBT8eF/otGCExSIPUdSqSYaDBcVVqdOxXwwozt4lXxshtFL9VLNYs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716737041; c=relaxed/simple;
	bh=k3NUnl+UZPLVgR8ggU2D5FTzKkBIrcHNEBMQ4kqkpoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t6/5l+s1pp2WJX9LdimBUQG3j2OfrwQn2LLjoXQLudtgpl/OO+W8FSSsbq7B7NhQktAZEWp4s/HOEiuNxTMxcmvoNpbngQxfOvHGT5x/8Ex+HaLECHAAbZz6ycdX7ZpQo1uG7s/3Gaa9D6+R1aP+Lsobojyn+kw8uMMltwQyrx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sjp1Pc6a; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/xOjU69qm4rjbpl+rDnnXcKROs5wuNB/6uFqI4dZc/wYNQuidTkim7INd3ZTRsAYEzXRhtU42HSWwpAe/DuYuGVMiK9TyjwjydRId87vBCqDg8qWbJm6uzTvqbj5g7kg1Ijd0eX9XJZrXlkcVVkSmnZ0K4roPAyR6sfDhOZp6NUPHeeo5vflOppMPMn2j3XhxTxx1353L3Kyu12fci6KpUmU+ojlTtpPUjyxdBH6+wPRqxbh+9L9e4XCd3gzragKEaBiWhtiY+jcMUJO4ADYypXtdpeYKykhQQhJEo0QjtGX27LpBAxj8ZeVpH+hfZnBLaCJYGhVlXCEMy1KZ28NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLfOF2g4CbiTIHPuDaklvKJoumSFwDMpjpHfvw08ybA=;
 b=YS+xVka+2vjVM8iHed8AxKPAENi4ZNq16mXJ7dc5O5oUIP0icLTfC+kIDwAUIw7gbbGVcatAihVlnOpctW7ugNh4A5kJlZLpMLIgZfBbGYVMgbFuckTZkJ3JrR41Ow4nWe9nW3SqURAHGbrddztA/Y7PKfSjF34hcTrWNM4d8Hv3SEqwVl+2TwNQjICWS95V0qr9CGzhdFsTVq3w+FJtqu2OgRClzgWS77dfH2LuLLACkrdG+jOLZ9Ma7MZr6Mn6Ln/Z3k4XEd3TIR63kV+eX6AWs0Xs3RzazkgOSf2pdPcyp7k3tD/OraVwGwx5HP6GNwqlzEp4vIZNFj/K2F5eVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLfOF2g4CbiTIHPuDaklvKJoumSFwDMpjpHfvw08ybA=;
 b=Sjp1Pc6aX+3BdgJbE4Eq9s0OuZCoNUlmUISdvdT7NO6kZdQfCqvvLWh8EjMfFoG/Hhalw4gp7yi+U8rRBrO1HiyNev3Yd3EV5/q5l7uM+L65icJVYyujBokqPva0NWkynJTLn45UEz0JCO1v6bRAyaSBxiXW8UyYmC2hF2agX3Q7rgBmCzUIv4soYjdBe75GQ9V2NeFTBTHszJsXzC6Th4gboQqYTYzLwcoCPKAQ8Tw2klhLl3RGpgBrjM5RRbaXXVgKzSLu0uR3/A0GJB9s73/QwaTRMMsbl4bibY3u+ysuV0halvusE7p8Olucg46W9c3bIs77XblDTiD7+9144Q==
Received: from DS7PR06CA0037.namprd06.prod.outlook.com (2603:10b6:8:54::12) by
 SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Sun, 26 May
 2024 15:23:57 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::87) by DS7PR06CA0037.outlook.office365.com
 (2603:10b6:8:54::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27 via Frontend
 Transport; Sun, 26 May 2024 15:23:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Sun, 26 May 2024 15:23:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 May
 2024 08:23:50 -0700
Received: from [172.27.34.245] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 May
 2024 08:23:47 -0700
Message-ID: <a26f1947-58fc-48c4-a8f3-4fe2a274afa6@nvidia.com>
Date: Sun, 26 May 2024 18:23:44 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] RDMA/mlx5: Release CPU for other processes in
 mlx5_free_cmd_msg()
To: Anand Khoje <anand.a.khoje@oracle.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <moshe@nvidia.com>
CC: <rama.nichanamatlu@oracle.com>, <manjunath.b.patil@oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240522033256.11960-1-anand.a.khoje@oracle.com>
 <20240522033256.11960-2-anand.a.khoje@oracle.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20240522033256.11960-2-anand.a.khoje@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c00ac99-b93c-45d7-b917-08dc7d97dc68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3FBUkpRcUNqMnNJTFp2RE9DMFZ0cTlPYXhoTzBmeVJNbzJnSXlzcUxhWVJi?=
 =?utf-8?B?ZFh6TGRoV2NyTm56NS9RK29oZzB0ZzB1cituQ2lYZ29MZEpkY1pRTER0cDNY?=
 =?utf-8?B?TEZsR0Q2Vzh0Sk1OOWsvRTBBd0JGT25UT1Erb2dMcENlSEJ5c1RlUlZIMXNs?=
 =?utf-8?B?YnNCL09yNjBIV2NFRm5wcWpZTnBDbUQyVCt1Tnk2MDFWN01EMWtMN1FWd3Bm?=
 =?utf-8?B?SndCb2hGaTFYTW9zRk1lek9HaDMrK3d2N1BGSU5sUEd4SzBJSTFjTXRScURQ?=
 =?utf-8?B?OTYzMmNnMG5QWkhLVTRWcjJITW8vTzRIM1dpbmd3bDgvY05aN3pTeDBmbjZ5?=
 =?utf-8?B?OXFVbDVIZHdNWG5WYk5lak9LUkI0WHN0dU8vdlNCMTNqb3FKdHVUcUhaMGp2?=
 =?utf-8?B?ODhOS1ZRaXZBeFJiMG5RMERNem53NjFlSFR2NnN6V3NsVWV3cDdOTzdHQllx?=
 =?utf-8?B?ekI4OEVVUys3b3pRU3c4UUVBUmdVcVhNU2FEM2E3T0wyZ2pKQUtIUVYwWEd0?=
 =?utf-8?B?YUZjd2NjM1kzL3FUSFh1T1UyL3ZiR1pQYzhkUDdrenJsQUFLREhXbC9OZWhN?=
 =?utf-8?B?RHFhdEJvcHhnNUdpQi94cVZzdVhkUXpLM2RCSDUrWXI3bUtmVlIzT3dXeE52?=
 =?utf-8?B?dXlwdGNXODRJZ2xRd2VlNjNHeVcxS3FPaW41dFhyNlBuQVVHaFlWNGdtdHFC?=
 =?utf-8?B?MGNaSUdOQkY0MUUyVU9tUCtIeTJWM3hqNlFHVWFUOVY3U2MwbldMYkY0VmJT?=
 =?utf-8?B?Qm8zVTU5MWk0cjFKTXRWOXlyaWxVeWFyTlplSElVcDR3ejdYOW9rcEQ3K3NG?=
 =?utf-8?B?aVVLNG9rU0RKN1V0ZkxMUnFiRWZhSHZBcUc4SUxzU2ZVclJSUFpNeURFbktS?=
 =?utf-8?B?MVJwd203R3FoemhEQ0ZDUUIzV2F5eStXZnYxWTFMbDVteXZiNnYrME5VV1Zi?=
 =?utf-8?B?SUhIYVNtZGdKb0dsdGZ4bU9WNFpla1p5OUdldTlML0pCZDNiRXVuWU5UYVQ5?=
 =?utf-8?B?Z3kxdU1DL014VjNjRTRlTGowMHNQVTNBSnBxV3ZOUitndC82Z3ppOUFHajNN?=
 =?utf-8?B?aFZNWi95aGpZWEE1VWZ1dit0T0lwU3pKRklOMFd6L3kwNzdLb2xtd0lacTdM?=
 =?utf-8?B?OEhadm8xelJyOUFFQkdSNGlrQTJoeFNlenlEZ3FxemRmU1VIbGxxUEx5cHEx?=
 =?utf-8?B?MWFSYlA2S2ZaOStIR09kTkFXWkVxL3UvN3NCNGJNQ2dTQU0yZ1RPa1d6MTho?=
 =?utf-8?B?cGVVZ2xQNW5IVGh6SlZicFBmcnRTU2ltbEhVOERVa3F5a3UxczZVRkRtbW0x?=
 =?utf-8?B?MlIyWkNWR3RIRlhWd0F3Sk4ybTUwSkxMUjRLdVRzVy9FQm16aVpjc05NWURG?=
 =?utf-8?B?R3ZoUFJ6T2dQK2FmRENhUXN4bjM4UzZQWWJvVGR1dkU4TFV4K21GbGtOQWhY?=
 =?utf-8?B?OExWUUtoVW8xY25PU1BZMitFejdhakJOYzhTcU1aaVRlTXRSUk54OWFqZnNv?=
 =?utf-8?B?bStMeEY3Q1pKMitKZ1RyeUt2K0tGeUZPSTNJM3ZvQ0NMc1FxUmFVYW9NWjkv?=
 =?utf-8?B?di9UQnZaQ3AxUHkzNnZlZzlFWjNmcXJMRHV2bkVIUjdvRjI5WDE3R2JjTFhE?=
 =?utf-8?B?b0Fla25hRVpWOXh1b25hck5PMnlKVy9oaWIyV25BNlY1KzU2c3N1WHhqM204?=
 =?utf-8?B?bFN5RXFBeEdNNytORHlOSmR1blc1YjhGeWdVM01kRHdjaTZXVjhTdHh4UlNK?=
 =?utf-8?B?cCthZ3NDSHlyTFZsbEEvRWtQVi95Yy9yWWFDT2VNb3ZTYTg2OXFXSE5RZWtI?=
 =?utf-8?Q?3YopA9hmW0GaIl+PZV5XbZkr4BtEevlYSMdRg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2024 15:23:56.9745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c00ac99-b93c-45d7-b917-08dc7d97dc68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909

Hi Anand.

First, the correct Mailing list for this patch is
netdev@vger.kernel.org, please send there the next version.

On 22/05/2024 6:32, Anand Khoje wrote:
> In non FLR context, at times CX-5 requests release of ~8 million device pages.
> This needs humongous number of cmd mailboxes, which to be released once
> the pages are reclaimed. Release of humongous number of cmd mailboxes
> consuming cpu time running into many secs, with non preemptable kernels
> is leading to critical process starving on that cpu’s RQ. To alleviate
> this, this patch relinquishes cpu periodically but conditionally.
> 
> Orabug: 36275016

this doesn't seem relevant

> 
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> index 9c21bce..9fbf25d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> @@ -1336,16 +1336,23 @@ static struct mlx5_cmd_msg *mlx5_alloc_cmd_msg(struct mlx5_core_dev *dev,
>   	return ERR_PTR(err);
>   }
>   
> +#define RESCHED_MSEC 2


What if you add cond_resched() on every iteration of the loop ? Does it
take much more time to finish 8 Million pages or same ?
If it does matter, maybe 2 ms is too high freq ? 20 ms ? 200 ms ?

Thanks

>   static void mlx5_free_cmd_msg(struct mlx5_core_dev *dev,
>   			      struct mlx5_cmd_msg *msg)
>   {
>   	struct mlx5_cmd_mailbox *head = msg->next;
>   	struct mlx5_cmd_mailbox *next;
> +	unsigned long start_time = jiffies;
>   
>   	while (head) {
>   		next = head->next;
>   		free_cmd_box(dev, head);
>   		head = next;
> +		if (time_after(jiffies, start_time + msecs_to_jiffies(RESCHED_MSEC))) {
> +			mlx5_core_warn_rl(dev, "Spent more than %d msecs, yielding CPU\n", RESCHED_MSEC);
> +			cond_resched();
> +			start_time = jiffies;
> +		}
>   	}
>   	kfree(msg);
>   }

