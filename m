Return-Path: <linux-rdma+bounces-20071-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNmzHt82+2nUXwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20071-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 14:41:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2844DA598
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 14:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94EC5307EBC0
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 12:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF54144E044;
	Wed,  6 May 2026 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RZWZZPxr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5558E44DB64;
	Wed,  6 May 2026 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071124; cv=fail; b=YD7Y22+iQJgO7oqQx0J/irUfnmUN2CDJpZrKboKjM2i14zkp43kYWOTCU1fzsBbczV68OAaJiIbArpDphZRxeoDdSCdyMvHS2jfTzD/7alZo/DNoywgJpDL4aWyyX9ElZ15kqOk6dClmz0llUMjBf4+nXrSgonk1wGmVMxn+rVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071124; c=relaxed/simple;
	bh=MDB2XFcIx+873yxRG3eKHVrN3g+SCkMvmxl5iYO+XHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ev7sRqkG6EAYSQeH7ES15k+oiYc4tmkk+NjpvkedPM0pYNnwrlMGIu7cV/cdiOQXMGFp4BuUxCv3OTzokzj0OiNEB214wmJ46C5/d8RktzBQ3r9wRyxMLXC8dMre34iViWAh/jH3BmDlJ2a/RLX8xsNr8MVeDZDqUPTH0gj+EX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RZWZZPxr; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TA/JXT3AdtUydL/99ZMXNPZDXuUqaIdQFchMHGd6Pz47CkobtRY5pL/phcHI0wmj4e8Hq4jhine4RDn1o81OOTb74YnDs0dxypUHkIibj6R1AnsL1ddx/dgpJamOPtZOU+ODbgBxo6CM00EDFY/45tVJOXyXrYgR/tujJsa9PBxifY8p9QtUmhMD3xnwr+uVMWKrZPr0+yQP6KofQPlCLFlaNVp0ZRkrp3U8cDpb2qdwbethjURBMcdcoNGi0/PW6LZRhYv8xIvaOEIAuailPfbAn7rrn6FiXDTmSvIWo0h4D1NgDIHF1Q7Bkrx3VocxImKKNs7KdjeuuM3CYWe/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHDs1B36ARWF4XzkZaPwt9tSITIn2DLz8wU3G9SHMSM=;
 b=yAH+eH+8XNj4pR2H/1yEPbhBTWwTsLl4NtjPFU3TJfvBMU8kNQ7Gns19P9jztr5/v30h7p7BQcRkctUrUx1IPe2Whi4Ft7Ix4LBlwfYa5WPljKISjSecJ6994JAf4QIy3NnTNCeAR0Y1qJxoQTX/J3UKjyn7ldQ9CjvHXeXFyyB2gxbU3WVMfnw7LHFuEZDSI8RGS1NwNdMVa/hlryX5Y0zd0q99LLWdyTbt06uoWddY4f7y5V4b701zpJr2O8GVPrEl3pKwEUjyvENmldCdGSSbcwXHDD07dByn0M4bppJdlFThxb4HCsoW7Dh2hWIe3OuAd2h2RYpSXv1iYdHxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHDs1B36ARWF4XzkZaPwt9tSITIn2DLz8wU3G9SHMSM=;
 b=RZWZZPxrU6+VOXPtmNeASOgVJQDf3nHJV+kVTRR9tiP6YhtLGYldjZHOiqDiGUAT+zOzLlVtTZFUx4yzGxavAZ4odCYDFhvTarxSlOoyLlbs01xYUqjad74PJMCNjv4fXMGJr6IPRU3D5WvCNb5eJ+E8ouLsaWsQNjGkKll/nFgO4foVFHviJCOUnsy4Zbc1CeQw3aL+qtUTzUmfoh39T2s6g7gsbWSNVb+allqL3fLlXnk+d192vkOGOpiXwH6tbxb/bFtTd3oo18b8xeeJhP9rISCgvzGGmUetIc4EA4Fib99+2zxZH6VqPz9gdggh1p5PQiPA2EliHGCnN0VAwA==
