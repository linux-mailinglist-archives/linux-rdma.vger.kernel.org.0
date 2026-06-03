Return-Path: <linux-rdma+bounces-21667-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FB/ECDPNH2pAqAAAu9opvQ
	(envelope-from <linux-rdma+bounces-21667-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 08:44:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0AF634BF6
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 08:44:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="G/8tduTp";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21667-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21667-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8118A302FEB5
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 06:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73233806C2;
	Wed,  3 Jun 2026 06:43:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102FF3659EB;
	Wed,  3 Jun 2026 06:43:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469036; cv=fail; b=OGug69Wbty2C5TM7LwM420Lbbd9hACbY7y/thyL/cvGRnSRZGQ9CqPQwGCzSMxq4tUoiZN8BY9SPZnCTC593cBHoQhcNmPr4j4U+tMAsssMELxbBRX0q00AnM38p/qme/mTU5irfFgbsT1z9qnKn8MO/Z5zUItu8b5lFUc7yLh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469036; c=relaxed/simple;
	bh=r4PBytMwdFHDNAxXfC/uIJr6X34SB1ldSEqWo1/PONs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HhPeqZY7kFPi71FkBbeGkBbMx21ox9nszx/K9EcAYJE6ErG7AFJI1NEYzwSHz1af1bs3YzwKZhQksftfokOZ/sa7W8CTiKOId/8iW/hwEwdYBgeivihq8pF7y3e9b9by9Z4jo0OafwVUjdZn11VXkAfXolO4pY4c2wE5LRR9iSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G/8tduTp; arc=fail smtp.client-ip=52.101.46.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vddkC0eJaB9d3iKNwHc5/cW2Z5ESLO3VON7DJ2qMJK/LleWJ840sXzwCgW4JZznP+u3NlW1vtcn3C+eJu796ExPFrwrAYY1892e0300hCbk3jkhtmXGIUxW7OzH6z/b5s2DsxxTwLIh06soK5fYwGi6rdifZqAkLmE/ZjzxadiTJ8PYt60jJVw4BNkwRaAHASWStSbkmW2ppITeggATz9fhvNZh1OXRgukxme3ggi7aSlEZ4NMRECIwsAjHqAZSV5Vpzozz0v9MCAEoTK3u23jntVQObWosOlJoirNFUA9mUq/wNypJ1wPAtyoaCHVPmm5V+CSKu5u0WbNfFArHnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLBxdPTqByVmJidyf3DqxguKjfKl8Rvc3adPmNbiejg=;
 b=U1yYat56YMk1czeEp2Pl5VfmfKOPuUP7F7tt1VaMvMKrrr/ppCAK9/ifOuH5C+TdI+PwZvJepZ7AAFxN0nuaCkQ+brRhWo1QVNiUR43XuVHEn+PyfQEjVWMrQUaG2LIESeKoNRPvsfgX2Lo4HL402/exAynH6aRrcrP81z+KsuijH1GyOMJ/M2lIHs//9IBpn/cHgWCs7S4Kwwg2v1S8I5spBbRbL3YCleN66e8Ccovi2zsY2TP+2NKhZMfOte37TuvmmWaoWCVUXY4/PpfGAj1Upwl8PcJ2yB3nKAPHoyAPAUK71yDMtNEGS4dHwx5EFK+xL/Y1FoFDCgg89+nzGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLBxdPTqByVmJidyf3DqxguKjfKl8Rvc3adPmNbiejg=;
 b=G/8tduTpOmCR01dkW47GaTwoNdvTXZABzlKa5dg6IfMTggANOyIgk3oIFEdHFGI4Vs+Y+r9RZSntgM1vfCECmlrsZNCHBINzqshf+Cf4f3V56ID7AROh1WvqzgkOO3LzgFdJTci6WW7EJ2/D8wwgvpy5i63A8XHvsLDVLpueO49ikCdfwV6Zb89fnm5sINWZL2LQioRYnjOEyrTz/lucYU2cRox41EfdA6kzgUh/4e3XIFVp+ValqOc/UrL2HnvWvmfl+shImyHNOJOX1P9UivXIvqr+z/zvCDjRCiN6yibNzSLOaRZ3HCTzq7iMAKGgc8/oPbdGZmaONUOrYPjKBg==
Received: from SJ0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:a03:33e::22)
 by DS0PR12MB8318.namprd12.prod.outlook.com (2603:10b6:8:f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 06:43:45 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::87) by SJ0PR03CA0047.outlook.office365.com
 (2603:10b6:a03:33e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 06:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 06:43:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 23:43:30 -0700
Received: from [10.221.198.204] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 23:43:23 -0700
Message-ID: <688e1bc4-09c5-451b-a5e3-65d7adf00089@nvidia.com>
Date: Wed, 3 Jun 2026 09:43:19 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 12/13] net/mlx5e: TC, enable steering for SD
 LAG
