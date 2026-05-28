Return-Path: <linux-rdma+bounces-21425-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALs3AzAKGGpBbAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21425-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 11:26:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C96E5EF8DD
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 11:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29C8130929B3
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 09:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685183ACA4C;
	Thu, 28 May 2026 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pSI6EyIr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29735E92F;
	Thu, 28 May 2026 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959988; cv=fail; b=osRAg/0VKVzbBrNZiAc47g+8EWxctIWVFRtov0kBILfifyXHJTVHBLv7th8lyj4Yx//HTUszSOsNdnDeyeMSxePkEIxFteixTbQIqxwMA09/x8Rc4g4/VFxurqD2NdT+7q5W4KhbDVeAAimEAdEUBxRFwKatP1a1av8UmtFLYyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959988; c=relaxed/simple;
	bh=Yq1VHBokh7DRdmqqgLFwRVbddxxFeD0zU+cAVpO7yrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NvJ/Un7zDgz5Zni/jxRJSU3NeIWjhOSyGf2OWGIhJfoRYZY6gay2Zv2jot1kZADeZ/LxYL6f90fGI+XY50knS47TDIeBhWff6+8UNfD24j3sN1rgWibZvY+8llMnOuCKnwWjaHmkZcRP/f7hWsyIdFOn7poC8DCgsFWshpNpjA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pSI6EyIr; arc=fail smtp.client-ip=52.101.46.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAwmuT3BynMyrKfFcyfzsG94rg4TTBEEooBiTYEnTd0pgypWIdb6VIsHBycab3FEgjgOoN3IaUmNQsbzZ6btMijhE7+Z7IsTg4WiY6iiFFVUVQMnj1UvTDwhLbp472HXITVLi0OL3apdr9vOk1wVDucEaPnoHpnMN3XsVGh/WLC4H+bgiYkAtEJXGRG9WyJYzZnXTXkHXyaC1kPB3seXwZ1ZjSkXhRoIScl+3LRV24vhlZzcTtPnQOx1b+DgOeHlH058SIiGwEPSpS1L3X4YmmisrEUhZgZYNyLOB6ezNaMjUawd0H6PkX2QaSmo/zUThRSHOLliHpTSahAyzIUcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MTj7pmFGzhjKyHC987M6hYJKZWuOzicWEUEt7cvx/Q=;
 b=bZH2R4wRhSY987Ewd04/PT6ybQSAnp+WJ4z2wZKfZJ5fnCaAmoHO5zBqc/lAFTmvhlNPoiDtl9zlK6nEZAKPGeiqBKjVUyGvNYHOX/RzscWcCuy1uTPJcAaBhYU7DGHZYMZzK6POubfA/CHM5kJIeOKWl4oVOAiz8M/g2ZpuEkSSPMVV/mfcvEQjBJzwgWT7Kao4EAEgOe7/99qWERrwNK8pXzm++hcUuIdWZc9/TPny0h+PD+yyoU0QtsiQETVt8wbQgXasAt9PegOQwOhCBkvlhezwGxdeCQz+USZkDKcey88+juoWc61KdSdMZKLYyDfEOb8WkiM/RUY1Erjisw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MTj7pmFGzhjKyHC987M6hYJKZWuOzicWEUEt7cvx/Q=;
 b=pSI6EyIriE981lylBaVSA2ER/KJ86XhC9uSss+Q6ze4nZZexlYvnNp0nUFyZsKT8jyj7Ay5j0E2xqcww+f0NSMntjCiPm20TFmhxX9BHuEeq+YWre135QZE3f4TU4Yjn18jdnMtGxxnAq5UJHUgdglfCDFbzAZ9+5E+rpxy/Ctp2VYgAiDzoO0n/ZhOfydLrTgVzQS33lD2X5Gq09KOm9dOAeuZjk3InLNC1b9YPHF2LwIAwO85s4tvGHscDCEYColQBqD9cOGfP4WdnWoas35m7TvqzlrxEblFqHPiYlJaYiDa1gX8jbm5Zskjb/dkZyU1BTepjIGr7aWzfzCKqzQ==
