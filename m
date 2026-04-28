Return-Path: <linux-rdma+bounces-19620-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJpyFKlB8Gn1QgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19620-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:12:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB3747D79C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AF023031AFA
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 05:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E129C325;
	Tue, 28 Apr 2026 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gVynMsf+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8112B67E;
	Tue, 28 Apr 2026 05:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353071; cv=fail; b=on180CK40Qw9n6FxVSQ3GhUipKkDu3BmJE7hnz35125p+ScOoI+GJhnn0mkv7dm8A+DHG2wBfI0Gwld7a9gLUKb/iBYAwBQEs2zIUouvlOhE6FwaWrrLpVvK5lnnmPL6VkMRnCpKmCMwljZazyut9gFjN11AxjiK+1EW+XGhO8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353071; c=relaxed/simple;
	bh=yk8gXsBajrtkMkN0DNiHQywTB/sbokKYqyqcH1w6Tsg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gezxXCWHAFpSxOFNAYdHe6IZ9VuaYJ0/ZcI247YXQqAtCcqKsTRnScoYEGnnrBrNzr8p99Q4BNWBT43c0x+2Jiw4OicSfMB3JjArHaZzNkazncFdgTvczxnKOY1+RXRMsSXr5NhTxyZNra1KBEKSZNrdhMpTDcnXata4MNJOoSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gVynMsf+; arc=fail smtp.client-ip=52.101.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwO51UIlkM3l59fVfIEaW1Fd1q3RParPnJkvDd2U+xdZoMPbLP6Jc75QuutgC7AYoeKQA3PVK41K5eVVXOPzeSFI1XRfqqLBCVkIPXYIS1yjgrTaVc/cc6zFwBBT4/It/eJ/0xRKo8oKYhVF14jIimJG5Y/0T5OCAY4H67AXTIzcrw/6yajctJLOk6n/2JpEjSd34XRkcMKRgL+0s6TikVeP0Y7cUbCV+aHamfu+Fugp7W+rnmp2S1MoSzB3pAm1m1p93km7KZvbXmMEp2Lw2le7akd0ZQy5O6rWHCwk1s7thLbGcubLneOzsDp7BIpy1nNy5NNZYHgn2aHJhSeuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipXz+YHmmVBUSTZWkrSSjfACvHxL9OrqEgsX5HKIODo=;
 b=vfaKuOcOeZxV4c0DC0UFJC2CyZfY23nxCHeHQIXCH/G72ig3fo3fGmZQ4Ie7Q3AHYzqiAIWazbsAIziny5lrNaAJHW8pxOAzjbH1AEO0xF9WMAjpu3Dq79BSXXBRCD7TGvDz2VQcYZFGwUmp/cW1gKU3hWwP2R506D4fEzL6YyKoQATMfSEvyUvVm5+R4dnv7EaJ5u/w6achNU31VDhlWPAVmyrf/O/cYfI3Pm67c4V8HOc4EvTTBAR/Bwa4r9QK7SoMexdN9Mq25Ka5dTYYQBpw6FaFn9auB2EIOBbN9dhTR93ydPb6relT0j60xL3bjYeMzbnH3NIMjx9ZJTdTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipXz+YHmmVBUSTZWkrSSjfACvHxL9OrqEgsX5HKIODo=;
 b=gVynMsf+Cvr/2378VkM8pno+xNC2euNwamHtd0xYef0T4M0badZWlswitbdenQIeOgWwiJ6ZM5TTNW9CgIh8eXBES3uuIxpzgoeOe/fnWjm7D63gPF1O1IiXHzbgPEaZgDTvYrtja24AdDqXian4l3Ht5eEUsVjAfYEsdjBLZoQy3eEdkTlEXB5B3I1M7uZo4jrVP7hVomZiOJjiUKgBjP5q5/C/UF3echmQfEmdtD9d2+2weRq7W4IdherKbWcHG4aqXFh4P7VeGwiNftxXL5TsRQJKECv3MvVTdlXacn5L3Uc3Gjiy5NJBK0ImI8AYJ8tdNrhOU4/EJ/o4JuDLJg==
Received: from MN0P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::9)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 05:11:03 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:52b:cafe::58) by MN0P223CA0015.outlook.office365.com
 (2603:10b6:208:52b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 05:11:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Tue, 28 Apr 2026 05:11:03 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:10:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Apr 2026 22:10:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Apr 2026 22:10:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V2 0/3] net/mlx5: Fix E-Switch work queue deadlock with devlink lock
