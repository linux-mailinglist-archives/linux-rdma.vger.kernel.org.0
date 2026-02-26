Return-Path: <linux-rdma+bounces-17256-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHM+FGLIoGnImQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17256-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:25:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C181B063F
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B9BC30E9D19
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 22:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203A347AF5D;
	Thu, 26 Feb 2026 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OoG6ZP7u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF9F42883B;
	Thu, 26 Feb 2026 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144451; cv=fail; b=Id7yCPu4r1bMhsnVMZ3IXfgpE0wXMQuQQsrZnrxBZE4v31Rg+4xJ4dO90alL0YJAXiDAr5fvNBTI+Q7RerIZwV0ClXaQy/g4e+UZrsQN7AupOzGwNbhs1qTCBbd1N3cCBOho6HAgh1zAJ0ZcZbL//N0NzmSMK8mB3h4kLS6N8+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144451; c=relaxed/simple;
	bh=VKiNoU8ZWEuiiPCUQbDfrDi0zJe4rrpuSqyL5+17yJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uG4Zx8h96Dj8GsKeqRfAqkyRu0Pxdy+PnH+xKam0SCo8KacHY00l6NzeE9co9aFiL/t3E8kQ05YFvZvx7YBFxWyp6ogk+Q2PboFlBd9w79RgDw32cBw0IrhIFoL7u8PAAUSO+83YBX6aO88rjMP/uQ2zoPW+PXZWQdlFBP7QuTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OoG6ZP7u; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HG4SmkdzZLMxAIMRpSHQCT7nPTcEKe5Dr99cAgBZh/7xucldF6GCySQxHErbOBaU4EheRb5Qul6a0SUQGw4fE00Jyg0U/9MIWE483BxGhsnS+BrIf4MIh6yKUDtL57rbtdppxKSKj3ol5J5/JVuzTmLC+H1f+dbV8OCXYo0q0uutQ0qju55gfdFW7xtlser+Vtj2XECHSc8kdqwHIEm/nuGmItSGkUlilnWOtPb5wxWUg0U8dq4rpX7GpEOtRkNMD4lmAm43KGzTNq8bgumMGbhS9O2Yc6hszLKFCRcfsLpScVLVnS5I5lMbcaJv9pCutS5Q424m2mHKcMWg6z+Clg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qELmdfexFI2XWh9HWiVbtA5gdCa0q6NMGSFO3KCpTc=;
 b=gOmiC6IFc5xVAHB/FJ3alZpnBVN4IMQ9pNrlWu/Ix0R2QvcHT36IyUIKZTDL0zCE64w44kJkV6Yae+GkPfZvU8wkahfopX1XZ7QiTKWQdiQIACJUv6jG6Ocn/ndrm0o9Aad9nMyJKqUNcjPX36NIOv2qsoJ6Oz5hIYyNLYjonNnY3FHyaVL9xPDIufFOprCNUuhsDK2i9xl1VnEPcU+WWZj2+M5bA9IYKCZyoTYzTxvSyJBq6CtyGjzBJkKcOg52pA8grHPHX7fn0ZCzIYNOVFuj1UjVVPm2fcUcebqQNmtb+BROMxcWhUuhKOLGaqs5nkGchnrCvtJ8zkpoLUfVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qELmdfexFI2XWh9HWiVbtA5gdCa0q6NMGSFO3KCpTc=;
 b=OoG6ZP7unZ6J/RsbMN1dSsY5mjDnvtD721tYk8JkQY9dyLMiMCSFhotb4U+CCv1PCzSDKNN4UM56jjTkKr0HXAXrz6Dze/WuhjswG/FoeqHFgf2V239rsTmVoI0hKDRq/R2s8n8Y8s9r9DPNRo6D0LNqDSoUeeP8IpOq59CWI7EHCvebuGkAg9fBryIxu4xTcEfW8eJh+gqcRaULoZhISIDC82lvq6xHGUvhlqx3whUn0qRM6JpPg/YdzDOtLJFFZujUxA4VrZDmDz90FK54D/O90vSNnK2xd2QJErVseIPNUxpInTiYZ2vJE0iqLWBRd+heQHMt2G/L95u8pSd53Q==
Received: from BN9PR03CA0211.namprd03.prod.outlook.com (2603:10b6:408:f8::6)
 by CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 22:20:44 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::31) by BN9PR03CA0211.outlook.office365.com
 (2603:10b6:408:f8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 22:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Thu, 26 Feb 2026 22:20:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:20:19 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:20:18 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 14:20:13 -0800
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
	<moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH net-next V3 09/10] selftest: netdevsim: Add devlink port resource test
