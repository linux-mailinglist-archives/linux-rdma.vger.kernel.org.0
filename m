Return-Path: <linux-rdma+bounces-22561-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y0P1JNe3QmqAAAoAu9opvQ
	(envelope-from <linux-rdma+bounces-22561-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 20:22:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2AB6DDFC0
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 20:22:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=CgCQhiSz;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22561-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22561-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CFCE30430F9
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 18:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6657E384CEF;
	Mon, 29 Jun 2026 18:21:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF8A2E3AF1;
	Mon, 29 Jun 2026 18:21:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757312; cv=fail; b=aXpD4UzTjSAqrsDnRGcxENqVvr7bQJwHwPi67dLHAiBm6Ixqnz1O0tfm0BDD3pLWxDho8S8FbjvLBksljNar3o24Muui8cmRRerYCBwfa/7YHLjRScLE5/NNM77oGyaAXmoXASIMfvDwawoaljMkXwd+MgX+lZjqfr2WXb7/YZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757312; c=relaxed/simple;
	bh=BNvk2Qe1SrZD5aJ4UyW2B+BAG19KDpGTxZ3/BkfzXRA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OK2PT/V26NQmskDkwXB8jh8s0dJhK8/vZdhFSPBFFumVgX/CbSK09k+PwP8erEQaFTppEX/b71A7WiQyZ8OySr8wZQpiUR6Bl0+KysJCRt5nsIQZ+PIL4OX7en6pcXbTHnGwiSlCDsiS+Qr0FT1xlra+ZrFVuns3xIF+/Che2Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CgCQhiSz; arc=fail smtp.client-ip=52.101.43.34
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgNrNcC72iJ968ENoO+eLH/wPAgEXniZC5pGMWBqSwJuXkLNCK1UahI4zgFVljF1OIHfPSlAXcwE/nWnDwykLiMCmfoL8ay3KJy2o5DpxVQm1TehjCCoZV0qnLumV7IpJJMBxDllmKxSgtCXYGd6MntZY/bWmaZ+ngBg0FrE83phHjbDdBoI3N8CUWmByIb5CkfuByeW/E/GD9ZZuL7XjcmvWMF1FnOb4CM4crd8A4Rh3ff3NK7UOsSMFjVFOF4qdSL2yvvM0W6+JYhtJHMNXp1gAJjfTZNJSzTa3dg6EqWkdZrM3G2V8c0MrPjXTBebYGSOD8kHe/+rTsHJ2IVJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrIr/5ttcIiMeCgQH1ghmF1Kq+dzHnRITLs5VyV/OvM=;
 b=aWRGTwUqW9wqPBlVxeblQVV/OAjDIvraDCTzvPM3925M7LUlLaH6sn/K2uKpkHwn5n0C/VIwI4Q23WT/fhZULEMrqFe0njov9nwULlfmeS17hPjLP+iu0hNmkJ1acCZ3FpzFxHg/qjktwp6Pjq0grvdaZe6h/mk6x1GUE5HcExjuPsVis01YinYJ2KQkCh9IFoml6gx5OT7psOoHHJeDJixKJssbpBFpFrnE1YcwMMLlouEao2AV+DQtPSnmMQXytNRJb6la+P6ppfkKVeYrrFXyxo+krhBI1F+i6zwoWgJzdSEmFxYMIyB6TGkgH+wYiewNDdzbGk3j0etRW/el4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrIr/5ttcIiMeCgQH1ghmF1Kq+dzHnRITLs5VyV/OvM=;
 b=CgCQhiSzyxVBlExLwSd7iAEtkh2NSE6dniDBU5tHJGJhmh3WNxixwYwcLXpFwYVoP3viUsIWCd8tSNUZTbatyMTgosjb/YoI7iWeUC+PRZRgg1CKfUrqkHbs+mYdXnCk+wS26wbfJKtR4wE7vLPYZyi4D7+MSxFtLAd/hCvaKQgSLmYJrwOPfAq2dmy/n2VvLpQt//Jz4QuPtI/awZguQpXkIlANl0HgoQhYDfHFxs6OZocEZbOPx1wh9DYB8fTOSb8vYgr7/XbW6YDtQAT6PMgpniCMyxg86RaRhcJMSp0TYKx8diR3L+/8yaVAkcUccudmV5cTvEzfcTZAuNUFqw==
Received: from PH7P220CA0127.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::7)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 18:21:41 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::d) by PH7P220CA0127.outlook.office365.com
 (2603:10b6:510:327::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 18:21:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 18:21:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 11:21:08 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 11:21:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 29
 Jun 2026 11:21:03 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V4 0/6] evlink: Add boot-time eswitch mode defaults
