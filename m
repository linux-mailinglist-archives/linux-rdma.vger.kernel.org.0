Return-Path: <linux-rdma+bounces-20315-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKnlG8rUAGp8NAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20315-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 20:56:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9610505D3A
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 20:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD141301A7E6
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 18:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE46325495;
	Sun, 10 May 2026 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IbquGA8b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5EE318ED6;
	Sun, 10 May 2026 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778439301; cv=fail; b=sFgmXyyxuimKldMNejbw+rPejjH8IHanelGQxtar//MXobTDfL9Gw9fj7dbineoT1QjxjkwhmEfPBSynkkf+zoktk+eEL7gWYGlnX6ockh89xoYdSY5q12xTgmw3z/cGUXN8qEQk5d+0RBOjSwBs9EMj+BqxKAO7uu808Hm2xGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778439301; c=relaxed/simple;
	bh=emL+4Z5NAZllm8onSWa3NgnIwkHaVappo2Hb4QSVwnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+vTJBqo8O/My1uaxEcM7rIUwhLfVR1/dsk+ej43yYGiRhhb5MUyMzL8Vh0t+a1DYIKAGVRt6fUmB2XOgmiF76Z2dhD5HKY2n230gyjFdDgTNk8wBRgINwiefzmUpT+fosx4BT6DLP7BbVttUS/5a4TlOhc1vqvo+1zkNblblbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IbquGA8b; arc=fail smtp.client-ip=40.93.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0Sgl497U5dVlgNSBnoGNF/2pSoycJz+ztT6/7W6RdNV7CvFo6t6uzmjiHnRMuHcMn8t1EjvmnkdLtCdwzYEEVcQ496H6pkxBS3mHqmthzBOa5rA4W5OFxXrLUdNhTUhc+CLMBq72Pun6Csfl22TYgOKbpyci/tpv+vE6H2PaeTq3jdqL8KPqKm7NEP5ouuNmwlaSXkQ8VlL5ZAR7mF/WW+xu9+NtBaQvJpckbvPDUKlo9xj0SeeqLTIf8ZS6vgmrsYzVd4zPafooBffIco6dbVkKYgNfAb9lDuzN2BilbURv+kzFgrZL6PMQeY8Al/FGiEMWwsWKnSsyH64ifXXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfVvXvJEynOWxd6rL8g6ukJLtF5JycDQCGOIOK0iToY=;
 b=zA6OTdBJ4tAgxDZ2HI1WQVyQZAwZgqC+5uszDYv+ZhPtcSihsJoALJNOLakYmJnccuySmHQyyTwq5bfhaZ1jWPsahdvlc3/6/x8etvWRh60B+h9f2gSYlT3rH+DM+GBK3uMI4MK/pnLKbg9egP92SQoVyMfcQ61jYNjeq8/iduEGPeUHFhRqmbyAMvWWMreKP/w/HT1zNCj15BIayXsLA5iXp8G56nkgfTZ2CTQSNVh9reW4w/2o7bkJX3jU+L/QBmNCrACFgrTW0zwDiZii3aesUBaFHD836Vy8bCeY3gJnMNm7Y2UG3+xGeAPOp2NXuDZpKmkZcz88cxnfqX57kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfVvXvJEynOWxd6rL8g6ukJLtF5JycDQCGOIOK0iToY=;
 b=IbquGA8b4Ss87w2ZW1DCUGat4qENaAUGB4WWbVS+n222eCqY/un+To27YJdB4kZ8Xje9mgnTp/fV6SHtWXWUrihwOOcEmE8+7jrZ0uFKqGjlalxeydy3xg/1SbamriJE/O7PkEL5eL32rpQQmXKQi8O50SqKhuB+mpG7vgZprjcpU75OJc754nCU/Up9Ta1jZOkER1UDy3WWkPuRdKnDHyYSNH+7Ixih0+Zy/+J7ANmc6KFnEwFKbZybqLoJubcKcTG4Ks3eeVQgbBVGyT05anekSHlIOXdTbxjc/VUs1hWeFWLuTCSY9zNEKaWQZix5/o8N5JLLJn240LLAuZ00Eg==
