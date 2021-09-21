Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95185412E9F
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Sep 2021 08:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhIUG3k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Sep 2021 02:29:40 -0400
Received: from mail-dm6nam10on2069.outbound.protection.outlook.com ([40.107.93.69]:54336
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229686AbhIUG3k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Sep 2021 02:29:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EahjFcAOeQwpgadBY37q2szaU1UyfNWl6bb09w3MpAqu9klsBVJQtj33VK9aIcW+qKBpac5/2SOPbDmh+VOJW8RsKRhG/GsFZSd2U2b2W3f0pNBMYVBiebKu7838tqOEtyvUZAUJh5J2gVrEVPcKyB7TWj2yI1zC7a1h+MrzRtlb6zI6detQNB9/qd8F3W8JjprCD5UgA+9rBcRyc//lUZ1lL8E4KFzXEHSogo59eYSvKf9AhK+V8Y4OgElEuJw1MqfLcfPoonvR+tyD5gg5Z/zygDPvXC6A55KB7PTzik3mdFppzqrKHFpvMvygSSGWM6X9tHCrHmXqhhi9rpEeTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VC6Xu5n0iWfU8LdbDGv4y1XSKT2SPG4vutWU7vKEXbg=;
 b=gRgF8A+lFV6YIjfv4O9S/dVLmmFiU4Zr3YQpLLxxell48yDzPiO8/DWFjrPmJY1QGKqCqPg5TzeFhRNrJfitpgW7Mc+fsF9l6CT6PymRukOjCB+QYAqiaxy0tkeRoiCfRx7nVzkcqw6HdCyCyXcBCTiFwo2fF3hOZvpstUhYz80+AA6g3DJCPJ8KSmQnHG7i6KHy15lfXKSGA97ZGgFllfdbX0sQmNCzJHHgUycZqWEhYd7xzCacFiIODW4HRs/ZN6mUYv8k3GNAXHpwvfMOsKADokk5d2c8miS29bFsazDTpeQPJwjiy+zdyARbFiGWyBYjIm/MLRRO87OMjqDkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC6Xu5n0iWfU8LdbDGv4y1XSKT2SPG4vutWU7vKEXbg=;
 b=N1ocmB8HTPEhVQTKt1NxdSH2J1ir6Tkzwpppv44IIFYIaAk7RcL9OjCdoc4pMO7lbqGhe5zmjEI2adXL1/PnOiF+aYEgtXt7A/fvzKB2uIEUcj0fc6JW8rcZOhd+io2jVS4/lGp+XFiK00NuY+rtTkoZ4BaNoA3ERUpiD6pEcbNykySTJiqHmPWUdaEiFOakhsmJztlPADB/PFT/JqjJGNY++JPuE2T3PUDsmIOYoOvzojQCM9aB/+j9taFzCsUgHH0iW0qzUaEP0AWPph2+4owVCVGG7UzOGwbDDwGf9Da34rTQDYEGD/GErVhCNKuldWC2yHGi0kN6DlXL2VbAiA==
Received: from DM5PR07CA0070.namprd07.prod.outlook.com (2603:10b6:4:ad::35) by
 MN2PR12MB3118.namprd12.prod.outlook.com (2603:10b6:208:c6::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 06:28:10 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::bc) by DM5PR07CA0070.outlook.office365.com
 (2603:10b6:4:ad::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 06:28:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 06:28:10 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 06:28:09 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Sep 2021 06:28:07 +0000
From:   Mark Zhang <markzhang@nvidia.com>
To:     <jgg@nvidia.com>, <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <aharonl@nvidia.com>,
        <netao@nvidia.com>, <leonro@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH iproute2-next 3/3] rdma: Add optional-counters set/unset support
Date:   Tue, 21 Sep 2021 09:27:26 +0300
Message-ID: <20210921062726.79973-4-markzhang@nvidia.com>
X-Mailer: git-send-email 2.8.4
In-Reply-To: <20210921062726.79973-1-markzhang@nvidia.com>
References: <20210921062726.79973-1-markzhang@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16fe5efb-a950-4452-c78e-08d97cc8fba5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3118:
X-Microsoft-Antispam-PRVS: <MN2PR12MB311876E5B1621FC765B90F81C7A19@MN2PR12MB3118.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYSjhjdEMTHQSGxY4LAV07gWFLx8fnicu0WmB5qgE2Adn2sjk0vr/z5Jjdgz4SU65+atjK50+LEIc3YUjtuDIsHuWVJjoGhOErSEapFtrueYpJqb7KaDN+wLeUJbnGcpgUWfvz5YvxO6XwFwEf9Byt1KxRypnMGf+FLZGapUcyoAqPpoiBHnIc8A/oqcOni+Gvg3Hi+bA5kuJIRcZBrC4N3DhdkXv0txt/hJFDs6nuAwi+MsfhMZHeypJi5KkGPHIHpr6KDp/GgzoMxZmgVx0GgQ7XjIHIj8vHC+CKFaynyBaK0xmmpyTnSvCu9PjeNjWn91nROJsEQen74S9f87Kx7j3T3LJhL694LyQ3PitRn7l5ZrJJNIHggu/2+c67Thar0WFz5QGw/zwhKkUzbyA8IkUETZPtVy5TVhAUPT3T2ZExxzO1bbyRWNxpT6yJN7UO25nSbGrXkrnnxKWXQua7e3eH0UrPPsdWWpW9vwopcTQSDiqtnqBwDPK9kYPzVqiLfHem2vWof3Am+j5n6CfMgyrGZy+CgwSHBDiJKVv2i0og/TuMAIhKhrqQyVCwYh1GIqDIiADsKYlMGJ6hc9WUu0KpNzieY5uF2dNb8/IWme3BvoALlZbmOOHp3GjgCyoPJpolsXFWcM2+xqE0D58vV1ut3X9osM0+xEB9eDJ6Q/jY9pLFkz9CMCxtQPbyuOXU7Or2UIyIvSe5m0oWREWw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(1076003)(36860700001)(110136005)(4326008)(54906003)(36756003)(86362001)(5660300002)(316002)(82310400003)(36906005)(356005)(508600001)(7696005)(70206006)(70586007)(7636003)(186003)(336012)(2906002)(8676002)(83380400001)(8936002)(47076005)(426003)(26005)(6666004)(2616005)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 06:28:10.5622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fe5efb-a950-4452-c78e-08d97cc8fba5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3118
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Neta Ostrovsky <netao@nvidia.com>

This patch provides an extension to the rdma statistics tool
that allows to set/unset optional counters set dynamically,
using new netlink commands.
Note that the optional counter statistic implementation is
driver-specific and may impact the performance.

Examples:
To enable a set of optional counters on link rocep8s0f0/1:
    $ sudo rdma statistic set link rocep8s0f0/1 optional-counters cc_rx_ce_pkts,cc_rx_cnp_pkts
To disable all optional counters on link rocep8s0f0/1:
    $ sudo rdma statistic unset link rocep8s0f0/1 optional-counters

Signed-off-by: Neta Ostrovsky <netao@nvidia.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
---
 man/man8/rdma-statistic.8 |  32 ++++++++
 rdma/stat.c               | 163 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+)

