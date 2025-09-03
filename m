Return-Path: <linux-rdma+bounces-13052-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E52D0B414EE
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 08:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01C31BA15F1
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 06:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5453B2DAFDF;
	Wed,  3 Sep 2025 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iuXEf1pg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0382D7DF1;
	Wed,  3 Sep 2025 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880275; cv=fail; b=CI7iHTBe1FL/RkUhC3Jl8AkxaCWwsCEe7I6ZPaZV7rHOrxa73JYn6HOgP3QhlEy07gPzUozpelOq+jNXNH8FeDCNDYh+gdcFZpzaOZG0yT68CaaK+fjhTaJZxPu9VSDIuDh3m9iNi6NUKYmt6P5X2d18a120vaDGpDmLYotthnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880275; c=relaxed/simple;
	bh=NfROQPYeGxHoicQQxDjEDs5h42zqtaKn9+xjzZTPuQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Asq0hkueuHFQLzr2xvBBjCBJZHZ2spxUxG0jf9/vpjTTGmZU1M5wEd/bnPihI9SPicfDEXII8BXPpasX3XDG5vHK3yiTeN/raOmtlTaVCrHqC/j2vOtJp/RMJsWhRpt4+zQ3d5IdopGi0lwwWjGPoyREHeSL7fC27Yk93SZqwXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iuXEf1pg; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdA//NLEV5gVLnQFT/iK30gcl1sYn5Prqbbs1fYtmEsyJeVOsMSKn6mxFg+T+NbL/4rlU0s3PlXvcK0dZ+djGMW5nHcskkVqp5k8XRxN+RaM9NapONeaHpUK88ocLR530SwbcgpCl0uc0xXKt37iNbX/1ZQZNx6+vU5XPjYk4SAjz+RcYcgRNchCXr8M351OATU6CudJkM2AZ4VrJD55j6fZ0EUJn/SySRh0G8YZzrVPuHK5oEuFs6phyqObF0KOXrWWiDwBV9gU9SxeYzl8SMb3NmFnOMOg88T/zACkBwp3tkgu7MbWE9/7ONQMRZmIN59/nCL4RISiwcCV+OrWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpRkPx+dQVGxL2AILTyXPMS7gdxA9IxJorx8b13lVVE=;
 b=CkxKUxadd4G6BG/RKPH27xsKz2GHrJfy4qy5fS8iTINgMP0B7p+VBEqnQlJPx8XcU3YQnO/UWvndassGwFzgTIVccK1BYAKKZzha8YJCa/EFgtgp/MAJx+51oR+3hjS3Hb5+pMiHt4mFTUXGNDPWipkne3mTyY/jHVBQG4arbtoyQYqoi5uWQrQPtwKbqKfhdkJrVpklfSvNJoTy1rgKrqV/Y/nVGsBG7nouBsuo2TXRqIyWOm5RJouJtkvF/e3+uMT12lcmkFqpO7v+8uMD4KkhdBtunbUHZ96X+3UAtTKspstpJ4ttzy0j7hdceLGpljsa4kMs/zH3JrVlaXG7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpRkPx+dQVGxL2AILTyXPMS7gdxA9IxJorx8b13lVVE=;
 b=iuXEf1pgn49lcfTaZ8/9ys8hzYR8sdiWOTCbXdHztlsZMzv87uc8O0jrCdgX5aeTi2nz/ocNyW983AyUPyjk0YiyuLQ+P7eqkPAhgxH8gmjp5ZrXbV39l+hEaYo8/Mu/EzmG9+4QuSSGkwxQM+f/5QSkeTL7zWzw437/owGFtAQ=
Received: from DM6PR10CA0014.namprd10.prod.outlook.com (2603:10b6:5:60::27) by
 DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.16; Wed, 3 Sep 2025 06:17:51 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::e8) by DM6PR10CA0014.outlook.office365.com
 (2603:10b6:5:60::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 06:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 06:17:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:17:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 23:17:50 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 01:17:45 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v6 07/14] RDMA: Add IONIC to rdma_driver_id definition
