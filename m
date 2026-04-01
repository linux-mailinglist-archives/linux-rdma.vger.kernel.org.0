Return-Path: <linux-rdma+bounces-18921-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOI4IR5qzWkkdQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18921-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:55:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F78E37F79C
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B11C530AF387
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 18:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D11047DD56;
	Wed,  1 Apr 2026 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V8qprRka"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61253F20ED;
	Wed,  1 Apr 2026 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069562; cv=fail; b=qu7/vL7kSui+5/zWbYENH1Ed1Zi/xCO48mdg4b07FMEA10IPhv0wguRHRacV7NnlbBIJRxwKA2ltqXDqX3ZoX22k9QadgE2y4mqK2Nl336jQH9ukrTdkeXB3QybnnDuZ99998SXFpS3UvKqo0k8A8hFsMnGQRoTA35XydUJu+SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069562; c=relaxed/simple;
	bh=Q37OQro86zkVqsZNZ2jfTQigq2bLpjOQaoHHWYgUlpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCDKZlC9NI2VVGXzF+KaXfHhMCJxHevGJdpsbsnL4zInT8lTeh8BPOlu2B/CBG5cSGh4yabGmtgf96ZR7bOlpknz1L1UlrtmI7SqdCqV4fgI99vM94X0odRgMwtqfsEv/rclKl6Nvo2962PJssRxlJx9Ao3fk1AcR7Yun0zFxiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V8qprRka; arc=fail smtp.client-ip=52.101.62.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7JaOnTQmAE90ORwd9ayn+cM4JM47csxOzCgdbz9rIrfshYbjCWVn+f8YnnhZ5rXAv0amJUVojRLRN2w8Ygm8tNbVx5dyLRga2wy3rEDWM0azrECMrxGKji8+cOgHnRvKAjsEIUOsIJzmgGXpknaQycqifH9K0n1VxEN4ArkO1VcDtoza4bB0c2L57wnKTRhyJpky/Fr3sfWyltACtt+3bzSRhtJzOkYvWtklMetAxoAORB1ZRXNoY8uUePzAJi3+GuzNeip48Qovfg+ki+nlqVnkMOMSkc27Hu7blE+wvRvg8S2+Hla1JrHvoWkkUy+bcNHOYM0Ywb6HM6FBRDm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OxWFWpc2ka1X4YsoLQmZVuudl4WzC15xlZy0IEqdXE=;
 b=o8riYiYXBA7Qdo3IsCIAK5imODQQSoXiRLKltOhI/eN7+lhtY2Yu4ONm60DFFVNREdoxMBQ705s8J97a8E4w2bHt/4j+h3hPNhZNZAYXp9Px8A6N/TYBcfQnwdh11u5ZOxPM5R3NRPpr4YzrHnWDYE/GU0Dt+N+4G05pP+83Z02j5vjXIK+gcLPQOn2gsK6S6FRd8ijVqeEZFgYhpxagm2J/msCiqSM5Nsshh/RvfFO/S8hpGF4sXVTfPevYcdGST1XER+9rJzMTZFm+Xxlxg16QYq43akUO95YNzD2Hmkp781VLpHoJ+6EWdC35Fdz3Uma9vvrLSaTxJT6+Gh7ZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OxWFWpc2ka1X4YsoLQmZVuudl4WzC15xlZy0IEqdXE=;
 b=V8qprRkayo0pS/BATcM7h3jO1hFMlaIKeXZveENNNSImM/R9Gq7rLNHfB//7d0IaCl6fGgniIF9WAJKPCVBz6N8PRN6mR7UIS+Thb/MOH8mwA2FW7vqdoR4hlU7heFEICuA+KVLDXfXhiEzreEfMplPo/c8d+Nryt5eHug0E3WbIBD0OAtrZ8lTV0VtTUyLuM0NEp3GYhiUovbGZksotmsKZYDvvCjMHBkqcDRIo4ePDEb5Wt/XDKo0z9e4jXgJ1k1hcaD32vaDhOFKHyUu0hU2uDg5RdJyB5IFoFYHZ4EkDLSnlLeMkaufoWQ5Zu5uxdYITs9Bt8UV58m6cGXwMww==
