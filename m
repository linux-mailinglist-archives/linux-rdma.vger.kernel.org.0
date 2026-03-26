Return-Path: <linux-rdma+bounces-18690-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L0iCozaxGkq4gQAu9opvQ
	(envelope-from <linux-rdma+bounces-18690-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:04:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A333302F8
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 949C030ADFAB
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 07:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2CF3A5427;
	Thu, 26 Mar 2026 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z/j0nCyc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1742E3AE6F1;
	Thu, 26 Mar 2026 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508520; cv=fail; b=JG5o2DvahyBZALr1gcTMm2dlGXE6kwGiNzYIsDtdv5aBWy5rri0eajKYPej4wDsIacZR0Ax3ZKWTphHd+k1Hk7cA66ytBcrUjeXmZ6ZR0oAdEr8tais03dQftkDJun2UE8aIDhS0mPyA77sC1IGs+arJ1eHc8zZ/UBfdbdKytqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508520; c=relaxed/simple;
	bh=QGv54V7hK2CAIEzhn4H9m9sSyEkeF+w2Pcw2KBOTCGo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1YhyiuLFZkyAT561oEd/TK71VnldQSYDz6miOxX5kNacvq8r3dZ+INH9n01oKtYfPzb1uxfrLen4tsK7x5gERTf2nyDqJVEWWYpGzPZjtUwmi6okEIEIt7NaOln/rdnkRUtiffwyIztuIZeEvFd2C98nX1SHc8KEptLhFsd8Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z/j0nCyc; arc=fail smtp.client-ip=52.101.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGQteA4KHot6gaR46eBf9EkKIh/4gafOd/OjLupUo5XZYV13qjfEi6HjqygCT9c0tjGc8m9us5xOC3lLvq5OnT+OANwo1UMGdENEM14heNUZHQm+GAj0bFN/AgQMf76x4mNGN1LpEZSQ35tcHI+u44DusF9c2HbsWa15GX8xxe9A1s2AKxY/kuCbIVZaVEFxbdy5PY4ZSik6ZkiyKIzdwOfP/f1spZ9XE/xeBXO6Axt0/F4m4aTMf3mOeVUyEHx6UpWY92dmf0ltDEMxMoUr9BZKYUyXtnOfo08WkfTjM2cK3mcWrP87i3HT+UG3vGfqhORIn19AuVB+p0nYAIZXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBUpjInFLVeZq4G9d5itiAaVZ/kyu9u97IT77qcsgbw=;
 b=mj3ST7IRRTi5B2sOO0WwIUtxdY7P8zK7Zgss+Hd9REhZixn7ps2AaRo8fjcPOHgB1lI6EBl0OIDWUrz53uQKbLotNHo/bfi2Cnk9URLhAHS9toKM1VG5udGen2KIF4AIgdHGM3n+8uHfnb9hM6mGNxIG2LImmVBLdTIvYeEhuTb08f+IiIIIxRTQrIdL1gTqmcdxXSzpW9QEQ6j5SDFCO/6/zZhrlUWf7QXZIN30NmPH0kZgMWPX3uN6Z5wWc+fcQct0iXTw+jDaUyLNfni2RuHSG//2oRVymbI4OFnbF0vsEbD0C/RlTOTn4gfx23vq0lQrO7SXNPNKHVFWboBG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBUpjInFLVeZq4G9d5itiAaVZ/kyu9u97IT77qcsgbw=;
 b=Z/j0nCycLEq09E8ApJkU8BwL3MvTtFBxrEGHbM11jmsefVmklEy/MkgAt2jPHlw3mfn45bmDaOR+9XF/cCnjhnzlsEVV6FDETzQDHCVJRDXDmtwp1wV1izBR+T4fWzdNAkA/4e58Wh0SvcjIV4DqN0A2iWWhO7wmvkVG+b1erQKa0dg+r/Vw2q+zfPKKVTOvtWeT/FqdPPVCnP13yoIUZ4z2v+SZBh8JbLEe2bwZ7S7mmNw4uGxKQwun0FNhKNfXZPtrYUWlnEKhuQhoKUdeysGFHdpio4IR4Kb3aHndkUM1y2L1had2f9Pof2zM5klEVTBB+6tfQ3khpC+aP6Ykqw==
Received: from IA4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::17)
 by CH3PR12MB7618.namprd12.prod.outlook.com (2603:10b6:610:14c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 07:01:48 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:559:cafe::6) by IA4P221CA0007.outlook.office365.com
 (2603:10b6:208:559::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 07:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 07:01:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 00:01:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 00:01:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 00:01:36 -0700
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
Subject: [PATCH net-next V9 08/14] net/mlx5: qos: Use mlx5_lag_query_bond_speed to query LAG speed
Date: Thu, 26 Mar 2026 08:59:43 +0200
Message-ID: <20260326065949.44058-9-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|CH3PR12MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6dcbb2-c6a5-43ae-e2d5-08de8b058caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sPYL1Phda7c+pEgYmEnjxLQjlFkQrScB3ZUKPbhhH9jb5YnvC1lJCHp3BDThmaLx4CdafCu0T0dO9Gyeevy0uPXWS3FHvnLbmmvQmwy5mbN1jVZJYPlKnVQhhDiNwvG6JCT+NRXK0ngLcyLZEJNi4yEC363zZnkpbmHncRBhejvhvZOoduvDEIZFFhNq8+90x0gDayfpzIw7GxnqzeBE8u3gS1gY1CvTQTdedMWhuwPTIhuFhbvoH3lh3/MB9UoEYM6xN63/uJv+yWzNuB/p0u+UpV8Hwt10CcZEBeMfVVcuIiYej0jE+YkYhgWZMi6wymtkzvlZ6l1M+H7gntIzRHqpdquFsiIkT9EANyd8tDsUERngLJcz4Bvxu0MdaH+NoxHMKUQHt+070a2mSjeLLj7w9gV44y6icwmqJE2OkxeQPY1X2hAR+H8lvRUtomqu43mKfINjQw7s8QgsG3MAktQomff2GDA6DQcGU0gHjtM9+sqMM5dicHERDRecVMaiRXRTW9h7SuxvIgndl83uq5HLikLaYjsO9tq/yDNi+5K2fHi9TtC/NW4FazUaFu3lhPKd826w+kO2drQZ26dCkvDpI7gx6gOuINnmrWS8RNMBOGAquiJ8H9WmJ+QiygHGmQy/yLc9IthN2TPiaPcLaSn2TZ/jF6303CVoTnjDQKyCZQHvLLUPhBFXrGbxa0300TnKu8tvJmuIKbJHsEuqGwalFAubBt+IQ9TqDNAoNNbnCm8QhMC0I3IK7OpNXUSawUgDyFAODiVvXdq90elLww==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S6khxAYwNJ0Xrfs97rQ564WYlIjy4Ebu4ceteQHWE6k1wAEuiTOYdl9U1fv6TMZzGxgZDWaxqC0TV7OLWihnlYkWm6P/dI/NkM868NaJJMlKeSjZUkgwusE5JP7TByvwG+QyQPginI2Z2UeXKVKq2cNuMos5RKlEBsXN/ZjnBEk0S9YxhGp3LH6CYWE20GrHBzP92ut1o6yBl1l9xMuxqi4gbR28k0Z5k+W61yP85zxFQnFehHgEsrQ9K4Fmic9hB46bzcQQ99anQH1JfFhukWE1IrKypBbAnUII7AiH8TkCX1qev6i/w5H1D/8tsHXBXUaFFQO8XtnB26kjGei3R2+5wsUzhQQFhdQwsOuC2NTIcrkYsxOpZ2Il72VuY5kmgiYBmjzYQ1yJm6YzZCiL9Szi7NO+R24tUYvphNph39CEobbCjT7OdTt63FIveIzq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:01:48.2697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6dcbb2-c6a5-43ae-e2d5-08de8b058caa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618
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
	TAGGED_FROM(0.00)[bounces-18690-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D1A333302F8
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


