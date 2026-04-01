Return-Path: <linux-rdma+bounces-18918-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L8+KNlpzWlmdQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18918-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:54:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6CB37F74C
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F21F83055FFE
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 18:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4390047DF90;
	Wed,  1 Apr 2026 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GWp0rcEG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920347DD7A;
	Wed,  1 Apr 2026 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069520; cv=fail; b=OdD4EQ7RAU+d3Bt62iJ10OUFi94TxdUTYUs6jrA8s1+ssOragzCOTTkzARdvVo49w37AlmJKE0NTGS2vv/gVYuWJEr++UbecJUCcig0XJKdRTPERE81VxK8IAfV/RHW3totuw5nh7tnz/3gm8bi+SZOXmE4mlvOTrycp2ZGD0RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069520; c=relaxed/simple;
	bh=1wk6AlUem+41e379GJdzzAitgdQGaEfZLKHC68xwGk4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plLn6N6H23aQc7+nqCdma+G4qYXVFY7wNEDUjsL6jmjMOtm6yURGz7nQ38ceGGoCPDT4if1WgY5pLcUIHjjZpMcaMUgmZTAqZ45apV8hqV4ZDJn/aYK8hrJAg1uhiozRx2IfaTAAGLFdyuNP5TEiZqy+94r57UsriFacG7SJgA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GWp0rcEG; arc=fail smtp.client-ip=40.107.209.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmpVyUYCjX5HmpuOBSu7vvuaYnGL9seixYst5ta6d9Nlzy+8M7JT6purxsLUGnXv/h1IFhwM5+/5BH59VOxxIiNP2tVY/MEPPThSmv5R7RnhfH1winjD6Coei4C/TS+WXCT2HQBzG9TvsA8Ccy6czbRTJmAM9mUqfW5W8er3xHlT1esyxcD86m5s6Z6dJ9x4DlG5cXW3n5ZrxQ+/5gnoYL9XJ1RteqItcQMhNNvm3X9LWUwJtG0Gs+WYF+o1o5UTDZCKbMFB45GLk8dAl7IcwbasNq9Klj8x0fK2LZZjRYzPY6onP28XaOl3hzLEAUIoWDAsXjPbGBiUQrksZ8g/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffr1wsQ5FqD3H8gh7GFFpffBcqh8z2EhjNy7f2ZzLB8=;
 b=wX3MjuuTcxSEsLU1/ZnfyqfuRK3B1p714sIyy9+n08l0hZoCrauVJMC2iySOCRltMHm5IbbbiXYq1ptfD21TbXPhBKm2Cyyw53y7mDdOIVATbmPlU65eJO5NlCkioDURMAeZxeKjCmdAu6i66S9elXO9oc1hqocfNfW8WzVsxcjXJns3nGFbhpNxKPUN6FYu/NHWJn4d2IfliWSfd8RJjKaV0qHtvLnznjyrf2ufAfuwcukguuUJK7gHv/+qYwscfVsqpicpihbIVNe6K3MNi7JWCeJkHgvgF6qiIE1JNOAVZ1M6Er1me/e9C786FIaGbwbK96awlVcVuQC4LEGv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffr1wsQ5FqD3H8gh7GFFpffBcqh8z2EhjNy7f2ZzLB8=;
 b=GWp0rcEGx6LzyIT7ymROlReKIS2AU9Ctv6uu2HoPxoGgrAHWXfbIzIvXQgX/5rE+iQpIi9+Jw/PR3nC0ah9Kf+3jRmsRM9zQVOyeweaDt2ITJXKYAF9V1BZkGX8Boi0O/XuoXzYhTaEf4XtlAZp5iT/DJMlz1snkgBPsww1CJkFCahvs5NBisHE8/U+YYmU+7BRDRPyTVs7MeJhjT/N7p9EWZM+10PvJ//wr31+Ve6YPKLPN9udHMQzVRgjKSlaBrC913REmukQqEiZibKhRjW5YmwvTCPfi2bFUuG8j9SPGzxZR4OaZHTw0HQ/JeMtr0kmgpa9NGsL4j0Ng4osXMg==
