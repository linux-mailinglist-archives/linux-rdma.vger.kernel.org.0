Return-Path: <linux-rdma+bounces-6876-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BF6A03BB9
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 11:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2FA165B46
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B42215A86B;
	Tue,  7 Jan 2025 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tbrf9tAr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207271E47D6;
	Tue,  7 Jan 2025 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736244152; cv=fail; b=RnIhW5R15ASUNzOvZZQqyxg+61w/mj4jPHaL/gtTP9GWOmQVIVJN+o1g0r9rP8h0J2ePgB+5GQItc1ldxHsY47Xzi0Brq5fUZE4wikSsSyp+RoTanc9PMgav3Vt/X7LGNC4dBGvCWfr6ylCOhZzu+O1I17zxLMdXmWDuVHA+LEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736244152; c=relaxed/simple;
	bh=7M7RFCvjS3jYiYoNN66BaQjwOupm+a3tTFvZ5TvIaPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XA3rLoRQJn58MUbrOIYzpe/6yJLc8em9/90CBClKpLS1BIf+1fBFBt8czoRdB44wDCjqvU4xRnxAF5LCCzHh0G3wL8Nby9QcZezuX1yFI1xq+8blBiAwWzKo0vYhmJ3fobRvNPZFRUW56oEvlfmeP8NGUBZ1VImUKcdM7pypL98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tbrf9tAr; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqWpgi56GdEaQf6erXu9Ro8BK6Orms6R8VoOeRnUvP3vCkpi73BUSTQT4Bg4PTiUfJhkxMHS3XRoZIhDKKy4KBI0tpYzx4UrB30R9nk1UaqDfhOVEJ3Wh3iOsG7YuKff/FgnvJWCkfCPhcLmVfV9vF2avtKIeVKe2Ae30lNa5iZMd6zIIjY1PJ9TgYIILhUHV33QVen1szqdpslMGUQ7gd+vRe9DRqxRDFb+oewc6pCQbP7jJaLi/jZjRmUOKiDdOW6UOxPoDvpIOSbPBDuRBWqpcvBsQKJsYbMlwrJgLGM7Gzi4QZkzMwLBH8Q6CqMXyjioKoBIckI2R+ROQGXmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q12wO8lYooGI438eJ1ArneAujTpyOPEF7TkDhSHIrOk=;
 b=UznbrkmUviFhrTerjT4gNATA9OVJt26u/y/YRds6C2tXIqB9gsxlqFnD7iIlQJWbH722G9hljEslWKfByIaxpWNXW5qsq+Z5FIEN9lOjBXRvpdpmT/lZrFq9ly5BuTw3D9j0rDyFO6G/YSMGeQlZ2PgMoA1pFSe5jxdgCt6b/goxMeCfVOerUEY86snstIXmzAGSKsdKF3kO87NUeqb9Ql0TyRVLLJmA2ORV5ryDrzZLb3TCGYtUaheLdHmweUlnf4hbICasW0yW7SkJ/0x5+0DbIL6tJMqoNNZU1UPBds/cO9lZ8dNuCMFoIc1V8HB3yydyKDGlHf9PUdxBnbYBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kylinos.cn smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q12wO8lYooGI438eJ1ArneAujTpyOPEF7TkDhSHIrOk=;
 b=tbrf9tArDuyNeGlpZVvMQDW6oSNEd0yrEg6EoyXX4CDpIYZJDauv6ZW+3saCYpc1Vm3gkcmOTTXqlpKfeTZ/5UjZXxqdwLfhgVsI78mMo5OaEEcYF3Xi8sLOZWpkEvFovpiJaOmCsrAGMIwXpIeWGW9wq9ijIua/xVXMFqtL0d4VUF5BP2/WLpPtpSN2kjOc/9cQqeMy/1EQOXTMPhI3zEJMXQeEMOOyILQhi6P2o+63EV7BE7oXf43SdjPMnt5WbngoEp8vPdzMfL/RoE3N7wmsIHhW2ZW/+ekWeLadJ2SX3LLcEMG960Ed/Xto+fqXXbNFK9MDoiK2zE4LiDxSEg==
