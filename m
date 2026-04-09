Return-Path: <linux-rdma+bounces-19150-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPSBOTiU12mGPwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19150-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 13:57:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A69903C9F1C
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 13:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE6FE3006115
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 11:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191003C2787;
	Thu,  9 Apr 2026 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TbXFvzeV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A68C3859CA;
	Thu,  9 Apr 2026 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735811; cv=fail; b=pkDa0MruRCJEX3xucjPyj799oM0TibTArMqqwlwaLFAVo5vXRCPqJubqQrIv5KEv0KmkgbXl2OlznoKuDpTkSuViE5REd0laOejvAnqL9aXhBLFPNMC/aNojlKB/+a6Q6Hiyzt6Qfa+cQfbbouHqqbYQd6yHo8Lxi4cYE+IR+F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735811; c=relaxed/simple;
	bh=sfNBkpH9YgXYuFD28iJaFJeh/ICFG3jE9lvhIxqWTFY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Md9D0PR3Ry3ZDm9z6m/9W5w76EXdynP0v7liyADSoN76uTB6+zpypG26nFczbBKtL4JEK4hQ951J0HUhyyvvEv55+XH1VX+TSrSFCLxKy+JrvRvLdfBFYDHWONrBdFgihb3mOot+U8U6omrBc+4uKST/yosZv5M0hcnO9eUVU2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TbXFvzeV; arc=fail smtp.client-ip=40.107.208.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlP5v2890+53zNNR4+lLD1fliJF4lcMvkDULqn+6C6WYwIP8ppMWa4bbEWZMHE/uO+Zb1Uw+BxK9x7zQo+HQmB+69dwguX5wIYCePmjomwMETHsOHmbjNvbwE4lxGeZmiAaYckOHuGqtsWe+4PLVef0NvN1619SRvV24ANVxpoglRKKuRw4BhtGP0lyYEM/q7Xy9JZIkWmrdaG8iXjQsBo4p+LL66H4o9EckiVOF8Pumisklz5sF5xflrAgqaxPQpz64lc+HLA33WmTyMUCIWCJYP2JuIdBWipR2YDFwxlMj+rb33eD9miLKNuK1ILQzFJaqAL+k6LTHM/sqpf8ZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=876w3Eudbe4OuXdZ3AHJEIlQSKWum/8BAmTxv7wttjU=;
 b=itsyfc7CNPStaW/WRTcH5AKpByNKFwaOx2png+i42ZLEHozcWcoX/wfiel42PxMGfKTYB0No+HmXJ8TbOajHyCKlOiSvQf/2nbgMVVaEF3T2YtJ2B7vzClYbpDFst6QSMmm/bKByazdwTmRHls1JnJ3h6PNjJwGi5tFlIBg2903HA7Vr3MMEtDT9RmBqUKV4wxx9oAzenFGXK4AczW3YK4HhJ7Ur/NUmkGagZvFVRcxtBhEOIw1cnl4knU7EUkg9esGtOdeAgj6+Z5YzpHjqRElU//b+r+K+7TOcH24VkL/YS8VL2E6pNoahKidmLwQtM5yn2UmFQ3yQtCcmStVKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=876w3Eudbe4OuXdZ3AHJEIlQSKWum/8BAmTxv7wttjU=;
 b=TbXFvzeVygbX996xRhrJypMUappWNLekM9NCWjbWkVoxMRorBA+rClpjGK6bMy1V7L5KjO7a7Mb0Duc4xjZFgL4FqBNwIIMWuKT1da8VPas+/ytQFR5g3J5e28/JG2UIGOvvg/cpEDmxXZJYnU1A1adeO/qw2rP2+bgcXlf6VhWA6gfchxbBML8Khl6pswldM88hV2AzYici/8MXXCLNH5V2aTPvYP70vf9BKqSDilfoR/OUBWov6y1avjQBMu2Krcey6FoxAlL7bwr4/JgYmD6VhEzQBYF+VBvYTN4CZuy12xXQNN2klc5llpZVVF+av1QkeofxjhYRAQJNy02WNg==
Received: from BY5PR17CA0035.namprd17.prod.outlook.com (2603:10b6:a03:1b8::48)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.41; Thu, 9 Apr
 2026 11:56:44 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::ee) by BY5PR17CA0035.outlook.office365.com
 (2603:10b6:a03:1b8::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 11:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 11:56:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 04:56:29 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 04:56:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 04:56:22 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Gerd Bayer
	<gbayer@linux.ibm.com>, Parav Pandit <parav@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 0/7] net/mlx5: Improve representor lifecycle and fix work queue deadlock
