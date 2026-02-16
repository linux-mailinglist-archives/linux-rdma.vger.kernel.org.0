Return-Path: <linux-rdma+bounces-16910-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCrVJR/bkmn3zAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16910-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 09:53:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1A2141B4C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 09:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3F3E30398A7
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 08:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF76B2798EA;
	Mon, 16 Feb 2026 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="G5UFEDsk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010034.outbound.protection.outlook.com [52.101.69.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DF0277026;
	Mon, 16 Feb 2026 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771231940; cv=fail; b=SLNCHG6XE7JTT7vzhu9WOgi/47EstmSUL/jhdYbXqHvy7e6wzH0rwaVfRE30aPACZJRihZpXWJzP8FukneqsMrkOfs9/iv/4sMwLQFheU1Om0bFjgLk4w8cyecAjyEHFrPzxzcTbsoMxvXPjVR7bHrPPkGzTNRAiwbnnCVQKS2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771231940; c=relaxed/simple;
	bh=E57Il8yBHHYIfeP7ALxpJaw7m/8SoMUsbIDPp7+AHqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAs+oX7FoF90zckCq1fgQMKtgOltTgAelaY2kk8UZsv0ZrcVRGW7TOY8qsXls/cmSiWDuMqfRBlvD/PX6tvlvwcaK9uA3+mrlohBSMgflzPrSjRY4WLFRHDNvjkVmF+t4Q1QeMjtK5Vh0fXCBUv/ipKbNdLdgKmzWIKy1+pLk2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=G5UFEDsk; arc=fail smtp.client-ip=52.101.69.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOUlL7lI0d2i6oi7iJZSD9OrUYgfk/e670zAuKDxAOUT6F0vjlpXXQrbaPgOgyuDWxWa5q9ReVutSTOM+P59GJaWo3KaatPBObkrb99P866jQWGv+YIK8CnJGGow1S0HWbjIf6W8NwBQVgMcNBWcmtrMLSVhFJ6JxPE8ZULK4mSzG2BAvmiVF3qXQugFgB/DQd3p94v+pn8JkVF4zFYN6TK7WRc8zK5IYY/Apkhxmf9nooe5N8kBbKqV1sDjQAS6O5Bb3dTK8qSEHL/YSmkjIsK0zgjnXswiDvkLyJhMpQtOPilTgiqDffXX3HPyHB0ehS8edwF4pBcdDFZp/yYX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtkVfM/eN0krvrljSOpWjfYXQSzzIUmrwGxdTXMkMFA=;
 b=yvwNLtnGoD51n4Xn+8glFxOauH9tlsk9S6DQ34gakSRqC1csyZjejUqP1IGQ4UodR7xLADspFfj1dlvXJ61S+5JhrKr9S0KgAiOLdUNZcVHDkJMt6ZA23dyuu0mjrbsslPWgynLwBkWqZbdK70ZvMF1hR2lAWmvBjMvBvhi1GRuCm0tYGpjh+0muyM4eBZ2kWkKwrLxedJPQbITbE0T/PXV9PTqWkXnvNelvR7cEWFDgGEmrIH/HbMQqo9WciPZkeiPG/CEVxuI5Whglgf8v0sedQ6IZSz4LTsZxJNDNl/tbf/gmvwW93OK0LaXnvpZ15SQii1dsyemDQYkmDst1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtkVfM/eN0krvrljSOpWjfYXQSzzIUmrwGxdTXMkMFA=;
 b=G5UFEDsknp77xPsUH1SToxLk2aUjRYNrONiwHUZvb3OqBh1bTZbukn51r+xGkV+TN6eYup84xyOrpfesW2wfnoGaiBiBLH8Nnrj2c8TnM/LyqRFHAX/hLiv8idIHcikVzIeJxk8sqUun61hxMv2wCDdys0AKjkz+YcDwbx4wrY1HmzSGqYz7YhqmFvJcpzcyvHP2jiMqYEejGHOb3Q14lxBMsgeMGzJtK86lttt4OBglX3RQb5TWfxW1G9uZszJph9N4IFaZXbU20dHRqp6ieNwsTqRIKDgetD4tyyHEFzy6GI1v7etAoxgeDRS5JkLYx602nTU05LwmOwXACUdf/A==
