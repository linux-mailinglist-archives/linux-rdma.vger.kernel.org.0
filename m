Return-Path: <linux-rdma+bounces-12436-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4A4B0F931
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 19:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128331770F6
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A92238C07;
	Wed, 23 Jul 2025 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="18txZHeJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FCC223707;
	Wed, 23 Jul 2025 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291963; cv=fail; b=VtLmf7Ua++bxjs4oJPtbl6E7iK9tj93rp35Q6CBYiQQe2VNwgQNIdbc9g+hRQcuIbugQUQ1Q9QyxFstbFQqpMFO16j9xLsX/rJUWpE5ML61SwyTSYh2ewxq20YYotBChFfWhN4TpGMlaSCkyRSpFycRUE1glyiXrNi5W5lN9+1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291963; c=relaxed/simple;
	bh=NfROQPYeGxHoicQQxDjEDs5h42zqtaKn9+xjzZTPuQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQ73w5a33RzU9Tme3wQSoX8URbwuY/zftfE/T1gNbdTObNgaCLJf8HYsmLsUMFPSnraxUaAPLJEA+NKMvXga+IkNVrJ5gkKik8KH/2KTpOE6uxAZ5vJ6W6z4SCd8AbLrdIKpRtxA4TfneM5yz2PnEpT89YEnSa3p4wC/LuQXfsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=18txZHeJ; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFPJK+nEI8//XDbskeT1OmzbPnTJWjg2IKi8f8HDIQ68C9O20oYgdWNFgWZLf6Zi0c4HLHvEkxTnwVC23khTxi83N9wdjrwtyU53jOhISXISfNueVcd8oYsmteeOpyizWm0tHWgWrLhoKuG6ax0GYVoNnOFsdH4UGlIUvnYhe/qX70h7oErTimQCZkvcbLHEaE1iO4SJ9HAbD6mvCoMrGahzjUKxvQIQszKOyXpUW2zCSEr5t32BYfF2uv1DyvFuLjqxhFe3IXfYcnbkSNgOfBgc6MJf5AmpZbv9naneiXx6H9s8J7vOIoyvXg3+tp/2DBsxA8KIk5seDuDAQWWLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpRkPx+dQVGxL2AILTyXPMS7gdxA9IxJorx8b13lVVE=;
 b=aN38iyS4b3y6IgO9BbKK/0oei9tM6i0v6uYGaAuiprjsFh2fN8auoFjTZvdmCbgD8wqSxUqcuByeGAWCaYR3YpZkxh7Ku4ZV+fe4+xZFGzsWNMBRJGkHdeE9/rYwNZDJu3aIB35cdKPWJcswgJLTDWnfgg9/duN6kq1vW5QLFFfRdqfo0iDEpq2lMHc+eDRzV7HB6oI22iNJeGziInp7T74+jEGP5Ox46IymAC6bXnZ5ztluYvuUsWjelOYJRw+kh1Z7hkZYmaZmg2J8n5xntrl+8gf82c0fRfgsxFWo56zYcqum8nNdsKj7T/GEuumHNl5g5Yfyy5axJVR5NRAXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpRkPx+dQVGxL2AILTyXPMS7gdxA9IxJorx8b13lVVE=;
 b=18txZHeJWpxlI6R3tbElfAdhoGbUiQ09tncduAM16+gwxcHZph6o6FLl7xWYz0+Eo9UoGWoUV7mAu37M7a7biS74FQ8MivZLLb449anBM3cLbM2siPTtfpGNy64MseVNou170MdQEZF6H8x93U53a3XqOwgqXBh6bHwJMpKKkYI=
Received: from PH7P220CA0106.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::7)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 17:32:37 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::93) by PH7P220CA0106.outlook.office365.com
 (2603:10b6:510:32d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.30 via Frontend Transport; Wed,
 23 Jul 2025 17:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 17:32:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:31 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 23 Jul 2025 12:32:27 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v4 07/14] RDMA: Add IONIC to rdma_driver_id definition
