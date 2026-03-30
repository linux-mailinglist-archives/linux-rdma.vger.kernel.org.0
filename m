Return-Path: <linux-rdma+bounces-18799-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGGgJv20ymmE/QUAu9opvQ
	(envelope-from <linux-rdma+bounces-18799-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:38:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3D835F598
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C424C3055C6C
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123563806C9;
	Mon, 30 Mar 2026 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uJth9efg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906091CDFCA;
	Mon, 30 Mar 2026 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892028; cv=fail; b=C4bxIQ1ztiVAl08EZ254HZjC/fzq5KdO3w9q0JnwI0hNR9+aj6Iuseu+ETuoMN0ZlRQhkaaPLcMjLky7wWuGy2wrjgolamu1UHMykNX4ZGQhLvd8kYesxzfdObGSZ9tNddl+XZjDKbJuDFhGOv489CmfpF9NTxv/ch+fkwSZqCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892028; c=relaxed/simple;
	bh=lSCpd+lORFR8CXCQfPBGKogC9fAUp/smg7HL27HbKLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWZLoB/eZYMc10jwk806j+7jN9t/Ghr+QOlLJwC43Uy3w8TFGBBSc57P5702v3s6aHMQD8QLmhXAycdZmuITrHJXUwOsH80XTuMCB3v12FXwciNp5QwyWY4B5TenK2IDApl2BuF9oXjz7PZ+IEVoKfo8fy9AAijx+E0vlW4IabU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uJth9efg; arc=fail smtp.client-ip=52.101.48.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKsRWGAzEJcY9vUnUzmnkWtfZSYcANguK/cM7zL0xxYgWFWoK+54Y+h3YTmXyXlTY0vUOPJ2m4tDuof319zqJlvfBMMlIts3TOiEuE5cEe/VmLmiMvUyCo40TL2Zu2FOcFQ7MW3sDXEz3+44d5+ECQObTs5677RMZjt4l98iZYOa0b0xr/SA1Hbq7cUm5tV5YfGTNVMfR2fQiDRgvblX6j3+HDlpSnYCIr/ri+N9RbkaFycj6dYAj/eYY3MxPNOv6QjjnQb6iytTAin+fcHZ6AqIzIn1mp1zN2rKZKZrr5HAR8JGFZp+c1R6/Fd+vp4I9edx+xsZLwGEdiydYO7kGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAi5XeJEsJysf3oP2bbGmxrHVrpcP6Mv/ERZD9mbHpI=;
 b=XMDzWes/laO6AAtbtBh+1fIFvXKWhzmC0PW9f1hhQTGhcrdJOvAUoAQB/ouqKH1XVQXWEB4Tb6dJvS8qiKuzbslsXurBDJ1vVKC0LlMbM4YFeb+BvXNjw5rX7AnsaXcMeJW4UKp/XiySUp/enYcrm0i1PquxsYLppsZl2kDCYv+dsUIJSDuJ+M9eRA0NKTPH/kE47kliemZKFciYzPk9mXzRyOSOTPqe4aApeq6qlFaOJlbcsuoCgA6x+JJJCQ2eIgrHmRejWAarHU4GeX0Tevu5SW5q7o7JTarcgWPkhyhg7BqsRcJiWdg4IgvyQieFTrb8EuJ/2u6NnWVD5LlfOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAi5XeJEsJysf3oP2bbGmxrHVrpcP6Mv/ERZD9mbHpI=;
 b=uJth9efggxoFduKZ3X6yUYzmIe3sSKHDGo2DRelBJgROV5IjnyvXly0tOCKNjjXQei2of/lfjcQDdMLxUJlPHd8uSs5wUHBURhBxJV69SqmtfgS8BveI9TjCh8ZYE/2o71HcgQoemUzuig7EUJU7YloEqY3BfxePKbGLrVLaEX2Q24mQkMuei5Mwept/UJR7k4Zp+rUEf/IkGLuPgdqygGFD8udRg4zHycfG3YXgSH7g0ZIAIqzVaeIjeltMFgf0i66Q63q9zvyAbWj4ovOgbKw4f0ubb4TAUHPGg2o4KlwlAHa1k9X5Lyn00J8auuvQ6m1uJ42iTF9LYG/X4cMZrA==
Received: from BL1PR13CA0088.namprd13.prod.outlook.com (2603:10b6:208:2b8::33)
 by SJ5PPFFA661D690.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Mon, 30 Mar
 2026 17:33:42 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::8c) by BL1PR13CA0088.outlook.office365.com
 (2603:10b6:208:2b8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 17:33:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 17:33:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 10:33:25 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 10:33:25 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 30
 Mar 2026 10:33:23 -0700
From: Chiara Meiohas <cmeiohas@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: <michaelgur@nvidia.com>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>
Subject: [PATCH v2 iproute2-next 3/4] rdma: Add FRMR pools set aging command
Date: Mon, 30 Mar 2026 20:31:17 +0300
Message-ID: <20260330173118.766885-4-cmeiohas@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260330173118.766885-1-cmeiohas@nvidia.com>
References: <20260330173118.766885-1-cmeiohas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SJ5PPFFA661D690:EE_
X-MS-Office365-Filtering-Correlation-Id: 2712fdb1-7443-47de-e643-08de8e827c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4dH3/NzK2wAIIqpbZnBC82zPaXA8QO4/eGBovWEg9/iDUFnQARz0cwWsKhPNMolH+imhhCwa4mwJ7v2W4v74Cqe6b5XbOlrl1N8Eerx24eixbsBR3zmWdIeNdhuUDvfDNoGah82Fl7rxsxs1s5PfQO1rI5tNG4qxmulw57lbdRgboJP3usjCbekCL9nHX2SgJTdWqg10Xm+DikgD05rCAbr5Gj/S8MKNovgKObpv61Zzj1/d23H46+jI41nxA84hYFNYKhSkPr9emMa3Rv26Vg3MMdWjXZqSRDGW+yYCsXSJuR/Nhy8XRIV2MWZ+VN5v0o9LIBDguGy31uNrsvIHcnS3h+dNY42sMVBZ1z/e3dhuFMd10OOMe9t7qfr2pN0u7F81lmYfgpB2I8g31owWdSZeYWABxgtsuNK/emq1H3dTgUqIJs3npafR3X9GiiWEs43HfZaWVhwcCMo220/Bv2wfO2zHMhFnFRWcDy/wk9cWGhTulRwFpREcbsW/AUcZyqonAdaKNV1O100pW1Pinokb3kzMISyYmpkr0mVPHujz9FbfUig9VySYgA9ZHy4aN8zyLAFeq++NS4TSt219cvFAh13dRUYqEWKRsoRqbrjOW1n3EsrJdp4mcvaB7fL1JJtfWB7Vq2eG2349SsblEJX3K0nf17diLd+9ylrCkJ74Eav/XnN48P4VkK0Xe5UffiEMjAQ01NuqbT7HlB6fn+97pd82gdi2Kl8vY5nBY7KMllxsZG9AATz0+Ld5krrCfVwbH+x+5zJ9AaUCHH84QA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ls98rt3rFgfJ2sUwXBBkLk35v0HXFDjtgcPclbsAVBJz4qL1efxeHmrRvw38z4uau3xgqA0iF9rEwxJZpW53VYqIeSvxfrVfK7/+IkejqHWgtO/aDxA+tdpQYw1vFNhyiQmYPQWnlx5hMWwL06DWRz1Vzy4DzOkjQMadvSBfWFwqoD6Wu+8ir/cLewz83YoI6p6hJcXzPWWRVTdZUxaX1b6IaK3z+4kgFdspGxcJ+dGnDFBm4gXeDBQFD2zU+XQuAiCJPh+1SVkLS5QHqMRgM44AbO+qlHAVBULtalRghwI+wC45Espmanb2zjLPBmbCpqWOqXQh//KHIBablhylXxbjGmKEkhd0jyikncdpr9HQEyenX74NlLapzOBQnjoxwgjiPssod5bX0aYLolbioS5HG0qdm0NqrV/JrqPzUPdD2GicB7dky6k262TNNO5Y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 17:33:41.6305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2712fdb1-7443-47de-e643-08de8e827c6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFFA661D690
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18799-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,networkplumber.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmeiohas@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3C3D835F598
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Guralnik <michaelgur@nvidia.com>

Add support for configuring the aging period of FRMR pools.
The aging mechanism frees unused FRMR handles that have not been
in use for the specified period.

Usage:
  rdma resource set frmr_pools dev DEV aging AGING_PERIOD

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Chiara Meiohas <cmeiohas@nvidia.com>
---
 man/man8/rdma-resource.8 | 22 +++++++++++++++
 rdma/res-frmr-pools.c    | 59 ++++++++++++++++++++++++++++++++++++++++
 rdma/res.c               | 13 +++++++++
 rdma/res.h               |  1 +
 4 files changed, 95 insertions(+)

diff --git a/man/man8/rdma-resource.8 b/man/man8/rdma-resource.8
index 4e2ba39a..a6dc33f3 100644
--- a/man/man8/rdma-resource.8
+++ b/man/man8/rdma-resource.8
@@ -26,6 +26,13 @@ rdma-resource \- rdma resource configuration
 .B rdma resource show
 .RI "[ " DEV/PORT_INDEX " ]"
 
+.ti -8
+.B rdma resource set frmr_pools
+.BR dev
+.IR DEV
+.BR aging
+.IR AGING_PERIOD
+
 .ti -8
 .B rdma resource help
 
@@ -37,6 +44,16 @@ rdma-resource \- rdma resource configuration
 - specifies the RDMA link to show.
 If this argument is omitted all links are listed.
 
+.SS rdma resource set - configure resource related parameters
+
+.PP
+.I "DEV"
+- specifies the RDMA device to configure.
+
+.PP
+.I "AGING_PERIOD"
+- specifies the aging period in seconds for unused FRMR handles. Handles unused for this period will be freed.
+
 .SH "EXAMPLES"
 .PP
 rdma resource show
@@ -119,6 +136,11 @@ rdma resource show frmr_pools ats 1
 Show FRMR pools that have ats attribute set.
 .RE
 .PP
+rdma resource set frmr_pools dev rocep8s0f0 aging 120
+.RS 4
+Set the aging period for FRMR pools on device rocep8s0f0 to 120 seconds.
+.RE
+.PP
 
 .SH SEE ALSO
 .BR rdma (8),
diff --git a/rdma/res-frmr-pools.c b/rdma/res-frmr-pools.c
index 7d99a728..c9d80c4b 100644
--- a/rdma/res-frmr-pools.c
+++ b/rdma/res-frmr-pools.c
@@ -172,3 +172,62 @@ int res_frmr_pools_parse_cb(const struct nlmsghdr *nlh, void *data)
 	}
 	return ret;
 }