Received: from CY5PR15CA0138.namprd15.prod.outlook.com (2603:10b6:930:68::20)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 09:19:41 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:68:cafe::2c) by CY5PR15CA0138.outlook.office365.com
 (2603:10b6:930:68::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 09:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 09:18:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 02:18:26 -0700
Received: from [10.125.202.189] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 02:18:19 -0700
Message-ID: <a2187226-2385-4aa1-9921-4e10e82400f0@nvidia.com>
Date: Thu, 28 May 2026 12:18:17 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/13] net/mlx5: Add switchdev mode support for
 Socket Direct single netdev, part 1/2
To: Jacob Keller <jacob.e.keller@intel.com>, Tariq Toukan <tariqt@nvidia.com>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
 <0a432449-2409-4e55-b17d-9d2fe1cc4860@intel.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <0a432449-2409-4e55-b17d-9d2fe1cc4860@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MN0PR12MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 086e9bbf-159e-4be9-5b54-08debc9a1beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|3023799007|6133799003|5023799004|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NYTZX6bMu7NbfM3PMDeKZbg7DhV2UWq1vd6+u/cwVlEznAm/kCVrVwzjpNhWpOEJE1Lnv5tKQqK08bHVXB1O1KTrPI47HLY1W1cKwOiduF+YiETR2UBhZ21wAOy2A826w5p/6hbff/hqodNAnKClNS5NZnwpI6iXPj98M3WknyiW7YZClmfnmzpItsXQUjN5N3Iga9KS9fincYh6eaQaHwzrGTCYThSbztVT07AJC0/5MDaOiY3UrO50+/hSpkVz+XaTP8Mn3fiXQXP77bmB6BD4Sbs9jYPIFwNVZdobN5vLehv6okK7YX9sgV5+HhnLHppXOL1DFafhnholIZuW8uSPHH6QfOl1H8uONDBKJ2x67zn+axI0SAgvW54kiw0/MMO8zaTH4D4z0qKNhnCS0n36+cDTSi1XMnlxirLCOvnCg6PFCO2lvs9n9TDk5BqnCQj/lxROpEWvuDXUtnvKZO/KZz9TGUNM3VZ9qpDf2ad3yk90trDkITfHG94Mtgkg9dywtEL/bOFJwU33v2MYke9DVT3WPI1BKgjajMINDvWvh05jxt6NPHzBqYL7DdfaQPTfIiB0dZsAldkBLAvfXmJ01Pl0PWkRCL/bw7WHNovSiqUREiHYWsuvgjBnCiewCCDwinNjkflZrSMHiQQj7NrGNKN5xCfnUIlpGsrzX3yIS6tGEEhlPflVzB+t4uROltFC7UvNSVNnRdmxFVDnDUTanH2kdmnCBFDQKdVxTDg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(3023799007)(6133799003)(5023799004)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	biW55pMZiOT904ABeM5Vg8wLUBbau/1tqNvhsGbgE2rM9Z2PhgqBCIKNKWaBJNieAvQTFF4xZCfvqSraQJL5IQJBIELDtefP2KRACLTaWda/sdTimEoVXgHc8zi+/PbVlQht6OOsmghzmYeuPciEDwjXqhKckqXWVCVaAOwRhEMlzTQonEfuXOdAG3GWBcQ/zyGbqqVeSDqmJfDY6ConOyDWiLuQUE8I23nGRKpQYLunp3XWogizGqHpFgreu7DENUHOuTsGabSiFUa4g4hKzNx7vHr5nnNywLV5kwV0rCvT5de3gkQoTyLrRYZrY9ky7khBlINtxKexX5X+NfHXI1nNTlLOeEeoxKDD+u075clLYYzBQ0iYx3T6m87LhseB3gQp4673V4cgc3/sK526wGtqK0/+V8GlgTNUr2Rg+GqIoPVOt8zYYjAPTPZp+h/1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 09:18:41.1532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 086e9bbf-159e-4be9-5b54-08debc9a1beb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21425-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 7C96E5EF8DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 28/05/2026 1:08, Jacob Keller wrote:
