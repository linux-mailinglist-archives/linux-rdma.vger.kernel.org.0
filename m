Return-Path: <linux-rdma+bounces-11147-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CABBAD3C75
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F66B18975FE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC6124166F;
	Tue, 10 Jun 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kMLz1JtV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C90E241131;
	Tue, 10 Jun 2025 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568325; cv=fail; b=u+YAEv3m4WfwX95KrxggiAXtEPiDvFoq1FAJuDQA7cn71hI9ij3e+k4e1I7rFjIPmMYUPWEHaslULdFp38swBl8e3fIyVAi+uF/7JOGPVYhmocgyG8QkG/D4wK4biBABlspl/zY9EnhNyDob5klhab+so1EZ/bc6QehzFRdk95Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568325; c=relaxed/simple;
	bh=dBWmL27iqY7NT25IKggnsBH3DTGF04107Yk+pi8pLRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncXtl85UMMJEgVENZZ1YQwJ+C668ofHEkxIkkCk74s0BWuKEFG+hqGLgM+CdxUY+utSmZfQ1CN1D3i3ZzTFpHlwV3K6MbmSF0GcFNa67vrSDg2h0kvinY24cY0CtU86XBW1DuDPzwnT4m64kmijrz7SkIR2BPsPBtLZhkKVw05Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kMLz1JtV; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3XJ0hKwZDzDejx2XBBaq/XedtYvxUQlKsc406fxVKjAFEzJ1FSNc+oy6s2Mi2t+qNa3SL5iVS66TmDUmnRuPMO6GwtMASnhMOjuSQk5BE9tN6cKYyRilA7YNW8TN3IdGH65X63zR8b7gX6M7DNzSCQgnSlU+sqACnjVBN3x0YPowywgHp20o+6bApvVJY9kioUO1ztsFYSwTtNALuQrXvTDuKgJTu9MmJSgAUYcY3hG6M2JSFPiUiZN9TL2FIwXIOPEUdsuJDRdQTl2ay4fr809NbBzWL0RD9OY9QJTgicR02xVH63M369cXP2psDCXvIubJkmSYN0jwkHx5VDpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixwoh1AqfN0SSe/5EGnEDm3XZKwJMJ9DwWKOEsrpBL0=;
 b=RIbVwdQC60O2mFlUoAmCaoZCmi818Arnmqb1EQERO35F///o43fToDkra3bS7f9PRu74QT2AhklxR/MLXgnYNT4idffl4Xmwl7EszvqTxzR5uuP4mW59LIIpxr+eZyVOpCXeWP+ozo7G3HBrV1X7207XgWdQNkZHoYO5lJ3YkWRHTdcK56+IXNGlIQwqtJdLAsOToMy//CoCSbWj+jnEZU58AHtr5jimFnJ6auH0PspsYGeeyMvVqm1rE8Gub93xXSGLTRP84D5gH6XY8ahiQvcjtu3VZNP+FU9IC6wXhM8Xlqi0k0hIVQuJeM2h2ucQK70I4Vm9PIZDS1be8A9dGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixwoh1AqfN0SSe/5EGnEDm3XZKwJMJ9DwWKOEsrpBL0=;
 b=kMLz1JtVhQCe/7vKVYhpltF+y2DAyDAjO2rIqTRcMocf3udf4Htl5eknzb48vggBRCfNrtHv/X7Bhy2glOEO2mDMoLkTNabzxechl3pV0oWpnPaoMYYUNUiUwI46tXCijbkBZomT7SPXhOKKRphghTpw+RHkm7prb+wAzu5rEMg8aUXG2f2Qv3mB36M3tNN/nZCJCP+D+5mL+yokr9Qm//Z/qp8qgiaDmwQNiqOzV3QHVe3gYQw498wSzYRtroj4tQ3UbHTlESHYGppRTNeLvHBhumPq1j3jCK3LY0BB6nIy0ZEkohZQI2MusUYuQwnRtIxoEzBHnuUaX12LM/Dluw==
Received: from MN2PR14CA0005.namprd14.prod.outlook.com (2603:10b6:208:23e::10)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Tue, 10 Jun
 2025 15:12:00 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::d) by MN2PR14CA0005.outlook.office365.com
 (2603:10b6:208:23e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Tue,
 10 Jun 2025 15:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:11:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:11:32 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:11:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:11:28 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v4 09/11] net/mlx5e: Implement queue mgmt ops and single channel swap
