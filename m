Return-Path: <linux-rdma+bounces-18694-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLhrECvbxGkq4gQAu9opvQ
	(envelope-from <linux-rdma+bounces-18694-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:07:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E811D3303B1
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56DC130DB634
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 07:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFE13B47DC;
	Thu, 26 Mar 2026 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q/UXbTWZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2313E3B47C6;
	Thu, 26 Mar 2026 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508563; cv=fail; b=Ew2eL/UMw5NwmT+e3f+8J1FGg6Fa3dOCZxs77dHxGoT9bbXNipSO+EuMbomNPxFeCd3Rv3oRtK5FOFa1yYTLgKG+cXof2pftNWINdovDmzPpBNezKTRIN2WXUhBK/bJkW2LifY6mWQwh1EN7xgsLp0znzvBkeo5EoTN/9gg6FLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508563; c=relaxed/simple;
	bh=Dmbk7vhfiIFC1cNlMurGf76TR33zY+Nf4qdZIKXqz/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rd/sCTcGQWFcDKKtp0J++ooqMy6p7mZLcffB2j+hfQQzw+h1lYjnT3Q5dCEQnkgNp30FR0Oot5azjW3GFy7Fv90eBL+SKqmTEofGVQedOzxz5icGa1QL631qbRUM5kVbylgA5wpLVLwkT+sbZW4iNrmoXtNvCp63cwuJTY9kPt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q/UXbTWZ; arc=fail smtp.client-ip=52.101.61.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HU3roZK+0Zo/oDVistlcVP+/TNNxAD5kL5x/E6CcQMJHdf8SpQQxwvz/vEyIHpmYa5dA2SiW7vjwy/J8cJcO0Z5ymd7fxCJ0cUXpDdEDK/fb9+S8mxElTac9dbD7b7neSYBUZqYqvuF4PxYp/EqqSu+Gu/xPg86HyYhiizIiUahtL+AoQk9xYJtziQDWoG/LlX3yFxlY2sVSx897KPfNDnZRjijTOf2ffl9DkauCBgidrlafqw0kTiqO/2acZZmdXcTZFl6nB0E1G8iogfcPE2MHja0uW4lEAXNIeYAwn9UjJS7VkRFIhDGdxB9c94TbW7gWqzXkXAgx41H2ml6TVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6z4p6aShfOT55dcGiABTGxNkQMBebXY2jGvEYfKzE8=;
 b=iGC7iOn1sCibC9a/69wZ9FvI5Pwmfe6q0D1eSXgohiust7gudWSHHGT3GB7nq3kOe+o4HgWdqpv9yq0xf8OKqahlezKeuXDqIohGZGKxTBAX0t/ORW7HIyNt2WLIyLBHwuHmDO/XPjpAQTUfjw4+bw/8PiG/54/bK87VWT7Dldat4SV83T6yQW8d2luBvWcYrE0MSYgWHUhv1Heymcy5LRKQ2Xvm5eof6T09NJzsNdWSPaySATAVwT7bkStd6TjceLfkUkBTg8rV6voBd9hFXPNPkQxmHz2UMfJ+gAo4mLzM0wWnx883aGExk6zqIACkHEM1UGllwDuf0ZUMivdhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6z4p6aShfOT55dcGiABTGxNkQMBebXY2jGvEYfKzE8=;
 b=q/UXbTWZqWQ425O2Pd2+Nvl7mPY+rSkKzJrVGU3rFMgXcokkwS8fuZI+YkTDodCC7b6NaEikOjf+H8iYOYW/9ucZdZStyIGkrWSSq+ieotXJlFZnGBy0j1sWBYk8E4hQ7rO5UE61wVZyaZzvzUAf7Q4ibr9qsY06t7PM2ABBrkSY3NmOfvyp6wxHcnB6DNQOqpSXXYCah5q7l4hxD5JO8hcBzY+F7+okk2rvFBmUTqDLXgAPqchc1DtNFGonv6rVC64uwJ9EooP2GouEQUczrP9NBkXN2KnZX5TzrlECxwSW2rzQonvztYKNN6VbNEE+TQQnioK6+anVaCOghEUKFA==
Received: from BN0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:e4::9)
 by BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 07:02:34 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::d7) by BN0PR02CA0004.outlook.office365.com
 (2603:10b6:408:e4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 07:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 07:02:33 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 00:02:31 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 00:02:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 00:02:20 -0700
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
Subject: [PATCH net-next V9 12/14] net/mlx5: qos: Support cross-device tx scheduling
Date: Thu, 26 Mar 2026 08:59:47 +0200
Message-ID: <20260326065949.44058-13-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|BL3PR12MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c3743c-0494-4261-665d-08de8b05a7d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uQS6kMJu+Qm7GYTzHXpyU1/Vr2OzhAfjbmwJEQUt664KcdSgVS8HfWVYga1qU3LxtJ4KyXX6JXyG75O2J+WUc/fSdPv8XQI/UBVBhQD0VMnpzMvGErwd60LguZhaiAGGqONnFCAx+Svm/rQbhjCZkoUbyg3q9G4Nnu5aiz02xeu2a2E1f+Dai1UKSRIBAeN7ZXdqbmDDuCKysK0/F5InJ6q9If/G+l9QxiHpMihQf20feV/PrvmxmqGZqWv2iaxZvRNCIICZsIyBgMNzsiZmfiNgRk1CuocJmlXbH1YyMKYyl6XsbI6VdmY3ZNsmL/SRaGuX3twDBeOtjRFMQzDwk4WlqD1NwhbE3a5gpyMy50rgmNIrfQY4V7Ax0MErliiPpbLPLYXec5fopOE/fFdTdGFCdlJVl1BNKj6SrJpwnoEE3qXuT218XwCkHWdTic/PKQ7Tada8aA/uYzregY0+0Zr1nGlyY2KQ9aJUpo/eY8Augnhl0JR7Z5MBXQKWm+JRIkVjtVZB7kFhB3aB6edFRdvMlYfaOxjkzjy7e9tQEjinMtunvxy1vjzbw09Djb9teWrBHhu1Kkgo0czhFDM38ZMi/Uqr1dOkTJxpqQJIL7RPvMnrNQnLwaloNIKKf2FIVPQB3EdA7eLMlGDrIvq5x3CR86wVuVthzRWVRFz70oiSs3nAloGOhDU5D1Dk5ajtIzxerJMUAqwj0efusr6fDPbz9XGt+HsCTwh3IFtU/r1nxfkjWVvsirKjPp3b80o46VuUDne/gjrzvYCmHNr4xQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5FS4d2Q8yK0f2u3GFx4L91g7Q3ug5nCFrC6OIE2vj+8CrjqkU3VT86v4ZI3eRCbWd0h0C1I9T67FVyGRUutSXqpFmk2282cnwrhcBigCOiOAEQoYi/lj7igAQTqgCW8whuI6Ci2jzMw6lOK3icHT3+79Yi2aBU4D2wB5YRGRrcHTfh/CxKrtkLt2WWblJ5Xe/WecT7mmmmsT9L0vk2yJjfSRfnI0nvklsWBdbjHXjwn/VTvAzdieL8vGNug8K+lcwSfoUcOsxoHzFR/hYQCuiSZVcQBDoz5AfYs9bLnQhWpJB/gv5yOIUQLwTS+ZNmoGqdFlX4+3xLfCSFXDNkyytbrpMCiUHMrDgJ6fSE5KhtQj6rk/S5x2lLIpkmzgi8NjC/NigiJ+y7jrOr4vwxco2EkV3vupsTKkYDnu9ITOqzo8F+0NyDNzl+1leL9/Lx3B
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:02:33.8306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c3743c-0494-4261-665d-08de8b05a7d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401
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
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,google.com,davidwei.uk,fomichev.me,iogearbox.net,dama.to,blackwall.org,linux.dev,redhat.com,openvpn.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18694-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E811D3303B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

Up to now, rate groups could only contain vports from the same E-Switch.
This patch relaxes that restriction if the device supports it
(HCA_CAP.esw_cross_esw_sched == true) and the right conditions are met:
- Link Aggregation (LAG) is enabled.
- The E-Switches are from the same shared devlink device.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 117 +++++++++++++-----
 1 file changed, 83 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index f67f99428959..a3d511367297 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -50,7 +50,9 @@ struct mlx5_esw_sched_node {
 	enum sched_node_type type;
 	/* The eswitch this node belongs to. */
 	struct mlx5_eswitch *esw;
-	/* The children nodes of this node, empty list for leaf nodes. */
+	/* The children nodes of this node, empty list for leaf nodes.
+	 * Can be from multiple E-Switches.
+	 */
 	struct list_head children;
 	/* Valid only if this node is associated with a vport. */
 	struct mlx5_vport *vport;
@@ -393,6 +395,7 @@ esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 	struct mlx5_esw_sched_node *parent = vport_node->parent;
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_node->esw->dev;
+	struct mlx5_vport *vport = vport_node->vport;
 	void *attr;
 
 	if (!mlx5_qos_element_type_supported(
@@ -404,10 +407,17 @@ esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
-	MLX5_SET(vport_element, attr, vport_number, vport_node->vport->vport);
+	MLX5_SET(vport_element, attr, vport_number, vport->vport);
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, parent->ix);
 	MLX5_SET(scheduling_context, sched_ctx, max_average_bw,
 		 vport_node->max_rate);
+	if (vport->dev != dev) {
+		/* The port is assigned to a node on another eswitch. */
+		MLX5_SET(vport_element, attr, eswitch_owner_vhca_id_valid,
+			 true);
+		MLX5_SET(vport_element, attr, eswitch_owner_vhca_id,
+			 MLX5_CAP_GEN(vport->dev, vhca_id));
+	}
 
 	return esw_qos_node_create_sched_element(vport_node, sched_ctx, extack);
 }
@@ -419,6 +429,7 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_tc_node->esw->dev;
+	struct mlx5_vport *vport = vport_tc_node->vport;
 	void *attr;
 
 	if (!mlx5_qos_element_type_supported(
@@ -430,8 +441,7 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
-	MLX5_SET(vport_tc_element, attr, vport_number,
-		 vport_tc_node->vport->vport);
+	MLX5_SET(vport_tc_element, attr, vport_number, vport->vport);
 	MLX5_SET(vport_tc_element, attr, traffic_class, vport_tc_node->tc);
 	MLX5_SET(scheduling_context, sched_ctx, max_bw_obj_id,
 		 rate_limit_elem_ix);
@@ -439,6 +449,13 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 		 vport_tc_node->parent->ix);
 	MLX5_SET(scheduling_context, sched_ctx, bw_share,
 		 vport_tc_node->bw_share);
+	if (vport->dev != dev) {
+		/* The port is assigned to a node on another eswitch. */
+		MLX5_SET(vport_tc_element, attr, eswitch_owner_vhca_id_valid,
+			 true);
+		MLX5_SET(vport_tc_element, attr, eswitch_owner_vhca_id,
+			 MLX5_CAP_GEN(vport->dev, vhca_id));
+	}
 
 	return esw_qos_node_create_sched_element(vport_tc_node, sched_ctx,
 						 extack);
@@ -1160,6 +1177,29 @@ static int esw_qos_vport_tc_check_type(enum sched_node_type curr_type,
 	return 0;
 }
 
+static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw,
+					       u32 *tc_bw)
+{
+	int i, num_tcs = esw_qos_num_tcs(esw->dev);
+
+	for (i = num_tcs; i < DEVLINK_RATE_TCS_MAX; i++)
+		if (tc_bw[i])
+			return false;
+
+	return true;
+}
+
+static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport,
+						     u32 *tc_bw)
+{
+	struct mlx5_esw_sched_node *node = vport->qos.sched_node;
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+
+	esw = (node && node->parent) ? node->parent->esw : esw;
+
+	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
+}
+
 static int esw_qos_vport_update(struct mlx5_vport *vport,
 				enum sched_node_type type,
 				struct mlx5_esw_sched_node *parent,
@@ -1179,8 +1219,15 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 	if (err)
 		return err;
 
-	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
 		esw_qos_tc_arbiter_get_bw_shares(vport_node, curr_tc_bw);
+		if (!esw_qos_validate_unsupported_tc_bw(parent->esw,
+							curr_tc_bw)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Unsupported traffic classes on the new device");
+			return -EOPNOTSUPP;
+		}
+	}
 
 	esw_qos_vport_disable(vport, extack);
 
@@ -1510,30 +1557,6 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 	return 0;
 }
 
