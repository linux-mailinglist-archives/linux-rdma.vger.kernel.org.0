Return-Path: <linux-rdma+bounces-19821-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C3yI10r9GlA+wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19821-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:26:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 251824AA511
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 06:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C218301904D
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 04:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994E52DECC6;
	Fri,  1 May 2026 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MwuPDFGi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012011.outbound.protection.outlook.com [40.107.200.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01872D9EC2;
	Fri,  1 May 2026 04:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777609062; cv=fail; b=iTxbd0Munvgpwjq4dUgIURlVKRREWW2KQJJpu6G06z7a4Q75Ny2Jbx/4YTJucDKBmXl2A6BNeIQohp1sJr20EPxguILb4aAPcAlCTwJCQukpaYtn8KG28FeITSxICF/y+C5o4zZyIO1A3KOPHSIqsvVRh2f/mtL/MyAm6jFKJgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777609062; c=relaxed/simple;
	bh=FwPp7Xs/RWWaDZ8/IDPrRlkh3T3ku7l7F9rLHdeuIbw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ptcTsixpQDhLAzkNM2xbp34Yz1xN0qFBD2YZRmCdC+rx3MiELGgeuWNj8O8Vss1+nsbiwL6Y1aA6vryQNTcljCBJu5kUZkyLByIHuAZiIXWXBWOSVO1qIy+CuK1dhO/9EVMjvtDSVf7YeLoItsV0uW9pWfKLuMbq8QO5S7mFh4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MwuPDFGi; arc=fail smtp.client-ip=40.107.200.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGgYty0D38tSzBEao7kbpe8Lmp240yrLcNsmFV5SGdm2l7mJKOW0DzF9xFU7f9pDNnub1S0O8M9W8kOuvGE5SwNwpkSrF5T+VZLxvIKyLFLChUVMLzMefaOpL1yWGPn/k+/fP/fc44AZiOX0TzIb2bbQeqv7lpqKiUfAagKJGlvjxsT23RjMj7MZbqOZSJxTRBIEVNPA5lclXRSsWWVTkz9Gon5KO+4UAwIHI82iPZXsd2N1cTb1aOFXqzNYPcZGI2jUCeayoeYVKgS/blJYQnM2bjg3VXc7K/4piUuEAVCUn7e0NejQNZF+5Xf4hVg3z3R7cZafg4ZJ7iHPT8P8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb3jcAQAA1dP62INaFyrTkeXTiObtoIizB/9kUmd4SE=;
 b=S+xQqU0WyLccABInszODe0AgFLyTJw7GFpMW3Y7YzFsUjqxymcWd4zjf++QUUHMbHpPT9/OVTmhM01JD52VinsBxg5g54tjfn5UyVu4W4KV/yen6hThWoQj7lg3lSKTGmUV3AncVBFnWX+Ygd0qAOQPpt7kBec48c6fTBeRPcalUCWToOBcrURDdgDfbjcIS8NhrfKCcqGgFQ5V7uAlfD8SkzrIekxBOYnUziTtt6OpOM1KUZpHF4NOmz/84wQ8gM6wfZnQ9dww2b5TWN3VE1E2lzRiA8VSVk0ZZLsY42ObSa5aYVmn2Nuu4vI8OJo8U170Cd87H+wZxzNjawMNWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mb3jcAQAA1dP62INaFyrTkeXTiObtoIizB/9kUmd4SE=;
 b=MwuPDFGiEgo6Y8LLGGecKL/+SmuEGJVIseRTYsPAYwhl5GIIRIB6/bwNuC4z5ViOv3Ep+nYGrrBrNN7tuNcsLJF0c5Y6APY5AyyWdGCjTbg6bBbh3JNmAh0OetwRwsyAj3EjQf+8u5HBt4+Wl36Njue7Sc7BZgB9hLVrA77xRybSgFK19daMVjyyXlZ7yLEX7leA/YhYih1Vnk1nXTLAod5psAtnRAORANYVzWhx7WnLVQKCTu7yDFzWBtGDQ+eKXiLnDFiiowtVTRwbw5l0vzl2ifZjjeRJ1QXhFQau1gVcu5C5jQRBM5TzeYodV9mt2cItZvbxHpNKa7V5ZiALVQ==
Received: from MN2PR08CA0009.namprd08.prod.outlook.com (2603:10b6:208:239::14)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Fri, 1 May
 2026 04:17:35 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::2b) by MN2PR08CA0009.outlook.office365.com
 (2603:10b6:208:239::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Fri,
 1 May 2026 04:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 1 May 2026 04:17:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:17:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 21:17:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Apr 2026 21:17:12 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>, Maher Sanalla
	<msanalla@nvidia.com>, Simon Horman <horms@kernel.org>, Gerd Bayer
	<gbayer@linux.ibm.com>, Moshe Shemesh <moshe@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 0/7] net/mlx5: Improve representor lifecycle and allow switchdev by default
