Return-Path: <linux-rdma+bounces-19558-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UH7iOjft7WnkowAAu9opvQ
	(envelope-from <linux-rdma+bounces-19558-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 12:47:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 926054696F4
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 12:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78DE33014C21
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 10:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CFB30B517;
	Sun, 26 Apr 2026 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PbooRC8O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD34D14A4F0;
	Sun, 26 Apr 2026 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777200396; cv=fail; b=JabHvS6APX6CRFlMbW09DESLzJ0Dj/7JEjKIyvLJlPRDj9MtN3xB9UoNNNRTFkvgwECy0bL9wjZqkjZq2jlyEaTr7Fl9iiHu4Rvx6cN/3luSXM1jHHrJ08H+U2rh6//jVY/BoE+YMeVJGwE2WpNOOuRIiDmG+PxNeU0M7BfSOek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777200396; c=relaxed/simple;
	bh=jspGmOaMS2OymPIJEX+g2I9LVib8E5e1QPjGToemjpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kdOi7VG27BvPmavWePSz+aj3pMVaKwGGYNEcYMdX3OShZWmgnI0tba6sWgHQguDo/nfoXlGk8fWBft6BXIaCxGG4qUoxRK8DYeoFSygq51QM2X4MxwJT6WU2LxpY60TUZ6Gp/xpyM3m+KLgXXLD5gCHE9QljztpDDAdSDrMiKYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PbooRC8O; arc=fail smtp.client-ip=40.107.209.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEN8jBP0mswdKNYR8LlYfQl5aVHSi00XvW2mba3Js4XEKrsYOfCql4jKUQ20eTLwkYSfUWsSMooRYRUpOJNRbvPAoNA+q7zngO7lG0OAQbKThTiRrfab5N2osaTDz618T4Sm4UVIbYNHLedP7qMDaA1tgiCv5x5aanMdILfXGtbToQlNDz+vBrQo72OKUqBj/a/px31kTNNe3UaQKV2uhAN/xs4sXYh4ejn18Mi4TvLkWjWLlTo7x6C/zS0CQz0RfAOq7EC/XjuWdg84ExDX98DjVjZe5035oEROvaFxiVKlU+oqwt4gfFtLM8/WDTxZCvmDoujClcrh1l1rGuofTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIojMW/H5Fi4albKpHkwVkoSBoabZykEG2EKq7d3s+Y=;
 b=I3dJKcARgMpmxCAyUjnSR9+11Sq+6n4KtNLshFQcMsyhl3JC6Ogz9EfkMwFYF6iCxTY6xID76P6j5qzeE4pOcPgIGf53ZgMT5N372kbk0k7U+xzV90P9b45JRGmxwmQoQychH7cg/EIc3i4XTpDWHVCBYD8poOCBm+i7jl/Lmgx/K1hjml37DXEddclgUzpiJtKtOnVep5SUoqPQhuivy2SqeNqA3/MXJdXvfEc9sa5p4p9erNyTRHgIHlePN4nQGlc26xYqaXZkGuCFCk/4JzMr/EEkS0bJf4we+23jCMTkiOwB5VwDDQYR/p3y32Vif9xVD1/0t5fo3Qs9zZVHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIojMW/H5Fi4albKpHkwVkoSBoabZykEG2EKq7d3s+Y=;
 b=PbooRC8OFjJX57AAHSfv7QZs/Kj8ZWa3Tzo6RBw8k95Bt+6FV82nGIjgjgEvO5jivS5kmqjjtTpMxSFCJt6ycuUJE3awPTCuTtM0jZzq7Zc6VotXVeJijlL1VcY/kWPuAAanXTL7kLMir/E8GKDPQCwS42+St8wg8AxwcBgKKXrJuWswqIjTxhD2/bvgbQtMKQqV+A0soaL6euC3oSIwhtLOkzVoCacs1D3TsXHk0qcxIetBbw7qoFE+htdQeAiZU5esvNh0P7k8tafQRqitxev9qFa2GgxjGscOyxl0qdNvShbJ6lBYh0Awsgl+A4wJlQD8auLBojO8SRRdAFqPFg==
Received: from MN2PR16CA0049.namprd16.prod.outlook.com (2603:10b6:208:234::18)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sun, 26 Apr
 2026 10:46:29 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::51) by MN2PR16CA0049.outlook.office365.com
 (2603:10b6:208:234::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.25 via Frontend Transport; Sun,
 26 Apr 2026 10:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sun, 26 Apr 2026 10:46:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 03:46:14 -0700
Received: from [10.221.206.176] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 03:46:08 -0700
Message-ID: <60dbc1e0-97b8-497c-86bf-90a0f75d6d18@nvidia.com>
Date: Sun, 26 Apr 2026 13:46:07 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V3 1/4] net/mlx5: SD: Serialize init/cleanup
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Simon Horman <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Gal Pressman <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
References: <20260423123104.201552-1-tariqt@nvidia.com>
 <20260423123104.201552-2-tariqt@nvidia.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260423123104.201552-2-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: ba03a3ad-d556-4c5f-b01b-08dea38112ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vf9j+n/G0ZCTu6iMdUf0TJMZKFn8MhDniDZd+ZWedy4nHsCBLDzg5daV++IOZSSL60WX1lQEH4C/RoVND+Yq/ZslUUvRXv6F0yD4F/jt4uKcTUNSnAjny4bD9vYw29sQsjzZmLgn+0jLG7bAeqwUknBbqROKgV3+0Jba9wBU4o3KZ4UKAO+N4L5GlLcuGcO72mRXudAmOGXErmOk/9lToE7j2DM38PyUW04BuZnULyEmmqioG2gjTkbo0nFlnan5aeUqnT6OnxmSerH0/NBtX/aRFX2pkeWM/89Mjn6cQCcPLtlnG+LnTmagRVozEqyiFKnynYDaa50VF7ultMflOtjtH6Ayxar0qSFCHobo7iuFwg67V2cTD/kA3W5XCfZbneRD5MJePR+jEnvs8/lGGif6EgL0rxLGWqp7Noi/w/VBkPOMFgNfC7Psq50ncJz5N6KUFGDRAjpuldLbIpDGoN+AKHsxP+gJ6xHujhjUIwTpXaXcbEz/r6utrwNojefsxh/GOw3Vk9dvurMtbHCREDWnzeQE08efDUjKaLluGd6zTfP20qZWC+Hpz+1yYEA7XUZKHKhyzbHwrEGPMZDAYzn9IeVwqpOFRSpDmO9+08+sA5qM+2U8BrLT4d0osgmnWqgDxPEPKK8B1Mn2zxPzLRxAkfWNWfXbrFCMbJ6JxFW+21ILfjyBSBsCiJDkc2I9sneVcDspKgdmDNfrIv2Pu9j/JJFxNWhP+4T8ShpbbNwkC6s/C/TDEsxZLTmemq9tQLrexVsEGaCPcUjizjlwaA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vAgX1LB5HLzn5ixLcdYODNiLeP6T6U6myV+/wNOlw6K5gW5x9FLvS22bae6piEQNkL2ulcuKQRZ2IMwOilaQIprZTlSiHwdo1vjupAAyL1M66vLbJIIwFSNnfFBUhQqaJrdl5EnC269WF/LhPSYYxw2aYN69qYaRhuuI358LAoMJDid3DklK0f2Sd00jUoHYXtNjvkvONsrzNYv6rfchQqK74bSPADGB31+a3hlmVODwk556D4Y7lUA6WYTa/43yM7qU074fPH5WYNtSqupDteiz503ab0HygAU33ws0icyg0h2hQOqOcRYysnicQCoVFDknQ5L7hHj1Zjd4TgFhGDNTueYg/Xt3r5EifjX5N7tkdFgyNIYTBjjvFteY2RgIqI2wy/i89yR3Y3PedKPiv5BY18BRV++J6+HjHrkitFmIlsZVJ3lC+7hviNRr4iEL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 10:46:29.4976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba03a3ad-d556-4c5f-b01b-08dea38112ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
