Return-Path: <linux-rdma+bounces-21919-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lC76NEhSJWrPGwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21919-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 13:13:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA416505D7
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 13:13:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=BNYHAPDL;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21919-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21919-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6882E300B745
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7704138C2C6;
	Sun,  7 Jun 2026 11:13:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013043.outbound.protection.outlook.com [40.107.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0EF37B015;
	Sun,  7 Jun 2026 11:13:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830786; cv=fail; b=iGDu0qXfKy5/7mjpc+AcY9+iK9Wqa+/Hzfy8ng/eaWnaKDfM7vaLHkkxNphaIdMCor3VrFPkZXUD9f8Ve0g8R5thAd7WtwnS+Hl4DG+5B9aYhZv6wSx5FcipKfR03dibl3uZXA8OFBOx8Ko04rL+LcIaFwl1+DqOhduXJvyjClI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830786; c=relaxed/simple;
	bh=nrOzd/Os8ZG2NfG+a3sWs85ILCuYICLD1oMUN5GKyr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gv3srJve9PAzmyutc0yPwT4affriNr3G86dx/HEgk5LyO7OrvXsjPBSh8xnvaWTZMglLKrZaD4xDVwujum8l6ztWPFOkDTQMnqylyZzAmAMR4vfNli+qt3ygy+6AZEq/smJoQlhLhpPxTLhijsLEKNfnAMuElcJvfCBlctIMpxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BNYHAPDL; arc=fail smtp.client-ip=40.107.201.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8l/Y00omVG4oFFQFOJhEyxdTgxEamqBd6DW8ZedH9E4RhfVbEn6CXQI8cyqR8AKQlXmS+FN9zoJinqhhMzAx+ykwSFavidDevn3sr77+ttUXM9pdrg0pEkggecRwxcyVCJPGkycVKeWa27GLDMzZo659JOb8gRZX9Xa445MbQ3apTD0Ykat0Ro2sByNAVzgGbewg7+P5P7z7Y9+1zrDYL9/Ioq/FXW9CfB5DvcZ1kvEA6mcZiXi6HjZHGHTLkhSUyFPvIj2XF97v80LTePNo84Dy7FCzHC9m753GRWQi8lrMGvgyiWblv1iuoM5I3sSmZKgtkrNeP9LRRSFN9Zn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2FW6hgrQYszatww2PMpTRD7+SehtioIu28egFzBK/M=;
 b=eXUUq+PhphY/Fjj2AQqvpUyHsL/iBLRCq+2O0zqX20ZRrJdmhWBatsgVVrSQXD5ls3L8WuGYAqnvz8z5XvZymutQ1NgwEDdKzw5xHrrddFK67tmjrErDanbtHxtXATH8InPKl486frv3N7OhIWMxKwPIXlxE3plm69TViqMW50PfOW0ISPW58mkJr6lQNnf6dRi1nm0p3TxyopLVf6dusQJP9nYV7J6rtOvgm9szvD4lF9dNMfU84Kml6SJ5tJX1kR27bQkM8WVWuaLZYv94rcUdnkCKNcw4PcUGZ2SKgtxDOVnLxOZYQRLv1nMed/Kw5zn3h7ilDrqM9QDr4gM0MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2FW6hgrQYszatww2PMpTRD7+SehtioIu28egFzBK/M=;
 b=BNYHAPDLU9tUJLDxtnFtdoVa9TH+a/0ym39KWAdQEgXrR7epMUdxwuRidzVWFb59T9pRMgHY7AiNXcnkwPcR81euh7JIurTkck7LmWYX+u0cpyOjoRb0swjgtOICljdHGRb1P0BPk1zsttlAgPzSlT1PRoXLHptnVtJsDZARccOTWnwXZaSqB5HpAgwe7RWjeGgdFZ29h4zesHBsLFM8dshePfI5A3Wt13lstm39uc2FZV/ep14NOpf/1H0mKisp2vZsi967BqDpxw+6Bo/hquwJKI01erskVmu7SkFwMcmd4XuCmue25nFiqB4Erx42jVO32CYk/wzksHzzRx1tiA==
Received: from BL1P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::6)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Sun, 7 Jun 2026
 11:12:58 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::ab) by BL1P222CA0001.outlook.office365.com
 (2603:10b6:208:2c7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Sun, 7
 Jun 2026 11:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sun, 7 Jun 2026 11:12:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 04:12:43 -0700
Received: from [10.125.203.115] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 04:12:36 -0700
Message-ID: <c386d2ce-4440-46ab-96fb-ae36752c2cc6@nvidia.com>
Date: Sun, 7 Jun 2026 14:12:32 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/15] net/mlx5: LAG, introduce software vport
 LAG implementation
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
References: <20260604114455.434711-1-tariqt@nvidia.com>
 <20260604114455.434711-12-tariqt@nvidia.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260604114455.434711-12-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2ab0c6-f51e-43d7-17c1-08dec485bb57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|22082099003|18002099003|4143699003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	qfCWWHMIw5vzUkTHZhsaSZ6oMNynQJ/odLpF+Q7Od8EkXP3xD6PdM/NmWHseYESnuBqFRNLGsdXF01HfuopSSlCc8YgK9UA2DcQs2Cspm3OgMMRDh+u5Z7Dl/F+R1qlaKd4HaJ5Jz/KJI61wEmdMw3aEUQbUi+TQq9+BySRqHpmknNCUX/K69ukwPpRyYyLpJAeS80vtJzHyrLOYg/o5gy3j11m30EURHLVxzsW7T/Sa9rwCM+EtjP915lm5KJ/uwhqRYqZPPEX5B1kCyJOvNCAMZP2wZfg13BmealnbDL00L5LyIXZF8e+tA+OPyRqN/Fs2kp5RVdO68i/CYaoFqazK1Ea6v/fMOvCIw7adie3L7QPX2mSrmRA44Hu6xsALtsJ1EcaIuKaHuLao7hH4qR3Q08+O9hloRKt03jsCqWsXbBp5KuZ59PhXaiqUfYYJdE8O88iQrMDVyzc9+4r5h6LpQ+/d2qUq8Joz1GRWMVTR8e2nLKLCs2DF/AE09158VW57jXj/o45z+8OMTV//dMBQSKQDHO6caRWkFVSsnNuc/Z0OumYcI4YF34hd7fKAmNXaM52okM/4/D7My0cRwPXIKXG/m/sYM/z2bct+i0J4A2ZIzCOPVKA8jPgqxjCJnr+njC2knBt/myaeIeoPZvUHvqv7umrYk9NAgX69bkL4MTTm7W/Spdy1gh5Ydq9livvbkJ/gL3Hz0Ub9K7qkFa0WYmuxbVN0DS7ZTN0w3jk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3FbjZZxTgYwXvaejbS5TGFJNUYlQ+1hxbKf1mkWUkrP+EdUJCGNMilij47hKrSqXo1irgloOd2X6yjAeCYLp0fCcEpPELCO1OFAr/iF3iDhRN59qDYFVyD+ctl0TB0wN5ENM4LGljmIMyT4wa5Qo+VvuPN63C85+625aQb/AAlfkhClFEMU5uU8ckPTVApCG9uMEXwVhHfw+DT9Mnez/2647PfLYbmblLhMiM95Ls/+L8omQ+06qdFxvFoxNSRSMjbJhTgFx14cgx11kI6g+3oIQ6lRjO97jmKFLSAhFv8e6t8+XC0m8V8MMTr70wVcYXgxzakqNDIX/rI6yDJFCmFT6fCSn1zbr5BnPNalD13dGrU/GaX+lcB535S+tUAShEWS6lOjv41jjrysS4yZhd29Efoiiv1gFJKj09gqNRk48mvD4/F6PePoADQP8HYJf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 11:12:58.3957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2ab0c6-f51e-43d7-17c1-08dec485bb57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231
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
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-21919-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
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
X-Rspamd-Queue-Id: 4DA416505D7



