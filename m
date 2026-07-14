Return-Path: <linux-rdma+bounces-23175-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qg3TN0zVVWp9uAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23175-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:21:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B137516FE
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:21:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=le3jlO68;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23175-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23175-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF923301ABB4
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 06:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6CB3DA5A6;
	Tue, 14 Jul 2026 06:18:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95E63033E6;
	Tue, 14 Jul 2026 06:18:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009931; cv=fail; b=gQUrdCh6N5A/WDansBgYkUNriIhp+nX19+HfaZfZ3+xrVcgmet5CyX3QCAKaVw+Pu1ezXJmCafm1O92V1ldQTSS4lLLyBoIshHDA3sjkAln5TgolQrJSYQo/mLa8hasAyUDxGyil5nwGFa+Lh8QMBpHqhUQJ5GbuAuO2WCXiBog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009931; c=relaxed/simple;
	bh=boRdXAEHlVmXMxinaN/jk87vp9lOCoyTi+w9Dse4dzM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kHYq4XP9O8olUKfUZMHA8JRL3+EqPnjQSLiUnEDfpFaInWe/6sUlt/cnhZF8fxlOxpWYY96JNeLLoA8sgzdRIdhhv3DTfu5s6ZwBlHyFzG91gjOLrOASzF+O8/AxSygc2Ef2izuTZlBBbZM7lVVvNdZmzzC+W1pJ3Nki45UPi/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=le3jlO68; arc=fail smtp.client-ip=40.93.195.58
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOLXgKAS2AXm/cXNdDeM3SUgISIsp1aHF10nzl2oJwbYVy4q+CnKAZjt1uHadUPMnPlC0NFTZLd6XKky72pA29ukLsEuTLodDDTuv0BZhfqK1t+JOejNm9YR6mUe7bkO2abiOsQEK8G4O/xKDdhO66ZPctWnS5fJlLdCbFqXqG3uW8AgYGveOGUpz2dJbQRR/8xdANS44NeouppXO0w/Tu32kDAFxHoKLivdgZsMBS8cFa90vjCtL34mvHP8m8XP+/g3cwDYkRYlIVdsvTijS4eY4S7busD9VpW9inty9wd2NSprCDrpbz119Ay7TvwMK5jw+GtUo+gan50TcGXy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bca8i7S3bWW+M4z4BPbJPgRhIBNDkLxGHzv1qfLx4VM=;
 b=BG0kyhfDRIlJwHKmBdbQEryadwX3akR7yPZ80Esiqo92iwPAz3l6CDg1h2YGAqMy96OpM9o/W87z5qOYUG2barkO2IYc9ED/NbJBQzE7ywV+RhJDo6HNdfuI0i21eEBbMb5TECwnXIbRTjDsuR6KAA90GVib5oT664zcjN1vcJwSxOJdambnvQWgjW0ZSPpNChY14OuLiBLJkaQ5/EiLfl23WAb9ZZcp7L8Oz59VabLhaR1hu3VLUD9Nm/OpfYck7yqfVBc2l6CCFNNBtYr2cSW32VXEYfl7araeDKgpLZU1MOWOW4ulXWlWU4aPo/V+3UbeOb+aZkGnB2bi9dzFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bca8i7S3bWW+M4z4BPbJPgRhIBNDkLxGHzv1qfLx4VM=;
 b=le3jlO68Py8TvtBsmlOUUC/PsIW86DM6aT2MyvsbwenpsWexqwynoC/FEtGVX9xvqyYmWUC4SygTFFcfAkwLKgMrKFqXtcDFvpf3Gl+zhIR3A3f5Y7a55t/zWq0K1Ize2m7vfR55/bpUOGdevVT4o4vFuYQmdXbwcpTdmjfYMaBaIp+jnfUyFkMNeigcOYZrtaqV8GTFbON9pw+2VLDT40lJMavUor4+VN/5E5wom4480G5AM58ttMUJXPM70MKOyaY/wSDYpf9f9EPUWvPtVLO6clp1cFdk9K5Rw1aSgtfqynRt3d67DR8bWatMitLRBnZiFlZrwpkVQyEIvNw7HA==
Received: from SJ0PR05CA0110.namprd05.prod.outlook.com (2603:10b6:a03:334::25)
 by CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 06:17:52 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::d) by SJ0PR05CA0110.outlook.office365.com
 (2603:10b6:a03:334::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.5 via Frontend Transport; Tue, 14
 Jul 2026 06:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 06:17:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 23:17:37 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 23:17:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Jul 2026 23:17:33 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V6 0/4] devlink: Add boot-time eswitch mode defaults
