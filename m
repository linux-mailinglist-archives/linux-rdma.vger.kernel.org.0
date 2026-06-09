Return-Path: <linux-rdma+bounces-22004-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BhtRIzGoJ2oO0QIAu9opvQ
	(envelope-from <linux-rdma+bounces-22004-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:44:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C53665C867
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:44:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=IQHpnBtK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22004-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22004-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8487E30C7C5B
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 05:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5E63C871B;
	Tue,  9 Jun 2026 05:41:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AE73C76A0;
	Tue,  9 Jun 2026 05:41:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983708; cv=fail; b=IeY/kfgMhhzzYIIs+KtRa62gPtMVWAYWaIkUclGEWiu/q3+p9qBzhgHVCN1PbK0CgAclZpFO59TPqbhfSmKyd1sdhh9FK0CjsNb/NVmpzaS2DvolkWd7tekib52JthlGYQcrXmqrNA+e4RgFt/kdD0UhbwxAxgbY7Fgk0a8yK1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983708; c=relaxed/simple;
	bh=VLlaPhtMPmDiE1NTzWMJ6t8vLnbkUbSHNuSWQTl8UbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXlU6pb5l3//1/+ocwdFYgEgF+TS2WXqkAKKZce7EWtAlTAk6NH+KxeodICgHEAczewXt9xxG1tI4gdYetnnmS05KXnpiWYvOByUjIpMq7VQvpgpZ/hteB5bcv7iQigS4n1dP+lpxdtx5J4MxOxTlGvsYUSvg7hvKWcIP7PPI5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IQHpnBtK; arc=fail smtp.client-ip=52.101.61.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fo8miJobzMVWVyTZar7y1Qi7jC7OnC5RPB9x+Dgfm8j2jCBLp9vlSR6nUjSNGG8/XQ0KxUfzxind7L+qaa5Oqdf7TIoRg5ZkImzFIcqbFUT6EvJgUdFWburqw3GD6Xo58T85te1Su/cKQJbQAXtlgYAXHz4YG9HcTBoXwJ9QkJi3Nv2vzFD494eRb1EaxBvfPJT91iCpCkQIgVpUdA1HZVVFiPb3sLctHxAa90h8m8KE/7YAvzqln3F0DczV6VCIRcpBrO9zltVdwV8r0Z6Pag4tlcB8BqUW3DhT662ZBuO8wpkNmh8Leho1ZHOIyZkR7tr1OADvIzuFm10VY0UfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTNndGTvLiGO1asVytXshqpvL4htXO2lsToCrzL8e/8=;
 b=Cfg/Xkfl1AnpP377iFMV4ZeLxJMIMiHgQbv1hGkUwRaDlYfpnXspd7q5QPGxQmgV8Y1ei/5jjaWLQsk8EcLsCdcd7LVC2u8R8TnwxPbJXZvGqMEzPqE4bCaoqpdnzFVHtgH7NJk3iMnh5hB3F8ncDQsmuXH9+5+W8r0/FZaSjKkgUxAgRgqPI/vbevdtWjemB4ZpEAbFtqBFki3QfGWrXe2YoUJ21LGnwwd1hIahmghOhQoMRqA7+3M4lxrCv58okKVIsOnrbKRSUWz6sqbYQ7/ocDPQPYF/kbRqoh83Upw5lHc/qou4VdaQ6sarqgcNO4/2w9tyFQXiPRLmyNKy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTNndGTvLiGO1asVytXshqpvL4htXO2lsToCrzL8e/8=;
 b=IQHpnBtKA3NLqsoSYH1PQEbZ7bWkYf5jmTQ59gEwKxpO9DQ6+v4Lg53SltUKrAFPcnn6XZ6bvl0x7G1BIvfkUmgCScGMuANeV5jJZMW6OeF7MWwswv8yk1oqlgnOprJ7rq0y3+Bsyc2sm1Wme05xF07V8aUjv6GZrkbOkkNNnqgbqReiR7LNj9vIoZeP9DljQu3Dq4N+zJB+zg9EBOejArNQKo66oncAtNonrfHO+cwj4cMeY6Sa+jWl2qbjc+SXOIs4/MHf1SxEm+Q1UYw6axDkUnvSI+505q7x+CkoMfkqWBihD8A+ZDHLpoerBE5NeShv5S8MzDgHq4MX7kTqzw==
Received: from SA0PR11CA0173.namprd11.prod.outlook.com (2603:10b6:806:1bb::28)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 05:41:42 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::30) by SA0PR11CA0173.outlook.office365.com
 (2603:10b6:806:1bb::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Tue, 9
 Jun 2026 05:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 05:41:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 22:41:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 22:41:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 22:41:20 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>
CC: David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, "Chuck
 Lever" <chuck.lever@oracle.com>, Or Har-Toov <ohartoov@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, Shahar Shitrit <shshitrit@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Kees Cook <kees@kernel.org>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Petr Machata
	<petrm@nvidia.com>
Subject: [PATCH iproute2-next 6/7] devlink: add per-port resource show support
Date: Tue, 9 Jun 2026 08:39:52 +0300
Message-ID: <20260609053953.487152-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260609053953.487152-1-tariqt@nvidia.com>
References: <20260609053953.487152-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 0941d231-c3f8-42f1-df99-08dec5e9c8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9Atx1TvAd6lCPIbKGLziDAQexIr2ZYTK74z3fPtH/z+3GrDC8rnmAdqPykYX2bCvcxg8vYl5Q2TsDqRI2eGPsuCGlBGoxcoqneHL3kBIudLqtjOlkcL2Gq669oWKJ7EF3HFXS58aUvDMMctKWkoRjLsL7Gmo3BE7zO3plf7Ii9TT29ycQMAOXD6PFWUqIUqpG0XL4KMpH9ho3d0uqktyemn96oXdPvuMtuCDD6LuAoLjpGYPfYa5rsPc50lhsCpUmtbA6ejWSeMy2QDTDl1UU+ttOsgS7E/jlkb0pMlS9UKCJI+zJfUehAeZH6rE0U7MwzEBzR4upHH64QCzX6P4wlWyHxMkXfwbfU7TXNBVSZ/PrKr5YKbHUNLKiJOS+jOZLKDSgk9iU245r96vZSz+4p0eWqnwl2bQ9cq1fupyuO3hAm0NAwH4DQkTtgJEu4YL1T/iqaB2RZPveUegyDgNMkFb80QiwhNuDuzXMjfiApOppC5uvshv+zZQqzdYUl9R7vm56gtw7P/zC0gQOCYD5gRzwhYGrZ67UjujOV80f0RqKXDIqq+1vwYjwPFBoml/sAFuZo0LCT5LQIF8rsEoqjBu9Sjt4oyE6Djra+9vWSGXiLcw6BM6SVSKF3nc+jp4MZEz9ZkRJHyoSNKNG6r+9BfKLP1yM9my8EEDSwlx+W76pUZ0XfYZMdrR9boqYUtLEWrxgXgNHf8S+PzJ7TbGKTECEwMmrbcg2PYAoyE4YVI=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u7UDBq/cK/XiNR5cIV1G3IkUs+fqASBG/GN8v0gqibpdZqniUqzdjLeN8MZgqqrj4nieqtdMvdfsdof9f5fCAfTzW0ugLPq4P9kazKtEHR67bKZ4+DNN4sauYpWWMgaeBIKdB4nfDd71A4WGjojFgyrM0ytJ1baLE/Zcr5ZpdH97C3cBr/+QHPYOJIuIGw+bzkYc42sZ8IkXkPsiXqTot7kdkw3DQaD/KaPq3uNDZzO7Ejo/4i5eym3iqxIT2xj/F8W+a7sgLUGjzb9fMQP0znhOecClF6hIzGziwXyictV7PUOQuixv8tyKOJQn7XbUwB75J2JpuaJe7bAwrHU+z9g4IS2tr0eRpAYn+h4hVw3ratUbtIL9tDYaeMYekkVMs5Rsx0616ru/y0JdKvVKusTcdDDr6Gd5LBKPhn28+izFuScxInz0u0V8e+jcYK1W
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 05:41:42.1621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0941d231-c3f8-42f1-df99-08dec5e9c8f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610
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
	RCPT_COUNT_TWELVE(0.00)[41];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:dsahern@kernel.org,m:donald.hunter@gmail.com,m:horms@kernel.org,m:jiri@resnulli.us,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shuah@kernel.org,m:matttbe@kernel.org,m:chuck.lever@oracle.com,m:ohartoov@nvidia.com,m:cjubran@nvidia.com,m:moshe@nvidia.com,m:shayd@nvidia.com,m:dtatulea@nvidia.com,m:daniel.zahka@gmail.com,m:shshitrit@nvidia.com,m:jacob.e.keller@intel.com,m:cratiu@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:ajayachandra@nvidia.com,m:danielj@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:gal@nvidia.com,m:idosch@nvidia.com,m:jiri@nvidia.com,m:petrm@nvidia.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,m:danielzahka@gmail.
 com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22004-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C53665C867

From: Or Har-Toov <ohartoov@nvidia.com>

Extend 'devlink resource show' to accept DEV/PORT_INDEX, sending
DEVLINK_ATTR_PORT_INDEX to the kernel so it returns only that port's
resources directly.

For example:

$ devlink resource show pci/0000:03:00.0/196608
pci/0000:03:00.0/196608:
  name max_SFs size 128 unit entry dpipe_tables none

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 bash-completion/devlink     |  1 +
 devlink/devlink.c           |  5 +++--
 man/man8/devlink-resource.8 | 17 ++++++++++++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/bash-completion/devlink b/bash-completion/devlink
index 7ec6a7cb6abd..3d8452a8869e 100644
--- a/bash-completion/devlink
+++ b/bash-completion/devlink
@@ -704,6 +704,7 @@ _devlink_resource()
         show)
             if [[ $cword -eq 3 ]]; then
                 _devlink_direct_complete "dev"
