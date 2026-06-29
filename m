Return-Path: <linux-rdma+bounces-22564-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D5zuNAa4QmqKAAoAu9opvQ
	(envelope-from <linux-rdma+bounces-22564-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 20:23:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 708C96DDFEA
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 20:23:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=kRdxBfXv;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22564-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22564-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3046300D76C
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 18:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6150384CFF;
	Mon, 29 Jun 2026 18:22:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010030.outbound.protection.outlook.com [52.101.193.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E0383334;
	Mon, 29 Jun 2026 18:22:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757330; cv=fail; b=qnKeKIVjqLbfBDmDJt7fqQI51mpYnH8HpS1zUEQUC2zUUTf8C+hEC0GkdAVUFxC2nNndwn+6Xxlau/AZr7sfwVRJiERvonP/IJ+qER8QhLSmyI2KQTOsVzUF89DuFuHF+nmWWrsGMGzKtkPAt0PIGi89NSTBySdwR7O/DnGMH+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757330; c=relaxed/simple;
	bh=fVyXj5zdqHH5oGlQp7bMStK+bAbqiyE3Siz5x7yEac0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHEcoQHbNhhQvQhXhusQJk7iWyiBfifsLMYCaGuAP5RlYDJdu27oF0UnfkBJ16jMkVNCuvKwQHX6q7mmHGucHoB34CmzO70MCrDXR1yZ/uIlOfwwmOp3bDKr3swKVBJOpT/MuJsw5i239wzArES742QXAuHiRQhFfR15xI60sfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kRdxBfXv; arc=fail smtp.client-ip=52.101.193.30
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfsKMA0dGiOFbL2EPqVSqtMS/sOfWNz2pJte31j6MWCWHA58OeHSo4Fmyi4g9gYeX7SJd8NFhKNTkI/5OWbvW1qv7sq4YgJDHB8OWKT9tRyiPs0KHf0WF6oS2YlH4H/8lNfT7WRT45Qtii4pKxMP3it8maD8N2SneM0J6KDmB3cv8OSCqcw8x+j9UqrFA/T2dUjoIC0vP4s9nKl8FP5Uw0pe0C0RO7SRm0fGsBZzxc6zXaPhq8Noautvnq8IzWugy1IF9LUJGzla5Bxb7zRNT9Ww6QmSRg5R04wGmH/5MJgj2GACcVM47TrAo+dXQsEu4Q1BkPtlmia0mteK2+6inw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0ssyvs/U1sTkp+FNP0wLHykEqzDAbYDYyk47uS+6O0=;
 b=QHX4scWjjwmJVZki+WEzDlkBPrHppV6QTk1zFMc5Z3SVmc7j9LtSeMAwnQRFHciV+xWbJYrfCpbAHbO0wzl/gt0OSI98nrB5gMB4NpVLAUB1Hw3wckB0vdHYPvSQLlIZ35zZlR7YrOCbnAXka2VKh1da/JlCv62/Xe0Ptz3aQeBPUxC2OKYluHFOxX1Ok0eipkOGW+DtCTahjCQMh6DP4STsmcxiCzuC01mSjNS5WFsr3NEa1tOHNcHCiRnbtmIS5FaI7eaUdvWBTsZ0LOSMItzJcgwQSZ9saejeu1pKkUjULQdyM2T6R+WsfBHEWFewobrtdQt5o2JObZ4AUI6e7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0ssyvs/U1sTkp+FNP0wLHykEqzDAbYDYyk47uS+6O0=;
 b=kRdxBfXvEo44zefKwek1tDdynR53xjHOivZ7RmMrd9rg3hohgz5Ev4bCkNE8G1jl+s8MebM3djuvDWu5yVVyRhvYmcHl21PqN6jZFMqOm+5PizXnn7LkLUqqF09ARzE2mPzPnQD8/qC9OnT9Dq+NIG4VTd+moJdpBv6x35j8WuRJNZ+T97Oj61OOfWVVX/rnJPitjA/aU1hDi7UfC05f+NW9twXwK3Bj6YDapxG89uBft4gcQuSncXOkwXbcSWfX/YtWfnjNsmFSB0KwDu/WiTUKJsukmyPRz7J47FjVXycIMq0V3VcR4MJqpG+NFrm0BT1QUDTNhoRd228ORtmZSg==
Received: from BY3PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:39a::14)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 18:21:57 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::aa) by BY3PR03CA0009.outlook.office365.com
 (2603:10b6:a03:39a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 18:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 18:21:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 11:21:29 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 11:21:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 29
 Jun 2026 11:21:25 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V4 5/6] devlink: Add API to apply eswitch mode boot default
