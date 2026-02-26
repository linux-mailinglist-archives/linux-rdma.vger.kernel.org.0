Return-Path: <linux-rdma+bounces-17250-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFRRHDDHoGnImQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17250-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:20:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC191B0498
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED7003014FD3
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 22:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751D04266A8;
	Thu, 26 Feb 2026 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qqmSxgGB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED13A3D2FE5;
	Thu, 26 Feb 2026 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144411; cv=fail; b=urjEPufN+XZfZkM2zXvw1IDkerNRYA3PwnDJ7RIbe5oXIJh+c1Gm2/cFIqmHlKbC84ebEj4nQ9d/24hcbzxz+GNAPHNPzyQ1Nlc5Op2uWvibrwOg82pTd7k1M9oTXKaxdLXuV830oMzAYnRPq1FzOdgUob/jqZlWZ5ZdCioWoOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144411; c=relaxed/simple;
	bh=M1hnKg8+ixjRzkqetw/Fiv63IuwPUCK+Ao+RVMTpu6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dj51ZzRC6lnNa2qaIRtH0dTtidbEYvuHYyWLS5aWvqyx3B46kiJ7nCn8CYb0wJ7/kZZLvQV9TYgvCPMmg9SdMkx1My+MHXmi/BCm238TQoIJKVEfWENfOtEYZ103RadCjliUKd1knzh10ZEWFyFGoxYBHgV9PqKEIMwPvL0X+Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qqmSxgGB; arc=fail smtp.client-ip=52.101.61.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkJrXMSGew5hiWaIWDBbCc7URysf9KPwm+xG6pvd7vs18a1WTXcBYXWQB3xV1fcLgCLrhKDy4hz70yC8wB7wFnobpTF3SMx+odGMvOF00pYHGr+9j+roLWkVkeCekOAL3HrUfr/bUwfZSJbqGpdMrbNB3nTHZhQoadXCqt7pbsIKwGWTzAW5XHW5oJvOAc9HFivuJPO7lCK37loyQfChh/yzv3eSa0sY8rw6G0bFWX8d7WNAH/5W8IIlu98CP2UIpTzSWgB+zL+14yWWM5qrQCHyJsbTh36fF0RHn45xSIaUzqpcNqHmGF4fPXVQz5Sk/nJDcRkffLuERap0NiVUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4gI8OiW20M50cZMkqPYMSflyihrpEZxvo31uhyTmbA=;
 b=VYkkgxGHOt7+mI6o52qfJU+yXzoF12hU1aMapZydMTafxCQMEHASiEoqKvJTXhfK+Ua/hxgXugMtflzF3b8TRRUSlIOxsx4sfNO1cDAQr4kwXHtc/aXyCJbl7gzvUTgztBCfHZ5kx7eXZfazNsptmrguvYX1Yn+Hit3HOq+nYmy4fLL8K1JCG42q4fHcyYzbT+b+IADkN7rCAwI29ePYgeHhkH+zpoOGy7V2i69mSMTyzWc+p7rTdbia+BPYjFFsWJvjdvaV6ggxYfybPGpDqH+PeddGAz50y5YD3F8O3d0ThLqFfhu8eJ0PvFODWn1mxIRlzfYsS6muUatzlC1IPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4gI8OiW20M50cZMkqPYMSflyihrpEZxvo31uhyTmbA=;
 b=qqmSxgGBwjmTWqfCexo6FMW4BmPHNW8x2ZFLvk0OkkuBiQBDZ0FCLunT3+UJVkawL1P85F3qOPVtZPkoPgiyi8H/RBgjDHFx2AcNfQseeklFZB+qPsUz1Ydgqyl710l0kRoZsJ8ziop7aXcpHJSbTrBOHz9Y3AoaScCoCXcyaj2JTlTtklA2iPqczmPv0Y5v1y8gsKLu9H2Hx35lIFYZH7P1P4y5jAHUA4wXdo+xHB+xCr4WsORUj11U5ogpf54KFlP4xpR3lizJzVI2AsLqVS/wxZbsarzqOfCy5siFRsKpx90MPcLqCygY6vruHfWSHkW1EoO6pG4BNBoLLao1+w==
