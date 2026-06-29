Return-Path: <linux-rdma+bounces-22562-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1hM4Cvu3QmqIAAoAu9opvQ
	(envelope-from <linux-rdma+bounces-22562-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 20:22:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AE46DDFE3
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 20:22:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=gvWI7iUd;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22562-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22562-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B3AB3046CF4
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 18:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24AF3839BB;
	Mon, 29 Jun 2026 18:21:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D08238425B;
	Mon, 29 Jun 2026 18:21:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757317; cv=fail; b=GwsK+t5Z7CCIo5DAn64JMmtWOxrknzyCTU4cVz1nCYvR5zHH3C/bG0wqFgwncrwZQZLcDayTg8t8uLRSHIhxtDsjMHs6pnltmrNb7EgVcMBTXPwYa04SJZQgrQSmzfvJ+LJU11xpLo2MiuS8j2eBtNulqaNEmAAuiYZ1V9s4JIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757317; c=relaxed/simple;
	bh=77WoDUoROSs5e2Qr4EFdIxekUNcoveLfVWLXOQGuBi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usP7gVx/nrrnTf6FUMDNZFdh7ccFE0NaPlEWw4u1xJVl8jDdpEXrid8w/nRYWlbeuW1tqjYnZB/t5zWnCs77zTPIwHufyLO4bMdzK+Nq5vwT4fcI8P+MwwRbBha7nHZvhM0XL+/DEKi3VSgmLg7rDzFkLBipY2RLT8W2NT9wWV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gvWI7iUd; arc=fail smtp.client-ip=40.93.195.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLUUXDkVsJY3zAXBDDf7IGec5w9GZo2WVeIcjOyWcPmCurVIANGttL0MjTFo+ZQ3/tWjJFXKCHpztEY3jhzTVZM3+rKwNUkxsvVtdgYHoxDOQuNCjn6WggsNgcXTvQ8wRT/FRzR0jpvsluquwiMGUyXQSl5JkcIv83g4Ydkgv4a5WxN/d8axumPoig1wqrV34iV/ME2vFDhySTq7tqw3JBvKUGJl6kkHTnNMd/gXR9YRwnxEFWNF8a9rtx7MQIsfb4zyCHXYbPn7t8QUnSQzm5F9hwmzjyF09DmFaCGj0DJ1a3TQyWv+Wgzoa6T5uOc9PDgR2QQvqa7XSndHeLyNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wioz307rS22NzIh9M8QZMsjvlm3txdgFNxZaQrDJovM=;
 b=rIU7/ITrsYm0GPZMUalyAy5FHIw2oByBF+IWMcEKi6xCJ1dVRI5nNzpRMKCRwS6/UH8Lvx8Jz0JrLhecq0+aHtxCAbml6pmtJikfgYXY0n1eIeGt4P+QOcLD8Q3zErntmnmB9MIh4hcR4CMlYv8XpxPrwcMWHTX4XGzmqLnZCp+SIAJEEMzv4HbPVoUyQPdQnilMZ4/fuuFRu3PvttdzXF+veDH9N8eEnld/3eiG5M2C1rStk+OKUQqfbTyDOztYPPRoWA7iMI7IU92qtrJ1llL7rW9nNT2IFOjI5kl7s7zAcrn05AmHrpAZT7AS/t1NLRZV1moTta8cnFL4+6iHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wioz307rS22NzIh9M8QZMsjvlm3txdgFNxZaQrDJovM=;
 b=gvWI7iUdYy34yhCd4Lo2eX8sk7TtAeSam7DKvjWt0OTfkAwCfybtPJl2oW1868xD3Wd9iU3rbRDGFrE9K5S8RbtZQNOS8Jf+3djuKmkyshOpxTBgH2Dlol4rcMDPzmAinSOYzmvn91aP6WfLP4sxW2GFx4Z3FNwV6o8QIVVXTNy0xuVqlg2ZcvxBRpoTpADUOYUX6A6pkDtnIg7y96GShsRY//R48slKGuD3Ckjfubf5+XSkmu+4jhqp7cq3/YLqKlnRww/vS1Lpwb16eyo8mqCXGg02XkFXUYYQ5MQ08Q3CFE54oahOXB3LfcCFCR7eSmQhYjsteupYpOrkAT9vyg==
Received: from CH0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::9) by
 SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Mon, 29 Jun 2026 18:21:48 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::33) by CH0P220CA0013.outlook.office365.com
 (2603:10b6:610:ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 18:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 18:21:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 11:21:16 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 11:21:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 29
 Jun 2026 11:21:12 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V4 2/6] devlink: Factor out eswitch mode setting
