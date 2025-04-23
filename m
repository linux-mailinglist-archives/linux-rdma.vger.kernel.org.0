Return-Path: <linux-rdma+bounces-9722-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8837A98772
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26715444579
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D732749DE;
	Wed, 23 Apr 2025 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vDXMRKtt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39958269CE6;
	Wed, 23 Apr 2025 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404278; cv=fail; b=qgHNWC3l5Gzc8IjvSgnRieVCBtg/fcMUaP2JqB+D+dBpEhmLQfZvgbb7aFsDpC4h+SMsZs2SMhhcShbkp6J6klfN+4Bf9hLCWmlJPJSZuE1A7Q0gVDGXSqGyDPuGqpJrpK407JWjqp5ZBPEiBE5J8Ynn06T+VmmV44sJc1st15U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404278; c=relaxed/simple;
	bh=8+NtQf5lkiRQPrS/xcz6OK0iODeCy7ElP2SsFMr69ak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGlLXE1+xDhVDdtq/HKVBWmK3hgYnjYtjhCPBh4KYmo8+WKhd2paQUqdmrv8/1HNKuSxKzJUeSZa7tBtMB8lTx+vieJ6fdzOcf/1FLKp6WLTAlog8c9Fd0PirvYoHnmlRFdYtgaZ/q5cKqFeXQ47mE4pvi87gwpi2GUqMa26EXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vDXMRKtt; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8tyEIpGnxJQwUNJKprpIUv/FqdNsd6/vwJf+5F2AljbhxX4dzHiQNTSOc2+2H/iF8Y2/q2iCjvIBqprB1+2j3rJlbdHtPLKKO3bmlpEwetLa2iQCNBQOZ0DHePJqghCInY40hOKOxyMIrVnVVV+aXbtr8i3+6UvaT5d+88nMGBgFlfNXuyiIGIIg3GPQ2ifha/cnNOZ89FXbNsM84CjFaFbUspT3P4IwtHFECVPYAc5tRRjy14s5LYtCGyCOHv1/+btln2LTRCppNoqNrwTaeWC7UWc/78H2B05CBfkdWXtZlykpo6ggBPdgiMLfFgsmv9jzugskNqgAMRpO4Dblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s70M94ctOYpR99iVT7Q0DBV8zpCout837W9PlFOf4QM=;
 b=BLlH7BTiu0UAIVV/0T60PHQ02ATDIQ2aFYi2zSSFoWZdDrwNDAFXTSiygZUwLR1ZYsa8NiSJSQqmQ6nxN62vZNySsRBc0EnFMOOczyfMRNdxQGTJs/bE6qGLlKV9kSLv9SXPKyrpSrrNYLwM271Cku50AoaPvMvoXvwwHyhOb92HKLk/oysFDGJZQQgHVQA1GBBXA6YUHmCTHhTwxhDJUlhXfR6byRClzfDvmwWtF1Ze7oio8XLOV2zJOkkntAGuB5mz01/5v/sPkbcUi0GgxOcn5vmfQlt1FzMtriRUBa0o5Sfyc8qP5UzMnPEoa18byNklYAGPFDTRB8bWH+lrHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s70M94ctOYpR99iVT7Q0DBV8zpCout837W9PlFOf4QM=;
 b=vDXMRKtthIk154F5CGzXW1UtPTVUsTjRKYNvBB0+xSGAcwYZfy5/7LHwMGKJzj3rcLnASUWJzBtcEZKbGnpTwu01p/T46xgEswLNQ0jKmwhXe3ElzE/0qfTgBoFSuhllyQIUbHxXayuVBT47gh944wA+OFnbt4eUm1SzPBTwW6A=
