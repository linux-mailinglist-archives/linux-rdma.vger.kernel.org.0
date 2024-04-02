Return-Path: <linux-rdma+bounces-1732-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506618951CA
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 13:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 581DFB23E70
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 11:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F3563417;
	Tue,  2 Apr 2024 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="neb06cUB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2F14CB4A;
	Tue,  2 Apr 2024 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057183; cv=fail; b=ITp1EF56vmlgaSYuQNAcakcc9RmOiYuRSc7yn2E1AvrRo/EFs0ltt2smvlW02k6rGEtwH1kRDS33sVhOAQKkfsJCFsqwhpFvSDWI+4WJh7wO6iSkWz28G16Jf/eSrbHmS82l42DSkXfuG/M1n6RSOOqoSvHNgtcGwcWOuEAOcNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057183; c=relaxed/simple;
	bh=MpokWOljzVHpeyGImRa2p6hUhIrw6JtieaBS4zSoHes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALowlaibCLmdiPSC8wxV1fChG7ELwAS8ZrqnHn4S3kdPWvp93Wl/mvzw6o9+AWQx2ch7H8O+op4QRyOGIFSvg44hLMmmkZLiFY2906GFxoTwgJIhmgzzcIAaz6aLXqwMcuVTrtZjZc45dgnqkEW45x2nhJrSFrdUVPy79Rw4qMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=neb06cUB; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mObalgLhmjAA81lZd0ELmqQCCykzHotOAiFE+dKFq26II6jjkVfdFpTpTZ2Ul5hKlUnBYAH+CU8vKpJrcnP4psS6n7KG0Mxrd6LnOU9ZDIxo5mpr5X8jWqtI3RiKS4OUM/hfYVxhfK1atmtro+dqngqf8Ha33s6q9s/WuOwuqYLcW0pn7KvykVS2Lw1j4mXHT34t7HHMnhNWSoUGWSbnWTlIyUFNlEQOC9E/a4AwLCRDee+NB3DPOI+2u4OPjL+Rk4+xYHSxpUgbcj+l+G76BPzw1sJU5XtZwkSo6qEANMjexkRaBnY9QyTS+B+qtvULQicQ5RSbqJUzTtwVXcUrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNUyV/MGjUBQvkJQCgosiKq1fBm4kagmzRs6s6mUwNk=;
 b=IoiRTLyz+LsQTrZrIo4ur89weLhc8IO4ogCOJ9Z9ZBy8CpDucFROKFaW1/MxZ2Tm3ok4cS5OeCLFqUqj+XUyNTu2bxxtRsrF0g+4gMAoEsVWIsFNHfWnStWDhHnqdDIDikYJXOEU/WHtjMs3UNgNa0Zrmf/46YLPl6Mp9Ak3zUJymICM6ZCetw92imKEFaYREZod+aTsUH3/I5Xd10c/Jk7qqQ01HbOaGmLxtuZiGrySw3ycOBOjdS1BloR2VpWEoOBAkwVgudzXWNHbOorBe1digkZMtjkyT85psCa8uSfaolvMdd6UVmJcWNPEwsKN3B9uvq+DL9dVkrMdRItUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNUyV/MGjUBQvkJQCgosiKq1fBm4kagmzRs6s6mUwNk=;
 b=neb06cUBlfDWwR03A0y9i2lZV0O9PlEDRTSRamutoKdLMB/AVBrLulUvc9B2c9vkfjVWdHVqKh6yItyuHaSxrpLI2R9atEcDHiMnjWhuKyPLiKyUpBZUcQTcKBjc3wH91j4omo3D4YsEgQ8du3e+pISWAchC/NuN7B9LcXFxWk6dlUHD4ov+pIMikOzFAH5+M6nAz8ZmD7TwoYyDw96Zzpi4mUAYTfd/mHlkTqMEp/SM52gXUZ6Zt+Xloe4y9ZtSuOnMzve3IJGgpz7DyVf7IjDUYVLPMzFGUwFq9uszZufgzDqFFg0CUqlqbPvyDAjq5iOliFACCd6QTz4XPkprCQ==
Received: from SJ0PR03CA0186.namprd03.prod.outlook.com (2603:10b6:a03:2ef::11)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:26:18 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::78) by SJ0PR03CA0186.outlook.office365.com
 (2603:10b6:a03:2ef::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34 via Frontend
 Transport; Tue, 2 Apr 2024 11:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 11:26:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 04:26:05 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 2 Apr 2024 04:26:03 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>,
	<kalesh-anakkur.purayil@broadcom.com>
CC: <saeedm@nvidia.com>, <leon@kernel.org>, <jiri@resnulli.us>,
	<shayd@nvidia.com>, <danielj@nvidia.com>, <dchumak@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Parav Pandit
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [net-next v2 1/2] devlink: Support setting max_io_eqs
Date: Tue, 2 Apr 2024 14:25:48 +0300
Message-ID: <20240402112549.598596-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240402112549.598596-1-parav@nvidia.com>
References: <20240402112549.598596-1-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ab9dd4-3f8e-4c91-766b-08dc5307b706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y1gHoizDepgQdLgMHBGLSpdV2VtOUexUSiVJYOXOMXaH2pmTDKSiPH/LA+nJeAvYOSlCZZoKSE0sOVeuJF42WR4oa35xwWHUN6VgjNvp5f4qYtLIunbMPt++oNagM0rDv0JqiAk1unHIaot1VMHANGIslSyVR4AN4gjJ1fe5EwRYQcOkv9E2Wp2a/7kr1mqWpnPwxHlKM1A4EbuB0aniNTRUEggG3L6xFqx6NoZXzf6firNX3azvJGDX4vT6aYxgKBWwZ1SV5qttEITaXBSIpPQM3H955SuVQfs/q/RrrEwwzEoxhLJCPx0FMI5V0op/8HIbpselK7NWriXOx2t6RInDYlbAoFkuh3jRxGsvjra1LnLlo/CBV+7zvZ1113dn8u/7IByQCnBi7UmQ9bL29RXypwJK1+gmJQvRbbJZZpioVokssyaTtQWns8m4G/a4DjXAZplVOsRp7vW3ysnbJ9vMbEHQXV825hxIw9F5pQYQ1FTwLdzD/HX/dYNjyM+S6h1S+OQIEdleTIwkI7KpZU6Y3alGT9N6H+U3friwojV0YCTzWZFuFcRS4qjNbs+TZvIZfM65HzagKV1DAVpVL75oQnKl/IFS0LgoIpTqG53skAEHGQdKfMVx+/1y/vdqJt5WNdegKuZ81rgErmMOTr4A7uRCohdbzdMSH6BDrOGa1HqTsgCK5mGh0CcWehH9azvI5tZcI+Gw52MSVMH4B9Xq1u4vl3Qmw9kXJOMTquWyc2bs9FBB2CehEiR6tarS
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:26:17.8892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ab9dd4-3f8e-4c91-766b-08dc5307b706
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823

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
v1->v2:
- limited comment to 80 chars per line in header file
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


