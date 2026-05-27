Return-Path: <linux-rdma+bounces-21363-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE35A17sFmruvgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21363-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:06:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 766665E49D4
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1623431CC42D
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B8D405C32;
	Wed, 27 May 2026 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AAF2Yoog"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011025.outbound.protection.outlook.com [52.101.57.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4CC407CC5;
	Wed, 27 May 2026 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886599; cv=fail; b=Fsseynx1DW7OeBC5z1Te2cmgeWjnDWDfBLwNLMRz7V+KMMvqm7qtRAeCAVENbAMNl1Ikc9D7pLPVvO/m8s4CVavzMZPam6Qt3Ej6L7/eU5g8icY/cnIguB9wjps5m+5XdfQRYqAhaZAXPDRv53ihxpL/wlkUodQBLNJqx3KQ+HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886599; c=relaxed/simple;
	bh=DBFy0emQdt6LTTJfxIzblGktGuoVIkE/QfqEJY71KDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6410EH2n9xeWiYx/BOUPda/RlDPJQ7xC8UGZZ+9w6V64DS/hyv7bdl3TqZuTlzj/dgtdyXO2QQ+g0R9/N80FLLJN4VAiwhNOTqhFUn5L+es0KAhgB9NzwlrgZa8yB6+Hf/9mm8PGwONOsjbRvfnn7NpTzygKpMzECrkmItvTC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AAF2Yoog; arc=fail smtp.client-ip=52.101.57.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQ+nDnmIQkPwHC+T+xTijctxed1sb+/xS0YDRJQMR6sw7EibfPZEcXVd7SfgnjUTG8oMH12EgBeLoVh9rb735V+E6SaO3PuGC9kQKv89VqAmD+aJhEpCee94pB217/O1O/Yz8+RZYdgmhdo1dtzRsMp14PLy4jhOfMsv7Xt8f947pwIae8723D5gT0hpSIzN1EeVrUEa++k6U5QkBOe4TCnwrhhK83cDYTRXvu7gkl09i328NtWOkVm3bZDyzwTeOsl1CTNhmC89cfxZQgWN+PUpDgTeDP8s5Vq/SWkIRo7eh6Jpjquvyy+uuR0thrwgjbrPc5gmN/3bwNNaXYLX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi9divZH6dVIU9Q2bKhYm7skW80niwvxqnoML9x7Mz8=;
 b=QYCAVGCpoMFI1gt9ULiQ1kFkDO0Cq/+Q50iRphCYMPjlmBSAvH/OznkoPMiq0oGlYdWvXA0mkUkvdoYeq+ozCEuwCek5Pe4CM/1vZbs6zprpdEUtRk1XM9vIXEhRtAfVB685rAllhjh32NTpFeaCLtJceWDqegokzfFzO8qAHNhm/srpFMlm4IQPOtu4vSRi1f1F0IucoOcpWczBeetVOyCm8udjWUVs+ktDXwCwwXV6/K26Cw7+LYvAZ1hAPwomfnMxLa4haVAjy1zkwY48tFtuysmXHtvG5acKSIQP0oYnyVO3y3EywuhYAcEhuM+OJSPsgEbI5wunmM/slO+SzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi9divZH6dVIU9Q2bKhYm7skW80niwvxqnoML9x7Mz8=;
 b=AAF2YoogAm3sgXXBZc6b17Z5Wns/BxAIcz0a4gTQkuzFgoKEgAjuZSyq4VGQ630t8SrLQtRTJBV4HOSKHElDztLGyrJ2vWwel107kHzt5IeY18g9DBINAtdgO22lhHSeBTySDjD7LYBnfthGD5Xx8NeWEK/FoHjayxhsqR30C7U8OfcytHZ9U32lvv124cZiTNm8MLzx8BBDa+xbhCijlfbMj6e8whpHQ75M8XPw9Tg4C5kw6X+A3NrnodbaaWbVOAXYmei/uvJ35M52QgZLVPykeY0U1ClKwSMqWpo+AXMwciyg09GKDl+e7+JbXisolDIsziutaVQ52/OQmN5AqQ==
Received: from MW4P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::17)
 by IA1PR12MB9522.namprd12.prod.outlook.com (2603:10b6:208:594::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 27 May
 2026 12:56:31 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::2d) by MW4P222CA0012.outlook.office365.com
 (2603:10b6:303:114::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 12:56:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 12:56:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 05:56:10 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 27 May 2026 05:56:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 05:56:04 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 11/13] net/mlx5e: TC, track peer flow slots with bitmap
