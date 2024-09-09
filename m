Return-Path: <linux-rdma+bounces-4839-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E64897211B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 19:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812BD1F23ACA
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D09217E010;
	Mon,  9 Sep 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gEmLamTf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0C2189511
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903081; cv=fail; b=mxC5tEAAfJUIIXow9Tvp0rDnxrWkYW0w1ZASNuZwcYYHZGNjEs363HXgBQHShtsSOV6SpjsfsM8snqKOLDErPDWMWLa7yjmHLOyoI1ulZYMxppB+SRXu5+TZ2F1dl6NKQHRk6xOQRNvC+BClrTmVDa6/bzN0FBPqbegqbIpxdXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903081; c=relaxed/simple;
	bh=VZiaL4Y3d+zpT/ihBYP1y8Ayp1drZCVgLlz99LGH0Gw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmKlpk1ku+s6D33mn2t+QeH8ASfi71WKXWDpgZ5mVOXzmOiUR5us4icAFmYZhzNbK46TgrDWVWyBvdPpWJLi6/jmG9uZ3tpG0yBdpjsa80uZeYCQQNxiZeUlychfvp5+NJRtQQMFk8leqrGuCK74IIorPuaW8IAtnpnrqNJqlvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gEmLamTf; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcXP7a+V3ishk+2Fznff54VMyfyjxRInu8MFHjLSSelJYZ9AWwShe2LQyzbhLal+fdLRyI0hXdhAibkX0T++7xvAWk45lqsaY0A6QHxnNDEiJEwcIaN5ncAQu2pl7iBFxwDBDbihgW8+8B0KMQup8lXJXQP/bFM9tre+XxtTyVoxJPbFLE9kvVkwYdkoltEoCQILvIkidi9JN6D0IsEjmu5A2dKsNV/poRnsJL+B14OfDHrcVTf5f3dO9W4FBLcU2LtbK4YGUy78KnsMb4cHMEeJsQBtty4fLiV1nceQcBU6OF6J3bHzrVUpL6va4gIWzLU2kNSH0vUIUUEoFamO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djegOwDop8e4Hm22kUFVHPVy+CRz2dJPTXW11WNhrqg=;
 b=Aa9lziG2JRFvP6gdWTpkv2wl1EINghMiJoKrtejN+jc59bEInupqwIE3cOytQnYGYa7jBbHBBIFth1XBIXu8hH80H894gwBZl2sWUc8AAhzQAGGbNYeQL/+iVzss4R5HCl1KDBzFIVsUV+LkjYxCOSKElWJblHhkyHoY2IbQPFW4SKtgmDmKeZ1SEscqJsI+gqourEySjROK5iuHXW8yA4ENG4AavBnfgsSkwNYunvMds6rOvPykT/VIMs5XlOtX0TojDUA9u4EqJ3qB+EXepq7IiDMPk5RFTEHqYDrt8rB9S758O/yaRz2WBwIso5zGXqAprtKDtdetakyXTueRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djegOwDop8e4Hm22kUFVHPVy+CRz2dJPTXW11WNhrqg=;
 b=gEmLamTfSlQ7i9xNfdDFhZ1nqX/WIx7JNFFsA1cwJ/ZxyTzMRxyvwFyCRwmm2PcFTnsnc6Yaq2yjjm8XyWzDuEBN9hUXs8AN8sTqYWlpcIF5//WEb8RI4WDSNg/7/Nckfau7Fo9hW3t0ZJL6a9mpwsa1P11ki9ZYaimYvLZaCOHBm9pbCQGrN2xBSS4nK6I6T0NXQuuuf/tZMmSM07UM6bBrHQF/pn/EXN6CEE+n6a4eo7sQ/2S5+9Pj/+Ko3USdYSDSrQsVGn63pqRJhME88oWYSD/01nfHVs7QAZo0+eCeY0P5bZNanhc1ndXn2l2Uz8mCGyLvVkwVgZbvoNYaFQ==