+
+static int res_frmr_pools_one_set_aging(struct rd *rd)
+{
+	uint32_t aging_period;
+	uint32_t seq;
+
+	if (rd_no_arg(rd)) {
+		pr_err("Please provide aging period value.\n");
+		return -EINVAL;
+	}
+
+	if (get_u32(&aging_period, rd_argv(rd), 10)) {
+		pr_err("Invalid aging period value: %s\n", rd_argv(rd));
+		return -EINVAL;
+	}
+
+	if (aging_period == 0) {
+		pr_err("Setting the aging period to zero is not supported.\n");
+		return -EINVAL;
+	}
+
+	rd_prepare_msg(rd, RDMA_NLDEV_CMD_RES_FRMR_POOLS_SET, &seq,
+		       (NLM_F_REQUEST | NLM_F_ACK));
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_DEV_INDEX, rd->dev_idx);
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_RES_FRMR_POOL_AGING_PERIOD,
+			 aging_period);
+
+	return rd_sendrecv_msg(rd, seq);
+}
+
+static int res_frmr_pools_one_set_help(struct rd *rd)
+{
+	pr_out("Usage: %s set frmr_pools dev DEV aging AGING_PERIOD\n",
+	       rd->filename);
+	return 0;
+}
+
+static int res_frmr_pools_one_set(struct rd *rd)
+{
+	const struct rd_cmd cmds[] = {
+		{ NULL, res_frmr_pools_one_set_help },
+		{ "help", res_frmr_pools_one_set_help },
+		{ "aging", res_frmr_pools_one_set_aging },
+		{ 0 }
+	};
+
+	return rd_exec_cmd(rd, cmds, "resource set frmr_pools command");
+}
+
+int res_frmr_pools_set(struct rd *rd)
+{
+	int ret;
+
+	ret = rd_set_arg_to_devname(rd);
+	if (ret)
+		return ret;
+
+	return rd_exec_require_dev(rd, res_frmr_pools_one_set);
+}
diff --git a/rdma/res.c b/rdma/res.c
index f1f13d74..63d8386a 100644
--- a/rdma/res.c
+++ b/rdma/res.c
@@ -28,6 +28,7 @@ static int res_help(struct rd *rd)
 	pr_out("          resource show srq dev [DEV] [FILTER-NAME FILTER-VALUE]\n");
 	pr_out("          resource show frmr_pools dev [DEV]\n");
 	pr_out("          resource show frmr_pools dev [DEV] [FILTER-NAME FILTER-VALUE]\n");
