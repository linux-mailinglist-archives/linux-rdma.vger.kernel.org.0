Return-Path: <linux-rdma+bounces-4446-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2009593E4
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 07:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499EFB2267B
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 05:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D781607BB;
	Wed, 21 Aug 2024 05:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jGYTX5S1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6C414B978
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217056; cv=fail; b=cw/6g+wxhLefl8590Q5ZjeMpJEEddtrEKsI/lARrHAUEaiNNEizws1JNhRy6+0h5M5mV2Eh4qyffKXqz1PcbweP1rGR8zfYjVsEdbdALx/k0zifruMEGcQTq2/ofZ2oE3YeTk8St3B23ShBoXry/Vb7FK1QDoKe6bdS3HhfJRzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217056; c=relaxed/simple;
	bh=3EonbINpHw2XGDVE+TI5/ERA3RnSH3/FbcxSU3hiL2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLzMiIfO1SPrzJpSciqsA3BgrDJeEYCykXkXZmH7X58Zl/nN968YTFpW01vCFMEF8aj4DSdAivoqnpf4WSjq9NmHIqSf6SpauukuhkYVQTAWpa4f0ajnWfpsa90A/iuEqLTgWKN+rT7VSbGMeWxZn2YbyjK1w/inn9OqytOzy1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jGYTX5S1; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqizZJSHCp4fQQSY28R7nt77WA5cYowCTxK9ecMAsF2GPFBJx+lwzaVnmpMd4CjGOgrllsm6/Qll1ulSIBp/bakx6rXrjAxgkHWI0vbtnKrBv6KHRhdsZj8pn7tNegKrjAA7oAq3kKnfQSqpZHOtJeb/0I9MpmJ31erhYAqNn4ivZ+HP2FLO+Ruhgj27xmStf5aLJsCzmLXFAZC/fDDjZo8Prn2U5bWu3kfBfxQUQfk+z7b5C5IW3nVVdy3SDRKZdwmKtfx1TmxrhYSK8TtyFOBrBS4uubLFXJNLMxwcJpQjDd+cmIKw0qxz1xkESqvJrUiMTJzgHnDYiGZibWd9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxxWRhW6Lp/65L8b8OkeuZm1fxOpeKuu2U7x2wYvwuo=;
 b=v3Y8JhxkC5r2NWUeim25VerrsJM4SnxasIwssWFcvsBIBcwDE+4yBsAUdBFi3i979dADyeQ88Lne1RvAj6D2qxOKVsseU1od0u1Jh874mzVDVmKSqkXziCcF2gokicGc/oizGBX6BxNT33rMFSELjdztWZ2Cp2AAlzEtR7diGnR8TznuqjMIlQ7Qa77sYrnv/3lDH4SM4VjxnNlK5yLNuxV/A4uG0ahbsPeYvd0qtD2ZJdqvkyQZEB2VqSoOVfurH5/o0Tr/koVCHw2S29/l5CY3ZYhL/E5eji191+ftwTISGQJWkGWKxAFYe5XCSDVkuPbzJUR0PPFE1TKh+BmMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxxWRhW6Lp/65L8b8OkeuZm1fxOpeKuu2U7x2wYvwuo=;
 b=jGYTX5S1aC+0fQfdV3utTphJYE+0rIeprnIz05fqujzRVuPCXkdugBUrViN9dJC7oasEvsu2WDkRl4dyKIy/F+eh3nWRd7vog/eHZciLb7VE5JYk+1Rgf4t2WGEhfnOYVlBajS0L77JV+nsLwARImr7cowNmGkTj5OZfzf3QFb/mjhMAITrRLdU8YzQVhmtMj2XGwVgQ1Isy2xlTo2Z142+HcWjue1LpJwETUNFOxG7mKMc7wP6QH+fuk+vBc+xF7Fz9zam41RiVn1basU3pp6ywpJDFMjl/4/k4bV6KejdZ8MsnO0oJGIinfhHIvyps7FukqGK7tlzWXNFXk2uFdg==