Received: from MN2PR17CA0036.namprd17.prod.outlook.com (2603:10b6:208:15e::49)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 17:31:10 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:15e:cafe::1a) by MN2PR17CA0036.outlook.office365.com
 (2603:10b6:208:15e::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Mon, 9 Sep 2024 17:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 17:31:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:46 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 9 Sep
 2024 10:30:44 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, <dsahern@gmail.com>, "Michael
 Guralnik" <michaelgur@nvidia.com>
Subject: [PATCH v3 rdma-next 5/7] RDMA/mlx5: Use IB set_netdev and get_netdev functions
Date: Mon, 9 Sep 2024 20:30:23 +0300
Message-ID: <20240909173025.30422-6-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240909173025.30422-1-michaelgur@nvidia.com>
References: <20240909173025.30422-1-michaelgur@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c6af07-10aa-46fb-7abc-08dcd0f531c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lUcd5isnnEH3jny8DIpFfENPNUlT/hfy71+73z5OWLioIavNXvk+yxvZvyOT?=
 =?us-ascii?Q?Gj0sb4XyWgyliJxb9nL1RByOxM1XdljA6kQaF/B1E4wRfFlQ1AL2N1Ww46pQ?=
 =?us-ascii?Q?9maUcOgjJURH2H3kSWb8fLKo650YUaJh5+/+i750U9Ms7ZMkeXVSgzWdFNCd?=
 =?us-ascii?Q?KkYiSn349xtbV/Msg11Q8nwsMCgHM3Sj0y3JnUETjkZHx0Jb6A8jOAjExvfW?=
 =?us-ascii?Q?eiGow3RRWsJFPw5OBNK77oHFSPRLLzQ6NMLDXqeKR+RnhY8BuH90unA/2+w5?=
 =?us-ascii?Q?omkzAQA9Hx+jczkpVQFiX+CYekszJgvV0frRKDZ4nDayosDWF4lbDo3ni352?=
 =?us-ascii?Q?z8WGUwT6zqh7BVYKTBstEPMzDk+PSS7x/rLIzbVEQL5Rj7tlTO17SQigoc3h?=
 =?us-ascii?Q?SqFQEfqlxGUmn/2RIHudei8zoMPg257LH40P2YuOD5sBLLtZrJvxEcLGu4h1?=
 =?us-ascii?Q?SMD0bq1eQxFSKYmZdq9ZhCxAgWYAGJXAYKltADiXBirwj6dAxD6I/BOkQ1W8?=
 =?us-ascii?Q?qKo9sqzvpN9uo7RUdv4su5Fy0mHgZI7UeI35eOSKWgpW5IKo8oR9jQR+u/6F?=
 =?us-ascii?Q?ySBWsWS6ZI49KVcaBOU6eXEdZk5UvX2TgFCJkktJDVCdxB9L7dAU+yzg0d0I?=
 =?us-ascii?Q?fkEqviu57ppUxhMilx9gESnFNJTD1fq21VZSFjHcA94VCFLzufWrxKkyV0dS?=
 =?us-ascii?Q?ZUYZlSzmj2dcVee2smxGPLvoj+gAXgfoSfbarlw0bikvEVDL6M5euStYJ8lJ?=
 =?us-ascii?Q?9KlGHttn7K8I0DV/m+W+uAWtTJgM3b9duBR0Hewqm6S59yBCVhaou5q18K5p?=
 =?us-ascii?Q?OGDLESsdUGCDlssKnTBOKNSgyPzckm6VGzPt7n6bfvUCLW3VWGiS1gHLpH4A?=
 =?us-ascii?Q?7KdeaFg6KXip5lfzpsp55c4e06+XUbKodt/XzWtMAmthvCDNjo66g9GmB6dv?=
 =?us-ascii?Q?iat5DcaC/T43ZJvmC31jJVHeia0ciTm5Bt0yhAFYITKDn+21tCQAg5RGqKhX?=
 =?us-ascii?Q?SmJasvmzMQpMfYFpZErSZlEPXhtQBc/y3daO6ZovAZrMd6mv1qWJK6elXfNa?=
 =?us-ascii?Q?eZdssghX59N5EmaiRXmoSnRT5zrUyE+QewJ3Cl4CZIKCY9ZOGzAYQ3ItuthY?=
 =?us-ascii?Q?3iZEa7DYAQFy3+0C+HSY8wZUQzF7fW5iJPqsgWnbcOJGa2s7/XUtmKVnMj/I?=
 =?us-ascii?Q?YdE7cAPrAW6RFpZrmFLVYS8w3L3RjPI2IXYw6FaKmOBuC8LclfRsNgC6WMJh?=
 =?us-ascii?Q?zGcluSzBOOFdF9qsIDrIRqI+LMQEW1ORsxU7vm4ryQ7GFuLkmokianvdpq1E?=
 =?us-ascii?Q?uBeR10r2kPz+2SFc98ZRD6S6FWbhzrenyB+nbMcoynpT4oENO9IQ2mu2XqfB?=
 =?us-ascii?Q?qp5aGEGGGX+qOcXKOY0sEW1mKmGYoWTLdN86VrcLO/sDPuUr/NVsO2HrpPCh?=
 =?us-ascii?Q?ahNjzWjBc+TyCdh4o9xPMxXSr2awqn1e?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 17:31:09.8458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c6af07-10aa-46fb-7abc-08dcd0f531c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125

From: Chiara Meiohas <cmeiohas@nvidia.com>

The IB layer provides a common interface to store and get net
devices associated to an IB device port (ib_device_set_netdev()
and ib_device_get_netdev()).
Previously, mlx5_ib stored and managed the associated net devices
internally.

Replace internal net device management in mlx5_ib with
ib_device_set_netdev() when attaching/detaching  a net device and
ib_device_get_netdev() when retrieving the net device.

Export ib_device_get_netdev().

For mlx5 representors/PFs/VFs and lag creation we replace the netdev
assignments with the IB set/get netdev functions.

In active-backup mode lag the active slave net device is stored in the
lag itself. To assure the net device stored in a lag bond IB device is
the active slave we implement the following:
- mlx5_core: when modifying the slave of a bond we send the internal driver event
  MLX5_DRIVER_EVENT_ACTIVE_BACKUP_LAG_CHANGE_LOWERSTATE.
- mlx5_ib: when catching the event call ib_device_set_netdev()

This patch also ensures the correct IB events are sent in switchdev lag.

While at it, when in multiport eswitch mode, only a single IB device is
created for all ports. The said IB device will receive all netdev events
of its VFs once loaded, thus to avoid overwriting the mapping of PF IB
device to PF netdev, ignore NETDEV_REGISTER events if the ib device has
already been mapped to a netdev.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c              |   4 +
 drivers/infiniband/hw/mlx5/ib_rep.c           |  23 +--
 drivers/infiniband/hw/mlx5/main.c             | 183 ++++++++++++------
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   3 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  76 ++++----
 include/linux/mlx5/device.h                   |   1 +
 include/linux/mlx5/driver.h                   |   2 +-
 include/rdma/ib_verbs.h                       |   2 +
 8 files changed, 191 insertions(+), 103 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b1377503cb9d..9e765c79a892 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2236,6 +2236,9 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 	if (!rdma_is_port_valid(ib_dev, port))
 		return NULL;
 
+	if (!ib_dev->port_data)
+		return NULL;
+
 	pdata = &ib_dev->port_data[port];
 
 	/*
@@ -2254,6 +2257,7 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 
 	return res;
 }
+EXPORT_SYMBOL(ib_device_get_netdev);
 
 /**
  * ib_device_get_by_netdev - Find an IB device associated with a netdev
diff --git a/drivers/infiniband/hw/mlx5/ib_rep.c b/drivers/infiniband/hw/mlx5/ib_rep.c
index 1ad934685d80..49af1cfbe6d1 100644
--- a/drivers/infiniband/hw/mlx5/ib_rep.c
+++ b/drivers/infiniband/hw/mlx5/ib_rep.c
@@ -13,6 +13,7 @@ mlx5_ib_set_vport_rep(struct mlx5_core_dev *dev,
 		      int vport_index)
 {
 	struct mlx5_ib_dev *ibdev;
+	struct net_device *ndev;
 
 	ibdev = mlx5_eswitch_uplink_get_proto_dev(dev->priv.eswitch, REP_IB);
 	if (!ibdev)
@@ -20,12 +21,9 @@ mlx5_ib_set_vport_rep(struct mlx5_core_dev *dev,
 
 	ibdev->port[vport_index].rep = rep;
 	rep->rep_data[REP_IB].priv = ibdev;
-	write_lock(&ibdev->port[vport_index].roce.netdev_lock);
-	ibdev->port[vport_index].roce.netdev =
-		mlx5_ib_get_rep_netdev(rep->esw, rep->vport);
-	write_unlock(&ibdev->port[vport_index].roce.netdev_lock);
+	ndev = mlx5_ib_get_rep_netdev(rep->esw, rep->vport);
 
-	return 0;
+	return ib_device_set_netdev(&ibdev->ib_dev, ndev, vport_index + 1);
 }
 
 static void mlx5_ib_register_peer_vport_reps(struct mlx5_core_dev *mdev);
@@ -104,11 +102,15 @@ mlx5_ib_vport_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 	ibdev->is_rep = true;
 	vport_index = rep->vport_index;
 	ibdev->port[vport_index].rep = rep;
-	ibdev->ib_dev.phys_port_cnt = num_ports;
-	ibdev->port[vport_index].roce.netdev =
-		mlx5_ib_get_rep_netdev(lag_master->priv.eswitch, rep->vport);
 	ibdev->mdev = lag_master;
 	ibdev->num_ports = num_ports;
+	ibdev->ib_dev.phys_port_cnt = num_ports;
+	ret = ib_device_set_netdev(&ibdev->ib_dev,
+			mlx5_ib_get_rep_netdev(lag_master->priv.eswitch,
+					       rep->vport),
+			vport_index + 1);
+	if (ret)
+		goto fail_add;
 
 	ret = __mlx5_ib_add(ibdev, profile);
 	if (ret)
@@ -161,9 +163,8 @@ mlx5_ib_vport_rep_unload(struct mlx5_eswitch_rep *rep)
 	}
 
 	port = &dev->port[vport_index];
-	write_lock(&port->roce.netdev_lock);
-	port->roce.netdev = NULL;
-	write_unlock(&port->roce.netdev_lock);
+
+	ib_device_set_netdev(&dev->ib_dev, NULL, vport_index + 1);
 	rep->rep_data[REP_IB].priv = NULL;
 	port->rep = NULL;
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 1046c92212c7..a750f61513d4 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -147,16 +147,52 @@ static struct mlx5_roce *mlx5_get_rep_roce(struct mlx5_ib_dev *dev,
 
 		if (upper && port->rep->vport == MLX5_VPORT_UPLINK)
 			continue;
-
-		read_lock(&port->roce.netdev_lock);
-		rep_ndev = mlx5_ib_get_rep_netdev(port->rep->esw,
-						  port->rep->vport);
-		if (rep_ndev == ndev) {
-			read_unlock(&port->roce.netdev_lock);
+		rep_ndev = ib_device_get_netdev(&dev->ib_dev, i + 1);
+		if (rep_ndev && rep_ndev == ndev) {
+			dev_put(rep_ndev);
 			*port_num = i + 1;
 			return &port->roce;
 		}
-		read_unlock(&port->roce.netdev_lock);
+
+		dev_put(rep_ndev);
+	}
+
+	return NULL;
+}
+
+static bool mlx5_netdev_send_event(struct mlx5_ib_dev *dev,
+				   struct net_device *ndev,
+				   struct net_device *upper,
+				   struct net_device *ib_ndev)
+{
+	if (!dev->ib_active)
+		return false;
+
+	/* Event is about our upper device */
+	if (upper == ndev)
+		return true;
+
+	/* RDMA device is not in lag and not in switchdev */
+	if (!dev->is_rep && !upper && ndev == ib_ndev)
+		return true;
+
+	/* RDMA devie is in switchdev */
+	if (dev->is_rep && ndev == ib_ndev)
+		return true;
+
+	return false;
+}
+
+static struct net_device *mlx5_ib_get_rep_uplink_netdev(struct mlx5_ib_dev *ibdev)
+{
+	struct mlx5_ib_port *port;
+	int i;
+
+	for (i = 0; i < ibdev->num_ports; i++) {
+		port = &ibdev->port[i];
+		if (port->rep && port->rep->vport == MLX5_VPORT_UPLINK) {
+			return ib_device_get_netdev(&ibdev->ib_dev, i + 1);
+		}
 	}
 
 	return NULL;
@@ -168,6 +204,7 @@ static int mlx5_netdev_event(struct notifier_block *this,
 	struct mlx5_roce *roce = container_of(this, struct mlx5_roce, nb);
 	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
 	u32 port_num = roce->native_port_num;
+	struct net_device *ib_ndev = NULL;
 	struct mlx5_core_dev *mdev;
 	struct mlx5_ib_dev *ibdev;
 
@@ -181,29 +218,38 @@ static int mlx5_netdev_event(struct notifier_block *this,
 		/* Should already be registered during the load */
 		if (ibdev->is_rep)
 			break;
-		write_lock(&roce->netdev_lock);
+
+		ib_ndev = ib_device_get_netdev(&ibdev->ib_dev, port_num);
+		/* Exit if already registered */
+		if (ib_ndev)
+			goto put_ndev;
+
 		if (ndev->dev.parent == mdev->device)
-			roce->netdev = ndev;
-		write_unlock(&roce->netdev_lock);
+			ib_device_set_netdev(&ibdev->ib_dev, ndev, port_num);
 		break;
 
 	case NETDEV_UNREGISTER:
 		/* In case of reps, ib device goes away before the netdevs */
-		write_lock(&roce->netdev_lock);
-		if (roce->netdev == ndev)
-			roce->netdev = NULL;
-		write_unlock(&roce->netdev_lock);
-		break;
+		if (ibdev->is_rep)
+			break;
+		ib_ndev = ib_device_get_netdev(&ibdev->ib_dev, port_num);
+		if (ib_ndev == ndev)
+			ib_device_set_netdev(&ibdev->ib_dev, NULL, port_num);
+		goto put_ndev;
 
 	case NETDEV_CHANGE:
 	case NETDEV_UP:
 	case NETDEV_DOWN: {
 		struct net_device *upper = NULL;
 
-		if (mlx5_lag_is_roce(mdev)) {
+		if (mlx5_lag_is_roce(mdev) || mlx5_lag_is_sriov(mdev)) {
 			struct net_device *lag_ndev;
 
-			lag_ndev = mlx5_lag_get_roce_netdev(mdev);
+			if(mlx5_lag_is_roce(mdev))
+				lag_ndev = ib_device_get_netdev(&ibdev->ib_dev, 1);
+			else /* sriov lag */
+				lag_ndev = mlx5_ib_get_rep_uplink_netdev(ibdev);
+
 			if (lag_ndev) {
 				upper = netdev_master_upper_dev_get(lag_ndev);
 				dev_put(lag_ndev);
@@ -216,18 +262,19 @@ static int mlx5_netdev_event(struct notifier_block *this,
 			roce = mlx5_get_rep_roce(ibdev, ndev, upper, &port_num);
 		if (!roce)
 			return NOTIFY_DONE;
-		if ((upper == ndev ||
-		     ((!upper || ibdev->is_rep) && ndev == roce->netdev)) &&
-		    ibdev->ib_active) {
+
+		ib_ndev = ib_device_get_netdev(&ibdev->ib_dev, port_num);
+
+		if (mlx5_netdev_send_event(ibdev, ndev, upper, ib_ndev)) {
 			struct ib_event ibev = { };
 			enum ib_port_state port_state;
 
 			if (get_port_state(&ibdev->ib_dev, port_num,
 					   &port_state))
-				goto done;
+				goto put_ndev;
 
 			if (roce->last_port_state == port_state)
-				goto done;
+				goto put_ndev;
 
 			roce->last_port_state = port_state;
 			ibev.device = &ibdev->ib_dev;
@@ -236,7 +283,7 @@ static int mlx5_netdev_event(struct notifier_block *this,
 			else if (port_state == IB_PORT_ACTIVE)
 				ibev.event = IB_EVENT_PORT_ACTIVE;
 			else
-				goto done;
+				goto put_ndev;
 
 			ibev.element.port_num = port_num;
 			ib_dispatch_event(&ibev);
@@ -247,39 +294,13 @@ static int mlx5_netdev_event(struct notifier_block *this,
 	default:
 		break;
 	}
+put_ndev:
+	dev_put(ib_ndev);
 done:
 	mlx5_ib_put_native_port_mdev(ibdev, port_num);
 	return NOTIFY_DONE;
 }
 
-static struct net_device *mlx5_ib_get_netdev(struct ib_device *device,
-					     u32 port_num)
-{
-	struct mlx5_ib_dev *ibdev = to_mdev(device);
-	struct net_device *ndev;
-	struct mlx5_core_dev *mdev;
-
-	mdev = mlx5_ib_get_native_port_mdev(ibdev, port_num, NULL);
-	if (!mdev)
-		return NULL;
-
-	if (mlx5_lag_is_roce(mdev)) {
-		ndev = mlx5_lag_get_roce_netdev(mdev);
-		goto out;
-	}
-
-	/* Ensure ndev does not disappear before we invoke dev_hold()
-	 */
-	read_lock(&ibdev->port[port_num - 1].roce.netdev_lock);
-	ndev = ibdev->port[port_num - 1].roce.netdev;
-	dev_hold(ndev);
-	read_unlock(&ibdev->port[port_num - 1].roce.netdev_lock);
-
-out:
-	mlx5_ib_put_native_port_mdev(ibdev, port_num);
-	return ndev;
-}
-
 struct mlx5_core_dev *mlx5_ib_get_native_port_mdev(struct mlx5_ib_dev *ibdev,
 						   u32 ib_port_num,
 						   u32 *native_port_num)
@@ -554,7 +575,7 @@ static int mlx5_query_port_roce(struct ib_device *device, u32 port_num,
 	if (!put_mdev)
 		goto out;
 
-	ndev = mlx5_ib_get_netdev(device, port_num);
+	ndev = ib_device_get_netdev(device, port_num);
 	if (!ndev)
 		goto out;
 
@@ -3185,6 +3206,60 @@ static void get_dev_fw_str(struct ib_device *ibdev, char *str)
 		 fw_rev_sub(dev->mdev));
 }
 
+static int lag_event(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct mlx5_ib_dev *dev = container_of(nb, struct mlx5_ib_dev,
+					       lag_events);
+	struct mlx5_core_dev *mdev = dev->mdev;
+	struct mlx5_ib_port *port;
+	struct net_device *ndev;
+	int  i, err;
+	int portnum;
+
+	portnum = 0;
+	switch (event) {
+	case MLX5_DRIVER_EVENT_ACTIVE_BACKUP_LAG_CHANGE_LOWERSTATE:
+		ndev = data;
+		if (ndev) {
+			if (!mlx5_lag_is_roce(mdev)) {
+				// sriov lag
+				for (i = 0; i < dev->num_ports; i++) {
+					port = &dev->port[i];
+					if (port->rep && port->rep->vport ==
+					    MLX5_VPORT_UPLINK) {
+						portnum = i;
+						break;
+					}
+				}
+			}
+			err = ib_device_set_netdev(&dev->ib_dev, ndev,
+						   portnum + 1);
+			dev_put(ndev);
+			if (err)
+				return err;
+			/* Rescan gids after new netdev assignment */
+			rdma_roce_rescan_device(&dev->ib_dev);
+		}
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+	return NOTIFY_OK;
+}
+
+static void mlx5e_lag_event_register(struct mlx5_ib_dev *dev)
+{
+	dev->lag_events.notifier_call = lag_event;
+	blocking_notifier_chain_register(&dev->mdev->priv.lag_nh,
+					 &dev->lag_events);
+}
+
+static void mlx5e_lag_event_unregister(struct mlx5_ib_dev *dev)
+{
+	blocking_notifier_chain_unregister(&dev->mdev->priv.lag_nh,
+					   &dev->lag_events);
+}
+
 static int mlx5_eth_lag_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_core_dev *mdev = dev->mdev;
@@ -3206,6 +3281,7 @@ static int mlx5_eth_lag_init(struct mlx5_ib_dev *dev)
 		goto err_destroy_vport_lag;
 	}
 
+	mlx5e_lag_event_register(dev);
 	dev->flow_db->lag_demux_ft = ft;
 	dev->lag_ports = mlx5_lag_get_num_ports(mdev);
 	dev->lag_active = true;
@@ -3223,6 +3299,7 @@ static void mlx5_eth_lag_cleanup(struct mlx5_ib_dev *dev)
 	if (dev->lag_active) {
 		dev->lag_active = false;
 
+		mlx5e_lag_event_unregister(dev);
 		mlx5_destroy_flow_table(dev->flow_db->lag_demux_ft);
 		dev->flow_db->lag_demux_ft = NULL;
 
@@ -3937,7 +4014,6 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 
 	for (i = 0; i < dev->num_ports; i++) {
 		spin_lock_init(&dev->port[i].mp.mpi_lock);
-		rwlock_init(&dev->port[i].roce.netdev_lock);
 		dev->port[i].roce.dev = dev;
 		dev->port[i].roce.native_port_num = i + 1;
 		dev->port[i].roce.last_port_state = IB_PORT_DOWN;
@@ -4202,7 +4278,6 @@ static const struct ib_device_ops mlx5_ib_dev_common_roce_ops = {
 	.create_wq = mlx5_ib_create_wq,
 	.destroy_rwq_ind_table = mlx5_ib_destroy_rwq_ind_table,
 	.destroy_wq = mlx5_ib_destroy_wq,
-	.get_netdev = mlx5_ib_get_netdev,
 	.modify_wq = mlx5_ib_modify_wq,
 
 	INIT_RDMA_OBJ_SIZE(ib_rwq_ind_table, mlx5_ib_rwq_ind_table,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index c0b1a9cd752b..6af8b4df9a5c 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -896,8 +896,6 @@ struct mlx5_roce {
 	/* Protect mlx5_ib_get_netdev from invoking dev_hold() with a NULL
 	 * netdev pointer
 	 */
-	rwlock_t		netdev_lock;
-	struct net_device	*netdev;
 	struct notifier_block	nb;
 	struct netdev_net_notifier nn;
 	struct notifier_block	mdev_nb;
@@ -1146,6 +1144,7 @@ struct mlx5_ib_dev {
 	/* protect accessing data_direct_dev */
 	struct mutex			data_direct_lock;
 	struct notifier_block		mdev_events;
+	struct notifier_block           lag_events;
 	int				num_ports;
 	/* serialize update of capability mask
 	 */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index cf8045b92689..8577db3308cc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -445,6 +445,34 @@ static int _mlx5_modify_lag(struct mlx5_lag *ldev, u8 *ports)
 	return mlx5_cmd_modify_lag(dev0, ldev->ports, ports);
 }
 
+static struct net_device *mlx5_lag_active_backup_get_netdev(struct mlx5_core_dev *dev)
+{
+	struct net_device *ndev = NULL;
+	struct mlx5_lag *ldev;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&lag_lock, flags);
+	ldev = mlx5_lag_dev(dev);
+
+	if (!ldev)
+		goto unlock;
+
+	for (i = 0; i < ldev->ports; i++)
+		if (ldev->tracker.netdev_state[i].tx_enabled)
+			ndev = ldev->pf[i].netdev;
+	if (!ndev)
+		ndev = ldev->pf[ldev->ports - 1].netdev;
+
+	if (ndev)
+		dev_hold(ndev);
+
+unlock:
+	spin_unlock_irqrestore(&lag_lock, flags);
+
+	return ndev;
+}
+
 void mlx5_modify_lag(struct mlx5_lag *ldev,
 		     struct lag_tracker *tracker)
 {
@@ -477,9 +505,18 @@ void mlx5_modify_lag(struct mlx5_lag *ldev,
 		}
 	}
 
-	if (tracker->tx_type == NETDEV_LAG_TX_TYPE_ACTIVEBACKUP &&
-	    !(ldev->mode == MLX5_LAG_MODE_ROCE))
-		mlx5_lag_drop_rule_setup(ldev, tracker);
+	if (tracker->tx_type == NETDEV_LAG_TX_TYPE_ACTIVEBACKUP) {
+		struct net_device *ndev = mlx5_lag_active_backup_get_netdev(dev0);
+
+		if(!(ldev->mode == MLX5_LAG_MODE_ROCE))
+			mlx5_lag_drop_rule_setup(ldev, tracker);
+		/** Only sriov and roce lag should have tracker->tx_type set so
+		 *  no need to check the mode
+		 */
+		blocking_notifier_call_chain(&dev0->priv.lag_nh,
+					     MLX5_DRIVER_EVENT_ACTIVE_BACKUP_LAG_CHANGE_LOWERSTATE,
+					     ndev);
+	}
 }
 
 static int mlx5_lag_set_port_sel_mode_roce(struct mlx5_lag *ldev,
@@ -613,6 +650,7 @@ static int mlx5_create_lag(struct mlx5_lag *ldev,
 			mlx5_core_err(dev0,
 				      "Failed to deactivate RoCE LAG; driver restart required\n");
 	}
+	BLOCKING_INIT_NOTIFIER_HEAD(&dev0->priv.lag_nh);
 
 	return err;
 }
@@ -1492,38 +1530,6 @@ void mlx5_lag_enable_change(struct mlx5_core_dev *dev)
 	mlx5_queue_bond_work(ldev, 0);
 }
 
-struct net_device *mlx5_lag_get_roce_netdev(struct mlx5_core_dev *dev)
-{
-	struct net_device *ndev = NULL;
-	struct mlx5_lag *ldev;
-	unsigned long flags;
-	int i;
-
-	spin_lock_irqsave(&lag_lock, flags);
-	ldev = mlx5_lag_dev(dev);
-
-	if (!(ldev && __mlx5_lag_is_roce(ldev)))
-		goto unlock;
-
-	if (ldev->tracker.tx_type == NETDEV_LAG_TX_TYPE_ACTIVEBACKUP) {
-		for (i = 0; i < ldev->ports; i++)
-			if (ldev->tracker.netdev_state[i].tx_enabled)
-				ndev = ldev->pf[i].netdev;
-		if (!ndev)
-			ndev = ldev->pf[ldev->ports - 1].netdev;
-	} else {
-		ndev = ldev->pf[MLX5_LAG_P1].netdev;
-	}
-	if (ndev)
-		dev_hold(ndev);
-
-unlock:
-	spin_unlock_irqrestore(&lag_lock, flags);
-
-	return ndev;
-}
-EXPORT_SYMBOL(mlx5_lag_get_roce_netdev);
-
 u8 mlx5_lag_get_slave_port(struct mlx5_core_dev *dev,
 			   struct net_device *slave)
 {
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index ba875a619b97..a38a17f8c12c 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -370,6 +370,7 @@ enum mlx5_driver_event {
 	MLX5_DRIVER_EVENT_SF_PEER_DEVLINK,
 	MLX5_DRIVER_EVENT_AFFILIATION_DONE,
 	MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
+	MLX5_DRIVER_EVENT_ACTIVE_BACKUP_LAG_CHANGE_LOWERSTATE,
 };
 
 enum {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index a96438ded15f..46a7a3d11048 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -643,6 +643,7 @@ struct mlx5_priv {
 	struct mlx5_sf_hw_table *sf_hw_table;
 	struct mlx5_sf_table *sf_table;
 #endif
+	struct blocking_notifier_head lag_nh;
 };
 
 enum mlx5_device_state {
@@ -1181,7 +1182,6 @@ bool mlx5_lag_mode_is_hash(struct mlx5_core_dev *dev);
 bool mlx5_lag_is_master(struct mlx5_core_dev *dev);
 bool mlx5_lag_is_shared_fdb(struct mlx5_core_dev *dev);
 bool mlx5_lag_is_mpesw(struct mlx5_core_dev *dev);
-struct net_device *mlx5_lag_get_roce_netdev(struct mlx5_core_dev *dev);
 u8 mlx5_lag_get_slave_port(struct mlx5_core_dev *dev,
 			   struct net_device *slave);
 int mlx5_lag_query_cong_counters(struct mlx5_core_dev *dev,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index a1dcf812d787..aa8ede439905 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4453,6 +4453,8 @@ struct net_device *ib_get_net_dev_by_params(struct ib_device *dev, u32 port,
 					    const struct sockaddr *addr);
 int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 			 unsigned int port);
+struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
+					u32 port);
 struct ib_wq *ib_create_wq(struct ib_pd *pd,
 			   struct ib_wq_init_attr *init_attr);
 int ib_destroy_wq_user(struct ib_wq *wq, struct ib_udata *udata);
-- 
2.17.2


