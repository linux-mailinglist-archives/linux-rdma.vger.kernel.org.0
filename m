Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A857CF25E
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 10:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjJSIWN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 04:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbjJSIWM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 04:22:12 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90249131;
        Thu, 19 Oct 2023 01:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcaM/wtFYCWzllwnr9Ep8U+Fl0C8bzQAzhKvRzyA4Dx2SAmq2/P2pd9caVnE2Hu+0VoKBRNmp1TH1mXagsy83h27lS0tbaA2gxAhvhmKCMVhmzJ0Ns1MTHHD0Z5kY0nRBgHDep8sJaQFxZGIsPCPRoejsDWW8vjjMnHcsbR373n0ekbLNLUCT8fHVpuy/n7i1snlohCSX2V4mM9Ul+evfTQbznkdyT7k7jUlqSv5YMtPm5kii9ezgTSe6fF+GmeteT7kurLrMMCr2rSWuMzEEvEX9Cg83GcpxuIXH42yQo57a+/UNIkdzBCSrCGy4P4n4PajOgAQF4cY2kqMYSWISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0JcVWYDTrC9zmi4M16KqWb1pcwH1V5/vKkmYydsReA=;
 b=muCrPZS96+hC+qxTdVL2KkPrKuxgGxbgsUVJJbqZgb65hNVc+U6EiBHUD7F/AfOMA5MmDhvynkiC28sFKRlgGLVp8MOb6mjus/4SV0vIexBWkO2xcUec4vQVXp+ftjg2sTx6Ezek71hhSODMZIoHi27EKp17hiyBt2Qam7n0EAHgR//Xr3fHy9R8GsQ+BPtVPVlw1L5sYFZdgNSTOElZfP01cOoz6nrlx8Uld24PcwE/NwD1Y2Q6E6V8Srkh1+HqG3Q8rlHrMzb8sVnZMHsRHTTPuPVDLbi7vrQU26I0ouko7PEtvLAxFe9UxQ/ohaV8SbrZcn1T6PJfB84LoG3ZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0JcVWYDTrC9zmi4M16KqWb1pcwH1V5/vKkmYydsReA=;
 b=PkRmtmwVCyowDiZdFL483LpAqNGK8I03oshylN0Mvv/veMjVFmEz8MNUAqoKzj7oYBcjZScxG2rU4A/YzeXE0jvg7Z2qyAROU/TL0AGqKJPddpv8LSYYod8EOdjwBWZWl6tvlfw/8mrgZ+8IPiKoSAaZ2QJtvWkxYRg2Lo+5xdn2779L3PVKjr1IUhTlwpb5/RE48vRhugBqBYXk4k7uQsLrgfdgqFBNVR0CNl9YIoWuIfyefhZUlL4PHB08EVoyXjfkjtHU9fSWmMCH2YICjo0STdXAEWm0DEP+jiGdx8qDWl8NOtNkBu0Gqixp6NoKv8/+pGygzsa/bJnh1PgKkA==
