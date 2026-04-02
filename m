Return-Path: <linux-rdma+bounces-18952-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB/rM5/LzmntqAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18952-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 22:03:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A65838DDA2
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 22:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17EF23043AD9
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 20:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793CF36DA16;
	Thu,  2 Apr 2026 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c8yA5K4H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E033985;
	Thu,  2 Apr 2026 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775160217; cv=fail; b=lZRkbg/Q71nVuqtKoSd1f/MAC7JUisUvZYQyd0BKX452T/0RIPZURyZnXiHvRl+6jcgh9hgBjXDKBkn5N9tqrp4f5K+kcakWw91CRBrR4iEHBXXsrujahkksSeDmboHTsCRmbQeNIPGGLzXfP6XscasiNnWEGH4fhMtQI4yAaqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775160217; c=relaxed/simple;
	bh=XkXfN8bvl2ApiI/vg0MXnNaZv2563Liy8X62a70AYa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cafuj5JtCp+Vr3FWMTWt/3dwyYpBQS2gL7nqfUolpxT6Ey1wWtPnShSbGDUmxKy/YLzxnkasphB62SII2eifiwdB0yyCec28mXP+i9DMGfXtVQFy/1WBZJOcEQuPn+COLmRxb/Yq5oJdDBbFNwDar+8hFmXuGj/zl5qodsLlU6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c8yA5K4H; arc=fail smtp.client-ip=40.93.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nj5P376uTv1hBtOdB140NDpNmqx5NTD0cFMvdRutA7qPvgK2MBUs2S3PkdIWAuZxyNZv7z5F0Es473Qpna3+w4UH4DN9vP1UPU+mFLAjiWHDCLCaSXKkvgK6Q1tMmpBShCtTIx1SrCi4AhvGUp3goT2D75AWQVaiHNmrqWm0OFMvRyfcBlVdyj9U4Owdmgh9AMDs6ASMHRBU6ubX5lONtWk69jeDsRiw9Esu6EICgh2GHo4YbBLWsRmNDx4SHkw/2z0WQOt9lJivj3K1Ms/u2z1bT46jyDY1DDg0gzF6ZkjuzdnXOYSQgJJt5D7PE34xazFVxyiLHB0oApo3FL3SnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqBW3ChXwO/+lj6QpXroAfXpj66XL3dv+IecMYrZtyw=;
 b=Bf+upUBOoViUanhKOHUKRdR0CM/Qn7X+CZRPzPH4Yd90L8y6JPQIJKsv9p/zvdnWunAzFBgwC8efpwQ3iqq7jiXoAhKXN08/zVLT2POr9Shn+sBMYI50h+VChLG2aoYpQS4NBvLJnAC1qR7PKQJ8AFQTkoiApF9CyneCymCHSWxMBm4Vqqfe/pn4gcKh+CuC+/UQi005xgTZ4WF90M0wKeq4mA6J0iyxtEUvrxBo/ULB6hIYBmtuRbfOn1KvtCUQB0AIWZMxDbQgeaCjGnDAqq5EdgkJjDr2KXFrhnhe66iZnymBuFHw4sP1z++/wdhrVNu5U5F1mfdGHpqMC3OuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqBW3ChXwO/+lj6QpXroAfXpj66XL3dv+IecMYrZtyw=;
 b=c8yA5K4Hl1w7Us59NEFXXDXKhYM4xFbjTJJd/3gLbSeUCtjy8Kp8fdciZ5Kp1IE2N4gRXADwrxWvRlCeJsmqitgyyKHXmm5p7QYNq22wIGo8u5WQ8NCLQetfDXPkTnZbwqg/Oe1J3vUWK8phVMpfNCyzkThNoIinKrXTW9i/maPHEtqv/xINDv3kZzI+tNOHLCdCMwpTyJyiupTvGfIbHaDj8SHBzilPhze0YuliL0B/jqKEceX4XsD68pr+y+O2H6t+M1GMLY1F1ctBerJLL1+ubzGF9R/rPsOGC7AjJYiRyePXYXbjTiaKUQbQI/d+M+lVS+SWg8ODnG88pOGswg==
