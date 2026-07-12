Return-Path: <linux-rdma+bounces-23071-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EQFsEXVYU2oHaAMAu9opvQ
	(envelope-from <linux-rdma+bounces-23071-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 11:03:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AD27443A8
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 11:03:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=nB4XO0hQ;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23071-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23071-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE7713004F3B
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 09:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDC139BFF2;
	Sun, 12 Jul 2026 09:03:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013049.outbound.protection.outlook.com [40.93.196.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF0F846A;
	Sun, 12 Jul 2026 09:03:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783847025; cv=fail; b=En9utOKIjBIkpLy0zJJSzzgDEdGX+6JO+W8/Gv7kycbndNKCK4UWiW4r99pF+4PGpHBX/V3Is3SIDl3z9nmcPSe5vIwhruxfIjP2Q5HIp07EghUEgRdUKXy+TyTI2ZR9hR/ZFad7uoRBUT0HDo90iaNot7CG+FIikJjvzA6OsQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783847025; c=relaxed/simple;
	bh=BDnxVnJxBh8oBSbxYHNjvtdzZnleF5zXT8Wwy4gNHOw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYXGhMhkXiFhnIsifPBT58JelOAIOG5fDo4vF92Nv5sUJszgiX7z7J4fyEYGxliIxvTlHtykikdQSiITXhkn9twtRk5U3Hl1X8U3UT3iLFbQubKAcKzFH2URUKM5Gj5XhwBoSA5Smw6JGlZTBro2+Do56UXSFHEIwrBmouhyuEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nB4XO0hQ; arc=fail smtp.client-ip=40.93.196.49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyGLx4MDe88RXY2dEFIGvELwNCeFQPHBJxrtIf1DTrZU5Zt4bOX07UUYA0IiQftq38LSHuPpc0MGHNgK59efq14i1ugLnifKky6M5VBLo6Mz1I/Gkt7+vs1CWYWYtgVT3gTn5k4LHjFpWA96gvivARpUsa594Mq9KPYmFLY/jmuVkMLQTZYYlUMtq/nlEDXNW90Cms3TJoixUpwVWeGfM739timVZtCRNwAdU/mI1PL/hrRNYjm3X+a0azQdn87sd2KwDAY3UnlOHVwBdr3C0r9H/Y66FEdr2ycq5kvFuS+9aWRxDwtyVokEqC5YYLeeGqEDfPsurTnERfRKVvBR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI+cgZ7nnHMavhwYNiH7apXyseO/smSbc2RaICcOLyU=;
 b=Q2vrXvSmpKF67hYxr743MbdCLJpsvuM4MG4G8ORG8O44g4fzPYa1YCHqyfsHvNWp5RE3oaYIdUZ7HFrThPsCll48kAOQZaZLBnhukMSNiPjcuAgfFbGncaw+7QS/dMc/XGwwAk+zlzhVPzfcVIINGYPTD042qsrlSxBaJNLmyobZMfs77hdK9EgtFdEavGnxl6UhgeiiXgWLq7/rKfbKz4yCBLgjNG2SGJUUDF15BH/EChpesBvju3/Qw1h3WJehq4DzT/Yz8Akwg5CmLs677Sexdk5hgjddo4foOqExVZOpkmVF7u3BpNV4hEbOZbo0yueQIcprC654oZR3+swy+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI+cgZ7nnHMavhwYNiH7apXyseO/smSbc2RaICcOLyU=;
 b=nB4XO0hQTKMxgWFBvs7511jWgC0HMFftX9Pm2fBwpBzvX4wIyhw6A0fNneoHSq4eBbKeuLEE7vLtrWvQLZEhxN/YTveb1CJYSANcP6lxtGIgzCOfmBI7Fe1cRHhKDRkvHb4M5dmOrTjkYOFpmVgduGMmbyrIoaWWVAiewGsMSAdhA1xgx+DGTqchwjXZ77BCngGFLzpA41p09ySVE6so9Vwq/xd0eJph1TBtTeYLObzGKA8gLrT2XLvJ199IEHljC/Ywb53r3nqHpEe7BaGE1F3eYNJW1J+FO/L8sN3GE/KXApSs6H6l+gZpxvgiewLy1HLp1g61RXHvV52s5rVK0w==
Received: from BN0PR04CA0049.namprd04.prod.outlook.com (2603:10b6:408:e8::24)
 by DS4PR12MB9796.namprd12.prod.outlook.com (2603:10b6:8:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Sun, 12 Jul
 2026 09:03:39 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:e8:cafe::81) by BN0PR04CA0049.outlook.office365.com
 (2603:10b6:408:e8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.18 via Frontend Transport; Sun,
 12 Jul 2026 09:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Sun, 12 Jul 2026 09:03:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 12 Jul
 2026 02:03:30 -0700
Received: from localhost (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 12 Jul
 2026 02:03:29 -0700
Date: Sun, 12 Jul 2026 12:03:25 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Tao Cui <cui.tao@linux.dev>
CC: <dsahern@kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <cuitao@kylinos.cn>
Subject: Re: [PATCH iproute2-next v5 1/2] rdma: update uapi headers
Message-ID: <20260712090325.GF33197@unreal>
References: <20260710011759.378893-1-cui.tao@linux.dev>
 <20260710011759.378893-2-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260710011759.378893-2-cui.tao@linux.dev>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|DS4PR12MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 391ab070-79c5-4781-32b2-08dedff47600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8vU+dioPJRguvvT3dtg5KXmazLcZi3gf8VwJ9S3b9m6mjFE7a90N1GU8HzcG8NVotwz80m0pwsMvHtw/696vu2ME8LoVSh1I7zpz7oDWL5OG/uFT/S3bUfO5Zage/3INn271X4sKLbev0VNwEyB95bjYAnqP06Vg7dzil9R+JAcnuHvOB/fY4NxHi2J0oxEKlaCNryPNja+xqtu5QuV2ZE3YXlzwuApZvq+z4DWe1XshB+xRwUUZVsk7Epumj5P0sraRM0tl5xLJ2lyoXziCq8pAZlG//1gt/PDNAkEObVPJ3qVZRDAIt7aIlcNVaJ2vWXIsqzTZ5HdSs01d6gchfVPxPDVAYKcTVd0Vz2UoYvAZg92zf6NreSfxZLlSAtIfMb90nRh023UbzPcMwKngtDdy9NijfBlDKLGSYFgZFdgBjhrB0fYsqNa4/jggQOTrnF7eowN2PGQ8eYVd6O9/f58CHs8YB8RPWOFmR/H6Au+SzRPADExZvHaQjiqqrxr1sQderdnb9cnS9Hknotar6xRLXCviUDWISAguZ8pCnLu5sKTT/2s++EJ7EJBwg9h2LFi+3Sq2d4W9WU1EYXaL3UU7oQ90GDY0oOIdQv0wipsab0/Usrtoi9RA9mWmr+Q2qxGGC61GiUD1dOXS1r+GIvzgVcLjjMF8XcNnew0LlKPfJpxKu0y2CtXUm5Yid/CeblyrQCDeR6Y484ELpqRsHw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lVME6LyR/0U32bzFf+PYq6MIXnevg2uROrwUoUEvEcmhppF8v9NuE4k4mf5pEtx2kgvLfthsTeiGHv2TmdH76KkIUI0t48iHB9tBgL7Te8UuRPv5WlFdqfvrEhPrvn0HCyLJKx85uv3ehYJlGetIiHrwKViDjgDd1cCFJRJF93H3oh+7nQxf1VJG4Kxj0BMD/F+jvrAsK8xhuy4ir+dOCoNhvac79ffZnzEwqzEu3NSnT2ZDh5Yb5MrloeLfcsQVNjXTrFlWHK8zKkdjW/VH+kHM5RP7MWUKBzAWiard0ILHp6tHXTqBQfS95+o2nCL+EgQkAODEHQ1pbRGr6YH7KIZMG6+KECwJwFZ5WdqNtUL7tdi2qdutjVBASeS0GE6Xawu2evStpsISFLc6nhptXHRSa5kK8n/56l6t5+nU418kaAN+dOD/yHmAW3HH/7as
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 09:03:37.5952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 391ab070-79c5-4781-32b2-08dedff47600
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9796
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23071-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:dsahern@kernel.org,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leonro@nvidia.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,unreal:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonro@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8AD27443A8

On Fri, Jul 10, 2026 at 09:17:58AM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Update rdma_netlink.h file upto kernel commit 5911f6d6e7ce
> ("RDMA/nldev: Add resource summary max values for usage display")

This SHA-1 is incorrect.
5911f6d6e7cc ("RDMA/nldev: Add resource summary max values for usage display")

Thanks

