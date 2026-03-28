Return-Path: <linux-rdma+bounces-18752-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBbqDbQqyGk2hgUAu9opvQ
	(envelope-from <linux-rdma+bounces-18752-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 20:23:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F7434FC98
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 20:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 497FB308011F
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 19:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7144343D63;
	Sat, 28 Mar 2026 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bridgetech.tv header.i=@bridgetech.tv header.b="Br21SBn7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023072.outbound.protection.outlook.com [40.107.162.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FE13033DF;
	Sat, 28 Mar 2026 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774725630; cv=fail; b=Q58XCzr1M6DKvg+S0RGHoLlCZ3GH1pdNapzR0/qT7mUUVLhCmYDQGpFrb1f5J1SFbOFiLxa5JaupWNPYGVlF7zIpr+P3dUobf6JJ8NkxOeWc/pyl8RxOVCUUxNnbTV0wBcxNWvzqdOpBBFgsp5Y5U+e0LX/V7e5beBR7m8nunjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774725630; c=relaxed/simple;
	bh=uRTBTgQi2EWKFOb+CzSK6i3o+uniSMPiC0ikbORWf8E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aO+hm1iYbsSHTqO3oIrTyF/vgBi9bOhCOw795H+gJs/GVA/iFowEru5d0N/uD3i54tfBpCkRMUNNkvym2+RpgKKxckGyoyYd3dvkAkcfnb4BkGc0RjImJAXWHpWeUtEXD3JyVpLvnm0m7VGGI+cyp00AG9nS1GhMkMkDWdTj7P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bridgetech.tv; spf=pass smtp.mailfrom=bridgetech.tv; dkim=pass (2048-bit key) header.d=bridgetech.tv header.i=@bridgetech.tv header.b=Br21SBn7; arc=fail smtp.client-ip=40.107.162.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bridgetech.tv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bridgetech.tv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fttbbmrWy7YDgk4IleyIravTFmfWtrvNNtn8hqzsw5oXDq3Q08ckhNWniC5JlJzf97HY50eYYs8S9rpD3DEWAGVmNtUloCUvV3iGKKBTa6lvD9HKmu9Wn+lvunZ2uf2Xnq+5PFRtrZdSBANyYStGdzRSZDa3+lm30EOlBB9nCvlOPJ1v0LbdySdyhbqYMKU6fBU8xqlMUxmD3bDthj6A1UrukfoxUXarmDe2Ah5Jr5YSP22MaOSvIoNMTvPbHXFQoXFWcNzRHpYaNVZmE49Qtc1ytruRVBt4NN49ewHNhF95okHl+SH22gMzuXKLKzr8a/0FJeKrhm3Ve7evXUfDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dqpQ5mQDH2EE1ot5vbiA2Lpv6pyLgV5ToZGdIycKmE=;
 b=WL//MkvwJTnnmkgHd46iyjT2GVfKhoMEC193O1AHUsNZzUztgbjLB4S3Ks20zaabowOd5Z1O21foZ7PSWo4KP/iTLe1PQXvc5qrQymJlEnhP8Au/1Xv1jog+qXKADNccixJg1FqwvcNB0idW+2JXphc/YVk795VBGD7F6Vcav/hsIGEwfleAUjzG0lvHN+FFh+G/+IcHw0R+vbb1W65ecO4tlH2tRE1DnNGHAHEMdP4zCpRn7Sph209iWmaC+ukwapBWyDhFULagnZyMf0Fer3xhS8wqVHLFhIY8jfQZmZJeb/176iEtoGR61rDLLouVHZP4YgzL/tbFN1irM6rbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bridgetech.tv; dmarc=pass action=none
 header.from=bridgetech.tv; dkim=pass header.d=bridgetech.tv; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bridgetech.tv;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dqpQ5mQDH2EE1ot5vbiA2Lpv6pyLgV5ToZGdIycKmE=;
 b=Br21SBn7fFa7Ce9P5RxerbH+3uCFQI9eQI5MSiek+o0xwVq1A9F2obSiNyDSWa43NwvhSJZFPIxhjfRYWrLO3uZWfI/Ukq3wQofO/z08+CpIVA18ZdyLgKsVcKBDWSndysnbYGIU6KaCuB4NifvSMMlShLBTM7Tljjl/2fnVMG7ZM0/H6CfsL0zk3zAG/7KQLuw7QNUgpHxRyiX+QXm63cgnGlWDYNwbeO9Mv34BBzlDyzboqsctsHlEAubfwbsD+aqg9tMp1p+tbVcKeuwRYPBhp43aky5fhk8DUB1jYyP0d2EmeJ1hjckCEgVbbhn1KGwl0f+E2vI3oZSLgnNqaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bridgetech.tv;
Received: from AS1PR08MB7611.eurprd08.prod.outlook.com (2603:10a6:20b:476::6)
 by AS8PR08MB6485.eurprd08.prod.outlook.com (2603:10a6:20b:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.25; Sat, 28 Mar
 2026 19:20:25 +0000
Received: from AS1PR08MB7611.eurprd08.prod.outlook.com
 ([fe80::8c65:fe4e:ea79:bbb4]) by AS1PR08MB7611.eurprd08.prod.outlook.com
 ([fe80::8c65:fe4e:ea79:bbb4%4]) with mapi id 15.20.9745.019; Sat, 28 Mar 2026
 19:20:25 +0000
From: kenneth@bridgetech.tv
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kenneth Klette Jonassen <kenneth@bridgetech.tv>,
	stable@vger.kernel.org
Subject: [PATCH net] net/mlx5: fs, fix invalid pointer dereference in mlx5_fs_add_rule tracepoint
Date: Sat, 28 Mar 2026 20:20:08 +0100
Message-ID: <20260328192008.3525475-1-kenneth@bridgetech.tv>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0016.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:33::6) To AS1PR08MB7611.eurprd08.prod.outlook.com
 (2603:10a6:20b:476::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR08MB7611:EE_|AS8PR08MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 644c9dad-dd0a-4b36-9cbb-08de8cff1055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|10070799003|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ybhZY5TYCJnVC31BB/5/wZ2Sz/5BRikhsBnAfPlHwTmlOUetlLeQ0cE0Yk0yf8MH4xqsaD67nXHJ9eYia7WcY4Uu7S58jBfET7eZbS5rR9+z9xo3Tp/ado8mSEPSLBlMttO5DmIwHwrx7i/Neyn9c3V24jcddst8MqltG1Jymz6g9cyHCkYxR5zNsqP6iBe63/Rf7nZ5N5GhyRiixXxIolsRDE/A+fIOC6mWzXLe+TnNCqAY1nqRmfGhKz+nmSaHQeAcRsVM7wka+vmhwh2igaYdTxwO/5b/hHFPBuaUHCZCI0yL6F+nqm7aWuBPB+0AH0RuwUyhtCh1E7R2qa2souhrfVC/mBjjoxiidS3fekGhDkecODUlBqTPLFh+1Jrna8Fp2/TsekLmOc2BrXDfxj100tYgB5HIkLUd+H9BJEHDzmBVW+U9U6k1r5S/nmufZ81zxZqA873LwSMxe3yOz71iIV156fDISxD1VaFcdieLn8cRbY3DJKi4BwPIsIx0yk/FKfKAD13EU45sW2rEtSK9CvN0wHpr+CZEeZZwB9pER6zcOBzf23CmjXRuu5SxCqgEn3JDPFIbzO9F3cIHv0AX5bfPcVXXPgYNFYnPxySBCffQ9104t44BlDIw5JhuReZ+0R+2WZLvbcG8zC+sh8d1EOB02dUo6Fy31mkyeXaqYtakTWbj7v7v3EhRMD7m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR08MB7611.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(10070799003)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a1r0iFrIPIitG5+866XtYsp+QbtTtr51P+sfldW1pEtU4Nc6bJObQr/bFS23?=
 =?us-ascii?Q?afYMNh1IagMBXPsBILuEsCUMcr1cRO4mXzOsi4g0Ejd3vk6kBUuyj+Q6TYDc?=
 =?us-ascii?Q?Lto7e7QVqS0XokHBBF4hS7Pcz6NK/1Dt8vVU9Aelp3pZtPrHNX6PIvJJ7IDW?=
 =?us-ascii?Q?vU6CNpSiJhr52nL3LiO9zBJpgHGlKz9rS9bCCOHbZX+6XW1x37ELxAffLSxq?=
 =?us-ascii?Q?lm0jJPFnFwPiL7v7Gxg21cPczHUACv0MTeHeEsnG7E44Vo3T5MHoFxpV0Ngw?=
 =?us-ascii?Q?fmHp6I03loSgCJf9RQI1pyLcxjhFwEL01otAI/VP3N5uH0vrD+kp2eMd3KdL?=
 =?us-ascii?Q?xdEkIOvcoppQMnzWWesgHp0AfYOYV94brpfYR1m1IkSHyC1XMIUf81dRe5PV?=
 =?us-ascii?Q?zAiBS6luXym+J08VFayWoYnmzH2cX6VVwND7l797OwHAxuTMsZsKki9vxoJg?=
 =?us-ascii?Q?oc568NScqwM7z5qVt5NDQGxNt+s0iq5UHjATn3FVxDoH3TMI3phTWRO1DRWP?=
 =?us-ascii?Q?4ZvxNnPzMd3Xr9hl3cgDaWBxGo9RkMpt1wv/PPFg0bGv0BNoq3l3wq6a/fq3?=
 =?us-ascii?Q?j1Z33hFLPcPZaQOgOGbGQF7yQuVF+mTlpdYbHqTproiU0keF3DhAQb9WjM5g?=
 =?us-ascii?Q?fnluKx/MUecUI4QLmaa+UapYPOl+fyK6MeoU3zAQqkun27t/N5wpNS+iAE+t?=
 =?us-ascii?Q?9yIuB+0uWyulztFKOKMs38CJwdK8pzK55vo3+KkUFw/AXuWLoRkr0a6Z0bBb?=
 =?us-ascii?Q?AAmVQxrLh5e3KlZsRMzzkDCC8tLEc2DZ82Qn3SFxxOa/HRwbRENekILJt4/h?=
 =?us-ascii?Q?ntkfp0Twx49n8tTnwwDo7/t0MCU09JVhUCluQ92WdaElQHipPzaVDXgrIHK3?=
 =?us-ascii?Q?5WyDk0SwcnDHAxcvqk1yV6iRoKEk1LNnw0D0gUYW14uoaWElud0bsqFfLV1t?=
 =?us-ascii?Q?BWcMEiHq7Z95/7Cr+/LvqUs+tj7PUg/NOPVi9JHX0hcgUOmZaP4YYaFphYnj?=
 =?us-ascii?Q?N7C/7Sn3QKANznFCOWTSkG1oQaYI3oZeJMMGXif+8SlkMarXW8Zzv4qEECIX?=
 =?us-ascii?Q?iNRZKuW0cPMDRyMeILA65NGbWGS+EB7rh+ruGy4qHZ8n9QMPyDZu7R02AjnC?=
 =?us-ascii?Q?6JjGnrkQxXQh9FT9HJXxRIcuFKR/rUxInCfHMTbSwlrz7mkPXD523eLX5sAc?=
 =?us-ascii?Q?V1XcGF5Sh+xa22gDB9v6RSNhJs7Lgf1rqPL6utHzqWmid9VvW29HTtN09vuF?=
 =?us-ascii?Q?92iegC/iV3Ty7/R/2S8RDOr5sHXM5KYXNNaHKeQU7JaByQI05DdJvayKm/1f?=
 =?us-ascii?Q?VCAEUmEi54C1OcHU6ewijrPrcst5l7US54oMUTdfE6GYStx1R0oNPL2akm7s?=
 =?us-ascii?Q?0nMl/vM0p+ECGixFOWoWZNTb1SssXQWjJHjGKay8CmqX7/JdmNoQcMJv8Vkw?=
 =?us-ascii?Q?pnF0oXTzAA6nT7qjgbgI8GtmkGpcK5cuyVv7DztWTBQaN/UavA3pOYTGDX9T?=
 =?us-ascii?Q?M1jK9emA0jofAZr07pHkR1e0E4uqeOQZPdpNIuafMIpO5rZKUfa44IC8A/aq?=
 =?us-ascii?Q?3zzErYF5tdrC4aX1tNKtVGtGghfz8CPDbqaKdEi4FyO1amvGeDFSzseCGi52?=
 =?us-ascii?Q?QmWP+ob1FrId6e0ZEPcalE/w9WlUiae4gFnMnKw/4ja4nAnxGD1vZxvHB8p3?=
 =?us-ascii?Q?S2o8lr7VMT/ua92nhqzG5zQqlKEnMLEUibMJPZpqGiWBKKxuRqFY4O5IYoCy?=
 =?us-ascii?Q?XwpjWyxs4PFS7uBGhL/FgSlhCzI+I2JEKxZ5qaxVGVyDXbyLbXKgL+80qdnD?=
X-MS-Exchange-AntiSpam-MessageData-1: jn+qM6fBcdfvBS3aVCabl9G7XpMAkP4L5aM=
X-OriginatorOrg: bridgetech.tv
X-MS-Exchange-CrossTenant-Network-Message-Id: 644c9dad-dd0a-4b36-9cbb-08de8cff1055
X-MS-Exchange-CrossTenant-AuthSource: AS1PR08MB7611.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2026 19:20:25.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 511b9776-65d2-4726-b5bc-af4fc772381e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNzZlZcd7RNn1KAGc5hrQVYjjwy1vhxoSjbUWwPVSnas3J9FYXXY4DNKowe2eMLL+vVBAXuZyhUm0bfczrXsiWJ5L6rxEu6PMo3tCSCZCy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6485
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bridgetech.tv,quarantine];
	R_DKIM_ALLOW(-0.20)[bridgetech.tv:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18752-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kenneth@bridgetech.tv,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[bridgetech.tv:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3F7434FC98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kenneth Klette Jonassen <kenneth@bridgetech.tv>

The mlx5_fs_add_rule tracepoint has used the flow destination type in
a bitwise test since its introduction. However, that's not a valid way
to treat it anymore (if it ever was), and after commit d639af621600dc
("net/mlx5: fs, split software and IFC flow destination definitions"),
this mismatch caused nearly any destination type to be mistaken as a
flow counter, and thus stashing 32 bits of the mlx5_flow_destination
union into the counter_id field of the tracepoint.

Later commit 95f68e06b41b9e ("net/mlx5: fs, add counter object to flow
destination") exacerbates this issue by converting the counter union
member from an integer to a pointer. Now the tracepoint dereferences
whichever value is in the union, and in cases where that's not a valid
pointer, it can lead to a kernel oops.

Fix the check. Reported by GitHub user whi71800.

Cc: stable@vger.kernel.org
Fixes: 95f68e06b41b9e ("net/mlx5: fs, add counter object to flow destination")
Closes: https://github.com/knneth/mlnx-ofa_kernel/issues/1
Signed-off-by: Kenneth Klette Jonassen <kenneth@bridgetech.tv>
---
 drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.h b/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.h
index d6e736c1fb24..b099fe71b781 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fs_tracepoint.h
@@ -289,7 +289,7 @@ TRACE_EVENT(mlx5_fs_add_rule,
 			   memcpy(__entry->destination,
 				  &rule->dest_attr,
 				  sizeof(__entry->destination));
-			   if (rule->dest_attr.type &
+			   if (rule->dest_attr.type ==
 			       MLX5_FLOW_DESTINATION_TYPE_COUNTER)
 				__entry->counter_id =
 					mlx5_fc_id(rule->dest_attr.counter);
-- 
2.43.0


