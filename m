Return-Path: <linux-rdma+bounces-21868-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wrBbLQMSI2pvhgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21868-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:14:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7FC64A797
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:14:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=lpTJbRzZ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21868-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21868-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31CD630765C7
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 18:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF5925B0B1;
	Fri,  5 Jun 2026 18:11:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845E39DBE0;
	Fri,  5 Jun 2026 18:11:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683113; cv=fail; b=pUJfp4JNG/fdlfhWxxc+Js2RNY4gsBgx8GPxaO8HC03gs5ucT/zeUvT5gBpZ7kcx20RRejALfbrJZmOz6a+hnQq14CkZAc1GKPw5JfXuZTt6MwfgX2NzSQEq8NNqApX9ciRM1hfwYtQmcHeQoi8yw7Ebjtvq3oHDg6E9WvSXGmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683113; c=relaxed/simple;
	bh=kpnVQukCU1Mcla1q7PpvYJRSXbDC80brRfXd0EE9e/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yjgh+HSImCebBazJeKVOtMgXyBNp8/vpVWYVTufEvwcKiLd/+WKPFtUxubZmbTdDwWt03TI35YwJTsCx0lTsJFdoOHizusw79/n+hMk8uWwCi+JwMThyrEWOa7mHNcySGmliQbZ7AbniZecatBQ1vOoEyqoligkYUGTSCJJGLX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lpTJbRzZ; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMHmOzNwx6DeUo+XHqh0gzNK8NY419YdvNGdtSB2U+YGcwB4YAuAdf+FVk4Jpq+76c/LPWqsEEzKL56j3xM66iYojC683edCx5I+EwDUjun3Z104WUSg+BsJiThtgZ9OUvv67GhP/ilyC2Bz0qZvBWxrdXF3X0scx4CE1hVXN9DicyZdOIQu6UVcBRQV5hIXIrPoNqy0Ux6zfOSkMQA1237hywv/DRgrG49WcaQhK9rHsQRxGWSD66ffoRo6vj7VXQ8lLg9BvCnzR1RJKY/+2ElbMNGfOVQ8fvZO5N2258swkT/NBTx1nBM7sS2tuCFIqegYQdKjMhsYX3O+FjqbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvpfypU4MLARQrkfqPs1YQldBWZT/5qOHc4vsSRYtW4=;
 b=P2d5BSz7GuubKrA6t+B2bOldanaMLjOXIjbKFdP6VMZ854Hm3oF3BWYo+xxAQZWBYF+UpnTHMseI015bBat1HYDQVyUVNGRBpBh80rqtSTIe3TONdqOMwl6Keo/pJjzSpICGIdA6HoHe5HIPpyx6TF1aOffssYGcm1T8bHF0LN89yVtLhY16WiKciPxljhg695Gk7PSPNMDqmD20fQ7b/kz4yP45D12LHIel3D1pSkbPxnzg2xH+DGtbAvv2K1Zycqt552XFVxpZBElzyVRn23Zs0/VTVfgSrS4XhktpueCNI1pKt6mXEVN2hqil72gfhQ3DEKo/tMnFHg38O8hC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvpfypU4MLARQrkfqPs1YQldBWZT/5qOHc4vsSRYtW4=;
 b=lpTJbRzZLO2EDzCKUz52bCEmgItZbO161o06tMZI5JlJDYxhsoL6vSj7NWtHJavffHywwmGO6REDvZnk/qdGic0ii/l5wHLDVdtPwuR65sEKwVo8Vxgfgb8+yipLlCzp+4/Yqvov61hm6H4bH0Fv7yNOOfpBRti6zbv1sQyQ1AiVAo4BFOy3tMvT/LoxLacgaUksTqmSrbUwT8yELFqBDUnXUW9KSfZB4wPMCium19Qt3Ah9g9DUw58uO1mz8j7jRizljJDzgVOrT/zspggl08/4TqNsDWkEpgDJgFXr2UzabOK3OhITRorbdlhV21Wd6a7hnOt2V7Pl6tDsttpPDg==
