Return-Path: <linux-rdma+bounces-18910-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO8NGw9pzWkkdQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18910-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:50:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F6737F6A0
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8776C3042987
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 18:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF3E47AF57;
	Wed,  1 Apr 2026 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V0336ok/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653F217F33;
	Wed,  1 Apr 2026 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069451; cv=fail; b=A8D0QN6P2FrLVxrl1wF9Q3AgL2KqIEV6Am2H+F6coPhkgtOhBXdqUgVHXJpWawlVL1WXzhbVPFvz+gr6vq9dnLUawbJf9962JYquQl1tMUFmFkUTtXLfjEjhHoKZGbrg3GViYEDF6J2StijSHX/WfVK+DJOOczaASROLL472eRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069451; c=relaxed/simple;
	bh=q9zlwXKHVuYc9OEoq/eIWBU45QR4Xw5ERj+6tbq3tE8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P3Xr26QgUtAekI6Tdw5RBdRZkE7d59OPVjRdRuyBHUSyGNFPr6Oas+RlD9hCRDn7h+riTkf/Bwe4CRQ7FGzOiFRy5EQzQzpFntLBNuodaSegAvmD5ge6CjW+xC+/UDJKMVCtokLGGhYekvJngmnVAdw1IXSUuaq3t0nZ39brJcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V0336ok/; arc=fail smtp.client-ip=40.107.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jl2lXX6Tx1+w2oJF8yTEqwO6ukRijLVmvTW6enWJJ/r4db/KTed4fgwBYfyz6PIoxFlhNtNwXCx5Pwz9oQaPTX1QqqqHLRJ88PQz6nsrTBjBhjm3hr9UccQmD3ZCBKzFLEdZgYdPnIKMRvGOsAkg8FdiKw0bg44ktDk5CcEL+wc2g/2AZe69+/tWdZyPQABv/Rj7bbZ1vv41+6fJezv5mpSjUsm0+GqTjXOeNODLDdiUI4IM732X13PwEK1kFMk4GxWuOm15F+vMaNkCPOxqVaxwRPo2WBBaFzShcm58ObhnAtaOHBdGO8m/yI6SISFpmQao12p0bM0QEirPmKMFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsT4Ckp2gcVbXUtF+Y6kztgrnG4ZWjW5l6Mx5+I6Jio=;
 b=csyQMYmo3725/uD4sQFWwceYPlotAZbtOSRkZo/SsELQAog3eY1+c/kBo0nt6iF2/GNuUPzq5yaMW99IedV3AM5OUSCka4GhUX+w3YN/n5MX48bRQTstD5e8LijjGE/DSY6fN+yHaFSzpAVxDDAwtLon7YeczGdUcyYmZX00ovCyMJm0Uly9rNZmfFmHxIJHDoMJL/5gd1iodrd9KPoC88eiefH7Mh7ZsrVooc32MDL2bdMaG0mlKa0YqJgCXn6LF8xLymCD2U4uJnJ0ev6KV9BSsg3scmbjGIRksAf1pindACFL+fNi/huO3ZU73DFVJ5oXq9gZ/4v9MrctLxV7CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsT4Ckp2gcVbXUtF+Y6kztgrnG4ZWjW5l6Mx5+I6Jio=;
 b=V0336ok/R/xziAsH7XB9xfHWXOloCDBzpEWXtOpcIP388C9XR5BfxFY6S0d/XOKGxZ+bkQXW+GegkJQ1IXF+gAyk4UUuKeMLrTtrJrDoVdqcW62oxrCkf3Cy13DacdACCZ8MjCPn4y8CbsxdfQ4gRRFKJEQKSmMjYrHYe4vSjiF+VtQqxx7MjzmWFZ211YzwbRGomVE3T9rxvW92UgBjayLs2/HCGUlw2kOFivjGZKCj0+styqHbF42Hyyp4CkD9AkUW5MxHJSHjhCwne3Y1UMkyqGDUhpG0cRX2kCJOHne+jM9Y3HCAcQLKhXi8t2OHTeD0bbO/JAsbBbokqA6a7A==
