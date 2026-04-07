Return-Path: <linux-rdma+bounces-19110-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEgfKcdf1WkF5gcAu9opvQ
	(envelope-from <linux-rdma+bounces-19110-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:49:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2734C3B4022
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 21:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48D6931210ED
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 19:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9537C379993;
	Tue,  7 Apr 2026 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZNZgRQJW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB163793B8;
	Tue,  7 Apr 2026 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591003; cv=fail; b=Pq1/R4KVIK0ca4Ahyz7Pj+p8vCXZ20F7FTSZ0Qf8K4kRz/lLFyzvUH28kkm8kptMc5l4QbfJ6ez8ebOiDT9VU1rbsNbPMMab2K92x6WeglO0o1WlcCZVFgG4m0fZzOubO/m7bToc/Ec76xS+uJh1RZ3GvLbYy+7oXA5kuAJCA9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591003; c=relaxed/simple;
	bh=aBDFAwL6S2nMOmwI6XMGS7v9IbCzctA1H1zY11TyZGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdFHbNq99lQbxj1Gai4pMBumB4g3iaDtvaBF5zZeRnKvy1ksBqqrE5y0Z21+QXxMd3//eMqM92xwdjzzooXGC43+VlzclC/SdYioy5QUB5GeJY46L1oe5/BE0DaiHO6kaALOjRa+i9I4Kf7C95HxAmlNSFfN7gys9nt6cUDh/ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZNZgRQJW; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QF/YTzv+KKKQVTuSlYRnkS8H6QQ5GlpC1/Y+5UB17FYdb9TYSPj2aN2tHxmTlwrKtDEwsC4Xf4qKkG+ijUI7tMBY1Kj2tNotgXWy4sGsh3RfCJXrO3UqzD4CUEfCncmbI7Ja/ECh0zF4ZCFfX03Vifrcjc5vkHf9RwgZBeekeMVARueoL17A8mmpxH8XEBqhaD9vLid/sJ/Rw4M8V3AxD4dR1T2uILf3L7s9fd3KAZ1MooxiZB5fwVNsdTg3iKvhwK4ZAuy7llNpTTZBsXCMCN1oV7FUFt87328YOdoTsoVwDAV/wOAh66zj3l1eyvciZfO1muwDKmiR8qAOf0wJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE/0QTZbVpWBs1fcZoCxjXPlW+mXo8V8kw0XmA8TY84=;
 b=klgBcW6yZNgB1ce5M6gN9dVHrKGeK23fmp/3AfEgqzVba2q0dxCqX84rPkWVidHt8b+vIlt4VX5BmX5ZwI5bzn1PeX00qpiKSHmD2n6QmZm/YPPXua0Oi1IQ7UDCT1ZFaYO7/bdjwkLxxQZYKgHrVpJ7MDj6FOotjst5PtoGoUXdNe6JVgmE3SrxQvVLWejdI/argxTsULT0ZH3Y8ggwr9n/g8ZM0I8r5j7RXqfiuRoNn3Hlzh1F6PgYOPsVmcYgXgkBld54rk25qwOse0W3oQ6OPLRSdTl8tktNXDEWDzomMaFCq7GUGYUtV7w8HMVydVR+/8KHef9AL7Miw1O35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE/0QTZbVpWBs1fcZoCxjXPlW+mXo8V8kw0XmA8TY84=;
 b=ZNZgRQJWCNP1uHV2QlkCaTRVwPfj9iPfIWRyhcu80dMpp/IaJRnfV1dzB0L9gYVFfFS+W9uJRJ/IHqDDjbWxHBBORVrxPYd/NqTfH8whE0nGdDQDDtvix++LKNTVtUsn06VbquFmRSeXRj4qkHuI1hnSA5xRKE8dsKNZEOGsw6yb1+Cg6Hq4E3yFupl3VohAgJSTDJvZXsHw6pqXb9+fXPaKjZhs1iC0mX7OjUkvhkB1nxuJy0LLbGeVIByIxY2hvF3h4YEJRwMAvkrPOwSBGnqPCi18KbtDzJrs1zJIFAwr0wCekOb45g38eOHAhCvcRJyjdUvq2Ixti6J9bTrFjA==
Received: from BN1PR14CA0027.namprd14.prod.outlook.com (2603:10b6:408:e3::32)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 19:43:15 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::4) by BN1PR14CA0027.outlook.office365.com
 (2603:10b6:408:e3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 19:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Tue, 7 Apr 2026 19:43:15 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:42:57 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 12:42:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Apr
 2026 12:42:48 -0700
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
Subject: [PATCH net-next V5 08/12] selftest: netdevsim: Add devlink port resource doit test
Date: Tue, 7 Apr 2026 22:41:03 +0300
Message-ID: <20260407194107.148063-9-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|IA1PR12MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b270e03-a7b1-4e75-5c5c-08de94dde956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	OI7rHLq4CRWC2qBZMMT284CulwwWq5Jtik34GNe1Yz7oul2X5uG84fJ3U1k718XMAgfJ0SdDtgWECJbYoWHVEvbrjX97jVUm9IpZve5uOXKd1MOvjrXxPxJwl8Y55g7/4v5ZF5rVXxJ0d2k5Xv6i7SJ8aJaJoYmEVV0WOXf3L80tRedk444l1W3Vi4V7e/UsvrQIAYMsAvZ92fzo06eeNoRTd2jw34ck4pI11tFtJ3vTRMCqZumJWZxaRQY2xSPwFbsBsScARNSuzq5EwGKWHb+XyTLPeGGdAEmU7e7ZfZTJ/Th14KAJLT7bht3+cmxb4UkAHNF804j2iAtr6rDIrZwPe9y3Q+TAy2OaxhwCehMBVpzjXwD7bQ/s5WFbmkvWLvZMqg486YkaHVYru0ReQPB4yYHNrXoqBlp/khNaqMLu+VzVJHdjcNsJwj2Lt0mtDzjOTZXK6+nuauutPxSe/QO2lufIRUJjeVHAJfD4YSazkdSMQl65evi2VKV/xg7wKtVnZoAXsCNRrH5e3L7TMgOZowFdv+TQIMAwlC1eDLITsjAEYV5SUYCUC1sS/b6nYwf4PFbRMb10Hmp4u/5b+hSTiKdTEGndnFDE/KDt9ifNF3hz/vJNgixm7h24+afEZPGDwoAisDC752Ac8TwP2Gsul9wSsKSAdCtBJ59ZqULFyD291bcaIu0wMYsprzBiN6UPGqO/Gfr+gjVBalBvGeKduAtV8KOQQzPybEtlGTxOCCz4Eqg/POWEYS8P2Jc1MFYiisnaIdDl7tLvl5lOAA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KiQMb2Zzx8xHeKModrYxaICn7yxS16n9fi7OFGnjtHOXG6IRN3ijkT+EhbDZJMNGvSRVu/7cSmEnuJ5GPWZY2N1CwgTWrAZyBB9somUKIIv9WQy5aW9jIge0u1UCAWXj3L0stz8pvjKl0OoEw7D4ML69RrivqP86qi8zrfbH2z6dhDE65UlM7WMsSaFlU8/gjHruIkjkP0Aa/sRKR/gA6v+6yNFNWAmND1lb7DjkuaaPbkaQo8GrDdynwpr9QqRbJp+ABjUuBRCiD5zgYHXgg1uMRM38dTF+D8TX6X72NMOhtRbQMOx/KbV3d3sZyLrB1r8VA5F9+8U39xcqC3fpXVztvNIug7v0ZMzWlVu+tXI5xvx/X+vO+8Gevv+xx58r0Hg7oKWhnOMUOoifR3fRN8cak0bthPuTFCuMGS08wzr5E1JS05FlFbtuGCfV3blT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:43:15.4612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b270e03-a7b1-4e75-5c5c-08de94dde956
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
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
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19110-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2734C3B4022
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
index 1b529ccaf050..31d1cef54898 100755
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
+		echo "SKIP: devlink resource show with port not supported"
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


