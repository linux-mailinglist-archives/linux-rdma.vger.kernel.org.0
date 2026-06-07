Return-Path: <linux-rdma+bounces-21927-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bx7cOC62JWpFKwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21927-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:19:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C48651385
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:19:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=XkW9hcwM;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21927-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21927-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C81A300F9C4
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 18:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49E5257452;
	Sun,  7 Jun 2026 18:18:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C90213FEE;
	Sun,  7 Jun 2026 18:18:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780856333; cv=fail; b=sOzcc9vD2457SGR7qb1jIpKR8FKXbTXmrsYQ1eKEhOO8AIQ9W/F7I/Mcz88A5xn8jRnChla60jZBuo+CHrIE40oyU24l/Ccayn2kcY4n4yIW40kQCPiesYO8jLkm3FtG7X8nAk+LMsBB/sPUvHzeLUkFetF1r7MA0Tn0rH4Ppw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780856333; c=relaxed/simple;
	bh=a1g2v1YBvjhocTfZCEgP1qcJrWabrrCjy/CwTu4G8Tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mbOZMFMdrFHMHeikrV5pA9t15VdZ2ldxVsJEKCSYt7le5IfFzCVEEuMBAJYZJqSNaL81UTxF7MuE4wmy+Le959wxPv5rFldZSGVmQuKN9O1L5AYI3Zzmgy+zA+Yt0wRTSSOAl96B/XprCyKSB/nkn2pW/RcY7ZFOXCuIE9z0u/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XkW9hcwM; arc=fail smtp.client-ip=52.101.56.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIJa0dsXylLFhpGdeBDS9rYW6BTyjtK1YmGd6ZNmoBtnoSGiXBHk9dgN9sfSp/mbHieUle1HeU2P2jUkYrs+2+Un3iSQN0sVz1V81EcklJ3pHj+glv/br9zzO8Tmyt1ruWG7dJ6VNkQ9Phet5ye+R/H7/rAWBdqG3plWJ7i0dj+dN8HnKJQmNf16yHP+2vSQ3P+rxwlbF8wB2RZeNvIoWOBzGCgx5Y/5aGdjVmn/lFQaX5lGlrQam6qQA4ePvgQTnYiMUXwrR+PiokRtHwy1/Adoy/Akk1qQSYDYIrgoCVlmfGiL6sWmNw5+GXjHR3IURxgAtdF1xq0PSdmKUhnDZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxqCoYK9cSGBeu9TpEkn0pb5ThybRXr7nIJf6S5V7AY=;
 b=EEMCalmGLR6ojoUG37nXXXDpaEzehy9khW/WV3UGzI39CLBmuoDynByFv3R/oNepQL+/wH6G568hmuf6Uk9YcPMkLBP735DuvXyazg9omXef7IQWIeMu+0D6gHFiG3wAYh30DXw4kkdUzFg0y2V/QieYDsNf+1jrMyFInIiEXFYNES7OXEHRoK+ge3KKNE8EzS+7hKFzbnJ4u5/FgJpu8Tbdset5tAAcOF/viq07p6nOCb8zvGkAVYQ9OsDwB2OZ6qgSB79kymHhXPwNn5GApmUqphZ9l5SQUpptCaMyNFPcw9uM52DIZn3/w5XOzow0zml5v3nPkntgyzrWpoQfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxqCoYK9cSGBeu9TpEkn0pb5ThybRXr7nIJf6S5V7AY=;
 b=XkW9hcwM900lVieXKjt13o49QSQbH0nkUkpLnKzcXDILfpKIjEfBMbuCxUsOOzOen7vbZ4VGzQ+pyMqsGyiPw7BL24c/ba/BRon9n/S9BuVw/E+YE5HGun2tYE6iCjRn87ij2iU2N2uA2PfH7OMhKM+RO7/Qgj28pKdtqyAjYrtS8KfB1U2wvADO/YApSv7nfylF/HP87eM4VEyrTmTFsTG2Z2MB8KLA8bBSeoEe/HJ3xA+pbXrWkb0xAFPTb8/8UEjdEW4U+Oa+YiOkQNR3WozOezap8DQi3mrsEAAkMdeym9BLSShXzHiin4O/kKLxvZnvW6c//9Vy52woJJmpOg==
