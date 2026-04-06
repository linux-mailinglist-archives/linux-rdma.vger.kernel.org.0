Return-Path: <linux-rdma+bounces-19018-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLvUArd502nPiQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19018-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:15:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 098C33A2833
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C7A83015760
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 09:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BA631F9A2;
	Mon,  6 Apr 2026 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lGg+O5Qt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F96A31E849;
	Mon,  6 Apr 2026 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466741; cv=fail; b=lvuvnEpxm50O4PqrPwpiaIQyanBZKXFo71jKD76RT/7QTWwl//yWZYzYXCyMTzymJMTgyigyvEwk/fZxRw+zOxvmYi9brWB5HLYXSpd5QyE3CGSlXWHT2+BcojwThmZLmvemGPheasCKhH8453izsA7sEKCCq21lRLOZ1WxTM9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466741; c=relaxed/simple;
	bh=Zh2rUBWQpIo2/xyLHnFKLZ6Tven2bo87Z38Ga0768d4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nGNS6fLoPP6UnWuGUkL86Nsho0LU/1T4UDvZcmzx1qQCaaPclaPNsjAmqHXSi6Y0oZLnoy0NP4LWQLGv7KZtOgOS4ZUtjonRUov0FDYvgbfGqAXUeUcBnZYDn3+RzfmVtXsJBhraWOKoDf3zElAdisj6/1xoLAJOpPGvGtkmCtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lGg+O5Qt; arc=fail smtp.client-ip=52.101.52.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6kU9l5G/8GdyMNZ+JLX7lRT5hTlvClXO0bHJLx7mbfLoNn59QEIys8fZT6IZ3Rfpcd/vlcj+zegOUZa79mRpjY4C7H/Yr2ZlUWVppUo/SGqyczPmunUTj4SOktnO9YeLGW12wG46MKGt/BTHbV7na6VF/+fhf/teovXyg97N4+WsiOdQxkj/SeynMH+Myc/KhsgvInhejtHM7UPnUicjvI/Mezi0DtK10GZwokQGEC54GVgh8Gk4GC7Ifi7Gky1fo4T5EwC+asNQWIgCzKED0ByJqUXkTezLJ6PZGbcJzTNC0/1WfBYKbt0pPLXW+nQhNOZvadBvMUbkcbXGgFh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crNdKivXMu1GoV76KiDQo7qUGaVVFO9lEawP2F8huTU=;
 b=KyrTXyu2qv7L6xqtCzIlBIShcVgcGbbt46bHd6XQMB3UE0Jzoun/AZUVRSM9RzRnV9aOhDheu5f8Cy4gtSEXZlbj4x1YvlqcKJxWSyDn5+6Oiq3joQHTnzkS6WEi3urEFHDB/PSzSaNLDnqTd3h7I6N1h7mM+oYkkZDB4iyB3AuRBp7YBLZrLi9W30czBWyQ1O7EVjDWPiiqjG/WdmAFZ0wLBUCLSBpYguHrQGLvaS90vG77Q+SgdEiaCa4PmyAm1cfmriX3dOLTKnvKimB7xr2/ih6brKjDwEGDAx00HJSp+E2Ya3bsK43KxW267+8a1gsnjO2w2pTHXnNe9alZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crNdKivXMu1GoV76KiDQo7qUGaVVFO9lEawP2F8huTU=;
 b=lGg+O5QtrqgDfEG0m7U+fq63I1VUBDX4hV/yiXxnZRlMewpaXoOb5ZTFg1cUyJpAbMBV4J6c8ino6xJajsoLlLxgVet+NqbF6F4ym/4iBGU5rfnUht71PrMn3eHppzqOfbpD7UbVc1x9h8Mb6VL8fLhoFyM7XTldIoQauvVJNw1552dXsQMFh0XadFH+hOs/QXxJ7upBhRqJ1QTNxiUAJaSe7czvEcGMONPBiPszt55+myAyU9E3H9Ph9bVDuylqRDxu9rwW/LD8tdUNhRsdkIdoqvBcMJM9y6mhOsiqVWaU55voqoFsC8ZLy0/QoJq5YchkBW3uNgazXblIwHDk1w==
