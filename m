Return-Path: <linux-rdma+bounces-19909-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH+JIBaG+GkbwQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19909-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 13:42:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EF54BC8D9
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 13:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 744D03010496
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 11:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9331E3BE156;
	Mon,  4 May 2026 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H6+pTNR6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D723A6B6A;
	Mon,  4 May 2026 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894930; cv=fail; b=UArRuyx1czwtzBkwR+mXvpaaBczv1E36pdRjjRq20RfUstFjx211TRmX6W8SuQglGZjINf6R1L+BHN46KdTafaAQ7x0A7MkchmmYI62SiQSzNs0b9S8rMvyZv7q4uxl5bFieQ/fqF5a+4tTGMJec0atBZ0es/EUjwpFXyIGcU+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894930; c=relaxed/simple;
	bh=ofMo6ZH7deIImSYpnAi3uyqp9GCpN0Qbk4F7qlQb2Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZrNh/KCuw0LlD5qfZfgUunwnocsc21cQurFXLSIyCN29VEVF7MgYLFRElZqZ0FBJBjFNrZnpnfihbIJqudRt4657m5DE5QCcVRQaBkoApCkF7PsEEA60zm+1krbfx88ZidD7RjlEoG3m3PiAKg7tQUNghI4hqErf4E6YaZ6XYyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H6+pTNR6; arc=fail smtp.client-ip=52.101.61.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHOuG4X2Ue9EqAutpmnNLq9jcQQYiV+iVyySFWOiz8XTF8uDruISkb8XQL/Jk5IxgFJc2zrc3tMtA0fwUsyPnUys9JN4vWAhxPs1kXAZZo0T2lUPXRVLUqCI2HWs8zx4tQtbA9yYxvrMTV1SRtyucH2mmBjmNQTNI6Co1vIfHjCXl8AnZqGlbSFr8Du7q2pndwdAKVSpxUeTfDMWAE80xndOVl2ppLQwt5IWdjFnRLicQA5j0nC1kPCyQj3j0NFiu+iqrklOhATk+MMrF2m3HeSrwewMK/3dutfxnTPXiSomCzic7HXeoVq0SsGWJyYQIyDYsl6V+aK8lcRVIGw7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyFmowbF/bW7f2WlQ13M2TK66EdKGlZ1FdT5W+sTTuw=;
 b=wyQG8L7fRcSPeSzyxH4bl0tUu+DQY2Skjx2vkiKUd4Ym+DCKwYzHsw+ki1DlT/rxG1O3Qcb0cdiU4JcGT90xLa5IkZ4TEIex6yv7iw9dYf5Ov5Je5obCq6km+MYwZJI6Ann/kBB0SEBxVaY1AjxT7LNrrBpnFoRIq2AJEwxN9yMS1YCfqPRyvNcNanV8/1osXBfEd6IZnAMo9+uxDv9XInIX5V9nv3kAf4MVq0WBmR2TVLCfJ6GFEB4CFaLv+ZVH4+m4hUH60FPQIcsd18OYUzbemEBqmMeNEt3eWftSs/6YiBw/N6HQjaXVNRu6agpC/+sY+obTY88pU/oVlgQLkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyFmowbF/bW7f2WlQ13M2TK66EdKGlZ1FdT5W+sTTuw=;
 b=H6+pTNR6lbnuODvUh5xzL4EqLgvp7eDYZoMRUzu6HLR6tLN2o5g0n/t6Jk/TeZcnYEcMkm4s4lIUTZQU00xpTMGawEfG2lUAT6zYziOc370XrIsIQsjBD68ncP3ymxYZwq7IU5LnIAXT3d3mMIhGidJHSfK7YpZaxyTwfKJm8UrQd8h4XgrzXK9WY1f4ItYvVmlL+b6FCb3njjNgVYa/kv/urDn3U2yzyQrIceDRxduFDuL7wokXrqX2kTrSpStB0lWulEz2HwBZVaT6GJtKnZ824vlz2+f54ZEoFlBDtHpMX/aOQPiL0RlJJwv2T5KlzmZY77leJqctHm8EhRsUHw==
