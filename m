Return-Path: <linux-rdma+bounces-12739-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68E0B25AF6
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 07:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ABCE7AB501
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 05:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFCA241CB7;
	Thu, 14 Aug 2025 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sOf0cHuh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9532405FD;
	Thu, 14 Aug 2025 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149995; cv=fail; b=ZoxyqM38bRdiyw+T4PgznFLzMsLBHxpC4iugnkfknr3JP+4PaAbquP0RFVNkqvqyzhxGemjcpoD20PEwuyf6MmF0ols+616LcKGdM0MvvVCrrYCG+Ubr8bNqedXTr5w6Ppu2woH8oIDAzLhbrIQiP8qJjMj0k/Jw3mckbsgIQeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149995; c=relaxed/simple;
	bh=NfROQPYeGxHoicQQxDjEDs5h42zqtaKn9+xjzZTPuQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0RObnVUJJe2e7ikRa6E4NmQ2yRZztvyQpkUkSVZcekVhM8wulIBKLQ8wq8bBor/Hi8Ja4p4EJpwmwBAyLWWAQ3lHNSsaT3B2Yoll7Eupo+rVI+dqE2cyIbgKLvrTBHdTA97wJN0PeqUHsB26LNov7VkTQv/5HlquEbXrsdrmAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sOf0cHuh; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkrrL+E7sPiKABhrmHwvZGSmi1by7EggqLdrslKljaoOoTCnUZwY8bEBWnzzNKdLbMKxKHnbxWEo979ljjg5oZt+MAS2g4FmjC0F4Aw6BG2fldWpeFvYwqsZmjTQK7kVIFo+M3QCINlJ6ZPlDhh4SbO2VcU3ZFYZW99pQtI3ErYapXQ/BcEJ4+tZxYvADxB7QqDC6COVGDvwTfSojWzeGuAtuV4j7MJcwgnjACCHACCMpOMo3HXkrlddxqj4PRSynI2qO9EofCYd2Yn8XY0di0e0xDN5Sez5wRmSRhz0EhhHxJHyJUWLgoA3i1Ta9i3qOAGqSxLuOxGurKAV66i3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpRkPx+dQVGxL2AILTyXPMS7gdxA9IxJorx8b13lVVE=;
 b=a3wG0Orc4Bdxocnc1POh266qvh3ZqWSFnh53O9qPbB3cWhwocOhPwklpdkTgS8WR+ScTKCH5y7FFALGuzTfHGIBN2WscFAk7hf1mWvdkWaxbwe48yviTPbKAy1GbY9EsbRDwsUq7THLGm9DBxdPVIj6f2f9Ox86HHz5oVlrvdPLHQ9ec4HbUDhpQ/hqCxgu5WFQvqIIe6tbFjaq4f+vPVk+tfKeNHuqEXStBDskML6m1j6M5gabFHDJCplMDhNv53X2YDKyyNVPnyZ0LaeBdVTUpnPpyzr37hWZkQpNyp4Ftqrcq4E4mNtmTevsZPzwEQWDIlZjb+DFh7/jq5VbCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpRkPx+dQVGxL2AILTyXPMS7gdxA9IxJorx8b13lVVE=;
 b=sOf0cHuheIWJPCe3uNzlBlwVctfNM4XWAHjwMTUnPyljSxJKu8HkbPF5ksJc9MLjy3cHC5G96RXt4Ks5CP1cGd7WIY0/NRHObHEUfQUix9L8I9Jls60D+r0TWuH7UTMi9dPBnKOartr4LQSfRIEkVp7veD1zjnCCzOKX3FZo8cc=
Received: from SA1PR02CA0018.namprd02.prod.outlook.com (2603:10b6:806:2cf::26)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 05:39:50 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::74) by SA1PR02CA0018.outlook.office365.com
 (2603:10b6:806:2cf::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 05:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 05:39:49 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 00:39:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 13 Aug
 2025 22:39:48 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 14 Aug 2025 00:39:44 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v5 07/14] RDMA: Add IONIC to rdma_driver_id definition
