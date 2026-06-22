Return-Path: <linux-rdma+bounces-22401-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C1MAERvZOGoMjAcAu9opvQ
	(envelope-from <linux-rdma+bounces-22401-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 08:41:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DC96ACFA5
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 08:41:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=NDTXgkZK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22401-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22401-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D26E13023FA0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 06:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB26335E953;
	Mon, 22 Jun 2026 06:41:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8735E93C;
	Mon, 22 Jun 2026 06:41:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782110481; cv=fail; b=rjJns3GaQTk+GBrrhwI2WP6Nj4oevh8JYvBmjSGnT41Gd0TT72nFIr1ce11G0b0ccgvkpZwmruwBBxXRuDDNgfPHWjXZrGgZGyVKi06doXQnY7+xnM1DYHQPoYd0gntkEiYYSXIRj0ZnLAn1Qzww0DysT6++aE1gmMzn5iM+hmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782110481; c=relaxed/simple;
	bh=ekOFwLP9clxETVzZa7YcIJAopmMjRTdVs4ME48YBaQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gnMlwo9lO3QjPcZzk7b0bITRbNs4A0KwtGi3xSZk15jOrNC60S07Rop+vXVsJs77smlGl14Nwq0fq8wITLTV2BnhO+spcZkpGAAMn+becI2sz4GiGVczzwfod1qebuC2rDbnVZosfj3PEIpWm3qvJqVsziAtamNnH9QVk81NKmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NDTXgkZK; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDZNBEb2jzhCUYdL95OyjII4Ja3dom5rReUcMLk8VIp/ai380IdeI38MxhWWm2XxzAk2ZAzKIQ4ALSh6iqLGw8eK8kaCejEk8fBsaUjOjH6jnMxFb4DvYc1lowZRgGDkrjrlI//t08HuTXLP64E7uVQrpF0I7gjdDbneU1kGsUl216BYIrVP1YgnP2hQYfNfd0pc+e1jglfslO+Ls2QZ5+6xh7VRPpw9qpK/LM+uivbMVNYEfVz6eaaLDmr5g7DiTwOnp09k42jX0nMMj6wG1LeXtKF7+OMmXYdI6GlQtdujWYltlhIB4gUah5HCHhMqYEnBXjnLbOdW+fR2qjvjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qyk49lpKf4aT8J2/GViA71axDLE7tSJZiT/hYKwJLFE=;
 b=AdCK1PMTd+cjSdjCYYL1rOx1zE2Mc6NGtbRa2z4RMcfstYP+tk6WvDVdZ0gdFZk+Al7W4ZYPPIvCcke+PGYKjGWdAoCNyUe7cn4ZtkloEJOF77zq6zO38Gz68aCSA3cUNnwNomk2v06wOoAwwnlycS+4epE3EVpzGLThacjWN9LdUYh+lJ4nEGO+eWSK/YKFeLGfN3yi1ts7GJTU3RX9n8SXMhUDPtFlMGkAg/2ga7xHw4Kio7qk3zDhT3XyPSK9ZvNk44uA93ulPcH6CzZXQiPUxcEVyETNkS04B9Sj3tqhNL4jA/g+hbAMdtZu6B0z1cwVR1NlxbkAeROy65ErpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qyk49lpKf4aT8J2/GViA71axDLE7tSJZiT/hYKwJLFE=;
 b=NDTXgkZKmFktAwC1ZYp4F9vgepygPMf1Uv8hcQkMujMHuJcm2MLyiQ4fn//+x9ES9GWgrxzH8y6u5lq5eZbMXZqxFmksiiwKKJvKAv9uXvtswzQNTqYReBQFp5r2K6ZtUEogwrlkXOl5EulZPdlSTeg9kcDbpzCiKYUf/W7emizfAtEJYPJZRXM8ZGTJJ3POryY5TKEPCBy9rG7A5cC/aHli5C0ldAyx8fd1UB+NfyrUByuAxRtqT20tgozQTdo5+TmbLso/rf4NT7GuDvFaF/w4+/Rh//X1u4HQRwFnc1qk2IPJoQhPfuxmAxPf3C0Qhf44snMdZOCkNsGjW7hjag==
Received: from BL1PR13CA0379.namprd13.prod.outlook.com (2603:10b6:208:2c0::24)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 06:41:13 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:2c0:cafe::5a) by BL1PR13CA0379.outlook.office365.com
 (2603:10b6:208:2c0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.9 via Frontend Transport; Mon, 22
 Jun 2026 06:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 06:41:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 21 Jun
 2026 23:40:55 -0700
Received: from [10.221.198.2] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 21 Jun
 2026 23:40:46 -0700
Message-ID: <e18662ac-413e-43f6-ac65-a4e15fd47bb7@nvidia.com>
Date: Mon, 22 Jun 2026 09:40:44 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net/mlx5e: TC, skip peer flow cleanup when LAG
 seq is unavailable
To: Simon Horman <horms@kernel.org>, <tariqt@nvidia.com>
CC: <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <saeedm@nvidia.com>,
	<mbloch@nvidia.com>, <leon@kernel.org>, <ohartoov@nvidia.com>,
	<edwards@nvidia.com>, <msanalla@nvidia.com>, <phaddad@nvidia.com>,
	<parav@nvidia.com>, <gbayer@linux.ibm.com>, <kees@kernel.org>,
	<moshe@nvidia.com>, <rongweil@nvidia.com>, <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gal@nvidia.com>
References: <20260617063204.547427-4-tariqt@nvidia.com>
 <20260618124820.890808-3-horms@kernel.org>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260618124820.890808-3-horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b0a8ea-651e-4fe4-6a61-08ded02940a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|7416014|23010399003|6133799003|3023799007|18002099003|22082099003|5023799004|11063799006|4143699003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	zDY/unD2fZFXZel7fni2yInlgRcfZwZn9Z07LPF69YtJ3Si99W57sR0uWoPxW6dsKXbKyQ4usDbb0WGnzXw+HSYsYDHO35D3WFMu96uVNRW2ktYRRnzxFJW/OxZZwm7BhPnu0wySEBUPJVimni08stoVeo+gUV9Qf0SbUovbrX2xcmyKA/CbyRIUpbyDtFB1em7O8ASfsiTwRAyHletgOlezACJsEzB/tve1yPfYGquHNNUfIGXDvNZ2a3Ed7qChQ7Oi8IlMo7ABLcrbUzKePPYdxEzIlw9oXroEiigJSQI/WKX9qCR9sNAZd7lmEqf8QJNQfjRQDQqzoCgS7inoOmLrf5Wss0DAn893a0RnFL8AQsVXrvmT5/B+TKleCWn5GJRiT5sMVElPcFHxgUJ8cTg3xeCQwhd3P4ZtpewU1l+4PQdvhhsSaUfwhdT8Jaqj5AxFt4Xz0cFZtw+WEGhZc3uR3YybRMqx7hYN9tZoQz41FYH6ITp48TY1czN+DId0dYgxvVe9JSOXunu2VFGk78ZrI/cPrIvoy7sg5gbp2T4fOtuksDvH2c0kdxGFo4hrwJGByuStTdIjkJpCzmWTrsyEcE7a1HQJcqeDdRpyFo8uiqHwtklKeYM1jcp22O/wGYleNymAZafH1QQ/SjUxuZfQKsq0xQ111yzb3dz6AEHKv3Lk07cwrBWM9JbOn6LkSKM9EOVinBLrvoi1Z5t3iA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(7416014)(23010399003)(6133799003)(3023799007)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WgarMlrbL4TRqnr11sfb4xuYuLWdXuNnevMxvmcL/IRnNPkD+Eogw1acb5Ajcji+pL7wZ4s6PLnWPlxONZLdIlP1orwG77FCxlLH1mxOG5njwOO7IFSPMn5XWvkd5klgocLD9wru6zvkvsx12toPRA6fsjG+sVn/NitjinUqW74kgQ30/twdWxlPRFHimqR/tX8usQ5Rnxu19yRjepjl05iq8GMFULMMD5FMvuk7dVq8zVT3Zc+Ek7rm8do63WekB/CM6uTQBa0geAtCM7RNnUX5VOHziAjYaXRxmQHi7s681gqpc9OsxUONZqN0P77D+uRkaCGzi8ucmYJJm1OrgGLGPR38avqPUG4yvvY5ApS48lW9VGX8ngBYD9r4xMlakQgwvojKqZar/EZ75zwCh11uAfySh3p6nfHjBggbJYR2GmJGPo+61lBiiHzMOGsX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:41:12.8348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b0a8ea-651e-4fe4-6a61-08ded02940a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22401-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:phaddad@nvidia.com,m:parav@nvidia.com,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:rongweil@nvidia.com,m:jacob.e.keller@intel.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97DC96ACFA5



On 18/06/2026 15:48, Simon Horman wrote:
> External email: Use caution opening links or attachments
> 
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> 
> Simon says: I think the first two issues flagged below warrant
>              consideration within the context of this patch.
> 
>              But the third and final issue flagged below as pre-existing
>              seems to be something to consider in the context of
>              possible follow-up.
> ---
> net/mlx5e: TC, skip peer flow cleanup when LAG seq is unavailable
> 
> This commit addresses a bad memory access crash by skipping peer flows when
> mlx5_lag_get_dev_seq() returns an error. This occurs when the peer isn't in
> the LAG or when no device is marked as master.
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>> index a9001d1c902ff..c6e6534a5e23b 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>> @@ -2155,6 +2155,9 @@ static void mlx5e_tc_del_fdb_peers_flow(struct mlx5e_tc_flow *flow)
>>        devcom = flow->priv->mdev->priv.eswitch->devcom;
>>        mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
>>                i = mlx5_lag_get_dev_seq(peer_esw->dev);
>> +             if (i < 0)
>> +                     continue;
>> +
> 
> [Severity: Critical]
> Does skipping the remainder of this loop prevent the flow from being
> unlinked from the doubly-linked list?
> 
> By using continue here in mlx5e_tc_del_fdb_peers_flow(), we skip calling
> mlx5e_tc_del_fdb_peer_flow(), which means flow->peer[i] is never
> unlinked from the esw->offloads.peer_flows[original_i] list.

only in case a LAG member is removed from ldev, mlx5_lag_get_dev_seq()
will return error.
before LAG member is removed, esw->devcom is cleanup, which invoke
mlx5e_tc_clean_fdb_peer_flows(), which remove all peer flows.
Hence, no flow remains.

> 
> If the flow is subsequently freed via mlx5e_flow_put(), will this leave a
> freed list node resident in the active list and guarantee a use-after-free
> list corruption during the next list traversal?
> 
>>                mlx5e_tc_del_fdb_peer_flow(flow, i);
>>        }
>>   }
> 
> [ ... ]
> 
>> @@ -5526,6 +5529,9 @@ void mlx5e_tc_clean_fdb_peer_flows(struct mlx5_eswitch *esw)
>>
>>        mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
>>                i = mlx5_lag_get_dev_seq(peer_esw->dev);
>> +             if (i < 0)
>> +                     continue;
>> +
> 
> [Severity: Critical]
> Similarly to the above, does this skip unlinking during flow cleanup when
> the LAG sequence is unavailable?

