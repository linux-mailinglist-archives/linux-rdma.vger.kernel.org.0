Return-Path: <linux-rdma+bounces-19936-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PWzOF7f+GmU2gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19936-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:03:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 764064C2491
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CA07300AC85
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799993E4C94;
	Mon,  4 May 2026 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kkDXz+RX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012067.outbound.protection.outlook.com [40.107.200.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D8229B18;
	Mon,  4 May 2026 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917783; cv=fail; b=QB0SpJk8SnHMmoup7r64jfaw8+Dy+hJ1t7wridu6VGeqISuQ3NcyEAaTJxI6tHqOopRkzpvAWEviJXV+aj+dZecL68o5hu/4ntWl6CkXiGqyhKPiJF74YnFVIHNz0YJcu5SnLqWirfRWtMBjZbPpnit2WpJ49SLK4CoZTNA62Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917783; c=relaxed/simple;
	bh=jWobw8AjH/3CFh1ksz1msh8Opsv8fLDs9oON2iPLjkM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g0kDa9siXqXt1seSziWz/y3mUKaHmzZ/em9ZLa/VBIlHXHRKZdhE1tYPKYJv+7yDsf3MrU1+blFjKvbt7XuVrMqonlrnYikUSuzJ45BcFOnaqh9M1b1HmUDt/9VKogNQbfKqGKrLUcoIaV1XWj75G5LFnBjX11na8vicy8/ViFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kkDXz+RX; arc=fail smtp.client-ip=40.107.200.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVR45oII/RJTchPuo4zPYYeDwt9mlie+8LE4FT3m3ZA802JcRwv0pYs5gF3FSdEjupnnnbkTKvCidP5WotVyU0Ei9nSV7XV4/G5OQ+shfHdJ1j+9Bf6d9/W53UNoxkr9nr+4nb+MRWJvfAdMuIP/B50cuWNJ4ovbnkO8LJBlSQ7/6RxO0zNcsyHKnwByP0PqJ23JuNLy0Y01Fz2vqff18JGfhL4Hz0MN42o8JYt19mc9YL+Y0xwrBMD2iOCN92y9K6NwPvllG5EO3aBQLNPy4g1Zq8Lufu07vvGnptk2mbcQQKTQlMQrh+HTYtAsjsojyepofBX50QPqvttlQPIjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWxBzwpzhwhPcRlEJPim0OJYILKK2Q/BTci/frOuLU0=;
 b=b0fAsZJOkCtgQ8Pfq2JfWkESl2LzGlybLalPuItduabGx8w51ZOkr3qchUe/hwi6oZ6WjBOfYHn85+OyfylJKTN5D0w+Ohc99EIXtWWKG9WIuXQLMCjNacw8V3iguuWzKHuCdS17DBWIC9KooHg/dXyeUrYL6ou+ZxH5htJsifNA/R07FB/yrwrw8+qcwLuI0a7XPa3h4OJdzuBpkipdBIpOnJJDSj23KmEDRaeTokuuZfJL63jwVTfEzwcGBYlKC8RHDO3VtZMvkcD0YETzLnO5F5ZMwClqwhc0qOmxHNZrRUHkqGIJkmWxhUrgw4SqgqnFAw7eVtiMjyjUHyKqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWxBzwpzhwhPcRlEJPim0OJYILKK2Q/BTci/frOuLU0=;
 b=kkDXz+RXdpe0OjF21opteHNJBXmytCcC29Cw+pFtBWfN9ElP64BLsEyd2uetgL2kmK9SLk18TxmqqyDzx2rQ1ZB/NiVj+aSYF57y8+fufTabFv2XpOFrPTYpurwiUERqkXWtV/GcD+CLfGhljAa4lYhUZ0eULkYz5el0iEH0eukSLHtj11HDPSQUtCp6Q1HJ162ov8uOmaGeZ8Je6SJ1VOHX2/0GxXZHecOjfjEV+SHzVefq7Db8i5ToUUETejs1cxbTHsgJArcVrhVFEAtbeeBt8UdVYP9Y/qC9veIy3W/3I6Vv/az3aJO2JhWH1gD9cUJhtj8mJwxG3srfjS3aoQ==
Received: from DS7PR03CA0289.namprd03.prod.outlook.com (2603:10b6:5:3ad::24)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:02:56 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::1d) by DS7PR03CA0289.outlook.office365.com
 (2603:10b6:5:3ad::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:02:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:02:25 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:02:25 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 4 May
 2026 11:02:20 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Gal Pressman <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net V5 0/4] net/mlx5: Fixes for Socket-Direct
