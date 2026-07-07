Return-Path: <linux-rdma+bounces-22841-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x4MpDlw7TWqfxAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22841-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 19:46:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DA171E60D
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 19:46:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=kGDsJcaF;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22841-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22841-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2376300FFBF
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 17:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699C43B6C2;
	Tue,  7 Jul 2026 17:45:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B933F8D9;
	Tue,  7 Jul 2026 17:45:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446356; cv=fail; b=I+nGXuHNuHs6i05026LjRfsmT8cNvb1Dt0qmZb9zkDtK3ZcvBF+oqabcILV0S5ksa3IQeDIzmvyphMxGy5eYYnh0lKvUYgsML039mWjCPPJ00ZU/+LTNF/Nn4N2qIAhJDImMPgtqI0fY+wO5TI/+tuoG3b6G/6E4yVRMLXmhWSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446356; c=relaxed/simple;
	bh=lU/BzVDnmD9OMjRSwxYuwFsKXGlB87wv11eFRfFNoPw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CiBP1NFMP4gnRgOjvfbVIBm+DkiYZHKCk8zqRfyXYfuIXQSFmGizg1c3w+MOR/557cSrVIoHH3ilVXUaZGVM1em8FD1ivk2YI64sS8UqVACotx/On19P4pRbHdD7ArEUmVkCwENeL7DsxhxGc/KAcFW/6565vKypeM8L8f3L2LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kGDsJcaF; arc=fail smtp.client-ip=52.101.85.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLtPlP2p3VhuyiXybJ92z0L4St62lfNfl/JUurVZBYCwFhBZ177XlreTEvTD+H+YuGNMehT7cwcF5OsRGY13Kr9OmLxEYMjVvZ2l+HCOxS1REdv/0y++a82Tk8MnN+mBuRC3Lh831H0MrV8sbyMvLwm26FTT+YddmT1d7+QXW40pjK1wMvfMILc+r/hjIDb5pQiq/l11osqiWSdIovNnUUVrpoj6gTboCZqkz8c0jM8qR9ospt6oU1sjjUbgok01BaiaZYuyG0crQthIDRRpRoRTvotMNyNe3wX51pipEn+7BpSPLMydRzMnLz09sXMvumvXBma6LT7dWLDxiOdpLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNq7PECFwyr8T1mzXA4HE94KTtJpnyl9LQK9/KdUDjQ=;
 b=pkOrwWK3PHAhUwM/gGtbUp7+xnKmPVgpFkgiwmvhTBIXCLWLgYJ+Nv3LR0ic2hKltihow1FedrEO24PnsNbVyymN5qvtp5SqMlnM1b0hjhG6IBnh48M4m/QKNX48aeHT7L0ZQBhWkV6T7tJFV97kT52dYRmQTDudZ319mnf+V/wCWu+pvLE7dr6phObEsX+JOIq4byd2nau7dMM0WF+f/g+mlmo/4JG47+YjfetqHV0MS505R7+J7kJRgO9MyFafVmdxp0VsJ2bg1pWC2ZUpEcZu9g2yMWA6u2hzkh9X8B7JDEuq8L7OYn9maJujK/Lo6HbadUX5kb7mnOnBWBIcKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNq7PECFwyr8T1mzXA4HE94KTtJpnyl9LQK9/KdUDjQ=;
 b=kGDsJcaF3HGfdtIKroQ0mVhnaiNjTkNQxeDM91Y7qE+cVMPUtaaLA1auFdtHumDlzaPVw9oZqtuTtmiIaMaF6hujRdThqRIWMcp0mH9BdFJ4r7y5+BwhToN6OnSyIYwlYiB7Us4Y0etT8ZjCqRYrSNHRNblO7A8ArczuuUpcDcgRDim4Ks3UvP2sTxDU/yCT1GYYJBMq7d9D6RRWciT0Z1HrI+b3pOOUIDS5nUzISSIqFa26iQ2FXXiH+16ZSmeXFhD7w9mqFv4DGm5xzlKa+d2RgT7X0Fz6xXl4BW6DeJfvwwT9gL5j24TGn+UUDAMpkXf0/ENmQmKbboIhAagmEg==
Received: from CH0PR13CA0055.namprd13.prod.outlook.com (2603:10b6:610:b2::30)
 by PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 17:45:46 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::a1) by CH0PR13CA0055.outlook.office365.com
 (2603:10b6:610:b2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 17:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:45:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 10:45:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 7 Jul 2026 10:45:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Jul 2026 10:45:32 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V5 0/6] devlink: Add boot-time eswitch mode defaults
