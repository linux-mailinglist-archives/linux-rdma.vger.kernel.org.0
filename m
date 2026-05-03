Return-Path: <linux-rdma+bounces-19883-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB/4JdWv92k1lAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19883-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:28:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 946D44B747D
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 693153001A62
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 20:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DE9375ADF;
	Sun,  3 May 2026 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dm+vFQzn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E131F373BF1;
	Sun,  3 May 2026 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777840079; cv=fail; b=N2Bl9KMlEHPKAKeRa/DxCifc0on1c0O7+aJjg/3+Kc68qLKFGoPXql7I76W9QxwFy8iGbkmKMCTZIiGx/xdfeJV3ZK6Mh4icWyVvTgUYmW7XSm4lj8DoLYAZQcH8HWVXerqFvGl2ozF0vV+tZVTJpHIL9SqPgGhOW3X/6FEDmpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777840079; c=relaxed/simple;
	bh=NzJ5hFZfg8gJ7727H/zqN3z39BA3f10WA8dGGpSBOqU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fh6AhDoZPr+p8QkL1BWLoZ5UYJYrnSFpB9rLPssESaihIx0s32Z0v703DPu539qqfFocJMsZA5/AKNH8cVTO7V6STUlKZthZgN1SP1gEhaex+bxgiuZGAkKVseoFO2OvUopuztNmTxm+1c1Ffo3F7cHFVnTEqBJdKpzooapKadM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dm+vFQzn; arc=fail smtp.client-ip=40.107.209.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ureAeq6Teb5ME0nhBbsmIo4f1N3UBf/06c/tTMpnBsmUKP2FWouKQ46JLOj+aXqKZgeGsrI+UVc7Fla6G+bIkpDEdpb5PmLFXT0I9nGXc6Wtdb4RU57026chWu4IZNEY25YuWyxdCAMJIxhziJi7bE45/RBKg42VuynIm+6yLScDCHtZxAQ3KHok6UpxOVpIqKpbKDdDMRBFRWHFhicNgh3IHAf6WnTIEZMypFPrXJWJXJzkkJau+AllN+ck0NRK9WSMrNOnLwGqu4THNJLKBKFX8n3VOpnqdIMqdoyf6OuHEXBffw6uTWg3itShnoGu/k90NaBDY4XKtENuMbaLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAnMg78K27kOvxPSIEHDUVMEMQC2dvsQtz8BPZeUjMQ=;
 b=LaMfTvInW6VmN1uoKCOSWHc1hmouaFDwaz/I6nZIQv7QIUT+wFgQ2oXRrlSSiOxj7C2P9jAq2xieGZ2qEPQuqKHxqm7vCPfoNGYMKqnpir30SgyAdFnLmbZQDGQYXe6CDDkunBcibqhiVF+HFTpTn3nkujKAbwZv4il4jn/uXP8lz+V0Q65GgoJXwn9yx7I196qRHTpdv75w5TwNgrHSn/4Ha4jvIuSYdQ4Jl1uZEeB80bdno+Flso7GFHDfv7ooSgrQytElgVS+2nAHN7glk0fjKZvg/y8JIFsk6xbkAseHh1ahTe/LcTEk8rHmdpiv9CGRtyeNxEXmwykyBMlXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAnMg78K27kOvxPSIEHDUVMEMQC2dvsQtz8BPZeUjMQ=;
 b=Dm+vFQznDksiH6z0e5vfLRGDBmy4uJ03pWm0NdCQA5yx3uObCwrs8q6zKHWnnobQOBQpk6TBdYtk3U8Vq0piaDCsWT0fFK+sjYHCaaRJu3Fp8+oX/SKa0ASAuxT3gVKs1qYncppB7Bux6p0taFMvwMz/yGRAN5946jmF7YoUCYRBdlDW0xBCoBmLJaAVm7jDW94gNZIViTqKi9gyk6m54abqSRX+U0jyAbczIFjHw6v4/mUhzLdj6DrtYpqco9iLc75Dlu22P7dp3MuSUUV5jf3edJYul0rnJlOIOPuJo1cUiPZtvkiKKxYUYh5hailaL4nCUmtlYAtaI6Jy+IUPrw==
Received: from BN9P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::31)
 by BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 20:27:49 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:10a:cafe::bf) by BN9P221CA0011.outlook.office365.com
 (2603:10b6:408:10a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Sun,
 3 May 2026 20:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sun, 3 May 2026 20:27:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 13:27:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 3 May 2026 13:27:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 3 May 2026 13:27:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>, Simon Horman
	<horms@kernel.org>, Maher Sanalla <msanalla@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Kees Cook
	<kees@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V3 0/7] net/mlx5: Improve representor lifecycle and late IB representor loading
