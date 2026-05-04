Return-Path: <linux-rdma+bounces-19908-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL5gLYKE+Gn0wAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19908-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 13:35:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 773604BC6F3
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 13:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33EDE30221F6
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 11:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AF23C13FD;
	Mon,  4 May 2026 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UJ8HoK1l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D640B3BE65F;
	Mon,  4 May 2026 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894470; cv=fail; b=RpWEcp19z218DwU9JRwgCr10nvt6hAFbEmPK4hNqni1ZYtPDfy6fHIB0T20XO0z2h90xARo5f6b/oVi5arYExmsVBqt9hKEeDIUXwD19kDyRcajhjjuR+WUpqEc9k1U2TIy1UNN2aoQ6359U6JpGYYRzN2/lTRfFpTBFuXHFODg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894470; c=relaxed/simple;
	bh=LhzJcXK1lQ3quKnRD5JFBLyBqAEdwfu/B8+ux1SlViU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=heOso5RJYM2TvWBqeuldvwHskMV9IHODjXqdSTuahpRj3ygXD17yAmPUShgjyn9y7HmJW1E05eF6s4uNzBj6Jmd9KWrM+kgiQjtia8+ipi+AhQnH/ZFlMPUuIzWfQ4CtlG0C9eDoKzF/wy/p4oNWBOYgHaDO4UQGxjb79Qma9Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UJ8HoK1l; arc=fail smtp.client-ip=52.101.53.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JG9kBCIl86W/sHwfHEtWhyhp30Z2HNpvJtiTR75QD6vLI0kFdfJ1JK1S/8Lch1XWRC1Vt/wmWt384PetihcQ1SJm6uml/97GJzd6n/azKv4PEYhYsHmp3sotngp0ZuaU71++k+T4zW+TeRGYMjJ4Jhddv+xV2E3GZRi7/fiHowuPTcBLi/VMcYAfKo0YZ1jZn5AtnbJTXTrzBYk0/dosig3u09hld6L36GAcPVv9xWtIaUr18qeldFqJAxFIWTfpsgzW6WrqfrWXbsx+XVh6gUmca97LYvgPcJQSFfriJV0a1/t3STRCAiKtMh2XatExMqDVf32ouejw1oj2X7uGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZUgtoRaI6Quom+Sr07Mg9kj2MslGNfavtxZVZ7S2S0=;
 b=H1UXJBeKxsXhj+jgSuTLCjoMRe7TnxYDFpMIBOqiqZsI4+W+LrmiGGygNKn4T6ZAy65DuvDl4+povIXwpLH+1Ix3L3HhYP3JmQ2mPR4XO9tYsXZVX3lxrU7OzocvyFeeGte34PYs46oJW8D/7/g340odbbet1Y0Rdna3F+KE7wy2CztHoJPMtrlsVZWPWL2hIkxXoQg5Ywt4EhgFsfZuhYl0DevrgeuL4g6cYxlb9cQpipPO/dAAnkja4CR+P5YdS1WUn7dwj2IeNySjpu3pZBKDJAQYyMv+4/q1j+D9WaNZr5V4xLjHWJE6ogmqTy/AXrv3qe/T2+isMZvBsb8nJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZUgtoRaI6Quom+Sr07Mg9kj2MslGNfavtxZVZ7S2S0=;
 b=UJ8HoK1lvq3qD54pON5g6GpYLT+4vol/X1Pxk4kC1u8HsFUz4fVuFMrSIw3uawmkiIz1uWZ4sYiXrfIcpkPvaPmVknhihMfZd5Ln4HyciIiEzNtWls/L7YiZn3N6irgpXGz89cyoIwfZ3bhg4ifeZAe+W+A/3zK4FnXNWh39HZ7WZonhgGrm8dt8ZYzhXpCY/r5/HH0ov0+YJ4N0Y7428Nu2pu3MHRTOww/gMyIt2yv3Ha6ebXR1GrSujizIUq43YNke5cTFSR+JyBn9nkig/XhjWrWqhS+1KAZywsY7CB1q2GkvhOfcjcEbJcxC3yPnt/11SSBC0A99DLZ2WhGlrg==
