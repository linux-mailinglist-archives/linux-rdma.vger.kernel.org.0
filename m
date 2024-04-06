Return-Path: <linux-rdma+bounces-1806-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D547789A815
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Apr 2024 03:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EFC8B215CF
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Apr 2024 01:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAAC5695;
	Sat,  6 Apr 2024 01:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q8q0pwHq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE4FBEE;
	Sat,  6 Apr 2024 01:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712365587; cv=fail; b=Ly5Ee8S1yJIGW8pzibKaa3RSlhT/pX7Yonb//yatn+MtpwndE+7c/gmXpzjyFW8YWQaEPxZQzWVYZ27TuP8N7nO82Eidl7ctmUZStx/J0sXeJCPXdQGHk8lkaNQqDsI425RSDtyqHOpnCN5s9fjy2hLIUqiPW5VLEtf3FnIfdkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712365587; c=relaxed/simple;
	bh=j/atRVOpT7yb9dVFOdQSVTSJM7kTnB8NzTdCU/ukz1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVqvMgxXoBQpMPToz4y1w3kHnPKqlPtmnEO+gUjdBwZCi9RmFJ8Y5VV/RG+3STrAwZ5A358m5OD6sMz61v4QTM4DMih2s43gZuANY9heSy45trqqY2XpAnrFMiEtVZCPnDNIG9dI3KVfqULC374k7rUbSfNXHBHPOvVIL7Ijsn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q8q0pwHq; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6Jc6RGZPRjc2WgAajiwO27NMEvfY7O9ourOVR9stWqHDL3E0hj9P3gdkGdgwqu+Z944qyIZLDMulme1ruJklgDkeg7T4TMsX78/DIV6o3y7H9floigxlMbYads/96FUr+Ln5JDbHx/UqPihiuHZE/yYM7QJiALQi2fZVP/ccvboutp2wd1uzYm6DmTgP589WHbvBkd+98h9TJcVn93gUukg8TmZWojzHD2VP8H2BktOPlMLhUsu5SLmdYoIDjndVBmyr7cPrKgFB3DIrlGs7XR14KvGBoEB5a1oxr7lJbGbR4y3PSEjrAsYUF31hPcjOiz7fLW47yL+lPCuI5QELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzyOOIwGJ7NmGhtfxUxRwkVdXEqFsdpzn0zlguAMOQE=;
 b=Aq6EdkU6DqYyqWZVNtkrhbPxwa2uL6LuJQVHfJEzKz5SKYx0yqSXJ6j3Z4UMJjI8jX1n1tgau80aeoJG0P7GHUleRAJ8k6SrLpstoRHTQDZEayqIFbLxStU7+RyobJ369rdISJFew5BxMZck7SHB3KGJ+uLKXy+NJSzRFcobmXRgY3EznGHfyl6/KGpyZj63Hj/zW87OUO8WDtOQ9rKdZ0H67yV4RhoPUS5Gt2t+2mIp2CgIE1XQy0UauLG7cdRYyJjltDszrjgeD+ucC43id3z7KU7mDMqPq/3G9AC+VsRR1LxgyrokxT3GNqVuvmZaAOxJGP2Jup/QcTp0bIdJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzyOOIwGJ7NmGhtfxUxRwkVdXEqFsdpzn0zlguAMOQE=;
 b=Q8q0pwHqkNuIUOR3eX81S4u1sts5SAs/RmluCFAqsGqScJTgPmKNNK+B0EV91RwINV7QUO6Eu22pfFHxA87BiiYo81vjW0c6RWzqPiR8h7oFfiLXE1E5rvxHlrpfWpZp8/imaIkWaDvG7Cv7FK1po56AYUeBDAFGSlyeLStg7EMYM+tEVtbCu0VcP7TSAzsEHRelsAczUgtB1Euos6VA8f/nCqD4zSDqE17ltp+EJ6BCiZjlUXaFRJe0EMgoQSZNa7UTvkuWqnhfzxfAV8w5fJPvHVTTSgRA6TrV8WRXvaEYXGa67yE+PgQqCCY+1Ty1Hv8/zQIWfH2Nut5NZPe9vA==
