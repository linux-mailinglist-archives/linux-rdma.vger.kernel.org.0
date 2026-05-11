Return-Path: <linux-rdma+bounces-20375-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KDTCHKaAWpxfwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20375-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 10:59:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B9550A780
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 10:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C36B3030D4F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 08:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9265A3C061D;
	Mon, 11 May 2026 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NQUq2ezw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095643BD63A;
	Mon, 11 May 2026 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489616; cv=fail; b=L0e2VnmQxKH00fmIoetJK2v2yHjp8V9q3r6Rrh17KjRbG6r9LEUzXX363q9fXtXNIAcPN10Tr49K9p+VZU6jjn17cGAZhRUxJBQXnjnmOhMQ956tYwyuZjeiHV6cxKJYm0Enlsqz1156cVJ2huHkzKgDIb6a2KUR3AVzsM0wlww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489616; c=relaxed/simple;
	bh=amCW6mSlhZzSBBzUYAUIu0z7pjdMGi/GimaxwN9Bd4M=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nE9vS/hVk9DCN1KBTvlPiN/3u/pNpK/CJrB0qjBQWMhvUWnZ2m+wwKPBD9oJaVVZrstSEjoOkLkuHgHd9d/KaIG3QeEPZkUDbbNntZPHHQzdC5tZjITqaw8rKt630OJqOihgDZLshzOtad5WNiSL31/6IsqInazxplq2PYo4Cyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NQUq2ezw; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqmqC4kA4MZBMMOZtRAVzCiYQXvy3kJIkvw6/rHJUJWM2IMmQzRSX1hFwf/6h8SeKXqNnXQ0jV3jFGogBQW6sxhrc96jjtOi8Bxs22DRY0Ywq85li+kXmefHFYE1VDkUacNh8F8/Vsg+3keiUcwxOZxQjSBNuFBBiFDUSIThrVpKOr5Wk7osP93e3BGOro7EWvKFwXMq8H9DteZy3kJYPfeoY2d0mek2C3etyGumTkHXA9qlPHt/KFJ5VxreIQhC4P3oORUKUxaJLIm3rXb2kGjt525zO8j5TgIIbBfbzpP+w68igB9GYX1xKOWtsbIu+goUetts8/zt2ZkK72CaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wgzCjs4oUlH1HTnxOUFAu9W2rMh9dV+Wbcp8gTlzZQ=;
 b=MmVFzQ03Kq7AYjtg0aUUpfKH2hUNzvLJE2uUt9r4bcNiJoG14AWZSopdIx9j2QPpKpV5zTQdhBq1Q1ApLqEBnTUrMx+149XW7PPBHk1KmOk32sCFldvY+ffgI/01Sx764rFMQrytbNhjteKYHxAbEO5U2IeDA1O5Nzr/zNT4/I306bivW6mF/ECSeQHgk5Bg+VJSh6dEpGIMXW/vQfpd+MjL+kWG4r/89QAcpnILcNCzXmR/7WN2ZAScdhsOTm8EKMt3z98D4eW1xxFRQMd8AjSfy0Tgb2n9xTIDABNFQGi67gvJclhnTM0nr7DE1dQj+Ge3/bOY1SOY8IOjVKEzlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wgzCjs4oUlH1HTnxOUFAu9W2rMh9dV+Wbcp8gTlzZQ=;
 b=NQUq2ezwTHNuFVyUYoL6WuecfrYQR1QheYIvZzzY+rKTiwXYsgmq9WSMlzf62/EIRQX8fXbUfDAlLV8qRk8Vp8hCahfnd3FN/Oq+rBJWI08MSy/PxdmYI7PGjxKxCGYmNODMF3IIFG76I7GHVW4l+6+chIuDg0oMfFVXIKN9YBNoCm9xeqpelD8HUwdx1nkEthdILDnKYaqjogc5NDWmpUizLfvwvkRpy7AysZa6vwKJj8iWANrt5d4GyfPUuSAWm/NLV/+gmUmLoZXbRx9Qb9aLIZQkldlnjCVB6cMoLYm3seWFZ0WrsGeL0xoCnyud3y8BSYX4CdfWz7mtfmp+YA==
