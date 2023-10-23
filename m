Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B607D32B5
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 13:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjJWLW7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 07:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbjJWLW4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 07:22:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55F5C1;
        Mon, 23 Oct 2023 04:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8yM1vFZiCtW91GqMecub3Xb2fwusJilQDGdab/D1ob0VYZCWag3YkFBi9tFyXA7I41S2tej4b77q0LZ8Wxi/aO5vmxFRoS9/NNTeu0HTHgV0soohiEsKEqPDWLM3nqsOcce0FsI3WZMfcvoKSHhN1g0ZCqkEsYjLDn1L3p2mCjOp0EBI85kFhZ01JldiP8HLfvGgkuCUl/M4XWh8StJD+OI5Y3McaVWrSSDgNymHku5e6wL0gVY1iHUb1stAoM4nBMqrt22UAUjbSxLi/Q5kN/QfNbZ9WJzKiYF9nR9YakWf4+tjKvKVlwjW90/xTpBRkObxmHa6qAgldOFHmRz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ng4jSeCnrCkMrkdGCTowupl+jWtncI/eOWAiQ+2tss0=;
 b=BiT3k0IC/lvXKLdWQdvV11O1F+jSs+Ho4rV0LXm+eFeR56TyZsEw1g3iC8Sbj6fthrfvdrpH89EdSA1etH5fbLQe3gUSOV7vdKjsegKRylyMULQn10anl4MUKRElD07luQrRYpGKr70tmtjcfgZLg06MZTM2BOG7INt+sl0td5NcHqE0YaF328g5tFWfS2Ha++972XiIluxm34av+DHgL6huzLzOQ0KhT0d73fVL6eUyUwcaHHYbAL7BY19YC3SLQ8cops//c4qQ2Q87mudbh19uFaoY/+AmtCIfSjSgBOzwcFt+5Fb5lLZ61nQ9Vh/kmrd9eiI5DRF37E65P7ecSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng4jSeCnrCkMrkdGCTowupl+jWtncI/eOWAiQ+2tss0=;
 b=tCzxT2CYlIelXYt4fDkrMLzV5tC9wtirxyS6ZUn+RA32sJQZF9YMosTVs/SNS58kA373hHR98FM88LHeeU1z3pIrSn76b2bHdBXiKlGGwWW1j6whyph2JoS4qBacoe+YnGNMugjKGguh5ofzEbPmcUiS0gzIluAOjIPePE9aKoGnDNXaiTWTmTMku5pH6Odt0FVyDHNgougq2QuJTSZ4Un6Sx/6uq+U8IokEiPf7Psqcy3m64+B7gdqMQVLV8h+Kl8XZi11nrhRur4bhHEd8OLXOpIGpJCR+/DNeAE2UzgQESJElApN28qjFBmHUaQakuNWB3FnfR0oqy6d/A4t5Gg==
Received: from MW4PR03CA0102.namprd03.prod.outlook.com (2603:10b6:303:b7::17)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 11:22:50 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:b7:cafe::93) by MW4PR03CA0102.outlook.office365.com
 (2603:10b6:303:b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 11:22:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.0 via Frontend Transport; Mon, 23 Oct 2023 11:22:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 23 Oct
 2023 04:22:37 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 23 Oct 2023 04:22:32 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 23 Oct 2023 04:22:29 -0700
From:   Patrisious Haddad <phaddad@nvidia.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
        <michaelgur@nvidia.com>
Subject: [PATCH v2 iproute2-next 2/3] rdma: Add an option to set privileged QKEY parameter
Date:   Mon, 23 Oct 2023 14:22:16 +0300
Message-ID: <20231023112217.3439-3-phaddad@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231023112217.3439-1-phaddad@nvidia.com>
References: <20231023112217.3439-1-phaddad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: aab064c2-2b63-4693-932c-08dbd3ba6422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L+fNEKv2VjI11ViCcGjb4I4wQ3N1y8mcst7e+L20DlLW+EuCCbPto+5E6z8vyje94YyP02Hz4HfgER7PSRDwEPzXWfTvwHoSWOETNJWULKte1s2PQcc1Hw4Md8FwigXag7a/J4WCUpMzep904nnx90mWNHJahiNYY7wG9uwTp3/5RnxWoabb2sHWtLlMvH7qx5olPjUM9lt5QKxbLYKvDOeBEgqlDDklsyk/v3tZV7KmZlRn+FumVgRdGJBazsDsEsKdZaS+r2ql/vXCCO+XviPbTwtRWiyIplt6/nzMlUho2ZKb5eGjPTLFdmruHBbPheMoE9v5rOCtratOs3TyyNjUpyIZeTk1H7CZCA82fueLBjflrkYxkq6NLz2c8YzmiTzkZw64d7k2jkM1aT0olvQbyufqRLw/33qsIJ2zCz1+1Qjc7KCREi+LxULwxeVlGU0XfSuiXSW+HALvDDkMX+iNUaGIJpjsFhDZrIvH73s1q/B7nNTKOTa8EyRNDesAlQqjf+WEWmxiM7/zp9ivpZjrTD1S8SblUH07MBW2tcnkPe/lNdsoixBDKqhIw38tqS9WMUBZ0LCHF4JafWrhT29h8WvsH+FrOrXXtxH6VlepChI/BWYXBr+jKVOsVnIYx5ZXcaoAPcqEN848b2D58jzijjpaCrYjfYTck+V5T2Pu59dn9Z/T2haR/rkqXWQmk7D1pDKdZ82W15gM21wTbytuLNQNSR1/WydPp2j8FSGPuoOQItK8hOciLC42OKw3
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(2906002)(41300700001)(110136005)(356005)(316002)(70586007)(54906003)(2616005)(82740400003)(70206006)(7696005)(7636003)(107886003)(1076003)(6666004)(478600001)(40480700001)(47076005)(426003)(336012)(83380400001)(40460700003)(36756003)(86362001)(5660300002)(4326008)(8936002)(8676002)(36860700001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 11:22:49.8859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aab064c2-2b63-4693-932c-08dbd3ba6422
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
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
---
 rdma/sys.c   | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 rdma/utils.c |  1 +
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/rdma/sys.c b/rdma/sys.c
index fd785b25..db34cb41 100644
--- a/rdma/sys.c
+++ b/rdma/sys.c
@@ -40,6 +40,17 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 				   mode_str);
 	}
 
+	if (tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]) {
+		uint8_t pqkey_mode;
+
+		pqkey_mode =
+			mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]);
+
+		print_color_on_off(PRINT_ANY, COLOR_NONE, "privileged-qkey",
+				   "privileged-qkey %s ", pqkey_mode);
+
+	}
+
 	if (tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
 		cof = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]);
 
@@ -67,8 +78,9 @@ static int sys_show_no_args(struct rd *rd)
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
 
@@ -86,6 +98,17 @@ static int sys_set_netns_cmd(struct rd *rd, bool enable)
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
@@ -111,10 +134,28 @@ static int sys_set_netns_args(struct rd *rd)
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
 
@@ -124,6 +165,7 @@ static int sys_set(struct rd *rd)
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

