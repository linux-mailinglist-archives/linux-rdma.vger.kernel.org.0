Return-Path: <linux-rdma+bounces-18914-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI3iFoVpzWlbdQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18914-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:52:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3718A37F6DC
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 20:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EA8C30675A2
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 18:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985E447DD5C;
	Wed,  1 Apr 2026 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MidXOTho"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF2247DD49;
	Wed,  1 Apr 2026 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069482; cv=fail; b=N5NL049Y8yIMq8QZlISJjhX0T8WFL8jNzmL0YFLhEIUJ4iwAhjWSS7SxDSfypgDgT3btYP2ZXPqnefYUouKSPgTc4hx0aBhgPxsnAIa4Mq4hf1c3FeVyBxoj1NEMl8V/CZTbHTuNSsHcrx3IHBCqcmQ1+q8Si841xKKSRO9BaUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069482; c=relaxed/simple;
	bh=J01E6J8KuHlCjJpbMhIzPfQ5OWBz6d68lMLuqM4TmJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QphxfxdmShvijHEDVNpJecEkS++feG38l4skL08UcFb0cNroSj6LX43anKXFJ8k+wLo78msg0fmL+8D7tUhWHBujxqEuUtEqxQQZ+XvTpydw5yoT2I880GESSH8jjdPXqZGNcF0xcraV47dm/D/oogmYGa1/hggzCRwGr0GWqKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MidXOTho; arc=fail smtp.client-ip=40.107.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lM4t9llE6UK4vFmQfcfV6Ge2LhPAq6VUb/8XcAQHw1c7HkE6EJHtJcUsNl1BfiSDtPXlg4NX4tUJpmoO/jW47WKGqPNIjkUjc2P71/STfxv1/mQqG5Puz9Gn5uhEjz4rLMCVTWLneamwPiSEI4qPNA8H2Uy4iqlaFE25eg+k4nT9J2yZJahAk+HYwdgz7jTeaq7z4xgz9h6uVeCFWiHTN+DQm2Gey8ivbrnikgJppESykd4X4DnYoq/oytKQMNRs3jFpLyP5eOs5SN53kgLbc0Sj4Q72YJ2uFU6oqTsBarnX9jrI8hGY5gU/x41Q2fdy/0I+B931RaPTNWCCGYYBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMTQnsGi7AHX0t8/FTdHAzIaS77LISeKREG8kwQwz0w=;
 b=lq/k2O2/L54D0ljRUcS9Dei+Q+r0/TAgNv2NdFBcdhaD7mKv7Td7GhyIPZ1n1PYvpJkh5iwDi23VgVXkv13b49I4Gw5gdM4SAq91h0brT5OUEA544POWyiAGZuX9h59+ANKyzObIZRDGmaFU0z3pIi73InJBgx2LJrXv0r0M5w+TS0DoZB3OR3/xxtC4OspaonvGqiNJ6uuwK0GJCd5ypexK3rdGXa/ULJmPqrJZYukABg+nLoLeyuWWGuzuHhJQW30eO4L+PBtfxkqAmQQtjZvslH5+vHnOfaLRGpKfzaYgub+x8B0L6OeLo9/EvuoSE3lMmuN7a/a2N4d3OCUgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMTQnsGi7AHX0t8/FTdHAzIaS77LISeKREG8kwQwz0w=;
 b=MidXOThomNKBD+wmI4q7wSNdmK9MonnQDHdg0Me5JSBhqLXWqf80xBpD5Fx2gPBYZTQe5WxhWQ6bBoog5xSP6rZBMRTLv9GPCJohttN0EpKKt+g5t423JQLieh7imj4GWVOnIBnAQtbCN8iRCqEnG9XRKIgjvkdP7in2wtMVDmmUKSSagJsOc+qvrAEBnwtgXZMdCQYDce2ISjM5RuvzpwdJcujFum9BZHmT340EozryIoz+ZwFJUn4pJ6+RzTL79KD8Lcinm0pUr6DTjZCqf41cdHdR7M1wa38zcFnWq4G+GUxhczTTadnsiAW2M/rc51WUObt1mCyV/oh18lUZ6g==
Received: from SJ0PR13CA0091.namprd13.prod.outlook.com (2603:10b6:a03:2c5::6)
 by PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 18:51:17 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::98) by SJ0PR13CA0091.outlook.office365.com
 (2603:10b6:a03:2c5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Wed,
 1 Apr 2026 18:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 18:51:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:50:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 11:50:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Apr
 2026 11:50:48 -0700
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
	<gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V4 04/12] netdevsim: Add devlink port resource registration