Date: Tue, 10 Jun 2025 18:09:48 +0300
Message-ID: <20250610150950.1094376-10-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe00c9e-8b65-4dd8-a858-08dda8312603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C/fngc63NvIg2SSs5fOUXE2m8PRyY/vH9mNpav4q9mvRtt206MjTRkR4H387?=
 =?us-ascii?Q?lFb2JnNiYEPP0O7lh06WRvVdb+N4Jca1XpjvBcRbwBENSegXMydVAXwU28Dz?=
 =?us-ascii?Q?AkK17QwlCNKNmS98VZPpw0VjDvGFOUX4VWDmziXRdgtotJd8Irlmeit3JGZg?=
 =?us-ascii?Q?w26/pRZRqcdUuoh0VlQMPQSkK/1QZJCb1yvGut+2RCSRG6zXhT0a2iYQbK3W?=
 =?us-ascii?Q?Ikco9PPwPUdRyos+IMytl+r1il70wWlT99vIDOt4UBesoPbWlp7jS/Ewi1Gs?=
 =?us-ascii?Q?qD2XUoAS5tIVahdcOTSVy5E5ChRsM4pPewRFT1zg1sU0cthPG66eVwbTyE5M?=
 =?us-ascii?Q?vUiDV6Mu3PIhIpDICFltIILJnK16PJt+AkoQMmCBjvwfHtoQ5CP7iMw3JGiD?=
 =?us-ascii?Q?nl+668zd8t/8LQna1YRWFI+GUrDG4ZxUkHGRUsZBfj0FS9hINZA3IrrtUMSy?=
 =?us-ascii?Q?/yaNdzZwKZZncrdR0GKnJaCSMXZGt7ODSX4urf8RSZbl5Ju9wxnPGKW+WTYS?=
 =?us-ascii?Q?xNEp7JoF6kUJ/HaMvsHsNT80ixV6MXzoumffd4Ezv5WyWdIP66n4jMBzqhMy?=
 =?us-ascii?Q?akGdeDP86JwRpzPgDu5J5Z5g5gkWjOfFM/+tyieyFArEArMcZKDai+vFKP0D?=
 =?us-ascii?Q?zGJ2tvzZe2pjqiAc1ZqkeEsCxSzK7Wjsw7ItIEzazG7jNFINl1aODrogekke?=
 =?us-ascii?Q?vZK6U9MyEsJ4HGrm8N1+jJNdxCZY/9v3VvGg0vUOKUri2ht3Zb4T0n8a4Ml3?=
 =?us-ascii?Q?OP/OwmHKqsAoMc3l5jnREZhSKaTHhzrBkPEJQzc5YfPDlchyHCIut3HfQ9bJ?=
 =?us-ascii?Q?zAxkbhIoH/hpy4s1oxmT2rHMPwnvipKo/ZlFYSog6mkZ4MFuuwhTR88ZokMs?=
 =?us-ascii?Q?jaLdpRzemnumMPLtiA5pOWkO+zh/QkEnnorEDKqr2Ga+2DU0geCvKeaanofo?=
 =?us-ascii?Q?CANz/3B3D4iNM8jhJAs0d5GNUKAmOFlVGp+SiQcNLC0w10L3hrv8cVKRdjdV?=
 =?us-ascii?Q?yeXNZKI0SppllVN/wlfSoXOidC/YfDxxCv22tRohDwhadgK9/zp4AeU5HHhj?=
 =?us-ascii?Q?VXQQOlDrr2bqsdRci70xFOTWLD7K+kO4srxHRnohaYdzqXjtiz5yfXgZtw7c?=
 =?us-ascii?Q?YJa9Zc2eV73O3a+2fAw4aIxNUey80HyKk1Y/TdwIFDYxPucxAYbxLLs3JhGX?=
 =?us-ascii?Q?0arfdVyq9AOQL/uV59fQB3LSsCh+hX26zxb3nBpwqDu6WNp9mL2asUYrc7f1?=
 =?us-ascii?Q?kdh3NFZ2ZGu40P/RiQO0GxBuJ0QXBBmlnGezeX3SsvdMFQhlo+20nFXsXsf7?=
 =?us-ascii?Q?KP3w8aHWcF6UfhioypZ+18krHtXDcMMtesjYWIHoZBtxhiDD+4SKtTzEMxSY?=
 =?us-ascii?Q?8Y1/2Z6piheP+cC3YTgFmj/8TgLcjKrtg3NLPELhx1TrYUIhlneIMr2Osfe+?=
 =?us-ascii?Q?Imz6cCvVlAnvxeCowCV92ZiCmWYNmKz+4HgxZHp0wGZO9JPRfr3vcgTLL08+?=
 =?us-ascii?Q?WmULKNO5VNOkrL1sfnyBWjjVFqWbqZIkNsfM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:11:59.9130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe00c9e-8b65-4dd8-a858-08dda8312603
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600

From: Saeed Mahameed <saeedm@nvidia.com>

