Return-Path: <linux-rdma+bounces-18568-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INBTNC6HwmkAegQAu9opvQ
	(envelope-from <linux-rdma+bounces-18568-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:44:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A4B30887C
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8556530874F9
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477C93FBEA0;
	Tue, 24 Mar 2026 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XcdaO8ss"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2C93E0224;
	Tue, 24 Mar 2026 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355438; cv=fail; b=PDu1SBhO29HfrbOttddhVdkqsGaiA/By20QMH50kzTSzKbkSIWWi9RKheT9YHB9ZAoFGCWbZD6AEKNmoJHsplQJy6ntI8Y4uGaiaYUiMXJCALpoTs/COwvTWbA/TlE8LU7aymuqj1/rQ86RhfHrHxBChn70LlPovLmKAZ43Idok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355438; c=relaxed/simple;
	bh=Dg7wX5H+kvpkmqTezdFMbj/IYYIg4wE+6SZZK5g2tJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUs6RsMgxQweoCL+71QRkSlDuZdWG4bVA7gii8qBRfb7rYJHcHcc+wp9/2/KIvPnOrOdL/E8rBr0/fiRAy/0y9NevBDCQYGJFO0FQuIgDi6eMf608aDMgxFma3o90XzvRzjj88icQs0u9NXidT7nl3YMwpwZTk0Zg7o2ohGQuC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XcdaO8ss; arc=fail smtp.client-ip=40.93.195.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUEQD8kXYJL6tg+D+F0e5/jyk0tFpiiGuhMqAYssidz2RYMeChK154e25gkMS0eadlwT/NSNGlD1kslOasu+0lGELGkfmBFAplT86Nz5o8zZTKz2FJKH5znFpXjF/HEAdgEIpno48HUKBCQ89JOM3RUc5lgyAR1G+uuq6mY9WHI1dyikSwae2B4hvblYE3acS0fFKoOD/wqOY7YyYTXJCsDKM9Tsu5ZyuMK/+XkvlG9oc4npiNrJsl4M4amHtuq9Zpxl/XHECGkZI9UloAu5UHRSigEzFb0FOAnG21WQFlY48vfCVGAA86nfTVmvxxfqX/4YhQIty1Nfqg6P9Dxi2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsicyKUJvobH8RjMVSM6RAsIi2KLcNEhNIzJ/7Nf+iw=;
 b=PTv06J3sqVJKJ2NbhUOlPN1WRNTTVkarHYoZCWRFfucj7gRL4OiM7bsoYyZCgk0NLOMAlv/kcgymzGxAvQPtHe87+eiqxiltR2Gctc/v5urGeAZYXvmVAAX/e0g1uvnIEzpK7UnE4Dg1aBwk3rx78/JNkDUCdLJAfkPN73dJ3ZaqnGxopvks0+17kA85rIRCyV5kzbkZ1zCRGCRvqoh9kUWvIc6HcjIn4CALURxITJOB3WqBq6MUzBsph7Zh8I0MsSjxLgI59OvNG/8+GMTnTmCrnE20Ha5btHKvYcZ4x0/4hMONZevEULU1O0ufVZzISiRqgppgAat+rTKdBNelvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsicyKUJvobH8RjMVSM6RAsIi2KLcNEhNIzJ/7Nf+iw=;
 b=XcdaO8ssItWJl3IUtbGc45Ie9Yu/3XVHbGRF86/1zLWzcgxJFlxQKNAGTsm4SNSZFSxM5EYJ4fWUD/MyOIshnbVF1R4DmTc/Fz71LKYka81PDAgtce2vieYKfKN44HQbML95UKt1Xe2BCPjIXhfpgNr7g4PWx7dFSIu5sidjyQ3Z7LmUtg7LYqwnSkKyn16gNiEN2jZrezQSrywyyblMOiosNRrBKB24blUtB+fFbZqynUCJxdHdgYnpyvK6rCE7GBvJSdbkDTqyls0W4UqKQhNwnw/3bHkp1jMoZHIrEithB6HozFnyFxM8Wv06FVVY2bWW55I4dubpB63WSgp5iw==
Received: from SA1PR04CA0016.namprd04.prod.outlook.com (2603:10b6:806:2ce::21)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:30:32 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::e) by SA1PR04CA0016.outlook.office365.com
 (2603:10b6:806:2ce::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:30:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:30:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:30:11 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:30:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Mar 2026 05:30:02 -0700
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
Subject: [PATCH net-next V8 05/14] devlink: Add parent dev to devlink API
Date: Tue, 24 Mar 2026 14:28:39 +0200
Message-ID: <20260324122848.36731-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a02ca1-df10-4153-4a35-08de89a123fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	09PWLB7UJwC39cZC3VWf3AmMJjVubmids6zUk2qHa+H6PV7HIp4hwOx+JnUOb1wnmAh3Tl9J2PHPIdSdUk3H6rZWK9/jVIHnJGMbyumIFlS71gQ45Q7Pmhovs5mvUY8FOdoSWmGgBMbR0Hx+UaxvkpFPdUZBPM+yGsiNhTuzqrP2j5VwRw26GJh6LoDmgTkoSXRrBCxBzDTwl+3PrhXqhFtvnMRoyBpyFQ5b4ffLdEU8TEDmOgvYjnI5ojj49U8srXaFGmXg21pRKcWbH9VF+hZC0DWgOrswVU1jA+eRgFy4Gb0PeTbODU8Wk6EfxVeNYcC1o3p3X4rNskn95ix6FnkewuKD554uk056AQiJjZM2Ra2fj7JytdLgu1sa1W38o6NSGhll3YDVTVkYeUgofeFLy/BQ4JEHxgWXbNyn1d4A5Vpq6BNmcz/BphjJl3PKRqbbeTMm2NcCAo+tgzln/w3mcB/AfRIJ9L6H5oX0OL1KYf7SMalKwUaPfWB2QxUPDHybsb6auv8aCCq1WmFQ1Am6qJTshJgV7+rJ5cvmLlBjL2xfgYQUvOyHwDs2/kGcqGWbU++Dd+3DydLfBngjMLKk/cpplMq3Jt9dnaqkFLB24P2I6HstkBSWz/hRQqTk+T0aqj5fCpTLNdkYNbrpwvxgo4BgYH38mU18w/zd0I0zX2cuokr4PACcy42XTaOCmmShvsJVZPNu1G3C+8v50fogF1nF79iWcrkkR1ld4dKXTRMiSa8Qq1VIw6sdVIB22ln1YNO9g7bn6bdqosyZkQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7t61HMtOu9FxBktNzqp8NNE7viQt8t2BxOgPTSxsFzgCXnlpSS7wLl+Uf7ukhiCwC2Eshh0oRWcnepIFYy0HN2Dn5gnTFQ4XIytUktBb1zE59ql5p4MT57q6VO/DvkQIGtv5haB96GTHbpRRvaMFPC41NGLQicOZSBJxHP4atk4N15FM1MAn35lQ7xfHUFSZYVITD2sn2X84+9eaJONtBecg3J4NaW8nv75lKx2XYvtbTb8jeCJeD6WBNtm6QFfVSIJwtkYQ6iECq6Xvk9KZB1p04qxGCH1+Y8mxY+kGsKv1rPIXNk1Pjm+pBItKNl5qeWio5n0kVuh6SFjRsW2/KXOanVJSLp6F9PL9vZ6OZBnHYalUrBeSUmKEEgNIb6KraVasqyCOc1Bjq6JBXgMCxQToZeIcUMj2aYGosEtN1O+aeNM4fRj8sts5/OEiklBG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:30:31.8180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a02ca1-df10-4153-4a35-08de89a123fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,google.com,davidwei.uk,fomichev.me,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18568-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 07A4B30887C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

Upcoming changes to the rate commands need the parent devlink specified.
This change adds a nested 'parent-dev' attribute to the API and helpers
to obtain and put a reference to the parent devlink instance in
info->ctx.

To avoid deadlocks, the parent devlink is unlocked before obtaining the
main devlink instance that is the target of the request.
A reference to the parent is kept until the end of the request to avoid
it suddenly disappearing.

This means that this reference is of limited use without additional
protection.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 14 +++++++++
 include/uapi/linux/devlink.h             |  2 ++
 net/devlink/devl_internal.h              |  3 ++
 net/devlink/netlink.c                    | 36 ++++++++++++++++++++----
 4 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index b495d56b9137..43cc0abf7235 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -873,6 +873,10 @@ attribute-sets:
         doc: Unique devlink instance index.
         checks:
           max: u32-max
+      -
+        name: parent-dev
+        type: nest
+        nested-attributes: dl-parent-dev
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1295,6 +1299,16 @@ attribute-sets:
              Specifies the bandwidth share assigned to the Traffic Class.
              The bandwidth for the traffic class is determined
              in proportion to the sum of the shares of all configured classes.
+  -
+    name: dl-parent-dev
+    subset-of: devlink
+    attributes:
+      -
+        name: bus-name
+      -
+        name: dev-name
+      -
+        name: index
 
 operations:
   enum-model: directional
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 7de2d8cc862f..01b7a4fcfedd 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -646,6 +646,8 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_INDEX,			/* uint */
 
+	DEVLINK_ATTR_PARENT_DEV,		/* nested */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 1af445f044e5..414b3d8f70a5 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -153,6 +153,7 @@ int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
 struct devlink_nl_ctx {
 	struct devlink *devlink;
 	struct devlink_port *devlink_port;
+	struct devlink *parent_devlink;
 };
 
 static inline struct devlink_nl_ctx *
@@ -191,6 +192,8 @@ typedef int devlink_nl_dump_one_func_t(struct sk_buff *msg,
 struct devlink *
 devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 			    bool dev_lock);
+struct devlink *
+devlink_get_parent_from_attrs_lock(struct net *net, struct nlattr **attrs);
 
 int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 		      devlink_nl_dump_one_func_t *dump_one);
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 5624cf71592f..21a34e4d2a49 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -12,6 +12,7 @@
 #define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
 #define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
 #define DEVLINK_NL_FLAG_NEED_DEV_LOCK		BIT(2)
