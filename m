Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43947412E9E
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Sep 2021 08:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhIUG3g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Sep 2021 02:29:36 -0400
Received: from mail-dm3nam07on2056.outbound.protection.outlook.com ([40.107.95.56]:3169
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229686AbhIUG3g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Sep 2021 02:29:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTdSS7H+G9bkxjz1wekPa4D5oovhWIHnRtq4hMLwfCEQoqjlc/bpUllexjj7eJBbyKEVmHLUZ6Ablc5FN9zqP6Sc4TPjLG7/pXMkaVrZkqnOTJjUZuHqYlioUoz3LvXtftRMYTlt+7VwMoK4unIJrjrZDtj6f9z5nQHfna1tLLi7Es+j3xCkiWFSxYmnU2ENzF2c6YsMKWilvCTlOR6fwurYUKozMgprL0FUSqHHB59N8t8v1g56KC27NR4OEQZO2pspzSxgD7sD2gPPU+ujfmzi/cLhIC7G87BvhuWDxXExLatTYJk7t5szdyUM8SkCeoTHCIaOsJAFnyGFHbwBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ak015dCLhFT9HUZ+614RoSyGTvLmgkWSQVqt3U7rULo=;
 b=fLa2OcaUMIvwJwCevLl9w+cdZT5a9DhKJ9n6iV2Ycc5z2rTtn2DJzfI+vDZs40VkSqXUCQ5WGM3lag/b0pIaRt26gMUcqUk4H5dA1/ptzaijp00gGaYh5K7wgCrSGEa/cUyBBTx6jd03CNajBt5PhYxWvjQJ8XOgBiapMvfiUJ+gOFodhRKMKacWxfU6Mo0tDpKsQB1J3AIU6/Ejx2nRYx4d1KoN7GO3KLiPzJo24prjbEm8fVoXNjTpG7Enw3qH9wAh+LbUgJfrJnnE01TMd/zs4uPPoF6B/A7JrJ7mL9yRFOURBE9zO4FURcUPs4dRuvU00O0LqLq9z9OUBclxOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak015dCLhFT9HUZ+614RoSyGTvLmgkWSQVqt3U7rULo=;
 b=RmuDTNdYJpURWY+Cu363dV+djlaVb7ij8LVHsf4YKYLhLJl7nI0KhxGML/uh1JekvMMeJdkEMzH8/aumgCetXCkmIedhO+ld1usJQNosHdRacZCSBQbKBL7/AhhHcvJOK7yz0OBCImCOHo6Tzs9OumnMhb0Ncp2kGVcAUxzHordDAsOMM5RlQ5mgh/V97n0tQO4GBpYtBTvl1O3SNVnEAceFoI0jE7yv9Zh3MmWtFKdTiFOBhMI5dtw0YCg+NQDo7VM6gbZYzMR5vskST7sgXZBI9UJPfh4B4bAj9VXQDWBCGjnmfleJcloB8SSNrKhkYqWQJZPAHU0CXTMSstPJdQ==
Received: from MW4PR04CA0354.namprd04.prod.outlook.com (2603:10b6:303:8a::29)
 by BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Tue, 21 Sep
 2021 06:28:06 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::f3) by MW4PR04CA0354.outlook.office365.com
 (2603:10b6:303:8a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 06:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 06:28:06 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 20 Sep
 2021 23:28:05 -0700
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Sep 2021 06:28:03 +0000
From:   Mark Zhang <markzhang@nvidia.com>
To:     <jgg@nvidia.com>, <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <aharonl@nvidia.com>,
        <netao@nvidia.com>, <leonro@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH iproute2-next 2/3] rdma: Add stat "mode" support