Received: from SJ0PR03CA0156.namprd03.prod.outlook.com (2603:10b6:a03:338::11)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 08:53:24 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::fe) by SJ0PR03CA0156.outlook.office365.com
 (2603:10b6:a03:338::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.21 via Frontend Transport; Mon,
 11 May 2026 08:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 08:53:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 01:53:09 -0700
Received: from fedora (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 01:52:56 -0700
References: <20260511033923.1301976-1-rkannoth@marvell.com>
 <20260511033923.1301976-4-rkannoth@marvell.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <oss-drivers@corigine.com>, <akiyano@amazon.com>,
	<andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <brett.creeley@amd.com>,
	<darinzon@amazon.com>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
	<edumazet@google.com>, <horms@kernel.org>, <idosch@nvidia.com>,
	<ivecera@redhat.com>, <jiri@resnulli.us>, <kuba@kernel.org>,
	<leon@kernel.org>, <mbloch@nvidia.com>, <michael.chan@broadcom.com>,
	<pabeni@redhat.com>, <pavan.chebbi@broadcom.com>, <petrm@nvidia.com>,
	<Prathosh.Satish@microchip.com>, <przemyslaw.kitszel@intel.com>,
	<saeedm@nvidia.com>, <sgoutham@marvell.com>, <tariqt@nvidia.com>,
	<vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v13 net-next 3/9] devlink: pass param values by pointer
Date: Mon, 11 May 2026 10:52:09 +0200
In-Reply-To: <20260511033923.1301976-4-rkannoth@marvell.com>
Message-ID: <875x4upbtn.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 292b0bb3-4b8b-41e1-4a8b-08deaf3ac1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|18002099003|3023799003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zxd+WsW+5DLWx8RPzCfBexSf0ODcBNhmpS/ASt1Ie4mUueWA0kWJKz2shxACKLdgZLgvW42YlEzuGDWiiVKYZ9MkfevJ3Bj6x1jWDWsfjE8azcQpLWl79SwBY5EagmBBc8b7s9uE+3XuuRvVRSg1Y5qjBP8s/V8lIWOHmJyqCNuFn4Sbc2YEhTvYKxeQNB5lL8/Yu9QxK5YPknZVCUAZOMtLtiDXxY+g4Iinl7q8q76Eg+Xy7Jq3ae9ahhbWQuqGDCGPNFXDE8tKPqrpzSnC+85Hsf6sMpoxleBPgX77Ae+eEq3RaX47gW+yvj2DaVMHGwvnmxP9VmM5u40kdUqKYxQsVYgsPea/F31TwKSYNXwk2QlYAUJPmQ0Wo8mTIF/s/qql3AKEFvz1jY6gpTT1Eq0W8l03sSgGMWhFTeLZ4r4Npc9wKQHqd7heLvJTvjX6YPlV3pxZrBLcl3XkQY5Ey4zB4rdcaaeDhLyLY3I6pIGlB6d9Tjj01Pj8yZq0Mvb4JWOOeOGM3s2qZT+1ePK2vUcJ9FVLQ1qVdhQrdK5abNbqOQw+m4Bl5UhdZrm+JEUe306mbSW+6A1y/dAt6G2UkuptWklQDfmnk9S1sDt0rSniJMptzkg8+7xij5geD2B02+6wRRi6PQhaA4P1ueHuUUhY662MK9jtzzi4BLl8QnjsZaJcX2czsR094pcRz21GwCZPae1QuErh7IxGIMpQf2abhCnT2QrwK592zbUfJ1k=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(18002099003)(3023799003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iq4uFMI/omVAf/HEIf4geZj5Q4M3F0nBQoaIPwM/vJFllToWK/5avJlILiO2uB/UjwvfA3AG62fNKgzetGu7XDU3ABXaUcEm/SFmjqsulnMhEBIfM4SAfr/S7YducH7r6Dhg8Hh8QBk94IO4ewZZpsAur0pr7xHddwutY0/IneUah6RTS2mBJX7vrQzt8eXadvIAHtaNPWxUQaDF/mkqhYvQQZUND+HNs1DvpH4wFTW6+QGRsV74TKWacYD+koL20TFUH3tK4hlulkzsb+EOoRpnRcaKcd40CkJYA/ldqcFXTTv7iIUHGaV5HPeGs9d7KtfRWgqvUhrs5OimSAM1PmMDawRfIdtJ5hEMoN2mnS8Sy0r/kd6ilIZaybX1utVqELn+qiB6cvWL6/3XBksYGtzYbwMfN2w9xtlDxNHWBsHzuClQfy37Tt6o643Dggnl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:53:22.6186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 292b0bb3-4b8b-41e1-4a8b-08deaf3ac1be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596
X-Rspamd-Queue-Id: D5B9550A780
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[vger.kernel.org,corigine.com,amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20375-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action


Ratheesh Kannoth <rkannoth@marvell.com> writes:

> union devlink_param_value grows substantially once U64 array
> parameters are added to devlink (from 32 bytes to over 264 bytes).
> devlink_nl_param_value_fill_one() and devlink_nl_param_value_put()
> copy the union by value in several places. Passing two instances as
> value arguments alone consumes over 528 bytes of stack; combined with
> deeper call chains the parameter stack can approach 800 bytes and trip
> CONFIG_FRAME_WARN more easily.
>
> Switch internal helpers and exported driver APIs to pass pointers to
> union devlink_param_value rather than passing the union by value.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reviewed-by: Petr Machata <petrm@nvidia.com> # for mlxsw

> diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
> index d76246301f67..308d8a94865f 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/core.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
> @@ -1306,11 +1306,11 @@ static int mlxsw_core_fw_flash_update(struct mlxsw_core *mlxsw_core,
>  }
>  
>  static int mlxsw_core_devlink_param_fw_load_policy_validate(struct devlink *devlink, u32 id,
> -							    union devlink_param_value val,
> +							    union devlink_param_value *val,
>  							    struct netlink_ext_ack *extack)
>  {
> -	if (val.vu8 != DEVLINK_PARAM_FW_LOAD_POLICY_VALUE_DRIVER &&
> -	    val.vu8 != DEVLINK_PARAM_FW_LOAD_POLICY_VALUE_FLASH) {
> +	if (val->vu8 != DEVLINK_PARAM_FW_LOAD_POLICY_VALUE_DRIVER &&
> +	    val->vu8 != DEVLINK_PARAM_FW_LOAD_POLICY_VALUE_FLASH) {
>  		NL_SET_ERR_MSG_MOD(extack, "'fw_load_policy' must be 'driver' or 'flash'");
>  		return -EINVAL;
>  	}
> @@ -1337,7 +1337,7 @@ static int mlxsw_core_fw_params_register(struct mlxsw_core *mlxsw_core)
>  	value.vu8 = DEVLINK_PARAM_FW_LOAD_POLICY_VALUE_DRIVER;
>  	devl_param_driverinit_value_set(devlink,
>  					DEVLINK_PARAM_GENERIC_ID_FW_LOAD_POLICY,
> -					value);
> +					&value);
>  	return 0;
>  }
>  