+#define DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV	BIT(3)
 
 static const struct genl_multicast_group devlink_nl_mcgrps[] = {
 	[DEVLINK_MCGRP_CONFIG] = { .name = DEVLINK_GENL_MCGRP_CONFIG_NAME },
@@ -239,19 +240,39 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	return ERR_PTR(-ENODEV);
 }
 
+struct devlink *
+devlink_get_parent_from_attrs_lock(struct net *net, struct nlattr **attrs)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 				 u8 flags)
 {
+	bool parent_dev = flags & DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV;
 	bool dev_lock = flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK;
+	struct devlink *devlink, *parent_devlink = NULL;
+	struct net *net = genl_info_net(info);
+	struct nlattr **attrs = info->attrs;
 	struct devlink_port *devlink_port;
-	struct devlink *devlink;
 	int err;
 
-	devlink = devlink_get_from_attrs_lock(genl_info_net(info), info->attrs,
-					      dev_lock);
-	if (IS_ERR(devlink))
-		return PTR_ERR(devlink);
+	if (parent_dev && attrs[DEVLINK_ATTR_PARENT_DEV]) {
+		parent_devlink = devlink_get_parent_from_attrs_lock(net, attrs);
+		if (IS_ERR(parent_devlink))
+			return PTR_ERR(parent_devlink);
+		devlink_nl_ctx(info)->parent_devlink = parent_devlink;
+		/* Drop the parent devlink lock but don't release the reference.
+		 * This will keep it alive until the end of the request.
+		 */
+		devl_unlock(parent_devlink);
+	}
 
+	devlink = devlink_get_from_attrs_lock(net, attrs, dev_lock);
+	if (IS_ERR(devlink)) {
+		err = PTR_ERR(devlink);
+		goto parent_put;
+	}
 	devlink_nl_ctx(info)->devlink = devlink;
 	if (flags & DEVLINK_NL_FLAG_NEED_PORT) {
 		devlink_port = devlink_port_get_from_info(devlink, info);
@@ -270,6 +291,9 @@ static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 unlock:
 	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
+parent_put:
+	if (parent_dev && parent_devlink)
+		devlink_put(parent_devlink);
 	return err;
 }
 
@@ -307,6 +331,8 @@ static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
 	devlink = devlink_nl_ctx(info)->devlink;
 	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
+	if (devlink_nl_ctx(info)->parent_devlink)
+		devlink_put(devlink_nl_ctx(info)->parent_devlink);
 }
 
 void devlink_nl_post_doit(const struct genl_split_ops *ops,
-- 
2.44.0


