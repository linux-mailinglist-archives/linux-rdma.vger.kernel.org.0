Return-Path: <linux-rdma+bounces-19113-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHgsLNVe1Wlq5QcAu9opvQ
	(envelope-from <linux-rdma+bounces-19113-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:45:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AC83B3EBF
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D36D3038D25
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 19:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDD4378D82;
	Tue,  7 Apr 2026 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DEh3zSJq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A2A3368B2;
	Tue,  7 Apr 2026 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591026; cv=fail; b=WeX5keSqm/ls4zJPnn47BS5/644Nbue+a77Lg5pE4wX/NrhXZ8lshU2yohS95qgCVLILkWVXCrSYfCjo5p9swYypzGW12Cl4jkL1sB/dMxZrZTINDjcBZxIY4zeTGsS941N9EhKt5xzPnIqRlvut/tH7k7GZNnZ0M98mYZygilM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591026; c=relaxed/simple;
	bh=VBfPhRTaMUASNT2Sg4PohzZ7oN4Fc2K+xkh2xWnuPi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSgGuTMue9qxnloqtNUqo+eP8ryL9Q13ybKC8jkMsps34tIsQCE9lGBRHE/NSMRhRzPFfPJyHWQAOQ7oKHg96lJGpGVuhYWUZ1pEb0k+E3vRG6QiqywUr9R7Umcl3duLQkNXWxMV2bLsGHm4oWp9Ct1+X3iXjmUCoJz4oCaaSj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DEh3zSJq; arc=fail smtp.client-ip=52.101.46.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UY4ycX0j/gjrTbrls7/tpRKZ37xTeNMweuSkqTO6Wg9EeabxprmLM+ZAbd067mzSu17teWfRpUF7Hqy895lITMvcrb31n6LjAJtlFtc+PHQ5MUqz7uTJv7YALNGZDD9jVAwcGIps6nMp+9CdVCFNXOpfi01yc1J/nARQKRQAawQCLjquMUj2JPi69mi9v/YG9ReIVMfMEumelVUMuiynQF0bPhgaiY1HBeXAzugoj3qS1wwgPyg8PGUn8I/up5EpHVg0RXjT3FRFcbCmVTsZcAzCC/RV27ZklXnx2vNaloBKuT9UAGS4dg+1o30P5j6TQYyYwX1dbxaikpf3pz0itA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UaTTHoY8ddfrHH+qhgzSh+2FQ0RmTk0kdcoRLiDP98=;
 b=c2v3Ey3ewbQx6N6EXdunGn55oh8jzaTn3hqM6DsmKXSTmoEJh34puaPDL2xyQZH4ZMxN4KkbfFKRsJlJcXhPfx3UOnJxpHSbKkF7FffZkC4noU6IieUZZfgxoi5oW0WA87Dsx/mMpYFTlBiAmSbOfaCkFJLUXWi1Km82grTTIoBkkgXB/k3ZZLp9efy9kzlg8HAKjt0uDiG0EW4p0lKvgVuprZ9K4pS5olObNtgOLkAN+2SJtnCA5f0s+J3+JkpREzo0885NGC8tZbf2MG6bvLehkOqdw9nJHT8R/OKHkKhJJGA+f18UQK5EU8H3Z4dlcr5pShuvDwfsI6nfUu1ytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UaTTHoY8ddfrHH+qhgzSh+2FQ0RmTk0kdcoRLiDP98=;
 b=DEh3zSJqpXU8W+U5Nf2cw2G7dnkXdxODyC5bussV+8CQ1AU0YqDiJ3SqvuoyjMRbHs1gAOidIyC8WwubCz4zR7D0WShAOCqY+CO3rpTxrOtIbyqTCVhZtdHSqY6Pw3KvxB8Kv5Cj1uK/AHVfd/fGvqaXAy0i/R7FMikLOFaZxdJ1ctFMHFiWnyE2TkXGK8WpScfhyECezr5dnUodXC2WBKzryZTyBiq24Pnc9ligHakNNt1kcQIxQDqKizZ5auECDfMGoJS2m+FyGihp57jgBVhg1eq7tPJTh6pCzqhr2A8Oo6hGCFhXZCwuew83hyZ8CvGdRklX0wpJNT4L1l1uRQ==
Received: from BN9PR03CA0376.namprd03.prod.outlook.com (2603:10b6:408:f7::21)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 19:43:39 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::30) by BN9PR03CA0376.outlook.office365.com
 (2603:10b6:408:f7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 19:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Tue, 7 Apr 2026 19:43:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:43:24 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:43:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Apr
 2026 12:43:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, "Matthieu Baerts (NGI0)"
	<matttbe@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Carolina Jubran
	<cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, Shahar Shitrit <shshitrit@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Parav Pandit
	<parav@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, "Shay
 Drori" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V5 11/12] selftest: netdevsim: Add resource dump and scope filter test
Date: Tue, 7 Apr 2026 22:41:06 +0300
Message-ID: <20260407194107.148063-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260407194107.148063-1-tariqt@nvidia.com>
References: <20260407194107.148063-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: ea546bc1-2ee1-4015-876b-08de94ddf745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZYNfcWiKOmEZ5gGnQS4xJUvovHOspd1P23ZjD4RLPdvdYnSDRj61h9tQOkqjSml5lB5IiG5BgjPwdpnq+hmw9JsG/JfY8cWv0V6QzJvsc//jU0lSqzqpzQRivgQibWxHCAep6WrxWLs5OSe783yeVyjRkupsc8nFN9k4sqBS+/CY2qpvcrqDgdIbQCqf71Z9hhN3urwnTm5DL4Rq+WW900UwsC35QStw7/ni1h5qPWa5o11OX8P+C0KAvX/jAIbHhkp0O2d2Ql5+jBF26W/1luyMIfmHpqFl5bQDhLrME61DYHx5AC/fPuLUZxF5EXYj1rLoC4zDxacsCOM7xFyp08bN+DModHUPRgSEmNR5zKFreKQBIi/Q80r2FUvhubnmM6epWBEPvCS45kwZPj/v/QfhmiUOIh8L2ehGZLCsIcVvTnmrCShvHNuHSbtitROJGiTtpv/jeLiibA/zRW+UogY2oHLTlpJ0xIhAVbuxf7wPefh1HQoZV6IjVC+eYsOOLJP673dnRbLaY1dGMkXZAbzS/cnArmrO7VlFIaPR618xwLhJQBlXNRL5JDXkmmwE53aroLbGCUtj0bHLwomVe7EigD8CrNX5KmFjPxgX80HTlULYhvVBw7Eucru9/2+CrxtJ+ZqbE+CCI5V3v63yAAFsqv0dDqrhDjDKT/NVhTvDfNyohSX0397oUjvo7Gh6OLA7qil+7KtpJ/dFkZL46PMvTCisNHmiXXevracRjUlumwVMuJTLNrgOWeWPM4lP6QZfWlW2cPoNQo94U4qT0Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w+fgK4AszOoCSeihzEkLiwxK6rZvxpOjUuj6FkOh0NufaPs1Q411FCE28APJ662LQ6ZuwFg/Xpm5/OH/kxA7bY9UgGgJkkEcGJrbryEIn+xeqlly406g70UPJo/iW2VuNdgb/Uiik8L53dqWNEye24l1LkD7Gu7p2HyvPnUbsPigHX+VLSiDcEo7ha0QCQVZX4REVKhXR6xwy+FA7ae6Sp3+xv2Y40R3L4Lrdty6LPPR9eyQFMjes6JGqgmGLBzknYy0ia0lFAUwePzWs/1w2OuvDXy98yZKq3tdc69cdsX0Ja4NqoTCc6nhYLTg6YjIX1v4KxusOcj3S/1zXgVt7/g5NdhTc2EwZXdDgpmiYiccegMWJ1dFV9wQnWR0YleFxP7G7IvkbiVgjZHSoR8RPyF5hS4RoiR7v+oSd5aHNaCz5nm+K55JvHzKl5XiDEzh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:43:38.8562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea546bc1-2ee1-4015-876b-08de94ddf745
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
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
	TAGGED_FROM(0.00)[bounces-19113-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 91AC83B3EBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Or Har-Toov <ohartoov@nvidia.com>

Add resource_dump_test() which verifies dumping resources for all
devices and ports, and tests that scope=dev returns only device-level
resources and scope=port returns only port resources.

Skip if userspace does not support the scope parameter.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../drivers/net/netdevsim/devlink.sh          | 52 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
index 31d1cef54898..22a626c6cde3 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
@@ -5,7 +5,7 @@ lib_dir=$(dirname $0)/../../../net/forwarding
 
 ALL_TESTS="fw_flash_test params_test  \
 	   params_default_test regions_test reload_test \
-	   netns_reload_test resource_test \
+	   netns_reload_test resource_test resource_dump_test \
 	   port_resource_doit_test dev_info_test \
 	   empty_reporter_test dummy_reporter_test rate_test"
 NUM_NETIFS=0
@@ -483,6 +483,56 @@ resource_test()
 	log_test "resource test"
 }
 
+resource_dump_test()
+{
+	RET=0
+
+	local port_jq
+	local dev_jq
+	local dl_jq
+	local count
+
+	dl_jq="with_entries(select(.key | startswith(\"$DL_HANDLE\")))"
+	port_jq="[.[] | $dl_jq | keys |"
+	port_jq+=" map(select(test(\"/.+/\"))) | length] | add"
+	dev_jq="[.[] | $dl_jq | keys |"
+	dev_jq+=" map(select(test(\"/.+/\")|not)) | length] | add"
+
+	if ! devlink resource help 2>&1 | grep -q "scope"; then
+		echo "SKIP: devlink resource show not supported"
+		return
+	fi
+
+	devlink resource show > /dev/null 2>&1
+	check_err $? "Failed to dump all resources"
+
+	count=$(cmd_jq "devlink resource show -j" "$port_jq")
+	[ "$count" -gt "0" ]
+	check_err $? "missing port resources in resource dump"
+
+	count=$(cmd_jq "devlink resource show -j" "$dev_jq")
+	[ "$count" -gt "0" ]
+	check_err $? "missing device resources in resource dump"
+
+	count=$(cmd_jq "devlink resource show scope dev -j" "$dev_jq")
+	[ "$count" -gt "0" ]
+	check_err $? "dev scope missing device resources"
+
+	count=$(cmd_jq "devlink resource show scope dev -j" "$port_jq")
+	[ "$count" -eq "0" ]
+	check_err $? "dev scope returned port resources"
+
+	count=$(cmd_jq "devlink resource show scope port -j" "$port_jq")
+	[ "$count" -gt "0" ]
+	check_err $? "port scope missing port resources"
+
+	count=$(cmd_jq "devlink resource show scope port -j" "$dev_jq")
+	[ "$count" -eq "0" ]
+	check_err $? "port scope returned device resources"
+
+	log_test "resource dump test"
+}
+
 info_get()
 {
 	local name=$1
-- 
2.44.0