Date: Wed, 3 Sep 2025 11:45:59 +0530
Message-ID: <20250903061606.4139957-8-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
References: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|DM6PR12MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa50d06-f270-4569-f0c7-08ddeab19c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g1D8M70e0aMhYdBeTfoM/ZmcbKOAo7rfKW4tAR1PE2uzAYYKS/8BGqkA8sY8?=
 =?us-ascii?Q?jh4Ym7m22HOpielcYWT00ST0ujGCVNTXlBAUwklhPgPz0/OoWjw2+qvSaYiI?=
 =?us-ascii?Q?NEvZAZrNau+EMOgq96l8w/L+zFkrcFDwfR2XxW+J/wgucqKbRUhfTF2j/G0e?=
 =?us-ascii?Q?vOTKxNohxPNkIn6gGuerLss19MyT2vJxemm0XYPQajWMevUELm2q9qIihkq2?=
 =?us-ascii?Q?cBecUiLlQW7Wyq5OsDTbHnpdF0/otOYNdvocMOvjr3jjD8GjFtuuwFHGgpwN?=
 =?us-ascii?Q?bSnOYLdpQeI9CW/1mQ2bNUiONWW8m+vc1ZblegEk+9hj/DoY/EKmErlF7Xph?=
 =?us-ascii?Q?WUuYcA47RZDZDwZnaEYkV80QiOiqcigQapod0V3U5u5qIv7UY0zfINL5doar?=
 =?us-ascii?Q?a+pewRHySHiJ/uyzBGHV7AlPSHMDI/VmXv74oEnygGRhf24TflHKqV7RCSPI?=
 =?us-ascii?Q?fpQU3AIrNgoX/qMtlIJyTMs7bu7pATUFLve9eKEY9W6igQHISE9ORDMDEsJv?=
 =?us-ascii?Q?0Qo9FVGpWz6Yzn+oC9FvhIfHsaJaJcGWqz0H86tZ52vXIm9vQ3o+v8HajZru?=
 =?us-ascii?Q?pI2PZBTZh7CxvYpNn1UnjrwVeLdXfso494LrxTF6IV+bO2euQXMid8Z8ZOWz?=
 =?us-ascii?Q?q9TvKgMDBKcbLSwiP4nc38TGaE3ZaOxNrdpaPtfxF06VKnDB/Sr1vlH9NGKY?=
 =?us-ascii?Q?r3Egfre3cIyxmeyWqGrplWquzlV4p4cLZti4piivVNhss2wGO0QYc3hvbkyc?=
 =?us-ascii?Q?EMXJlqv/Kbv6EpOeN2ZREOetH1jMBW+ZumnIz8zpQCNKRffp8cRJVTVM8IKE?=
 =?us-ascii?Q?ULDBHyLCLDcqFYrNsg2GsIo+e98oPaMIVZlzRqF9FnqP0PMAIH6EoNhnFqmB?=
 =?us-ascii?Q?0yNUT3x5WYTlVYbR5ipEfr8GlMA/Vyf1AKh5+XpiuSxOCg80knFoiVUmvkH/?=
 =?us-ascii?Q?TszDqWnVR3YCjOd5Jbgc637A5bmM3ZPSWjXWiCab+eu+ThM807SeOXCQxFdf?=
 =?us-ascii?Q?amMiSuilL6P65hwSA6DY0L4uoVvde+K0DMw8YxrylWRHgBQKrHBecsHLV4ya?=
 =?us-ascii?Q?capVUz6TRGi/4ocGKqLrr+wY76ymxQBzuZTZrpn3prLOgN61FIQh1jIQI7RR?=
 =?us-ascii?Q?d0TJkk9x7qZKQ6CF5ZPhyBNm83G8vB7hk9h/WqNnjZ8eU9QE0w5RrF9JPYaN?=
 =?us-ascii?Q?QwAtc4LzdazQrvOxTZKo3GW2/hmYh1daDLMNNM6qJ6hTt0qPe+eCwxGzTlgM?=
 =?us-ascii?Q?LoPx5c0z0J776Tki7vCoUIm0YgCy5oe1JFJUn0M1qvjp4wOHm9T6vcsgWHQV?=
 =?us-ascii?Q?xNnhMsvTrlrnPPbYdZMq48W5ZFbff3PmM3QrfDvbSIZ0kY6uSivtZ0EZWIkA?=
 =?us-ascii?Q?dlUVCWmHqx7832owe4HCYmRhDvloIvgAhjMSOB5aK2d7KFq1NfdRku2uwc22?=
 =?us-ascii?Q?FRdC6yCjhuoqdsR45h0S084pp4lI5b8vYLJmJgDiwfZLiQ+ZSWz5WXxr+wVm?=
 =?us-ascii?Q?24hwEzUYTENQ3CZx0y9NWJ2N1pBjU5xop4XL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 06:17:50.8526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa50d06-f270-4569-f0c7-08ddeab19c53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154

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