Received: from BN9PR03CA0865.namprd03.prod.outlook.com (2603:10b6:408:13d::30)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 11:42:02 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::96) by BN9PR03CA0865.outlook.office365.com
 (2603:10b6:408:13d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 11:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Mon, 4 May 2026 11:42:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 04:41:43 -0700
Received: from [10.125.201.174] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 04:41:37 -0700
Message-ID: <8a7035c2-72a8-4b60-b7a3-8e36787774e8@nvidia.com>
Date: Mon, 4 May 2026 14:41:33 +0300
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
 <20260503014520.4098577-1-kuba@kernel.org>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20260503014520.4098577-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e5868e0-8d97-44ea-54c3-08dea9d22873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	S9HuFP91wB4/GPwykJgbfzHJnggjGbPUHcbVqfnX+XnDTMqdWfc5dYZOtKl3mGilF7xUBQ3JLX91tbKrTZhcMiO6gFuBtOjvquD9t1bl9j+oEl0bpL21kJMZcC4uXk1qJ14eNfq/3SNWFltcILcM1qNzBOy+/s/Y6aHgg71uPRkTMQ7/QN9nv2jrsGDfWIrVQrk8RYcSon28kBSYBGbewQRiGycROy56nKqqsgYnQ7nUXl88vLA49vBpy2ikjwz4X/XIaGBq9l3jlU8WE1OSx0pn/XfOk4XIff8OvRARf3pFGfI/zis2UfMtm9+8VlZpB+OD474tfhL+PcmpYB0PzUJqrJa9Yqbekd68bsurVsQPUFx3eO1VIrHSJ7EYxbrFwvdmd/8YYw1rmOpXFhghNEtvjYZXmldxHd0vld764PiPThDgHjLQOKQcW2W1INZBiJHX6xqoaVN+WYfVGq3fq2viCSjdQF5LitjlRoWDuJrOhRn8RCvz3mtyCux0RkeV43Yh+JES3K2xD7a0NwZ5RdHg/XAb5aCDKaTKX9S3EOygFwyDFHVu2qP0uMbcbYPMWOKrcmRdISztUsQdSHOyBHErox6hPkkFW9x3b8xfSl9xMUZ8kwpjisLOk6QjpvKiUUGAcj0F21O1JFrgIQx93nX7JwZWC/ErMAYT3CQ4xEVK/pFnyK55GiKq3V6dLIGZxk6Mr92x2p4jTaa5MKdi9J9tsI+V0w2BVX5r7xUHvKU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lywXX2hCHKQexRpH9An25ZiUYy5muQMtT8jtZbhnPcColJs/nCiQVpxmQfF9BtMbg1WlvIRsv0NXUEc55FbCqPKJG6xFO7NAiiU+n7rwjdAzdJzk8MdSzPiKc1tsW6tUrrZH7IqSEgiOcrbukpHRTxgNK0zNQAp+u95F0+j9xkuFrTCdZOKQByJpCtlT3P5ZPU09d2YpeID9QYqu4vw33rgO1Uvckk2olq5uCVrWbq8m3nRkCBuma2opXCLVPnqrZzBe54phjlN8hERVhd3hQGt2O79/82gl6tuo2nfd+J4UMHmHh2PD/DS5pesWmf+Cuems3TLHePabL9LirZ8sgh1eAdejiOryO2vVmYK1P7q0wo3Vj9umUngqoPG3xKYFrjTtxN41qVe/Pwnxe6lWCkya+Cuthd6AsXqQAJzhUv/a7BJ4cqOihHRi8gn+jXih
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 11:42:01.8163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5868e0-8d97-44ea-54c3-08dea9d22873
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
X-Rspamd-Queue-Id: F2EF54BC8D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-19909-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]



On 5/3/2026 4:45 AM, Jakub Kicinski wrote:
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> Subject: net/mlx5: Add VHCA_ID page management mode support
> 
> This commit adds support for VHCA_ID-based page management mode. It
> updates page management commands to conditionally use vhca_id and adds
> a function to resolve the function type via vport lookup.
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
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
> Can this race with driver unload?
> 
> Since the page allocator workqueue (pg_wq) is asynchronous and destroyed
> after the eswitch structure is freed, could a pending page request evaluate
> esw as valid just before it's freed, and then attempt to lock it here?
> 
> Also, is there a potential deadlock when acquiring esw->state_lock here?
> 
> If a thread holds the lock while sending a firmware command, and the
> firmware issues a page request to complete it, the pg_wq worker will block
> here waiting for the lock. Would this prevent the firmware command from
> completing?

