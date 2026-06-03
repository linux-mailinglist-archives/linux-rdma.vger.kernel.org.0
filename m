Return-Path: <linux-rdma+bounces-21676-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oM62GDICIGq9twAAu9opvQ
	(envelope-from <linux-rdma+bounces-21676-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 12:30:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB42D63699E
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 12:30:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="tBL/4rvD";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21676-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21676-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB5EC30C0B68
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4983C81A9;
	Wed,  3 Jun 2026 10:27:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095F938886B;
	Wed,  3 Jun 2026 10:27:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780482467; cv=fail; b=goS6pZHBwDNVIdhpjrcouOdesfPP8A0p3yNld0INng9q4VeEJ41SKwicjrF/Oj6yth4UB1Cqgimn07ngPcTxZC2RsRz+v+Jo1rjCIa8ykT+4lksSVFetHDAtFMozepkKqOUqK2otph8tQhM39Q6QPXzDCyvtv0OrB4YKJWU+hCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780482467; c=relaxed/simple;
	bh=GunfFXd5jbSXRhQcUtLT0ggA22LOI1FfjSkYvFyAhiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1uyDQDlJ6YF1QQ0KtUtySdS91b8nWTLb+OXaOd9nx5ePkHCAREmK/+lPu3+M7QRu13bO958naOmhwF824d7yUO01r6dtaBRsvZQ8hTIOKcUljzjWAqrt33ZoxA+OPEttDlGYhNhZnBljxBHa0bBCb+l0gS14zTr/iB4v7dVeLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tBL/4rvD; arc=fail smtp.client-ip=52.101.61.56
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4k41kN7O5Eg4NeXgBbVmLbHq/msw/uAWzlUZEVGcRUvzbuhNEFEHBmfkuhviQQvwBlSgne2lGcInEm65djSA/2w0YeUR0a/Dpy/oaFBU1dUJWL/WhIChh3pYWLKcf9dsVl9ZhrLEf2qzXxH3BLFssb9vnjaubDfE1pfCJDWzXs5aUYQz8DLT76yPsgIaD6zE3XM/NUJ4HAEfUYZGG8dVvnchoe3uJCEx2OPbBzl41jrG3Fr4qXqFm5K3aeT4d/9KcOckMaUy1Lj7RSR3CSJtmt9KnWq9dGTR+gQAKfAm0Cw/SmEHqN6heSTmWUyO+x9mxbTrm8IwCQcGIoja8e4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cp84i4HBaz1DflBIk+Q5BBQgoa6ATJ+wa/MPahiBJnk=;
 b=J2KWS3JMS8+nlG8nizz+P9odCOivnO8LDCNNuFuq+IGikhVgMN/9qNh8K8Z/EXtEPogzvbReqUAnPSoGX2r3/o8PNPI8FJUKBqeFkQaJwX0idw/ESoWvnI8Aead7ieq6enhEpJCAafkCPJ4SiV9TAa/wQo3tI8rUA0rhEbft+lzBTxkZZWeRrwpuYwEQm+pLU0mzbysnGdNonQRunB6LSGq2Id4GSeZVOyHMd7KrXK81aYZ3sI4xz3EEMwAp0zJ126agc775J1H84lUR4KyxrdoZJVvVdsPnx38mLzrZXgigjazDEXP9HqQdVrTYKfQyI+Nmas1uGhHxv9aBu91Jbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cp84i4HBaz1DflBIk+Q5BBQgoa6ATJ+wa/MPahiBJnk=;
 b=tBL/4rvDQrmlAZKPgKnzEIetHScJAP0lWE2xkYuRctV0wMb3sqy2ludl84EmHd0GMnIWS6P/vzl4G6jjPAPa8rMa8eb0G35Vrt/LI95+LUESaDHtGm0ZcxcWtLtahOxiYecFZ++dvL5MvY7KvwVk6ZOlW5CgoEPeBhW7Qa3Um4HzwNC4WP3fWHQ9YpZqvWmbStZF5NtUJniuzITsiEy+A/NbJ5iB+2F7WTix/JmRG2UoJpsb55bdlmX5MUY/kkwFABoWBp0Tt6ELiZqDdl1zkkvXhUdxwG6x1W6kjT3I8QLwjItm6p+CBTDBsWeMadxniX8bTkESPF+AFZ9ZNrYsLw==
Received: from MW4PR04CA0210.namprd04.prod.outlook.com (2603:10b6:303:86::35)
 by EAYPR12MB999156.namprd12.prod.outlook.com (2603:10b6:303:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Wed, 3 Jun
 2026 10:27:36 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:86:cafe::38) by MW4PR04CA0210.outlook.office365.com
 (2603:10b6:303:86::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 10:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 10:27:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 03:27:18 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 03:27:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 3 Jun
 2026 03:27:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dumitrescu
	<vdumitrescu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Arthur Kiyanovski <akiyano@amazon.com>, "Petr
 Machata" <petrm@nvidia.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, David Ahern
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Amery Hung <ameryhung@gmail.com>, Nikolay Aleksandrov
	<nikolay@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V3 1/2] devlink: add generic device max_sfs parameter
Date: Wed, 3 Jun 2026 13:26:45 +0300
Message-ID: <20260603102646.404797-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260603102646.404797-1-tariqt@nvidia.com>
References: <20260603102646.404797-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|EAYPR12MB999156:EE_
X-MS-Office365-Filtering-Correlation-Id: 718e156c-47a5-401a-9519-08dec15abb31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H/atSmQPbOWW0FVviQwIHn2POrdH0R2hquP8sAx+SVf2IsHvivdBrkSPrKmQTNblmGD4IN+kyVeb9mvdGNWLC3W+EZujGMltaZMwDlyguHy2pxQIzaNDWFfDcWTYnOR/+rXDVwgLQHVjN4WgVxrwg3EBpC5h/NmuUroc7ec+8yVZ4mAkO+NwZ6rCGIbNhDx/ZAWUjMLkxrM45TUAUISk3PmO4RgqW8B5OzZOdoZIfnQmGghTqvmlh5o4paxLagh9m4pnIkuyjscYhf65+h8l39avbMUVfhexVuC9m+Mdjbo4OBWabandQEZelIry6ovBamWzXB9qCJw+FGwjzyVRWy6aMIBYjSe7GWsJnxrP2jakFHcf0eozR6598IJZcT+M6g6cGQl8NUgLjmtMzkAXKjNjvkne31cLJeCj4KQ8m0RYb4+syg7O1DZeSsMu1wHfawOEyk/gkPSPxmTLUhJPh4dV+NE3qqLrjWhl1bHYHDOc8Fj0Q/zmzeo8amY6Ug1H/ZP1MvoEnbEfgPAcktlq/QxggTUEU6GDTax0gdkdCcuC9yy44Hyh4y22RS2+cf3bo6cQyDTfcz98fKnK+pJtFof8f3RDq4N+7C8gA2Qccaurfk/OzuMlCnNLrhZ8whgz1gXO/RRnMbwq8r+udLveVwK3YeTDLS5Gl0cwSQiCIj+PD4JDXMta82q5XwIHpw31+YNA4tg+gYm5r0p2iw5mZciGoG0yqL6SAayV0FZZMEs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PBU+lL1DdrNz7O+dveHKaw8KC9q9c5cIpBG7HGd5Ut5iyoVPJnkvthKv5eGO5Ml6epWaaLRm9D89fxQ9tcSokIc7MnzoL1RsSCVqyuDf9aG3OzmbC3d86ZNFvtpcsm/IVDo0VNPZxLyfOk4JDAfqfM6NpHBNb5SRdF7GAQBBAwyD8vucj/a8n5bdqvqCt9paCCRFuif62lyd47wm5AcrhY22LG9bzg78wc/BC7NHR+DJmWrfW7ipBBcx+gjZd2qYaHzOHZwQdPWtGeElONsn0+san8NLwbIFWVHOIu/mlsFKwXwOM6UcIkYD9z5qWdzpvsvQzr8NpaaNgVGEwi4oAhbJs/NgwMPO3ebRIPzgBJ9MIoKFLRXhtkYXtw9VlhT9MIxxhtuUUnIFtVsmrcmpV/FMXXjmPiNAQzFefq16i7sCso6DY6/qsbMocqFRQ2Sa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 10:27:36.3576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 718e156c-47a5-401a-9519-08dec15abb31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999156
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:vdumitrescu@nvidia.com,m:daniel.zahka@gmail.com,m:aleksandr.loktionov@intel.com,m:przemyslaw.kitszel@intel.com,m:akiyano@amazon.com,m:petrm@nvidia.com,m:rkannoth@marvell.com,m:razor@blackwall.org,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:gal@nvidia.com,m:ameryhung@gmail.com,m:nikolay@nvidia.com,m:jiri@nvidia.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21676-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[resnulli.us,kernel.org,lwn.net,linuxfoundation.org,nvidia.com,gmail.com,intel.com,amazon.com,marvell.com,blackwall.org,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB42D63699E

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Add a new generic devlink device parameter (max_sfs) to control if and
how many light-weight NIC subfunctions can be created. Subfunctions are
a light-weight network functions backed by an underlying PCI function.
Their lifecycle can already be managed by devlink, but currently users
cannot enable them in the device. They can be enabled/disabled only via
external vendor tools. This parameter allows subfunctions to be enabled
(>0) or disabled (0) via devlink. A subsequent patch will add support
for max_sfs to the mlx5 driver.

Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/devlink-params.rst | 6 ++++++
 include/net/devlink.h                               | 4 ++++
 net/devlink/param.c                                 | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index ea17756dcda6..29b8a9246fb6 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -165,3 +165,9 @@ own name.
      - u32
      - Controls the maximum number of MAC address filters that can be assigned
        to a Virtual Function (VF).
+   * - ``max_sfs``
+     - u32
+     - The maximum number of subfunctions which can be created on the device.
+       Modifying this parameter may require a device restart and PCI bus
+       rescanning because the BAR layout may change. A value of 0 disables
+       subfunction creation.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 5f4083dc4345..ecdc7098a4d9 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -546,6 +546,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
 	DEVLINK_PARAM_GENERIC_ID_NUM_DOORBELLS,
 	DEVLINK_PARAM_GENERIC_ID_MAX_MAC_PER_VF,
+	DEVLINK_PARAM_GENERIC_ID_MAX_SFS,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -619,6 +620,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME "max_mac_per_vf"
 #define DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE DEVLINK_PARAM_TYPE_U32
 
+#define DEVLINK_PARAM_GENERIC_MAX_SFS_NAME "max_sfs"
+#define DEVLINK_PARAM_GENERIC_MAX_SFS_TYPE DEVLINK_PARAM_TYPE_U32
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 1a196d3a843d..1d5f5c205c32 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -117,6 +117,11 @@ static const struct devlink_param devlink_param_generic[] = {
 		.name = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_NAME,
 		.type = DEVLINK_PARAM_GENERIC_MAX_MAC_PER_VF_TYPE,
 	},
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_MAX_SFS,
+		.name = DEVLINK_PARAM_GENERIC_MAX_SFS_NAME,
+		.type = DEVLINK_PARAM_GENERIC_MAX_SFS_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
-- 
2.44.0