Received: from BN9PR03CA0958.namprd03.prod.outlook.com (2603:10b6:408:108::33)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 22:19:58 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::19) by BN9PR03CA0958.outlook.office365.com
 (2603:10b6:408:108::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 22:19:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Thu, 26 Feb 2026 22:19:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:19:39 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:19:38 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 14:19:33 -0800
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
Subject: [PATCH net-next V3 02/10] selftest: netdevsim: Add resource dump test
Date: Fri, 27 Feb 2026 00:19:08 +0200
Message-ID: <20260226221916.1800227-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bdec5ca-1543-4706-df58-08de75852d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	Gkb5AqY0p72GmcDMDg//qyVjkmlDjato31dC1kAcI4/JDWnKTpBgfGQDfd4pGuLw/5m4sZoHyovwN7FFCV54ny92ifRhXst+xpP4NAWj5GCUiY13KrcrjdQeUiTXJ9oPdBRIVzxmD2b4JaQB9VMqEqKZEJ9HW2wnDdUUL0NhyKC6S/jRl2DH6CFWarDUEnbPkcSpuvgRrxWyF44DD/nafI6AuZ4Ku1sboMSQLZdD7151DzGmWapVO+BGaedhtRtj06F7d2ca8Qq7AMUlQddI8mrcpUm3esIi7737T14GYxC5WHjSG29BqTQDDjSIjLl9doc+X8fLdBHyuEP4wm19udT1BGWE4IE0Mv0VjJ1mFCqBKrBOTogkXEM5Oqv/iM/X2o7cx9Oi7Fh7dDZVBwHPfNOTsP7WkAnz9xtsnyw9hh2yyznEFCWaAlymyJQPgfEPsnHpDijvn8XhrGeyQoUhE2PznPdufXcBASob5vNNJpDQTW2MrCuo8tLCWGJ6wYq4Y83pD50JL+NeT1GleBJKJnZMQ+mmoksNrYuxW4G7kZefa6hIaNeWXmMXWMffF8KUcX4iyx9M1U8JwchCxO9kzoZq7t82Spa3upVqJLQNMt8j8PXU/4UTHOEgAH3lXy38CboCFf2K7r5Mf8oRrcmVyiTNFPBplsr5Mp1F/BJQCG48WAfHw/h6Nvf5grWBelteqXe90VmpwB2ptLIv4wlw35LMT+ibluRr9EeUp4s7/bzVQhTLeOya/IypdV56DV8FoSSYWrZnmRMave5ODsVjQquXPABadMo76fGi0yTtabBCah9dluPZcza2BTdla+YVdFYmMhFPiVNPyk/uB0t3XQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rKXVEP7kIFm01JAe7Aqg8l820Sw9gG7zKKqf/lJ6D0GmOZJBpCJP82YUoHmPk2HpwxPdPJ/zY2vA50K7EMctUr2M/B4PuHJ7hLyI9LxTmq/6W2ny/4X/G187RCAZO62CR42mQp8sdsBH3XBD/OWoejyYIMrlU4wft7X7qP+3kdNZGjXTjGbs5iE7C2mv/gXaBcreyqmvLs6DvACoEy+AWHjLRYWxbB4+MIIq3stBALfRMup5Tb8Vu+qPxtEN1CPoQB+vtZkwXVXifH9JmQYmfMMqSF5EaSLZOewVSKB4cd13IkymAyExAEgWUGXeczLTja5EKQnpc0xrd9psCw+5xxUjqHnELP9lWnMxO1cmPKPenEKmchWCpVdSVqH+m/anIOjthcbecJqXZ9pzEHiHjOT92DsxbBPMZQkkpQmmhqEen4EHchIv9hgeDlSAwZ6t
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 22:19:58.7221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdec5ca-1543-4706-df58-08de75852d8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17250-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.978];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3FC191B0498
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Add test for devlink resource dump command which verifies dumping
resources for all devices.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../selftests/drivers/net/netdevsim/devlink.sh  | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
index 1b529ccaf050..9efd20d0241c 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
@@ -5,7 +5,7 @@ lib_dir=$(dirname $0)/../../../net/forwarding
 
 ALL_TESTS="fw_flash_test params_test  \
 	   params_default_test regions_test reload_test \
-	   netns_reload_test resource_test dev_info_test \
+	   netns_reload_test resource_test resource_dump_test dev_info_test \
 	   empty_reporter_test dummy_reporter_test rate_test"
 NUM_NETIFS=0
 source $lib_dir/lib.sh
@@ -482,6 +482,21 @@ resource_test()
 	log_test "resource test"
 }
 
+resource_dump_test()
+{
+	RET=0
+
+	if ! devlink resource show > /dev/null 2>&1; then
+		echo "SKIP: devlink resource dump not supported"
+		return
+	fi
+
+	devlink resource show > /dev/null 2>&1
+	check_err $? "Failed to dump all resources"
+
+	log_test "resource dump test"
+}
+
 info_get()
 {
 	local name=$1
-- 
2.44.0