Received: from SJ0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:33a::25)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 11:34:17 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::59) by SJ0PR03CA0020.outlook.office365.com
 (2603:10b6:a03:33a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 11:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 11:34:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 04:34:06 -0700
Received: from [10.125.201.174] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 04:34:01 -0700
Message-ID: <2b06dc5a-542e-440e-af7e-73c29204cda5@nvidia.com>
Date: Mon, 4 May 2026 14:33:57 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net/mlx5: Add VHCA_ID page management mode
 support
To: Jakub Kicinski <kuba@kernel.org>, <tariqt@nvidia.com>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<mbloch@nvidia.com>, <agoldberger@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gal@nvidia.com>, <dtatulea@nvidia.com>
References: <20260501044156.260875-4-tariqt@nvidia.com>
 <20260503014501.4098393-1-kuba@kernel.org>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20260503014501.4098393-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|SJ1PR12MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe90fa5-b566-4034-e696-08dea9d1137c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|18092099006|56012099003;
X-Microsoft-Antispam-Message-Info:
	i7yWtd9j8GTDD5dREYoefwd6YTirpb6y+pxCzyDNWVEv/JmlnL1tju7yPNa3SQjz6Agy3LBRcXjWDQM4sxFHinSdcVtbxFGaz3Ozf7cf3qOJq2Dv1t9SO37XMuPYi18pXsPa9pbezhF+S1VqchE+83e/sKqMjNSz2MZK3pPIK2Rt1hWHQ196Zlj8cnQyZj4nMj7zCOfxwqc/jkOazFo2E3zBizEv0BDLrfn+KBBAeiC9dRGZ3cHbxlIj6ldUygBnvn8bQ54nGSNq6cFvzMM68RQ3uSt9Dr3nsYnqi3RXAES4FJr7NHW2TVYgVoLsjBOhNWdOoLDxu0crZoHy7CTyyecozV7IITPAAKLSAqw2KU4mCztWhkH7YF3Xm08SZ0OtFOf46U0s43OS87ckwihr5O0l7QCX0s/u76nwnEURMdgsNs4zNmnEe8V0JXLb7U2ajGQHXLLBqqpdyEUbRVWhxLb5aiYqCTTKSrM5qvDZ8WPgXlm7oyZlLKwpNfnSZ/4Mr5McLLL1p6aQ3+wMV0eJ7b2qE79plHqxzDBG+C3RHMcu1K1EyVVGxQ6Kb/QqARbpJw3tyMKpFddpvFxqorJf9cV4SNEBeIS6UX59cL8UInkPvm0OMaUOdKEUh34YY2roCHITpGAA/Z8hpMuzK7vi6c4i83BSodVd3rXcJs95rHvZS23XoP+pD2SAwLi3sgJnyMTEqsOEstdxt+Kv80aBH+AlVY6Yq+n6B/pjxSYBtPk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(18092099006)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HZ6ECk3HdCMbx9uPd+L8xCrypc3NklPLLc1mpC+BM38oKB3bVZCxhlG7JxcgalxaLR2PcCOyd4a+Ab90JfiO6NHMOJQiyCwT59zDQujfowKtwPXs+2RxGtflEVbLw3hKEYpPDvJ7gBrIgQDHsF7SvCx+4LGZKbmyY/K3h1ajcI6W1hnsWvGtdXWx4ppx8MAluP164CoWReGKUTZMQDTz9MVzpWoOc28Fwo6SYTKtpA5b9CI44W6W/wx06qYttjnto2OZoEymFJQNqv45xyEK3zT08gEe39HcOWi9CT9BF4vbF8rZSHwAtL1qdvH4KIExp35Hmw+p2co/dfPcllWR1eZqvQ6Bmk7lsJTwOq1jV4ofdhdyIINVVvn2ewIK1/xbkzygL1MW3UnV/45HaW7j73HRfN5Ow75MUNDi2bWSFN/U52IwAh2+nEXL2J4yo1gq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 11:34:17.2373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe90fa5-b566-4034-e696-08dea9d1137c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290
X-Rspamd-Queue-Id: 773604BC6F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-19908-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moshe@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]



