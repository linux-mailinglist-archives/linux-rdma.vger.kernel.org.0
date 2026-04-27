Return-Path: <linux-rdma+bounces-19579-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HqCKRxD72lP/QAAu9opvQ
	(envelope-from <linux-rdma+bounces-19579-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 13:06:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 116024717AD
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 13:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDB353050A1C
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 11:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D2F390986;
	Mon, 27 Apr 2026 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YurG0LgS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499A388E61;
	Mon, 27 Apr 2026 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287809; cv=fail; b=sOiBOnPeYKPknAmVMJ0CPhlgb9D6aMWmKXveyjsS9Uj9hiTtLcO1QfiTddD9e/FHeRSi5WoCH5LHDM9KaIWvmZFeP3PeuE5e93zcXirLmXd1I0u2h7hYpdnWHYIaXborx1HL+J+JvZ10dx9ofU1FBGmhc7Mcfj1ZOJonCw9u9rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287809; c=relaxed/simple;
	bh=twhy6JvLcZfraQ6zhpNaCj49rByjd8hCm5kGrV+ih/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mTqkikElybnIGkq5KZu+D2MZV55BtFbmn9cs1k0uekaG1Vv6yAwCMG6jrxTKPt8gl4LPuAdzrs5EwSotsOGfxYFukuhyNCkur85Hwbl2GdtxvYg4weLpfE1l2+juV8l8ouCGWSQowgmNWrora9YxxRF64JtAKjGSleoj8f8DKrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YurG0LgS; arc=fail smtp.client-ip=52.101.85.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpBobOM62AFAh2tAqI3ks/DztpQV69MYJstzGD917CH1s0bdahCeQKXs4j6uHU5K6mue5SceGM6VUp11/e6owaXA04qHhFhQZLYmnjcfTRbJ3oH7MSy6IcbMVNDzIa4HJ4bkm+j6NWFvpmbT/PyioE4WNcI8PgN+OqPhMgFp13fcqYiPCdaxvo9EoPEFB74rEaCGHQudxCKeX7KKualJq3ehAPF32hMJfj51RRlh3L1ngoYBqQW4foLeEkMRdgrjH3PsTV4z1HRlZRqxFjQdGDDKGsbHnZgOJoTNCZWwvIcS6jHjt0Vc7AsKYUAbgBeSgyF4EWo7vqNB5x9+uK98Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Adc+71oSC3kEstgNHwRXQOB3tfLEMA6PwNu4D8iVjRI=;
 b=LUfYDVrfeSCIqe02xygzDNUunxCO/i9uY5Er/P0ub3V5kx8soQXP3mjoxpkQdXbF9HKG+mFZar1ce0OC5VzyPI14AsDLhYuf/IxwN61ceXps2+ym1VxpDoIn5yUItSMjUTJwHzg+h66aMSBzNVJzkRzGUISQgBnUWv1wblVfRYIfXV1dq1YANWGX8hpDWC3XRxOPEg85FTzxotWJbRmOqf+LZimxWNOkv2gn1lWdA2VKlfVqZDfsWuqrlNO5PpqZ8tN6udvZ3f20R0IhwdBLlkOhxGmNSKYCMDY/BaN29VllNj5C4Rhh1Z7a+JwwH6sSvMY7EacCFKAc0bb0f8wcBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Adc+71oSC3kEstgNHwRXQOB3tfLEMA6PwNu4D8iVjRI=;
 b=YurG0LgSY9CLl1Z3+PXSrRbyQGgQ5UfBqL0826MqxaGYqkJM3iPfS5HXc5kJW9zwzOtk8bHKSKmBhIWksmWC6pnx3C4E3H+Y/1bmdzc7gdzjWJMJ/wPu0JxfQ8DKqpXH6qTONzoYX4D1JjklvKGFBeNboNQNlPT+JRX1nnnYtSY7Tq9MXuXLyNYxlVefdiQIvI/iTEl1gYNdljSZpOOzD7/zBrPgylswsV5UfdMSNlaIbd6HJT9UKDkrK2/TGhitDQb1UfNh4OtFM2pm/cCg0P62wzPKXvODdDk1GfeHs06P0iDql4OwdimZJAxVUp/6s+C58mALStqOGu4sH5A1dQ==
Received: from PH5P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::8)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 11:03:24 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::fb) by PH5P220CA0001.outlook.office365.com
 (2603:10b6:510:34a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 11:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 11:03:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 04:03:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 04:03:04 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 04:02:59 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 27 Apr 2026 14:02:34 +0300
Subject: [PATCH rdma-next v3 3/5] IB/core: Fix IPv6 netlink message size in
 ib_nl_ip_send_msg()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260427-security-bug-fixes-v3-3-4621fa52de0e@nvidia.com>
References: <20260427-security-bug-fixes-v3-0-4621fa52de0e@nvidia.com>
In-Reply-To: <20260427-security-bug-fixes-v3-0-4621fa52de0e@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>, Maor Gottlieb <maorg@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777287764; l=1480;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=dowc9GYbR6/8wK5VJ1yS3HHNzFTqRKqHxXN007YFpfs=;
 b=IjMx5jyw7HQWLZQmeLU7WM1BVjrP1s9eALBcCFDz5hvkjeRV1pCDr6w8JzxdgMC1l41NEEQ2u
 EH5AuslZNZCCNSw4IZIifY68KPKIBH1gwlhk8y91JZQMSUg3u+CJ5us
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c26b94-f449-44a4-99fd-08dea44c9a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	S3o+6wpRJyad2+3C43ZR/KA/qnhTpM6S3eoo9X1dTnnAxMD+y21i03Ne6XMHvembzzydi+BkV/WN+vrPAB8OEznTRlJA0TPjQD986+2MOX+ti8lPHXFiYgLoKhwsbJZD+cC8JHT4QUj2/YLSGIpVaJ38/zEQouQcYL9jjPnadSld2SSfR3b1HMGMuwbJaXDYhFNUpWmVZ3TsePYMw4FCBEA5TMnn6W46eyP4Ts0yF2mN5P6Iw23mQXCHclYIXdfTw3l9cqK9NTuWWOUxvjju+AINSYXc3JKScytebaoAU+xprARCbmR9elp388/a7x2UaoXIOzORiscL46WeF9vwItpOaOjp0VgWEKg+XfHu0AnXU/+dUK5/Bfy9fV8Vweowe3woUdPaXJrrn7vSELPCmc28vXBbEERMAZblT5ZH4+4Kdb3jSBpnk/9T2FZgT+CtTj8m/4/rsBlllmF3ZSnWOyAMh7m2vK0BDogwDBnaQN36NYZrVkciZCeA4gc6zHFJZxmLy1DWTrQuawuSWCSoeRqjLKB5JYKJIb1fYNmze4C3AWYLEabC7WR2HziVZTvnce1FKDcjVg078c2uho8Dy5BgUGsqRoyDgoRW1z0q4hYp3RI9QUISOs8KC5tTNJceF/QD7ahyv2pyKKd9Ofx0sVWUnYfLJE88c1q3EY6T3+Upny2F4qXC6vm/NjIOAAH4IDE3pqKusMQZrBt6ILkGi0c8coZaXmxmmwQPWsCj8ffgB+zINUOq5HWSX3VRQkHPt7VYmAQ+07RshkkoblrYcATimfYibiBnm6X6pkCCW4hbxrWguxTEYgTzoj/JBOvL
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	msswSRWVfXvCWDUUFHOACau3pJxhOZlloS1SfopCbjC+9OLCSoJQ4oRZUW+hmWcz2nAqL+l5PqGCU7BIHRMjtu7oIV11TB8+lff+TYOLAjtU3MBa9L5C1GVy4DI/kNecoOE5ZlirGlL2tJbtAcXZ5Gi7d/g81DLwN4gvWOI/y+jNKjHrx4e2FfihvImrCXy5wK8ryRB/5EFJ+aNWZZAgs40Pg3E1L5FozTEzyoMQybfMQ4LTGPxtOTTUl2lncEwRFSxCZsAEugTmsBNVeQso5mW4PQ0ggGqj4U6/+0FRGQNCaYaLUEGDG8VrKOHGL234aq4CFua4zoh5qmBegNb+wiEUmhzoNJoFYIiih+ceAJiB62SJI61QvVzZgRfCCZtf28rqjrFdDHAUBiG6tO6B41i27Sk4uZ7R4mGxBh7Cd7et9VMFpCR1Ly8KcEHk1fHe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:03:24.1794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c26b94-f449-44a4-99fd-08dea44c9a17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
X-Rspamd-Queue-Id: 116024717AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-19579-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Maher Sanalla <msanalla@nvidia.com>

When resolving an RDMA-CM IPv6 address, ib_nl_ip_send_msg() sends a
netlink request to the userspace daemon to perform IP-to-GID
resolution in certain cases. The function allocates the netlink message
buffer using nla_total_size(sizeof(size)), which passes 8 bytes (the
size of size_t) instead of 16 bytes (the size of an IPv6 address).
This results in an 8-byte under-allocation.

This is currently masked by nlmsg_new() over-allocation of the skb
in its internal logic. However, the code remains incorrect.

Fix the issue by supplying the proper IPv6 address length to
nla_total_size().

Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 6526fda8f9c0bbbcddcf54f5c953d3f7a9785d66..5cd930d47eae52d35db8657ab3fc5993c5cd7770 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -150,7 +150,7 @@ static int ib_nl_ip_send_msg(struct rdma_dev_addr *dev_addr,
 		attrtype = RDMA_NLA_F_MANDATORY | LS_NLA_TYPE_IPV6;
 	}
 
-	len = nla_total_size(sizeof(size));
+	len = nla_total_size(size);
 	len += NLMSG_ALIGN(sizeof(*header));
 
 	skb = nlmsg_new(len, GFP_KERNEL);

-- 
2.49.0