> On 5/27/2026 5:54 AM, Tariq Toukan wrote:
>> Hi,
>>
>> This series enables Socket Direct single netdev to operate in switchdev
>> mode with shared FDB. See detailed feature description by Shay below.
>>
>> Regards,
>> Tariq
>>
>>
>> This series enables Socket Direct single netdev to operate in switchdev
>> mode with shared FDB. SD single netdev combines multiple PCI functions
>> behind a single netdev interface. To support switchdev offloads, these
>> functions must participate in virtual LAG (shared FDB).
>>
>> Design
>>
>> Rather than introducing a separate LAG instance for SD, this series
>> integrates SD secondary devices into the existing LAG structure
>> (priv.lag) created at probe time. Each lag_func entry carries a
>> group_id field that identifies its SD group membership (0 means not
>> part of any SD group). An xarray mark (XA_MARK_PORT) distinguishes
>> physical port entries from SD secondaries, enabling a single unified
>> iterator that filters by group:
>>
>>    - MLX5_LAG_FILTER_PORTS: iterate port-level entries only (existing
>>      behavior, used by bonding, FW LAG commands, v2p_map)
>>    - MLX5_LAG_FILTER_ALL: iterate all devices including SD secondaries
>>      (used by MPESW shared FDB across all devices)
>>    - specific group_id: iterate only devices in that SD group (used by
>>      per-group SD shared FDB operations)
>>
>> Existing callers use mlx5_ldev_for_each() which maps to
>> MLX5_LAG_FILTER_PORTS, preserving current behavior for non-SD
>> configurations.
>>
>> Lifecycle and ownership
>>
>> The SD LAG lifecycle is tied to the SD group, not to bonding events:
>>
>> 1. At PCI probe, mlx5_lag_add_mdev() creates the LAG structure
>>     (priv.lag) for each LAG-capable PF. e.g.: SD primary devices
>>
>> 2. During mlx5_sd_init(), after the SD group is fully formed (primary
>>     and secondaries paired), sd_lag_init() registers the secondary
>>     devices into the primary's existing priv.lag by calling
>>     mlx5_ldev_add_mdev() with the SD group_id. The primary's lag_func
>>     also gets its group_id set. No separate LAG instance is created.
>>
>> 3. After all the devices in SD group transition to switchdev,
>>     mlx5_lag_shared_fdb_create() is invoked with the group_id to create
>>     a software-only shared FDB scoped to that SD group. This sets
>>     sd_fdb_active on all lag_func entries in the group. No FW LAG
>>     commands are issued since SD devices share the same physical port.
>>
>> 4. If MPESW (multi-port eswitch) is enabled on top of SD groups, the
>>     per-group SD shared FDB is torn down first, then MPESW shared FDB is
>>     created spanning all devices (ports + SD secondaries) using
>>     MLX5_LAG_FILTER_ALL. On MPESW disable, per-group SD shared FDB is
>>     restored.
>>
>> 5. On SD teardown (mlx5_sd_cleanup or device unbind), sd_lag_cleanup()
>>     removes secondaries from priv.lag and clears the primary's group_id.
>>     The LAG structure itself is not destroyed.
>>
>> The sd_fdb_active flag is set on all lag_func entries in a group (not
>> just the primary), so any device can detect the SD shared FDB state
>> during lag_disable_change teardown without needing to look up peer
>> entries.
>>
>> SD shared FDB is a pure software construct -- unlike regular LAG modes
>> (ROCE, SRIOV, MPESW), it does not issue FW create_lag/destroy_lag
>> commands. The software vport LAG for SD is implemented via eswitch
>> egress ACL bounce rules, managed by the IB layer through
>> mlx5_eth_lag_init(). And the software LAG demux is implemented via
>> steering rules that utilize new destination, VHCA_RX.
>>
> 
> I appreciate the overall details on the lifecycle and ownership. That
> made it easier to follow the patches and understand the changes.
> 
>> Patches
>>
>> Infrastructure (patches 1, 5-6):
>>    - Factor out shared FDB code into a dedicated file
>>    - Extend lag_func with group_id and sd_fdb_active fields;
>>      add XA_MARK_PORT and unified iterator with group_id filter
>>    - Extend shared FDB API with group_id parameter
>>
>> E-Switch preparation (patches 2-3):
>>    - Align eswitch disable sequence ordering
>>    - Move devcom init from TC to eswitch layer
>>
>> SD group management (patches 4, 7-9):
>>    - Replace peer count check with direct peer lookup
>>    - Register SD secondaries in the existing LAG at SD init time
>>    - Block RoCE and VF LAG for SD devices
>>    - Block multipath LAG for SD devices
>>
>> Switchdev integration (patch 10):
>>    - Keep netdev resources local in switchdev mode
>>
>> Steering (patches 11-12):
>>    - Track peer flow slots with bitmap for selective peer flow deletion
>>    - Enable TC flow steering for SD LAG
>>
>> Enablement (patch 13):
>>    - Verify unique vhca_id count for cross-VHCA RQT
>>
> 
> The patch 13 being the "enablement" is a bit confusing to me since I had
> trouble understanding how the patch description is "enabling" the socket
> direct stuff..  But the description does say "part 1/2" so I am guessing
> thats addressed in part 2?

