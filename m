Return-Path: <linux-rdma+bounces-4662-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A119658A4
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 09:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC20F1F26283
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A796816BE02;
	Fri, 30 Aug 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gp3H4cmu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8238168487
	for <linux-rdma@vger.kernel.org>; Fri, 30 Aug 2024 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003125; cv=fail; b=thVp40d2UpIZix+mA1+MeeLKelV4cBlY7lKNJMDapgBFbYz0dJ88nQFhNiJizqg9Jl6/qqs37hkG6tTYkHMa58r9aMiTT7t62u5zgpySt7pbdtiwUUzsijK10WEFssqvY0mUr3LFelyqN7oMGao3ZuWxf0f7EYW7OlVjfGIOrC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003125; c=relaxed/simple;
	bh=CnbQObHDd2dIFDF2Hs4buSYxYvltOmZzBzyMSFSd6YA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJ4ecUyuU8e9c4G6ttaYR9A0nzc5HR9BFbLuH6AjskXAiq0UjsI2tUhnXgBfw803INsfZ/yBSfEKCDgecRrC4wwYTalQf8zWsfA50XD78kjGoJUs+LdhoqMESLseer7WorbWRvhysEqZxXwZ57WXpVSgYg+adjuNxHe3YY7/ftk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gp3H4cmu; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uvohk/EJCVrZlWg3AOxbJRoqN3MB87xUKaCD1bbT03s5tfBudOzEW8pqkoIVjTb6h9b/dLpDR7k3nCK5j1f1FIwiD7P1tFjGWF4BCMOtcvQfJuvA19pmCOEbJL/FXjT+80QsWVvJtsZSMJvAv9zeIRXn3vHT9sb03eIUIfZN9tFwhTm7AABHqdzNIX6g1sJT/qbX8MQ7XvtjhLNr07oSpZWFdRoerhhMXfyDcCyXZGwpZZ3QMOjgH5oTvDruIKOWL9lUo1qoybiNxs7EhPAau8IHlZhwgketVCHtIttBwICxjz4noUmQDXzcwIX/OuH91Yl+lEWPEtqwqVozl9n65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBEcTykqEySuYHFc8FP+1MW7lCTwuoKKyg0UEtAYMgI=;
 b=mDL9V9mE8DTEvCdmP3s5WaY914GQJiJ11MHuA7zYCO1mhTAapBvzDCzzV2hc4Lz/d7BYCUQf3bMkcOPfNBmiacgwk9z3J6OMGcxysiDMJBnAVUsSMepd/cY+mQIg4U04YT/xygYaVl65N/AkoY+01dJ0l0wY93GIIU8mo9IHhBfu/sXGTADEQxVf3Li5RmrLRN/6JiGgFPVLvfbOhgnVuS1hb14vSnPmNjbM7t11ddtqtNTOrRTG7PsWjlTcHrJ1AhPUu8FqxFFaW+h0g4CVGZka2GxkFrCh9o13HJNaQKW4NjpIcMCyL5oeuOpt5o6MycfRA/VzspOZIiuZj0yvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBEcTykqEySuYHFc8FP+1MW7lCTwuoKKyg0UEtAYMgI=;
 b=gp3H4cmu3Z64q6xswbDhxG44MW08B2el/nAgGVfzSdENdJi4VdBDd59Svo3LuBh8qWf1E1kyHeZ+iOV/m7Bej3C5GG6Ia6d3QxDTXfBV0frDPowrGWBjvwsT6Pyg7q9BGdsFABkei5piwY3MvGyJewSns+riLBhxz+lttwjMybcp34ZYlv6CkbqHMlu/FSx3tI7eBiPmDyYtBeH8u+0ManhMWOZVqe1N0XD0ucmXqRtEPCGkAPH5H3A4hzWIDTh8NAGESfBvrQS+xYkVBPR4vBcW6/b/FrCxUPFDt/70joU+ZDYP8RMdaoG9KyGrSFxZO2ZY4mG7kcSbNNbmxWe4Hw==