Date:   Tue, 21 Sep 2021 09:27:25 +0300
Message-ID: <20210921062726.79973-3-markzhang@nvidia.com>
X-Mailer: git-send-email 2.8.4
In-Reply-To: <20210921062726.79973-1-markzhang@nvidia.com>
References: <20210921062726.79973-1-markzhang@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ba6ccb4-c3ae-42e4-6a64-08d97cc8f92d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4901:
X-Microsoft-Antispam-PRVS: <BY5PR12MB490185068024BAEFD35BCF5DC7A19@BY5PR12MB4901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:94;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JjFXcbY52q48PuHUsprSttDciZx4VoYJZVkQDdsq1UiTHaWluVc2IBFvFmm9WED/CkN3LXafiVNDybq6MOCuCnQgmk1gC/SWNqFSKwEJfB6a05zhlHW94AdfQroJ0NEHEuFHL3YtsJJnNakmL0ah3k/aleYP8JVSBGhq02679p52ZWBj9qGVmWyb+n79hYiPgHIQjVEnvPdzDMFWG7xybdgdrXNex0vfTwZL6iktEl5P4V15+XvTRV07/+hWYxxu3otdFM8C5ORXgeiW0Ze1/iU8ICTLEkOob+hPleXV7oJXXFmMUWgj84fMq/pB8oUw1DC82kI6zq66kBReQgI0Nb2f6yTuo7h++DBezR+w0q6K+1jFp8hUc9A2BedW98no1OW6pKq6bxU6DzeD4IR5PqOH6bXVRRVpsfUoMYGIqFVk0VV6si18otaD9xFNG4NFrnge/dUHZiaaWl8iRxTT5BWhRFNAmbFsE8j8cSGaCeyRsxic63oaYnkLRpXIa5YPkTFdwd7oUPVVRUJYYsI45FjYR7QPkleEHsxXO19phcMYzMPFZVSpJWrwcOaOpNLKUkkPWBSDV8Hnx/Vc7EvLOw550VUpBaGt+u96XzolG+HHfcv4td6y+aUiGZlea5RsIQsD7PzqYMoc5c3BM1SFfpqIupB2Fk9VZv+RmuKyCZl0FPfbILJgvsQVlEGAIWEZkuVta/K0oEsRNnPgBIL2hg==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(1076003)(86362001)(4326008)(2906002)(54906003)(47076005)(2616005)(8936002)(110136005)(36756003)(8676002)(186003)(426003)(107886003)(336012)(82310400003)(83380400001)(5660300002)(6666004)(7636003)(36860700001)(356005)(316002)(70206006)(7696005)(508600001)(26005)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 06:28:06.4333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba6ccb4-c3ae-42e4-6a64-08d97cc8f92d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Neta Ostrovsky <netao@nvidia.com>

This patch introduces the "mode" command, which presents the enabled or
supported (when the "supported" argument is available) optional
counters.

An optional counter is a vendor-specific counter that may be
dynamically enabled/disabled. This enhancement of hwcounters allows
exposing of counters which are for example mutual exclusive and cannot
be enabled at the same time, counters that might degrades performance,
optional debug counters, etc.

Examples:
To present currently enabled optional counters on link rocep8s0f0/1:
    $ rdma statistic mode link rocep8s0f0/1
    link rocep8s0f0/1 optional-counters cc_rx_ce_pkts

To present supported optional counters on link rocep8s0f0/1:
    $ rdma statistic mode supported link rocep8s0f0/1
    link rocep8s0f0/1 supported optional-counters cc_rx_ce_pkts,cc_rx_cnp_pkts,cc_tx_cnp_pkts

Signed-off-by: Neta Ostrovsky <netao@nvidia.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
---
 man/man8/rdma-statistic.8 |  23 ++++++
 rdma/stat.c               | 164 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)

diff --git a/man/man8/rdma-statistic.8 b/man/man8/rdma-statistic.8
index 7160bcdf..885769bc 100644
--- a/man/man8/rdma-statistic.8
+++ b/man/man8/rdma-statistic.8
@@ -58,6 +58,13 @@ rdma-statistic \- RDMA statistic counter configuration
 .RI "[ " COUNTER-ID " ]"
 .RI "[ " OBJECT-ID " ]"
 
+.ti -8
+.B rdma statistic
+.B mode
+.B "[" supported "]"
+.B link
+.RI "[ " DEV/PORT_INDEX " ]"
+
 .ti -8
 .IR COUNTER_SCOPE " := "
 .RB "{ " link " | " dev " }"
@@ -100,6 +107,10 @@ When unbound the statistics of this object are no longer available in this count
 - specifies the id of the counter to be bound.
 If this argument is omitted then a new counter will be allocated.
 