Date: Thu, 14 Aug 2025 11:08:53 +0530
Message-ID: <20250814053900.1452408-8-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
References: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 354da2dc-6a65-4198-b131-08dddaf4fc5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?II9omzmSwDSis3fxe+tu9gUWpJQ1vJG/5VWCs+6IOwHmBx06oUaFYHI6ePY3?=
 =?us-ascii?Q?Fgg9anMDwR6o07IBS6qcFMDIbsyU41HTpB3g6Q4yuC8nQj1qUXRKpnOikV+B?=
 =?us-ascii?Q?rFNrQPiK++5aHuLRc8YU7tIzVOPlJ81GCVG4Q0/wO/idaHB/IclgDNJT3uk7?=
 =?us-ascii?Q?sbY+AI68oyJhihaMItHxF/xuxNV3FKUxWGDD5Cf/g9A8jyWoTLC2IGdPM9Ih?=
 =?us-ascii?Q?EarusXWZ2ylBWDCEJFQa7APr0V6XTdJJKTL0fMM9l/hfAScSY8UxJxtnsBh9?=
 =?us-ascii?Q?JOjwLhJajYvSmitoW0ZFj/k0U+an4y1pOHcnHIeEhe1D284mqUeK3OGM7RJm?=
 =?us-ascii?Q?/aUQyJUwTP8vqMs2wtHSpjUiMSsCgbpvx0hiwBhJnlB/fkvmHOj2y+PGM0zI?=
 =?us-ascii?Q?HaCGt4OOboq7g3PiCacZwfDr/AiChZoKhQV+CwNTghKTJktkgKPphoniAMLX?=
 =?us-ascii?Q?LMxHS3QBgtctKarN03clmQH0UNCu5CwD5BNMAOCjXVQoAzJUqq/FNKK3U5VJ?=
 =?us-ascii?Q?zzQEG6/0tNKECy4hY9seboI2GXAmzrkdQQx1G2wpKDQywq58daCAt2Naxigp?=
 =?us-ascii?Q?WgPi1wrUE+TYgSrhd358K56CJBoHFjiOJYT+EPZ0uxiEsuDBnjG9Qbu0hws/?=
 =?us-ascii?Q?63Ypu5/TOlm3udgBwxH1C5cox6j/OC7OY4DQNA9N0sczK0a+RSxAFBdhkSdO?=
 =?us-ascii?Q?GDbdUhdMAD8Q1p8u3xuuwO7VbrdYgk4miUfSdpz7Ik7Ib2NS0MhYXNfgsjap?=
 =?us-ascii?Q?jXsObzdVNx++LUeVJKO31SxH+7a9UYqXmhz5LO6LrfjAHf/W9aGud2mgmItw?=
 =?us-ascii?Q?0XNXLItIUFeOLohWrGvZc9ZWBV2uNkZ6FvS19X31SGGkT03txkmmwfbBC6Jo?=
 =?us-ascii?Q?eSpGjCzfPFS/9sjoTkmC9Z89RC77DhnTn9kQHfMH0PLMSASR+PzZeleTS7wG?=
 =?us-ascii?Q?zp8rRqaL7/gim0eslK7jwuPrKrbGwQzbsipioatGnW8/Lu7PQQ1bDIxCLetr?=
 =?us-ascii?Q?GEVjUWJoFYDMnKZ7bHRiRHT0e1xp54NA3Xt1BELU3oQuMI7U14qfiSL3UPPx?=
 =?us-ascii?Q?MZqTl54e1Of7e3U9bnmE9BSIhEpMHXY1Baz0SQ/vsUTZQeis5q6MXNj4oAdg?=
 =?us-ascii?Q?6X+aDqbkWU0SGD3OCmWd5ZLpHHXC/fbYzxEB+Ka+rPHg835pOMdAVLpupjv0?=
 =?us-ascii?Q?VQaTiw2HPem663iBahuirHm8N9RqKGhCLdveapzlTrTWfsOCPZfDhAZRvkN4?=
 =?us-ascii?Q?qz7rK7PXMqxmB7O3H2Mb5P1ahyol0OlBjINehchb/iQocieGy1axyOAvSUmX?=
 =?us-ascii?Q?1qfftn3GKLCgE0LFyC57i0ZqQYSCxaiLFglLh3G3X0+Sp2CgLp1ZSBp3zV5+?=
 =?us-ascii?Q?bC0VXDpbEQfiyugtjAcYqXCj0Xl8KNR+kZijOQuLp7HGO0zQaCdsgC2y0Jsg?=
 =?us-ascii?Q?rYbsJq5hKHwx67Lk6i17Pyzm7R+ep5TNCeolMT1Av5NoQg9CFQZ5pUn6k2Vi?=
 =?us-ascii?Q?O/dVQ1VQgZVfyejyw/6BbqJWpBbyi159a3/A?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 05:39:49.6777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 354da2dc-6a65-4198-b131-08dddaf4fc5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524

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
2.43.0