Date: Fri, 27 Feb 2026 00:19:15 +0200
Message-ID: <20260226221916.1800227-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260226221916.1800227-1-tariqt@nvidia.com>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 79759256-63a8-4fb6-fcd6-08de7585485d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	QGGfpcDgagQOb3F65e1+X1/yBAp5P/u9LW0O+mUFzATFubT7NAUcVs5RxTTFzH8YDihzX7/Dw9VddBEX9nZcS4kIul/1c/MkbWtnAvzy8xV7JVRzs4+sf7QlNuO9AxqU21L8+U5lYTCuZaJ96Kiz241/5fhHm0WCGsV57rPFp6zmVJlPqUFkTvUqg2dMnyRLSAwvJ2a6NyOysnZ2C3SHAwD3trhkIY+vNgAsjWf930qX0abcnNMJh354gmqg90Po4Zqbzc+RoZp5zLo70fYff3UGqHRBF8mLvEvVPYz27ot4ybphpdDaIyzVk1/OXGvn70JdtO2MayW1YzDgk2+BeOZOXQa6yQGdZPxR09Bdwz2AIHjOufAax9Sz87x8spSQA9Et5KrMea8It+OtEAG8bPsg2Sg9dc521EnmWWzgFprF3CSca6YyInBCuY08/ZIAG1Is7H1qWXbnYpGpaQTWCcNB3ppzKz4yXDk0q2hRJcoRGEUS7NH6NI0x8RTlQWp+1xScG/nlkz1/VdInY25tVylz5Nzt9iPrApJaeRNTZCm+W89W2iKW4tzw/xZW5l/446JpR0unuzRiR+5yILz7S7yqJ/zZMlJmUVw2eKEwNC9AVQ1eB+F+IcD8ojLnG3xNa8IH0B4QIXHasxuTQ6XArnKFyQvglDJCu+3qT515a+x7sLaaLrClB8bcvtlkULRgpJTcDWR8cN6mk9SWKi7sqBMRolJPv4Q1OiCEGXuwT+z+1Wxxd9vuoFilkJ6ikw5kzTzIBkMoXwFujtPGayBJ/jJ6DI74rLxjIIqK1HqNrO5XRApBo/bm9LCK4t7YLV1RsCw6uPBpDbOyqrBFdU+jCQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Kk4rXIcQzCb9rFqRy2Usa8mQx1K1gNzMV4aQWx6M0ktT5AQf7D9BniQzt2wNU52X4ttNuG7F403hKO4gPpnHKbfwClb29a8yU7av1g7SN1tEczLyiL00n2Rok2rIrl2tII/4cQuD1sw16jnu24S/zS8gM4J7Gp8JxLXzqIiulJ9ZCiRj2Ogc3ABDDnf4VHkAGBTSkZ8YTsNhVtR6DTnRNTZP0OmCGP7T2iuczvyuN8vlqldDb6zoIZk81dJlqU52GLGikr51/EjBKyeNS+tP0eKFcutVCHJFZg53rnQA0WIlzDkmdR3NvKlli5WwMJwP28t8rGnRv+cmuiIluHNDakZJvTEy9mu0Raqr2juIgBHEyDtsXYVCMfpNKMyzuGw2SU13PcYkjEV/Wf5dmSfwgILe3y5AN3gQwh+TFtXSzU8xIbhKoUOAVh2QmITTCgcP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 22:20:43.6557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79759256-63a8-4fb6-fcd6-08de7585485d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17256-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.976];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 06C181B063F
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Add selftest to verify port-level resource functionality using netdevsim.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../drivers/net/netdevsim/devlink.sh          | 38 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
index 9efd20d0241c..93f6ef3cd700 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
@@ -5,7 +5,8 @@ lib_dir=$(dirname $0)/../../../net/forwarding
 
 ALL_TESTS="fw_flash_test params_test  \
 	   params_default_test regions_test reload_test \
-	   netns_reload_test resource_test resource_dump_test dev_info_test \
+	   netns_reload_test resource_test resource_dump_test \
+	   port_resource_test dev_info_test \
 	   empty_reporter_test dummy_reporter_test rate_test"
 NUM_NETIFS=0
 source $lib_dir/lib.sh
@@ -871,6 +872,41 @@ rate_test()
 	log_test "rate test"
 }
 
+port_resource_test()
+{
+	RET=0
+
+	if ! devlink port help 2>&1 | grep -q resource; then
+		echo "SKIP: missing devlink port resource support"
+		return
+	fi
+
+	local first_port="${DL_HANDLE}/0"
+	local name
+	local size
+
+	devlink port resource show "$first_port" > /dev/null 2>&1
+	check_err $? "Failed to show port resource for $first_port"
+
+	name=$(cmd_jq "devlink port resource show $first_port -j" \
+		      ".[][][].name")
+	[ "$name" == "test_resource" ]
+	check_err $? "Unexpected resource name $name (expected test_resource)"
+
+	size=$(cmd_jq "devlink port resource show $first_port -j" \
+		      ".[][][].size")
+	[ "$size" == "20" ]
+	check_err $? "Unexpected resource size $size (expected 20)"
+
+	devlink port resource show "$DL_HANDLE" > /dev/null 2>&1
+	check_err $? "Failed to show port resources for $DL_HANDLE"
+
+	devlink port resource show > /dev/null 2>&1
+	check_err $? "Failed to dump all port resources"
+
+	log_test "port resource test"
+}
+
 setup_prepare()
 {
 	modprobe netdevsim
-- 
2.44.0