Received: from MW4PR03CA0196.namprd03.prod.outlook.com (2603:10b6:303:b8::21)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 07:31:57 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::34) by MW4PR03CA0196.outlook.office365.com
 (2603:10b6:303:b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Fri, 30 Aug 2024 07:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.2 via Frontend Transport; Fri, 30 Aug 2024 07:31:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:44 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 30 Aug
 2024 00:31:42 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [PATCH rdma-next v2 4/7] RDMA/device: Clear netdev mapping in ib_device_get_netdev on unregistration
Date: Fri, 30 Aug 2024 10:31:27 +0300
Message-ID: <20240830073130.29982-5-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240830073130.29982-1-michaelgur@nvidia.com>
References: <20240830073130.29982-1-michaelgur@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 031aa2fa-38d1-47c4-b620-08dcc8c5d3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hT0Hd8wFUttIsjnDOn5epxcDy5Olo1sXNGouoGrPWcVIMPO+HVjQjKoo/+j6?=
 =?us-ascii?Q?7jpUTiV23bcn2VKA2wBzou9BjZrlADmcJq43D0l6M2Hrb9cxTTU3JPAPE0EJ?=
 =?us-ascii?Q?ftZbh+I+Ilg5uq+r8AKFT5lUtAT8hegCsO4fYv8NuTbvGTU+4KodCf8xmk/M?=
 =?us-ascii?Q?a/IWijKXtX+0duO7WBceFAwQBtfeT0iqz7IvbgRSAis7t9+zNH5X44x+48F+?=
 =?us-ascii?Q?+o7wR1hHKPge3Za1y64lmDLdBct1EwyHQkZFYPp/WzT88hZfZ0ET6329lvgp?=
 =?us-ascii?Q?ugnC8I2f90ymlz4cd54CVXCFiTzRgXCLYOZ5b/Byi6yA6lqtrNPs3tj2yhxD?=
 =?us-ascii?Q?mwn1uVm23Dams5V7N2Lx2yW6k1Yc6dpBqhGU/kHEWx5vy4Hij1zRNYDchGLp?=
 =?us-ascii?Q?ZqWDYO+dEjmUJXWVUKtWTYMwsbJh39U7qvOgmZS4R0wOCDIEEgnEiDsAQMQ5?=
 =?us-ascii?Q?hi3bjxRwYEK2oAPVy+O313hngyD1/s55+MG0yMAtmNXAC/jn34vskz3/ht5A?=
 =?us-ascii?Q?kQ4v9JQSBpq07MMylqBfwZl24r9A2CKzMwFzkAGCABDusu3tkgkWnbfiEB/I?=
 =?us-ascii?Q?KNjMqp/Olgynn/wYpG+53eHcqg9yp0LKUBU9H4uGTtHegQa5kejWRpeObQfz?=
 =?us-ascii?Q?CJGqywUuefsX2f6rT56Ra8nvberQDOPsIP0RXtr3yRcD++SzAPjHO5hu/uNU?=
 =?us-ascii?Q?SGIpAe45wZRHTX91AW5YpoMuKPH4WNoU3jLmXFVL4YyBT9ruNCg0RhPkr/ZI?=
 =?us-ascii?Q?Z19dRx0BsHBdIGMlPKLpYWhvtz5Lw/uFpTYdJFXie1iexNPlsOvOb3ugJ73b?=
 =?us-ascii?Q?0ol6X63QSVGKGq0Rrg3ab89A2Qt298NDUYNEofUnQMiJqxPgh5gFk44NDA7j?=
 =?us-ascii?Q?oC1H/4MJf3pHcIDfR+Wk67KjU3UQUvhT2n1ED4URvgdIUeQw7CMWqie518W+?=
 =?us-ascii?Q?Gx+XhoNPYpDettQysA/FQyyKubOKMaGR8rm5euBYGQsCAiVNuQqw+KguArxq?=
 =?us-ascii?Q?JJsiL4TUFCE5KVYHme4bJc9a9VRrcbD0K8vKiKn/ZgNJV6O825a6Aliju1Y1?=
 =?us-ascii?Q?UBYxRqkUU86Zn2W2lfuNs3AraAfc1o8yp+TFt93JEagDtZs//vCewXkPUsQ9?=
 =?us-ascii?Q?/VU20e/DXanxIn1EPTzdKdZ7JEQ5mZFSIWwHANKMjRebeIQqyrCIXfu/Yps9?=
 =?us-ascii?Q?iMpTGT3P8kwBj76qLNLv8+paq3//yaEVeC35nUS18KHoXxqNFD8CvWVpvwLI?=
 =?us-ascii?Q?1+JUK4bTBTEFscZnGUQ8F1/XaPo6J9wE6idJM8i8KW4riQS+hxCaiz2+4wPw?=
 =?us-ascii?Q?xwwnAEAiMi7CeFmIHs3+IMRqkoS49QBMnNxFWOu29TOZbF/BBwgTGgz9skUf?=
 =?us-ascii?Q?QNvM4Ew4KnDjIU/sSuepG08CxxXG22bOjMQeEHAW2XmrXOZP22xzYPVv9NYU?=
 =?us-ascii?Q?3tyUdk4WLyWZ8Cw55Lpq+WvzLnXCa3HR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 07:31:56.7399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 031aa2fa-38d1-47c4-b620-08dcc8c5d3dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863

From: Maher Sanalla <msanalla@nvidia.com>

The caller of ib_device_get_netdev() relies on its result to accurately
match a given netdev with the ib device associated netdev.

ib_device_get_netdev returns NULL when the IB device associated netdev
is unregistering, preventing the caller of matching netdevs properly.

Thus, revise ib_device_get_netdev to assign NULL to netdev when the netdev
is undergoing unregistration, allowing matching by the caller.

This change ensures proper netdev matching and reference count handling
by the caller of ib_device_get_netdev/ib_device_set_netdev API.

Fixes: c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an alternative to get_netdev"
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/infiniband/core/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 0290aca18d26..583047457de2 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2257,6 +2257,7 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 	 * propagation of an unregistering netdev.
 	 */
 	if (res && res->reg_state != NETREG_REGISTERED) {
+		ib_device_set_netdev(ib_dev, NULL, port);
 		dev_put(res);
 		return NULL;
 	}
-- 
2.17.2