Thanks for the review

the word "enablement" here in the cover letter is a bit confusing... :(
This commit prepare RQT layer for SD-over-DPU, which will also be enable
by the series.
in SD-over-DPU configuration, a device's vhca_id ends up failing the old
range-based check.

> 
>> Shay Drory (13):
>>    net/mlx5: LAG, factor out shared FDB code into dedicated file
>>    net/mlx5: E-Switch, align disable sequence with switchdev-to-legacy
>>      transition
>>    net/mlx5: E-Switch, move devcom init from TC to eswitch layer
>>    net/mlx5: LAG, replace peer count check with direct peer lookup
>>    net/mlx5: LAG, prepare for SD device integration
>>    net/mlx5: LAG, extend shared FDB API with group_id filter
>>    net/mlx5: SD, introduce Socket Direct LAG
>>    net/mlx5: LAG, block RoCE and VF LAG for SD devices
>>    net/mlx5: LAG, block multipath LAG for SD devices
>>    net/mlx5: SD, keep netdev resources on same PF in switchdev mode
>>    net/mlx5e: TC, track peer flow slots with bitmap
>>    net/mlx5e: TC, enable steering for SD LAG
>>    net/mlx5e: Verify unique vhca_id count instead of range
>>
>>   .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
>>   .../net/ethernet/mellanox/mlx5/core/en/rqt.c  |  27 +-
>>   .../ethernet/mellanox/mlx5/core/en/tc_priv.h  |   7 +
>>   .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  83 ++--
>>   .../net/ethernet/mellanox/mlx5/core/eswitch.h |  11 +-
>>   .../mellanox/mlx5/core/eswitch_offloads.c     |  26 ++
>>   .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 429 ++++++++++--------
>>   .../net/ethernet/mellanox/mlx5/core/lag/lag.h | 100 +++-
>>   .../net/ethernet/mellanox/mlx5/core/lag/mp.c  |   4 +
>>   .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  28 +-
>>   .../mellanox/mlx5/core/lag/shared_fdb.c       | 233 ++++++++++
>>   .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 227 +++++++--
>>   .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |  23 +
>>   .../net/ethernet/mellanox/mlx5/core/main.c    |   3 +-
>>   14 files changed, 914 insertions(+), 289 deletions(-)
>>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
>>
>>
>> base-commit: aa064a614efcfa4c300609d1f01134e99a12ad10
> 
> 


