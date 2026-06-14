Return-Path: <linux-rdma+bounces-22217-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +3mSHcvaLmpn4wQAu9opvQ
	(envelope-from <linux-rdma+bounces-22217-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 18:46:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8757768190E
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 18:46:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="lHdL/IO+";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22217-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22217-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78741301603B
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 16:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13D0395AFA;
	Sun, 14 Jun 2026 16:44:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F2F3CB8EB;
	Sun, 14 Jun 2026 16:44:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455496; cv=fail; b=iLjmjiA+N4FhM16sfZv1DpAz1vn/piICHe8mgU/T30hkHf1ncMjaQRjMlrUqQLZhUxs1D7+DKlEyFN5FT1l8V30jykcX1NhFO/od1Kryd/gTppKBeGjyw8QwfUoGHk78BIz0O2PDvVmdVavUKQFFfxHA6KxPGoG9HCqV4+8Q9zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455496; c=relaxed/simple;
	bh=l2PC1DwT7bLT6gAU9PhkaxA6UQi2h+zkAJtaxLp/jz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dVmFswJ4LphSa21O7hVbQQWwA6W9g0FWWWkglkNWFyLkbpIl9FtSz5TmaHm/99AD79a1VWCF3SgYRbCA9rA7/FN1aShSTmX9BuWnSkOUp02sVPwtvfoltTMvqjHYLNfDzjbig7BNdQ2myrsRrdfwAnScQGHN7eRYk0/QDjBY+Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lHdL/IO+; arc=fail smtp.client-ip=40.107.200.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1viwI5oNq1iwJamoqEWRCPIetsAKIO0KmID1X75qjB7T4jaGYvwk0BkZThKPi3awsejCUP2pXo6MExP8zybB0qcn3LcEGEA+8sFLQl4BD8wvpeQ0osFTwyf0CzFU9g3z6J8t81A0uzxxP544Qo0KjttLzrWsf5n3jZ/1O+mnnh5sWawHlzknBWKdsVCgMHEzmx183hT8lwFwM+78BuhYU6O6eipQCWDtmL5QHbqezERR5UqQDQL3UqSkNmMZN4TNm+weH5NlMFkz2ykaJHGCxBttcufWz0+0FXhu5Qx9DcUPaGeXakCZkEp2yqqKLSkfHxYBxSuaVhMVIjj5B8Hqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZS3ri0XSS1sbkKEXP4p7VhZikQZJCBXoNSFUs1wCXE=;
 b=RcDAa8jVUoBZhLDPvo7cFVsGp522FGFZb+c65xMwAQ0jsC+nzUt0LeUULB/xKSf2f0k+9cSdb9iLWVwNrVT+JXfE+hHPHsBP46thCGsx+nd9Mn2Ry/2Ev9wvWkmkUk1jM6myK2zVVz3bZHtasmE57xZ64bv4Qb9XFAD6wiJV3NOoQ2QWQn41bEU0Pd90oI4oUqLyY/wQ8Dvt8RVVqC4ioCqIrOhpEYqY7J5ZjTfSUZSF/eVXC7A/0AY7hErUcAgLHxD6RbkX2+M/wtAE13e72UlvY11WnkGKF8ptu9YcilI+bCdv5R4CTDu/RfX92lVhuIpdHpWEnqVsnMxyQVzrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZS3ri0XSS1sbkKEXP4p7VhZikQZJCBXoNSFUs1wCXE=;
 b=lHdL/IO+E2QwMFPrj1CQM9ICnCe/Ux9Z+Oq/MBBBhF/YMPNokTwH6W0Pu2SCejCx/t1MxSQwBcvd5W5kHra5Q6t+2rL4OFwEePbyYWn6/l95mZ8p5WMZQvvoKNOE9JALl6hKOEyF0EbaNLiQ+aDhqj05NbezQAdVVZBsPH+SdVINaPiWcu220BNIPoasyCb8YVbDR1xgdmFw0WO2L0xg+9oq6ufObaJPZ8jf6LoUaE64PE6A2HPciMA2Vp/BPOq7nmS4t1rmyVodQ1GrJRxgPLl+qXLC/1mlobJ19EecOXCEfl/CvP8U7RwAO6TfO3fTZGHrM0KbamFIzHrL14pXzA==
Received: from SJ0PR05CA0109.namprd05.prod.outlook.com (2603:10b6:a03:334::24)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Sun, 14 Jun
 2026 16:44:47 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::13) by SJ0PR05CA0109.outlook.office365.com
 (2603:10b6:a03:334::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.9 via Frontend Transport; Sun, 14
 Jun 2026 16:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Sun, 14 Jun 2026 16:44:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 14 Jun
 2026 09:44:32 -0700
Received: from [10.221.208.116] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 14 Jun
 2026 09:44:25 -0700
Message-ID: <8e8434f7-6120-4fe7-8a8a-045e71bbfd2f@nvidia.com>
Date: Sun, 14 Jun 2026 19:44:23 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 13/15] net/mlx5: E-Switch, Tie rep load/unload
 to SD LAG state
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
References: <20260612113904.537595-1-tariqt@nvidia.com>
 <20260612113904.537595-14-tariqt@nvidia.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260612113904.537595-14-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd1e775-bca9-41de-2f9a-08deca343e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|23010399003|22082099003|18002099003|4143699003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	kws5cq1I/LUglqg3ktVr153MYYTGMjWZ1TaHIBL803ijgm/A7PDS+H3FTQ8oA+Iv95/8dVBTkflT3yB24lduDDsO8Z67WEuPliRJjS4dI845QMlQJpg+XPFfaAsaqDyX1ECId3O190cKusyOWfnH7G2KFLuoGkMmtVUMMoWh/WNkTjps9b3TiMip/S02qo0878196Ya+tIxW3UCJjGmlhC1oR7DO9X0Cp0P+2QWDp0E3K5YlKEbvk9yDa6elWaZSd7McbEqDwtpJqVXcirppo1DYsjQ4MzebL1SLpwFB+0jY8mBD+W4JLsU3eNc/fGhmEbUORcKSaYiJa68kxhJKxZfxuN2+VBCvTHR3lXKt46bohymzXVnaMoMsOJH56mLVBQX0bS1i/f4peFmHG/7hMMMmQzjNu8GmRHiA521SyKF4aNujf7bQUYDA++qhN5WsKXVXgZDfvSIxuDnd4/6Qhyy7zrbfxl4WmmBnPZGqmEqIl4nF4WjGQMCKn0/dLFFA08kc5ZoYw5wu7QilSD4nx7XhXJNofli83Q0F8WtD1Yg9mxfbcliZyRFFWRQdgbDCJoxJOwyd6+CAYiRKcr7dXhOiquA/6ZAM1gMwHbxJ8sGTLfNEhm8OuD+GTACXqvA/tMmjlGN6ydK2YyiXe4tubtU7vraOPkqir8m2AgMGV6e/tiXqKwK+0ZLn3/wlnMrN4OqO2+CNfUxn/vS2HDbD5IsUB8+OfZBkYxiYkZ7yRN0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NIe8JMbAh+rvix4PTwnIPYlpme0vx+zFyUQNgiKhJ+5GzH7P+7Lpo8F+io5YLJP9YyX5a5IcGj8AOFZJDO77La45bXDlFHC0N+77JjVaMSf9iFZtIPwxo79wCG6Dk/xREv/aGRPA+b4ffIaAaGefaADHhEzYMGSY/gPjcrBcXePxNjinTBN9xkZ96Bvz7yy8cOO3Lnmv0pOLymswxYaSmFMi2NGA/MY8eFf71BjBFkYECpiPGQSygCaenZQacc9T5Ke/B+CWq/h8LOOvfGgek6E5xNzXkqxbBCmq4GBXX2SA4zxtLefJdcpqo/XwHCKff1i0rICMBRgFP0wYLEArxFkd+gSU6LB2adqeWtSBEIsc31u5DP9B3b7XdokgjDFf6Q0hOiJTxi+ar9bItCY6GczzYXQrS6d3SLQhM8iWojbTdHhA+QTwnuGl90bITuIH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 16:44:46.8520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd1e775-bca9-41de-2f9a-08deca343e91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22217-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:horms@kernel.org,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:parav@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sashiko.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime];
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
X-Rspamd-Queue-Id: 8757768190E



