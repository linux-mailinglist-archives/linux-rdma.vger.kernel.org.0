Return-Path: <linux-rdma+bounces-20542-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMMaOAYPBGoMDAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20542-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 07:41:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC25252DA3D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 07:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9255300F2A3
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 05:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DA53A641D;
	Wed, 13 May 2026 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LIvh9xI8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A51E3A63E4;
	Wed, 13 May 2026 05:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778650879; cv=fail; b=cAOlfzecghxvlEs+NP30k/rOIAClCUqzJgh9jRdpAheq240CiN5Ijx7iyv6pFI8K210MLTv1gRiqqWWkzNwFe7CCDWkNiuF05Fu651/2CJ7nbYRC1tAeMCXzLPmHMQT7AtFxKTebv/mn4STqY02WhMo98SMfG3mGjQGMFLk4dWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778650879; c=relaxed/simple;
	bh=ZTTWMndoWaxcFFuSbRBIATGykD/nmy4YDw0NRczlmG8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cndmTzzm8wOrkKrFCq22liSKXfX23C7THq6BN8tEeABJxUkaF2/bfHmTRYFJr6Rrfx4I0Oaomvu4YksOHgFGOT5YtfQyNp0KVigugsgRsbkDvKUA/QJ5Rx5WMAJ1oKpSjx9VfMAuY4jwVJ2ywSjeXy0Tued24JqFwUHOjzZ4SGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LIvh9xI8; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N40kxXPheWjchZ9PPmiUqmGaQ+AUh7+61Eo1i4yJ0/tLMy9VXtPmDiHOKniI4d6fp05+0mMtN3cInfUGCqJnRQLUGXArpb+jtMsqo3ZpIoL9Pcg+3FLOzrNdI14w9Sv9zgtchcdutSg4JCnRrTfcrWECMWc/1sbHuZg3oygVnBqJRBORmuV77wJx/gSDKfKCXGG29H2OQuh/nWyUctd9ZVdUsPWKnwv/BkLSgxeE9MqB2zWEoY4GTk4RaXVB3Himexe0qpMP44zVjmWT+gqvBbuc+pjIpYGdM1b5Mpldr9uQ7Tc2m69zZDazTCSxIFopctxHXJnfSWCmH+dsNG4BPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+ZT5XKq/vj3uKsNonKhHcit+O8kesdtnB3sxOHaFUg=;
 b=udoOr7CQUgGQe1uxPygUU6PMPL3EaJDUZ7qfPEfAFkUPYtww/K/SCaD0YcEKgnokUsZYHiazv33U4jZFUwX4eYyk/lTEzpFl6600OI8bO6+pi8uKp5byWc+lRdj4WXPVnHNBy29bfn7GSH+6tkRWdd70mObcBO0w8XSSJjkQH2ziBNBFEPFO5xSe/l7+f86Ynkg8176/ujEkd0TzuRWK2NKBAiA/PPc5RZjreVYvfQV5nePe8UkLodOjI8sve6hNOJDE8JKwM9MGX06oWHlk7PxFPYYgl5NiHeIu8Mr+bolwn/1dTqPGycm97ypoR/gOIlft3nh+bcqeu1C3xMoWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+ZT5XKq/vj3uKsNonKhHcit+O8kesdtnB3sxOHaFUg=;
 b=LIvh9xI8G3PayGGUh5boSPxcOFFcv020YM7qqQeswlBxcpYsQArIoIvPxm6BtNM5viRWvsTviuJoW46CdAn5X9Q1q87kdxU+hCj2zfBRRanSH1H9kQEncixKuY3IDazDvTpfR1dFtxlVZmvgRw9TmCL2vs4SsP9xCSdIzF5lrPiXrmWAa+tUXMLcoUMvWTrouNMW3mPvk9v1aM2inx9oMNYHs+uiKVlHpnR3ASgk80ELWEtxLQTuMxfnA1+ic5bFRmG6hEy1CnEm8O7OMQSV74VrVgwgKITa+K+1gDAHLoetAYEgW1UqUMmnjYOROrbuXfwWhTePuIq0IQe42L1Efw==
