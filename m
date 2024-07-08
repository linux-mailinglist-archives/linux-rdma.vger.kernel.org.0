Return-Path: <linux-rdma+bounces-3723-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C45092A1D4
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171962872DC
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784E823C8;
	Mon,  8 Jul 2024 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KuTpTviA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1259280BF0;
	Mon,  8 Jul 2024 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440110; cv=fail; b=ELuhbpi+7ESW/6YTUfIYoOiGArvLiLnk2dwdjpyAl7fDVinBsa3nGXEO48WjeMQ1L8IO7BnPEZnCzzv0VVZLiH6TDlOiZe1Ij8xpn7Qo6KzqmvQKRU/Gt1z8gJSnhxd00fWkvJOlnrE4E/tP41dRcXpxTy4y1EQ1No1YXgPhVTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440110; c=relaxed/simple;
	bh=DHrXSEe+RknvJt1MkdZLHqGjn7NQF9NlApBfwGP6yGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tD/5jHHCSFSyZ3mywhUrD8ftxlyS2kS4xZWSG77meuHoMLBqfhxUCvDrYgOehMBk76oQqQ+RI6o9eVX0sMTg30gu72dJ1zDfGuG2VfXVIOcI8kbcOlba46m/CXVCcJGfqb85SAu5IHTBz5MXRAXtJiIFZvTV99pW1wtcBjE1mmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KuTpTviA; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA8m2i94hPo7gzcR/a8U8cpTw256QSiN2d0XrO5g8BCMiwjeo/N3C8Yqwt9HaDJBm8VmrDSqGtv9C7ClMjacME79YiPcIv5MCL8gPfll5rhjyrbKQ0g5nXtrBHMVDHFRMGcP/HZSYC8gKiITT6NFx/0x6H/w3zL5EuED6sfnsjx8PM+sYzjVHnYoYJ3XXM92ODj5OJtPoEqU9G0zQPK6nUDVP7tQCN4BL2Qgib439T4mGfUSBOOCOMX6OPZ2qkiFo4hpYEs26XSjkowN7Mj88i27dKPJAdlgKfTUIONZJmT18426LZ/Xfk1vDPCdWkNORHqFK87gXE0XbJ3QXwlF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2z72/tMu8L9qHHmtikas5vtPUfaEPquPR1NHlmrecis=;
 b=OnaW0dsDl5g4GohV3UzNYSn9EX8k1r9VzqGR3G2QtWj0Sf9hXondq+3STsCWU4pfkZKNzNwjpCLw3aZ5n23eQLNkgpwnaeaU6CTiFIeSMv9veavVe80h/ZeaRYfnP9XxJQe+oDSelcK+fb/b37NkqozcHYHoXXMCM1K0d798J7/y3jzfYl/MyIF1SVZLZsDfxubs8h2svV5F9wfbZUK6bBvNdTs054h3p1BiYtbtOvtRQ9yFRjochas7/YjozD7CEyIJKtEGGD9PnicX46+3RTg8PXg48W+emoTxqdd70L2EdXpcdSWVVRdO6spSXwRNjKIgoFpczz6aDwn1cN7ffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2z72/tMu8L9qHHmtikas5vtPUfaEPquPR1NHlmrecis=;
 b=KuTpTviAgcbRPt4PNmDmaXqGTMdszXI/ZCBmMXvU2lkrBRqHqVltU/V1W+tJGkiorIZP5/p20NItlUDbv1vbkPMtO85CoH1liF3Gy6OJTdYRSl2B6A4lloN8kAXmcew9fIhVMFsfBC5tR8I3QzY7KdriJzZaNR5sCHOKsMwdTltlHHM0xLgX9xBL33y9UgIeWLAx3K3ROB8HxdF7T0ENdUnPE+n3A6a/9t8xmGz9lKvoVVqMyLabIY9JPc7pDqlA3U1U4QHaFiGAgpf0GqZWlhLc4YATr/Dz/SpEvCplebjoP3jbzpXNF6DFQLXCt9oN9//kEWlm118KgYF387ib5Q==
