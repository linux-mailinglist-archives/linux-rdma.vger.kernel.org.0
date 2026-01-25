Return-Path: <linux-rdma+bounces-15983-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qExTEuYJdmnYKwEAu9opvQ
	(envelope-from <linux-rdma+bounces-15983-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 13:17:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5111807C3
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 13:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF1A23004596
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB4431A545;
	Sun, 25 Jan 2026 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BtK8dF6x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73647319615;
	Sun, 25 Jan 2026 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769343458; cv=fail; b=Ec7GS6Nef1GAGIpSH/qhFfIW6K02beEEymj1XDxjXyreOJQv8+FDlfGDKOF7BF4CqbOpMgcKcPycVsmmp75DyTBqS2KQqOVOA1TOYyJrdZQZH5gsXIxsUQy5BJAgiiaAX1qW7ayZgDMxGfBefg4NjZH9l1a7KgBcpCfuTFIUhA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769343458; c=relaxed/simple;
	bh=jTP6u/SOYUtkzfLR41go0+EXtvskdOQVrvLmN++NMm0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhPjgFWlIYaClFN5gOk+gJXv2cWZEo87fIyCEgMf3fBSPAqzWeveJb+Lu1QPycEo4fVQ/nDAh4QygJl4BPNSnlYa7/C3O1g/dxU4FCLj0acjj03IP1Fc5LdmlGOCgVUjE0pGkd2wPF8q+RHreSHaMzxeBUFQKVeYD+eLZzz5ZKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BtK8dF6x; arc=fail smtp.client-ip=40.93.198.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flBeansHqJpRhvvDYhKO3X4NRBbEGyGiE3fcdgMbUT3FfRsoIW6bPwuPOyPaiwGT2XXVA6MTuJlVLJMulcHpDCveBW5PhoC9OLnfhq+e3sQn+RrtNa4W9Dc8Dpd5mK0STNmv0nTveKTThYppkeM2Enis6uiZnHnOearZHJcxTJv1LVaZsw57ZI0oiG+MHQ9yPOcVmxzOIh099Z4Kh2ruDqIwnCHG2Cc+E0FixDDKteaDjzCXcWevGkZAt01MIluIKWy9vDZ/5EO3QJ+/8pz8awpM2f5NsJEj5nndOMarj4hCwROKCjodHiF/wQpawz/R4wIr8FhJrl4pfeUfEIWTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1Z0vMEPwG+gkuqGh3MytnmZWaLABOnwVfISjjSa/NI=;
 b=FchbrUUUgXcUfDUafDXr7lk9IGqZ9B8neWvxhYpftWcVHJfUw6t5KSpKApX8gs+S96FoShvA35tJY+0DmTHfTL9hBNb388ATbs1FpdJsWSciUpVW9BzCJe6xwcJm+NDIdo8JAtuadheICBtVUeHPJHymD/CcaOYudgJvEpzoD4p5v0WvrSUk9zGgmqkNI/UyF0nbC2CeSjvQ2iPTqdl0CyOYbidXsm8ETKlwqFtTnOTYtDVZxi9KUgYZ8sKn3J1GBGO8m0A0S96o+lQYWmjcKLOcdbuRXo6HybZnW+7ltCm7ns079fPGbwB8PIDts9lJiR4EbznT0bEXMD3GS/Dq0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1Z0vMEPwG+gkuqGh3MytnmZWaLABOnwVfISjjSa/NI=;
 b=BtK8dF6xRhLDQdk3XCA1Ikr57srRE8UMqFRmqbZpvSZB8naqJ3p+rNpiBkjWAeCQXzosJsYiVFr7NhDYVH7kjvm1Gf8yP9Ob8bCZh5v8KYOe1IXBO+Qj67wc+VbCKM0LL0Ykac6tcfiHhMgIdpWCss6ZMvoPjAJvPK0j8nh+EgyA55g527yNBEWnX19+/4LUbGozqP7AgcS2E0t1vXaUSf6bEcqFBtHN7xIO6caCM21cJyarR2YXSXqSIGsq9brU7oMW1P9OkngxI69CRx0iYPPJ0pwJ5Un1iOdou4GXQKHkbC1AqbNPnJajfsCQsiT3SeNilnHWWYjI71doa7UBxQ==
Received: from PH2PEPF00003855.namprd17.prod.outlook.com (2603:10b6:518:1::75)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Sun, 25 Jan
 2026 12:17:34 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2a01:111:f403:f90e::4) by PH2PEPF00003855.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Sun,
 25 Jan 2026 12:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sun, 25 Jan 2026 12:17:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 04:17:16 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 04:17:16 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 25
 Jan 2026 04:17:11 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Igor Russkikh <irusskikh@marvell.com>, Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Alexander Duyck
	<alexanderduyck@fb.com>, <linux-rdma@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 3/3] net: aquantia: Remove redundant UDP length adjustment with GSO_PARTIAL
