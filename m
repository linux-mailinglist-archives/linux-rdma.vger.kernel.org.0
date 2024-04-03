Return-Path: <linux-rdma+bounces-1771-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C72E8977BA
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 20:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 708BCB359D7
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 17:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF2715887A;
	Wed,  3 Apr 2024 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="klHb72Hc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E9158871;
	Wed,  3 Apr 2024 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166139; cv=fail; b=KKigEyzmatD3Gj2hnKtq+qj4NvAxomk1il96I4Gj+JHHD7Cciy1IfeDgwEsE4oLVr303RxbadI/AEJ0eyYSqNxTAeugH1nxsSSs6/hRmp6HJuhuAfNf4BG/VUbeW0uAzDvF455VPU73NGNO9UZFhlnLhU4q4kdRhchs4tgIBPSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166139; c=relaxed/simple;
	bh=/oOtw1HTnV+UOoVpYhjbhv34cLlcmaN9hw6qKObuDoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ho7mT4Dyey/qg9zMUaAaO0/s5KthXWES6d3a92ppNAykf9G7QXPJyiEfOe1KXk3hbuzIk37IJFJdkd+OhHNIR+1Oc9l7VhpZRhYdxD5YjlMmjCDCh+27j7OmfXxS2kTzjfgdjkUw/mxiDobHwpOFCEK7IMYpBoYL6zm+eZyxyes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=klHb72Hc; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxEW8o8LhDL40fP2zB3x56MJ2o3x8A80duc2oGtIJvLfrMvnRxR93eNzJO6gPuARFuaW59PToKj3aTrx0rzhiqQPE4wxywuDxQy4BP/MKVr17IHVf1u486QTvLxQwvS9Jy1yH2OQ6AnUVX+aQYJ2TWhJ0WiGDW3MsQe3JEYqbrDeaOh6alV3DDxQbI3lS7RrfjBcfM1mxANQB/5wFcud5MnRBWDKEaDRMl9R9b4uQQQ+LOzWoYN3aIZROyG2h4QydizhchPRx+f0Rvif6IAXvus5iCC263BfeJXpp1Vy3mGWjl+OcW4hFW14+w6HSB1QSH5aMM3EAH7JENHR/GXJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2idS9c/O/QMS05Oa89+f63nwmySO7uPXomb1XXC4Wbc=;
 b=MMmYgHsLMxufDpHrjYv4gtJMidinZmIqx/Vtlk/yDN/XCW2/y3aXc9+QWvWOn3VdoXokozqj11ZsvsnbLSn7SHPx0GojKn1ho1qhX/ziKr6/9bVoHcxjQUvoJXyt2K5XZ12oNi+fLN/FAqkEsAbKCjO+HsjFM6siCQ+uZpCqxf9HA+N4ymhxTKBKq9G4BB3aYFoovy7rSFpELsPZ73nkIrLfGiYu5S6qo92gT/X+8QGXAOIIDg0Jd3mHPIvyoKwVS+ajfHXz8Ru8n4ofeTWFZ/4aHAXFvlowZK0TSt7/O7gC77GODrRzahfwbkQ1rVfXfPyncNVPXuHca+V/jYfBQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2idS9c/O/QMS05Oa89+f63nwmySO7uPXomb1XXC4Wbc=;
 b=klHb72Hcp+dyos5vSyxwtXu0ILM6EmbkiKXrOhDd7UQLjjyNt58YD5yN++47fYMiJ+awWPrYRQKW/6LJ93LKl79CEdBmSACgK9Kg12AJvuqrrYHiUuzVmngXWKUhrPc7gpZ2BjlFi3TIPNHnUOSufJMvXR72vew4syfk5mzrvzDa/4maYwtu0fXRrlCzbwB4PAcPg4yEDRyBJf4hchUlsdzRWuLfhfJwSRCw8gdebC8MrgAJu4XHIp8Ekjdj4WWQ14eYVRKo1QDN5oacBSAKd3j1DpXML3F8S2Iy7LFnX4jlJMxC3I18yEGxtds7kdW8FSGfCS9ZxZYXWfl+qiNYpA==