Received: from PH7PR10CA0016.namprd10.prod.outlook.com (2603:10b6:510:23d::8)
 by LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 05:10:49 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::64) by PH7PR10CA0016.outlook.office365.com
 (2603:10b6:510:23d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Wed, 21 Aug 2024 05:10:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 05:10:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 22:10:34 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 22:10:34 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 20 Aug
 2024 22:10:32 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [PATCH rdma-next 4/7] RDMA/device: Clear netdev mapping in ib_device_get_netdev on unregistration
Date: Wed, 21 Aug 2024 08:10:14 +0300
Message-ID: <20240821051017.7730-5-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240821051017.7730-1-michaelgur@nvidia.com>
References: <20240821051017.7730-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|LV3PR12MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 6510d2c7-320e-4d2f-9c4a-08dcc19f9ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iSVUUpkPg7jm4o1riUX8vX28qCMvjwDhdvo99QDc+xXTJEeGYMp3muANKSiQ?=
 =?us-ascii?Q?8ZndwmiERDc+dsHr/GMijv4GX0wVyMXk34ySDLVLct6EP9UFbBtDDo9mBtbu?=
 =?us-ascii?Q?YASW48AbBPMPgtzilYoT6OTJ39kn4mxea8f5i7rEOtbqYDBBX97kkctBDn/4?=
 =?us-ascii?Q?EUSWvNivw+AGcQ1i8H+U5w8lWxKOeQNbapSh3rJt+RJf0wFnMqojwBqmEPYS?=
 =?us-ascii?Q?o57mWpw+9+YcQRQwujOE7f8QZFUisggu9zai7RzWTrtMaEQC6Wei+4T7oojb?=
 =?us-ascii?Q?0nJHxEbrRSKIcf1fQSihjNrTbILNRLrLXaK1CiskX30sFAh0mp8l53qZ0i5h?=
 =?us-ascii?Q?29LNGVyJeY6Qdp3nyuwzSchI4MRivp2kpyxdCyEeJV+rfTDIlrSHC+Ufc/av?=
 =?us-ascii?Q?Fn4tDauJ6mI2w4ILy3xTZSZp2zoqDY5botpg63hCM3a9RAzKzO3tBISTSzE7?=
 =?us-ascii?Q?3HQg6J9p2BXNF02qwyj7V+pFWMBysQLEHhe8BTXULdhqXXW6F5Y0kN4U3P9p?=
 =?us-ascii?Q?Ip/wtw3l+rnGo32iyFODZn5yLJcHUgbiitr7/5ip+3qvrKZTubilbo14nOJz?=
 =?us-ascii?Q?QFP6/XYcEv0/V7eTPUoYsw2mgw0tBrMknW6EJoCh5MxWIIXm4q4W3sGOlaL5?=
 =?us-ascii?Q?B2UeL9Zhg/z1XUMHi/IKL7tnujOiFe2JMEaQwGSuQ9suE+iEVYAMN9gl0hFe?=
 =?us-ascii?Q?NlKxBIs9x87ckU7jvpgV+IwcVO8rCwK+W/cqt8yFh3gqquDuznaRwLB0QKSx?=
 =?us-ascii?Q?nmOKVGgV5Gx4xX3DDM/vOX2fPHIx2zvcUa0r/cBYBrYP9F1woc+dBmixqYPw?=
 =?us-ascii?Q?maAMRDb5R/AfNgO/2UfZq5d4pyGp2URBX0No/GL5qUrGHL1PlBEBo8icdOai?=
 =?us-ascii?Q?+myuCXJbxwpRGgMKpmpvBhaV2QM9ygFKoAgn3OwXgGlHndHfAcP4tAAywaOu?=
 =?us-ascii?Q?V+0NBGqnB0vDTYDE3kjA2mYFScZsF7hn8yT9x1ykkW99A1pUOt4kV1xnTFPf?=
 =?us-ascii?Q?/SOyhW5evm2rG+a9Rt2rG8ljdPlkW2RFZWAxh6JqtN0QrSrJXhIFY+BexPfP?=
 =?us-ascii?Q?CUFskNUkO6l+PS4ejJiDgxnCZpSLmVcUuPul6FhxckQ3x+d1/3k7I5JrjHb7?=
 =?us-ascii?Q?SgZcrQk8hdS2tdSa4t0kjruULMoKVHSp3yaHKTXHaX9kkXNLC5t4RmUqlQcQ?=
 =?us-ascii?Q?Woxa2LiiGNJ7nySML7VdsvuQAFprZA7/KoXf3rOBeJfI0xF3vsu8MdPy/uTN?=
 =?us-ascii?Q?NMx0J3uAszbPyXM2uKaRDHeHMPMtkYSyXY5mjwKlYo1NJC7i0itkUGdWOUaT?=
 =?us-ascii?Q?Lxkq5/nPTW/Q9YWDNiVP7bcqbQM4UTDV4KB1P7gNpiJE8PN0zJf71+z8fM+u?=
 =?us-ascii?Q?9obA+DzmsTxk7ZrTL4Un9PJ4ctP3fLvcz3upJyIxT8DZWZNBuTrjXcvxBe6h?=
 =?us-ascii?Q?//LIV8mQVzznSw+60bQxwFX4pA7IFa2m?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 05:10:48.8482
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6510d2c7-320e-4d2f-9c4a-08dcc19f9ee5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118

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
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
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


