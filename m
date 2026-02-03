Return-Path: <linux-rdma+bounces-16412-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCUqCV6ggWkoIAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16412-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:14:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE10DD59D9
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 585E230558C3
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 07:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05972392828;
	Tue,  3 Feb 2026 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qk2dRcJG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB83921D0;
	Tue,  3 Feb 2026 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770102721; cv=fail; b=ne/zl9+pOG8CTthQmd2NQACMb8fHkp0oGORLv88AD7NfZWXH6lliR3DUlNEurjGFapGykuI1x9CyQ4G5vb5sO48TV0RzrdJPoyjptSMHPGSqNuimatvFJ//YBqkznSz9CLTupNVJv2CZuyhxh4GBBuowrv+z3xHeinEQu7rL7Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770102721; c=relaxed/simple;
	bh=v4s9fRlYFfIJBlf1h6Q7S9bnEzRb4/bF70sWHTiCxEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5r68jvUHnGOl2IXUggRgeJpW9r3F/6nwoinVY8XT0X4IOmLAU2RWJYRVp1hq5gl4e7VzldcuXdPts9X78rdbmOBQR9Cq2DEscWqjjV4ie9JiIH43PqB6OH/SOfOeyhOTkoM2svF/miBvw8TKYJuDc0vb18XcJ19pMX5QHSw1do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qk2dRcJG; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yokdakQCuAgW1M/dVT/DYvviuoFQrLDWBngVz3ii5UaPtg1k3zUd5zKavGGqQI+qwGgKHklO+SiX8g2t7ZgU7Qb3kaWYY0pUtLUKmUbhQzxam9PyVi0IDMrg+X7QCEvn3F4KNNkv5VMe6uwGVEnPGdUSo48SXT2ghA5yuhWyqxOoOGYm9KDk44T8s0Uq9Tf5EjnnDapgarhuWFXC9OsAmzlpXUGxMdYvrp2gGhyXl4lGSqhU3hw+3rELe/AbmNYtKW5bb25bSxQIgReT7wUWtgDYEtmf44+wQGRuSfIfbc4zXqIzHpPb42AjAYAlUD3pZwrfvQeb8N8CI8gy/227Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvEFVRfH+bPCjsjgi9fG23mHPi7GrBbj5rSGheTjP/k=;
 b=FDYK6dCSesi5qI66WBV/zgVYqOYQsEIv2W4QhXfMy8rY6YqYZl9UOcomVcRtqIy/Hhd1E1toBqfBYqknSVGCZT+L0HrlU6RuIzeviXsjR+gJfmcic4m6XvtypKFuAxc74G2hhetq6Y6+Gh+MM8n+Tc/AUOCQ6yvDA4cujbOXuInm+OP41KxTHtfIQjLyt8GOXxp8v+8Q5mE6uVKsPjQ7rXo8lo6UkT/RDdTWkA2mBAbIgSnJxsVmsnxB7cBHbv04Hmfhrh03/Mha0gzNF7S06CR2E0MEHPMUqcVYepZ2d3X0y5doYkcAvOvySKtBWL021sLmghukOgLFzi7ygBHOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvEFVRfH+bPCjsjgi9fG23mHPi7GrBbj5rSGheTjP/k=;
 b=Qk2dRcJGNLRRgcJJw5VEzG9QR/yeqonHlvJJTM86ezU+lYciLkM5vsQ66wNUjLYcTt/zGyKUvdZFKzOTXJl6uNq5MnGzs/RZrVWA/DBbZX9CPN8Mxzz5QORYtQrBAcR7GFFvAfjAZjBE7FuAjshwpTEWrzsKvzdJU3q8PFDfnq7dj+5jtakQ/azw8oQ++JFPoWNSh97rP7f8tI/nPjl8nQfqYXGXi0J5u+CkYhlmSy32UgzGYzLBwPwKejHfj0GaRER9ZWdyXvdlegyRHyc6KuX+CKoiG4Q7ulcaLWQHHSt71ey3pY19qRw4TojQlL35qwBt8CnyK2b2RQLTz1e0WA==
