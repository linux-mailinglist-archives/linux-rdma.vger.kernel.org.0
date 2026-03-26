Return-Path: <linux-rdma+bounces-18692-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDgIAe3axGkq4gQAu9opvQ
	(envelope-from <linux-rdma+bounces-18692-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:06:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B49CC330357
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FDBA30D0BF1
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 07:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEC93AE6F1;
	Thu, 26 Mar 2026 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aIctHaPi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299E539B947;
	Thu, 26 Mar 2026 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508555; cv=fail; b=sk8VEImnzJWTjCzXNeX/TiGGcz+CGSkwJ2KquLsOse1CliH1qB8mn5TPA8gkWlz9PXE4Cq1xzwbak6nRqh4k9OSsrzpPqbIz8cucGN2AviPucbaK6nDbCrtbaAoONDhIU20sXkB1Sbt4+2JhhFR9Wh4wGZqYnslWjkYUZev1MYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508555; c=relaxed/simple;
	bh=z9bmY89BQNYi8SW4sMyTG3pJn2i+Cd6D+f9umeXjSnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n07RZmVGxyyCfrQWvY+Luu5FtOSYx15hbP6QhZE5GrUFKIfge56mJaWSEmrtwoRig1BQE4GCo2lM/hOwwX0l9w6vHB7JAQSNhM6UtEx929EH8PCkc/mpfElMJtEAfJ8rI9EAYLGh6HyN+gfrGX4mgkZBU80Rrgugbq7sdMkyPiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aIctHaPi; arc=fail smtp.client-ip=52.101.43.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alsXvXeMhRg1CIukqGN8i/qCprJEwBjJ2584HrtdWU6OWC6EtnWBVFuA+IV7Mg5Rw0tl0ysH6JvQhrdZOlDpciR+E8yqn8zLy9G/Zvu6+VTWuFrNcJkBrFybo6n12lHQguEFJLDnyB09FrmUwirqYDIVWKVv7EtW981Z9fR4mbEN4HmXkEMSD9sG8ZpEdOw/rRDyZF6+dNFU3/zorM04I/jqKnQndnJ05SuoyqRMimn/QJNZ3vfyjDLMh+Y8zLYObTV/HfxKvb97b8jh2CPCy4rzvNFO5ybXuB1+QM2lH8knbFGpY5GnBo5Wl5Qp2LYe25p6MMAwb8i7tiVmwbCWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ge611uEHWJgZnftsUt3Kj0Cu8RmSKdmT2ovqymwS9o=;
 b=nZhbaFMPQz7sxAvjvVzVg7ppsImHR3QsMDzZ9Z+zL2TZtME7nCbhDy5FkJzzF7LLLJNfuI1708oskWkp3nJg70SXuzigIsv6nmiOAWudqjK7ydK4aZ/HiUemYNDLKqQ1g8r6pg/VOgh1AkrprwCTLUvpn0x92V/WbCwG5dmI3i6V+AaMGpiC6BhSAhyG+H0U+5QFlOxLFSbhxu9pA/txUvJtE6GITSY+0EV7C3PPm6jQIm3sY2RxfaijnW/kfPeRUMqiwZnqYntXsum2ZKcSim8C9sUH0lY52RmBZDhrPEG6DxuSzmXExgShvTsQZDtDVam82VW6cOLEN5hG+UqvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ge611uEHWJgZnftsUt3Kj0Cu8RmSKdmT2ovqymwS9o=;
 b=aIctHaPi6vo8thmobbJyx+3JiIEjYE289f5UoCwMDkTlpXz1iWufNQQvMPU2vXeNgBXeT6QSdfhG5hhWUpkWNSOTz+hOK+RnAPk8nAe4/XKA+NcxS1cbDFedW0lmmzp6tAEZKeZNNtPF+WwcalMqbpt+jgSHb8fjU8LlZIbcGkAcynS62MFtww6rTEYcriQvT2Vj1HxifniiUF4LPXFpC1F0P/klCaAczWTJmfYAIj+GNoRBW85J7s6bciO1HeH+U1wbRxn2dzb9dyLs8HXQ1Pi/W+kUGMJx/+UQON1M3N+YfmeIVbfQTzP5ylESnhmYs+I/hu1j24WBCSs9x5HSGQ==
Received: from BN9PR03CA0073.namprd03.prod.outlook.com (2603:10b6:408:fc::18)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 07:02:18 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::8) by BN9PR03CA0073.outlook.office365.com
 (2603:10b6:408:fc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 07:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 07:02:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 00:02:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 00:02:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 00:01:58 -0700
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
Subject: [PATCH net-next V9 10/14] net/mlx5: qos: Model the root node in the scheduling hierarchy
Date: Thu, 26 Mar 2026 08:59:45 +0200
Message-ID: <20260326065949.44058-11-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: a39d817c-7395-4c9c-20aa-08de8b059e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1lOdfOY5yDoK3rWpMkhaLX6rH3b4+8HG3KhNlKmpQvZr+LUyZPcJ5bScRw4riXxSlWLqrtFnGxt+43npIJGaTnI823WRw2lUX/+I672drYj+1KW5Hv8QlQSjhk+1I793jDNTNWxNR8MMPAPJm8RLA86CwX+airtRkUhO9Qxfr5pIrDDH0Ic/NeeqYIoLo0gMcYIxme3AxmvNz0/Emn4YPzqkWL1pnRsFwHlNaEnM44zG0PfloPi+9LVCJ/lsXAPdR2uGFjixFt2NJnkY+WgG1yVtDaEA9BlJ/fxKzdJmMijrky0a3ouN1d3wAfFXtGAMV44vl8AGhwwCPHUJu4u/1VJs1ojBo19A1nMwEgHloLO6Iipc7SbrNi5toU2BB71jNixyNPaW5VzRKFyZ7kzMx5uvO8x8Vt/tJNzj2BsFvigXToikIfP6O0DHUm5J9F3V4R2vpFdzHgmeF3uAfY5wQV6b3zV3gZePeS9AZ0RsF/dFCPY5vjalofZoIzqeta85NPC8N60BGXPPRsH8ViF9t0ILVVMncDB+2d5oAXVd8n9UyebsRm0n/lI6k44qneNAuHgKeOM6c3YilMUEeKyJbzdwarDo3pAqEzNX9UTPHvnAudxVllL4Mgo9CHyEa2X8LRafTCKWZ82AIUgNtEfMo0XH8k1j7CwByzwo+58tKOhQX6TIKgRXF8DAvMlG/UVxkmy+7cLKdmtku6i7QZGtnecFuBaEe25CGMp7cP0sC281V1pgYc/L8EfiXH/ChxTCF4BrlEE19LPvi/ERNwjs1A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(82310400026)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WtFzyH5Je+4uWN6WmvDNdK277VMnGPG9UGPP4/GY0wiv48QcdkRZbaLsV4uPdAy6nLFMxFHH3og5QvhwzNNm0vp9AQarJAuuySBwxLUYet+IGJSUKb9Fr07wKpTsYIg3+NLKurupK+c3YL+7hLowTL7Q0gErwhhRblarkpC5oFDccMznuxe8Z3Qbruc6T9smEBDWdrO8bYQGRogvoZpegpz7fVSqQwFpT93m9AssDTDUDUsGlyDI17n7CPOBjzKRD8XyL42tIY80BIzmXVd24ZVQNqa9u/U6/J1tn9D3SVzbSg14HpbjlWeQGNby7XIaaAJHIcD0adrEGirb4GjIrG95tCSb8mZEZRVylhBmDUZL8AMVIm43yT58IiX4ReduTKxOBU1vfawS80y7UJnhy6KGc7ZbUhy0+e27NCX+/FTzTej/M+IaklnnNPO1lmda
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:02:18.3798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a39d817c-7395-4c9c-20aa-08de8b059e9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
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
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,google.com,davidwei.uk,fomichev.me,iogearbox.net,dama.to,blackwall.org,linux.dev,redhat.com,openvpn.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18692-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B49CC330357
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

In commit [1] the concept of the root node in the qos hierarchy was
removed due to a bug with how tx_share worked. The side effect is that
in many places, there are now corner cases related to parent handling.
However, since that change, support for tc_bw was added and now, with
upcoming cross-esw support, the code is about to become even more
complicated, increasing the number of such corner cases.

Bring back the concept of the root node, to which all esw vports and
nodes are connected to. This benefits multiple operations which can
assume there's always a valid parent and don't have to do ternary
gymnastics to determine the correct esw to talk to.

As side effect, there's no longer a need to store the groups in the
qos domain, since normalization can simply iterate over all children of
the root node. Normalization gets simplified as a result.

There should be no functionality changes as a result of this change.

[1] commit 330f0f6713a3 ("net/mlx5: Remove default QoS group and attach
vports directly to root TSAR")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 194 ++++++++----------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   3 +-
 2 files changed, 84 insertions(+), 113 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 4781a1a42f1a..0be516003bcd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -15,8 +15,6 @@
 struct mlx5_qos_domain {
 	/* Serializes access to all qos changes in the qos domain. */
 	struct mutex lock;
-	/* List of all mlx5_esw_sched_nodes. */
-	struct list_head nodes;
 };
 
 static void esw_qos_lock(struct mlx5_eswitch *esw)
@@ -43,7 +41,6 @@ static struct mlx5_qos_domain *esw_qos_domain_alloc(void)
 		return NULL;
 
 	mutex_init(&qos_domain->lock);
-	INIT_LIST_HEAD(&qos_domain->nodes);
 
 	return qos_domain;
 }
@@ -62,6 +59,7 @@ static void esw_qos_domain_release(struct mlx5_eswitch *esw)
 }
 
 enum sched_node_type {
+	SCHED_NODE_TYPE_ROOT,
 	SCHED_NODE_TYPE_VPORTS_TSAR,
 	SCHED_NODE_TYPE_VPORT,
 	SCHED_NODE_TYPE_TC_ARBITER_TSAR,
@@ -106,18 +104,6 @@ struct mlx5_esw_sched_node {
 	u32 tc_bw[DEVLINK_RATE_TCS_MAX];
 };
 
-static void esw_qos_node_attach_to_parent(struct mlx5_esw_sched_node *node)
-{
-	if (!node->parent) {
-		/* Root children are assigned a depth level of 2. */
-		node->level = 2;
-		list_add_tail(&node->entry, &node->esw->qos.domain->nodes);
-	} else {
-		node->level = node->parent->level + 1;
-		list_add_tail(&node->entry, &node->parent->children);
-	}
-}
-
 static int esw_qos_num_tcs(struct mlx5_core_dev *dev)
 {
 	int num_tcs = mlx5_max_tc(dev) + 1;
@@ -125,14 +111,14 @@ static int esw_qos_num_tcs(struct mlx5_core_dev *dev)
 	return num_tcs < DEVLINK_RATE_TCS_MAX ? num_tcs : DEVLINK_RATE_TCS_MAX;
 }
 
-static void
-esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_node *parent)
+static void esw_qos_node_set_parent(struct mlx5_esw_sched_node *node,
+				    struct mlx5_esw_sched_node *parent)
 {
-	list_del_init(&node->entry);
 	node->parent = parent;
-	if (parent)
-		node->esw = parent->esw;
-	esw_qos_node_attach_to_parent(node);
+	node->esw = parent->esw;
+	node->level = parent->level + 1;
+	list_del(&node->entry);
+	list_add_tail(&node->entry, &parent->children);
 }
 
 static void esw_qos_nodes_set_parent(struct list_head *nodes,
@@ -321,22 +307,19 @@ static int esw_qos_create_rate_limit_element(struct mlx5_esw_sched_node *node,
 	return esw_qos_node_create_sched_element(node, sched_ctx, extack);
 }
 
-static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw,
-					      struct mlx5_esw_sched_node *parent)
+static u32
+esw_qos_calculate_min_rate_divider(struct mlx5_esw_sched_node *parent)
 {
-	struct list_head *nodes = parent ? &parent->children : &esw->qos.domain->nodes;
-	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
+	u32 fw_max_bw_share = MLX5_CAP_QOS(parent->esw->dev, max_tsar_bw_share);
 	struct mlx5_esw_sched_node *node;
 	u32 max_guarantee = 0;
 
 	/* Find max min_rate across all nodes.
 	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
 	 */
-	list_for_each_entry(node, nodes, entry) {
-		if (node->esw == esw && node->ix != esw->qos.root_tsar_ix &&
-		    node->min_rate > max_guarantee)
+	list_for_each_entry(node, &parent->children, entry)
+		if (node->min_rate > max_guarantee)
 			max_guarantee = node->min_rate;
-	}
 
 	if (max_guarantee)
 		return max_t(u32, max_guarantee / fw_max_bw_share, 1);
@@ -368,18 +351,13 @@ static void esw_qos_update_sched_node_bw_share(struct mlx5_esw_sched_node *node,
 	esw_qos_sched_elem_config(node, node->max_rate, bw_share, extack);
 }
 
-static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
-				       struct mlx5_esw_sched_node *parent,
+static void esw_qos_normalize_min_rate(struct mlx5_esw_sched_node *parent,
 				       struct netlink_ext_ack *extack)
 {
-	struct list_head *nodes = parent ? &parent->children : &esw->qos.domain->nodes;
-	u32 divider = esw_qos_calculate_min_rate_divider(esw, parent);
+	u32 divider = esw_qos_calculate_min_rate_divider(parent);
 	struct mlx5_esw_sched_node *node;
 
-	list_for_each_entry(node, nodes, entry) {
-		if (node->esw != esw || node->ix == esw->qos.root_tsar_ix)
-			continue;
-
+	list_for_each_entry(node, &parent->children, entry) {
 		/* Vports TC TSARs don't have a minimum rate configured,
 		 * so there's no need to update the bw_share on them.
 		 */
@@ -391,7 +369,7 @@ static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
 		if (list_empty(&node->children))
 			continue;
 
-		esw_qos_normalize_min_rate(node->esw, node, extack);
+		esw_qos_normalize_min_rate(node, extack);
 	}
 }
 
@@ -412,14 +390,11 @@ static u32 esw_qos_calculate_tc_bw_divider(u32 *tc_bw)
 static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 				     u32 min_rate, struct netlink_ext_ack *extack)
 {
-	struct mlx5_eswitch *esw = node->esw;
-
 	if (min_rate == node->min_rate)
 		return 0;
 
 	node->min_rate = min_rate;
-	esw_qos_normalize_min_rate(esw, node->parent, extack);
-
+	esw_qos_normalize_min_rate(node->parent, extack);
 	return 0;
 }
 
@@ -472,8 +447,7 @@ esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
 	MLX5_SET(vport_element, attr, vport_number, vport_node->vport->vport);
-	MLX5_SET(scheduling_context, sched_ctx, parent_element_id,
-		 parent ? parent->ix : vport_node->esw->qos.root_tsar_ix);
+	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent->ix);
 	MLX5_SET(scheduling_context, sched_ctx, max_average_bw,
 		 vport_node->max_rate);
 
