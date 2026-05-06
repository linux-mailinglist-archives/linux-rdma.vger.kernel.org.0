Return-Path: <linux-rdma+bounces-20067-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gClZEV03+2nUXwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20067-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 14:43:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2AF4DA62E
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 14:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 669203032598
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 12:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3000C44CAF8;
	Wed,  6 May 2026 12:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TztvfSdb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013026.outbound.protection.outlook.com [40.93.196.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8D32BF5A;
	Wed,  6 May 2026 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071097; cv=fail; b=Tj1aX06F/JcNMfuV+udyPhXZH+Ypk/na9hqhMohUIf5gm5wdlkRthsWpp5RwT6C+07wfIHzgy2cA1GuNvFF/pfPkrjt+qR/QFvn/OAgRM42litkYbtdsK7qZluETSbtEPmUvfek1MepV1n/cJmP3M2OsvW/LeJ1/ZFJtV/uPAsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071097; c=relaxed/simple;
	bh=DnrtGsGZXqgweiD6Tot+8gJSVK87hXNa4aJWkj/EHQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KUw1LM+fTfVzPok1bq3nTa4BwnMyQiqhmI/CCN+NKtbDuGCWARpYkYLGVjJeasAFjt7Fp6PW2ITFcAhMX+1DWJiQpSvssAvmHnLMHMq8UJybxVF17PuaR773RA03BaqY+/Dn6/qIUvxRSRYJCCTWCW2VYAcN0R5pQBkTKCkoK3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TztvfSdb; arc=fail smtp.client-ip=40.93.196.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmexvqaXA7ySKWljFBBW1hosr6+VfJBsfUZZwj1ZK2m4yXbAE3WP6dvJb73jYAQcfHpW2gP5xKbkLDsXhWan340ZAX9NQTF0fthF+52fL1CuPpJyRO1pBS9triynrBqppdTKcgGtrhWw37M3UpTDXXg70ZOWRBkq4SpwVKjk5Aei7AB4mxOBYjXW8g6zNuPMRFgT48IK0+zh/RyW4LRzJPjkW8ugxfQaqKxkQFwE4B3klp3StpbR7YDeuheAS/Czd29Ol4MlLYrNBbnHCYvELfUoHc9M5BuDSemaLoyetNJjYwenfkMCf15Juo2PwWT6hruCeDhGzzURHDUKH7Bx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ap3mf5ZhOtgFboXqLpiC9tzU552oSSvtCOdVkV6kDf8=;
 b=KDEOOktNcGkKS3BuHNOkVAGrByuDjPqykNR9cz5AFMo0ZXt7W3q/WbkwV4fekzcWN8/sEaR8cKhzIR0ShKXH6KqwVusBRbKzfRk+nWbSsg93+IkyQwY6qABrpVA1tN5/01h6el+gZqKqTw0P10yvZFPr1MIFo9pPeH140Ow1cenw7fUyxJHLHCU49Adr53+4FPYppbAUtIqzFJws9PY7i6DMIvTyNlwFCsjHJYJ40yGD98vsUjADqc2Qi9uuT3I9Vr3vORIyW+VvoEisNf5ibGtaN/FFqrNwsDqxvb/U1RpnVX/KsvP8VCIDJuvtjSKmPZ5tpDF25CcKWfFj+BB6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ap3mf5ZhOtgFboXqLpiC9tzU552oSSvtCOdVkV6kDf8=;
 b=TztvfSdbD1F17hJBrnick+8/is+CMMlvidcVYmbmI+hd/IdTgYBFXXtdnAGj3u+QiQEiW9QjHXAdUMjFhJbhJit4Xlt4gkrbsQfhMmzkezkDkbUW0npLl0x/QgaPVR/89t8Z1Yi3nMx8EKBHjw8QgIF+MUskNb1tt93GYpyYF9VDXi2oLuEpcUTJPskgxxFRvVeJAOEsNxLGaumLrbZsci5bM4KYuvE4cUqSU7N8r7JQjcZB3xGf9e1miRpnA2G7c/B4DNUhv2QsyE5G7IoxcteT6O2zliAwk3Ae75JECuOBmjdpiQu7zuh97tQMkHkiMAPxWw/XfmjaPdxzSoQ+qg==
Received: from SJ0PR13CA0144.namprd13.prod.outlook.com (2603:10b6:a03:2c6::29)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 12:38:05 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::ac) by SJ0PR13CA0144.outlook.office365.com
 (2603:10b6:a03:2c6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.6 via Frontend Transport; Wed, 6
 May 2026 12:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 12:38:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 05:37:50 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 6 May 2026 05:37:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 05:37:42 -0700
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
Subject: [RFC net-next 0/4] devlink: Add boot-time defaults
Date: Wed, 6 May 2026 15:37:35 +0300
Message-ID: <20260506123739.1959770-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a38334f-c99f-4e42-dd28-08deab6c51cc
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|7416014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	MFkAxbWjH+BK/1G7JTCE7oYlG12EcdGM35a7xZQL1gI/jwM8arqKRHCfThLtKGm91Kugz2rU12XR+DIYkXHlb85is55jPW+z2+4lsYVMvXbKJzLNvluHdNolMTCt3NyITV6kDWopEmpzFwCoQ5/jGNPYoEo5gLfdIoRW0SmTVkNfqlI1pp5ML9OGagdyARpiA4bgm/BZv9iu8HnE4oesfBSfhofiIDqEzF9vIKOESN5CXc+F04KlYAncOKijD3jjXF7YzEeFHS7yCJCYv7cq0IfILR4Abxw5acLJ9/JT7nttoicsLMGyJzBZL+fgrAfAx0TCFOiuEro3EA8BcKmn4rdWfcwssmYNb2CyTG1SpsnD8XUwsrIoHsJwCkQ8kqOdx0KrmB98skMn/0xPJmrTN14MimlTs3qrQoJ5nKMK5nM/cfXrkhTchkVodSMwynY++fkpeqhf33DHlnwgAjQvkK5YEuBX2JJMMdi8nOz0AEfkzE0vB0zy7btzQgUaOfcwvADCQhrxkFUTuVDQwXYz450ucuhI+45V9RbQ1rPdUXHfiMjDyn1HsmIvjXGOKVWUjiC4GLqA9CHJTmaBQ8KpLdokLQG9njEDZwsVxc828hFybzQnPN8CbZk084iFQUUZ7/SzNgrTdxX2JQtzqaNSLz4cAFKJhAUTBcaw/CeLo0HFgOXJZBM4/z+qb6kOiaraZaZb5HG7+P709LU72KoQPJ1LJ8l2nrRKOCQuu9rL9xJhMFXcnJ+LwdHvbydZhRuI
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(7416014)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1EJCINeRsnvgqRkOe7voYJiPPdf1VNGiRvJTGwyVrjsIcg1J5fAsFGNB8XLLEIAxLeeHnXg7sNfWjdQL0yzdB5apJ2xShzSPB0OHOE3g/weKEVCXEnAfS4lzhR3RZFftvCqXpJ6kmFdbmphOLjtx/CNogqdLEv0XdhkLXcJftAvXL4xZYcU+/6GhpdqDjrHwjF6b3h4BP8vtuRub5puz74zBd+JmlQPRnCqEKuGqPNvXHP5uQ/olGV5nVdTU8FvlSL34Q3zJqWhE/Wg84uFIroe9pvlaZl9xk247A8x8j7NV7+Oo0SKHkYTW+YNFu1DI17JGInGR9p+GFl/CYQdEIRbQQtx6Nm3oSuIK1iz5xQUC7soRZ8E+pP0SNcVGSLaaE2RPW2gJjYotA0JH4TI5RERpsMWeQPpS9VuN8WboTAH3WIwkgjKKBpWJ7yYjzmpe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 12:38:04.9732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a38334f-c99f-4e42-dd28-08deab6c51cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
X-Rspamd-Queue-Id: DA2AF4DA62E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20067-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

This series adds a devlink= kernel command line parameter for applying
selected devlink settings during device initialization.

Following a discussion with Jakub[1], I am sending this RFC to get the
conversation moving. I started from Jakub's example/request and extended
it to cover requirements from production systems and configurations that
customers use.

One important caveat is that the parsing logic in this RFC was written
with AI assistance. I am also not sure whether the resulting syntax and
parser are too complex for a kernel command line interface. This is part
of why I am sending it as an RFC: to understand what direction and level
of complexity would be acceptable to people.

The implementation is intended to support the following properties:

- A system may have multiple devlink devices that usually need the same
  configuration. For a configuration such as eswitch mode switchdev, a
  user should be able to specify multiple devices to which that
  configuration applies.

- There may be ordering dependencies between options. For example, in
  mlx5, flow_steering_mode should be set before moving to switchdev.
  With this in mind, defaults are applied per device in the left-to-right
  order in which they appear on the command line.

The intent is to let deployments set devlink defaults before normal
userspace orchestration runs, while still using devlink concepts and
driver callbacks rather than adding driver-specific module parameters.
A default is scoped to one or more devlink handles, for example:

  devlink=[pci/0000:08:00.0]:esw:mode:switchdev
  devlink=[pci/0000:08:00.0]:param:flow_steering_mode:smfs
  devlink=[pci/0000:08:00.0,pci/0000:08:00.1]:param:flow_steering_mode:hmfs,[pci/0000:08:00.0,pci/0000:08:00.1]:esw:mode:switchdev

The infrastructure stores parsed defaults per devlink handle and
applies them in command-line order when a matching devlink instance is
ready. Duplicate defaults for the same handle are rejected so the
resulting state is deterministic.

The first supported command is eswitch mode configuration. The second
is generic runtime devlink parameter setting. Parameter values are
parsed according to the registered devlink parameter type and are
applied only in runtime configuration mode.

mlx5 wires this into device initialization after the devlink instance
is registered and after mlx5 devlink operations and parameters are
available, so both eswitch mode defaults and runtime parameter
defaults can be applied to matching devlink devices.

Patch 1 adds the generic devlink boot-default parser, storage,
duplicate handling and devl_apply_defaults() API.

Patch 2 adds eswitch mode defaults and documents the devlink= syntax.

Patch 3 adds runtime devlink parameter defaults, including string to
devlink parameter value conversion.

Patch 4 calls devl_apply_defaults() from mlx5 device initialization.

[1] https://lore.kernel.org/all/20260502184153.4fd8d06f@kernel.org/

Mark Bloch (4):
  devlink: Add infrastructure for boot-time defaults
  devlink: Add eswitch mode boot default
  devlink: Add runtime parameter boot defaults
  net/mlx5: Apply devlink boot defaults during init

 .../admin-guide/kernel-parameters.txt         |  26 +
 .../networking/devlink/devlink-defaults.rst   | 115 ++++
 Documentation/networking/devlink/index.rst    |   1 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |   2 +
 include/net/devlink.h                         |   1 +
 net/devlink/core.c                            | 591 ++++++++++++++++++
 net/devlink/devl_internal.h                   |   3 +
 net/devlink/param.c                           |  70 +++
 8 files changed, 809 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-defaults.rst


base-commit: 7e0cccae6b45b12eaf71fc3ab8eb133bb50b28ad
-- 
2.34.1