+.SS rdma statistic mode - Display the enabled optional counters for each link.
+
+.SS rdma statistic mode supported - Display the supported optional counters for each link.
+
 .SH "EXAMPLES"
 .PP
 rdma statistic show
@@ -186,6 +197,16 @@ rdma statistic show mr mrn 6
 .RS 4
 Dump a specific MR statistics with mrn 6. Dumps nothing if does not exists.
 .RE
+.PP
+rdma statistic mode link mlx5_2/1
+.RS 4
+Display the optional counters that was enabled on mlx5_2/1.
+.RE
+.PP
+rdma statistic mode supported link mlx5_2/1
+.RS 4
+Display the optional counters that mlx5_2/1 supports.
+.RE
 
 .SH SEE ALSO
 .BR rdma (8),
@@ -198,3 +219,5 @@ Dump a specific MR statistics with mrn 6. Dumps nothing if does not exists.
 Mark Zhang <markz@mellanox.com>
 .br
 Erez Alfasi <ereza@mellanox.com>
+.br
+Neta Ostrovsky <netao@nvidia.com>
diff --git a/rdma/stat.c b/rdma/stat.c
index 8edf7bf1..157b23bf 100644
--- a/rdma/stat.c
+++ b/rdma/stat.c
@@ -20,6 +20,8 @@ static int stat_help(struct rd *rd)
 	pr_out("       %s statistic OBJECT unbind COUNTER_SCOPE [DEV/PORT_INDEX] [COUNTER-ID]\n", rd->filename);
 	pr_out("       %s statistic show\n", rd->filename);
 	pr_out("       %s statistic show link [ DEV/PORT_INDEX ]\n", rd->filename);
+	pr_out("       %s statistic mode [ supported ]\n", rd->filename);
+	pr_out("       %s statistic mode [ supported ] link [ DEV/PORT_INDEX ]\n", rd->filename);
 	pr_out("where  OBJECT: = { qp }\n");
 	pr_out("       CRITERIA : = { type }\n");
 	pr_out("       COUNTER_SCOPE: = { link | dev }\n");
@@ -37,6 +39,10 @@ static int stat_help(struct rd *rd)
 	pr_out("       %s statistic qp unbind link mlx5_2/1 cntn 4 lqpn 178\n", rd->filename);
 	pr_out("       %s statistic show\n", rd->filename);
 	pr_out("       %s statistic show link mlx5_2/1\n", rd->filename);
+	pr_out("       %s statistic mode\n", rd->filename);
+	pr_out("       %s statistic mode link mlx5_2/1\n", rd->filename);
+	pr_out("       %s statistic mode supported\n", rd->filename);
+	pr_out("       %s statistic mode supported link mlx5_2/1\n", rd->filename);
 
 	return 0;
 }
@@ -715,6 +721,163 @@ static int stat_qp(struct rd *rd)
 	return rd_exec_cmd(rd, cmds, "parameter");
 }
 