Date: Mon, 29 Jun 2026 21:20:55 +0300
Message-ID: <20260629182102.245150-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e84036-22eb-46ea-bb4a-08ded60b43fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|23010399003|82310400026|18002099003|11063799006|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	WUfiqNQZPnEpLJhYF6rJbeVObsoiYUHQ+UpuS6gGIlFCrakBbLiQ6sSsiGh5a6OHPCe4Ag/BNZZH/xbEE7A5zxYchh0RvYelEVbCDcOUt4FK45kA72UDl/U3c5+J/VKcSwJIdYleu7dImM5fcwP8PpLWM4Omb/HRLRHPnosJCbuhBH6wJKkLAlfdFuOtxDXyClXwxc3r6RoSo5tPbzyxQJ0YFKfct6hhZ+0IyNoXDrt16Woy/oFKNRQwa/FseiYTpfASvxxgyaoGKnAW1X58O2GH6wCaMXhYSKiU6QNoMKplnUsaosLz/kk7H7YyU6AFxsFIXAwiliIzlexoxPnAtRkAabde9iNQ7u/YLeOx27lCr0a8b70SHqunwVSKLpzR10/j62NxvXigwqHaDa7JBLVnLpZdNAomEDUEshVClTufaTEBDVeLssy65yws/ylcwLRR+wzHne+JECwL5TfRsO4v1Pk/qeVo6i+U25xWRRnYo++rTIlgMVcCI2Z89t+z78NfkG9g9hNx3PtdHgo98Nv0AyKPp/JWmhuqll3AZ1dRFDS4bpMJekVdHbyMzjJLsBHLLuuOuwyQOGCYGArLTvS3L2pxGT48yFIqHFU159HrKcYGZbR1cqJ/vOUhGVIwceAdsApK5t+GdLv5ZRq+0P3T/LaC/C9jWRtDPLJWXk2eClgUfADtgBCtJmcnh8cww4toFgGUrE+MOZIit/YQ2g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(23010399003)(82310400026)(18002099003)(11063799006)(56012099006)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VfJW+qbfGqPB1FnECCsmIs2aJ5ZY+IeusReWP1CeT/y0kSrQLYAq/G6GAI4qFnkba1vKXw2KzHxNaKAzpltm1JiZ6rLQkL86cWjWO67n++fjPgA/8e6trlH7Pvj5zD//EhgW4puFyqKNfN5uXg7WISUiDIIVB8NP5ngotqLPWYP3CrJoSSpxfzo9Mhutmxn6QyAEPzf84bjuA76vvTEmDwdidRf+evMCgrxV52Ke7RxMISxlGzSY2GW5lTrwrpGAKAVfpuzQivPDwjrO/ZP1140ZFgKoqzxNUZ6eNIrnzE3dDILy1cp335ykQxo9cjq1Lp8C68rGeYctNcLm5EZH3MTJT6hTfTkOtVPA0rFQKBFnuTQGuKzIgiJjDT0z3lIat5rPu3ujdLhhqSl5tHUrnywOXA5vIQiJtoPL+t0WoFpgfvCZEdziZNtTU2MBWNv8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 18:21:40.5576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e84036-22eb-46ea-bb4a-08ded60b43fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22561-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:mbloch@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C2AB6DDFC0

This series adds a devlink_eswitch_mode= kernel command line parameter
for setting a default devlink eswitch mode during boot.

Following the discussion with Jakub[1] and the feedback on the RFC
postings, this version keeps the scope limited to a boot-time devlink
eswitch mode default only.

The option selects either all devlink handles or an explicit
comma-separated handle list:

devlink_eswitch_mode=*=switchdev
devlink_eswitch_mode=pci/0000:08:00.0,pci/0000:09:00.1=switchdev_inactive