Received: from SN4PR0501CA0129.namprd05.prod.outlook.com
 (2603:10b6:803:42::46) by BL3PR12MB6523.namprd12.prod.outlook.com
 (2603:10b6:208:3bf::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Thu, 19 Oct
 2023 08:22:07 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:803:42:cafe::27) by SN4PR0501CA0129.outlook.office365.com
 (2603:10b6:803:42::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7 via Frontend
 Transport; Thu, 19 Oct 2023 08:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 08:22:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 01:21:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 01:21:55 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 19 Oct 2023 01:21:53 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [PATCH iproute2-next 2/3] rdma: Add an option to set privileged QKEY parameter
Date:   Thu, 19 Oct 2023 11:21:37 +0300
Message-ID: <20231019082138.18889-3-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231019082138.18889-1-phaddad@nvidia.com>
References: <20231019082138.18889-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 634f688e-3530-4186-91ad-08dbd07c7bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rRt2V0UsfOAaEer23IhETVXgyWMb9c5QPz3z3JAOYJwQ8IQHqCWzWnHiiISA6WI58ZIwxuoe1WJ8DjDHdknQm+u//x1W/9Q2UsByr9/YgbPsI3lb7AmFtHkZw9zEH8rBhOw3gycy0URet6ph/29UhfAtLv3NB007po7+mjDk6ss/JXtRmE+v+AaG0sJqnR/BOE1nZwiUGg+eYGGRLhy39vSQD+KauAO/inqfeqBzTRr6Q6rYLB/pEx/U/NK6fB0KLkU9AZbQssZ+BD932aslH8vN/MA/EqDps7FdAhy+7vWkWOuvSYSHaG1obEYpTIHk8mPTWabJmavwYskLkNpPtR8kOmEokzEdLaRZ3sno5195ngOi3/8Ht1aJLR5ouVu4gMH3AgmKKivlg0ox9j9J/Hheh73D7+aVe+AgokqCLldAhHB6q+rWKjqVB8T0Ez3ehwzu9xb+GGD0eViTPA+ynZua8FUpWVCHZYmq376Gtx1YyH67554TTfD6ArmyYaRgYt66W4UCsoZ4ULxKk6GNgwfAYmZs2CLJ9lETUyfK4Lj9RYIPQRmwXnWOsfU3xq+pdOQS82CJ9fgsa8bydmxeb+irZ3nfkSbM1m4HlA3OQzH6kUkfKiZTCgF05qP9202URolFNjfV3e1e67JAqcT8THNPfa1Zfce2ekeIzFeEujeJrGAd8K71rtSLlmyiX56dhKKLpjhX6La6uzVNZ4N2JLC05SrFRSDP8AoxxYxHOFYRpiLoB9IesxN1Vap8Vfa
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(86362001)(47076005)(40460700003)(26005)(70586007)(54906003)(82740400003)(316002)(36756003)(70206006)(110136005)(356005)(7636003)(83380400001)(2616005)(36860700001)(7696005)(8936002)(107886003)(336012)(1076003)(426003)(6666004)(5660300002)(41300700001)(8676002)(2906002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 08:22:07.3963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 634f688e-3530-4186-91ad-08dbd07c7bd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Enrich rdmatool with an option to enable or disable privileged QKEY.
When enabled, non-privileged users will be allowed to specify a
controlled QKEY.

By default this parameter is disabled in order to comply with IB spec.
According to the IB specification rel-1.6, section 3.5.3:
"QKEYs with the most significant bit set are considered controlled
QKEYs, and a HCA does not allow a consumer to arbitrarily specify a
controlled QKEY."

This allows old applications which existed before the kernel commit:
0cadb4db79e1 ("RDMA/uverbs: Restrict usage of privileged QKEYs")
they can use privileged QKEYs without being a privileged user to now
be able to work again without being privileged granted they turn on this
parameter.

rdma tool command examples and output.

$ rdma system show
netns shared privileged-qkey off copy-on-fork on

$ rdma system set privileged-qkey on

$ rdma system show
netns shared privileged-qkey on copy-on-fork on

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
---
 rdma/sys.c   | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 rdma/utils.c |  1 +
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/rdma/sys.c b/rdma/sys.c
index fd785b25..32ca3444 100644
--- a/rdma/sys.c
+++ b/rdma/sys.c
@@ -17,6 +17,11 @@ static const char *netns_modes_str[] = {
 	"shared",
 };
 
+static const char *privileged_qkey_str[] = {
+	"off",
+	"on",
+};
+
 static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 {
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX] = {};
@@ -40,6 +45,22 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 				   mode_str);
 	}
 