The bulk of the work is done in mlx5e_queue_mem_alloc, where we allocate
and create the new channel resources, similar to
mlx5e_safe_switch_params, but here we do it for a single channel using
existing params, sort of a clone channel.
To swap the old channel with the new one, we deactivate and close the
old channel then replace it with the new one, since the swap procedure
doesn't fail in mlx5, we do it all in one place (mlx5e_queue_start).

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a51e204bd364..90687392545c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5494,6 +5494,102 @@ static const struct netdev_stat_ops mlx5e_stat_ops = {
 	.get_base_stats      = mlx5e_get_base_stats,
 };
 
+struct mlx5_qmgmt_data {
+	struct mlx5e_channel *c;
+	struct mlx5e_channel_param cparam;
+};
+
+static int mlx5e_queue_mem_alloc(struct net_device *dev, void *newq,
+				 int queue_index)
+{
+	struct mlx5_qmgmt_data *new = (struct mlx5_qmgmt_data *)newq;
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct mlx5e_channels *chs = &priv->channels;
+	struct mlx5e_params params = chs->params;
+	struct mlx5_core_dev *mdev;
+	int err;
+
+	mutex_lock(&priv->state_lock);
+	if (!test_bit(MLX5E_STATE_OPENED, &priv->state)) {
+		err = -ENODEV;
+		goto unlock;
+	}
+
+	if (queue_index >= chs->num) {
+		err = -ERANGE;
+		goto unlock;
+	}
+
+	if (MLX5E_GET_PFLAG(&chs->params, MLX5E_PFLAG_TX_PORT_TS) ||
+	    chs->params.ptp_rx   ||
+	    chs->params.xdp_prog ||
+	    priv->htb) {
+		netdev_err(priv->netdev,
+			   "Cloning channels with Port/rx PTP, XDP or HTB is not supported\n");
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	mdev = mlx5_sd_ch_ix_get_dev(priv->mdev, queue_index);
+	err = mlx5e_build_channel_param(mdev, &params, &new->cparam);
+	if (err) {
+		return err;
+		goto unlock;
+	}
+
+	err = mlx5e_open_channel(priv, queue_index, &params, NULL, &new->c);
+unlock:
+	mutex_unlock(&priv->state_lock);
+	return err;
+}
+
+static void mlx5e_queue_mem_free(struct net_device *dev, void *mem)
+{
+	struct mlx5_qmgmt_data *data = (struct mlx5_qmgmt_data *)mem;
+
+	/* not supposed to happen since mlx5e_queue_start never fails
+	 * but this is how this should be implemented just in case
+	 */
+	if (data->c)
+		mlx5e_close_channel(data->c);
+}
+
+static int mlx5e_queue_stop(struct net_device *dev, void *oldq, int queue_index)
+{
+	/* mlx5e_queue_start does not fail, we stop the old queue there */
+	return 0;
+}
+
+static int mlx5e_queue_start(struct net_device *dev, void *newq,
+			     int queue_index)
+{
+	struct mlx5_qmgmt_data *new = (struct mlx5_qmgmt_data *)newq;
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct mlx5e_channel *old;
+
+	mutex_lock(&priv->state_lock);
+
+	/* stop and close the old */
+	old = priv->channels.c[queue_index];
+	mlx5e_deactivate_priv_channels(priv);
+	/* close old before activating new, to avoid napi conflict */
+	mlx5e_close_channel(old);
+
+	/* start the new */
+	priv->channels.c[queue_index] = new->c;
+	mlx5e_activate_priv_channels(priv);
+	mutex_unlock(&priv->state_lock);
+	return 0;
+}
+
+static const struct netdev_queue_mgmt_ops mlx5e_queue_mgmt_ops = {
+	.ndo_queue_mem_size	=	sizeof(struct mlx5_qmgmt_data),
+	.ndo_queue_mem_alloc	=	mlx5e_queue_mem_alloc,
+	.ndo_queue_mem_free	=	mlx5e_queue_mem_free,
+	.ndo_queue_start	=	mlx5e_queue_start,
+	.ndo_queue_stop		=	mlx5e_queue_stop,
+};
+
 static void mlx5e_build_nic_netdev(struct net_device *netdev)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
@@ -5504,6 +5600,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	SET_NETDEV_DEV(netdev, mdev->device);
 
 	netdev->netdev_ops = &mlx5e_netdev_ops;
+	netdev->queue_mgmt_ops = &mlx5e_queue_mgmt_ops;
 	netdev->xdp_metadata_ops = &mlx5e_xdp_metadata_ops;
 	netdev->xsk_tx_metadata_ops = &mlx5e_xsk_tx_metadata_ops;
 	netdev->request_ops_lock = true;
-- 
2.34.1


