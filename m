Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5837E7D6BC1
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 14:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343974AbjJYMbn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 08:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjJYMbm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 08:31:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C375CC;
        Wed, 25 Oct 2023 05:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAL+oW9ncaQ74owdrDOYwHP1a5osPlin1RXw+WUiykFu1X0VUWxS8lVeCyu3ep4MFf0SKHAkP1bOrMKksf1bJRf3sYAPPPs1VW7JOG7/BOrdST46rtp9PMOV1+7xtQBZ0NtSr5tIfCb+1iAcyegLj4WCqKWAjb3tW+zQHtPUK89h3uDJ19fq+Or3l/xrbX4W/lW5x1UH+zF3B9KDpNaRz4iJSEynYq45ZXvsjZAsHJlyQLNRcY7kAuIemuJXWeEQDbosllyPHhuCoz7wPRJrx4Dpv/ILXz01d7FLEgwo59FHq/jjmojIqeykQ6S6ue03z11/Pr4OrvYPxyarep477A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkVKxfmoB0VNoib7/jND40Wtz6CtYAiB7WoZEfedF8U=;
 b=DUg5x6AndMHmKEhVEASCjQcXRJlXBKnfq9osZeX09wQ+jJBYHHCgrqneeOYnYyRr6lCRAdgk5/AUu3ShiMuf9yySvSfAA0MArkS2e3jyX6FgGLeIBncyMM46crHSHA1aSQqpRXm4hQ3I6rXST4hD7GnulFjhfdpM8ztBeAHFH4ySiFuvIDfTbWKF2uZtnSq8iRNlJnewRdg41mWuIRXq0wU+PDbS/Y+XRkEoxoDfgEe48lqf0ixjIUkaZoOYtmhv/vUCbozYj03Oy0SDTDiLI0OjgwefWggSFltbXbnykS9dvdsgtUB34RC1n6VXrAY4gevf2rMlYPkH4pgEBx5e7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkVKxfmoB0VNoib7/jND40Wtz6CtYAiB7WoZEfedF8U=;
 b=nC+GR/vBci5DFgnZXfjAjm8sPdcv6o1LcMX7J/bV/AEqjUU/ixcD0DuiiipFSHwXqLWBiO+WOIG6Ln0ACx8/rciTga/6frCpqeC5qkV/szhFy4hdIi+2j6QV8aRGDGNrJzLzTv+A6JqHeeE+0zsYUNOCWJDCw7nqZFMyIO55gn5qr0X66gaklNSVYHWPh2+fAUJOLq31TglEtpcAbaXXCPMvjip9riyQC0KrWJivjMfKM/Uzk/ii/P0EOlUKOfw4gQ90iuhcjO8MJlmQVD0AAU0njowdAeaypvr1GKtHOlCsnwNgvCzAovosgBmp6j6E4aq30M/fEHIwjsdqKDHXhg==
Received: from DM6PR13CA0069.namprd13.prod.outlook.com (2603:10b6:5:134::46)
 by CH0PR12MB5028.namprd12.prod.outlook.com (2603:10b6:610:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 12:31:36 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::5c) by DM6PR13CA0069.outlook.office365.com
 (2603:10b6:5:134::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 12:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 12:31:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 05:31:16 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 25 Oct 2023 05:31:16 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 25 Oct 2023 05:31:13 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [PATCH v3 iproute2-next 2/3] rdma: Add an option to set privileged QKEY parameter
Date:   Wed, 25 Oct 2023 15:31:01 +0300
Message-ID: <20231025123102.27784-3-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231025123102.27784-1-phaddad@nvidia.com>
References: <20231025123102.27784-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CH0PR12MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: 381ad323-bd09-435d-52ce-08dbd556548b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcLLbB1OsKzMxhYQ+TMJ74Wc2eHNHNHwtn9y7pPGw/c6TyKkodEcEnMsUN2F3OSXNHtAxuMfO8aaIlwF2U35Jfp4EVGWVS26u/yFlL7rHOkQAM1Y3ePaRHIjYpUW0Wq6e/9xEB2rfZPz+LIvwqVMq93gJmakT/Vs08T0wqoxAuuDpJVhVYLM6mvGmPOzWtHZSxbyvWw2C4kXZ+bWPPN/HXYND4xppW1aefeM1Xon+QTh1zTvFs+ywdLNTbRD1JKPCfdUEK1piAo4WS3TZte8RRH10u9DUa1v7655fL3NYPrRgey5FNBXQbw88mSQntMHZTZN4MH92ohSAWNsHD+vi0zXgu/XSgQBQY2i2qiMJBovK/uMoLbrhH5Vmpiipb2ndsakY8jHNsaV5UPEYkSv2lznOJ+Yteq/k8Zratz+UxIeUHZD2q9Jy0CtJNQ6j5pApMJkYW/PiaSNIpUosmCmffHpirJ47Eoggb80rw24v1jgZX2gDnA8lqB5CWVgeYHCAQijDhoIlS0ZxMOJ7tfT1ZYEoWh5kMx9m1apUDie/VxqnB6gA1i8+2XYgaoBLd+83tewcUSXUCtOF2it266oIqhoISgh6ct4uHm40EmAX7W1D84heaeHvRn5e0ndZKskKRVXYoZH8j9y9K8ckO5HltquraEzJJ5s9+V2T4uYPVbXlYat+d83N5S4JAx1AlxGhfeCcFHxWsGMO4PUB5DJbPdbneP1Rw07HiXCWJbMkr0+r8QpqyjdVtdJmXo+lSVW
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(40470700004)(46966006)(36840700001)(2906002)(86362001)(41300700001)(82740400003)(54906003)(316002)(110136005)(70586007)(6666004)(7696005)(478600001)(107886003)(70206006)(1076003)(7636003)(426003)(47076005)(83380400001)(356005)(40480700001)(336012)(36860700001)(40460700003)(5660300002)(36756003)(4326008)(2616005)(8676002)(8936002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:31:36.4283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 381ad323-bd09-435d-52ce-08dbd556548b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5028
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 rdma/sys.c   | 45 +++++++++++++++++++++++++++++++++++++++++++--
 rdma/utils.c |  1 +
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/rdma/sys.c b/rdma/sys.c
index fd785b25..3e369553 100644
--- a/rdma/sys.c
+++ b/rdma/sys.c
@@ -40,6 +40,16 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 				   mode_str);
 	}
 
+	if (tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]) {
+		uint8_t mode;
+
+		mode = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]);
+
+		print_color_on_off(PRINT_ANY, COLOR_NONE, "privileged-qkey",
+				   "privileged-qkey %s ", mode);
+
+	}
+
 	if (tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
 		cof = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]);
 
@@ -67,8 +77,9 @@ static int sys_show_no_args(struct rd *rd)
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
 
@@ -86,6 +97,17 @@ static int sys_set_netns_cmd(struct rd *rd, bool enable)
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
@@ -111,10 +133,28 @@ static int sys_set_netns_args(struct rd *rd)
 	return sys_set_netns_cmd(rd, cmd);
 }
 
+static int sys_set_privileged_qkey_args(struct rd *rd)
+{
+	bool cmd;
+	int ret;
+
+	if (rd_no_arg(rd)) {
+		pr_err("valid options are: { on | off }\n");
+		return -EINVAL;
+	}
+
+	cmd = parse_on_off("privileged-qkey", rd_argv(rd), &ret);
+	if (ret)
+		return -EINVAL;
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
 
@@ -124,6 +164,7 @@ static int sys_set(struct rd *rd)
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