Received: from CH0PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:33::35)
 by SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 01:06:21 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::c8) by CH0PR08CA0030.outlook.office365.com
 (2603:10b6:610:33::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Sat, 6 Apr 2024 01:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 6 Apr 2024 01:06:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 5 Apr 2024
 18:06:00 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 5 Apr 2024 18:05:58 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <dw@davidwei.uk>,
	<kalesh-anakkur.purayil@broadcom.com>
CC: <saeedm@nvidia.com>, <leon@kernel.org>, <jiri@resnulli.us>,
	<shayd@nvidia.com>, <danielj@nvidia.com>, <dchumak@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Parav Pandit
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [net-next v4 1/2] devlink: Support setting max_io_eqs
Date: Sat, 6 Apr 2024 04:05:37 +0300
Message-ID: <20240406010538.220167-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240406010538.220167-1-parav@nvidia.com>
References: <20240406010538.220167-1-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5d0df7-3290-4749-937e-08dc55d5c59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NbrFpLV8o6ZhNDJGjf6GqXYlyCfa8OveTc15A3CkXRA4TROYkTKfC/GQ2bQUh37V4Ld2DZYudQchDiJKqs2YMzdgChmpthB0cAV9VXjRK52ff+/YxDhbwwhUlCNSS3mGY7gVmJfkt2esG++73Tatx71H8GVz1kT38OOxN67gMn6aClwuTqk7fR7pP7XHm3BVbj+eWdrw52BkoEyXIBh6dzRfl3p/OCUf/lZw9Ki4zXTVNVQYvwRg1n4/6BHh/AOTVfAh6uR8JQy1hltaxpIvGLvRLkO9pzSvNgm0HpZS3k3JOLWBOtAQlDHFXYlCGbrqDXqLiRxboV+ned/R62cwB0PKbnhwTtZ1cWlHFPz/l5yYslqfDH3B7dBSTTly0Cp0YI9zaS6BUDac5tuNwQOKCsXfDVMEbf9Xzvz6DzYkGQ7GAq1Q9ixaw559t9f6agUo2iI+t+qn9k4sloHTwi/ORTxIizQkIxpJPdAv89eEASBJuDQjCainjFsvkPBztgEsQVIe35Dib7m3eEj9F/qkbQl4hDVF13mTZWwv1y6U8Np7qbJFb92aByOc1oqQzAUKpx7eQ4fwB41eMUx7fAqxmvRQOPLd6NCEUc0jpqR1E7tG8WCN5VIxewYPDRH/Hj89fiW0ZAsvSPZFxOZBjqSmsj1V+9lRNz+gm7a+VEON0tE3WvKC/UDzxXcIGQG2tdLS+tSvbyYLynJoSAA8rCTCYU37tSKLC0N34Fp3/msKklGddRGOM7PD7+UJ5CNS9O/Q
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 01:06:21.0105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5d0df7-3290-4749-937e-08dc55d5c59e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725

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
v3->v4:
- addressed comment from Jakub to improve devlink documentation
v2->v3:
- limited 80 chars per line
v1->v2:
- limited comment to 80 chars per line in header file
---
 .../networking/devlink/devlink-port.rst       | 33 ++++++++++++
 include/net/devlink.h                         | 14 +++++
 include/uapi/linux/devlink.h                  |  1 +
 net/devlink/port.c                            | 53 +++++++++++++++++++
 4 files changed, 101 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 562f46b41274..9d22d41a7cd1 100644
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
 
@@ -295,6 +298,36 @@ policy is processed in software by the kernel.
         function:
             hw_addr 00:00:00:00:00:00 ipsec_packet enabled
 
+Maximum IO events queues setup
+------------------------------
+When user sets maximum number of IO event queues for a SF or
+a VF, such function driver is limited to consume only enforced
+number of IO event queues.
+
+IO event queues deliver events related to IO queues, including network
+device transmit and receive queues (txq and rxq) and RDMA Queue Pairs (QPs).
+For example, the number of netdevice channels and RDMA device completion
+vectors are derived from the function's IO event queues. Usually, the number
+of interrupt vectors consumed by the driver is limited by the number of IO
+event queues per device, as each of the IO event queues is connected to an
+interrupt vector.
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