Received: from BY3PR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:217::32)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 18:52:26 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::d0) by BY3PR04CA0027.outlook.office365.com
 (2603:10b6:a03:217::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 18:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 18:52:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:52:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:51:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Apr
 2026 11:51:51 -0700
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
Subject: [PATCH net-next V4 11/12] selftest: netdevsim: Add resource dump and scope filter test
Date: Wed, 1 Apr 2026 21:49:46 +0300
Message-ID: <20260401184947.135205-12-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eaa493c-0490-438f-84fa-08de901fd10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dbhPts/v6dtoGKn2sFGgyY6bSoVe0s6kdqEB4uPMc+bUTS/dXr5ViG7lrI/W+DsneQjpISFI+BkgTPQOAZrRItukIV++rrTHW9KKyhQ9YcqcNTTKJHBTReQpkGT7lV3W02Z78L0ewVSO5aNNKOVFVks2TdtLJcTPoKU+HRWRPiPBf2KfzgdAgi8+b6jrX+x5iVDIbedc5IWqxbGzresMzlIk5/1E11EOtO8bpfYuGeDLGjjWLyY6nBywRtVXN/l9/VHjrtF1i6YMhOtuIeB1IPPOI5FB5QjhqIqpfV77tH9pRwhm3NxKjRO1v83nrtjjkebEG1A5QsCZJHtT5Kgtd1bwS4F3ojatbOn3HoV1N6jAlMfp+7HCJhCkdjTIDvDY0F3hOB8w6YPOOE5s4QdhmcoaGGvA5+peej5jJasxwlJ3zmLtPUV9pqQYPv9txKpTA6ZNWtMm8kyf3Rj97aWuMAehtalNjwoS6zWrNeTt+S+Ez7VXnFS4UbYtDArDAYdedpmTr4zRIpD/0OCGYywo34Av0lAXsgyQjyAaSjimWvERchbx/G5orBKCC5fXgifQ6EGUrBnFSnkFPVGLSvgiB0KPdCcFKwRqsuJQcd5IN0j8nqBYVrwKl5oU+mq4QUfm5WHU0Zx4hdBQg9BQfu6A9bQAHKrnD2WiLEQ/VEUORbDibRfXFn95iSEej1EYRcLdvBwq0rMVSk/6z34FBxY96yOIjp7g3ORovGQo6bjR2A7axMDf93LWiJgavQ5lqfCZ6kGxKKKOZOjkq7K6NWcHkA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+U4hH13eDIlivHV+tnQJ+5ezosFkx9haPqUG9Wv4JYrn1V7IC692O+W/gbQXqyAggDnJspaVSIGFhf4KJSMPTjhbIn4gOW7SBVbZ71cHYP5Y9gCIoa0GnUz/6F7PGnXR1dsw1Qa7ExetfXnKfCiDPH5h9Owtyzd4z+v3fqTYp3yfx5VNdgBZmdzvMf7OLbJZ3ayVfDwUxm4apDvBSRG7vDx+uHsT886lrFZDj0JDK5NQ34vbp2DJoPrnizPPZWGxWZ4/Trps891TApp9xOd04Pfo0Vg/cA0g8PQtI9t+hc2d9wVzlO0Ii2ZrJjDdIrxEi22Wak4S0mDabGj3FRv6308nlp4f9o37T8m/Vl5wqO+d5ZFpjuO1jtiAb5Bem9pP7Es+Oidr6p9U9+wNHKNR3Ss0JKOTv4CEz9wmum5x90qx84bSB/ml+AxslR7482RF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 18:52:25.7791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eaa493c-0490-438f-84fa-08de901fd10d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
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
	TAGGED_FROM(0.00)[bounces-18921-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 6F78E37F79C
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
index 2e63d02fae4b..8118cc211590 100755
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


