Return-Path: <linux-rdma+bounces-19430-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPBJFAvG5WlIoAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19430-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 08:22:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE9C42729D
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 08:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2EC5930028FF
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 06:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D1C1A9F87;
	Mon, 20 Apr 2026 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OaQMeh8w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B602EC54C;
	Mon, 20 Apr 2026 06:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776666114; cv=fail; b=OKT3fHT53hYCEsu4R6F7sMy78ilVUini/KaNQ+oXlfheJB5CtkglRG+6XnIm9H6Y8EAbJb5M0PalrYULzw0RYdypaRqyMlFJiC7s1/9Racet32fDSJLcZQZN5XPWnQstuQ2TcxIEG7/+pDKf0jgYMuHKHkARpyPCTAYLJM1QT0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776666114; c=relaxed/simple;
	bh=w/wSs6VUtjZZ0d28ctRaT1sZpXLpkgB/acRbEWpG6lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QmoyG4/dPE6RWjo1mcfNOpHukx9NpXJGqr11Nk158plRTtXkju+0gYIKw8Ewb4wSl7ncwntahUzFIDqxg/bjDV46AnCq/BtIGqUWLY/Ib1yTVBPzWBxQ2HQovzeBbWwkXhYT9MZPEbjYnuNkArhDbvosAJjrW+5hq4YpT8GP39U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OaQMeh8w; arc=fail smtp.client-ip=52.101.48.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dt/6SDxGIbzpuzQ98MSv1BWqvYWR96QMSc9aICf8gZ1HXE+y8tYR4maRtODce4OhNb5+MtbvMOudXhjrwxlQ2+Lqz5H0+g8wIVAAfN57HOYcRTOqFR5k8Gmrdou6xM5Xf9MVdAVDIKta90025c/a7JOk9ohwRC94HwIwgn4/gu4L2Q/vdpK285H+GZY7JJQ9dkYgByG0r0wI5aY+t80IKUECEME17V6rp6IMmmRN6eNt3rB7+zaWmR6vxvM3qSL7F2quT6nepDiGe7Yz50kejsHUVWyf8iTAnzCvbK/bU2FMmS3pdfnzwcbnu07Svbi43USMXmxdqE9IdvzCFdSpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHdanNfiMlKFmg+UtwEfWjrSjcZS7RrylCZXPQ/RdW0=;
 b=GgWMacfg/fIfD5KTnRzzVOUwxHGJuVXrllmlZJJDBOHPH8qXy/DEBepPpa4W7udcEGqYYecxgtAHeB+Z5GE9bfB6rG+RLRnb1jPY0d9k4XetBGLdkWyKyWTvWvUU2+lRxo9ij5Gx7HGanEUYiYXbIHQIVwd+wNJGRlLJ5zey6ALWkyZSCAJuIWsTKvQ0TKvkswrESEJDBZuSkfEhRavfNDatmojFtqTwUTT+4zFcaCsD4QWCDtzNlLeOgAP56ZmD5GajQWIpQ089bdQ6xXZAruvdF2G44mSxrrcxlyjNi1l555v3uZvWNGNLYYHuQa0xAHrfHJUMFXc4mTF9TkVbkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHdanNfiMlKFmg+UtwEfWjrSjcZS7RrylCZXPQ/RdW0=;
 b=OaQMeh8wZjDDT2BYX5EVkfJyhNuIp+/8VQKp6+5BvaEcTZXrLrr+PXHa3DInGiqJLjnFCPG4h6o1GHprYPc270HZqnO/SNgrH7Qs7DGteFoKPM7X0sYpiLSUyyxrLJ7qTNEOmK8XKirlR2SKlYEJSY+ho18EisxWa2fHSTtxxjkGwInwuH3SUo5HdG6Q8f6HvPlTXbkpNhvt3FItc1Vdb/pNotpozoF5pJcUZWt8MfAU0+kdTPZ9OJib3rYBTWA61R0lksfHjM7RpFX8x4suLAtJ41BJxUDTyhsgDq+GSxm4cB6YdIkhFfcAViM6nclG+3t2HYsyOqOtY4WWm2naiA==
Received: from CH2PR18CA0017.namprd18.prod.outlook.com (2603:10b6:610:4f::27)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 06:21:47 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::de) by CH2PR18CA0017.outlook.office365.com
 (2603:10b6:610:4f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 06:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 06:21:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 19 Apr
 2026 23:21:33 -0700
Received: from [10.221.202.31] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 19 Apr
 2026 23:21:26 -0700
Message-ID: <70536063-73cc-4121-aa67-631d2275ff29@nvidia.com>
Date: Mon, 20 Apr 2026 09:21:23 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 3/3] net/mlx5e: SD, Fix race condition in secondary
 device probe/remove