Received: from SJ0PR03CA0347.namprd03.prod.outlook.com (2603:10b6:a03:39c::22)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 18:51:52 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::3) by SJ0PR03CA0347.outlook.office365.com
 (2603:10b6:a03:39c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 18:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 18:51:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:51:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:51:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Apr
 2026 11:51:24 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Shay Drori <shayd@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, Kees Cook <kees@kernel.org>, "Daniel
 Jurgens" <danielj@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V4 08/12] selftest: netdevsim: Add devlink port resource doit test
Date: Wed, 1 Apr 2026 21:49:43 +0300
Message-ID: <20260401184947.135205-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260401184947.135205-1-tariqt@nvidia.com>
References: <20260401184947.135205-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 3851aacf-7d33-42dc-3286-08de901fbcc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	d2QP54WinzBrHhvtk8ARUqW61ACsQ02Fo7+ARSSfu6HajovDdQ1SwAzu6s+ZBmLRuFYZrUV3KWHrAe7Sma/twl3wbFKAxP8DjJICfgR/dnCljJ7GGM0HRwSUq3oSfLEI9Kxj0bSZnVdJCkeeBLjysK9mBvTu6WvBJgqrV7lLaiQbJ6w+Wlvbe4aMQ88wl45+hbpeVC+DsMRHu1jE2J8VjYsuG2EB2y+OpoUSoXxh4st3h+po+/UVtzsg7wlINe7DWxqcLWlLbh+D7sfbTzVtO7wLs3Lw7le3JA96zDcBC37XARrLvl5jwl296tO07DFMthPgzjZ9GTM94R5kLOG5N09Imlq9cPh0QIStzSsj5Tcp1ZdJ1MW8RF2I4ip0TH/nchwoyuLZmCUDCRnzzu2gWTyXVQ48rLxnuSSRRi1HhlM4ZULuJAKeADEcinGbNT9LMh4v1NpBxUZ1xWkxbT/xZGug31KX+bHU/G1pRJJHIgnj40wumPnAOG9oSpsgRKqZ8sKsVqAo6blSdxih0lPdhdhytcVWEPLbrxmpM3nONETRyglxhtlbNPKtnYeYGHv3eozddKJTPBLfsYkhrIoVMxSfYfiQUppxnfIPbuNvdIfTpEGKeF+smxLBgM7fHiROmJ1FkiGiCPjhvVvvIYZh9ZkhxEMxKrwmVMLCj3KR9W43fweqhemK8VGSqWluxnhTvJQ7kuK3AjgApAeS9UepXPmMDhcEBh1Rkc/OMtQn140D0eXX87pLZsujyI8+8eA8L80hzeM3EFOl5frC31ZLhw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iQKU5GIz3KM8xOSRRaewzY0a1WK/UMiAxHZo38WL1u6UHdqOiBq3CSB5So7+9QPAJhVyKxQfPCc0YHoJP7nQLkRKwttQiIIj3l3Rz62A2wKXwY9plv25jJpgQ7LsWVBWR7r5Ptsf853tuT1L9J2pbtU0gvW/ayctcHziy5hfTus9zNZA6SHi3ixnDWRYWmAawBn25aDKugWKegGMGizFBqynh2zCIS00of6EMxwtXhF15yn38XwGkQGiLrFeN4r7OxSCS7PeRLJ7EUcA0cKcl4bYkRyhLmoAVDt6QTNt9BflKa81OzRFAmlG2YPO+jVTWncjR/GheQOEEZCq8Dt/TYnsfIE7807wITYsJrQgxoUwL9ZAdIPN1W+xKN3IY8xsG9ssfyxlYEvsjaJyU8AfbEvCz87FRfUWH+C6hSkM6dOihzV/Pg4h10JAh/8SahSm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 18:51:51.7569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3851aacf-7d33-42dc-3286-08de901fbcc9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18918-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8B6CB37F74C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Or Har-Toov <ohartoov@nvidia.com>

Tests that querying a specific port handle returns the expected
resource name and size.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../drivers/net/netdevsim/devlink.sh          | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
index 1b529ccaf050..2e63d02fae4b 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
@@ -5,7 +5,8 @@ lib_dir=$(dirname $0)/../../../net/forwarding
 
 ALL_TESTS="fw_flash_test params_test  \
 	   params_default_test regions_test reload_test \
-	   netns_reload_test resource_test dev_info_test \
+	   netns_reload_test resource_test \
+	   port_resource_doit_test dev_info_test \
 	   empty_reporter_test dummy_reporter_test rate_test"
 NUM_NETIFS=0
 source $lib_dir/lib.sh
@@ -768,6 +769,32 @@ rate_node_del()
 	devlink port function rate del $handle
 }
 
+port_resource_doit_test()
+{
+	RET=0
+
+	local port_handle="${DL_HANDLE}/0"
+	local name
+	local size
+
+	if ! devlink resource help 2>&1 | grep -q "PORT_INDEX"; then
+		echo "SKIP: devlink resource show not supported for port selector"
+		return
+	fi
+
+	name=$(cmd_jq "devlink resource show $port_handle -j" \
+		      '.[][][].name')
+	[ "$name" == "test_resource" ]
+	check_err $? "wrong port resource name (got $name)"
+
+	size=$(cmd_jq "devlink resource show $port_handle -j" \
+		      '.[][][].size')
+	[ "$size" == "20" ]
+	check_err $? "wrong port resource size (got $size)"
+
+	log_test "port resource doit test"
+}
+
 rate_test()
 {
 	RET=0
-- 
2.44.0


