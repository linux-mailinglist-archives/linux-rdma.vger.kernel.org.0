Return-Path: <linux-rdma+bounces-17257-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLcVEmzIoGnImQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17257-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:25:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BA41B064E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 23:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 293D630ECAC1
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 22:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425AF47AF75;
	Thu, 26 Feb 2026 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ngw1u7wn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF813A0B26;
	Thu, 26 Feb 2026 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772144452; cv=fail; b=syOdspm8bxq2cquDecxPAkqBic9dTO7Rd3R3ZjkKJvy2OqokIO8t6kmJ5xi9ur+XiwaHSULg9QAd7QO+jd9l7K8SJh2V6HU0RC5N0/s/Qw0bErgESn/EuEMcTpu77qatSj0PIgvfLPP237Fhlg140hNO8/lIQWDFx/l98U7PwNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772144452; c=relaxed/simple;
	bh=RyJqm06nJp4BSmne4q/2dPS56JIBVuhdwtkmhj7qj10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTQFwCZLq0j+wA3lEqiABsxR2KW39fQWZ4C3Z9/KToC1uQZ3VUo4N+zn/QmwvO4IuadcAyPcV3QxEQDz8bbWzzIB+ggqU5MtSM+Yq7upZESIzJkjRFvQk2UvecMPmc1+dtbzUzpEOS6lRz5eUtvsqvzzkHt8UK5GeQVRTDsZclw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ngw1u7wn; arc=fail smtp.client-ip=52.101.53.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMarrerT8+ZW+YTITuIblCV5olbDaNcwWdwhuk2kkJfOigEkfo5x26wWe78PNGXjmwbfE0Kz4fvw+QFXfpq3fpVDHpYd9vDOblp+HWFi4eoGtL6r/6ZtTmLfBMbEFR7DItTGi0SHTCF6pCy01v2TDI4pkyBMfexiDOt4ogC9eOpfgXsqfz3iRxUoh72h0PtY58XTcW7iwjQFODPX5En0VUZT637OiMUhZPagrgToVhsraJ/p8g+iKDG+JlCPVvgDPizYIiB40eHJk9fyX45sXLNMx1qnXQ7ypIlyhR9dDq3zGgL2v1xW0XA5CEAaPMsenTpDgHwFuVFP5AYGamN74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUM9Z2Rv8fWNMcWS8XGLGU+TozRiLJdItSocgrJpIhM=;
 b=HMVrCOEoVnuNC/2FbEU/qHxk6jEs5/0SECpZsENTliRue9Jy3ldHGgmNXxuVTXAtZvG8UV5MCrr9RGDJ+YeER9r8cQCA7P2XZwJ7B3lsFi9afHEAsheb7IXUc92vFW0+/lsUtTDAiSJJeHJZB4gmXNdMX+dO2S69hPibT6rsEbAcnvqhLDo/v671uyF2iTLC6asK0bS7aATw4x/wj719Vy3Gck1eL3zuVsBHYLfuQ+T6ceDgQ+qdwEQkQPGWCqlJi20cdxPfRUuemcfQGL6KMQHzhfIP20fewabf1R5a7k2UlbXAlCkyPOlyYALxr/6mHj7dXykcAvr6Ylzv0i31tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUM9Z2Rv8fWNMcWS8XGLGU+TozRiLJdItSocgrJpIhM=;
 b=ngw1u7wnlsm1kpUbc7MIfAYMFRZRSNUMrkjXLYmq5mHj1YvwNL6hHVbpBVWsPdRbgjJAXniyimSvGE5tppZCHS0LiiNjUnDVBqhpRhFsI+161ZWdz7b9G1cf13Ef9NgzccCeYNCcGmJPjHBpk52qYslUnG0bAlCaTzfDg7MLi1mrPfrXD3SXpx2pvQQuu7bJATNnA0Q4Kd2RW8PTvrllZwYJtD1YHsIQQCng68Bxr5UHWAZ9R0guWMv8pT4hQe1vbBZV/KeC9hIm/Y5d8rMQNP3n2Kh0O/NBQeCGg8TxB4wQBQWiFMmIFLhRHFZW730WonLmGWlc/7UWAA4AOU4QZg==
