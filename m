Return-Path: <linux-rdma+bounces-18689-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BipHGvaxGkq4gQAu9opvQ
	(envelope-from <linux-rdma+bounces-18689-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:04:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 287813302D9
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26E2030A2961
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 07:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DCD353EDE;
	Thu, 26 Mar 2026 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c+yuLFAU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495371A6805;
	Thu, 26 Mar 2026 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508516; cv=fail; b=MGsOwYQnuB6T3/NXyClsuGq5R/3JxmEVaSNWZURAolblF6p4oiM02ZbgEXFqGL0iyX6S7jSeyVUQtacMeMrtX6EYI50A5g1+6osPYxq8ZwbR/+f8zGp4T9hPi1QrpEPO+ulqGVTuVLSeLH+mSqFg2RAMnxuLZ0qQ0nEmKS/BV+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508516; c=relaxed/simple;
	bh=Iu1vYg7GwNi/dR7ygmOkqrIZ8P1sVBVwR3biMW8Fb5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GA0dB9oMqbzNsn/bRv1hv13laz/cSjoPVx8d+VNYJo0/b/tXZ074nxwevgtzoTHtaL8GwVJU/XqlGYisSmNq+IPZ6L8M+hXllYJQAYSXF7LDtgzIVasZA0Jq0ACtMZ6URPz5GULkEz1K/C+HoylRfkZwsa6SlBas4qPz4LHLVok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c+yuLFAU; arc=fail smtp.client-ip=52.101.62.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qg/RTGaX2APySplb1BgcW5dCnIkHbljgTj9vQSLWw4f9qAHN71AT83pzhuEH+1QzENB/XAtnekbc7yhmyehpVSRMNle47Oz5AYixuKM4boiKyrNMA7gOwBvB5+7iYuSanlecMFto/CddU5vZinIzMgR+KmM4c9gch5I+NygxO1ZOuMaevy8UtzgTJtwvVX0J9TJHZyDx/71DriJs6tscLh8TYhSQXm5K6WdlbyLvCF/rD08J8Nhz5r/2U+FEOb3LULc6zsnwS/ECS6//Xp456za9V87GrIez+tdOg+rIfJjexdolxE4dfIZALatAdd5O4tW/fG7PYqRUI+eebZrWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lyfd0WUUrXN7Za1ZG5LPN0gi/IumMVLCdLLSgfBJZb8=;
 b=EdmDIW+UezCJIHsdoK58DYbw82eMERZ7NaC4S8G8romoislE4tafyM05o8WHk1S4BrEvxq5HfrJEHPRrn5dKEawR03UJ0T63j6zpKBpOBLDuxY6gGqHK00gvIZtVv4GbrtLrjNEvX9167lDqUl9s55448iG1L4I+g+km0Yn0hyUMJ3HIVHTPPLMqKJFs+T+efnJmRhhqmCYpohmH6rm6PO3vWQczvd8ihSE26HH7mgDoC3K2haNdUvtUj6VA6a70RtwzZduMdDS8ALWvCSel4n1Z5vg8EON4E3O+oniokLhyd5H3bNO4thYeGkAiC4d/AV7kYmesPW1AtWoNIQ87lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lyfd0WUUrXN7Za1ZG5LPN0gi/IumMVLCdLLSgfBJZb8=;
 b=c+yuLFAUm3Z6xpQWOSolOdkyh+SqZw9x8xdd1qoGD5KS3NxTepoKJOn5WbilG8m3MI+SQLJaArJP05y8SjpSfFUY5hazpLhTpzi0CamRYSwBtYg21qnVK8ZVwYQgZfYoqIkaLvIZM8xDAgNf4HX9zsLIT+GuAa05VpR+gmtV4CZaFrX5bLlH5vtYg505SFrIFyisvHkO9ozfq6GLpOPjUrjKW7KoeWY5WP1g+ncj8g2RnOoiK/3hK5/f9E22+MvEtoBjORtIBIzwawQAgLpCHcrsex86BHlu129Nx/qXv8DRewAtVNYlrc9lOXuAESw3n0RjSy2aV9u3604nwa16Kw==
Received: from BLAPR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:32b::10)
 by CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Thu, 26 Mar
 2026 07:01:44 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::bd) by BLAPR03CA0005.outlook.office365.com
 (2603:10b6:208:32b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 07:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 26 Mar 2026 07:01:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 00:01:36 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 00:01:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 00:01:25 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Shahar Shitrit <shshitrit@nvidia.com>, "Daniel
 Zahka" <daniel.zahka@gmail.com>, Parav Pandit <parav@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, Kees Cook <kees@kernel.org>, "Shay
 Drori" <shayd@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Daniel Borkmann <daniel@iogearbox.net>, Joe Damato
	<joe@dama.to>, Nikolay Aleksandrov <razor@blackwall.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, "Antonio
 Quartulli" <antonio@openvpn.net>, Allison Henderson
	<allison.henderson@oracle.com>, Bui Quang Minh <minhquangbui99@gmail.com>,
	Nimrod Oren <noren@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V9 07/14] devlink: Allow rate node parents from other devlinks