Date: Wed, 23 Jul 2025 23:01:42 +0530
Message-ID: <20250723173149.2568776-8-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 309b843e-75db-49c5-5f00-08ddca0eea2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?omAH5NdZegeHg63tgRBSWxBgnL6/AmFYJVDeSEW1VDYNaAEl27UqEWYDMJY1?=
 =?us-ascii?Q?LhcTfERXRwtfY/6O/l8u3fLxsNQIhMNWyBKqnH/W04u0GDbBnhjr+Eapl8eR?=
 =?us-ascii?Q?eYYIH75h4q9MmYE0zG0G5F5OYCYJkvEGSBpiWvfuNfXpQFXt72Vsn5bpDchr?=
 =?us-ascii?Q?cqAhNollQ2gkcF/+69cJNWcsjOGWi+kAg3a8ag2ZJn3iUtxPDBklWgZW+J1e?=
 =?us-ascii?Q?iG2N+oGfS7Uebe6naNR5t/4nvUirvMFME0w01KIksfkJjFG+ugwAYqJuVxBA?=
 =?us-ascii?Q?9PLbU3fYST4wJHeb7RpbLzZrFkbJtFdwMNnGX1qzZvOgVBO/BDSwgyU6bgpv?=
 =?us-ascii?Q?Z+ws77Eolr5LZ7l3vH2luWyd0XJp8PfiRiuB+rnUJ8m8H0T85GDOjfc3aYWa?=
 =?us-ascii?Q?/p4hckgvyrAxCHJbyXcdIlbSzFPtwM3oLX3JeHfWfy0ffcRFuZR0FbHsD/pQ?=
 =?us-ascii?Q?+GY1cQ+ov/lazILRQTgHTZy8LBLgDSQ1Av7Z9m3cb5CQPVAYVp03prYU+msM?=
 =?us-ascii?Q?evVzBN2Hfh7YmmfI6//jFWUyMzZDI+yEYUi0yIr+raY8mwP4KqcUlhhHZj23?=
 =?us-ascii?Q?mGqaP/FaJKz7xzParLmzE0JeBFjJKkmbj/qqjFc2wGO+GUT+F9QOfJM8X5TW?=
 =?us-ascii?Q?vpv1xJWFzAu3Lbm8Y6ZU7eXOfSNATjfkwDpYb/m3HmpfV3Th/1mp9jtgqhjW?=
 =?us-ascii?Q?boJ3T9iKn+tlWG7LCAisYF5WIe1DJqkHH9OcB06CoeI3XVXp8tDwiDD2IHxY?=
 =?us-ascii?Q?VDcGl2zEldcNTX7DPhhPFHuFdx829w96rcYEAne31VP9SCsks9F11PehguoG?=
 =?us-ascii?Q?Sm+CNuqhXNbHIuNQv5vtDVBq1DvxAXDFJ0vouKf4k8B31VBMNl2u0PnNGl+W?=
 =?us-ascii?Q?xsG3Vipon1ZDVVwwSTPZZpahInN2thrNsBydhRLU9fJ4ci3THhWR/0peeLI1?=
 =?us-ascii?Q?Q02pwpU4voPm7QNHbH0Knks+cjZzpuGMkwCEyplSAT8uCOTO+XMl/t/5xa05?=
 =?us-ascii?Q?vcnAWBEoChAWiX3YWKi4WmwxkKg+7+6d1T8uXcxv2uRsjsYhMIDAIS5XQjRY?=
 =?us-ascii?Q?1+PZbZ1gObVf7Ztw/xAUiUyBag0Y7eenFsTYy3LZOHqXJH0z4AD1RDSRDtyn?=
 =?us-ascii?Q?+sNOs/TkZrXVzXKMbIITISxYWbHOftjDUb3E+5BN5Yc/USeUl1umGlubfAyc?=
 =?us-ascii?Q?ia2y6YPFZOJ3qkm90IHsaTFcStEagM0JGzgu7Eqp6RSz+LIi2Y3xd+oEXgRH?=
 =?us-ascii?Q?e9VQzAoVUrR01NrAZAhYLBahrMU3lWKahXMyCkVgMe0sfMGsYuO0o+CX1wyD?=
 =?us-ascii?Q?LCmKiv+O9iVKklk0ADtnIrql2nLqtJRzZRvWl1eyrUH9SeG8uHWhktEM6t+m?=
 =?us-ascii?Q?VOsc4cxqmRkeaB4jD4hIX9O6Lc0tl2YSpRNyuh/8t9pd6H1rp0UX9rJqcSqL?=
 =?us-ascii?Q?xNmTxYdBKs2BdAAeUpp97nQH1zSlfs8R5tgRUYnRw0SW4S5hgoDp0eV+6hsg?=
 =?us-ascii?Q?DGR/KyTFi4kThQI+VgTnbX2trCwO5hwRZx35kWB3scw1zIKO6XZIsVsKSQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:32:36.2661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 309b843e-75db-49c5-5f00-08ddca0eea2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261

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


