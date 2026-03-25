Return-Path: <linux-rdma+bounces-18653-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLdEGswxxGkAxQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18653-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:04:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E8332AFBE
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3442305C1F6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88792318BA6;
	Wed, 25 Mar 2026 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dY26AFYQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E60330D3B;
	Wed, 25 Mar 2026 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465285; cv=fail; b=OpCLZ7ls9bHXkL181dyn9IRw49EruM7drGljnDkgaUHWWhQsQ0X5PsZCfeZD/QlTlzf2D71xUjDfTEZ7nNe48ndLZQMNnEdCLh4azuBUqZj9CFRQn88QVHrNM6SdaisFFtxa75DlfVtvflJfsnHCvPZTwQwQJjLRBlnXItqwRBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465285; c=relaxed/simple;
	bh=Zh2rUBWQpIo2/xyLHnFKLZ6Tven2bo87Z38Ga0768d4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=U0QKWaoYOE6lnlXU+YvC5D5XhETkXurUsAXg9/ndD+G2wglsqTGmuxA0N2XXldj8P4jksfQSjZYtmDsT2rZrQ/Ab2USvg9ZyXRZ56O8zqFOruDL9gYY03hUlGKLG6TpGQg1hTTwaGprnfC6XxeMgSujxhiJKnUb4EzaltYVeQhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dY26AFYQ; arc=fail smtp.client-ip=40.107.209.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsYYZT7bKSQGkL/mtjJ3/LONEmFk4NETSTh3CMp8xZyHwYNyzG9qal+LWgy4BQmguwf26p5DWRImk/seOyZdxDNYQnBbVWZVv7lT4b9NsufWO484TkJm/y0ileCxedUsldughnrP6GjALHMvDSYZaVicLglAQclcVg1gGiPWgb23Lm6hEllAUpfSh4JijCxqa215+QvqDA2BLkywsFxPveKyNh/kaFHrFEQXKfcoIJGP+JZNGoPt202q097qSZEDg99/GoXuEks8dE2CJyCMI7Q1B8+Pc/3LBSkgP1JUqcvG3su5wwrMd9a+0ZL6UjK0JlLascrZJ2TzIWgcgEoI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crNdKivXMu1GoV76KiDQo7qUGaVVFO9lEawP2F8huTU=;
 b=jx/oGLYpdMcGHKTkpKWotS0Hs7efS0PiSqkNj928+kLiIOi5z2YQyLfR9Uf4iuL5/GvXMmnMsyJWbGHBAsjfZ0dBpLl3DQyLz4KiWcY2UJcADaD2mNPfaHMuT49s/tnO3RiEmFoEnboncyDsqL99URB2208I/eodD42Ag1RoRW0an54u/j9goyzottUIVJSFKdmzJFkcbhaCB50nbY2CyDf5MZYB/+zdVjSU7bpFlMulYTPfkrN/CNjHYgTXd2nadhFlX4THfTC9TXYbETh9TqbEjZnS9APZNuDbo0d2vwkTmgfywtlVjbLou6VtGxYxUl4aXOALXDQpDIEfENCURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crNdKivXMu1GoV76KiDQo7qUGaVVFO9lEawP2F8huTU=;
 b=dY26AFYQ8aeKAiOV0NQHLp0WTe7WQN1vR53aLArCl0h/tobf4VZy//c4uvan4hfRa3sygGLy4j6QW8qcffG2vnNqYH0lGyxnpM/DdX8PUTbnrTHcjVZSurvORKJVNybpEZIQvVAaVB+6JZH0EadrZ9MegoTskpNUWui2sIjh5we2RbL3SWpxRI7fEVMEvo1Zn3suzirZSJCzXX4mt/z+HwrUuit7KSM4vliLIKFrzxu9IOIyv8gUt5W800kRE6jA7PmjsQQNphMp21gQHfznPUW80Hw5umwloy619DPf7Ro/YKPT3/WPODImgdMp9MZ5lvvfv5dcZa2zDmSKlXEpWw==
