Return-Path: <linux-rdma+bounces-21457-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MYgILyVGGoMlQgAu9opvQ
	(envelope-from <linux-rdma+bounces-21457-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 21:21:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F795F6FF1
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 21:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D93A30FF29B
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 19:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A836347521;
	Thu, 28 May 2026 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T8OW4VLG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013014.outbound.protection.outlook.com [40.107.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317AF348C42;
	Thu, 28 May 2026 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995694; cv=fail; b=FB+jeRy5KyhlLXndmHTpGmXqGZplQb9OkDBUonPEwbC+9i24Gfk3WiXDzzaKyGMdw//NOQu1TD1P3OiqkXoOK39kVyUJRpIMzgl6yqLomI6ee3jwcIG0wnts2rblmTaH3Y/jfJ6861HTk6REEX85+jk9a/GSxLXYXU2Rb36I1Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995694; c=relaxed/simple;
	bh=MZHvqXiDKNOrgyw83gtrpozjAOH+kLbnmRGbouvIAQY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J9gSi+I7oJChtv/gL353ttK2sF91qIHzD70eFFlgnAjvk282TVJUytXax5k4jHgOAQUUg6NQDL1ogDs6x6VUEGaGJQiIsrEc4ITxSXLGl2f+tZvcgfYKF6o31YwRmS9vNSLXlvaoB530BbISTHyPcLNuxnwmJFYPSqR8bGJIPKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T8OW4VLG; arc=fail smtp.client-ip=40.107.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dX9to5mZL1yGgM1OQdJbG4NJ1cEabm9idCCpM8P2sBXRJ9/QxzowWXlX5UuUd/Ctyu2aMumFdOMBMXKpUlBjDKCmUDTVz7TxvlEoGowmgfChd6UjdfGcm8B2PWh+0OLCbh9STgdcK/c724QAIALI4Vaxc4m67pi2N+LPJ717EDdsqz4IXwnlCZCXgwsdjVPJ3T5xr7ttq21PCHSr3a6V7cN13d5KbYCwsluUwidl5VjkdPvF9k94LDDBM/mc5IpulAzdCNpgOmnkKeGQ0l0LiG8Nlo+CuENot6Bi2Ux/gL11j3RxP9i1NmB9VAG2Fz/p/RFMyqA3MSB1ipwA8gj/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a49xA+6FPfvUgj4jgn3j/LgTKavLe8qpCZnymQZulX4=;
 b=ZgEat08jpq91otFGD0OHz8GH19fW/UeSWItTNFElwGjEwnfjWOrt9qHSxTgFkLO+g621oIt7wi4G69/rcNntZRREbFOcx7uaBIwIfbmDOM7u2x0R5c6DPnvrWTp5+gY/1jssOFIiqy3bQJCoMgKCzI3UzFSH4NUv8QxCYMS+eYfqPQ0ImW1hM/ZT8v/NO0rXkLjTCME46yOM6Nv76oRY/hFEUJ+HuNrxWnqcMPFMeGP6gzbTsy8dc2k5wg2S//rgEdB75jCExpmq/13wdgjQr69/WguDyWglmjSCPPcWWI7x2PzMP27pZOMoCQbdgSo+cySrR5wV3wdjp81EfiSZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a49xA+6FPfvUgj4jgn3j/LgTKavLe8qpCZnymQZulX4=;
 b=T8OW4VLGKGc05pGQ1INz7FbKweWS2iKfKtLZcqnWNEn9WdtgPxKGNcbPWKFatDSPOaUXUlO6U9GYdwgoHIwBzrj2Ex3ProXy/zVC+Fbwbkmld+nw+25W5Z+AM3fhZomFi9Fib+Udi/UNfN/uiQS1sLAfXicDMbHghKBcoKeCiP0YgTspcvDnv03KgIXa/MRqerUFHX40jQvpL4PaPF+Nue3bjfGYsrPCST7WEe6NtJmMvliFujXCBswjX1iy0uC8Zjl8bIknxE2Uum+SBBWsUkY+5TVaRJ/A7kV+PdRaKNWXf7k6K3C6bpgJnRUxBx14sIYpZczt8y1PxJ6pRhCXOQ==
Received: from BY3PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:217::30)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 19:14:45 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::4d) by BY3PR04CA0025.outlook.office365.com
 (2603:10b6:a03:217::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 19:14:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 19:14:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 12:14:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 12:14:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 28
 May 2026 12:14:15 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@nvidia.com>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net] devlink: Release nested relation on devlink free
