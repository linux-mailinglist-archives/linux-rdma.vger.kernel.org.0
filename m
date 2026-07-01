Return-Path: <linux-rdma+bounces-22618-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ps+fCEnERGpN0goAu9opvQ
	(envelope-from <linux-rdma+bounces-22618-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:39:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF96EAC0B
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:39:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=jdhRqtf8;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22618-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22618-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3F92305B97D
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 07:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB943BB66E;
	Wed,  1 Jul 2026 07:35:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961733A9E2;
	Wed,  1 Jul 2026 07:35:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891322; cv=fail; b=qpt0E3PbNmE26gUcM+dvIEm3attRoyQ8tmSGYI9zI3l7KvOCtyUr48TykSDP33bgYnkXv7lb+bdvTfsEZjyBF7v/6AIl62X9kbgk2dIvBWRFkzLCQqYl49c0aFkhWUToKuCGJALmN/k/Ou1RlqtCAB3sp1RLCBDupAnw2fWRZj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891322; c=relaxed/simple;
	bh=HK/PNCDj7wJNmskPDbGWQfoKzg+rR5J2hgfrUEz+d1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCY5JMxCqNVvaDuiFTgfcuLeq6bggaFfK06fweTVZ6Nht7Ghv6wc1HT+L7XSiYjErqbiYrq2gV1tW7dSlvDko8G+rrmqlUbcEVRFb4qHZZ+HWhMdNJVxl6QZy634bxqzVmPWBIj9EWetOI7ApNv4lcif4Ppc4V0vvxhSB1Q7tDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jdhRqtf8; arc=fail smtp.client-ip=52.101.52.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cysaox+jBo3rFJ3NpLdSXPw0t43sx/KZfAgVhA5Sxn6T/CE9Y31Q5iCLY6OBEzlz8w22hAX/mc5fnDs6uBIM2fnMwkByWeNMry4W0JCYMVmQvcIjqr/PuensxdmFEK8N2Lkeu4D1D/1bEiKpbCBl3bNo8OGfR68DLysSfoHxS2Bbgto+zVlSxB5sRb2mEy8HVTc/jIDPlKLrFj/7DJib4BdhkrXC/b8YOisOs+vRGByEOtpe/fm26x9gB5c5rCm33ahNaxjGyg9gFBHXNGNH+WmyUOMC1UlWgWxAVvEI3RZpQ3pI6Bef+vI4e9roTwrqXWJJxXrZz1Z9yxm7rgCgAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEOctaRx0wkt3E0eLNJH5PU/eIMHWT05U6iXAhJmqPo=;
 b=AMAR9YCKpCufc386ldHQL+0CK/4vx+NK6WXeajm24XkkrCf0avlEavfBh2eN0hm9TuA+BvGB8Eq8IA4HmsdCWe5mzy9DD8XfjcNhYOiUgZV6Sht/MiO5o1+VzAfyh35vEYp7iixHE9DdKCdSAVgHUMZlIpJW3jbVxC7fXvv6orcLnFfqWXvI7DWmffJl/eBqJf5GpEnoGBzQv9oPZMjl9Qk7al4DCPq0IEcv32uTyJSfNnqNEJ1vxTeA5DtI/jQo0e3/4+0h2px7nYSRWwAVbbLrU5FnVcnRvU8P1/rFUITnfG59AaRc1qrMHxj7JVZoE/nuOcKNCVhUA8ybsR98vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEOctaRx0wkt3E0eLNJH5PU/eIMHWT05U6iXAhJmqPo=;
 b=jdhRqtf8sVtJkwNdUjuqBbKdaatuAhMQq1uILtdIcDLh3vOwJJXjAFkOpnMA2O2AVkCqZS+T1P2l79dbQiExUt4AwR+E726mFZ4WAvHY+8xXP7nr1ewD0YKAF5dJjoLRf5oHqImiIT7e1C1lEGSyXAty0CRt+BqFJVtNXxMs6UtwDGFtV66HgwY5OXXzrnyPBFqTp3KFFEpdoy2blOV1AWXos2mU8HbwJUTm1Al3m7ZpS3l56nGh4GCe1VyQj6ueo/4YxI62SPlAAdoRfjX2a/rJjjS4G6Nb7i9bID7o4nhEAjkJghJ4RYD9eXNdFu4Y5ipBAB5fcyUww47XgNEP5Q==
Received: from DS1PR05CA0026.namprd05.prod.outlook.com (2603:10b6:8:23f::8) by
 PH7PR12MB6394.namprd12.prod.outlook.com (2603:10b6:510:1fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:35:14 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:23f:cafe::53) by DS1PR05CA0026.outlook.office365.com
 (2603:10b6:8:23f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.3 via Frontend Transport; Wed, 1
 Jul 2026 07:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 07:35:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:34:55 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:34:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 00:34:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Adithya Jayachandran <ajayachandra@nvidia.com>, Bobby Eshleman
	<bobbyeshleman@meta.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, Daniel Jurgens
	<danielj@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, David Wei
	<dw@davidwei.uk>, Donald Hunter <donald.hunter@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Joe Damato <joe@dama.to>, Jonathan Corbet
	<corbet@lwn.net>, Kees Cook <kees@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ratheesh Kannoth
	<rkannoth@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, Shay Drori <shayd@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Simon Horman
	<horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Tariq Toukan
	<tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V10 09/14] net/mlx5: qos: Refactor vport QoS cleanup
Date: Wed, 1 Jul 2026 10:32:49 +0300
Message-ID: <20260701073254.754518-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260701073254.754518-1-tariqt@nvidia.com>
References: <20260701073254.754518-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|PH7PR12MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8786df-d92a-43fd-6375-08ded7434a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|23010399003|36860700016|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	EIuwMEfD5V9WND7Smbpc0J6/2FF158nUlwrNkA8Pip0jmRevnE/h2gIgIeq9tcpSZ/dgJi3yjn6FM3fOCD1QWxz8NiCjebrlu/wJIBDNekvOjnBRiONZz8Kamp+GhQcNjCFnyB4TKGXEBt9B1IpX4eINYGMqeov0zV919YGl9BEbzp0KfxJ1zyKzdLzxFue8GR68us+ltx06MfkOEOde0/Zs5i22GW9VKSXKyEas6R1FRNYlEoUYqu9DBTCEEAofXoCx6y2A2tS1nXKxJM0gHnLR+X4Z8FxbdJQpOrJZ7DI0aWND3Ady5I1CxD0gEXnngDwsnwOMvlX+npR3KrTKNUFIdIxfrbHm9v8vuRTm52/S3vAhGV7iWN5wANeulIxaC5NXNAXihwdLuoWm3T7hyWz1CF2qqa+2QabCF5FDcHB4Qj4x++B36TPuCfqoqiGyGkeo5WAdCQGSwufDH0T1LbmpXFMJRI3AD5WXOuN65rkKYG8G/VVlLFgpCtEYMO9GjVURKmRnRie8Lim5RP9T1np20AzboRcpjIpxTVfiQul+rr0bIzPOiArH8h7pV7v6BaI22mnd74mZyifAD+Bz/z8kOWqyruWRxr67283b1M6zQsysPg38GOzgzOzSZ171AJ2XF4M+f2jo4T6/sjNW0hknBlw8wNQv1rLNl5IHQSxWWqa/whhnp4DHADxcLSWE
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cxTIHhYtWK4GS783pB9IX1Ra1O6LpJaOSP9+c+g52VU+LPI6msYoqQTfLY5y6vzg9Jm+aE1/ELFvx7AuZQBFQp6jievdX4UQtYVhQEjRUgmuvPpKGklg1N6SvhR1Z7xp509ZtupHLN7N6nLlcz5h/ePuMlLwy8lwa3D0SvpaYrKarl99Pw89KqgHwIwSbOtxyCvfphqRCgg3hlxBY3wrgNl6uOIvBQDToc+wGGKyVlG4I5JanJMQ/Kyqg0ADAe9oXc0wZphA2yYfA7g3V/ivCdO31mowdoRhrC7tXYqkGp+4+8doMbR76Q4oV01Ocp9bQwW25t86Ymz6xWVz0GxbOHurcpxKFyNpLkSd7VVVfwslD6affupekgVi0SBDukqL2pw0hk9SWTBAofXlC8ZKIdvb5amwkfHEcwklwIcLFkzidPkkBELqajH0T8TkXC5X
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:35:13.8284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8786df-d92a-43fd-6375-08ded7434a2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6394
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:ajayachandra@nvidia.com,m:bobbyeshleman@meta.com,m:cjubran@nvidia.com,m:cratiu@nvidia.com,m:daniel@iogearbox.net,m:danielj@nvidia.com,m:daniel.zahka@gmail.com,m:dw@davidwei.uk,m:donald.hunter@gmail.com,m:dtatulea@nvidia.com,m:jiri@nvidia.com,m:jiri@resnulli.us,m:joe@dama.to,m:corbet@lwn.net,m:kees@kernel.org,m:leon@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:parav@nvidia.com,m:petrm@nvidia.com,m:rkannoth@marvell.com,m:saeedm@nvidia.com,m:shshitrit@nvidia.com,m:shayd@nvidia.com,m:shuah@kernel.org,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:sdf@fomichev.me,m:tariqt@nvidia.com,m:willemb@google.com,m:gal@nvidia.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:donaldhunter@gmail.co
 m,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22618-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,meta.com,iogearbox.net,gmail.com,davidwei.uk,resnulli.us,dama.to,lwn.net,kernel.org,vger.kernel.org,marvell.com,linuxfoundation.org,fomichev.me,google.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BAF96EAC0B

From: Cosmin Ratiu <cratiu@nvidia.com>

Qos cleanup is a complex affair, because of the two modes of operation
(legacy and switchdev).

Leaf QoS is removed:
1. In legacy mode by esw_vport_cleanup() -> mlx5_esw_qos_vport_disable()
2. In switchdev mode by mlx5_esw_offloads_devlink_port_unregister() ->
mlx5_esw_qos_vport_update_parent(). A little later in the same flow, the
calls in 1 happen but they are noops.

Zooming out a bit, from both mlx5_eswitch_disable_locked() and
mlx5_eswitch_disable_sriov() the leaves are destroyed before the nodes,
which is the reverse of what should be.

For SFs there's no devl_rate_nodes_destroy() call to unparent the
affected leaf.

Sanitize all of this by:
1. Destroying nodes before leaves in both legacy and switchdev mode.
2. Only removing vport qos from esw_vport_cleanup(), reachable from both
   legacy and switchdev and also reachable by SF removal.
3. Unexpose mlx5_esw_qos_vport_update_parent(), which becomes internal
   to qos.
4. Remove the WARN in mlx5_esw_qos_vport_disable().

This also takes care of a theoretical corner case, when
mlx5_esw_qos_vport_update_parent() tried to reattach the vport to
the original parent on failure, which can fail as well, leaving the
vport in a broken state.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     |  1 -
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 14 ++++----------
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 19 ++++++++++---------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  2 --
 4 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 6e50311faa27..8c27a33f9d7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -268,7 +268,6 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_vport *vport)
 	dl_port = vport->dl_port;
 	mlx5_esw_devlink_port_res_unregister(&dl_port->dl_port);
 