Received: from MN0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:52c::15)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 10:02:22 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:52c:cafe::2a) by MN0PR05CA0016.outlook.office365.com
 (2603:10b6:208:52c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 10:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 10:02:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 02:02:06 -0800
Received: from [172.27.19.172] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 Jan 2025
 02:02:03 -0800
Message-ID: <158e9b46-c151-45fc-b342-a1d3b4a13c87@nvidia.com>
Date: Tue, 7 Jan 2025 12:02:00 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Fix variable not being completed when function
 returns
To: Chenguang Zhao <zhaochenguang@kylinos.cn>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <20250106091426.256243-1-zhaochenguang@kylinos.cn>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20250106091426.256243-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a05d2a-ea23-4d17-2445-08dd2f02607b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk5CbzF1OWxUdXRwNkNLWUh0dnowUndVazR2RUl1TGFrNlBVOUdoVnIrVTZ0?=
 =?utf-8?B?U3NZY3NQaUxBa0kzY1RCdVlyNDYxaDZYaUpub1lwNjhMbEpIRzRmakN4b3cy?=
 =?utf-8?B?TmxaL0hDalErandWR3lwa3ZaNEVDTktORzF2ZkZiY2hhS3oxQWFnbmJuVzls?=
 =?utf-8?B?Z21ZZnphV2JoMzBZWFhxL0s4NnkzaVFpOW01NVZNaTRqMUNRMGppUE03YVY1?=
 =?utf-8?B?eHI5QnVzQ2g0UC9ZdFY1WExyZU5LUXhvNHF2MWt6ZXcrZml1N1NBOC9aa0hR?=
 =?utf-8?B?L0xWVFZnRGZtWmZrWDVvcGJ5cDIrWTdjQ3BQbTZCTkJFTFl3c3pPdVFmZGll?=
 =?utf-8?B?ZHdaaitKUlBnSEFaY0FCQlExdHVHNGNiSkhLREt2akpGZ0pPcmhYNVI0b3Vj?=
 =?utf-8?B?SmowZi9pSEIrdWRyQ29QajF6OVpBUkYzaTlDcmxVejJsdGlCQzdwN3FoUnFs?=
 =?utf-8?B?c3UwWW5WeTdTTUpQTkZvTVRVMm9UNTUrQWRXamVlc3Jrakk2TWc1dGpER0pR?=
 =?utf-8?B?Z2I0N0pNSEhXWW14RllkVEJ4YkFlNWZ0TEd5VUYzenNYK1lDSmNuZHVzTUx5?=
 =?utf-8?B?YjBsYnozNFNzUFI3SWpKT0hSOGdNMmJsRVdMV2wyNHpLNHZZVXY3REJ6V0lX?=
 =?utf-8?B?S0tIUDFGSXo0Y0xrRlRUL2VTUzQvZldkalJITlE3UUdPeng1djhydkJXUFZL?=
 =?utf-8?B?V1RDZlpFQkVpbG9pVXB5bWVEejNMVERLUkJXa1REajkrUXA0WGF3TG5oVm9h?=
 =?utf-8?B?eTFsQUlXQ1E2NlRMcG9mY0FJT0g3WjkyOENwd3hKM0xMQnhYMjFGcms5b3Q2?=
 =?utf-8?B?SWlYWEUyRDRvdUpMNzR5OWw0UitOMUFOZE1xWFBFYWs5TlJNOHdvVmJrRzhR?=
 =?utf-8?B?SHZxMUhBR0laMVl0dXpQc0JpeTFGVUhaYy9ldCt3bEhmZEc0WnhzMmtHTzFk?=
 =?utf-8?B?Wlcxam8xNlpuVkx4d0MwbFNHQjkzZWFwU1FNL2szUjRJVjBXZ2V3bzRpVXZI?=
 =?utf-8?B?U0pvNU02eGFla3Bzd3M1K1MycVpHSFNZNHFFT0pEOFFjVnNiMWFPZnJvMjJt?=
 =?utf-8?B?OXVvSTZQd0VoUlVsNGlYK2N4Qzg0SVZBWGJ1Ykk1NFB5L1dsVFI5N3dsVXdN?=
 =?utf-8?B?dkIwQ1ZoaWg1elNsdk1aem5HK2hESG1oTGNUOUo4Z0hoVWdCZk52a01wekty?=
 =?utf-8?B?QVdQSnJwcTZHbGE5aVBqVjZ1RldmYUtNRmx1NmNIQmpHUGtkb3krQmJxeUxG?=
 =?utf-8?B?U3dDMlZ2VE1QeXZoMms5dmtweXR5N1BaaGJpVDhQc3FBdEgwWDVGeUJlUWw2?=
 =?utf-8?B?SUVvOVB5ZXgyTE8wSHl4Z0l4b1puTENDM0FrdkVXcTFsU3lJUk1sNDVQL01F?=
 =?utf-8?B?eDZEYXJPajNWOUhSNmh5c0RjdGxGSThzZ3Y4RDVUMXEyQmJEMWw0MnNZZFJt?=
 =?utf-8?B?blRQZnlKWDM2YUxDbHNjWWZrZ1gyMGx1VXA2TSt5OWlndW5tcjExTSs4TVZh?=
 =?utf-8?B?UjlyQ1FrZkhDSFR0NkpiQS9tSTNJT0NzR2R2eTVKdDgweEIxakIzQ2lIaVhZ?=
 =?utf-8?B?TDZucmFyb3BBc2JLbDZxNHZRNGl5b3R2QUdoc3RhdWh6cmhSTXdwOG5ZM0dX?=
 =?utf-8?B?QXpWSktnN29pK245RXZzWDQ0aThWbGh0b0c5MnBNT2JZYzZ4aUUzd2NWaUtv?=
 =?utf-8?B?SGJJeDAyNG9EQ3JVelQrZHo0TTRtVzhxWlVpTnFtRGlFRSsxbkx5ZVRINDVs?=
 =?utf-8?B?TDJqZVdHQzV0T1NFeUdMS2RUMCtqN1pNbkhXWE9OUHpnWVhVREk2TG10YkJo?=
 =?utf-8?B?VFB0Ti9ubFFGcEM1UE40Z0l1eW9EVXF0S2NJUVVrTFBXWTM1c2FHMFVLcG81?=
 =?utf-8?B?U2loQi84aWtSaHg0TDVZUTBSZXJDNmt3RzQyUmRWbDdMTjZYOTEyMmpDbVVk?=
 =?utf-8?B?cFZScXVMYTZwb211bWpCbXZhZ1FTWDAxRXlxVU5BeGl4UGlYalVMSWM1UGVm?=
 =?utf-8?Q?6NRlVEwCnFaS589mI27bmv/3OTmco4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 10:02:21.0195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a05d2a-ea23-4d17-2445-08dd2f02607b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167



On 1/6/2025 11:14 AM, Chenguang Zhao wrote:
>      The cmd_work_handler function returns from the child function
>      cmd_alloc_index because the allocate command entry fails,
>      Before returning, there is no complete ent->slotted.

nit : s/Before/before

> 
>      The patch fixes it.
> 
> 	Trace:
> 
>       mlx5_core 0000:01:00.0: cmd_work_handler:877:(pid 3880418): failed to
> 	  allocate command entry
>       INFO: task kworker/13:2:4055883 blocked for more than 120 seconds.
>             Not tainted 4.19.90-25.44.v2101.ky10.aarch64 #1
>       "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> 	  this message.
>       kworker/13:2    D    0 4055883      2 0x00000228
>       Workqueue: events mlx5e_tx_dim_work [mlx5_core]
>       Call trace:
>        __switch_to+0xe8/0x150
>        __schedule+0x2a8/0x9b8
>        schedule+0x2c/0x88
>        schedule_timeout+0x204/0x478
>        wait_for_common+0x154/0x250
>        wait_for_completion+0x28/0x38
>        cmd_exec+0x7a0/0xa00 [mlx5_core]
>        mlx5_cmd_exec+0x54/0x80 [mlx5_core]
>        mlx5_core_modify_cq+0x6c/0x80 [mlx5_core]
>        mlx5_core_modify_cq_moderation+0xa0/0xb8 [mlx5_core]
>        mlx5e_tx_dim_work+0x54/0x68 [mlx5_core]
>        process_one_work+0x1b0/0x448
>        worker_thread+0x54/0x468
>        kthread+0x134/0x138
>        ret_from_fork+0x10/0x18
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

Thanks for your fix!
Please add the following fixes tag:
Fixes: 485d65e13571 ("net/mlx5: Add a timeout to acquire the command 
queue semaphore")
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>

> ---
>   drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> index 6bd8a18e3af3..e733b81e18a2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> @@ -1013,6 +1013,7 @@ static void cmd_work_handler(struct work_struct *work)
>   				complete(&ent->done);
>   			}
>   			up(&cmd->vars.sem);
> +			complete(&ent->slotted);
>   			return;
>   		}
>   	} else {


