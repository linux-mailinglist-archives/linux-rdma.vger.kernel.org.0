Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C447C9F8B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Oct 2023 08:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjJPGbo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Oct 2023 02:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjJPGbn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Oct 2023 02:31:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D24CA2;
        Sun, 15 Oct 2023 23:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qo9dru0Aooz930yV1ZMRSTAW8ZrB02Yj65YqQaGicCA/2GFNRC98Mo2YqswU/YWXqliXh1ATUJwyv8j+t528S2nqL6RquTrksJuc9EgF5INxUq+BhjZyyQgsrlwfT2D7VHOhFBeOZ768C9FTDVF/hUplKCKaGhvuRvv2bIF022pbIcgnzUotTiTpz+R14yZX+p+qEKBbFQRggTWsh1rH5uBl9fuu/s8fW22MlDoNZVCMNe/EoLHisQK4ROuudWYAwXex+ZzO6TwlXLJAjn5K1t61njxWRIgyJC+JlacbYsKCXsIRnfDWZYd2TKUP2K1qEzdKfXcH37rZX1HfSH+3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0JcVWYDTrC9zmi4M16KqWb1pcwH1V5/vKkmYydsReA=;
 b=nZpDwugSSivtRWGsM4xXI9mTIsIrFl0+6ZKT/bNrtJr1dgGU4A6pHDK5OFcCR2iDUa5ZKD6bYyBvbZ26FLb4AQ+6n4TZ3KzEAkYHXno02xvu4xjQGFhsVFLKKmrXGgyuDlsbmkh5ie/vt/1HHtAhyG9+awp/t+LhxQg4nFxg0asTmZArV1826bASFafaigdeqlqNkJSNmgvUobA7hBDGReq92SLhNJVEx606yL2rsUSqT2asqp8wy0xqRRpx9rlekPd+nqKLlalrdLbVQ311s5EMdF1P/T+CPbBrYLJ/ZRScFTKpef4UhlSlQpjpbjS1eRSB/XzC2+dFrsIk2hdPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0JcVWYDTrC9zmi4M16KqWb1pcwH1V5/vKkmYydsReA=;
 b=HpGWy23H51SD2fmzVWRkrVedHAmvP8+kRY+OVSYI65PQPUBtsgAFJK2mWZmtIWoVWnIE9XcRcF87taFn2L4B1IA7pAilONiWhAdqS1JZm9Wl0LAFPvqaJ++uYZuTFEOJeGa+a+pFWTHeonqWghP7yO7n6D6/Vm6fqlfA8U8fKxX8cvaV0MNuZLm8Iz1/x31W/DnmDnZqqHQxxIVf8RjTFY6KlP3a64L8dwgHlu/9pbaIhPtSOY6hiTh6D2V6jJC6HAt8fWkhUFw8GI3PAEqAvrcCHc/ZXFvWFln0iR1har1Af1QWvFgmjXVBdIcn19Lyg8jPpzYD9DPPq61cYeKenQ==
Received: from BYAPR08CA0002.namprd08.prod.outlook.com (2603:10b6:a03:100::15)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Mon, 16 Oct
 2023 06:31:37 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::9d) by BYAPR08CA0002.outlook.office365.com
 (2603:10b6:a03:100::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 06:31:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 06:31:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 23:31:19 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 23:31:18 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Sun, 15 Oct
 2023 23:31:15 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [RFC iproute2-next 2/3] rdma: Add an option to set privileged QKEY parameter
Date:   Mon, 16 Oct 2023 09:31:02 +0300
Message-ID: <20231016063103.19872-3-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231016063103.19872-1-phaddad@nvidia.com>
References: <20231016063103.19872-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: c23215db-94b3-4e53-fcb9-08dbce118cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KVsu/Zrs+QOixhxtL6lMohMJHh/f6zLzbjQrJ05ICOl/NI6j5i1Hkt5TMxwkgKp74Y/wdr2ghtzfaMxvPNws58eludJEZs65kPCJDBv0iAgyHIKkzyzX8z6LugXhXwLnWbYVcR3OPl7tCYQilzTlGIVmLJtAWXWyPKvSFMt9RGj8H97nnYMEefMD80fQ+6gpJc8Fg7Xf7yT93Ou4WDpRLHcRTdcISQcZj+hzCItWKPJ18dpTT2TjgxKy0Yb2qYch+gGrt9hutqwGIFXaxlSVY2W/UzK6oOc26V6sd0IBeVBXwGj10m4xJrTF5E+a4GzSRxB0fn8LB2c6qKv41/XxzLfAo9aALeKmCYvNkfpMcN7Rrimb6J82oKT1W41psENxDm7PttXilZm5tEI8thAWccS4YoRCwh+j+26FB0M/ZAb0MbCGrb7wuytZpLujmEcyF6GXjgSLcSUJYq8NyK2wV/aqZh/J3jFqfRGw0n9L/c5psYfQc1zt1JTCFTCiLBrguO75ILw1eeTO+/ZbTQGlOBbXdVlIhJMwlrAnbLIhv7fOOJh1eI0W+Abrlbmaxx5mJX3cpq7XO7WB5npNeeiO0IT+AmM6byU+zy2wGExbQK8dL9hblMBeO2PP/wMiP5fulhZPQz/M9w5Ayzp/WomHN5mddT+5+L6GmG4nzxC3rJM1me4ZY8Xwgx7lnEFyyujWgAPHGiU/OTIJSf98bnWx+iK4ueMYiKtnp1QuZNT0bsS4h7OHug3rOFGi3KRIZTL2
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(82310400011)(451199024)(186009)(46966006)(40470700004)(36840700001)(6666004)(478600001)(40460700003)(107886003)(1076003)(426003)(336012)(26005)(356005)(86362001)(82740400003)(47076005)(2616005)(7636003)(36756003)(36860700001)(40480700001)(83380400001)(7696005)(110136005)(70206006)(41300700001)(70586007)(316002)(54906003)(8936002)(8676002)(4326008)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 06:31:37.1407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c23215db-94b3-4e53-fcb9-08dbce118cac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