On 12/06/2026 14:39, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> On an SD device, vport representors are not functional until the SD
> group is combined and shared FDB is active. Skip the initial load and
> the reload paths in that window; reps are loaded as part of the SD LAG
> activation flow once it becomes active.
> 
> In addition, explicitly unload representors when SD LAG is destroyed.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/eswitch.h |  4 +++
>   .../mellanox/mlx5/core/eswitch_offloads.c     | 26 +++++++++++++++++++
>   .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 26 +++++++++++++++++++
>   .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  1 +
>   .../mellanox/mlx5/core/lag/shared_fdb.c       |  1 +
>   5 files changed, 58 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> index a5f0774834fe..b2b3150f1f04 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -959,6 +959,7 @@ int mlx5_eswitch_offloads_single_fdb_add_one(struct mlx5_eswitch *master_esw,
>   void mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
>   					      struct mlx5_eswitch *slave_esw);
>   int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw);
> +void mlx5_eswitch_unload_reps(struct mlx5_eswitch *esw);
>   bool mlx5_eswitch_is_peer(struct mlx5_eswitch *esw,
>   			  struct mlx5_eswitch *peer_esw);
>   
> @@ -1063,6 +1064,9 @@ mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
>   	return 0;
>   }
>   
> +static inline void
> +mlx5_eswitch_unload_reps(struct mlx5_eswitch *esw) {}
> +
>   static inline bool
>   mlx5_eswitch_block_encap(struct mlx5_core_dev *dev, bool from_fdb)
>   {
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index a24719cfba34..4dc190a4e7b2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -2863,6 +2863,10 @@ static int mlx5_esw_offloads_rep_load(struct mlx5_eswitch *esw, u16 vport_num)
>   	int rep_type;
>   	int err;
>   
> +	if (vport_num != MLX5_VPORT_UPLINK &&
> +	    mlx5_get_sd(esw->dev) && !mlx5_lag_is_active(esw->dev))
> +		return 0;

sashiko.dev says:
If we intentionally skip the initial load of the Ethernet representors
(REP_ETH) here, will secondary devices permanently fail to load them later?
Looking at mlx5_lag_shared_fdb_create(), the code triggers an asynchronous
rescan exclusively for the primary device (dev0):
     mlx5_lag_rescan_dev_locked(ldev, dev0, true);
     err = mlx5_lag_reload_ib_reps_from_locked(ldev, 0, filter, false);
Because secondary devices are not rescanned, their auxiliary eth-rep drivers
are never re-probed, and their asynchronous reload is never queued. 
Since the
synchronous reload depends on REP_ETH already being loaded, skipping it here
seems to leave secondary devices permanently without network interfaces.

[SD] primary will invoke mlx5_esw_add_work() for secondary devices as
well via mlx5_eswitch_register_vport_reps_nested().

> +
>   	rep = mlx5_eswitch_get_rep(esw, vport_num);
>   	for (rep_type = 0; rep_type < NUM_REP_TYPES; rep_type++) {
>   		err = __esw_offloads_load_rep(esw, rep, rep_type,
> @@ -3779,6 +3783,21 @@ static void esw_destroy_offloads_acl_tables(struct mlx5_eswitch *esw)
>   		esw_vport_destroy_offloads_acl_tables(esw, vport);
>   }
>   
> +void mlx5_eswitch_unload_reps(struct mlx5_eswitch *esw)
> +{
> +	struct mlx5_eswitch_rep *rep;
> +	unsigned long i;
> +
> +	if (!esw || esw->mode != MLX5_ESWITCH_OFFLOADS)
> +		return;
> +
> +	mlx5_esw_for_each_rep(esw, i, rep) {
> +		if (rep->vport == MLX5_VPORT_UPLINK)
> +			continue;
> +		mlx5_esw_offloads_rep_unload(esw, rep->vport);
> +	}
> +}
> +
>   int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
>   {
>   	struct mlx5_eswitch_rep *rep;
> @@ -3805,6 +3824,10 @@ int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
>   		if (!mlx5_sd_is_primary(esw->dev) &&
>   		    rep->vport == MLX5_VPORT_UPLINK)
>   			continue;
> +		if (rep->vport != MLX5_VPORT_UPLINK &&
> +		    mlx5_get_sd(esw->dev) && !mlx5_lag_is_active(esw->dev))
> +			continue;
> +

Is there a race condition here during SD LAG activation that bypasses the
synchronous load of primary device representors?
In mlx5_lag_shared_fdb_create(), the unbind/rebind of auxiliary drivers for
the primary device queues an asynchronous work item to load REP_ETH.
Immediately following this, mlx5_lag_reload_ib_reps_from_locked() executes
synchronously.
Because the asynchronous work hasn't run yet, REP_ETH is not loaded.
Consequently, this synchronous loop will evaluate the REP_LOADED check as
false and silently skip loading REP_IB.

[SD] The async reload loads both REP_ETH and REP_IB for VF/SF. The
synchronous reload_ib_reps only re-adds IB for reps whose ETH is already
loaded; skipping IB when ETH isn't up yet is not a loss — the async path
loads both. No race.


>   		if (atomic_read(&rep->rep_data[REP_ETH].state) == REP_LOADED)
>   			__esw_offloads_load_rep(esw, rep, REP_IB, NULL);
>   	}
> @@ -4764,6 +4787,9 @@ static void mlx5_eswitch_reload_reps_blocked(struct mlx5_eswitch *esw)
>   		return;
>   	}
>   
> +	if (mlx5_get_sd(esw->dev) && !mlx5_lag_is_active(esw->dev))
> +		return;
> +
>   	mlx5_esw_for_each_vport(esw, i, vport) {
>   		if (!vport)
>   			continue;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index 424478e649ef..28d16fdc3f06 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -1312,6 +1312,32 @@ int mlx5_lag_reload_ib_reps_from_locked(struct mlx5_lag *ldev, u32 flags,
>   	return mlx5_lag_reload_ib_reps(ldev, flags, filter, cont_on_fail);
>   }
>   
> +static void mlx5_lag_unload_reps_unlocked(struct mlx5_lag *ldev, u32 filter)
> +{
> +	struct lag_func *pf;
> +	int i;
> +
> +	mlx5_lag_for_each(i, 0, ldev, filter) {
> +		struct mlx5_eswitch *esw;
> +
> +		pf = mlx5_lag_pf(ldev, i);
> +		esw = pf->dev->priv.eswitch;
> +		mlx5_esw_reps_block(esw);
> +		mlx5_eswitch_unload_reps(esw);
> +		mlx5_esw_reps_unblock(esw);
> +	}
> +}
> +
> +void mlx5_lag_unload_reps_from_locked(struct mlx5_lag *ldev, u32 filter)
> +{
> +	/* Same lock dance as mlx5_lag_reload_ib_reps: drop ldev->lock around
> +	 * the per-eswitch reps_lock to keep the reps_lock -> ldev->lock order.
> +	 */
> +	mlx5_lag_drop_lock_for_reps(ldev, filter);
> +	mlx5_lag_unload_reps_unlocked(ldev, filter);
> +	mlx5_lag_retake_lock_after_reps(ldev);
> +}
> +
>   void mlx5_disable_lag(struct mlx5_lag *ldev)
>   {
>   	bool shared_fdb = test_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, &ldev->mode_flags);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> index 8481ce55c10a..e9f0ef83ce1d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> @@ -310,6 +310,7 @@ int mlx5_lag_num_devs(struct mlx5_lag *ldev);
>   int mlx5_lag_num_netdevs(struct mlx5_lag *ldev);
>   int mlx5_lag_reload_ib_reps_from_locked(struct mlx5_lag *ldev, u32 flags,
>   					u32 filter, bool cont_on_fail);
> +void mlx5_lag_unload_reps_from_locked(struct mlx5_lag *ldev, u32 filter);
>   int mlx5_ldev_add_mdev(struct mlx5_lag *ldev, struct mlx5_core_dev *dev,
>   		       u32 group_id);
>   void mlx5_ldev_remove_mdev(struct mlx5_lag *ldev, struct mlx5_core_dev *dev);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
> index 8d4f2903a101..113866494d16 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
> @@ -296,6 +296,7 @@ void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev, u32 group_id)
>   			pf->sd_fdb_active = false;
>   		}
>   		mlx5_lag_destroy_single_fdb_filter(ldev, group_id);
> +		mlx5_lag_unload_reps_from_locked(ldev, filter);

sashiko.dev says:
Does explicitly unloading all representors here render the subsequent IB 
reload
a dead code no-op?
Immediately after mlx5_lag_unload_reps_from_locked() forcefully unloads 
REP_ETH
and other representors, this function calls
mlx5_lag_reload_ib_reps_from_locked().
Because REP_ETH was just unloaded, the condition checking if the state is
REP_LOADED inside mlx5_eswitch_reload_ib_reps() will evaluate to false,
silently skipping all IB representors.

[SD] this is intended

>   	}
>   
>   	mlx5_lag_add_devices_filter(ldev, filter);


