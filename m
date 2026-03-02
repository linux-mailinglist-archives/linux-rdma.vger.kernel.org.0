Return-Path: <linux-rdma+bounces-17389-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL1QNlKzpWlaEgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17389-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 16:57:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5DE1DC3FF
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 16:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 624E130D9269
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 15:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3513FFAD4;
	Mon,  2 Mar 2026 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qVtgodB+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5030F345752;
	Mon,  2 Mar 2026 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466783; cv=fail; b=bACNkjTF5ozCoSrGwLIYwIlOBntIgEV+5b4mBJZBqtfABF/tmdEMl9ReNVAFqvcFoWWUsNVpdbgCOVC8dqpte2VltSvaboY6h8EJX/eLBdK0xSKv/xCsfGYrB3W4WZ3m3raIRGehqzKXoAAKldoAhSYiu1nQlORWw3sXqrKQN9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466783; c=relaxed/simple;
	bh=qCiO3is3qFOAZBjmdqqST5zBYiAl3pgWT3ofKGdzcEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOIpwtwbvOZAm3HeG4lVIHcmOtDpZdLhWOyQ+X1Ku1kQ6fXdDxjG0Z8qyLmMmCJvS0ODem17Kxewxrj84sC609B1hc0gomjhnnzlbjPpSS0jS3hqyL28FhqE2ud9BC+GsXOhW1i+MsIG0D0py403o4Chc4Wau2OWC/i5/WgCG/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qVtgodB+; arc=fail smtp.client-ip=52.101.61.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXNwXwF04rODlZG0zpWyTfW+ID0BfmQSpYCeT8tQjU0+9N0ceFdxDK14ANDgciqzKPMCz6eKWy/8wjyrot+0bOiNWXeJjVFjwqssyZkTcAiU5SXEMeBS6YoENUZLLtwSh7diBpXsFptOcJSCTw69yC20HYO53wVlh33e8Q+xN7Ps0lM5LDkJdsopPEbJSbSLEl+72cwCXio6UIzjv1PdVxCS8wYNLy/tCKMnjEZg5majZ0DeoxQsrcoyF8C48U+m9y4bxhH18rFyGtrJ+9+5AmUJ4/pS6JeD8vMpziK7SqUUrP3X6X5BMjb6IYEM0RPIrUVJM7R1+DE2Zj5ANCW1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvOrc7Gb2vjmf0+C1cUzd1QsLjonQQ3ZEBhPcQEU7NA=;
 b=JFHZeKJjMMefFriZ0WVb+LOXs0GqV9KaNJdONKAQgnILZKMRcZpIH9PJrYHX15SkXuLsgmN68lpmrsR/4TLwQUpe2Z19m7ic48zpZjOXzCkPw7+Oz2n5v/8rOWbC8tS8ZrCfMJrRYOwctkFPhsZeBT9NXBgP5mCb9oT4D3vfe1Gsrw9tY4Zl3ybN/9XWZobKA69dnDnEAvZY3D1ep21EKO3X1+Psq+pf5wA6KJ2XqPdwP4gT7vsy1XDSXG2lCSr9RVtYlm4wfa3iepOTl86bglXXhNefYKgqt4/m6XiqHPd/2FzE7i88fSvX/+JMwbwrnuobrMv51YjUhIKppDLkcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvOrc7Gb2vjmf0+C1cUzd1QsLjonQQ3ZEBhPcQEU7NA=;
 b=qVtgodB+h4456Px6j/0aO4eqpfz6ceUJUmt4XyCaWWLHI+KJ9ytS+cOVCT6tfy/Nxg3iy2TNv5M1FroJJy0ZJ6uDMN4bpIXQlH5+yEMA2rtgma4THiCUu3FWi15O3IFKDWy2FQ7solwV5YTSWPGveKNydR7olW4qEUB+LMjKZ+uTUPnpZ870Pbs+P2Iki+7Kebkpe8uHXIoMlAdf+u2RBA6Cv9Pk3zkYAbvG/ovsFBTP21WZA+4GNkKfO5lDYLPUXp8f2BD59jsRZgtp5H9sjYaj7m7X1myTmoUKk3rU4EN2NHNX0pAEqXK+N4c3lprjMOZDVd4VRg0xuFH9QZDf2w==
