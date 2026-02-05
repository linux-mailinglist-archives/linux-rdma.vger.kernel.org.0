Return-Path: <linux-rdma+bounces-16594-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHbzOm2qhGlL4QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16594-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:34:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5210DF4122
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D34C9300C56C
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F433F23D9;
	Thu,  5 Feb 2026 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YVsPnTl7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29CF22FE11;
	Thu,  5 Feb 2026 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301911; cv=fail; b=qYcKQFZj1Rprpgsx4LIP7BsKj+Q0D5GeadAXRVgVKxkxooMh6f4CpRg+B55LwgRi+hjbbNZlSt62zC61lk4HQ5g/y57UoEfKuchmMMMIiGLa0+CiHGmVQchCR24QbNVK8vjrmfeAkToXwi0S+xYLJ02LqGpywBm65hBlL2vAwpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301911; c=relaxed/simple;
	bh=C1/qlCXlY/g3y6rDUqeYFl5SPwQsnVqfSAbGos7cdP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnMV3CVEUjQgetcFCIhrHmv5ArKcE3WsaC+RxkVIck5dv8te54JACSuemV3+VUeqTDexHjUDhLYgUkOOheXS6OZxW2WJdBdz7UPZknfRivDlTgWdDSkypZz8hOpXQ3ae55VDA2QSo6DD/IucoBI6NF2DGSD+moojux3aPvp6CV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YVsPnTl7; arc=fail smtp.client-ip=52.101.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C58/GDp3H1IHQzy5qwXuWUIUXKZN57A/QHnP9TjPYxOTQDOHX3HaCUtmMQ/vIXRjSi2OZFPfNT34eYuUfakVyICuIYaMZ4ipKfbiqI2FdSd9a0PmtvvPSJw89puFU8Wsg4G3tZaLqlYrjSZ85j4u3Kzq8bjT3cYvHs69IbA8fbbj2fPSWBBoKtbXr44c51u7ztNO81JKqSP5xRcHlS9NwmZn1+oembVTKRlj4oVd3SeZf0KKyIUCO3uG9aB+4KzkFqsp8tAQQnejq8DhPg0n8ls+IJPYvusU8Q6diCIq+P8rr9kuox7wl4uozqzoxTi0Hjcr59yT3AP5kWpMJJmq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsCch8jB9WVgPCnIxO6po+wWaLa7sxXat+GS5eT1eeo=;
 b=fakm/B2474prh86XCSjzZ8hnBQ8gxxhXVNlL7vbYvS76Yc9L7mIFRPa0fSqhvPCoyd6KGFa5IjmYN05QR8klPGxAq7BCGy6zoXQeYsdyBu4XDxQL9KPdHBl3Bdw6YYLZhfR8ZeAzrCyoA+LIPbdclKSDzg0fC40ErewPLB9ZMzPRsE33bXg1hRc5ft5JkYHfOoJXJVkheEraTZ4+8TVcOhFGUMU5qdDiGqnDmVNTh5C2Lv/UscooUqsTxGETCBgAWh0q4E4TEretGdCumTEANswwNSslMh6hjCOirF5d4VhRgTPLN/Rj5gHZdTHG738Wq6+ySsFZAwgfx/64m6++Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsCch8jB9WVgPCnIxO6po+wWaLa7sxXat+GS5eT1eeo=;
 b=YVsPnTl7tbWj36lWtp0Uqc2Pc9Dpa46kJjHv5lZYbDHLFRy/DLAZypAYY3DB3NA4ibnmHJTd/apS+0/LTg+lXYKNFqeZj0CQStZbhbbZXEnm5ihzkYM3pN41zMYX/yiR9nCWLDwiOkM3hKuHhZBy9bGO0K2rFVA8hD0VdX3i3Xd/7QVsG5qRWMyyEOQDwcB5b3U23haQQ+FiIMUJg4EFELm8gyN9sgAgGowHe2dnJG27p8aB4efbJhtUucfnDiqgPFMtWK9kZb2giJPZxjs08cKgdi+e6nmvVwwsrVotcyWcnOrKpP//CDvyztF2fBgbyBPNNLK5MvzM8mrrSBydNw==
