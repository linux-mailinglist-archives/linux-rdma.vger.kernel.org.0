Return-Path: <linux-rdma+bounces-21094-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMl0MHroDmqmDAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21094-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:11:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7C95A3CA2
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A8E03023E60
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76A53BCD1F;
	Thu, 21 May 2026 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eW3zvxeH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF483BAD88;
	Thu, 21 May 2026 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361902; cv=fail; b=fqXFgsUBrP2BxR3Z43RNVdAXnfVH1Duh18KZt6H9jQIzzwN3RN1NW8RsEhlaJFpFZ/yfKU2dZvmf5nbhxZsFEzmKbSlOu8ZGE1OTGwlS4MD+RTORHMfeYr6UYD85Ydf/h3HwexdBSel6w+5rTa2vCWZq8blKR2a3tHyAXRsJGAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361902; c=relaxed/simple;
	bh=iyX3CV9vblxV6fwFxfuecBLYR+qhh46sFdvwYI/HRAU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eJIkUHYof5JpR/sC31qwNcKSKk4qEShu9ice5dk1i8fQwYTUrO4wmsSjjSw5HuYWZLAvba4bC9VVRC+FX3R687rSBt8gUuwyb/O15xfIy96Jmm9ewVWrK9js1bwJGmwGX7U0L8L+hmmcNj3RccyMBOZymn+4/jEZ0IJtW8J8wR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eW3zvxeH; arc=fail smtp.client-ip=52.101.52.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inIrJQ7WMXaUJXaCIZdKvqKLatcr16wNqFMPd+wSzjHtJrHoYKW5jVlAzTeUxRYfJxfo660j4ZNuMj4gzKrV2JUbKlZ0pHgD+8Po5idnTMPk/sb02TbKU59OptpsmzBUyDY9L7/p6c0HIjbq38qU0CoQTir+H9HXS5k5UXeznI3HePvZLOPxRIJPAysHLUgHwNPbioU/X0OdajqGsyj8DbwwXnlBRh/RUiyW/GZ87I7EIL1G9vuJr5x3ydr2l6nrHlWyYs+Lo3wkTIbkGy9XEZvHhhqDQxjjQnfoM3/9wvX3VZekhfW+XFygsMS3GOqpjlk7SmS2IlTSsIXyQrYdkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVb+THSZabrXsLDVzUO/xi6O4RCpnXNtOZK9WEtqIrQ=;
 b=k/Ovtc4LvQl/ElHkskpVmREG9yCZ84kN1PJrCWyJ80f3qmSnO6HgL3jAuQ86ucetvz9umhhBUB9TNQe3BSM8G+t0eoOrZFcDGAAgR8wjZHE7HyD0K4MHrhxak3hwP2kubzJxOnnnE08iCNJO/7TlqutFkj3XgH0eo8/J7Aaq7nX5yGhSbUPNpT/Ap2CWsG8ViiRUxt+okVU//pl2RO1UluybIDej4U+tJPd1r4KMG06EFrtZXoXn2zWeRvonK7jNEOfCKft40XH+M/gwb/K2OLNBsllnXOeic/Td7cSbGoxH26p0Z4yZLTmbI64pRgnSaTfsv4+2fTVOgh1/JzrrMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVb+THSZabrXsLDVzUO/xi6O4RCpnXNtOZK9WEtqIrQ=;
 b=eW3zvxeHAFsd1VPVE6hOeJDemKhKhj1ZWznGZxO70l3K9WrvHK4V47TpiHijQXWWifvVULSfhkfs+c5jeMMOK6HDKyAbKCUxpe13z9cglGX8lbGCH86XTs3ZQgA+lF0lqscObIsOdn97r03g/KWC1jYEVtBQ77EtaMZpvXQANA3WQcg8G300rn0SBA1O3S6I9mlQYYDgK1aZre0yryp+2/ookkzPn8zeAIDmBVRFKaGYc6UnIpV0i1NkJYiw1N/zM8c/P4IcR9wxNjQIlAYLG78dpumrVrLLFHacHGPYocX4F7eV+6Kqbl8xhR9qN4NhnK+ozSUVOG906r1UScx/HA==
Received: from CH0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:610:e7::12)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Thu, 21 May
 2026 11:11:34 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::f7) by CH0PR03CA0217.outlook.office365.com
 (2603:10b6:610:e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Thu, 21
 May 2026 11:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 11:11:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:11:17 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 04:11:17 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 21
 May 2026 04:11:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, Adithya Jayachandran <ajayachandra@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Moshe Shemesh <moshe@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Shay Drori <shayd@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, Kees Cook
	<kees@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 00/12] net/mlx5: Add satellite PF support
