Return-Path: <linux-rdma+bounces-18691-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBwsL6jbxGkq4gQAu9opvQ
	(envelope-from <linux-rdma+bounces-18691-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:09:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3C3330423
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 314813066BDF
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 07:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BA73A9623;
	Thu, 26 Mar 2026 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rSbtKjeq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013026.outbound.protection.outlook.com [40.93.196.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DEF34C140;
	Thu, 26 Mar 2026 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508536; cv=fail; b=PEw8w8L24V+DenuocYHPpG8Ino4MBo9afxknX2N4t//hGta1V4DhF+ESBXIFFVPwhXXmBMpewx/9BMTaWAmwnninCE0dktbiNQo9OhCKanDIXhTudVyoqnVfIw5eSQpew2L7W8TleD8kFf15r0S8GxBEnl+S092sA6zPx9a+NtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508536; c=relaxed/simple;
	bh=U+jRQP0+gtxO5B20GtBqzbI5RAKuRhakmRfRMn0s5e0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxl6qmGYJE55SClTUoQn2HArBMXPA21nYP9LKIFT4GPQMw9aX1EINmFGqlcuenxvgJDaG3P5v8CQBf9XWezIdxhff8r8H4gOHT56jXdCUn/qnG2+h28y2mL1fJ4ouql8sE4S0VeJGuUj1LICzwmXj3HWzm8pWR1hx7cXxl9aCzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rSbtKjeq; arc=fail smtp.client-ip=40.93.196.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+3inGrRKBafnb6LoLYy3HiDx0EwCLsRt2vgC/XK6QwQDiw3XJMDqim8SxRnFcG83Rr+iO7GvQRFBbZuWnRgkyzfas3qPk9mZomFIelxzGavlOzgCNqWXvDJWx166KaXUzVQrnlITEnD0QVLGZ6VJc1VfODnKCEDoXYyM+bE8rAoSvzocUhBvItBnBm3TFycWZOaA0T000lurMkfZ+KmezwA7rYu9aPTPdSLZ8fmPl6ADeFJwsu8umwR0Ig9pYhEKzFDLnRxGP6j0NkYItB2V7bJkpIQr7gth1RiLWgIX+Oa1KQJ2dRxpg3U8gTT2sWBRN+dji5FQAV8grOKpc+YyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jz9K/OyMbIfKrOzNc03+7zFjT7ikB9qLAGavuipoF1Y=;
 b=mfbXzYWzyqvLfmlLlYIczAwpH1lnfoEW+owgeBvtDWb8WqDnYoA/NFYY42LMG6HZtsV9nh3BzspBtpkGqci1bHbNLyCWWUJvrc+iI/+qcPijmYObF2aUc2x9wtKlABxFqvuVe/q5l18hpQ5pJa4TM8Iq6r37uQkBqJV2X37vA/WRwqByn4VqKZmLDh7kHmqsGv2aukxlorB4gLF4JSL8YWBJmJtlNT8Ek9WPHsFXV80myMSjGnemTuJW/u7ZAS0+wlKbC/PQeo0m/R3ELtO1lLE3Ol7dcaLyPtOjxjwcgDRCKOiAHFwW7SGh+R51wshZkPhwlXeyvq8C2fYfn47HFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz9K/OyMbIfKrOzNc03+7zFjT7ikB9qLAGavuipoF1Y=;
 b=rSbtKjeqGRRokLgkdsKSu7yvMA1AC6teizc8vzi2ER9VlDX6/PZyh/GQEZsJMtFbDJgHL+9KIYjb2cpk5xZn12BiGRoEwIKWM1FQu8UIibjvcFnidLJfN8XbtahIfAefqi9XbeDuGHYBDBJ8zM91DhR1hY5R7nQw0E+joqCazGW5JLqbQaNu7Dq8ntGUrUiyuRue3Dk/e3ZUAtYQlN3CFBYWyin+tjQemD6L8dKryg7NoScmzAwszdbQIvIw8Wg+6P4+g8txx+CUcSZVNRp2w7yXdxNSjunwd72AYsmgk32vWEAVHemTzbnJw4+MztYGWHPki1XxTIPxm2pre/l6zw==
Received: from BN9PR03CA0077.namprd03.prod.outlook.com (2603:10b6:408:fc::22)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 07:02:08 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::55) by BN9PR03CA0077.outlook.office365.com
 (2603:10b6:408:fc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 07:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 07:02:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 00:01:58 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 00:01:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 00:01:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Shahar Shitrit <shshitrit@nvidia.com>, "Daniel
 Zahka" <daniel.zahka@gmail.com>, Parav Pandit <parav@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, Kees Cook <kees@kernel.org>, "Shay
 Drori" <shayd@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Daniel Borkmann <daniel@iogearbox.net>, Joe Damato
	<joe@dama.to>, Nikolay Aleksandrov <razor@blackwall.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, "Antonio
 Quartulli" <antonio@openvpn.net>, Allison Henderson
	<allison.henderson@oracle.com>, Bui Quang Minh <minhquangbui99@gmail.com>,
	Nimrod Oren <noren@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V9 09/14] net/mlx5: qos: Expose a function to clear a vport's parent
Date: Thu, 26 Mar 2026 08:59:44 +0200
Message-ID: <20260326065949.44058-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260326065949.44058-1-tariqt@nvidia.com>
References: <20260326065949.44058-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: e88992b7-1c29-495e-6d62-08de8b0598d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	m3cDePO8Y7K/W5CEf0y5Z+03VCJQLXHcuZ/8asGRq4Nojp1WiLBlWiYckjov9bPBtNQlBHxAhYJuBriC/FKPnjQH0kNJ7kdEcvFjrJ7FgeeN4qM/BleUFzMZl3Ebxgs4o2XvPF1gKrQU+fakmmA5SivWyiZqwgRQPJgydVz09VNJ/0Mk76f0qqBNJ7yUmROlj0gqGermyr2hnyOXLuEE0oxigSvyLnPm13tJiLHzYKV081suBQ2qHAXSvZd8bT9pqjHUdGD9bX4qxBc+Tbb2VGq60kt1yLBCgspAzru9uNt4KUHTxz+DktnHW+gspiiFfUAEaVUIGNVU+To7mwUGm/iBB7vn8OSvke6fcwqseYNfXCo1JgEeYX1VoFl0w2uvv7sRmOsaYEWlh89bGfGcIJFVl8f47OvVx6Nsa7LpcjEX/G3DjH/8vtKFMb1U2LmjyqSnJu66nkIFL3I+Mr5PDSW5zYzxYGZvYja9hJ8y+JEjADutxtLef5SGL+Oi/Q6d6V2SZGs3yImNkHkPv0H8t1cKDttZ6v9yXmPMzNjNmiPDbf3NmEAUgWcZqMAFDn+2UOIhDjCQz/FlKzBb/5azglxSTqL6+mHZEhpa2221tbZLPMDIhpQZ/3k9aiUZeWPP0oUL1DtgU1L6EkGvQG2Fix4WL71B/kKEOKtES8UDW+Sb+Pld1TWyoZvCHvgDme/QX//oR9k/mYE4iYB/3YBYzRsnS7IME33JmbAk+YRszp/fANbm9He2nDvQYhULYr+B398DSP2cR+N3UWJ+zBYvBg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LLyWjKvyFiuQCo+/KT/YoyRRP4NJd/PDRe3ZdkJXq8F0h7hnuL0DxGHEhPu2jZftTQncDp5zYUIzIDhKM3fxZ2Yx5VtbfBQJ9Kp2Z0R8PL704Yy77vgpR7DOgm+r8zrhMs6k7Z0mYckGZC7naFKuYGY5RbMOhXsZ6637cueVktc8roWxrjuqIiOnSjniP6UIM9Vz28owas/NfUodJh9x9tI8xkTzu7omwOW+UYnLzoc8pL+ya9qwXRlXA4PFSVC8BgKOF7BBSpoPrAQHpTQghq39JL/2T8c3cohB9i74gmZ/fqzmHLIkWKqgHoYB4b4pQ+WnQfNkf82ohaVEMO/5YBML34BVOKL6TZeGBSYcwaXjalQtoXRtq4ykAtyIA3Xhtu8QHFhamQCf8cLit62yrnwfaZ0ti61MEuEUOlj73Z8DX6TmK94KBA1H79wx6jWv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:02:08.6408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e88992b7-1c29-495e-6d62-08de8b0598d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,google.com,davidwei.uk,fomichev.me,iogearbox.net,dama.to,blackwall.org,linux.dev,redhat.com,openvpn.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18691-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1F3C3330423
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

Currently, clearing a vport's parent happens with a call that looks like
this:
	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);