Received: from DS7PR03CA0355.namprd03.prod.outlook.com (2603:10b6:8:55::30) by
 IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.18; Mon, 6 Apr 2026 09:12:15 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:8:55:cafe::dc) by DS7PR03CA0355.outlook.office365.com
 (2603:10b6:8:55::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 09:12:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Mon, 6 Apr 2026 09:12:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 02:12:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Apr 2026 02:12:03 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Apr
 2026 02:11:59 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 6 Apr 2026 12:11:20 +0300
Subject: [PATCH rdma-next v2 09/11] IB/core: Fix IPv6 netlink message size
 in ib_nl_ip_send_msg()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260406-security-bug-fixes-v2-9-ee8815fa81b7@nvidia.com>
References: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
In-Reply-To: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775466677; l=1480;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=Jq8SMqoLS1LE7WfgI2KdbBbflGEjDYrMCeWBfgAspUw=;
 b=fnoUzIL30l7O6sNiycpI2dmIAaH+++ZMZPRUjV/Y1RU2u1yDAz/82tlb6MW2XXPUHZ0S2nvQW
 94oTsphq5U3Cx5BJjj2F785sz1qAT1kH0xaG/OtBnLlp9Y0v1EvecJq
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: b17cabfd-1da1-42ec-e502-08de93bc986b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	M80XrwVERLYQrlMiVIKVsPjjuU9v5tyFHnziX2vMe8ebzucwaqNKbdyYEVfxJW0MB4Z1zERXHDXGVuCwNp7M1Zg0Gp2CZO13NFLHk0tDltitHFJx/PN5mZS/DSbcOwY0UrAwnFC5rKuUwtZ/Ji8mALbkXMqilc7fgr7S6Kp9zXvY1Y+yl8K+nteEH6BSymyw44a0ioqTQZtoXBjQ7ISP17Va9VZ0fOjTG/D02Xlhpa3DLAtuXCwuFi9HA0t71zzoefXZGitv3DDB643xpYtS/qi1CNDYop7TdrrgRf5WOazkNEVuImEPxWKK0UNCsWswb1r+UQdTMlEsEVghogOPNrQrbFwhP9Eiop6peD3XNN+buI88/arEL48oySuaEFFkmlMAf8+LfKj3j8aB4JxRzKAadfd89W0roIs+i18vlVYxQB/LvGrBjO0o+HuplzzPTZ6O38T5LwUhnGMRsJkH/kflt1d34JZGti/vZ3RTf9HdLdBUjKX8FJkV2JgRYOEYV+Zkx8eY9YC/crTAG0gImZVdoXIZTtWlKdB/IDnozrUIPVKk+IS1t/meyc+RAiAjsRHI0jNRhfvZBqnP0kYuB/3FTbAEIryF7BcFyMc3mBcnG3LZDLeBZewFcL/M9HIT9fy5UTNkTIY5tZ3MCg7/zy137hdNizOB1l4Vrx2V6WwNJ/APyU68TTZ9WriLMMUkgeHzmD/SSHffACXPj7K816aDe48Dw+GdxToC5p48S9aJPhY8NtpU9OWC+sxpLOhwL2xY+snSMQdWkR5BQ9ZKSZJqh0YRMT+EvSFq5EahsD0+JQqlzBunu/sNFaYg5G4b
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bxGoYT6+VnHHCjx5z+CVj7YaJfB4t/lyiZHA58B5k2onFokwDkwCoVEQ85rCqccjtpZvM/jLSpocAS5AwjkcMYcDg+HjNaIevN3tWZvUdCIGuRbZA6HDGfDsvV0bAG14kMbrXPkUU6/ivs/ZWNIxqn+v7CZoDyopWpMzhKaJuQOgaz1RiC4hLwb0RKuLtJuppn/W5YeO3KSJW8o25j+sOJvco5/wXTduJq5CuGLi89gUe/Ot5bATIOOMTBVz7IV8qC4zGmVj9ZRXfvg3GURf/NLofZsyMMaDXZMZECH23yAuaXLeCUlEmh+0RsImVCyarQvTS6sl8jn+ACVIw1fBtx29mfoensAraJDJbOhqYMjbylBoMFjbwvtAikO27M724AB6W8iAWS3jQ5MfEwfeHKYdZD1PP7pXd4+1HKhFI5TePmOdb+SSDPrU3wFRI+de
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 09:12:15.2114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b17cabfd-1da1-42ec-e502-08de93bc986b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-19018-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 098C33A2833
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


