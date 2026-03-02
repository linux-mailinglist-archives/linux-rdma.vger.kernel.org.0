Return-Path: <linux-rdma+bounces-17390-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ABgOX+zpWlaEgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17390-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 16:57:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0861DC428
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 16:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BA393084C80
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1173141C0A4;
	Mon,  2 Mar 2026 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="epb4fpRv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F9E41C0CE;
	Mon,  2 Mar 2026 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466788; cv=fail; b=AfxIBmjhlJ5El9Xcj69yJ/5XSEyb8aatJB3e5eQl6JSS4oQObq5OyVuVO5iEh3Y/u4TtlCG15gd+se+EEfShWMfEd7AExG7BjSlFbnegbHaAfRIbaTXl+B8g6S+ArXSMzsNfSJMWLux7zrveql8GxmeNrHCxeB7LqM5+LgQcMD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466788; c=relaxed/simple;
	bh=3BmIu2GJMe1h6GnkW8r7xkp//+SUgR2hcXN9/WCJ5tU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLux0HbjGVvuc14PUbxOtwuNSVPcqnjZkhFTujv+aMFTzk05uG6/DkIe/7tXU2Exd6faQgCyrNVOLruowXlNDLEKk9bc+LDqqG/NwvZo1OhGnziKOodX6tudG8YyT6iqQSAHm6Ak3hrG8Zy4Wa9Gni00QYu5ckIsLOs3ElI2WWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=epb4fpRv; arc=fail smtp.client-ip=40.93.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uib7b16So16ez4/OmYlzDu959rRp872ipYmzEhlO+gLlmAogfsl5ol8HBDn+BWWDYCo0tm51uviH3dyy/47S0p6KBZMvQnrJnbdT49QocrpkWv/b+aOk11agO7336FVz4OhOD5fQ4FUuL/y9x1Pcu5uQ0caJ3F2CD4jdgAPtup8mXALsDH/ph4X9igSWljX9uFkHgYyCFG7W5GP6WsAv9Yi3ERxcptToRez7tXIObwtudiyjKYQxxAvhF6atd49LMIInF9YFV5AbsskE9ErXxX+lLnZ9LILqJ5szESKKwHOkuAAKU4AQ/D9PpR/ujH7Bb17YJruHHdWD6uuLW3bykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1Y/GWM2WDesOkzQV87LqrG7xfYgQXXr1IMYRdrZMbM=;
 b=VRVQdj/3kVo19WVhFRMqMYU6ovhM8VxK0onADGlIr856DZ1MjjYUFpvsVuMzdjfA+p2gZW9vwztI2LisqEnmiBo6R25log6R+YCboJH/CBYcWeDCaDy++8WozlcbsN60wGI8Hw4vZDRP0LQPg4e+xMQV09TwAKOYiJwofZ/fe/hQ7mD/gq8dOa+lP1quZq8iAq9Xt5l25ZJdSdx9p4E2awbpZNbY93pJ3vAJEnLGLb6sUBRSbSfBEfmg50Uxq4IUY3/4PNPaNaY3Wz+eBZGZ/jJHZWlIaRB9FbIaPPciSvpBhh+gKOAd09Y6SjUxBiBCV/CYwUpH7fgao/hUFw0Zyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1Y/GWM2WDesOkzQV87LqrG7xfYgQXXr1IMYRdrZMbM=;
 b=epb4fpRvOKoxevoeR0ZoFTy7DtJhsBkPXgXyLHG3gyQRJ+dNMiMp5a+FOvRX1j0gAPNPByTSPW5zyL+B9Qoi5WqOss3VwnFmqKfSkpBkyVuIGMdfuqEboNMLRDb9h+5DXuqlk9BySwHTlouoKxPE6P9EHCVxfqc1N+VktIVw7rOGcu2i4plZo/9fq7jMclL/lSd/kB3fNO7wfRI77YQ1WZrFXoTx5g6rFK5khJtvZ0buRH4SyThsl+dUhWBdsgOWYug+ejmTdtDXQUhMdTIkeeCHznIOXpkYsvsCvyFIzujsSG2BC+3WLZ/3lC83nCp1pbetp38DRg7QDmG1+NtbHA==
