Return-Path: <linux-rdma+bounces-20544-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCEeK5wRBGoMDAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20544-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 07:52:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F8752DCAC
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 07:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C82273000E0A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 05:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C933AE182;
	Wed, 13 May 2026 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C3rgf9If"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4663AE713;
	Wed, 13 May 2026 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651397; cv=fail; b=kzIabfqW8QDx71blTN5DhhwKP5XNvz11zkw2FcBQEpr5655+qnVbXnn74nBQekRXY6joKJTpSAHCU8IHtDAxMaCrAUmRPxudfgyydpHG67NAtrwrjvVjhW/Gtjne++SVZVLUBPf5yjOkRFGUHj4vYeS/CRlWSaoUSUfVC+/96NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651397; c=relaxed/simple;
	bh=9HNyrE3fXmdDs4IA1r6Ekcm4IAr5IMXb6DwuqMWcNhQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp248Sl+1oYCakfVl9FbovpQlK32L5hms3Ktw4M1I9QnHDqRWZPnr/00fu5CpmuBt5xoot1a+abGqMV9OFXhjVRg4nehHKlbEDzgt9RK4h7MnqOLTYi0sXaro5YYRY6Cbjat7AokkOSEEycQ/P+xiryZGedU9LBGyTauIl4Bkgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C3rgf9If; arc=fail smtp.client-ip=52.101.193.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooEUtnMdgeTKtKB1fa4/Y6mSiITfEUYPcFi/c5D28Lxz4iN2voUwVDC3WJzr/S0rbaPc3PDgmQt6mv+5u2HG9fRGZoEf12II49xALDW/LhjPNGqB5a2LPdcSYdsCI6dSDXJEX41SHshTAIfSjYbWJhHJ6/8LLfKtBn/FvPbHYRk/1C/QHND7MzmZWEG/HanWXlQNGEGfuHqHapm227ItYW8p4tJPs/6wRawuyDVb1hlEZ5OXcQl95LUBByocs8KnefaNgh0rBylN63+YV5UYo4pKb9odL8lX/O5tKcHNplbT5+O99sVjKY+fDcDApxHBvROxYOHGPdehKKDi/t2WJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJuJX9LGhNGD+uinkdr8E5AchnGR/ksRIfsJu6ZqFj4=;
 b=wTZEh3XcF1tPg2PXcyE+Ks5tZc3Lx/EQvjqopBAlrrCnWGr8Mo75GXxG9Gy0bsIgD1450cRl5AgxL0Xx1t0X/wCWfDzIFgGSezoSkrfbCscXuuPpqAmlgL/i007/CRHpjcxc5GfXmUbtyCg5aOidUWOu1WXz/4cbdmEUODSQzjmBDLHfBYK7BElCnd2mYpanPK3d9M4d37UtLISefmMBVNXthA3i3zu7vtbOIv+akXamexIvEsLdVdXitFmrA8Uc4ITI3h+VxZmJnSPK06tBRPHM/xMoDwZw+KlvzXuGb7KY6lta90hHj+r1M4WvP48EFNTaxTwU1zTuesJOS9wigw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJuJX9LGhNGD+uinkdr8E5AchnGR/ksRIfsJu6ZqFj4=;
 b=C3rgf9IfmVUnthPuMQWaTELWVYsFkoEMSKnmXM7NYUQK8TcrPefuUFlbKRVWz+cOTIo6CHCIqgM8O40lKUyHDCTlmPDrv3we5FIfE6ttsB9FCgU3RS14yry2hyovPrDVQo5A+kfLFeu3HEF1oT3ymjKqJY3VMrkeWPumH5RXYsF83Ebo68Rcd8Axxu+lCa+WNpaR8t7g4fjPsSszUQCTCXzlU0f9nEvTiiRMwlfNHJjPD0SkIMmBo3ibhSGNiCawpnnWMvysNndoPZlJ2Rv/pUsXtAQG0mK43IiAwUs6xgFfOIVoiilrjw7Q4WmT2HW7xG1Jtz+U0PddRP7ZgowUhA==