Date: Fri, 1 May 2026 07:16:26 +0300
Message-ID: <20260501041633.231662-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 0698054b-b85e-492c-051c-08dea73892bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	E+o1o//j1hZhctsp3AYYh7+HvjFWizBAx/Z1fd9Xs86dAqDOk1mUZ6F62U+ADlthvx+gLedsM+/utLYZwQU9/zooX/fowjoKxl1CtswyengHSUdx9KaB/+s8LxZ5Y0K/5njFr4Pg8TPIoVLvhYf6EHXgW44benNJybLsgFCOfI3yWxzYb0A8ramOfCZOVNaij808qwznqYyDCD2KAxEEuGr0nVdKO8L/jyJGEx/fg2GS9Bo4FvebNRg0+c+ceeeFUxmrinoxP95KQz2kkMH4iu5U/dtnwJ8mnTDdYjMdi6e/WqjM971GzqnAMG/lxcajo8MT77UGAJbtvm58lTSQ1RqNH/9k1N4oODYZwfF3s4PmonC71nhyb45+m15ff/cTG2v1BRlptr1SPxyLyZRkOQ6HiyVaBJOsnbF7Eyb48dOlHfMGz2zzuyzLA4xCNZkRSxdKzU1olpkJHZgamCMWjfvAofKB0xvKzXcbnY2zsM0RpAAEH8CfWAAGms1VCdjWcCACCwg8S4K6wavI1rwKATBmEvsYuzPYB3wk/n9git0DhqwxnCWJaeE4HAdOd0CJNdIVS/IMfyAH8uyCTi0EwNYYr4p2Jr79WBPG6QyFGP1Jup9RHOCVgyYZJnlRn1fWrYS6juICGu06tC8O2b+o8eoX56QLJ7Deb06oqeX7NXpv6bTOvUJ0XJ5YRTOCC854R4O4pVlfPuT4taBM+51kQQ67TxcMY9WI7RwxzMs3X/Xq8W948WY5dj73URudHdy6
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+c70JGvTKjsH4JOkyjCaf+GCVG6HdHR3Js5Dt6FtWnx3R6HXs3jaiNoyNW24P050KLPLG3Kn4GBP6MmnLHvUDTn7QOjoqXIXhnY5P8HjzYprHzpBhDOAj858/dBffpmk/ago2PbkKP6JfNZjU6yzjF408e/QRiMrFX+6Pby9HfuZAikz/FQ/YpGNnYpflpECFd3K6bLj/Y/uiQn5b8IjtYiUd45kcF+OAV2QcPJMak7hRBrf+6mUbq6utxg3p3GObXKmFAKXTqkShNI+J4RzEsRgeUSUstdgS9zU075zB+LV5Oa+n8x/qeY9pYKBFj773ROL/+n2XcvKmXNqyWNxBSAv+aUidbS++VpDty+nI+WrZ5/UVmJLS+hY4dCtdl4L4KMwwysISGG2J8c1VpKo0lgOw2DycnsOEcvNHW+l9aYV8HKud01sRcXdS9h4XP2A
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 04:17:35.3147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0698054b-b85e-492c-051c-08dea73892bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676
X-Rspamd-Queue-Id: 251824AA511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_FROM(0.00)[bounces-19821-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Hi,

Find detailed description by Mark below.

Regards,
Tariq


This series addresses three problems that have been present for years, and
fixes one representor reload error-unwind case exposed while making the
reload path reusable.

First, there is no coordination between E-Switch reconfiguration and
representor registration. The E-Switch can be mid-way through a mode
change or VF count update while mlx5_ib walks in and registers or
unregisters representors. Nothing stops them. The race window is small
and there is no field report, but it is clearly wrong.

Second, loading mlx5_ib while the device is already in switchdev mode
does not bring up the IB representors. mlx5_eswitch_register_vport_reps()
only stores callbacks; nobody triggers the actual load after registration.

Third, deployments that always use switchdev mode still need a manual
devlink mode change after probe. That makes automated provisioning more
fragile than needed.

The series fixes the registration race with a per-E-Switch representor
mutex. The lock is introduced first, then LAG shared-FDB and multiport
E-Switch transitions are adjusted so auxiliary device rescans and IB
representor reloads do not hold ldev->lock while taking the representor
lock. This keeps the intermediate commits bisectable before the stricter
E-Switch serialization and lock assertions are enabled.

After the LAG ordering is fixed, all E-Switch reconfiguration paths that
create, destroy, load, or unload representors take the representor mutex.
esw_mode_change() deliberately drops the mutex around
mlx5_rescan_drivers_locked(), because auxiliary probe and remove paths
re-enter mlx5_eswitch_register_vport_reps() and
mlx5_eswitch_unregister_vport_reps() on the same thread.

The shared-FDB peer IB registration path can hold one E-Switch
representor mutex and then register peer representor ops on another
E-Switch. The series annotates that case as nested locking so lockdep can
distinguish it from recursive locking on the same E-Switch.

For the missing IB representors, mlx5_eswitch_register_vport_reps() queues
a work item that acquires the devlink lock and loads all relevant
representors. This is the change that actually fixes the long-standing
bug.

The reload path also learns to track which representor types were loaded by
the current attempt, so an error does not unload representors that were
already active before the retry.

Patch 1 is cleanup. LAG and MPESW had the same representor reload
sequence duplicated in several places and the copies had started to
drift. This consolidates them into one helper.

Patch 2 adds the per-E-Switch representor lifecycle lock and helper APIs.

Patch 3 adjusts the LAG shared-FDB and multiport E-Switch transitions so
auxiliary device rescans and IB representor reloads run without
ldev->lock held while taking the representor lock.

Patch 4 protects the E-Switch reconfiguration, representor registration
and peer IB representor paths with the representor lock.

Patch 5 fixes representor load error unwind so only representor types
loaded by the current attempt are unloaded on failure.

Patch 6 moves the representor load triggered by
mlx5_eswitch_register_vport_reps() onto the work queue. This is the patch
that fixes IB representors not coming up when mlx5_ib is loaded while the
device is already in switchdev mode.

Patch 7 adds a driver profile that auto-enables switchdev at device init,
for deployments that always operate in switchdev mode and want to avoid a
manual devlink command after every probe.

V2:

Split v1 into two parts: the E-Switch workqueue deadlock fix and the
representor lifecycle changes. This is the second part; the first part
has already been accepted [1].

Patch 1: Add a cont_on_fail flag so callers can decide whether reload
should continue after a failure.

Patches 2, 3, 4: Replace the atomic-variable based scheme with a mutex,
per Jakub's feedback.

Patch 5: New patch that fixes the unwind on representor load failure.

Patch 7: Switch from profile 4 to profile 8. Since the profile mainly
targets E-Switch handling, keep it separate from the NIC profiles.

[1] https://lore.kernel.org/all/20260428051018.219093-1-tariqt@nvidia.com/

Link to V1:
https://lore.kernel.org/all/20260409115550.156419-1-tariqt@nvidia.com/

Mark Bloch (7):
  net/mlx5: Lag: refactor representor reload handling
  net/mlx5: E-Switch, add representor lifecycle lock
  net/mlx5: Lag, avoid LAG and representor lock cycles
  net/mlx5: E-Switch, serialize representor lifecycle
  net/mlx5: E-Switch, unwind only newly loaded representor types
  net/mlx5: E-switch, load reps via work queue after registration
  net/mlx5: Add profile to auto-enable switchdev mode at device init

 drivers/infiniband/hw/mlx5/ib_rep.c           |   6 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  10 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  12 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 186 ++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 171 ++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |   5 +
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  18 +-
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  |   8 +
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |   1 +
 .../net/ethernet/mellanox/mlx5/core/main.c    |  43 +++-
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |   5 +
 include/linux/mlx5/driver.h                   |   2 +
 include/linux/mlx5/eswitch.h                  |   6 +
 13 files changed, 405 insertions(+), 68 deletions(-)


base-commit: 4e37987362bcac8909f2d4b4458f3aa645e41641
-- 
2.44.0