X-Rspamd-Queue-Id: 926054696F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-19558-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]



On 23/04/2026 15:31, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> mlx5_sd_init() / mlx5_sd_cleanup() may run from multiple PFs in the same
> Socket-Direct group. This can cause the SD bring-up/tear-down sequence
> to be executed more than once or interleaved across PFs.
> 
> Protect SD init/cleanup with mlx5_devcom_comp_lock() and track the SD
> group state on the primary device. Skip init if the primary is already
> UP, and skip cleanup unless the primary is UP.

Sashiko:
"The commit message mentions skipping cleanup unless the primary is UP.
However, it appears this state check is missing from mlx5_sd_cleanup()
in the diff below."

The above sentence is leftover and should be removed.
will drop in next version.

> 
> In addition, move mlx5_devcom_comp_set_ready(false) from sd_unregister()
> into the cleanup's locked section. A concurrent init acquiring the
> devcom lock will now observe devcom is no longer ready and bail out
> immediately.
> 
> Fixes: 381978d28317 ("net/mlx5e: Create single netdev per SD group")
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 32 +++++++++++++++----
>   1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> index 762c783156b4..96b4316f570e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> @@ -18,6 +18,7 @@ struct mlx5_sd {
>   	u8 host_buses;
>   	struct mlx5_devcom_comp_dev *devcom;
>   	struct dentry *dfs;
> +	u8 state;
>   	bool primary;
>   	union {
>   		struct { /* primary */
> @@ -31,6 +32,11 @@ struct mlx5_sd {
>   	};
>   };
>   
> +enum mlx5_sd_state {
> +	MLX5_SD_STATE_DOWN = 0,
> +	MLX5_SD_STATE_UP,
> +};
> +
>   static int mlx5_sd_get_host_buses(struct mlx5_core_dev *dev)
>   {
>   	struct mlx5_sd *sd = mlx5_get_sd(dev);
> @@ -270,9 +276,6 @@ static void sd_unregister(struct mlx5_core_dev *dev)
>   {
>   	struct mlx5_sd *sd = mlx5_get_sd(dev);
>   
> -	mlx5_devcom_comp_lock(sd->devcom);
> -	mlx5_devcom_comp_set_ready(sd->devcom, false);
> -	mlx5_devcom_comp_unlock(sd->devcom);
>   	mlx5_devcom_unregister_component(sd->devcom);
>   }
>   
> @@ -426,6 +429,7 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
>   	struct mlx5_core_dev *primary, *pos, *to;
>   	struct mlx5_sd *sd = mlx5_get_sd(dev);
>   	u8 alias_key[ACCESS_KEY_LEN];
> +	struct mlx5_sd *primary_sd;
>   	int err, i;
>   
>   	err = sd_init(dev);
> @@ -440,10 +444,15 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
>   	if (err)
>   		goto err_sd_cleanup;
>   
> +	mlx5_devcom_comp_lock(sd->devcom);
>   	if (!mlx5_devcom_comp_is_ready(sd->devcom))
> -		return 0;
> +		goto out;

Sashiko:
"Can primary be NULL here?
In sd_register(), the devcom ready state is published under the devcom
lock, but the lock is then released before the peer_sd->primary_dev
pointers are initialized.
If a concurrent thread executing mlx5_sd_init() or mlx5_sd_cleanup()
acquires the lock and observes the ready state, could it read an
uninitialized primary_dev before the loop in sd_register() completes?"

No, this is impossible. concurrent init will always set primary before
accessing it, and cleanup is always after successful init, so again-
primary is set.
and the next comment is also impossible seqence

>   
>   	primary = mlx5_sd_get_primary(dev);
> +	primary_sd = mlx5_get_sd(primary);
> +
> +	if (primary_sd->state != MLX5_SD_STATE_DOWN)
> +		goto out;
>   
>   	for (i = 0; i < ACCESS_KEY_LEN; i++)
>   		alias_key[i] = get_random_u8();
> @@ -472,6 +481,9 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
>   		sd->group_id, mlx5_devcom_comp_get_size(sd->devcom));
>   	sd_print_group(primary);
>   
> +	primary_sd->state = MLX5_SD_STATE_UP;
> +out:
> +	mlx5_devcom_comp_unlock(sd->devcom);
>   	return 0;
>   
>   err_unset_secondaries:
> @@ -481,6 +493,8 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
>   	sd_cmd_unset_primary(primary);
>   	debugfs_remove_recursive(sd->dfs);
>   err_sd_unregister:
> +	mlx5_devcom_comp_set_ready(sd->devcom, false);
> +	mlx5_devcom_comp_unlock(sd->devcom);
>   	sd_unregister(dev);
>   err_sd_cleanup:
>   	sd_cleanup(dev);
> @@ -491,22 +505,28 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>   {
>   	struct mlx5_sd *sd = mlx5_get_sd(dev);
>   	struct mlx5_core_dev *primary, *pos;
> +	struct mlx5_sd *primary_sd;
>   	int i;
>   
>   	if (!sd)
>   		return;
>   
> +	mlx5_devcom_comp_lock(sd->devcom);
>   	if (!mlx5_devcom_comp_is_ready(sd->devcom))
> -		goto out;
> +		goto out_unlock;
>   
>   	primary = mlx5_sd_get_primary(dev);
> +	primary_sd = mlx5_get_sd(primary);
>   	mlx5_sd_for_each_secondary(i, primary, pos)
>   		sd_cmd_unset_secondary(pos);
>   	sd_cmd_unset_primary(primary);
>   	debugfs_remove_recursive(sd->dfs);
>   
>   	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
> -out:
> +	primary_sd->state = MLX5_SD_STATE_DOWN;
> +	mlx5_devcom_comp_set_ready(sd->devcom, false);
> +out_unlock:
> +	mlx5_devcom_comp_unlock(sd->devcom);
>   	sd_unregister(dev);
>   	sd_cleanup(dev);
>   }


