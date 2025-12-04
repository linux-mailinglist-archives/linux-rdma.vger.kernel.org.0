Return-Path: <linux-rdma+bounces-14892-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E34ACA4B6F
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Dec 2025 18:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7294C3025306
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Dec 2025 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC1D29ACF7;
	Thu,  4 Dec 2025 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ECGHlJhc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D026B08F;
	Thu,  4 Dec 2025 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868079; cv=fail; b=fEwnvZzkQ/5trp14UZyiPKtSp1c0k4vjBOzFwgbtLJYhXmamtWlkvp9iGViJmmWGmlQTRexXxC2yblzqUlOxNgFKQuOGRRA6jFqZH4HyKmKNwvjdGOhbGG+nTPTT2futUsOKrySL9q2PMLzoget+NKgTB+B8HbneiXUt9CzXeWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868079; c=relaxed/simple;
	bh=EKXs/uBoZpyEYgRxgtij2sf5wzJ3iaAcgtB1gw0BZd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TISbASTFc8e9PPMrLQwHDEvFbU5woSklTvWek2sD92LxudU/vh77YeIPb+n/KMs5gupxCL7k6sfRctiWuqdNQvXqGZchlj00da7vDp2ZzKoQuokt9cY/5Hd6XMNT26IkTdQQMY/I3droQorEh70sMALn3BKfh/oz6lF9m33tDOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (0-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ECGHlJhc reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krKkE0zlONkioTmQmZkyEPnD+Eeuth5mrUD7wjLQhChMQkFQcVrY056o/gSbxXeEqWxzMRoLU3l7qfo/zeSfOwUoa1CEEDOhPeRvnqEVB6r1OvEqiIydxOMVdml8DQfLqZOduKyAvXnSGjj+Us6Qidic7gXHvedzWIvTVbALfUzTcSDpbjBgkMcb3jiRVjHnw1QqVzV19s0fCWfGMgO9eseigcWgZjFKRqX5fouGjCTf3J7JYo9PJok9M3loUygR+RSbCp2Zlyn5KQ7aJkjAbCSLkNF8tkD+vB1pimEU3RNMHHUuUb/e8KQdrLW9+to7xDl9k7h9URT6Q4/gW8Jz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7pzPPpfPmvX8qNgcKjyNwv7k8BMB4uSLn9JhU8buXs=;
 b=SAtxnbNi9IY0+soOaJCcs8R5quktfm941OxpSs2TQVYVhbDCZuj55e31oTI8hqwbg+eTR4z0oFzXZV2FJnCi+ev0may4OY9PxMGTdxL8XYtaMRa7tlzYAiWxBZuAbPN7+WgkNhrQmCS9MF4TKpxsac+vBzZw3DiBHK79keHljg2kKZ5gF364QEdkZ9jq+cmRr42wH01B823FGPXdJbMPEwAtmvr9oGRQ78YMBlNVOOhorlFwCb8YYD8SGYrjetBzD3454Rr3vpRYumRpfPcRPG1XAxeMqKIutcBhbU5eG9rTFxHBgOTrLlvzKkpc/1749R6Nr/Jn1WUeaWXkfyHMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7pzPPpfPmvX8qNgcKjyNwv7k8BMB4uSLn9JhU8buXs=;
 b=ECGHlJhcrckfC798JDU2Hsf1VFLUA3Kp38g92zYR58F9jfCmzhx+izPHQhqqtRHbdP0FNXPpCy5IdlRPllk69vikzOtDX5ZuP/JnDPMUD/xzwIN55b+dFXGsaiz1kKFqu0/U/h8qc419RCm7zwP+1a7k6DLWDu1AB8+OGE6ob/DXz6NVJYlmB7TI1CsTHcaYriD2QKjDANrYNuSWXM1e+TeUBacls/qbUFJGj2iQayIjWkD7K8xOE8TH0LpgMV7K8YET511RRWZjUPksa6q4MvbwvMvYruS/Pr06o8ikPn+r5z3G8u0hCU3gg2LYkUAFkSOq45UqKd1lkwNftiSkgw==
Received: from MW4PR04CA0178.namprd04.prod.outlook.com (2603:10b6:303:85::33)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 17:07:53 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::81) by MW4PR04CA0178.outlook.office365.com
 (2603:10b6:303:85::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Thu,
 4 Dec 2025 17:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 17:07:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 09:07:28 -0800
Received: from [10.242.158.240] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 09:07:22 -0800
Message-ID: <1bef8fd9-e9b8-4184-98be-98d016df20d0@nvidia.com>
Date: Thu, 4 Dec 2025 19:07:20 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fix double unregister of HCA_PORTS
 component
To: Gerd Bayer <gbayer@linux.ibm.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Drory
	<shayd@nvidia.com>, Simon Horman <horms@kernel.org>
CC: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	"Niklas Schnelle" <schnelle@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20251202-fix_lag-v1-1-59e8177ffce0@linux.ibm.com>
 <7ae1ae03-b62d-4c49-9718-f01ac8713872@nvidia.com>
 <502727b0ad4a9bc34afb421d465646248c69f7d4.camel@linux.ibm.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <502727b0ad4a9bc34afb421d465646248c69f7d4.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4c8bd8-16d8-4f73-1e4d-08de3357a96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmNQRFJ4WEpGaW53Wngwd21JTzQ5ZFZQYktwUStGRUFMTi85ekdkby9pUVlX?=
 =?utf-8?B?TG5WcGdPc2Z1bWtpV3hPK2o1TVZyVTVsTVA0VXRjMkxodGdqM3F6WmltbktQ?=
 =?utf-8?B?VUk3WmFRQi95ZmRJcGNCUUN3RTVodmd4RUcxME5XSHhCVmlRZFZQK2lkaXJC?=
 =?utf-8?B?ZFBXZmkxV1lNWUhGdG91MG9jRzlUMkExYnFTLzNUUEN3bTNDWFhHT21NaWlW?=
 =?utf-8?B?aENpcnd5VmlRUnFSazNRZ1ZCNW1TMmgzS3hCRVpJaUhuSHJHaEw1WWsvSHZZ?=
 =?utf-8?B?cHFpRWVNWDVpU3FJcW8rU21uR01JWU5ZeUZyRUp0MkZpSnQvdW10d0U1STd1?=
 =?utf-8?B?djJlR002TWtuTW9IMExoVjRlZ2VIMUJaWDNZYjF2aTZyU3JXZldzYUc1aDg0?=
 =?utf-8?B?Ymwxb3EwblNqRUtMS09SVHU1c3pZQWt3NzNwbkN1WTg1Si9iNmVxZmZFZ3Vj?=
 =?utf-8?B?RFYxL0xFUkFsUnNZdkRsdnRUZ2lhTXM1QnZLMlVrZ0tVV1prN2JTb2FDZkZE?=
 =?utf-8?B?TzZGS3BuSXlhWVpQdVBaaGt4emtVbk9Pd2hna1RoUW5NdjB3QWFINTdyWmNi?=
 =?utf-8?B?bkNDT1h4MTBnL1hNQTYxTHdtbk5TUTJkUzExRFVrK0RsSVYxRDlxVENuUzB5?=
 =?utf-8?B?bW5jb3ZhZm5hUnhSR0VQUVhJTG56SU4xdDZscXZjRXlZQnVmSTBCQjJueUVq?=
 =?utf-8?B?Si8vU1RIVkQySXZmdXk1Nk16d2puSEtsZ1Rha3VRQW5jdHpNczZ1emkyRkFI?=
 =?utf-8?B?VGFVb0tGU0wxK1FQMkRuQjQ5TDU1SDNGZWJBTmhHYW5DMTRjSExmbjNLejJJ?=
 =?utf-8?B?aHlqRHVaSmJBVTJFaHJNMElBakJzQU9QeVVUellMQ2Rob0dTTk5CeFoxZ0E3?=
 =?utf-8?B?UGh6QXFKd1ZoN21rSXBWMlVlNVFlTEM4aERRSDkvUVQvczBCSXZGd0s2NURl?=
 =?utf-8?B?cFo3Mis1bHAyS1VYTStQZzdoWGRPcS9iMW0wWGFGZWg1MHhkNThOSXAzWGkw?=
 =?utf-8?B?eVBoWUpiTmZ2ZytpOUluVlJQYm00dkxuTk1MMVMxazM5eEpiWStVUitsbU1s?=
 =?utf-8?B?eG9wcUFVVEJQNXVaUTc1cWhBYTQ2VndteTM4WGwxdk9HaFZnWllxYktKa1Bu?=
 =?utf-8?B?TzI1OWpEckU5Rm5sbTBKdm9kMC9wdnE3aWVmM1JhdTBrV2xYcC80bWh5M1Fr?=
 =?utf-8?B?SDBvdEl6Y2VKTHpEZXJMMTlqa2FDNHduKzR4T3N4N3BJQ21aR21iemt0T0dF?=
 =?utf-8?B?QjlXV0lDR214VDBjbDNDRjZrUW5wMUcvUDdEZGRZK2l0NENTdU03TWFZNEFl?=
 =?utf-8?B?NllDSlhCaHhCNDg1Z0x4ZGZwOXVQSVYrMDMzWUVUOFlUZ3R3dzVMODNYOW52?=
 =?utf-8?B?ZVN2UHlvTmVWWG80SXYzN0VkUUo4cDRmWUtMZytjMlRFM0FTL0ZSdzJLYkxQ?=
 =?utf-8?B?YlZJTExGR0k4U0drSFNCRXhYWHBJRnpSb3k0T2Q2V1RKeGs5a3R4QlVPY24w?=
 =?utf-8?B?bHFIM3Baa2tKcmE1UW5yVGwxVjJiUGFXSmxsM3ZkeFFOaFYxdXYrVWxqT0pF?=
 =?utf-8?B?VXgxbEEzN3BqRzAvU005L2QxcDAva1dFZW5XMlhxV0NtRlN1aDBFd08rTDds?=
 =?utf-8?B?TFFaQkFUNGx0ckFSMi9tSXgyNXI2dWZtNEl4clUzempiZU5SakcvL1JiR1Rj?=
 =?utf-8?B?MUI5SFV1d2xJZDNFWS9KbXE0QlJISWFISDVZaFdVSFBHeTAvV3hwWDVSV05q?=
 =?utf-8?B?c3FrTml3ZXY3M1FtTXdsSk54d0M1d0phK05mVXl2bHc3ZDVsWDdINVd3TUYz?=
 =?utf-8?B?RTZzZE9NcHlFcHBUZFFSZldacUJlNGhwaXo5VmlOWWkvWmJzeDhGL0lOeVJ1?=
 =?utf-8?B?dzk0VmRmU29obWFFRkdCMjUvZ3Bhbk4zbVZxRCtOYmlIZ3g2UStkcHRFMkJT?=
 =?utf-8?B?QkZOWjFITytTNU5pRGFpdzc4NitXV1VPdnpLZzc5eStlenNYaFZ0L1JaLzJS?=
 =?utf-8?B?VXVqbkduTXNMTU94NUdtK2J6UDl6eGh4VGtLVWFmeUE1S1NSVk50YUhYcURx?=
 =?utf-8?B?dnlJUlEwZ3lWK01GbE4vaWZGdGNzLzUwMUE2TXc0c0c1Y1NwR0VST2E5bXBa?=
 =?utf-8?Q?pujpQsdWMWqclZ87M4G3fzK7U?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:07:52.9842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4c8bd8-16d8-4f73-1e4d-08de3357a96c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873



On 12/4/2025 11:48 AM, Gerd Bayer wrote:
> 
> On Wed, 2025-12-03 at 17:14 +0200, Moshe Shemesh wrote:
>>
>> On 12/2/2025 1:12 PM, Gerd Bayer wrote:
>>>
> 
>    [ ... snip ... ]
> 
>>>
>>> Fixes: 5a977b5833b7 ("net/mlx5: Lag, move devcom registration to LAG layer")
>>> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>>
>> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>> ---
>>> Hi Shay et al,
>>>
>>
>> Hi Gerd,
>>    I stepped on this bug recently too, without s390 and was about to
>> submit same fix :) So as you wrote it is unrelated to Lukas' patches and
>> this fix is correct.
> 
> Good to hear. I wonder if you could share how you got to run into this?
> 