Received: from MW3PR05CA0020.namprd05.prod.outlook.com (2603:10b6:303:2b::25)
 by BN5PR12MB9540.namprd12.prod.outlook.com (2603:10b6:408:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 12:38:37 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::ce) by MW3PR05CA0020.outlook.office365.com
 (2603:10b6:303:2b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.5 via Frontend Transport; Wed, 6
 May 2026 12:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 12:38:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 05:38:23 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 6 May 2026 05:38:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 05:38:15 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, "Randy
 Dunlap" <rdunlap@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>, Petr Mladek <pmladek@suse.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Thomas Gleixner
	<tglx@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver
	<elver@google.com>, Eric Biggers <ebiggers@kernel.org>, Li RongQing
	<lirongqing@baidu.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [RFC net-next 4/4] net/mlx5: Apply devlink boot defaults during init
Date: Wed, 6 May 2026 15:37:39 +0300
Message-ID: <20260506123739.1959770-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506123739.1959770-1-mbloch@nvidia.com>
References: <20260506123739.1959770-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|BN5PR12MB9540:EE_
X-MS-Office365-Filtering-Correlation-Id: c755fb0f-f826-4523-9cc6-08deab6c64d9
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sIvBKBdqqna2dL9kkHxTiTEIWcMDtOstFTSDsKPpR35b70mjXdulG8/OXGBinPL28F685Z36w41t5vLx1Ngbq6s4G/gMDuvyce+OxHuc3vSasl8CDT6pRAD00iCqO/LoHP60ATSvHSvN1ebVCRPJb4glF6ioSBwUuqsyMauZhIEZedpwQbfLeumS7ct7rU/MLpy6ln2DjIKc2sBGAZaOdaKdbxvSGKIcRAZbPpiUZFy5sHOzaZFfRTWAFGwMplA983bLxXGZrllJFk/aoYqyUkgi7GWNtKH/DSORHK9cE8wQ48WPtvKh+1TZG2Glo1iKdVIl/TspDkKat5ekCiNPY6HaqA614n7IIUR8buZhXaFMwyK0MWm59xkH8ngX07Wnyrj6m5YFswNYLyTN7/WW3M/RkF4Pt+IrhnZOcr/ed5k+Hjfv+OCVm1JxPzyaGaHD77/v+gn5niZjbRD81UwaSRf16B1m45s13sNyXdhjs4LdE9nLROnnmCQpkmwN+vcSbotwvOZzsVitH+ttWvBPdsNiLPStdvCTm04fLEEUzIBLsWujhaKD/3LRKKqXWp7uMlqlfATMzwLnIpNb91EH5jqAHaKkeXJDeK5C4r7UnSuLOrb9VuaecdifcXNfz8zOOCcFwGJMXQihF3wCxbgE4Cx29mWftS6UeuUm4Q1zCmEARxWHUF7nEkOrvyL+LgsXhpV9un7089QgtS47puIx59HU7nYUh3tWKgxn6zaXfwY=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RUfGzAZCEY13gnTBIFn1dLnSKgWG9syaobj0YkixehaGQCe6kBfHXfjTzzEyjy7F9N8jQbCSl01hhDgP+jjpO/EsQdG6gNA+jXJwz83iZrxy+QesMGGJesAqkImWipGi3dBVSvTuWPpwiZgNWPNmu7nGPCbqcHf5mYBWhom8Tv+o4kiEc13xYYyESjgWqx/QNtKMrh1mLY5PFFgskk+8nrAdDE3BAQgTIHzrQR5ltDUwT0dFRioWY/nhpiRsdHe4V/w2NoFEVYuen/YFkn0UjCUTwJ9f3wG/yxNS1YmSoUCd9HjgLjWAFAmaUkwSikBQwdh2Gi6QEcqXESqJHH3lavBOLXMzk+qFhqwo4K/j9OqFSNX3ARJv1yiM6WzvsZqTtHunlD5cJCupC3eJGJJCDPIVgd5LfjGKfkiGFL5NEV5IIGo4NT0bqAAho+2uHfiG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 12:38:36.9295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c755fb0f-f826-4523-9cc6-08deab6c64d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9540
X-Rspamd-Queue-Id: 3D2844DA598
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20071-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Apply devlink boot defaults for mlx5 devices after successful device
initialization, while holding the devlink instance lock.

At this point the devlink instance is registered and the mlx5 devlink
operations and parameters have been registered, so generic devlink
defaults such as eswitch mode and runtime parameters can be applied to
the matching PCI devlink handle.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index b1b9ebfd3866..a119d199f9a5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1464,6 +1464,8 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
 	err = mlx5_init_one_devl_locked(dev);
 	if (err)
 		devl_unregister(devlink);
+	else
+		devl_apply_defaults(devlink);
 unlock:
 	devl_unlock(devlink);
 	return err;
-- 
2.34.1


