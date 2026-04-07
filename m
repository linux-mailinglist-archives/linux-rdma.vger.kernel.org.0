Return-Path: <linux-rdma+bounces-19102-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EcsM2xe1Wlq5QcAu9opvQ
	(envelope-from <linux-rdma+bounces-19102-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:43:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5293B3E1D
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A3C1302F394
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 19:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD1B3783B4;
	Tue,  7 Apr 2026 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b75JJqop"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2747533A9DE;
	Tue,  7 Apr 2026 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590929; cv=fail; b=oKOfYU41wD8wTE67s7s41EhD9xD/WRtsZ6RwZmXG3sP1XybCKrwinLWA9Q8iX0AVRlK4TmcNbJ4LMrhMrMHREQXJBmXxy7NtWyYaEoxNptAGQoa9WzE0HMEtN+MHyXMXBXqnhnRYnLhzlwF1TzilJ6E5EhgbBsWTUQZRiGfLG3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590929; c=relaxed/simple;
	bh=8scGPEcgD2WtZ+fFLaLz9rUZO+6A4GZGKyMVEW5SNF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ejDVvA6GKc+Y4b//llQpw9pnOVMbbBeJk8vRjifzPRSwkTiyjFuvlbHgU0oRXVRiEdLCairodyzc0A7lZpN0VUsG6Yz94vS4hNCINa34qsdMkTa8OpFtBq/lIyKStzhH/Ym4RZN0B+V9Y8PqIf1k7RDOlEE2OF3rl/B1rlSfRYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b75JJqop; arc=fail smtp.client-ip=52.101.53.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyq+BbMjfdlmL2ydOV3yKh/4oLdaEmISlLZNz64u/Y3l/B2k9Btp8RJbYF8/NqHPNUD4GLVR1vdT4ZOlxnpRHzWlc8lAGM8UmJqKQh+reMU5yYBAE1oJQKrQCXEBeuEsyjFH5c2iCW8/nVMktO36rG1ujhe/Gi2LCoNKG/T+fzsP9QQWnzrJSyjirW/VA3aDXLJl2NZ6L5FtBpqlhn4m1zUKsH2x0AJQ7DhnYjkUAfgaHFQq/gJ5ARBbHE6DAzuAg4L/zeto46jfT+hsNW+leQR3jir2/yMa5KYXWLjvxlvcLIWlmP98ZoTaJzxXsv2+YrGJngOkZE06ICoeUrT8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYh0Xs/YYzzqCu38Cd0fF26PERpVnn4GpxthKjkQBvU=;
 b=lB/ksGM9u2BfZZ6KAmH/cp4MdruWANuF9KsGkgPheqpzErRtz/6YyYUyXPOiLUywzpTQMigqqGZ3oxHv4/+fy5AB24tdd4hX81OdejxsUzZJYChhzhuRqRq3e0bJ0psL67dJpDynfREb0namFIuwCdr4CO3cFY07shAMWXDqYXHVc8q/BKQNSbPCrnkrpwocrwKvT4fo88d64+vzeWKv6ZjoeOnJtv9wr01A93Pl6x7Dqdz0TFA3iyEFPyN9birRiTWGld3so8mKzKsgCl+oTGKM/CHFE8w8drLKImgQHYdLBB+PwazVUj8wF6SuNN6qn2vQWxGuKokSm+j0xRNe9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYh0Xs/YYzzqCu38Cd0fF26PERpVnn4GpxthKjkQBvU=;
 b=b75JJqopbi5FDTvL4H1sJsYPr5w8oGjlls3GR2GNUte6gnl1Oc8CBZnOakdd5mNg8iW/TC0v7qjLkDqkcKNuVUTePDW+gOl96FVLZYNOUAjDSfbGpauyp4tZyyd87/awSuqsNAdSZi89I86LIe/E4mkKVsQ06IZqFDcEe/XAen05i1RU+QW/crlp6ewQ2Utw3JWwHIiXJ/JioAerHSUGhgDT9g2uVdhwhi+6hjARn4wKWc+1Q7lhiBVAzHybxYIrq3lL3CelDZ1htbSjZfGeUmYqskMBhzZlQ0xhvf9n3OmcQJQuHJGKK6uNl03s2JQOPDODaRQaG9kp1KLlxpxvnQ==
Received: from BN9PR03CA0315.namprd03.prod.outlook.com (2603:10b6:408:112::20)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 19:42:03 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::74) by BN9PR03CA0315.outlook.office365.com
 (2603:10b6:408:112::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 19:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 19:42:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:41:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:41:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Apr
 2026 12:41:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, "Matthieu Baerts (NGI0)"
	<matttbe@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Carolina Jubran
	<cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, Shahar Shitrit <shshitrit@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Parav Pandit
	<parav@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, "Shay
 Drori" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V5 00/12] devlink: add per-port resource support
Date: Tue, 7 Apr 2026 22:40:55 +0300
Message-ID: <20260407194107.148063-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: 5574ab04-40de-4a3c-db15-08de94ddbdeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qnbtMZAl6NvnIpXEtSyrEVw7qlMThF/Zr0mOk81lO9FdtvOUY4esneua7CTlo3PYC7kwNoONudpdUk3NtJFToTuZHFqcSO4KNjPinSPRaXvIB5Ih+OsT/JWWXX0fGFyeVFT5vQ6RQi7LIjQcG41wVfCCuq1IqKxDwCfoTbADmWIxcoBpbo3cSZ/mFRrFqevhxrjQrDUmjgfisqhdA5rpt/VWIAD41TnQGjj2KfughEuRUImzpDtrIeOK2lz4yaC2aLb1HpyRbZ4/X+/vxtbLhz0p/m4BW8+mawMEOaoZWrxAog8JNO7ztuQ8jW61+1oI9LfGb/CsbOK1WzcxxYkxpWTk8yszZe5rAFEdkGagjx/wpE5i9DAbaskODvrqBbSFw5oaq8X+Zqp0hyysJuHtx34zV3q224KJTs/27LbuH/BN5v3etXgnKY615Y5/95MNov9jzy0t71GEav3I8tN0cnNJLPnaYWVXMbodppXnmluLACa05sWzTEuxBrzMN2gOARX3O8JlPa02Z8+tawzAP3ZcNCLSEcSXPkVuC/n+7w38KY4bFFHFwX25DLaxMXya1E/d48tZa9f9STUAoYgb0LYdxJILx2Zu1SsOCRgLOhd0QxQd06izGZYJ7Z+E32UjPIDsPk84F/bd6rL0csj7H5QgpTD77FyaAbhh4k3iyCdiPwMwh7WP2YYrCZGA6avfUAuvAvNd7IO+QFr0Su7LXQCyRhy2SXFadTzWac1jeYzOyXxyzHCXH9tDYc4O0azOvE/Bkcuxjx7MW5YIFmcuFA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rm9QWIcHcLysby14DNdUpNYxrlemd57FeBg24q6ZsW7IMGBH6SU3+MdGy/kI6x6NfrTWWQ8hvGslzLDrcEKf+gYCeymcO3H+8zEB2i1rZlQTQ2wcjv7Lj+FunbLjf1o013KNIGumBT2ol8ZDovo9C4TYMC7TKQsE31SU+lWBM6EEP/iZ2UKB+KbO8wc/bmhpIgziunObfYpJ9GnUJjNaexQbthhr/m+wTTVVfL8ZEsvOmeg2m6+gv0pIqWiNFdkLfJk3cQyzhIycdpLoOND/SCaGXPJ0ek1BolXOG/rPfWdaWXm92RZkKOx0amb/qjrBI7+M9l30rW2Gfn+ALQfgq0Z/cH804nsLwI+u6+LGg/ea9UB69tfFzMOvjoMQgmSUaW/0r+JINMvUcMIhc8wox+HmJDpXdl/F+pzjtb+vreIELy31kriWbHT1U0Zp7j8f
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:42:02.6447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5574ab04-40de-4a3c-db15-08de94ddbdeb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19102-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6A5293B3E1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series by Or adds devlink per-port resource support.
See detailed description by Or below [1].

Regards,
Tariq

[1]
Currently, devlink resources are only available at the device level.
However, some resources are inherently per-port, such as the maximum
number of subfunctions (SFs) that can be created on a specific PF port.
This limitation prevents user space from obtaining accurate per-port
capacity information.
This series adds infrastructure for per-port resources in devlink core
and implements it in the mlx5 driver to expose the max_SFs resource
on PF devlink ports.

Patch #1  refactors resource functions to be generic
Patch #2  adds port-level resource registration infrastructure
Patch #3  registers SF resource on PF port representor in mlx5
Patch #4  adds devlink port resource registration to netdevsim for testing
Patch #5  adds dump support for device-level resources
Patch #6  includes port resources in the resource dump dumpit path
Patch #7  adds port-specific option to resource dump doit path
Patch #8  adds selftest for devlink port resource doit
Patch #9  documents port-level resources and full dump
Patch #10 adds resource scope filtering to resource dump
Patch #11 adds selftest for resource dump and scope filter
Patch #12 documents resource scope filtering

Userspace patches for iproute2:
https://github.com/ohartoov/iproute2/tree/port_resources

V5:
- Link to V4:
  https://lore.kernel.org/all/20260401184947.135205-1-tariqt@nvidia.com/
- Change resource scope attribute from bitmask to u32
- Remove max value and valid mask define for scope attribute
- Handle the case where a device is unregistered or a port is removed
  in the middle of a multi-callback dump (Sashiko's comment)
- Replace port_number with port_index and add an index_valid bool to
  the dump state to track the port resources phase of the dump
  (Sashiko's comment)

Or Har-Toov (12):
  devlink: Refactor resource functions to be generic
  devlink: Add port-level resource registration infrastructure
  net/mlx5: Register SF resource on PF port representor
  netdevsim: Add devlink port resource registration
  devlink: Add dump support for device-level resources
  devlink: Include port resources in resource dump dumpit
  devlink: Add port-specific option to resource dump doit
  selftest: netdevsim: Add devlink port resource doit test
  devlink: Document port-level resources and full dump
  devlink: Add resource scope filtering to resource dump
  selftest: netdevsim: Add resource dump and scope filter test
  devlink: Document resource scope filtering

 Documentation/netlink/specs/devlink.yaml      |  32 +-
 .../networking/devlink/devlink-resource.rst   |  70 ++++
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   4 +
 .../mellanox/mlx5/core/esw/devlink_port.c     |  37 +++
 drivers/net/netdevsim/dev.c                   |  23 +-
 drivers/net/netdevsim/netdevsim.h             |   4 +
 include/net/devlink.h                         |  10 +-
 include/uapi/linux/devlink.h                  |  11 +
 net/devlink/devl_internal.h                   |   5 +
 net/devlink/netlink.c                         |   2 +
 net/devlink/netlink_gen.c                     |  24 +-
 net/devlink/netlink_gen.h                     |   8 +-
 net/devlink/port.c                            |   2 +
 net/devlink/resource.c                        | 314 +++++++++++++++---
 .../drivers/net/netdevsim/devlink.sh          |  79 ++++-
 15 files changed, 568 insertions(+), 57 deletions(-)


base-commit: c149d90e260ca1b6b9175468955a15c4d95a9f3b
-- 
2.44.0


