Return-Path: <linux-rdma+bounces-4665-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB75B9658A6
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 09:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937D7281C49
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 07:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C8716BE2C;
	Fri, 30 Aug 2024 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N4lRlvZa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E1C16B38E
	for <linux-rdma@vger.kernel.org>; Fri, 30 Aug 2024 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003126; cv=fail; b=sqluxtdMhUT9Y3Isvw4sr0qjQ7lteSXQY/8tTL6ICFimoKrFG/YqAf2WjZdK1bBkeXTBj9e9+mvQWUJXjr85sp3RUaVaq50IGOux5T007Dt1U1TlDEaNtpfZSzwTv71m+3atCaRoSmBiaHXLNxvY/Nt5TQrS2kYDBQdxcXHj1q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003126; c=relaxed/simple;
	bh=CZUQl0p/Ew155LkgJ0AXKQn2F7dZlBk4kaLbl1ajHXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cynP/dPgQ5WljfiqaG+tSpfzSUxYz7wLrvtrMen2hGyTR4jdyWexek9uceV+y/x7PS3Q9zrObCEfboKqMAFpBGalQoMTk9t/zcfCsCLhzA4Bzh/3x8Zoa8vgp9w46dDHtwbXJGDglfsB6W9WwoZwUpf63fP0wAVhJR1JMoyj4vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N4lRlvZa; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeEHhRVf97/1xoOeJcM1ywfaLb68mDo4HWRRBpZnoVfh6hF3BtONHe6Igjsbtce1JdBJpnz5ys8MoTUWzpxXfe67CAI+kEl8ubJvTz2ZnaBZtEQarkQFMP2TJpuMCYxDM09cx+9u0svbR7ZbWe3LTF39o4JlpJZzZT0qK1AP0TroZK7bgx8qJGGTmg86yDS2JZCjOywMwQjUlXP1CJpESQC+ZfML3YN0uXyKYtQn+JBKkT3wPCuCRyH9MOx92sLsiELurvc263U5YqMWoGKe7aYU6pgE5oLwApxSvgXh/FR47z+csrnJ6KuYOyY2t8599UmlIrZg8dejUV9eHGC4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hTEamW2IgIuljHfKT1nTk28fOwxJW5ItzWsU+FaB+Y=;
 b=JivvYl8WzbOZZqDhOfOsaxPplk4KICyv+Da/5YSE77WuZ3lmTVfBdnf6a/+9Zv6DGfc79447ARvaO/MIk9k2Qs3zUlJAyEDE6KRiecdX06igfdNcATK5xFUOShfHIEXMat/JDzicnXToq2U7ScOVic2wILMQLPpCOO2S+17NlQ8Dr+LYP4MtNkHFrwT8Ar02EzUq0pw1kS/cIKPXlFuS+WudF1ZtmQDAOMqfgaIRKDr16EM3T48ULlsFSN0DpGvbwe9WaSv+OO/zahlCtYfT/aYF0NrGeUw0CoH2Ns56clvgKdq/aWOes9ABQCsDqP4y7J9T03NoJCPip9sfbSbdLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hTEamW2IgIuljHfKT1nTk28fOwxJW5ItzWsU+FaB+Y=;
 b=N4lRlvZaDF+NoBRlZ+SSANgX/bP1rMV+VQnaxLk4EbO4KxucKeit3zHvQnsai6TynFHOpyI6UDyzQMM7pqiHN7z/cH5Raq7BVrG1j7q0iVq/peq5r2+Wd5Hg2cgOdayo9JOtm2S+47EpVY0ftj7ViSyVrQoGsz8Y/EXKyscgqHJ+2A3x5CoAkmweJMhP1ZOo8Dz7OPV+UGpkI5frGRmA7lh/DG8wS/wRcJ+FDe1gjeuWV8rLeM340faZ974ZXO14aPckkVKiN1K72LL92ugAvzoo4QpituVgHT0hUZ9+MpYk5m0RRdF5xl24RnQlXqolrBXRGVLDhdpwGb+jD9L61Q==