Date: Thu, 26 Mar 2026 08:59:42 +0200
Message-ID: <20260326065949.44058-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260326065949.44058-1-tariqt@nvidia.com>
References: <20260326065949.44058-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|CH2PR12MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: 2193e79f-50d5-49ee-98ab-08de8b058a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Gampzoicb6+HW08GKrv0Q3uCXVa8jg59ncLAntRhSmdK4ouM7ziqbR8sf0RzsrH8y0PrH3Jq9cYNRGjch9L4zwP46utxnjlbOH+4oK67XJsC7eoCvOpRwxcxQhQ81XrpjH6rJHRUJRmpP7Pel58a9QElDqRQTy7/jSpKMETMAM9pB9FwwdjvOdVA8qRewpUzD6JtdGAVXBN1y8J0I1dnVvGGO4hnpVi437vpVTIXMKtiuYCbwwXJfsKzl2MxfKkiAJFCDUwPfCI5cm2dMeerMg+oXd/AwyZFVOqshkgWr7Wrb023cFh5KSSoi1cHed+QUqEBnmzPcXZfMnOmWv6HHpIyXS0XfHOozLOCWF7kQT8US+Lh3r6OLsZ7hEKUMwDWdwg8XXxKH2pKsZ3BCt8yUEWIGUo/sCp6rztoxC235QznOPu7pZ5dhW7mH5yE++Hm7fUJxGmqoBV77NhwMnCGkAA2dxClttveYXE86RQFMcx8uObDDLxyniQRUcQIrAajzXIocsyYS7+yMKpOG0qudAas5XjmhKtYukWExgvo8UDn9+M9fxAzi8xwbAYUVus+E99oDk+A6aIXJbaqB3tCYmGJfakgYuaWtzN3KCIIf3ibiVLoMEt26QlOVN0EvlllbjdUEmdxIOl3szopCZgeQzmT1Lq/L3xq1ejk3shuNdDSn2cR+OXtU7KfI9fLzflFzcmVgBRq6DBlFdEARV3vJiGvNtHQP5j/KNcbjY5CVU3xnIa28FwoAsnVgPOJZOhnA7snDDvzx2gLD/XiNhkaOA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k+/qFdEzyOCJFMdOyFOAU7sgmUxy7jtI1u7jZ5r4rTc3OdFqpL16FRoT2dMUVyZ+193v9uhuWBQu0QunYaBeCufytLIx9tCdXF9JFYKPacN57kmv++v2jEID/CrPeN0d+GvLV23P3Q305RTaTyYWK2EbCODpctGGHY1i/WRdTEO6lZZ3ZFXLOEzk+/jG/prGixNfgIYBN27QGfFe5bl9u3FHPjF6iLCtsZK3exGC+RhKAWER5FGb6dBuYROB8tzBvLmJjq+0SvdbiBWhyPQ9xqDVzzxmrkH8xR7Kzmy3IE57kGzS0e/zu+JEqpoNvsGXpvA8l1/6Hc+IBbjwTj9DY6aJR9OI/xik5p0Ie0H7geaZfSyruNZOobjzIItT5s3vjBp5NojtTwzB3Q2bTtHxcN6T6D358tuL5R+P3Ki6BTX7qDM8oq1DbUuGdAszH2Id
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:01:44.4117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2193e79f-50d5-49ee-98ab-08de8b058a5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9457
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,google.com,davidwei.uk,fomichev.me,iogearbox.net,dama.to,blackwall.org,linux.dev,redhat.com,openvpn.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18689-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 287813302D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