In give_pages() the function mlx5_esw_vhca_id_to_func_type() is called 
only after the firmware got the pages. Following other mail comments 
will use caching instead of lock.
> 
> [ ... ]
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> [ ... ]
>> -static int give_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
>> +static int give_pages(struct mlx5_core_dev *dev, u16 func_vhca_id, int npages,
>>                      int event, bool ec_function)
>>   {
>> -     u32 function = get_function(func_id, ec_function);
>> +     u32 function = get_function_key(dev, func_vhca_id, ec_function);
>>        u32 out[MLX5_ST_SZ_DW(manage_pages_out)] = {0};
>>        int inlen = MLX5_ST_SZ_BYTES(manage_pages_in);
> 
> This isn't a new issue introduced by this patch, but does the npages
> calculation risk an integer overflow?
> 
> The npages parameter is derived from the firmware payload, and the
> allocation size is calculated as:
> 
> inlen += npages * MLX5_FLD_SZ_BYTES(manage_pages_in, pas[0]);
> 
> If a compromised firmware provides a massive npages value, could this
> overflow the 32-bit inlen and result in an undersized kvzalloc allocation,
> followed by an out-of-bounds write in the subsequent loop?

Technically yes, but as Sashiko writes here, it is not relevant to this 
patch or this series. it could be addressed as a separate hardening patch.

> 
> [ ... ]
> 
>> @@ -577,8 +626,9 @@ static int reclaim_pages(struct mlx5_core_dev *dev, u16 func_id, int npages,
>>        if (nclaimed)
>>                *nclaimed = num_claimed;
>>
>> -     func_type = func_id_to_type(dev, func_id, ec_function);
>> -     dev->priv.page_counters[func_type] -= num_claimed;
>> +     func_type = func_vhca_id_to_type(dev, func_vhca_id, ec_function);
>> +     if (func_type != MLX5_FUNC_TYPE_NONE)
>> +             dev->priv.page_counters[func_type] -= num_claimed;
> 
> Does this dynamically look up the vport during page reclaim?
> 
> If an SF or VF has been destroyed and its vport removed, the lookup will
> return MLX5_FUNC_TYPE_NONE. Will this cause the decrement to be skipped,
> leading to a counter leak and triggering the WARN() statements in
> mlx5_reclaim_startup_pages() during driver unload?

VF and SF vports are removed after reclaiming pages, but as already 
wrote on the other mail, will try caching

> 
> [ ... ]
> 
>> @@ -658,30 +708,101 @@ static int req_pages_handler(struct notifier_block *nb,
> [ ... ]
>> +     } else {
>> +             if (MLX5_CAP_GEN_MAX(dev, icm_mng_function_id_mode) ==
>> +                 MLX5_ID_MODE_FUNCTION_VHCA_ID) {
>> +                     err = mlx5_pagealloc_migrate_pf_to_vhca_id(dev);
>> +                     if (err)
>> +                             return err;
>> +                     mlx5_page_mgt_mode_set(dev, MLX5_PAGE_MGT_MODE_VHCA_ID);
>> +             }
>> +     }
> 
> What happens to the device state if mlx5_pagealloc_migrate_pf_to_vhca_id()
> fails?
> 
> The firmware has already been instructed to use VHCA_ID mode during driver
> load, but if the migration fails, the function returns early and leaves
> dev->priv.page_mgt_mode as FUNC_ID.
> 
> When the initialization aborts and mlx5_reclaim_startup_pages() runs, will
> the driver send reclaim commands using the old ID, causing the firmware
> to reject them and leak the allocated DMA memory?

If mlx5_pagealloc_migrate_pf_to_vhca_id() fails, it can fail only on 
xa_insert of the new key, OOM issue and we couldn't set the new key. if 
it does fail, the device init fails entirely anyway.



