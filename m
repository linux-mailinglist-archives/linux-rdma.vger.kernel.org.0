Return-Path: <linux-rdma+bounces-17248-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDbwNRfHoGnImQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17248-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:20:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 061A41B046A
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64C5D3041282
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 22:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784D93191D0;
	Thu, 26 Feb 2026 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kIaaVgsF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C8A2D879E;
	Thu, 26 Feb 2026 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144399; cv=fail; b=lKkSQgepTQxDltfjPRxU6tlvUMAyjfSZU2tobeuDxRr35Oo7D3+YMPbJRGAbt3QI+fywAUMj9kHDxU4jpDNFBmzKddKxzGjDGR841MWRGuswDTCEq6e+RnSHb+z6FLl85F8/wPGqhVY9nwpx2kE+yVZPyqqIYpKQaCVHaOQx01Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144399; c=relaxed/simple;
	bh=KsOweNaBg4MRXw2+Cqi8aIqhD+/TQpmnpwr1AWNGHIM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F9LJnHjEACXUTy1T7TqFfJ6ttvJ48pXKlCMMIzzg7kPbHWfzu6qXJHfDM56z51dHhPlW/h3kN9on0ojBJJ9MHhsfUjqV7hUx6u0/dezQYEEX2Sd/FLFjVy0DEQpAElPOHh4MshYzSs6VUIEFBYwaXd/lrtxLHkR2QJaR+DpNTnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kIaaVgsF; arc=fail smtp.client-ip=52.101.193.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVygOjLsMoOh70nQ0PfvFT982KuYSmNBeuQdermYPGFis3XHgV1ChVirSd3LcSEmFJZZJcjpyJ8XsgrS9T6nrl1tds27+bSOxl+3OmXVYsISmfTffMBiywmHScFacfU3ETdkRZOWwGmm5QW1OzKZkjEwezuvAcci3LXuySm0tnJXmGKwOuGjlVdy7TsTgthC3hg2944TzyQDun12Gqv+8sWhb/s4S0udOOJX46tS/JnaeQK7CuPACPKNHGpGX/aE9Z8m95vHZYBZ4x24SFl2iQen3U5P012rMLfOa4+03x3YzNB87rGWgyYlnmu4BeXGTy+87hgghKY0VjSizZdcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nHNhrKmFylZBQwf1jSlLIZsbY4cFqVl80yDJ2PRuDQ=;
 b=NDdCCNOkNiFLA1PEzPx75gLLdsizES3gCmRpyqsTSonx9YJxFFXPsRmirjIcik/9AfJ/RqJ8aU2BNinSyew/osKe26xSXXfzLogg7IRTxunRuAfYsDANutWtjbCuVFMPLFaCNPCXSBCDmpK9NfKXny3Y/ecP9o4rMehynocde9o8S9tGetB2jSwgpmDiPf/n1CGPrh3MIMm8qXOcBQi2WHrbBStQHvNDp1d4l0phxPdmN6gkE5nvGeyC9S54Per/mzVhthNTOFUW0Jpvxz4ts6obuPkIYYUl90FPkPJy0L3i9QEOJ6+cKenUa+uFmp/gr18U070PW5+wreA5/mfr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nHNhrKmFylZBQwf1jSlLIZsbY4cFqVl80yDJ2PRuDQ=;
 b=kIaaVgsFqv8gq0vu75eD25uCnxEoFVCYuLUue6D2aC5uyfRCVJvOWeTBFLHSpNVNqE83iY13v4FcBs+g/Gu0+2UtmXuLv7SHZ3UiqfRBWIsNFn+DdaTGti2/eA59UO/PiQw/gYuRkm2vJ6JLrpcLfle/eKMV2eRuask1Xxvp9XY0K/5JG6Q6N46IkvsD6YeY8z/g4kWVtQKNco3BCErPSwy0KZb+OPfsq4Wj+UuwbQrRaPu1NAbscstsv4UNvzPH0ia7U6jfkXx2BzJ1QhG1yehZ9hxDa59IX4EK0NO7+Oga57hXbkIR3scplKObt2uEUZ1/uWARnUMwO+VkY4CR1g==
Received: from BL0PR02CA0007.namprd02.prod.outlook.com (2603:10b6:207:3c::20)
 by SA5PPFD8C5D7E64.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 22:19:53 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::d1) by BL0PR02CA0007.outlook.office365.com
 (2603:10b6:207:3c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 22:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 22:19:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:19:28 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:19:27 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 14:19:22 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net-next V3 00/10] devlink: add per-port resource support
