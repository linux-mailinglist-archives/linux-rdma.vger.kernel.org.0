Return-Path: <linux-rdma+bounces-1696-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C06C893942
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 11:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BFE281E4E
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 09:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11BE10A35;
	Mon,  1 Apr 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ei7eHCoy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEC710A01;
	Mon,  1 Apr 2024 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962372; cv=fail; b=ZpYyp+92iTQQoTXLtv9yQPoJECBUL8KOo98E10U52yuFzGqXHq4dXWAPETWLa1kTtTsIUQMaCYMCL7KGjgKb9qhE1LFREXbWsWXlVBJb/Kj9neSKVHx/mceqqUKsU8ptQdGqJQzgRoB6hkTfsGdfxoLjvMGN1D5Oplqgb++WN8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962372; c=relaxed/simple;
	bh=I9z55Emo/q64NokWckDtU7k23h7qFH7NG61iMTR5+yA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSN6ywPAKwcK3u3FuRm/o+U99BE7X27I+RhS5covUgTjYfEq/TVy6KHvazFwtURx/STaRHXlhTASjPcWlLEx0jbqPbWpPpRlsH5th5wO56z9L1Cndx9bWFRVZ9fCyU4Kx+TIBkAMT7blIapQZxejBxPTgesiPIzA3ewX0CN78Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ei7eHCoy; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnn4vpqkZ0uq6IBC2FS/Ke+gtVwEy5B9bT2lpJmmTxwiSbes94eOToPKKgQ6M78Tr6ZwAY/JLPpecbVxtFHX9Oe7oFJbFFkmiFzOA2K14Vlm7huVE1CLcyJDriFMfiCqyJKr7Lpr1PTJCyRmcFZsCSYAS49GDKqtS6KZix1kBcQpk7ydCCEIJX5j1YAr9i1HOGKFzUYZg7EBohBpbNfTrRcazIWFfzY9Ulk1cgtxquEmTfciNbgMzGWlR7dHOo0YbbXylZqnfrIEmbpUqHOpT1X0+0W9Y0tB6wEWC/Y8dRZ6tXe3+6o5Qai4ragokvmnLLAM7xA3ISG7p9RYI6oR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZFmJqSQYWBiLWkgAk80fIx+SqRj33RPftt6HeN+YAA=;
 b=Js+owPxelp1gZMq3Heo3/aHKHz/x8xp1PvLAzMOxW41Rz9H8KeBffhhOFrQypcetmlCBmRGny1LfEK8YNeshVi4dz/3TxbI3jByeO7fb0WEBAT99+/9G5uqshbfK8tB71m0dzJZeqAPeVvg3LlrPvnZ4iLaFPXqJIsznOFahU7+/ZsnLRZPdzY516DG1EO6dKHXiUH+QqqDUwsLPHn8SBTKZIzCViqX32E0L6Sewtb0ZTUMGOTOO3kEWjtbiAdXZ+0b7LdU/np54ugImmPhYTPO6rCGKs9BMeCDDegbgVTzJ294AVsEM2Rraz0jDeOewA0ZYBw7o12OUN49ulzGO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZFmJqSQYWBiLWkgAk80fIx+SqRj33RPftt6HeN+YAA=;
 b=ei7eHCoyVTj9zlhluVIJmHrJwDtfWfP1JTo1L3X4tpzUt53cQPSOYVGNFxPI07u3bCgE4ijP5yxvzYQlSLXspqHykgtsJ8d4qojVwC7EaHcboxpp9d0lKWvsCVMmxoIuZaQiWojQ1P3AgeFZ8hDtJDDvLd6kTsa7zj8tYDAjBjU/OLqg7LcagPABXS92mxmLBU8GN1EkD0iJATwlIJ5gEKy77sEphRNs3K4ITC7tpLoLLODpdSJTBV/NOHv2vWIvaAJ5nm6A+nFQ+XWCwFxpMgjCRm+uKrzCyvDe2JH3YKASbJAOTZ9L1Kr9BlKuH/pbtcUsJr78j/IMk8SCRO4y/A==