+	if (tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]) {
+		const char *pqkey_str;
+		uint8_t pqkey_mode;
+
+		pqkey_mode =
+			mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]);
+
+		if (pqkey_mode < ARRAY_SIZE(privileged_qkey_str))
+			pqkey_str = privileged_qkey_str[pqkey_mode];
+		else
+			pqkey_str = "unknown";
+
+		print_color_string(PRINT_ANY, COLOR_NONE, "privileged-qkey",
+				   "privileged-qkey %s ", pqkey_str);
+	}
+
 	if (tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
 		cof = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]);
 
@@ -67,8 +88,9 @@ static int sys_show_no_args(struct rd *rd)
 static int sys_show(struct rd *rd)
 {
 	const struct rd_cmd cmds[] = {
-		{ NULL,		sys_show_no_args},
-		{ "netns",	sys_show_no_args},
+		{ NULL,			sys_show_no_args},
+		{ "netns",		sys_show_no_args},
+		{ "privileged-qkey",	sys_show_no_args},
 		{ 0 }
 	};
 
@@ -86,6 +108,17 @@ static int sys_set_netns_cmd(struct rd *rd, bool enable)
 	return rd_sendrecv_msg(rd, seq);
 }
 
+static int sys_set_privileged_qkey_cmd(struct rd *rd, bool enable)
+{
+	uint32_t seq;
+
+	rd_prepare_msg(rd, RDMA_NLDEV_CMD_SYS_SET,
+		       &seq, (NLM_F_REQUEST | NLM_F_ACK));
+	mnl_attr_put_u8(rd->nlh, RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE, enable);
+
+	return rd_sendrecv_msg(rd, seq);
+}
+
 static bool sys_valid_netns_cmd(const char *cmd)
 {
 	int i;
@@ -97,6 +130,17 @@ static bool sys_valid_netns_cmd(const char *cmd)
 	return false;
 }
 
+static bool sys_valid_privileged_qkey_cmd(const char *cmd)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(privileged_qkey_str); i++) {
+		if (!strcmp(cmd, privileged_qkey_str[i]))
+			return true;
+	}
+	return false;
+}
+
 static int sys_set_netns_args(struct rd *rd)
 {
 	bool cmd;
@@ -111,10 +155,25 @@ static int sys_set_netns_args(struct rd *rd)
 	return sys_set_netns_cmd(rd, cmd);
 }
 
+static int sys_set_privileged_qkey_args(struct rd *rd)
+{
+	bool cmd;
+
+	if (rd_no_arg(rd) || !sys_valid_privileged_qkey_cmd(rd_argv(rd))) {
+		pr_err("valid options are: { on | off }\n");
+		return -EINVAL;
+	}
+
+	cmd = (strcmp(rd_argv(rd), "on") == 0) ? true : false;
+
+	return sys_set_privileged_qkey_cmd(rd, cmd);
+}
+
 static int sys_set_help(struct rd *rd)
 {
 	pr_out("Usage: %s system set [PARAM] value\n", rd->filename);
 	pr_out("            system set netns { shared | exclusive }\n");
+	pr_out("            system set privileged-qkey { on | off }\n");
 	return 0;
 }
 
@@ -124,6 +183,7 @@ static int sys_set(struct rd *rd)
 		{ NULL,			sys_set_help },
 		{ "help",		sys_set_help },
 		{ "netns",		sys_set_netns_args},
+		{ "privileged-qkey",	sys_set_privileged_qkey_args},
 		{ 0 }
 	};
 
diff --git a/rdma/utils.c b/rdma/utils.c
index 8a091c05..09985069 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -473,6 +473,7 @@ static const enum mnl_attr_data_type nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_STAT_AUTO_MODE_MASK] = MNL_TYPE_U32,
 	[RDMA_NLDEV_ATTR_DEV_DIM] = MNL_TYPE_U8,
 	[RDMA_NLDEV_ATTR_RES_RAW] = MNL_TYPE_BINARY,
+	[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE] = MNL_TYPE_U8,
 };
 
 static int rd_attr_check(const struct nlattr *attr, int *typep)
-- 
2.18.1