Date: Wed, 27 May 2026 15:54:25 +0300
Message-ID: <20260527125427.385976-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260527125427.385976-1-tariqt@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|IA1PR12MB9522:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b4ea75-52b1-4ad8-4817-08debbef5fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	9hjE5Fq+1qMV5qEY9Qvc5Sv6VuHVY1dvtTbHhuKw0Wfj7kTu6ZXynOWtsf1PDpl4ZUWvyfvJb2+HBnHOXkInddlFie1MKWKS1xjFmZkvRt03EUNDXNyoTlY0e2aGuPUVIrWiL7mla+ISZVBMORIqqJPwxGB00JHkwgq4+eXdrymSkNC7I1gjfuU2pPdOTWf/J/Gmi7GhFylwrtPhM7cW/0yzpDjndPvdrt27xxfwQ51ddN0A/oFDtNFZnwe4ONccEU3bsMrVGZXgLAyw9r0S/OG8RiRRiq9VNSlhYlKQV8nsn6PdmQgbU2ZoDnk2B3dBKG0PXVgbUrc8awUJCxnjVeTBo5miJvhEygfruKEjv3600gluYjdjy7iA//pWJw+SyTHVJzEAg5z4d0UnA021aDtoM1NAWYtHp1YIZlL5aP2iaqoYOHp8qC6FD2srNRGwXhodAtCY9HpgqT2PXUcaNmle1g5Q4ehV0/tew/oOo+JPHX770SG7pB2hnoY//Aj8fuPMFfqCpK6FBsCi3AfU/dl4zXRzomA4lYdsRx0amXkg+yaj/bSOTDsP0BvtK+/spvsZvesA4I/kk6iBpcQR1LHLfggBLQFrJHPuQ4U0Mx3KCSp6jzbL1vz2xhx0jxEkpK4I5/HiU7UxHeFqCLqNzxC4OmUdOaN0C8q0gx3ahrBJv1IslDDlEa+c02EhZBhPlER52BWXllgClzN2iyfLVUVs+NgHq9t2CoGJAnJGgZE=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nH7tGnwjyExo7U4UzBhPccvVFRBD9VNHxFuE4PucuixT7gvH3lZ0ZcUu6y+H90krcQjQ1xnhGjyFofzAOghsBts9nAMJ0DWsyEdOzlnMrohhUmSXBWr7cgBz7wyVVtBwDKCRdK6QQLFMPzSuinox7y7/6TpykuRwQr1lweeNOmsXGz9knKsRW3ASXywH5HRZNDCm8q3YfH1/PNvUO8Cyaz8Q8PHK7BY+8SOAE2GnZdsFKW5opqyfpkfQ3rgFcZb9RJQfoW9FOV7/1QrN+3CFrjW7G1MgrAWSuZGhVavfr9OzAtcxG9w2pjFK10j8iFk7pJBY8VukG4JPk7rdLWSh5K9WcyJfQEfSTJduNnIwKHb5xabJuIqtlyEookN1VkTGVYVFbPykJ3+vbw6NauN+g9HkitIpuvS8vvgR9O+m2DvACNhR3PHXsldjcl/eWBes
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:56:31.2835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b4ea75-52b1-4ad8-4817-08debbef5fe9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9522
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21363-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 766665E49D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

With SD devices joining the LAG, peer flows are not created for all
devcom peers - SD devices skip peers that belong to a different SD
group. However, the delete path iterated all devcom peers
unconditionally, attempting to delete from slots that were never
populated.

Track which peer slots are populated using a bitmap in mlx5e_tc_flow.
The delete path now iterates only set bits, matching exactly the slots
that were set up during flow creation.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h |  3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c      | 10 +++-------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h
index efb34de4cb7a..a0434ceebe69 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_priv.h
@@ -97,6 +97,9 @@ struct mlx5e_tc_flow {
 	struct mlx5e_hairpin_entry *hpe; /* attached hairpin instance */
 	struct list_head hairpin; /* flows sharing the same hairpin */
 	struct list_head peer[MLX5_MAX_PORTS];    /* flows with peer flow */
+	DECLARE_BITMAP(peer_used, MLX5_MAX_PORTS); /* tracks populated peer
+						    * slots
+						    */
 	struct list_head unready; /* flows not ready to be offloaded (e.g
 				   * due to missing route)
 				   */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 3846c16c3138..2a16368a948e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2128,6 +2128,7 @@ static void mlx5e_tc_del_fdb_peer_flow(struct mlx5e_tc_flow *flow,
 
 	mutex_lock(&esw->offloads.peer_mutex);
 	list_del(&flow->peer[peer_index]);
+	clear_bit(peer_index, flow->peer_used);
 	mutex_unlock(&esw->offloads.peer_mutex);
 
 	list_for_each_entry_safe(peer_flow, tmp, &flow->peer_flows, peer_flows) {
@@ -2147,16 +2148,10 @@ static void mlx5e_tc_del_fdb_peer_flow(struct mlx5e_tc_flow *flow,
 
 static void mlx5e_tc_del_fdb_peers_flow(struct mlx5e_tc_flow *flow)
 {
-	struct mlx5_devcom_comp_dev *devcom;
-	struct mlx5_devcom_comp_dev *pos;
-	struct mlx5_eswitch *peer_esw;
 	int i;
 
-	devcom = flow->priv->mdev->priv.eswitch->devcom;
-	mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
-		i = mlx5_lag_get_dev_seq(peer_esw->dev);
+	for_each_set_bit(i, flow->peer_used, MLX5_MAX_PORTS)
 		mlx5e_tc_del_fdb_peer_flow(flow, i);
-	}
 }
 
 static void mlx5e_tc_del_flow(struct mlx5e_priv *priv,
@@ -4618,6 +4613,7 @@ static int mlx5e_tc_add_fdb_peer_flow(struct flow_cls_offload *f,
 	flow_flag_set(flow, DUP);
 	mutex_lock(&esw->offloads.peer_mutex);
 	list_add_tail(&flow->peer[i], &esw->offloads.peer_flows[i]);
+	set_bit(i, flow->peer_used);
 	mutex_unlock(&esw->offloads.peer_mutex);
 
 out:
-- 
2.44.0