Date: Wed, 1 Apr 2026 21:49:39 +0300
Message-ID: <20260401184947.135205-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb60cfa-b64f-4365-51ab-08de901fa7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	OXAMLEFGHODRSqiHjnUtLU5pkAkH8olorR2a32h88tEY/sKkmFtl1kPo7A2iweibZ9TTGmPMXBIfK3n5XWs5kHYHwm0jLenbHilXJUrs1Wc5RIv5I/3pASMQFXvqWRhIwpMfG30CnqceCp1CnxDsR/Y6K++OAxNQ6eFzMocPVuVw11+Tqo5OKtbsy50UbngW5tsErznd757nzGVC8F0O2qr+BFSOHcr/HG/nSwxknw84apLwLSP/PwO/W8Of1aYQRbla3y0RwZVVEeu1ipxoGIN6iiS/Uy318Y8iXj/Ww11Hk20kQYLbCcVqrNZ6Tndw/Av6SO29maKFXEkf6jlyToLyUrho8mxQ1X4Bg3o8Pf6OVQpgF+0d6T1my5Y+UfFzY/Zg1raAlpO1Y24b76UHiqve1t7DJxi0Dr9hKzApcfk5bK4et0X2NWd4g1EgNvrbJ5HLPktuY2h/6BrgLj7k/FQhfeoNe2c2mPOdKbTPRcXHNzkvv10vAsH3rjfDZtLoDZP/d4JTrJPGOm9R+VoF+Z+veDL/UneUuzAXv4808Lsww84+LSbuk8+xK9rYE9IrwjJyrVKFSC6+oxl28yZY7EjJGQQaFk2CILJpRkJaEOodX/Mi85qg75lQy3EeHw010QFAconvfSDu+om3xeC1EJ3RK/raUt9c3scbwnXKkTdCeXzrfVubCHyzt3VL53lQKCyBFXLez6lN4J0j+PrsCvlSdQVHHJ2SLRRVOYsJtxRmtu9miPHhsoWLvw/+91Kf0PUSIMPIGSdivSlLjw2DFQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rnl8CkxYxxR/9qSTEcwL9rvneN8aQD+W2vcwMTx313PLUgCeiirFyCGUZ4jw173OV7PZBfKp+lw0JnrIs7EVGUhkoHGSxmveM5LsRYdaPm9FygXMB5JZPJVDWe0Grpm7KYMeikkMOtdyDcA8sH5I+sECJZxP6mAFkXKZ/VM7jzpOxz/ZBrrwU/sKGWkGRL+7kLDScxmDCz99SDg1xDkO/YbsmvqqSGCw7dNXXglOmJ66e+wBPSwuXrfYNagt0MRr/PPqx5qscaXsvw0PvpxW1l7K1TXRpejEf3D+eY/5cIv8NYrOdoc+cjb3GBq8SkQ/9zlM0j9q+4BKHJMlZaFc1dISQrsFjPONuoHQ+4m20wMFfhfX+rfrkS30ghiTUfYNmmsvMKWDevZHRwSZv3xJ5u4iC7iO6vYYazCLUWHkjTKGjUJV1yDMmEdJ76d0jOAh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 18:51:16.8522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb60cfa-b64f-4365-51ab-08de901fa7fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966
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
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18914-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 3718A37F6DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index e82de0fd3157..1e06e781c835 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1486,9 +1486,25 @@ static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_typ
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
@@ -1511,6 +1527,9 @@ static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_typ
 	nsim_destroy(nsim_dev_port->ns);
 err_port_debugfs_exit:
 	nsim_dev_port_debugfs_exit(nsim_dev_port);
+err_port_resource_unregister:
+	if (nsim_dev_port_is_pf(nsim_dev_port))
+		devl_port_resources_unregister(devlink_port);
 err_dl_port_unregister:
 	devl_port_unregister(devlink_port);
 err_port_free:
@@ -1527,6 +1546,8 @@ static void __nsim_dev_port_del(struct nsim_dev_port *nsim_dev_port)
 		devl_rate_leaf_destroy(&nsim_dev_port->devlink_port);
 	nsim_destroy(nsim_dev_port->ns);
 	nsim_dev_port_debugfs_exit(nsim_dev_port);
+	if (nsim_dev_port_is_pf(nsim_dev_port))
+		devl_port_resources_unregister(devlink_port);
 	devl_port_unregister(devlink_port);
 	kfree(nsim_dev_port);
 }
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index c904e14f6b3f..c7de53706ec4 100644
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