Received: from BN9PR03CA0381.namprd03.prod.outlook.com (2603:10b6:408:f7::26)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 26 Feb
 2026 22:20:39 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::46) by BN9PR03CA0381.outlook.office365.com
 (2603:10b6:408:f7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 22:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Thu, 26 Feb 2026 22:20:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:20:13 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 14:20:12 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 14:20:07 -0800
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
Subject: [PATCH net-next V3 08/10] netdevsim: Add devlink port resource registration
Date: Fri, 27 Feb 2026 00:19:14 +0200
Message-ID: <20260226221916.1800227-9-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: ad901de8-472c-4da5-263d-08de7585458e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	lJK24NIgpk+wnEMXNoPzpF/ERDnwv2NGic0CBLhsBJ8wSpYsGp3GOa/iCcRmttT40AMeT4AJKklyt02w6FJZ8SyuWSTHTYKtDkNWy+Iq1xS00sLhXmbGWRI+kC0XMHjWSz+DReXUTvyMz6JhnLwrSq90jQAwlugVzSOmqx09TFzzqwcFW4wrQHfNbm7Obh0iYv72vgJANgk4BusKMKWXtY28dQYHFR0Qj8Ab7PjZEpKd6i95SCceYFA6zhTBcdJw5XO3Fybt68bz0KYYYD4yx8TyyHYmXpZivR1InX4uc/MbP+EHJCytjcFTu6NvtijI3FXh5JaR4gfHhHbnWvc0rZYOigtTJlsV0yHNS0eeez4wEIOZtujlc3t72Jgo4bpzu+/8VfmAl7nBUTyEgCILcokj8cVf4ETNfnDHC6ZWrNV1QDvFVXunvVyQjbS/Hz12PcsIAdGnAhPlNrKYBASVBIbmzSyvR+aqVCbLN/dlTmXaXVvIvyrOBkITMOZ3Qo+G+y/zschAliNXWV9j+EMYK2135IZwa9Vg+vuUUt4LmOMnr+PXE99gvhGka0eoSCkBvO24ptJU4sj7pTXVwzQsFiwF3ncME9R45c8Sc/i9lRITWx1S6RqbjtMj7QVIoD8DsVoq+fm6onU5hrVgth/069qhYAvgi+JZcRfG5YM0DiZjtkTiHaXMCnNNMQPMtDSW+XWuInHPTM8A0FXnXdB/EzxZIMcBvkNzSmfumwnGaRlFyQSm10sKIBwebyT6QjREaIO3MhmikM9Pl9yyI1o01kIX49Yu5zYj3xYYFsRN3GRzqLTsNzmrmmDQOhXJERuSjZ/mYwQ6aPY0qtWPLxnrRg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uLarJqLFBCAPVGRXWs6/u/rZPyWPtIpj72ZJjv4rjYRElcea9k59z96miOD6iSKZvgCw5bhv+rdWQufly2WcB1Bfk1cwFtKSMVlahTBsN68EDHr+KWlFw6ClEhREVbxqmI3bHBISwrpp020bn9Ds/1aZzX/2tvU1gcc+1R/5ZkY89psj/2/2nLpD4A79CnLw14+a1h3h4RoTjIbyPmtjBbpk3vrZPWmwPY0BKsON2SmJNuVIFvADS0NDDipDSWWII8Qma9i9vIxxShEwcNL1CAEr+Adw//Ix69P4XHxDYQvDSRF8dUrK7LTlOaMSHsqxsJl/ZGQcV5yAshUqgZo2Aaof9UpFbGSoZ6v2MaiOt8E9f7GJhJoQFmxMWMeUgyuS/6wb4dqTKeWqMiw+gJLoo7DWMy1DErcz8xSOhJklgKcdQYtbFAaM/udqt/ZA7Gfw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 22:20:38.9068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad901de8-472c-4da5-263d-08de7585458e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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
	TAGGED_FROM(0.00)[bounces-17257-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.981];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D1BA41B064E
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

Register port-level resources for netdevsim ports to enable testing
of the port resource infrastructure.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/netdevsim/dev.c       | 23 ++++++++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h |  4 ++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index f7b32446d3b8..80df3ffd1bc7 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1487,9 +1487,25 @@ static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_typ
 	if (err)
 		goto err_port_free;
 
+	if (nsim_dev_port_is_pf(nsim_dev_port)) {
+		u64 parent_id = DEVLINK_RESOURCE_ID_PARENT_TOP;
+		struct devlink_resource_size_params params = {
+			.size_max = 100,
+			.size_granularity = 1,
+			.unit = DEVLINK_RESOURCE_UNIT_ENTRY
+		};
+
+		err = devl_port_resource_register(devlink_port,
+						  "test_resource", 20,
+						  NSIM_PORT_RESOURCE_TEST,
+						  parent_id, &params);
+		if (err)
+			goto err_dl_port_unregister;
+	}
+
 	err = nsim_dev_port_debugfs_init(nsim_dev, nsim_dev_port);
 	if (err)
-		goto err_dl_port_unregister;
+		goto err_port_resource_unregister;
 
 	nsim_dev_port->ns = nsim_create(nsim_dev, nsim_dev_port, perm_addr);
 	if (IS_ERR(nsim_dev_port->ns)) {
@@ -1512,6 +1528,9 @@ static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_typ
 	nsim_destroy(nsim_dev_port->ns);
 err_port_debugfs_exit:
 	nsim_dev_port_debugfs_exit(nsim_dev_port);
+err_port_resource_unregister:
+	if (nsim_dev_port_is_pf(nsim_dev_port))
+		devl_port_resources_unregister(devlink_port);
 err_dl_port_unregister:
 	devl_port_unregister(devlink_port);
 err_port_free:
@@ -1528,6 +1547,8 @@ static void __nsim_dev_port_del(struct nsim_dev_port *nsim_dev_port)
 		devl_rate_leaf_destroy(&nsim_dev_port->devlink_port);
 	nsim_destroy(nsim_dev_port->ns);
 	nsim_dev_port_debugfs_exit(nsim_dev_port);
+	if (nsim_dev_port_is_pf(nsim_dev_port))
+		devl_port_resources_unregister(devlink_port);
 	devl_port_unregister(devlink_port);
 	kfree(nsim_dev_port);
 }
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index f767fc8a7505..985530486184 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -224,6 +224,10 @@ enum nsim_resource_id {
 	NSIM_RESOURCE_NEXTHOPS,
 };
 
+enum nsim_port_resource_id {
+	NSIM_PORT_RESOURCE_TEST = 1,
+};
+
 struct nsim_dev_health {
 	struct devlink_health_reporter *empty_reporter;
 	struct devlink_health_reporter *dummy_reporter;
-- 
2.44.0