-	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
 	devl_rate_leaf_destroy(&dl_port->dl_port);
 
 	devl_port_unregister(&dl_port->dl_port);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index d04fda4b3778..204f47c99142 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1139,18 +1139,10 @@ static void mlx5_esw_qos_vport_disable_locked(struct mlx5_vport *vport)
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-	struct mlx5_esw_sched_node *parent;
 
 	lockdep_assert_held(&esw->state_lock);
 	esw_qos_lock(esw);
-	if (!vport->qos.sched_node)
-		goto unlock;
-
-	parent = vport->qos.sched_node->parent;
-	WARN(parent, "Disabling QoS on port before detaching it from node");
-
 	mlx5_esw_qos_vport_disable_locked(vport);
-unlock:
 	esw_qos_unlock(esw);
 }
 
@@ -1866,8 +1858,10 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	return 0;
 }
 
-int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
-				     struct netlink_ext_ack *extack)
+static int
+mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
+				 struct mlx5_esw_sched_node *parent,
+				 struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index a0e2ca87b8d8..b67f15a8f766 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1990,6 +1990,13 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
 		 esw->esw_funcs.num_vfs, esw->esw_funcs.num_ec_vfs, esw->enabled_vports);
 
 	mlx5_eswitch_invalidate_wq(esw);