Date: Tue, 14 Jul 2026 09:17:26 +0300
Message-ID: <20260714061731.531849-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|CYYPR12MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c397dd4-5a9b-45d0-4ea8-08dee16fa293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|13003099007|6133799003|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	JQfHTVp2t5VjNLDMCOAzhXA+yPNtCxwLI5+dcELBLriakhMWig8vbX0z0ao+yBEaHeuz6AWLAtfb91D1rQJTC2dNRB0tH4MOfkkOavsMkRD5AYN/4WvFyS9P2sOdVyCkHa0A13Nx7fy9KThNDOKmyStAfNN3AU6lDkSZzCHiLY8jLybAk7hvvthN4AO8tsvGSGjHyv9t8YRaCJNPXhMU3Rv6Wb24fniMuEPA4JSk/4LGllbrE76qA7NzjZwoo9UbCChbYCI9GISgEREAz9ZnBeHnO+SR1NX4573v/mg8IEDByrW+an1iNK3bVs8MMxvy0m7+mXPpV/Wc473sn5rwK23Oy+GWdxkYQAmwkno1r5Lp7KixfAEWM3N6WXgNuwqoVGg0NyOAbpqWlndCRAWd2X3Hd2Fh9/n0iybXf4i59iFEFxI1YKk3ZMdUeC3YmCLFnHo1Pe4ojxQSyO7I424fTHCZizvB4O8eOt3WF2miGqGBV5TK/9FFjgxBd/ho8G5wQj57hocEk2hxgjozpgMHAdFlNxGJ7+/1WkL9f/Ado3d8oowrGcGIUTRqC8D0bk7HsCPJxaT1p9BkRsQ+5PSHj4PxbRo+9fF931kUNyEcM4wu5tR5R7aop6y4gO4+NGW9OubFvglf/RfyrXQzzxEvHwKda4Slqj6j2Z20G6obIjtsY9dJe2t9HZYheu5B+Z3yC1xIxAP+bWePYTnkN+QgLA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(13003099007)(6133799003)(56012099006)(11063799006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5CAvTjcvMmts6sRhpKWZE4mUNAHwJdqD8OqhlUBm0hcRTbJ8Bfjow+rt5GLPMfI4vwONp8tYJX3Df2NzUuYTIW9wkN8B/dZAlAb0ZPbFercdOVrrV3MP5rBR5iyuBijjBDbFqXTKwdD5UUNa36doldJLe1GlvkRsiVPpqN3PBe32Csn0L+/2FSmZxx71cwm0sp/HObUAFT4QNZyHFZ/+nasN6TMcq+wDq9dqdiejui0M2ks+XKIL+zzVR2g67WbQEgFJwHCvuUn3ktC5UAuMG+ReD6hDY3HnMhn/NiN2SAge7KSYFlDUopR//7MCTS6tYW8iWeBs6asYMa4R8M6FRBktRkxnzLY6Vbi8eMBsn7uMQSgn7CKIWRqb8TFW1MTn6k+4kfZTkgyYQpwCAyyAkR8JS77qqkWy9rv7l5cjVTk3nEPdhVCZ/rAuD6SItPcg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:17:51.7948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c397dd4-5a9b-45d0-4ea8-08dee16fa293
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8702
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
	TAGGED_FROM(0.00)[bounces-23175-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:mid,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65B137516FE

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

Registration may happen while a driver holds the devlink lock and
continues device initialization. Devlink core marks the default as
pending and applies it from devl_unlock() once the instance is
registered, before releasing the lock. This prevents userspace from
racing with the boot default.

After a successful reload that performed DRIVER_REINIT, devlink core
already holds the devlink instance lock and the driver completed
reload_up(), so the default is applied directly from the reload path.

Patch 1 clears the mlx5 FW reset-in-progress bit before reload.

Patch 2 factors the common eswitch mode set validation into a helper.

Patch 3 adds the devlink_eswitch_mode= parser and documentation.

Patch 4 applies parsed defaults from devlink core.

Changelog:

v5 -> v6:

- Dropped regular work and applied a pending default directly from
  devl_unlock() while the devlink instance lock is still held.

- Dropped the driver API and mlx5-specific default application patches.

v4 -> v5:

- Moved the default eswitch mode code into a separate file, per Jiri's
  comment.

- Dropped the delayed workqueue and switched to regular work triggered
  via devl_unlock(), per Jiri's comment.

- Renamed some functions to better align with devlink code.

v3 -> v4:

- Rework registration time apply to use per devlink work queued from
  devl_unlock(), instead of calling eswitch_mode_set() directly from
  devl_register().

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
v5: lore.kernel.org/all/20260707174527.425134-1-mbloch@nvidia.com/

Mark Bloch (4):
  net/mlx5: Clear FW reset-in-progress bit before reload
  devlink: Factor out eswitch mode setting
  devlink: Parse eswitch mode boot defaults
  devlink: Apply eswitch mode boot defaults

 .../admin-guide/kernel-parameters.txt         |  25 ++
 .../networking/devlink/devlink-defaults.rst   |  78 +++++
 Documentation/networking/devlink/index.rst    |   1 +
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |  28 +-
 net/devlink/Makefile                          |   2 +-
 net/devlink/core.c                            |  10 +
 net/devlink/default.c                         | 303 ++++++++++++++++++
 net/devlink/dev.c                             |  33 +-
 net/devlink/devl_internal.h                   |  10 +
 9 files changed, 471 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-defaults.rst
 create mode 100644 net/devlink/default.c


base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
-- 
2.43.0