Received: from BL1PR13CA0372.namprd13.prod.outlook.com (2603:10b6:208:2c0::17)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 8 Jul
 2024 12:01:44 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::75) by BL1PR13CA0372.outlook.office365.com
 (2603:10b6:208:2c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18 via Frontend
 Transport; Mon, 8 Jul 2024 12:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:01:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:20 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:19 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:16 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:29 +0300
Subject: [PATCH vhost v3 05/24] vdpa/mlx5: Iterate over active VQs during
 suspend/resume
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-5-afe3c766e393@nvidia.com>
References: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
In-Reply-To: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu
	<si-wei.liu@oracle.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
X-Mailer: b4 0.13.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: f72a974b-5df0-4326-6a19-08dc9f45bbed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWY3Yk1EMjlwTG5USnFCWkZDZVdWSnBhR0lHcWM0WHRLSnZLTkZlaHQ3YS9n?=
 =?utf-8?B?b1pJa2pwMnRvSkhMWXJ0VTlVZE5icGFWekdWK1BTaFNVbUdFd3AyOWtlYVh2?=
 =?utf-8?B?a1NjVUdFaDdGYUFFd04rRGJiWmNJOWc0My9LV1EwVUdqa0JPVDFaS3lkaXVI?=
 =?utf-8?B?aTZMMDhmRFh6K2FjZkJMOUlWOTduUGNpeXpPcU9mc3lueWxkNTJYMGlsOWJq?=
 =?utf-8?B?a1htR09lQURlU1lPdGtBNEtOcVdBWjdqU3ZvdXBoRzhtd1hjVFFzeGtVSUxG?=
 =?utf-8?B?NWVqNHJXTmdqZmVRSnhnYUkwZ3dob3JvMVd4MWFaVXBEaEVwNjhVa1lmblZ4?=
 =?utf-8?B?Rmc1b0dmc2tGWmZzWlNGd2pYaHZHT21CZ1RZVGZhUDYxZUR5TWFvNXlsbm44?=
 =?utf-8?B?bDJ5S01YYU9vR240aTJFZWYrTG8wK0RjbENFZXJRUVREbXBXNHNzZXY3SStK?=
 =?utf-8?B?RHRzUXA0R082YVMwTHN6ai9pQURxNllEMlBYUUN3RlhlaDFlTU9EMjg0dVJP?=
 =?utf-8?B?S3paL0IxTEUybmtmY0xDNXhpTUtsVkVYM2pOUGNTU0QzVEVDSlFvNDF2OXNW?=
 =?utf-8?B?TDlqc0MrekRNTDdsUUhGazJaR1F5OTFVVC8wUTY4Vm9nRUpubmtGRkIrYmxQ?=
 =?utf-8?B?ZVYxQXNtaXQyRlFNUXlVSUVPT0xnUHRrVmRQNlZjc2dnZmVtaVBJb2UrbGJ4?=
 =?utf-8?B?M08xamFJWGdpc3RXTDhFUkJzUnZnZ3prRnBaa2t5WXdJWHNUaFhGb2w1TExu?=
 =?utf-8?B?ZVNTRXNpcEl2VTF2bEswbEVpWk40UTUwUDJWc2VqaDlaZTdmZ1YvWTI5YjU0?=
 =?utf-8?B?NWV1Z1BmQ1JCcTYrSnB2WDlabmk5Nis4WkJzWWVMT0FaaWFhWHV1WVdTamRX?=
 =?utf-8?B?YzFaVWcvMUt1RGl1ZTRKU1dta3lGcnZKTUowV2p0T1ZralQyZ1RxNTU4TE00?=
 =?utf-8?B?TXNkamx3OFdLd2IxZW94TzE0OHRYZDFpZXZBMHNsamV6WjBuT0VwS3NDOG1H?=
 =?utf-8?B?NGUzTEpRU1FISTlXUURvKzEyakV4alJQMjlXV3ZpM2VBMlRGNlJQZFo4Y2Zl?=
 =?utf-8?B?b3N6N1AzR3dGanY3ODhUQUZuM1R2Y3RyOGNXaG9iQkFKMXJRMVk2YlFKNkVC?=
 =?utf-8?B?cFJjWHlpR25YQnpDbjBXVzlRZjdBcDltUk9oazg4aHVmT2J3aU92ZG9ETUFt?=
 =?utf-8?B?cTNpWjUxVUZ4bi9JcWJKQWpRblFGbGNSdUJoYmNxdFZiL1prL3hFZWhPclVV?=
 =?utf-8?B?cXpnSHQ3QUpYTGNHdlk0SGtYcFY3VmZ2ejlnUmtEY211NjVOUlRsandkV3Az?=
 =?utf-8?B?K1BmRUpYOXF1bVViV3lOS04wNEJSWWw0VXgxZmtGK2t2M25SZC90Q2NTMmJF?=
 =?utf-8?B?OEJ1S2kxNVdtRjdDeEFXS2trUUtvY2NiQ3FYRmQ3dHlMenMxbkgzMksyc0hZ?=
 =?utf-8?B?eHYxOFlNaDRlM1pacHV4ZzA0YWg3QUYvMitmYVVwTzZoMHF2bmVMUStiU09C?=
 =?utf-8?B?ODh3SUlrdGExY2IzNkxndHJFTG1FT0JpaVJadk9kYjlrQmF2TDZOcXhsZ3Ux?=
 =?utf-8?B?dm5nMDRCeWlIc0hXaElKRG4wdlJaTGlzNk9rV2JJQjI0b0tLNzRBKzV3WERV?=
 =?utf-8?B?L1NjVm80cHlBbWQySldxMnRhSTFycW5CbG04cTN0OVhBZGYyRlpKWlhlWlRE?=
 =?utf-8?B?ZHdRaUttOE1qS2JMWkZTbVZBd1E0MkVNQjIzdmRlREhRWWlZUXZkdWRYV0ZL?=
 =?utf-8?B?VERPZThJVjN6MytscmNObXVZTHIyblFRbDZhdGpISEM1Z1E4dkI3Tk1POHhy?=
 =?utf-8?B?SkgrUTExcUR3cStJQ3JHQUZ5Vmx3cTh6WXh4QnYyTFBYQ0x1T2FER3B2QTgr?=
 =?utf-8?B?aE1CZ1pkSUtuS0FDb1hRS2V2SENqQVRJcTQvZFVzQzV3WWhYZzk2TmRyaGJO?=
 =?utf-8?Q?gdNkznBwfW3KkxlL8BnN368A6UkyFus+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:01:43.2351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f72a974b-5df0-4326-6a19-08dc9f45bbed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133

No need to iterate over max number of VQs.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 96782b34e2b2..51630b1935f4 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1504,7 +1504,7 @@ static void suspend_vqs(struct mlx5_vdpa_net *ndev)
 {
 	int i;
 
-	for (i = 0; i < ndev->mvdev.max_vqs; i++)
+	for (i = 0; i < ndev->cur_num_vqs; i++)
 		suspend_vq(ndev, &ndev->vqs[i]);
 }
 
@@ -1522,7 +1522,7 @@ static void resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mv
 
 static void resume_vqs(struct mlx5_vdpa_net *ndev)
 {
-	for (int i = 0; i < ndev->mvdev.max_vqs; i++)
+	for (int i = 0; i < ndev->cur_num_vqs; i++)
 		resume_vq(ndev, &ndev->vqs[i]);
 }
 

-- 
2.45.2