This commit makes use of the building blocks previously added to
implement cross-device rate nodes.

A new 'supported_cross_device_rate_nodes' bool is added to devlink_ops
which lets drivers advertise support for cross-device rate objects.
If enabled and if there is a common shared devlink instance, then:
- all rate objects will be stored in the top-most common nested instance
  and
- rate objects can have parents from other devices sharing the same
  common instance.

The parent devlink from info->ctx is not locked, so none of its mutable
fields can be used. But parent setting only requires comparing devlink
pointer comparisons. Additionally, since the shared devlink is locked,
other rate operations cannot concurrently happen.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-port.rst       |  2 +
 include/net/devlink.h                         |  5 +
 net/devlink/rate.c                            | 92 +++++++++++++++++--
 3 files changed, 90 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 5e397798a402..976bc5ca0962 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -417,6 +417,8 @@ API allows to configure following rate object's parameters:
   Parent node name. Parent node rate limits are considered as additional limits
   to all node children limits. ``tx_max`` is an upper limit for children.
   ``tx_share`` is a total bandwidth distributed among children.
+  If the device supports cross-function scheduling, the parent can be from a
+  different function of the same underlying device.
 
 ``tc_bw``
   Allow users to set the bandwidth allocation per traffic class on rate
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 3038af6ec017..8d5ad5d4f1d0 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1585,6 +1585,11 @@ struct devlink_ops {
 				    struct devlink_rate *parent,
 				    void *priv_child, void *priv_parent,
 				    struct netlink_ext_ack *extack);
+	/* Indicates if cross-device rate nodes are supported.
+	 * This also requires a shared common ancestor object all devices that
+	 * could share rate nodes are nested in.
+	 */
+	bool supported_cross_device_rate_nodes;
 	/**
 	 * selftests_check() - queries if selftest is supported
 	 * @devlink: devlink instance
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 1949746fab29..f243cccc95be 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -30,19 +30,53 @@ devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
 	return devlink_rate ?: ERR_PTR(-ENODEV);
 }
 
+/* Repeatedly locks the nested-in devlink instances while cross device rate
+ * nodes are supported. Returns the devlink instance where rates should be
+ * stored.
+ */
 static struct devlink *devl_rate_lock(struct devlink *devlink)
 {
-	return devlink;
+	struct devlink *rate_devlink = devlink;
+
+	while (rate_devlink->ops &&
+	       rate_devlink->ops->supported_cross_device_rate_nodes) {
+		devlink = devlink_nested_in_get_lock(rate_devlink->rel);
+		if (!devlink)
+			break;
+		rate_devlink = devlink;
+	}
+	return rate_devlink;
 }
 
+/* Variant of the above for when the nested-in devlink instances are already
+ * locked.
+ */
 static struct devlink *
 devl_get_rate_node_instance_locked(struct devlink *devlink)
 {
-	return devlink;
+	struct devlink *rate_devlink = devlink;
+
+	while (rate_devlink->ops &&
+	       rate_devlink->ops->supported_cross_device_rate_nodes) {
+		devlink = devlink_nested_in_get_locked(rate_devlink->rel);
+		if (!devlink)
+			break;
+		rate_devlink = devlink;
+	}
+	return rate_devlink;
 }
 
+/* Repeatedly unlocks the nested-in devlink instances of 'devlink' while cross
+ * device nodes are supported.
+ */
 static void devl_rate_unlock(struct devlink *devlink)
 {
+	if (!devlink || !devlink->ops ||
+	    !devlink->ops->supported_cross_device_rate_nodes)
+		return;
+
+	devl_rate_unlock(devlink_nested_in_get_locked(devlink->rel));
+	devlink_nested_in_put_unlock(devlink->rel);
 }
 
 static struct devlink_rate *
