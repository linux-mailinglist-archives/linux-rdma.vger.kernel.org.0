Return-Path: <linux-rdma+bounces-18576-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBZ1HgKHwmkAegQAu9opvQ
	(envelope-from <linux-rdma+bounces-18576-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:43:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3D6308832
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEA5B31F7884
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 12:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC91E3FF892;
	Tue, 24 Mar 2026 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GAcmfUl+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44563FB05D;
	Tue, 24 Mar 2026 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355514; cv=fail; b=q+wHgnm8HUrfvpkhM/+ZotEjubfkxHDsn/w00BhR60h1cXXmnYuWbzHhtkt4w+pYoygu1x+NGOZSFo+SOzBdiCRxFWApQuUMChbGaSH2uwhOjVC/lz+/7P1KlHwmMFNfRXDOnQYTJu2qNgVUgAr+UpTLag4WY0s+XXOjlkR8QBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355514; c=relaxed/simple;
	bh=44fJ4asWbtDn0YA2Tiw2NAaqV7jtVauRw9ZzZhKjQeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHjoUInxXs1Mn6vw0EQUA25dwHKJBQ6SKT5VvvFvnLniG1RvOG7fDGdJKpqUocMV9KaBkpxXNyVL0LvxchS8r4YCkkQdBku3vXCKRqK/vLqNbVdNH60HA36kJILwNa8ic0lrzyjVmccN1m95AsE6fZGRNu5CbgiUCbA1tL7MS3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GAcmfUl+; arc=fail smtp.client-ip=52.101.56.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKAhK4VpnlwbHJsbW0v3MbbobxgvBb6f8JY/Qc934rMxKRukX+r8QpdeH/UaV1h9r8f5WsI4JPoWsNhIiNy5YjFlKuF4hLLSl0zEMCXNHfEf8I3nGeDZvcLHy2KJJclQs6ryxOoWJ5CvPe+4L7OhmpsnrbMYYqTY4qxUBgmA6tqs4+rOwVc8hbEPKegmFmrE/b0E/n4/yFhdb5LFKbyX8M0wmwSTQoXr9Q3O6MU+tSwLIkD6ewq/Yzh946BgK8QRWHaLjSQ/qSw+VOhcutkfG5osNUDSSpW8rQew8u1Xq17oWtOwTe91wp9XS4nHe7A6BsthUSh2rql1HUia4wNQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqjUp9YInRG7lY8V2ayrljQvVVBH8B0sYcfz2KZ6gQY=;
 b=HtDGaXyOzo1BNOTIpMat8knumvatca/xFfsOcqMe8tBJ7Zv0r729CUPDVAY7JEVa7Ncxv2mFDyAtNRnRfVdCGG6Loz9q/1O2aYS4qahJrfzhpbtyOz0/G/9W821XEe+5o4kEiQOs/kgEp2eLW90Rc+MWDpU1RDE4pune7yxane9O6e4uPLJkdCx/zLXArmqgK2INAdpCzh8/O71+GPz0LrUYX+BvAOzFCuGQUWmzQfaT6IVCxfBQtmlHU3lqDx5de7qkAkFpRU827qfeTAqZzCfRQ/MSfOqh7nY7/1kG20KR9dJuZmXdborpUiZkDR54PF/33Qb6gXSiXe3HB2r5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqjUp9YInRG7lY8V2ayrljQvVVBH8B0sYcfz2KZ6gQY=;
 b=GAcmfUl+3FatpPet2bmixV11nMXg9x24/CCh4hnpI3CacYifSpvpBn9GvJdLCHt/kXW+aT1pSt9RmKo8qjCnt+rz9km2xoQwiv9atwdPysFgT/OLCvKn655m8G8MYTydj67exdIU/y76GTTU5ktg69lCs9RAEsrtawfkS+1ox3U41KN+9wSuqhWjZ+RiVBv3Rud/gHAcgeQe+6E/IuJLctrQEN7stAqV+yl5/llW07bBnz6BHz1DJP6wloetuvdgc6aeZpN+pU/BsYiiMXzQTYaS4B7QtGBy7AIE7OEkPzE6iJesuSqeTpQkL0Lw7FefrNiPz9ix+3tm885bBIL+dQ==
Received: from PH8PR02CA0017.namprd02.prod.outlook.com (2603:10b6:510:2d0::20)
 by DS2PR12MB9589.namprd12.prod.outlook.com (2603:10b6:8:279::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 24 Mar
 2026 12:31:46 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::ad) by PH8PR02CA0017.outlook.office365.com
 (2603:10b6:510:2d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:31:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:31:24 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:31:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Mar 2026 05:31:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Chuck Lever <chuck.lever@oracle.com>, "Matthieu Baerts
 (NGI0)" <matttbe@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Shay
 Drory" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next V8 13/14] selftests: drv-net: Add test for cross-esw rate scheduling
Date: Tue, 24 Mar 2026 14:28:47 +0200
Message-ID: <20260324122848.36731-14-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260324122848.36731-1-tariqt@nvidia.com>
References: <20260324122848.36731-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|DS2PR12MB9589:EE_
X-MS-Office365-Filtering-Correlation-Id: fd233651-4d2d-424f-4f7b-08de89a14fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5fPGpGCAnHO0O3mosF307+QxTwzWF6WiiKui/rkUdVKh+/LhimVzYImk8kjqy7GF2d08mSEXsdDTmHM8babonmGJMzij8uorvOaFB77HFrigqeSvlgv2eGAfBG0vFfqf+VfT9htD8EadqizKFrezTS3qHnxW/oWPVNsAgHP79bRVKzjPQnDE6WnpqxHls6z7lgwYqKmVeUuePXJViYpQwAXxnavnl/BmUcpnNPKbIIdMsN6zUg4DxTf1yQMPuXQHOcLkvpnZztAlcQncQY95kCUwVw41piEqmpi/01qgsSU1k3gOUBPwGSlvOl+/LGGvFvTaEvLJZqb1wpJxx52lslSyDzgjtHJRkFQAbW7W3AzXeuPdwauV09qoNbqC60G2ttvW/rROlMaB32/2MTvcd0cTGKLwOubXEYD0NNKrBcoEyzAAm0a2ata+mT9Bb96NqZDUWIpci6QBv6wA6QiuEFuHOOGEL4i4syX8Qp1rxalJqpjxzShqjVJxqEcxuayd7qiIVo8hBPHuMgRnR8HUsKI/JDyjrF/Vo/StqtdH95CmhSfmQd0V5Nnd65+aldppZJRNeTm/idrXGZqpJ3uZmKK7bS+IbwL3fkZO5ouu77Wvau/gV24SO25b/IIi3WBcWDL4TQbC+hfSI2Bt4XbEmrMWQ7UWmi+dvBxoZwzlT31qt8Zl9ZBe9SokBpXHohNPNKiwam05cwHpHltes4/vg9pMs3aezzsRqwxFk16Q91QP1x8A0i4osTJD4LOLV5PRngg/hg+o9lb+75uqhPSYEg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CdMZgxxqn6GJxCPUgbS0IiSB4eGvbq57J2hdDS8pZzsig1eSwxiT9KhBtx7/jyCYELJpWNnDv+pBz+AzFJOXVTj0RVFq5pu0I+jv6H/wqfMOJZUwNhjwUILZGQTk+xjpZNqOAUEIktIMJC8zeM/xE9uN0hGkE/hr0AIGABM3c1Ci1n+eTHCzRcWz+PtikU5Nn3u+u6x8MY80zD9QeMUZGDf1X5z5Uy5baJw0PUS7eYtNkHdrAuGiTdtPvlrBz5ViRrUx70hrNcDkjNv6ZjOE7qh812TNKHT53oUy5ctWFeOW5sum8r0g7niQrSKSn2eN1qAcYl6N6kkQt/XLy1wPffJ3DJzZcjvcVN1b/SByt87k91y3BLc3K35d2K+aFPqT+CGk5+EyknGVIdIchGdAsAHNQ+zWHIgRpNOtgwzYafpHvMcsTPhWeYdjVSvlW7oh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:31:45.4950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd233651-4d2d-424f-4f7b-08de89a14fe6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9589
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,google.com,davidwei.uk,fomichev.me,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18576-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,lib.py:url,devlink_rate_cross_esw.py:url];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1A3D6308832
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

Adds a Python selftest using the YNL devlink API to verify the devlink
rate ops. The test requires a bond device given in the config as NETIF
containing two PFs. Test setup will then create 1 VF on each PF and
verify the various rate commands.

./devlink_rate_cross_esw.py
TAP version 13
1..3
ok 1 devlink_rate_cross_esw.test_same_esw_parent
ok 2 devlink_rate_cross_esw.test_cross_esw_parent
ok 3 devlink_rate_cross_esw.test_tx_rates_on_cross_esw

Tests will be skipped when the preconditions aren't met, when the
devlink API is too old or when the devices don't appear to support
cross-esw scheduling (detected via EOPNOTSUPP).

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/devlink_rate_cross_esw.py  | 300 ++++++++++++++++++
 2 files changed, 301 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_rate_cross_esw.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 3c97dac9baaa..361fbb9fd44b 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -20,6 +20,7 @@ TEST_GEN_FILES := \
 TEST_PROGS = \
 	csum.py \
 	devlink_port_split.py \
+	devlink_rate_cross_esw.py \
 	devlink_rate_tc_bw.py \
 	devmem.py \
 	ethtool.sh \
diff --git a/tools/testing/selftests/drivers/net/hw/devlink_rate_cross_esw.py b/tools/testing/selftests/drivers/net/hw/devlink_rate_cross_esw.py
new file mode 100755
index 000000000000..0f3b4516c3b7
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/devlink_rate_cross_esw.py
@@ -0,0 +1,300 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Devlink Rate Cross-eswitch Scheduling Test Suite
+==================================================
+
+Control-plane tests for cross-eswitch TX scheduling via devlink-rate.
+Validates that VFs from different PFs on the same chip can share
+rate groups using the cross-device parent-dev attribute.
+
+Preconditions:
+- NETIF points to a bond device with exactly two interfaces.
+- the interfaces must be two PFs from different devices sharing the same chip.
+- (for mlx5): the two interfaces are in switchdev mode and configured in a LAG:
+  - devlink dev eswitch set $DEV1 mode switchdev
+  - devlink dev eswitch set $DEV2 mode switchdev
+  - devlink dev param set $DEV1 name esw_multiport value 1 cmode runtime
+  - devlink dev param set $DEV2 name esw_multiport value 1 cmode runtime
+- test cases will be skipped if:
+  - the number of interfaces in the bond device is != 2.
+  - the kernel doesn't support devlink rates.
+  - the devlink API doesn't support cross-device parents (ENODEV).
+  - cross-esw rate scheduling returns EOPNOTSUPP.
+"""
+
+import errno
+import glob
+import os
+import time
+
+from lib.py import ksft_pr, ksft_eq, ksft_run, ksft_exit
+from lib.py import KsftSkipEx, KsftFailEx
+from lib.py import NetDrvEnv, DevlinkFamily
+from lib.py import NlError
+from lib.py import cmd, defer, ip, tool
+
+
+# --- Discovery and setup ---
+
+
+def get_bond_slaves(bond_ifname):
+    """Returns sorted list of slave netdev names for a bond."""
+    pattern = f"/sys/class/net/{bond_ifname}/lower_*"
+    lowers = glob.glob(pattern)
+    if not lowers:
+        raise KsftSkipEx(f"No bond slaves for {bond_ifname}")
+    slaves = []
+    for path in sorted(lowers):
+        name = os.path.basename(path)
+        if name.startswith("lower_"):
+            name = name[len("lower_"):]
+        slaves.append(name)
+    return slaves
+
+
+def discover_pfs(cfg):
+    """Discovers both PFs from bond slaves."""
+    slaves = get_bond_slaves(cfg.ifname)
+    if len(slaves) != 2:
+        raise KsftSkipEx(f"Need 2 bond slaves, found {len(slaves)}")
+
+    pf0, pf1 = slaves[0], slaves[1]
+    ksft_pr(f"PF0: {pf0} PF1: {pf1}")
+    return pf0, pf1
+
+
+def get_pci_addr(ifname):
+    """Resolves PCI address for a network interface."""
+    return os.path.basename(os.path.realpath(f"/sys/class/net/{ifname}/device"))
+
+
+def get_vf_port_index(pf_pci):
+    """Finds devlink port-index for vf0 under pf_pci."""
+    ports = tool("devlink", "port show", json=True)["port"]
+    for port_name, props in ports.items():
+        if port_name.startswith(f"pci/{pf_pci}/") and props.get("vfnum") == 0:
+            return int(port_name.split("/")[-1])
+    raise KsftSkipEx(f"VF port not found for {pf_pci}")
+
+
+def cleanup_esw(pf):
+    """Removes VFs if created by tests."""
+    cmd(f"echo 0 > /sys/class/net/{pf}/device/sriov_numvfs", shell=True, fail=False)
+
+
+def setup_esw(pf):
+    """Creates 1 VF on 'pf'."""
+    path = f"/sys/class/net/{pf}/device/sriov_numvfs"
+    cmd(f"echo 0 > {path}", shell=True)
+    cmd(f"echo 1 > {path}", shell=True)
+    time.sleep(2)
+
+    vf_dir = f"/sys/class/net/{pf}/device/virtfn0/net"
+    entries = os.listdir(vf_dir) if os.path.isdir(vf_dir) else []
+    if not entries:
+        raise KsftSkipEx(f"VF not found for {pf}")
+    ip(f"link set dev {entries[0]} up")
+
+    pf_pci = get_pci_addr(pf)
+    vf_idx = get_vf_port_index(pf_pci)
+    ksft_pr(f"Created VF {vf_idx} on PF {pf} ({pf_pci})")
+    return pf_pci, vf_idx
+
+
+# --- Rate operation helpers ---
+
+
+def rate_new(devnl, dev_pci, node_name, **kwargs):
+    """Creates rate node."""
+    params = {
+        "bus-name": "pci",
+        "dev-name": dev_pci,
+        "rate-node-name": node_name,
+    }
+    params.update(kwargs)
+    try:
+        devnl.rate_new(params)
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("rate_new not supported") from e
+        raise KsftFailEx("rate_new failed") from e
+
+
+def rate_get(devnl, dev_pci, node_name):
+    """Gets rate node."""
+    params = {
+        "bus-name": "pci",
+        "dev-name": dev_pci,
+        "rate-node-name": node_name,
+    }
+    return devnl.rate_get(params)
+
+
+def rate_get_leaf(devnl, dev_pci, port_index):
+    """Gets rate leaf (VF)."""
+    params = {
+        "bus-name": "pci",
+        "dev-name": dev_pci,
+        "port-index": port_index,
+    }
+    return devnl.rate_get(params)
+
+
+def rate_del(devnl, dev_pci, node_name):
+    """Deletes rate node."""
+    devnl.rate_del({
+        "bus-name": "pci",
+        "dev-name": dev_pci,
+        "rate-node-name": node_name,
+    })
+
+
+def rate_set_leaf(devnl, dev_pci, port_index, **kwargs):
+    """Sets rate attributes on a leaf (VF)."""
+    params = {
+        "bus-name": "pci",
+        "dev-name": dev_pci,
+        "port-index": port_index,
+    }
+    params.update(kwargs)
+    try:
+        devnl.rate_set(params)
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("rate_set not supported") from e
+        raise KsftFailEx("rate_set failed") from e
+
+
+def rate_set_leaf_parent(devnl, dev_pci, port_index,
+                         parent_name, parent_dev_pci=None):
+    """Sets a leaf's parent, optionally cross-esw."""
+    params = {
+        "bus-name": "pci",
+        "dev-name": dev_pci,
+        "port-index": port_index,
+        "rate-parent-node-name": parent_name,
+    }
+    if parent_dev_pci:
+        params["parent-dev"] = {
+            "bus-name": "pci",
+            "dev-name": parent_dev_pci,
+        }
+    try:
+        devnl.rate_set(params)
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("rate_set not supported") from e
+        if parent_dev_pci and e.error == errno.ENODEV:
+            raise KsftSkipEx("Cross-esw scheduling not supported") from e
+        raise KsftFailEx("rate_set failed") from e
+
+
+def rate_clear_leaf_parent(devnl, dev_pci, port_index):
+    """Clears a leaf's parent."""
+    rate_set_leaf_parent(devnl, dev_pci, port_index, "")
+
+
+def rate_set_node(devnl, dev_pci, node_name, **kwargs):
+    """Sets rate attributes on a node."""
+    params = {
+        "bus-name": "pci",
+        "dev-name": dev_pci,
+        "rate-node-name": node_name,
+    }
+    params.update(kwargs)
+    devnl.rate_set(params)
+
+
+# --- Test cases ---
+
+
+def test_same_esw_parent(cfg):
+    """Assigns PF0's VF to PF0's group (same esw baseline)."""
+    pf0, _ = discover_pfs(cfg)
+    pf0_pci, vf0_idx = setup_esw(pf0)
+    defer(cleanup_esw, pf0)
+
+    rate_new(cfg.devnl, pf0_pci, "group0")
+    defer(rate_del, cfg.devnl, pf0_pci, "group0")
+    ksft_pr("rate-new succeeded")
+
+    rate_set_leaf_parent(cfg.devnl, pf0_pci, vf0_idx, "group0")
+    defer(rate_clear_leaf_parent, cfg.devnl, pf0_pci, vf0_idx)
+
+    ksft_pr("Same-esw parent assignment succeeded")
+
+
+def test_cross_esw_parent(cfg):
+    """Sets cross-esw parent, then clear it."""
+    pf0, pf1 = discover_pfs(cfg)
+    pf0_pci, _ = setup_esw(pf0)
+    defer(cleanup_esw, pf0)
+    pf1_pci, vf1_idx = setup_esw(pf1)
+    defer(cleanup_esw, pf1)
+
+    rate_new(cfg.devnl, pf0_pci, "group1")
+    defer(rate_del, cfg.devnl, pf0_pci, "group1")
+    ksft_pr("rate-new succeeded")
+
+    rate_set_leaf_parent(cfg.devnl, pf1_pci, vf1_idx,
+                         "group1", parent_dev_pci=pf0_pci)
+    defer(rate_clear_leaf_parent, cfg.devnl, pf1_pci, vf1_idx)
+
+    ksft_pr("Cross-esw parent set and clear succeeded")
+
+
+def test_tx_rates_on_cross_esw(cfg):
+    """Sets tx_max on group and tx_share on leaves in a cross-esw setup."""
+    pf0, pf1 = discover_pfs(cfg)
+    pf0_pci, vf0_idx = setup_esw(pf0)
+    defer(cleanup_esw, pf0)
+    pf1_pci, vf1_idx = setup_esw(pf1)
+    defer(cleanup_esw, pf1)
+
+    rate_new(cfg.devnl, pf0_pci, "group2", **{"rate-tx-max": 10000000})
+    defer(rate_del, cfg.devnl, pf0_pci, "group2")
+    ksft_pr("rate-new succeeded")
+
+    rate_set_leaf_parent(cfg.devnl, pf1_pci, vf1_idx,
+                         "group2", parent_dev_pci=pf0_pci)
+    defer(rate_clear_leaf_parent, cfg.devnl, pf1_pci, vf1_idx)
+    ksft_pr("set parent cross-esw succeeded")
+
+    rate_set_leaf_parent(cfg.devnl, pf0_pci, vf0_idx, "group2")
+    defer(rate_clear_leaf_parent, cfg.devnl, pf0_pci, vf0_idx)
+    ksft_pr("set parent same esw succeeded")
+
+    rate_set_leaf(cfg.devnl, pf0_pci, vf0_idx, **{"rate-tx-share": 1000000})
+    rate = rate_get_leaf(cfg.devnl, pf0_pci, vf0_idx)
+    ksft_eq(rate["rate-tx-share"], 1000000)
+    rate_set_leaf(cfg.devnl, pf1_pci, vf1_idx, **{"rate-tx-share": 2000000})
+    rate = rate_get_leaf(cfg.devnl, pf1_pci, vf1_idx)
+    ksft_eq(rate["rate-tx-share"], 2000000)
+    rate_set_node(cfg.devnl, pf0_pci, "group2", **{"rate-tx-max": 250000000})
+    rate = rate_get(cfg.devnl, pf0_pci, "group2")
+    ksft_eq(rate["rate-tx-max"], 250000000)
+
+    ksft_pr("tx_max and tx_share set on cross-esw group")
+
+
+def main() -> None:
+    """Main function."""
+
+    with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        cfg.devnl = DevlinkFamily()
+
+        ksft_run(
+            cases=[
+                test_same_esw_parent,
+                test_cross_esw_parent,
+                test_tx_rates_on_cross_esw,
+            ],
+            args=(cfg,),
+        )
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.44.0