Received: from DUZP191CA0066.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::9) by
 FRWPR07MB10660.eurprd07.prod.outlook.com (2603:10a6:d10:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 08:52:14 +0000
Received: from DB5PEPF00014B9A.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::dc) by DUZP191CA0066.outlook.office365.com
 (2603:10a6:10:4fa::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 08:52:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B9A.mail.protection.outlook.com (10.167.8.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Mon, 16 Feb 2026 08:52:13 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 84A611C0030;
	Mon, 16 Feb 2026 10:52:12 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: linyunsheng@huawei.com,
	andrew+netdev@lunn.ch,
	parav@nvidia.com,
	jasowang@redhat.com,
	mst@redhat.com,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leonro@nvidia.com,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net 3/3] net: hns3: fix CWR handling in drivers to preserve ACE signal
Date: Mon, 16 Feb 2026 09:51:43 +0100
Message-Id: <20260216085143.40242-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216085143.40242-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260216085143.40242-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9A:EE_|FRWPR07MB10660:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 876fd65b-904e-4f9a-25d6-08de6d38ae28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FT9ZItt6egAS7/+oAhaDba8yKWQ1TiGzZ9m/YEFwj9IPNVZBULD0qqvhkPHj?=
 =?us-ascii?Q?tUjobVUTNRZImazv+oeO5uFMskcCanNT0DCBaiXvOnp6Ok5lRIzIb+EnwMUm?=
 =?us-ascii?Q?HsLYqTG2t4rIzSrSbQCrBtPuuZnqEsuTJm8tn/7aOJpBA84QRt3qfM42NBaE?=
 =?us-ascii?Q?40ybGV6VPsuXLo6DRNCR7k0m4XNcI+/QCnnNTp7JKZ4NOMTNzmBTjexir/ww?=
 =?us-ascii?Q?YDl+YQeGKJ8M84L4zCIasKoDWjQvjG2lEmUbOkPgCxRMQKtPf/Rwqdx76Rk3?=
 =?us-ascii?Q?Eq0X5rP12GjgHiBGbT/ITrZ02RaTxclehUQFKAiIT4Ks7TkV5QEhFlqNshct?=
 =?us-ascii?Q?Ezg+KhVi0TYF5QFxzFZR6Udbm7sjJ0r0m5gxb8Obs/tzlQ/lc19IOkiLJ6TZ?=
 =?us-ascii?Q?4v5TccBk23PzRiT18b5cDByphp3fgQKeZx1qoOcbFESOMMMFpu6bF056sopw?=
 =?us-ascii?Q?gPLcNDp441JugMlidsip6NITC470Urcdy2updkSZt2WsA82ZKWqPj0xPojbi?=
 =?us-ascii?Q?2nfd6Wp07fFF4oSA2LOM2TcYi1rbslBdMLOeOSorltiplK0EBfzKe6LKKd3e?=
 =?us-ascii?Q?Px+Y6M19SEiAEFF2Mr2cUjOFMcSKOEvQ56058yxZpJYBBaZdpdFoUjvcOIWh?=
 =?us-ascii?Q?xSsY4dN4NXMr5/fZnZEFi4osUqBV5ly3q8vGNThTOaqVhR4qunoiA7hJKuXT?=
 =?us-ascii?Q?F+cdiS6jyXu5PdmMG05aJ7rtilomykjiVGpUg2DYts+GSt33cyBzcewywSda?=
 =?us-ascii?Q?lFMdGRVWdbgdxETu37axdUoRflTdvOY8wr2F2+y4XaJUOtwzXFAwEf58XFId?=
 =?us-ascii?Q?fw+pGyWDzuOXEls9+pFJ4q1KVoLKRmkxLJ6HbCqiRMFp9+vWYm2WWkSSXtr5?=
 =?us-ascii?Q?vr9N349qXq5+WMJibPWBZhZT53khyI/4UOaa4QTqXe//oKOyOm3q/N+3HQHk?=
 =?us-ascii?Q?1u7sfjMFWRNrnkE/lS7VKxJj1Pxo9hzLNNXM/HA2tcyUkIC1smQ+jSJ8w8XS?=
 =?us-ascii?Q?AaI6QQT3dQkL4S5i6bFjyFsKUlCBptsv6rMaW0NfSqkgrEeeAnxsTO9YW2a0?=
 =?us-ascii?Q?e6ZLcGyPcjVmDCIeX2D4Z6dwS5+foaJFIsfyPdwDbDlbxK65TmL0Nalhg6ny?=
 =?us-ascii?Q?VAikwLrTiBBAhnWvSukR3TgG9UBlQUXTyB7hRvwXIPT58F90WAi4CzyESSsa?=
 =?us-ascii?Q?9GgwZFO29JBX91Vmgd1J7LQrwThiTb2q3qFbjGLE1+poCwjJwobfKK2qpIJs?=
 =?us-ascii?Q?Px6ErXWkemKc+sOQYFEa7M+VZ/HGRyJYPaR2KPAOHpnXEVD3blBa9oHK/SSc?=
 =?us-ascii?Q?h6J87BlaEk4BrW+H/gqFr3UE9PXa5VWckYFRnnoX5WqwcWVqd6OE/0WWvzrI?=
 =?us-ascii?Q?5qfUwiKBBJ0gxUI+IRnGpKxxbxd96hNL7kKARpx39GGZ1YwGTvRz7XC91oIi?=
 =?us-ascii?Q?1biTO/ZViHpPgasbzElNJeMLZLjuaJAdu4N5ibrrVLY9xjhvVds/VGR4oQVX?=
 =?us-ascii?Q?BVYZAIeE6Jy4XhQGyWDh5KCJD1JsV00N6pUx6LPSQwewjgWwSFBzsL/WBYO3?=
 =?us-ascii?Q?gUVspZtGz+z8+iCSH7rCG85AIZ+q8At/NyrmV3vvARv7Ft5xvGgRlnyLTptS?=
 =?us-ascii?Q?PQ774b0T9rPcTbpYsUTeUZdgv4inIewJ5j5wb1SEIJCqL5iqq3Xbt5fqaHSW?=
 =?us-ascii?Q?9z4QGZXjBUaPCdMFNjQdzI8a1+s=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MQlq148M6gOT5Dlk3+ZktjFCMCnocBP1h2ttjTSrOvB4E7fxfnWpk+Bdd8S8lOxsFE4Y9S38U5e6MumCLsRTcC/8a5tfLBSU28jew1AWFn2YxeZrRjfmGYZyt4Rdc1LAiOxfyCZXzBpHAYLR9iQS8fe3biPcYmoYdjE9wbr1Nm8PFTL0tVr2AZPl5EzX3GHs1LILalgQAxv+JbZ48OqsqDDGbpJIYW/t9i13wBKGyqnFAqVcZf4DWFBvIabwJYay9MDuGlczPQfcDY59iKS/QBsoGfGTa7+auptd7o5V1Ath4eJKldO2+Xo/8faWoDiJKLLBMczcqWUZ+I/1WpE1rFP04+WuYWjBWts3EMySxwDnnMDig5PuxSmC+G51Rol9IaqDzHyGDZR/0AdnACWtxgg3V8fiH/pNSr7n/c5shr7/WGZH06vZBorGWUTWU9a9
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 08:52:13.9591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 876fd65b-904e-4f9a-25d6-08de6d38ae28
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR07MB10660
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16910-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:mid,nokia-bell-labs.com:dkim,nokia-bell-labs.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3C1A2141B4C
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Currently, hns3 Rx paths use SKB_GSO_TCP_ECN flag when a TCP segment
with the CWR flag set. This is wrong because SKB_GSO_TCP_ECN is only
valid for RFC3168 ECN on Tx, and using it on Rx allows RFC3168 ECN
offload to clear the CWR flag. As a result, incoming TCP segments
lose their ACE signal integrity required for AccECN (RFC9768),
especially when the packet is forwarded and later re-segmented by GSO.

Fix this by setting SKB_GSO_TCP_ACCECN for any Rx segment with the CWR
flag set. SKB_GSO_TCP_ACCECN ensure that RFC3168 ECN offload will
not clear the CWR flag, therefore preserving the ACE signal.

Fixes: d474d88f88261 ("net: hns3: add hns3_gro_complete for HW GRO process")

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index a3206c97923e..e1b0dba56182 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3904,7 +3904,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
 
 	skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
 	if (th->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 
 	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
-- 
2.34.1


