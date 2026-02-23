Return-Path: <linux-rdma+bounces-17067-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE+tM0y8nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17067-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:45:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9273617D17B
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7308D301E7C6
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C567379972;
	Mon, 23 Feb 2026 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="podowaTb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012052.outbound.protection.outlook.com [40.107.200.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190BF3793DC;
	Mon, 23 Feb 2026 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879397; cv=fail; b=tEIflMp+5xG2xq5U32YzmaXdeQMgEc82WFLntCMyJaCHF1pONuV8h5pmFo5RUEXunJc2IlPuB//p+jzhixxNsL84zATpbP5PLMabUXTVXvcAhSjfi0+0nn8XY7VKC1bbCRJx/4PgWtvKm3OtRu25t3wbxPAz6a2T3U4P4EWIrEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879397; c=relaxed/simple;
	bh=mfqUiJOEtS8fzCGfE+9JLr6YYHaje2nUbDPSlFzvtfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhUp0o7qPn7HrybdVf9imiTGte9v+71AUMPZWqgHUKAmbNIT0v6xyLncrHbNmqdjwqlPRhzFMUN4M/ma3/6S8qygxfU9F/S+JjZN/rTdU7iyGQjey2/bxNB3EEFq8jKYWyFQxr9zcuE03jNkQNihJSHPq959ukka/996S1fdFVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=podowaTb; arc=fail smtp.client-ip=40.107.200.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXrEV2NXZVapP74vRZYucAFaZdLx+OTP+wbtIFwIMd3ifc+mC77pIQqf9reoZd9dpgzEw88Y13UdfDvdvAO2y3XH8mFG+A5sy8sWNgiwwwddldY8YOA/hu9BeYWX6K0BEa5IqQ6JHQC/c8cVh9IpJrJ519uqWwTO+tlqO/RQol1iNNkWA2R0lsvgE3WoEPTcrOZht/FIRYeBQkDfz9RntCXZnKfwZKW5bzfqkSEb7RMrsH+rTq13ek3fN1EVdTQA1iPydiy9+dy2AWmrPnqQaUu6aWZKW43JiQP7/gcgu0asRjVZvRQqaA5SiK5hLVV7e7Nuovmb36tUPd+FWpQhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acV3Nu0MRfkUanYYVvlWooIIz6hTAXTU/4kRDLm0MiM=;
 b=RUGWM+jLtY9FE6DT5TtCcUOyNYpxEKu3hZOYSJFutcaBYkrMM+YAJorC2WXF/jVX1gQhfnVu96fvAvFr4MuRo3pl/Peyd+A6/Qe3l6zDNwq8o1XFTQWATXGWlUTDfSfa+TM/ov3mMk5IWi1n+SH84h57Q+TBl0CG8SzBIxpjKo12wuY1foMeeGUMgQVwgz7cG2nIXmTbobLAaFsPuY6M/jr/WvSj3Zuz5xYZlhTSgZmGUhG4MSm8wc3C/i3kMPooNPxJLASyG2U5Uy6V+dzFZujrCaUvuQUB4b5tomjJ53l+tnu/uqP1LcU468EtG5KO10f1JWnd40HZJWsk4RuNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acV3Nu0MRfkUanYYVvlWooIIz6hTAXTU/4kRDLm0MiM=;
 b=podowaTb3ZWCxwpILsqC04QjQYQld0rPE9n4nBLHnZPYQuT84e8ksseSsecm2vLK24cjGCkht5ZSppeojSk+gNLdEwbhstSbH/xadgpEUObG2VTMOzleJMwDJwz3k7mQ0RuYT7ZBzIwdx5HQEVokdcIVVDxibLc+W1Y5Cq3mJ8oEDoM3/l5ebNPjNIDydVAIOcirOS4pRyZoyuP1EXz6nb8UOcedr8oI1zRuYlkh9JGw58ssSXzU37t9q4mmAre0dOO13lJjfge89GqVx9NpdqQRIQkmeL1aWtGZ0+Gin2TQQGyZVs5+CDRiCqySq61eQX92iWEboAq9ijScex9EIg==
