Return-Path: <linux-rdma+bounces-12670-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8578FB20850
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 14:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E70189E37E
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179782D3738;
	Mon, 11 Aug 2025 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wphenp0G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7432253A9;
	Mon, 11 Aug 2025 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754913959; cv=fail; b=SVg6skwgPiZQ9pWOVXDpr9UQ/U0KZcRSU7SPXyz42imMjKHNCGtsIlMcMWv/MzBrcgBNhFYuUsSMP61Eb/zah/1Y8MP7K2hfMoXZpAC3nH74hrOFVMD++3brqmuebMroRAK5Kd4gimqeK7cQEudqQ6fyDwwK4gLfrD7gTIk5dTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754913959; c=relaxed/simple;
	bh=mvx/7GAFEjpOnB2AJyg4GuZae8hjFKr0FJS60/dz/nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n/OWLKkZZXpasLJQzPDTQoHpuEeuaiFGJHiU2GzoAFndpQgDufEksnTTQVuYSdWhrOqx4nmqeA6gu78dl+5pGnzwLTPK/6BefkQmw46++NqllEr5RxoShic3fkA32M5ir2Bwp86tb1YO/glmgC1DjnqDfsoc81COzhKL9z/DMQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wphenp0G; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCO13ojlrvbWentScAbUPnNSiGwdcwIOfh/rH+GOHXP5+Svv+RwnT/S/gIaGI7apKNdsBv4XPj+pzOb1HCqy2+U31s4LqAwoQPO1aV6rKQbUGzuj1Xzq7S5TDFNmV5b7tvAf+R7JOA9KpTkk+I/yvOEoV9KE6jULtS+yg8TLbG3O+X1+fFFzniFCF4OwyEcsJX1XMX9Zq6UpzrXiROc4KocKMmwMB6j2yUzO/C683gGN3uj2IBWtPwk91No5YpGPn5ZHZ5xFFzxVrV6HoJEsfadEVSa6zavlMC+rvhJlPxrisHzBR2wkZsE8iqqVjWG+yVKx1qD2CA/Z3ViRU08Wig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysp5b21zJbotB4ycMpWNAAo/cBHP+NlNGRCrzAcf9Mg=;
 b=ipHJVrkW2N6CgK5dtBwmUw8mnncUW0kEwnlj6/vxqznkNb59aMO/uC8YhDraM3WrCGGooPSp+5yKMSj96yGpwYzsXIM9aa3j0/SD896+bph3h3ev0tAE1rItNwa76fbO45dXxux0Ms4xc5BJzRQVUK7eh5TowzNK6yyluFqtpzVLzU0inw/CYUz2xWDzwuvufotkilq0i6yBAd47U6I47mW5Ce3/z0EJ5CRL0pEfjQAmRA5ekeH4/PAAbJc20QnDiegFmz5ubfX2Vr6O2U96b/Zxxn7H94+ye7fY+hO8O1ud5HH1dzS4m/0eowfk0TzQ1hB2cVevqpKotTPPPKT+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysp5b21zJbotB4ycMpWNAAo/cBHP+NlNGRCrzAcf9Mg=;
 b=Wphenp0G39i+8I9aLGMMzHGIU+rkr62GGymrWYVGEtmQBjA/OgehU08OfuvbLuDwLNfuOYwTwA5WoUFlTpxgMp693bAmyo2UTF/hlrDqT8vU1VMkNOfuJksnJLiXXfSjgjs5ulSwk8hmq5PvKuF6QhAP/hSnHaxAvEih7PKUxhlr0IP9lz9mCV0+It+vbx9n+/DKr+M9a0fefe2wBrT6so/imCfRFcnN+4QVpnoKy91kMixfgcrAs0Tjjqzl+ceroRGAo2KHJUFvXdWPej5LMmVOGQgLMRVyFjqqIumKUnL+oSzEPlvCCpGW10c0T8++rwZPTdV1ABGsYtFu4CGxjg==