@@ -513,7 +487,7 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 }
 
 static struct mlx5_esw_sched_node *
-__esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type,
+__esw_qos_alloc_node(u32 tsar_ix, enum sched_node_type type,
 		     struct mlx5_esw_sched_node *parent)
 {
 	struct mlx5_esw_sched_node *node;
@@ -522,20 +496,12 @@ __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type
 	if (!node)
 		return NULL;
 
-	node->esw = esw;
 	node->ix = tsar_ix;
 	node->type = type;
-	node->parent = parent;
 	INIT_LIST_HEAD(&node->children);
-	esw_qos_node_attach_to_parent(node);
-	if (!parent) {
-		/* The caller is responsible for inserting the node into the
-		 * parent list if necessary. This function can also be used with
-		 * a NULL parent, which doesn't necessarily indicate that it
-		 * refers to the root scheduling element.
-		 */
-		list_del_init(&node->entry);
-	}
+	INIT_LIST_HEAD(&node->entry);
+	if (parent)
+		esw_qos_node_set_parent(node, parent);
 
 	return node;
 }
@@ -570,7 +536,7 @@ static int esw_qos_create_vports_tc_node(struct mlx5_esw_sched_node *parent,
 					  SCHEDULING_HIERARCHY_E_SWITCH))
 		return -EOPNOTSUPP;
 