Received: from CH2PR02CA0001.namprd02.prod.outlook.com (2603:10b6:610:4e::11)
 by CH1PR12MB9694.namprd12.prod.outlook.com (2603:10b6:610:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 10:31:11 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::7e) by CH2PR02CA0001.outlook.office365.com
 (2603:10b6:610:4e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 10:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:31:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:31:10 -0500
Received: from xhdipdslab48.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Apr 2025 05:31:05 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH 07/14] RDMA: Add IONIC to rdma_driver_id definition
Date: Wed, 23 Apr 2025 15:59:06 +0530
Message-ID: <20250423102913.438027-8-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423102913.438027-1-abhijit.gangurde@amd.com>
References: <20250423102913.438027-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH1PR12MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2d3687-b831-4e05-7d12-08dd8251f760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XSu/aCXoWFBf229sJ6+cm2jutmjuYbC8F/Ghyzsg318Mdp+nkQ6a/JZfMsTr?=
 =?us-ascii?Q?FSZonbNVGkxrwP8oICAPktLMAzOWwETvsjMpPUkz8V4fSbZcldi/hQXUqAro?=
 =?us-ascii?Q?cYI0MgvS5GXlgKWj/svwLomnDv2hC2bVOCyYJsVH1CE7g6lOpNBebsdel3jy?=
 =?us-ascii?Q?TKLFc5T5yvgBj3ddD6dRIKLA7GKwv6kpaZton03lsxU01r1S2uWBRqVzNpHD?=
 =?us-ascii?Q?0v/HJwoXZBY4b1nYR42uHo5QRpBmuX/Xy7O5OH+h73Ly6TGQnsibWlqN9tm8?=
 =?us-ascii?Q?aVMFJZo8HklGiZu3kr/Kyakt6vuXNr2FDr3XPbxjuhHj0tq+gih6JqkME8c1?=
 =?us-ascii?Q?MTWskZ7cGNgHQ9Ye6YlXRmWs0twvYmVgF1Zd5lhmVCKuKWG5o66jRU4Li3ff?=
 =?us-ascii?Q?afnCg5kIOaOm3eRGn2DLd50Hjcd9AufNFyXK4TQeY/PCLjrxz6O4jvFcmibD?=
 =?us-ascii?Q?6TefmwoWZ8W1J9La8L2jEjbNhyeUO8iTrpFttxEMPsPLRZBCFd7sywGp9ndM?=
 =?us-ascii?Q?CLqJMZUQ2cVLrqoHrw+uqc19IcgwHGrnDbhzOihJgzSZrNUD4b0tm7rV6vFp?=
 =?us-ascii?Q?MyeJszlagp38LQVTFGyA/nFiw5EEbXtCJtgy2PouE+AXHlhkjcKSNSkS/XzM?=
 =?us-ascii?Q?ss8O00ckmxE1/L1i/GZ0LHsrp8MPnDcXQ7Ooo65V0hk4ZsbZcQ0eFIHthbE6?=
 =?us-ascii?Q?EWRVNcyc8TAfsn5AfPAkKPHZ7KDyZugZCwmpmNKEBXtMHtFk3YANiA+yPpgV?=
 =?us-ascii?Q?elzJr8uO6vB6oVEl6UYj+4QYNP/rQ3SZ/63OKrCOyjtsKelMI4hrtBee8O9Y?=
 =?us-ascii?Q?P8v0yRZKn6CArseovFKL5NFLD6lXiGI6oJOLxqtwmJgaF5IgHue5qhszGRgo?=
 =?us-ascii?Q?L0KfrnO7+Dp1h8msR7uQFfH6jdjXkN/a2YHBGwndgbLVMnP9L0Eh+uYa9169?=
 =?us-ascii?Q?fZJxfAneZ5QIrysS0a/MctXlYDV2aMhtPjJuQfKfGR5Uj+NEYTTr3kEulZkm?=
 =?us-ascii?Q?hlmjteSFK4o76mZw+3mRiUyVLep2JzWF28fIFr4K33ukQ0rxMj1uAN3M6vyf?=
 =?us-ascii?Q?uv8UGirDkl+Hhtx/hraumZHrnlM5ncseqqNOj6Yg6dpVjhIhlGdl3txHi4dI?=
 =?us-ascii?Q?bkKelKXV4Nfi5LCuhfR+krBWseWoYyu6yrRsv80Ws6p7YrIx3L0/hDjjYVaK?=
 =?us-ascii?Q?dQvWk54UzbJ90gUCKnxKS8bDwC2wWH0k4Vt+y3Aqxu9D/tvxDqqqhFq5/9Z5?=
 =?us-ascii?Q?z64hbp6gFRrlF+391VADcU/AALUe7uO7dk8UUI3wEuVNWY/hP5qbDY8x3cRL?=
 =?us-ascii?Q?NcHT2fI9b4Kzddt6D2oF4z2ff29mNugslJPH0vNJz0nEoGxXdMRA5GnXSOcw?=
 =?us-ascii?Q?fKARfkoPO0dPa2ALG10+GG0eiMRKT+CWNHV53eZ+WR0mIUUZD7Re/b3vHdva?=
 =?us-ascii?Q?O8F525jbFqaRUqL87KJYzZ0eJFTNcfwoR5KveJt0diBTlnPyUiXAwDbvl7NW?=
 =?us-ascii?Q?U3RkBVSoicjjO0Eg9kaMKyykzACoufJth9VKNAxPsByUkg+4QWwyjdNmQA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:31:10.9954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2d3687-b831-4e05-7d12-08dd8251f760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9694

Define RDMA_DRIVER_IONIC in enum rdma_driver_id.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 include/uapi/rdma/ib_user_ioctl_verbs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index fe15bc7e9f70..89e6a3f13191 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -255,6 +255,7 @@ enum rdma_driver_id {
 	RDMA_DRIVER_SIW,
 	RDMA_DRIVER_ERDMA,
 	RDMA_DRIVER_MANA,
+	RDMA_DRIVER_IONIC,
 };
 
 enum ib_uverbs_gid_type {
-- 
2.34.1


