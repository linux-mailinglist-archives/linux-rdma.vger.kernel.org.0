Return-Path: <linux-rdma+bounces-20300-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HxzVELdXAGpEGgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20300-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 12:02:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DCF5037CC
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 12:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADDD5300C918
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4651287268;
	Sun, 10 May 2026 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Euak2/Cq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013057.outbound.protection.outlook.com [40.107.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5725119EED3;
	Sun, 10 May 2026 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778407344; cv=fail; b=XvxVVxqc5S2gF43JVnPn9Pkbfq6xgOv7E7t/lMlHciGFMKlK9flqHXYyMAGKl8XBxLR2nlA0GS7fpp0sDvu91D/VnnIe0/+M7JwPTGE76I3tq9oSIpdfeqa4NiXW1oBEJoIDONs9FzFsllb9fL2YS8vv/OOkNG3+Dwubfgv+PgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778407344; c=relaxed/simple;
	bh=Gn+hMahaZY6YDhBqMydrOgOWEUNc6P2QGG99UpESDso=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlH2km/BtoieOpy1WlOr+8y95fZ+Hkld4mDj/1214HInilD0umCfUpMfiDUtFEj/tt17Klm8MyJo3pThD4D3MbLq5SZYpuRdsr5/fyuQmdrGolJSzySYlalANWjh/w1dvfeFqP+AYAhwGY8gwVMgjz/9cWUFFXrDxselfCILQpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Euak2/Cq; arc=fail smtp.client-ip=40.107.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgW3ZurVyX35izYh//9w6sToH0RAud34C0MCBgtk7oOcr3ZOVkft7lvT5OkWg+eQXv1SRshg6RtDEPzM4QUZMRboKbEsmo/F7juDR70WPWy/whAXmp/A4RTiOUvlGuK1Ir0vhylCxbpwRrCUMs4E7Um/vn+yXYccIVbAj8ZL0QzaTZvd2IbkOWaNhoyqhlI6mVfI+tXrU4jQ7Y4OKGFt1VzTPqMgOgcL6xlmHZFXNsFjks6SaDnDhhcXkYGa9OCO09mrqBWGZ5h8GjWEw200k0iOp8Hiz1QoM48Hd+KW7fsvE+Ow92NOyi6T+Zax307z4S1bpG0W8vaQjSVLl8PsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywdkWz1PzxZJjin8n0qhCo17Lf5NTfzpRyCEXrdu+iU=;
 b=FMeM/ybGjbkyPrGQl749anknPaRtmfcKJJTdS2uPP6GPrZw3mz586Ohttu4NTSDt5Kr6KK6J1o0/+O+47rknEAVe9+0fRoQw9l9Kvoeo6qC+dFfD2ryYG+9ibXBfuOfs/U2J600dpdVK2dAZoxrMv+5q1uYMPsjQjoA5wA3jWnjyDB1j5ViN3ZNfXmQ+gZgLTL234WIo1M7V1hcaqB96F8u2FmOANCHtX0t0yg/S63aj9iRz9Pe9IFlFi5pB6lVG6bi0J9dXiW7qHkUDR0XpcM+RDZQvXeugebEP3Bc5bG/lRWG94NdIvqXkWn58pIC241jKB4ka4brL9uDqCqw6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywdkWz1PzxZJjin8n0qhCo17Lf5NTfzpRyCEXrdu+iU=;
 b=Euak2/CqdJ95j1kP1OLqmA42bdG9p7vmXml1r4zWGVsSBwBilxun/nl+lnjD+OnHLAafmECilQM5VC0x8yCFgdDTZKBFWqeibUn7fcU3HPR15D7hEeQG/hxl10t04QNN4YdNXLhaFVOr+DCEG5NMGdtlsx7bMPwYz4wUTDaFdrPi6BJ0xidh38fsZtyOfuXj3czD8AAoCo+PEpmk4uxVG5hzOXLQcBpv3bEKbcMRGoWqU7Gz8neXnNUdqIrwSYEPGncD4Io4hPDlZtc2JMfrw3KJfpxl4A90NvyCXst+1LNxjBNYDO50QoXingiP/OLJh/ISvKsXfGwD6Lvj+ZVQuQ==
Received: from BYAPR08CA0024.namprd08.prod.outlook.com (2603:10b6:a03:100::37)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Sun, 10 May
 2026 10:02:15 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::3b) by BYAPR08CA0024.outlook.office365.com
 (2603:10b6:a03:100::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Sun,
 10 May 2026 10:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 10:02:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 10 May
 2026 03:02:00 -0700
Received: from localhost (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 10 May
 2026 03:01:58 -0700
Date: Sun, 10 May 2026 13:01:48 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: David Ahern <dsahern@kernel.org>
CC: <stephen@networkplumber.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, David Ahern <dahern@nvidia.com>
Subject: Re: [PATCH iproute2-next 2/4] iplink: Update iplink_parse to use
 netns_get_fd_pid
Message-ID: <20260510100148.GC15586@unreal>
References: <20260507150836.28105-1-dsahern@kernel.org>
 <20260507150836.28105-3-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507150836.28105-3-dsahern@kernel.org>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: bb06614d-e9c6-4892-fc30-08deae7b36b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p1bPcG5RydzOQ3DLPe96s2bX4FaKIO76epPsR3hzU6cS0j/RIyY4al5QkbxFnPgP0cjuNjYO5bIktzjHNlWfQi7qg69nKuCKDwj+fHuKZ45nwy3cWEalOqWMeE/p0jDkXPvpfESi44VvZRtPguMTN2B5lbvny921pJp0aDMQLFOyTZjwCk3Jq6/7hdNa6OkxkitaPboBsJGeZaV658lanlngCIQWMTk2RA08g4o17WSjbCTXisj8+yT7ZP+37dvaTldkr6ctgUxwqPer6QoJBYuULKLt7fPdJx90d7XGswkSNnj4eMUwJkBvF4L+xN+G2kp2ZvOBFm2Iye+lIr4ALGxTPDbwf3bFIphft5i8F4tfWIgNJOJ+lX4ECozWUwd4LBq6ZAc5wZuvL+bbcph8+vCLh6KZJUXdW6tLASkVFCKM6zo+txiGdB0furDPlR4HwEDHt12yG2Ky/Sm0mkRGYRhoRTOkFX/2bHXyYE2uj/Ktbmr7TRE6+Mfscy/jnLTj6lhGbpJxLNj/BoFjNv3Msxh3ShCmEX5Zl+7LhTA7nc/3xm+n600FoultmutY3ZIyg5dKlHmOUdSjdJjYq7PGnuovPE0LwND/yJN+CKF2EOx7sK8Ow3HrYNesKsrsih2HNrW79gXbX/r2n5fsrAoIXxmnyXo+VSAAXFGAZkh+bxQKZL4SmfsL1SVHEDe++US4PI6Wui0SvQKnaJ7XrRVmZzWE5o0Lqd5y7ZvBOmzqOWw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q0Q65SkoEUpwKGjmLrjzyoeZ2o+cu+btylY6ADms/gAiY971QHDuvJSDTQhymo8myStfjHVEZYwCQuiXYUMwYwLf+LuJRswGNC7F76YKK7UjIcjmqO/H6xjm8MkwxLCAMlMkapqV0ra1pKessUUtsJhJP3MwktHm7MgKWAyYpsA6U11mAHXHKN8KscGrHT/KOj5IFwAC72XWW0tgi4FmrNuH9PeXgDLJZ/dIJg2FNdbtlX/lkmKPp5tbu782g64PPDZY4qX+vyH4IYfFL2PiNXH/DUtyVDccT5x4aNxouCmJrf319nG2ECuQv6nmeJdhgtEG7IT7WZj7EuX2XGt/pZTAgQcfh8atltVi33vJQZLB0ORL73yTDE/565e4xRUWvV++dzM7E6aX1zFBEY0NE1euKOb1IoqbaCRSz1aCq390hsxSiJ71mn9yUgUG1Ymt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 10:02:15.3830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb06614d-e9c6-4892-fc30-08deae7b36b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
X-Rspamd-Queue-Id: 87DCF5037CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20300-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonro@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 09:08:33AM -0600, David Ahern wrote:
> From: David Ahern <dahern@nvidia.com>
> 
> Drop the open coding of proc/pid/ns/net in favor of
> netns_get_fd_pid.
> 
> Signed-off-by: David Ahern <dahern@nvidia.com>
> ---
>  ip/iplink.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/ip/iplink.c b/ip/iplink.c
> index eae51438..6c4586ee 100644
> --- a/ip/iplink.c
> +++ b/ip/iplink.c
> @@ -650,19 +650,13 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
>  			if (offload && name == dev)
>  				dev = NULL;
>  		} else if (strcmp(*argv, "netns") == 0) {
> -			int pid;
> -
>  			NEXT_ARG();
>  			if (netns != -1)
>  				duparg("netns", *argv);
> +			/* try by name then by pid */
>  			netns = netns_get_fd(*argv);
> -			if (netns < 0 && get_integer(&pid, *argv, 0) == 0) {
> -				char path[PATH_MAX];
> -
> -				snprintf(path, sizeof(path), "/proc/%d/ns/net",
> -					 pid);
> -				netns = open(path, O_RDONLY);
> -			}
> +			if (netns < 0)
> +				netns = netns_get_fd_pid(*argv);

It would be good to have a single function that handles the entire
netns_get_fd() → netns < 0 → netns_get_fd_pid() sequence internally. This
logic is used by at least iplink and rdmatool.

Thanks