-	vports_tc_node = __esw_qos_alloc_node(parent->esw, 0,
+	vports_tc_node = __esw_qos_alloc_node(0,
 					      SCHED_NODE_TYPE_VPORTS_TC_TSAR,
 					      parent);
 	if (!vports_tc_node) {
@@ -665,7 +631,6 @@ static int esw_qos_create_tc_arbiter_sched_elem(
 		struct netlink_ext_ack *extack)
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
-	u32 tsar_parent_ix;
 	void *attr;
 
 	if (!mlx5_qos_tsar_type_supported(tc_arbiter_node->esw->dev,
@@ -678,10 +643,8 @@ static int esw_qos_create_tc_arbiter_sched_elem(
 
 	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
 	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_TC_ARB);
-	tsar_parent_ix = tc_arbiter_node->parent ? tc_arbiter_node->parent->ix :
-			 tc_arbiter_node->esw->qos.root_tsar_ix;
 	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
-		 tsar_parent_ix);
+		 tc_arbiter_node->parent->ix);
 	MLX5_SET(scheduling_context, tsar_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
 	MLX5_SET(scheduling_context, tsar_ctx, max_average_bw,
@@ -694,37 +657,36 @@ static int esw_qos_create_tc_arbiter_sched_elem(
 }
 
 static struct mlx5_esw_sched_node *
-__esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sched_node *parent,
+__esw_qos_create_vports_sched_node(struct mlx5_esw_sched_node *parent,
 				   struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *node;
-	u32 tsar_ix;
 	int err;
+	u32 ix;
 
-	err = esw_qos_create_node_sched_elem(esw->dev, esw->qos.root_tsar_ix, 0,
-					     0, &tsar_ix);
+	err = esw_qos_create_node_sched_elem(parent->esw->dev, parent->ix, 0, 0,
+					     &ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch create TSAR for node failed");
 		return ERR_PTR(err);
 	}
 
-	node = __esw_qos_alloc_node(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
+	node = __esw_qos_alloc_node(ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
 	if (!node) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc node failed");
 		err = -ENOMEM;
 		goto err_alloc_node;
 	}
 
-	list_add_tail(&node->entry, &esw->qos.domain->nodes);
-	esw_qos_normalize_min_rate(esw, NULL, extack);
-	trace_mlx5_esw_node_qos_create(esw->dev, node, node->ix);
+	esw_qos_normalize_min_rate(parent, extack);
+	trace_mlx5_esw_node_qos_create(parent->esw->dev, node, node->ix);
 
 	return node;
 
 err_alloc_node:
-	if (mlx5_destroy_scheduling_element_cmd(esw->dev,
+	if (mlx5_destroy_scheduling_element_cmd(parent->esw->dev,
 						SCHEDULING_HIERARCHY_E_SWITCH,
-						tsar_ix))
+						ix))
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR for node failed");
 	return ERR_PTR(err);
 }
@@ -746,7 +708,7 @@ esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct netlink_ext_ac
 	if (err)
 		return ERR_PTR(err);
 
-	node = __esw_qos_create_vports_sched_node(esw, NULL, extack);
+	node = __esw_qos_create_vports_sched_node(esw->qos.root, extack);
 	if (IS_ERR(node))
 		esw_qos_put(esw);
 
@@ -762,38 +724,47 @@ static void __esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netl
 
 	trace_mlx5_esw_node_qos_destroy(esw->dev, node, node->ix);
 	esw_qos_destroy_node(node, extack);
-	esw_qos_normalize_min_rate(esw, NULL, extack);
+	esw_qos_normalize_min_rate(esw->qos.root, extack);
 }
 
 static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = esw->dev;
+	struct mlx5_esw_sched_node *root;
+	u32 root_ix;
 	int err;
 
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
 		return -EOPNOTSUPP;
 
-	err = esw_qos_create_node_sched_elem(esw->dev, 0, 0, 0,
-					     &esw->qos.root_tsar_ix);
+	err = esw_qos_create_node_sched_elem(esw->dev, 0, 0, 0, &root_ix);
 	if (err) {
 		esw_warn(dev, "E-Switch create root TSAR failed (%d)\n", err);
 		return err;
 	}
 
+	root = __esw_qos_alloc_node(root_ix, SCHED_NODE_TYPE_ROOT, NULL);
+	if (!root) {
+		esw_warn(dev, "E-Switch create root node failed\n");
+		err = -ENOMEM;
+		goto out_err;
+	}
+	root->esw = esw;
+	root->level = 1;
+	esw->qos.root = root;
 	refcount_set(&esw->qos.refcnt, 1);
 
 	return 0;
+out_err:
+	mlx5_destroy_scheduling_element_cmd(dev, SCHEDULING_HIERARCHY_E_SWITCH,
+					    root_ix);
+	return err;
 }
 
 static void esw_qos_destroy(struct mlx5_eswitch *esw)
 {
-	int err;
-
-	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
-						  SCHEDULING_HIERARCHY_E_SWITCH,
-						  esw->qos.root_tsar_ix);
-	if (err)
-		esw_warn(esw->dev, "E-Switch destroy root TSAR failed (%d)\n", err);
+	esw_qos_destroy_node(esw->qos.root, NULL);
+	esw->qos.root = NULL;
 }
 
 static int esw_qos_get(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
@@ -866,8 +837,7 @@ esw_qos_create_vport_tc_sched_node(struct mlx5_vport *vport,
 	u8 tc = vports_tc_node->tc;
 	int err;
 
-	vport_tc_node = __esw_qos_alloc_node(vport_node->esw, 0,
-					     SCHED_NODE_TYPE_VPORT_TC,
+	vport_tc_node = __esw_qos_alloc_node(0, SCHED_NODE_TYPE_VPORT_TC,
 					     vports_tc_node);
 	if (!vport_tc_node)
 		return -ENOMEM;
@@ -959,7 +929,7 @@ esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
 		/* Increase the parent's level by 2 to account for both the
 		 * TC arbiter and the vports TC scheduling element.
 		 */
-		new_level = (parent ? parent->level : 2) + 2;
+		new_level = parent->level + 2;
 		max_level = 1 << MLX5_CAP_QOS(vport_node->esw->dev,
 					      log_esw_max_sched_depth);
 		if (new_level > max_level) {
@@ -997,7 +967,7 @@ esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
 err_sched_nodes:
 	if (type == SCHED_NODE_TYPE_RATE_LIMITER) {
 		esw_qos_node_destroy_sched_element(vport_node, NULL);
-		esw_qos_node_attach_to_parent(vport_node);
+		esw_qos_node_set_parent(vport_node, vport_node->parent);
 	} else {
 		esw_qos_tc_arbiter_scheduling_teardown(vport_node, NULL);
 	}
@@ -1055,7 +1025,7 @@ static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_a
 	vport_node->bw_share = 0;
 	memset(vport_node->tc_bw, 0, sizeof(vport_node->tc_bw));
 	list_del_init(&vport_node->entry);
-	esw_qos_normalize_min_rate(vport_node->esw, vport_node->parent, extack);
+	esw_qos_normalize_min_rate(vport_node->parent, extack);
 
 	trace_mlx5_esw_vport_qos_destroy(vport_node->esw->dev, vport);
 }
@@ -1068,7 +1038,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 	int err;
 
-	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+	esw_assert_qos_lock_held(vport_node->esw);
 
 	esw_qos_node_set_parent(vport_node, parent);
 	if (type == SCHED_NODE_TYPE_VPORT)
@@ -1079,7 +1049,7 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 		return err;
 
 	vport_node->type = type;
-	esw_qos_normalize_min_rate(vport_node->esw, parent, extack);
+	esw_qos_normalize_min_rate(parent, extack);
 	trace_mlx5_esw_vport_qos_create(vport->dev, vport, vport_node->max_rate,
 					vport_node->bw_share);
 
@@ -1092,7 +1062,6 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	struct mlx5_esw_sched_node *sched_node;
-	struct mlx5_eswitch *parent_esw;
 	int err;
 
 	esw_assert_qos_lock_held(esw);
@@ -1100,14 +1069,13 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 	if (err)
 		return err;
 
-	parent_esw = parent ? parent->esw : esw;
-	sched_node = __esw_qos_alloc_node(parent_esw, 0, type, parent);
+	if (!parent)
+		parent = esw->qos.root;
+	sched_node = __esw_qos_alloc_node(0, type, parent);
 	if (!sched_node) {
 		esw_qos_put(esw);
 		return -ENOMEM;
 	}
-	if (!parent)
-		list_add_tail(&sched_node->entry, &esw->qos.domain->nodes);
 
 	sched_node->max_rate = max_rate;
 	sched_node->min_rate = min_rate;
@@ -1147,7 +1115,8 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 		goto unlock;
 
 	parent = vport->qos.sched_node->parent;
-	WARN(parent, "Disabling QoS on port before detaching it from node");
+	WARN(parent != esw->qos.root,
+	     "Disabling QoS on port before detaching it from node");
 
 	mlx5_esw_qos_vport_disable_locked(vport);
 unlock:
@@ -1319,11 +1288,9 @@ static int esw_qos_switch_tc_arbiter_node_to_vports(
 	struct mlx5_esw_sched_node *node,
 	struct netlink_ext_ack *extack)
 {
-	u32 parent_tsar_ix = node->parent ?
-			     node->parent->ix : node->esw->qos.root_tsar_ix;
 	int err;
 
-	err = esw_qos_create_node_sched_elem(node->esw->dev, parent_tsar_ix,
+	err = esw_qos_create_node_sched_elem(node->esw->dev, node->parent->ix,
 					     node->max_rate, node->bw_share,
 					     &node->ix);
 	if (err) {
@@ -1378,8 +1345,8 @@ esw_qos_move_node(struct mlx5_esw_sched_node *curr_node)
 {
 	struct mlx5_esw_sched_node *new_node;
 
-	new_node = __esw_qos_alloc_node(curr_node->esw, curr_node->ix,
-					curr_node->type, NULL);
+	new_node = __esw_qos_alloc_node(curr_node->ix, curr_node->type,
+					curr_node->parent);
 	if (!new_node)
 		return ERR_PTR(-ENOMEM);
 
@@ -1888,7 +1855,9 @@ mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
 		err = mlx5_esw_qos_vport_enable(vport, type, parent, 0, 0,
 						extack);
 	} else if (vport->qos.sched_node) {
-		err = esw_qos_vport_update_parent(vport, parent, extack);
+		err = esw_qos_vport_update_parent(vport,
+						  parent ? : esw->qos.root,
+						  extack);
 	}
 	esw_qos_unlock(esw);
 	return err;
@@ -1941,7 +1910,7 @@ mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
 {
 	u8 new_level, max_level;
 
-	if (parent && parent->esw != node->esw) {
+	if (parent->esw != node->esw) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Cannot assign node to another E-Switch");
 		return -EOPNOTSUPP;
@@ -1953,13 +1922,13 @@ mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
 		return -EOPNOTSUPP;
 	}
 
-	if (parent && parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+	if (parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Cannot attach a node to a parent with TC bandwidth configured");
 		return -EOPNOTSUPP;
 	}
 
-	new_level = parent ? parent->level + 1 : 2;
+	new_level = parent->level + 1;
 	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
 		/* Increase by one to account for the vports TC scheduling
 		 * element.
@@ -2010,14 +1979,12 @@ static int esw_qos_vports_node_update_parent(struct mlx5_esw_sched_node *node,
 {
 	struct mlx5_esw_sched_node *curr_parent = node->parent;
 	struct mlx5_eswitch *esw = node->esw;
-	u32 parent_ix;
 	int err;
 
-	parent_ix = parent ? parent->ix : node->esw->qos.root_tsar_ix;
 	mlx5_destroy_scheduling_element_cmd(esw->dev,
 					    SCHEDULING_HIERARCHY_E_SWITCH,
 					    node->ix);
-	err = esw_qos_create_node_sched_elem(esw->dev, parent_ix,
+	err = esw_qos_create_node_sched_elem(esw->dev, parent->ix,
 					     node->max_rate, 0, &node->ix);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack,
@@ -2044,12 +2011,15 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 	struct mlx5_eswitch *esw = node->esw;
 	int err;
 
+	esw_qos_lock(esw);
+	curr_parent = node->parent;
+	if (!parent)
+		parent = esw->qos.root;
+
 	err = mlx5_esw_qos_node_validate_set_parent(node, parent, extack);
 	if (err)
-		return err;
+		goto out;
 
-	esw_qos_lock(esw);
-	curr_parent = node->parent;
 	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
 		err = esw_qos_tc_arbiter_node_update_parent(node, parent,
 							    extack);
@@ -2060,8 +2030,8 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 	if (err)
 		goto out;
 
-	esw_qos_normalize_min_rate(esw, curr_parent, extack);
-	esw_qos_normalize_min_rate(esw, parent, extack);
+	esw_qos_normalize_min_rate(curr_parent, extack);
+	esw_qos_normalize_min_rate(parent, extack);
 
 out:
 	esw_qos_unlock(esw);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index a5a02b26b80b..9b3949a64784 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -390,8 +390,9 @@ struct mlx5_eswitch {
 	struct {
 		/* Initially 0, meaning no QoS users and QoS is disabled. */
 		refcount_t refcnt;
-		u32 root_tsar_ix;
 		struct mlx5_qos_domain *domain;
+		/* The root node of the hierarchy. */
+		struct mlx5_esw_sched_node *root;
 	} qos;
 
 	struct mlx5_esw_bridge_offloads *br_offloads;
-- 
2.44.0