Date: Mon, 29 Jun 2026 21:21:00 +0300
Message-ID: <20260629182102.245150-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629182102.245150-1-mbloch@nvidia.com>
References: <20260629182102.245150-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a78e6a-7759-4e0a-c44c-08ded60b4df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|82310400026|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	cIW3u/SIjmdfo6PoN3iTzPyXbO0XUBrWYsLI7xf0zeCXpYQ/FboyEkewmdyExQAiNartDkA204O1Ak2pFCMlT1VJnV5PEWdsZ6UBNasRge+B8hOuZjsGM7bZEXUvBAb+ln1d7bBSl9AEeEM6G6C2m/QARLZ2xXIU5+3rPOqfjHL/MD/UMAly5pB2BzyZpq1iGR8bqfbw9B+IGC37kjG4ZAx7+1c2neU5Jt+mTXl4NSlgXSze/DX1ra3z1qUBHRSkU4Yir0SJ/zquEAjzbCPjRPBwCAleTE0FkZcOISGUMA4FOKNyHrvf+dGb9vG+07JWu/tQvhWuuNkgM+R/sh8BZ+VVy++woe3sESm82jqLP36vn7PHCV6WZdFe20pG+KmePjrLHNwlLIg6if49K9Nf7e6WWhGC61NqsWoQPltutkfzWkGQcUq6baYq6M0xhnV4tVRslRj+prYJB6pPBayKSn8sbMmpCuLm1W1iQZ2mJtKgqK/cdptnmXnLiV33wU0cQVnWnBzt0r0xXeSJEoJxdISjwYQ7nAqdnVta9dJUfhM8zhQWAbvye33t4ui6DOD5rkkiZKtl3bZwWz9ETq/pTCwodsBrUtuJZrm7ocB5OH8lfv3ur9vZ2KbzJj7UBhalW82NNSMlMA66zosCaTaOkO9yyLRfJo5PPS18BXsgQH9kv6EU5MrqA4I1gbXb8L8fsQ5QVkdwp7gNScVlB8cqLQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(82310400026)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6M6KZieGpAiMUEAS7p+O4OGJ5MzYa89Fc9l284mgAtfZeIP4Sbk6BT7Ctf2sKyaJL8NVXVNvTvUrwVIuT1ZfbDgIhwTbQGK8DKCrsSDvGycPZRm0WFMGbDRyO3LEyeEXbd7NBOIXNzMxBnmMlnLxEKFOxWjs5d6u+LvgzBtekmSfUb62di6x7Vu4wLN73pDoFnGPi+M/4EGjqfz2hMSbApozcQAIGMWwwmf6rSoea8/T9noLF476k2/xOVk8xAnXqD+jMkptDtLeXL57f3fqfIF+eVs+/QTtPQ86/Hq/LE1AcWxlEhiBUResV6mjdK8gypiNgsv0bOY3D/BQeOvbKfo+HPOWZs0oyZVU6wP8CLiFlp0qPptiIg7fF3IuLZ3dU5l7Inraw+TJ58/7yBppJ+Ur9rDmunJYX4w1JYTYS9GSlQxia5c4EqeqsjDD/MVL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 18:21:57.3533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a78e6a-7759-4e0a-c44c-08ded60b4df1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22564-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:mbloch@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 708C96DDFEA

Add devl_apply_default_esw_mode() for drivers that can apply the
devlink_eswitch_mode= boot default once their device is ready instead of
waiting for the asynchronous registration work.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 include/net/devlink.h |  1 +
 net/devlink/core.c    | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index dd546dbd57cf..b71d282c6d52 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1652,6 +1652,7 @@ static inline struct devlink *devlink_alloc(const struct devlink_ops *ops,
 
 int devl_register(struct devlink *devlink);
 void devl_unregister(struct devlink *devlink);
+void devl_apply_default_esw_mode(struct devlink *devlink);
 void devlink_register(struct devlink *devlink);
 void devlink_unregister(struct devlink *devlink);
 void devlink_free(struct devlink *devlink);
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 998e4ffd5dce..d8f273e1732c 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -299,6 +299,28 @@ void devlink_default_esw_mode_apply_disable(struct devlink *devlink)
 	devlink->default_esw_mode_apply_pending = false;
 }
 
+/**
+ * devl_apply_default_esw_mode - Apply devlink eswitch mode boot default
+ * @devlink: devlink
+ *
+ * Apply a matching devlink_eswitch_mode= boot default immediately. Drivers may
+ * use this helper when the device is ready for an eswitch mode change and the
+ * caller already holds the devlink instance lock.
+ *
+ * Any pending asynchronous default apply is cleared before applying the
+ * default, so work queued by devl_register() will not apply it again.
+ *
+ * Context: Caller must hold the devlink instance lock.
+ */
+void devl_apply_default_esw_mode(struct devlink *devlink)
+{
+	devl_assert_locked(devlink);
+
+	devlink->default_esw_mode_apply_pending = false;
+	devlink_default_esw_mode_apply(devlink);
+}
+EXPORT_SYMBOL_GPL(devl_apply_default_esw_mode);
+
 static void devlink_default_esw_mode_apply_cancel(struct devlink *devlink)
 {
 	if (cancel_delayed_work_sync(&devlink->default_esw_mode_apply_dw))
-- 
2.43.0