Received: from BL1PR13CA0010.namprd13.prod.outlook.com (2603:10b6:208:256::15)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 17:42:14 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:256:cafe::42) by BL1PR13CA0010.outlook.office365.com
 (2603:10b6:208:256::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Wed, 3 Apr 2024 17:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 17:42:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Apr 2024
 10:41:51 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 3 Apr 2024 10:41:49 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>,
	<kalesh-anakkur.purayil@broadcom.com>
CC: <saeedm@nvidia.com>, <leon@kernel.org>, <jiri@resnulli.us>,
	<shayd@nvidia.com>, <danielj@nvidia.com>, <dchumak@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Parav Pandit
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [net-next v3 1/2] devlink: Support setting max_io_eqs
Date: Wed, 3 Apr 2024 20:41:32 +0300
Message-ID: <20240403174133.37587-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240403174133.37587-1-parav@nvidia.com>
References: <20240403174133.37587-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: e8dec4ea-2e41-4dc8-46c5-08dc540565e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GFvTfRWD6GySzft/cduX7xybyZmuc0gb7uslVSZBWnnNX+RKRPGKhICvsIPdugC2D8zVbSzYWREHC/PA1pGujnGn51hFyw5KvjBNHjk+yMP3vV9YWUlb8mf2a2ut4ivO64lntQqI7Y7aZgBWXxgCSQCu+9xUiI0gUCETKug5nzK3LF7wB5x9qp3FvkXUjKhgpZY8tUidgajghD9x4Q46JCIp35DcUuH1WJVVYHH9Zb4BWqo7JUwraNnZG6ItEb4I+JibnBQpt3Vc+NR4XPMcd0plronfZOUhDbqJZk4PnWiAckfXdW6NkACSXnslPWn1Q9fRk5ZY44UZQTu9ELf4PL7XIdy7IJlpAbvVwe4pro+L935JVjBsUWadJ54uxDOIhQpWQIsO+UyTvjU/0KtnZF7Vg+hul/M3nyN2NQ6d/w+L3byFe4w4wwqo/UFRN0V2q3djATKe242rL9kVcL9nWm2KvMR5hcMOOwHSkxbZBYfA/LyH1K3a89LHoaEHfQxrwNmKjXpUMk5151AaPmr68Shz55m2RDtPhNZWiYP0jwlPDX0oc8Ttb5TtANk0Gjjhh8KyLg+sThH7esBrmvHZJ3DRtnWlAqt83OsTyt+DfZtPqSKjVrLjsQQku3gWSHhpuZNow7DGPtNm5JQSxQ3SGx1mthzcDyUd1jxhPiDEKYA9paFRJ3ekiF2qNirhWId2HnBvcYWAzsI7Pd0Z0TZyOg1UengV11s7ZK/e+hgxgAdbhUHDaAV4zsDjx/wmmdxO
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 17:42:13.8830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dec4ea-2e41-4dc8-46c5-08dc540565e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412

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

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
- limited 80 chars per line
v1->v2:
- limited comment to 80 chars per line in header file
---
 .../networking/devlink/devlink-port.rst       | 25 +++++++++
 include/net/devlink.h                         | 14 +++++
 include/uapi/linux/devlink.h                  |  1 +
 net/devlink/port.c                            | 53 +++++++++++++++++++
 4 files changed, 93 insertions(+)

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
index 9ac394bdfbe4..bb1af599d101 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1602,6 +1602,14 @@ void devlink_free(struct devlink *devlink);
  *			      capability. Should be used by device drivers to
  *			      enable/disable ipsec_packet capability of a
  *			      function managed by the devlink port.
+ * @port_fn_max_io_eqs_get: Callback used to get port function's maximum number
+ *			    of event queues. Should be used by device drivers to
+ *			    report the maximum event queues of a function
+ *			    managed by the devlink port.
+ * @port_fn_max_io_eqs_set: Callback used to set port function's maximum number
+ *			    of event queues. Should be used by device drivers to
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
index 118d130d2afd..be9158b4453c 100644
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
@@ -726,6 +766,12 @@ static int devlink_port_function_validate(struct devlink_port *devlink_port,
 			}
 		}
 	}
+	if (tb[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS] &&
+	    !ops->port_fn_max_io_eqs_set) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[DEVLINK_PORT_FN_ATTR_MAX_IO_EQS],
+				    "Function does not support max_io_eqs setting");
+		return -EOPNOTSUPP;
+	}
 	return 0;
 }
 
@@ -761,6 +807,13 @@ static int devlink_port_function_set(struct devlink_port *port,
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