Received: from CH2PR05CA0064.namprd05.prod.outlook.com (2603:10b6:610:38::41)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 2 Apr
 2026 20:03:32 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::10) by CH2PR05CA0064.outlook.office365.com
 (2603:10b6:610:38::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Thu,
 2 Apr 2026 20:03:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 20:03:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 13:03:19 -0700
Received: from [10.221.201.51] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 13:03:13 -0700
Message-ID: <53c3bf8c-0b0e-4986-91f3-3eec53fc2b1a@nvidia.com>
Date: Thu, 2 Apr 2026 23:03:10 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net/mlx5e: SD, Fix race condition in secondary
 device probe/remove
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Simon Horman <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260330193412.53408-1-tariqt@nvidia.com>
 <20260330193412.53408-2-tariqt@nvidia.com>
 <20260401200842.79322a24@kernel.org>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260401200842.79322a24@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e3d7f0-f7b8-4c7f-dcea-08de90f2eaa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jtksWSfQTXCaWZQLF1aeuHWzWZXH0yBtYL6G6sF6emVSLlko3jNlsvWdaoddgzhj9TvBIWS93CcH2O/yZmTxlhUtMavT6NDOzIRc9ahqS4kk7V7MDkiOUZnQorBUdaPyWWmPcDWkxSevv3/NJ8UoxWoDRqznwsP7VYHxwtQlRZ/NNjyb1shqdzLi1yg8Mc0uxQfN3chYgpGGtKpbdyqjsm0ObSvjMWtTGuraA44q4443ZVnmeNMVX7ntfkT6yel9gaxGo1eaOHLwun0iG0Y8yUukO7qchnQnuTUFAkJSKImzriSI8yIPaq/8qAbnPEVwHhBWKFPHief5Dd+0fyVVEKbRbopAp/VgYMjj6npyWw/tt6hbB6EJdvyGVOLfAD5kjVnTnxinJ6HQ6kZkuFTSZmdz+qHGZyU5RXkhbegQTnDcxfsd9bqf7IXmpSSHamtAdt6mYsvVFSp9Uxsb1B8lO900wSgK8pStP3qPGbw4bM9HSFqnGFYoSfBBu/YCQnNYgPUnLMuBgp0n6hD8ajpF+Qq+mu01PK9m43dvdGTFC+GRWDRazej8NAMWTseSnyEZF1MSaJ0Cw9faDxFAxGqQGVeY61eA1/+wdF4J76UDRH+/55sCFRA3gWT/klcwecpXvfbzDbXqrsuktrJcEJOMqS5XNLDyXfN9r80/BtDt0+gADntC/LtOXCVagWMo5T1atu8bGoNBE+eBeZO76NAIDx3mb5dTiW69/eVNsNaaRAppKbeU82OcZIOEFevx4LXtTK9tWaldXZXTgEu7owHNpA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GrM8BnvCPhryOx9WRdv0T6nm/FHWPMA6NgkGhnfr3XBFIH82pU5xibiVHQNnsA3of8if+fabaXkVXjDzg4m5mmt6Axrpf9nolOXtXFxGrXEEi4epHa1lLfQOiOdnMuF0qBWN3ECbjlzTSTe3g8xcwKQxH3QW5Ib4sxG62A1bivDcKVLwaRxoe2247BhVs/n5lNWU3/p+ffJmF9zCTsZta/TWqvQJwLZcCxyVEU1JTCdWs0ttLyYsgt8H3tv9l2XEVaqKb6u3fEV+gW+R5gA6Fb7btrbCFVSmwpetBQdEfeDsqytapPNAwxOtIA7/h1n+McM674IVS0bi067flTuoZIKsY5Vo1fxKJwZ3pLaJVoQW1by1vdKUOTXoCl5M2t3yWLCID6HW1aqtg6Trx32Ww1obA9NMg/nTkyqYLUASUQ5Nuv1Xvsm6oQrk1ZTh018c
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 20:03:32.4385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e3d7f0-f7b8-4c7f-dcea-08de90f2eaa0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-18952-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3A65838DDA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 02/04/2026 6:08, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, 30 Mar 2026 22:34:10 +0300 Tariq Toukan wrote:
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
> 
> Please explain why the "primary" designation is reliable, and therefore
> we can be sure there will be no ABBA deadlock here

The "primary" designation is determined once in sd_register(). It's set
before devcom is marked ready, and it never changes after that.
In Addition, The primary path never locks a secondary: When the primary
device invoke mlx5_sd_get_adev(), it sees dev == primary and returns.
no additional lock is taken.
Therefore lock ordering is always: secondary_lock → primary_lock. The
reverse never happens, so ABBA deadlock is impossible.

Does the above is the explanation you looked for?
If not, can you elaborate?
If yes, to add it to the commit message in V2?

> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> index b6c12460b54a..5761f655f488 100644
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
> 
> Feels like I recently complained about similar code y'all were trying
> to add. Magically and conditionally locking something in a get helper
> makes for extremely confusing code.

Do you think explicit locking API is preferred here?
something like:
new_locking_api()

mlx5_sd_get_adev()

new_unlocking_api()

thanks for the review

> --
> pw-bot: cr