Received: from CH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::25)
 by CH1PR12MB9695.namprd12.prod.outlook.com (2603:10b6:610:2af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 18:11:44 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::46) by CH5P222CA0009.outlook.office365.com
 (2603:10b6:610:1ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 18:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 18:11:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Jun
 2026 11:11:18 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 5 Jun 2026 11:11:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Jun 2026 11:11:09 -0700
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
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Shay Drori
	<shayd@nvidia.com>
Subject: [PATCH net-next V3 4/7] net/mlx5: Register devlink after device init
Date: Fri, 5 Jun 2026 21:10:27 +0300
Message-ID: <20260605181030.3486619-5-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|CH1PR12MB9695:EE_
X-MS-Office365-Filtering-Correlation-Id: 6045a40d-02cb-49f2-a72b-08dec32de69a
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	o4fbhzA25QUgCEHwdSy00KASEx6Tc4eTN3NTy8oMo712HINxIxGu18s6Gor+2aljzj0cPl64tF8PAv42IlSH6ZzohaVtD+0UbAA2N+rgtYNfhxbx6BwpQ88C3ziuceQpeSj8IWKERiQlL53OxdQFiFDXw1oeYeSvnC9Rt7yr8BTW1D8+1USsEDR6udPkWFc9uZtACrdXbWCPvz6MrnG5WSEjGpnmq8xOwCTMfPDL+itAkE7tSauOsXGECBvTDx00synvBYbjacnCmAAg++ge1/aEDFTEbUHOv695SSZemV8Tt62tipkzDguDlRQYoLAKfhHY8PdQSVud+f31SNXdehUcPdup15Y7PjPyV/TLkUdIN9jGI/TpiNdJB4yJhma6peQU+pxNbS6xwjaCZdGGuz2oCAydnrrEQeZMvDzMXpW5KMpLfh+N2q1nEhHXrSEQY+5pQLh/0fNyy/cdzdj+qlkUitqHSaP4CA7UwofrtfMxqML41IG2I8k5t73RWB2j6sYzK+L6PaGdMZIf4Mnc/qNJK2VYMDukOo/EYwYfwwnk26Xh13ADRoPHizNR0xSjErcXkURcVRgtcw+OWU7wIN9baKWR3oSjBp/9aIiw3+EKL694BuxZwZ8ubyGaYv6q8RnE0dzlNRnZJfXW1mhiGWk9BEfbMIiAZRH+MLrRFQbGqlRmAU4+5gsx12OlCklDBy8Oc5EYVSVzKDyuBZPJh2rXcIsmubO7inpPpbMlNOY=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KaNePOcfClsobsO9LEVq79Zh3g2EZDM6LDc0KaiqLeO0ikGn78jQYGRmcN/t415WULiELP4ox27O+ieCF7u9IUzkFtL/QD++fSwQjacjNoFCbkm2H3Nm36D1bkkwMfWsSant6hFXeQ0CGc1bV7ClOiJkFnYCTuEgEEO/UGajXf3EoH99LEwn1opt2kEURQWnffHM3UECP/e3gUcqicJagbfhwKwaWZLK4wIYNgWuHgTvZtyIiCflhBZgahJo0yH/kV/PPt7tjss67PmQ0xUnx11dbkkea2O/uMQqGbH2roMjgVrnYLfafhtdgPWeGpPrYskZmk/tON4QdzHrlQM80oJrZFFBKLvWafbsszWA7oGnWFRqnauh1rLcGJ0/rsyLPHh6EGxQ0qdHeNDP9t+svtjbOyBKTRMqEqKGYJOrzjxxTjaEQYbOypUzEFSs/tpK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:11:44.1890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6045a40d-02cb-49f2-a72b-08dec32de69a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9695
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:peterz@infradead.org,m:dave.hansen@linux.intel.com,m:vbabka@kernel.org,m:brauner@kernel.org,m:tj@kernel.org,m:feng.tang@linux.alibaba.com,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:shayd@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21868-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F7FC64A797

devl_register() makes the devlink instance visible to userspace. A later
patch also makes registration the point where devlink core may call
eswitch_mode_set() to apply a boot-time default eswitch mode.

Move mlx5 devlink registration after mlx5 device initialization completes,
including the lightweight init path, so registration-time devlink
operations see initialized driver state.

Move devl_unregister() before the matching teardown paths, so unregister
notifications are emitted from devl_unregister() before mlx5 removes the
devlink objects.

Add a devl-locked uninit helper so failed nested devlink setup can unwind
the initialized device before the instance is registered.

Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/main.c    | 34 ++++++++++++++-----
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index fd285aeb9630..4e3cb6ec8630 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1454,31 +1454,40 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
 	return err;
 }
 