To: Jakub Kicinski <kuba@kernel.org>, <tariqt@nvidia.com>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<mbloch@nvidia.com>, <noren@nvidia.com>, <ychemla@nvidia.com>,
	<ohartoov@nvidia.com>, <edwards@nvidia.com>, <horms@kernel.org>,
	<msanalla@nvidia.com>, <parav@nvidia.com>, <kees@kernel.org>,
	<phaddad@nvidia.com>, <moshe@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, <gal@nvidia.com>,
	<jacob.e.keller@intel.com>
References: <20260531113954.395443-13-tariqt@nvidia.com>
 <20260603022645.2298955-1-kuba@kernel.org>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260603022645.2298955-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|DS0PR12MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 6caad087-5ee8-4f60-a452-08dec13b7548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|22082099003|18002099003|5023799004|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	RKIo5ooZxePQ1CVq1RLikm4yeTMreuY896Qj7yXp84PLJU/NpfSzTltl5or0KHfZr851nPvai/orqN+V5wIlGwXD5piGjw0d6c4Tcvfz99kbjdNLhgl5PLBBCRyLt+57p+0vpm3kSqqMIGo3Vj/1xTZdySfF3cuGkEUbNdy64iZbGNqxK+1XO4AWzFyo7XU7DtLw/v255N4fjwt3EMCbIJJWhiRNNGni9gAuMyKHy6se7CJikfjIimT3nPM1TpYCec/YNj6u1TU16if0siN62blFr5YnTns0LCoM2cfpnohj5C0kBYQ73v0L8JM9RjC41kbSc/tnsjvdCeEg1f0xKHpfiXmgxgZ7DO77Vk18nID9VW8kT9a1mNCrCQkBqK9oM7aKGGU6vfez6rACCYKhqACklVdbH8/2UPopUi1+Kjtn51rpl6K2GtzHB4YtaTmpBl8HsSjO6vvHvaz6e/aEEwsVmcXpW0N7ZDQ/1I+9mUh0MDgcJDEo+teUr6dvbeAViegYoB1wdwweZuz7NKVQPxGRpxFADJJxF3ipJgic1ucXb0qwONXbfE1JAj1GTQkhI+COW5L27MWgVP7If+XNdvMiYZEUKoGHMYGWJjpcL7EaAnmtspFsHkafjn2mHqw7jbxTTvPig7AoAf4iIKqE2NrXMSybcKia1liYCHSfXBRTQ/uYAAu5+04NU3WLLgL+zsvKWu0U51rxnZ2APn0lMKrKJUdPkj1soY8FZ9A5Jko=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(5023799004)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XaFMSNXAo4jjkOuJMypHRZ+2AYOCNjKIV7CEk9XtJtLpn5Ih3j4WUfcxJb8fJgE5dtkpMRBI2NfJVUqQdPjzpFzjiwQdG8qp1FOWc89/X8zYAJOwx/Eiu9Ec0KJqSaCXJHiBUXX32XnAw784Z0EUObAbQ6GulzWiavWAJolBz65Jg3QV80hz86RMY5XJjtl1LHuQkjo4+QyiEM3VWv3TqEgqJsJHsIgcrxCFnW5bYkmHIhhIgjJvJAWjGLrIwl19c2uAbYb8XuASLzW2SV5/5e4Gqme9PAi+FouLc5Zs3zd2hp9kfCSk90XxMV6zXgzLQssVf5lp2/BNw3v1ecbDLWHZyiw595bHcEc/191cbaF5ce/kitzkYEWhw7xYZmEWIRyxy6jjKIFCSYw4N3Ufb720EIIha+BkcisuHEkvHu49nmhCZ1P/WU0UQ9/5D6KQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 06:43:44.7234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6caad087-5ee8-4f60-a452-08dec13b7548
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8318
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-21667-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:tariqt@nvidia.com,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:noren@nvidia.com,m:ychemla@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:phaddad@nvidia.com,m:moshe@nvidia.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:mid,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A0AF634BF6