By the time get_dev_seq() can fail, the member is already out of ldev
- and clean_fdb_peer_flows() (devcom unpair) ran before that, while seq
was still valid, so the flows are already unlinked.
The guard just covers that later window; nothing remains to leak.


> 
>>                list_for_each_entry_safe(flow, tmp, &esw->offloads.peer_flows[i], peer[i])
>>                        mlx5e_tc_del_fdb_peers_flow(flow);
>>        }
> 
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but is there a similar missing
> bounds check during flow addition in mlx5e_tc_add_fdb_peer_flow() in this
> same file?
> 
> If a flow is added concurrently with LAG teardown, mlx5_lag_get_dev_seq()
> can return -ENOENT (-2):
> 
> drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:mlx5e_tc_add_fdb_peer_flow() {
>      ...
>      int i = mlx5_lag_get_dev_seq(peer_esw->dev);
>      ...
>      list_add_tail(&flow->peer[i], &esw->offloads.peer_flows[i]);
>      ...
> }
> 
> Does this result in an out-of-bounds write to a negative array index?


No, if LAG is destroyed, than is_peer_flow_needed will return false and
we won't enter here.
the whole peer loop runs under the devcom read lock
(mlx5_devcom_for_each_peer_begin), while devcom unpair - which is what
precedes LAG member removal and runs clean_fdb_peer_flows - takes the
write lock. The read lock therefore blocks teardown for the duration, so
mlx5_lag_get_dev_seq() can't go negative here.