+                _devlink_direct_complete "port"
             fi
             return
             ;;
diff --git a/devlink/devlink.c b/devlink/devlink.c
index 737cfc7437f9..4224b7fa6792 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -9013,7 +9013,8 @@ static int cmd_resource_show(struct dl *dl)
 	int err;
 
 	err = dl_argv_parse_with_selector(dl, &flags, DEVLINK_CMD_RESOURCE_DUMP,
-					  DL_OPT_HANDLE, 0, 0, 0);
+					  DL_OPT_HANDLE | DL_OPT_HANDLEP,
+					  0, 0, 0);
 	if (err)
 		return err;
 
@@ -9035,7 +9036,7 @@ static int cmd_resource_show(struct dl *dl)
 
 static void cmd_resource_help(void)
 {
-	pr_err("Usage: devlink resource show [ DEV ]\n"
+	pr_err("Usage: devlink resource show [ DEV[/PORT_INDEX] ]\n"
 	       "       devlink resource set DEV path PATH size SIZE\n");
 }
 
diff --git a/man/man8/devlink-resource.8 b/man/man8/devlink-resource.8
index b55138d950c7..1e7d96126ce5 100644
--- a/man/man8/devlink-resource.8
+++ b/man/man8/devlink-resource.8
@@ -19,7 +19,7 @@ devlink-resource \- devlink device resource configuration
 
 .ti -8
 .B devlink resource show
-.RI "[ " DEV " ]"
+.RI "[ " DEV "[/" PORT_INDEX "] ]"
 
 .ti -8
 .B devlink resource help
@@ -43,6 +43,16 @@ Format is:
 .in +2
 BUS_NAME/BUS_ADDRESS
 
+.PP
+.I "PORT_INDEX"
+- specifies the port to show resources for.
+When given, only port-level resources for that port are shown.
+
+.in +4
+Format is:
+.in +2
+BUS_NAME/BUS_ADDRESS/PORT_INDEX
+
 .SS devlink resource set - sets resource size of specific resource
 
 .PP
@@ -69,6 +79,11 @@ devlink resource show pci/0000:01:00.0
 Shows the resources of the specified devlink device.
 .RE
 .PP
+devlink resource show pci/0000:01:00.0/1
+.RS 4
+Shows port-level resources for port 1 of the specified devlink device.
+.RE
+.PP
 devlink resource set pci/0000:01:00.0 path /kvd/linear size 98304
 .RS 4
 Sets the size of the specified resource for the specified devlink device.
-- 
2.44.0