Date: Tue, 28 Apr 2026 08:10:14 +0300
Message-ID: <20260428051018.219093-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 72be9a3b-9397-40b7-8f92-08dea4e48ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	SLwX4VbMiQAtMplwIFK6UINfHXP1lZkDp43MfIEuYw2Q9XvTdTHWfge9qrTv169QPtpQcq/eQbjKEryAiiPcGCPMa5ybnbaksfmMaUww1c+sMzhChdFSIZ6xSm1AJQLwpBHjiM9eU4zrUxwbkQ5Oe1qb4bbgBjSLEd6ohtOEKJG7drVPqdXFbmJ5a/Iy4s+o7ZkfltpU+Y+UKbTD3qx26CkxA9ZI3axxJAAs5VTH5Z4f2LCRT9NYSs8Q/b1hmvkad6Aqz/DNojXD8X6l82FWqVRimFZPSxuH7MFbe0mdyXbnn4tPeHtmv7hpMmhHlm0LhH83Wyyha/+N1B6+lGk1+l5bTowkS6KtR3RchuTTd/IqKyToaFBs3q6fQSDJYtOqAW7Iw4yspqjJVkyTbNnAUCKaTbNmWYiDFoqLNmdn0PEjUJ27H/V/QPFxZ86Sniew6MrL/H5lGxceDb95uBq6bSBWMZscVaG7UwIuZORO/yg+p0b2Gq0dOCPnawgIiU0HCV+7KnxLWwNsVyJwPpwFvon09mVlSBJMWYz6zS63ordGPFzWfEXe7suHnOTnUn41HEb/9dG5MH86rOiMWweXQcyYRrQksk/9orMJehqF6J6cukwaZ0qlZdwIh1+oPEG/vt8Bvg0Un4YKseQ2cVsYW5zQp703lGTtUvWU3etb9P7fuBXB+R/LlBhoe7YY1thtAM/CyuT+/zqmaW34LZYhwQnphvY+kuFVJvqMz/bDGlQBm/m3dGyptNeHc22NDhDsz/TkPson9ENMRMu30S/HcQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZpTGOjdKww6ynlZbR8EOQD9WYZZY7mKt+C8D3xONtSWJDvZqxG8hUkgSeO8+cf6WnfVVAffl5R1CC0+3AxDbeJhFXEIP43Huw5XMS3ZHh86ploOljYtYTwtRmte/DhWRbPL82XrYGTyen55zDzriyehpcioLRyicfvBDKRIxyU3qZMOorhLtqRS2BQiJ6MmEuqlIvYqgMtdtVB8joNwdRtmou/uoJL8wHyzjdQxi1HJ+QWMrBOqRLEX4exZSBl3ss+UhoKSxgHHbN9HISU5LSXbklIImJkAjgL3gvZ5rehYwcBZE+qp+Vtc9Ewse1xffZ1Oy9Npljqd1KcCONxVuTsEpy5ph0AXrG7ycy5SSezbTFA/bXJ2EpbFfONmKHirU0LB40hgNLnZTVKRuE+1DMLqYOjbmWefM7OcxYtr86NsMgLpVLjibvXDb7nFatHwS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:11:03.3780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72be9a3b-9397-40b7-8f92-08dea4e48ba6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
X-Rspamd-Queue-Id: BDB3747D79C
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
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19620-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Hi,

See detailed description by Mark below [1].

Regards,
Tariq

[1]
mlx5_eswitch_cleanup() calls destroy_workqueue() while holding the
devlink lock through mlx5_uninit_one(). E-Switch workqueue workers also
need the devlink lock, but previously took it before checking whether
their work item was stale. Cleanup can therefore wait for a worker that
is blocked on the same devlink lock.

Mode changes have the same ordering hazard: the mode-change path holds
devlink lock while tearing down the current mode, and old work may still
be pending on the E-Switch workqueue.

Fix this by making esw_wq_handler() check the generation counter before
attempting to take devlink lock. The worker uses devl_trylock(); if the
lock is busy and the work is still current, it sleeps on an E-Switch wait
queue with a short timeout. Invalidation increments the generation
counter and wakes the wait queue, so stale workers exit without spinning
or blocking cleanup.

The generation counter already existed but was buried in
mlx5_esw_functions and only covered function-change events. The three
patches get from there to the fix in small steps.

Patch 1 moves the counter up to mlx5_eswitch. Pure refactor,
no behavior change.

Patch 2 cleans up the work queue plumbing: factors out the repeated
lock/check/dispatch boilerplate into a single esw_wq_handler() and
adds mlx5_esw_add_work() as the one place to enqueue work.

Patch 3 is the actual fix: check the generation before the lock, use
devl_trylock() instead of devl_lock(), add a wait queue so lock retries
do not spin, and invalidate pending work at the earliest safe operation
boundary. Cleanup invalidates before destroy_workqueue(), and mode
teardown unregisters the work-producing notifiers before invalidating so
new notifier work cannot capture the new generation.

V2:

Split out from a larger series. The representor lifecycle improvements
to be sent separately.

Patch 3:
- Move generation invalidation after notifier unregister but before
  teardown, so old work is discarded early without allowing new notifier
  work to use the new generation.
- Replace cond_resched() polling with a wait queue to avoid CPU spinning
  while devlink lock is held by a long operation.

Link to V1:
https://lore.kernel.org/all/20260409115550.156419-1-tariqt@nvidia.com/

Mark Bloch (3):
  net/mlx5: E-Switch, move work queue generation counter
  net/mlx5: E-Switch, introduce generic work queue dispatch helper
  net/mlx5: E-Switch, fix deadlock between devlink lock and esw->wq

 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 20 +++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  5 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 96 ++++++++++++-------
 3 files changed, 82 insertions(+), 39 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.44.0