mlx5_unload_one() can be called from few flows.
Even that it is always called with devlink lock, serial of 
mlx5_unload_one() twice caused it. I got it on fw_reset and shutdown. I 
I will submit also a patch for calling mlx5_drain_fw_reset() on shutdown 
soon.

>>
>>>
>>> I've spotted two additional places where the devcom reference is not
>>> cleared after calling mlx5_devcom_unregister_component() in
>>> drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c that I have not
>>> addressed with a patch, since I'm unclear about how to test these
>>> paths.
>>
>> As for the other cases, we had the patch 664f76be38a1 ("net/mlx5: Fix
>> IPsec cleanup over MPV device") and two other cases on shared clock and
>> SD but I don't see any flow the shared clock or SD can fail,
>> specifically mlx5_sd_cleanup() checks sd pointer at beginning of the
>> function and nullify it right after sd_unregister() that free devcom.
> 
> I didn't locate any calls to mxl5_devcom_unregister_component() in
> "shared clock" - is that not yet upstream?

mlx5_shared_clock_unregister() in 
drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c

> 
> Regarding SD, I follow that sd_cleanup() is followed immediately after
> sd_unregister() and does the clean-up. One path remains uncovered
> though: The error exit at
> https://elixir.bootlin.com/linux/v6.18/source/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c#L265
> 
> Not sure, how likely that is...

It comes on error flow but after successful 
mlx5_devcom_register_component() in sd_register(), and that error leads 
to error flow in mlx5_sd_init(), which calls sd_cleanup() too.

> 
> Thanks,
> Gerd