Date: Thu, 9 Apr 2026 14:55:43 +0300
Message-ID: <20260409115550.156419-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3885d6-e526-4afe-21dc-08de962f11b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GpuDOPjgtFOaLhU57QgDVftslGl18nMUpDsHPuMmdYZrPbnuy43/l1BGMN7sc8u1zCtv23oTpBabANJ0JH2viBrswescbrhnoVyEnvZ2lr6baG8K66on5bsNEb6WA6pDM7EuE9qMaX0uJtO+pxerlEzu3tatyRYe81knuj7FblJc/Y9CBeo1l0qvKXjKLC1r+Qt+Ycs3vVIXEldYqGJyX7qaW8fQHR1CrDz3wmo1cB1nsEGWDq6tdblyvgryp1Spar+TM4C0WOPWOXxVO3ooek7uyKSfmD2V/5qzDoXNdpuVUD0YepTTrvUOJpakjAG5YgBTaqGjnrrT7Ri9wRTUl9N9h8x/QJBREljZE9333rxTLUR/yiBAvnORWFK1fpOe9X4hTSRbop2pFmMybtaBZr3oxgbGqbFFXUU9VKHW3qD1fNOkjrHRIONf2bxQbUCYciZkKSD0SQK1U/GE02Fn+iCzHTIb+7QIRdaZo+L9J2d684EDVbPdwfdrLgruVfZPO3eke825xrAbSJWUqPcVGn9KQSOCqAG7uSrFccM9l+yysUQJCIjn/6wKKZpYul5ZODnIeB9GbqUn9TExo9XSOKsg+vaT79E7G54h0NsOMJAR9oeT3tUQXHh58Lv6b61VfVa0W5dCE6/lIanRZLepMVP3bNgarlSmaCwucLYpC19ZF1xx3pF8Z5bnqp8OGiMA8Mx4HdaMwFiaoYS//Pk1O2mtNM1AsXOITP/p8jOOiNBY9A691rmKekYF5VazWn2QwltSFreFUu1YI7czYiorkw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TkCVBHolavyzA9Esss0AqJhD23T2yLaSjCcXdJyFrc+YYn2H+czYdh5aXXlFvsvym5SrBC1DdK2bhEXzIkBdOl2qfE2Gg6mY1klnrG170uioodsWrZlmV8VEaFqstNwQX1eyBbM5PPKqprF5k7wKlWI6s1BPc+4NCsq2eO/kZHgt82dKGdSz0SgnGzFq2rAMufUX2z/8ckB3xaACVgNMPhuOV1/W5FafO8P/LXLlFoY1fy05vcMzwe2qsSTfkQtcGIRQWm9B5jaAwz8Ddvhl7ZtJ/uU5rWMlFpLhdzLTqzUbpc3cLIJsHTaE44Cxw+K2B2o4txPzD8eYklZMBPcjT9L3BURZ43+HXTNKm1Khn4f+qMUY/NEcaJAP9gUrfZ67X+3+9STmB+O1jG4Ad7pKjwgGACxFljSQDRgqV4sg2llOpK2uwuNN1ArIkRrK4bIx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:56:43.7625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3885d6-e526-4afe-21dc-08de962f11b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-19150-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A69903C9F1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

See detailed description by Mark below [1].

Regards,
Tariq

[1]
This series addresses three problems that have been present for years.
First, there is no coordination between E-Switch reconfiguration and
representor registration. The E-Switch can be mid-way through a mode
change or VF count update while mlx5_ib walks in and registers or
unregisters representors. Nothing stops them. The race window is small
and there is no field report, but it is clearly wrong.

A mutex is not the answer. The representor callbacks reach into RDMA,
netdev, and LAG layers that already hold their own locks, making a
new mutex in the E-Switch layer a deadlock waiting to happen.

Second, the E-Switch work queue has a deadlock of its own.
mlx5_eswitch_cleanup() drains the work queue while holding the devlink
lock. Workers on that queue acquire devlink lock before checking whether
their work is still relevant. They block. The cleanup path waits for
them to finish. Deadlock.