Date: Mon, 4 May 2026 21:02:02 +0300
Message-ID: <20260504180206.268568-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eae32a0-c946-4802-1520-08deaa075dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	iJvwoh+zT6XWs6UFZQWWnep6dGXWE9op284dTREBiSB535U2pmoYWBrtcqsjPgwNEbZzzvOLINe2ZEKCjoinyje17iE3Lt4rKVLn+Slkf4mmVIXtSnUD+xkjL4mA18dibj++0yItdN9z3oxiLb5NRDqr58emd1GtSPhqft5V+JjaDlU8PtfXIYn3en7Gdl62e8GmLfPgbwoCo20mzKPziVoBc9bNvNyUSfUwIxO+T61BW+A0GEjxk/x0Nl+Am6BH53w+RV8e1ed2whwMvuuk9hOqfi/GiQpuFC4KaQwHSlZIIRkQU33ETL296aj7bGxsV8loGjt0M8e8kZjl98sbfBdBR4u64hk/zM3xg5rIWlmJIObwBVasDUhBedzQrG/wKlAV9x0tTZdRgsOllokgM6egNyxzf3aqVCvY40c5mycdy25SwBLrpl6QNmkRAHf/roPO3uwLqw1ODFoqA18VcLycPZvbBWY4kUeyJLHtec/JQsz61109ZPBi4YSjv+ZIJj4zPPu9dbk/1gS0twEBJCQZdg/G2rzYBzVPkYlpfNubSURkavrxVwk/deX7qScd4fPB9EjazMjvQ++0rt0L3r/d2tJMT2xdNqbIr8cWfdKxLwxKEDHub9o0YpDrl4otI3vTFBGYW7rED4B1e7esFlA94chOMfmKZejV7AoiROQ6XIy+0a4dIy+S9R5YQPO2ezc2XuU3ZjC+AkzpLILnkwA9JMXb/5abp5148UurLJlwc7en2UEN7AuXEiYQwDgs
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	glDuMR22ux0+ra1pbchdS/Lcm0E6FPooTQ1qQi+hx3V5J3yVHOo3hpBo7SlCgqW/tOpsrJCA21LBAw5WJ/eA6om6/2/oFvtP7bqEg7hronAVMxrJUQXCoPVEpe90avgNmwgUz6QkalwfeBUzQMt5U0aZ7weaqoL3rDlYBThNQ+YIzSg9NSY7wqAWhdmP58xspsANMVmircthRT0ULqPmgHqks+JkI7d4Sf2wLZXH69j3PivOtjtgmW/bzwIAPxPb6VGDeltALAfgOPOuQSbaygDfiSCoKTo1aJ553VI9WEvVO3O/0pj3aYXu0odmAdpVbS/oI/B9O31D6ZLyOWMRBEpb2rdq2+MA2fhLXFnn121ktwEPT9jIWEJmza/VGGs2+KmA0h+tBBfZv3unIYyit2sRjT6jh9caDm1RYHoNAz1Z6jLoxmkwMzRJ8eYQxbsy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:02:54.5937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eae32a0-c946-4802-1520-08deaa075dc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
X-Rspamd-Queue-Id: 764064C2491
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19936-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Hi,

This series fixes several race conditions and bugs in the mlx5
Socket-Direct (SD) single netdev flow.

Patch 1 serializes mlx5_sd_init()/mlx5_sd_cleanup() with
mlx5_devcom_comp_lock() and tracks the SD group state on the primary
device, preventing concurrent or duplicate bring-up/tear-down.

Patch 2 fixes the debugfs "multi-pf" directory being stored on the
calling device's sd struct instead of the primary's, which caused
memory leaks and recreation errors when cleanup ran from a different PF.

Patch 3 fixes a race where a secondary PF could access the primary's
auxiliary device after it had been unbound, by holding the primary's
device lock while operating on its auxiliary device.

Patch 4 fixes missing cleanup on ETH probe errors. The analogous gap on
the resume path requires introducing sd_suspend/resume APIs that only
destroy FW resources and is left for a follow-up series.

Regards,
Tariq

---

V5:
- Adjust "net/mlx5: SD: Serialize init/cleanup" to clear each peer's
  primary_dev pointer and the primary's secondaries[] under the comp
  lock, and to set devcom not-ready in the !primary and state != UP
  early-exit paths so the device cannot unregister while devcom is
  still marked ready.
- Adjust "net/mlx5e: SD, Fix race condition in secondary device
  probe/remove" to also take get_device()/put_device() on the primary's
  adev, since device_lock() alone does not pin the kobject.

V4: https://lore.kernel.org/all/20260428060111.221086-1-tariqt@nvidia.com/
V3: https://lore.kernel.org/all/20260423123104.201552-1-tariqt@nvidia.com/

Shay Drory (4):
  net/mlx5: SD: Serialize init/cleanup
  net/mlx5: SD, Keep multi-pf debugfs entries on primary
  net/mlx5e: SD, Fix missing cleanup on probe error
  net/mlx5e: SD, Fix race condition in secondary device probe/remove

 .../net/ethernet/mellanox/mlx5/core/en_main.c |  26 +++-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 114 +++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.h  |   2 +
 3 files changed, 122 insertions(+), 20 deletions(-)


base-commit: bd3a4795d5744f59a1f485379f1303e5e606f377
-- 
2.44.0