Received: from MW4PR03CA0209.namprd03.prod.outlook.com (2603:10b6:303:b8::34)
 by DM4PR12MB7504.namprd12.prod.outlook.com (2603:10b6:8:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 07:32:01 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::8) by MW4PR03CA0209.outlook.office365.com
 (2603:10b6:303:b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Fri, 30 Aug 2024 07:32:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.2 via Frontend Transport; Fri, 30 Aug 2024 07:32:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:51 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:51 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 30 Aug
 2024 00:31:49 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [PATCH rdma-next v2 7/7] RDMA/nldev: Expose whether RDMA monitoring is supported
Date: Fri, 30 Aug 2024 10:31:30 +0300
Message-ID: <20240830073130.29982-8-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240830073130.29982-1-michaelgur@nvidia.com>
References: <20240830073130.29982-1-michaelgur@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DM4PR12MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb76bb0-37a9-4de9-821b-08dcc8c5d692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ftHe8cexXUkQbU0Ff7uc6qceflpiZLTJKSPOElXLFx2wppY2xpLA5VcUXWM?=
 =?us-ascii?Q?j58PcpCLwcy24b5JOLTJowAVSJ69rTTJpDLWRRxU2F5QR6BdRaadSRKeZM0E?=
 =?us-ascii?Q?rDxP9bC2mlHdRMPGCgLQCPBIFBmiPdO7gz2Gu7mmx7we9c3GSArnTTi9eAAZ?=
 =?us-ascii?Q?AvN+YMjJNdYI5xDP3U+cH8eMHaLpNxxnb1ARle8O+Jc0VfqnuG+zzuXKv3F+?=
 =?us-ascii?Q?4vmD+0t1H6s1rm+Ib8BPSyUkeX5SGsynIMw7qQujT75WhDpdU7TTTWf8B0AV?=
 =?us-ascii?Q?FgCx4Yt/PlBVo0OVPGO4uvwErPKrSdHb0pBTQYkR7oJkeGZ0pW5NC5hfrCLh?=
 =?us-ascii?Q?Dj3i/tXIw/D+0kLPI0HfDVyrSAw/xvJ0190nyex2hacCM9CZb+hJZlGlHuqm?=
 =?us-ascii?Q?wnYY4nwm8lvHI4DU6LbHlwpjT8FVLCv34TZlPMQd2yP1K9ax5m84f5Oc3kEG?=
 =?us-ascii?Q?MkrpQHX8PplM5lN3N+Zyq65/K9TLwnmg/LT6FmF8RY3cWF3pfB2VkJOtN0b2?=
 =?us-ascii?Q?X43F0JWwI4iNQfIiGwrIOgTrQcmjmYU/ToVQNesXmBUx1jMQifPpurtxb2s2?=
 =?us-ascii?Q?9yJjho+n5fczSCj907+weJ7CpTePg5UP9IAPohJRkfP8xjXvRNXGySUYmGM6?=
 =?us-ascii?Q?Q7vYh/dZy+/b5io2pe57whuvuV30BwFR21n3VcAUVznqh/2QgtHxrUQWudxl?=
 =?us-ascii?Q?gfBZdlKpbOYj6IOukIuAi9elbuYz2lF+5Sk063oHNta3Z2B+skJMFzs/TXpc?=
 =?us-ascii?Q?hW5kbMMuY6uL5gTcz87620HZDmPUU7aB5Cw2CZuTYI/6vChxlalWcOE64LSD?=
 =?us-ascii?Q?86B9jL3TzZwxWml5g4LvgIDuKvNELoYv2Fax0w50wELJoXmGZBv1VywHiUSg?=
 =?us-ascii?Q?RzLOtvzXdteeJETtU6EmCtu26oOADmLH1QQQjca4Bjr9F/O8Ktl6vgr2U6t+?=
 =?us-ascii?Q?Jvf6OmWlgCGwx5ccj1+xlRx40C60x7IsWlmYYkMes6yH2JtS0lWSRcUGGnTZ?=
 =?us-ascii?Q?HiyepVhouYHplBLJxjz4iYZyw6PY5BJIHUoW7xYyzBxSoS/c72rvx1IaWBKH?=
 =?us-ascii?Q?PrYpUPaxv1UKKid5ZJxF7hiEZbLdYOw7mtpaZdVED8LolD9QMKuZ8xGBUGoR?=
 =?us-ascii?Q?dfUCGNH/EhEUZWvMQdVWHootbQmmb0CQ209wKS9RM5S+e+OIKk5Gr9b9rX0E?=
 =?us-ascii?Q?9PhXgZhl5u+beeqyXSPfY0ZtaIn0FwajhzQsyQy9n6STRA1qCR/yqoYmgiCk?=
 =?us-ascii?Q?Rkknvq+QLbNp2jPI5/iWbKzvSZ9b5mbnnRZGFM5jAZjDtp0DZeVGlax+p5ML?=
 =?us-ascii?Q?5cWpprBOFwW8FOypLJGYtj291dFjW+oeWNCYTS1TRFAsRvwN+gzoCoX0O37H?=
 =?us-ascii?Q?wBPSm/4PC06AqwyBG/MK9kqjlTlJe/zKd383W8bqFBc6sB+qUsJPCqEhQI6w?=
 =?us-ascii?Q?+UBQ6t3MoDlzpczKndtje84K9lhLCSrH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 07:32:01.2868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb76bb0-37a9-4de9-821b-08dcc8c5d692
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7504

From: Chiara Meiohas <cmeiohas@nvidia.com>

Extend the "rdma sys" command to display whether RDMA
monitoring is supported.

RDMA monitoring is not supported in mlx4 because it does
not use the ib_device_set_netdev() API, which sends the
RDMA events.

Example output for kernel where monitoring is supported:
$ rdma sys show
netns shared privileged-qkey off monitor on copy-on-fork on

Example output for kernel where monitoring is not supported:
$ rdma sys show
netns shared privileged-qkey off monitor off copy-on-fork on

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 6 ++++++
 include/uapi/rdma/rdma_netlink.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index b0354bb8ba0d..ee19bcd1cb1e 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1952,6 +1952,12 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		nlmsg_free(msg);
 		return err;
 	}
+
+	err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_MONITOR_MODE, 1);
+	if (err) {
+		nlmsg_free(msg);
+		return err;
+	}
 	/*
 	 * Copy-on-fork is supported.
 	 * See commits:
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 5f9636d26050..39be09c0ffbb 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -579,6 +579,7 @@ enum rdma_nldev_attr {
 
 	RDMA_NLDEV_ATTR_EVENT_TYPE,		/* u8 */
 
+	RDMA_NLDEV_SYS_ATTR_MONITOR_MODE,	/* u8 */
 	/*
 	 * Always the end
 	 */
-- 
2.17.2


