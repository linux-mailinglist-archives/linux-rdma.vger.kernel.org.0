Return-Path: <linux-rdma+bounces-22923-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ytTFHVBJT2ondgIAu9opvQ
	(envelope-from <linux-rdma+bounces-22923-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 09:10:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F3F72D796
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 09:10:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=AxyQrHO6;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22923-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22923-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6563D3047BED
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 07:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8353DCDA6;
	Thu,  9 Jul 2026 07:01:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09347396588;
	Thu,  9 Jul 2026 07:01:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580512; cv=fail; b=vF7Dvw3uqdhsw3Vkfq0g4ucj5xbmtTm0AjpCst3Xg+2U0jJ3pbDGdNbwI6tEYVhAq5UYQyQPblr/bnyupM9v7quPjsbdKNahFYdWo8i8Ahk6+Ra123KGye2clEGIYt493hONYI/+LmFV3u/ci/S+P34ztRMWW+7VFSdiVKSkiyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580512; c=relaxed/simple;
	bh=yMg7h5nCas6aBpm+26PRM223czjoDmfxVgvG/agLc+I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=forg/aHAmwWYleD4dj6+9z+90J1qbz4qA6PadLtfjYJsE6zJZynINMA3aSEeZihxu6q6oDsAjv687szlKG3Ya93dYBtl6LaT54zPDL078s+IjHxZHFlZEs9xAQLDS4Td1aAlSeqB4lhXC9OKcSWWPIFfS+/GWDMTZtpjnbqRNOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AxyQrHO6; arc=fail smtp.client-ip=52.101.46.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYPoQSfDnIn6E3FeWZ76M3KW2BjDgcPYmDsMLF4Br+DzhtrWPuckgmPFhBE2hmSIrFeNbZY23q+8Ql/pIY2IPq97+8VAbkAmcAonGvBNjELvLfjpH+5k23Ku2RtTetPf3K2r/D2cUEM6NW5pdu+pSGoBEvWQeoC6vntsNH34h2BneHnaJsoBLrNTDN0jpilFNMmFP97womPoer2L5g13p8t+9enNCRbEG4S3NJDoE2to8Gur15ldYBauRAc+o1fuC0ERU52vWlvD6lGg2bkX8dRTbWKBvfnJPR2pS2CFpv+4epRj7ghzjLjHRHYQW1MkOoCtGhuC+PpviEMTGpPZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9I5CfMkBU5Cj1dRg5FR5POJz9qFu720gKygiPEbDCg=;
 b=cek1gRArmIFfjvkvt8fYMfTogjk2MobMR8e7RAHp/RrY4Bfq3dIaGN/fW677P2SDFPX8ymLyRGpZToh3Lf7QKecjExAqxvabcfSPK4g466TdgTpS5IeZKo6HYq9yQaflg1k9stNSFm4aOUcXLpJbFQunj5dJS7KC1D16YXxCPfF7QcT3O4p5oPcbH2YPzoTKiW89MViV/43ZMZO0YxwaldY0vHDaz7aY/J93rQC8ZwgDB5du9cvj0puAq0nLYSyDuN3u2mP+sa7g54wC/thruAsxA6hTZXhnfBpVN8hP0+LOzuyKqIKtULC3EEvwXXps32WR6lm9JWNd3O9+CKFndA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9I5CfMkBU5Cj1dRg5FR5POJz9qFu720gKygiPEbDCg=;
 b=AxyQrHO6V0k8q908XEwaRRxtoyaD8xueSqqiIXpDqwqilixFeVJrpnzzF7v51oq8+qcQqoO/yDKEdJylu1kiB0TPJMcPPNPBdIiCb2zjMAjCo4w+XJIRFprhb3TyxEsNEilSztIGuc78qBrtsAS9jorG1f/04o/MFI8A1xumU1OqZGw1fS+8XpPs3jIbHLQqZXBrBfnE9i0Fu/6nx8qefypjW8w6CxEqxt0I5dwgrX9rBtEioQ3DTp0s3WhUzTQ4BmwE/AgSnLRQXby+Q0zObVuxFqMbHuekOhNp/P/n05tx9cI6tzsDZ8jy4pY5jtVl43CLJbQIhx/q+Qk5gGYOIA==
Received: from BN9PR03CA0500.namprd03.prod.outlook.com (2603:10b6:408:130::25)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 07:01:47 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::8d) by BN9PR03CA0500.outlook.office365.com
 (2603:10b6:408:130::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 07:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 07:01:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 00:01:24 -0700
Received: from localhost (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 00:01:23 -0700
Date: Thu, 9 Jul 2026 10:01:18 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Tao Cui <cui.tao@linux.dev>
CC: <dsahern@kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <cuitao@kylinos.cn>
Subject: Re: [PATCH iproute2-next v4] rdma: display resource limits in
 curr/max format
Message-ID: <20260709070118.GP15188@unreal>
References: <20260708134003.85505-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260708134003.85505-1-cui.tao@linux.dev>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: bf60a5f0-e2cc-41cf-d339-08dedd87f133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|13003099007|3023799007|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hLBtgqk69z9+A4tHLxnpvzVrurYTZZrGqIWr4nouAAxzEWpyD0AEf4/2jYTnGJSiOAjIiDBgeFx98jDm+fYDmyEB4VTgTrf5UOUiONI/YMmEw/tIEgLcLBlUbPNxdVv72Lrklbooe4lf/tlHMFVwfpjyBECRbEqqqH0ULDKIMLO75E+hpFt09yGQZibkYFXe8Ev3zNS56vvXWYz/aZEYu4GmQMAp9NsIyLVkDv5/pe1BuhkC8yZj6mrvByzUgZLjlgi5g70aKVwLIlhkB/YO+JTHJs1sjxLOS+cROfh1mkaMkXlIXiqFVUHixTcEPMgPCVDNOSBTI+FoQZXyWcZ5B7viXR7xT5vGuRpIjrXaA8cwauuBbN0QgEcdciTOfqkOefhBXMpw9CenJSCGAur09cMH1DCDdognAhw7RKaa7KXLEfLMZErlSMUd4hy0suB779/VUd4s8w0OHRrTwSKyQ/i4BVGz9/VliHMv4+Y143GjpN0YAU2CLUlYiv9sShOFnC1n7Mn0utyqgeAnAb9h7U+0qGqEZdWlFpWDuX6usQz32SIZSVhbVb/AT+2SG/wypgZWKEg9hfUcVoe8q11CvGvm67dpgRoeOnLrIV+UIo+93ho9rMir+kW2VqYJYYd0i4utKm+HLdMYG/G35j7NwGSZNLROBzUnftpu2Qj7hAf6Uij3/+mo7SUPZpz3vusPkMC9Qh52I0conY6uEQvPAg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(13003099007)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	42t8TKpZcaPYQWNI3ZJxCOhkQtSEJMAhsrQEwj22U++MzOZAyPN+0O19I6IzYe2NbEsVLMtZfor2Z4ffNYHgMAipKWbzr8YYMjH4SRwP43F96MpmtBTpykH3NIRk79X/zZKjyfQz2bt+u1FEb1UObUDI6LI+cDrPVyvHs7MMGvRYGPMwTwXJT1S4NxH4/BVoZnNHE7Ga5UvmE4do/qJe5bszWzfiPWDNESVCpLocUkQnGP4y0htJICPmf5fzRHO5u0vpB2uSA3Yr8wft4TFpL68uy1ehXPB6qcODequB1ZWFzsTYNMN5JJNGsTyCJLa5JumqNybEgjZxPNL9NWqa0Mt5NnAE+wdbi/wp6HAkrjuMVeY06+fqauT72xvecAFhnT/GS/DdsB5HuH2kFuw/asI4nerIvgZwZt2E5ajZ3Q5xeHl2acG/PFlw3Auziqr0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 07:01:46.8189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf60a5f0-e2cc-41cf-d339-08dedd87f133
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:dsahern@kernel.org,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[leonro@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22923-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonro@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8F3F72D796

On Wed, Jul 08, 2026 at 09:40:03PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Parse the new RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX netlink attribute
> to show resource limits alongside current counts in curr/max format:
> 
>   Before: 0: mlx5_0: qp 123  cq 45  mr 200  pd 10
>   After:  0: mlx5_0: qp 123/131072  cq 45/65536  mr 200/1000000  pd 10/32768
> 
> JSON output provides both current and max fields per resource type
> (e.g. "qp": 123, "qp-max": 131072). Backward compatible: no output
> change when kernel lacks the new attribute.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> Link: https://lore.kernel.org/all/20260615003646.168704-1-cui.tao@linux.dev/
> ---
> Changes in v4:
> - Add Link to the kernel patch that introduces the new uapi attribute.
> ---
>  rdma/include/uapi/rdma/rdma_netlink.h |  5 +++++

Please move changes to rdma_netlink.h into a separate commit using
the following format:
https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/rdma/include/uapi/rdma?id=85860c7dce2ce742ef0c6879b5c5bcbcecaaf717

Thanks

>  rdma/res.c                            | 21 ++++++++++++++++++++-
>  rdma/utils.c                          |  1 +
>  3 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
> index 4356ec4a..e5b8b065 100644
> --- a/rdma/include/uapi/rdma/rdma_netlink.h
> +++ b/rdma/include/uapi/rdma/rdma_netlink.h
> @@ -604,6 +604,11 @@ enum rdma_nldev_attr {
>  	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
>  	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,	/* u64 */
>  
> +	/*
> +	 * Resource summary entry maximum value.
> +	 */
> +	RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX,		/* u64 */
> +
>  	/*
>  	 * Always the end
>  	 */
> diff --git a/rdma/res.c b/rdma/res.c
> index 062f0007..046935e2 100644
> --- a/rdma/res.c
> +++ b/rdma/res.c
> @@ -55,7 +55,26 @@ static int res_print_summary(struct nlattr **tb)
>  
>  		name = mnl_attr_get_str(nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_NAME]);
>  		curr = mnl_attr_get_u64(nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR]);
> -		res_print_u64(name, curr, nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR]);
> +		if (nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX]) {
> +			uint64_t max;
> +			char max_name[64];
> +
> +			max = mnl_attr_get_u64(
> +				nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX]);
> +			snprintf(max_name, sizeof(max_name), "%s-max", name);
> +			print_u64(PRINT_JSON, name, NULL, curr);
> +			print_u64(PRINT_JSON, max_name, NULL, max);
> +			if (!is_json_context()) {
> +				char buf[64];
> +
> +				snprintf(buf, sizeof(buf), "%s %" PRIu64 "/%" PRIu64 " ",
> +					 name, curr, max);
> +				pr_out("%s", buf);
> +			}
> +		} else {
> +			res_print_u64(name, curr,
> +				      nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR]);
> +		}
>  	}
>  	return 0;
>  }
> diff --git a/rdma/utils.c b/rdma/utils.c
> index 87003b2c..90ea1c55 100644
> --- a/rdma/utils.c
> +++ b/rdma/utils.c
> @@ -480,6 +480,7 @@ static const enum mnl_attr_data_type nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
>  	[RDMA_NLDEV_ATTR_EVENT_TYPE] = MNL_TYPE_U8,
>  	[RDMA_NLDEV_SYS_ATTR_MONITOR_MODE] = MNL_TYPE_U8,
>  	[RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED] = MNL_TYPE_U8,
> +	[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX] = MNL_TYPE_U64,
>  };
>  
>  static int rd_attr_check(const struct nlattr *attr, int *typep)
> -- 
> 2.43.0
> 
> 