Received: from BN0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:408:e6::28)
 by IA1PR12MB8587.namprd12.prod.outlook.com (2603:10b6:208:450::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 12:05:55 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::2a) by BN0PR03CA0023.outlook.office365.com
 (2603:10b6:408:e6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 12:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 12:05:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 05:05:36 -0700
Received: from [172.27.33.48] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 11 Aug
 2025 05:05:28 -0700
Message-ID: <2fa90540-0560-4d5b-9f3a-27ade6c92d01@nvidia.com>
Date: Mon, 11 Aug 2025 15:04:23 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Avoid deadlock between PCI error recovery
 and health reporter
To: Gerd Bayer <gbayer@linux.ibm.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Moshe Shemesh <moshe@nvidia.com>
CC: Niklas Schnelle <schnelle@linux.ibm.com>, Alexandra Winter
	<wintera@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Yuanyuan
 Zhong" <yzhong@purestorage.com>, Mohamed Khalfella
	<mkhalfella@purestorage.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250807131130.4056349-1-gbayer@linux.ibm.com>
 <44d0f39d-890e-446b-a2a1-3d52e2592a95@nvidia.com>
 <ef665e6ab7744cc32b44b8f5865726a0e3d97fc8.camel@linux.ibm.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <ef665e6ab7744cc32b44b8f5865726a0e3d97fc8.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|IA1PR12MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1fb320-988f-4f3c-78ea-08ddd8cf6d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjNHL1VHajBJUTBIUGF0bVhZcmpJeFUvV1dSK0pacmFiWm91SHpGeXg2dTBH?=
 =?utf-8?B?TWU1ZzRoT1NSR3VzZUt0aEpuZHdsOVNDaHdxcUlNcG9nc0lmc0xjSWhLUndP?=
 =?utf-8?B?T2VycDlYTm1McGkyUE9zY2t4a2NzNkxONElnaXVlUEswRWZsODVBQWFhb0FX?=
 =?utf-8?B?L2s4UXZoVFVyTStXYUR5VWdxTm8weUxzVTJ0eG1selUzUUlONStSTVNQRS9z?=
 =?utf-8?B?eU1ONkxmREVvYlB4NXFxWmFMTTFBS1d5clFQTkZpd013cER0UXNlVE1sTmRn?=
 =?utf-8?B?NnErTGd0WVJiZ1lRY0o2QlI0KzloNjlWUkFFOU93M0Mxakc3QWc0Sk0wTFlo?=
 =?utf-8?B?SjdDNW5obnZZOE1CZ0VVNmVNWVR0Qmc3UjV5RzdSMjlld3IyL25EYnF4OGZ1?=
 =?utf-8?B?bis1SklleFllSjQ5Y0p5YVY3VEFpK2NFaHNzcWp6dndGUFJjajcxc3QxVFg0?=
 =?utf-8?B?YWFmdm5JakdLMWNSMUJ2OU5MRXBraHhqT3RWZDc2VUZtZzBBeE5FU0JGYkcv?=
 =?utf-8?B?L29YMmJBbmtpN1dHNmdkOER6U2NlSkJmWldDdXBOUVFRNnhYckpjUU1xZHJZ?=
 =?utf-8?B?Ym1RWW1FRFlUMzNZWStCTG5iNVhlZVZpVTNaeDczRkJ4bHNoRytoTDdqQ0h1?=
 =?utf-8?B?YkJ4MTV3bjNvU2RvLytMeitleURxb2g5ckhCV0t1czY5cXMwTmRhWGx5WGhX?=
 =?utf-8?B?MUNpcWFucFFGSXc1OW42aUo1am9nNE9tN29GUXR3RmRDNDA4RXovZWtENzM3?=
 =?utf-8?B?ajJsbGFWc0I2TXI1VW5TMDhOQmlFbnhHb3loV28zN1pCQ2E4M0VuY1psajNj?=
 =?utf-8?B?SmJXZVR4eG9yMWRUQTV2NHBFamZ0alJRV0FQVktDa2FmS3NRWTE3M3BCU2Vv?=
 =?utf-8?B?V0FhZVBJQWI0N1BOZlE5QVpQRndiaW1ETWV2anBnc2tHUUVueFR0SldFYm5V?=
 =?utf-8?B?Nm40SjdRbms3amlTQm1GNmxOUG1yRVRXbnpZRitObkdqejVVcmNCQ2l2LzUr?=
 =?utf-8?B?VzN1K09WaGV2ck44UXZzaWFBWWdXcHF3NGpJRjk2MzFtZ0JnbURLdnpic3dD?=
 =?utf-8?B?Q243ekQ2SjAvRkdOa2ZONjZNQ24wUzBlU2d5NlFqRmtZL0tnNm5vMVVxVnJH?=
 =?utf-8?B?ckNWV040UWc3UjdnblRlcHJYdlJJMDFYZ1R4YmRpNml6eGxCTmIwUEw1cWk3?=
 =?utf-8?B?SnFIRnM1c3pJb0FyUmhUS0UzK1QySHNYRWN4Q2NTU1RJYTBseVFEaUMrUzly?=
 =?utf-8?B?MjdkMDRHeHNNS09YdFhTM00xL21FaE4zMk1VditQTjBuQ1FRUXRTQThaemJy?=
 =?utf-8?B?WUJqejIrUTdRcFJWRTZUM2R0N0RRYkhiU25lMkIvcWZ2dkt2cEt4N0hEd2RP?=
 =?utf-8?B?dFdSZ2hndWtHZXZlWm9udENnTGxTT0tXcDNJd1Z1QUdSNDczR3VydFZKeCs0?=
 =?utf-8?B?elNEQzBoR1loOFQ0TldhV2c3MUhyYTRVYkFYai9idWhZOTZZR0RYaTRQbDNH?=
 =?utf-8?B?ZkpaMzI4cktmcnlFZE9kbldTVm5jR2puY3ZSdWZnMWx2dGZHSnZ6d3I4N054?=
 =?utf-8?B?cXc3dFhUN3AvY1VQc2RxRU9nMGsrU3EvSjVTSHZDWE51bVJsNUhxVjRKQnlY?=
 =?utf-8?B?MzRLZy9sVW9meUhFbmRLNGFRdHBVb1JTV2M4WEoyY2ZEQ1FXMk5pblZkK0lm?=
 =?utf-8?B?TDdUTkVkL0IxdEpnWmYwUXA4ODMrTWdHNFU5dHNxWWRoUklYL0RZaFRmVUtW?=
 =?utf-8?B?cGpLY25nTDk3S0E1cVdxd0wxaEJLWmtpMUxFYmpRdVltaFEzVUlpVWJEL3Aw?=
 =?utf-8?B?TTdOb3d0NW4rUUZBelhmL21lallSVXdVb3lDMUptMGZWUXUydUd3MGVZK3dR?=
 =?utf-8?B?YXd3ZUVVUWU5bVdHaXVHT1JWMEdWQlVnUFQwSDRQS05sandSR2JCSzk0Vzlm?=
 =?utf-8?B?bWNOSkdvOC9Fd2pFSVh3MFBra1RnV0NrU2xZY2p2bHJ6Tnh0alROeGlYSzZq?=
 =?utf-8?B?SVVpeFZvR0R0RUxiRmJGdlNMOXBnV3NSYXJ6aktHSWFDZGRyelB3NTIxblNV?=
 =?utf-8?Q?9NHV4v?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:05:55.2074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1fb320-988f-4f3c-78ea-08ddd8cf6d04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8587



On 11/08/2025 10:29, Gerd Bayer wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, 2025-08-10 at 14:51 +0300, Shay Drori wrote:
>> On 07/08/2025 16:11, Gerd Bayer wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> During error recovery testing a pair of tasks was reported to be hung
>>> due to a dead-lock situation:
>>>
>>> - mlx5_unload_one() trying to acquire devlink lock while the PCI error
>>>     recovery code had acquired the pci_cfg_access_lock().
>>
>> could you please add traces here?
>> I looked at the code and didn't see where pci_cfg_access_lock() is
>> taken...
> 
> Sure thing. This is the original hung task message:
> 
> 10144.859042] mlx5_core 0000:00:00.1: mlx5_health_try_recover:338:(pid 5553): health recovery flow aborted, PCI reads still not working
> [10320.359160] INFO: task kmcheck:72 blocked for more than 122 seconds.
> [10320.359169]       Not tainted 5.14.0-570.12.1.bringup7.el9.s390x #1
> [10320.359171] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [10320.359172] task:kmcheck         state:D stack:0     pid:72    tgid:72    ppid:2      flags:0x00000000
> [10320.359176] Call Trace:
> [10320.359178]  [<000000065256f030>] __schedule+0x2a0/0x590
> [10320.359187]  [<000000065256f356>] schedule+0x36/0xe0
> [10320.359189]  [<000000065256f572>] schedule_preempt_disabled+0x22/0x30
> [10320.359192]  [<0000000652570a94>] __mutex_lock.constprop.0+0x484/0x8a8
> [10320.359194]  [<000003ff800673a4>] mlx5_unload_one+0x34/0x58 [mlx5_core]
> [10320.359360]  [<000003ff8006745c>] mlx5_pci_err_detected+0x94/0x140 [mlx5_core]
> [10320.359400]  [<0000000652556c5a>] zpci_event_attempt_error_recovery+0xf2/0x398
> [10320.359406]  [<0000000651b9184a>] __zpci_event_error+0x23a/0x2c0
> [10320.359411]  [<00000006522b3958>] chsc_process_event_information.constprop.0+0x1c8/0x1e8
> [10320.359416]  [<00000006522baf1a>] crw_collect_info+0x272/0x338
> [10320.359418]  [<0000000651bc9de0>] kthread+0x108/0x110
> [10320.359422]  [<0000000651b42ea4>] __ret_from_fork+0x3c/0x58
> [10320.359425]  [<0000000652576642>] ret_from_fork+0xa/0x30
> [10320.359440] INFO: task kworker/u1664:6:1514 blocked for more than 122 seconds.
> [10320.359441]       Not tainted 5.14.0-570.12.1.bringup7.el9.s390x #1
> [10320.359442] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [10320.359443] task:kworker/u1664:6 state:D stack:0     pid:1514  tgid:1514  ppid:2      flags:0x00000000
> [10320.359447] Workqueue: mlx5_health0000:00:00.0 mlx5_fw_fatal_reporter_err_work [mlx5_core]
> [10320.359492] Call Trace:
> [10320.359521]  [<000000065256f030>] __schedule+0x2a0/0x590
> [10320.359524]  [<000000065256f356>] schedule+0x36/0xe0
> [10320.359526]  [<0000000652172e28>] pci_wait_cfg+0x80/0xe8
> [10320.359532]  [<0000000652172f94>] pci_cfg_access_lock+0x74/0x88
> [10320.359534]  [<000003ff800916b6>] mlx5_vsc_gw_lock+0x36/0x178 [mlx5_core]
> [10320.359585]  [<000003ff80098824>] mlx5_crdump_collect+0x34/0x1c8 [mlx5_core]
> [10320.359637]  [<000003ff80074b62>] mlx5_fw_fatal_reporter_dump+0x6a/0xe8 [mlx5_core]
> [10320.359680]  [<0000000652512242>] devlink_health_do_dump.part.0+0x82/0x168
> [10320.359683]  [<0000000652513212>] devlink_health_report+0x19a/0x230
> [10320.359685]  [<000003ff80075a12>] mlx5_fw_fatal_reporter_err_work+0xba/0x1b0 [mlx5_core]
> [10320.359728]  [<0000000651bbf852>] process_one_work+0x1c2/0x458
> [10320.359733]  [<0000000651bc073e>] worker_thread+0x3ce/0x528
> [10320.359735]  [<0000000651bc9de0>] kthread+0x108/0x110
> [10320.359737]  [<0000000651b42ea4>] __ret_from_fork+0x3c/0x58
> [10320.359739]  [<0000000652576642>] ret_from_fork+0xa/0x30
> 
> The pci_config_access_lock() is acquired in zpci_event_attempt_error_recovery() by way of pci_dev_lock().

Thanks a lot!
can you please add the above to the commit message?

snip
<...>


>>> ---
>>>    drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 7 +++----
>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
>>> index 432c98f2626d..d2d3b57a57d5 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
>>> @@ -73,16 +73,15 @@ int mlx5_vsc_gw_lock(struct mlx5_core_dev *dev)
>>>           u32 lock_val;
>>>           int ret;
>>>
>>> +       if (pci_channel_offline(dev->pdev))
>>> +               return -EACCES;
>>> +

There is still a race here.
it is possible that mlx5 have passed the above check, while
zpci_event_attempt_error_recovery() already took the cfg_look but still
didn't change the pdev to error state :(


>>>           pci_cfg_access_lock(dev->pdev);
>>>           do {
>>>                   if (retries > VSC_MAX_RETRIES) {
>>>                           ret = -EBUSY;
>>>                           goto pci_unlock;
>>>                   }
>>> -               if (pci_channel_offline(dev->pdev)) {
>>> -                       ret = -EACCES;
>>> -                       goto pci_unlock;
>>> -               }
>>>
>>>                   /* Check if semaphore is already locked */
>>>                   ret = vsc_read(dev, VSC_SEMAPHORE_OFFSET, &lock_val);
>>> --
>>> 2.48.1
>>>