Date: Tue, 7 Jul 2026 20:45:21 +0300
Message-ID: <20260707174527.425134-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 5336d72d-a423-4b0f-0b02-08dedc4f933e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700016|23010399003|3023799007|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	CvbT+E2w0krBsvAyddbwvRkQO6W1xt1+lZBvi+OXQx8v0nFBBOlkezSIZV/ZFi1WpPtYCs4Jn0JfsvGSgEt1ZtWNlD3CWRQNjO1x1+d0qqeAIyipDZJrWef11poXFFSVh0mGhb3fznBS9QeLNS04Qhb04g9+9EKex+IT+EsqHyjoG0ZtYZQIF2RnqbcB3/0Lgbz2/L5/8TxcvLraBVWGIEk6rY3B1v9aVufeMXlYAO0ghp925OdTPgRg43Sl7OyE5WSvnVcr5nXGIfxEBvENABxYqwa1Q/3cS52+K/4sN6I78f673q5MbtxPLJMlbeL5WriHclb3vWRPFnSwaWkFd/qTA0UaeLItJoiJoMOzt262CkdSPMhNcKCgiJZLjTklKOOa6o5ek8InZC4pmhMjOLR1fTZwQcX+apwq3kSci1Mg7EJI9HLVaa9w3lyfKSzPAKqoPdM3VgxpS4430wcKs5XsW5toM6rWr6VZpw+UObSAhvqhv+6Sp+XsKjRKlEbdAOi10kVZ1sT+O2IT1p6ovR/RAu7qkCNMzH9QdabEOmLB3BQYm+w2orvcb5EIC+fHXrtGKS4vMS1rcHDSlo975xTZ9XbWDyjC9qM/rR8jSV0ctdWGBwE1eedAxn6QyFJDFaijEjQ8lwntmyc1kBx7PkoYJMIVEuNx7MYsy5ZLXLjZpkY772eLbLIR3Q/+yw2h6a2nk8hAuWCuQPE0Yj1Chw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700016)(23010399003)(3023799007)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n8REWwoR/hN9Ann0KVNmCVC+Jt3NICHJqUxDwuqEYbNA5rj8vQFscPVXptZltvT2JMigE5bSNcNspV4NTggetK91L/cjm/eSURh64gm3mBoKwlqrtSxSAwF3yZftIf/XdW3X+xj9eUAW/yfHsl2nsKioubx0FQ+VNRUA3d4Bjv2JOHJEYDKDClb8HY+Gf+naj9kq9VR0Zj3fk9Unx7jrnYvI4eB2KvxcPTqVQJIsyubuVpKccOjZz7+lWc9sAdyBnZKVMhT6+1r40xw2Xou9Ja9PO5nwDeAa0TorZt8IXHCoH3NWVI3csaSZkWQFsgwG88AJ9ojRBoE6SqxAiGyruiSnyU8VrQ2LpatUO/3JhzYhHoYLwEY2Ws0otlqVdtvpFwQOfDgQH+ED3t1Hejoca7fUpvCVTUAG5EFITOiyX0Z/vAQyjQAauRGIxPGgxjrJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:45:46.2563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5336d72d-a423-4b0f-0b02-08dedc4f933e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22841-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76DA171E60D

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
so devlink core marks the default as pending and queues async work from
devl_unlock() once the instance is registered. The worker takes the
devlink instance lock before calling into the driver.

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

v4 -> v5:

- Moved the default eswitch mode code into a separate file, per Jiri's
  comment.

- Dropped the delayed workqueue and switched to regular work triggered
  via devl_unlock(), per Jiri's comment.

- Renamed some functions to better align with devlink code.

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
v4: lore.kernel.org/all/20260629182102.245150-1-mbloch@nvidia.com/

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
 net/devlink/Makefile                          |   2 +-
 net/devlink/core.c                            |  13 +
 net/devlink/default.c                         | 364 ++++++++++++++++++
 net/devlink/dev.c                             |  33 +-
 net/devlink/devl_internal.h                   |  12 +
 11 files changed, 551 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-defaults.rst
 create mode 100644 net/devlink/default.c


base-commit: 4a13f31a92f35161b499bf29638336885259da78
-- 
2.43.0