To: Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Simon Horman <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260413105323.186411-1-tariqt@nvidia.com>
 <20260413105323.186411-4-tariqt@nvidia.com>
 <b429c6d3-8f6a-41fb-a9e6-9867a8ee1ad8@redhat.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <b429c6d3-8f6a-41fb-a9e6-9867a8ee1ad8@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb0125b-c683-4439-9998-08de9ea51a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	V2UJSTaK3c+M7aNELoparbsZ/B9AowYJOtsPnWwz9IM7PpaxMoNRDdRdX80WtHrSSYDwZKDBwohKvNemaQ5FRLyDA2RbRhuZoRtJgazlRXm9/wB59tK80zRzulwGjaXJjD7lgcYY59SYL/4zfE4PKfaOUNnG25ATgYwRsIrGmYSF/S6LuGjx6noPY73adTIzw1CLXneF3BTAkl9wANNGXq2eRoXHR8fJhSIw0DAA7Ysai8O4MPkNDKVj6CxvbtxeH+fmF55/pt/BoxeT2gByATm/oXSv0G8frHsyXsSlzFy1HqTKcRVCF9z08rF3JykxbuyiPYLW/c5w3fIDcb0SlV9+AS7spG6EoiMxRupSUcg1kFEG1nzWuiN+ZoKTyHCD8FskPUKKhUBZ7l9eTrmNg7Y5/ieMvyx68pMMCUJox73y6rGrtnepudOtcZ9qjjb4gHDCndQObEf/a7iLIerhwGjPLhbQtc/2GYlowD/Tf7nflkYT9TM3gnCSpOoLRFnBaKqEUtMx/VnIqtAsk4vbENm1zQvLdybKWvSl7aEzYl5Mihm0vtf3Z1Ib85H3SD6Q7D5iFIyeIZz3YxADsIJGzRrwaI7DfNN8yY3UqlYGpKM0r480++4lyPbGM3KtPA1uMTL/i+HoLNdwwwhpKnVJki61LbgYx0beqJu0XynQAEsE/U+AswPtQY6z+1MeU7Vodmqh4YLNfbiBTx7aUY7V8NvIcmmpC/btZqFSFZS8H5vW/ZhAHbkNXC7mclxryEOXe8+SP7L4L/qELdKgTC4cpg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5MuSxvxEUWj7qyNuIj2Pxyqe/H0soUlobf9FjBGfkX1DoY4t/kxm+CbeC0Ew/gIz+6MQVLW0zbO/PkcgWz4KQ9MBVYacrr1n3qo5OEWWMdKb2l4+kYBepMmyR12qVZnDcwQklhS7acIwQZqrfD9wwh5ppLm/qgaAnx4PG3hMSgMxKS2dcdydbAKFMfHVc2Ya+7FacgjRGPdE8iddoqezqz46KHjHItcPyhBjMR/tl+1y4RiZQT/LTS0SLl8+x9oWF3e4Yr2r1klb4uEz7fopobs0TaqY4pj/S76tmTeE0f+YC0oOUva5e6A+EX2LLkDWN6WnEg69FUjHoY+3RhF2vIyCYDxc5lUR7gf75OvfDXLAqDZ/IupYnvDyHmaJ5mZ8OJGgWKyrEy+xjeAl6J96VYFfcgBnAKAkiM/d8/fw35wwrBti0NbEkSabUdBCFkbu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 06:21:47.7528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb0125b-c683-4439-9998-08de9ea51a2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19430-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4CE9C42729D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 16/04/2026 14:07, Paolo Abeni wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 4/13/26 12:53 PM, Tariq Toukan wrote:
