Return-Path: <linux-rdma+bounces-21028-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNnXOGh5DWqfxwUAu9opvQ
	(envelope-from <linux-rdma+bounces-21028-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 11:05:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EA458A603
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 11:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E58A3107C32
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EA939C657;
	Wed, 20 May 2026 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mvuvilwd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013005.outbound.protection.outlook.com [40.107.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556CD1E2834;
	Wed, 20 May 2026 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779267379; cv=fail; b=JkKOEJKxztFpEns6v2ejHLy0h09UfKSJl9Wnd9tNx0Io2sD4/6fwrXA4iry3e+A8OztaZ9LsLL29BImB0caA3fXKXVFP/RizbXc3juMDjB0FOyoy35KyozZZbGGT+bmChx7wnU9Xyp9f70P1HPMXqwlNjuAppZhsbjQVsRzl81g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779267379; c=relaxed/simple;
	bh=GK0VVcwSQisawyPe1HxZOL8JczdaTaykWeoCrrDefCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kwSoECODs62YdFdbmqLdRgW2ZgZxYBg+TYbvVcDPCBUZ+XKS6yH6MSbT8ZHWGFlJHEwWv7JKxkHpEJa4eEMGDtuKPQ4vPVf0mG+em5nBXfzZX82UeHnVwxgWohe4E/Fp1UZFxkwK/fJ9D/cxoz3nRg9u9L9TO5b9IMsBd8sQunc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mvuvilwd; arc=fail smtp.client-ip=40.107.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQ0gAfZGYvy4AVlvXUnEd5Damf3YXSkVdbq/eQRgPG4fZPjNP+bRO0aQeS0G5RJ7iZ+dVWwo8N3rkchx85UfY7zF6HB4yZVLYY0jtH5/z0a6xq5ln3AykB3adyrbJjk+unJgtyAu2ZrcV/LavvtkNHFoTsFGPpzqmUIdgKw7lIhb3bwRyZ3VuMmr2HYTRpVK+YthBB6cgV1TyBotoWvi4mv7MZ0b2PL7Q/jwEF29Hr+oGalfo7AnArbspR/FDohvtp+FNr5trb8EniWKhd1DjrwkWpUAPxAAxprB3dyzOLwxjM7lcpJ+v1NazYauWypbEE/NxGIROCdJdwYkwBoc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqfKfg020ZrDZ4B9kGqskpJvrz6KzU+ls9TNW6a/u4c=;
 b=YJvu/U/zcx5ZPcEZ5jqseVlIyAc+I2d6QpinNkU/9u6EEjNgisnxY1ijjIO9iew0JtlStS1ONu/XxgTrBYhev6wu7Att6ZZ7msyxnEeMd5UoihsIOq+NbvcM6CoA6cw/YEv+lFcy16jomrWyGAGo/ECeEsVv50VnX55omEG5Je+sTNFd3AVHXFVc54CDpF01MLy0KmzH1Qfvq4rXUIiEgzwp4u9/koDULlYqfcsGlHZ7okzmdY99wdpgsX4b8Dwny+i79x9MMx8TLQXcAQ6wr2vhmq2kx2DfDjyLVx/L5P2cRoTFGFYL6XK14kaFkr8WBL85NfWZp2Q3UFOTX1jUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqfKfg020ZrDZ4B9kGqskpJvrz6KzU+ls9TNW6a/u4c=;
 b=MvuvilwdFftBz7etu7BXV1dsMwz2OSM8D+QzEPXg52hwYe4G/DksW6WrbGsWXBRl7pFR3IdCrB+iFWXA8D7DYF0DBCsPtaXuDBmCYrOaYWRywGkHTOwfn3Lu9S/eZbEbz0+oBhCjee1PagpTyW/iGKx4R13vNfrVChZb19mXf5Lc3iXFn9kp+96oRQDETTY15D9xjcXJnrS9vV7nBfe3e9VBw5bgB7Mn55atF6DWDYSHWjBHiLg+nKf2aDqOqjiniXpC2znxRyPBYptBfQnWYguCqm/3tHeQDxelvU+HxxI1B3ky3KWWv88j6G2zszJASJ6oUO0swELQHwUZ4FlSfg==
Received: from MN2PR15CA0052.namprd15.prod.outlook.com (2603:10b6:208:237::21)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 08:56:13 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::78) by MN2PR15CA0052.outlook.office365.com
 (2603:10b6:208:237::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 08:56:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 08:56:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 01:55:52 -0700
Received: from [172.29.229.84] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 01:55:45 -0700
Message-ID: <f2e7580f-6577-41d7-96cf-8081013a5505@nvidia.com>
Date: Wed, 20 May 2026 16:55:39 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Skip IPsec flow modify when MAC address is
 unchanged
To: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<tariqt@nvidia.com>
CC: <edumazet@google.com>, <kuba@kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <borisp@nvidia.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <mbloch@nvidia.com>, <cjubran@nvidia.com>,
	<acassen@corp.free.fr>, <kees@kernel.org>, <Jason@zx2c4.com>,
	<michal.swiatkowski@linux.intel.com>, <fmancera@suse.de>,
	<antonio@openvpn.net>, <cratiu@nvidia.com>, <ecree.xilinx@gmail.com>,
	<sridhar.samudrala@intel.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gal@nvidia.com>, <leonro@nvidia.com>
References: <20260513190226.335562-1-tariqt@nvidia.com>
 <20260518112710.510979-2-horms@kernel.org>
 <c7e0dd4f-e34b-42a6-ae4d-8060a59e9b8f@redhat.com>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <c7e0dd4f-e34b-42a6-ae4d-8060a59e9b8f@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 987a9017-7748-4159-3ac9-08deb64da535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|4143699003|22082099003|56012099003|18002099003|11063799006|13003099007|5023799004|41080700001;
X-Microsoft-Antispam-Message-Info:
	EuxKSiK6fgre1EBcElTuQc+uVPA7nWayZuijnl3yBCHww3qlT//Ui1hkPUml+TGgRWjA+BAEhaICIRB9mfcQGogy2dcuLdhI6+55lr1n+pg7RAY2BNleQuqfxGnfaNaVaV7Ag4aLJT0tl4p/x/r5y4vXcsflkqkscG8u14lwBBEU90wxOXOLxL/wNTvH8ZdmiWU6cY8s0ENDah+Nf5LlK1Qzr5VJdwDn+b5qYL2/XdvOrZFaJ/UdKzQZ7iQMAU97NUuaB+hD851WWpUvFxIIy+9LbZlEV6kocIKo3UVTyRpjcHxfqYk6RbB0/4UJUCjCoTMZLy1SpEVftZ7eTqV/T36u6mXTVuONqNHLRnXPI4bs5AQeK4lg0TusxrvBnnT+1QubTq7S6QL/v697cyTsQBL+FunhYpzRkjP6DmKNb65y5qqAHtvBrfQtossxGONQU1RK28gtY4HKMBhihIVR5i1TxqOBi08mhU2Av8f/NC8I0xdRDJdzFtsthaV3ng9/Mseg+yY6086nWDKeKHgYK4q1VTJKe49ql/a/KUR/QG1T+6UR2zBW/Lait9BqYRPT2+MihKVhzixfLwAYHjXpYXbo5uJ1vRU4VYYJ2Dre1l9Xsm9EfouuFCsLipGRfip2S40IXjnaHgvRg6wn5asxsLk50bYfVWbXzAvg0L7dbQY1FOKbKr5IxkhDn8GBZZl5BZs7REa+JKUqlIZBinIdAZ68FjzNNwSx5g4uMcS4wrJcfIpN3TG664zILfJVwA7O1WVUb+NgrIu43zVt+VBErMVbwDh7J7Aa2js3LeIwKpc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(4143699003)(22082099003)(56012099003)(18002099003)(11063799006)(13003099007)(5023799004)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	reArTpQ7vxZmeHstNIVtD/8h5iG42LiaMqdHQ6mnrO1f5gCGlQ3fjdpCrFM5ev07nC9fZ3T782tanbrCtWSYE5AzZbTr/jl2OpUP7et9qFKrxLjr7antIFA80zKurU8IOIZb/MYVneaPVAeFLYzInAcc/JD9e1Sg6ZPJyNssZ86iSVWUzi6JfF/PFu/NXA/pZZvV5XLbbU7HO8c/h0QTvZYgyH0G8EYtFZRBKckri7MmUe3gVal7PFLxR0uahlhc5as5/fHp7iu9VszyVtKhAum2xb3eqtijo0GGDua4uNM2w3O1jjIspEyPbfqiZH5apCbevNl44L2RZDcA8JKIQGRed4fKbRqxMKBG0x+5JyJhZ7axQcOm94MB+gQwJIk7fhnTRAOqxc97FOa07Cyr7BKjRzg48MY3AywmSVjoC7I9xiqht4+IkiHigNjKn9Dm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:56:13.1797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 987a9017-7748-4159-3ac9-08deb64da535
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21028-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,lunn.ch,davemloft.net,nvidia.com,corp.free.fr,zx2c4.com,linux.intel.com,suse.de,openvpn.net,gmail.com,intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sashiko.dev:url,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianbol@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 60EA458A603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/19/2026 4:09 PM, Paolo Abeni wrote:
> On 5/18/26 1:27 PM, Simon Horman wrote:
>> From: 'Simon Horman' <horms@kernel.org>
>>
>> This is an AI-generated review of your patch. The human sending this
>> email has considered the AI review valid, or at least plausible.
>> Full review at: https://sashiko.dev
>> ---
>> net/mlx5e: Skip IPsec flow modify when MAC address is unchanged
>>
>> When a netdev event fires for an IPsec SA, skip calling
>> mlx5e_accel_ipsec_fs_modify() if the MAC address has not changed and
>> the rule is not in drop mode. This avoids redundant hardware updates.
>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
>>> index a52e12c3c95a2..f567cd801adb3 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
>>> @@ -674,19 +674,26 @@ static void mlx5e_ipsec_handle_netdev_event(struct work_struct *_work)
>>>   	struct mlx5e_ipsec_sa_entry *sa_entry = work->sa_entry;
>>>   	struct mlx5e_ipsec_netevent_data *data = work->data;
>>>   	struct mlx5_accel_esp_xfrm_attrs *attrs;
>> [ ... ]
>>> +
>>> +	if (ether_addr_equal(mac, data->addr) && !attrs->drop)
>>> +		return;
>>> +
>>> +	ether_addr_copy(mac, data->addr);
>>>   	attrs->drop = false;
>>>   	mlx5e_accel_ipsec_fs_modify(sa_entry);
>>
>> If mlx5e_accel_ipsec_fs_modify() fails (for example, due to a memory
>> allocation failure), does this early return prevent the hardware state
>> from recovering?
>>
>> Since attrs->drop and the mac address are updated before calling
>> mlx5e_accel_ipsec_fs_modify(), a failure in the hardware update leaves the
>> software state out of sync with the hardware.
>>
>> Prior to this patch, a subsequent netdev event for the same neighbor would
>> unconditionally retry the hardware update. With this patch, the early return
>> sees the optimistically updated software state, matches it, and skips the
>> retry, potentially leaving the hardware permanently stuck in a dropped or
>> failed state.
> 
> @Tariq, @Jianbo: I tend to think that the above qualifies as
> pre-existing issue: when mlx5e_accel_ipsec_fs_modify() failed the S/W
> and the H/W ended-up in out-of-sync state for a potentially unlimited
> time even before this patch. WDYT?

I agree. Please drop this patch for now. I will submit a new one.

Thanks,
Jianbo


