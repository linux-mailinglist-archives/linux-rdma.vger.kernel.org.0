Return-Path: <linux-rdma+bounces-22169-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1dm2GwjxK2q3IAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22169-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:44:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 647936790CD
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:44:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=CHdNnFoc;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22169-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22169-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A04C2302A58F
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04E63EAC76;
	Fri, 12 Jun 2026 11:41:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059B73E9C23;
	Fri, 12 Jun 2026 11:41:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264463; cv=fail; b=p5tZNpqyr2tQ/lj8hA5IeXl6Qhepkbkygra00kB597zP7Wq47zt9ikDGlZrasRj9HEJvkNlZRCtal3HZUaO47YckOlzqRHsajZFvBE2u9BtnDVo2EsqulMp+5DpjRiOSA5pK+1iwbW7KOp+lva9jDPBH5ATLWmHdx5kUNrJ31ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264463; c=relaxed/simple;
	bh=HboRoWNmPoJ4EBNZJICrwkeILAXmrZVaOeyicSlePpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7cwepOweucaYwextPlp4FZia36p6M3S5tlHlNqCCIoqKhw62ie8E8yagf9RYJur2pfRdGmKddXjJ0JvUfep+OOYNUWbBWXJOAYqsgHkLi9d6BciCh9vlXsjBqBfPj+7RuUsHiHRFxv9VSkY1z19ezsQQKUJC1wAuxJpie0l9QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CHdNnFoc; arc=fail smtp.client-ip=40.93.194.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCe4yG8EbOycltpIwU/0hy1FZZbV14mREsUZc+gaAd3OxL1Ae3B5OIERzPKBfIUrcqngpIGCH+q+zyUkbkfToJb/dqBjvbcFoD471MZIlNi1I//dVqLJEzcjue3cslGD5YxUq8SObE6iohr918flmszfjBfqV40DqCuzFV9sNGCa2yOgJTWq2SiILtaCW53e9OvLVcHV4lTSVSzrViTku3exMwTqAjB/dKDHxQwNwCPOUCZ20RXppcBYdy8JSxdzqF34xBiM1VRUtZ42MsnBkG+TS1ylPYOwbzl+XMM/dmS70Wq6mmMYfMR0WtI7bQYtINd/DndLDjzNMMbKkzRk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWah90nIpVusnj1Ba0IuXz+hlEMxKAehNVMRT5rS4Bw=;
 b=RpF9PfobAQoHmYIndLuPljArhB9bBNSLJsMU4NKNHEQp6s+VYofJxgkgiWo3LMtsEnWfJR8zQCKR7urImpqezArez+vkMwNc7Kf5nPAJ97eRxAs3k5ouI9PJiZn3gqaZmtNCORSQJFUagH3H/cZTcB3H2F/ySsjHfrlxhsJnpWuUlSTF5FOjpfUw888tMQCBGFJ7e1S/d8hhZYdulC9PSVY16ld8TNYvf70ez3tru3yVgNOnflZi8dSxTh4vOglLRclnng6QeWUSusbJwXaTz408j4UIgdrEG987vkmEc+E19Xc1PrIhKZYSahfQA3MFjrwrPD8PRgmAxN9KqonG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWah90nIpVusnj1Ba0IuXz+hlEMxKAehNVMRT5rS4Bw=;
 b=CHdNnFocwrNw5anseX3I8UZElx7xvavTU1sHmO+8kv76uTNqfcMHbyIoRo9IGqa+naf0TGImPxxxwEdKe6lnNr1FxO/rLIGcD51q1T0rVzpcp0REWxqJkvN2lJkASh9Jv47tPvRqXzk3zh35fVm0afzQ6eWrRlg4ItZ1TCsfuYfyJ7m0ZWTe26rSflqA+TUocSMuStPBd3WtA0ofkbettgjNZwuD0YQPjISKYE9rHTiu/Ljvnk9bL5mipeLIJjqJ+jOPy52KcfZXeTtBdtSGczjEasK+bndK3xbF1bAph/fXVntv5Yet2ExaV1M0HU4rGaJVedkbU9f46BIe9txUqg==
Received: from PH8P221CA0055.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::8)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Fri, 12 Jun
 2026 11:40:52 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:510:349:cafe::a5) by PH8P221CA0055.outlook.office365.com
 (2603:10b6:510:349::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 11:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Fri, 12 Jun 2026 11:40:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:40:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V3 11/15] net/mlx5: LAG, introduce software vport LAG implementation