Received: from MW4PR04CA0111.namprd04.prod.outlook.com (2603:10b6:303:83::26)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 18:18:47 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::80) by MW4PR04CA0111.outlook.office365.com
 (2603:10b6:303:83::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Sun, 7
 Jun 2026 18:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sun, 7 Jun 2026 18:18:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 11:18:41 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 11:18:40 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 7 Jun
 2026 11:18:37 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 7 Jun 2026 21:18:09 +0300
Subject: [PATCH rdma-next 2/6] RDMA/mlx5: Remove raw RSS QP restrack
 tracking
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260607-restrack-uaf-fix-v1-2-d72e45eb76c2@nvidia.com>
References: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
In-Reply-To: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Maor Gottlieb <maorg@mellanox.com>, "Dennis
 Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Steve Wise <larrystevenwise@gmail.com>, Mark Bloch
	<markb@mellanox.com>, Mark Zhang <markzhang@nvidia.com>, Neta Ostrovsky
	<netao@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	"Michael Guralnik" <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780856308; l=1292;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=9tGJJV2RtEHUlmoA3QkRav3nmmfe0EesfGn/t0IIlOM=;
 b=uDr1rtK4SWl/IHzW07L+29lT2YptygUONd/En3IVeE4GSu7waEB87dZC9182l1RCNbB0NWAXA
 vQeWtqK2u1vCDioYF91koFN/jitzr92xOyxNS3Iih2FRda62cwty/kL
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: b1151f30-2285-4ce6-e270-08dec4c13717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|921020|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	980JS3HR9F4JM9wxg37ZCipM9vICkxLxDgyoC7bK0envbw6wCM8vLWFxrutR3DuZg9w0KLYzGIqjplixl/hP33KOChrpBd2VqPc1l3c/NKjvFkJ4tcbWTR68K1Ib0x51rGwJhRMJZun7hVRMnt6YvqtdOSZR8zMqjoxx38WhFCQTaE5Kg49/VK2l0TadjzVpzqcI770PRYpNBoGo0XaGBcaC1zgg6ysUlLcNoO859NZRNasWf1zcf6EFM0Ld0MmMonj+3OFVwDIEvpwKB/1sBpmtUCCqusz62JpRn0q9UGO3AmSGOhg1Rq1VCKu7DaZ39uWaz97OKtp3NZgOgsC5H4YTbnBN0lkj+QrsIJlKQnypShGpnfVXcBhVTFWCY1S/omqJOLksqpX7paQZ8dd1uEEtxiDSJSDvFo7Cknrk3xWBcUco25TT+j3nzZnV9m6wsEasmdLiql2vZaS1rGSvMDQ/t4gWXqI4GUliukoSbaM5pjZa+vAbwY/93N3VCIV/fDX7yjhF54xxUh0FysMMtGHRjH4N+/mkghOuNbnszblXXr4f4gJwyBkWCbhl1bVjAPpYRDF+z73Q0e7/+ZGJY8tozzeaNnC8tsv4ObKog6eiwBgeZD6C76peP4VvEy643y0Ex/SKXlANjN/fDuOJN2WqwedIgl6/2B7geNfB4HgigouDBINF//7WLuscAlsCRcYgU++IchQmPUnr3TcI7nZtmEi1YITUjMcBHxjlgwSMj+qaayOCa8gkoVkfT6sSSplZ4a2VNFFQdk9L8c+SaQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(921020)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1O1rehy/7DXBRgpXM1tPYffOUidYtvrw2oXm/ywX/XG+6iw4PqZ0XI9ClDJTfnUTlTQnnqYo77fIZRZhaUaTfbL4kdNp+oFVvJsU8U6Ge0XrCEPwlJCw1/gYecwq8Kkst7Yuh/4E3DXg22szukn2SwDrVIsTNy075FRzZfJY+2EdsheUpNOiXCVpPq9tcyPhvjDAVjsCVelE9FAs0dq/kqH/d8uOizqQOrRn5hcgi7HSIdD74iv75wRck0+tgWAfmVBuo4LKim1u7mpY4vWvSgG0U/fqv0QyNS4WYvXsbvff6qWlonccl2NuLKJMf7yEDgMKUrKd7tsHDPG0UeiSGIxUCeWOzhu8sUcNjxifNmaee+/T/4YxTQ0MEcb1jOquCqp0WNGJJt2IKwZBWD9Ctilt5c4sQQqJRQyIDV7G1u7bicNK3ePUqM0V8/F/IDo+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 18:18:46.4729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1151f30-2285-4ce6-e270-08dec4c13717
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21927-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:cmeiohas@nvidia.com,m:maorg@mellanox.com,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:markzhang@nvidia.com,m:netao@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,mellanox.com,cornelisnetworks.com,amazon.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43C48651385

From: Patrisious Haddad <phaddad@nvidia.com>

Raw RSS QP restrack tracking wasn't working to begin with as it was
only tracking the first raw RSS QP which was added, since at creation
the raw RSS QP number is reserved so the QP number for this qp type
was always zero.
The following raw RSS QP additions were always failing silently.

Since the fix isn't trivial and there were no users that required or
complained about this issue we are dropping this for now instead of fixing.

Fixes: 968f0b6f9c01 ("RDMA/mlx5: Consolidate into special function all create QP calls")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index a16da733d99fa1f6fdb9ee864465acf45a6abb3d..d7fffc0d818f39ca9c75b386811fb016f547a32c 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3129,6 +3129,7 @@ static int create_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	int err;
 
 	if (params->is_rss_raw) {
+		rdma_restrack_no_track(&qp->ibqp.res);
 		err = create_rss_raw_qp_tir(dev, pd, qp, params);
 		goto out;
 	}

-- 
2.49.0