diff --git a/man/man8/rdma-statistic.8 b/man/man8/rdma-statistic.8
index 885769bc..198ce0bf 100644
--- a/man/man8/rdma-statistic.8
+++ b/man/man8/rdma-statistic.8
@@ -65,6 +65,21 @@ rdma-statistic \- RDMA statistic counter configuration
 .B link
 .RI "[ " DEV/PORT_INDEX " ]"
 
+.ti -8
+.B rdma statistic
+.B set
+.B link
+.RI "[ " DEV/PORT_INDEX " ]"
+.B optional-counters
+.RI "[ " OPTIONAL-COUNTERS " ]"
+
+.ti -8
+.B rdma statistic
+.B unset
+.B link
+.RI "[ " DEV/PORT_INDEX " ]"
+.B optional-counters
+
 .ti -8
 .IR COUNTER_SCOPE " := "
 .RB "{ " link " | " dev " }"
@@ -111,6 +126,13 @@ If this argument is omitted then a new counter will be allocated.
 
 .SS rdma statistic mode supported - Display the supported optional counters for each link.
 
+.SS rdma statistic set - Enable a set of optional counters for a specific device/port.
+
+.I "OPTIONAL-COUNTERS"
+- specifies the name of the optional counters to enable. Optional counters that are not specified will be disabled. Note that optional counters are driver-specific.
+
+.SS rdma statistic unset - Disable all optional counters for a specific device/port.
+
 .SH "EXAMPLES"
 .PP
 rdma statistic show