Date: Fri, 12 Jun 2026 14:39:00 +0300
Message-ID: <20260612113904.537595-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260612113904.537595-1-tariqt@nvidia.com>
References: <20260612113904.537595-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a53a6a4-0f70-477a-46f9-08dec8777510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|36860700016|82310400026|3023799007|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	tg2oXvCUOMB9Scu4w08wK7N6rCvs1zDUYoxOPTOmiI37ZBz5FCi6qrsMGatxgWtGfrBMuDeEixmeHe/V47/NLYz6aFhGZjtVqK75UGoGmgj7TLq0l8xQCJhbym/VfUlZF0VfoehgcVhnPnWEuDevlcSQbR7jPtl6AUJoibO/CGZUKn/w7SClxvxLpFiQug0GMxpnsUpq22Fn0WUIdlRJIjIo9cxXAEFdOAyc7mKO2j0AaHN6a4Rnw0Vub+Z5C4qE2vYev1op8ghi8ieYfVajujQcW1Kk32uvGyJ2nwXhlx18UjOzyMukDhEmamsW6H0vApCoASBb3dBYiLK+KBhZ+fdsbvkcFz/62HOCThdKcDL70vehFvns+A5jJP6B0B/LD9Y5QhwvU/WbVHtBN/DBOHU26QGl3BrVHwEzB4iaARXBsB/34KvKcoLYtOYOG0bTFS7ZazMkY0icZvvuT3638yWPhOj/D+BU/McAzmIrJRwx/to7JMJTdBLGR9DGre/l1/y4s8uDZHTStfyKPpbgG7SrvJO5uE8xJUNwjL/pZTWMC6Q6ff7slq9f7tsr6LG8NpjblUm3jFP4YYqa2GqfKmvaXqgZxdtkI2I1llkyJQ7WTeuaN9V4qGfiWGWxPvMnTNOFEm+hQRwFAqNP7GuSfm23NddlRFfbJo2ryH/hMIz+Q2X6jTSgGG+DfSjPR7pdWGMp6IyR1Mev4xEpLXGP0Um2RZ0tF9GkuqGOAzocDmQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(3023799007)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tobvEL2FpOcQ23OLplgK3IMQ5d4JCNjW8+bBVUnUGixODQ6CelYX3TwSJTW1ZauHfxEsDLA8K//i4asnArc8JptsIlwAgizpXMWQ4GswRJgPAI+jlo1vwj5sTiqZ5jE9HG7D6hksOGc9PexiXgSbUpBmwtnjqYfIdC0fGTP6VDfamKmFJy4pdcRsv7QPygESiGyN7JWPSdktITnB1e2t8nVV8E2YHoEpV1JQvqsWViJuAf/ybyrPkEg738wh1zXM2nZCO6bo4tCc+kVk6Z+NXiSJ0lNdZ/7S05s7nRtP+cw1abGI6FdnqylnQD2H0XvVc5EHzL+gHilLnhX85vgW0V8+iycXNe1cnqiKIe+Nem7zIFeqdxAw80oP4+MBzIGh/ycbN7rE7C3G/UO+XIii5p6dveiQ2Vw8nraGxXNGuFEmkQCnHXkQBDT5qmHCMDHz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:40:52.3368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a53a6a4-0f70-477a-46f9-08dec8777510
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22169-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:horms@kernel.org,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:parav@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 647936790CD

From: Shay Drory <shayd@nvidia.com>

SD LAG is a virtual LAG without hardware LAG support, so it cannot use
the firmware vport LAG commands. Implement a software-based vport LAG
using egress ACL bounce rules.

Add esw_set_slave_egress_rule() to create an egress ACL rule on the
slave's manager vport that bounces traffic to the master's manager
vport. This achieves the same traffic steering as hardware vport LAG.

Redirect mlx5_cmd_create_vport_lag() and mlx5_cmd_destroy_vport_lag()
to the software implementation when operating in SD LAG mode.
In addition, adjust lag_demux creation to check SD LAG mode as well.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   4 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 142 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  49 +++++-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  14 ++
 .../mellanox/mlx5/core/lag/shared_fdb.c       |  74 ++++++++-
 5 files changed, 280 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 94a530d19828..a5f0774834fe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -950,6 +950,10 @@ void esw_vport_change_handle_locked(struct mlx5_vport *vport);
 
 bool mlx5_esw_offloads_controller_valid(const struct mlx5_eswitch *esw, u32 controller);
 