On 03/06/2026 5:26, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
> 
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/mlx5e: TC, enable steering for SD LAG
> 
> Extends TC flow steering to support the SD LAG mode by adding
> mlx5_lag_is_sd()/mlx5_sd_is_primary() helpers, redirecting uplink
> priv/proto_dev queries to the primary eswitch in SD setups, and adding
> peer-flow handling for secondary devices.
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>> index 2a16368a948e..910492eb51f2 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> 
> [ ... ]
> 
>> @@ -4196,9 +4197,26 @@ static bool is_lag_dev(struct mlx5e_priv *priv,
>>                 same_hw_reps(priv, peer_netdev));
>>   }
>>
>> +static bool is_sd_eligible(struct mlx5e_priv *priv,
>> +                        struct net_device *peer_netdev)
>> +{
>> +     struct mlx5e_priv *peer_priv;
>> +
>> +     peer_priv = netdev_priv(peer_netdev);
>> +     return same_hw_reps(priv, peer_netdev) &&
>> +             mlx5_lag_is_sd(priv->mdev) &&
>> +             (mlx5_sd_get_primary(priv->mdev) ==
>> +              mlx5_sd_get_primary(peer_priv->mdev));
>> +}
> 
> [Medium]
> With the redefinition of mlx5_sd_get_primary() to return NULL when
> sd->devcom is not ready, can both calls here legitimately return NULL
> during a teardown race and make the equality test succeed?

no, mlx5_lag_is_sd() is the gateway. e.g.: if mlx5_lag_is_sd() returns
true, mlx5_sd_get_primary() returns a valid primary, never NULL. The
two-NULLs-and-equal scenario isn't reachable.

> 
> In that situation is_sd_eligible() would report two unrelated devices
> as belonging to the same SD primary.
> 
> Would something like this be more robust:
> 
>      struct mlx5_core_dev *primary = mlx5_sd_get_primary(priv->mdev);
> 
>      return same_hw_reps(priv, peer_netdev) &&
>             mlx5_lag_is_sd(priv->mdev) &&
>             primary &&
>             primary == mlx5_sd_get_primary(peer_priv->mdev);
> 
>> +
>>   static bool is_multiport_eligible(struct mlx5e_priv *priv, struct net_device *out_dev)
>>   {
>> -     return same_hw_reps(priv, out_dev) && mlx5_lag_is_mpesw(priv->mdev);
>> +     struct mlx5_core_dev *primary = mlx5_sd_get_primary(priv->mdev);
>> +
>> +     if (!primary)
>> +             return false;
>> +
>> +     return same_hw_reps(priv, out_dev) && mlx5_lag_is_mpesw(primary);
>>   }
> 
> [ ... ]
> 
>> @@ -4351,7 +4372,7 @@ static struct rhashtable *get_tc_ht(struct mlx5e_priv *priv,
>>                return &tc->ht;
>>   }
>>
>> -static bool is_peer_flow_needed(struct mlx5e_tc_flow *flow)
>> +static bool is_peer_flow_needed(struct mlx5e_tc_flow *flow, bool *is_sd)
>>   {
>>        struct mlx5_esw_flow_attr *esw_attr = flow->attr->esw_attr;
>>        struct mlx5_flow_attr *attr = flow->attr;
>> @@ -4372,6 +4393,13 @@ static bool is_peer_flow_needed(struct mlx5e_tc_flow *flow)
>>        if (mlx5_lag_is_mpesw(esw_attr->in_mdev))
>>                return true;
>>
>> +     if (mlx5_lag_is_sd(esw_attr->in_mdev) &&
>> +         !mlx5_sd_is_primary(esw_attr->in_mdev)) {
>> +             if (!mlx5_lag_is_mpesw(mlx5_sd_get_primary(esw_attr->in_mdev)))
>> +                     *is_sd = true;
>> +             return true;
>> +     }
>> +
>>        return false;
>>   }
> 
> [High]
> Can mlx5_sd_get_primary(esw_attr->in_mdev) return NULL here?

no, same as above.

> 
> [Medium]
> On the topic of unsynchronized SD-state reads in this branch, the
> writer (mlx5_sd_cleanup) updates sd->primary and devcom->ready under
> the devcom rwsem, but the readers introduced by this patch take none
> of those locks:
> 
>    - mlx5_sd_is_primary() reads sd->primary with no lock and no
>      READ_ONCE.
>    - mlx5_sd_get_primary() pairs READ_ONCE(ready) with a plain read of
>      sd->primary and sd->primary_dev.
>    - mlx5_lag_is_sd() reads pf->group_id under lag_lock, which does
>      not order against the devcom rwsem at all.
> 
> Since sd->primary also selects which arm of the union in struct
> mlx5_sd is valid (secondaries[] vs primary_dev), can a torn or stale
> read of sd->primary make these helpers read the wrong union member?