Received: from SJ0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:33b::14)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 15:52:55 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::10) by SJ0PR05CA0009.outlook.office365.com
 (2603:10b6:a03:33b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Mon,
 2 Mar 2026 15:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 15:52:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 07:52:34 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 07:52:33 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 2 Mar
 2026 07:52:31 -0800
From: Chiara Meiohas <cmeiohas@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: <michaelgur@nvidia.com>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH iproute2-next 1/4] rdma: Update headers
Date: Mon, 2 Mar 2026 17:51:57 +0200
Message-ID: <20260302155200.2611098-2-cmeiohas@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260302155200.2611098-1-cmeiohas@nvidia.com>
References: <20260302155200.2611098-1-cmeiohas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: d9934207-2ea7-48d3-fc33-08de7873c50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	w4s4s+3xPcPDolu2VjpZuH5SaQapVRW+Gu7XgBI51NZ2MAmoR5zw3ksKt8O7xqpIf2MnTuD2K8Ojg27eU/nfCAk9w3krxSpflgHjDf5C/CxalfZDPBbpempVOFXDqSu4ybG9hqw1o2itYHrvMMXCEl9gf5zd+7DzXL7YP1Uvu0L/dfXdN65KStmWXd6TysOFyR+YfGgS7Xc3GMGusMVaaON0aZMue/ULV+ubDwTyPZH1DaKLNxA0oFpIN/yJ7H4g8uV/KCXc53nwnxFFNukQlgb1JatCVJE9lprJuz6lRqTbJSneneY6T9F9EqD3YHlMf9/xXjA8K425nDp2bO9GDRKHryjKkkSu7nBdo5nbL11XVC9pEWvlKORsh/ucoobNo9/0aa5RmxyDth7XffYKNn5ph1isNocnjErvV7egIlDrtlUXR2IVj44WW/rXtw0H++3F8jIM80w/WxFPPf1jH9o6Jg9RsDgWyB9dApBDrRUjpPc7lqJktnFD6lHfnoEsGGnICbUJXp8PvfTltBjj0JYWDaYqXNCHbWpaEjJumdaZe9Sq65CTYQwzXEtXhdpyUdvFpQpzETbuJ0T7fwIPkhyV2Uyr60mrCc01iHr6OmlEreZ4b8kKerEAmsOtGgqni65jRFW2EsGnovV4mKY0L0jm2VOMPdKYHOZf6CmAaIpjzPiOJQEAL3mT3TXUirf9tcCg+veNa/dZwA/XqQ1DxoWZ9JOGC+tGiDTbGA17TZe9rmmBvT234tdDOF781oGo+xw21GRGW+LPYAhvrFdRR4MuhIUwen0lW8sWZL8LBOTAPZcCZ6P7+ry5Y4lwHiswRMZygswQ7h5336IkFaNXgA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P1BqcKJrY6vtFiQTBNuy5HvqAjgAI7MFUQJHeI3mNuB/nfBpXnLohDaRDvxff07BN+DEIgkAZg/Xr6XvJF0+0hXZ9yX+xOtF9mWDIloqCwH4HoR+BnyDI5ZHl7UWGVHI1PgJIdepvJsUb2WKLUdXCox1KQlO2V5bqFzYWbH6Stl/qwvgOpre5XCup/QgiQBz3PYMF0pt7yjVopJgpFo2lKu5UFLMxJoYNTxtTsjq6J52LXNoMKmQbOFvDYFDy6PFNcJQvgbr1PL+dpEg/qXk10/8gpjo+DJJQOB7xAblUDv8+dFi52Kc9d5Y7EXUeN9ygFxDUa/NQmRap23WvUYC5bkU08aJ3x/3f3GpX4YudGYlWtE7h4Z+2l897n1h+Fbaf1qgJtMNGlCDUDF0j+oPkbW9rO7rZib/SyJhJXuxIhCSouvXeFdl3dxKomVegjQg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 15:52:55.4585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9934207-2ea7-48d3-fc33-08de7873c50a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
X-Rspamd-Queue-Id: 7C5DE1DC3FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17389-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,networkplumber.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmeiohas@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Update rdma_netlink.h file up to kernel commit f55576f6ace6
("RDMA/nldev: Expose kernel-internal FRMR pools in netlink")

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
---
 rdma/include/uapi/rdma/rdma_netlink.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index ec8c19ca..dc958c8a 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
@@ -308,6 +308,10 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_MONITOR,
 
+	RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET, /* can dump */
+
+	RDMA_NLDEV_CMD_RES_FRMR_POOLS_SET,
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -582,6 +586,24 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_SYS_ATTR_MONITOR_MODE,	/* u8 */
 
 	RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED,	/* u8 */
+
+	/*
+	 * FRMR Pools attributes
+	 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOLS,			/* nested table */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_ENTRY,		/* nested table */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY,		/* nested table */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS,		/* u8 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS,	/* u32 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY,	/* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS, /* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE,	/* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE,		/* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD,	/* u64 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_PINNED,		/* u8 */
+	RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY, /* u64 */
+
 	/*
 	 * Always the end
 	 */
-- 
2.38.1