Received: from CH0PR04CA0097.namprd04.prod.outlook.com (2603:10b6:610:75::12)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 14:31:45 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::4c) by CH0PR04CA0097.outlook.office365.com
 (2603:10b6:610:75::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Thu,
 5 Feb 2026 14:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 14:31:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 06:31:21 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 06:31:20 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 06:31:15 -0800
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
Subject: [PATCH net-next V2 7/7] devlink: Document port-level resources
Date: Thu, 5 Feb 2026 16:28:33 +0200
Message-ID: <20260205142833.1727929-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260205142833.1727929-1-tariqt@nvidia.com>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 5835a10a-681c-4c6d-2306-08de64c3494f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yqgn+PzhofIMIskHf9hWtVN7PT6nt5AI7jtT2C5ZAdX6U5F7EpnuV2i7aO1u?=
 =?us-ascii?Q?45VIlYDSGc648q2ujO4M3PRqZDJOK3pjNWub3wK5QyJ+RkNjjw4ZOk2aLb4/?=
 =?us-ascii?Q?DJYc+RQ7Yt5esSKIfGyK3RSxRgZpXvIZo5t9be9QCbeo/3/K2Bv/ORVnvymX?=
 =?us-ascii?Q?ByaG1Mgu1HpOTRrFb7urO3Q6uV0oEGz9Sd3ed+pje763xV0h46OdMXaSM5B1?=
 =?us-ascii?Q?5HsR+0CKY3DNDOvJ6siYMikKyUkwLvy2qsvithm6/LTwjG+C2oLKyK+2lbe9?=
 =?us-ascii?Q?tH3XizePLlMVpXPrtIDwK3m/T2RaJ6X4sKzE7y0gwO7HM2DVOTP95k4AatGd?=
 =?us-ascii?Q?Wh5jFkIiYHjiVHdGhvujt4ctpE/RAL5zRH9mQnHrVieGT1gCf+qdP+TdU4Pq?=
 =?us-ascii?Q?KrD2ngw0WNpMqjuH6ZSl5CWAkDdMRlgDICQBd6tAQJF2515xPEySrhCRbcS3?=
 =?us-ascii?Q?9Q+HiKeeR7LxRLbBJ0oKFG6NNfuzIK+nbtapDqMvH/dZwDkdhITSy1u2gANW?=
 =?us-ascii?Q?29hdNen48RgE0lawqXCosn98RHs4pCQ5YQzvC+KIIR2X4k+7M7TMeV9BCM5s?=
 =?us-ascii?Q?1xvAck353/xhuMqtHMgBod7H7CL/iQJcBUSuaQ1bgyOK3vHbj58QYVrrQr5O?=
 =?us-ascii?Q?KHOZwR6FrXyNnmFv3mCleDDIIEoGy4b4l4gaUYAQEJCYrDkQVhCWubCj8TiS?=
 =?us-ascii?Q?oXRWbPVTF6Lkedw9yOUiWSxNhDnNiap0/vERBAX9hihcYvZF6cNRyYf86PN3?=
 =?us-ascii?Q?19PzOzdbWUEO1K5fwUAZpGxX6SNMvlqnrWHlcIhUTgxe/hK2oGa7bF/Awqug?=
 =?us-ascii?Q?ql2o/380mAvFroEZu65XAivhMKBA4JmfcTdmRQn0mlXaM1Yv9AC84Rm2dKAE?=
 =?us-ascii?Q?ka9ApIOlHq+SspQZJx6WaCsdEKRdTQ0Iuipm/JFbKU8b2k+k7A0yT1yNp0Pm?=
 =?us-ascii?Q?ytDmuP2KDyT2kABv9ajoTe/Habo6SlxHy5JEDIpcu++pfkyP3gz6uHQnzvOF?=
 =?us-ascii?Q?MjKVs8W/U8+SnM17/naK39wlFcTtUDAlf6aplBlOiNZBkzWQathelcxvT+37?=
 =?us-ascii?Q?dpbEvk0CwbpsQ9+ApeYQ/4Kn6Zk/xaloSiweP4E4u/8OhYFsiMbU5UuaXGFf?=
 =?us-ascii?Q?9Lo5h2M7hOCBM7tAVqh/r6ggbmXChLqdKBjvai8VWkDYBzJPDrINM/VGFOIn?=
 =?us-ascii?Q?KCtjiJQCZBjk/qTwTTiroY1FIwDNvxjVom4WlV2hxAR6aDu5rGcro1c2f5LD?=
 =?us-ascii?Q?WGCkeQmC5eOJlABub10bwUNYt2tDnXlrE28vJpp4J+dmOiBrDX0LdBMl7Znm?=
 =?us-ascii?Q?t9fqB9nWgyMQkXJl/hyKzSMQdvNLZ/1qHnLd7/PxygMMSUN9Ux+cNNNeM+Iz?=
 =?us-ascii?Q?QuRDPIVm/4FeX+iR0pvcyaX+zbHg9C71Y5UgXuk+ZZF06+Bk5d1MdyWrHXqN?=
 =?us-ascii?Q?Frr8AORsaYA+ZFjI9qzf7jZR4p4Tc1KsASTTlE4km/1/AaG5xv43/Un02C+y?=
 =?us-ascii?Q?ksKxoTtAoswLQRTlU2MVRCJvxK6tsmFPVN6h+hWaIt7vMkqgVvyoFPPfnDwA?=
 =?us-ascii?Q?LzEFtPT0iYGfoDsBZNW/FzQ0F9+uuubFQMdVCI8umKyZSMmFO+vb3r24XCMc?=
 =?us-ascii?Q?p8NeywkquLofK32iTjMCK9LxS8dFm3DJ0v+XBW0F56QP/2kzebOgeNXRkY+O?=
 =?us-ascii?Q?M1PNFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1ri8maCkY+p2FxY1VVy6Qh7PuUilU9n36qEwGV8PlKD1cU5Sg1V8dTSbyGdfkWgYd7WzIfQ7/Dhpi2Z3+ygdbsOQN8sU+fcJHf/dXKCVzJBgzjOP1wNHWH68ZClgvVKnnz51pf5tAiOsPFbFXib1bqGktXxkAqsWtdB+e9HkB/mZhodeOuEZ8nMYOuFlEUdcalfPoK9gcsQ+ZKm6s+dhDStL+6CpbrZy6gV1q0BctzuNxmzXaTImvtCS41ZX/LUN8cDj0cOHHoe7bjKmLeIpETfK8Xr48Eql0CyH3PDmDObcu4JCCkUEjjbeRrh0wMkXU9rNK8qH4lC2tOChUnKVx4eGt4mz0Cibx19HXe0KfXB5ZxJaUQJ/OKmpO60s0SgX6+R8oORp0YGYSfQc9TNXC50s+8TS1LTTGOdQZgdRYTKkAhHrdbcuuZKVA2zcnltB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:31:44.3252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5835a10a-681c-4c6d-2306-08de64c3494f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16594-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5210DF4122
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Add documentation for the port-level resource feature to
devlink-resource.rst. Port-level resources allow viewing resources
associated with specific devlink ports.

Currently, port-level resources only support the show command for
viewing resource information.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-resource.rst   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-resource.rst b/Documentation/networking/devlink/devlink-resource.rst
index 3d5ae51e65a2..c2bb7e429a26 100644
--- a/Documentation/networking/devlink/devlink-resource.rst
+++ b/Documentation/networking/devlink/devlink-resource.rst
@@ -74,3 +74,39 @@ attribute, which represents the pending change in size. For example:
 
 Note that changes in resource size may require a device reload to properly
 take effect.
+
+Port-level Resources
+====================
+
+In addition to device-level resources, ``devlink`` also supports port-level
+resources. These resources are associated with a specific devlink port rather
+than the device as a whole.
+
+Currently, port-level resources only support the ``show`` command for viewing
+resource information.
+
+Port-level resources can be viewed for a specific port:
+
+.. code:: shell
+
+    $ devlink port resource show pci/0000:03:00.0/196608
+      pci/0000:03:00.0/196608:
+        name max_SFs size 20 unit entry
+
+Or for ports of a specific device:
+
+.. code:: shell
+
+    $ devlink port resource show pci/0000:03:00.0
+      pci/0000:03:00.0/196608:
+        name max_SFs size 20 unit entry
+
+Or for all ports across all devices:
+
+.. code:: shell
+
+    $ devlink port resource show
+      pci/0000:03:00.0/196608:
+        name max_SFs size 20 unit entry
+      pci/0000:03:00.1/262144:
+        name max_SFs size 20 unit entry
-- 
2.44.0