+
+	if (esw->mode == MLX5_ESWITCH_OFFLOADS) {
+		struct devlink *devlink = priv_to_devlink(esw->dev);
+
+		devl_rate_nodes_destroy(devlink);
+	}
+
 	mlx5_esw_reps_block(esw);
 
 	if (!mlx5_core_is_ecpf(esw->dev)) {
@@ -2003,12 +2010,6 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
 	}
 
 	mlx5_esw_reps_unblock(esw);
-
-	if (esw->mode == MLX5_ESWITCH_OFFLOADS) {
-		struct devlink *devlink = priv_to_devlink(esw->dev);
-
-		devl_rate_nodes_destroy(devlink);
-	}
 	/* Destroy legacy fdb when disabling sriov in legacy mode. */
 	if (esw->mode == MLX5_ESWITCH_LEGACY)
 		mlx5_eswitch_disable_locked(esw);
@@ -2039,6 +2040,9 @@ void mlx5_eswitch_disable_locked(struct mlx5_eswitch *esw)
 		 esw->mode == MLX5_ESWITCH_LEGACY ? "LEGACY" : "OFFLOADS",
 		 esw->esw_funcs.num_vfs, esw->esw_funcs.num_ec_vfs, esw->enabled_vports);
 
+	if (esw->mode == MLX5_ESWITCH_OFFLOADS)
+		devl_rate_nodes_destroy(devlink);
+
 	if (esw->fdb_table.flags & MLX5_ESW_FDB_CREATED) {
 		esw->fdb_table.flags &= ~MLX5_ESW_FDB_CREATED;
 		if (esw->mode == MLX5_ESWITCH_OFFLOADS)
@@ -2047,9 +2051,6 @@ void mlx5_eswitch_disable_locked(struct mlx5_eswitch *esw)
 			esw_legacy_disable(esw);
 		mlx5_esw_acls_ns_cleanup(esw);
 	}
-
-	if (esw->mode == MLX5_ESWITCH_OFFLOADS)
-		devl_rate_nodes_destroy(devlink);
 }
 
 void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index fea72b1dedab..140343f2b913 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -482,8 +482,6 @@ int mlx5_eswitch_set_vport_trust(struct mlx5_eswitch *esw,
 				 u16 vport_num, bool setting);
 int mlx5_eswitch_set_vport_rate(struct mlx5_eswitch *esw, u16 vport,
 				u32 max_rate, u32 min_rate);
-int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *node,
-				     struct netlink_ext_ack *extack);
 int mlx5_eswitch_set_vepa(struct mlx5_eswitch *esw, u8 setting);
 int mlx5_eswitch_get_vepa(struct mlx5_eswitch *esw, u8 *setting);
 int mlx5_eswitch_get_vport_config(struct mlx5_eswitch *esw,
-- 
2.44.0


