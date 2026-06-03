Return-Path: <linux-rdma+bounces-21677-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T7vMDlYCIGrOtwAAu9opvQ
	(envelope-from <linux-rdma+bounces-21677-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 12:30:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E53BB6369C2
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 12:30:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=MWob5gAQ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21677-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21677-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6161130D6B75
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 10:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6F13AD514;
	Wed,  3 Jun 2026 10:27:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7283D564A;
	Wed,  3 Jun 2026 10:27:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482469; cv=fail; b=nvS8wH0G02/+Sq2ksdS9kmrpogDbRZi7I5SZcJZWTXoTS+TmfSX4yo+v5QCV9+mHgvbZiLSjxAHC5uDgDO6g/5QJvY2HBs+aFkeKKwwRmyvjnyK2Sa3f4r5Ltoe1mymWtT1hbPdf9lEEcP1T3QFCZT2kuN0YmZyNnpjNLOWkVV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482469; c=relaxed/simple;
	bh=W/9/xY+l4VAQcHa5GsTTLq0906D99vB5j70yy7o7DIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MymHyvqWSypZx82UpyxMBDZNJR2MkCbXb8o42EGYiu7eny89QxFsbJfLQD+VQcH1//Wk4MiVDzQtB8+b1donpEOA6Hiyc1IGQvA4FgOYAurhXsax3eS6fxuqUmb1MXBYUMBmHaYQuFQYV5WQ92ZYbYa+xUrBdSp4u5lzgbGN57s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MWob5gAQ; arc=fail smtp.client-ip=52.101.85.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Te7T5CtEId2loI2nuQi4WtyJCJsWSVc0/vmSUzLABvePAEN8zwyku8KmPw8islqqPZc+f8mgTuI/MsIbQo6Xvfw1/sf6B1lwENAYwK5Ahii2lGckwhfHGUD20O5nxEiOM/fe4GtAR2390EO2qvD7jxVh/20KNuZissOAOeucnn+NNIoCFNk35/NYXY6U4e8BUwTjpZdQ29MbUOJub1kxJdrPGxZIBFTbVupMj0fU8e4Gslk1vxw0HqKsVVdRSyAdagsC0sgqn9h5RtVfF7Hu8NitOCGb6lSa1XSA8Kg4j53CILb9UTS55LlJ8VpCAjb6yQtlpw0vK/gfwPN3uMBkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xtnRC7N3IgjAiKuwuFW8jFzNniD0lhN2+ojm8D4XJI=;
 b=SAlHNxMQH2S/7lW8LhA9gLXEtpLoHBYrUaqkYTE2LVLQBq75JTpmgwE9P954R94Rx5CGRTTM+GmgsErWr4lWjkpvoM86MqygrW4WoWZ37/iBGnmnSDG90aY3DdO0hTlfzEIv9DThyjPPyihTULuSSrFlkdITAtpDoY69D6evQzU4/KhsInAp16EJdq0yMEiMdYHi/8e2U36TA1VSP1IH+LNyQ0Yqk7qF8KAyK/lEl6ARI9hJLYKd7U7cRw5jgIJFgCzTfIxV1znuRSQEOwRoRaYzhg7WDkbxwOVqfaMiHVUKAyVZajX+kPJH670sxQN+JZs0wEIXowxN9SdoinwjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xtnRC7N3IgjAiKuwuFW8jFzNniD0lhN2+ojm8D4XJI=;
 b=MWob5gAQY5+15TP9TzOBtnyxJcq5F7pL3I7jGaDB3iLOq705pN+4iKhaClF49tYHG3T0LNNRKBfY4Z9fZ54kmS02CQI7CB/725jBjXQ9vFiFU6FwJIcozJ5svbRtBr5MCUtwTfTjIll7uWjgjO9zo06TsbPX/ofiSwOActuXwySp296iI6AhuGUzhBYkZdR6xJT9pdzmC3vHKSqtvv9O172Nwk4cf+XqhMPn6Ekyy/MEWqrntVUNai7YVqtdrO5cuhJGfhJIZXNQB7UETVX6a55cpFpR7oov55zrVdO26tnJ0D1i4Hd+5mhoJPRY/MTun3FJnF5nOd6NeW8uh2kmow==
Received: from SJ0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:33a::34)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 10:27:42 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::5) by SJ0PR03CA0029.outlook.office365.com
 (2603:10b6:a03:33a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 10:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 10:27:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 03:27:26 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 03:27:25 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 3 Jun
 2026 03:27:18 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dumitrescu
	<vdumitrescu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Arthur Kiyanovski <akiyano@amazon.com>, "Petr
 Machata" <petrm@nvidia.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, David Ahern
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Amery Hung <ameryhung@gmail.com>, Nikolay Aleksandrov
	<nikolay@nvidia.com>
Subject: [PATCH net-next V3 2/2] net/mlx5: implement max_sfs parameter
Date: Wed, 3 Jun 2026 13:26:46 +0300
Message-ID: <20260603102646.404797-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260603102646.404797-1-tariqt@nvidia.com>
References: <20260603102646.404797-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1e5e8b-bdd2-4206-5067-08dec15abe6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|82310400026|376014|6133799003|18002099003|3023799007|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9uiDewN8CyoB4FaxGQu7yHkRzuUW1aIznvp9JJf8vHYPENQKlQHkWJRVqNlPjDdj8KTOq1OeqP4V2CTz3KuNilJIanu0DPverTP1F6hfgkGjU/o9brnz1bBxl1z8/sMHg7LjvkTi0IEdKKP1S9gpN27+EYSOaphaMqM4agKA9TVSrG9w5Ms6j167aR0nDYsX2EmfePY9kjoxHcZrfGHPOH7IJSh3AdUKbSw4nmfOHwyL6KU6J9SVdDUGoqSYXJ8MjQpZ6A2Mr8Mi+Gyf4Iasm1AESrSO1PIMH6eREC8UwNvl5JyUmpdhebG1OOg1P7nJg1jV272yOaaJYuInBgQjIIUZs7WmQ8oODKFJPBipM6As6n+Cp35p/mQdNWlVMGhXe1y9YHrNOCYXp1YkyASDxCHXAKDXqbcYmCoCPw6Ivws6Q8tIDCdNQJZZGbWG3mNI4IfY9Zo5doSZRBbHwM9sWrkApU5Fz6kVhvogsJFHw3nlllx/5rRFFjKhOdHnsCiQ0NQakFpMJqS3E/AubiZKzqE1wVMIPW7OCafj+fTYI26EIAPJYswApNYUinO2et8I8B/IWtCLH1IofbtmlnGWlVd7iTJWKzD+Fes+BJn9m7K4FGAJ50B0dILpxzhIIgzpkC4RQ0pevBt9IIu2A/ognc3tcS0hvrEBU8bzV7KEwWX9S0WXQ6Z0xNx3uiByEkT+wt5X8xt0zGhEZJ7FUYOwmRks9wgsWYBSe04w8LCL9tI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(82310400026)(376014)(6133799003)(18002099003)(3023799007)(11063799006)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VD1DdI1S2iCQDEmTJjcC/ghJLAWjclBvYrbvkpetW+JKPMoHC/dv+KaRgfZqmblAyKlmF1PBf4PVZFZEyJONle84ekSXybSXmfloZvO9/UsBvIYGvLnAAEQT0Yfn3T3+y0uI+xwCUR7OONe4N+BSCUlAmwU7v58k6xOiTttDT/HFtGn8r62EvI/moj6DpMlKfIaBpggUwvKTkbrTzwDYvLXISyoTzJHEUfIhTadyks26LTrr+pN+HO7IbPO2Xqi37T4GUFezyd6n04IhAvMBCv0QuVhuX3Kg0QHi1MXYUYUsoeqz+yG20LhXS0ZtXE46N01zDD906ay9HA1ZlAy63Pob2q7gzkZiaLr+8cJdvcKLqeynCPl7xLZNfj6YZ5Yf5ZJcp6rL1NzuX8qmDRVioOT7q+kpBTd1ry/nK3jjX91J8Q8PU4xxO7YRnrAjg9fi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 10:27:41.7855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1e5e8b-bdd2-4206-5067-08dec15abe6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:vdumitrescu@nvidia.com,m:daniel.zahka@gmail.com,m:aleksandr.loktionov@intel.com,m:przemyslaw.kitszel@intel.com,m:akiyano@amazon.com,m:petrm@nvidia.com,m:rkannoth@marvell.com,m:razor@blackwall.org,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:gal@nvidia.com,m:ameryhung@gmail.com,m:nikolay@nvidia.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21677-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[resnulli.us,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,gmail.com,intel.com,amazon.com,marvell.com,blackwall.org,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E53BB6369C2

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Implement max_sfs generic parameter to allow users to control the total
light-weight NIC subfunctions that can be created using devlink instead
of external vendor tools. A value of 0 will effectively disable creation
of new subfunction devices. A warning is sent to user-space via extack
(returning extack without error code is interpreted as a warning by
user-space tools). The maximum value is capped at U16_MAX.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst     |   7 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 118 +++++++++++++++++-
 2 files changed, 121 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 4bba4d780a4a..f5e2dccafa5a 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -45,8 +45,13 @@ Parameters
      - The range is between 1 and a device-specific max.
      - Applies to each physical function (PF) independently, if the device
        supports it. Otherwise, it applies symmetrically to all PFs.
+   * - ``max_sfs``
+     - permanent
+     - The range is between 0 and a device-specific max.
+     - Applies to each physical function (PF) independently.
 
-Note: permanent parameters such as ``enable_sriov`` and ``total_vfs`` require FW reset to take effect
+Note: permanent parameters such as ``enable_sriov``, ``total_vfs`` and ``max_sfs``
+      require FW reset to take effect
 
 .. code-block:: bash
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
index 4a7275e8b62e..899167a5cd92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
@@ -68,7 +68,9 @@ struct mlx5_ifc_mnvda_reg_bits {
 
 struct mlx5_ifc_nv_global_pci_conf_bits {
 	u8         sriov_valid[0x1];
-	u8         reserved_at_1[0x10];
+	u8         reserved_at_1[0xa];
+	u8         per_pf_num_sf[0x1];
+	u8         reserved_at_c[0x5];
 	u8         per_pf_total_vf[0x1];
 	u8         reserved_at_12[0xe];
 
@@ -93,9 +95,11 @@ struct mlx5_ifc_nv_global_pci_cap_bits {
 };
 
 struct mlx5_ifc_nv_pf_pci_conf_bits {
-	u8         reserved_at_0[0x9];
+	u8         log_sf_bar_size[0x8];
+	u8         pf_total_sf_en[0x1];
 	u8         pf_total_vf_en[0x1];
-	u8         reserved_at_a[0x16];
+	u8         reserved_at_a[0x6];
+	u8         total_sf[0x10];
 
 	u8         reserved_at_20[0x20];
 
@@ -158,6 +162,8 @@ struct mlx5_ifc_nv_sw_accelerate_conf_bits {
 #define MLX5_GET_CFG_HDR_LEN(_mnvda_ptr) \
 	MLX5_GET(mnvda_reg, _mnvda_ptr, configuration_item_header.length)
 
+#define MLX5_DEFAULT_LOG_SF_BAR_SIZE 12
+
 static int mlx5_nv_param_read(struct mlx5_core_dev *dev, void *mnvda,
 			      size_t len)
 {
@@ -755,6 +761,108 @@ static int mlx5_devlink_total_vfs_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int mlx5_devlink_max_sfs_get(struct devlink *devlink, u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	int err;
+
+	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to read global PCI configuration");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	if (!MLX5_GET(nv_global_pci_conf, data, per_pf_num_sf)) {
+		ctx->val.vu32 = 0;
+		return 0;
+	}
+
+	memset(mnvda, 0, sizeof(mnvda));
+	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to read PF configuration");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	if (MLX5_GET(nv_pf_pci_conf, data, pf_total_sf_en))
+		ctx->val.vu32 = MLX5_GET(nv_pf_pci_conf, data, total_sf);
+	else
+		ctx->val.vu32 = 0;
+
+	return 0;
+}
+
+static int mlx5_devlink_max_sfs_validate(struct devlink *devlink, u32 id,
+					 union devlink_param_value val,
+					 struct netlink_ext_ack *extack)
+{
+	if (val.vu32 > U16_MAX) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Max SFs allowed value is %u", U16_MAX);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mlx5_devlink_max_sfs_set(struct devlink *devlink, u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct mlx5_core_dev *dev = devlink_priv(devlink);
+	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
+	void *data;
+	int err;
+
+	err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to read global PCI configuration");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	MLX5_SET(nv_global_pci_conf, data, per_pf_num_sf, !!ctx->val.vu32);
+
+	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to change per_pf_num_sf global PCI configuration");
+		return err;
+	}
+
+	memset(mnvda, 0, sizeof(mnvda));
+	err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to read PF configuration");
+		return err;
+	}
+
+	data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
+	MLX5_SET(nv_pf_pci_conf, data, log_sf_bar_size,
+		 ctx->val.vu32 ? MLX5_DEFAULT_LOG_SF_BAR_SIZE : 0);
+	MLX5_SET(nv_pf_pci_conf, data, pf_total_sf_en, !!ctx->val.vu32);
+	MLX5_SET(nv_pf_pci_conf, data, total_sf, ctx->val.vu32);
+
+	err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to change PF PCI configuration");
+		return err;
+	}
+	NL_SET_ERR_MSG(extack,
+		       "Modifying max_sfs requires a FW reset and PCI bus rescan");
+
+	return 0;
+}
+
 static const struct devlink_param mlx5_nv_param_devlink_params[] = {
 	DEVLINK_PARAM_GENERIC(ENABLE_SRIOV, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
 			      mlx5_devlink_enable_sriov_get,
@@ -763,6 +871,10 @@ static const struct devlink_param mlx5_nv_param_devlink_params[] = {
 			      mlx5_devlink_total_vfs_get,
 			      mlx5_devlink_total_vfs_set,
 			      mlx5_devlink_total_vfs_validate),
+	DEVLINK_PARAM_GENERIC(MAX_SFS, BIT(DEVLINK_PARAM_CMODE_PERMANENT),
+			      mlx5_devlink_max_sfs_get,
+			      mlx5_devlink_max_sfs_set,
+			      mlx5_devlink_max_sfs_validate),
 	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE,
 			     "cqe_compress_type", DEVLINK_PARAM_TYPE_STRING,
 			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
-- 
2.44.0