Date: Sun, 25 Jan 2026 14:16:49 +0200
Message-ID: <20260125121649.778086-4-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20260125121649.778086-1-gal@nvidia.com>
References: <20260125121649.778086-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0049a9-882a-43e0-328b-08de5c0bb7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M7DiOCF5oY5oaA/ovK27vys/VhiuW8KMXsl41LrtEARuplHtiQTC+T/ujS0z?=
 =?us-ascii?Q?LKAJOdEHHeHpp/xJdIH29hOjsO4NbCgvXtzxV3vv3CtXX5zwEwb+CZa0I/9L?=
 =?us-ascii?Q?93Pn8vpz+IelUhgY6MObA6rmPHaxfmqN3YQwsaDsD1ooPxGG77neFjWl37OA?=
 =?us-ascii?Q?PPm/Qf2rpqL//b6hMMk4VlTGpfMFv7kyRuN2bfhrX3HJkPJpDZ0z/saRRI0a?=
 =?us-ascii?Q?qThU7TtzPw54FlKRQJ8EndhWm4BKE5rH1frzlOIRGVcDN4+yQv8E9gZ9a9dC?=
 =?us-ascii?Q?Q+u7cQ4WL7/scQKKeu2pwRPUwM7o41VMWvAVVQWm2uuJpqMgQ9/qB4hIQM4c?=
 =?us-ascii?Q?QNXNxd2ssXiFEqtzpmlPtDLTO1DNdIkrChMpc/MirtXaulMxw3SGR7BJZzYj?=
 =?us-ascii?Q?1uRCIT7NNDKjBJh2wqbXQALSfgg6qXz6LkLpldfrkZjLe/nNGCaKbq7hrCq8?=
 =?us-ascii?Q?XSwhq5h1yUxSx3sy05xGk2fm9upaDPb0A+iEXi9MjB6E38ngxELvKjs//eH7?=
 =?us-ascii?Q?iyPYmte00e9hpOBAaMzwm6M9PMsLRov56By44onWo7LBM0bs3mSdx+qzGgHM?=
 =?us-ascii?Q?W1GeVElVstPVXscnU18YwFv7WPfYNyVS5KJc5hhHLeGKztZGzdOUTB8cMMcX?=
 =?us-ascii?Q?A2rAUoXUvyk8cHMUEr3NFNCW1JEwwDYaF9JNqP1srbeDeCsuyrvja+fWTp7J?=
 =?us-ascii?Q?1aX3PuD481NZ8Zu0tTecCkOB7FsE2HUB81N/8GDTu4808RuqPhrMGR0zCMPP?=
 =?us-ascii?Q?D6N0MIbAp5NYU45bUkMutdvdZAjDcvbpbWvgK6JvY1dMqSURm8LKrOo7tIEK?=
 =?us-ascii?Q?PICqPA0pPKluUZ/hDQsgXCV5XZmyqNhuh45t+R6fqvyJr5uv85sfFy/nbPFr?=
 =?us-ascii?Q?zMRG0hWGH44SGV+iF6R7Om2jxZW0j0xFpm8gQDfU5W+2+xjflSI/7v4PbXE5?=
 =?us-ascii?Q?e4eLfJTxX18dIOz4haD2gtVrkvj1Qf6oQykQIRMQ/WrDEI96KAGQeMcRJN6W?=
 =?us-ascii?Q?SY2B8pVJZKUt3lhGPKdDqzYPTaP7wxyTJRNQqYEYRteRT0BvNAIb0qajEDGT?=
 =?us-ascii?Q?DARE12thlYr11SVHtc9j4u/NYZBqFD4UsV8WwUr0C9O8p8RVGhfyio6H1Imz?=
 =?us-ascii?Q?tgOh7fO8tVqZwGXBKFujYAl4kgxUt4dG507T8l0P0Up1PTVDwVV5BpWLdBN2?=
 =?us-ascii?Q?Div55Ee4S2DLwBncCM65LfROTRE1jyN6dHs1A4q26qqFzO8ijppqP5asEzNY?=
 =?us-ascii?Q?KuuVYoL0I6ThcPEYF7fEnnuIrupWM/zmA5CnKlMcBGuHUks3F3yTAAmg6HNv?=
 =?us-ascii?Q?SrqAludpH+zdtSVPuRaRG5BUGQR49eg8O6HyS7rzh6gJtPz3CbRkD401cAph?=
 =?us-ascii?Q?aTr5JBCbCK0BTHl8apnZCpRUcqq0oVqSUT82U/fYGKfQPvceHbEdCwNH7PBa?=
 =?us-ascii?Q?qk7CUUZK1iOMS9ROwW5wmYWA+IRZP1cpoIETGOl9EVVoZwJzMbEixtODsdy1?=
 =?us-ascii?Q?J7Mn0T0j+lIXiiEE7k/tNzG8LssToCJpaNdUx7BVHStbXz3/05C1DZT2keYf?=
 =?us-ascii?Q?sEq5/noGQG2dMt5gkS9PC2NkvNFptiQzoX2YfAdjisa2IjhVQtYMWtMacPQo?=
 =?us-ascii?Q?Wj4eM7UhYwLdB87PHnu9GgyvwaR8a60Wd91aj+fp3ThcWDZVK2YMux5px93S?=
 =?us-ascii?Q?hGZCMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 12:17:33.2054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0049a9-882a-43e0-328b-08de5c0bb7ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15983-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A5111807C3
X-Rspamd-Action: no action

GSO_PARTIAL now takes care of updating the UDP header length, remove the
redundant assignment in aq_nic_map_skb().

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index b24eaa5283fa..ef9447810071 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -701,9 +701,6 @@ unsigned int aq_nic_map_skb(struct aq_nic_s *self, struct sk_buff *skb,
 		} else if (l4proto == IPPROTO_UDP) {
 			dx_buff->is_gso_udp = 1U;
 			dx_buff->len_l4 = sizeof(struct udphdr);
-			/* UDP GSO Hardware does not replace packet length. */
-			udp_hdr(skb)->len = htons(dx_buff->mss +
-						  dx_buff->len_l4);
 		} else {
 			WARN_ONCE(true, "Bad GSO mode");
 			goto exit;
-- 
2.40.1


