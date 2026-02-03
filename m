Return-Path: <linux-rdma+bounces-16409-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLQIAuGfgWkoIAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16409-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:12:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABCCD593A
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95C11300B456
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 07:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD163921C0;
	Tue,  3 Feb 2026 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aTaAiM9a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013062.outbound.protection.outlook.com [40.93.196.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F05D2192EE;
	Tue,  3 Feb 2026 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770102705; cv=fail; b=lrQZfqZVvFKDYaUFYznNqfgrTQSzoaMbRQfEC8S/YAf3L6O/gC7uWMsE/9InxLRE+cTh/7xBzxmGv29y0lpPrpaGsmS3pLaCm3hNlkZMb/j8sdwsHDaykx7cMCzrqOazdEkMq+p1VY1LEhLOQKfFWXrBZ0wsfxUtNJUyRnR1UAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770102705; c=relaxed/simple;
	bh=7zrA6/0Ay0CZ3tMPEfbJYO1ollFqHNQPwVhQFTk4Xj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUyl6jFTqy/W7ZScNGWa7j5mU0ge4jNguETemcoJHQlktIDqvdsTHWFbvAqZ/jE+DdF9VU/D8bgTTMYHt2oeB/Ae4b4i4GRjCmmTL33paNCgHItQ12+7MxKQ61ha9pXSAXzZWFZ8WyoAS1LbEBnpMQl18puDLlF3k/MMyNIJhoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aTaAiM9a; arc=fail smtp.client-ip=40.93.196.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tb9doYt2q6FlrIHlxTgwhFPrt0VkGemHmAijkOy14ns3ai754t+xiH7VA30vi/crVBJu/X49nQERk+ir20QjaQpUSpFLsJPCaYgru4dDUZGsvCqGO5wQ2lLgU+xXhD+vuNtnM5JZclJnEL0kD8omWEFrfughfvxlkddyGb2gvCBweMcLKkvz0dIiJTIlq5oVYs6Vtu7fLoP7nHPhdxkt7s16nYK1Vfrq1LeVN03r+6smnwuGIwbVqKYJ8BlXnGMaJYbMViFj+ef9EsU+ew1j71xRAIl8anUNPcOcy5zrpxpsEqM5A7826W1mK1foyPqacC1AEszixDMPu8gwXIDqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvUxnC66vz/5hqJQ0TOUryNBGbuojbM8qDnaVuYepv0=;
 b=s0jHj9dkjjrtYuZrbk8tYPhC0x95HdG2I7PHUqB6/F0tb36WUU+Ku31a2FKWaTF5tqVxsGQz/EQNFqtS+ywx6oYBdTgcqhZNdCmgzAX9JMZ89J3swc9NH3M5qFRkP1LS/a+DrX6LJChVrwL758YQNYN+PLIK/kXfzLkIhOrvDPKYtkuGJr8gdEYSz4PAnf6J2O2cHFeR7n9dW/UqjU4vcdw9d0fvROF6jZsVpxmyjGeo7tb7Yh8cek51gTJirX1GwMljRDOgT3fRq8w+9QCyATSuE7WihAe5cCWICwKuCaiub2XWEdHl9HatTNQ1xkgPVHJs+HS9xOmsSAEl24RsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvUxnC66vz/5hqJQ0TOUryNBGbuojbM8qDnaVuYepv0=;
 b=aTaAiM9acc96Mj8kN6GyoH6BQUIn9y/IqXVb5ozK2dCv3kd6u0MkTiRzYaeZ27m5sluLLeVhpRXEs/BTUp2D9YspMWttY46Mmi7eUEOU0E6m4vQ/EFUwQaQlE+r36phi5mQkMv620RUJH0NlRXdTxupS3xCAFa0vhYr6tcpWR+r8KDmDG/oVQ2kh2+gCTGsWTDgA6fWijO1oencjFzxxoyixocelABJ8MzY0XxlLRJABRnxs3rPw7NYw/bXZDGUJNW4MKrwAVoDHjwBi1jks1I/NIqvUSmp96JxGZ6zNBcW4DJMdcR2C5zHMScZKD1x420XEYUMiYZuOxagFydRcGA==
Received: from DM6PR01CA0012.prod.exchangelabs.com (2603:10b6:5:296::17) by
 SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Tue, 3 Feb 2026 07:11:31 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:296:cafe::7) by DM6PR01CA0012.outlook.office365.com
 (2603:10b6:5:296::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend
 Transport; Tue, 3 Feb 2026 07:11:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:11:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:11:15 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:11:14 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 2 Feb
 2026 23:11:09 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>
Subject: [PATCH net-next 1/5] devlink: Add port-level resource infrastructure
Date: Tue, 3 Feb 2026 09:10:29 +0200
Message-ID: <20260203071033.1709445-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260203071033.1709445-1-tariqt@nvidia.com>
References: <20260203071033.1709445-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 605cdc84-b375-4dcc-d60c-08de62f3752f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xvIusCj95u/Bc4m14xS+taqWx/kNR1T0yV5yeFI3s8lY+n3DjtJUJb8g5ZD6?=
 =?us-ascii?Q?beFybwnYjsELiJCNCcgeeWoVMgpxUMPYdB/SjlHCqPhtDnOh9o4lsgc2zc9o?=
 =?us-ascii?Q?xmNlLuwBScX3tYOHm2AyusOtmEi/XR+6e0O/5SYSJ0vxkbcAJCKg7bUXuNCe?=
 =?us-ascii?Q?bBiMId/o5ERgN4eYwEtahHdiFjVunen1L6uGe4cH04D3bcjo2YdGG/+DyD6a?=
 =?us-ascii?Q?jc6lGLqapTYkglg1DiUaWlqix3qhnMI7hOMidwgH/tUwdjwaBUpa5t9ZO9fM?=
 =?us-ascii?Q?hNn46Q+55/XzOSxYTsCTGpVCZVcD+vkGbkUx23xaVi1wLWqEkrKWKT0vOy8i?=
 =?us-ascii?Q?md8G5YhzqJuANDaHgNakXwO6azEifvcthI7785rbbNpUQFlHfipzoqxviY8q?=
 =?us-ascii?Q?gyGoqCST63VNbYqAx00hAyWE+cOBbB+YL7SZTnQQ3PXK2ta32bhtCIpmdWK9?=
 =?us-ascii?Q?ME2/zXVNwWqtaPVbLcrnTnAxRrBOPUzxAjZR04/39lzMSS+PWK2v8SPJ0ZMr?=
 =?us-ascii?Q?tMlDnsxjTFgMLGwh+KLw2p8wg9BUcBFNQtQTaxnBqATFSfFxon+S+RBvDNjF?=
 =?us-ascii?Q?sVePIG3FK/dsjYQZuG9OxMIGDcIzoXigpE7pl78I5+nTq+WGFik2357GGNoj?=
 =?us-ascii?Q?zYfMMnNjpqYN0R3+d5QU4SLm1KRspDUF3i8tgkf0LEMSgqNTyYKTkDieDTYs?=
 =?us-ascii?Q?XENmW7NePbnqObJtAi9QtkO+HYLquaTXWiDo47XWXxNWTKI6b5aASt86xeS8?=
 =?us-ascii?Q?JjPAZvgLKNDlZWmcKctEI1+1LHktDUVr87kaIAm0cH4fXq6jOtUXtXblqA6E?=
 =?us-ascii?Q?+zer/3hef9Tiaos9a2TtjgGW+HjravicxiNOsMxXWOz4Mmp9u4Hz34CToM8x?=
 =?us-ascii?Q?V1C4hkXxCcogS+BISBTDql7euYENh5pksQiuCLORUEV22WP9Wflzis+TA6ie?=
 =?us-ascii?Q?mlijuLAROIQUAfkPgVgPZQHls9yO7Y5CnRKW/tO7+IQQTG8ossh4USL1fMAf?=
 =?us-ascii?Q?s/t/IjoPRs9fUhh2nWYNfcabHTgE9/NDhrsP3roHhYWCwMv4e9IAPVxiC8Gq?=
 =?us-ascii?Q?wOcN9dZNa+vNXihEqMSsTYNGd1XY/bEB4PWf29LI3lmOjLyXCZgcSD/6jJu7?=
 =?us-ascii?Q?QY17vuyLI4pgAfvKjICUG2wEyHcLqGBcvvQSMKwKusPq0VGCGYReGTfYnpsR?=
 =?us-ascii?Q?Tvwl3J9CGguwBxjRXjZWmD889hK5thht/Zn27EfLpeYA1YaxPvzsGT9L0R94?=
 =?us-ascii?Q?UsamULMkZ42iHRfh9E7kDEy20ei3Ls2KJHHiRDSOqzPzj2PkpirS9GNdnDIy?=
 =?us-ascii?Q?rDT4VmDsIoBrIRLnvzT8uf5e8i/0OOWOHMv/QcsrSFe2UufOgr12ZSzuTl2i?=
 =?us-ascii?Q?gLjlw2dVwaCRK8gse+C4/i5IGPQ/o96ZZhLxe8yb4vNHbwA+/ySKhtKgLxgh?=
 =?us-ascii?Q?Ox50F/oQyOcabC/98d2egQZsX6XOn/6QFOUsCEc+C7vuS09PWsRcaTkU72+a?=
 =?us-ascii?Q?/acXx7MjXTp6h+qrZuDmMvdB94ujRgrFyB0+Q2HHNDhz3V1CHGYSwAVZFyOe?=
 =?us-ascii?Q?CAdOUvQM+JZPMVCRzmaeHuTYW4rfSj8L0YjzPSvWv8dFwG7/JJu6QJ5tcWTb?=
 =?us-ascii?Q?xNDorWCf6IUSTTTBW2WycwNoIFtVWNLYcn8zUcboCzeFuJZM0R9v4XwhUVQW?=
 =?us-ascii?Q?mdkcmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	481BhEc6qaRd32cMex5jZgtJlLK+LGfPcLKbDrdqckErqdqeQ4Q4aQmVzVW5XpTt9nxLncr36RE4TUSqpNel7NE6b0A9/l12/Sv86rKWHDgQfDeksJBK0JYbBCvS+AU2gS7+ySyKdPKTSu3K2SozGl/lvQXymlhyXQMqRFTGtcKZ0faubYBbmCgYPI5Vhgi2TiLk8phwkk1/neBggruc0lL5dEJTGRMVtu82eS0u1iAk2HYX+Uoutxii5P+8XW3wt4s0RawQzm4L1VBngI3zV6Nb7AfzCm4yPRPbuVxyrSRc2CBsTG/e4lFc8lLd4qMorfdoNh86VHIp9YnquviyHVHDGW+0aw+N3h3udtzs2apf6sAF4A7rMW1rYZe3rFLNcN1ySt+dJWc2/Z6GnKpmXT+/sN6A2/oRlIBHSweiNPPEIc/JdZj83YUv8fwFi/l9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:11:31.4246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 605cdc84-b375-4dcc-d60c-08de62f3752f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16409-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3ABCCD593A
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

The current devlink resource infrastructure only supports device-level
resources. Some hardware resources are associated with specific ports
rather than the entire device, and today we have no way to show resource
per-port.

Add support for registering and querying resources at the port level,
allowing drivers to expose per-port resource limits and usage.

Example output:

  $ devlink port resource show
  pci/0000:03:00.0/196608:
    name max_SFs size 20 unit entry
  pci/0000:03:00.1/262144:
    name max_SFs size 20 unit entry

  $ devlink port resource show pci/0000:03:00.0/196608
  pci/0000:03:00.0/196608:
    name max_SFs size 20 unit entry

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml |  23 ++
 include/net/devlink.h                    |   8 +
 include/uapi/linux/devlink.h             |   2 +
 net/devlink/netlink.c                    |   2 +-
 net/devlink/netlink_gen.c                |  32 ++-
 net/devlink/netlink_gen.h                |   6 +-
 net/devlink/port.c                       |   3 +
 net/devlink/resource.c                   | 282 ++++++++++++++++++-----
 8 files changed, 301 insertions(+), 57 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 837112da6738..0290db1b8393 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2336,3 +2336,26 @@ operations:
             - bus-name
             - dev-name
             - port-index
+
+    -
+      name: port-resource-get
+      doc: Get port resources.
+      attribute-set: devlink
+      dont-validate: [strict]
+      do:
+        pre: devlink-nl-pre-doit-port
+        post: devlink-nl-post-doit
+        request:
+          value: 85
+          attributes: *port-id-attrs
+        reply: &port-resource-get-reply
+          value: 85
+          attributes:
+            - bus-name
+            - dev-name
+            - port-index
+            - resource-list
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *port-resource-get-reply
diff --git a/include/net/devlink.h b/include/net/devlink.h
index cb839e0435a1..40335ecc3343 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -129,6 +129,7 @@ struct devlink_rate {
 struct devlink_port {
 	struct list_head list;
 	struct list_head region_list;
+	struct list_head resource_list;
 	struct devlink *devlink;
 	const struct devlink_port_ops *ops;
 	unsigned int index;
@@ -1881,6 +1882,13 @@ void devlink_resources_unregister(struct devlink *devlink);
 int devl_resource_size_get(struct devlink *devlink,
 			   u64 resource_id,
 			   u64 *p_resource_size);
+int
+devl_port_resource_register(struct devlink_port *devlink_port,
+			    const char *resource_name,
+			    u64 resource_size, u64 resource_id,
+			    u64 parent_resource_id,
+			    const struct devlink_resource_size_params *params);
+void devl_port_resources_unregister(struct devlink_port *devlink_port);
 int devl_dpipe_table_resource_set(struct devlink *devlink,
 				  const char *table_name, u64 resource_id,
 				  u64 resource_units);
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e7d6b6d13470..74a541013af6 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -141,6 +141,8 @@ enum devlink_command {
 
 	DEVLINK_CMD_NOTIFY_FILTER_SET,
 
+	DEVLINK_CMD_PORT_RESOURCE_GET,	/* can dump */
+
 	/* add new commands above here */
 	__DEVLINK_CMD_MAX,
 	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 593605c1b1ef..c78c31779622 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -367,7 +367,7 @@ struct genl_family devlink_nl_family __ro_after_init = {
 	.module		= THIS_MODULE,
 	.split_ops	= devlink_nl_ops,
 	.n_split_ops	= ARRAY_SIZE(devlink_nl_ops),
-	.resv_start_op	= DEVLINK_CMD_SELFTESTS_RUN + 1,
+	.resv_start_op	= DEVLINK_CMD_PORT_RESOURCE_GET + 1,
 	.mcgrps		= devlink_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(devlink_nl_mcgrps),
 	.sock_priv_size		= sizeof(struct devlink_nl_sock_priv),
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f4c61c2b4f22..692d7862183a 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -604,8 +604,21 @@ static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
+/* DEVLINK_CMD_PORT_RESOURCE_GET - do */
+static const struct nla_policy devlink_port_resource_get_do_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
+};
+
+/* DEVLINK_CMD_PORT_RESOURCE_GET - dump */
+static const struct nla_policy devlink_port_resource_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 /* Ops table for devlink */
-const struct genl_split_ops devlink_nl_ops[74] = {
+const struct genl_split_ops devlink_nl_ops[76] = {
 	{
 		.cmd		= DEVLINK_CMD_GET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
@@ -1284,4 +1297,21 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DEVLINK_CMD_PORT_RESOURCE_GET,
+		.validate	= GENL_DONT_VALIDATE_STRICT,
+		.pre_doit	= devlink_nl_pre_doit_port,
+		.doit		= devlink_nl_port_resource_get_doit,
+		.post_doit	= devlink_nl_post_doit,
+		.policy		= devlink_port_resource_get_do_nl_policy,
+		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= DEVLINK_CMD_PORT_RESOURCE_GET,
+		.dumpit		= devlink_nl_port_resource_get_dumpit,
+		.policy		= devlink_port_resource_get_dump_nl_policy,
+		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
 };
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 2817d53a0eba..204a665d2fd2 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -18,7 +18,7 @@ extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
-extern const struct genl_split_ops devlink_nl_ops[74];
+extern const struct genl_split_ops devlink_nl_ops[76];
 
 int devlink_nl_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 			struct genl_info *info);
@@ -146,5 +146,9 @@ int devlink_nl_selftests_get_dumpit(struct sk_buff *skb,
 int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
 				      struct genl_info *info);
+int devlink_nl_port_resource_get_doit(struct sk_buff *skb,
+				      struct genl_info *info);
+int devlink_nl_port_resource_get_dumpit(struct sk_buff *skb,
+					struct netlink_callback *cb);
 
 #endif /* _LINUX_DEVLINK_GEN_H */
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 93d8a25bb920..10d0d88894a3 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -1024,6 +1024,7 @@ void devlink_port_init(struct devlink *devlink,
 		return;
 	devlink_port->devlink = devlink;
 	INIT_LIST_HEAD(&devlink_port->region_list);
+	INIT_LIST_HEAD(&devlink_port->resource_list);
 	devlink_port->initialized = true;
 }
 EXPORT_SYMBOL_GPL(devlink_port_init);
@@ -1041,6 +1042,7 @@ EXPORT_SYMBOL_GPL(devlink_port_init);
 void devlink_port_fini(struct devlink_port *devlink_port)
 {
 	WARN_ON(!list_empty(&devlink_port->region_list));
+	WARN_ON(!list_empty(&devlink_port->resource_list));
 }
 EXPORT_SYMBOL_GPL(devlink_port_fini);
 
@@ -1135,6 +1137,7 @@ void devl_port_unregister(struct devlink_port *devlink_port)
 	devlink_port_notify(devlink_port, DEVLINK_CMD_PORT_DEL);
 	xa_erase(&devlink_port->devlink->ports, devlink_port->index);
 	WARN_ON(!list_empty(&devlink_port->reporter_list));
+	devlink_port_fini(devlink_port);
 	devlink_port->registered = false;
 }
 EXPORT_SYMBOL_GPL(devl_port_unregister);
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 2d6324f3d91f..1c563c76ddb6 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -36,15 +36,16 @@ struct devlink_resource {
 };
 
 static struct devlink_resource *
-devlink_resource_find(struct devlink *devlink,
-		      struct devlink_resource *resource, u64 resource_id)
+devlink_resource_find_by_list(struct list_head *res_list_head,
+			      struct devlink_resource *resource,
+			      u64 resource_id)
 {
 	struct list_head *resource_list;
 
 	if (resource)
 		resource_list = &resource->resource_list;
 	else
-		resource_list = &devlink->resource_list;
+		resource_list = res_list_head;
 
 	list_for_each_entry(resource, resource_list, list) {
 		struct devlink_resource *child_resource;
@@ -52,14 +53,23 @@ devlink_resource_find(struct devlink *devlink,
 		if (resource->id == resource_id)
 			return resource;
 
-		child_resource = devlink_resource_find(devlink, resource,
-						       resource_id);
+		child_resource = devlink_resource_find_by_list(res_list_head,
+							       resource,
+							       resource_id);
 		if (child_resource)
 			return child_resource;
 	}
 	return NULL;
 }
 
+static struct devlink_resource *
+devlink_resource_find(struct devlink *devlink,
+		      struct devlink_resource *resource, u64 resource_id)
+{
+	return devlink_resource_find_by_list(&devlink->resource_list,
+					     resource, resource_id);
+}
+
 static void
 devlink_resource_validate_children(struct devlink_resource *resource)
 {
@@ -214,8 +224,10 @@ static int devlink_resource_put(struct devlink *devlink, struct sk_buff *skb,
 }
 
 static int devlink_resource_fill(struct genl_info *info,
+				 struct list_head *resource_list,
 				 enum devlink_command cmd, int flags)
 {
+	struct devlink_port *devlink_port = info->user_ptr[1];
 	struct devlink *devlink = info->user_ptr[0];
 	struct devlink_resource *resource;
 	struct nlattr *resources_attr;
@@ -226,8 +238,11 @@ static int devlink_resource_fill(struct genl_info *info,
 	int i;
 	int err;
 
-	resource = list_first_entry(&devlink->resource_list,
-				    struct devlink_resource, list);
+	if (list_empty(resource_list))
+		return -EOPNOTSUPP;
+
+	resource = list_first_entry(resource_list, struct devlink_resource,
+				    list);
 start_again:
 	err = devlink_nl_msg_reply_and_new(&skb, info);
 	if (err)
@@ -243,6 +258,10 @@ static int devlink_resource_fill(struct genl_info *info,
 	if (devlink_nl_put_handle(skb, devlink))
 		goto nla_put_failure;
 
+	if (devlink_port && nla_put_u32(skb, DEVLINK_ATTR_PORT_INDEX,
+					devlink_port->index))
+		goto nla_put_failure;
+
 	resources_attr = nla_nest_start_noflag(skb,
 					       DEVLINK_ATTR_RESOURCE_LIST);
 	if (!resources_attr)
@@ -250,7 +269,7 @@ static int devlink_resource_fill(struct genl_info *info,
 
 	incomplete = false;
 	i = 0;
-	list_for_each_entry_from(resource, &devlink->resource_list, list) {
+	list_for_each_entry_from(resource, resource_list, list) {
 		err = devlink_resource_put(devlink, skb, resource);
 		if (err) {
 			if (!i)
@@ -286,10 +305,8 @@ int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct devlink *devlink = info->user_ptr[0];
 
-	if (list_empty(&devlink->resource_list))
-		return -EOPNOTSUPP;
-
-	return devlink_resource_fill(info, DEVLINK_CMD_RESOURCE_DUMP, 0);
+	return devlink_resource_fill(info, &devlink->resource_list,
+				     DEVLINK_CMD_RESOURCE_DUMP, 0);
 }
 
 int devlink_resources_validate(struct devlink *devlink,
@@ -314,26 +331,12 @@ int devlink_resources_validate(struct devlink *devlink,
 	return err;
 }
 
-/**
- * devl_resource_register - devlink resource register
- *
- * @devlink: devlink
- * @resource_name: resource's name
- * @resource_size: resource's size
- * @resource_id: resource's id
- * @parent_resource_id: resource's parent id
- * @size_params: size parameters
- *
- * Generic resources should reuse the same names across drivers.
- * Please see the generic resources list at:
- * Documentation/networking/devlink/devlink-resource.rst
- */
-int devl_resource_register(struct devlink *devlink,
-			   const char *resource_name,
-			   u64 resource_size,
-			   u64 resource_id,
-			   u64 parent_resource_id,
-			   const struct devlink_resource_size_params *size_params)
+static int
+devl_resource_reg_by_list(struct devlink *devlink,
+			  struct list_head *res_list_head,
+			  const char *resource_name, u64 resource_size,
+			  u64 resource_id, u64 parent_res_id,
+			  const struct devlink_resource_size_params *params)
 {
 	struct devlink_resource *resource;
 	struct list_head *resource_list;
@@ -341,9 +344,10 @@ int devl_resource_register(struct devlink *devlink,
 
 	lockdep_assert_held(&devlink->lock);
 
-	top_hierarchy = parent_resource_id == DEVLINK_RESOURCE_ID_PARENT_TOP;
+	top_hierarchy = parent_res_id == DEVLINK_RESOURCE_ID_PARENT_TOP;
 
-	resource = devlink_resource_find(devlink, NULL, resource_id);
+	resource = devlink_resource_find_by_list(res_list_head, NULL,
+						 resource_id);
 	if (resource)
 		return -EEXIST;
 
@@ -352,15 +356,15 @@ int devl_resource_register(struct devlink *devlink,
 		return -ENOMEM;
 
 	if (top_hierarchy) {
-		resource_list = &devlink->resource_list;
+		resource_list = res_list_head;
 	} else {
-		struct devlink_resource *parent_resource;
+		struct devlink_resource *parent_res;
 
-		parent_resource = devlink_resource_find(devlink, NULL,
-							parent_resource_id);
-		if (parent_resource) {
-			resource_list = &parent_resource->resource_list;
-			resource->parent = parent_resource;
+		parent_res = devlink_resource_find_by_list(res_list_head, NULL,
+							   parent_res_id);
+		if (parent_res) {
+			resource_list = &parent_res->resource_list;
+			resource->parent = parent_res;
 		} else {
 			kfree(resource);
 			return -EINVAL;
@@ -372,46 +376,78 @@ int devl_resource_register(struct devlink *devlink,
 	resource->size_new = resource_size;
 	resource->id = resource_id;
 	resource->size_valid = true;
-	memcpy(&resource->size_params, size_params,
-	       sizeof(resource->size_params));
+	memcpy(&resource->size_params, params, sizeof(resource->size_params));
 	INIT_LIST_HEAD(&resource->resource_list);
 	list_add_tail(&resource->list, resource_list);
 
 	return 0;
 }
+
+/**
+ * devl_resource_register - devlink resource register
+ *
+ * @devlink: devlink
+ * @resource_name: resource's name
+ * @resource_size: resource's size
+ * @resource_id: resource's id
+ * @parent_resource_id: resource's parent id
+ * @params: size parameters
+ *
+ * Generic resources should reuse the same names across drivers.
+ * Please see the generic resources list at:
+ * Documentation/networking/devlink/devlink-resource.rst
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int devl_resource_register(struct devlink *devlink, const char *resource_name,
+			   u64 resource_size, u64 resource_id,
+			   u64 parent_resource_id,
+			   const struct devlink_resource_size_params *params)
+{
+	return devl_resource_reg_by_list(devlink, &devlink->resource_list,
+					      resource_name, resource_size,
+					      resource_id, parent_resource_id,
+					      params);
+}
 EXPORT_SYMBOL_GPL(devl_resource_register);
 
-static void devlink_resource_unregister(struct devlink *devlink,
-					struct devlink_resource *resource)
+static void devlink_resource_unregister(struct devlink_resource *resource)
 {
 	struct devlink_resource *tmp, *child_resource;
 
 	list_for_each_entry_safe(child_resource, tmp, &resource->resource_list,
 				 list) {
-		devlink_resource_unregister(devlink, child_resource);
+		devlink_resource_unregister(child_resource);
 		list_del(&child_resource->list);
 		kfree(child_resource);
 	}
 }
 
-/**
- * devl_resources_unregister - free all resources
- *
- * @devlink: devlink
- */
-void devl_resources_unregister(struct devlink *devlink)
+static void
+devl_resources_unregister_by_list(struct devlink *devlink,
+				  struct list_head *res_list_head)
 {
 	struct devlink_resource *tmp, *child_resource;
 
 	lockdep_assert_held(&devlink->lock);
 
-	list_for_each_entry_safe(child_resource, tmp, &devlink->resource_list,
+	list_for_each_entry_safe(child_resource, tmp, res_list_head,
 				 list) {
-		devlink_resource_unregister(devlink, child_resource);
+		devlink_resource_unregister(child_resource);
 		list_del(&child_resource->list);
 		kfree(child_resource);
 	}
 }
+
+/**
+ * devl_resources_unregister - free all resources
+ *
+ * @devlink: devlink
+ */
+void devl_resources_unregister(struct devlink *devlink)
+{
+	devl_resources_unregister_by_list(devlink, &devlink->resource_list);
+}
 EXPORT_SYMBOL_GPL(devl_resources_unregister);
 
 /**
@@ -502,3 +538,141 @@ void devl_resource_occ_get_unregister(struct devlink *devlink,
 	resource->occ_get_priv = NULL;
 }
 EXPORT_SYMBOL_GPL(devl_resource_occ_get_unregister);
+
+/**
+ * devl_port_resource_register - devlink port resource register
+ *
+ * @devlink_port: devlink port
+ * @resource_name: resource's name
+ * @resource_size: resource's size
+ * @resource_id: resource's id
+ * @parent_resource_id: resource's parent id
+ * @params: size parameters for the resource
+ *
+ * Generic resources should reuse the same names across drivers.
+ * Please see the generic resources list at:
+ * Documentation/networking/devlink/devlink-resource.rst
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int
+devl_port_resource_register(struct devlink_port *devlink_port,
+			    const char *resource_name,
+			    u64 resource_size, u64 resource_id,
+			    u64 parent_resource_id,
+			    const struct devlink_resource_size_params *params)
+{
+	return devl_resource_reg_by_list(devlink_port->devlink,
+					 &devlink_port->resource_list,
+					 resource_name, resource_size,
+					 resource_id, parent_resource_id,
+					 params);
+}
+EXPORT_SYMBOL_GPL(devl_port_resource_register);
+
+/**
+ * devl_port_resources_unregister - unregister all devlink port resources
+ *
+ * @devlink_port: devlink port
+ */
+void devl_port_resources_unregister(struct devlink_port *devlink_port)
+{
+	devl_resources_unregister_by_list(devlink_port->devlink,
+					  &devlink_port->resource_list);
+}
+EXPORT_SYMBOL_GPL(devl_port_resources_unregister);
+
+static int devlink_nl_port_resource_fill(struct sk_buff *msg,
+					 struct devlink_port *devlink_port,
+					 enum devlink_command cmd,
+					 u32 portid, u32 seq, int flags)
+{
+	struct devlink *devlink = devlink_port->devlink;
+	struct devlink_resource *resource;
+	struct nlattr *resources_attr;
+	void *hdr;
+
+	if (list_empty(&devlink_port->resource_list))
+		return 0;
+
+	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (devlink_nl_put_handle(msg, devlink))
+		goto nla_put_failure;
+	if (nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX, devlink_port->index))
+		goto nla_put_failure;
+
+	resources_attr = nla_nest_start_noflag(msg, DEVLINK_ATTR_RESOURCE_LIST);
+	if (!resources_attr)
+		goto nla_put_failure;
+
+	list_for_each_entry(resource, &devlink_port->resource_list, list) {
+		if (devlink_resource_put(devlink, msg, resource)) {
+			nla_nest_cancel(msg, resources_attr);
+			goto nla_put_failure;
+		}
+	}
+	nla_nest_end(msg, resources_attr);
+	genlmsg_end(msg, hdr);
+	return 0;
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+int devlink_nl_port_resource_get_doit(struct sk_buff *skb,
+				      struct genl_info *info)
+{
+	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct sk_buff *msg;
+	int err;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	err = devlink_nl_port_resource_fill(msg, devlink_port,
+					    DEVLINK_CMD_PORT_RESOURCE_GET,
+					    info->snd_portid, info->snd_seq, 0);
+	if (err) {
+		nlmsg_free(msg);
+		return err;
+	}
+
+	return genlmsg_reply(msg, info);
+}
+
+static int
+devlink_nl_port_resource_get_dump_one(struct sk_buff *msg,
+				      struct devlink *devlink,
+				      struct netlink_callback *cb, int flags)
+{
+	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
+	u32 cmd = DEVLINK_CMD_PORT_RESOURCE_GET;
+	struct devlink_port *devlink_port;
+	unsigned long port_index;
+	int err;
+
+	xa_for_each_start(&devlink->ports, port_index, devlink_port,
+			  state->idx) {
+		err = devlink_nl_port_resource_fill(msg, devlink_port, cmd,
+						    NETLINK_CB(cb->skb).portid,
+						    cb->nlh->nlmsg_seq, flags);
+		if (err) {
+			state->idx = port_index;
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+int devlink_nl_port_resource_get_dumpit(struct sk_buff *skb,
+					struct netlink_callback *cb)
+{
+	return devlink_nl_dumpit(skb, cb,
+				 devlink_nl_port_resource_get_dump_one);
+}
-- 
2.40.1


