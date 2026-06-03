Return-Path: <linux-rdma+bounces-21713-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4BJmI5mDIGpG4gAAu9opvQ
	(envelope-from <linux-rdma+bounces-21713-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 21:42:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E265363AF1A
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 21:42:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Fgtfv08w;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21713-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21713-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11F9930E3D65
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 19:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A11148C8A6;
	Wed,  3 Jun 2026 19:34:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9148C40F;
	Wed,  3 Jun 2026 19:34:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515277; cv=fail; b=i9rrzdPCQS10706I12YDQuwRh6g8yC+3N0r/KJq7iZpYZxhlnt8OhMsYCKZH0vlnnTCE2wRFxub1T13zckVHwe+dS4a65SMrHl5xHrC3+Pwl3bGDGnVC+2Jj64FvfY1iDDUVIN6EXLHfZ20380bDhKVkytqQDMGzi7FVsyv+6Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515277; c=relaxed/simple;
	bh=jSch0ciHaAM1sWMZMwjvlyCb+JrlevS5niw4TmhB6+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/RZpdAk+mQsvyTJUHewIvpBT+PAjXFXX2Zv4Kp3PVxKkPYLZgCyX3qH2B0I5xGdGcUMVwOCHE/SBSRG+XjHLyZ/fbiMMbzBjCVywbiyz4dIiIZs/7Wr+Vwkr8oKTeLfEvptzx1WD8H5XHcYtghrz3TW+5mf6unvT3K/dpkCVqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fgtfv08w; arc=fail smtp.client-ip=52.101.43.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2xXGEmINOpyS8aMsj/zZRK5TTpEJy+qYByyFhD5f1+/gtGGNb8MmlwL4hN56V9Ku2ca+2Mb9uAagD8tttEiaLcecZDJwz5Vjwz54JGlezavzayEwP1AKCZbfaaW/PsixfgEYAp3VXECMRq7cATZ7zHt31pc/bzeOQ18TI8AMdjYFJi96QFWgdLxihWmbpBcj9oY8FI6FMP8xur4Ey2yxDcrFvWwlav8p7L/eMjerqxb8oSqIBNRVAyLccEODSAi/+qEhlQElgl1Mka7jH2Vtv8Xf1fG9i1bCd5XR4AVRI3Mk4EMoww68pMZfbbV4bs0PyDEYHlXE/7AQavF+xLjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Fjh6Va9is1UKXphs4R/KE5/TgQpuAEqDeLTgySmbZw=;
 b=nNZguOT0BMiPHjUKwFmLHS20Nq3U59gAF+Uwy+jtYym6kpEdK9gYaRLyD6bC4NhV0SxR2y23U9jP2WQTEkwH5hi4PXmaTsdLDh8oL8KtB42d+oOYMKcZO1BxcOPIOpQ1/tm3JqxMEfBQmzzmt7HeLP0+P9C1Pr4c3Qh9tWq/CLhkIVr1RDc2vbkvfTaPDv/5q0BngnyufUdnT6ZQCqHgVLlwD+7qJAcCWnH1+xGeYaF2v3Fs0chOsjN2rnIm6V8KWVae4fISSEhmlpFqf6eIPu7m4ULDnXoMHiW4R2SU2WCm/KcICQ+6ZFYBIIXVqPO6Tt5gTHk2H7zeGAtEVl4S9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Fjh6Va9is1UKXphs4R/KE5/TgQpuAEqDeLTgySmbZw=;
 b=Fgtfv08w1OMLXdonW+6HhtK+YmUVi2lSS4VLNGSHmALfE55OYgvxudlo1Q4f7jySItgL6vXqvATpX3wvNhH+bA73roP8Ui+xg5eBRvUzuKu5FtyeInKKVflg2gMq+Y6VEqgy+KY4Rjqi95nxCUea+676mSRT9DrWr4CEEG8MLSziAma3drMxNQdsnhwKXsK4t3C30uSXU4j2ET6d3+IP2npt2w/LZXHrQWPcqygZ2hgs8hRzsy+FdqORKCs/GFOfSRLkMkUVOTCvCDqcpy/EUBF/ikpVvXoF8VcMnkEgj2h3VRxOx97dkEWwPdzGLcFyMH+koLLvp2/ECUsn8+QuFg==
Received: from SJ0PR13CA0144.namprd13.prod.outlook.com (2603:10b6:a03:2c6::29)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 19:34:28 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::e5) by SJ0PR13CA0144.outlook.office365.com
 (2603:10b6:a03:2c6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 19:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 19:34:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 12:34:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 3 Jun 2026 12:34:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 3 Jun 2026 12:33:58 -0700
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
	<rdunlap@infradead.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, Tejun Heo
	<tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver
	<elver@google.com>, Eric Biggers <ebiggers@kernel.org>, Li RongQing
	<lirongqing@baidu.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Ethan
 Nelson-Moore" <enelsonmoore@gmail.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
Subject: [PATCH net-next V2 6/7] octeontx2-pf: Register devlink after SR-IOV state init
Date: Wed, 3 Jun 2026 22:32:58 +0300
Message-ID: <20260603193259.3412464-7-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603193259.3412464-1-mbloch@nvidia.com>
References: <20260603193259.3412464-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|MW4PR12MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: aec7e565-1771-41d6-312b-08dec1a71e5f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	aj5MfJdt7S7ffWEPi+2bAyFKJJ+JKCDKT3lmNTaudJZjdP+2XuhUSP8dWnaPB/+GODtfGEkmjun2Ykwx5Ika04Nk76A948BFRfkOSg+3WdcqVlz/sbFzcYIqMpk6B0f0+gYPZNbK08f1JxcnVf6zQzy6RinkbmWvuLdkAyQMCi/d5nUY3mzHeFietax3qCgQACNfLZykk6nQkpjRYHbYV9f6VMQRva/b4Jg77N9qbMUy1kYvTjz1gKTGjwJOg7oEkDIetZVWOfPIl7BoLQKGLu1DuOnbMR1HBng03AXZ6lDT3w40cd0aSNCja5zUVHiyG2aGWJfGQ8oThyIJmR+VcxWTLZQzIjm1mdD78J6tOIIVKq8WbMUoGk0y12ZPV/2twQZjfQdaQrLmBjApCR6dZy43uJLr0ZQm66RM8P3g+vvu0LlmfUvaFB+qELN95duYuwlDqKVhoN6Vpb0MugIsHRT+nRIbmOSIo42MDW7TVoMxzw6jseoo7kPFAuC18RQ5zZfMUU+ZhniRBIK04iKE4YYJCe2e9pIQDtGRKpxJ2DC+s3orWMtzjjDMOZSFbX+Ig2dpWtyaqTWWn8YigTOWmd6kk8XWgCmgcuH+BlDTg+4pZMHyGj+1jX2Xxypgybu0acjxA3rKNx5Opjkja1tpa6VUTEXfhg2Rn5TJNjPDgnXIQEQKc4uqLMpyH6AsINaNTieD3M0hJIFLKmLpqwaeoGJJ4TlLSsdRMLpQupwOv5E=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pYvcMNaVP/MUO06CJGhrMlHikBRZfeMjxaOLvi3d7MoX2PYGsMqLahWar0SDDH81grOmCN73c2o5L3Jn+DezI82yy4Hv70athUPxyWiT3GJB3gFcJFr4xxyqX2tQmyKMEe/9GuUf1j99bNaRZljiY1m8BeU5Uk1QuK023oyt2I4NWyiFK/8wX/Mva9mdGVuPjqIAeNYe+AemnU3yLNkkmTfRoC5LJfm0B7YXSnRx66ZMjcevijzxTIVsb2Q/hpVKJ0c5u9M3l5FeoRSNWw/oHeLCADVFHmiWBi4arrhbHghuSXPiNtVU5HnAsdmX2j8dPpU6Y2c9u4L+PuBEgk8TpZwUF6EH/YN8iBfVS0+fWRe8X76ghC5uKCoPutRR7u84T1mGlMpGSh0c4EcFvp6XBDIsv7yiSNEsguyeoQTKw2+YII0eS6rjK5fGlGzyV/jD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 19:34:24.5714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec7e565-1771-41d6-312b-08dec1a71e5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:peterz@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:tj@kernel.org,m:vbabka@kernel.org,m:feng.tang@linux.alibaba.com,m:dave.hansen@linux.intel.com,m:brauner@kernel.org,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21713-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,alien8.de,linux-foundation.org,infradead.org,suse.com,linux.alibaba.com,linux.intel.com,google.com,baidu.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E265363AF1A

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
index ee623476e5ff..9afe6cf0ea01 100644
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