+int mlx5_eswitch_offloads_vport_lag_add_one(struct mlx5_eswitch *master_esw,
+					    struct mlx5_eswitch *slave_esw);
+void mlx5_eswitch_offloads_vport_lag_del_one(struct mlx5_eswitch *master_esw,
+					     struct mlx5_eswitch *slave_esw);
 int mlx5_eswitch_offloads_single_fdb_add_one(struct mlx5_eswitch *master_esw,
 					     struct mlx5_eswitch *slave_esw, int max_slaves);
 void mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 915571a1586c..a24719cfba34 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3041,6 +3041,136 @@ static int __esw_set_master_egress_rule(struct mlx5_core_dev *master,
 	return err;
 }
 
+static int esw_slave_egress_create_resources(struct mlx5_eswitch *esw,
+					     struct mlx5_vport *vport)
+{
+	struct mlx5_flow_table_attr ft_attr = {
+		.max_fte = 1, .prio = 0, .level = 0,
+	};
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_flow_namespace *ns;
+	struct mlx5_flow_table *acl;
+	struct mlx5_flow_group *g;
+	u32 *flow_group_in;
+	int err = 0;
+
+	if (vport->egress.acl)
+		return 0;
+
+	xa_init_flags(&vport->egress.offloads.bounce_rules, XA_FLAGS_ALLOC);
+	ns = mlx5_get_flow_vport_namespace(esw->dev,
+					   MLX5_FLOW_NAMESPACE_ESW_EGRESS,
+					   vport->index);
+	if (!ns)
+		return -EINVAL;
+
+	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
+	if (!flow_group_in)
+		return -ENOMEM;
+
+	if (vport->vport || mlx5_core_is_ecpf(esw->dev))
+		ft_attr.flags = MLX5_FLOW_TABLE_OTHER_VPORT;
+
+	acl = mlx5_create_vport_flow_table(ns, &ft_attr, vport->vport);
+	if (IS_ERR(acl)) {
+		err = PTR_ERR(acl);
+		goto out;
+	}
+
+	g = mlx5_create_flow_group(acl, flow_group_in);
+	if (IS_ERR(g)) {
+		err = PTR_ERR(g);
+		goto err_table;
+	}
+
+	vport->egress.acl = acl;
+	vport->egress.offloads.bounce_grp = g;
+	vport->egress.type = VPORT_EGRESS_ACL_TYPE_SHARED_FDB;
+	err = 0;
+
+err_table:
+	if (err && !IS_ERR_OR_NULL(acl)) {
+		mlx5_destroy_flow_table(acl);
+		vport->egress.acl = NULL;
+	}
+out:
+	kvfree(flow_group_in);
+	return err;
+}
+
+static void esw_slave_egress_destroy_resources(struct mlx5_vport *vport)
+{
+	if (!IS_ERR_OR_NULL(vport->egress.offloads.bounce_grp)) {
+		mlx5_destroy_flow_group(vport->egress.offloads.bounce_grp);
+		vport->egress.offloads.bounce_grp = NULL;
+	}
+	if (!IS_ERR_OR_NULL(vport->egress.acl)) {
+		esw_acl_egress_ofld_cleanup(vport);
+		xa_destroy(&vport->egress.offloads.bounce_rules);
+	}
+}
+
+static int esw_set_slave_egress_rule(struct mlx5_core_dev *master,
+				     struct mlx5_core_dev *slave)
+{
+	struct mlx5_eswitch *slave_esw = slave->priv.eswitch;
+	u16 master_vhca = MLX5_CAP_GEN(master, vhca_id);
+	struct mlx5_flow_destination dest = {};
+	struct mlx5_flow_handle *bounce_rule;
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_vport *slave_vport;
+	int err;
+
+	slave_vport = mlx5_eswitch_get_vport(slave_esw,
+					     slave_esw->manager_vport);
+	if (IS_ERR(slave_vport))
+		return PTR_ERR(slave_vport);
+
+	err = esw_slave_egress_create_resources(slave_esw, slave_vport);
+	if (err)
+		return err;
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_VPORT;
+	dest.vport.num = master->priv.eswitch->manager_vport;
+	dest.vport.vhca_id = master_vhca;
+	dest.vport.flags = MLX5_FLOW_DEST_VPORT_VHCA_ID;
+
+	bounce_rule = mlx5_add_flow_rules(slave_vport->egress.acl, NULL,
+					  &flow_act, &dest, 1);
+	if (IS_ERR(bounce_rule)) {
+		err = PTR_ERR(bounce_rule);
+		goto err_rule;
+	}
+	err = xa_insert(&slave_vport->egress.offloads.bounce_rules,
+			master_vhca, bounce_rule, GFP_KERNEL);
+	if (err)
+		goto err_insert;
+
+	return 0;
+err_insert:
+	mlx5_del_flow_rules(bounce_rule);
+err_rule:
+	esw_slave_egress_destroy_resources(slave_vport);
+	return err;
+}
+
+static void esw_unset_slave_egress_rule(struct mlx5_core_dev *master,
+					struct mlx5_core_dev *slave)
+{
+	struct mlx5_eswitch *slave_esw = slave->priv.eswitch;
+	u16 master_vhca = MLX5_CAP_GEN(master, vhca_id);
+	struct mlx5_vport *slave_vport;
+
+	slave_vport = mlx5_eswitch_get_vport(slave_esw,
+					     slave_esw->manager_vport);
+	if (IS_ERR(slave_vport))
+		return;
+
+	esw_acl_egress_ofld_bounce_rule_destroy(slave_vport, master_vhca);
+	esw_slave_egress_destroy_resources(slave_vport);
+}
+
 static int esw_master_egress_create_resources(struct mlx5_eswitch *esw,
 					      struct mlx5_flow_namespace *egress_ns,
 					      struct mlx5_vport *vport, size_t count)