On 04/06/2026 14:44, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> SD LAG is a virtual LAG without hardware LAG support, so it cannot use
> the firmware vport LAG commands. Implement a software-based vport LAG
> using egress ACL bounce rules.
> 
> Add esw_set_slave_egress_rule() to create an egress ACL rule on the
> slave's manager vport that bounces traffic to the master's manager
> vport. This achieves the same traffic steering as hardware vport LAG.
> 
> Redirect mlx5_cmd_create_vport_lag() and mlx5_cmd_destroy_vport_lag()
> to the software implementation when operating in SD LAG mode.
> In addition, adjust lag_demux creation to check SD LAG mode as well.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/eswitch.h |   4 +
>   .../mellanox/mlx5/core/eswitch_offloads.c     | 142 ++++++++++++++++++
>   .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  49 +++++-
>   .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  14 ++
>   .../mellanox/mlx5/core/lag/shared_fdb.c       |  74 ++++++++-
>   5 files changed, 280 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> index 94a530d19828..a5f0774834fe 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -950,6 +950,10 @@ void esw_vport_change_handle_locked(struct mlx5_vport *vport);
>   
>   bool mlx5_esw_offloads_controller_valid(const struct mlx5_eswitch *esw, u32 controller);
>   
> +int mlx5_eswitch_offloads_vport_lag_add_one(struct mlx5_eswitch *master_esw,
> +					    struct mlx5_eswitch *slave_esw);
> +void mlx5_eswitch_offloads_vport_lag_del_one(struct mlx5_eswitch *master_esw,
> +					     struct mlx5_eswitch *slave_esw);
>   int mlx5_eswitch_offloads_single_fdb_add_one(struct mlx5_eswitch *master_esw,
>   					     struct mlx5_eswitch *slave_esw, int max_slaves);
>   void mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index 1133267a53fb..ad812fb1bb80 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -3041,6 +3041,136 @@ static int __esw_set_master_egress_rule(struct mlx5_core_dev *master,
>   	return err;
>   }
>   
> +static int esw_slave_egress_create_resources(struct mlx5_eswitch *esw,
> +					     struct mlx5_vport *vport)
> +{
> +	struct mlx5_flow_table_attr ft_attr = {
> +		.max_fte = 1, .prio = 0, .level = 0,
> +	};
> +	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
> +	struct mlx5_flow_namespace *ns;
> +	struct mlx5_flow_table *acl;
> +	struct mlx5_flow_group *g;
> +	u32 *flow_group_in;
> +	int err = 0;
> +
> +	if (vport->egress.acl)
> +		return 0;
> +
> +	xa_init_flags(&vport->egress.offloads.bounce_rules, XA_FLAGS_ALLOC);
> +	ns = mlx5_get_flow_vport_namespace(esw->dev,
> +					   MLX5_FLOW_NAMESPACE_ESW_EGRESS,
> +					   vport->index);
> +	if (!ns)
> +		return -EINVAL;
> +
> +	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
> +	if (!flow_group_in)
> +		return -ENOMEM;
> +
> +	if (vport->vport || mlx5_core_is_ecpf(esw->dev))
> +		ft_attr.flags = MLX5_FLOW_TABLE_OTHER_VPORT;
> +
> +	acl = mlx5_create_vport_flow_table(ns, &ft_attr, vport->vport);
> +	if (IS_ERR(acl)) {
> +		err = PTR_ERR(acl);
> +		goto out;
> +	}
> +
> +	g = mlx5_create_flow_group(acl, flow_group_in);
> +	if (IS_ERR(g)) {
> +		err = PTR_ERR(g);
> +		goto err_table;
> +	}
> +
> +	vport->egress.acl = acl;
> +	vport->egress.offloads.bounce_grp = g;
> +	vport->egress.type = VPORT_EGRESS_ACL_TYPE_SHARED_FDB;
> +	err = 0;
> +
> +err_table:
> +	if (err && !IS_ERR_OR_NULL(acl)) {
> +		mlx5_destroy_flow_table(acl);
> +		vport->egress.acl = NULL;
> +	}
> +out:
> +	kvfree(flow_group_in);
> +	return err;
> +}
> +
> +static void esw_slave_egress_destroy_resources(struct mlx5_vport *vport)
> +{
> +	if (!IS_ERR_OR_NULL(vport->egress.offloads.bounce_grp)) {
> +		mlx5_destroy_flow_group(vport->egress.offloads.bounce_grp);
> +		vport->egress.offloads.bounce_grp = NULL;
> +	}
> +	if (!IS_ERR_OR_NULL(vport->egress.acl)) {
> +		esw_acl_egress_ofld_cleanup(vport);
> +		xa_destroy(&vport->egress.offloads.bounce_rules);
> +	}
> +}
> +
> +static int esw_set_slave_egress_rule(struct mlx5_core_dev *master,
> +				     struct mlx5_core_dev *slave)
> +{
> +	struct mlx5_eswitch *slave_esw = slave->priv.eswitch;
> +	u16 master_vhca = MLX5_CAP_GEN(master, vhca_id);
> +	struct mlx5_flow_destination dest = {};
> +	struct mlx5_flow_handle *bounce_rule;
> +	struct mlx5_flow_act flow_act = {};
> +	struct mlx5_vport *slave_vport;
> +	int err;
> +
> +	slave_vport = mlx5_eswitch_get_vport(slave_esw,
> +					     slave_esw->manager_vport);
> +	if (IS_ERR(slave_vport))
> +		return PTR_ERR(slave_vport);
> +
> +	err = esw_slave_egress_create_resources(slave_esw, slave_vport);
> +	if (err)
> +		return err;
> +
> +	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> +	dest.type = MLX5_FLOW_DESTINATION_TYPE_VPORT;
> +	dest.vport.num = master->priv.eswitch->manager_vport;
> +	dest.vport.vhca_id = master_vhca;
> +	dest.vport.flags = MLX5_FLOW_DEST_VPORT_VHCA_ID;
> +
> +	bounce_rule = mlx5_add_flow_rules(slave_vport->egress.acl, NULL,
> +					  &flow_act, &dest, 1);
> +	if (IS_ERR(bounce_rule)) {
> +		err = PTR_ERR(bounce_rule);
> +		goto err_rule;
> +	}
> +	err = xa_insert(&slave_vport->egress.offloads.bounce_rules,
> +			master_vhca, bounce_rule, GFP_KERNEL);
> +	if (err)
> +		goto err_insert;
> +
> +	return 0;
> +err_insert:
> +	mlx5_del_flow_rules(bounce_rule);
> +err_rule:
> +	esw_slave_egress_destroy_resources(slave_vport);
> +	return err;
> +}
> +
> +static void esw_unset_slave_egress_rule(struct mlx5_core_dev *master,
> +					struct mlx5_core_dev *slave)
> +{
> +	struct mlx5_eswitch *slave_esw = slave->priv.eswitch;
> +	u16 master_vhca = MLX5_CAP_GEN(master, vhca_id);
> +	struct mlx5_vport *slave_vport;
> +
> +	slave_vport = mlx5_eswitch_get_vport(slave_esw,
> +					     slave_esw->manager_vport);
> +	if (IS_ERR(slave_vport))
> +		return;
> +
> +	esw_acl_egress_ofld_bounce_rule_destroy(slave_vport, master_vhca);
> +	esw_slave_egress_destroy_resources(slave_vport);
> +}
> +
>   static int esw_master_egress_create_resources(struct mlx5_eswitch *esw,
>   					      struct mlx5_flow_namespace *egress_ns,
>   					      struct mlx5_vport *vport, size_t count)
> @@ -3208,6 +3338,18 @@ void mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
>   	esw_unset_master_egress_rule(master_esw->dev, slave_esw->dev);
>   }
>   
> +int mlx5_eswitch_offloads_vport_lag_add_one(struct mlx5_eswitch *master_esw,
> +					    struct mlx5_eswitch *slave_esw)
> +{
> +	return esw_set_slave_egress_rule(master_esw->dev, slave_esw->dev);
> +}
> +
> +void mlx5_eswitch_offloads_vport_lag_del_one(struct mlx5_eswitch *master_esw,
> +					     struct mlx5_eswitch *slave_esw)
> +{
> +	esw_unset_slave_egress_rule(master_esw->dev, slave_esw->dev);
> +}
> +
>   #define ESW_OFFLOADS_DEVCOM_PAIR	(0)
>   #define ESW_OFFLOADS_DEVCOM_UNPAIR	(1)
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index b660253ffc6d..9566fbf59fdb 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -139,9 +139,44 @@ static int mlx5_cmd_modify_lag(struct mlx5_core_dev *dev, struct mlx5_lag *ldev,
>   	return mlx5_cmd_exec_in(dev, modify_lag, in);
>   }
>   
> +static u32 mlx5_lag_dev_group_id(struct mlx5_core_dev *dev)
> +{
> +	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
> +	struct lag_func *pf;
> +	int i;
> +
> +	if (!ldev)
> +		return 0;
> +
> +	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
> +		pf = mlx5_lag_pf(ldev, i);
> +		if (pf->dev == dev)
> +			return pf->sd_fdb_active ? pf->group_id : 0;
> +	}
> +	return 0;
> +}

