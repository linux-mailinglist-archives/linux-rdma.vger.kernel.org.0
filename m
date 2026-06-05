Return-Path: <linux-rdma+bounces-21870-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LDdpH10SI2qIhgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21870-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:15:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C1464A7D0
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:15:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=UWbgjcWN;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21870-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21870-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D722A308FC85
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 18:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1CC3A4523;
	Fri,  5 Jun 2026 18:12:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3DE395AC3;
	Fri,  5 Jun 2026 18:12:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683127; cv=fail; b=dm4kTXds3a+oJKeH7H4ADq0yV2diK/6NBx4Sd8tDKl94HkXscf5x3O03hSWf3VweIJCwysNYrIhfBFYZszincaGDaYsta+oCqdl6ECfrmBkDBFeQLZLykQyUVURWl7rm0ckST+8AYYAnnIOejGYAuZfHHQUBZGVy8PkmCI3e1ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683127; c=relaxed/simple;
	bh=/hZfjVUzoNonbkaPhQtPDhUIz/WtWCNsGBfCu+ohQCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O752ig0IT/FSVIv2IOUw12ExB40JLvOuy9UXvkFeEWFY1/ki3/32bhxMXm2v+urGXxIXF/khfeNO9nGfvrwA8N42+hBADR/CMBURuxswXkiBs2EOMDXmkRP70LepnRqij5tHwi3gF0Rr8hQimk2vHsSz2eN4Db0T8gpSGEzQ/tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UWbgjcWN; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxScYrEUbePA+nXGDdW8dFz6M9EefhSx/brzbDfz3WCaVxE+ClW7tvX4DxFlSeXbHiFdPnEmEUZyNaXWnA1mSclm1z2s8eRLfhE1v4VkavRJ11rgmF3+MFhCqevU0Olku8m51pTdHyNeusf2rQAIugQFSkXAclo8zFONN2KtyImgy5d6oinJ/BTtKudvPmXl+PPjXf5MHrfMulS+x2OIEOMhL4Oijb0huVgO7VaeSWq/TPuG4vHgLnpc7H4ndlE2tc/53Z76UNyvd879irRT9M2bHUByUMXXsDxZJ2k6nr1WZF+Dd2tBhiiWHqOydufRPMu3VDoNYNX6E9bEQD9Lcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9soaXMPYRauy8lKt/ifeZipF8Nxan0y+TSlYDm86b24=;
 b=yUJ6KEzM/lyCWLR/Nfwrw/y6bUx5NsYHikkw2GjFCYmvSlVWV3GSDPPmxEYJGFhD89aY17KBkHumkvjOeQgb53MFmarZ3JeQ4ogu0Kwv5jhKmlaRD7JEzgPHGq6F+VqpxCREFv2eZodAc67PMMiBv0OjjJT0Ck0jmqjqbC56xV5OYiUEUl1NzOQz0PJS9e+6nNgtgvaOqAshf95sCHG5v2i6g9h237V9iU/MJ4ikOEG9hV4vxJfi6thcYwaEPOHGRoH76DglywfGxY1aUbyr7RktowhppKO1TamtXneBjD+EMX6IytiLVsNI8L5dZTYYB72obhl6kI/wFzskRuAajQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9soaXMPYRauy8lKt/ifeZipF8Nxan0y+TSlYDm86b24=;
 b=UWbgjcWNVGgGekPESYn0LtMjiazivteKVYxZdIbLnFPAxmp7RvCzbysv5l+f7nObh/scwMWssM6ZV+S+T1hR1LhmwQHdLuEfa3uHFJKtGY6EmDqN6UPkjldtyv2jNvNCdgOenQ6oLQpJWMTmn2UppQ2qJBpfNOatpw0l+++QUlq5kXo3Y9eOfi1YmkFUIAFUIOjFtF8O3UxSPo0wmvxWFfzyEGt1nq1ibnulisFsvTcZmi4Wk8DQY0wPIFq0rKIAAXVE0PYpY8c9+KeOi5R5v3iE3nIzXXLICGnzOlTeWCSM2X80brO1GdvhuTd+0hdk8YnDeV/IaALAviQL/bpLFg==
Received: from PH7P220CA0090.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::13)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:11:55 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::3c) by PH7P220CA0090.outlook.office365.com
 (2603:10b6:510:32c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 18:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.2 via Frontend Transport; Fri, 5 Jun 2026 18:11:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Jun
 2026 11:11:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 5 Jun 2026 11:11:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Jun 2026 11:11:27 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya Sundeep
	<sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Borislav Petkov (AMD)"
	<bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap
	<rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Petr Mladek
	<pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Vlastimil Babka <vbabka@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, "Kees
 Cook" <kees@kernel.org>, Marco Elver <elver@google.com>, Eric Biggers
	<ebiggers@kernel.org>, Li RongQing <lirongqing@baidu.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next V3 6/7] octeontx2-pf: Register devlink after SR-IOV state init
