Return-Path: <linux-rdma+bounces-18683-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAJ+EljaxGkq4gQAu9opvQ
	(envelope-from <linux-rdma+bounces-18683-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:03:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDCF3302AB
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96C3C304044A
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 07:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D674033B970;
	Thu, 26 Mar 2026 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oxScj8dS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013011.outbound.protection.outlook.com [40.107.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E028313D;
	Thu, 26 Mar 2026 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508457; cv=fail; b=pcgbwEThCrHe2v3jHJD4H37yWf3MJypDF39gT+F10P1ajJVD2aABllD5CT8wa5dv79LuDd0gAhMn1Mol15QOLn22CFFFOI2vPJsfhyJFrYlPkUqclAMI9jkWiow1hRo15KOq3w2l3gMtJd+SbjygS8P/OP9snwaYksWZfKCLu6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508457; c=relaxed/simple;
	bh=/j78Xk1iSJzE0ZDQaLLRImHhCbOwUfEfPi+shZe/Znw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahRrtvXwlJ0vp7HthBS6U9hU4igcD1cxZy5Lm7FReXApjg0YGWn2iiP65KLRlGW/XfH6mi6mNmQQvevL6QsqLPTdqg5opD4mMJBGLR7DCtajGovX3kP2pLxceyNUNtm0fccjHW1Ar8TGM6L7IMRPUMRiXDTTe4jFovbr/GewCc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oxScj8dS; arc=fail smtp.client-ip=40.107.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OX50LP4NFCpbbjmsanwZMuEbgPA9VzSJlbEstsb/ZsNj8EdRE64gBGDtVFuc+7IUTVdMY+hsmgqb02SbHywq7bjhaP3nIMUAZt2yZiobuPgpiOfnRhMh5lqhkYQJsB7/GIj7nWYnpkJ0bigdxJ7QswRVDyRNk9XV5tUNNGWw4EZBfCDy5uSy7SU4TiPKVxcCd7I4XrjW3Cvt0bEfUDETiNtbkOOWAd4hZGvaPgjRlSobxmqaziuXipRLglPX+Y69nYBpuJsR6cV6WWvDZ8sK/mKqQjwSVbeRWklsFE5L9KVYNptoTzUYAD2p+FaV4ySs3IHNk74C5uw/79r4vW/6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+jDYRpLemxdXeCsES28XU2xT3qBnfpoYrcuurWre4g=;
 b=KhSmE4c2WMFKFMTDs1950nAqMJrAvHjHfqIiqc53uaemBVPRv9o2pii4iUrzFrBmeCNvjz62YQinLirswjsSJywvFCro7+eF9lfnX53a58xBtXeyr339l0hGLd76BnMUXdPQCWIEaiJ0exQEJFckuzcdTz6Q+Gu6sq8KiF/Xz0oQDdJQ3QU1XJDotQWj6lgLGdNsyP7/6RKZq+lH6miPxQeFNowWawyLKlsNALIMNSMn6rtIvzjobUnaXZDnfxxlI1auCeYHowAJJhKjFWU3whmHVMClISpxcGMseIylseU0H8LnShTZHmownb+hkh6HrALISDamcCPpXdj7h6TeSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+jDYRpLemxdXeCsES28XU2xT3qBnfpoYrcuurWre4g=;
 b=oxScj8dSE3jWrr2FR8A6+S1EGG8XuCQemqWI9i+dZvA+zWejiizG5GyNloXqO7QYQCphvTjU4aEjOnAkJOJ5SyTk8/o94HmnS49BvCN+SJ5/GCrrn2etvzn2wuqidanrFBBKOmy7Jrhlx8FkSnk/RVhIla08ZkvxpnymkDlPXSfU9Oa8g+kQV4takDaJrQoWm3pbgt0qDt4XYmzz6xHIWajAtVepU8Lgp9Jjj2eqToCReQs8dCF2a6J+Zh5AN/Y6bSnXS2BGZW3ij9bPBd5vnh3yXyhENvIOp6Gy7ouKxKk9UelVImOxjVXBhzOYio8xGpLQ6Ztkvpw4irTtKSACng==
Received: from BN9PR03CA0760.namprd03.prod.outlook.com (2603:10b6:408:13a::15)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 07:00:47 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::d7) by BN9PR03CA0760.outlook.office365.com
 (2603:10b6:408:13a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 07:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 26 Mar 2026 07:00:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 00:00:30 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 00:00:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 00:00:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Shahar Shitrit <shshitrit@nvidia.com>, "Daniel
 Zahka" <daniel.zahka@gmail.com>, Parav Pandit <parav@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, Kees Cook <kees@kernel.org>, "Shay
 Drori" <shayd@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Daniel Borkmann <daniel@iogearbox.net>, Joe Damato
	<joe@dama.to>, Nikolay Aleksandrov <razor@blackwall.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, "Antonio
 Quartulli" <antonio@openvpn.net>, Allison Henderson
	<allison.henderson@oracle.com>, Bui Quang Minh <minhquangbui99@gmail.com>,
	Nimrod Oren <noren@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V9 01/14] devlink: Update nested instance locking comment
Date: Thu, 26 Mar 2026 08:59:36 +0200
Message-ID: <20260326065949.44058-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260326065949.44058-1-tariqt@nvidia.com>
References: <20260326065949.44058-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 52337ea9-414f-43b7-e161-08de8b05688c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MP0yKXLeD9JAQRBpznElt56DWEWuIKGgEF/I6uJY3SrKa11FFCGU+uYZ0Mv5d5E0NgejBg9TNzkC5oJ6AKGG6DPe2CpZQ6ajKLzp73bjkiinzxIv2AMZZexP5XUoActhoYYQ9TXJwrofiywHniQQIx8hFr5HD4RkCQdlXscR5n6BnVPMuFLuBvSDPlIc3RPC2Rw/KE82c9H7anJaIKAt30HwCNEYzrrDyNYvfMxpcno4+KQbg6q7rUF21CuN5U40sUAIGQQu+Hx7wLU5toRWMryLCpxhJcyTnuXhgBZD4jL5kGZxJ5m0W8t8WT84EF9I7Sn+JH+LP/YXT7tBR4AcvjTj84AVFLB1Dsnw6pE61dSJ789YR3Brcpq7MJ8sdHLe7BUPi5Rq5LgjXsqzcDM8QDoK8tWeLjSoza/H9GAh62RBpOZfVTCAwsFbIGpeI6QFw8pCQHQpdYDuAn2EFcjYVkY9+L46yjTgYmXZoPgpHWj6+7fVeu0gLj4DRSX3BHiVSmKXmvt7jUG7LNSS6dtVmeQDFD/n0n/ckBT7mBOoMlM5ZuJJRCJUk27mjat37o0P3M4gX7CcaaOyXrgMKloC0YwbpBX+Gcj6QEK39Ub+mlocGjt+gdQfrkDNlMOwND78noUa1WvZOzJkhxLT0LIeJBHk8hItD1GARAUnjNsM3jSYDkjva2Fyy6YhrrrlbtxV2TOQoPe2DuEMDCdQcXgEMBuaK8ybWqHCpdhwMn509ZHfrJ5L1Tr8HypZ9+vJ/AOCEIDFxVMKOxUnn2q8fyViHA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8mwS3TGunp3qEVqpyxrqAZ+G83ve/LCgWG/wvZgjE1pKqWcLc3FMk8YS9cfIm7axYIfhvxyihL/xbgwqmJ5EfqGlGeDdJexUv4kmKGThtxbj7UOc+JlDbLYW0PQxQ4bhON/NQpScYMO5TjJp+8VB+aMnod3g0Tm+8bgPR8v2ADcwQkBvW5qM3jw5p9XHtUTECi+WflSz9qmW/THtVoFVmNB1J7+A6SYKrZlvnflbGSdBGjv5Ixsxb0JgP22dwvQdgSXwp012+IZk3sylwBUS24d8D4OkTRJ5AvTfj1lPCwFUYPNoTmgbZkKMh6WYsHWbOTwz6sIT8PhO2XWFEzaNSfrenlOekt6uKGPMxpBQyOHCkWb28Ggg3iV6lIWWmTGkMXzE+NatZJ4Q+9MFyQx8jpRS6ocnJRCxsQhtJb6AhWRRPbBB5PzGH4Mpg+IGfDQx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:00:47.6721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52337ea9-414f-43b7-e161-08de8b05688c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,google.com,davidwei.uk,fomichev.me,iogearbox.net,dama.to,blackwall.org,linux.dev,redhat.com,openvpn.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18683-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DFDCF3302AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

In commit [1] a comment about nested instance locking was updated. But
there's another place where this is mentioned, so update that as well.

[1] commit 0061b5199d7c ("devlink: Reverse locking order for nested
instances")

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/index.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index f7ba7dcf477d..2087c2de5104 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -31,8 +31,8 @@ sure to respect following rules:
 
  - Lock ordering should be maintained. If driver needs to take instance
    lock of both nested and parent instances at the same time, devlink
-   instance lock of the parent instance should be taken first, only then
-   instance lock of the nested instance could be taken.
+   instance lock of the nested instance should be taken first, only then
+   instance lock of the parent instance could be taken.
  - Driver should use object-specific helpers to setup the
    nested relationship:
 
-- 
2.44.0