The supported modes are legacy, switchdev and switchdev_inactive. The
selected mode is applied through the existing eswitch_mode_set() devlink
operation, the same operation used by the devlink eswitch mode command.

Registration may happen before a driver is ready to change eswitch mode,
so devlink core queues an asynchronous apply request from devl_register().
The worker takes the devlink instance lock before calling into the driver.

After a successful reload that performed DRIVER_REINIT, devlink core
already holds the devlink instance lock and the driver completed
reload_up(), so the default is applied directly from the reload path.

Drivers that know exactly when the device is ready can call
devl_apply_default_esw_mode() directly. mlx5 uses this after initial
probe, when the device is initialized and the devlink lock is already
held.

Patch 1 clears the mlx5 FW reset-in-progress bit before reload.

Patch 2 factors the common eswitch mode set validation into a helper.

Patch 3 adds the devlink_eswitch_mode= parser and documentation.

Patch 4 applies parsed defaults from devlink core.

Patch 5 adds devl_apply_default_esw_mode() for drivers.

Patch 6 wires mlx5 to apply the default after initial probe.

Changelog:

v3 -> v4:

- Rework registration time apply to use per devlink delayed work instead
  of calling eswitch_mode_set() directly from devl_register().

- Apply the default directly after successful DRIVER_REINIT devlink reload,
  where the devlink lock is already held and reload_up() has completed.

- Add devl_apply_default_esw_mode() for drivers that know their exact ready
  point.

- Drop the driver registration-ordering preparation patches that are no
  longer needed with the async registration apply path.

v2 -> v3:

- Change the devlink_eswitch_mode= API syntax to use <selector>=<mode>
  instead of [<selector>]:<mode>, following a comment from Randy Dunlap.

v1 -> v2:

- Move default eswitch mode application into devlink core. The default is
  now applied during devlink registration and after a successful devlink
  reload that performed DRIVER_REINIT.

- Remove the exported devl_apply_default_esw_mode() driver API and the mlx5
  driver-side call to it.

- Skip devlink health recovery notifications while the devlink instance is
  not registered, so drivers can move registration later without early
  health work hitting registration assertions.

- Move mlx5 devlink registration after device initialization, including the
  lightweight init path, so the core can apply the default through the
  normal registration flow.

- Move the matching netdevsim and mlx5 unregister paths before object
  teardown, so unregister notifications come from devl_unregister() and the
  later object teardown paths run while the devlink instance is no longer
  registered.

- Add registration-ordering preparation patches for netdevsim and octeontx2
  AF/PF, so their eswitch state is ready before registration-time defaults
  may call eswitch_mode_set().

[1] lore.kernel.org/r/20260502184153.4fd8d06f@kernel.org/
RFC v1: lore.kernel.org/r/20260506123739.1959770-1-mbloch@nvidia.com/
RFC v2: lore.kernel.org/r/20260510185424.2041415-1-mbloch@nvidia.com/
v1: lore.kernel.org/r/20260521072434.362624-1-tariqt@nvidia.com/
v2: lore.kernel.org/all/20260603193259.3412464-1-mbloch@nvidia.com/
v3: lore.kernel.org/all/20260605181030.3486619-1-mbloch@nvidia.com/

Mark Bloch (6):
  net/mlx5: Clear FW reset-in-progress bit before reload
  devlink: Factor out eswitch mode setting
  devlink: Parse eswitch mode boot defaults
  devlink: Apply eswitch mode boot defaults
  devlink: Add API to apply eswitch mode boot default
  net/mlx5: Apply devlink eswitch mode boot default on probe

 .../admin-guide/kernel-parameters.txt         |  25 ++
 .../networking/devlink/devlink-defaults.rst   |  78 ++++
 Documentation/networking/devlink/index.rst    |   1 +
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |  28 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  13 +
 include/net/devlink.h                         |   1 +
 net/devlink/core.c                            | 393 ++++++++++++++++++
 net/devlink/dev.c                             |  33 +-
 net/devlink/devl_internal.h                   |   8 +
 9 files changed, 562 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-defaults.rst


base-commit: 805185b7c7a1069e407b6f7b3bc98e44d415f484
-- 
2.43.0