Received: from DS7PR03CA0258.namprd03.prod.outlook.com (2603:10b6:5:3b3::23)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:11:44 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::1b) by DS7PR03CA0258.outlook.office365.com
 (2603:10b6:5:3b3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 07:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:11:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:11:27 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:11:26 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 2 Feb
 2026 23:11:21 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>
Subject: [PATCH net-next 3/5] netdevsim: Add devlink port resource registration
Date: Tue, 3 Feb 2026 09:10:31 +0200
Message-ID: <20260203071033.1709445-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260203071033.1709445-1-tariqt@nvidia.com>
References: <20260203071033.1709445-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f1689f-bdd8-4caf-2fea-08de62f37c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Agk7fHg3V+bNYbdNTtKLiCKItSZHEpuVcz6vGioadRfzI1TE8GFy69mm3ovL?=
 =?us-ascii?Q?zP2Rt0WfWkAAq5T71Cxi8VLUqgwuVwWXogTAkyEJLMivJEhZlnABcqNUyZ9L?=
 =?us-ascii?Q?E4RCPW3JQgLv6UlYYm6i8mpHp7RavvCFLmLCer6AVB0MA9eRU9p6uxpHoF7K?=
 =?us-ascii?Q?wqktAtNwLlRts9YVccWXEp2u4JEMaZH+24PVtuG+bf5tWTQizdwjyhO3jmQ2?=
 =?us-ascii?Q?uqelWUSYottAhStCeLoQNMYODwUMBNEz6b/nL7evN5cocmNlLrRo388TS6RM?=
 =?us-ascii?Q?k6yxNuRNwVRQMZCs+DW+pYkHHUJR9g2nDQmbn5hh9q4urtyrP1oj+hiTdx10?=
 =?us-ascii?Q?4BfbSbv81YSjZZkFh3cDOUqtboeuIuw0a0sc3VOFpcPO5zU4MMqaK57UP/Ec?=
 =?us-ascii?Q?lg2IHlGjQVUglgEvv2r5qoRBGETNeXcK6x4+UGReGIaxRaEaOxwECOe994f9?=
 =?us-ascii?Q?9QLBXL2X/3d3KrNYIfwWHynhrM9mt2I1+F31hgBeEPYCWC20ySoaKywIXkI+?=
 =?us-ascii?Q?evy4knIwAfUY/DGWJOxNJBAktqpLmWl89ijoLSZtBrRVzMSCDquD5SWZ6VRC?=
 =?us-ascii?Q?NOTHCXZJA1J3JXfk+X7DB6g/Zd9OaoDgyHQtZuu9z/CvYePDWYdseUNH94xO?=
 =?us-ascii?Q?6S9mTwKJA/TtpuPqGwCcGQrDq4XoGa9vsMdC7961GnzPAXAPwUaUxQMJPqV6?=
 =?us-ascii?Q?Vhm4+tsXEDF3YV+JsHnYVrFEQ5fg6c0HGBcz/sohuGV3C/EIw4FUTLDawXu7?=
 =?us-ascii?Q?igF0ynfSzxhBa1ps7Svpu6Pz5CCs2Xk3eo4Pf+zdqbggZPvSJZlss9tXRJ04?=
 =?us-ascii?Q?f2AXYfV/7N7vYBn5UFCGoxzNHQTN95X4xe1qm7Ljj1Ba4jZ9K5aXGhAfQF+f?=
 =?us-ascii?Q?Jg2N8qZR4+TxZ4doDey2xBW/egBMEw6aIEoc/NPozIzc7b0O0UHakr4qAHtZ?=
 =?us-ascii?Q?ZwQ4h6FRwrzV6Ww0+wYAFigP9uh0Bkfnzgzz8veVGc2MfmYEWR93pRKs0DPK?=
 =?us-ascii?Q?qcZderq0SV2iPB1J87dAzp4yg+kuzbyAHB5ywodM/uzVcoEVmv2RJzz7e9Fs?=
 =?us-ascii?Q?a68KhreEFA49zYz0m7zq2FJK+K2BL0zTt9rTIGlsIgi72mLjlYcM6ysTXhfL?=
 =?us-ascii?Q?bgE0wlfJ9tykh0JEAQVpOENpY2FePAE66/omVLNl9BBm3j5dcWFCw11HFFel?=
 =?us-ascii?Q?2n0gZJCfPGDljJCNPlNe0pbHomU1CVNrhmwe9DQ6M1r63xiGgoocAmhzdlnp?=
 =?us-ascii?Q?+/Gl54AGCLBlEl8lMBiVMllUJ0CNHz9qAPwqNYRvm0EiZ9Ups6ieB7hM6QR4?=
 =?us-ascii?Q?MSjOmR8LY2363+3hYfmvA1+f+ARWcJwzQUEmNORmOTK/fcr6ZDjK8/x23du5?=
 =?us-ascii?Q?SLFYIzN6oH+qClKZK0m+WaF9Bjv7N+Jf3p/7yMK/D1TRLkukFT+r71P8ahQ+?=
 =?us-ascii?Q?HHo8gPB3Q8YZw2RoknW6SoFtKm+1o1x6k9rG18tsvwEB3fqkqO2TI5Dvs3+j?=
 =?us-ascii?Q?EwAYDSW0rWYDPmm6SMDZfcThR1tdcXaBpGuEdt1AJxCu8D9ygHbpux/5ESX0?=
 =?us-ascii?Q?lZSOC8LiCBlu8CkpPGpOvJEFiJVtx+E3TODjMjN8prqtGnOvXJoBSlOfoBfU?=
 =?us-ascii?Q?FfUtNlWRl3HWmKqPXYt2U/sYR5PkfZdjt7OLIYH7zan8WYEx+zcBL2wAcq2y?=
 =?us-ascii?Q?hPeAJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L3WO+05kYsa7miUoCFEA/sbpch+n2m9WMu12b5bjWQowuvxSCrncNSYEF9wjt2wMJ+RKWzxDkV3iAEks5iiCoTLXRueGlz14ZeXstmj3Zx/nu8tYDv2/qdAJPwD5h4nziGohGf8Hnu7xs272IcqvEfk2NTQS8Nk4NuZtv4EzKDP9Ku6MA/0rdEtxdtiY4cqYHslD0nn7NOrQd0WH36TbMPt6WhcR7STW8ML8qsFIJBSAbabxLb3Xyez7FzhG2enkIacX67q/gUAtQiS6LQ/QajYdLau+oGbSwKIMXCe9+i0EIG+FRWUBSbJtS42w2aWsVYI+a6FzouBIKmT/aUVOP/Q32saEYNZffh1lpI0Ve5K9wPG5iJGzzsaQq6OJ3YuHN4kD70u4/DjfYR5y3taWFhE5B8g4C/sKexXaOd0hNxYqdJgFeNYHjbQiD0tuj0Lj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:11:43.7773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f1689f-bdd8-4caf-2fea-08de62f37c8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16412-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CE10DD59D9
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Register port-level resources for netdevsim ports to enable testing
of the port resource infrastructure.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/netdevsim/dev.c       | 22 +++++++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h |  4 ++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index dfd571b22107..ebda1b961664 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1486,9 +1486,24 @@ static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_typ
 	if (err)
 		goto err_port_free;
 
+	if (nsim_dev_port_is_pf(nsim_dev_port)) {
+		u64 parent_id = DEVLINK_RESOURCE_ID_PARENT_TOP;
+		struct devlink_resource_size_params params = {
+			.size_max = 100,
+			.size_granularity = 1,
+			.unit = DEVLINK_RESOURCE_UNIT_ENTRY
+		};
+
+		err = devl_port_resource_register(devlink_port, "max_sfs", 20,
+						  NSIM_PORT_RESOURCE_MAX_SFS,
+						  parent_id, &params);
+		if (err)
+			goto err_dl_port_unregister;
+	}
+
 	err = nsim_dev_port_debugfs_init(nsim_dev, nsim_dev_port);
 	if (err)
-		goto err_dl_port_unregister;
+		goto err_port_resource_unregister;
 
 	nsim_dev_port->ns = nsim_create(nsim_dev, nsim_dev_port, perm_addr);
 	if (IS_ERR(nsim_dev_port->ns)) {
@@ -1511,6 +1526,9 @@ static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_typ
 	nsim_destroy(nsim_dev_port->ns);
 err_port_debugfs_exit:
 	nsim_dev_port_debugfs_exit(nsim_dev_port);
+err_port_resource_unregister:
+	if (nsim_dev_port_is_pf(nsim_dev_port))
+		devl_port_resources_unregister(devlink_port);
 err_dl_port_unregister:
 	devl_port_unregister(devlink_port);
 err_port_free:
@@ -1527,6 +1545,8 @@ static void __nsim_dev_port_del(struct nsim_dev_port *nsim_dev_port)
 		devl_rate_leaf_destroy(&nsim_dev_port->devlink_port);
 	nsim_destroy(nsim_dev_port->ns);
 	nsim_dev_port_debugfs_exit(nsim_dev_port);
+	if (nsim_dev_port_is_pf(nsim_dev_port))
+		devl_port_resources_unregister(devlink_port);
 	devl_port_unregister(devlink_port);
 	kfree(nsim_dev_port);
 }
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index f767fc8a7505..11ea1a52924a 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -224,6 +224,10 @@ enum nsim_resource_id {
 	NSIM_RESOURCE_NEXTHOPS,
 };
 
+enum nsim_port_resource_id {
+	NSIM_PORT_RESOURCE_MAX_SFS = 1,
+};
+
 struct nsim_dev_health {
 	struct devlink_health_reporter *empty_reporter;
 	struct devlink_health_reporter *dummy_reporter;
-- 
2.40.1