Date: Thu, 21 May 2026 14:08:31 +0300
Message-ID: <20260521110843.367329-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c08f34-ce81-4d07-99ce-08deb729b73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|7416014|82310400026|11063799006|18002099003|56012099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	yKPNCvI1YOLMuwK8P+0HhGpGgEcEhHEYuZKPGGEh7YEo+11HGwXtLol5nAw/yLOpxWCYjYqQarrudIrrYY2Bu86xdnMJQHOp5iI5icb23TamVN2lZGtXLXE3vBio4cdUpSOjbDQzyzRZsbuhzYHMbP6j0ED0Kn4pbnn2GNCpA/nruA0VhPVluBrbqTLGwX3467+y6l5KxPiSghxzuBUZgEO1K0RujhGa1r1IcpCKRRekt9lcpTpcXBJWBD5tiDXZQbI6d5QgpDTvXMq80llCEaLu9MIV/YiHk+DO2PnK14MgaeLLmKBI+njUOtwgG6sTF9uHA8ytWHtsF6M1++biGk4ZpcdiSSZb+UhhcWFFh8HSfYk1WfYxHCmEofBToKXW0KFsaKL3eD1LDjtAFMuzA/u7pEGayWlwFUAHgmedmG7VVpeiFPZ0irnPLdTBOEdl+KM7SktdDqiArvHyL0obK8JZaPtCCWWrCEZJGKfTsIsUD2+CU4cMWOXPKvOVE+wq8UGnNs0uJEVviL5jaWQl1bqUZk1rrCGjVFqzOJxJZVNMoD51JZnOjBqxDDDwMQCDBbvtDAQUy0T9gUh3nCSvEByRCJIxQ9GXoRcLOBtxnKVtfkMMS2c9PEdd01XgN4UnREL0WneRnrBdmbpQMr24xGOTKMv7zqxzgM2C1tEPE2bROFOTJkOFr6cFv9l3BrT9fTrl86CvAYCU3YSx/0OoiWc5cRjUhSIwJueZYDp/+NE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(7416014)(82310400026)(11063799006)(18002099003)(56012099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w79iUWkiVgIM0E1H6rkV+ZO3/z6bHKngEl7AxUmy99djYBbrt2TOyVcUNq0AYLJ8YgPk2fE+tIOIQggWoIgk+2Qtb3OX8GR27ZqzrK1v4lyhsm9koTcr/p/YwW7Mj9TQ4aE3IoQv7WH8mSWBBxVyq7KRxfO8GR4cZCWzhBPK7vDZdUXt7JEiGTFeUwcTDwQfRITp6hb1s9PZhq5iNisQUInvvSz1kHyfkAj/qSBR/OsVX8OYzRvMdS0Iasc7kqqAQwTpqeXIqLvSamcwffVoOQR+lBN2vKPWXvOyXJt61w0jr51UABkrdQTWFOgRtMSGrcxL5Fe9h1bMPHfOE2KD1xGlIU6LEsxlfwQkK5RqgeRXlrOoLfm46HtC08BZ4YwG4QGqTQaZ2PE8DrhufcIuB6vDcq/3DDBoKycLCrlkekdYD4VHJ6KZZG8GQg++THyK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:11:32.7101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c08f34-ce81-4d07-99ce-08deb729b73a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
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
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21094-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6A7C95A3CA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

See detailed feature description by Moshe below.

Regards,
Tariq

A satellite PF is a new SmartNIC configuration that adds another
physical function on the DPU that is not an eswitch manager and not a
page manager. The satellite PF can have its own SFs and can be passed
through to a VM on the DPU, providing an isolated function for users who
should not have access to the privileged ECPF. The ECPF handles the
satellite PF and the host PF in a similar way, using the same management
framework.

This series adds support for satellite PFs (SPFs) in the mlx5 eswitch.
SPFs are discovered through the v1 response layout of the
query_esw_functions command, introduced in the previous infrastructure
preparation series.

The first four patches discover satellite PFs, allocate eswitch vports
for them and their SFs, and extend the SF hardware table to manage SPF
SF entries.

The next five patches expose PF numbers from firmware, map SF
controllers to their pfnum, register devlink ports with proper
attributes, and register SF resource on satellite PF ports.

The final four patches add devlink port state management, FDB peer miss
rules, dedicated page accounting, and SF resource registration for
satellite PF vports.

This series builds on the eswitch infrastructure preparation series
previously submitted.


Moshe Shemesh (11):
  net/mlx5: Add satellite PF vport support
  net/mlx5: Introduce generic helper for PF SFs info
  net/mlx5: Initialize host PF host number earlier
  net/mlx5: Initialize satellite PF SF vports
  net/mlx5: Support SPF SFs in SF hardware table
  net/mlx5: Expose PF number from query_esw_functions
  net/mlx5: Map SF controller to pfnum for satellite PFs
  net/mlx5: Register devlink ports for satellite PFs
  net/mlx5: Support state get/set for satellite PF ports
  net/mlx5: Add FDB peer miss rules for satellite PFs
  net/mlx5: Add SPF function type for page management

Or Har-Toov (1):
  net/mlx5: Register SF resource on satellite PF ports

 .../net/ethernet/mellanox/mlx5/core/debugfs.c |   3 +
 .../net/ethernet/mellanox/mlx5/core/ecpf.c    |   5 +
 .../mellanox/mlx5/core/esw/adj_vport.c        |   6 +-
 .../mellanox/mlx5/core/esw/devlink_port.c     |  59 ++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 398 ++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  43 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |  86 ++--
 .../ethernet/mellanox/mlx5/core/pagealloc.c   |   3 +
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |  14 +-
 .../ethernet/mellanox/mlx5/core/sf/hw_table.c |  89 +++-
 include/linux/mlx5/driver.h                   |   1 +
 11 files changed, 595 insertions(+), 112 deletions(-)


base-commit: 33fb2e2bc7a43c79f02dad79c39ff04ae6dc224f
-- 
2.44.0