Received: from BL0PR1501CA0009.namprd15.prod.outlook.com
 (2603:10b6:207:17::22) by IA0PPF0C93AC97B.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sun, 10 May
 2026 18:54:53 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::34) by BL0PR1501CA0009.outlook.office365.com
 (2603:10b6:207:17::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Sun,
 10 May 2026 18:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 18:54:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 10 May
 2026 11:54:43 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 10 May
 2026 11:54:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 10
 May 2026 11:54:35 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, "Borislav
 Petkov (AMD)" <bp@alien8.de>, Randy Dunlap <rdunlap@infradead.org>, "Petr
 Mladek" <pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, "Marco
 Elver" <elver@google.com>, Li RongQing <lirongqing@baidu.com>, Eric Biggers
	<ebiggers@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [RFC V2 net-next 1/2] devlink: Add eswitch mode boot defaults
Date: Sun, 10 May 2026 21:54:23 +0300
Message-ID: <20260510185424.2041415-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510185424.2041415-1-mbloch@nvidia.com>
References: <20260510185424.2041415-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e809a1-5d23-470d-e8b7-08deaec59f2f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|56012099003|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IcnjadyzRYcVXtfsiT6yP4UMrOGvyLJz/h9s/5YSAohEMQFuspG7ACyPsE1Jd0bXiS1HQVwPSB0T3b7lzYz97MgHBWNftMwvdXjz/Kyyak/+1coUL4uCYcMGhRn11eJXpQM7cen21cQKwRuGRgMb+EcVV50kPz/Dx2O+1wZVbJjeTh+uRKfg8bYfkz+uwJbKEAY49d/fTZmmvgGm/XmQ/OdV8iila75eD2a0+CQNHdzVL07ZtJ3hgWRy8tWvgxTMF0fSGIJ+kzrTWIw/tQWAz+/22+IutXX0BoW9HhcxCIzd+bO3J3Y5lTGjN/icHNxb7UTRXq++ag/jWslbdlHx9EnmHiyq8u0Zf45V9cwjxyK0htUfJZgHXB1xl+6bLdkD0OHl3Uhw/kOHGqgUj2b7ym2j+OkdXL7QenifYCXUpg2c9zFitSETL/N12fIcxq41uChcOSNJHMJ0COH2oN0ecGrDsZgTyiuQ+EsXrwrWqMrw6kPUxTzD8Uv6ctPPhFgviLFqJwl04h7tEIY9x0rIY6JgHJmRNqt/+mmzcxJ3FQIKtAmQe8/0GISq+GuRHl88pOK8Ga6LYii4eEN5UcQpALhx/GR64cOEIKi7kf+T39kWtrFiekEfx9wPDwhQa6Ay5Gx897uMjMkfbeedljh8FTAHtin08DQAYR3w7BXfngI3ise3uXGPMSqzN+x8udFrVY4p4oO+WBmJZQjUC56GYFdhrjcErjuJbQOkJD/Qa0k=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(56012099003)(3023799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7TXsxcCUsXndJVLzoUdgoO82rSFezn1BqwoyOlvzoggAdlKcIWBVaCDYVk2B6YPEw1H3tOh4t91pCY56eDX8GgHSjB/7xRE5MUuwCbulDZLNRusBKvfAsdOkocV2lxPE0Lew27yT9SwtX6nvfhfKYtfxWivrVIR2O62SMvSvZoIEKttQIOi2OC3HQHoAsiATVEhJKUrqc/md1PrNtw09W3845BuTXPLigCLpckL9THTvut21CQvgifNqeszu5dl8joPrqjCU1JpNCHsQAzQSpyVuBp6bqnngC2DA7BmlGKnchBl4CJKfHNE5fiNyw4raiYS76YgmhErVXso6DINS7sM6p738/eh/6QILUURDDxiwQl61Rm2TdqAcaepnyG9xNCZ3HnqhnPjgzJgDvZ/bb7/XXhrcXhqlYyTnmnY6cgycft+jOSuVXG7htSTRJ++d
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 18:54:53.3909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e809a1-5d23-470d-e8b7-08deaec59f2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B
X-Rspamd-Queue-Id: D9610505D3A
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20315-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mellanox.com:email,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Add devlink= kernel command line support for configuring devlink
eswitch mode during device initialization.

The supported syntax selects either all devlink handles or one explicit
comma-separated handle list:

  devlink=[*]:esw:mode:<mode>
  devlink=[<handle>[,<handle>...]]:esw:mode:<mode>

where <mode> is one of legacy, switchdev or switchdev_inactive. All
selected handles receive the same mode. Comma-separated default groups are
not supported.

The default is applied through the existing eswitch_mode_set() devlink
operation, matching the userspace devlink eswitch set command.

Document the devlink= syntax and duplicate handle handling.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         |  24 ++
 .../networking/devlink/devlink-defaults.rst   |  93 ++++++
 Documentation/networking/devlink/index.rst    |   1 +
 include/net/devlink.h                         |   1 +
 net/devlink/core.c                            | 269 ++++++++++++++++++
 5 files changed, 388 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-defaults.rst

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7834ee927310..46435bdfe039 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1278,6 +1278,30 @@ Kernel parameters
 	dell_smm_hwmon.fan_max=
 			[HW] Maximum configurable fan speed.
 
+	devlink=	[NET]
+			Format:
+			[<selector>]:esw:mode:<mode>
+
+			<selector>:
+			* | <handle>[,<handle>...]
+
+			<handle>:
+			<bus-name>/<dev-name>
+
+			Configure default devlink settings for matching
+			devlink instances during device initialization.
+
+			Currently supported settings:
+			esw:mode:{ legacy | switchdev | switchdev_inactive }
+
+			Examples:
+			devlink=[*]:esw:mode:switchdev
+			devlink=[pci/0000:08:00.0]:esw:mode:switchdev
+			devlink=[pci/0000:08:00.0,pci/0000:09:00.1]:esw:mode:legacy
+
+			See Documentation/networking/devlink/devlink-defaults.rst
+			for the full syntax.
+
 	dfltcc=		[HW,S390]
 			Format: { on | off | def_only | inf_only | always }
 			on:       s390 zlib hardware support for compression on
diff --git a/Documentation/networking/devlink/devlink-defaults.rst b/Documentation/networking/devlink/devlink-defaults.rst
new file mode 100644
index 000000000000..4db3025c540f
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-defaults.rst
@@ -0,0 +1,93 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+Devlink Defaults
+================
+
+Devlink defaults allow selected devlink settings to be provided on the
+kernel command line and applied to matching devlink instances during device
+initialization.
+
+The devlink device is selected by its devlink handle. For PCI devices this is
+the same handle shown by ``devlink dev show``, for example
+``pci/0000:08:00.0``.
+
+Kernel command line syntax
+==========================
+
+Defaults are specified with the ``devlink=`` kernel command line parameter.
+
+The general syntax is::
+
+  devlink=[<selector>]:esw:mode:<mode>
+
+``<selector>`` is either ``*`` or one or more devlink handles::
+
+  * | <bus-name>/<dev-name>[,<bus-name>/<dev-name>...]
+
+``*`` applies the default to every devlink instance. All handles in the same
+``[]`` list receive the same eswitch mode setting.
+
+``<mode>`` is one of ``legacy``, ``switchdev`` or ``switchdev_inactive``.
+
+Syntax rules
+------------
+
+The following syntax rules apply:
+
+* Specify the default in one ``devlink=`` parameter. Repeated ``devlink=``
+  parameters are not accumulated.
+* The ``devlink=`` value is limited by the kernel command line size.
+* Whitespace is not allowed within the parameter value.
+* ``<selector>`` must be either ``*`` or a handle list. ``*`` cannot be
+  combined with explicit handles.
+* ``<bus-name>`` and ``<dev-name>`` must not be empty.
+* ``<bus-name>`` must not contain ``:``.
+* ``<dev-name>`` may contain ``:``. This allows PCI names such as
+  ``0000:08:00.0``.
+* Handles must not contain whitespace, ``[``, ``]``, ``*`` or more than one
+  ``/``.
+* A comma inside ``[]`` separates handles.
+* Comma-separated default groups are not supported.
+* Duplicate handles are rejected and the devlink default is ignored.
+
+Supported defaults
+==================
+
+The supported command is ``esw``:
+
+.. list-table::
+   :widths: 10 25 35
+   :header-rows: 1
+
+   * - Command
+     - Options
+     - Values
+   * - ``esw``
+     - ``mode:<mode>``
+     - ``legacy``, ``switchdev``, ``switchdev_inactive``
+
+The ``esw:mode`` default corresponds to the userspace command::
+
+  devlink dev eswitch set <handle> mode <value>
+
+
+Examples
+========
+
+Set all devlink instances to switchdev mode::
+
+  devlink=[*]:esw:mode:switchdev
+
+Set one PCI devlink instance to switchdev mode::
+
+  devlink=[pci/0000:08:00.0]:esw:mode:switchdev
+
+Set two PCI devlink instances to legacy mode::
+
+  devlink=[pci/0000:08:00.0,pci/0000:09:00.1]:esw:mode:legacy
+
+The following is invalid because comma-separated default groups are not
+supported::
+
+  devlink=[pci/0000:08:00.0]:esw:mode:switchdev,[pci/0000:09:00.0]:esw:mode:switchdev_inactive
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index f7ba7dcf477d..0d27a7008b14 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -56,6 +56,7 @@ general.
    :maxdepth: 1
 
    devlink-dpipe
+   devlink-defaults
    devlink-eswitch-attr
    devlink-flash
    devlink-health
diff --git a/include/net/devlink.h b/include/net/devlink.h
index bcd31de1f890..058654d6800f 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1622,6 +1622,7 @@ int devl_trylock(struct devlink *devlink);
 void devl_unlock(struct devlink *devlink);
 void devl_assert_locked(struct devlink *devlink);
 bool devl_lock_is_held(struct devlink *devlink);
+int devl_apply_defaults(struct devlink *devlink);
 DEFINE_GUARD(devl, struct devlink *, devl_lock(_T), devl_unlock(_T));
 
 struct ib_device;
diff --git a/net/devlink/core.c b/net/devlink/core.c
index eeb6a71f5f56..2cfd50f9393b 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -4,6 +4,10 @@
  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
  */
 
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 #include <net/genetlink.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/devlink.h>
@@ -16,6 +20,247 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
 
 DEFINE_XARRAY_FLAGS(devlinks, XA_FLAGS_ALLOC);
 
+static char *devlink_default;
+static bool devlink_default_match_all;
+static enum devlink_eswitch_mode devlink_default_eswitch_mode;
+static LIST_HEAD(devlink_default_nodes);
+
+struct devlink_default_node {
+	struct list_head list;
+	char *bus_name;
+	char *dev_name;
+};
+
+static int __init
+devlink_default_esw_mode_to_value(const char *str,
+				  enum devlink_eswitch_mode *mode)
+{
+	if (!strcmp(str, "legacy")) {
+		*mode = DEVLINK_ESWITCH_MODE_LEGACY;
+		return 0;
+	}
+	if (!strcmp(str, "switchdev")) {
+		*mode = DEVLINK_ESWITCH_MODE_SWITCHDEV;
+		return 0;
+	}
+	if (!strcmp(str, "switchdev_inactive")) {
+		*mode = DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int __init
+devlink_default_cmd_parse(char *str)
+{
+	char *cmd;
+	char *attr;
+	char *mode;
+
+	cmd = strsep(&str, ":");
+	attr = strsep(&str, ":");
+	mode = strsep(&str, ":");
+	if (!cmd || strcmp(cmd, "esw") || !attr || strcmp(attr, "mode") ||
+	    !mode || !*mode || str)
+		return -EINVAL;
+
+	return devlink_default_esw_mode_to_value(mode,
+						 &devlink_default_eswitch_mode);
+}
+
+static int devlink_default_eswitch_apply(struct devlink *devlink)
+{
+	const struct devlink_ops *ops = devlink->ops;
+
+	if (!ops->eswitch_mode_set)
+		return -EOPNOTSUPP;
+
+	return ops->eswitch_mode_set(devlink, devlink_default_eswitch_mode,
+				     NULL);
+}
+
+static int __init
+devlink_default_handle_parse(char *handle, char **bus_name, char **dev_name)
+{
+	char *slash;
+	char *p;
+
+	if (!handle || !*handle)
+		return -EINVAL;
+
+	for (p = handle; *p; p++) {
+		if (*p == '[' || *p == ']' || *p == '*')
+			return -EINVAL;
+	}
+
+	slash = strchr(handle, '/');
+	if (!slash || slash == handle || !slash[1])
+		return -EINVAL;
+	if (strchr(slash + 1, '/'))
+		return -EINVAL;
+
+	*slash = '\0';
+	if (strchr(handle, ':'))
+		return -EINVAL;
+
+	*bus_name = handle;
+	*dev_name = slash + 1;
+	return 0;
+}
+
+static struct devlink_default_node *
+devlink_default_node_find(const char *bus_name, const char *dev_name)
+{
+	struct devlink_default_node *node;
+
+	list_for_each_entry(node, &devlink_default_nodes, list) {
+		if (!strcmp(node->bus_name, bus_name) &&
+		    !strcmp(node->dev_name, dev_name))
+			return node;
+	}
+
+	return NULL;
+}
+
+static int __init
+devlink_default_node_add(const char *bus_name, const char *dev_name)
+{
+	struct devlink_default_node *node;
+
+	if (devlink_default_node_find(bus_name, dev_name))
+		return -EEXIST;
+
+	node = kzalloc_obj(*node);
+	if (!node)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&node->list);
+	node->bus_name = kstrdup(bus_name, GFP_KERNEL);
+	node->dev_name = kstrdup(dev_name, GFP_KERNEL);
+	if (!node->bus_name || !node->dev_name) {
+		kfree(node->bus_name);
+		kfree(node->dev_name);
+		kfree(node);
+		return -ENOMEM;
+	}
+
+	list_add_tail(&node->list, &devlink_default_nodes);
+	return 0;
+}
+
+static int __init devlink_default_handles_parse(char *handles)
+{
+	char *handle;
+	int err;
+
+	if (!strcmp(handles, "*")) {
+		devlink_default_match_all = true;
+		return 0;
+	}
+
+	while ((handle = strsep(&handles, ",")) != NULL) {
+		char *bus_name;
+		char *dev_name;
+
+		err = devlink_default_handle_parse(handle, &bus_name,
+						   &dev_name);
+		if (err)
+			return err;
+
+		err = devlink_default_node_add(bus_name, dev_name);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void __init devlink_default_node_free(struct devlink_default_node *node)
+{
+	kfree(node->bus_name);
+	kfree(node->dev_name);
+	kfree(node);
+}
+
+static void __init devlink_default_nodes_clear(void)
+{
+	struct devlink_default_node *node;
+	struct devlink_default_node *node_tmp;
+
+	list_for_each_entry_safe(node, node_tmp, &devlink_default_nodes, list) {
+		list_del(&node->list);
+		devlink_default_node_free(node);
+	}
+
+	devlink_default_match_all = false;
+}
+
+static int __init devlink_default_parse(char *str)
+{
+	char *handles_end;
+	char *handles;
+	char *cmd;
+	int err;
+
+	if (!str || *str != '[')
+		return -EINVAL;
+
+	handles = str + 1;
+	handles_end = strchr(handles, ']');
+	if (!handles_end || handles_end[1] != ':' || !handles_end[2])
+		return -EINVAL;
+
+	*handles_end = '\0';
+	cmd = handles_end + 2;
+	if (!*handles)
+		return -EINVAL;
+
+	err = devlink_default_cmd_parse(cmd);
+	if (err)
+		return err;
+
+	err = devlink_default_handles_parse(handles);
+	if (err)
+		devlink_default_nodes_clear();
+
+	return err;
+}
+
+/**
+ * devl_apply_defaults - Apply defaults matching the devlink instance
+ * @devlink: devlink
+ *
+ * The caller must hold the devlink instance lock.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int devl_apply_defaults(struct devlink *devlink)
+{
+	const char *bus_name = devlink_bus_name(devlink);
+	const char *dev_name = devlink_dev_name(devlink);
+	struct devlink_default_node *node;
+
+	devl_assert_locked(devlink);
+
+	if (devlink_default_match_all)
+		return devlink_default_eswitch_apply(devlink);
+
+	node = devlink_default_node_find(bus_name, dev_name);
+	if (node)
+		return devlink_default_eswitch_apply(devlink);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devl_apply_defaults);
+
+static int __init devlink_default_setup(char *str)
+{
+	devlink_default = str;
+	return 1;
+}
+__setup("devlink=", devlink_default_setup);
+
 static struct devlink *devlinks_xa_get(unsigned long index)
 {
 	struct devlink *devlink;
@@ -578,6 +823,27 @@ static int __init devlink_init(void)
 {
 	int err;
 
+	if (devlink_default) {
+		char *def;
+
+		def = kstrdup(devlink_default, GFP_KERNEL);
+		if (!def) {
+			err = -ENOMEM;
+			goto out;
+		}
+		err = devlink_default_parse(def);
+		kfree(def);
+		if (err == -EEXIST) {
+			devlink_default = NULL;
+			pr_warn("devlink: duplicate handles ignored\n");
+		} else if (err == -EINVAL) {
+			devlink_default = NULL;
+			pr_warn("devlink: invalid command line parameter ignored\n");
+		} else if (err) {
+			goto out;
+		}
+	}
+
 	err = register_pernet_subsys(&devlink_pernet_ops);
 	if (err)
 		goto out;
@@ -593,7 +859,10 @@ static int __init devlink_init(void)
 out_unreg_pernet_subsys:
 	unregister_pernet_subsys(&devlink_pernet_ops);
 out:
+	if (err)
+		devlink_default_nodes_clear();
 	WARN_ON(err);
+
 	return err;
 }
 
-- 
2.34.1