sashiko.dev says:

In mlx5_lag_shared_fdb_destroy(), pf->sd_fdb_active is set to false for the
target group before calling mlx5_lag_reload_ib_reps_from_locked() to unload
the IB representors.
During the IB unload process, mlx5_eth_lag_cleanup() calls
mlx5_cmd_destroy_vport_lag(), which queries mlx5_lag_dev_group_id().
Since sd_fdb_active was already cleared, will mlx5_lag_dev_group_id() 
evaluate
to 0 here?
If it does, there might be a risk that mlx5_cmd_destroy_vport_lag() will 
pass
0 to mlx5_lag_destroy_vport_lag(), which treats 0 as MLX5_LAG_FILTER_ALL and
unconditionally destroys the manager vports' egress ACLs for all independent
SD groups on the device.


sd_fdb_active is cleared after, not before, the IB unload.
mlx5_lag_remove_devices_filter() is removing the IB rep, and
The mlx5_lag_reload_ib_reps_from_locked() call at the end of
mlx5_lag_shared_fdb_destroy() is the re-add path, not an unload.


> +
> +static int mlx5_lag_is_sw_lag(struct mlx5_core_dev *dev)
> +{
> +	return mlx5_lag_is_sd(dev);
> +}
> +
>   int mlx5_cmd_create_vport_lag(struct mlx5_core_dev *dev)
>   {
>   	u32 in[MLX5_ST_SZ_DW(create_vport_lag_in)] = {};
> +	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
> +	int ret;
> +
> +	if (mlx5_lag_is_sw_lag(dev)) {
> +		if (!ldev)
> +			return -ENODEV;
> +
> +		mutex_lock(&ldev->lock);
> +		ret = mlx5_lag_create_vport_lag(mlx5_lag_dev(dev),
> +						mlx5_lag_dev_group_id(dev));
> +		mutex_unlock(&ldev->lock);
> +		return ret;
> +	}
>   
>   	MLX5_SET(create_vport_lag_in, in, opcode, MLX5_CMD_OP_CREATE_VPORT_LAG);
>   
> @@ -152,6 +187,18 @@ EXPORT_SYMBOL(mlx5_cmd_create_vport_lag);
>   int mlx5_cmd_destroy_vport_lag(struct mlx5_core_dev *dev)
>   {
>   	u32 in[MLX5_ST_SZ_DW(destroy_vport_lag_in)] = {};
> +	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
> +
> +	if (mlx5_lag_is_sw_lag(dev)) {
> +		if (!ldev)
> +			return 0;
> +
> +		mutex_lock(&ldev->lock);
> +		mlx5_lag_destroy_vport_lag(mlx5_lag_dev(dev),
> +					   mlx5_lag_dev_group_id(dev));
> +		mutex_unlock(&ldev->lock);
> +		return 0;
> +	}
>   
>   	MLX5_SET(destroy_vport_lag_in, in, opcode, MLX5_CMD_OP_DESTROY_VPORT_LAG);
>   
> @@ -1663,7 +1710,7 @@ int mlx5_lag_demux_init(struct mlx5_core_dev *dev,
>   
>   	xa_init(&pf->lag_demux_rules);
>   
> -	if (mlx5_get_sd(dev))
> +	if (mlx5_lag_is_sw_lag(dev))
>   		return mlx5_lag_demux_ft_fg_init(dev, ft_attr, pf);
>   
>   	return mlx5_lag_demux_fw_init(dev, ft_attr, pf);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> index c689f1951cd8..34350b0a7307 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> @@ -175,6 +175,8 @@ int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
>   			       enum mlx5_lag_mode mode,
>   			       u32 group_id);
>   void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev, u32 group_id);
> +int mlx5_lag_create_vport_lag(struct mlx5_lag *ldev, u32 group_id);
> +int mlx5_lag_destroy_vport_lag(struct mlx5_lag *ldev, u32 group_id);
>   int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev);
>   void mlx5_lag_destroy_single_fdb(struct mlx5_lag *ldev);
>   bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev);
> @@ -191,6 +193,18 @@ static inline int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
>   static inline void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev,
>   					       u32 group_id) {}
>   
> +static inline int mlx5_lag_create_vport_lag(struct mlx5_lag *ldev,
> +					    u32 group_id)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int mlx5_lag_destroy_vport_lag(struct mlx5_lag *ldev,
> +					     u32 group_id)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static inline int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
>   {
>   	return -EOPNOTSUPP;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
> index 1371e14c4c13..8d4f2903a101 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
> @@ -89,6 +89,76 @@ static int mlx5_lag_create_single_fdb_filter(struct mlx5_lag *ldev, u32 filter)
>   	return err;
>   }
>   
> +int mlx5_lag_create_vport_lag(struct mlx5_lag *ldev, u32 group_id)
> +{
> +	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_ALL;
> +	int master_idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1,
> +							     filter);
> +	struct mlx5_eswitch *master_esw;
> +	struct mlx5_core_dev *dev0;
> +	int i, j;
> +	int err;
> +
> +	if (master_idx < 0)
> +		return -EINVAL;
> +
> +	dev0 = mlx5_lag_pf(ldev, master_idx)->dev;
> +	master_esw = dev0->priv.eswitch;
> +
> +	mlx5_lag_for_each(i, 0, ldev, filter) {
> +		struct mlx5_eswitch *slave_esw;
> +
> +		if (i == master_idx)
> +			continue;
> +
> +		slave_esw = mlx5_lag_pf(ldev, i)->dev->priv.eswitch;
> +		err = mlx5_eswitch_offloads_vport_lag_add_one(master_esw,
> +							      slave_esw);
> +		if (err)
> +			goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	mlx5_lag_for_each_reverse(j, i - 1, 0, ldev, filter) {
> +		struct mlx5_eswitch *slave_esw;
> +
> +		if (j == master_idx)
> +			continue;
> +		slave_esw = mlx5_lag_pf(ldev, j)->dev->priv.eswitch;
> +		mlx5_eswitch_offloads_vport_lag_del_one(master_esw, slave_esw);
> +	}
> +	return err;
> +}
> +
> +int mlx5_lag_destroy_vport_lag(struct mlx5_lag *ldev, u32 group_id)
> +{
> +	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_ALL;
> +	int master_idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1,
> +							     filter);
> +	struct mlx5_eswitch *master_esw;
> +	struct mlx5_core_dev *dev0;
> +	int i;
> +
> +	if (master_idx < 0)
> +		return 0;
> +
> +	dev0 = mlx5_lag_pf(ldev, master_idx)->dev;
> +	master_esw = dev0->priv.eswitch;
> +
> +	mlx5_lag_for_each(i, 0, ldev, filter) {
> +		struct mlx5_core_dev *dev;
> +
> +		if (i == master_idx)
> +			continue;
> +		dev = mlx5_lag_pf(ldev, i)->dev;
> +		mlx5_eswitch_offloads_vport_lag_del_one(master_esw,
> +							dev->priv.eswitch);
> +	}
> +	return 0;
> +}
> +
>   static void mlx5_lag_destroy_single_fdb_filter(struct mlx5_lag *ldev,
>   					       u32 filter)
>   {
> @@ -141,7 +211,7 @@ int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
>   			       enum mlx5_lag_mode mode,
>   			       u32 group_id)
>   {
> -	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_PORTS;
> +	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_ALL;
>   	int idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1,
>   						       filter);
>   	struct mlx5_core_dev *dev0;
> @@ -209,7 +279,7 @@ int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
>   
>   void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev, u32 group_id)
>   {
> -	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_PORTS;
> +	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_ALL;
>   	struct lag_func *pf;
>   	int err;
>   	int i;