Received: from CY8PR02CA0005.namprd02.prod.outlook.com (2603:10b6:930:4d::9)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 05:49:50 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:930:4d:cafe::74) by CY8PR02CA0005.outlook.office365.com
 (2603:10b6:930:4d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 05:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 05:49:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 22:49:36 -0700
Received: from localhost (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 22:49:34 -0700
Date: Wed, 13 May 2026 08:49:28 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: David Ahern <dsahern@kernel.org>
CC: <stephen@networkplumber.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, David Ahern <dahern@nvidia.com>
Subject: Re: [PATCH iproute2-next v2 1/4] namespace: Add fallback to netns by
 pid
Message-ID: <20260513054928.GZ15586@unreal>
References: <20260512193412.32019-1-dsahern@kernel.org>
 <20260512193412.32019-2-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260512193412.32019-2-dsahern@kernel.org>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: a8460992-f785-461e-b134-08deb0b37267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	0lHvLCXlvkfwF5O1WAj+3k0Bwpgqj4mHA+M17PtW8Vj/7/GgvxUuBWP9nK8+o3tuk9RjLoQF5js9BHdx58hU6Z7NZLrG/plx3lWw9gzcLqnHvhH1jXxQbJPhRojkgY8jbGGYTLgVVqWZZvA+4XkR5t8ydNXpfoBqQuk35ZBthmW9OBB6sKrzE6LP542F5MQxjl0n7TfVww7C1C3xy93/ceKXOz9LhY9wEIEGHwk+tCSIEMqYj/e0gv+20hjyK76lOVtJdXUqvEFBZe80tec/uTBlVKYLlhaqOw7x/tP0o9Ss+RkPDqayqslPJAWmBiUDvpfYwYG9I2TpNyv9SEA1QfD9hEzGpxvK+qKO94h2sxLuhJ3El8ELCEamaGzr5L/kOYozl1YorORrxZT1chnwcsSQ3mr4UnVhsR5B82f+ICjWvP+qbEoCLgtwcKCGF0viKEbZ1b80xLnr83HKtnJqBhF1l62+T57esr64+wdlTXgUCDaO9vNaY0xjPL2Emqezv7Da+p8wle9MqrhgvEKSckm3aYcINh5t/hggY89hHyJFH2AtNJS/GwNXCuvvGy7k67yc+A/vFk+50dcN/3ZkWdAyQPC0JsUDWLYvca05NUTVxY1WYJebcnG6wm9J5DF4az0R07pt8ZazxandLkeeFFlJinq42zMoR10MRgjI/2tWRFMHUr4Yk/ACg3OGyL0TjKum9UIbl1u+VhXbbUy5+u3m13YlLfeh6kCQTqcsjFU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Oheaa5etKcRk0+CCjh9BwoxpLwBaiVHAWKT0rL9JRPtg1qRzmm4kyzilBzXEWyyUt04feb2j34QkoL347vXnslFUhi7aH+g3Xeui4k98ClXTDmIG0697BlQzNguDjQ19APVydaDM6eZFaCp0dtzg8+cYAjESRb4gDt6aDz/vXxv29HL35qbG2xDi/7Ma2zESL6XGT5hz9QCtvOrj+/Zp6iPu/NTy7x2ypXVwlagNB9ghSsJel9EoFdq5tuUMapIcfBcSdjdnC/e/LF4DEVFoy86cj+ljb0ThkQLzG2eboXM2JE0ze4DX/onFTa840YtWomZBn72TDFMwkBsjPm/d64stOSfr+Wp8rHyfqxiDT9kAW78V5ajRDzKEC7TiSfhxaolO54qPZo6Jm61MLmaalWR24Gcm5YWpKlgGPt2Z7M/8JUVIC4Ef3AvzMSj3TzGy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:49:49.6714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8460992-f785-461e-b134-08deb0b37267
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
X-Rspamd-Queue-Id: 22F8752DCAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20544-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonro@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:34:04PM -0600, David Ahern wrote:
> From: David Ahern <dahern@nvidia.com>
> 
> Update netns_get_fd to try the passed in string as a name first. If the
> netns filesystem entry does not exist, try converting the string to an
> integer and if successful return an fd to /proc/<pid>/ns/net.
> 
> This allows netns_get_fd to uniformly handle the 2 common use cases of
> specifying network namespace by name and pid.
> 
> Signed-off-by: David Ahern <dahern@nvidia.com>
> ---
>  lib/namespace.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