Date: Mon, 29 Jun 2026 21:20:57 +0300
Message-ID: <20260629182102.245150-3-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a1b646-332d-412b-b203-08ded60b485d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	KO9NUEmXfj12jtHef3Mavxf6xOfawd9Uis31kBD4EOBogVSioH+rwE/ImG9TxvOwinux0dd9Xrt0ca1wZoIsGxZRbB/p0ZmyrI/logtDnuSDespPJdeM4wsWQbSQhIX+r8IbBIj0FPdFH3uyi05She86fT5VO1qspAbHmfyPBBBSP9wjKZCHYnjolykrxJKyOY1sDpmo7G4apHGBGY0ycO/peMLyN5nuqkKWU/Sm9nXYGg5eu6ALiqReF9fLurMwQJohn+9y8bnJX3BxumCvRriuMVO1u/mtIrItL/zVSzRxKv2c4tHGD9p07S9D7oaFF7Ly9taTzRJ0x/TX1AY7HtqkT16YMA4OlQ2oDdX1CTjVRuwvcrb3cAezHIlr0yrVo91C3kh2n+KpWh+e40+Cj4LzYJ3jwKcZoOCWvunc3UIyXL9DqwhHsaoUQ8i6vopsMKb73eHi2L+8SaJfBidDhX8OCTLhnt49Ql9QYRJH9IQ9NeaYLh1wohd0RGLuIHLW91HayAqDzKk2/zs4mR7kTCv1tdsdWJy0Xxta8chDskX72a1H3CWhrB8og5MHzMPMynNwnTnR4agxU5Ov1n5+O02f4ZGorZ4bUH3Cxy63Lmc6HgTcrU28+1oJbO1PPkJv0qj7+fjts79cKZkOAK6E0BCDgfykZLZQ5CFsBQMMkvfJk+7EbXjJQ0GnlgsThjhT
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eSChoOfGilXtszW+peYJRRQOH/3spsAmlCvosUjqAV6m2AFug62P3BZ2Ec9vhGe1JIZS5t2Qo2F0WAAooUYKhO+YLNdxB3y9ax381ZgmDTdCmO0Om9eF77woVUFuD4lLtKOQ+oLQONMjmfCFTgu5FEJaVE8DbCzlzzRuPahmNH/UhL6+HIPgSsiHwHF5vZApksVuKJk4AIUtiZMjTR1Evgy4VviQpX6VORJm4dwhS3uREyXZ1jsr05HUfjBir213ICrMFzT3jE5g5PRkCc36X1hiXZei9Qu64cfqU6v2qjiSH/oyyqC8I8cUSlF5NUYHLAuHNpnd5u0JT0iuqFaV1ahyijBYCxn3Noraq9y7LsuXqNx8jq801+mgk0TVpQ1k7b6igmaw+P8HIPp3Y8/B+mOyPzwVRhMGbIf+mU02rnLnt7slvGG5ig0s5zpM4Ds3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 18:21:47.8623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a1b646-332d-412b-b203-08ded60b485d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22562-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4AE46DDFE3

Move the common eswitch mode set checks into a small helper and use it
from the netlink eswitch set command. Making the same validation
available to the devlink core path that applies eswitch mode defaults.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 net/devlink/dev.c           | 27 ++++++++++++++++++++-------
 net/devlink/devl_internal.h |  3 +++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 57b2b8f03543..4fb02bb993c1 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -702,6 +702,25 @@ int devlink_nl_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
+int devlink_eswitch_mode_set(struct devlink *devlink,
+			     enum devlink_eswitch_mode mode,
+			     struct netlink_ext_ack *extack)
+{
+	const struct devlink_ops *ops = devlink->ops;
+	int err;
+
+	devl_assert_locked(devlink);
+
+	if (!ops->eswitch_mode_set)
+		return -EOPNOTSUPP;
+
+	err = devlink_rates_check(devlink, devlink_rate_is_node, extack);
+	if (err)
+		return err;
+
+	return ops->eswitch_mode_set(devlink, mode, extack);
+}
+
 int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
@@ -712,14 +731,8 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 	u16 mode;
 
 	if (info->attrs[DEVLINK_ATTR_ESWITCH_MODE]) {
-		if (!ops->eswitch_mode_set)
-			return -EOPNOTSUPP;
-		err = devlink_rates_check(devlink, devlink_rate_is_node,
-					  info->extack);
-		if (err)
-			return err;
 		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
-		err = ops->eswitch_mode_set(devlink, mode, info->extack);
+		err = devlink_eswitch_mode_set(devlink, mode, info->extack);
 		if (err)
 			return err;
 	}
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index e4e48ee2da5a..97be77d3ed42 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -328,6 +328,9 @@ bool devlink_rate_is_node(const struct devlink_rate *devlink_rate);
 int devlink_rates_check(struct devlink *devlink,
 			bool (*rate_filter)(const struct devlink_rate *),
 			struct netlink_ext_ack *extack);
+int devlink_eswitch_mode_set(struct devlink *devlink,
+			     enum devlink_eswitch_mode mode,
+			     struct netlink_ext_ack *extack);
 
 /* Linecards */
 unsigned int devlink_linecard_index(struct devlink_linecard *linecard);
-- 
2.43.0