Change that to something nicer that looks like this:
	mlx5_esw_qos_vport_clear_parent(vport);

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c     | 11 +++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h     |  3 +--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 8bffba85f21f..6f884c4189a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -204,7 +204,7 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_vport *vport)
 		return;
 	dl_port = vport->dl_port;
 
-	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
+	mlx5_esw_qos_vport_clear_parent(vport);
 	devl_rate_leaf_destroy(&dl_port->dl_port);
 
 	devl_port_unregister(&dl_port->dl_port);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index d04fda4b3778..4781a1a42f1a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1866,8 +1866,10 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	return 0;
 }
 
-int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
-				     struct netlink_ext_ack *extack)
+static int
+mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
+				 struct mlx5_esw_sched_node *parent,
+				 struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err = 0;
@@ -1892,6 +1894,11 @@ int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_s
 	return err;
 }
 
+void mlx5_esw_qos_vport_clear_parent(struct mlx5_vport *vport)
+{
+	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
+}
+
 int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 					  struct devlink_rate *parent,
 					  void *priv, void *parent_priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 5128f5020dae..a5a02b26b80b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -455,8 +455,7 @@ int mlx5_eswitch_set_vport_trust(struct mlx5_eswitch *esw,
 				 u16 vport_num, bool setting);
 int mlx5_eswitch_set_vport_rate(struct mlx5_eswitch *esw, u16 vport,
 				u32 max_rate, u32 min_rate);
-int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *node,
-				     struct netlink_ext_ack *extack);
+void mlx5_esw_qos_vport_clear_parent(struct mlx5_vport *vport);
 int mlx5_eswitch_set_vepa(struct mlx5_eswitch *esw, u8 setting);
 int mlx5_eswitch_get_vepa(struct mlx5_eswitch *esw, u8 *setting);
 int mlx5_eswitch_get_vport_config(struct mlx5_eswitch *esw,
-- 
2.44.0