Date: Thu, 28 May 2026 22:14:10 +0300
Message-ID: <20260528191411.3270532-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ace755c-68a0-4926-cc87-08debced5fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	qEmQiN0XlMoF8JqO83BAx3EtH50tDXTDVu/wl4qRnMVLq6/a4fmLmXUMvmHl5ZqOF8tZ2BDk8Z52L68NiPhob6AfEzkhgfUhWmUnw9mwnrq3CNNSlMhbQl7ppEVZX7MNo/DCSwpDjLZNaMmd/T82r+HjHmGhoSD67kfuTtAFfrqn/bBasUmE3/p2XzhmycHOvmg0W6Irb3waJRYTMzlZYhXD/fa/DeNy48QU35DfL4UgDKOH44ked9cLiJv4EM/QXsjRtsvNzz6v3HagIC9EANlJyIkSrdx/20EXZslttFjeKg3tAF+m4rxUy0wum7JcCH1lTyyvx5zxyP2vomULBmgQ+SgBpSj8YoTH+Lwg0YuY/cRjSepwsKsYGEhGikiHqhK654pe77pC2SPK3NIGBy68tzf2bRavSvLRn66Es5b0HhH7zDgqniSLL6wguEkOq38MQt8uHuLv4KhBmFhtKBnzuoPz28bPkKw6tAqPErbbzcZ8urMM6nNdpdY2gUbXIB2YcDi0lIHV7oYTZgcnOg6j4IoFxKexGv8Tjc81KfJwxqNMW9IJmg7US42TvmYhWCHoolmq8KbfpNBPhUX6PE4paj7JtFL3bfzthZvykTmp5La11HA5jHcQMJWV1L+b7lSzmo5ogIMK7Z1mMEBxBLeYjAOJZ8RDlqbHZFMhjY3XzHFGVXBXhWs0Bo1nXM6wzdT7Ddv5TA+f/yngI96/Y0JtfOJzVkhpMpU8hBHAiMY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fIBLVDEqoYYk/RHRmd1kJ+9zpsNpZfOyFwuwFuFuWs2MY0vuD3SQ8b+JsiMejfgAdrYN7ulPTwlLoE671bpQv3MVcXdFfjvt6s9p4cKXlxVeK6uTDOvogsoJUNHBR0MgxG0F6sIVSO/toMg+HUWdo6V6nle1w97qZVk2ljsWalOs9f+wFsY8yGTC2St4kqm1f8AybFF82Ac9gNafbTYPlP7QV53e96bvLpwUWxScnhwLf6GiUI4B9ZmZcLZ6DmZWDu8mmkiMGnqE4MHzgOoaJt18sL/R0vcKrrlNcnlHMeBkHuTxz3kQVybzZLeaVn/AlFGrdAFQXztHjWoqYm7PL6DUpNd/4EEaVC9xLfnaSJRlcDEOOd/WBB/FM3wFzjKt95ZsDuhOLcjTMYkGXLZsg86/VJfJSSlQ9GC5OWhQjgHNuOzntXhlh21NiupipDli
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 19:14:43.4152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ace755c-68a0-4926-cc87-08debced5fe2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21457-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D0F795F6FF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

devlink relation state is normally released from devl_unregister(), which
calls devlink_rel_put(). This misses devlink instances that get a nested
relation before registration and then fail probe before devl_register() is
reached.

That flow can happen for SFs. The child devlink gets linked to its
parent before registration, then a later probe error calls devlink_free()
directly. Since the instance was never registered, devl_unregister() is not
called and devlink->rel is leaked.

Release any pending relation from devlink_free() as well. The registered
path is unchanged because devl_unregister() already clears devlink->rel
before devlink_free() runs.

Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 net/devlink/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index eeb6a71f5f56..fe9f6a0a67d5 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -518,6 +518,8 @@ void devlink_free(struct devlink *devlink)
 {
 	ASSERT_DEVLINK_NOT_REGISTERED(devlink);
 
+	devlink_rel_put(devlink);
+
 	WARN_ON(!list_empty(&devlink->trap_policer_list));
 	WARN_ON(!list_empty(&devlink->trap_group_list));
 	WARN_ON(!list_empty(&devlink->trap_list));

base-commit: 8d26955ea5a4697c1e21a3869ceb36b90389b051
-- 
2.34.1