Received: from SA1P222CA0188.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::16)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Mon, 2 Mar
 2026 15:53:02 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::93) by SA1P222CA0188.outlook.office365.com
 (2603:10b6:806:3c4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 15:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 15:53:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 07:52:43 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 07:52:43 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 2 Mar
 2026 07:52:40 -0800
From: Chiara Meiohas <cmeiohas@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: <michaelgur@nvidia.com>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH iproute2-next 3/4] rdma: Add FRMR pools set aging command
Date: Mon, 2 Mar 2026 17:51:59 +0200
Message-ID: <20260302155200.2611098-4-cmeiohas@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260302155200.2611098-1-cmeiohas@nvidia.com>
References: <20260302155200.2611098-1-cmeiohas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba425c5-b2b9-49d9-d87e-08de7873c8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	PAz9uCJZ+NqabRmbdh/HxIKspdKrAy9MRL0cPMp60bd3/+0m68dMGF8o+rhq84SWTXGJPmeNry5ah/WnK0O1wnYp/LJc+PfpaVlvhm0Ll/1BUuOa1vQe7zsWt0QV9cGS2FUJr5/Tw0X3fJo1C3KGvaBBQJcqduhihTJQM0sfhOIQYExBGQ5FFN2biZccCqagIeQDc1TLyWYzdDsGi9JHLBV9tzjAAGttIQSQkZZknge//rNe9AdZKLosoBU/7ZhQyLLlVvx8IYuK3dYW7oY7oAPp0Mjr8XtoqgmIofxdeKpzQjV6tBYSrgoOaRVrQ0LkzEqq8SoRVNulZ/T766C5ZYr16yGaobItPxIaghVJVegEcuRuQLX5ylTMIAFsPfH4mhF6fG2JUQlgkECrhB3uRf+kR7xBOnbwXNg7Q6PQNjY7sQkno2AX1XcTfWX3bXj5zmdvlrTKADt2QMFC4syAhWLEQALgVe5Zank7gp9nAseRVe3NO3FVA/UJxPjAiu3xQ2RdOt5Dmgg86o99+0imts47TdrtXTaYplr8zc59UMyT81RvdHFbdD3hnEtjOWCkJfHx5TrOmyVcmuVsp9QUkjC3HWdK2Wo368uybJcETju54ZZ2zOeI9ExFhtnuAzMCSWUPQqD742vNYcFs9+Rd9RvowEyd849n/CdeqKp1aTfak9C1DUeqacONRud1m9AmVhFyrO/r0TB18XmnmypIEm3VscwAnvz3cSj9yLSin0SCtM1SiVutoVOboLPgEgJn/I+3MsG0BSU+YGBQO4dIc8/Xkqys3Uik8IX8aVEwjKrVgkGh36PusTWIqUB6oynvLD0OBiPMEXKShT0E2/jUeQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zhT8ZVUe5jF8y6CHUCBfMEuMNi03iIv9GSgWAxxydl0a0DV2tB/Hgeb+k9n/nYtd/IYG+Tj1PNAnqVvw+/r5A+M2Mcv+VIhDWaceJzVy6LCe+uTu0FJuhVh5dnHsHxtZroK/iXbPiMxMYhVk2DNWezuAmNXgPmhq90Els86bWGBysIsYMwzc0ZBScSvVTwKJQSDZi30c6uap0f1li7nMNgeamyXsGi9P64iCET8OpRMGYhhQnawiPwFW4WugF/cyCbKnVn9IkgzIQZ8qZhBaZnOWsOmrJ6p54anO3rGyGsDESX6jf+M6oPlBI237RECmBi2cCv4GWY+uiaBM6mmI+X8kOpxsJmkygnG43+yGrd248fqS30GMA443f15IGdxZF7KOr6mT4Zx+BB14U9wG/8MSj5T7XOXdgRkY/3GcNKoKOGAMITkcWDfxMwn7WQFe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 15:53:01.6882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba425c5-b2b9-49d9-d87e-08de7873c8c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
X-Rspamd-Queue-Id: 8B0861DC428
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-17390-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,networkplumber.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmeiohas@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Allow users to modify the aging time of FRMR pools.

Usage:
$rdma resource set frmr_pools dev rocep8s0f0 aging 120

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
---
 man/man8/rdma-resource.8 | 22 +++++++++++++++
 rdma/res-frmr-pools.c    | 61 ++++++++++++++++++++++++++++++++++++++++
 rdma/res.c               | 13 +++++++++
 rdma/res.h               |  1 +
 4 files changed, 97 insertions(+)

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
index 97d59705..29efb9cd 100644
--- a/rdma/res-frmr-pools.c
+++ b/rdma/res-frmr-pools.c
@@ -188,3 +188,64 @@ int res_frmr_pools_parse_cb(const struct nlmsghdr *nlh, void *data)
 	}
 	return ret;
 }
+
+static int res_frmr_pools_one_set_aging(struct rd *rd)
+{
+	uint32_t aging_period;
+	uint32_t seq;
+	int ret;
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
+	ret = rd_sendrecv_msg(rd, seq);
+	return ret;
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