+static void mlx5_uninit_one_devl_locked(struct mlx5_core_dev *dev);
+
 int mlx5_init_one(struct mlx5_core_dev *dev)
 {
 	struct devlink *devlink = priv_to_devlink(dev);
 	int err;
 
 	devl_lock(devlink);
+	err = mlx5_init_one_devl_locked(dev);
+	if (err)
+		goto unlock;
+
 	if (dev->shd) {
 		err = devl_nested_devlink_set(dev->shd, devlink);
 		if (err)
-			goto unlock;
+			goto err_uninit;
 	}
+
 	devl_register(devlink);
-	err = mlx5_init_one_devl_locked(dev);
-	if (err)
-		devl_unregister(devlink);
+	devl_unlock(devlink);
+	return 0;
+
+err_uninit:
+	mlx5_uninit_one_devl_locked(dev);
 unlock:
 	devl_unlock(devlink);
 	return err;
 }
 
-void mlx5_uninit_one(struct mlx5_core_dev *dev)
+static void mlx5_uninit_one_devl_locked(struct mlx5_core_dev *dev)
 {
 	struct devlink *devlink = priv_to_devlink(dev);
 
-	devl_lock(devlink);
+	devl_assert_locked(devlink);
 	mutex_lock(&dev->intf_state_mutex);
 
 	mlx5_hwmon_dev_unregister(dev);
@@ -1501,7 +1510,15 @@ void mlx5_uninit_one(struct mlx5_core_dev *dev)
 	mlx5_function_teardown(dev, true);
 out:
 	mutex_unlock(&dev->intf_state_mutex);
+}
+
+void mlx5_uninit_one(struct mlx5_core_dev *dev)
+{
+	struct devlink *devlink = priv_to_devlink(dev);
+
+	devl_lock(devlink);
 	devl_unregister(devlink);
+	mlx5_uninit_one_devl_locked(dev);
 	devl_unlock(devlink);
 }
 
@@ -1636,7 +1653,6 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
 	int err;
 
 	devl_lock(devlink);
-	devl_register(devlink);
 	dev->state = MLX5_DEVICE_STATE_UP;
 	err = mlx5_function_enable(dev, true, mlx5_tout_ms(dev, FW_PRE_INIT_TIMEOUT));
 	if (err) {
@@ -1656,6 +1672,7 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
 		goto query_hca_caps_err;
 	}
 
+	devl_register(devlink);
 	devl_unlock(devlink);
 	return 0;
 
@@ -1663,7 +1680,6 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
 	mlx5_function_disable(dev, true);
 out:
 	dev->state = MLX5_DEVICE_STATE_INTERNAL_ERROR;
-	devl_unregister(devlink);
 	devl_unlock(devlink);
 	return err;
 }
@@ -1673,8 +1689,8 @@ void mlx5_uninit_one_light(struct mlx5_core_dev *dev)
 	struct devlink *devlink = priv_to_devlink(dev);
 
 	devl_lock(devlink);
-	mlx5_devlink_params_unregister(priv_to_devlink(dev));
 	devl_unregister(devlink);
+	mlx5_devlink_params_unregister(priv_to_devlink(dev));
 	devl_unlock(devlink);
 	if (dev->state != MLX5_DEVICE_STATE_UP)
 		return;
-- 
2.34.1