On 5/3/2026 4:45 AM, Jakub Kicinski wrote:
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/mlx5: Add VHCA_ID page management mode support
> 
> This change adds a VHCA_ID-based page management mode that uses vhca_id
> instead of function_id as the effective function identifier when the
> firmware advertises icm_mng_function_id_mode. Boot pages keep FUNC_ID
> semantics for backward compatibility, and tracked pages are migrated to
> the vhca_id key after set_hca_cap().
> 
> A few questions below on the per-type counter accounting, the boot-page
> migration helper, and locking on the FW-driven page path.
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
>> index e0eafcf0c52a..d3eaefc5c0e0 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
>> @@ -852,6 +852,48 @@ bool mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
>>        return true;
>>   }
>>
>> +u16 mlx5_esw_vhca_id_to_func_type(struct mlx5_core_dev *dev, u16 vhca_id)
>> +{
>> +     struct mlx5_eswitch *esw = dev->priv.eswitch;
>> +     struct mlx5_vport *vport;
>> +     unsigned long i;
>> +     u16 type;
>> +
>> +     if (vhca_id == MLX5_CAP_GEN(dev, vhca_id))
>> +             return MLX5_SELF;
>> +
>> +     if (!esw)
>> +             return MLX5_FUNC_TYPE_NONE;
>> +
>> +     mutex_lock(&esw->state_lock);
> 
> This function is reached from give_pages()/reclaim_pages()/
> release_all_pages() via func_vhca_id_to_type(), which in turn runs
> from the pg_wq work handler triggered by firmware page-request EQE
> events. Does acquiring esw->state_lock on that path introduce a new
> lock dependency?
> 
> Several eswitch paths (for example mlx5_esw_vport_enable(),
> mlx5_esw_vport_disable(), mlx5_eswitch_set_vport_mac()) hold
> state_lock while synchronously issuing firmware commands. Before this
> patch, the page path held no eswitch locks.
> 
> Would it be safer to resolve the func_type outside of state_lock, for
> example by caching the vhca_id-to-type mapping separately, or by
> attaching the resolved type to the fw_page at give time so reclaim
> does not need to look it up again?
> 

I don't think there is a real issue with the lock, but for sure better 
without, I will try caching vhca_id to type mapping.

>> +     mlx5_esw_for_each_vport(esw, i, vport) {
>> +             if (vport->vhca_id != vhca_id)
>> +                     continue;
>> +
>> +             if (vport->vport == MLX5_VPORT_HOST_PF) {
>> +                     type = MLX5_HOST_PF;
>> +                     goto unlock;
>> +             }
>> +
>> +             if (xa_get_mark(&esw->vports, i, MLX5_ESW_VPT_SF)) {
>> +                     type = MLX5_SF;
>> +                     goto unlock;
>> +             }
>> +
>> +             if (xa_get_mark(&esw->vports, i, MLX5_ESW_VPT_VF)) {
>> +                     type = MLX5_VF;
>> +                     goto unlock;
>> +             }
>> +
>> +             type = MLX5_EC_VF;
>> +             goto unlock;
> 
> Can this fall-through misattribute counters?
> 
> If a matching vport is not HOST_PF and has neither the VPT_SF nor the
> VPT_VF mark, it is unconditionally classified as MLX5_EC_VF. Would an
> UPLINK, ECPF, manager, or adjacent-style vport whose vhca_id happens
> to match end up charged to the EC_VF bucket here?
> 

The fallthrough is correct in practice  - uplink is the physical port, 
not a separate HCA function, FW doesn't request pages for it. ECPF is 
the esw manager, if requested here can be only as self, will catch the 
MLX5_SELF condition. Adjacent VFs are caught correctly by the VF mark.

>> +     }
>> +     type = MLX5_FUNC_TYPE_NONE;
>> +unlock:
>> +     mutex_unlock(&esw->state_lock);
>> +     return type;
>> +}
>> +
> 
> [ ... ]
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> index a242053f3a58..52cf341ad6b3 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>> @@ -597,6 +597,9 @@ static int handle_hca_cap(struct mlx5_core_dev *dev, void *set_ctx)
>>        if (MLX5_CAP_GEN_MAX(dev, release_all_pages))
>>                MLX5_SET(cmd_hca_cap, set_hca_cap, release_all_pages, 1);
>>
>> +     if (MLX5_CAP_GEN_MAX(dev, icm_mng_function_id_mode))
>> +             MLX5_SET(cmd_hca_cap, set_hca_cap, icm_mng_function_id_mode, 1);
>> +
> 
> [ ... ]
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> index 77ffa31cc505..7ebe88aa3b3e 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> 
> [ ... ]
> 
>> @@ -89,12 +105,21 @@ static u16 func_id_to_type(struct mlx5_core_dev *dev, u16 func_id, bool ec_funct
>>        return MLX5_SF;
>>   }
>>
>> +static u16 func_vhca_id_to_type(struct mlx5_core_dev *dev, u16 func_vhca_id,
>> +                             bool ec_function)
>> +{
>> +     if (mlx5_page_mgt_mode_is_vhca_id(dev))
>> +             return mlx5_esw_vhca_id_to_func_type(dev, func_vhca_id);
>> +
>> +     return func_id_to_type(dev, func_vhca_id, ec_function);
>> +}
> 
> Can the give/reclaim accounting become asymmetric in VHCA_ID mode?
> 
> The per-type counters are only updated when the resolved type is not
> MLX5_FUNC_TYPE_NONE:
> 
>          func_type = func_vhca_id_to_type(dev, func_vhca_id, ec_function);
>          if (func_type != MLX5_FUNC_TYPE_NONE)
>                  dev->priv.page_counters[func_type] += npages;
> 
> Since mlx5_esw_vhca_id_to_func_type() walks the eswitch vport table
> dynamically on every call, can the give and the corresponding reclaim
> resolve to different types?
> 
> For example, if a give runs before vport->vhca_id is populated in
> mlx5_esw_vport_caps_get(), the lookup returns MLX5_FUNC_TYPE_NONE and
> the counter is not incremented. Later, when the vport is fully
> populated, reclaim resolves to a real type and decrements the counter
> below the amount ever added, which on a u32 drives it to a very large
> value.
> 
> Similarly, if a vport is removed before reclaim, the increment at
> give time is recorded but the decrement at reclaim is skipped, so the
> counter leaks upward.
> 
> Would caching the func_type on the fw_page at give time and reusing
> it on reclaim make the accounting symmetric by construction?