@@ -207,6 +229,16 @@ rdma statistic mode supported link mlx5_2/1
 .RS 4
 Display the optional counters that mlx5_2/1 supports.
 .RE
+.PP
+rdma statistic set link mlx5_2/1 optional-counters cc-rx-ce-pkts,cc_rx_cnp_pkts
+.RS 4
+Enable the cc-rx-ce-pkts,cc_rx_cnp_pkts counters on device mlx5_2 port 1.
+.RE
+.PP
+rdma statistic unset link mlx5_2/1 optional-counters
+.RS 4
+Disable all the optional counters on device mlx5_2 port 1.
+.RE
 
 .SH SEE ALSO
 .BR rdma (8),
diff --git a/rdma/stat.c b/rdma/stat.c
index 157b23bf..b5d1a59f 100644
--- a/rdma/stat.c
+++ b/rdma/stat.c
@@ -22,6 +22,8 @@ static int stat_help(struct rd *rd)
 	pr_out("       %s statistic show link [ DEV/PORT_INDEX ]\n", rd->filename);
 	pr_out("       %s statistic mode [ supported ]\n", rd->filename);
 	pr_out("       %s statistic mode [ supported ] link [ DEV/PORT_INDEX ]\n", rd->filename);
+	pr_out("       %s statistic set link [ DEV/PORT_INDEX ] optional-counters [ OPTIONAL-COUNTERS ]\n", rd->filename);
+	pr_out("       %s statistic unset link [ DEV/PORT_INDEX ] optional-counters\n", rd->filename);
 	pr_out("where  OBJECT: = { qp }\n");
 	pr_out("       CRITERIA : = { type }\n");
 	pr_out("       COUNTER_SCOPE: = { link | dev }\n");
@@ -43,6 +45,8 @@ static int stat_help(struct rd *rd)
 	pr_out("       %s statistic mode link mlx5_2/1\n", rd->filename);
 	pr_out("       %s statistic mode supported\n", rd->filename);
 	pr_out("       %s statistic mode supported link mlx5_2/1\n", rd->filename);
+	pr_out("       %s statistic set link mlx5_2/1 optional-counters cc-rx-ce-pkts,cc_rx_cnp_pkts\n", rd->filename);
+	pr_out("       %s statistic unset link mlx5_2/1 optional-counters\n", rd->filename);
 
 	return 0;
 }
@@ -878,6 +882,163 @@ static int stat_mode(struct rd *rd)
 	return rd_exec_cmd(rd, cmds, "parameter");
 }
 