Received: from SJ0PR03CA0226.namprd03.prod.outlook.com (2603:10b6:a03:39f::21)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 18:50:43 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::89) by SJ0PR03CA0226.outlook.office365.com
 (2603:10b6:a03:39f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 18:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 18:50:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:50:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:50:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Apr
 2026 11:50:12 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Shay Drori <shayd@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, Kees Cook <kees@kernel.org>, "Daniel
 Jurgens" <danielj@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V4 00/12] devlink: add per-port resource support
Date: Wed, 1 Apr 2026 21:49:35 +0300
Message-ID: <20260401184947.135205-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ec6932-dc5a-4d26-dc57-08de901f93cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7ia2RkSV+wYncwRIYXqwYInzd7x8KC7ghuJ+2/DuhDFdEQV+y79bOvaL7BjY7NlVMoZ/8vwl+GeKR5in9gNUXZm3QAYX35m9dsG+YOi+6bvvnWnnqp3QX+ERbrDR13tjCq+3iksrUEIQZREoQWTaKMoJpAdZJqu9ijfHLEdy7b6plw0N5WtIdtt/9RC2ToHw4VzZNJUf+2PteQQbXcYW8VAF9OrSkGbkv0oCOGy1Z6IWp5B6zrpDMbHmpAjUWk7If1wURAJxWnjVgsd4frJpY3vY3FXnImuzlwvnXFnXUnVH5SBmWs0SgXW4YQ7hRszBBYJ0OFpZgt370wWIeIrqniDPPfkcQ4K0piau5B6i50dn72D8otpkev+NdbP4RZElWrJv0LFpcawg0+5yGRioBHks5iFR+piCzVE7Be0B5eLDtE0Jt9dALCPFRoqgxuft0XBLM3UiIfFUSLJPK09GEwMCqcX/ntEGVKMF7x4769DdCmfdSFhUOKUY3oDHIiqrXhW9QMcgBTajPUQ3p+GIJ7jwJtkVMXmmS7htNm6Pt6x9gAvhya9qZnT/2lEV4dOfNpwuQKAhTZK8yas2HUdEL/HmWtYYOzCdAtpSEEips6sKiY+j0JVhQ3htxON3AqcSeSzey7YGaaQHjZPVb+lBGITKdDZYFvPYmWQjNCelSe+1AZH4kiqhwGbvE0WsNp1GOoTyl/nwdWbrsMIF61Ul9vOD0id08oX2QECoELELxcvIEB+c55e9pqnFndLOneLMH8mYKGNCNyrTzJZ5bY612w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	veIYdyiSm43UBdntzmAl6hL/n5ZD4ewbLYH449QHeaoAqWCY59NAxwgMPIzWXvHwLLEbb2xr1UZvWIkEuM3/WM+nY23piGgm7tBgFYozPKP/CCz6g5xxehVUwRp0yPgnq8pW5BI+/DNjv2SgTZBsw+qvOIoJA70r7t9BeQkSBVAVzJ1gioUU92UXE/m8C6Jfh9kbITkRB0q1Ahr1DGxLvLrAv62IIgR42L8qJAiCSoxso8NHywfYLZ6BrV8UimJq7JNpw6Xx9mzArqMSXWSoRXeY5NSN1yj63EgKqxzxJ1PT8+1abg0b38F1M8dcFrGZ5+PiUJDuaB77kP1xrefIgJr/jnrX0XujWSirQtezfWnQV+bu8RPkXWMIDxr+XeoORU0HHyqElzSQrr7rh/ZWTlYCfBrsCM0IC/iWNR/BKcaAl/Yq83huT9suQtWUbd4d
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 18:50:42.9861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ec6932-dc5a-4d26-dc57-08de901f93cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18910-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D3F6737F6A0
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

V4:
- Link to V3:
  https://lore.kernel.org/all/20260226221916.1800227-1-tariqt@nvidia.com/
- Remove new devlink port resource command
- Add devlink resource show for all resources (devices + ports) via
  dumpit
- Add scope parameter to dump (scope dev / scope port)
- Extend the doit command with port handle option while preserving the
  legacy dev doit path

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
 .../mellanox/mlx5/core/esw/devlink_port.c     |  37 ++
 drivers/net/netdevsim/dev.c                   |  23 +-
 drivers/net/netdevsim/netdevsim.h             |   4 +
 include/net/devlink.h                         |  10 +-
 include/uapi/linux/devlink.h                  |  17 +
 net/devlink/devl_internal.h                   |   4 +
 net/devlink/netlink_gen.c                     |  24 +-
 net/devlink/netlink_gen.h                     |   8 +-
 net/devlink/port.c                            |   2 +
 net/devlink/resource.c                        | 319 +++++++++++++++---
 .../drivers/net/netdevsim/devlink.sh          |  79 ++++-
 14 files changed, 576 insertions(+), 57 deletions(-)


base-commit: f1359c240191e686614847905fc861cbda480b47
-- 
2.44.0


