Return-Path: <linux-rdma+bounces-20070-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKtsL8E2+2n2XwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20070-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 14:40:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 652A84DA573
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 14:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70D933075216
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DBB44D03B;
	Wed,  6 May 2026 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qiQxXx4k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC3044CF39;
	Wed,  6 May 2026 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071122; cv=fail; b=CDIPLed5pVf67U8JzR/nnH81v6X9NI/C/YFDOaZ2kVHNQ0IveMWGZwVOWiZhojOXin0ZeSZVp/5ThuXgMaQ8Yg6oIcqx6HSsge9n8cCzJpg4X6GB2OWUHv5Sc2JPeI8tzyYZ0YlHNE9VKvY7YQHRdZCgy+UEVR3As5isUsXuZt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071122; c=relaxed/simple;
	bh=LorUiXDYKxcgsmY93kG1kknJXxWPWGGZWyFhqgyK+7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8cH7j6SkdZB98wY4J3nJyDu5/kSBcSmtJW8+DqifHk6EQj98vZuKNDrtBsVBbbUxBsaMNW+Hq+DSVM9gbf9u3hZ+T7SKilCYUtsM01jPjkQkNaZVZxLhk+kwTne/3JXTG2iwR7gEBikMonc9zg0gHBW1u6W+wqWSf5pAal25pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qiQxXx4k; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWPBPRwZglTAUAnth2K6de7pqwat/B5LGhhqNXHfxShQFNTEBcDmVPrTTjbRoPN4cI1lgnQsBhP41hNWkl198QC45O7rcUbdGL2XReEbPm4JV0t+mM9OweV6rrra3YpAmYiPURF6AL8txJJv/TAWA9V3VfnEY0tbJYCzxpXYzyDD2rfsRKP3w8VR6/E3jwLM3hBVpyg1rTxw93vGqrxsqjMxOVlNQJcn+ItkYr3g/UNdI9D9kNpVV9mf3rs27u5fwdCCFBu1ZPxrS8XRy2TrBJo3cBgCGOlTbW1kN62kvQrWsr+C44D1N1mIkfWvWFeCyJdJ/T4WHc6ZRiduQ3KeWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9fcvnLst3Ln2PmNzyZ94pxTNym78iMxD0VkpoYUgDM=;
 b=pkoB7N1bRbbfGVL2wkM6Wlwjkto4twTuh8WZOhnHqXu0HEaO4hNmAuRowayUbDbfHheB6Ti6iCDGP8DruHC8dp2ehto5j71pu7nSb287y2Ij7X1crfVGpRKqo9PuomaDQpnxXJStJUJrR52nUDpSA5dE0btkJREgJN1At2u6no9At+JQmERl0HvJJ700SlVv8qNlHncNfqjszochWDs2GB9og15AoZBlw9ZMf97XPwwvsSHE8sgGnHBsLutHztxnTTZVFowkYB3Dr7b+U+jzq+M4PECEfWhFBKsI+x4tocZ2xanj28jwOyeESjtSE+8AwPWvJGY6y4exQAT0X5EXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9fcvnLst3Ln2PmNzyZ94pxTNym78iMxD0VkpoYUgDM=;
 b=qiQxXx4kSCx4yz4jXJ4u1PJFAyfsS5xzvx7skPdlhwc8LsDm33lvjEZ1j0XkB/Bcr2a3aVMRzwYlPCTjO9Km5grkK1XDozTZ+GSATmpwhApwlLAic2d9SjkYa6DkJ0Ft58IKnTZWNF631Nw1Y/+46bCALmsSa/EC3ChroL+A42TM2gF+UiWYbwnMcRvha70fmeJGoioEoAWK+ErbQiFoonRRf6jRr+CNmZioyx4n83eR47BHajnhpfqd5RJHFIQyG+xkz+nXN6uJbcgGUC7QCrq/czTrpByMtrv/aXGi43I9bTv3eMSWnPHNeWF8zI70TVMLF+q8nVoGmejuqpL4Og==