Date: Sun, 3 May 2026 23:27:19 +0300
Message-ID: <20260503202726.266415-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a273f5a-ab37-41cd-fca1-08dea9527198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8w7GECdRhehUVW1oLvEbCn66N2+yyYHK21B51EIZGXK+IWLQattVnZRw2MsLo0lRBkOfpVauOdZ0yjJ6ki0msQTwcbGuyMMFPBbUQwi7tQmRRRbUOyR4/PthmFh7tLcl5Hfy08BzKhf/J1VP99xqZ1pMYAx/DZLN0h0/7fzyxwTMp86Nmt8nX09TlUs1oEMPWO8JZWtuZvLZXsnf55B7DeFcDY3c5ovs+BKqqjByDmu7+CD+JjfMmIB4DWpjLsjBQdNrSxvYrAOrdzc6RpwqftO0WYVF1PWG/tsxXMx/ILdVK55NGFIn6F+OdzNUqv4HiaVldIM0XnVkCHpDAMJyn/07eMmDCnPzbDecmm90ob2s1Nhd0zRPrV4ykG65Xk3Tz42JhEfhpVqJRRVRoOLk4TqTESl80bXPDoSMOQhyAO25GoEk1x2I6Ww/Qpvguk8i1BTSoepyVSwQ8BLD/6cxG/m7tg1PZDA3vA6mBl+SG88lVuEPK0UHJ3zYXAkEP/xsxTKJUCNazDfgS3ducxgwCbXBI/KgMLIicgF1+Zrg1iAVAbzlUNX8MEhWMyYIEN2z83W56kMm3EqHjgNwRMRrIsJg8TOjHOT1T3u2vGhPAt+/e6c4uO12rxbhuI0BfrtWpJgeS2IC4B9TadFIx23yvwDPqy59qiemIxEu3EZYmbvUJ2hsK3vAR5vIKDBZGXqzyThn+kBjZqRATk5cbFA5xr4hgRfVQ4hWyZ+7eXOHGkIyxCUeWxIRJr+cZpBzukIJ
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D+HadE04r0RCqEtkEpn4u6vSzgpuONoOIUh5JfUFIHkTqBHYp86xbfqgAm+djtDphWvuNkkjdG4kzLZmWVuyb76EImB/kzKPJ+U4MsTuv6qRj2qfuKgi+G3t6CJ3k/KaZS2rfeCLO1pgP7r7gHV/ywZpEl8+A1klk3I5wWFRFwZmxuWQASzhJTsivrWuaj+vozFTo81l62KQZhU7RnJNRQYT8zOoA+BwzII0cVCvGOA/gdA7n0Fc31wqvvK/03OPflp7tu4bLtqhwSzl//1uALnW7lYS1CzsRhxNMWfRYFQ7WZqz1gEuWe5Cpe8fJoSJL+XGHNkySRD/NsyPsK/OuAhFpk1PV8lMuMdfdnR1486J4+4NymOI+vFjJC/rN+lBkt/V9E8A05L8tzyaAGmWhTVUz3yo/dnycRNzN6pX2ktQJ18aXBub7iwE5xiHBhxB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 20:27:48.9596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a273f5a-ab37-41cd-fca1-08dea9527198
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448
X-Rspamd-Queue-Id: 946D44B747D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19883-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Hi,

Find detailed description by Mark below.

Regards,
Tariq


This series addresses two problems that have been present for years, and
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

Patch 2 lets E-Switch workqueue callers choose GFP allocation flags.

Patch 3 adds the per-E-Switch representor lifecycle lock and helper APIs.

Patch 4 adjusts the LAG shared-FDB and multiport E-Switch transitions so
auxiliary device rescans and IB representor reloads run without
ldev->lock held while taking the representor lock.

Patch 5 protects the E-Switch reconfiguration, representor registration
and peer IB representor paths with the representor lock.

Patch 6 fixes representor load error unwind so only representor types
loaded by the current attempt are unloaded on failure.

Patch 7 moves the representor load triggered by
mlx5_eswitch_register_vport_reps() onto the work queue. This is the patch
that fixes IB representors not coming up when mlx5_ib is loaded while the
device is already in switchdev mode.

Changes:

v2 -> v3:

Drop the default switchdev module parameter patch. The proper user facing
interface is still under discussion, and this may be better handled by
devlink core infrastructure.

Patch 2: Add a new patch, per Sashiko's feedback, that lets E-Switch
workqueue callers pass GFP allocation flags to mlx5_esw_add_work(). The
functions-change notifier keeps using GFP_ATOMIC, while sleepable callers
can use GFP_KERNEL.

Patch 5: The unregister path now always unloads the selected representor
type before marking it unregistered and clearing rep_ops. It no longer
depends on esw->mode == MLX5_ESWITCH_OFFLOADS.

Patch 7: The queued late representor reload now calls mlx5_esw_add_work()
with GFP_KERNEL instead of relying on the helper's previous hardcoded
GFP_ATOMIC allocation.

v1 -> v2:

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

V2:
https://lore.kernel.org/all/20260501041633.231662-1-tariqt@nvidia.com/

V1:
https://lore.kernel.org/all/20260409115550.156419-1-tariqt@nvidia.com/

[1] https://lore.kernel.org/all/20260428051018.219093-1-tariqt@nvidia.com/


Mark Bloch (7):
  net/mlx5: Lag: refactor representor reload handling
  net/mlx5: E-Switch, let esw work callers choose GFP flags
  net/mlx5: E-Switch, add representor lifecycle lock
  net/mlx5: Lag, avoid LAG and representor lock cycles
  net/mlx5: E-Switch, serialize representor lifecycle
  net/mlx5: E-Switch, unwind only newly loaded representor types
  net/mlx5: E-Switch, load reps via work queue after registration

 drivers/infiniband/hw/mlx5/ib_rep.c           |   6 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  10 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   6 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 197 ++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 171 +++++++++++----
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |   5 +
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  18 +-
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  |   8 +
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |   1 +
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |   5 +
 include/linux/mlx5/eswitch.h                  |   6 +
 11 files changed, 361 insertions(+), 72 deletions(-)


base-commit: 98878ed91b68a3150126fccef125ee7b1bb86ab2
-- 
2.44.0