Received: from BY3PR04CA0012.namprd04.prod.outlook.com (2603:10b6:a03:217::17)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Mon, 23 Feb 2026 20:43:05 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::bb) by BY3PR04CA0012.outlook.office365.com
 (2603:10b6:a03:217::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:43:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:42:51 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:42:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:42:45 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Pavel Begunkov <asml.silence@gmail.com>, David Wei
	<dw@davidwei.uk>
Subject: [PATCH net-next 02/15] net/mlx5e: Extract striding rq param calculation in function
Date: Mon, 23 Feb 2026 22:41:42 +0200
Message-ID: <20260223204155.1783580-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260223204155.1783580-1-tariqt@nvidia.com>
References: <20260223204155.1783580-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: ee4f2b31-f676-41df-1949-08de731c253b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rDGR/knnNFh5Ei9S/aDitKyWjX2jGqilTcdcappI3TcBPIqfxZ2AQLZUofQ/?=
 =?us-ascii?Q?dS1DlKZoCpR84RbXsIEtFZblp55KljIr+HT84/ymnoWhCMx84+t2q3RVEQpQ?=
 =?us-ascii?Q?HXE+Hu3TG3HDhnppliU9HBlrMgPeRjZllOUKXNbepIDM4tWQ3bVa4fGYwPWA?=
 =?us-ascii?Q?7GsZ73JHDnPBtUFInJjndkJQP+sCNXdB4K8tzaHRF4kZCPrq7LaxY7nVZFjP?=
 =?us-ascii?Q?IhmZNK1ZiDdJjsyGak62EUHhhoG91XpmMZu+1f0Ofh+1yK1yTRMDq8Iw9PdA?=
 =?us-ascii?Q?iY4NAhodN9xom1SZdXUcTHIZ7+bscS3p9/OzQ+20TXUmbbunVGc9++lmweaT?=
 =?us-ascii?Q?f+/4zCr2UH/VUOTIW7lKFW99VQJG3eB7/qjYm2pgahsFsObYyU8qfn/9bYrz?=
 =?us-ascii?Q?9nJZFX/bMa6LTLsK4sea/1IV/qllMfrGPta1oEvopai/9bjmpJz1k7swY0Zz?=
 =?us-ascii?Q?0+ax3K2fcCXc841r9Y8rHFWrSF+6vqQDb8eyNCnMRdCuORk5t5Ff0X9B5DAD?=
 =?us-ascii?Q?Sjnu2ZCYU7qj91tuayK5Pc0h32do60rpP9gaKrvcbMhNnJ2IM5rCz2IJZ6Qc?=
 =?us-ascii?Q?DeygdbHhDm/I7nfHf9F1l3TFFFPUEEOwPuidXPVi9HuSlQ9k753dj2Ulzqve?=
 =?us-ascii?Q?2VQ4G85wMe2hHUUlOzign+vzK1NXVbhDkFvLoxKFHFHfRe2IbUFhIlGfwuvF?=
 =?us-ascii?Q?VAmrja60zET0hJNm2QIjWjFmNSImZWwihG5QADIWUyUhnD6dssIMQIpCGLSH?=
 =?us-ascii?Q?Gf+VuNZsaXZAOHRo4k8B+JrJMa9fY34GkUposp5ekPMD6tbumr0GrgVEc+l4?=
 =?us-ascii?Q?kjw9C6XgpS8BFsDaj3Y3+6lBsSKcq49sackX4aLhY8591XNZnPM/YG8FMwWD?=
 =?us-ascii?Q?j/9uccGpDN77iWOFI/m8twol8TfbcA5n1F6aeFryKYUKokSG7e+JTdOchBI3?=
 =?us-ascii?Q?YlQSfeyuKI1qIRaLL/JIsMKYf10I09nUrhkfzUprl+y+AwoAy/uIFfoyMTsE?=
 =?us-ascii?Q?vbVMnrEOOhbsIe/rWzq3LMmNoCnrZ1zF2sB83LHBy5rzKuqAeIfMxbtMpizD?=
 =?us-ascii?Q?+ml/HM0rVDzGdy8X++QZKelMnB/jzW3Ielos2lBP3Z6LoN7o/EZSBX26kUvh?=
 =?us-ascii?Q?dM5N1EJGsq3yy2CoHvYSNys0F7ZHuwKNt9wlOVr+wgmaUbzKeHv+ZytaiFUP?=
 =?us-ascii?Q?boJlEzO8vRKxSD9a1PU06yzpR+gKO2EsEeokxkZktraTDBoWxDLvT5WHNUVW?=
 =?us-ascii?Q?IB3Y+DWp3P0QfKqVNmReuUzpBv2AKMzsZUDNBdw6Gy4DE0vRfXl4lWHyY5ff?=
 =?us-ascii?Q?WTUjxXh5asShQFhNBUVgj4p74EY6ixk0n9+sqbDg7/aZVezVtQHFsfjChnQ9?=
 =?us-ascii?Q?nBZFMUOOtq6zfCFvWHvSnPRkckmswnMOS6vOeefTG4ljADc9k93z2O2/NcNt?=
 =?us-ascii?Q?yEVpJLuV2WAOOWBwQq0WHaz4hVrKSQYL4b9FSLtYD051SucYzVwgYZ86d/7l?=
 =?us-ascii?Q?qb1efX17UnHfR0Mrkntuoe0lxOS8urGTHL1PXOPNBjbry5jmtmqwlFplxmlI?=
 =?us-ascii?Q?LMMDBDNGD/g0uppfR12+wMI6ldWBkmHUv/mCBplhPpYqhaSo8IYg5jk1t9DL?=
 =?us-ascii?Q?Hqnyf5Q21Rv0EtedEqF2Y08bEGYWtZmLiZ/qGH6kjBIA9Egn7YF1ZT2nudqG?=
 =?us-ascii?Q?1mTMLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lcid46Yg7WSFy6vsQp0zJVYnur6S23FykJUj4gZFIYVYhYuwAXm7Av2bk1Ji4jAfTRDlRANYF6RG5QLHV1TmOFysJ5/5aVN3tyN8BmtEFJ8hNVOURtghE33UxaS7xBrE/gokj5lL+HKAN+xBSi2ZYgTTh9VJndUDfjxk4KNYr/ji/kcnOeIMGTRD+L0oRtFlT5+pXF/OAjmblKGfROrPHsXkkVHcfiGqgYxUHiKgHLWRPygo3ug8oXhHMaiJyRQegIskEIlvhq9O4+eps5CxMvH+1JO2vFxeB1o9fxuxhP72vbwy6j8fIH49agst4+3NJyk7VbNDjsAhWxDemNRnTrsI2Skn161TAF31XZKxHcR+g6s5E3CiqBwsAZOeUq2JWMbhbHIyy8u4n17eHZPzbfFY7vtq+WZhrdaGlZhN5My/rjemAklUBZjZJwuOKXbv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:43:05.3714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4f2b31-f676-41df-1949-08de731c253b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17067-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9273617D17B
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

Calculating parameters for striding rq is large enough
to deserve its own function. As the names are also very long
it is very easy to hit on the 80 char limitation every time
a change is made. This is an additional sign that it should
be extracted into its own function.

This patch has no functional change.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/params.c   | 106 ++++++++++--------
 1 file changed, 62 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 3fdaf003e1d0..07d75a85ee7f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -880,13 +880,70 @@ static u8 rq_end_pad_mode(struct mlx5_core_dev *mdev, struct mlx5e_params *param
 		MLX5_WQ_END_PAD_MODE_NONE : MLX5_WQ_END_PAD_MODE_ALIGN;
 }
 
+static int mlx5e_mpwqe_build_rq_param(struct mlx5_core_dev *mdev,
+				      struct mlx5e_params *params,
+				      struct mlx5e_xsk_param *xsk,
+				      struct mlx5e_rq_param *rq_param)
+{
+	u8 log_rq_sz = mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk);
+	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, xsk);
+	u8 log_wqe_num_of_strides, log_wqe_stride_size;
+	enum mlx5e_mpwrq_umr_mode umr_mode;
+	void *rqc = rq_param->rqc;
+	u32 lro_timeout;
+	void *wq;
+
+	log_wqe_num_of_strides = mlx5e_mpwqe_get_log_num_strides(mdev, params,
+								 xsk);
+	log_wqe_stride_size = mlx5e_mpwqe_get_log_stride_size(mdev, params,
+							      xsk);
+	umr_mode = mlx5e_mpwrq_umr_mode(mdev, xsk);
+
+	wq = MLX5_ADDR_OF(rqc, rqc, wq);
+	if (!mlx5e_verify_rx_mpwqe_strides(mdev, log_wqe_stride_size,
+					   log_wqe_num_of_strides,
+					   page_shift, umr_mode)) {
+		mlx5_core_err(mdev,
+			      "Bad RX MPWQE params: log_stride_size %u, log_num_strides %u, umr_mode %d\n",
+			      log_wqe_stride_size, log_wqe_num_of_strides,
+			      umr_mode);
+		return -EINVAL;
+	}
+
+	MLX5_SET(wq, wq, log_wqe_num_of_strides,
+		 log_wqe_num_of_strides - MLX5_MPWQE_LOG_NUM_STRIDES_BASE);
+	MLX5_SET(wq, wq, log_wqe_stride_size,
+		 log_wqe_stride_size - MLX5_MPWQE_LOG_STRIDE_SZ_BASE);
+	MLX5_SET(wq, wq, log_wq_sz, log_rq_sz);
+	if (params->packet_merge.type != MLX5E_PACKET_MERGE_SHAMPO)
+		return 0;
+
+	MLX5_SET(wq, wq, shampo_enable, true);
+	MLX5_SET(wq, wq, log_reservation_size,
+		 MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE -
+		 MLX5E_SHAMPO_WQ_RESRV_SIZE_BASE_SHIFT);
+	MLX5_SET(wq, wq, log_max_num_of_packets_per_reservation,
+		 mlx5e_shampo_get_log_pkt_per_rsrv(params));
+	MLX5_SET(wq, wq, log_headers_entry_size,
+		 MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE -
+		 MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE_SHIFT);
+	lro_timeout = mlx5e_choose_lro_timeout(mdev,
+					       MLX5E_DEFAULT_SHAMPO_TIMEOUT);
+	MLX5_SET(rqc, rqc, reservation_timeout, lro_timeout);
+	MLX5_SET(rqc, rqc, shampo_match_criteria_type,
+		 MLX5_RQC_SHAMPO_MATCH_CRITERIA_TYPE_EXTENDED);
+	MLX5_SET(rqc, rqc, shampo_no_match_alignment_granularity,
+		 MLX5_RQC_SHAMPO_NO_MATCH_ALIGNMENT_GRANULARITY_STRIDE);
+
+	return 0;
+}
+
 int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 			 struct mlx5e_params *params,
 			 struct mlx5e_xsk_param *xsk,
 			 struct mlx5e_rq_param *rq_param)
 {
 	void *rqc = rq_param->rqc;
-	u32 lro_timeout;
 	int ndsegs = 1;
 	void *wq;
 	int err;
@@ -894,50 +951,11 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 	wq = MLX5_ADDR_OF(rqc, rqc, wq);
 
 	switch (params->rq_wq_type) {
-	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ: {
-		u8 log_wqe_num_of_strides = mlx5e_mpwqe_get_log_num_strides(mdev, params, xsk);
-		u8 log_wqe_stride_size = mlx5e_mpwqe_get_log_stride_size(mdev, params, xsk);
-		enum mlx5e_mpwrq_umr_mode umr_mode = mlx5e_mpwrq_umr_mode(mdev, xsk);
-		u8 page_shift = mlx5e_mpwrq_page_shift(mdev, xsk);
-
-		if (!mlx5e_verify_rx_mpwqe_strides(mdev, log_wqe_stride_size,
-						   log_wqe_num_of_strides,
-						   page_shift, umr_mode)) {
-			mlx5_core_err(mdev,
-				      "Bad RX MPWQE params: log_stride_size %u, log_num_strides %u, umr_mode %d\n",
-				      log_wqe_stride_size, log_wqe_num_of_strides,
-				      umr_mode);
-			return -EINVAL;
-		}
-
-		MLX5_SET(wq, wq, log_wqe_num_of_strides,
-			 log_wqe_num_of_strides - MLX5_MPWQE_LOG_NUM_STRIDES_BASE);
-		MLX5_SET(wq, wq, log_wqe_stride_size,
-			 log_wqe_stride_size - MLX5_MPWQE_LOG_STRIDE_SZ_BASE);
-		MLX5_SET(wq, wq, log_wq_sz, mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk));
-		if (params->packet_merge.type != MLX5E_PACKET_MERGE_SHAMPO)
-			break;
-
-		MLX5_SET(wq, wq, shampo_enable, true);
-		MLX5_SET(wq, wq, log_reservation_size,
-			 MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE -
-			 MLX5E_SHAMPO_WQ_RESRV_SIZE_BASE_SHIFT);
-		MLX5_SET(wq, wq,
-			 log_max_num_of_packets_per_reservation,
-			 mlx5e_shampo_get_log_pkt_per_rsrv(params));
-		MLX5_SET(wq, wq, log_headers_entry_size,
-			 MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE -
-			 MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE_SHIFT);
-		lro_timeout =
-			mlx5e_choose_lro_timeout(mdev,
-						 MLX5E_DEFAULT_SHAMPO_TIMEOUT);
-		MLX5_SET(rqc, rqc, reservation_timeout, lro_timeout);
-		MLX5_SET(rqc, rqc, shampo_match_criteria_type,
-			 MLX5_RQC_SHAMPO_MATCH_CRITERIA_TYPE_EXTENDED);
-		MLX5_SET(rqc, rqc, shampo_no_match_alignment_granularity,
-			 MLX5_RQC_SHAMPO_NO_MATCH_ALIGNMENT_GRANULARITY_STRIDE);
+	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
+		err = mlx5e_mpwqe_build_rq_param(mdev, params, xsk, rq_param);
+		if (err)
+			return err;
 		break;
-	}
 	default: /* MLX5_WQ_TYPE_CYCLIC */
 		MLX5_SET(wq, wq, log_wq_sz, params->log_rq_mtu_frames);
 		err = mlx5e_build_rq_frags_info(mdev, params, xsk,
-- 
2.44.0


