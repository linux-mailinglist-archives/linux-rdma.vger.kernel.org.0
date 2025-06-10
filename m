Return-Path: <linux-rdma+bounces-11139-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A05AD3C59
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3681696A8
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0088C23814A;
	Tue, 10 Jun 2025 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hFlslwnA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BD823716B;
	Tue, 10 Jun 2025 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568251; cv=fail; b=XC5WXqR28Tsw6UiIRuFs95y0FStP1h4i9/RzIcJCz+vV6+3ApleIAl5IdQq4oW/oxWpl1iYT6CateyhcV/m3uRAMpBWaIEi8hshIHo5TAtq2vGd2oN0JN3xKJCOmB8va+0U42Y7dE+H8zeDpsLNKd4zxcUfdUfDKZN4pldxHq3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568251; c=relaxed/simple;
	bh=iQ405jlpUdi2M2mlpiwGwBGuNpLG7h7qji6ME3PIh1o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVSGaosVBCrajVKPlen8FdGvibTHLf1iVI2At+MEosvnI8quS9M+l7EzB7gE6q+WyK1MHBvM23LjdEsp5WU35ZpVabr9ga82W1n4QwNPpLvJeZjLBwWe9BnUxTKhwQO3Cyrj9leh3ZrkR1L0RB3JZXsZ7wGd3QDXBN18NpHXCok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hFlslwnA; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYkHwNTEHV8qnedzvwrkIZoaqhwSu/uMqgRlxM5AYAGlbLFMdsz5RESe46aSus9NNYSVCWfCdam7GSIr/9LuzV2eIJjeG5y8nK42pZ7nxGX7JEmf3CQTjvfVEH8ql/u01QOSdeFYBlAm4TGdGzcqq/75Ro3kaMeOCCGawkzA0DsLz8Zpc/7GKbN/VCS8VnsMMU0Zt0X9BbsW8xbvScVzvP/n5dLh81thJbj/ehb+tegLa8Z2jZxaMT0KY0cJvFZNdh59Li7i2LDtzUSEab8hM0Qw8kxVF0Bs8BTtb1PhmG/0J3Hc2jrnzcKKOuHyEB+LunwJSGGxrk9Bj/t/HXUEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9tB83GKWoV97ArXyO52qnwT/TP4jHi0S9un8/W/1Xo=;
 b=HxuWu2AecfoFand+JoL4sq590Y5mEo13qmxeeALdtbH3vwAUHNQGDpCKhWmcKfyQ4TWZSldU+OXM7sZ9mCe7c21kwmnGLTXlP6ntUdMOESEO5hsGJX1jfolj9Z24JnDXe3J9i4arMobTFzmgMpj5ea9x5hDWWU+Da7x4kHJn3zv809HAENDD9847GkTf+jjcjlYTZEPHm3buK+nFqKB3RZ0KSR92dnqBEmRbrf8bZ/dT7wpjcBCt0LR8tJ0hzL+lQg6yXXq6ACyeIDMhv+Wm6vV+a9uHcRpHgUmYrpRE+Y2si+PvI/tLGiEmlCkA6RD6pggh+yV/CWSNgnuJX1D1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9tB83GKWoV97ArXyO52qnwT/TP4jHi0S9un8/W/1Xo=;
 b=hFlslwnALgd76tvfY4R6bFHHohwU5zBVz9aV4GVI8Gb9q1CmLzhrW80HN6RuKTXV9nOYZ1OOLU4jRJ111/bR8IWTQt9muOv5EM9dAF+U0feFHpEfSokZgvqYTs9xR1LbewIlF6jesj4IFZNdw8qni8Ku0djdnOuma3AP1dkfSQFA5mmgPVH3Nn2KRJ+leE2d7DYeI5NmHXiRt9l1Gz6otSmQgK+ZIYPB/oWMEtX2Dm0DiHLaDW/4+KzuAKipfDMUuqlPl/4C+YwNGvn6pfLgxSAhECIlNJ/rOXGSIIcZQoh61SOOrg8bskeC/LTE0R21ej7tPsQir2HETjEvUYUpsg==
Received: from MN2PR14CA0010.namprd14.prod.outlook.com (2603:10b6:208:23e::15)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 15:10:47 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::ce) by MN2PR14CA0010.outlook.office365.com
 (2603:10b6:208:23e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 15:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:10:46 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:10:23 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:10:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:10:19 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v4 01/11] net: Allow const args for of page_to_netmem()