+	pr_out("          resource set frmr_pools dev DEV aging AGING_PERIOD\n");
 	return 0;
 }
 
@@ -252,11 +253,23 @@ static int res_show(struct rd *rd)
 	return rd_exec_cmd(rd, cmds, "parameter");
 }
 
+static int res_set(struct rd *rd)
+{
+	const struct rd_cmd cmds[] = {
+		{ NULL,		res_help },
+		{ "frmr_pools",	res_frmr_pools_set },
+		{ 0 }
+	};
+
+	return rd_exec_cmd(rd, cmds, "resource set command");
+}
+
 int cmd_res(struct rd *rd)
 {
 	const struct rd_cmd cmds[] = {
 		{ NULL,		res_show },
 		{ "show",	res_show },
+		{ "set",	res_set },
 		{ "list",	res_show },
 		{ "help",	res_help },
 		{ 0 }
diff --git a/rdma/res.h b/rdma/res.h
index 30edb8f8..dffbdb52 100644
--- a/rdma/res.h
+++ b/rdma/res.h
@@ -203,6 +203,7 @@ struct filters frmr_pools_valid_filters[MAX_NUMBER_OF_FILTERS] = {
 RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
 	 frmr_pools_valid_filters, true, 0);
 
+int res_frmr_pools_set(struct rd *rd);
 void print_dev(uint32_t idx, const char *name);
 void print_link(uint32_t idx, const char *name, uint32_t port, struct nlattr **nla_line);
 void print_key(const char *name, uint64_t val, struct nlattr *nlattr);
-- 
2.38.1