@@ -120,6 +154,24 @@ static int devlink_rate_put_tc_bws(struct sk_buff *msg, u32 *tc_bw)
 	return -EMSGSIZE;
 }
 
+static int devlink_nl_rate_parent_fill(struct sk_buff *msg,
+				       struct devlink_rate *devlink_rate)
+{
+	struct devlink_rate *parent = devlink_rate->parent;
+	struct devlink *devlink = parent->devlink;
+
+	if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
+			   parent->name))
+		return -EMSGSIZE;
+
+	if (devlink != devlink_rate->devlink &&
+	    devlink_nl_put_nested_handle(msg, devlink_net(devlink), devlink,
+					 DEVLINK_ATTR_PARENT_DEV))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int devlink_nl_rate_fill(struct sk_buff *msg,
 				struct devlink_rate *devlink_rate,
 				enum devlink_command cmd, u32 portid, u32 seq,
@@ -164,10 +216,9 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 			devlink_rate->tx_weight))
 		goto nla_put_failure;
 
-	if (devlink_rate->parent)
-		if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
-				   devlink_rate->parent->name))
-			goto nla_put_failure;
+	if (devlink_rate->parent &&
+	    devlink_nl_rate_parent_fill(msg, devlink_rate))
+		goto nla_put_failure;
 
 	if (devlink_rate_put_tc_bws(msg, devlink_rate->tc_bw))
 		goto nla_put_failure;
@@ -320,13 +371,14 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 				struct genl_info *info,
 				struct nlattr *nla_parent)
 {
-	struct devlink *devlink = devlink_rate->devlink;
+	struct devlink *devlink = devlink_rate->devlink, *parent_devlink;
 	const char *parent_name = nla_data(nla_parent);
 	const struct devlink_ops *ops = devlink->ops;
 	size_t len = strlen(parent_name);
 	struct devlink_rate *parent;
 	int err = -EOPNOTSUPP;
 
+	parent_devlink = devlink_nl_ctx(info)->parent_devlink ? : devlink;
 	parent = devlink_rate->parent;
 
 	if (parent && !len) {
@@ -344,7 +396,13 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 		refcount_dec(&parent->refcnt);
 		devlink_rate->parent = NULL;
 	} else if (len) {
-		parent = devlink_rate_node_get_by_name(devlink, parent_name);
+		/* parent_devlink (when different than devlink) isn't locked,
+		 * but the rate node devlink instance is, so nobody from the
+		 * same group of devices sharing rates could change the used
+		 * fields or unregister the parent.
+		 */
+		parent = devlink_rate_node_get_by_name(parent_devlink,
+						       parent_name);
 		if (IS_ERR(parent))
 			return -ENODEV;
 
@@ -625,7 +683,8 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 
 int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
+	struct devlink_nl_ctx *ctx = devlink_nl_ctx(info);
+	struct devlink *devlink = ctx->devlink;
 	struct devlink_rate *devlink_rate;
 	const struct devlink_ops *ops;
 	int err;
@@ -644,6 +703,14 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 		goto unlock;
 	}
 
+	if (ctx->parent_devlink && ctx->parent_devlink != devlink &&
+	    !ops->supported_cross_device_rate_nodes) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Cross-device rate parents aren't supported");
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
 	err = devlink_nl_rate_set(devlink_rate, ops, info);
 
 	if (!err)
@@ -671,6 +738,13 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!devlink_rate_set_ops_supported(ops, info, DEVLINK_RATE_TYPE_NODE))
 		return -EOPNOTSUPP;
 
+	if (ctx->parent_devlink && ctx->parent_devlink != devlink &&
+	    !ops->supported_cross_device_rate_nodes) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Cross-device rate parents aren't supported");
+		return -EOPNOTSUPP;
+	}
+
 	rate_devlink = devl_rate_lock(devlink);
 	rate_node = devlink_rate_node_get_from_attrs(devlink, info->attrs);
 	if (!IS_ERR(rate_node)) {
-- 
2.44.0