Third, loading mlx5_ib while the device is already in switchdev mode
does not bring up the IB representors. This has been broken for years.
mlx5_eswitch_register_vport_reps() only stores callbacks; nobody
triggers the actual load after registration.

For the work queue deadlock: introduce a generation counter in the
top-level mlx5_eswitch struct (moved from mlx5_esw_functions,
which only covered function-change events) and a generic dispatch helper
mlx5_esw_add_work(). The worker esw_wq_handler() checks the counter
before touching the devlink lock using devl_trylock() in a loop. Stale
work exits immediately without ever contending. The counter is
incremented at every E-Switch operation boundary: cleanup, disable,
mode-set, enable, disable_sriov.

For the registration race: a simple atomic block state guards all
reconfiguration paths. mlx5_esw_reps_block()/mlx5_esw_reps_unblock()
spin a cmpxchg between UNBLOCKED and BLOCKED. Every reconfiguration
path (mode set, enable, disable, VF/SF add/del, LAG reload, and the
register/unregister calls themselves) brackets its work with this guard.
No new locks, no deadlock risk.

For the missing IB representors: now that the work queue infrastructure
is in place, mlx5_eswitch_register_vport_reps() queues a work item that
acquires the devlink lock and loads all relevant representors. This is
the change that actually fixes the long-standing bug.

One thing worth calling out: the block guard is non-reentrant. A caller
that tries to transition UNBLOCKED->BLOCKED while the E-Switch is already
BLOCKED will spin forever. All call sites were audited:

 - mlx5_eswitch_enable/disable/disable_sriov hold BLOCKED only around
   low-level vport helpers that do not call register/unregister.

 - Inside mlx5_eswitch_unregister_vport_reps the unload callbacks run
   while BLOCKED is held. The one callback that calls unregister
   (mlx5_ib_vport_rep_unload in LAG shared-FDB mode) only does so on
   peer E-Switch instances, each with its own independent atomic.

 - mlx5_devlink_eswitch_mode_set acquires BLOCKED, then calls
   esw_offloads_start/stop -> esw_mode_change. esw_mode_change releases
   BLOCKED before calling rescan_drivers so that the probe/remove
   callbacks that trigger register/unregister see UNBLOCKED.
   esw_mode_change re-acquires before returning, and mode_set releases
   at the end. This is an explicit hand-off of the guard across the
   rescan window.

 - mlx5_eswitch_register_vport_reps holds BLOCKED only while storing
   callbacks and queuing the load work. The actual rep loading runs from
   the work queue after the guard is released.

Patch 1 is cleanup. LAG and MPESW had the same representor reload
sequence duplicated in several places and the copies had started to
drift. This consolidates them into one helper.

Patches 2-4 fix the work queue deadlock in three steps: first move the
generation counter from mlx5_esw_functions to mlx5_eswitch;
then introduce the generic esw_wq_handler/mlx5_esw_add_work dispatch
infrastructure; then apply the actual fix by switching to devl_trylock
and adding generation increments at all operation boundaries.

Patch 5 adds the atomic block guard for representor registration,
protecting all reconfiguration paths.

Patch 6 moves the representor load triggered by
mlx5_eswitch_register_vport_reps() onto the work queue. This is the
patch that fixes IB representors not coming up when mlx5_ib is loaded
while the device is already in switchdev mode.

Patch 7 adds a driver profile that auto-enables switchdev at device
init, for deployments that always operate in switchdev mode and want
to avoid a manual devlink command after every probe.

Mark Bloch (7):
  net/mlx5: Lag: refactor representor reload handling
  net/mlx5: E-Switch, move work queue generation counter
  net/mlx5: E-Switch, introduce generic work queue dispatch helper
  net/mlx5: E-Switch, fix deadlock between devlink lock and esw->wq
  net/mlx5: E-Switch, block representors during reconfiguration
  net/mlx5: E-switch, load reps via work queue after registration
  net/mlx5: Add profile to auto-enable switchdev mode at device init

 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  25 ++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  15 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 204 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  46 ++--
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |   1 +
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  12 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  26 ++-
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |   5 +
 include/linux/mlx5/driver.h                   |   1 +
 include/linux/mlx5/eswitch.h                  |   5 +
 10 files changed, 267 insertions(+), 73 deletions(-)


base-commit: 9700282a7ec721e285771d995ccfe33845e776dc
-- 
2.44.0