Following first comment, I will try caching.

> 
> [ ... ]
> 
>> @@ -658,30 +708,101 @@ static int req_pages_handler(struct notifier_block *nb,
>>         * req->npages (and not min ()).
>>         */
>>        req->npages = max_t(s32, npages, MAX_RECLAIM_NPAGES);
>> -     req->ec_function = ec_function;
>> +     if (!mlx5_page_mgt_mode_is_vhca_id(dev))
>> +             req->ec_function = ec_function;
>>        req->release_all = release_all;
>>        INIT_WORK(&req->work, pages_work_handler);
>>        queue_work(dev->priv.pg_wq, &req->work);
>>        return NOTIFY_OK;
>>   }
>>
>> +/*
>> + * After set_hca_cap(), the second satisfy_startup_pages(dev, 0) may see
>> + * VHCA_ID mode. If page_root_xa already has the PF entry from the first
>> + * (boot) call under FUNC_ID keys 0 or (ec_function << 16), migrate that
>> + * entry to the device vhca_id key so lookups use VHCA_ID semantics.
>> + */
>> +static int mlx5_pagealloc_migrate_pf_to_vhca_id(struct mlx5_core_dev *dev)
>> +{
>> +     u32 vhca_id_key, old_key;
>> +     struct rb_root *root;
>> +     struct fw_page *fwp;
>> +     struct rb_node *p;
>> +     bool ec_function;
>> +     int err;
>> +
>> +     if (xa_empty(&dev->priv.page_root_xa))
>> +             return 0;
>> +
>> +     vhca_id_key = MLX5_CAP_GEN(dev, vhca_id);
>> +     ec_function = mlx5_core_is_ecpf(dev);
>> +
>> +     old_key = ec_function ? (1U << 16) : 0;
>> +     root = xa_load(&dev->priv.page_root_xa, old_key);
>> +     if (!root)
>> +             return 0;
> 
> Does this assume the boot-path func_vhca_id was always 0?
> 
> The boot call to mlx5_cmd_query_pages() reads func_vhca_id directly
> from the firmware output, and give_pages() then uses that value to
> compute the key. The migration here instead hardcodes old_key as
> ec_function ? (1U << 16) : 0.
> 
> If firmware returned a non-zero boot function_id, xa_load(old_key)
> returns NULL, the function silently returns 0, the caller flips the
> mode to VHCA_ID, and the original rb_root is orphaned in page_root_xa
> under the old key. Subsequent free_fwp()/find_fw_page() paths would
> then hit WARN_ON_ONCE(!root) and leak the DMA mappings and pages.
> 
> Would it be more robust to look up the actual key used at boot
> (derived from the stored func_vhca_id), and to treat the "xa not
> empty but old_key absent" case as an invariant violation rather than
> silently succeeding?
> 

During boot (mlx5_satisfy_startup_pages(dev, 1)), the mode is FUNC_ID. 
The mlx5_cmd_query_pages() call sets embedded_cpu_function in the 
request but leaves function_id as 0 (the PF queries its own pages). 
Firmware returns function_id in the output, which for the PF's own pages 
is always 0.
The "silently returns 0" when xa_load returns NULL is also fine, it 
means no boot pages were allocated.

>> +
>> +     if (old_key == vhca_id_key)
>> +             return 0;
>> +
>> +     err = xa_insert(&dev->priv.page_root_xa, vhca_id_key, root, GFP_KERNEL);
>> +     if (err) {
>> +             mlx5_core_warn(dev,
>> +                            "failed to migrate page root key 0x%x to vhca_id 0x%x\n",
>> +                            old_key, vhca_id_key);
>> +             return err;
>> +     }
>> +
>> +     xa_erase(&dev->priv.page_root_xa, old_key);
>> +
>> +     for (p = rb_first(root); p; p = rb_next(p)) {
>> +             fwp = rb_entry(p, struct fw_page, rb_node);
>> +             fwp->function = vhca_id_key;
>> +     }
> 
> Is the ordering here safe against any concurrent free_fwp()?
> 
> Between xa_erase(old_key) and the loop that updates fwp->function,
> every fw_page still carries the old key while page_root_xa no longer
> resolves it. If a free_fwp() were to run in that window:
> 
>          root = xa_load(&dev->priv.page_root_xa, fwp->function);
>          if (WARN_ON_ONCE(!root))
>                  return;
> 
> it would return early, skipping dma_unmap_page(), __free_page(), and
> kfree(fwp), leaking the DMA mapping and the backing page.
> 
> No concurrent free path is structurally reachable today because this
> runs before the EQ notifier is registered in mlx5_pagealloc_start(),
> but would it be cleaner to update the fwp->function values first,
> then swap the xarray entries (or store the new value at a single key)
> so the two views cannot disagree?
> 

Reordering is safer, I will reorder.

>> +
>> +     return 0;
>> +}
>> +
>>   int mlx5_satisfy_startup_pages(struct mlx5_core_dev *dev, int boot)
>>   {
>> -     u16 func_id;
>> +     bool ec_function = false;
>> +     u16 func_vhca_id;
>>        s32 npages;
>>        int err;
>>
>> -     err = mlx5_cmd_query_pages(dev, &func_id, &npages, boot);
>> +     /* When boot flag is set, the icm_mng_function_id_mode capability is
>> +      * not yet set (only set after set_hca_cap()), so use FUNC_ID mode
>> +      * for backward compatibility. When boot is false, set mode from
>> +      * cap (set_hca_cap has run successfully).
>> +      */
>> +     if (boot) {
>> +             mlx5_page_mgt_mode_set(dev, MLX5_PAGE_MGT_MODE_FUNC_ID);
>> +     } else {
>> +             if (MLX5_CAP_GEN_MAX(dev, icm_mng_function_id_mode) ==
>> +                 MLX5_ID_MODE_FUNCTION_VHCA_ID) {
> 
> The comment just above says "set mode from cap (set_hca_cap has run
> successfully)", which reads as "use the current/negotiated cap value",
> but the check uses MLX5_CAP_GEN_MAX rather than MLX5_CAP_GEN. The
> sibling code in drivers/net/ethernet/mellanox/mlx5/core/debugfs.c uses
> MLX5_CAP_GEN(dev, icm_mng_function_id_mode) for the same semantic
> check.
> 
> Could the comment and the _MAX usage be made consistent? If anyone
> later adds a conditional around the MLX5_SET() in handle_hca_cap()
> (for example a module parameter), the driver would start flipping to
> VHCA_ID mode based on _MAX without actually having enabled the feature
> in firmware.

OK, I will rewrite the comment.

> 
>> +                     err = mlx5_pagealloc_migrate_pf_to_vhca_id(dev);
>> +                     if (err)
>> +                             return err;
>> +                     mlx5_page_mgt_mode_set(dev, MLX5_PAGE_MGT_MODE_VHCA_ID);
>> +             }
>> +     }
> 
> Once page_mgt_mode is flipped to MLX5_PAGE_MGT_MODE_VHCA_ID, it stays
> set in dev->priv and is only reset on the next boot=1 call. Between
> teardown and the next boot=1 path (for example during health
> recovery, PCI reset, or any async flow that runs page work before
> mlx5_satisfy_startup_pages(dev, 1) re-runs), would a FW page-request
> EQE observe a stale mode?
> 
> The req_pages EQ notifier is registered via mlx5_pagealloc_start()
> and unregistered via mlx5_pagealloc_stop(), so this is not reachable
> today, but would it be worth resetting the mode explicitly on the
> teardown side rather than relying on the next reinit?

No. Once flipped to MLX5_PAGE_MGT_MODE_VHCA_ID, both driver and firmware 
keep using it till reopen function (next boot=1 call).
> 
> [ ... ]
> 
>> @@ -751,6 +874,9 @@ int mlx5_reclaim_startup_pages(struct mlx5_core_dev *dev)
>>        WARN(dev->priv.fw_pages,
>>             "FW pages counter is %d after reclaiming all pages\n",
>>             dev->priv.fw_pages);
>> +     if (mlx5_page_mgt_mode_is_vhca_id(dev) && !dev->priv.eswitch)
>> +             return 0;
>> +
> 
> Does this guard address the asymmetric-counter case raised above?
> 
> It only skips the per-type WARNs when the eswitch is entirely absent.
> In the common case where the eswitch is present but a vport's
> vhca_id/marks change between give and reclaim, the counters can still
> drift and these WARNs would still fire on normal teardown paths.
> 

Following first comment, will try caching.

> [ ... ]