Date: Fri, 27 Feb 2026 00:19:06 +0200
Message-ID: <20260226221916.1800227-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SA5PPFD8C5D7E64:EE_
X-MS-Office365-Filtering-Correlation-Id: 060234ab-1dcd-4cf5-aa32-08de75852a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	rUqLL6JzA1f4vScEarb6l3FE/q2kasUqhLfq5JOSfKXdgvmWQDVjpsDww5ZCwhSv02lLdkNnNdAcLib+ouLGi178pNrictv93vyNTuSzMKVUNogMWSNkbTmRVNraNV6SpQ1BvjpG4ezye1VKCRUHUb14f1Pfdm9xSsHHH6T0r+09eGeyUea89aThl5gNiOr/Wud+PVhzD2NX0HW3a47pf2/07d/oHj6s+WUYu60EBr4e7cJYYkfHykZmZ0VpLFKjl5QydolyMYeqm20hSV0CKNZS/tcrcmJmzyDIRcOAnZu6sjGlXYhGk0lj2plr1RxWiVedV8LV4Jfmtakl4GjBxc8iguLjL8/kCHRgXCHETgrAhlji69oFCRFyzC32jrs0KQRb0pC3gxbLDDa6bT9GnnSvhh2s9AyCokH17mDqlqeuKp75TE1y2AFAEJvQKlcCfVLv9drkoo67i/Ili24Q+Ne0L+SMmRgjcMvVREIJJnr4oSSUI2RypHOYH0RUTjAG5Bo6XVeYHN1iRSPmTfTVXVWRWCKW0bXCbErnXWPg1BNmIasJgi8bxnAdVjlxY5j9qAxTSa3JLJNgdiCBSeBxvVw8EEm1h5AO1sKNS0vQ0UpEJVc9IzCXfUV9mr/AP2nfAyOWvclxyKcH1fnDnifEY6rKGwKuansqMcxhITTJ4MOnTM+SQNkLbdqhLu8Y/joUONeFAiJqSl+mk+aW7ALd9XIWQqjUIaEkGqRNuOJq4jBVAShKfuFe0HhuoUSof+Tw2Sz3pvAiDY6BPf8v45LCLejS+it6AfhqMLTz1F5mxlbLjXcOzYNZeTBsqYbPOZevNmsdKg4wYQBBm9Io8iQmaQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rndv18Ltcpo3LPYDDvkPbFcKuGHDK1d9i0qUPDKHl0hCDuSelLuX5pXDusgwenmNoq+46jJg1eCFVdYV6D25kdOssjlLAtX5ymkUn6FGGBh6ABsU+3+O4ofx6+0F0SD5wM04wegN28O80wffUxLcTAPREB5b+JFs3j+rJ80G9rRgp5Us8X0/OXReOolxfP5wnYJFaJUz07WO75lnh0a29Tphp+yb8MoeroCrELVCaTVf/pK8febwc4Tt7G9VZT3pQiJjWRELTvhKmSpe4T7BDoWkevL0Heblktr39RpcaH+H0a4qC7d2j6F9O7Bd+XeEPp3/cDpIyS27CZ8s7BmWiBw0910ybQd6LpLocQJ5HXBvN+KLiRnC0W4SZ1C7N11qvOuarlIep6Io6RTgi/vaRVqReEesHtKXwvJyRL3Zx3ZgBU2sc2vMqc0hJ3DRWWwN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 22:19:53.0049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 060234ab-1dcd-4cf5-aa32-08de75852a2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD8C5D7E64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17248-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.954];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 061A41B046A
X-Rspamd-Action: no action

Hi,

This series adds devlink per-port resource support.
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

Patch #1  adds dump support for device-level resources
Patch #2  adds selftest for resource dump
Patch #3  adds dump to resource documentation
Patch #4  refactors resource functions to be generic
Patch #5  adds port-level resource registration infrastructure
Patch #6  adds port resource netlink command
Patch #7  registers SF resource on PF port representor in mlx5
Patch #8  adds devlink port resource registration to netdevsim for testing
Patch #9  adds selftest for devlink port resources
Patch #10 documents port-level resources

With this series, users can query per-port resources:

$ devlink port resource show pci/0000:03:00.0/196608
pci/0000:03:00.0/196608:
  name max_SFs size 20 unit entry

$ devlink port resource show
pci/0000:03:00.0/196608:
  name max_SFs size 20 unit entry
pci/0000:03:00.1/262144:
  name max_SFs size 20 unit entry

Userspace patches for iproute2:
https://github.com/ohartoov/iproute2/tree/port_resource

V3:
- Add dump command for device-level resources.
- Fix selftest to expect the "test_resource" registered by netdevsim
  instead of max_SFs.
- Use a single netlink fill function for both device-level and
  port-level resources.
- Fix documentation to refer to the GET command (kernel/netlink
  perspective) instead of show.
- Link to V2: https://lore.kernel.org/all/20260205142833.1727929-1-tariqt@nvidia.com/


Or Har-Toov (10):
  devlink: Add dump support for device-level resources
  selftest: netdevsim: Add resource dump test
  devlink: Add dump to resource documentation
  devlink: Refactor resource functions to be generic
  devlink: Add port-level resource registration infrastructure
  devlink: Add port resource netlink command
  net/mlx5: Register SF resource on PF port representor
  netdevsim: Add devlink port resource registration
  selftest: netdevsim: Add devlink port resource test
  devlink: Document port-level resources

 Documentation/netlink/specs/devlink.yaml      |  29 +-
 .../networking/devlink/devlink-resource.rst   |  60 ++-
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   4 +
 .../mellanox/mlx5/core/esw/devlink_port.c     |  37 ++
 drivers/net/netdevsim/dev.c                   |  23 +-
 drivers/net/netdevsim/netdevsim.h             |   4 +
 include/net/devlink.h                         |  10 +-
 include/uapi/linux/devlink.h                  |   3 +
 net/devlink/devl_internal.h                   |   4 +
 net/devlink/netlink.c                         |   2 +-
 net/devlink/netlink_gen.c                     |  49 ++-
 net/devlink/netlink_gen.h                     |   8 +-
 net/devlink/port.c                            |   3 +
 net/devlink/resource.c                        | 366 +++++++++++++++---
 .../drivers/net/netdevsim/devlink.sh          |  53 ++-
 15 files changed, 581 insertions(+), 74 deletions(-)


base-commit: 90fcb0f3bc5ab67773b35030af68ed8c6bd83e1c
-- 
2.44.0