Received: from BY3PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:254::24)
 by CY1PR12MB9559.namprd12.prod.outlook.com (2603:10b6:930:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Wed, 6 May
 2026 12:38:29 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::25) by BY3PR05CA0019.outlook.office365.com
 (2603:10b6:a03:254::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.6 via Frontend Transport; Wed, 6
 May 2026 12:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 12:38:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 05:38:15 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 6 May 2026 05:38:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 05:38:07 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, "Randy
 Dunlap" <rdunlap@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>, Petr Mladek <pmladek@suse.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Thomas Gleixner
	<tglx@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver
	<elver@google.com>, Eric Biggers <ebiggers@kernel.org>, Li RongQing
	<lirongqing@baidu.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [RFC net-next 3/4] devlink: Add runtime parameter boot defaults
Date: Wed, 6 May 2026 15:37:38 +0300
Message-ID: <20260506123739.1959770-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506123739.1959770-1-mbloch@nvidia.com>
References: <20260506123739.1959770-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|CY1PR12MB9559:EE_
X-MS-Office365-Filtering-Correlation-Id: 6189f9b4-52a4-4fe4-0903-08deab6c606b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eoKnxLinW78DOGzn9pbNhPI886OC/er6qUUhULk1+/9Gdys3DUTM3TWuMxambBdIJ2DtQRf+4mweIFCxQmtHdKdlCg3wXCVD7Tdo/nf34J3MX53H2UZm44BAXlQgw7YXy9Ck3vQfTYTt5wo3qRVfvHAguyFJCDrEQMXacCClr2PPMgPgiciVjwcoN+lXq/+embDPhfeuify00UIg8cq/D5FOHRwlXEFMGMjSOiY4hva8uVvjNKQwvhFGNV9jMbLJUD5OEYD/XtitzVuaE2HOnjzz/RNYsq4fKbTy3rcNTR3XjpZ1ngF5eNUiSum/ZfOWSNm3aOKOfE+FoMNQX2Hjc5sCBCNfPkvBMy1pirtEwnO7O/gVcxPrZZ+7Z0W11iBTjnRUBiXo1dHKNO1+VHzaxJ1hoFMtLKAD/JDBPazG48KypHyelDXRYWGcOOyya52S9NGsIbUmBDa/b9IxjhBWOeaCGgzhxe7BjXdLTfZCQmv4oLNQ7B4RMUyG4UXMXqQQjQCwDtBCPiBJfc/NDsLA5tFjWMqiFZc9QI5KtPpJHSdDwJLw55ZK3bA8LkSgmU46pTRduoAaLMqctE+S/V5JMh25nHc3QaFMeqRvC88UuYY3e67KCdNQ9H2TDIEIo1GPC6FdEI5siyXKT8FDhdvL7/OYOwrDQit88zwK3UeSpYiGMXzKFlHwBleoFuHj4L8uhjVICyVpoUYNjuCyeQPWaA/PES6uNd18H5WDgNP4Vbc=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lCa2lC8xzngnUqX1jlhKJ8IZOXcGbXqv+Rq5KHf/YW7oiKPP6OI0nyGXso6vq/75l9QYREAmrq7ain4mm4ScQz/U7XKGFDfiiEZ4xtyEUWp+bE3SS5VKwi2ba+adfbLbe/Ol22Qu0v8IErPiQicweK5AE0j3AhgQCLFS7uV9kESwmm1gqijeTaLazOS8dtETsCe35oNkaob0GRxckDtkguY3asJOB79Jrjlp2U4skM0IEb1t3aP6hUWFyF+xorUGpSHnrQ+DgrjDnurhUVW6k5vUTnfJqucrQlv8mWKLdFkYfmsQJBP3VJhqFdHub/6YJtsEQMWvnovTvNbkTUgG4zCmLk5QkVyuc94qmjmj/G0R5FLYR4FDamrtOM9Ns7y6KdDOKvpEpVq2a78ObchHHLxhrLQh04ili/UNea7bfTovi+ZM8ZgWfab3uHbe/jFR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 12:38:29.4941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6189f9b4-52a4-4fe4-0903-08deab6c606b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9559
X-Rspamd-Queue-Id: 652A84DA573
X-Rspamd-Action: no action
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
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20070-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,mellanox.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Add support for setting devlink device parameters from the devlink=
kernel command line parameter.

The supported syntax is:

  devlink=[<handle>]:param:<name>:<value>

Parameter values are parsed according to the registered devlink
parameter type and are applied in runtime configuration mode. Driverinit
and permanent configuration modes are intentionally not part of the
boot-default syntax.

Add a helper that finds a parameter by name, verifies runtime mode
support, converts the string value, runs the parameter validator and
invokes the existing set callback.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         |   2 +
 .../networking/devlink/devlink-defaults.rst   |  18 ++-
 net/devlink/core.c                            | 110 ++++++++++++------
 net/devlink/devl_internal.h                   |   3 +
 net/devlink/param.c                           |  70 +++++++++++
 5 files changed, 165 insertions(+), 38 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 150202882870..761ae45b8607 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1293,9 +1293,11 @@ Kernel parameters
 
 			Currently supported settings:
 			esw:mode:{ legacy | switchdev | switchdev_inactive }
+			param:<name>:<value>
 
 			Examples:
 			devlink=[pci/0000:08:00.0]:esw:mode:switchdev
+			devlink=[pci/0000:08:00.0]:param:flow_steering_mode:smfs
 			devlink=[pci/0000:08:00.0,pci/0000:08:00.1]:esw:mode:legacy
 			devlink=[pci/0000:08:00.0]:esw:mode:switchdev,[pci/0000:08:00.1]:esw:mode:switchdev_inactive
 
diff --git a/Documentation/networking/devlink/devlink-defaults.rst b/Documentation/networking/devlink/devlink-defaults.rst
index 7d6ccaddca86..0d4036e59e88 100644
--- a/Documentation/networking/devlink/devlink-defaults.rst
+++ b/Documentation/networking/devlink/devlink-defaults.rst
@@ -55,13 +55,16 @@ The following syntax rules apply:
 * Defaults for the same handle are applied in command-line order.
 * The same ``esw`` attribute may be specified only once for a given devlink
   handle.
+* The same ``param`` name may be specified only once for a given devlink
+  handle.
 * Duplicate entries for the same handle are rejected and all devlink defaults
   are ignored.
+* Parameter names and values must not contain ``:`` or ``,``.
 
 Supported defaults
 ==================
 
-The supported command is ``esw``:
+The supported commands are ``esw`` and ``param``:
 
 .. list-table::
    :widths: 10 25 35
@@ -73,11 +76,16 @@ The supported command is ``esw``:
    * - ``esw``
      - ``mode:<mode>``
      - ``legacy``, ``switchdev``, ``switchdev_inactive``
+   * - ``param``
+     - ``<name>:<value>``
+     - ``<value>`` is parsed according to the registered devlink parameter
+       type. Only runtime devlink parameters are supported.
 
 The ``esw:mode`` default corresponds to the userspace command::
 
   devlink dev eswitch set <handle> mode <value>
 
+The ``param`` default applies the named devlink parameter in runtime mode.
 
 Examples
 ========
@@ -90,6 +98,10 @@ Set two PCI devlink instances to legacy mode::
 
   devlink=[pci/0000:08:00.0,pci/0000:08:00.1]:esw:mode:legacy
 
+Set a runtime devlink device parameter::
+
+  devlink=[pci/0000:08:00.0]:param:flow_steering_mode:smfs
+
 Set different modes for different PCI devlink instances::
 
   devlink=[pci/0000:08:00.0]:esw:mode:switchdev,[pci/0000:08:00.1]:esw:mode:switchdev_inactive
@@ -97,3 +109,7 @@ Set different modes for different PCI devlink instances::
 The following is invalid because the same handle receives ``esw:mode`` twice::
 
   devlink=[pci/0000:08:00.0]:esw:mode:legacy,[pci/0000:08:00.0]:esw:mode:switchdev
+
+The following is invalid because the same handle receives ``param:x`` twice::
+
+  devlink=[pci/0]:param:x:1,[pci/0]:param:x:2
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 4b404135181c..22990793ab8c 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -50,6 +50,13 @@ struct devlink_default_node {
 	struct list_head cmd_list;
 };
 
+struct devlink_default_attr_spec {
+	const char *name;
+	enum devlink_attr attr;
+	int (*value_parse)(const char *value,
+			   struct devlink_default_attr_item *attr_item);
+};
+
 struct devlink_default_cmd_spec {
 	const char *name;
 	enum devlink_command cmd;
@@ -73,13 +80,6 @@ devlink_default_attr_free(struct devlink_default_attr_item *attr)
 	kfree(attr->value.param.value);
 }
 
-struct devlink_default_attr_spec {
-	const char *name;
-	enum devlink_attr attr;
-	int (*value_parse)(const char *value,
-			   struct devlink_default_attr_item *attr_item);
-};
-
 static int __init
 devlink_default_attr_parse(char *str,
 			   const struct devlink_default_attr_spec *attrs,
@@ -153,6 +153,33 @@ devlink_default_esw_attr_parse(char *str,
 					  attr_item);
 }
 
+static int __init
+devlink_default_param_attr_parse(char *str,
+				 struct devlink_default_attr_item *attr_item)
+{
+	char *name;
+	char *value;
+
+	attr_item->attr = DEVLINK_ATTR_PARAM;
+
+	name = strsep(&str, ":");
+	value = strsep(&str, ":");
+	if (!name || !*name || !value || !*value || str)
+		return -EINVAL;
+
+	attr_item->value.param.name = kstrdup(name, GFP_KERNEL);
+	if (!attr_item->value.param.name)
+		return -ENOMEM;
+	attr_item->value.param.value = kstrdup(value, GFP_KERNEL);
+	if (!attr_item->value.param.value) {
+		kfree(attr_item->value.param.name);
+		attr_item->value.param.name = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int
 devlink_default_eswitch_apply(struct devlink *devlink,
 			      const struct devlink_default_attr_item *attr)
@@ -171,6 +198,17 @@ devlink_default_eswitch_apply(struct devlink *devlink,
 	}
 }
 
+static int
+devlink_default_param_apply(struct devlink *devlink,
+			    const struct devlink_default_attr_item *attr)
+{
+	if (attr->attr != DEVLINK_ATTR_PARAM)
+		return -EOPNOTSUPP;
+
+	return devlink_param_set_from_string(devlink, attr->value.param.name,
+					     attr->value.param.value);
+}
+
 static const struct devlink_default_cmd_spec devlink_default_cmds[] __initconst = {
 	{
 		.name = "esw",
@@ -178,52 +216,46 @@ static const struct devlink_default_cmd_spec devlink_default_cmds[] __initconst
 		.run = devlink_default_eswitch_apply,
 		.attr_parse = devlink_default_esw_attr_parse,
 	},
+	{
+		.name = "param",
+		.cmd = DEVLINK_CMD_PARAM_SET,
+		.run = devlink_default_param_apply,
+		.attr_parse = devlink_default_param_attr_parse,
+	},
 };
 
-static const struct devlink_default_cmd_spec *__init
-devlink_default_cmd_spec_find(const char *name)
-{
-	size_t i;
-
-	for (i = 0; i < ARRAY_SIZE(devlink_default_cmds); i++) {
-		if (!strcmp(name, devlink_default_cmds[i].name))
-			return &devlink_default_cmds[i];
-	}
-
-	return NULL;
-}
-
 static int __init
 devlink_default_cmd_parse(char *str,
 			  struct devlink_default_cmd_item *cmd_item)
 {
-	const struct devlink_default_cmd_spec *spec;
 	struct devlink_default_attr_item attr_item = {};
 	char *cmd_name;
 	int err;
+	size_t i;
 
 	cmd_name = strsep(&str, ":");
 	if (!cmd_name || !*cmd_name || !str || !*str)
 		return -EINVAL;
 
-	spec = devlink_default_cmd_spec_find(cmd_name);
-	if (!spec)
-		return -EINVAL;
-
-	err = spec->attr_parse(str, &attr_item);
-	if (err) {
-		devlink_default_attr_free(&attr_item);
-		return err;
-	}
-	if (cmd_item) {
-		cmd_item->cmd = spec->cmd;
-		cmd_item->run = spec->run;
-		cmd_item->attr = attr_item;
-	} else {
-		devlink_default_attr_free(&attr_item);
+	for (i = 0; i < ARRAY_SIZE(devlink_default_cmds); i++) {
+		if (!strcmp(cmd_name, devlink_default_cmds[i].name)) {
+			err = devlink_default_cmds[i].attr_parse(str, &attr_item);
+			if (err) {
+				devlink_default_attr_free(&attr_item);
+				return err;
+			}
+			if (cmd_item) {
+				cmd_item->cmd = devlink_default_cmds[i].cmd;
+				cmd_item->run = devlink_default_cmds[i].run;
+				cmd_item->attr = attr_item;
+			} else {
+				devlink_default_attr_free(&attr_item);
+			}
+			return 0;
+		}
 	}
 
-	return 0;
+	return -EINVAL;
 }
 
 static int __init
@@ -369,6 +401,10 @@ devlink_default_cmd_equal(const struct devlink_default_cmd_item *a,
 	if (a->cmd != b->cmd || a->attr.attr != b->attr.attr)
 		return false;
 
+	if (a->cmd == DEVLINK_CMD_PARAM_SET)
+		return !strcmp(a->attr.value.param.name,
+			       b->attr.value.param.name);
+
 	return true;
 }
 
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index e4e48ee2da5a..bde333c22f18 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -212,6 +212,9 @@ static inline int devlink_nl_put_u64(struct sk_buff *msg, int attrtype, u64 val)
 int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
 				 struct devlink *devlink, int attrtype);
 int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info);
+int devlink_param_set_from_string(struct devlink *devlink,
+				  const char *param_name,
+				  const char *value_str);
 
 static inline bool devlink_nl_notify_need(struct devlink *devlink)
 {
diff --git a/net/devlink/param.c b/net/devlink/param.c
index cf95268da5b0..d2604fe2eee5 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
  */
 
+#include <linux/kstrtox.h>
+
 #include "devl_internal.h"
 
 static const struct devlink_param devlink_param_generic[] = {
@@ -551,6 +553,74 @@ devlink_param_value_get_from_info(const struct devlink_param *param,
 	return 0;
 }
 
+static int
+devlink_param_value_get_from_str(const struct devlink_param *param,
+				 const char *value_str,
+				 union devlink_param_value *value)
+{
+	switch (param->type) {
+	case DEVLINK_PARAM_TYPE_U8:
+		return kstrtou8(value_str, 0, &value->vu8);
+	case DEVLINK_PARAM_TYPE_U16:
+		return kstrtou16(value_str, 0, &value->vu16);
+	case DEVLINK_PARAM_TYPE_U32:
+		return kstrtou32(value_str, 0, &value->vu32);
+	case DEVLINK_PARAM_TYPE_U64:
+		return kstrtou64(value_str, 0, &value->vu64);
+	case DEVLINK_PARAM_TYPE_STRING:
+		if (strscpy(value->vstr, value_str, sizeof(value->vstr)) < 0)
+			return -EINVAL;
+		return 0;
+	case DEVLINK_PARAM_TYPE_BOOL:
+		return kstrtobool(value_str, &value->vbool);
+	}
+
+	return -EINVAL;
+}
+
+int devlink_param_set_from_string(struct devlink *devlink,
+				  const char *param_name,
+				  const char *value_str)
+{
+	struct devlink_param_gset_ctx ctx;
+	struct devlink_param_item *param_item;
+	const struct devlink_param *param;
+	union devlink_param_value value;
+	int err;
+
+	devl_assert_locked(devlink);
+
+	param_item = devlink_param_find_by_name(&devlink->params, param_name);
+	if (!param_item)
+		return -EINVAL;
+	param = param_item->param;
+
+	if (!devlink_param_cmode_is_supported(param,
+					      DEVLINK_PARAM_CMODE_RUNTIME))
+		return -EOPNOTSUPP;
+	if (!param->set)
+		return -EOPNOTSUPP;
+
+	err = devlink_param_value_get_from_str(param, value_str, &value);
+	if (err)
+		return err;
+
+	if (param->validate) {
+		err = param->validate(devlink, param->id, value, NULL);
+		if (err)
+			return err;
+	}
+
+	ctx.val = value;
+	ctx.cmode = DEVLINK_PARAM_CMODE_RUNTIME;
+	err = devlink_param_set(devlink, param, &ctx, NULL);
+	if (err)
+		return err;
+
+	devlink_param_notify(devlink, 0, param_item, DEVLINK_CMD_PARAM_NEW);
+	return 0;
+}
+
 static struct devlink_param_item *
 devlink_param_get_from_info(struct xarray *params, struct genl_info *info)
 {
-- 
2.34.1