Date: Tue, 10 Jun 2025 18:09:40 +0300
Message-ID: <20250610150950.1094376-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610150950.1094376-1-mbloch@nvidia.com>
References: <20250610150950.1094376-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a75970-404c-476e-3e21-08dda830fa42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rr549Z8jw7DgLmao2/ffXRZPQrGe5lOyiectq04ftk8vdHdSTLUPIlZ57zh5?=
 =?us-ascii?Q?3ITmd2MX/dJI1DLwT+fg0Llm1DI5CS8Y5QEkqdo71NwcHExz+5kZ1+HZSvP3?=
 =?us-ascii?Q?H91u/3P57EmKV8Yp95cF8wu4C8n12Xs4Z4WSQWotING1vb7A9WoMIi9mSBc0?=
 =?us-ascii?Q?dhZHBbM6KYswQEuzKUQ0I5Sv4kHObCBSv5R7NKaXN6cVasL6TYrzdoVXbnX5?=
 =?us-ascii?Q?ncqvwpRQbajGr8+nV949dcpymToM4/LoWKI5qCQqbYYL49S7YFDXx6p9Mstb?=
 =?us-ascii?Q?s9cFabQnbwVVpOBrs5Fq3hzYxBpRDBQt5Hu7f30qMEk1OBrhgLqYa+uHl6U+?=
 =?us-ascii?Q?Tyman3TH6RdV6FK0annJg6OWNFeeyWZpaIN5mze7ivGs8tVOGNKsgUsPqavD?=
 =?us-ascii?Q?fH3KKbTSLPx+xdTsrn/R9E0x6UKxJYFvMiPPsIpdxHKWskXN3uDqXexjqLg3?=
 =?us-ascii?Q?LwG57cvKIOzk3ZdyqZIGoOK5S7C4vz2MLKVJYOt/oBB3kTBAmtfeUOzi0Pdo?=
 =?us-ascii?Q?C4I2NzHhCcOXml8nh62yxqdVLgT0nCc8kHvzg+BN0hIJWZE80qQJ/DYwAa0r?=
 =?us-ascii?Q?ieZ8nMSl8jL2HNYJeyJvkxhcEI+w0kw8DL4NkdhelkT5hGdm8iKOvPTLJOAf?=
 =?us-ascii?Q?2phPLms4+WuHAN9jmOQ+KWS0iqX+gUNEiDGv+egjYcF39qyjNgxU+W6vzrzP?=
 =?us-ascii?Q?IBeZ5/G7QFpwnqRcH4a552WLRsfXpWZH4gFudIjZNxOZa6uz579uqQX0IAfh?=
 =?us-ascii?Q?VxqoyilLvsUeW9plz3KljEIIZVKTvFKHxpPX9Hp6FKSBCvM2GL4sE0/LR9Yc?=
 =?us-ascii?Q?3BSK+QiIp0dWb6C/2zs7r5X4b7lwkAlhF0qSd4xL/1XY2/E3KoN9sCiASfXR?=
 =?us-ascii?Q?u+3Pd5ExFadj0bgCUh5/++0A0nIYUf6N/gJAsxDLEY00Vk1fRc+G3VcZkIht?=
 =?us-ascii?Q?VYZhDUhjDfs5VzWP3oeHUTSvHQdfG344wDOlHacwO4yJ3kn726svyFRydMVi?=
 =?us-ascii?Q?myqyz7OPxKadeQVvWpo4T9N1AldLHQADG5wbsfgaSzpVwCQ3xp98b3TuVd1+?=
 =?us-ascii?Q?FXa+6weiV5GIAFU6JlDU1tRTkP27GyiE3pMdg0nQE3vK91R/pIZe/4R69aeF?=
 =?us-ascii?Q?/6Frag2O1mBOsATPzOQEhcVmYwIUTreuQL5VqdRdFKCf8rTqPLfD5k4bbbqt?=
 =?us-ascii?Q?sOld8HJy8BZhNhMiFLK55/Kw2Cd0Gutdr9PkD1awvu0dzK2HtWY1kfzap9Op?=
 =?us-ascii?Q?Ns+WI7CmmB96N90DC0/MDCAccUyskJlVE3J359tOpuNX/+pAPu8BETfDLnTt?=
 =?us-ascii?Q?YpHpV3tFGpbgEHG/LmAAXJThl6ZtaeZCJELyJ1fudSfPQzbQLQ0j4EFs0X10?=
 =?us-ascii?Q?XJnLwANB1fPYXFznxd07PzK+P7eq52uKBVdQI2B6Z1RnUlFAxjm7/kC6UXzD?=
 =?us-ascii?Q?yBzQ2QS2mb91jk6D43jTudmm/uZreiMNuf9hyrtBffTDUQHtQBN7Siyk+8Ys?=
 =?us-ascii?Q?lSi3Xy4S7AcnO7TNba0gEJjwFeweF7551DJR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:10:46.4724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a75970-404c-476e-3e21-08dda830fa42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263

From: Dragos Tatulea <dtatulea@nvidia.com>

This allows calling page_to_netmem() with a const page * argument.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 include/net/netmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 386164fb9c18..caf2e773c915 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -143,7 +143,7 @@ static inline netmem_ref net_iov_to_netmem(struct net_iov *niov)
 	return (__force netmem_ref)((unsigned long)niov | NET_IOV);
 }
 
-static inline netmem_ref page_to_netmem(struct page *page)
+static inline netmem_ref page_to_netmem(const struct page *page)
 {
 	return (__force netmem_ref)page;
 }
-- 
2.34.1


