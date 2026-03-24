Return-Path: <linux-rdma+bounces-18571-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFqZLoCFwmlVegQAu9opvQ
	(envelope-from <linux-rdma+bounces-18571-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:37:20 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4A530863D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59C11303A0C2
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BE63FD145;
	Tue, 24 Mar 2026 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DKv6OeYX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4353FD12D;
	Tue, 24 Mar 2026 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355466; cv=fail; b=laviT9UL9UKdi7oIfSOvvFaDUyBFdNO/b94Tt06JyQ7EJEld6pL7ElC++V354JceiNNemDPlOpwO30PsPVavUJ9eAHTpR1e41aEt27wSaew6G/q5KPOrubGQyLJ6ljIAMbCYlr1IMcb7rysnodR1zeC2R5f8/pzr4ElCzo6HPPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355466; c=relaxed/simple;
	bh=QGv54V7hK2CAIEzhn4H9m9sSyEkeF+w2Pcw2KBOTCGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+7wvLpYcOHghM66tKr2bUGKBRd+JJOPI3ZpouQQQHvqe94DkWjNcOkFjvnOCoJu9GjGGPtD3g/TrN3Ov8BBzAsriHh5vDsyWKbKn5t+YJdyHGadzJxP9aRBUAklRDT+EVPfCT+N4INf+hzsk7KILI4BCFNCruCR6AOltvlAqdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DKv6OeYX; arc=fail smtp.client-ip=52.101.57.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xhz5xHGlwtUpGavIuA1pxWMTZ+3icBvrTiSwNTgVsoz+vB7rzY99GRUEiYmyc9B/sFsdSK9ULUevoPs724DR2swg4ZnvMW0OA8hZ66raCpDpsi3PNsQE7la4ScaaDrQMFlybas02wvTGK3RN484IZj1kJ6pfJ6i5/pKWpJkJURBepvLlaunhhqlCsvVWV5orcFri5VphcmYhyQO2ABDbLp0DD0AXJ0dB2bvihjVrUYoFPLStW/6KIX1WxbowSB6gumTSzf9P95z07paD+x0w5Ob9eDycCVdZnzWbtvFHD3+yO+nwqQGrW6fTVuTY4kjeYFbkjx/ULQnlPgH64ph5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBUpjInFLVeZq4G9d5itiAaVZ/kyu9u97IT77qcsgbw=;
 b=wLFCZIsBASNDkwIKgSce9JsQPmhELolVxvMxm2zFkO7RbB040LWWe+hVHEa0CSMRjkJL8pY0QkxiG7ao8rLJ48ICtNp6uZpzC2BoBGXFCNjx5LN5Nyxf+qi/nlYeuqT2cGZtENe/+FrAkEm82gWCuO4EjHxEzyNE7F5XJBfcRUhjkqU1rORLXcehxgmtTG1cnwpv5Dbfy6xPjRmK8tJ9sllMq7FlGQxPaO7rVu48ytkC6GjrpcaJZdHlVjeia7UqpKmyvV4MdkxwiCq6qDaWjuTsjWdmGWF9qwswy4ukbeS5X10FROgfIeAtmBOrvbDTPaV+VT6K2VCVO9HAjSLHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBUpjInFLVeZq4G9d5itiAaVZ/kyu9u97IT77qcsgbw=;
 b=DKv6OeYXgtF2OtV8ujL7OTu36jhBVJO+DZURdJnYF0NxkN0baOSTBlsoA/3EwHOsBEV6AuhvLVHA1pIDrDqEd6BHgw9guE5opZRApt3CI7dagsANnvnSDPi4xwIr9amLrlFJnrGW7+EtMp/dCrPgqkDjuhYN1i/Z1IKxuhEDsfpmnY8BKaXPaAyKHDdGcy9YMLKJa6shMTuJM4edq8oPSjmlRNhPQENPy1kpY8EpeAgfurYaLpjVktOyMg+YH0gGiD/KtdljPzS+rcOW2SxQkez4B/y8LizEkPqrF8kzhD7oWuwbgOa8RLBQnn4W8Hodv8sIarGgB3S8jRrx7eoUNA==
Received: from BLAPR03CA0159.namprd03.prod.outlook.com (2603:10b6:208:32f::34)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:30:58 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::1d) by BLAPR03CA0159.outlook.office365.com
 (2603:10b6:208:32f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:30:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:30:38 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:30:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Mar 2026 05:30:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Chuck Lever <chuck.lever@oracle.com>, "Matthieu Baerts
 (NGI0)" <matttbe@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Shay
 Drory" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next V8 08/14] net/mlx5: qos: Use mlx5_lag_query_bond_speed to query LAG speed
Date: Tue, 24 Mar 2026 14:28:42 +0200
Message-ID: <20260324122848.36731-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260324122848.36731-1-tariqt@nvidia.com>
References: <20260324122848.36731-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f106379-7a9d-4b8f-0135-08de89a132d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WcEOWmm/CJ79fSOyCaBCQ/fmkf4PTel0BiTUjpZamSHAlNnRV+WZz5J8HbWHcRnKn8ycfwVx5Lza7hFRkiOm3JHZw7ELYGgdvKnLCGSA958vYTcdpi7c8NH8H51BNq4uCTgg9ipziTYRt/C4EQBqxch4qr47MzbyePo1NLibuFLu93alX+M3GcvmvFcFXaPQlEw+IFoUvXz0Tn1IqfcYhI1fnvrrmUPwK8OQWHg3BtONeuszBDz5zufONhTfI3t5qK+0VbPyyA/H4MEm2tb+IqFc34/0NDMsR7dOJYLeg/4QrwS3Paif6FntMxjnXzbrTBltFI/le+qqB/IgBGCslKqqND9S/CKSth2jYmJ5O0QYfVlcuVAXTBJDkRllQtQwu59Hb+zTaH1TAvERpm9Dll40PyR/Yp97MZO9ZBlAM2F3vRdQ7uPoS/GLWa3KUPdMSHASNHkBYda9anCakti6ftwDKaBzyeq5gvv3SY2LRpZBhQjFJ3lfAhchzKgxOeJ7tYLA0mOQgKIKE6Q6B3A/kvp9EL2b30oVrdTglhx5UArM3uaDfTZDsQ+Xqy97lvfkscIk3XNOcGl6+gSCIjGuJs+11EHJ2vNY8Nlu/ssf7BHvgfDBzI/X8F4uzZm6xor7o30b1JrbbygKxqVPmmwDY3uqjlwgHV2jGQfGeBS4Ax6gKxHkO6/8iwo6X3tOOAuxjuLKah8feZOenRfZ6al46DqJCr3bGwp0g3Iw2ZPAipv9WynoNPcagr4Myn8IbAn4Pbr6S4F571WJGsU++kZTIQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PBofvWOa50WVSD7kN3O93yedtM+v9IAvVVbKqE41ixNMBFKNhKtBmMOZVyXGLDRim6S+CHopJ7we/RbpjwmOcsQdfZsTWSUYsJGs38rPlbou3N7e1dqXGrLN5shiI5+I1ZPezifrv/0pGJzEZzklX/jIob2xw5c//CR+AIlPulRCWWv74J8hqMxu+3+GWwKKy+7qtntQ6+/IO4CbZSZD4PAWPOPcUSIBp+AklXhT1K03X9sn2lRMpXVD+Toxt8J13LqTSLzJVMrA67KzgFpZ8dM0E6UcmarEgKGx/eh8zJ+81nRgi03BT5YZOzs5WEVzAlRFvpLlhzvMmKM5ED0FCD/H5Fl+4Yt1QaIHdDbBGma0mWIsnXZuavh084ntaGqiaA7W2HOXnHwwL6/LLn6UBtWbWYiwUEtCl9UYne+q5DglhvEzXjt+gIhID51j9Ygo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:30:56.6840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f106379-7a9d-4b8f-0135-08de89a132d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,google.com,davidwei.uk,fomichev.me,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18571-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9A4A530863D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

Previously, the master device of the uplink netdev was queried for its
maximum link speed from the QoS layer, requiring the uplink_netdev mutex
and possibly the RTNL (if the call originated from the TC matchall
layer).

Acquiring these locks here is risky, as lock cycles could form. The
locking for the QoS layer is about to change, so to avoid issues,
replace the code querying the LAG's max link speed with the existing
infrastructure added in commit [1].

This simplifies this part and avoids potential lock cycles.
One caveat is that there's a new edge case, when the bond device is not
fully formed to represent the LAG device, the speed isn't calculated and
is left at 0. This now handled explicitly.

[1] commit f0b2fde98065 ("net/mlx5: Add support for querying bond
speed")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 36 ++++---------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index faccc60fc93a..d04fda4b3778 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1489,41 +1489,16 @@ static int esw_qos_node_enable_tc_arbitration(struct mlx5_esw_sched_node *node,
 	return err;
 }
 
-static u32 mlx5_esw_qos_lag_link_speed_get(struct mlx5_core_dev *mdev,
-					   bool take_rtnl)
-{
-	struct ethtool_link_ksettings lksettings;
-	struct net_device *slave, *master;
-	u32 speed = SPEED_UNKNOWN;
-
-	slave = mlx5_uplink_netdev_get(mdev);
-	if (!slave)
-		goto out;
-
-	if (take_rtnl)
-		rtnl_lock();
-	master = netdev_master_upper_dev_get(slave);
-	if (master && !__ethtool_get_link_ksettings(master, &lksettings))
-		speed = lksettings.base.speed;
-	if (take_rtnl)
-		rtnl_unlock();
-
-out:
-	mlx5_uplink_netdev_put(mdev, slave);
-	return speed;
-}
-
 static int mlx5_esw_qos_max_link_speed_get(struct mlx5_core_dev *mdev, u32 *link_speed_max,
-					   bool take_rtnl,
 					   struct netlink_ext_ack *extack)
 {
 	int err;
 
-	if (!mlx5_lag_is_active(mdev))
+	if (!mlx5_lag_is_active(mdev) ||
+	    mlx5_lag_query_bond_speed(mdev, link_speed_max) < 0 ||
+	    *link_speed_max == 0)
 		goto skip_lag;
 
-	*link_speed_max = mlx5_esw_qos_lag_link_speed_get(mdev, take_rtnl);
-
 	if (*link_speed_max != (u32)SPEED_UNKNOWN)
 		return 0;
 
@@ -1560,7 +1535,8 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 		return PTR_ERR(vport);
 
 	if (rate_mbps) {
-		err = mlx5_esw_qos_max_link_speed_get(esw->dev, &link_speed_max, false, NULL);
+		err = mlx5_esw_qos_max_link_speed_get(esw->dev, &link_speed_max,
+						      NULL);
 		if (err)
 			return err;
 
@@ -1598,7 +1574,7 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 		return -EINVAL;
 	}
 
-	err = mlx5_esw_qos_max_link_speed_get(mdev, &link_speed_max, true, extack);
+	err = mlx5_esw_qos_max_link_speed_get(mdev, &link_speed_max, extack);
 	if (err)
 		return err;
 
-- 
2.44.0