These helpers are intentionally lockless; it's the caller's
responsibility to call them in a context where the returned state is
guaranteed to remain valid. In this patch, the TC/rep callers only run
while SD is valid.

> 
>> @@ -4628,19 +4657,26 @@ mlx5e_add_fdb_flow(struct mlx5e_priv *priv,
>>                   struct mlx5e_tc_flow **__flow)
>>   {
>>        struct mlx5_devcom_comp_dev *devcom = priv->mdev->priv.eswitch->devcom, *pos;
>> +     struct netlink_ext_ack *extack = f->common.extack;
>>        struct mlx5e_rep_priv *rpriv = priv->ppriv;
>>        struct mlx5_eswitch_rep *in_rep = rpriv->rep;
>>        struct mlx5_core_dev *in_mdev = priv->mdev;
>>        struct mlx5_eswitch *peer_esw;
>>        struct mlx5e_tc_flow *flow;
>> +     bool is_sd = false;
>>        int err;
>>
>> +     if (mlx5_lag_is_sd(in_mdev) && !mlx5_lag_is_active(in_mdev)) {
>> +             NL_SET_ERR_MSG_MOD(extack, "SD shared FDB not yet active");
>> +             return -EOPNOTSUPP;
>> +     }
>> +
>>        flow = __mlx5e_add_fdb_flow(priv, f, flow_flags, filter_dev, in_rep,
>>                                    in_mdev);
>>        if (IS_ERR(flow))
>>                return PTR_ERR(flow);
>>
>> -     if (!is_peer_flow_needed(flow)) {
>> +     if (!is_peer_flow_needed(flow, &is_sd)) {
>>                *__flow = flow;
>>                return 0;
>>        }
>> @@ -4651,6 +4687,15 @@ mlx5e_add_fdb_flow(struct mlx5e_priv *priv,
>>        }
>>
>>        mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
>> +             if (is_sd) {
>> +                     /* SD shared FDB: only the matching SD primary. */
>> +                     if (mlx5_sd_get_primary(in_mdev) !=
>> +                         mlx5_sd_get_primary(peer_esw->dev))
>> +                             continue;
>> +             } else {
>> +                     if (!mlx5_sd_is_primary(peer_esw->dev))
>> +                             continue;
>> +             }
>>                err = mlx5e_tc_add_fdb_peer_flow(f, flow, flow_flags, peer_esw);
>>                if (err)
>>                        goto peer_clean;
> 
> [Medium]
> Same NULL == NULL question applies here. The devcom being iterated is
> priv->mdev->priv.eswitch->devcom, i.e. the eswitch devcom, so peer_esw
> entries are not necessarily SD peers and may belong to different SD
> groups (or to none).

The is_sd branch is only entered when is_peer_flow_needed() returns
is_sd=true, which requires the caller's mdev to be SD. As mentioned
above, mlx5_sd_get_primary() is gated by mlx5_lag_is_sd(), so
mlx5_sd_get_primary(in_mdev) can't be NULL here. Different SD groups
have different primaries, so the is_sd branch explicitly filters to
the matching group.

> 
> If mlx5_sd_get_primary() can transiently return NULL on either side
> during an SD teardown race, both sides may evaluate to NULL and the
> != test will not skip the unrelated peer:
> 
>      if (mlx5_sd_get_primary(in_mdev) !=
>          mlx5_sd_get_primary(peer_esw->dev))
>          continue;
> 
> Would explicitly requiring a non-NULL primary on at least one side, or
> caching mlx5_sd_get_primary(in_mdev) once and rejecting NULL up front,
> be more correct?
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> index ec606851feb8..25286ecd724e 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> @@ -49,13 +49,16 @@ static int mlx5_sd_get_host_buses(struct mlx5_core_dev *dev)
>>        return sd->host_buses;
>>   }
>>
>> -static struct mlx5_core_dev *mlx5_sd_get_primary(struct mlx5_core_dev *dev)
>> +struct mlx5_core_dev *mlx5_sd_get_primary(struct mlx5_core_dev *dev)
>>   {
>>        struct mlx5_sd *sd = mlx5_get_sd(dev);
>>
>>        if (!sd)
>>                return dev;
>>
>> +     if (!mlx5_devcom_comp_is_ready(sd->devcom))
>> +             return NULL;
>> +
>>        return sd->primary ? dev : sd->primary_dev;
>>   }
> 
> [ ... ]