Date: Fri, 5 Jun 2026 21:10:29 +0300
Message-ID: <20260605181030.3486619-7-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605181030.3486619-1-mbloch@nvidia.com>
References: <20260605181030.3486619-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9b0e84-95b3-49cf-8ae7-08dec32ded09
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	q8zvO9SI6n3Om9/cp0araI6oP8VlAOpF5ggGJv8RNhypjd7iFWUDtvOlhEgbhKvkiHtIFu5JdgXCzLIAGofoaLWmEjkUHuGzbS6VTbCPd1ssxlF6rrS3aJwuqNrdzg+OG+SeLTtCF7i4vbj84IVEfAT6L5IJ9MjS3eq/6lxdTK3Qxp367ZzGrGjbh0DWgDQUjJxa0V3ECoGi5PSJ9iHGuoj1SR3coPlSDepTb0jVAGL8p0+CuKLuayUjHN9SPGHcPldXqO2HN7omTgmeTU3NiaDW2dGX7daTaR7jr+8vKArppvIM509wLZZVKM4LCBrYgMq8NIWHymwniM1+/7tm+/rXc69RbrO7B4ZJyTuBUZh7QrtXxee0jvfjH3p+U2b81IaAn2mNwuLNggNtw2z9UxYE+DK3ZttgN+x8wqXQgbVMmw50VeXjsx7KD/Bm0TCQ7EjdNjmwa+MtiOQZot/1yRteFh6Dvj5mtMrSkkl2a18KjdiGOER3sB/3Yf/swhAnO/YfT0yGOLMhuAhivy+DVx80kyDCKfFwvP50Gpw56SkHL5YKKU5BLGnDNoTCbQPWbrQq8uK3KxToeBqoenKtyz7Fy7gMoiI1x1FQ77S3w0TXJTVBjWk3/DUOuAGTVUaNJD1ziMg9TD+pZ8kdhbJ6lLwG2NjVWynmBPPorz1h4ioDQi5omjo/I2Gs205iuH/8zZyoMo0kH3p0i8V5O7TFC4hRxrollCBx9UK715BKjks=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q6NtkYjUp4/2LQFa9HvK5tSy5x2WcZ2BqUJT4P5ze5UUY2vtEHTNG+CctvrMxwjmpqHw8LmLHt1efYqsuhlZZKNpVJGi+WTvPHy5sCKQHUz/NJemZBTXm9m/RRQNgPPe/TTK1+cGfOa8BbTm8HnUgNcBJLRwqFPU3eHRJvoPIg9XsevpHyNu0m3G317PIwFhycAHhzXsl2tPuz8tSr/KxPOr8khGV7qUqO0VQzZys+qIxOCcVYNP/rtbBP/ubKroeit6dyamcD+G5CjIEb5F4B8TpLBXvy339O5Xv3HQkLC95kIS7ylbKn677SJY1nhB4ERmKeNBmdZiZV8X7IevTp2mf4pZ8n7Y9zORrTxoqWXcH04YZyq+81TlPZowxRlpbNBIuyyCBRhMn8YVfc6ke8jZTBnl7zHoP7FHsjbEWw+lLROTW7UmuCD/nQlQHOql
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:11:55.0312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9b0e84-95b3-49cf-8ae7-08dec32ded09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:peterz@infradead.org,m:dave.hansen@linux.intel.com,m:vbabka@kernel.org,m:brauner@kernel.org,m:tj@kernel.org,m:feng.tang@linux.alibaba.com,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21870-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,alien8.de,linux-foundation.org,infradead.org,suse.com,linux.intel.com,linux.alibaba.com,google.com,baidu.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38C1464A7D0

A later patch makes devlink registration the point where devlink core may
call eswitch_mode_set() to apply a boot-time default eswitch mode.

Move octeontx2 PF devlink registration after PF SR-IOV configuration state
is initialized, so representor creation has the state it needs.

Add a separate unwind label so failures after devlink registration
unregister devlink before cleaning up SR-IOV state.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c    | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index f9fbf0c17648..47d2c6a24636 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3278,14 +3278,14 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_mcam_flow_del;
 
-	err = otx2_register_dl(pf);
-	if (err)
-		goto err_mcam_flow_del;
-
 	/* Initialize SR-IOV resources */
 	err = otx2_sriov_vfcfg_init(pf);
 	if (err)
-		goto err_pf_sriov_init;
+		goto err_shutdown_tc;
+
+	err = otx2_register_dl(pf);
+	if (err)
+		goto err_sriov_cleannup;
 
 	/* Enable link notifications */
 	otx2_cgx_config_linkevents(pf, true);
@@ -3293,7 +3293,7 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pf->af_xdp_zc_qidx = bitmap_zalloc(qcount, GFP_KERNEL);
 	if (!pf->af_xdp_zc_qidx) {
 		err = -ENOMEM;
-		goto err_sriov_cleannup;
+		goto err_dl_unregister;
 	}
 
 #ifdef CONFIG_DCB
@@ -3310,10 +3310,11 @@ static int otx2_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_free_zc_bmap:
 	bitmap_free(pf->af_xdp_zc_qidx);
 #endif
+err_dl_unregister:
+	otx2_unregister_dl(pf);
 err_sriov_cleannup:
 	otx2_sriov_vfcfg_cleanup(pf);
-err_pf_sriov_init:
-	otx2_unregister_dl(pf);
+err_shutdown_tc:
 	otx2_shutdown_tc(pf);
 err_mcam_flow_del:
 	otx2_mcam_flow_del(pf);
-- 
2.34.1