@@ -3208,6 +3338,18 @@ void mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 	esw_unset_master_egress_rule(master_esw->dev, slave_esw->dev);
 }
 
+int mlx5_eswitch_offloads_vport_lag_add_one(struct mlx5_eswitch *master_esw,
+					    struct mlx5_eswitch *slave_esw)
+{
+	return esw_set_slave_egress_rule(master_esw->dev, slave_esw->dev);
+}
+
+void mlx5_eswitch_offloads_vport_lag_del_one(struct mlx5_eswitch *master_esw,
+					     struct mlx5_eswitch *slave_esw)
+{
+	esw_unset_slave_egress_rule(master_esw->dev, slave_esw->dev);
+}
+
 #define ESW_OFFLOADS_DEVCOM_PAIR	(0)
 #define ESW_OFFLOADS_DEVCOM_UNPAIR	(1)
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 84eff995cad1..06e1a61d1f58 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -139,9 +139,44 @@ static int mlx5_cmd_modify_lag(struct mlx5_core_dev *dev, struct mlx5_lag *ldev,
 	return mlx5_cmd_exec_in(dev, modify_lag, in);
 }
 
+static u32 mlx5_lag_dev_group_id(struct mlx5_core_dev *dev)
+{
+	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
+	struct lag_func *pf;
+	int i;
+
+	if (!ldev)
+		return 0;
+
+	mlx5_lag_for_each(i, 0, ldev, MLX5_LAG_FILTER_ALL) {
+		pf = mlx5_lag_pf(ldev, i);
+		if (pf->dev == dev)
+			return pf->sd_fdb_active ? pf->group_id : 0;
+	}
+	return 0;
+}
+
+static int mlx5_lag_is_sw_lag(struct mlx5_core_dev *dev)
+{
+	return mlx5_lag_is_sd(dev);
+}
+
 int mlx5_cmd_create_vport_lag(struct mlx5_core_dev *dev)
 {
 	u32 in[MLX5_ST_SZ_DW(create_vport_lag_in)] = {};
+	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
+	int ret;
+
+	if (mlx5_lag_is_sw_lag(dev)) {
+		if (!ldev)
+			return -ENODEV;
+
+		mutex_lock(&ldev->lock);
+		ret = mlx5_lag_create_vport_lag(mlx5_lag_dev(dev),
+						mlx5_lag_dev_group_id(dev));
+		mutex_unlock(&ldev->lock);
+		return ret;
+	}
 
 	MLX5_SET(create_vport_lag_in, in, opcode, MLX5_CMD_OP_CREATE_VPORT_LAG);
 
@@ -152,6 +187,18 @@ EXPORT_SYMBOL(mlx5_cmd_create_vport_lag);
 int mlx5_cmd_destroy_vport_lag(struct mlx5_core_dev *dev)
 {
 	u32 in[MLX5_ST_SZ_DW(destroy_vport_lag_in)] = {};
+	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
+
+	if (mlx5_lag_is_sw_lag(dev)) {
+		if (!ldev)
+			return 0;
+
+		mutex_lock(&ldev->lock);
+		mlx5_lag_destroy_vport_lag(mlx5_lag_dev(dev),
+					   mlx5_lag_dev_group_id(dev));
+		mutex_unlock(&ldev->lock);
+		return 0;
+	}
 
 	MLX5_SET(destroy_vport_lag_in, in, opcode, MLX5_CMD_OP_DESTROY_VPORT_LAG);
 
@@ -1663,7 +1710,7 @@ int mlx5_lag_demux_init(struct mlx5_core_dev *dev,
 
 	xa_init(&pf->lag_demux_rules);
 
-	if (mlx5_get_sd(dev))
+	if (mlx5_lag_is_sw_lag(dev))
 		return mlx5_lag_demux_ft_fg_init(dev, ft_attr, pf);
 
 	return mlx5_lag_demux_fw_init(dev, ft_attr, pf);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index d645c2cfca4d..57e6f82713b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -175,6 +175,8 @@ int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
 			       enum mlx5_lag_mode mode,
 			       u32 group_id);
 void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev, u32 group_id);
+int mlx5_lag_create_vport_lag(struct mlx5_lag *ldev, u32 group_id);
+int mlx5_lag_destroy_vport_lag(struct mlx5_lag *ldev, u32 group_id);
 int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev);
 void mlx5_lag_destroy_single_fdb(struct mlx5_lag *ldev);
 bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev);