+static int stat_one_set_link_opcounters(const struct nlmsghdr *nlh, void *data)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX] = {};
+	struct nlattr *nla_entry, *tb_set;
+	int flags = NLM_F_REQUEST | NLM_F_ACK;
+	struct rd *rd = data;
+	uint32_t seq;
+	char *opcnt;
+	bool found;
+
+	mnl_attr_parse(nlh, 0, rd_attr_cb, tb);
+	if (!tb[RDMA_NLDEV_ATTR_STAT_HWCOUNTERS])
+		return MNL_CB_ERROR;
+
+	if (rd_no_arg(rd)) {
+		stat_help(rd);
+		return -EINVAL;
+	}
+
+	if (strcmpx(rd_argv(rd), "optional-counters") != 0) {
+		pr_err("Unknown parameter '%s'.\n", rd_argv(rd));
+		return -EINVAL;
+	}
+
+	rd_arg_inc(rd);
+	if (rd_no_arg(rd)) {
+		stat_help(rd);
+		return -EINVAL;
+	}
+
+	rd_prepare_msg(rd, RDMA_NLDEV_CMD_STAT_SET, &seq, flags);
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_DEV_INDEX,
+			 rd->dev_idx);
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_PORT_INDEX,
+			 rd->port_idx);
+	mnl_attr_put_u8(rd->nlh, RDMA_NLDEV_ATTR_STAT_HWCOUNTER_DYNAMIC, 1);
+
+	tb_set = mnl_attr_nest_start(rd->nlh, RDMA_NLDEV_ATTR_STAT_HWCOUNTERS);
+
+	opcnt = strtok(rd_argv(rd), ",");
+	while (opcnt) {
+		found = false;
+		mnl_attr_for_each_nested(nla_entry,
+					 tb[RDMA_NLDEV_ATTR_STAT_HWCOUNTERS]) {
+			struct nlattr *cnt[RDMA_NLDEV_ATTR_MAX] = {}, *nm, *id;
+
+			if (mnl_attr_parse_nested(nla_entry, rd_attr_cb,
+						  cnt) != MNL_CB_OK)
+				return -EINVAL;
+
+			nm = cnt[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME];
+			id = cnt[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_INDEX];
+			if (!nm || ! id)
+				return -EINVAL;
+
+			if (!cnt[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_DYNAMIC])
+				continue;
+
+			if (strcmp(opcnt, mnl_attr_get_str(nm)) == 0) {
+				mnl_attr_put_u32(rd->nlh,
+						 RDMA_NLDEV_ATTR_STAT_HWCOUNTER_INDEX,
+						 mnl_attr_get_u32(id));
+				found = true;
+			}
+		}
+
+		if (!found)
+			return -EINVAL;
+
+		opcnt = strtok(NULL, ",");
+	}
+	mnl_attr_nest_end(rd->nlh, tb_set);
+
+	return rd_sendrecv_msg(rd, seq);
+}
+
+static int stat_one_set_link(struct rd *rd)
+{
+	uint32_t seq;
+	int err;
+
+	if (!rd->port_idx)
+		return 0;
+
+	err = stat_one_link_get_status_req(rd, &seq);
+	if (err)
+		return err;
+
+	return rd_recv_msg(rd, stat_one_set_link_opcounters, rd, seq);
+}
+
+static int stat_set_link(struct rd *rd)
+{
+	return rd_exec_link(rd, stat_one_set_link, true);
+}
+
+static int stat_set(struct rd *rd)
+{
+	const struct rd_cmd cmds[] = {
+		{ NULL,		stat_help },
+		{ "link",	stat_set_link },
+		{ "help",	stat_help },
+		{ 0 },
+	};
+	return rd_exec_cmd(rd, cmds, "parameter");
+}
+
+static int stat_one_unset_link_opcounters(struct rd *rd)
+{
+	int flags = NLM_F_REQUEST | NLM_F_ACK;
+	struct nlattr *tbl;
+	uint32_t seq;
+
+	if (rd_no_arg(rd)) {
+		stat_help(rd);
+		return -EINVAL;
+	}
+
+	if (strcmpx(rd_argv(rd), "optional-counters") != 0) {
+		pr_err("Unknown parameter '%s'.\n", rd_argv(rd));
+		return -EINVAL;
+	}
+
+	rd_prepare_msg(rd, RDMA_NLDEV_CMD_STAT_SET, &seq, flags);
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_DEV_INDEX,
+			 rd->dev_idx);
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_PORT_INDEX,
+			 rd->port_idx);
+	mnl_attr_put_u8(rd->nlh, RDMA_NLDEV_ATTR_STAT_HWCOUNTER_DYNAMIC, 1);
+
+	tbl = mnl_attr_nest_start(rd->nlh, RDMA_NLDEV_ATTR_STAT_HWCOUNTERS);
+	mnl_attr_nest_end(rd->nlh, tbl);
+
+	return rd_sendrecv_msg(rd, seq);
+}
+
+static int stat_one_unset_link(struct rd *rd)
+{
+	return stat_one_unset_link_opcounters(rd);
+}
+
+static int stat_unset_link(struct rd *rd)
+{
+	return rd_exec_link(rd, stat_one_unset_link, true);
+}
+
+static int stat_unset(struct rd *rd)
+{
+	const struct rd_cmd cmds[] = {
+		{ NULL,		stat_help },
+		{ "link",	stat_unset_link },
+		{ "help",	stat_help },
+		{ 0 },
+	};
+	return rd_exec_cmd(rd, cmds, "parameter");
+}
+
 static int stat_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 {
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX] = {};
@@ -950,6 +1111,8 @@ int cmd_stat(struct rd *rd)
 		{ "qp",		stat_qp },
 		{ "mr",		stat_mr },
 		{ "mode",	stat_mode },
+		{ "set",	stat_set },
+		{ "unset",	stat_unset },
 		{ 0 }
 	};
 
-- 
2.26.2