+static int do_stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data,
+				 bool supported)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX] = {};
+	struct nlattr *nla_entry;
+	const char *dev, *name;
+	struct rd *rd = data;
+	int enabled, err = 0;
+	bool isfirst = true;
+	uint32_t port;
+
+	mnl_attr_parse(nlh, 0, rd_attr_cb, tb);
+	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX] || !tb[RDMA_NLDEV_ATTR_DEV_NAME] ||
+	    !tb[RDMA_NLDEV_ATTR_PORT_INDEX] ||
+	    !tb[RDMA_NLDEV_ATTR_STAT_HWCOUNTERS])
+		return MNL_CB_ERROR;
+
+	dev = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_NAME]);
+	port = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_PORT_INDEX]);
+
+	mnl_attr_for_each_nested(nla_entry,
+				 tb[RDMA_NLDEV_ATTR_STAT_HWCOUNTERS]) {
+		struct nlattr *cnt[RDMA_NLDEV_ATTR_MAX] = {};
+
+		err  = mnl_attr_parse_nested(nla_entry, rd_attr_cb, cnt);
+		if ((err != MNL_CB_OK) ||
+		    (!cnt[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]))
+			return -EINVAL;
+
+		if (!cnt[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_DYNAMIC])
+			continue;
+
+		enabled = mnl_attr_get_u8(cnt[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_DYNAMIC]);
+		name = mnl_attr_get_str(cnt[RDMA_NLDEV_ATTR_STAT_HWCOUNTER_ENTRY_NAME]);
+		if (supported || enabled) {
+			if (isfirst) {
+				open_json_object(NULL);
+				print_color_string(PRINT_ANY, COLOR_NONE,
+						   "ifname", "link %s/", dev);
+				print_color_uint(PRINT_ANY, COLOR_NONE, "port",
+						 "%u ", port);
+				if (supported)
+					open_json_array(PRINT_ANY,
+						"supported optional-counters");
+				else
+					open_json_array(PRINT_ANY,
+							"optional-counters");
+				print_color_string(PRINT_FP, COLOR_NONE, NULL,
+						   " ", NULL);
+				isfirst = false;
+			} else {
+				print_color_string(PRINT_FP, COLOR_NONE, NULL,
+						   ",", NULL);
+			}
+			if (rd->pretty_output && !rd->json_output)
+				newline_indent(rd);
+
+			print_color_string(PRINT_ANY, COLOR_NONE, NULL, "%s",
+					   name);
+		}
+	}
+
+	if (!isfirst) {
+		close_json_array(PRINT_JSON, NULL);
+		newline(rd);
+	}
+
+	return 0;
+}
+
+static int stat_mode_parse_cb(const struct nlmsghdr *nlh, void *data)
+{
+	return do_stat_mode_parse_cb(nlh, data, false);
+}
+
+static int stat_mode_parse_cb_supported(const struct nlmsghdr *nlh, void *data)
+{
+	return do_stat_mode_parse_cb(nlh, data, true);
+}
+
+static int stat_one_link_get_status_req(struct rd *rd, uint32_t *seq)
+{
+	int flags = NLM_F_REQUEST | NLM_F_ACK;
+
+	rd_prepare_msg(rd, RDMA_NLDEV_CMD_STAT_GET, seq,  flags);
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_DEV_INDEX, rd->dev_idx);
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_PORT_INDEX, rd->port_idx);
+	mnl_attr_put_u8(rd->nlh, RDMA_NLDEV_ATTR_STAT_HWCOUNTER_DYNAMIC, 1);
+
+	return rd_send_msg(rd);
+}
+
+static int stat_one_link_get_mode(struct rd *rd)
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
+	return rd_recv_msg(rd, stat_mode_parse_cb, rd, seq);
+}
+
+static int stat_one_link_get_mode_supported(struct rd *rd)
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
+	return rd_recv_msg(rd, stat_mode_parse_cb_supported, rd, seq);
+}
+
+static int stat_link_get_mode(struct rd *rd)
+{
+	return rd_exec_link(rd, stat_one_link_get_mode, false);
+}
+
+static int stat_link_get_mode_supported(struct rd *rd)
+{
+	return rd_exec_link(rd, stat_one_link_get_mode_supported, false);
+}
+
+static int stat_mode_supported(struct rd *rd)
+{
+	const struct rd_cmd cmds[] = {
+		{ NULL,		stat_link_get_mode_supported },
+		{ "link",	stat_link_get_mode_supported },
+		{ "help",	stat_help },
+		{ 0 },
+	};
+	return rd_exec_cmd(rd, cmds, "parameter");
+}
+
+static int stat_mode(struct rd *rd)
+{
+	const struct rd_cmd cmds[] = {
+		{ NULL,		stat_link_get_mode },
+		{ "link",	stat_link_get_mode },
+		{ "show",	stat_link_get_mode },
+		{ "supported",	stat_mode_supported },
+		{ "help",	stat_help },
+		{ 0 },
+	};
+
+	return rd_exec_cmd(rd, cmds, "parameter");
+}
+
 static int stat_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 {
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX] = {};
@@ -786,6 +949,7 @@ int cmd_stat(struct rd *rd)
 		{ "help",	stat_help },
 		{ "qp",		stat_qp },
 		{ "mr",		stat_mr },
+		{ "mode",	stat_mode },
 		{ 0 }
 	};
 
-- 
2.26.2