Received: from PH8P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::9)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 19:01:16 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::c4) by PH8P220CA0001.outlook.office365.com
 (2603:10b6:510:345::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 19:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 19:01:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:56 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:55 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 25
 Mar 2026 12:00:51 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 25 Mar 2026 21:00:08 +0200
Subject: [PATCH rdma-next 08/10] IB/core: Fix IPv6 netlink message size in
 ib_nl_ip_send_msg()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260325-security-bug-fixes-v1-8-c8332981ad26@nvidia.com>
References: <20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com>
In-Reply-To: <20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774465211; l=1480;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=Jq8SMqoLS1LE7WfgI2KdbBbflGEjDYrMCeWBfgAspUw=;
 b=QWXh0ADSQzzg1fwaMTjufpLRZ7t//hQjUcMUYpvG6IdciXG6uSzH9ISJrOIJLZQxGYfGh0ooG
 fD5w2glnwblChB9ObDYAD+nBPk0SkgWAcqZEZt4ywThBh/hNFh9gVks
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 6263c538-dc3c-4a3b-eef9-08de8aa0e423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IPXUIjpcG0QusI1eGVr+Ei/Azgb2PYVsKzae4ciFcXNyPr3KAWN3XynsvbzEBoayh83CgA6lRXO0+Jm6HPut5JH2vUQ1gTGryLOXS4RF+K76KzBe5wCeBpt5BXNRpNTTqD3M8MO/EAq7IakFUWIv4ygiGytMi1LAfwCR4j59xFCLqfOPDHcPVpag+n/+jBrFLu5N45+whEKwsa5Bx5iBkUf8UhezflR5hG8+D60iinE2wtsXKKiIUdEpiLTxtqaWiTu1vz/GYB+wTuhB/fw64h3+U/T+Bsu/+EtXUcybOFVMLJ1o7xHsxi8WpYmPhCdrfB39AKjYKG69W75PG/e4lF769C43seY+jSA8neV+9YpDe1L/E2icdw3IZSuq4GsZIj/AFSvekjHMk49qsTcB6ZL8k7BsW1jijowNXcWxJ71hcCMy+mw4g4Kk9PFvNde1Py34a49gfVnKK8f2JIu0GBLSsqbyYrEsvmggkJ65Yg+K8rCoWFB861SW6WhBLsN4FzTiApvHCDHG8Rz7xDUh21BHHi8L/SMZqD2f6pZ9wHkCo2viELNMQrjeptam5peir1CA6bi/DNLjhwXgm6daDQEXMDyWPzzVxSHFwTkIUXV3svJoJDMQ4qMFsYY01H/YV3PhTdIVq+n1z7m1M83TcVZ/3LRDEQVKPuM46e4u8IgdrnotkXIJDjB2R/h6fWxFPuNLqp4ZllnrPb6lDiK99Tx7wQh9OhW+UYaC5irqSvNsOiRmw/3GiExrJkIkRgEEJ+KXozzOKdnPBOFE3i9impWxMko05uKRaL/KKG01QEJfqWCNt+CRBZeZ6rMF1+LK
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7KRwZ4Zaqk1+g10wT/S1NkPKQd/+vU3kPrTssEo2tCYpmTofoeNtaq0PXPuW4kX4GAAeX/RBqb2fVD2iu21jOQxf1IdQrwbFNUn+Byyu0B7Hj4lmNHBbfpK2XwCEWtrqDzRq6Bz99ij/0AYFxC9dnrLjws149AS/W3sbNr1tN58GpdyaMwHo/MxkypI4cEiuxbTesg4iU35xzZUmiralYU4s0eisb9/FmUMW5nSxYWEUrNwyNc14tKDSX3MbNr0IoYWgpO69mbeTKtJka7UXY9XoaJW9OdDUMaNQvDKytJLHvc//cvhJRCrQfDkOJRDMLLb4ege9cVlNaH8QZzlpdKa1boI72zUfJwnGaU09e/sSo70+0vAKFGe7W0LKtV/EaXOaCsJ+TytKnoFyQNlcJAqIh0NogpQEbcEtGT+MKV5/UECgNt5NkyxyRezrb8cn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:01:15.8816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6263c538-dc3c-4a3b-eef9-08de8aa0e423
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18653-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 05E8332AFBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 866746695712aeae425100eefb231e44d52d52d4..01c8e8806eebe511b405d17604cca28e3ed92571 100644
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