-static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw,
-					       u32 *tc_bw)
-{
-	int i, num_tcs = esw_qos_num_tcs(esw->dev);
-
-	for (i = num_tcs; i < DEVLINK_RATE_TCS_MAX; i++) {
-		if (tc_bw[i])
-			return false;
-	}
-
-	return true;
-}
-
-static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport,
-						     u32 *tc_bw)
-{
-	struct mlx5_esw_sched_node *node = vport->qos.sched_node;
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-
-	esw = (node && node->parent) ? node->parent->esw : esw;
-
-	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
-}
-
 static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
 {
 	int i;
@@ -1738,18 +1761,44 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	return 0;
 }
 
+static int
+mlx5_esw_validate_cross_esw_scheduling(struct mlx5_eswitch *esw,
+				       struct mlx5_esw_sched_node *parent,
+				       struct netlink_ext_ack *extack)
+{
+	if (!parent || esw == parent->esw)
+		return 0;
+
+	if (!MLX5_CAP_QOS(esw->dev, esw_cross_esw_sched)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cross E-Switch scheduling is not supported");
+		return -EOPNOTSUPP;
+	}
+	if (esw->dev->shd != parent->esw->dev->shd) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot add vport to a parent belonging to a different device");
+		return -EOPNOTSUPP;
+	}
+	if (!mlx5_lag_is_active(esw->dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cross E-Switch scheduling requires LAG to be activated");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int
 mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
 				 struct mlx5_esw_sched_node *parent,
 				 struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-	int err = 0;
+	int err;
 
-	if (parent && parent->esw != esw) {
-		NL_SET_ERR_MSG_MOD(extack, "Cross E-Switch scheduling is not supported");
-		return -EOPNOTSUPP;
-	}
+	err = mlx5_esw_validate_cross_esw_scheduling(esw, parent, extack);
+	if (err)
+		return err;
 
 	if (!vport->qos.sched_node && parent) {
 		enum sched_node_type type;
-- 
2.44.0