@@ -191,6 +193,18 @@ static inline int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
 static inline void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev,
 					       u32 group_id) {}
 
+static inline int mlx5_lag_create_vport_lag(struct mlx5_lag *ldev,
+					    u32 group_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int mlx5_lag_destroy_vport_lag(struct mlx5_lag *ldev,
+					     u32 group_id)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int mlx5_lag_create_single_fdb(struct mlx5_lag *ldev)
 {
 	return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
index 1371e14c4c13..8d4f2903a101 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/shared_fdb.c
@@ -89,6 +89,76 @@ static int mlx5_lag_create_single_fdb_filter(struct mlx5_lag *ldev, u32 filter)
 	return err;
 }
 
+int mlx5_lag_create_vport_lag(struct mlx5_lag *ldev, u32 group_id)
+{
+	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_ALL;
+	int master_idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1,
+							     filter);
+	struct mlx5_eswitch *master_esw;
+	struct mlx5_core_dev *dev0;
+	int i, j;
+	int err;
+
+	if (master_idx < 0)
+		return -EINVAL;
+
+	dev0 = mlx5_lag_pf(ldev, master_idx)->dev;
+	master_esw = dev0->priv.eswitch;
+
+	mlx5_lag_for_each(i, 0, ldev, filter) {
+		struct mlx5_eswitch *slave_esw;
+
+		if (i == master_idx)
+			continue;
+
+		slave_esw = mlx5_lag_pf(ldev, i)->dev->priv.eswitch;
+		err = mlx5_eswitch_offloads_vport_lag_add_one(master_esw,
+							      slave_esw);
+		if (err)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	mlx5_lag_for_each_reverse(j, i - 1, 0, ldev, filter) {
+		struct mlx5_eswitch *slave_esw;
+
+		if (j == master_idx)
+			continue;
+		slave_esw = mlx5_lag_pf(ldev, j)->dev->priv.eswitch;
+		mlx5_eswitch_offloads_vport_lag_del_one(master_esw, slave_esw);
+	}
+	return err;
+}
+
+int mlx5_lag_destroy_vport_lag(struct mlx5_lag *ldev, u32 group_id)
+{
+	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_ALL;
+	int master_idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1,
+							     filter);
+	struct mlx5_eswitch *master_esw;
+	struct mlx5_core_dev *dev0;
+	int i;
+
+	if (master_idx < 0)
+		return 0;
+
+	dev0 = mlx5_lag_pf(ldev, master_idx)->dev;
+	master_esw = dev0->priv.eswitch;
+
+	mlx5_lag_for_each(i, 0, ldev, filter) {
+		struct mlx5_core_dev *dev;
+
+		if (i == master_idx)
+			continue;
+		dev = mlx5_lag_pf(ldev, i)->dev;
+		mlx5_eswitch_offloads_vport_lag_del_one(master_esw,
+							dev->priv.eswitch);
+	}
+	return 0;
+}
+
 static void mlx5_lag_destroy_single_fdb_filter(struct mlx5_lag *ldev,
 					       u32 filter)
 {
@@ -141,7 +211,7 @@ int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
 			       enum mlx5_lag_mode mode,
 			       u32 group_id)
 {
-	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_PORTS;
+	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_ALL;
 	int idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1,
 						       filter);
 	struct mlx5_core_dev *dev0;
@@ -209,7 +279,7 @@ int mlx5_lag_shared_fdb_create(struct mlx5_lag *ldev,
 
 void mlx5_lag_shared_fdb_destroy(struct mlx5_lag *ldev, u32 group_id)
 {
-	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_PORTS;
+	u32 filter = group_id ? group_id : MLX5_LAG_FILTER_ALL;
 	struct lag_func *pf;
 	int err;
 	int i;
-- 
2.44.0