Received: from DM6PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:333::16)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 05:41:11 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::23) by DM6PR03CA0083.outlook.office365.com
 (2603:10b6:5:333::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 05:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 05:41:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 22:40:54 -0700
Received: from localhost (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 22:40:52 -0700
Date: Wed, 13 May 2026 08:40:45 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: David Ahern <dsahern@kernel.org>
CC: <stephen@networkplumber.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, David Ahern <dahern@nvidia.com>
Subject: Re: [PATCH iproute2-next v2 4/4] devlink: Drop now duplicate pid
 fallback for netns
Message-ID: <20260513054045.GY15586@unreal>
References: <20260512193412.32019-1-dsahern@kernel.org>
 <20260512193412.32019-5-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260512193412.32019-5-dsahern@kernel.org>
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de02cf6-6d79-4e90-6c07-08deb0b23d38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ytw0kQiGoLMGmTp2IM4shmaaIBCUlmedjpVibbJUFzFM/EevCKsObzReTocyb1zLzwQ6+W4VIKeKNvJOON9hkoKJED5C7U/7JCnko21kPVcPhYDuknr2YWUB40zRj/lNe12zfDdJ8duqWnJup436pOzdssaIhU9EccI/h+UYggNakMAGEKvjo4wlzAaAZ6Df+38YnQj54xDs7dlOw63qdlbl26KX1BQR0n0/Hce7QsxKAfwmqDjBpsY8D/UVngPwrsVcPNDEYuirTewgynGcS4y7eKwi5yKkJ/Ky1u9GzGSq45MiLlNA3W075J2m0h0V8mIzj02tPbsMT8zNDCGvUnfPniO0VJgvQIOih1VbzHZCyAyiM0WJiy0HeOuUvRpNkj8aeuyDyWpcmjuZb8FFBN0WTwxoXidb1DwNlodGjpXm/bjoJkEocEvriVNas58zt2jqMoH8pDz2F63XOB23d5X0ESYMnd+VoV71yn2q/P9/j8nn0/y/wcVGjy9R1/P02u/77Ex779ebgitZQS60MI2UPWOeVgj0JowlJ4AXdMnv+84IF3l0b4aTdIU12FznQMOAhv7gHo17PBkWZldOj01K9GYaIt9NOlYbUfl5o/wVLf4uXJ6/v0vl33sl0okleyLWuk0umlGpOxYpgOqnxer1t1GEhH/U5M1hMWfuw8gdUYyXAHhzxrv/OD2xP/cImY2QeTTnHGKYQI1hdb17SHBkCOMBQob4OXlb1bG4LeU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5gHghlffytcD8kVieQ//74qCDBz8z4sDltj7lfUXb1vg4WaoIwzKaPEYQQ1SmVDV5d0iINQ0P2xqHLAxgXM78QtPrRccsKoMtfY5CVR1PTzmdRSKRr96h4AOMaH+rAAlgdi1AoXs3ykblqu9LWB4C5mpg0w7vXUZnZBZ/6bG5jHJfGxbCphUc1KJvobYNEP4zfOHXYES7CK4oPtzvIDxO8N1HW27A2AMugLZmxCPsxF59NLATwRBH423IxNV/Myw4Wo+8jLq4yXfxfaLQsn/bfdikd9Q9OnlAdWDuhjqe/VgYzqfdHOJ34mO6WmwBkMpc5ubNblsZ40qr2FMIMohYvgSYqS++F9LEe9hom85KAW1Nd+v0K1KYvkFo5ooeevoZS6463wVZUSzS+JXibKQuOER94F5uIlnrHwd2bC3sDwIw9DfTxRRsIcCuI0ukXLA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:41:10.9588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de02cf6-6d79-4e90-6c07-08deb0b23d38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
X-Rspamd-Queue-Id: DC25252DA3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20542-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonro@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:34:07PM -0600, David Ahern wrote:
> From: David Ahern <dahern@nvidia.com>
> 
> Now that netns_get_fd handles by name and pid, the special
> handling in devlink to fallback to PID can be removed with
> both cases handled by the FD attribute.
> 
> Signed-off-by: David Ahern <dahern@nvidia.com>
> ---
>  devlink/devlink.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)

<...>

>  static char *dl_argv_next(struct dl *dl)
>  {
>  	char *ret;
> @@ -2153,14 +2147,12 @@ static int dl_argv_parse(struct dl *dl, uint64_t o_required,
>  			err = dl_argv_str(dl, &netns_str);
>  			if (err)
>  				return err;
> -			opts->netns = netns_get_fd(netns_str);
> -			if ((int)opts->netns < 0) {
> -				dl_arg_dec(dl);
> -				err = dl_argv_uint32_t(dl, &opts->netns);
> -				if (err)
> -					return err;
> -				opts->netns_is_pid = true;
> -			}
> +
> +			err = netns_get_fd(netns_str);
> +			if (err < 0)
> +				return err;
> +
> +			opts->netns = err;
>  			o_found |= DL_OPT_NETNS;
>  		} else if (dl_argv_match(dl, "action") &&
>  			   (o_all & DL_OPT_RELOAD_ACTION)) {
> @@ -2725,10 +2717,7 @@ static void dl_opts_put(struct nlmsghdr *nlh, struct dl *dl)
>  		mnl_attr_put_u8(nlh, DEVLINK_ATTR_TRAP_ACTION,
>  				opts->trap_action);
>  	if (opts->present & DL_OPT_NETNS)
> -		mnl_attr_put_u32(nlh,
> -				 opts->netns_is_pid ? DEVLINK_ATTR_NETNS_PID :
> -						      DEVLINK_ATTR_NETNS_FD,
> -				 opts->netns);
> +		mnl_attr_put_u32(nlh, DEVLINK_ATTR_NETNS_FD, opts->netns);

You can also remove netns_is_pid from struct dl_opts.

It is unfortunate that devlink implements DEVLINK_ATTR_NETNS_PID in  
the kernel, given that user space can provide this functionality  
with trivial effort.

Thanks