Received: from CH0PR13CA0053.namprd13.prod.outlook.com (2603:10b6:610:b2::28)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 09:06:07 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::be) by CH0PR13CA0053.outlook.office365.com
 (2603:10b6:610:b2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.9 via Frontend
 Transport; Mon, 1 Apr 2024 09:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 09:06:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 1 Apr 2024
 02:05:51 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 1 Apr 2024 02:05:50 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>
CC: <saeedm@nvidia.com>, <leon@kernel.org>, <jiri@resnulli.us>,
	<shayd@nvidia.com>, <danielj@nvidia.com>, <dchumak@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Parav Pandit
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [net-next 1/2] devlink: Support setting max_io_eqs
Date: Mon, 1 Apr 2024 12:05:30 +0300
Message-ID: <20240401090531.574575-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240401090531.574575-1-parav@nvidia.com>
References: <20240401090531.574575-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 7038a3e1-584b-44e3-08da-08dc522af74b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QVNqYZngrkWuXvKOBkrmyMQB/NXlI18dFK+UnCImcZmthhuDTi3j5b+UK85RuNlHK7cEuEopGf2PWBj2Xwsh6TnXQOn2X4+tgusbHWN+JgXb0iXeVYZGFmfSu6cwABfS/3aC/NHg0/c5XIKSCfsdhbO/M3H6rfzmrhPoOOSnelIpsOCeMDhRz4k22ZMGnsMLTzmJFQCV8dFj3JeBxvTq1lOguK1NtV3ePgUnUNtYDAghNhiDadJ85ODBD/q+yBgAeSdMrDynTStWDF8783y4jVjtUB338FvvNo0Wv1pxZjpwKAIZcT53KIwRXD+k5a5lzbKVpFQONEUr7jP4gakoD9fxV1k7q2j1n7hcD2E8VKTfvNG4sbLX5zruFwtT4CVQO5xWdevErEqqfOM/sPI0oPDeMsXGFBSnZusAuTIc1LMMB7LEHyJgqtcEM1xrmDvZ6i0K22D/qz4GJREvKLXx3coy8iUyM44E9s2X2Qm0930ZVemKTs2PHoQSqgeVif/UJOivzAodwRZWL/wvpOVxmKmB5KYWbPA093D4RzU7fzalChBTN+QoQEc1IoKZV8CDA//gQHtfKe4+iVjBUtO8OYMMgTJcj2qQ26xPRaE3sN6fX2BLiRbgYXbamnaxc6g8ClX826PE0p9polW3usYsOo/LlIIbw+jDTNBMfuxzoo+DZ44B29fTw37cAjOkqqYXoOmLjxrHQfF4SGylb1Gglc+GcE7ft2QA2/9VP5bRnPDs2etSLWkVX0dB/E2/8wOx
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(7416005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 09:06:06.8728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7038a3e1-584b-44e3-08da-08dc522af74b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

Many devices send event notifications for the IO queues,
such as tx and rx queues, through event queues.

Enable a privileged owner, such as a hypervisor PF, to set the number
of IO event queues for the VF and SF during the provisioning stage.

example:
Get maximum IO event queues of the VF device::

  $ devlink port show pci/0000:06:00.0/2
  pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
      function:
          hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 10

Set maximum IO event queues of the VF device::

  $ devlink port function set pci/0000:06:00.0/2 max_io_eqs 32

  $ devlink port show pci/0000:06:00.0/2
  pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
      function:
          hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 32

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 .../networking/devlink/devlink-port.rst       | 25 +++++++++
 include/net/devlink.h                         | 14 +++++
 include/uapi/linux/devlink.h                  |  1 +
 net/devlink/port.c                            | 52 +++++++++++++++++++
 4 files changed, 92 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 562f46b41274..451f57393f11 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -134,6 +134,9 @@ Users may also set the IPsec crypto capability of the function using
 Users may also set the IPsec packet capability of the function using
 `devlink port function set ipsec_packet` command.
 
+Users may also set the maximum IO event queues of the function
+using `devlink port function set max_io_eqs` command.
+
 Function attributes
 ===================
 
@@ -295,6 +298,28 @@ policy is processed in software by the kernel.
         function:
             hw_addr 00:00:00:00:00:00 ipsec_packet enabled
 
+Maximum IO events queues setup
+------------------------------
+When user sets maximum number of IO event queues for a SF or
+a VF, such function driver is limited to consume only enforced
+number of IO event queues.
+
+- Get maximum IO event queues of the VF device::
+
+    $ devlink port show pci/0000:06:00.0/2
+    pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
+        function:
+            hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 10
+
+- Set maximum IO event queues of the VF device::
+
+    $ devlink port function set pci/0000:06:00.0/2 max_io_eqs 32
+
+    $ devlink port show pci/0000:06:00.0/2
+    pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0 vfnum 1
+        function:
+            hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs 32
+
 Subfunction
 ============
 
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 9ac394bdfbe4..a270e71dee0e 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1602,6 +1602,14 @@ void devlink_free(struct devlink *devlink);
  *			      capability. Should be used by device drivers to
  *			      enable/disable ipsec_packet capability of a
  *			      function managed by the devlink port.
+ * @port_fn_max_io_eqs_get: Callback used to get port function's maximum number of
+ *			    event queues. Should be used by device drivers to
+ *			    report the maximum event queues of a function
+ *			    managed by the devlink port.
+ * @port_fn_max_io_eqs_set: Callback used to set port function's maximum number of
+ *			    event queues. Should be used by device drivers to
+ *			    configure maximum number of event queues
+ *			    of a function managed by the devlink port.
  *
  * Note: Driver should return -EOPNOTSUPP if it doesn't support
  * port function (@port_fn_*) handling for a particular port.
@@ -1651,6 +1659,12 @@ struct devlink_port_ops {
 	int (*port_fn_ipsec_packet_set)(struct devlink_port *devlink_port,
 					bool enable,
 					struct netlink_ext_ack *extack);
+	int (*port_fn_max_io_eqs_get)(struct devlink_port *devlink_port,
+				      u32 *max_eqs,
+				      struct netlink_ext_ack *extack);
+	int (*port_fn_max_io_eqs_set)(struct devlink_port *devlink_port,
+				      u32 max_eqs,
+				      struct netlink_ext_ack *extack);
 };
 
 void devlink_port_init(struct devlink *devlink,
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 2da0c7eb6710..9401aa343673 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -686,6 +686,7 @@ enum devlink_port_function_attr {
 	DEVLINK_PORT_FN_ATTR_OPSTATE,	/* u8 */
 	DEVLINK_PORT_FN_ATTR_CAPS,	/* bitfield32 */
 	DEVLINK_PORT_FN_ATTR_DEVLINK,	/* nested */
+	DEVLINK_PORT_FN_ATTR_MAX_IO_EQS,	/* u32 */
 
 	__DEVLINK_PORT_FUNCTION_ATTR_MAX,
 	DEVLINK_PORT_FUNCTION_ATTR_MAX = __DEVLINK_PORT_FUNCTION_ATTR_MAX - 1
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 118d130d2afd..307bfeedda54 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -16,6 +16,7 @@ static const struct nla_policy devlink_function_nl_policy[DEVLINK_PORT_FUNCTION_
 				 DEVLINK_PORT_FN_STATE_ACTIVE),
 	[DEVLINK_PORT_FN_ATTR_CAPS] =
 		NLA_POLICY_BITFIELD32(DEVLINK_PORT_FN_CAPS_VALID_MASK),
+	[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS] = { .type = NLA_U32 },
 };
 
 #define ASSERT_DEVLINK_PORT_REGISTERED(devlink_port)				\
@@ -182,6 +183,30 @@ static int devlink_port_fn_caps_fill(struct devlink_port *devlink_port,
 	return 0;
 }
 
+static int devlink_port_fn_max_io_eqs_fill(struct devlink_port *port,
+					   struct sk_buff *msg,
+					   struct netlink_ext_ack *extack,
+					   bool *msg_updated)
+{
+	u32 max_io_eqs;
+	int err;
+
+	if (!port->ops->port_fn_max_io_eqs_get)
+		return 0;
+
+	err = port->ops->port_fn_max_io_eqs_get(port, &max_io_eqs, extack);
+	if (err) {
+		if (err == -EOPNOTSUPP)
+			return 0;
+		return err;
+	}
+	err = nla_put_u32(msg, DEVLINK_PORT_FN_ATTR_MAX_IO_EQS, max_io_eqs);
+	if (err)
+		return err;
+	*msg_updated = true;
+	return 0;
+}
+
 int devlink_nl_port_handle_fill(struct sk_buff *msg, struct devlink_port *devlink_port)
 {
 	if (devlink_nl_put_handle(msg, devlink_port->devlink))
@@ -409,6 +434,18 @@ static int devlink_port_fn_caps_set(struct devlink_port *devlink_port,
 	return 0;
 }
 
+static int
+devlink_port_fn_max_io_eqs_set(struct devlink_port *devlink_port,
+			       const struct nlattr *attr,
+			       struct netlink_ext_ack *extack)
+{
+	u32 max_io_eqs;
+
+	max_io_eqs = nla_get_u32(attr);
+	return devlink_port->ops->port_fn_max_io_eqs_set(devlink_port,
+							 max_io_eqs, extack);
+}
+
 static int
 devlink_nl_port_function_attrs_put(struct sk_buff *msg, struct devlink_port *port,
 				   struct netlink_ext_ack *extack)
@@ -428,6 +465,9 @@ devlink_nl_port_function_attrs_put(struct sk_buff *msg, struct devlink_port *por
 	if (err)
 		goto out;
 	err = devlink_port_fn_state_fill(port, msg, extack, &msg_updated);
+	if (err)
+		goto out;
+	err = devlink_port_fn_max_io_eqs_fill(port, msg, extack, &msg_updated);
 	if (err)
 		goto out;
 	err = devlink_rel_devlink_handle_put(msg, port->devlink,
@@ -726,6 +766,11 @@ static int devlink_port_function_validate(struct devlink_port *devlink_port,
 			}
 		}
 	}
+	if (tb[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS] && !ops->port_fn_max_io_eqs_set) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS],
+				    "Function does not support max_io_eqs setting");
+		return -EOPNOTSUPP;
+	}
 	return 0;
 }
 
@@ -761,6 +806,13 @@ static int devlink_port_function_set(struct devlink_port *port,
 			return err;
 	}
 
+	attr = tb[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS];
+	if (attr) {
+		err = devlink_port_fn_max_io_eqs_set(port, attr, extack);
+		if (err)
+			return err;
+	}
+
 	/* Keep this as the last function attribute set, so that when
 	 * multiple port function attributes are set along with state,
 	 * Those can be applied first before activating the state.
-- 
2.26.2