>> From: Shay Drory <shayd@nvidia.com>
>>
>> When utilizing Socket-Direct single netdev functionality the driver
>> resolves the actual auxiliary device using mlx5_sd_get_adev(). However,
>> the current implementation returns the primary ETH auxiliary device
>> without holding the device lock, leading to a potential race condition
>> where the ETH device could be unbound or removed concurrently during
>> probe, suspend, resume, or remove operations.[1]
>>
>> Fix this by introducing mlx5_sd_put_adev() and updating
>> mlx5_sd_get_adev() so that secondaries devices would acquire the device
>> lock of the returned auxiliary device. After the lock is acquired, a
>> second devcom check is needed[2].
>> In addition, update The callers to pair the get operation with the new
>> put operation, ensuring the lock is held while the auxiliary device is
>> being operated on and released afterwards.
>>
>> The "primary" designation is determined once in sd_register(). It's set
>> before devcom is marked ready, and it never changes after that.
>> In Addition, The primary path never locks a secondary: When the primary
>> device invoke mlx5_sd_get_adev(), it sees dev == primary and returns.
>> no additional lock is taken.
>> Therefore lock ordering is always: secondary_lock -> primary_lock. The
>> reverse never happens, so ABBA deadlock is impossible.
>>
>> [1]
>> for example:
>> BUG: kernel NULL pointer dereference, address: 0000000000000370
>> PGD 0 P4D 0
>> Oops: Oops: 0000 [#1] SMP
>> CPU: 4 UID: 0 PID: 3945 Comm: bash Not tainted 6.19.0-rc3+ #1 NONE
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>> RIP: 0010:mlx5e_dcbnl_dscp_app+0x23/0x100 [mlx5_core]
>> Call Trace:
>>   <TASK>
>>   mlx5e_remove+0x82/0x12a [mlx5_core]
>>   device_release_driver_internal+0x194/0x1f0
>>   bus_remove_device+0xc6/0x140
>>   device_del+0x159/0x3c0
>>   ? devl_param_driverinit_value_get+0x29/0x80
>>   mlx5_rescan_drivers_locked+0x92/0x160 [mlx5_core]
>>   mlx5_unregister_device+0x34/0x50 [mlx5_core]
>>   mlx5_uninit_one+0x43/0xb0 [mlx5_core]
>>   remove_one+0x4e/0xc0 [mlx5_core]
>>   pci_device_remove+0x39/0xa0
>>   device_release_driver_internal+0x194/0x1f0
>>   unbind_store+0x99/0xa0
>>   kernfs_fop_write_iter+0x12e/0x1e0
>>   vfs_write+0x215/0x3d0
>>   ksys_write+0x5f/0xd0
>>   do_syscall_64+0x55/0xe90
>>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>
>> [2]
>>      CPU0 (primary)                     CPU1 (secondary)
>> ==========================================================================
>> mlx5e_remove() (device_lock held)
>>                                       mlx5e_remove() (2nd device_lock held)
>>                                        mlx5_sd_get_adev()
>>                                         mlx5_devcom_comp_is_ready() => true
>>                                         device_lock(primary)
>>   mlx5_sd_get_adev() ==> ret adev
>>   _mlx5e_remove()
>>   mlx5_sd_cleanup()
>>   // mlx5e_remove finished
>>   // releasing device_lock
>>                                         //need another check here...
>>                                         mlx5_devcom_comp_is_ready() => false
>>
>> Fixes: 381978d28317 ("net/mlx5e: Create single netdev per SD group")
>> Signed-off-by: Shay Drory <shayd@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   .../net/ethernet/mellanox/mlx5/core/en_main.c  | 18 ++++++++++++++----
>>   .../net/ethernet/mellanox/mlx5/core/lib/sd.c   | 17 +++++++++++++++++
>>   .../net/ethernet/mellanox/mlx5/core/lib/sd.h   |  2 ++
>>   3 files changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> index 0b8b44bbcb9e..11f80158e107 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> @@ -6657,8 +6657,11 @@ static int mlx5e_resume(struct auxiliary_device *adev)
>>                return err;
>>
>>        actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
>> -     if (actual_adev)
>> -             return _mlx5e_resume(actual_adev);
>> +     if (actual_adev) {
>> +             err = _mlx5e_resume(actual_adev);
>> +             mlx5_sd_put_adev(actual_adev, adev);
>> +             return err;
>> +     }
>>        return 0;
>>   }
>>
>> @@ -6698,6 +6701,8 @@ static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
>>                err = _mlx5e_suspend(actual_adev, false);
>>
>>        mlx5_sd_cleanup(mdev);
>> +     if (actual_adev)
>> +             mlx5_sd_put_adev(actual_adev, adev);
>>        return err;
>>   }
>>
>> @@ -6795,8 +6800,11 @@ static int mlx5e_probe(struct auxiliary_device *adev,
>>                return err;
>>
>>        actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
>> -     if (actual_adev)
>> -             return _mlx5e_probe(actual_adev);
>> +     if (actual_adev) {
>> +             err = _mlx5e_probe(actual_adev);
>> +             mlx5_sd_put_adev(actual_adev, adev);
> 
> Sashiko says:
> 
> ---
> If _mlx5e_probe(actual_adev) fails, it frees mlx5e_dev but leaves the
> auxiliary device's drvdata pointing to it.

After probe fails, the driver core marks the device as unbound.
Hence, the stale drvdata pointer is unreachable.

> Furthermore, mlx5e_probe()
> returns the error without calling mlx5_sd_cleanup(mdev), leaving devcom
> incorrectly marked as ready.
> If the primary device is later unbound, mlx5e_remove() will see that
> devcom is ready, call _mlx5e_remove(), and blindly dereference the
> dangling mlx5e_dev pointer.
> Is there a missing cleanup step here to clear drvdata or reset the sd
> state on failure?

This is an existing bug that will be address in a new patch in V3

> ---
> 
> Please try to address AI comments (i.e. explaining why not relevant)
> proactively.

Ack.

Thanks

> 
> Thanks,
> 
> Paolo
> 


